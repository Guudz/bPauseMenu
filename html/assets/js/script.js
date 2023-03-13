$(function () {
    function displayUI(bool, id) {
        if (bool) {
            $(id).show();
        } else {
            $(id).hide();
        }
    }

    displayUI(false, "#container")
    
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true ) {
                displayUI(true, "#container");
                if (item.data) {
                    var money = item.data.money
                    var bank = item.data.bank
                    var job1 = item.data.job1
                    var job2 = item.data.job2
                    var job_grade1 = item.data[1].job_grade1
                    var job_grade2 = item.data[1].job_grade2

                    document.getElementById("money").textContent = (money + " $")
                    document.getElementById("bank").textContent = (bank + " $")
                    document.getElementById("job1").textContent = (job1 + " - " +  job_grade1)
                    document.getElementById("job2").textContent = (job2 + " - " +  job_grade2)
                    
                }
            } else {
                displayUI(false, "#container");
            }
        } 
    })

    $("#settings").click(function() {
        $.post("https://bPauseMenu/settings", JSON.stringify({}));
    })

    $("#map").click(function() {
        $.post("https://bPauseMenu/map", JSON.stringify({}));
    })

    $("#discord").click(function() {
        window.invokeNative('openUrl', 'https://discord.gg/2re6jFEsGc/')
        $.post("https://bPauseMenu/discord", JSON.stringify({}));
    })

    $("#website").click(function() {
        window.invokeNative('openUrl', 'https://memory-s.fr/')
        $.post("https://bPauseMenu/website", JSON.stringify({}));
    })

    $("#disconnect").click(function() {
        $.post("https://bPauseMenu/disconnect", JSON.stringify({}));
    })

    $("#exit").click(function() {
        $.post("https://bPauseMenu/exit", JSON.stringify({}));
    })
    
})