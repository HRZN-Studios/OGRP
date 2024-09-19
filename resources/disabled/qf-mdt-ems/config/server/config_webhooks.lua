Config.UseWebhooks = true

Config.Webhooks = {
    ['addCitizenNote'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Dodaj notatkę obywatelską",
        description = "Player ID **[%s]** dodano notatkę dla obywatela %s\nDescription %s",
        color = "16601088",
    },
    ['submitFine'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "operacja: nałożono kare pieniężną",
        description = "Player ID **[%s]** otrzymał pieniądze za nałożenie kary pieniężnej %s",
        color = "16601088",
    },
    ['setPWC'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Ustaw PWC",
        description = "Player ID **[%s]** objął stanowisko dowódcy patrolu",
        color = "16601088",
    },
    ['setAPWC'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Ustaw APWC",
        description = "Player ID **[%s]** objął stanowisko zastępcy dowódcy wachty patrolowej",
        color = "16601088",
    },
    ['setStatus'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Ustaw status",
        description = "Player ID **[%s]** zmienić swój status na [%s]",
        color = "16601088",
    },
    ['clearDispatch'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Wyczyść  dispatch",
        description = "Player ID **[%s]** wyczyszczono dispatch",
        color = "16601088",
    },
    ['changePatrolStatus'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Zmień status patrolu",
        description = "Player ID **[%s]** zmienić status własnego patrolu na %s",
        color = "16601088",
    },
    ['removeAnn'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Usunięto ogłoszenie",
        description = "Player ID **[%s]** usunięto ogłoszenie",
        color = "16601088",
    },
    ['addAnn'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Dodano ogłoszenie",
        description = "Player ID **[%s]** dodano ogłoszenie",
        color = "16601088",
    },
    ['kickFromDuty'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Wyrzucenie ze służby",
        description = "Player ID **[%s]** wyrzucił z służby %s %s",
        color = "16601088",
    },
    ['saveEvidence'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Zachowaj dowody",
        description = "Player ID **[%s]** zapisano nowe dowody z tytułem %s",
        color = "16601088",
    },
    ['saveSettings'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Zapisz ustawienia",
        description = "Player ID **[%s]** zapisano nowe ustawienia [%s, %s, %s, %s, %s, %s]",
        color = "16601088",
    },
    ['deleteCitizenNote'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Usuń notatkę obywatela",
        description = "Player ID **[%s]** usunięta notatka obywatelska",
        color = "16601088",
    },
    ['addNote'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Dodaj notatkę",
        description = "Player ID **[%s]** dodał nową notatkę",
        color = "16601088",
    },
    ['deleteNote'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Usuń notatkę",
        description = "Player ID **[%s]** usunięta notatka",
        color = "16601088",
    },
    ['editPatrol'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Edytuj patrol",
        description = "Player ID **[%s]** edytowany patrol",
        color = "16601088",
    },
    ['createPatrol'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Utwórz patrol",
        description = "Player ID **[%s]** utworzył patrol",
        color = "16601088",
    },
    ['joinPatrol'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Dołącz do patrolu",
        description = "Player ID **[%s]** dołączył do patrolu",
        color = "16601088",
    },
    ['quitPatrol'] = {
        webhook = "https://discord.com/api/webhooks/1211782402087723049/c_A0qL0a1mAoKimiIH-Tj_s9Ey4m5czstioppbEsdhvF-g6A5jZnG_SCL7bsnv-qFJpC",
        title = "Operacja: Opuść patrol",
        description = "Player ID **[%s]** opuścił patrol",
        color = "16601088",
    },
}