Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9CC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E359E4067A;
	Mon,  9 Jun 2025 04:55:31 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
 by mails.dpdk.org (Postfix) with ESMTP id D70AF4066C;
 Mon,  9 Jun 2025 04:55:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MU8+ghAoTmGelk7Fz8MQYS/tK9cyplL7s0YfsqNepG77REDEiQihcKYYQoSZMAWQmWEC/Q7ArSFgWfJcNpd9u1KzBDxs5VJ+0wRiG7suTlBVqNvY1fq9QOn8giBCbRWxr3q3d54vWRIM8b7Rn/4B67Y4/Gt4MdC2FELXMOrJMNPaYHG0rktTQtNWa7WIjSa2wWPzFMrNZuPaPYprJ5VYO2Efg8msvj7ujZgugGH8nYNp7wDQlmfnoSsKFwtqNSyKHkDtY4I8quuSw+FdYZiXu94HgLMNJj1BvNQZPlH4h5QknOPVRpqnnby12Dx4eJtKxsyS7kn33489cwqoJMBZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=nWMsJurvGgJ+pI8Ge6WLUNYYLWmqTzL8eTgVkkDuqlLaE68GXJxcm7yxKpL6KUALcXmqDYvYSGL5BOHNQX66rPELyzEa9SRZ/h/Ue4Oyuk1p5wBcl6yI+ssDfDRJsWEqAR0v18K1CQGzVyBgBISeT3oEZ/IKFe9YOe1T1zTPOj7WCoP5y6Nn5mkKP0u/X394+tGiL5pAwCPvgrsOoxM0VFiWz5B+24doMoJ7WOe8WoEiOv3kRRgkhWy7mrN5ucR+wPJ0r5I+VOjw0BzAPZhKWJtftQVpl7IPJrANkyKUE7UtaxPDSLvCheCJzKIja5y0mb/xzThgG9/ZDPKTwJi//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=IV6Mb3V0TZo7HV2NtwcA8UmHWQUZOEGLK/FJtX6hJ7gBbE5Wtvi04FosGclEoVzw626iNDc2eHKFeioD3iyxf9WNPlinKVg3ZRrkDhFT8erf34LVUvMvJqf5doIZx4BpHVncuzgxIMCh9tnFxJ5c1rIa599blaNYQeKT+PI/LsRky71VKn9SAdgbLYioeBb/Lnjf2fmya7/+l10ThrOD4G4lY3+zfZUBBQRaLJPIse3Y1yeG2XgMKE5elDY8E9PpMwqMyLgrf88+x894K4dXHyCSraxG1lJt01l3k68lAo7dh6rJOuzrpepCltvVoDfpjVKyCkkP6/+oZAgh6O/4Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:12 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:12 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v3 02/11] net/dpaa2: fix shaper rate
