Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0161CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:46:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDB8442E7B;
	Mon, 20 Oct 2025 18:44:21 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 0232940E27
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:58 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021123.outbound.protection.outlook.com
 [52.101.65.123]) by mx-outbound9-130.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfUCSo9N2VbuUCm7vqrjkbRYRQXbwaTpZNQyqPMNPOJGGg/lwVKHz2Ypv3h55aYGyBDNzP39w977qIqlVuAAMNPjSvHcvxE6rzrmRi+K72izxWaa8Ex6pv3yoXLBmeW0a72JYoC5Xjg5jH4qNKDD/HZcM6GerJY3OkMgKude2zoEYWmRr3MeYlI+twKNGsYDppc5PkRLfhSIKf9RVD3vL6nynQOCXQ0D3Z02t/WR5C4Q4buWfiUVylLPvzwY3MbnscZcqdx63lzoDUbDkY7SFGDyV31OlrY18Qr6+K27mSz4J+7eKrp0DC1UhHVuNXiSzy3r5syqSWthrpSbRukbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLDzZtrMCYfwaiX2ZtAxblPGabrVvGXeBqaZcCbHH7A=;
 b=PHZUxng8B/OCjnE1kaWnD7m/1tdk/W/t8zPIjzeSUKCYYRgTVUH2e3jJTqKHxTix9BI3l0ZXDzmHnzZPJuHRTeple3fZVH7BvvIYhv8SU+EUTxeu8CMnkX2Oj8OAecObS/l+tjufqaViXg/KohDpfMpIw7ELC5CJe1kL1HktQesp/a677ik8qSsRJ7NgxVDRESVVQnJ+9/6YRmYkHSpXI0l/Xm9zFXUdOerB0p/SN+f7KZrywFk49z1HBAiXvE8R7iDVBf+FFGFa+tzo1eiSQZ19LOsD5hFwrdwIA09cE1GMb3SefLDmqYFScYLbqXBcoxJ7M0GeWpbTypm2XJ2aOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLDzZtrMCYfwaiX2ZtAxblPGabrVvGXeBqaZcCbHH7A=;
 b=iRCdyV4rwoPfCQBfUE4srZwrjye+85i7PmzHpmEg7n1OVoAO7z2vzLafpwMUzggQdyZJL3WLlG2mrmCUE+ZYo9i+DloYxzoKc7LsJMkMyvZU4rGscDJUA/oGlU6HEAEvHIosi4A7PhtJBRZkrE8JhZpTiqpSQiwcmm+CBVylo2I=
