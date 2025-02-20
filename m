Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACF9C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:04:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EC3C40A70;
	Thu, 20 Feb 2025 23:04:24 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 8F3794069F
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:19 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 mx-outbound8-89.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxUAvE8gtEVta9jYzVdSOX/ndMMpnVhiNQqDdlf0K5wfJiUBk9YaAoLcrlO5HFGPoLlHtypLDsEn4FLrA3xL86lCe97EA68FnX+METLcI5Mf9lU1fLtitXvLZAXV/DQwYZpbtw0U3YWW8DxI/XhBgfLK+lm5fj17TCmyDyp52WOUV7S2VUUzxydDKbH21xf6oFu4uRC5DHaljGCAmTuFtz8Vpa9pJy50CrVCSy46KecpSwJtaDeNHsTjD65D0eYnsUZawKjhNjS+FzbX/2jbe7yoTmUOza2Im8Gry7qEpBk4J1s2gNKAvUnGEPmWiGRk5Q9pL8Fx39cwzUlHkWTXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lVon79qjeZSym6XjLrgxLAJsWKAnSLQioi6vfCBZsc=;
 b=MjsI9eo269cMnNqaRPjdvfwl159kU/EYhs56e8719chwG2EjYxdW6ct08AlpVNSoZstD9m+H5natOpowW7gZacs0LTPx2lWNh3zul4K4+A9as7grhRTkABofY7/Ff/qaL+SXx9c6y6TPYDzdssHkVcOWie6IuW7sRbOSRfKuhNxlUbRrcmuQat8P51qJ531XCRcG+RKxaa14DW3bCPFD3Fmwy9QU1kVHUFOUGGPon014HKl2A8Z7X+hsSIL5tsnsMt6oFlVMpNlgYAQzFdjD9pkl0mdwvcXGXqtIrUSfIHtfRGXuexOTu9C0bAOPoovOqwxEdyY85Ig+C0ydgroF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lVon79qjeZSym6XjLrgxLAJsWKAnSLQioi6vfCBZsc=;
 b=a6pRZuHwSQK47k06V39xUVR7Oxa28rFZLbHUozh/vAaVl5LuZ2TUzHYHBFYcOaiAV8t+OOW7VsDcVfcVeMCDzLrDpBK5ECxpJZz08/mv1mZzHs9YQHcFggzYVYHhzAX6tdwmHApywYjWDIl+dOyOQHv/HBDbf045gBEG6/oiT/w=
Received: from CWLP265CA0498.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::12)
 by PR3P190MB0827.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:88::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 22:04:17 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::65) by CWLP265CA0498.outlook.office365.com
 (2603:10a6:400:18b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:16 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 07/32] net/ntnic: add 100 gbps port init
