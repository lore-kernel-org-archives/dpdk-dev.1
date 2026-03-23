Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D6EC01C0
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2FF540268;
	Mon, 23 Mar 2026 11:21:37 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by mails.dpdk.org (Postfix) with ESMTP id C78634025F;
 Mon, 23 Mar 2026 11:21:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMkmXiogwIlK2hv/MQubnymDOPxBuumGh+H9SllYU1K6bMKlSqRyGS4qJ4M3hjNGF4HzCmFeAXwu3ZYHpBk4q1eK58C48T0dZgmlbHg1uM6bBLAuRKwERzhuQFQktpc32BHl8fK0Zvolr6sq1wStveBTM5SZ+c6NC6SW0kTZHazVmEOvIMym3ezX8r4Y9KwgrF03YfUGY3FxbH6nh8nXOWofWB7wo1xsZSvxNwcjXHh9HvDH8dvcH7nEcMTdjFeSyDra2eFZqoQ+lSx+/edbAz6ylzkLGcnRUdWZwEkZg3Ft20CtzO+f+cLuC9NJojAaNiGBR4rQdDC6G7S6PcButg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBalumU3IZ7j0Qt1Ezu41xRvbL1lARLKLGKUfwOyCGk=;
 b=uEjQ4rYis3WtxfAE5sWwGTq/LjG8rYmDreKi5Ldw+yBg/QyYdbOSmE8fmentp0CwP+MJRQ0u7CMbpnXTyo4YwG7prEmHnaxQmnqYM9z9Mq4cmHSvC9ZUgGjE7CfUgbFYkAObood00dh4GdLFLOO4vR2vZ1gR0QYXril5EH7NQm1r5UKpKUbBUs6VY6c0VRV90Nrfp8I9XioDmrcyMD48k9CofprbSbC8eEnVKGhEm2UpfTosLkRc24vbjiGu4VjdFAt58yfIdJrUobI5vInAbuy+ySR0jF5ydTzbGtvQUFZPQ0Vd2zKBR5hhR1nzd3eKQpbApcW/YujXqoEcOX7yrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBalumU3IZ7j0Qt1Ezu41xRvbL1lARLKLGKUfwOyCGk=;
 b=HH8KuPDJeplN9bJ9CbmZwvSn2gar7QCJZhU1VxDzOCVS80nZEGxzUuaRqxTpRZyjDNzBQPdZgOlIBRO6PmpjYX8+tsmdz9HPvoTtAImOWjI0eVZ7dtwPtCjYi7o+1ygv/SDiXYZpYrSotiCmT36oakL495NmI1t8nlPSkEIWtKkgdnYSI/IEa9uoY1KZhOUoiZJ/H+Fsb/NDEt21286b5TMiD1r6O1HHOREYklxEdv3DvIRC7aN6WBzDSXL6W1RaOD83voWL0HgAByxPS/LfVRfyf3TtUkzF4BhXWrWPr+hSgqCePisRxyyVZDK7ifwkqlKhnFhDOEgPQN5qih1H8Q==
