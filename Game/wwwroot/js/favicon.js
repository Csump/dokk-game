window.faviconHelper = {
    changeFavicon: function (iconPath) {
        const link = document.querySelector("link[rel*='icon']") || document.createElement('link');
        link.type = 'image/png';
        link.rel = 'icon';
        link.href = iconPath;

        if (!document.querySelector("link[rel*='icon']")) {
            document.head.appendChild(link);
        }
    },

    getCharacterIconUrl: function(gender, age) {
        const genderStr = gender === 0 ? 'male' : 'female';
        const ageStr = age === 0 ? 'young' : 'old';
        return `/src/Characters/large-char-${ageStr}-${genderStr}-icon.png`;
    }
};