Date: Thu, 20 Feb 2025 23:03:31 +0100
Message-ID: <20250220220406.3925597-8-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PR3P190MB0827:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a01c66d-3028-4174-df23-08dd51fa84e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ge1S9tFYB+9bYywLwaGnOdI7Vg5qH5B4BfFgOPXRm/sqw6rWJz5ZMOAycvAw?=
 =?us-ascii?Q?szj2VeCFC50HeGANpB7uJfza3f6rKzy1LdHzTfaeOfbYqoYxY1KVgoLJ1aDh?=
 =?us-ascii?Q?EwVdsIcVPzZj64QcT5Q7KpoPbqYLeWx+fnBpKpDpvjY33y0+ErLrQzLk8fLR?=
 =?us-ascii?Q?X/NIJbmLPljHZ4KgGcRGxOKVLHJDCPZJOq1W7Cs3M8laOH/kz33Hk3NqjoJQ?=
 =?us-ascii?Q?iBddHnKk08EaH2gzKaR9zCXsj/ePEr6AFIqBtxvjLpvyV6c23D0MApy3x+TL?=
 =?us-ascii?Q?vKNx8VinDgNq4FgmVDUy+d1YOu3Du8MgkGGR/9yKRrsKuXM/9Cglx3Jpc5Mk?=
 =?us-ascii?Q?Vo+tL3YvFjfyjGc7G6vQ/XcbDKAF9uE6NBV82NGckVq64D5jAgvUXU7Cf5h2?=
 =?us-ascii?Q?9E3PXWBlUp8OqISr/srWaiMbKprGmBwcODP7Nybcnjsgm8Hx9QstnNo8KPop?=
 =?us-ascii?Q?e5bZVTf3BChY8R4+VSuxFdxquwTR/NorijVW0LC/EQ4IANL8+HsLDUpU6QdJ?=
 =?us-ascii?Q?Se481px5ORF+2QuYKlf1dYv4fYOLbcS8MTW8lTwaDIQhSr8ok5nt0oI73h0y?=
 =?us-ascii?Q?+EwpyToOJRwizxGVhr8+IfPebVGRxjzjmrair7uSJc//lIlsz5ycubR76TAF?=
 =?us-ascii?Q?+XmWA53ok+RM9SB2WqDNN1sY2uIR2KWZLwFblhkpGosUv8lmYrqwTyIK5Ox7?=
 =?us-ascii?Q?l8GrZMvvjCZ1vHQ8uzjj53B8jiii08O7HVZIDvaw8k9hW+ZjqI7Q9IaZwJaT?=
 =?us-ascii?Q?ZxHbQkEoVy4yYxM8YvbHszGzew58RUuAjT5Agk6iAMWCLxiQ5b1cEtjK85MZ?=
 =?us-ascii?Q?N5G5o0GsRI3eHJrQcaWqPDpa5BKrPxIc8Fa4m0BcmOPFtUQAi+h9XsaQ2sK2?=
 =?us-ascii?Q?9q6tVdtSgdJuImDgGufAlEQtJfLrGM4naYN5vpY2QEhUm8h6H2TCJEPy+u1V?=
 =?us-ascii?Q?DHv/CFEdyCiNjaslwyQLoIEz139v7roENJ4AZ83cgk6OhMB7grKGjr4jhJ+n?=
 =?us-ascii?Q?IvRRyMnS14PuF2xFXKGE0mEu+gVxV84nXJq5kAi04SuEut3ZUnJEdIWPfm5a?=
 =?us-ascii?Q?OpJEcoIm8i671nXOz/0AUcqHqd3lbENklNf5OOTweAMUDnJzuiGd/fHJz4y5?=
 =?us-ascii?Q?Ca5beE7RF7BKMzuu6jVoOanEnLTMK9Tkxwwbz8vle+6wd04SkJEt6VazscqA?=
 =?us-ascii?Q?YIZGrtACYxLYn/ZLEhli2mD15ZYpfqMOvqCqyyQciwG2mp15O2eqFLs05cVO?=
 =?us-ascii?Q?v/9DonhopeAbB6HTeqi8D03q70buKgNrZNYpp2/G2YnDP0sO5lwr27SAV4ts?=
 =?us-ascii?Q?4W3B3L6EGocf8FGo4dJj4kVFa7tz/CtMrL1NnRJBfYegrY8UPRy2zm8tsf3I?=
 =?us-ascii?Q?zqKUHM+uZ9O61JbilpEgUvTp3CuBxnyayNfEweAEXg/Sbkg+qpSJx9WbUYUL?=
 =?us-ascii?Q?P+VmUBsNd5GYeNg8E8fKB5FETa6a854/9SNe/O2BLrCKAFdj/3Q7VVPjvRF+?=
 =?us-ascii?Q?D2YSXnF3WVBcijM=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MH5HsiWwiImjSUwOsZdPD5vbpqFKG4PR2gc4Fw74ekunPe6McIks1Bq0VqfNcWuHhZTeV6m3T0nz9wrzWSwgb4X55Nz7GUzfW5bKsidG1dPP0+Hn0xBAzuPoZbJBkuUoLQlo1XhC/UfhBVP6lceTueOBQFMrIatZOARIVuuUVR3xjQmxkeVBzl5e5yZy1b+ezywhmWJ1D35voZB5lLiF02LQZ/0RHOkJ+gc5ke5DWHV1K+I4kByTJalfrMr9ZpU3Vr+fyg3K7TZ+fFD1SDh3ahAzxBaOpKosK4+UFkDooN3P4NLWDGT1vixhWO4D8mwAlz4JB0ybK0lVF+MMZKC1fOIpv4CqH+vfRVxMZY/dfCW5Ja9CxySniKUPiOswTznd295UCuDlYl1B1I3Xl8R3TgYpmocwRAdFpTqy9BZEeXJ0/wALdvFi0ydduMJmB7KcEIC7PJYFr2/A1OdoYDrBSXpLEo9A3EG0+559ldEU/mjo9+k8uK8s3DRbPPM71cgI26fRkhT9DUiF237RBVnJZnU1x21T55JVjS+1nxhGrUaU4d37HU9AssEzcKQxfe4bBVYDn59wAoXF7WfdL1awPW/J7G6PswusiyPhGytMX+jONr7q+jnecCr1qtM4hPnoirKb7MVdHlXuTzjRuzWX05yKqKNy6XznqQy5I6oEokU=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:16.8650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01c66d-3028-4174-df23-08dd51fa84e4
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0827
X-BESS-ID: 1740089058-302137-23558-14689-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGBhZmQGYGUDTFwjjN2NQ42S
 jFzMQkxSTV2CgtOcnAwCjFyMg8JSXVVKk2FgBkMlrhQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-102.eu-central-1b.ess.aws.cudaops.com]
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

