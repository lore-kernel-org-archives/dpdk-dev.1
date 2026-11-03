Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC433606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Rg15qM1/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50375410D3;
	Tue,  3 Nov 2026 09:20:47 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by mails.dpdk.org (Postfix) with ESMTPS id 0491240278;
 Tue,  3 Nov 2026 09:20:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hychnQBzfAcfv9MiCJ5Nhktv3f8BwdPinSacZOZGjKmdS+3LmF0qiNj2hoTrGW97lm9UZRf3hAFhR/HyevwNItFjQd7iEe4pGdKHUgqe8lJjq8DYd+Eo2zuxfURtfDZ5P0UOEV5+dn6HDKjd/9ha1m8Qu8njTQeNT220o2r9hngpAXyN48pSpHwqYfH2I/f17M5+WIBf2eKnF1VOeNropLuRh2IFVhPwPm2gEhbDiFqOQFMoiOTWeCdWHAn0RREJFttzi2YK1pCejx/9gyJmi91rw3uyHWIZKmDnBdCrdQTomgp8DGDAJLyHy4lER23H9d5BdLUGC+Bcdr1viDvpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTDDKRR0OwOgwzFH3xjqd/fCfTYosSW7ELFuq4/w3Ig=;
 b=y5svTAs5iCzu0VN7D8Yz5EYakYi7GI57TK4sszUCKtDVipcTqXi/zaHdNDVMyzhRqDY8CLghZhSPSah0bCs8w3VMONqJgbBwPwkkozREHrSqOc0UrNk0u3Xk2V7AOeM5yjpF70RWUiuDgU8wP1IROY6bnlKrCDxRA+CmCrCh4j1e62anTHxxgLZqKQJque2+5QhQei45cQ0uE+wA4032qgwqqUmWHasgVR+4yI/u02Up5v9i96qmJJRRCq+Iw7wij4JNJcW66a0p+qgD1WRcGIXmPbXWYP3M958FmeAyWleGE58KPMJKwF9PHrXTyfUyVjFYYtGmM/SOEj2NxHCZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTDDKRR0OwOgwzFH3xjqd/fCfTYosSW7ELFuq4/w3Ig=;
 b=Rg15qM1/NneWm7n5RfjXuAMV+I+UYAYMfSoV5oSd1T8AkE03USFjgwtuk6b8dUqw37zuvJ+KvBvihVO/MqGQgh20gRAcJ+kDNRn4ffGUPHlYyGUcqX4+OSL3Thq+kW2Bjebgc2OQ6TfewBMsiqZCe/daMTUuOPhLpGqOlht22W5/q3WwTPGNBNjo7MDFdzObkzkQvH/ban0pdu+iWhwJs44xR5H6c/A8GSg3ETCkeqX2H2pYyhkP75HZzxCAokD2/JK0Lc470lywXOstB0i2WBrl9hVuKHcLJO+wK88asHHwhcuDQGdK0PIZ+bgzQTOTX5zeG8mvpVZmIRaLqtKUxQ==
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:20:39 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::8b) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 08:20:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 08:20:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 00:20:23 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 00:20:20 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <stable@dpdk.org>
Subject: [PATCH v2] net/mlx5: fix local and host representor name collision
Date: Tue, 3 Nov 2026 08:19:59 +0000
Message-ID: <20261103081959.2932331-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102122316.2504667-1-bingz@nvidia.com
   >
