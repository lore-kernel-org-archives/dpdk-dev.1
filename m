Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D43C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B1D340664;
	Wed, 30 Apr 2025 15:49:28 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 3842D402CA
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:19 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 mx-outbound12-177.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZE74z5IrnFJAMdyoBT9G+Vt370vVY63Z6hLglwvoyQ9G5nBa/OlcmxXE6PvSMVNWqy55UWGcODfQfKsLW6rAiAQNFWW//h/FVIT6LoDaL+YTSL9SJW8WA9Xf5nWySOLtw9IJy/4D0jf9J1pf0imQD3SLvSZtLJheTfj/QQP4GGDsY1USiOgovxDVy9vVdtTBFRPrQUZrtFa2hjBqYlZV6I5N6B3/qLBkoT8fBoTAVig5savwMq3JMvhPw3Hg6nWTyQl9Ok0N6OA09C3VqKEZH37tCfWA/bgse0Xi4KLmele255/eQRShTn88SSpqryvn4tRI5gpB6g4ELAg+xP/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkibkoYxOsEtDxloQVMzg79QdnN3fmmv34u3+HabLuY=;
 b=pAo32ua2rTPxLEZke7E+l+uzDqd0V+AcnyyhF4KjnaTG1breDsmTtZ4uua2dxZmSxdiEa4R9x269xW4BWUtLHDXJhmK3o1zQ3cS8gJ6pwQucKwGRRWYWJNMUErYSPTKH14Rk9qRj63ONXsoWRqM+VfEzmdK2/4IazgSeWSAj8VGNcq2GMplYf7ATqiamwuCPgDElwxAcQ0a+C0SDiPfMWNn91e/yEyP+NqnQWPtYcmVY2NghcLgxYpXlLi1xnRU6aQ+cCpDc0bYHgxkt9otUnI5HXUvJ85NhXztuTuKCsGBbmsKyTNZPsXo7CuLW6SllyGKIXVyzC1x/GlgygJUWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkibkoYxOsEtDxloQVMzg79QdnN3fmmv34u3+HabLuY=;
 b=NO9BOsGjdDvDzgPjTWCVWglvAfEBalwmdCKZEKUydP8fG2gtUKePINZT1aIFNNT5IV3Ej/o9P+Iz24U/S15XwbCVWJTNq4YjpcrqXLE63UMQgRdk/QbatWHmvj6iYNQDuaRRChswCaNGowY4Rf5hdZ5z1uBkam/y9kIWFXjl0jA=
Received: from AM9P193CA0021.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::26)
 by AS1P190MB1750.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:13 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::de) by AM9P193CA0021.outlook.office365.com
 (2603:10a6:20b:21e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:13 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 12/25] net/ntnic: add error logging for hsh
