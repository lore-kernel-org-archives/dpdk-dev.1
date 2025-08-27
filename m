Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55384CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AA2D4065F;
	Wed, 27 Aug 2025 17:18:13 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 37F1F4065B;
 Wed, 27 Aug 2025 17:18:12 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id CBA54EC00BD;
 Wed, 27 Aug 2025 11:18:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 11:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756307891; x=
 1756394291; bh=JkuNee7NpO7ImVqhez+BzIGYcvNwQXX5P65D+/3m+m8=; b=d
 r/xgR5kucGY6UiijlyIlmFygS21j7LNjQov/IKd2fGuS2sbuMyq6A5ziFNUxDUhW
 6krTF3RbpuKCuYnL4UyVukFF79u3YzlnsDDwGZZAgg07gEXU9IioDo1Tfb1F5NRs
 kLSU0TlZJlmM6KyRl6OFl+aQ0dXVtkF76z9+XOlwrgzW8yXq4JjjyahrEG1iD1WW
 ScrrrUlYUmtKKwo0HS+U1fqiCta4loSJDE+GBQ197bHvFhW/s0UNqHhJ019LIh1u
 dlB0lpLF6vBm71HxWIxvhNG/mk+cpR26+FXpY87GBLRbXnhcXSDRaS4VEsczAWSY
 Zj74EbO3pZCFK150fZB7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756307891; x=1756394291; bh=J
 kuNee7NpO7ImVqhez+BzIGYcvNwQXX5P65D+/3m+m8=; b=K0QZBNMlgfr12ZqLY
 pnpK5+5UqfDJvyQ8j+m4OVyhSw9d+4RAfoAtZetJz+uxHjw62rVSwCELO2yFrcAA
 QI4utySTu3TFQmTnqSn0xRgbn5AXXSVEamyqfr/HKO0R6HiZlEwoSrAdiNxaJ7Ic
 G42G4/gPHf0fv59IDl8YWXyLzekhBbzgTOtvTSfyZFlEwYzzTzt8gbcML3YAA85N
 tAIfH9VIYHGOsFyNBzhMkTIdcsFk81EFttjnDpmdpbqE6UQEowH9LY7E9l26WfN9
 8tf2Q4+YoxoLpQd2eWjz9eEIncae0vZuki2PFrRzqczN6jlJF1VwHqJ5arthD2Ok
 IKFOg==
X-ME-Sender: <xms:syGvaH2bVZzQB_iSTcdESRLi40g4kw1SyhHAf8VieL2pAdoU4BclJA>
 <xme:syGvaHp-aABSCZMIXAlN86o0YlJTEbwROHvZTg0PnpoLi-OKz3bY0foRqIKN0ctf-
 Xmh2iOxbdfz80LmCA>
X-ME-Received: <xmr:syGvaONcY-rWrQv2r9dRmlFXC7GZCSUOhG5UT73OkLzF9jTJ-6KCEIGdmBInOd8-Ahn-MM9HGqLBL6YIUFw1Nw1BQSuUoF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekgeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegushhoshhnohifsh
 hkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhv
 ihguihgrrdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhrtg
 hpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhurghnmhhi
 nhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgrrd
 gtohhm
X-ME-Proxy: <xmx:syGvaIq3rAASy6PJPp5RkpddtIZxYVV6-KDGtTvLR9Pn6xQ5raxWkQ>
 <xmx:syGvaBsjHYaA6eE-rrV2a_pEb_bBpfi_c-jDvQ4fPCgneGMWcp3-fw>
 <xmx:syGvaH0M9Gp3JuU-TWfRdtdbF7zNHnok1K5BDvkNoxsOIgBF-znQuQ>
 <xmx:syGvaMEWYI-J9slmz_XarRguI77sHVmckTxaT-VJf6UL2R0EkNIh1Q>
 <xmx:syGvaPlE5AncSTAz33hMnphUag8OH3rNG3luSy89QnPuvZpRhEdm2ICF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 11:18:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Tal Shnaiderman <talshn@nvidia.com>
Subject: [PATCH v2 2/3] net/mlx5: fix build with MinGW 13
Date: Wed, 27 Aug 2025 17:16:42 +0200
Message-ID: <20250827151759.1448018-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827151759.1448018-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250827151759.1448018-1-thomas@monjalon.net>
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

After an upgrade to MinGW version 13, compilation breaks:

drivers/net/mlx5/windows/mlx5_ethdev_os.c:285:69: error:
	'dev_link.<U1000>.<Uaf00>.link_autoneg' may be used uninitialized

This is because link_autoneg is never set in mlx5_link_update().
It can be set to the previous value (no change).
Also it does not make sense to check this value to return the update status
as it does not change.

Fixes: 6fbd73709ee4 ("net/mlx5: support link update on Windows")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/mlx5/windows/mlx5_ethdev_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/windows/mlx5_ethdev_os.c b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
index 49f750be68..c82ce6cbda 100644
--- a/drivers/net/mlx5/windows/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
@@ -283,11 +283,11 @@ mlx5_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 	dev_link.link_duplex = 1;
 	if (dev->data->dev_link.link_speed != dev_link.link_speed ||
 	    dev->data->dev_link.link_duplex != dev_link.link_duplex ||
-	    dev->data->dev_link.link_autoneg != dev_link.link_autoneg ||
 	    dev->data->dev_link.link_status != dev_link.link_status)
 		ret = 1;
 	else
 		ret = 0;
+	dev_link.link_autoneg = dev->data->dev_link.link_autoneg;
 	dev->data->dev_link = dev_link;
 	return ret;
 }
-- 
2.47.1