Date: Mon,  9 Jun 2025 08:24:41 +0530
Message-Id: <20250609025450.3997062-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609025450.3997062-1-g.singh@nxp.com>
References: <20250602104041.3322164-1-g.singh@nxp.com>
 <20250609025450.3997062-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 490570c4-a2b6-4946-838f-08dda7010d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oV+koKJMPkQ/jQY5KhixNrv2LbZ8+hh6cWswlP/N4gRtJYeqVfwHnNZJPZkS?=
 =?us-ascii?Q?tfOrFbbIxzplXKEl//Nmks5GTEQnw4NqQEWy7wyTpsc5TkapuiuMeDu3jv3j?=
 =?us-ascii?Q?QyP0WdahlbaErACo1P59O2FyG0mNAJTBrwY0++EkJLjL+Hk8IbS697kUmLYC?=
 =?us-ascii?Q?ABNjp1KF2plz5gCFXDqLWL2jNByyIG6PzVHSxrXVmbipQ/LY6eQf2O1Cvt23?=
 =?us-ascii?Q?yNOgL51WHVl5coSMkhSyon7+T07uBM8by6lyJK1rBEwIKaG6EV37HO644alA?=
 =?us-ascii?Q?XtZwkUWfKKl12NhRMhB8FLjBp4HObJrsXFQ3WwX3LKjgThFruDGdOq5duSV5?=
 =?us-ascii?Q?c5xJBOxbiJiZGlsaU16AdCYn/iZt67rOI/swezW7IEm1G8cQOD8xhl4jw8TC?=
 =?us-ascii?Q?/5jOaNUlodj8oRGwm6mZuhKVE+FolgkdhxyjRl7ogw/rsu5miFFZA96SdXSU?=
 =?us-ascii?Q?Tq79+TD6XmPtv70p9+tZGClECTOt5Gk7r1Ck6DWZjsxj8S1YojyDhBCPVd3w?=
 =?us-ascii?Q?sFK7q+1XmF8wgfKQo64NNO5l8BMgi5CMhMCqes+KmYEEJU1D/hsf7xNeVsfQ?=
 =?us-ascii?Q?gSLAP2rogWWifraijVvnuuHlC4xtLA3blIJuMrdx5sZmnBra/LzgNEj+2NVq?=
 =?us-ascii?Q?wO1oS06r1846Il4jfZsTrozrd2gYLMiDT3z+cBUYOD4Eot3TVcAR1Pb0R+Ve?=
 =?us-ascii?Q?GCwheMqpVuQjn8plvmMQJFmnbSwXm1WR0qg8PTas0SiPkeEQFaRCsrk6c+0U?=
 =?us-ascii?Q?oWdbZoKEyt8NSo+JEo6engnOEHsXWzGRITkoA9yOqJKlT2j2ekHB/nhE3uKa?=
 =?us-ascii?Q?VIZOgS2aT48hAG6csFF8VVYL+gGXWkVueafXxwZghe/qQfSoBhiIdV9jcb/r?=
 =?us-ascii?Q?2c95WnzEL3JT1Icz1NCOq70DCHtAZoGF3LNY5tY/y/oUQGN9LTnkbq2nZrMN?=
 =?us-ascii?Q?7JLhQREbuJPI5Caq9P6VAZKZodmsLHwMf1SibJs9zdplf8FmCY5O/oLh+0sE?=
 =?us-ascii?Q?egpwpmMcI2632nh2dnHq5pH3pCvDcUpanSA3clJWq9It2V3DI2zTSsdDwQ7w?=
 =?us-ascii?Q?3fRkEYL0cvNJt58Rq8QIsAtWvciQrY7J5Pj0x7Bi7xlQvvB83AqkcfkTFptT?=
 =?us-ascii?Q?zG/q4yzibMtuIUXgPH8PX0lnCAFnhSKYDLXthdjf5Qm5wusNxbmGVFQmMvJi?=
 =?us-ascii?Q?Oifb2MnRi6x4ED20wGBQ3Vjr8wN86/AP/wMLf51R1HAOjMsMpZT0gD+KPHX6?=
 =?us-ascii?Q?2U0aaHOY/OvN5VUqykdqBUWMz8pKGjd8BhbXmlNHD9rRbKAIbcj+o9j/DrRS?=
 =?us-ascii?Q?FkUgYJ71SS7Xmi7p57S345WckS8MGkcvV5VVrszuiA2yQ7AQhug8flBRZrvf?=
 =?us-ascii?Q?rEdXm8RviXotMvoqQpiRG7r8QXe4bN1fMUFrMoqWQPOA/ZdrZHh/lHpWMtTx?=
 =?us-ascii?Q?aJpZV5iL2gMWWuuWbtyNkDiHhjq7jHUdKjN0PE8zISzlvYsbdL0GqlfoEA7C?=
 =?us-ascii?Q?bStUx5xydCMZdXw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i2z6k/sKX3hBYC4zMimtWUZ71/1+G3mqgL6eK8ug8sBMohShQ2NugacNNuMv?=
 =?us-ascii?Q?AZaHVKlxccAiJvRwtgbofNU9bR2pNVfxtngoK4ey4XIFMDFsDTKHOGLK6a3C?=
 =?us-ascii?Q?WFYGmEf5qFfFaCYL5i0ernzhhPXPDkVBF+4Cr8yMbaeAZY7icLuvy/JenOol?=
 =?us-ascii?Q?AbyMUt2mCueXDARHO1AgF3/N0/x7xnULs9cPh6ySvzhnbU4EI4URvWDTM3wQ?=
 =?us-ascii?Q?qgJTGlo/mQkdIP6/mur43qpfP4hP9Q0sZWdR+lN0UoSwVgdFyOWCR5h7K7yU?=
 =?us-ascii?Q?optaWdZvyo3CbPqSv0DXZijn067xGQcZC5Oc3x57lYix1AkW9xy8yRgT83qS?=
 =?us-ascii?Q?YQjjPgvcZP+vm3UsBzsExMXV2kJFM9q+3F6hdEOoOV9mjIz6ncA9DxYYUs9S?=
 =?us-ascii?Q?+9LMqHi6rJO8wTEf5wUW0r4nuirtKr4Vkxi3GbCEW+BzuiG4huMat512J5WU?=
 =?us-ascii?Q?4Ri8sFoLkIyOt84+yqyETB/Ah5FC2GH7oVl73a/+Lf11ydaLTYeONWz+Wdla?=
 =?us-ascii?Q?3xXqOPx7tyM1rIknEv6ggo2KMKsqA3pwnGgeE2SoQcp5UvHVmamxTDlKmmN+?=
 =?us-ascii?Q?o31YDLnAxxykj/LbD8xi4scCThtfRxGXRc4amTMuGrL15mDeigCA3jffpYkS?=
 =?us-ascii?Q?5UJ6yPd5dXc9T71FxRGVpaiSOO+hQPVKkDRRyLmRIOnssYWIBykOTdqnz9zf?=
 =?us-ascii?Q?00iYoOeIiDGPoYDgmFlpJUTHqdyDFfDi5WZHS8c1XJWUQE8OVBVkfOBqHdxS?=
 =?us-ascii?Q?5mE43ibTR8BDOp+U8b1gQ6z7j1lH77vAm6K9y0eWTWmtuyexpKV0Ug0n/Y8Z?=
 =?us-ascii?Q?MkXZZJ6z4+i0UEpp4yNw1smfK/5/Yg/xGj/zyGwHcV+dUOUe+7RY8LvsAEvx?=
 =?us-ascii?Q?SHsJr8qAizPDyZw/dLGoghJWItbxOZAxzt7rsXg0MWGIC7YgXSIXvUZ/4qRZ?=
 =?us-ascii?Q?YtewLmBFap4GvgB8uSqCAXJa/JtRFlq06oZ7xOiMXbsV+rHDCaubQ+v0plh0?=
 =?us-ascii?Q?Gf80xE+SbDn3/A1Lbx/jwISN0gN/rbMAtaCNlyxG/muGS9dOOKG6dVnFbE6/?=
 =?us-ascii?Q?Xpdhp26HZQwHVwedpEwnI30cO4vcnKTFGIb5boGv5i3UynxsFMXDAEuvb74q?=
 =?us-ascii?Q?X2y4mTwdmLic0BTzBhDWjWO1ngtNLfC1ahHuL1bcZmP4TnXruLeeIV8ZusXx?=
 =?us-ascii?Q?38w1sJPLGLfY2iz7IokkmSybmSZQkvOIBwKwnFS8yxAXeKq2vaGOCr78CFvJ?=
 =?us-ascii?Q?XJjWXtVJD/FIEyrNLWDCOIZgcecIE/RBH8xr1ZRHQSQAGeAhYZBED7dYKzbf?=
 =?us-ascii?Q?Z3GTno8mtzS8azQxVo240wX2NwwJ2Y6RR40CGudNbPjNH7lBEGKZndsG7Z9w?=
 =?us-ascii?Q?CMmye46zxbGu7G9xA1IhaqHp7Glr/E48NgOOT5+pKJd2PpIl3EpOrbpC6ssP?=
 =?us-ascii?Q?Y3UAdzodWppVR4XjKH/q0rvskhl725t9gPSkQGlrpXZpv8P63zz+y0RK/sF6?=
 =?us-ascii?Q?bU9ZgrhHphR9jFsVngPt0aoLJls+8ZrYHvk8ue+iMI4GEX8Gn/aNWdjmR9gw?=
 =?us-ascii?Q?+Po4aIgoh4Vw0FjQNoU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490570c4-a2b6-4946-838f-08dda7010d47
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:11.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byLBiQSPtQUrNZtJUBvZghjKSmaHq+JZOUPn/Pfa+5hqeAPegDbdflg8fPRe+vOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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

This patch fixes the shaper rate by configuring the
user given rate in bytes. Earlier driver was considering
the user given rate value in bits.

Fixes: ac624068ee25 ("net/dpaa2: support traffic management")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_tm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index f91392b092..dbf66c756e 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2023 NXP
+ * Copyright 2020-2024 NXP
  */
 
 #include <rte_ethdev.h>
@@ -733,12 +733,12 @@ dpaa2_hierarchy_commit(struct rte_eth_dev *dev, int clear_on_fail,
 			tx_cr_shaper.max_burst_size =
 				node->profile->params.committed.size;
 			tx_cr_shaper.rate_limit =
-				node->profile->params.committed.rate /
-				(1024 * 1024);
+				(node->profile->params.committed.rate /
+				(1024 * 1024)) * 8;
 			tx_er_shaper.max_burst_size =
 				node->profile->params.peak.size;
 			tx_er_shaper.rate_limit =
-				node->profile->params.peak.rate / (1024 * 1024);
+				(node->profile->params.peak.rate / (1024 * 1024)) * 8;
 			/* root node */
 			if (node->parent == NULL) {
 				DPAA2_PMD_DEBUG("LNI S.rate = %u, burst =%u",
-- 
2.25.1

