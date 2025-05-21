Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A8C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:58:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39155410DD;
	Wed, 21 May 2025 08:57:37 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
 by mails.dpdk.org (Postfix) with ESMTP id 20D3F41101
 for <dev@dpdk.org>; Wed, 21 May 2025 08:57:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gcf/oG4PSA0d1boSmaaIMTvt3rOB8OFTLtK6RwlQToSjURlc/h2EAh9kUJIBq97dfrobX3fosNDlWNJZ/f/cOp9TVvEdibzkAzQB2HfBRjOi9l7QF+gu8cru+ImCHaNeB0LSe97pYH6j3/jM7tKAmuJA8Xf5a29BzYJ0Q4s+juYsEfZuAElnOUHyWNYSOnExDAu3YCD7q4m8HOLnm53MzMkxoZbGI5V97CLd7dAB+xYayHLLgThS2PMqzxjLV85tMRw1N5Cbxqr94tGe2eo61KZvbUvdTFEpmi+XCXs9b4TNr92GJYVS/ISpCKtcv7K6pVKpaA32sB1X5hvWzcD+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbgWWXFBwG3TgLJctraa/L1yB0+MqONsjrVuRjxFmXg=;
 b=d09i3G72hIIAl/tpjAb0eV94fEIOoyuKyttajOfSYbJOX+dF6+nORqDehFksLptMn3R1o9arar6ZqYfzWbsAE90WRb1ypuChBFzTO3n6jh2vh30e5W1du2jKFp7JviLlXvnNnu3EXham9RiyKPH102v19XtqOoaJyYyXM2avo/d0iLY0rTCoTUKYdyVGLIgE7cLqmGZbtWAYqqpjppB/D7hnpiUpP6M19C5upPnBv7p6S/p0n4OgiPw4BBDBQ3Yzve03vBS363zNMRv3UzVgK4srzW2GENor8aBFZ4LCTc0PkBLIJwP2B8pha59jCpfh8YdJD8ZbYmqlgrcVLgJrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbgWWXFBwG3TgLJctraa/L1yB0+MqONsjrVuRjxFmXg=;
 b=ZuVaJLepZj2ZTJqvCM2XyXMdTQ2kUJeIdrWjq4z1NFoa23b2YaIdhzylsx7hvfYXQh3zwIVDlr3uDTWAqMn1phwWbY1JKgbQ43U2woZDu052MMXrMjPR6tq7jIarHNet9emFtnnf0zLZkuZWJK1FQQwPa8Rjy/5uSiRet1nYNI/ZcUKnfsKJEzdW6EhjFwXBUOMpUgI8UaTrMBOLfYVihHZnJSX+RzVQIq/jzZH2/MqMJ1DNYqTS/Gx6oihlrtIwNUpKwUx7znJuevjSBB3pM8/dZTuuPmK/ghfmZm69rEUQ342o2IKM+MsG+P7nMuh9j4kTPTgRWx6/P5HkRA/B0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:57:34 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:34 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 8/9] mempool/dpaa2: mempool operation index
