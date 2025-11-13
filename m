Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401ACCD5BCE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 11:44:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC4B040E1B;
	Thu, 13 Nov 2025 12:44:18 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
 by mails.dpdk.org (Postfix) with ESMTP id EFC3E40E1B;
 Thu, 13 Nov 2025 12:44:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmF3gNdIZJCTM/xCmX7UplyqCrooF0YSqejr8xIsoUXVgzyA9k9FcTE4FsI7O6T0/BL/Ag/2th0qblHFJ63n61ebGwJaJDso2RsN1+vkZC8DZe8Rx+WTt6sWoRaS4/5BiV9jIUEtN3GMifSTHRCYOCs1ZUGd8eMzZI/Odpznw05ROKwn/sz5ed3AXjFTeEjiNI21PVSRs81fRqyiMwjQMi78XPbGAvYHpPnUqoIzkDlqae0znLI3FrjP7talgKy8uDtRPFPsh3Ly+D6K4g1jc7mFA3V9hvSgO9TJCvHGS0c+Gy2eicIZF7QIeLhBwxDdqfVIqmgMI3eabikrYO15LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HgBPJsqxB1PD3LEs+vXBlyj3sRKMspBAD5IJyMGeXc=;
 b=iw9TZuZvw+8nFU1ZBJ2pYk3av9brtwbvI0kPlcn540vbp9MZgOUZueXm4/4SE/0C3V/AdMjA7X03zj7XtFJtHbFdf6STknrs5YQkSzCJCZ16VDI1RcHeYGuHK/DIr6FdjTWzbvuphfPttAmqJPVY0Xsv2IOsH9KzoDO0yA5d5eDS3CbFu9uKyQPhZzpZDVVVDK4aoCIzRgW1ifwAJPi/MD2GRDcQI10hb75J6t1pwZ/fCyuSvd4H6BqoCArX918cJPISBg+ksm6uBrxzz0ig94gAg9Uj1QAC/YBY9q0HpaZsXOlOVBUI1nsu7lCxCqiLisLGN2pGIstsFC86+Yj+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HgBPJsqxB1PD3LEs+vXBlyj3sRKMspBAD5IJyMGeXc=;
 b=chlaXg9082XdIvw4go9N2w+GxBzoWbogqEvwzsNS0LQmHZTfpNz1bndYh3t/mdvaKNQ365yvGdMGoq53YtBRt/6hhu+QFTnqozR5H5PcBGd1om3Sp28C6i+3t4mSd61YuWYmygvhn4mla2O/pdy1lblfP3B2M3oG2xwFBZCXY0IaRocEYgiOBXRjcwZ/vis4TBtaawNA3jI1bmHbsv3/acYw5Yu4k9ZLPgkCr241OwEnzk4tvYTyoWV1yB4CbNWwQX4fS4Gnoa3/H632EmKEDw3mkJTFJJOpXZRbVOblN/A4CpUoy4Ey7BH+VJD0ZZM9jfHJ+IYtqCT68Oc7XssYLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:44:15 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:44:15 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: jun.yang@nxp.com,
	stable@dpdk.org
