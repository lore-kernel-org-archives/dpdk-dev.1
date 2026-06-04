Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CEFCD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 19:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 533024065E;
	Thu,  4 Jun 2026 21:33:32 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 06DAD40651
 for <dev@dpdk.org>; Thu,  4 Jun 2026 21:33:30 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 79A7B1400132;
 Thu,  4 Jun 2026 15:33:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 15:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780601610; x=
 1780688010; bh=vz/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=n
 NGiGrz6InSElev4cOXWykjmOw6EIAdWTrcjYzftOFpGBHmZlingv+ajZyCgmJZyD
 0bNsROIgCstLwnE48jBGcOr2D/JF2tuZDsp3y3de6OkyIvmtFTKJC85yhLgsFzPA
 P/DAsLdhvNHys6L0dX14pnPAQdp31PP6my51k2V72Pq5IKGP56zKUdfOQsINnGhQ
 gUxzjrc9YmBQvoIhKPbg2H7jrSB/fZtRI5boOQZ4zwfNUs212S58PKgXl7djlG+c
 3NQYQtj3XJNk/SpyHRrJ28O8i72E+fulPvcXmU8KTIXjsv53ZyrFpXPqsNJajm88
 wYH36XsXQD9T4ErBKCLuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780601610; x=1780688010; bh=v
 z/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=ez3Eki9bw/FEz9EmB
 HbYT1j2xBtf0Xv8OBWasspNN0u+2uK7GsWyByJUuiesre9Nxvzr+Jj4xok59IXMM
 6mVa0ZEOi92OZiWiaLzWXLKlSWtroaeG/zo+nEyuir75bgQJdDei1y1dJPngTsDk
 rrjqf0pAsz3fbnA5dnTBO3zuiMmhGcPdHkHnJa0UuRzpwJSGXKjFRi889b7zLCbX
 BR1+7ILfLdaR+FvwG801af+ELrVSSCTzm1NiEtCiPYcxCymAITOfoCgLkoFvs0Gc
 a5P3npH9muGByH1NDZSoFXzc1vVJVqQh0iLRDojfdZ074SmpMQ9fx1fFz1vKLWP8
 3mInA==
X-ME-Sender: <xms:CtMharMp5esFlpEhFM2-yqbp4FoNpqXTJQ2V89gxY1IqF7nMixpx9g>
 <xme:CtMhaqR-pZyhlyMVHZOv5v5WLNl8rHdXL07TVkjpEEgvQjRJ-wvi6hJJb-FAQEl4p
 jZDL9SrbzLTiM0RnfM0Nc6Q2G83TH-IkxT4RHh6cLcgxrhTIqMi>
X-ME-Received: <xmr:CtMhapb2AjVoPLkYu4LB0V-ptVYFCb1cxBjmbpX02madDLxWPJ-rhGLV3m3myt8KCp_h4dnaGYCTrhyGQwUP0hpZVUj1-ks>
X-ME-Proxy-Cause: dmFkZTFBVtFu73v6kEfmvEVYm2wybPSOOTBO2QZQTLxMmhRKicwazOPAhmwg6YOl/udFjG
 9CMckWvsaG3S/jXdOqGQ5YBD4798m4D3rAKVoB8d50ghLHACp09RRpMyKxbxJtg2kE4byq
 Wp+HcF41u2/fePWGB0Uoi0ggfcS2OmIDt7CA/hRM1+p1IN9erhF5steHvQA9oFz66G1z/y
 O12rNKrmv1xf2hrywdgv534RP7gMBVDK99h9nsQJRbuaOBkZo8ScTD2/4XPDewNtPAzPjR
 ComfayxCQpZAQ5JXvsrV1I8vr239TJi7FrAX9RwQ6Hiol1JR4VNExV6vm4spCCRsmuhAGe
 SoEMjYmWXeCbwo8hdeaFlkRXQ2IDq6aBQ+Uisv7MRtl+tKOom+1sHLm5kesL+Nrqg7T1tG
 iWFHHVLrpIAKN3S0HnajAw/m1GSL39oW1j87kXY/maxqb7tDLADheRtEJLWOuv8ck/dSvC
 iHNCvwcfJ9HtfXt5h3J9NbNvZoHZ8C7NF7wEG4+nzxzl2FKDsjH6Rs86TExqk1UvOuc4wA
 Bo3oS5CBRYFJwLg9JSaFaBUarHTMRt3YO1bpXf3AaHtEQZ9TW8JHczeQhjyPTiGQrrMWB4
 YTw2XQ/fygwp0KyGPqcoBgbfFKOMmRsgc09up5equpxyZoFWMrbUtjcwIOGA
X-ME-Proxy: <xmx:CtMhan2551OrnjD1H2s2lL4N5BinZuWr1U65g_RSoI_cfupi7SeYuA>
 <xmx:CtMhapVQCoRkmZuN55CVg41aJFl4hxLrpQd-N6M-c5qEQRS0v-iIGQ>
 <xmx:CtMhahWx8ORuCoVrp7jxtj1v-Rx-smx4n6mWpLPonuNDU2S5P-x7xw>
 <xmx:CtMhaoe_UZkDn8fp-CI3AuGH32wyWeTtFN5sH6CQfLaR4D9XrLVM6w>
 <xmx:CtMhavIYXNf3DbAgSaEdXYCQjxxYG91giopU8DkOw5Wb59uceZnCeG7I>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:33:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v8 1/9] app/testpmd: print Rx split capabilities
Date: Thu,  4 Jun 2026 21:30:53 +0200
Message-ID: <20260604193324.1996141-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604193324.1996141-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-1-thomas@monjalon.net>
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

