window.$(document).ready(function() {

    let Commands = [];

    let writeHistory = [];//[""];
    let writeHistoryCurrent = -1;

    window.$('.settings-btn').on('click', function() {
        window.$('.chat__settings').addClass('active');
        if (window.$('.chat').hasClass('center')) {
            window.$('.chat').addClass('settings-active');
        }
    });

    window.$('.close-btn').on('click', function() {
        window.$('.chat__settings').removeClass('active');
        if (window.$('.chat').hasClass('center')) {
            window.$('.chat').removeClass('settings-active');
        }
    });

    window.$('.progress').css('background', `linear-gradient(to right, #31AFD4 0%, #31AFD4 ${window.$('.progress').val() * 25}%, #fff ${window.$('.progress').val() * 25}%, white 100%)`)
    
    window.$('.chat').css('scale', 0.9 + window.$('.progress').val() / 20);
    
    window.$('.progress').on('input', function() {
        let value = window.$(this).val();
        SaveSettings(null, `${value}`, null, null)
        window.$(this).css('background', `linear-gradient(to right, #31AFD4 0%, #31AFD4 ${value * 25}%, #fff ${value * 25}%, white 100%)`);
        setTimeout(() => {
            window.$('.chat').css('scale', 0.9 + window.$('.progress').val() / 20);
        }, 150);
        window.$('.custom-range span').html(value);
    });

    window.$('#chat-position input[type="radio"]').on('click', function() {
        if (window.$(this).is(':checked')) {
            window.$('.chat').attr('class', `chat ${window.$(this).val()}`);
            SaveSettings(window.$(this).val(), null, null, null)
            if (window.$(this).val() === 'center') {
                window.$('.chat').addClass('settings-active');
            }
        }
    });

    let backgroundStyle = window.$('.chat__main').css('background');
    let chatMessagesStyle = window.$('.chat__messages').css('background');

    window.$('#bgyes').on('click', function() {
        window.$('.chat__main').css('background', backgroundStyle);
        window.$('.chat__messages').css('background', chatMessagesStyle);
        SaveSettings(null, null, "true", null)
    });

    window.$('#bgno').on('click', function() {
        window.$('.chat__main').css('background', 'none');
        window.$('.chat__messages').css('background', 'none');
        SaveSettings(null, null, "false", null)
    });

    window.$('#show-chat').on('click', function() {
        window.$('.chat').removeClass('hidden');
        window.$('.chat__row').removeClass('hidden');
        window.$('.chat__main').removeClass('hidden');
        window.$.post('https://forge-chat/changeVisibility', JSON.stringify({
            value: 0
        }));
        SaveSettings(null, null, null, "0");
    });

    window.$('#hide-chat').on('click', function() {
        window.$('.chat').addClass('hidden');
        window.$('.chat__row').addClass('hidden');
        window.$('.chat__main').addClass('hidden');
        window.$.post('https://forge-chat/changeVisibility', JSON.stringify({
            value: 2
        }));
        SaveSettings(null, null, null, "2");
    });

    window.$('#oninput').on('click', function() {
        window.$('.chat').addClass('hidden');
        window.$('.chat__row').addClass('hidden');
        window.$('.chat__main').addClass('hidden');
        window.$.post('https://forge-chat/changeVisibility', JSON.stringify({
            value: 1
        }));
        SaveSettings(null, null, null, "1");
    });
	
	window.$('.chat').addClass('hidden');
	window.$('.chat__row').addClass('hidden');
	window.$('.chat__main').addClass('hidden');
	window.$('#show-chat').attr('checked', false);
	window.$('#oninput').attr('checked', true);
	window.$('#hide-chat').attr('checked', false);

    function GetCommandConfig(command) {
        let commandConfig = null;
        Commands.forEach(element => {
            let tempCmd = '/'+element.Command;
            if (tempCmd == command) {
                commandConfig = element;
            }
        });
        return commandConfig;
    }

    function SendMessage(command, name, id, message, staff, customRole, labelText, labelStyle, showid) {
        if(command == "__CHAT__"){
            let newMessage = window.$('<div class="chat__message" />');
            if(labelText == null || labelText.length < 1){
                newMessage.append(`
                    <div class='chat__message-row'>
                    </div>
                    <div class='chat__message-text'>${message}</div>
                `);
            }
            else if(labelStyle != null && labelStyle.length > 0){
                newMessage.append(`
                    <div class='chat__message-row'>
                    <div class='chat__message-info'>
                        <div class='chat__message-id' style='${labelStyle}'>${labelText}</div>
                    </div>
                    </div>
                    <div class='chat__message-text'>${message}</div>
                `);
            }
            window.$('.chat__messages-list').append(newMessage);
        }
        else if (!command) {
            let newMessage = window.$('<div class="chat__message" />');
            if (staff) {
                newMessage.append(`
                    <div class='chat__message-row'>
                        <div class='chat__message-author'>
                            <span style="color: #c96c00">[STAFF]</span> ${name}:
                        </div>
                        <div class='chat__message-info'>
                            ${!showid ? staff ? `<div class='chat__message-id'>ID: ${id}</div>` : `` : `<div class='chat__message-id'>ID: ${id}</div>`}
                        </div>
                    </div>
                    <div class='chat__message-text'>${message}</div>
                `);
            } else {
                newMessage.append(`
                    <div class='chat__message-row'>
                        <div class='chat__message-author'>
                            ${name}:
                        </div>
                        <div class='chat__message-info'>
                            ${!showid ? staff ? `<div class='chat__message-id'>ID: ${id}</div>` : `` : `<div class='chat__message-id'>ID: ${id}</div>`}
                        </div>
                    </div>
                    <div class='chat__message-text'>${message}</div>
                `);
            }
            window.$('.chat__messages-list').append(newMessage);
        } else {
            let commandConfig = GetCommandConfig(command);
            if (!commandConfig) return;
            let newMessage = window.$('<div class="chat__message" />');
            if (commandConfig.Style.Background) newMessage.css('background', commandConfig.Style.Background);
            if (commandConfig.Style.Border) newMessage.css('border', commandConfig.Style.Border);
            let status = commandConfig.Label;
            let role = customRole ? `[${customRole}]` : commandConfig.Role ? `[${commandConfig.Role}]` : '';
            let AuthorColor = commandConfig.Style.AuthorColor ? `color: ${commandConfig.Style.AuthorColor}` : '';
            let LabelBoxContainer = commandConfig.Style.LabelBoxContainer ? `box-shadow: ${commandConfig.Style.LabelBoxContainer}` : '';
            let LabelBoxBackground = commandConfig.Style.LabelBoxBackground ? `background: ${commandConfig.Style.LabelBoxBackground}` : '';
            let LabelBoxBorder = commandConfig.Style.LabelBoxBorder ? `border: ${commandConfig.Style.LabelBoxBorder}` : '';
            if (staff) {
                if (commandConfig.JobLabel) {
                    newMessage.append(`
                        <div class='chat__message-row'>
                            <div class='chat__message-author'>
                                <span style="color: ${commandConfig.ColorJobLabel}">${role}</span> <span style="color: #c96c00">[STAFF]</span> ${name}:
                            </div>
                            <div class='chat__message-info'>
                                <div class='chat__message-status' style="${LabelBoxContainer}">
                                    <span style="${LabelBoxBackground}; ${LabelBoxBorder}">${status}</span>
                                </div>
                                ${!showid ? staff ? `<div class='chat__message-id'>ID: ${id}</div>` : `` : `<div class='chat__message-id'>ID: ${id}</div>`}
                            </div>
                        </div>
                        <div class='chat__message-text'>${message}</div>
                    `);
                } else {
                    newMessage.append(`
                        <div class='chat__message-row'>
                            <div class='chat__message-author'>
                                <span style="color: #c96c00">[STAFF]</span> <span style="${AuthorColor}">${role}</span> ${name}:
                            </div>
                            <div class='chat__message-info'>
                                <div class='chat__message-status' style="${LabelBoxContainer}">
                                    <span style="${LabelBoxBackground}; ${LabelBoxBorder}">${status}</span>
                                </div>
                                ${!showid ? staff ? `<div class='chat__message-id'>ID: ${id}</div>` : `` : `<div class='chat__message-id'>ID: ${id}</div>`}
                            </div>
                        </div>
                        <div class='chat__message-text'>${message}</div>
                    `);
                }
            } else {
                if (commandConfig.JobLabel) {
                    newMessage.append(`
                        <div class='chat__message-row'>
                            <div class='chat__message-author'>
                                <span style="color: ${commandConfig.ColorJobLabel}">${role}</span> ${name}:
                            </div>
                            <div class='chat__message-info'>
                                <div class='chat__message-status' style="${LabelBoxContainer}">
                                    <span style="${LabelBoxBackground}; ${LabelBoxBorder}">${status}</span>
                                </div>
                                ${!showid ? staff ? `<div class='chat__message-id'>ID: ${id}</div>` : `` : `<div class='chat__message-id'>ID: ${id}</div>`}
                            </div>
                        </div>
                        <div class='chat__message-text'>${message}</div>
                    `);
                } else {
                    newMessage.append(`
                        <div class='chat__message-row'>
                            <div class='chat__message-author'>
                                <span style="${AuthorColor}">${role}</span> ${name}:
                            </div>
                            <div class='chat__message-info'>
                                <div class='chat__message-status' style="${LabelBoxContainer}">
                                    <span style="${LabelBoxBackground}; ${LabelBoxBorder}">${status}</span>
                                </div>
                                ${!showid ? staff ? `<div class='chat__message-id'>ID: ${id}</div>` : `` : `<div class='chat__message-id'>ID: ${id}</div>`}
                            </div>
                        </div>
                        <div class='chat__message-text'>${message}</div>
                    `);
                }
            }
            window.$('.chat__messages-list').append(newMessage);
        }
        window.$('.chat__messages-list').scrollTop(window.$('.chat__messages-list').prop('scrollHeight'));
    }
    
    window.$('.chat__form').on('submit', function(event) {
        event.preventDefault();
        let message = window.$('.chat__form input').val();
        ShowSuggestions([], "");
        if(message.length < 1) {
            setTimeout(() => {
                window.$.post('https://forge-chat/close', JSON.stringify({}));
                window.$('.chat__settings').removeClass('active');
                if (window.$('.chat').hasClass('center')) {
                    window.$('.chat').removeClass('settings-active');
                }
            }, 100);
            return;
        }
        window.$.post('https://forge-chat/close', JSON.stringify({}));
        window.$('.chat__settings').removeClass('active');
        if (window.$('.chat').hasClass('center')) {
            window.$('.chat').removeClass('settings-active');
        }
        let regex = /^\/(.*)/g;
        command = message.match(regex);
        command = command ? command[0] : command;
        message = command ? message.replace(command.split(" ")[0], '') : message;
        if(command == null) command = "/ooc";
        window.$.post('https://forge-chat/sendMessage', JSON.stringify({
            fullcommand: command,
            command: command.split(" ")[0],
            message: message
        }));
        window.$('.chat__form input').val('');
        if(command != "/ooc") writeHistory.unshift(command); else writeHistory.unshift(command + " " + message);
        writeHistoryCurrent = -1;
    });

    function UpdateShortcuts(shortcuts) {
        window.$('#shortcuts').html('');
        for (let index = 0; index < shortcuts.length; index++) {
            window.$('#shortcuts').append(`
                <label class="custom-radio-btn">
                    <input type="radio" value="/${shortcuts[index]}" name="command" />
                    <span>${shortcuts[index]}</span>
                </label>
            `);
        }
        window.$('.chat__row input[type="radio"]').on('click', function() {
            window.$('.chat__form input').val(window.$(this).val());
        });
    }

    window.addEventListener('message', event => {
        try {
            switch (event.data.type) {
                case 'UpdateSuggestions':
                    Commands.push(event.data.command);
                    break;
                case 'UpdateShortcuts':
                    UpdateShortcuts(event.data.shortcuts);
                    event.data.commands.forEach(x => {
                        Commands.push(x);
                    });
                    break;
                case 'ShowMessage':
                    SendMessage(event.data.command, event.data.name, event.data.id, event.data.message, event.data.staff, event.data.customRole, event.data.labelText, event.data.labelStyle, event.data.showid);
                    window.$.post('https://forge-chat/close', JSON.stringify({showMessage: true}));
                    break;
                case 'ShowChat':
                    LoadSettings();
                    window.$('.chat').removeClass('hidden');
                    window.$('.chat__row').removeClass('hidden');
                    window.$('.chat__main').removeClass('hidden');
                    break;
                case 'FocusInput':
                    window.$('.chat__form input').focus();
                    break;
                case 'HideChat':
                    window.$('.chat').addClass('hidden');
                    window.$('.chat__row').addClass('hidden');
                    window.$('.chat__main').addClass('hidden');
                    break;
                case 'UpdateVisibility':
                    switch (event.data.chatVisibility) {
                        case 0:
                            window.$('.chat').removeClass('hidden');
                            window.$('.chat__row').removeClass('hidden');
                            window.$('.chat__main').removeClass('hidden');
                            window.$('#show-chat').attr('checked', true);
                            window.$('#oninput').attr('checked', false);
                            window.$('#hide-chat').attr('checked', false);
                            break;
                        case 1:
                            window.$('.chat').addClass('hidden');
                            window.$('.chat__row').addClass('hidden');
                            window.$('.chat__main').addClass('hidden');
                            window.$('#show-chat').attr('checked', false);
                            window.$('#oninput').attr('checked', true);
                            window.$('#hide-chat').attr('checked', false);
                            break;
                        case 2:
                            window.$('.chat').addClass('hidden');
                            window.$('.chat__row').addClass('hidden');
                            window.$('.chat__main').addClass('hidden');
                            window.$('#show-chat').attr('checked', false);
                            window.$('#oninput').attr('checked', false);
                            window.$('#hide-chat').attr('checked', true);
                            break;
                    }
                    break;
                case 'Clear':
                    ClearChat();
                    break;
                case 'ShowPopups':
                    window.$('.center').html('');
                    event.data.popups.forEach(popup => {
                        window.$('.center').append(`
                            <div class="popupwrapper" style="top: ${popup.top * 100 + '%'}; left: ${popup.left * 100 + '%'};">
                                <div class="popup">
                                    <div class="col">
                                        <div class="command" style="box-shadow: ${popup.config.Style.LabelBoxContainer}; background: ${popup.config.Style.LabelBoxBackground}; border: ${popup.config.Style.LabelBoxBorder}">
                                            <span id="popupcommand">${popup.command}</span>
                                        </div>
                                        <div class="id">
                                            <span id="popupid">${'ID: ' + popup.id}</span>
                                        </div>
                                    </div>
                                    <div class="text">
                                        <span id="popuptext">${popup.text}</span>
                                    </div>
                                </div>
                                <div class="triangle"></div>
                            </div>
                        `);
                    });
                    break;
                case 'HidePopup':
                    window.$('.center').fadeOut(500);
                    break;
                case 'LoadSettings':
                    if(event.data.chatPosition != null){ 
                        document.querySelectorAll("input[value=left-up]")[0].removeAttribute("checked");
                        document.querySelectorAll(`input[value=${event.data.chatPosition}]`)[0].setAttribute("checked", true);
                        window.$('.chat').attr('class', `chat ${event.data.chatPosition}`);
                    }

                    if(event.data.chatSize != null) {
                        var value = parseInt(event.data.chatSize);
                        window.$('.progress').css('background', `linear-gradient(to right, #31AFD4 0%, #31AFD4 ${value * 25}%, #fff ${value * 25}%, white 100%)`);
                        setTimeout(() => {
                            window.$('.chat').css('scale', 0.9 + value / 20);
                        }, 150);
                        window.$('.custom-range span').html(value);
                    }

                    if(event.data.chatBackground == "false"){
                        window.$('.chat__main').css('background', 'none');
                        window.$('.chat__messages').css('background', 'none');
                        document.getElementById("bgyes").removeAttribute("checked");
                        document.getElementById("bgno").setAttribute("checked", true);
                    }
                    break;
                case 'showPopup':
                    try {
                        const popup = event.data;
                        window.$('.center').append(`
                            <div class="popupwrapper" style="top: ${popup.top * 100 + '%'}; left: ${popup.left * 100 + '%'};">
                                <div class="popup">
                                    <div class="col">
                                        <div class="command" style="box-shadow: ${popup.config.LabelBoxContainer}; background: ${popup.config.LabelBoxBackground}; border: ${popup.config.LabelBoxBorder}">
                                            <span id="popupcommand">${popup.command}</span>
                                        </div>
                                        <div class="id">
                                            <span id="popupid">${'ID: ' + popup.id}</span>
                                        </div>
                                    </div>
                                    <div class="text">
                                        <span id="popuptext">${popup.text}</span>
                                    </div>
                                </div>
                                <div class="triangle"></div>
                            </div>
                        `);
                    } catch (error) {
                        console.error("Error displaying popup: ", error);
                    }
                    break;
                default:
                    console.warn("Unhandled event type: ", event.data.type);
            }
        } catch (error) {
            console.error("Error handling message event: ", error);
        }
    });

    window.$(document).keyup(function(e) {
        if (e.keyCode == 27) {
            window.$.post('https://forge-chat/closeInstant', JSON.stringify({}));

            window.$('.chat__settings').removeClass('active');
            if (window.$('.chat').hasClass('center')) {
                window.$('.chat').removeClass('settings-active');
            }
        }
        else if (e.keyCode == 38) {
            if(writeHistoryCurrent+1 > writeHistory.length-1) return;
            window.$('.chat__form input').val(writeHistory[++writeHistoryCurrent]);
        }
        else if (e.keyCode == 40) {
            if(writeHistoryCurrent-1 < 0) return;
            window.$('.chat__form input').val(writeHistory[--writeHistoryCurrent]);
        }
    });

    function Search(str) {
        let results = [];
        const val = str.toLowerCase();
        Commands.forEach(command => {
            command = '/'+command.Command
            if (command.toLowerCase().indexOf(val) > -1) {
                results.push(command);
            }
        });
        return results;
    }

    function SearchHandler(event) {
        const inputVal = event.currentTarget.value;
        let results = [];
        if (inputVal.length > 0) {
            results = Search(inputVal);
        }
        ShowSuggestions(results, inputVal);
    }

    function ShowSuggestions(results, inputVal) {
        window.$('.suggestions').html('');
        if (results.length > 0) {
            for (index = 0; index < results.length; index++) {
                let item = results[index];
                let commandConfig = GetCommandConfig(item);
                let type = commandConfig.Help.Title || "Command";
                let text = commandConfig.Help.Subtitle;
                const match = item.match(new RegExp(inputVal, 'i'));
                item = item.replace(match[0], `<span>${match[0]}</span>`);
                window.$('.suggestions').append(`
                    <div class="suggestion">
                        <div class="suggestion__row">
                            <div class="suggestion-command">${item}</div>
                            <div class="suggestion-type">${type}</div>
                        </div>
                        <div class="suggestion-text">
                            ${text}
                        </div>
                    </div>
                `);
            }
        } else {
            results = [];
            window.$('.suggestions').html('');
        }
    }

    function UseSuggestion(event) {
        const command = event.target.querySelector('.suggestion-command').innerText;
        window.$('.chat__form input').val(command);
        window.$('.chat__form input').focus();
        window.$('.suggestions').html('');
    }

    function ClearChat(){
        var chatBox = document.getElementsByClassName("chat__messages-list")[0];
        Array.from(chatBox.children).forEach(x => {
            x.remove();
        });
    }

    function SaveSettings(_chatPosition, _chatSize, _chatBackground, _chatVisibility){
        window.$.post('https://forge-chat/saveSettings', JSON.stringify({
            chatPosition: _chatPosition,
            chatSize: _chatSize,
            chatBackground: _chatBackground,
            chatVisibility: _chatVisibility
        }));
    }
    function LoadSettings(){
        window.$.post('https://forge-chat/loadSettings', JSON.stringify({}));
    }

    window.$('.chat__form input').on('keyup', SearchHandler);
    window.$('.suggestions').on('click', UseSuggestion);

});