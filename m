Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F8CEEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:05:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 212D840A80;
	Fri, 13 Feb 2026 18:04:06 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 21D2240A73
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:04:05 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso13734885e9.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002245;
 x=1771607045; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KV6JXgcTIjhVAZNIUCHbxL5X+wjOwT4bz34BOWDnDvk=;
 b=g0VULsR2+OLte87jnJm8qd8wuYxMA1CRQi2PE3cGqf6KNnA6fo+alAplSmDVmnvnDz
 q8St2VLO5X1Euc9sEicRa6/6jKP4uLG4ytESOQyao93UxRKql3zudW90j587VH98FJ0Y
 Nx+iJmN4RHsuopGmteSuDuQc4qKIf6Fvc4jqqibpmW8r3H0fN4BLHwekQtuhzr8l3KjF
 mAZLuKjuAyEU2xTZxb7mCqy1vBmdHyfOENomZYGqF/VRSOb5mmFuEhHwA2f9bXIOlrnN
 IiNbD86ZeJgKaa1OFOXbN4JEvCsTegpJ0WhNeuJwpJpZQxOYHDsbVonfvp7XKCfgU+wT
 Fq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002245; x=1771607045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KV6JXgcTIjhVAZNIUCHbxL5X+wjOwT4bz34BOWDnDvk=;
 b=k9CM67cSa2mpEc0I59SF1IeW7Vo3YuWn6nb4wQmAfb9kmeHOpCzu3FLE3nIHZSLw2U
 pXatnyhnyXIv9ZTFnIwG+5mGxFxAJ/X4RdG5T7XnnVYpgKpL6+MAT9DM0AmEMEHurUlB
 4bC273sJdMHIU5kNJvOYDafkSVFDbV2sN8PBLw15XDWzRiK3nyDBgLGs2K36byRdaAMo
 oLTFsfPJC9utdUfPdjUOBPF8QGkItk8u2MGt9rUS8H1YeG8KZAICMm/qgaqGk6hLqB9g
 ue4BmzA9KWVWO/qq3qhNZejUGtzbZBvESrNLQnYHk35QpLtI6mOXDah+LlWDOIlbomUv
 Y1mA==
X-Gm-Message-State: AOJu0YyfF9xjAEN7t5tFxZ7yR+/oVp9XLL7mR2I5nQJqgIZBbC8BZFt6
 lY04NLdNyvQRoC2HJjY26pyCH8VCpvSm07Tj+DVHZYijixMvBUldL2Ern4F4INSGbvVxnOjbV+P
 3ATR2
X-Gm-Gg: AZuq6aJ/BQqqxIahgrTcTJGZtYCZ9ov8Rk5k9cP7rTr5F8uJbEoaB7F6fZ27hxJ1rzY
 eUvzJJ3s6DLmLiXHErPeYFv38QNZME7zJXn/zOMIo2NeKbDDRVHgH0fXs8Eyg73wH6xLs/dp6UL
 wX4Hr8fz72wf7err6E7rt37ncmiu/h7bpSr9ULd5zam7nhDt+s0t49nbHRACKFJDl1DBjH9IzmA
 edZKaxed6B008LwmUFXTnp7oC6MYbDgml+zEkGa+iMQB6v3m3nxxg09c7F2zs5MITs1/OJcrctw
 L69d2ZsOSBCHaNenw+vG0i/+ZyBOC13sgSOXt0tunm9dLlH2zNcXqTNNPTcg723fWwavLY2l72V
 c+xuLXp2/XoIoXWAYvfBPYrf3e61ka/xIc0Wmxwqnkn8PaHaUW2bDv6yuesc+g5qzFThqCwxMEo
 FEuuDyUSxndSP6h3BtKeSqs/jgzjmGJp9y9YMRgpp/YVHF1D/9VP7mWn04ze/XGQ==
X-Received: by 2002:a05:600c:8b28:b0:483:6d42:25c6 with SMTP id
 5b1f17b1804b1-48373a63174mr41549015e9.23.1771002244617; 
 Fri, 13 Feb 2026 09:04:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:04:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 14/18] net/pcap: clarify maximum received packet
Date: Fri, 13 Feb 2026 09:01:37 -0800
Message-ID: <20260213170333.40089-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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
index eeac0cffc8..f2f05689ca 100644
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

