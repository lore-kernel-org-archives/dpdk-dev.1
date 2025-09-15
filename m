Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C2CAC598
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 10:40:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEBEF402CD;
	Mon, 15 Sep 2025 12:40:39 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by mails.dpdk.org (Postfix) with ESMTP id 853F240262;
 Mon, 15 Sep 2025 12:40:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP3e6NsFFh1AQc+8qJ/rNZUv6eeKUpPSOeRkVFDhDlf96+nKz1x6OYjIwEnRJO9AgfIaxzzbkW9WIpytSFPM/P8hrUDMtTo3qAJCJzRIvfI49uCaOW9YboqYnASS02BBPPC6lrPPi+EKK1uykFeZoWS+P0RMfSGIoVBPSvO0rgkr6zx/JaEtSgdJMDbCJYab+WWIPW73AoyAx8ndxd7q2VxM8hMBxqEIDiM5aWUB74bdWcTB5glaEKNR8omAVibfs6uKkazxiF2ieWoVKKOSUC8B+NfI677dmhKZyMH3ukc4OHF+NyY5wd1VW1ViQuiruq1tkc1ZWVFS1dsogCRiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvarQRRAhQzNvQ2qjQjY9YzZy2DKb6ierpKcm38bpxU=;
 b=W0qHHVgOPDNdwEQ7dpktLE2vtdVE8JkiN1a/IP7SlGrVA778Z1gFappO/9S92KqlA0n+Jgc1t+/BRkO855WibExEi+BOwHAVHN+onT0CZk6vQuHkNjkTX5ImrgSEOProcEct0S+sohUALRdCOq6ZHQ6+SOsJn0FRZD4rYz4xVXZ0rnqoOvvwXjxaIx+zJYl/Y4mEX6dsHCHwweNS8j4T0OyOUaUMSMNASXJ+BLTl0dGeir6brBxZin7udU6qrSsq88apdevsZ8xires5Huxf8EX/IGGsZ3iw8q7dM8X/buqnhe1RtufrcCNfytMsU7gn8YaWwPh+kySzEgyuih5QOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvarQRRAhQzNvQ2qjQjY9YzZy2DKb6ierpKcm38bpxU=;
 b=BmD/S8hiXOPTyaV7Ui9EGiILhCCR9ymYbE0rV4zpfnIlR+WNR3y8p+mOBaqabqlEANG5X1Pm1tp5uosJWWVJVtfrg1WKTiRD5PYLaOKDylodzWW2xUsoB1jetxcBgCSeHlUqoI0/WlefwI3mBugvfX3xVqEuwi/2jjUxt3JrPaTF7yChOs5Kmw5KeSGpdOLvWL/RTF2K7P9XZ2E2MUBwkCLf/pxFNdRgMnjl6tUGil3TAK26gC3YZFXPVWu0MBI1cjDnbUwkW8e0hPo4B8ZBluwLxFblUwlVT87EBa4RhrSMeJZSRRx3R01vQZaJgx0whs1uslrW1lHWN1ADNgygnQ==
