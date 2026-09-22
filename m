Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605D3C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:42:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AECC642EA6;
	Tue, 22 Sep 2026 21:41:49 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 56C4742EAA
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:47 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b31b4281eso192104a91.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790106106;
 x=1790710906; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vUVdi8tXWrg0j0siTTj9DoZhITJwNICiFbYQuHVuGIw=;
 b=PynhyBox9j9XpTZDS0ih0vyWQlnwpu26fqqRT7wxqBb1aucg6N3YaVvJW9ayRxGQlC
 ZrkiRnzcAas4CWv3qTTF6kVaNjl6g22IY2TiRTcmWc6yWW2Ad7d3Hp37g/rJAHF1+9fe
 xmYmF6sThqfRh/U94/wPE6dr4ZclY8X/SbW67W95BBjY5vMeb3WKX03F0rrXGXboUKaw
 orMvc/I9O6uF8SGujU3gwWyb6IOh7CE3BfcPFjm4KcNev8c2bsBWI6R+srQKK+sWA7Lq
 XxBUKUQ+HX6yUtvEB6J7nZEENMgb5gPa19z8K+3EfMt8VO9cFKf/eGlY+kGt6LAAv3Vo
 pbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790106106; x=1790710906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vUVdi8tXWrg0j0siTTj9DoZhITJwNICiFbYQuHVuGIw=;
 b=lVZA+SOYEw3GO/+k9XKZegejPwFLm7L551APXIHMYuKNlthU3Q3VXVWKZeknyKoQuH
 IDloqgLgXDMf6wRIiTr2LfGc7oHxSozTspVH0+hwPdDMXKNWQWF7VOeqp4th9ynUwX3F
 ULTkTYBzsji6Es1Z/hbx6niPaVac51yypLkIF3z9izvHvTv0yiYHg29EX7JIRHNwNKDj
 EbZeTtja0IFK1YPLldZsL0u13h35i3ghPVQyJsQEzzs8DqR2G0XcaGxbdRUMhuucZ0cv
 P2AcHCWc3LE2c5QlotXhX7Hs2Ui/EE9tD1Xgd/+K2qTfZNi7pvLhXiPl2rCZq2jChRr2
 w72g==
X-Gm-Message-State: AFuF++k2DMgzACl8w5vuYTiAi5PlplEe6ClnhG8AUNHSOgZ1f8w7raUg
 J8bssNWCLSC6qiOgpwYCJlRCL+xq27SOcUS7x0w8kLzMhHy+ZF29Gl1qPkUAUX5eoWFJhJqKu8L
 0pyNG5mk=
X-Gm-Gg: AYBFou3y3nt3UIHFTcsI9+sYJ/IkVgKRXyBOjy+WYyzgZoIcRYLaE2Pdeu0IiP3Geii
 +6O43tgiPP5hs1x/8xOqH8+RfQHHyTHWFYbnZ3SUHIDE0U8qZZPBKCHUAqdeklky9IzlthYv5Pi
 tlRaPA77cwP9TBOXhzLyHB74GpVuh3OOUR7Ami42Un6Njqd3DNT0+hRAVDY4kPf29J2XX8V9FhZ
 WemPT3gMFBBS42MF4D9ILlqc9KKlnwxMfdRPKgX+KoIebAMJaGs+31HqAdyeFGAqL/hgFAXacW6
 2AXk4phn7yGzl+chEDE1Qmm12UjzGKaZRu8FE88/TliPcVgW6JMQQHpjC81B72GSPGzz2eofpp2
 MBlGMozM4ZR+OEtzFKTyOq/MHi8/df5jye5Zfip6sn6a+h3OG7Yu1fZ9qgMCNiHdTJ+BKmyBq4C
 HdAwHdoQKmN/0ROPD04tj4/PGEuHOE/8bJlmzBrt3JiyAg9Y5gsbsPjuXyKbgt6q5dAPXjSZ5NO
 bFL4Ghzr9WKBiolLHokgzSqun7KodMUqwD/PlbCBSVOkATf
X-Received: by 2002:a17:90a:d60c:b0:39e:6c68:c777 with SMTP id
 98e67ed59e1d1-3a07e68d3cbmr375506a91.45.1790106106423; 
 Tue, 22 Sep 2026 12:41:46 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf1cf3sm814881a91.9.2026.09.22.12.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:41:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 5/7] net/memif: validate descriptor length in zero-copy mode
Date: Tue, 22 Sep 2026 12:40:56 -0700
Message-ID: <20260922194138.508919-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194138.508919-1-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
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

In zero-copy mode the receive buffers are the driver's own mbufs,
and the peer supplies the resulting length. That length needs to
be checked so that buggy/hostile peer doesn't crash server.

Validate the length against the buffer size advertised to the peer.
Read descriptor length once to avoid TOCTOU issues.

An invalid length means the peer is not honoring the contract on a
field whose buffer the driver owns, so nothing else in the ring can
be trusted. Drop the burst and disconnect, as is done for the other
invalid descriptor cases.

