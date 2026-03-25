Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBE8103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:42:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60EE840E2B;
	Wed, 25 Mar 2026 03:40:47 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 1708140E68
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:44 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12732165d1eso2751673c88.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406443;
 x=1775011243; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZoTQMTbtJGagdtfNYrU9/jo5RPufaPL18GMXn0uIgE=;
 b=1HoXhcJZiCpFbUu8Zyv7a+bhTli3B+W99GR8c2npXBCMpqIpY3MZ1P3gkJfdqQ6Zjg
 9qLlDMRtFXL6r3vLgwn9A4ldELisqdc8YDJL1NrEzuFu0kYEpeI22l7nGxwljtd0szyf
 5CQbGrRoxUDdtOwWc0OnPyrIbLJFgLb57lK8KquN43M+ZruBfXJXP4wgsjj3f3fPk+gE
 W449PbfVh+E7gaEvQ8zfj/07mEg6dqxM+JG57Ul8n0DkvrDanwm7ztH1YGBIgbY+B82J
 /JZ2i3Nn8A0sa1JWqKsHn6Yt1dMT1Te/2sWP+pKgdkUwC0ysNUFXKhupUX7FqrUJ3k1d
 52QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406443; x=1775011243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jZoTQMTbtJGagdtfNYrU9/jo5RPufaPL18GMXn0uIgE=;
 b=NVeP2YV4yQJhMZxQybWsSeYoClrgVuU41f2KoBflyOQ4OG1/Ew0R/3qfDDVX+sE2h/
 +Y28huswl/f6c4Sp030AZoOa8jHb6AoBjpXcwA9uPQmZ7vApNJZMSzEJtNIirqo9HJSu
 7jJ/wAgYMBKWoo70qTh/ML1wC6NiWLEieA8GzonYzfugRauzEXGxY5/R7yVlq2HuCrq8
 3MLW9601DOl7m90zuqmj4cWWwkU4OR27cEbs08g0/mdpSdevLFi1aWM9iMjPnasKl5FZ
 m6VKaqaum+G2m/8m7lo/ClGJwUitXwZV21jNoYuPc3dNa75ZM7KZe07NJu91OCT5O11+
 oIMg==
X-Gm-Message-State: AOJu0Ywo1XC3NoJam7hw6qkXWZA7QMiyNpf316yN6iao+5wAy4QfIZEA
 ciwDu/6kTx1JHYP7sqbsrcbpBmFNenrQnOUQmDwLlYTVeTqnvraTvnZmU9NwAzZC7BgRiSZS2cs
 P+Swo
X-Gm-Gg: ATEYQzyHwLU47t+VWmCLVVYcz45gX1xBqXRNWrGGU9WFSInvQo/H+K7VjsrlDJIczTP
 FtSdk98EEyYHZvr2fV86wfzqOyHf39hg/h5LR8F0m06Npkm/n57SHCVfPELHhTedFHlh474t+dD
 S3zUSqEpi/Rf50O9ygZ2epeu5fo4+Gia/mMb9sUgFJP2TtqNA6J71pBKEupqDkN6qiFvLws8bl+
 q2zRZ2GfJdMYz1oAdTrrObgc8iYuT/wEB0MDmCav034WKd+jhRLxBGTYhOFizjx316PEPirDmIp
 fEnV61KB2y8sTo490C34QjkAHVM8lX8fAzJ8ERRxAdgraHmcKA5YeH65aMmiZRp9Ltcayf34cJn
 Fh0rhRjDdx2f4QbSTZU/J95CQpKiLs45rY2JJH9fu1GxPKWgIIoYWnQfQDhxAyETYxs80l491Db
 uiJXq3DNccmpgZfQfZe4QzElCd9DBNZl3RNfQoQ2cqOBE=
X-Received: by 2002:a05:7022:2509:b0:119:e56b:98be with SMTP id
 a92af1059eb24-12a96f0ecedmr793538c88.37.1774406443020; 
 Tue, 24 Mar 2026 19:40:43 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v21 19/25] net/pcap: clarify maximum received packet
Date: Tue, 24 Mar 2026 19:37:50 -0700
Message-ID: <20260325024018.1275209-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
index 0ac8b90ce3..0da3062d2f 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -890,10 +890,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

