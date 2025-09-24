Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA54CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3440A40E41;
	Wed, 24 Sep 2025 16:42:38 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 3C3B8406BA
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021074.outbound.protection.outlook.com
 [40.107.130.74]) by mx-outbound42-195.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXot2FkSkdFeZ6aWKF5ZTBlB4g7WRWb+K5usVmqBmEPz7wzsSu8AE9pvCEaD+BjJq7WRxTyE58Q9aeI5f+wWRYQP/7rhq2Fd40TsQOhRcNxZ9536H4fDZNWjoqsJWHk6qz/WtNsEaDzuLFid3SAQI7c6tC556jA0sCVomy3SgENLOZxQSOq+kpTKbjZwTdtemXE2WjmS8le6kRKKlWI720UqPRxBo2MrkKBz9TIo1IyuCtKTqs+q6ZTjk/uY7nQDfdwOAxvMatKAmLGPDvSwa53jq+Mp4FMW3MeE62A2Arqp2Dtd3VTf5JFq5auMw/QIpUkfICWpP9JxbSiRXWpteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78JIDf6SeUdN4JsQkMvuHwnKmzYTekZkxKBnzjsK6LM=;
 b=iEiLa+oAdaHQhPW1d22yKbiCfkxmnRXMu2BhS/atnXWeL14wDgT7uzr1rmL3gPF2mU2v1faMAS202+zMTZiFg+juo0G7XblgssIGVMG/M8q9eUvenMTdDlb3PIwWCr16VvbZxC0e+zTtO8upCl+oqtqsCl2C8ZBDoqZBNOgoAOiAEAsZ57pqQkXciXES6SXVJnMT2ZHcbVy+qk4an9AM/Gw+XkgPeYoIYnEvBff4tU80BTigtMTQ/JOzHfP8iVCv04Nb9iq/SIg7I/8ZSB83HQxKJiEyJ4UxjoSWP15JqKaMNj8XGNS6s7HT91xeLuLt1M5zuPN4bg3IEagDNOT7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78JIDf6SeUdN4JsQkMvuHwnKmzYTekZkxKBnzjsK6LM=;
 b=nffeIWPCG345i/C2I6dRRYbdaPGtRdlC/YrWCdUwk/cQ1QmR0d1REUda+Z/t3M1dqubWGdO+s826MfJRE9yNHFG9cRVCCfafU+J4LEl7BdoRHDrAZ/QSZVwfTYLKn+CBEQsn6gOZ9WhZ9/mZ6oDP4aC0Ioo+kTslhPSXsjPbCmE=
Received: from CWLP123CA0234.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::9)
 by AS8P190MB1302.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:42:16 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::5d) by CWLP123CA0234.outlook.office365.com
 (2603:10a6:400:19f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:15
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 21/24] net/ntnic: rename get ops functions
Date: Wed, 24 Sep 2025 16:41:44 +0200
Message-ID: <20250924144152.53203-22-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS8P190MB1302:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e84a8787-0071-4084-5310-08ddfb788e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sO2WL/lbs4PC+C20FigTrmXrSxeMlMAgGWLWmsA4TWvadJ9N6h4qNgmC0AE9?=
 =?us-ascii?Q?EMv6Npwi1HAytWaqxX+1+D2NIXDZBQqoZg7C7Ur/H6zv5+kthGc/L+y9xT3v?=
 =?us-ascii?Q?oiRdGvVJT4F5KQ54hccNZaXAHdo7aLEyN2f4yOGha5oGU9syQ7GpRS+R+ljj?=
 =?us-ascii?Q?SluATsy1NkCL+WVqsBsC3cRx76QD403TVfLRfHMWc1FHXPoCyvYK37VOEqlj?=
 =?us-ascii?Q?RimS6itS7fb+aWwxeHzZ+3RxLC1o6ze8ovo5V/AHeWc6qYTkY/krFM+MQPM4?=
 =?us-ascii?Q?+/PROHc7XvtyZn4e3fG3mmro/tVw5jxJTQeH2nRFj0zn5zWPEkemHXvKrUU0?=
 =?us-ascii?Q?JLOm1Fwsyv31ne+1oqeqo/zqeePP87yFa+cfnAf9CkDUPHvnxLqTQDn6dX11?=
 =?us-ascii?Q?PMr4q39fviJ/1SFNc9fC2y9hI+xIqwF0asr9CqyB36UxbjIZtVCxIzXdgv0D?=
 =?us-ascii?Q?8psXr/lK7/V4D0llMME7ckAyu8BR4HQ8HPbj/KMvk46+qN1cHXPGiOz6oN6m?=
 =?us-ascii?Q?TC9VacjqjGs3nhffhZK8Pb/eeRYTf4uusZAb73uvFNMpIPC+3Gap1lb14tI8?=
 =?us-ascii?Q?2wBBGiXGw3nTIzGMbIPGqgxJYfs8iHEWo2Gc0FiwILSfwano3WavitZP3/ke?=
 =?us-ascii?Q?4rbBTwnYBYEwx06VjHPZAtGJGjyDjzNJtvjaY7ZPiK9xv/qBVUWU0rLfyAP8?=
 =?us-ascii?Q?3zwutW63oAW/o1JLXDlfSAWgqGpK9b4YYPWgTcSOY9k0VzrUUk32NFqyCO2O?=
 =?us-ascii?Q?I48iCWbxcv/1nr/uR9Q0bB227DBOETPhdT0fzVtmQNOalS/EHmMuTJvpILqD?=
 =?us-ascii?Q?0zEMvIUdx1kZSr7jNlfXfqhfAo0BkQYTyVEHf6+s/+AYEemCReZxR6sbA43s?=
 =?us-ascii?Q?RsFs9qcx6UKLcgqFtm9c7jT5KUH7mB+s9LUKYBh5wcnhX1ydVo2WmFYatI71?=
 =?us-ascii?Q?E9VDg81W4wLLAAahJho4m19CwSZjLloYmsuLIKM4Xc3MH2kgNlQ20N4XB3Qc?=
 =?us-ascii?Q?3w8GbCisMw630kJ55Bd/LssYML4F0AhYtOoC1vRYRe7MGubCjNtBZmq+pvcK?=
 =?us-ascii?Q?zwj4zMhdDg9+d76kjW0L1I9Ee2Zd02qvywMWg9CIuTCFDe0qzWehO8Pgd79u?=
 =?us-ascii?Q?4Tep0UJQUdqJGwkZlgVdrxp6FW2rX/tdXYVhOQD/5a5L86SJzCZR3Rj8uXT1?=
 =?us-ascii?Q?oEYeLWlMqLqYPTzMsgoxl2GW8i0yRjRTozSd+x697iKEh7WT0poWmqekYui1?=
 =?us-ascii?Q?kEIWTPiIsVOEvWVDyr9y313qefGaq5CjPtTCxeC1EzlNyaCjIww7y9JBPFwK?=
 =?us-ascii?Q?msCSJbQuFZs5tmKE3b/HZQ3oFqd+xA7Omzn9oEelUxQK4BGO7c7gpXIgGrZj?=
 =?us-ascii?Q?Pxyjtw4rgr/3hXBLTe4U0DFaBdqqhl1PTl0R7cEIKSV4lD+8NCx5QosOXBas?=
 =?us-ascii?Q?yuhhNLeIe2ZrBQ6RDwzY7PKA45AbBBD0Im94C2fse3Q5nuwgaOSHCq3Rr9uI?=
 =?us-ascii?Q?XnRoUpnIqmXDZsUZf2uLB87fsbH+LXiyoEwx?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U4cXVqe6D2IdGEqib7sbdHi8zxki+IHQ7ACi+UiaTVMo/gA5KXmzS+ZHgZcVJQ6/11qwhPPQDMnCPKGZgW3B2pAGAGfoG0N1fjYPZf95UINzRYKQVvhkV8dJVqABPZkVVw57JJHsW/GHkrpSCtctlahIJONJ9w+zjqxhnEQRnggQNuSf2gkMS2ZBquUbNLnJEXchgWWUQ0nh0YgLZzsWTTOyYgSpaZb9l7uzlrQ70G+5vzuiyvD5eqg4xlO4oSFmnIwrDFe3kDeLwz/GdUc1RECUKeFsAEzS7R0VsLdoFkqGeLqzKn+1qpUNZcJuo30al9yq2VIrFHOOMrSJnkJI2AQA11uFF0tyVr2U6F8hv7yPX/REgHQA7xTKd2v7ddhSgzdkR1uIF6+z9aOSOgoc3sn+LOy3IE/4QlG/vllWPCdVT397JwcUUlLsXaAwGlmToHRCcoyUFrgFkKRT6Z+Mcd7URAquCF/Jl5L0vPPE+quP37PebU1oZLas0/TPnC8AnHFsZ9ycRPwTA0TWAVGkSxXR9af4wFglCS6LzxkLt6rFpE3iX387FVlzZf6Yac/TN/bK1MGIBz23oY6SfAXjMasyP0a/hQYrIFTE5367/As89SvcQW6nWb3sQdnAeKCGAHebbWLQSeyAyQvgDfIQOA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:15.8393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84a8787-0071-4084-5310-08ddfb788e5a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1302
