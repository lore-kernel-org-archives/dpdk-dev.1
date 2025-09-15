Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7866CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 14:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 086704066D;
	Mon, 15 Sep 2025 16:43:45 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by mails.dpdk.org (Postfix) with ESMTP id 1CE1E40697
 for <dev@dpdk.org>; Mon, 15 Sep 2025 16:43:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXsxsYNnAP4+EoUt51FRdp+Ie6BN8W7yYvoDMfhJTmjrDlzKH9t12ZKC8t5FQ6GOlKz1Hl6pOTUvophytEk5QfIz0gdyUelEo5q05LkhhfdX/0xGadwJ9KfZHtcEJbtslLl/ho5kONhEdfpSXg32IlRq4Dz3TJbUWxisSFhaB3zCVl/Uw2IEb072kp8QQnYosD6OV79Ufwlzw9XTd2ogNszwNBhHBl1r6AIMnH6BGogH5ANZsw/Y+164+Y8vAGgghuiGRl5NYVnxOBgiTfQoQgu8LSVDVwlgcS8ptH8oxxCCVLROf6YAH9CK9AHpbxkjNc7sf8stQd6ce4mlErRgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT1Te81eVS9APuM4HICfl2SOGNrNneMIGQ06+RY1hNk=;
 b=e6cQH5B7I7MORrGpYtA8DRdmdzWn+Z6IdQbWFmbYdUy3qVrUg0Sop8jPqdCG41gSZs2AzUFzkHYfFAd7ISbrVzAU/Js2laxZsFzzs9qPuxhcZBYIdbsVBKWQMdzxkfOQbyuLGA5TI3HX7tLtDSGlZRtBGZki8fEEaPC5YQejIo3AqOQ61knF8uIIgF87ZP+CSKG9c62D2tZTJaAtZKJ9feW+wl0T7UEcRc/iyqaFk3od2lJMT8xAEGjgqhzfe0Y8ggy2ZtlvyeKMcb3L6F2nrJpgD02citLF4gkQroMMuV7Wtf5cYqLWvSwuM76vkJ2ytrBV9yGZagtAjSurtKYKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT1Te81eVS9APuM4HICfl2SOGNrNneMIGQ06+RY1hNk=;
 b=VFe0/SNDKW5/g/ycFtCPG8QfCzHxt9OMdRG6RtkGsU57nupx8DJlvl87qmggx1twtz16M220dXzxWH4kr6sS14PRWeSA5uPTTA0zrqbxmzieSQnuzZI7N2wqF70aJgy3PHGKECS/gixy8Lb589INmCvOWMZ/v9GWHOwi2g5mmEK065qLz+mBqVnKItvSPRHVlznP4IvtRU9sN+3hwCgPK9dTwpm6MB+XgsZp+Y7F0skJHrBrhimV2tm1wONxGCyJsc/pzQnGVNaTWIA8t2gR7sKZSS8DKBtFI5SHCfwODY7lbpTx+7pqc4e8zqgXZ/WfqPBw89jB2HW6pN/ZkNozyw==
