Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A5CCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 16:38:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F67440655;
	Thu,  6 Nov 2025 17:38:37 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
 by mails.dpdk.org (Postfix) with ESMTP id 37E9040431;
 Thu,  6 Nov 2025 17:38:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okOSjWpbMh34TXaFYSs8jSua9U/r6Mnz52mCnw11mplYacVq5gnaHknpoHcvWVoYt1kUPVBnMtOWVZXBrYAiV4LD9vbZ2gBAChog9PZYwgfQz0wnzR8oXz1Gw9J1CERtIuAMYcknPIP52ge2K4KlF3d3n52+53o8RS03xeP4UUHZYjvJ4TokI192lQdehBV3waT3EMWQOFJGNuOjodezAkv9flZi9Lb1ryA78EXyqIG4m6qbcA/Z2u2L4XqnCb21ALCKnaNixeTFcBW6qXHLpnYPoQlzUKnrgNhL19FdszgkGOy1kOutPbnLDF3uTYGlWM/Nyf6S+6M8fMcuP94Q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gsaZ8eEmpPXndowryEj2gewPIapCw+Lz5hVWrjUUa4=;
 b=E6gwecNXZGRnvqfA50uqwB9PQjYiFJ/AVT9Gqj2auD36dnOMWLDzjTchmjwiLURnHoZaFe+iwPHwue0FEu5KSM8YLSPOdgcDBZI9yFMHzBm8fdfXPqlwe/iGnRRsd3v0zcpsFJy8PcaRpWR108FEGq9mTGPdfC1jlPriFlAxTdwlV3wvmHr9uxP0DwlkjC827wMenFw5lJbmsJp0YTyZczrc9w3wbcuzJ9fGWKgIhQhjn2n1hXU0f47qNOVXlJZojmLq81+8LvBQtrJ9wPEwnAz+WUlwl9stBVAYh1eyEK+y3i9i3BwNHts5kqxU3XU2T36WqjB1Kvi/PpIzZEHapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gsaZ8eEmpPXndowryEj2gewPIapCw+Lz5hVWrjUUa4=;
 b=jV4jldLkBHdMyRaYfwT0VxIFUHISEonUjBt2YFvDymqnHSplrFjALovrfVy1HBJXzwRFMPmQVwkN983rhBcmKeSpM2aJ7BXJj6NLcSoHUYysfW24KnbSKJdN0X0SEtDmtBR5D7bF4w98j6ffjX/NmUUO3ecqO7MceOODgJUiX3YjVEuTAttqumdY4mJ8GIjm9ZmI8VF8t76uYkf3uYRAs1QaGKzjmmLa+dd2Wvt5kJGh9L0ZP00WMnLrn6eRAjk+kN1uJYpTxhN+lwUB9XXN6ZALT7MMZQy6Dt6XTD9FB9UZciHY/MKJxy4CvHT22ajafmhEq2F7Vzg7UqKOOkEQYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GVXPR04MB10801.eurprd04.prod.outlook.com (2603:10a6:150:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 16:38:35 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 16:38:35 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Maxime Leroy <maxime@leroys.fr>,
 jun.yang@nxp.com, stable@dpdk.org
Subject: [PATCH 2/3] net/dpaa2: clear active VDQ state when freeing Rx queues
Date: Thu,  6 Nov 2025 22:08:06 +0530
Message-Id: <20251106163807.201451-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251106163807.201451-1-hemant.agrawal@nxp.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|GVXPR04MB10801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1decccc4-9925-4bd7-7769-08de1d52edcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GXVNZ8Xfmi2IbG7QPJC5u1bxZlVf1A1wm+n7W1usbnH1ZLXtd1xyO6afz87u?=
 =?us-ascii?Q?MfmJxDW+Ec1saNBjVKR9JB+hBHXZfmDHABcPBcTPqGukZk0Hrwe0yXZX8taS?=
 =?us-ascii?Q?snCEp/7B/Z/CNUKyAXz2JyJwD3zBBUHlAArJMngY6OZDY0aiz+8OcPilLmJV?=
 =?us-ascii?Q?H26Fa0zESYnuPfJ3DRsk7DRRAqFwz1FSMIup7pLHUoitms8TWHtdfj7wt+6s?=
 =?us-ascii?Q?hLqdEI9co/7faTE4oI8C+5WeOi/fTuUwmyGbdCbaLwl03WoVx2CQvxaa7eQR?=
 =?us-ascii?Q?jBGEZmghDbr8Mvj5OLp4sgSjwNqY7cAoeJFVx68kFVaxbspYt2Zuzx4vPi5s?=
 =?us-ascii?Q?8i7e0mQaNrIs/D6HpuEA5bQZcH+7Q15MaDaHWEoYejoLLYIIX3tZGV/XhKgw?=
 =?us-ascii?Q?+9fEkkO+AAqhGqdz8TGVZ9ZKPWgEs01fgiZnakjRBEWCSJ0CZ5o+kwyENqfo?=
 =?us-ascii?Q?fwrKmfNbsIDYSfofWHfdkWnf2GDtCOBIeLKsSdceeNE+JwweY8HzKJwjZudT?=
 =?us-ascii?Q?MNS/2xrd+vQA6wCDYOQnO+ujGa7laUOeZoNZDHsxxP2AP7GYxm7IbOxvlHW+?=
 =?us-ascii?Q?jL5VPC7s6zV8f09k1ARcDhPOZBkgJNOU6Nsx4re/flZHKoNX0UHY+q9KZycU?=
 =?us-ascii?Q?lqgbkXe7+DRAXrC75bNX5akUf6v7lJqWvKOGuzOMl0PJ9955eCj/Ej7S4q5R?=
 =?us-ascii?Q?OFZc8ao+ORuS9zrRlUKidQraUajCmyXLuKdhuqmpR0iVpr72ztulXyGBfv4A?=
 =?us-ascii?Q?04O46ZiPWP3ur5xJC8ogem9kYEF/8W72siguPslNZJhcBmyaJhdmrSHLStDe?=
 =?us-ascii?Q?EppsZd3f8SYPGjet4FviHT6KfnYWjjBXccSgI/XJKoTggwpAeG5NJOO3B3VP?=
 =?us-ascii?Q?+zpTsFn9Fi8drPnMAjB9/s0/PipLqek4lpQsz7Ctmvyq0S+OVnx6zzsVZF0H?=
 =?us-ascii?Q?22o8+xlfLieEPFOSgfelUN0l1x515O0S9JPslftzGRcugbxvRmftJKBkUUfI?=
 =?us-ascii?Q?Lx7eMcIElRyustNUAZsxI/Rbi8Khb63tCC00Z0HxhhFhG4Qb+cl2CKRiwk4O?=
 =?us-ascii?Q?1watvVcxUL6Jjsh1nfxtu5k/pOUXUd/SECa2lYDF52aSG0KmV9F8+Mflbw5E?=
 =?us-ascii?Q?Dim6bk2yco2XI1y9oy6g4kLZOtTv1KI7YhojfLB6yZjs1CYUiHXIFNJCSGK3?=
 =?us-ascii?Q?uhK1VBRS6Jm3Am2sJ1U3ZmoDngV+G9juPQb302HWEzXCejo4V+BJVZx56Zob?=
 =?us-ascii?Q?+3kNsCd7h2aVD6jpcktxw8z48injaGsN/I8bX9eNCp2Y+h1tcPBmpN9/VBfk?=
 =?us-ascii?Q?2yjiRce0gEMXWOw6RWi8OFulCAVgWBKUkoOUKTjX9Vx5rIL3X7HBcKtAJQWz?=
 =?us-ascii?Q?+LOkWY/2Orqlr/IrTMqZHaT8T/V3QVKEbd9tIs34toCky4OmLudPhClPsd25?=
 =?us-ascii?Q?gQRizj69LcFBP82USSu3xx9L8f7ZCz7o/qdn17A06xcziDEC/FpGl6+JEe6k?=
 =?us-ascii?Q?ayEaHrWyQOC5Tx5V9W+/sNsHXJzkzpvtsynT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vyowWoOr/P3PAksGE0gOSaKpGjxR5AZ+ww5hdpR3zwgLpoJabVkiJrjX1RGd?=
 =?us-ascii?Q?SxLv0PUcPTZ2VrmQuEXrxxemQou7oDEeNfg9nDnhslcrPSPlfMBCUedYdS60?=
 =?us-ascii?Q?UG5+vaT4geg0+cgQA8tKwd+VBFvNnCCeU3phEypPKa0OeDUJ1CY9V3gUXCDN?=
 =?us-ascii?Q?O/0FMxP5l6AhgGevTfFxA6CUs4hdywJB8TC58yNMmZoDfQlPdpxVWA0O62TZ?=
 =?us-ascii?Q?lr1Oyk9XCX18MJlMOJa2ldxlZgyI2lcXTpZCQJ7zYhiiLfBtFNZ82LT08c8K?=
 =?us-ascii?Q?c4bUxGpxi0Xtbw3iZm5x2c18SwDjboDg6QGv6naJjJbWxtkCHWKwR22DU1e8?=
 =?us-ascii?Q?J8qCsPiM46S+xkgTpWaWhlKEtL/2+/4jHnFzkS1TbIQGCWpJNqxr5Qb8rQBc?=
 =?us-ascii?Q?DTgJAlPg91SgC0z5YW066UAggxknNc5ngwUhJy3Yb9/KZe/KqAxCStjc1+bl?=
 =?us-ascii?Q?R2IJ7h1FbakSh+d/CZoGne0qTfayYb4tfZCyrCHtdV1tukBegtcp7Qgh4LI0?=
 =?us-ascii?Q?kh2WjC2MFmr5R0O8Zx2EA0BeBiGhG8ofmqp8AqkX1ZFRSQI/GmwoIdLx/ZZ/?=
 =?us-ascii?Q?puXDyjWzyKELT6YJwLVaHLXkp7y34uriXHSU9Y2MGLnX888Xik2VaG7wrtMp?=
 =?us-ascii?Q?SSYMswKnn9LjKsV6dr/QnRyyPkIeenr+N5HkM3cFNiRJYaFOP5oxEeO7sryj?=
 =?us-ascii?Q?R7Cfem0x1t526D9kPTkLN+53P8cY9BW+3GXE1PsRyhq2nMsd+Vq6gMtGYIYQ?=
 =?us-ascii?Q?H9jiwHJk+4pk7/ZA3HmvWsxW/MmzajRcJbqnyCKdhaqFFAOJXp1hmHwWjE2f?=
 =?us-ascii?Q?e728g/EK8ygK4nhKTbKHsMksPpXQb5nGeSfu3c1C8auJX5oH+nZW/bL+ME2d?=
 =?us-ascii?Q?5XqzGXnYCwG+2lEKldMmWmtTmn043k3wnvb6J9FcHGuPGwhPo2W53Mv+mBnn?=
 =?us-ascii?Q?CVd2py5o8UmJZ9EHRf7gxBVwKf0K28FlkhCFZFkKc6kQdEi/3un+fDTqftdU?=
 =?us-ascii?Q?gWFuPENHvJ/esbwOrgWMpTLCE2SLLLgu2rcn/UFezwYNn9qToyAXV+RlL1Gy?=
 =?us-ascii?Q?WjJh9v6m+Z57rOwuz7Xkg0OVSiN80VfV4lz6olaIGnZNzWTpJzp47IG5MF8q?=
 =?us-ascii?Q?pDinMfnE6kAfbSwHj/Fcd1rHZqqFmNL0+JsA0R7G/gybL+YCFjayja9AeBkY?=
 =?us-ascii?Q?jeGbzTsHzrONP1+Dg18VC5B2LZn5Sst+curTwQkXaiXADptja/ETjm6AYVbn?=
 =?us-ascii?Q?5SILBKC1xBuO99YI3bv2haoVbW3U9ab34AsZQvhVoqGYP2itnwyNLg15VuJU?=
 =?us-ascii?Q?3yqZy4rBa3vG2MTUOUhVXjmT10E3ALV1ZwNXYNsKZ2v76/5lN+6sbMRtGmXZ?=
 =?us-ascii?Q?vS6XOKeseqTQn1usK8q9Q16KNck+5Op+1aDIrMzbvVfdD61PlKy0Jr+6RREJ?=
 =?us-ascii?Q?aSy/OO6tjB2VOqoqIhKV1lPhbqPpTxgt+hzHQtF5DOCa9RS7yI1F6g5zyJAi?=
 =?us-ascii?Q?mddh4zcSFCR/NgTS0ZcluHFHJt/UUVkFCanNXY9eJBgw+w1BuLJ1C6I53rsk?=
 =?us-ascii?Q?7CkQsBNYhFfOcA6IcUtn8JGSOwOzoyCIS+qojjUZA2+0llO5ybfM0DdLi4gD?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1decccc4-9925-4bd7-7769-08de1d52edcd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:38:34.9517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrRWKL/0vXIN/q/IY3ZXgKiXY/FnnCsUdrGPkJ1Jc+e14Ja+zh7c9hRaevUSWs7E0W+oTI0weWEw3xkp5Xti8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10801
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
    -> Rx was hanging, now runs normall

Fixes: 12d98eceb8ac ("bus/fslmc: enhance QBMAN DQ storage logic")
Cc: jun.yang@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 .mailmap                         |  1 +
 drivers/net/dpaa2/dpaa2_ethdev.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/.mailmap b/.mailmap
index 10c37a97a6..1f540f7f51 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1036,6 +1036,7 @@ Mauro Annarumma <mauroannarumma@hotmail.it>
 Maxime Coquelin <maxime.coquelin@redhat.com>
 Maxime Gouin <maxime.gouin@6wind.com>
 Maxime Leroy <maxime.leroy@6wind.com>
+Maxime Leroy <maxime@leroys.fr>
 Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
 Megha Ajmera <megha.ajmera@intel.com>
 Meijuan Zhao <meijuanx.zhao@intel.com>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f3db7982a4..3c18d58804 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -631,6 +631,24 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
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
+			clear_swp_active_dqs(qs->active_dpio_id);
+			qs->active_dqs = NULL;
+		}
+	}
+}
+
 static void
 dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 {
@@ -645,6 +663,7 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		/* cleaning up queue storage */
 		for (i = 0; i < priv->nb_rx_queues; i++) {
 			dpaa2_q = priv->rx_vq[i];
+			dpaa2_clear_queue_active_dps(dpaa2_q, RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q,
 				RTE_MAX_LCORE);
 		}
-- 
2.25.1

