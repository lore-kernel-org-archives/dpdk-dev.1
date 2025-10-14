Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BC0CCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:15:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61A054065A;
	Tue, 14 Oct 2025 11:15:57 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id D742E402AE;
 Tue, 14 Oct 2025 11:15:55 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 71D3D14001B8;
 Tue, 14 Oct 2025 05:15:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 05:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760433355; x=
 1760519755; bh=XAxu5Mq/781QiwcX+fURCmF7sopjkXdwEwD+SXsCbiQ=; b=F
 Ybi1Sb8tIckgCyq34zwn8+36+7UhgNzM+AQ+T0Xr6cbDLFwMViw/GWT4ZHG3c7DM
 7zu+0v3pXqzThBdM9kpXdpEeFAYgiu/vsB7pSl+J2HfIGNZRszZsIQ9U9iC7xN8e
 FMqo8Rez9DqVfxirNGx8rBi4J+CNvqVKKeFQOVsMxeAnXyiNtACKl6NFWf6p8T3x
 gJqdgnvpUWy7tkHrHBwA9XaUyHSUq4fsiwUYpJSoYdxeXKoZlvG1rM2cXlJnc872
 v4gQH+pwBtc1SGbkGq5QHlTLMVOsvFUOZ/F5e9+IzJ4o+gj4fFRoeybeRmelD6gN
 zliPfNYrCYGuoyW6nuydQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760433355; x=1760519755; bh=X
 Axu5Mq/781QiwcX+fURCmF7sopjkXdwEwD+SXsCbiQ=; b=Tn0aVY2s9Qtzwg7qm
 uyYI1Yc8MWA4hQ7sH5ER2Jcuv2VpTyjGXcYcPqMiQssc9TN7GY8ZSHBdxS4l+AlD
 o4WipnNdVzhh4CEB9EI5Tl8MV/TpYihFUmT1VrD73y50YpLNmtCjs2P7bk3P7nJ1
 GKtrwhfhB5oqnIf4XEZWPqeS49QHfrZITW8FKCk3Lb6Bsbyxib7SkKJIrXVmD0v0
 9jsqhhtQF9oxsGnZ+LpTf/0/1h8MDsyTck9p5t3ZNJ9uTqarW62ptSSJyLfz9yps
 40rQLevPp829uLaKlYU8svk8MomXQ7iXmhLVMbMwQH2Bpm2BGG7JFBbZcImewB4i
 4CwCA==
X-ME-Sender: <xms:yxTuaG1_wQcJeyF3guF5JUcuolf86pQBanBMGApQqjs6ctFtCnqWsA>
 <xme:yxTuaJjl_DX_NsOy2I8HBqvYf-AmPWQUYDA9EUiPcPRGBQucvAWe4uU1HJhTLETgK
 prL3wauMIPyde0wmenHv4P_Ate1KXuTCtH9b5JtTaBZr1_fU0-ofA>
X-ME-Received: <xmr:yxTuaPlNG3QlfDrnNzT_1gzAOZt1IbBL9KBoVhiWRqpmqiwuMdvOg7XklkzgvMoQnXMFBVR9Cn19fP4f_KWDNSuqNA_tuUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:yxTuaPbPBT_-tfgwbfunxl5gId69O6-Ajyi1JWvfO9x229O5eRSB5Q>
 <xmx:yxTuaKHIvowsAKl7V-agsk_2V6LH9ult4RDdeBwrWVoDyWhJY4nklA>
 <xmx:yxTuaOYTXRj3q7qJAyq86zJ-NrbX2rPRDpyI1aNRRMvNIWTzxyW8vQ>
 <xmx:yxTuaOz0pyf9jN4s08wy2ZdiDOyj91BAefGAdmAcjDGPRj6kKvG82A>
 <xmx:yxTuaGRJUBo3wYHtCkYmzUKiYGxrQeYQb3XPDqtK-EQMLlF0eqxbJvJ6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:15:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Tal Shnaiderman <talshn@nvidia.com>
Subject: [PATCH v4 2/3] net/mlx5: fix build with MinGW 13
Date: Tue, 14 Oct 2025 11:14:00 +0200
Message-ID: <20251014091528.936405-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014091528.936405-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20251014091528.936405-1-thomas@monjalon.net>
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
index 32a9f599b2..e24ff367af 100644
--- a/drivers/net/mlx5/windows/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/windows/mlx5_ethdev_os.c
@@ -311,11 +311,11 @@ mlx5_link_update(struct rte_eth_dev *dev, int wait_to_complete)
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
2.51.0

