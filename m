Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98007CD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D7474066C;
	Sat,  6 Jun 2026 01:35:09 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 024654065B
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:35:08 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 9698AEC01E8;
 Fri,  5 Jun 2026 19:35:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 19:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702507; x=
 1780788907; bh=vz/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=Y
 plNkJZRE04SsPSDs1g7V/XTz7b1OynTUXuZxhb7ImMs7sPWDnWje2EqPUqV2yE0W
 7K6AT+5BCejZYMUPPNix2q8mOokP2tbXgnVT3Z74PT/ae1303uKk93vF+eZhcIT2
 Le6/4ZDzoP4l8+k+Qo6gHoSN4i151GdsE4PI/sNscQw7z7gEni7BHWoYiadTWq1B
 E5hUDX9/FWQ0Ik6V8ZuUDuWLHrJbfkuFs94kZweqwaowKmGVtmJlC0TswffGpL8a
 8XnyLEnBeAuVH7H8voehlr7PYxh6ZPnLPXNWp4Kp4xDdCutDl6KTNUxDwV/8bBOj
 QUt8Idrsxr6zi2Uit1aAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702507; x=1780788907; bh=v
 z/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=MgQHn03hKlY3EKlYk
 i5KoAKbrG44coF/5vmb/1T3VocIWh4sIycnByDevdGDWnOqGASsiyj2+XVvP3v+E
 Uy0n2erv5AxVrP7rTWskVW//Mubqt344xqw4jIYPwhf0SF8HgUf/dx//YjTyBgt1
 kUtp0cmzGafrzHCFTzr+vz4Y4sbyGdY4w6eSm/RMM3VUs6q3UN0OZh53dF6hSNad
 B0kcRD2IJhu6oIxUk2O1QVduJpvtQugOvXzYwbQ8iQjWWnLlUqASjdaRfduj0ucC
 Vj0sxPPNfYsuhJgLJhNhqQ+q2iLfGBBhq/STYvMGSDOT0/DpkHGu6xgKIBdicfog
 znE7Q==
X-ME-Sender: <xms:K10jauLkzjfor_Ej8JtIjrWL9vgMQyBVfY4f3dXUm8OibVlaLXKxYg>
 <xme:K10jaqdrqj6AcesFNUuQaT2lkKTjy1VjOtH2GtVepFMbOt9DVKuPkoJHaG3am_Jqb
 Xr_H93Wnf0lgkORlmFgCclbt4w_2EXkCgBebgDVKdBHsUnVryqtww>
X-ME-Received: <xmr:K10jat2S0LbqkVg_wZzyYhGlU2mC1W1zh0BFqcSJpqG8PjojZJjdVwarjBKGu4jBFHVwM6KI-xEL0W2qiN5lHXfSDW_GNR4>
X-ME-Proxy-Cause: dmFkZTF8TioU96Tq8QejfEYWkQIUsOFAOK0FW7DC0LiMj/WHoJBthbNIYQLZhbAbsRQFO2
 lhUgktCKGre+6Hnm7PQXDfi1me7GJ21rd3W+s+oTHe2orhprMWu2vu6WchUqxiyReLNIP/
 h3ejxiJXKpjK7apdIpmRIiSOfY1fUBhqsQ0e82bQFHzyD22eDCAo38hZuDD/ypb4Oztk6q
 OeXfKEwFSxXbs9e3Sev8qr5ihJ1wJqhq/BCqlbt+MotFGfBijxQCyHb3Pfm3eEogn9mTf7
 rZwf/OFQ2wp3HTDchj9Os4Lo4khXvPNfnxTbVv7CQBS9l+7W8MnadGcXfmGvlq8RLz+3Jj
 d2HqfA6T+kw1c9aZwCKrbwD051lX1H9l2Z+Yz1SQVluykRdfa0PAygMsSVvcxNYYrarEmj
 zLOLMQLfO1Ln+8WRz4GI2fa7wu9HrQvsvTd8zV0ujXc6D6tzrXNYzPm7yHRPsdRI+BL5Be
 UYYyrmYnwBigcc/RwNtE0eCU7FpoDesi7HOo5EC5MLCeWR4UGh/49ynsUZs9+38Awn/Omg
 s53AGPbjCGivv6X0Ck0AneVpzX1isJAHVXufzR6XprBExiHui9wLyZ8SJsf1PX4MmMq/nf
 JzBLWwejE5X9mbXP5KVEzd2dNOU+WJgT/q38HemJAji33tKFKzlpuGjVBJGQ
X-ME-Proxy: <xmx:K10jargNT_Ydg7khlQrYtTPtR68vTEYGb22AeI1LTag2tVmajKRHgw>
 <xmx:K10jarQvGlAKbWsnWuyGfGP9tPC6RkqegFJ_lEOfk9vX9uak9LCeng>
 <xmx:K10jakiLvJzfEEFv7bs939rhVSHIJR1CXZM7Vz3xonNzIuHPAbC9IA>
 <xmx:K10jaj55K2LCvoCYb5PcU9RU3rHbAPfnsR7wHe5gohuW1zimwQ1eZw>
 <xmx:K10jaimEe9mz1Vp33tpodGvLXby_3fLnrHBfSUPPeLH-vkiFlg1yg7Dl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v9 01/10] app/testpmd: print Rx split capabilities
Date: Sat,  6 Jun 2026 01:33:41 +0200
Message-ID: <20260605233456.3017423-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
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

