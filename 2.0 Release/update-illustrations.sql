UPDATE situations
SET illustration = 
    CASE 
        WHEN id IN (62, 63) THEN 'diagramok_stat.jpg'
        WHEN illustration IN (
            'dekan.png',
            'lehetpeter_hogyanhaladtok.png',
            'choice_dekan.png',
            'choice_gabor.png'
        ) THEN 'hedgie_terulo.png'
        ELSE illustration
    END
WHERE id IN (62, 63)
   OR illustration IN (
        'dekan.png',
        'lehetpeter_hogyanhaladtok.png',
        'choice_dekan.png',
        'choice_gabor.png'
   );

COMMIT;