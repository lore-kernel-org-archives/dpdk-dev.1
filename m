Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D7606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KYpSX3Hi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E602B40A70;
	Wed, 21 Oct 2026 12:30:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3052040B98
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRTFvULMnu9L+bcL4sy7Ws+9hyU/URfNT8o6wErCPT0=;
 b=KYpSX3Hi9I2mCLyDQ7WaRfxgC6yRZBt6Tjs5GZGMTZdX8KuIo1PKBCaf7metabZ8TF6BIz
 p8gemd8XGA8WtUEI0d27/OdOmuduv1J0cOu6eop+tZcPLZ6GovNLGPnlQuA9MSC7AEDrV9
 iZD7OGsqiaAGhC68jK/mv2koOcgdyFw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-TPH6DpAwNDeJLD9nGwqJVQ-1; Wed,
 21 Oct 2026 06:30:48 -0400
X-MC-Unique: TPH6DpAwNDeJLD9nGwqJVQ-1
X-Mimecast-MFC-AGG-ID: TPH6DpAwNDeJLD9nGwqJVQ_1792578646
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C06C219560B4; Wed, 21 Oct 2026 10:30:46 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3767418004D2; Wed, 21 Oct 2026 10:30:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Keegan Freyhof <keegan.freyhof@broadcom.com>
Subject: [PATCH v2 04/12] net/bnxt: remove leftover VMDq code in MAC helpers
Date: Wed, 21 Oct 2026 12:30:18 +0200
Message-ID: <20261021103027.2050351-5-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y1YuWuy9stiNhRwyImVqVYw6tOeHquLwAUTggvVxD8A_1792578646
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VMDq support removal left dead code in MAC address addition, removal
and filter restore functions.
Remove the VMDq flag checks and pool_mask logic that are no longer needed.

At the same time, remove unneeded reset to 0 of VMDq related field in
the dev_info structure.

Fixes: 582f971526da ("net/bnxt: remove VMDq support")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- cleaned up bnxt_mac_addr_add_op,
- preferred bnxt_get_default_vnic() to direct access to bp->vnic_info[0],

---
 drivers/net/bnxt/bnxt_ethdev.c | 90 +++++++++-------------------------
 1 file changed, 22 insertions(+), 68 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 23edd94444..4a4e9c1ea3 100644
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
@@ -1999,45 +1993,32 @@ static void bnxt_mac_addr_remove_op(struct rte_eth_dev *eth_dev,
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
+	if (bp->vnic_info == NULL)
+		return;
 
-	/*
-	 * Loop through all VNICs from the specified filter flow pools to
-	 * remove the corresponding MAC addr filter
-	 */
-	for (i = 0; i < bp->nr_vnics; i++) {
-		if (!(pool_mask & (1ULL << i)))
-			continue;
+	vnic = bnxt_get_default_vnic(bp);
 
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
 
 static int bnxt_add_mac_filter(struct bnxt *bp, struct bnxt_vnic_info *vnic,
-			       struct rte_ether_addr *mac_addr, uint32_t index,
-			       uint32_t pool)
+			       struct rte_ether_addr *mac_addr, uint32_t index)
 {
 	struct bnxt_filter_info *filter;
 	int rc = 0;
@@ -2045,9 +2026,7 @@ static int bnxt_add_mac_filter(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 	/* Attach requested MAC address to the new l2_filter */
 	STAILQ_FOREACH(filter, &vnic->filter, next) {
 		if (filter->mac_index == index) {
-			PMD_DRV_LOG_LINE(DEBUG,
-				    "MAC addr already existed for pool %d",
-				    pool);
+			PMD_DRV_LOG_LINE(DEBUG, "MAC addr already exists");
 			return 0;
 		}
 	}
@@ -2082,10 +2061,9 @@ static int bnxt_add_mac_filter(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 
 static int bnxt_mac_addr_add_op(struct rte_eth_dev *eth_dev,
 				struct rte_ether_addr *mac_addr,
-				uint32_t index, uint32_t pool)
+				uint32_t index, uint32_t pool __rte_unused)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
-	struct bnxt_vnic_info *vnic;
 	int rc = 0;
 
 	rc = is_bnxt_in_error(bp);
@@ -2097,11 +2075,6 @@ static int bnxt_mac_addr_add_op(struct rte_eth_dev *eth_dev,
 		return -ENOTSUP;
 	}
 
-	if (pool >= bp->max_vnics) {
-		PMD_DRV_LOG_LINE(ERR, "Pool %u exceeds VNIC count %u!", pool, bp->max_vnics);
-		return -EINVAL;
-	}
-
 	/* Filter settings will get applied when port is started */
 	if (!eth_dev->data->dev_started)
 		return 0;
@@ -2109,9 +2082,7 @@ static int bnxt_mac_addr_add_op(struct rte_eth_dev *eth_dev,
 	if (bp->vnic_info == NULL)
 		return 0;
 
-	vnic = &bp->vnic_info[pool];
-
-	rc = bnxt_add_mac_filter(bp, vnic, mac_addr, index, pool);
+	rc = bnxt_add_mac_filter(bp, bnxt_get_default_vnic(bp), mac_addr, index);
 
 	return rc;
 }
@@ -2953,7 +2924,7 @@ bnxt_config_vlan_hw_filter(struct bnxt *bp, uint64_t rx_offloads)
 		for (i = 0; i < RTE_ETHER_MAX_VLAN_ID; i++)
 			bnxt_del_vlan_filter(bp, i);
 
-		rc = bnxt_add_mac_filter(bp, vnic, NULL, 0, 0);
+		rc = bnxt_add_mac_filter(bp, vnic, NULL, 0);
 		if (rc)
 			return rc;
 	} else {
@@ -3030,7 +3001,7 @@ bnxt_config_vlan_hw_stripping(struct bnxt *bp, uint64_t rx_offloads)
 		if (rc)
 			return rc;
 	} else {
-		rc = bnxt_add_mac_filter(bp, vnic, NULL, 0, 0);
+		rc = bnxt_add_mac_filter(bp, vnic, NULL, 0);
 		if (rc)
 			return rc;
 	}
@@ -3181,7 +3152,7 @@ bnxt_set_default_mac_addr_op(struct rte_eth_dev *dev,
 		/* This filter will allow only untagged packets */
 		rc = bnxt_add_vlan_filter(bp, 0);
 	} else {
-		rc = bnxt_add_mac_filter(bp, vnic, addr, 0, 0);
+		rc = bnxt_add_mac_filter(bp, vnic, addr, 0);
 	}
 
 	PMD_DRV_LOG_LINE(DEBUG, "Set MAC addr");
@@ -4528,10 +4499,7 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
 	struct rte_eth_dev *dev = bp->eth_dev;
 	struct rte_eth_dev_info dev_info;
 	struct rte_ether_addr *addr;
-	uint64_t pool_mask;
-	uint32_t pool = 0;
 	uint32_t i;
-	bool vmdq;
 	int rc;
 
 	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp))
@@ -4541,8 +4509,6 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
 	if (rc)
 		return rc;
 
-	vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
-
 	/* replay MAC address configuration */
 	for (i = 1; i < dev_info.max_mac_addrs; i++) {
 		addr = &dev->data->mac_addrs[i];
@@ -4551,21 +4517,9 @@ static int bnxt_restore_mac_filters(struct bnxt *bp)
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

