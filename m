Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626E4C77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 11:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CDE14067C;
	Tue, 24 Jun 2025 13:27:04 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 009A340264
 for <dev@dpdk.org>; Tue, 24 Jun 2025 07:10:24 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2353a2bc210so42818465ad.2
 for <dev@dpdk.org>; Mon, 23 Jun 2025 22:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1750741823;
 x=1751346623; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=26bX2qGFgbuo6FmnJ50p3bVj3RXWcnJ/RhZ3phH6XlI=;
 b=S8YYgqAXj7gGk1eUseDQbgkKyl6wfZjPWhlSgFUlW5xyvm3blUQxxg73BDDr8xThcN
 +Y4SEES4WUPMCPsBLAyp+nadkPzxWGQ/lNK6nUFp5Rno4NAcUblgiZqyuS5KO5soQcyY
 ygEWZ4X4ngULf21r0S0uZ89eThsgIlc/3frMOpztTHlA4YJ86gNTI4glEJ+r3zH60eZj
 wrvCj5ZA6NJBv5nT/44WIYOzjnoxzUYvdHoLKiu5OogzTevbFA6Gd/qX0kzod7YhaVne
 Pnj6rflnNN7CTiHQgiebo/dbQ6KGkUWZdiOcQkaYSQUHh0FVWVppj1WxNVVeBoRyo6U6
 JCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750741823; x=1751346623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26bX2qGFgbuo6FmnJ50p3bVj3RXWcnJ/RhZ3phH6XlI=;
 b=WYzHRy2DHeJcdiDIbtF6BOWe7x9lKYAapmk5geMGIeNVBDOdqf8gPCmaRV1DZbbqGK
 v0NT3dqLVCs/Gf1WGWm9l71xEUPGFrHFlQ36AvuD5PqG8l4R1Tk146EymfbWH7rgN1hF
 RGtqW76jkCx3qgdcweQDHMvSdUw4q4zDOMthXjjDQYIgwpnABAfyv5jFuIJEq8Rhtl1F
 Aw9Fzox8ZUj6jBfehxHAQTMeI7voalGAlPYBwTBNM0i1vxb0yrco69ZdB/xLHwgPBmm/
 XCUFn7NoaVi8tVCn+I+wtbvqpOazoDqooR3YCUbUiSFBMHgRa/ftz5+/xapiBD1HcpF6
 AQbg==
X-Gm-Message-State: AOJu0YxAeFEwNSkmfDwznZcxRATBgXwYOsQo2WNOhhYejFNdBFhFUg+S
 5hPYOOoayzjlV3IzbBuTMaJnwQu0xn+nMDa0Rh6yLPUL37KYks3Hpnuy2eRPTj1ZNqvWTbRPq4d
 jkqdfF0Bfkw==
X-Gm-Gg: ASbGncvTcW0ue9QCyh6C+BInhRRrdUACmpf23bnV5I6/cFh1v+nGlnNeMVeTvirwb8k
 51Hp+Aqdc8OYKHeYtgOnrB74+K5kjxOXXzqaMtLWgUj56w2E41Kj+T2IDDYb/wg1s13+VgQ4jM+
 QEYVkShUCqViy4OBVPupPLVHO2f1g4kac2ghWaMEHy6ScUbTX2S7cD7JwqxPewgw/SFnx3SyYjj
 G+8r6CZ9hZSOZAz7jBa+wm5aSltifee1Nq3wtLEu3Ie7Wc/Ao1SwK9oOTR8jEodPdP46yZMGEue
 UHdOTQYntTWtLc9gw5zx2mlvckrRjkLA4HPtT/3XPIbfmRBZJyOtZEVEF5TznHwrc2qYDrOKSac
 IK9hwqRvIJ0BU
X-Google-Smtp-Source: AGHT+IG7NKCuxEXPdnTNiDTG60pfXJmXGkryv+d4PUqaoKDRl2dzA03zvcj0iqow60H0nhaaZhY8PA==
X-Received: by 2002:a17:902:ec8c:b0:234:a139:1203 with SMTP id
 d9443c01a7336-237d9960355mr243693845ad.32.1750741823137; 
 Mon, 23 Jun 2025 22:10:23 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d839357csm99782035ad.6.2025.06.23.22.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 22:10:22 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org
Cc: rasland@nvidia.com,
	Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] net/mlx5: fix segfault on indirect action age query with
 conntrack
Date: Tue, 24 Jun 2025 01:10:15 -0400
Message-ID: <20250624051015.3145137-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Jun 2025 13:27:02 +0200
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

This patch fixes a segmentation fault that occurs when querying the
age action of an indirect flow rule using connection tracking.

Steps to reproduce:
 1. Create an indirect action:
    flow indirect_action 0 create ingress action conntrack / end

 2. Create a root flow rule with a jump:
    flow create 0 ingress pattern eth / ipv4 / tcp / end /
         actions jump group 3 / end

 3. Create a group 3 rule using the indirect action:
    flow create 0 group 3 ingress pattern eth / ipv4 / tcp / end /
         actions indirect 0 / jump group 5 / end

 4. Create a group 5 rule matching on conntrack state:
    flow create 0 group 5 ingress pattern eth / ipv4 / tcp /
         conntrack is 1 / end actions queue index 5 / end

 5. Querying the first rule causes a segmentation fault:
    flow query 0 1 age

This patch ensures proper handling of the indirect action with
conntrack to prevent this crash.

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 .mailmap                        | 1 +
 drivers/net/mlx5/mlx5_flow.c    | 2 ++
 drivers/net/mlx5/mlx5_flow_dv.c | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8483d96ec5..5c9ea95346 100644
--- a/.mailmap
+++ b/.mailmap
@@ -812,6 +812,7 @@ Kevin Scott <kevin.c.scott@intel.com>
 Kevin Traynor <ktraynor@redhat.com>
 Ke Xu <ke1.xu@intel.com>
 Ke Zhang <ke1x.zhang@intel.com>
+Khadem Ullah <14pwcse@uetpeshawar.edu.pk>
 Khoa To <khot@microsoft.com>
 Kiran KN <kirankn@juniper.net>
 Kiran Kumar K <kirankumark@marvell.com> <kkokkilagadda@caviumnetworks.com> <kiran.kokkilagadda@caviumnetworks.com>
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 3d49a2d833..5c799ea4ce 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -4550,6 +4550,8 @@ flow_aso_age_get_by_idx(struct rte_eth_dev *dev, uint32_t age_idx)
 	struct mlx5_aso_age_pool *pool;
 
 	rte_rwlock_read_lock(&mng->resize_rwl);
+	if (mng->pools == NULL)
+		return NULL;
 	pool = mng->pools[pool_idx];
 	rte_rwlock_read_unlock(&mng->resize_rwl);
 	return &pool->actions[offset - 1];
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index c217634d9b..f81ce20385 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -18086,6 +18086,11 @@ flow_dv_query_age(struct rte_eth_dev *dev, struct rte_flow *flow,
 	if (flow->age) {
 		struct mlx5_aso_age_action *act =
 				     flow_aso_age_get_by_idx(dev, flow->age);
+		if (!act)
+			return rte_flow_error_set
+					(error, EINVAL,
+					 RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					 NULL, "cannot read age data");
 
 		age_param = &act->age_params;
 	} else if (flow->counter) {
-- 
2.43.0