Initialize NIM and 100G port for Agilex FPGA

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 143 ++++++++++++++++++
 drivers/net/ntnic/meson.build                 |   1 +
 .../net/ntnic/nthw/core/include/nthw_gmf.h    |   2 +
 .../ntnic/nthw/core/include/nthw_pcal6416a.h  |  10 ++
 drivers/net/ntnic/nthw/core/nthw_gmf.c        |  41 +++++
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |  41 +++++
 6 files changed, 238 insertions(+)
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 9551dfdfdc..6593c90ca5 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -197,6 +197,26 @@ static int phy_set_line_loopback(adapter_info_t *drv, int port, loopback_line_t
 	return 0;
 }
 
+/*
+ * Nim handling
+ */
+
+static bool nim_is_present(nim_i2c_ctx_p ctx, uint8_t nim_idx)
+{
+	assert(nim_idx < NUM_ADAPTER_PORTS_MAX);
+
+	nthw_pcal6416a_t *p = ctx->hwagx.p_io_nim;
+	uint8_t data = 0;
+
+	if (nim_idx == 0)
+		nthw_pcal6416a_read(p, 3, &data);
+
+	else if (nim_idx == 1)
+		nthw_pcal6416a_read(p, 7, &data);
+
+	return data == 0;
+}
+
 /*
  * Utility functions
  */
@@ -295,6 +315,119 @@ set_loopback(struct adapter_info_s *p_adapter_info, int port, uint32_t mode, uin
 	nt_os_wait_usec(10000);	/* 10ms - arbitrary choice */
 }
 
