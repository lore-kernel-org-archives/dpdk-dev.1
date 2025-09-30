Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEEECCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 23:39:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17EE840689;
	Wed,  1 Oct 2025 01:39:01 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 4AB184065D
 for <dev@dpdk.org>; Wed,  1 Oct 2025 01:38:59 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 847037A0149;
 Tue, 30 Sep 2025 19:38:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 30 Sep 2025 19:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1759275538; x=
 1759361938; bh=dnf+64shqECrfkw/Ad2frRjna936OVUnAZ1Y+KKlJi4=; b=Q
 zyt3SJdpAAh5vw4vDKde2B61KK5XquK+4Qa21dT+lbnH+w+9qB8S5anG7dD+nBrQ
 w2yNljnrE2XYgdo4F1EgCoFkv2cSVGPZadY2DkUAOX2uq5iR1//xrfEGnpDJvPQe
 dcvggYomBaEuB3XPO7YQU2sH+qrChEQrRgCQ7RULq34oYMwQC8I3IwZR1NENZgws
 qDeQhrW8ET+c1YT/ZsAEg1d2yAtprRr90QUred4lunIFzfDylY+F1rua2XfinRrQ
 RvTjuMxkYmO3sYyudqT1Sw7t0nGPGVNqzokPD92oDj26U6EupZkAKWW6qxvdBtnf
 ttim/LnMvFMlFBk9Hno1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1759275538; x=1759361938; bh=d
 nf+64shqECrfkw/Ad2frRjna936OVUnAZ1Y+KKlJi4=; b=vkT4vDaqMv7xmXMCe
 NQwoOumkq/raGnVSlKxq5BcI059EJaAofFd/ruYlED+Si+C0y7vO0dIlu/FvuG22
 11l/opN6kD5bUCOnzKRXoy4CVdpN3RLYm3W/A8a4wD/LnZBo/dW/mosScHyft5IW
 nU8hH0cLDTNB8XsqhhC5/5FXSEJvmaJ71dWIBNsg5yV8Qh5Whu5kjIO53yYzXqej
 fbZX2DETIiDNUvhaK+5st++aQyFvMXGt1NbYsrQCnb3wE+zJQqFqXXFfQxOclABd
 4iZEY3RTUB26dj0V8N5kYkd8+851dDZ+j8tAgoTcDslj4E4C0uhw5cmSF2hkgqWu
 HE/Qw==
X-ME-Sender: <xms:EWrcaO-bdbE4zoQq30r8lYq5y_9PTisTea6mzlWiOD1UVVgu16Rtxw>
 <xme:EWrcaJo9sMrZsi9Xlq_9zzjhnpdxDS745cCdGNHkiDbe7vCucbnwTPptMx8nxcoJO
 Q4vlOe97H-A9LtnvDkRPCW727Jml-ofMQxHqN9A-Dvg3UhK5ND3ww>
X-ME-Received: <xmr:EWrcaDANYwi4dx_-7kCbUmlY0TTAwDWunVi3mFktJGAWm_74Sb9DveCrvvfrVjcTlPBQ3vF3tzYpdo-pGcLtr4gnjrmYAUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepshhhphgvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghh
 vghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthh
 grrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhshhgr
 rhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorh
 hkphhluhhmsggvrhdrohhrghdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhk
 ohesohhkthgvthhlrggsshdrrhhu
X-ME-Proxy: <xmx:EWrcaLzBE1fs_kqoIi71mDFDvLqGrMQYI2OS3TJUCGSOd4PL7W_IfA>
 <xmx:EWrcaA1BDGAxBsdSlsOSVfkOinpmBXz-zEeet4-xvlsTWs5pb6PdaA>
 <xmx:EWrcaLzOVLQVeDlWkYwVQUmi3hPCV7bkxODOz7gjDphFfrR-WXnLIA>
 <xmx:EWrcaHHC3d7SqjKpUGszO2zabc7NNkcWpTNaGyV2BJSnB9MN7RHDNg>
 <xmx:EmrcaIcHlbtEP5ousy1ilRwgHH0myiD-60UbZ3Ent6VlW5Rje_7_oVVq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 19:38:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 3/5] ethdev: mark mbufs in burst functions
Date: Wed,  1 Oct 2025 01:25:04 +0200
Message-ID: <20250930233828.3999565-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930233828.3999565-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
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
 lib/ethdev/rte_ethdev.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index d23c143eed..8a9683c5e9 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6336,6 +6336,8 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t queue_id,
 
 	nb_rx = p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
 
+	rte_mbuf_history_mark_bulk(rx_pkts, nb_rx, RTE_MBUF_HISTORY_OP_RX);
+
 #ifdef RTE_ETHDEV_RXTX_CALLBACKS
 	{
 		void *cb;
@@ -6688,8 +6690,19 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+#if RTE_MBUF_HISTORY_DEBUG
+	uint16_t requested_pkts = nb_pkts;
+	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts, RTE_MBUF_HISTORY_OP_TX);
+#endif
+
 	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
 
+#if RTE_MBUF_HISTORY_DEBUG
+	if (requested_pkts > nb_pkts)
+		rte_mbuf_history_mark_bulk(tx_pkts + nb_pkts,
+				requested_pkts - nb_pkts, RTE_MBUF_HISTORY_OP_BUSY_TX);
+#endif
+
 	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
 	return nb_pkts;
 }
@@ -6785,6 +6798,8 @@ rte_eth_tx_prepare(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+	rte_mbuf_history_mark_bulk(tx_pkts, nb_pkts, RTE_MBUF_HISTORY_OP_PREP_TX);
+
 	return p->tx_pkt_prepare(qd, tx_pkts, nb_pkts);
 }
 
-- 
2.51.0

