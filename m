Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED698CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:44:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13C740E1C;
	Wed, 24 Sep 2025 16:42:29 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 8402E40B9B
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022076.outbound.protection.outlook.com [52.101.66.76])
 by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOOkyP36PmDmppNsynDjIdmhTDTJbjbtKjYwBmWGW1xaTub/tFRpoLb5nOV9Z5/sQUcCkyC8ll4iCPsgArzio1kP/vZKyqM3ZOWCOLXstL4SDT9bs6KjVT8y45bdpKRwnxwHV2Xkqj7f9i0l+jsK4DQs+cORQq+nP+rwKdwUP/k4Fr20IBaFtcKYYZI3GVno+Y+SQjamREu0sxnRNWe37zjYfd0z5r4e8zanmm9135xmO/COLTqEro06CtqVM15vDBNPx/2v9laJgZkEfeeQa2Wj93TPAKkR/5uTri+a3OFwhyk79lZwSeD9uJaYkA3jV9FGX76EqLsM/q96FmIKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uabxCkQ+2lapaaAvscqq+uG3y+Rff60BbjbE7oJRzI=;
 b=xKk7XKmnbtytqWbQMQl1nsrR7Y3E0eyp2QztPLgqsI1aRNkyN+Yr5GRxmmEm7nETtA2Zxa8fpYtIrjFnBBkWqELens92hmpYwU5ZW28fzBTcva+CX/i6HVARc1/ThArv9YuYv0ZCGb/J8Xk2T25xeEuvLfu2Q5KMWLwAQcJY4KOfaOTgansHPxp1crdI4ntciVze6YwcKNUpZQeoODY4diLT+uNrbdw7jWZqSmDK+nDoDCtBgX91cMJiJBzwRbY6PziKzsgzoLQQHVMN89S/DoGpkd7OLD2IH/lm8myzu43QptPMKR0wJfu5YTNYOWPfcTxtfp7IlW2EV4Hx23y0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uabxCkQ+2lapaaAvscqq+uG3y+Rff60BbjbE7oJRzI=;
 b=N9kevb+2xLi2UkCRWoWQqo+at/nLuAMcuo9VNlcT6MizRUcow67lDvwYcEO0wM97z+Eth92l01ZTQC7U6AIX0kpedCZNBzxCfIc6MEFQT5wkdaVYaT8l3AVg3zSx2i+FqO5k91Bl1cDBmHXv/0wuBMrWT/PSQPbqlmAHUr3i3NI=
