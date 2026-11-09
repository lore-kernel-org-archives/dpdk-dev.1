Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590CF606D827
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GxG16s/U
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B5754060C;
	Mon,  9 Nov 2026 13:53:03 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 1E85740151;
 Mon,  9 Nov 2026 13:53:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWq6ITKpR5bDIMshABVSh8lRqSpA3pBuBi9vSoKXgRCamLOKauSdjsp3y1a5uJNJgpClP2sav3E89krCpMpmIImuGXgQwYoYkSDT4r3l67yiaOMNAOsCYwwV8mYE6av6djwswYMOpL0SvyAn2b7R3Qmsh5wprI8B91VxSeK5FcVD+npTLZ8mKUjCnG4CNKTmBI9jl64E1UpXaYnUZhgqM2P4r/kn+xURmSDGMEzdajWJJ6JthL+Ts+Q6+etyN66QhANnlZZJR16l+xf1MqUDEe2DEYp1dyfgB5BsLQozcSSRWCeyhxCxRyKRl1Xohm40TdCDQLFZnspOKwlPe4wYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP69A5V12E7+BUKK4kQIJ8Gj11iSVMgXnptRFJbX+yA=;
 b=g9ZWbX4SqxUEvhaPpeHoQoV3Qd5YDmwGvFpBh+uDs39zZEkWnOvhQnP0rdWo0g3a3CMbVTeB4csRUE6Kcac3ew+pAzH/JM4BpDNfxFOewOEh7Q0iTzhY1+cBlRFGTTc6gJOA8DtgqY4nmyY7fVRTEjR50kvNPTV7e7OIiY73YhxYNNeNeux7m17mqICX5QP3sqTcNlR47yefqTh+8hySQOmf2Dm4p73Fdw9Hl04AqDCxe4CopajVpsq62xEvPaL/8QKM+s2KvLYhQDk63Zm4IerUfH+4KSd4maosWZvvO7FoQreXzywG6VF5naTPEUn43fpsH1BqO8LeA6hfOBS4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP69A5V12E7+BUKK4kQIJ8Gj11iSVMgXnptRFJbX+yA=;
 b=GxG16s/U/Nfg2YSCq3O3ghShP8AIjF+r23GiQui7iN+s+M7pq20OrBM8Pf2IwMHOm0n4KE262ffgakbt824m7/pQ6n34PElj6ZCkiaakRIsDF13FjzF+ZMHjTkn6T66Q7/dCSJDtTQXnZ3VAC8qT9AlUBBX4+b4jgCPvJnPSkbrehcwIvQQo/D+LgluxTyyY9ICBCyR3qqM/arkuDdaDcrD7lodS8YW/OzlnuJEUnL1vTHd9fBWUdEHwM00BVdOPuakOeCeiQuvpx6ANLTRUGcRuF7ZevsyrfJMw6q0uKw4docmyKHF7aLlgptsZkKW4mJr5New6XgdcZp59JAZJfA==
