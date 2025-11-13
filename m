Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D63CD5BCE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 11:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2C5B40DD2;
	Thu, 13 Nov 2025 12:32:33 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by mails.dpdk.org (Postfix) with ESMTP id 69EEC40DD2;
 Thu, 13 Nov 2025 12:32:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYxfbGeu8Ua4XCWq1rNg3U066E/0mVUywv6/4hlm2XqVR77zpCJ5gWgMHV9YF0nYGy7XIEvdQnfW3VJAEDQCD4dDN9W1JRFrhpRS3Zv6DNS5yIu1reDV1lFLNJOIkg9SzwspISeDGVLc6yMfkyOhKEvG5dj0zCd0dDmL2sodTG5VFmeEzsJTihS3qFzyBnaW4nzz1oqV3cWXRqsl+4glIbvL869HIeubHjhRaD0FRYyrjINRBhIf0aLIFVcqfNlwoAVacRQzoVSkjHSkZ5vJ/8j07+3b8pEbCEvm12SPALRvgSzWQ2bZ6wtxYBBrOz9fCpV33XLtb0O9ksuQ2CQgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzxK4ZtDMeVJRgXYLoABQmzg8mvUeZZtxFoQDHZWlMU=;
 b=dnLcA++8k3ybVCBMNBk26N1JXlkTponNhtbtjykQgI+L8jpLRUCDeE6GDbjVwMyO5lFF6U1DVSVkAF8h74Ey6uqm/p8jWawhyLH9jp8O/EI2CbCTGoen875DrAmPca6r99zN/wUqYJWSoccon8pQwCA0osuP3U1oiBXGPVIjGejPWqPDTx+kObKDFWN8ulsBZw4e0a/46Cz1hu5C53mvsUYvnjRagNCdyYijXD3j3mgAIx/1fS/6d9RrG87K4AowDpjeEwYlmDuqDvxSUpZwXZP/LVuvvD8wqodyw1jCLjJpvd1/vMewY0RDb0s6Cc1w4xBZeCAuOJew0v64R1/Evw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzxK4ZtDMeVJRgXYLoABQmzg8mvUeZZtxFoQDHZWlMU=;
 b=gNDjRH3UqH0dvp4JEoBnjwc0IX0Ji2OJsm+DSJtPcF4nsNu2ijtuYcLwPryvz8IleDWfPcMAlBVnA8soNyBmmkTGmiqrIJW7rlrvLMPE0+zkx0P61d1OeJo7EUK7+wqRTaY5AWVI+ZysfTcBW1y+Ikrt3wT2LKjB6jxOcwrizDU=
