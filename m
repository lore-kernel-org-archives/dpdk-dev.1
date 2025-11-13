Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BC0CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 09:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ADD340E03;
	Thu, 13 Nov 2025 10:59:43 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
 by mails.dpdk.org (Postfix) with ESMTP id EDB3C40DF8;
 Thu, 13 Nov 2025 10:59:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHqqIq9HV03WYUJdaU7VHpKFWSWAtAccvUiybzbgYkOQZh/6MyxzmwwzdKvQf85wDlxMSpBRuihUJO3WnW4V9WUN4MfY3379Oqj35CTbaDD7R5nJ7cdbmj6QCE9xxf1UdViNfRi/XBZatg0+JelOxaiW4ObCQv6JZwpsfUQxjASaqSeKp8Dl7iGOSMMN9pBk/vay1UNcJFbZLZqj0445mG+7IYSl2TN3mcwYFirdSonADXbdbKC6bIiphyWGoyJNwhnGB7VgyC7QHR4yQk/ZNCIdQurDraT3AvQcLRJLzyX1/EK57LMZfCAujMftwu1cx8hv477+QqSMrySfLNVuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTg5IYZYdVOQFpGp3ms11YOvA4/+a65SDRpIi6U/0a4=;
 b=ILusqcyR7FHK263YoTJLCrOnwcldnqdRyhOcADKmjD6y7WJcZ/lqFwcggM/FrOzgoSBCL0PAmq3n5Lkid+ECOeiJaVt8Vr7bPdpObMJmn/uVVLVyGgtCGSdrKGvV4PY5GAi6ixuzShuHzZ9vpIKIxnlRSFFYJqi+9iV/aWSVW0tnOvqmGSyadzaaOUtINKVqRqKPlcas/1GYgqpSJR+dLU54eQ80j4P3PkmowhheXt5aYtCf3PC02QnTLvt/xqOJHR8D3wcLDWquEGzs5uSF98jCaQbZSVEeaSVhDP+9N94umWxfTbxZIV5FLX0+tA7zokiQ5KJSgxEgA30A4zbqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTg5IYZYdVOQFpGp3ms11YOvA4/+a65SDRpIi6U/0a4=;
 b=IeyXsgOzuUhFIm6nw3tfdKSZjtR35ycwrPzqC/WyaPT7+0XWy2f7icDY+8Vm/Gp+MD9iS745jIXQ3c9iQ2KzvRCSv3MkpmVow8sqtiohCLYSkLAw87fzbW/L1V7H+SYTUddYDp4fo4ecDhm6LJVgw9BK9ya60ADrgAOEncC2huti9zFiFagdgL+iFqaOANiszbX8bsxRzbhUFDdCkE4VyvkkaT50+Xyy5l6jUixzh3XmcljMN6Wj9eq/qHeBK7yKfpJDirtYWruE/SYTfM+t6MHHY3QwCm0NXyvumpXyZIdSTBReo0WYixoGhiiIoe5p3vKwQ1fy3kp7YG7h1xIpYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:59:40 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:59:40 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: jun.yang@nxp.com,
	stable@dpdk.org
