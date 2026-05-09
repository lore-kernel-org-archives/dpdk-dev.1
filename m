Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2BCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68A054060A;
	Sun, 10 May 2026 00:04:22 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 53ED54042E
 for <dev@dpdk.org>; Sun, 10 May 2026 00:04:20 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 9547A1D0005C;
 Sat,  9 May 2026 18:04:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sat, 09 May 2026 18:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364259; x=
 1778450659; bh=YHkdGsuMY62M/AuEMvbvksloJujTz6zangkqphvdY8k=; b=e
 BDdaexN1j59oCcFWCtU/Z7X/f2GLVf6UmbNonfty3Ae6zhVu3DB9O2gDMQQ1VJuF
 oVZH0OUW8GkT1PiRB2NpSfqcHhm+nLfCEEzSw/rHql375VtCO3u/57ZpU1Z+3wW6
 5H0yFjyhk4FG58bNPM9LoxwdCEcsFADw9ZX6rFt4e6jvU4q2c0VYzJ/VEKkAKYCc
 ZhUa5fHDn5Gj5TrxOZgYRGl/iPrcw6PxTyLLnbaJSARsJSroLBWApGnwB600GUUQ
 86Q+nypttTlA1QNs+W0kXOB/EH5LIRJraU01jE6QK8sgFtaxhw+1qyKCFk7Vmc1z
 +Kennes2RqrizK6YAX8Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364259; x=1778450659; bh=Y
 HkdGsuMY62M/AuEMvbvksloJujTz6zangkqphvdY8k=; b=U5AfnL6XF5lK4kHdU
 k8zzYvKot1LyGR/S+/zhtRhOvAKY9RtTAXF/vF+zbIcW0UfMYQw3mT40EdpfEMBk
 qMh77pOkjuLhnDnBizh69O6ys+VAZiThRuBA5H4nNblVKo9940ixMdFW2LdYl7Rp
 8zH3EQIxADxesEX+9q1CaEq8nFAopD+DZU2yibSxUVPPx+3gqSDJb6EOYeF/QYDf
 HZjDebPHMsJEYuj2HyQo7nlhVZghOrwLiDYQfd0qUumZnVSPgx2JKGx+jnuhgLc7
 xOz58cC6lLSEtBoClZWF1ZgFwzsaw32olu/fLCrzay6ZBT5Dh+ECj53dpiaHe401
 7Bcbw==
X-ME-Sender: <xms:Yq__aX8tAsqGVIUG09JAojLTvTUHiyTifyCCLl8XXWmIRdhk0RE2fg>
 <xme:Yq__aYBkeaioWqlFE40BGdOWg5RKCv8vowQCgA_cdss3N-ezTEvMssduEuAhSs28K
 8p0ldestEic0PSFnpqTTomBlvp8-S8SegVXOvUazNWJuv0TPnp_FQ>
X-ME-Received: <xmr:Yq__aUJ9j01uerqhpIUW0n_bke2v84Frk0s2z3Ui_BlCJGy3iarCojt5tcoa19qerEbL2k5GmxnK3U7X5d0RdoyP3iYn7PI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopegrmhgrnhdruggvvghprdhsihhnghhhsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Yq__abmYS1dSfRO60gK7GChYDYS8oLXn7-8nwSwCjtkbQQQRL37zKw>
 <xmx:Yq__aSFFcIPT4zke4pK7DesrOaRAVgmGUsKddsew8d366iM1-dUfPA>
 <xmx:Yq__abGYHxZOjjhG53cKbj4N9uby6bClDjQgBP8f1GUeoQwEICPcxQ>
 <xmx:Yq__afOEMHo7CV5_Xjg52n0MegZ7Gt-I8dffyxsMwv57b8_3uUzNPg>
 <xmx:Y6__aS6U14ABafGPJTbJP5hhkVT1jOPYepXc6SAe9z0FTM35NCGGREPY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 01/10] app/testpmd: print Rx split capabilities
Date: Sat,  9 May 2026 23:56:52 +0200
Message-ID: <20260509220356.3679114-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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
index 32c885de0b..af725fb74e 100644
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

