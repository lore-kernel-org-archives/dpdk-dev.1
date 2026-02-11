Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE818ECD6F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:23:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B275B40BA2;
	Wed, 11 Feb 2026 23:22:09 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id A513D40A87
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:22:06 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43770c94dfaso2689005f8f.2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848526;
 x=1771453326; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1dHxICdUAqe3+1l/xz3CcOXtCEmQSGzbJlrAruajFY=;
 b=QMgaiYBen4nPl4u7rq1Z865uqvp8feb49tiwUr3zauIyFfIN6sPZePO+CrMNzw+4i0
 p0o91C058Qv0zfroHmmvJwtWtkGC8C+NVVPSoQUMlf2/EyGyGGdSR6wY6LsR/H3vWGND
 15M1kVkap8kqzxV3QIUcbvMm/7/Ak1XH4jJpF8FKOJLYVb5zb9NRHQVv4n9jtKweervb
 qlPKB+JQYGUkL60SW3AJNlMG1eoyKhG346rbPaQ2QLxYy9vok6eEUR7yzKPkETZUy5aP
 pLStljNJfOOQZXw3VD4KocuPFgUXQtW2bSonN3lig93tdCV9kmOoWNWMsrW9yNDW8wOY
 x5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848526; x=1771453326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I1dHxICdUAqe3+1l/xz3CcOXtCEmQSGzbJlrAruajFY=;
 b=mYxopFsNscWXepWyBHN4huQOqtm0CGzuKE7wkPIshG7IJJEz6aGDeN5Xk1VffYLqAm
 QQ7oQ7CXti/Zz1MSlR5X09xuyEjzHSBVbSlyrnRAfj0oUID6JSZQgNCv3Ul+EfF+jsaa
 RNfZXhs6JcGEWug2eit0djOeTBVvKNyxGIu5VkEfzMaA3wWmrsM1yjBk+LqifIhbRTlJ
 yZdNLxu8AfU9akWvySsu6wGidXJip8LlO65sRovPyEFJafU5zkPXsoyaeD3rAVTHcTCQ
 gSTlqvTX09RLuu0iaM8jqlHGNf+Cs8b1yhL0yCJl4PPSql7VG+Ztd0bQk5cMKYmei/lw
 hIHw==
X-Gm-Message-State: AOJu0YzkzVdqYHYWca5okyIjqyH/uIxNJgHAlW3lQImMaxpK9bxBq028
 pyIDrrMM3C4kKQiEV8iWpEOLBwxeBn2Ruy05bUYIzitYP037V4+G/YGcgsz552c6exdakuEGg2+
 F2b6h
X-Gm-Gg: AZuq6aLXrG5VwVeNoCvH/m8xYW5ZSL7IPhIAyK9H5KYU8wTlyziMG7NovxgacRXFlHI
 7zJv8VlySxGsSVf2QJHuvufczS5O/MahLHTC0ohEij2+jdzrgkKIkgoacJ7yeY8UkqRkdpI1CNQ
 edZJiKMLHjn9k/JnLuxOY2DflRqkn2fRTEw3canqctde5m5G/vSrjT/FsQbVsNOiJc5oTxsTPIv
 eDEYhwMFngim2CJVFZ3tqhOIsjVMzFcOjzQXmsBPFzZXm0uh1gyJCbCMnx5smtrzkJcoehcOhh7
 0/UN1C+jGGqgHylZnMEYkZ4pP/vZmBMo9zMpbJMqIPlXiHyqizP9RZ9cRrbKe4tBPVYFmOmyh27
 AOSnejbqs81nbyNl2RjFCOpvzlLLvWRxW5CwWYtKrwyp06vKssBmdnLy+4ONheCr3/grEbeS0jv
 gow3Ft0s8l8C6myAdG5AdT2EeyhMMh5RxTq/m8nmoyFmQbmgL3z+ymWFBF+Evzrg==
X-Received: by 2002:a05:6000:2891:b0:42f:bbc6:eda2 with SMTP id
 ffacd0b85a97d-4378f15b7a3mr314894f8f.40.1770848526361; 
 Wed, 11 Feb 2026 14:22:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:22:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 14/18] net/pcap: clarify maximum received packet
Date: Wed, 11 Feb 2026 13:09:47 -0800
Message-ID: <20260211222130.338797-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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
index d4f8811572..6562f0ecc5 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -911,10 +911,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

