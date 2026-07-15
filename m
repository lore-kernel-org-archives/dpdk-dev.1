Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95143C44507
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 10:50:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9ED8402D3;
	Wed, 15 Jul 2026 12:50:00 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25]) by mails.dpdk.org (Postfix) with ESMTP id 5AA074028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 12:49:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0JIOl3OIfv1CIlvi7ibSkYfqd/UcqdLdDKWSn1uD+kw+ToS+/4CnITKiHYrub9u4Q7ttXREITV1vvRW8buyUjrqbq4ZmIwTGbCNcHgHrXkjHpTD/dNsOoAeGnResryvSH20aA6g/yCm0ZDMZBBh86nNy4UUzHs6GxDdliRn79fLe+Zeaif396grTORUCltJ+4AzNzlCai+MpIH+wAbmAEqy4ErcPzMbanKTWOX2bQwtPecCPTMo2Lz71cZ4JJjyt7MxF7orxQwmobQq1ehfoRb9Py8HAb4qYDqSM233v4TYupVS7HJMGTCyJX3lFh++nLcmFVyf6qvKPI6izty8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VCkis34aoqghLdGAHRlSvBjxxJlzS+HeaOQHE/1siw=;
 b=pQqZWtnxCpDPzfE+A6VXb8+S3U/PU1JqCJUXr3OpYnz4/iIODu3/Pptm2iFQwKq022tLDq7t7S4xTVVUgNOZaABj6ltVtyu+42ewgNcPuvzVvSLklnIS0KinQ7T55Tr1ZR2V0uY7AYA1YC7ufZTmD47aMUwmXAv4klRUy6HoYKTLBXhVp0uHvIFnGGjpbbrMpqbWpYdvNWH6Q7iP5t9z2k+7LD+i9Q8iM5eDIis5uI0L7A7TIpHRL5uZo60PdUCX2KO0kwmSNxPElZRe6k7NBm1p70aU9JYrpvrb7VV5itPvOXw+o8MpRglHSSNHVv4TW4DEqQuoeVtrHfpOlND8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VCkis34aoqghLdGAHRlSvBjxxJlzS+HeaOQHE/1siw=;
 b=A2HLlqsaAc/0wZW7owG/5p0bjEebCQb69RYKdxxSE4/f5rWoQn0RmfQUOenvk49eLGY6ipowmhXus2cJXpz9y8jEKnJ5pyCEz8CRy33b0AcHJi3XX0JJpwxlIIjlgiTiHuFe4B8VvZtFLoFzePWdwHj4q4zgBL4zZJcZE5oCYW8=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 10:49:53 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::a7) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Wed, 15
 Jul 2026 10:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 10:49:52 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 05:49:49 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <bruce.richardson@intel.com>,
 <kevin.laatz@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <david.marchand@redhat.com>,
 <thomas@monjalon.net>, Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v3] dmadev: clarify last_idx documentation for completion APIs
Date: Wed, 15 Jul 2026 16:19:34 +0530
Message-ID: <20260715104934.3668478-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: d83c9136-bc33-445b-05fa-08dee25ecd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|3023799007|56012099006|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 6p0LMA2fjoSNppckd2xfqxjYa+atquMFq460q52tdjK0AfLf2WoZ5sOkYHxpWq+WIx5naJDHLx0ACW/OHaFd/FLepnNBvn4Vlj5AIN1PgyB/GyZimINjf/aYBLVz4n9VKM7NL0RJ4ZTCJY/Yti8ZxBqPPz5xqGYiFFcIxGrT1lPMin+T63iVW/zfeOKCt0NLqcGCQwnrK4ApYgnLUwovNEMZAkN7tVg7K0l6F2BUXFFQMgW7pRWugFrc9XWGac7IDYH06cI5lrYiQEsbnE3PUzDA5E8jUVOqKkJNTZhA/tnb3O8YvHx5PmSgWPyGkoMu3pdfZc+1KJ/YLa6ylhCGMQ/zZYrzp0t8xuo1exqalxQsh1y5ftMaTUnMIaez4AZqc96BEeM/rUJRs1GoVvnJRpWLBHSl8FSTvZPHo8AJQ595grLsdyiW/C3WvRxQFvDDliUK65AKfbjlAYH2RjiaXnN9hpEiFrEdsnELfD9/Z3tZkLk29TomzGhEtTsIReFCf1clCbqx7Ut+knL6ESWv1pjhbObBDIFncXZRMaaxRkdbwXuzJLp742/8B3Q3Xry8gcfb5nuSu/OPUc5UPdveH0rKp9j9fOEXKE75ChV6Kl0JnLmwM62iaTePo43dXULFxpRIZ52wyBMTRB65BkR2Bpekhqat+5OXLU1WiFnK1SeDPuGs+HBfJcjDmZJMzF0nZbSHStxuXoLZrTm0MblT/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(3023799007)(56012099006)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GFwyN9JuhMBlLYicYGrQO4ArNjp6dfC22d5fm9RutKSy63USTsR3lLr//jC3Hn1fEioZRVQl87VJJEfOSy6/MzvTLvIkeyguLUHNJjgNP1n4TxR4cgw23FIEwivqIzI7uLVLDrF984/KqPNAXadPiwlJsmGS5LCsI9ohkI6KalgUyFJPvvbJEXLIL4LmTf0n0AmmfheY4iLHvyN932f9KrHxes+5EpbvURhU8P1NjcEQqbo7Z5H1noIrXEZBkvHYv0cEhNynhKelC2laVBFWqZE7usXeBpVJ8BQ7viKjBj+ZN3aJPjxsmx5DM0EvworF4ISfBHZm/jJxSftnf6T0MV7WVdxIo8LzZNUsH8YgjJae6Fsum/9r7NT11lbLcOZDlSwETxllaBKe1Nsv9vdUP4Np3dCg+pfPGh4bGhfyhxRpjljT5KKQrx3nc9aW/r1Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 10:49:52.6897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c9136-bc33-445b-05fa-08dee25ecd03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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

