Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18308ECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACAF34060C;
	Thu,  5 Feb 2026 22:30:58 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 35481402E4
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:30:57 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A98871400135;
 Thu,  5 Feb 2026 16:30:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Thu, 05 Feb 2026 16:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327056; x=
 1770413456; bh=8q3bER4XuD6Xv/qR40Daad261tuBP/DfpjrIZBDcz78=; b=C
 WhMyqulPyQHJ3X5V+I5t7uQ2DfFbkNcq0U7mhWUgXqj4l4YYSQUmB2WFjpFjEze+
 qpCSQkkzWGOGSt5tb2HUPdRMRHns1UtzTpXVXAS+9w5Amzeuf/cCSXTn2yfXoxfI
 ySsH6X8jIMcrjkgBhsmjBszwTxPw5cwIZhTMHxn9CZJ32TuSucj676qxWaC/Tugo
 +g2qs724C8QbaalSK6sXoZu6QcJbJnxgGXStvVAwzmfNFqa+wANQQCw2bnJB225B
 D13L9JZpW1MoEtpApzU2b9H0jk4AGttsIF3nQwheOST43jas7ntbZOoIAAa/r5Kt
 cUM8uOaqUN/zK7OAFZ0WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327056; x=1770413456; bh=8
 q3bER4XuD6Xv/qR40Daad261tuBP/DfpjrIZBDcz78=; b=bbufTn94n4865IXYN
 T033/5kA1a7iREo1w+xSCL2mjrANiumJjkP/tI/bAkEOMRNyk28sKGDkxGATiYmx
 am76ZtRyT/ly5wYT/VuI6HX/3N08G2bqHQonfwea+L/41DutE7w+xFM0GbC28LEr
 D9+q7CJdDZ9D0WDMDAbJvTr3WPFGFC/RJ7I0rhIRpABfP56yL4C170aSa5KbPvw4
 zdFzLRJKlrDwIROeo3EBMFcutF+oHnlM9OJfc5YcBr+6p6duTYmTv/FJPNTNATrd
 NflOEWHMQvWdpg/mVSuc4hzytNMqYpa1u/aVtI2t9wNxgplmmN+UtQ2UlmtUhiaB
 P+DPA==
X-ME-Sender: <xms:EAyFaVknlsRZ5BJF22RfGFF_pFN7Aj3gAyFk_7ayUclNE0gQJROMuQ>
 <xme:EAyFaVKi7KwrGNx0n-emA0zOhxfWERRCc7tU7wgoYDrjAgQJI8QFQlxPtW3VqirlL
 7znukFx--GLMvWvv05wXIUV_hnVXfuqu2DiuX0pVSgQsabKZWnoIzU>
X-ME-Received: <xmr:EAyFaax7w9WCKNvTKJLXGnr8sKaDGxJNmeb_CvRLF6ymCGWgcxsxle_Duj0QRd5DJmj2dBbx1ZxzpELiyIovSfZH6WfmSNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:EAyFadsnuoGx0SdDTsIs2u3zKqiAOtSv8s9d2s5NVnzd78tXReWBpw>
 <xmx:EAyFaZvCc1hjlosfXuMulJhFrhvRjEciUMjN9KwlDphG-s2tTHwtyA>
 <xmx:EAyFaaOhz2NtHq3h-Q0YyD8buuo2Oc9awTpjGc8GM10t7yUo5c97Bw>
 <xmx:EAyFaf2_RdGCqUOFDwsKOcKVyalnxHvgnWFYDBXQ_J7nNWYz-c7qfQ>
 <xmx:EAyFaWoNPNvi02aB8zMhg9h92tPrwrpyfnPmDMIXKv4q0sFt5-pqKoXq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:30:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v4 03/11] argparse: fix minsize build
Date: Thu,  5 Feb 2026 22:27:35 +0100
Message-ID: <20260205213044.702908-4-thomas@monjalon.net>
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

In function 'parse_args', lib/argparse/rte_argparse.c:764:31: error:
'arg_idx' may be used uninitialized [-Werror=maybe-uninitialized]
  764 | if (arg_parsed[arg_idx] && !arg_attr_flag_multi(arg)) {
      |               ^

It looks to be a compiler issue because we are not supposed
to reach this point in case of find_option_arg() failure.

The variable is initialized to allow compiling with "minsize" option.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/argparse/rte_argparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 9c3c5e7ae3..88c3e7740c 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -702,7 +702,7 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 	const char *arg_name;
 	size_t n_args_to_move;
 	char **args_to_move;
-	uint32_t arg_idx;
+	uint32_t arg_idx = 0;
 	char *curr_argv;
 	char *value;
 	int ret;
-- 
2.52.0

