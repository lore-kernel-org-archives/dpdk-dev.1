Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454CDCCA472
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E62C410D0;
	Wed,  1 Oct 2025 17:10:47 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id B42D040EA5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020122.outbound.protection.outlook.com [52.101.69.122])
 by mx-outbound22-252.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYxMidCd8PnqFYja+VdIRhjIVRdGIkpCW52AatIRlMtreRKE/TGwMZBLh9XHjwq9X8HgGY2Xfu337JtRQN4Bi82kUZrGglMycPP5TeHjhi6SgNuXUvFInVD+jj8y2tZRrAX+6LszZRJboFI6Y8UKJupDUiWF6AAxJQFdrLNuICqJFdxGglLxrxcyG8RVJJ/XSXUyR4TWWKjBJQmsCzEeCeMJbwOa2uDmaXJqmh1oD7/iwczuWP8nm8nHnIM45cvI7QWF053f7Bk2UiBjZiBLzs8rL/9niwgG+PtCdZkEeqvh90KlgGatzaZN8xkmcC17JVWxXZcNaYFa8SV7hJyHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLDzZtrMCYfwaiX2ZtAxblPGabrVvGXeBqaZcCbHH7A=;
 b=kCLKKzctQZ7wBmQ5R1okR4VB04W35AayVeciRIdBJFpL/fc/MdBJ6aKA6XyXQos2KCsccIEFp8Kl230zsP8RyqGsjJlpUL95WWki3Af/4B/LrYwYg0khYcvEpkWtulEx0RKBebaa9URNOOSR9fGxBuXldQEAli6/lvNEc8cTkR1+a850AjZwyT8+JO50wWXxRR1d3V3jgS+tkeOpO8Dcqkk5lHnnhGej8zQOIA6xJ3XkctpnAMgD3AanDcXxu9YwS1S0UCkxKkftbhlR53cqb/pZIKvCYWk0/T+k5Bts8j+yHzBvTfACieE5qjdvEIEBL+vho45W8F2VO9rFQb5Yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLDzZtrMCYfwaiX2ZtAxblPGabrVvGXeBqaZcCbHH7A=;
 b=LgFCjbU4KyTLiOk+A3KE5qFysk7p34PiaStccLHrOuPR05fWwKy7ZTF9OEhYVGqvovQZ5VEJGQmB9HOxhyIv7+IOBWARelhq15/K9eaZtovajb6/gRRe2KhpUXxcCNSYp2dXN9h8JIJm/gjrEN+wqaHbE7INUumZGP8zyuRjjns=