This also fixes the packet length of chained zero-copy segments.
memif_pktmbuf_chain() adds the tail data_len while it is still
zero, so a multi-segment packet previously carried only the length
of its first segment.

While here, fix a leak on the existing number-of-segments-overflow
path.

Bugzilla ID: 2018
Fixes: 43b815d88188 ("net/memif: support zero-copy slave")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Tested-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 49 ++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index f7be4e4f4b..7dbc80d3b0 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -711,7 +711,11 @@ eth_memif_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	memif_ring_t *ring = memif_get_ring_from_queue(proc_private, mq);
 	uint16_t cur_slot, last_slot, n_slots, ring_size, mask, s0, head;
 	uint16_t n_rx_pkts = 0;
+	/* Buffer size advertised to the peer by the refill loop below. */
+	const uint16_t buf_size = rte_pktmbuf_data_room_size(mq->mempool) -
+		RTE_PKTMBUF_HEADROOM;
 	memif_desc_t *d0;
+	memif_desc_t desc;
 	struct rte_mbuf *mbuf, *mbuf_tail;
 	struct rte_mbuf *mbuf_head = NULL;
 	int ret;
@@ -763,14 +767,31 @@ eth_memif_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			rte_prefetch0(&ring->desc[(cur_slot + 1) & mask]);
 
 		mbuf->port = mq->in_port;
-		rte_pktmbuf_data_len(mbuf) = d0->length;
-		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf);
+		desc = memif_desc_read(d0);
+
+		/* The peer only supplies the length here */
+		if (unlikely(desc.length > buf_size)) {
+			memif_desc_error(mq, &desc, MEMIF_DESC_STATUS_ERR_DATA_TOO_BIG);
+			/* Consume the slot before discarding */
+			cur_slot++;
+			n_slots--;
+			goto discard;
+		}
 
-		mq->n_bytes += rte_pktmbuf_data_len(mbuf);
+		rte_pktmbuf_data_len(mbuf) = desc.length;
+		rte_pktmbuf_pkt_len(mbuf) = desc.length;
+		if (mbuf != mbuf_head)
+			rte_pktmbuf_pkt_len(mbuf_head) += desc.length;
+
+		mq->n_bytes += desc.length;
 
 		cur_slot++;
 		n_slots--;
-		if (d0->flags & MEMIF_DESC_FLAG_NEXT) {
+		if (desc.flags & MEMIF_DESC_FLAG_NEXT) {
+			if (unlikely(n_slots == 0)) {
+				mq->n_err++;
+				goto discard;
+			}
 			s0 = cur_slot & mask;
 			d0 = &ring->desc[s0];
 			mbuf_tail = mbuf;
@@ -778,7 +799,8 @@ eth_memif_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			ret = memif_pktmbuf_chain(mbuf_head, mbuf_tail, mbuf);
 			if (unlikely(ret < 0)) {
 				MIF_LOG(ERR, "number-of-segments-overflow");
-				goto refill;
+				mq->n_err++;
+				goto discard;
 			}
 			goto next_slot;
 		}
@@ -788,6 +810,17 @@ eth_memif_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	}
 
 	mq->last_tail = cur_slot;
+	goto refill;
+
+discard:
+	/*
+	 * The peer is buggy or hostile, remaining descriptors cannot be trusted.
+	 * Drop the partially built packet and the slots not yet consumed.
+	 */
+	rte_pktmbuf_free(mbuf_head);
+	while (n_slots--)
+		rte_pktmbuf_free_seg(mq->buffers[cur_slot++ & mask]);
+	mq->last_tail = cur_slot;
 
 /* Supply server with new buffers */
 refill:
@@ -820,8 +853,9 @@ eth_memif_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		d0->length = rte_pktmbuf_data_room_size(mq->mempool) -
 				RTE_PKTMBUF_HEADROOM;
 		d0->region = 1;
+		/* Use the constant, the peer can change d0->region at any time. */
 		d0->offset = rte_pktmbuf_mtod(mbuf, uint8_t *) -
-			(uint8_t *)proc_private->regions[d0->region]->addr;
+			(uint8_t *)proc_private->regions[1]->addr;
 	}
 no_free_mbufs:
 	/* The ring->head acts as a guard variable between Tx and Rx
@@ -1096,8 +1130,9 @@ memif_tx_one_zc(struct pmd_process_private *proc_private, struct memif_queue *mq
 	mq->n_bytes += rte_pktmbuf_data_len(mbuf);
 	/* FIXME: get region index */
 	d0->region = 1;
+	/* Use the constant, the peer can change d0->region at any time. */
 	d0->offset = rte_pktmbuf_mtod(mbuf, uint8_t *) -
-		(uint8_t *)proc_private->regions[d0->region]->addr;
+		(uint8_t *)proc_private->regions[1]->addr;
 	d0->flags = 0;
 
 	/* check if buffer is chained */
-- 
2.53.0

