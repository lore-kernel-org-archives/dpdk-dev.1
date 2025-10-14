Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB9ECCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AF624068A;
	Tue, 14 Oct 2025 14:41:07 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id E7FEC4068A
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:41:05 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 2B7341D0016D;
 Tue, 14 Oct 2025 08:41:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 08:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760445665; x=
 1760532065; bh=/jGfHMudWxJ74bs557G44vGu6kyv4OdpiN3FjE+hbpw=; b=E
 HsGu0NV4u37D6Jtpz2MOIncU2Zve0Y8/mB64aWVRYRzlCfFHma04kAwu1jyuRV6x
 +Fv7d/JZPnfcSOc1vvjgQULe/Q/qjmXhFjnaFYXI6ry6E6/+0/z2Ey+LytOCLQZ3
 wzc1gKOC6Fb0ryT9v+BKadPioSic3xgBGYAwxL/okLR3liZqYcOE6oGS/E45eMJz
 xAUArFUixyFWfa5bn0O9H4qw5rn7hPWnl+/I6hCCIojBCYUhmSwhJ+YcC1niZgE5
 sUjilGc4r9c2PDOGN0GbslU7anz0qZGr3hNCNvdWAO5i1NMD95XhNU8ml8+R6WY1
 aCNXr9ewCSX5z1JBEMz8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760445665; x=1760532065; bh=/
 jGfHMudWxJ74bs557G44vGu6kyv4OdpiN3FjE+hbpw=; b=ZcPHuwFsXrEPGcqN9
 CTJ7spJ+++T+hDDtfBaHb5oL+iPTPFahRUMhKIbRx3fYj9ypJ1RC4fDeKDRT+HsR
 C2ZrhwwxMc4NPPmg1JHk6GkwHbgxB7Ugn4441UaZG6xWyBKI5A4obiIdmnq5+Rlg
 /1GMmkkh+C1sMASzZilZXJGXeXQwuYC7kw1nDQdpOpE2Zre5BK/JCoeTyz/af6n5
 adz0kQ51Ev5ZLW6vX0CunyOZ2BKwplqpGTEZ2XEI+KWR3EIVkISR0Aqvr0qqD+Fh
 zev0JKZNW/9uEkhlxSUb/p+lcO6qngDEP5wbA+v2ftr1Nnt6LyJsaas0SP9rl/5x
 EVFxw==
X-ME-Sender: <xms:4ETuaDEynz-f36pgC77ejjT3GFYXXKuRUU71QlxtOE98cS9DnuIF_A>
 <xme:4ETuaLSDPHC9fErPaT8UN8C-W2TgVWDc3sMj3SZj-nazAS6HG_QqW1SoV2BUkZMrO
 J5O65bxYttn3rQMjmHE9vaYBOq_zMNo2XRz6EZWvW3tETe5YMZe1w>
X-ME-Received: <xmr:4ETuaEJCELgpIbuQ1iJ7Zt54v_7Y_Cjmq5vQeAJbQETC7cpXb2Nb9prydX-yppT4PTFbDXLSd0DG5-sCy0spzH6CuX0xHWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4ETuaGaGGUqnN2EDWylNAtnCMbmGv29Pr-F1CqQh2mUXNIv5tk2WVg>
 <xmx:4ETuaG-56cDJl3xuV0u1XHJ8FgaS8XVcjwgj7sD7fv7HdtLxWPs2mg>
 <xmx:4ETuaHYcIeOVZyrg1nqt6wq_c2pJQm4oP2GDa8ZTPtbjdcdn2RnOsQ>
 <xmx:4ETuaKP2J00PG25LkVQRPwmuax2ZWKO7kkx9pyqD9glulJs_n6VfzA>
 <xmx:4UTuaOHVh9uJPmwd2KfkTpgziiRq1telgtIlGGVT_kpWiU3BwAMQDR90>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:41:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v6 4/7] ethdev: mark mbufs in burst functions
Date: Tue, 14 Oct 2025 14:33:37 +0200
Message-ID: <20251014124046.1032293-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014124046.1032293-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
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
index d23c143eed..5e250e5083 100644
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
+				requested_pkts - nb_pkts, RTE_MBUF_HISTORY_OP_TX_BUSY);
+
 	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
 	return nb_pkts;
 }
@@ -6785,6 +6794,8 @@ rte_eth_tx_prepare(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts, RTE_MBUF_HISTORY_OP_TX_PREP);
+
 	return p->tx_pkt_prepare(qd, tx_pkts, nb_pkts);
 }
 
-- 
2.51.0

