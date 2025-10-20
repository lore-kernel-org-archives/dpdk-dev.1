Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053FCCCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A95BB40DF5;
	Mon, 20 Oct 2025 18:36:46 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 000584068A
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:39 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022095.outbound.protection.outlook.com [52.101.66.95])
 by mx-outbound16-13.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiAZ3tnQBFrpzCRsf9dXXEZ03JkumiZ8tfqgL6JBTN0m8mdXDVUHtdSX1rkfB6GnBjU/PZnUTZkUagBGTUo1dJtTUmv2MlvCK9D/bI9TYgC+rkGGFHvIxoR67oT7SRTwhq87/8dBTEIhqUVcsd0p11f34LloCgX8sSLeMjbd6rPv47wzsRoGS9BH3Cto8liZFl+Kbc7xr6yCI+LqeqvVWxidhFRHdVrzSv8dxqtjkRxVqeFbxXdTO+8WVWVYCiZCOTV5UFXn50SlZrF4BTl14iRUQ+O9k0oIGi7QMiVXcYC3bJlqZyVXq7d5OMHvnPD2riJWhokx/lyaTH+xuSZucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwXI1CLiDMuQE+/Rm+xj4MSUX3TqgHHaHfjZuVXHv5o=;
 b=kIGqgZbe5cOPB01dPqy3EO0eZFzBcxxAifjKQzKGym1rKWvQRcB5MeqjpV97LewMgjxVWRgi01ghG0fvrN1SOpFL3qKXJXGkIuq0cXFjziMqS0qnpbD1XrrKoZEg0o8jCYKVM/AfqvR7lHFTv4lWoLVvuwVoDikJEfsZYaSdOK56liJZJi5RJP+S4IUiwbTVqkzAV4HpUU/34vs8M3ZP3ZPGL/MGodahpIobqAiA2RVgN0vaw2zDYQo4hv4X362z1qV8JrOIebItCXQD05eypCLtPBqzaBXOM6eoZCtZwCEVhzXKau5q6+SvnHhQ44uleVX3Tr/8YAgXJC+4f8UXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwXI1CLiDMuQE+/Rm+xj4MSUX3TqgHHaHfjZuVXHv5o=;
 b=GtphKm6sUBsyn/hEv01Wx+HmWIn6HlN+vzOiLMR7DeGusBkllW2WZNQN/LJvNCAQxRPTD2e8HgackFCXPsAGI7gh9kouIAJi9VioO/i+VBJ+ajALIzzbS3AQm71N1BVzc1qiA+GzxfJGS/703vZAUKi16/J0DCbiCLU7yxjxATQ=
Received: from AS4P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::20)
 by PRAP190MB1786.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:29a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:35 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::da) by AS4P191CA0028.outlook.office365.com
 (2603:10a6:20b:5d9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:34
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 11/24] net/ntnic: move nthw to prefix part
Date: Mon, 20 Oct 2025 18:36:02 +0200
Message-ID: <20251020163620.282312-12-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|PRAP190MB1786:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6c40aa90-7945-4209-8978-08de0ff6d55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aWYiscmehVnUxePsXai4Vt1/mXLvfD842t06kzRmMTTWRZRiSC11Zss1uyvx?=
 =?us-ascii?Q?3Mf+hghzB8Cm7AkUhBV28a24aBHINRUhtPiKVMwpU+RzU5mFmEYivngO2eWV?=
 =?us-ascii?Q?poPXuxhAOFdrrs1Ks7llBhxwrNlfTRkKU5MHaGIjsPZebiTODqyN2RKQdi2D?=
 =?us-ascii?Q?qbKIq4OJeEpm5Lth3OhchtOTDcc5bDuPHl35tUNMxUm+iT19GU66UWKfM+Gk?=
 =?us-ascii?Q?yqC9QS5DO8DbxdHsmZyZIuVrdzJIBRM4N4cbJETyszriiCuilHNN6sYb7yiM?=
 =?us-ascii?Q?F0nYncq5fJyVGw4ElFJp9PYonG/kZg6IBUM1E03jzIGLoOfps8AeV1ew3TIf?=
 =?us-ascii?Q?3uuuv+Mjznq0WXY39UOn1tUZdSEKvfB2mVi1m/DBLYwTAY1NcF4xqH7/n1P5?=
 =?us-ascii?Q?30PufTHeLta2FI7JQS8jaHg1SbwGmKGxaqelNOl3MIYRpQopUcJTBbC9y8mu?=
 =?us-ascii?Q?FuCfiyRp8+sTApvIoNmHKP3kfvHmS9djQHSnbhBG65/pE5WnUhumPUD47cjb?=
 =?us-ascii?Q?yHVb/I/Q34yIEMNlZZc4msnI65dfY35uzEiGY3/2GAw32q2DddjvbHkPOlZo?=
 =?us-ascii?Q?4MFNSlGiEe3WHKlAX30QAJ1MpcsSOYew0dodPeB5JG2f7207/3CjlK6RhEgU?=
 =?us-ascii?Q?86DvxF0Z9A3LXHybJRz9vBGbyQtUXj3MKYFU5PQGcuXhsY99Nva105GURD+I?=
 =?us-ascii?Q?zmDCq3vAF+4ArK/La5f1WLXBB22BPEepHlWyzgxt9kkI42ETGdcX9YcTrHw+?=
 =?us-ascii?Q?Vy7WZ1VA33wvcFsE6XBfLVJIV/EoQ+OY9FQTLqrUM02jC6dBq5jUiZ4TNkfe?=
 =?us-ascii?Q?0FQ94cNk54de4Wyl2UaT3EviBvzSueXLzKbJS58dY5w+U86DXboQkUsRql4i?=
 =?us-ascii?Q?tASeUbYxmIr3LNkRzOys447ZWr+O48wbhz1uDLsnCaFQvAvvAzROCr0rDYn/?=
 =?us-ascii?Q?7U3geGYDRdGAFa1qBmdusdZ49C93to7xxJw7KQ14T//RIzfPp++A4H14QwUy?=
 =?us-ascii?Q?b1ZbnDzRkki4u88IaJhL5E8lCT20Z24vxi8iZRt2FOt7jFj0KhYRin7ELcMb?=
 =?us-ascii?Q?wyveyKWliT987VtlvVxWdfdXKJrm5ClyEd8yWXE/2uZ6YtTyV+OggnEcbIQQ?=
 =?us-ascii?Q?vmg8UG06RjkL5dzyzExuQkDtZidbNk1Zn5kxyVjSSYqLPIRqS2it/0x23LsG?=
 =?us-ascii?Q?G7t7ZUKHVLHw6QXPYd04hUj9dmvnnewy2hA4BOPBMC71FsrC/TaVfKqIFWvL?=
 =?us-ascii?Q?i3BnoTa/tUulnK9IhPh9SSrWB1yH9x6vMrhqBU8h41e2KbBCoNu71NanwdXK?=
 =?us-ascii?Q?AtwzQzbwjpxWD5nnw31qGIhQIWsLYnYFD4hrCXKX1kWEMQf/xY5FR1kz5M63?=
 =?us-ascii?Q?NWV1ZwrU7ReoZEFX4CtlmlnJkZS1VKKphAR9PcQi7Se8q5EyBLcJaZVlXNgj?=
 =?us-ascii?Q?/F0PmOFGMjsAW58AGlv5OEy3PlerdZ/pq/gHUrk2yyNaxhG6aQKdvAVsj3Hq?=
 =?us-ascii?Q?rt0TYVlKj8fIT6qKc+alXbMJ0o7FqXJhPsni3U8/t4RUth1Rx/21BK417dBK?=
 =?us-ascii?Q?xXKcUhdLCOXOM2DRD0E=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qCDT8CnpbVWPt4vGCT4htMRmbxMXcOHXv4AxeRLjVXo6fY6tbAQKEYmM343yiPf0MCimysvg3zcKl8vBcICtFnnqheNQtIdZYAw0mR0ZV/mloaDr2qeUBVh2QN8E/WjlDFWWGZB51uohTorlO0iFfHBJPNRwpYN80NS8D15EBT8NgcLr2YKHM8lNvKlSAxI3DetsXqInDHNSK682lxl0XdMHSuqZrSGNV8eGDK2SEk9TLBD4qHL3DSRIw0hXOC1LsgOieJkFNnQBrcQgSQ7l+q62xmJDdwz18C5mzPXzZmSFFAfsnYgNf2x6fgCf2tyrM7Wb7eoWKCSplOD4jL6CY3B0qINaZ5AjU94SZGmyZR1T03W7eov8FRc5c0U9IDuhZ/zmznQS5w6yurcUgmdhQ/3znp+vWXS8grdqCj3EPYlrJAb68GlVSN32KEnHFmOw9YsnpfrYXATNUqD3m+xTKPR54f93C1Y3Gse24eXh0Vr0Aj02XpmGtCbx+L2lW4MOkoegdVAgw8500rFlBzeew6xWtLpT4oWOWtJ9P6TVQauNqxiQ9UHwsVAihyrqC/hmZ2nYeo0iHtboPGjjP2qTEZFRJgGGLQrqHPYQpWRhQlFtXRPHaQUmtHju/mdNueGSvqOmjrjQwvABce4EOrr2AQrKTE/UVp5KnzGraaibFj8=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:34.8198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c40aa90-7945-4209-8978-08de0ff6d55e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP190MB1786
X-BESS-ID: 1760978198-304109-7615-117688-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.66.95
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGJqYmBkB2BlDY1MjM1DQx0c
 LQMCXRKMkwOTnJ0DTJLMXcyNAsySQ1zUCpNhYAM+mfB0MAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-181.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 LARGE_BODY_SHORTCUT    META:  
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=LARGE_BODY_SHORTCUT
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

Move nthw_ from function names to a prefix to specify
NapaTech Hardware-related functions.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |    2 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |    2 +-
 .../nthw/flow_api/flow_backend/flow_backend.c | 1336 ++++++++---------
 .../ntnic/nthw/flow_filter/flow_nthw_cat.c    |  230 +--
 .../ntnic/nthw/flow_filter/flow_nthw_cat.h    |  230 +--
 .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |   22 +-
 .../ntnic/nthw/flow_filter/flow_nthw_csu.h    |   24 +-
 .../ntnic/nthw/flow_filter/flow_nthw_flm.c    |  278 ++--
 .../ntnic/nthw/flow_filter/flow_nthw_flm.h    |  278 ++--
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |   58 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hfu.h    |   58 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |   60 +-
 .../ntnic/nthw/flow_filter/flow_nthw_hsh.h    |   60 +-
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.c    |   30 +-
 .../ntnic/nthw/flow_filter/flow_nthw_ifr.h    |   30 +-
 .../ntnic/nthw/flow_filter/flow_nthw_info.c   |   88 +-
 .../ntnic/nthw/flow_filter/flow_nthw_info.h   |   88 +-
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |  160 +-
 .../net/ntnic/nthw/flow_filter/flow_nthw_km.h |  162 +-
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |   54 +-
 .../ntnic/nthw/flow_filter/flow_nthw_pdb.h    |   56 +-
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |   68 +-
 .../ntnic/nthw/flow_filter/flow_nthw_qsl.h    |   68 +-
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |   32 +-
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h |   32 +-
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |   28 +-
 .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.h |   28 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |   22 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h |   22 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |   20 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.h |   20 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |   42 +-
 .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h |   46 +-
 .../net/ntnic/nthw/model/nthw_fpga_model.c    |   12 +-
 drivers/net/ntnic/nthw/nthw_platform.c        |    2 +-
 drivers/net/ntnic/nthw/nthw_platform_drv.h    |    2 +-
 .../nthw/supported/nthw_fpga_mod_str_map.c    |    2 +-
 .../nthw/supported/nthw_fpga_mod_str_map.h    |    2 +-
 38 files changed, 1877 insertions(+), 1877 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index de4e8707bf..98725879b9 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -71,7 +71,7 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 	int res = -1;
 	nthw_fpga_t *p_fpga = NULL;
 
-	p_hw_info->n_nthw_adapter_id = nthw_platform_get_nthw_adapter_id(p_hw_info->pci_device_id);
+	p_hw_info->n_nthw_adapter_id = nthw_platform_get_adapter_id(p_hw_info->pci_device_id);
 
 	fpga_info->n_nthw_adapter_id = p_hw_info->n_nthw_adapter_id;
 	/* ref: DN-0060 section 9 */
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 9153b31cea..f9e8f90e8a 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -388,7 +388,7 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 	p_fpga_mgr = nthw_fpga_mgr_new();
 	if (p_fpga_mgr) {
 		nthw_fpga_mgr_init(p_fpga_mgr, nthw_fpga_instances,
-			(const void *)sa_nthw_fpga_mod_str_map);
+			(const void *)nthw_sa_fpga_mod_str_map);
 		nthw_fpga_mgr_log_dump(p_fpga_mgr);
 		p_fpga = nthw_fpga_mgr_query_fpga(p_fpga_mgr, n_fpga_ident, p_fpga_info);
 		p_fpga_info->mp_fpga = p_fpga;
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
index 360cbc155a..cb6489b3ac 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
@@ -55,14 +55,14 @@ static struct backend_dev_s {
 	int __debug__ = 0;                                                                        \
 	if (((be)->dmode & FLOW_BACKEND_DEBUG_MODE_WRITE) || (mod)->debug)                        \
 		do {                                                                              \
-			mod##_nthw_set_debug_mode((inst), 0xFF);                                  \
+			nthw_##mod ##_set_debug_mode((inst), 0xFF);                               \
 			__debug__ = 1;                                                            \
 	} while (0)
 
 #define CHECK_DEBUG_OFF(mod, inst)                                                                \
 	do {                                                                                      \
 		if (__debug__)                                                                    \
-			mod##_nthw_set_debug_mode((inst), 0);                                     \
+			nthw_##mod ##_set_debug_mode((inst), 0);                                  \
 	} while (0)
 
 const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpga, void **be_dev);
@@ -82,247 +82,247 @@ static int set_debug_mode(void *be_dev, enum debug_mode_e mode)
 static int get_nb_phy_ports(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_phy_ports(be->p_info_nthw);
+	return nthw_info_get_nb_phy_ports(be->p_info_nthw);
 }
 
 static int get_nb_rx_ports(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_rx_ports(be->p_info_nthw);
+	return nthw_info_get_nb_rx_ports(be->p_info_nthw);
 }
 
 static int get_ltx_avail(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_ltx_avail(be->p_info_nthw);
+	return nthw_info_get_ltx_avail(be->p_info_nthw);
 }
 
 static int get_nb_cat_funcs(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_cat_funcs(be->p_info_nthw);
+	return nthw_info_get_nb_cat_funcs(be->p_info_nthw);
 }
 
 static int get_nb_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_categories(be->p_info_nthw);
+	return nthw_info_get_nb_categories(be->p_info_nthw);
 }
 
 static int get_nb_cat_km_if_cnt(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_cat_km_if_cnt(be->p_info_nthw);
+	return nthw_info_get_nb_cat_km_if_cnt(be->p_info_nthw);
 }
 
 static int get_nb_cat_km_if_m0(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_cat_km_if_m0(be->p_info_nthw);
+	return nthw_info_get_nb_cat_km_if_m0(be->p_info_nthw);
 }
 
 static int get_nb_cat_km_if_m1(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_cat_km_if_m1(be->p_info_nthw);
+	return nthw_info_get_nb_cat_km_if_m1(be->p_info_nthw);
 }
 
 static int get_nb_queues(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_queues(be->p_info_nthw);
+	return nthw_info_get_nb_queues(be->p_info_nthw);
 }
 
 static int get_nb_km_flow_types(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_km_flow_types(be->p_info_nthw);
+	return nthw_info_get_nb_km_flow_types(be->p_info_nthw);
 }
 
 static int get_nb_pm_ext(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_pm_ext(be->p_info_nthw);
+	return nthw_info_get_nb_pm_ext(be->p_info_nthw);
 }
 
 static int get_nb_len(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_len(be->p_info_nthw);
+	return nthw_info_get_nb_len(be->p_info_nthw);
 }
 
 static int get_kcc_size(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_kcc_size(be->p_info_nthw);
+	return nthw_info_get_kcc_size(be->p_info_nthw);
 }
 
 static int get_kcc_banks(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_kcc_banks(be->p_info_nthw);
+	return nthw_info_get_kcc_banks(be->p_info_nthw);
 }
 
 static int get_nb_km_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_km_categories(be->p_info_nthw);
+	return nthw_info_get_nb_km_categories(be->p_info_nthw);
 }
 
 static int get_nb_km_cam_banks(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_km_cam_banks(be->p_info_nthw);
+	return nthw_info_get_nb_km_cam_banks(be->p_info_nthw);
 }
 
 static int get_nb_km_cam_record_words(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_km_cam_record_words(be->p_info_nthw);
+	return nthw_info_get_nb_km_cam_record_words(be->p_info_nthw);
 }
 
 static int get_nb_km_cam_records(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_km_cam_records(be->p_info_nthw);
+	return nthw_info_get_nb_km_cam_records(be->p_info_nthw);
 }
 
 static int get_nb_km_tcam_banks(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_km_tcam_banks(be->p_info_nthw);
+	return nthw_info_get_nb_km_tcam_banks(be->p_info_nthw);
 }
 
 static int get_nb_km_tcam_bank_width(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_km_tcam_bank_width(be->p_info_nthw);
+	return nthw_info_get_nb_km_tcam_bank_width(be->p_info_nthw);
 }
 
 static int get_nb_flm_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_flm_categories(be->p_info_nthw);
+	return nthw_info_get_nb_flm_categories(be->p_info_nthw);
 }
 
 static int get_nb_flm_size_mb(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_flm_size_mb(be->p_info_nthw);
+	return nthw_info_get_nb_flm_size_mb(be->p_info_nthw);
 }
 
 static int get_nb_flm_entry_size(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_flm_entry_size(be->p_info_nthw);
+	return nthw_info_get_nb_flm_entry_size(be->p_info_nthw);
 }
 
 static int get_nb_flm_variant(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_flm_variant(be->p_info_nthw);
+	return nthw_info_get_nb_flm_variant(be->p_info_nthw);
 }
 
 static int get_nb_flm_prios(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_flm_prios(be->p_info_nthw);
+	return nthw_info_get_nb_flm_prios(be->p_info_nthw);
 }
 
 static int get_nb_flm_pst_profiles(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_flm_pst_profiles(be->p_info_nthw);
+	return nthw_info_get_nb_flm_pst_profiles(be->p_info_nthw);
 }
 
 static int get_nb_flm_scrub_profiles(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_flm_scrub_profiles(be->p_info_nthw);
+	return nthw_info_get_nb_flm_scrub_profiles(be->p_info_nthw);
 }
 
 static int get_nb_flm_load_aps_max(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_flm_load_aps_max(be->p_info_nthw);
+	return nthw_info_get_nb_flm_load_aps_max(be->p_info_nthw);
 }
 
 static int get_nb_qsl_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_qsl_categories(be->p_info_nthw);
+	return nthw_info_get_nb_qsl_categories(be->p_info_nthw);
 }
 
 static int get_nb_qsl_qst_entries(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_qsl_qst_entries(be->p_info_nthw);
+	return nthw_info_get_nb_qsl_qst_entries(be->p_info_nthw);
 }
 
 static int get_nb_pdb_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_pdb_categories(be->p_info_nthw);
+	return nthw_info_get_nb_pdb_categories(be->p_info_nthw);
 }
 
 static int get_nb_roa_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_roa_categories(be->p_info_nthw);
+	return nthw_info_get_nb_roa_categories(be->p_info_nthw);
 }
 
 static int get_nb_tpe_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_tpe_categories(be->p_info_nthw);
+	return nthw_info_get_nb_tpe_categories(be->p_info_nthw);
 }
 
 static int get_nb_tx_cpy_writers(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_tx_cpy_writers(be->p_info_nthw);
+	return nthw_info_get_nb_tx_cpy_writers(be->p_info_nthw);
 }
 
 static int get_nb_tx_cpy_mask_mem(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_tx_cpy_mask_mem(be->p_info_nthw);
+	return nthw_info_get_nb_tx_cpy_mask_mem(be->p_info_nthw);
 }
 
 static int get_nb_tx_rpl_depth(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_tx_rpl_depth(be->p_info_nthw);
+	return nthw_info_get_nb_tx_rpl_depth(be->p_info_nthw);
 }
 
 static int get_nb_tx_rpl_ext_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_tx_rpl_ext_categories(be->p_info_nthw);
+	return nthw_info_get_nb_tx_rpl_ext_categories(be->p_info_nthw);
 }
 
 static int get_nb_tpe_ifr_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_tpe_ifr_categories(be->p_info_nthw);