+/*
+ * Initialize NIM, Code based on nt400d1x.cpp: MyPort::createNim()
+ */
+
+static int create_nim(adapter_info_t *drv, int port, bool enable)
+{
+	int res = 0;
+	const uint8_t valid_nim_id = NT_NIM_QSFP28;
+	sfp_nim_state_t nim;
+	nt4ga_link_t *link_info = &drv->nt4ga_link;
+	nim_i2c_ctx_t *nim_ctx = &link_info->u.nim_ctx[port];
+
+	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	assert(link_info->variables_initialized);
+
+	if (!enable) {
+		phy_reset_rx(drv, port);
+		phy_reset_tx(drv, port);
+	}
+
+	/*
+	 * Wait a little after a module has been inserted before trying to access I2C
+	 * data, otherwise the module will not respond correctly.
+	 */
+	nt_os_wait_usec(1000000);	/* pause 1.0s */
+
+	res = construct_and_preinit_nim(nim_ctx, NULL);
+
+	if (res)
+		return res;
+
+	res = nim_state_build(nim_ctx, &nim);
+
+	if (res)
+		return res;
+
+	/* Set FEC to be enabled by default */
+	nim_ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena = true;
+
+	NT_LOG(DBG, NTHW, "%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
+		drv->mp_port_id_str[port], nim_ctx->nim_id, nim_id_to_text(nim_ctx->nim_id), nim.br,
+		nim_ctx->vendor_name, nim_ctx->prod_no, nim_ctx->serial_no);
+
+	/*
+	 * Does the driver support the NIM module type?
+	 */
+	if (nim_ctx->nim_id != valid_nim_id) {
+		NT_LOG(ERR, NTHW, "%s: The driver does not support the NIM module type %s",
+			drv->mp_port_id_str[port], nim_id_to_text(nim_ctx->nim_id));
+		NT_LOG(DBG, NTHW, "%s: The driver supports the NIM module type %s",
+			drv->mp_port_id_str[port], nim_id_to_text(valid_nim_id));
+		return -1;
+	}
+
+	return res;
+}
+
+/*
+ * Initialize one 100 Gbps port.
+ */
+static int _port_init(adapter_info_t *p_info, nthw_fpga_t *fpga, int port)
+{
+	uint8_t adapter_no = p_info->adapter_no;
+	int res;
+
+	nt4ga_link_t *link_info = &p_info->nt4ga_link;
+	nthw_gfg_t *p_gfg = &link_info->u.var_a100g.gfg[adapter_no];
+	nthw_phy_tile_t *p_phy_tile = p_info->fpga_info.mp_nthw_agx.p_phy_tile;
+	nthw_rpf_t *p_rpf = p_info->fpga_info.mp_nthw_agx.p_rpf;
+
+	assert(port >= 0 && port < NUM_ADAPTER_PORTS_MAX);
+	assert(link_info->variables_initialized);
+
+	link_info->link_info[port].link_speed = NT_LINK_SPEED_100G;
+	link_info->link_info[port].link_duplex = NT_LINK_DUPLEX_FULL;
+	link_info->link_info[port].link_auto_neg = NT_LINK_AUTONEG_OFF;
+	link_info->speed_capa |= NT_LINK_SPEED_100G;
+
+	nthw_gfg_stop(p_gfg, port);
+
+	for (uint8_t lane = 0; lane < 4; lane++)
+		nthw_phy_tile_set_host_loopback(p_phy_tile, port, lane, false);
+
+	swap_tx_rx_polarity(p_info, port, true);
+	nthw_rpf_set_ts_at_eof(p_rpf, true);
+
+	NT_LOG(DBG, NTNIC, "%s: Setting up port %d", p_info->mp_port_id_str[port], port);
+
+	phy_reset_rx(p_info, port);
+
+	if (nthw_gmf_init(NULL, fpga, port) == 0) {
+		nthw_gmf_t gmf;
+
+		if (nthw_gmf_init(&gmf, fpga, port) == 0)
+			nthw_gmf_set_enable_tsi(&gmf, true, 0, 0, false);
+	}
+
+	nthw_rpf_unblock(p_rpf);
+
+	res = create_nim(p_info, port, true);
+
+	if (res) {
+		NT_LOG(WRN, NTNIC, "%s: NIM initialization failed",
+			p_info->mp_port_id_str[port]);
+		return res;
+	}
+
+	NT_LOG(DBG, NTNIC, "%s: NIM initialized", p_info->mp_port_id_str[port]);
+
+	phy_reset_rx(p_info, port);
+	return res;
+}
+
 /*
  * Link state machine
  */
@@ -310,6 +443,7 @@ static void *_common_ptp_nim_state_machine(void *data)
 	/* link_state_t new_link_state; */
 
 	link_state_t *link_state = link_info->link_state;
