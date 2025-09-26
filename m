Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD61CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 12:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B660C402B5;
	Fri, 26 Sep 2025 14:41:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4C6C74025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 14:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758890517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imDd47xveAHCZzeSlEXlNJ05XYwBcjkjY+4eGPAmx40=;
 b=XqnBRBEe3gFUgYFov/h4xCLPTLmiUvrV3mO3OteSn5Bt/DdsSpBWYBq6J84zMr7U3E4OUe
 ufAdRnU6B8vdv8HS4+Ivxct122AyHp6pke/pMF9nZkmcbdF2bwjJJpf6kcXe3tNGTnHJUz
 9xdjNATolUA0ZaCGJ/KZqo31+/ZIsfY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-fb5iMt-iNWOkvONJFqa8vA-1; Fri,
 26 Sep 2025 08:41:54 -0400
X-MC-Unique: fb5iMt-iNWOkvONJFqa8vA-1
X-Mimecast-MFC-AGG-ID: fb5iMt-iNWOkvONJFqa8vA_1758890511
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25907195608E; Fri, 26 Sep 2025 12:41:51 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47F6A1956095; Fri, 26 Sep 2025 12:41:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Gagandeep Singh <g.singh@nxp.com>, Jingjing Wu <jingjing.wu@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Jeff Guo <jia.guo@intel.com>,
 Haiyue Wang <haiyue.wang@intel.com>, Michael Baum <michaelba@nvidia.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>
Subject: [PATCH v5 5/9] drivers: fix some exported headers
Date: Fri, 26 Sep 2025 14:40:58 +0200
Message-ID: <20250926124103.750844-6-david.marchand@redhat.com>
In-Reply-To: <20250926124103.750844-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xMzsNP3hk0xJoZoE6YcgStUqXDVEhABD54R4xDFv62I_1758890511
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Those headers could not be included individually as they were not
including their dependencies, were subject to some build warnings,
or were not compiling on Windows.

Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
Fixes: 5b2a1a02dcaf ("crypto/cnxk: fix experimental version for PMD API")
Fixes: e5abbeeeefa5 ("crypto/cnxk: add PMD API for getting CPTR")
Fixes: 3ca607402c4d ("crypto/cnxk: add PMD API to flush CTX")
Fixes: 8c3495f5d2dd ("net/dpaa: support loopback API")
Fixes: 12b435bf8f2f ("net/iavf: support flex desc metadata extraction")
Fixes: 23f627e0ed28 ("net/mlx5: add flow sync API")
Fixes: f5177bdc8b76 ("net/mlx5: add GENEVE TLV options parser API")
Fixes: 53c71586c789 ("raw/dpaa2_cmdif: support enqueue/dequeue operations")
Fixes: c39d1e082a4b ("raw/ntb: setup queues")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
Changes since v2:
- rebased,
- dropped changes on raw/cnxk drivers,

---
 drivers/bus/vmbus/rte_vmbus_reg.h             | 6 ++++++
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h     | 2 ++
 drivers/net/dpaa/rte_pmd_dpaa.h               | 2 ++
 drivers/net/intel/iavf/rte_pmd_iavf.h         | 6 ++++++
 drivers/net/mlx5/rte_pmd_mlx5.h               | 3 +++
 drivers/raw/dpaa2_cmdif/rte_pmd_dpaa2_cmdif.h | 2 ++
 drivers/raw/ntb/rte_pmd_ntb.h                 | 2 ++
 7 files changed, 23 insertions(+)

diff --git a/drivers/bus/vmbus/rte_vmbus_reg.h b/drivers/bus/vmbus/rte_vmbus_reg.h
index fb7e3043ec..6370a07f95 100644
--- a/drivers/bus/vmbus/rte_vmbus_reg.h
+++ b/drivers/bus/vmbus/rte_vmbus_reg.h
@@ -6,6 +6,12 @@
 #ifndef _VMBUS_REG_H_
 #define _VMBUS_REG_H_
 
+#include <stdint.h>
+
+#include <rte_common.h>
+#include <rte_stdatomic.h>
+#include <rte_uuid.h>
+
 /*
  * Hyper-V SynIC message format.
  */