Received: from CWLP123CA0233.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::21)
 by DU0P190MB1930.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:42:09 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::17) by CWLP123CA0233.outlook.office365.com
 (2603:10a6:400:19f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:09
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 13/24] net/ntnic: modify prefix flow with prefix nthw
Date: Wed, 24 Sep 2025 16:41:36 +0200
Message-ID: <20250924144152.53203-14-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DU0P190MB1930:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5ed0cc2b-4bbc-455b-606e-08ddfb788a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/+Ddy9D2ntyBjvSy4XYqByEwcbzmWdc8Y7EzOWjhU20iC7JQsK1qIaO89crF?=
 =?us-ascii?Q?1Q5lllY998WxQhnSoll7M1Np2mnBlK3+sGxnn1gOF1fGJc10scUjQKJVMJXs?=
 =?us-ascii?Q?u7mN710cMsUD4Tzb3EY9z09zUFQRMCmexuYF11/XTP57m6tFFYzPVXpIpXLW?=
 =?us-ascii?Q?OKJuPuDazrqOxE8G1Vkv5E99Y1qVeBvQlv8OIwu2l8hKnbSO4lBhUESJ+JvM?=
 =?us-ascii?Q?g3baByc/Hsl8XmhsoTtfSs8vsdJiL6WiVM2n/7yz3QhQa8NcJtnQSDa2tVoc?=
 =?us-ascii?Q?iixHVO4YZTT6XaEDwgjXHLG1lhszZoRIyIOr3d1xkTC+3c3Axpzq7ngmx6tW?=
 =?us-ascii?Q?FvXdgHyymqqHucrJKZG97TresY/fGF+AyNl+zU9OYQ4AUWAqMHDT8H5er5v9?=
 =?us-ascii?Q?BLxMWbqTa/7OtDjpL295UAFchCLfA9d5kkZAk7hV9/BrEvO0qasrhKySlIk9?=
 =?us-ascii?Q?gO6Qc7+YrShQRBA6MbNyIXL3X2fXQk3LY9cwNJCNWhBA5WzGB/0uXV4pcGY+?=
 =?us-ascii?Q?QUMv+hikHs2C4mU7Qldx8dlXbEGQqVhYmehHWOJYArUjOJaW44EH6RduvOIb?=
 =?us-ascii?Q?u4x02MSAvFkl0HK3dDH23XfWkgACmLv41SwyK5OBHxNU6hPcFiwtYY6yP4cw?=
 =?us-ascii?Q?pfAuxCKgHx67G6lXrlUtRvcJVW6Ok1F51/L5qc6iMdRCpGTP8lucHhPvRKyU?=
 =?us-ascii?Q?fQQJK3XZjGv4MgAczPY2EybEfOpT4L+OUXwtd3awDYyOEF5/xgaBBfXye1Jz?=
 =?us-ascii?Q?+VyLR412YUPdgRG6aYqBnCKrwHYFvvz8l4KsTSvTR2cUvbBEkGRkhwllN6QK?=
 =?us-ascii?Q?EHrkg6kRWUGkbOkq1pNLh4lahG+2PDyYPDOjCX9B0rybQYGxOo11/OT1MO+L?=
 =?us-ascii?Q?O5PxJRzWubFv+q+PMX3FCwzJooFFRvGzukTmYXpPTOP+dm2Mu/Iw6o33Ulp7?=
 =?us-ascii?Q?6eco4UhSSg4MG0c4/fu+0gsFJX/pwXYdRlWSz+1Aynm4n8m5suolmhlRBu9R?=
 =?us-ascii?Q?u79+KdJU7bR2sYYYuK1FnJsP8IDhqng25MAuyrIStCzsdI7ZYpaPmOGMJI3y?=
 =?us-ascii?Q?YCRol7PNoRsSwpVvN9QIy6l4cAa3ct1hHNvJS4sD77saQpKWl5BgZucoCyOa?=
 =?us-ascii?Q?QVQH5HK8v+8Ivi5CCW8sOXb5Yvgpoehw4N35m4Ho6nTRnEDroDEPFrOxkBGU?=
 =?us-ascii?Q?vFhe2n7hsCfCv+m+3Ax3cGtjDtZamaRBXT5JGimyylNNqROnnrTHXVnreKmw?=
 =?us-ascii?Q?/dYXHzzGPMNkwDvRsr6R7JX5QUT7/io4Ow8K1JZVJIfXj/WQBNx6owmjC9gd?=
 =?us-ascii?Q?VAz9fsTq1J6Ivj1XKBfjCIHobE2vSm7XjvxWf888Ap580fZSK7nB1Sz4RMYi?=
 =?us-ascii?Q?P0lsZ53v+MMa/2pea9Xj3rYLO9zAuWdV3pEeiamkC2sH8cy2PW6Sm7wTQZVR?=
 =?us-ascii?Q?8tmAMVN2qfZtL9rDcEs89UpFzv/rKiigZDzy5J2E2VFrTnf3tefUNJYCFqgD?=
 =?us-ascii?Q?DBZ6qXXnQJY5eKxDwMjBUl8vIo8lQYEwg/J+?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ER4LB/Fy1J52K1VJmKpkd1vz4xpNY/a+UGP03SchRYF+LoOOTDtIsRYWSve76CN7vtDr/ht5fIbl7aRzG8nfufjPcBTRseO/5PNkykB83eLQywaLDkj2Y2PzxdnmHTLpgMfM7yxpzIUW40ukdp8H3vzX3R6FjusESArm+bf/5yzFE/u0mad1nxvxyWmxEefzvF8naTsDm/esCusy71aIWIYZq1/YoswiWOm3lFSU56G0NxQ1+MxrbSlAy5ile2WTH9ucxenwQDY+IoRxvZ8Swoz+2MqmRMj8RbDbm5dGwmAtgVD4ywvgi5nrEm/6K3cdbKEDoo2k/z7Q/ctaCjLaWw2gQ2wPvXHHwyCyJuyetKyd7mA9vrIwkpzfmpEzgu5bBQdUnXNfi2caQMDPwPXsmT8DdVI0iE7ULrEIuSz/1sbdCTdn2ki+ajUmhCFvKofZsSBcp4wgJWLgElbjd6asLVdIpr99IscdqTLLuz4mz5NTKFn5MCKwA+DEwZcbaCXjTqh4yPHdDB2cVK+re02qjki14R/rBk/DZL9NuHaqARp0LnWnRGzuMLX5zlqwHzIBybshWkC+fPsBwCRhpfHaai8+0FeuPYk/bjWTbM+w7j3mLJs8NDTX15RRg5qsoeLs0ABINV1Y91L2X88ZERPa+A==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:09.0178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed0cc2b-4bbc-455b-606e-08ddfb788a49
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1930
X-BESS-ID: 1758724930-305664-7614-7987-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.76
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYW5sYWQGYGUNTSJM3UPMkkJd
 U0xcjA0tjIxMTY3NDC0NAi1SDNxCDFQqk2FgBDLEf9QgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan13-148.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

Change the prefix flow_ with prefix nthw_flow to specify that the flow API
belongs to the Napatech hardware (nthw).

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  54 +++++----
 .../nthw/flow_api/flow_backend/flow_backend.c |   4 +-
 .../profile_inline/flow_api_profile_inline.c  | 113 +++++++++---------
 .../profile_inline/flow_api_profile_inline.h  |  49 ++++----
 drivers/net/ntnic/ntnic_ethdev.c              |   2 +-
 drivers/net/ntnic/ntnic_mod_reg.c             |   2 +-
 drivers/net/ntnic/ntnic_mod_reg.h             |  46 +++----
 7 files changed, 141 insertions(+), 129 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index dd25b51e14..4c7bb4a60a 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -299,7 +299,7 @@ static struct flow_handle *flow_create(struct flow_eth_dev *dev __rte_unused,
 		return NULL;
 	}
 
-	return profile_inline_ops->flow_create_profile_inline(dev, attr,
+	return profile_inline_ops->nthw_flow_create_profile_inline(dev, attr,
 		forced_vlan_vid, caller_id,  item, action, error);
 }
 
@@ -313,7 +313,7 @@ static int flow_destroy(struct flow_eth_dev *dev __rte_unused,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_destroy_profile_inline(dev, flow, error);
+	return profile_inline_ops->nthw_flow_destroy_profile_inline(dev, flow, error);
 }
 
 static int flow_flush(struct flow_eth_dev *dev, uint16_t caller_id, struct rte_flow_error *error)
