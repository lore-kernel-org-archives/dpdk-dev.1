Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A0C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:05:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF9E440A8A;
	Thu, 20 Feb 2025 23:04:27 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 3000E40A75
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:22 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk1wG1Nr1qkpt5uDGFCZybC7Ba00wyurKjHnRgb2WtRo1iXYEQGIlvPojkA5ESqjKs0r7R61VoyDcNL2tYoRS/KBryWJC0yQp+XAS+/asEeMpp0fwsBrsFevcvdo7VyYxoYoauZ49/tnOKyRusq96/cIKCLDh5/DcehyFQV3JaYLveYxZSVc5UJ/oDOl7wFcIfbe47QrV7qLBq7+iQHw+zIWVl5kcSZ2CCmLZoNmRAhot8d6RAgksnztvOEleqNd62WWR2gCoEs7VG0QWuuBSQfZ08f9lPPnkxcLufjxZ95mBTbrckta/NgTMVSo3Q78UXgLo4v2KBZL/uyBG+7jdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlB1mcxLqW4KT8I8M90MjTMS2TBlZGQ0jLePqQrUQ/A=;
 b=OEwVXzyFPGM7wCArVIaBG/JfKGoLf9jh6e6tdRrqwo78rl4WrRLmGuNEaJEJRxT54F5LlAls8+HJ0EjagHu7B0KgHHpdfsOJAk5i32pXDS7fdWbCAhr+vVWYnm4qB37ZCCXz2aPzz1GORtmY+Dty8H43i6w+ASHIUKVtRzmcZ4coubzmjKeEGte9Ifsd8HXbSvCYQzWSkYowYKNWWQd9dAa4aPNbAWbDi9G3/bG+Peka/Kg8AFINgPa9oWWVWjPxamI6vC7SgZR71cnkRFB/ri9tmkk5Vo1bFNjswRkN5FuZraEFOo7wXZuSHJRGlFWcwpIQQOMfbWIKVYeLaxCQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlB1mcxLqW4KT8I8M90MjTMS2TBlZGQ0jLePqQrUQ/A=;
 b=USpCrhcBdsnoSERYodrsjl2F5fmdP07QpG67qQiSpyTaKinGJO+TQ8MYEpMBItzNjXWU0jYm/Tjdx0zi2tii4eiW5DeEGh3fZCf8aNSw1oXzNXYnuS3yBD4zg5QqLT2PLfmSbRKpO5U/wKy/YWTwbs5puj/XzMB83FcE39AhHgQ=
Received: from CWLP265CA0496.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::17)
 by PR3P190MB0843.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 22:04:19 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::6d) by CWLP265CA0496.outlook.office365.com
 (2603:10a6:400:18b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 22:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:19 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 10/32] net/ntnic: add link handling API
