Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98190CA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 10:29:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEE34402D1;
	Wed, 17 Sep 2025 12:29:01 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by mails.dpdk.org (Postfix) with ESMTP id 825474025A;
 Wed, 17 Sep 2025 12:28:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeIGFplyG3whhX7uHnBp3X5iDRjIDFbN2iJbcPtkc+FmnZK5LWiYA64aEY22Vsi8ecz7l9lg5VtYTlpThix4om4VUwkJQN0PjNPQVq9olZhQg39kh+UBfU8mQCdZdmG8PE0lEtT3rIuaN3YE1lr6BwuHqZ5VuvO1hVSIYWyvZE+MobWtYkMOUTr7wtwhLtzoe7SK0k0gIiRbkIfnZHmDgks02CWCgAq3UcSgy+k9QWw4uau75JDykTcroHgaiizeLgS4FbnzKKtLlRyJEjfc52u4SXteGDECwOsrX2F49X8PP7uS+V2ZcIQCeA/+4ie+pyfHpEBA8Pfglsbur3cyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JcAnMWAnRWc1KShH5iKKnOUrLH/aR22WwapO45Nnl4=;
 b=ualWjLST+Hya76acBSszhxmFU4NAVTbfGLQrqAcNJI95fmMtBkm065Hp+9nQwAZPRQpEG9bn9Y1ll5CE0n6t3zLvNwXbvCCOA6TjDac69T0K4Ad+uyHDTRh7wfR4qmmbrycY1QVVrDZmyF6lnjHXWD2m567ThZHtOkmncqEWBJAsxHtizNZfjWx7u86EMNSrOK5P7qUzcaM+btrqm1gNKmcoBo49pCfCbW1y2OjhZH12xBul1vm3Wc1o7X3szHsCehnbJ13Kdyshp5uq5K2HLIrGz0/P2avKxn9gTkPQHkEVDmpy26538dycybtZzHkiXpELRpbMR4TS5sCSZULlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JcAnMWAnRWc1KShH5iKKnOUrLH/aR22WwapO45Nnl4=;
 b=bujFSS6g0Cl0kBRdiBAqBi86Ge8R/H3YircNZk+VXTELTUDry1xY9x47/xzEudj58h/vbx5I4AhyPhRyDlJpRorYZUUWB59Q/SzzWxh3pJn5VA9O7h5/q7VDgut5yzIAdxcEDFKIsyy8spWjuIBOIqDV3T8RLpA2V5tnLCkNWdzRPYN/5DwZRkBQ95kQqnNhRnohmR2/q+FPi59soF6fWGjMXH1TXsXt16+uLdZGk5vzMiV2DhfOxz9y+jvcFXfNnGs03AKCJFXLr34HCqsmcZfELVpcWPr+CvIgsLisFp7jBlcq6bwjNdaISeclTaOrdvIA+htN5PCASvuQmc/++w==