@@ -325,7 +325,7 @@ static int flow_flush(struct flow_eth_dev *dev, uint16_t caller_id, struct rte_f
 		return -1;
 	}
 
-	return profile_inline_ops->flow_flush_profile_inline(dev, caller_id, error);
+	return profile_inline_ops->nthw_flow_flush_profile_inline(dev, caller_id, error);
 }
 
 static int flow_actions_update(struct flow_eth_dev *dev,
@@ -340,7 +340,8 @@ static int flow_actions_update(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_actions_update_profile_inline(dev, flow, action, error);
+	return profile_inline_ops->nthw_flow_actions_update_profile_inline(dev,
+		flow, action, error);
 }
 
 /*
@@ -405,7 +406,7 @@ static int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 	while (flow) {
 		if (flow->dev == eth_dev) {
 			struct flow_handle *flow_next = flow->next;
-			profile_inline_ops->flow_destroy_locked_profile_inline(eth_dev, flow,
+			profile_inline_ops->nthw_flow_destroy_locked_profile_inline(eth_dev, flow,
 				NULL);
 			flow = flow_next;
 
@@ -471,11 +472,11 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 			"ERROR : Flows still defined but all eth-ports deleted. Flow %p",
 			ndev->flow_base);
 
-		profile_inline_ops->flow_destroy_profile_inline(ndev->flow_base->dev,
+		profile_inline_ops->nthw_flow_destroy_profile_inline(ndev->flow_base->dev,
 			ndev->flow_base, NULL);
 	}
 
-	profile_inline_ops->done_flow_management_of_ndev_profile_inline(ndev);
+	profile_inline_ops->nthw_done_flow_mgmnt_of_ndev_profile_inline(ndev);
 
 	km_free_ndev_resource_management(&ndev->km_res_handle);
 	kcc_free_ndev_resource_management(&ndev->kcc_res_handle);
@@ -656,7 +657,7 @@ static struct flow_eth_dev *flow_get_eth_dev(uint8_t adapter_no, uint8_t port_no
 
 		/* Initialize modules if needed - recipe 0 is used as no-match and must be setup */
 		if (profile_inline_ops != NULL &&
-			profile_inline_ops->initialize_flow_management_of_ndev_profile_inline(ndev))
+			profile_inline_ops->nthw_init_flow_mgmnt_of_ndev_profile_inline(ndev))
 			goto err_exit0;
 
 	} else {
@@ -1021,7 +1022,8 @@ static int flow_dev_dump(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_dev_dump_profile_inline(dev, flow, caller_id, file, error);
+	return profile_inline_ops->nthw_flow_dev_dump_profile_inline(dev,
+		flow, caller_id, file, error);
 }
 
 static int flow_get_aged_flows(struct flow_eth_dev *dev,
@@ -1043,7 +1045,7 @@ static int flow_get_aged_flows(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_get_aged_flows_profile_inline(dev, caller_id, context,
+	return profile_inline_ops->nthw_flow_get_aged_flows_profile_inline(dev, caller_id, context,
 			nb_contexts, error);
 }
 
@@ -1058,7 +1060,7 @@ static int flow_info_get(struct flow_eth_dev *dev, uint8_t caller_id,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_info_get_profile_inline(dev, caller_id, port_info,
+	return profile_inline_ops->nthw_flow_info_get_profile_inline(dev, caller_id, port_info,
 			queue_info, error);
 }
 
@@ -1073,7 +1075,7 @@ static int flow_configure(struct flow_eth_dev *dev, uint8_t caller_id,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_configure_profile_inline(dev, caller_id, port_attr,
+	return profile_inline_ops->nthw_flow_configure_profile_inline(dev, caller_id, port_attr,
 			nb_queue, queue_attr, error);
 }
 
@@ -1093,8 +1095,8 @@ flow_pattern_template_create(struct flow_eth_dev *dev,
 			return NULL;
 	}
 
-	return profile_inline_ops->flow_pattern_template_create_profile_inline(dev, template_attr,
-		caller_id, pattern, error);
+	return profile_inline_ops->nthw_flow_pattern_template_create_profile_inline(dev,
+		template_attr, caller_id, pattern, error);
 }
 
 static int flow_pattern_template_destroy(struct flow_eth_dev *dev,
@@ -1108,7 +1110,7 @@ static int flow_pattern_template_destroy(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_pattern_template_destroy_profile_inline(dev,
+	return profile_inline_ops->nthw_flow_pattern_template_destroy_profile_inline(dev,
 			pattern_template,
 			error);
 }
@@ -1126,8 +1128,8 @@ flow_actions_template_create(struct flow_eth_dev *dev,
 		return NULL;
 	}
 
-	return profile_inline_ops->flow_actions_template_create_profile_inline(dev, template_attr,
-		caller_id, actions, masks, error);
+	return profile_inline_ops->nthw_flow_actions_template_create_profile_inline(dev,
+		template_attr, caller_id, actions, masks, error);
 }
 
 static int flow_actions_template_destroy(struct flow_eth_dev *dev,
@@ -1141,7 +1143,7 @@ static int flow_actions_template_destroy(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_actions_template_destroy_profile_inline(dev,
+	return profile_inline_ops->nthw_flow_actions_template_destroy_profile_inline(dev,
 			actions_template,
 			error);
 }
@@ -1159,7 +1161,7 @@ static struct flow_template_table *flow_template_table_create(struct flow_eth_de
 		return NULL;
 	}
 
-	return profile_inline_ops->flow_template_table_create_profile_inline(dev, table_attr,
+	return profile_inline_ops->nthw_flow_template_table_create_profile_inline(dev, table_attr,
 		forced_vlan_vid, caller_id, pattern_templates, nb_pattern_templates,
 		actions_templates, nb_actions_templates, error);
 }
@@ -1175,8 +1177,8 @@ static int flow_template_table_destroy(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_template_table_destroy_profile_inline(dev, template_table,
-			error);
+	return profile_inline_ops->nthw_flow_template_table_destroy_profile_inline(dev,
+		template_table, error);
 }
 
 static struct flow_handle *
@@ -1193,7 +1195,7 @@ flow_async_create(struct flow_eth_dev *dev, uint32_t queue_id,
 		return NULL;
 	}
 
-	return profile_inline_ops->flow_async_create_profile_inline(dev, queue_id, op_attr,
+	return profile_inline_ops->nthw_flow_async_create_profile_inline(dev, queue_id, op_attr,
 			template_table, pattern, pattern_template_index, actions,
 			actions_template_index, user_data, error);
 }
@@ -1209,8 +1211,8 @@ static int flow_async_destroy(struct flow_eth_dev *dev, uint32_t queue_id,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_async_destroy_profile_inline(dev, queue_id, op_attr, flow,
-			user_data, error);
+	return profile_inline_ops->nthw_flow_async_destroy_profile_inline(dev, queue_id,
+		op_attr, flow, user_data, error);
 }
 int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 {
@@ -1220,7 +1222,7 @@ int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t
 		return -1;
 
 	if (ndev->flow_profile == FLOW_ETH_DEV_PROFILE_INLINE)
-		return profile_inline_ops->flow_get_flm_stats_profile_inline(ndev, data, size);
+		return profile_inline_ops->nthw_flow_get_flm_stats_profile_inline(ndev, data, size);
 
 	return -1;
 }
@@ -1233,7 +1235,7 @@ int nthw_flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t p
 		return -1;
 
 	if (ndev->flow_profile == FLOW_ETH_DEV_PROFILE_INLINE) {
-		return profile_inline_ops->flow_get_ifr_stats_profile_inline(ndev, data,
+		return profile_inline_ops->nthw_flow_get_ifr_stats_profile_inline(ndev, data,
 				port_count);
 	}
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
index cb6489b3ac..8144e25540 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
@@ -1972,7 +1972,7 @@ static int free_rx_queue(void *be_dev, int hw_queue)
 	return 0;
 }
 
-const struct flow_api_backend_ops flow_be_iface = {
+const struct flow_api_backend_ops nthw_flow_be_iface = {
 	1,
 
 	set_debug_mode,
@@ -2248,7 +2248,7 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	be_devs[physical_adapter_no].adapter_no = physical_adapter_no;
 	*dev = (void *)&be_devs[physical_adapter_no];
 
-	return &flow_be_iface;
+	return &nthw_flow_be_iface;
 }
 
 static void bin_flow_backend_done(void *dev)
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 71b9bcd3d7..32aae24499 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -3898,7 +3898,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
  * Public functions
  */
 
-int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
+int nthw_init_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 {
 	if (!ndev->flow_mgnt_prepared) {
 		/* Check static arrays are big enough */
@@ -4086,11 +4086,11 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 	return 0;
 
 err_exit0:
-	done_flow_management_of_ndev_profile_inline(ndev);
+	nthw_done_flow_mgmnt_of_ndev_profile_inline(ndev);
 	return -1;
 }
 
-int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
+int nthw_done_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 {
 #ifdef FLOW_DEBUG
 	ndev->be.iface->set_debug_mode(ndev->be.be_dev, FLOW_BACKEND_DEBUG_MODE_WRITE);
@@ -4166,7 +4166,7 @@ int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 	return 0;
 }
 
-struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev __rte_unused,
+struct flow_handle *nthw_flow_create_profile_inline(struct flow_eth_dev *dev __rte_unused,
 	const struct rte_flow_attr *attr __rte_unused,
 	uint16_t forced_vlan_vid __rte_unused,
 	uint16_t caller_id __rte_unused,
@@ -4266,7 +4266,7 @@ struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev __rte_un
 	return NULL;
 }
 
-int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *fh,
 	struct rte_flow_error *error)
 {
@@ -4332,27 +4332,27 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 }
 
-int flow_destroy_profile_inline(struct flow_eth_dev *dev, struct flow_handle *flow,
+int nthw_flow_destroy_profile_inline(struct flow_eth_dev *dev, struct flow_handle *flow,
 	struct rte_flow_error *error)
 {
 	int err = 0;
 
 	if (flow && flow->type == FLOW_HANDLE_TYPE_FLM && flow->flm_async)
-		return flow_async_destroy_profile_inline(dev, 0, NULL, flow, NULL, error);
+		return nthw_flow_async_destroy_profile_inline(dev, 0, NULL, flow, NULL, error);
 
 	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	if (flow) {
 		/* Delete this flow */
 		rte_spinlock_lock(&dev->ndev->mtx);
-		err = flow_destroy_locked_profile_inline(dev, flow, error);
+		err = nthw_flow_destroy_locked_profile_inline(dev, flow, error);
 		rte_spinlock_unlock(&dev->ndev->mtx);
 	}
 
 	return err;
 }
 
-int flow_flush_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_flush_profile_inline(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	struct rte_flow_error *error)
 {
@@ -4369,7 +4369,7 @@ int flow_flush_profile_inline(struct flow_eth_dev *dev,
 	while (flow && !err) {
 		if (flow->dev == dev && flow->caller_id == caller_id) {
 			struct flow_handle *flow_next = flow->next;
-			err = flow_destroy_profile_inline(dev, flow, error);
+			err = nthw_flow_destroy_profile_inline(dev, flow, error);
 			flow = flow_next;
 
 		} else {
@@ -4383,7 +4383,7 @@ int flow_flush_profile_inline(struct flow_eth_dev *dev,
 	while (flow && !err) {
 		if (flow->dev == dev && flow->caller_id == caller_id) {
 			struct flow_handle *flow_next = flow->next;
-			err = flow_destroy_profile_inline(dev, flow, error);
+			err = nthw_flow_destroy_profile_inline(dev, flow, error);
 			flow = flow_next;
 
 		} else {
@@ -4394,7 +4394,7 @@ int flow_flush_profile_inline(struct flow_eth_dev *dev,
 	return err;
 }
 
-int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	const struct rte_flow_action action[],
 	struct rte_flow_error *error)
@@ -4566,7 +4566,7 @@ static void dump_flm_data(const uint32_t *data, FILE *file)
 	}
 }
 
-int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	void **context,
 	uint32_t nb_contexts,
@@ -4615,7 +4615,7 @@ int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	return idx;
 }
 
-int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	uint16_t caller_id,
 	FILE *file,
@@ -4687,7 +4687,7 @@ int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 }
 
-int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
+int nthw_flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 {
 	const enum hw_flm_e fields[] = {
 		HW_FLM_STAT_FLOWS, HW_FLM_STAT_LRN_DONE, HW_FLM_STAT_LRN_IGNORE,
@@ -4729,7 +4729,7 @@ int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	return 0;
 }
 
-int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
+int nthw_flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	uint8_t port_count)
 {
 	/* IFR RCP 0 is reserved, port counters start from record 1 */
@@ -4747,7 +4747,7 @@ int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	return 0;
 }
 
-int flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu)
+int nthw_flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu)
 {
 	if (port >= 255)
 		return -1;
@@ -4808,7 +4808,7 @@ int flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu)
 	return err;
 }
 
-int flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
+int nthw_flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	struct rte_flow_port_info *port_info,
 	struct rte_flow_queue_info *queue_info, struct rte_flow_error *error)
 {
@@ -4830,7 +4830,7 @@ int flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	return res;
 }
 
-int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
+int nthw_flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	const struct rte_flow_port_attr *port_attr, uint16_t nb_queue,
 	const struct rte_flow_queue_attr *queue_attr[],
 	struct rte_flow_error *error)
@@ -4905,7 +4905,8 @@ int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	return -1;
 }
 
-struct flow_pattern_template *flow_pattern_template_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_pattern_template *
+nthw_flow_pattern_template_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_pattern_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_item pattern[], struct rte_flow_error *error)
 {
@@ -4949,7 +4950,7 @@ struct flow_pattern_template *flow_pattern_template_create_profile_inline(struct
 	return template;
 }
 
-int flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_pattern_template *pattern_template,
 	struct rte_flow_error *error)
 {
@@ -4963,7 +4964,7 @@ int flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
 }
 
 struct flow_actions_template *
-flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
+nthw_flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_actions_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_action actions[],
 	const struct rte_flow_action masks[],
@@ -5023,7 +5024,7 @@ flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 	return template;
 }
 
-int flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_actions_template *actions_template,
 	struct rte_flow_error *error)
 {
@@ -5036,7 +5037,7 @@ int flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 }
 
-struct flow_template_table *flow_template_table_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_template_table *nthw_flow_template_table_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_template_table_attr *table_attr, uint16_t forced_vlan_vid,
 	uint16_t caller_id,
 	struct flow_pattern_template *pattern_templates[], uint8_t nb_pattern_templates,
@@ -5109,7 +5110,7 @@ struct flow_template_table *flow_template_table_create_profile_inline(struct flo
 	return NULL;
 }
 
-int flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_template_table *template_table,
 	struct rte_flow_error *error)
 {
@@ -5136,7 +5137,7 @@ int flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 }
 
-struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_handle *nthw_flow_async_create_profile_inline(struct flow_eth_dev *dev,
 	uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr,
 	struct flow_template_table *template_table,
@@ -5346,7 +5347,7 @@ struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
 	return NULL;
 }
 
-int flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
+int nthw_flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr, struct flow_handle *flow,
 	void *user_data, struct rte_flow_error *error)
 {
@@ -5355,7 +5356,7 @@ int flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_i
 	(void)user_data;
 
 	if (flow->type == FLOW_HANDLE_TYPE_FLOW)
-		return flow_destroy_profile_inline(dev, flow, error);
+		return nthw_flow_destroy_profile_inline(dev, flow, error);
 
 	if (flm_flow_programming(flow, NT_FLM_OP_UNLEARN)) {
 		NT_LOG(ERR, FILTER, "FAILED to destroy flow: %p", flow);
@@ -5374,36 +5375,40 @@ static const struct profile_inline_ops ops = {
 	/*
 	 * Management
 	 */
-	.done_flow_management_of_ndev_profile_inline = done_flow_management_of_ndev_profile_inline,
-	.initialize_flow_management_of_ndev_profile_inline =
-		initialize_flow_management_of_ndev_profile_inline,
-	.flow_dev_dump_profile_inline = flow_dev_dump_profile_inline,
+	.nthw_done_flow_mgmnt_of_ndev_profile_inline = nthw_done_flow_mgmnt_of_ndev_profile_inline,
+	.nthw_init_flow_mgmnt_of_ndev_profile_inline =
+		nthw_init_flow_mgmnt_of_ndev_profile_inline,
+	.nthw_flow_dev_dump_profile_inline = nthw_flow_dev_dump_profile_inline,
 	/*
 	 * Flow functionality
 	 */
-	.flow_destroy_locked_profile_inline = flow_destroy_locked_profile_inline,
-	.flow_create_profile_inline = flow_create_profile_inline,
-	.flow_destroy_profile_inline = flow_destroy_profile_inline,
-	.flow_flush_profile_inline = flow_flush_profile_inline,
-	.flow_actions_update_profile_inline = flow_actions_update_profile_inline,
-	.flow_get_aged_flows_profile_inline = flow_get_aged_flows_profile_inline,
+	.nthw_flow_destroy_locked_profile_inline = nthw_flow_destroy_locked_profile_inline,
+	.nthw_flow_create_profile_inline = nthw_flow_create_profile_inline,
+	.nthw_flow_destroy_profile_inline = nthw_flow_destroy_profile_inline,
+	.nthw_flow_flush_profile_inline = nthw_flow_flush_profile_inline,
+	.nthw_flow_actions_update_profile_inline = nthw_flow_actions_update_profile_inline,
+	.nthw_flow_get_aged_flows_profile_inline = nthw_flow_get_aged_flows_profile_inline,
 	/*
 	 * Stats
 	 */
-	.flow_get_flm_stats_profile_inline = flow_get_flm_stats_profile_inline,
-	.flow_get_ifr_stats_profile_inline = flow_get_ifr_stats_profile_inline,
-	.flow_info_get_profile_inline = flow_info_get_profile_inline,
-	.flow_configure_profile_inline = flow_configure_profile_inline,
-	.flow_pattern_template_create_profile_inline = flow_pattern_template_create_profile_inline,
-	.flow_pattern_template_destroy_profile_inline =
-		flow_pattern_template_destroy_profile_inline,
-	.flow_actions_template_create_profile_inline = flow_actions_template_create_profile_inline,
-	.flow_actions_template_destroy_profile_inline =
-		flow_actions_template_destroy_profile_inline,
-	.flow_template_table_create_profile_inline = flow_template_table_create_profile_inline,
-	.flow_template_table_destroy_profile_inline = flow_template_table_destroy_profile_inline,
-	.flow_async_create_profile_inline = flow_async_create_profile_inline,
-	.flow_async_destroy_profile_inline = flow_async_destroy_profile_inline,
+	.nthw_flow_get_flm_stats_profile_inline = nthw_flow_get_flm_stats_profile_inline,
+	.nthw_flow_get_ifr_stats_profile_inline = nthw_flow_get_ifr_stats_profile_inline,
+	.nthw_flow_info_get_profile_inline = nthw_flow_info_get_profile_inline,
+	.nthw_flow_configure_profile_inline = nthw_flow_configure_profile_inline,
+	.nthw_flow_pattern_template_create_profile_inline =
+		nthw_flow_pattern_template_create_profile_inline,
+	.nthw_flow_pattern_template_destroy_profile_inline =
+		nthw_flow_pattern_template_destroy_profile_inline,
+	.nthw_flow_actions_template_create_profile_inline =
+		nthw_flow_actions_template_create_profile_inline,
+	.nthw_flow_actions_template_destroy_profile_inline =
+		nthw_flow_actions_template_destroy_profile_inline,
+	.nthw_flow_template_table_create_profile_inline =
+		nthw_flow_template_table_create_profile_inline,
+	.nthw_flow_template_table_destroy_profile_inline =
+		nthw_flow_template_table_destroy_profile_inline,
+	.nthw_flow_async_create_profile_inline = nthw_flow_async_create_profile_inline,
+	.nthw_flow_async_destroy_profile_inline = nthw_flow_async_destroy_profile_inline,
 	/*
 	 * NT Flow FLM Meter API
 	 */
@@ -5424,10 +5429,10 @@ static const struct profile_inline_ops ops = {
 	/*
 	 * Config API
 	 */
-	.flow_set_mtu_inline = flow_set_mtu_inline,
+	.nthw_flow_set_mtu_inline = nthw_flow_set_mtu_inline,
 };
 
-void profile_inline_init(void)
+void nthw_profile_inline_init(void)
 {
 	register_profile_inline_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
index 98aba07515..2c2d0e2fbf 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
@@ -22,18 +22,18 @@
  * Management
  */
 
-int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev);
+int nthw_done_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev);
 
-int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev);
+int nthw_init_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev);
 
 /*
  * Flow functionality
  */
