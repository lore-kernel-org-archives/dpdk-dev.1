Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE28BE7BDB8
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 12:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CAF040647;
	Mon, 16 Feb 2026 13:52:54 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by mails.dpdk.org (Postfix) with ESMTP id CE06F40647
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:52:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK0yWkO5BaTaP2O+ipZz1bMikiSEheRj1DaIbeuNN8XwGTdO3N0TaxnuGlHnEhGEmxEHK1tvt+MjuhqxdHM8MdH9MTnhHPmdxc90MKz43kp242ha7rayeZuPwpVzUNf7a9EqVHtpWjKnAaJqUSihQE8vI/g77Vi0rEKJ0ewkOBzOaOhtVOX5UXk3na510kkyHl4FYNULj8rR/9NQjXDwPbMTaAGaBDD0UOeHtb0QM1BJePlrs7vKiuLtpBHGjqK1tzTtJGIiT+jb9wTonXhTHIRB1756e8GHo8929zrhKKwZPWvcGxLy5qSI8f+GBLAExkZAfzTfw/Zkq7agaYlHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzH/Nb1B8y1zBM0GhCG1R75a7TARhIfwX7m4WoPNWEs=;
 b=sx++b2INdoy4I269x40PL5E9CikViC+mxzVOJAqsIlcLWPuKfsAlCsSsdAH+XhsUoasFakrQh49FyzBCNJnRdHguGGHpnFq9gfNKVnSqQ2r/J3x7xSEIgznxCccBPLCeJ4fvS3j3xLHkF4k9pP9/iFNsRTO9SviwKFiUMHzE0DvHXEogMq+joiQaFUzw6NC4RsGkgPC5iSqh1inAJuROVljSxKMbloIMGekIiaxOalomHC98pw6UT0hTrmuEzi/6pYcp/0nPyXpBkOYbpB3uWOJdlArnhKG7OzYcmhyEgplwQWvdURhHettZ1fWo5/AafAxlgL603IL5/GZtwlp3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzH/Nb1B8y1zBM0GhCG1R75a7TARhIfwX7m4WoPNWEs=;
 b=fDbgMzJ8Ki4OE0Rz6hTvzSj5eALwK09Bx9IDXAtnvdPBpsDkMOvw5bLCoGanEv1BXtr9SVgUFYhU4BCdiZ84315hstLJsi5tOX/O6J2tEAWryLlhAEkG/aNnYLxAgQobldchqT4fto8ftrEC+H+pO/UiCEcHfqwKi6GhCN58OvA=
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Mon, 16 Feb 2026 12:52:46 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::1b) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 12:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 12:52:46 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 06:52:44 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH 3/3] net/axgbe: Add support for 100Mbps link speed
Date: Mon, 16 Feb 2026 18:22:05 +0530
Message-ID: <20260216125205.1032-3-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
References: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 67006c06-d4ed-4898-c75d-08de6d5a488e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IldoEAV5hxmD1iZZA/x65zDtO/nHV0K8ewdP6XMjaBugAhgM24iKxDMXuVSw?=
 =?us-ascii?Q?jiyUmNEFSWTOsyXuC2RVfmB/ft1zQG9L8X/MtLe48pFWs9+zSZTklt9mAe5J?=
 =?us-ascii?Q?D3EMyPA4aOGOAGNT/f5eoO20HZZH3DNPOvzz0ijGE2jLuEVPTrE42MgPgdqM?=
 =?us-ascii?Q?yaf79y4dtuC2hYIhIuznqqEk0iOYAlgl9fIwgzFpumjqBld+Br5iIWchCyAR?=
 =?us-ascii?Q?19XCqACxPfkSkNRwcuDXWqxMgWfvI58oSd8AcpCXWMvbXZWpYi2s+uGtmEKz?=
 =?us-ascii?Q?TrWVVxgUaRtCziunRzQFhylKjUDrnvU0fbpM0WB7qsQ5QTImZfjCbQGbhd+P?=
 =?us-ascii?Q?I4tqzdljahaeciPQsVe7VnLqKQ3PM96KLjZj/KcorXJAP3foZ6z0eahU0d4A?=
 =?us-ascii?Q?4aX3skfasBjEsaNSAgV7ip0+cbN2uhP9Yp4TemjizIMIRcXUIkW5rzjohKQJ?=
 =?us-ascii?Q?gBYgoghSLf9He4vN/DN5xRdV1gRKOxueEoEWTLgbQRxEoeGwPQNyRPkjYRq5?=
 =?us-ascii?Q?DELptBhiRQ9LN7zrWZ1FanFWyUaQ/0JiiLEbmFu6gVj7MvwTQlnBFAeRUuaV?=
 =?us-ascii?Q?FF+PwNATQCLDwuO2m8RWVMaVcZwZe1a/28II0wl6zHiXnhH/1FfSUQX5ojMw?=
 =?us-ascii?Q?MXTKAqUGP/uYFa4kJ6Eb35+egb7Y5HHgQvXdHnSxHm//KdBZ0Qd7hRPz+9x0?=
 =?us-ascii?Q?SKxj7qZ2StgCciUxrI+MgCE4KeMbMl0eesdJs3tRonGDo9adJoYVtAi7qMid?=
 =?us-ascii?Q?GsX50t0K7iziaat199M6eVmF9IvJEBw3XXos1UzwC/oIacJV3v0dJQ7Yollx?=
 =?us-ascii?Q?GQsl1GEbeafBbW6MhvjsTq5ZP0ruTTzO0x+htOmdkVAg2cfgsNRuY+34IMeM?=
 =?us-ascii?Q?x3naYWLklnJdhzP6958/pGf2I3VhczZU/vaKxfoB8kDIvuXoEbZrx0ZP3ZEo?=
 =?us-ascii?Q?YZKFaFhPc7ROOrUwJveUnj/sdZo+4JnqAFef3QRxzSPpqHeqBbiw3YHShAEd?=
 =?us-ascii?Q?21dv54OmPijIqZ/4tsfrvcQRynzL00v8umI2zcjZEwNRmZ4KASfM4ZyRbBUS?=
 =?us-ascii?Q?S1Fu8nIRZFXJV2menaD0vA2BnfAvNkDdXK4gTtmNvjFJlDoesCwXVkxo/imB?=
 =?us-ascii?Q?Cl+WpYIrb6z64pi+KavOvth+jtTGTy+gfeMSghYIvXQJeaFjl4XE5SlTOr4b?=
 =?us-ascii?Q?1GrRgJOHlvOIkeYJ4nfi7ZSR/vyP83q2Cqm3pmvK3Eoe5U7Lzee3TFBO0WsM?=
 =?us-ascii?Q?F4rlH+U3F1wEc+laPxW/ZDKhRFBjXFu83xwXbSxdh09rKaRyUkd6qQplSbAn?=
 =?us-ascii?Q?mnOISvjIboy0DEJ+lhgXFbaVCzCurZKLaa5hLwgPmvnjvgLhdGTVvlh+YCw3?=
 =?us-ascii?Q?G6Ik3Y8gZg2c5lgLkP2IMvewZV927FqS9EVzJnXfE+MFiG/wfM+pklm7IWze?=
 =?us-ascii?Q?oB3L2NDmMcbpGVj3gm2EQh29urvxsdGG4Ybm/kGNAA5ZS8hhF9kVgFTDVgeb?=
 =?us-ascii?Q?m9c5OQ/F+AGZGOECNwJJ/7o0lvptneF43v8asC1TX19DBkVNy1t4mulxjnYO?=
 =?us-ascii?Q?yKAP/lpu/6VRaToI01yKUNwcB96H+iZTk+ygrZB8BfdXO6B71xblNpuekg6a?=
 =?us-ascii?Q?/KvkFFZFdLbySjywOF5eDH3LBI4b4ig4P9+kAZRwVAs+y52X3iz8dixdJlej?=
 =?us-ascii?Q?MsUWHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lA/FcXNsIFA5qUcAf3O4eGN0Bvr3jr9BxDKmQkrmHYWQ2lAFJ3q/SJmOf4RTjNJ6kBY7e+FzBIbWcFw6fIW5g7Xq21MyAdu+arzhJyUZi/ZAWhXuwWuy0q6ZY1UFZ6yTnSYOVrm/UseLCGFmxhDEOaptIXcnYGTZWqfTxEYNZwOMS2Iccl9Xlw5cicjTfWcpgYYMYa7qHjkcRHfIWVsZJ9buiOOxkE6gya5DzgaycUKdhZrhEKDcJPLFd+3BE05RjukRTf8KPTFCZctmRQRCoIiUxvUK3gHxPuaBEP7pn92wk5/BCJJNrA7sVVS+fJatXElnEXOzdoYFKRJvGWRXFSHeYEo0UDOILk8nExHxacJ/Q/VWT7Cqrr818MTNZlELNQFfgtGsGsS2koHTGp77YxQtgejqOzc5Oj0K/fP4bUH12NMHHeIn4QkcWKYhzRGC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:52:46.4209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67006c06-d4ed-4898-c75d-08de6d5a488e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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

