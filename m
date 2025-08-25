Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C27CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 09:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BD9D4025A;
	Mon, 25 Aug 2025 11:28:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B62F540151
 for <dev@dpdk.org>; Mon, 25 Aug 2025 11:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756114086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r1EmlHTfiKSqcfR+WlPIY/av7fKIEb6Kjjmuae/gCUQ=;
 b=Dv50k86wcMwZ8Xsm2SUf2+05YWM7nz1iyI423fH39juvhI+eXXfPLoQa3in2XvKho/tp6w
 OYmdz4YOSe46Hgy4LPgAc/IobJXomrv+68Q5xj1F0ekTwnhSI+laYyFexy27SiPoNtlUTc
 TFhAejDkyIBvETdgSp8PwBfeCpf4KRA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-whjqI_rOMEe4LmwvHUciLw-1; Mon,
 25 Aug 2025 05:28:02 -0400
X-MC-Unique: whjqI_rOMEe4LmwvHUciLw-1
X-Mimecast-MFC-AGG-ID: whjqI_rOMEe4LmwvHUciLw_1756114081
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3393195419F; Mon, 25 Aug 2025 09:28:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.144])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95A9419560AB; Mon, 25 Aug 2025 09:27:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH] net/bnxt: remove dead code under DPDK version check
Date: Mon, 25 Aug 2025 11:27:18 +0200
Message-ID: <20250825092719.882769-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QTw569PnLcZYsvhjbeUGjraUE_XVReNyyRbN-_ulUMg_1756114081
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

There is no good reason to keep code for older versions of DPDK in the
main branch.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/bnxt/bnxt_cpr.h              |  2 --
 drivers/net/bnxt/bnxt_ethdev.c           |  5 ----
 drivers/net/bnxt/bnxt_reps.c             |  7 +-----
 drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c  |  2 --
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c    |  2 --
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c   |  2 --
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h | 31 ------------------------
 7 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_cpr.h b/drivers/net/bnxt/bnxt_cpr.h
index 489dab6b15..94f449e8b5 100644
--- a/drivers/net/bnxt/bnxt_cpr.h
+++ b/drivers/net/bnxt/bnxt_cpr.h
@@ -119,9 +119,7 @@ bool bnxt_is_recovery_enabled(struct bnxt *bp);
 bool bnxt_is_primary_func(struct bnxt *bp);
 
 void bnxt_stop_rxtx(struct rte_eth_dev *eth_dev);
-#if (RTE_VERSION_NUM(21, 8, 0, 0) < RTE_VERSION)
 void bnxt_start_rxtx(struct rte_eth_dev *eth_dev);
-#endif
 
 /**
  * Check validity of a completion ring entry. If the entry is valid, include a
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 8213ff9e4b..cace6e8e17 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -4309,7 +4309,6 @@ static int bnxt_get_module_eeprom(struct rte_eth_dev *dev,
 	return length ? -EINVAL : 0;
 }
 
-#if (RTE_VERSION_NUM(22, 11, 0, 0) <= RTE_VERSION)
 static int bnxt_speed_lanes_set(struct rte_eth_dev *dev, uint32_t speed_lanes)
 {
 	struct bnxt *bp = dev->data->dev_private;
@@ -4406,8 +4405,6 @@ static int bnxt_speed_lanes_get(struct rte_eth_dev *dev, uint32_t *lanes)
 	return 0;
 }
 
-#endif
-
 /*
  * Initialization
  */
@@ -4479,11 +4476,9 @@ static const struct eth_dev_ops bnxt_dev_ops = {
 	.timesync_read_rx_timestamp = bnxt_timesync_read_rx_timestamp,
 	.timesync_read_tx_timestamp = bnxt_timesync_read_tx_timestamp,
 	.mtr_ops_get = bnxt_flow_meter_ops_get,
-#if (RTE_VERSION_NUM(22, 11, 0, 0) <= RTE_VERSION)
 	.speed_lanes_get = bnxt_speed_lanes_get,
 	.speed_lanes_set = bnxt_speed_lanes_set,
 	.speed_lanes_get_capa = bnxt_speed_lanes_get_capa,
-#endif
 };
 
 static uint32_t bnxt_map_reset_regs(struct bnxt *bp, uint32_t reg)
diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index 6f5c3f80eb..43e4085434 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -766,13 +766,8 @@ int bnxt_rep_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 	return 0;
 
 out:
