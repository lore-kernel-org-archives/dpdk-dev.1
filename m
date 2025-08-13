Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A169C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:29:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20DF040EF0;
	Wed, 13 Aug 2025 17:29:05 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 115D140265;
 Wed, 13 Aug 2025 17:29:04 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 82A9E1400156;
 Wed, 13 Aug 2025 11:29:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 13 Aug 2025 11:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1755098943; x=
 1755185343; bh=7cLfDD0BjIjYseErQcNPoz/iHEejMIAX3HEgtEwOblg=; b=N
 0u2LZvvA4DHOqjDKHQnujxlpcVsh4kq2q55dobHIUaOZIY5M1rsQhVEwjzP2NjOp
 DVWmJfUVtVm+Yc29BI0CMXzY2o20sxkZGsbtVryNo2YPcIuY+FAEI/kCu5Phx/EJ
 iDbUXGD3bMRfXYYXNorC+BN25lQ5mmnW7bGtM0LDtH49X4x0OsXxQOdb9ce6FeAZ
 N5panqRzap9zLhY4juTVsgSmc6JJq78FvpxZ+T9dzG/CanC1AohjCLw1j6wjgNo2
 FhPDL7/1CHpZY8iecX2Z3UeXsgwDmiQMCeX+22BuKdotH7ZC2ZHE/YQkcrm4HN4l
 NgFzr/G9TRuAMNtzhFg8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1755098943; x=1755185343; bh=7
 cLfDD0BjIjYseErQcNPoz/iHEejMIAX3HEgtEwOblg=; b=bzrma1JeGU5NkqAg5
 GjO3eMu+gFGYqNLhE/MSMVY6hHQnOIkEhwKli2C5IUYPmi9RdeL7YrHa1hGjHdg8
 RZdElpJHdI6X8L3mgOLn8YlKgYO9oeTq0JC0fZ7bH2yHib4kH7sy/HYS2ZWmWQVu
 GspqQGGxwWV601U7r2SrOGyz4TeGS6ZsY6qItA40s539cBuv17i1FNafKMNkAfWU
 d0F3oKvTytaBAi4wFxXqmW26cs876VOfmnJBOgTLz+Yzy3KPmSI1oaQCKuTub2Ki
 BLzecF5v1T5wJt8TdgsQIN5mARa/TmtDSS3OW1K5Lfe4Hwn7t4LWw31I50VXumlq
 lnhHg==
X-ME-Sender: <xms:P6-caKk3oYpRtT37HOwidqtMsq3abdn9cEXCDyRGkO6ZdEdUnjAlyA>
 <xme:P6-caInZNT_eI8KD3rDgJpfPs4zKiIh1Jqvc03-f-QkH3LQbwtEfzTR6ZYkRipiWi
 6mLv2GGpowXYTLRLA>
X-ME-Received: <xmr:P6-caKaVXtakhxtjtC3xvx6Yrkqpdg0zbItb0h_-cGi2ycXMA-eYH5hRtI7E7KUHY5H8UKyyYQ9n70S4wnXA-cDpx80-WWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepughsohhsnhhofihs
 khhisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvh
 hiughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgt
 phhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmih
 hnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdr
 tghomhdprhgtphhtthhopehtrghlshhhnhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:P6-caKSw3rC-U_vpF8TtaqFAlsqMo-M3BZiz901shLRRiezgJqNJhg>
 <xmx:P6-caEtDQX4oT6XQm06lEsminQEJpxU5vX5eV-HO1otEynOPdHWdeQ>
 <xmx:P6-caME44_gCeJBAsOHqncGGYotjH6dAIE5_35meYTkJHzBzu1P8ug>
 <xmx:P6-caFxGSt8qhSUwqc_GogQYd9IuXHesUG7MNwPmfj8OcaK99QLRJg>
 <xmx:P6-caBtY3W6jo77--wsCBeiwnNHlvF0veqrFV7oQA8yHT5Ay92b5_q-1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 11:29:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Tal Shnaiderman <talshn@nvidia.com>
Subject: [PATCH 2/3] net/mlx5: fix build with MinGW 13
Date: Wed, 13 Aug 2025 17:25:24 +0200
Message-ID: <20250813152829.457463-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250813152829.457463-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
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