+	return nthw_info_get_nb_tpe_ifr_categories(be->p_info_nthw);
 }
 
 static int get_nb_rpp_per_ps(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_rpp_per_ps(be->p_info_nthw);
+	return nthw_info_get_nb_rpp_per_ps(be->p_info_nthw);
 }
 
 static int get_nb_hsh_categories(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_hsh_categories(be->p_info_nthw);
+	return nthw_info_get_nb_hsh_categories(be->p_info_nthw);
 }
 
 static int get_nb_hsh_toeplitz(void *be_dev)
 {
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
-	return info_nthw_get_nb_hsh_toeplitz(be->p_info_nthw);
+	return nthw_info_get_nb_hsh_toeplitz(be->p_info_nthw);
 }
 
 /*
@@ -349,128 +349,128 @@ static int cat_cfn_flush(void *be_dev, const struct cat_func_s *cat, int cat_fun
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18) {
-		cat_nthw_cfn_cnt(be->p_cat_nthw, 1U);
+		nthw_cat_cfn_cnt(be->p_cat_nthw, 1U);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_cfn_select(be->p_cat_nthw, cat_func);
-			cat_nthw_cfn_enable(be->p_cat_nthw, cat->v18.cfn[cat_func].enable);
-			cat_nthw_cfn_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].inv);
-			cat_nthw_cfn_ptc_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_inv);
-			cat_nthw_cfn_ptc_isl(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_isl);
-			cat_nthw_cfn_ptc_cfp(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_cfp);
-			cat_nthw_cfn_ptc_mac(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_mac);
-			cat_nthw_cfn_ptc_l2(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_l2);
-			cat_nthw_cfn_ptc_vn_tag(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_vntag);
-			cat_nthw_cfn_ptc_vlan(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_vlan);
-			cat_nthw_cfn_ptc_mpls(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_mpls);
-			cat_nthw_cfn_ptc_l3(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_l3);
-			cat_nthw_cfn_ptc_frag(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_frag);
-			cat_nthw_cfn_ptc_ip_prot(be->p_cat_nthw,
+			nthw_cat_cfn_select(be->p_cat_nthw, cat_func);
+			nthw_cat_cfn_enable(be->p_cat_nthw, cat->v18.cfn[cat_func].enable);
+			nthw_cat_cfn_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].inv);
+			nthw_cat_cfn_ptc_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_inv);
+			nthw_cat_cfn_ptc_isl(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_isl);
+			nthw_cat_cfn_ptc_cfp(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_cfp);
+			nthw_cat_cfn_ptc_mac(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_mac);
+			nthw_cat_cfn_ptc_l2(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_l2);
+			nthw_cat_cfn_ptc_vn_tag(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_vntag);
+			nthw_cat_cfn_ptc_vlan(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_vlan);
+			nthw_cat_cfn_ptc_mpls(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_mpls);
+			nthw_cat_cfn_ptc_l3(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_l3);
+			nthw_cat_cfn_ptc_frag(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_frag);
+			nthw_cat_cfn_ptc_ip_prot(be->p_cat_nthw,
 				cat->v18.cfn[cat_func].ptc_ip_prot);
-			cat_nthw_cfn_ptc_l4(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_l4);
-			cat_nthw_cfn_ptc_tunnel(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_tunnel);
-			cat_nthw_cfn_ptc_tnl_l2(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_tnl_l2);
-			cat_nthw_cfn_ptc_tnl_vlan(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_l4(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_l4);
+			nthw_cat_cfn_ptc_tunnel(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_tunnel);
+			nthw_cat_cfn_ptc_tnl_l2(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_tnl_l2);
+			nthw_cat_cfn_ptc_tnl_vlan(be->p_cat_nthw,
 				cat->v18.cfn[cat_func].ptc_tnl_vlan);
-			cat_nthw_cfn_ptc_tnl_mpls(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_tnl_mpls(be->p_cat_nthw,
 				cat->v18.cfn[cat_func].ptc_tnl_mpls);
-			cat_nthw_cfn_ptc_tnl_l3(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_tnl_l3);
-			cat_nthw_cfn_ptc_tnl_frag(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_tnl_l3(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_tnl_l3);
+			nthw_cat_cfn_ptc_tnl_frag(be->p_cat_nthw,
 				cat->v18.cfn[cat_func].ptc_tnl_frag);
-			cat_nthw_cfn_ptc_tnl_ip_prot(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_tnl_ip_prot(be->p_cat_nthw,
 				cat->v18.cfn[cat_func].ptc_tnl_ip_prot);
-			cat_nthw_cfn_ptc_tnl_l4(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_tnl_l4);
-
-			cat_nthw_cfn_err_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].err_inv);
-			cat_nthw_cfn_err_cv(be->p_cat_nthw, cat->v18.cfn[cat_func].err_cv);
-			cat_nthw_cfn_err_fcs(be->p_cat_nthw, cat->v18.cfn[cat_func].err_fcs);
-			cat_nthw_cfn_err_trunc(be->p_cat_nthw, cat->v18.cfn[cat_func].err_trunc);
-			cat_nthw_cfn_err_l3_cs(be->p_cat_nthw, cat->v18.cfn[cat_func].err_l3_cs);
-			cat_nthw_cfn_err_l4_cs(be->p_cat_nthw, cat->v18.cfn[cat_func].err_l4_cs);
-
-			cat_nthw_cfn_mac_port(be->p_cat_nthw, cat->v18.cfn[cat_func].mac_port);
-
-			cat_nthw_cfn_pm_cmp(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_cmp);
-			cat_nthw_cfn_pm_dct(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_dct);
-			cat_nthw_cfn_pm_ext_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_ext_inv);
-			cat_nthw_cfn_pm_cmb(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_cmb);
-			cat_nthw_cfn_pm_and_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_and_inv);
-			cat_nthw_cfn_pm_or_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_or_inv);
-			cat_nthw_cfn_pm_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_inv);
-
-			cat_nthw_cfn_lc(be->p_cat_nthw, cat->v18.cfn[cat_func].lc);
-			cat_nthw_cfn_lc_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].lc_inv);
-			cat_nthw_cfn_km0_or(be->p_cat_nthw, cat->v18.cfn[cat_func].km_or);
-			cat_nthw_cfn_flush(be->p_cat_nthw);
+			nthw_cat_cfn_ptc_tnl_l4(be->p_cat_nthw, cat->v18.cfn[cat_func].ptc_tnl_l4);
+
+			nthw_cat_cfn_err_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].err_inv);
+			nthw_cat_cfn_err_cv(be->p_cat_nthw, cat->v18.cfn[cat_func].err_cv);
+			nthw_cat_cfn_err_fcs(be->p_cat_nthw, cat->v18.cfn[cat_func].err_fcs);
+			nthw_cat_cfn_err_trunc(be->p_cat_nthw, cat->v18.cfn[cat_func].err_trunc);
+			nthw_cat_cfn_err_l3_cs(be->p_cat_nthw, cat->v18.cfn[cat_func].err_l3_cs);
+			nthw_cat_cfn_err_l4_cs(be->p_cat_nthw, cat->v18.cfn[cat_func].err_l4_cs);
+
+			nthw_cat_cfn_mac_port(be->p_cat_nthw, cat->v18.cfn[cat_func].mac_port);
+
+			nthw_cat_cfn_pm_cmp(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_cmp);
+			nthw_cat_cfn_pm_dct(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_dct);
+			nthw_cat_cfn_pm_ext_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_ext_inv);
+			nthw_cat_cfn_pm_cmb(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_cmb);
+			nthw_cat_cfn_pm_and_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_and_inv);
+			nthw_cat_cfn_pm_or_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_or_inv);
+			nthw_cat_cfn_pm_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].pm_inv);
+
+			nthw_cat_cfn_lc(be->p_cat_nthw, cat->v18.cfn[cat_func].lc);
+			nthw_cat_cfn_lc_inv(be->p_cat_nthw, cat->v18.cfn[cat_func].lc_inv);
+			nthw_cat_cfn_km0_or(be->p_cat_nthw, cat->v18.cfn[cat_func].km_or);
+			nthw_cat_cfn_flush(be->p_cat_nthw);
 			cat_func++;
 		}
 
 	} else if (cat->ver == 21) {
-		cat_nthw_cfn_cnt(be->p_cat_nthw, 1U);
+		nthw_cat_cfn_cnt(be->p_cat_nthw, 1U);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_cfn_select(be->p_cat_nthw, cat_func);
-			cat_nthw_cfn_enable(be->p_cat_nthw, cat->v21.cfn[cat_func].enable);
-			cat_nthw_cfn_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].inv);
-			cat_nthw_cfn_ptc_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_inv);
-			cat_nthw_cfn_ptc_isl(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_isl);
-			cat_nthw_cfn_ptc_cfp(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_cfp);
-			cat_nthw_cfn_ptc_mac(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_mac);
-			cat_nthw_cfn_ptc_l2(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_l2);
-			cat_nthw_cfn_ptc_vn_tag(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_vntag);
-			cat_nthw_cfn_ptc_vlan(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_vlan);
-			cat_nthw_cfn_ptc_mpls(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_mpls);
-			cat_nthw_cfn_ptc_l3(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_l3);
-			cat_nthw_cfn_ptc_frag(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_frag);
-			cat_nthw_cfn_ptc_ip_prot(be->p_cat_nthw,
+			nthw_cat_cfn_select(be->p_cat_nthw, cat_func);
+			nthw_cat_cfn_enable(be->p_cat_nthw, cat->v21.cfn[cat_func].enable);
+			nthw_cat_cfn_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].inv);
+			nthw_cat_cfn_ptc_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_inv);
+			nthw_cat_cfn_ptc_isl(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_isl);
+			nthw_cat_cfn_ptc_cfp(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_cfp);
+			nthw_cat_cfn_ptc_mac(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_mac);
+			nthw_cat_cfn_ptc_l2(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_l2);
+			nthw_cat_cfn_ptc_vn_tag(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_vntag);
+			nthw_cat_cfn_ptc_vlan(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_vlan);
+			nthw_cat_cfn_ptc_mpls(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_mpls);
+			nthw_cat_cfn_ptc_l3(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_l3);
+			nthw_cat_cfn_ptc_frag(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_frag);
+			nthw_cat_cfn_ptc_ip_prot(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].ptc_ip_prot);
-			cat_nthw_cfn_ptc_l4(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_l4);
-			cat_nthw_cfn_ptc_tunnel(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_tunnel);
-			cat_nthw_cfn_ptc_tnl_l2(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_tnl_l2);
-			cat_nthw_cfn_ptc_tnl_vlan(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_l4(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_l4);
+			nthw_cat_cfn_ptc_tunnel(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_tunnel);
+			nthw_cat_cfn_ptc_tnl_l2(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_tnl_l2);
+			nthw_cat_cfn_ptc_tnl_vlan(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].ptc_tnl_vlan);
-			cat_nthw_cfn_ptc_tnl_mpls(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_tnl_mpls(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].ptc_tnl_mpls);
-			cat_nthw_cfn_ptc_tnl_l3(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_tnl_l3);
-			cat_nthw_cfn_ptc_tnl_frag(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_tnl_l3(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_tnl_l3);
+			nthw_cat_cfn_ptc_tnl_frag(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].ptc_tnl_frag);
-			cat_nthw_cfn_ptc_tnl_ip_prot(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_tnl_ip_prot(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].ptc_tnl_ip_prot);
-			cat_nthw_cfn_ptc_tnl_l4(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_tnl_l4);
-
-			cat_nthw_cfn_err_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].err_inv);
-			cat_nthw_cfn_err_cv(be->p_cat_nthw, cat->v21.cfn[cat_func].err_cv);
-			cat_nthw_cfn_err_fcs(be->p_cat_nthw, cat->v21.cfn[cat_func].err_fcs);
-			cat_nthw_cfn_err_trunc(be->p_cat_nthw, cat->v21.cfn[cat_func].err_trunc);
-			cat_nthw_cfn_err_l3_cs(be->p_cat_nthw, cat->v21.cfn[cat_func].err_l3_cs);
-			cat_nthw_cfn_err_l4_cs(be->p_cat_nthw, cat->v21.cfn[cat_func].err_l4_cs);
-			cat_nthw_cfn_err_tnl_l3_cs(be->p_cat_nthw,
+			nthw_cat_cfn_ptc_tnl_l4(be->p_cat_nthw, cat->v21.cfn[cat_func].ptc_tnl_l4);
+
+			nthw_cat_cfn_err_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].err_inv);
+			nthw_cat_cfn_err_cv(be->p_cat_nthw, cat->v21.cfn[cat_func].err_cv);
+			nthw_cat_cfn_err_fcs(be->p_cat_nthw, cat->v21.cfn[cat_func].err_fcs);
+			nthw_cat_cfn_err_trunc(be->p_cat_nthw, cat->v21.cfn[cat_func].err_trunc);
+			nthw_cat_cfn_err_l3_cs(be->p_cat_nthw, cat->v21.cfn[cat_func].err_l3_cs);
+			nthw_cat_cfn_err_l4_cs(be->p_cat_nthw, cat->v21.cfn[cat_func].err_l4_cs);
+			nthw_cat_cfn_err_tnl_l3_cs(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].err_tnl_l3_cs);
-			cat_nthw_cfn_err_tnl_l4_cs(be->p_cat_nthw,
+			nthw_cat_cfn_err_tnl_l4_cs(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].err_tnl_l4_cs);
-			cat_nthw_cfn_err_ttl_exp(be->p_cat_nthw,
+			nthw_cat_cfn_err_ttl_exp(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].err_ttl_exp);
-			cat_nthw_cfn_err_tnl_ttl_exp(be->p_cat_nthw,
+			nthw_cat_cfn_err_tnl_ttl_exp(be->p_cat_nthw,
 				cat->v21.cfn[cat_func].err_tnl_ttl_exp);
 
-			cat_nthw_cfn_mac_port(be->p_cat_nthw, cat->v21.cfn[cat_func].mac_port);
+			nthw_cat_cfn_mac_port(be->p_cat_nthw, cat->v21.cfn[cat_func].mac_port);
 
-			cat_nthw_cfn_pm_cmp(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_cmp);
-			cat_nthw_cfn_pm_dct(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_dct);
-			cat_nthw_cfn_pm_ext_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_ext_inv);
-			cat_nthw_cfn_pm_cmb(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_cmb);
-			cat_nthw_cfn_pm_and_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_and_inv);
-			cat_nthw_cfn_pm_or_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_or_inv);
-			cat_nthw_cfn_pm_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_inv);
+			nthw_cat_cfn_pm_cmp(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_cmp);
+			nthw_cat_cfn_pm_dct(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_dct);
+			nthw_cat_cfn_pm_ext_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_ext_inv);
+			nthw_cat_cfn_pm_cmb(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_cmb);
+			nthw_cat_cfn_pm_and_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_and_inv);
+			nthw_cat_cfn_pm_or_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_or_inv);
+			nthw_cat_cfn_pm_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].pm_inv);
 
-			cat_nthw_cfn_lc(be->p_cat_nthw, cat->v21.cfn[cat_func].lc);
-			cat_nthw_cfn_lc_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].lc_inv);
-			cat_nthw_cfn_km0_or(be->p_cat_nthw, cat->v21.cfn[cat_func].km0_or);
+			nthw_cat_cfn_lc(be->p_cat_nthw, cat->v21.cfn[cat_func].lc);
+			nthw_cat_cfn_lc_inv(be->p_cat_nthw, cat->v21.cfn[cat_func].lc_inv);
+			nthw_cat_cfn_km0_or(be->p_cat_nthw, cat->v21.cfn[cat_func].km0_or);
 
 			if (be->p_cat_nthw->m_km_if_cnt > 1)
-				cat_nthw_cfn_km1_or(be->p_cat_nthw, cat->v21.cfn[cat_func].km1_or);
+				nthw_cat_cfn_km1_or(be->p_cat_nthw, cat->v21.cfn[cat_func].km1_or);
 
-			cat_nthw_cfn_flush(be->p_cat_nthw);
+			nthw_cat_cfn_flush(be->p_cat_nthw);
 			cat_func++;
 		}
 	}
@@ -486,22 +486,22 @@ static int cat_kce_flush(void *be_dev, const struct cat_func_s *cat, int km_if_i
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18) {
-		cat_nthw_kce_cnt(be->p_cat_nthw, 0, 1U);
+		nthw_cat_kce_cnt(be->p_cat_nthw, 0, 1U);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_kce_select(be->p_cat_nthw, 0, index + i);
-			cat_nthw_kce_enable(be->p_cat_nthw, 0, cat->v18.kce[index + i].enable_bm);
-			cat_nthw_kce_flush(be->p_cat_nthw, 0);
+			nthw_cat_kce_select(be->p_cat_nthw, 0, index + i);
+			nthw_cat_kce_enable(be->p_cat_nthw, 0, cat->v18.kce[index + i].enable_bm);
+			nthw_cat_kce_flush(be->p_cat_nthw, 0);
 		}
 
 	} else if (cat->ver == 21) {
-		cat_nthw_kce_cnt(be->p_cat_nthw, km_if_idx, 1U);
+		nthw_cat_kce_cnt(be->p_cat_nthw, km_if_idx, 1U);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_kce_select(be->p_cat_nthw, km_if_idx, index + i);
-			cat_nthw_kce_enable(be->p_cat_nthw, km_if_idx,
+			nthw_cat_kce_select(be->p_cat_nthw, km_if_idx, index + i);
+			nthw_cat_kce_enable(be->p_cat_nthw, km_if_idx,
 				cat->v21.kce[index + i].enable_bm[km_if_idx]);
-			cat_nthw_kce_flush(be->p_cat_nthw, km_if_idx);
+			nthw_cat_kce_flush(be->p_cat_nthw, km_if_idx);
 		}
 	}
 
@@ -516,23 +516,23 @@ static int cat_kcs_flush(void *be_dev, const struct cat_func_s *cat, int km_if_i
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18) {
-		cat_nthw_kcs_cnt(be->p_cat_nthw, 0, 1U);
+		nthw_cat_kcs_cnt(be->p_cat_nthw, 0, 1U);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_kcs_select(be->p_cat_nthw, 0, cat_func);
-			cat_nthw_kcs_category(be->p_cat_nthw, 0, cat->v18.kcs[cat_func].category);
-			cat_nthw_kcs_flush(be->p_cat_nthw, 0);
+			nthw_cat_kcs_select(be->p_cat_nthw, 0, cat_func);
+			nthw_cat_kcs_category(be->p_cat_nthw, 0, cat->v18.kcs[cat_func].category);
+			nthw_cat_kcs_flush(be->p_cat_nthw, 0);
 			cat_func++;
 		}
 
 	} else if (cat->ver == 21) {
-		cat_nthw_kcs_cnt(be->p_cat_nthw, km_if_idx, 1U);
+		nthw_cat_kcs_cnt(be->p_cat_nthw, km_if_idx, 1U);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_kcs_select(be->p_cat_nthw, km_if_idx, cat_func);
-			cat_nthw_kcs_category(be->p_cat_nthw, km_if_idx,
+			nthw_cat_kcs_select(be->p_cat_nthw, km_if_idx, cat_func);
+			nthw_cat_kcs_category(be->p_cat_nthw, km_if_idx,
 				cat->v21.kcs[cat_func].category[km_if_idx]);
-			cat_nthw_kcs_flush(be->p_cat_nthw, km_if_idx);
+			nthw_cat_kcs_flush(be->p_cat_nthw, km_if_idx);
 			cat_func++;
 		}
 	}
@@ -548,22 +548,22 @@ static int cat_fte_flush(void *be_dev, const struct cat_func_s *cat, int km_if_i
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18) {
-		cat_nthw_fte_cnt(be->p_cat_nthw, 0, 1);
+		nthw_cat_fte_cnt(be->p_cat_nthw, 0, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_fte_select(be->p_cat_nthw, 0, index + i);
-			cat_nthw_fte_enable(be->p_cat_nthw, 0, cat->v18.fte[index + i].enable_bm);
-			cat_nthw_fte_flush(be->p_cat_nthw, 0);
+			nthw_cat_fte_select(be->p_cat_nthw, 0, index + i);
+			nthw_cat_fte_enable(be->p_cat_nthw, 0, cat->v18.fte[index + i].enable_bm);
+			nthw_cat_fte_flush(be->p_cat_nthw, 0);
 		}
 
 	} else if (cat->ver == 21) {
-		cat_nthw_fte_cnt(be->p_cat_nthw, km_if_idx, 1);
+		nthw_cat_fte_cnt(be->p_cat_nthw, km_if_idx, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_fte_select(be->p_cat_nthw, km_if_idx, index + i);
-			cat_nthw_fte_enable(be->p_cat_nthw, km_if_idx,
+			nthw_cat_fte_select(be->p_cat_nthw, km_if_idx, index + i);
+			nthw_cat_fte_enable(be->p_cat_nthw, km_if_idx,
 				cat->v21.fte[index + i].enable_bm[km_if_idx]);
-			cat_nthw_fte_flush(be->p_cat_nthw, km_if_idx);
+			nthw_cat_fte_flush(be->p_cat_nthw, km_if_idx);
 		}
 	}
 
@@ -577,23 +577,23 @@ static int cat_cte_flush(void *be_dev, const struct cat_func_s *cat, int cat_fun
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18 || cat->ver == 21) {
-		cat_nthw_cte_cnt(be->p_cat_nthw, 1);
+		nthw_cat_cte_cnt(be->p_cat_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_cte_select(be->p_cat_nthw, cat_func);
-			cat_nthw_cte_enable_col(be->p_cat_nthw, cat->v18.cte[cat_func].b.col);
-			cat_nthw_cte_enable_cor(be->p_cat_nthw, cat->v18.cte[cat_func].b.cor);
-			cat_nthw_cte_enable_hsh(be->p_cat_nthw, cat->v18.cte[cat_func].b.hsh);
-			cat_nthw_cte_enable_qsl(be->p_cat_nthw, cat->v18.cte[cat_func].b.qsl);
-			cat_nthw_cte_enable_ipf(be->p_cat_nthw, cat->v18.cte[cat_func].b.ipf);
-			cat_nthw_cte_enable_slc(be->p_cat_nthw, cat->v18.cte[cat_func].b.slc);
-			cat_nthw_cte_enable_pdb(be->p_cat_nthw, cat->v18.cte[cat_func].b.pdb);
-			cat_nthw_cte_enable_msk(be->p_cat_nthw, cat->v18.cte[cat_func].b.msk);
-			cat_nthw_cte_enable_hst(be->p_cat_nthw, cat->v18.cte[cat_func].b.hst);
-			cat_nthw_cte_enable_epp(be->p_cat_nthw, cat->v18.cte[cat_func].b.epp);
-			cat_nthw_cte_enable_tpe(be->p_cat_nthw, cat->v18.cte[cat_func].b.tpe);
-
-			cat_nthw_cte_flush(be->p_cat_nthw);
+			nthw_cat_cte_select(be->p_cat_nthw, cat_func);
+			nthw_cat_cte_enable_col(be->p_cat_nthw, cat->v18.cte[cat_func].b.col);
+			nthw_cat_cte_enable_cor(be->p_cat_nthw, cat->v18.cte[cat_func].b.cor);
+			nthw_cat_cte_enable_hsh(be->p_cat_nthw, cat->v18.cte[cat_func].b.hsh);
+			nthw_cat_cte_enable_qsl(be->p_cat_nthw, cat->v18.cte[cat_func].b.qsl);
+			nthw_cat_cte_enable_ipf(be->p_cat_nthw, cat->v18.cte[cat_func].b.ipf);
+			nthw_cat_cte_enable_slc(be->p_cat_nthw, cat->v18.cte[cat_func].b.slc);
+			nthw_cat_cte_enable_pdb(be->p_cat_nthw, cat->v18.cte[cat_func].b.pdb);
+			nthw_cat_cte_enable_msk(be->p_cat_nthw, cat->v18.cte[cat_func].b.msk);
+			nthw_cat_cte_enable_hst(be->p_cat_nthw, cat->v18.cte[cat_func].b.hst);
+			nthw_cat_cte_enable_epp(be->p_cat_nthw, cat->v18.cte[cat_func].b.epp);
+			nthw_cat_cte_enable_tpe(be->p_cat_nthw, cat->v18.cte[cat_func].b.tpe);
+
+			nthw_cat_cte_flush(be->p_cat_nthw);
 			cat_func++;
 		}
 	}
@@ -608,13 +608,13 @@ static int cat_cts_flush(void *be_dev, const struct cat_func_s *cat, int index,
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18 || cat->ver == 21) {
-		cat_nthw_cts_cnt(be->p_cat_nthw, 1);
+		nthw_cat_cts_cnt(be->p_cat_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_cts_select(be->p_cat_nthw, index + i);
-			cat_nthw_cts_cat_a(be->p_cat_nthw, cat->v18.cts[index + i].cat_a);
-			cat_nthw_cts_cat_b(be->p_cat_nthw, cat->v18.cts[index + i].cat_b);
-			cat_nthw_cts_flush(be->p_cat_nthw);
+			nthw_cat_cts_select(be->p_cat_nthw, index + i);
+			nthw_cat_cts_cat_a(be->p_cat_nthw, cat->v18.cts[index + i].cat_a);
+			nthw_cat_cts_cat_b(be->p_cat_nthw, cat->v18.cts[index + i].cat_b);
+			nthw_cat_cts_flush(be->p_cat_nthw);
 		}
 	}
 
@@ -628,13 +628,13 @@ static int cat_cot_flush(void *be_dev, const struct cat_func_s *cat, int cat_fun
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18 || cat->ver == 21) {
-		cat_nthw_cot_cnt(be->p_cat_nthw, 1);
+		nthw_cat_cot_cnt(be->p_cat_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_cot_select(be->p_cat_nthw, cat_func + i);
-			cat_nthw_cot_color(be->p_cat_nthw, cat->v18.cot[cat_func + i].color);
-			cat_nthw_cot_km(be->p_cat_nthw, cat->v18.cot[cat_func + i].km);
-			cat_nthw_cot_flush(be->p_cat_nthw);
+			nthw_cat_cot_select(be->p_cat_nthw, cat_func + i);
+			nthw_cat_cot_color(be->p_cat_nthw, cat->v18.cot[cat_func + i].color);
+			nthw_cat_cot_km(be->p_cat_nthw, cat->v18.cot[cat_func + i].km);
+			nthw_cat_cot_flush(be->p_cat_nthw);
 		}
 	}
 
@@ -648,13 +648,13 @@ static int cat_cct_flush(void *be_dev, const struct cat_func_s *cat, int index,
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18 || cat->ver == 21) {
-		cat_nthw_cct_cnt(be->p_cat_nthw, 1);
+		nthw_cat_cct_cnt(be->p_cat_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_cct_select(be->p_cat_nthw, index + i);
-			cat_nthw_cct_color(be->p_cat_nthw, cat->v18.cct[index + i].color);
-			cat_nthw_cct_km(be->p_cat_nthw, cat->v18.cct[index + i].km);
-			cat_nthw_cct_flush(be->p_cat_nthw);
+			nthw_cat_cct_select(be->p_cat_nthw, index + i);
+			nthw_cat_cct_color(be->p_cat_nthw, cat->v18.cct[index + i].color);
+			nthw_cat_cct_km(be->p_cat_nthw, cat->v18.cct[index + i].km);
+			nthw_cat_cct_flush(be->p_cat_nthw);
 		}
 	}
 
@@ -668,13 +668,13 @@ static int cat_exo_flush(void *be_dev, const struct cat_func_s *cat, int ext_ind
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18 || cat->ver == 21) {
-		cat_nthw_exo_cnt(be->p_cat_nthw, 1);
+		nthw_cat_exo_cnt(be->p_cat_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_exo_select(be->p_cat_nthw, ext_index + i);
-			cat_nthw_exo_dyn(be->p_cat_nthw, cat->v18.exo[ext_index + i].dyn);
-			cat_nthw_exo_ofs(be->p_cat_nthw, cat->v18.exo[ext_index + i].ofs);
-			cat_nthw_exo_flush(be->p_cat_nthw);
+			nthw_cat_exo_select(be->p_cat_nthw, ext_index + i);
+			nthw_cat_exo_dyn(be->p_cat_nthw, cat->v18.exo[ext_index + i].dyn);
+			nthw_cat_exo_ofs(be->p_cat_nthw, cat->v18.exo[ext_index + i].ofs);
+			nthw_cat_exo_flush(be->p_cat_nthw);
 		}
 	}
 
@@ -688,12 +688,12 @@ static int cat_rck_flush(void *be_dev, const struct cat_func_s *cat, int index,
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18 || cat->ver == 21) {
-		cat_nthw_rck_cnt(be->p_cat_nthw, 1);
+		nthw_cat_rck_cnt(be->p_cat_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_rck_select(be->p_cat_nthw, index + i);
-			cat_nthw_rck_data(be->p_cat_nthw, cat->v18.rck[index + i].rck_data);
-			cat_nthw_rck_flush(be->p_cat_nthw);
+			nthw_cat_rck_select(be->p_cat_nthw, index + i);
+			nthw_cat_rck_data(be->p_cat_nthw, cat->v18.rck[index + i].rck_data);
+			nthw_cat_rck_flush(be->p_cat_nthw);
 		}
 	}
 
@@ -707,16 +707,16 @@ static int cat_len_flush(void *be_dev, const struct cat_func_s *cat, int len_ind
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18 || cat->ver == 21) {
-		cat_nthw_len_cnt(be->p_cat_nthw, 1);
+		nthw_cat_len_cnt(be->p_cat_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_len_select(be->p_cat_nthw, len_index + i);
-			cat_nthw_len_lower(be->p_cat_nthw, cat->v18.len[len_index + i].lower);
-			cat_nthw_len_upper(be->p_cat_nthw, cat->v18.len[len_index + i].upper);
-			cat_nthw_len_dyn1(be->p_cat_nthw, cat->v18.len[len_index + i].dyn1);
-			cat_nthw_len_dyn2(be->p_cat_nthw, cat->v18.len[len_index + i].dyn2);
-			cat_nthw_len_inv(be->p_cat_nthw, cat->v18.len[len_index + i].inv);
-			cat_nthw_len_flush(be->p_cat_nthw);
+			nthw_cat_len_select(be->p_cat_nthw, len_index + i);
+			nthw_cat_len_lower(be->p_cat_nthw, cat->v18.len[len_index + i].lower);
+			nthw_cat_len_upper(be->p_cat_nthw, cat->v18.len[len_index + i].upper);
+			nthw_cat_len_dyn1(be->p_cat_nthw, cat->v18.len[len_index + i].dyn1);
+			nthw_cat_len_dyn2(be->p_cat_nthw, cat->v18.len[len_index + i].dyn2);
+			nthw_cat_len_inv(be->p_cat_nthw, cat->v18.len[len_index + i].inv);
+			nthw_cat_len_flush(be->p_cat_nthw);
 		}
 	}
 
@@ -730,15 +730,15 @@ static int cat_kcc_flush(void *be_dev, const struct cat_func_s *cat, int len_ind
 	CHECK_DEBUG_ON(be, cat, be->p_cat_nthw);
 
 	if (cat->ver == 18 || cat->ver == 21) {
-		cat_nthw_kcc_cnt(be->p_cat_nthw, 1);
+		nthw_cat_kcc_cnt(be->p_cat_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			cat_nthw_kcc_select(be->p_cat_nthw, len_index + i);
-			cat_nthw_kcc_key(be->p_cat_nthw, cat->v18.kcc_cam[len_index + i].key);
-			cat_nthw_kcc_category(be->p_cat_nthw,
+			nthw_cat_kcc_select(be->p_cat_nthw, len_index + i);
+			nthw_cat_kcc_key(be->p_cat_nthw, cat->v18.kcc_cam[len_index + i].key);
+			nthw_cat_kcc_category(be->p_cat_nthw,
 				cat->v18.kcc_cam[len_index + i].category);
-			cat_nthw_kcc_id(be->p_cat_nthw, cat->v18.kcc_cam[len_index + i].id);
-			cat_nthw_kcc_flush(be->p_cat_nthw);
+			nthw_cat_kcc_id(be->p_cat_nthw, cat->v18.kcc_cam[len_index + i].id);
+			nthw_cat_kcc_flush(be->p_cat_nthw);
 		}
 	}
 
@@ -770,56 +770,56 @@ static int km_rcp_flush(void *be_dev, const struct km_func_s *km, int category,
 	CHECK_DEBUG_ON(be, km, be->p_km_nthw);
 
 	if (km->ver == 7) {
-		km_nthw_rcp_cnt(be->p_km_nthw, 1);
+		nthw_km_rcp_cnt(be->p_km_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			km_nthw_rcp_select(be->p_km_nthw, category + i);
-			km_nthw_rcp_qw0_dyn(be->p_km_nthw, km->v7.rcp[category + i].qw0_dyn);
-			km_nthw_rcp_qw0_ofs(be->p_km_nthw, km->v7.rcp[category + i].qw0_ofs);
-			km_nthw_rcp_qw0_sel_a(be->p_km_nthw, km->v7.rcp[category + i].qw0_sel_a);
-			km_nthw_rcp_qw0_sel_b(be->p_km_nthw, km->v7.rcp[category + i].qw0_sel_b);
-			km_nthw_rcp_qw4_dyn(be->p_km_nthw, km->v7.rcp[category + i].qw4_dyn);
-			km_nthw_rcp_qw4_ofs(be->p_km_nthw, km->v7.rcp[category + i].qw4_ofs);
-			km_nthw_rcp_qw4_sel_a(be->p_km_nthw, km->v7.rcp[category + i].qw4_sel_a);
-			km_nthw_rcp_qw4_sel_b(be->p_km_nthw, km->v7.rcp[category + i].qw4_sel_b);
-			km_nthw_rcp_dw8_dyn(be->p_km_nthw, km->v7.rcp[category + i].dw8_dyn);
-			km_nthw_rcp_dw8_ofs(be->p_km_nthw, km->v7.rcp[category + i].dw8_ofs);
-			km_nthw_rcp_dw8_sel_a(be->p_km_nthw, km->v7.rcp[category + i].dw8_sel_a);
-			km_nthw_rcp_dw8_sel_b(be->p_km_nthw, km->v7.rcp[category + i].dw8_sel_b);
-			km_nthw_rcp_dw10_dyn(be->p_km_nthw, km->v7.rcp[category + i].dw10_dyn);
-			km_nthw_rcp_dw10_ofs(be->p_km_nthw, km->v7.rcp[category + i].dw10_ofs);
-			km_nthw_rcp_dw10_sel_a(be->p_km_nthw, km->v7.rcp[category + i].dw10_sel_a);
-			km_nthw_rcp_dw10_sel_b(be->p_km_nthw, km->v7.rcp[category + i].dw10_sel_b);
-			km_nthw_rcp_swx_cch(be->p_km_nthw, km->v7.rcp[category + i].swx_cch);
-			km_nthw_rcp_swx_sel_a(be->p_km_nthw, km->v7.rcp[category + i].swx_sel_a);
-			km_nthw_rcp_swx_sel_b(be->p_km_nthw, km->v7.rcp[category + i].swx_sel_b);
-			km_nthw_rcp_mask_da(be->p_km_nthw, km->v7.rcp[category + i].mask_d_a);
-			km_nthw_rcp_mask_b(be->p_km_nthw, km->v7.rcp[category + i].mask_b);
-			km_nthw_rcp_dual(be->p_km_nthw, km->v7.rcp[category + i].dual);
-			km_nthw_rcp_paired(be->p_km_nthw, km->v7.rcp[category + i].paired);
-			km_nthw_rcp_el_a(be->p_km_nthw, km->v7.rcp[category + i].el_a);
-			km_nthw_rcp_el_b(be->p_km_nthw, km->v7.rcp[category + i].el_b);
-			km_nthw_rcp_info_a(be->p_km_nthw, km->v7.rcp[category + i].info_a);
-			km_nthw_rcp_info_b(be->p_km_nthw, km->v7.rcp[category + i].info_b);
-			km_nthw_rcp_ftm_a(be->p_km_nthw, km->v7.rcp[category + i].ftm_a);
-			km_nthw_rcp_ftm_b(be->p_km_nthw, km->v7.rcp[category + i].ftm_b);
-			km_nthw_rcp_bank_a(be->p_km_nthw, km->v7.rcp[category + i].bank_a);
-			km_nthw_rcp_bank_b(be->p_km_nthw, km->v7.rcp[category + i].bank_b);
-			km_nthw_rcp_kl_a(be->p_km_nthw, km->v7.rcp[category + i].kl_a);
-			km_nthw_rcp_kl_b(be->p_km_nthw, km->v7.rcp[category + i].kl_b);
-			km_nthw_rcp_keyway_a(be->p_km_nthw, km->v7.rcp[category + i].keyway_a);
-			km_nthw_rcp_keyway_b(be->p_km_nthw, km->v7.rcp[category + i].keyway_b);
-			km_nthw_rcp_synergy_mode(be->p_km_nthw,
+			nthw_km_rcp_select(be->p_km_nthw, category + i);
+			nthw_km_rcp_qw0_dyn(be->p_km_nthw, km->v7.rcp[category + i].qw0_dyn);
+			nthw_km_rcp_qw0_ofs(be->p_km_nthw, km->v7.rcp[category + i].qw0_ofs);
+			nthw_km_rcp_qw0_sel_a(be->p_km_nthw, km->v7.rcp[category + i].qw0_sel_a);
+			nthw_km_rcp_qw0_sel_b(be->p_km_nthw, km->v7.rcp[category + i].qw0_sel_b);
+			nthw_km_rcp_qw4_dyn(be->p_km_nthw, km->v7.rcp[category + i].qw4_dyn);
+			nthw_km_rcp_qw4_ofs(be->p_km_nthw, km->v7.rcp[category + i].qw4_ofs);
+			nthw_km_rcp_qw4_sel_a(be->p_km_nthw, km->v7.rcp[category + i].qw4_sel_a);
+			nthw_km_rcp_qw4_sel_b(be->p_km_nthw, km->v7.rcp[category + i].qw4_sel_b);
+			nthw_km_rcp_dw8_dyn(be->p_km_nthw, km->v7.rcp[category + i].dw8_dyn);
+			nthw_km_rcp_dw8_ofs(be->p_km_nthw, km->v7.rcp[category + i].dw8_ofs);
+			nthw_km_rcp_dw8_sel_a(be->p_km_nthw, km->v7.rcp[category + i].dw8_sel_a);
+			nthw_km_rcp_dw8_sel_b(be->p_km_nthw, km->v7.rcp[category + i].dw8_sel_b);
+			nthw_km_rcp_dw10_dyn(be->p_km_nthw, km->v7.rcp[category + i].dw10_dyn);
+			nthw_km_rcp_dw10_ofs(be->p_km_nthw, km->v7.rcp[category + i].dw10_ofs);
+			nthw_km_rcp_dw10_sel_a(be->p_km_nthw, km->v7.rcp[category + i].dw10_sel_a);
+			nthw_km_rcp_dw10_sel_b(be->p_km_nthw, km->v7.rcp[category + i].dw10_sel_b);
+			nthw_km_rcp_swx_cch(be->p_km_nthw, km->v7.rcp[category + i].swx_cch);
+			nthw_km_rcp_swx_sel_a(be->p_km_nthw, km->v7.rcp[category + i].swx_sel_a);
+			nthw_km_rcp_swx_sel_b(be->p_km_nthw, km->v7.rcp[category + i].swx_sel_b);
+			nthw_km_rcp_mask_da(be->p_km_nthw, km->v7.rcp[category + i].mask_d_a);
+			nthw_km_rcp_mask_b(be->p_km_nthw, km->v7.rcp[category + i].mask_b);
+			nthw_km_rcp_dual(be->p_km_nthw, km->v7.rcp[category + i].dual);
+			nthw_km_rcp_paired(be->p_km_nthw, km->v7.rcp[category + i].paired);
+			nthw_km_rcp_el_a(be->p_km_nthw, km->v7.rcp[category + i].el_a);
+			nthw_km_rcp_el_b(be->p_km_nthw, km->v7.rcp[category + i].el_b);
+			nthw_km_rcp_info_a(be->p_km_nthw, km->v7.rcp[category + i].info_a);
+			nthw_km_rcp_info_b(be->p_km_nthw, km->v7.rcp[category + i].info_b);
+			nthw_km_rcp_ftm_a(be->p_km_nthw, km->v7.rcp[category + i].ftm_a);
+			nthw_km_rcp_ftm_b(be->p_km_nthw, km->v7.rcp[category + i].ftm_b);
+			nthw_km_rcp_bank_a(be->p_km_nthw, km->v7.rcp[category + i].bank_a);
+			nthw_km_rcp_bank_b(be->p_km_nthw, km->v7.rcp[category + i].bank_b);
+			nthw_km_rcp_kl_a(be->p_km_nthw, km->v7.rcp[category + i].kl_a);
+			nthw_km_rcp_kl_b(be->p_km_nthw, km->v7.rcp[category + i].kl_b);
+			nthw_km_rcp_keyway_a(be->p_km_nthw, km->v7.rcp[category + i].keyway_a);
+			nthw_km_rcp_keyway_b(be->p_km_nthw, km->v7.rcp[category + i].keyway_b);
+			nthw_km_rcp_synergy_mode(be->p_km_nthw,
 				km->v7.rcp[category + i].synergy_mode);
-			km_nthw_rcp_dw0_b_dyn(be->p_km_nthw, km->v7.rcp[category + i].dw0_b_dyn);
-			km_nthw_rcp_dw0_b_ofs(be->p_km_nthw, km->v7.rcp[category + i].dw0_b_ofs);
-			km_nthw_rcp_dw2_b_dyn(be->p_km_nthw, km->v7.rcp[category + i].dw2_b_dyn);
-			km_nthw_rcp_dw2_b_ofs(be->p_km_nthw, km->v7.rcp[category + i].dw2_b_ofs);
-			km_nthw_rcp_sw4_b_dyn(be->p_km_nthw, km->v7.rcp[category + i].sw4_b_dyn);
-			km_nthw_rcp_sw4_b_ofs(be->p_km_nthw, km->v7.rcp[category + i].sw4_b_ofs);
-			km_nthw_rcp_sw5_b_dyn(be->p_km_nthw, km->v7.rcp[category + i].sw5_b_dyn);
-			km_nthw_rcp_sw5_b_ofs(be->p_km_nthw, km->v7.rcp[category + i].sw5_b_ofs);
-			km_nthw_rcp_flush(be->p_km_nthw);
+			nthw_km_rcp_dw0_b_dyn(be->p_km_nthw, km->v7.rcp[category + i].dw0_b_dyn);
+			nthw_km_rcp_dw0_b_ofs(be->p_km_nthw, km->v7.rcp[category + i].dw0_b_ofs);
+			nthw_km_rcp_dw2_b_dyn(be->p_km_nthw, km->v7.rcp[category + i].dw2_b_dyn);
+			nthw_km_rcp_dw2_b_ofs(be->p_km_nthw, km->v7.rcp[category + i].dw2_b_ofs);
+			nthw_km_rcp_sw4_b_dyn(be->p_km_nthw, km->v7.rcp[category + i].sw4_b_dyn);
+			nthw_km_rcp_sw4_b_ofs(be->p_km_nthw, km->v7.rcp[category + i].sw4_b_ofs);
+			nthw_km_rcp_sw5_b_dyn(be->p_km_nthw, km->v7.rcp[category + i].sw5_b_dyn);
+			nthw_km_rcp_sw5_b_ofs(be->p_km_nthw, km->v7.rcp[category + i].sw5_b_ofs);
+			nthw_km_rcp_flush(be->p_km_nthw);
 		}
 	}
 
@@ -833,23 +833,23 @@ static int km_cam_flush(void *be_dev, const struct km_func_s *km, int bank, int
 	CHECK_DEBUG_ON(be, km, be->p_km_nthw);
 
 	if (km->ver == 7) {
-		km_nthw_cam_cnt(be->p_km_nthw, 1);
+		nthw_km_cam_cnt(be->p_km_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			km_nthw_cam_select(be->p_km_nthw, (bank << 11) + record + i);
-			km_nthw_cam_w0(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w0);
-			km_nthw_cam_w1(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w1);
-			km_nthw_cam_w2(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w2);
-			km_nthw_cam_w3(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w3);
-			km_nthw_cam_w4(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w4);
-			km_nthw_cam_w5(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w5);
-			km_nthw_cam_ft0(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft0);
-			km_nthw_cam_ft1(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft1);
-			km_nthw_cam_ft2(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft2);
-			km_nthw_cam_ft3(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft3);
-			km_nthw_cam_ft4(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft4);
-			km_nthw_cam_ft5(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft5);
-			km_nthw_cam_flush(be->p_km_nthw);
+			nthw_km_cam_select(be->p_km_nthw, (bank << 11) + record + i);
+			nthw_km_cam_w0(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w0);
+			nthw_km_cam_w1(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w1);
+			nthw_km_cam_w2(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w2);
+			nthw_km_cam_w3(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w3);
+			nthw_km_cam_w4(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w4);
+			nthw_km_cam_w5(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].w5);
+			nthw_km_cam_ft0(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft0);
+			nthw_km_cam_ft1(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft1);
+			nthw_km_cam_ft2(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft2);
+			nthw_km_cam_ft3(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft3);
+			nthw_km_cam_ft4(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft4);
+			nthw_km_cam_ft5(be->p_km_nthw, km->v7.cam[(bank << 11) + record + i].ft5);
+			nthw_km_cam_flush(be->p_km_nthw);
 		}
 	}
 
@@ -865,13 +865,13 @@ static int km_tcam_flush(void *be_dev, const struct km_func_s *km, int bank, int
 
 	if (km->ver == 7) {
 		int start_idx = bank * 4 * 256 + byte * 256 + value;
-		km_nthw_tcam_cnt(be->p_km_nthw, 1);
+		nthw_km_tcam_cnt(be->p_km_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
 			if (km->v7.tcam[start_idx + i].dirty) {
-				km_nthw_tcam_select(be->p_km_nthw, start_idx + i);
-				km_nthw_tcam_t(be->p_km_nthw, km->v7.tcam[start_idx + i].t);
-				km_nthw_tcam_flush(be->p_km_nthw);
+				nthw_km_tcam_select(be->p_km_nthw, start_idx + i);
+				nthw_km_tcam_t(be->p_km_nthw, km->v7.tcam[start_idx + i].t);
+				nthw_km_tcam_flush(be->p_km_nthw);
 				km->v7.tcam[start_idx + i].dirty = 0;
 			}
 		}
@@ -891,13 +891,13 @@ static int km_tci_flush(void *be_dev, const struct km_func_s *km, int bank, int
 
 	if (km->ver == 7) {
 		/* TCAM bank width in version 3 = 72 */
-		km_nthw_tci_cnt(be->p_km_nthw, 1);
+		nthw_km_tci_cnt(be->p_km_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			km_nthw_tci_select(be->p_km_nthw, bank * 72 + index + i);
-			km_nthw_tci_color(be->p_km_nthw, km->v7.tci[bank * 72 + index + i].color);
-			km_nthw_tci_ft(be->p_km_nthw, km->v7.tci[bank * 72 + index + i].ft);
-			km_nthw_tci_flush(be->p_km_nthw);
+			nthw_km_tci_select(be->p_km_nthw, bank * 72 + index + i);
+			nthw_km_tci_color(be->p_km_nthw, km->v7.tci[bank * 72 + index + i].color);
+			nthw_km_tci_ft(be->p_km_nthw, km->v7.tci[bank * 72 + index + i].ft);
+			nthw_km_tci_flush(be->p_km_nthw);
 		}
 	}
 
@@ -915,15 +915,15 @@ static int km_tcq_flush(void *be_dev, const struct km_func_s *km, int bank, int
 
 	if (km->ver == 7) {
 		/* TCAM bank width in version 3 = 72 */
-		km_nthw_tcq_cnt(be->p_km_nthw, 1);
+		nthw_km_tcq_cnt(be->p_km_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
 			/* adr = lover 4 bits = bank, upper 7 bits = index */
-			km_nthw_tcq_select(be->p_km_nthw, bank + (index << 4) + i);
-			km_nthw_tcq_bank_mask(be->p_km_nthw,
+			nthw_km_tcq_select(be->p_km_nthw, bank + (index << 4) + i);
+			nthw_km_tcq_bank_mask(be->p_km_nthw,
 				km->v7.tcq[bank + (index << 4) + i].bank_mask);
-			km_nthw_tcq_qual(be->p_km_nthw, km->v7.tcq[bank + (index << 4) + i].qual);
-			km_nthw_tcq_flush(be->p_km_nthw);
+			nthw_km_tcq_qual(be->p_km_nthw, km->v7.tcq[bank + (index << 4) + i].qual);
+			nthw_km_tcq_flush(be->p_km_nthw);
 		}
 	}
 
@@ -954,24 +954,24 @@ static int flm_control_flush(void *be_dev, const struct flm_func_s *flm)
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_control_enable(be->p_flm_nthw, flm->v25.control->enable);
-		flm_nthw_control_init(be->p_flm_nthw, flm->v25.control->init);
-		flm_nthw_control_lds(be->p_flm_nthw, flm->v25.control->lds);
-		flm_nthw_control_lfs(be->p_flm_nthw, flm->v25.control->lfs);
-		flm_nthw_control_lis(be->p_flm_nthw, flm->v25.control->lis);
-		flm_nthw_control_uds(be->p_flm_nthw, flm->v25.control->uds);
-		flm_nthw_control_uis(be->p_flm_nthw, flm->v25.control->uis);
-		flm_nthw_control_rds(be->p_flm_nthw, flm->v25.control->rds);
-		flm_nthw_control_ris(be->p_flm_nthw, flm->v25.control->ris);
-		flm_nthw_control_pds(be->p_flm_nthw, flm->v25.control->pds);
-		flm_nthw_control_pis(be->p_flm_nthw, flm->v25.control->pis);
-		flm_nthw_control_crcwr(be->p_flm_nthw, flm->v25.control->crcwr);
-		flm_nthw_control_crcrd(be->p_flm_nthw, flm->v25.control->crcrd);
-		flm_nthw_control_rbl(be->p_flm_nthw, flm->v25.control->rbl);
-		flm_nthw_control_eab(be->p_flm_nthw, flm->v25.control->eab);
-		flm_nthw_control_split_sdram_usage(be->p_flm_nthw,
+		nthw_flm_control_enable(be->p_flm_nthw, flm->v25.control->enable);
+		nthw_flm_control_init(be->p_flm_nthw, flm->v25.control->init);
+		nthw_flm_control_lds(be->p_flm_nthw, flm->v25.control->lds);
+		nthw_flm_control_lfs(be->p_flm_nthw, flm->v25.control->lfs);
+		nthw_flm_control_lis(be->p_flm_nthw, flm->v25.control->lis);
+		nthw_flm_control_uds(be->p_flm_nthw, flm->v25.control->uds);
+		nthw_flm_control_uis(be->p_flm_nthw, flm->v25.control->uis);
+		nthw_flm_control_rds(be->p_flm_nthw, flm->v25.control->rds);
+		nthw_flm_control_ris(be->p_flm_nthw, flm->v25.control->ris);
+		nthw_flm_control_pds(be->p_flm_nthw, flm->v25.control->pds);
+		nthw_flm_control_pis(be->p_flm_nthw, flm->v25.control->pis);
+		nthw_flm_control_crcwr(be->p_flm_nthw, flm->v25.control->crcwr);
+		nthw_flm_control_crcrd(be->p_flm_nthw, flm->v25.control->crcrd);
+		nthw_flm_control_rbl(be->p_flm_nthw, flm->v25.control->rbl);
+		nthw_flm_control_eab(be->p_flm_nthw, flm->v25.control->eab);
+		nthw_flm_control_split_sdram_usage(be->p_flm_nthw,
 			flm->v25.control->split_sdram_usage);
-		flm_nthw_control_flush(be->p_flm_nthw);
+		nthw_flm_control_flush(be->p_flm_nthw);
 	}
 
 	CHECK_DEBUG_OFF(flm, be->p_flm_nthw);
@@ -985,12 +985,12 @@ static int flm_status_flush(void *be_dev, const struct flm_func_s *flm)
 
 	if (flm->ver >= 25) {
 		/* CALIBDONE, INITDONE, IDLE, and EFT_BP is read only */
-		flm_nthw_status_critical(be->p_flm_nthw, &flm->v25.status->critical, 0);
-		flm_nthw_status_panic(be->p_flm_nthw, &flm->v25.status->panic, 0);
-		flm_nthw_status_crcerr(be->p_flm_nthw, &flm->v25.status->crcerr, 0);
-		flm_nthw_status_cache_buf_crit(be->p_flm_nthw,
+		nthw_flm_status_critical(be->p_flm_nthw, &flm->v25.status->critical, 0);
+		nthw_flm_status_panic(be->p_flm_nthw, &flm->v25.status->panic, 0);
+		nthw_flm_status_crcerr(be->p_flm_nthw, &flm->v25.status->crcerr, 0);
+		nthw_flm_status_cache_buf_crit(be->p_flm_nthw,
 			&flm->v25.status->cache_buf_critical, 0);
-		flm_nthw_status_flush(be->p_flm_nthw);
+		nthw_flm_status_flush(be->p_flm_nthw);
 	}
 
 	CHECK_DEBUG_OFF(flm, be->p_flm_nthw);
@@ -1003,16 +1003,16 @@ static int flm_status_update(void *be_dev, const struct flm_func_s *flm)
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_status_update(be->p_flm_nthw);
-		flm_nthw_status_calib_success(be->p_flm_nthw, &flm->v25.status->calib_success, 1);
-		flm_nthw_status_calib_fail(be->p_flm_nthw, &flm->v25.status->calib_fail, 1);
-		flm_nthw_status_initdone(be->p_flm_nthw, &flm->v25.status->initdone, 1);
-		flm_nthw_status_idle(be->p_flm_nthw, &flm->v25.status->idle, 1);
-		flm_nthw_status_critical(be->p_flm_nthw, &flm->v25.status->critical, 1);
-		flm_nthw_status_panic(be->p_flm_nthw, &flm->v25.status->panic, 1);
-		flm_nthw_status_crcerr(be->p_flm_nthw, &flm->v25.status->crcerr, 1);
-		flm_nthw_status_eft_bp(be->p_flm_nthw, &flm->v25.status->eft_bp, 1);
-		flm_nthw_status_cache_buf_crit(be->p_flm_nthw,
+		nthw_flm_status_update(be->p_flm_nthw);
+		nthw_flm_status_calib_success(be->p_flm_nthw, &flm->v25.status->calib_success, 1);
+		nthw_flm_status_calib_fail(be->p_flm_nthw, &flm->v25.status->calib_fail, 1);
+		nthw_flm_status_initdone(be->p_flm_nthw, &flm->v25.status->initdone, 1);
+		nthw_flm_status_idle(be->p_flm_nthw, &flm->v25.status->idle, 1);
+		nthw_flm_status_critical(be->p_flm_nthw, &flm->v25.status->critical, 1);
+		nthw_flm_status_panic(be->p_flm_nthw, &flm->v25.status->panic, 1);
+		nthw_flm_status_crcerr(be->p_flm_nthw, &flm->v25.status->crcerr, 1);
+		nthw_flm_status_eft_bp(be->p_flm_nthw, &flm->v25.status->eft_bp, 1);
+		nthw_flm_status_cache_buf_crit(be->p_flm_nthw,
 			&flm->v25.status->cache_buf_critical, 1);
 	}
 
@@ -1026,8 +1026,8 @@ static int flm_scan_flush(void *be_dev, const struct flm_func_s *flm)
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_scan_i(be->p_flm_nthw, flm->v25.scan->i);
-		flm_nthw_scan_flush(be->p_flm_nthw);
+		nthw_flm_scan_i(be->p_flm_nthw, flm->v25.scan->i);
+		nthw_flm_scan_flush(be->p_flm_nthw);
 	}
 
 	CHECK_DEBUG_OFF(flm, be->p_flm_nthw);
@@ -1040,8 +1040,8 @@ static int flm_load_bin_flush(void *be_dev, const struct flm_func_s *flm)
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_load_bin(be->p_flm_nthw, flm->v25.load_bin->bin);
-		flm_nthw_load_bin_flush(be->p_flm_nthw);
+		nthw_flm_load_bin(be->p_flm_nthw, flm->v25.load_bin->bin);
+		nthw_flm_load_bin_flush(be->p_flm_nthw);
 	}
 
 	CHECK_DEBUG_OFF(flm, be->p_flm_nthw);
@@ -1054,15 +1054,15 @@ static int flm_prio_flush(void *be_dev, const struct flm_func_s *flm)
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_prio_limit0(be->p_flm_nthw, flm->v25.prio->limit0);
-		flm_nthw_prio_ft0(be->p_flm_nthw, flm->v25.prio->ft0);
-		flm_nthw_prio_limit1(be->p_flm_nthw, flm->v25.prio->limit1);
-		flm_nthw_prio_ft1(be->p_flm_nthw, flm->v25.prio->ft1);
-		flm_nthw_prio_limit2(be->p_flm_nthw, flm->v25.prio->limit2);
-		flm_nthw_prio_ft2(be->p_flm_nthw, flm->v25.prio->ft2);
-		flm_nthw_prio_limit3(be->p_flm_nthw, flm->v25.prio->limit3);
-		flm_nthw_prio_ft3(be->p_flm_nthw, flm->v25.prio->ft3);
-		flm_nthw_prio_flush(be->p_flm_nthw);
+		nthw_flm_prio_limit0(be->p_flm_nthw, flm->v25.prio->limit0);
+		nthw_flm_prio_ft0(be->p_flm_nthw, flm->v25.prio->ft0);
+		nthw_flm_prio_limit1(be->p_flm_nthw, flm->v25.prio->limit1);
+		nthw_flm_prio_ft1(be->p_flm_nthw, flm->v25.prio->ft1);
+		nthw_flm_prio_limit2(be->p_flm_nthw, flm->v25.prio->limit2);
+		nthw_flm_prio_ft2(be->p_flm_nthw, flm->v25.prio->ft2);
+		nthw_flm_prio_limit3(be->p_flm_nthw, flm->v25.prio->limit3);
+		nthw_flm_prio_ft3(be->p_flm_nthw, flm->v25.prio->ft3);
+		nthw_flm_prio_flush(be->p_flm_nthw);
 	}
 
 	CHECK_DEBUG_OFF(flm, be->p_flm_nthw);
