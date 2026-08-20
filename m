Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3661EC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C78340DDD;
	Thu, 20 Aug 2026 07:24:45 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 6782E40B97
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:44 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso15352635ad.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203483;
 x=1787808283; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4e7PMaXchKEogp78c9n2uHg/bt4VKDjcNSfxXQnxzP4=;
 b=pq2eW3ipUOmcvrzKKuHuQnIFzrXEay+0ODxxRUU7cSJQQuyYkCwNF4QN8saL5O0U9P
 5wTyr1YWvJc1Xda3U3/ZzcG9dxO1Fvy20NUwW2WL9oTaPtgRdamrdqeefshPgx1snEzs
 FHYUfOfGvtQwpKUvsLvFjNZ+D2yLfFJZUdG0GzVxzeymJ9FvL+wHb1yVJ/1abjzG7TAN
 3wrpOaB0xSHh2Xu9mVo4HZomm3YcloFEy7SaerPxrtm8yvnUKvOEFeb1WnQvsMGgHtWH
 UgLmEVjcXwn2waLoPNBOzlv/Zu6yXtaVyNEqZqJDtIAqMsrvMGvtfuu+fFaTWnQ7aA1U
 vP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203483; x=1787808283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4e7PMaXchKEogp78c9n2uHg/bt4VKDjcNSfxXQnxzP4=;
 b=CteI8Sv20Ug1uG1fjb+zXma4HBSzuYjyPxwzWuTZKA4OUPlw/oYDZAJpcUCsotOXtW
 P1isHRQTL6zHDdgxCKK+vXzeOCaH32e3YiWtLAJhqNEO0nO0Vw/gWj4hh2Ok27e26bEV
 XpRZkGou0jUbiVNIw8hYxHU6U/3ydfU6tMreXssZ2NJdn8IdCbA6TmiKi/aThTfcVUCT
 4D8sjnriTXwVXDq6mol7Abc956rzI2NzJOXVv+VPZuzkNnp0rGVcwZJnD0vML+nfGe5n
 Qqv3Ze6BuoddYeelk1/WwuYRM35/XS1zkxVp+6dd8v+B2AkzvIlRUUakayKLDBD5AgpY
 B5nw==
X-Gm-Message-State: AFuF++libR6rJiFGgEHfud3dg/tLAd7/3cBIcukPjQIC/LzLrdzj/v1Q
 S60vxPNdJNc4w+/NaiL2ym9lrdM7l0fDc/PUfLVQHLqRjst0p0rFp2vZqB6yOjLtuJwYUTp7eGB
 QxcSw
X-Gm-Gg: AR+sD11Gb0UMfHH3aVnsLtPnPi3A8glT0nfXJnQpq/B+8lxLfQpSLhpuGu8gLFZRHi8
 AaZgtj9ut7mqyzEpXcjOSF/9ksQai1+8K4XgBwx/NyF11reW9X6d5tnaQVAXimRmK9jVjSZkWR2
 jA9OzzL5jlwulsZRnG0MGFiVjF+3Dgak1MMUueoyWWbr5zPa0xh+kF5mDdc6lDiRc5U9+lLDmu4
 Q0nRur2BucLPcp/Sflfl4VubjzNTSz/iDf5D6jK71yXXUrXIv5K3A9SZrF24Zo5bq5GKTrkAjyN
 0vJ8xakqoljm+SX5cuBj+xeZ2Kg3r2/ypMofXN/FS2Z4xFTug8qwJQpy7NC+scEP3JsxdsQyrxw
 NcgtkuDlT354F4TkBxNmvq4jhpU5fbP6so/LHXmq26V3TRWfjdevCh1tlaHOZhek1llI9uRd1NL
 JpWtxVziI8hQPhyHtnSuavZrYiBxLHu98lUZm2mWMbLJxFs+bFbL6W7JgrX0PcMGRRE6BZ1VtCF
 pRDCaCivEEyg45AJOmVvF5EQn0=
X-Received: by 2002:a17:90b:3145:b0:395:5f43:4ec4 with SMTP id
 98e67ed59e1d1-39580ab3df7mr17450141a91.0.1787203483537; 
 Wed, 19 Aug 2026 22:24:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH 27/61] net/failsafe: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:17 -0700
Message-ID: <20260820052251.1453273-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

