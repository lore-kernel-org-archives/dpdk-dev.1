Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D08606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9cSBYTK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F8C0402D4;
	Wed, 28 Oct 2026 10:01:02 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C80740151
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:21:26 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2e608cd460eso450155ad.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793125285; x=1793730085; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tmzd9Chzvx0+YL+6o1t2bEXYgCPBzepR5vsEzw6Lo9w=;
 b=Z9cSBYTKJ0jOZb2Rs710eKLjrrPAULqmf7nKR6ID4/zgpC3COIo7WbhQiUJNNHLu1H
 NnwOpdxTOCvayt3cKr6Uz+NP/gudCtXLD+jg7x4ROxdTaBZW6BK6e3GMLD3/cn1dqN79
 c6Mufsl7uZgwAz+8RU+kVP2fhr8VnPf4/6baiEK7TlPDgjYCBDUaNnGHLpsToQup61sV
 Ndx9T4SISmpm8KaQikZgTcPVshrjPiR7D/UIwnf2/HXXZpPZJOY4GED96wpP9EG855Ja
 bq4sifx+biGMPYqyu1bLQZ4n2RCK8jmCK9WqXJ8uS9XUpk2CkqCAC/nYVNHczRgiN2to
 dd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125285; x=1793730085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tmzd9Chzvx0+YL+6o1t2bEXYgCPBzepR5vsEzw6Lo9w=;
 b=qRCUpTEqYcszMlLe584D0JAZ3XnZG+T0TMKPQ+fXH/pIIEOW7LOywJXVnAkPGlX+nk
 n0M1TU08Il0nWhl1IUOVZhBiYQgSxgcBs0ad8nmhlIYbdZ9hRe8sMKxw50tZvTgrmT92
 TKpfLWDOKWz8dH4jnBfx0+1WvLqnnRnSy/FuKjZpdp7f9rRTGbWAo86gWUT4A16nzEUa
 4VQ6rW2xYaOGFIcVXdt0bh6zhFi4awpW4usZKLO0Qam0MNZKjI/t32aJBLe5F/1qiYiu
 Ee8DQTzTCbMLDakqo8HM8qn+5Y38uCluo9kbNUffdqm0dsL9RjOhSwAiDCiD1r9FA348
 y5tw==
X-Gm-Message-State: AFq9FYL8OiA8mv/9okXHASCP7I7aPqPTtULsZPikGLKggdwj23SSQ5/W
 KuJK4OTN0YTr9edFRaE0U6mvg27aCZBdOhzWTqjJdFrXv66LRDLgQzRdSzrvYNXO
X-Gm-Gg: AYBFou1DyyezJCQhRaApYi3LtmInSse8gdbGHoVqc7a+NQBbw4jpXqE9u2ewp4mTBqK
 auLJW8bhVt3a0PoWw8WHOOc35slh8ROkFGSFveoMpeKXtZwzlxIVscp1dx9gCXk66YxQX69BYlj
 DudZF+yCimLrA7VTgu4M3RSrHnL/bT5dsrvPC5hBeksJilqg6Rq76nxTQFeSOWb+cJX9Jsj7hAC
 5c9DIMr+Mmq3NTO6/X4tZQeEoPeiTVrWwxpATVOq3elOH011p2BWqqVOLPnvEUL1p8KK0LlA4GJ
 RQi2GyimhFGbE29Y+oldC0eYtuGOdW1QdyXKTkeGA6vTVAA0kXOTW6diK5Ot0KB+iCTBA+iZ14x
 1TUS89dZEkcvz/YyVyMUMSbLl3rEqcK6Xzo0kknApxVVG0VmTLjrCtkBP1rpbZE/J/Wl3MVNkOd
 xCxKc/U3jsLr6KovBY6VptHyLmdNePOGXUEDvpZhLro8X1ri7Xssot8BlulBnTiRMtFxaK7UyuC
 YxsInQUVHTLM4lRhNAcuS3tN+UHP6ZBOGRIVtRBI3XpJuNiUoq0yrcvuQ==
X-Received: by 2002:a17:902:ecc1:b0:2e9:814c:dccb with SMTP id
 d9443c01a7336-2eb005715aamr1639995ad.69.1793125284504; 
 Tue, 27 Oct 2026 11:21:24 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c84d6csm13054585ad.55.2026.10.27.11.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:21:23 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: weh@microsoft.com, longli@microsoft.com, stephen@networkplumber.org,
 stable@dpdk.org
