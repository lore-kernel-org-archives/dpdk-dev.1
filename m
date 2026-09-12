Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27305C88E56
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:04:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A774027F;
	Sat, 12 Sep 2026 19:04:06 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id AEBFF4027F
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:04:05 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469a34907so552444b3a.1
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232645;
 x=1789837445; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P86N+Buub5GqNn5/Sy0Y+jZdWZoWDK38wpHZnAbnX0s=;
 b=tPoaVwO+WfLupJIGoumfbZdBGNAnlmVS6wbush/y0NSf0JaBtsCL4TwS2Itfdojy8f
 7bs+O0He5I7OqI2Eb+I9oVl3VaK2uGt2GjuPIA6TXWCCNGmyC+60QaAVpLAk/CaxGzZI
 fmgVRQTQag/aj0qGH8bqFabW6f5mya9ETJgNK2hvoG+Cvo6eLN9JwWIceaWQmFrf0/id
 V+uNdSl23tEVBh9n2G6daHHmo0qb+ZN/oxvunzB5aKD128xIGY3URiBBDImUddu+OeBJ
 hKHPtK3JuVNw4mGAyLdDgrlDtgx3qUCkdyX6fzGPPeownJUxfATUEmx3XMoLjRZPuj27
 xPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232645; x=1789837445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P86N+Buub5GqNn5/Sy0Y+jZdWZoWDK38wpHZnAbnX0s=;
 b=cP4dDNaEPowrb4gNINjtDXuhZnt5eGonEVO2PygEgJe5EeOO3CSsyXYiAQEMLkwapB
 s+FlqCu61sfwGx/ckbSgooD1Fzo6PS3QIo1Rdo45G3K7n59LMXIbW5ZTXtA5z1QydwB/
 S9ZkqiV8KFdnegtqWuWIReWgcX7KzRdVt0mfZzAlgoex3QlpgttXM7XMCWIshrkWy/X2
 OLNGH0YEkOJpv1iycvP5QJVoM3paNB68sTlHmTFYgiG7bPHsSqan8krI4oKuvOObR+0v
 EgjPA0i1BZ7+FGrcSgayWEt7PDIloLTfFm5pBDVcNYYUzqXm9QEVwg4S8a4GJXjU59B1
 BoFw==
X-Gm-Message-State: AFuF++l93td5BfI2mWvMkaS9eSlxi3sXk8dABGjj0Pbvf3FyZrlNz0sx
 Ajn77QoVXl0I6kEsEucLN/DnzYePXu1E/daYUngytZn1SKv01wf8ECrjW/khaKyVK+neEfzCp3U
 qOexTPK0=
X-Gm-Gg: AYBFou17lIJKG4MYLd0HJIdrtiQn9NLIIuljehLorhSnQBQuVG4SOyL6Zfznd7aa2kF
 bhyrQ+3TBk1o8peMZr5ZtAfvOGQLtjOfV7WvQlGuyliIspC8FTxWDu1hYGweoB7k3Uiyzj4vs1S
 xEsQQXlKnxmKub0AWRRBcNJuyb0RbLANc7d+jXAWrexoVvp8DsCG50YqKxCXAGKwaYeUgVFHu0G
 raMpJvS6Da+FW1dsjB1Mpfl3VnGV7k5/IVxij+vyqbR/SL0Rqn0v8aZN/Tv5CdTWPmpXVRg5b49
 QUyvxLs8vYAEJnv+ersQoPMDW1Qov5XnJ7mmz5lRVgtmYFlHkfVGZpRr4nvjp6Ht2FjY+8IYJrj
 HxILZ7dlhkEvxO5TQupbJHp0jcnL3rGbgkF9b0GSmMIQNfXT6NxN7auxJbHqj+VGmPldklrLToU
 lWvgsFMHznFg7mq/lHfE9ATyTaSPF4W9dcGuvOleotpfT4TBdMuvdHSnLLgH9yg8vyIv6MrrKr4
 vEb6/NhzMXhc32uSW2E64I76k1KA0MS/ohO7w==
X-Received: by 2002:a05:6a00:301c:b0:857:7337:5db5 with SMTP id
 d2e1a72fcca58-86ccbe402f6mr6204363b3a.19.1789232644669; 
 Sat, 12 Sep 2026 10:04:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:04:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v2 3/9] common/ionic: use common sysfs routines
Date: Sat, 12 Sep 2026 10:02:15 -0700
Message-ID: <20260912170338.486978-4-stephen@networkplumber.org>
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

The three resource helpers and the UIO name lookup each built a path
with an unchecked sprintf() into a 64 byte buffer and then read the
value with fscanf(). Use the EAL routines instead; base 0 conversion
handles the "0x" prefix these files use.

The scan walks /sys/class/uio, so it only ever found anything on
Linux. Build the implementation there only, and keep no-op stubs
for the rest so that the vdev probe in net/ionic and crypto/ionic
still links where it did before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/ionic/ionic_common_uio.c | 102 ++++++++++++------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/common/ionic/ionic_common_uio.c b/drivers/common/ionic/ionic_common_uio.c
index aaefab918c..04c184c2ee 100644
--- a/drivers/common/ionic/ionic_common_uio.c
+++ b/drivers/common/ionic/ionic_common_uio.c
@@ -22,6 +22,16 @@
 
 #include "ionic_common.h"
 
