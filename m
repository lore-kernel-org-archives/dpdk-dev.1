Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F047CAC582
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 21:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 100194066F;
	Mon,  8 Sep 2025 23:20:55 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 85F804066F;
 Mon,  8 Sep 2025 23:20:53 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3CFA7140017A;
 Mon,  8 Sep 2025 17:20:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 08 Sep 2025 17:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1757366453; x=
 1757452853; bh=XAxu5Mq/781QiwcX+fURCmF7sopjkXdwEwD+SXsCbiQ=; b=R
 EEUWXmVHa4y8qDF941hp1rwnVCs/YtRJqDRRPiuKmfZ7Pn4q4dgwc4jFraAakNm1
 gYcBdf/Oh3UM28jZG5G+Io63tsvClj0UpvpZVJl9TwCD5uA3ywLStv2+l5NnLyEC
 R2TjuaFKuy/nwLvAa64hHN+N5c5Ue7rhoEbgOO9GLpWLJ3hSrzOgZjSML1IAUDJK
 CSn/HiklPFAhcfSGfuPiPODVHOOQ6MsxNcnx3X1gOOQPimp0F2Jo2oyluK/bvSPS
 SIZZdRhqTvfQfe6EgAwnt21Yx2EIKzdvPNlCD1270gUSru4YUpa/rqhjlXMsIBt3
 2sr9GjGs5jFvrYS5aMZ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1757366453; x=1757452853; bh=X
 Axu5Mq/781QiwcX+fURCmF7sopjkXdwEwD+SXsCbiQ=; b=PU/lN6Uw0iLN47YxO
 91Fj/YdKnseIZ0+e2+zfGrNGcgUwvLBznPtEvRs4SnNXTSmi4lRymTfr5+y0TAQE
 iV4F2hjYwE2da6mJAEQLEHBpjoANBqv49IC7NVvrRIXstOiXeuYHzOjztG6x7BCy
 zCAuArx/gmkzWqE/C1gHKoE5MGsiJ2duQMJNq8oSrVI1TQeOZEAcxOzPuB2ffqCd
 iYMSzcx8yNMDtwhtPYgKIPLm2BHv6r2oDt8DQlyQr6T4RxcOTsyKvKLc+bXGc8hL
 zmdoDMMyaHgOlsH8rexsRQ5ApYrEvL1HXfPGG0+rl3GVYa/c0KJdkDURz+nZ+JrD
 X+nrQ==
X-ME-Sender: <xms:tUi_aKOZkHyaw9fCGTyDRJjGwKJOPrDvWiBJbkirOd9gSclNPqdHjw>
 <xme:tUi_aKjY5LiQWulj0jVwlZ-Aa3LYAz6OoGXdXrIMh8uAsOYhiDtgWCFmMOBoSuwvy
 D-bWW8czGITNAl4FA>
X-ME-Received: <xmr:tUi_aHkWwzbuXhYsNwHX3T81y5RAr1HNzpyJjcfd1MgSL5d8ld1lm7Pies7SQW1V8ZkrT-QKPDgdbyDZLGGO6i4X7jvdLIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeitdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepughsohhsnhhofihskh
 hisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhi
 ughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtph
 htthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhn
 ghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtg
 homh
X-ME-Proxy: <xmx:tUi_aGiAc7C7zGI2OfjdbB6vgdAqubXsYFliC9EzDMvSuJ1vFUT2oQ>
 <xmx:tUi_aKEd4KbdBo9FiEkGdWvXF7XPdPGlbmBFwRz8G53V0DRye0QGcw>
 <xmx:tUi_aIsblbIRKAeVeIx2ax28n0Mtz3X5No3bKRcv2JcRFrY-ugf4vw>
 <xmx:tUi_aLcTYsfVCWDpQRRvucASSHeM-B4Dj0x0CVgmJ2-QP7GnEhSuKQ>
 <xmx:tUi_aD_l93Qz6-WjE67xpY7bRXVHdDwqIqnJ3hf5NNsFT0r_fIpARqSF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:20:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Tal Shnaiderman <talshn@nvidia.com>
Subject: [PATCH v3 2/3] net/mlx5: fix build with MinGW 13
Date: Mon,  8 Sep 2025 23:17:50 +0200
Message-ID: <20250908212034.699713-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908212034.699713-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250908212034.699713-1-thomas@monjalon.net>
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

