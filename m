Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CDE103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3805740E54;
	Wed, 25 Mar 2026 03:40:42 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id AAA2D40E44
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:38 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so4002008eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406438;
 x=1775011238; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33QRfEivyN+ZbbYlNZ/gVRT4O612xhqfFkApaKZV4Iw=;
 b=m3UEwH1zgvHzJqz4+nmdPTU1uH8X6GLYN8OwyYXWismlJWqrsIxdGfX71G0oMOEydu
 LNP9hMi4UxSvRjpHrn0WKOXD6YRvx/Bf9FeuMoLf7/Hoh+JOjCMQugdfQ6I0FO98wi7n
 0+98bCHMtk0VJBqOs5puHN3SR/SzDrrc8qTRPfCM8V/VwJXCdx7Og+PitgzFoziGtl38
 nj7koed4HHmsXCxmxseOv0dmfscooKmkvgPGsEd1q696h0rzcipY77MkXWcpsGubk4q4
 Nt+qApL9XO0mfKMTZd2lGo4iasBMTZqslAuGrDVGknNVlmlv5Gj1OhhgmXP+gw7bhVGo
 FAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406438; x=1775011238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=33QRfEivyN+ZbbYlNZ/gVRT4O612xhqfFkApaKZV4Iw=;
 b=p4lMqlZNPk3phUPH7BjQTRdfl04aC9qxsfW9PVU6qzxiiVgi6diGV7wL6oj430nNnI
 ITMlRrprY30QffSEEovq2kPAPVfgnLaFaOZMDsqVwmFk2acdEHotWHW+t/HrQeRUfxCW
 f39dT0nBdm8tS6DxrY4YSAj0ajFHeCECZsZSCe5IvrkRlx/GkKrBwxLxZn5mVZSc2bYc
 Ez9i7xi+TaLDr0FqkYYZUeOWrvNsypvfnBozPm2Bb5Q1NO6BYAshUc+stbVhI1q3r9YJ
 EY1KxCb8pG5NOjHquEoAVawtd6KIG22B8j7+72CZECobTc02k5PNrHxkDIjtTbAZ2krK
 SXew==
X-Gm-Message-State: AOJu0YxPDQA11tFeSKzEleXFscLDMvlIJ0qkFgSj5msBXWf6apCuq+Lr
 L1KU7Ke1eQRU5emf8V8OmbQPE0oGtUMWvk5T+ItAutDN5rBJAmjzlN9GZxWv3nSmyKsIOrP0Sp7
 wSo/B
X-Gm-Gg: ATEYQzxl+ujQ+K+gcVlDjFX+atIc56V43jR4f1e40StuX5KOUlPQ0QaCA/wF3g8ToO3
 2fyFZ3VJxCvipt8SRgQImmoaoYHu3EWHe71vUhHRUgUw8L8QqyGR1O65ZEm/ZW00pHfrKDKstXP
 aZP2JV8tpQN0ZsmY9bqNAPGToSeemUQgEim1bGvyz4ul0do33AUu7Qlhu5eFqHJ3ciWFEDzKotg
 0hP9AqFYpFmU++p7i3UqCGs8Zy+1TRGnSRSui3TEUMx/darJ5aPrMzQn29vkI2uOkW+7rY7amoh
 om3APBodIkxi/sO2qMuAYERPWjRnY/qNLHLreGZ80C6WInLiTZc/HAWp46GccthLVS5GSyvyjaY
 426cbP/pavxTcsNX9A4tZGbUYQPHnT2yu46BVNXwE0z4Wzm9gFbAKe+vp+hhxPit187p++sP+wq
 7lJi0L2Iq04kxGkyTmLq9eh2j7sCazIpcw
X-Received: by 2002:a05:7301:6794:b0:2ba:6c66:1f0d with SMTP id
 5a478bee46e88-2c15d2a1f45mr814703eec.14.1774406437634; 
 Tue, 24 Mar 2026 19:40:37 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v21 14/25] app/pdump: preserve VLAN tags in captured packets
Date: Tue, 24 Mar 2026 19:37:45 -0700
Message-ID: <20260325024018.1275209-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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

When the source port has VLAN strip enabled, captured packets have
the VLAN tag in mbuf metadata (vlan_tci) but not in the packet data.
Similarly, TX captures with pending VLAN insert have the tag only
in metadata. The resulting pcap files contain untagged packets.

Convert RX_VLAN_STRIPPED metadata to TX_VLAN offload requests on
dequeued mbufs and call rte_eth_tx_prepare() before rte_eth_tx_burst()
so the pcap vdev inserts the tag into the packet data.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ac94efe7ff..6ffe72e284 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -9,6 +9,7 @@
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <rte_lcore.h>
+#include <rte_ether.h>
 #include <rte_log.h>
 #include <rte_memzone.h>
 #include <rte_errno.h>
@@ -135,6 +136,29 @@ pdump_cb_release(struct pdump_rxtx_cbs *cbs)
 	rte_atomic_store_explicit(&cbs->use_count, count, rte_memory_order_release);
 }
 
+/*
+ * Reconstruct VLAN tag in packet data if it was offloaded to metadata.
+ *
+ * When VLAN strip is active on RX, or VLAN insert is pending on TX,
+ * the VLAN tag exists only in mbuf metadata (vlan_tci / ol_flags)
+ * and not in the packet data.  For packet capture we need the
+ * complete wire-format packet, so insert the tag back into the
+ * cloned mbuf.
+ */
+static inline void
+pdump_vlan_restore(struct rte_mbuf *m)
+{
+	if (m->ol_flags & (RTE_MBUF_F_RX_VLAN_STRIPPED | RTE_MBUF_F_TX_VLAN)) {
+		if (rte_vlan_insert(&m) != 0)
+			return;
+		/*
+		 * Clear offload flags so the pcap writer sees the packet
+		 * as a plain tagged frame rather than acting on these again.
+		 */
+		m->ol_flags &= ~(RTE_MBUF_F_RX_VLAN_STRIPPED | RTE_MBUF_F_TX_VLAN);
+	}
+}
+
 /* Create a clone of mbuf to be placed into ring. */
 static void
 pdump_copy_burst(uint16_t port_id, uint16_t queue_id,
@@ -182,8 +206,14 @@ pdump_copy_burst(uint16_t port_id, uint16_t queue_id,
 
 		if (unlikely(p == NULL))
 			rte_atomic_fetch_add_explicit(&stats->nombuf, 1, rte_memory_order_relaxed);
-		else
+		else {
+			/*
+			 * Restore any VLAN tag that was offloaded to metadata
+			 * so the captured packet has the complete wire format.
+			 */
+			pdump_vlan_restore(p);
 			dup_bufs[d_pkts++] = p;
+		}
 	}
 
 	if (d_pkts == 0)
-- 
2.53.0

