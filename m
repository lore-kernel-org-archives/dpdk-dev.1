Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7976ECD9AA
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E89D7402F1;
	Fri,  6 Feb 2026 02:12:16 +0100 (CET)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 110CA40264
 for <dev@dpdk.org>; Fri,  6 Feb 2026 02:12:15 +0100 (CET)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so2288906eec.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 17:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770340334; x=1770945134; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2gUdldnfuTWmzkvbk672xyxA4FjSY1EIpNuPX0hfkE=;
 b=VDlWJnIquaZuG7SF1Na+X2KY5RV+CUWzFortYpmjHJTIS6yEoYjP8DbIAu+SHuSXOS
 CZQewh+5Z69Z9535oPJztyklPfv9GLdhuUKkpBywkKu3KCHPIy2N0iocA+u55cH4KH4M
 0pL5u8lDJqBVw6NHYRNAe1GJtW6Z8d66Kjc6JpZbQPMjBb3wiSPO7az3imvE/b4m2VT6
 TxW3uO2BgHdttDamdlqs1LZoGYVTLO4vnC/7Z1RUyYU4lBk6QsNJTiq5dH2gkUmfT0Pe
 XmWsf2AatLe16i7bzTmNi+AN7SK1DPUNmFirYxq7jPaTMzgyzYmSAtGpdjYGQhFll1QA
 8rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770340334; x=1770945134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z2gUdldnfuTWmzkvbk672xyxA4FjSY1EIpNuPX0hfkE=;
 b=mzlquM4ZDZhRo99IjBpnwDIoa06mcSvAGCApTtLJmoAkBN06Bx9NKVnlEnxlubo6D6
 eyYjhmIfdUieeqlG0pBVBVhVP2aCI/oHkKUdgVcQ50/3Jnq2BXKRQc/bNCKEz7zFXU4L
 h20hQ5/tQzEadv+3z3jBvO8CfH5mHyVWIHgucgMOy0TzOzfWyaOl3DuGzgrUiuUNDQKS
 DI/SPtSTlvHuHgK4Lx+iAkk8WA0idSCLEVLIAMR+nBKnQYuHWimqU7fI+Ok0vZSkxFbR
 tbQQAaVdx6uN5t6fp2e77P96zyJngXkt9g8Vr3bzRjJGrv7JVfA1f9xg8an4vBYIByFY
 tl9Q==
X-Gm-Message-State: AOJu0YxHRDLkq0ojMimX/makBEdXAwFCPQUlPQwo4K4Yy1pztiarZD9N
 NlFmNV1Jh3bY5My5KU0fqfzvpVSFOLpb0+upibvyF1cyXV5Zk+EGvCRg4vN8mA==
X-Gm-Gg: AZuq6aIEqCqM5Yhelf64sF1d9JGd7zdNYMVBZR/4/YWLAf3slhvPYoNmBpwA3LgXwdt
 mEXlD0TT3K0iQ+9wLSB4j+qMeXG8gNOzOP9CgefV+0TFquYIu/Qzfu7pOdmFq6gdIjuklUlpeZc
 rfPneohduhEh2q5Jfn4IitarYzYCAPf28R7gK/bcBJm4uCRY6iaP8tgt8KEQ9sLNCzAQPysNKvg
 tLyZcINw/t/bqtBpoTCII9tY1gSp2ePxP8gCndCSDgqpaRqkOQeucZpTazCS1w9Uzu6LrVqjBpb
 YLiWkNJzEH54QIcAYxgl1x/5eRx1xbfVtW3yCKn3sDuYZQu7eyZKr87khSYd/iBOcuyhlSNPV0H
 BfqRtJ9HgCZ34kltJvnxmzbFEN7cLfxHCOMI34HsWxOXOtCB751DGdB3HrbVxti5CEWv6XKU37c
 PmWPtZquCfTMHndXrJ4wv3KStiv+gVFkbOqk/odpfXD1AOddz0Bl2+SiNO34MVDbHr
X-Received: by 2002:a05:7300:dc8d:b0:2b0:4f8d:2f5 with SMTP id
 5a478bee46e88-2b85642c942mr550443eec.2.1770340333837; 
 Thu, 05 Feb 2026 17:12:13 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([216.157.103.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855afc852sm711730eec.13.2026.02.05.17.12.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 17:12:13 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v6 2/4] net/af_packet: RX/TX bulk free, unlikely hint
Date: Thu,  5 Feb 2026 17:11:39 -0800
Message-Id: <20260206011141.2377-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260206011141.2377-1-scott.k.mitch1@gmail.com>
References: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260206011141.2377-1-scott.k.mitch1@gmail.com>
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
index 78ed3fb858..9acce990d1 100644
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

