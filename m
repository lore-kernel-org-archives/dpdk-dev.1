Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB99EC55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:20:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FE8840A8B;
	Sun,  2 Aug 2026 20:19:06 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 90B4D40671
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:57 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso2485173a91.1
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694737;
 x=1786299537; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+4Lod7esgwoloXCt6rGhR1rOmj8JmQPwx7czXDdY0ZQ=;
 b=sUfgtGakXQGY3i2ZS9XDIX308mhn9fadntKGiH/limOgl+6SSoDZLwMcKwo9C76Is5
 cXYDDiBs7myvaxWbQSwPE6cHWtRSene7x1rzxNUGoGUAmpAoyWcaLKeClo1fBGenMyYD
 eGl6EOxvR8//t6eBlEvdQNxOG4xChZmEJuLzdXncidLXRLunCf1UHxWU2cAgwJRWA4qW
 dAmvI8iARo2tgS47uBwxZWlTaCqX9UFpUqT1WG4lVhcSxC5lpXMbWYO+Lwnq4Oz/YOlv
 eUUhXxI4mW3xz6yRNe17aF6pz1BojBZ199FNScNa3yXlyfVT+xMOF4qOjJWRDWe5HrZI
 ugjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694737; x=1786299537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+4Lod7esgwoloXCt6rGhR1rOmj8JmQPwx7czXDdY0ZQ=;
 b=jJlntlZXmJmUSh+VaCy91hqOvWegKH91OAGBjcfJ1q7SmKGIFoQ97ts0Ttav5FzERZ
 JgwYq+jlTpwVnodAFQ7U0qHUwz+Oz+p19AlaZWsbOTHqHuv74bSpzLhFstdAwCeDmccV
 EJnCkRjaaBD93joYYby4s/PYXkFvpVBPzQ7oSXJw9pyzFmPpWVkeTMb9LNhwlJ4K3TUe
 v/FYZZutOyjVRrs7khf4VKGJqdXhKE7G2DPGaCFGmqrU4Wk0osCRbhyp5z+yFdxbwMW8
 I/Zcgf9T2gEIW44juDnKnQwm6yljZKXyNSZNLk/ML5hjYWqR8RbpIJxerd5o3rYZLOOF
 WOAA==
X-Gm-Message-State: AOJu0Yz6DDbxolWBsl7qxE7zFOlbJYWYirYUT/dyWrS6l/utVLbfAZr+
 Rm/0KWBkcjQuk1ljhneqMcUAblCg4+L9RgpjTIm/Nr+sZObytu1zK0rPEjVHeBSwfXFe6zdMzO2
 wXQlm
X-Gm-Gg: AR+sD12ygo71fa7RguCWbbKbfPxL3iFnPM2AzSPq3npPQ49r2B5CYYZbV6onms+mWNA
 v4689MqcDhqZTOsZd7AHeq9zM9ZpVGtoWRX8yHSwtbiya262JKRA4xmg0JuKI4l4ksVPS1w4adm
 oh5IwGFpryx5itk8/RazB4elR4TuSZ+l/55FEW4gX/iZ+FlxDryjI61uyfkgn7irk7ym/yjc9CR
 vU8I44ztkcCtvvkd1r2ZZVlYYVBWqhyPpZ8OcGA5zHqH03XrqnNRUw9+JZwFB81LwaC37dR/Car
 xB9J7GBUrjyETmDz21pqyPuAHTufBhCh8YZ2L257YW/6bs+1pnx9qLm/vilgGDOvWSTkYO7eFKx
 qBHYAEixpScmEWQrnpopQ1yCnJl0g1Llm40JhKa/Gt2B+ktLaEE3TbFAF0FwNGxAaW+B9t5kHhb
 n1oynghZrHqpfLmBBbSp6tHMe5NyLNKbWJ+LY16M1ePsNfTMNpyidTlOghvH+wbaZi86TjBZJv8
 TA1QsxMJfnt0FEB2+uwsMFs4aY=
X-Received: by 2002:a05:6a21:6282:b0:3c3:8e7f:4b1d with SMTP id
 adf61e73a8af0-3c92a8f3f44mr7332396637.59.1785694736729; 
 Sun, 02 Aug 2026 11:18:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [RFC 17/21] net/mlx5: include rte_flow as needed
Date: Sun,  2 Aug 2026 11:15:22 -0700
Message-ID: <20260802181835.476887-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

