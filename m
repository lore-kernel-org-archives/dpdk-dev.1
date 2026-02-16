Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C166E7BDB0
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 12:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F41A40289;
	Mon, 16 Feb 2026 13:52:35 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by mails.dpdk.org (Postfix) with ESMTP id CD1D640269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:52:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMwhvtAvVJuQxgugfDBsOoL9KVIi4Zhb0LPplGGzO4pAOjAWwkc/ul5kZw5EuOq2wELZGagtUvI+sHI1NACQfYykuGCLpNYySA3LZu/2+Vqs/ju9t48fieGXBaadcgv2sdk0SsNP1Sb/aOkS+xWRBgVGKMUqA+b4WwB6pPhZhR5i6tI9I/nLnyzwvq1ZzpL2velV4wHPdKATl2P4rLJhWedmj2mjb7/Rj1CCIzCEeFIKT3ZmHpAIoZBenizpPlX6QNG4pY/PhX3cp0n+Odk2jR49uOXHEk0Jro4JQboGrmaFDsbdCpoFWhH1FsNn1AcW/h93Egd5eb5Q9nE6KCS63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=preHldYUZ+znKVBQ5UpMoWkkJWzHVrZ1ReueBK1XNKA=;
 b=U+7K9m75bKN0E/V/Lq6KA1EEhTmEVz6mszoqy18POXh74SzMqQU1fli1wYvPGIBfi8ts9pAMR9Gy18wJNIHi2JfHXH2TSSBss6DBTOWHbLnyBb+peOTawodYESSVXMpyRZVQC8elkEbQobp4FN6kyNV2lp85qJFlpma0T8zxGM7IsMdeCiLlF62Td7tDUPmmrSGuCP2Gx7V+G5jTpnVj13URSTGeG18N+OkSHnutRHdKFqDhoRJMdC4caJWPmftNWDSW1j+ghrze2uX7sYNxYaObwmr8Xz5EC38eP5LFciROPgfISdlK5mBna8B0sBY20XjxuRcoK71dnhPhx/Wt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=preHldYUZ+znKVBQ5UpMoWkkJWzHVrZ1ReueBK1XNKA=;
 b=HbRaiIyZbsniAjey3BR8kTTudn0XbOIV2mj4pMny6RXWNcibXZgx9eZ3J1pTF6jRj4AOZvjMOPcXykv39uj5oKfVVYOYe4oOtUmjSjOUMgvsCi2EAEPlAxE1P+JN1CuAWQkPmAMp5+4OUsj+a0hNoX+pozJJprrT22sg9PPsqI0=
Received: from DS7PR03CA0306.namprd03.prod.outlook.com (2603:10b6:8:2b::14) by
 PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 12:52:30 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::f3) by DS7PR03CA0306.outlook.office365.com
 (2603:10b6:8:2b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 12:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 12:52:30 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 06:52:28 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH 1/3] net/axgbe: Add external PHY read/write functions
