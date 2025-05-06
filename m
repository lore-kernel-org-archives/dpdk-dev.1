Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1D6C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C74C4065D;
	Tue,  6 May 2025 19:50:32 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id CFCE240650
 for <dev@dpdk.org>; Tue,  6 May 2025 19:50:30 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQsf41SFz3Y5p;
 Tue, 06 May 2025 17:50:30 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQsf2wQZz437g;
 Tue, 06 May 2025 17:50:30 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jdoTI9kTvqjd/OYFMPWFcqWeH2EoijQtMZHK05SNgxA=;
 b=HGLBQUJ+5eFcNHvoKdZXcVoUS3Yrsk5WO/KRpwwG92ZcNLfTXY/fwM7/uz6jgEtsjKpnEZ
 RPM3tiiCfXYDZto/AKumh0d2ow2/ZTu3sfAsAR4UOh9pkfAytdICDU/o05/v9bOTZxuVJK
 08c9/6rnWD4RMNYXnaJoaN73b148tkmRr4htakcLyMtBbDa6ii4zQSTvFWkbnQsgxxeZm/
 21XitBQnnxtAN03Ry22oW5Sm7lTH3O4daFfhcw29Iana1926w3v5/TBtekLq8rHA0uTjaK
 oQTn1gipjlErK2OVfbjuj7P8CsCQkPf0Ppo7FSkh46qDXiBZTM+g4Rke2mfgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jdoTI9kTvqjd/OYFMPWFcqWeH2EoijQtMZHK05SNgxA=;
 b=ZNzqJMjNkpR9y5BN2w3oy5fmAzT9bF0gxNg8g8Vq3jTAEdBFbeK6+vta3YbcS1QSeyS7dP
 OPaPw9VfclaNVeeWu+hQd8vNK/aRSNnrntdCquqmNTetA/UdjO91hTyx7M0VzhrX3KffX5
 v4LEsNMTEKUUMUDd5dJBy9EWQ6mnffkpseWVngRImlvzgtEhOFB1ELCHj2Kr7k24TzsblV
 4l8SaVudj41TZF5f/DRNYRuUqXhRFmGNpfiVB+1XRCpa2R7OU2a+CRZ9TyrDROfMaox7np
 QghoLhyBnlbtmZQ1ybZ4Mu3VaKtAY6YzpTbieTWcDnqK7byYVZwx76x23O4dfA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553830; a=rsa-sha256; cv=none;
 b=AEC6csWzleMWQmoFezIskv58FKT/6m5ytAoh1gB4fKLB8ORT2XaLw2tYOAvbCo7A/Ehl6/
 4veJEQr/v+P1DsUpDH27iozvxCqR6NY4m0HgQ26ynspdbnP+bhyJd90SO9bKR7+kGgJOHA
 nqBoauQhgLEpPZWNht6zp6UZzKnZfM079KPlrTCfrIXbYZfQp4msdkEDa8N3Y96kNlDHZL
 RhcRSmMaltnFlfrFFvlrs/RBMryTCq44wKb2XKwGz86QHbHwD998rsDCSONY4mAxIufn19
 POvnUpqBLLFayyZ46a54iW6UbulleQuffHqC/L8Msf4znNfty8NJNJSL9MGUAw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQsf0jLgzv68;
 Tue, 06 May 2025 17:50:30 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH] net/ice: Localize dynamic mbuf timestamp data
Date: Tue,  6 May 2025 12:50:24 -0500
Message-ID: <20250506175025.1141664-1-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
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

The ice_timestamp_dynfield_offset and ice_timestamp_dynflag global
variables are used to access the dynamic mbuf timestamp field when
timestamp offloading is enabled.

Move these into the ice_rx_queue structure, located in shared
rte_eth_dev_data, so they can be accessed by secondary processes.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 drivers/net/intel/ice/ice_ethdev.c | 13 -------------
 drivers/net/intel/ice/ice_rxtx.c   | 27 +++++++++++++--------------
 drivers/net/intel/ice/ice_rxtx.h   |  6 ++----
 3 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 21d3795954..2ec7eab7fa 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -44,9 +44,6 @@
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
 
-uint64_t ice_timestamp_dynflag;
-int ice_timestamp_dynfield_offset = -1;
-
 static const char * const ice_valid_args[] = {
 	ICE_SAFE_MODE_SUPPORT_ARG,
 	ICE_PROTO_XTR_ARG,
@@ -3977,16 +3974,6 @@ ice_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
-		/* Register mbuf field and flag for Rx timestamp */
-		ret = rte_mbuf_dyn_rx_timestamp_register(&ice_timestamp_dynfield_offset,
-							 &ice_timestamp_dynflag);
-		if (ret) {
-			PMD_DRV_LOG(ERR, "Cannot register mbuf field/flag for timestamp");
-			goto tx_err;
-		}
-	}
-
 	/* program Rx queues' context in hardware*/
 	for (nb_rxq = 0; nb_rxq < data->nb_rx_queues; nb_rxq++) {
 		ret = ice_rx_queue_start(dev, nb_rxq);
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 40ac01e782..ba1435b9de 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -275,17 +275,16 @@ ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
 		return -EINVAL;
 	}
 
