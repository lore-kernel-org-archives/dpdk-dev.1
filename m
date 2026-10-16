Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE413CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:06:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D171B402EB;
	Fri, 16 Oct 2026 15:06:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3EE00402EB
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:06:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792155969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mdwJNF3KcMSf8MDUmuA0PGwFEUQHEdr3VtqrshkcIRc=;
 b=a/A4PzCNqFbzR97AnLXtwyS0W4TbmwIuWvgO/1wa4987tkV4IChZu4C/Zq9M3BkjOVydIe
 C5GA5EVGRXjI2398PnsneLrq0CeLPcmDqXBeEvX5D2nNEZ76JTbt1Jeoi6UTJrfXYJop1r
 uILL/4nHRoj1+Z7NPh2sLw3SImTzKN0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-DUv_NcHBOnKm0Rb-P8T89w-1; Fri,
 16 Oct 2026 13:06:05 +0000
X-MC-Unique: DUv_NcHBOnKm0Rb-P8T89w-1
X-Mimecast-MFC-AGG-ID: DUv_NcHBOnKm0Rb-P8T89w_1792155963
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76CC71955EAE; Fri, 16 Oct 2026 13:06:03 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B83A43000B56; Fri, 16 Oct 2026 13:06:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 1/8] net/bnxt: remove leftover VMDq code in MAC helpers
Date: Fri, 16 Oct 2026 15:05:47 +0200
Message-ID: <20261016130555.1685102-2-david.marchand@redhat.com>
In-Reply-To: <20261016130555.1685102-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mZbMYTaCs2e5M6AXCptuHoeTmMNFsbWKHwILZPyRPO0_1792155963
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

The VMDq support removal left dead code in MAC address removal and
filter restore functions.
Remove the VMDq flag checks and pool_mask logic that are no longer needed.

At the same time, remove unneeded reset to 0 of VMDq related field in
the dev_info structure.

Fixes: 582f971526da ("net/bnxt: remove VMDq support")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 65 +++++++---------------------------
 1 file changed, 13 insertions(+), 52 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 23edd94444..e811651413 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1252,12 +1252,6 @@ static int bnxt_dev_info_get_op(struct rte_eth_dev *eth_dev,
 	 * TODO: default_rxconf, default_txconf, rx_desc_lim, and tx_desc_lim
 	 *       need further investigation.
 	 */
-	dev_info->max_vmdq_pools = 0;
-	dev_info->vmdq_queue_num = 0;
-
-	dev_info->vmdq_pool_base = 0;
-	dev_info->vmdq_queue_base = 0;
-
 	dev_info->rx_seg_capa.max_nseg = BNXT_MAX_BUFFER_SPLIT_SEGS;
 	dev_info->rx_seg_capa.multi_pools = BNXT_MULTI_POOL_BUF_SPLIT_CAP;
 	dev_info->rx_seg_capa.offset_allowed = BNXT_BUF_SPLIT_OFFSET_CAP;
@@ -1999,39 +1993,23 @@ static void bnxt_mac_addr_remove_op(struct rte_eth_dev *eth_dev,
 				    uint32_t index)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
-	uint64_t pool_mask;
 	struct bnxt_vnic_info *vnic;
 	struct bnxt_filter_info *filter, *temp_filter;
-	uint32_t i;
 
 	if (is_bnxt_in_error(bp))
 		return;
 
-	if ((eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) == 0)
-		pool_mask = 1;
-	else
-		pool_mask = eth_dev->data->mac_pool_sel[index];
-
-	/*
-	 * Loop through all VNICs from the specified filter flow pools to
-	 * remove the corresponding MAC addr filter
-	 */
-	for (i = 0; i < bp->nr_vnics; i++) {
-		if (!(pool_mask & (1ULL << i)))
-			continue;
-
-		vnic = &bp->vnic_info[i];
-		filter = STAILQ_FIRST(&vnic->filter);
-		while (filter) {
-			temp_filter = STAILQ_NEXT(filter, next);
-			if (filter->mac_index == index) {
-				STAILQ_REMOVE(&vnic->filter, filter,
-						bnxt_filter_info, next);
-				bnxt_hwrm_clear_l2_filter(bp, filter);
-				bnxt_free_filter(bp, filter);
-			}
-			filter = temp_filter;
+	vnic = &bp->vnic_info[0];
+	filter = STAILQ_FIRST(&vnic->filter);
+	while (filter) {
+		temp_filter = STAILQ_NEXT(filter, next);
+		if (filter->mac_index == index) {
+			STAILQ_REMOVE(&vnic->filter, filter,
+					bnxt_filter_info, next);
+			bnxt_hwrm_clear_l2_filter(bp, filter);
+			bnxt_free_filter(bp, filter);
 		}
+		filter = temp_filter;
 	}
 }
 
@@ -4528,10 +4506,7 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
 	struct rte_eth_dev *dev = bp->eth_dev;
 	struct rte_eth_dev_info dev_info;
 	struct rte_ether_addr *addr;
-	uint64_t pool_mask;
-	uint32_t pool = 0;
 	uint32_t i;
-	bool vmdq;
 	int rc;
 
 	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp))
@@ -4541,8 +4516,6 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
-
 	/* replay MAC address configuration */
 	for (i = 1; i < dev_info.max_mac_addrs; i++) {
 		addr = &dev->data->mac_addrs[i];
@@ -4551,21 +4524,9 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
 		if (rte_is_zero_ether_addr(addr))
 			continue;
 
-		pool = 0;
-		if (!vmdq)
-			pool_mask = 1;
-		else
-			pool_mask = dev->data->mac_pool_sel[i];
-
-		do {
-			if (pool_mask & 1ULL) {
-				rc = bnxt_mac_addr_add_op(dev, addr, i, pool);
-				if (rc)
-					return rc;
-			}
-			pool_mask >>= 1;
-			pool++;
-		} while (pool_mask);
+		rc = bnxt_mac_addr_add_op(dev, addr, i, 0);
+		if (rc)
+			return rc;
 	}
 
 	return 0;
-- 
2.54.0

