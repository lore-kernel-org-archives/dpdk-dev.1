Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41565C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0861F40DDD;
	Thu,  6 Aug 2026 07:10:36 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id B7BAB40DDC
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:34 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso6501905ad.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993034;
 x=1786597834; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+4Lod7esgwoloXCt6rGhR1rOmj8JmQPwx7czXDdY0ZQ=;
 b=AHaM4YKN1Z60vUaqtioI+BqednLcGg7DN72eD/pMh2V99XFRda+atmmHqh4+eVzeAg
 3Xb29yKqxH04mgVkSGqwerP71iBEcjylXDLythUMNVTdRs2DGqtz0OfKyssywhyy3PjE
 FlcVYBA29oIFp1JSk7utnYNMVzIuPI4UJ/Pdrjpat7wGBb6NuDmPCmXHqnXwGI/3u6fO
 +zby5d+0RcaQ84phk+KhWhpE/HnQbMBmRFgI6/5hFfzqfWZ/Q8ep5nx0tiVMcvSenfzI
 J7n7bfNBzHERsAfbgLroLovq4FO/1R7+Pt+7y0QjkOTn44MSDABx7il8egM2EASnhKHL
 dg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993034; x=1786597834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+4Lod7esgwoloXCt6rGhR1rOmj8JmQPwx7czXDdY0ZQ=;
 b=hGkGgd96ZZAZE92cuU/Wlj5yp1F9qPrDTjlpSPHkk2e8HsNvUuzhD0VY7Hf5smlLZb
 fp5WmNlGt79DPyAfgZ4/omBoUx6QXf+2XVwZtq1A09gz+FvWINIKW56nOOJys3CGOid1
 Yc7h4WTxCvuUPl7zxZtr5cLBxbx4UG5EcS1c+tgu9EcwbwFuShL9Lc50Om6VsuI4dBxj
 JwqwaJd9OfPfi4knXk37v6IWsk80Qz2fqTixyRY4bWwaV0RpA2+RQqyeDnLXN4NsRLWO
 6rasG3XqbxH1AMg6kzd/hPRceZ9rCsB3Dif5/2iCS4nuASUjX4BLE79LSHATSm7g20cS
 SAQw==
X-Gm-Message-State: AOJu0Yw8yRP5ZtMnb6t5b/+XiNZSgN0gpRhjzT+RQ2LJ6impJh2nx+DM
 kSQO+7HPDBU0hjdx1EHfbR6b4vYcHG/UN18DDA4oH1Ij16PJA3DN/9gK1i88Rca1og4fDfAiK5J
 mB/mf3lQ=
X-Gm-Gg: AR+sD11qCeqhJkDPN3KvSnxstbKsRCDZi/ewcgeOX8RWVDYabBcwqOlzSdKOMjgqNMm
 Jrsw4w5IxQGL1D+nshe+6chI7Btg6GtyAr3LIHMlxA9/Q338+ZbqCjLjXzaZFpv8ZeE1tPOeExy
 kuO7pJ6ArC0ZVl8kWN+SOe8eMWNK6bSOJu3jbi2a56tG6seCkZERgYj+qhzlAmqTYmj4aILz+gC
 jT9qggzzB6wwfYMudj4on+OZZsdUa3LYYhhEMOURopkzyavtQ8w7O+kPmo/T612sTKddBm64+9a
 SyCmnZ9ZOhJAkFmHWm6PP52/Xmo7ciQfrFOTzUhzYsAgBMx40wdKXkAh8oNPlmsUOz06v4Do/IJ
 1NU0aCh1g7AOk+yvYGtF8hPGKPvQg3P4pqFfqv3A9012naf+x152CmHQFeSvLkzrwhC1txsB6mk
 9BSREYYG9favWyCzU0DU+8u4vtz0Nm45VwbO6CUfsNv80mKc53CxxR4hOnuNGFHA1wVIBWjgu6u
 SqfkWCVoYJiLFvV7tiQxkUOaTg=
X-Received: by 2002:a17:902:ea0b:b0:2ca:f417:396b with SMTP id
 d9443c01a7336-2d0f18623e5mr38532005ad.3.1785993033946; 
 Wed, 05 Aug 2026 22:10:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v4 18/23] net/mlx5: include rte_flow as needed
Date: Wed,  5 Aug 2026 22:09:12 -0700
Message-ID: <20260806051004.166778-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

