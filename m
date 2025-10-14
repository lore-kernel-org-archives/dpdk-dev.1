Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2D5CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B63440662;
	Tue, 14 Oct 2025 12:17:43 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
 by mails.dpdk.org (Postfix) with ESMTP id 41EB240678
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:17:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pA1XRUYL9zS+8l1ivHMFWOQf0rqcjTU3wlaB3nGLTaU91XaDdZJbeWUCUJilP0QiCbe/LzFf9bpsgbZjev9TzL29Z5zBbhza1WfksQd0pA3qIvobc6FY8PBKdoPqncfw9N7ElOilhvbJkd+GURyfb6icK3F8sGChphRHLmjdWoGAenZrqVOb3w2r0eo8aUzpNbvUVzTd3lnyJHxh4OC8EuJJYrmcoSCGxdMvdc4/fnF2Gws4w6SZ9PZCDmEibdYR3S5srqJsJis6H8nGlWRUefAlPaMXk6A5s/g4mgRqK+kHwwX2eigr+1FR7zXIpQftIdwivZloOoMsaBiYoIe/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=HPocplGCGdgg0bsfGOvZVugmnCKpEDPg4Cdlvmek/j06BnyI4mQ7A9WLHqq5jIV2xz/S6ejgJX2J8I4sZnmkxLPf2/kPISc7Mo/hC9oumN4+CzzWzzaeh8lkAm8lDA9ZQX6ovnaPbQhlJholOyy7RKELbqOvutm9OsJIt36JCJZ7iqaSaFKPBTXctpxiLXhuZecepg5jPGm42xZFcx6B+06u9VvMju8oZp1byDVx7mugMyVyfUTS0CsMXLtt8Z04xkmwEft+bt9BLeJCRkIbaW+kOGVgp0raTkm/rIVY4ZT27EyiQy+52igWgew3Zkh4u5Ezwcg9aGdLVfP8k7zrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=EA0cbjcc6Eh3FJDIZeppUpBzK2PiDBZXhcAhM+O5VCYYmlOH03m79chS0qelniOvDWS1HEZkaw+2J3EbOLyplgdZFMYOzIoCxfSw/QqNBUZ67ZydY8TyKi8EySmbwVPFDPmmUy4O4uSQIWhlx/E6K6M5Shdvhfn+xXWWv9RGobxYy6FudgGW+5ShhF8hTzpkssgbgFraD8abFAQSg0SgYiBkOs1XZCHUZ1jMr8rkE1cXKITuCqzv266VX1HZCzL7ElSr8D6bcJNdsSiJkqWAP0vzJZMiplfEHQVLVNQ8rP5FIcxdBgKG8zcNm1wSSYF6E/8JXLWRexIav9MQi8AvoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by VI0PR04MB11746.eurprd04.prod.outlook.com (2603:10a6:800:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:17:39 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 10:17:39 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3 3/5] bus/dpaa: Disable qman Invalid Enqueue State interrupt
Date: Tue, 14 Oct 2025 15:47:14 +0530
Message-Id: <20251014101716.2885563-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014101716.2885563-1-g.singh@nxp.com>
References: <20251008043519.2461707-1-g.singh@nxp.com>
 <20251014101716.2885563-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|VI0PR04MB11746:EE_
