Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0F8E73144
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 08:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D212140A76;
	Mon,  2 Feb 2026 09:15:04 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id A8B1F40285
 for <dev@dpdk.org>; Mon,  2 Feb 2026 09:15:02 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-11f1fb91996so4554074c88.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 00:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770020101; x=1770624901; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbOiC9tOovJ6pBfMGbcBVFH9C7Z3D8BopdtjFOYmFCw=;
 b=bffkOohulFEhwQ6b8JIrz+ITAnX+y9GqsfsTWj+hpzQ4d97SWCwqhp+HfTWABg8zRo
 4FIh3eise+vP3AGsdh+OB7QV3bxaHEKPO1789cyE1W+vtFWbmNGK9mKwtboZ4xgfT2GP
 rWEIx/qthT9jMha8qIHgHyoAVrArdv5N+90ry7jRxyXbZCH7X4GbdNPDQTZittDt0gtF
 wWiyv9LYbXVcEgHAtBHDq2bFeZeWGvCdxIjDtTyCjyLhhUTzibdeHhJKVwpXLHMstfVr
 +wGlxkE4+fTAVkROOqNyrOG/ZQ9i10wqIax6DL+4fWsbe4rJsFI/4Rn/Y4+yzL+h/vmn
 8MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770020101; x=1770624901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbOiC9tOovJ6pBfMGbcBVFH9C7Z3D8BopdtjFOYmFCw=;
 b=OauwH1QMdyk3Xkmq7xvz08/t4UyAbweE7eHiuIRzPTpf4NfatqOKqzoBWpRQFZHGO+
 YKa7btTxb72f1zA8Wda0phgpy2CIeMRcO27fzMrmOVBStE5Lgkrj5H9I7YpjMQEN3qxt
 M6ZwDbYZWvghs7gcQxT9jNsKLE2bsqtyxrI5uLfSG/y8LXr4/JXd0b9vJ7/OVbGE03SI
 4aL/BHACmePbdjDWLXcyQECrLUK2E62I2s7d4xjxZyIRAlTdyUzHvnnQx6SqY6PCcn7Y
 hRMxl6qHS0OW4OogpR1Sg2QDr7xs1PLKAeuNXVrJWUl5v6WhWFpIat4z5lQcXj+2jdfX
 dJWQ==
X-Gm-Message-State: AOJu0YzrW0KD4KBn5Kr7aJtXplr8R8jGKUHaZNZp6JqMyjcEc5dq+V0Z
 NzkrfIrGbuGaoOPN9Ru4rnSxfG7mLtJJGcoEhQjBfLMtGSPyt1WynMXvv3bW1Q==
X-Gm-Gg: AZuq6aKpGeqjXxhcMhlQZW3SenW6pR60YnwVymjEuGYVpVEZh29D3H5kzkE7e3WRUjn
 hsKUIzDVDZozpsVuo/LNOUozBIfl3ZZplaoMrOZ9nVXdL4M2uVjXQHWL/d4vt5UOEM2oycJNsTq
 IyIiBvC6Lk67+WRuhJvWVHhsEkBLsE7qHaGugv4yTfOvkCsStkn4lkNaBXs9A4BuKWSicIAY2Vx
 8vORHQUFrOShdFuQGlzg7ddByM5h0AZdfuEEmhwWdNKKYM0MlQEOPptu/NTzLxJyMNXM3IEMUOj
 64PSQW4F9ifsf2svaxoPb2L+AtZlWt1sWEdFpBiuCHEwdq85IGQXaV3VV6NVqNc+cLiyjrgus5j
 pavIrTptFUFH8eoOQcpFNo6h79WO5fiMOY/VbAYKfZYg6jB18DH/Pr9PGC/tA0nFstvLcrjn4Gs
 aLVBXorpz7SqUP7Lj/AkP1NQ==
X-Received: by 2002:a05:7022:2219:b0:119:e569:f27a with SMTP id
 a92af1059eb24-125c102eea9mr5472393c88.35.1770020101545; 
 Mon, 02 Feb 2026 00:15:01 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a9d7f597sm17142131c88.5.2026.02.02.00.15.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 00:15:01 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v4 2/4] net/af_packet: RX/TX bulk free, unlikely hint
Date: Mon,  2 Feb 2026 00:14:54 -0800
Message-Id: <20260202081456.4322-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
References: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-1-scott.k.mitch1@gmail.com>
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

