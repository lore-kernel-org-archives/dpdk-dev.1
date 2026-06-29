Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B05AC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 06:19:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7656740611;
	Mon, 29 Jun 2026 08:19:27 +0200 (CEST)
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 68B8C40299
 for <dev@dpdk.org>; Mon, 29 Jun 2026 08:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1782713962; bh=/Psw2iFVnBkKwYHG6sUcDEnE+IO4CJUSdl+8eVxAQHo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U12ML5bd/7aypsc2zoaWcoSFu/Tdt3JvyoHSlZwHJHDgvYPm143m6XFOFVdeGaq/u
 lNwNad+sQJyWrqd2ma9D70X/G7Vw3TRGDs5xcil7qfVQ5uWvHCm3bjq8Q2db7w+gpo
 uG0SDECc4yljRtJcHKKzIGaCBqQzAcSa2ipUWoHA=
Received: from fedora.tail0f0cf3.ts.net ([139.159.170.83])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 4D416624; Mon, 29 Jun 2026 14:19:20 +0800
X-QQ-mid: xmsmtpt1782713961tun6w6qn3
Message-ID: <tencent_A451F4FBCA0EDF2A6C2A9F2B9597BE0A010A@qq.com>
X-QQ-XMAILINFO: OEvtD4zY+/95Op4ckcLn34q69eDceOpNmp4+5nfiiUsq7fdmajDkMuyX039jR/
 dbKLf7U5Ldk2EbPeEdyqRSMsdFQRa3oN3aI+G9PPpgix4mQFpCUc5o3uaJSiaBBR6CVB1pSrK4DU
 7hmwNGnFQn5vu0cVOdBS/A1BX+e5bd/o95PzphW7UQLtySzIGiWHnnnlVvxKkW0cyATod5FtSDeG
 XmiDf2+2RUIthNnaKsakA4xAez3/0wOICCwl+LzKi/9jHgmH4cdNT9Lch9qnULo9vQi2OFrD6vMB
 4Hmv/wpEyARg3jct6BamizB6CPvhDwlbrIRbiwuJfzg3KDU1hJ8Xz00eIGiHmzQPSgmwQ7R6DiN3
 aLt3oNrRCzbDLV8AKIV8MjKUs2usAovEZMO19GaV02yB3r8re8hiZ5HMJrUshL8S+f8zigtsmESe
 PDQ1Z3eIipN1q50gSxw3WR0BO67LjsQfLo1UgAdtnVh1U5oo6NxZoDtxIksVqkKgo4DtDJ1Ll+zF
 M+0x733Vw6NjBLrMPHSzH09+WW+w88NoPm69rEmk0yqGMF3H2/ky5O5vmGWUSNwfjb/uOEn4IHF2
 NbuXNu7fs6MYd0F0rchEvEOGkgu6kCwNcML/aymMaEY/g8a1XKMlKmh/nqn+RJzn1mfXLoJmCpge
 D8OaGflwQ2eDks4mPYYVCLJF3GqCkoH5Q5dhUMMQosUH8bf4A1Sa8oHBL/+GJxGqbB2k+h+jsXYj
 uY5nbozYhlihsdXOlkXe0vUzRtiKHR3sLiBR6p9R/C3c3mNoOFOTpZK1MaIx6nEX00r6c5nzQy8x
 UjB7ztWhlBFcPVzHBCFf6CarDR7aMgqvqnMFsPvKT8JFkuNpp8F5j15aqohgo2HRhFgizpa+gKRu
 RHNqAhtVGqwDonq9Qo4KCK4fY9cF0qeIevs842Sl5K8UwLADgiMU2ctMqE8sroScGFMpEp685JYJ
 qgoc38Mgohuy0z2wVIret5cF+TRRKVoxUN2XWJNXzDbhUZDhXwx2EglM1olNU54OIQP7wYBSEXzM
 qbDuZqNUNZ/aBkImVbb0uqKU1f5PvmTugM5L47EUtX1/2egGSJ2YvEixXiom5ErC3ST5qriDBtWQ
 uVehAGRPKup0Bv79s=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: datshan@qq.com
To: thomas@monjalon.net
Cc: dev@dpdk.org
Subject: [PATCH 1/2] dmadev: fix incomplete configuration validation
Date: Mon, 29 Jun 2026 14:19:16 +0800
X-OQ-MSGID: <20260629061917.321374-2-datshan@qq.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629061917.321374-1-datshan@qq.com>
References: <20260629061917.321374-1-datshan@qq.com>
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

From: Chengwen Feng <fengchengwen@huawei.com>

Add a dma_check_vchan_conf() helper to validate rte_dma_vchan_conf
fields that do not depend on device capabilities: direction enum,
port_type enum, domain type enum, and all reserved[] arrays.

