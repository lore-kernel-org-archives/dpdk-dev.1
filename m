Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFEBC88E56
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:04:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0EC040659;
	Sat, 12 Sep 2026 19:04:03 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 83C1140678
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:04:02 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so1437691a12.0
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232642;
 x=1789837442; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DO+vem7XofIUsM4Z33QKvXG343IYCUGPhuuXLAmkaJE=;
 b=JdJNMOa64I0cCmmK9DLCGFZFu3HWMM4M/YJVEXFDpIHRKZVyIqsW0D3qWYj/23TxZY
 Erjz85pP4xL/sAU6uuyl0XiiP78/auuMZHSa7ntX1zSH+sgqQ/IW981tPNSXrYzsQtIP
 gTn42qlyjIxzVcUA9f1QJ5r39/ZCW6PzXtILQQp1M39fDnmy3+PfAZUjTYQFmWnsruzK
 Jo85Rg/gBwaWrEJZOrG4gfngip4gVqLLZs2uy8QYWLejknKTy88/uXRi59+J/Ks5e2L3
 qdOVu5M5zkiaTDkcHF6ZCsioj6A0eIilFK3IWF3umPbqSx/KJJnxAa4P3trnDJib3dfB
 Z81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232642; x=1789837442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DO+vem7XofIUsM4Z33QKvXG343IYCUGPhuuXLAmkaJE=;
 b=B98aZ83+1nxi908M2F+8EmptJuPKl0Bls+gJ2HxRYxZMHfZw/Cu+j4na+BZx3mFP+f
 3ZeetJNLcV80O0fv+lnZSQNNWWUhBxtM2UI75sdAZ7xdQst9DUON03SYhEnAa8cj+Jnq
 G5ZzHrq7PWYurDZ4gd1uuIBY3YTLR9sWczA4uAQChd4CNr+SaOIDQQ/FGjVQUI/iQ6LA
 81KaKD5Kwi/Lo1kKAH+mdJClA+fJtqvw0ktYVLl8wKCPZD4VUi+fiMmD62hJJsjoyPmH
 0+yuAyAiY6C4ZDpXqq9A1SLn0WwV58Fdp44kNsxP3okLQn30WmGvVNDgfuuEUZhH0g9B
 v6lw==
X-Gm-Message-State: AFuF++lJCuBlcjJFQqmkD8EHMEyBQzPCsNHzIvypN3a15yubfgE7xbcb
 tRtuc2C1iIc5+y03WViU2Otdjq83482D5IFZZFQPIiBaqsWYiDw6RsNAbEu1B+WlozmlMUS4f8q
 spGFhiDA=
X-Gm-Gg: AYBFou1Ixejwh96oaVjKq3PplE9v/HGImR+yn1WcT3jgetpRjzAJUAwPYq41qT2Cf5t
 FsmY0POX5Qds1SZ03qcD7PQl7s4RXmQVK3foJ5n4JP13onAwOuUSDcMEiGpCQltqAuXVcgvcLn9
 GrVCUtWf5OuE0zm3695KG37vcATOAe+UrrxijbPxbyU5sh+yxa3hJgqiJKbQxbybgBfwDP72GNL
 jcuGLPoAmS7S4/WRV9PoIGtiyn5tzuR1mrwuzGff41+S6crHEj9p2TJDf+AxO2IhL5S8A5hLBBK
 IYB8W8qgUw2uHskCVuMkN+yGIaz/QbSYpwkOpTEzSg4AuleQh7yDuMYXlN7kb0u2RDz/p9k+Squ
 C2Ltkg06p9A4IG0W2mg9VwtpiGfzm/GN6N3HGOjL2FkBg8EbhE5EzQFAo40PGjrGICU2jEYb48k
 KnJ6wVu4Ukpv3EwTpPZXzz0T0Scymv4f024vWVjGGxuu6HdO/CJ/GJo2ATQTPrQshm+ilIUEZaw
 F52reRbkZ+5LJR13S2xpkuZAy9OuVueKbEtnA==
X-Received: by 2002:a05:6a21:99a3:b0:3d0:88f5:f812 with SMTP id
 adf61e73a8af0-3daed1d94aemr15312570637.10.1789232641592; 
 Sat, 12 Sep 2026 10:04:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:04:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v2 2/9] dma/idxd: use common sysfs routines
Date: Sat, 12 Sep 2026 10:02:14 -0700
Message-ID: <20260912170338.486978-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912170338.486978-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260912170338.486978-1-stephen@networkplumber.org>
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

