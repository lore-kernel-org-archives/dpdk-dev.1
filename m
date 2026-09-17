Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2951AC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 17:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F90242FC7;
	Thu, 17 Sep 2026 19:21:29 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 20D6F42F9F
 for <dev@dpdk.org>; Thu, 17 Sep 2026 19:21:27 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso977735b3a.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789665686;
 x=1790270486; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iQAXr/6NDfRx1HQOGgRjEn+n2BXmNFshAPu+8LNw/RQ=;
 b=Uv53GbtLxkceRVtGd+yZ7mnt6xFpIIKzNnungXRreNx/SFITy89sgEP3MnHHwiEu6B
 LyIp8UhZ7niV1UWTBpM44axIoZuJZ9WGRMYURVrgcPEmE1IeSoOaWwvmmgPX1OfN2Gwt
 /UdamEPUZSmwV5w5fFjBFoRxMjYIM94PYyE/alV5IJjxUZWegz+W4RI+y+pJQmXBheDT
 +OBd1JwddTRG4aeGZ7NyGmuvVItoWA4XcT66/vqSZr5FTFN3G+0S1rldkdD/Yx2rd5XQ
 ae67RmUrjdSUBQXvjPnN89MAi0Dx/kMMC56fdPMYLA2lkYBNiJYTZdPV9zJmpRozf0Mc
 Ss0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665686; x=1790270486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iQAXr/6NDfRx1HQOGgRjEn+n2BXmNFshAPu+8LNw/RQ=;
 b=uo68tk688ezpP4tKT0ECMX4NFlkXKhrQqy/UyVTkRNNmJbDaJWBici3D+diZcPYepv
 bm3rc7MPpMyB77grwCQ69aRBJyjs6woU7rTbt+u/gRAWZb8S0LUsAgs3TYtRhlrk3N/c
 /e6MuipmkWjYZASahCwPTtN18RjeS8vtKESWvR2rbUA8SfZGMR+H3vNDNiDd458UpvTz
 gAqsOypd3AANdheLcjDox0QwVBRqq6rg3JQeFcfHs83eUCM8NtO4rkpodAIRE4NSErld
 Z06EpOXOQj9sTnUL/Si5KCajy7yp0ITMHIRtmzHC0MthTq++I0ggEcMdMl4cjpcuzLEL
 KmFA==
X-Gm-Message-State: AFuF++mT605nz/zBIRt3ZhSbZAjEYCUp6PDb1kaaQTttfzPrblEmu82K
 GEhUUtik7gOYVkaS1jplDMYfYyOU8OcQTXncDtAFTJDdhJ/dKrVzIQ0WJi4xwURkRBggmnUtWGm
 zmyVU
X-Gm-Gg: AYBFou3VIKogH1Ng2qA+fMOZuDiftiP4D8an0PxSvfEqtbFKraEp96HmldECVtubJ6m
 A2s2MAZsf6d29vHKPb2GDoSarihE1xN96/Km1r+Qy/PBBSmeOu02wP8VQxDiZcDilAnRMhFtA5u
 CGOTeltEH6QB5ktiANGp7ELU4SZIznH2n6I5GMhHqEakhH6J2HYOx0zy5XZm92NUKyrsqA+SJ8T
 alWCvU2aSxWJ9XNj0FeFEwgRgMyKqTUIJN7Db9AfPkoPXm/XN0mQgtN96EqKVCdP9wZvXjb7IDQ
 Pst8TNj4zrtr+gkId8DSmPIjmT4EEofH1dIpNWngQLwF+zDCU7Mshfn5fyBRnLaAp3qyT0WwU7t
 ChRffkLmPZ7M7clalISbWj6y2a38+zsgHA+aPD0LgHM71ulbT7IB1idKuvYv8iHI4zkcblZAvS6
 hYCpDmN1x9yBLGF2us/inocLsWNphDd3sbwklpLMjfooLR2QMmUIzEnLfMRDPGnyvm7HxgNc2P+
 UCvRK4dDznoSBKEm+NHP8EvpnVmEC90e1fkneo=
