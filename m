Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B509C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2EB240684;
	Wed, 30 Apr 2025 15:49:32 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 431F9402ED
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:21 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2109.outbound.protection.outlook.com [104.47.30.109]) by
 mx-outbound8-212.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxFlr5QQENTEIPrNx9cQidnr/qYeaburxMLmCLxBBAiDHy3BtBJMcQ9/FABC/ju9wi5mA3HOXXuw8h/bMGurM6USZ9cYJdBTCSA6jzy28ySnYWsOyRu0nPBpB7zSykIjZoTPQDRIEm4QXSIGhZqiWOSogu1st22RoV1zEsHyiL/kwhmioMFexIOVhHRUU9Z7bP7tn9QnIC9j+KthEjVQB/sylLg26qTrjRaaOebb6gEbiysenyHjP+hzaJ9+KIehE5nYpIU+tz5IsiC9Yl046qetSG/YeMi2nR0qhgKP8iGZ2Lr+mCCgx5Lj5N2wH9bRJ42q5rqgkIoBWmBadc1Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U67K+Uemz+HymxLg4Hc1S1nWo52WdYZf2ixP9l+LzWQ=;
 b=IY2G1OA7u37GFytAa1qvYgamSdRf945peV27QDdWvbHmLcsYuMdslpsGyCTNXGPDDQKyS+80BaqKLKP1qBZUL4YOXXbCsfTvQoK9Ylrt/dTQCSPQcqqUEfPrJNGfOeUp0QgPCafgmv8B3lbfnq4tySqtMyK5mJ6RNP7w8MQgo2lJLD0BBELZFcr7JfSEVhZHZg4ltyFLF++pRhKYLtXYUVyD2KffecZPG2P5+Uz4jVnwGCZK9g8f3zoO1cPYA2dOO7IN+inf3Re/W3qtsuU7FlHAXf0UYrKWWnN53JhmlyratnyRY1esnwx9SGmC3po/pHztKwmUPRBjdrBMDPkg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U67K+Uemz+HymxLg4Hc1S1nWo52WdYZf2ixP9l+LzWQ=;
 b=bpVGHzhGnQdTWg32nfevL+1A5RDyZFVmxgT5bQvU87QJG6xLNTCSzDlvmgZeG2RsoWodzFeKWJ6hnEz7GIZe+bw1FApxoWD2INRlYkRAVK34dWx1ltWSKg+RxR4Sy7XojcgBu51YnHnBYfQF6qBVADQcWhe6TSnDJtA44YVgpvE=
Received: from AM9P193CA0008.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::13)
 by VI1P190MB0718.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:121::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:49:11 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::2) by AM9P193CA0008.outlook.office365.com
 (2603:10a6:20b:21e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:11 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 08/25] net/ntnic: improve logging format specifiers
Date: Wed, 30 Apr 2025 15:48:20 +0200
Message-ID: <20250430134840.402553-9-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|VI1P190MB0718:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 088a999f-a4b8-4e3a-5215-08dd87edc985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RMdMGH1BSNkKSgefAmRLbZ3ykpge27IuHDtXO9hw9cDFO3JfaGIr7Bp8lu/S?=
 =?us-ascii?Q?mtFyP3yDz5zhKIZEmKzkb2yjrYY09jAdW1P8ZzG5H2wINNwIO6t+JZyYECMU?=
 =?us-ascii?Q?ZflGpH/adAGnkBIdbPsyp04j2ftdwFOMtsPLua5eKA++6Q1bc4fGh7gn4a0F?=
 =?us-ascii?Q?yoMPb7NIIy9ZyW9m8l9aiPUMGZutin22VhMuMbt/gabLSh2e7zdjWHbIFKiw?=
 =?us-ascii?Q?kZuRLLSrpAk4baa8zvv5Quf8JNQMUcVpOZZHOJI3y7auupYKz6yNWBiboqFn?=
 =?us-ascii?Q?Mh+vR/O5UVd4lxLF8vIF774vlzJ/FIo4oJLmKbXfMuxaU0ZWyZOL3doLbdii?=
 =?us-ascii?Q?vyqYIGoIwemieg/xQ9lqH0n6k7HDVHzt/2O+MtTl2TBTFqVil0S8B5TwYpL6?=
 =?us-ascii?Q?IYL7JXWSyRKy9B77Rz84fS7vCZ74WJsRVOzn3WuU7ugLxzkTwtE7s2PThvhT?=
 =?us-ascii?Q?3NbV/aDytBMkceRgLpC3oTRz2/o4vQv3ahGGMkU2GmcbVLcplcnSrHuWpIY4?=
 =?us-ascii?Q?p0oXiV5znNWygs3rOTJxWCG2pWyzM61gC3UoqajK4N0Gief09H1IcGRbP25a?=
 =?us-ascii?Q?sDYp6BcUqto0zhsH0NA3+gPYMBT2L9bZw36vyF5J9nVdxUFthOZ32S32yDiw?=
 =?us-ascii?Q?+P/UrwmAnJ0ESbfwKfzHz08x/NX9or9UtZyJ8KvnZ27kQBV/Pxplc+EbJ4z7?=
 =?us-ascii?Q?TYq8dFHyxVVs6wYfY1y2vISm9LdH+b3UiBAlU9fMG9B/qXcdL6GaIpPJpDhg?=
 =?us-ascii?Q?To/YgqQzfQCN71XE0ldkYvgLS8HdNDTv+r4catpCigaJ7K9rEMxDMZdv2+jL?=
 =?us-ascii?Q?wQAUmp1px+yG4VRSGHMCB1Z188PbSozL65LLmWw82XtjdQd5VsnDVIm9/iej?=
 =?us-ascii?Q?vgMuAp+7cOeHwS97bNLEvIm6afxMOwttwx6oT9+ZBh8WAlipqAFKu1Z/FlQT?=
 =?us-ascii?Q?TaPL2bN5pZVTo5thA2IFquwkskM5RGWwx9iG5BhDmSXUGPvoVzI5bFasctQM?=
 =?us-ascii?Q?fK4uP8v6ugPyMYLdceZeaE308a4K7x6pW3D+PT4xD3i7ywLyQFLmdsNJZsHy?=
 =?us-ascii?Q?ctIZy3o/YyXAzDYnPCNGjFEaQzKxDvebrHnw6D0nce15LbuOFiliNJOerjKz?=
 =?us-ascii?Q?NhJEf/gawsrzAezFLkVCNMiTlPPbJp3/nWjBaw+AwK8OBNSozJC8f05xiS0C?=
 =?us-ascii?Q?fQv+mX7m67f8h9PiQeFKRGlJSIR7qe8AcT0bmFdvlbj6U4JOklL4gfsex5hU?=
 =?us-ascii?Q?KZ+eNZO/CBnIhXVZTNcdYgOM1UDW6k9+6FPSWnYq0vrnS3dABsdadesp0geU?=
 =?us-ascii?Q?xBB6x4uaHG1O5EEEnjL//PF/sDOIBM5RLOB1VETpTpeI0oMDFIFYHih+gTXa?=
 =?us-ascii?Q?y+OVAbyOCwa1WZ+Et7uPuO0ITzqpkjqElBsbNGappgu7J4bkGYM8tFWdA2nF?=
 =?us-ascii?Q?14yb66mCkPT0hG8dnsEtAHhJxaUFwPbPDCJoyjq+SyoahCdOub6maKEmucJe?=
 =?us-ascii?Q?p9lO0N4gk4CuzssFP6TQ32a6bfHqp5B5AZyH?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vCXrtlDLoLDpAVb5QRiyM+T8eiSrLKYpSdxQKa7omKCnEp+0vyIYFXRZ1n0adjHt5fGyEJ2SWjc4Dt1uV3jyzCZyAGBDLeEOtp8pTPZHxwOdQyu/lCSVbiLhGZAiymW4Iy2/UkY1MIHssh3lSAm3GvYsFfpp6qck/RmJRAkEiPNrYVZjjlZqHaaxiXUiPrr1ac7yAA1EfJSrw2fTV2Ru8drDlSOy6iskGlLiaSySJR7XIUmAsLIxd3i4xVyf0O2zegHSfbF3cz19tiI2XmDIv+8Ba/IEnURni3AsL8XAz9ssKc6O8B+/dGbDMP9pqq0nY48f5/dPaNFVMQjsLHXUzw2PG7viwaQx53qqRDHbxA4A5oX/BeMMm+0sPZz9TDQR8LB0+MGsW7IdEkfTziIa6COCD8f48Onm3OUbiwJIe4fQRBOcSww5/oyXt6F1YLeTa7xHqZwu3pO5GpHS3Iatd6uHiBSyKrpm5C8Yx5S/5DnAPCIpQ+YkmSP/3Rz3LsAWNd5H1sXeBvqHZQbFnh/vJsjAZHpXaxFLmFbJBcOVCybEouPPOweofH6Oegja9vnDe02pLOmpxi0iQ+90x/4ynCZDn7H1aqdQ3jEk88f3iVWxzO+Slue5dKGlrAap67sxTipsn637y4SnAuHU2EVbCQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:11.2894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 088a999f-a4b8-4e3a-5215-08dd87edc985
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0718
X-BESS-ID: 1746020954-302260-7745-9113-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.30.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbG5kZmQGYGUNQ8LcnA3CwxLd
 k40cgy0czC0tjUwtTYONnMzMLQwNjCRKk2FgBXcI0XQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan22-232.eu-central-1b.ess.aws.cudaops.com]
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

