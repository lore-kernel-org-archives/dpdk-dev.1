Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2360C44503
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 11:08:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE9AC427D1;
	Wed, 21 Jan 2026 12:08:09 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id AF52E400D7;
 Wed, 21 Jan 2026 12:08:08 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 2BBDDEC00D6;
 Wed, 21 Jan 2026 06:08:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 06:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1768993688; x=
 1769080088; bh=AS3ZDHnZd9DcmA9TN+9xeHjqJb/PEXpHdhL6TTQddVU=; b=T
 9Di9vVfhSlXbgqN0Otdgnx1DQXNLbtqFJNuscD8sRWGe4U0chaIyR3rMqJAlWhBq
 jlzi6zoNl6mepLtFcav03O5x1EwfjEasEsJKu2C8vwlhxlVENFQQ6JU36uspbzDa
 tLJQ9NU80ZBejya77b2l198txt9U3WR/4B9eZR5kEhzs8RTO+sJRVu5GYhweA2jK
 m4x3Kt4h9PIK3H0UYLow47gEwSTCKkjVjtoxp1ikrCZYrp0Liuaw5wxc6povNE4h
 VlARUhGrF0G0IYzFLeL8cpCdeGQzn9rXGdj+mw3q0Ze/0S6dkTneUISZ6Bl6YfjW
 WgEc8dQVB3jWZjz0ISIaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768993688; x=1769080088; bh=A
 S3ZDHnZd9DcmA9TN+9xeHjqJb/PEXpHdhL6TTQddVU=; b=lmh69R77EZQg3kBNl
 Av/KrAEdSgc//BRhE5Rr1JH7ti9BZiW4DHegrL5tVZmz83PnXikLYO7K0fOO8JNJ
 2zU3k5RQndRxhd935xdf4qOp7waUpb9AjvwEGwHX/mTSk0Y7WEO8QavOwApUegzM
 QZ1+QXyNLylslrTKSB8A2iaZm69DeDbWeYcotXvpoil1ue2QKHjrz8HR5Uc3/tVO
 PypAoDu+/ORSXHeMLO+AIO/smKaGV3QPz9s08vUk13646Uozpm7Y6I+xoIbbnVSh
 7HXp9K2eXOOCFxG5XNeqkemHMx2UcRfI+4TcomI9e/WeiA9HzJL46bkU2b14k1TA
 s5vew==
X-ME-Sender: <xms:mLNwaYJ0S-UfHEwceIC7QaOb1ew-kNlLS4xEEiUwyZMazNwulzGdUA>
 <xme:mLNwaVjQZSO1j-f6iFJ9dp10_YmzxD_VlwPUxNjF0n5nmWOXs8Ti33JkI6onUq1Mz
 VwDmkGJ8uq0QdmMRXKRaGhs7wBlE0VjOCDMx_EPwIyopLaRoDdkCg>
X-ME-Received: <xmr:mLNwaSPWGq-pjEqEuNcD-CggJtnwK54kRvIahiCWBNZorWoOyue4sI8Bxnzui-XhyjJfFJ8vdSb1g7wew8nJR5IpA9Rz0VU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduuddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtth
 hopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepughsohhsnhhofihskhhi
 sehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiug
 hirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphht
 thhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhngh
 hmsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:mLNwaQphj_bPCBbV8MTTjhS2r8Nt95DAanofBgVT2pqb9HcN988g0w>
 <xmx:mLNwaU7T609udY8-McVx6MSSGbzXPLpaMF9OoZpg9Bk7X4v_mZGSww>
 <xmx:mLNwaehPd06qF-jfASjPyLOmQRwfNrRlKvyz1B3OL_gfAUH3ZbdI7A>
 <xmx:mLNwaa5IXGsMU0M4ILqCj1Y2xO4hj2Jz9GSxIsXQ85ZwpsrBNrTf7g>
 <xmx:mLNwab9J117XVZPfQVEBFORFmC92NuRKXHD_Az1ZxdnNM2uOLw-AEF5C>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 06:08:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, david.marchand@redhat.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Ophir Munk <ophirmu@nvidia.com>
Subject: [PATCH 1/2] common/mlx5: fix variable shadowing
Date: Wed, 21 Jan 2026 12:06:00 +0100
Message-ID: <20260121110757.1948723-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121110757.1948723-1-thomas@monjalon.net>
References: <20260121110757.1948723-1-thomas@monjalon.net>
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

The word "unused" is too common for being used in a header.
There is a warning because a parameter is named "unused" in mbuf:

lib/mbuf/rte_mbuf.h: In function 'rte_mbuf_tx_offload':
error: declaration of 'unused' shadows a previous local [-Werror=shadow]
 1910 |         uint64_t ol3, uint64_t ol2, uint64_t unused)
      |                                     ~~~~~~~~~^~~~~~

Such value should be prefixed with "MLX5".

Fixes: bd935fe3e624 ("net/mlx5: wrap sampling actions per OS")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/common/mlx5/windows/mlx5_glue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/windows/mlx5_glue.h b/drivers/common/mlx5/windows/mlx5_glue.h
index 5ba324ebc4..f53142e3d4 100644
--- a/drivers/common/mlx5/windows/mlx5_glue.h
+++ b/drivers/common/mlx5/windows/mlx5_glue.h
@@ -16,7 +16,7 @@
 #endif
 
 #ifndef HAVE_MLX5DV_DR
-enum  mlx5dv_dr_domain_type { unused, };
+enum  mlx5dv_dr_domain_type { MLX5_UNUSED_DOMAIN_TYPE };
 struct mlx5dv_dr_domain;
 struct mlx5dv_dr_action;
 #endif
-- 
2.52.0