Subject: [PATCH v4 2/4] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Date: Thu, 13 Nov 2025 17:13:53 +0530
Message-Id: <20251113114355.2027438-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
References: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
 <20251113114355.2027438-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DB8PR04MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dfa586-f741-4c36-666b-08de22a9f827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pwn07sXdFBvkrSdMk4GrvudhngQjGIXbGr3B9jwql9MVls9fPLPraBDVmwJK?=
 =?us-ascii?Q?9w/dntwUoA5JTX5t+i5EZhsja3a7TMPsgpnXwzNv9EweAVrimQSG03r7lwjh?=
 =?us-ascii?Q?Apzx/vLg4vs2E9C9LVlo7qurqHxIq5M69QjwrmAD1ADRllAM+Lm6MWcRsVRB?=
 =?us-ascii?Q?Gq4FyJvMv22UC2gbsHZm5W1ehvTHIEEBgCS5QjWc8dZdCRDs77Ae0z7gHmuq?=
 =?us-ascii?Q?wHh3LPHum/2e37srgU9dbxhCkxbNJWpc+7nsg54tIpsrEp9LQuSAAhWjIR7Y?=
 =?us-ascii?Q?qZwiGLvW1WNT+hqH/f4z/gNdeS9/cLcHOyWzNvWkowDS+5ANE/ukqL2s/lDf?=
 =?us-ascii?Q?y0DLvF5nirfvDg7FiDFNFZPOprw7zMHyr+oN8uER690wjMQ6nOeMj5JMOZ3q?=
 =?us-ascii?Q?qdgdlclHwHbml0YCDoxf6TB2J8vgnuXEVtWQgO9ysvoC1AsPvhH7advh3BPV?=
 =?us-ascii?Q?+L7Va4E/1qcG8afty0IvM7f5jC0zuRCaVBBoX+9l+jpzWkua7xll1QZmzubk?=
 =?us-ascii?Q?d46GgFpyMLl/S3Ttr1U1ZrJdpe8mewmmFlXkFY8iGMnBB5uQLhVW4CjfZ0D5?=
 =?us-ascii?Q?9KBSCfbZUiyt942cUENMs16YcTHbVkP+VMPYL8sSnbrF2pPuKGcT24hBpyNY?=
 =?us-ascii?Q?5BlbOXuFieV1/Z/ivhXNC3t+S5SxOZjK6+GRzDk6Up9qeyiZNLXMhZ80gHBh?=
 =?us-ascii?Q?rV2G5WH+V5EmOXI9iBBPcc0PCe7/7IUKFvCB9c+cfaVvSlVYqeRmvcn+iq03?=
 =?us-ascii?Q?kOy4fz4WFZxwn6Rm+vr78zS4jTWrC+oONohxjn5FkFw4GM9PBqzudYmHQu5g?=
 =?us-ascii?Q?S3H5p1T9NYY204uLHBz72QlYprcuNXFMfciUiqTat6TuoDCYsV9VNIGiPCm7?=
 =?us-ascii?Q?lRmqyqCOeoijcV2TOccAeAS70fCCjWwfN28widTNw2dpsD1Ql6qLmfibqVXv?=
 =?us-ascii?Q?dxInCNQI9roAEzE47MleoGS/paf6lhWjgbBwp3Xeq9zBT/VVYhgD7dWQ5HEp?=
 =?us-ascii?Q?7LNpZmYuIMpmWZfSbSiiF09FV8jPYYYHwg1L1bsipowHoWvffp5VfpbvEuOU?=
 =?us-ascii?Q?q2yUidQBB6YnO0QVWXdkPr1cZHPedHjamVyeaa5YLXOEx7R69T1pCrzgYiKP?=
 =?us-ascii?Q?ZzXqvekeT1fntjdHQpuvCqnQ4X0tUT7pD2EydHR4E08qN6s1EMPEH9eNLCip?=
 =?us-ascii?Q?qW+oNbKs8DJKnKcMY90OIGar+2pu8GrVryQBFx+OBU6VHepIR63zYoi4Guin?=
 =?us-ascii?Q?H7heVUdxJMH3uTysEsTXIOKalD1GSmLe9kPaeBiCYblqVckqYDWdnCIbYEHr?=
 =?us-ascii?Q?bbkYdCHHVu2TuueKKRXuKgiNj3FRI2QsEHIwUoiuThQ/NMBaAh0lBlvyqQqJ?=
 =?us-ascii?Q?0r5UPaMLWQkkaDaVSBCvojb7uC7PE/YZvqSqwdMVEAYOW1mh0HmXu0o5YZzd?=
 =?us-ascii?Q?/h4Y1M3e0xAazIL/a6D9wI0TQ+9ueU97NFgnsjRuxZp661YmkEe1zgTcLR9W?=
 =?us-ascii?Q?IxnhFdOJ+9OmtA3z9YRti6/3Mht/JMiuB2mk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wq6IpujnJzJ23jmAkrHyl4F4wRC3XzjRuUt7WDMjYoGJ6Ei9AOEpIEl5rIMw?=
 =?us-ascii?Q?r1BJoWV9xMIJqQQMcN0BlO49FANfhT2DMbE2J9R7s15icXvASxAjwNjRVncY?=
 =?us-ascii?Q?F/nw/aB+mLYDj3yA7TDMIHRXZz41nltRXrWVrn9+rfqfrcl249Mv5B4Nkdej?=
 =?us-ascii?Q?ZFkFvEOHx5Xfbv2UW/9L7udD7lsf+bwnsNW6jkcVvLcxJ9KpAMhXDWKndRcs?=
 =?us-ascii?Q?R6TXjBeh83/v7egjyrJUAZf77D/pxgEaywTnDeaHYf4CeeFadQllv/s3zU2H?=
 =?us-ascii?Q?mS6FC3JwoDWN7gBRP0+UzrnhY8N40XRL/h8cSrVJOLcpIJNSYFIwUOrk8NxC?=
 =?us-ascii?Q?gIo880ahHYlah0b8cGvyaWrCuHJDxuT/XUPMJdXi9uupnIvWgpxORaNFSKa1?=
 =?us-ascii?Q?XfpsoqDVSTHgM6INoWAdhayRgDsG6Nsuc+Iyi//GxvaFB2jtUyNwInrmin65?=
 =?us-ascii?Q?3wsAlnZZwRals1eUS2MKe/1QRzf/wFnSx0duSfEui8arIblot/oS7vLxtZoc?=
 =?us-ascii?Q?lIGFGsTomESMS/+285OkJZaYwzwVi31AGV4Id02daOhL9e54mlUXOztqFrEy?=
 =?us-ascii?Q?Q9gpCEfzSp2PShfWtN5/7Oh5/2kd6DDLgAG1R075AB2mePEB4gSsjnGvw5LV?=
 =?us-ascii?Q?I+nmtRBTPdQ6Ayta6pYp0/bq9Df6AHa/2nRnz+XymRUQQ6vTDB4fiSmDeyA8?=
 =?us-ascii?Q?RP/bFy+zQw8ls5Vce3DuBAiyuC38+BqwOkEnFBHpgyO4TyJzXIViMGX8Yh1H?=
 =?us-ascii?Q?9660Ot1HVWrXeZdWzE2jk+8iDlqa/l2EkzbD5zKaRt61QXoAg5fkredn6lPh?=
 =?us-ascii?Q?edxXFbgzmf/tI/ujo9lIaxBvnT4mSJ1BXdZeg3L2A/Hg3dpDZmAO+q+ih3Nt?=
 =?us-ascii?Q?LBi2kCJZtNCRjbhGqA6Rrjrog8Wm5YerLYABuhg4aC1UvXs5c6hZBer5cs8t?=
 =?us-ascii?Q?iOaB03O6zlZgUMwPCmpdHtPPrR8d6DPtg8yZtsM56EVVmwcgekkYtxBs80WO?=
 =?us-ascii?Q?Ohenq5XcGOMRvOqTEbXVCPOzR7vATKCyMf701yLyEQ97mD8bI0UmqPWBnFol?=
 =?us-ascii?Q?BNPG2RWw6ZkDaXHuspVjrNIlDlmpu5VD9SryFJ0Kv/L+yPUo1/SRXInyIVKS?=
 =?us-ascii?Q?HbhSiTmWnaYOzP4CIjGarmPXJNPpH2KcIOEnLTvdnM7L8sN+7moDUI+ySXdX?=
 =?us-ascii?Q?hQGEKXShkdfYAR4ywYSOm/5K/HZ9d5fFVgtD7qHVoImiIsgXs+o3F+gGs/NN?=
 =?us-ascii?Q?/C7L9iapyyEzTuGrayQSiMbnQY9YfCJLc77l305OisqwKuorVq/li+iUG7vB?=
 =?us-ascii?Q?UBuNJo+UX8Ba5P7Qa4+J1gBJn9+fViKJqomjM83Zy0Q34ZZpQNAaSlg4XpqP?=
 =?us-ascii?Q?cXOIBwboCLjREdNCMXTYPi4Ipip6LUT59WSEmlxNl/a5m+6/WS9YBerXpGS+?=
 =?us-ascii?Q?sjHe5gN+Fq6nUzg6hx8HjeeAbjqaQjPzbn63891K6pZfHWXoBD2J5HNk/Fo+?=
 =?us-ascii?Q?ruwNuS9UWwVLln9AKjsOwePM2Q3dKXOIuvVk1Yt3OQkRBP6tbyQBXnIkEOJa?=
 =?us-ascii?Q?8n0lw56Sa2G45/7Vu9LWcb0WRHBMogQ8k55aIFx4de+RnWsYBOhUu6es0fIc?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dfa586-f741-4c36-666b-08de22a9f827
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:44:14.3665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mupDr9zBm19x0PlmA5C9YIZO7HgL+zRwa8eNS2A7ohhI9e7IE7ynmvxuodSHdlszRQNoVVOpL0YCnzB/cKOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
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