-	if (!rxq->ts_enable && (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
+	if (rxq->ts_flag == 0 && (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 		/* Register mbuf field and flag for Rx timestamp */
 		err = rte_mbuf_dyn_rx_timestamp_register(
-				&ice_timestamp_dynfield_offset,
-				&ice_timestamp_dynflag);
+				&rxq->ts_offset,
+				&rxq->ts_flag);
 		if (err) {
 			PMD_DRV_LOG(ERR,
 				"Cannot register mbuf field/flag for timestamp");
 			return -EINVAL;
 		}
-		rxq->ts_enable = true;
 	}
 
 	memset(&rx_ctx, 0, sizeof(rx_ctx));
@@ -679,7 +678,7 @@ ice_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 		return 0;
 
 	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)
-		rxq->ts_enable = true;
+		rxq->offloads |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 	err = ice_program_hw_rx_queue(rxq);
 	if (err) {
 		PMD_DRV_LOG(ERR, "fail to program RX queue %u",
@@ -1785,7 +1784,7 @@ ice_rx_scan_hw_ring(struct ice_rx_queue *rxq)
 			ice_rxd_to_vlan_tci(mb, &rxdp[j]);
 			rxd_to_pkt_fields_ops[rxq->rxdid](rxq, mb, &rxdp[j]);
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
-			if (ice_timestamp_dynflag > 0 &&
+			if (rxq->ts_flag > 0 &&
 			    (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 				rxq->time_high =
 				rte_le_to_cpu_32(rxdp[j].wb.flex_ts.ts_high);
@@ -1804,9 +1803,9 @@ ice_rx_scan_hw_ring(struct ice_rx_queue *rxq)
 				rxq->hw_time_update = rte_get_timer_cycles() /
 						     (rte_get_timer_hz() / 1000);
 				*RTE_MBUF_DYNFIELD(mb,
-						   ice_timestamp_dynfield_offset,
+						   rxq->ts_offset,
 						   rte_mbuf_timestamp_t *) = ts_ns;
-				pkt_flags |= ice_timestamp_dynflag;
+				pkt_flags |= rxq->ts_flag;
 			}
 
 			if (ad->ptp_ena && ((mb->packet_type &
@@ -2153,7 +2152,7 @@ ice_recv_scattered_pkts(void *rx_queue,
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, first_seg, &rxd);
 		pkt_flags = ice_rxd_error_to_pkt_flags(rx_stat_err0);
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
-		if (ice_timestamp_dynflag > 0 &&
+		if (rxq->ts_flag > 0 &&
 		    (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 			rxq->time_high =
 			   rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high);
@@ -2171,9 +2170,9 @@ ice_recv_scattered_pkts(void *rx_queue,
 			rxq->hw_time_update = rte_get_timer_cycles() /
 					     (rte_get_timer_hz() / 1000);
 			*RTE_MBUF_DYNFIELD(first_seg,
-					   (ice_timestamp_dynfield_offset),
+					   (rxq->ts_offset),
 					   rte_mbuf_timestamp_t *) = ts_ns;
-			pkt_flags |= ice_timestamp_dynflag;
+			pkt_flags |= rxq->ts_flag;
 		}
 
 		if (ad->ptp_ena && ((first_seg->packet_type & RTE_PTYPE_L2_MASK)
@@ -2651,7 +2650,7 @@ ice_recv_pkts(void *rx_queue,
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, rxm, &rxd);
 		pkt_flags = ice_rxd_error_to_pkt_flags(rx_stat_err0);
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
-		if (ice_timestamp_dynflag > 0 &&
+		if (rxq->ts_flag > 0 &&
 		    (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 			rxq->time_high =
 			   rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high);
@@ -2669,9 +2668,9 @@ ice_recv_pkts(void *rx_queue,
 			rxq->hw_time_update = rte_get_timer_cycles() /
 					     (rte_get_timer_hz() / 1000);
 			*RTE_MBUF_DYNFIELD(rxm,
-					   (ice_timestamp_dynfield_offset),
+					   (rxq->ts_offset),
 					   rte_mbuf_timestamp_t *) = ts_ns;
-			pkt_flags |= ice_timestamp_dynflag;
+			pkt_flags |= rxq->ts_flag;
 		}
 
 		if (ad->ptp_ena && ((rxm->packet_type & RTE_PTYPE_L2_MASK) ==
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 276d40b57f..500d630679 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -65,9 +65,6 @@
 #define ICE_TX_OFFLOAD_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ ICE_TX_OFFLOAD_MASK)
 
-extern uint64_t ice_timestamp_dynflag;
-extern int ice_timestamp_dynfield_offset;
-
 /* Max header size can be 2K - 64 bytes */
 #define ICE_RX_HDR_BUF_SIZE    (2048 - 64)
 
@@ -143,7 +140,8 @@ struct ice_rx_queue {
 	/* address of temp buffer for RX split mbufs */
 	struct rte_eth_rxseg_split rxseg[ICE_RX_MAX_NSEG];
 	uint32_t rxseg_nb;
-	bool ts_enable; /* if rxq timestamp is enabled */
+	int ts_offset; /* dynamic mbuf timestamp field offset */
+	uint64_t ts_flag; /* dynamic mbuf timestamp flag */
 };
 
 /* Offload features */
-- 
2.47.2

