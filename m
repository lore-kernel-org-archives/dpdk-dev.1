Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE2DC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C37C440662;
	Wed,  5 Feb 2025 11:46:22 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 967A54066E
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:12 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGSP2AXOUhclycnm9S1JEJf22S2Xmu5joHKfgMVMEMmCQgIr9GMKSevHLRJi/rRCRhwJJemBj+rUtCvtKL+bcBu9ZZKVDRMJGU0yslCpxCZAcswdJ+Cs38+x6u81CuWTEoXOlLPTgZ/h2/leogbuBOyXD/FdLiX6uan2PytquuuhwDmEc1d7cuFgF2oztVIv9NryGbLq6UlSDMM3u7jSgpqCj831V6LCQOI7TZ7+vfGoDffSKaSkmRtcQIc3gbIzQw7A/gS2/IiVeyjIP2+UKRZULNBU1H9DrqNumTho6GulHM+ZZnNsGa+yOPcJcRcmgOJk2Ft/y3I+eKQL9ED+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez9uKHEUc7uLu6aPINCCgXr6zDbeFTb4eU8i4xXRCZo=;
 b=wIaxNRcxWLFspxBsg7JZbNBkjUwgyJxFgJZH4+pnwT9s+JuFyzApxrdrzt2t6BEBmLnd8XDfv0Y/tvywjLteQ0EGjUONo9EQ1ZdPmcqTw6Id+60J9LwBL9nX95pfUbfm8d3YWpRhN5m4ajJ0Fn2UNZV41igmTtxNDBBKEJvbuUolUyrmWYVZVRZBz8yaXj3V+YTNuvNy+27ZT+k7ypebsmmfPZq3IuAv2KfqAR1gGJpTB1wDeBWtQymqVEdI0dWz6XpL4UL99DBzmOFmsX1xQXZoZ5yU9TYA/AP5/qCZ5f1kyqb4LDFLbNO8FDmPIhdFyx4PhNI6XtXI+ZQzrecbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez9uKHEUc7uLu6aPINCCgXr6zDbeFTb4eU8i4xXRCZo=;
 b=oBVd+TjGH64sOFgjHDSPY1fM4czV9kYIMFVK+81PFR6jFk7D14YxQ5uYIf1B3C9Q5IvbTRFB2+cCMDi8UM3HNzba0oYp8dYVNddS3/+ojZ0Ek3P1Oufis6BqXhqsFLqRdZWlt/VR6ZmTWAigSDXs0f4aQs7ZLxyHzbBqJlV3nI4=