In rte_dma_configure(), reject undefined flag bits and non-zero
priority when the device lacks priority scheduling support.

Fixes: b36970f2e13e ("dmadev: introduce DMA device library")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/dmadev/rte_dmadev.c | 156 ++++++++++++++++++++++++++++------------
 1 file changed, 109 insertions(+), 47 deletions(-)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 822bb7c89f..2311f01906 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -480,6 +480,7 @@ RTE_EXPORT_SYMBOL(rte_dma_configure)
 int
 rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 {
+	const uint64_t valid_flags = RTE_DMA_CFG_FLAG_SILENT | RTE_DMA_CFG_FLAG_ENQ_DEQ;
 	struct rte_dma_info dev_info;
 	struct rte_dma_dev *dev;
 	int ret;
@@ -510,18 +511,28 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 			"Device %d configure too many vchans", dev_id);
 		return -EINVAL;
 	}
+
+	if (dev_info.dev_capa & RTE_DMA_CAPA_PRI_POLICY_SP) {
+		if (dev_conf->priority >= dev_info.nb_priorities) {
+			RTE_DMA_LOG(ERR, "Device %d configure invalid priority", dev_id);
+			return -EINVAL;
+		}
+	} else {
+		if (dev_conf->priority != 0) {
+			RTE_DMA_LOG(ERR, "Device %d should not configure priority", dev_id);
+			return -EINVAL;
+		}
+	}
+
+	if ((dev_conf->flags & ~valid_flags) != 0) {
+		RTE_DMA_LOG(ERR, "Device %d configure invalid flags", dev_id);
+		return -EINVAL;
+	}
 	if ((dev_conf->flags & RTE_DMA_CFG_FLAG_SILENT) &&
 	    !(dev_info.dev_capa & RTE_DMA_CAPA_SILENT)) {
 		RTE_DMA_LOG(ERR, "Device %d don't support silent", dev_id);
 		return -EINVAL;
 	}
-
-	if ((dev_info.dev_capa & RTE_DMA_CAPA_PRI_POLICY_SP) &&
-	    (dev_conf->priority >= dev_info.nb_priorities)) {
-		RTE_DMA_LOG(ERR, "Device %d configure invalid priority", dev_id);
-		return -EINVAL;
-	}
-
 	if ((dev_conf->flags & RTE_DMA_CFG_FLAG_ENQ_DEQ) &&
 	    !(dev_info.dev_capa & RTE_DMA_CAPA_OPS_ENQ_DEQ)) {
 		RTE_DMA_LOG(ERR, "Device %d don't support enqueue/dequeue", dev_id);
@@ -632,13 +643,85 @@ rte_dma_close(int16_t dev_id)
 	return ret;
 }
 
