Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8FC79FB6
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:33:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 705594068A;
	Sat, 12 Sep 2026 08:33:43 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 0A719406B4
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:33:42 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so399236a91.0
 for <dev@dpdk.org>; Fri, 11 Sep 2026 23:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789194821;
 x=1789799621; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DO+vem7XofIUsM4Z33QKvXG343IYCUGPhuuXLAmkaJE=;
 b=LlTEzUTt555nx8qskjZcKYF+fM0dpC6MrK1icaKuHNSH5+RPlvDl/7XZ4aNzbPFyod
 FSvEcU+JjNZ1uZtB6whsuZbmWIX7M2tnnDSwV+yDXqpcVKzsC5gyjEkynSUCBmt9xLs/
 42ofLTEMHoiIheaKssR8g2qKLIF7eQiEtQ0+mXOLpSqMLDdrIwFxG9QUmPq0kwbQd5Tx
 lmp0DTF2nlVf21RTmrRL2zFxnNAYm6uZTJ8dDpwimrC7eAnm5qjUOOsvFlu+n5LixGQf
 A/AWT7y7WgeEbuULm9wA08lyB9g194mDCX2WTxdIzQC+4pc4CuSnfEC1crkbohg4EJG4
 YlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194821; x=1789799621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DO+vem7XofIUsM4Z33QKvXG343IYCUGPhuuXLAmkaJE=;
 b=mEG+vEHT1NC8huNqA+QxcN08L3ueetxf/10PqRgcx/niMdfeqpwwLaHplgzTLcg8AH
 Oit65wlEFtEMTKG1rYYClM7twBbcvQ1B7NEIPr5gKRO3jvkgQL2SnQCnuHn8UcdoyEnk
 O3cIILnTGwa9SM23ZRiumgdCp/NRk8yG2n699/nGDKZ4Pg8boC4x99qBbwJbwvGd6nKB
 8+/+MIqAdViXycgIC+sULOWRB6dtyAzMrd2GXcYqLthPfj7TE+pYBoY3IBEMC4T34hid
 OarnhJVfcWcyEzDEIF1OvYYofhn0Lv23DmJ/8Tk/XUPW8unt1eD+lUtP3Fer7DWxxviT
 Z4wg==
X-Gm-Message-State: AFuF++nZL2OYyEl7NgwRk904LZx486sUB12F59YqrkPVAxBkt6XMyQUG
 Yb8Nmtf2wId8iF5/WVYYIu4FbJ0jhH5C1ocWenPwhnNGjeC00LlcD2iD1LUKCAJz7URq4ew/wWW
 PaE0j
X-Gm-Gg: AYBFou0Q19jxglGZ175EKTdqb3I1gWM2NZFPvuqhhAJv6+T8cr/4CW9X/OrBFYfZTmL
 Yf69UjqhSEhnwUvH4HkCbKYm+1YFIRMwMAVtQxaDKExQktxyWJpJb04IYad0XNpn83T4VjSGEvj
 2yI6jIVkHxYLmAig+Np4ZiMtKLc1c8dmV58vBBY1k4sYY3mHjwgfnxR0qGS7u4Kc1xS94DZ0WBO
 7O9mPWa29lmaFi9bdD6MWFVCwfG+d2aG1ynTJQGV6zOWdzKQjWHgTcEb8cusC/rekUwHRHnK9pV
 Etv+ANyB+h1vXyMmeRM+KQD0namMho/ajPWZZl4NgbzRbQTOYtglvyLPZPkiTrrFufobRMUjADp
 SqgqmzJHpABwhqTVQjLPth726W2OBVLDtHRFBXLYjByv7NY45boV7P+TLATIjMXMw/8Sh18vq6z
 +a8jTi38Po7Qfnc179umK3fyt9aq0FugzowtO2v5BDuC7hhbt1cAA+ddY/JBLxCAtfy70yxoGhq
 podHPTBFk4okeM7rwwCXKIPuK8Y5DZOPcsXVA==
X-Received: by 2002:a17:90b:560e:b0:39b:34ef:3b2b with SMTP id
 98e67ed59e1d1-39d9c0ba635mr13784888a91.14.1789194821110; 
 Fri, 11 Sep 2026 23:33:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm8661497a91.10.2026.09.11.23.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 23:33:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH 2/9] dma/idxd: use common sysfs routines
Date: Fri, 11 Sep 2026 23:30:21 -0700
Message-ID: <20260912063319.4117869-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912063319.4117869-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The three local helpers each rebuilt a path and read a value; they
now wrap the EAL routines instead. Note that "numa_node" is -1 when
the device is not tied to a node, so the integer reads use the
signed routine.

The wq "size" and "max_batch_size" attributes were read with
fscanf("%u") and are now converted with base 0, so a value with a
leading zero would parse as octal. The kernel does not print either
with leading zeros.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/idxd/idxd_bus.c | 80 ++++++-------------------------------
 1 file changed, 12 insertions(+), 68 deletions(-)

diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 2ec526ec09..684dee3d6d 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -16,6 +16,7 @@
 #include <rte_log.h>
 #include <rte_dmadev_pmd.h>
 #include <rte_string_fns.h>
+#include <rte_sysfs.h>
 
 #include "idxd_internal.h"
 
@@ -121,82 +122,24 @@ static int
 read_wq_string(const struct rte_dsa_device *dev, const char *filename,
 		char *value, size_t valuelen)
 {
-	char sysfs_node[PATH_MAX];
-	int len;
-	int fd;
-
-	snprintf(sysfs_node, sizeof(sysfs_node), "%s/%s/%s",
+	return rte_sysfs_parse_string(value, valuelen, "%s/%s/%s",
 			dsa_get_sysfs_path(), dev->wq_name, filename);
-	fd = open(sysfs_node, O_RDONLY);
-	if (fd < 0) {
-		IDXD_PMD_ERR("%s(): opening file '%s' failed: %s",
-				__func__, sysfs_node, strerror(errno));
-		return -1;
-	}
-
-	len = read(fd, value, valuelen - 1);
-	close(fd);
-	if (len < 0) {
-		IDXD_PMD_ERR("%s(): error reading file '%s': %s",
-				__func__, sysfs_node, strerror(errno));
-		return -1;
-	}
-	value[len] = '\0';
-	return 0;
 }
 
 static int
 read_wq_int(struct rte_dsa_device *dev, const char *filename,
-		int *value)
+		long *value)
 {
-	char sysfs_node[PATH_MAX];
-	FILE *f;
-	int ret = 0;
-
-	snprintf(sysfs_node, sizeof(sysfs_node), "%s/%s/%s",
+	return rte_sysfs_parse_int(value, "%s/%s/%s",
 			dsa_get_sysfs_path(), dev->wq_name, filename);
-	f = fopen(sysfs_node, "r");
-	if (f == NULL) {
-		IDXD_PMD_ERR("%s(): opening file '%s' failed: %s",
-				__func__, sysfs_node, strerror(errno));
-		return -1;
-	}
-
-	if (fscanf(f, "%d", value) != 1) {
-		IDXD_PMD_ERR("%s(): error reading file '%s': %s",
-				__func__, sysfs_node, strerror(errno));
-		ret = -1;
-	}
-
-	fclose(f);
-	return ret;
 }
 
 static int
 read_device_int(struct rte_dsa_device *dev, const char *filename,
-		int *value)
+		long *value)
 {
-	char sysfs_node[PATH_MAX];
-	FILE *f;
-	int ret = 0;
-
-	snprintf(sysfs_node, sizeof(sysfs_node), "%s/dsa%d/%s",
+	return rte_sysfs_parse_int(value, "%s/dsa%d/%s",
 			dsa_get_sysfs_path(), dev->addr.device_id, filename);
-	f = fopen(sysfs_node, "r");
-	if (f == NULL) {
-		IDXD_PMD_ERR("%s(): opening file '%s' failed: %s",
-				__func__, sysfs_node, strerror(errno));
-		return -1;
-	}
-
-	if (fscanf(f, "%d", value) != 1) {
-		IDXD_PMD_ERR("%s(): error reading file '%s': %s",
-				__func__, sysfs_node, strerror(errno));
-		ret = -1;
-	}
-
-	fclose(f);
-	return ret;
 }
 
 static int
@@ -205,15 +148,16 @@ dsa_probe_device(__rte_unused struct rte_driver *drv, struct rte_device *dev)
 	struct rte_dsa_device *dsa_dev = RTE_BUS_DEVICE(dev, *dsa_dev);
 	struct idxd_dmadev idxd = {0};
 	int ret = 0;
+	long val;
 
 	IDXD_PMD_INFO("Probing device %s on numa node %d",
 			dsa_dev->wq_name, dsa_dev->device.numa_node);
-	if (read_wq_int(dsa_dev, "size", &ret) < 0)
+	if (read_wq_int(dsa_dev, "size", &val) < 0)
 		return -1;
-	idxd.max_batches = ret;
-	if (read_wq_int(dsa_dev, "max_batch_size", &ret) < 0)
+	idxd.max_batches = val;
+	if (read_wq_int(dsa_dev, "max_batch_size", &val) < 0)
 		return -1;
-	idxd.max_batch_size = ret;
+	idxd.max_batch_size = val;
 	idxd.qid = dsa_dev->addr.wq_id;
 	idxd.u.bus.dsa_id = dsa_dev->addr.device_id;
 	idxd.sva_support = 1;
@@ -286,7 +230,7 @@ dsa_scan(void)
 
 	while ((wq = readdir(dev_dir)) != NULL) {
 		struct rte_dsa_device *dev;
-		int numa_node = SOCKET_ID_ANY;
+		long numa_node = SOCKET_ID_ANY;
 
 		if (strncmp(wq->d_name, "wq", 2) != 0)
 			continue;
-- 
2.53.0

