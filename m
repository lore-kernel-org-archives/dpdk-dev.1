Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B2FD4F05
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFEEA410E3;
	Tue, 10 Mar 2026 17:14:25 +0100 (CET)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mails.dpdk.org (Postfix) with ESMTP id 2C48C40E7C
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:22 +0100 (CET)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-467161c4a1cso696983b6e.3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159260;
 x=1773764060; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvG73nzdEYqzyzq5+pgq1ZEEdPRoJ/um9UEqKgdYzss=;
 b=TjVUshmO/zKy34lS2aletAgtpRpiTsV4hDvYI/Au/JzHqyPzEbH7tPvHPyRKk+umLI
 CLzEsHb+oZ0aHKJW8PKq0/SCvBYy1Cq+N0Jf1YljAEBUD0Yac/PyGDtqTS5lcbmuWMWR
 A0G/gYawjIStVYGw2IXu06A2AlKtTWL1ATXbptostydsZUSZz8hy/mKWNeopOFyqYixD
 g5TLpKUPlJaRvJTUB4vdfX3Q3yXlQ/NdaNmiJZrszzdswMEm1rLswCa8hrfYjWhz4aPO
 S5juc0txRty5w1e/XxC7H4DdIGw64kNyX5AHgr2YMjD3QBOuxfy8sl0eoyyeF3rNcTC/
 RY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159260; x=1773764060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FvG73nzdEYqzyzq5+pgq1ZEEdPRoJ/um9UEqKgdYzss=;
 b=LRpF54iwnGJpvPYf/Mi3dpvtfHNzIK5CyhHOqQkxG4N4CR3pJqory6u/i6aMY0Z1Pt
 tEWAqVKUqiRc1yLVhUXmSUdC4zpecGiGviys7zqfvDfeZsi+oZdsbLQAQPHwaQxuNTTw
 FMMtdqrH9uXWHt3DEZS+hrRWDw1fJgo9QFtc52mfIkbshyjzFtX3ND5Bv1CZhkSKQNmY
 lZaFdhIvwnwEycYBseGK9MhadDT6Xe6u1cVOdlJndGOHBUyLh110YgCJDdmcC50ETmQJ
 YbGKTC7+5adqIhW0lhsk615pZUSeSoBXv5Q2n2E8Eq5G5sb6x1Qki0eLNDkELf9m/06h
 f0DA==
X-Gm-Message-State: AOJu0YwFSBXx4OirGyDYOgpLCMNoM6J0JlbjyOo204c2JqBJvEtAX/UO
 EYilkcAgoI1oSb+voRbtFpAAMVFsUWw9ovLIwtsUBMgUNkWUzxl7RkleJ7ZYL0lv3ygo8VyeAp7
 TffztOI4=
X-Gm-Gg: ATEYQzx3jNrLd1zZqXQZURH9Aczc/jytLmZOodcCAxEkNNoenrcb3EWPQE48hasKTcp
 4CfWDqAR62ueelAaJpA+AKwmuYhR+SXbIoN7cEr8GrMmkiyfAFDX6Q2OhAJohby+7ICf3l2IEI3
 gDcAQrXf29r/D/LEqgGWA6A96/puBbwEvx0lR6IrgVGA+0dG3xFy8kBZzsWXAu1vqmWHzicgDSC
 Qy6dbuJ3LKbuPdNgKHCmbTbZ8Pw31Ov++z4OKIrEVr0Pkyqehbq0kHkO9sP5/axnpDHbjEQRZJC
 kOrCm1Xo76R5aBPx1uOHnWGX66fu3a3TI+d/DEGgTN+oCParkth13G4yCg8PEE2KGzAHTVtRfmD
 t3zno5KaXTyYyY3R3h+r7Rg9q+AQhYmLDqOxCLXHenvTWyRzwjB0aiUlDKMqte7a+O4bvX6M6x7
 kDRi9Nin3D0g/yDQxVxHz6lrGoWptz3ICO
X-Received: by 2002:a05:6808:6a96:b0:467:1cf5:7684 with SMTP id
 5614622812f47-4671cf88618mr1962045b6e.6.1773159260323; 
 Tue, 10 Mar 2026 09:14:20 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 18/25] net/pcap: clarify maximum received packet
Date: Tue, 10 Mar 2026 09:09:56 -0700
Message-ID: <20260310161356.194553-19-stephen@networkplumber.org>
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

The driver has constant RTE_ETH_PCAP_SNAPSHOT_LEN with is set
to the largest value the pcap library will return, so that should
also be the largest receive buffer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 20e4b8e6aa..2ffbce2448 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -884,10 +884,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

