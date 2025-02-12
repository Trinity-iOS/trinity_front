//
//  MockData.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import UIKit

struct MockData {
    static let artworkItems: [Artwork] = [
        //MARK: - Alfred Stieglitz
        Artwork(
            id: "LettersOfLonging",
            image: UIImage(named: "LettersOfLonging")!,
            title: "Letters of Longing",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                In a dimly lit room, a woman sits at her desk, absorbed in writing a letter. The soft rays of sunlight filter through the blinds, casting dramatic shadows across the walls and her silhouette. Surrounding her are portraits of loved ones, evoking a sense of nostalgia and yearning. An empty birdcage hangs on the wall, symbolizing confinement and the longing for freedom.
                """
        ),
        Artwork(
            id: "WhisperingTouch",
            image: UIImage(named: "WhisperingTouch")!,
            title: "Whispering Touch",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                This artwork captures the delicate interaction between two hands, suspended in a moment of silent communication. The subtle contours and soft shading evoke a sense of intimacy and fragility.
                """
        ),
        Artwork(
            id: "TheSilentBarn",
            image: UIImage(named: "TheSilentBarn")!,
            title: "The Silent Barn",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                This piece features an old, weathered barn with its wooden walls and broken window, standing as a testament to time. The stark contrast between light and shadow highlights the texture of the aged wood, evoking a sense of nostalgia and abandonment.
                """
        ),
        Artwork(
            id: "BranchesOfSolitude",
            image: UIImage(named: "BranchesOfSolitude")!,
            title: "Branches of Solitude",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                This image portrays the skeletal branches of leafless trees reaching out against a pale sky. The stark emptiness of the scene, combined with the sharp contrast of the dark branches against the soft background, creates a sense of desolation and isolation.
                """
        ),
        Artwork(
            id: "DepartureIntoTheUnknown",
            image: UIImage(named: "DepartureIntoTheUnknown")!,
            title: "Departure into the Unknown",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                A lone figure, shrouded in shadow, walks away from an old barn, leaving behind the familiar path that leads to the darkened building. The contrast of light and darkness, along with the figure's obscured identity, evokes a sense of mystery and solitude.
                """
        ),
        Artwork(
            id: "EchoesOfMemories",
            image: UIImage(named: "EchoesOfMemories")!,
            title: "Echoes of Memories",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                This piece captures the interior of a lavish room, adorned with antique furniture and framed portraits. The ornate decor and the carefully arranged photographs tell a story of a time long past. Each frame, containing faded images of people and places, serves as a window into the history and memories that linger within these walls.
                """
        ),
        Artwork(
            id: "TangledGrowth",
            image: UIImage(named: "TangledGrowth")!,
            title: "Tangled Growth",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                This photograph showcases a dense thicket of bare branches, intertwining and overlapping in a chaotic yet natural pattern. The intricate web of lines and textures creates a visual maze, drawing the viewer’s eye deeper into the composition.
                """
        ),
        Artwork(
            id: "WintersEmbrace",
            image: UIImage(named: "WintersEmbrace")!,
            title: "Winter’s Embrace",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                This photograph depicts a tree cloaked in a thick layer of snow, its branches appearing almost sculptural under the weight. The snow’s soft contours contrast with the stark lines of the bare tree, creating a delicate interplay between strength and fragility.
                """
        ),
        Artwork(
            id: "TheGatheringStorm",
            image: UIImage(named: "TheGatheringStorm")!,
            title: "The Gathering Storm",
            artist: "Alfred Stieglitz",
            artistImage: UIImage(named: "AlfredStieglitz")!,
            detail: """
                This image captures a dramatic sky filled with swirling clouds, partially obscuring the sun. The interplay of light and shadow creates an intense atmosphere, as the dark clouds loom ominously, suggesting the approach of a storm.
                """
        ),
        
        //MARK: - Henri Rousseau
        Artwork(
            id: "WomanWalkingInAnExoticForest",
            image: UIImage(named: "WomanWalkingInAnExoticForest")!,
            title: "Woman Walking in an Exotic Forest",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                This painting by Henri Rousseau depicts a serene and dreamlike scene of a woman walking through a lush, exotic forest. The vibrant greenery, towering trees, and oversized flowers create a surreal and almost magical atmosphere. Rousseau’s characteristic style, with its flattened perspective and rich color palette, gives the scene a naive yet captivating charm. The woman, dressed in a white gown and hat, stands in stark contrast to the dense foliage, symbolizing human presence amidst the untamed beauty of nature.
                """
        ),
        Artwork(
            id: "TheFactoryAtCharenton",
            image: UIImage(named: "TheFactoryAtCharenton")!,
            title: "The Factory at Charenton",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                "The Factory at Charenton," portrays an industrial landscape surrounded by greenery. The tall chimneys rise above the lush trees, emitting smoke that contrasts with the serene atmosphere of the scene. In the foreground, small figures go about their day, adding a sense of human activity to the otherwise still environment. The art’s gentle colors and precise detailing reflect Rousseau’s unique ability to blend the man-made and the natural, creating a harmonious yet slightly surreal image.
                """
        ),
        Artwork(
            id: "SailingAtSunset",
            image: UIImage(named: "SailingAtSunset")!,
            title: "Sailing at Sunset",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                In this work, Henri Rousseau captures the tranquil beauty of a sailing ship at sunset. The pastel hues of the sky and sea, coupled with the gentle waves, evoke a sense of calm and stillness. Palm trees and vibrant flowers frame the scene, adding a tropical touch to the serene seascape. The composition’s simplicity and dreamlike quality are hallmarks of Rousseau’s style, inviting the viewer into a world of peaceful reverie and distant horizons.
                """
        ),
        Artwork(
            id: "TheWomanWithABasket",
            image: UIImage(named: "TheWomanWithABasket")!,
            title: "The Woman with a Basket",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                In this portrait, I sought to capture the charm of a simple, rural life. The woman’s calm expression and gentle demeanor reflect a sense of contentment as she holds a basket full of eggs, freshly collected. The large hat and her modest dress suggest the countryside setting, where time seems to pass more slowly. The vibrant green foliage in the background contrasts beautifully with her attire, emphasizing her connection to nature and the simplicity of her existence.
                """
        ),
        Artwork(
            id: "BouquetInAGlassVase",
            image: UIImage(named: "BouquetInAGlassVase")!,
            title: "Bouquet in a Glass Vase",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                This still life is a celebration of color and form. The bouquet, carefully arranged in a simple glass vase, showcases a variety of flowers, each painted with attention to detail and vibrancy. The deep reds, soft yellows, and gentle greens all come together to create a harmonious composition. By placing the vase on a vivid red table, I aimed to add warmth and contrast to the overall scene, making the flowers stand out even more against the muted backdrop.
                """
        ),
        Artwork(
            id: "StrollingInThePark",
            image: UIImage(named: "StrollingInThePark")!,
            title: "Strolling in the Park",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                This art captures the leisurely atmosphere of an afternoon in the park. Gentlefolk dressed in elegant attire stroll along the path, enjoying the tranquility of the lush greenery around them. The tall trees frame the scene, their branches forming a natural canopy that gives a sense of seclusion and peace. In the distance, an industrial building peeks through the foliage, reminding us of the city beyond. By blending nature and urban elements, I aimed to create a space where the past and present coexist harmoniously.
                """
        ),
        Artwork(
            id: "FishermenByTheRiver",
            image: UIImage(named: "FishermenByTheRiver")!,
            title: "Fishermen by the River",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                In this tranquil riverside scene, a group of fishermen stand along the riverbank, casting their lines into the water. The calm reflections of their figures ripple gently across the surface, suggesting the stillness of the early morning. Behind them, rows of white buildings contrast with the dense greenery, creating a serene balance between nature and the man-made world. I aimed to capture a moment of quiet harmony, where human activity and the natural environment coexist peacefully.
                """
        ),
        Artwork(
            id: "TheLittleBoyOnTheRocks",
            image: UIImage(named: "TheLittleBoyOnTheRocks")!,
            title: "The Little Boy on the Rocks",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                This portrait captures a young boy seated confidently atop rugged rocks. His solemn expression and formal attire stand out against the stark, barren landscape. Despite his small stature, the boy exudes a sense of composure and presence, almost as if he were the master of this harsh terrain. By placing him in such a dramatic setting, I aimed to convey the idea of childhood innocence confronting the larger, untamed world around him.
                """
        ),
        Artwork(
            id: "MonkeysInTheJungle",
            image: UIImage(named: "MonkeysInTheJungle")!,
            title: "Monkeys in the Jungle",
            artist: "Henri Rousseau",
            artistImage: UIImage(named: "HenriRousseau")!,
            detail: """
                In this vibrant jungle scene, playful monkeys peer out from behind lush foliage, clutching bright orange fruits. The dense, overlapping leaves create a tapestry of greens, while the bold colors of the monkeys and fruits add a lively contrast. Above, a brightly colored parrot perches on a branch, adding to the exotic atmosphere. I wanted to depict the energy and life of the jungle, where every leaf and creature is full of movement and curiosity.
                """
        ),
        
        //MARK: - Ito Jakuchu
        Artwork(
            id: "BlossomingPlumTree",
            image: UIImage(named: "BlossomingPlumTree")!,
            title: "Blossoming Plum Tree",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                The painting depicts a maze of twisted plum tree branches blooming with delicate white and pink blossoms, set against a muted brown background. Each flower, meticulously detailed, stands out with a sense of lightness and purity. The intricacy of the interwoven branches and the soft glow of the full moon in the background evoke a tranquil atmosphere of early spring. This work captures the delicate balance of nature's beauty, symbolizing renewal and the fleeting nature of life.
                """
        ),
        Artwork(
            id: "CrowsSong",
            image: UIImage(named: "CrowsSong")!,
            title: "Crow’s Song",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                A solitary crow perches on a wooden beam, its beak open as if cawing into the vast, empty space. The strong, bold ink strokes create a sharp contrast between the bird's form and the light background, capturing the essence of the crow's voice reverberating in the silence. The minimalist composition and dynamic brushwork emphasize the raw energy and fleeting nature of the moment, embodying the spirit of traditional Asian ink painting.
                """
        ),
        Artwork(
            id: "CrimsonSolitude",
            image: UIImage(named: "CrimsonSolitude")!,
            title: "Crimson Solitude",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                A striking crimson parrot perches quietly on a winding branch, its vivid plumage glowing against the stark black background. The intricate patterns on its feathers are meticulously rendered, showcasing hues of deep blue, fiery red, and golden accents. Surrounding the bird, autumnal leaves and delicate mushrooms add a subtle warmth, as if whispering of nature’s delicate balance between life and decay. This composition exudes both elegance and tranquility, capturing a fleeting moment of solitary beauty.
                """
        ),
        Artwork(
            id: "ThePerchOfSerenity",
            image: UIImage(named: "ThePerchOfSerenity")!,
            title: "The Perch of Serenity",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                A tranquil scene featuring a white cockatoo perched elegantly on a vibrant, ornate stand. The intricate details of the decorative bar, with its rich reds, blues, and golds, contrast gently against the soft white of the bird's plumage. The cockatoo’s calm expression and the harmonious blend of traditional motifs evoke a sense of peace and grandeur, symbolizing the timeless beauty of nature intertwined with refined art.
                """
        ),
        Artwork(
            id: "WhisperingSilhouettes",
            image: UIImage(named: "WhisperingSilhouettes")!,
            title: "Whispering Silhouettes",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                Two cranes stand side by side, their slender necks entwining subtly, creating an elegant silhouette against the muted background. Each crane faces a different direction, their gazes suggesting a quiet conversation between them. The delicate brushstrokes emphasize their poised stance, blending simplicity with sophistication. This monochromatic masterpiece captures the ephemeral beauty of nature, expressed through refined minimalism.
                """
        ),
        Artwork(
            id: "WhiteCockatoo",
            image: UIImage(named: "WhiteCockatoo")!,
            title: "White Cockatoo",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                The artwork showcases a majestic white cockatoo upside down on a perch, depicted with smooth, clean lines and intricate patterns. The contrasting red and blue ornamental elements add an exotic touch, standing out against the black circular backdrop. The piece beautifully captures the bird's delicate form, exuding both playfulness and elegance, while highlighting the artist's mastery of balance and simplicity in design.
                """
        ),
        Artwork(
            id: "FullMoonOverPines",
            image: UIImage(named: "FullMoonOverPines")!,
            title: "Full Moon Over Pines",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                This painting features a striking red full moon rising behind dark silhouettes of pine trees. The bold, expressive brushstrokes convey a sense of movement and rhythm, contrasting with the stillness of the serene moonlit night. The subtle interplay of light and shadow creates a mystical atmosphere, making the moon appear almost surreal against the night sky. This work invites the viewer to contemplate nature's majestic beauty and the tranquility of the moment.
                """
        ),
        Artwork(
            id: "HarmonyInContrast",
            image: UIImage(named: "HarmonyInContrast")!,
            title: "Harmony in Contrast",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                A vivid parrot rests amidst the stark darkness, framed by a branch adorned with delicate camellia blossoms. The vibrant red and yellow feathers of the bird contrast sharply with the deep black canvas, drawing the viewer’s attention to its exquisite details. The precise linework and soft gradients of the surrounding flora add to the visual harmony, making this artwork a celebration of nature’s vivid colors and intricate patterns.
                """
        ),
        Artwork(
            id: "ParrotAndFoliage",
            image: UIImage(named: "ParrotAndFoliage")!,
            title: "Parrot and Foliage",
            artist: "Ito Jakuchu",
            artistImage: UIImage(named: "ItoJakuchu")!,
            detail: """
                A vibrant green parrot perches calmly on a branch surrounded by stylized leaves and flowers, set against a deep black background. The use of rich colors and contrasting patterns highlights the bird's striking appearance. The minimalistic design allows the viewer to focus on the parrot's vivid plumage and the subtle details of the plant forms, blending elegance and simplicity in a harmonious composition.
                """
        )
    ]
}
