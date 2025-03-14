Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B4DC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 12:57:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05A0140289;
	Fri, 14 Mar 2025 13:57:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9E5ED400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 13:57:21 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E90Zci015733
 for <dev@dpdk.org>; Fri, 14 Mar 2025 05:57:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=vhvGtTCgGXR2U6vd2kVlSAE
 H1Z8qaaZgPwr4Vzu/nRo=; b=LG0F6xvu2WD1s51YoHNlKRnsoHGaXre3NH489E/
 BYCabYbOeahYVzrjtj/fePd6XaKz/EzSIfmG03Vfrugms4EDFcrLz+onqvnfdZU7
 wLUfV4xSrnswHI413/v4Qxp/yVhdcdR39mhPZxgHVqekNDH6LyxiqwompJC8VxLa
 KsN/V4IU/3n9kgxo+dS6ep/wqivXU9aX2nSEeW+aFguwhbbJfNxXeQAJn+Ra+aaR
 pyg9mb90uVRhJW0hk73/2EMWmiq0m0YbB6b+49k2xl5jc6ZaU9G+XO7W86HPWoTq
 2ZrTD2GEVRNO4mvZimvHnVwvZyJrQqCd6XrcKxN1W44e5/A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45avuuydjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 14 Mar 2025 05:57:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 14 Mar 2025 05:57:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 14 Mar 2025 05:57:18 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 8E3613F7063;
 Fri, 14 Mar 2025 05:57:16 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>, Jakub Palider <jpalider@marvell.com>, Tomasz Duszynski
 <tduszynski@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH] raw/cnxk_gpio: switch to character based GPIO interface
Date: Fri, 14 Mar 2025 13:57:09 +0100
Message-ID: <20250314125710.4118027-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PL6ArQaV-CFCgQ3tloMiMosVgLxUeBh9
X-Proofpoint-ORIG-GUID: PL6ArQaV-CFCgQ3tloMiMosVgLxUeBh9
X-Authority-Analysis: v=2.4 cv=ZKLXmW7b c=1 sm=1 tr=0 ts=67d427b0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=-9QUVapbMWqBLdov93YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-13_01,2024-11-22_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The direct passthrough interrupt mechanism, which allowed bypassing the
kernel, was obscure and is no longer supported. So this driver won't
work with latest SDK kernels. Additionally, the sysfs GPIO control
interface has been deprecated by Linux kernel itself.

That said, this change updates the PMD to use the current GPIO interface
ensuring compatibility with current kernel standards while improving
maintainability and security.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 doc/guides/rawdevs/cnxk_gpio.rst           |  37 +-
 drivers/raw/cnxk_gpio/cnxk_gpio.c          | 518 ++++++++++++---------
 drivers/raw/cnxk_gpio/cnxk_gpio.h          |  17 +-
 drivers/raw/cnxk_gpio/cnxk_gpio_irq.c      | 216 ---------
 drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c | 234 ++--------
 drivers/raw/cnxk_gpio/meson.build          |   1 -
 drivers/raw/cnxk_gpio/rte_pmd_cnxk_gpio.h  |  57 ++-
 7 files changed, 427 insertions(+), 653 deletions(-)
 delete mode 100644 drivers/raw/cnxk_gpio/cnxk_gpio_irq.c

diff --git a/doc/guides/rawdevs/cnxk_gpio.rst b/doc/guides/rawdevs/cnxk_gpio.rst
index 954d3b8905..8084dd4adb 100644
--- a/doc/guides/rawdevs/cnxk_gpio.rst
+++ b/doc/guides/rawdevs/cnxk_gpio.rst
@@ -6,31 +6,20 @@ Marvell CNXK GPIO Driver
 
 CNXK GPIO PMD configures and manages GPIOs available on the system using
 standard enqueue/dequeue mechanism offered by raw device abstraction. PMD relies
-both on standard sysfs GPIO interface provided by the Linux kernel and GPIO
-kernel driver custom interface allowing one to install userspace interrupt
-handlers.
+on standard kernel GPIO character device interface.
 
 Features
 --------
 
 Following features are available:
 
-- export/unexport a GPIO
-- read/write specific value from/to exported GPIO
+- read/write specific value from/to GPIO
 - set GPIO direction
 - set GPIO edge that triggers interrupt
 - set GPIO active low
 - register interrupt handler for specific GPIO
 - multiprocess aware
 
-Requirements
-------------
-
-PMD relies on modified kernel GPIO driver which exposes ``ioctl()`` interface
-for installing interrupt handlers for low latency signal processing.
-
-Driver is shipped with Marvell SDK.
-
 Limitations
 -----------
 
@@ -43,20 +32,20 @@ Device Setup
 CNXK GPIO PMD binds to virtual device which gets created by passing
 `--vdev=cnxk_gpio,gpiochip=<number>` command line to EAL. `gpiochip` parameter
 tells PMD which GPIO controller should be used. Available controllers are
-available under `/sys/class/gpio`. For further details on how Linux represents
-GPIOs in userspace please refer to
-`sysfs.txt <https://www.kernel.org/doc/Documentation/gpio/sysfs.txt>`_.
+`/dev/gpiochipN` character devices. For further details on
+how Linux represents GPIOs in userspace please refer to
+`gpio-cdev <https://www.kernel.org/doc/Documentation/ABI/testing/gpio-cdev>`_.
 
 If `gpiochip=<number>` was omitted then first gpiochip from the alphabetically
 sort list of available gpiochips is used.
 
 .. code-block:: console
 
-   $ ls /sys/class/gpio
-   export gpiochip448 unexport
+   $ ls /dev/gpiochip*
+   /dev/gpiochip0
 
 In above scenario only one GPIO controller is present hence
-`--vdev=cnxk_gpio,gpiochip=448` should be passed to EAL.
+`--vdev=cnxk_gpio,gpiochip=0` should be passed to EAL.
 
 Before performing actual data transfer one needs to call
 ``rte_rawdev_queue_count()`` followed by ``rte_rawdev_queue_conf_get()``. The
@@ -65,7 +54,7 @@ being controllable or not. Thus it is user responsibility to pick the proper
 ones. The latter call simply returns queue capacity.
 
 In order to allow using only subset of available GPIOs `allowlist` PMD param may
-be used. For example passing `--vdev=cnxk_gpio,gpiochip=448,allowlist=[0,1,2,3]`
+be used. For example passing `--vdev=cnxk_gpio,gpiochip=0,allowlist=[0,1,2,3]`
 to EAL will deny using all GPIOs except those specified explicitly in the
 `allowlist`.
 
@@ -179,12 +168,12 @@ Request interrupt
 
 Message is used to install custom interrupt handler.
 
-Message must have type set to ``CNXK_GPIO_MSG_TYPE_REGISTER_IRQ``.
+Message must have type set to ``CNXK_GPIO_MSG_TYPE_REGISTER_IRQ2``.
 
-Payload needs to be set to ``struct cnxk_gpio_irq`` which describes interrupt
+Payload needs to be set to ``struct cnxk_gpio_irq2`` which describes interrupt
 being requested.
 
-Consider using ``rte_pmd_gpio_register_gpio()`` wrapper.
+Consider using ``rte_pmd_gpio_register_irq2()`` wrapper.
 
 Free interrupt
 ~~~~~~~~~~~~~~
@@ -193,7 +182,7 @@ Message is used to remove installed interrupt handler.
 
 Message must have type set to ``CNXK_GPIO_MSG_TYPE_UNREGISTER_IRQ``.
 
-Consider using ``rte_pmd_gpio_unregister_gpio()`` wrapper.
+Consider using ``rte_pmd_gpio_unregister_irq()`` wrapper.
 
 Self test
 ---------
diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio.c b/drivers/raw/cnxk_gpio/cnxk_gpio.c
index 329ac28a27..800f2cf1c3 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio.c
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio.c
@@ -3,11 +3,19 @@
  */
 
 #include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/gpio.h>
+#include <regex.h>
 #include <string.h>
+#include <sys/ioctl.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 
 #include <bus_vdev_driver.h>
 #include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_interrupts.h>
 #include <rte_kvargs.h>
 #include <rte_lcore.h>
 #include <rte_rawdev_pmd.h>
@@ -17,9 +25,8 @@
 #include "cnxk_gpio.h"
 #include "rte_pmd_cnxk_gpio.h"
 
-#define CNXK_GPIO_BUFSZ 128
-#define CNXK_GPIO_CLASS_PATH "/sys/class/gpio"
 #define CNXK_GPIO_PARAMS_MZ_NAME "cnxk_gpio_params_mz"
+#define CNXK_GPIO_INVALID_FD (-1)
 
 struct cnxk_gpio_params {
 	unsigned int num;
@@ -40,6 +47,31 @@ cnxk_gpio_format_name(char *name, size_t len)
 	snprintf(name, len, "cnxk_gpio");
 }
 