Received: from DM6PR02CA0096.namprd02.prod.outlook.com (2603:10b6:5:1f4::37)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 10:21:32 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:1f4:cafe::69) by DM6PR02CA0096.outlook.office365.com
 (2603:10b6:5:1f4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 10:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Mon, 23 Mar 2026 10:21:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 03:21:17 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 03:21:15 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix flex item capability check
Date: Mon, 23 Mar 2026 11:20:59 +0100
Message-ID: <20260323102059.791194-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 9738859c-5d00-4fde-16e4-08de88c5f45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: NdnyjgvJWkgtmdVPHTna1Suv/FjbHxE4/5abRP8UoII60PXlTYU4PXD2T08WwFx8asg6XXPRTSTbbK9+I5zi5R5F4XjnDfy7zWVNBSSFUXvIhDD3L4O+YIhVI7Dgf9qh3D29rdVBGBfTAtET84lQKKuaSeis6fPaJ0Z9f2Jkc4Df/dy2FW5Trnf0V/6zGlBXpQOcIKn6Voy0pSMQ7/l+GvuvVBI8bhnhtX70LhW+Sw+mEzHcqYGPbAGonT7kLv6ugnKJgMzDDo4Uvk/QKbW346GMqZQbSEM435UZbqMsNp+JP0AcHtKQGwwBHW2Ozxq6FMh2ob/o+uxT8GmzBIro3zKTDI0WfL2fEGCUcEQE7JbF/KvPsNqNNN4M09Ivi1SMZWm1EVB4EWc3eB7NfjKW+hT25h5JKpoaCdCzxZymuOWNRxhIfdrRA9gZC5AYTeZflTdrguuvuMW71Uy2LBZ+ZkezqGBi2kgNp1ncD5MG4kp080WjvQDUPjAMgJkil2sY4kCPbllEoL1OvY6xPrFmX84F7T2fbJpiKGDN7OdFW4A9sgn96sE7YLnfWLZ+ldVYn+Pm2RV9SJ8+Bw0ytSS6geIyQG1POd1An5dK+ujQ+iZtg9fYnrR8wDHMqEuNQx7t5GkAh4InAc5hQg+rF8SXJwsa7Ul3ufqHKWtZfmZ0oMgrINk45x2IQ8gWwstAImy6+m0PFHsych/wsPDfSh0CgJN+YnV+0DwloN3x9ysPQfzTau5jbnGmXT2F79zEmHDZbIygPAxJIs7T68p4MVJr2A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +5UR2uXWc44RS8mIzZgT7kFi5U6EmZOaKox4orCu9CL4tLVCt3B0NIygRTXgejhHpL7wy97eimDuAD5tgeQ35BuSC/gVb0XwBSbSygTu+cyB9mckb3yFL/jIVs4u9u3czQ8D+dYc0QA3cp0hGP4D3SRlYRCnIPMh0aMTfDUhT+rLNghJVVvbQGOF0sEosJGzKTTgsVhviM6/pbrXg5as6DWAY4Yvd7jRgfdTkRrFTS6OycUAXxxt0c5Ukh7561xxGxPEj6xzOJ5S8/so1SAVnk1lPSScNDxFvoiBr9em7GMJQ0kC+JPOVBdGlVi2LtgeOQCBO5fhZ++aFvoLWAJCqVZgSsu16zNtT+CTeJOw0ffPbUMz8JbXqL5mGmfBvZXehCBwOhoYc1bEVPiSHacooX2bwg/qZ1gx8v1vyamwDtz6v4PbUuRfbfxz54CVgqjh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:21:32.1406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9738859c-5d00-4fde-16e4-08de88c5f45f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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

Whenever installed BlueField FW was too old and it did not support
flex parser, mlx5 PMD reported an unrelated error
on flex item creation.
For example it reported that:

    unsupported header length field mode (FIXED)

This was caused by lack of check for flex parser support.

This patch adds missing capability check and
adds proper error reporting.
Limitations of flex item described in PMD docs are also adjusted.

Fixes: 71adf25dbfb3 ("net/mlx5: fix flex item availability")
Cc: getelson@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 doc/guides/nics/mlx5.rst     | 39 +++++++++++++++++++++++++++++++++---
 drivers/net/mlx5/mlx5_flow.c |  6 ++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 9dcc93cc23..64d3c96332 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -3100,15 +3100,48 @@ See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
 Limitations
 ^^^^^^^^^^^
 
+#. Minimum FW version ``XX.31.1002``.
+
 #. Flex item is supported on PF only.
 
 #. The header length mask width can go up to 6 bits.
 
-#. The Firmware supports 8 global sample fields.
+#. Following number of global sample fields is available based on FW version.
    Each flex item allocates non-shared sample fields from that pool.
 
-#. The flex item can have 1 input link - ``eth`` or ``udp``
-   and up to 3 output links - ``ipv4`` or ``ipv6``.
+   +---------------+------------+
+   | Sample fields | FW version |
+   +===============+============+
+   | 3             | XX.31.1002 |
+   +---------------+------------+
+   | 8             | XX.33.1048 |
+   +---------------+------------+
+
+#. The flex item can have 1 input link and up to 3 output links.
+
+#. Following types of input links are supported:
+
+   +------+------------+
+   | Type | FW version |
+   +======+============+
+   | ETH  | XX.31.1002 |
+   +------+------------+
+   | UDP  | XX.31.1002 |
+   +------+------------+
+
+#. Following types of output links are supported:
+
+   +------+------------+
+   | Type | FW version |
+   +======+============+
+   | IPV4 | XX.31.1002 |
+   +------+------------+
+   | IPV6 | XX.31.1002 |
+   +------+------------+
+   | TCP  | XX.36.1010 |
+   +------+------------+
+   | UDP  | XX.36.1010 |
+   +------+------------+
 
 #. In flex item configuration, ``next_header.field_base`` value
    must be byte aligned (multiple of 8).
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 7df64d634d..915ea29a5a 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -11904,6 +11904,12 @@ mlx5_flow_flex_item_create(struct rte_eth_dev *dev,
 				   "flex item available on BlueField ports only");
 		return NULL;
 	}
+	if (!priv->sh->cdev->config.hca_attr.parse_graph_flex_node) {
+		rte_flow_error_set(error, ENOTSUP,
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "flex item not supported on current FW");
+		return NULL;
+	}
 	if (!fops->item_create) {
 		DRV_LOG(ERR, "port %u %s.", dev->data->port_id, err_msg);
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION,
-- 
2.47.3