Subject: [PATCH v3 1/2] net/mana: fix transmit burst error handling
Date: Tue, 27 Oct 2026 18:21:14 +0000
Message-ID: <20261027182115.3666158-2-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182115.3666158-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
 <20261027182115.3666158-1-tathagat.dpdk@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 10:01:00 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mana_tx_burst() skipped, using continue, a packet that exceeded the
segment limit or whose SGL could not be populated. rte_eth_tx_burst()
callers treat the return value as a contiguous prefix of consumed
packets, so later packets were posted while the caller considered them
unsent and freed them, and their completions then freed them again.

Drop such a packet instead: count it in stats.errors, free it and
include it in the returned count. Return early only when the ring is
full, since a packet that fails validation would fail again on every
retry and stall applications that loop until all packets are sent.

sgl.gdma_sgl[] holds MAX_SGL_ENTRIES_FOR_TRANSMIT entries, but
max_send_sge comes from the device and was not limited, so a packet with
more segments could write past the array. Reject such packets and limit
the advertised nb_seg_max and nb_mtu_seg_max to the same value.

Fixes: 7f322844f427 ("net/mana: send packets")
Fixes: d878cb09501d ("net/mana: report device info")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
v2:
- Drop unsendable packets and return a separate consumed count (nb_done)
  instead of breaking out of the burst; break only when the ring is full.
- Move MAX_SGL_ENTRIES_FOR_TRANSMIT clamp from patch 2 to patch 1, and
  clamp dev_info nb_seg_max and nb_mtu_seg_max.

 drivers/net/mana/mana.c |  4 ++--
 drivers/net/mana/tx.c   | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 30b0ce90d6..5ddbbdc3d0 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -410,9 +410,9 @@ mana_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->tx_desc_lim.nb_max = RTE_MIN(priv->max_tx_desc, UINT16_MAX);
 	dev_info->tx_desc_lim.nb_align = MIN_BUFFERS_PER_QUEUE;
 	dev_info->tx_desc_lim.nb_seg_max =
-		RTE_MIN(priv->max_send_sge, UINT16_MAX);
+		RTE_MIN(priv->max_send_sge, MAX_SGL_ENTRIES_FOR_TRANSMIT);
 	dev_info->tx_desc_lim.nb_mtu_seg_max =
-		RTE_MIN(priv->max_send_sge, UINT16_MAX);
+		RTE_MIN(priv->max_send_sge, MAX_SGL_ENTRIES_FOR_TRANSMIT);
 
 	/* Speed */
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_100G;
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 10f2212b5d..16e63e89c9 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -192,6 +192,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	int ret;
 	void *db_page;
 	uint16_t pkt_sent = 0;
+	uint16_t nb_done = 0;
 	uint32_t num_comp, i;
 	uint32_t expected = 0;
 #ifdef RTE_ARCH_32
@@ -278,10 +279,11 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			break;
 
 		/* Drop the packet if it exceeds max segments */
-		if (m_pkt->nb_segs > priv->max_send_sge) {
+		if (unlikely(m_pkt->nb_segs > priv->max_send_sge ||
+			     m_pkt->nb_segs > MAX_SGL_ENTRIES_FOR_TRANSMIT)) {
 			DP_LOG(ERR, "send packet segments %d exceeding max",
 			       m_pkt->nb_segs);
-			continue;
+			goto drop;
 		}
 
 		/* Fill in the oob */
@@ -432,7 +434,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Skip this packet if we can't populate all segments */
 		if (seg_idx != m_pkt->nb_segs)
-			continue;
+			goto drop;
 
 		/* If we can at least queue post two WQEs and there are at
 		 * least two packets to send, use TX CQE suppression for the
@@ -477,6 +479,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			txq->desc_ring_len++;
 
 			pkt_sent++;
+			nb_done++;
 
 			DP_LOG(DEBUG, "nb_pkts %u pkt[%d] sent",
 			       nb_pkts, pkt_idx);
@@ -499,6 +502,13 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			       pkt_idx, ret);
 			break;
 		}
+
+		continue;
+
+drop:
+		txq->stats.errors++;
+		rte_pktmbuf_free(m_pkt);
+		nb_done++;
 	}
 
 	/* Ring hardware door bell */
@@ -523,5 +533,5 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	rte_atomic_fetch_and_explicit(&txq->burst_state, ~(uint32_t)1,
 				     rte_memory_order_release);
 
-	return pkt_sent;
+	return nb_done;
 }
-- 
2.43.0

