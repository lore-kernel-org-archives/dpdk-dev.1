Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0509CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 20:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F6E427E0;
	Thu, 16 Oct 2025 22:36:15 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 185A5427DF
 for <dev@dpdk.org>; Thu, 16 Oct 2025 22:36:14 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 911DD1400122;
 Thu, 16 Oct 2025 16:36:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 16:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760646973;
 x=1760733373; bh=TqI/Z7Ria0UO7aM4y6GDUk6fXCmfzW/5YEGnop3plKE=; b=
 D+hDfzuNyJZwzo8XUugmIhTY3+M/JgJb+szew5H5LfiBlobuElPb6JO0+fYG4yJV
 PBCjPr6NidyecJBOo0wof3sHACXd0YFbgzsi4gXCxyhsL7hocuSSxSSKPAd6KU/I
 p9DjuakMZR3bK61Rt3QS6zMD4zDviiwbNmWuaa+Jfy1UMN/ntJmzuJJblD05N3yk
 omCTqTNcVgdTghopVhk8TVHTuW57x7fD+f8/pr7z9zkfKipgB3d+y/GE4QJao2w2
 P7i/C0s3IdVD8V0KU/2odkcFCsTOcOckS04uzgNTCOfWuKmSjD+9jM6CDnFJtYjS
 xa+q9XWm4TZsHfo2Mo/C3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760646973; x=
 1760733373; bh=TqI/Z7Ria0UO7aM4y6GDUk6fXCmfzW/5YEGnop3plKE=; b=H
 ex89tPRZ6Nw3+9Ah930XLezlvAMMvY8H17b4ZYtQOKAdYGAfPBfGjy6+XCAXd8D/
 uxaMm/QlGFk+NV43QS5Kz1guE9Mj+bMAxn3q9ZllQNAW/MU350D63CyIG1dv2Jw/
 9P1z9FYKyQqL+lYyFE6AE+qP7thU8O1Agx9m/JKSofdAKst1dBraOzEsPA7wyhhT
 26qtG/1HMxGRG62YTdcVmmFDT9jCJRYf1DR3Xcq16PLeaYC+Z0GI0OrVp4j5zRo7
 6kUGocSVpQR5pYPaXFy7XXaNI2+Utz6M7rBatVElwoTSrn25dWFSOQ1/SGpoPfLi
 I+Et4nAekHtdGh7Hx+5UQ==
X-ME-Sender: <xms:PFfxaCPr5RK1xVs3QHfa-DiGGWl8kBkYHU71l2qb_QbkTCpgWBaRKA>
 <xme:PFfxaIUGc8nkxTLdljnrUtjEwSTuPIBHN6zWlJwCv6VcpARE9uTeSAC_r5qQg7DUT
 hv_SKYwLU7uS2GSulldUb_x9o2jsKLxY8s7xtEAGsg_R6X6rMZlTw>
X-ME-Received: <xmr:PFfxaO1IP3XnUIDBHwkKtrdA3bxugvN1GmxhucPBdgWrSPfpeF5BIns-9O037JeFFmgnYqg-YYSSYgso9x_xhVItcx4Yeho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvhhhomhgr
 shcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecugg
 ftrfgrthhtvghrnheptdeiffffgeefteelhfekueetueduffejgfelvedtieejudekgfev
 heetheehgeejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
 homhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgr
 tghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhutggvrdhrih
 gthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhs
 hhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfi
 horhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgv
 nhhkohesohhkthgvthhlrggsshdrrhhu
X-ME-Proxy: <xmx:PFfxaOrWNnMYA64rZ71Bt9nrnvAWvQa-tIRsk_Aw7Zzn3w_oY7OsdQ>
 <xmx:PFfxaNUr1-1pdeZijuKWdpIBt6zmKKhLJIyfaauLTxWn8k9TpPk3GA>
 <xmx:PFfxaBbcD_yqCNVxt6XoDNML8aanf2Cosh-19k0p6SSmku7FYUYJIQ>
 <xmx:PFfxaCfZEd0coWLrGTlg3YilAA_DvzvFK_cQmymyNvxIZBu-XdmUDA>
 <xmx:PVfxaFyl6L6OHlVGQ7bSUT2EcN7iuec7GgROmGSXK4DDQLwjVQjRa5L3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:36:11 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v7 4/7] ethdev: mark mbufs in burst functions
Date: Thu, 16 Oct 2025 22:34:42 +0200
Message-ID: <20251016203557.2554678-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016203557.2554678-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
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