Received: from DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) by VI1P190MB0784.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:11e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:54 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::d4) by DUZPR01CA0018.outlook.office365.com
 (2603:10a6:10:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:54
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 19/21] net/ntnic: rename hwlock
Date: Mon, 20 Oct 2025 18:43:28 +0200
Message-ID: <20251020164336.283664-20-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|VI1P190MB0784:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1062f7eb-a736-4d40-1dff-08de0ff7db59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lXna9y+6DKyWGQjmsg5GQ3FQms12WCNJB6e+wWdshk1CrLmKEa61AsoF5dFU?=
 =?us-ascii?Q?+A2Bu+3pBptZ2/NkWfdh0sTdNLyhlUh79Emvgnw37GUk+HPf5j/zmkgfldVZ?=
 =?us-ascii?Q?qsyQ8PM346a+ZS55WH5Sf96xCDIH4JCMmF06Wq/MJ6pxF0rqmuQxy3oOzcp7?=
 =?us-ascii?Q?5RNI0E5CtVosZQGykEAzutqGSvIrb59Myr6fsAhqte2x/ZZLEFe8A6hdyVXu?=
 =?us-ascii?Q?3jGVpQNxQGmzs6cBSwJdkckEpffFS7Ihy6tN2s6Snkdley3peFy1y94Hr9Bn?=
 =?us-ascii?Q?AppRcyUIy5niv3oLHn63nf3+2iEFCCb/HdE/huguSh3Vwk6+0GxmkEPrpUaF?=
 =?us-ascii?Q?vv+bfXY9crrUysHJGMWBeACbRTNyFd1ozjpN2LkEvlMFBaJK/BE4h/v2Izr4?=
 =?us-ascii?Q?whXKdqAXJxIht6XbqEN6IzNV3D3UGa1XcA8tpU8Y6O8c42LLPHm77IVOsYSd?=
 =?us-ascii?Q?kt2pCR3ipqU49WsJdzZGwUTN+1S+V1SIDWM3qAgYmOLN2yhQNoQICmmc4mk0?=
 =?us-ascii?Q?VqcNdrr+CMPVCNbMdm6ikV0gE8FUfGfzUE4jAxaxutza8RoChUwHcFJeJeSS?=
 =?us-ascii?Q?eyjDgB8KqNMu8GKsqMZ8kfjitfXr2JB3aPsOxtKdUs/eho+rVR7pOuUJ1K+n?=
 =?us-ascii?Q?4QFpboX6cbdvGPpNS1gdiM6U8nwt7mzSkFV0EtqRDR//L5OH1klByhBZKStq?=
 =?us-ascii?Q?n/MWhXRx8uGjztGulwCSNfwxe2fLhn4Kjrcz9189yqp9/KOZNvHxqrS0Jp67?=
 =?us-ascii?Q?qDZ4XBCbb59p1D2UW6XtdFUXuLlTwaGhOtbUIAsBNjCTscLl/92Y5ozdm1Pg?=
 =?us-ascii?Q?Oe4mLGmKCN5BeBd+iIiWuJgTmoSQyDz/ryS6A8MY/7bvJu61W4lwqcFo6EmS?=
 =?us-ascii?Q?ZGcqnVKmlYgoT0O9RO0qoVfWxxb2rd80aoK1cgKugn9dzGgOf5uI+HXHFSR3?=
 =?us-ascii?Q?qoOp9N42LqwERBzMXJk5hlJR2V5x6iP4SguthazzFaEiWUqRQECgNqc8YwjL?=
 =?us-ascii?Q?SQCWiu1BLVn12nxEYEkbDTKWJF8kh8tqyRIuAis7OWDQNZXHx7Y7a5kep8JF?=
 =?us-ascii?Q?DbmfYdffVErhgYx/BBY7PIYtvWTmrfdDrW3KaETvbwQduU1u8fTAc71C6o01?=
 =?us-ascii?Q?pGOFbuCAYUsXEOM4Oa3dT4mivY71VJIVFrm9Etu5R+dbReNAe6NXcmy4IDgr?=
 =?us-ascii?Q?FrRjjv1hSKdMLat9BC7OYgArDeT8jyahUTjDmEo6LGEqZjZP9oa3qR4nmMIA?=
 =?us-ascii?Q?OnFCtQIarD7zkO/7tuv78/zJ748bz/HzqTSMWiTLBpWLdAtUuS/9dxMEDS3F?=
 =?us-ascii?Q?xkLHE1PVV+xoKR0nqwYXpgo8U4cjqkfMmvGjK2km74w/qGJajuxQHVyZy/JZ?=
 =?us-ascii?Q?kOQIiJ/Z5J30yAjG0Z33WXDkDdCcnCOAkOeJcJPol2Pi8F3Jb7lrDRlBbhk/?=
 =?us-ascii?Q?jz++3UCaum+s+dHkaXyvfjLj10KvT6AOIxRlFSHpKaMxk7yRaLMsMkn7e/uw?=
 =?us-ascii?Q?9EtCZDYLrjFMj3ekVvsEO+rfco94l6eQVqyw6Az1TvuNGpZ3wDyJk4URU5Ia?=
 =?us-ascii?Q?/yLggVrvm6lydtRMZp4=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lSNfV1W/Zg7Zp3siFsP9U7O1howxtXdsEyc/6ZNuHqH9pJUIruynppS/QQmq1qiDybWVJfgqz1XnL5XkE6IDTYlY7tNbMe3mSm07eqaUOPBwdd2DWXvhU6baHtsI/VP0ClxwK/VdJlM08cPoXYinkyhyR+EwxD7kcC9kjH0FymRw18m6g18y9vra4vsMA8Xj3skI7fdYBtMb85E2gVTrmQZec77DjULIH4hBZEe/Z6goF9ClonE9AeVy8Ao17KfJbR/2vMXhE6sAhW98x0tF0xS6m0OPJIPRHXPQUfNGaMXkujXG4ksBmT+BkyLisnnYDZ9LGkd7VyJB35/wMvJZxhMfDsERI/GxuOAZftQo711F5nvCPOZJFHDBP8Ut4OOZnUbv55fgaTplfyfnOWXpYKcHdQ4AA3KtcpnGKRhpRNkWifJmDNl9IKgkFnBFFvK2RcPdKoQ5fDSdf3k8JcY6EVZQfUno7YrIXbKfNN/rqpgkxLLF5n4RmvMoQ4aLXPaG7l7KvB8I1HY6nvavBJDpOqkTGidYvblq42Ht3xDeOoouHH/LHAUXge+Yw6rdiW+Lcus6zTu9Dj86YntDS13GqslpE2+NXv/4/gGpDnBR+eV8s85vlx6xILZmJRL75byTUy3GSCW/hfE0Rl8abb8U8hRHCFmGp8SCZaMkp7e44Lg=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:54.3118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1062f7eb-a736-4d40-1dff-08de0ff7db59
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0784
X-BESS-ID: 1760978638-302434-10212-72929-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.65.123
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZmFhZAVgZQMMUozcQ4xdTEws
 Q4yTzJ0sLc0sIyxSA50dAsJSkl0dhYqTYWAD338zNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-181.eu-central-1b.ess.aws.cudaops.com]
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