Date: Thu, 20 Feb 2025 23:03:34 +0100
Message-ID: <20250220220406.3925597-11-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PR3P190MB0843:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4df45a02-4339-4b93-0bbb-08dd51fa8635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RICzvpStgImOArgg3u8/SopUICk9byQ2udY1An+0HYvwFcoPwHYS1GOlFglf?=
 =?us-ascii?Q?9viCKfU/hK3zVOq4HKrjvsumVyqvernnuTSHDnHosksd2MzEpere4pBftNgi?=
 =?us-ascii?Q?mwsXfwAdJpfhZ+mroypuNOlcO5qk+iTENK9tgKPn8slhpLqgAdgMNkQ0Wecq?=
 =?us-ascii?Q?dAzSzyx+W2t0+IWjHYlejig19qLG35NpiIYDFTpxnrSOHaJIeoLntxeLA4C3?=
 =?us-ascii?Q?pSPIchuLnLdJf/NqB8lJ3DPbbAAmH9rbsFNwCAtSt8XUT/9OG7vprYrfQPFl?=
 =?us-ascii?Q?2vkPETRK1pWCMMfyWXG7b5Y2Nc4SrHM/IldPhcw3eiKv8C1wHYITps7OFHun?=
 =?us-ascii?Q?u7k1CSmAHUDEd2sfjgmnyIUvm9ZPW7RNkyxfdndu4xGJmWsgK+LBK3ez/Dkk?=
 =?us-ascii?Q?dxL60X/YWrbJzXTdr6i+HGiDtRZ8h5eHlNI1ClGrPeLlXTo1V55D2JI2eudw?=
 =?us-ascii?Q?sqzEwyX7P46GyqrTlQ1UNnBAUQA5mKEQnS1lQDHrOOLNBNiKYnB05+e0C2zj?=
 =?us-ascii?Q?Z9zGXzATvGZL0wgtxMrzeVefqMGHhTQRIE2eBT/2xc2kTMV+b4I8vb38oFAG?=
 =?us-ascii?Q?07Rfc10fInmkHT9mJcIdDIRYdb7HqhLnBk7lX7djqc3oEn06kUtUiHxFfv3C?=
 =?us-ascii?Q?Kx4qNTCL7L/gPeah6hosWCc0jC6K+0C05abHKX3DYUBj73ghmrOeETC0iX1b?=
 =?us-ascii?Q?WGDC1Q6H/JDAUXRRY51O4JgeQ4S1ClRFc1+dR2JLaabJ3nSt3kIsW75BLY09?=
 =?us-ascii?Q?BAeGL90kJN8TrzUHA+sx2Jhd8ZIFudSVAOqZtrJT2Yyxvc/XjBqpNOoKx9Mt?=
 =?us-ascii?Q?Q7tRF1FqPxPyZSbLoJ/vu4q8MGq9JbJFCnN8F8oPK1QnjAxAA/fzt6oRMg1O?=
 =?us-ascii?Q?+Z2C+OQDdMKmDqXBiLHPhVG/UXgzVVhTGOWtOvjwSBgpWKPdVgRVIX5ZXjdc?=
 =?us-ascii?Q?C1F0f1rYH10Et24qLo88aKXqEMEyO1FcLKT+QRVyzYqL859CoWnzy2fiyAGi?=
 =?us-ascii?Q?/vY9DVB8R/T0W8IhwDB+Tcobs/mdMfGZsrayxbwqXUJDH9lNhF0JRk7RBT0z?=
 =?us-ascii?Q?JpsRKX+Mc0LhjbsUs9qdJZB/aKpmJMeFD0+ywxUSdKcZ96PnEgoCO+rxBCiV?=
 =?us-ascii?Q?juNu8o/1XZyfDr5F1BScq4l24sunWcyU83bHdART6iEIrNqnc96hO32WeFv4?=
 =?us-ascii?Q?9SzDeMx352xkxKVCxycuMEWkncOBHaEZ8MgTSOAfphr+QN/o5t+DXFJdQzZb?=
 =?us-ascii?Q?Z8Ugd7EBaLDgvg4/fBJcDYt2CDo0IXqVqIw/wSQPksWJaf+Qa8sTHgDls1fW?=
 =?us-ascii?Q?c6eqvAB7COb5Rn0Nu1QO/qjie6GVQmP5scLC/HboPMYJlCDfkJZtWFjIHnMG?=
 =?us-ascii?Q?98n6wXSkY3tObb9//71xp8AXz2t7DyaTllxvC9XUkb5+72vPunhyTmstK6r7?=
 =?us-ascii?Q?HuUh8xYiYyfykMMUI41IzzrVson+WczBWqbtLM3f0N6ahUSVNMXqRsBASMWU?=
 =?us-ascii?Q?3asD8/f1taRCDTE=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3wCg2vSNk9Z25uid5mZAHBIyQxMc9PsCyx5u8VHpQcHBuxBIWs3miK41avD0R4mBqSNErFoa7uSebmOjJeSvzyIXUU2oY8H+/jGnaw0wfKU0Vs1Avd4jlgs3NEs5rlIIU2nOfYtxd+25Fmh2JVsG5W/EY2t0IJLrL3bJTTdcZRkoMpmRgcDr2FSs+IVYHK8ST1x4yab+7ViKEjb4pY+Amo1LBBvPVWUZE7kpDNc1q7TUM6zSPsE8f8IsTSA2imjiTSGR4uG8jzQ4/WJ75WuuOQTjpbu68hpyy0YZ9/KGaTyiQ9Db3H3rA3G5fBF0pFSuianh7lIFn16wfxLuZYQGmTANvykxpoYxeeKQsrJyquoeFxzQUpOoQHjfZ5hNBjD8Me1KRwdGReSdFVtQCVO+aKiHe5qox0gBljYOndMRnnWxkp2lwol0XskvNRTJr/fZYQMOG8HZq2QTdk4jF3qmcpCHEsvnojElG5QGwq2zBv7MllCUyVk0XayXp+dqhCl+P3JmfE1tZSmv7diRRSldUXcccoP1uQrxXi4hLY7DzLmy9XYHkmaYANBz4dJx28zmwIRisn5vvBXZPhN664ihDn73FWtNA72kSeBXNbGgiEPsDFpxHIoCEHHZDU52JIEB3JlvIDTFvNMZT+EAsVJqcnhOaZwKbDmKoMKC9Fx7lkI=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:19.0525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df45a02-4339-4b93-0bbb-08dd51fa8635
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0843
X-BESS-ID: 1740089060-312005-29061-14088-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYm5hbGQGYGUNTQIC3Z1MzIwD
 I10dLc0CItyTTJ0NDANM00JcU82cDUUKk2FgCM+ALdQgAAAA==
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan21-197.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 1.00 BSF_SC7_GK0121_1       META: Custom rule BSF_SC7_GK0121_1 
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC7_GK0121_1
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

