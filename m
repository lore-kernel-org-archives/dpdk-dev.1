Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E290CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 21:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39BE840653;
	Mon, 13 Oct 2025 23:20:41 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 880A740615
 for <dev@dpdk.org>; Mon, 13 Oct 2025 23:20:39 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id D8FB71D000CA;
 Mon, 13 Oct 2025 17:20:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 13 Oct 2025 17:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760390438; x=
 1760476838; bh=R+GMdUvYdRhJbcv3Syky/T8jJjoLSvYB84JEnLpl/ow=; b=B
 felVEtjuW4ljtCyPvCl0P1R9E7e44S8v1oDSHum75IvCSD35Ujd0eL4YDwDSevSq
 ii11D34BLdKOa9tBdUtyVNNM6Zr+y0NVxKODFTzdfa7TwWX/DjRYudAKAOMpiBgL
 RtvPeFlLTv9IHuUNmKPEDV5IXGyx1nXCiswvCa/ibeIYb5ZVw8bfu0O6ye0Imlue
 hDiWTNaI/J/1dv0SSvSBpnjtqHDuzJfNOqJGxydPCjnF/qTHdPHY9AkPKYKRNcnx
 E+cT76Y1BzTf5pozOsQcML1Ygimq7YiMZMwi32rMBzdygzLmBkmeEtNgbQjzHJ/p
 TKymCdidRoDMHwnT5bs6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760390438; x=1760476838; bh=R
 +GMdUvYdRhJbcv3Syky/T8jJjoLSvYB84JEnLpl/ow=; b=LGyvCU/z8KYLhwNBF
 6w45iPlOw6wb5KBLtPS80C8sXFZ8h063H8kcrRpjadEcrelAfVI8uErjerL7wiII
 Z9H095cKHFC+0tOsq16bwYKVS4lCtFLz8b8smjpid072JjGgRmnyZRsWEhB+rjM2
 Ar+qyuo/KqOlGrjULZw6QW5HLusmT3WfbtmKd4LdASfHseZnRDwQnENwNEuajIjm
 5snFr5cgUgEbleTx+BSDiV6E1+okUYfqRhsyUAyHwpJsvqcF1yIwFzKnua1YKOcC
 QPlkljZhty00bQ5mQPZWoTs4ckcsYx39dVDOS6SkCnaWWf8n83sgZU7gVpyMFLly
 NEPlw==
X-ME-Sender: <xms:Jm3taCax6_k6Jxs8007SuOjru7aJCLL7-zeTeQhgIgW-USU4w4kfBw>
 <xme:Jm3taAWwuvyguYhNm42iDFHU-5hq8s3SpaXdjStdJQ78OHibLadYj1aN3dnaj2Y8Q
 orEwiGmME3A12iQd-DzMFvhjDyMytqZI6kvHqOKCKkr66UN9HkF3w>
X-ME-Received: <xmr:Jm3taL_mRf6fT-edq50xy2if7uqxF3AzPjhY7zrTNdDSHb2JJHGZsd72rFk68ODXAjWdeyiMf7SPS3logX0t3eMzdyzxDos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggt
 hhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitg
 hhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhh
 rghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghn
 khhosehokhhtvghtlhgrsghsrdhruh
X-ME-Proxy: <xmx:Jm3taJ_d9Gmagha6pj7wwp0RO7opsCJvQOXhLWHlT6OvfBPaRMDxFg>
 <xmx:Jm3taLQSNziLZYFQYpf4FsX4DmbSsUwt5BHWJQXc4hcK9ZazpZLuMw>
 <xmx:Jm3taNcc4E6c4T6zJfJuY3m0t7e-MoTRMmtL-wCAl0Mz2cxOchHqFA>
 <xmx:Jm3taPBFPj9YikmvDVtkRuATMNeCyti8Z1kSIieBAJohMTXPlv3-zA>
 <xmx:Jm3taNJADcs_14xZISVStC_ZfBPOlKPEortVVfMxjxxw7Gkt0HXSOIiE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 17:20:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 4/7] ethdev: mark mbufs in burst functions
Date: Mon, 13 Oct 2025 23:16:04 +0200
Message-ID: <20251013212019.892032-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013212019.892032-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251013212019.892032-1-thomas@monjalon.net>
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

From: Shani Peretz <shperetz@nvidia.com>

Mark the Rx/Tx steps in mbufs for debugging.
It has no performance impact if mbuf history is disabled (by default).

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 lib/ethdev/rte_ethdev.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index d23c143eed..8d59e81d66 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6336,6 +6336,8 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t queue_id,
 
 	nb_rx = p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
 
+	rte_mbuf_history_mark_bulk(rx_pkts, nb_rx, RTE_MBUF_HISTORY_OP_RX);
+
 #ifdef RTE_ETHDEV_RXTX_CALLBACKS
 	{
 		void *cb;
@@ -6688,8 +6690,15 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+	uint16_t requested_pkts = nb_pkts;
+	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts, RTE_MBUF_HISTORY_OP_TX);
+
 	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
 
+	if (requested_pkts > nb_pkts)
+		rte_mbuf_history_mark_bulk(tx_pkts + nb_pkts,
+				requested_pkts - nb_pkts, RTE_MBUF_HISTORY_OP_BUSY_TX);
+
 	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
 	return nb_pkts;
 }
@@ -6785,6 +6794,8 @@ rte_eth_tx_prepare(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts, RTE_MBUF_HISTORY_OP_PREP_TX);
+
 	return p->tx_pkt_prepare(qd, tx_pkts, nb_pkts);
 }
 
-- 
2.51.0

