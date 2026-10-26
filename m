Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953A606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EshRK+W1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8D624064E;
	Tue, 27 Oct 2026 10:34:38 +0100 (CET)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 23B8640151
 for <dev@dpdk.org>; Mon, 26 Oct 2026 22:21:35 +0100 (CET)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso5665411eec.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793049693; x=1793654493; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tFeW5wlTjkDLigRUozCebZDzMrWCjXsVBoKp/Pf0c4E=;
 b=EshRK+W1yIOPE16rNslNv39W6wLF5RESTyg/nYCyIKrVvRH9im5xalCePyKWVQIy9Y
 cvp6ahHWNhFB5uFs2F6VwNWjabLJe2AZ3WJwRnDIVdroiKR50QiG71+PYz34XTOkyAkG
 LcaggJvcMPR6Iijd/MKLfVC82y3pphRt40OVNDtTdzZ6SA6KpCNwmy1KqCFuZG4DvCi5
 sXSWHaSw5yeV7aJ+sB47FTKdrHiw2aZuv3WOCvbStKkDvkvByIlBFnNaZqhE+iIUzfqe
 of14g89ivZTwZs5NhLFau6TLUntAVEtsZDQVZPlgWkvK76dRxYQv8thYlIySYTLkeWHD
 fOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049693; x=1793654493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tFeW5wlTjkDLigRUozCebZDzMrWCjXsVBoKp/Pf0c4E=;
 b=LVu8wFz/59826C0nL0c1NAgEwm58OcZyquI/IzJpLKYeaqrOlH8xh/cQTqP/Aapr8K
 Z9EMFcfAP+IrDzPSVZzqd6FDNo3xQ8wIMx9taI+g1cu6wz7C/PoE7dBOSAcWqifQVA3x
 SHIb2KhOnBqtQqlqNowDvQ1yeRjOhiTBllC5iczVgqiB1+KgwNW5hSSGjqVFwmznhAOv
 /EUtO+IcP7x2/Hle+9lYcU+bS/bYwCzDzP+tZhDRmo5HmhawMVGsiwXy5Xg8D+Yu/iYf
 h1EwOymZERy32IawNFnMo/ZD+XEkUJYXGUwhKLsXtHiv7imIABJ7cuq2P5S52dGyoDJM
 fbDQ==
X-Gm-Message-State: AFq9FYJScUhKY3rCwmXRNzolt7lW0GzXO3xbE8mTdEsnXOJ3aaFCtMnv
 q5yHQ8I9OXO/hzk7Wfs0aY1Ib0+vzneUK8kw7WB7c1XFIZfoDQ1iJBN0rkvUc1DK
X-Gm-Gg: AYBFou1SEBMU2kLXMGyAQbA1h0rXx0PSVEDRd07fSE91jewj0Ioe5iI1Il1zQCy8PIF
 oUIE+RDO5JI5tkNTYqGeZYBN2X5BDMwHQZISik2z294svUSENJpzxwb2fZDHjZSC5ZKIU3GC615
 GxIWmCa1TtefiQ6qeUkZ7sPX/VTDg3bjbeY4SSlawfRdZq8/g1mK5tfY08uA7VvNN6L27n9tjM4
 Nf/roR5nE8uboUE8tt0ngNDBF7BqjtI+loThPjXL8by6thQNOE61WDO5TaKNVVURrpauYoV8hC1
 Ko7xjigFa+qhKegmBu8OusdWxpDcadx6xbw9DEf5gdDFBpmYcRXhjHCSAj9tE1DCUPI3TCLSz0J
 n1sU0IFyebvN79wktom7p0qBiYw65h0ILpkkhQzg6VnSgP1PhxfNkAGr+C4kqkHm0bIs6uKUNiO
 2kccuzL3rKza/Xbjf7qKmoruoCiev82ej7fzTYIFQ0agxJcFy2lIBysYjVQAYarwccx+mfEmsYC
 84L/wpkQPdBmkBPw44HKlIkElbOdKMOna9+v4t8IxIzlYupe5JPY2yB/Q==
X-Received: by 2002:a05:7300:3d13:b0:351:7e5d:2de9 with SMTP id
 5a478bee46e88-369e837c6b1mr12029254eec.1.1793049693323; 
 Mon, 26 Oct 2026 14:21:33 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a11b45b8csm617393eec.17.2026.10.26.14.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:21:32 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: weh@microsoft.com, longli@microsoft.com, stephen@networkplumber.org,
 stable@dpdk.org
Subject: [PATCH v2 1/2] net/mana: fix transmit burst error handling
Date: Mon, 26 Oct 2026 21:21:24 +0000
Message-ID: <20261026212125.3193356-2-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026212125.3193356-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
 <20261026212125.3193356-1-tathagat.dpdk@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 10:34:36 +0100
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

