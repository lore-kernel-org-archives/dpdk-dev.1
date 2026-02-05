Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB486ECD997
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1B9A40430;
	Thu,  5 Feb 2026 22:30:56 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 15337402F1
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:30:55 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id C13BDEC054B;
 Thu,  5 Feb 2026 16:30:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 16:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327054; x=
 1770413454; bh=GZSfc3JlYaPgOmPTmu0qcIT5dLskIkyL4wYy7qA3/Zo=; b=Z
 p2sN4CSxpFfC+aW2jGWzwoW0ynhmLz8TePzSHBwnX9imaxPRXMnu1YGxJW8Zvv2Z
 HHr3KqmYNf0WHXNsexXpd+mx+JAi/JcTd3p1rjFG7KEnhATyMGZ5ERTfm5vyJB82
 X84bWq4EPR2y6y8bA/XufYyNPxUlrBr80HHTCx9ZycJJbdUYpF5p1wYLDHkXO74f
 1e5utZCaDCPYSqmWNlDoKBvLaOTB2i4M3+k/iWeVT3Q2XjZG1QAK2WuVW0PyWIHA
 jrVDjzWCEckDH79I54VOuRBV24smf1FoTcrID2fgNtVY4cbnr8O/GIt3jMFOACON
 +aUQSwHry8H1np+40XWSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327054; x=1770413454; bh=G
 ZSfc3JlYaPgOmPTmu0qcIT5dLskIkyL4wYy7qA3/Zo=; b=bLFoZrcPQJaTa58U3
 jUYguCcDhoflkRtIFW+NY4/iRzdfSw96Six/xDqfkSX77h6TMqMOexfe4egsLLpr
 3GmTKftEBzTifq7MzmimJzltC0MZ6omfhXH4iL1SlzEkHQ8hh1xHsHT2qkVBcKdM
 O8XsKiwKgNXTh2UDJMCwrbk6Uf5NkqMK6E7z5dKcuuHMRAN3E62IR67uzbWiN3Gm
 kHyynoeIKQvLioXiJ1mvHpf9r4yRl3ck+9/PWiJkIQ654bc8yDpxmj3YmQaLHOKk
 ZFBIupjk787Rd0qNnfdLRmPw3QMDCZdo4td3KizFlXEl2ZCkOFIro9igMCvgb5hO
 GVdKQ==
X-ME-Sender: <xms:DgyFaa41shcJxGhRJ7ErcSHoo7JI46NnftBHuNFr6i-Bs9E-aYgisA>
 <xme:DgyFaYMaGzH8hruVfA5A6yi5qj27N1PWjfGXeOkj2fJT0BxpfARHdz5b9ahKMJh_t
 NEJHN-4XHzJnrHXhQtwNz2TURCDg2gg9j2UxoPF2zEDixWp956ANQ>
X-ME-Received: <xmr:DgyFaYmutChTqJqciWu8VoRjmCeMnjlh5XGXA48IaaQCLK88qYTaOUtmncgpRUlmua5O73l9EVToSER4VCIftMMv392-rxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:DgyFafRd2w9E-7oYsFzDL7KrdZ1nQ_GDrMhrKQnltP3-8hYeV0maIQ>
 <xmx:DgyFaUBBPkC-SRarSq58AzyNz89LmLxiyeJcQ5SX2gIP06ez_s6Drg>
 <xmx:DgyFaeTL69ir-vonS1eLdj0gi7xLXt_6H4PBs71Al4FtdvtPWhB12A>
 <xmx:DgyFaaojJk6iGiK7v_AaM7DWAAQbNCv292oU6_hwUFnhmnoUaJ3xGg>
 <xmx:DgyFacrD750GDAAuttR8T48lzpmt91_1olx5omQBF4_1JmdKRkbbN33f>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:30:53 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 02/11] mem: avoid hugepage path overflow
Date: Thu,  5 Feb 2026 22:27:34 +0100
Message-ID: <20260205213044.702908-3-thomas@monjalon.net>
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

When constructing hugepage path, allocate the variable
to avoid a possible overflow which was detected in debug build:

In function 'find_numasocket':
lib/eal/linux/eal_memory.c:450:31:
	error: 'snprintf' output may be truncated
	before the last format character [-Werror=format-truncation=]
lib/eal/linux/eal_memory.c:449:9:
	note: 'snprintf' output 2 or more bytes (assuming 4097)
	into a destination of size 4096
  449 | snprintf(hugedir_str, sizeof(hugedir_str),
  450 |                 "%s/%s", hpi->hugedir, eal_get_hugefile_prefix());

This is a new warning (format-truncation) enabled in DPDK 26.03.

Bugzilla ID: 1878

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/linux/eal_memory.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 7c4197a5b8..ceda9c3246 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -436,8 +436,9 @@ find_numasocket(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi)
 	unsigned i, hp_count = 0;
 	uint64_t virt_addr;
 	char buf[BUFSIZ];
-	char hugedir_str[PATH_MAX];
+	char *hugedir_str;
 	FILE *f;
+	int ret;
 
 	f = fopen("/proc/self/numa_maps", "r");
 	if (f == NULL) {
@@ -446,8 +447,14 @@ find_numasocket(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi)
 		return 0;
 	}
 
-	snprintf(hugedir_str, sizeof(hugedir_str),
-			"%s/%s", hpi->hugedir, eal_get_hugefile_prefix());
+	ret = asprintf(&hugedir_str, "%s/%s",
+			hpi->hugedir, eal_get_hugefile_prefix());
+	if (ret < 0) {
+		EAL_LOG(ERR, "%s(): failed to store hugepage path", __func__);
+		goto error;
+	}
+
+	ret = -1;
 
 	/* parse numa map */
 	while (fgets(buf, sizeof(buf), f) != NULL) {
@@ -503,12 +510,11 @@ find_numasocket(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi)
 	if (hp_count < hpi->num_pages[0])
 		goto error;
 
-	fclose(f);
-	return 0;
-
+	ret = 0;
 error:
+	free(hugedir_str);
 	fclose(f);
-	return -1;
+	return ret;
 }
 
 static int
-- 
2.52.0

