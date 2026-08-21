Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0C6C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02DAE40DD0;
	Fri, 21 Aug 2026 21:30:01 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7F54E40E01
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:59 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso797873b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340599;
 x=1787945399; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4e7PMaXchKEogp78c9n2uHg/bt4VKDjcNSfxXQnxzP4=;
 b=EfqeK7M5ywn2Z6qeoEMqUVHEDFd5r4VKs7s4FNIXTTf9hEtuW6n+VK1QpZZHtRmCU5
 xO9gYC+D/A8rtJOYWlDg1QE5SxR1MFgvLezgTU2740t3wdFBTwvyN3q2+94GjBn9wii1
 GKtatRbhLBEbr8YyPVzvrZSeQkudwLxNZh08926nvl7EarFc/ksd1ZrB+yfiFyWSWfIa
 nxdxdTXL4Nc4DVqsNxKwnHt/UGnHf0z4afja7aFFaoW21cg5JeS6VKOyWGlWQFWwqABr
 j1cGhKEEsPo8gD/36OCTzuKHb3bXZsdzhE05uDAyujNHQ60Fc5DCqsCJORTeAxLxKApl
 haeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340599; x=1787945399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4e7PMaXchKEogp78c9n2uHg/bt4VKDjcNSfxXQnxzP4=;
 b=Nrazpn6RrFfjT6J2GRLzrSs449yQlQizVhdIgmQIP3dh1HrvTEPTkz0pqA1PBevUyX
 3bgv9lck7p3FnZm2EbE8e2XFnWhXm8wiXzU4MzPCJU4LcXkvW9xPjlzCdlF7pmSnvujg
 TaJ03Jmmc0Wof4Urg3XejfJ4xDGLdu+jmujbMsxgjHzc8kI9LjHTBGUQDqk8JtiYJDAf
 578J05WZBf74bVSuWxc7/m1ce017zfFhr91dVSeyQ7gePGi5LmkTnwb83AnwpU0yrfHX
 oBlMZdVQX+3WeF2cqghSVfrLpJ3f9NdKjV15CEcWKuYsseFHuDg+b0MtZ7n5gg+2SjnA
 kPnw==
X-Gm-Message-State: AFuF++nuaQ3D40jCzHLTAmvy7KRd2pYQE2f8ObOrM3d/tbFejFCk+/a0
 9CD8qb4SaBcc2Xkc1GxNErp+xKQYkZGcU+WvvIt+u6121fz8OrfMQ/KAn8AwRHIHeX6eTvH1Igk
 jAFNY+1I=
X-Gm-Gg: AR+sD11LprOEHxjBoiyjViRZB7N5A5bVp+afhJRBD2kLpIg27nBma21b+PeaQRbECMn
 sgOsNCeM6ZeO5CU+YxKxCjPMY46lRjZwWC+VoQ6nNAnRh+LLV6qkJmLpvuGa4hZGO6H/+BEbvZK
 cuuGsXqtssIpX4oUwe3wAUEtKvXD66BoEjaf4cYjhQD047vauLbuU7RxgdY+FSvZjIgMP5+uKSJ
 xw6jCN8kEgOk9KngCZQAZ4ecHQrcXbB+FGpZ8Ot98u/LtPj1L/BeTgtpl9JioXjnFTRENv8afMA
 cz7SB3xfbFyJHTgbIFejq5/QIa00hCgFKX7XOffLxUWzromSAcDhlT5TP/rp43G2TRC7L1busW4
 wibZmAA1f+KCK4Ezj7Phs35jhoPv354bz/iQ93q98ozuOyhn/SqVv/IDTDqIMEx31yrKtNZnanr
 hNLi4UR1TQmoIrWK3yKDaxyrvYSAsMr5pxzoxaI/LlR31XXwW2txdqlM2ObD0FGqe0sLmDxFu7R
 SC83yvA+VWtCXr9EV+iXxK5XvE=
X-Received: by 2002:a05:6a21:918a:b0:3cc:841d:bb26 with SMTP id
 adf61e73a8af0-3cd301379e2mr16142674637.15.1787340598709; 
 Fri, 21 Aug 2026 12:29:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v2 34/68] net/failsafe: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:29 -0700
Message-ID: <20260821192646.146382-35-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for addresses in control path.

The use of rte_memcpy() when saving the multicast address list is
control path only. Regular memcpy() has no performance disadvantage
there and gets more compile time checking of the arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe_ops.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index ddc8808ebe..f393476571 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -909,16 +909,16 @@ fs_stats_get(struct rte_eth_dev *dev,
 	ret = fs_lock(dev, 0);
 	if (ret != 0)
 		return ret;
-	rte_memcpy(stats, &PRIV(dev)->stats_accumulator, sizeof(*stats));
+	memcpy(stats, &PRIV(dev)->stats_accumulator, sizeof(*stats));
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
 		struct rte_eth_stats *snapshot = &sdev->stats_snapshot.stats;
 		uint64_t *timestamp = &sdev->stats_snapshot.timestamp;
 
-		rte_memcpy(&backup, snapshot, sizeof(backup));
+		memcpy(&backup, snapshot, sizeof(backup));
 		ret = rte_eth_stats_get(PORT_ID(sdev), snapshot);
 		if (ret) {
 			if (!fs_err(sdev, ret)) {
-				rte_memcpy(snapshot, &backup, sizeof(backup));
+				memcpy(snapshot, &backup, sizeof(backup));
 				goto inc;
 			}
 			ERROR("Operation rte_eth_stats_get failed for sub_device %d with error %d",
@@ -1523,8 +1523,8 @@ fs_set_mc_addr_list(struct rte_eth_dev *dev,
 		ret = -ENOMEM;
 		goto rollback;
 	}
-	rte_memcpy(mcast_addrs, mc_addr_set,
-		   nb_mc_addr * sizeof(PRIV(dev)->mcast_addrs[0]));
+	memcpy(mcast_addrs, mc_addr_set,
+	       nb_mc_addr * sizeof(PRIV(dev)->mcast_addrs[0]));
 	PRIV(dev)->nb_mcast_addr = nb_mc_addr;
 	PRIV(dev)->mcast_addrs = mcast_addrs;
 
-- 
2.53.0