Received: from CH0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:610:11a::15)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 10:40:34 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::f0) by CH0PR03CA0353.outlook.office365.com
 (2603:10b6:610:11a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 10:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 10:40:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 03:40:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 03:40:20 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 15 Sep 2025 03:40:17 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix missing next proto in IPv4/6 encap hash calc
Date: Mon, 15 Sep 2025 13:40:12 +0300
Message-ID: <20250915104013.165130-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 378b849e-5dc6-4cb3-628a-08ddf4444cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WPEUK4D7BtJvS74DndE9cXIhBQKXkP9pwBZJwiB7f45LjsO/ZUiWU+PbfgEu?=
 =?us-ascii?Q?BW77ztrQZxVezWmtFZvhJshfv/bpYNjRM9qtPr6JvvRndkfcNjqA7NZPUkJE?=
 =?us-ascii?Q?bG1vOUwgFG3l6iX1OOqZgDhI4SYCActWn9dJg34wkEY5mOr4rx5l0mSugk6C?=
 =?us-ascii?Q?oStrqTm+hF3a7IK0oQkHuhaoZXdGInRFywN3yM4dIK1U7UO8f8Xsqb9MKmFo?=
 =?us-ascii?Q?PnnKwnin+GXkieX8cg3OJXkqnPJnhkvwKU26gUns0huebRzqJR7CKGmEQH3R?=
 =?us-ascii?Q?hFObDUk8AbPZLjtJmbmHdtOJWrgQ3d66vc1zPin4AmemsqEi7XkkaK56L/oo?=
 =?us-ascii?Q?w1dIzTdIMSFuhfhA9ialH0h7NpKQFA3PxSQ6hB86IItgj7x9qLl8VfmmERgn?=
 =?us-ascii?Q?ES+x97ninWbcxnSjWIPgJJuAVoT2P8Obw+o+TUCvLFRzPNSgYGF/9R6/tf3t?=
 =?us-ascii?Q?eOxxP1/uACTyNnwTqylmEtpl8xT/4J9o6yAYDAF0Df9KAN0AvZk0PFRHckgA?=
 =?us-ascii?Q?2pc8KUAyYMDX369IR5i+6wSsnFO5QMluawadDWF3UG31e4mL8YulAcXsCyh4?=
 =?us-ascii?Q?iHtoR6IGZ6HlGzH/FKSLq0GTe385xnOP2gbSLxIWHmfDAmdnS5gHI6GEAMmc?=
 =?us-ascii?Q?c/ZNbsgXhanhcwiieGFcdgT+08dIglnVFF6kWyNhzKg+BFCb+C/nY93NRUBF?=
 =?us-ascii?Q?um7+OZyeFSrEIABB6DHaXHHG5igwC/dkTbXibyfeLNq9gi4ySR7j2iBbkKtW?=
 =?us-ascii?Q?UcSGz8TABI8FflCiXGTlHBStdWkD//jLEADN1jxAy/TpScU73YNf/C/JZnSX?=
 =?us-ascii?Q?7IKLPrzncZcx1jkLgpnD8uJrJChuzNtA61BD4dgHtsen9oe9xE1mSQ71wc0S?=
 =?us-ascii?Q?0svGAIIF+5+FHZqy7+GnXXsQY/Bvr7aV0rcu+kRvXjWa6RPRRg4N5yQfqBUo?=
 =?us-ascii?Q?yYwbcegjF2vrjvOxAqgeSnBEZKk0CdM1EmVtykC0YGgUfmOgZp5MyVWrZch6?=
 =?us-ascii?Q?5mU+T0tMw7gCiKHxFj35M5VrSagzxVlLNGhZcYSBjmVoEIGqVlkUUxdCOZBU?=
 =?us-ascii?Q?RjzfLZ5TdytXiHtJjGafGVpLnWeXnGnvxGDqj7iVwGtAZrhTccTvsR7g3Pa0?=
 =?us-ascii?Q?HU2PAivJ3hWuX072F+hf2zW6j3PW16IMKVmuG7MDONAwtihr5vyzRRfToBfY?=
 =?us-ascii?Q?CUhspCbBd0tHpZiH8YEEIAa2ypZmXdoZfI2yk3k29gtD4rUC+wrCBBrEk/9e?=
 =?us-ascii?Q?MpE7zS/jEKZVB3cqiuIcVPlt3iSi6Qzz6hEhryTCJ7z/Jw4BO47axAAfBX9G?=
 =?us-ascii?Q?NdFqCQaCd5CMQWNEw0x57gm4kiEl2t8wOUaHKptbDttXLWsPw0byb6XQOo8d?=
 =?us-ascii?Q?jf1aFWSSlpTLr2UgCpv+PZc5qAaIlLeaDeX9zrCKjcNA8vxwhNO2OvKGRooZ?=
 =?us-ascii?Q?D5pMqYE9N+rvpztQONWXJrOJK40bApC4yOiWb6AN76CG/ZygODYq5X+j8ZM8?=
 =?us-ascii?Q?4D6ih1G1fX4H9QlYA1vHaW07JWQDsOU5tHvc?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:40:33.9651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378b849e-5dc6-4cb3-628a-08ddf4444cde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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

Add missing memcpy for next_protocol field when processing IPv4/6 items
in flow_hw_calc_encap_hash function. This ensures the IPv4/6 header's
proto field is properly copied to the hash calculation data structure.

Fixes: bb328f44afe9 ("net/mlx5: support encapsulation hash calculation")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 2ca40b41465..ee8f8c35e57 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -15096,6 +15096,8 @@ flow_hw_calc_encap_hash(struct rte_eth_dev *dev,
 				((const struct rte_flow_item_ipv4 *)(pattern->spec))->hdr.dst_addr;
 			data.src.ipv4_addr =
 				((const struct rte_flow_item_ipv4 *)(pattern->spec))->hdr.src_addr;
+			data.next_protocol = ((const struct rte_flow_item_ipv4 *)
+				(pattern->spec))->hdr.next_proto_id;
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
 			memcpy(data.dst.ipv6_addr,
@@ -15104,6 +15106,8 @@ flow_hw_calc_encap_hash(struct rte_eth_dev *dev,
 			memcpy(data.src.ipv6_addr,
 			       &((const struct rte_flow_item_ipv6 *)(pattern->spec))->hdr.src_addr,
 			       sizeof(data.src.ipv6_addr));
+			data.next_protocol = ((const struct rte_flow_item_ipv6 *)
+			       (pattern->spec))->hdr.proto;
 			break;
 		case RTE_FLOW_ITEM_TYPE_UDP:
 			data.next_protocol = IPPROTO_UDP;
-- 
2.21.0