Received: from DB9PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:10:1d9::7)
 by PA1P190MB2246.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:485::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:10:38 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::13) by DB9PR02CA0002.outlook.office365.com
 (2603:10a6:10:1d9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:38
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 19/20] net/ntnic: rename hwlock
Date: Wed,  1 Oct 2025 17:10:01 +0200
Message-ID: <20251001151018.250671-20-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|PA1P190MB2246:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf1274ca-993f-4e53-c8af-08de00fcae39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RjjPNEiujYBSo0Wu9KjsaNMIXnepBGdBrDkz3rvVDQurqdZCa797uVhwKRnf?=
 =?us-ascii?Q?YtRCryDrVxVP2o/LfHvMPuALmZ0li3gJEJ6w1h2sDgmeA3xNp8tsvdIJl1Rl?=
 =?us-ascii?Q?lpL9wbPJfbsnLJP+5YjlOmal3IqJB5J3wZkBkNwYtypuJ75P/TzH65k59oZ2?=
 =?us-ascii?Q?J9It4dgvQR6PyNevawwSotMGYC7FJCOq0Ka7cESxoOm/p2MROXRJrJMVlZeQ?=
 =?us-ascii?Q?Nn4nRoTygvd5v51omKHUz5mzTHp7nf08svYTBYCV8neKd/AgoyP+ZWA9sTHy?=
 =?us-ascii?Q?eeJEP6LPATowvxnSQ1zxen1Pf2Twio1BO6bl/l0kiFD3IuikW8yhrxlm3yyD?=
 =?us-ascii?Q?0fa+iLqp4qnwUI7zJA3H7/L2wnHJgMsPMYcfBt48R9ZCZ+R/BeNIcbr9ZgmZ?=
 =?us-ascii?Q?R7ikrT6IZ4F4nA1PA6IAPEqEyi7pnRmAR3pMH8us2iJefbxY7oKccab+Db/3?=
 =?us-ascii?Q?yCHoiz2FGSKkaA0nhEfMTmDb0u/H2x26mTSnjV0iMJrZZ0kVRbsC/x4RVyRK?=
 =?us-ascii?Q?/7FKcEJXJdBc7KUWFnZAjf96S1bpwKX7XmpNcZ+sVFIQXnUUrIxg4xFWEpKh?=
 =?us-ascii?Q?KUC+Nim+m4yQm5FmNXYZOkHTS7VvgjKkrKNBUd3rfVmc+fWayIX8urALSOtH?=
 =?us-ascii?Q?67QZZqcvEOM1O2wbuidV+q2+pmJSp+BPBZXzkHR//AWL1g8ZEw4ZPutncupE?=
 =?us-ascii?Q?j62SYjG3LBteoinNS4vuRUGN11drDlvEI5gRr63BWBABy+kBvUcXzoo67YlO?=
 =?us-ascii?Q?JUv5uwSeFE50MdYkPywwIZgb4J8h5vjERjKqbhdI/rkAPhRTDNpZ5scTIXtd?=
 =?us-ascii?Q?ay+HCiUqWtlLNnKd/ksGqy/0Mii/gahK40T4W6Xl1FagooXlhayoIzwTf5Uu?=
 =?us-ascii?Q?0bhu33O077bHOCRKqjH8pb0KFZywKQ+rqk0SqWCyVLEcgNmKjyPIVDbklYq0?=
 =?us-ascii?Q?bxmx/p86fmoDG6lj38ZFKi5Wc8jnoxox8gj/YEGVReIcN+CsZg7A2EJfnxES?=
 =?us-ascii?Q?wa2zBxApGuGoBbtXc0IZrfOy9cQDcaVnxotUTsFXkjf/bn0s2gnv5uSL78mV?=
 =?us-ascii?Q?u8T+n6eKzw9MaatLEePulynYbnM8Tk82gIkDceGSeNY84Gns99aQgbuLTOo5?=
 =?us-ascii?Q?ZOFppCf9KwYO0ElycEZqeRZcqaYrz9Z9acVfTcTPprhCKLEOxu6ErfTzjeqS?=
 =?us-ascii?Q?+XFOgnquJOA59kCn8g0QGXb/Pz6vwHoYT6wBKCXRrrTT2ZxvsmUzOxHBkLR2?=
 =?us-ascii?Q?KVD/AdaRwJkM4xY8Yx8ZZATDEblTlSNOM+I5MQw9wjlXJdgHoo68YmymrqS3?=
 =?us-ascii?Q?DwrHeNCpp6SPKGusz+odNXr57dvbxoV3i6BwSKBq1QHJTBaeqRM+vykA9a+5?=
 =?us-ascii?Q?Bo5x3wzKfS5A8PllJbu3qRauVjqQU1NT/RqoOf3gZvNeP+FAjLM8uiLfNI6Q?=
 =?us-ascii?Q?L3J0G0fy1gtYorvjeLmie+dHGfUVpFTIpeNogWctomI8x7aCrwhgbg+E1bm1?=
 =?us-ascii?Q?0ufM0MltarrSgYQtDDdYYOG6WL8J1pYfL7BvOOGf354merCIV70RuQ5s78UD?=
 =?us-ascii?Q?FvkTtr3RkthhVHKyhOg=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eVLwZVVBeZX7A0oW/8IjM2jovxOA+X2FM2mvJaVOcXVUT7fGxm/W69E5e97PQowoy/CYbvRfxkGkR/gDpIOzyK37RyybVhaHUmvIHFgfAA5I3o8pSs2y2VhmUkn6MEzbmv7y+Pilm7TtqpnMp7/yJlsPd/UquLnt0QHvlOENXfjjJOmmJQKVTpp65yP7sh7ROOFQWBJ9ocR+tc3jQDBLzf/xlEELkJyqTUb5rhGEqFKa4+YK7xwD8RkVyxosM2yJlzttM6d84CWGSQV9hB+z2Jdr3dNTiQqtWS/S/Ct0JF3SQDHkKcRmpduETepGTNUOEzG1IliC//dIx19KQHghejPoIoZFtciP6MKsTKUrQ0lHzbyrm+ktQO0C4EoL+325R9TpLSTWGo8DeUyWLbI1cDJjelrR7uc7yKCWuqu8YUMbwCZuL8Ff6aSUS5AcjrHMZgAAJGMQXZu/3zeqXzuwSW0ryBuWUdItcQOryaK848AVLXAnWjMoNJxzYrDgwZSL0+EskZ9uVRTtfO3d5SlSpCcGfPgjBHagBjkc27RefXP8rPnYkipn8UnxQ14UKB/Ak/Pd5exYuNkFAlpEqSMIYB8DLz6x4BsK1dqpuUw/cvk0AZ7rKH2TIeYLvWFs0LhDJpTnxeystoyD1xL/skUhNw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:38.5597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1274ca-993f-4e53-c8af-08de00fcae39
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P190MB2246
X-BESS-ID: 1759331439-305884-7639-4396-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.122
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZmFhZAVgZQMMUozcQ4xdTEws
 Q4yTzJ0sLc0sIyxSA50dAsJSkl0dhYqTYWAD338zNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan16-205.eu-central-1b.ess.aws.cudaops.com]
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

