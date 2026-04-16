Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A693F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:53:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE83440E26;
	Thu, 16 Apr 2026 20:52:10 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id C624840DDE
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:06 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12c565476d7so260763c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365526;
 x=1776970326; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrPzXJjuimhLGi0d5bpoI0iqI8celoLDRbgKUh0q6iU=;
 b=wCSlbyyhFwbtSKZj7N2fQ1/N2rjzcnoRWayRcHugCkcnXQ1kcnuxqgPrOtIL88QZa4
 +J1mZpPp2s3BgYQGlz4E0ssoS6jMRZ/onOETCPwLpu+Y7E6kSFwQHgvPyHobUhdUJDvT
 W1oSWnwTx2Yin2hjGLvU5nC5JRDka6az8R3VD+PrhG66rHfuYp1dr0OD6P1i0Gr60YpB
 5LHmTz4VnQkjvV1uJdxuwMhk4py+ZQxmClHrHHI42N4Ifrv7R8DlomEI1gfiCIbdE71h
 pRhLCW3QoZCASRnf0aWAMBFVwZdgJ8ftSD16nn0ZYgJtNSt5jFpZVf8k8HFa918Z5uut
 IPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365526; x=1776970326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CrPzXJjuimhLGi0d5bpoI0iqI8celoLDRbgKUh0q6iU=;
 b=P9JfGwCSE+dCR/1bsQ/4dQbgJSR7v0AckOxoGa6XmR6hcj4ILmiFkCF1ODHpYaMItV
 +2Dq8Ew5a2x7sI42B3qjm0jc5NhK7/Rj8Ht7vn+iENKvBGE1sOonaZn6xEunLWCb1zdu
 lsL6EVH0l1Ibv/c8PrceUGNi5wmarKM46HroMQuS7p1m4YDz5DYoQdSEqlBnPl2pXQTN
 +HnD7Ac50OBiaJWxWj3F61hRO3I+1vGdokeCOi1b4M6U5iMIdQx2XMF+XgqnrpywWGZF
 MA0cIQyH2beCXg3S0IB+c2J7S9TNeUayOpluRYbwJJRgH8am7TVXP1fiHxj4cW7JNq9x
 26KQ==
X-Gm-Message-State: AOJu0YwKPFXOrGpCocze7ciqRGLEKlKi8q5r7ZFq+7owMfNqIaimYzur
 9mFsYnNIqyEt+H+di1cjWNhW0oqAREUP3EsXUXYn8gyH3vM5ie90CdqWxXj5Acr3nNyn4mhqYc1
 Hx4Eq
X-Gm-Gg: AeBDievGGBa2t/BL7oQgJJdgXTGq1DCjtjMa1HmKUzW9IIMic+GZ29Xl6nT5Lgl6icf
 Pa8dmUO72ydq9P2fLceUECEszLyNtI/mZ7wCOfL1fnrTBdZaSfwbb69bXSFw7OD2a9zToW03YiY
 ooL6MOzdWm4ildn2OnL/+O4CqNXzzEmNrqb3EEbuTO+X1y24TLPF/vBtHfsv3ooqYS7ybfnuKKb
 neLP2JWrUckThcdWdYf0wzs+saWUZ/egIR5IB48giIq/ts4GxsnWWY+ug8/RCLXWQm+qIwZHGCV
 zvIoFS9FPpeSwgUxcxU4x+x3bd1dUYWj1Lv740722v0IyJx1gc72FivKqIRKsb3YmW2nsbc54Zx
 wB76meiUW3ePsw5oOD+RUd0UKTWUdFjoauJqajy43mh9kG48O459dFwUn+j4QpBl+g2q+O8gFI0
 OPFRgqj+mkIN7jkno7pK1iyoUZBm0kkriT9mxqxRoAY3U=
X-Received: by 2002:a05:7300:5728:b0:2cc:600d:2ffa with SMTP id
 5a478bee46e88-2e2e4f22233mr266130eec.16.1776365525887; 
 Thu, 16 Apr 2026 11:52:05 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:52:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v24 18/24] net/pcap: clarify maximum received packet
Date: Thu, 16 Apr 2026 11:48:35 -0700
Message-ID: <20260416185144.1359260-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

