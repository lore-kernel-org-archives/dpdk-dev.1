Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CA6C88E45
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C6C0406FF;
	Sat, 12 Sep 2026 08:33:46 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 19A5040609
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:33:45 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1724069a91.3
 for <dev@dpdk.org>; Fri, 11 Sep 2026 23:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789194824;
 x=1789799624; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/VGXHac9PFuoJH9HkXClGPlDuwB6jtLoDisQ12YkLyQ=;
 b=LGB8xZX4Hr2ozEo3jH5Rs37DBDAAf0j6FgleYK8GRur+iR3BZWNKidM4jsNda3LFT6
 /5uvT/h3xD5VPig2jowRpA26BQdwdl3sNDU7yCZSeCvSRDh0pADn1mVyB8GBw0eQmFdA
 TPp6grdoMvuSAHMeMg9Vs+7KNld4I6DKGyooZsH+QOKXVSgDExPhPtdvRyLxw5G5K28E
 jRBdpmgfoKs529pXgGNdH5IYXK/tdvOAJ+72Tm+o9eaWSZEv9z1BNq6yNTj6XJ4wxOmx
 04zZimlKWrGdfy8XafyXpbgR92wqY+BIOFSj5AnyuVOhnQjgzDr5+dmuRShJYyj4CaXB
 wtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194824; x=1789799624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/VGXHac9PFuoJH9HkXClGPlDuwB6jtLoDisQ12YkLyQ=;
 b=tB+JeF9FDoVpwNv+ny+qMEea6DNzWQ4GHyttMqjwHUo0ONf2zEyvmQaRwyV/nYFpB9
 7suyxU90jlLmoeGv66wy2SMs/mqwGp2mTDqyvzj/rTQ6tnAm8gqr1DKcGoPKXOQXYJD+
 nONzexHi5hqBYi01BI+FycIamqXHyj5544l37iqLbwkR0m8DfHPz/pg7ZchqPqRp9PH+
 yA/LAGj8UNX3gl0idStgccudxVZO+HL+P4NvwSXcHcFKWiTSoZNlrG+q11wSpDeXzxBD
 oihZ7Y1KfvLkOoLshi96P+nu4Tn1T1/oxepyTSfY9fAFwj3jtGwt1skcGYhKqgb8bBGC
 i5TA==
X-Gm-Message-State: AFuF++nYfzVviDFy9coVEVKRKJlBeEqN+VBJ/vFuKSTfz9GEq+Kwid4s
 JUqWv/tFivzU2yvo3TuNhqkBF1feZlXHLKg1sknzXTzi62lPy32RLyR0WpaaVJfId/AHh3K4VMU
 x0TGFsZE=
X-Gm-Gg: AYBFou19LEaZ9fQmFQdTTc0wfsoGHCG4Ph24JkA+gLx0wojtvK9MRDE3uH/dKux8hQJ
 aczyAww42iQY0rinYK7cXG9YkCNvO2WCC4YetOBtrlAmyL5O8KOLIBQr9cmslZPwy9I8iqFLB9/
 TMOW7UvMvVbyfAdqfSF+2BPMquCrvcGvlUB4xi3YOSDfWi/kOdJZIkj8RZIl8DZRkt1rFU9BEHC
 /k6OgpUYqBsfqPnYL3KdruTEAtci0BD6W/vPjhLx30HrdlKXm4D1vGUI9MoFYG7ecQin1iEFrrZ
 MSHdKv5ex1PsG0spVOX+Mi9JK9BSPy0Wh2/OuD9jF4Oz5i8wVGuSJFMpbO50Yx4aV5JfkgTJREV
 rReV4gNTtmgPmGJd+nyY3HsYAkc6u1MtqYhd6oxHbw75ggeLCIvT4F7dkO3oI3vFN2qJK1+8hy2
 cGXy0oxZJXPD8NV9K/+AaQ0gXHQ0YlbEJANUBPAz7iVDD3wy61ZPdAS4WhNKweIp4pBM5DmhF5o
 U0j4+tj6RR6/oUHM3kflh8txLA5fR/Mg/qaGw==
X-Received: by 2002:a17:90a:da8f:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39d9bc10072mr11404143a91.6.1789194824201; 
 Fri, 11 Sep 2026 23:33:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm8661497a91.10.2026.09.11.23.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 23:33:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH 3/9] common/ionic: use common sysfs routines
Date: Fri, 11 Sep 2026 23:30:22 -0700
Message-ID: <20260912063319.4117869-4-stephen@networkplumber.org>
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

The three resource helpers and the UIO name lookup each built a path
with an unchecked sprintf() into a 64 byte buffer and then read the
value with fscanf(). Use the EAL routines instead; base 0 conversion
handles the "0x" prefix these files use.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/ionic/ionic_common_uio.c | 63 +++++--------------------
 1 file changed, 12 insertions(+), 51 deletions(-)

diff --git a/drivers/common/ionic/ionic_common_uio.c b/drivers/common/ionic/ionic_common_uio.c
index aaefab918c..a796281bdd 100644
--- a/drivers/common/ionic/ionic_common_uio.c
+++ b/drivers/common/ionic/ionic_common_uio.c
@@ -19,6 +19,7 @@
 #include <rte_common.h>
 #include <rte_eal.h>
 #include <rte_string_fns.h>
+#include <rte_sysfs.h>
 
 #include "ionic_common.h"
 
@@ -63,30 +64,17 @@ struct uio_name {
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
-			continue;
-
-		ret = fgets(name_cache[name_idx].name, IONIC_MAX_NAME_LEN, fp);
-		if (ret == NULL) {
-			fclose(fp);
+		if (rte_sysfs_parse_string(name_cache[name_idx].name, IONIC_MAX_NAME_LEN,
+				"/sys/class/uio/uio%d/name", i) < 0)
 			continue;
-		}
 
 		name_cache[name_idx].idx = i;
 
-		fclose(fp);
-
 		if (strncmp(name_cache[name_idx].name, pfx, strlen(pfx)) == 0)
 			name_idx++;
 	}
@@ -215,21 +203,12 @@ static unsigned long
 uio_get_res_size(int uio_idx, int res_idx)
 {
 	unsigned long size;
-	char file[64];
-	FILE *fp;
-
-	sprintf(file, "/sys/class/uio/uio%d/maps/map%d/size",
-		uio_idx, res_idx);
 
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
 
@@ -237,21 +216,12 @@ static unsigned long
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
 
@@ -259,21 +229,12 @@ static unsigned long
 uio_get_res_phy_addr(int uio_idx, int res_idx)
 {
 	unsigned long addr;
-	char file[64];
-	FILE *fp;
 
-	sprintf(file, "/sys/class/uio/uio%d/maps/map%d/addr",
-		uio_idx, res_idx);
-
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
 
-- 
2.53.0