From: Maxime Leroy <maxime@leroys.fr>

When using the prefetch Rx path (dpaa2_dev_prefetch_rx), the driver keeps
track of one outstanding VDQCR command per DPIO portal in the global
rte_global_active_dqs_list[] array. Each queue_storage_info_t also stores
the active result buffer and portal index:

  qs->active_dqs
  qs->active_dpio_id

Before issuing a new pull command, dpaa2_dev_prefetch_rx() checks for an
active entry and spins on qbman_check_command_complete() until the
corresponding VDQCR completes.

On port close / hotplug remove, dpaa2_free_rx_tx_queues() frees all
per-lcore queue_storage_info_t structures and their dq_storage[] buffers,
but never clears the global rte_global_active_dqs_list[] entries. After a
detach/attach sequence (or "del/add" in grout), the prefetch Rx path
still sees an active entry for the portal and spins forever on a stale dq
buffer that has been freed and will never be completed by hardware. In
gdb, dq->dq.tok stays 0 and dpaa2_dev_prefetch_rx() loops in:

  while (!qbman_check_command_complete(get_swp_active_dqs(idx)))
      ;

Fix this by clearing the active VDQ state before freeing queue storage.
For each Rx queue and lcore, if qs->active_dqs is non-NULL, call
clear_swp_active_dqs(qs->active_dpio_id) and set qs->active_dqs to NULL.
Then dpaa2_queue_storage_free() can safely free q_storage and
dq_storage[].

