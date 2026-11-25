Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACF606A323
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=WGy6Cdg0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E01DD406BC;
	Wed, 25 Nov 2026 15:06:37 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTPS id EDFF34027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:32 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oM7b0o4rH1SeofYBElAeWAkNyoZbwIYEiRdEXW4SQHk=;
 b=WGy6Cdg0Z4+RWkT8k99op/pYbfU2tOCaEFKQyJwcjoSlUXciZwHEc644IMLYA3I8z+YTcudy7
 K7LgxVyuj7BhPjbJWDPNN3N5GoiH1SCPqJIXlGZRacV4omBHWUH4qR4XHfZKjDzhpwxymYkEqc9
 zuLR3by/XxeS09nt0y/RD2w=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jZLzk1lw5zcZyF;
 Wed, 25 Nov 2026 22:05:22 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 117BF40537;
 Wed, 25 Nov 2026 22:06:28 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:27 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Sivaprasad Tummala <sivaprasad.tummala@amd.com>, 
 Shuaisong Yang <yangshuaisong@h-partners.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <fengchengwen@huawei.com>,
 <yangxingui@h-partners.com>, <yangxingui@huawei.com>, Huisong Li
 <lihuisong@huawei.com>
Subject: [PATCH 8/9] power/hisi_uncore: support Hisilicon uncore driver
Date: Wed, 25 Nov 2026 22:06:14 +0800
Message-ID: <20261125140616.3965843-9-yangshuaisong@h-partners.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
References: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Huisong Li <lihuisong@huawei.com>

DPDK uncore power framework currently only supports Intel and AMD
platforms. HiSilicon platforms lack an uncore frequency management
driver, so applications cannot manage uncore frequency on these
systems.

This patch introduces a new hisi_uncore driver that manages uncore
frequency via the Linux devfreq sysfs interface (device HID
HISI04F1:), which depends on the kernel hisi_uncore_freq module.

The driver is registered into the rte_power_uncore ops framework,
supports package/die enumeration, available frequency query, and
get/set/min/max frequency operations. It is restricted to Linux and
aarch64.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 MAINTAINERS                             |   4 +
 doc/guides/prog_guide/power_man.rst     |  15 +
 doc/guides/rel_notes/release_26_11.rst  |   5 +
 drivers/power/hisi_uncore/hisi_uncore.c | 693 ++++++++++++++++++++++++
 drivers/power/hisi_uncore/hisi_uncore.h |  39 ++
 drivers/power/hisi_uncore/meson.build   |  17 +
 drivers/power/meson.build               |   1 +
 lib/power/rte_power_uncore.c            |   3 +-
 lib/power/rte_power_uncore.h            |   3 +-
 9 files changed, 778 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/hisi_uncore/hisi_uncore.c
 create mode 100644 drivers/power/hisi_uncore/hisi_uncore.h
 create mode 100644 drivers/power/hisi_uncore/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index cdc1ce259a..402164f534 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1871,6 +1871,10 @@ F: doc/guides/sample_app_ug/l3_forward_power_man.rst
 F: examples/vm_power_manager/
 F: doc/guides/sample_app_ug/vm_power_management.rst
 
+Hisilicon uncore power
+M: Shuaisong Yang <yangshuaisong@h-partners.com>
+F: drivers/power/hisi_uncore/
+
 Timers
 M: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
 F: lib/timer/
diff --git a/doc/guides/prog_guide/power_man.rst b/doc/guides/prog_guide/power_man.rst
index 72f6dc9ea5..40ba7850a7 100644
--- a/doc/guides/prog_guide/power_man.rst
+++ b/doc/guides/prog_guide/power_man.rst
@@ -249,6 +249,21 @@ Additionally, the EPYC System Management Interface In-band Library for Linux
 offers essential API, enabling user-space software
 to effectively manage system functions.
 
+HiSilicon Uncore
+~~~~~~~~~~~~~~~~
+
+On HiSilicon platforms, the uncore frequency is managed through the Linux
+devfreq subsystem. The kernel ``hisi_uncore_freq`` module exposes the
+uncore device (HID ``HISI04F1:``) under ``/sys/devices/platform/``,
+providing devfreq sysfs entries for frequency control.
+
+Please ensure that the ``hisi_uncore_freq`` kernel module is loaded.
+The driver switches the devfreq governor to ``userspace`` during
+initialization to allow manual frequency setting, and restores the
+original governor on exit.
+
+This driver is only supported on Linux and aarch64.
+
 Uncore API Overview
 ~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8387949ef3..dbb9cb6d93 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -337,6 +337,11 @@ New Features
   when using ``RTE_UNCORE_PM_ENV_AUTO_DETECT``,
   instead of defaulting only to the Intel uncore driver.
 
