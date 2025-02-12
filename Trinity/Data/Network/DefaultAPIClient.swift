//
//  DefaultAPIClient.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation

final class DefaultAPIClient: APIClient {
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        // URL 생성
        guard let url = endpoint.url(baseURL: "https://whatif.click") else {
            print("❌ [APIClient] 유효하지 않은 URL: \(endpoint)")
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        // 요청 로깅
        print("""
        🌐 [APIClient] Request:
            URL: \(url)
            Method: \(endpoint.method.rawValue)
            Headers: \(endpoint.headers.map { $0.map { "\($0.key): \($0.value)" }.joined(separator: ", ") } ?? "No Headers")
            Body: \(String(data: endpoint.body ?? Data(), encoding: .utf8) ?? "No Body")
        """)

        // 네트워크 요청
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ [APIClient] 네트워크 에러: \(error.localizedDescription)")
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ [APIClient] 잘못된 응답 형식")
                completion(.failure(.invalidResponse))
                return
            }

            // 상태 코드 확인
            guard (200...299).contains(httpResponse.statusCode) else {
                print("❌ [APIClient] HTTP 상태 코드 에러: \(httpResponse.statusCode)")
                if let data = data {
                    print("❌ [APIClient] 에러 응답 데이터: \(String(data: data, encoding: .utf8) ?? "디코딩 불가")")
                }
                completion(.failure(.invalidResponse))
                return
            }

            // 응답 데이터 디코딩
            guard let data = data else {
                print("❌ [APIClient] 응답 데이터가 비어 있음")
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("❌ [APIClient] 디코딩 실패: \(error.localizedDescription)")
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}
