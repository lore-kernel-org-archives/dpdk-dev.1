Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB4DC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE10440E22;
	Wed,  5 Feb 2025 11:46:43 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 20F9240B9A
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:31 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2109.outbound.protection.outlook.com [104.47.30.109]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJJ88oXcCvOUn+Pt9XyB63zvPvubyAIILdgRHAT8dTlZUvY6zGu9RrHz2v3jSl1s34nhw3ry5IkAVRVD1CRvu+q9NxI0o/G/HpuDvIVYZWQnLOGoe08XqSqtHoEfNMdxXh7dXuLFCTQW5tUUv8ETe3q52EY1FAipQFfgb1HrVFA5Vu7+EsmKbOAGyry55udeseSFnBaR1m8mWtDKTPu8WajcQr8TrIeainRdV9rpzP/2swNylO8OzopZGasrDWL7mLlNJrjPnYSBBUp8t83qMsNRxjoy9axa0OpjMsO9lKW0JxEbb6+MbfjK2aXpYfMKz/V6KvrtpSrqn7BFTEuaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hx+GH1/3i/9p0GzL6vgMB2sZIHaOWQ21raoM7VS7RA=;
 b=C3cIljgOyvnuYEI11go4FtQBuLEmKS1SaiFvCuarXL+v19N5lBGfQwgAsyDL966KNZPdiHxUFFz2g3jyM4Sl4xCnWBjzBeRaHMjFIOJLgMt+rP/5bh6hZZ8JemtI8gCEoG6RPnX0aFt7iy1bAlIthmNHFUdKlCqtwFZm8Grjl6e2wAp+Pmz0+whTmhgsMVckkZhgRNcTn7nLUgEYaJHuR/8RPVigo0T6U2azijTK3CzPcONRTwSxA9jOO3JuWi7v5JTbMm20BliQOx5dg9OjjqPRCfatESP5YdwvXazWfUFjixvHo2rqorMJ4Hg8bYpg/6hHs3TNbV4z0r/z24/DFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hx+GH1/3i/9p0GzL6vgMB2sZIHaOWQ21raoM7VS7RA=;
 b=XcqrABsDUtqWtgDgO2y/tRc75PBXD8pGKqew5QCdSny8yzeMQPOhmcb2LfTU65i3DxJTPZ7lhlrbEJ2SwDZR/qBsp+A8kD1tyFmB7p6PqX9cnICwPHzr1ZMeNw6uoLYWYC4zTMZHkg0A8G8RwNeDlJLzy8JqV1N0K2wLupNgMoA=
