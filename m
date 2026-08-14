Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E171C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7280F4067C;
	Fri, 14 Aug 2026 14:55:51 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 472D44064F;
 Fri, 14 Aug 2026 14:55:48 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 7A633E0ADB;
 Fri, 14 Aug 2026 16:55:47 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 7A633E0ADB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712148;
 bh=+Aaz+6MoWuikZOupjmYwcEYXE2TINTso8LYQ3zhyvZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=7dcyRglCIKcXGKJK4n/wXEeSo+YzPzLgyfMnOF2EfDo6GPLGKh4y5Ho8UdNtWnMYK
 B2sVHFKm4ldGnL3eGzbkvrj9syg3F2HN+sx1mbt0talPm25Y2MUd3H5GWsc2Oos9HT
 SS1TW3jO1kum0xIXrApKovUYSpW0epdmbw1i/N1tULs3RPglE1g48lgYG7+EAEz/He
 9GzcV7Ux1KgXZG7A85NGvBNfBMrr0WBu2jqg932ndXL8DDiZKwNuIBY9LMOxv2Vcol
 5NTziG5PJ8x6oGCcnftssahvhN6NfEAuNfRf3qWGYIbRQEAhnjprC18Wi9VSqJGPCI
 692n1JVj4KvJw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 1/3] net/sfc: set Rx queue type flags from scratch on queue
 setup
Date: Fri, 14 Aug 2026 16:55:43 +0400
Message-ID: <20260814125545.13343-2-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125545.13343-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125545.13343-1-ivan.malov@arknetworks.am>
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

Derive queue type flags from scratch on every queue setup
so that flags left over from a previous configuration do
not persist when an offload is disabled.

Fixes: b8cf5ba549f2 ("net/sfc: support initialising different Rx queue types")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/net/sfc/sfc_rx.c | 8 ++++----
 drivers/net/sfc/sfc_rx.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index d8b961ff7e..1d4101b9e9 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1183,9 +1183,9 @@ sfc_rx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 	else
 		rxq_info->type = EFX_RXQ_TYPE_DEFAULT;
 
-	rxq_info->type_flags |=
-		(offloads & RTE_ETH_RX_OFFLOAD_SCATTER) ?
-		EFX_RXQ_FLAG_SCATTER : EFX_RXQ_FLAG_NONE;
+	rxq_info->type_flags = rxq_info->extra_type_flags |
+		((offloads & RTE_ETH_RX_OFFLOAD_SCATTER) ?
+		EFX_RXQ_FLAG_SCATTER : EFX_RXQ_FLAG_NONE);
 
 	if ((encp->enc_tunnel_encapsulations_supported != 0) &&
 	    (sfc_dp_rx_offload_capa(sa->priv.dp_rx) &
@@ -1660,7 +1660,7 @@ sfc_rx_qinit_info(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 	SFC_ASSERT(rte_is_power_of_2(max_entries));
 
 	rxq_info->max_entries = max_entries;
-	rxq_info->type_flags = extra_efx_type_flags;
+	rxq_info->extra_type_flags = extra_efx_type_flags;
 
 	return 0;
 }
diff --git a/drivers/net/sfc/sfc_rx.h b/drivers/net/sfc/sfc_rx.h
index 4ab513915e..bd189e6a56 100644
--- a/drivers/net/sfc/sfc_rx.h
+++ b/drivers/net/sfc/sfc_rx.h
@@ -110,6 +110,7 @@ struct sfc_rxq_info {
 	unsigned int		entries;
 	efx_rxq_type_t		type;
 	unsigned int		type_flags;
+	unsigned int		extra_type_flags;
 	struct sfc_dp_rxq	*dp;
 	boolean_t		deferred_start;
 	boolean_t		deferred_started;
-- 
2.47.3

