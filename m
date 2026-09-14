Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F9BC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:37:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 972F740ED9;
	Mon, 14 Sep 2026 19:37:27 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7A4E440EE3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:26 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-869d181419bso3348780b3a.2
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407445;
 x=1790012245; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P86N+Buub5GqNn5/Sy0Y+jZdWZoWDK38wpHZnAbnX0s=;
 b=PozG2FPvyQ241ZrH6MbNfN8QspS2JjxA8aOolzvfB8W2tUXSuy13MOQJECUnIlhwDO
 xru1MT3ejln4WcYstLLzWGGVZ4ukRZ+55ePx/90nEnhgHQRwVzUURFcGjD1myzQYkIfY
 UQ4emdwMKDfIJQgwRqOX16dj9Ely8o1UHD429xnpnj6zBac7fxPolgrYa3CBZITs/mse
 gGlA1PLx+POjJ3M9PXg/D+bZLAXkpSgpzpv/wP4BMKNlNEEcDV3Wyjp5yWgdLj0m5hxr
 +wvjU1cJATtieqCPsUDp1dll+0W6Fk/F2/+yMNTu1kUULOGrXH98Tjip5D0kQwMuccM/
 J6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407445; x=1790012245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P86N+Buub5GqNn5/Sy0Y+jZdWZoWDK38wpHZnAbnX0s=;
 b=ZiudsEW4trFTd8iryuzVN3ZRAzYBeMqoIfup7ZStk//stitRMYcbBEnDimvPYVpntP
 QgLA5RmvWGFAtDpFIy86CnnhAdqB5ck4ZZa2So14x+jClH03HE2bJyQ+/NpEWOpkRr9N
 h0I8uNJu7MraUg+MeaY9jbeMPkt8xgBwSjl7XymUZ+lYp6v5o6RrkyspRPkMH8T1cLP4
 IgDVjSAY8Ng13oSOcmeZNxb/w/8r8ReGv+VpxGwXY9e+UnrGFdx0qWV0oZwAdA/ZL56d
 7BBUxnc8KaWRDOnh3Ji739Z9fMsaWP/XN3ZCxkV9GfZqTbSMy/EzgHClJwaSkgulFBK+
 GwYA==
X-Gm-Message-State: AFuF++muorje2AF9N2N9EkVAbftqXk4FNPkt9rphXKJmahTCSAyRo0yj
 b54dv0xAdlAG1P85Zx8UFQ103LDu1BOOvpJ64sC3Uvx9bh4tkDnGx+Jj5HFhJOTlNEMu74y++vg
 sqOmrGAU=
X-Gm-Gg: AYBFou1KrdD5E25wKCuwsEaaAhsXZ8QMV6qe9jZMP1a9yBOjAZwqBFaNEtWBwkSQCBp
 PmlybrY4IbxpYyR45boxAk/OKG98Ouy558MqzHpqxBcA57SkhS+sUU1iFS7GvFP7RioV8Vj8Ka8
 +6cSlHA7wKhhU9NpnrxH4hGxzHXaD+j61K+e7fSoQNmvoW3LTHLNOAh3KLFlsoLwDJvE+onO1J/
 0BduIltxsDMOGnMqOaW4B96cNR20mFGXAqn1npqbyQvGleq56OLAzDKjlFlPHUBdKTnlcmlrXRd
 QbAixEJYOr5WemBeB70caCJxR6wc4mRThTnLRlcxg8dd3mZNhs7rPX6Pay3WYYXy85HhzRundb8
 qjW8zafbvvm1gOin7YzHrhiemMo3NQurc1QtM+5GIKeP7CR9Q8NB+6fbt/P7rWauIxk/mnWhpP/
 VMXAwBBQVqbshNamy/yyNqpGRTtcg+1jF/1nu6FXKhKb2iYfNSGja+NvSKzjDxouIkQSs+C1BLW
 FHeD/CwpbnDfq00RVKdL1cXRQmpwfSA21LEvw==
X-Received: by 2002:a05:6a00:1da2:b0:845:ba94:a56 with SMTP id
 d2e1a72fcca58-86f83346518mr7159433b3a.5.1789407445514; 
 Mon, 14 Sep 2026 10:37:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v3 3/9] common/ionic: use common sysfs routines
Date: Mon, 14 Sep 2026 10:36:16 -0700
Message-ID: <20260914173700.2795983-4-stephen@networkplumber.org>
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

