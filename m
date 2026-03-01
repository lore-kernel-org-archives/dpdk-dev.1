Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7030FD0048
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:09:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CB9C40B9B;
	Sun,  1 Mar 2026 03:07:59 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id BB2F640E18
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:54 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8cb7edbcde6so439661185a.3
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330874;
 x=1772935674; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yW9uIzze6gFNBtoIhy4jYXvMC6fgcFouC1arEJiUQ+8=;
 b=Qszu1gDrx7ShqdULYz6wAzTsgDzaIMb26LBKCkUFxK/xWxYh3TVCzI2RQNU0vquobA
 W1xjuJaLlbQHyfATlOUeyvBOjTplnKJxr0sdyJ2H7YYyQWSMPmwvbJS+aNMcDECYpymv
 h5+Th+zB+4jDG+USE7c5/8JFuC1QQCXdkAFtWznTUbUGnOmCKUHCYAQ9UHN9tjtvVR8h
 GQaP8N815Egaq3t5pe9glZXHMNSJVzBqKM4ecQrJ4TMBDbu9mFSZLk+xmYgPC9tAgnvr
 sPr0N1O1Ypu/XTk5abB0S7hrjMtWtZIQTWUWD4tKMo5SsokjDngBZ06CxKRS6gSBxIse
 r0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330874; x=1772935674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yW9uIzze6gFNBtoIhy4jYXvMC6fgcFouC1arEJiUQ+8=;
 b=wtg29oFYykd82weNG9OWsDo4DqaDuct6m+oKHfZtz9mkJmxnSfyi13bvVkqO44u3+T
 oomRqID32K37V2Wcp/zleCEJ/kln+YgceQ9+P9sSSXA+cQW05/GFpmr68qC9tMz8LRyX
 pmU5jRLiPVQOTCl4DJtfbxVNTDP+MJweCzAi1jsnguSk2Z09+HdDprI8asrgxFcszoZo
 Oqc0AcasZqqkdXginYE1foXxq1oNMSXcout+tTdKAX5+alW9LWIL0TExbYAsuFY3KGjr
 KteYdZEHz86nK89CagDXG6e51jiktE7vGUAJcpgUCZgPj4t2tmyQEhgiXFeE0szHATIc
 jEug==
X-Gm-Message-State: AOJu0Yz4FLcdjnlYeWu1QClBxCqMBYyKGVezDlb2/42Ux0AOrP0oBEAd
 xDsQQaF33aOu0HC7jeE1aVfp9PXDJev130mhelTk4JoXkxYjjB5P3Sn4JVMXREs/MkmtMdqq8Fi
 GFDZH
X-Gm-Gg: ATEYQzwq+UG/3UvAF+2cAAWZwVdWARKvdM/sZjiKvqYfXAwGGvQ6JOog0s6WEYdocpa
 ynoBvcQ/zOaigLA9BZOSjzZM+x79MWrdZm49zlZ06bLSjIrRU/j+ocw1xvmMdRU0UYAmZ7IHyPo
 C6aCUPypgAWOQoZwx1XoCLHVQ81bzNJGS88UZX3h3TKySMRhNOBbXUycNqrbHiv+EZwxdzu5O6H
 NehX/PBnOxWjw/Yes4v0apxfPM7sXHnextqq0YGQlqrfxV4IG8AHR3tN2CfGp54OmN9Y2t1eE8I
 LSgeQW59nKa828mImgT7/ToI920EkxVGTL2wvQ7Wz+fY4m+1T1utiXiUgsSjW3dT+dd2c8o1+Po
 uWfp2JLl1m/OTz0epNIFrXhqP5U4Wnfxcy//Pvr/OQv4J+e8t4kGkhA48EDRtFNWE2fndcUoOZO
 Lffi17kzTfG4aUFX+NVWLXO2RwqG33xjNH5ZD4GcADPysk/D0YiE11p2PvKUNrHQ==
X-Received: by 2002:a05:620a:2591:b0:8c5:3415:aceb with SMTP id
 af79cd13be357-8cbc8e8095emr1050094185a.32.1772330874104; 
 Sat, 28 Feb 2026 18:07:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 18/23] net/pcap: clarify maximum received packet
Date: Sat, 28 Feb 2026 18:05:51 -0800
Message-ID: <20260301020726.852401-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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
index 14edafb581..f2c13530ee 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -891,10 +891,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