-int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *fh,
 	struct rte_flow_error *error);
 
-struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_handle *nthw_flow_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_attr *attr,
 	uint16_t forced_vlan_vid,
 	uint16_t caller_id,
@@ -41,26 +41,26 @@ struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_action action[],
 	struct rte_flow_error *error);
 
-int flow_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	struct rte_flow_error *error);
 
-int flow_flush_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_flush_profile_inline(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	struct rte_flow_error *error);
 
-int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	const struct rte_flow_action action[],
 	struct rte_flow_error *error);
 
-int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	uint16_t caller_id,
 	FILE *file,
 	struct rte_flow_error *error);
 
-int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	void **context,
 	uint32_t nb_contexts,
@@ -70,9 +70,11 @@ int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
  * Stats
  */
 
-int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
+int nthw_flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev,
+		uint64_t *data,
+		uint64_t size);
 
-int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev,
+int nthw_flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev,
 	uint64_t *data,
 	uint8_t port_count);
 
@@ -80,49 +82,52 @@ int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev,
  * RTE flow asynchronous operations functions
  */
 
-struct flow_pattern_template *flow_pattern_template_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_pattern_template *
+nthw_flow_pattern_template_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_pattern_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_item pattern[], struct rte_flow_error *error);
 
