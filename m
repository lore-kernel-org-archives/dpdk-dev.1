Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EEAECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF60C40656;
	Thu,  5 Feb 2026 22:31:03 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 3125940647
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:31:02 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id DCBCBEC04F2;
 Thu,  5 Feb 2026 16:31:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 05 Feb 2026 16:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327061; x=
 1770413461; bh=fjeWoP25rz7BV4OouTm3/uqLs0Nuv/AvQwU39L0FAPU=; b=S
 w1F0t2hlqlqfQzmJdtaPRzQfUSonmPriAJ3gOYfECxYMhkr/PAzJS1aTMbyKoV+n
 JV9kqhU38pAxg28UZkcp24EK9NbKqFhUcNHJtnG6/HKKrEzy5RhxFYFNysCOI/Ne
 RM7CtAAg6EwT3SAPc8fLI6SMO0kdJymwDCKR0Qx3sRULYzJHETHCbKXAIp/gGMEJ
 5wX50QY0mrQRHFBmEr0Qp9dhwqmG6ViuBIXo94By/Om9fOf6keJyhqKhtooxO/jw
 9fbGvBH3A+KwqtNgAqZUyPunwdnV9uIWkfP+2QwnA57bKqhfKQxNUqkP8L+2eKvJ
 FJco32TbXbZt4ZK/io1/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327061; x=1770413461; bh=f
 jeWoP25rz7BV4OouTm3/uqLs0Nuv/AvQwU39L0FAPU=; b=nPi7R7S5DXtRtns1c
 uwrop9iPLSiLliu07K80V9fclEV+7q81OpqoVq3EvR1WuBeY2gqaaMAXNHLdDd2F
 t1rHAbP/5sNQJm+9H4TSdabnWw1ANfmaqtV+49Smy5eUTbrc5BnJVIDtW8K+Rfxd
 X0zNwxbVkGS+/wDV678que7o0+w7QHin7dolPQRpRnIntfaMpWoKsnFc9FtZN2Y5
 vZuzKKj05nvKulnn7cGiisfkQFGh8cL3JWBZnQ/lPjHF54+GuDiBiSwZdr1rDzPl
 rp6zOTSzoLuvdphbCUBjcyvDbNcxfVDnT6DPPZprllTqg51Oj7nADmuJsgE4vaRk
 biBzg==
X-ME-Sender: <xms:FQyFaQsKWb8SVE7Hceo3MntGTXam5WDFt0FBrSIoGrinRV3KBqXeWQ>
 <xme:FQyFaY52qZJdTLGu6epjJ3mh44MYPSeKmxnHRTm2ia24k2YET7a1NF--0dOnFmHi4
 xIoCsHjnQsXPB2FaRyvUYDgugaust51Y2ExTbxESXiv0Y_A11w>
X-ME-Received: <xmr:FQyFafQhfqknKFew6yWdbWLkm9t3h9T4Z_W-A7SzbFc_a3fKfy9fB8oytRZnWeqlH-tXFoZUuU_CJl8a1Muq71qLbT3gV5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdprhgtphhtthhope
 gurghvihgurdhhuhhnthesihhnthgvlhdrtghomhdprhgtphhtthhopehsihhvrghprhgr
 shgrugdrthhumhhmrghlrgesrghmugdrtghomh
X-ME-Proxy: <xmx:FQyFaXqTUn3iU0PExFNav8yRn8ihb0SpXcZlODjhQVDgWLnJ78xJig>
 <xmx:FQyFadL5MvBWuiak89kghhQtmRNz8NWNj_23gqEKVJ1WQmf8TW1-HQ>
 <xmx:FQyFaao0YAEdbDmeK2l4hNbbZQeZzNgiywept3IaUbobjZaNkI8Njg>
 <xmx:FQyFaVzlFDPZl-PXhczzJ50qucag5gFex_4dlGpOHytAIJx-svnl9w>
 <xmx:FQyFaQZhxgeeghYXjJ5GnKm4ua2F3V-47WzYogqdki9w5YuGZoSS4EQn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:31:00 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v4 06/11] power/intel_pstate: fix minsize build
Date: Thu,  5 Feb 2026 22:27:38 +0100
Message-ID: <20260205213044.702908-7-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205213044.702908-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
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

This error is seen in build of type "minsize":

In function 'power_init_for_setting_freq',
	drivers/power/intel_pstate/intel_pstate_cpufreq.c:205:30:
	error: 'max_non_turbo' may be used uninitialized
		[-Werror=maybe-uninitialized]
drivers/power/intel_pstate/intel_pstate_cpufreq.c:122:18:
	note: 'max_non_turbo' was declared here
  122 |         uint64_t max_non_turbo;

It looks to be a compiler issue because we are not supposed
to reach this point in case of power_read_turbo_pct() failure.

The variable is initialized to allow compiling with "minsize" option.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/power/intel_pstate/intel_pstate_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/intel_pstate/intel_pstate_cpufreq.c b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
index eba50b2874..8e27570e3c 100644
--- a/drivers/power/intel_pstate/intel_pstate_cpufreq.c
+++ b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
@@ -119,7 +119,7 @@ power_init_for_setting_freq(struct pstate_power_info *pi)
 	FILE *f_base = NULL, *f_base_min = NULL, *f_base_max = NULL,
 	     *f_min = NULL, *f_max = NULL;
 	uint32_t base_ratio, base_min_ratio, base_max_ratio;
-	uint64_t max_non_turbo;
+	uint64_t max_non_turbo = 0;
 	int ret;
 
 	/* open all files we expect to have open */
-- 
2.52.0