@@ -1075,14 +1075,14 @@ static int flm_pst_flush(void *be_dev, const struct flm_func_s *flm, int index,
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_pst_cnt(be->p_flm_nthw, 1);
+		nthw_flm_pst_cnt(be->p_flm_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			flm_nthw_pst_select(be->p_flm_nthw, index + i);
-			flm_nthw_pst_bp(be->p_flm_nthw, flm->v25.pst[index + i].bp);
-			flm_nthw_pst_pp(be->p_flm_nthw, flm->v25.pst[index + i].pp);
-			flm_nthw_pst_tp(be->p_flm_nthw, flm->v25.pst[index + i].tp);
-			flm_nthw_pst_flush(be->p_flm_nthw);
+			nthw_flm_pst_select(be->p_flm_nthw, index + i);
+			nthw_flm_pst_bp(be->p_flm_nthw, flm->v25.pst[index + i].bp);
+			nthw_flm_pst_pp(be->p_flm_nthw, flm->v25.pst[index + i].pp);
+			nthw_flm_pst_tp(be->p_flm_nthw, flm->v25.pst[index + i].tp);
+			nthw_flm_pst_flush(be->p_flm_nthw);
 		}
 	}
 
@@ -1096,31 +1096,31 @@ static int flm_rcp_flush(void *be_dev, const struct flm_func_s *flm, int index,
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_rcp_cnt(be->p_flm_nthw, 1);
+		nthw_flm_rcp_cnt(be->p_flm_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			flm_nthw_rcp_select(be->p_flm_nthw, index + i);
-			flm_nthw_rcp_lookup(be->p_flm_nthw, flm->v25.rcp[index + i].lookup);
-			flm_nthw_rcp_qw0_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].qw0_dyn);
-			flm_nthw_rcp_qw0_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].qw0_ofs);
-			flm_nthw_rcp_qw0_sel(be->p_flm_nthw, flm->v25.rcp[index + i].qw0_sel);
-			flm_nthw_rcp_qw4_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].qw4_dyn);
-			flm_nthw_rcp_qw4_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].qw4_ofs);
-			flm_nthw_rcp_sw8_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].sw8_dyn);
-			flm_nthw_rcp_sw8_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].sw8_ofs);
-			flm_nthw_rcp_sw8_sel(be->p_flm_nthw, flm->v25.rcp[index + i].sw8_sel);
-			flm_nthw_rcp_sw9_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].sw9_dyn);
-			flm_nthw_rcp_sw9_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].sw9_ofs);
-			flm_nthw_rcp_mask(be->p_flm_nthw, flm->v25.rcp[index + i].mask);
-			flm_nthw_rcp_kid(be->p_flm_nthw, flm->v25.rcp[index + i].kid);
-			flm_nthw_rcp_opn(be->p_flm_nthw, flm->v25.rcp[index + i].opn);
-			flm_nthw_rcp_ipn(be->p_flm_nthw, flm->v25.rcp[index + i].ipn);
-			flm_nthw_rcp_byt_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].byt_dyn);
-			flm_nthw_rcp_byt_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].byt_ofs);
-			flm_nthw_rcp_txplm(be->p_flm_nthw, flm->v25.rcp[index + i].txplm);
-			flm_nthw_rcp_auto_ipv4_mask(be->p_flm_nthw,
+			nthw_flm_rcp_select(be->p_flm_nthw, index + i);
+			nthw_flm_rcp_lookup(be->p_flm_nthw, flm->v25.rcp[index + i].lookup);
+			nthw_flm_rcp_qw0_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].qw0_dyn);
+			nthw_flm_rcp_qw0_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].qw0_ofs);
+			nthw_flm_rcp_qw0_sel(be->p_flm_nthw, flm->v25.rcp[index + i].qw0_sel);
+			nthw_flm_rcp_qw4_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].qw4_dyn);
+			nthw_flm_rcp_qw4_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].qw4_ofs);
+			nthw_flm_rcp_sw8_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].sw8_dyn);
+			nthw_flm_rcp_sw8_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].sw8_ofs);
+			nthw_flm_rcp_sw8_sel(be->p_flm_nthw, flm->v25.rcp[index + i].sw8_sel);
+			nthw_flm_rcp_sw9_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].sw9_dyn);
+			nthw_flm_rcp_sw9_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].sw9_ofs);
+			nthw_flm_rcp_mask(be->p_flm_nthw, flm->v25.rcp[index + i].mask);
+			nthw_flm_rcp_kid(be->p_flm_nthw, flm->v25.rcp[index + i].kid);
+			nthw_flm_rcp_opn(be->p_flm_nthw, flm->v25.rcp[index + i].opn);
+			nthw_flm_rcp_ipn(be->p_flm_nthw, flm->v25.rcp[index + i].ipn);
+			nthw_flm_rcp_byt_dyn(be->p_flm_nthw, flm->v25.rcp[index + i].byt_dyn);
+			nthw_flm_rcp_byt_ofs(be->p_flm_nthw, flm->v25.rcp[index + i].byt_ofs);
+			nthw_flm_rcp_txplm(be->p_flm_nthw, flm->v25.rcp[index + i].txplm);
+			nthw_flm_rcp_auto_ipv4_mask(be->p_flm_nthw,
 				flm->v25.rcp[index + i].auto_ipv4_mask);
-			flm_nthw_rcp_flush(be->p_flm_nthw);
+			nthw_flm_rcp_flush(be->p_flm_nthw);
 		}
 	}
 
@@ -1134,15 +1134,15 @@ static int flm_scrub_flush(void *be_dev, const struct flm_func_s *flm, int index
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_scrub_cnt(be->p_flm_nthw, 1);
+		nthw_flm_scrub_cnt(be->p_flm_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			flm_nthw_scrub_select(be->p_flm_nthw, index + i);
-			flm_nthw_scrub_t(be->p_flm_nthw, flm->v25.scrub[index + i].t);
-			flm_nthw_scrub_r(be->p_flm_nthw, flm->v25.scrub[index + i].r);
-			flm_nthw_scrub_del(be->p_flm_nthw, flm->v25.scrub[index + i].del);
-			flm_nthw_scrub_inf(be->p_flm_nthw, flm->v25.scrub[index + i].inf);
-			flm_nthw_scrub_flush(be->p_flm_nthw);
+			nthw_flm_scrub_select(be->p_flm_nthw, index + i);
+			nthw_flm_scrub_t(be->p_flm_nthw, flm->v25.scrub[index + i].t);
+			nthw_flm_scrub_r(be->p_flm_nthw, flm->v25.scrub[index + i].r);
+			nthw_flm_scrub_del(be->p_flm_nthw, flm->v25.scrub[index + i].del);
+			nthw_flm_scrub_inf(be->p_flm_nthw, flm->v25.scrub[index + i].inf);
+			nthw_flm_scrub_flush(be->p_flm_nthw);
 		}
 	}
 
