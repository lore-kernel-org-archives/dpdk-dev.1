Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5683DF43828
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:50:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B22E40A87;
	Wed, 15 Apr 2026 16:48:33 +0200 (CEST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0612440A87
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:31 +0200 (CEST)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4648447e29bso1996876b6e.0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264510;
 x=1776869310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrPzXJjuimhLGi0d5bpoI0iqI8celoLDRbgKUh0q6iU=;
 b=DVLQirgkbC6BiN7JUtd43TtY3AvcDh+XOMRdX0ZM3g6x4B1k9dnqBYlU9MmKOOP/KC
 Ip3OcXJmaLOhj0VeD7V+xr5yeefFVlJIbuiJmuHSPpw4EoEByb1YCqAhNCgG2X1WwTqD
 Yx4M5hv7FAuiltYpFQbY+vsTHgzFJEjqWOm7hU+8UTHT/bMuYt7hCZagGwEkTZ1gPuwb
 HPZVSjNkw6wQp2Ee13DL2pdWrp1CP/vPp5rYCZ7OvqTUvbSmHdgNsf/8w4I5MCIe8v8c
 TMsIwMBxcrY49jVtGXY+bZUwPF6UwGvV8dBVRnFq02zsmDO3g3aN01Mm3YJKLDrHyyqk
 jk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264510; x=1776869310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CrPzXJjuimhLGi0d5bpoI0iqI8celoLDRbgKUh0q6iU=;
 b=BHiOJP0D5BT3cTPtJafzPfQKfX7GzgEfYGMYGVg8UBpiI0HkEoAq1hxE7yBtbikR93
 7zS2vIUcSFkt+CPiuyCyqhSlno2l5Vtj8g5Shd6qMAdYooCyurD4neDvGvfgVgs8CrvM
 iD5is7mkSKad4KjVaG/uAyH7O74fEjtrBDH7HlxnacJtBp1XEzk0URx5GeCH+3AZAUEu
 QztkB0l8enBGNLFapGh5pSYI0kl/Nng8WCT/5v3Bg8coFhcil4LQgAeFAWfBM7RT3Hy7
 s5ft2H/9gSKbSTHh57mJ+F/R5fsafUCj9ZLnrirOdGqbetH6VcP1IHcjnbyrbsrrDHYD
 pz+g==
X-Gm-Message-State: AOJu0YyhkDJtUchvctet9W1KwhncRSFozt6NhjKHG4UZbmdXWvQJlhXV
 YfiyfwEnJN1mKPZPYkZgeE3HLT4d9Lc4Bx8nri0aayNqXrgH6XHKcyKWuW6Y5BcXEYNgzkczrn3
 8d0bz
X-Gm-Gg: AeBDieuoRr1liK/m7bLOvZB8y8AfAvl6jc93ZA9No00bwBIwhi3ibq3dXOb4k6xk8qY
 uzAE76LFOYmgYYxLSlBSt7Ex0pOhRq1aAzGcyjg8moOxYoXPa4evymy+BjoMmIec1kImmM6CjB+
 LvBOTs/BKlEBbftvhkxFXjyeKScvxllVae3RFUcgD83r3N9WkxncO/eWEBwhuLw/YAf1zv2Capn
 XptsHoRXutg2pqFP7XtMJ1/DGUnnisjICKYeYyVHAPH5J/ApxGuLTZYz3p7StXkoMLBtZ/xDOWP
 yzJ0v7KEU/JNwX02vMQ6PChV+2nWwNwxxQrLyC7f5SNjDZNZmi2icK2K5ae5eheYlDC7Ay7/Ojl
 LsnnrHW6ZBtR4OeJqpgwOt7jZ+tDVyfKyKmTBFZ4sSGfLe6s7W09Da0bU2CkNl/kvZhPwfrps3T
 ckylGkK2l24NOUeFLUvqsDlZK/UIFFBbQ7wPbi1WD+JV0=
X-Received: by 2002:a05:6808:6702:b0:450:bbed:7a75 with SMTP id
 5614622812f47-4789e71f894mr11014185b6e.28.1776264510213; 
 Wed, 15 Apr 2026 07:48:30 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v23 18/24] net/pcap: clarify maximum received packet
Date: Wed, 15 Apr 2026 07:46:07 -0700
Message-ID: <20260415144717.226161-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

The driver has constant RTE_ETH_PCAP_SNAPSHOT_LEN with is set
to the largest value the pcap library will return, so that should
also be the largest receive buffer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 99ffc29817..ea0293bf39 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -916,10 +916,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
 	dev_info->if_index = internals->if_index;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t) -1;
+	dev_info->max_rx_pktlen = RTE_ETH_PCAP_SNAPSHOT_LEN;
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->max_mtu = RTE_ETH_PCAP_SNAPSHOT_LEN - RTE_ETHER_HDR_LEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-- 
2.53.0

