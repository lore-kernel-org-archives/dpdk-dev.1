Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68238CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:05:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A04640613;
	Tue, 14 Oct 2025 09:05:40 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id C2787402D7
 for <dev@dpdk.org>; Tue, 14 Oct 2025 09:05:38 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 37BF914001EC;
 Tue, 14 Oct 2025 03:05:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 03:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760425538; x=
 1760511938; bh=R+GMdUvYdRhJbcv3Syky/T8jJjoLSvYB84JEnLpl/ow=; b=X
 i8yiUJmku/UOSSG/5kR3PJHICPif1EsgTJjVRPXviSer5Lntfgc2vOWzgmdaiaZP
 mbK+iKBp3sKwbezcWIEDZ4VaJ5CUJAAYBTfoeRRElC4SIaWWXnWJpMTp3Kz0AeAf
 MMvjcaRUUAGAPu6Eark3OEi+o1LlOb3Cd2piks2WC6jrg8+OY96WWOjufZj6dc4R
 Ql5Ysf4MtkJU5z7UmDgOzcmo4/GbI+fUU5aKgMyGBF/BHRWzQj5dxuxPus78BAit
 sFT38kql7wTCmCHAa/SjBRouFufdJeC06aHo7dmmQKbkNqRXfbnm9fBMloedUDhs
 J8cu5qZ9OrjvlzKvWG5MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760425538; x=1760511938; bh=R
 +GMdUvYdRhJbcv3Syky/T8jJjoLSvYB84JEnLpl/ow=; b=W6BqJTCUuwLQPXZm5
 zUqXXSYZUWa5AeApjk/+mkYWF0R+WBZkZ7gCky/9yNAu2Pcr1Iq/4aFE6hPShUoP
 L9+xBA2Bk10xdTApH7RH1OqWPgjIYJolc/YUzGVPpB6WBzapC8mkh50DvxenIVV9
 MNKGZlzmp6bbXQdxL4zGGtLnqK93Jd5fA8y3u22tk28itQQR6jGeiR9w98UwVXWI
 TvimfJ6ktyfqgaramXCEdczl/CuwNx6MkGax2P1/tshxbDmQDOjwFVLPCY59Np1V
 +PzIcEh9KEwnBqTz/We1F9HfO3oLTANTH69jpnXcXEMypeEA/uSFMjJX5WnjOl0E
 /gZlg==
X-ME-Sender: <xms:QfbtaLs-hgUQbhYq2ZVDtzkAoB3PELp7jgXyL4ELutdDcwKTAlThZg>
 <xme:QfbtaHbWGIRUQmDgDqzXtKhmfooVSA6WSs8kblOyojuRCd6qCR22KNEn7M-Aat2gD
 mWhQs4tM0nNYIEc9hwAYo9XDEUAxxHKNyVZpsSIg6270AiHSyiZiQ>
X-ME-Received: <xmr:QfbtaNzKEaYw4DiXXpoha6MFpyxYiRK6lNmc1V321l3jRWS6TmYz5VZJu7G2K7LZw0pjA7cbtL2lPB3qGGOnKfpHeDAnzYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelkeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QfbtaPgLc3uhai3tjiM4kb-FVFhXC6-h4M2BIKAOU1WiD3tOtGYx6A>
 <xmx:QfbtaJnEoPBoX69w3ZZ7SPsFlv4Xy3y4mRcsTWqPCIwIZ77I5qT14w>
 <xmx:QfbtaFiZ0F5GpA7iYkMtM3s14nc49TNRM_XdYdECOn15Cb5pcNF-GQ>
 <xmx:QfbtaN0ua719B4hoJaKg3-enN8cJhNuTyFThRoqH0dsuPRuaK14k7A>
 <xmx:QvbtaON5IOg6qpo4wFKX7THcm-Tbtzy2iM9Q0RFrXXCbNwdQAAD_pGjN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 03:05:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v5 4/7] ethdev: mark mbufs in burst functions
Date: Tue, 14 Oct 2025 08:58:32 +0200
Message-ID: <20251014070517.922137-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014070517.922137-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-1-thomas@monjalon.net>
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