+* **Added Hisilicon uncore power driver.**
+
+  Added the ``hisi_uncore`` driver for managing uncore frequency on
+  Hisilicon platforms via the Linux devfreq sysfs interface.
+
 * **Added graph profiling.**
 
   Added build time configurable graph node profiling statistics
diff --git a/drivers/power/hisi_uncore/hisi_uncore.c b/drivers/power/hisi_uncore/hisi_uncore.c
new file mode 100644
index 0000000000..0f22182767
--- /dev/null
+++ b/drivers/power/hisi_uncore/hisi_uncore.c
@@ -0,0 +1,693 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 HiSilicon Technologies Co., Ltd. All rights reserved.
+ */
+#include <dirent.h>
+#include <errno.h>
+#include <linux/limits.h>
+#include <rte_string_fns.h>
+#include <rte_memcpy.h>
+#include <rte_lcore.h>
+#include <rte_stdatomic.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "hisi_uncore.h"
+#include "power_common.h"
+#include "power_uncore_ops.h"
+
+#define HISI_UNCORE_DRIVER_NAME			"hisi-uncore"
+#define HISI_UNCORE_DEVICE_HID			"HISI04F1:"
+#define HISI_UNCORE_DEVICE_NAME_FMT		"HISI04F1:%02u"
+
+#define HISI_UNCORE_DEVFREQ_DEV_PATH		"/sys/devices/platform/"
+#define HISI_UNCORE_DEPEND_MODULE		"hisi_uncore_freq"
+#define HISI_UNCORE_DIE_NUM_PER_PKG		1
+
+#define HISI_UNCORE_DEVFREQ_GOVERNOR \
+	"/sys/devices/platform/HISI04F1:%02u/devfreq/HISI04F1:%02u/governor"
+#define HISI_UNCORE_USERSPACE_GOVERNOR "userspace"
+
+#define HISI_UNCORE_DEVFREQ_AVAILABLE_FREQ  \
+	"/sys/devices/platform/HISI04F1:%02u/devfreq/HISI04F1:%02u/available_frequencies"
+#define HISI_UNCORE_DEVFREQ_MIN_FREQ  \
+	"/sys/devices/platform/HISI04F1:%02u/devfreq/HISI04F1:%02u/min_freq"
+#define HISI_UNCORE_DEVFREQ_MAX_FREQ  \
+	"/sys/devices/platform/HISI04F1:%02u/devfreq/HISI04F1:%02u/max_freq"
+#define HISI_UNCORE_CUR_FREQ  \
+	"/sys/devices/platform/HISI04F1:%02u/devfreq/HISI04F1:%02u/cur_freq"
+#define HISI_UNCORE_SET_FREQ  \
+		"/sys/devices/platform/HISI04F1:%02u/devfreq/HISI04F1:%02u/userspace/set_freq"
+
+#define POWER_CONVERT_TO_DECIMAL 10
+
+static struct hisi_uncore_info *hisi_uncore;
+
+enum hisi_uncore_sysfs_type {
+	HISI_UNCORE_SYSFS_MIN_FREQ,
+	HISI_UNCORE_SYSFS_MAX_FREQ,
+	HISI_UNCORE_SYSFS_CUR_FREQ,
+	HISI_UNCORE_SYSFS_GOVERNOR,
+	HISI_UNCORE_SYSFS_AVAIL_FREQS,
+};
+
+static int hisi_uncore_probe_device(void)
+{
+	char driver_path[PATH_MAX];
+	bool access_ok = false;
+	struct dirent *dir;
+	DIR *d;
+
+	d = opendir(HISI_UNCORE_DEVFREQ_DEV_PATH);
+	if (d == NULL) {
+		POWER_LOG(DEBUG, "Open %s path error", HISI_UNCORE_DEVFREQ_DEV_PATH);
+		return -EINVAL;
+	}
+	while ((dir = readdir(d)) != NULL) {
+		if (!strncmp(dir->d_name, HISI_UNCORE_DEVICE_HID,
+		    strlen(HISI_UNCORE_DEVICE_HID))) {
+			snprintf(driver_path, sizeof(driver_path), "%s/%s/driver",
+				 HISI_UNCORE_DEVFREQ_DEV_PATH, dir->d_name);
+			if (access(driver_path, F_OK))
+				POWER_LOG(DEBUG, "Please load %s module",
+					  HISI_UNCORE_DEPEND_MODULE);
+			else
+				access_ok = true;
+			break;
+		}
+	}
+	closedir(d);
+
+	return access_ok ? 0 : -ENOENT;
+}
+
+static uint32_t hisi_uncore_get_pkg_num(void)
+{
+	struct dirent *dir;
+	uint32_t num = 0;
+	DIR *d;
+
+	d = opendir(HISI_UNCORE_DEVFREQ_DEV_PATH);
+	if (d == NULL) {
+		POWER_LOG(DEBUG, "Open %s path error", HISI_UNCORE_DEVFREQ_DEV_PATH);
+		return 0;
+	}
+	while ((dir = readdir(d)) != NULL) {
+		if (strncmp(dir->d_name, HISI_UNCORE_DEVICE_HID,
+		    strlen(HISI_UNCORE_DEVICE_HID)) == 0)
+			num++;
+	}
+	closedir(d);
+
+	return num;
+}
+
+static void hisi_uncore_plat_data_uninit(void)
+{
+	uint32_t i;
+
+	if (!hisi_uncore)
+		return;
+
+	for (i = 0; i < hisi_uncore->pkg_num; i++)
+		free(hisi_uncore->pkg_data[i].die_data);
+	free(hisi_uncore->pkg_data);
+	free(hisi_uncore);
+	hisi_uncore = NULL;
+}
+
+static int hisi_uncore_plat_data_init(void)
+{
+	struct hisi_uncore_die_data *die_data;
+	uint32_t pkg_num, die_num;
+	uint32_t i, j;
+	int ret;
+
+	if (hisi_uncore)
+		return 0;
+
+	ret = hisi_uncore_probe_device();
+	if (ret) {
+		POWER_LOG(DEBUG, "%s: Probe uncore device failed",
+			  HISI_UNCORE_DRIVER_NAME);
+		return ret;
+	}
+	hisi_uncore = calloc(1, sizeof(struct hisi_uncore_info));
+	if (!hisi_uncore)
+		return -ENOMEM;
+
+	pkg_num = hisi_uncore_get_pkg_num();
+	hisi_uncore->pkg_data = calloc(pkg_num, sizeof(struct hisi_uncore_pkg_data));
+	if (!hisi_uncore->pkg_data) {
+		ret = -ENOMEM;
+		goto uninit_plat_uncore;
+	}
+	hisi_uncore->pkg_num = pkg_num;
+
+	for (i = 0; i < hisi_uncore->pkg_num; i++) {
+		die_num = HISI_UNCORE_DIE_NUM_PER_PKG;
+		hisi_uncore->pkg_data[i].die_data =
+			calloc(die_num, sizeof(struct hisi_uncore_die_data));
+		if (!hisi_uncore->pkg_data[i].die_data) {
+			ret = -ENOMEM;
+			goto uninit_plat_uncore;
+		}
+		hisi_uncore->pkg_data[i].pkg_id = i;
+		hisi_uncore->pkg_data[i].die_num = die_num;
+		for (j = 0; j < die_num; j++) {
+			die_data = &hisi_uncore->pkg_data[i].die_data[j];
+			die_data->die_id = j;
+		}
+	}
+
+	return 0;
+
+uninit_plat_uncore:
+	hisi_uncore_plat_data_uninit();
+
+	return ret;
+}
+
+static int
+hisi_uncore_pkg_die_valid(unsigned int pkg, unsigned int die)
+{
+	return hisi_uncore && (pkg < hisi_uncore->pkg_num) &&
+	       (die < hisi_uncore->pkg_data[pkg].die_num);
+}
+
+static int
+hisi_uncore_read_sysfs_str(struct hisi_uncore_die_data *die_data,
+			   enum hisi_uncore_sysfs_type type,
+			   char *buf, size_t bufsz)
+{
+	const char *item_name;
+	FILE *f = NULL;
+	int ret;
+
+	switch (type) {
+	case HISI_UNCORE_SYSFS_MIN_FREQ:
+		item_name = "min_freq";
+		ret = open_core_sysfs_file(&f, "r", HISI_UNCORE_DEVFREQ_MIN_FREQ,
+					   die_data->uid, die_data->uid);
+		break;
+	case HISI_UNCORE_SYSFS_MAX_FREQ:
+		item_name = "max_freq";
+		ret = open_core_sysfs_file(&f, "r", HISI_UNCORE_DEVFREQ_MAX_FREQ,
+					   die_data->uid, die_data->uid);
+		break;
+	case HISI_UNCORE_SYSFS_CUR_FREQ:
+		item_name = "cur_freq";
+		ret = open_core_sysfs_file(&f, "r", HISI_UNCORE_CUR_FREQ,
+					   die_data->uid, die_data->uid);
+		break;
+	case HISI_UNCORE_SYSFS_GOVERNOR:
+		item_name = "governor";
+		ret = open_core_sysfs_file(&f, "r", HISI_UNCORE_DEVFREQ_GOVERNOR,
+					   die_data->uid, die_data->uid);
+		break;
+	case HISI_UNCORE_SYSFS_AVAIL_FREQS:
+		item_name = "available_frequencies";
+		ret = open_core_sysfs_file(&f, "r", HISI_UNCORE_DEVFREQ_AVAILABLE_FREQ,
+					   die_data->uid, die_data->uid);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (ret != 0) {
+		POWER_LOG(ERR, "Failed to open %s under " HISI_UNCORE_DEVICE_NAME_FMT,
+			  item_name, die_data->uid);
+		goto err;
+	}
+
+	ret = read_core_sysfs_s(f, buf, bufsz);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Failed to read %s under " HISI_UNCORE_DEVICE_NAME_FMT,
+			  item_name, die_data->uid);
+		goto err;
+	}
+
+err:
+	if (f != NULL)
+		fclose(f);
+
+	return ret;
+}
+
+static int
+hisi_uncore_read_freq_sysfs(struct hisi_uncore_die_data *die_data,
+			    enum hisi_uncore_sysfs_type type, uint32_t *val)
+{
+	unsigned long tmp;
+	char buf[BUFSIZ];
+	int ret;
+
+	ret = hisi_uncore_read_sysfs_str(die_data, type, buf, sizeof(buf));
+	if (ret != 0)
+		return ret;
+
+	tmp = strtoul(buf, NULL, POWER_CONVERT_TO_DECIMAL);
+	if (tmp > UINT32_MAX)
+		return -EINVAL;
+	*val = tmp;
+
+	return 0;
+}
+
+static int
+hisi_uncore_get_min_freq(struct hisi_uncore_die_data *die_data)
+{
+	return hisi_uncore_read_freq_sysfs(die_data,
+					   HISI_UNCORE_SYSFS_MIN_FREQ,
+					   &die_data->min_freq);
+}
+
+static int
+hisi_uncore_get_max_freq(struct hisi_uncore_die_data *die_data)
+{
+	return hisi_uncore_read_freq_sysfs(die_data,
+					   HISI_UNCORE_SYSFS_MAX_FREQ,
+					   &die_data->max_freq);
+}
+
+static int
+hisi_uncore_get_cur_freq_helper(struct hisi_uncore_die_data *die_data, uint32_t *freq)
+{
+	return hisi_uncore_read_freq_sysfs(die_data, HISI_UNCORE_SYSFS_CUR_FREQ, freq);
+}
+
+static int
+hisi_uncore_get_governor_ori(struct hisi_uncore_die_data *die_data)
+{
+	char buf[BUFSIZ];
+	int ret;
+
+	ret = hisi_uncore_read_sysfs_str(die_data, HISI_UNCORE_SYSFS_GOVERNOR, buf, sizeof(buf));
+	if (ret != 0)
+		return ret;
+
+	rte_strscpy(die_data->governor_ori, buf, sizeof(die_data->governor_ori));
+	return 0;
+}
+
+static uint32_t
+hisi_uncore_parse_available_freqs(char *buf, uint32_t *freqs, int max_num)
+{
+	unsigned long val;
+	char *next = buf;
+	int count = 0;
+
+	while (*next != '\0' && count < max_num) {
+		char *endptr;
+
+		val = strtoul(next, &endptr, POWER_CONVERT_TO_DECIMAL);
+		if (endptr == next) {
+			next++;
+			continue;
+		}
+		if (val > UINT32_MAX) {
+			POWER_LOG(ERR, "Frequency value is more than %u", UINT32_MAX);
+			break;
+		}
+
+		freqs[count++] = val;
+		next = endptr;
+	}
+
+	if (count >= max_num)
+		POWER_LOG(ERR, "Available frequency number exceeds the maximum capacity %u",
+				max_num);
+
+	return count;
+}
+
+static int
+hisi_uncore_freq_cmp(const void *a, const void *b)
+{
+	uint32_t f1 = *(const uint32_t *)a;
+	uint32_t f2 = *(const uint32_t *)b;
+
+	return (f1 > f2) - (f1 < f2);
+}
+
+static int
+hisi_uncore_get_avail_freqs_inner(struct hisi_uncore_die_data *die_data)
+{
+	char buf[BUFSIZ];
+	int ret;
+
+	ret = hisi_uncore_read_sysfs_str(die_data, HISI_UNCORE_SYSFS_AVAIL_FREQS,
+					 buf, sizeof(buf));
+	if (ret != 0)
+		return ret;
+
+	die_data->nb_freqs = hisi_uncore_parse_available_freqs(buf, die_data->freqs,
+								RTE_MAX_UNCORE_FREQS);
+	qsort(die_data->freqs, die_data->nb_freqs, sizeof(uint32_t), hisi_uncore_freq_cmp);
+	return 0;
+}
+
+static int
+hisi_uncore_set_governor(struct hisi_uncore_die_data *die_data, const char *governor)
+{
+	FILE *f = NULL;
+	int ret;
+
+	ret = open_core_sysfs_file(&f, "w", HISI_UNCORE_DEVFREQ_GOVERNOR,
+				   die_data->uid, die_data->uid);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Failed to open governor under " HISI_UNCORE_DEVICE_NAME_FMT,
+			  die_data->uid);
+		goto err;
+	}
+
+	ret = write_core_sysfs_s(f, governor);
+	if (ret != 0)
+		POWER_LOG(ERR, "Failed to write governor (%s) under " HISI_UNCORE_DEVICE_NAME_FMT,
+			  governor, die_data->uid);
+
+err:
+	if (f != NULL)
+		fclose(f);
+
+	return ret;
+}
+
+static int
+hisi_uncore_die_setup(struct hisi_uncore_die_data *die_data)
+{
+	int ret;
+
+	ret = hisi_uncore_get_min_freq(die_data);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Get the min_freq of uncore die (uid-%u) failed",
+			  die_data->uid);
+		return ret;
+	}
+
+	ret = hisi_uncore_get_max_freq(die_data);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Get the max_freq of uncore die (uid-%u) failed",
+			  die_data->uid);
+		return ret;
+	}
+	ret = hisi_uncore_get_cur_freq_helper(die_data, &die_data->cur_freq_ori);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Get the original cur_freq of uncore die (uid-%u) failed",
+			  die_data->uid);
+		return ret;
+	}
+
+	ret = hisi_uncore_get_avail_freqs_inner(die_data);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Get the available frequency of uncore die (uid-%u) failed",
+			  die_data->uid);
+		return ret;
+	}
+
+	ret = hisi_uncore_get_governor_ori(die_data);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Get the original governor of uncore die (uid-%u) failed",
+			  die_data->uid);
+		return ret;
+	}
+
+	ret = hisi_uncore_set_governor(die_data, HISI_UNCORE_USERSPACE_GOVERNOR);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Set %s governor for uncore die (uid-%u) failed",
+			  HISI_UNCORE_USERSPACE_GOVERNOR, die_data->uid);
+		return ret;
+	}
+
+	ret = open_core_sysfs_file(&die_data->f_set_freq, "rw+", HISI_UNCORE_SET_FREQ,
+				   die_data->uid, die_data->uid);
+	if (ret != 0) {
+		POWER_LOG(ERR, "Failed to open set_freq " HISI_UNCORE_DEVICE_NAME_FMT,
+			  die_data->uid);
+		(void)hisi_uncore_set_governor(die_data, die_data->governor_ori);
+	}
+
+	return ret;
+}
+
+static void
+hisi_uncore_die_teardown(struct hisi_uncore_die_data *die_data)
+{
+	if (die_data == NULL)
+		return;
+	if (die_data->f_set_freq == NULL)
+		return;
+
+	(void)fprintf(die_data->f_set_freq, "%u\n", die_data->cur_freq_ori);
+	fclose(die_data->f_set_freq);
+	die_data->f_set_freq = NULL;
+	(void)hisi_uncore_set_governor(die_data, die_data->governor_ori);
+}
+
+static int
+hisi_uncore_init(unsigned int pkg, unsigned int die)
+{
+	struct hisi_uncore_die_data *die_data;
+	int ret;
+
+	ret = hisi_uncore_plat_data_init();
+	if (ret != 0) {
+		POWER_LOG(DEBUG, "%s: Initialize platform uncore data failed",
+			  HISI_UNCORE_DRIVER_NAME);
+		return ret;
+	}
+
+	if (!hisi_uncore_pkg_die_valid(pkg, die)) {
+		POWER_LOG(ERR, "Invalid pkg-%u or die-%u for %s",
+			  pkg, die, HISI_UNCORE_DRIVER_NAME);
+		ret = -EINVAL;
+		goto plat_data_uninit;
+	}
+
+	die_data = &hisi_uncore->pkg_data[pkg].die_data[die];
+	die_data->uid = pkg * HISI_UNCORE_DIE_NUM_PER_PKG + die;
+	ret = hisi_uncore_die_setup(die_data);
+	if (ret != 0) {
+		POWER_LOG(ERR, "%s: Initialize die data (pkg-%u die-%u) failed",
+			  HISI_UNCORE_DRIVER_NAME, pkg, die);
+		goto plat_data_uninit;
+	}
+
+	rte_atomic_fetch_add_explicit(&hisi_uncore->ref, 1,
+				      rte_memory_order_relaxed);
+
+	return 0;
+
+plat_data_uninit:
+	if (rte_atomic_load_explicit(&hisi_uncore->ref,
+				     rte_memory_order_relaxed) == 0)
+		hisi_uncore_plat_data_uninit();
+
+	return ret;
+}
+
+static int
+hisi_uncore_exit(unsigned int pkg, unsigned int die)
+{
+	struct hisi_uncore_die_data *die_data;
+
+	if (!hisi_uncore_pkg_die_valid(pkg, die)) {
+		POWER_LOG(ERR, "Invalid pkg-%u or die-%u for %s",
+			  pkg, die, HISI_UNCORE_DRIVER_NAME);
+		return -EINVAL;
+	}
+
+	die_data = &hisi_uncore->pkg_data[pkg].die_data[die];
+	hisi_uncore_die_teardown(die_data);
+
+	rte_atomic_fetch_sub_explicit(&hisi_uncore->ref, 1,
+				      rte_memory_order_relaxed);
+	if (rte_atomic_load_explicit(&hisi_uncore->ref,
+				     rte_memory_order_relaxed) == 0)
+		hisi_uncore_plat_data_uninit();
+
+	return 0;
+}
+static uint32_t
+hisi_uncore_get_cur_freq(unsigned int pkg, unsigned int die)
+{
+	struct hisi_uncore_die_data *die_data;
+	uint32_t freq, idx;
+	int ret;
+
+	if (!hisi_uncore_pkg_die_valid(pkg, die)) {
+		POWER_LOG(ERR, "Invalid pkg-%u or die-%u for %s",
+			  pkg, die, HISI_UNCORE_DRIVER_NAME);
+		return RTE_POWER_INVALID_FREQ_INDEX;
+	}
+
+	die_data = &hisi_uncore->pkg_data[pkg].die_data[die];
+	ret = hisi_uncore_get_cur_freq_helper(die_data, &freq);
+	if (ret != 0)
+		return RTE_POWER_INVALID_FREQ_INDEX;
+
+	for (idx = 0; idx < die_data->nb_freqs; idx++) {
+		if (die_data->freqs[idx] == freq)
+			break;
+	}
+	if (idx == die_data->nb_freqs) {
+		POWER_LOG(ERR, "Invalid cur_freq on die (pkg-%u die-%u)",
+			  pkg, die);
+		return RTE_POWER_INVALID_FREQ_INDEX;
+	}
+
+	return idx;
+}
+
+static int
+hisi_uncore_set_freq(unsigned int pkg, unsigned int die, uint32_t index)
+{
+	struct hisi_uncore_die_data *die_data;
+
+	if (!hisi_uncore_pkg_die_valid(pkg, die)) {
+		POWER_LOG(ERR, "Invalid pkg-%u or die-%u for %s",
+			  pkg, die, HISI_UNCORE_DRIVER_NAME);
+		return -EINVAL;
+	}
+
+	die_data = &hisi_uncore->pkg_data[pkg].die_data[die];
+	if (index >= RTE_MAX_UNCORE_FREQS || index >= die_data->nb_freqs) {
+		POWER_LOG(ERR, "%s: Invalid frequency index-%u",
+			  HISI_UNCORE_DRIVER_NAME, index);
+		return -EINVAL;
+	}
+
+	if (fprintf(die_data->f_set_freq, "%u\n", die_data->freqs[index]) < 0) {
+		POWER_LOG(ERR, "%s: Set freq on uncore die (pkg-%u die-%u) failed",
+			  HISI_UNCORE_DRIVER_NAME, pkg, die);
+		return -errno;
+	}
+
+	if (fflush(die_data->f_set_freq) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int
+hisi_uncore_set_freq_max(unsigned int pkg, unsigned int die)
+{
+	struct hisi_uncore_die_data *die_data;
+
+	if (!hisi_uncore_pkg_die_valid(pkg, die)) {
+		POWER_LOG(ERR, "Invalid pkg-%u or die-%u for %s",
+			  pkg, die, HISI_UNCORE_DRIVER_NAME);
+		return -EINVAL;
+	}
+
+	die_data = &hisi_uncore->pkg_data[pkg].die_data[die];
+	if (fprintf(die_data->f_set_freq, "%u\n", die_data->max_freq) < 0) {
+		POWER_LOG(ERR, "%s: Set max freq on uncore die (pkg-%u die-%u) failed",
+			  HISI_UNCORE_DRIVER_NAME, pkg, die);
+		return -errno;
+	}
+
+	if (fflush(die_data->f_set_freq) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int
+hisi_uncore_set_freq_min(unsigned int pkg, unsigned int die)
+{
+	struct hisi_uncore_die_data *die_data;
+
+	if (!hisi_uncore_pkg_die_valid(pkg, die)) {
+		POWER_LOG(ERR, "Invalid pkg-%u or die-%u for %s",
+			  pkg, die, HISI_UNCORE_DRIVER_NAME);
+		return -EINVAL;
+	}
+
+	die_data = &hisi_uncore->pkg_data[pkg].die_data[die];
+	if (fprintf(die_data->f_set_freq, "%u\n", die_data->min_freq) < 0) {
+		POWER_LOG(ERR, "%s: Set min freq on uncore die (pkg-%u die-%u) failed",
+			  HISI_UNCORE_DRIVER_NAME, pkg, die);
+		return -errno;
+	}
+
+	if (fflush(die_data->f_set_freq) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int
+hisi_uncore_get_avail_freqs(unsigned int pkg, unsigned int die,
+			    uint32_t *freqs, uint32_t num)
+{
+	struct hisi_uncore_die_data *die_data;
+
+	if (!hisi_uncore_pkg_die_valid(pkg, die)) {
+		POWER_LOG(ERR, "Invalid pkg-%u or die-%u for %s",
+			  pkg, die, HISI_UNCORE_DRIVER_NAME);
+		return -EINVAL;
+	}
+
+	if (freqs == NULL || num == 0) {
+		POWER_LOG(ERR, "NULL buffer supplied");
+		return -EINVAL;
+	}
+
+	die_data = &hisi_uncore->pkg_data[pkg].die_data[die];
+	if (num < die_data->nb_freqs) {
+		POWER_LOG(ERR, "Buffer size is not enough");
+		return -EINVAL;
+	}
+	rte_memcpy(freqs, die_data->freqs, die_data->nb_freqs * sizeof(uint32_t));
+
+	return die_data->nb_freqs;
+}
+
+static int
+hisi_uncore_get_num_freqs(unsigned int pkg, unsigned int die)
+{
+	struct hisi_uncore_die_data *die_data;
+
+	if (!hisi_uncore_pkg_die_valid(pkg, die)) {
+		POWER_LOG(ERR, "Invalid pkg-%u or die-%u for %s",
+			  pkg, die, HISI_UNCORE_DRIVER_NAME);
+		return -EINVAL;
+	}
+
+	die_data = &hisi_uncore->pkg_data[pkg].die_data[die];
+	return die_data->nb_freqs;
+}
+
+static unsigned int
+hisi_uncore_get_num_pkgs(void)
+{
+	return hisi_uncore_get_pkg_num();
+}
+
+static unsigned int
+hisi_uncore_get_num_dies(__rte_unused unsigned int pkg)
+{
+	return HISI_UNCORE_DIE_NUM_PER_PKG;
+}
+
+static int
+hisi_uncore_detect(void)
+{
+	return hisi_uncore_probe_device();
+}
+
+static struct rte_power_uncore_ops hisi_uncore_ops = {
+	.name = HISI_UNCORE_DRIVER_NAME,
+	.detect = hisi_uncore_detect,
+	.init = hisi_uncore_init,
+	.exit = hisi_uncore_exit,
+	.get_avail_freqs = hisi_uncore_get_avail_freqs,
+	.get_num_pkgs = hisi_uncore_get_num_pkgs,
+	.get_num_dies = hisi_uncore_get_num_dies,
+	.get_num_freqs = hisi_uncore_get_num_freqs,
+	.get_freq = hisi_uncore_get_cur_freq,
+	.set_freq = hisi_uncore_set_freq,
+	.freq_max = hisi_uncore_set_freq_max,
+	.freq_min = hisi_uncore_set_freq_min,
+};
+
+RTE_POWER_REGISTER_UNCORE_OPS(hisi_uncore_ops);
diff --git a/drivers/power/hisi_uncore/hisi_uncore.h b/drivers/power/hisi_uncore/hisi_uncore.h
new file mode 100644
index 0000000000..a4ff7bc74b
--- /dev/null
+++ b/drivers/power/hisi_uncore/hisi_uncore.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 HiSilicon Technologies Co., Ltd. All rights reserved.
+ */
+#ifndef HISI_UNCORE_H
+#define HISI_UNCORE_H
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_stdatomic.h>
+
+#define HISI_UNCORE_GOV_NAME_LEN	32
+struct hisi_uncore_die_data {
+	uint32_t die_id;
+	uint32_t uid;
+	uint32_t freqs[RTE_MAX_UNCORE_FREQS];
+	uint32_t nb_freqs;
+	uint32_t max_freq;
+	uint32_t min_freq;
+	uint32_t cur_freq_ori;
+	uint32_t curr_idx;
+	char governor_ori[HISI_UNCORE_GOV_NAME_LEN];
+	FILE *f_set_freq;
+};
+
+struct hisi_uncore_pkg_data {
+	uint32_t pkg_id;
+	uint32_t die_num;
+	struct hisi_uncore_die_data *die_data;
+};
+
+struct hisi_uncore_info {
+	RTE_ATOMIC(uint32_t) ref;
+	uint32_t pkg_num;
+	struct hisi_uncore_pkg_data *pkg_data;
+};
+
+#endif
diff --git a/drivers/power/hisi_uncore/meson.build b/drivers/power/hisi_uncore/meson.build
new file mode 100644
index 0000000000..13ba6ab100
--- /dev/null
+++ b/drivers/power/hisi_uncore/meson.build
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2026 HiSilicon Technologies Co., Ltd. All rights reserved.
+
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+    subdir_done()
+endif
+
+if (arch_subdir != 'arm') or (not dpdk_conf.get('RTE_ARCH_64'))
+    build = false
+    reason = 'only supported on aarch64'
+    subdir_done()
+endif
+
+deps += ['power']
+sources = files('hisi_uncore.c')
diff --git a/drivers/power/meson.build b/drivers/power/meson.build
index 0a703bce38..c49ed68daa 100644
--- a/drivers/power/meson.build
+++ b/drivers/power/meson.build
@@ -9,6 +9,7 @@ drivers = [
         'intel_pstate',
         'intel_uncore',
         'kvm_vm',
+        'hisi_uncore'
 ]
 
 std_deps = ['power']
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index 1ec029702b..698f0f36f3 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -22,7 +22,8 @@ const char *uncore_env_str[] = {
 	"not set",
 	"auto-detect",
 	"intel-uncore",
-	"amd-hsmp"
+	"amd-hsmp",
+	"hisi-uncore"
 };
 
 /* register the ops struct in rte_power_uncore_ops, return 0 on success. */
diff --git a/lib/power/rte_power_uncore.h b/lib/power/rte_power_uncore.h
index 66aea1b37f..9375e65766 100644
--- a/lib/power/rte_power_uncore.h
+++ b/lib/power/rte_power_uncore.h
@@ -23,7 +23,8 @@ enum rte_uncore_power_mgmt_env {
 	RTE_UNCORE_PM_ENV_NOT_SET,
 	RTE_UNCORE_PM_ENV_AUTO_DETECT,
 	RTE_UNCORE_PM_ENV_INTEL_UNCORE,
-	RTE_UNCORE_PM_ENV_AMD_HSMP
+	RTE_UNCORE_PM_ENV_AMD_HSMP,
+	RTE_UNCORE_PM_ENV_HISI_UNCORE
 };
 
 /**
-- 
2.33.0