Subject: [PATCH v3 2/4] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Date: Thu, 13 Nov 2025 15:29:15 +0530
Message-Id: <20251113095917.1973514-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
References: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
 <20251113095917.1973514-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 569f6731-c4be-4bb9-adde-08de229b5bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qUOFSyK9hidW0emyiZRVJU/CFrxsPBuMpBPndRP3Gsio+qWp29L3mvN0fSZ3?=
 =?us-ascii?Q?mw3SL8uThrFIGoB3SZb3x82fZyRdZ60zY8j5R5yVoEtzvMX/Rsowt5W/mMzC?=
 =?us-ascii?Q?HjHx1NKbbojIVL59DLVtkMsNlrECCnFJ/siBJKJ1vx+WRWUqPYUI8105qOft?=
 =?us-ascii?Q?IHB1Gk3Xi9ld8wd8G7K2L+61m/6xyEQkuSze265nOmLOVhUEhdamQ76jVSyr?=
 =?us-ascii?Q?Sp6V5svomyX7RcTl3RD5sdINT2EDfTRbys+zB5o62PnUIs8/9wgMFfLC48AF?=
 =?us-ascii?Q?Cqjt+SKKf/6INT6Gn6KrZAFuQHDmi390bgt0lCg4ZwFlhD9VZcqFH2jmBSA9?=
 =?us-ascii?Q?qFU7LAApj0Fxjk/mkz5K/EwL36tCFVO5xHlTUh6An/r5UeLBK9LThwaUsvYw?=
 =?us-ascii?Q?a91uo3/wkz8NAUUrNcgSNtdOWEXYdLRHHAXRbzkkmAtQE6cy/ud0fqWGE84Q?=
 =?us-ascii?Q?Zy8Zx94BLkROjRsDCOj9JgN7eGOa852Emhgvvf7X18Bfx7OUecnCrjEM+8Bp?=
 =?us-ascii?Q?urj/RympisjVzzeNDiDXpNqv7et2oRD82ydL5YwD+n0CXERxvqXclcs9pTmn?=
 =?us-ascii?Q?0wo1wU+RYJv3WWB5XsiuOhyU2ZV+u9pdJt0qO4lYYQKzTQ7b0OuqLk+JvjtV?=
 =?us-ascii?Q?M9eJTloLC/391GRnxOM8zgKn9+d+hyc96trsZlO9TeuieyzoQ2yjAalf18yN?=
 =?us-ascii?Q?G+hzcVjPOMHow7OG/19kVdIIb1YbTrXeKCnhDhjcTydETvtUIeLb74BpEbmg?=
 =?us-ascii?Q?usWt5m4pi17kjzSXDjsBomk2/0nzRlgHXshiymMODjDcjTJsBfMQhYmQRKlu?=
 =?us-ascii?Q?aPQX3RXSPh6aJrbudx/AiilY1H99ueNOTFa3vTnfoaH8CDKJG8YXJnkjkPLM?=
 =?us-ascii?Q?JbcwS3PqFABQqzPkQttmTGa7BeZ9m9jU/Wrs8F5+xTA3SDz4IUKXkAncFG3D?=
 =?us-ascii?Q?sgFE2LhApMgTEvxuexjpVswhB4Om2fjR7O193VahEK0Bvg4qhF5aA+BVMM6v?=
 =?us-ascii?Q?5IzyVxL1N1EPgS6nP/d1TR0ddDVz0wT9BUY9ku9msAcXmOMf8QGA6A1MJuNa?=
 =?us-ascii?Q?VWe9RTwWaSpQxbJdgoU5XE11P0msDVJrGDgaWSSq4aD8otMTHzIhTsydMsnr?=
 =?us-ascii?Q?OKLLNshjtX65wyGA8RxVn2i+CXfwwW0kEimwf7qbNEenkXQI56WdBKUCqwdk?=
 =?us-ascii?Q?0XspU3mqXoxys4/JlGB2UeBuFRIiDUIUMwAQ5S8CQiQ1EjHPAWH559fBoBwG?=
 =?us-ascii?Q?Q9QmWH+S0I3LeX3c1g6lRF85eK6owoWypescEOeFgg6fj7VvWAz1PRo+zC6E?=
 =?us-ascii?Q?dUB/O1EJKRi+J+mQzETTsMMCauEOpr6qCFGGGDyzQvO1lmUHsE9pIswxQS9+?=
 =?us-ascii?Q?1NxqbowkxQZlTEiB3Ib6pOETEKNXkb1Ft2u2bL5woOk//uvk1b0PA7kqaQkX?=
 =?us-ascii?Q?t5bs2PPtakPDhAnj1Q3fM/+XhDygeI0ajxPHttweo8d+pemte1uW2FOg4UtX?=
 =?us-ascii?Q?+h2u5sAE8wVp5jNDss7UvmJtghbEVGO8L14z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Xm28T0V+DI+twPDY8sYtZPfk6ebYETw+uKLW8dE5Z2ToUR+2K0/62PjRFJi?=
 =?us-ascii?Q?cocZgp324wm5qvqcppceRwcVZ3v4i+GaV171YVC9N1aZQP32t4iBaucz1Fb+?=
 =?us-ascii?Q?fvZp0J/qJHbiO4OqQ3cupPsO8gWDA4K521qlqaRWczG4SRkm24aEtLamW/Eq?=
 =?us-ascii?Q?S9cHgrw8/zD3CGt5k5+L2vPuo65cvTnKwQQ5LrZm4Qo9ET+DNAn/IRD0/+xM?=
 =?us-ascii?Q?qHWUaqcCpv6jBHbV889PvXQAcp3I6Y3WbGTaAMKijCVHY8j8W1QdJHUqklCe?=
 =?us-ascii?Q?Whn5gGnERFm9djeQaz9yoisTzXGrn8CrjiocTeH8guPGd/EU27AYqFR39GY9?=
 =?us-ascii?Q?w8PSUbrnBtlA9UD0Sv7s2uKcq8grp+i1MQ5sjq6S/F2by4owh0gl8envN6qa?=
 =?us-ascii?Q?HojPnIFWLQNKAnm3k3NLmOXVCIy4pnqZ2z5SR6lKC+vuWBjS2jzHhKcwtB5E?=
 =?us-ascii?Q?8eiFSRCE9UeC1+seoelc3FV5qNmml6+swT6qsLH/K1jD/dKe4EkllW+bwhKM?=
 =?us-ascii?Q?foowkahAXAtjXPQVaLB0oHFdzkC6q5eQBILxTqEBEBZ5UrP5BVdXmj8HfOgH?=
 =?us-ascii?Q?cQnGOUFIfKQvBKMRy+CIDDD4Xv8z5fUj10SelhfBdCJayiQkohiUui1tcSIf?=
 =?us-ascii?Q?9VnVonDJxI77dQmGOv+GdcGFlgzhLeaHZ2861NN7ea4XMD8CjSXmlQehoedD?=
 =?us-ascii?Q?5DOldlJnoOUnymf6PY5felif+4RqMul53/GTAHOqV5M/ExNqIhg/KMyzcIIr?=
 =?us-ascii?Q?gNn+cOuE5pS8ddD4u9uZGL/vmOYfYiINt6EpvSjXVGydZY1urIIPxX//llBM?=
 =?us-ascii?Q?9+aBuTp6LdsJLWJ2Sz4gyTXo5uKlKa9nJ0A1rNiv6EDsrF5FndW9b3CwSH7a?=
 =?us-ascii?Q?5O+7VIIb9P0xRlFPlkVXuFJWvlKFx4skDb5vNVKapcIGjr5e80/hXQbFEeO1?=
 =?us-ascii?Q?tGCeqkXMoDIY4uCR7GFnoUEFAOrUkAj3HD8p+FuohfFLsYcuFSmPD/gEgNIc?=
 =?us-ascii?Q?ijuR2eFwECTacnsmh7BAXPUqHCAIhSapMZ0MGyFA2xqvsNTS+Uj/ZjrcEqrd?=
 =?us-ascii?Q?XaGbSgiAjzI/IeD/8o1s/bI7y63HR7M5NQ7KF/G5vrHCkyvNVe9gthpdQ61R?=
 =?us-ascii?Q?hhU5oQpk804OSUOkaI250jXRYJ/RzW/+50h+cfdQ1UZxaZLWIHQwVeJVJQ9m?=
 =?us-ascii?Q?8fPsPnvI07qC9cof+C+E6WK48bd7bPEbqs2FDYTsNWacf8OCdFhp+o/IZ5xr?=
 =?us-ascii?Q?fk6++T2mHJpUixwbBRGQLlhhZe4Usoie1ru6mo8MNleSFpDWZ4KrlvWH4lXv?=
 =?us-ascii?Q?pNUuaU0g7pah0fiAtyqvK2HXvbkROpBlUfGn5OujlEjBaBB9ThzxiVW+uHUw?=
 =?us-ascii?Q?xbyqCZMyhhjdE2lzvCYwbr7EacHBUn/QIPCwQTXVEaWlbPFVmBxFXUibLNKI?=
 =?us-ascii?Q?ahu/xfZOhjgk64GPbYAyqjdKrLtFFu1jNosQ/zYcPc8M4bVUi2m8W6zY9eXx?=
 =?us-ascii?Q?vJChCGDQJ6sbq71S6fZI8D5GYUiIjBsY+Q+PTXMKsyL9vogCkMvZkINntQLA?=
 =?us-ascii?Q?US2xF8fjikVCGwp/SjlPJWkKO3A0FzhE3IMYcYGaz+EWZiCPb1pBX/+JzjMQ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569f6731-c4be-4bb9-adde-08de229b5bd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:59:39.9431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTArdEySASsLEVRB0hFRuo/4HJfcxRmQmZ+FvkEWRwLdonGOm9tDcMSW0bTBOb9VKuoPQgcsZlIIXy0Cj7ly/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
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