+static int
+cnxk_gpio_ioctl(struct cnxk_gpio *gpio, unsigned long cmd, void *arg)
+{
+	return ioctl(gpio->fd, cmd, arg) ? -errno : 0;
+}
+
+static int
+cnxk_gpio_gpiochip_ioctl(struct cnxk_gpiochip *gpiochip, unsigned long cmd, void *arg)
+{
+	char path[PATH_MAX];
+	int ret = 0, fd;
+
+	snprintf(path, sizeof(path), "/dev/gpiochip%d", gpiochip->num);
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return -errno;
+
+	if (ioctl(fd, cmd, arg))
+		ret = -errno;
+
+	close(fd);
+
+	return ret;
+}
+
 static int
 cnxk_gpio_filter_gpiochip(const struct dirent *dirent)
 {
@@ -54,8 +86,7 @@ cnxk_gpio_set_defaults(struct cnxk_gpio_params *params)
 	struct dirent **namelist;
 	int ret = 0, n;
 
-	n = scandir(CNXK_GPIO_CLASS_PATH, &namelist, cnxk_gpio_filter_gpiochip,
-		    alphasort);
+	n = scandir("/dev", &namelist, cnxk_gpio_filter_gpiochip, alphasort);
 	if (n < 0 || n == 0)
 		return -ENODEV;
 
@@ -143,7 +174,7 @@ cnxk_gpio_parse_arg(struct rte_kvargs *kvlist, const char *arg, arg_handler_t ha
 static int
 cnxk_gpio_parse_store_args(struct cnxk_gpio_params **params, const char *args)
 {
-	size_t len = sizeof(**params);
+	size_t len = sizeof(**params) + 1;
 	const char *allowlist = NULL;
 	struct rte_kvargs *kvlist;
 	int ret;
@@ -163,11 +194,13 @@ cnxk_gpio_parse_store_args(struct cnxk_gpio_params **params, const char *args)
 
 	ret = cnxk_gpio_parse_arg(kvlist, CNXK_GPIO_ARG_ALLOWLIST, cnxk_gpio_parse_arg_allowlist,
 				  &allowlist);
-	if (ret < 0)
+	if (ret < 0) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	if (allowlist)
-		len += strlen(allowlist) + 1;
+		len += strlen(allowlist);
 
 	*params = cnxk_gpio_params_reserve(len);
 	if (!(*params)) {
@@ -175,7 +208,8 @@ cnxk_gpio_parse_store_args(struct cnxk_gpio_params **params, const char *args)
 		goto out;
 	}
 
-	strlcpy((*params)->allowlist, allowlist, strlen(allowlist) + 1);
+	if (allowlist)
+		strlcpy((*params)->allowlist, allowlist, strlen(allowlist) + 1);
 
 	ret = cnxk_gpio_parse_arg(kvlist, CNXK_GPIO_ARG_GPIOCHIP, cnxk_gpio_parse_arg_gpiochip,
 				  &(*params)->num);
@@ -188,6 +222,24 @@ cnxk_gpio_parse_store_args(struct cnxk_gpio_params **params, const char *args)
 	return ret;
 }
 
+static bool
+cnxk_gpio_allowlist_valid(const char *allowlist)
+{
+	bool ret = false;
+	regex_t regex;
+
+	/* [gpio0<,gpio1,...,gpioN>], where '<...>' is optional part */
+	if (regcomp(&regex, "^\\[[0-9]+(,[0-9]+)*\\]$", REG_EXTENDED))
+		return ret;
+
+	if (!regexec(&regex, allowlist, 0, NULL, 0))
+		ret = true;
+
+	regfree(&regex);
+
+	return ret;
+}
+
 static int
 cnxk_gpio_parse_allowlist(struct cnxk_gpiochip *gpiochip, char *allowlist)
 {
@@ -199,6 +251,17 @@ cnxk_gpio_parse_allowlist(struct cnxk_gpiochip *gpiochip, char *allowlist)
 	if (!list)
 		return -ENOMEM;
 
+	/* no gpios provided so allow all */
+	if (!*allowlist) {
+		for (i = 0; i < gpiochip->num_gpios; i++)
+			list[queue++] = i;
+
+		goto out_done;
+	}
+
+	if (!cnxk_gpio_allowlist_valid(allowlist))
+		return -EINVAL;
+
 	allowlist = strdup(allowlist);
 	if (!allowlist) {
 		ret = -ENOMEM;
@@ -239,6 +302,7 @@ cnxk_gpio_parse_allowlist(struct cnxk_gpiochip *gpiochip, char *allowlist)
 	} while ((token = strtok(NULL, ",")));
 
 	free(allowlist);
+out_done:
 	gpiochip->allowlist = list;
 	gpiochip->num_queues = queue;
 
@@ -250,88 +314,6 @@ cnxk_gpio_parse_allowlist(struct cnxk_gpiochip *gpiochip, char *allowlist)
 	return ret;
 }
 
-static int
-cnxk_gpio_read_attr(char *attr, char *val)
-{
-	int ret, ret2;
-	FILE *fp;
-
-	fp = fopen(attr, "r");
-	if (!fp)
-		return -errno;
-
-	ret = fscanf(fp, "%s", val);
-	if (ret < 0) {
-		ret = -errno;
-		goto out;
-	}
-	if (ret != 1) {
-		ret = -EIO;
-		goto out;
-	}
-
-	ret = 0;
-out:
-	ret2 = fclose(fp);
-	if (!ret)
-		ret = ret2;
-
-	return ret;
-}
-
-static int
-cnxk_gpio_read_attr_int(char *attr, int *val)
-{
-	char buf[CNXK_GPIO_BUFSZ];
-	int ret;
-
-	ret = cnxk_gpio_read_attr(attr, buf);
-	if (ret)
-		return ret;
-
-	ret = sscanf(buf, "%d", val);
-	if (ret < 0)
-		return -errno;
-
-	return 0;
-}
-
-static int
-cnxk_gpio_write_attr(const char *attr, const char *val)
-{
-	FILE *fp;
-	int ret;
-
-	if (!val)
-		return -EINVAL;
-
-	fp = fopen(attr, "w");
-	if (!fp)
-		return -errno;
-
-	ret = fprintf(fp, "%s", val);
-	if (ret < 0) {
-		fclose(fp);
-		return ret;
-	}
-
-	ret = fclose(fp);
-	if (ret)
-		return -errno;
-
-	return 0;
-}
-
-static int
-cnxk_gpio_write_attr_int(const char *attr, int val)
-{
-	char buf[CNXK_GPIO_BUFSZ];
-
-	snprintf(buf, sizeof(buf), "%d", val);
-
-	return cnxk_gpio_write_attr(attr, buf);
-}
-
 static bool
 cnxk_gpio_queue_valid(struct cnxk_gpiochip *gpiochip, uint16_t queue)
 {
@@ -353,14 +335,16 @@ cnxk_gpio_lookup(struct cnxk_gpiochip *gpiochip, uint16_t queue)
 }
 
 static bool
-cnxk_gpio_exists(int num)
+cnxk_gpio_available(struct cnxk_gpio *gpio)
 {
-	char buf[CNXK_GPIO_BUFSZ];
-	struct stat st;
+	struct gpio_v2_line_info info = { .offset = gpio->num };
+	int ret;
 
-	snprintf(buf, sizeof(buf), "%s/gpio%d", CNXK_GPIO_CLASS_PATH, num);
+	ret = cnxk_gpio_gpiochip_ioctl(gpio->gpiochip, GPIO_V2_GET_LINEINFO_IOCTL, &info);
+	if (ret)
+		return false;
 
-	return !stat(buf, &st);
+	return !(info.flags & GPIO_V2_LINE_FLAG_USED);
 }
 
 static int
@@ -368,9 +352,9 @@ cnxk_gpio_queue_setup(struct rte_rawdev *dev, uint16_t queue_id,
 		      rte_rawdev_obj_t queue_conf, size_t queue_conf_size)
 {
 	struct cnxk_gpiochip *gpiochip = dev->dev_private;
-	char buf[CNXK_GPIO_BUFSZ];
+	struct gpio_v2_line_request req = {0};
 	struct cnxk_gpio *gpio;
-	int num, ret;
+	int ret;
 
 	RTE_SET_USED(queue_conf);
 	RTE_SET_USED(queue_conf_size);
@@ -386,33 +370,87 @@ cnxk_gpio_queue_setup(struct rte_rawdev *dev, uint16_t queue_id,
 	if (!gpio)
 		return -ENOMEM;
 
-	num = cnxk_queue_to_gpio(gpiochip, queue_id);
-	gpio->num = num + gpiochip->base;
+	gpio->num = cnxk_queue_to_gpio(gpiochip, queue_id);
+	gpio->fd = CNXK_GPIO_INVALID_FD;
 	gpio->gpiochip = gpiochip;
 
-	if (!cnxk_gpio_exists(gpio->num)) {
-		snprintf(buf, sizeof(buf), "%s/export", CNXK_GPIO_CLASS_PATH);
-		ret = cnxk_gpio_write_attr_int(buf, gpio->num);
-		if (ret) {
-			rte_free(gpio);
-			return ret;
-		}
-	} else {
-		CNXK_GPIO_LOG(WARNING, "using existing gpio%d", gpio->num);
+	if (!cnxk_gpio_available(gpio)) {
+		rte_free(gpio);
+		return -EBUSY;
+	}
+
+	cnxk_gpio_format_name(req.consumer, sizeof(req.consumer));
+	req.offsets[req.num_lines] = gpio->num;
+	req.num_lines = 1;
+
+	ret = cnxk_gpio_gpiochip_ioctl(gpio->gpiochip, GPIO_V2_GET_LINE_IOCTL, &req);
+	if (ret) {
+		rte_free(gpio);
+		return ret;
+	}
+
+	gpio->fd = req.fd;
+	gpiochip->gpios[gpio->num] = gpio;
+
+	return 0;
+}
+
+static void
+cnxk_gpio_intr_handler(void *data)
+{
+	struct gpio_v2_line_event event;
+	struct cnxk_gpio *gpio = data;
+	int ret;
+
+	ret = read(gpio->fd, &event, sizeof(event));
+	if (ret != sizeof(event)) {
+		CNXK_GPIO_LOG(ERR, "failed to read gpio%d event data", gpio->num);
+		goto out;
+	}
+	if ((unsigned int)gpio->num != event.offset) {
+		CNXK_GPIO_LOG(ERR, "expected event from gpio%d, received from gpio%d",
+			      gpio->num, event.offset);
+		goto out;
 	}
 
-	gpiochip->gpios[num] = gpio;
+	if (gpio->intr.handler2)
+		(gpio->intr.handler2)(&event, gpio->intr.data);
+	else if (gpio->intr.handler)
+		(gpio->intr.handler)(gpio->num, gpio->intr.data);
+out:
+	rte_intr_ack(gpio->intr.intr_handle);
+}
+
+static int
+cnxk_gpio_unregister_irq(struct cnxk_gpio *gpio)
+{
+	int ret;
+
+	if (!gpio->intr.intr_handle)
+		return 0;
+
+	ret = rte_intr_disable(gpio->intr.intr_handle);
+	if (ret)
+		return ret;
+
+	ret = rte_intr_callback_unregister_sync(gpio->intr.intr_handle, cnxk_gpio_intr_handler,
+						(void *)-1);
+	if (ret)
+		return ret;
+
+	rte_intr_instance_free(gpio->intr.intr_handle);
+	gpio->intr.intr_handle = NULL;
 
 	return 0;
 }
 
+
 static int
 cnxk_gpio_queue_release(struct rte_rawdev *dev, uint16_t queue_id)
 {
 	struct cnxk_gpiochip *gpiochip = dev->dev_private;
-	char buf[CNXK_GPIO_BUFSZ];
 	struct cnxk_gpio *gpio;
-	int num, ret;
+	int num;
 
 	if (!cnxk_gpio_queue_valid(gpiochip, queue_id))
 		return -EINVAL;
@@ -421,10 +459,11 @@ cnxk_gpio_queue_release(struct rte_rawdev *dev, uint16_t queue_id)
 	if (!gpio)
 		return -ENODEV;
 
-	snprintf(buf, sizeof(buf), "%s/unexport", CNXK_GPIO_CLASS_PATH);
-	ret = cnxk_gpio_write_attr_int(buf, gpio->num);
-	if (ret)
-		return ret;
+	if (gpio->intr.intr_handle)
+		cnxk_gpio_unregister_irq(gpio);
+
+	if (gpio->fd != CNXK_GPIO_INVALID_FD)
+		close(gpio->fd);
 
 	num = cnxk_queue_to_gpio(gpiochip, queue_id);
 	gpiochip->gpios[num] = NULL;
@@ -462,134 +501,218 @@ cnxk_gpio_queue_count(struct rte_rawdev *dev)
 
 static const struct {
 	enum cnxk_gpio_pin_edge edge;
-	const char *name;
-} cnxk_gpio_edge_name[] = {
-	{ CNXK_GPIO_PIN_EDGE_NONE, "none" },
-	{ CNXK_GPIO_PIN_EDGE_FALLING, "falling" },
-	{ CNXK_GPIO_PIN_EDGE_RISING, "rising" },
-	{ CNXK_GPIO_PIN_EDGE_BOTH, "both" },
+	enum gpio_v2_line_flag flag;
+} cnxk_gpio_edge_flag[] = {
+	{ CNXK_GPIO_PIN_EDGE_NONE, 0 },
+	{ CNXK_GPIO_PIN_EDGE_FALLING, GPIO_V2_LINE_FLAG_EDGE_FALLING },
+	{ CNXK_GPIO_PIN_EDGE_RISING, GPIO_V2_LINE_FLAG_EDGE_RISING },
+	{ CNXK_GPIO_PIN_EDGE_BOTH, GPIO_V2_LINE_FLAG_EDGE_FALLING | GPIO_V2_LINE_FLAG_EDGE_RISING },
 };
 
-static const char *
-cnxk_gpio_edge_to_name(enum cnxk_gpio_pin_edge edge)
+static enum gpio_v2_line_flag
+cnxk_gpio_edge_to_flag(enum cnxk_gpio_pin_edge edge)
 {
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(cnxk_gpio_edge_name); i++) {
-		if (cnxk_gpio_edge_name[i].edge == edge)
-			return cnxk_gpio_edge_name[i].name;
+	for (i = 0; i < RTE_DIM(cnxk_gpio_edge_flag); i++) {
+		if (cnxk_gpio_edge_flag[i].edge == edge)
+			break;
 	}
 
-	return NULL;
+	return cnxk_gpio_edge_flag[i].flag;
 }
 
 static enum cnxk_gpio_pin_edge
-cnxk_gpio_name_to_edge(const char *name)
+cnxk_gpio_flag_to_edge(enum gpio_v2_line_flag flag)
 {
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(cnxk_gpio_edge_name); i++) {
-		if (!strcmp(cnxk_gpio_edge_name[i].name, name))
+	for (i = 0; i < RTE_DIM(cnxk_gpio_edge_flag); i++) {
+		if ((cnxk_gpio_edge_flag[i].flag & flag) == cnxk_gpio_edge_flag[i].flag)
 			break;
 	}
 
-	return cnxk_gpio_edge_name[i].edge;
+	return cnxk_gpio_edge_flag[i].edge;
 }
 
 static const struct {
 	enum cnxk_gpio_pin_dir dir;
-	const char *name;
-} cnxk_gpio_dir_name[] = {
-	{ CNXK_GPIO_PIN_DIR_IN, "in" },
-	{ CNXK_GPIO_PIN_DIR_OUT, "out" },
-	{ CNXK_GPIO_PIN_DIR_HIGH, "high" },
-	{ CNXK_GPIO_PIN_DIR_LOW, "low" },
+	enum gpio_v2_line_flag flag;
+} cnxk_gpio_dir_flag[] = {
+	{ CNXK_GPIO_PIN_DIR_IN, GPIO_V2_LINE_FLAG_INPUT },
+	{ CNXK_GPIO_PIN_DIR_OUT, GPIO_V2_LINE_FLAG_OUTPUT },
+	{ CNXK_GPIO_PIN_DIR_HIGH, GPIO_V2_LINE_FLAG_OUTPUT },
+	{ CNXK_GPIO_PIN_DIR_LOW, GPIO_V2_LINE_FLAG_OUTPUT },
 };
 
-static const char *
-cnxk_gpio_dir_to_name(enum cnxk_gpio_pin_dir dir)
+static enum gpio_v2_line_flag
+cnxk_gpio_dir_to_flag(enum cnxk_gpio_pin_dir dir)
 {
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(cnxk_gpio_dir_name); i++) {
-		if (cnxk_gpio_dir_name[i].dir == dir)
-			return cnxk_gpio_dir_name[i].name;
+	for (i = 0; i < RTE_DIM(cnxk_gpio_dir_flag); i++) {
+		if (cnxk_gpio_dir_flag[i].dir == dir)
+			break;
 	}
 
-	return NULL;
+	return cnxk_gpio_dir_flag[i].flag;
 }
 
 static enum cnxk_gpio_pin_dir
-cnxk_gpio_name_to_dir(const char *name)
+cnxk_gpio_flag_to_dir(enum gpio_v2_line_flag flag)
 {
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(cnxk_gpio_dir_name); i++) {
-		if (!strcmp(cnxk_gpio_dir_name[i].name, name))
+	for (i = 0; i < RTE_DIM(cnxk_gpio_dir_flag); i++) {
+		if ((cnxk_gpio_dir_flag[i].flag & flag) == cnxk_gpio_dir_flag[i].flag)
 			break;
 	}
 
-	return cnxk_gpio_dir_name[i].dir;
+	return cnxk_gpio_dir_flag[i].dir;
 }
 
 static int
-cnxk_gpio_register_irq(struct cnxk_gpio *gpio, struct cnxk_gpio_irq *irq)
+cnxk_gpio_register_irq_compat(struct cnxk_gpio *gpio, struct cnxk_gpio_irq *irq,
+			      struct cnxk_gpio_irq2 *irq2)
 {
+	struct rte_intr_handle *intr_handle;
 	int ret;
 
-	ret = cnxk_gpio_irq_request(gpio->num - gpio->gpiochip->base, irq->cpu);
-	if (ret)
-		return ret;
+	if (!irq && !irq2)
+		return -EINVAL;
+
+	if ((irq && !irq->handler) || (irq2 && !irq2->handler))
+		return -EINVAL;
+
+	if (gpio->intr.intr_handle)
+		return -EEXIST;
+
+	intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (!intr_handle)
+		return -ENOMEM;
+
+	if (rte_intr_type_set(intr_handle, RTE_INTR_HANDLE_VDEV)) {
+		ret = -rte_errno;
+		goto out;
+	}
+
+	if (rte_intr_fd_set(intr_handle, gpio->fd)) {
+		ret = -rte_errno;
+		goto out;
+	}
+
+	if (rte_intr_callback_register(intr_handle, cnxk_gpio_intr_handler, gpio)) {
+		ret = -rte_errno;
+		goto out;
+	}
 
-	gpio->handler = irq->handler;
-	gpio->data = irq->data;
-	gpio->cpu = irq->cpu;
+	gpio->intr.intr_handle = intr_handle;
+
+	if (irq) {
+		gpio->intr.data = irq->data;
+		gpio->intr.handler = irq->handler;
+	} else {
+		gpio->intr.data = irq2->data;
+		gpio->intr.handler2 = irq2->handler;
+	}
+
+	if (rte_intr_enable(gpio->intr.intr_handle)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	return 0;
+out:
+	rte_intr_instance_free(intr_handle);
+
+	return ret;
 }
 
 static int
-cnxk_gpio_unregister_irq(struct cnxk_gpio *gpio)
+cnxk_gpio_register_irq(struct cnxk_gpio *gpio, struct cnxk_gpio_irq *irq)
+{
+	CNXK_GPIO_LOG(WARNING, "using deprecated interrupt registration api");
+
+	return cnxk_gpio_register_irq_compat(gpio, irq, NULL);
+}
+
+static int
+cnxk_gpio_register_irq2(struct cnxk_gpio *gpio, struct cnxk_gpio_irq2 *irq)
 {
-	return cnxk_gpio_irq_free(gpio->num - gpio->gpiochip->base);
+	return cnxk_gpio_register_irq_compat(gpio, NULL, irq);
 }
 
 static int
 cnxk_gpio_process_buf(struct cnxk_gpio *gpio, struct rte_rawdev_buf *rbuf)
 {
 	struct cnxk_gpio_msg *msg = rbuf->buf_addr;
+	struct gpio_v2_line_values values = {0};
+	struct gpio_v2_line_config config = {0};
+	struct gpio_v2_line_info info = {0};
 	enum cnxk_gpio_pin_edge edge;
 	enum cnxk_gpio_pin_dir dir;
-	char buf[CNXK_GPIO_BUFSZ];
 	void *rsp = NULL;
-	int ret, val, n;
+	int ret;
+
+	info.offset = gpio->num;
+	ret = cnxk_gpio_gpiochip_ioctl(gpio->gpiochip, GPIO_V2_GET_LINEINFO_IOCTL, &info);
+	if (ret)
+		return ret;
 
-	n = snprintf(buf, sizeof(buf), "%s/gpio%d", CNXK_GPIO_CLASS_PATH,
-		     gpio->num);
+	info.flags &= ~GPIO_V2_LINE_FLAG_USED;
 
 	switch (msg->type) {
 	case CNXK_GPIO_MSG_TYPE_SET_PIN_VALUE:
-		snprintf(buf + n, sizeof(buf) - n, "/value");
-		ret = cnxk_gpio_write_attr_int(buf, !!*(int *)msg->data);
+		values.bits = *(int *)msg->data ?  RTE_BIT64(gpio->num) : 0;
+		values.mask = RTE_BIT64(gpio->num);
+
+		ret = cnxk_gpio_ioctl(gpio, GPIO_V2_LINE_SET_VALUES_IOCTL, &values);
 		break;
 	case CNXK_GPIO_MSG_TYPE_SET_PIN_EDGE:
-		snprintf(buf + n, sizeof(buf) - n, "/edge");
 		edge = *(enum cnxk_gpio_pin_edge *)msg->data;
-		ret = cnxk_gpio_write_attr(buf, cnxk_gpio_edge_to_name(edge));
+		info.flags &= ~(GPIO_V2_LINE_FLAG_EDGE_RISING | GPIO_V2_LINE_FLAG_EDGE_FALLING);
+		info.flags |= cnxk_gpio_edge_to_flag(edge);
+
+		config.attrs[config.num_attrs].attr.id = GPIO_V2_LINE_ATTR_ID_FLAGS;
+		config.attrs[config.num_attrs].attr.flags = info.flags;
+		config.attrs[config.num_attrs].mask = RTE_BIT64(gpio->num);
+		config.num_attrs++;
+
+		ret = cnxk_gpio_ioctl(gpio, GPIO_V2_LINE_SET_CONFIG_IOCTL, &config);
 		break;
 	case CNXK_GPIO_MSG_TYPE_SET_PIN_DIR:
-		snprintf(buf + n, sizeof(buf) - n, "/direction");
 		dir = *(enum cnxk_gpio_pin_dir *)msg->data;
-		ret = cnxk_gpio_write_attr(buf, cnxk_gpio_dir_to_name(dir));
+		config.attrs[config.num_attrs].attr.id = GPIO_V2_LINE_ATTR_ID_FLAGS;
+		config.attrs[config.num_attrs].attr.flags = cnxk_gpio_dir_to_flag(dir);
+		config.attrs[config.num_attrs].mask = RTE_BIT64(gpio->num);
+		config.num_attrs++;
+
+		if (dir == CNXK_GPIO_PIN_DIR_HIGH || dir == CNXK_GPIO_PIN_DIR_LOW) {
+			config.attrs[config.num_attrs].attr.id = GPIO_V2_LINE_ATTR_ID_OUTPUT_VALUES;
+			config.attrs[config.num_attrs].attr.values = dir == CNXK_GPIO_PIN_DIR_HIGH ?
+								     RTE_BIT64(gpio->num) : 0;
+			config.attrs[config.num_attrs].mask = RTE_BIT64(gpio->num);
+			config.num_attrs++;
+		}
+
+		ret = cnxk_gpio_ioctl(gpio, GPIO_V2_LINE_SET_CONFIG_IOCTL, &config);
 		break;
 	case CNXK_GPIO_MSG_TYPE_SET_PIN_ACTIVE_LOW:
-		snprintf(buf + n, sizeof(buf) - n, "/active_low");
-		val = *(int *)msg->data;
-		ret = cnxk_gpio_write_attr_int(buf, val);
+		if (*(int *)msg->data)
+			info.flags |= GPIO_V2_LINE_FLAG_ACTIVE_LOW;
+		else
+			info.flags &= ~GPIO_V2_LINE_FLAG_ACTIVE_LOW;
+
+		config.attrs[config.num_attrs].attr.id = GPIO_V2_LINE_ATTR_ID_FLAGS;
+		config.attrs[config.num_attrs].attr.flags = info.flags;
+		config.attrs[config.num_attrs].mask = RTE_BIT64(gpio->num);
+		config.num_attrs++;
+
+		ret = cnxk_gpio_ioctl(gpio, GPIO_V2_LINE_SET_CONFIG_IOCTL, &config);
 		break;
 	case CNXK_GPIO_MSG_TYPE_GET_PIN_VALUE:
-		snprintf(buf + n, sizeof(buf) - n, "/value");
-		ret = cnxk_gpio_read_attr_int(buf, &val);
+		values.mask = RTE_BIT64(gpio->num);
+		ret = cnxk_gpio_ioctl(gpio, GPIO_V2_LINE_GET_VALUES_IOCTL, &values);
 		if (ret)
 			break;
 
@@ -597,47 +720,35 @@ cnxk_gpio_process_buf(struct cnxk_gpio *gpio, struct rte_rawdev_buf *rbuf)
 		if (!rsp)
 			return -ENOMEM;
 
-		*(int *)rsp = val;
+		*(int *)rsp = !!(values.bits & RTE_BIT64(gpio->num));
 		break;
 	case CNXK_GPIO_MSG_TYPE_GET_PIN_EDGE:
-		snprintf(buf + n, sizeof(buf) - n, "/edge");
-		ret = cnxk_gpio_read_attr(buf, buf);
-		if (ret)
-			break;
-
 		rsp = rte_zmalloc(NULL, sizeof(enum cnxk_gpio_pin_edge), 0);
 		if (!rsp)
 			return -ENOMEM;
 
-		*(enum cnxk_gpio_pin_edge *)rsp = cnxk_gpio_name_to_edge(buf);
+		*(enum cnxk_gpio_pin_edge *)rsp = cnxk_gpio_flag_to_edge(info.flags);
 		break;
 	case CNXK_GPIO_MSG_TYPE_GET_PIN_DIR:
-		snprintf(buf + n, sizeof(buf) - n, "/direction");
-		ret = cnxk_gpio_read_attr(buf, buf);
-		if (ret)
-			break;
-
-		rsp = rte_zmalloc(NULL, sizeof(enum cnxk_gpio_pin_dir), 0);
+		rsp = rte_zmalloc(NULL, sizeof(enum cnxk_gpio_pin_edge), 0);
 		if (!rsp)
 			return -ENOMEM;
 
-		*(enum cnxk_gpio_pin_dir *)rsp = cnxk_gpio_name_to_dir(buf);
+		*(enum cnxk_gpio_pin_dir *)rsp = cnxk_gpio_flag_to_dir(info.flags);
 		break;
 	case CNXK_GPIO_MSG_TYPE_GET_PIN_ACTIVE_LOW:
-		snprintf(buf + n, sizeof(buf) - n, "/active_low");
-		ret = cnxk_gpio_read_attr_int(buf, &val);
-		if (ret)
-			break;
-
 		rsp = rte_zmalloc(NULL, sizeof(int), 0);
 		if (!rsp)
 			return -ENOMEM;
 
-		*(int *)rsp = val;
+		*(int *)rsp = !!(info.flags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
 		break;
 	case CNXK_GPIO_MSG_TYPE_REGISTER_IRQ:
 		ret = cnxk_gpio_register_irq(gpio, (struct cnxk_gpio_irq *)msg->data);
 		break;
+	case CNXK_GPIO_MSG_TYPE_REGISTER_IRQ2:
+		ret = cnxk_gpio_register_irq2(gpio, (struct cnxk_gpio_irq2 *)msg->data);
+		break;
 	case CNXK_GPIO_MSG_TYPE_UNREGISTER_IRQ:
 		ret = cnxk_gpio_unregister_irq(gpio);
 		break;
@@ -731,11 +842,11 @@ static const struct rte_rawdev_ops cnxk_gpio_rawdev_ops = {
 static int
 cnxk_gpio_probe(struct rte_vdev_device *dev)
 {
+	struct gpiochip_info gpiochip_info;
 	char name[RTE_RAWDEV_NAME_MAX_LEN];
 	struct cnxk_gpio_params *params;
 	struct cnxk_gpiochip *gpiochip;
 	struct rte_rawdev *rawdev;
-	char buf[CNXK_GPIO_BUFSZ];
 	int ret;
 
 	cnxk_gpio_format_name(name, sizeof(name));
@@ -762,25 +873,14 @@ cnxk_gpio_probe(struct rte_vdev_device *dev)
 
 	gpiochip->num = params->num;
 
-	ret = cnxk_gpio_irq_init(gpiochip);
-	if (ret)
-		goto out;
-
-	/* read gpio base */
-	snprintf(buf, sizeof(buf), "%s/gpiochip%d/base", CNXK_GPIO_CLASS_PATH, gpiochip->num);
-	ret = cnxk_gpio_read_attr_int(buf, &gpiochip->base);
-	if (ret) {
-		CNXK_GPIO_LOG(ERR, "failed to read %s", buf);
-		goto out;
-	}
-
 	/* read number of available gpios */
-	snprintf(buf, sizeof(buf), "%s/gpiochip%d/ngpio", CNXK_GPIO_CLASS_PATH, gpiochip->num);
-	ret = cnxk_gpio_read_attr_int(buf, &gpiochip->num_gpios);
+	ret = cnxk_gpio_gpiochip_ioctl(gpiochip, GPIO_GET_CHIPINFO_IOCTL, &gpiochip_info);
 	if (ret) {
-		CNXK_GPIO_LOG(ERR, "failed to read %s", buf);
+		CNXK_GPIO_LOG(ERR, "failed to read /dev/gpiochip%d info", gpiochip->num);
 		goto out;
 	}
+
+	gpiochip->num_gpios = gpiochip_info.lines;
 	gpiochip->num_queues = gpiochip->num_gpios;
 
 	ret = cnxk_gpio_parse_allowlist(gpiochip, params->allowlist);
@@ -827,15 +927,11 @@ cnxk_gpio_remove(struct rte_vdev_device *dev)
 		if (!gpio)
 			continue;
 
-		if (gpio->handler)
-			cnxk_gpio_unregister_irq(gpio);
-
 		cnxk_gpio_queue_release(rawdev, gpio->num);
 	}
 
 	rte_free(gpiochip->allowlist);
 	rte_free(gpiochip->gpios);
-	cnxk_gpio_irq_fini();
 	cnxk_gpio_params_release();
 	rte_rawdev_pmd_release(rawdev);
 
diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio.h b/drivers/raw/cnxk_gpio/cnxk_gpio.h
index 94c8e36977..adc7f90936 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio.h
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio.h
@@ -11,20 +11,24 @@ extern int cnxk_logtype_gpio;
 #define CNXK_GPIO_LOG(level, ...) \
 	RTE_LOG_LINE(level, CNXK_GPIO, __VA_ARGS__)
 
+struct gpio_v2_line_event;
 struct cnxk_gpiochip;
 
 struct cnxk_gpio {
 	struct cnxk_gpiochip *gpiochip;
+	struct {
+		struct rte_intr_handle *intr_handle;
+		void (*handler)(int gpio, void *data);
+		void (*handler2)(struct gpio_v2_line_event *event, void *data);
+		void *data;
+	} intr;
 	void *rsp;
 	int num;
-	void (*handler)(int gpio, void *data);
-	void *data;
-	int cpu;
+	int fd;
 };
 
 struct cnxk_gpiochip {
 	int num;
-	int base;
 	int num_gpios;
 	int num_queues;
 	struct cnxk_gpio **gpios;
@@ -33,9 +37,4 @@ struct cnxk_gpiochip {
 
 int cnxk_gpio_selftest(uint16_t dev_id);
 
-int cnxk_gpio_irq_init(struct cnxk_gpiochip *gpiochip);
-void cnxk_gpio_irq_fini(void);
-int cnxk_gpio_irq_request(int gpio, int cpu);
-int cnxk_gpio_irq_free(int gpio);
-
 #endif /* _CNXK_GPIO_H_ */
diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio_irq.c b/drivers/raw/cnxk_gpio/cnxk_gpio_irq.c
deleted file mode 100644
index 2fa8e69899..0000000000
--- a/drivers/raw/cnxk_gpio/cnxk_gpio_irq.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(C) 2021 Marvell.
- */
-
-#include <fcntl.h>
-#include <pthread.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <sys/queue.h>
-#include <unistd.h>
-
-#include <rte_rawdev_pmd.h>
-
-#include <roc_api.h>
-
-#include "cnxk_gpio.h"
-
-#define OTX_IOC_MAGIC 0xF2
-#define OTX_IOC_SET_GPIO_HANDLER                                               \
-	_IOW(OTX_IOC_MAGIC, 1, struct otx_gpio_usr_data)
-#define OTX_IOC_CLR_GPIO_HANDLER                                               \
-	_IO(OTX_IOC_MAGIC, 2)
-
-struct otx_gpio_usr_data {
-	uint64_t isr_base;
-	uint64_t sp;
-	uint64_t cpu;
-	uint64_t gpio_num;
-};
-
-struct cnxk_gpio_irq_stack {
-	LIST_ENTRY(cnxk_gpio_irq_stack) next;
-	void *sp_buffer;
-	int cpu;
-	int inuse;
-};
-
-struct cnxk_gpio_irqchip {
-	int fd;
-	/* serialize access to this struct */
-	pthread_mutex_t lock;
-	LIST_HEAD(, cnxk_gpio_irq_stack) stacks;
-
-	struct cnxk_gpiochip *gpiochip;
-};
-
-static struct cnxk_gpio_irqchip *irqchip;
-
-static void
-cnxk_gpio_irq_stack_free(int cpu)
-{
-	struct cnxk_gpio_irq_stack *stack;
-
-	LIST_FOREACH(stack, &irqchip->stacks, next) {
-		if (stack->cpu == cpu)
-			break;
-	}
-
-	if (!stack)
-		return;
-
-	if (stack->inuse)
-		stack->inuse--;
-
-	if (stack->inuse == 0) {
-		LIST_REMOVE(stack, next);
-		rte_free(stack->sp_buffer);
-		rte_free(stack);
-	}
-}
-
-static void *
-cnxk_gpio_irq_stack_alloc(int cpu)
-{
-#define ARM_STACK_ALIGNMENT (2 * sizeof(void *))
-#define IRQ_STACK_SIZE 0x200000
-
-	struct cnxk_gpio_irq_stack *stack;
-
-	LIST_FOREACH(stack, &irqchip->stacks, next) {
-		if (stack->cpu == cpu)
-			break;
-	}
-
-	if (stack) {
-		stack->inuse++;
-		return (char *)stack->sp_buffer + IRQ_STACK_SIZE;
-	}
-
-	stack = rte_malloc(NULL, sizeof(*stack), 0);
-	if (!stack)
-		return NULL;
-
-	stack->sp_buffer =
-		rte_zmalloc(NULL, IRQ_STACK_SIZE * 2, ARM_STACK_ALIGNMENT);
-	if (!stack->sp_buffer) {
-		rte_free(stack);
-		return NULL;
-	}
-
-	stack->cpu = cpu;
-	stack->inuse = 1;
-	LIST_INSERT_HEAD(&irqchip->stacks, stack, next);
-
-	return (char *)stack->sp_buffer + IRQ_STACK_SIZE;
-}
-
-static void
-cnxk_gpio_irq_handler(int gpio_num)
-{
-	struct cnxk_gpiochip *gpiochip = irqchip->gpiochip;
-	struct cnxk_gpio *gpio;
-
-	if (gpio_num >= gpiochip->num_gpios)
-		goto out;
-
-	gpio = gpiochip->gpios[gpio_num];
-	if (likely(gpio->handler))
-		gpio->handler(gpio_num, gpio->data);
-
-out:
-	roc_atf_ret();
-}
-
-int
-cnxk_gpio_irq_init(struct cnxk_gpiochip *gpiochip)
-{
-	if (irqchip)
-		return 0;
-
-	irqchip = rte_zmalloc(NULL, sizeof(*irqchip), 0);
-	if (!irqchip)
-		return -ENOMEM;
-
-	irqchip->fd = open("/dev/otx-gpio-ctr", O_RDWR | O_SYNC);
-	if (irqchip->fd < 0) {
-		rte_free(irqchip);
-		return -errno;
-	}
-
-	pthread_mutex_init(&irqchip->lock, NULL);
-	LIST_INIT(&irqchip->stacks);
-	irqchip->gpiochip = gpiochip;
-
-	return 0;
-}
-
-void
-cnxk_gpio_irq_fini(void)
-{
-	if (!irqchip)
-		return;
-
-	close(irqchip->fd);
-	rte_free(irqchip);
-	irqchip = NULL;
-}
-
-int
-cnxk_gpio_irq_request(int gpio, int cpu)
-{
-	struct otx_gpio_usr_data data;
-	void *sp;
-	int ret;
-
-	pthread_mutex_lock(&irqchip->lock);
-
-	sp = cnxk_gpio_irq_stack_alloc(cpu);
-	if (!sp) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
-
-	data.isr_base = (uint64_t)cnxk_gpio_irq_handler;
-	data.sp = (uint64_t)sp;
-	data.cpu = (uint64_t)cpu;
-	data.gpio_num = (uint64_t)gpio;
-
-	mlockall(MCL_CURRENT | MCL_FUTURE);
-	ret = ioctl(irqchip->fd, OTX_IOC_SET_GPIO_HANDLER, &data);
-	if (ret) {
-		ret = -errno;
-		goto out_free_stack;
-	}
-
-	pthread_mutex_unlock(&irqchip->lock);
-
-	return 0;
-
-out_free_stack:
-	cnxk_gpio_irq_stack_free(cpu);
-out_unlock:
-	pthread_mutex_unlock(&irqchip->lock);
-
-	return ret;
-}
-
-int
-cnxk_gpio_irq_free(int gpio)
-{
-	int ret;
-
-	pthread_mutex_lock(&irqchip->lock);
-
-	ret = ioctl(irqchip->fd, OTX_IOC_CLR_GPIO_HANDLER, gpio);
-	if (ret) {
-		pthread_mutex_unlock(&irqchip->lock);
-		return -errno;
-	}
-
-	cnxk_gpio_irq_stack_free(irqchip->gpiochip->gpios[gpio]->cpu);
-
-	pthread_mutex_unlock(&irqchip->lock);
-
-	return 0;
-}
diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c b/drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c
index a0d9942f20..4e04811fe5 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c
@@ -8,97 +8,27 @@
 #include <unistd.h>
 
 #include <rte_cycles.h>
+#include <rte_io.h>
 #include <rte_rawdev.h>
 #include <rte_rawdev_pmd.h>
-#include <rte_service.h>
 
 #include "cnxk_gpio.h"
 #include "rte_pmd_cnxk_gpio.h"
 
-#define CNXK_GPIO_BUFSZ 128
-
-#define OTX_IOC_MAGIC 0xF2
-#define OTX_IOC_TRIGGER_GPIO_HANDLER                                           \
-	_IO(OTX_IOC_MAGIC, 3)
-
-static int fd;
-
-static int
-cnxk_gpio_attr_exists(const char *attr)
-{
-	struct stat st;
-
-	return !stat(attr, &st);
-}
-
-static int
-cnxk_gpio_read_attr(char *attr, char *val)
-{
-	int ret, ret2;
-	FILE *fp;
-
-	fp = fopen(attr, "r");
-	if (!fp)
-		return -errno;
-
-	ret = fscanf(fp, "%s", val);
-	if (ret < 0) {
-		ret = -errno;
-		goto out;
-	}
-	if (ret != 1) {
-		ret = -EIO;
-		goto out;
-	}
-
-	ret = 0;
-out:
-	ret2 = fclose(fp);
-	if (!ret)
-		ret = ret2;
-
-	return ret;
-}
-
-#define CNXK_GPIO_ERR_STR(err, str, ...) do {                                  \
-	if (err) {                                                             \
-		CNXK_GPIO_LOG(ERR, "%s:%d: " str " (%d)", __func__, __LINE__, \
-			##__VA_ARGS__, err);                                   \
-		goto out;                                                      \
-	}                                                                      \
+#define CNXK_GPIO_ERR_STR(err, str, ...) do {                                                      \
+	if (err) {                                                                                 \
+		CNXK_GPIO_LOG(ERR, "%s:%d: " str " (%d)", __func__, __LINE__, ##__VA_ARGS__, err); \
+		goto out;                                                                          \
+	}                                                                                          \
 } while (0)
 
 static int
-cnxk_gpio_validate_attr(char *attr, const char *expected)
+cnxk_gpio_test_input(uint16_t dev_id, int gpio)
 {
-	char buf[CNXK_GPIO_BUFSZ];
 	int ret;
 
-	ret = cnxk_gpio_read_attr(attr, buf);
-	if (ret)
-		return ret;
-
-	if (strncmp(buf, expected, sizeof(buf)))
-		return -EIO;
-
-	return 0;
-}
-
-#define CNXK_GPIO_PATH_FMT "/sys/class/gpio/gpio%d"
-
-static int
-cnxk_gpio_test_input(uint16_t dev_id, int base, int gpio)
-{
-	char buf[CNXK_GPIO_BUFSZ];
-	int ret, n;
-
-	n = snprintf(buf, sizeof(buf), CNXK_GPIO_PATH_FMT, base + gpio);
-	snprintf(buf + n, sizeof(buf) - n, "/direction");
-
 	ret = rte_pmd_gpio_set_pin_dir(dev_id, gpio, CNXK_GPIO_PIN_DIR_IN);
 	CNXK_GPIO_ERR_STR(ret, "failed to set dir to input");
-	ret = cnxk_gpio_validate_attr(buf, "in");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
 	ret = rte_pmd_gpio_set_pin_value(dev_id, gpio, 1) |
 	      rte_pmd_gpio_set_pin_value(dev_id, gpio, 0);
@@ -107,29 +37,17 @@ cnxk_gpio_test_input(uint16_t dev_id, int base, int gpio)
 		CNXK_GPIO_ERR_STR(ret, "input pin overwritten");
 	}
 
-	snprintf(buf + n, sizeof(buf) - n, "/edge");
-
-	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio,
-					CNXK_GPIO_PIN_EDGE_FALLING);
+	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio, CNXK_GPIO_PIN_EDGE_FALLING);
 	CNXK_GPIO_ERR_STR(ret, "failed to set edge to falling");
-	ret = cnxk_gpio_validate_attr(buf, "falling");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
-	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio,
-					CNXK_GPIO_PIN_EDGE_RISING);
+	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio, CNXK_GPIO_PIN_EDGE_RISING);
 	CNXK_GPIO_ERR_STR(ret, "failed to change edge to rising");
-	ret = cnxk_gpio_validate_attr(buf, "rising");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
 	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio, CNXK_GPIO_PIN_EDGE_BOTH);
 	CNXK_GPIO_ERR_STR(ret, "failed to change edge to both");
-	ret = cnxk_gpio_validate_attr(buf, "both");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
 	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio, CNXK_GPIO_PIN_EDGE_NONE);
 	CNXK_GPIO_ERR_STR(ret, "failed to set edge to none");
-	ret = cnxk_gpio_validate_attr(buf, "none");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
 	/*
 	 * calling this makes sure kernel driver switches off inverted
@@ -141,44 +59,36 @@ cnxk_gpio_test_input(uint16_t dev_id, int base, int gpio)
 	return ret;
 }
 
-static int
-cnxk_gpio_trigger_irq(int gpio)
-{
-	int ret;
-
-	ret = ioctl(fd, OTX_IOC_TRIGGER_GPIO_HANDLER, gpio);
-
-	return ret == -1 ? -errno : 0;
-}
+static uint32_t triggered;
 
 static void
-cnxk_gpio_irq_handler(int gpio, void *data)
+cnxk_gpio_irq_handler(struct gpio_v2_line_event *event, void *data)
 {
-	*(int *)data = gpio;
+	int gpio = (int)(size_t)data;
+
+	if ((int)event->offset != gpio)
+		CNXK_GPIO_LOG(ERR, "event from gpio%d instead of gpio%d", event->offset, gpio);
+
+	rte_write32(1, &triggered);
 }
 
 static int
 cnxk_gpio_test_irq(uint16_t dev_id, int gpio)
 {
-	int irq_data, ret;
+	int ret;
 
 	ret = rte_pmd_gpio_set_pin_dir(dev_id, gpio, CNXK_GPIO_PIN_DIR_IN);
 	CNXK_GPIO_ERR_STR(ret, "failed to set dir to input");
 
-	irq_data = 0;
-	ret = rte_pmd_gpio_register_irq(dev_id, gpio, rte_lcore_id(),
-					cnxk_gpio_irq_handler, &irq_data);
+	ret = rte_pmd_gpio_register_irq2(dev_id, gpio, cnxk_gpio_irq_handler, (int *)(size_t)gpio);
 	CNXK_GPIO_ERR_STR(ret, "failed to register irq handler");
 
-	ret = rte_pmd_gpio_enable_interrupt(dev_id, gpio,
-					    CNXK_GPIO_PIN_EDGE_RISING);
+	ret = rte_pmd_gpio_enable_interrupt(dev_id, gpio, CNXK_GPIO_PIN_EDGE_RISING);
 	CNXK_GPIO_ERR_STR(ret, "failed to enable interrupt");
 
-	ret = cnxk_gpio_trigger_irq(gpio);
-	CNXK_GPIO_ERR_STR(ret, "failed to trigger irq");
-	rte_delay_ms(1);
-	ret = *(volatile int *)&irq_data == gpio ? 0 : -EIO;
-	CNXK_GPIO_ERR_STR(ret, "failed to test irq");
+	rte_delay_ms(2);
+	rte_read32(&triggered);
+	CNXK_GPIO_ERR_STR(!triggered, "failed to trigger irq");
 
 	ret = rte_pmd_gpio_disable_interrupt(dev_id, gpio);
 	CNXK_GPIO_ERR_STR(ret, "failed to disable interrupt");
@@ -193,24 +103,15 @@ cnxk_gpio_test_irq(uint16_t dev_id, int gpio)
 }
 
 static int
-cnxk_gpio_test_output(uint16_t dev_id, int base, int gpio)
+cnxk_gpio_test_output(uint16_t dev_id, int gpio)
 {
-	char buf[CNXK_GPIO_BUFSZ];
-	int ret, val, n;
+	int ret, val;
 
-	n = snprintf(buf, sizeof(buf), CNXK_GPIO_PATH_FMT, base + gpio);
-
-	snprintf(buf + n, sizeof(buf) - n, "/direction");
 	ret = rte_pmd_gpio_set_pin_dir(dev_id, gpio, CNXK_GPIO_PIN_DIR_OUT);
 	CNXK_GPIO_ERR_STR(ret, "failed to set dir to out");
-	ret = cnxk_gpio_validate_attr(buf, "out");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
-	snprintf(buf + n, sizeof(buf) - n, "/value");
 	ret = rte_pmd_gpio_set_pin_value(dev_id, gpio, 0);
 	CNXK_GPIO_ERR_STR(ret, "failed to set value to 0");
-	ret = cnxk_gpio_validate_attr(buf, "0");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 	ret = rte_pmd_gpio_get_pin_value(dev_id, gpio, &val);
 	CNXK_GPIO_ERR_STR(ret, "failed to read value");
 	if (val)
@@ -219,64 +120,41 @@ cnxk_gpio_test_output(uint16_t dev_id, int base, int gpio)
 
 	ret = rte_pmd_gpio_set_pin_value(dev_id, gpio, 1);
 	CNXK_GPIO_ERR_STR(ret, "failed to set value to 1");
-	ret = cnxk_gpio_validate_attr(buf, "1");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 	ret = rte_pmd_gpio_get_pin_value(dev_id, gpio, &val);
 	CNXK_GPIO_ERR_STR(ret, "failed to read value");
 	if (val != 1)
 		ret = -EIO;
 	CNXK_GPIO_ERR_STR(ret, "read %d instead of 1", val);
 
-	snprintf(buf + n, sizeof(buf) - n, "/direction");
 	ret = rte_pmd_gpio_set_pin_dir(dev_id, gpio, CNXK_GPIO_PIN_DIR_LOW);
 	CNXK_GPIO_ERR_STR(ret, "failed to set dir to low");
-	ret = cnxk_gpio_validate_attr(buf, "out");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
-	snprintf(buf + n, sizeof(buf) - n, "/value");
-	ret = cnxk_gpio_validate_attr(buf, "0");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
-	snprintf(buf + n, sizeof(buf) - n, "/direction");
 	ret = rte_pmd_gpio_set_pin_dir(dev_id, gpio, CNXK_GPIO_PIN_DIR_HIGH);
 	CNXK_GPIO_ERR_STR(ret, "failed to set dir to high");
-	ret = cnxk_gpio_validate_attr(buf, "out");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
-	snprintf(buf + n, sizeof(buf) - n, "/value");
-	ret = cnxk_gpio_validate_attr(buf, "1");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
-
-	snprintf(buf + n, sizeof(buf) - n, "/edge");
-	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio,
-					CNXK_GPIO_PIN_EDGE_FALLING);
+	ret = rte_pmd_gpio_get_pin_value(dev_id, gpio, &val);
+	CNXK_GPIO_ERR_STR(ret, "failed to read value");
+	if (val != 1)
+		ret = -EIO;
+	CNXK_GPIO_ERR_STR(ret, "read %d instead of 1", val);
+
+	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio, CNXK_GPIO_PIN_EDGE_FALLING);
 	ret = ret == 0 ? -EIO : 0;
 	CNXK_GPIO_ERR_STR(ret, "changed edge to falling");
-	ret = cnxk_gpio_validate_attr(buf, "none");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
-	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio,
-					CNXK_GPIO_PIN_EDGE_RISING);
+	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio, CNXK_GPIO_PIN_EDGE_RISING);
 	ret = ret == 0 ? -EIO : 0;
 	CNXK_GPIO_ERR_STR(ret, "changed edge to rising");
-	ret = cnxk_gpio_validate_attr(buf, "none");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
 	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio, CNXK_GPIO_PIN_EDGE_BOTH);
 	ret = ret == 0 ? -EIO : 0;
 	CNXK_GPIO_ERR_STR(ret, "changed edge to both");
-	ret = cnxk_gpio_validate_attr(buf, "none");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
 	/* this one should succeed */
 	ret = rte_pmd_gpio_set_pin_edge(dev_id, gpio, CNXK_GPIO_PIN_EDGE_NONE);
 	CNXK_GPIO_ERR_STR(ret, "failed to change edge to none");
-	ret = cnxk_gpio_validate_attr(buf, "none");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
-	snprintf(buf + n, sizeof(buf) - n, "/active_low");
 	ret = rte_pmd_gpio_set_pin_active_low(dev_id, gpio, 1);
 	CNXK_GPIO_ERR_STR(ret, "failed to set active_low to 1");
-	ret = cnxk_gpio_validate_attr(buf, "1");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
 
 	ret = rte_pmd_gpio_get_pin_active_low(dev_id, gpio, &val);
 	CNXK_GPIO_ERR_STR(ret, "failed to read active_low");
@@ -284,23 +162,24 @@ cnxk_gpio_test_output(uint16_t dev_id, int base, int gpio)
 		ret = -EIO;
 	CNXK_GPIO_ERR_STR(ret, "read %d instead of 1", val);
 
-	snprintf(buf + n, sizeof(buf) - n, "/value");
 	ret = rte_pmd_gpio_set_pin_value(dev_id, gpio, 1);
 	CNXK_GPIO_ERR_STR(ret, "failed to set value to 1");
-	ret = cnxk_gpio_validate_attr(buf, "1");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
+	ret = rte_pmd_gpio_get_pin_value(dev_id, gpio, &val);
+	CNXK_GPIO_ERR_STR(ret, "failed to read value");
+	if (val != 1)
+		ret = -EIO;
+	CNXK_GPIO_ERR_STR(ret, "read %d instead of 1", val);
 
 	ret = rte_pmd_gpio_set_pin_value(dev_id, gpio, 0);
 	CNXK_GPIO_ERR_STR(ret, "failed to set value to 0");
-	ret = cnxk_gpio_validate_attr(buf, "0");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
+	ret = rte_pmd_gpio_get_pin_value(dev_id, gpio, &val);
+	CNXK_GPIO_ERR_STR(ret, "failed to read value");
+	if (val != 0)
+		ret = -EIO;
+	CNXK_GPIO_ERR_STR(ret, "read %d instead of 0", val);
 
-	snprintf(buf + n, sizeof(buf) - n, "/active_low");
 	ret = rte_pmd_gpio_set_pin_active_low(dev_id, gpio, 0);
 	CNXK_GPIO_ERR_STR(ret, "failed to set active_low to 0");
-	ret = cnxk_gpio_validate_attr(buf, "0");
-	CNXK_GPIO_ERR_STR(ret, "failed to validate %s", buf);
-
 out:
 	return ret;
 }
@@ -309,17 +188,13 @@ int
 cnxk_gpio_selftest(uint16_t dev_id)
 {
 	struct cnxk_gpio_queue_conf conf;
-	struct cnxk_gpiochip *gpiochip;
-	char buf[CNXK_GPIO_BUFSZ];
 	struct rte_rawdev *rawdev;
 	unsigned int queues, i;
-	struct cnxk_gpio *gpio;
 	int ret, ret2;
 
 	rawdev = rte_rawdev_pmd_get_named_dev("cnxk_gpio");
 	if (!rawdev)
 		return -ENODEV;
-	gpiochip = rawdev->dev_private;
 
 	queues = rte_rawdev_queue_count(dev_id);
 	if (queues == 0)
@@ -329,10 +204,6 @@ cnxk_gpio_selftest(uint16_t dev_id)
 	if (ret)
 		return ret;
 
-	fd = open("/dev/otx-gpio-ctr", O_RDWR | O_SYNC);
-	if (fd < 0)
-		return -errno;
-
 	for (i = 0; i < queues; i++) {
 		ret = rte_rawdev_queue_conf_get(dev_id, i, &conf, sizeof(conf));
 		if (ret) {
@@ -355,15 +226,7 @@ cnxk_gpio_selftest(uint16_t dev_id)
 			goto out;
 		}
 
-		gpio = gpiochip->gpios[conf.gpio];
-		snprintf(buf, sizeof(buf), CNXK_GPIO_PATH_FMT, gpio->num);
-		if (!cnxk_gpio_attr_exists(buf)) {
-			CNXK_GPIO_LOG(ERR, "%s does not exist", buf);
-			ret = -ENOENT;
-			goto release;
-		}
-
-		ret = cnxk_gpio_test_input(dev_id, gpiochip->base, conf.gpio);
+		ret = cnxk_gpio_test_input(dev_id, conf.gpio);
 		if (ret)
 			goto release;
 
@@ -371,7 +234,7 @@ cnxk_gpio_selftest(uint16_t dev_id)
 		if (ret)
 			goto release;
 
-		ret = cnxk_gpio_test_output(dev_id, gpiochip->base, conf.gpio);
+		ret = cnxk_gpio_test_output(dev_id, conf.gpio);
 release:
 		ret2 = ret;
 		ret = rte_rawdev_queue_release(dev_id, i);
@@ -381,12 +244,6 @@ cnxk_gpio_selftest(uint16_t dev_id)
 			break;
 		}
 
-		if (cnxk_gpio_attr_exists(buf)) {
-			CNXK_GPIO_LOG(ERR, "%s still exists", buf);
-			ret = -EIO;
-			break;
-		}
-
 		if (ret2) {
 			ret = ret2;
 			break;
@@ -394,7 +251,6 @@ cnxk_gpio_selftest(uint16_t dev_id)
 	}
 
 out:
-	close(fd);
 	rte_rawdev_stop(dev_id);
 
 	return ret;
diff --git a/drivers/raw/cnxk_gpio/meson.build b/drivers/raw/cnxk_gpio/meson.build
index 9d9a527392..372f3d9f46 100644
--- a/drivers/raw/cnxk_gpio/meson.build
+++ b/drivers/raw/cnxk_gpio/meson.build
@@ -5,7 +5,6 @@
 deps += ['bus_vdev', 'common_cnxk', 'rawdev', 'kvargs']
 sources = files(
         'cnxk_gpio.c',
-        'cnxk_gpio_irq.c',
         'cnxk_gpio_selftest.c',
 )
 headers = files('rte_pmd_cnxk_gpio.h')
diff --git a/drivers/raw/cnxk_gpio/rte_pmd_cnxk_gpio.h b/drivers/raw/cnxk_gpio/rte_pmd_cnxk_gpio.h
index 80a37be9c7..d0b165639c 100644
--- a/drivers/raw/cnxk_gpio/rte_pmd_cnxk_gpio.h
+++ b/drivers/raw/cnxk_gpio/rte_pmd_cnxk_gpio.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_PMD_CNXK_GPIO_H_
 #define _RTE_PMD_CNXK_GPIO_H_
 
+#include <linux/gpio.h>
+
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_rawdev.h>
@@ -48,8 +50,10 @@ enum cnxk_gpio_msg_type {
 	CNXK_GPIO_MSG_TYPE_GET_PIN_DIR,
 	/** Type used to read inverted logic state */
 	CNXK_GPIO_MSG_TYPE_GET_PIN_ACTIVE_LOW,
-	/** Type used to register interrupt handler */
+	/** Type used to register interrupt handler (deprecated) */
 	CNXK_GPIO_MSG_TYPE_REGISTER_IRQ,
+	/** Type used to register interrupt handler */
+	CNXK_GPIO_MSG_TYPE_REGISTER_IRQ2,
 	/** Type used to remove interrupt handler */
 	CNXK_GPIO_MSG_TYPE_UNREGISTER_IRQ,
 };
@@ -79,7 +83,7 @@ enum cnxk_gpio_pin_dir {
 };
 
 /**
- * GPIO interrupt handler
+ * GPIO interrupt handler (deprecated)
  *
  * @param gpio
  *   Zero-based GPIO number
@@ -97,6 +101,23 @@ struct cnxk_gpio_irq {
 	int cpu;
 };
 
+/**
+ * GPIO interrupt handler
+ *
+ * @param event
+ *   Pointer to gpio event data
+ * @param data
+ *   Cookie passed to interrupt handler
+ */
+typedef void (*cnxk_gpio_irq_handler2_t)(struct gpio_v2_line_event *event, void *data);
+
+struct cnxk_gpio_irq2 {
+	/** Interrupt handler */
+	cnxk_gpio_irq_handler2_t handler;
+	/** User data passed to irq handler */
+	void *data;
+};
+
 struct cnxk_gpio_msg {
 	/** Message type */
 	enum cnxk_gpio_msg_type type;
@@ -338,7 +359,7 @@ rte_pmd_gpio_get_pin_active_low(uint16_t dev_id, int gpio, int *val)
 }
 
 /**
- * Attach interrupt handler to GPIO
+ * Attach interrupt handler to GPIO (deprecated)
  *
  * @param dev_id
  *   The identifier of the device
@@ -371,6 +392,36 @@ rte_pmd_gpio_register_irq(uint16_t dev_id, int gpio, int cpu,
 	return __rte_pmd_gpio_enq_deq(dev_id, gpio, &msg, NULL, 0);
 }
 
+/**
+ * Attach interrupt handler to GPIO
+ *
+ * @param dev_id
+ *   The identifier of the device
+ * @param gpio
+ *   Zero-based GPIO number
+ * @param handler
+ *   Interrupt handler to be executed
+ * @param data
+ *   Data to be passed to interrupt handler
+ *
+ * @return
+ *   Returns 0 on success, negative error code otherwise
+ */
+static __rte_always_inline int
+rte_pmd_gpio_register_irq2(uint16_t dev_id, int gpio, cnxk_gpio_irq_handler2_t handler, void *data)
+{
+	struct cnxk_gpio_irq2 irq = {
+		.handler = handler,
+		.data = data,
+	};
+	struct cnxk_gpio_msg msg = {
+		.type = CNXK_GPIO_MSG_TYPE_REGISTER_IRQ2,
+		.data = &irq,
+	};
+
+	return __rte_pmd_gpio_enq_deq(dev_id, gpio, &msg, NULL, 0);
+}
+
 /**
  * Detach interrupt handler from GPIO
  *
-- 
2.34.1

