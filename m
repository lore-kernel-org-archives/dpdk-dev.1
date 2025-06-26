Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A80C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:07:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F8B0402D3;
	Thu, 26 Jun 2025 15:07:19 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id AF33B40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 15:07:17 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-236377f00a1so11023295ad.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1750943237;
 x=1751548037; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oEmYbJVk8mEPyCG4GxGlfjC2h+EhEBw2Rx6RviTkstA=;
 b=E1elysDDfFrbGS19U/TB872t0U1nwGM79/FHce5vCbyxqnMxpZUwihNqEBfnrGZ2F8
 +b99boPLQleERN/ZWnr4R02B6pCRg14JTzvaGMKLNUbK768/y4ujhKtJ5Z5MxdOeyNNo
 hzQ/YX9A8b0NhJ1Cf5gILoXUHmQofP6lbFGu/MK0Yj2gIpVe0Sy8GsoORoAoytACsvZW
 tm3+G9DkBzxNCqUXO6qciuxFKN1df4tH4Eit//bPE98L0ZCILAITKkT+BvtrAlMtogN9
 mmaPoRmceVzc7Q8Te5Oh0tq0Oc+0oGw6gvu82EDEBghC5ZhRdTQNU/Azodl7sWUnYhq5
 TrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750943237; x=1751548037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oEmYbJVk8mEPyCG4GxGlfjC2h+EhEBw2Rx6RviTkstA=;
 b=MEijBT+OVen/rGtzNAhioD9njwMacN9RqBlO4VWlOMV6/H883oPjzk/dBj3HP1MeAO
 /MuUgC1o52aS4dbTIKnpBAdd9A85F8V6ENp4XO+aJ2GlL1W3Ajot73g/RF2DoyfyJQgC
 CJIGYmScUJjE4rO22zxPblelDIsXfi2UPHI/wxejye09lIqthCPjaTIsE5/Kwcvqq8Oo
 6n4NZQiCD3e2sBrxTW/o3wyBHfhWgvISvjZtso/UJzbt5bhXyZa5hoRDjQH7raegFqsr
 fJYaY4eBhUuM0uCJ6U+RgOg1vD5gSLNi46ysFgczKL+tGNHCfsSEF76PdEbezt5GrYs6
 jxAw==
X-Gm-Message-State: AOJu0YyCDZj2R7LdzAllJBoUVquDscAFJ9FYr/4lbD9KM9ElkbYZtOlG
 SmguIgFMrOt7Lu1LyYqiEmLKNxrIAxie4x06/fJII2yF0+ucrNNWX5KTR86dUNkE6uPaGRtK410
 3ODxL
X-Gm-Gg: ASbGncuUF3Z2vudn7Ej5HYwqXH6u+ugJyMnCACh3kuCibWX28UGDy0iuqaeQJnUXeDI
 LSjI4EhrrtUFyteV0peXtj4U4WbllYjDJqtNxBkrqz0j+WTb5hKkeGUeo4sZ+KqyGT4kxqkQ768
 wRifiAxn4S9Tpn0vYSkHV4WHQpH8GxzVAh/nAv1GH0tlXFbYbFmRMt+jjNdeqKe8gqeDQW/ukZs
 D6KKnsSsDeqV2ya8zAUXQKHJNOQIyJ/t3QUhKQ4Ff9sTfgbfvim1ANswaVbFow2Oe0Alta7cMCM
 B0n0f/TJVvY9boQ1JlRArf1WZjMYZRj1if2pFrTu9eyNT3nUAQSICw3LZ3Oto/DGU66W2Arczl8
 UKASqVO8JnPMo
X-Google-Smtp-Source: AGHT+IExY1G3CwrPJudT1WxTZgDt7Foh1dgVnoTk2Rm3CVtp1IzAiSQCbKMQEJi4fPxRwT6mVIIKSg==
X-Received: by 2002:a17:902:f711:b0:236:6f5f:caaf with SMTP id
 d9443c01a7336-23823fd61bfmr116977045ad.15.1750943236471; 
 Thu, 26 Jun 2025 06:07:16 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d867c0d9sm155104415ad.177.2025.06.26.06.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 06:07:16 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org
Cc: rasland@nvidia.com, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org
Subject: [PATCH v2] net/mlx5: fix segfault on indirect action age query with
 conntrack
Date: Thu, 26 Jun 2025 09:07:02 -0400
Message-ID: <20250626130702.3921887-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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

v2:
 - Added missing check for AGE + CT conflict in flow_dv_query().
 - Removed unnecessary null check from flow_aso_age_get_by_idx().
 - Added Fixes tag for LTS tracking.
 - Ensured .mailmap and Signed-off-by addresses match.

This patch fixes a segmentation fault that occurs when querying the
AGE action of a flow rule that uses indirect connection tracking (CT).

Background:
AGE and CT indices share a union in the mlx5 flow struct. When using CT
without age, the age index is invalid. Querying AGE in this case leads
to a crash due to reading an invalid pointer.

Fix:
Add a check in `flow_dv_query()` to prevent AGE queries on indirect CT
actions. This is the correct fix rather than null-checking the pool.

Steps to reproduce:
 1. Create an indirect CT action:
    flow indirect_action 0 create ingress action conntrack / end

 2. Create a root rule with jump:
    flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump group 3 / end

 3. Create a group 3 rule using the indirect action:
    flow create 0 group 3 ingress pattern eth / ipv4 / tcp / end actions indirect 0 / jump group 5 / end

 4. Create a group 5 rule matching CT state:
    flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / end actions queue index 5 / end

 5. Querying the first rule causes segfault:
    flow query 0 1 age

Fixes: 2d084f69aa26 ("net/mlx5: add translation of connection tracking action")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 .mailmap                        | 1 +
 drivers/net/mlx5/mlx5_flow_dv.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8483d96ec5..6126f7e472 100644
--- a/.mailmap
+++ b/.mailmap
@@ -812,6 +812,7 @@ Kevin Scott <kevin.c.scott@intel.com>
 Kevin Traynor <ktraynor@redhat.com>
 Ke Xu <ke1.xu@intel.com>
 Ke Zhang <ke1x.zhang@intel.com>
+Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
 Khoa To <khot@microsoft.com>
 Kiran KN <kirankn@juniper.net>
 Kiran Kumar K <kirankumark@marvell.com> <kkokkilagadda@caviumnetworks.com> <kiran.kokkilagadda@caviumnetworks.com>
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index c217634d9b..7ce093e075 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -18134,6 +18134,11 @@ flow_dv_query(struct rte_eth_dev *dev,
 						  error);
 			break;
 		case RTE_FLOW_ACTION_TYPE_AGE:
+			if (flow->indirect_type == MLX5_INDIRECT_ACTION_TYPE_CT)
+				return rte_flow_error_set(error, ENOTSUP,
+						  RTE_FLOW_ERROR_TYPE_ACTION,
+						  actions,
+						  "age not available");
 			ret = flow_dv_query_age(dev, flow, data, error);
 			break;
 		default:
-- 
2.43.0

