Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA36C87FC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 08:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EEDC40668;
	Wed, 30 Jul 2025 10:44:46 +0200 (CEST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46]) by mails.dpdk.org (Postfix) with ESMTP id 850254025E
 for <dev@dpdk.org>; Wed, 30 Jul 2025 10:44:44 +0200 (CEST)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-553d52cb80dso751681e87.1
 for <dev@dpdk.org>; Wed, 30 Jul 2025 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753865084; x=1754469884; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cPIx3FmPtKCp9cciXDhLiRCHY0oCxGCVlJToGZsAwCo=;
 b=Sg4ArvYsoqCAzVl7Jnw+KrPbPoXYXWGW0L52hQmZUWRhR6VcgmLWsNopLz8NapaKe9
 FY+mzVs50bHUQd8hYg/eQ+8yQ0IUNqpNg7pzyFAuVFUVABpJ8f4zxI2AzNk0z/GOnJd/
 lvMV8PMWHUCRT1vrGSd/++KUCW6M5/mERCKuOecVxQTs02tEpVIQicqa6NY/aGwTWb3Q
 4VOCueSyJfLehI4UX50v1jvVWkYn9GZfhHJps0PtnpR8wACvW/3tZCVgQQj8FUgfl77/
 0bG2hPF1ybOD8jUIhVUm5daEU29Zz94gQXrP+pKwTzinex58qvLagrPY/vsRCRR8/Rfv
 tscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753865084; x=1754469884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cPIx3FmPtKCp9cciXDhLiRCHY0oCxGCVlJToGZsAwCo=;
 b=EJUIPRi7Wtfo3851Yt2ubXoeNG+YN+Jiy32dXy4sRHFyzc8elhtJ0VXSodlxsVhNA/
 jQYmvMoUSiOlhJFIlUKHqs9M5zjv23ZQkTvEcAh6V/7tN6LiOxcODSYLST/dV9T8X5fM
 Gzk1mXm6U6UP3ZWmHjGAXdZjLC99Kv28HegHHCU85KzIEsaGpjHPCnyzZFfRlYT83p3S
 ayh08R8tP2xhoqibaBup9T4SJwRP9hyPgaP7ok8fuW5OW3o1ZqT0Kj6x9z04mBMibeZh
 WdhFNqVw/S1LO1pOVH9u4smw5SAszUG9JQUYmk4/yO00jQk+i9lTZmNnAlRfQxGUIGqe
 3crw==
X-Gm-Message-State: AOJu0YyltQWXTlPF/qGycKLwrjLWNUbCTL7D6T5zATyXMlz2Q0lZNv3S
 60IwIRb99MwqPHeQB7OuOZdBdQ3YKiNxBp7WHqD0F4eVAv74+MLqKo4O
X-Gm-Gg: ASbGnctLoYf4eOIQQjBMO3I0rPtK6+ndb5X8iYutk0e/zyEe1/Dim325jbI2t3ubRPx
 jFYUVNj80sxCuXS0OVuxlXG5r0j8Itz+FGb6NssBe4hTF0nvLNuOWWamTjrIbFBYS+sudce2iPI
 n348JLz8ZPeo0iWXP++vMjPM6ec93zxgvdJOXR0jdwaBCrOjn9kN7QhGRZJ+R8vSkZcXD1IDUsh
 64dxdsAXQpNv8FevQpLWKv7wC6bpulcUgXDo53dLWLH5mlM+96Uezg0X2gmkuL/JOh6o3C5zQBZ
 w/YYJMX++Re4280FPOGR8SccGlal4EtKMhAeFHTRDCjt6yHsqt1ButhMFVsJkaUM1JSWgDsduKh
 DuUPe38n/BbBZh567PCG8voxUh8msdqqKJkQKl7YrFWbG466Poh8=
X-Google-Smtp-Source: AGHT+IFOXxIeIg2IY9dfQFy1gBCySgsXa9QC2gak+cSALBwlhyX0+e1btIQCLnTBHEyYm7YCGutcQQ==
X-Received: by 2002:a05:6512:b03:b0:55b:81cb:538e with SMTP id
 2adb3069b0e04-55b81cb5537mr451617e87.26.1753865083520; 
 Wed, 30 Jul 2025 01:44:43 -0700 (PDT)
Received: from thinkpad.l.postgrespro.ru ([109.202.2.11])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b6316da6esm2064988e87.24.2025.07.30.01.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 01:44:43 -0700 (PDT)
From: Tofig Aliev <t.aliev.mnt@gmail.com>
To: jingjing.wu@intel.com
Cc: dev@dpdk.org,
	Tofig Aliev <t.aliev.mnt@gmail.com>
Subject: [PATCH] raw/ntb: immediate return if no doorbells
Date: Wed, 30 Jul 2025 15:44:40 +0700
Message-ID: <20250730084440.102403-1-t.aliev.mnt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Added immediate return from ntb_dev_intr_handler()
if no doorbells.

Signed-off-by: Tofig Aliev <t.aliev.mnt@gmail.com>
---
 ...ntb-immediate-return-if-no-doorbells.patch | 32 +++++++++++++++++++
 drivers/raw/ntb/ntb.c                         |  4 ++-
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 0001-raw-ntb-immediate-return-if-no-doorbells.patch

diff --git a/0001-raw-ntb-immediate-return-if-no-doorbells.patch b/0001-raw-ntb-immediate-return-if-no-doorbells.patch
new file mode 100644
index 0000000000..2fd9d47b6a
--- /dev/null
+++ b/0001-raw-ntb-immediate-return-if-no-doorbells.patch
@@ -0,0 +1,32 @@
+From bd47260510660e0a0ccd0cc8d9e5c5bcdebbb175 Mon Sep 17 00:00:00 2001
+From: Tofig Aliev <tofig.aliev.02@gmail.com>
+Date: Wed, 30 Jul 2025 02:07:27 +0700
+Subject: [PATCH] raw/ntb: immediate return if no doorbells
+
+Added immediate return from ntb_dev_intr_handler()
+if no doorbells.
+
+Signed-off-by: Tofig Aliev <tofig.aliev.02@gmail.com>
+---
+ drivers/raw/ntb/ntb.c | 4 +++-
+ 1 file changed, 3 insertions(+), 1 deletion(-)
+
+diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
+index 0ed4c14592..e298820e5f 100644
+--- a/drivers/raw/ntb/ntb.c
++++ b/drivers/raw/ntb/ntb.c
+@@ -158,8 +158,10 @@ ntb_dev_intr_handler(void *param)
+ 	}
+ 
+ 	db_bits = (*hw->ntb_ops->db_read)(dev);
+-	if (!db_bits)
++	if (!db_bits) {
+ 		NTB_LOG(ERR, "No doorbells");
++		return;
++	}
+ 
+ 	/* Doorbell 0 is for peer device ready. */
+ 	if (db_bits & 1) {
+-- 
+2.43.0
+
diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 0ed4c14592..e298820e5f 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -158,8 +158,10 @@ ntb_dev_intr_handler(void *param)
 	}
 
 	db_bits = (*hw->ntb_ops->db_read)(dev);
-	if (!db_bits)
+	if (!db_bits) {
 		NTB_LOG(ERR, "No doorbells");
+		return;
+	}
 
 	/* Doorbell 0 is for peer device ready. */
 	if (db_bits & 1) {
-- 
2.43.0