Received: from SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::21)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 14:43:37 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::2e) by SA9P223CA0016.outlook.office365.com
 (2603:10b6:806:26::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 14:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:43:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:16 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 07:43:14 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Elena Agostini <eagostini@nvidia.com>
Subject: [PATCH 9/9] gpu/cuda: support CUDA 13 building
Date: Mon, 15 Sep 2025 17:41:36 +0300
Message-ID: <20250915144137.54858-9-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915144137.54858-1-getelson@nvidia.com>
References: <20250915144137.54858-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f5f678-5f80-4644-8009-08ddf46640e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7XLjnRiSrXXoGUhuWboVYGdrYqh6S9l4yp2tI6qhAzdO42pjXzEayyXKNjBf?=
 =?us-ascii?Q?OvAy09yf+1FISTsxrpIpc4ra32s8RYEJKkdAPsWnNwwBtg6DYnLsf9XEYiuv?=
 =?us-ascii?Q?04Kxq/iEfN7xIwkS1FDa344FRhlcCHAEJJqMOnUJqBkOt0t757u17nSpz8ja?=
 =?us-ascii?Q?AGDyS/SnDr5IbfYlfZVowYSWoAkvyMG+ZuERQvyrLJED+S7WvHLCQ18o9//B?=
 =?us-ascii?Q?8RXcRLe0tMeBucJgM07lx2Pf9akkqDMIJN7Wgj9GTBEUUmHtvOBaiijrjQnH?=
 =?us-ascii?Q?oMspcqKQuEcO4RCE4XOD7ZRACqy0ZOk16rBS0fCVlZEL/9dPZra3Pbe3I9VE?=
 =?us-ascii?Q?6s8F/Y7nnMr/6jK26XoMBA7I0Ix/r3kcD5FcmpGScImBBIV9xgNG2apooOlD?=
 =?us-ascii?Q?i4Sy9cmJIs2LJmxRZ/MFVcFK/tp+R8OagcPU1PY02rDW/PXQk983PQhd4vli?=
 =?us-ascii?Q?4BQWKC8b4rByQTdTdFLgkBuTKEBy1QKQFXEhkboTucxzIj2UCpqZqTSNuuF3?=
 =?us-ascii?Q?FFz90mpU1svFmTOI0voJUf1lGZEVA9EICch3cbzGhlcfRa66SIXZrtMtQJPa?=
 =?us-ascii?Q?iof4CFxG+MQgAgOID89i2eAZsAsOdk/zVYRVG70sdv502KT/ITcIYWX1vsQQ?=
 =?us-ascii?Q?OTZKynn81ujk7V+T8L4kitMFWUd/mVkclA+FrfCaeckBqPvJ2Vj9cB5eAx5H?=
 =?us-ascii?Q?WjjxIoYz2b2ov3v8huedevPulKgxT5eMtJqTyFTAfzTIb6sYH0pq/DQjGWLQ?=
 =?us-ascii?Q?HJKKaSpdkHh5OfS5U2V1AyYbghIXgkF/eXey5WLlpMwQ1QqHc0XNlE5+ySWp?=
 =?us-ascii?Q?zpxF7Y+3LOLzbvd30QvIT7iTD4oRUovWGyKpBo4ltRWAP/bKLjxV2ZwneLa2?=
 =?us-ascii?Q?JS782z8K8XYKnhQfPNB15Z+Jv9Acc/EiIVOxFfXdpDspQ3s8DMqmj/bgAn5K?=
 =?us-ascii?Q?IAQSy2BZrxquMNzMNNTt6po5HtouLYZZj9KbbYS9NnNZEwWYfS69dh00pGHy?=
 =?us-ascii?Q?ZBZmc0otK7oyizRDrNfI7Im/ENGciIZjcAMDIb9dTFHfEiMQTyXOjBBq34hC?=
 =?us-ascii?Q?50HdwjgBP5Sob3ppUEoCOkDpZsgK20skv4CA5EeC6quwonzTeXRS3UcYqTiB?=
 =?us-ascii?Q?1L4Brss+YtndZwXbPcY6u1P8HvrxJuhn0Y+tKdy7HDpHT/DYnaFIueYPUnUP?=
 =?us-ascii?Q?mIYIfNoPyq8PzithIgI4dYr4ue5F47AoFWzYfQCa8ry1zXFU/G+jk593S/ZL?=
 =?us-ascii?Q?xxrME+Ah4EeGFk6+B2nrrYMK0yps78sG+IGOmE5mPnawKN2nLAKxac0xxFJx?=
 =?us-ascii?Q?YZLFwi5i01Vz+w0IZgmHOGG3XolgIKBSVdTbnnz7mOroVy7rnLFiGGot6kRe?=
 =?us-ascii?Q?A1I70El14f/PnQBDt0RUCa5Cph5sU44OALJd52JgTLekfUuLzNdHYqzsgtKW?=
 =?us-ascii?Q?aPupuCo+wjUKzLHY2ySdvmzFawXanIuP3F+NDCOi9ZPzLtTWwsbd8j43E5ZH?=
 =?us-ascii?Q?zE+CSyCy4YGKzGgDssrmIshT/QpCh3etdW67?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:43:36.6764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f5f678-5f80-4644-8009-08ddf46640e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666
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

From: Bing Zhao <bingz@nvidia.com>

The API name and prototype have been changed in the new CUDA, this
commit will ensure the compatibility with different versions.

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/gpu/cuda/cuda.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index e050b6370b..3f3391cf30 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -28,6 +28,28 @@ static CUresult CUDAAPI (*sym_cuGetProcAddress)(const char *symbol,
 		void **pfn, int cudaVersion, uint64_t flags);
 
 /* CUDA Driver functions loaded with cuGetProcAddress for versioning */
+#if defined(CUDA_VERSION) && (CUDA_VERSION >= 13000)
+static PFN_cuGetErrorString_v6000 pfn_cuGetErrorString;
+static PFN_cuGetErrorName_v6000 pfn_cuGetErrorName;
+static PFN_cuPointerSetAttribute_v6000 pfn_cuPointerSetAttribute;
+static PFN_cuDeviceGetAttribute_v2000 pfn_cuDeviceGetAttribute;
+static PFN_cuDeviceGetByPCIBusId_v4010 pfn_cuDeviceGetByPCIBusId;
+static PFN_cuDevicePrimaryCtxRetain_v7000 pfn_cuDevicePrimaryCtxRetain;
+static PFN_cuDevicePrimaryCtxRelease_v11000 pfn_cuDevicePrimaryCtxRelease;
+static PFN_cuDeviceTotalMem_v3020 pfn_cuDeviceTotalMem;
+static PFN_cuDeviceGetName_v2000 pfn_cuDeviceGetName;
+static PFN_cuCtxGetApiVersion_v3020 pfn_cuCtxGetApiVersion;
+static PFN_cuCtxSetCurrent_v4000 pfn_cuCtxSetCurrent;
+static PFN_cuCtxGetCurrent_v4000 pfn_cuCtxGetCurrent;
+static PFN_cuCtxGetDevice_v2000 pfn_cuCtxGetDevice;
+static PFN_cuCtxGetExecAffinity_v11040 pfn_cuCtxGetExecAffinity;
+static PFN_cuMemAlloc_v3020 pfn_cuMemAlloc;
+static PFN_cuMemFree_v3020 pfn_cuMemFree;
+static PFN_cuMemHostRegister_v6050 pfn_cuMemHostRegister;
+static PFN_cuMemHostUnregister_v4000 pfn_cuMemHostUnregister;
+static PFN_cuMemHostGetDevicePointer_v3020 pfn_cuMemHostGetDevicePointer;
+static PFN_cuFlushGPUDirectRDMAWrites_v11030 pfn_cuFlushGPUDirectRDMAWrites;
+#else
 static PFN_cuGetErrorString pfn_cuGetErrorString;
 static PFN_cuGetErrorName pfn_cuGetErrorName;
 static PFN_cuPointerSetAttribute pfn_cuPointerSetAttribute;
@@ -48,6 +70,7 @@ static PFN_cuMemHostRegister pfn_cuMemHostRegister;
 static PFN_cuMemHostUnregister pfn_cuMemHostUnregister;
 static PFN_cuMemHostGetDevicePointer pfn_cuMemHostGetDevicePointer;
 static PFN_cuFlushGPUDirectRDMAWrites pfn_cuFlushGPUDirectRDMAWrites;
+#endif
 
 static void *cudalib;
 static unsigned int cuda_api_version;
-- 
2.48.1

