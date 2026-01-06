Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614CCE9D7D
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:48:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00EFE40DD6;
	Tue,  6 Jan 2026 17:48:26 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 8D52240BA6
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:48:24 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso632506f8f.2
 for <dev@dpdk.org>; Tue, 06 Jan 2026 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767718104;
 x=1768322904; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GX9ywGXrBE5Xu2WP7ZGe6hZXCA15xSvUHOVqQvQ77Ls=;
 b=NDpYqUVv85Qn5enm64kxXo9uV0sf/hveyc4BN5GQxihbSncHIS1TmiHBcX6hnMDEQW
 YXhOYIGsIYR88EL11Y/Mx2KkL74xQRAAZv77HF8KZNmE2FvjQg4ojZqk+tx9LclHzuMP
 qgjFUzZrfMQbU6+bpYVghNXs/+itHdPqE0GLFp0MWYKbC600MLy2oslS6blG/Vo6/wXO
 nYs8YBPV1FY/WZW4TygiVAAOBVIK/OiOvLkMk4rFSMVuGXLVDoM4ej7O9IHsB9FdL3pM
 +3zB9nARpuo/79GMVKb85ijuxWtw4zHhWBGAjDH8X3cbgMYRlofCJU9tXbBvtj/6sqk3
 S4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767718104; x=1768322904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GX9ywGXrBE5Xu2WP7ZGe6hZXCA15xSvUHOVqQvQ77Ls=;
 b=SCUIyjVBZDCNAVZgA3LulQVOMX0ci3b9hlfCfLhEWcTQiRI3lIozjUX5mU1zCXOpa0
 mCcqli17zgVQ6Ly0+RarA4mhL4jqDj0XhNIMWh7E0vobd3Zbp9nYSQ7Q11gR6NlHe6IP
 qs790mGEC1u2pyLsVpETzzGIrXAo8yBZHvX15QOvVJJ9tArBC4R8qN6SAENvQqg5q61B
 hMtewlN6mSNDsrONaGJ/qBl1YkYpsEce/M7myoxqBNzvBzaeoNMq/W6xI08q0AEV3UfQ
 57vdknaVVZkPmTJEAB2n+WMVNcxFhXj0xSB555kZKeZVTqGBpRlkfXRAcB8M+NmOdEfc
 P7XQ==
X-Gm-Message-State: AOJu0YxVRaJfslztPO0m4Sws3L+7d/lOCxiAPVGER0c2za2WgpXdI1Ki
 SOH/36nQLaCfBknmXvRPy7+KJrd/P2qR0uXU2EU2QP6IXWzCE3MXVrk4MWOh8rQWUgF5H1/VmhD
 bk/hahhs=
X-Gm-Gg: AY/fxX7Jhb1pBF6PDU5o+uLWWqmkkNMouDd6H+UjfvezEyh9Dm8YvNQ9waZMDga+c8b
 u3obUhZkQaXGz7rt9O9ljHbs5Qx4vN23yPvN9QrL/CqrGZLMqKxpTHEpWDAwZCYvjabcPPyCghw
 h5MZ9bm4pK3OjdrzUxDIovKY3Pi2B+Xry1svEFl7AoJ20FQu27U50aP3t2RPH5tPF6Y86V274NW
 2tpunkjMIQdnolpToylMvBsVXAo6Km9MIAXzB7SX+KFN6T/ymhk96074P0ak32S+W2yr8tJqy5Q
 InYEFQ53KVVnDXOZjdv9snqZI4s4RDqAdJt4OFFgb+zh/BlYUSj/95IiMsKpveLd2JUgItlF3o0
 88jyEmIK/XKzZIQybfN3YfWrixX/GJPu6OUWeXK/WkpHDJui8X/0rlIR5vjiWRqGkP0mW0Ds4yJ
 e/47R6avfFs6qQvfXvO41W8G0fjcOZjpm3SlRc4gssxdzEDW4cpQ==