Received: from CH0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:610:b1::32)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:32:27 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::84) by CH0PR13CA0027.outlook.office365.com
 (2603:10b6:610:b1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Thu,
 13 Nov 2025 11:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 11:32:27 +0000
Received: from BLR-L-VENKANDE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 03:32:25 -0800
From: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Venkat Kumar Ande
 <VenkatKumar.Ande@example.com>, <stable@dpdk.org>
Subject: [PATCH v1] net/axgbe: fix the build warninig for GCC-16
Date: Thu, 13 Nov 2025 17:00:55 +0530
Message-ID: <20251113113055.371-1-VenkatKumar.Ande@amd.com>
X-Mailer: git-send-email 2.40.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 501b156d-df4d-4fb2-58f6-08de22a852e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjU4SHp3QW9zTVFWam5sMElWYnFWRFRJa3p0MFBwUGRnYWl5OG94ckpkbWRy?=
 =?utf-8?B?WGhFVEQveERlYVQyU2pMNVNBMGEwZEJZNHoyVkRCeGxUdWZ0NFFlSzJTZG5I?=
 =?utf-8?B?Yy9WYkxvM3lIcEdJcDRQSHkraDRRclhqZ05qTlJvUS9iMGo1Q21NOWpDYXdh?=
 =?utf-8?B?Y2tqdEpyVjA5dUkrbjVMd3YyUVhnQWxONDA1MmRINUl2cWdZd2FBYXB0VUhN?=
 =?utf-8?B?SmR0RTZzenlrdGtzR3JTRUlGdkMwRC9BS0xiZXQ1bk1lM2d1cEVSRURVU0ts?=
 =?utf-8?B?eVdWMjdGcExhVDFSNm82V2NRcHpPSG8xdWllUFR1eTJDb1NvVExBZjJEVUF5?=
 =?utf-8?B?NXQ5WjhWMnBJcnhVaUwrMXRybDhoVHo2L243MEtRNWwyWkV5cktvVlpqdlp6?=
 =?utf-8?B?UTl2c3BIeSt1UFMzM2JMUzkzL1ZNalNvdlBJVzY3RXlibjhwQ3hnUGMzRGZ0?=
 =?utf-8?B?K0taNmtha1dRTmowSXp6UDMzSWg2RmpUcU9FcExnZmdJOWlONVJNK3Z6c1hJ?=
 =?utf-8?B?NUNhMjVOQldhY1FwOGJhTk54R011MFF1V0ZUU3JuUFRlTTlBRDdrVmg0T2Rt?=
 =?utf-8?B?Q2RIb0xzNm1TeUFrUFNXV1JTRWl1MTZYMXJ3RnRHT09IcFA1akFuQklYZmJm?=
 =?utf-8?B?SHkwaFRPU0xwQm9IWkVrT0UzZlRJaC9hRFBSMXFLaEExMUdEckZ3bW1qQUEz?=
 =?utf-8?B?cWxOamRDMHlhVFAxTGxKVFQ0ME9SM2NDbFFYSHpPOWZibm9NSkxibHN3Wksy?=
 =?utf-8?B?YWdnV2dLMHhRYjdYQ2JSTnRkVERMZ2lETjRha1Z5MWIxMmpaejZsWVlYcW1w?=
 =?utf-8?B?Undwd1MrTzRwYnZpdTdMeVhkTkFMM1JvNGRLclljam9TY2xRclpoekNpOVVN?=
 =?utf-8?B?U3lRendhTmpLdjU1aUtTNjlndEppZDdHL21OQTVOS2JHOG9iNUIySE5GWXJS?=
 =?utf-8?B?SmVBRVJDM05pSGRwWjdlZEhTYXlISHFjTkczMW5pNGh6bGNraGkwdVdDKzFH?=
 =?utf-8?B?U0N6cUlxeXNxc1ZLbjV5cEZtWnQ5MkdqM0VBNS9aUjBxdkN4ck1COWhMekRG?=
 =?utf-8?B?OEJ3QWRJdGJTek4xQ1R2dlFjMXpEREh3cnUveENQT0pLQmFZOHpxbWJ1bGlX?=
 =?utf-8?B?UzdsZWQ4STFPVzNkcWNZaDU1VW5lZ1ZTamVhaktRUW5VcjNZRS9Wcm11QlhT?=
 =?utf-8?B?eVRDS2dqM040K2tjQ3d4aVNkby9nWDlFOExlV0dlQWlTKzE4RVByNEFaMk4w?=
 =?utf-8?B?eE1FQ245Q09ad1U5UXZoaFdnYXE4cCs2aGVjQ2Jlcjg3MHdjbDZqc2ZCVHRu?=
 =?utf-8?B?UlowR01CNWNyVk16aXJ3TmhNYWpwZFFLYjRnYkFuQjBpT2xJZWZtS3F5V0RV?=
 =?utf-8?B?MGw2RWd2aWQwWHZvZllmcFRscjRjWVVqRHhmcHpORU1SalFVTVJKdkNrREFU?=
 =?utf-8?B?am1hRTJwdUFMRGwxQmJqVFdXb2xkSU40Y0krSHhkK2gvOWtqSDJVdjJkWVhs?=
 =?utf-8?B?K05RSzd4TytVT3R5TFVSM0UvTXh1Y0Vhc3VUblZJb0ZLa2MyQ29EeFdwWW9N?=
 =?utf-8?B?OVQyZUs5NHQ0ZnhQVGkxTlI4UDdmbTh5S1RpYndJZE9ZRk1PaUIrYzh2eTB0?=
 =?utf-8?B?QlcrZHV5WGl6bHlrV2RTem5rajNsYVZkVlJwaGtWYXRxdnNyMHZra0pTazdO?=
 =?utf-8?B?M0ZaaTdDVjg0MTZWd2JhekJ6aFRTM2ZhMk4veThGTlZNaUJiS3FmN0UvQ3Fs?=
 =?utf-8?B?UEtRS1V0L0RvMHlhZm9tZDdIcGY4TGFTSXZVUmZtNDBZK3I3Q0VvK3dJRjR6?=
 =?utf-8?B?SW1zRTh6UllXMXFHR2pDT0FJTEpEMnFSN0RSdGJlTUQ3MGNKMlZkQ0hvNzdr?=
 =?utf-8?B?RFEyWThLWXhsRHFpcDg4VElZZFA1SndZMkVsWE9qMStJNzJza3FFOVE4U2pj?=
 =?utf-8?B?cFZhVUZvN2w3bmx2MDZ2ditwcVBKNnl6UFlaMGVxcm52K0FOTGp0R2Ztbzl0?=
 =?utf-8?B?RlQ1T3ExYldPbTlDRld3cDZCL2QvUFZGVk5LTEwvOVVUME5JU1dXQ1VjOVdj?=
 =?utf-8?B?R2hYTEVXZDVIK1hma3BPamY5SnhsaW1OTTdIWHVucmp1alRyZnhRUjNvQ0tj?=
 =?utf-8?Q?2hLE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:32:27.3118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501b156d-df4d-4fb2-58f6-08de22a852e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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

From: Venkat Kumar Ande <VenkatKumar.Ande@example.com>

Build warning reported for local variable set and not used on GCC-16.
Fix the issue by using the variable for missed register write operation.

../drivers/net/axgbe/axgbe_ethdev.c: In function ‘axgbe_timesync_disable’:
../drivers/net/axgbe/axgbe_ethdev.c:1744:22: warning:
variable ‘mac_tscr’ set but not used [-Wunused-but-set-variable=]
 1744 |         unsigned int mac_tscr = 0;
      |                      ^~~~~~~~

Bugzilla ID: 1819
Fixes: e04449488fdb ("net/axgbe: support IEEE 1588 PTP")
Cc: stable@dpdk.org

Signed-off-by: Venkat Kumar Ande <VenkatKumar.Ande@example.com>
---
 drivers/net/axgbe/axgbe_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 31d35ff182..cf3b0d9ef5 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -1742,6 +1742,7 @@ axgbe_timesync_disable(struct rte_eth_dev *dev)
 {
 	struct axgbe_port *pdata = dev->data->dev_private;
 	unsigned int mac_tscr = 0;
+	unsigned int value = 0;
 
 	/*disable timestamp for all pkts*/
 	AXGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENALL, 0);
@@ -1751,6 +1752,11 @@ axgbe_timesync_disable(struct rte_eth_dev *dev)
 	AXGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCFUPDT, 0);
 	/*disable time stamp*/
 	AXGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 0);
+
+	value = AXGMAC_IOREAD(pdata, MAC_TSCR);
+	value |= mac_tscr;
+	AXGMAC_IOWRITE(pdata, MAC_TSCR, value);
+
 	return 0;
 }
 
-- 
2.40.1.windows.1

