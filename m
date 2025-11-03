Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CA0CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBDEE40ECF;
	Mon,  3 Nov 2025 17:50:14 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4AC8740E68
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:11 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b9a5b5b47bfso975181a12.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188610;
 x=1762793410; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xq9NBaMDwTjgrTg/G4FMNP+9QAs7osjDYamRMRCkuP0=;
 b=IfTs2fGrp96QEMai+2/vXTsON94ZwclM627sacSBWrZVL1TtsCYbjNB1hsPDEwdSGO
 79ngmjFwU/rK1h/w9XdcW+Zw2ElXB1H8wXXATclvUFgEvtgqxPoUAZgVyqeUwZS824Xe
 j/63ZF2mNAlTa34TDl07pMlyFfj8WhQnEUUmfOZvjKRElwNy/2vg86t+EpftPxiGStOD
 zh6wDRokyqoB/AM+ee2uk1GkFL6r7wkLltSP4353CYJtXaVL5LaKw90uaVsL+6cOcuRj
 r43uWA3BnOe/a7xLNLKzkbHtx4WNcbH5fDUJcs67mgszhI1isE3ltJDPV5C5YYuKC4WT
 JyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188610; x=1762793410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xq9NBaMDwTjgrTg/G4FMNP+9QAs7osjDYamRMRCkuP0=;
 b=oY8VY1r+ax9q+ikH9CIS3Y1IWRpCnVYunhbYXN5aDxejX5SB2O97aAyCk3R5RVhmHA
 QImVbLsa5DbqjvzkqgaV3GvFpzkyuAQZI6p2aEV2KTbs7ZGrH/6ttpoIV4KRhY+yCnIZ
 gDALzVBeUGh6pAHVAOto6tpdP2pSi+Bd79j6ESzk1ZfrOuGs9rB2Q7lYXc7gSBpeekX3
 Cf06h4glIZrBs5CQUkNXUo1xXYiIEM4uiLq1La4fmH5IugXv/ef8x5KEoA94pQjyqrvQ
 q0fwXFLDLVBIHnAIVpzRY+iaSLbiCfUPqsij1k5nBU+BVKtBI//tNiwE6eeJFR0gg1XU
 9IMQ==
X-Gm-Message-State: AOJu0Yx8Nvi+zn7WmmgyTDioe6605zW1mAlgTHq+dlkZ1N5Rk8UhxHl5
 EYD+eUZDfw48Bosvhtisn5bSSJlL6h0yKy5yjhFaehMowvyNLmCB1zPlbv1z3BH/wsbStwDH6+3
 0Oa+g
X-Gm-Gg: ASbGncsCISOPT5DVCE3jyTvHlsVXVY1H8ORssM/T/cbELRfL2Tk//nqQJ8TcCt4hB4M
 u0bMRlqtJAgwLgNgN6EhW7adFK0vRj1/sheGOORUJtX6iotkAiTc+FNsbC4iNzcqgrBKcmt4QBC
 u+bPSALoEBZXlzQX6lP5BvjfVcgZEmwQVfY2JJpLehAG5ZT0Vc3OoTeVw3tEO1E7cM5BYdPNYGu
 uI8npFPQSDvZhHnK/dMW6h6FytcRL5gZ6bgw3oBp/3rpvMJaC6QuDVgQk8UG8tEJ2KRawzIAayl
 7IPgk2+c6fq8NxqCrumhhQ0NehblJSsxvScWvJMKSpzqOnPNiT9vG4tiil+HAn7+85r805BozFd
 klJs7oyFynC9iwGPmPVYxjo9ZP4Hq4ZmbaC08k023/cMHPQpfMknKB9QTNAP0mX6EFXgPv3ej1a
 b9igJn0pI+lVSlTiKIZ5R7JOD5QszN61LbxpuYGYRYbDfyf8XtAg==
X-Google-Smtp-Source: AGHT+IG5yGZW+84Xw0oDToQeF6eg9sRbXoCFYEr4NBKI8nTZtf/j0jFCfkCZ2CvUf0xFAy3PRB5ybA==
X-Received: by 2002:a17:903:32ce:b0:295:54cb:16ac with SMTP id
 d9443c01a7336-29554cb25f3mr121828145ad.18.1762188610349; 
 Mon, 03 Nov 2025 08:50:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 40/44] drivers/common: remove use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:45 -0800
Message-ID: <20251103164915.101713-41-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_bphy_irq.c   | 3 ++-
 drivers/common/cnxk/roc_npc.h        | 2 --
 drivers/common/mlx5/mlx5_common_mr.h | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/common/cnxk/roc_bphy_irq.c b/drivers/common/cnxk/roc_bphy_irq.c
index 7b39b61537..0c2dc04517 100644
--- a/drivers/common/cnxk/roc_bphy_irq.c
+++ b/drivers/common/cnxk/roc_bphy_irq.c
@@ -5,9 +5,10 @@
 #include <pthread.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
+#include <rte_bsd_queue.h>
+
 #include "roc_api.h"
 #include "roc_bphy_irq.h"
 
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index 91c84d7d97..f96c449ae8 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -5,8 +5,6 @@
 #ifndef _ROC_NPC_H_
 #define _ROC_NPC_H_
 
-#include <sys/queue.h>
-
 enum roc_npc_item_type {
 	ROC_NPC_ITEM_TYPE_VOID,
 	ROC_NPC_ITEM_TYPE_ANY,
diff --git a/drivers/common/mlx5/mlx5_common_mr.h b/drivers/common/mlx5/mlx5_common_mr.h
index cf7c685e9b..8bcc13f111 100644
--- a/drivers/common/mlx5/mlx5_common_mr.h
+++ b/drivers/common/mlx5/mlx5_common_mr.h
@@ -8,10 +8,9 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
-
 
 #include <rte_compat.h>
+#include <rte_bsd_queue.h>
 #include <rte_rwlock.h>
 #include <rte_bitmap.h>
 #include <rte_mbuf.h>
-- 
2.51.0