Received: from CWLP265CA0337.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::13)
 by PR3P190MB0827.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:88::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 10:46:27 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::f5) by CWLP265CA0337.outlook.office365.com
 (2603:10a6:401:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:26
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 33/34] net/ntnic: add IFR DROP counter
Date: Wed,  5 Feb 2025 11:45:42 +0100
Message-ID: <20250205104548.1533554-34-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PR3P190MB0827:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 642b91fd-05e1-493a-c2fe-08dd45d25763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kZh+7w7oJRGvMPujo/NrMf/qPL9/d3btaPU9u9lOcNHBuQbQj4AKLjOmWVVq?=
 =?us-ascii?Q?2I4qWrbMo30zNcEsMgvPsaCbDbCOsEaLWRJPl4VkQujXiZs5aSmtwPORJ7tK?=
 =?us-ascii?Q?VviYmSsVojXFco5AbciKawuxxNVlStdLgIilb0JiBkOgC5Psbl2LJf8bGhn3?=
 =?us-ascii?Q?ZjSk78gI+AuatylXUWxkSa4jdXaK1WlLmP+L5qwCMOWWUw4iIGncHXc/oiNU?=
 =?us-ascii?Q?B4KcgnlsWxV2mbEPbNFM3xYpo3F+OeWR/8ho8d4vu05qWdC+IVWKQPvhWsNF?=
 =?us-ascii?Q?N3d4LJ+RSxNEp3n6H/1qSFdsP1PfHFdaA5DNZ1JWk6mPFRQTCIqIBxCY6Jws?=
 =?us-ascii?Q?LkaBYZgc1y7+epUbWZ89zdsZtEjv+60M5QmAVdg4pV1n+5QDIuqfoSjuP3nC?=
 =?us-ascii?Q?QxU4FNQ+sM7S+1Scp+e++Ua5/A9vsJK4UutfQ+02b6hKoyjNABGis2hW71nS?=
 =?us-ascii?Q?/DmWezcW/efF3adxw3tRPf0CVM256YwuO+8/mySlxzYKKQ3taKM7nWNSJxQ8?=
 =?us-ascii?Q?85PlAZp5Ze9ZO/Bv+sfkv96AUHXp9U/VLFwWaZGxknGvuwlEF3GEBXkM4mnu?=
 =?us-ascii?Q?TCPOpiAu/O+Fr7O9bV5C+mBMh5+d5SIA0w9i1KOBapFfxgOb3fwzEPWxGAJd?=
 =?us-ascii?Q?QKochEfZcEwlP2lDBCf+Cyc2K9PLfzPwn0HcY7XoJz+o88AO3JHch+8WEIEK?=
 =?us-ascii?Q?bK+mbBrdsdXx06AJtLZbJ2NrUxh1iUsRHsjM7fI1yWB+a/4S8eW2A5iNi+UB?=
 =?us-ascii?Q?4p60erDF1aYBe3jrvIVeFsjv4PnaBdPp17goKG+5jbWTDWtDgB1XDqg5mOqe?=
 =?us-ascii?Q?ERJvpy3eYW8CmxkjmZg+J9FeP4gMfMiVcB6GnZm6fzGe8LNuDJgBRCJat751?=
 =?us-ascii?Q?Gvz1SlB/r45FAXaSImeto64gPYESXlqexQrMqIULSMtbpTPGkvS0L7zs/oKS?=
 =?us-ascii?Q?kkVwY+5YsjM/2GF1Wsb0b9cbl5n1gKP97NqVC0B1IKLD2NBtnMWhH6UcFvJ7?=
 =?us-ascii?Q?XSww2rX1E3Ir852VJUFfeqkaOv/q17nQnXHkEKyuBnVfJhZCb2G6jz5UDm62?=
 =?us-ascii?Q?2H3l9vpCDvxV/Fdahdr+ew7s7lRzLiYh2ait6QVyGGHCgi+7jow7bn1Mw3xZ?=
 =?us-ascii?Q?5PzYDvfoTMBbVVfKGaezzmMk6nuIDrZwpO+WKsUDLgtf/IA075YwI3YD0Jaf?=
 =?us-ascii?Q?BrBsiWm8zKMQuCCNSgzlPoaFw3L1wDDaTYDcKK9+LUxbg0RkHGAG8/D+Zxo7?=
 =?us-ascii?Q?9ybJmUuXCt0YYwkRq74gobR+pwFkOPgoqE9+g6HsONplqdaHOYM/K2xqnaaT?=
 =?us-ascii?Q?3FOlqSEdvj7xPdWKA1qpli465XlXmZwAEWo8mwVNdl+Zk2ywrpEZyUItihwU?=
 =?us-ascii?Q?rOgoXkDFCE5rSaMvSL9SbYHHVUzH13Ds5oCXwHP1nz/oruzV6gB/+PYuhXgb?=
 =?us-ascii?Q?cH/xgnc3ApkapMRnyQtWaax1WemUlkRil8e7i99PlM2F/qKgiysfxjpw5HhD?=
 =?us-ascii?Q?blckV36wGyOBElk=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a3mmVqR8ED8h49WIHB+WwHXLjeZF2CPQH31ZcRbkeutAdA/Z7Vis8y+UIHKN16YBsk9qISTYZqjdPxO7axHCQjNjqB1nZ7SHlRRccrPKpOvWB4vOciFGf4oKATIW/p1B/SK3YYy4BefHemy5JR175edHbdSeIzDvXvJ7LAH9IBWj1vMC5O2N1A7DnzNeEEcfcPw2ogAhUqG6Xf51OrqvAMF7Jz8EDDz6MJgRzm/y2yg7xb7FsFJ9WGkicEciakqn9txhYgaTDzl1aoBWLFPeoOFraQWnDmKCqrGi/XsUo9GZuK6Xpg5RjChaMjPGdhIEzmJX1N4/tvh348r3Hp4zOfXp6WB72YEsDsz5mA+CsW/PYzyHsyuFcUpNtyFxqcVbDKlY84hPX31+YW2CXzHFVmBIKKZWovo0lvArGx7cQjtQBwmVH1QXw0CsJMhppWg1zmZnFqteVdud5VaQ90QCY4roQqgYoTWoIhSM5G6o8nMFq3dGqfx+eBwzJjntVpkZNME9niI7jzDuWksyR3xhACXFnOi25eh5pDnQiD8hdPdhnlkmlDqFI2jjHwYH3zO5H+UYhKdKa+nmtR28HZg8ZSwi2MjPt9nbTnJmHpL7WuVpZJsUDhBp588HUGa7ffs+I1ywrQLRiqDa0xRPIF0rXw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:26.6832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642b91fd-05e1-493a-c2fe-08dd45d25763
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0827
X-BESS-ID: 1738752388-302364-7585-687-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.30.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWZoZGQGYGUNTQzMDcNC3J2D
 gpzTLZwMwo0cjc0MLYxMIyOcnYxNzIQqk2FgB+aarrQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan18-30.eu-central-1b.ess.aws.cudaops.com]
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