diff --git a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
index 46861ab2cf..70c019e94c 100644
--- a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
+++ b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
@@ -11,8 +11,10 @@
 #ifndef _PMD_CNXK_CRYPTO_H_
 #define _PMD_CNXK_CRYPTO_H_
 
+#include <stdbool.h>
 #include <stdint.h>
 
+#include <rte_compat.h>
 #include <rte_crypto.h>
 #include <rte_security.h>
 
diff --git a/drivers/net/dpaa/rte_pmd_dpaa.h b/drivers/net/dpaa/rte_pmd_dpaa.h
index ec45633ba2..0a57e2097a 100644
--- a/drivers/net/dpaa/rte_pmd_dpaa.h
+++ b/drivers/net/dpaa/rte_pmd_dpaa.h
@@ -5,6 +5,8 @@
 #ifndef _PMD_DPAA_H_
 #define _PMD_DPAA_H_
 
+#include <stdint.h>
+
 /**
  * @file rte_pmd_dpaa.h
  *
diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
index 56d453fc4c..04b86a5dd7 100644
--- a/drivers/net/intel/iavf/rte_pmd_iavf.h
+++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
@@ -15,6 +15,7 @@
  */
 
 #include <stdio.h>
+
 #include <rte_compat.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
@@ -184,6 +185,7 @@ __rte_experimental
 static inline void
 rte_pmd_ifd_dump_proto_xtr_metadata(struct rte_mbuf *m)
 {
+#ifdef ALLOW_EXPERIMENTAL_API
 	union rte_pmd_ifd_proto_xtr_metadata data;
 
 	if (!rte_pmd_ifd_dynf_proto_xtr_metadata_avail())
@@ -243,6 +245,10 @@ rte_pmd_ifd_dump_proto_xtr_metadata(struct rte_mbuf *m)
 	else if (m->ol_flags & RTE_IAVF_PKT_RX_DYNF_PROTO_XTR_IP_OFFSET)
 		printf(" - Flexible descriptor's Extraction: ip_offset=%u",
 		       data.ip_ofs);
+#else
+	RTE_SET_USED(m);
+	RTE_VERIFY(false);
+#endif
 }
 
 #ifdef __cplusplus
diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h b/drivers/net/mlx5/rte_pmd_mlx5.h
index fdd2f65888..f2c6aebe0b 100644
--- a/drivers/net/mlx5/rte_pmd_mlx5.h
+++ b/drivers/net/mlx5/rte_pmd_mlx5.h
@@ -5,6 +5,9 @@
 #ifndef RTE_PMD_PRIVATE_MLX5_H_
 #define RTE_PMD_PRIVATE_MLX5_H_
 
+#include <stdint.h>
+
+#include <rte_byteorder.h>
 #include <rte_compat.h>
 
 /**
diff --git a/drivers/raw/dpaa2_cmdif/rte_pmd_dpaa2_cmdif.h b/drivers/raw/dpaa2_cmdif/rte_pmd_dpaa2_cmdif.h
index 483b66eaae..7731fc6363 100644
--- a/drivers/raw/dpaa2_cmdif/rte_pmd_dpaa2_cmdif.h
+++ b/drivers/raw/dpaa2_cmdif/rte_pmd_dpaa2_cmdif.h
@@ -12,6 +12,8 @@
  *
  */
 
+#include <stdint.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/drivers/raw/ntb/rte_pmd_ntb.h b/drivers/raw/ntb/rte_pmd_ntb.h
index 6591ce7931..76da3be026 100644
--- a/drivers/raw/ntb/rte_pmd_ntb.h
+++ b/drivers/raw/ntb/rte_pmd_ntb.h
@@ -5,6 +5,8 @@
 #ifndef _RTE_PMD_NTB_H_
 #define _RTE_PMD_NTB_H_
 
+#include <stdint.h>
+
 /* App needs to set/get these attrs */
 #define NTB_QUEUE_SZ_NAME           "queue_size"
 #define NTB_QUEUE_NUM_NAME          "queue_num"
-- 
2.51.0