Received: from SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 10:27:34 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::95) by SJ0PR03CA0281.outlook.office365.com
 (2603:10b6:a03:39e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 10:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 10:27:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 03:27:22 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 03:27:19 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <getelson@nvidia.com>, <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: [PATCH v1] net/mlx5: fix indirect action memory leak
Date: Wed, 17 Sep 2025 13:26:03 +0300
Message-ID: <20250917102604.451241-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 9250793e-efe2-4f86-09bb-08ddf5d4d0b4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J5oRkNSXa8l+VbK0+PlJl0n/fY6sJAWv6PMrIu2NG2gFPC3lShnIbYQnRb9f?=
 =?us-ascii?Q?nEbbgA8Ybml9ASkCt5VcC7yHWTjgpzDljhwSIR1gZ+CwoCCsxAqCn2x8A3yr?=
 =?us-ascii?Q?0SYf2jrjK/Tnw1v4b4niN3xfWdmSylyFhKaBKUG91I/ueRhmzs1fSPpW1Te9?=
 =?us-ascii?Q?KIWQQQSKZo/tCm7qexmW5H8grhkVtM3nIWCo5A12wdAxd931dpLw9HMo9kOr?=
 =?us-ascii?Q?NwG2F41b9mIEd3ZxQebRkp8hG6Q64+3oMKogLaixXDpYLYEq4osFWZkqkVQN?=
 =?us-ascii?Q?RLscb8wpYpILgsEyCs4k5jFzHMOpzKnoj1ebs50t+ZKWyu4L01EOl5Tw6dOv?=
 =?us-ascii?Q?CAZfBrviKukjKAv7Zh+UuVXT0NYxMG03qlsTvGBY0DoCr5y5+P4XZfBY8lsb?=
 =?us-ascii?Q?rHHKWjZW0ncDfJuBYViQvD534pcUYaYakHOEWSy8Eo24IjzP3Oc8VVn+HfE9?=
 =?us-ascii?Q?RyJjtSUbKohokUnIcGrfibbLVSPbBfNCaoXNrWe9htyC88hRwCg/Qmbs/pQ1?=
 =?us-ascii?Q?XHQIrsYdrZP81+VgTL+g1iZ+BMW4L0jWuISnZuxL1HMlKs+KBrirrcc4QoNk?=
 =?us-ascii?Q?oUP/ObLgyzjLqVQI/lyjZjHZ9qyxMpNFgsZyG6tmrUr/wgGCh0LYBnh2oucX?=
 =?us-ascii?Q?W6wYfvQ6FsivCnzhCsmg5uf8VSR7jIPkonxgAW6MEx+f5IYldXTx2CL3wjlu?=
 =?us-ascii?Q?TeJ5O4ZBsGOtqS5czFSrcxG5GVXVzDEv0dIixHfS+MDxIIoJ6L9gfC0uqcsC?=
 =?us-ascii?Q?zqUbB7ZUlGe4eNU4igctLhX4YdIHymZY5PQu0YhgFSFBEHHJszHjc8HCwAvL?=
 =?us-ascii?Q?QmHSUK0E9YOBfDLrnlIiraVx/Uhnb7WQsZg08EQzmSPs1TSb7BeOcaV9N8o8?=
 =?us-ascii?Q?e18XfTHjpatkko1QeozucbWlnK9NHtzci8YRLfze+T0t4NKBt5plV7a4kv0g?=
 =?us-ascii?Q?TxyfrgjdBluBsYzCTWUSmfXsAXkvBMBlLb/mCpnALnFKMTii6lNo3Ldwp2eZ?=
 =?us-ascii?Q?zKGnJlQaaKyJdywT3F8tRC1yfaqn0o1X0bOLu/wwZeTbL8aTxp+7CZ8NbSmf?=
 =?us-ascii?Q?9+UeUAr/fqN5Z9aN3cWDdUMKcQALkzyRSnAxvuN7ltUAY7qjCud+LV0hCKc/?=
 =?us-ascii?Q?El3hUyLv5uuHB+i/YrVAAtIDUb+jLuGVdBXK3pI8g0h/Wu84fgrsehyb0Dtz?=
 =?us-ascii?Q?yPE+B+6Zz9IcQXSr0zxzdbuntke/oBiWgAfYg+W7otRlNT2Ty0CRbOohatb4?=
 =?us-ascii?Q?2ewBR6CBHq28iACk7K2fecDHd+o/uKN3deSbURN2au3qo4jZIES16OQ5Ijga?=
 =?us-ascii?Q?pG9E3nIhHApTFYGr/ydDnnM9CBQP20beMt/jz7sjrDq/oOe4EaDXFAudHx5v?=
 =?us-ascii?Q?Ylq3cOLSk7huUGV+YRCLdbBlBLLCPzs+mhM55RCc/pD8kJFZPr03vzS0Xq2G?=
 =?us-ascii?Q?bqx3+JjVbcpm4jcSur0mppzWQ+s0YdjLQ3FEv8Ml6L08KeV+IP3Veo7Jtm2R?=
 =?us-ascii?Q?kdhE5BN3NDaFJg5CkZAk7y4zxEMgiin5XmnR?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 10:27:33.9541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9250793e-efe2-4f86-09bb-08ddf5d4d0b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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

There is a handle that is not freed when using
indirect action list to manipulate legacy action.

Fixes: e26f50adb ("net/mlx5: support indirect list meter mark action")
Cc: getelson@nvidia.com
Cc: stable@dpdk.org
Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 2ca40b4146..336924b8d8 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14959,6 +14959,7 @@ flow_hw_async_action_list_handle_destroy
 						    legacy->handle,
 						    user_data, error);
 		mlx5_indirect_list_remove_entry(&legacy->indirect);
+		mlx5_free(legacy);
 		goto end;
 	}
 	if (attr) {
-- 
2.27.0

