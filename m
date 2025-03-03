Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C9C282D1
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 13:35:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58A52402AC;
	Mon,  3 Mar 2025 14:35:21 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by mails.dpdk.org (Postfix) with ESMTP id 99404400D7;
 Mon,  3 Mar 2025 14:35:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZH03ZoBbzMYP5FjyGrxqh8lL9QgWC/VuXZyB8JhbXTgZlSeu1NyShDLmWH+545ag62K/SJf2CY9bg/9FLAGk5HinHRQyhkQY5YJjxXlEkZiIIGQakmbEetRfjRKxBsQWbxV7cSLVIwoqxlJTVSw5x0JrktXIaYOH0hLOpiOiQDuDBg44adgB46+fmxp6MvOiGdWEBILDzYwOT+3jhldJHbRp8GJX0mG3lOt9BxT6fguBHD1LoRwVrSAkcGD+dT+N5vkAqbRR819jNmeR2U16pa2Z1rygJZFkl2di8rBZd1unHSywA8d14mXsB2sLikNpx/IPIcDKPc6qJGgH1cXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBOJgsPwxoiZMtMFsycLo/5B/aFS5+AMepQVduNwEJY=;
 b=wqy4a1Wf47CKgYGWz8iROGUVVfhLy7QY+0p4bmoRVeSUg09fr1zXRRr92zm3xC3JZ44PHwB/9BOel5St1atidwZegUKGYo4MtA6LEPxVg8xMtKMb9O52q/1eby9GMvIv4bguJ+tJrLcWFNfdxU4XK81xiNw2ZCRetrnorIJ41xAaia5oeDtdprPp9flpYthW9EFprd7sLuFdETpll2I0QhFpyBzoa4I+FHxNL/IMQrEVMHVQcan+mGef+RStYLxMmkkjmLt49PHZcW+0wSHXEqlxMTFtyvDYAdBjer2hD74EyddJTF2W8+quSxpphJ4u7tPDTSOLL4rQ+0/lHfRDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBOJgsPwxoiZMtMFsycLo/5B/aFS5+AMepQVduNwEJY=;
 b=tkQdBBV29slc/BbH9HkADWSkk9Tq0IpzyNsmJXVzTXi31cJP3Ah73Atcudw7yj556uUIuzgQHO1K/d65lFMZR0urZubnTpsLdXNyKcZo9oufD57jp2Zn3rGDkhg1G/jOMh6rVgFTxy+rQ3387f7LQd125GSX8odQUHM3DzXxC4EL3+YEuFdR1G5sBsRgipVvz5qWSVkOjlAAK6/AowbRxjiU/1DgHi61QiqChn3XuOjROKo+uQhVT3zgTzYRYJVsF7402et62ldfJsEyVMC51frPy+Qz8QTxX/Dey6HqCAvWRGPUtV5urpSy7GAGAr5x6P4zhjrrg5duDY5GO66xig==
Received: from PH1PEPF000132FC.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2d)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 13:35:14 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH1PEPF000132FC.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Mon,
 3 Mar 2025 13:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 13:35:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 05:35:02 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 05:35:02 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 05:34:59 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 1/2] net/mlx5: fix non template flow validation on validate