Date: Mon, 16 Feb 2026 18:22:03 +0530
Message-ID: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: fde8fede-24d9-421e-3533-08de6d5a3ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU9VcjlPdkhkd08rb05HU2xwQThGTDFnd09aZkpzL3dzOVVoU1FYVFpmWFdn?=
 =?utf-8?B?UERoUTJrd2RSdTVCa1hQTlRnTlk3U2dDUG42MEhSY0dwcDB0QXprU3pKZEx0?=
 =?utf-8?B?dUpialMzaDNVZ1R6bHV1SlBzOFpjK0dIK1ZveHJFMVY3ZjJ6bHZLUG8yNmRw?=
 =?utf-8?B?RzJtdXBjS29mQm1FckdHQkZpN0pOdFRqanBLb1ZudE11ZWMwL0REbTNlL3pa?=
 =?utf-8?B?dEFyTWJrOHhaKzJjREM0WUVRQWowTy9ZVzJpdkdTN1A0RHBKTUMyZDR4R3h2?=
 =?utf-8?B?TDZQVThabW1PdVdMY2xDNUxyZ0xRckMrSzNUYUxTclUrZ0JUcHVzcUxjMU1s?=
 =?utf-8?B?a25Bb2xIYkZxQU8rYTAySU1VNHZjSml4VXZEYStkeFhXOGsyUVloZEVSTHRM?=
 =?utf-8?B?dit4RWNudWJoV05tT1l3VmExdksxWUlIUVpMV0ZpNXNoZW5QdENVMDBRV1BE?=
 =?utf-8?B?T1RjL09SRENNc0JPYUR1ZnVhT1ZWVldzeGFSdXJHU2xjakJyckdWZ29rZDlM?=
 =?utf-8?B?Nm16WVViWVY1ZGoxRlRGaDVsSUFRTU02OFJ1dE9Pcm5TV1MyZkg3MVhsSVNp?=
 =?utf-8?B?dnpQTFMySnMxN0Q1bTU2anYwZytsVzRuTWJPLzVGenYvQUIrN2xqYmJESXFp?=
 =?utf-8?B?UkxJWGZoMDhYbUJjYWZzWExpL0wzMktaSG83YUxrbjZ5VHVIYklXQ3F0cjJD?=
 =?utf-8?B?M2tIUW1pdnlreHJ3VkhKaWtwQlRIZzRzeW1xUWlQeUUraXpGTm5ZenJYZmo4?=
 =?utf-8?B?YzlYc2pXUzhQSmxTUWJSL0F3MDFVN1JPTXo3RzZ2dnVvU0JiZHlHdG15bmlv?=
 =?utf-8?B?NG4vcWZOaVp5NzZGLy9YWThkR1hCYnZIY0dkby9JbkR3NDZKNlhKQlZhZDhu?=
 =?utf-8?B?ZGdFQ2hDZ2xGWlNlMTRCMitOSHB3RElraVlRQzFoQzJvQ29tS2hvbTVQY0h0?=
 =?utf-8?B?TzhnM081WS9ZdWF2M0hsSUJZQ3Q5SUpGN3NJYU5vUjZwNm5sdHcwQlM4T1hP?=
 =?utf-8?B?TXM4U092dUx3WDVMZm9FdUphYzBjK2o4cDBIQmZ0WHlxeTNzSSs4UXpFa0NE?=
 =?utf-8?B?dlJZMi95aWRuVXFtbjlzZzR3MGoyRC85T2wxVEJuL3FCT1FJanJnZmNOSjho?=
 =?utf-8?B?Q1RsalhYemlpV3JtNGNJWVJmZ3V5UTI3VVNpUHhMNnY3ZXQ0YzB5VXVBMjBI?=
 =?utf-8?B?MkdtdWZzaGNlemxPOG03bkdYajNKMTJQRGFpbWJPQUlqV1VRZGlVUlQ0L2dz?=
 =?utf-8?B?WFF0N3ptNkNqTm0wZ1NDYVpIaFlFbWZUTUNPY1VUV1NhQU1rMWo2NHpPS1Rv?=
 =?utf-8?B?bUFxN1JMQzdxaEFPM1d0T2tDQS9tcTBad1ArbTZvODFKMEtNZmFGcVgyek1k?=
 =?utf-8?B?SDArWExXRXVtNXlmUURHeTJXTjRrRmlVOVkyUytnYlVvTTBseG56ZXNuUXVm?=
 =?utf-8?B?eThSSm9aQVZudHkrUU9XQUNmNXJmWjNhWFVydWRPMnNXTXRlL3VDZU03U09Y?=
 =?utf-8?B?aUpBUmhoc0t6TXdRWmdvTmtSaGxlTU8wTDFkb3ZhZ0k0eTM3QmNhMFgrQ2JV?=
 =?utf-8?B?OTJlY2RUNlNpVFNqR2hrd2N3bTY5NmhMVDdvbkhaZEFnZUJXdmgzOHFkT2t1?=
 =?utf-8?B?RTBOQXU5ZU93UTZtaHp1NU1ZZGtibHZZV2NvQTdzc2h2Vk9pTXZVZFJZaXYx?=
 =?utf-8?B?bGVtYTVMTkxhazdGaEJQUmNJbkRueGhOaFNvYVowbHFCZWkwWnF1L0s2WkVy?=
 =?utf-8?B?TEc2TE4wMEpGeVg2MTNTangzNlAyRkRldERiUnVnWFRXRmc0SmVFTDQrS0sx?=
 =?utf-8?B?T2d6em9TWGp3RGlldG14STRBYTRjMXZTK1I0ZmJBSC83R0xuSVBDTDZvVVJs?=
 =?utf-8?B?dFF0bnVLT05BRjFoTFpNOVRGK1kwdUNvQlFIblFuMzlBeVJ4TXkvdGpRQWdv?=
 =?utf-8?B?enBIN2g2ZnJiNmdxK1NhNWgxejdYSVBOQzlzd3cvVzJHM2libUVTREY5TW9h?=
 =?utf-8?B?T0FUa2FhMW5wY3luZVhXTVBWQlM2TWFQNG51aHcrVFNIY3FqT3c0VVUwS0ZQ?=
 =?utf-8?B?VVNURWVNcllmcVpCdE5jQzJFNXZNdTc1VDQ5d1p3a1Fod2VJZi91SFlnUGZH?=
 =?utf-8?B?ajBlWmZMZC83QWE4OXR4aXBPQ0Q3T3VZWSt3Tjh1N1h2OFJqcGVCNjZTNXlF?=
 =?utf-8?B?WGJMSzRVZjVZRkh0WklXYWtockdQS1k3M0FJTVJPeGlNeVBHeXhMTlNDS0M5?=
 =?utf-8?B?WnpVVFNibHZ4ZHkwaXpVcEMya2FBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iIYMxCGG91aK+tC03pdB9rshX6jk9XZgLCnjqY/S0XRXutREc3fKYkSmhjP0hHthIhGaATJHWfGDL6WDcBc8hRnXHfj7S0aVZQl7xYe1bEXbBaOzU1r3jO4F0Htk2Ru5Z/d8RSoCr8riwwMcfpZju3zj0xygxDvxW/LobOt8BMcylW682TakWE3EenzJzPC0sTYpscvN/Qo65IPG3RC09YGCiWdradDQtxlSbz4tudvsBHFtmj2/VWAhuU9EYhCmiw8j2pYX0KYHYv1EvAqEVIpv9HqBJXSVGoo6LH2JYQTNn2b6tUpCywlRRgT/WpagYerqbMVIiWRzxTc//vxDkWRf2ue25et//GeJyocXxNwnRaXKPXRwHiOTR+yj2ejjTkVvAlE5EJfskJra3CwPjEijjw08loIKANos9ecZqsPSeYIGCC5QD4ImB9XUQ/5X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:52:30.1274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde8fede-24d9-421e-3533-08de6d5a3ed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