Date: Wed, 21 May 2025 12:26:57 +0530
Message-Id: <20250521065658.857707-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebbe6fa-764d-4d7e-dfd0-08dd9834c35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I64civW659MC82QWmzybcGdlZlWru/hTIcnT9NtqSiQy95zqKJ6rBwYwVxf2?=
 =?us-ascii?Q?3FtOorLhnfEIoZo9l3iZt0KVjRQhNDBNfeBfGJ3dK/MudFOGsdRTqsjPoqDw?=
 =?us-ascii?Q?6iKS/QKx28ffV+QGyYgWUL7zSV1TQC1SZ+npeYqscZXMShmcL5LKh8aKOtK+?=
 =?us-ascii?Q?GhSs0wFyst1q0KaYOvDg4JwuZLTOmxJ/WzF5flC5jD2o/hTlHRJs6yX/Ep/C?=
 =?us-ascii?Q?gGj98GVUMoyWudZwyqVrdCeZIfeXw9a6aLdSIec1x60jQnHIWlsAZ750ORBf?=
 =?us-ascii?Q?fISb4ScKJBh6ny+hcwkDD3g1bMRTrURt8qNSwKSeK47+39Srn06HG2PQ9cvb?=
 =?us-ascii?Q?ExuumfVwQrw4a+cZ4+dVHsfE5a1/2bJFFPIxeLGNvPQkyrRbC3y1G0N2rKD2?=
 =?us-ascii?Q?F897CqLQfpu0XEAvt4VGMZkI7R4yX1CFfiMEdBEd1TuQqk3iD8z8G8wkGc4n?=
 =?us-ascii?Q?sCAxXCnticBbNL4dFiQnIcssyBM3VCdCHoON/b1lRFqsz3iWh1YxldiuvvlQ?=
 =?us-ascii?Q?hlQWg7YE9LqRH4UYtnk68uWYQamB5yOpwE93/YxB8G3j8YgSY9e10yEtJC3z?=
 =?us-ascii?Q?jrIlwA7ac7tHqB7Uz1rqTn+yy79Ltsy/X608OoUJQyZzqsfEqmvvEorFR+uA?=
 =?us-ascii?Q?uEzQl04A2QpprJ7kRemT4jnC+eyU/LdwpVRmwbr/aBix6Z73nD4aSI8G2yym?=
 =?us-ascii?Q?yUpd8A3ljXxEXVWd7PIx1jLcAH4uPF9kSkLKuJTEYrd8i2uPV0Iz6E0D1cYV?=
 =?us-ascii?Q?W5+Fpr3Lgq5c3J02OYq4v6UVoPoHESCJjmypzMXJaQuoriSkf1rlL85cn45A?=
 =?us-ascii?Q?8bDj3u3jZaISMu63WVG29Qcg/Tt7FXW5XgPO3ED7FulAPPNR9DdjV6fzE7G0?=
 =?us-ascii?Q?2mx2mCKeb35mM9Jyah9H9X4a7fsm5maSFHzTgH73T/G8s5W5qHorJRtqPMCD?=
 =?us-ascii?Q?HlOQohKR+quZBb5qLKOu2PwpjEMcHkQee0R6JCo36QvTYSGuC7ZxHipd/qAi?=
 =?us-ascii?Q?oDg6knRVXhyzS/i2tgIHbRH3sobir8YDL1O9K1R5mX4vu4B826dpdLve8nbF?=
 =?us-ascii?Q?5n64I3NGY5ZfTVEobEG1wXDfGxcnkdo5Fv6ykxuzR8nVFOmysP7c2r+nzG6G?=
 =?us-ascii?Q?APS2GAtZwyOcdBVvPPl3KRRCkn3F9vVmKvgaw/sZIKuORCkP1lRMMcHdpAV/?=
 =?us-ascii?Q?JcVLgcJNPm/Fk75OodazAZNyLpZCUxi0b3W5XT+R631Uou9QeQA74fzCFnai?=
 =?us-ascii?Q?kLUKpZVw5JEEiEqmTG1lAReAEvmQFpVVgbRAq0fFZFjmvN3rY/xRiSSV/loW?=
 =?us-ascii?Q?5txivgVffeTiK9mFd8ncRxcEXJrJOU+q02C+gAwwU/8ZRZpO+Brpf4cgdWYU?=
 =?us-ascii?Q?DvO1vm1qgFGQRW5QOrt88CEt0hJmj1T/cFWWXJLsF6Jy9QCombPsYgcnJypr?=
 =?us-ascii?Q?4MQTfRWOQJEi8xxXfwXij75d7XCYxueLTdOMKFVHghe29bGeBcbfBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGMo+14RfuZYp14lfcwj+9ROzUGRRczxCsHmpQwOuHAubbczxhubdYzNCk0z?=
 =?us-ascii?Q?ZoxZ8ODKrmhiu5K0bJOPw9pYABMa0VtG3smOwY7+4Z18jXVROxU5kKxb8Qxw?=
 =?us-ascii?Q?fOCUIUIrqHdq++0T6ZcOEkO7LPQDbdicL2At9WfVwRIBFojHFxDV4KouOHLT?=
 =?us-ascii?Q?c0HLowpJz4KwR8kKb4DSaARhoRmLP7n19yz6bAP1XmIXs/eldJx2sEqRxwtP?=
 =?us-ascii?Q?xC6Aqyega9wuOsx29q1KVNhXk3d/qNJ5mdxKD4DleYk/bkdFDBRfKxy+yn7L?=
 =?us-ascii?Q?4B1jFYwoJRdfTsErfDz8bh+5HLyzgmG6A+WmY82R6s7GvmpUOLL4HPqsVSJm?=
 =?us-ascii?Q?8GetNhcICuzpZB+JGPDxP5gLk2iOSto4PfkvcoQ6Izj2hnyv6hV+KvY2bvRC?=
 =?us-ascii?Q?qmtRcWsobmuakJO3MmCsJVe1x5DhcWylCFh92Nx08PP/e85QhD1DjbNQRsf3?=
 =?us-ascii?Q?O+8jFmyhcz0AKObtUgtFf7mtXc1gIt91k52+Pg3ygtLGah621WLMbQJFxjOv?=
 =?us-ascii?Q?1tbVnyP9dcvjE8ddaFrZXai0+ptXAGP9QM8zn4D4fJ1YLyqo0BSVc0/IJMuY?=
 =?us-ascii?Q?pnCJaswNVrIvcy2Ektq4YXFU8A5A6vzSFrV68MJn37aKxKu1OWL7yLf3G75w?=
 =?us-ascii?Q?muqtKKyfaZlAn2TbKQ65p333nmiKqY6j2sr+oFR7AX8Vesm/P4aLiuUb//Z/?=
 =?us-ascii?Q?tRm01BK4pp062JXfersDYZPAQlz7D1s+7/Yt71/gTuVHfhWeJi8wk13PPudi?=
 =?us-ascii?Q?dI0suV4H86HIJa0Hm16FOXxUfe72QtMG0/RoBeLXKe7Dq80zc8bzLP0dRU0i?=
 =?us-ascii?Q?Qi02hQuNxMN059BsWompyfGngIoDF1Hx/LeVAcz6aAT9LiorINlPhr79Id3y?=
 =?us-ascii?Q?vWVyeGn4bTGu7Yw/MEACMQErnXiuo11ic2eehSzYb8ZyYp8V5wUSZTnD7unW?=
 =?us-ascii?Q?FxgJ53+KCo31gTms3i6PcEQCe7UmZf4bU1Jk26rbbnL2l+2FZaIMh3bvHXjI?=
 =?us-ascii?Q?3D/OF4OQDRW2/UlJ6dNWXV7ahsQMz520LJDx3fSi9pkLfUp1sH8tPmm98Ipz?=
 =?us-ascii?Q?poB1tNXIrrVNw/TrdCKb7ndeCQ5m9vF6Q07stqs6MEvVOIRdkv8bW0yb3KNq?=
 =?us-ascii?Q?anxc2sJC2YeNrRzD1iKx2sa46nMgmwjO+WzKUc1nAKhFaUyX7Z4qqE3qn/wK?=
 =?us-ascii?Q?NgavXbfd+fV4KYSvexUt70j25hLnxpp4RQpi/BMsiy5HOUkTaq6JrgNfXj8B?=
 =?us-ascii?Q?/Qx0auN02m++Sv0G8BDjZH7RjKgCkeMq5/b+4ZDZ96KsZXwFMiWYyD+4S04W?=
 =?us-ascii?Q?gK+zP3oR8iZnzrq8ADhGeyjKtW5BeZQiXlpu/uSjBkWOURf5ugQIKBDShbBR?=
 =?us-ascii?Q?Wd1Sfry+arY+Xi4+y6B43kxgdOGKIu1oJDWt6NaIjOarPRQqNjjReAYSbFlt?=
 =?us-ascii?Q?eFjTz7gteeh2SpJA6Uqgvlw7IxVV1qWbB9zTjRKt3/e/bNF7cwV1wKYx2KWg?=
 =?us-ascii?Q?S3arJILEtthRL9YGIKs1XGIFiXT/GwXkAZVdyV2tMRTlFkZSA863le+T8sXX?=
 =?us-ascii?Q?KWtLnLpSTzWdDsBqrO90xSSo6e15Ej7HH1O2wu8k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebbe6fa-764d-4d7e-dfd0-08dd9834c35b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:34.2107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VMtsRt5iq/gFk3FWg4rW3gGPrQO5X4NkwEBOMHvoumRrJ2QrK1Yr3vhSiZTw8Cq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
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