Received: from CWLP265CA0354.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::30)
 by GVXP190MB2116.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 10:46:08 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::c3) by CWLP265CA0354.outlook.office365.com
 (2603:10a6:401:5a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 5 Feb 2025 10:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:07
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 14/34] net/ntnic: add null checking
Date: Wed,  5 Feb 2025 11:45:23 +0100
Message-ID: <20250205104548.1533554-15-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|GVXP190MB2116:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c35a7d33-0b73-4622-5b0d-08dd45d24c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MUpmK73s9wiw5khzlF2wGY2bsCZBlJ5hdKLdDLC1s6G7Y3cZgHGWhCsWlzSN?=
 =?us-ascii?Q?BR+SCY+5Dvq+vATb38EMoPXAFYUT8Qxt1+0jL/370CGhV6b0PbUR27V4g7RW?=
 =?us-ascii?Q?xnec40iO9CriesBJB14cPyas3LfsveAjp6nE17YHZiE8qkgXcTxSfF1rUZRF?=
 =?us-ascii?Q?WSNl4w4OzkXEpgBkuMCb5BkbC4g6AqN+PvRdhvwLJD+/6dUeSV4ZJ/MttHNP?=
 =?us-ascii?Q?ETMDj63CglYNyR0t3VjqAf2SkEYS3V8oarH9FzlWFASGIV7PJM9nBRCJ43kw?=
 =?us-ascii?Q?Yv/NeD34VWiXN+ltcb3wyL5EV7GIz59NSqSOz/55KY7Stdmy5o3AP4sY1Vht?=
 =?us-ascii?Q?tmtEis8LbuXxhn3AtZqcmf6ircGQawvaRuxIjDbkOHUsUs5yGkgsEQQQNXSC?=
 =?us-ascii?Q?Rh+Vl7Mw+sj8S+nd1yAF9NtKtN2j5ILZ5SXqx1Bhqr0baYaabaae2T+U56Kp?=
 =?us-ascii?Q?3DXt6twiOjsTR+K/MkXFmFYZwUwJy5ZPNVMnUM7S+Vk6il7rAnddV8yGE1qX?=
 =?us-ascii?Q?y8EsIYI+vzj2udpIf1FMFj8oqyTopO3aywOUADSafW2QvEo1wm4dU/FIEzJW?=
 =?us-ascii?Q?Mw1NodxjXc3PhzjV95RI3hB2b4NPY3vk6P0Jl1ANSlBCY8WDZrfBuW7GV9fc?=
 =?us-ascii?Q?+pbga9GMQi7FriAZzrqr1qVvcmEzlyLfmjZszk6/kuJ6gehw68Wep3LQX6bR?=
 =?us-ascii?Q?Yqn9esieApM/6c35TGPCWNwZKn97izNjKaxmZW+Toi274HziE3mn81lyZM4t?=
 =?us-ascii?Q?PDSfkBm4awxIfLdBux4BpJuBGgkjhcAABu5FyHqJn2t/3puD0BcVM+gnPx3P?=
 =?us-ascii?Q?uqN8UvD1XCrR52Fo5YgSBFSwc0dIP+q/D9UldMXif202Dzw9EToklu2LqJQP?=
 =?us-ascii?Q?7IKfPWmdYy9p7W1y3fvtG4Sa1d+qHa5zmeDUZz0i0Nmi2L+JZHaBbPZVmcCf?=
 =?us-ascii?Q?ZiS4UpcOVVYjeIC9xSOXRtTSWDvmoT0p2Ed3JH/bPBEum3B4sRomgG5Qerka?=
 =?us-ascii?Q?W6QeEwpHCkhAF4Dj8DDx+NBfMophIM1mFCNENw2uWxRtCZQkrLVYTynReaua?=
 =?us-ascii?Q?jqGFDIrEYwXQy7f+d6BBl81k7qCXUCxte0uMdtDZsfU0vzlRRpOQuBMLoyGu?=
 =?us-ascii?Q?DHsl0i3ylFuymGmzyDPgU6qtdGMxq7HlghaXtfNOE+61NsxteOVp3Tds36rC?=
 =?us-ascii?Q?RwDUH4FclpVeN0xa/4nzGb1dSzWt4etzfa8EMB+F4MgKUyoNVjLXMOrV7S46?=
 =?us-ascii?Q?INE6C/sv8xWGkIREdyPlwYUTHTXxeImqwB6sRIg1AYxkUQSDpfV0mUqSeno4?=
 =?us-ascii?Q?sHFrEeKdCZvyTPLosnCTy9oUjogBPulV0hL+6nCH2Tmv+uJWg7vTuVyZ09Ld?=
 =?us-ascii?Q?2pgAc8ecKQKKj6SAkzAqge/sM1nLbXMiPvcKTGsKZySK5y4VfLIucA5XrvXT?=
 =?us-ascii?Q?f/Ok5RTPDZcsDuijqhF5WwHO2d64qOv7Ga6LA6pC5d1TMnsEyNGctjP3s4Ps?=
 =?us-ascii?Q?ExSa2wROJWP4jDo=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KQaTrp5eAGyIDo+ZxeGTVJoZsll03xf89Zb8jdCmg+fbJzN0xvS8oBYFfP/7wfO9nMb9+BdYKvv40nPolT4KpD8FPKBrTXumLUn1eKosR831mMtWVclGG5gReaiAInRqrzUUVI4fLFO6rYQejFYsNltM15kdyDpX6ttooGlvYRJiSg5ebubb4H0jzLWiqLK6otJOPSIrCrrqcN4sOt8RwnwTTLkKqJgpwIE36UZ5mxFjWXHhw7wB0ePHRKAHwF+mugQ4XmlgQ3DMH8kOBaignKsknmb0avJ6v9zZSarTrab3t1zIaaw8BiVuBuZAZfXW9jiOWmctlAdGquNjr4dMD8Oiz/CEwcuVc7sCL3QrxXvZ1NA4bCO/zGb5j6HL3sigElYeBh9rLnTEGfm2T43qBy+e8G/9RogYN18SFk9JOqJpRhCpeppvMsz3ds6CN1C8Ol3EcuwOSuiZBPf3NWetzz+QeR2uMg2NjtsTSTlrtGc8cZK2gzgTuipr2Gj6Q452wymMdgXRUXslKxshSoJXfg/o9GTzWW93VZtj8C5MYfeeEavGyuHZwPOQEjkuUlmEi0rHg2cUA5uf/30wPG9aG3bjmmd0yDsOWill+d+Sl3u3+C8f14XorizwWiIQ9lBOpk0Sc3ueQq3pXkv/B33uJQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:07.8864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c35a7d33-0b73-4622-5b0d-08dd45d24c34
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2116
X-BESS-ID: 1738752371-306009-7771-609-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmpkBGBlDM3NwoxTDNwjwp0S
 DN0jzR1MDIKNncPCXVzMAiJdko2VCpNhYAq2KkZkAAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan18-131.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add null checking for fpga var.

Coverity issue: 448916
Fixes: 30b2f87ac650 ("net/ntnic: add GMF module")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index d8e0cad7cd..67dc0d01f6 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -405,7 +405,7 @@ static int _port_init(adapter_info_t *drv, nthw_fpga_t *fpga, int port)
 	_reset_rx(drv, mac_pcs);
 
 	/* 2.2) Nt4gaPort::setup() */
-	if (nthw_gmf_init(NULL, fpga, port) == 0) {
+	if (fpga && nthw_gmf_init(NULL, fpga, port) == 0) {
 		nthw_gmf_t gmf;
 
 		if (nthw_gmf_init(&gmf, fpga, port) == 0)
-- 
2.45.0

