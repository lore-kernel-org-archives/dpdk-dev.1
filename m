Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F7E7FDE0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F24DE4066C;
	Tue,  3 Feb 2026 00:13:25 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 0133640B94
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:23 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4359a302794so3416167f8f.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770074003;
 x=1770678803; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwBOIV0c9mNsaCe99oVOF9rQaNvlFBqHPAsSOhkktWI=;
 b=KM+30wYPFFrHHpBPtiuHd/NCdQSD4+aFuTLJ1oiWLVz8xYiQHeR20C4sxxWAnekrrY
 PCdZpsMaLjbfTWdIjkHTB4tXzaUOUUidGjO5SpA7Bs2P9RxIMaPNzQ/xjHjv5PqMgwxY
 7Ep/4GIDc9cfg4H2ff9i4AzzZQIi28zHDRvdtmWlEd2MBOqQoYchedtVJunV4iDBPO8A
 32MzdlfyghM3gVg4j6msMRQ9hSMQQJN2LaHcD6pwpKHrCXRI/j5F/oULxr0GTtnGPX1J
 K0Up43jEFQijQ3OMCMOmykIdQqt8vufBrYUbPtZcQqsFuB0J5l4ItOPw8XtyInchGpDQ
 Lv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770074003; x=1770678803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wwBOIV0c9mNsaCe99oVOF9rQaNvlFBqHPAsSOhkktWI=;
 b=vDW4llTB37rGp/ZTKb5xNhu+XbzcCjZ+m49rdPMFCEWKFvwzn+aUc4NJU1frIiFYO0
 gm4uPWrAXBpwzWqHbLheps96WB+yW+ljvjHyE0Mu/t+D2tR4CrQR1UzfYeAE0Fi1eDFm
 6R2GxgIrfylI+rttJHjEqB4SCpp8AhPUIei9VHRbK8bQ1SjA/jQakBrkPLmvVdqVpv1d
 CFAVFm/S55BF5vEVRNVeXFdF2asQvBnv1+lB++Iykioa8hOnvSYOHOcitt8j0cc4bVsG
 kiZ/I4GGeteGZyzQKstnW9gZBSzItwwCJ3SzMW1Chnt0qL59JGzXVFJlg5g9M3u3wahK
 xKUQ==
X-Gm-Message-State: AOJu0YxvBzVdPXRG0Ysfnhc2l4uJHoL55gx+nJVrGe5n06kahakK8MG1
 eFycmCF8wYaImSYVB9jZGSYBhaRNDCEac/P+uYTyh2zdwQYPmLatMT3rZ44blPgZWeOurTJ+bzE
 i1k24
X-Gm-Gg: AZuq6aLVkLTiKKlhQh0Cww04uDsTadUkP6KiIkzaX4Pw4hMREsO+5PGwCZCZAbgsi/A
 GxRLF3eCz1OAfJR7sxw2wYA3SCVvbf7BtyfDq4oF5fniVdkxiEX4Yn10C3nX6MBY9DzVzfoNV8U
 g39hqi9Vwf2r2eVt0VyE/7WDRbMp4snYk4rZNIOplgLdIOTTfnKu5TEbwgLgWmtJUunLUtAmoXZ
 7KenK3ByiNaFydCDDGqXbYA+GczBgU9KZDHxdW48lUDTD4dVe6EtQExlx6bBNO7Z8ALODYq9JkU
 ewz3EA/VJKhO0UZuyRHZRxvlcs78sVBqap7n/nclz9EQ5rSnUK74CsqBvUQKyakeJpKvg950oM1
 u3PJVHGiMsWtlHDfkWg/G+MEul1f3tKvklAkeySbkIvGz1VYsf3C1m9eoXb5EgI/3RrIPJQIoEN
 1HIUD33uhcRx+bG6n+r6Br9YDK7Eo+nvQrQmGrDE5nbu5rMXi0FA==
X-Received: by 2002:a05:6000:1ac8:b0:432:c37c:d83a with SMTP id
 ffacd0b85a97d-435f3a86321mr20234989f8f.15.1770074003606; 
 Mon, 02 Feb 2026 15:13:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 17/19] net/pcap: clarify maximum received packet
Date: Mon,  2 Feb 2026 15:09:20 -0800
Message-ID: <20260202231245.216433-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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
index f3220cea92..35d4f28d50 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -845,10 +845,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

