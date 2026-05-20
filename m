Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF985CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 13:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AB784029D;
	Wed, 20 May 2026 15:27:32 +0200 (CEST)
Received: from out-ham1.mail.syseleven.net (out-ham1.mail.syseleven.net
 [151.252.42.30])
 by mails.dpdk.org (Postfix) with ESMTP id 4BC9340144;
 Wed, 20 May 2026 15:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1779283649;
 bh=by+S0YaxUlC5t3TEvFnr7Xh7UfuQ5TIbuNqmAGB71ZE=; h=From:From;
 b=iZTyYgOzP0a5epUhynVQurAHWROZQtlYjTNkarC5LbnZkC3AwW6ss39wJnG5KeAGF
 iGqu/bp1RBgvvl5DQL35SurtVStDLr4t4oM2Wicl5wPShx7BkJrp0XHP0tNV8uKIr1
 eDgbgt6TTp6k8+4velfOj7psBMa9ujW6b3lgL9F53O5n4d/y6j6hK/1GRd2hZImwgS
 4sXsSrSf8wb2Qdc4dJCdxVnPstMuI/hHuznZ7uf9FiBvawOP5x8rsAvL0GPoqYqCJZ
 X8O0ube+7VAl3yHKVET66yZSlTsgM96t6kBC9TsWBgWcNkLRbIUAesIht7HX8JKwpk
 e2WWeuWF2r8EA==
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-ham1.mail.syseleven.net (Postfix) with ESMTPSA id E76E442E03;
 Wed, 20 May 2026 15:27:28 +0200 (CEST)
From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Michael Baum <michaelba@nvidia.com>
Cc: dev@dpdk.org, Michael Pfeiffer <m.pfeiffer@syseleven.de>, stable@dpdk.org,
 Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Subject: [PATCH] net/mlx5: remove nonsensical flow action class_id checks
Date: Wed, 20 May 2026 15:25:32 +0200
Message-Id: <20260520132533.159996-1-a.schollmeyer@syseleven.de>
X-Mailer: git-send-email 2.34.1
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

From: Michael Pfeiffer <m.pfeiffer@syseleven.de>

For a MODIFY_FIELD action, flow_hw_validate_action_modify_field() is
invoked and enforces class_id == 0 in the action's source and
destination, if the modified field is none of
RTE_FLOW_FIELD_GENEVE_OPT_*, as the value is used solely for GENEVE
fields.

However, this check is flawed due to the way rte_flow_field_data is
initialized. As it consists of unions and anonymous structs as members,
empty initialization of this struct or initializing just the tag_index
only guarantees initialization of the first union member, while the
remaining member's default initialization behavior is unspecified.
Therefore, depending on the compiler type, version and configuration,
the remaining members may either be default-initialized as well or
contain bytes from uninitialized memory. This causes the check to fail
depending on how the struct is initialized wherever it is used.

For example, rte_flow_configure() sometimes fails on mlx5 under these
circumstances with an error "destination class id is not supported"
during creation of representor tagging rules, as these internally use
MODIFY_FIELD actions in the following call stack:

  1. rte_flow_configure
  2. mlx5_flow_port_configure
  3. flow_hw_configure
  4. __flow_hw_configure
  5. flow_hw_setup_tx_repr_tagging
  6. flow_hw_create_tx_repr_tag_jump_acts_tmpl
     --> various rte_flow_action_modify_field are initialized here, but
         class_id remains uninitialized
  7. __flow_hw_actions_template_create
  8. mlx5_flow_hw_actions_validate
  9. flow_hw_validate_action_modify_field
     --> invoked with class_id containing uninitialized bytes and
         non-GENEVE field type

Remove the two checks for class_id in the non-GENEVE case, as this field
is unused for these actions and avoids additional implicit dependencies
on the correct ordering of union members.

Fixes: 1caa89ec1891 ("net/mlx5: support GENEVE options modification")
Cc: stable@dpdk.org

Signed-off-by: Michael Pfeiffer <m.pfeiffer@syseleven.de>
Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index bca5b2769e..add48d7c8f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -6264,10 +6264,6 @@ flow_hw_validate_action_modify_field(struct rte_eth_dev *dev,
 			return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION, action,
 					"destination tag index is not supported");
-		if (action_conf->dst.class_id)
-			return rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"destination class id is not supported");
 	}
 	if (mask_conf->dst.level != UINT8_MAX)
 		return rte_flow_error_set(error, EINVAL,
@@ -6290,10 +6286,6 @@ flow_hw_validate_action_modify_field(struct rte_eth_dev *dev,
 				return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION, action,
 					"source tag index is not supported");
-			if (action_conf->src.class_id)
-				return rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"source class id is not supported");
 		}
 		if (mask_conf->src.level != UINT8_MAX)
 			return rte_flow_error_set(error, EINVAL,
-- 
2.34.1

