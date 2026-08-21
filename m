Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4572C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B3004067D;
	Fri, 21 Aug 2026 21:28:01 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id DB3834067D
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:27:59 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso1051693a12.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340479;
 x=1787945279; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wIbkMNpgVWIkidp+NMwuPrNQG8+S+OVVZEDNSpfW4Fc=;
 b=GxbQCiR48a0iu512RjO5/lKXSenObsANTRbGopZzcO0Ja2Ajzmg6nevx+G5oNg3DhK
 zjyrjlYzqioBcv8A01VU9xjLSF9vq8Zg/YTydG8Q4LrMCc3uK8gaL90QNpNpmBjtvoFL
 4wehy7Hm9GO9Ilz3hJH3WeUB+diUW9CuhTwflFawWNMviBWif81CLryaUfs4zET0aTVH
 H/4D+UX8cfGylNybSlY2a/+zXBXMv+Wt/n6CKmHKAaqtdkH84LiD3td00V+fqB0IC90N
 1xA9wk7voFo1UOyWdlGaZRS/hKzngfpYPPIwu6Cr15wZX+LHcODWQAmaSCmcNXQ/4TMe
 Y3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340479; x=1787945279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wIbkMNpgVWIkidp+NMwuPrNQG8+S+OVVZEDNSpfW4Fc=;
 b=BFOMn380OfgzNA1A/934BaRd52FtvpTAu9lgFXnN+7QDZsEVXUPEPFbQcaGrebKnS3
 bvFH53tG5Hk0ZuVrc2aJIBVU8TQGR6LuJg3rqHLWfEb09/+cNvTRvh9LtQ2ncvRFheyo
 XsG0ScvCy4mdUAbcYVQqhSIq8NdZ+LlYs78pOFE/JdF4DeS+poeQMx5kkiEROSw3b16z
 Z/TR/kk5PJ1vBAlPwQV2zOA8VwR5Wym6Xg/wAENBX/DB5LCmC1jAVsoC+ddB36wVg5+U
 jv22JScozstYCVzlFb16T+A+/EzEv1vUv3POMW89DCwJd8LQ/VkjEF/iQigMTaRJtt32
 86DA==
X-Gm-Message-State: AFuF++nmVHXXsMPv0OaUol7Qacmld/P1sZo6CHmD44DBbF2ZUmnqg0aX
 FknHqv9m33DcaeYlKwaZ9SJ7uOE7TLE+YIqLny4BehzEHyhbql5+NQ/b8KNHa1Q4o1Asd/CpJ99
 kfwei
X-Gm-Gg: AR+sD13ox14QZdgDLaBwZYVywBwuBsSXcO6a3gEHhvd/XL3KkrC1bCJpU5MZ7w46kSX
 xRtcCTJndqnK/xn5Eksm/KZo6v3c4XDlxJHOU6zHS/zYZ09AsaxbWWTgdIQlQGf1MRcs5uabUOM
 01Obd81m2/Jq2TvEecoBN8VZzPh/5igl/+2KMWn4Eqt615MH939eHN7USCd4Any1/CCemTMqKuL
 U6fe/VM32iDHeORZQo6U5HACricg9SqnBKh5fju30gpPdCrGuZtLHXNpbM0id4Np4KLb2mHQ5os
 fyIfun/uMtK+rwCoVh5Rg6hi3Os0YjeRCYTcNnN9Y2lVPA+TuJ04FH4HP6LqfoAAYup60SjG4lA
 JDWWCBXMjcllZ1tTBTtPQ9eRDAj8WgnUWYdtYziLr+QWniwU+AY6li23J36OOzOtqhAfrSoULDN
 VzCJjkf/HtKmL+knHEoJXSkA80AhH9z0wRNLMKrdNmNxvV9eWvHIRHwtIQguNkf+V9gRjlTou1e
 jdef/tkJ/rbyf/d0MhGCe4F17lOK2J/YJsRnwY=
X-Received: by 2002:a05:6a21:3293:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3cd4ba80d89mr1548335637.8.1787340478998; 
 Fri, 21 Aug 2026 12:27:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:27:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>,
 Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Matan Azrad <matan@nvidia.com>, Michael Shamis <michaelsh@marvell.com>,
 Liron Himi <lironh@marvell.com>, Jay Zhou <jianjay.zhou@huawei.com>
Subject: [PATCH v2 04/68] crypto: add missing include of rte_memcpy.h
Date: Fri, 21 Aug 2026 12:23:59 -0700
Message-ID: <20260821192646.146382-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