Support for IP Fragmenter DROP counter to display number of packets
dropped due to size larger than MTU.
NOTE: Frames are dropped only in case that both IPV4_EN and IPV4_DF_DROP
are set to one (resp. their IPV6 counterparts).

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |  9 +++
 drivers/net/ntnic/include/flow_api.h          |  1 +
 drivers/net/ntnic/include/hw_mod_backend.h    |  8 +++
 drivers/net/ntnic/include/hw_mod_tpe_v3.h     |  5 ++
 drivers/net/ntnic/include/ntnic_stat.h        |  9 +++
 drivers/net/ntnic/nthw/flow_api/flow_api.c    | 16 +++++
 .../nthw/flow_api/flow_backend/flow_backend.c | 28 ++++++++-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c   | 58 ++++++++++++++++++-
 .../profile_inline/flow_api_profile_inline.c  | 19 ++++++
 .../profile_inline/flow_api_profile_inline.h  |  4 ++
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.c    | 32 ++++++++++
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.h    | 15 ++++-
 drivers/net/ntnic/nthw/stat/nthw_stat.c       |  2 +
 drivers/net/ntnic/ntnic_mod_reg.h             |  5 ++
 14 files changed, 208 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index 2add43639a..2f1e12f891 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -100,6 +100,8 @@ static int nt4ga_stat_init(struct adapter_info_s *p_adapter_info)
 
 		p_nt4ga_stat->mn_rx_ports = p_nthw_stat->m_nb_rx_ports;
 		p_nt4ga_stat->mn_tx_ports = p_nthw_stat->m_nb_tx_ports;
+
+		p_nt4ga_stat->mn_ifr_counters = p_nthw_stat->m_nb_ifr_counters;
 	}
 
 	return 0;
@@ -205,6 +207,9 @@ static int nt4ga_stat_setup(struct adapter_info_s *p_adapter_info)
 		p_nt4ga_stat->mp_stat_structs_flm->max_lps =
 			nthw_fpga_get_product_param(p_adapter_info->fpga_info.mp_fpga,
 				NT_FLM_LOAD_LPS_MAX, 0);
+
+		p_nt4ga_stat->mp_stat_structs_ifr =
+			calloc(1, sizeof(struct ifr_counters) * p_nt4ga_stat->mn_ifr_counters);
 	}
 
 	p_nt4ga_stat->mp_port_load =
