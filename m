Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19E606A894
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PJqhsJtn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E7DA40E1D;
	Wed, 11 Nov 2026 14:12:00 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48]) by mails.dpdk.org (Postfix) with ESMTPS id B4DE34029E
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:11:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewmHb5h6pr7BkmGkdFOAmNbMjXEr015IOdM/jfBU+o0XDqKusHZL04SG33T3Q6vKU2DicZXjZGebu5Wl2Nu9u0Vf5EaKE+vgjH5cN8LnTWZWE3jzmtacGCNIfsFONjsfjphW5QnYn9zTlG0RMje79tPk0VFfag1vRo7MXvA6B0pR1Dl1iRDI8RexbIuMuwOTslWmvUMSamGMMntMYTVdSwQ/rry7i4mGPbGv0027ic+kUcpI1c3CwOZwcnl66ytWqzGAsf/0EHhRasYCLkj+olytVqKyzeV782K4Tmz6dg5eQ7uRO4j0/TO1XaaWRZO+3IAsLOj++sxsQ63jg4NyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=wbFN2E4YZn38bFJ1OJo07I7sW9JhMPMAC7sN62HAYUUrPOY7N1oNPMUx25cgbPx/GK/bYTTZv2VpdsFxVY3RBu8UxZDvxXFUDkwCM93hBxd6eZss5fbh8bJsu5iqGAwNfpAYOLmI/pAaWUdTATglaFp7JAnYN+YViLLxxPZXrwUD0jORmpKN8NY30xMQ1Q22XEbiJUKyZFjL2gbJDc7TGCM67b+oKFEu5FWsnJX7UmYxVrrQhzquYV0EfEzg1W9LrphAh4N0B2KaTNlKwFdyvMKCvMo9PS8wozOBoFP63apOPxsrHQ7bnHki5XKMtQYoAQEc/O/1ToSD4clsQkv0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=PJqhsJtnDatRALah/xDA5tFjUxnqQGLRSMiyqwUn/0zbouBAzPdDkox3Ro2O61Ai/czkja+wap7w85Yk1bws7O+BJlOvciAswORsqhUPXKD3+ZNmIMNCqeRjDhFLcAbcslbVpv4w/KtayxgbBr0eSHFyBG+OxzE4dOKtWs+nElOahl3FXyu5T7wn+5J37kG6O3RwakkJcrvfyep4sm2ZfcWzky8cETQjVqN2fQWEX0UoxHQi53BIyX8RIX/QlxBjnRnqeebYYM89Ln/h9oP/fjkR2O+vLv4CA1l0BMXdt8lBUR0ORK2ynfaHWPhYndE2FwTaO+p4C5KfYn+w9AC1Dg==
Received: from CH0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:610:33::32)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:11:53 +0000
Received: from CH3PEPF0002457A.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::76) by CH0PR08CA0027.outlook.office365.com
 (2603:10b6:610:33::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 13:11:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0002457A.mail.protection.outlook.com (10.167.252.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:11:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:11:35 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:11:34 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/2] net/mlx5: report HWS counter pool allocation failure
Date: Wed, 11 Nov 2026 15:11:23 +0200
Message-ID: <20261111131125.14398-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109125740.4034743-2-mkashani@nvidia.com>
References: <20261109125740.4034743-2-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457A:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f2a825-7132-4195-435b-08df3ff55ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SGTpamj4ZgaCk5Uh94sM2PNS5pa7Qi+3eIlslIiZT65O5lAFDm42Z21dRdiI7uCNx7YHcqNBvxsCPBjLIyau1ehQDh/9BtptCa0GJDwypTglHzj4tDAdzncZjOfQrusjqhDsqdnrB9M3cKzYVxHILNARPvocYOz2XngKIhoSEih4ml5seb5rENqGyYymHk7kqcgkTcly88iOFEHfNCzoLPMJWgCQawDDzWB3n8ijvN/yxia6HegYtRYYk18q2Xtwpa793qbwkhL05NeJFjnClI8jDGwmrbBVG82tRgwav4VwFeplf+CWK84hX4TNS4AayMXSYfTavgIM9vbeyWusXvOQnh7zUNTLXAnOfMYTnfnK2A2D1rWo2VfTeutAi34PFs7tCs7ugb4x+3s4LhYgQ5+EYkIMXl49Mtd1XABrBoT8aVnz/DkgrhOWBXz60DIIcqljA4Ojif0WnzlaTjjd4vvPsenH7ICuAB/Gh/5aZVP7S8qqKG7cENQzAiDpwm6FhhxMw2ogvrfWU6i+8Pkl80z81CEzOHi0osziKDSfI2+4Ej05lbi/ZVSae7WmVa2J89hfM9Le/4w0WTH4J55csKIcD/cPKefzSURdtjcXHD9OfbTLGqL7g1VyHM5/fLcBLOg7n9Vg8OJMFQkX2od1e4910kJW06f2Yt/GtkDsJW98ErsffccQbHqja8k0xwRtVtirU6PaF9fiF00lD8h3bA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hFUF5ZrMXc+d6FnzKKAjoOrcLGgY3ivtIS17F6kvgx158UIRBDTuIoBdEpb0N6vSDyRnboWK2eAZooJViDKfEwt52qtjTxrpsAKJYPwHD0l+dq/C2Pb2etV7Qnx121Xsd4LqZ8jxmjOEShPulXAoU1/cHmRIW1A4nixZ6E0QszYnAPTzIMX0wxFDHOR5sbqIPXM3NKPp4au2yhLGT0GDNmxEvSXAV4nY2tyr0dWD1Jkr5ZSBB9CLF5QnNv0b+mTx/s1ig8Bsdv8ffU5jkmQpZelDj0X3CbQ2X3opIOk7GLTopbYB7xLq/ZO5Zb1XO311Dp//nCX1BheP2kTtSdNawEn/W1qkeojc5MC7JVToJyBWJo1xgTdI3s98Md4i/Rzk6jtXs8RnuCUBsrF6XvAN88gwHtD+44MApL2DnqKi6lquqo2RkJWrJLDFKQUDxYge
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:11:53.2089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f2a825-7132-4195-435b-08df3ff55ae5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch applied to next-net-mlx.

Thanks,
Raslan Darawsheh
