Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A551DCD8CA4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 16:42:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8A9140DDE;
	Thu, 13 Nov 2025 17:42:04 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by mails.dpdk.org (Postfix) with ESMTP id F0B2640151;
 Thu, 13 Nov 2025 17:42:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNyaBxDZlxKCPeUFSG9wMQ4rI+NI3lcu4F0xGk/u5NU+jJ2NATxSqAY3GoknAoErX+74WTJ/YRtrEa4k5POMDSKAVfbMq+7r2B+3sMBB/4xiUDH9yN6+yDe7czNFp1f1uORI2iSJlNKX3AlKjKTvlPeaCDqfrZ4peJxJMyfWeWVvTN2GzWLu9bq0DAvNgrFH4DzN48WutIxnJTiygVIEqJqko3Ogab4kGIHELr3+PoCGmNu5e/j5+SZB0N2WnuTmVZabPXJYtS6XnHRlWxO3PQtdi1N9a8wvLlYcjBdZGccoRneW4rP0BsJOAhOSHoPNSBK6QBNGrBccxjtU7VfnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFXlKoaUOx0fS8sTKoWtQzLghvvRBToqsgSV319Y2qY=;
 b=fLYZF/1KuSJYb0WnK/tKnjiJU26VZkd4D7oKTvfP/1UwmgHoIhYunVA47wBZ66d1xxezm3usSHT8YFoq7kbcoUNRqf0rMYSkcz5lBQJT3NtiKdTltWBCi6lGhSSpbRUAniIGprUcJZO6jZ+HPTyR77O7WiIQMjDokZtwdYkzfA0awpKihJ0vnS7gplDyaoe+Dv1O0NVlHJd3px9pVg/KVoOgOiwoDUSDOKwXwK8HTPTezi0IzqlM+qvnAoMuzyIiTiLqtKX/RwOEqLB1x2vXF+059hRGaR9+lQQOFmqESW7qhmYSbYuWbDe639Jhas/DB20vaPh1iHbh8qZveFhMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFXlKoaUOx0fS8sTKoWtQzLghvvRBToqsgSV319Y2qY=;
 b=CaoDp1ouL7CLZq9RkgIYc7EM9lH3uikq7ZsyxG89ob2TZv1fdn4isM44RumXTIRkCjcp86sszGU+wK1XjmdgW34RXaZRDX5YCSXn4tV9do8j3NwRP0aEvQG3AgLFuCPePUl3CcitZ/yhWqFNKUjS0oNNONfbMmE7aSss5FMMnxQ=