The last_idx output parameter was documented identically for
rte_dma_completed() and rte_dma_completed_status(), even though the two
APIs have different semantics:

- rte_dma_completed() only reports operations that completed
  successfully and stops at the first error, so its last_idx is the
  ring_idx of the last successfully completed operation.
- rte_dma_completed_status() reports all completed operations regardless
  of status, so its last_idx is the last completed operation's ring_idx
  irrespective of success or failure.

In both cases only up to nb_cpls operations are reported per call, so
last_idx is the ring_idx of the last reported operation, which may not
be the last operation the device has actually completed.

Refresh the full documentation of both functions to remove the
ambiguity and make the behaviour explicit.

Fixes: 91e581e5c924 ("dmadev: add data plane API")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v3:
 - Refresh the full documentation of both functions (per Chengwen Feng),
   not just the last_idx field: update the summary, nb_cpls, has_error,
   status and return descriptions to make the completion semantics
   explicit.

v2:
 - Clarify (per Bruce Richardson) that last_idx is the ring_idx of the
   last operation reported by the call, bounded by nb_cpls, which may not
   be the last operation the device has actually completed.

 lib/dmadev/rte_dmadev.h | 67 +++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 81dfe187e2..364a9d335a 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -1327,26 +1327,41 @@ rte_dma_submit(int16_t dev_id, uint16_t vchan)
 }
 
 /**
- * Return the number of operations that have been successfully completed.
- * Once an operation has been reported as completed, the results of that
- * operation will be visible to all cores on the system.
+ * Return the number of operations that have completed successfully,
+ * starting from the current ring position.
+ *
+ * This function reports a contiguous run of successfully completed
+ * operations. It stops at the first operation that either failed or
+ * has not yet completed. Once an operation is reported as successfully
+ * completed, the results of that operation are visible to all cores
+ * on the system.
  *
  * @param dev_id
  *   The identifier of the device.
  * @param vchan
- *   The identifier of virtual DMA channel.
+ *   The identifier of the virtual DMA channel.
  * @param nb_cpls
- *   The maximum number of completed operations that can be processed.
+ *   The maximum number of completed operations to report.
  * @param[out] last_idx
- *   The last completed operation's ring_idx.
+ *   The ring_idx of the last successfully completed operation reported
+ *   by this call. The function stops at the first failed or incomplete
+ *   operation, and reports at most nb_cpls operations, so this may not
+ *   be the last successful operation the device has actually completed.
  *   If not required, NULL can be passed in.
  * @param[out] has_error
- *   Indicates if there are transfer error.
+ *   When set to true, a failed operation was encountered among the
+ *   completed operations on the device (within the nb_cpls limit),
+ *   causing the function to stop early. The returned count covers
+ *   only the successful completions preceding that first failure.
+ *   When false, all operations reported by this call succeeded;
+ *   the function stopped either because nb_cpls operations have been
+ *   reported, or because no more completed operations are available on
+ *   the device.
  *   If not required, NULL can be passed in.
  *
  * @return
- *   The number of operations that successfully completed. This return value
- *   must be less than or equal to the value of nb_cpls.
+ *   The number of operations that successfully completed. This
+ *   return value is less than or equal to the value of nb_cpls.
  */
 static inline uint16_t
 rte_dma_completed(int16_t dev_id, uint16_t vchan, const uint16_t nb_cpls,
@@ -1385,30 +1400,38 @@ rte_dma_completed(int16_t dev_id, uint16_t vchan, const uint16_t nb_cpls,
 }
 
 /**
- * Return the number of operations that have been completed, and the operations
- * result may succeed or fail.
- * Once an operation has been reported as completed successfully, the results of that
- * operation will be visible to all cores on the system.
+ * Return the number of operations that have completed (successfully
+ * or with error), starting from the current ring position.
+ *
+ * This function reports all completed operations up to nb_cpls,
+ * regardless of whether each individual operation succeeded or
+ * failed. Once an operation has been reported as completed
+ * successfully, the results of that operation are visible to all
+ * cores on the system.
  *
  * @param dev_id
  *   The identifier of the device.
  * @param vchan
- *   The identifier of virtual DMA channel.
+ *   The identifier of the virtual DMA channel.
  * @param nb_cpls
- *   Indicates the size of status array.
+ *   The size of the status array, i.e. the maximum number of
+ *   completed operations to report.
  * @param[out] last_idx
- *   The last completed operation's ring_idx.
+ *   The ring_idx of the last completed operation reported by this
+ *   call, whether successful or failed. The function reports up to
+ *   nb_cpls completed operations without stopping on errors, so this
+ *   may not be the last operation the device has actually completed.
  *   If not required, NULL can be passed in.
  * @param[out] status
- *   This is a pointer to an array of length 'nb_cpls' that holds the completion
- *   status code of each operation.
+ *   Pointer to an array of length 'nb_cpls' that receives the
+ *   completion status code of each reported operation.
  *   @see enum rte_dma_status_code
  *
  * @return
- *   The number of operations that completed. This return value must be less
- *   than or equal to the value of nb_cpls.
- *   If this number is greater than zero (assuming n), then n values in the
- *   status array are also set.
+ *   The number of operations that completed. This return value is
+ *   less than or equal to the value of nb_cpls.
+ *   If this number is n (n > 0), the first n entries in the status
+ *   array are valid.
  */
 static inline uint16_t
 rte_dma_completed_status(int16_t dev_id, uint16_t vchan,
-- 
2.34.1

