Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55813CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19CB440667;
	Wed,  3 Jun 2026 20:45:13 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id A3FCC4065E
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:45:11 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E4E737A00BD;
 Wed,  3 Jun 2026 14:45:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 14:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780512310; x=
 1780598710; bh=vz/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=W
 3uKFNZfnjaZb6ixOgcKOKTPA25BvTan0haWHKCPmZQMDiU2mJdpsLna+cy2CL9to
 iklbaOA1fAXNf/lV4GWzFnsK2FT+3mxwKvhV+rQpsIIm55wuTXB9PlUdOj0I56XO
 1M4u0AFLelPeScxwUW3JfYoYTk1YELSoQXPFARykvxkV/dytmHdUVtZV4pTU+ga8
 uFwR5l7PfcxDnZKX7Bu0KbzH8/o3UdY+9PUGzcknMA4RxOkCzfh6NLucYpkVrMVT
 hLrkXKZm7p4WG5UL2QqSFh0cmpplXkA+Bl97BBeHoho0vaWlkzZy7H+AMQxS66GR
 Vw73QA7CSjBOFaKx/v5iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780512310; x=1780598710; bh=v
 z/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=avx35eZUTOtZ5rVdv
 7vctkEGJ+2SNa0ogkf4gj7QA0wGcrTFbxpSyftJnBQW5jQbXdKWKAeZHYp18Mw0s
 YAMCwDGXJ84CeNNGshtbTQJoCeu2mU1cmJ45Z9PCfzllBpQwFHQslvvmYk9DHW2t
 Gp4DMzu6Dlsvv1PzEG5nO4jclMIoJ3y+Rez2lC1ceDe5jdwBzWJlkycN25jPgi1o
 S+3nrT3CINFkkhfXKd0ks+NwJ3PeGEpXpmrjTlgYbATMmNVTODi4SttsTQUz53GF
 7KfkBznucFMauvUym032/LC5Q72G+h53K7ad1wl+BKanUewf4rAZHJHML6tKL8yQ
 E0+/g==
X-ME-Sender: <xms:NnYgatV1oZ4d71HuAONLWtutpkztFqL16qZbT8vP4tmzvBgf6SGk4w>
 <xme:NnYgah51kI7LYTn1szqN398vUtJJP3d48k0Fngar6YB-JHzApftixZ0KscxBsksV9
 Uc6mV8LHoLPaYjGhg6E_B6M279L1aKUCtvWNcEV1mA1pQdieWLXmQ>
X-ME-Received: <xmr:NnYgaoiE91MF4NOnk4yAo43-FCzGfINDyDDqwNm3GirB-ky9XJ9EoEhhRTxPRF-DoUrIWmw2XBCi6XkfvAmvoABP2OV9S0w>
X-ME-Proxy-Cause: dmFkZTG3Cc37AEZv9gWLWp72Aes+17oTj2cMnam3xuZtyjtHoUerOWgaegF+YA5caRZxlN
 +CpkgXX/LN++ffhiXBWkGJbYR1ThI8q93cgy6Xrsdc2JOur3G+hwonLVgkZqZlxQfN01Q0
 HpCgGzFYmnGyurvfbaioIV5f6QOcRha0Y8fP0mOSR//IE6g+GyuDMiZMJK5pvJgOcqQ2v5
 RHmzDuOrWL/PsjNYI3fdzrpjl2tywyPsPRvhLE/JMnVlC+JivaixKJ8G6by84edoJi/2rf
 yBve3yBsXPqOXBzqLSIl3TiGCTdVziTKrhNFOc/ZaL0dbux7VBMxS4tmA78RDPom42yZS2
 k80VXpXIewS1ipf9UDX1AQE/iaxzJmB0Z8rvC5xXCr1LsYLIwaoSGp71pfTDF77R4StoTJ
 SPXBVFJ3LWDhK28vP1wVKM9DirFJt8FlnCyVpX9ITvmjexzjK6ty/JNTbAp1UXbxHB7SWS
 ExMokfVrMM0tS0DtVziX8Oq6xyp6edcVbhdS2tzAsOI9RNLQM8n4FTmcvZAOb+bAUIDVFb
 uHK1EzlAX4DlFuDdPJgTh9NIcFijD2fBPi+LVJ8beCycf4IvpWfLSKEnkkngEb7gSaOCNg
 TzLQxcawNYIQeWXiVxTO1yYScBuujtVxri8tJLY4TyDZfdtojR/Ppr5oGrVA
X-ME-Proxy: <xmx:NnYgaoeVp_BMu7mhpWxunlpakykyPn2TyMX-uI5LtITZ2JhGlz6q7g>
 <xmx:NnYgatf8oybTdBhAmRLP4US9NsQ2dfoZPWQIVPLuxiX2Yt038lpqGQ>
 <xmx:NnYgai9V-jkb8UKejLFw-3r5Jc_7V-8Fb5Rx7flwiKiohwtF-APEfw>
 <xmx:NnYgapn600tfUkS4Olb2MloC4_UvLxixAw2GRBHTc22WXEQ-mG0MGg>
 <xmx:NnYgavwOSOooielxD5uqqhxWstbAqk2f-aWKvCNXVUks2UfracXeZ2NR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 14:45:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v7 01/10] app/testpmd: print Rx split capabilities
Date: Wed,  3 Jun 2026 20:23:24 +0200
Message-ID: <20260603184503.652030-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603184503.652030-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260603184503.652030-1-thomas@monjalon.net>
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