X-BESS-ID: 1758724937-310947-7717-8059-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.130.74
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqZGhuamQGYGUDTV0iDRIDnR2N
 IwJSXRzNTU2DDJOCk11czCMtnC2DTVQqk2FgBDoaSMQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan10-222.eu-central-1a.ess.aws.cudaops.com]
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

Add prefix nthw_ to get ops functions to follow naming convention.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     | 10 ++--
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |  4 +-
 .../net/ntnic/nthw/core/include/nthw_fpga.h   |  4 +-
 .../nthw/core/nt200a0x/nthw_fpga_nt200a0x.c   |  4 +-
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c   |  4 +-
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  4 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |  8 +--
 drivers/net/ntnic/nthw/flow_api/flow_api.c    | 42 +++++++--------
 drivers/net/ntnic/nthw/flow_api/flow_filter.c |  4 +-
 .../net/ntnic/nthw/ntnic_meter/ntnic_meter.c  | 18 +++----
 drivers/net/ntnic/ntnic_ethdev.c              | 54 +++++++++----------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 32 +++++------
 drivers/net/ntnic/ntnic_mod_reg.c             | 38 ++++++-------
 drivers/net/ntnic/ntnic_mod_reg.h             | 38 ++++++-------
 14 files changed, 132 insertions(+), 132 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 5295387fa8..6d8547483f 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -52,7 +52,7 @@ static int nt4ga_adapter_show_info(struct adapter_info_s *p_adapter_info, FILE *
 
 static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL)
 		NT_LOG(ERR, NTNIC, "%s: flow_filter module uninitialized", __func__);
@@ -162,7 +162,7 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 		switch (fpga_info->n_fpga_prod_id) {
 		/* NT200A01: 2x100G (Xilinx) */
 		case 9563:	/* NT200A02 (Cap) */
-			link_ops = get_100g_link_ops();
+			link_ops = nthw_get_100g_link_ops();
 
 			if (link_ops == NULL) {
 				NT_LOG(ERR, NTNIC, "NT200A02 100G link module uninitialized");
@@ -173,7 +173,7 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 			res = link_ops->link_init(p_adapter_info, p_fpga);
 			break;
 		case 9574: /* NT400D13 (Intel Agilex FPGA) */
-			link_ops = get_agx_100g_link_ops();
+			link_ops = nthw_get_agx_100g_link_ops();
 			if (link_ops == NULL) {
 				NT_LOG(ERR, NTNIC, "NT400D11 100G link module uninitialized");
 				res = -1;
@@ -197,7 +197,7 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 		}
 	}
 
-	const struct nt4ga_stat_ops *nt4ga_stat_ops = get_nt4ga_stat_ops();
+	const struct nt4ga_stat_ops *nt4ga_stat_ops = nthw_get_nt4ga_stat_ops();
 
 	if (nt4ga_stat_ops != NULL) {
 		/* Nt4ga Stat init/setup */
@@ -223,7 +223,7 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 
 static int nt4ga_adapter_deinit(struct adapter_info_s *p_adapter_info)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL)
 		NT_LOG(ERR, NTNIC, "%s: flow_filter module uninitialized", __func__);
diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index aca88c6635..0f7e1f2b00 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -191,7 +191,7 @@ static int nt4ga_stat_setup(struct adapter_info_s *p_adapter_info)
 		return -1;
 	}
 
