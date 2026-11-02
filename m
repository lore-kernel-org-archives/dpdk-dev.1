Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17841606A793
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PxG1oTdz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D277240274;
	Mon,  2 Nov 2026 13:23:59 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013004.outbound.protection.outlook.com
 [40.93.196.4]) by mails.dpdk.org (Postfix) with ESMTPS id B21F04003C;
 Mon,  2 Nov 2026 13:23:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgCjUb4bQVAFEYsIGcBcYNGWdmn7d/wXJU3giSVRcERsR4QigGSlvGkAbqJpREoJFKWHF2Wi0IT7Ur59q7zHA8BbW2AyPUx607eCdx6Z2OOz3pk/W41Z1m7blwyZwhj1f3COO8yOuK15Z26kJ+No0dVAVoIfrwLMbQQhOpH1Ig5mCi+z816r5IVbC/itPzq3rY8Si/sHJXJ7eacmpsbqco/ZtxetRtDSQSwHr9KCxv9BP+Sf+7oh147mmQIFcjkPKr9wmT1CUrfLuAcEc6NN3YfR1uX9qXEClizKh7mhCVZgjCeS2WSHoP1aDgvOo/wqU3XKgrX2UexhJRleGmZWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHcqoFynBwt2qJPrEYYROnilP9MCwzzUb/i0okgau/U=;
 b=lG/y+nZ/C9Nmfatb4Aek7wMLuoYVFG8CGfSBtNKs51SjfdmNBtT5Bxl9ugIUxnHhC1IxiywjbL53T8yoKUYfuBhwIl3M/qJ8Ahsibnc3rzFsHbmucObKR9vdYC1B0fwg0TBrApBuXzfdX0U8Kt8XVVWydpxwaAOSkelPGGv2OQCn+gz5pgQ2OagJvZWvoU966eNH+odL+ZANJ///rvmW5k69UelSJwd9Vi3qsoIxA3KYTVkkMJd84pCB4S9mIa4SODe1CBT7Ggi/FaCaDF6LjCgPdqd3TnnfsBAFi38qXuBM6lsg7X0kMZArtOhyP3tXyzTwF0o33GwloXXMS707zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHcqoFynBwt2qJPrEYYROnilP9MCwzzUb/i0okgau/U=;
 b=PxG1oTdzCuSraOjlrSlnRv+kZKP/y5UbgkH92GjHZcBdyBoqrBtPAWDDJF2sxmznBk3m5QmymwwvbkgTlza0wOHuTWfvCe7AXMN90rMociMgg8u7dMEFXXH47dzuermkMEwhMMFwcRSh9EJ19EVzYBml3exApm3Z7YIJEOMta6sPg7eSTRRuLWaOOgrfB2u8Is0yIUdRWDhPGkA6iWibEz9HCHzZOaHuAUzHVH4mHWCEzcmUlfGQ1p9o4FIgXbPmTOo4Wihin1Z/LJlcRCF4KmM3ud8jI/kcFVFwUg8EazMgaQPDIAPxKgKv19UNSK37Su0F/omu3UGWzpeqT7KhPA==
Received: from PH8PR20CA0004.namprd20.prod.outlook.com (2603:10b6:510:23c::12)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:23:54 +0000
Received: from PH2PEPF00048914.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::32) by PH8PR20CA0004.outlook.office365.com
 (2603:10b6:510:23c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:23:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH2PEPF00048914.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 12:23:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 04:23:40 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 04:23:37 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix local and host representor name collision
Date: Mon, 2 Nov 2026 12:23:16 +0000
Message-ID: <20261102122316.2504667-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048914:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 418b6ebf-d478-485c-ff64-08df38dc296b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261026140227099003|261022105027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: j07U3+tvkGMGQ0Gg5agVWmPLv91bEF+2tH/wmY8Rlf4TQhzVHtTkw+uVGoBQCJ+wMK5n3qcE/7Z/K4SGhySJu3zoVAQEPm2M46mxhd7aqBE2XfE9M9I2jbN229s0riWuK0YWjH+yqBWx0gnLrQhWDIOisI3osrhKUsWXYGn6pY/wXsqJsvN6n56i194IfDa1JEwjMSZ2vvYu1n1cEVf/Xlik/yzPcKtEm435snyqcg8rzNLUg+WxNp244xMcOMFh2xYautwRBd1XRTAJmr2PniG4xzGxJOv7BIqpLxpytXG7evd8fNRwPNgfwNCilZSrejGDMl1IX5cZZqNqWhuBotSVIhgdy/DyGw9ROVQa4MG6+DXVnZrdxxh4JBzvEfxqcRG/j5jhqP3rpEXWqpjtdUtSyRf6F4gqN1YoDOSN3D6yqR7hJ1CdfUTZf61QV1nmJMGDYFSZVyU8h9tWMeLowOgle+vyLfq7fL9l6RiQ0q/joiqk56QB5Q+TycZX4sWyJJXA1phyEsfguhuUN5n37fX33SFDDDCKRKYJBNiuCYTI6jJA36cgD8vXgGjEwk9MfDS1BmMf8qjn9oeY3NdzYpRo1o0vC0ETyh7AiOmkrHLyprV1LFwiSyOvXf/BO20AN9+7+Pv3M+Czj7LQkA9nUxMoUpyzXriSwonXERgfqiXNHZVZgQNarlqyJ8LqgGXTqgT/iqKoUlHSu2f2G759tw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AQsqPSqONSAk4vqTQwh6iU1UebBYPQqzlsjjnmI25h7QVsem7Uz+TFaVS9YWDSnr4Mnf7muqZ5SczJuYsJmqCjQutGk7O/0BBwuS+u+sr19RLEBky7oNWRFEy884arR8pCXO7O4OV4CmrnCVswjbogRjWg+OQq4f7MjBL2GkP5Hq32isGf/yUFobnem4kVeY1W+jLOItP+AtDq2tteufN+9/ChyiqKWNubj+qmT7wpkP+uYsut9i4oJQNpWDhkIiWQ/MREJM197TZ6qgxDdGpTGD5OJ72K73E749clm7KE8oLq6u3LKeer3+QNQvhZICAQ5mD81dGNLKoMTOmpgmAqJeZIBN9sqafnK3jqWVDP9O6oZOKls9IDlHcujOaD3DAoQIIZx6Ng4kjqdvhB2mMF4HsRJvNwLqBke0mDuAbu1fEOWFqViw9cHjCv22ncWH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:23:54.7888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418b6ebf-d478-485c-ff64-08df38dc296b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048914.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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
Host representor names are unchanged.

Also log a notice when a requested representor is already spawned,
so that probing it again is no longer silent.

Fixes: cb95feefdd03 ("net/mlx5: support sub-function representor")
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 4c35737292..82a8ad549b 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1081,6 +1081,12 @@ is_hpf(const struct mlx5_dev_spawn_data *spawn)
 	       spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_PFHPF;
 }
 
+static bool
+is_bluefield_local_representor(const struct mlx5_dev_spawn_data *spawn)
+{
+	return spawn->info.representor && spawn->info.ctrl_num == 0 && spawn->nb_hpfs > 0;
+}
+
 static int
 build_port_name(struct rte_device *dpdk_dev,
 		struct mlx5_dev_spawn_data *spawn,
@@ -1130,12 +1136,14 @@ build_port_name(struct rte_device *dpdk_dev,
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
@@ -1359,6 +1367,9 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
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

