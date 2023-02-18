
# AGH-Analiza-i-przetwarzanie-sygnalow-i-obrazow-cyfrowych

#### Final project of course Analysis and processing of digital signals and images at AGH.

The goal of the project was to detect selected rock components. The analysis was carried out on Istebnian sandstone, which had in its composition, among other components, such as quartz, glauconite and carbonates. In addition to the detection, the surface area of the indicated components. No manual reduction of the image area was used during the analysis.

The analysis was based on images of one area (no. 31) of the sandstone. One photo was taken for a single polarizer in orientation 180, while six photos were taken for a crossed polarizer, each in a different orientation. The photos were taken at a 20x zoom. In addition, one photo with an included scale was available to assist in the process of calculating the area. Computer detection was primarily based on two photos, but the other photos were very helpful in seeing what the sandstone components we were looking for looked like. A top-down assumption during the analysis was the size of the components - elements with an area of less than 100 pixels were not considered. The calculations were performed in MatLAB once with the Image Processing Toolbox library installed.

#### Photographs on which computer detection was based:


![31_180_1N](https://user-images.githubusercontent.com/100961127/219884144-6ea95cb6-db3d-49b4-b210-9bb66b6a92d5.jpg)

![31_180_XN](https://user-images.githubusercontent.com/100961127/219884268-569eb469-84cf-41c2-a325-763f848e305f.jpg)



## Results
#### Quartz (0.2287 mm<sup>2</sup>):
![kwaN](https://user-images.githubusercontent.com/100961127/219884356-0c08d7f0-8e4b-4dd5-a3b4-374011256835.png)
#### Glauconite (0.0368 mm<sup>2</sup>):
![glaN](https://user-images.githubusercontent.com/100961127/219884361-8e8bcbf6-dcd7-4e44-ba1b-ad62307a5cc9.png)
#### Carbonates (0.0141 mm<sup>2</sup>):
![wegN](https://user-images.githubusercontent.com/100961127/219884364-fff29ab2-df4c-47c1-bb9c-a4767f50d4cb.png)