@@ -1156,7 +1156,7 @@ static int flm_buf_ctrl_update(void *be_dev, const struct flm_func_s *flm)
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_buf_ctrl_update(be->p_flm_nthw,
+		nthw_flm_buf_ctrl_update(be->p_flm_nthw,
 			&flm->v25.buf_ctrl->lrn_free,
 			&flm->v25.buf_ctrl->inf_avail,
 			&flm->v25.buf_ctrl->sta_avail);
@@ -1172,69 +1172,69 @@ static int flm_stat_update(void *be_dev, const struct flm_func_s *flm)
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
 	if (flm->ver >= 25) {
-		flm_nthw_stat_lrn_done_update(be->p_flm_nthw);
-		flm_nthw_stat_lrn_ignore_update(be->p_flm_nthw);
-		flm_nthw_stat_lrn_fail_update(be->p_flm_nthw);
-		flm_nthw_stat_unl_done_update(be->p_flm_nthw);
-		flm_nthw_stat_unl_ignore_update(be->p_flm_nthw);
-		flm_nthw_stat_rel_done_update(be->p_flm_nthw);
-		flm_nthw_stat_rel_ignore_update(be->p_flm_nthw);
-		flm_nthw_stat_aul_done_update(be->p_flm_nthw);
-		flm_nthw_stat_aul_ignore_update(be->p_flm_nthw);
-		flm_nthw_stat_aul_fail_update(be->p_flm_nthw);
-		flm_nthw_stat_tul_done_update(be->p_flm_nthw);
-		flm_nthw_stat_flows_update(be->p_flm_nthw);
-		flm_nthw_load_lps_update(be->p_flm_nthw);
-		flm_nthw_load_aps_update(be->p_flm_nthw);
-
-		flm_nthw_stat_lrn_done_cnt(be->p_flm_nthw, &flm->v25.lrn_done->cnt, 1);
-		flm_nthw_stat_lrn_ignore_cnt(be->p_flm_nthw, &flm->v25.lrn_ignore->cnt, 1);
-		flm_nthw_stat_lrn_fail_cnt(be->p_flm_nthw, &flm->v25.lrn_fail->cnt, 1);
-		flm_nthw_stat_unl_done_cnt(be->p_flm_nthw, &flm->v25.unl_done->cnt, 1);
-		flm_nthw_stat_unl_ignore_cnt(be->p_flm_nthw, &flm->v25.unl_ignore->cnt, 1);
-		flm_nthw_stat_rel_done_cnt(be->p_flm_nthw, &flm->v25.rel_done->cnt, 1);
-		flm_nthw_stat_rel_ignore_cnt(be->p_flm_nthw, &flm->v25.rel_ignore->cnt, 1);
-		flm_nthw_stat_aul_done_cnt(be->p_flm_nthw, &flm->v25.aul_done->cnt, 1);
-		flm_nthw_stat_aul_ignore_cnt(be->p_flm_nthw, &flm->v25.aul_ignore->cnt, 1);
-		flm_nthw_stat_aul_fail_cnt(be->p_flm_nthw, &flm->v25.aul_fail->cnt, 1);
-		flm_nthw_stat_tul_done_cnt(be->p_flm_nthw, &flm->v25.tul_done->cnt, 1);
-		flm_nthw_stat_flows_cnt(be->p_flm_nthw, &flm->v25.flows->cnt, 1);
-
-		flm_nthw_stat_prb_done_update(be->p_flm_nthw);
-		flm_nthw_stat_prb_ignore_update(be->p_flm_nthw);
-		flm_nthw_stat_prb_done_cnt(be->p_flm_nthw, &flm->v25.prb_done->cnt, 1);
-		flm_nthw_stat_prb_ignore_cnt(be->p_flm_nthw, &flm->v25.prb_ignore->cnt, 1);
-
-		flm_nthw_load_lps_cnt(be->p_flm_nthw, &flm->v25.load_lps->lps, 1);
-		flm_nthw_load_aps_cnt(be->p_flm_nthw, &flm->v25.load_aps->aps, 1);
+		nthw_flm_stat_lrn_done_update(be->p_flm_nthw);
+		nthw_flm_stat_lrn_ignore_update(be->p_flm_nthw);
+		nthw_flm_stat_lrn_fail_update(be->p_flm_nthw);
+		nthw_flm_stat_unl_done_update(be->p_flm_nthw);
+		nthw_flm_stat_unl_ignore_update(be->p_flm_nthw);
+		nthw_flm_stat_rel_done_update(be->p_flm_nthw);
+		nthw_flm_stat_rel_ignore_update(be->p_flm_nthw);
+		nthw_flm_stat_aul_done_update(be->p_flm_nthw);
+		nthw_flm_stat_aul_ignore_update(be->p_flm_nthw);
+		nthw_flm_stat_aul_fail_update(be->p_flm_nthw);
+		nthw_flm_stat_tul_done_update(be->p_flm_nthw);
+		nthw_flm_stat_flows_update(be->p_flm_nthw);
+		nthw_flm_load_lps_update(be->p_flm_nthw);
+		nthw_flm_load_aps_update(be->p_flm_nthw);
+
+		nthw_flm_stat_lrn_done_cnt(be->p_flm_nthw, &flm->v25.lrn_done->cnt, 1);
+		nthw_flm_stat_lrn_ignore_cnt(be->p_flm_nthw, &flm->v25.lrn_ignore->cnt, 1);
+		nthw_flm_stat_lrn_fail_cnt(be->p_flm_nthw, &flm->v25.lrn_fail->cnt, 1);
+		nthw_flm_stat_unl_done_cnt(be->p_flm_nthw, &flm->v25.unl_done->cnt, 1);
+		nthw_flm_stat_unl_ignore_cnt(be->p_flm_nthw, &flm->v25.unl_ignore->cnt, 1);
+		nthw_flm_stat_rel_done_cnt(be->p_flm_nthw, &flm->v25.rel_done->cnt, 1);
+		nthw_flm_stat_rel_ignore_cnt(be->p_flm_nthw, &flm->v25.rel_ignore->cnt, 1);
+		nthw_flm_stat_aul_done_cnt(be->p_flm_nthw, &flm->v25.aul_done->cnt, 1);
+		nthw_flm_stat_aul_ignore_cnt(be->p_flm_nthw, &flm->v25.aul_ignore->cnt, 1);
+		nthw_flm_stat_aul_fail_cnt(be->p_flm_nthw, &flm->v25.aul_fail->cnt, 1);
+		nthw_flm_stat_tul_done_cnt(be->p_flm_nthw, &flm->v25.tul_done->cnt, 1);
+		nthw_flm_stat_flows_cnt(be->p_flm_nthw, &flm->v25.flows->cnt, 1);
+
+		nthw_flm_stat_prb_done_update(be->p_flm_nthw);
+		nthw_flm_stat_prb_ignore_update(be->p_flm_nthw);
+		nthw_flm_stat_prb_done_cnt(be->p_flm_nthw, &flm->v25.prb_done->cnt, 1);
+		nthw_flm_stat_prb_ignore_cnt(be->p_flm_nthw, &flm->v25.prb_ignore->cnt, 1);
+
+		nthw_flm_load_lps_cnt(be->p_flm_nthw, &flm->v25.load_lps->lps, 1);
+		nthw_flm_load_aps_cnt(be->p_flm_nthw, &flm->v25.load_aps->aps, 1);
 	}
 
 	if (flm->ver >= 25) {
-		flm_nthw_stat_sta_done_update(be->p_flm_nthw);
-		flm_nthw_stat_inf_done_update(be->p_flm_nthw);
-		flm_nthw_stat_inf_skip_update(be->p_flm_nthw);
-		flm_nthw_stat_pck_hit_update(be->p_flm_nthw);
-		flm_nthw_stat_pck_miss_update(be->p_flm_nthw);
-		flm_nthw_stat_pck_unh_update(be->p_flm_nthw);
-		flm_nthw_stat_pck_dis_update(be->p_flm_nthw);
-		flm_nthw_stat_csh_hit_update(be->p_flm_nthw);
-		flm_nthw_stat_csh_miss_update(be->p_flm_nthw);
-		flm_nthw_stat_csh_unh_update(be->p_flm_nthw);
-		flm_nthw_stat_cuc_start_update(be->p_flm_nthw);
-		flm_nthw_stat_cuc_move_update(be->p_flm_nthw);
-
-		flm_nthw_stat_sta_done_cnt(be->p_flm_nthw, &flm->v25.sta_done->cnt, 1);
-		flm_nthw_stat_inf_done_cnt(be->p_flm_nthw, &flm->v25.inf_done->cnt, 1);
-		flm_nthw_stat_inf_skip_cnt(be->p_flm_nthw, &flm->v25.inf_skip->cnt, 1);
-		flm_nthw_stat_pck_hit_cnt(be->p_flm_nthw, &flm->v25.pck_hit->cnt, 1);
-		flm_nthw_stat_pck_miss_cnt(be->p_flm_nthw, &flm->v25.pck_miss->cnt, 1);
-		flm_nthw_stat_pck_unh_cnt(be->p_flm_nthw, &flm->v25.pck_unh->cnt, 1);
-		flm_nthw_stat_pck_dis_cnt(be->p_flm_nthw, &flm->v25.pck_dis->cnt, 1);
-		flm_nthw_stat_csh_hit_cnt(be->p_flm_nthw, &flm->v25.csh_hit->cnt, 1);
-		flm_nthw_stat_csh_miss_cnt(be->p_flm_nthw, &flm->v25.csh_miss->cnt, 1);
-		flm_nthw_stat_csh_unh_cnt(be->p_flm_nthw, &flm->v25.csh_unh->cnt, 1);
-		flm_nthw_stat_cuc_start_cnt(be->p_flm_nthw, &flm->v25.cuc_start->cnt, 1);
-		flm_nthw_stat_cuc_move_cnt(be->p_flm_nthw, &flm->v25.cuc_move->cnt, 1);
+		nthw_flm_stat_sta_done_update(be->p_flm_nthw);
+		nthw_flm_stat_inf_done_update(be->p_flm_nthw);
+		nthw_flm_stat_inf_skip_update(be->p_flm_nthw);
+		nthw_flm_stat_pck_hit_update(be->p_flm_nthw);
+		nthw_flm_stat_pck_miss_update(be->p_flm_nthw);
+		nthw_flm_stat_pck_unh_update(be->p_flm_nthw);
+		nthw_flm_stat_pck_dis_update(be->p_flm_nthw);
+		nthw_flm_stat_csh_hit_update(be->p_flm_nthw);
+		nthw_flm_stat_csh_miss_update(be->p_flm_nthw);
+		nthw_flm_stat_csh_unh_update(be->p_flm_nthw);
+		nthw_flm_stat_cuc_start_update(be->p_flm_nthw);
+		nthw_flm_stat_cuc_move_update(be->p_flm_nthw);
+
+		nthw_flm_stat_sta_done_cnt(be->p_flm_nthw, &flm->v25.sta_done->cnt, 1);
+		nthw_flm_stat_inf_done_cnt(be->p_flm_nthw, &flm->v25.inf_done->cnt, 1);
+		nthw_flm_stat_inf_skip_cnt(be->p_flm_nthw, &flm->v25.inf_skip->cnt, 1);
+		nthw_flm_stat_pck_hit_cnt(be->p_flm_nthw, &flm->v25.pck_hit->cnt, 1);
+		nthw_flm_stat_pck_miss_cnt(be->p_flm_nthw, &flm->v25.pck_miss->cnt, 1);
+		nthw_flm_stat_pck_unh_cnt(be->p_flm_nthw, &flm->v25.pck_unh->cnt, 1);
+		nthw_flm_stat_pck_dis_cnt(be->p_flm_nthw, &flm->v25.pck_dis->cnt, 1);
+		nthw_flm_stat_csh_hit_cnt(be->p_flm_nthw, &flm->v25.csh_hit->cnt, 1);
+		nthw_flm_stat_csh_miss_cnt(be->p_flm_nthw, &flm->v25.csh_miss->cnt, 1);
+		nthw_flm_stat_csh_unh_cnt(be->p_flm_nthw, &flm->v25.csh_unh->cnt, 1);
+		nthw_flm_stat_cuc_start_cnt(be->p_flm_nthw, &flm->v25.cuc_start->cnt, 1);
+		nthw_flm_stat_cuc_move_cnt(be->p_flm_nthw, &flm->v25.cuc_move->cnt, 1);
 	}
 
 	CHECK_DEBUG_OFF(flm, be->p_flm_nthw);
@@ -1249,7 +1249,7 @@ static int flm_lrn_data_flush(void *be_dev, const struct flm_func_s *flm, const
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
-	int ret = flm_nthw_lrn_data_flush(be->p_flm_nthw, lrn_data, records, words_per_record,
+	int ret = nthw_flm_lrn_data_flush(be->p_flm_nthw, lrn_data, records, words_per_record,
 			handled_records, &flm->v25.buf_ctrl->lrn_free,
 			&flm->v25.buf_ctrl->inf_avail,
 			&flm->v25.buf_ctrl->sta_avail);
@@ -1268,7 +1268,7 @@ static int flm_inf_sta_data_update(void *be_dev, const struct flm_func_s *flm, u
 	struct backend_dev_s *be = (struct backend_dev_s *)be_dev;
 	CHECK_DEBUG_ON(be, flm, be->p_flm_nthw);
 
-	int ret = flm_nthw_inf_sta_data_update(be->p_flm_nthw, inf_data, inf_size, sta_data,
+	int ret = nthw_flm_inf_sta_data_update(be->p_flm_nthw, inf_data, inf_size, sta_data,
 			sta_size, &flm->v25.buf_ctrl->lrn_free,
 			&flm->v25.buf_ctrl->inf_avail,
 			&flm->v25.buf_ctrl->sta_avail);
@@ -1303,39 +1303,39 @@ static int hsh_rcp_flush(void *be_dev, const struct hsh_func_s *hsh, int categor
 	CHECK_DEBUG_ON(be, hsh, be->p_hsh_nthw);
 
 	if (hsh->ver == 5) {
-		hsh_nthw_rcp_cnt(be->p_hsh_nthw, 1);
+		nthw_hsh_rcp_cnt(be->p_hsh_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			hsh_nthw_rcp_select(be->p_hsh_nthw, category + i);
-			hsh_nthw_rcp_load_dist_type(be->p_hsh_nthw,
+			nthw_hsh_rcp_select(be->p_hsh_nthw, category + i);
+			nthw_hsh_rcp_load_dist_type(be->p_hsh_nthw,
 				hsh->v5.rcp[category + i].load_dist_type);
-			hsh_nthw_rcp_mac_port_mask(be->p_hsh_nthw,
+			nthw_hsh_rcp_mac_port_mask(be->p_hsh_nthw,
 				hsh->v5.rcp[category + i].mac_port_mask);
-			hsh_nthw_rcp_sort(be->p_hsh_nthw, hsh->v5.rcp[category + i].sort);
-			hsh_nthw_rcp_qw0_pe(be->p_hsh_nthw, hsh->v5.rcp[category + i].qw0_pe);
-			hsh_nthw_rcp_qw0_ofs(be->p_hsh_nthw, hsh->v5.rcp[category + i].qw0_ofs);
-			hsh_nthw_rcp_qw4_pe(be->p_hsh_nthw, hsh->v5.rcp[category + i].qw4_pe);
-			hsh_nthw_rcp_qw4_ofs(be->p_hsh_nthw, hsh->v5.rcp[category + i].qw4_ofs);
-			hsh_nthw_rcp_w8_pe(be->p_hsh_nthw, hsh->v5.rcp[category + i].w8_pe);
-			hsh_nthw_rcp_w8_ofs(be->p_hsh_nthw, hsh->v5.rcp[category + i].w8_ofs);
-			hsh_nthw_rcp_w8_sort(be->p_hsh_nthw, hsh->v5.rcp[category + i].w8_sort);
-			hsh_nthw_rcp_w9_pe(be->p_hsh_nthw, hsh->v5.rcp[category + i].w9_pe);
-			hsh_nthw_rcp_w9_ofs(be->p_hsh_nthw, hsh->v5.rcp[category + i].w9_ofs);
-			hsh_nthw_rcp_w9_sort(be->p_hsh_nthw, hsh->v5.rcp[category + i].w9_sort);
-			hsh_nthw_rcp_w9_p(be->p_hsh_nthw, hsh->v5.rcp[category + i].w9_p);
-			hsh_nthw_rcp_p_mask(be->p_hsh_nthw, hsh->v5.rcp[category + i].p_mask);
-			hsh_nthw_rcp_word_mask(be->p_hsh_nthw,
+			nthw_hsh_rcp_sort(be->p_hsh_nthw, hsh->v5.rcp[category + i].sort);
+			nthw_hsh_rcp_qw0_pe(be->p_hsh_nthw, hsh->v5.rcp[category + i].qw0_pe);
+			nthw_hsh_rcp_qw0_ofs(be->p_hsh_nthw, hsh->v5.rcp[category + i].qw0_ofs);
+			nthw_hsh_rcp_qw4_pe(be->p_hsh_nthw, hsh->v5.rcp[category + i].qw4_pe);
+			nthw_hsh_rcp_qw4_ofs(be->p_hsh_nthw, hsh->v5.rcp[category + i].qw4_ofs);
+			nthw_hsh_rcp_w8_pe(be->p_hsh_nthw, hsh->v5.rcp[category + i].w8_pe);
+			nthw_hsh_rcp_w8_ofs(be->p_hsh_nthw, hsh->v5.rcp[category + i].w8_ofs);
+			nthw_hsh_rcp_w8_sort(be->p_hsh_nthw, hsh->v5.rcp[category + i].w8_sort);
+			nthw_hsh_rcp_w9_pe(be->p_hsh_nthw, hsh->v5.rcp[category + i].w9_pe);
+			nthw_hsh_rcp_w9_ofs(be->p_hsh_nthw, hsh->v5.rcp[category + i].w9_ofs);
+			nthw_hsh_rcp_w9_sort(be->p_hsh_nthw, hsh->v5.rcp[category + i].w9_sort);
+			nthw_hsh_rcp_w9_p(be->p_hsh_nthw, hsh->v5.rcp[category + i].w9_p);
+			nthw_hsh_rcp_p_mask(be->p_hsh_nthw, hsh->v5.rcp[category + i].p_mask);
+			nthw_hsh_rcp_word_mask(be->p_hsh_nthw,
 				hsh->v5.rcp[category + i].word_mask);
-			hsh_nthw_rcp_seed(be->p_hsh_nthw, hsh->v5.rcp[category + i].seed);
-			hsh_nthw_rcp_tnl_p(be->p_hsh_nthw, hsh->v5.rcp[category + i].tnl_p);
-			hsh_nthw_rcp_hsh_valid(be->p_hsh_nthw,
+			nthw_hsh_rcp_seed(be->p_hsh_nthw, hsh->v5.rcp[category + i].seed);
+			nthw_hsh_rcp_tnl_p(be->p_hsh_nthw, hsh->v5.rcp[category + i].tnl_p);
+			nthw_hsh_rcp_hsh_valid(be->p_hsh_nthw,
 				hsh->v5.rcp[category + i].hsh_valid);
-			hsh_nthw_rcp_hsh_type(be->p_hsh_nthw, hsh->v5.rcp[category + i].hsh_type);
-			hsh_nthw_rcp_toeplitz(be->p_hsh_nthw, hsh->v5.rcp[category + i].toeplitz);
-			hsh_nthw_rcp_k(be->p_hsh_nthw, hsh->v5.rcp[category + i].k);
-			hsh_nthw_rcp_auto_ipv4_mask(be->p_hsh_nthw,
+			nthw_hsh_rcp_hsh_type(be->p_hsh_nthw, hsh->v5.rcp[category + i].hsh_type);
+			nthw_hsh_rcp_toeplitz(be->p_hsh_nthw, hsh->v5.rcp[category + i].toeplitz);
+			nthw_hsh_rcp_k(be->p_hsh_nthw, hsh->v5.rcp[category + i].k);
+			nthw_hsh_rcp_auto_ipv4_mask(be->p_hsh_nthw,
 				hsh->v5.rcp[category + i].auto_ipv4_mask);
-			hsh_nthw_rcp_flush(be->p_hsh_nthw);
+			nthw_hsh_rcp_flush(be->p_hsh_nthw);
 		}
 	}
 
@@ -1366,20 +1366,20 @@ static int qsl_rcp_flush(void *be_dev, const struct qsl_func_s *qsl, int categor
 	CHECK_DEBUG_ON(be, qsl, be->p_qsl_nthw);
 
 	if (qsl->ver == 7) {
-		qsl_nthw_rcp_cnt(be->p_qsl_nthw, 1);
+		nthw_qsl_rcp_cnt(be->p_qsl_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			qsl_nthw_rcp_select(be->p_qsl_nthw, category + i);
-			qsl_nthw_rcp_discard(be->p_qsl_nthw, qsl->v7.rcp[category + i].discard);
-			qsl_nthw_rcp_drop(be->p_qsl_nthw, qsl->v7.rcp[category + i].drop);
-			qsl_nthw_rcp_tbl_lo(be->p_qsl_nthw, qsl->v7.rcp[category + i].tbl_lo);
-			qsl_nthw_rcp_tbl_hi(be->p_qsl_nthw, qsl->v7.rcp[category + i].tbl_hi);
-			qsl_nthw_rcp_tbl_idx(be->p_qsl_nthw, qsl->v7.rcp[category + i].tbl_idx);
-			qsl_nthw_rcp_tbl_msk(be->p_qsl_nthw, qsl->v7.rcp[category + i].tbl_msk);
-			qsl_nthw_rcp_lr(be->p_qsl_nthw, qsl->v7.rcp[category + i].lr);
-			qsl_nthw_rcp_tsa(be->p_qsl_nthw, qsl->v7.rcp[category + i].tsa);
-			qsl_nthw_rcp_vli(be->p_qsl_nthw, qsl->v7.rcp[category + i].vli);
-			qsl_nthw_rcp_flush(be->p_qsl_nthw);
+			nthw_qsl_rcp_select(be->p_qsl_nthw, category + i);
+			nthw_qsl_rcp_discard(be->p_qsl_nthw, qsl->v7.rcp[category + i].discard);
+			nthw_qsl_rcp_drop(be->p_qsl_nthw, qsl->v7.rcp[category + i].drop);
+			nthw_qsl_rcp_tbl_lo(be->p_qsl_nthw, qsl->v7.rcp[category + i].tbl_lo);
+			nthw_qsl_rcp_tbl_hi(be->p_qsl_nthw, qsl->v7.rcp[category + i].tbl_hi);
+			nthw_qsl_rcp_tbl_idx(be->p_qsl_nthw, qsl->v7.rcp[category + i].tbl_idx);
+			nthw_qsl_rcp_tbl_msk(be->p_qsl_nthw, qsl->v7.rcp[category + i].tbl_msk);
+			nthw_qsl_rcp_lr(be->p_qsl_nthw, qsl->v7.rcp[category + i].lr);
+			nthw_qsl_rcp_tsa(be->p_qsl_nthw, qsl->v7.rcp[category + i].tsa);
+			nthw_qsl_rcp_vli(be->p_qsl_nthw, qsl->v7.rcp[category + i].vli);
+			nthw_qsl_rcp_flush(be->p_qsl_nthw);
 		}
 	}
 
@@ -1393,18 +1393,18 @@ static int qsl_qst_flush(void *be_dev, const struct qsl_func_s *qsl, int entry,
 	CHECK_DEBUG_ON(be, qsl, be->p_qsl_nthw);
 
 	if (qsl->ver == 7) {
-		qsl_nthw_qst_cnt(be->p_qsl_nthw, 1);
+		nthw_qsl_qst_cnt(be->p_qsl_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			qsl_nthw_qst_select(be->p_qsl_nthw, entry + i);
-			qsl_nthw_qst_queue(be->p_qsl_nthw, qsl->v7.qst[entry + i].queue);
-			qsl_nthw_qst_en(be->p_qsl_nthw, qsl->v7.qst[entry + i].en);
-
-			qsl_nthw_qst_tx_port(be->p_qsl_nthw, qsl->v7.qst[entry + i].tx_port);
-			qsl_nthw_qst_lre(be->p_qsl_nthw, qsl->v7.qst[entry + i].lre);
-			qsl_nthw_qst_tci(be->p_qsl_nthw, qsl->v7.qst[entry + i].tci);
-			qsl_nthw_qst_ven(be->p_qsl_nthw, qsl->v7.qst[entry + i].ven);
-			qsl_nthw_qst_flush(be->p_qsl_nthw);
+			nthw_qsl_qst_select(be->p_qsl_nthw, entry + i);
+			nthw_qsl_qst_queue(be->p_qsl_nthw, qsl->v7.qst[entry + i].queue);
+			nthw_qsl_qst_en(be->p_qsl_nthw, qsl->v7.qst[entry + i].en);
+
+			nthw_qsl_qst_tx_port(be->p_qsl_nthw, qsl->v7.qst[entry + i].tx_port);
+			nthw_qsl_qst_lre(be->p_qsl_nthw, qsl->v7.qst[entry + i].lre);
+			nthw_qsl_qst_tci(be->p_qsl_nthw, qsl->v7.qst[entry + i].tci);
+			nthw_qsl_qst_ven(be->p_qsl_nthw, qsl->v7.qst[entry + i].ven);
+			nthw_qsl_qst_flush(be->p_qsl_nthw);
 		}
 	}
 
@@ -1418,12 +1418,12 @@ static int qsl_qen_flush(void *be_dev, const struct qsl_func_s *qsl, int entry,
 	CHECK_DEBUG_ON(be, qsl, be->p_qsl_nthw);
 
 	if (qsl->ver == 7) {
-		qsl_nthw_qen_cnt(be->p_qsl_nthw, 1);
+		nthw_qsl_qen_cnt(be->p_qsl_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			qsl_nthw_qen_select(be->p_qsl_nthw, entry + i);
-			qsl_nthw_qen_en(be->p_qsl_nthw, qsl->v7.qen[entry + i].en);
-			qsl_nthw_qen_flush(be->p_qsl_nthw);
+			nthw_qsl_qen_select(be->p_qsl_nthw, entry + i);
+			nthw_qsl_qen_en(be->p_qsl_nthw, qsl->v7.qen[entry + i].en);
+			nthw_qsl_qen_flush(be->p_qsl_nthw);
 		}
 	}
 
@@ -1437,14 +1437,14 @@ static int qsl_unmq_flush(void *be_dev, const struct qsl_func_s *qsl, int entry,
 	CHECK_DEBUG_ON(be, qsl, be->p_qsl_nthw);
 
 	if (qsl->ver == 7) {
-		qsl_nthw_unmq_cnt(be->p_qsl_nthw, 1);
+		nthw_qsl_unmq_cnt(be->p_qsl_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			qsl_nthw_unmq_select(be->p_qsl_nthw, entry + i);
-			qsl_nthw_unmq_dest_queue(be->p_qsl_nthw,
+			nthw_qsl_unmq_select(be->p_qsl_nthw, entry + i);
+			nthw_qsl_unmq_dest_queue(be->p_qsl_nthw,
 				qsl->v7.unmq[entry + i].dest_queue);
-			qsl_nthw_unmq_en(be->p_qsl_nthw, qsl->v7.unmq[entry + i].en);
-			qsl_nthw_unmq_flush(be->p_qsl_nthw);
+			nthw_qsl_unmq_en(be->p_qsl_nthw, qsl->v7.unmq[entry + i].en);
+			nthw_qsl_unmq_flush(be->p_qsl_nthw);
 		}
 	}
 
@@ -1476,24 +1476,24 @@ static int slc_lr_rcp_flush(void *be_dev, const struct slc_lr_func_s *slc_lr, in
 	CHECK_DEBUG_ON(be, slc_lr, be->p_slc_lr_nthw);
 
 	if (slc_lr->ver == 2) {
-		slc_lr_nthw_rcp_cnt(be->p_slc_lr_nthw, 1);
+		nthw_slc_lr_rcp_cnt(be->p_slc_lr_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			slc_lr_nthw_rcp_select(be->p_slc_lr_nthw, category + i);
-			slc_lr_nthw_rcp_head_slc_en(be->p_slc_lr_nthw,
+			nthw_slc_lr_rcp_select(be->p_slc_lr_nthw, category + i);
+			nthw_slc_lr_rcp_head_slc_en(be->p_slc_lr_nthw,
 				slc_lr->v2.rcp[category + i].head_slc_en);
-			slc_lr_nthw_rcp_head_dyn(be->p_slc_lr_nthw,
+			nthw_slc_lr_rcp_head_dyn(be->p_slc_lr_nthw,
 				slc_lr->v2.rcp[category + i].head_dyn);
-			slc_lr_nthw_rcp_head_ofs(be->p_slc_lr_nthw,
+			nthw_slc_lr_rcp_head_ofs(be->p_slc_lr_nthw,
 				slc_lr->v2.rcp[category + i].head_ofs);
-			slc_lr_nthw_rcp_tail_slc_en(be->p_slc_lr_nthw,
+			nthw_slc_lr_rcp_tail_slc_en(be->p_slc_lr_nthw,
 				slc_lr->v2.rcp[category + i].tail_slc_en);
-			slc_lr_nthw_rcp_tail_dyn(be->p_slc_lr_nthw,
+			nthw_slc_lr_rcp_tail_dyn(be->p_slc_lr_nthw,
 				slc_lr->v2.rcp[category + i].tail_dyn);
-			slc_lr_nthw_rcp_tail_ofs(be->p_slc_lr_nthw,
+			nthw_slc_lr_rcp_tail_ofs(be->p_slc_lr_nthw,
 				slc_lr->v2.rcp[category + i].tail_ofs);
-			slc_lr_nthw_rcp_pcap(be->p_slc_lr_nthw, slc_lr->v2.rcp[category + i].pcap);
-			slc_lr_nthw_rcp_flush(be->p_slc_lr_nthw);
+			nthw_slc_lr_rcp_pcap(be->p_slc_lr_nthw, slc_lr->v2.rcp[category + i].pcap);
+			nthw_slc_lr_rcp_flush(be->p_slc_lr_nthw);
 		}
 	}
 
@@ -1524,36 +1524,36 @@ static int pdb_rcp_flush(void *be_dev, const struct pdb_func_s *pdb, int categor
 	CHECK_DEBUG_ON(be, pdb, be->p_pdb_nthw);
 
 	if (pdb->ver == 9) {
-		pdb_nthw_rcp_cnt(be->p_pdb_nthw, 1);
+		nthw_pdb_rcp_cnt(be->p_pdb_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			pdb_nthw_rcp_select(be->p_pdb_nthw, category + i);
-			pdb_nthw_rcp_descriptor(be->p_pdb_nthw,
+			nthw_pdb_rcp_select(be->p_pdb_nthw, category + i);
+			nthw_pdb_rcp_descriptor(be->p_pdb_nthw,
 				pdb->v9.rcp[category + i].descriptor);
-			pdb_nthw_rcp_desc_len(be->p_pdb_nthw, pdb->v9.rcp[category + i].desc_len);
-			pdb_nthw_rcp_tx_port(be->p_pdb_nthw, pdb->v9.rcp[category + i].tx_port);
-			pdb_nthw_rcp_tx_ignore(be->p_pdb_nthw,
+			nthw_pdb_rcp_desc_len(be->p_pdb_nthw, pdb->v9.rcp[category + i].desc_len);
+			nthw_pdb_rcp_tx_port(be->p_pdb_nthw, pdb->v9.rcp[category + i].tx_port);
+			nthw_pdb_rcp_tx_ignore(be->p_pdb_nthw,
 				pdb->v9.rcp[category + i].tx_ignore);
-			pdb_nthw_rcp_tx_now(be->p_pdb_nthw, pdb->v9.rcp[category + i].tx_now);
-			pdb_nthw_rcp_crc_overwrite(be->p_pdb_nthw,
+			nthw_pdb_rcp_tx_now(be->p_pdb_nthw, pdb->v9.rcp[category + i].tx_now);
+			nthw_pdb_rcp_crc_overwrite(be->p_pdb_nthw,
 				pdb->v9.rcp[category + i].crc_overwrite);
-			pdb_nthw_rcp_align(be->p_pdb_nthw, pdb->v9.rcp[category + i].align);
-			pdb_nthw_rcp_ofs0_dyn(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs0_dyn);
-			pdb_nthw_rcp_ofs0_rel(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs0_rel);
-			pdb_nthw_rcp_ofs1_dyn(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs1_dyn);
-			pdb_nthw_rcp_ofs1_rel(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs1_rel);
-			pdb_nthw_rcp_ofs2_dyn(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs2_dyn);
-			pdb_nthw_rcp_ofs2_rel(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs2_rel);
-			pdb_nthw_rcp_ip_prot_tnl(be->p_pdb_nthw,
+			nthw_pdb_rcp_align(be->p_pdb_nthw, pdb->v9.rcp[category + i].align);
+			nthw_pdb_rcp_ofs0_dyn(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs0_dyn);
+			nthw_pdb_rcp_ofs0_rel(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs0_rel);
+			nthw_pdb_rcp_ofs1_dyn(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs1_dyn);
+			nthw_pdb_rcp_ofs1_rel(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs1_rel);
+			nthw_pdb_rcp_ofs2_dyn(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs2_dyn);
+			nthw_pdb_rcp_ofs2_rel(be->p_pdb_nthw, pdb->v9.rcp[category + i].ofs2_rel);
+			nthw_pdb_rcp_ip_prot_tnl(be->p_pdb_nthw,
 				pdb->v9.rcp[category + i].ip_prot_tnl);
-			pdb_nthw_rcp_ppc_hsh(be->p_pdb_nthw, pdb->v9.rcp[category + i].ppc_hsh);
-			pdb_nthw_rcp_duplicate_en(be->p_pdb_nthw,
+			nthw_pdb_rcp_ppc_hsh(be->p_pdb_nthw, pdb->v9.rcp[category + i].ppc_hsh);
+			nthw_pdb_rcp_duplicate_en(be->p_pdb_nthw,
 				pdb->v9.rcp[category + i].duplicate_en);
-			pdb_nthw_rcp_duplicate_bit(be->p_pdb_nthw,
+			nthw_pdb_rcp_duplicate_bit(be->p_pdb_nthw,
 				pdb->v9.rcp[category + i].duplicate_bit);
-			pdb_nthw_rcp_duplicate_bit(be->p_pdb_nthw,
+			nthw_pdb_rcp_duplicate_bit(be->p_pdb_nthw,
 				pdb->v9.rcp[category + i].pcap_keep_fcs);
-			pdb_nthw_rcp_flush(be->p_pdb_nthw);
+			nthw_pdb_rcp_flush(be->p_pdb_nthw);
 		}
 	}
 
@@ -1567,9 +1567,9 @@ static int pdb_config_flush(void *be_dev, const struct pdb_func_s *pdb)
 	CHECK_DEBUG_ON(be, pdb, be->p_pdb_nthw);
 
 	if (pdb->ver == 9) {
-		pdb_nthw_config_ts_format(be->p_pdb_nthw, pdb->v9.config->ts_format);
-		pdb_nthw_config_port_ofs(be->p_pdb_nthw, pdb->v9.config->port_ofs);
-		pdb_nthw_config_flush(be->p_pdb_nthw);
+		nthw_pdb_config_ts_format(be->p_pdb_nthw, pdb->v9.config->ts_format);
+		nthw_pdb_config_port_ofs(be->p_pdb_nthw, pdb->v9.config->port_ofs);
+		nthw_pdb_config_flush(be->p_pdb_nthw);
 	}
 
 	CHECK_DEBUG_OFF(pdb, be->p_pdb_nthw);
@@ -1642,12 +1642,12 @@ static int tpe_rpp_rcp_flush(void *be_dev, const struct tpe_func_s *rpp_lr, int
 	CHECK_DEBUG_ON(be, rpp_lr, be->p_rpp_lr_nthw);
 
 	if (rpp_lr->ver >= 1) {
-		rpp_lr_nthw_rcp_cnt(be->p_rpp_lr_nthw, 1);
+		nthw_rpp_lr_rcp_cnt(be->p_rpp_lr_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			rpp_lr_nthw_rcp_select(be->p_rpp_lr_nthw, index + i);
-			rpp_lr_nthw_rcp_exp(be->p_rpp_lr_nthw, rpp_lr->v3.rpp_rcp[index + i].exp);
-			rpp_lr_nthw_rcp_flush(be->p_rpp_lr_nthw);
+			nthw_rpp_lr_rcp_select(be->p_rpp_lr_nthw, index + i);
+			nthw_rpp_lr_rcp_exp(be->p_rpp_lr_nthw, rpp_lr->v3.rpp_rcp[index + i].exp);
+			nthw_rpp_lr_rcp_flush(be->p_rpp_lr_nthw);
 		}
 	}
 
@@ -1662,22 +1662,22 @@ static int tpe_rpp_ifr_rcp_flush(void *be_dev, const struct tpe_func_s *rpp_lr,
 	CHECK_DEBUG_ON(be, rpp_lr, be->p_rpp_lr_nthw);
 
 	if (rpp_lr->ver >= 2) {
-		rpp_lr_nthw_ifr_rcp_cnt(be->p_rpp_lr_nthw, 1);
+		nthw_rpp_lr_ifr_rcp_cnt(be->p_rpp_lr_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			rpp_lr_nthw_ifr_rcp_select(be->p_rpp_lr_nthw, index + i);
-			rpp_lr_nthw_ifr_rcp_ipv4_en(be->p_rpp_lr_nthw,
+			nthw_rpp_lr_ifr_rcp_select(be->p_rpp_lr_nthw, index + i);
+			nthw_rpp_lr_ifr_rcp_ipv4_en(be->p_rpp_lr_nthw,
 				rpp_lr->v3.rpp_ifr_rcp[index + i].ipv4_en);
-			rpp_lr_nthw_ifr_rcp_ipv4_df_drop(be->p_rpp_lr_nthw,
+			nthw_rpp_lr_ifr_rcp_ipv4_df_drop(be->p_rpp_lr_nthw,
 				rpp_lr->v3.rpp_ifr_rcp[index + i]
 				.ipv4_df_drop);
-			rpp_lr_nthw_ifr_rcp_ipv6_en(be->p_rpp_lr_nthw,
+			nthw_rpp_lr_ifr_rcp_ipv6_en(be->p_rpp_lr_nthw,
 				rpp_lr->v3.rpp_ifr_rcp[index + i].ipv6_en);
-			rpp_lr_nthw_ifr_rcp_ipv6_drop(be->p_rpp_lr_nthw,
+			nthw_rpp_lr_ifr_rcp_ipv6_drop(be->p_rpp_lr_nthw,
 				rpp_lr->v3.rpp_ifr_rcp[index + i].ipv6_drop);
-			rpp_lr_nthw_ifr_rcp_mtu(be->p_rpp_lr_nthw,
+			nthw_rpp_lr_ifr_rcp_mtu(be->p_rpp_lr_nthw,
 				rpp_lr->v3.rpp_ifr_rcp[index + i].mtu);
-			rpp_lr_nthw_ifr_rcp_flush(be->p_rpp_lr_nthw);
+			nthw_rpp_lr_ifr_rcp_flush(be->p_rpp_lr_nthw);
 		}
 
 	} else {
@@ -1695,18 +1695,18 @@ static int tpe_ifr_rcp_flush(void *be_dev, const struct tpe_func_s *ifr, int ind
 	CHECK_DEBUG_ON(be, ifr, be->p_ifr_nthw);
 
 	if (ifr->ver >= 2) {
-		ifr_nthw_rcp_cnt(be->p_ifr_nthw, 1);
+		nthw_ifr_rcp_cnt(be->p_ifr_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			ifr_nthw_rcp_select(be->p_ifr_nthw, index + i);
-			ifr_nthw_rcp_ipv4_en(be->p_ifr_nthw, ifr->v3.ifr_rcp[index + i].ipv4_en);
-			ifr_nthw_rcp_ipv4_df_drop(be->p_ifr_nthw,
+			nthw_ifr_rcp_select(be->p_ifr_nthw, index + i);
+			nthw_ifr_rcp_ipv4_en(be->p_ifr_nthw, ifr->v3.ifr_rcp[index + i].ipv4_en);
+			nthw_ifr_rcp_ipv4_df_drop(be->p_ifr_nthw,
 				ifr->v3.ifr_rcp[index + i].ipv4_df_drop);
-			ifr_nthw_rcp_ipv6_en(be->p_ifr_nthw, ifr->v3.ifr_rcp[index + i].ipv6_en);
-			ifr_nthw_rcp_ipv6_drop(be->p_ifr_nthw,
+			nthw_ifr_rcp_ipv6_en(be->p_ifr_nthw, ifr->v3.ifr_rcp[index + i].ipv6_en);
+			nthw_ifr_rcp_ipv6_drop(be->p_ifr_nthw,
 				ifr->v3.ifr_rcp[index + i].ipv6_drop);
-			ifr_nthw_rcp_mtu(be->p_ifr_nthw, ifr->v3.ifr_rcp[index + i].mtu);
-			ifr_nthw_rcp_flush(be->p_ifr_nthw);
+			nthw_ifr_rcp_mtu(be->p_ifr_nthw, ifr->v3.ifr_rcp[index + i].mtu);
+			nthw_ifr_rcp_flush(be->p_ifr_nthw);
 		}
 
 	} else {
@@ -1725,12 +1725,12 @@ static int tpe_ifr_counters_update(void *be_dev, const struct tpe_func_s *ifr, i
 	CHECK_DEBUG_ON(be, ifr, be->p_ifr_nthw);
 
 	if (ifr->ver >= 2) {
-		ifr_nthw_counters_cnt(be->p_ifr_nthw, 1);
+		nthw_ifr_counters_cnt(be->p_ifr_nthw, 1);
 
 		for (i = 0; i < cnt; i++) {
-			ifr_nthw_counters_select(be->p_ifr_nthw, index + i);
-			ifr_nthw_counters_update(be->p_ifr_nthw);
-			ifr_nthw_counters_drop(be->p_ifr_nthw,
+			nthw_ifr_counters_select(be->p_ifr_nthw, index + i);
+			nthw_ifr_counters_update(be->p_ifr_nthw);
+			nthw_ifr_counters_drop(be->p_ifr_nthw,
 				&ifr->v3.ifr_counters[index + i].drop, 1);
 		}
 
@@ -1748,14 +1748,14 @@ static int tpe_ins_rcp_flush(void *be_dev, const struct tpe_func_s *tx_ins, int
 	CHECK_DEBUG_ON(be, tx_ins, be->p_tx_ins_nthw);
 
 	if (tx_ins->ver >= 1) {
-		tx_ins_nthw_rcp_cnt(be->p_tx_ins_nthw, 1);
+		nthw_tx_ins_rcp_cnt(be->p_tx_ins_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			tx_ins_nthw_rcp_select(be->p_tx_ins_nthw, index + i);
-			tx_ins_nthw_rcp_dyn(be->p_tx_ins_nthw, tx_ins->v3.ins_rcp[index + i].dyn);
-			tx_ins_nthw_rcp_ofs(be->p_tx_ins_nthw, tx_ins->v3.ins_rcp[index + i].ofs);
-			tx_ins_nthw_rcp_len(be->p_tx_ins_nthw, tx_ins->v3.ins_rcp[index + i].len);
-			tx_ins_nthw_rcp_flush(be->p_tx_ins_nthw);
+			nthw_tx_ins_rcp_select(be->p_tx_ins_nthw, index + i);
+			nthw_tx_ins_rcp_dyn(be->p_tx_ins_nthw, tx_ins->v3.ins_rcp[index + i].dyn);
+			nthw_tx_ins_rcp_ofs(be->p_tx_ins_nthw, tx_ins->v3.ins_rcp[index + i].ofs);
+			nthw_tx_ins_rcp_len(be->p_tx_ins_nthw, tx_ins->v3.ins_rcp[index + i].len);
+			nthw_tx_ins_rcp_flush(be->p_tx_ins_nthw);
 		}
 	}
 
@@ -1769,25 +1769,25 @@ static int tpe_rpl_rcp_flush(void *be_dev, const struct tpe_func_s *tx_rpl, int
 	CHECK_DEBUG_ON(be, tx_rpl, be->p_tx_rpl_nthw);
 
 	if (tx_rpl->ver >= 1) {
-		tx_rpl_nthw_rcp_cnt(be->p_tx_rpl_nthw, 1);
+		nthw_tx_rpl_rcp_cnt(be->p_tx_rpl_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			tx_rpl_nthw_rcp_select(be->p_tx_rpl_nthw, index + i);
-			tx_rpl_nthw_rcp_dyn(be->p_tx_rpl_nthw, tx_rpl->v3.rpl_rcp[index + i].dyn);
-			tx_rpl_nthw_rcp_ofs(be->p_tx_rpl_nthw, tx_rpl->v3.rpl_rcp[index + i].ofs);
-			tx_rpl_nthw_rcp_len(be->p_tx_rpl_nthw, tx_rpl->v3.rpl_rcp[index + i].len);
-			tx_rpl_nthw_rcp_rpl_ptr(be->p_tx_rpl_nthw,
+			nthw_tx_rpl_rcp_select(be->p_tx_rpl_nthw, index + i);
+			nthw_tx_rpl_rcp_dyn(be->p_tx_rpl_nthw, tx_rpl->v3.rpl_rcp[index + i].dyn);
+			nthw_tx_rpl_rcp_ofs(be->p_tx_rpl_nthw, tx_rpl->v3.rpl_rcp[index + i].ofs);
+			nthw_tx_rpl_rcp_len(be->p_tx_rpl_nthw, tx_rpl->v3.rpl_rcp[index + i].len);
+			nthw_tx_rpl_rcp_rpl_ptr(be->p_tx_rpl_nthw,
 				tx_rpl->v3.rpl_rcp[index + i].rpl_ptr);
-			tx_rpl_nthw_rcp_ext_prio(be->p_tx_rpl_nthw,
+			nthw_tx_rpl_rcp_ext_prio(be->p_tx_rpl_nthw,
 				tx_rpl->v3.rpl_rcp[index + i].ext_prio);
 
 			if (tx_rpl->ver >= 3) {
-				tx_rpl_nthw_rcp_eth_type_wr(be->p_tx_rpl_nthw,
+				nthw_tx_rpl_rcp_eth_type_wr(be->p_tx_rpl_nthw,
 					tx_rpl->v3.rpl_rcp[index + i]
 					.eth_type_wr);
 			}
 
-			tx_rpl_nthw_rcp_flush(be->p_tx_rpl_nthw);
+			nthw_tx_rpl_rcp_flush(be->p_tx_rpl_nthw);
 		}
 	}
 
@@ -1801,13 +1801,13 @@ static int tpe_rpl_ext_flush(void *be_dev, const struct tpe_func_s *tx_rpl, int
 	CHECK_DEBUG_ON(be, tx_rpl, be->p_tx_rpl_nthw);
 
 	if (tx_rpl->ver >= 1) {
-		tx_rpl_nthw_ext_cnt(be->p_tx_rpl_nthw, 1);
+		nthw_tx_rpl_ext_cnt(be->p_tx_rpl_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			tx_rpl_nthw_ext_select(be->p_tx_rpl_nthw, index + i);
-			tx_rpl_nthw_ext_rpl_ptr(be->p_tx_rpl_nthw,
+			nthw_tx_rpl_ext_select(be->p_tx_rpl_nthw, index + i);
+			nthw_tx_rpl_ext_rpl_ptr(be->p_tx_rpl_nthw,
 				tx_rpl->v3.rpl_ext[index + i].rpl_ptr);
-			tx_rpl_nthw_ext_flush(be->p_tx_rpl_nthw);
+			nthw_tx_rpl_ext_flush(be->p_tx_rpl_nthw);
 		}
 	}
 
@@ -1821,13 +1821,13 @@ static int tpe_rpl_rpl_flush(void *be_dev, const struct tpe_func_s *tx_rpl, int
 	CHECK_DEBUG_ON(be, tx_rpl, be->p_tx_rpl_nthw);
 
 	if (tx_rpl->ver >= 1) {
-		tx_rpl_nthw_rpl_cnt(be->p_tx_rpl_nthw, 1);
+		nthw_tx_rpl_rpl_cnt(be->p_tx_rpl_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			tx_rpl_nthw_rpl_select(be->p_tx_rpl_nthw, index + i);
-			tx_rpl_nthw_rpl_value(be->p_tx_rpl_nthw,
+			nthw_tx_rpl_rpl_select(be->p_tx_rpl_nthw, index + i);
+			nthw_tx_rpl_rpl_value(be->p_tx_rpl_nthw,
 				tx_rpl->v3.rpl_rpl[index + i].value);
-			tx_rpl_nthw_rpl_flush(be->p_tx_rpl_nthw);
+			nthw_tx_rpl_rpl_flush(be->p_tx_rpl_nthw);
 		}
 	}
 
@@ -1846,21 +1846,21 @@ static int tpe_cpy_rcp_flush(void *be_dev, const struct tpe_func_s *tx_cpy, int
 		for (int i = 0; i < cnt; i++) {
 			if (wr_index != (index + i) / tx_cpy->nb_rcp_categories) {
 				wr_index = (index + i) / tx_cpy->nb_rcp_categories;
-				tx_cpy_nthw_writer_cnt(be->p_tx_cpy_nthw, wr_index, 1);
+				nthw_tx_cpy_writer_cnt(be->p_tx_cpy_nthw, wr_index, 1);
 			}
 
-			tx_cpy_nthw_writer_select(be->p_tx_cpy_nthw, wr_index,
+			nthw_tx_cpy_writer_select(be->p_tx_cpy_nthw, wr_index,
 				(index + i) % tx_cpy->nb_rcp_categories);
-			tx_cpy_nthw_writer_reader_select(be->p_tx_cpy_nthw, wr_index,
+			nthw_tx_cpy_writer_reader_select(be->p_tx_cpy_nthw, wr_index,
 				tx_cpy->v3.cpy_rcp[index + i]
 				.reader_select);
-			tx_cpy_nthw_writer_dyn(be->p_tx_cpy_nthw, wr_index,
+			nthw_tx_cpy_writer_dyn(be->p_tx_cpy_nthw, wr_index,
 				tx_cpy->v3.cpy_rcp[index + i].dyn);
-			tx_cpy_nthw_writer_ofs(be->p_tx_cpy_nthw, wr_index,
+			nthw_tx_cpy_writer_ofs(be->p_tx_cpy_nthw, wr_index,
 				tx_cpy->v3.cpy_rcp[index + i].ofs);
-			tx_cpy_nthw_writer_len(be->p_tx_cpy_nthw, wr_index,
+			nthw_tx_cpy_writer_len(be->p_tx_cpy_nthw, wr_index,
 				tx_cpy->v3.cpy_rcp[index + i].len);
-			tx_cpy_nthw_writer_flush(be->p_tx_cpy_nthw, wr_index);
+			nthw_tx_cpy_writer_flush(be->p_tx_cpy_nthw, wr_index);
 		}
 	}
 
@@ -1874,51 +1874,51 @@ static int tpe_hfu_rcp_flush(void *be_dev, const struct tpe_func_s *hfu, int ind
 	CHECK_DEBUG_ON(be, hfu, be->p_hfu_nthw);
 
 	if (hfu->ver >= 1) {
-		hfu_nthw_rcp_cnt(be->p_hfu_nthw, 1);
+		nthw_hfu_rcp_cnt(be->p_hfu_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			hfu_nthw_rcp_select(be->p_hfu_nthw, index + i);
-			hfu_nthw_rcp_len_a_wr(be->p_hfu_nthw, hfu->v3.hfu_rcp[index + i].len_a_wr);
-			hfu_nthw_rcp_len_a_ol4len(be->p_hfu_nthw,
+			nthw_hfu_rcp_select(be->p_hfu_nthw, index + i);
+			nthw_hfu_rcp_len_a_wr(be->p_hfu_nthw, hfu->v3.hfu_rcp[index + i].len_a_wr);
+			nthw_hfu_rcp_len_a_ol4len(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_a_outer_l4_len);
-			hfu_nthw_rcp_len_a_pos_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_a_pos_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_a_pos_dyn);
-			hfu_nthw_rcp_len_a_pos_ofs(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_a_pos_ofs(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_a_pos_ofs);
-			hfu_nthw_rcp_len_a_add_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_a_add_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_a_add_dyn);
-			hfu_nthw_rcp_len_a_add_ofs(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_a_add_ofs(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_a_add_ofs);
-			hfu_nthw_rcp_len_a_sub_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_a_sub_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_a_sub_dyn);
-			hfu_nthw_rcp_len_b_wr(be->p_hfu_nthw, hfu->v3.hfu_rcp[index + i].len_b_wr);
-			hfu_nthw_rcp_len_b_pos_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_b_wr(be->p_hfu_nthw, hfu->v3.hfu_rcp[index + i].len_b_wr);
+			nthw_hfu_rcp_len_b_pos_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_b_pos_dyn);
-			hfu_nthw_rcp_len_b_pos_ofs(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_b_pos_ofs(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_b_pos_ofs);
-			hfu_nthw_rcp_len_b_add_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_b_add_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_b_add_dyn);
-			hfu_nthw_rcp_len_b_add_ofs(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_b_add_ofs(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_b_add_ofs);
-			hfu_nthw_rcp_len_b_sub_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_b_sub_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_b_sub_dyn);
-			hfu_nthw_rcp_len_c_wr(be->p_hfu_nthw, hfu->v3.hfu_rcp[index + i].len_c_wr);
-			hfu_nthw_rcp_len_c_pos_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_c_wr(be->p_hfu_nthw, hfu->v3.hfu_rcp[index + i].len_c_wr);
+			nthw_hfu_rcp_len_c_pos_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_c_pos_dyn);
-			hfu_nthw_rcp_len_c_pos_ofs(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_c_pos_ofs(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_c_pos_ofs);
-			hfu_nthw_rcp_len_c_add_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_c_add_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_c_add_dyn);
-			hfu_nthw_rcp_len_c_add_ofs(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_c_add_ofs(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_c_add_ofs);
-			hfu_nthw_rcp_len_c_sub_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_len_c_sub_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].len_c_sub_dyn);
-			hfu_nthw_rcp_ttl_wr(be->p_hfu_nthw, hfu->v3.hfu_rcp[index + i].ttl_wr);
-			hfu_nthw_rcp_ttl_pos_dyn(be->p_hfu_nthw,
+			nthw_hfu_rcp_ttl_wr(be->p_hfu_nthw, hfu->v3.hfu_rcp[index + i].ttl_wr);
+			nthw_hfu_rcp_ttl_pos_dyn(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].ttl_pos_dyn);
-			hfu_nthw_rcp_ttl_pos_ofs(be->p_hfu_nthw,
+			nthw_hfu_rcp_ttl_pos_ofs(be->p_hfu_nthw,
 				hfu->v3.hfu_rcp[index + i].ttl_pos_ofs);
-			hfu_nthw_rcp_flush(be->p_hfu_nthw);
+			nthw_hfu_rcp_flush(be->p_hfu_nthw);
 		}
 	}
 
@@ -1932,19 +1932,19 @@ static int tpe_csu_rcp_flush(void *be_dev, const struct tpe_func_s *csu, int ind
 	CHECK_DEBUG_ON(be, csu, be->p_csu_nthw);
 
 	if (csu->ver >= 1) {
-		csu_nthw_rcp_cnt(be->p_csu_nthw, 1);
+		nthw_csu_rcp_cnt(be->p_csu_nthw, 1);
 
 		for (int i = 0; i < cnt; i++) {
-			csu_nthw_rcp_select(be->p_csu_nthw, index + i);
-			csu_nthw_rcp_outer_l3_cmd(be->p_csu_nthw,
+			nthw_csu_rcp_select(be->p_csu_nthw, index + i);
+			nthw_csu_rcp_outer_l3_cmd(be->p_csu_nthw,
 				csu->v3.csu_rcp[index + i].ol3_cmd);
-			csu_nthw_rcp_outer_l4_cmd(be->p_csu_nthw,
+			nthw_csu_rcp_outer_l4_cmd(be->p_csu_nthw,
 				csu->v3.csu_rcp[index + i].ol4_cmd);
-			csu_nthw_rcp_inner_l3_cmd(be->p_csu_nthw,
+			nthw_csu_rcp_inner_l3_cmd(be->p_csu_nthw,
 				csu->v3.csu_rcp[index + i].il3_cmd);
-			csu_nthw_rcp_inner_l4_cmd(be->p_csu_nthw,
+			nthw_csu_rcp_inner_l4_cmd(be->p_csu_nthw,
 				csu->v3.csu_rcp[index + i].il4_cmd);
-			csu_nthw_rcp_flush(be->p_csu_nthw);
+			nthw_csu_rcp_flush(be->p_csu_nthw);
 		}
 	}
 
@@ -2101,14 +2101,14 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 {
 	uint8_t physical_adapter_no = (uint8_t)p_fpga->p_fpga_info->adapter_no;
 
-	struct info_nthw *pinfonthw = info_nthw_new();
-	info_nthw_init(pinfonthw, p_fpga, physical_adapter_no);
+	struct info_nthw *pinfonthw = nthw_info_new();
+	nthw_info_init(pinfonthw, p_fpga, physical_adapter_no);
 	be_devs[physical_adapter_no].p_info_nthw = pinfonthw;
 
 	/* Init nthw CAT */
-	if (cat_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct cat_nthw *pcatnthw = cat_nthw_new();
-		cat_nthw_init(pcatnthw, p_fpga, physical_adapter_no);
+	if (nthw_cat_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct cat_nthw *pcatnthw = nthw_cat_new();
+		nthw_cat_init(pcatnthw, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_cat_nthw = pcatnthw;
 
 	} else {
@@ -2116,9 +2116,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw KM */
-	if (km_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct km_nthw *pkmnthw = km_nthw_new();
-		km_nthw_init(pkmnthw, p_fpga, physical_adapter_no);
+	if (nthw_km_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct km_nthw *pkmnthw = nthw_km_new();
+		nthw_km_init(pkmnthw, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_km_nthw = pkmnthw;
 
 	} else {
@@ -2126,9 +2126,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw FLM */
-	if (flm_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct flm_nthw *pflmnthw = flm_nthw_new();
-		flm_nthw_init(pflmnthw, p_fpga, physical_adapter_no);
+	if (nthw_flm_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct flm_nthw *pflmnthw = nthw_flm_new();
+		nthw_flm_init(pflmnthw, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_flm_nthw = pflmnthw;
 
 	} else {
@@ -2136,9 +2136,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw IFR */
-	if (ifr_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct ifr_nthw *ifrnthw = ifr_nthw_new();
-		ifr_nthw_init(ifrnthw, p_fpga, physical_adapter_no);
+	if (nthw_ifr_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct ifr_nthw *ifrnthw = nthw_ifr_new();
+		nthw_ifr_init(ifrnthw, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_ifr_nthw = ifrnthw;
 
 	} else {
@@ -2146,9 +2146,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw HSH */
-	if (hsh_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct hsh_nthw *phshnthw = hsh_nthw_new();
-		hsh_nthw_init(phshnthw, p_fpga, physical_adapter_no);
+	if (nthw_hsh_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct hsh_nthw *phshnthw = nthw_hsh_new();
+		nthw_hsh_init(phshnthw, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_hsh_nthw = phshnthw;
 
 	} else {
@@ -2156,9 +2156,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw QSL */
-	if (qsl_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct qsl_nthw *pqslnthw = qsl_nthw_new();
-		qsl_nthw_init(pqslnthw, p_fpga, physical_adapter_no);
+	if (nthw_qsl_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct qsl_nthw *pqslnthw = nthw_qsl_new();
+		nthw_qsl_init(pqslnthw, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_qsl_nthw = pqslnthw;
 
 	} else {
@@ -2166,9 +2166,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw SLC LR */
-	if (slc_lr_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct slc_lr_nthw *pslclrnthw = slc_lr_nthw_new();
-		slc_lr_nthw_init(pslclrnthw, p_fpga, physical_adapter_no);
+	if (nthw_slc_lr_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct slc_lr_nthw *pslclrnthw = nthw_slc_lr_new();
+		nthw_slc_lr_init(pslclrnthw, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_slc_lr_nthw = pslclrnthw;
 
 	} else {
@@ -2176,9 +2176,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw PDB */
-	if (pdb_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct pdb_nthw *ppdbnthw = pdb_nthw_new();
-		pdb_nthw_init(ppdbnthw, p_fpga, physical_adapter_no);
+	if (nthw_pdb_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct pdb_nthw *ppdbnthw = nthw_pdb_new();
+		nthw_pdb_init(ppdbnthw, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_pdb_nthw = ppdbnthw;
 
 	} else {
@@ -2186,9 +2186,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw HFU */
-	if (hfu_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct hfu_nthw *ptr = hfu_nthw_new();
-		hfu_nthw_init(ptr, p_fpga, physical_adapter_no);
+	if (nthw_hfu_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct hfu_nthw *ptr = nthw_hfu_new();
+		nthw_hfu_init(ptr, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_hfu_nthw = ptr;
 
 	} else {
@@ -2196,9 +2196,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw RPP_LR */
-	if (rpp_lr_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct rpp_lr_nthw *ptr = rpp_lr_nthw_new();
-		rpp_lr_nthw_init(ptr, p_fpga, physical_adapter_no);
+	if (nthw_rpp_lr_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct rpp_lr_nthw *ptr = nthw_rpp_lr_new();
+		nthw_rpp_lr_init(ptr, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_rpp_lr_nthw = ptr;
 
 	} else {
@@ -2206,9 +2206,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw TX_CPY */
-	if (tx_cpy_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct tx_cpy_nthw *ptr = tx_cpy_nthw_new();
-		tx_cpy_nthw_init(ptr, p_fpga, physical_adapter_no);
+	if (nthw_tx_cpy_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct tx_cpy_nthw *ptr = nthw_tx_cpy_new();
+		nthw_tx_cpy_init(ptr, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_tx_cpy_nthw = ptr;
 
 	} else {
@@ -2216,9 +2216,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw CSU */
-	if (csu_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct csu_nthw *ptr = csu_nthw_new();
-		csu_nthw_init(ptr, p_fpga, physical_adapter_no);
+	if (nthw_csu_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct csu_nthw *ptr = nthw_csu_new();
+		nthw_csu_init(ptr, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_csu_nthw = ptr;
 
 	} else {
@@ -2226,9 +2226,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw TX_INS */
-	if (tx_ins_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct tx_ins_nthw *ptr = tx_ins_nthw_new();
-		tx_ins_nthw_init(ptr, p_fpga, physical_adapter_no);
+	if (nthw_tx_ins_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct tx_ins_nthw *ptr = nthw_tx_ins_new();
+		nthw_tx_ins_init(ptr, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_tx_ins_nthw = ptr;
 
 	} else {
@@ -2236,9 +2236,9 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	}
 
 	/* Init nthw TX_RPL */
-	if (tx_rpl_nthw_init(NULL, p_fpga, physical_adapter_no) == 0) {
-		struct tx_rpl_nthw *ptr = tx_rpl_nthw_new();
-		tx_rpl_nthw_init(ptr, p_fpga, physical_adapter_no);
+	if (nthw_tx_rpl_init(NULL, p_fpga, physical_adapter_no) == 0) {
+		struct tx_rpl_nthw *ptr = nthw_tx_rpl_new();
+		nthw_tx_rpl_init(ptr, p_fpga, physical_adapter_no);
 		be_devs[physical_adapter_no].p_tx_rpl_nthw = ptr;
 
 	} else {
@@ -2254,20 +2254,20 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 static void bin_flow_backend_done(void *dev)
 {
 	struct backend_dev_s *be_dev = (struct backend_dev_s *)dev;
-	info_nthw_delete(be_dev->p_info_nthw);
-	cat_nthw_delete(be_dev->p_cat_nthw);
-	km_nthw_delete(be_dev->p_km_nthw);
-	flm_nthw_delete(be_dev->p_flm_nthw);
-	hsh_nthw_delete(be_dev->p_hsh_nthw);
-	qsl_nthw_delete(be_dev->p_qsl_nthw);
-	slc_lr_nthw_delete(be_dev->p_slc_lr_nthw);
-	pdb_nthw_delete(be_dev->p_pdb_nthw);
-	csu_nthw_delete(be_dev->p_csu_nthw);
-	hfu_nthw_delete(be_dev->p_hfu_nthw);
-	rpp_lr_nthw_delete(be_dev->p_rpp_lr_nthw);
-	tx_cpy_nthw_delete(be_dev->p_tx_cpy_nthw);
-	tx_ins_nthw_delete(be_dev->p_tx_ins_nthw);
-	tx_rpl_nthw_delete(be_dev->p_tx_rpl_nthw);
+	nthw_info_delete(be_dev->p_info_nthw);
+	nthw_cat_delete(be_dev->p_cat_nthw);
+	nthw_km_delete(be_dev->p_km_nthw);
+	nthw_flm_delete(be_dev->p_flm_nthw);
+	nthw_hsh_delete(be_dev->p_hsh_nthw);
+	nthw_qsl_delete(be_dev->p_qsl_nthw);
+	nthw_slc_lr_delete(be_dev->p_slc_lr_nthw);
+	nthw_pdb_delete(be_dev->p_pdb_nthw);
+	nthw_csu_delete(be_dev->p_csu_nthw);
+	nthw_hfu_delete(be_dev->p_hfu_nthw);
+	nthw_rpp_lr_delete(be_dev->p_rpp_lr_nthw);
+	nthw_tx_cpy_delete(be_dev->p_tx_cpy_nthw);
+	nthw_tx_ins_delete(be_dev->p_tx_ins_nthw);
+	nthw_tx_rpl_delete(be_dev->p_tx_rpl_nthw);
 }
 
 static const struct flow_backend_ops ops = {
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
index d60dae6912..bc3c9ed8a7 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
@@ -13,7 +13,7 @@
 
 #include "flow_nthw_cat.h"
 
-struct cat_nthw *cat_nthw_new(void)
+struct cat_nthw *nthw_cat_new(void)
 {
 	struct cat_nthw *p = malloc(sizeof(struct cat_nthw));
 
@@ -23,7 +23,7 @@ struct cat_nthw *cat_nthw_new(void)
 	return p;
 }
 
-void cat_nthw_delete(struct cat_nthw *p)
+void nthw_cat_delete(struct cat_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -31,12 +31,12 @@ void cat_nthw_delete(struct cat_nthw *p)
 	}
 }
 
-void cat_nthw_set_debug_mode(struct cat_nthw *p, unsigned int n_debug_mode)
+void nthw_cat_set_debug_mode(struct cat_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_cat, n_debug_mode);
 }
 
-int cat_nthw_init(struct cat_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_cat_init(struct cat_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_CAT, n_instance);
@@ -284,586 +284,586 @@ int cat_nthw_init(struct cat_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 }
 
 /* CFN */
-void cat_nthw_cfn_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_select(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_addr, val);
 }
 
-void cat_nthw_cfn_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_cnt, val);
 }
 
-void cat_nthw_cfn_enable(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_enable(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_enable, val);
 }
 
-void cat_nthw_cfn_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_inv, val);
 }
 
-void cat_nthw_cfn_ptc_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_inv, val);
 }
 
-void cat_nthw_cfn_ptc_isl(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_isl(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_isl, val);
 }
 
-void cat_nthw_cfn_ptc_mac(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_mac(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_mac, val);
 }
 
-void cat_nthw_cfn_ptc_l2(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_l2(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_l2, val);
 }
 
-void cat_nthw_cfn_ptc_vn_tag(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_vn_tag(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_vn_tag, val);
 }
 
-void cat_nthw_cfn_ptc_vlan(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_vlan(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_vlan, val);
 }
 
-void cat_nthw_cfn_ptc_mpls(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_mpls(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_mpls, val);
 }
 
-void cat_nthw_cfn_ptc_l3(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_l3(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_l3, val);
 }
 
-void cat_nthw_cfn_ptc_frag(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_frag(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_frag, val);
 }
 
-void cat_nthw_cfn_ptc_ip_prot(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_ip_prot(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_ip_prot, val);
 }
 
-void cat_nthw_cfn_ptc_l4(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_l4(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_l4, val);
 }
 
-void cat_nthw_cfn_ptc_tunnel(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_tunnel(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_tunnel, val);
 }
 
-void cat_nthw_cfn_ptc_tnl_l2(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_tnl_l2(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_tnl_l2, val);
 }
 
-void cat_nthw_cfn_ptc_tnl_vlan(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_tnl_vlan(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_tnl_vlan, val);
 }
 
-void cat_nthw_cfn_ptc_tnl_mpls(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_tnl_mpls(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_tnl_mpls, val);
 }
 
-void cat_nthw_cfn_ptc_tnl_l3(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_tnl_l3(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_tnl_l3, val);
 }
 
-void cat_nthw_cfn_ptc_tnl_frag(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_tnl_frag(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_tnl_frag, val);
 }
 
-void cat_nthw_cfn_ptc_tnl_ip_prot(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_tnl_ip_prot(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_tnl_ip_prot, val);
 }
 
-void cat_nthw_cfn_ptc_tnl_l4(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_tnl_l4(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_ptc_tnl_l4, val);
 }
 
-void cat_nthw_cfn_ptc_cfp(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_ptc_cfp(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cfn_data_ptc_cfp);
 	nthw_field_set_val32(p->mp_cfn_data_ptc_cfp, val);
 }
 
-void cat_nthw_cfn_err_l3_cs(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_l3_cs(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cfn_data_err_l3_cs);
 	nthw_field_set_val32(p->mp_cfn_data_err_l3_cs, val);
 }
 
-void cat_nthw_cfn_err_l4_cs(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_l4_cs(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cfn_data_err_l4_cs);
 	nthw_field_set_val32(p->mp_cfn_data_err_l4_cs, val);
 }
 
-void cat_nthw_cfn_err_tnl_l3_cs(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_tnl_l3_cs(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cfn_data_err_tnl_l3_cs);
 	nthw_field_set_val32(p->mp_cfn_data_err_tnl_l3_cs, val);
 }
 
-void cat_nthw_cfn_err_tnl_l4_cs(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_tnl_l4_cs(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cfn_data_err_tnl_l4_cs);
 	nthw_field_set_val32(p->mp_cfn_data_err_tnl_l4_cs, val);
 }
 
-void cat_nthw_cfn_err_ttl_exp(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_ttl_exp(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cfn_data_err_ttl_exp);
 	nthw_field_set_val32(p->mp_cfn_data_err_ttl_exp, val);
 }
 
-void cat_nthw_cfn_err_tnl_ttl_exp(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_tnl_ttl_exp(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cfn_data_err_tnl_ttl_exp);
 	nthw_field_set_val32(p->mp_cfn_data_err_tnl_ttl_exp, val);
 }
 
-void cat_nthw_cfn_err_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_err_inv, val);
 }
 
-void cat_nthw_cfn_err_cv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_cv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_err_cv, val);
 }
 
-void cat_nthw_cfn_err_fcs(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_fcs(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_err_fcs, val);
 }
 
-void cat_nthw_cfn_err_trunc(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_err_trunc(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_err_trunc, val);
 }
 
-void cat_nthw_cfn_mac_port(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_mac_port(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_mac_port, val);
 }
 
-void cat_nthw_cfn_pm_cmp(const struct cat_nthw *p, const uint32_t *val)
+void nthw_cat_cfn_pm_cmp(const struct cat_nthw *p, const uint32_t *val)
 {
 	nthw_field_set_val(p->mp_cfn_data_pm_cmp, val, p->mp_cfn_data_pm_cmp->mn_words);
 }
 
-void cat_nthw_cfn_pm_dct(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_pm_dct(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_pm_dct, val);
 }
 
-void cat_nthw_cfn_pm_ext_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_pm_ext_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_pm_ext_inv, val);
 }
 
-void cat_nthw_cfn_pm_cmb(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_pm_cmb(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_pm_cmb, val);
 }
 
-void cat_nthw_cfn_pm_and_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_pm_and_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_pm_and_inv, val);
 }
 
-void cat_nthw_cfn_pm_or_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_pm_or_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_pm_or_inv, val);
 }
 
-void cat_nthw_cfn_pm_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_pm_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_pm_inv, val);
 }
 
-void cat_nthw_cfn_lc(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_lc(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_lc, val);
 }
 
-void cat_nthw_cfn_lc_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_lc_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_lc_inv, val);
 }
 
-void cat_nthw_cfn_km0_or(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_km0_or(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cfn_data_km0_or, val);
 }
 
-void cat_nthw_cfn_km1_or(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cfn_km1_or(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cfn_data_km1_or);
 	nthw_field_set_val32(p->mp_cfn_data_km1_or, val);
 }
 
-void cat_nthw_cfn_flush(const struct cat_nthw *p)
+void nthw_cat_cfn_flush(const struct cat_nthw *p)
 {
 	nthw_register_flush(p->mp_cfn_ctrl, 1);
 	nthw_register_flush(p->mp_cfn_data, 1);
 }
 
-void cat_nthw_kce_select(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_kce_select(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_kce_addr[index], val);
 }
 
-void cat_nthw_kce_cnt(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_kce_cnt(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_kce_cnt[index], val);
 }
 
-void cat_nthw_kce_enable(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_kce_enable(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_kce_data_enable[index], val);
 }
 
-void cat_nthw_kce_flush(const struct cat_nthw *p, int index)
+void nthw_cat_kce_flush(const struct cat_nthw *p, int index)
 {
 	nthw_register_flush(p->mp_kce_ctrl[index], 1);
 	nthw_register_flush(p->mp_kce_data[index], 1);
 }
 
-void cat_nthw_kcs_select(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_kcs_select(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_kcs_addr[index], val);
 }
 
-void cat_nthw_kcs_cnt(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_kcs_cnt(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_kcs_cnt[index], val);
 }
 
-void cat_nthw_kcs_category(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_kcs_category(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_kcs_data_category[index], val);
 }
 
-void cat_nthw_kcs_flush(const struct cat_nthw *p, int index)
+void nthw_cat_kcs_flush(const struct cat_nthw *p, int index)
 {
 	nthw_register_flush(p->mp_kcs_ctrl[index], 1);
 	nthw_register_flush(p->mp_kcs_data[index], 1);
 }
 
-void cat_nthw_fte_select(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_fte_select(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_fte_addr[index], val);
 }
 
-void cat_nthw_fte_cnt(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_fte_cnt(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_fte_cnt[index], val);
 }
 
-void cat_nthw_fte_enable(const struct cat_nthw *p, int index, uint32_t val)
+void nthw_cat_fte_enable(const struct cat_nthw *p, int index, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_fte_data_enable[index], val);
 }
 
-void cat_nthw_fte_flush(const struct cat_nthw *p, int index)
+void nthw_cat_fte_flush(const struct cat_nthw *p, int index)
 {
 	nthw_register_flush(p->mp_fte_ctrl[index], 1);
 	nthw_register_flush(p->mp_fte_data[index], 1);
 }
 
-void cat_nthw_cte_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_select(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_addr, val);
 }
 
-void cat_nthw_cte_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_cnt, val);
 }
 
-void cat_nthw_cte_enable_col(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_col(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_data_col, val);
 }
 
-void cat_nthw_cte_enable_cor(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_cor(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_data_cor, val);
 }
 
-void cat_nthw_cte_enable_hsh(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_hsh(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_data_hsh, val);
 }
 
-void cat_nthw_cte_enable_qsl(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_qsl(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_data_qsl, val);
 }
 
-void cat_nthw_cte_enable_ipf(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_ipf(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_data_ipf, val);
 }
 
-void cat_nthw_cte_enable_slc(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_slc(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_data_slc, val);
 }
 
-void cat_nthw_cte_enable_pdb(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_pdb(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cte_data_pdb, val);
 }
 
-void cat_nthw_cte_enable_msk(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_msk(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cte_data_msk);
 	nthw_field_set_val32(p->mp_cte_data_msk, val);
 }
 
-void cat_nthw_cte_enable_hst(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_hst(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cte_data_hst);
 	nthw_field_set_val32(p->mp_cte_data_hst, val);
 }
 
-void cat_nthw_cte_enable_epp(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_epp(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cte_data_epp);
 	nthw_field_set_val32(p->mp_cte_data_epp, val);
 }
 
-void cat_nthw_cte_enable_tpe(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cte_enable_tpe(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_cte_data_tpe);
 	nthw_field_set_val32(p->mp_cte_data_tpe, val);
 }
 
-void cat_nthw_cte_flush(const struct cat_nthw *p)
+void nthw_cat_cte_flush(const struct cat_nthw *p)
 {
 	nthw_register_flush(p->mp_cte_ctrl, 1);
 	nthw_register_flush(p->mp_cte_data, 1);
 }
 
-void cat_nthw_cts_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cts_select(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cts_addr, val);
 }
 
-void cat_nthw_cts_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cts_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cts_cnt, val);
 }
 
-void cat_nthw_cts_cat_a(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cts_cat_a(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cts_data_cat_a, val);
 }
 
-void cat_nthw_cts_cat_b(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cts_cat_b(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cts_data_cat_b, val);
 }
 
-void cat_nthw_cts_flush(const struct cat_nthw *p)
+void nthw_cat_cts_flush(const struct cat_nthw *p)
 {
 	nthw_register_flush(p->mp_cts_ctrl, 1);
 	nthw_register_flush(p->mp_cts_data, 1);
 }
 
-void cat_nthw_cot_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cot_select(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cot_addr, val);
 }
 
-void cat_nthw_cot_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cot_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cot_cnt, val);
 }
 
-void cat_nthw_cot_color(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cot_color(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cot_data_color, val);
 }
 
-void cat_nthw_cot_km(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cot_km(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cot_data_km, val);
 }
 
-void cat_nthw_cot_flush(const struct cat_nthw *p)
+void nthw_cat_cot_flush(const struct cat_nthw *p)
 {
 	nthw_register_flush(p->mp_cot_ctrl, 1);
 	nthw_register_flush(p->mp_cot_data, 1);
 }
 
-void cat_nthw_cct_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cct_select(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cct_addr, val);
 }
 
-void cat_nthw_cct_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cct_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cct_cnt, val);
 }
 
-void cat_nthw_cct_color(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cct_color(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cct_data_color, val);
 }
 
-void cat_nthw_cct_km(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_cct_km(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cct_data_km, val);
 }
 
-void cat_nthw_cct_flush(const struct cat_nthw *p)
+void nthw_cat_cct_flush(const struct cat_nthw *p)
 {
 	nthw_register_flush(p->mp_cct_ctrl, 1);
 	nthw_register_flush(p->mp_cct_data, 1);
 }
 
-void cat_nthw_exo_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_exo_select(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_exo_addr, val);
 }
 
-void cat_nthw_exo_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_exo_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_exo_cnt, val);
 }
 
-void cat_nthw_exo_dyn(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_exo_dyn(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_exo_data_dyn, val);
 }
 
-void cat_nthw_exo_ofs(const struct cat_nthw *p, int32_t val)
+void nthw_cat_exo_ofs(const struct cat_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_exo_data_ofs, val);
 }
 
-void cat_nthw_exo_flush(const struct cat_nthw *p)
+void nthw_cat_exo_flush(const struct cat_nthw *p)
 {
 	nthw_register_flush(p->mp_exo_ctrl, 1);
 	nthw_register_flush(p->mp_exo_data, 1);
 }
 
-void cat_nthw_rck_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_rck_select(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rck_addr, val);
 }
 
-void cat_nthw_rck_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_rck_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rck_cnt, val);
 }
 
-void cat_nthw_rck_data(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_rck_data(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_register_set_val(p->mp_rck_data, &val, 1);
 	nthw_register_make_dirty(p->mp_rck_data);
 }
 
-void cat_nthw_rck_flush(const struct cat_nthw *p)
+void nthw_cat_rck_flush(const struct cat_nthw *p)
 {
 	nthw_register_flush(p->mp_rck_ctrl, 1);
 	nthw_register_flush(p->mp_rck_data, 1);
 }
 
-void cat_nthw_len_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_len_select(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_len_addr, val);
 }
 
-void cat_nthw_len_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_len_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_len_cnt, val);
 }
 
-void cat_nthw_len_lower(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_len_lower(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_len_data_lower, val);
 }
 
-void cat_nthw_len_upper(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_len_upper(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_len_data_upper, val);
 }
 
-void cat_nthw_len_dyn1(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_len_dyn1(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_len_data_dyn1, val);
 }
 
-void cat_nthw_len_dyn2(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_len_dyn2(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_len_data_dyn2, val);
 }
 
-void cat_nthw_len_inv(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_len_inv(const struct cat_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_len_data_inv, val);
 }
 
-void cat_nthw_len_flush(const struct cat_nthw *p)
+void nthw_cat_len_flush(const struct cat_nthw *p)
 {
 	nthw_register_flush(p->mp_len_ctrl, 1);
 	nthw_register_flush(p->mp_len_data, 1);
 }
 
-void cat_nthw_kcc_select(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_kcc_select(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_kcc_addr);
 	nthw_field_set_val32(p->mp_kcc_addr, val);
 }
 
-void cat_nthw_kcc_cnt(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_kcc_cnt(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_kcc_cnt);
 	nthw_field_set_val32(p->mp_kcc_cnt, val);
 }
 
-void cat_nthw_kcc_key(const struct cat_nthw *p, uint32_t *val)
+void nthw_cat_kcc_key(const struct cat_nthw *p, uint32_t *val)
 {
 	RTE_ASSERT(p->mp_kcc_data_key);
 	nthw_field_set_val(p->mp_kcc_data_key, val, 2);
 }
 
-void cat_nthw_kcc_category(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_kcc_category(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_kcc_data_category);
 	nthw_field_set_val32(p->mp_kcc_data_category, val);
 }
 
-void cat_nthw_kcc_id(const struct cat_nthw *p, uint32_t val)
+void nthw_cat_kcc_id(const struct cat_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_kcc_data_id);
 	nthw_field_set_val32(p->mp_kcc_data_id, val);
 }
 
-void cat_nthw_kcc_flush(const struct cat_nthw *p)
+void nthw_cat_kcc_flush(const struct cat_nthw *p)
 {
 	RTE_ASSERT(p->mp_kcc_ctrl);
 	RTE_ASSERT(p->mp_kcc_data);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h
index 29f9a332f1..13dddfd96e 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h
@@ -14,136 +14,136 @@ struct cat_nthw;
 
 typedef struct cat_nthw cat_nthw_t;
 
-struct cat_nthw *cat_nthw_new(void);
-void cat_nthw_delete(struct cat_nthw *p);
-int cat_nthw_init(struct cat_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct cat_nthw *nthw_cat_new(void);
+void nthw_cat_delete(struct cat_nthw *p);
+int nthw_cat_init(struct cat_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int cat_nthw_setup(struct cat_nthw *p, int n_idx, int n_idx_cnt);
-void cat_nthw_set_debug_mode(struct cat_nthw *p, unsigned int n_debug_mode);
+void nthw_cat_set_debug_mode(struct cat_nthw *p, unsigned int n_debug_mode);
 
 /* CFN */
-void cat_nthw_cfn_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_enable(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_isl(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_cfp(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_mac(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_l2(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_vn_tag(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_vlan(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_mpls(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_l3(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_frag(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_ip_prot(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_l4(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_tunnel(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_tnl_l2(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_tnl_vlan(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_tnl_mpls(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_tnl_l3(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_tnl_frag(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_tnl_ip_prot(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_ptc_tnl_l4(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_cv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_fcs(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_trunc(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_l3_cs(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_l4_cs(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_tnl_l3_cs(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_tnl_l4_cs(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_ttl_exp(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_err_tnl_ttl_exp(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_mac_port(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_pm_cmp(const struct cat_nthw *p, const uint32_t *val);
-void cat_nthw_cfn_pm_dct(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_pm_ext_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_pm_cmb(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_pm_and_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_pm_or_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_pm_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_lc(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_lc_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_km0_or(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_km1_or(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cfn_flush(const struct cat_nthw *p);
+void nthw_cat_cfn_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_enable(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_isl(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_cfp(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_mac(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_l2(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_vn_tag(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_vlan(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_mpls(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_l3(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_frag(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_ip_prot(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_l4(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_tunnel(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_tnl_l2(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_tnl_vlan(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_tnl_mpls(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_tnl_l3(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_tnl_frag(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_tnl_ip_prot(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_ptc_tnl_l4(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_cv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_fcs(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_trunc(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_l3_cs(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_l4_cs(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_tnl_l3_cs(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_tnl_l4_cs(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_ttl_exp(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_err_tnl_ttl_exp(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_mac_port(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_pm_cmp(const struct cat_nthw *p, const uint32_t *val);
+void nthw_cat_cfn_pm_dct(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_pm_ext_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_pm_cmb(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_pm_and_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_pm_or_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_pm_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_lc(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_lc_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_km0_or(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_km1_or(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cfn_flush(const struct cat_nthw *p);
 /* KCE 0/1 */
-void cat_nthw_kce_select(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_kce_cnt(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_kce_enable(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_kce_flush(const struct cat_nthw *p, int index);
+void nthw_cat_kce_select(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_kce_cnt(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_kce_enable(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_kce_flush(const struct cat_nthw *p, int index);
 /* KCS 0/1 */
-void cat_nthw_kcs_select(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_kcs_cnt(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_kcs_category(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_kcs_flush(const struct cat_nthw *p, int index);
+void nthw_cat_kcs_select(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_kcs_cnt(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_kcs_category(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_kcs_flush(const struct cat_nthw *p, int index);
 /* FTE 0/1 */
-void cat_nthw_fte_select(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_fte_cnt(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_fte_enable(const struct cat_nthw *p, int index, uint32_t val);
-void cat_nthw_fte_flush(const struct cat_nthw *p, int index);
+void nthw_cat_fte_select(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_fte_cnt(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_fte_enable(const struct cat_nthw *p, int index, uint32_t val);
+void nthw_cat_fte_flush(const struct cat_nthw *p, int index);
 /* CTE */
-void cat_nthw_cte_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_col(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_cor(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_hsh(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_qsl(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_ipf(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_slc(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_pdb(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_msk(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_hst(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_epp(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_enable_tpe(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cte_flush(const struct cat_nthw *p);
+void nthw_cat_cte_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_col(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_cor(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_hsh(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_qsl(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_ipf(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_slc(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_pdb(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_msk(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_hst(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_epp(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_enable_tpe(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cte_flush(const struct cat_nthw *p);
 /* CTS */
-void cat_nthw_cts_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cts_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cts_flush(const struct cat_nthw *p);
-void cat_nthw_cts_cat_a(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cts_cat_b(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cts_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cts_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cts_flush(const struct cat_nthw *p);
+void nthw_cat_cts_cat_a(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cts_cat_b(const struct cat_nthw *p, uint32_t val);
 /* COT */
-void cat_nthw_cot_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cot_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cot_color(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cot_km(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cot_flush(const struct cat_nthw *p);
+void nthw_cat_cot_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cot_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cot_color(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cot_km(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cot_flush(const struct cat_nthw *p);
 /* CCT */
-void cat_nthw_cct_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cct_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cct_color(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cct_km(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_cct_flush(const struct cat_nthw *p);
+void nthw_cat_cct_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cct_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cct_color(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cct_km(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_cct_flush(const struct cat_nthw *p);
 /* EXO */
-void cat_nthw_exo_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_exo_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_exo_dyn(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_exo_ofs(const struct cat_nthw *p, int32_t val);
-void cat_nthw_exo_flush(const struct cat_nthw *p);
+void nthw_cat_exo_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_exo_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_exo_dyn(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_exo_ofs(const struct cat_nthw *p, int32_t val);
+void nthw_cat_exo_flush(const struct cat_nthw *p);
 /* RCK */
-void cat_nthw_rck_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_rck_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_rck_data(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_rck_flush(const struct cat_nthw *p);
+void nthw_cat_rck_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_rck_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_rck_data(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_rck_flush(const struct cat_nthw *p);
 /* LEN */
-void cat_nthw_len_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_len_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_len_lower(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_len_upper(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_len_dyn1(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_len_dyn2(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_len_inv(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_len_flush(const struct cat_nthw *p);
+void nthw_cat_len_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_len_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_len_lower(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_len_upper(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_len_dyn1(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_len_dyn2(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_len_inv(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_len_flush(const struct cat_nthw *p);
 /* KCC */
-void cat_nthw_kcc_select(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_kcc_cnt(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_kcc_key(const struct cat_nthw *p, uint32_t *val);
-void cat_nthw_kcc_category(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_kcc_id(const struct cat_nthw *p, uint32_t val);
-void cat_nthw_kcc_flush(const struct cat_nthw *p);
+void nthw_cat_kcc_select(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_kcc_cnt(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_kcc_key(const struct cat_nthw *p, uint32_t *val);
+void nthw_cat_kcc_category(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_kcc_id(const struct cat_nthw *p, uint32_t val);
+void nthw_cat_kcc_flush(const struct cat_nthw *p);
 
 struct cat_nthw {
 	uint8_t m_physical_adapter_no;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
index 4ad169b943..6054b611cd 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
@@ -12,12 +12,12 @@
 
 #include "flow_nthw_csu.h"
 
-void csu_nthw_set_debug_mode(struct csu_nthw *p, unsigned int n_debug_mode)
+void nthw_csu_set_debug_mode(struct csu_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_csu, n_debug_mode);
 }
 
-struct csu_nthw *csu_nthw_new(void)
+struct csu_nthw *nthw_csu_new(void)
 {
 	struct csu_nthw *p = malloc(sizeof(struct csu_nthw));
 
@@ -27,7 +27,7 @@ struct csu_nthw *csu_nthw_new(void)
 	return p;
 }
 
-void csu_nthw_delete(struct csu_nthw *p)
+void nthw_csu_delete(struct csu_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -35,7 +35,7 @@ void csu_nthw_delete(struct csu_nthw *p)
 	}
 }
 
-int csu_nthw_init(struct csu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_csu_init(struct csu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_CSU, n_instance);
@@ -66,17 +66,17 @@ int csu_nthw_init(struct csu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void csu_nthw_rcp_select(const struct csu_nthw *p, uint32_t val)
+void nthw_csu_rcp_select(const struct csu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_ctrl_adr, val);
 }
 
-void csu_nthw_rcp_cnt(const struct csu_nthw *p, uint32_t val)
+void nthw_csu_rcp_cnt(const struct csu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_ctrl_cnt, val);
 }
 
-void csu_nthw_rcp_outer_l3_cmd(const struct csu_nthw *p, uint32_t val)
+void nthw_csu_rcp_outer_l3_cmd(const struct csu_nthw *p, uint32_t val)
 {
 	/*
 	 * Select L3 calc method for outer layer3.
@@ -88,7 +88,7 @@ void csu_nthw_rcp_outer_l3_cmd(const struct csu_nthw *p, uint32_t val)
 	nthw_field_set_val32(p->mp_rcp_data_ol3_cmd, val);
 }
 
-void csu_nthw_rcp_outer_l4_cmd(const struct csu_nthw *p, uint32_t val)
+void nthw_csu_rcp_outer_l4_cmd(const struct csu_nthw *p, uint32_t val)
 {
 	/*
 	 * Select L4 calc method for outer layer4.
@@ -105,7 +105,7 @@ void csu_nthw_rcp_outer_l4_cmd(const struct csu_nthw *p, uint32_t val)
 	nthw_field_set_val32(p->mp_rcp_data_ol4_cmd, val);
 }
 
-void csu_nthw_rcp_inner_l3_cmd(const struct csu_nthw *p, uint32_t val)
+void nthw_csu_rcp_inner_l3_cmd(const struct csu_nthw *p, uint32_t val)
 {
 	/*
 	 * Select L3 calc method for inner layer3 (tunneled).
@@ -117,7 +117,7 @@ void csu_nthw_rcp_inner_l3_cmd(const struct csu_nthw *p, uint32_t val)
 	nthw_field_set_val32(p->mp_rcp_data_il3_cmd, val);
 }
 
-void csu_nthw_rcp_inner_l4_cmd(const struct csu_nthw *p, uint32_t val)
+void nthw_csu_rcp_inner_l4_cmd(const struct csu_nthw *p, uint32_t val)
 {
 	/*
 	 * Select L4 calc method for inner layer4 (tunneled).
@@ -134,7 +134,7 @@ void csu_nthw_rcp_inner_l4_cmd(const struct csu_nthw *p, uint32_t val)
 	nthw_field_set_val32(p->mp_rcp_data_il4_cmd, val);
 }
 
-void csu_nthw_rcp_flush(const struct csu_nthw *p)
+void nthw_csu_rcp_flush(const struct csu_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h
index 91a0926318..0f94761d41 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h
@@ -26,19 +26,19 @@ struct csu_nthw {
 	nthw_field_t *mp_rcp_data_il4_cmd;
 };
 
-struct csu_nthw *csu_nthw_new(void);
-void csu_nthw_delete(struct csu_nthw *p);
-int csu_nthw_init(struct csu_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct csu_nthw *nthw_csu_new(void);
+void nthw_csu_delete(struct csu_nthw *p);
+int nthw_csu_init(struct csu_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int csu_nthw_setup(struct csu_nthw *p, int n_idx, int n_idx_cnt);
-void csu_nthw_set_debug_mode(struct csu_nthw *p, unsigned int n_debug_mode);
-
-void csu_nthw_rcp_select(const struct csu_nthw *p, uint32_t val);
-void csu_nthw_rcp_cnt(const struct csu_nthw *p, uint32_t val);
-void csu_nthw_rcp_outer_l3_cmd(const struct csu_nthw *p, uint32_t val);
-void csu_nthw_rcp_outer_l4_cmd(const struct csu_nthw *p, uint32_t val);
-void csu_nthw_rcp_inner_l3_cmd(const struct csu_nthw *p, uint32_t val);
-void csu_nthw_rcp_inner_l4_cmd(const struct csu_nthw *p, uint32_t val);
-void csu_nthw_rcp_flush(const struct csu_nthw *p);
+void nthw_csu_set_debug_mode(struct csu_nthw *p, unsigned int n_debug_mode);
+
+void nthw_csu_rcp_select(const struct csu_nthw *p, uint32_t val);
+void nthw_csu_rcp_cnt(const struct csu_nthw *p, uint32_t val);
+void nthw_csu_rcp_outer_l3_cmd(const struct csu_nthw *p, uint32_t val);
+void nthw_csu_rcp_outer_l4_cmd(const struct csu_nthw *p, uint32_t val);
+void nthw_csu_rcp_inner_l3_cmd(const struct csu_nthw *p, uint32_t val);
+void nthw_csu_rcp_inner_l4_cmd(const struct csu_nthw *p, uint32_t val);
+void nthw_csu_rcp_flush(const struct csu_nthw *p);
 
 #endif	/* _FLOW_NTHW_CSU_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
index 372f735c2b..0fa6d918ae 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
@@ -15,7 +15,7 @@
 
 #include "flow_nthw_flm.h"
 
-struct flm_nthw *flm_nthw_new(void)
+struct flm_nthw *nthw_flm_new(void)
 {
 	struct flm_nthw *p = malloc(sizeof(struct flm_nthw));
 
@@ -25,7 +25,7 @@ struct flm_nthw *flm_nthw_new(void)
 	return p;
 }
 
-void flm_nthw_delete(struct flm_nthw *p)
+void nthw_flm_delete(struct flm_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -33,12 +33,12 @@ void flm_nthw_delete(struct flm_nthw *p)
 	}
 }
 
-void flm_nthw_set_debug_mode(struct flm_nthw *p, unsigned int n_debug_mode)
+void nthw_flm_set_debug_mode(struct flm_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_flm, n_debug_mode);
 }
 
-int flm_nthw_init(struct flm_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_flm_init(struct flm_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_FLM, n_instance);
@@ -270,94 +270,94 @@ int flm_nthw_init(struct flm_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void flm_nthw_control_enable(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_enable(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_enable, val);
 }
 
-void flm_nthw_control_init(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_init(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_init, val);
 }
 
-void flm_nthw_control_lds(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_lds(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_lds, val);
 }
 
-void flm_nthw_control_lfs(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_lfs(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_lfs, val);
 }
 
-void flm_nthw_control_lis(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_lis(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_lis, val);
 }
 
-void flm_nthw_control_uds(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_uds(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_uds, val);
 }
 
-void flm_nthw_control_uis(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_uis(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_uis, val);
 }
 
-void flm_nthw_control_rds(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_rds(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_rds, val);
 }
 
-void flm_nthw_control_ris(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_ris(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_ris, val);
 }
 
-void flm_nthw_control_pds(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_pds(const struct flm_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_control_pds);
 	nthw_field_set_val32(p->mp_control_pds, val);
 }
 
-void flm_nthw_control_pis(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_pis(const struct flm_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_control_pis);
 	nthw_field_set_val32(p->mp_control_pis, val);
 }
 
-void flm_nthw_control_crcwr(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_crcwr(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_crcwr, val);
 }
 
-void flm_nthw_control_crcrd(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_crcrd(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_crcrd, val);
 }
 
-void flm_nthw_control_rbl(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_rbl(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_rbl, val);
 }
 
-void flm_nthw_control_eab(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_eab(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_eab, val);
 }
 
-void flm_nthw_control_split_sdram_usage(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_control_split_sdram_usage(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_control_split_sdram_usage, val);
 }
 
-void flm_nthw_control_flush(const struct flm_nthw *p)
+void nthw_flm_control_flush(const struct flm_nthw *p)
 {
 	nthw_register_flush(p->mp_control, 1);
 }
 
-void flm_nthw_status_calib_success(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_calib_success(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get) {
 		uint32_t w = nthw_field_get_bit_width(p->mp_status_calib_success);
@@ -371,25 +371,25 @@ void flm_nthw_status_calib_success(const struct flm_nthw *p, uint32_t *val, int
 	}
 }
 
-void flm_nthw_status_calib_fail(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_calib_fail(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_status_calib_fail);
 }
 
-void flm_nthw_status_initdone(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_initdone(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_status_initdone);
 }
 
-void flm_nthw_status_idle(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_idle(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_status_idle);
 }
 
-void flm_nthw_status_critical(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_critical(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_status_critical);
@@ -398,7 +398,7 @@ void flm_nthw_status_critical(const struct flm_nthw *p, uint32_t *val, int get)
 		nthw_field_set_val32(p->mp_status_critical, *val);
 }
 
-void flm_nthw_status_panic(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_panic(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_status_panic);
@@ -407,7 +407,7 @@ void flm_nthw_status_panic(const struct flm_nthw *p, uint32_t *val, int get)
 		nthw_field_set_val32(p->mp_status_panic, *val);
 }
 
-void flm_nthw_status_crcerr(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_crcerr(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_status_crcerr);
@@ -416,13 +416,13 @@ void flm_nthw_status_crcerr(const struct flm_nthw *p, uint32_t *val, int get)
 		nthw_field_set_val32(p->mp_status_crcerr, *val);
 }
 
-void flm_nthw_status_eft_bp(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_eft_bp(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_status_eft_bp);
 }
 
-void flm_nthw_status_cache_buf_crit(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_status_cache_buf_crit(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_status_cache_buf_critical);
@@ -431,246 +431,246 @@ void flm_nthw_status_cache_buf_crit(const struct flm_nthw *p, uint32_t *val, int
 		nthw_field_set_val32(p->mp_status_cache_buf_critical, *val);
 }
 
-void flm_nthw_status_flush(const struct flm_nthw *p)
+void nthw_flm_status_flush(const struct flm_nthw *p)
 {
 	nthw_register_flush(p->mp_status, 1);
 }
 
-void flm_nthw_status_update(const struct flm_nthw *p)
+void nthw_flm_status_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_status);
 }
 
-void flm_nthw_scan_i(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_scan_i(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_scan_i, val);
 }
 
-void flm_nthw_scan_flush(const struct flm_nthw *p)
+void nthw_flm_scan_flush(const struct flm_nthw *p)
 {
 	nthw_register_flush(p->mp_scan, 1);
 }
 
-void flm_nthw_load_bin(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_load_bin(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_load_bin_bin, val);
 }
 
-void flm_nthw_load_bin_flush(const struct flm_nthw *p)
+void nthw_flm_load_bin_flush(const struct flm_nthw *p)
 {
 	nthw_register_flush(p->mp_load_bin, 1);
 }
 
-void flm_nthw_load_lps_update(const struct flm_nthw *p)
+void nthw_flm_load_lps_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_load_lps);
 }
 
-void flm_nthw_load_lps_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_load_lps_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_load_lps_lps);
 }
 
-void flm_nthw_load_aps_update(const struct flm_nthw *p)
+void nthw_flm_load_aps_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_load_aps);
 }
 
-void flm_nthw_load_aps_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_load_aps_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_load_aps_aps);
 }
 
-void flm_nthw_prio_limit0(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_prio_limit0(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_prio_limit0, val);
 }
 
-void flm_nthw_prio_ft0(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_prio_ft0(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_prio_ft0, val);
 }
 
-void flm_nthw_prio_limit1(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_prio_limit1(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_prio_limit1, val);
 }
 
-void flm_nthw_prio_ft1(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_prio_ft1(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_prio_ft1, val);
 }
 
-void flm_nthw_prio_limit2(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_prio_limit2(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_prio_limit2, val);
 }
 
-void flm_nthw_prio_ft2(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_prio_ft2(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_prio_ft2, val);
 }
 
-void flm_nthw_prio_limit3(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_prio_limit3(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_prio_limit3, val);
 }
 
-void flm_nthw_prio_ft3(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_prio_ft3(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_prio_ft3, val);
 }
 
-void flm_nthw_prio_flush(const struct flm_nthw *p)
+void nthw_flm_prio_flush(const struct flm_nthw *p)
 {
 	nthw_register_flush(p->mp_prio, 1);
 }
 
-void flm_nthw_pst_select(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_pst_select(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_pst_ctrl_adr, val);
 }
 
-void flm_nthw_pst_cnt(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_pst_cnt(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_pst_ctrl_cnt, val);
 }
 
-void flm_nthw_pst_bp(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_pst_bp(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_pst_data_bp, val);
 }
 
-void flm_nthw_pst_pp(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_pst_pp(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_pst_data_pp, val);
 }
 
-void flm_nthw_pst_tp(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_pst_tp(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_pst_data_tp, val);
 }
 
-void flm_nthw_pst_flush(const struct flm_nthw *p)
+void nthw_flm_pst_flush(const struct flm_nthw *p)
 {
 	nthw_register_flush(p->mp_pst_ctrl, 1);
 	nthw_register_flush(p->mp_pst_data, 1);
 }
 
-void flm_nthw_rcp_select(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_select(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_ctrl_adr, val);
 }
 
-void flm_nthw_rcp_cnt(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_cnt(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_ctrl_cnt, val);
 }
 
-void flm_nthw_rcp_lookup(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_lookup(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_lookup, val);
 }
 
-void flm_nthw_rcp_qw0_dyn(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_qw0_dyn(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_dyn, val);
 }
 
-void flm_nthw_rcp_qw0_ofs(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_qw0_ofs(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_ofs, val);
 }
 
-void flm_nthw_rcp_qw0_sel(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_qw0_sel(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_sel, val);
 }
 
-void flm_nthw_rcp_qw4_dyn(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_qw4_dyn(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw4_dyn, val);
 }
 
-void flm_nthw_rcp_qw4_ofs(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_qw4_ofs(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw4_ofs, val);
 }
 
-void flm_nthw_rcp_sw8_dyn(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_sw8_dyn(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw8_dyn, val);
 }
 
-void flm_nthw_rcp_sw8_ofs(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_sw8_ofs(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw8_ofs, val);
 }
 
-void flm_nthw_rcp_sw8_sel(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_sw8_sel(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw8_sel, val);
 }
 
-void flm_nthw_rcp_sw9_dyn(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_sw9_dyn(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw9_dyn, val);
 }
 
-void flm_nthw_rcp_sw9_ofs(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_sw9_ofs(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw9_ofs, val);
 }
 
-void flm_nthw_rcp_mask(const struct flm_nthw *p, const uint32_t *val)
+void nthw_flm_rcp_mask(const struct flm_nthw *p, const uint32_t *val)
 {
 	nthw_field_set_val(p->mp_rcp_data_mask, val, 10);
 }
 
-void flm_nthw_rcp_kid(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_kid(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_kid, val);
 }
 
-void flm_nthw_rcp_opn(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_opn(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_opn, val);
 }
 
-void flm_nthw_rcp_ipn(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_ipn(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ipn, val);
 }
 
-void flm_nthw_rcp_byt_dyn(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_byt_dyn(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_byt_dyn, val);
 }
 
-void flm_nthw_rcp_byt_ofs(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_byt_ofs(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_byt_ofs, val);
 }
 
-void flm_nthw_rcp_txplm(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_txplm(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_txplm, val);
 }
 
-void flm_nthw_rcp_auto_ipv4_mask(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_rcp_auto_ipv4_mask(const struct flm_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_auto_ipv4_mask, val);
 }
 
-void flm_nthw_rcp_flush(const struct flm_nthw *p)
+void nthw_flm_rcp_flush(const struct flm_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
 
-int flm_nthw_buf_ctrl_update(const struct flm_nthw *p, uint32_t *lrn_free, uint32_t *inf_avail,
+int nthw_flm_buf_ctrl_update(const struct flm_nthw *p, uint32_t *lrn_free, uint32_t *inf_avail,
 	uint32_t *sta_avail)
 {
 	int ret = -1;
@@ -708,7 +708,7 @@ int flm_nthw_buf_ctrl_update(const struct flm_nthw *p, uint32_t *lrn_free, uint3
 	return ret;
 }
 
-int flm_nthw_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint32_t records,
+int nthw_flm_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint32_t records,
 	uint32_t words_per_record, uint32_t *handled_records,
 	uint32_t *lrn_free, uint32_t *inf_avail, uint32_t *sta_avail)
 {
@@ -807,7 +807,7 @@ int flm_nthw_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint
 	return 0;
 }
 
-int flm_nthw_inf_sta_data_update(const struct flm_nthw *p, uint32_t *inf_data,
+int nthw_flm_inf_sta_data_update(const struct flm_nthw *p, uint32_t *inf_data,
 	uint32_t inf_word_count, uint32_t *sta_data,
 	uint32_t sta_word_count, uint32_t *lrn_free, uint32_t *inf_avail,
 	uint32_t *sta_avail)
@@ -886,62 +886,62 @@ int flm_nthw_inf_sta_data_update(const struct flm_nthw *p, uint32_t *inf_data,
 	return ret;
 }
 
-void flm_nthw_stat_lrn_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_lrn_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_lrn_done_cnt);
 }
 
-void flm_nthw_stat_lrn_done_update(const struct flm_nthw *p)
+void nthw_flm_stat_lrn_done_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_lrn_done);
 }
 
-void flm_nthw_stat_lrn_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_lrn_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_lrn_ignore_cnt);
 }
 
-void flm_nthw_stat_lrn_ignore_update(const struct flm_nthw *p)
+void nthw_flm_stat_lrn_ignore_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_lrn_ignore);
 }
 
-void flm_nthw_stat_lrn_fail_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_lrn_fail_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_lrn_fail_cnt);
 }
 
-void flm_nthw_stat_lrn_fail_update(const struct flm_nthw *p)
+void nthw_flm_stat_lrn_fail_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_lrn_fail);
 }
 
-void flm_nthw_stat_unl_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_unl_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_unl_done_cnt);
 }
 
-void flm_nthw_stat_unl_done_update(const struct flm_nthw *p)
+void nthw_flm_stat_unl_done_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_unl_done);
 }
 
-void flm_nthw_stat_unl_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_unl_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_unl_ignore_cnt);
 }
 
-void flm_nthw_stat_unl_ignore_update(const struct flm_nthw *p)
+void nthw_flm_stat_unl_ignore_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_unl_ignore);
 }
 
-void flm_nthw_stat_prb_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_prb_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_prb_done_cnt);
 
@@ -949,13 +949,13 @@ void flm_nthw_stat_prb_done_cnt(const struct flm_nthw *p, uint32_t *val, int get
 		*val = nthw_field_get_val32(p->mp_stat_prb_done_cnt);
 }
 
-void flm_nthw_stat_prb_done_update(const struct flm_nthw *p)
+void nthw_flm_stat_prb_done_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_prb_done);
 	nthw_register_update(p->mp_stat_prb_done);
 }
 
-void flm_nthw_stat_prb_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_prb_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_prb_ignore_cnt);
 
@@ -963,90 +963,90 @@ void flm_nthw_stat_prb_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int g
 		*val = nthw_field_get_val32(p->mp_stat_prb_ignore_cnt);
 }
 
-void flm_nthw_stat_prb_ignore_update(const struct flm_nthw *p)
+void nthw_flm_stat_prb_ignore_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_prb_ignore);
 	nthw_register_update(p->mp_stat_prb_ignore);
 }
 
-void flm_nthw_stat_rel_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_rel_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_rel_done_cnt);
 }
 
-void flm_nthw_stat_rel_done_update(const struct flm_nthw *p)
+void nthw_flm_stat_rel_done_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_rel_done);
 }
 
-void flm_nthw_stat_rel_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_rel_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_rel_ignore_cnt);
 }
 
-void flm_nthw_stat_rel_ignore_update(const struct flm_nthw *p)
+void nthw_flm_stat_rel_ignore_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_rel_ignore);
 }
 
-void flm_nthw_stat_aul_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_aul_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_aul_done_cnt);
 }
 
-void flm_nthw_stat_aul_done_update(const struct flm_nthw *p)
+void nthw_flm_stat_aul_done_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_aul_done);
 }
 
-void flm_nthw_stat_aul_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_aul_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_aul_ignore_cnt);
 }
 
-void flm_nthw_stat_aul_ignore_update(const struct flm_nthw *p)
+void nthw_flm_stat_aul_ignore_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_aul_ignore);
 }
 
-void flm_nthw_stat_aul_fail_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_aul_fail_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_aul_fail_cnt);
 }
 
-void flm_nthw_stat_aul_fail_update(const struct flm_nthw *p)
+void nthw_flm_stat_aul_fail_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_aul_fail);
 }
 
-void flm_nthw_stat_tul_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_tul_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_tul_done_cnt);
 }
 
-void flm_nthw_stat_tul_done_update(const struct flm_nthw *p)
+void nthw_flm_stat_tul_done_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_tul_done);
 }
 
-void flm_nthw_stat_flows_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_flows_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_stat_flows_cnt);
 }
 
-void flm_nthw_stat_flows_update(const struct flm_nthw *p)
+void nthw_flm_stat_flows_update(const struct flm_nthw *p)
 {
 	nthw_register_update(p->mp_stat_flows);
 }
 
-void flm_nthw_stat_sta_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_sta_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_sta_done_cnt);
 
@@ -1054,13 +1054,13 @@ void flm_nthw_stat_sta_done_cnt(const struct flm_nthw *p, uint32_t *val, int get
 		*val = nthw_field_get_val32(p->mp_stat_sta_done_cnt);
 }
 
-void flm_nthw_stat_sta_done_update(const struct flm_nthw *p)
+void nthw_flm_stat_sta_done_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_sta_done);
 	nthw_register_update(p->mp_stat_sta_done);
 }
 
-void flm_nthw_stat_inf_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_inf_done_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_inf_done_cnt);
 
@@ -1068,13 +1068,13 @@ void flm_nthw_stat_inf_done_cnt(const struct flm_nthw *p, uint32_t *val, int get
 		*val = nthw_field_get_val32(p->mp_stat_inf_done_cnt);
 }
 
-void flm_nthw_stat_inf_done_update(const struct flm_nthw *p)
+void nthw_flm_stat_inf_done_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_inf_done);
 	nthw_register_update(p->mp_stat_inf_done);
 }
 
-void flm_nthw_stat_inf_skip_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_inf_skip_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_inf_skip_cnt);
 
@@ -1082,13 +1082,13 @@ void flm_nthw_stat_inf_skip_cnt(const struct flm_nthw *p, uint32_t *val, int get
 		*val = nthw_field_get_val32(p->mp_stat_inf_skip_cnt);
 }
 
-void flm_nthw_stat_inf_skip_update(const struct flm_nthw *p)
+void nthw_flm_stat_inf_skip_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_inf_skip);
 	nthw_register_update(p->mp_stat_inf_skip);
 }
 
-void flm_nthw_stat_pck_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_pck_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_pck_hit_cnt);
 
@@ -1096,13 +1096,13 @@ void flm_nthw_stat_pck_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 		*val = nthw_field_get_val32(p->mp_stat_pck_hit_cnt);
 }
 
-void flm_nthw_stat_pck_hit_update(const struct flm_nthw *p)
+void nthw_flm_stat_pck_hit_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_pck_hit);
 	nthw_register_update(p->mp_stat_pck_hit);
 }
 
-void flm_nthw_stat_pck_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_pck_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_pck_miss_cnt);
 
@@ -1110,13 +1110,13 @@ void flm_nthw_stat_pck_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get
 		*val = nthw_field_get_val32(p->mp_stat_pck_miss_cnt);
 }
 
-void flm_nthw_stat_pck_miss_update(const struct flm_nthw *p)
+void nthw_flm_stat_pck_miss_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_pck_miss);
 	nthw_register_update(p->mp_stat_pck_miss);
 }
 
-void flm_nthw_stat_pck_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_pck_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_pck_unh_cnt);
 
@@ -1124,13 +1124,13 @@ void flm_nthw_stat_pck_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 		*val = nthw_field_get_val32(p->mp_stat_pck_unh_cnt);
 }
 
-void flm_nthw_stat_pck_unh_update(const struct flm_nthw *p)
+void nthw_flm_stat_pck_unh_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_pck_unh);
 	nthw_register_update(p->mp_stat_pck_unh);
 }
 
-void flm_nthw_stat_pck_dis_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_pck_dis_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_pck_dis_cnt);
 
@@ -1138,13 +1138,13 @@ void flm_nthw_stat_pck_dis_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 		*val = nthw_field_get_val32(p->mp_stat_pck_dis_cnt);
 }
 
-void flm_nthw_stat_pck_dis_update(const struct flm_nthw *p)
+void nthw_flm_stat_pck_dis_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_pck_dis);
 	nthw_register_update(p->mp_stat_pck_dis);
 }
 
-void flm_nthw_stat_csh_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_csh_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_csh_hit_cnt);
 
@@ -1152,13 +1152,13 @@ void flm_nthw_stat_csh_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 		*val = nthw_field_get_val32(p->mp_stat_csh_hit_cnt);
 }
 
-void flm_nthw_stat_csh_hit_update(const struct flm_nthw *p)
+void nthw_flm_stat_csh_hit_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_csh_hit);
 	nthw_register_update(p->mp_stat_csh_hit);
 }
 
-void flm_nthw_stat_csh_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_csh_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_csh_miss_cnt);
 
@@ -1166,13 +1166,13 @@ void flm_nthw_stat_csh_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get
 		*val = nthw_field_get_val32(p->mp_stat_csh_miss_cnt);
 }
 
-void flm_nthw_stat_csh_miss_update(const struct flm_nthw *p)
+void nthw_flm_stat_csh_miss_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_csh_miss);
 	nthw_register_update(p->mp_stat_csh_miss);
 }
 
-void flm_nthw_stat_csh_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_csh_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_csh_unh_cnt);
 
@@ -1180,13 +1180,13 @@ void flm_nthw_stat_csh_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 		*val = nthw_field_get_val32(p->mp_stat_csh_unh_cnt);
 }
 
-void flm_nthw_stat_csh_unh_update(const struct flm_nthw *p)
+void nthw_flm_stat_csh_unh_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_csh_unh);
 	nthw_register_update(p->mp_stat_csh_unh);
 }
 
-void flm_nthw_stat_cuc_start_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_cuc_start_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_cuc_start_cnt);
 
@@ -1194,13 +1194,13 @@ void flm_nthw_stat_cuc_start_cnt(const struct flm_nthw *p, uint32_t *val, int ge
 		*val = nthw_field_get_val32(p->mp_stat_cuc_start_cnt);
 }
 
-void flm_nthw_stat_cuc_start_update(const struct flm_nthw *p)
+void nthw_flm_stat_cuc_start_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_cuc_start);
 	nthw_register_update(p->mp_stat_cuc_start);
 }
 
-void flm_nthw_stat_cuc_move_cnt(const struct flm_nthw *p, uint32_t *val, int get)
+void nthw_flm_stat_cuc_move_cnt(const struct flm_nthw *p, uint32_t *val, int get)
 {
 	RTE_ASSERT(p->mp_stat_cuc_move_cnt);
 
@@ -1208,49 +1208,49 @@ void flm_nthw_stat_cuc_move_cnt(const struct flm_nthw *p, uint32_t *val, int get
 		*val = nthw_field_get_val32(p->mp_stat_cuc_move_cnt);
 }
 
-void flm_nthw_stat_cuc_move_update(const struct flm_nthw *p)
+void nthw_flm_stat_cuc_move_update(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_stat_cuc_move);
 	nthw_register_update(p->mp_stat_cuc_move);
 }
 
-void flm_nthw_scrub_select(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_scrub_select(const struct flm_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_scrub_ctrl_adr);
 	nthw_field_set_val32(p->mp_scrub_ctrl_adr, val);
 }
 
-void flm_nthw_scrub_cnt(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_scrub_cnt(const struct flm_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_scrub_ctrl_cnt);
 	nthw_field_set_val32(p->mp_scrub_ctrl_cnt, val);
 }
 
-void flm_nthw_scrub_t(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_scrub_t(const struct flm_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_scrub_data_t);
 	nthw_field_set_val32(p->mp_scrub_data_t, val);
 }
 
-void flm_nthw_scrub_r(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_scrub_r(const struct flm_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_scrub_data_r);
 	nthw_field_set_val32(p->mp_scrub_data_r, val);
 }
 
-void flm_nthw_scrub_del(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_scrub_del(const struct flm_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_scrub_data_del);
 	nthw_field_set_val32(p->mp_scrub_data_del, val);
 }
 
-void flm_nthw_scrub_inf(const struct flm_nthw *p, uint32_t val)
+void nthw_flm_scrub_inf(const struct flm_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_scrub_data_inf);
 	nthw_field_set_val32(p->mp_scrub_data_inf, val);
 }
 
-void flm_nthw_scrub_flush(const struct flm_nthw *p)
+void nthw_flm_scrub_flush(const struct flm_nthw *p)
 {
 	RTE_ASSERT(p->mp_scrub_ctrl);
 	RTE_ASSERT(p->mp_scrub_data);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h
index 5cc95ab03c..de537c9e49 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h
@@ -14,229 +14,229 @@ struct flm_nthw;
 
 typedef struct flm_nthw flm_nthw_t;
 
-struct flm_nthw *flm_nthw_new(void);
-void flm_nthw_delete(struct flm_nthw *p);
-int flm_nthw_init(struct flm_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
-void flm_nthw_set_debug_mode(struct flm_nthw *p, unsigned int n_debug_mode);
+struct flm_nthw *nthw_flm_new(void);
+void nthw_flm_delete(struct flm_nthw *p);
+int nthw_flm_init(struct flm_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+void nthw_flm_set_debug_mode(struct flm_nthw *p, unsigned int n_debug_mode);
 
 /* Control */
-void flm_nthw_control_enable(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_init(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_lds(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_lfs(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_lis(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_uds(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_uis(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_rds(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_ris(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_pds(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_pis(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_crcwr(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_crcrd(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_rbl(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_eab(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_split_sdram_usage(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_control_flush(const struct flm_nthw *p);
+void nthw_flm_control_enable(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_init(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_lds(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_lfs(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_lis(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_uds(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_uis(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_rds(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_ris(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_pds(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_pis(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_crcwr(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_crcrd(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_rbl(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_eab(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_split_sdram_usage(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_control_flush(const struct flm_nthw *p);
 
 /* Status */
-void flm_nthw_status_calib_success(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_calib_fail(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_initdone(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_idle(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_critical(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_panic(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_crcerr(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_eft_bp(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_cache_buf_crit(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_status_flush(const struct flm_nthw *p);
-void flm_nthw_status_update(const struct flm_nthw *p);
+void nthw_flm_status_calib_success(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_calib_fail(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_initdone(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_idle(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_critical(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_panic(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_crcerr(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_eft_bp(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_cache_buf_crit(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_status_flush(const struct flm_nthw *p);
+void nthw_flm_status_update(const struct flm_nthw *p);
 
 /* Scan */
-void flm_nthw_scan_i(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_scan_flush(const struct flm_nthw *p);
+void nthw_flm_scan_i(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_scan_flush(const struct flm_nthw *p);
 
 /* Load BIN */
-void flm_nthw_load_bin(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_load_bin_flush(const struct flm_nthw *p);
+void nthw_flm_load_bin(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_load_bin_flush(const struct flm_nthw *p);
 
 /* Load LPS */
-void flm_nthw_load_lps_update(const struct flm_nthw *p);
-void flm_nthw_load_lps_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_load_lps_update(const struct flm_nthw *p);
+void nthw_flm_load_lps_cnt(const struct flm_nthw *p, uint32_t *val, int get);
 
 /* Load APS */
-void flm_nthw_load_aps_update(const struct flm_nthw *p);
-void flm_nthw_load_aps_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_load_aps_update(const struct flm_nthw *p);
+void nthw_flm_load_aps_cnt(const struct flm_nthw *p, uint32_t *val, int get);
 
 /* Prio */
-void flm_nthw_prio_limit0(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_prio_ft0(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_prio_limit1(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_prio_ft1(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_prio_limit2(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_prio_ft2(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_prio_limit3(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_prio_ft3(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_prio_flush(const struct flm_nthw *p);
+void nthw_flm_prio_limit0(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_prio_ft0(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_prio_limit1(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_prio_ft1(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_prio_limit2(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_prio_ft2(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_prio_limit3(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_prio_ft3(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_prio_flush(const struct flm_nthw *p);
 
 /* PST */
-void flm_nthw_pst_select(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_pst_cnt(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_pst_bp(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_pst_pp(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_pst_tp(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_pst_flush(const struct flm_nthw *p);
+void nthw_flm_pst_select(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_pst_cnt(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_pst_bp(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_pst_pp(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_pst_tp(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_pst_flush(const struct flm_nthw *p);
 
 /* RCP */
-void flm_nthw_rcp_select(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_cnt(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_lookup(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_qw0_dyn(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_qw0_ofs(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_qw0_sel(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_qw4_dyn(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_qw4_ofs(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_sw8_dyn(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_sw8_ofs(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_sw8_sel(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_sw9_dyn(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_sw9_ofs(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_mask(const struct flm_nthw *p, const uint32_t *val);
-void flm_nthw_rcp_kid(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_opn(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_ipn(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_byt_dyn(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_byt_ofs(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_txplm(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_auto_ipv4_mask(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_rcp_flush(const struct flm_nthw *p);
+void nthw_flm_rcp_select(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_cnt(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_lookup(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_qw0_dyn(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_qw0_ofs(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_qw0_sel(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_qw4_dyn(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_qw4_ofs(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_sw8_dyn(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_sw8_ofs(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_sw8_sel(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_sw9_dyn(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_sw9_ofs(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_mask(const struct flm_nthw *p, const uint32_t *val);
+void nthw_flm_rcp_kid(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_opn(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_ipn(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_byt_dyn(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_byt_ofs(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_txplm(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_auto_ipv4_mask(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_rcp_flush(const struct flm_nthw *p);
 
 /* Buf Ctrl */
-int flm_nthw_buf_ctrl_update(const struct flm_nthw *p, uint32_t *lrn_free, uint32_t *inf_avail,
+int nthw_flm_buf_ctrl_update(const struct flm_nthw *p, uint32_t *lrn_free, uint32_t *inf_avail,
 	uint32_t *sta_avail);
 
 /* Lrn Data */
-int flm_nthw_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint32_t records,
+int nthw_flm_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint32_t records,
 	uint32_t words_per_record, uint32_t *handled_records,
 	uint32_t *lrn_free, uint32_t *inf_avail, uint32_t *sta_avail);
 
 /* Inf - Sta Data */
-int flm_nthw_inf_sta_data_update(const struct flm_nthw *p, uint32_t *inf_data,
+int nthw_flm_inf_sta_data_update(const struct flm_nthw *p, uint32_t *inf_data,
 	uint32_t inf_word_count, uint32_t *sta_data,
 	uint32_t sta_word_count, uint32_t *lrn_free, uint32_t *inf_avail,
 	uint32_t *sta_avail);
 
 /* Stat Lrn Done */
-void flm_nthw_stat_lrn_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_lrn_done_update(const struct flm_nthw *p);
+void nthw_flm_stat_lrn_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_lrn_done_update(const struct flm_nthw *p);
 
 /* Stat Lrn Ignore */
-void flm_nthw_stat_lrn_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_lrn_ignore_update(const struct flm_nthw *p);
+void nthw_flm_stat_lrn_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_lrn_ignore_update(const struct flm_nthw *p);
 
 /* Stat Lrn Fail */
-void flm_nthw_stat_lrn_fail_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_lrn_fail_update(const struct flm_nthw *p);
+void nthw_flm_stat_lrn_fail_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_lrn_fail_update(const struct flm_nthw *p);
 
 /* Stat Unl Done */
-void flm_nthw_stat_unl_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_unl_done_update(const struct flm_nthw *p);
+void nthw_flm_stat_unl_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_unl_done_update(const struct flm_nthw *p);
 
 /* Stat Unl Ignore */
-void flm_nthw_stat_unl_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_unl_ignore_update(const struct flm_nthw *p);
+void nthw_flm_stat_unl_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_unl_ignore_update(const struct flm_nthw *p);
 
 /* Stat Prb Done */
-void flm_nthw_stat_prb_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_prb_done_update(const struct flm_nthw *p);
+void nthw_flm_stat_prb_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_prb_done_update(const struct flm_nthw *p);
 
 /* Stat Prb Ignore */
-void flm_nthw_stat_prb_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_prb_ignore_update(const struct flm_nthw *p);
+void nthw_flm_stat_prb_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_prb_ignore_update(const struct flm_nthw *p);
 
 /* Stat Rel Done */
-void flm_nthw_stat_rel_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_rel_done_update(const struct flm_nthw *p);
+void nthw_flm_stat_rel_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_rel_done_update(const struct flm_nthw *p);
 
 /* Stat Rel Ignore */
-void flm_nthw_stat_rel_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_rel_ignore_update(const struct flm_nthw *p);
+void nthw_flm_stat_rel_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_rel_ignore_update(const struct flm_nthw *p);
 
 /* Stat Aul Done */
-void flm_nthw_stat_aul_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_aul_done_update(const struct flm_nthw *p);
+void nthw_flm_stat_aul_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_aul_done_update(const struct flm_nthw *p);
 
 /* Stat Aul Ignore */
-void flm_nthw_stat_aul_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_aul_ignore_update(const struct flm_nthw *p);
+void nthw_flm_stat_aul_ignore_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_aul_ignore_update(const struct flm_nthw *p);
 
 /* Stat Aul Fail */
-void flm_nthw_stat_aul_fail_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_aul_fail_update(const struct flm_nthw *p);
+void nthw_flm_stat_aul_fail_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_aul_fail_update(const struct flm_nthw *p);
 
 /* Stat Tul Done */
-void flm_nthw_stat_tul_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_tul_done_update(const struct flm_nthw *p);
+void nthw_flm_stat_tul_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_tul_done_update(const struct flm_nthw *p);
 
 /* Stat Flows */
-void flm_nthw_stat_flows_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_flows_update(const struct flm_nthw *p);
+void nthw_flm_stat_flows_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_flows_update(const struct flm_nthw *p);
 
 /* Stat Sta Done */
-void flm_nthw_stat_sta_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_sta_done_update(const struct flm_nthw *p);
+void nthw_flm_stat_sta_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_sta_done_update(const struct flm_nthw *p);
 
 /* Stat Inf Done */
-void flm_nthw_stat_inf_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_inf_done_update(const struct flm_nthw *p);
+void nthw_flm_stat_inf_done_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_inf_done_update(const struct flm_nthw *p);
 
 /* Stat Inf Skip */
-void flm_nthw_stat_inf_skip_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_inf_skip_update(const struct flm_nthw *p);
+void nthw_flm_stat_inf_skip_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_inf_skip_update(const struct flm_nthw *p);
 
 /* Stat Pck Hit */
-void flm_nthw_stat_pck_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_pck_hit_update(const struct flm_nthw *p);
+void nthw_flm_stat_pck_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_pck_hit_update(const struct flm_nthw *p);
 
 /* Stat Pck Miss */
-void flm_nthw_stat_pck_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_pck_miss_update(const struct flm_nthw *p);
+void nthw_flm_stat_pck_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_pck_miss_update(const struct flm_nthw *p);
 
 /* Stat Pck Unh */
-void flm_nthw_stat_pck_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_pck_unh_update(const struct flm_nthw *p);
+void nthw_flm_stat_pck_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_pck_unh_update(const struct flm_nthw *p);
 
 /* Stat Pck Dis */
-void flm_nthw_stat_pck_dis_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_pck_dis_update(const struct flm_nthw *p);
+void nthw_flm_stat_pck_dis_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_pck_dis_update(const struct flm_nthw *p);
 
 /* Stat Csh Hit */
-void flm_nthw_stat_csh_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_csh_hit_update(const struct flm_nthw *p);
+void nthw_flm_stat_csh_hit_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_csh_hit_update(const struct flm_nthw *p);
 
 /* Stat Csh Miss */
-void flm_nthw_stat_csh_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_csh_miss_update(const struct flm_nthw *p);
+void nthw_flm_stat_csh_miss_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_csh_miss_update(const struct flm_nthw *p);
 
 /* Stat Csh Unh */
-void flm_nthw_stat_csh_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_csh_unh_update(const struct flm_nthw *p);
+void nthw_flm_stat_csh_unh_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_csh_unh_update(const struct flm_nthw *p);
 
 /* Stat Cuc Start */
-void flm_nthw_stat_cuc_start_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_cuc_start_update(const struct flm_nthw *p);
+void nthw_flm_stat_cuc_start_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_cuc_start_update(const struct flm_nthw *p);
 
 /* Stat Cuc Move */
-void flm_nthw_stat_cuc_move_cnt(const struct flm_nthw *p, uint32_t *val, int get);
-void flm_nthw_stat_cuc_move_update(const struct flm_nthw *p);
+void nthw_flm_stat_cuc_move_cnt(const struct flm_nthw *p, uint32_t *val, int get);
+void nthw_flm_stat_cuc_move_update(const struct flm_nthw *p);
 
 /* Scrubber profile memory */
-void flm_nthw_scrub_select(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_scrub_cnt(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_scrub_t(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_scrub_r(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_scrub_del(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_scrub_inf(const struct flm_nthw *p, uint32_t val);
-void flm_nthw_scrub_flush(const struct flm_nthw *p);
+void nthw_flm_scrub_select(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_scrub_cnt(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_scrub_t(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_scrub_r(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_scrub_del(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_scrub_inf(const struct flm_nthw *p, uint32_t val);
+void nthw_flm_scrub_flush(const struct flm_nthw *p);
 
 struct flm_nthw {
 	uint8_t m_physical_adapter_no;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
index 14ad74396f..6e46fee637 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
@@ -12,12 +12,12 @@
 
 #include "flow_nthw_hfu.h"
 
-void hfu_nthw_set_debug_mode(struct hfu_nthw *p, unsigned int n_debug_mode)
+void nthw_hfu_set_debug_mode(struct hfu_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_hfu, n_debug_mode);
 }
 
-struct hfu_nthw *hfu_nthw_new(void)
+struct hfu_nthw *nthw_hfu_new(void)
 {
 	struct hfu_nthw *p = malloc(sizeof(struct hfu_nthw));
 
@@ -27,7 +27,7 @@ struct hfu_nthw *hfu_nthw_new(void)
 	return p;
 }
 
-void hfu_nthw_delete(struct hfu_nthw *p)
+void nthw_hfu_delete(struct hfu_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -35,7 +35,7 @@ void hfu_nthw_delete(struct hfu_nthw *p)
 	}
 }
 
-int hfu_nthw_init(struct hfu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_hfu_init(struct hfu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_HFU, n_instance);
@@ -103,127 +103,127 @@ int hfu_nthw_init(struct hfu_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void hfu_nthw_rcp_select(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_select(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
-void hfu_nthw_rcp_cnt(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_cnt(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
-void hfu_nthw_rcp_len_a_wr(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_a_wr(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_a_wr, val);
 }
 
-void hfu_nthw_rcp_len_a_ol4len(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_a_ol4len(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_a_ol4len, val);
 }
 
-void hfu_nthw_rcp_len_a_pos_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_a_pos_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_a_pos_dyn, val);
 }
 
-void hfu_nthw_rcp_len_a_pos_ofs(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_a_pos_ofs(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_a_pos_ofs, val);
 }
 
-void hfu_nthw_rcp_len_a_add_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_a_add_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_a_add_dyn, val);
 }
 
-void hfu_nthw_rcp_len_a_add_ofs(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_a_add_ofs(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_a_add_ofs, val);
 }
 
-void hfu_nthw_rcp_len_a_sub_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_a_sub_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_a_sub_dyn, val);
 }
 
-void hfu_nthw_rcp_len_b_wr(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_b_wr(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_b_wr, val);
 }
 
-void hfu_nthw_rcp_len_b_pos_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_b_pos_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_b_pos_dyn, val);
 }
 
-void hfu_nthw_rcp_len_b_pos_ofs(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_b_pos_ofs(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_b_pos_ofs, val);
 }
 
-void hfu_nthw_rcp_len_b_add_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_b_add_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_b_add_dyn, val);
 }
 
-void hfu_nthw_rcp_len_b_add_ofs(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_b_add_ofs(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_b_add_ofs, val);
 }
 
-void hfu_nthw_rcp_len_b_sub_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_b_sub_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_b_sub_dyn, val);
 }
 
-void hfu_nthw_rcp_len_c_wr(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_c_wr(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_c_wr, val);
 }
 
-void hfu_nthw_rcp_len_c_pos_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_c_pos_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_c_pos_dyn, val);
 }
 
-void hfu_nthw_rcp_len_c_pos_ofs(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_c_pos_ofs(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_c_pos_ofs, val);
 }
 
-void hfu_nthw_rcp_len_c_add_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_c_add_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_c_add_dyn, val);
 }
 
-void hfu_nthw_rcp_len_c_add_ofs(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_c_add_ofs(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_c_add_ofs, val);
 }
 
-void hfu_nthw_rcp_len_c_sub_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_len_c_sub_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len_c_sub_dyn, val);
 }
 
-void hfu_nthw_rcp_ttl_wr(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_ttl_wr(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ttl_wr, val);
 }
 
-void hfu_nthw_rcp_ttl_pos_dyn(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_ttl_pos_dyn(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ttl_pos_dyn, val);
 }
 
-void hfu_nthw_rcp_ttl_pos_ofs(const struct hfu_nthw *p, uint32_t val)
+void nthw_hfu_rcp_ttl_pos_ofs(const struct hfu_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ttl_pos_ofs, val);
 }
 
-void hfu_nthw_rcp_flush(const struct hfu_nthw *p)
+void nthw_hfu_rcp_flush(const struct hfu_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h
index 77002a639e..a41ff4c8b8 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h
@@ -45,40 +45,40 @@ struct hfu_nthw {
 	nthw_field_t *mp_rcp_data_ttl_pos_ofs;
 };
 
-struct hfu_nthw *hfu_nthw_new(void);
-void hfu_nthw_delete(struct hfu_nthw *p);
-int hfu_nthw_init(struct hfu_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct hfu_nthw *nthw_hfu_new(void);
+void nthw_hfu_delete(struct hfu_nthw *p);
+int nthw_hfu_init(struct hfu_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int hfu_nthw_setup(struct hfu_nthw *p, int n_idx, int n_idx_cnt);
-void hfu_nthw_set_debug_mode(struct hfu_nthw *p, unsigned int n_debug_mode);
+void nthw_hfu_set_debug_mode(struct hfu_nthw *p, unsigned int n_debug_mode);
 
 /* RCP */
-void hfu_nthw_rcp_select(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_cnt(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_select(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_cnt(const struct hfu_nthw *p, uint32_t val);
 
-void hfu_nthw_rcp_len_a_wr(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_a_ol4len(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_a_pos_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_a_pos_ofs(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_a_add_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_a_add_ofs(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_a_sub_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_b_wr(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_b_pos_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_b_pos_ofs(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_b_add_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_b_add_ofs(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_b_sub_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_c_wr(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_c_pos_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_c_pos_ofs(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_c_add_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_c_add_ofs(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_len_c_sub_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_ttl_wr(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_ttl_pos_dyn(const struct hfu_nthw *p, uint32_t val);
-void hfu_nthw_rcp_ttl_pos_ofs(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_a_wr(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_a_ol4len(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_a_pos_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_a_pos_ofs(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_a_add_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_a_add_ofs(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_a_sub_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_b_wr(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_b_pos_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_b_pos_ofs(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_b_add_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_b_add_ofs(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_b_sub_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_c_wr(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_c_pos_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_c_pos_ofs(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_c_add_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_c_add_ofs(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_len_c_sub_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_ttl_wr(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_ttl_pos_dyn(const struct hfu_nthw *p, uint32_t val);
+void nthw_hfu_rcp_ttl_pos_ofs(const struct hfu_nthw *p, uint32_t val);
 
-void hfu_nthw_rcp_flush(const struct hfu_nthw *p);
+void nthw_hfu_rcp_flush(const struct hfu_nthw *p);
 
 #endif	/* __FLOW_NTHW_HFU_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
index f8cfa94a15..fc1ca7aba2 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
@@ -13,12 +13,12 @@
 
 #include "flow_nthw_hsh.h"
 
-void hsh_nthw_set_debug_mode(struct hsh_nthw *p, unsigned int n_debug_mode)
+void nthw_hsh_set_debug_mode(struct hsh_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_hsh, n_debug_mode);
 }
 
-struct hsh_nthw *hsh_nthw_new(void)
+struct hsh_nthw *nthw_hsh_new(void)
 {
 	struct hsh_nthw *p = malloc(sizeof(struct hsh_nthw));
 
@@ -28,7 +28,7 @@ struct hsh_nthw *hsh_nthw_new(void)
 	return p;
 }
 
-void hsh_nthw_delete(struct hsh_nthw *p)
+void nthw_hsh_delete(struct hsh_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -36,7 +36,7 @@ void hsh_nthw_delete(struct hsh_nthw *p)
 	}
 }
 
-int hsh_nthw_init(struct hsh_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_hsh_init(struct hsh_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_HSH, n_instance);
@@ -124,136 +124,136 @@ int hsh_nthw_init(struct hsh_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void hsh_nthw_rcp_select(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_select(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
-void hsh_nthw_rcp_cnt(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_cnt(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
-void hsh_nthw_rcp_load_dist_type(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_load_dist_type(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_load_dist_type, val);
 }
 
-void hsh_nthw_rcp_mac_port_mask(const struct hsh_nthw *p, uint32_t *val)
+void nthw_hsh_rcp_mac_port_mask(const struct hsh_nthw *p, uint32_t *val)
 {
 	nthw_field_set_val(p->mp_rcp_data_mac_port_mask, val,
 		p->mp_rcp_data_mac_port_mask->mn_words);
 }
 
-void hsh_nthw_rcp_sort(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_sort(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sort, val);
 }
 
-void hsh_nthw_rcp_qw0_pe(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_qw0_pe(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_pe, val);
 }
 
-void hsh_nthw_rcp_qw0_ofs(const struct hsh_nthw *p, int32_t val)
+void nthw_hsh_rcp_qw0_ofs(const struct hsh_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_ofs, val);
 }
 
-void hsh_nthw_rcp_qw4_pe(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_qw4_pe(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw4_pe, val);
 }
 
-void hsh_nthw_rcp_qw4_ofs(const struct hsh_nthw *p, int32_t val)
+void nthw_hsh_rcp_qw4_ofs(const struct hsh_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw4_ofs, val);
 }
 
-void hsh_nthw_rcp_w8_pe(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_w8_pe(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_w8_pe, val);
 }
 
-void hsh_nthw_rcp_w8_ofs(const struct hsh_nthw *p, int32_t val)
+void nthw_hsh_rcp_w8_ofs(const struct hsh_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_w8_ofs, val);
 }
 
-void hsh_nthw_rcp_w8_sort(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_w8_sort(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_w8_sort, val);
 }
 
-void hsh_nthw_rcp_w9_pe(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_w9_pe(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_w9_pe, val);
 }
 
-void hsh_nthw_rcp_w9_ofs(const struct hsh_nthw *p, int32_t val)
+void nthw_hsh_rcp_w9_ofs(const struct hsh_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_w9_ofs, val);
 }
 
-void hsh_nthw_rcp_w9_sort(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_w9_sort(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_w9_sort, val);
 }
 
-void hsh_nthw_rcp_w9_p(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_w9_p(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_w9_p, val);
 }
 
-void hsh_nthw_rcp_p_mask(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_p_mask(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_p_mask, val);
 }
 
-void hsh_nthw_rcp_word_mask(const struct hsh_nthw *p, uint32_t *val)
+void nthw_hsh_rcp_word_mask(const struct hsh_nthw *p, uint32_t *val)
 {
 	nthw_field_set_val(p->mp_rcp_data_word_mask, val, 10);
 }
 
-void hsh_nthw_rcp_seed(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_seed(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_seed, val);
 }
 
-void hsh_nthw_rcp_tnl_p(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_tnl_p(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tnl_p, val);
 }
 
-void hsh_nthw_rcp_hsh_valid(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_hsh_valid(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_hsh_valid, val);
 }
 
-void hsh_nthw_rcp_hsh_type(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_hsh_type(const struct hsh_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_hsh_type, val);
 }
 
-void hsh_nthw_rcp_toeplitz(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_toeplitz(const struct hsh_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_toeplitz)
 		nthw_field_set_val32(p->mp_rcp_data_toeplitz, val);
 }
 
-void hsh_nthw_rcp_k(const struct hsh_nthw *p, uint32_t *val)
+void nthw_hsh_rcp_k(const struct hsh_nthw *p, uint32_t *val)
 {
 	if (p->mp_rcp_data_k)
 		nthw_field_set_val(p->mp_rcp_data_k, val, 10);
 }
 
-void hsh_nthw_rcp_auto_ipv4_mask(const struct hsh_nthw *p, uint32_t val)
+void nthw_hsh_rcp_auto_ipv4_mask(const struct hsh_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_auto_ipv4_mask)
 		nthw_field_set_val32(p->mp_rcp_data_auto_ipv4_mask, val);
 }
 
-void hsh_nthw_rcp_flush(const struct hsh_nthw *p)
+void nthw_hsh_rcp_flush(const struct hsh_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h
index 70626122e3..0cd9a365fe 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h
@@ -14,40 +14,40 @@ struct hsh_nthw;
 
 typedef struct hsh_nthw hsh_nthw_t;
 
-struct hsh_nthw *hsh_nthw_new(void);
-void hsh_nthw_delete(struct hsh_nthw *p);
-int hsh_nthw_init(struct hsh_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct hsh_nthw *nthw_hsh_new(void);
+void nthw_hsh_delete(struct hsh_nthw *p);
+int nthw_hsh_init(struct hsh_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int hsh_nthw_setup(struct hsh_nthw *p, int n_idx, int n_idx_cnt);
-void hsh_nthw_set_debug_mode(struct hsh_nthw *p, unsigned int n_debug_mode);
+void nthw_hsh_set_debug_mode(struct hsh_nthw *p, unsigned int n_debug_mode);
 
 /* RCP */
-void hsh_nthw_rcp_select(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_cnt(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_load_dist_type(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_mac_port_mask(const struct hsh_nthw *p, uint32_t *val);
-void hsh_nthw_rcp_sort(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_qw0_pe(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_qw0_ofs(const struct hsh_nthw *p, int32_t val);
-void hsh_nthw_rcp_qw4_pe(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_qw4_ofs(const struct hsh_nthw *p, int32_t val);
-void hsh_nthw_rcp_w8_pe(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_w8_ofs(const struct hsh_nthw *p, int32_t val);
-void hsh_nthw_rcp_w8_sort(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_w9_pe(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_w9_ofs(const struct hsh_nthw *p, int32_t val);
-void hsh_nthw_rcp_w9_sort(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_w9_p(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_p_mask(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_word_mask(const struct hsh_nthw *p, uint32_t *val);
-void hsh_nthw_rcp_seed(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_tnl_p(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_hsh_valid(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_hsh_type(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_toeplitz(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_k(const struct hsh_nthw *p, uint32_t *val);
-void hsh_nthw_rcp_auto_ipv4_mask(const struct hsh_nthw *p, uint32_t val);
-void hsh_nthw_rcp_flush(const struct hsh_nthw *p);
+void nthw_hsh_rcp_select(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_cnt(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_load_dist_type(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_mac_port_mask(const struct hsh_nthw *p, uint32_t *val);
+void nthw_hsh_rcp_sort(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_qw0_pe(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_qw0_ofs(const struct hsh_nthw *p, int32_t val);
+void nthw_hsh_rcp_qw4_pe(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_qw4_ofs(const struct hsh_nthw *p, int32_t val);
+void nthw_hsh_rcp_w8_pe(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_w8_ofs(const struct hsh_nthw *p, int32_t val);
+void nthw_hsh_rcp_w8_sort(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_w9_pe(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_w9_ofs(const struct hsh_nthw *p, int32_t val);
+void nthw_hsh_rcp_w9_sort(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_w9_p(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_p_mask(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_word_mask(const struct hsh_nthw *p, uint32_t *val);
+void nthw_hsh_rcp_seed(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_tnl_p(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_hsh_valid(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_hsh_type(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_toeplitz(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_k(const struct hsh_nthw *p, uint32_t *val);
+void nthw_hsh_rcp_auto_ipv4_mask(const struct hsh_nthw *p, uint32_t val);
+void nthw_hsh_rcp_flush(const struct hsh_nthw *p);
 
 struct hsh_nthw {
 	uint8_t m_physical_adapter_no;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
index 78835654dc..ee77e21694 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
@@ -12,12 +12,12 @@
 
 #include "flow_nthw_ifr.h"
 
-void ifr_nthw_set_debug_mode(struct ifr_nthw *p, unsigned int n_debug_mode)
+void nthw_ifr_set_debug_mode(struct ifr_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_ifr, n_debug_mode);
 }
 
-struct ifr_nthw *ifr_nthw_new(void)
+struct ifr_nthw *nthw_ifr_new(void)
 {
 	struct ifr_nthw *p = malloc(sizeof(struct ifr_nthw));
 
@@ -27,7 +27,7 @@ struct ifr_nthw *ifr_nthw_new(void)
 	return p;
 }
 
-int ifr_nthw_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_ifr_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_IFR, n_instance);
@@ -79,49 +79,49 @@ int ifr_nthw_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void ifr_nthw_rcp_select(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_rcp_select(const struct ifr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_rcp_addr);
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
-void ifr_nthw_rcp_cnt(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_rcp_cnt(const struct ifr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_rcp_cnt);
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
-void ifr_nthw_rcp_ipv4_en(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_rcp_ipv4_en(const struct ifr_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_ipv4_en)
 		nthw_field_set_val32(p->mp_rcp_data_ipv4_en, val);
 }
 
-void ifr_nthw_rcp_ipv4_df_drop(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_rcp_ipv4_df_drop(const struct ifr_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_ipv4_df_drop)
 		nthw_field_set_val32(p->mp_rcp_data_ipv4_df_drop, val);
 }
 
-void ifr_nthw_rcp_ipv6_en(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_rcp_ipv6_en(const struct ifr_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_ipv6_en)
 		nthw_field_set_val32(p->mp_rcp_data_ipv6_en, val);
 }
 
-void ifr_nthw_rcp_ipv6_drop(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_rcp_ipv6_drop(const struct ifr_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_ipv6_drop)
 		nthw_field_set_val32(p->mp_rcp_data_ipv6_drop, val);
 }
 
-void ifr_nthw_rcp_mtu(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_rcp_mtu(const struct ifr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_rcp_data_mtu);
 	nthw_field_set_val32(p->mp_rcp_data_mtu, val);
 }
 
-void ifr_nthw_rcp_flush(const struct ifr_nthw *p)
+void nthw_ifr_rcp_flush(const struct ifr_nthw *p)
 {
 	RTE_ASSERT(p->mp_rcp_ctrl);
 	RTE_ASSERT(p->mp_rcp_data);
@@ -129,25 +129,25 @@ void ifr_nthw_rcp_flush(const struct ifr_nthw *p)
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
 
-void ifr_nthw_counters_select(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_counters_select(const struct ifr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_counters_addr);
 	nthw_field_set_val32(p->mp_counters_addr, val);
 }
 
-void ifr_nthw_counters_cnt(const struct ifr_nthw *p, uint32_t val)
+void nthw_ifr_counters_cnt(const struct ifr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_counters_cnt);
 	nthw_field_set_val32(p->mp_counters_cnt, val);
 }
 
-void ifr_nthw_counters_drop(const struct ifr_nthw *p, uint32_t *val, int get)
+void nthw_ifr_counters_drop(const struct ifr_nthw *p, uint32_t *val, int get)
 {
 	if (get)
 		*val = nthw_field_get_val32(p->mp_counters_drop);
 }
 
-void ifr_nthw_counters_update(const struct ifr_nthw *p)
+void nthw_ifr_counters_update(const struct ifr_nthw *p)
 {
 	RTE_ASSERT(p->mp_counters_data);
 	nthw_register_flush(p->mp_counters_ctrl, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
index 4763333765..eaf955a25f 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
@@ -42,26 +42,26 @@ struct ifr_nthw {
 	nthw_field_t *mp_counters_drop;
 };
 
-struct ifr_nthw *ifr_nthw_new(void);
-int ifr_nthw_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct ifr_nthw *nthw_ifr_new(void);
+int nthw_ifr_init(struct ifr_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int ifr_nthw_setup(struct ifr_nthw *p, int n_idx, int n_idx_cnt);
-void ifr_nthw_set_debug_mode(struct ifr_nthw *p, unsigned int n_debug_mode);
+void nthw_ifr_set_debug_mode(struct ifr_nthw *p, unsigned int n_debug_mode);
 
 /* IFR RCP */
-void ifr_nthw_rcp_select(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_rcp_cnt(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_rcp_ipv4_en(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_rcp_ipv4_df_drop(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_rcp_ipv6_en(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_rcp_ipv6_drop(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_rcp_mtu(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_rcp_flush(const struct ifr_nthw *p);
+void nthw_ifr_rcp_select(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_rcp_cnt(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_rcp_ipv4_en(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_rcp_ipv4_df_drop(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_rcp_ipv6_en(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_rcp_ipv6_drop(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_rcp_mtu(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_rcp_flush(const struct ifr_nthw *p);
 
 /* IFR Counters */
-void ifr_nthw_counters_select(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_counters_cnt(const struct ifr_nthw *p, uint32_t val);
-void ifr_nthw_counters_drop(const struct ifr_nthw *p, uint32_t *val, int get);
-void ifr_nthw_counters_update(const struct ifr_nthw *p);
+void nthw_ifr_counters_select(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_counters_cnt(const struct ifr_nthw *p, uint32_t val);
+void nthw_ifr_counters_drop(const struct ifr_nthw *p, uint32_t *val, int get);
+void nthw_ifr_counters_update(const struct ifr_nthw *p);
 
 #endif	/* __FLOW_NTHW_IFR_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
index f945f33fff..812c265cda 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
@@ -18,7 +18,7 @@ static inline unsigned int clamp_one(unsigned int val)
 	return val > 1 ? 1 : val;
 }
 
-struct info_nthw *info_nthw_new(void)
+struct info_nthw *nthw_info_new(void)
 {
 	struct info_nthw *p = malloc(sizeof(struct info_nthw));
 
@@ -28,7 +28,7 @@ struct info_nthw *info_nthw_new(void)
 	return p;
 }
 
-void info_nthw_delete(struct info_nthw *p)
+void nthw_info_delete(struct info_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -36,7 +36,7 @@ void info_nthw_delete(struct info_nthw *p)
 	}
 }
 
-int info_nthw_init(struct info_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_info_init(struct info_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	RTE_ASSERT(n_instance >= 0 && n_instance < 256);
 
@@ -135,207 +135,207 @@ int info_nthw_init(struct info_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-unsigned int info_nthw_get_nb_phy_ports(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_phy_ports(const struct info_nthw *p)
 {
 	return p->n_phy_ports;
 }
 
-unsigned int info_nthw_get_nb_rx_ports(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_rx_ports(const struct info_nthw *p)
 {
 	return p->n_rx_ports;
 }
 
-unsigned int info_nthw_get_ltx_avail(const struct info_nthw *p)
+unsigned int nthw_info_get_ltx_avail(const struct info_nthw *p)
 {
 	return p->n_ltx_avail;
 }
 
-unsigned int info_nthw_get_nb_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_categories(const struct info_nthw *p)
 {
 	return p->nb_categories;
 }
 
-unsigned int info_nthw_get_kcc_size(const struct info_nthw *p)
+unsigned int nthw_info_get_kcc_size(const struct info_nthw *p)
 {
 	return p->nb_kcc_size;
 }
 
-unsigned int info_nthw_get_kcc_banks(const struct info_nthw *p)
+unsigned int nthw_info_get_kcc_banks(const struct info_nthw *p)
 {
 	return p->nb_kcc_banks;
 }
 
-unsigned int info_nthw_get_nb_queues(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_queues(const struct info_nthw *p)
 {
 	return p->nb_queues;
 }
 
-unsigned int info_nthw_get_nb_cat_funcs(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_cat_funcs(const struct info_nthw *p)
 {
 	return p->nb_cat_func;
 }
 
-unsigned int info_nthw_get_nb_km_flow_types(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_km_flow_types(const struct info_nthw *p)
 {
 	return p->nb_flow_types;
 }
 
-unsigned int info_nthw_get_nb_pm_ext(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_pm_ext(const struct info_nthw *p)
 {
 	return p->nb_pm_ext;
 }
 
-unsigned int info_nthw_get_nb_len(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_len(const struct info_nthw *p)
 {
 	return p->nb_len;
 }
 
-unsigned int info_nthw_get_nb_km_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_km_categories(const struct info_nthw *p)
 {
 	return p->nb_km_categories;
 }
 
-unsigned int info_nthw_get_nb_km_cam_banks(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_km_cam_banks(const struct info_nthw *p)
 {
 	return p->nb_km_cam_banks;
 }
 
-unsigned int info_nthw_get_nb_km_cam_record_words(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_km_cam_record_words(const struct info_nthw *p)
 {
 	return p->nb_km_cam_record_words;
 }
 
-unsigned int info_nthw_get_nb_km_cam_records(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_km_cam_records(const struct info_nthw *p)
 {
 	return p->nb_km_cam_records;
 }
 
-unsigned int info_nthw_get_nb_km_tcam_banks(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_km_tcam_banks(const struct info_nthw *p)
 {
 	return p->nb_km_tcam_banks;
 }
 
-unsigned int info_nthw_get_nb_km_tcam_bank_width(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_km_tcam_bank_width(const struct info_nthw *p)
 {
 	return p->nb_km_tcam_bank_width;
 }
 
-unsigned int info_nthw_get_nb_flm_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_flm_categories(const struct info_nthw *p)
 {
 	return p->nb_flm_categories;
 }
 
-unsigned int info_nthw_get_nb_flm_size_mb(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_flm_size_mb(const struct info_nthw *p)
 {
 	return p->nb_flm_size_mb;
 }
 
-unsigned int info_nthw_get_nb_flm_entry_size(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_flm_entry_size(const struct info_nthw *p)
 {
 	return p->nb_flm_entry_size;
 }
 
-unsigned int info_nthw_get_nb_flm_variant(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_flm_variant(const struct info_nthw *p)
 {
 	return p->nb_flm_variant;
 }
 
-unsigned int info_nthw_get_nb_flm_prios(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_flm_prios(const struct info_nthw *p)
 {
 	return p->nb_flm_prios;
 }
 
-unsigned int info_nthw_get_nb_flm_pst_profiles(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_flm_pst_profiles(const struct info_nthw *p)
 {
 	return p->nb_flm_pst_profiles;
 }
 
-unsigned int info_nthw_get_nb_flm_scrub_profiles(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_flm_scrub_profiles(const struct info_nthw *p)
 {
 	return p->nb_flm_scrub_profiles;
 }
 
-unsigned int info_nthw_get_nb_flm_load_aps_max(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_flm_load_aps_max(const struct info_nthw *p)
 {
 	return p->nb_flm_load_aps_max;
 }
 
-unsigned int info_nthw_get_nb_qsl_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_qsl_categories(const struct info_nthw *p)
 {
 	return p->nb_qsl_categories;
 }
 
-unsigned int info_nthw_get_nb_qsl_qst_entries(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_qsl_qst_entries(const struct info_nthw *p)
 {
 	return p->nb_qsl_qst_entries;
 }
 
-unsigned int info_nthw_get_nb_pdb_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_pdb_categories(const struct info_nthw *p)
 {
 	return p->nb_pdb_categories;
 }
 
-unsigned int info_nthw_get_nb_roa_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_roa_categories(const struct info_nthw *p)
 {
 	return p->nb_roa_categories;
 }
 
-unsigned int info_nthw_get_nb_cat_km_if_cnt(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_cat_km_if_cnt(const struct info_nthw *p)
 {
 	return p->nb_cat_km_if_cnt;
 }
 
-unsigned int info_nthw_get_nb_cat_km_if_m0(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_cat_km_if_m0(const struct info_nthw *p)
 {
 	return p->m_cat_km_if_m0;
 }
 
-unsigned int info_nthw_get_nb_cat_km_if_m1(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_cat_km_if_m1(const struct info_nthw *p)
 {
 	return p->m_cat_km_if_m1;
 }
 
-unsigned int info_nthw_get_nb_tpe_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_tpe_categories(const struct info_nthw *p)
 {
 	return p->nb_tpe_categories;
 }
 
-unsigned int info_nthw_get_nb_tx_cpy_writers(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_tx_cpy_writers(const struct info_nthw *p)
 {
 	return p->nb_tx_cpy_writers;
 }
 
-unsigned int info_nthw_get_nb_tx_cpy_mask_mem(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_tx_cpy_mask_mem(const struct info_nthw *p)
 {
 	return p->nb_tx_cpy_mask_mem;
 }
 
-unsigned int info_nthw_get_nb_tx_rpl_depth(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_tx_rpl_depth(const struct info_nthw *p)
 {
 	return p->nb_tx_rpl_depth;
 }
 
-unsigned int info_nthw_get_nb_tx_rpl_ext_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_tx_rpl_ext_categories(const struct info_nthw *p)
 {
 	return p->nb_tx_rpl_ext_categories;
 }
 
-unsigned int info_nthw_get_nb_tpe_ifr_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_tpe_ifr_categories(const struct info_nthw *p)
 {
 	return p->nb_tpe_ifr_categories;
 }
 
-unsigned int info_nthw_get_nb_rpp_per_ps(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_rpp_per_ps(const struct info_nthw *p)
 {
 	return p->nb_rpp_per_ps;
 }
 
-unsigned int info_nthw_get_nb_hsh_categories(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_hsh_categories(const struct info_nthw *p)
 {
 	return p->nb_hsh_categories;
 }
 
-unsigned int info_nthw_get_nb_hsh_toeplitz(const struct info_nthw *p)
+unsigned int nthw_info_get_nb_hsh_toeplitz(const struct info_nthw *p)
 {
 	return p->nb_hsh_toeplitz;
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h
index d726e89e57..49c5c9ce7d 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h
@@ -12,52 +12,52 @@
 
 struct info_nthw;
 
-struct info_nthw *info_nthw_new(void);
-void info_nthw_delete(struct info_nthw *p);
-int info_nthw_init(struct info_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct info_nthw *nthw_info_new(void);
+void nthw_info_delete(struct info_nthw *p);
+int nthw_info_init(struct info_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
-unsigned int info_nthw_get_nb_phy_ports(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_rx_ports(const struct info_nthw *p);
-unsigned int info_nthw_get_ltx_avail(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_phy_ports(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_rx_ports(const struct info_nthw *p);
+unsigned int nthw_info_get_ltx_avail(const struct info_nthw *p);
 
-unsigned int info_nthw_get_nb_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_queues(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_cat_funcs(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_km_flow_types(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_pm_ext(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_len(const struct info_nthw *p);
-unsigned int info_nthw_get_kcc_size(const struct info_nthw *p);
-unsigned int info_nthw_get_kcc_banks(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_km_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_km_cam_banks(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_km_cam_record_words(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_km_cam_records(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_km_tcam_banks(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_km_tcam_bank_width(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_flm_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_flm_size_mb(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_flm_entry_size(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_flm_variant(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_flm_prios(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_flm_pst_profiles(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_flm_scrub_profiles(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_flm_load_aps_max(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_qsl_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_qsl_qst_entries(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_pdb_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_roa_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_cat_km_if_cnt(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_cat_km_if_m0(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_cat_km_if_m1(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_tpe_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_tx_cpy_writers(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_tx_cpy_mask_mem(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_tx_rpl_depth(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_tx_rpl_ext_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_tpe_ifr_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_rpp_per_ps(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_hsh_categories(const struct info_nthw *p);
-unsigned int info_nthw_get_nb_hsh_toeplitz(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_queues(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_cat_funcs(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_km_flow_types(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_pm_ext(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_len(const struct info_nthw *p);
+unsigned int nthw_info_get_kcc_size(const struct info_nthw *p);
+unsigned int nthw_info_get_kcc_banks(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_km_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_km_cam_banks(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_km_cam_record_words(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_km_cam_records(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_km_tcam_banks(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_km_tcam_bank_width(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_flm_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_flm_size_mb(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_flm_entry_size(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_flm_variant(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_flm_prios(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_flm_pst_profiles(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_flm_scrub_profiles(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_flm_load_aps_max(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_qsl_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_qsl_qst_entries(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_pdb_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_roa_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_cat_km_if_cnt(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_cat_km_if_m0(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_cat_km_if_m1(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_tpe_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_tx_cpy_writers(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_tx_cpy_mask_mem(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_tx_rpl_depth(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_tx_rpl_ext_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_tpe_ifr_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_rpp_per_ps(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_hsh_categories(const struct info_nthw *p);
+unsigned int nthw_info_get_nb_hsh_toeplitz(const struct info_nthw *p);
 
 struct info_nthw {
 	uint8_t m_physical_adapter_no;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
index 10450b3600..0d6dabed46 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
@@ -22,12 +22,12 @@
 		}                                                                                 \
 	} while (0)
 
-void km_nthw_set_debug_mode(struct km_nthw *p, unsigned int n_debug_mode)
+void nthw_km_set_debug_mode(struct km_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_km, n_debug_mode);
 }
 
-struct km_nthw *km_nthw_new(void)
+struct km_nthw *nthw_km_new(void)
 {
 	struct km_nthw *p = malloc(sizeof(struct km_nthw));
 
@@ -37,7 +37,7 @@ struct km_nthw *km_nthw_new(void)
 	return p;
 }
 
-void km_nthw_delete(struct km_nthw *p)
+void nthw_km_delete(struct km_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -45,7 +45,7 @@ void km_nthw_delete(struct km_nthw *p)
 	}
 }
 
-int km_nthw_init(struct km_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_km_init(struct km_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_KM, n_instance);
@@ -220,390 +220,390 @@ int km_nthw_init(struct km_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 }
 
 /* RCP */
-void km_nthw_rcp_select(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_select(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 };
 
-void km_nthw_rcp_cnt(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_cnt(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 };
 
-void km_nthw_rcp_qw0_dyn(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_qw0_dyn(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_dyn, val);
 };
 
-void km_nthw_rcp_qw0_ofs(const struct km_nthw *p, int32_t val)
+void nthw_km_rcp_qw0_ofs(const struct km_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_ofs, val);
 };
 
-void km_nthw_rcp_qw0_sel_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_qw0_sel_a(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_sel_a, val);
 };
 
-void km_nthw_rcp_qw0_sel_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_qw0_sel_b(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw0_sel_b, val);
 };
 
-void km_nthw_rcp_qw4_dyn(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_qw4_dyn(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw4_dyn, val);
 };
 
-void km_nthw_rcp_qw4_ofs(const struct km_nthw *p, int32_t val)
+void nthw_km_rcp_qw4_ofs(const struct km_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw4_ofs, val);
 };
 
-void km_nthw_rcp_qw4_sel_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_qw4_sel_a(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw4_sel_a, val);
 };
 
-void km_nthw_rcp_qw4_sel_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_qw4_sel_b(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_qw4_sel_b, val);
 };
 
-void km_nthw_rcp_dw8_dyn(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dw8_dyn(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_dw8_dyn, val);
 };
 
-void km_nthw_rcp_swx_cch(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_swx_cch(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_swx_cch, val);
 };
 
-void km_nthw_rcp_dw8_ofs(const struct km_nthw *p, int32_t val)
+void nthw_km_rcp_dw8_ofs(const struct km_nthw *p, int32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_dw8_ofs, val);
 };
 
-void km_nthw_rcp_dw8_sel_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dw8_sel_a(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_dw8_sel_a, val);
 };
 
-void km_nthw_rcp_dw8_sel_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dw8_sel_b(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_dw8_sel_b, val);
 };
 
-void km_nthw_rcp_dw10_dyn(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dw10_dyn(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_dw10_dyn, val);
 };
 
-void km_nthw_rcp_dw10_ofs(const struct km_nthw *p, int32_t val)
+void nthw_km_rcp_dw10_ofs(const struct km_nthw *p, int32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_dw10_ofs, val);
 };
 
-void km_nthw_rcp_dw10_sel_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dw10_sel_a(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_dw10_sel_a, val);
 };
 
-void km_nthw_rcp_dw10_sel_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dw10_sel_b(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_dw10_sel_b, val);
 };
 
-void km_nthw_rcp_swx_sel_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_swx_sel_a(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_swx_sel_a, val);
 };
 
-void km_nthw_rcp_swx_sel_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_swx_sel_b(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_swx_sel_b, val);
 };
 
-void km_nthw_rcp_mask_b(const struct km_nthw *p, const uint32_t *val)
+void nthw_km_rcp_mask_b(const struct km_nthw *p, const uint32_t *val)
 {
 	nthw_field_set_val(p->mp_rcp_data_mask_b, val, p->mp_rcp_data_mask_b->mn_words);
 };
 
-void km_nthw_rcp_mask_da(const struct km_nthw *p, const uint32_t *val)
+void nthw_km_rcp_mask_da(const struct km_nthw *p, const uint32_t *val)
 {
 	nthw_field_set_val(p->mp_rcp_data_mask_a, val, p->mp_rcp_data_mask_a->mn_words);
 };	/* for DW8/DW10 from v6+ */
 
-void km_nthw_rcp_dual(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dual(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_dual, val);
 };
 
-void km_nthw_rcp_paired(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_paired(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_paired, val);
 };
 
-void km_nthw_rcp_el_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_el_a(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_el_a, val);
 };
 
-void km_nthw_rcp_el_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_el_b(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_el_b, val);
 };
 
-void km_nthw_rcp_info_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_info_a(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_info_a, val);
 };
 
-void km_nthw_rcp_info_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_info_b(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_info_b, val);
 };
 
-void km_nthw_rcp_ftm_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_ftm_a(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ftm_a, val);
 };
 
-void km_nthw_rcp_ftm_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_ftm_b(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ftm_b, val);
 };
 
-void km_nthw_rcp_bank_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_bank_a(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_bank_a, val);
 };
 
-void km_nthw_rcp_bank_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_bank_b(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_bank_b, val);
 };
 
-void km_nthw_rcp_kl_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_kl_a(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_kl_a, val);
 };
 
-void km_nthw_rcp_kl_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_kl_b(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_kl_b, val);
 };
 
-void km_nthw_rcp_keyway_a(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_keyway_a(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_keyway_a, val);
 };
 
-void km_nthw_rcp_keyway_b(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_keyway_b(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_rcp_data_keyway_b, val);
 };
 
-void km_nthw_rcp_synergy_mode(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_synergy_mode(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_synergy_mode, val);
 };
 
-void km_nthw_rcp_dw0_b_dyn(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dw0_b_dyn(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_dw0_b_dyn, val);
 };
 
-void km_nthw_rcp_dw0_b_ofs(const struct km_nthw *p, int32_t val)
+void nthw_km_rcp_dw0_b_ofs(const struct km_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_dw0_b_ofs, val);
 };
 
-void km_nthw_rcp_dw2_b_dyn(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_dw2_b_dyn(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_dw2_b_dyn, val);
 };
 
-void km_nthw_rcp_dw2_b_ofs(const struct km_nthw *p, int32_t val)
+void nthw_km_rcp_dw2_b_ofs(const struct km_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_dw2_b_ofs, val);
 };
 
-void km_nthw_rcp_sw4_b_dyn(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_sw4_b_dyn(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw4_b_dyn, val);
 };
 
-void km_nthw_rcp_sw4_b_ofs(const struct km_nthw *p, int32_t val)
+void nthw_km_rcp_sw4_b_ofs(const struct km_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw4_b_ofs, val);
 };
 
-void km_nthw_rcp_sw5_b_dyn(const struct km_nthw *p, uint32_t val)
+void nthw_km_rcp_sw5_b_dyn(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw5_b_dyn, val);
 };
 
-void km_nthw_rcp_sw5_b_ofs(const struct km_nthw *p, int32_t val)
+void nthw_km_rcp_sw5_b_ofs(const struct km_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_sw5_b_ofs, val);
 };
 
-void km_nthw_rcp_flush(const struct km_nthw *p)
+void nthw_km_rcp_flush(const struct km_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
 };
 
 /* CAM */
-void km_nthw_cam_select(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_select(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_addr, val);
 };
 
-void km_nthw_cam_cnt(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_cnt(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_cnt, val);
 };
 
-void km_nthw_cam_w0(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_w0(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_w0, val);
 };
 
-void km_nthw_cam_w1(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_w1(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_w1, val);
 };
 
-void km_nthw_cam_w2(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_w2(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_w2, val);
 };
 
-void km_nthw_cam_w3(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_w3(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_w3, val);
 };
 
-void km_nthw_cam_w4(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_w4(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_w4, val);
 };
 
-void km_nthw_cam_w5(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_w5(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_w5, val);
 };
 
-void km_nthw_cam_ft0(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_ft0(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_ft0, val);
 };
 
-void km_nthw_cam_ft1(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_ft1(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_ft1, val);
 };
 
-void km_nthw_cam_ft2(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_ft2(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_ft2, val);
 };
 
-void km_nthw_cam_ft3(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_ft3(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_ft3, val);
 };
 
-void km_nthw_cam_ft4(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_ft4(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_ft4, val);
 };
 
-void km_nthw_cam_ft5(const struct km_nthw *p, uint32_t val)
+void nthw_km_cam_ft5(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_cam_data_ft5, val);
 };
 
-void km_nthw_cam_flush(const struct km_nthw *p)
+void nthw_km_cam_flush(const struct km_nthw *p)
 {
 	nthw_register_flush(p->mp_cam_ctrl, 1);
 	nthw_register_flush(p->mp_cam_data, 1);
 };
 
 /* TCAM */
-void km_nthw_tcam_select(const struct km_nthw *p, uint32_t val)
+void nthw_km_tcam_select(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tcam_addr, val);
 };
 
-void km_nthw_tcam_cnt(const struct km_nthw *p, uint32_t val)
+void nthw_km_tcam_cnt(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tcam_cnt, val);
 };
 
-void km_nthw_tcam_t(const struct km_nthw *p, uint32_t *val)
+void nthw_km_tcam_t(const struct km_nthw *p, uint32_t *val)
 {
 	nthw_field_set_val(p->mp_tcam_data_t, val, 3);
 };
 
-void km_nthw_tcam_flush(const struct km_nthw *p)
+void nthw_km_tcam_flush(const struct km_nthw *p)
 {
 	nthw_register_flush(p->mp_tcam_ctrl, 1);
 	nthw_register_flush(p->mp_tcam_data, 1);
 };
 
 /* TCI */
-void km_nthw_tci_select(const struct km_nthw *p, uint32_t val)
+void nthw_km_tci_select(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tci_addr, val);
 };
 
-void km_nthw_tci_cnt(const struct km_nthw *p, uint32_t val)
+void nthw_km_tci_cnt(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tci_cnt, val);
 };
 
-void km_nthw_tci_color(const struct km_nthw *p, uint32_t val)
+void nthw_km_tci_color(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tci_data_color, val);
 };
 
-void km_nthw_tci_ft(const struct km_nthw *p, uint32_t val)
+void nthw_km_tci_ft(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tci_data_ft, val);
 };
 
-void km_nthw_tci_flush(const struct km_nthw *p)
+void nthw_km_tci_flush(const struct km_nthw *p)
 {
 	nthw_register_flush(p->mp_tci_ctrl, 1);
 	nthw_register_flush(p->mp_tci_data, 1);
 };
 
 /* TCQ */
-void km_nthw_tcq_select(const struct km_nthw *p, uint32_t val)
+void nthw_km_tcq_select(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tcq_addr, val);
 };
 
-void km_nthw_tcq_cnt(const struct km_nthw *p, uint32_t val)
+void nthw_km_tcq_cnt(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tcq_cnt, val);
 };
 
-void km_nthw_tcq_bank_mask(const struct km_nthw *p, uint32_t val)
+void nthw_km_tcq_bank_mask(const struct km_nthw *p, uint32_t val)
 {
 	CHECK_AND_SET_VALUE(p->mp_tcq_data_bank_mask, val);
 };
 
-void km_nthw_tcq_qual(const struct km_nthw *p, uint32_t val)
+void nthw_km_tcq_qual(const struct km_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_tcq_data_qual, val);
 };
 
-void km_nthw_tcq_flush(const struct km_nthw *p)
+void nthw_km_tcq_flush(const struct km_nthw *p)
 {
 	nthw_register_flush(p->mp_tcq_ctrl, 1);
 	nthw_register_flush(p->mp_tcq_data, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h
index 510aaaae98..9278c60241 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h
@@ -14,97 +14,97 @@ struct km_nthw;
 
 typedef struct km_nthw km_nthw_t;
 
-struct km_nthw *km_nthw_new(void);
-void km_nthw_delete(struct km_nthw *p);
-int km_nthw_init(struct km_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct km_nthw *nthw_km_new(void);
+void nthw_km_delete(struct km_nthw *p);
+int nthw_km_init(struct km_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int km_nthw_setup(struct km_nthw *p, int n_idx, int n_idx_cnt);
-void km_nthw_set_debug_mode(struct km_nthw *p, unsigned int n_debug_mode);
+void nthw_km_set_debug_mode(struct km_nthw *p, unsigned int n_debug_mode);
 
 /* RCP initial v3 */
-void km_nthw_rcp_select(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_cnt(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_qw0_dyn(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_qw0_ofs(const struct km_nthw *p, int32_t val);
-void km_nthw_rcp_qw0_sel_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_qw0_sel_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_qw4_dyn(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_qw4_ofs(const struct km_nthw *p, int32_t val);
-void km_nthw_rcp_qw4_sel_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_qw4_sel_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_select(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_cnt(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_qw0_dyn(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_qw0_ofs(const struct km_nthw *p, int32_t val);
+void nthw_km_rcp_qw0_sel_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_qw0_sel_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_qw4_dyn(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_qw4_ofs(const struct km_nthw *p, int32_t val);
+void nthw_km_rcp_qw4_sel_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_qw4_sel_b(const struct km_nthw *p, uint32_t val);
 /* subst in v6 */
-void km_nthw_rcp_dw8_dyn(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_dw8_ofs(const struct km_nthw *p, int32_t val);
-void km_nthw_rcp_dw8_sel_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_dw8_sel_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_dw10_dyn(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_dw10_ofs(const struct km_nthw *p, int32_t val);
-void km_nthw_rcp_dw10_sel_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_dw10_sel_b(const struct km_nthw *p, uint32_t val);
-
-void km_nthw_rcp_swx_cch(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_swx_sel_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_swx_sel_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_mask_da(const struct km_nthw *p, const uint32_t *val);
-void km_nthw_rcp_mask_b(const struct km_nthw *p, const uint32_t *val);
-void km_nthw_rcp_dual(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_paired(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_el_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_el_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_info_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_info_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_ftm_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_ftm_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_bank_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_bank_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_kl_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_kl_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_keyway_a(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_keyway_b(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_synergy_mode(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_dw0_b_dyn(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_dw0_b_ofs(const struct km_nthw *p, int32_t val);
-void km_nthw_rcp_dw2_b_dyn(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_dw2_b_ofs(const struct km_nthw *p, int32_t val);
-void km_nthw_rcp_sw4_b_dyn(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_sw4_b_ofs(const struct km_nthw *p, int32_t val);
-void km_nthw_rcp_sw5_b_dyn(const struct km_nthw *p, uint32_t val);
-void km_nthw_rcp_sw5_b_ofs(const struct km_nthw *p, int32_t val);
-void km_nthw_rcp_flush(const struct km_nthw *p);
+void nthw_km_rcp_dw8_dyn(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_dw8_ofs(const struct km_nthw *p, int32_t val);
+void nthw_km_rcp_dw8_sel_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_dw8_sel_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_dw10_dyn(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_dw10_ofs(const struct km_nthw *p, int32_t val);
+void nthw_km_rcp_dw10_sel_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_dw10_sel_b(const struct km_nthw *p, uint32_t val);
+
+void nthw_km_rcp_swx_cch(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_swx_sel_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_swx_sel_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_mask_da(const struct km_nthw *p, const uint32_t *val);
+void nthw_km_rcp_mask_b(const struct km_nthw *p, const uint32_t *val);
+void nthw_km_rcp_dual(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_paired(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_el_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_el_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_info_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_info_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_ftm_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_ftm_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_bank_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_bank_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_kl_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_kl_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_keyway_a(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_keyway_b(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_synergy_mode(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_dw0_b_dyn(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_dw0_b_ofs(const struct km_nthw *p, int32_t val);
+void nthw_km_rcp_dw2_b_dyn(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_dw2_b_ofs(const struct km_nthw *p, int32_t val);
+void nthw_km_rcp_sw4_b_dyn(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_sw4_b_ofs(const struct km_nthw *p, int32_t val);
+void nthw_km_rcp_sw5_b_dyn(const struct km_nthw *p, uint32_t val);
+void nthw_km_rcp_sw5_b_ofs(const struct km_nthw *p, int32_t val);
+void nthw_km_rcp_flush(const struct km_nthw *p);
 /* CAM */
-void km_nthw_cam_select(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_cnt(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_w0(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_w1(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_w2(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_w3(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_w4(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_w5(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_ft0(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_ft1(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_ft2(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_ft3(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_ft4(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_ft5(const struct km_nthw *p, uint32_t val);
-void km_nthw_cam_flush(const struct km_nthw *p);
+void nthw_km_cam_select(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_cnt(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_w0(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_w1(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_w2(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_w3(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_w4(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_w5(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_ft0(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_ft1(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_ft2(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_ft3(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_ft4(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_ft5(const struct km_nthw *p, uint32_t val);
+void nthw_km_cam_flush(const struct km_nthw *p);
 /* TCAM */
-void km_nthw_tcam_select(const struct km_nthw *p, uint32_t val);
-void km_nthw_tcam_cnt(const struct km_nthw *p, uint32_t val);
-void km_nthw_tcam_t(const struct km_nthw *p, uint32_t *val);
-void km_nthw_tcam_flush(const struct km_nthw *p);
+void nthw_km_tcam_select(const struct km_nthw *p, uint32_t val);
+void nthw_km_tcam_cnt(const struct km_nthw *p, uint32_t val);
+void nthw_km_tcam_t(const struct km_nthw *p, uint32_t *val);
+void nthw_km_tcam_flush(const struct km_nthw *p);
 /* TCI */
-void km_nthw_tci_select(const struct km_nthw *p, uint32_t val);
-void km_nthw_tci_cnt(const struct km_nthw *p, uint32_t val);
-void km_nthw_tci_color(const struct km_nthw *p, uint32_t val);
-void km_nthw_tci_ft(const struct km_nthw *p, uint32_t val);
-void km_nthw_tci_flush(const struct km_nthw *p);
+void nthw_km_tci_select(const struct km_nthw *p, uint32_t val);
+void nthw_km_tci_cnt(const struct km_nthw *p, uint32_t val);
+void nthw_km_tci_color(const struct km_nthw *p, uint32_t val);
+void nthw_km_tci_ft(const struct km_nthw *p, uint32_t val);
+void nthw_km_tci_flush(const struct km_nthw *p);
 /* TCQ */
-void km_nthw_tcq_select(const struct km_nthw *p, uint32_t val);
-void km_nthw_tcq_cnt(const struct km_nthw *p, uint32_t val);
-void km_nthw_tcq_bank_mask(const struct km_nthw *p, uint32_t val);
-void km_nthw_tcq_qual(const struct km_nthw *p, uint32_t val);
+void nthw_km_tcq_select(const struct km_nthw *p, uint32_t val);
+void nthw_km_tcq_cnt(const struct km_nthw *p, uint32_t val);
+void nthw_km_tcq_bank_mask(const struct km_nthw *p, uint32_t val);
+void nthw_km_tcq_qual(const struct km_nthw *p, uint32_t val);
 
-void km_nthw_tcq_flush(const struct km_nthw *p);
+void nthw_km_tcq_flush(const struct km_nthw *p);
 
 struct km_nthw {
 	uint8_t m_physical_adapter_no;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
index 132ee14baf..664d2d1dea 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
@@ -13,12 +13,12 @@
 
 #include "flow_nthw_pdb.h"
 
-void pdb_nthw_set_debug_mode(struct pdb_nthw *p, unsigned int n_debug_mode)
+void nthw_pdb_set_debug_mode(struct pdb_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_pdb, n_debug_mode);
 }
 
-struct pdb_nthw *pdb_nthw_new(void)
+struct pdb_nthw *nthw_pdb_new(void)
 {
 	struct pdb_nthw *p = malloc(sizeof(struct pdb_nthw));
 
@@ -28,7 +28,7 @@ struct pdb_nthw *pdb_nthw_new(void)
 	return p;
 }
 
-void pdb_nthw_delete(struct pdb_nthw *p)
+void nthw_pdb_delete(struct pdb_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -36,7 +36,7 @@ void pdb_nthw_delete(struct pdb_nthw *p)
 	}
 }
 
-int pdb_nthw_init(struct pdb_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_pdb_init(struct pdb_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_PDB, n_instance);
@@ -92,119 +92,119 @@ int pdb_nthw_init(struct pdb_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 }
 
 /* RCP */
-void pdb_nthw_rcp_select(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_select(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
-void pdb_nthw_rcp_cnt(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_cnt(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
-void pdb_nthw_rcp_descriptor(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_descriptor(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_descriptor, val);
 }
 
-void pdb_nthw_rcp_desc_len(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_desc_len(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_desc_len, val);
 }
 
-void pdb_nthw_rcp_tx_port(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_tx_port(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tx_port, val);
 }
 
-void pdb_nthw_rcp_tx_ignore(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_tx_ignore(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tx_ignore, val);
 }
 
-void pdb_nthw_rcp_tx_now(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_tx_now(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tx_now, val);
 }
 
-void pdb_nthw_rcp_crc_overwrite(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_crc_overwrite(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_crc_overwrite, val);
 }
 
-void pdb_nthw_rcp_align(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_align(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_align, val);
 }
 
-void pdb_nthw_rcp_ofs0_dyn(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_ofs0_dyn(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ofs0_dyn, val);
 }
 
-void pdb_nthw_rcp_ofs0_rel(const struct pdb_nthw *p, int32_t val)
+void nthw_pdb_rcp_ofs0_rel(const struct pdb_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ofs0_rel, val);
 }
 
-void pdb_nthw_rcp_ofs1_dyn(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_ofs1_dyn(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ofs1_dyn, val);
 }
 
-void pdb_nthw_rcp_ofs1_rel(const struct pdb_nthw *p, int32_t val)
+void nthw_pdb_rcp_ofs1_rel(const struct pdb_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ofs1_rel, val);
 }
 
-void pdb_nthw_rcp_ofs2_dyn(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_ofs2_dyn(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ofs2_dyn, val);
 }
 
-void pdb_nthw_rcp_ofs2_rel(const struct pdb_nthw *p, int32_t val)
+void nthw_pdb_rcp_ofs2_rel(const struct pdb_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ofs2_rel, val);
 }
 
-void pdb_nthw_rcp_ip_prot_tnl(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_ip_prot_tnl(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ip_prot_tnl, val);
 }
 
-void pdb_nthw_rcp_ppc_hsh(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_ppc_hsh(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ppc_hsh, val);
 }
 
-void pdb_nthw_rcp_duplicate_en(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_duplicate_en(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_duplicate_en, val);
 }
 
-void pdb_nthw_rcp_duplicate_bit(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_rcp_duplicate_bit(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_duplicate_bit, val);
 }
 
-void pdb_nthw_rcp_flush(const struct pdb_nthw *p)
+void nthw_pdb_rcp_flush(const struct pdb_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
 
 /* CONFIG */
-void pdb_nthw_config_ts_format(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_config_ts_format(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_config_ts_format, val);
 }
 
-void pdb_nthw_config_port_ofs(const struct pdb_nthw *p, uint32_t val)
+void nthw_pdb_config_port_ofs(const struct pdb_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_config_port_ofs, val);
 }
 
-void pdb_nthw_config_flush(const struct pdb_nthw *p)
+void nthw_pdb_config_flush(const struct pdb_nthw *p)
 {
 	nthw_register_flush(p->mp_config, 1);
 }
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h
index aafe12d3e0..bd220ed8d7 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h
@@ -46,40 +46,40 @@ struct pdb_nthw {
 
 typedef struct pdb_nthw pdb_nthw_t;
 
-struct pdb_nthw *pdb_nthw_new(void);
-void pdb_nthw_delete(struct pdb_nthw *p);
-int pdb_nthw_init(struct pdb_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct pdb_nthw *nthw_pdb_new(void);
+void nthw_pdb_delete(struct pdb_nthw *p);
+int nthw_pdb_init(struct pdb_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int pdb_nthw_setup(struct pdb_nthw *p, int n_idx, int n_idx_cnt);
-void pdb_nthw_set_debug_mode(struct pdb_nthw *p, unsigned int n_debug_mode);
+void nthw_pdb_set_debug_mode(struct pdb_nthw *p, unsigned int n_debug_mode);
 
 /* RCP */
-void pdb_nthw_rcp_select(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_cnt(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_select(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_cnt(const struct pdb_nthw *p, uint32_t val);
 
-void pdb_nthw_rcp_descriptor(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_desc_len(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_tx_port(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_tx_ignore(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_tx_now(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_crc_overwrite(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_align(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_ofs0_dyn(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_ofs0_rel(const struct pdb_nthw *p, int32_t val);
-void pdb_nthw_rcp_ofs1_dyn(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_ofs1_rel(const struct pdb_nthw *p, int32_t val);
-void pdb_nthw_rcp_ofs2_dyn(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_ofs2_rel(const struct pdb_nthw *p, int32_t val);
-void pdb_nthw_rcp_ip_prot_tnl(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_ppc_hsh(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_duplicate_en(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_duplicate_bit(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_rcp_flush(const struct pdb_nthw *p);
+void nthw_pdb_rcp_descriptor(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_desc_len(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_tx_port(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_tx_ignore(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_tx_now(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_crc_overwrite(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_align(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_ofs0_dyn(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_ofs0_rel(const struct pdb_nthw *p, int32_t val);
+void nthw_pdb_rcp_ofs1_dyn(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_ofs1_rel(const struct pdb_nthw *p, int32_t val);
+void nthw_pdb_rcp_ofs2_dyn(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_ofs2_rel(const struct pdb_nthw *p, int32_t val);
+void nthw_pdb_rcp_ip_prot_tnl(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_ppc_hsh(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_duplicate_en(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_duplicate_bit(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_rcp_flush(const struct pdb_nthw *p);
 
 /* CONFIG */
-void pdb_nthw_config_ts_format(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_config_port_ofs(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_config_port_ofs(const struct pdb_nthw *p, uint32_t val);
-void pdb_nthw_config_flush(const struct pdb_nthw *p);
+void nthw_pdb_config_ts_format(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_config_port_ofs(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_config_port_ofs(const struct pdb_nthw *p, uint32_t val);
+void nthw_pdb_config_flush(const struct pdb_nthw *p);
 
 #endif	/* __FLOW_NTHW_PDB_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
index d2c7130f2e..d82a22ba8a 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
@@ -13,12 +13,12 @@
 
 #include "flow_nthw_qsl.h"
 
-void qsl_nthw_set_debug_mode(struct qsl_nthw *p, unsigned int n_debug_mode)
+void nthw_qsl_set_debug_mode(struct qsl_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_qsl, n_debug_mode);
 }
 
-struct qsl_nthw *qsl_nthw_new(void)
+struct qsl_nthw *nthw_qsl_new(void)
 {
 	struct qsl_nthw *p = malloc(sizeof(struct qsl_nthw));
 
@@ -28,7 +28,7 @@ struct qsl_nthw *qsl_nthw_new(void)
 	return p;
 }
 
-void qsl_nthw_delete(struct qsl_nthw *p)
+void nthw_qsl_delete(struct qsl_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -36,7 +36,7 @@ void qsl_nthw_delete(struct qsl_nthw *p)
 	}
 }
 
-int qsl_nthw_init(struct qsl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_qsl_init(struct qsl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_QSL, n_instance);
@@ -132,163 +132,163 @@ int qsl_nthw_init(struct qsl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 }
 
 /* RCP */
-void qsl_nthw_rcp_select(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_select(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 };
 
-void qsl_nthw_rcp_cnt(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_cnt(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
-void qsl_nthw_rcp_discard(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_discard(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_discard, val);
 }
 
-void qsl_nthw_rcp_drop(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_drop(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_drop, val);
 }
 
-void qsl_nthw_rcp_tbl_lo(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_tbl_lo(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tbl_lo, val);
 }
-void qsl_nthw_rcp_tbl_hi(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_tbl_hi(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tbl_hi, val);
 }
-void qsl_nthw_rcp_tbl_idx(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_tbl_idx(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tbl_idx, val);
 }
 
-void qsl_nthw_rcp_tbl_msk(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_tbl_msk(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tbl_msk, val);
 }
 
-void qsl_nthw_rcp_lr(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_lr(const struct qsl_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_lr)
 		nthw_field_set_val32(p->mp_rcp_data_lr, val);
 }
 
-void qsl_nthw_rcp_tsa(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_tsa(const struct qsl_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_tsa)
 		nthw_field_set_val32(p->mp_rcp_data_tsa, val);
 }
 
-void qsl_nthw_rcp_vli(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_rcp_vli(const struct qsl_nthw *p, uint32_t val)
 {
 	if (p->mp_rcp_data_vli)
 		nthw_field_set_val32(p->mp_rcp_data_vli, val);
 }
 
-void qsl_nthw_rcp_flush(const struct qsl_nthw *p)
+void nthw_qsl_rcp_flush(const struct qsl_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
 
 /* QST */
-void qsl_nthw_qst_select(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qst_select(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_qst_addr, val);
 }
 
-void qsl_nthw_qst_cnt(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qst_cnt(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_qst_cnt, val);
 }
 
-void qsl_nthw_qst_queue(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qst_queue(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_qst_data_queue, val);
 }
 
-void qsl_nthw_qst_en(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qst_en(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_qst_data_en, val);
 }
 
-void qsl_nthw_qst_tx_port(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qst_tx_port(const struct qsl_nthw *p, uint32_t val)
 {
 	if (p->mp_qst_data_tx_port)
 		nthw_field_set_val32(p->mp_qst_data_tx_port, val);
 }
 
-void qsl_nthw_qst_lre(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qst_lre(const struct qsl_nthw *p, uint32_t val)
 {
 	if (p->mp_qst_data_lre)
 		nthw_field_set_val32(p->mp_qst_data_lre, val);
 }
 
-void qsl_nthw_qst_tci(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qst_tci(const struct qsl_nthw *p, uint32_t val)
 {
 	if (p->mp_qst_data_tci)
 		nthw_field_set_val32(p->mp_qst_data_tci, val);
 }
 
-void qsl_nthw_qst_ven(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qst_ven(const struct qsl_nthw *p, uint32_t val)
 {
 	if (p->mp_qst_data_ven)
 		nthw_field_set_val32(p->mp_qst_data_ven, val);
 }
 
-void qsl_nthw_qst_flush(const struct qsl_nthw *p)
+void nthw_qsl_qst_flush(const struct qsl_nthw *p)
 {
 	nthw_register_flush(p->mp_qst_ctrl, 1);
 	nthw_register_flush(p->mp_qst_data, 1);
 }
 
 /* QEN */
-void qsl_nthw_qen_select(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qen_select(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_qen_addr, val);
 }
 
-void qsl_nthw_qen_cnt(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qen_cnt(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_qen_cnt, val);
 }
 
-void qsl_nthw_qen_en(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_qen_en(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_qen_data_en, val);
 }
 
-void qsl_nthw_qen_flush(const struct qsl_nthw *p)
+void nthw_qsl_qen_flush(const struct qsl_nthw *p)
 {
 	nthw_register_flush(p->mp_qen_ctrl, 1);
 	nthw_register_flush(p->mp_qen_data, 1);
 }
 
 /* UNMQ */
-void qsl_nthw_unmq_select(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_unmq_select(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_unmq_addr, val);
 }
 
-void qsl_nthw_unmq_cnt(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_unmq_cnt(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_unmq_cnt, val);
 }
 
-void qsl_nthw_unmq_dest_queue(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_unmq_dest_queue(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_unmq_data_dest_queue, val);
 }
 
-void qsl_nthw_unmq_en(const struct qsl_nthw *p, uint32_t val)
+void nthw_qsl_unmq_en(const struct qsl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_unmq_data_en, val);
 }
 
-void qsl_nthw_unmq_flush(const struct qsl_nthw *p)
+void nthw_qsl_unmq_flush(const struct qsl_nthw *p)
 {
 	nthw_register_flush(p->mp_unmq_ctrl, 1);
 	nthw_register_flush(p->mp_unmq_data, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h
index 1bbcd1cea6..b57546a09c 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h
@@ -66,48 +66,48 @@ struct qsl_nthw {
 
 typedef struct qsl_nthw qsl_nthw_t;
 
-struct qsl_nthw *qsl_nthw_new(void);
-void qsl_nthw_delete(struct qsl_nthw *p);
-int qsl_nthw_init(struct qsl_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct qsl_nthw *nthw_qsl_new(void);
+void nthw_qsl_delete(struct qsl_nthw *p);
+int nthw_qsl_init(struct qsl_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
-void qsl_nthw_set_debug_mode(struct qsl_nthw *p, unsigned int n_debug_mode);
+void nthw_qsl_set_debug_mode(struct qsl_nthw *p, unsigned int n_debug_mode);
 
 /* RCP */
-void qsl_nthw_rcp_select(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_cnt(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_discard(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_drop(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_tbl_lo(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_tbl_hi(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_tbl_idx(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_tbl_msk(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_lr(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_tsa(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_vli(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_rcp_flush(const struct qsl_nthw *p);
+void nthw_qsl_rcp_select(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_cnt(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_discard(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_drop(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_tbl_lo(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_tbl_hi(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_tbl_idx(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_tbl_msk(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_lr(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_tsa(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_vli(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_rcp_flush(const struct qsl_nthw *p);
 
 /* QST */
-void qsl_nthw_qst_select(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qst_cnt(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qst_queue(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qst_en(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qst_tx_port(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qst_lre(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qst_tci(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qst_ven(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qst_flush(const struct qsl_nthw *p);
+void nthw_qsl_qst_select(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qst_cnt(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qst_queue(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qst_en(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qst_tx_port(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qst_lre(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qst_tci(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qst_ven(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qst_flush(const struct qsl_nthw *p);
 
 /* QEN */
-void qsl_nthw_qen_select(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qen_cnt(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qen_en(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_qen_flush(const struct qsl_nthw *p);
+void nthw_qsl_qen_select(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qen_cnt(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qen_en(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_qen_flush(const struct qsl_nthw *p);
 
 /* UNMQ */
-void qsl_nthw_unmq_select(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_unmq_cnt(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_unmq_dest_queue(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_unmq_en(const struct qsl_nthw *p, uint32_t val);
-void qsl_nthw_unmq_flush(const struct qsl_nthw *p);
+void nthw_qsl_unmq_select(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_unmq_cnt(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_unmq_dest_queue(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_unmq_en(const struct qsl_nthw *p, uint32_t val);
+void nthw_qsl_unmq_flush(const struct qsl_nthw *p);
 
 #endif	/* __FLOW_NTHW_QSL_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
index 1bb69e740f..07e6d38731 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
@@ -12,12 +12,12 @@
 
 #include "flow_nthw_rpp_lr.h"
 
-void rpp_lr_nthw_set_debug_mode(struct rpp_lr_nthw *p, unsigned int n_debug_mode)
+void nthw_rpp_lr_set_debug_mode(struct rpp_lr_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_rpp_lr, n_debug_mode);
 }
 
-struct rpp_lr_nthw *rpp_lr_nthw_new(void)
+struct rpp_lr_nthw *nthw_rpp_lr_new(void)
 {
 	struct rpp_lr_nthw *p = malloc(sizeof(struct rpp_lr_nthw));
 
@@ -27,7 +27,7 @@ struct rpp_lr_nthw *rpp_lr_nthw_new(void)
 	return p;
 }
 
-void rpp_lr_nthw_delete(struct rpp_lr_nthw *p)
+void nthw_rpp_lr_delete(struct rpp_lr_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -35,7 +35,7 @@ void rpp_lr_nthw_delete(struct rpp_lr_nthw *p)
 	}
 }
 
-int rpp_lr_nthw_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_rpp_lr_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_RPP_LR, n_instance);
@@ -83,25 +83,25 @@ int rpp_lr_nthw_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void rpp_lr_nthw_rcp_select(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_rcp_select(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_rcp_addr);
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
-void rpp_lr_nthw_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_rcp_cnt);
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
-void rpp_lr_nthw_rcp_exp(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_rcp_exp(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_rcp_data_exp);
 	nthw_field_set_val32(p->mp_rcp_data_exp, val);
 }
 
-void rpp_lr_nthw_rcp_flush(const struct rpp_lr_nthw *p)
+void nthw_rpp_lr_rcp_flush(const struct rpp_lr_nthw *p)
 {
 	RTE_ASSERT(p->mp_rcp_ctrl);
 	RTE_ASSERT(p->mp_rcp_data);
@@ -109,49 +109,49 @@ void rpp_lr_nthw_rcp_flush(const struct rpp_lr_nthw *p)
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
 
-void rpp_lr_nthw_ifr_rcp_select(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_ifr_rcp_select(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_ifr_rcp_addr);
 	nthw_field_set_val32(p->mp_ifr_rcp_addr, val);
 }
 
-void rpp_lr_nthw_ifr_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_ifr_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_ifr_rcp_cnt);
 	nthw_field_set_val32(p->mp_ifr_rcp_cnt, val);
 }
 
-void rpp_lr_nthw_ifr_rcp_ipv4_en(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_ifr_rcp_ipv4_en(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	if (p->mp_ifr_rcp_data_ipv4_en)
 		nthw_field_set_val32(p->mp_ifr_rcp_data_ipv4_en, val);
 }
 
-void rpp_lr_nthw_ifr_rcp_ipv4_df_drop(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_ifr_rcp_ipv4_df_drop(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	if (p->mp_ifr_rcp_data_ipv4_df_drop)
 		nthw_field_set_val32(p->mp_ifr_rcp_data_ipv4_df_drop, val);
 }
 
-void rpp_lr_nthw_ifr_rcp_ipv6_en(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_ifr_rcp_ipv6_en(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	if (p->mp_ifr_rcp_data_ipv6_en)
 		nthw_field_set_val32(p->mp_ifr_rcp_data_ipv6_en, val);
 }
 
-void rpp_lr_nthw_ifr_rcp_ipv6_drop(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_ifr_rcp_ipv6_drop(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	if (p->mp_ifr_rcp_data_ipv6_drop)
 		nthw_field_set_val32(p->mp_ifr_rcp_data_ipv6_drop, val);
 }
 
-void rpp_lr_nthw_ifr_rcp_mtu(const struct rpp_lr_nthw *p, uint32_t val)
+void nthw_rpp_lr_ifr_rcp_mtu(const struct rpp_lr_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_ifr_rcp_data_mtu);
 	nthw_field_set_val32(p->mp_ifr_rcp_data_mtu, val);
 }
 
-void rpp_lr_nthw_ifr_rcp_flush(const struct rpp_lr_nthw *p)
+void nthw_rpp_lr_ifr_rcp_flush(const struct rpp_lr_nthw *p)
 {
 	RTE_ASSERT(p->mp_ifr_rcp_ctrl);
 	RTE_ASSERT(p->mp_ifr_rcp_data);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h
index bdb2e5fa54..e68df10cc2 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h
@@ -35,27 +35,27 @@ struct rpp_lr_nthw {
 	nthw_field_t *mp_ifr_rcp_data_ipv6_drop;
 };
 
-struct rpp_lr_nthw *rpp_lr_nthw_new(void);
-void rpp_lr_nthw_delete(struct rpp_lr_nthw *p);
-int rpp_lr_nthw_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct rpp_lr_nthw *nthw_rpp_lr_new(void);
+void nthw_rpp_lr_delete(struct rpp_lr_nthw *p);
+int nthw_rpp_lr_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int rpp_lr_nthw_setup(struct rpp_lr_nthw *p, int n_idx, int n_idx_cnt);
-void rpp_lr_nthw_set_debug_mode(struct rpp_lr_nthw *p, unsigned int n_debug_mode);
+void nthw_rpp_lr_set_debug_mode(struct rpp_lr_nthw *p, unsigned int n_debug_mode);
 
 /* RCP */
-void rpp_lr_nthw_rcp_select(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_rcp_exp(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_rcp_flush(const struct rpp_lr_nthw *p);
+void nthw_rpp_lr_rcp_select(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_rcp_exp(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_rcp_flush(const struct rpp_lr_nthw *p);
 
 /* RCP IFR */
-void rpp_lr_nthw_ifr_rcp_select(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_ifr_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_ifr_rcp_ipv4_en(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_ifr_rcp_ipv4_df_drop(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_ifr_rcp_ipv6_en(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_ifr_rcp_ipv6_drop(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_ifr_rcp_mtu(const struct rpp_lr_nthw *p, uint32_t val);
-void rpp_lr_nthw_ifr_rcp_flush(const struct rpp_lr_nthw *p);
+void nthw_rpp_lr_ifr_rcp_select(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_ifr_rcp_cnt(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_ifr_rcp_ipv4_en(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_ifr_rcp_ipv4_df_drop(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_ifr_rcp_ipv6_en(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_ifr_rcp_ipv6_drop(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_ifr_rcp_mtu(const struct rpp_lr_nthw *p, uint32_t val);
+void nthw_rpp_lr_ifr_rcp_flush(const struct rpp_lr_nthw *p);
 
 #endif	/* __FLOW_NTHW_RPP_LR_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
index f5030d1997..afe5597962 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
@@ -13,12 +13,12 @@
 
 #include "flow_nthw_slc_lr.h"
 
-void slc_lr_nthw_set_debug_mode(struct slc_lr_nthw *p, unsigned int n_debug_mode)
+void nthw_slc_lr_set_debug_mode(struct slc_lr_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_slc_lr, n_debug_mode);
 }
 
-struct slc_lr_nthw *slc_lr_nthw_new(void)
+struct slc_lr_nthw *nthw_slc_lr_new(void)
 {
 	struct slc_lr_nthw *p = malloc(sizeof(struct slc_lr_nthw));
 
@@ -28,7 +28,7 @@ struct slc_lr_nthw *slc_lr_nthw_new(void)
 	return p;
 }
 
-void slc_lr_nthw_delete(struct slc_lr_nthw *p)
+void nthw_slc_lr_delete(struct slc_lr_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -36,7 +36,7 @@ void slc_lr_nthw_delete(struct slc_lr_nthw *p)
 	}
 }
 
-int slc_lr_nthw_init(struct slc_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_slc_lr_init(struct slc_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_SLC_LR, n_instance);
@@ -74,52 +74,52 @@ int slc_lr_nthw_init(struct slc_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 }
 
 /* RCP */
-void slc_lr_nthw_rcp_select(const struct slc_lr_nthw *p, uint32_t val)
+void nthw_slc_lr_rcp_select(const struct slc_lr_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
-void slc_lr_nthw_rcp_cnt(const struct slc_lr_nthw *p, uint32_t val)
+void nthw_slc_lr_rcp_cnt(const struct slc_lr_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
-void slc_lr_nthw_rcp_head_slc_en(const struct slc_lr_nthw *p, uint32_t val)
+void nthw_slc_lr_rcp_head_slc_en(const struct slc_lr_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_head_slc_en, val);
 }
 
-void slc_lr_nthw_rcp_head_dyn(const struct slc_lr_nthw *p, uint32_t val)
+void nthw_slc_lr_rcp_head_dyn(const struct slc_lr_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_head_dyn, val);
 }
 
-void slc_lr_nthw_rcp_head_ofs(const struct slc_lr_nthw *p, int32_t val)
+void nthw_slc_lr_rcp_head_ofs(const struct slc_lr_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_head_ofs, val);
 }
 
-void slc_lr_nthw_rcp_tail_slc_en(const struct slc_lr_nthw *p, uint32_t val)
+void nthw_slc_lr_rcp_tail_slc_en(const struct slc_lr_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tail_slc_en, val);
 }
 
-void slc_lr_nthw_rcp_tail_dyn(const struct slc_lr_nthw *p, uint32_t val)
+void nthw_slc_lr_rcp_tail_dyn(const struct slc_lr_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tail_dyn, val);
 }
 
-void slc_lr_nthw_rcp_tail_ofs(const struct slc_lr_nthw *p, int32_t val)
+void nthw_slc_lr_rcp_tail_ofs(const struct slc_lr_nthw *p, int32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_tail_ofs, val);
 }
 
-void slc_lr_nthw_rcp_pcap(const struct slc_lr_nthw *p, uint32_t val)
+void nthw_slc_lr_rcp_pcap(const struct slc_lr_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_pcap, val);
 }
 
-void slc_lr_nthw_rcp_flush(const struct slc_lr_nthw *p)
+void nthw_slc_lr_rcp_flush(const struct slc_lr_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h
index 2eed32c022..6e8860d3dc 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h
@@ -32,23 +32,23 @@ struct slc_lr_nthw {
 
 typedef struct slc_lr_nthw slc_lr_nthw_t;
 
-struct slc_lr_nthw *slc_lr_nthw_new(void);
-void slc_lr_nthw_delete(struct slc_lr_nthw *p);
-int slc_lr_nthw_init(struct slc_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct slc_lr_nthw *nthw_slc_lr_new(void);
+void nthw_slc_lr_delete(struct slc_lr_nthw *p);
+int nthw_slc_lr_init(struct slc_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int slc_lr_nthw_setup(struct slc_lr_nthw *p, int n_idx, int n_idx_cnt);
-void slc_lr_nthw_set_debug_mode(struct slc_lr_nthw *p, unsigned int n_debug_mode);
+void nthw_slc_lr_set_debug_mode(struct slc_lr_nthw *p, unsigned int n_debug_mode);
 
 /* RCP */
-void slc_lr_nthw_rcp_select(const struct slc_lr_nthw *p, uint32_t val);
-void slc_lr_nthw_rcp_cnt(const struct slc_lr_nthw *p, uint32_t val);
-void slc_lr_nthw_rcp_head_slc_en(const struct slc_lr_nthw *p, uint32_t val);
-void slc_lr_nthw_rcp_head_dyn(const struct slc_lr_nthw *p, uint32_t val);
-void slc_lr_nthw_rcp_head_ofs(const struct slc_lr_nthw *p, int32_t val);
-void slc_lr_nthw_rcp_tail_slc_en(const struct slc_lr_nthw *p, uint32_t val);
-void slc_lr_nthw_rcp_tail_dyn(const struct slc_lr_nthw *p, uint32_t val);
-void slc_lr_nthw_rcp_tail_ofs(const struct slc_lr_nthw *p, int32_t val);
-void slc_lr_nthw_rcp_pcap(const struct slc_lr_nthw *p, uint32_t val);
-void slc_lr_nthw_rcp_flush(const struct slc_lr_nthw *p);
+void nthw_slc_lr_rcp_select(const struct slc_lr_nthw *p, uint32_t val);
+void nthw_slc_lr_rcp_cnt(const struct slc_lr_nthw *p, uint32_t val);
+void nthw_slc_lr_rcp_head_slc_en(const struct slc_lr_nthw *p, uint32_t val);
+void nthw_slc_lr_rcp_head_dyn(const struct slc_lr_nthw *p, uint32_t val);
+void nthw_slc_lr_rcp_head_ofs(const struct slc_lr_nthw *p, int32_t val);
+void nthw_slc_lr_rcp_tail_slc_en(const struct slc_lr_nthw *p, uint32_t val);
+void nthw_slc_lr_rcp_tail_dyn(const struct slc_lr_nthw *p, uint32_t val);
+void nthw_slc_lr_rcp_tail_ofs(const struct slc_lr_nthw *p, int32_t val);
+void nthw_slc_lr_rcp_pcap(const struct slc_lr_nthw *p, uint32_t val);
+void nthw_slc_lr_rcp_flush(const struct slc_lr_nthw *p);
 
 #endif	/* __FLOW_NTHW_SLC_LR_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
index bb7b9c2946..9841a9a7b8 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
@@ -12,12 +12,12 @@
 
 #include "flow_nthw_tx_cpy.h"
 
-void tx_cpy_nthw_set_debug_mode(struct tx_cpy_nthw *p, unsigned int n_debug_mode)
+void nthw_tx_cpy_set_debug_mode(struct tx_cpy_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_tx_cpy, n_debug_mode);
 }
 
-struct tx_cpy_nthw *tx_cpy_nthw_new(void)
+struct tx_cpy_nthw *nthw_tx_cpy_new(void)
 {
 	struct tx_cpy_nthw *p = malloc(sizeof(struct tx_cpy_nthw));
 
@@ -27,7 +27,7 @@ struct tx_cpy_nthw *tx_cpy_nthw_new(void)
 	return p;
 }
 
-void tx_cpy_nthw_delete(struct tx_cpy_nthw *p)
+void nthw_tx_cpy_delete(struct tx_cpy_nthw *p)
 {
 	if (p) {
 		free(p->m_writers);
@@ -36,7 +36,7 @@ void tx_cpy_nthw_delete(struct tx_cpy_nthw *p)
 	}
 }
 
-int tx_cpy_nthw_init(struct tx_cpy_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_tx_cpy_init(struct tx_cpy_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_TX_CPY, n_instance);
@@ -343,44 +343,44 @@ int tx_cpy_nthw_init(struct tx_cpy_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void tx_cpy_nthw_writer_select(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
+void nthw_tx_cpy_writer_select(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
 	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_ctrl_addr, val);
 }
 
-void tx_cpy_nthw_writer_cnt(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
+void nthw_tx_cpy_writer_cnt(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
 	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_ctrl_cnt, val);
 }
 
-void tx_cpy_nthw_writer_reader_select(const struct tx_cpy_nthw *p, unsigned int index,
+void nthw_tx_cpy_writer_reader_select(const struct tx_cpy_nthw *p, unsigned int index,
 	uint32_t val)
 {
 	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_data_reader_select, val);
 }
 
-void tx_cpy_nthw_writer_dyn(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
+void nthw_tx_cpy_writer_dyn(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
 	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_data_dyn, val);
 }
 
-void tx_cpy_nthw_writer_ofs(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
+void nthw_tx_cpy_writer_ofs(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
 	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_data_ofs, val);
 }
 
-void tx_cpy_nthw_writer_len(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
+void nthw_tx_cpy_writer_len(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val)
 {
 	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_field_set_val32(p->m_writers[index].mp_writer_data_len, val);
 }
 
-void tx_cpy_nthw_writer_flush(const struct tx_cpy_nthw *p, unsigned int index)
+void nthw_tx_cpy_writer_flush(const struct tx_cpy_nthw *p, unsigned int index)
 {
 	RTE_ASSERT(index < p->m_writers_cnt);
 	nthw_register_flush(p->m_writers[index].mp_writer_ctrl, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h
index c1094c09a9..c3b3129fa5 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h
@@ -40,20 +40,20 @@ struct tx_cpy_nthw {
 	struct tx_cpy_writers_s *m_writers;
 };
 
-struct tx_cpy_nthw *tx_cpy_nthw_new(void);
-void tx_cpy_nthw_delete(struct tx_cpy_nthw *p);
-int tx_cpy_nthw_init(struct tx_cpy_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct tx_cpy_nthw *nthw_tx_cpy_new(void);
+void nthw_tx_cpy_delete(struct tx_cpy_nthw *p);
+int nthw_tx_cpy_init(struct tx_cpy_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int tx_cpy_nthw_setup(struct tx_cpy_nthw *p, int n_idx, int n_idx_cnt);
-void tx_cpy_nthw_set_debug_mode(struct tx_cpy_nthw *p, unsigned int n_debug_mode);
+void nthw_tx_cpy_set_debug_mode(struct tx_cpy_nthw *p, unsigned int n_debug_mode);
 
-void tx_cpy_nthw_writer_select(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
-void tx_cpy_nthw_writer_cnt(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
-void tx_cpy_nthw_writer_reader_select(const struct tx_cpy_nthw *p, unsigned int index,
+void nthw_tx_cpy_writer_select(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
+void nthw_tx_cpy_writer_cnt(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
+void nthw_tx_cpy_writer_reader_select(const struct tx_cpy_nthw *p, unsigned int index,
 	uint32_t val);
-void tx_cpy_nthw_writer_dyn(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
-void tx_cpy_nthw_writer_ofs(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
-void tx_cpy_nthw_writer_len(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
-void tx_cpy_nthw_writer_flush(const struct tx_cpy_nthw *p, unsigned int index);
+void nthw_tx_cpy_writer_dyn(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
+void nthw_tx_cpy_writer_ofs(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
+void nthw_tx_cpy_writer_len(const struct tx_cpy_nthw *p, unsigned int index, uint32_t val);
+void nthw_tx_cpy_writer_flush(const struct tx_cpy_nthw *p, unsigned int index);
 
 #endif	/* __FLOW_NTHW_TX_CPY_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
index 2409875a5a..63ead6c925 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
@@ -12,12 +12,12 @@
 
 #include "flow_nthw_tx_ins.h"
 
-void tx_ins_nthw_set_debug_mode(struct tx_ins_nthw *p, unsigned int n_debug_mode)
+void nthw_tx_ins_set_debug_mode(struct tx_ins_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_tx_ins, n_debug_mode);
 }
 
-struct tx_ins_nthw *tx_ins_nthw_new(void)
+struct tx_ins_nthw *nthw_tx_ins_new(void)
 {
 	struct tx_ins_nthw *p = malloc(sizeof(struct tx_ins_nthw));
 
@@ -27,7 +27,7 @@ struct tx_ins_nthw *tx_ins_nthw_new(void)
 	return p;
 }
 
-void tx_ins_nthw_delete(struct tx_ins_nthw *p)
+void nthw_tx_ins_delete(struct tx_ins_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -35,7 +35,7 @@ void tx_ins_nthw_delete(struct tx_ins_nthw *p)
 	}
 }
 
-int tx_ins_nthw_init(struct tx_ins_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_tx_ins_init(struct tx_ins_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_TX_INS, n_instance);
@@ -66,32 +66,32 @@ int tx_ins_nthw_init(struct tx_ins_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void tx_ins_nthw_rcp_select(const struct tx_ins_nthw *p, uint32_t val)
+void nthw_tx_ins_rcp_select(const struct tx_ins_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_addr, val);
 }
 
-void tx_ins_nthw_rcp_cnt(const struct tx_ins_nthw *p, uint32_t val)
+void nthw_tx_ins_rcp_cnt(const struct tx_ins_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_cnt, val);
 }
 
-void tx_ins_nthw_rcp_dyn(const struct tx_ins_nthw *p, uint32_t val)
+void nthw_tx_ins_rcp_dyn(const struct tx_ins_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_dyn, val);
 }
 
-void tx_ins_nthw_rcp_ofs(const struct tx_ins_nthw *p, uint32_t val)
+void nthw_tx_ins_rcp_ofs(const struct tx_ins_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ofs, val);
 }
 
-void tx_ins_nthw_rcp_len(const struct tx_ins_nthw *p, uint32_t val)
+void nthw_tx_ins_rcp_len(const struct tx_ins_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len, val);
 }
 
-void tx_ins_nthw_rcp_flush(const struct tx_ins_nthw *p)
+void nthw_tx_ins_rcp_flush(const struct tx_ins_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h
index b87b9dcac3..b58f3d2e28 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h
@@ -26,19 +26,19 @@ struct tx_ins_nthw {
 	nthw_field_t *mp_rcp_data_len;
 };
 
-struct tx_ins_nthw *tx_ins_nthw_new(void);
-void tx_ins_nthw_delete(struct tx_ins_nthw *p);
-int tx_ins_nthw_init(struct tx_ins_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct tx_ins_nthw *nthw_tx_ins_new(void);
+void nthw_tx_ins_delete(struct tx_ins_nthw *p);
+int nthw_tx_ins_init(struct tx_ins_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int tx_ins_nthw_setup(struct tx_ins_nthw *p, int n_idx, int n_idx_cnt);
-void tx_ins_nthw_set_debug_mode(struct tx_ins_nthw *p, unsigned int n_debug_mode);
+void nthw_tx_ins_set_debug_mode(struct tx_ins_nthw *p, unsigned int n_debug_mode);
 
 /* RCP */
-void tx_ins_nthw_rcp_select(const struct tx_ins_nthw *p, uint32_t val);
-void tx_ins_nthw_rcp_cnt(const struct tx_ins_nthw *p, uint32_t val);
-void tx_ins_nthw_rcp_dyn(const struct tx_ins_nthw *p, uint32_t val);
-void tx_ins_nthw_rcp_ofs(const struct tx_ins_nthw *p, uint32_t val);
-void tx_ins_nthw_rcp_len(const struct tx_ins_nthw *p, uint32_t val);
-void tx_ins_nthw_rcp_flush(const struct tx_ins_nthw *p);
+void nthw_tx_ins_rcp_select(const struct tx_ins_nthw *p, uint32_t val);
+void nthw_tx_ins_rcp_cnt(const struct tx_ins_nthw *p, uint32_t val);
+void nthw_tx_ins_rcp_dyn(const struct tx_ins_nthw *p, uint32_t val);
+void nthw_tx_ins_rcp_ofs(const struct tx_ins_nthw *p, uint32_t val);
+void nthw_tx_ins_rcp_len(const struct tx_ins_nthw *p, uint32_t val);
+void nthw_tx_ins_rcp_flush(const struct tx_ins_nthw *p);
 
 #endif	/* __FLOW_NTHW_TX_INS_H__ */
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
index b787c38ee2..4eb2e69e78 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
@@ -12,12 +12,12 @@
 
 #include "flow_nthw_tx_rpl.h"
 
-void tx_rpl_nthw_set_debug_mode(struct tx_rpl_nthw *p, unsigned int n_debug_mode)
+void nthw_tx_rpl_set_debug_mode(struct tx_rpl_nthw *p, unsigned int n_debug_mode)
 {
 	nthw_module_set_debug_mode(p->m_tx_rpl, n_debug_mode);
 }
 
-struct tx_rpl_nthw *tx_rpl_nthw_new(void)
+struct tx_rpl_nthw *nthw_tx_rpl_new(void)
 {
 	struct tx_rpl_nthw *p = malloc(sizeof(struct tx_rpl_nthw));
 
@@ -27,7 +27,7 @@ struct tx_rpl_nthw *tx_rpl_nthw_new(void)
 	return p;
 }
 
-void tx_rpl_nthw_delete(struct tx_rpl_nthw *p)
+void nthw_tx_rpl_delete(struct tx_rpl_nthw *p)
 {
 	if (p) {
 		memset(p, 0, sizeof(*p));
@@ -35,7 +35,7 @@ void tx_rpl_nthw_delete(struct tx_rpl_nthw *p)
 	}
 }
 
-int tx_rpl_nthw_init(struct tx_rpl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_tx_rpl_init(struct tx_rpl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_TX_RPL, n_instance);
@@ -82,90 +82,90 @@ int tx_rpl_nthw_init(struct tx_rpl_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void tx_rpl_nthw_rcp_select(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rcp_select(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_ctrl_addr, val);
 }
 
-void tx_rpl_nthw_rcp_cnt(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rcp_cnt(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_ctrl_cnt, val);
 }
 
-void tx_rpl_nthw_rcp_dyn(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rcp_dyn(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_dyn, val);
 }
 
-void tx_rpl_nthw_rcp_ofs(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rcp_ofs(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ofs, val);
 }
 
-void tx_rpl_nthw_rcp_len(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rcp_len(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_len, val);
 }
 
-void tx_rpl_nthw_rcp_rpl_ptr(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rcp_rpl_ptr(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_rpl_ptr, val);
 }
 
-void tx_rpl_nthw_rcp_ext_prio(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rcp_ext_prio(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rcp_data_ext_prio, val);
 }
 
-void tx_rpl_nthw_rcp_eth_type_wr(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rcp_eth_type_wr(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	RTE_ASSERT(p->mp_rcp_data_eth_type_wr);
 	nthw_field_set_val32(p->mp_rcp_data_eth_type_wr, val);
 }
 
-void tx_rpl_nthw_rcp_flush(const struct tx_rpl_nthw *p)
+void nthw_tx_rpl_rcp_flush(const struct tx_rpl_nthw *p)
 {
 	nthw_register_flush(p->mp_rcp_ctrl, 1);
 	nthw_register_flush(p->mp_rcp_data, 1);
 }
 
-void tx_rpl_nthw_ext_select(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_ext_select(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_ext_ctrl_addr, val);
 }
 
-void tx_rpl_nthw_ext_cnt(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_ext_cnt(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_ext_ctrl_cnt, val);
 }
 
-void tx_rpl_nthw_ext_rpl_ptr(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_ext_rpl_ptr(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_ext_data_rpl_ptr, val);
 }
 
-void tx_rpl_nthw_ext_flush(const struct tx_rpl_nthw *p)
+void nthw_tx_rpl_ext_flush(const struct tx_rpl_nthw *p)
 {
 	nthw_register_flush(p->mp_ext_ctrl, 1);
 	nthw_register_flush(p->mp_ext_data, 1);
 }
 
-void tx_rpl_nthw_rpl_select(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rpl_select(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rpl_ctrl_addr, val);
 }
 
-void tx_rpl_nthw_rpl_cnt(const struct tx_rpl_nthw *p, uint32_t val)
+void nthw_tx_rpl_rpl_cnt(const struct tx_rpl_nthw *p, uint32_t val)
 {
 	nthw_field_set_val32(p->mp_rpl_ctrl_cnt, val);
 }
 
-void tx_rpl_nthw_rpl_value(const struct tx_rpl_nthw *p, const uint32_t *val)
+void nthw_tx_rpl_rpl_value(const struct tx_rpl_nthw *p, const uint32_t *val)
 {
 	nthw_field_set_val(p->mp_rpl_data_value, val, 4);
 }
 
-void tx_rpl_nthw_rpl_flush(const struct tx_rpl_nthw *p)
+void nthw_tx_rpl_rpl_flush(const struct tx_rpl_nthw *p)
 {
 	nthw_register_flush(p->mp_rpl_ctrl, 1);
 	nthw_register_flush(p->mp_rpl_data, 1);
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h
index f743b418f0..77fe9373ee 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h
@@ -43,32 +43,32 @@ struct tx_rpl_nthw {
 	nthw_field_t *mp_rpl_data_value;
 };
 
-struct tx_rpl_nthw *tx_rpl_nthw_new(void);
-void tx_rpl_nthw_delete(struct tx_rpl_nthw *p);
-int tx_rpl_nthw_init(struct tx_rpl_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
+struct tx_rpl_nthw *nthw_tx_rpl_new(void);
+void nthw_tx_rpl_delete(struct tx_rpl_nthw *p);
+int nthw_tx_rpl_init(struct tx_rpl_nthw *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int tx_rpl_nthw_setup(struct tx_rpl_nthw *p, int n_idx, int n_idx_cnt);
-void tx_rpl_nthw_set_debug_mode(struct tx_rpl_nthw *p, unsigned int n_debug_mode);
+void nthw_tx_rpl_set_debug_mode(struct tx_rpl_nthw *p, unsigned int n_debug_mode);
 
 /* RCP */
-void tx_rpl_nthw_rcp_select(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rcp_cnt(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rcp_dyn(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rcp_ofs(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rcp_len(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rcp_rpl_ptr(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rcp_ext_prio(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rcp_eth_type_wr(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rcp_flush(const struct tx_rpl_nthw *p);
-
-void tx_rpl_nthw_ext_select(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_ext_cnt(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_ext_rpl_ptr(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_ext_flush(const struct tx_rpl_nthw *p);
-
-void tx_rpl_nthw_rpl_select(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rpl_cnt(const struct tx_rpl_nthw *p, uint32_t val);
-void tx_rpl_nthw_rpl_value(const struct tx_rpl_nthw *p, const uint32_t *val);
-void tx_rpl_nthw_rpl_flush(const struct tx_rpl_nthw *p);
+void nthw_tx_rpl_rcp_select(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rcp_cnt(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rcp_dyn(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rcp_ofs(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rcp_len(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rcp_rpl_ptr(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rcp_ext_prio(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rcp_eth_type_wr(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rcp_flush(const struct tx_rpl_nthw *p);
+
+void nthw_tx_rpl_ext_select(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_ext_cnt(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_ext_rpl_ptr(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_ext_flush(const struct tx_rpl_nthw *p);
+
+void nthw_tx_rpl_rpl_select(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rpl_cnt(const struct tx_rpl_nthw *p, uint32_t val);
+void nthw_tx_rpl_rpl_value(const struct tx_rpl_nthw *p, const uint32_t *val);
+void nthw_tx_rpl_rpl_flush(const struct tx_rpl_nthw *p);
 
 #endif	/* __FLOW_NTHW_TX_RPL_H__ */
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 0b8958c4c1..9e269eb69f 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -42,16 +42,16 @@ static const char *get_bus_name(int n_bus_type_id)
 static const struct {
 	const nthw_id_t a;
 	const char *b;
-} *sa_nthw_fpga_mod_str_map;
+} *nthw_sa_fpga_mod_str_map;
 
 static const char *nthw_fpga_mod_id_to_str(nthw_id_t n_fpga_mod_id)
 {
 	int i;
 
-	if (sa_nthw_fpga_mod_str_map) {
-		for (i = 0; sa_nthw_fpga_mod_str_map[i].a && sa_nthw_fpga_mod_str_map[i].b; i++)
-			if ((nthw_id_t)sa_nthw_fpga_mod_str_map[i].a == n_fpga_mod_id)
-				return sa_nthw_fpga_mod_str_map[i].b;
+	if (nthw_sa_fpga_mod_str_map) {
+		for (i = 0; nthw_sa_fpga_mod_str_map[i].a && nthw_sa_fpga_mod_str_map[i].b; i++)
+			if ((nthw_id_t)nthw_sa_fpga_mod_str_map[i].a == n_fpga_mod_id)
+				return nthw_sa_fpga_mod_str_map[i].b;
 	}
 
 	return "unknown";
@@ -372,7 +372,7 @@ void nthw_fpga_mgr_init(nthw_fpga_mgr_t *p, struct nthw_fpga_prod_init **pa_nthw
 	size_t i = 0;
 
 	p->mpa_fpga_prod_init = pa_nthw_fpga_instances;
-	sa_nthw_fpga_mod_str_map = pa_mod_str_map;
+	nthw_sa_fpga_mod_str_map = pa_mod_str_map;
 
 	/* Count fpga instance in array */
 	if (pa_nthw_fpga_instances) {
diff --git a/drivers/net/ntnic/nthw/nthw_platform.c b/drivers/net/ntnic/nthw/nthw_platform.c
index 80063c9d25..6f2582d6fe 100644
--- a/drivers/net/ntnic/nthw/nthw_platform.c
+++ b/drivers/net/ntnic/nthw/nthw_platform.c
@@ -5,7 +5,7 @@
 
 #include "nthw_platform_drv.h"
 
-nthw_adapter_id_t nthw_platform_get_nthw_adapter_id(const uint16_t n_pci_device_id)
+nthw_adapter_id_t nthw_platform_get_adapter_id(const uint16_t n_pci_device_id)
 {
 	switch (n_pci_device_id) {
 	case NT_HW_PCI_DEVICE_ID_NT200A02:
diff --git a/drivers/net/ntnic/nthw/nthw_platform_drv.h b/drivers/net/ntnic/nthw/nthw_platform_drv.h
index df54dcead0..db2bc05180 100644
--- a/drivers/net/ntnic/nthw/nthw_platform_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_platform_drv.h
@@ -20,6 +20,6 @@ enum nthw_adapter_id_e {
 
 typedef enum nthw_adapter_id_e nthw_adapter_id_t;
 
-nthw_adapter_id_t nthw_platform_get_nthw_adapter_id(const uint16_t n_pci_device_id);
+nthw_adapter_id_t nthw_platform_get_adapter_id(const uint16_t n_pci_device_id);
 
 #endif	/* __NTHW_PLATFORM_DRV_H__ */
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
index a0afa22579..816d4ff781 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
@@ -5,7 +5,7 @@
 
 
 #include "nthw_fpga_mod_str_map.h"
-const struct nthw_fpga_mod_str_s sa_nthw_fpga_mod_str_map[] = {
+const struct nthw_fpga_mod_str_s nthw_sa_fpga_mod_str_map[] = {
 	{ MOD_CAT, "CAT" },
 	{ MOD_CPY, "CPY" },
 	{ MOD_CSU, "CSU" },
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h
index 9442bb2d20..a6da8912b1 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h
@@ -10,4 +10,4 @@ struct nthw_fpga_mod_str_s {
 	const nthw_id_t a;
 	const char *b;
 };
-extern const struct nthw_fpga_mod_str_s sa_nthw_fpga_mod_str_map[];
+extern const struct nthw_fpga_mod_str_s nthw_sa_fpga_mod_str_map[];
-- 
2.45.0