From: Jun Yang <jun.yang@nxp.com>

For user to identify dpaa2 mempool by operation index.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 20 +++++++++++++++++++-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h |  5 ++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index 09729d2828..118eb76db7 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2019 NXP
+ *   Copyright 2016-2019,2022-2025 NXP
  *
  */
 
@@ -38,6 +38,14 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info)
 struct dpaa2_bp_info *rte_dpaa2_bpid_info;
 static struct dpaa2_bp_list *h_bp_list;
 
+static int16_t s_dpaa2_pool_ops_idx = RTE_MEMPOOL_MAX_OPS_IDX;
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mpool_get_ops_idx)
+int rte_dpaa2_mpool_get_ops_idx(void)
+{
+	return s_dpaa2_pool_ops_idx;
+}
+
 static int
 rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 {
@@ -119,6 +127,14 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	bp_list->buf_pool.dpbp_node = avail_dpbp;
 	/* Identification for our offloaded pool_data structure */
 	bp_list->dpaa2_ops_index = mp->ops_index;
+	if (s_dpaa2_pool_ops_idx == RTE_MEMPOOL_MAX_OPS_IDX) {
+		s_dpaa2_pool_ops_idx = mp->ops_index;
+	} else if (s_dpaa2_pool_ops_idx != mp->ops_index) {
+		DPAA2_MEMPOOL_ERR("Only single ops index only");
+		ret = -EINVAL;
+		goto err4;
+	}
+
 	bp_list->next = h_bp_list;
 	bp_list->mp = mp;
 
@@ -150,6 +166,8 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	}
 
 	return 0;
+err4:
+	rte_free(bp_list);
 err3:
 	rte_free(bp_info);
 err2:
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.h b/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
index 9e21823fb6..8b2718bfa1 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2019 NXP
+ *   Copyright 2016-2024 NXP
  *
  */
 
@@ -65,4 +65,7 @@ __rte_internal
 int rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 		       void **obj_table, unsigned int count);
 
+__rte_internal
+int rte_dpaa2_mpool_get_ops_idx(void);
+
 #endif /* _DPAA2_HW_DPBP_H_ */
-- 
2.25.1

