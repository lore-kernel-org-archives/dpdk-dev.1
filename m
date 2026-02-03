Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C0E8305D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 07:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7BD840648;
	Tue,  3 Feb 2026 08:07:49 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 3EE9C402EF
 for <dev@dpdk.org>; Tue,  3 Feb 2026 08:07:47 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so9367935eec.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 23:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770102466; x=1770707266; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbOiC9tOovJ6pBfMGbcBVFH9C7Z3D8BopdtjFOYmFCw=;
 b=ERNSMh3NKE9rvCdvO60HJ3cL6f7ywfbIh3DXmPaOwDISzIlq5vsiIsD9BExgTh/wi5
 4RxSKPw79WyfP7ki+cjwDzQp1VAeZPVw11sqTaDCkw4kvOqCV9BAKR86Jx+F0hgpSfF5
 us4EklbPC0Is1mOd2Hy/O0J80z2q524D4Hxl85Dho5Bu5vfFQH5geofl9v6IfeOrSG8F
 VoHPiX9rBxZ6HHtpfFOUgEVXW/680eYThfRaF5zvJT7trZ5mVwm8+WckQKshbDq+qv3L
 KmA349TQ3HfrMjyIz/yS59dHiDVIIEhOLXgCpuLiYVsesWCXwZaiRxL55BPAoIZZyY+m
 fldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770102466; x=1770707266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbOiC9tOovJ6pBfMGbcBVFH9C7Z3D8BopdtjFOYmFCw=;
 b=qLg1dJUKbFVFAuCseR02y12Lv54wI6C4EW6saXada5kNS20XXw9Aj42KaZBOJoO2TJ
 FMLKEDk1aJbRxisjrt7VVWMVbxnpUfPAXhOCJTRy9c9QUz4TnGg7V3ZRm0RAU0534QZB
 UKkyNlKTlvPokPhXM9exerPOmZ7F2CN7ltW0LRi2R5vXb2IqBz8XTewOKxtcSCEqBchQ
 Ta+nSMg9+zEgcC7tjHKzonA3S74tfjFJ8UEJrfhL7NBw80/oSDkk2cf8IHpYTEE38DPN
 ngMf6g960u92PFU7AjpQCnIB3BRlJQK4m1YsleJGh9ff7ubKag5gnOoWQg095Ds5Q8Wu
 p+Iw==
X-Gm-Message-State: AOJu0YxYZIs1hkU0hDvDtoduifNMhtRSBr5QAfAutL96oFoStEiVk0IY
 2pEbFM0F58qZbozY/Pr48DZK8NVkxtUVmefp4zNMXEaOrUOuqZbAdghy6QyyBw==
X-Gm-Gg: AZuq6aKQ5NtczRmACyVBFGaNy2a9QR2APheuvvsM5pLQeOUXHVU25J6t8tHXtz911Lg
 bkylqemWmNEJTg8EuA26/lXD3E4Nvte1AIwXGmwihe4Ybm+y2jcu719r+Yhehinuf8CciFWtBlj
 6BZZXmbCDmZrdtCSh8ZDVqHRGuhRv7gNGgFeqyjYWjTWhH/3d0c2XsWCM4vTBa24O+NbWClBTOb
 EYYa4PStNiHo2en27uJAJEERBBK25lMqccZTdHDAjgG4NDZN0vLpG2x/vPKNOZXrlAB/m1Iiu20
 EqkPoFNkv0A/PDdw46ZVczjDrZDTk14cez/PS/R7BTl3uo4tGQCpdY/+G3JnCTZfry6YrtdeVV6
 e09Ve0up6A3r+g2XMqXw1sx7RZ2X8ZqNEhrZEl9xFP+zU45FwsY7937rDWxRynhAQiNitbxECSw
 BBzMux9lqbn1Wraos1mRHUfZMQsJ3bfBgL
