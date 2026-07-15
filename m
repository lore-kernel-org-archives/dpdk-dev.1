Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BAFC4450A
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 06:06:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E794028F;
	Wed, 15 Jul 2026 08:06:55 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62]) by mails.dpdk.org (Postfix) with ESMTP id CD6024028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 08:06:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9VIjPG03afeU0bDbg0JE5dP1srOVs78GvvILawCzJRu2VnW8tRgCYh/1ly4U+NyKO3W8u+Eo/YAFtJw2nDkgpsOGxFuFV0a2FYtlJQ4vYNyptxogbKq8LmC17HMW2o219DAGMNUYaQY+mOPId42BE9Q+0oFl4g36RJxo3hdjRqyIB243Gilg/xAfk3VDZHu+A01EOfhgv3vN6rB8XkDXTaeDyjBlF9u8xirstTU0BYX7ZgA47nYlg2ikGzGcf9RuND2PbSmYJ1YlWEjGTOaJy4PDPZJ8fEl/PXy+efTf0YuI7WzeIoskMlJRWUHOcShenBOtZ+O5oRrEaLc2R/RQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pFtJxfTlZfjuUiAzODyUC4Fmpz33vr8FZFukM6a5GY=;
 b=ZJ8chDY0DQjW7eGLFkjrqLBhpFKeguoTPdBWftBjzoDjAkoKtcFUVzMUD5psMn6fiu/X8dbtJ6tdkzPbdWHxj7jmxCNK7jB7wLxDFrPDGIq1EEB+FUk0SxFWlMDU/ftvlOIr6TUIVAhW0iPUCm0423IRcvErwTop7oxeSz+mk7Ki/ZvhgsC6h04KoBXaMKYSQ8a+qZKujcB7pgqNAtiJBt4R2qRhkBdANyNNhaeRD6Efru9Upb2nFuj/YAdfSbWojtpO4DFRQca5052K+oNRFMcpiP3+RiHy3SOauYRu5R76p4Z5YR+n6dNsnEQLS2Oh/GtIrBmALsLif3gmw6Vlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pFtJxfTlZfjuUiAzODyUC4Fmpz33vr8FZFukM6a5GY=;
 b=zV6JvGfsKGs+8//7Kp+YPJbnfuqNd3sLfk8mIUmeto22+nETfUvQv7Wd+lVqRmCbvmVFETtbGVa2pkD9tMdPPNJVj4mwRGXRqJgKAAzwnBPWPjnF9kBrFU81H5yc24LaIuWoSzaQn5vCM7nC96JKXIKaWE7eVxa5TvEWIgShk7Q=
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 06:06:49 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::1a) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 06:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 06:06:49 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 01:06:46 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, Bruce Richardson <bruce.richardson@intel.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, David Marchand <david.marchand@redhat.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v2] dmadev: clarify last_idx documentation for completion APIs
Date: Wed, 15 Jul 2026 11:36:30 +0530
Message-ID: <20260715060630.3450172-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: cb879e47-4627-4e48-3323-08dee237422d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: W5wnRZGzXcTnkVVvfgmGqXFnmO38C0n51gGWwZL5CJ6kj0naOPIYcGQxajSrxNCZxyz01JTCIA4xT86RJ4S5BlSWkiCztEDHr/BT850Cli4JZD/aed5f0G/H1Bx3yVTZtwZoWI13SRpsOL1anl/mqm47TcJ/ipJ3QNyZtREUi7NDm2C8N0NZjZkyujjaPVjny8IwI1UimnK55n/t5WLCuagxsXcU1Z/dKzv933NfyvtJCGhiVwxdgpvrbb5tV99k6cTpZQNi+KJioV3mwsACxSW77bDWkBN/O844kw+2NehJK7WAZrxYa9IGJppY4m+Hgp/tcSAPcsDAZqJ5xo07thLSNQ1kMgGl3OdDZCreF4bnrR/73H2NxhxJgnKkYwZW7zn2gKIlAu8b1Y2gru1L/CLW0Sz+1VTOGv7B0GdsvXv+YkDOxXuF/k89Dqn5bzEd0jWN85Qzx0KdNgClY/L3ZVukHwju9HNc09BRc7KEHKjqNhe8VG5VSRLdcPhyepM8P0CWp3iLcseZ9h1QX2ePX/NiAuIYbmruKwQhhVMitABwamTxppCUGcDvII9lnus5WkLP0kJTzUGaD0G1SNPD+YMkrTYC0encYOEknVkLeYAK+xkechik33rfwWrVEI4/Ve324k10LYC7ZozOZszwCBZh1uTMdaMiRwG2Uiwz7beW1dT1QkXHSQJam3tA2m+KD3r7QDR5WXAD1pxylA7YgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Iz1f7IhtWmh5IPMMuf4ayNbjVWTp2Q0iQU44PA6DCw6zf6+H+3KLsfrg+Jxo5gwCo2PqALytyi50eDbMcipjzin0SVAcRmaCmkC6w+1MHB1Q60bv64VNdHCgfY3jd9iIpV+IRQNJzc68P5gAHOg3J3ZMly6ztMZqMkHpwjqxUaTKb+T2gwTeb3+hZJCbxrlaIdEcjO/ReJW6Phi4tle1Y0qlxEIVqJh6cO8LGp02y+3MLIwYqdQvIKpvcN0afpM+Te6OJg1i2/vIeWlYUybo1hjN6MEYmL7gfchXGJtgUAzxVBVZt0GEMleIgLhykPj66rmE8rjmFhN72sNXJgrklViOcCsdTbWrPim9MyDLEvinNFczjaYWMz1f+bNpO2IpEqSahWtjvpKAUisIF/VXFAuHaeqbvq697lBjPcYfaMjGsMUTUNy0ejU5ZYOq3Z0/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:06:49.4045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb879e47-4627-4e48-3323-08dee237422d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
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

Clarify both descriptions to remove the ambiguity.

Fixes: 91e581e5c924 ("dmadev: add data plane API")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
v2:
 - Clarify (per Bruce Richardson) that last_idx is the ring_idx of the
   last operation reported by the call, bounded by nb_cpls, which may not
   be the last operation the device has actually completed.

 lib/dmadev/rte_dmadev.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 81dfe187e2..76b0dd6a1b 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -1338,7 +1338,9 @@ rte_dma_submit(int16_t dev_id, uint16_t vchan)
  * @param nb_cpls
  *   The maximum number of completed operations that can be processed.
  * @param[out] last_idx
- *   The last completed operation's ring_idx.
+ *   The ring_idx of the last successfully completed operation reported by
+ *   this call (at most nb_cpls operations are reported, so this may not be
+ *   the last operation the device has actually completed).
  *   If not required, NULL can be passed in.
  * @param[out] has_error
  *   Indicates if there are transfer error.
@@ -1397,7 +1399,10 @@ rte_dma_completed(int16_t dev_id, uint16_t vchan, const uint16_t nb_cpls,
  * @param nb_cpls
  *   Indicates the size of status array.
  * @param[out] last_idx
- *   The last completed operation's ring_idx.
+ *   The ring_idx of the last operation reported by this call, regardless of
+ *   whether it completed successfully or with an error (at most nb_cpls
+ *   operations are reported, so this may not be the last operation the
+ *   device has actually completed).
  *   If not required, NULL can be passed in.
  * @param[out] status
  *   This is a pointer to an array of length 'nb_cpls' that holds the completion
-- 
2.34.1

