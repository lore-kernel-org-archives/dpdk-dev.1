Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1ACCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 05:30:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E1DE40E30;
	Thu, 13 Nov 2025 06:30:01 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011028.outbound.protection.outlook.com
 [40.107.130.28])
 by mails.dpdk.org (Postfix) with ESMTP id 1679A4003C;
 Thu, 13 Nov 2025 06:29:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZxse6HpfZeGD6sd3miNCG4yAkWOWk1+DLSxshhdQIpHY1K0MC4h9SJvlHbYeoX5qS3C5WDkmdo/5/3PfEziuBsZC5HO6CY4zSjLrLmRWYDIO+ezZeZoAzyHocKc8P448ehbqwXL86IH3i9g4aRupLuuv5+u58I+nQHDdiS0iJOlU2Op2O7CXnBrSdwjCCsHx+6ZFnNGvMkHT8BBIn6xL8hahR75iaQVaYo5s/Y1PzyRBuUYi5tWsVzweWKnpAt/3CO1KCqyP/AJdNoIjn73tFXA+oLfaUSkyseSHA0JMcE3CcobSO1slsA4FFCw3jk0aN2GW2+aStEta7yS2bhebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTg5IYZYdVOQFpGp3ms11YOvA4/+a65SDRpIi6U/0a4=;
 b=jlwQTgOAnKdW7zOVbX+uaMGjSFSNEk9W6XEjFm7k0WWXRysrjEerNvtrzRUNXzpVhD3TlSyYQjL38o+ct9hulpnIRltJ3BFNN45TbeAfqbcLZJnF1k5Wjh9QILbYkr033cFhRk616q8cOmHoHXXunOcb/Uh/E6hK/5qnnjICC6cHE6DIoIgdWfi8rooVCv+7DU6cenkYC4DCtCsRw7KEaYtFWTCw3Df5kpi8TEfigE2NwZAkxvL+o4W8W6r3NlPqZLyicSnwbAsZb/+hYw0pc04NgYal0yPl6YqJGfuViVOKLbQvmZkib38UaYgk7PhFAKFjFBrBZVAfa2O18Fd7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTg5IYZYdVOQFpGp3ms11YOvA4/+a65SDRpIi6U/0a4=;
 b=QdZGP7byDGlgNa0ScsmqPFgRmt0r15D6AUjJL2/QdemWLINsVcYCeMeZd+7KI5RzfyfE9EzoQG0uh1Eb6m8TDc8qEGtFiZ6J9UQc+Zj3+OmxakxeYSXptQFCKKAE90LAJrTpGIqZhw84SEecV/b53ym/p338jW1LOQwHzFg20cSt/GD7XXMnBRmKEQXs09Sty0xORj3igD/vIJMl24K+6El7gifgtkfymTV6DRfQC9B3n8PtN2e1IoybCNfzmEGN4xWDBhlMryYLExHPQmXzrlq9jS2l4MnvBedWWaEBPTRjJN8JkSqJZCfZU1mSjeTzzejcK/fmi0yiHogWX4OsaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 05:29:57 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 05:29:57 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: jun.yang@nxp.com,
	stable@dpdk.org
