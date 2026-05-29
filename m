Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7489ECD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 13:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01C4840431;
	Fri, 29 May 2026 15:35:32 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id ADFFE402EE
 for <dev@dpdk.org>; Fri, 29 May 2026 15:35:30 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id E30F11D00089;
 Fri, 29 May 2026 09:35:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 29 May 2026 09:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780061729; x=
 1780148129; bh=vz/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=D
 JaCe+HJlRJ9Slwi4pgQaQj0kkk8N7cQ6XYOJJ9WtgO3593qManT4W4pQ8rSis3cs
 Cu1/YOMCNHjJmllQ+da1rWoo7Sq4pEJBAZsu4HzO3AE+W6P7GP+mUFhkltSHzkgU
 8AySE0tiFSxbeUMe6nWqYcd+r9071/mUW70ll/66GGU3w2Ta3IITePW1ZT/38mvw
 zla2oxUZPQwMS+z3hn3pvClXY9KHf3/Wt4Vx+9qOgCoZ4CWsSl00Hbf8JOglwjfD
 ivLfgZ4CEOtU43N60FYSQJRe6yIItEIaz4tM9gNiOGycYhnW69ACGQNV2DbGVRfj
 yhl1YYOr+pv6OUYmmDbsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1780061729; x=1780148129; bh=v
 z/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=G/95KfYYY8/wv2/5j
 YSySyPJr99KwtV1cSVqkKmJzK8ggtTLsrQTSxbgg+FVQaA2jDFU9+KNEQWvDqPU/
 xfSdSpAA4wBvBaFixXa/wCgnlKbimdZBuv2dhtT/gGZtIr7+zbXjB/x82aDgJL9a
 0A55ZFKMNgvo1yGPQVmCnIxFISWlitX4y1vZssQpq3+hBoAEO2F0nAy9FFArHou/
 2xuGcR1WUJB0YR4zYAr4c1eR2u6FZjERAElv0dCs9CUWkgNuIa+Iq1hdORkkmKKw
 eYtpoH6ZAbQkd2Rrzyqgx9NC1GEo4qWkq+3l6mROAHloarQ7uZ9/94T9BF8AsADJ
 z+nIw==
X-ME-Sender: <xms:IZYZakIrGEFTukTY8N3au700_iEOomk-FeI15ciadP9pUFqaSYvXsg>
 <xme:IZYZaoeilygu_B5vgLwWs0ObsMJxsl9_Jq7zF2lqTKpLdcCKKEyAOAEh3FRFz0v7M
 j5FQmSk36hx-OSNVuVaxnBSEhZhVNU8vDlA8aavKTjAWC84g2Tg_Q>
X-ME-Received: <xmr:IZYZaj0wnka3994QhT5oQWDwQ-bMrbQw2ZL80H8GNkDc4CNkK4b-n-HvHy0E-PgxDlaIa5h1YyAlVkW-GxQ_cjaSDd2g6y8>
X-ME-Proxy-Cause: dmFkZTE3poQ72lyOLUtTls1iSE7jC1cJW+MwUIT4Kv644ZOrdNRKfQ3/Ev2gXgL395veoh
 ZDdDjLNSO0BG2KHpNIwo2dedZS3b32AgoiPrSkQK080JNV3qskw91CJsXhQZC3e3ycJ3Se
 KN6SHiNywBxxxsKjfeWSX5APDcmRKffqT9WfPe7MtMaXzo3bkvgDnD78AQ/3mlvaYa0TPN
 SLRcV4tweUNBMms/TSSl1iNBPpWug9xdFZbzi1A97ZkW3VS6oHW+6Gk+78N/5RM4vbcms/
 3U8SKm8B1c/qgSmjmyTj2xQPClqshWpEG250DNhdWY0QdMyhpQEDT0oNzp/PKMy5jCCDNO
 N/mHOPl1flMHUBrN/a4ZY7ops5XidR0IRYhWxah3TuB8CioeFV5ilEtbNnuFJXDnv6c57f
 vfGQTMYsSdzWcEcRhlnsGRTcIR9zm+dl7LwoQ6cgyZTJIKu5SwY/Cmrv1Cp7lcyr720F6E
 bdbLL2IrnX9qHOjtiFfckGs7gfruPm5s7C6Q3oshHa+LPPQuwWdjPrKRvHAhki6sh4aC6E
 qSLUwyY3m6WBn2iNeNPRzDqRmgUgw6OYfEeGyScSedjTL5a1BA4fhArCqVM7q6dQ1Uy9t2
 jYyKlHzDuhvbGCF6u9KZtQlQZh0FJKlFOHkGhVxMxnpPblvTzvVo7Z8LdM7Q
X-ME-Proxy: <xmx:IZYZaphPv0BsvhT0dK0hzdVnje4O9e3ZqJOg2H6FqVO6wREEeecDEQ>
 <xmx:IZYZahR8ldcN6aoql05Fh2jj5Qj-q4IYxVmbS1xoncUykQ6X7bpUMA>
 <xmx:IZYZaihQWruJlk48yV1nSvOC-aPUy-H724ZqyvW1iz-4axbeDl0gYA>
 <xmx:IZYZap6MueifQ4nsLu4-NVLmVyM3O46LZ2XFMdLhDHr5Rq56n1IHiw>
 <xmx:IZYZag3CDtbUMMSfrAI6K4vSswzIXdA7h9M0LcZlENBUFryuk1P2YWMS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:35:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v4 01/10] app/testpmd: print Rx split capabilities
Date: Fri, 29 May 2026 15:33:55 +0200
Message-ID: <20260529133522.2646044-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529133522.2646044-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
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