X-Received: by 2002:a05:7300:e7ab:b0:2b6:fa0c:6c44 with SMTP id
 5a478bee46e88-2b7c86485f8mr5938243eec.12.1770102465994; 
 Mon, 02 Feb 2026 23:07:45 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a16cfaa8sm21073318eec.4.2026.02.02.23.07.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 23:07:45 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v5 2/4] net/af_packet: RX/TX bulk free, unlikely hint
Date: Mon,  2 Feb 2026 23:07:38 -0800
Message-Id: <20260203070740.62305-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

- Use rte_pktmbuf_free_bulk() in TX path instead of individual
  rte_pktmbuf_free() calls for better batch efficiency
- Add unlikely() hints for error paths (oversized packets, VLAN
  insertion failures, sendto errors) to optimize branch prediction
- Remove unnecessary early nb_pkts == 0 when loop handles this
  and app may never call with 0 frames.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 41 ++++++++---------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index d0cc2c419a..51ac95ff5e 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -161,9 +161,6 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tp_status;
 	unsigned int framecount, framenum;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	/*
 	 * Reads the given number of packets from the AF_PACKET socket one by
 	 * one and copies the packet data into a newly allocated mbuf.
@@ -261,9 +258,6 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t num_tx_bytes = 0;
 	uint16_t i;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = pkt_q->sockfd;
 	pfd.events = POLLOUT;
@@ -271,24 +265,17 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	framecount = pkt_q->framecount;
 	framenum = pkt_q->framenum;
-	ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = *bufs++;
+		mbuf = bufs[i];
 
-		/* drop oversized packets */
-		if (mbuf->pkt_len > pkt_q->frame_data_size) {
-			rte_pktmbuf_free(mbuf);
+		/* Drop oversized packets. Insert VLAN if necessary */
+		if (unlikely(mbuf->pkt_len > pkt_q->frame_data_size ||
+			    ((mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) != 0 &&
+			     rte_vlan_insert(&mbuf) != 0))) {
 			continue;
 		}
 
-		/* insert vlan info if necessary */
-		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
-			if (rte_vlan_insert(&mbuf)) {
-				rte_pktmbuf_free(mbuf);
-				continue;
-			}
-		}
-
+		ppd = (struct tpacket2_hdr *)pkt_q->rd[framenum].iov_base;
 		/*
 		 * poll() will almost always return POLLOUT, even if there
 		 * are no extra buffers available
@@ -312,6 +299,9 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		pbuf = (uint8_t *)ppd + ETH_AF_PACKET_FRAME_OVERHEAD;
 
+		ppd->tp_len = mbuf->pkt_len;
+		ppd->tp_snaplen = mbuf->pkt_len;
+
 		struct rte_mbuf *tmp_mbuf = mbuf;
 		do {
 			uint16_t data_len = rte_pktmbuf_data_len(tmp_mbuf);
@@ -320,23 +310,20 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			tmp_mbuf = tmp_mbuf->next;
 		} while (tmp_mbuf);
 
-		ppd->tp_len = mbuf->pkt_len;
-		ppd->tp_snaplen = mbuf->pkt_len;
-
 		/* release incoming frame and advance ring buffer */
 		tpacket_write_status(&ppd->tp_status, TP_STATUS_SEND_REQUEST);
 		if (++framenum >= framecount)
 			framenum = 0;
-		ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
-
 		num_tx++;
 		num_tx_bytes += mbuf->pkt_len;
-		rte_pktmbuf_free(mbuf);
 	}
 
+	rte_pktmbuf_free_bulk(&bufs[0], i);
+
 	/* kick-off transmits */
-	if (sendto(pkt_q->sockfd, NULL, 0, MSG_DONTWAIT, NULL, 0) == -1 &&
-			errno != ENOBUFS && errno != EAGAIN) {
+	if (unlikely(num_tx > 0 &&
+		     sendto(pkt_q->sockfd, NULL, 0, MSG_DONTWAIT, NULL, 0) == -1 &&
+		     errno != ENOBUFS && errno != EAGAIN)) {
 		/*
 		 * In case of a ENOBUFS/EAGAIN error all of the enqueued
 		 * packets will be considered successful even though only some
-- 
2.39.5 (Apple Git-154)

