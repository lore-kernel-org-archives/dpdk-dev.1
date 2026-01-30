Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53617E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 785F940A87;
	Fri, 30 Jan 2026 18:35:48 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 7B1674068E
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:25 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso24323075e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794525;
 x=1770399325; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlcqFC8n6cBujT0d8pZWE5FvC+E9TuzvyW45n3haPSE=;
 b=XVqYlFB2wiNoW/K/KWTmU83o68BCCrekaZoDDjIjh+HoxKSc3gctJYJNphczTSvBDe
 3MTfVZoqH5v9qSCINWVDYiu4LFD4dvF8sa06ha1xQvhMhRzqSovAwCMR/G2u6W8uME0k
 wscK/KqRxhOUyJmgozLIUTLmzr2emWVhk1I+/ogCrduIkM2BHCfTfig0BZhVZtXlivYd
 PlGqRQq/0WSn/s/WH5FpRp2oOqi8fc6bvsXeqVbu5ivLghV9BT/S5/ZE2681VcID/byv
 IclzUAdjhpYnUTwjGpU3mKcgZwyGkb7rwCKHbBLZHyuwyB+/bhZSOl2ehgyZF/i+ncRH
 O61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794525; x=1770399325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WlcqFC8n6cBujT0d8pZWE5FvC+E9TuzvyW45n3haPSE=;
 b=H6vU7Obq1DtH8vz40sJlUMB9PfUc0aeJ08muDcyTI8iS4LY0Sc5JAHQUzs7FCsOtfw
 IkBKe5euj5I/0sbQo/ZIXm9yu16+o7tmR0BhVBEJCuCpha7NGHcAYcjVY2AuNIWMWkmT
 J6e51NrCVBcfCq2o5jUW0sSCUAqp1UlEt7pVVAu/jH+Fg0MfqB4+YfEi0hIY/1TS0hHb
 V5DrasnnsYzqghFmuH8aJEdZGO41BOTaRAOIAHfAY1gWzqeMCMyURHLZI25DiVFmR2IA
 04xeVDyt9dIFfy23uAGvxsYRY1iJRe7dMUlnNvAP4CZeK80bdpB2AKqC3PTabytug5/7
 TTXQ==
X-Gm-Message-State: AOJu0YxpvFup6WI5ne7gkulDKaM4aSK8xsldtPYwxLl8lMuFzH6YCYxX
 SuB5dZlYtcIoKU10UyBimNwlDrne/DwvVg0weJ9OW0CoSFBnOPmesPTgoGbY86q9gkHCtMyFvfM
 9YGc4
X-Gm-Gg: AZuq6aLR2YjHO9olzkwuLP0rCoM/Tn8UZrvNDDVCxXxzfwWLG/u4vA5AA05emJoVpTV
 O5oigKug42O9+y2Tru1usx28hQnLj4PlRwcjjt6WnyOR7LXLT19W2uu1HgEQdyV9A76ZTmTX32P
 p6n+6Ymx/m4jd3btnyQx+j8Rc47y8cAmIFFmu8+olxaqm9s89GDS4760A7SUZl2Jvbd2SQ9nSrD
 gRaFmd4aJzZZDX9y/ZJuE8BYNVJ6LsnyD79FXfbl9S9sYVqjctKXYVhW1NEYb/o0QnBshfjfwOl
 g5LOBeXrs0MspghwN4fXCrKwacNCIDra1Ofc2hRqbgsZYR/JySGFIWe+2s4Md0ikt6dmkD5rjj1
 KinzVZj9gNGU1tmIFReUNE2ulrxz1ADpjObSJUMMNhzy1JV2TCiOSo1yzYUCGmzceSWxF2ZCndr
 SnC1HFJ8RIiTiKEaF/ioBuao7+Y/kjnk6ReLt2+IXul3eHtCIVmg==
X-Received: by 2002:a05:600c:1d1b:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-482db493aa8mr47146015e9.22.1769794524856; 
 Fri, 30 Jan 2026 09:35:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 17/19] net/pcap: clarify maximum received packet
Date: Fri, 30 Jan 2026 09:33:30 -0800
Message-ID: <20260130173447.14546-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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
---
 drivers/net/pcap/pcap_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 5e72a985e4..415de46e22 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -820,10 +820,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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
2.51.0

