Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474A810ED666
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 12:21:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DABEB42E0C;
	Fri, 27 Mar 2026 13:21:03 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by mails.dpdk.org (Postfix) with ESMTP id E333142E00;
 Fri, 27 Mar 2026 13:21:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdDEHtSw84VIuZS4cpCQHj5is3jfrNAb1yQTevJD1oQWPfmTmYlMADxPr557rhgVMV15mtk8rBFBtHIbB6UFJ9x8NJa3lATAnXnYgPzwN5XtkTRGpnJgjlgCxd5NuT9yDTqOt7wq1o9JLtFfnCGhY4lM7twcSCcdKY4vpSNxgwErfPWvUS1ma6XXPr8LabWnPR7kqifTAhqwoqzH3v7e3wvd1c8cV3NNwJ07jDNkex0MyNlTcsHxGjV69M5/hAJZK8C9T0gChVGawfP/kN1VPCHs3RAyOP7Tx+yrRdb7viSjk4tz8vCkZXkw2c45IceDypZvMLvZe0qcyP7TJEEP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkrqVgUx0s4BJ0pqjvuclVAyp7yMQQE4bdmfHUY1e0w=;
 b=M+2t43kZRKoTm38eNxJHHFr1zvngencElLhsD9wBjUeM2GxF3P2B/buvDdrBcZlIyKkZpzieiqLt74+HLCVo6xAT0bbd7XA5foNCOK6BwklBPV/fjyixvy9xaV3+DyxAYzkBPPpiFMYD6mr6d6gl8L3AnkSOT3qPlZu/xEA/cQbn+uoX9nnmJ5iZVFZZOD4vDkkhmwQLzfVa59dXHeO4NddZqQBn2Ka4bv3hYTVSy17ZcO1sse6lXenlNNWSDgPY6Rw1ChgjcTYFBZ7LHGYWq4p+cP1lZQki5tMYFYG5NIrgLXYIQz7Sz9idxe39tyhC73izSPHwiqwd8Z4DXB0f1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkrqVgUx0s4BJ0pqjvuclVAyp7yMQQE4bdmfHUY1e0w=;
 b=zx2BeinLzk/mfntsQ9Xu5sXrzQkYfu6H02FR/Tr4o+ektiwKyB6QzM0+U5Tgb6SveWQLsfYdWnAFZqLbOfebAPjeSZzYIoK8zQfl8VUHYlbp8OUMchigsIkpIsWLXOgVn56hRk0Zl/vRhLkHoUows+SNwoJeowGQUE0z2YiwqH4=
Received: from CH0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:610:e5::19)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 12:20:58 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::f8) by CH0PR03CA0254.outlook.office365.com
 (2603:10b6:610:e5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:20:57 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:20:55 -0500
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v1 2/4] net/axgbe: add 100 Mbps MAC speed select
Date: Fri, 27 Mar 2026 17:50:04 +0530
Message-ID: <20260327122011.1534-2-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
References: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 409187b5-7b34-415a-70c4-08de8bfb4ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6qhIYdqVWGOisL/tYjwfUelHoubaO/aBMJoxbMaWw0jiVU2MlWBOQCheXtAYvNNTUU2PNYLGuQRvJG3E9krqvMm9dzWYTio9yfQHnqOnf1rjztnn4SAqHVV46/eJpWIJ/9mgijRBwWxi9Y1ea4y0BP+PhTWQs2XPhii4jytYRInm9JxdjUtXQoN5Ec2jYYgMdB+QbPYFcjcvlw6958+l/1QcWhk6Yc/rDOiJ7XMzlOgPDNi6U/iRcgpjv3gO/zeIp38z5GnrsI8SYnusKtLhvXrqKU9Qn1pkKF7DdlrulhidOZrx0j0JU7qPZUm6p1Nrg2Vs2gE6JU7OFuGkTmA1co2O8l49TEm+zQUxsIFTLOFEXW+qOFuO2DRiEjub610k725j1TmBgNwo9koYtYJ/1NfCYxImdgyIVcpRXsrP07U9x1W47ATDCuPqhIYAAELhI5Ly2w3yTGqzgjVxfxcg2PK1z6L7qnMo9hMQhy1wEEPOIaniIHr68fUY7tEHcNl2E3M5BjtuWTXi/Ye9WN+rwyblBtS0yyKkP7907AQIYMOHAJZRwcTufemRfy7SjaZwqdIDvvlBaC+GwBOMNppUoEQLOAYCBKhuAHev+08w+5ZgmrV0nnGpTZiCC59QsvmFuiME82YpK8aay92Xcl6dFlrx4Vi2fQD3nBDeuxgBiczThxZdtEa2OhHTO77ur0+ObDvxDw7ChZRsw/A1wnw5kaCAisheD9kWEHp/bo4x1yp7MQb78bZCs+v+4JseaR/N5XWkH68kECwIZ/H7mD5oXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q7F8c4eam1jYrzj4HHHBzXK25Ss6cwtHhRMj5QWgthiitmowGLvq3VbKWI3XOEtIT6ZDnjC8gYTj4/LlFCHCEdKbUSnYqhZ3d/PKzPoZOicIh2qwcPuc4VQ/MTmp9ldELJodePl3CoBPqnevcIKiWeP4roUbDIpNUhVXtDna4XneJNd0GSdpCo84YpHFQhM9ezgCgizSRP1o8ptqUGFiS7y6l1k3sAXgaU2SR9p4SasENLQrBoO7+mRZrg0XFlQmZbbmm75ijgP17EJ4d7bGOD4tvpC9GkQ/+yKxfjEm8/uZL3488VUy3Too4tbDhKp5bQ6+HEqtZbg1ki+IHgW4mzy5yMSCr8iXes5TY0yai08n8QszjTFR4DC5jzRZhHN52hV5/FXk+uUvpVWEsbZ/1nGiTvzkZ+mYN/+KpXgopAhZLVCaY1R38zoJ8KKs7//6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:20:57.6347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409187b5-7b34-415a-70c4-08de8bfb4ce9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
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

SPEED_100 is not handled, leaving the MAC speed select unprogrammed
when a 100 Mbps link is used.

Add the required speed select (SS) encoding so the MAC is configured
according to the hardware specification for 100 Mbps operation.

Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
Cc: stable@dpdk.org

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_dev.c b/drivers/net/axgbe/axgbe_dev.c
index 10a99aeac2..482d3d8062 100644
--- a/drivers/net/axgbe/axgbe_dev.c
+++ b/drivers/net/axgbe/axgbe_dev.c
@@ -303,6 +303,9 @@ static int axgbe_set_speed(struct axgbe_port *pdata, int speed)
 	case SPEED_10:
 		ss = 0x07;
 		break;
+	case SPEED_100:
+		ss = 0x04;
+		break;
 	case SPEED_1000:
 		ss = 0x03;
 		break;
-- 
2.34.1