@@ -556,6 +561,10 @@ static int nt4ga_stat_collect_cap_v1_stats(struct adapter_info_s *p_adapter_info
 	flow_filter_ops->flow_get_flm_stats(ndev, (uint64_t *)p_nt4ga_stat->mp_stat_structs_flm,
 		sizeof(struct flm_counters_v1) / sizeof(uint64_t));
 
+	/* Update and get IFR stats */
+	flow_filter_ops->flow_get_ifr_stats(ndev, (uint64_t *)p_nt4ga_stat->mp_stat_structs_ifr,
+		p_nt4ga_stat->mn_ifr_counters - 1);
+
 	/*
 	 * Calculate correct load values:
 	 * rpp = nthw_fpga_get_product_param(p_fpga, NT_RPP_PER_PS, 0);
diff --git a/drivers/net/ntnic/include/flow_api.h b/drivers/net/ntnic/include/flow_api.h
index 9201b8a3ae..7f6aa82ee0 100644
--- a/drivers/net/ntnic/include/flow_api.h
+++ b/drivers/net/ntnic/include/flow_api.h
@@ -230,5 +230,6 @@ int flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, i
 int flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index);
 
 int flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
+int flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count);
 
 #endif
diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index 4061d3f9e5..594bdab2a6 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -899,6 +899,7 @@ enum hw_tpe_e {
 	HW_TPE_IFR_RCP_IPV6_EN,
 	HW_TPE_IFR_RCP_IPV6_DROP,
 	HW_TPE_IFR_RCP_MTU,
+	HW_TPE_IFR_COUNTERS_DROP,
 	HW_TPE_INS_RCP_DYN,
 	HW_TPE_INS_RCP_OFS,
 	HW_TPE_INS_RCP_LEN,
@@ -959,6 +960,12 @@ int hw_mod_tpe_ifr_rcp_flush(struct flow_api_backend_s *be, int start_idx, int c
 int hw_mod_tpe_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
 
+int hw_mod_tpe_ifr_counters_update(struct flow_api_backend_s *be, int start_idx, int count);
+int hw_mod_tpe_ifr_counters_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+	uint32_t value);
+int hw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+	uint32_t *value);
+
 int hw_mod_tpe_ins_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count);
 int hw_mod_tpe_ins_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t value);
@@ -1124,6 +1131,7 @@ struct flow_api_backend_ops {
 	int (*tpe_rpp_rcp_flush)(void *dev, const struct tpe_func_s *tpe, int index, int cnt);
 	int (*tpe_rpp_ifr_rcp_flush)(void *dev, const struct tpe_func_s *tpe, int index, int cnt);
 	int (*tpe_ifr_rcp_flush)(void *dev, const struct tpe_func_s *tpe, int index, int cnt);
+	int (*tpe_ifr_counters_update)(void *dev, const struct tpe_func_s *tpe, int index, int cnt);
 	int (*tpe_ins_rcp_flush)(void *dev, const struct tpe_func_s *tpe, int index, int cnt);
 	int (*tpe_rpl_rcp_flush)(void *dev, const struct tpe_func_s *tpe, int index, int cnt);
 	int (*tpe_rpl_ext_flush)(void *dev, const struct tpe_func_s *tpe, int index, int cnt);
diff --git a/drivers/net/ntnic/include/hw_mod_tpe_v3.h b/drivers/net/ntnic/include/hw_mod_tpe_v3.h
index 87710d8b35..9137e69256 100644
--- a/drivers/net/ntnic/include/hw_mod_tpe_v3.h
+++ b/drivers/net/ntnic/include/hw_mod_tpe_v3.h
@@ -104,6 +104,10 @@ struct tpe_v2_ifr_v1_rcp_s {
 	uint32_t mtu;
 };
 
+struct tpe_v2_ifr_v1_counters_s {
+	uint32_t drop;
+};
+
 struct hw_mod_tpe_v3_s {
 	struct tpe_v1_rpp_v0_rcp_s *rpp_rcp;
 
@@ -121,6 +125,7 @@ struct hw_mod_tpe_v3_s {
 
 	struct tpe_v2_rpp_v1_ifr_rcp_s *rpp_ifr_rcp;
 	struct tpe_v2_ifr_v1_rcp_s *ifr_rcp;
+	struct tpe_v2_ifr_v1_counters_s *ifr_counters;
 };
 
 #endif	/* _HW_MOD_TPE_V3_H_ */
diff --git a/drivers/net/ntnic/include/ntnic_stat.h b/drivers/net/ntnic/include/ntnic_stat.h
index 4d4affa3cf..1b53f6c347 100644
--- a/drivers/net/ntnic/include/ntnic_stat.h
+++ b/drivers/net/ntnic/include/ntnic_stat.h
@@ -46,6 +46,7 @@ struct nthw_stat {
 	int m_nb_counters;
 
 	int m_nb_rpp_per_ps;
+	int m_nb_ifr_counters;
 
 	nthw_field_t *mp_fld_dma_ena;
 	nthw_field_t *mp_fld_cnt_clear;
@@ -204,6 +205,10 @@ struct flm_counters_v1 {
 	uint64_t max_aps;
 };
 
+struct ifr_counters {
+	uint64_t drop;
+};
+
 struct nt4ga_stat_s {
 	nthw_stat_t *mp_nthw_stat;
 	nthw_rmc_t *mp_nthw_rmc;
@@ -220,6 +225,8 @@ struct nt4ga_stat_s {
 	int mn_rx_ports;
 	int mn_tx_ports;
 
+	int mn_ifr_counters;
+
 	struct color_counters *mp_stat_structs_color;
 	/* For calculating increments between stats polls */
 	struct color_counters a_stat_structs_color_base[NT_MAX_COLOR_FLOW_STATS];
@@ -236,6 +243,8 @@ struct nt4ga_stat_s {
 	int flm_stat_ver;
 	struct flm_counters_v1 *mp_stat_structs_flm;
 
+	struct ifr_counters *mp_stat_structs_ifr;
+
 	/* Rx/Tx totals: */
 	uint64_t n_totals_reset_timestamp;	/* timestamp for last totals reset */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 857051fe14..022d7a1c0e 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -1226,6 +1226,21 @@ int flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 	return -1;
 }
 
+int flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count)
+{
+	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+
+	if (profile_inline_ops == NULL)
+		return -1;
+
+	if (ndev->flow_profile == FLOW_ETH_DEV_PROFILE_INLINE) {
+		return profile_inline_ops->flow_get_ifr_stats_profile_inline(ndev, data,
+				port_count);
+	}
+
+	return -1;
+}
+
 static const struct flow_filter_ops ops = {
 	.flow_filter_init = flow_filter_init,
 	.flow_filter_done = flow_filter_done,
@@ -1242,6 +1257,7 @@ static const struct flow_filter_ops ops = {
 	.flow_actions_update = flow_actions_update,
 	.flow_dev_dump = flow_dev_dump,
 	.flow_get_flm_stats = flow_get_flm_stats,
+	.flow_get_ifr_stats = flow_get_ifr_stats,
 	.flow_get_aged_flows = flow_get_aged_flows,
 
 	/*
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
index a50055ce2b..9f7ee5decb 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
@@ -1584,7 +1584,7 @@ static bool tpe_get_present(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
 	return be->p_csu_nthw != NULL && be->p_hfu_nthw != NULL && be->p_rpp_lr_nthw != NULL &&
-		be->p_tx_cpy_nthw != NULL && be->p_tx_ins_nthw != NULL &&
+		be->p_ifr_nthw != NULL && be->p_tx_cpy_nthw != NULL && be->p_tx_ins_nthw != NULL &&
 		be->p_tx_rpl_nthw != NULL;
 }
 
@@ -1717,6 +1717,31 @@ static int tpe_ifr_rcp_flush(void *be_dev, const struct tpe_func_s *ifr, int ind
 	return res;
 }
 
+static int tpe_ifr_counters_update(void *be_dev, const struct tpe_func_s *ifr, int index, int cnt)
+{
+	int res = 0;
+	int i = 0;
+	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
+	CHECK_DEBUG_ON(be, ifr, be->p_ifr_nthw);
+
+	if (ifr->ver >= 2) {
+		ifr_nthw_counters_cnt(be->p_ifr_nthw, 1);
+
+		for (i = 0; i < cnt; i++) {
+			ifr_nthw_counters_select(be->p_ifr_nthw, index + i);
+			ifr_nthw_counters_update(be->p_ifr_nthw);
+			ifr_nthw_counters_drop(be->p_ifr_nthw,
+				&ifr->v3.ifr_counters[index + i].drop, 1);
+		}
+
+	} else {
+		res = -1;
+	}
+
+	CHECK_DEBUG_OFF(ifr, be->p_ifr_nthw);
+	return res;
+}
+
 static int tpe_ins_rcp_flush(void *be_dev, const struct tpe_func_s *tx_ins, int index, int cnt)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
@@ -2062,6 +2087,7 @@ const struct flow_api_backend_ops flow_be_iface = {
 	tpe_rpp_rcp_flush,
 	tpe_rpp_ifr_rcp_flush,
 	tpe_ifr_rcp_flush,
+	tpe_ifr_counters_update,
 	tpe_ins_rcp_flush,
 	tpe_rpl_rcp_flush,
 	tpe_rpl_ext_flush,
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
index 2c3ed2355b..0df5b9cf00 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
@@ -69,11 +69,13 @@ int hw_mod_tpe_alloc(struct flow_api_backend_s *be)
 
 	switch (_VER_) {
 	case 3:
-		if (!callocate_mod((struct common_func_s *)&be->tpe, 10, &be->tpe.v3.rpp_rcp,
+		if (!callocate_mod((struct common_func_s *)&be->tpe, 11, &be->tpe.v3.rpp_rcp,
 				be->tpe.nb_rcp_categories, sizeof(struct tpe_v1_rpp_v0_rcp_s),
 				&be->tpe.v3.rpp_ifr_rcp, be->tpe.nb_ifr_categories,
 				sizeof(struct tpe_v2_rpp_v1_ifr_rcp_s), &be->tpe.v3.ifr_rcp,
 				be->tpe.nb_ifr_categories, sizeof(struct tpe_v2_ifr_v1_rcp_s),
+				&be->tpe.v3.ifr_counters, be->tpe.nb_ifr_categories,
+				sizeof(struct tpe_v2_ifr_v1_counters_s),
 
 				&be->tpe.v3.ins_rcp, be->tpe.nb_rcp_categories,
 				sizeof(struct tpe_v1_ins_v1_rcp_s),
@@ -131,6 +133,7 @@ int hw_mod_tpe_reset(struct flow_api_backend_s *be)
 	err |= hw_mod_tpe_csu_rcp_flush(be, 0, ALL_ENTRIES);
 	err |= hw_mod_tpe_rpp_ifr_rcp_flush(be, 0, ALL_ENTRIES);
 	err |= hw_mod_tpe_ifr_rcp_flush(be, 0, ALL_ENTRIES);
+	err |= hw_mod_tpe_ifr_counters_update(be, 0, ALL_ENTRIES);
 
 	return err;
 }
@@ -358,6 +361,59 @@ int hw_mod_tpe_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
 	return hw_mod_tpe_ifr_rcp_mod(be, field, index, &value, 0);
 }
 
+/*
+ * IFR_COUNTER
+ */
+
+int hw_mod_tpe_ifr_counters_update(struct flow_api_backend_s *be, int start_idx, int count)
+{
+	if (count == ALL_ENTRIES)
+		count = be->tpe.nb_ifr_categories;
+
+	if ((unsigned int)(start_idx + count) > be->tpe.nb_ifr_categories)
+		return INDEX_TOO_LARGE;
+
+	return be->iface->tpe_ifr_counters_update(be->be_dev, &be->tpe, start_idx, count);
+}
+
+static int hw_mod_tpe_ifr_counters_mod(struct flow_api_backend_s *be, enum hw_tpe_e field,
+	uint32_t index, uint32_t *value, int get)
+{
+	if (index >= be->tpe.nb_ifr_categories)
+		return INDEX_TOO_LARGE;
+
+	switch (_VER_) {
+	case 3:
+		switch (field) {
+		case HW_TPE_IFR_COUNTERS_DROP:
+			GET_SET(be->tpe.v3.ifr_counters[index].drop, value);
+			break;
+
+		default:
+			return UNSUP_FIELD;
+		}
+
+		break;
+
+	default:
+		return UNSUP_VER;
+	}
+
+	return 0;
+}
+
+int hw_mod_tpe_ifr_counters_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+	uint32_t value)
+{
+	return hw_mod_tpe_ifr_counters_mod(be, field, index, &value, 0);
+}
+
+int hw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
+	uint32_t *value)
+{
+	return hw_mod_tpe_ifr_counters_mod(be, field, index, value, 1);
+}
+
 /*
  * INS_RCP
  */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index fe72865140..2cd2eab5cb 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -4715,6 +4715,24 @@ int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	return 0;
 }
 
+int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
+	uint8_t port_count)
+{
+	/* IFR RCP 0 is reserved, port counters start from record 1 */
+	hw_mod_tpe_ifr_counters_update(&ndev->be, 1, port_count);
+	uint8_t i = 0;
+
+	for (i = 0; i < port_count; ++i) {
+		uint8_t ifr_mtu_recipe = convert_port_to_ifr_mtu_recipe(i);
+		uint32_t drop_cnt = 0;
+		hw_mod_tpe_ifr_counters_get(&ndev->be, HW_TPE_IFR_COUNTERS_DROP, ifr_mtu_recipe,
+			&drop_cnt);
+		data[i] = data[i] + drop_cnt;
+	}
+
+	return 0;
+}
+
 int flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu)
 {
 	if (port >= 255)
@@ -5338,6 +5356,7 @@ static const struct profile_inline_ops ops = {
 	 * Stats
 	 */
 	.flow_get_flm_stats_profile_inline = flow_get_flm_stats_profile_inline,
+	.flow_get_ifr_stats_profile_inline = flow_get_ifr_stats_profile_inline,
 	.flow_info_get_profile_inline = flow_info_get_profile_inline,
 	.flow_configure_profile_inline = flow_configure_profile_inline,
 	.flow_pattern_template_create_profile_inline = flow_pattern_template_create_profile_inline,
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
index be22c9bcd1..98aba07515 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
@@ -72,6 +72,10 @@ int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 
 int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
 
+int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev,
+	uint64_t *data,
+	uint8_t port_count);
+
 /*
  * RTE flow asynchronous operations functions
  */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
index 11b6b5e5b8..45f2047916 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
@@ -69,6 +69,13 @@ int ifr_nthw_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	p->mp_df_buf_data_fifo_dat =
 		nthw_register_get_field(p->mp_df_buf_data, IFR_DF_BUF_DATA_FIFO_DAT);
 
+	p->mp_counters_ctrl = nthw_module_get_register(p->m_ifr, IFR_COUNTERS_CTRL);
+	p->mp_counters_addr = nthw_register_get_field(p->mp_counters_ctrl, IFR_COUNTERS_CTRL_ADR);
+	p->mp_counters_cnt = nthw_register_get_field(p->mp_counters_ctrl, IFR_COUNTERS_CTRL_CNT);
+
+	p->mp_counters_data = nthw_module_get_register(p->m_ifr, IFR_COUNTERS_DATA);
+	p->mp_counters_drop = nthw_register_get_field(p->mp_counters_data, IFR_COUNTERS_DATA_DROP);
+
 	return 0;
 }
 