X-MS-Office365-Filtering-Correlation-Id: 2594eea7-d6ec-4287-08f2-08de0b0ae737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?99BKyTMIehPNBv5NCC2b0zwH0bClVVx6wk/ljvQwue9tN/eCq2KTKtLHvQEI?=
 =?us-ascii?Q?3wkB7eeIfI9WFmzOvJMVyqgZysHzqh4dfZZY90sUGAf9RZ6nenR+t07u0PlI?=
 =?us-ascii?Q?CIEFSe35TXlup0s53IkN3KpEyYbGrQvzDi76+p7Xo3n77E1Vf6fEtNp4ER1o?=
 =?us-ascii?Q?nvOfn5TNPC8cxcKFiUpxCe5QX/O9O1By2R98Pc21TyqK6JGD0NfVXNTdLLea?=
 =?us-ascii?Q?QSFDHmwlQC760cTWfcF66WxmHeK5sLmAbgw6xJnripv0isZ03fsKFCZhz0m3?=
 =?us-ascii?Q?rP/o31UN9fkA5bEJ6DWG/B3tKBhOxJuIvGUk/ZjnxORyH/mHNtbxw8D0htYv?=
 =?us-ascii?Q?NohmcLn6Kc47GF/SnpHaTp9KVzWV+r9dhdBjnLK5qDVCQ4lWjlQmZOpyMKuZ?=
 =?us-ascii?Q?guw/xE7IrCbVfwVqm8qtqzgcxL/OyyJ2+IQj7bl6jdWFL+A4xR8EJexbdpaN?=
 =?us-ascii?Q?e/TctzJZkah1+FmglWl3t80/Dtjha5BQWOJDRR5Cl9Iybc3p87CyW3ACW1UJ?=
 =?us-ascii?Q?1i59BHiDyOmbiUnWUiuVgPgYdeU49xn81J9nYal1yGCFWlKoicfXdGrgb4hM?=
 =?us-ascii?Q?8MRJaLcV7HvuY0VjyMlWWyyBoc9BKEUUNhjQ0jMKAFbfcMbOGCnkO4syXZFa?=
 =?us-ascii?Q?MN1GFfhJt5QRFGvd+cnjX6pIRnAkonIz0rSKDNQHDeOZuWQw6H+DEKry6wI4?=
 =?us-ascii?Q?xGDYl2qOKZ3GneCi2KHEB/lS0n2C+2xxB2Z4Pn0Bo2fgMaOpf21af70lGmhW?=
 =?us-ascii?Q?RgIz0Inl/TTjY16r1kb7kmWxamot4/AgON+WzTM06M9uk0GvQIHRSd6TaWmR?=
 =?us-ascii?Q?iz2iM/ZDYMjXQzwgSp6qaDiIkkcU35fTigHctymNkaBpBpAq91FUXrbMnoFd?=
 =?us-ascii?Q?hNj6iXyJHe3aHbJi0fJXvgPNIic2nStYgswwtPl44vrpIucDGYIenYSYqPLs?=
 =?us-ascii?Q?H244DZCENtol08zV+7nPP3ip+8zLpQdiv/dCQwEDb1zKPSUzwtaB+4RQnl5D?=
 =?us-ascii?Q?fP9flQFwmncJK0BwUXU/4gJDZhWophaciN1wlwfvtWzNb/jy7wxdIoTkZhdY?=
 =?us-ascii?Q?kS9GwQLW9cC0uT+JzqwNaxiH/tW5IFME3ncIxQxXvJocbo5gj+SKYiwTyJYz?=
 =?us-ascii?Q?+O9s+mk/1YXyss/1lNLUSdEMmmaUL167g0AYfcdR9rYSHxJ6GFGCLPtHQDAQ?=
 =?us-ascii?Q?0xDdZu5FjzrPr7u9kWr4kNkLRWZCi2gKkQDn7jBpwsLJs6gmq6tX6UIfFQA5?=
 =?us-ascii?Q?i3AJhHK9JMIgipu6+WDEB7drTzzQ4clX8ipTT2SEIP4ihdhizTOssYmX1Tt7?=
 =?us-ascii?Q?C5CUJzGFCrVmkkt5637BYzVu7FwXLchhoKqRLCRWYb9M6foxumniCqcNDqRs?=
 =?us-ascii?Q?2EaQ1ZXvBPzXQOZKv5+ruEghzAV9uzjMDvTLTkpznUcyiJCZkVR3Ulrsy/DP?=
 =?us-ascii?Q?Zw63eeEJtKa6aSN2vsNdkbwu82fv/LVuD9FTjrOg6+4Yk+TQQH3/4+OAec4N?=
 =?us-ascii?Q?uJHgpJUS0yD+pn9f78ZB56Mw7lmaPvyAYFXa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0do4Iddn91azfrxYqYFoRkWWVqTAE1Kdl6qsy5BpjeWZVUgVDrKZwIHM5nQ?=
 =?us-ascii?Q?d7+742Ek/vdrTL+kNOAVBBg5Hk8+ZwjMY/wsBohyNSDFK6LpEyEATCjTEhYM?=
 =?us-ascii?Q?m+DfDI/qPHGFiFvwNfwtnTjgP4nl/m4SzYY4xBfgJdG6kmzfzkPAuXkagGkK?=
 =?us-ascii?Q?sgxMaafwU27Q6PyGx7BTjomVMKKMQo/RXSlaJcvRz1aC1ryI/eyVAiXVktwu?=
 =?us-ascii?Q?Emsx+eRyQILUOfYTJK8O48+nwY1vlhkKbKdykBlNsJFQ4+jBVn0A9pPf9csT?=
 =?us-ascii?Q?Z4Quu9mwvyqIOSIpoBjCWvDu8Q4xF15pE+NguM1RNAZsK3S+zgIYe7rEgC8p?=
 =?us-ascii?Q?CLBYjk3BhJnf75NaIz+KTcXqOOqUgU8Xl2LHcxPs6rTfsGsH+m1Lx5cnlbal?=
 =?us-ascii?Q?Y+isTVql8YlyqYdsy+nldkoBkK6IUcnJ1DiFmgNDsBN94jGiVVx4RKJpvcFO?=
 =?us-ascii?Q?q9+n747PRyADbhAH0hmLXKhjzEyC2DeW1PHP9n0S6h9JoHXnUQrCHa7MTE5l?=
 =?us-ascii?Q?YMKDtuSLYNwtX1vZhYRO19unjT1+pRiX8wxutEKLV1M1Bl8ehSfFdDWahgSR?=
 =?us-ascii?Q?jBtdlTt9fokhXBqCeJni/fRO21dE2wl/K2j76m0zlxrbz/J+9Gr8GaKWjZNE?=
 =?us-ascii?Q?JJiy+XaHdfvyFCOkamh2bfGdLkWxWg4Bj4RMo2/ObVcVViRc9Jnh52ohadRf?=
 =?us-ascii?Q?GJ8c/5isOfPoBrVoJPtzn9WGDr07vxghTZkY+MZAu0I54CCKR1zQ5RnDJEvI?=
 =?us-ascii?Q?2Dd/wSJCPRgtqu0GCrH/PuADmzdW2sII8W0bq4ipVkv1GhJN0P/tSWNbw3u5?=
 =?us-ascii?Q?Zlw2PtTFRn/8b0qwLrAlbkB9kL76755cdQZlT+hyh7HqRSopc81rGeZsC64S?=
 =?us-ascii?Q?YtfTRW0UBjqzw3+LlpsRfIR9GVVAPK1dyYtI0GDINvbsnLBSCyVEnVm1Ydlp?=
 =?us-ascii?Q?17WAF0aStm1O/M/Nt6eTrBwZhVgqZQocp9NLzKZ7AzIiIk1idZehSFQ8n+8V?=
 =?us-ascii?Q?BKbwnMuJwTlrroIEB88CIcH7dtMpy5LEHTUaieftAYm8/nJ/sRhol1fjwoaF?=
 =?us-ascii?Q?RLD0mlKQFswjK1mTq+fnTv5lTzSF1CDwOzKVggaL+1H1FwdtVXld+rQCUaiT?=
 =?us-ascii?Q?U4S/6EJ7jOQYKXH4oBN5Csoj06j2jzWvGXMIlO9ojtJZoC+duPUFavg65hjR?=
 =?us-ascii?Q?xjMomVogqVdh1dUqOYCG8sm9rjv30QlynTGorajaec9qQ3wjzQboKXoXJYQo?=
 =?us-ascii?Q?NdFPCFhzFBhUzpME5SGH+1fO2VShlQVpcQiP3Ql7YWRS+EqeKH3cgaqvHtA7?=
 =?us-ascii?Q?JjCZmJZA3eiP5m9udh8KE4jUDijXEtdJxb+vjTYKqs4Oe41Ao52Cdu8PytWp?=
 =?us-ascii?Q?4E2k49A9swxcYkZFHs3VOYApqd4rd2on1AXk548cjU3E3bnKP/BBALJQn983?=
 =?us-ascii?Q?fEUqhH4CdCh7HU2NAmoEM9xfUt0SUpKfQo7A/oKl+5lUosxiWXjXLvr1vjI3?=
 =?us-ascii?Q?AgBSwZbN3u/aeruha5azM5xDIAi0rVXKxybjf0DA3TFQgwqCJOBF2TGUYEKn?=
 =?us-ascii?Q?39OXv57vi3RBHLz8OtI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2594eea7-d6ec-4287-08f2-08de0b0ae737
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:17:39.2179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z34k5TweJ74Ouk7O/g+McDUwfPbzFQ3CdyXWHLooGSoXXimL00PaKbPp4HrGhUil
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11746
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