Date: Wed, 30 Apr 2025 15:48:24 +0200
Message-ID: <20250430134840.402553-13-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS1P190MB1750:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a0ad292-9663-472d-4e01-08dd87edcb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UcIO1CY3dHAe8L6w2TjC/0QRKFiqXPPnzSVi9VR86l741+HtnFUIyFPWBwvj?=
 =?us-ascii?Q?5PXoA6rVKQLu+JEqeFtD6QOK5N33lmRzJSIoHx5dp2EX0bYDcDlWhkwirNnP?=
 =?us-ascii?Q?A04nqSIzi0Yu55W8cwSDaZBXo7SvLRMx5kNu6b2KngjzGUG0e9aXBlGp5PZ0?=
 =?us-ascii?Q?p/QEiLnH3UJR1UDQ90RgY606xw+ey8nPYiV1DIMGapZHVySATC0aTx96EGjf?=
 =?us-ascii?Q?n2Sa1d1anF44Kb6Vm3X2VEebfQXlmHZoVNHQH/z+PE8nyHnqfGJk3aZU9C21?=
 =?us-ascii?Q?BwbTA5Q9wUmhnu6j0zxG0VFo8959W6FOcWMTcMTare2MEyu04RvbSFv8A1Hb?=
 =?us-ascii?Q?1wbp2EYQDGjKqaVGaU6Itdd0TktV4Fcx7sczeRHpsfyobI0bQ6s4woyWTLzQ?=
 =?us-ascii?Q?hwnANjsOzsWx0dRTGl1GbLqL/NA+3Uu5jEtZRuHXrKh6NOF1MaGTE37qewpJ?=
 =?us-ascii?Q?SmtthgDqRLQHQgj0/brCjkVVo1tds/OExI6X9Zs2ir6pXKbEYFEGo63gY0Cl?=
 =?us-ascii?Q?K8Ov3f/6wE45HAEsCJqdUOUcnNN12AVBCEeAI559i+Lb5udKM7mynK4OViB7?=
 =?us-ascii?Q?0vOUN6lREchdo5Esjddq8s1vGMJYdBAuIk91Xtk1XZafqtRrrhogZywJlKqe?=
 =?us-ascii?Q?IAv+oB6pqrYqel6C64GgPRY8frr3VADQaTbn5kkDA98QP03g4kahDbyZkRn2?=
 =?us-ascii?Q?J4vUW7W/7apT5X0Xql7l0cFAh6MSkBaHCKn6yghQkJRH3n20zT33HWAwFlb6?=
 =?us-ascii?Q?/RJ9OfCy5y1ggk4zJPbh015aCxgMImiDXDW0dt8olke1HFNE4zzuGq8O6AMI?=
 =?us-ascii?Q?Q2JGEQ+drGwFcUxDnuYjaxlIC1snrVE49FTh7T0SDWi2/ZMl4Nfj7rqKTTi+?=
 =?us-ascii?Q?nkye/ijQszDefAF4aicD4h8OyzFO4ttvQYezsMHypHkaB6bc7uflBOI28Skk?=
 =?us-ascii?Q?0WULZpiZF1Ephn/6xCMIHK3d9fHsmarR2srx9PIIEVBsYvUMNuCXvKR1znO5?=
 =?us-ascii?Q?CreAZp+oh5WMLjU3FxtQ4q/2wCk1c7Qb9tmXTbsHxUcjgkb5XA0n5QnfCObY?=
 =?us-ascii?Q?Go+phUAYyrRk7ynqh7RB0KGtQRMNjtZo6U+tQV20R51ymbgBZ0Yzdte7TWuu?=
 =?us-ascii?Q?GRSx6Z2CMlbpeDxpmxDMjlV99lvXWYlaG4ZZcss0coGR25Tyds05n/eBkpWC?=
 =?us-ascii?Q?xm5T+SvXRYOToqg5sNSxpIlchxQo0KOCCUlyDdlgz0UwjbDvXtT+6aH79/jM?=
 =?us-ascii?Q?w56Oc5pD1MaZIddimnFMypCtjJVbUNHXq49QYJwp3AQyceXuiJhnxdd4vLwN?=
 =?us-ascii?Q?4bIcCbuMU/m13EFLQZ0HWHK9K2zJsKsuH54mF4eF9HXsn3fU/wYfYQJiMHGk?=
 =?us-ascii?Q?Sd1ZaV/glfgBkgr+FAyXuXxYKzDRTzOlFMteH+Lq9M4PYVIlHg08vj1IkKHs?=
 =?us-ascii?Q?rX4jhLS0BjOedov1x8HOf6RSPVjUsc2l5NCDhGQ25P9gI2Viho8RygizlWor?=
 =?us-ascii?Q?cPvHvTA+CR92hjrY4UrIrWBbNG1du0jlvL6A?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MyoC5Juy+wc7yiXPjv+q2dsvf1ecqCS5KRbNMmwNX5rIDpRba+SHNQ9S9FYkh2W3pCovtHZsyp75wVxjI25NW+AckMCdeLKjkhZnSG5nF+0++hxz0oDMR9U2iff8ON9LGP3GyQSp3mGmNDhl9EaoTNjKnQ9EIT98DHVyNKv+B9xYk58foEMHiGArIJpin1wa1Rp8mzwbNi/eRWOLSwW4I2NrqxGbo3Yq4FOcnFGRionIhRtenkB2H9351JH0B14f2Cgclrci/QjM1Azd5XcIaPQoUyvid05qB6xskSuhshYYpcCc19ljp772y3xSk4g8lm2NcqUzZpfUFjP0lhtJ0j+wtX8Mt6H7C4D8fk955vBBZQUNaY4/QVOhC+5aOtC1oESZrMFCMB63KpOjy7m88Hqn8VFRQDVg/PgSGhoiRwILfJcogFpnSyFvkCFbrS6cJGdSTeB3uJC4RSB4OgBUsUsHkTXglpbE9vHaIfdTbVWHWjTmBJZr8PgzW8s2k2cxg802+EKxvL924mxZxAaWWTOQG6Ow7r1gj6qrmmKINx6VWNE4e4vj1+2u7Vruh0JoU/eAryzaJFqxmY7fdVOlf1dyRCMIi7zxtWODBeT3CE0+N0dzx/pJ/KPHDvPOvXeP8iWkzc7lWv9Pqf6xPV+rbg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:13.8459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0ad292-9663-472d-4e01-08dd87edcb0a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1750
X-BESS-ID: 1746020955-303249-7652-576-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.18.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmZoZAVgZQMNnCNNnQMCU5xc
 Iw2czQ3NDYPNEwNSklMdnSMtUoydxcqTYWAA1qYs5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan18-242.eu-central-1b.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Enhance error logging in hw_db_inline_hsh_deref function to ensure proper
handling of HSH RCP preset failures.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/flow_api/profile_inline/flow_api_hw_db_inline.c     | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index fbb7b04cd1..52ca79f104 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -10,6 +10,7 @@
 #include "flow_api_hw_db_inline.h"
 #include "flow_api_profile_inline_config.h"
 #include "flow_hsh_cfg.h"
+#include "ntlog.h"
 
 #define HW_DB_INLINE_ACTION_SET_NB 512
 #define HW_DB_INLINE_MATCH_SET_NB 512
@@ -2914,7 +2915,9 @@ void hw_db_inline_hsh_deref(struct flow_nic_dev *ndev, void *db_handle, struct h
 		 * it is not used by any flow
 		 */
 		if (idx.ids > 0) {
-			hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, idx.ids, 0, 0x0);
+			int res = hw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL,
+				idx.ids, 0, 0x0);
+			NT_LOG(ERR, FILTER, "Failed to preset HSH RCP %u: %d", idx.ids, res);
 			hw_mod_hsh_rcp_flush(&ndev->be, idx.ids, 1);
 
 			memset(&db->hsh[idx.ids].data, 0x0, sizeof(struct hw_db_inline_hsh_data));
-- 
2.47.1