Add link state management and NIM reset functionality

- Implement phy_get_link_state to retrieve PHY link state.
- Implement adjust_maturing_delay to adjust link maturing delay.
- Implement get/set to operate current link state.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 171 ++++++++++++++++++
 drivers/net/ntnic/meson.build                 |   1 +
 .../ntnic/nthw/core/include/nthw_pca9532.h    |  22 +++
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |   9 +
 drivers/net/ntnic/nthw/core/nthw_pca9532.c    |  40 ++++
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |  51 +++++-
 drivers/net/ntnic/nthw/nthw_drv.h             |   2 +
 7 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_pca9532.c

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 9193f21f6f..00a30f24a5 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -43,6 +43,38 @@ void link_agx_100g_init(void)
  * Phy handling
  */
 
+static void phy_get_link_state(adapter_info_t *drv,
+	int port,
+	nt_link_state_p p_curr_link_state,
+	nt_link_state_p p_latched_links_state,
+	uint32_t *p_local_fault,
+	uint32_t *p_remote_fault)
+{
+	uint32_t status = 0;
+	uint32_t status_latch = 0;
+
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+
+	nthw_phy_tile_get_link_summary(p,
+		&status,
+		&status_latch,
+		p_local_fault,
+		p_remote_fault,
+		port);
+
+	if (status == 0x0)
+		*p_curr_link_state = NT_LINK_STATE_DOWN;
+
+	else
+		*p_curr_link_state = NT_LINK_STATE_UP;
+
+	if (status_latch == 0x0)
+		*p_latched_links_state = NT_LINK_STATE_DOWN;
+
+	else
+		*p_latched_links_state = NT_LINK_STATE_UP;
+}
+
 static void phy_rx_path_rst(adapter_info_t *drv, int port, bool reset)
 {
 	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
@@ -242,6 +274,135 @@ static void set_nim_low_power(nim_i2c_ctx_p ctx, uint8_t nim_idx, bool low_power
 	}
 }
 