+	nim_i2c_ctx_t *nim_ctx = link_info->u.var_a100g.nim_ctx;
 
 	if (!fpga) {
 		NT_LOG(ERR, NTNIC, "%s: fpga is NULL", drv->mp_adapter_id_str);
@@ -361,6 +495,15 @@ static void *_common_ptp_nim_state_machine(void *data)
 				continue;
 
 			if (link_info->port_action[i].port_lpbk_mode != last_lpbk_mode[i]) {
+				/* Loopback mode has changed. Do something */
+				if (!nim_is_present(&nim_ctx[i], i)) {
+					/*
+					 * If there is no Nim present, we need to initialize the
+					 * port  anyway
+					 */
+					_port_init(drv, fpga, i);
+				}
+
 				set_loopback(drv,
 					i,
 					link_info->port_action[i].port_lpbk_mode,
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 271115cdd3..b1505c5549 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -55,6 +55,7 @@ sources = files(
         'nthw/core/nthw_iic.c',
         'nthw/core/nthw_mac_pcs.c',
         'nthw/core/nthw_pcie3.c',
+        'nthw/core/nthw_pcal6416a.c',
         'nthw/core/nthw_phy_tile.c',
         'nthw/core/nthw_si5332_si5156.c',
         'nthw/core/nthw_rpf.c',
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_gmf.h b/drivers/net/ntnic/nthw/core/include/nthw_gmf.h
index cc5be85154..c8beb2117c 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_gmf.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_gmf.h
@@ -58,6 +58,8 @@ struct nthw_gmf {
 typedef struct nthw_gmf nthw_gmf_t;
 
 int nthw_gmf_init(nthw_gmf_t *p, nthw_fpga_t *p_fpga, int n_instance);
+void nthw_gmf_set_enable_tsi(nthw_gmf_t *p, bool enable, int tsi_dynamic_offset,
+	int tsi_static_offset, bool tsi_always);
 
 void nthw_gmf_set_enable(nthw_gmf_t *p, bool enable);
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
index 636d2beb85..5ef14a0bc9 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
@@ -7,13 +7,23 @@
 
 #include <stdint.h>
 
+#include "nthw_i2cm.h"
+#include "nthw_si5332_si5156.h"
+
 /*
  * PCAL6416A I/O expander class
  */
 
 struct nthw_pcal6416a {
+	nthw_i2cm_t *mp_nt_i2cm;
+	uint8_t m_dev_address;
+	nthw_pca9849_t *mp_ca9849;
+	uint8_t m_mux_channel;
+	uint8_t m_config_data[2];
 };
 
 typedef struct nthw_pcal6416a nthw_pcal6416a_t;
 
+void nthw_pcal6416a_read(nthw_pcal6416a_t *p, uint8_t pin, uint8_t *value);
+
 #endif	/* __NTHW_PCAL6416A_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nthw_gmf.c b/drivers/net/ntnic/nthw/core/nthw_gmf.c
index 16a4c288bd..9fb708bc50 100644
--- a/drivers/net/ntnic/nthw/core/nthw_gmf.c
+++ b/drivers/net/ntnic/nthw/core/nthw_gmf.c
@@ -131,3 +131,44 @@ void nthw_gmf_set_enable(nthw_gmf_t *p, bool enable)
 	if (!p->m_administrative_block)
 		nthw_field_set_val_flush32(p->mp_ctrl_enable, enable ? 1 : 0);
 }
+
+void nthw_gmf_set_enable_tsi(nthw_gmf_t *p, bool enable, int tsi_dynamic_offset,
+	int tsi_static_offset, bool tsi_always)
+{
+	if (!p->m_administrative_block) {
+		nthw_field_update_register(p->mp_ctrl_enable);
+
+		if (p->mp_ctrl_ts_inject_always) {
+			/*
+			 * Do not force timestamp Inject- let the TBH control this now
+			 * Later we could consider an ini-setting for controlling this
+			 */
+			nthw_field_set_val_flush32(p->mp_ctrl_ts_inject_always,
+				tsi_always ? 1 : 0);
+		}
+
+		if (p->mp_ctrl_fcs_always) {
+			/*
+			 * Do not force FSC calculation - let the TBH control this
+			 * Later we could consider an ini-setting for controlling this
+			 */
+			nthw_field_set_val_flush32(p->mp_ctrl_fcs_always, 0);
+		}
+
+		if (p->mp_ts_inject) {
+			nthw_register_update(p->mp_ts_inject);
+
+			if (p->mp_ts_inject_pos) {
+				nthw_field_set_val_flush32(p->mp_ts_inject_pos,
+					(uint32_t)tsi_dynamic_offset);
+			}
+
+			if (p->mp_ts_inject_offset) {
+				nthw_field_set_val_flush32(p->mp_ts_inject_offset,
+					(uint32_t)tsi_static_offset);
+			}
+		}
+
+		nthw_field_set_val_flush32(p->mp_ctrl_enable, enable ? 1 : 0);
+	}
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
new file mode 100644
index 0000000000..37b6e7ec57
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
@@ -0,0 +1,41 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+#include <pthread.h>
+
+#include "nt_util.h"
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_register.h"
+
+#include "nthw_pcal6416a.h"
+
+static const uint8_t read_port[2] = { 0x00, 0x01 };
+
+/*
+ * PCAL6416A I/O expander class
+ */
+
+void nthw_pcal6416a_read(nthw_pcal6416a_t *p, uint8_t pin, uint8_t *value)
+{
+	uint8_t port;
+	uint8_t data;
+
+	rte_spinlock_lock(&p->mp_nt_i2cm->i2cmmutex);
+	nthw_pca9849_set_channel(p->mp_ca9849, p->m_mux_channel);
+
+	if (pin < 8) {
+		port = 0;
+
+	} else {
+		port = 1;
+		pin = (uint8_t)(pin - 8);
+	}
+
+	nthw_i2cm_read(p->mp_nt_i2cm, p->m_dev_address, read_port[port], &data);
+
+	*value = (data >> pin) & 0x1;
+	rte_spinlock_unlock(&p->mp_nt_i2cm->i2cmmutex);
+}
-- 
2.45.0

