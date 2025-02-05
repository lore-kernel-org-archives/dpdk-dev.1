Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A95C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BB8D40674;
	Wed,  5 Feb 2025 11:46:16 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id BFE1140653
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:09 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2105.outbound.protection.outlook.com [104.47.11.105]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMrJ1IuvLWzdd6QkXusbkkxqMpxppUAXpWH1aq324OREYBvvxcFJxg2bS8/YEKg5aRuVAQAVCAZ0aRfKJ/4hvRkeQ+1eJvKku6zN1xUb1PXUDKDHe0Ho/UkjU37tJUwvFaI/S9oIG4PPm79DbU8jktbOm5ALV4BmdaBg2vIAsEIHGlF16t6Wzd5JOKmCaew89w7KC6R+S0+8os1dFTupwd4gTzXTZFQGOumldLiQgWMqIGBvoTHR6qANnifViaTt+HuOekdpS4mSwvukaVYceX37HSk+I6Wsw72zYIzWyNV20pbsjXaQpYxjzgCSM9wCuDa4mQDp6rs8k5B19+tjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/5OorzN93J9AxNLk5sE1aOAhzODKmSBFDgux7H/fso=;
 b=yoSIpIIGB5BxHMYTUt0sWjjbh/HQPGlP14pPcia1x5eQsTf0h+tIMJ7n6GaGcMuYMhi49Ay7JBLo2EEJz6g8JN8ziGpA/0qYVp923zNVK5S0CpOROtGEBZL/L0GGO1Obw33NqOcoCJW59tlFb+5vD2kH8ldyaj6TvsH5obZoWsGZB0SwdulmJ4ScK7Np0z2TsFz0lfy5fhzjgKheOtNstDNpyoyFs+lBatXiYTuolxhV8hRaBa6t/IdMi/x6d7VPcF4C1RF3Tqb7g0XhLZa74saLe05/xukH/RoirwvVbgwwhQrOu0LcWRAbB74wTPutW9HBIa0/4Er141O0C4uWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/5OorzN93J9AxNLk5sE1aOAhzODKmSBFDgux7H/fso=;
 b=Op7ATRxGSHrw/8WF9ky/uIt8kF7w3NGDCtkAV+O41yoesezHhh6qKTkR2YX/R5D1HauvzcLdzleCVg84v6Dd49XOVHoIdDsm79AuxRtIYJInk0sC/5rK0H7r25YZj/9XG0ZpfdLB+v+S6RTeGiMaP+rSULv95zcHpaVaiZgHLpY=