Introduce helper functions to perform external PHY register read and
write operations. These helpers currently support only IEEE Clause 22
PHY access, providing a simple and consistent API for accessing
standard 16‑bit MII registers on external PHY devices.

This patch does not implement Clause 45 transactions; support for C45
access can be added in future updates as needed.

No functional changes are introduced for existing drivers. The new
helpers will be used by subsequent patches that require external PHY
management.

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 .mailmap                           |  1 +
 drivers/net/axgbe/axgbe_ethdev.h   |  3 +++
 drivers/net/axgbe/axgbe_phy_impl.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8bbfcc1703..6f951bcd92 100644
--- a/.mailmap
+++ b/.mailmap
@@ -165,6 +165,7 @@ Ashish Paul <apaul@juniper.net>
 Ashish Sadanandan <ashish.sadanandan@gmail.com>
 Ashish Shah <ashish.n.shah@intel.com>
 Ashok Kaladi <ashok.k.kaladi@intel.com>
+Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
 Ashwin Sekhar T K <asekhar@marvell.com> <ashwin.sekhar@caviumnetworks.com>
 Asim Jamshed <asim.jamshed@gmail.com>
 Atul Patel <atul.patel@intel.com>
diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_ethdev.h
index b94a7f3562..12d77cd520 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -398,6 +398,9 @@ struct axgbe_phy_impl_if {
 	/* Pre/Post KR training enablement support */
 	void (*kr_training_pre)(struct axgbe_port *);
 	void (*kr_training_post)(struct axgbe_port *);
+
+	int (*read)(struct axgbe_port *port, int addr, int reg);
+	int (*write)(struct axgbe_port *port, int addr, int reg, u16 val);
 };
 
 struct axgbe_phy_if {
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 9249e11335..4f3cc63836 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -251,6 +251,8 @@ static void axgbe_phy_perform_ratechange(struct axgbe_port *pdata,
 		enum axgbe_mb_cmd cmd, enum axgbe_mb_subcmd sub_cmd);
 static void axgbe_phy_rrc(struct axgbe_port *pdata);
 
+static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata);
+static void axgbe_phy_put_comm_ownership(struct axgbe_port *pdata);
 
 static int axgbe_phy_i2c_xfer(struct axgbe_port *pdata,
 			      struct axgbe_i2c_op *i2c_op)
@@ -258,6 +260,30 @@ static int axgbe_phy_i2c_xfer(struct axgbe_port *pdata,
 	return pdata->i2c_if.i2c_xfer(pdata, i2c_op);
 }
 
+static int axgbe_phy_mii_read_c22(struct axgbe_port *pdata, int addr, int reg)
+{
+	int ret, regval;
+	ret = axgbe_phy_get_comm_ownership(pdata);
+	if (ret)
+		return -1;
+	regval = pdata->hw_if.read_ext_mii_regs_c22(pdata, addr, reg);
+	axgbe_phy_put_comm_ownership(pdata);
+	return regval;
+}
+
+static int axgbe_phy_mii_write_c22(struct axgbe_port *pdata, int addr,
+		int reg, u16 val)
+{
+	int ret, regval;
+	ret = axgbe_phy_get_comm_ownership(pdata);
+	if (ret)
+		return -1;
+	regval = pdata->hw_if.write_ext_mii_regs_c22(pdata, addr, reg, val);
+	axgbe_phy_put_comm_ownership(pdata);
+	return regval;
+}
+
+
 static int axgbe_phy_redrv_write(struct axgbe_port *pdata, unsigned int reg,
 				 unsigned int val)
 {
@@ -2542,4 +2568,7 @@ void axgbe_init_function_ptrs_phy_v2(struct axgbe_phy_if *phy_if)
 
 	phy_impl->kr_training_pre	= axgbe_phy_kr_training_pre;
 	phy_impl->kr_training_post	= axgbe_phy_kr_training_post;
+
+	phy_impl->read			= axgbe_phy_mii_read_c22;
+	phy_impl->write			= axgbe_phy_mii_write_c22;
 }
-- 
2.34.1