@@ -121,3 +128,28 @@ void ifr_nthw_rcp_flush(const struct ifr_nthw *p)
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
+
+void ifr_nthw_counters_select(const struct ifr_nthw *p, uint32_t val)
+{
+	assert(p->mp_counters_addr);
+	nthw_field_set_val32(p->mp_counters_addr, val);
+}
+
+void ifr_nthw_counters_cnt(const struct ifr_nthw *p, uint32_t val)
+{
+	assert(p->mp_counters_cnt);
+	nthw_field_set_val32(p->mp_counters_cnt, val);
+}
+
+void ifr_nthw_counters_drop(const struct ifr_nthw *p, uint32_t *val, int get)
+{
+	if (get)
+		*val = nthw_field_get_val32(p->mp_counters_drop);
+}
+
+void ifr_nthw_counters_update(const struct ifr_nthw *p)
+{
+	assert(p->mp_counters_data);
+	nthw_register_flush(p->mp_counters_ctrl, 1);
+	nthw_register_update(p->mp_counters_data);
+}
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
index 6751a599aa..4763333765 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
@@ -33,6 +33,13 @@ struct ifr_nthw {
 
 	nthw_register_t *mp_df_buf_data;
 	nthw_field_t *mp_df_buf_data_fifo_dat;
+
+	nthw_register_t *mp_counters_ctrl;
+	nthw_field_t *mp_counters_addr;
+	nthw_field_t *mp_counters_cnt;
+
+	nthw_register_t *mp_counters_data;
+	nthw_field_t *mp_counters_drop;
 };
 
 struct ifr_nthw *ifr_nthw_new(void);
