Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9087CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 17:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E852440A77;
	Wed,  5 Nov 2025 18:50:19 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8021A4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 18:50:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXDYFGLbV+nkhU8wMI8wU5W7IEQZs+uvsmAgb8Muy+Tc//zWt91SQQ5Lnhe8uWrvPc4QOySiIPThHLh4+1H/aWlzSy8LoSwiJfsHjuSpLxi40CP/YIuSfjiE+ki9PTNhh1Od6qKOMcklqPBDGC8atpkEMvsx/HlqxTmW9GQNVCEmbGI2itjTe86vZF/wtY3MSou/5510pO2vUktq1HIv6dGE0B8HHgpSL1TYPoZRg8WTe9dXRGEe3wWp/K8n/Q0YRppEoBqqDrAJ5bTrQLgRXAn1oXyPiqNfS+oFFcvsfkxEbISPS/wuI7tuIepRQEWQjSOJ+OcNHh9f0X5+EcYfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qntxBU1t9iTKCTq48gNKiO9bSKhQiq8gK+C4aNBsFUY=;
 b=yuicGxxTQz+zvggKCbMv1hExkUvf3SE3T9J/3k5EgrvhzgcQypP6TbF96QA30WZ0IgJMnMrTVTqDAr8EKMWHVX8dLcnItZfyKGBUXSkwPMn/q0mPJ9g8Ge1MZMG2JjA+J3Ww9zaRfUtWqfTiUPHzydMQ+ZIDdYux7AVGUuhOsNMAw0MLNXODfhHQ+NNNKKVTyrJtSpOYO+uNRFrXpT1LTR7WuB8/bwV0n39WFm4geERJPVPKJq1pu44cgkjs8V5eNgByJc3QBCy2EJKVGX2GzP/2h72fXPCEJD4KStwuc/dNcaQ+dsyTRVbwjDJQyN4lOpYms/UjSa68Q7GnFbea2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qntxBU1t9iTKCTq48gNKiO9bSKhQiq8gK+C4aNBsFUY=;
 b=JqBDZnNnfWtBnjRhG1HmghIE5DiahoXFXEOoVT4zvCM0qB6X0FWFweMIkyLyjTpGSY6kPgG0F8n6rDhmjV2P1bQ2/T1Jv8/JdBxIlRMCS6NMn/Uso+WcyRbJrVUTvAiQc1jus1bESt6YA2GbbPc8gths0NEKman3cth7dx9GkSOKteTxgTDgIIeRJ70l4/5l1vvRcDoKdupH3YWXoGcHz+rT0hkuh6eCxg2fpBqqYU/wxtYSKQZhoe/TWM3/H4Cz2REeS2mqPRoDLTJwT2Ei6UpLB1SEHoeujTwazis7H+tdGk3m+jFDRsHq3lOfUj4q6qslnkdkptMlLbIZcazNBw==
Received: from MN2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:208:23e::35)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Wed, 5 Nov 2025 17:50:15 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::89) by MN2PR14CA0030.outlook.office365.com
 (2603:10b6:208:23e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 17:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 17:50:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:49:59 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 09:49:55 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v3 2/2] net/mlx5: support PF representor suppression in
 multi-port E-Switch
