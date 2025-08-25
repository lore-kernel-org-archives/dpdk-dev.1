Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317B1CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCDC8406BA;
	Mon, 25 Aug 2025 05:42:37 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 7116F4042C
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:22 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45b60fd5a1dso3023095e9.2
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093342;
 x=1756698142; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8Ae3AlIANO+FViRV0PIBZWETGBBXTZPFM/8CV7826w=;
 b=kl2CzmDCppaUmEgFcS/vLHTEaijKhGDsQYf8KnTbyMw0oQwleWG8KPZ/Xl5AaRlT1r
 bqSZVEIUhVdhFSi6Zx1e4nsyRvm2dvhIv1BxYbY6txXKGJBVlc6pjCHbqKQvIag6bSvR
 VnIBdFk0PSyuRi9d7pAxUkc/jJ9U8MgT4E5L9CcqOH8m+2cwCIjiAFZbgsiJZqFfEslY
 pogb5eOznlYlW7izwF6lNYu0EQ81t1SoX1+02JwvbSW+UyUkfgFCxHKORIGpPk+/+doa
 dbX2g+PIsZOy2q7YTEJMN4FAR2dU7T1ze381ft1P5ZvswBTURR6xC1evncEYN1KTA9vi
 O9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093342; x=1756698142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8Ae3AlIANO+FViRV0PIBZWETGBBXTZPFM/8CV7826w=;
 b=LOirizKxrxrUecFImMJhydK0jwUWOQpPEb74oVFGmuQqZYDRjL7lrcpXFdzpoQnJq8
 chDbd95VP+9Z8muypzwNm2zJ4ja3up71rSJIHK/kmj8YJbZ8ritmY2esrs31KDOrSTB2
 k3aVlZVTNCjwMJQYJDtlU7U2856VjwUTU+KjhhRkEfKtYzOs/khqcJbtp7Bjjj/blkKw
 QAaERXWifA/uEuOlMmu4ZdxZsoQeRUx/rXu+RxAKj9SPc7F2lqBnG8WhkwcWXwCbq4hN
 lzZq4Be/b1K/aqGvHJtHE3nEADSW7iaM4u0VMxls11TV8HQbEoG4awcABwK/54DN/xJo
 3GoA==
X-Gm-Message-State: AOJu0YzLfSoNSqSP66HnJhT5b029QqoR42NfwdCbjg5VO2fu50MDhzAm
 Rw6nBVPHMd1zfl0MJlgAeAHU6TmASl3zxQyrGAzeG1rUglDobPLLCM19Fwh5cUDp2YRD/uwhOel
 hUDt/
X-Gm-Gg: ASbGnctoumN7snpBD0I2Mn+AnwncxpKWjFeVMTasrvO6TBAx2Gwg5IHRxxm04Nn2dXH
 0WXyaN0ujiKzuboM82MF7dhVC4G2omJaOcRd+jdQLU1rKZTi/NbEIUrstqFD/OWsAjc6vKk4VdE
 uifrKKBJCh9VQ9oAQ6zxr9xfnQQu9Iy6BogH/8pYOYUoWoqmWvD5raM0SQ+mCluNFW+8+DDoxgG
 fA4Ycl8kAzJ168uZTAxmwDxpCzUkb5lNjkLt9SBjGZM42zmuI2c/qNO6GpCBXXxR/PSTZSIlVch
 QoOsJQJ4wVR4EdtKq4WxZdgiD+xQNsf4B8i02LllVI0Om0RnXS+rNxI/cCkDCJENE6r7Cn08jBE
 6CXJEzCn+mXa+jtSuahJkFH1zPUqwj5gDX4GIoEPSUo1RJz88QGydx0xTbyl7pFZggqLpcEbV
X-Google-Smtp-Source: AGHT+IHJR0xPljVTOxFisAsqZpV1gHLWTZuQzYnjPyT/nHSEDDTV4nw3AZV+/Oj8Hl/EO3kbSyNx8A==
X-Received: by 2002:a05:6000:2382:b0:3c6:e311:e33b with SMTP id
 ffacd0b85a97d-3c6e32128a0mr4981276f8f.33.1756093342026; 
 Sun, 24 Aug 2025 20:42:22 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v2 16/43] net/intel: remove use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:29 -0700
Message-ID: <20250825034126.12046-17-stephen@networkplumber.org>
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
index 339ae1f4b6..f80afdffdc 100644
--- a/drivers/net/intel/e1000/e1000_ethdev.h
+++ b/drivers/net/intel/e1000/e1000_ethdev.h
@@ -6,7 +6,6 @@
 #define _E1000_ETHDEV_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_flow.h>
 #include <rte_time.h>
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index 39dddf3384..e14adddcab 100644
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
index e3d8967a5c..d22495a436 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index 124cf75762..973b07f701 100644
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
index b63de2354f..b045d80e53 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 7a562a6e0b..f1db0edc3c 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -12,6 +12,7 @@
 #include <inttypes.h>
 #include <assert.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_common.h>
 #include <rte_eal.h>
 #include <rte_string_fns.h>
@@ -5097,16 +5098,12 @@ i40e_res_pool_destroy(struct i40e_res_pool_info *pool)
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
index 44864292d0..7d20bd301b 100644
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
index 02e1457d80..71658fce8d 100644
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
index aba3c11ee5..e60e54c029 100644
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
index f81c939c96..485c9968f8 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -5,7 +5,6 @@
 #ifndef _IAVF_ETHDEV_H_
 #define _IAVF_ETHDEV_H_
 
-#include <sys/queue.h>
 
 #include <rte_kvargs.h>
 #include <rte_tm_driver.h>
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 335a8126c4..e517047bf4 100644
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
index 7033a74610..fee433e595 100644
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
index b1b7a5bf94..bf85a9bc23 100644
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
index 83cb3e36f9..ad6a9a93ee 100644
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
index 499062be40..dc192c1a6c 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -4,7 +4,6 @@
 
 #include <errno.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..8855af91cb 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -883,16 +883,12 @@ ice_res_pool_destroy(struct ice_res_pool_info *pool)
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
index 7b43df3079..0440a144a8 100644
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
index 4f0343245e..63486d65b4 100644
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
index 86da9fc89b..1bc310d85f 100644
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
index 6278646720..8d5149effa 100644
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
index bbe665a6ff..fd5841c70d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3,7 +3,6 @@
  * Copyright 2014 6WIND S.A.
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.47.2