+/*
+ * Link handling
+ */
+
+static void adjust_maturing_delay(adapter_info_t *drv, int port)
+{
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+	nthw_rpf_t *p_rpf = drv->fpga_info.mp_nthw_agx.p_rpf;
+	/*
+	 * Find the maximum of the absolute values of the RX componensation for all
+	 * ports (the RX componensation may not be set for some of the other ports).
+	 */
+	const int16_t unset_rx_compensation = -1;	/* 0xffff */
+	int16_t max_comp = 0;
+
+	for (int i = 0; i < drv->fpga_info.n_phy_ports; i++) {
+		int16_t comp = (int16_t)nthw_phy_tile_get_timestamp_comp_rx(p, i);
+
+		if (comp != unset_rx_compensation && abs(comp) > abs(max_comp))
+			max_comp = comp;
+	}
+
+	int delay = nthw_rpf_get_maturing_delay(p_rpf) - max_comp;
+
+	/*
+	 * For SOF time-stamping account for jumbo frame.
+	 * Frame size = 80000 b. divided by Gb link speed = processing time in ns.
+	 */
+	if (!nthw_rpf_get_ts_at_eof(p_rpf)) {
+		uint32_t jumbo_frame_processing_time_ns = 80000U / 100U;
+		delay -= (int)jumbo_frame_processing_time_ns;
+	}
+
+	const unsigned int delay_bit_width = 19;/* 19 bits maturing delay */
+	const int min_delay = -(1 << (delay_bit_width - 1));
+	const int max_delay = 0;
+
+	if (delay >= min_delay && delay <= max_delay) {
+		nthw_rpf_set_maturing_delay(p_rpf, delay);
+
+	} else {
+		NT_LOG(WRN, NTNIC,
+			"Port %u: Cannot set the RPF adjusted maturing delay to %i because "
+			"that value is outside the legal range [%i:%i]",
+			port, delay, min_delay, max_delay);
+	}
+}
+
+static void set_link_state(adapter_info_t *drv, nim_i2c_ctx_p ctx, link_state_t *state, int port)
+{
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+	/*
+	 * 100G: 4 LEDs per port
+	 */
+
+	bool led_on = state->nim_present && state->link_state == NT_LINK_STATE_UP;
+	uint8_t led_pos = (uint8_t)(port * ctx->lane_count);
+
+	for (uint8_t i = 0; i < ctx->lane_count; i++) {
+		nthw_pca9532_set_led_on(drv->fpga_info.mp_nthw_agx.p_pca9532_led, led_pos + 1,
+			led_on);
+	}
+
+	nthw_phy_tile_set_timestamp_comp_rx(p, port, 0);
+
+	if (ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena) {
+		/* Updated after mail from JKH 2023-02-07 */
+		nthw_phy_tile_set_timestamp_comp_rx(p, port, 0x9E);
+		/* TODO Hermosa Awaiting comp values to use */
+
+	} else {
+		/* TODO Hermosa Awaiting comp values to use */
+		nthw_phy_tile_set_timestamp_comp_rx(p, port, 0);
+	}
+
+	adjust_maturing_delay(drv, port);	/* MUST be called after timestampCompRx */
+}
+
+static void get_link_state(adapter_info_t *drv, nim_i2c_ctx_p ctx, link_state_t *state, int port)
+{
+	uint32_t local_fault;
+	uint32_t remote_fault;
+	nt_link_state_t curr_link_state;
+
+	nthw_phy_tile_t *p = drv->fpga_info.mp_nthw_agx.p_phy_tile;
+
+	/* Save the current state before reading the new */
+	curr_link_state = state->link_state;
+
+	phy_get_link_state(drv, port, &state->link_state, &state->link_state_latched, &local_fault,
+		&remote_fault);
+
+	if (curr_link_state != state->link_state)
+		NT_LOG(DBG, NTNIC, "Port %d: Faults(Local = %d, Remote = %d)", port, local_fault,
+			remote_fault);
+
+	state->nim_present = nim_is_present(ctx, port);
+
+	if (!state->nim_present)
+		return;	/* No nim so no need to do anything */
+
+	state->link_up = state->link_state == NT_LINK_STATE_UP ? true : false;
+
+	if (state->link_state == NT_LINK_STATE_UP)
+		return;	/* The link is up so no need to do anything else */
+
+	if (remote_fault == 0) {
+		phy_reset_rx(drv, port);
+		NT_LOG(DBG, NTNIC, "Port %u: resetRx due to local fault.", port);
+		return;
+	}
+
+	/* In case of too many errors perform a reset */
+	if (nthw_phy_tile_get_rx_hi_ber(p, port)) {
+		NT_LOG(INF, NTNIC, "Port %u: HiBer", port);
+		phy_reset_rx(drv, port);
+		return;
+	}
+
+	/* If FEC is not enabled then no reason to look at FEC state */
+	if (!ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena ||
+		nthw_phy_tile_read_fec_enabled_by_scratch(p, port)) {
+		return;
+	}
+
+	if (!nthw_phy_tile_get_rx_am_lock(p, port))
+		phy_reset_rx(drv, port);
+}
+
 /*
  * Utility functions
  */
