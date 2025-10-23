Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F92ACCD1BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 08:30:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68A4B402E3;
	Thu, 23 Oct 2025 10:30:30 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id B97DE400D6
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:30:29 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7a27ab05a2dso191315b3a.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761208228; x=1761813028; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wa44899RI35+6NQEgMJ6INV82CPtiE+Ahs6THM8cw0Q=;
 b=CYQqrxsHZ1WHFfNKbjJS+rGCrpZBDPWY2X8/FIlEJKUD0XICU07jVw3BnYb3Xe0Vtx
 teiar82lILH/lRVn/3SPuxUTHRM7I6c1PWrsfcXRwMmPNoTfRv0CovZAhoE/D6eLgSZb
 e20uqbPltkfmMA2lZHXGCLJzp1vgqaeeL4iuOx9SdUwxmvYe6uFrtOQ7ABIKSplkFtix
 ZB2tYlHhZ3dTuJ6n5ZHjJjgI3QKVcI14LPxKaK3Gq89LnkLafxqgkR5QA+tGJpBYLHIV
 VUbrzS+5HuyTKGroDOhOGqAPpWUZlYxY1UO/BU2USZZUg+IHshQ2jCcd0mTSvpwtuvTa
 2u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761208228; x=1761813028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wa44899RI35+6NQEgMJ6INV82CPtiE+Ahs6THM8cw0Q=;
 b=ZSpDShWoY+pKBFt6ONEleTrX5BBOceTNjTlDefce4B+qtmFNZPguYO7US6blW6DK7j
 ABh3NNHm4bSD7/8EiMC40+40AepuAEn5sqgCNqSfjNaAyyEhdNSzjRj4CbOjP/ubUkIu
 VYPOz5XbEHlHxad1Hs+wZD/B6cy95MBGBQW7FM+YgwuwKbK9NUqVoMoeXdNYb7Kzik0X
 pchg++TvQo4h0yemuqLH+E9TpOmO04EDZiayZuovHm1ZKxqNS+S4Y91T8Qv+9BN7DxgM
 tPjh7TQrAEILuqpX0XcW3tiLyV3OK89nZMcDpev46lwyNfqw/xbz6p0S2crrZdPZfeMS
 Fg3Q==
X-Gm-Message-State: AOJu0YzK3GBND+V9KY+9cQx2qvMEcOFZl7+emvtEM0fk5eO25JYMW75v
 LBb0Q/Vqf6jc7nOShSz72QhsxriCbrnGwnpVdYwuXoZEC0W6g0OtO9m1nEuCZQ==
X-Gm-Gg: ASbGncuXQUlCysuHaOfPGyvr+pByV8rE7UDAKpdxHY9PhaE4dujffGvotpsbkl8TWba
 KwwfTn8k84AxcM0ltss7LJaNqAVEWPk5oAnQrl5+j3dlowFSJVUKiiR3O7FKY2/nirCWYizwqSz
 gHa6NQl1gFRaRI/bMcfw2oK5MKkkhTun0g9W89W2bA73GmJllx4Y39IT0z+t80TbpjunHfA9qqO
 RIOAsQstEtL29k2h2bf7R2ywMsK612LnVVCTsyvDSn6foXPFlS0lNQ1hh5pap2O40wMzzgrEhXJ
 /FwcXe2ew/koqmbF9m7qvJO27l0LkQW2zSgdG6eG8c417RGgmr8PZ7SiW56HH/VJLpKfpDHAEZ3
 nt6Hqzyuy0RdWgxkMt/RNo2IKk73W7MTvWxzjh9SyUcaFdDDsTn4D+49OID/jFa+nG4qs3wLHEs
 VhdhGOyN4Yb+cDxDNWej10zgsPsLcJ2iQ4qiDfUkRpPM3bpjbA/piMUpcEMoV71tvJF3AK
X-Google-Smtp-Source: AGHT+IGeEgOKAgHCgH9Cf/7EStU0tiHj8ZHNFk4fWJNOA6vt3Q8F40OpJZmea/c8lIg4dmnm5cZk7Q==
X-Received: by 2002:a17:90b:3d8a:b0:32b:6820:6509 with SMTP id
 98e67ed59e1d1-33bcf8748b5mr30202786a91.9.1761208228215; 
 Thu, 23 Oct 2025 01:30:28 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com
 ([2402:e280:2162:53:690b:e114:2f06:4eff])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33e223d11c8sm5022097a91.4.2025.10.23.01.30.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 01:30:27 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v3] net/vmxnet3: disable RSS for single queue configuration
 for ESX8.0+ versions
Date: Thu, 23 Oct 2025 14:00:19 +0530
Message-Id: <20251023083019.18792-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
References: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
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

It fixes the issue of v4 RSS configuration failure in
vmxnet3_v4_rss_configure() while writing to BAR register. It's very
specific to single queue configuration.

https://mails.dpdk.org/archives/users/2025-April/008236.html

Bugzilla ID:1789
Fixes: 52ec00fd1474e8 ("net/vmxnet3: fix RSS setting on v4")
Cc: stable@dpdk.org

v2:
 - Fixed typo in commit message
v3:
 - Checking if RSS is already enabled

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index f4cdb1bb31..a0306af86c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -534,6 +534,13 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* Disabling RSS for single queue pair */
+	if (dev->data->nb_rx_queues == 1 &&
+	    dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
+		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+		PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
+	}
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
-- 
2.39.5 (Apple Git-154)

