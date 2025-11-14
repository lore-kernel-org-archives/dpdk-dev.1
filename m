Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57541CDE010
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 06:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F23140E49;
	Fri, 14 Nov 2025 07:25:28 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
 by mails.dpdk.org (Postfix) with ESMTP id C1E4140E2F;
 Fri, 14 Nov 2025 07:25:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kheKRu3nZty7JbbyC3ZMFCqOp1hBSMsm2NxjOI0BfAVPbZ/pJ8P7ANFy5+ZNQmgLYzQJLq93U/LMJArjZiII8kRRX+etDho52riMVswDFTOBv+pnMwNfzwOKVfbSdqFBPJAQqNuJKl1rDBX6TiTn0bM779lzqH+pAwBx9XwzgNsPI6tmbu2JhlNE3WL3CV2hyS4/gMHJB2YnO598AZWB3YFLgKKQaa/caYrmFpyacIr2vYcLI9BN3oe5nSgLE6QXaeU+MYD8qpRDXBV8ida6zowIanowQhUVHGvjSgyMz+OcemcLbNplvflQIHqEuLy+U05eFQ4nPenClppYVXOsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+a2Y/bx6cSbp+p/186qxXTFJUz4sQtJUc7n69W+Egk=;
 b=qhxbi3aEorKcCJUTyqLcvSbHCKO9bWBJCwN4FZ4+cvIDGrBrpk7mM3vH1Y6kP6yhbOzv4/LPxdlnxJymTyAeSdTeYISLUCNqZtK0wp6hE1Vlo2fFMlv1y3zojdlxEnD755qoZ7vS3Xmr5HJ9J0qPENOuZfEIC6akrKuHXvD86sJHLY//m44tpJ8FyYyBYjEiucfQOn2zI8Fn4vDivmsDLsS0Y0qsHxr9gASjZFSBj6IFpAbGb8BCJX7nRgu91qXDJrBnrokzyp+OQ0i7ZdGi7Al16J71KG4762FfeYpO3f4sgmQyo4N/HqC0dKv3Viw76c8pHY25jWc2JLbPdpRJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+a2Y/bx6cSbp+p/186qxXTFJUz4sQtJUc7n69W+Egk=;
 b=P+t0c8nku+O+jXE0rQblW6h/uVeb9IUuhUu0SZPcMyk4oe+VOZK9rLSHB8OlSs66Gir3V7OSVFArAz2Kqqbd5fyG6nEZ2TAGPQrRwqKtt3brYGgqEZRXo3gzaFpwZumU41mkwtOe3Wg/iHd8pN3xZLLAeohdIWiZ2HoY7C3dpMy8ZHGI+rJAvZn3A9PNIV+USDyxTmHt4scvKEnUb7zM+i61WndXVtGR3O7uK24vi8XcPBHNCRmIhIB0xNaVcCYuc6wcXtKMLH3lkUob3xFyNeF0XtmcTjU23v9CfjpxVvAUKo3izBmwAmMF8JQscDFtlt8ztT6mvNXo2ghlXwJoWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GVXPR04MB11067.eurprd04.prod.outlook.com (2603:10a6:150:21a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 06:25:12 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:25:12 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: jun.yang@nxp.com,
	stable@dpdk.org
Subject: [PATCH v5 2/4] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Date: Fri, 14 Nov 2025 11:54:52 +0530
Message-Id: <20251114062454.2731559-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114062454.2731559-1-hemant.agrawal@nxp.com>
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|GVXPR04MB11067:EE_
X-MS-Office365-Filtering-Correlation-Id: 7855e7b8-4c47-4f10-6e0b-08de2346912e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A3VVXJ+JNfWSvB8F2+B2HO/XzjziYD0UlEingmMGEbJuSRYt498dONkd9lZC?=
 =?us-ascii?Q?VjLiRYecVEOWAEcxIGgEtd/24dihvd5fmIbgQIx0xjJ5Cro3/Me2O1n4UdaA?=
 =?us-ascii?Q?Z5K7iQLgddR3O7mAXCnLIZ1zMizwQFgFYL83Zv6F33cUm9ePoqH6JXo1UfPw?=
 =?us-ascii?Q?71l2vdWh5NtmObqCNsn3Wf/MVyI2DCftlyfmYPJxwyPykpVWP4P2bkaAKpzN?=
 =?us-ascii?Q?UCHhf7WfYGJP4GH/lGHLYeyojWS1Y4qQheWZRqaAXSNXP2UVvifzuJCPWIOp?=
 =?us-ascii?Q?SoIgzwRSDeckVtI+rs2/qaeITaHQxGMo35DNzXRqxKZqDoS5jzjwz2BS4hO4?=
 =?us-ascii?Q?WxpPca8E901hjKlj/+Hl/mzfKQnkt22f75fOoGjI1wxk1Yt4LSUvtLxhK+q9?=
 =?us-ascii?Q?R4Plu38hm3IMN9Ym21ZcOxZkqFzVZmidoKuYQn9JS04tJ2lo5crqt4kTcOeE?=
 =?us-ascii?Q?zp8DN0HBThPsABtMfsoiNNOHIdDATtAFfh/80fF6a0AJjMiMr+39DEvOYbyx?=
 =?us-ascii?Q?55gGsIT/S8eZCYt56Rd9/n4BrVeBMnwo1I8tRlP9IABqfrwUqzhGT7LiVDFO?=
 =?us-ascii?Q?2aofBDEN/GBNsJ9Dcf/yDaAl7ob3xIHyhZFFiltNDMNSunamQXPhYKOYyr+O?=
 =?us-ascii?Q?DVGSQugTLTBkw6zCzeyGxJvU79IP8dXoF8ZzEZo7mWZ7PoaxTnubDf9u09UR?=
 =?us-ascii?Q?rgg4eP6P8zljxHu4G18l+q+dqUr1kcIgn6aH4YcEPKFx2dQAwHeze640C+4x?=
 =?us-ascii?Q?54ik7mz10WJ+aTP9Y5IQxNwz3VuF17KXAFqHy4CT3LhXxOiFUTYCZmk3E6WD?=
 =?us-ascii?Q?vOBHLAOj5L/MzLfhjVLkrTPKhhBEcTZajmBd886bjatsf+VzUihyXtNcSDXU?=
 =?us-ascii?Q?Z9NT0tIxBaChqPgNLQM8skPrK/Pz6TNnbdWtxyYbKq2Tu2fmTHxX1ge1kpat?=
 =?us-ascii?Q?81GGZxSOJy2m1xpo68WRzS8IYsSor6T4WXLkQkfbw8qRBVIkhK1jA6MsHmyY?=
 =?us-ascii?Q?d3lO168dM8r7ryd3su2jTfmUaciERxsRsfUYM4iaNcd3NsIe/yQokxcmuVnN?=
 =?us-ascii?Q?47V7dDAxJI5uMeWi+LyAY9zy/lJf1GQfYQkby23vOgkHrehMUb4ThO+6DlSl?=
 =?us-ascii?Q?T9dV69/hNr+tXl5FcCBp+XQuREXOoEPqe28xLooxvsRhK5reTin5GyxSmDTc?=
 =?us-ascii?Q?2pNBtvieUSapc7YE71u/2YWLQwi20UgQwecSpoQ802dvgJnY/SqBDNcUF3IU?=
 =?us-ascii?Q?aCN+HuBmszoKVbiK1EYH6ZHmCFcF4ueQEH7DfiLTGZJSBeKS8OrZPrnm0mxx?=
 =?us-ascii?Q?wdcEY2K+ByuTco60Y9PVpZJ5hwDDOm9V9gHJe++7mIT7emNpPbqJPfZ+HKU9?=
 =?us-ascii?Q?IKH9P4NToNvdHoxPuRuyXTfQOHtt5y03PAwOtHWvTMdYc3/yBF2XjZnPZHuU?=
 =?us-ascii?Q?ufGXxBhl0Re4nN3duYRfYQVwtfn2paShWYXiLoG6KoZGxRZfxvB48S/Qbjw/?=
 =?us-ascii?Q?HL1U6yk8sSmnKSwI2DFgJ2dvWYOJbtD6OjA8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iizrqe+mKwJn7/fUurvc318/n2ZIpnw/xcqLY7y4eImWiaY7wILcBYwmBmKT?=
 =?us-ascii?Q?A/+m5Tlv+ljzysZERGFPU9eJevYgWKTPqjJvvAWldsz3BBm6dBkeoRFv4Bcv?=
 =?us-ascii?Q?9/R/9dQUly5ZYgVZLGYlMvFn0DqKSkwcXU4qsg9MiluttD17pTwXdajqOyeo?=
 =?us-ascii?Q?qt5GyS0yX0OburGXhzDBj6AnruNFeT1xmM59iFfFD7W1ElEwvwTJcWIsS8QK?=
 =?us-ascii?Q?sAiwOjWkPnXHDjyXO5FuLIuARDvgnKr3vYia8AqXSv8aOWUJpK0XYZv35hvi?=
 =?us-ascii?Q?SE0iE97Xlc56/QZN3dsgV2KbmPmzjjmw5qK5MNzCJ2c3s21idquSAIYtb3+D?=
 =?us-ascii?Q?aGpb527OVo8cbL/aQoL4Gffetcxj9sUpNRoeM0/RhekAplt+JNx+YgqV8pPw?=
 =?us-ascii?Q?ztg8pZpe+yMxaUOv/QF4EprIBJ85CS+/Aca+Py1AI++9gjp1NjnzE0K7NfIL?=
 =?us-ascii?Q?1lhzfGV/f5kYFcmEaU/ygcj5Y8PnD7Ms7rBM7pWhbQXdIz1O/mbFcF5yS9EY?=
 =?us-ascii?Q?vEv63IOCjukISEEke3vsFZjq5CRg3YEO8kEGTSBaw27VaWoMDXwgGN4Z2G1q?=
 =?us-ascii?Q?7F0TZPDvALfn9GqwyFlUCYiqGSJknlwv5PF68o7SsKwKAVll2UxKSq3N5XgE?=
 =?us-ascii?Q?BDWeUrYkz+XTM1ZqGrgHydVCwDnVBj8G9TUdLbUG7EIj85FyUtPGx0DcyNYH?=
 =?us-ascii?Q?wD+dVf4m/AHhXWa6hWSmelwzEy6EVwOoBmMCB/7uhaQ85UoGCxMkU4tRIrgX?=
 =?us-ascii?Q?4wR+dx0kJSiq9GQyv9FZhl03Gv8KoJhrK33jel7a1278UnE/sSbYf17+SKtt?=
 =?us-ascii?Q?NpbbR/iC7Eu7KYA3iSh9xZKG4hTjirfFvcFDfMUvP/j97sb9b3iV3w0jmX/2?=
 =?us-ascii?Q?VEcs4OGcGzsiO+MRhayOMOn0Ka4w4TK/rI9f80GBMGm4ASbPvIoTpTdUzWIJ?=
 =?us-ascii?Q?gbDJZjZ3i2Cj75mWusrbWSv46wEEzZFlFYS2iKRFPnJiICN4WmDm9gCmR6+J?=
 =?us-ascii?Q?XYg8hMqiQV5bSHvsdloVryS2gOHVvj3w23eaRhBDWS9atkrr4NMpVk6dmoRg?=
 =?us-ascii?Q?9vlPG4VEpDlHgbjyOyrjCY55pXmsv9nqYdAYthVIa11jCfsfDt9MzAdOnuld?=
 =?us-ascii?Q?BTFm90jqbt/WA6QHodvxTPsTmASQymPhdzaijvlHmbIN0m0RYrAjQmFklspU?=
 =?us-ascii?Q?tiaFIvBkGlE/LuzjQn0Eut2H2DxSZt+SYbyZ9/dORiQYjmQrO+v/6hxzw6vw?=
 =?us-ascii?Q?O1SSFd2MmB8wZh4Z+hk0FCSd0NtCEdgAtzdV0r9YOTNiZq/ZzJ0jdJ0DysuH?=
 =?us-ascii?Q?JjXlUhSF5LDWFq2ANPNAxTEVvrhZ70HFSSpwsfSN6GbGCheU3CPnUELchhfk?=
 =?us-ascii?Q?LR7m18J6et12dfuazHneavWpUxDU4eMLILDv+Q5ITTTLJqZgDsA0u7LOYJDx?=
 =?us-ascii?Q?Yaj8Ri4LQU7UsoCt8HoOzfxH2cePMe4Bt08n6RF2VgoRo1ZeXkZiUtziY2X1?=
 =?us-ascii?Q?LCnhNbv/uCGnrtHbItj9YvBhxRotct+ps4yJYE+JWOe3PqoDeZhR7X3HBXg6?=
 =?us-ascii?Q?hhJnCpAGhX+lpkpUM2B5NHbTqFeYzlulDAB3ZSt4FneHSML/ClbM7URU7ls3?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7855e7b8-4c47-4f10-6e0b-08de2346912e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:25:12.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDChsUXo/UYB3jPdSwOqBa+HadaSgQtuvDB/vubyl0vod5x0EO78Q2/7t3CGszXE0Iwk3XWZARFtN15Gl6rtvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11067
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
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
index fcda267e0b..3fc708cb02 100644
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