Date: Mon, 3 Mar 2025 15:34:48 +0200
Message-ID: <20250303133450.71626-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: c9058703-5063-4b94-121a-08dd5a583a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGlHeHFJdmREV3I4TTREcTNraTdFVnF6RmZaRU1hWEY0Ty9qWURBMmNUaHZq?=
 =?utf-8?B?amVweE5hWXNZN01KbGROZHhwOTVCd3J5TUVCYUdvMUg0WUpjOW5kUktoZWVJ?=
 =?utf-8?B?T3IxbHRiM05vUnFFNkdMWmgvNzYweGZwekplT2Z0dEdLU1JCeVg4bmF2dG5z?=
 =?utf-8?B?djNhaXVtNmpxY1FiRGl3c3VSSlcwekhibmRCSElLbHJlOFEzREptOWs4aHFs?=
 =?utf-8?B?QVdvSlVoTnVyYUpZVWQwOEN1bWZkaG9pRk5xK3pBdTRuL2JKeU90dE9wQTVX?=
 =?utf-8?B?d0lUUWJrOTJ6eGJRZWZSMkJzUSt6R1hZTUNPdWY5TmxZSG1jWDJPa25xKzlw?=
 =?utf-8?B?L3o2d2FZL3Y4RjF0cEpYRFlFcEh3aVFGeCt3RjF5dDJwOWYxTWRUY3VrU2VM?=
 =?utf-8?B?QmwxQTNiUlZ2MUdrYmRDMXcvTTkzUmQvZW5mSm5tcWIwU0RvbWhIN0tmRGFr?=
 =?utf-8?B?Nm1QaHIram5UTFVkTDdXN0x3ZXJzY2MxUlJpcjNUdDZGSm10eXR1TWVvbk9X?=
 =?utf-8?B?b3JEaEs1OVJFQjloclI0ZXhvSTNHZzdvZFdpZDdQOEtpTG1XS2psVGFCc2JU?=
 =?utf-8?B?T1lDOTZLbjZMN2VDSzk5V1V4cGswc2ZjalBzZlREQU0vMUE4TTVNQ0pZV3dH?=
 =?utf-8?B?ZTdBOWczUHRKVkFveS9PazJydWg5dE4ra3MwQy9PblJTZUhOMXdYZU9HWUhM?=
 =?utf-8?B?V2JDeGxRZDlMekY0Z2pSZDNHSmNHeTJkR1dNS2RzTTFBN3c5TDY0Z25Nekln?=
 =?utf-8?B?UWJSN0loaHpwWUV2U25zQkxhYkVIU2Q4UVBjbm11dWRoZk9PSUV0MEJ1TkdM?=
 =?utf-8?B?cWNRc3g3MjFRN1pNVGc3N2ZuVTh5SktJL2lFWlhkOS9yamN1STd5RlBTVU13?=
 =?utf-8?B?UWQ3RWFjeFBDT1A4d21jMys0T1pMV1FSZEkvV2gwRnlWWHMxZFQyeXRBZnFr?=
 =?utf-8?B?YUVFVVY1b3dNQ2hZL1pqemh5eXdveG9UcG1mTnRvRE9SdlpLc21aRlBDemtK?=
 =?utf-8?B?aEM5VkJjNEpOejgzQUg5cmNCQncwNFowVk1wOFNrYTVwQThHaG9ob0o2Ly9M?=
 =?utf-8?B?L1pmYVRwb2p2TWFCYWRKbUxJamVYbU5JYXJiTmJYODdGS1ZFR3ZRaW4rUldm?=
 =?utf-8?B?TDdvUXhvYkFXZG1KbXprUDB6U2NHUjlkQVdBUmRJMjVxOWJSdHFVcStEN2NI?=
 =?utf-8?B?QWl6S1dGekZVTjFycTVlZkYxQUVROGRtMUtCVGNXUFhzMklJK3I2VWlRUE5E?=
 =?utf-8?B?V211bmtpcUY3MWpKTE1JK0RKcUIyZjA1b3VmTHVvK1oyYmxOU0FZTVJIUGNB?=
 =?utf-8?B?RzZ2WlJhL09ydjZPalF2b1AzTmIvdFR6Q0Qwc2JLMW5kYlZJMmJidVR6THZo?=
 =?utf-8?B?TmoxK3hlVlcvQU1MWlYwSTVjYUo0NU9nK1NOTUFxSFBZNy80cS80MUFDeUV1?=
 =?utf-8?B?aytHa2Y2VU5RelZYdWpiSmxNWm96VDNlbVUzQkg4Q3U1M0pIdkZYRnNjOWV4?=
 =?utf-8?B?V3dKWkhhd1FGeS9BamZTOWRnSnJjeTVacnhrR0pFZ3llakxmQkNHb3A4eFR4?=
 =?utf-8?B?d2JNTjc3SEp3NmJpQ1hLWDR3S09qek50blh5NHFnT0Zjb1BEcSs1cnp4WFlZ?=
 =?utf-8?B?VkNtSFF0QjZVN2o0b0lob2U2SmRyM2hCZGRKTnd0MWNhMnA0a1RLL1ZzT1ZJ?=
 =?utf-8?B?ckVnSUlLRkExNHpHVFhtSHlvNHkyVGdYYjY1RXJpTEVjVHUrbG5OWGltVUFo?=
 =?utf-8?B?enBjbXZ2T2JpMEg5bVhFay9adU5KSWJZUnF6TkNENVJiV1V2RCtTU0dvVXFM?=
 =?utf-8?B?S2xQdHE1Q2FUZzZFRWN5d3FhbW81ZkxjRXdpa3JraE9PZDU5UXJtTU5JRUFm?=
 =?utf-8?B?U1R0TER2eWZqZGE1STVnRXFuNjBuRmlYcyt1Y05WZ0JPbXlSOGg0M25yaWtF?=
 =?utf-8?B?WUh5Q2IyUkdVd1RDZkxseXdiOE5WTU5VNFNxeTE1SStMVE1xU0ljak9VVzJB?=
 =?utf-8?Q?4dMmB7ZCglx+oBaJpkE1iKp5yMAjWk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:35:13.7922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9058703-5063-4b94-121a-08dd5a583a59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
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