X-Google-Smtp-Source: AGHT+IFbNEOew5/9oJ6ycohQZAtMuFdi4XLf8wQizP64Ba6so59XBwmMVSGRRfwP1ikHwBjHFzziBg==
X-Received: by 2002:a05:6000:26c3:b0:42f:b707:56e6 with SMTP id
 ffacd0b85a97d-432bca45aabmr4054630f8f.34.1767718104118; 
 Tue, 06 Jan 2026 08:48:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm5197001f8f.19.2026.01.06.08.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 08:48:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v2 2/2] net/null: revise info_get
Date: Tue,  6 Jan 2026 08:47:15 -0800
Message-ID: <20260106164815.158430-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106164815.158430-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260106164815.158430-1-stephen@networkplumber.org>
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

The dev_info_get callback does not need to check for invalid arguments
since that is already done at ethdev layer.

Make the min/max MTU values reflect the most an Ethernet type
PMD would allow.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_null.c        | 13 +++++++++++--
 drivers/net/null/rte_eth_null.c | 11 ++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/app/test/test_pmd_null.c b/app/test/test_pmd_null.c
index c6a8bba701..ee62d7ecb5 100644
--- a/app/test/test_pmd_null.c
+++ b/app/test/test_pmd_null.c
@@ -430,6 +430,10 @@ static int
 test_null_dev_info(void)
 {
 	struct rte_eth_dev_info dev_info;
+	const uint16_t jumbo_mtu = RTE_ETHER_MAX_JUMBO_FRAME_LEN
+		- RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
+	const uint16_t min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN -
+		RTE_ETHER_CRC_LEN;
 	int ret;
 
 	ret = rte_eth_dev_info_get(port_id, &dev_info);
@@ -438,8 +442,13 @@ test_null_dev_info(void)
 	/* Verify expected device info values */
 	TEST_ASSERT(dev_info.max_mac_addrs == 1,
 		    "Expected max_mac_addrs=1, got %u", dev_info.max_mac_addrs);
-	TEST_ASSERT(dev_info.max_rx_pktlen == UINT32_MAX,
-		    "Unexpected max_rx_pktlen");
+
+	TEST_ASSERT(dev_info.max_mtu == jumbo_mtu,
+		    "Unexpected max_mtu: %u", dev_info.max_mtu);
+	TEST_ASSERT(dev_info.min_mtu == min_mtu,
+		    "Unexpected min_mtu: %u", dev_info.max_mtu);
+	TEST_ASSERT(dev_info.max_rx_pktlen == RTE_ETHER_MAX_JUMBO_FRAME_LEN,
+		    "Unexpected max_rx_pktlen: %u", dev_info.max_rx_pktlen);
 	TEST_ASSERT(dev_info.min_rx_bufsize == 0,
 		    "Expected min_rx_bufsize=0, got %u", dev_info.min_rx_bufsize);
 
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..2928f0d2d5 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -298,19 +298,16 @@ static int
 eth_dev_info(struct rte_eth_dev *dev,
 		struct rte_eth_dev_info *dev_info)
 {
-	struct pmd_internals *internals;
-
-	if ((dev == NULL) || (dev_info == NULL))
-		return -EINVAL;
+	struct pmd_internals *internals = dev->data->dev_private;
 
-	internals = dev->data->dev_private;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t)-1;
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
-	dev_info->min_rx_bufsize = 0;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 
+	dev_info->max_rx_pktlen = RTE_ETHER_MAX_JUMBO_FRAME_LEN;
+	dev_info->max_mtu = RTE_ETHER_MAX_JUMBO_FRAME_LEN
+		- RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
 	dev_info->reta_size = internals->reta_size;
 	dev_info->flow_type_rss_offloads = internals->flow_type_rss_offloads;
 	dev_info->hash_key_size = sizeof(internals->rss_key);
-- 
2.51.0