@@ -41,7 +48,7 @@ int ifr_nthw_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 int ifr_nthw_setup(struct ifr_nthw *p, int n_idx, int n_idx_cnt);
 void ifr_nthw_set_debug_mode(struct ifr_nthw *p, unsigned int n_debug_mode);
 
-/* IFR */
+/* IFR RCP */
 void ifr_nthw_rcp_select(const struct ifr_nthw *p, uint32_t val);
 void ifr_nthw_rcp_cnt(const struct ifr_nthw *p, uint32_t val);
 void ifr_nthw_rcp_ipv4_en(const struct ifr_nthw *p, uint32_t val);
@@ -51,4 +58,10 @@ void ifr_nthw_rcp_ipv6_drop(const struct ifr_nthw *p, uint32_t val);
 void ifr_nthw_rcp_mtu(const struct ifr_nthw *p, uint32_t val);
 void ifr_nthw_rcp_flush(const struct ifr_nthw *p);
 
+/* IFR Counters */
+void ifr_nthw_counters_select(const struct ifr_nthw *p, uint32_t val);
+void ifr_nthw_counters_cnt(const struct ifr_nthw *p, uint32_t val);
+void ifr_nthw_counters_drop(const struct ifr_nthw *p, uint32_t *val, int get);
+void ifr_nthw_counters_update(const struct ifr_nthw *p);
+
 #endif	/* __FLOW_NTHW_IFR_H__ */