X-Received: by 2002:a05:6a00:9094:b0:85a:bc69:bfc4 with SMTP id
 d2e1a72fcca58-8723412fe92mr17892308b3a.0.1789665686131; 
 Thu, 17 Sep 2026 10:21:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87379a2e079sm1447408b3a.31.2026.09.17.10.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:21:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Jie Liu <liujie5@linkdatatechnology.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>, Wei Hu <weh@microsoft.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Rosen Xu <rosen.xu@altera.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH 4/6] build: remove private FOREACH_SAFE definitions
Date: Thu, 17 Sep 2026 10:19:42 -0700
Message-ID: <20260917172116.660120-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917172116.660120-1-stephen@networkplumber.org>
References: <20260917172116.660120-1-stephen@networkplumber.org>
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

Ten files carried their own copy of LIST_FOREACH_SAFE,
SLIST_FOREACH_SAFE, STAILQ_FOREACH_SAFE or TAILQ_FOREACH_SAFE, because
glibc does not provide them. They all now get the macros from
rte_queue.h, so drop the private copies.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c  | 7 -------
 drivers/common/sxe2/sxe2_osal.h           | 8 +-------
 drivers/net/bnxt/bnxt_filter.c            | 7 -------
 drivers/net/intel/iavf/iavf_vchnl.c       | 8 +-------
 drivers/net/intel/idpf/base/idpf_osdep.h  | 7 -------
 drivers/net/netvsc/hn_ethdev.c            | 8 +-------
 drivers/net/nfp/nfp_mtr.c                 | 8 +-------
 drivers/net/qede/qede_filter.c            | 8 +-------
 drivers/raw/ifpga/base/opae_intel_max10.c | 8 +-------
 lib/bpf/bpf_validate_debug.c              | 9 +--------
 10 files changed, 7 insertions(+), 71 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 9dbf5f413e..fb7ecff468 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -41,13 +41,6 @@
 #include "dpaa2_hw_dpio.h"
 #include <mc/fsl_dpmng.h>
 
-#ifndef TAILQ_FOREACH_SAFE
-#define	TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = TAILQ_FIRST((head));				\
-	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 #define NUM_HOST_CPUS RTE_MAX_LCORE
 
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_io_portal)
diff --git a/drivers/common/sxe2/sxe2_osal.h b/drivers/common/sxe2/sxe2_osal.h
index 9f0ee73b5a..fccc7d35e7 100644
--- a/drivers/common/sxe2/sxe2_osal.h
+++ b/drivers/common/sxe2/sxe2_osal.h
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 
 #include <rte_common.h>
+#include <rte_queue.h>
 #include <rte_cycles.h>
 #include <rte_malloc.h>
 #include <rte_ether.h>
@@ -24,13 +25,6 @@
 #define BIT_WORD(nr)      ((nr) / __BITS_PER_LONG)
 #define BIT_MASK(nr)      (1UL << ((nr) % __BITS_PER_LONG))
 
-#ifndef TAILQ_FOREACH_SAFE
-#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
-	for ((var) = TAILQ_FIRST((head)); \
-		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
-		(var) = (tvar))
-#endif
-
 #define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
 #define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
 
diff --git a/drivers/net/bnxt/bnxt_filter.c b/drivers/net/bnxt/bnxt_filter.c
index a4df485965..9a1b294dc0 100644
--- a/drivers/net/bnxt/bnxt_filter.c
+++ b/drivers/net/bnxt/bnxt_filter.c
@@ -18,13 +18,6 @@
 #include "bnxt_vnic.h"
 #include "hsi_struct_def_dpdk.h"
 
