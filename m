Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43670CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ACC240E17;
	Mon, 25 Aug 2025 05:43:15 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id A3D2140E22
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:43:13 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3c7edd71bbfso1316521f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093393;
 x=1756698193; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SskpvbGb9YAPyXQB1ZeGZ2Rh4vuA5EZJSgULjjNPwF4=;
 b=FxkHBo28zZIckX9Oem0W0/588yy+X7rOwTGCYOaZJjSkxmGH4uuI51zkUDM6DUuDs/
 kVElx18rKAIhagmsl3aoaFm563ePnWx7uTAlHLLf0OsBg4e/VxsjsXL/Q/aL4zqZXr60
 g6cZ2m2G46B1hj3CpB3/x7fU6EGJR5Up3WPNRKtGllNMvIrdnePkHtaMba9yuWvLYOZV
 vIjEYYkWL0IQ9eluAuw8k4oqmlWOUIWyDKYePKmC/1H7LWnIWVN82fkqoUMWAyAMO3rw
 5URArOHkYmHX/vqtub8BJGXZKqZ55qwSRuqE670A+E1cCult5it78C5HL0kywzqBr50k
 AVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093393; x=1756698193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SskpvbGb9YAPyXQB1ZeGZ2Rh4vuA5EZJSgULjjNPwF4=;
 b=NGQZ0BYO/v5pMxDRTwLoL5BL4to7yUWNsbMBPkbMlug+9iZqx+f37+ZYbBZq3wiC68
 xcmQh5REXjbbzFlfG9k9ZOiRqtVHAP0x/v87yYWQM6uFPHB9s8sBfe+JYHHmkm3XJfVE
 FypFoUWt1S/Qkp01JThBU/tVgL4/3VeDShjlDqnOXDXAhSDWZn62nHGVgWEBkJLsoiTx
 lJ4BPx5B59ognd3Kp3cEipBEdupRQwc0BgicgsZ+Zoleq3CYLr7kTVeoeSkV5qI+Lqgf
 /TxjVVCEEMgVCAjbuSKQyCOZohmctKAxKXfSOIERnIHXcAO9QK6QNlbRf56xpCQAyIep
 706w==
X-Gm-Message-State: AOJu0YzLcCR3thV2n20cVOb7nDbfIdg1rHZ2MSzUH/A0IgTl8Lj0Vwdv
 l1ACL/bhaX+4HzPTMnm/BGRgfjBeyFDEw8EhXxZRCPb27axtOQyPC8rncZThiwfhYlilRP4fWTE
 RIylEiNU=
X-Gm-Gg: ASbGncsgBlCOrlfE1O9P9FIX6yPu12HbEzGSlZaL0OLymB6+vwKOfzHqYaAXXQpBiK8
 A5ZAxohX1VLCBuQdKBzTepK/6JjTvL1zeCcy55uc2bTMNxAFuti2eNsAFFRs7DjPKYLYVULdsXO
 afu9aHvQcEvNGVycXhFWYIaH0kAK31r6T4uswgEIEW2r2lrQAtOlBS3kwY/oxozecaLv3Ix//mK
 iXH0Be2JPPcjxDYmvqZ1XyIslFzT9HyvtbbfV96pfmu+z39/Ezj3TPYHf+0BWKvIgEHoDSvj40p
 wpjUpySxpQJQ/JSxt+hiw1vLwFWKPyLYswga9dKu5se18X6cfLAb6onsRDZ/t0KCN333wc6GISS
 5kfP6rYFbvAc11QrwNyN0XQNku+yLS+BVj1fYdJ6DYwKhXmsniv2Mj5/zoxUqFxGEjPifFBM7yW
 zuMjyV9v8=
X-Google-Smtp-Source: AGHT+IHLIGDKMXOu2ApYDljRZV/WAHhHsAFjZew9uvL6RN58R4czaKcso7pUzV55ceA0LMpGhccohA==
X-Received: by 2002:a05:6000:3101:b0:3c9:b4e7:fd9 with SMTP id
 ffacd0b85a97d-3c9b4e7145emr865996f8f.40.1756093393227; 
 Sun, 24 Aug 2025 20:43:13 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:43:12 -0700 (PDT)
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
Subject: [PATCH v2 40/43] drivers/common: remove use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:53 -0700
Message-ID: <20250825034126.12046-41-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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
2.47.2