diff --git a/drivers/net/ntnic/nthw/stat/nthw_stat.c b/drivers/net/ntnic/nthw/stat/nthw_stat.c
index b0db7b1984..afa24fd3a9 100644
--- a/drivers/net/ntnic/nthw/stat/nthw_stat.c
+++ b/drivers/net/ntnic/nthw/stat/nthw_stat.c
@@ -199,6 +199,8 @@ int nthw_stat_init(nthw_stat_t *p, nthw_fpga_t *p_fpga, int n_instance)
 
 	p->m_nb_rpp_per_ps = nthw_fpga_get_product_param(p_fpga, NT_RPP_PER_PS, 0);
 
+	p->m_nb_ifr_counters = nthw_fpga_get_product_param(p_fpga, NT_TX_MTU_PROFILE_IFR, 0);
+
 	p->m_nb_tx_ports = nthw_fpga_get_product_param(p_fpga, NT_TX_PORTS, 0);
 	p->m_rx_port_replicate = nthw_fpga_get_product_param(p_fpga, NT_RX_PORT_REPLICATE, 0);
 
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 8db4911262..bddae823c8 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -362,6 +362,10 @@ struct profile_inline_ops {
 		uint64_t *data,
 		uint64_t size);
 
+	int (*flow_get_ifr_stats_profile_inline)(struct flow_nic_dev *ndev,
+		uint64_t *data,
+		uint8_t port_count);
+
 	/*
 	 * NT Flow FLM queue API
 	 */
@@ -459,6 +463,7 @@ struct flow_filter_ops {
 		struct rte_flow_error *error);
 
 	int (*flow_get_flm_stats)(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
+	int (*flow_get_ifr_stats)(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count);
 
 	/*
 	 * Other
-- 
2.45.0