These files use rte_memcpy() but relied on rte_memcpy.h being
included indirectly via another header. Add the direct include
so that later patches which remove now-unnecessary includes of
rte_memcpy.h do not break the build.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/armv8/rte_armv8_pmd.c               | 1 +
 drivers/crypto/caam_jr/caam_jr.c                   | 1 +
 drivers/crypto/ccp/ccp_crypto.c                    | 1 +
 drivers/crypto/cnxk/cn10k_tls_ops.h                | 1 +
 drivers/crypto/cnxk/cn20k_tls_ops.h                | 1 +
 drivers/crypto/cnxk/cnxk_ae.h                      | 1 +
 drivers/crypto/cnxk/cnxk_se.h                      | 1 +
 drivers/crypto/dpaa2_sec/dpaa2_sec_raw_dp.c        | 1 +
 drivers/crypto/dpaa_sec/dpaa_sec_raw_dp.c          | 1 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c             | 1 +
 drivers/crypto/ipsec_mb/pmd_snow3g.c               | 1 +
 drivers/crypto/mlx5/mlx5_crypto_gcm.c              | 1 +
 drivers/crypto/mvsam/rte_mrvl_pmd.c                | 1 +
 drivers/crypto/openssl/rte_openssl_pmd.c           | 1 +
 drivers/crypto/qat/asym/qat_asym.c                 | 1 +
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c       | 1 +
 drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c    | 1 +
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h       | 1 +
 drivers/crypto/scheduler/rte_cryptodev_scheduler.c | 1 +
 drivers/crypto/virtio/virtio_cryptodev.c           | 1 +
 drivers/crypto/virtio/virtio_rxtx.c                | 1 +
 21 files changed, 21 insertions(+)

diff --git a/drivers/crypto/armv8/rte_armv8_pmd.c b/drivers/crypto/armv8/rte_armv8_pmd.c
index a7caac186d..f99f7ef636 100644
--- a/drivers/crypto/armv8/rte_armv8_pmd.c
+++ b/drivers/crypto/armv8/rte_armv8_pmd.c
@@ -11,6 +11,7 @@
 #include <bus_vdev_driver.h>
 #include <rte_malloc.h>
 #include <rte_cpuflags.h>
+#include <rte_memcpy.h>
 
 #include "AArch64cryptolib.h"
 
diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index a57dc56b80..77958f9340 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -14,6 +14,7 @@
 #include <rte_cryptodev.h>
 #include <bus_vdev_driver.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_security_driver.h>
 #include <rte_hexdump.h>
 
diff --git a/drivers/crypto/ccp/ccp_crypto.c b/drivers/crypto/ccp/ccp_crypto.c
index b07a786d8e..a8e085d6db 100644
--- a/drivers/crypto/ccp/ccp_crypto.c
+++ b/drivers/crypto/ccp/ccp_crypto.c
@@ -17,6 +17,7 @@
 #include <openssl/evp.h> /*sub key apis*/
 
 #include <rte_hexdump.h>
+#include <rte_memcpy.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
diff --git a/drivers/crypto/cnxk/cn10k_tls_ops.h b/drivers/crypto/cnxk/cn10k_tls_ops.h
index 90600bd850..9ba625d4d9 100644
--- a/drivers/crypto/cnxk/cn10k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn10k_tls_ops.h
@@ -6,6 +6,7 @@
 #define __CN10K_TLS_OPS_H__
 
 #include <rte_crypto_sym.h>
+#include <rte_memcpy.h>
 #include <rte_security.h>
 
 #include "roc_ie.h"
diff --git a/drivers/crypto/cnxk/cn20k_tls_ops.h b/drivers/crypto/cnxk/cn20k_tls_ops.h
index e7a8ba34ae..39d5242f8d 100644
--- a/drivers/crypto/cnxk/cn20k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn20k_tls_ops.h
@@ -6,6 +6,7 @@
 #define __CN20K_TLS_OPS_H__
 
 #include <rte_crypto_sym.h>
+#include <rte_memcpy.h>
 #include <rte_security.h>
 
 #include "roc_ie.h"
diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index f2aa5d5a2e..93e2627f15 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -8,6 +8,7 @@
 #include <rte_common.h>
 #include <rte_crypto_asym.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_memory.h>
 
 #include "roc_ae.h"
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 505a5fcd37..d267122fdd 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 
 #include <rte_cryptodev.h>
+#include <rte_memcpy.h>
 
 #include "cnxk_cryptodev.h"
 #include "cnxk_cryptodev_ops.h"
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_raw_dp.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_raw_dp.c
index fb0408f8ad..ada410048f 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_raw_dp.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_raw_dp.c
@@ -12,6 +12,7 @@
 #include "dpaa2_sec_logs.h"
 
 #include <desc/algo.h>
