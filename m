Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E02C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B5B340689;
	Fri,  3 Jul 2026 15:13:19 +0200 (CEST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id 9359040A72
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:18 +0200 (CEST)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2ca53c486f2so7369915ad.3
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084398; x=1783689198; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lq41BhrjKl0hnBjxMqc7fvAIHPP5DWhlu9cMWncz6y8=;
 b=Tc4ZQUWsXNsIIfSPRK528860BVRsqUutr2o1c1CECjZAdh178aN0esdnTqfkRFhKNF
 quvqLBmkKH6bcvtzGTvrooy/0PTWD0z67qTSIUcfcv/y0Xf1hD/LOErniPFBT2kq2KUM
 84lEZwDQecAlxVa3PwcAXwF34BuzQ9YkRlsdEfjjR4Z7IpF5au9kguz0o+zwtTdiy7mW
 NpRuU7zzLnDlKrE8c2OZzqVkb+c1yBXYK1LmEFsewvNBFxFVPJGd0kXANmwMaTVK/RGI
 XOuULBTlmIMgF8Iw+OCGRnkJD+4itLGg/bbc2b+eq96Ji5H3x7MN/jeT/B7xBXlsGorz
 nUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084398; x=1783689198;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lq41BhrjKl0hnBjxMqc7fvAIHPP5DWhlu9cMWncz6y8=;
 b=Y4v/8PVEHbNJYNkdu1mvdTK/GDaKrSKZkEfW1muIgxP2nigqbVjE3eGFX0e/i405ZI
 SV2FsU3fTTfYPZ3Q23aU27vPWcxR66pxO4wn4FIibiVOmXApwLJiO+dE1ypEFsO2lf6x
 rnR7ge4wvDFv0VDY7Po6fzzPSKQThnT067pRZgBtEO/ymc/QgcWNItCUUhlu5UHnmxxo
 XnHAVv3NsRGzXQezMkyHadptd/Rdhj3TG/KbtE0y+WiISRvKH85R+MxFwq4hffirbSV1
 Oz0P4gRcfij6lIKHW+OTNNtR7Extr9rx/itYMzM4U79U8iQkJyv4o8nQ2j9GSkXvfejN
 TElA==
X-Gm-Message-State: AOJu0YziQbniN2Z5XGB2im61uC0gOXtgAldd+x8eSEgoJ97JkQVxVU3d
 FC2CMiRGZTDAahwI6/U7q373K2BinU3Jfj8gydqbCE9tXhJUg1TPtf/Mcelv108C1+u2EIFfCBO
 z3jIjpz0e3mdWHg==
X-Received: from pljc7.prod.google.com ([2002:a17:903:3b87:b0:2b0:5538:b55b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc50:b0:2ca:e090:e37a with SMTP id
 d9443c01a7336-2cae090e98dmr17915615ad.47.1783084397440; 
 Fri, 03 Jul 2026 06:13:17 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:13:01 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-5-joshwash@google.com>
Subject: [PATCH v2 4/9] net/gve: validate buf ID before processing Rx packet
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, Ankit Garg <nktgrg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The buffer id is part of the RX completion descriptor for packets in the
DQ format. This value can technically go up to 64K, while the max RX
ring size is 4K, meaning that there could similarly be an expected 4K RX
buffer IDs. Validate that the RX buffer ID is valid before attempting to
access it in the sw_ring to prevent a potential out of bounds in the
event of a hardware error.

Fixes: 1aed73b23ac0 ("net/gve: support out-of-order completions on DQ Rx")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_rx_dqo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index cc343f3fd8..c4e2d32067 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -200,6 +200,11 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		}
 
 		rx_buf_id = rte_le_to_cpu_16(rx_desc->buf_id);
+		if (unlikely(rx_buf_id >= rxq->nb_rx_desc)) {
+			PMD_DRV_DP_LOG(ERR, "Invalid buf_id %d", rx_buf_id);
+			continue;
+		}
+
 		rxm = rxq->sw_ring[rx_buf_id];
 		gve_completed_buf_list_push(rxq, rx_buf_id);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