Received: from CH2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:610:4c::19)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:50:52 +0000
Received: from CH01EPF000BE94D.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::39) by CH2PR10CA0009.outlook.office365.com
 (2603:10b6:610:4c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:50:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH01EPF000BE94D.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 12:50:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 04:50:38 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 04:50:37 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport; Mon, 9 Nov
 2026 04:50:35 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>, "Maayan
 Kashani" <mkashani@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix NOP insertion for modify field read-write
Date: Mon, 9 Nov 2026 14:50:34 +0200
Message-ID: <20261109125034.4027845-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94D:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 83df79c4-4987-49b6-c5e7-08df3e60164e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: VYkIAp75jR4bv6LLDPaT/UEVN9UWeQCq8qaSJvETF9i4SuuwIqbPzUKFfhCYAZ42sMMRFVSK7/cfMPYagTxMT3XO2Dp+U9uJVSqL88W8Wj/nmipgNCYUP9fwa0hIZrXnTtGwYaz+3t8KGi51EhQRJrC4w+YNVEa+25/KAMdQiTCm+Vcuc7FtZK3WdAEsXlsEAXNXAT42AhWMXaqHLd+F66Qca6RB+7/f0q7p776hh6X97spc0Ql7ni+9Ie92NaJO43UGh5kmqz0jhiDi9NWgLe8KUojZG3SS0Y88sIhw9EjGc1rXWvtBfUrGdEwZl5z6nsu7iRk/Ek7HE7DMZcXpx7OuIBMpndO2rLrShvLLzzvNCGvNWVNxD5GkbgSapED/+I+0s0lG/VXy/gX3+u0m7JoFmFaqdDnY6yKRQvXLSskwDkHgXkhfv45bmMmGxoZVk07eyw2XdPt4i0mSFXiz1Nim3QWiLoUDPxp4Edn2jJ9l5pbrqRN0FZsAb2+uBNaucaYIST+W6CZT73yyFzSWeoEqbVaFChTDKYw1zdcb9B1NBhW7dxYRF+1OaxZQbpCnhHXzGCpbdF8iiNmoVAsGugjVoYXmwNwCE9dikFDviwAkN3l53aJbgku323WwdDHn6LJW46ZzCuVaMKJDx/xUscUy7tDl5asvUVX2H4K3RfzGhsZFFgqxGMyTG0jvMTZCk8EeuU5ceWJ219eFquQdMg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0UIz0Wf3NzLwExN/q7wZ0ldxNzGgig2xBuq6nQkei+tGMQUReW1HGqfxw0LgyrX9G334YV9iwBbMz8Aj2a6B+D7otM43y8w58j98kECMn++rK01je9O4X/Ljkt1LeB5r97dTfcUHv62p2MMFBUPKoS18idKdxiVOIEjWHU+TF9FFCGEDVcJcZ9FkizabPLly7eQQskZ6//DFhmaYidILywJ4dvXbjjStrdLFZWpt94P3FOazMUwbfjCnhX81hv+fBLs1sxFXAMjjWLEvWTpNH4mA2Q7zP/fdt2xOjRaf26YS6d/psKweSTQrJ8Y3x5Z5vRmXmbGAg4cqND7DKbBO15OsAIFWrCHdQTEEgMq8vCEpOO37ZM8kSo2qybJ1vaX4QJRKS6kFRmxNs1AnoYqaBbTH7yGvE3J9kX1tFMlV1VPPeUUkd1f3ULrq6nze8hqT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:50:52.0504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83df79c4-4987-49b6-c5e7-08df3e60164e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
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

In HWS non-root groups, modify field actions are compiled into a
modify header pattern. When a COPY or ADD_FIELD reads a field and the
next SET or ADD writes that same field, no NOP was inserted between
them. Firmware rejects the resulting pattern at template table
creation with syndrome 0xa0a3a8.

flow_hw_should_insert_nop() only compared the new command's
destination with the previous command's destination. After a
COPY or ADD_FIELD it never compared against the previous source
field, which is the one that was read.

Extend the checks so a NOP is inserted when:
- a SET or ADD writes a field read by the previous COPY or ADD_FIELD,
- a COPY or ADD_FIELD writes a field read by the previous COPY or
  ADD_FIELD.

Two consecutive reads of the same field still do not need a NOP.

Fixes: 0f4aa72b99da ("net/mlx5: support flow modify field with HWS")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 8b74f66770b..acbbeb4002f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1572,7 +1572,8 @@ flow_hw_should_insert_nop(const struct mlx5_hw_modify_header_action *mhdr,
 			should_insert = new_cmd.field == last_cmd.field;
 		else if (last_type == MLX5_MODIFICATION_TYPE_COPY ||
 			 last_type == MLX5_MODIFICATION_TYPE_ADD_FIELD)
-			should_insert = new_cmd.field == last_cmd.dst_field;
+			should_insert = (new_cmd.field == last_cmd.dst_field ||
+					 new_cmd.field == last_cmd.field);
 		else if (last_type == MLX5_MODIFICATION_TYPE_NOP)
 			should_insert = false;
 		else
@@ -1587,7 +1588,8 @@ flow_hw_should_insert_nop(const struct mlx5_hw_modify_header_action *mhdr,
 		else if (last_type == MLX5_MODIFICATION_TYPE_COPY ||
 			 last_type == MLX5_MODIFICATION_TYPE_ADD_FIELD)
 			should_insert = (new_cmd.field == last_cmd.dst_field ||
-					 new_cmd.dst_field == last_cmd.dst_field);
+					 new_cmd.dst_field == last_cmd.dst_field ||
+					 new_cmd.dst_field == last_cmd.field);
 		else if (last_type == MLX5_MODIFICATION_TYPE_NOP)
 			should_insert = false;
 		else
-- 
2.25.1