+#include <rte_memcpy.h>
 
 struct dpaa2_sec_raw_dp_ctx {
 	dpaa2_sec_session *session;
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec_raw_dp.c b/drivers/crypto/dpaa_sec/dpaa_sec_raw_dp.c
index f62c803894..5ad8c3256c 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec_raw_dp.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec_raw_dp.c
@@ -7,6 +7,7 @@
 #include <cryptodev_pmd.h>
 #include <rte_crypto.h>
 #include <rte_cryptodev.h>
+#include <rte_memcpy.h>
 #include <rte_security_driver.h>
 
 /* RTA header files */
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 4c5b6e70b5..c170743a4d 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -5,6 +5,7 @@
 #include <unistd.h>
 
 #include "pmd_aesni_mb_priv.h"
+#include <rte_memcpy.h>
 
 RTE_DEFINE_PER_LCORE(pid_t, pid);
 
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 35fe23c157..8ce951a03e 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -3,6 +3,7 @@
  */
 
 #include "pmd_snow3g_priv.h"
+#include <rte_memcpy.h>
 
 /** Parse crypto xform chain and set private session parameters. */
 static int
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 1a2600655a..f9ac00c7ed 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_eal_paging.h>
 #include <rte_errno.h>
diff --git a/drivers/crypto/mvsam/rte_mrvl_pmd.c b/drivers/crypto/mvsam/rte_mrvl_pmd.c
index a824719fb0..1129b68ef5 100644
--- a/drivers/crypto/mvsam/rte_mrvl_pmd.c
+++ b/drivers/crypto/mvsam/rte_mrvl_pmd.c
@@ -8,6 +8,7 @@
 #include <rte_hexdump.h>
 #include <rte_cryptodev.h>
 #include <cryptodev_pmd.h>
+#include <rte_memcpy.h>
 #include <rte_security_driver.h>
 #include <bus_vdev_driver.h>
 #include <rte_malloc.h>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 2319c7cfa9..2784fc5581 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -10,6 +10,7 @@
 #include <bus_vdev_driver.h>
 #include <rte_malloc.h>
 #include <rte_cpuflags.h>
+#include <rte_memcpy.h>
 
 #include <openssl/cmac.h>
 #include <openssl/hmac.h>
diff --git a/drivers/crypto/qat/asym/qat_asym.c b/drivers/crypto/qat/asym/qat_asym.c
index 9276b86c0e..0792b0116a 100644
--- a/drivers/crypto/qat/asym/qat_asym.c
+++ b/drivers/crypto/qat/asym/qat_asym.c
@@ -14,6 +14,7 @@
 #include "icp_qat_fw.h"
 #include "qat_pke.h"
 #include "qat_ec.h"
+#include <rte_memcpy.h>
 
 #define ASYM_ENQ_THRESHOLD_NAME "qat_asym_enq_threshold"
 #define RSA_MODULUS_2048_BITS 2048
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
index 91546046f1..202d76b94d 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_cryptodev.h>
+#include <rte_memcpy.h>
 #include <cryptodev_pmd.h>
 #include "qat_sym_session.h"
 #include "qat_sym.h"
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
index ec075bbf68..9a49d1c4ed 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_cryptodev.h>
+#include <rte_memcpy.h>
 #include <cryptodev_pmd.h>
 #include "qat_sym_session.h"
 #include "qat_sym.h"
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
index aacbb405e9..b2b53e4b70 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -8,6 +8,7 @@
 #include <rte_cryptodev.h>
 #include <rte_common.h>
 #include <rte_branch_prediction.h>
+#include <rte_memcpy.h>
 #include "qat_crypto.h"
 #include "qat_sym_session.h"
 #include "qat_sym.h"
diff --git a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
index 1ca8443431..7434c7021e 100644
--- a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
+++ b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2017 Intel Corporation
  */
 #include <eal_export.h>
+#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_reorder.h>
 #include <rte_cryptodev.h>
diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index d70651646e..38615b969e 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -6,6 +6,7 @@
 
 #include <rte_common.h>
 #include <rte_errno.h>
+#include <rte_memcpy.h>
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_cryptodev.h>
diff --git a/drivers/crypto/virtio/virtio_rxtx.c b/drivers/crypto/virtio/virtio_rxtx.c
index 4204e1f77e..079446f289 100644
--- a/drivers/crypto/virtio/virtio_rxtx.c
+++ b/drivers/crypto/virtio/virtio_rxtx.c
@@ -7,6 +7,7 @@
 #include "virtio_ring.h"
 #include "virtio_cryptodev.h"
 #include "virtio_crypto_algs.h"
+#include <rte_memcpy.h>
 
 static void
 vq_ring_free_chain(struct virtqueue *vq, uint16_t desc_idx)
-- 
2.53.0

