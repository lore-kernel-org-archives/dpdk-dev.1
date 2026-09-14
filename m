Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B11C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:37:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CE43410D3;
	Mon, 14 Sep 2026 19:37:24 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 734B7410D0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:23 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469b35611so1253970b3a.0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407442;
 x=1790012242; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DO+vem7XofIUsM4Z33QKvXG343IYCUGPhuuXLAmkaJE=;
 b=iowCjgnM8RGSzY7ufGeBhwYRV6RirVjvsnXEjWRkoF0i8VSJyM6JI5hJaWF3Piywql
 OnRK7vyJTzw2z9MEMAMzjRisq3ynm9Thx0bCG/r+hpiQ6PS9X1uxixdCD/TgRA7UOZUf
 fZ1b99Nr8YKB2N+H10WlBgspQOeKlV5JPkoZ7U7qay9LaRoqTAlqP72TUxSm0DWbjZRi
 fyk+LOo+dP030pmeW5zRJxEqkBYNp0MIIu8OpytZjgdmMjtRpnNfWpP4cfUlX8nuCEK9
 sWbuFHjeY/Sr4JaK2xgluPUwgvJb7GnnT2na1giPI3c6aSoGvHveQ9s93l/QU4bA3dq+
 6OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407442; x=1790012242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DO+vem7XofIUsM4Z33QKvXG343IYCUGPhuuXLAmkaJE=;
 b=L8vUXrIy2cZg4+HoXP68FM4Aom7/6Pfp76Q/Tq0FMqVAtqrk8r4ErTCK2RXx+j7Os6
 wun3iq6gc0pW24VwlLQ+L/FrVgTZy3cWLPnWdEklg5yNGDyabMCEVKIc+QK5QK48bDNY
 RhFrbZs+Fd26nPnP8tnZykrVsnvtcttX/T1BRGbiJJ3xwg9oBzwuboEGeriWCcLD1Jbh
 z9m5rOpdHJ3wTz/xry6qYZJaAUQQU5vMmqTyYwMshrkvwBjDTVE6xCpCVAHFiImJTxsr
 oyKsHXTxyuedKV4IzwuRNMKltRfYzQ9EL5QRaZvIR3Oz7M32QOTPXoMIcjevxG44LTHA
 PgEQ==
X-Gm-Message-State: AFuF++m8EPWCcLDPmM7E5wiZvfoLXYcMx85FWvWrNShMWjmr2WANCO9T
 GWrFrFuOmTse3cOHSBia+E269M/cXGYkZvcYjcSZu56amDTZzAcuiOHMAgCurSv/6J7p5boQEO7
 v4rskSJA=
X-Gm-Gg: AYBFou1atnb8c/yqXuMEeGCWgBER4DQs+FYxYEtwTVJeRby202h9e6AR0Nh/DPPeoBd
 PGxe/Xk+wYlwZy32QC1surLl5Yam1J5wCRVCLy21BxkuTJYowc0cD26VXO8nTRLfD2aBnQaL7R2
 3PGlX4PiTiO7A0HdjVazwjBPFfdRsXPzu9AKts/SgYItKHjXm141YaTvcRs2m0nLStMG78Uvzvg
 KUpjVs7h3nhAFkvVrcP4UQzAWXfT9r907Jkf7hdVz0KePSNnuWz2cE148Gse3GrJX0iOL8C3WOt
 JkoaMLMWy4Kwmtgtht3eLQqB/2/WCu+qOhG8adMQ6PnrC+xgIVkJ5B9IAPZBbXjhiEd1m/JX7Q5
 iV+v7zAlJCCJtnz35FmFITDxCXYoeuXq/ec7b2XBNAt6K7gZEhUL+uoGU9Jj7f3T/Mgt7dj6uQW
 GS5Qd8FXCXiAniohtlTFURczbGEQbvE5iCje4YQ0ufXif9yl1VRSmvPox9okarSi2hpga17sTVu
 WaubG/aizlDPjLUPjoODi/8UMFCtmrsdS5hLg==
X-Received: by 2002:a05:6a00:288a:b0:869:4484:ed98 with SMTP id
 d2e1a72fcca58-86f84e0fa2bmr7344992b3a.20.1789407442542; 
 Mon, 14 Sep 2026 10:37:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v3 2/9] dma/idxd: use common sysfs routines
Date: Mon, 14 Sep 2026 10:36:15 -0700
Message-ID: <20260914173700.2795983-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914173700.2795983-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
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

