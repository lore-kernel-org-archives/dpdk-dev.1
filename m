Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B475EA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7608740B97;
	Sun, 19 Apr 2026 18:11:32 +0200 (CEST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47]) by mails.dpdk.org (Postfix) with ESMTP id 93DE240A8A
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:29 +0200 (CEST)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-4152698e745so904232fac.1
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615089;
 x=1777219889; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LigWUArXYjCalc2QpUJiRDd6eZBYf5FLEHSV/LdDGhE=;
 b=ozwlQoYKqAc8mvPXoXUiH5lQ5XT7ZSVgbB9P3LtQcjO4CVuycbo2/6L7ZnfGe/NYN3
 2QN7IYy8xi51P8vm2X9D7BG/Cuuo6AwhA069cDZOAkoO4uFP0uDnANuzOX5lGvt+awMa
 v3MrL4H9CwUeLoxIqmK3VGzfFNn6Kfgj7MnRrfOdkBSOmjLk78TuiD0l4ZIzsDQPvVxg
 R8Hs6uNukjJQVR8QxukrmU0QsI3vKSatWbhtV42+7XP8xBStIcr0kJ34M/PJv6mpcARw
 8vf30Azxi0HLeQ1a6OthW/vvBKwcXdhbJtCyAacWim0AZ/Q7+8oVGHoIM9L83V+SxCE3
 c3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615089; x=1777219889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LigWUArXYjCalc2QpUJiRDd6eZBYf5FLEHSV/LdDGhE=;
 b=oI8haWmhht63I8a89P4Ds6rY4TXCH5navZEHtRgr+4eUIxxTnHmoH6/OrNZXblWZnS
 Mea8NoOdWdwTa6CGBrpb4WLLGoQNqO+uWdXGgZC6jPv8lOzPGd+1MOjZjh+bZQIwyFcO
 CK7Bq4zgAeZT4N+ptfHNNtt4cJafh0HPmz90hwnkx0wBkQCeTyDiLznx+N6mUZUzVLB7
 ujWkQpMV64wG5WQxU/MDYhyq4QzQRHSO1RFPryUdJsE7zmnuQhpPogXoKRcbMAE0/33i
 ix8+iseRDiFRtU31pzzVdkMSrwBn1uFBOxMsCJrplb4EBWd4I6I6jIuqi93n+Q2+oiq4
 Noyg==
X-Gm-Message-State: AOJu0YwNLwZX2Gh6o8c1Gu2RMRReRDjCjlpC6aNY9of8Zc/ccyGI0rNB
 nIurQFNTKRAzJRfAbr3omVYGWJ3ndh3TL5+TO67bTI7jNCT+T58+4krEQSXFZL8spvZtwAYjZbP
 DmSCK
X-Gm-Gg: AeBDies4Hj8NM6BTb3hnhoDt2cxvI53E0Hgnb2+2x9q8P49UUsNaMZTu1vRF8nbK0RJ
 aG98kcvSAjIqyf8CG0uAl/aCmmIUKGAuGxfmB5rAuZPsI3c7+npYeVna3dk3ffQBD/qZmaAIGlr
 iP83hB8BQN0REy1VsU0St0TAjbOncJYNPvpZ+l7RGz8EtZyOTKQJRDl8ILKffpCNkAWMbDmL0nm
 Bn6utnY+e6YKkwcJUpEVzOTw76pQ017Bsq4lmQ+7PkeJAxGBbG1TmX84Xtqv46bBQn3TtjO1pTi
 E9/hRatF9nw42is/NUc1RYCd+GGRkP8/uQG3QqNCLl2aXbjd0AVPmM+33/77AHiph+viQf3qEMN
 CtJjSC8v9+qWTj2seoll6hpkAuLOOMzz67hs/x8lZeXrmiwVBK5ZN18j3LFGmX31wXxajsZtVme
 ueYuI6tSnh7Ecwoa6AAou09LXgadAWTq10EXF6wBD3K6w=
X-Received: by 2002:a05:6871:4086:b0:417:435c:ba0a with SMTP id
 586e51a60fabf-42aded59513mr6070890fac.33.1776615088804; 
 Sun, 19 Apr 2026 09:11:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v25 18/24] net/pcap: clarify maximum received packet
Date: Sun, 19 Apr 2026 09:09:51 -0700
Message-ID: <20260419161059.205954-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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
index d71ee4ec1b..86bf7d0b99 100644
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