-int flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_pattern_template *pattern_template,
 	struct rte_flow_error *error);
 
-struct flow_actions_template *flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_actions_template *
+nthw_flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_actions_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_action actions[], const struct rte_flow_action masks[],
 	struct rte_flow_error *error);
 
-int flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_actions_template *actions_template,
 	struct rte_flow_error *error);
 
-struct flow_template_table *flow_template_table_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_template_table *nthw_flow_template_table_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_template_table_attr *table_attr, uint16_t forced_vlan_vid,
 	uint16_t caller_id,
 	struct flow_pattern_template *pattern_templates[], uint8_t nb_pattern_templates,
 	struct flow_actions_template *actions_templates[], uint8_t nb_actions_templates,
 	struct rte_flow_error *error);
 
-int flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_template_table *template_table,
 	struct rte_flow_error *error);
 
-struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
+struct flow_handle *nthw_flow_async_create_profile_inline(struct flow_eth_dev *dev,
+	uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr,
 	struct flow_template_table *template_table, const struct rte_flow_item pattern[],
 	uint8_t pattern_template_index, const struct rte_flow_action actions[],
 	uint8_t actions_template_index, void *user_data, struct rte_flow_error *error);
 
-int flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
+int nthw_flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr, struct flow_handle *flow,
 	void *user_data, struct rte_flow_error *error);
 