For non template API on top of HWS,
it’s validation function pointed to SWS legacy validation function,
which does not match HWS restrictions.

Added HWS validation function for non template rules.

Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 56 ++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 03cbf53f492..9efe41b1127 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -210,6 +210,13 @@ flow_hw_allocate_actions(struct rte_eth_dev *dev,
 			 uint64_t action_flags,
 			 struct rte_flow_error *error);
 
+static int
+flow_hw_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		 const struct rte_flow_item items[],
+		 const struct rte_flow_action actions[],
+		 bool external __rte_unused, int hairpin __rte_unused,
+		 struct rte_flow_error *error);
+
 bool
 mlx5_hw_ctx_validate(const struct rte_eth_dev *dev, struct rte_flow_error *error)
 {
@@ -15385,10 +15392,57 @@ flow_hw_update_resized(struct rte_eth_dev *dev, uint32_t queue,
 	return 0;
 }
 
+/**
+ * Internal validation function. For validating both actions and items.
+ *
+ * @param[in] dev
+ *   Pointer to the rte_eth_dev structure.
+ * @param[in] attr
+ *   Pointer to the flow attributes.
+ * @param[in] items
+ *   Pointer to the list of items.
+ * @param[in] actions
+ *   Pointer to the list of actions.
+ * @param[in] external
+ *   This flow rule is created by request external to PMD.
+ * @param[in] hairpin
+ *   Number of hairpin TX actions, 0 means classic flow.
+ * @param[out] error
+ *   Pointer to the error structure.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise and rte_errno is set.
+ */
+static int
+flow_hw_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		 const struct rte_flow_item items[],
+		 const struct rte_flow_action actions[] __rte_unused,
+		 bool external, int hairpin __rte_unused,
+		 struct rte_flow_error *error)
+{
+	const struct rte_flow_pattern_template_attr pattern_template_attr = {
+		.relaxed_matching = 0,
+		.ingress = attr->ingress,
+		.egress = attr->egress,
+		.transfer = attr->transfer,
+	};
+	uint64_t item_flags = 0;
+	int ret = 0;
+
+	if (external) {
+		/* Validate application items only */
+		ret = flow_hw_pattern_validate(dev, &pattern_template_attr, items,
+						    &item_flags, error);
+		if (ret < 0)
+			return -rte_errno;
+	}
+	return 0;
+}
+
 const struct mlx5_flow_driver_ops mlx5_flow_hw_drv_ops = {
 	.list_create = flow_hw_list_create,
 	.list_destroy = flow_hw_list_destroy,
-	.validate = flow_dv_validate,
+	.validate = flow_hw_validate,
 	.info_get = flow_hw_info_get,
 	.configure = flow_hw_configure,
 	.pattern_validate = flow_hw_pattern_validate,
-- 
2.21.0

