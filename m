Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F31CC55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA52F40E0A;
	Tue,  4 Aug 2026 17:46:18 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id D02FE40DDC
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:17 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso3497020a91.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858377;
 x=1786463177; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+4Lod7esgwoloXCt6rGhR1rOmj8JmQPwx7czXDdY0ZQ=;
 b=wstBaqA4xIZROxnCYaXg6Fgdj4Malb11bHvvcBUEsrXbNmgvtLb3wpYABZ5VxEirIC
 uISde6jaGoeZCLJaeR1VI4Rhvd3R8FElez9djoOFJf4rIL0IWeCdNJ/QljB1ql433juu
 MCLGVoZLKh5poPa/vGQ4Aq9FM714FSYXw+CiPKB41741i049ubTxxxfsf+FLIcbu4Ak4
 aX7lcp7wnRDBon2B2weT4tKo7c3ljVIfE0v/d6QKL2RJwwIjPSQA6bJINrWfxDcIiIYi
 GoasLDJOzbbNUZwpVvp3WR254ID3Gs/c1Ln8ndOLIy06y6kRGklEfyedX81z92vcYTRz
 W1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858377; x=1786463177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+4Lod7esgwoloXCt6rGhR1rOmj8JmQPwx7czXDdY0ZQ=;
 b=R5hUZM/V5VqDu/ip3PwOoqoZH7Twu3BSV8sbYv7qBeL53fbqjsekLuj+8izEk4nnCS
 iL9RJwVaP1WC03CfKeSdRn6VR5pCn0A1/Q56yg3cng8ghvMiyiThf8AHNgmmviUCw6fO
 3BqzEhZ43jHfo5qOE338USiN1eoas8iIRntZcLsEAFM6Wuj8mR7cq4Vvvc3D24ByIHqV
 sUphcSTQj58vgClorGaui7UJl067dCdTqTCSl/Y61X7+UVA43XzoX2MlDcyAdnjg5itJ
 /++B8WP1DXPM5QbMJ8mgI/KQ6KinI6vXYwWVRcKgx4OxpDJKgH8q7dcaUM9A+bl6ByyS
 sIOg==
X-Gm-Message-State: AOJu0Yzm6BkUZAqw5cCAem/imFd8+xRiMLcssDn5LYXoAe2NLyHibPS5
 6JUdLlijfZ5EYuWdOZsK3uxW2annlVE48OZHU2ss3skCPId9b3filNOitcS/1gEimAG0A+34LNS
 EmY6i
X-Gm-Gg: AR+sD130pM2TR0Ww6mm0XZUyYjtBDUj+wTnD/9FMcKFr0PxllXUdIXWLAalZHFoMiSC
 UAF9h0OrWI2ajSJC+V0nm8/o2uiSlGfpSb2C7UTec0DgQl55wVjXpgHmLo/lbItppBLPlppGV7u
 yyaViXVrhLDjOj6n6TQH/FeDI0Oyr61PU2j5Fnmb1/SGo2Y7V1oGLOXtv9H6eNG2BkqoPy1ZEZp
 75lv75et0jKJvesiSYhrsH+J9sphGkursK9MKl8dpbSKagAA5IL+5Mo5Dp42K7u62/PB8aAf7TV
 yjjp4ALs/Qao9HDsmYqZnV6g+ezuxOj5X2cO9OIU0e8fVHXWGBU7ze+TCXJP7O1pT4WKC3NLJGL
 QhYRAokZg7QfcxUYzD5K8JHsh+hVbV6ZBm0txPGVXdVnasjG+177/cTzrUQhU/iyZFmt+2IBoNA
 xGtmrAcJ3ipUiwW9ZfDCW5biZ8FPHMS2K+dyVRKXcLjUs5ou3pv6KelZc6zDyma1qpYnWXrFXt1
 +RDDOzz/E9wnJ0Kr4tTM12l/9s=
X-Received: by 2002:a17:90b:2d84:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-3903c538263mr134795a91.8.1785858376917; 
 Tue, 04 Aug 2026 08:46:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 18/23] net/mlx5: include rte_flow as needed
Date: Tue,  4 Aug 2026 08:45:06 -0700
Message-ID: <20260804154549.148691-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

The driver was getting rte_flow.h included indirectly via
rte_ethdev.h. This will change in future and driver should
include it where needed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/mlx5_ethdev.c | 1 +
 drivers/net/mlx5/mlx5_flow.h   | 1 +
 drivers/net/mlx5/mlx5_txq.c    | 1 +
 drivers/net/mlx5/mlx5_utils.c  | 1 +
 drivers/net/mlx5/mlx5_utils.h  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 8160d10e7e..c3d8e1b04f 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -19,6 +19,7 @@
 #include <rte_string_fns.h>
 #include <rte_rwlock.h>
 #include <rte_cycles.h>
+#include <rte_flow.h>
 
 #include <mlx5_malloc.h>
 
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 3415b4722e..0da50fab85 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -12,6 +12,7 @@
 
 #include <rte_alarm.h>
 #include <rte_mtr.h>
+#include <rte_flow.h>
 
 #include <mlx5_glue.h>
 #include <mlx5_prm.h>
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index f9b254c6c5..f0b7b2d032 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -18,6 +18,7 @@
 #include <rte_common.h>
 #include <rte_eal_paging.h>
 #include <rte_bitops.h>
+#include <rte_flow.h>
 
 #include <mlx5_common.h>
 #include <mlx5_common_mr.h>
diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index 606743c4b7..12820054ff 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_malloc.h>
+#include <rte_flow.h>
 
 #include <mlx5_malloc.h>
 
diff --git a/drivers/net/mlx5/mlx5_utils.h b/drivers/net/mlx5/mlx5_utils.h
index 9ab79c8ad5..19d03145a6 100644
--- a/drivers/net/mlx5/mlx5_utils.h
+++ b/drivers/net/mlx5/mlx5_utils.h
@@ -16,6 +16,7 @@
 #include <rte_rwlock.h>
 #include <rte_memory.h>
 #include <rte_bitmap.h>
+#include <rte_flow.h>
 
 #include <mlx5_common.h>
 #include <mlx5_common_utils.h>
-- 
2.53.0