-int flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
+int nthw_flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	struct rte_flow_port_info *port_info,
 	struct rte_flow_queue_info *queue_info, struct rte_flow_error *error);
 
-int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
+int nthw_flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	const struct rte_flow_port_attr *port_attr, uint16_t nb_queue,
 	const struct rte_flow_queue_attr *queue_attr[],
 	struct rte_flow_error *error);
@@ -130,6 +135,6 @@ int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 /*
  * Config API
  */
-int flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
+int nthw_flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
 
 #endif	/* _FLOW_API_PROFILE_INLINE_H_ */
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 276a2dc8e1..6318a32e4b 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1192,7 +1192,7 @@ static int dev_set_mtu_inline(struct rte_eth_dev *eth_dev, uint16_t mtu)
 	int ret = -1;
 
 	if (internals->type == PORT_TYPE_PHYSICAL && mtu >= MIN_MTU_INLINE && mtu <= MAX_MTU)
-		ret = profile_inline_ops->flow_set_mtu_inline(flw_dev, internals->port, mtu);
+		ret = profile_inline_ops->nthw_flow_set_mtu_inline(flw_dev, internals->port, mtu);
 
 	return ret ? -EINVAL : 0;
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 8dc6e48182..36aee48818 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -226,7 +226,7 @@ void register_profile_inline_ops(const struct profile_inline_ops *ops)
 const struct profile_inline_ops *get_profile_inline_ops(void)
 {
 	if (profile_inline_ops == NULL)
-		profile_inline_init();
+		nthw_profile_inline_init();
 
 	return profile_inline_ops;
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 2d5bebda2a..59eb5ab69f 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -297,18 +297,18 @@ struct profile_inline_ops {
 	 * Management
 	 */
 
-	int (*done_flow_management_of_ndev_profile_inline)(struct flow_nic_dev *ndev);
+	int (*nthw_done_flow_mgmnt_of_ndev_profile_inline)(struct flow_nic_dev *ndev);
 
-	int (*initialize_flow_management_of_ndev_profile_inline)(struct flow_nic_dev *ndev);
+	int (*nthw_init_flow_mgmnt_of_ndev_profile_inline)(struct flow_nic_dev *ndev);
 
 	/*
 	 * Flow functionality
 	 */
-	int (*flow_destroy_locked_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_destroy_locked_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_handle *fh,
 		struct rte_flow_error *error);
 
-	struct flow_handle *(*flow_create_profile_inline)(struct flow_eth_dev *dev,
+	struct flow_handle *(*nthw_flow_create_profile_inline)(struct flow_eth_dev *dev,
 		const struct rte_flow_attr *attr,
 		uint16_t forced_vlan_vid,
 		uint16_t caller_id,
@@ -316,26 +316,26 @@ struct profile_inline_ops {
 		const struct rte_flow_action action[],
 		struct rte_flow_error *error);
 
-	int (*flow_destroy_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_destroy_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_handle *flow,
 		struct rte_flow_error *error);
 
-	int (*flow_flush_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_flush_profile_inline)(struct flow_eth_dev *dev,
 		uint16_t caller_id,
 		struct rte_flow_error *error);
 
-	int (*flow_actions_update_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_actions_update_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_handle *flow,
 		const struct rte_flow_action action[],
 		struct rte_flow_error *error);
 
-	int (*flow_dev_dump_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_dev_dump_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_handle *flow,
 		uint16_t caller_id,
 		FILE *file,
 		struct rte_flow_error *error);
 
-	int (*flow_get_aged_flows_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_get_aged_flows_profile_inline)(struct flow_eth_dev *dev,
 		uint16_t caller_id,
 		void **context,
 		uint32_t nb_contexts,
@@ -345,43 +345,43 @@ struct profile_inline_ops {
 	 * RTE flow asynchronous operations functions
 	 */
 
-	struct flow_pattern_template *(*flow_pattern_template_create_profile_inline)
+	struct flow_pattern_template *(*nthw_flow_pattern_template_create_profile_inline)
 		(struct flow_eth_dev *dev,
 		const struct rte_flow_pattern_template_attr *template_attr, uint16_t caller_id,
 		const struct rte_flow_item pattern[], struct rte_flow_error *error);
 
-	int (*flow_pattern_template_destroy_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_pattern_template_destroy_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_pattern_template *pattern_template,
 		struct rte_flow_error *error);
 
-	struct flow_actions_template *(*flow_actions_template_create_profile_inline)
+	struct flow_actions_template *(*nthw_flow_actions_template_create_profile_inline)
 		(struct flow_eth_dev *dev,
 		const struct rte_flow_actions_template_attr *template_attr,
 		uint16_t caller_id, const struct rte_flow_action actions[],
 		const struct rte_flow_action masks[], struct rte_flow_error *error);
 
-	int (*flow_actions_template_destroy_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_actions_template_destroy_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_actions_template *actions_template,
 		struct rte_flow_error *error);
 
-	struct flow_template_table *(*flow_template_table_create_profile_inline)
+	struct flow_template_table *(*nthw_flow_template_table_create_profile_inline)
 		(struct flow_eth_dev *dev, const struct rte_flow_template_table_attr *table_attr,
 		uint16_t forced_vlan_vid, uint16_t caller_id,
 		struct flow_pattern_template *pattern_templates[], uint8_t nb_pattern_templates,
 		struct flow_actions_template *actions_templates[], uint8_t nb_actions_templates,
 		struct rte_flow_error *error);
 
-	int (*flow_template_table_destroy_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_template_table_destroy_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_template_table *template_table,
 		struct rte_flow_error *error);
 
-	struct flow_handle *(*flow_async_create_profile_inline)(struct flow_eth_dev *dev,
+	struct flow_handle *(*nthw_flow_async_create_profile_inline)(struct flow_eth_dev *dev,
 		uint32_t queue_id, const struct rte_flow_op_attr *op_attr,
 		struct flow_template_table *template_table, const struct rte_flow_item pattern[],
 		uint8_t rte_pattern_template_index, const struct rte_flow_action actions[],
 		uint8_t rte_actions_template_index, void *user_data, struct rte_flow_error *error);
 
-	int (*flow_async_destroy_profile_inline)(struct flow_eth_dev *dev, uint32_t queue_id,
+	int (*nthw_flow_async_destroy_profile_inline)(struct flow_eth_dev *dev, uint32_t queue_id,
 		const struct rte_flow_op_attr *op_attr,
 		struct flow_handle *flow, void *user_data,
 		struct rte_flow_error *error);
@@ -389,11 +389,11 @@ struct profile_inline_ops {
 	/*
 	 * Stats
 	 */
-	int (*flow_get_flm_stats_profile_inline)(struct flow_nic_dev *ndev,
+	int (*nthw_flow_get_flm_stats_profile_inline)(struct flow_nic_dev *ndev,
 		uint64_t *data,
 		uint64_t size);
 
-	int (*flow_get_ifr_stats_profile_inline)(struct flow_nic_dev *ndev,
+	int (*nthw_flow_get_ifr_stats_profile_inline)(struct flow_nic_dev *ndev,
 		uint64_t *data,
 		uint8_t port_count);
 
@@ -431,11 +431,11 @@ struct profile_inline_ops {
 
 	uint32_t (*flm_update)(struct flow_eth_dev *dev);
 
-	int (*flow_info_get_profile_inline)(struct flow_eth_dev *dev, uint8_t caller_id,
+	int (*nthw_flow_info_get_profile_inline)(struct flow_eth_dev *dev, uint8_t caller_id,
 		struct rte_flow_port_info *port_info, struct rte_flow_queue_info *queue_info,
 		struct rte_flow_error *error);
 
-	int (*flow_configure_profile_inline)(struct flow_eth_dev *dev, uint8_t caller_id,
+	int (*nthw_flow_configure_profile_inline)(struct flow_eth_dev *dev, uint8_t caller_id,
 	const struct rte_flow_port_attr *port_attr, uint16_t nb_queue,
 	const struct rte_flow_queue_attr *queue_attr[],
 	struct rte_flow_error *error);
@@ -443,12 +443,12 @@ struct profile_inline_ops {
 	/*
 	 * Config API
 	 */
-	int (*flow_set_mtu_inline)(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
+	int (*nthw_flow_set_mtu_inline)(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
 };
 
 void register_profile_inline_ops(const struct profile_inline_ops *ops);
 const struct profile_inline_ops *get_profile_inline_ops(void);
-void profile_inline_init(void);
+void nthw_profile_inline_init(void);
 
 struct flow_filter_ops {
 	int (*nthw_flow_filter_init)(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device,
-- 
2.45.0