All global variables in driver should use common prefix.
Rename hwlock to nthw_lock.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/stream_binary_flow_api.h |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c                   | 14 +++++++-------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c      |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ntnic/include/stream_binary_flow_api.h b/drivers/net/ntnic/include/stream_binary_flow_api.h
index 4ce1561033..3c6de8899b 100644
--- a/drivers/net/ntnic/include/stream_binary_flow_api.h
+++ b/drivers/net/ntnic/include/stream_binary_flow_api.h
@@ -47,7 +47,7 @@
 #define RAW_ENCAP_DECAP_ELEMS_MAX 16
 
 extern uint64_t rte_tsc_freq;
-extern rte_spinlock_t hwlock;
+extern rte_spinlock_t nthw_lock;
 
 /*
  * Flow eth dev profile determines how the FPGA module resources are
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 29508888a3..dc9202cdc0 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -95,7 +95,7 @@ static const struct rte_pci_id nthw_pci_id_map[] = {
 
 static const struct sg_ops_s *sg_ops;
 
-rte_spinlock_t hwlock = RTE_SPINLOCK_INITIALIZER;
+rte_spinlock_t nthw_lock = RTE_SPINLOCK_INITIALIZER;
 
 /*
  * Store and get adapter info
@@ -127,9 +127,9 @@ store_pdrv(struct drv_s *p_drv)
 			PCIIDENT_TO_FUNCNR(p_drv->ntdrv.pciident));
 	}
 
-	rte_spinlock_lock(&hwlock);
+	rte_spinlock_lock(&nthw_lock);
 	_g_p_drv[p_drv->adapter_no] = p_drv;
-	rte_spinlock_unlock(&hwlock);
+	rte_spinlock_unlock(&nthw_lock);
 }
 
 static void clear_pdrv(struct drv_s *p_drv)
@@ -137,9 +137,9 @@ static void clear_pdrv(struct drv_s *p_drv)
 	if (p_drv->adapter_no >= NUM_ADAPTER_MAX)
 		return;
 
-	rte_spinlock_lock(&hwlock);
+	rte_spinlock_lock(&nthw_lock);
 	_g_p_drv[p_drv->adapter_no] = NULL;
-	rte_spinlock_unlock(&hwlock);
+	rte_spinlock_unlock(&nthw_lock);
 }
 
 static struct drv_s *
@@ -147,7 +147,7 @@ get_pdrv_from_pci(struct rte_pci_addr addr)
 {
 	int i;
 	struct drv_s *p_drv = NULL;
-	rte_spinlock_lock(&hwlock);
+	rte_spinlock_lock(&nthw_lock);
 
 	for (i = 0; i < NUM_ADAPTER_MAX; i++) {
 		if (_g_p_drv[i]) {
@@ -159,7 +159,7 @@ get_pdrv_from_pci(struct rte_pci_addr addr)
 		}
 	}
 
-	rte_spinlock_unlock(&hwlock);
+	rte_spinlock_unlock(&nthw_lock);
 	return p_drv;
 }
 
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index c1a05255ee..fc5f5f8d2f 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1215,7 +1215,7 @@ static int poll_statistics(struct pmd_internals *internals)
 
 	RTE_ASSERT(rte_tsc_freq > 0);
 
-	rte_spinlock_lock(&hwlock);
+	rte_spinlock_lock(&nthw_lock);
 
 	uint64_t now_rtc = rte_get_tsc_cycles();
 
@@ -1224,7 +1224,7 @@ static int poll_statistics(struct pmd_internals *internals)
 	 * if more than a second since last stat read, do a new one
 	 */
 	if ((now_rtc - internals->last_stat_rtc) < rte_tsc_freq) {
-		rte_spinlock_unlock(&hwlock);
+		rte_spinlock_unlock(&nthw_lock);
 		return 0;
 	}
 
@@ -1270,7 +1270,7 @@ static int poll_statistics(struct pmd_internals *internals)
 
 	/* Globally only once a second */
 	if ((now_rtc - last_stat_rtc) < rte_tsc_freq) {
-		rte_spinlock_unlock(&hwlock);
+		rte_spinlock_unlock(&nthw_lock);
 		rte_spinlock_unlock(&p_nt_drv->stat_lck);
 		return 0;
 	}
@@ -1307,7 +1307,7 @@ static int poll_statistics(struct pmd_internals *internals)
 		}
 	}
 
-	rte_spinlock_unlock(&hwlock);
+	rte_spinlock_unlock(&nthw_lock);
 	rte_spinlock_unlock(&p_nt_drv->stat_lck);
 
 	return 0;
-- 
2.45.0