Subject: [PATCH v2 2/5] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Date: Thu, 13 Nov 2025 10:59:28 +0530
Message-Id: <20251113052931.1784953-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251113052931.1784953-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PR3PR04MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d54118d-ae5d-4d15-6eef-08de2275aeae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cTYJq6srzY3Mb28jOyTLZepMbQwJFHluzewOhLtQ4rDKuKGgBG3HQIvdhOKW?=
 =?us-ascii?Q?2XAp1zF20NaKMvoQbKPAYIPLOtRzwUGD3gMg06rNn/278zX1SNHe384GzXRp?=
 =?us-ascii?Q?Tv71FzBNM2HtYb/kFyeovLLrBHqSLS0OOw2dNjo41wq5AzL+x8yHY8/NxGh1?=
 =?us-ascii?Q?Rre8ne1V6Ngqwv7CyBJI5/W/rgbfn++83en4NskLJ4aLV3Lr3CYPugn5FElI?=
 =?us-ascii?Q?f6VvA0GqP9w7R/pB0SWFxgUPIBO44Vl1TlchXO7a0dx2UakY6en52HLNVIqc?=
 =?us-ascii?Q?4opGGQOe8y2B7Ead1xFnVAwj5oLINqAxn3vSsEA8i2u1L7Pz/5YZHdwl2pd5?=
 =?us-ascii?Q?HzIXer5gNyyNlUfW9qatZD6pp3LpKI7M5db4DM8XlsBVlTk90A8BU0RfpXcd?=
 =?us-ascii?Q?jkb3wPgZP247M+Y3TB/5GT4iqhH+EN4bhAdyTWW7vy26dtuWijLtZAaHYh62?=
 =?us-ascii?Q?BIHzAE/GUeFf3lsFxVswYHphiaehZ92t9076sE5qPlTVr+N0idZg0x0qyOY+?=
 =?us-ascii?Q?WnHrh+ihv2WQa2MOFKgMp1XQeIInrqYcqXt+27/9TX5c/5vV5gd6biGVqwsX?=
 =?us-ascii?Q?0hAO01SaQATlKvVNPequpw14fpdAb9xqxbNc9VODMhT7jFz4ftWVHoWQehP7?=
 =?us-ascii?Q?Ip9pVQwznzv1yd/+T7+ONoY268n5IWsdvg0odYGUqiCCsBaeLeA78EG0WnvF?=
 =?us-ascii?Q?C7W6DYFn5BHXs1ILIfmf+aERsxGkcee1KpT2eUfRwMn7Hl2X8eDynSZol2Wq?=
 =?us-ascii?Q?nDemvJpAjvV8tyjtOGVYRSzlz/VooU6Ly71qRAWJzAWOfSyc4JKiqk7+p2rX?=
 =?us-ascii?Q?DqPiD8TDxJx9Xe8SpvcheW4TsGH6n8XvskM4ks8AXLsVB0VsR/SFcOvJ407v?=
 =?us-ascii?Q?0pbfmB6YrTrmWKhNpVcbYRpg77mGpu4Z9Oa/YSc8e2sAEeleT3dJN3zWEQpg?=
 =?us-ascii?Q?DnFEJ6NlzPk3/l9NqFTIhMTTF84l+AwOLiwmb/CHw51fq8OeYfL3c8XD3l6i?=
 =?us-ascii?Q?cIQS+wZHuSbgCUQTnLK8PA0yKVblG+RPb3BvbJEHuAW8bzuo3kThtOPe14ax?=
 =?us-ascii?Q?lCn3Ytfq/v0R4rxbcVW/cLbN8xlEOS0JGIRwlNAJDa7yvxXkmVdn1hxYQ7Ab?=
 =?us-ascii?Q?I6wJYYYtnQXPsxBsE1P6n/vsxc5BZyfz332UsZvnJQWgyMZyzUlqgFY1kNni?=
 =?us-ascii?Q?xFeeXH7e0s+ixJGH5jD7TF1qGu7tlK0b0Ixi5xiV39E8opvijWMfFCcC6l3r?=
 =?us-ascii?Q?YwPrjv+plovrIFI8jplO12vSl9vcSH5tlwzKl2aXoHDSV7oP1Ipl+jep/9IJ?=
 =?us-ascii?Q?AD/DSXOMX/k9ABIqPjF6sCtJlpufQAlYgtUZqExM+lJMHJlNJB1lti0nipZf?=
 =?us-ascii?Q?8NzdinNh30D95Wi0OKqRMom1oCUMwWKYk/kcJn5Xvx5JUS7ZyW6DTdQseW+N?=
 =?us-ascii?Q?502rSNqpP2sQAhxtprG19+pgZs2Q18SYRoTi1p+b4rLBnk18WwnVfCyhm53R?=
 =?us-ascii?Q?itlVI6AVeuGXmwdsS25R6zjtTTvHOSpG9/rc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?blC1ep6gf9O9kwNAuqzTElJ9fe6wSmAzK4pzOVx3xLgD5rEnpqh0csBCgqbb?=
 =?us-ascii?Q?O+Z/lXfWVU9BdPbU1L8gqX6wRd2RunaLRb3BG+yyRhPVsEK2o1tMGx/AT7PI?=
 =?us-ascii?Q?muVYlcWt77WdPOGRx9zIadV1cyPu39aAMzZFE0QxuioM06w+wU5PFFbKQ0qY?=
 =?us-ascii?Q?NzrnFd5OaHsHK3bF35s+APM8ph/DBi7DqV7D+yfgxnGvP2iWFRdTS5zRQMUS?=
 =?us-ascii?Q?4Vi9rJVh5N6wNkufwDOH9vhpu4RjoOlQfA8yx9XHE3wO0+ns2c01J+iXRDnU?=
 =?us-ascii?Q?wAxiznYA8N7OA48gp1CVxjsUJLz/65xHxJkid+2BR9cHaivGM23XPADyGEy3?=
 =?us-ascii?Q?FnokmZ7H7QbKjNe+BV3Ph4t3ujp/mEh5H8az63saLJEMhexzSoU+mbhmKeDU?=
 =?us-ascii?Q?3nRSlEa4T9gP2qLe86eVDVEVDF+9FIMI0EfbSy90+5uJLLKS8AMPtJ0fXAAX?=
 =?us-ascii?Q?8pM9lY8Mz/5XB4Y2NXTM0eM/mf4EEmK6htywVUc66TD5iroFig4XG4Mh0Yjv?=
 =?us-ascii?Q?hE2Tmi6PiwoPOFbTw96JrXQnrqkcYa9QAO/GaZXv3aziJj9xtids+5+R2IHZ?=
 =?us-ascii?Q?2PDzhSnEDuwUFCnJuodsx9vHik/AbSSYoO2f9f3h1TA/hH+WhoIcO+U6Oqnh?=
 =?us-ascii?Q?dB52udaiFVPyJuTJGLAgXikCqKieBKbePDXGaB+7GRoLFuCXvjMohfogZua8?=
 =?us-ascii?Q?G1KStbeh9OHwP06PsubZzddRgmUWkONvNXylYD3AF85Xo6NRJlAX1RkKUhsU?=
 =?us-ascii?Q?g6jcG6DU2h5pBvgyHGZwKYK1xT6FNemBbiK8ucc11cpJHIuXAtwvns5UOZZW?=
 =?us-ascii?Q?21Z5fOOdfmIidDTQr5p15+MQiS+JcFMIRzWtKOEQrXGu1pu/wip8j/ks+oer?=
 =?us-ascii?Q?Ad5VvuagDAG1PytRxH+0/7DzCAjNsxxNtRju199SU+eznHIx39F1IyQAhHBG?=
 =?us-ascii?Q?jTt/18at5Pp48vQM4qWLv1DBJWXhRLqCAqorqGYvyXl62hZYf6k6ZcvhgEhW?=
 =?us-ascii?Q?znDzVBGNU7pwokFaPN/DMQJvs6f/xzDZcDa2RcC/iF8gX9nfOwzlFQjHVp3I?=
 =?us-ascii?Q?AyqmBonM+b+lebRyjVKZ/oF+hcRBZ/aMRSUNrMiyR+P/Vl9NORU+VG0Wab+p?=
 =?us-ascii?Q?9EuqQMuee0NDCz4QkzagYpd/vp9JW4VORb+ayfaZOr5axsk2Rizhx1aoqtyw?=
 =?us-ascii?Q?EbWfbbESpDPI/sJIcnDRkPeqYCBae8O4Bjfp6qegy/8yC99ml1S/yp+QzTxe?=
 =?us-ascii?Q?CAF2q6vrNcPju3j0xisZQoQ9hbdf8UVSnX3Mcff+kRdbNgV9IiQ0xFLnkMKX?=
 =?us-ascii?Q?YpBE2xbp1AWeOZ7BMuw0Dl/13B3je4eEJNBYuoNtcgA77qeux0gAGvUkU20l?=
 =?us-ascii?Q?/iod6jdDkI1WnpdgwwFkvyOf0ZDvBe1cDHlie05WdLDxYjycQpM6pPQE2soR?=
 =?us-ascii?Q?zDgM8PdOxoRTLPtED/glk+uYRlRQtnLfasVRtxnAC+weVnosfhXoDHetabX0?=
 =?us-ascii?Q?dqzhHCpeWVp6hZIHVrESi7dEX3Z3dIDOD2JjFR9fVqoxdNcoAuVRiGi1WYrE?=
 =?us-ascii?Q?Y3UHDPr90qHMVUWZ87mHhNTGmGPZUWHMmq1Slt0E7/hifJ/KKwdEVZ6ksmo/?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d54118d-ae5d-4d15-6eef-08de2275aeae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:29:57.2102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwx6Pdknf+bnk2oXp8AWvXrHKZZ+CDVYaP/QNyTfHvEki++8ykQEbYc99dJVI+f/w8CZoAX2hs8Ub7q31ZeUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
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
 drivers/net/dpaa2/dpaa2_ethdev.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

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
index fc63cf4f09..c94034104a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -631,6 +631,27 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static void
+dpaa2_clear_queue_active_dps(struct dpaa2_queue *q)
+{
+	int lcore_id;
+
+	RTE_LCORE_FOREACH(lcore_id) {
+		struct queue_storage_info_t *qs = q->q_storage[lcore_id];
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
@@ -645,6 +666,7 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		/* cleaning up queue storage */
 		for (i = 0; i < priv->nb_rx_queues; i++) {
 			dpaa2_q = priv->rx_vq[i];
+			dpaa2_clear_queue_active_dps(dpaa2_q);
 			dpaa2_queue_storage_free(dpaa2_q,
 				RTE_MAX_LCORE);
 		}
-- 
2.25.1