+/*
+ * The mnic and mcrypt devices are found by walking /sys/class/uio,
+ * so this only ever does anything on Linux. The stubs at the end of
+ * the file keep the vdev probe in net/ionic and crypto/ionic linking
+ * on other systems, where the scan would have found nothing anyway.
+ */
+#ifdef RTE_EXEC_ENV_LINUX
+
+#include <rte_sysfs.h>
+
 #define IONIC_MDEV_UNK      "mdev_unknown"
 #define IONIC_MNIC          "cpu_mnic"
 #define IONIC_MCRYPT        "cpu_mcrypt"
@@ -63,30 +73,17 @@ struct uio_name {
 static void
 uio_fill_name_cache(struct uio_name *name_cache, const char *pfx)
 {
-	char file[64];
-	FILE *fp;
-	char *ret;
 	int name_idx = 0;
 	int i;
 
 	for (i = 0; i < IONIC_UIO_MAX_TRIES &&
 			name_idx < IONIC_MAX_DEVICES; i++) {
-		sprintf(file, "/sys/class/uio/uio%d/name", i);
-
-		fp = fopen(file, "r");
-		if (fp == NULL)
+		if (rte_sysfs_parse_string(name_cache[name_idx].name, IONIC_MAX_NAME_LEN,
+				"/sys/class/uio/uio%d/name", i) < 0)
 			continue;
 
-		ret = fgets(name_cache[name_idx].name, IONIC_MAX_NAME_LEN, fp);
-		if (ret == NULL) {
-			fclose(fp);
-			continue;
-		}
-
 		name_cache[name_idx].idx = i;
 
-		fclose(fp);
-
 		if (strncmp(name_cache[name_idx].name, pfx, strlen(pfx)) == 0)
 			name_idx++;
 	}
@@ -215,21 +212,12 @@ static unsigned long
 uio_get_res_size(int uio_idx, int res_idx)
 {
 	unsigned long size;
-	char file[64];
-	FILE *fp;
 
-	sprintf(file, "/sys/class/uio/uio%d/maps/map%d/size",
-		uio_idx, res_idx);
-
-	fp = fopen(file, "r");
-	if (fp == NULL)
+	/* zero is the error value for all of these */
+	if (rte_sysfs_parse_uint(&size, "/sys/class/uio/uio%d/maps/map%d/size",
+			uio_idx, res_idx) < 0)
 		return 0;
 
-	if (fscanf(fp, "0x%lx", &size) != 1)
-		size = 0;
-
-	fclose(fp);
-
 	return size;
 }
 
@@ -237,21 +225,12 @@ static unsigned long
 uio_get_res_phy_addr_offs(int uio_idx, int res_idx)
 {
 	unsigned long offset;
-	char file[64];
-	FILE *fp;
-
-	sprintf(file, "/sys/class/uio/uio%d/maps/map%d/offset",
-		uio_idx, res_idx);
 
-	fp = fopen(file, "r");
-	if (fp == NULL)
+	/* zero is the error value for all of these */
+	if (rte_sysfs_parse_uint(&offset, "/sys/class/uio/uio%d/maps/map%d/offset",
+			uio_idx, res_idx) < 0)
 		return 0;
 
-	if (fscanf(fp, "0x%lx", &offset) != 1)
-		offset = 0;
-
-	fclose(fp);
-
 	return offset;
 }
 
@@ -259,21 +238,12 @@ static unsigned long
 uio_get_res_phy_addr(int uio_idx, int res_idx)
 {
 	unsigned long addr;
-	char file[64];
-	FILE *fp;
-
-	sprintf(file, "/sys/class/uio/uio%d/maps/map%d/addr",
-		uio_idx, res_idx);
 
-	fp = fopen(file, "r");
-	if (fp == NULL)
+	/* zero is the error value for all of these */
+	if (rte_sysfs_parse_uint(&addr, "/sys/class/uio/uio%d/maps/map%d/addr",
+			uio_idx, res_idx) < 0)
 		return 0;
 
-	if (fscanf(fp, "0x%lx", &addr) != 1)
-		addr = 0;
-
-	fclose(fp);
-
 	return addr;
 }
 
@@ -338,3 +308,33 @@ ionic_uio_rel_rsrc(const char *name, int idx, struct ionic_dev_bar *bar)
 	offs = uio_get_res_phy_addr_offs(num, idx);
 	munmap(((char *)bar->vaddr) - offs, bar->len);
 }
+
+#else /* !RTE_EXEC_ENV_LINUX */
+
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_scan_mnet_devices)
+void
+ionic_uio_scan_mnet_devices(void)
+{
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_scan_mcrypt_devices)
+void
+ionic_uio_scan_mcrypt_devices(void)
+{
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_get_rsrc)
+void
+ionic_uio_get_rsrc(const char *name __rte_unused, int idx __rte_unused,
+		struct ionic_dev_bar *bar __rte_unused)
+{
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_rel_rsrc)
+void
+ionic_uio_rel_rsrc(const char *name __rte_unused, int idx __rte_unused,
+		struct ionic_dev_bar *bar __rte_unused)
+{
+}
+
+#endif /* RTE_EXEC_ENV_LINUX */
-- 
2.53.0