Received: from BN9PR03CA0723.namprd03.prod.outlook.com (2603:10b6:408:110::8)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 16:42:00 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::1b) by BN9PR03CA0723.outlook.office365.com
 (2603:10b6:408:110::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Thu,
 13 Nov 2025 16:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 16:41:58 +0000
Received: from BLR-L-VENKANDE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 08:41:56 -0800
From: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Venkat Kumar Ande <VenkatKumar.Ande@amd.com>, 
 <stable@dpdk.org>
Subject: [PATCH v2] net/axgbe: fix the build warning for GCC-16
Date: Thu, 13 Nov 2025 22:11:09 +0530
Message-ID: <20251113164109.522-1-VenkatKumar.Ande@amd.com>
X-Mailer: git-send-email 2.40.1.windows.1
In-Reply-To: <20251113113055.371-1-VenkatKumar.Ande@amd.com>
References: <20251113113055.371-1-VenkatKumar.Ande@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0e89ae-de76-454c-28bd-08de22d39075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXZOM2svbUx2ckRrNXFxTFduR01oZ0U5bnJOQUlhbW5HNHdXTjljYWlFZ1hz?=
 =?utf-8?B?WkVKa2p4d0NIQ0w0d3VUM1FoM1dEZW0vNnBaYUFpUzdjdEFPQmFvZVpiV01C?=
 =?utf-8?B?UkpYZEJGSzExTWQ1SGxGZThWSUxBYS91eXF6Z3VqNFVMTkZTd1VpQ2VTTXFl?=
 =?utf-8?B?NG0rNzFxL3dEZktiOVNMS1dLdUZjaitXaTdRbjdrSjFVczAza0ZlTmtzNW5Z?=
 =?utf-8?B?Smg2SHMrU1daN1o5aFI2Y0t2L1lqa3ZnVHEwVHdsL2ZxS0s2cEtlTXNhd1Vk?=
 =?utf-8?B?cGdpeXdLUmVGRklBUGpYN1JmTHFGMDFja0RuK3IyTmp4NzRJdVNQOHZTZTh3?=
 =?utf-8?B?QmdBTGcyTXRab2lqa3hQb003OTlzcU9nK1JtTVZrVDUyK1VwNm5lSGJhU2xY?=
 =?utf-8?B?b0xqd2tGOEdITTZ0dFZucnRsSFh5UnZCOXd1WDc0THpYR3kxS21NUDRnOEds?=
 =?utf-8?B?R01PNmxOTnQydVdVNkVKVjZrTW0vNDM4eHBDTVZQWGpzelMyN29PdzFoR0lt?=
 =?utf-8?B?UWtyNGoydWgzZDFneFNBQkZmM3AwMEZGZVhsUDMwQzFMNmI0N2ZBMHFpc0V4?=
 =?utf-8?B?ZHpOUm5uR3ROeU5RUDZwSFMzUnZwMWcwWjdxcTVaSC9zTHMvUWd2c25xSHRO?=
 =?utf-8?B?aGlhY1gwbEcyN0JOMDlRLzYyc1k1WktZZXczV2txbWhaZFlYMlhPTUlvN21h?=
 =?utf-8?B?Y1JsU0NuTjJrZXZZV2lFUTBhQjZlVGtjemlUbStWYkZGNGFmb1paTGVkeHgx?=
 =?utf-8?B?dlZUcWt4Qmxld2RMSHBaOEpmdGFONUlLWndxeUJyMlNBRHRHYU9SZjlDKzJq?=
 =?utf-8?B?Z3RwbTY4MmpxWGNxUW93aThOc2JycmsxTlNVUDZjWWhKeEQyazJrcjlLS0VK?=
 =?utf-8?B?Rk9QaFlLTmd2NUVQL0NaZGV6OTZPWjk0UkpLNXE3c09XTGVLZzcxbkl0NmpK?=
 =?utf-8?B?VHg5ZU1DeEllZ0RTQ1VZWU5yQ3R2bzdEa1czZEFGRjIrSjZRMkNuNitkZTRs?=
 =?utf-8?B?YzMyUDFWK3AwUWs0Q3Y3Y2FLVWRWSHlxMUFpbkpVYXA5cVVGckU2a1M0akRB?=
 =?utf-8?B?S29EclR4MUV0OHJMOEZhYlZ6VWh3YkZvYSs1WWkweGRHVFdJV3d5MGhrUk05?=
 =?utf-8?B?V2ZPU1c4UDZ2azErTjlsRkFMRVdtdWpHaU56bnVpNDMwWEJPVlYramw3ZjM2?=
 =?utf-8?B?dkhKMmY5S3pRNGZKRmkrMkxwUWo4TWdVTVY3M3dnVGhWcmNBYVM3LzNuNFVF?=
 =?utf-8?B?OVdLNHJLZHJXeE85QzVGR2VlUEhRSUl2eElBWk1UMEFHRGtDbE1HUUFvZEdl?=
 =?utf-8?B?cTJldkNUUlVKQk5xV09zR3orM3NXbGo3Rk5tcWRwbFh6clUxaEN3T1hTMzQw?=
 =?utf-8?B?UmVtR1BnOThMWWZVTHBZL2FxTmxPZURYeDhYOUtnSWNNU01VaDMrSVJFbDIz?=
 =?utf-8?B?cFRUNnJVL1F5enRnQWRWTGM2UE1LbkV1d09IKzlmYzErbE1HOHkvRVBWK0oy?=
 =?utf-8?B?N0V4aUFKSmJGS0tjR3VteENBeFZxWklCWmh0UTZsRHlrakhpN3FDSXBQRE9z?=
 =?utf-8?B?ZWw5TkwwdXNiek9rVU1sbmRFdVI5dk9nTEN4Z0Q1cDFaZnZJRDcrZDBkakdO?=
 =?utf-8?B?TnFSVWVvZUN5NGZrcmhKeWdITHhHaVlRUXRJQTJ1NWl3clM5eXFaUDdHS0Zw?=
 =?utf-8?B?L3lLWFN2UmM5TWk1bVVPcENITGVqZDJQRHRmaG0ySTJUNXRvQzMvMnJtRHlr?=
 =?utf-8?B?L2FNRzg2OFNhWXRqSXRXbTFLbkZEMjhoVTg5eHhySTdyN1hqcjRmTmZSNzg3?=
 =?utf-8?B?UGxkMnZCTGVIajBEZVRjNlo0ckJDTzh6bFJrQkppWkYvZUltYU1PRGYxOW9l?=
 =?utf-8?B?bnIyVVFMSFJIVWQrMGRwMzBVNEdLQXFLUGovdW0xVDlSa3VMNkMzYWtYTFNj?=
 =?utf-8?B?UnpaR2dZWU5DZk52VFJnUUU5bktKR1V0Mm5iQXR3SHNTeFdxUUY3akFDRU85?=
 =?utf-8?B?TUNULzA3R0NtRitqSnJ3Mk5vbGtSaUd5K2ZXK0xyYnZJeW1Xek83eEcwbGZk?=
 =?utf-8?B?ZFRHMGtpY29HcHJjRFQyV2Y5L0JrN1NRcEZFTGJjTWdvTXNrdlRKb2hoT3Zo?=
 =?utf-8?Q?v1b0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:41:58.9788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0e89ae-de76-454c-28bd-08de22d39075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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

Build warning reported for local variable set and not used on GCC-16.
Fix the issue by using the variable for missed register write operation.

../drivers/net/axgbe/axgbe_ethdev.c: In function ‘axgbe_timesync_disable’:
../drivers/net/axgbe/axgbe_ethdev.c:1744:22: warning:
variable ‘mac_tscr’ set but not used [-Wunused-but-set-variable=]
 1744 |         unsigned int mac_tscr = 0;
      |                      ^~~~~~~~

Bugzilla ID: 1819
Fixes: e04449488fdb ("net/axgbe: support IEEE 1588 PTP")
Cc: stable@dpdk.org

Signed-off-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
---
 drivers/net/axgbe/axgbe_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 31d35ff182..cf3b0d9ef5 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -1742,6 +1742,7 @@ axgbe_timesync_disable(struct rte_eth_dev *dev)
 {
 	struct axgbe_port *pdata = dev->data->dev_private;
 	unsigned int mac_tscr = 0;
+	unsigned int value = 0;
 
 	/*disable timestamp for all pkts*/
 	AXGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENALL, 0);
@@ -1751,6 +1752,11 @@ axgbe_timesync_disable(struct rte_eth_dev *dev)
 	AXGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCFUPDT, 0);
 	/*disable time stamp*/
 	AXGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 0);
+
+	value = AXGMAC_IOREAD(pdata, MAC_TSCR);
+	value |= mac_tscr;
+	AXGMAC_IOWRITE(pdata, MAC_TSCR, value);
+
 	return 0;
 }
 
-- 
2.40.1.windows.1

