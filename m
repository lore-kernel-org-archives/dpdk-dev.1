Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868DED25B47
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:00:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B0204066A;
	Wed, 28 Jan 2026 13:00:24 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 9A6324065E
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:00:22 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 283FE1400159;
 Wed, 28 Jan 2026 07:00:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 28 Jan 2026 07:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1769601622; x=
 1769688022; bh=t6LGLFH1ufgB+wwPp80w71BVBpTR61LSXSSDa2hbDNY=; b=c
 eT4NbqxkEAeLsW4cewJrPRk3m7Enmwu6vJHLGhMhwZjtILmiKFxMQVNcankHZKUO
 hbRtz6Ho1z/t9qHNEFQFryBhHdnFkPMQeD6eQ5zqIZjX6R4lWlufG+shTcNF8Wjf
 Na3R6S+EH710uedfD60lEcfZBJtP8vfrGKY0YWegAmnrVf2dPn6o7BLekucG/H/U
 kOTMYfyB+1ROtA0CRyF0TBn6fvA7ZFyNAoBg67YrqXOKqofrjB+hz+xRbPy4IuSo
 yc78RY/G7d9vNTIPGIKZWhjLGdOFuRCg4NxWiugE4FIsPql+QYAnEjoU4aV7qbIv
 3lmP9EO4rIwkcesX/vQ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769601622; x=1769688022; bh=t
 6LGLFH1ufgB+wwPp80w71BVBpTR61LSXSSDa2hbDNY=; b=NtfcpwDKADfDjVBx5
 La0KXwnp+S4ZJy7NM/F9HhixYoLYKxiYAUulvkhCQWHgqrxqU+j0OYL5m45wIPD3
 Mn1Z4rGoU6CtlNpHJOsvIPvPPT4MX2zuY3ziaweAegZOx6KsmrCrnX2O+w5x6KA8
 J8nh2DZvme+JiOfp4Du43faeREtLoUEd7N9HlV0XPfNFNrJUPL1XRi8vogJ8JPAd
 4cxfxjAGKVsVneCJblx880K8uUPUufp5JvhuoihkQOfqoUGX+JVRuKyRf2LH/had
 NixbDiMaAlFGHBGIOwVpLpBVK/Pan8uGZa5q9dxeoP1ksQN9wGUexbi7s1okOHgc
 DqQ3g==
X-ME-Sender: <xms:Vfp5aQwx3t9goDc1g_8rhwLIgDwTiDhGCF9bhlfl9A7PvqgyeGU1eA>
 <xme:Vfp5aYmVUy4trrHxpD7_CFQgngamgkj4vYcN36EKYmID9K3JP378dwK7qBAleavv2
 Ho2pPlOm8HB6312zZWWmJ0j5A0PmQt68XQhRYi3rjCEIgUVKOOxvQ>
X-ME-Received: <xmr:Vfp5aRd00FWVZvwWE0uiI7_aGOHGSDD4dMC5QgcHz6IXJHkQl6sqNdA8oQPVHNGUUqduDm4LRnva1nuXQDgs5ivAUdIpxuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeffedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Vfp5aWoPFHusJb1QsSb0XO4pW8xaWI8SmE0Ysb4lz3N0pMzCAlKWkw>
 <xmx:Vfp5aX7UmcMDPpNMfbGhSxHL6vQMvalGnOOjrcTZf_QvsUBV9SksCA>
 <xmx:Vfp5aUoxW45WgbYvRVzD3UPwylqYbd-EpYJJBxDiTOgIXa_WTXmf7g>
 <xmx:Vfp5aRj0tZF6PHiIX2DVbrF03qb6aZT2zQ4efC2Wkhui8NVPGcczmg>
 <xmx:Vvp5aRn1w3maAX1CUlHs2Eu0Rz9OwGKMiPBCIZt2WXqqt6h5PEB56O64>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 07:00:21 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v4 2/4] argparse: fix minsize build
Date: Wed, 28 Jan 2026 12:58:31 +0100
Message-ID: <20260128120005.2777473-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128120005.2777473-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260128120005.2777473-1-thomas@monjalon.net>
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
  764 |                 if (arg_parsed[arg_idx] && !arg_attr_flag_multi(arg)) {
      |                               ^

It looks to be a compiler issue because we are not supposed
to reach this point in case of find_option_arg() failure.

The variable is initialized to allow compiling with "minsize" option.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
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