References: <20261102122316.2504667-1-bingz@nvidia.com
   >
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5f5f28-b0e3-4337-1bc9-08df398357c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261026140227099003|261022105027099003|261021123027099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: RW9u4ILLHw2COs/BJ750n29bZxY3wq+2g6RG/INtbDvKMzUEfVPt1xcvBy63LUWZG+4tsDStnIXhoH+Yq/5xE18pXPC6p1ckrt+wvT6pLetg9jQiPZfdoFY3ceYIz7c6fPyj/kZuyNtVL5k3wmxJgFzyvDK5+RBgaPf9fF9mYJUUvSGUocfXLsufD63mgxWCHPZV31PGRoQ7srShiSaX7ocCIIvfBehMbPWPRWb0xj8aJ0EmDVYOe4xuJMSB64nCk7JzDKe8ghHtN3mzR1h0kgIB7bz07E2cz9G+qZGLPKmwRrDwxLax6rdYm0nD1EqNHiXJSkHHqWduiaQTrJSiS623ImCMEVyCC4ismZELRBR0yf8HxocIOQ8SKXE0asPLT1FTqMqeoUaxLRYk3NeEjeWFLuvtkTxJazn11UL4g9WGX9llDisa81KKy/BTpCPWGtNdnhFW37xokiSH5GJV7k3O5rycC6f3fKoeREuxW4NRGvee/mELRF4YL7IPsQSbwgbENlEOF69psh+fzW2K3tNUuCOLOEC1PWmzNoQxR7ZYoY29baWJkBUXtjvBh67TH3HAPSgquYG617eWv4miFCI12wdgt7IOKloUey9TaCqLnt0d1mTocUPT95tZ0xzT4orvPfqFrh7SdUT7y25qiHuVCu2JOAaFFDXjQsVPrt5h9c7+aZKjsSbvkMEm59rYkxaMa7NjCyh6WhVfeKMb0g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261022105027099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KWydAy/UHARaPKdB2MJs6RGLj/Vq26m1qOXL2NJRheb1RSIJReucjOu+24p4MmjohRrWG5vJDC1l+O4nFRspe39cAowlvyLAvSfKD6sgvfMhg1x+OjPA1J+q2Yk+tCqsdm3beUAgThbM/U6+iRWw+vEZh7HMyMaKBQ7QCP/uk7x57MQXPgzrnGUxxd3+x/VOmwN+PhpJPJJojizlR8gjdfHLYgo0ry84Hh/TsCTV3BhVqzR6Jz5gHq4ghujA3e8C4YvhunQL4dwuNpodCAa6iA+gCE+xBSf9Kqwsuqx86kpxm5tIRBIKLlkEnKaP7KGhzPZZvI5JJEt62pmVaJqoYYRlN7O9AGd75sdNyavAdPUTiA9in+YPU1NQRVbiPksx+qUEf3GVNmM8sJPcsloF7q703Wd8SfVoz8xaFoaVinYupWaLHHrbUPrcJp/xLSj/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:20:38.4661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5f5f28-b0e3-4337-1bc9-08df398357c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On BlueField with a single uplink and host PF, representor port names
omit the controller index. A local representor (pf0vf0, controller 0)
and a host representor (c1pf0vf0, controller 1) with the same index
were both named <BDF>_representor_vf0. Whichever was probed first took
the name. Probing the other one returned EEXIST, which is treated as
already spawned, so the attach succeeded silently without a new port.

Add controller and PF indexes to the names of local representors on
BlueField, detected by the presence of a host PF, for example
<BDF>_representor_c0pf0vf0 and <BDF>_representor_c0pf0sf0.
The host PF representor can also report controller 0, so it is
excluded explicitly. Host representor names are unchanged.

Also log a notice when a requested representor is already spawned,
so that probing it again is no longer silent.

Fixes: cb95feefdd03 ("net/mlx5: support sub-function representor")
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
v2:
- Exclude the host PF representor from the new naming condition with
  is_hpf(). It can also report controller 0, so without this it was
  renamed too. Its name is now unchanged.
- Update the commit log to mention the host PF exclusion.
---
 drivers/net/mlx5/linux/mlx5_os.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 4c35737292..bf6f5c0ae2 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1081,6 +1081,13 @@ is_hpf(const struct mlx5_dev_spawn_data *spawn)
 	       spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_PFHPF;
 }
 
+static bool
+is_bluefield_local_representor(const struct mlx5_dev_spawn_data *spawn)
+{
+	return spawn->info.representor && spawn->info.ctrl_num == 0 &&
+	       spawn->nb_hpfs > 0 && !is_hpf(spawn);
+}
+
 static int
 build_port_name(struct rte_device *dpdk_dev,
 		struct mlx5_dev_spawn_data *spawn,
@@ -1130,12 +1137,14 @@ build_port_name(struct rte_device *dpdk_dev,
 		 * 1. Device is a bond (VF-LAG).
 		 * 2. There are multiple uplinks (MPESW).
 		 * 3. There are multiple host PFs (BlueField socket direct).
+		 * 4. Port is a local (controller 0) representor on BlueField. Local and
+		 *    host representors with the same index would otherwise share a name.
 		 *
 		 * If none of these conditions apply, then it is assumed that
 		 * this device manages a single non-shared E-Switch with single controller,
 		 * where there is only one uplink/PF and one host PF (on BlueField).
 		 */
-		if (!is_standard_eswitch(spawn))
+		if (!is_standard_eswitch(spawn) || is_bluefield_local_representor(spawn))
 			ret = snprintf(name + written, name_sz - written,
 				       "_representor_c%dpf%d%s%u",
 				       spawn->info.ctrl_num,
@@ -1359,6 +1368,9 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		 */
 		if (mkvlist)
 			mlx5_port_args_set_used(name, port_id, mkvlist);
+		if (switch_info->representor)
+			DRV_LOG(NOTICE, "representor \"%s\" is already spawned as port %u",
+				name, port_id);
 		rte_errno = EEXIST;
 		return NULL;
 	}
-- 
2.34.1

