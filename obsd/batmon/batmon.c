/*
 * http://github.com/mitchweaver/bin
 *
 * monitor battery level on OpenBSD
 * and send desktop notification when low
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <util.h>
#include <fcntl.h>
#include <machine/apmvar.h>
#include <sys/ioctl.h>

int
bperc()
{
    int fd;
    fd = open("/dev/apm", O_RDONLY);
    if (fd < 0)
        return 0;

    struct apm_power_info info;
    memset(&info, 0, sizeof(struct apm_power_info));
    ioctl(fd, APM_IOC_GETPOWER, &info);
    close(fd);

    return info.battery_life;
}

int
main()
{
    #ifndef __OpenBSD__
        printf("%s", "Not running on OpenBSD, exiting...");
        exit(1);
    #endif
    
    char buf[512];
    int perc;

    while (1) {
        perc = bperc();
        if(perc < 20) {
            if (perc < 5)
                sprintf(buf, "-u critical 'Battery level CRITICAL: %d%%'\n", perc);
            else if (perc < 10)
                sprintf(buf, "-u critical 'Battery level urgent: %d%%'\n", perc);
            else
                sprintf(buf, "'Battery level low: %d%%'\n", perc);
            char *argv[] =
            {
                "notify-send",
                "notify-send",
                buf,
                NULL
            };
            execv("/usr/bin/env", argv);
        }
        sleep(600);
    }
    return 0;
}
