Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6CECCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87E4440B94;
	Mon,  3 Nov 2025 17:49:47 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id D065E406B7
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:43 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-33067909400so3274194a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188583;
 x=1762793383; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HupPFHZg0cAJ4FSiYV+/6e9Y/2XkcqjfIzXFl6OWsAU=;
 b=xPSmS0/2xAgovi7xk5WoAPkiAdkyrQVUXcl3yCOS9bkFn9QW3HkI5pTv/7+SkqF1y1
 Dy1roh/dCMZOvxOc4KabFJoVYg6mi6jO3g2j27wT0NIPy1BsTuZC7sMt7AIbIeqW49f7
 vxVNztf2LQFL4U1j19rqW0Hjufc7FU/55GLM2bv5E8jtxA2ApoZLM5MHN96cuHPQLsAc
 AHW2AuVy+wYzSGKSCefWJpNRBtNCvsniuTILvgMY1ReWzUeHArTQlIfBIEW7e8T/hH6N
 Ostmbn+K2ATu4o78IE5fC54n2l07u2oeTLyMLADKZeMf8Vl4GP4HubaREm+3SXSqjEjE
 Mpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188583; x=1762793383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HupPFHZg0cAJ4FSiYV+/6e9Y/2XkcqjfIzXFl6OWsAU=;
 b=v8jwASmo0SHpzMaNQebJUTfm0CyiBaZuBbSXcyubjQVIKDEE//S0Naq9IEg+BLQ95K
 hrwfJuEF0prnRQzSxwoAYT5rpbzf5OCdJ/KebE6IXg8pQmBXriTAx/u5Cgw4JDDOA/ds
 gzlUsT3j1X+w/tztOWgzI4Jg2Vr3xkRnhYNBl0ovRbZsty9Q4c1gJbTkM+tfairWhN0z
 eyWRScnYKYaSBQlQdCtw8C6EK3r6QbJxPgK2dNcryUu5+FlZuIhX4tzqYbt4Otj0cvWN
 qSc6b18BlepCsiLmboaGRnEgcapYys0CkbG+0+5ACGM1bOYw+2q21P1taNzxg9cK8xIG
 +hIA==
X-Gm-Message-State: AOJu0YxGHk9Eyk7pJ7XuxqRMI1sP8/Dm0Lm2SC5s0XoOAQFK2a8ecGJa
 s6MbN8otL5WKSrrTDPkn+WZV9rAHxjIxAqWsrZoFwZE+szPnlrwXnUDGdwGPy5hIIHaeUkimGad
 CmQQl
X-Gm-Gg: ASbGncsK+RpRAN7EvGq2QDu0g/eOHfORDUd2vxH+wORKjgznHTN70fbw6b1Jowd7LIO
 dl1tEVwKagtNnzIvLa//zOipzIC9HM+aTB/T5TpcJPNQJHWo7tmoqAdZ5Xq9bMsuxmupY9lN21q
 NACLjCfaEBZ2AjRdPCXzU//2/lbUAUdKub3cGPrdTCo7mjfHJCr3R8qkdGCPAvKl9B1jlkmeYrH
 rT8MDOtEr7npCBARLvMssNwIQIFERe/FxeFBQHRvWqSyYrjBMVYHvhYApSUXPyZCgQKo3aQt9wa
 sJfngNq4R7WB8CdeMthbCfHNpLqX4jZ6/W71elBse5vHFpnl+7DEQqX3wk1yLW+L0wMFbzahYUL
 e2w6iaSuo6a9sKXk4FTamxpDKclwxMxeUH9iVZMt5O15ld+HMiLUSB3zXFAVEa3LWAw1Vt5dqRv
 zI6BJSnRCcidpnaGOB3OtVBoV2EP/sJBZN5P3dkPM=
X-Google-Smtp-Source: AGHT+IEd8kjUGYjVwD/OeR/SjejTH7hmFE8Cpc95uYJdcMNRHceziXJM/Vr0AIVYIlzWgd6sxtGuyQ==
X-Received: by 2002:a17:90b:5550:b0:32d:f352:f764 with SMTP id
 98e67ed59e1d1-34082fcc5eamr14240164a91.2.1762188582877; 
 Mon, 03 Nov 2025 08:49:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v3 16/44] net/intel: remove use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:21 -0800
Message-ID: <20251103164915.101713-17-stephen@networkplumber.org>
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

