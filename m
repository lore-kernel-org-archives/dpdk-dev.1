Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE1BCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9118B40651;
	Tue,  2 Jun 2026 23:40:46 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id ED2E540649
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:40:44 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 68EF31D0008D;
 Tue,  2 Jun 2026 17:40:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 02 Jun 2026 17:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780436444; x=
 1780522844; bh=vz/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=Y
 zvB4spKXFS9OdOOwkjyxYeKLYZt52IRNlG8mcKEURBqNXTH7Y/u95MFS3VvlfXsF
 C54kpumTlyBsnXqtBl0o6Fv1bClcbKLmz+TaLCTF/Itn8m0b++8fw8AXbiybeao7
 bB65Kbv914berYtJZi5ohjPTSrAdhEmZ3u8v3h2X5oGgjrEwXZP+040EQ4CY+rLx
 CZNfMFJ72mNjmSWpoSGEYIQNnrfq07eOJYzUzZsMqauxer45j0rY2iw9rQ7MJNQA
 WShogkFxF1ZHfq+HqTNF1kNowy/NwFHuiZ1ATHeAbOmGoClK+rfEpZ1NoKkzFXQZ
 twgDjX94thqSFr/8pmoSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780436444; x=1780522844; bh=v
 z/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=jSmOByZPDt3hkdMMB
 FBkpa54hL1dSfqouoe+jhTqzR6skMlZ3HplGEKn+uC3e+5egF0ucacppTbq+1ux/
 ue2QXM0io4MrwrojEUmZjllffFojgcgTuaeHcykrdEf1GrrqalzfjkmDgN+TGa2W
 DNojahFckukIi/R0nK0FikPm+YD+ZYLRY17Ci8l+tHaqwN+ICXP3Hxu8rUexhHMd
 fkhS2iskFIMXN0LE2XhJNk4C3LiJ9wGM41ROoSkcdeyTjQ7qRp0NnZoQ17Khdp8x
 0z40IhRoz+YyrsA4AfFX/Dm75yX1pe0CIpOkO8aeYw1JRRN/wR1suKyG40EILuuh
 s4o6A==
X-ME-Sender: <xms:3E0fapF7VFLh2gPkTwDmJ045oEg56nMhh3r4-cYOwmMUezPIAYKmTg>
 <xme:3E0fairOQDqz7p6cCEhr5hhUhaD8EcZOrRozI2po4B1H5XgI7R-OpoaVnuXwl50PB
 SdaJK_TGbX0_IWiW5tdT7y1RezCsvNquhj4xfKfK6R3hv3l-Hlf>
X-ME-Received: <xmr:3E0faqQ2Hl2fS6mstI7QsU5lkLgAJYZrQhX1lNn3fg5KiHGkQLo8qnQ69JpouFREDhkVZb2kn8uA_PvwAQSRzTwe1j7jozU>
X-ME-Proxy-Cause: dmFkZTGG5QG5Qo2LZmwXqqvuNNhi19An1/OHLJk+jOD2py8sn4MHJ4nPNbpF72I9jcWzu9
 VRXulbNmYCwD6P0ncbx/mcv4YJNui8c/fgayxuJKLu8KViRzeO3nUh6MWQLuXClMzS5Cj8
 rGYRxhOHw1xRA2LiD2IIw/+mInaTwnWkoindQu+nHp7U5jBZaN3J+BFQd3qCMFkOOO1Ca5
 nMIBjlMLIFzcLvRFfxIx3nkf72Y5pOksU189GTlSPd0bT1sX/nBi1/z0aUkYxn4GdUtn1h
 5Qya9RZnaklBolACp5VLIPUz1oq85G1wGWWORjSm0JoyS9m/5i4wZtp1BhN6MlMw37EbJn
 t501GEp0GeVCpfYy/N3grAoWxdkz1HW/jLj4edtZz1Zj1HiXrj7cWMdnl956MARlS2c5pt
 XOix0isXM/VLQCU/QFHUBi6eR6LXmXSuT0+HAjN60cH40exoMYG1I0K4ISK8UTnH2VHE9E
 gDWtP9CVsgyrhAVQTwQsk5AxdFP2ZpNcciEk5M+e6Ji64BspHg9qHqT+ktLo+hhO+3DWwT
 2veKy4ZwgYnea41hb3LVyYv/8YkBQojJRG65oDOHsnj1eH3e9UW4HudBIMvhgML+AjbdPW
 TbM4Phbend9Emx53P3amqC7wcgOJrjdrCPj43yuooEnsFpJQVqnnKuWdiskg
X-ME-Proxy: <xmx:3E0fanOT9hNvLMJu5UUjDfyD0JiF0fju3c4ieqj8ggbTwTgHtnSQOg>
 <xmx:3E0falMi-ORuEi66m8J1K9V0ROZKvZOBxU9OSWicMlWYimUV44tNBw>
 <xmx:3E0favuyy_NlUBjJ4Icq6q6UDna3f6mMP7zUp6lY4xxWULW2p4HcNA>
 <xmx:3E0fanUyTuTWQmhkTr-l6WUdPQZilbeRZXxpEbpY3wLI2LRPLbmyqw>
 <xmx:3E0faujY5H31nBjxgb68QFe5yRFXCiYNRibAqeIPoWis1kgrzUR53AyC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:40:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v5 01/10] app/testpmd: print Rx split capabilities
Date: Tue,  2 Jun 2026 23:38:32 +0200
Message-ID: <20260602214036.3606359-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602214036.3606359-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602214036.3606359-1-thomas@monjalon.net>
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

