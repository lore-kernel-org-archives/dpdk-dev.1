Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A93F9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:12:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97B9D40C35;
	Tue, 14 Apr 2026 18:10:38 +0200 (CEST)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54]) by mails.dpdk.org (Postfix) with ESMTP id B708A40B99
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:35 +0200 (CEST)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-4230a00de40so3948312fac.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183035;
 x=1776787835; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrPzXJjuimhLGi0d5bpoI0iqI8celoLDRbgKUh0q6iU=;
 b=vu+NnzdJaNI+eiXcgQTb+1UYbMKSpPsv73EMfEeppwcIdJY/iOAz6w3QYHE+Yi6eYW
 zlJDixHrCxapqCm+ZmDM2n97c+k2LRxzC9MTmFz1HZ8yWP9DyFqkQIuL1WR2zx33Zs9S
 NZ7J1FDzpsa5V51uikkJqV5XGGWmZ1309A34Q0GihiRMprrfOLtA4HErT3cfWd5emq8s
 8/8WaofN8hHJxcvhIDwnnMLAyfugzaZvsDStJ2+qtLXo2+bMC0cFoaOyWvCbBMGhwxp7
 KNK0K3I2cDGTHOcmBpzeQbOro+ElYZit5EFkTsndyqRC1xrtNNBnpntqBkGZEqRXLWv7
 WQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183035; x=1776787835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CrPzXJjuimhLGi0d5bpoI0iqI8celoLDRbgKUh0q6iU=;
 b=hc3tcWU+N1xOusbH0tdXH5vimbt6ggVX8k7IkfOped/IaaI45cPyen0dQohsT5VQDz
 RIq0etPSU9iz4tAF55NpX0/nbTtIgngdXba3tH+yOqi2ZYaJzAN6Ywah4twM7uYy7LAo
 bYGkjCEH0cDeyuiweqZOaU5+Fl7qwXNaySkpxcIzbKSDSFRWkyYgM1fgSRrIZuykiM5m
 QFjiwieS5j6hd6cGoHW/tPpCPyvi7w0JfJoA1+j1QkPEGa1IvvUQio+yckIIV/AyFzj2
 JguWtdXBc522RARAux24MtDPyJiclOTQ30rUKjNvoKkA9bTCAe0W0dBZoB2GgIZT6+7M
 KAuw==
X-Gm-Message-State: AOJu0YxApyW5O1kZNFtJW+gRvcIGi8LFEQd+8XfhImeCf39nsMww5Y4H
 YuHb8CbJeg7rBUmQSM9lwcVBX4Y4uQjXsdMKdZ/eAymBr0cSALDNO18NjQPRk2Zofh8ahKPq7oz
 NzXyK
X-Gm-Gg: AeBDiesII+hYVUgNOPqFkxgpfZpTlzBciPYbxTSoIpSVr++ewx68tE0ODf+wBTBti+P
 vKf8bTA4FVo1cfTz74FZgUZlK7qtUAojqM0WnkM8yPSqPlQJ79CafX2XAvUEVqfhSB7PX1urZtB
 0Zz0gLIJHi4o16u69CFXv3iATRwtk2b58OW4kZ/8vKN0Mr1FKjtNwpzfU71DQrxHPNUivk5vS9m
 GadVEnpAgmQu/ua7re9/BpNtA4PoYMptRrKB7m2V23+USrRFzQnkUDV9rerSMdT+md0nJw9DAJ7
 g5iSVgFDHTu43mCG/GhPZ1U4e9GL1otr9EojRXRee4JcDsLt8XSx1uXXMDij4Q6zq+wBudgmzbm
 Ki2qGKGO7f2s76STrxdRh7rIpyEky5a1TFeIK6aeIwmLlTWXsR7M8HQBdnzZOu1EK9/tCG9UyaG
 CB07KA1POoFTMt8fOYTc3BwzCNZa3ejEhSgy3jTHWXLuYwm7u++/oHtw==
X-Received: by 2002:a05:6870:702a:b0:423:4e3f:7570 with SMTP id
 586e51a60fabf-423e1e18382mr8346691fac.15.1776183034961; 
 Tue, 14 Apr 2026 09:10:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v22 18/24] net/pcap: clarify maximum received packet
Date: Tue, 14 Apr 2026 09:08:09 -0700
Message-ID: <20260414161011.756101-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

