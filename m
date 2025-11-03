Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13586CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB4BF40B9E;
	Mon,  3 Nov 2025 17:50:15 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 777EF40E4C
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:12 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-33be037cf73so4729758a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188612;
 x=1762793412; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1gu7AfiRa9fBPlbh989JJguWLJVJXR3ZWLC0hAe+DE=;
 b=a8higHqpAz4laHFXQXsguWS7pDcgh5zLsvSV6n2joYnkF7q9K05x5gARC76lUR644H
 kI26fbZ+FifD38rM+Gc9K1ocOQjqujQmw3haRuvjemLAEtNES3jumBRQNz74AM3TqOey
 btEwi+T1VM8eqtJP86PBFYGduvzf5zfMHMIVAS3KIiWW94rAtxUFfWteQ6KzqaNj2hPv
 79mnyKFl3+EfiRQR9L4S8TYGgTucLzrKuwfrGjdI/gVNCKyWsoN6EL1tvHxuX5HV1wHm
 wl4m3ae8noSdoP+OG5CWhfwpCoNhyP2SkzbJHdP+4HzNbTF6QjJIVT+KZX+mcpQwCOvW
 6/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188612; x=1762793412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1gu7AfiRa9fBPlbh989JJguWLJVJXR3ZWLC0hAe+DE=;
 b=iUsuqZMxB08WVbtGQ6gv5Fza2DEbiAgD/9SXwdKLSs8KY5di7JBduutkJABCUErTvR
 V4jYYJECkVmgsyiRYxeY4f59VDFLodskyFC562Xay4Yjlj4XmCpG0B8Dvdwy9ZFKd8Vp
 q98oRWs3MlKUKMfZt/WsG01Ux63i5ehZcyONqFGvCgLFLBur2SPT2gdsG8FbQV6fqYqN
 KsB82zrh21I/pGnoirR4rS0NTbn/SuMbXtTGOtt4eyLYPJWFd9nOwGZhGSQJ/ALF+j0l
 op+zn2AjCID2w1Zuot7Sz3sJ+ZVRFsNdHaoXgYd11nXCUE6QoKyoWT09ZEF8znLka7Ru
 WPhA==
X-Gm-Message-State: AOJu0YyiX1ph2FpGlXUxqHitTQi4HfCJs0stI4U4+OKBdp/gJVqwEmsl
 KHp96NAmiqryHK62pmbuc92/Z7q7DZRJWHBM02Pnm+Qe6q4HV5zDI6uox0TsHLaPD0pkeX1QQp5
 14e4H
X-Gm-Gg: ASbGncvQYTCfDx3nSIxV9fcnN19ZwVuB/UV3wlNPv1l/I9S2HK6XXyO234kbcOf4cKh
 zjCbNlBeMAAJNmJAdLZ/sb2XwBXYBqh8J/82C1C4ea97VsuTatc95IfLCSZ5pjm6oDwwLXq8yOk
 AGvDJhqwdeu/HuBHJTFlNA0BY6MDoUepPBekByiMCMr/unlV7pNSPTGL0s3gYPVIOhdZ9tpySuk
 3IT1BZV9p/J5jAqeN+lD3OoM4Wsstc/dCLjFsI76FQJGskYLssLmvqAFsv0xqNU761FUOMQX7EA
 cp7OGmUeoMY03mdPKC3gSWT2y5IQSDEaWCvTKvB9PpQOnLedwdB28gT/1IFsJ6/xzcSp7dhUtZ+
 i7I2F8MP0SBiNWyi6RcJMRfpdElNaSxwPZ1zm0jqwKhezgiTG+9fE6R6/cEJXFFUY002xl7TaCm
 M3vbSN9SrcXGg7CNPnL3wTjJLNX2SWIcxDuQLn32uGkRHbyYdKYg==
X-Google-Smtp-Source: AGHT+IE1nS3m4iujEXaSHZBm9IpwTdkaTdlzNwv5jj8pbBKdXpQ9W0WV0jTGTTia+X3erHoYIrvg+g==
X-Received: by 2002:a17:90b:2f48:b0:340:7f06:faeb with SMTP id
 98e67ed59e1d1-3408308a89emr17512143a91.37.1762188611553; 
 Mon, 03 Nov 2025 08:50:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v3 41/44] drivers/crypto: remove use of sys_queue.h
Date: Mon,  3 Nov 2025 08:47:46 -0800
Message-ID: <20251103164915.101713-42-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

The system version of queue.h should not be used.
If necessary use rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/bcmfs/bcmfs_device.c | 2 +-
 drivers/crypto/bcmfs/bcmfs_device.h | 2 --
 drivers/crypto/ccp/ccp_crypto.c     | 1 -
 drivers/crypto/ccp/ccp_dev.c        | 2 +-
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/bcmfs/bcmfs_device.c b/drivers/crypto/bcmfs/bcmfs_device.c
index 46522970d5..c66e31097e 100644
--- a/drivers/crypto/bcmfs/bcmfs_device.c
+++ b/drivers/crypto/bcmfs/bcmfs_device.c
@@ -6,8 +6,8 @@
 #include <dirent.h>
 #include <stdbool.h>
 #include <stdlib.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_malloc.h>
 #include <rte_string_fns.h>
 
diff --git a/drivers/crypto/bcmfs/bcmfs_device.h b/drivers/crypto/bcmfs/bcmfs_device.h
index 610454dd5e..7e1eafc4de 100644
--- a/drivers/crypto/bcmfs/bcmfs_device.h
+++ b/drivers/crypto/bcmfs/bcmfs_device.h
@@ -6,8 +6,6 @@
 #ifndef _BCMFS_DEVICE_H_
 #define _BCMFS_DEVICE_H_
 
-#include <sys/queue.h>
-
 #include <rte_spinlock.h>
 #include <bus_vdev_driver.h>
 
diff --git a/drivers/crypto/ccp/ccp_crypto.c b/drivers/crypto/ccp/ccp_crypto.c
index 5899d83bae..7069265f5d 100644
--- a/drivers/crypto/ccp/ccp_crypto.c
+++ b/drivers/crypto/ccp/ccp_crypto.c
@@ -9,7 +9,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <openssl/sha.h>
diff --git a/drivers/crypto/ccp/ccp_dev.c b/drivers/crypto/ccp/ccp_dev.c
index 5088d8ded6..61df5b1d7e 100644
--- a/drivers/crypto/ccp/ccp_dev.c
+++ b/drivers/crypto/ccp/ccp_dev.c
@@ -7,11 +7,11 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <sys/types.h>
 #include <sys/file.h>
 #include <unistd.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_hexdump.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
-- 
2.51.0

