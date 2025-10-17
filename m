Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB74CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:43:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF96427B2;
	Fri, 17 Oct 2025 06:43:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
 by mails.dpdk.org (Postfix) with ESMTP id A9CA4427B4;
 Fri, 17 Oct 2025 06:43:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdoYyx0pHRRlehuUugP8jK3N8Dr2wOzrIcYkydzC70mPlPVu7N8nXSwL1Yx5fuD3qrB82cUf+Gy3shdoscHJvlCmD0JI0scYwOZ3JNICLL2D+RbZ/Vd+ziKVoyAp7wHhXhZDTmAXTmtdS0A2PxNmSE7MslWvNGNkJhvmYOP0trteRv54DdJUo3onax7SPLzS4gtxPxteb7GdjefJiGjjfVkHwz1e9pof8VffruQSUHNm0rxQVXlU+NbA2i3LC5tKaGN8PTyvE0qfNS2g25TvQIeE18dMGaWD2pR/x4MjT4qvf8M2DHU8xgzNqHJMfXAHP9zM2MI+/IyyxiJthrKWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2LdG3dDSIDoHYuThSae42cKcTQzeIcXSb30wxISp5A=;
 b=rUCMXp3HsuIxrtKVAN1ctyliKNBqLpyAUg0Yfnqrmb+srKO2UG2ojJaloRFL+ROJ0CJobH+36K4wpt1ZLBbErps65JXQd1yEmOe29pFdbv3JVHTFARCvzGsaU/ZqP7s/SK3pTjmKzkR4AEC5Kmcqk/02Og8Dd65ezwX7OrDf8NuFx8s86n/q3P43jiEwjA8zSH3q6q/dVtB7m5Tm3siL89c3zv2licPYA08y9aU5k76jSDKNlncNaXVXt9NiVLfjcu1X9Q9jvfT7txlLfzLbrV2/sXRWVT65nmKvrpmO/gAiteTHFtvC9oY5tCD76OOCvZI8e7oKKuiTshCcPEVwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2LdG3dDSIDoHYuThSae42cKcTQzeIcXSb30wxISp5A=;
 b=mVKoYUE6soPpbZnHBOLjCccsuB8wE3Aw3MdnwhF+mi4yvicpEcVAnGfE4jkn0eegdiYz3E73uKSGdbaUpLNhQc58vr13Zs3MUUWQ/y+uATRhmZqJTiM88w5rRZh5TcHOKAz9gHwJt45BJhRPyD9gOAYN5/rpSRBxwDF+0jj72j9WPfW4KSpwSNRGh/ljlajPhKjG9Hx8E0xMY/Qw/WW9ox+Y+FjAhPM2eIiihx7DuarDhG2OIzrjyC/GqKnAssw6QyPTy7dY3yNYBnjFifw+tXsgA3g4/GS/SQFnXwAV8G6FCa4Y0uEaWekKnzj7TfTIvQVbYnmp2gWHZ6OYbeX6HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by GVXPR04MB11655.eurprd04.prod.outlook.com (2603:10a6:150:2c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:43:24 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:43:24 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>,
	stable@dpdk.org
Subject: [PATCH v4 6/6] net/dpaa: fix resource leak coverity issue
Date: Fri, 17 Oct 2025 10:12:56 +0530
Message-Id: <20251017044256.3264737-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044256.3264737-1-g.singh@nxp.com>
References: <20251014101716.2885563-1-g.singh@nxp.com>
 <20251017044256.3264737-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|GVXPR04MB11655:EE_
X-MS-Office365-Filtering-Correlation-Id: 402a06d0-4790-4265-f9b2-08de0d37b4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J4ttSSCUZG2U6JUofpZAcSb36N/a4wFhVHfFjIctO04c3XIrOkwo8KymIMaw?=
 =?us-ascii?Q?Hj4Ns5Svi51Ix4MJ1sjEKzQwhITTVsLDsOqD1TdvVhjjsxRd45uhr+deWdOz?=
 =?us-ascii?Q?WpZqyxcNYEZ2AZwQqfsXAg9G9VzgnlH/wZ9EJaZSdBTDVrkZnZWsWIdCRtDj?=
 =?us-ascii?Q?4WTd48oGjvtlxi1oF3CdTUOOMal15E7L26+vQvdzU0Gp8MTvRy1hSWFclx8r?=
 =?us-ascii?Q?nT7iQBcx1pC+613Ie+2zRv8HR24zEH+iQOsqHMF9rDgy5cU1Bn8+alv4SknM?=
 =?us-ascii?Q?EiMOgTdqOJOOaZNqld2f9g4Jj27OFJDMwp96wlRl2NQxC44g7yQY5aW7oeaL?=
 =?us-ascii?Q?snPsOk7rApCqCp43qNxWYsQvsgxoqZpJK5aYnZYo1Nhpi48ZnSj9Uk4RYh1X?=
 =?us-ascii?Q?5iFqGw7zpnfrWJQPtldiwVJRHcQyjB0HJAjHIP123Oip2nnSK2hLi8490/Ql?=
 =?us-ascii?Q?/cxDxySnhXJPXnJojUPdiIKGaE6QMDwIGxVEwnJgee2Q0RZ1VzSHP2dF7iKp?=
 =?us-ascii?Q?cxQqdh5P+Y8OCy4sHclWq1RLTuz8ZQi9rvn/I3zADE0l1TZVuEnVZ2cfWJ+K?=
 =?us-ascii?Q?jr57qY//8TOCUWSS3Ts9qKwPxxZj6P4oeSWhqoq2nF2PrqtfGsFNL2OlAMW6?=
 =?us-ascii?Q?u2QN7YKNkXfSyMcVxWu7Wnr3OsWgB+NoWrpV7QqmtANoMzliGgVRKFkWuCnq?=
 =?us-ascii?Q?QVbvTeO/djheQh4Ki/lBceteFeBJ2oEVB4HNCDH1+qM89hyWxeP8jw7hTBiq?=
 =?us-ascii?Q?RNWsSQ8pe5wGqibthwFj/oRKVy4K9S5+kvqGon9ZR8s2mD40d4c6nWWUq2Zm?=
 =?us-ascii?Q?A5ZLR3hmnleyKEUA0Iwo4W+ATqJLsvPhMrBicpc5Ta8Ww8UsRjkZIvOyjVu3?=
 =?us-ascii?Q?7no0eQd/3Q1393Tyc7JSzfz8RNoGg7FroTE9Mu5ACjY04q41YDhSTFZ4cQMY?=
 =?us-ascii?Q?i0ItLJDYPqNqkb+sVj0fhpUIHtHL0XDne3BLflz1qCsPU0KXMc9YrVgdE3DW?=
 =?us-ascii?Q?zv0gwiREz/M/n0NKvVVOs0m2a+T/Lz6BnJrud1uHtmlUXEiO7OfnjfeTgAM+?=
 =?us-ascii?Q?5gkzhZ1OD65Y5jMx7zReh5GzBF4rNNE2I2R2EKkLyCZKhQnOsX+xbFjOFF6E?=
 =?us-ascii?Q?2gwTsJWrAISz3JRVAWm8smyzfKn2wBMITr5btt58f8WZmEsmJ9vyeHyisthp?=
 =?us-ascii?Q?gNoABYXZSu0lWkaEpyAKE8VtBD09asNJgmQjzcSqUnMBVzVq3TzvqDe9AqFb?=
 =?us-ascii?Q?mZ8lEt3DvTn08LxM6p8ZTgA43skOyo0C+2dEF0UxalttbrR1wFyMLsqtLlAP?=
 =?us-ascii?Q?i/tbgNSvxyLwqGy/nGJcCLOrH9XCJlbFrTQRlr8lIN7hiqUMATeS71elJbEM?=
 =?us-ascii?Q?MmYAbUpKe32WUvLCwkwcSPrUGlEZSDJ9e5rvRTsvjnEQ/HEuWCO1EO4xJdT+?=
 =?us-ascii?Q?T7QME/3WY1s++VNK0WlFjPFDzLeYof2+gaIzOLRQuQiZUC0wheIhTvchKkVy?=
 =?us-ascii?Q?50pCkV+26HrVDdxf1GqEHfTvyXfCgW6eLZMr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Gb3vx/P35YplHFHHemqBw8wXbfvAysyN4XiazldN92JslcnS95B0GLdgeyC?=
 =?us-ascii?Q?sEjqwJrD/826r9/0S9NoSfjTb/NQbfX4zX62PzjwNGRb1oOc0/dZFNKH22Ie?=
 =?us-ascii?Q?PbWcYi9/D295Glg9PEJIUO2kRDpgnUi9w7FcsM7q6eElyw8YNUkTk/0FWZle?=
 =?us-ascii?Q?PipnIa81H6ANdUhSPwfyTdMOymhqY2cTdmAvmJNpW1HtSYGKXN/HAbW3cCfb?=
 =?us-ascii?Q?VbWDlmq0Q5vxzy3qJYCS4ytYJmGR2NLwcGvGOxpHy59ROHZjfyx7C45vrm3D?=
 =?us-ascii?Q?Xq6MzWFYoFHHZiQeVaoMH/gNXC//DmEirVqLsAHgwcOpZilryzcsMb7BhNa7?=
 =?us-ascii?Q?DRsG3iDbeuo1wa2dAZ9IlAiK+KmQqWHsurkPtr11e/9GlJnTbPfVZqDZrZHm?=
 =?us-ascii?Q?ijp4SUaaLBRkEFjsT4Q1a3w7aLLl5A2X+QoZVI8Uqmeav8eajpjQSIf06LNI?=
 =?us-ascii?Q?oSDj/DDqtlKShO4KrTYUdt5fzax1rbvoGFmpqA0BhSmZQzds5rYDRnmB+Oc9?=
 =?us-ascii?Q?lmoFiOsc9sZsz1cW2egJabhtruYq+4z6bQdhqL/GX1jmHJIsEhOz5Wea3jhL?=
 =?us-ascii?Q?GqxUHG+2Ll7q4+8sOo+JxZsLcxvJvHO6EDJTbD4iOH/qPlvFDo/o1PKOPQL/?=
 =?us-ascii?Q?ZnMLUX5k8jTbyUfxUtiMK7ZeJhTBY4v9rpU2bnrUQHz6KFcGvPzlO7LKzCkK?=
 =?us-ascii?Q?vAukD2Rx7LEJE9laOJvwjSdTt8h4XY7lc1lUJ286OkP2E3BoUq2P01FeRWiE?=
 =?us-ascii?Q?12nAPZ2bnSUbLB40I2difnaeSiHf4tTc+iJNz9xgbZ8ORL47cnRpbBPR9VkN?=
 =?us-ascii?Q?RXC9IyRCkqN80jg6kexsjAVkZh3TI7OR6jDB+SqDxLNbL12uYHDT28yf+adq?=
 =?us-ascii?Q?85GJB37r+HETpy4TQqAw2gZV9cV3cVeq31f0PF9QGw6qDUHexqad9psY3mBh?=
 =?us-ascii?Q?I5yRPZxTyf7cy8ThbLFEZA0v5ft6btA/UiKi4DAu89qVgIsyh1wZUYPNl6qt?=
 =?us-ascii?Q?BZtX01btXgOBN12uSFM7ET8E9j+HJsaXP0hSK2bHUiysFAxd4QHrQh69Sg9D?=
 =?us-ascii?Q?UC8s1i5GA1vhu39qJdpik1PD5sJMfDWmk3xzvmb80DV7yhiYNSSm+OsCwTYH?=
 =?us-ascii?Q?O3VBttKrtmiF2/1D+4qOkFslnye7mUAECiCplpdTtwO7aLJqxfoKcQE+Y+M3?=
 =?us-ascii?Q?ZY1nQ725MXLiMOEogRHJosIbTTjepVkyx4WxkBWwhN30BwMS9LHmOUYJrngT?=
 =?us-ascii?Q?s/r/NH0l43KhizB7HNurmezsXqTwxVxovde6kklwXUZMbqlBKV0eBd8nI6yU?=
 =?us-ascii?Q?4t0aWkIX1XKWDANKXxgRbTmm2Z/WvtJ1ifnncIFwB3IGaZ4fKZgRGv/hSPco?=
 =?us-ascii?Q?a2hfPcoBwP7aEHRh1EOmh4CKd9sPWcupTr3WgoF5+MUJGsV03BJGwm7QhpG3?=
 =?us-ascii?Q?iCsR3oVPpU1cYUd92FsmGqGPMS9zNXeP2eHm+H4zTRI72D7af/ZCp/34cinQ?=
 =?us-ascii?Q?b0qQM9mCmplEz91ZBHQwQVAYWYxzN+Bw96x7NMbq4oL43tx+7J5uo17Gi1vK?=
 =?us-ascii?Q?y6UN54ijVIQicdDuW6Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402a06d0-4790-4265-f9b2-08de0d37b4f6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:43:24.7031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqt6n0SgqnkydFue2HKEQzQ30IV16Fe2Y6GeHj4ebo04382EK0e76QC+0iw6mDm5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11655
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

Fix CID:362787 issue. This patch correct the cleanup
order of PCD and FMan handles to prevent resource leaks.

Fixes: 4defbc8cbb6d ("net/dpaa: support FMCless mode")
Cc: sachin.saxena@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa/dpaa_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 2a22b23c8f..417b9b6fbb 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2019,2021-2024 NXP
+ * Copyright 2017-2019,2021-2025 NXP
  */
 
 /* System headers */
@@ -889,9 +889,9 @@ int dpaa_fm_init(void)
 	/* FM PCD Enable */
 	ret = fm_pcd_enable(pcd_handle);
 	if (ret) {
-		fm_close(fman_handle);
-		fm_pcd_close(pcd_handle);
 		DPAA_PMD_ERR("fm_pcd_enable: Failed");
+		fm_pcd_close(pcd_handle);
+		fm_close(fman_handle);
 		return -1;
 	}
 
-- 
2.25.1