-	if (get_flow_filter_ops() != NULL) {
+	if (nthw_get_flow_filter_ops() != NULL) {
 		struct flow_nic_dev *ndev = p_adapter_info->nt4ga_filter.mp_flow_device;
 		p_nt4ga_stat->flm_stat_ver = ndev->be.flm.ver;
 		p_nt4ga_stat->mp_stat_structs_flm = calloc(1, sizeof(struct flm_counters_v1));
@@ -244,7 +244,7 @@ static int nt4ga_stat_collect_cap_v1_stats(struct adapter_info_s *p_adapter_info
 	uint32_t *p_stat_dma_virtual)
 {
 	(void)p_adapter_info;
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL || p_nt4ga_stat == NULL)
 		return -1;
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
index b86865b24f..9838ad3c07 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
@@ -33,7 +33,7 @@ struct nt200a0x_ops {
 };
 
 void nthw_reg_nt200a0x_ops(struct nt200a0x_ops *ops);
-struct nt200a0x_ops *get_nt200a0x_ops(void);
+struct nt200a0x_ops *nthw_get_nt200a0x_ops(void);
 void nt200a0x_ops_init(void);
 
 struct nt400dxx_ops {
@@ -41,7 +41,7 @@ struct nt400dxx_ops {
 };
 
 void nthw_reg_nt400dxx_ops(struct nt400dxx_ops *ops);
-struct nt400dxx_ops *get_nt400dxx_ops(void);
+struct nt400dxx_ops *nthw_get_nt400dxx_ops(void);
 void nt400dxx_ops_init(void);
 
 #endif	/* __NTHW_FPGA_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
index 739b1aab85..371177c14f 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
@@ -15,7 +15,7 @@ static int nthw_fpga_nt200a0x_init(struct fpga_info_s *p_fpga_info)
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
 	struct nthw_fpga_rst_nt200a0x rst;
 	int res = -1;
-	const struct rst_nt200a0x_ops *rst_nt200a0x_ops = get_rst_nt200a0x_ops();
+	const struct rst_nt200a0x_ops *rst_nt200a0x_ops = nthw_get_rst_nt200a0x_ops();
 
 	if (rst_nt200a0x_ops == NULL) {
 		NT_LOG(ERR, NTHW, "RST NT200A0X NOT INCLUDED");
@@ -32,7 +32,7 @@ static int nthw_fpga_nt200a0x_init(struct fpga_info_s *p_fpga_info)
 	}
 
 	bool included = true;
-	struct rst9563_ops *rst9563_ops = get_rst9563_ops();
+	struct rst9563_ops *rst9563_ops = nthw_get_rst9563_ops();
 
 	/* reset specific */
 	switch (p_fpga_info->n_fpga_prod_id) {
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index a345f163bb..f3a28e801e 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -160,7 +160,7 @@ static int nthw_fpga_rst9563_clock_synth_init(nthw_fpga_t *p_fpga,
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	const int n_fpga_product_id = p_fpga->mn_product_id;
 	int res;
-	const struct clk9563_ops *clk9563_ops = get_clk9563_ops();
+	const struct clk9563_ops *clk9563_ops = nthw_get_clk9563_ops();
 
 	if (clk9563_ops == NULL) {
 		NT_LOG(INF, NTNIC, "CLK9563 module not included");
@@ -220,7 +220,7 @@ static int nthw_fpga_rst9563_init(struct fpga_info_s *p_fpga_info,
 		return res;
 	}
 
-	const struct rst_nt200a0x_ops *rst_ops = get_rst_nt200a0x_ops();
+	const struct rst_nt200a0x_ops *rst_ops = nthw_get_rst_nt200a0x_ops();
 	res = rst_ops != NULL ? rst_ops->nthw_fpga_rst_nt200a0x_reset(p_fpga, p_rst) : -1;
 
 	if (res) {
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 234da0da33..1f87e36d08 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -124,7 +124,7 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 	switch (p_fpga_info->n_fpga_prod_id) {
 	case 9574:
-		rst9574_ops = get_rst9574_ops();
+		rst9574_ops = nthw_get_rst9574_ops();
 
 		if (rst9574_ops == NULL) {
 			NT_LOG(ERR, NTHW, "%s: RST 9574 NOT INCLUDED", p_adapter_id_str);
@@ -148,7 +148,7 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 		return -1;
 	}
 
-	struct rst_nt400dxx_ops *rst_nt400dxx_ops = get_rst_nt400dxx_ops();
+	struct rst_nt400dxx_ops *rst_nt400dxx_ops = nthw_get_rst_nt400dxx_ops();
 
 	if (rst_nt400dxx_ops == NULL) {
 		NT_LOG(ERR, NTHW, "RST NT400DXX NOT INCLUDED");
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index f18069e492..0e1f686b4f 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -431,8 +431,8 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 	nthw_rac_rab_flush(p_nthw_rac);
 	p_fpga_info->mp_nthw_rac = p_nthw_rac;
 
-	struct nt200a0x_ops *nt200a0x_ops = get_nt200a0x_ops();
-	struct nt400dxx_ops *nt400dxx_ops = get_nt400dxx_ops();
+	struct nt200a0x_ops *nt200a0x_ops = nthw_get_nt200a0x_ops();
+	struct nt400dxx_ops *nt400dxx_ops = nthw_get_nt400dxx_ops();
 
 	switch (p_fpga_info->n_nthw_adapter_id) {
 	case NT_HW_ADAPTER_ID_NT200A02:
@@ -562,7 +562,7 @@ void nthw_reg_nt200a0x_ops(struct nt200a0x_ops *ops)
 	nt200a0x_ops = ops;
 }
 
-struct nt200a0x_ops *get_nt200a0x_ops(void)
+struct nt200a0x_ops *nthw_get_nt200a0x_ops(void)
 {
 	if (nt200a0x_ops == NULL)
 		nt200a0x_ops_init();
@@ -576,7 +576,7 @@ void nthw_reg_nt400dxx_ops(struct nt400dxx_ops *ops)
 	nt400dxx_ops = ops;
 }
 
-struct nt400dxx_ops *get_nt400dxx_ops(void)
+struct nt400dxx_ops *nthw_get_nt400dxx_ops(void)
 {
 	if (nt400dxx_ops == NULL)
 		nt400dxx_ops_init();
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index b737589e14..3e45db67d7 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -292,7 +292,7 @@ static struct flow_handle *flow_create(struct flow_eth_dev *dev __rte_unused,
 	const struct rte_flow_action action[] __rte_unused,
 	struct rte_flow_error *error __rte_unused)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
@@ -306,7 +306,7 @@ static struct flow_handle *flow_create(struct flow_eth_dev *dev __rte_unused,
 static int flow_destroy(struct flow_eth_dev *dev __rte_unused,
 	struct flow_handle *flow __rte_unused,	struct rte_flow_error *error __rte_unused)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
@@ -318,7 +318,7 @@ static int flow_destroy(struct flow_eth_dev *dev __rte_unused,
 
 static int flow_flush(struct flow_eth_dev *dev, uint16_t caller_id, struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -333,7 +333,7 @@ static int flow_actions_update(struct flow_eth_dev *dev,
 	const struct rte_flow_action action[],
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -378,7 +378,7 @@ static int nic_remove_eth_port_dev(struct flow_nic_dev *ndev, struct flow_eth_de
 
 static int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
@@ -453,7 +453,7 @@ static int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 
 static void flow_ndev_reset(struct flow_nic_dev *ndev)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
@@ -586,7 +586,7 @@ static struct flow_eth_dev *flow_get_eth_dev(uint8_t adapter_no, uint8_t port_no
 	int *rss_target_id, enum flow_eth_dev_profile flow_profile,
 	uint32_t exception_path)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL)
 		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
@@ -1015,7 +1015,7 @@ static int flow_dev_dump(struct flow_eth_dev *dev,
 	FILE *file,
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
@@ -1032,7 +1032,7 @@ static int flow_get_aged_flows(struct flow_eth_dev *dev,
 	uint32_t nb_contexts,
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline_ops uninitialized");
@@ -1053,7 +1053,7 @@ static int flow_info_get(struct flow_eth_dev *dev, uint8_t caller_id,
 	struct rte_flow_port_info *port_info, struct rte_flow_queue_info *queue_info,
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1068,7 +1068,7 @@ static int flow_configure(struct flow_eth_dev *dev, uint8_t caller_id,
 	const struct rte_flow_port_attr *port_attr, uint16_t nb_queue,
 	const struct rte_flow_queue_attr *queue_attr[], struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1088,7 +1088,7 @@ flow_pattern_template_create(struct flow_eth_dev *dev,
 	const struct rte_flow_pattern_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_item pattern[], struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1103,7 +1103,7 @@ static int flow_pattern_template_destroy(struct flow_eth_dev *dev,
 	struct flow_pattern_template *pattern_template,
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1121,7 +1121,7 @@ flow_actions_template_create(struct flow_eth_dev *dev,
 	const struct rte_flow_action actions[], const struct rte_flow_action masks[],
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1136,7 +1136,7 @@ static int flow_actions_template_destroy(struct flow_eth_dev *dev,
 	struct flow_actions_template *actions_template,
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1154,7 +1154,7 @@ static struct flow_template_table *flow_template_table_create(struct flow_eth_de
 	uint8_t nb_pattern_templates, struct flow_actions_template *actions_templates[],
 	uint8_t nb_actions_templates, struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1170,7 +1170,7 @@ static int flow_template_table_destroy(struct flow_eth_dev *dev,
 	struct flow_template_table *template_table,
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1188,7 +1188,7 @@ flow_async_create(struct flow_eth_dev *dev, uint32_t queue_id,
 	const struct rte_flow_action actions[], uint8_t actions_template_index, void *user_data,
 	struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1204,7 +1204,7 @@ static int flow_async_destroy(struct flow_eth_dev *dev, uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr, struct flow_handle *flow,
 	void *user_data, struct rte_flow_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "profile_inline module uninitialized");
@@ -1216,7 +1216,7 @@ static int flow_async_destroy(struct flow_eth_dev *dev, uint32_t queue_id,
 }
 int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL)
 		return -1;
@@ -1229,7 +1229,7 @@ int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t
 
 int nthw_flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t port_count)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL)
 		return -1;
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_filter.c b/drivers/net/ntnic/nthw/flow_api/flow_filter.c
index a4a95746e8..9de3ed3b7a 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_filter.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_filter.c
@@ -12,7 +12,7 @@ int nthw_flow_filter_init(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_devi
 	void *be_dev = NULL;
 	struct flow_nic_dev *flow_nic;
 
-	const struct flow_backend_ops *flow_backend_ops = get_flow_backend_ops();
+	const struct flow_backend_ops *flow_backend_ops = nthw_get_flow_backend_ops();
 
 	if (flow_backend_ops == NULL) {
 		NT_LOG(ERR, FILTER, "%s: flow_backend module uninitialized", __func__);
@@ -41,7 +41,7 @@ int nthw_flow_filter_done(struct flow_nic_dev *dev)
 	int res = nthw_flow_api_done(dev);
 
 	if (be_dev) {
-		const struct flow_backend_ops *flow_backend_ops = get_flow_backend_ops();
+		const struct flow_backend_ops *flow_backend_ops = nthw_get_flow_backend_ops();
 
 		if (flow_backend_ops == NULL) {
 			NT_LOG(WRN, FILTER, "%s: flow_backend module uninitialized", __func__);
diff --git a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
index a2c37774fe..95a875fc1a 100644
--- a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
+++ b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
@@ -35,7 +35,7 @@ static int eth_mtr_capabilities_get_inline(struct rte_eth_dev *eth_dev,
 	struct rte_mtr_capabilities *cap,
 	struct rte_mtr_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
@@ -106,7 +106,7 @@ static int eth_mtr_meter_profile_add_inline(struct rte_eth_dev *eth_dev,
 	struct rte_mtr_meter_profile *profile,
 	struct rte_mtr_error *error __rte_unused)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
@@ -157,7 +157,7 @@ static int eth_mtr_meter_profile_delete_inline(struct rte_eth_dev *eth_dev,
 	uint32_t meter_profile_id,
 	struct rte_mtr_error *error __rte_unused)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
@@ -180,7 +180,7 @@ static int eth_mtr_meter_policy_add_inline(struct rte_eth_dev *eth_dev,
 	struct rte_mtr_meter_policy_params *policy,
 	struct rte_mtr_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
@@ -226,7 +226,7 @@ static int eth_mtr_meter_policy_delete_inline(struct rte_eth_dev *eth_dev __rte_
 	uint32_t policy_id,
 	struct rte_mtr_error *error __rte_unused)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
@@ -246,7 +246,7 @@ static int eth_mtr_create_inline(struct rte_eth_dev *eth_dev,
 	int shared,
 	struct rte_mtr_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
@@ -312,7 +312,7 @@ static int eth_mtr_destroy_inline(struct rte_eth_dev *eth_dev,
 	uint32_t mtr_id,
 	struct rte_mtr_error *error __rte_unused)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
@@ -342,7 +342,7 @@ static int eth_mtr_stats_adjust_inline(struct rte_eth_dev *eth_dev,
 	uint64_t adjust_value,
 	struct rte_mtr_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
@@ -405,7 +405,7 @@ static int eth_mtr_stats_read_inline(struct rte_eth_dev *eth_dev,
 	int clear,
 	struct rte_mtr_error *error)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG(ERR, NTHW, "profile_inline module uninitialized");
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 906e55de7c..42aa2d4095 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -162,7 +162,7 @@ get_pdrv_from_pci(struct rte_pci_addr addr)
 
 static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_stats *stats)
 {
-	const struct ntnic_filter_ops *ntnic_filter_ops = get_ntnic_filter_ops();
+	const struct ntnic_filter_ops *ntnic_filter_ops = nthw_get_filter_ops();
 
 	if (ntnic_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "ntnic_filter_ops uninitialized");
@@ -261,7 +261,7 @@ static int dpdk_stats_reset(struct pmd_internals *internals, struct ntdrv_4ga_s
 static int
 eth_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete __rte_unused)
 {
-	const struct port_ops *port_ops = get_port_ops();
+	const struct port_ops *port_ops = nthw_get_port_ops();
 
 	if (port_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "Link management module uninitialized");
@@ -317,7 +317,7 @@ static int eth_stats_reset(struct rte_eth_dev *eth_dev)
 static int
 eth_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_info)
 {
-	const struct port_ops *port_ops = get_port_ops();
+	const struct port_ops *port_ops = nthw_get_port_ops();
 
 	if (port_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "Link management module uninitialized");
@@ -1081,7 +1081,7 @@ static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 	unsigned int socket_id __rte_unused,
 	const struct rte_eth_txconf *tx_conf)
 {
-	const struct port_ops *port_ops = get_port_ops();
+	const struct port_ops *port_ops = nthw_get_port_ops();
 
 	if (port_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "Link management module uninitialized");
@@ -1181,7 +1181,7 @@ static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 
 static int dev_set_mtu_inline(struct rte_eth_dev *eth_dev, uint16_t mtu)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "profile_inline module uninitialized");
@@ -1367,14 +1367,14 @@ eth_dev_configure(struct rte_eth_dev *eth_dev)
 static int
 eth_dev_start(struct rte_eth_dev *eth_dev)
 {
-	const struct port_ops *port_ops = get_port_ops();
+	const struct port_ops *port_ops = nthw_get_port_ops();
 
 	if (port_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "Link management module uninitialized");
 		return -1;
 	}
 
-	eth_dev->flow_fp_ops = get_dev_fp_flow_ops();
+	eth_dev->flow_fp_ops = nthw_get_dev_fp_flow_ops();
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
 	const int n_intf_no = internals->n_intf_no;
@@ -1459,7 +1459,7 @@ eth_dev_stop(struct rte_eth_dev *eth_dev)
 static int
 eth_dev_set_link_up(struct rte_eth_dev *eth_dev)
 {
-	const struct port_ops *port_ops = get_port_ops();
+	const struct port_ops *port_ops = nthw_get_port_ops();
 
 	if (port_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "Link management module uninitialized");
@@ -1484,7 +1484,7 @@ eth_dev_set_link_up(struct rte_eth_dev *eth_dev)
 static int
 eth_dev_set_link_down(struct rte_eth_dev *eth_dev)
 {
-	const struct port_ops *port_ops = get_port_ops();
+	const struct port_ops *port_ops = nthw_get_port_ops();
 
 	if (port_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "Link management module uninitialized");
@@ -1509,14 +1509,14 @@ eth_dev_set_link_down(struct rte_eth_dev *eth_dev)
 static void
 drv_deinit(struct drv_s *p_drv)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "profile_inline module uninitialized");
 		return;
 	}
 
-	const struct adapter_ops *adapter_ops = get_adapter_ops();
+	const struct adapter_ops *adapter_ops = nthw_get_adapter_ops();
 
 	if (adapter_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "Adapter module uninitialized");
@@ -1623,7 +1623,7 @@ eth_fw_version_get(struct rte_eth_dev *eth_dev, char *fw_version, size_t fw_size
 
 static int dev_flow_ops_get(struct rte_eth_dev *dev __rte_unused, const struct rte_flow_ops **ops)
 {
-	*ops = get_dev_flow_ops();
+	*ops = nthw_get_dev_flow_ops();
 	return 0;
 }
 
@@ -1636,7 +1636,7 @@ static int eth_xstats_get(struct rte_eth_dev *eth_dev, struct rte_eth_xstat *sta
 	int n_intf_no = internals->n_intf_no;
 	int nb_xstats;
 
-	const struct ntnic_xstats_ops *ntnic_xstats_ops = get_ntnic_xstats_ops();
+	const struct ntnic_xstats_ops *ntnic_xstats_ops = nthw_get_xstats_ops();
 
 	if (ntnic_xstats_ops == NULL) {
 		NT_LOG(INF, NTNIC, "ntnic_xstats module not included");
@@ -1661,7 +1661,7 @@ static int eth_xstats_get_by_id(struct rte_eth_dev *eth_dev,
 	int n_intf_no = internals->n_intf_no;
 	int nb_xstats;
 
-	const struct ntnic_xstats_ops *ntnic_xstats_ops = get_ntnic_xstats_ops();
+	const struct ntnic_xstats_ops *ntnic_xstats_ops = nthw_get_xstats_ops();
 
 	if (ntnic_xstats_ops == NULL) {
 		NT_LOG(INF, NTNIC, "ntnic_xstats module not included");
@@ -1683,7 +1683,7 @@ static int eth_xstats_reset(struct rte_eth_dev *eth_dev)
 	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
 	int n_intf_no = internals->n_intf_no;
 
-	struct ntnic_xstats_ops *ntnic_xstats_ops = get_ntnic_xstats_ops();
+	struct ntnic_xstats_ops *ntnic_xstats_ops = nthw_get_xstats_ops();
 
 	if (ntnic_xstats_ops == NULL) {
 		NT_LOG(INF, NTNIC, "ntnic_xstats module not included");
@@ -1704,7 +1704,7 @@ static int eth_xstats_get_names(struct rte_eth_dev *eth_dev,
 	ntdrv_4ga_t *p_nt_drv = &p_drv->ntdrv;
 	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
 
-	const struct ntnic_xstats_ops *ntnic_xstats_ops = get_ntnic_xstats_ops();
+	const struct ntnic_xstats_ops *ntnic_xstats_ops = nthw_get_xstats_ops();
 
 	if (ntnic_xstats_ops == NULL) {
 		NT_LOG(INF, NTNIC, "ntnic_xstats module not included");
@@ -1723,7 +1723,7 @@ static int eth_xstats_get_names_by_id(struct rte_eth_dev *eth_dev,
 	struct drv_s *p_drv = internals->p_drv;
 	ntdrv_4ga_t *p_nt_drv = &p_drv->ntdrv;
 	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
-	const struct ntnic_xstats_ops *ntnic_xstats_ops = get_ntnic_xstats_ops();
+	const struct ntnic_xstats_ops *ntnic_xstats_ops = nthw_get_xstats_ops();
 
 	if (ntnic_xstats_ops == NULL) {
 		NT_LOG(INF, NTNIC, "ntnic_xstats module not included");
@@ -1743,7 +1743,7 @@ promiscuous_enable(struct rte_eth_dev __rte_unused(*dev))
 
 static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_rss_conf *rss_conf)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "flow_filter module uninitialized");
@@ -2035,7 +2035,7 @@ static int adapter_flm_update_service(void *context)
 
 		dev = p_flow_nic_dev->eth_base;
 
-		profile_inline_ops = get_profile_inline_ops();
+		profile_inline_ops = nthw_get_profile_inline_ops();
 		RTE_ASSERT(profile_inline_ops != NULL);
 
 		NT_LOG(INF, NTNIC, "flm update service started on lcore %i",  rte_lcore_id());
@@ -2067,7 +2067,7 @@ static int adapter_stat_service(void *context)
 		struct drv_s *p_drv = context;
 		RTE_ASSERT(p_drv != NULL);
 
-		nt4ga_stat_ops = get_nt4ga_stat_ops();
+		nt4ga_stat_ops = nthw_get_nt4ga_stat_ops();
 		RTE_ASSERT(nt4ga_stat_ops != NULL);
 
 		p_nt_drv = &p_drv->ntdrv;
@@ -2136,14 +2136,14 @@ static int adapter_stat_service(void *context)
 static int
 nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "flow_filter module uninitialized");
 		/* Return statement is not necessary here to allow traffic processing by SW  */
 	}
 
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
 
 	if (profile_inline_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "profile_inline module uninitialized");
@@ -2151,14 +2151,14 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 	}
 
 	nthw_vfio_init();
-	const struct port_ops *port_ops = get_port_ops();
+	const struct port_ops *port_ops = nthw_get_port_ops();
 
 	if (port_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "Link management module uninitialized");
 		return -1;
 	}
 
-	const struct adapter_ops *adapter_ops = get_adapter_ops();
+	const struct adapter_ops *adapter_ops = nthw_get_adapter_ops();
 
 	if (adapter_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "Adapter module uninitialized");
@@ -2328,7 +2328,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		return -1;
 	}
 
-	const struct meter_ops_s *meter_ops = get_meter_ops();
+	const struct meter_ops_s *meter_ops = nthw_get_meter_ops();
 
 	if (meter_ops != NULL)
 		nthw_eth_dev_ops.mtr_ops_get = meter_ops->eth_mtr_ops_get;
@@ -2337,7 +2337,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		NT_LOG(DBG, NTNIC, "Meter module is not initialized");
 
 	/* Initialize the queue system */
-	sg_ops = get_sg_ops();
+	sg_ops = nthw_get_sg_ops();
 
 	if (sg_ops != NULL) {
 		err = sg_ops->nthw_virt_queue_init(fpga_info);
@@ -2556,7 +2556,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		/* increase initialized ethernet devices - PF */
 		p_drv->n_eth_dev_init_count++;
 
-		if (get_flow_filter_ops() != NULL) {
+		if (nthw_get_flow_filter_ops() != NULL) {
 			if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE &&
 				internals->flw_dev->ndev->be.tpe.ver >= 2) {
 				RTE_ASSERT(nthw_eth_dev_ops.mtu_set == dev_set_mtu_inline ||
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 2d0d0ea54f..5a0ef125be 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -540,7 +540,7 @@ static int convert_flow(struct rte_eth_dev *eth_dev,
 static int
 eth_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *flow, struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -584,7 +584,7 @@ static struct rte_flow *eth_flow_create(struct rte_eth_dev *eth_dev,
 	const struct rte_flow_action actions[],
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -667,7 +667,7 @@ static struct rte_flow *eth_flow_create(struct rte_eth_dev *eth_dev,
 
 static int eth_flow_flush(struct rte_eth_dev *eth_dev, struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -708,7 +708,7 @@ static int eth_flow_actions_update(struct rte_eth_dev *eth_dev,
 	const struct rte_flow_action actions[],
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG(ERR, FILTER, "flow_filter module uninitialized");
@@ -770,7 +770,7 @@ static int eth_flow_dev_dump(struct rte_eth_dev *eth_dev,
 	FILE *file,
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG(ERR, NTNIC, "%s: flow_filter module uninitialized", __func__);
@@ -797,7 +797,7 @@ static int eth_flow_get_aged_flows(struct rte_eth_dev *eth_dev,
 	uint32_t nb_contexts,
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "flow_filter module uninitialized");
@@ -824,7 +824,7 @@ static int eth_flow_get_aged_flows(struct rte_eth_dev *eth_dev,
 static int eth_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
 	struct rte_flow_queue_info *queue_info, struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -849,7 +849,7 @@ static int eth_flow_configure(struct rte_eth_dev *dev, const struct rte_flow_por
 	uint16_t nb_queue, const struct rte_flow_queue_attr *queue_attr[],
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -875,7 +875,7 @@ static struct rte_flow_pattern_template *eth_flow_pattern_template_create(struct
 	const struct rte_flow_pattern_template_attr *template_attr,
 	const struct rte_flow_item pattern[], struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -914,7 +914,7 @@ static int eth_flow_pattern_template_destroy(struct rte_eth_dev *dev,
 	struct rte_flow_pattern_template *pattern_template,
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -939,7 +939,7 @@ static struct rte_flow_actions_template *eth_flow_actions_template_create(struct
 	const struct rte_flow_action actions[], const struct rte_flow_action masks[],
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -1000,7 +1000,7 @@ static int eth_flow_actions_template_destroy(struct rte_eth_dev *dev,
 	struct rte_flow_actions_template *actions_template,
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, NTNIC, "flow_filter module uninitialized");
@@ -1026,7 +1026,7 @@ static struct rte_flow_template_table *eth_flow_template_table_create(struct rte
 	struct rte_flow_actions_template *actions_templates[], uint8_t nb_actions_templates,
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -1065,7 +1065,7 @@ static int eth_flow_template_table_destroy(struct rte_eth_dev *dev,
 	struct rte_flow_template_table *template_table,
 	struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -1091,7 +1091,7 @@ static struct rte_flow *eth_flow_async_create(struct rte_eth_dev *dev, uint32_t
 	uint8_t pattern_template_index, const struct rte_flow_action actions[],
 	uint8_t actions_template_index, void *user_data, struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
@@ -1151,7 +1151,7 @@ static int eth_flow_async_destroy(struct rte_eth_dev *dev, uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr, struct rte_flow *flow,
 	void *user_data, struct rte_flow_error *error)
 {
-	const struct flow_filter_ops *flow_filter_ops = get_flow_filter_ops();
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
 
 	if (flow_filter_ops == NULL) {
 		NT_LOG_DBGX(ERR, FILTER, "flow_filter module uninitialized");
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index be872aa090..67ba694e25 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -12,7 +12,7 @@ void nthw_reg_sg_ops(struct sg_ops_s *ops)
 	sg_ops = ops;
 }
 
-const struct sg_ops_s *get_sg_ops(void)
+const struct sg_ops_s *nthw_get_sg_ops(void)
 {
 	if (sg_ops == NULL)
 		nthw_sg_init();
@@ -29,7 +29,7 @@ void nthw_reg_meter_ops(struct meter_ops_s *ops)
 	meter_ops = ops;
 }
 
-const struct meter_ops_s *get_meter_ops(void)
+const struct meter_ops_s *nthw_get_meter_ops(void)
 {
 	if (meter_ops == NULL)
 		nthw_meter_init();
@@ -47,7 +47,7 @@ void nthw_reg_filter_ops(const struct ntnic_filter_ops *ops)
 	ntnic_filter_ops = ops;
 }
 
-const struct ntnic_filter_ops *get_ntnic_filter_ops(void)
+const struct ntnic_filter_ops *nthw_get_filter_ops(void)
 {
 	if (ntnic_filter_ops == NULL)
 		ntnic_filter_init();
@@ -62,7 +62,7 @@ void nthw_reg_100g_link_ops(struct link_ops_s *ops)
 	link_100g_ops = ops;
 }
 
-const struct link_ops_s *get_100g_link_ops(void)
+const struct link_ops_s *nthw_get_100g_link_ops(void)
 {
 	if (link_100g_ops == NULL)
 		nthw_link_100g_init();
@@ -79,7 +79,7 @@ void nthw_reg_agx_100g_link_ops(struct link_ops_s *ops)
 	link_agx_100g_ops = ops;
 }
 
-const struct link_ops_s *get_agx_100g_link_ops(void)
+const struct link_ops_s *nthw_get_agx_100g_link_ops(void)
 {
 	if (link_agx_100g_ops == NULL)
 		link_agx_100g_init();
@@ -93,7 +93,7 @@ void nthw_reg_port_ops(const struct port_ops *ops)
 	port_ops = ops;
 }
 
-const struct port_ops *get_port_ops(void)
+const struct port_ops *nthw_get_port_ops(void)
 {
 	if (port_ops == NULL)
 		nthw_port_init();
@@ -107,7 +107,7 @@ void nthw_reg_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops)
 	nt4ga_stat_ops = ops;
 }
 
-const struct nt4ga_stat_ops *get_nt4ga_stat_ops(void)
+const struct nt4ga_stat_ops *nthw_get_nt4ga_stat_ops(void)
 {
 	if (nt4ga_stat_ops == NULL)
 		nt4ga_stat_ops_init();
@@ -122,7 +122,7 @@ void nthw_reg_adapter_ops(const struct adapter_ops *ops)
 	adapter_ops = ops;
 }
 
-const struct adapter_ops *get_adapter_ops(void)
+const struct adapter_ops *nthw_get_adapter_ops(void)
 {
 	if (adapter_ops == NULL)
 		nthw_adapter_init();
@@ -136,7 +136,7 @@ void nthw_reg_clk9563_ops(struct clk9563_ops *ops)
 	clk9563_ops = ops;
 }
 
-struct clk9563_ops *get_clk9563_ops(void)
+struct clk9563_ops *nthw_get_clk9563_ops(void)
 {
 	if (clk9563_ops == NULL)
 		clk9563_ops_init();
@@ -150,7 +150,7 @@ void nthw_reg_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops)
 	rst_nt200a0x_ops = ops;
 }
 
-struct rst_nt200a0x_ops *get_rst_nt200a0x_ops(void)
+struct rst_nt200a0x_ops *nthw_get_rst_nt200a0x_ops(void)
 {
 	if (rst_nt200a0x_ops == NULL)
 		rst_nt200a0x_ops_init();
@@ -164,7 +164,7 @@ void nthw_reg_rst9563_ops(struct rst9563_ops *ops)
 	rst9563_ops = ops;
 }
 
-struct rst9563_ops *get_rst9563_ops(void)
+struct rst9563_ops *nthw_get_rst9563_ops(void)
 {
 	if (rst9563_ops == NULL)
 		rst9563_ops_init();
@@ -185,7 +185,7 @@ void nthw_reg_rst9574_ops(struct rst9574_ops *ops)
 	rst9574_ops = ops;
 }
 
-struct rst9574_ops *get_rst9574_ops(void)
+struct rst9574_ops *nthw_get_rst9574_ops(void)
 {
 	if (rst9574_ops == NULL)
 		rst9574_ops_init();
@@ -200,7 +200,7 @@ void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops)
 	rst_nt400dxx_ops = ops;
 }
 
-struct rst_nt400dxx_ops *get_rst_nt400dxx_ops(void)
+struct rst_nt400dxx_ops *nthw_get_rst_nt400dxx_ops(void)
 {
 	if (rst_nt400dxx_ops == NULL)
 		rst_nt400dxx_ops_init();
@@ -208,7 +208,7 @@ struct rst_nt400dxx_ops *get_rst_nt400dxx_ops(void)
 	return rst_nt400dxx_ops;
 }
 
-const struct flow_backend_ops *get_flow_backend_ops(void)
+const struct flow_backend_ops *nthw_get_flow_backend_ops(void)
 {
 	if (flow_backend_ops == NULL)
 		nthw_flow_backend_init();
@@ -223,7 +223,7 @@ void nthw_reg_profile_inline_ops(const struct profile_inline_ops *ops)
 	profile_inline_ops = ops;
 }
 
-const struct profile_inline_ops *get_profile_inline_ops(void)
+const struct profile_inline_ops *nthw_get_profile_inline_ops(void)
 {
 	if (profile_inline_ops == NULL)
 		nthw_profile_inline_init();
@@ -238,7 +238,7 @@ void nthw_reg_flow_filter_ops(const struct flow_filter_ops *ops)
 	flow_filter_ops = ops;
 }
 
-const struct flow_filter_ops *get_flow_filter_ops(void)
+const struct flow_filter_ops *nthw_get_flow_filter_ops(void)
 {
 	if (flow_filter_ops == NULL)
 		nthw_init_flow_filter();
@@ -253,7 +253,7 @@ void nthw_reg_dev_fp_flow_ops(const struct rte_flow_fp_ops *ops)
 	dev_fp_flow_ops = ops;
 }
 
-const struct rte_flow_fp_ops *get_dev_fp_flow_ops(void)
+const struct rte_flow_fp_ops *nthw_get_dev_fp_flow_ops(void)
 {
 	if (dev_fp_flow_ops == NULL)
 		nthw_dev_fp_flow_init();
@@ -268,7 +268,7 @@ void nthw_reg_dev_flow_ops(const struct rte_flow_ops *ops)
 	dev_flow_ops = ops;
 }
 
-const struct rte_flow_ops *get_dev_flow_ops(void)
+const struct rte_flow_ops *nthw_get_dev_flow_ops(void)
 {
 	if (dev_flow_ops == NULL)
 		nthw_dev_flow_init();
@@ -283,7 +283,7 @@ void nthw_reg_xstats_ops(struct ntnic_xstats_ops *ops)
 	ntnic_xstats_ops = ops;
 }
 
-struct ntnic_xstats_ops *get_ntnic_xstats_ops(void)
+struct ntnic_xstats_ops *nthw_get_xstats_ops(void)
 {
 	if (ntnic_xstats_ops == NULL)
 		ntnic_xstats_ops_init();
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 26c8723afa..2ed2286911 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -120,7 +120,7 @@ struct sg_ops_s {
 };
 
 void nthw_reg_sg_ops(struct sg_ops_s *ops);
-const struct sg_ops_s *get_sg_ops(void);
+const struct sg_ops_s *nthw_get_sg_ops(void);
 void nthw_sg_init(void);
 
 /* Meter ops section */
@@ -129,7 +129,7 @@ struct meter_ops_s {
 };
 
 void nthw_reg_meter_ops(struct meter_ops_s *ops);
-const struct meter_ops_s *get_meter_ops(void);
+const struct meter_ops_s *nthw_get_meter_ops(void);
 void nthw_meter_init(void);
 
 /*
@@ -140,7 +140,7 @@ struct ntnic_filter_ops {
 };
 
 void nthw_reg_filter_ops(const struct ntnic_filter_ops *ops);
-const struct ntnic_filter_ops *get_ntnic_filter_ops(void);
+const struct ntnic_filter_ops *nthw_get_filter_ops(void);
 void ntnic_filter_init(void);
 
 struct link_ops_s {
@@ -148,11 +148,11 @@ struct link_ops_s {
 };
 
 void nthw_reg_100g_link_ops(struct link_ops_s *ops);
-const struct link_ops_s *get_100g_link_ops(void);
+const struct link_ops_s *nthw_get_100g_link_ops(void);
 void nthw_link_100g_init(void);
 
 void nthw_reg_agx_100g_link_ops(struct link_ops_s *ops);
-const struct link_ops_s *get_agx_100g_link_ops(void);
+const struct link_ops_s *nthw_get_agx_100g_link_ops(void);
 void link_agx_100g_init(void);
 
 struct port_ops {
@@ -208,7 +208,7 @@ struct port_ops {
 };
 
 void nthw_reg_port_ops(const struct port_ops *ops);
-const struct port_ops *get_port_ops(void);
+const struct port_ops *nthw_get_port_ops(void);
 void nthw_port_init(void);
 
 struct nt4ga_stat_ops {
@@ -219,7 +219,7 @@ struct nt4ga_stat_ops {
 };
 
 void nthw_reg_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops);
-const struct nt4ga_stat_ops *get_nt4ga_stat_ops(void);
+const struct nt4ga_stat_ops *nthw_get_nt4ga_stat_ops(void);
 void nt4ga_stat_ops_init(void);
 
 struct adapter_ops {
@@ -230,7 +230,7 @@ struct adapter_ops {
 };
 
 void nthw_reg_adapter_ops(const struct adapter_ops *ops);
-const struct adapter_ops *get_adapter_ops(void);
+const struct adapter_ops *nthw_get_adapter_ops(void);
 void nthw_adapter_init(void);
 
 struct clk9563_ops {
@@ -239,7 +239,7 @@ struct clk9563_ops {
 };
 
 void nthw_reg_clk9563_ops(struct clk9563_ops *ops);
-struct clk9563_ops *get_clk9563_ops(void);
+struct clk9563_ops *nthw_get_clk9563_ops(void);
 void clk9563_ops_init(void);
 
 struct rst_nt200a0x_ops {
@@ -250,7 +250,7 @@ struct rst_nt200a0x_ops {
 };
 
 void nthw_reg_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops);
-struct rst_nt200a0x_ops *get_rst_nt200a0x_ops(void);
+struct rst_nt200a0x_ops *nthw_get_rst_nt200a0x_ops(void);
 void rst_nt200a0x_ops_init(void);
 
 struct rst9563_ops {
@@ -259,7 +259,7 @@ struct rst9563_ops {
 };
 
 void nthw_reg_rst9563_ops(struct rst9563_ops *ops);
-struct rst9563_ops *get_rst9563_ops(void);
+struct rst9563_ops *nthw_get_rst9563_ops(void);
 void rst9563_ops_init(void);
 
 struct rst9574_ops {
@@ -270,7 +270,7 @@ struct rst9574_ops {
 };
 
 void nthw_reg_rst9574_ops(struct rst9574_ops *ops);
-struct rst9574_ops *get_rst9574_ops(void);
+struct rst9574_ops *nthw_get_rst9574_ops(void);
 void rst9574_ops_init(void);
 
 struct rst_nt400dxx_ops {
@@ -279,7 +279,7 @@ struct rst_nt400dxx_ops {
 };
 
 void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops);
-struct rst_nt400dxx_ops *get_rst_nt400dxx_ops(void);
+struct rst_nt400dxx_ops *nthw_get_rst_nt400dxx_ops(void);
 void rst_nt400dxx_ops_init(void);
 
 struct flow_backend_ops {
@@ -289,7 +289,7 @@ struct flow_backend_ops {
 };
 
 void nthw_reg_flow_backend_ops(const struct flow_backend_ops *ops);
-const struct flow_backend_ops *get_flow_backend_ops(void);
+const struct flow_backend_ops *nthw_get_flow_backend_ops(void);
 void nthw_flow_backend_init(void);
 
 struct profile_inline_ops {
@@ -447,7 +447,7 @@ struct profile_inline_ops {
 };
 
 void nthw_reg_profile_inline_ops(const struct profile_inline_ops *ops);
-const struct profile_inline_ops *get_profile_inline_ops(void);
+const struct profile_inline_ops *nthw_get_profile_inline_ops(void);
 void nthw_profile_inline_init(void);
 
 struct flow_filter_ops {
@@ -560,15 +560,15 @@ struct flow_filter_ops {
 };
 
 void nthw_reg_dev_fp_flow_ops(const struct rte_flow_fp_ops *ops);
-const struct rte_flow_fp_ops *get_dev_fp_flow_ops(void);
+const struct rte_flow_fp_ops *nthw_get_dev_fp_flow_ops(void);
 void nthw_dev_fp_flow_init(void);
 
 void nthw_reg_dev_flow_ops(const struct rte_flow_ops *ops);
-const struct rte_flow_ops *get_dev_flow_ops(void);
+const struct rte_flow_ops *nthw_get_dev_flow_ops(void);
 void nthw_dev_flow_init(void);
 
 void nthw_reg_flow_filter_ops(const struct flow_filter_ops *ops);
-const struct flow_filter_ops *get_flow_filter_ops(void);
+const struct flow_filter_ops *nthw_get_flow_filter_ops(void);
 void nthw_init_flow_filter(void);
 
 struct ntnic_xstats_ops {
@@ -592,7 +592,7 @@ struct ntnic_xstats_ops {
 };
 
 void nthw_reg_xstats_ops(struct ntnic_xstats_ops *ops);
-struct ntnic_xstats_ops *get_ntnic_xstats_ops(void);
+struct ntnic_xstats_ops *nthw_get_xstats_ops(void);
 void ntnic_xstats_ops_init(void);
 
 #endif	/* __NTNIC_MOD_REG_H__ */
-- 
2.45.0