Date: Wed, 5 Nov 2025 19:48:38 +0200
Message-ID: <20251105174839.323085-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105174839.323085-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251105174839.323085-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 462c58a1-519b-4453-e2fc-08de1c93c6d9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SdTD4X/LlaEH1/OfRTtYInhfqYSDqsG2Y931LFli18GLu4coBNi1SWbbJU+3?=
 =?us-ascii?Q?gKLRf5/iUzbgvLSuQo98+RA+2gBXBIR7AmjCZ3RBX8vB+3vSfr2h1vB7GUKU?=
 =?us-ascii?Q?wViIhYeE2zxQByWSPO3W2IeU8EEI02IZduEatQehI+4iiade6zUSPrZTGVMz?=
 =?us-ascii?Q?tailxpKORCZ+CWbmY1LzY/hGJguFN34M8WzwqSUF92wg2e6eJ7SVObPK6Rse?=
 =?us-ascii?Q?JnZQG4RdVcP62Mg+VI4OdhPhVkaVyzmhMEuc/xfQhBYYMDTcgBgxANI4ajGY?=
 =?us-ascii?Q?2jmgz4Ku57YZh+iWOsoSwbjotRpuSElsBmHJOir4ffl8ez2i/cX/1EJ4Q4kT?=
 =?us-ascii?Q?sY9rOyErvMsjXzwnzQHXP2+Jni628Z1hluPaXGFqR5V8vlSkkX6kM3kaNzvw?=
 =?us-ascii?Q?9qx7f2VFTod6vHZ19B7n+GT+6aYCrCUDgouTfNU5DZ8zP6K+saNh/uM0mm5Y?=
 =?us-ascii?Q?FvM46o6sB8C4G6CW/m5QzXC25EHb5KI+HtKjzypHPs7oL52lnUk2654ubcaJ?=
 =?us-ascii?Q?iCwefEwD6p3F4tAzH/Xw2idDtw7uh4ug68kMpX8Awne96uir3myk8QyzqW6u?=
 =?us-ascii?Q?M45z9lX5BaksHJgkRyelT5Zhf1xMjybAaoN3QVFeeCzVKhMW9+EgnGkOwk+4?=
 =?us-ascii?Q?tNAmS3e2Anah876qObMxZHvf8NBrIlWEgA5MImLWdR6g+g8aYVvw+aAJZcsg?=
 =?us-ascii?Q?yRNADbCWELTlTy0jQ1ZSxvNxSG/LsKkv1XNwOV9NIAeD0aIDJYIu/O35kVSv?=
 =?us-ascii?Q?8khL56Fx4cfd/dqLYIfkdrSTWZFlqXnp6kqguZtm6pJAqh+esp/WmXeXSt+4?=
 =?us-ascii?Q?PBHVM+dzFte1cRtrfZNCJJj5cvz7/4Xey6lrRXLfiq2IBHnGU5vK7NpGioMe?=
 =?us-ascii?Q?fUOJBahj6Je3VkojoWty20CjhLt/BcS5so8w2xpA18jx0HJLW6mTwKSwzQkj?=
 =?us-ascii?Q?RsLJ40EuHiBYg7CYB+0dp2snZQgzGRuHwFJE489JHYNuw7j/lG7Pt3wPHT1F?=
 =?us-ascii?Q?tAhUevjAtPLqSlWUSPHUoEaJnyUTicYjMkAlfcUbTUE8CxMD38KoCZCOVpBv?=
 =?us-ascii?Q?+U4PmFCvA4AanNtODPFVLeKmheo6/X85DCLrZif27r+OoTwSReJPw52+bQj0?=
 =?us-ascii?Q?AO+x/aA9LKixLFjDenzQOtXlFjnaxcsG5XwBZHXfXy2rLI2Q28V5V+T7TO+2?=
 =?us-ascii?Q?M3INrBkUWjpyxJg18/MfxAvDJ8F+ugwHewZy5V9NY37HkHmNv9uDBZvGy6Xi?=
 =?us-ascii?Q?7kCk2kwAKzct3MiicVHgJLLDbCxpf83Ch/obf1y7+9XbdBvwM14oty/Yl+IR?=
 =?us-ascii?Q?ztt/aAQUKP2NsoHXOalYjoL/esI1F/jQt2q/Pp632MnlvKJxSEXIxHqa9m2f?=
 =?us-ascii?Q?SHQ+rDv389WlTln0dkyh9YHcj4qocNNfd4Cf+ppzJpuof3B+h+yWRhOxNUXo?=
 =?us-ascii?Q?cjV65U3DKWIMYaKL9ophDm0DOhQSDsq8R/AKMramoPQ8s9Yi6l5WZGwfA/fQ?=
 =?us-ascii?Q?oA37wv/7e86qB0S7Q1bWDaZddoYvAZGpbhdKMhEWf+Pxs14dfWvZ2AYazOPy?=
 =?us-ascii?Q?UxqYUOgwrQGShaic9lk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:50:15.3385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462c58a1-519b-4453-e2fc-08de1c93c6d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

In multi-port E-Switch setup, the MLX5 PMD always added
PF representor port.
For example, `representor=pf1vf[0,1]` implicitly added PF1 representor
port:

```
Port     Name
0        p0
1        p1
2        representor_c0pf1vf0
3        representor_c0pf1vf1
```

The patch adds support for the new representor format that suppresses
PF representor attachment:

Example: `representor=(pf1)vf[0,1]`

```
Port     Name
0        p0
1        representor_c0pf1vf0
2        representor_c0pf1vf1
```

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
v2: Use updated rte_eth_devargs::flags.
v3: Fix typo in comment.
---
 drivers/net/mlx5/linux/mlx5_os.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index c742e0f282..fe80773d49 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -2284,6 +2284,12 @@ mlx5_device_mpesw_pci_match(struct ibv_device *ibv,
 	return -1;
 }
 
+static inline bool
+mlx5_ignore_pf_representor(const struct rte_eth_devargs *eth_da)
+{
+	return (eth_da->flags & RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR) != 0;
+}
+
 /**
  * Register a PCI device within bonding.
  *
@@ -2592,6 +2598,8 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 					if (list[ns].info.port_name == mpesw) {
 						list[ns].info.master = 1;
 						list[ns].info.representor = 0;
+					} else if (mlx5_ignore_pf_representor(&eth_da)) {
+						continue;
 					} else {
 						list[ns].info.master = 0;
 						list[ns].info.representor = 1;
-- 
2.51.0