Updated logging format specifiers for better consistency
and to match the expected data types

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  7 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  2 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 14 ++--
 drivers/net/ntnic/nthw/core/nthw_hif.c        |  5 +-
 drivers/net/ntnic/nthw/core/nthw_iic.c        |  2 +-
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |  2 +-
 drivers/net/ntnic/nthw/core/nthw_spi_v3.c     |  2 +-
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  7 +-
 .../net/ntnic/nthw/flow_api/flow_hsh_cfg.c    |  8 +-
 drivers/net/ntnic/nthw/flow_api/flow_km.c     |  6 +-
 .../profile_inline/flow_api_hw_db_inline.c    | 77 +++++++++++--------
 .../profile_inline/flow_api_profile_inline.c  | 16 ++--
 .../net/ntnic/nthw/model/nthw_fpga_model.c    |  4 +-
 drivers/net/ntnic/nthw/nthw_rac.c             | 22 +++---
 drivers/net/ntnic/ntnic_ethdev.c              | 30 +++++---
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  4 +-
 16 files changed, 116 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 889f47caab..526ecc8089 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -126,7 +126,7 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 			PCIIDENT_TO_BUSNR(p_adapter_info->fpga_info.pciident),
 			PCIIDENT_TO_DEVNR(p_adapter_info->fpga_info.pciident),
 			PCIIDENT_TO_FUNCNR(p_adapter_info->fpga_info.pciident));