For all the drivers, remove use of sys/queue.h if not necessary.
Remove locally defined FOREACH_SAFE macros.
Use rte_bsd_queue.h instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c | 1 -
 drivers/net/intel/e1000/e1000_ethdev.h        | 1 -
 drivers/net/intel/e1000/em_ethdev.c           | 1 -
 drivers/net/intel/e1000/em_rxtx.c             | 1 -
 drivers/net/intel/e1000/igb_ethdev.c          | 2 +-
 drivers/net/intel/e1000/igb_flow.c            | 2 +-
 drivers/net/intel/e1000/igb_rxtx.c            | 1 -
 drivers/net/intel/i40e/i40e_ethdev.c          | 9 +++------
 drivers/net/intel/i40e/i40e_ethdev.h          | 1 -
 drivers/net/intel/i40e/i40e_fdir.c            | 2 +-
 drivers/net/intel/i40e/i40e_flow.c            | 1 -
 drivers/net/intel/i40e/i40e_hash.c            | 1 -
 drivers/net/intel/i40e/i40e_pf.c              | 1 -
 drivers/net/intel/i40e/i40e_rxtx.c            | 1 -
 drivers/net/intel/iavf/iavf.h                 | 1 -
 drivers/net/intel/iavf/iavf_ethdev.c          | 1 -
 drivers/net/intel/iavf/iavf_fdir.c            | 1 -
 drivers/net/intel/iavf/iavf_fsub.c            | 1 -
 drivers/net/intel/iavf/iavf_generic_flow.c    | 1 -
 drivers/net/intel/iavf/iavf_hash.c            | 1 -
 drivers/net/intel/iavf/iavf_rxtx.c            | 1 -
 drivers/net/intel/iavf/iavf_vchnl.c           | 7 -------
 drivers/net/intel/ice/base/ice_osdep.h        | 2 +-
 drivers/net/intel/ice/ice_acl_filter.c        | 1 -
 drivers/net/intel/ice/ice_dcf.c               | 2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        | 1 -
 drivers/net/intel/ice/ice_ethdev.c            | 8 ++------
 drivers/net/intel/ice/ice_generic_flow.c      | 1 -
 drivers/net/intel/ice/ice_hash.c              | 1 -
 drivers/net/intel/ice/ice_switch_filter.c     | 1 -
 drivers/net/intel/idpf/base/idpf_osdep.h      | 9 +--------
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      | 1 -
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        | 1 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        | 1 -
 drivers/net/intel/ixgbe/ixgbe_fdir.c          | 2 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 1 -
 38 files changed, 14 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
index 689ed82f18..98e7678a65 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2022 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/e1000/e1000_ethdev.h b/drivers/net/intel/e1000/e1000_ethdev.h
index 0907c7c259..3da4c5f4fd 100644
--- a/drivers/net/intel/e1000/e1000_ethdev.h
+++ b/drivers/net/intel/e1000/e1000_ethdev.h
@@ -6,7 +6,6 @@
 #define _E1000_ETHDEV_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_flow.h>
 #include <rte_time.h>
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index ec3924bf6b..89f217e5d0 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/e1000/em_rxtx.c b/drivers/net/intel/e1000/em_rxtx.c
index 54971fe285..b2342e3e72 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index f4e2a6442e..85549e5796 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/e1000/igb_flow.c b/drivers/net/intel/e1000/igb_flow.c
index ea9b290e1c..c8f8bc6c0e 100644
--- a/drivers/net/intel/e1000/igb_flow.c
+++ b/drivers/net/intel/e1000/igb_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index cdd7a3338f..e786a7fc18 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b8ce79061b..b298cae5a5 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -12,6 +12,7 @@
 #include <inttypes.h>
 #include <assert.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_common.h>
 #include <rte_eal.h>
 #include <rte_string_fns.h>
@@ -5098,16 +5099,12 @@ i40e_res_pool_destroy(struct i40e_res_pool_info *pool)
 	if (pool == NULL)
 		return;
 