-#ifndef STAILQ_FOREACH_SAFE
-#define	STAILQ_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = STAILQ_FIRST((head));				\
-	    (var) && ((tvar) = STAILQ_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 /*
  * Filter Functions
  */
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index f8fffa7802..e876e830e7 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -12,6 +12,7 @@
 #include <inttypes.h>
 #include <rte_byteorder.h>
 #include <rte_common.h>
+#include <rte_queue.h>
 #include <rte_os_shim.h>
 
 #include <rte_debug.h>
@@ -52,13 +53,6 @@ static struct iavf_event_handler event_handler = {
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
diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
index 207eefd100..f651559475 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/base/idpf_osdep.h
@@ -342,13 +342,6 @@ idpf_hweight32(u32 num)
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
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 9a193e4a7a..2c6a6c5857 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -17,6 +17,7 @@
 
 #include <rte_ethdev.h>
 #include <rte_memcpy.h>
+#include <rte_queue.h>
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
 #include <rte_devargs.h>
@@ -41,13 +42,6 @@
 #include "hn_nvs.h"
 #include "ndis.h"
 
-#ifndef LIST_FOREACH_SAFE
-#define LIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = LIST_FIRST((head));				\
-	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 /* Spinlock for netvsc_shared_data */
 static rte_spinlock_t netvsc_shared_data_lock = RTE_SPINLOCK_INITIALIZER;
 
diff --git a/drivers/net/nfp/nfp_mtr.c b/drivers/net/nfp/nfp_mtr.c
index 4833ebd881..a89214d6e3 100644
--- a/drivers/net/nfp/nfp_mtr.c
+++ b/drivers/net/nfp/nfp_mtr.c
@@ -7,18 +7,12 @@
 
 #include <rte_alarm.h>
 #include <rte_malloc.h>
+#include <rte_queue.h>
 #include <rte_mtr_driver.h>
 
 #include "flower/nfp_flower_representor.h"
 #include "nfp_logs.h"
 
-#ifndef LIST_FOREACH_SAFE
-#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = LIST_FIRST((head));				\
-	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 #define NFP_MAX_POLICY_CNT             NFP_MAX_MTR_CNT
 #define NFP_MAX_PROFILE_CNT            NFP_MAX_MTR_CNT
 
diff --git a/drivers/net/qede/qede_filter.c b/drivers/net/qede/qede_filter.c
index cecb58c997..799cd535f7 100644
--- a/drivers/net/qede/qede_filter.c
+++ b/drivers/net/qede/qede_filter.c
@@ -8,17 +8,11 @@
 #include <rte_tcp.h>
 #include <rte_sctp.h>
 #include <rte_errno.h>
+#include <rte_queue.h>
 #include <rte_flow_driver.h>
 
 #include "qede_ethdev.h"
 
-#ifndef SLIST_FOREACH_SAFE
-#define	SLIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = SLIST_FIRST((head));				\
-	    (var) && ((tvar) = SLIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 /* VXLAN tunnel classification mapping */
 const struct _qede_udp_tunn_types {
 	uint16_t rte_filter_type;
diff --git a/drivers/raw/ifpga/base/opae_intel_max10.c b/drivers/raw/ifpga/base/opae_intel_max10.c
index 58c884a8d8..1a4db13671 100644
--- a/drivers/raw/ifpga/base/opae_intel_max10.c
+++ b/drivers/raw/ifpga/base/opae_intel_max10.c
@@ -4,15 +4,9 @@
 
 #include "opae_intel_max10.h"
 #include <libfdt.h>
+#include <rte_queue.h>
 #include "opae_osdep.h"
 
-#ifndef TAILQ_FOREACH_SAFE
-#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
-	for ((var) = TAILQ_FIRST((head)); \
-		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
-	(var) = (tvar))
-#endif
-
 int max10_sys_read(struct intel_max10_device *dev,
 	unsigned int offset, unsigned int *val)
 {
diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index 5d18804a74..5c7c0e19bc 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -10,19 +10,12 @@
 #include <rte_bpf_validate_debug.h>
 #include <rte_errno.h>
 #include <rte_per_lcore.h>
+#include <rte_queue.h>
 
 #include <errno.h>
 #include <stddef.h>
 #include <stdlib.h>
 
-#ifndef LIST_FOREACH_SAFE
-/* We need this macro which neither Linux nor EAL for Linux include yet. */
-#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = LIST_FIRST((head));				\
-	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 #define EVENT_ARRAY_LENGTH RTE_BPF_VALIDATE_DEBUG_EVENT_END
 
 struct rte_bpf_validate_debug_point {
-- 
2.53.0

