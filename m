Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B26BC36010
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 10:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C0F540613;
	Wed, 26 Mar 2025 11:10:44 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
 by mails.dpdk.org (Postfix) with ESMTP id 8624A402E0
 for <dev@dpdk.org>; Wed, 26 Mar 2025 11:10:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyFaHfUViejjDzvSycXZ+Fs7p6rfxFNxP0km2YoQKrnq+5A6QeTrH7NrK4gON1kdOy82uVyEdAnzacWR0FIOxcfrTugnkRh9a9o1CoMznzQVx6i3gquNv2eIYo/dxM5zmy5ib4EgDw50exKFvSSLlBeejFmHt2s7om/bO41NHfulRBQxeQpTR+LoBioC1pZzSmvnHvr8D3KzNvY8K02bi5TDtpBU8RG739hxJJuMJ4o6XADISpnsZZwKDV5DLHtuj1tUJDBaSc+oe7v5nfMGiMIavbV5k4m0NqmtlwFr6XWRjcZ3DgOCe5rCvKpGaOuBc2VKq52HsObMwjexomHylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJHHNxJHqHOcRYmxwXft3TVTYVU7654+7A+8K1JBvgo=;
 b=bBbt6y4HGXM1fkv76+PI2PCNpmmmimN/oZY7bN134OynWVNO6HbYhhILrsxp+o2NSsysTlznbfl9fdc88BZ+rImLWiaczt9IZ2oCtI2vRH00csJWzPZHW6mqlC1Iu0sBKnQincSiajaCAYpNrHg7QkhzFk/jR4fePW+BAYQe0vu/thUl27S357Nh23/epNwy+gCcCJbnJdz560gPMoiz0UR1pLSChsE1qNlOg2JHMlelEvdMcSWwhFHhX1X1xRddkEho/bck7k9w4jbLtG1vocIqrG9j76/b2jxFQxVYoDpwyqGKbkW/7CZYGDn/j806mO8VG17nCpzgr5T+CQGzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=marvell.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJHHNxJHqHOcRYmxwXft3TVTYVU7654+7A+8K1JBvgo=;
 b=S5XV3Icui7tY2zTkDstVs06RAt1crToZrIhaoyxcPsXFZtfiqZIfOcKIc6faBJF4fQauFJ+eUi5CCQta0MnDirxMxz63Bo7TUflPAgCyiZKXhUKqV72/abPhivbPhpKFP0PSIeQOiJNQkr9s4wdTzzJyvXl2nNIizVyANuePNsdHMf6yzeWh57csBfVW8Pe7QkEPmTNIM6vm2YUSnxccayPu/Rwfvxf3308VjAOfPdt/gPPtOnbFdG/rClX229vat754iHCWWESnp8/5VqCbZ4X7hsWnlkrm6p2aveJz8+EDA06BnRMxP2d/X9aEXJg/9Pk2ojVGoq4s30n7x7lldA==
Received: from AS4P195CA0044.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::7)
 by AM9PR07MB7713.eurprd07.prod.outlook.com (2603:10a6:20b:2ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 10:10:40 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::b5) by AS4P195CA0044.outlook.office365.com
 (2603:10a6:20b:65a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 10:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 10:10:39 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 26 Mar 2025 11:10:38 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH] eventdev: fix dereferencing null atomic locks pointer in
 test-eventdev
