# Problem 1: List the case number, type of crime and community area for all crimes in community area number 18.
SELECT CD.CASE_NUMBER, CD.PRIMARY_TYPE, CSD.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME CD
INNER JOIN CHICAGO_SOCIOECONOMIC_DATA AS CSD ON CD.COMMUNITY_AREA_NUMBER = CSD.COMMUNITY_AREA_NUMBER
WHERE CD.COMMUNITY_AREA_NUMBER = 18;

# Problem 2: List all crimes that took place at a school. 
# Include case number, crime type and community name.
SELECT CD.CASE_NUMBER, CD.PRIMARY_TYPE, CD.LOCATION_DESCRIPTION, CSD.COMMUNITY_AREA_NAME 
FROM CHICAGO_CRIME CD
LEFT OUTER JOIN CHICAGO_SOCIOECONOMIC_DATA AS CSD ON CD.COMMUNITY_AREA_NUMBER = CSD.COMMUNITY_AREA_NUMBER
WHERE CD.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

# Problem 3: For the communities of Oakland, Armour Square, Edgewater and CHICAGO 
# list the associated community_area_numbers and the case_numbers.
SELECT CD.COMMUNITY_AREA_NUMBER, CD.CASE_NUMBER, CSD.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME AS CD
LEFT OUTER JOIN CHICAGO_SOCIOECONOMIC_DATA AS CSD ON CD.COMMUNITY_AREA_NUMBER = CSD.COMMUNITY_AREA_NUMBER
WHERE CSD.COMMUNITY_AREA_NAME IN ('Oakland', 'Armour Square', 'Edgewater', 'CHICAGO')
UNION
SELECT CD.COMMUNITY_AREA_NUMBER, CD.CASE_NUMBER, CSD.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME AS CD
RIGHT OUTER JOIN CHICAGO_SOCIOECONOMIC_DATA AS CSD ON CD.COMMUNITY_AREA_NUMBER = CSD.COMMUNITY_AREA_NUMBER
WHERE CSD.COMMUNITY_AREA_NAME IN ('Oakland', 'Armour Square', 'Edgewater', 'CHICAGO');