After this change, a DPNI detach/attach sequence no longer leaves stale
entries in rte_global_active_dqs_list[], and the prefetch Rx loop does
not hang waiting for a completion from a previous device instance.

Reproduction:
  - grout:
      grcli interface add  port dpni.1 devargs fslmc:dpni.1
      grcli interface del  dpni.1
      grcli interface add  port dpni.1 devargs fslmc:dpni.1
    -> Rx was stuck in qbman_check_command_complete(), now works.

  - testpmd:
      dpdk-testpmd -n1 -a fslmc:dpni.65535 -- -i --forward-mode=rxonly
      testpmd> port attach fslmc:dpni.1
      testpmd> port start all
      testpmd> start
      testpmd> stop
      testpmd> port stop all
      testpmd> port detach 0
      testpmd> port attach fslmc:dpni.1
      testpmd> port start all
      testpmd> start
    -> Rx was hanging, now runs normal

Fixes: 12d98eceb8ac ("bus/fslmc: enhance QBMAN DQ storage logic")
Cc: jun.yang@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 .mailmap                         |  2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 10c37a97a6..d92d4fc24b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1035,7 +1035,7 @@ Mauricio Vasquez B <mauricio.vasquez@polito.it> <mauricio.vasquezbernal@studenti
 Mauro Annarumma <mauroannarumma@hotmail.it>
 Maxime Coquelin <maxime.coquelin@redhat.com>
 Maxime Gouin <maxime.gouin@6wind.com>
-Maxime Leroy <maxime.leroy@6wind.com>
+Maxime Leroy <maxime.leroy@6wind.com> <maxime@leroys.fr>
 Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
 Megha Ajmera <megha.ajmera@intel.com>
 Meijuan Zhao <meijuanx.zhao@intel.com>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index fc63cf4f09..3c3a1508fc 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -631,6 +631,27 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static void
+dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, int num_lcores)
+{
+	int i;
+
+	for (i = 0; i < num_lcores; i++) {
+		struct queue_storage_info_t *qs = q->q_storage[i];
+
+		if (!qs)
+			continue;
+
+		if (qs->active_dqs) {
+			while (!qbman_check_command_complete(qs->active_dqs))
+				/* wait */;
+
+			clear_swp_active_dqs(qs->active_dpio_id);
+			qs->active_dqs = NULL;
+		}
+	}
+}
+
 static void
 dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 {
@@ -645,6 +666,8 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		/* cleaning up queue storage */
 		for (i = 0; i < priv->nb_rx_queues; i++) {
 			dpaa2_q = priv->rx_vq[i];
+			dpaa2_clear_queue_active_dps(dpaa2_q,
+						RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q,
 				RTE_MAX_LCORE);
 		}
-- 
2.25.1