@@ -645,6 +806,7 @@ static void *_common_ptp_nim_state_machine(void *data)
 
 	while (monitor_task_is_running[adapter_no]) {
 		int i;
+		static bool reported_link[NUM_ADAPTER_PORTS_MAX] = { false };
 
 		for (i = 0; i < nb_ports; i++) {
 			const bool is_port_disabled = link_info->port_action[i].port_disable;
@@ -691,12 +853,14 @@ static void *_common_ptp_nim_state_machine(void *data)
 				continue;
 			}
 
+			get_link_state(drv, nim_ctx, &link_state[i], i);
 			link_state[i].link_disabled = is_port_disabled;
 
 			if (!link_state[i].nim_present) {
 				if (!link_state[i].lh_nim_absent) {
 					NT_LOG(INF, NTNIC, "%s: NIM module removed",
 						drv->mp_port_id_str[i]);
+					reported_link[i] = false;
 					link_state[i].link_up = false;
 					link_state[i].lh_nim_absent = true;
 
@@ -707,6 +871,13 @@ static void *_common_ptp_nim_state_machine(void *data)
 
 				continue;
 			}
+
+			if (reported_link[i] != link_state[i].link_up) {
+				NT_LOG(INF, NTNIC, "%s: link is %s", drv->mp_port_id_str[i],
+					(link_state[i].link_up ? "up" : "down"));
+				reported_link[i] = link_state[i].link_up;
+				set_link_state(drv, nim_ctx, &link_state[i], i);
+			}
 		}
 
 		if (monitor_task_is_running[adapter_no])
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index b1505c5549..92aad6f94d 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -55,6 +55,7 @@ sources = files(
         'nthw/core/nthw_iic.c',
         'nthw/core/nthw_mac_pcs.c',
         'nthw/core/nthw_pcie3.c',
+        'nthw/core/nthw_pca9532.c',
         'nthw/core/nthw_pcal6416a.c',
         'nthw/core/nthw_phy_tile.c',
         'nthw/core/nthw_si5332_si5156.c',
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h b/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
new file mode 100644
index 0000000000..24da937a18
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
@@ -0,0 +1,22 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef __NTHW_PCA9532_H__
+#define __NTHW_PCA9532_H__
+
+#include "nthw_si5332_si5156.h"
+
+struct nthw_pca9532 {
+	nthw_i2cm_t *mp_nt_i2cm;
+	uint8_t m_dev_address;
+	nthw_pca9849_t *mp_ca9849;
+	uint8_t m_mux_channel;
+};
+
+typedef struct nthw_pca9532 nthw_pca9532_t;
+
+void nthw_pca9532_set_led_on(nthw_pca9532_t *p, uint8_t led_pos, bool state_on);
+
+#endif	/* __NTHW_PCA9532_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
index c810f55c0d..f84aef44a9 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -74,8 +74,17 @@ void nthw_phy_tile_set_host_loopback(nthw_phy_tile_t *p, uint8_t intf_no, uint8_
 void nthw_phy_tile_set_tx_equalization(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 	uint32_t pre_tap2, uint32_t main_tap, uint32_t pre_tap1,
 	uint32_t post_tap1);
+void nthw_phy_tile_get_link_summary(nthw_phy_tile_t *p, uint32_t *p_nt_phy_link_state,
+	uint32_t *p_ll_nt_phy_link_state, uint32_t *p_lh_local_fault,
+	uint32_t *p_lh_remote_fault, uint8_t index);
 void nthw_phy_tile_set_tx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset);
 void nthw_phy_tile_set_rx_reset(nthw_phy_tile_t *p, uint8_t intf_no, bool reset);
+bool nthw_phy_tile_read_fec_enabled_by_scratch(nthw_phy_tile_t *p, uint8_t intf_no);
+
+bool nthw_phy_tile_get_rx_hi_ber(nthw_phy_tile_t *p, uint8_t intf_no);
+bool nthw_phy_tile_get_rx_am_lock(nthw_phy_tile_t *p, uint8_t intf_no);
+void nthw_phy_tile_set_timestamp_comp_rx(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t value);
+uint32_t nthw_phy_tile_get_timestamp_comp_rx(nthw_phy_tile_t *p, uint8_t intf_no);
 
 uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address);
 void nthw_phy_tile_write_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address, uint32_t data);