+/* Perform verification on rte_dma_vchan_conf only. */
+static int
+dma_check_vchan_conf(int16_t dev_id, const struct rte_dma_vchan_conf *conf)
+{
+	bool src_is_dev, dst_is_dev;
+
+	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
+	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
+	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM &&
+	    conf->direction != RTE_DMA_DIR_DEV_TO_DEV) {
+		RTE_DMA_LOG(ERR, "Device %d direction invalid!", dev_id);
+		return -EINVAL;
+	}
+
+	if (conf->src_port.port_type != RTE_DMA_PORT_NONE &&
+	    conf->src_port.port_type != RTE_DMA_PORT_PCIE) {
+		RTE_DMA_LOG(ERR, "Device %d source port type unsupported", dev_id);
+		return -EINVAL;
+	}
+	if (conf->src_port.reserved[0] != 0 || conf->src_port.reserved[1] != 0) {
+		RTE_DMA_LOG(ERR, "Device %d src_port has non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
+	src_is_dev = conf->direction == RTE_DMA_DIR_DEV_TO_MEM ||
+		     conf->direction == RTE_DMA_DIR_DEV_TO_DEV;
+	if ((conf->src_port.port_type == RTE_DMA_PORT_NONE && src_is_dev) ||
+	    (conf->src_port.port_type != RTE_DMA_PORT_NONE && !src_is_dev)) {
+		RTE_DMA_LOG(ERR, "Device %d source port type invalid", dev_id);
+		return -EINVAL;
+	}
+
+	if (conf->dst_port.port_type != RTE_DMA_PORT_NONE &&
+	    conf->dst_port.port_type != RTE_DMA_PORT_PCIE) {
+		RTE_DMA_LOG(ERR, "Device %d destination port type unsupported", dev_id);
+		return -EINVAL;
+	}
+	if (conf->dst_port.reserved[0] != 0 || conf->dst_port.reserved[1] != 0) {
+		RTE_DMA_LOG(ERR, "Device %d dst_port has non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
+	dst_is_dev = conf->direction == RTE_DMA_DIR_MEM_TO_DEV ||
+		     conf->direction == RTE_DMA_DIR_DEV_TO_DEV;
+	if ((conf->dst_port.port_type == RTE_DMA_PORT_NONE && dst_is_dev) ||
+	    (conf->dst_port.port_type != RTE_DMA_PORT_NONE && !dst_is_dev)) {
+		RTE_DMA_LOG(ERR,
+			"Device %d destination port type invalid", dev_id);
+		return -EINVAL;
+	}
+
+	if (conf->auto_free.reserved[0] != 0 || conf->auto_free.reserved[1] != 0) {
+		RTE_DMA_LOG(ERR, "Device %d auto_free has non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
+
+	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
+	    conf->domain.type != RTE_DMA_INTER_PROCESS_DOMAIN &&
+	    conf->domain.type != RTE_DMA_INTER_OS_DOMAIN) {
+		RTE_DMA_LOG(ERR, "Device %d domain type invalid!", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.reserved[0] != 0 || conf->domain.reserved[1] != 0) {
+		RTE_DMA_LOG(ERR, "Device %d domain has non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
+	    conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
+		RTE_DMA_LOG(ERR, "Device %d inter domain only support mem-to-mem transfer", dev_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_dma_vchan_setup)
 int
 rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		    const struct rte_dma_vchan_conf *conf)
 {
 	struct rte_dma_info dev_info;
-	bool src_is_dev, dst_is_dev;
 	struct rte_dma_dev *dev;
 	int ret;
 
@@ -653,6 +736,10 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		return -EBUSY;
 	}
 
+	ret = dma_check_vchan_conf(dev_id, conf);
+	if (ret != 0)
+		return ret;
+
 	ret = rte_dma_info_get(dev_id, &dev_info);
 	if (ret != 0) {
 		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
@@ -666,34 +753,7 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		RTE_DMA_LOG(ERR, "Device %d vchan out range!", dev_id);
 		return -EINVAL;
 	}
-	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
-	    conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
-		RTE_DMA_LOG(ERR, "Device %d inter domain only support mem-to-mem transfer", dev_id);
-		return -EINVAL;
-	}
-	if (conf->domain.type == RTE_DMA_INTER_OS_DOMAIN &&
-	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
-		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
-		return -EINVAL;
-	}
-	if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &&
-	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
-		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
-		return -EINVAL;
-	}
-	if ((conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN ||
-	    conf->domain.type == RTE_DMA_INTER_OS_DOMAIN) &&
-	    (conf->domain.reserved[0] != 0 || conf->domain.reserved[1] != 0)) {
-		RTE_DMA_LOG(ERR, "Device %d does not support non-zero reserved fields", dev_id);
-		return -EINVAL;
-	}
-	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
-	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
-	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM &&
-	    conf->direction != RTE_DMA_DIR_DEV_TO_DEV) {
-		RTE_DMA_LOG(ERR, "Device %d direction invalid!", dev_id);
-		return -EINVAL;
-	}
+
 	if (conf->direction == RTE_DMA_DIR_MEM_TO_MEM &&
 	    !(dev_info.dev_capa & RTE_DMA_CAPA_MEM_TO_MEM)) {
 		RTE_DMA_LOG(ERR,
@@ -724,19 +784,21 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 			"Device %d number of descriptors invalid", dev_id);
 		return -EINVAL;
 	}
-	src_is_dev = conf->direction == RTE_DMA_DIR_DEV_TO_MEM ||
-		     conf->direction == RTE_DMA_DIR_DEV_TO_DEV;
-	if ((conf->src_port.port_type == RTE_DMA_PORT_NONE && src_is_dev) ||
-	    (conf->src_port.port_type != RTE_DMA_PORT_NONE && !src_is_dev)) {
-		RTE_DMA_LOG(ERR, "Device %d source port type invalid", dev_id);
+
+	if (conf->auto_free.m2d.pool != NULL &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_M2D_AUTO_FREE)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support m2d auto free", dev_id);
 		return -EINVAL;
 	}
-	dst_is_dev = conf->direction == RTE_DMA_DIR_MEM_TO_DEV ||
-		     conf->direction == RTE_DMA_DIR_DEV_TO_DEV;
-	if ((conf->dst_port.port_type == RTE_DMA_PORT_NONE && dst_is_dev) ||
-	    (conf->dst_port.port_type != RTE_DMA_PORT_NONE && !dst_is_dev)) {
-		RTE_DMA_LOG(ERR,
-			"Device %d destination port type invalid", dev_id);
+
+	if (conf->domain.type == RTE_DMA_INTER_OS_DOMAIN &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
 		return -EINVAL;
 	}
 
-- 
2.54.0

