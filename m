Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4C0ECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4A7D402E8;
	Thu,  5 Feb 2026 22:30:54 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 42005402E4
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:30:53 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D92B8EC00AE;
 Thu,  5 Feb 2026 16:30:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 05 Feb 2026 16:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327052; x=
 1770413452; bh=oSUGUyiew/V95szEJCiwNKzQqj61tM3OEqf64KVDn9s=; b=f
 AL3/t/9Ajq3KQU5E4y04A0wqK9W8iFknKy+ytVrPEYy78CPZsTKeK189+ZgM2nAv
 mDOE/U5kAQAsbL0+n0V2HqYFNpvE9lEX/47qY8YgWRrs3T1o0kLFOZ5VAEXX4PG1
 rYXqFRHIKPr98wC7kHxYg6cMFZRY7vgLicqTNzTnPS7cPIotZ5Oql1wM5w9EBn7n
 8GeP8GdpXXKQ4leq88i5ieDqpWrM3JLY1+b31zoahv7iLQvWIoDPq0A02XYnk8SX
 LzHxphh9fPMsCxHE8qzL/x2pEqjhp3Fct4qVDobVwTQJ5UkBuB3ZbA0TGS1HwqEi
 y5xfHzjd/QCKQRNzOYdvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327052; x=1770413452; bh=o
 SUGUyiew/V95szEJCiwNKzQqj61tM3OEqf64KVDn9s=; b=sawRexs6FxZQzR5aN
 UwcONQOSs0rOxo+7V1M9xpAa+blHjoAfhFL5M8D0Jb9MjY3YBUG7/NOI/dciGWIM
 4LNdbo8bmthTai8gUDq8Esw8EbwwceNqPQu+ANvUvaXHl0OZj7SK57KNX+aJ7Ajj
 V2zruz7KQrPx0LBRfvqTkgxW+l/P76cCooVHNXCbTipHW6FlChEyooZAB3R6VYfd
 fufMIQiQCcmQmRMcFh0gZDq63SxAwWoyRatfHFoBMHGfVj1SmctLCWhQt6RMBjXu
 BoVRVF7e8RxJrTY4NjVzU2Q4187wA/g2VXt82CzR3xDiwRiIDvOf9I/C4+PWo+h0
 OP4iQ==
X-ME-Sender: <xms:DAyFaTywWqBwMBUEkQv4PMM6OuejJYhSnupYSOijSYk-SEXaBFl6hw>
 <xme:DAyFafnc2t2pKysholEdh79T6asmmgph54huBJYeS488AINRB-T9zSDc3no3BZrh_
 6XBkzEzkAkQcUToxqyVpqjP0-zFoN1F354B_vSRbvgfTVF4v6qIXQ>
X-ME-Received: <xmr:DAyFacd-2JfxMzkb_0FXkfLZC9p1d4_k8w7VAHgMrrBR-XG53WexwnZ7-coLq-kTegM2JTtg-TvvilBwULehDTfyXpqRK3Y>
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
X-ME-Proxy: <xmx:DAyFaVq8WkxD8JRd-whn3B2Pu0UWtbpTqzTuHZPhKLM4X529yhACig>
 <xmx:DAyFaa4WUevozUKv_u79BtvnnkUkiSmUC55IicuN9C4XAayTnfPKqw>
 <xmx:DAyFabp_GcHSjuiqZ3h75Ytv36RmpUihBqIoM66hd33XpEU_zUTDBg>
 <xmx:DAyFacj5dZbkZGC9zTJkOZ69MK8M0hxLwZRxw0yZhQrvjfCzg9Bh6g>
 <xmx:DAyFaZC9Oay5XWJ354x5VQW2Gh6ivQ8hv3VdX8qtyVwUuG-xN7tNERle>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:30:52 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 01/11] mem: check fbarray name truncation in secondary
 process
Date: Thu,  5 Feb 2026 22:27:33 +0100
Message-ID: <20260205213044.702908-2-thomas@monjalon.net>
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

When compiling in debug mode, the format-truncation check
raises a warning:

In function 'secondary_msl_create_walk':
     lib/eal/linux/eal_memalloc.c:1401:50:
     error: '%i' directive output may be truncated writing
     between 1 and 11 bytes into a region of size between 0 and 63
     [-Werror=format-truncation=]
     note: 'snprintf' output between 3 and 76 bytes
     into a destination of size 64
 1401 |         snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%i",
 1402 |                 primary_msl->memseg_arr.name, getpid());

This is a new warning enabled in DPDK 26.03.
It is solved by checking the return of snprintf.

Bugzilla ID: 1878

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/linux/eal_memalloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index d9e8ea76b9..4dee224ac5 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -1398,8 +1398,13 @@ secondary_msl_create_walk(const struct rte_memseg_list *msl,
 	local_msl = &local_memsegs[msl_idx];
 
 	/* create distinct fbarrays for each secondary */
-	snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%i",
+	ret = snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%i",
 		primary_msl->memseg_arr.name, getpid());
+	if (ret >= RTE_FBARRAY_NAME_LEN) {
+		EAL_LOG(ERR, "fbarray name %s_%i is too long",
+				primary_msl->memseg_arr.name, getpid());
+		return -1;
+	}
 
 	ret = rte_fbarray_init(&local_msl->memseg_arr, name,
 		primary_msl->memseg_arr.len,
-- 
2.52.0