-	if (rxq) {
- #if (RTE_VERSION_NUM(21, 8, 0, 0) < RTE_VERSION)
+	if (rxq)
 		bnxt_rep_rx_queue_release_op(eth_dev, queue_idx);
- #else
-		bnxt_rx_queue_release_op(rxq);
- #endif
-	}
 
 	return rc;
 }
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
index 2c22582e1c..ab02b01b46 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c
@@ -75,10 +75,8 @@ bnxt_ulp_set_dir_attributes(struct ulp_rte_parser_params *params,
 		params->dir_attr |= BNXT_ULP_FLOW_ATTR_EGRESS;
 	if (attr->ingress)
 		params->dir_attr |= BNXT_ULP_FLOW_ATTR_INGRESS;
-#if RTE_VERSION_NUM(17, 11, 10, 16) < RTE_VERSION
 	if (attr->transfer)
 		params->dir_attr |= BNXT_ULP_FLOW_ATTR_TRANSFER;
-#endif
 	if (attr->group) {
 		ULP_COMP_FLD_IDX_WR(params, BNXT_ULP_CF_IDX_GROUP_ID,
 				    rte_cpu_to_le_32(attr->group));
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index 4a1ccfa2a3..e3eb9107ab 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -1613,9 +1613,7 @@ ulp_tf_mtr_cap_get(struct bnxt *bp,
 		return -EINVAL;
 	}
 
-#if (RTE_VERSION_NUM(21, 05, 0, 0) <= RTE_VERSION)
 	cap->srtcm_rfc2697_byte_mode_supported = 1;
-#endif
 	cap->n_shared_max = cap->n_max;
 	/* No meter is identical */
 	cap->identical = 1;
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 508c194d04..c20aea1966 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -1087,9 +1087,7 @@ static int
 ulp_tfc_mtr_cap_get(struct bnxt *bp __rte_unused,
 		    struct rte_mtr_capabilities *cap)
 {
-#if (RTE_VERSION_NUM(21, 05, 0, 0) <= RTE_VERSION)
 	cap->srtcm_rfc2697_byte_mode_supported = 1;
-#endif
 	cap->n_max = MAX_NUM_METER;
 	cap->n_shared_max = cap->n_max;
 	/* No meter is identical */
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index e6f316539c..daa3be64a7 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -814,35 +814,6 @@ bnxt_ulp_cntxt_release_fdb_lock(struct bnxt_ulp_context	*ulp_ctx)
 	pthread_mutex_unlock(&ulp_ctx->cfg_data->flow_db_lock);
 }
 
-#if (RTE_VERSION_NUM(21, 05, 0, 0) > RTE_VERSION)
-
-/* Function to extract the action type from the shared action handle. */
-static inline uint32_t
-bnxt_get_shared_action_type(const struct rte_flow_shared_action *handle)
-{
-	return (uint32_t)(((uint64_t)handle >> 32) & 0xffffffff);
-}
-
-/* Function to extract the direction from the shared action handle. */
-static inline uint32_t
-bnxt_get_shared_action_direction(const struct rte_flow_shared_action *handle)
-{
-	uint32_t shared_type;
-
-	shared_type = bnxt_get_shared_action_type(handle);
-	return shared_type & 0x1 ? BNXT_ULP_FLOW_ATTR_EGRESS :
-		BNXT_ULP_FLOW_ATTR_INGRESS;
-}
-
-/* Function to extract the action index from the shared action handle. */
-static inline uint32_t
-bnxt_get_shared_action_index(const struct rte_flow_shared_action *handle)
-{
-	return (uint32_t)((uint64_t)handle & 0xffffffff);
-}
-
-#else /* (RTE_VERSION >= RTE_VERSION_NUM(21,05,0,0)) */
-
 /* Function to extract the action type from the shared action handle. */
 static inline int32_t
 bnxt_get_action_handle_type(const struct rte_flow_action_handle *handle,
@@ -882,8 +853,6 @@ bnxt_get_action_handle_index(const struct rte_flow_action_handle *handle)
 	return (uint32_t)((uint64_t)handle & 0xffffffff);
 }
 
-#endif	/* RTE_VERSION < RTE_VERSION_NUM(21,05,0,0) */
-
 /* Function to set the ha info into the context */
 static inline int32_t
 bnxt_ulp_cntxt_ptr2_ha_info_set(struct bnxt_ulp_context *ulp_ctx,
-- 
2.51.0

