Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF6DCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:51:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33D6B42796;
	Tue, 29 Sep 2026 14:51:49 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9]) by mails.dpdk.org (Postfix) with ESMTP id 7452F427A2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:51:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUqIRqK9jxFOWUkKHCoG+VOptr0qxA5wI1cy8htkPs4A6rTGaRY/FUdQldcf+D0xY4XGvZmknPt8DFD9v9oIK4LsWBuNJ2uNueuVxlvCI//n3i4zPK28bkcdYzWIlRAIfXRK4Eap9zad/ngmeHtMzrj4RkiRymEKYTgo69/ccOZ6bhNFjeHpXAWox+uj5FGgw24uP1z8s5xlyBkaRi/FpLKysbRmWiqzsv5/+J6xN3bOKfOznVqFqCWXVFrD7KGiNOykdVE2FTOPgd0BGFHTe0spdKUejbQ6NZz2PggR7mWHu2LwAJ5B7ryIC5FQ4eImK1IbqzaoqmwuRjgCybvccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdoHobEDCmOKMe5nF1WFdqXBcapqRA9S2EdVAd47G3g=;
 b=gE2ng2T0ELzbbLn9QcdyXrgLHUcB8ytNyWyv6EwJfv/PgubdIwGd8hYmsBrqM60wTYrwpfIO2txkyRh3jlMWlsp1MwnTHr9+md6kEfPsTqHmqPKvKFzrLihIHPMWB1QKQuc/LIIgbNtIG2A0oO4pKADK0rojrl9xBiV7gsUnA/ZeFtEA7tSYB6JcVWQ/hMXAqa1uU1j6FUsqfoB37KEwTJ4b2cSUvIEeyJSJTv7chhTt+d57ZXIGCx0ZNtCtTZIIk+3KLvRyDi+r2zAwnXxQ7J78N6RS/ekx6mW0g/HykIoRufnt0Q1dp1cN9eyG7KrxooxLKeqgjK3hVlf59bWfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdoHobEDCmOKMe5nF1WFdqXBcapqRA9S2EdVAd47G3g=;
 b=M2LxM+I4/4U+idxixgOyGt7PHyXX0s0nbPVMQ7QLtpAurgOT3yB82qbhJmJFiZWhhw/6S2gkhrt4GzqTyRMdUGlgyNuizMs8hlAGN4NKP5VppIypmz1QQJ+bo4fSX4oFUVab1XxUN0LWLz+DxW0Ae9Lx9jhMtewzuy3ukYaEHKEzKgXJo6t3ZB92ZX9o5rHEWDblnDG1ufCbS0UoqWISZTiSO4CsZtX+EF3bWd6u9GTaEKDiweATp6ZA9mIyHBerwhbVl+KCInSTvrlZC0aD9h/+JBCDfug2N/tACnLP+ixvZy/jlctPMDjiNiTEuUqS54YwzXOMJpLyzLw+y0lP0Q==
Received: from PH8PR02CA0001.namprd02.prod.outlook.com (2603:10b6:510:2d0::19)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:51:39 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::c) by PH8PR02CA0001.outlook.office365.com
 (2603:10b6:510:2d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 12:51:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 12:51:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:18 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:16 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v9 4/5] net/mlx5: use bitset for tracking MAC addresses
Date: Tue, 29 Sep 2026 15:50:52 +0300
Message-ID: <20260929125054.85048-3-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924063836.355745-4-david.marchand@redhat.com>
References: <20260924063836.355745-4-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e0eb91-53f7-4494-65d8-08df1e286719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: PX4Pn1RaTjt+xHZctZthZOpfyquMPJcn5aN5d5JQgDJMzLNL4o9YRM3bw1B1rqK7/aeWQe21CqGqBnITihp0lI2iEtYJDe/gYQL/rkxmV9B8JVL76tOTxuzZ4O19sa/PYDYXFnbnNYO722AUvxXKW9jY64xHH5vcOg0ZzaQpSlbYuvyw7RolBPGrwY+wQjsXnhIZBRSPQeDSiavXeUIKHbcD6i3ciI/LK7b14n7dW3ILMwJYkv4fGUYmSrl8u796bvSxeqc8oUBKM/pggIRZ75VSohQLMJXxuv9BcEcHKpbnd1tnkpZGwdWKaif4D/MbNHY2/ehcEuRR6xZKuTKG2+tPfzcPpp1dyduCqrF9zhGO7onzJ/7e8/oNhtl5JmlFfRleGpiDXh3M6trpk+1M9n3M4TL1LScfihoIf2ktRxx0nxn8z9fxHaiGfkzqPDb6nu04Y0fowlBqedZoJGPEpvRWlSQE90pushPFjfO22psTu8qBYACz8fkBjhAj60uGe28UaaEcI/tKElELa77ksncf1zwjg6AAR4qLp1q9JkaMLsXsZhHsmR5ayzG4ERroTuxory0VcG/Oy4Gf4mcCE1ogbP58WP2HN76fr2l5fJKQSs10d5DkcomGAneI/RVxf5MqftJsmq4QD/XhX1nOBYyQhPDUKSkDl9CGJBJSAfhWUExWdaSqhK7hjCdEr7t9CXSZshtqctMNMe0T4u0Ung==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k/wdERwM9wXcSPJS9A06WB2PyaVIpQjUKhw3Bwbiv6jVY1kaykYPgHJAtyVox+bAu+lGbApaqu5xP8ZY3ZjQfoNQIW6UdrEnQYKwrhxPFNxSx9qooiwNRGGF41Sv8Vwdu4p+8KhXt6jaDpRo/YEdJPCgxmsC4IUfdpV6YksaRTIjhZK+FkNWUKX3nvqkCL4KaSbKl1kqRviXXpeSnx44KD4QEaq+zNoVL+WRbu+65Fw2KU6/y0YGVWE2bI/kRKFgxYJD3XYI8NXZlbnpoDet665WjXgIEOaP4GeL+UrqCVEeEIriHsRWPkIA4pYiI4Pnz/+X9s2vQTnsuZGgjL6TVw7R0dwWR8IOJKtKTB1X2szrx4kVclZ0RgEtY+W84aMd14Nwd+yBSHpXeHjJVgnKXEOWaAcB8CpPMmWVJZvV019MJ5iTDNQyksr+p/mNzFoo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:51:38.5067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e0eb91-53f7-4494-65d8-08df1e286719
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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

Acked-by: Raslan Darawsheh <rasland@nvidia.com>
