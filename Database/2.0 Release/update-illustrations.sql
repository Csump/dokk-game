UPDATE situations

SET illustration = 
    CASE 
        WHEN illustration = 'dekan.png' THEN 'choice_dekan.png'
        WHEN illustration = 'lehetpeter_hogyanhaladtok.png' THEN 'choice_dekan.png'
        ELSE illustration
    END
WHERE illustration IN ('dekan.png', 'lehetpeter_hogyanhaladtok.png');

COMMIT;