diff --git a/drivers/net/ntnic/nthw/core/nthw_pca9532.c b/drivers/net/ntnic/nthw/core/nthw_pca9532.c
new file mode 100644
index 0000000000..fcf5463fcb
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_pca9532.c
@@ -0,0 +1,40 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include <pthread.h>
+
+#include "nt_util.h"
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_register.h"
+
+#include "nthw_pca9532.h"
+
+static const uint8_t led_sel_reg[4] = { 6, 7, 8, 9 };
+
+void nthw_pca9532_set_led_on(nthw_pca9532_t *p, uint8_t led_pos, bool state_on)
+{
+	if (led_pos >= 16) {
+		NT_LOG(ERR, NTHW, "Led pos (%u) out of range", led_pos);
+		return;
+	}
+
+	rte_spinlock_lock(&p->mp_nt_i2cm->i2cmmutex);
+	nthw_pca9849_set_channel(p->mp_ca9849, p->m_mux_channel);
+
+	uint8_t reg_addr = led_sel_reg[led_pos / 4];
+	uint8_t bit_pos = (uint8_t)((led_pos % 4) * 2);
+	uint8_t data = 0U;
+
+	nthw_i2cm_read(p->mp_nt_i2cm, p->m_dev_address, reg_addr, &data);
+	data = data & (uint8_t)(~(0b11 << bit_pos));	/* Set bits to "00" aka off */
+
+	if (state_on)
+		data = (uint8_t)(data | (0b01 << bit_pos));
+
+	nthw_i2cm_write(p->mp_nt_i2cm, p->m_dev_address, reg_addr, data);
+	rte_spinlock_unlock(&p->mp_nt_i2cm->i2cmmutex);
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index 42e2782f99..b057e9e88c 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -263,7 +263,34 @@ void nthw_phy_tile_set_tx_equalization(nthw_phy_tile_t *p, uint8_t intf_no, uint
 	nthw_phy_tile_write_xcvr(p, intf_no, lane, tx_eq_addr + 0x8000U * lane, data);
 }
 
-static bool nthw_phy_tile_read_fec_enabled_by_scratch(nthw_phy_tile_t *p, uint8_t intf_no)
+void nthw_phy_tile_get_link_summary(nthw_phy_tile_t *p, uint32_t *p_nt_phy_link_state,
+	uint32_t *p_ll_nt_phy_link_state, uint32_t *p_lh_local_fault,
+	uint32_t *p_lh_remote_fault, uint8_t index)
+{
+	nthw_register_update(p->mp_reg_link_summary[index]);
+
+	if (p_nt_phy_link_state) {
+		*p_nt_phy_link_state =
+			nthw_field_get_val32(p->mp_fld_link_summary_nt_phy_link_state[index]);
+	}
+
+	if (p_ll_nt_phy_link_state) {
+		*p_ll_nt_phy_link_state =
+			nthw_field_get_val32(p->mp_fld_link_summary_ll_nt_phy_link_state[index]);
+	}
+
+	if (p_lh_local_fault) {
+		*p_lh_local_fault =
+			nthw_field_get_val32(p->mp_fld_link_summary_lh_received_local_fault[index]);
+	}
+
+	if (p_lh_remote_fault) {
+		*p_lh_remote_fault =
+			nthw_field_get_val32(p->mp_fld_link_summary_lh_remote_fault[index]);
+	}
+}
+
+bool nthw_phy_tile_read_fec_enabled_by_scratch(nthw_phy_tile_t *p, uint8_t intf_no)
 {
 	bool fec_enabled = false;
 
@@ -292,6 +319,28 @@ static void nthw_phy_tile_write_fec_enabled_by_scratch(nthw_phy_tile_t *p, uint8
 	nthw_field_set_val_flush32(p->mp_fld_scratch_data, val);
 }
 
+bool nthw_phy_tile_get_rx_hi_ber(nthw_phy_tile_t *p, uint8_t intf_no)
+{
+	return nthw_field_get_updated(p->mp_fld_port_status_rx_hi_ber[intf_no]);
+}
+
+bool nthw_phy_tile_get_rx_am_lock(nthw_phy_tile_t *p, uint8_t intf_no)
+{
+	return nthw_field_get_updated(p->mp_fld_port_status_rx_am_lock[intf_no]);
+}
+
+void nthw_phy_tile_set_timestamp_comp_rx(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t value)
+{
+	nthw_field_get_updated(p->mp_fld_port_comp_rx_compensation[intf_no]);
+	nthw_field_set_val_flush32(p->mp_fld_port_comp_rx_compensation[intf_no], value);
+}
+
+uint32_t nthw_phy_tile_get_timestamp_comp_rx(nthw_phy_tile_t *p, uint8_t intf_no)
+{
+	nthw_field_get_updated(p->mp_fld_port_comp_rx_compensation[intf_no]);
+	return nthw_field_get_val32(p->mp_fld_port_comp_rx_compensation[intf_no]);
+}
+
 uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address)
 {
 	nthw_register_update(p->mp_reg_port_eth_base[intf_no]);
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index 1fc8df52ce..a3c54846f5 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -11,6 +11,7 @@
 
 #include "nthw_si5332_si5156.h"
 #include "nthw_pcal6416a.h"
+#include "nthw_pca9532.h"
 #include "nthw_phy_tile.h"
 #include "nthw_rpf.h"
 #include "nthw_phy_tile.h"
@@ -22,6 +23,7 @@ typedef struct nthw_agx_s {
 	nthw_i2cm_t *p_i2cm;
 	nthw_pca9849_t *p_pca9849;
 	nthw_pcal6416a_t *p_io_nim;	/* PCAL6416A I/O expander for controlling TS */
+	nthw_pca9532_t *p_pca9532_led;
 	nthw_phy_tile_t *p_phy_tile;
 	nthw_rpf_t *p_rpf;
 } nthw_agx_t;
-- 
2.45.0