-	for (entry = LIST_FIRST(&pool->alloc_list);
-			entry && (next_entry = LIST_NEXT(entry, next), 1);
-			entry = next_entry) {
+	LIST_FOREACH_SAFE(entry, &pool->alloc_list, next, next_entry) {
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
 
-	for (entry = LIST_FIRST(&pool->free_list);
-			entry && (next_entry = LIST_NEXT(entry, next), 1);
-			entry = next_entry) {
+	LIST_FOREACH_SAFE(entry, &pool->free_list, next, next_entry) {
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 3fca089d6c..2caaa42a00 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -6,7 +6,6 @@
 #define _I40E_ETHDEV_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_time.h>
 #include <rte_kvargs.h>
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 55d18c5d4a..eb838b7746 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index f130f53ae0..5f7b69c72f 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2016-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 3149682197..41761eb547 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/i40e/i40e_pf.c b/drivers/net/intel/i40e/i40e_pf.c
index ebe1deeade..06a468d388 100644
--- a/drivers/net/intel/i40e/i40e_pf.c
+++ b/drivers/net/intel/i40e/i40e_pf.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 255414dd03..f9b893aca7 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -10,7 +10,6 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index d78582e05c..4cc41ea4ef 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -5,7 +5,6 @@
 #ifndef _IAVF_ETHDEV_H_
 #define _IAVF_ETHDEV_H_
 
-#include <sys/queue.h>
 
 #include <rte_kvargs.h>
 #include <rte_tm_driver.h>
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 15e49fe248..957ad69387 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3,7 +3,6 @@
  */
 
 #include <ctype.h>
-#include <sys/queue.h>
 #include <stdalign.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 3213464254..7b418c6604 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index eb5a3feab1..12d59fb05c 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2022 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 6f6e95fc45..8f52b43b7c 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 217f0500ab..212048adf9 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index a3ef13c791..cc017611b2 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -10,7 +10,6 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_string_fns.h>
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 460035d772..bd0dd48b0f 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -52,13 +52,6 @@ static struct iavf_event_handler event_handler = {
 	.fd = {-1, -1},
 };
 
-#ifndef TAILQ_FOREACH_SAFE
-#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
-	for ((var) = TAILQ_FIRST((head)); \
-		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
-	(var) = (tvar))
-#endif
-
 static uint32_t
 iavf_dev_event_handle(void *param __rte_unused)
 {
diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index 21c460d007..218ae4157d 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -10,9 +10,9 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 #include <stdbool.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_common.h>
 #include <rte_memcpy.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 38e30a4f62..5469ded014 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 51716a4d5b..ac2f526382 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 81da5a4656..1f27ba711e 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -4,7 +4,6 @@
 
 #include <errno.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..5bf61fa59a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -941,16 +941,12 @@ ice_res_pool_destroy(struct ice_res_pool_info *pool)
 	if (!pool)
 		return;
 
-	for (entry = LIST_FIRST(&pool->alloc_list);
-	     entry && (next_entry = LIST_NEXT(entry, next), 1);
-	     entry = next_entry) {
+	LIST_FOREACH_SAFE(entry, &pool->alloc_list, next, next_entry) {
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
 
-	for (entry = LIST_FIRST(&pool->free_list);
-	     entry && (next_entry = LIST_NEXT(entry, next), 1);
-	     entry = next_entry) {
+	LIST_FOREACH_SAFE(entry, &pool->free_list, next, next_entry) {
 		LIST_REMOVE(entry, next);
 		rte_free(entry);
 	}
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 4049157eab..614b8ae280 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index aa6a21c055..b4516b1510 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 28bc775a2c..a40eafb977 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
index 47b95d0da6..bc25ec2ae4 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/base/idpf_osdep.h
@@ -10,7 +10,7 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdbool.h>
 
 #include <rte_common.h>
@@ -343,13 +343,6 @@ idpf_hweight32(u32 num)
 #define LIST_ENTRY_TYPE(type)	   LIST_ENTRY(type)
 #endif
 
-#ifndef LIST_FOREACH_SAFE
-#define LIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = LIST_FIRST((head));				\
-	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 #ifndef LIST_FOR_EACH_ENTRY_SAFE
 #define LIST_FOR_EACH_ENTRY_SAFE(pos, temp, head, entry_type, list)	\
 	LIST_FOREACH_SAFE(pos, head, list, temp)
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
index 4b93d2649e..e285fa65d6 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
@@ -11,7 +11,6 @@
 #include <limits.h>
 #include <net/if.h>
 #include <netinet/in.h>
-#include <sys/queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_flow_driver.h>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_flow.c b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
index a2f76268b5..843f9f6747 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_flow.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index bfc091c367..dade9d1699 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5393c81363..aba6e6d139 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -7,7 +7,6 @@
 
 #include <stdint.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include "base/ixgbe_type.h"
 #include "base/ixgbe_dcb.h"
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b6351bc2cf..4f65ede4fd 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -6,7 +6,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_interrupts.h>
 #include <rte_log.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 3b68d820ca..8353c50ae1 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 897ee2b671..74f88e3dfc 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3,7 +3,6 @@
  * Copyright 2014 6WIND S.A.
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.51.0

