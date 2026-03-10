Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3E6FD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67F8A41141;
	Tue, 10 Mar 2026 17:14:31 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id EC8D241104
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:28 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7d73e0e0a36so1161098a34.1
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159268;
 x=1773764068; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkbf71K/J9spa+hJpKcJCqOxcDuCbx1nhSOf8WS+VZI=;
 b=K1P2wvizna+dmYU+/BC3XYvRDIIKJP18KrKWW8h9vswKV5e7S/r5BovQeh4zjgDZZE
 Vyogn0OmKLkkWewJqe7+SNsECN8joWNYN8IQPaolFNKiHbGvVjLk0hila09G0t65K+hy
 Mx9UfhQpn3qwsz0G7xgtS3jJfp6U61FvHfUYG9bTtjFaC0/+4L64fA94JainuSdLuzax
 VVWfKQbSYxn61STC+u8Gd6zRLIERj0TCK9VMFoFmt4yPqWm4JoelIZhPd7sAirdgJ7gW
 MGkQdYiwI2+kZxSthqM/KkUg5VMz9Jz3DOyJa8r1L+rjQsj/rThwgcwr6wQKl2q9mPW8
 6FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159268; x=1773764068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xkbf71K/J9spa+hJpKcJCqOxcDuCbx1nhSOf8WS+VZI=;
 b=YZzTG88kxduEhY6FRBFN5T4Q+OSPWnmxTeVRZWyXVOp+4r+ZkABED1RHWB5uBdz9uP
 EYNI+fYZKyeWGIeBkroIwCZuvj7oYcXDSgZdaRCjQeaJuYHE+AtbcUGdV5E9TKccPImk
 7jXc2MI6lhbrvqJTWjHwDLvBIOj+BelmDOf3AETYWyKYnp36wmHkBowNW37kKsIHzISi
 sOnWw6K3nWACkl04iWm4G/eUBQzI7NM4/i7UkHSyU7Q/RriH+LJMwDZRhETbb1Lr5Pb+
 1bBDQ6AqKow5G8CfyRZBpO8p1HJQ+84bbaQq/3nnY2LByP3Lu8/Jga+P24qOzbWhSckk
 mohw==
X-Gm-Message-State: AOJu0Yz6rv6Gt02RKS18bI83bvhJgdVgjJZUc+wvrAWdvX2X71wjp498
 OCioEFEEhzpCexntKBf6QWIjj72THWi8GM9+RWREUjksE5xQBGbEecfUGzFCcHV9vahoWkk2MiV
 FghVk5h0=
X-Gm-Gg: ATEYQzwWjx8hzTt8vZ0cKuIP2kSClPdaQWW7FwDTlm90TCzikr9BgVEEbRQZ5H6mXUX
 +9tUC6s/aQYNjSmG9oBDNguN9aNfsr7cHLVhJbhqKhvGJRaFuHOtvhRjuk0SVP7PjVavaSzPyTG
 //JG6XW/kIv0xwElc8Ir9Yn8QFKB+y876aRYSJWsRx5HBeg1sy2hTz1r2kB4lg7dS8HqVCgrKaQ
 oUHAo/gvXaYIU5hx0H77EsF1gQTnrW+luDPAzBRukHCT0aYG63yqDQLj6arkOTBXCPSWoqNUyFr
 1Rbq+t0YDIpKqSk1bsNbC1uHedvlH8zfUeNzXA0HE2M2l7qyu9/DhMiPO7I7BuiYhcBjak2+A6c
 auhTrnABBqEfqC/EqtXomK05U+bR2zb/S+RMH5CmyMHg0EcYvKsbJbmjpydUBG5R3si0sZOhCiG
 ExfMe9S0yuNo4GfNSo75eYrYOZ3Pn7UN6N
X-Received: by 2002:a05:6830:4122:b0:7d7:5604:72a0 with SMTP id
 46e09a7af769-7d756047568mr3399053a34.13.1773159268252; 
 Tue, 10 Mar 2026 09:14:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured packets
Date: Tue, 10 Mar 2026 09:10:03 -0700
Message-ID: <20260310161356.194553-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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
2.51.0