Add 100Mbps link speed support to the axgbe driver. This update enables
the MAC and PHY configuration required to operate at 100M, including
proper mode selection and link handling.

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_mdio.c     |  4 ++--
 drivers/net/axgbe/axgbe_phy_impl.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_mdio.c b/drivers/net/axgbe/axgbe_mdio.c
index 952a0add62..a37cd8b80d 100644
--- a/drivers/net/axgbe/axgbe_mdio.c
+++ b/drivers/net/axgbe/axgbe_mdio.c
@@ -155,8 +155,8 @@ static void axgbe_sgmii_10_mode(struct axgbe_port *pdata)
 static void axgbe_sgmii_100_mode(struct axgbe_port *pdata)
 {
 
-	/* Set MAC to 1G speed */
-	pdata->hw_if.set_speed(pdata, SPEED_1000);
+	/* Set MAC to 100M speed */
+	pdata->hw_if.set_speed(pdata, SPEED_100);
 
 	/* Call PHY implementation support to complete rate change */
 	pdata->phy_if.phy_impl.set_mode(pdata, AXGBE_MODE_SGMII_100);
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 20cfdcc796..3dbbee15b0 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -1534,6 +1534,18 @@ static void axgbe_phy_sgmii_1000_mode(struct axgbe_port *pdata)
 	phy_data->cur_mode = AXGBE_MODE_SGMII_1000;
 }
 
+static void axgbe_phy_sgmii_100_mode(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+
+	axgbe_phy_set_redrv_mode(pdata);
+
+	/* 100M/SGMII */
+	axgbe_phy_perform_ratechange(pdata, AXGBE_MB_CMD_SET_1G, AXGBE_MB_SUBCMD_100MBITS);
+
+	phy_data->cur_mode = AXGBE_MODE_SGMII_100;
+}
+
 static void axgbe_phy_sgmii_10_mode(struct axgbe_port *pdata)
 {
 	struct axgbe_phy_data *phy_data = pdata->phy_data;
@@ -1731,6 +1743,9 @@ static void axgbe_phy_set_mode(struct axgbe_port *pdata, enum axgbe_mode mode)
 	case AXGBE_MODE_SGMII_1000:
 		axgbe_phy_sgmii_1000_mode(pdata);
 		break;
+	case AXGBE_MODE_SGMII_100:
+		axgbe_phy_sgmii_100_mode(pdata);
+		break;
 	case AXGBE_MODE_SGMII_10:
 		axgbe_phy_sgmii_10_mode(pdata);
 		break;
-- 
2.34.1