-		NT_LOG(DBG, NTNIC, "%s: %s", p_adapter_id_str, p_dev_name);
+		NT_LOG(DBG, NTNIC, "%s: %s", p_adapter_id_str, p_dev_name ? p_dev_name : "NA");
 	}
 
 	{
@@ -147,8 +147,9 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 	res = nthw_fpga_init(&p_adapter_info->fpga_info);
 
 	if (res) {
-		NT_LOG_DBGX(ERR, NTNIC, "%s: %s: FPGA=%04d res=x%08X", p_adapter_id_str,
-			p_dev_name, fpga_info->n_fpga_prod_id, res);
+		NT_LOG_DBGX(ERR, NTNIC, "%s: %s: FPGA=%04d res=x%08X",
+			p_adapter_id_str ? p_adapter_id_str : "NA",
+			p_dev_name ? p_dev_name : "NA", fpga_info->n_fpga_prod_id, res);
 		return res;
 	}
 
diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 69cd184680..cc09fdcc4a 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -397,7 +397,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	int_enable = 0;
 	vec = 0;
 	istk = 0;
-	NT_LOG_DBGX(DBG, NTNIC, "set_rx_uw_data int=0 irq_vector=%u", irq_vector);
+	NT_LOG_DBGX(DBG, NTNIC, "set_rx_uw_data int=0 irq_vector=%i", irq_vector);
 
 	if (set_rx_uw_data(p_nthw_dbs, index,
 			(uint64_t)used_struct_phys_addr,
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index d27ceeea88..f1c17ea80a 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -316,7 +316,7 @@ static void adjust_maturing_delay(adapter_info_t *drv, int port)
 
 	} else {
 		NT_LOG(WRN, NTNIC,
-			"Port %u: Cannot set the RPF adjusted maturing delay to %i because "
+			"Port %i: Cannot set the RPF adjusted maturing delay to %i because "
 			"that value is outside the legal range [%i:%i]",
 			port, delay, min_delay, max_delay);
 	}
@@ -367,8 +367,8 @@ static void get_link_state(adapter_info_t *drv, nim_i2c_ctx_p ctx, link_state_t
 		&remote_fault);
 
 	if (curr_link_state != state->link_state)
-		NT_LOG(DBG, NTNIC, "Port %d: Faults(Local = %d, Remote = %d)", port, local_fault,
-			remote_fault);
+		NT_LOG(DBG, NTNIC, "Port %i: Faults(Local = %" PRIu32 ", Remote = %" PRIu32 ")",
+			port, local_fault, remote_fault);
 
 	state->nim_present = nim_is_present(ctx, port);
 
@@ -382,13 +382,13 @@ static void get_link_state(adapter_info_t *drv, nim_i2c_ctx_p ctx, link_state_t
 
 	if (remote_fault == 0) {
 		phy_reset_rx(drv, port);
-		NT_LOG(DBG, NTNIC, "Port %u: resetRx due to local fault.", port);
+		NT_LOG(DBG, NTNIC, "Port %i: resetRx due to local fault.", port);
 		return;
 	}
 
 	/* In case of too many errors perform a reset */
 	if (nthw_phy_tile_get_rx_hi_ber(p, port)) {
-		NT_LOG(INF, NTNIC, "Port %u: HiBer", port);
+		NT_LOG(INF, NTNIC, "Port %i: HiBer", port);
 		phy_reset_rx(drv, port);
 		return;
 	}
@@ -974,7 +974,7 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 		res = nthw_rpf_init(p_nthw_agx->p_rpf, fpga, adapter_no);
 
 		if (res != 0) {
-			NT_LOG(ERR, NTNIC, "%s: Failed to initialize RPF module (%u)",
+			NT_LOG(ERR, NTNIC, "%s: Failed to initialize RPF module (%i)",
 				p_adapter_info->mp_adapter_id_str, res);
 			return res;
 		}
@@ -982,7 +982,7 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 		res = nthw_gfg_init(&gfg_mod[adapter_no], fpga, 0 /* Only one instance */);
 
 		if (res != 0) {
-			NT_LOG(ERR, NTNIC, "%s: Failed to initialize GFG module (%u)",
+			NT_LOG(ERR, NTNIC, "%s: Failed to initialize GFG module (%i)",
 				p_adapter_info->mp_adapter_id_str, res);
 			return res;
 		}
diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index e1ca80046d..ddb875f625 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -79,8 +79,9 @@ int nthw_hif_init(nthw_hif_t *p, nthw_fpga_t *p_fpga, int n_instance)
 	NT_LOG(DBG, NTHW, "%s: HIF %d: %d-%d-%d-%d-%d", p_adapter_id_str, p->mn_instance,
 		p->mn_fpga_id_item, p->mn_fpga_id_prod, p->mn_fpga_id_ver,
 		p->mn_fpga_id_rev, p->mn_fpga_id_build_no);
-	NT_LOG(DBG, NTHW, "%s: HIF %d: HIF ref clock: %d Hz (%d ticks/ps)", p_adapter_id_str,
-		p->mn_instance, p->mn_fpga_hif_ref_clk_freq, p->mn_fpga_param_hif_per_ps);
+	NT_LOG(DBG, NTHW, "%s: HIF %d: HIF ref clock: %" PRIu32 " Hz (%d ticks/ps)",
+		p_adapter_id_str, p->mn_instance, p->mn_fpga_hif_ref_clk_freq,
+		p->mn_fpga_param_hif_per_ps);
 
 	p->mp_reg_build_seed = NULL;	/* Reg/Fld not present on HIF */
 	p->mp_fld_build_seed = NULL;	/* Reg/Fld not present on HIF */
diff --git a/drivers/net/ntnic/nthw/core/nthw_iic.c b/drivers/net/ntnic/nthw/core/nthw_iic.c
index 0d50721710..f84eb7eeb2 100644
--- a/drivers/net/ntnic/nthw/core/nthw_iic.c
+++ b/drivers/net/ntnic/nthw/core/nthw_iic.c
@@ -239,7 +239,7 @@ int nthw_iic_init(nthw_iic_t *p, nthw_fpga_t *p_fpga, int n_iic_instance,
 
 	/* Setup controller timing */
 	if (p->mn_iic_cycle_time) {
-		NT_LOG(DBG, NTHW, "%s: I2C%d: cycletime=%d", p_adapter_id_str,
+		NT_LOG(DBG, NTHW, "%s: I2C%d: cycletime=%" PRIu32 "", p_adapter_id_str,
 			p->mn_iic_instance, p->mn_iic_cycle_time);
 		nthw_iic_reg_set_timing(p, p->mn_iic_cycle_time);
 	}
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index 0dc2784034..eea220e40b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -83,7 +83,7 @@ int nthw_phy_tile_init(nthw_phy_tile_t *p, nthw_fpga_t *p_fpga, int mn_phy_tile_
 		break;
 
 	default:
-		NT_LOG_DBG(DBG, NTHW, "unknown product ID: %u", p_fpga->mn_product_id);
+		NT_LOG_DBG(DBG, NTHW, "unknown product ID: %i", p_fpga->mn_product_id);
 		break;
 	}
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
index 6ef739279a..a995b1fb6e 100644
--- a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
@@ -125,7 +125,7 @@ static void dump_hex(uint8_t *p_data, uint16_t count)
 int nthw_spi_v3_init(nthw_spi_v3_t *p, nthw_fpga_t *p_fpga, int n_instance_no)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
-	uint32_t result;
+	int result;
 
 	p->mn_instance_no = n_instance_no;
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 1455a1e508..358ea3e4fa 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -211,7 +211,7 @@ void nthw_flow_nic_free_resource(struct flow_nic_dev *ndev, enum res_type_e res_
 
 int nthw_flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
 {
-	NT_LOG(DBG, FILTER, "Reference resource %s idx %i (before ref cnt %i)",
+	NT_LOG(DBG, FILTER, "Reference resource %s idx %i (before ref cnt %" PRIu32 ")",
 		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
 	RTE_ASSERT(flow_nic_is_resource_used(ndev, res_type, index));
 
@@ -224,7 +224,7 @@ int nthw_flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_ty
 
 int nthw_flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
 {
-	NT_LOG(DBG, FILTER, "De-reference resource %s idx %i (before ref cnt %i)",
+	NT_LOG(DBG, FILTER, "De-reference resource %s idx %i (before ref cnt %" PRIu32 ")",
 		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
 	RTE_ASSERT(flow_nic_is_resource_used(ndev, res_type, index));
 	RTE_ASSERT(ndev->res[res_type].ref[index]);
@@ -425,7 +425,7 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 			int used = flow_nic_is_resource_used(ndev, i, ii);
 
 			if (ref || used) {
-				NT_LOG(DBG, FILTER, "  [%i]: ref cnt %i, used %i", ii, ref,
+				NT_LOG(DBG, FILTER, "  [%u]: ref cnt %i, used %i", ii, ref,
 					used);
 				err = 1;
 			}
@@ -434,7 +434,6 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 		if (err)
 			NT_LOG(DBG, FILTER, "ERROR - some resources not freed");
 	}
-
 }
 
 int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
index 624d1a26d1..b53252662b 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
@@ -71,11 +71,11 @@ static int hsh_set_part(struct flow_nic_dev *ndev, int hsh_idx, struct hsh_words
 	words[word].free = false;
 
 	res |= hw_mod_hsh_rcp_set(&ndev->be, words[word].pe, hsh_idx, 0, pe);
-	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %d)", words[word].pe,
-		hsh_idx, pe);
+	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %" PRIu32 ")",
+		(int)words[word].pe, hsh_idx, pe);
 	res |= hw_mod_hsh_rcp_set(&ndev->be, words[word].ofs, hsh_idx, 0, ofs);
-	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %d)", words[word].ofs,
-		hsh_idx, ofs);
+	NT_LOG(DBG, FILTER, "hw_mod_hsh_rcp_set(&ndev->be, %d, %d, 0, %" PRIu32 ")",
+		(int)words[word].ofs, hsh_idx, ofs);
 
 
 	/* set HW_HSH_RCP_WORD_MASK based on used QW/W and given 'bit_len' */
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_km.c b/drivers/net/ntnic/nthw/flow_api/flow_km.c
index e7ba07d7db..7b0fdddeea 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_km.c
@@ -580,7 +580,7 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 				}
 
 				NT_LOG(DBG, FILTER,
-					"Set KM QW0 sel A: dyn: %i, offs: %i, size: %i",
+					"Set KM QW0 sel A: dyn: %i, offs: %i, size: %" PRIu32 "",
 					km->match_map[i]->extr_start_offs_id,
 					km->match_map[i]->rel_offs, km->match_map[i]->word_len);
 
@@ -611,7 +611,7 @@ int km_rcp_set(struct km_flow_def_s *km, int index)
 				}
 
 				NT_LOG(DBG, FILTER,
-					"Set KM QW4 sel A: dyn: %i, offs: %i, size: %i",
+					"Set KM QW4 sel A: dyn: %i, offs: %i, size: %" PRIu32 "",
 					km->match_map[i]->extr_start_offs_id,
 					km->match_map[i]->rel_offs, km->match_map[i]->word_len);
 
@@ -788,7 +788,7 @@ static int move_cuckoo_index(struct km_flow_def_s *km)
 				km->cam_dist[CAM_KM_DIST_IDX(km->bank_used) + 1].km_owner = NULL;
 
 			NT_LOG(DBG, FILTER,
-				"KM Cuckoo hash moved from bank %i to bank %i (%04X => %04X)",
+				"KM Cuckoo hash moved from bank %i to bank %" PRIu32 " (%04X => %04X)",
 				km->bank_used, bank, CAM_KM_DIST_IDX(km->bank_used),
 				CAM_KM_DIST_IDX(bank));
 			km->bank_used = bank;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index ae72b8775e..fbb7b04cd1 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -423,9 +423,10 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 		case HW_DB_IDX_TYPE_MATCH_SET: {
 			const struct hw_db_inline_match_set_data *data =
 					&db->match_set[idxs[i].ids].data;
-			fprintf(file, "  MATCH_SET %d, priority %d\n", idxs[i].ids,
-				(int)data->priority);
-			fprintf(file, "    CAT id %d, KM id %d, KM_FT id %d, ACTION_SET id %d\n",
+			fprintf(file, "  MATCH_SET %" PRIu32 ", priority %u\n", idxs[i].ids,
+				(unsigned int)data->priority);
+			fprintf(file, "    CAT id %" PRIu32 ", KM id %" PRIu32
+				", KM_FT id %" PRIu32 ", ACTION_SET id %" PRIu32 "\n",
 				data->cat.ids, data->km.id1, data->km_ft.id1,
 				data->action_set.ids);
 
@@ -435,7 +436,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 					data->jump, &group_orig) < 0)
 					fprintf(file, "    Jumps to %d (encoded)\n", data->jump);
 				else
-					fprintf(file, "    Jumps to %d\n", group_orig);
+					fprintf(file, "    Jumps to %" PRIu32 "\n", group_orig);
 			}
 			break;
 		}
@@ -443,7 +444,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 		case HW_DB_IDX_TYPE_ACTION_SET: {
 			const struct hw_db_inline_action_set_data *data =
 					&db->action_set[idxs[i].ids].data;
-			fprintf(file, "  ACTION_SET %d\n", idxs[i].ids);
+			fprintf(file, "  ACTION_SET %" PRIu32 "\n", idxs[i].ids);
 
 			if (data->contains_jump) {
 				uint32_t group_orig = 0;
@@ -455,7 +456,9 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 					fprintf(file, "    Jumps to %d\n", group_orig);
 			} else {
 				fprintf(file,
-					"    COT id %d, QSL id %d, SLC_LR id %d, TPE id %d, HSH id %d, SCRUB id %d\n",
+					"    COT id %" PRIu32 ", QSL id %" PRIu32 ", SLC_LR id %"
+					PRIu32 ", TPE id %" PRIu32 ", HSH id %" PRIu32 ", SCRUB id %"
+					PRIu32 "\n",
 					data->cot.ids, data->qsl.ids, data->slc_lr.ids,
 					data->tpe.ids, data->hsh.ids, data->scrub.ids);
 			}
@@ -464,7 +467,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 
 		case HW_DB_IDX_TYPE_CAT: {
 			const struct hw_db_inline_cat_data *data = &db->cat[idxs[i].ids].data;
-			fprintf(file, "  CAT %d\n", idxs[i].ids);
+			fprintf(file, "  CAT %" PRIu32 "\n", idxs[i].ids);
 			fprintf(file, "    Port msk 0x%02x, VLAN msk 0x%02x\n",
 				(int)data->mac_port_mask, (int)data->vlan_mask);
 			fprintf(file,
@@ -479,7 +482,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 
 		case HW_DB_IDX_TYPE_QSL: {
 			const struct hw_db_inline_qsl_data *data = &db->qsl[idxs[i].ids].data;
-			fprintf(file, "  QSL %d\n", idxs[i].ids);
+			fprintf(file, "  QSL %" PRIu32 "\n", idxs[i].ids);
 
 			if (data->discard) {
 				fprintf(file, "    Discard\n");
@@ -491,7 +494,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 				break;
 			}
 
-			fprintf(file, "    Table size %d\n", data->table_size);
+			fprintf(file, "    Table size %" PRIu32 "\n", data->table_size);
 
 			for (uint32_t i = 0;
 				i < data->table_size && i < HW_DB_INLINE_MAX_QST_PER_QSL; ++i) {
@@ -506,7 +509,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 
 		case HW_DB_IDX_TYPE_COT: {
 			const struct hw_db_inline_cot_data *data = &db->cot[idxs[i].ids].data;
-			fprintf(file, "  COT %d\n", idxs[i].ids);
+			fprintf(file, "  COT %" PRIu32 "\n", idxs[i].ids);
 			fprintf(file, "    Color contrib %d, frag rcp %d\n",
 				(int)data->matcher_color_contrib, (int)data->frag_rcp);
 			break;
@@ -515,7 +518,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 		case HW_DB_IDX_TYPE_SLC_LR: {
 			const struct hw_db_inline_slc_lr_data *data =
 					&db->slc_lr[idxs[i].ids].data;
-			fprintf(file, "  SLC_LR %d\n", idxs[i].ids);
+			fprintf(file, "  SLC_LR %" PRIu32 "\n", idxs[i].ids);
 			fprintf(file, "    Enable %u, dyn %u, ofs %u\n", data->head_slice_en,
 				data->head_slice_dyn, data->head_slice_ofs);
 			break;
@@ -523,7 +526,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 
 		case HW_DB_IDX_TYPE_TPE: {
 			const struct hw_db_inline_tpe_data *data = &db->tpe[idxs[i].ids].data;
-			fprintf(file, "  TPE %d\n", idxs[i].ids);
+			fprintf(file, "  TPE %" PRIu32 "\n", idxs[i].ids);
 			fprintf(file, "    Insert len %u, new outer %u, calc eth %u\n",
 				data->insert_len, data->new_outer,
 				data->calc_eth_type_from_inner_ip);
@@ -557,7 +560,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 			const struct hw_db_inline_tpe_ext_data *data =
 					&db->tpe_ext[idxs[i].ids].data;
 			const int rpl_rpl_length = ((int)data->size + 15) / 16;
-			fprintf(file, "  TPE_EXT %d\n", idxs[i].ids);
+			fprintf(file, "  TPE_EXT %" PRIu32 "\n", idxs[i].ids);
 			fprintf(file, "    Encap data, size %u\n", data->size);
 
 			for (int i = 0; i < rpl_rpl_length; ++i) {
@@ -575,25 +578,33 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 
 		case HW_DB_IDX_TYPE_FLM_RCP: {
 			const struct hw_db_inline_flm_rcp_data *data = &db->flm[idxs[i].id1].data;
-			fprintf(file, "  FLM_RCP %d\n", idxs[i].id1);
-			fprintf(file, "    QW0 dyn %u, ofs %u, QW4 dyn %u, ofs %u\n",
-				data->qw0_dyn, data->qw0_ofs, data->qw4_dyn, data->qw4_ofs);
-			fprintf(file, "    SW8 dyn %u, ofs %u, SW9 dyn %u, ofs %u\n",
-				data->sw8_dyn, data->sw8_ofs, data->sw9_dyn, data->sw9_ofs);
-			fprintf(file, "    Outer prot %u, inner prot  %u\n", data->outer_prot,
-				data->inner_prot);
+			fprintf(file, "  FLM_RCP %" PRIu32 "\n", idxs[i].id1);
+			fprintf(file, "    QW0 dyn %" PRIu64 ", ofs %" PRIu64
+				 ", QW4 dyn %" PRIu64 ", ofs %" PRIu64 "\n",
+				(uint64_t)data->qw0_dyn, (uint64_t)data->qw0_ofs,
+				(uint64_t)data->qw4_dyn, (uint64_t)data->qw4_ofs);
+			fprintf(file, "    SW8 dyn %" PRIu64 ", ofs %" PRIu64
+				 ", SW9 dyn %" PRIu64 ", ofs %" PRIu64 "\n",
+				(uint64_t)data->sw8_dyn, (uint64_t)data->sw8_ofs,
+				(uint64_t)data->sw9_dyn, (uint64_t)data->sw9_ofs);
+			fprintf(file, "    Outer prot  %" PRIu64 ", inner prot   %" PRIu64 "\n",
+				(uint64_t)data->outer_prot, (uint64_t)data->inner_prot);
 			fprintf(file, "    Mask:\n");
-			fprintf(file, "      %08x %08x %08x %08x %08x\n", data->mask[0],
-				data->mask[1], data->mask[2], data->mask[3], data->mask[4]);
-			fprintf(file, "      %08x %08x %08x %08x %08x\n", data->mask[5],
-				data->mask[6], data->mask[7], data->mask[8], data->mask[9]);
+			fprintf(file, "      %08x %08x %08x %08x %08x\n",
+				(uint32_t)data->mask[0], (uint32_t)data->mask[1],
+				(uint32_t)data->mask[2], (uint32_t)data->mask[3],
+				(uint32_t)data->mask[4]);
+			fprintf(file, "      %08x %08x %08x %08x %08x\n",
+				(uint32_t)data->mask[5], (uint32_t)data->mask[6],
+				(uint32_t)data->mask[7], (uint32_t)data->mask[8],
+				(uint32_t)data->mask[9]);
 			break;
 		}
 
 		case HW_DB_IDX_TYPE_FLM_FT: {
 			const struct hw_db_inline_flm_ft_data *data =
 					&db->flm[idxs[i].id2].ft[idxs[i].id1].data;
-			fprintf(file, "  FLM_FT %d\n", idxs[i].id1);
+			fprintf(file, "  FLM_FT %" PRIu32 "\n", idxs[i].id1);
 
 			if (data->is_group_zero)
 				fprintf(file, "    Jump to %d\n", data->jump);
@@ -607,7 +618,7 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 
 		case HW_DB_IDX_TYPE_KM_RCP: {
 			const struct hw_db_inline_km_rcp_data *data = &db->km[idxs[i].id1].data;
-			fprintf(file, "  KM_RCP %d\n", idxs[i].id1);
+			fprintf(file, "  KM_RCP %" PRIu32 "\n", idxs[i].id1);
 			fprintf(file, "    HW id %u\n", data->rcp);
 			break;
 		}
@@ -615,25 +626,25 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 		case HW_DB_IDX_TYPE_KM_FT: {
 			const struct hw_db_inline_km_ft_data *data =
 					&db->km[idxs[i].id2].ft[idxs[i].id1].data;
-			fprintf(file, "  KM_FT %d\n", idxs[i].id1);
+			fprintf(file, "  KM_FT %" PRIu32 "\n", idxs[i].id1);
 			fprintf(file, "    ACTION_SET id %d\n", data->action_set.ids);
-			fprintf(file, "    KM_RCP id %d\n", data->km.ids);
-			fprintf(file, "    CAT id %d\n", data->cat.ids);
+			fprintf(file, "    KM_RCP id %" PRIu32 "\n", data->km.ids);
+			fprintf(file, "    CAT id %" PRIu32 "\n", data->cat.ids);
 			break;
 		}
 
 		case HW_DB_IDX_TYPE_FLM_SCRUB: {
 			const struct hw_db_inline_scrub_data *data = &db->scrub[idxs[i].ids].data;
-			fprintf(file, "  FLM_RCP %d\n", idxs[i].id1);
-			fprintf(file, "  SCRUB %d\n", idxs[i].ids);
-			fprintf(file, "    Timeout: %d, encoded timeout: %d\n",
+			fprintf(file, "  FLM_RCP %" PRIu32 "\n", idxs[i].id1);
+			fprintf(file, "  SCRUB %" PRIu32 "\n", idxs[i].ids);
+			fprintf(file, "    Timeout: %" PRIu32 ", encoded timeout: %" PRIu32 "\n",
 				hw_mod_flm_scrub_timeout_decode(data->timeout), data->timeout);
 			break;
 		}
 
 		case HW_DB_IDX_TYPE_HSH: {
 			const struct hw_db_inline_hsh_data *data = &db->hsh[idxs[i].ids].data;
-			fprintf(file, "  HSH %d\n", idxs[i].ids);
+			fprintf(file, "  HSH %" PRIu32 "\n", idxs[i].ids);
 
 			switch (data->func) {
 			case RTE_ETH_HASH_FUNCTION_DEFAULT:
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index c0407574f0..6bfa471321 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -1159,8 +1159,9 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 				fd->dst_num_avail++;
 
 				NT_LOG(DBG, FILTER,
-					"Dev:%p: RTE_FLOW_ACTION_TYPE_QUEUE port %u, queue index: %u, hw id %u",
-					dev, dev->port, queue->index, hw_id);
+					"Dev:%p: RTE_FLOW_ACTION_TYPE_QUEUE port %u, queue index:"
+					"%" PRIu16 ",hw id %i",
+					dev, (unsigned int)dev->port, queue->index, hw_id);
 
 				fd->full_offload = 0;
 				*num_queues += 1;
@@ -1202,8 +1203,9 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 				fd->hsh.key_len = rss->key_len;
 
 				NT_LOG(DBG, FILTER,
-					"Dev:%p: RSS func: %d, types: 0x%" PRIX64 ", key_len: %d",
-					dev, rss->func, rss->types, rss->key_len);
+					"Dev:%p: RSS func: %i, types: 0x%" PRIX64
+					", key_len: %" PRIu32 "",
+					dev, (int)rss->func, rss->types, rss->key_len);
 
 				fd->full_offload = 0;
 				*num_queues += rss->queue_num;
@@ -1222,7 +1224,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 					sizeof(struct rte_flow_action_mark));
 
 				fd->mark = mark->id;
-				NT_LOG(DBG, FILTER, "Mark: %i", mark->id);
+				NT_LOG(DBG, FILTER, "Mark: %u", mark->id);
 			}
 
 			break;
@@ -3138,7 +3140,7 @@ static int copy_fd_to_fh_flm(struct flow_handle *fh, const struct nic_flow_def *
 			break;
 
 		default:
-			NT_LOG(DBG, FILTER, "Unknown modify field: %d",
+			NT_LOG(DBG, FILTER, "Unknown modify field: %" PRIu32,
 				fd->modify_field[i].select);
 			break;
 		}
@@ -4516,7 +4518,7 @@ int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 				break;
 
 			default:
-				NT_LOG(DBG, FILTER, "Unknown modify field: %d",
+				NT_LOG(DBG, FILTER, "Unknown modify field: %" PRIu32,
 					fd->modify_field[i].select);
 				break;
 			}
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 43841b2f7b..fbaf0c2d6d 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -904,7 +904,9 @@ void nthw_field_init(nthw_field_t *p, nthw_register_t *p_reg, const nthw_fpga_fi
 
 		if (p->mn_debug_mode >= 0x100) {
 			NT_LOG_DBGX(DBG, NTHW,
-				"fldid=%08d: [%08d:%08d] %08d/%08d: (%08d,%08d) (0x%08X,%08d,0x%08X)",
+				"fldid=%08" PRIu32 ": [%08" PRIu16 ":%08" PRIu16 "] %08" PRIu16 "/%08"
+				PRIu16 ": (%08i ,%08" PRIu32 ") (0x%08" PRIx32 ",%08"
+				PRIu32 ",0x%08" PRIx32 ")",
 				p_init->id, p_init->low, (p_init->low + p_init->bw),
 				p_init->bw, ((p_init->bw + 31) / 32), p->mn_first_word,
 				p->mn_first_bit, p->mn_front_mask, p->mn_body_length,
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index 2257dfb7dc..d6fdea2ddb 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -265,7 +265,7 @@ static inline int _nthw_rac_wait_for_rab_done(const nthw_rac_t *p, uint32_t addr
 	}
 
 	if (used < word_cnt) {
-		NT_LOG(ERR, NTHW, "%s: Fail rab bus r/w addr=0x%08X used=%x wordcount=%d",
+		NT_LOG(ERR, NTHW, "%s: Fail rab bus r/w addr=0x%08X used=%x wordcount=%" PRIu32 "",
 			p_adapter_id_str, address, used, word_cnt);
 		return -1;
 	}
@@ -470,7 +470,8 @@ int nthw_rac_rab_write32_dma(nthw_rac_t *p, nthw_rab_bus_id_t bus_id, uint32_t a
 
 	if (word_cnt == 0 || word_cnt > 256) {
 		NT_LOG(ERR, NTHW,
-			"%s: Failed rab dma write length check - bus: %d addr: 0x%08X wordcount: %d - inBufFree: 0x%08X",
+			"%s: Failed rab dma write length check - bus: %d addr: 0x%08X wordcount: %"
+			PRIu32 " - inBufFree: 0x%08X",
 			p_adapter_id_str, bus_id, address, word_cnt, p->m_in_free);
 		RTE_ASSERT(0);      /* alert developer that something is wrong */
 		return -1;
@@ -509,7 +510,8 @@ int nthw_rac_rab_read32_dma(nthw_rac_t *p, nthw_rab_bus_id_t bus_id, uint32_t ad
 
 	if (word_cnt == 0 || word_cnt > 256) {
 		NT_LOG(ERR, NTHW,
-			"%s: Failed rab dma read length check - bus: %d addr: 0x%08X wordcount: %d - inBufFree: 0x%08X",
+			"%s: Failed rab dma read length check - bus: %d addr: 0x%08X wordcount: %"
+			PRIu32 " - inBufFree: 0x%08X",
 			p_adapter_id_str, bus_id, address, word_cnt, p->m_in_free);
 		RTE_ASSERT(0);      /* alert developer that something is wrong */
 		return -1;
@@ -560,19 +562,19 @@ int nthw_rac_rab_write32(nthw_rac_t *p, bool trc, nthw_rab_bus_id_t bus_id, uint
 	int res = 0;
 
 	if (address > (1 << RAB_ADDR_BW)) {
-		NT_LOG(ERR, NTHW, "%s: RAB: Illegal address: value too large %d - max %d",
+		NT_LOG(ERR, NTHW, "%s: RAB: Illegal address: value too large %" PRIu32 " - max %d",
 			p_adapter_id_str, address, (1 << RAB_ADDR_BW));
 		return -1;
 	}
 
 	if (bus_id > (1 << RAB_BUSID_BW)) {
-		NT_LOG(ERR, NTHW, "%s: RAB: Illegal bus id: value too large %d - max %d",
+		NT_LOG(ERR, NTHW, "%s: RAB: Illegal bus id: value too large %" PRIu32 " - max %d",
 			p_adapter_id_str, bus_id, (1 << RAB_BUSID_BW));
 		return -1;
 	}
 
 	if (word_cnt == 0) {
-		NT_LOG(ERR, NTHW, "%s: RAB: Illegal word count: value is zero (%d)",
+		NT_LOG(ERR, NTHW, "%s: RAB: Illegal word count: value is zero (%" PRIu32 ")",
 			p_adapter_id_str, word_cnt);
 		return -1;
 	}
@@ -747,28 +749,28 @@ int nthw_rac_rab_read32(nthw_rac_t *p, bool trc, nthw_rab_bus_id_t bus_id, uint3
 	rte_spinlock_lock(&p->m_mutex);
 
 	if (address > (1 << RAB_ADDR_BW)) {
-		NT_LOG(ERR, NTHW, "%s: RAB: Illegal address: value too large %d - max %d",
+		NT_LOG(ERR, NTHW, "%s: RAB: Illegal address: value too large %" PRIu32 " - max %d",
 			p_adapter_id_str, address, (1 << RAB_ADDR_BW));
 		res = -1;
 		goto exit_unlock_res;
 	}
 
 	if (bus_id > (1 << RAB_BUSID_BW)) {
-		NT_LOG(ERR, NTHW, "%s: RAB: Illegal bus id: value too large %d - max %d",
+		NT_LOG(ERR, NTHW, "%s: RAB: Illegal bus id: value too large %" PRIu32 " - max %d",
 			p_adapter_id_str, bus_id, (1 << RAB_BUSID_BW));
 		res = -1;
 		goto exit_unlock_res;
 	}
 
 	if (word_cnt == 0) {
-		NT_LOG(ERR, NTHW, "%s: RAB: Illegal word count: value is zero (%d)",
+		NT_LOG(ERR, NTHW, "%s: RAB: Illegal word count: value is zero (%" PRIu32 ")",
 			p_adapter_id_str, word_cnt);
 		res = -1;
 		goto exit_unlock_res;
 	}
 
 	if (word_cnt > (1 << RAB_CNT_BW)) {
-		NT_LOG(ERR, NTHW, "%s: RAB: Illegal word count: value too large %d - max %d",
+		NT_LOG(ERR, NTHW, "%s: RAB: Illegal word count: value too large %" PRIu32 " - max %d",
 			p_adapter_id_str, word_cnt, (1 << RAB_CNT_BW));
 		res = -1;
 		goto exit_unlock_res;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 6ba6769e47..87a0c3576b 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -844,7 +844,8 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 
 		if (!hwq->pkt_buffers) {
 			NT_LOG(ERR, NTNIC,
-				"Failed to allocated buffer array for hw-queue %p, total size %i, elements %i",
+				"Failed to allocated buffer array for hw-queue %p, total size %"
+				PRIu32 ", elements %i",
 				hwq->pkt_buffers, size, num_descr);
 			rte_free(virt);
 			return -1;
@@ -866,7 +867,8 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 		res = nt_vfio_dma_map(vf_num, virt_addr, &iova_addr, size);
 
 		NT_LOG(DBG, NTNIC,
-			"VFIO MMAP res %i, virt %p, iova %016" PRIX64 ", vf_num %i, num pkt bufs %i, tot size %i",
+			"VFIO MMAP res %i, virt %p, iova %016"
+			PRIX64 ", vf_num %i, num pkt bufs %i, tot size %" PRIu32 "",
 			res, virt_addr, iova_addr, vf_num, num_descr, size);
 
 		if (res != 0)
@@ -907,7 +909,8 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 
 	if (!hwq->pkt_buffers) {
 		NT_LOG(ERR, NTNIC,
-			"Failed to allocated buffer array for hw-queue %p, total size %i, elements %i",
+			"Failed to allocated buffer array for hw-queue %p, total size %"
+			PRIu32 ", elements %i",
 			hwq->pkt_buffers, size, num_descr);
 		rte_free(virt);
 		return -1;
@@ -973,7 +976,7 @@ static int num_queues_alloced;
 static int allocate_queue(int num)
 {
 	int next_free = num_queues_alloced;
-	NT_LOG_DBGX(DBG, NTNIC, "num_queues_alloced=%u, New queues=%u, Max queues=%u",
+	NT_LOG_DBGX(DBG, NTNIC, "num_queues_alloced=%i, New queues=%i, Max queues=%d",
 		num_queues_alloced, num, MAX_TOTAL_QUEUES);
 
 	if (num_queues_alloced + num > MAX_TOTAL_QUEUES)
@@ -1011,7 +1014,8 @@ static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 		return 0;
 	}
 
-	NT_LOG(DBG, NTNIC, "(%i) NTNIC RX OVS-SW queue setup: queue id %i, hw queue index %i",
+	NT_LOG(DBG, NTNIC, "(%" PRIu32 ") NTNIC RX OVS-SW queue setup: queue id %"
+		PRIu16 ", hw queue index %i",
 		internals->port, rx_queue_id, rx_q->queue.hw_id);
 
 	rx_q->mb_pool = mb_pool;
@@ -1041,7 +1045,8 @@ static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 			SPLIT_RING,
 			-1);
 
-	NT_LOG(DBG, NTNIC, "(%i) NTNIC RX OVS-SW queues successfully setup", internals->port);
+	NT_LOG(DBG, NTNIC, "(%" PRIu32 ") NTNIC RX OVS-SW queues successfully setup",
+		internals->port);
 
 	return 0;
 }
@@ -1075,7 +1080,7 @@ static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 		return 0;
 	}
 
-	NT_LOG(DBG, NTNIC, "(%i) NTNIC TX OVS-SW queue setup: queue id %i, hw queue index %i",
+	NT_LOG(DBG, NTNIC, "(%" PRIu32 ") NTNIC TX OVS-SW queue setup: queue id %" PRIu16 ", hw queue index %i",
 		tx_q->port, tx_queue_id, tx_q->queue.hw_id);
 
 	if (tx_queue_id > internals->nb_tx_queues) {
@@ -1135,7 +1140,8 @@ static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 
 	tx_q->enabled = 1;
 
-	NT_LOG(DBG, NTNIC, "(%i) NTNIC TX OVS-SW queues successfully setup", internals->port);
+	NT_LOG(DBG, NTNIC, "(%" PRIu32 ") NTNIC TX OVS-SW queues successfully setup",
+		internals->port);
 
 	if (internals->type == PORT_TYPE_PHYSICAL) {
 		struct adapter_info_s *p_adapter_info = &internals->p_drv->ntdrv.adapter_info;
@@ -1276,7 +1282,7 @@ eth_dev_start(struct rte_eth_dev *eth_dev)
 	const int n_intf_no = internals->n_intf_no;
 	struct adapter_info_s *p_adapter_info = &internals->p_drv->ntdrv.adapter_info;
 
-	NT_LOG_DBGX(DBG, NTNIC, "Port %u", internals->n_intf_no);
+	NT_LOG_DBGX(DBG, NTNIC, "Port %i", internals->n_intf_no);
 
 	/* Start queues */
 	uint q;
@@ -1334,7 +1340,7 @@ eth_dev_stop(struct rte_eth_dev *eth_dev)
 {
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
-	NT_LOG_DBGX(DBG, NTNIC, "Port %u", internals->n_intf_no);
+	NT_LOG_DBGX(DBG, NTNIC, "Port %i", internals->n_intf_no);
 
 	if (internals->type != PORT_TYPE_VIRTUAL) {
 		uint q;
@@ -2304,13 +2310,13 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		/* Setup queue_ids */
 		if (nb_rx_queues > 1) {
 			NT_LOG(DBG, NTNIC,
-				"(%i) NTNIC configured with Rx multi queues. %i queues",
+				"(%i) NTNIC configured with Rx multi queues. %" PRIu32 " queues",
 				internals->n_intf_no, nb_rx_queues);
 		}
 
 		if (nb_tx_queues > 1) {
 			NT_LOG(DBG, NTNIC,
-				"(%i) NTNIC configured with Tx multi queues. %i queues",
+				"(%i) NTNIC configured with Tx multi queues. %" PRIu32 " queues",
 				internals->n_intf_no, nb_tx_queues);
 		}
 
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 29bfb2a121..551979cf0f 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -355,8 +355,8 @@ int nthw_create_action_elements_inline(struct cnv_action_s *action,
 				case RTE_ETH_HASH_FUNCTION_MAX:
 				default:
 					NT_LOG(ERR, FILTER,
-						"RTE ACTION RSS - unsupported function: %u",
-						rss->func);
+						"RTE ACTION RSS - unsupported function: %i",
+						(int)rss->func);
 					return -1;
 				}
 
-- 
2.47.1