ShareMAC port is still alive after dpdk process quits but RXQ setup
in dpdk process is in invalid state. If high loading ingress traffic
hits the FMan PCD then it's en-queued to the RXQ to generate frequent
interrupts. This causes system stuck.
User can disable this kind of interrupt by env to avoid this issue:
export DPAA_QMAN_IESR_ISR_DISABLE=1

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman_driver.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index cdce6b777b..dc84260731 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2022 NXP
+ * Copyright 2017-2022, 2025 NXP
  *
  */
 
@@ -32,6 +32,29 @@ static __thread struct dpaa_ioctl_portal_map map = {
 	.type = dpaa_portal_qman
 };
 
+#define REG_ERR_IER 0x0e04
+#define QM_EIRQ_IESI 0x00000004
+
+static void dpaa_qm_iesr_irq_control(void)
+{
+	char *env = getenv("DPAA_QMAN_IESR_ISR_DISABLE");
+	uint32_t val;
+
+	if (!qman_ccsr_map) {
+		pr_err("qman CCSR not mapped!\n");
+		return;
+	}
+
+	val = in_be32((void *)((uintptr_t)qman_ccsr_map + REG_ERR_IER));
+
+	if (!env || atoi(env) == 0)
+		val = val | QM_EIRQ_IESI;
+	else
+		val = val & (~((uint32_t)QM_EIRQ_IESI));
+
+	out_be32((void *)((uintptr_t)qman_ccsr_map + REG_ERR_IER), val);
+}
+
 u16 dpaa_get_qm_channel_caam(void)
 {
 	return qm_channel_caam;
@@ -343,6 +366,8 @@ int qman_global_init(void)
 		return -EINVAL;
 	}
 
+	dpaa_qm_iesr_irq_control();
+
 	clk = of_get_property(dt_node, "clock-frequency", NULL);
 	if (!clk)
 		pr_warn("Can't find Qman clock frequency\n");
-- 
2.25.1