Date: Wed, 26 Mar 2025 11:09:52 +0100
Message-ID: <20250326100952.114143-1-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|AM9PR07MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: b3344965-7f18-48a4-92a5-08dd6c4e75a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7JRdrQP6uoTGZ1RXBtnL6jAEVl7hEzL7Pfc7MHsO2pMLwaeVWH7yj5+u+M1F?=
 =?us-ascii?Q?vkxHPl9AWmn5tjPr099EDoYi9vQFIqcZ/h7VP+HFnd73/6unD0v0MtSHNT7f?=
 =?us-ascii?Q?LmEFu0Rjh11SOiZrMtb/pllLYPX1tYUCjzCumZDlXwvh++fkUPsw1n9fmkvc?=
 =?us-ascii?Q?AxblgWlOFYmuNGuxeikAz9bYxFB/fjo3IT/hA6gfV77USsiT+d4jpVY8ad7U?=
 =?us-ascii?Q?7GxYJMp+KYoVK4sTQv+x233Xn/7jAQHf6Tg2IIDgPOLKClAA5dzhTKTqf3Dw?=
 =?us-ascii?Q?YnISKl8207Fke06d93k6zHit14JocTANhoTXMCbFyckLYUtzeS3gAxTD63WK?=
 =?us-ascii?Q?CqZGJ82BCnWZ8pC5n8Xssnw8UiifP0gQnqOhFgbx4ksn5EJdZMUpCL1UPjUQ?=
 =?us-ascii?Q?PqpKqMpLUpbRi0k6Wer/LxHpMjrHcicf3my7YzbTG9wKpuCw2l5pvUO5XAdY?=
 =?us-ascii?Q?6VA5yUHSQrQD3zOJVw2g6/oBvM4zlslenuTBrpFJCq2Bc3wb32nyLWnlhc4z?=
 =?us-ascii?Q?9w3opu/eFHe+NdOCHzx46VEGFPrxt3uGcuuU+8mmRNs9BrJx7PJKgKJDsHdj?=
 =?us-ascii?Q?6QJ9vkpv56Ln/hXc8hdq5pqGuamPhm+incQQ16D9jOBUmkY6jRSztl3I9QDh?=
 =?us-ascii?Q?TspmfSFqX9Z9bQ3DrFyx2V3biPbVD27KfArVxSocHHMm96vbwCBue8XCHPfW?=
 =?us-ascii?Q?WSEld0ho/OyYQiH63qwWT9ohUOxZcnIy4EM/ar3LGWn851aIsMjeEM2LCcYi?=
 =?us-ascii?Q?GfTG2XeFinirssjNyMSd03BdPuo+dzeUB4iN6OLriXfOArd6PahXmHFiwN6i?=
 =?us-ascii?Q?Tt4mTwkVTNxcbJFPNRAhyiBMVFBoPazjdE+bcxOXtNoVWgl2jvR1A7wyB/7y?=
 =?us-ascii?Q?8vPRb5t89gNnLLb2hLWZkT7+L93gJHyTC8SCsSKk64lcA47haRrTTmCaCWbF?=
 =?us-ascii?Q?Bjhsb6w0b1LW7PvXgCpdzCXUxf/ZztyBDsNA+Ux4TI5xZjq5SrCIZ0sEFBD6?=
 =?us-ascii?Q?QuK3WWfylKrTqOvRV0Dn2688qsDyn6MJuUuFMieNu6cREYtAkf+k1NDYbATu?=
 =?us-ascii?Q?j4QU9fq5SsGZtQiUzBV+crkr/k+HrAjoAyjrvLcnQjFv3mRQNKq2LSCPyRUl?=
 =?us-ascii?Q?66B8lpqr1UZWpPM0tUE5dMSDYaIam3dLKRHx4LgV80jTuWgnlDwuHTVNvdG2?=
 =?us-ascii?Q?eQPKRpuUM50jzBFurtwj1MIkkj+1ZFOWFioRAJomb2QTqrCc187ik/i2K20e?=
 =?us-ascii?Q?m+GLsjXlWHuyMkvM8aQRfqn3kniQhQf8GkTET6kgv10iGiOT1DbbdKg6YqHS?=
 =?us-ascii?Q?jOIunC6VRsGZkaa5qiyrAG1H5XsEM00uSXJqkaatUKfMv+sORrwxgJXEy+uq?=
 =?us-ascii?Q?O0wtgnGifM187gDNgs7OoD00gISlKVLF5nTWlaVLHLGHh7YHzVpJCBuoTcJj?=
 =?us-ascii?Q?gtiPZtl3mpzVdSRCx/mZ6RgM2110isggajSNbjf9X0P0flZdtj1W/CHhfNnQ?=
 =?us-ascii?Q?TV9XpYK1iPJdqDT8UjlBp6mh4v5JxBkbQQn3?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:10:39.2559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3344965-7f18-48a4-92a5-08dd6c4e75a0
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7713
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

Update atomic_init_locks to immediately return if memory allocation
fails. Atomic queue and atq tests updated to handle atomic locks being
null.

Coverity issue: 457876
Fixes: 9d619f82321b ("app/eventdev: introduce atomic tests")

Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>
---
 app/test-eventdev/test_atomic_atq.c    | 2 ++
 app/test-eventdev/test_atomic_common.h | 4 +++-
 app/test-eventdev/test_atomic_queue.c  | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/app/test-eventdev/test_atomic_atq.c b/app/test-eventdev/test_atomic_atq.c
index 4810d2eaae..73e2a53ae4 100644
--- a/app/test-eventdev/test_atomic_atq.c
+++ b/app/test-eventdev/test_atomic_atq.c
@@ -175,6 +175,8 @@ atomic_atq_eventdev_setup(struct evt_test *test, struct evt_options *opt)
 	}

 	atomic_locks = atomic_init_locks(NB_STAGES, opt->nb_flows);
+	if (atomic_locks == NULL)
+		return -1;

 	return 0;
 }
diff --git a/app/test-eventdev/test_atomic_common.h b/app/test-eventdev/test_atomic_common.h
index a3cec4791d..0ee81328a4 100644
--- a/app/test-eventdev/test_atomic_common.h
+++ b/app/test-eventdev/test_atomic_common.h
@@ -66,8 +66,10 @@ atomic_init_locks(uint32_t nb_stages, uint32_t nb_flows)

 	rte_spinlock_t *atomic_locks = rte_calloc(NULL, num_locks, sizeof(rte_spinlock_t), 0);

-	if (atomic_locks == NULL)
+	if (atomic_locks == NULL) {
 		evt_err("Unable to allocate memory for spinlocks.");
+		return NULL;
+	}

 	for (uint32_t i = 0; i < num_locks; i++)
 		rte_spinlock_init(&atomic_locks[i]);
diff --git a/app/test-eventdev/test_atomic_queue.c b/app/test-eventdev/test_atomic_queue.c
index c1a447bbac..8ce0849664 100644
--- a/app/test-eventdev/test_atomic_queue.c
+++ b/app/test-eventdev/test_atomic_queue.c
@@ -189,6 +189,8 @@ atomic_queue_eventdev_setup(struct evt_test *test, struct evt_options *opt)
 	}

 	atomic_locks = atomic_init_locks(NB_STAGES, opt->nb_flows);
+	if (atomic_locks == NULL)
+		return -1;

 	return 0;
 }
--
2.34.1

