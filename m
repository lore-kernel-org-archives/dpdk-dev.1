Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F7CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62C484064E;
	Thu, 28 May 2026 14:48:09 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 2C6474064E
 for <dev@dpdk.org>; Thu, 28 May 2026 14:48:08 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id BF646EC00EB;
 Thu, 28 May 2026 08:48:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 28 May 2026 08:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972487; x=
 1780058887; bh=vz/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=q
 GUYMmnpUNS7awrE0oq9KRHHuqfuFR9pYNbwTykruZccFW2yUXBCRuqZmXA4zsAFI
 6DNoP2+8NrG2jlZskLwbAGCJZCf8ubrf8EeV7NqftYvqygug1KOf/+72T6R8UvNU
 555w8HiLCiY9sS7iJMnYbvUo38+imEThHPFasJGjB9/TlRdLYiMDfADTGIrvkjsU
 smpxnJeTCQ8eonH7wAEAJbeOVW2cd30tAnV50leeXFy1gfDxVYty306HPMTHYClu
 upugxuxemj6M2Z2PJFSuXTb7qWgpTqmzlbJPtaBCXMus7HjemqYaxZKtQFgVdVRL
 Ha9Cm1y7Pk2Lki8qwN44A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972487; x=1780058887; bh=v
 z/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=XjyjZX4dsjr/9QN2y
 onLew4O0xZL9vnBkUkcl2uRT0i4QPKFNtUSCLorzz8rknUOXGbcKayO5GojazHgX
 Cysei7W2bgwlz16VQGwMu10kZ9injBT0+GgBZpMbQQEFN39PfRVetfEVlWNpNiGL
 v5o1NbVlSkk6+bzkNOHVVsofTXAuw53rRNJInp9c1ySfgVMnvrBmaMlRzsBmw5ug
 aSYqUjhBKCNdmMPGQh8IBGqWukjPOVBJrSYSRpRt/AnVtKvTb2WL/g9eH6WKPgNj
 f+MUVdc8J6/eZkuNKgLqNpMb2NItZS4brHKUyVdJ0jo1jmMIkGgfhvloSlSm3V25
 Kmifg==
X-ME-Sender: <xms:hzkYasXQMduWoiKpjgxFYkDi92oIFlKEhY4v-6mYHTgDZL6zW3zeqw>
 <xme:hzkYak7N-v6UBclYDOo04kQc1ezmZ3RUu8Egrf5Wrfk8dWy-deYFT-yHGy8SL0LlB
 -PlZCml_6Z70-D5tGWeilJw_HfHWGSg5-ltIOsUwTwMqECYhd0>
X-ME-Received: <xmr:hzkYavgwuqhPkn1Q3kucQZ2GtfYeDfdWNAFzcTksfV-41XWZLuifex61ucKc3fOaOZ7oidWLySf5lG_F1UqFU_iJxv7QzDo>
X-ME-Proxy-Cause: dmFkZTEFn7AQHI48n9AODvJpJqUxdk72sZf0QLbOirQK2oyoi+UcGmNWDkA8MQxq/UNVpS
 kxC5Io4+kU3Fbdr2iWwXxCfnXp+UEUJi+bqAIR0An7WYiX1o8NsYAUQ+pI7oK7Eon+l6Qc
 5smSvBkE8YwlgQX4htbges5IHO+VQGpWCeK47LL9uKaWZSkQ5SQ07Hb2BFZLFyK7uXMXjg
 a1gXgJJv4QvNCyHA6ug7ni4QQm0Rb3dKyMtJ29hsub5yqp48T7fXlGEH0ytXZYMruyvqZu
 mw8vrT/WMNUWiTcH4tjJGnAZ2M5JgoyGW1r2WTRcytlCKxhVBJsOOZMhAqWbv+aQjxKVgD
 XjCq5YQtRkf3arjHmxOKBAuY9meDkob2NJi/Np+q0msI3FgjXiUuvhFT9CzW7ZbeL//eSv
 0eMiaFnmL6ZSxaGV8oenKjqQCMNYPIhHM7asjITKsAa+eliK2VS0QxtchP6nBSNzpbepKv
 QImErrz3R95w4Nx0UuZv/DsrJ1bbgL5W9fCOsV8an6gW3cDws7RMVpJN7PdosBMCdez2ID
 dbNUfMBmZRA49Xt+JyLNoT1HKTzsO3nmTl8/UL1x4KPVoQBqZX4Rds+ciFbG+b47aN9zAE
 HghYidHOyBQZ3GECENZ6QnV+ud5PO1jCDd0zNA8Oydw4IX5Rmt1LURFvW4qw
X-ME-Proxy: <xmx:hzkYajehtwUhjdHSHSHs53Ty1-IItHtluc0OGukHGpr9LrLTJGWe4A>
 <xmx:hzkYascWOe_j1XvCxLl_pgNlA_b2uROV6I5obhCsoYeIC0doFqDOiQ>
 <xmx:hzkYal8ABKAx9iu4IRwTfAw2ztNDEUDkCd7htY4aTw3T_LXGowSErQ>
 <xmx:hzkYagn-_t3Mor_1oNOHjoYIAzDwiYr4YHHGiq_AHXakq1sFEXWrFw>
 <xmx:hzkYaqxKw5T9TuL_bMuvxAWSH3hxsc0VXv-uIMLH2iPFUXpNvOCfvcSu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 01/10] app/testpmd: print Rx split capabilities
Date: Thu, 28 May 2026 14:46:28 +0200
Message-ID: <20260528124758.1984528-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528124758.1984528-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260528124758.1984528-1-thomas@monjalon.net>
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

The capabilities from rte_eth_rxseg_capa are added
to the command "show port info".

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/config.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index c950793aaf..55d1c6d696 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -790,6 +790,12 @@ rss_offload_types_display(uint64_t offload_types, uint16_t char_num_per_line)
 	printf("\n");
 }
 
+static void
+print_bool_capa(const char *label, int value)
+{
+	printf("%s: %s\n", label, value ? "supported" : "not supported");
+}
+
 void
 port_infos_display(portid_t port_id)
 {
@@ -911,6 +917,16 @@ port_infos_display(portid_t port_id)
 		dev_info.max_rx_pktlen);
 	printf("Maximum configurable size of LRO aggregated packet: %u\n",
 		dev_info.max_lro_pkt_size);
+
+	printf("Rx split:\n");
+	printf("\tMax segments: %hu\n", dev_info.rx_seg_capa.max_nseg);
+	if (dev_info.rx_seg_capa.max_nseg > 0) {
+		print_bool_capa("\tMulti-pool", dev_info.rx_seg_capa.multi_pools);
+		print_bool_capa("\tBuffer offset", dev_info.rx_seg_capa.offset_allowed);
+		printf("\tOffset alignment: %u\n",
+				RTE_BIT32(dev_info.rx_seg_capa.offset_align_log2));
+	}
+
 	if (dev_info.max_vfs)
 		printf("Maximum number of VFs: %u\n", dev_info.max_vfs);
 	if (dev_info.max_vmdq_pools)
-- 
2.54.0