Received: from CWLP265CA0341.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::17)
 by VE1P190MB0926.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:46:06 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::38) by CWLP265CA0341.outlook.office365.com
 (2603:10a6:401:5a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 10:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:05
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>,
 Oleksandr Kolomeiets <okl-plv@napatech.com>
Subject: [PATCH v2 11/34] net/ntnic: add null checking
Date: Wed,  5 Feb 2025 11:45:20 +0100
Message-ID: <20250205104548.1533554-12-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|VE1P190MB0926:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 328fbf06-a561-485a-56c2-08dd45d24aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cp+g/J8QcNgM8dIzgPIT8yMS2OOBjo0x1SMM8bIhqu+xHcM27ZIo5dwN+WW1?=
 =?us-ascii?Q?Mc6TU2IJShDXzL5fXRJFyYyIjEUd68M/dWyXOZAdQxzm3ywBChmAqfwaDn+j?=
 =?us-ascii?Q?ZQ/QtWp1/k6v0lvlU/WYN4qcKeLY1kMMhvWOY5iPQLLG4RWsOJrbgZazX9fq?=
 =?us-ascii?Q?fD2lgb3MJcmiDWYfBq7P7bwhk+Spqzgxmxurfpk2N7ju5352YqIcJKmXZ2b5?=
 =?us-ascii?Q?M/WdybKd8TNzzf3VV6Ff80xDAlnYdVpbiufQ2RxXXS7gFIZ6WYA76fuUK5Gt?=
 =?us-ascii?Q?uHaFOoxDLnYXvvr4gOQGbjzledfrjqC8XIt6BpbwU76wEHBqkLlJycEOOXn/?=
 =?us-ascii?Q?AgI4NDI7Shz2OaKdzA+H3AdjORqO8QS4x6rlhH/KZQee7PNfJKavNdHGZxNF?=
 =?us-ascii?Q?2AdI1jMKP2yZwKfDjeJnR+FHXVutBMge6KHT10wIdQ36JtxRkcbWcVPVfn8j?=
 =?us-ascii?Q?Oeg35Aiklli3bqGUwjj5NW1RX4pGFd1hfb/2JlUhlkMHuliyvvBnPVS+n7k2?=
 =?us-ascii?Q?M81nZi3saP3MLGzeinUaFfvOs76DS4wCgCnsimYBWAEUo5n9lSgZKE18t3xW?=
 =?us-ascii?Q?PzeDWRzlZrT7RGicV/kPDwSRJLZVS0sa9JPc/AD2u2HxCHQ2epS/a4fHVIUH?=
 =?us-ascii?Q?8mDqyA+ECO5hrt9fFB3PP6SFTqPZHpt3qAW5sX8Tk+o8cB0PCHLj+enLX2fe?=
 =?us-ascii?Q?HpNdw2aPoXqRi7TnLVzdn6Uulh3xpE0+6RqRgUEPpr+n5c2wht+zwj/mVzlo?=
 =?us-ascii?Q?FRT5+4U2tCrNlohpQYGlrFFhj0DBZ+AT2m7eBYP874LLkXen2tOLlABkOPVI?=
 =?us-ascii?Q?TAfyhQV5TvEtr4AKW27XZnbvWdVWHmyRJs6LTU5GSlxiHlvjpKTr0ttiSXhH?=
 =?us-ascii?Q?wjAxcbxaIehv416E2klBymgDVTQQHWDkLvtvvm9NDc71ccu6KtEpSfrsBUXR?=
 =?us-ascii?Q?l7O8xMIeSSg2NQwcSXE+rYmkcj0uOVMsi/jtGtz0/H+uemWBuaoqf2QSPW1v?=
 =?us-ascii?Q?BjVspCfRKi3uS2+vvWcbmsxDfEgXmoM31VcrjZCTKEv7yO8vnfS2KbgqLIGl?=
 =?us-ascii?Q?ex6vkcnd/Cv2wZL2/3/od/ydLFBR0k61HxGbn4eDUOi/qOkMoqGUs9bg0CuC?=
 =?us-ascii?Q?m3EHRv+nmyeqMs0N3Z67Jf16tKWM+JGY/5J5QUOji2/aW9WN1WURIoIx45Da?=
 =?us-ascii?Q?ib6mUj6iSCdRzpGgMqC4Fl1IP9TA0/jcjbT491Lr0sfD9zX0P3cNLK/E7+zb?=
 =?us-ascii?Q?j59lVxJznyGdHy6pGlscjrGJoU0APBw+sfr+3P5047jJU1OMKFnjlwHo7h3m?=
 =?us-ascii?Q?r3tLyQxUy6z76h/cKkc+WdkuBxoT6/mx/TnwCu0cHdEaaWXZVZXh6Hr96qLv?=
 =?us-ascii?Q?uLfgw9Qs5llRlwtMkqBFyeAAMZso0ujcPvpc1dbDc/CmxNDwbN6nldVGLSin?=
 =?us-ascii?Q?Ads5ADNV3gmjJ+aKPcUetjkPkc/1cpe2477SU8mBQi39dsLdn+a2+vDtlulv?=
 =?us-ascii?Q?Orah4PzlTattrjY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +BQUYYpp1XDJ7QNn9mMrX5Fq8qLecPks/P0h8x+9rGfm2AyNzIBaazpEI8o3JcL5QVrMb2mvsy8/Cfi2n4afrEx2fGOFsDu6IQ41VFo9aD906pwc4itSC2BCOCJLA2aC28h1edJCZMsdDqk3a4VbHvaNO9Fq+9pLartJRRL/ZuTFKdxtFo3651upc001OukdpFBVVenk1r3pIFdU8gUr7w5HOnKb+jK4ySFgo+vq6CPfGHq8nxED1H+ulDYf5Skr9C9Po7P3Qp+9igXfU9jcFZ312JAIToJlb+i9xc+o3gVWIwErwV9hWlRgd7IoPoU+JlY1+VFeoV41vK6kPZEXfiJ7q8/ZkCKZTzzvy3jFcEIBmDD2cqUDu8TnGl0plTD3jmCjZJnhic7DJlMxVIpyCky8vOjqDlQdu4n0pAZ6iLgB+AnbG8obUQIVEwbt9mEZbMXPnQtYNdIhKD7TeLL0vVmYRyvTpUQw3g+WStrOaN/a4WCUAh0pHq1ME8mmu1upESa1KjI5lSKR+QyzID/Uj1yf5PUYQ8LbUb4Wzcpm6o0LQz0jwfsAvPpgVZKflul66Gff+BKbiBR+eGMJcZMmlxhs9rgebTsKVjXs5RZc+oe62Cs8j+GrhU1sVLO9xPnQfvR4hd+BBnAqoY4Z2E/Iag==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:05.7145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328fbf06-a561-485a-56c2-08dd45d24aeb
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0926
X-BESS-ID: 1738752368-306009-7767-603-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.11.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZGJpZAVgZQ0DTRzDAlLTnJ0M
 gw1dI8LdHECEhYGlkYJRtaJFomWyjVxgIAYcJ8I0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan17-75.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

Fix issue with potential rereferencing a pointer
that might be NULL p->m_rpp_lr when calling
nthw_module_query_register

CID 448923:  Dereference null return value (NULL_RETURNS)

Coverity issue: 448923
Fixes: f543ca6b9ab2 ("net/ntnic: add RPP local retransmit (RPP LR) flow module")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
index 28c7a05fe2..e69a1ca823 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
@@ -54,18 +54,20 @@ int rpp_lr_nthw_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	p->mp_fpga = p_fpga;
 	p->m_physical_adapter_no = (uint8_t)n_instance;
 	p->m_rpp_lr = nthw_fpga_query_module(p_fpga, MOD_RPP_LR, n_instance);
-
-	p->mp_rcp_ctrl = nthw_module_get_register(p->m_rpp_lr, RPP_LR_RCP_CTRL);
+	if (p->m_rpp_lr)
+		p->mp_rcp_ctrl = nthw_module_get_register(p->m_rpp_lr, RPP_LR_RCP_CTRL);
 	p->mp_rcp_addr = nthw_register_get_field(p->mp_rcp_ctrl, RPP_LR_RCP_CTRL_ADR);
 	p->mp_rcp_cnt = nthw_register_get_field(p->mp_rcp_ctrl, RPP_LR_RCP_CTRL_CNT);
-	p->mp_rcp_data = nthw_module_get_register(p->m_rpp_lr, RPP_LR_RCP_DATA);
+	if (p->m_rpp_lr)
+		p->mp_rcp_data = nthw_module_get_register(p->m_rpp_lr, RPP_LR_RCP_DATA);
 	p->mp_rcp_data_exp = nthw_register_get_field(p->mp_rcp_data, RPP_LR_RCP_DATA_EXP);
 
 	p->mp_ifr_rcp_ctrl = nthw_module_query_register(p->m_rpp_lr, RPP_LR_IFR_RCP_CTRL);
 	p->mp_ifr_rcp_addr =
 		nthw_register_query_field(p->mp_ifr_rcp_ctrl, RPP_LR_IFR_RCP_CTRL_ADR);
 	p->mp_ifr_rcp_cnt = nthw_register_query_field(p->mp_ifr_rcp_ctrl, RPP_LR_IFR_RCP_CTRL_CNT);
-	p->mp_ifr_rcp_data = nthw_module_query_register(p->m_rpp_lr, RPP_LR_IFR_RCP_DATA);
+	if (p->m_rpp_lr)
+		p->mp_ifr_rcp_data = nthw_module_query_register(p->m_rpp_lr, RPP_LR_IFR_RCP_DATA);
 	p->mp_ifr_rcp_data_ipv4_en =
 		nthw_register_query_field(p->mp_ifr_rcp_data, RPP_LR_IFR_RCP_DATA_IPV4_EN);
 	p->mp_ifr_rcp_data_ipv6_en =
-- 
2.45.0

