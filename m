Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE01CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07340406FF;
	Wed, 24 Sep 2025 16:42:04 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 08E1D406A2
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:01 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021094.outbound.protection.outlook.com [52.101.65.94])
 by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osf8fjQyLfBw7MWHrAROBXQCX0cvIaYhVSL85iEAS4g0UT6i3pwFp9biIQgY+h9vdEm3ckkZ8odh/VAGDSMezmlkOIzI8ca+Q6oOLmKecyPgYXo4AenxrZeAq/Y4JDHRj3mHNSSM4qM+5qjsp8RczBnYt4x6eieHixrjxqWdpjaBPE+k5sJwDcmnf5reMC7Z7H+ot3PbL+kr9SohylVUot/M3iEqus3PbSW+db/56qEzWvI3hm0gZlqYpPjfj56D+/lwhuLfdVvnABXSn5woaJqAG/IL4RJaKAtCyKW6J5i4kZSv8WfHZN+w7Yzb4RxLMC1mxOLkaCtSIUmoYGtNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LUpJU6M/gnwPdMUnKD7MmYF9/2kqth9oPK4faU0wYI=;
 b=cjqpoWkpyZH/RvaUoOe8SAyM1vJBRpY+gkMBOnffLsPzXqWm4UCktw7R8vp1oePL5Tkcc10vImyfjYy4A6yv6zzkflfEo/VD4RILhZJzd4OiU1pxvn8echNvcWu3wMK9RBIwWXc8waJp7Zh8krQBq2dj6B5USis9FHniO6EZ4YwbD1S7ExzMGy3WS8gp17zvVt68Tj4rUOQWuyGpoEvav0MWpFEeRKdn/VzM4eIVGjRg6eJ+NlzCTwJEil08V4tGiYBlHnmQoGRkDz6nzH8MaIQdamXHiHW0uZuT+w85XOy/wgEmfH28jWMs/LMBrfOskm/4TUQrMTKu7HSD0bR5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LUpJU6M/gnwPdMUnKD7MmYF9/2kqth9oPK4faU0wYI=;
 b=M3STkReGvN9kndTqzyCBi+2nkoUcanyivEqJKZPr511Hbvap+3l5Z5zgRedT1JimqPSM0b11N+h6gTESPZ094EovL77aXXKJPvQhbXsTGxRKYwg37/wR58oQx9B9c88MXIu8UIxHxmJrHLyS0aoSkhGE7jtw4K8HMVfFcFSLSZM=
Received: from CWLP123CA0231.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::17)
 by AS8P190MB1111.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:41:58 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::3b) by CWLP123CA0231.outlook.office365.com
 (2603:10a6:400:19f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 14:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:41:58
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 02/24] net/ntnic: migrate flm update thread to service
Date: Wed, 24 Sep 2025 16:41:25 +0200
Message-ID: <20250924144152.53203-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS8P190MB1111:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 224f1f21-3558-4117-e401-08ddfb7883c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XcgChaFMwOWtmnyQ841RoEK7/AP9FPhRIOSnzzE6O3UsGhcjoFSFYBY16OcU?=
 =?us-ascii?Q?QrfpIk+uH7srEmMD11n2bbIdH7WnGeSWZ3Wieg+G6yDtphQ/+pCLeojmTOCP?=
 =?us-ascii?Q?YDtGTP9RK4Bt3XSswQ0Yu/6PdCqHAH8FtuCMJJ6pYgp5mz3n6wdHQMxn0LjH?=
 =?us-ascii?Q?ExL8x5aH5kwHd0zBhiIS79J9jz9mU8X/JWdyleNL4Aj+dpjDso1m3ueNYcYi?=
 =?us-ascii?Q?rHpL2aMhQV04L7gyqXarZSXTQLdutBo3x4f18ZJ7wnGx1kebqo5UvqvLpiDb?=
 =?us-ascii?Q?UdLrR8Xo9x43EC8ufGQfeo/4M1kUQOO65RNScysNdAYXUWEhrPVrWm04dy8V?=
 =?us-ascii?Q?wJ4qXt60IglqrpOzj1/vW1xtMkXS1zhrQFKWxR9ckwb9r8tSY707n48KaL2o?=
 =?us-ascii?Q?EOXiRhbK/j7GguIsWX45pFdB8dDzHlw/tMy4zp2sfLKL0nP7igmap4tfsR8z?=
 =?us-ascii?Q?Rt9cJNfY0zCHk9Fqr8JMeL4z5OjgHaRDWLLTH7IQTPMwSkuL/Gom0Q28n6y8?=
 =?us-ascii?Q?99q0dmgfYIViFdhKHIRm635Cf8LWH2tZdBljFgAzhrpMMyHOyztoElsEutEK?=
 =?us-ascii?Q?SBXr/KNSZ44csI5k2+EfMOyN8HAPh7Q7Hkl77JvW+aPVLwuHJMK7Aljtewqb?=
 =?us-ascii?Q?fK/bQ4MS2zRilwT9TjocuhCBLedTk5xpUT7Zin8g7/5vRt6WUtPLO/DD5x88?=
 =?us-ascii?Q?7IW1A63VoAJ4oUMxZAEMWjuP20MIrNISwSVoiOpGhUMd7eYCncSo9FH3DRKW?=
 =?us-ascii?Q?H2dDbynOj5OdDliPx5Z3m8frZVgV80sjh5ieEDlqwE/mOkHXAasjzM+zlzO2?=
 =?us-ascii?Q?tyJV7Ktrswp8JYcCz8WeA+GeCIAefSyWTnGu9XNugCpjkqMPTZRFZthbKcIj?=
 =?us-ascii?Q?jiJX4HWP5cJ4LNZpoXSsZ67Xx+bPfAWPEJOBc/Fhv0he3BTo776o+/8bZAaQ?=
 =?us-ascii?Q?zdHOk9SfYCngNqEtFI2/jDmaqgdavTblmzlqJ+RA3b7mM98qJmzWnSfEI0sg?=
 =?us-ascii?Q?eimHwVEf311Cym550W5N2UM/fyPtq2tbYwbfxqVoCWuHIx5PpvIFqk3oVbaJ?=
 =?us-ascii?Q?99ha7dk0qGkmB5Tz1E/yxjylo/+Bya8+6T8n+D8fipoahipndXvb3cZ6qKdO?=
 =?us-ascii?Q?iCpQCUeDtpMC/LkVojzVoha53s4z2UJCLAnMcSDuQ86JAqtVxloV8l5HS+zz?=
 =?us-ascii?Q?R57atRAiR0CRcSpYp+GrI+pXV8s/eN7oPtPm/4LFTNgE/NKRU8IIZXyRfrNo?=
 =?us-ascii?Q?W4fGfyzOXk//wlayk3lAJ+bhcm4HDFAf5Y1YeYvTyX2jnCX2H+s5J/X4r6K/?=
 =?us-ascii?Q?GIzFBxGGN8TFuSGoMM/CibqpHc9v/gVLeASRrP3rvY4sn1u7y2wD+MrCSyYB?=
 =?us-ascii?Q?PccKvqaOIHGSF40ciFV7BMyw8L+cT1g0WCzZtwfIJJ1/0UL4NyLTSI3BsgUj?=
 =?us-ascii?Q?qwxjWnEvXF9zs7VJX5vhjdnTEykTNiNjcTYO9lwb/4HOoAxiMMhGQnc0Dn3c?=
 =?us-ascii?Q?olqyB/NhipBx5fqVZkNkqgfUVSF1yMmcJOC7?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HiUizwgu8Knz8AGnzA7JE6NV7KYdrn9X5FGtxSRYqJ08b5Ubrwhn5NBVx7igDRwS/de6d35u/Qcq0OxgNHB2Diz87ZPGEJ4po2WA1/Gvq4IZ8Cs7tQ8YleMgJtx0Dl5dR+8tBtp3sOCrpgJX0M0wUSGmR3Hpd9O8FDLK1aSpGAsK2ewsJjmonvXZrXkILbDOGBflIaATarQlva/VWrQF58DT771WOxJmNZp00jwzIAKx+neY5m81VQRfcew+W9VLbJm+I4XNYwFcjPOdaWxs5x3pLL1Kiw1Ip9oMJeYMcqyIiRVMlVWFn/TlCm/F1dfDdoGnPBOYPnyGT8kOCbooYfqbRpIPrmv8MCErIycoc02UqDCeNDPlTyz0MkUB5MIVHd34wcUnljydzpjwkt5B+jgiGIX2rzOVhknSbs/SySJ5GSEBITLcf+HjKiNz5Ni2Nmamgp8/WZevX5l/A0bseo1lbpIUmtZGj/jj+0qwxQG9TGQ7clnyIDBmpV8Wc8ICrzKj6UE+OpDww9tmhmEp05CGvGxTS5hQ4pFDFGmijyeSYFlHIsf34nhBTEOc5Ev8zF6KkZIpnzvzyMokxRTPIyFnEQ0ceovNHMDLh+qB/Q/KJwoU2YKx+HPnHRitae9FgAJK/WB6dfqNuBn5/LpGEA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:41:58.0563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224f1f21-3558-4117-e401-08ddfb7883c0
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1111
X-BESS-ID: 1758724919-305664-7612-8005-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.65.94
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmxkZAVgZQMCXVwjLZwsIoyc
 jEwsDMLNHSwCgtLSklydLQPC3J3DhNqTYWABDd39xBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan21-85.eu-central-1b.ess.aws.cudaops.com]
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

This commit adds the FLM update service to the NTNIC PMD.
The service is responsible for handling creating/destroying flows.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/ntdrv_4ga.h         |  1 -
 drivers/net/ntnic/ntnic_ethdev.c              | 67 ++++++++++++-------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 17 +++++
 drivers/net/ntnic/ntutil/nt_service.c         |  4 +-
 drivers/net/ntnic/rte_pmd_ntnic.h             |  3 +-
 5 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ntnic/include/ntdrv_4ga.h b/drivers/net/ntnic/include/ntdrv_4ga.h
index 78cf10368a..35afcd546c 100644
--- a/drivers/net/ntnic/include/ntdrv_4ga.h
+++ b/drivers/net/ntnic/include/ntdrv_4ga.h
@@ -15,7 +15,6 @@ typedef struct ntdrv_4ga_s {
 	char *p_drv_name;
 
 	volatile bool b_shutdown;
-	rte_thread_t flm_thread;
 	rte_spinlock_t stat_lck;
 	rte_thread_t stat_thread;
 	rte_thread_t port_event_thread;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 79ef9e7e7c..c114017db8 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -31,6 +31,7 @@
 #include "profile_inline/flm_age_queue.h"
 #include "profile_inline/flm_evt_queue.h"
 #include "rte_pmd_ntnic.h"
+#include "nt_service.h"
 
 const rte_thread_attr_t thread_attr = { .priority = RTE_THREAD_PRIORITY_NORMAL };
 #define THREAD_CREATE(a, b, c) rte_thread_create(a, &thread_attr, b, c)
@@ -1546,7 +1547,7 @@ drv_deinit(struct drv_s *p_drv)
 	THREAD_JOIN(p_nt_drv->stat_thread);
 
 	if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
-		THREAD_JOIN(p_nt_drv->flm_thread);
+		nthw_service_del(RTE_NTNIC_SERVICE_FLM_UPDATE);
 		profile_inline_ops->flm_free_queues();
 		THREAD_JOIN(p_nt_drv->port_event_thread);
 		/* Free all local flm event queues */
@@ -1980,40 +1981,46 @@ THREAD_FUNC port_event_thread_fn(void *context)
 }
 
 /*
- * Adapter flm stat thread
+ * Adapter flm update service
  */
-THREAD_FUNC adapter_flm_update_thread_fn(void *context)
+static int adapter_flm_update_service(void *context)
 {
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+	static struct flow_eth_dev *dev;
+	static const struct profile_inline_ops *profile_inline_ops;
 
-	if (profile_inline_ops == NULL) {
-		NT_LOG(ERR, NTNIC, "%s: profile_inline module uninitialized", __func__);
-		return THREAD_RETURN;
-	}
+	struct nt_service *flm_update_srv = nthw_service_get_info(RTE_NTNIC_SERVICE_FLM_UPDATE);
+	RTE_ASSERT(flm_update_srv != NULL);
 
-	struct drv_s *p_drv = context;
+	if (!NT_SERVICE_GET_STATE(flm_update_srv)) {
+		struct drv_s *p_drv = context;
+		RTE_ASSERT(p_drv != NULL);
 
-	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
-	struct adapter_info_s *p_adapter_info = &p_nt_drv->adapter_info;
-	struct nt4ga_filter_s *p_nt4ga_filter = &p_adapter_info->nt4ga_filter;
-	struct flow_nic_dev *p_flow_nic_dev = p_nt4ga_filter->mp_flow_device;
+		struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
+		struct adapter_info_s *p_adapter_info = &p_nt_drv->adapter_info;
+		struct nt4ga_filter_s *p_nt4ga_filter = &p_adapter_info->nt4ga_filter;
+		struct flow_nic_dev *p_flow_nic_dev = p_nt4ga_filter->mp_flow_device;
 
-	NT_LOG(DBG, NTNIC, "%s: %s: waiting for port configuration",
-		p_adapter_info->mp_adapter_id_str, __func__);
+		NT_LOG(DBG, NTNIC, "%s: %s: waiting for port configuration",
+			p_adapter_info->mp_adapter_id_str, __func__);
 
-	while (p_flow_nic_dev->eth_base == NULL)
-		nt_os_wait_usec(1 * 1000 * 1000);
+		if (p_flow_nic_dev->eth_base == NULL)
+			return -1;
 
-	struct flow_eth_dev *dev = p_flow_nic_dev->eth_base;
+		dev = p_flow_nic_dev->eth_base;
 
-	NT_LOG(DBG, NTNIC, "%s: %s: begin", p_adapter_info->mp_adapter_id_str, __func__);
+		profile_inline_ops = get_profile_inline_ops();
+		RTE_ASSERT(profile_inline_ops != NULL);
 
-	while (!p_drv->ntdrv.b_shutdown)
-		if (profile_inline_ops->flm_update(dev) == 0)
-			nt_os_wait_usec(10);
+		NT_LOG(INF, NTNIC, "flm update service started on lcore %i",  rte_lcore_id());
+		flm_update_srv->lcore = rte_lcore_id();
+		NT_SERVICE_SET_STATE(flm_update_srv, true);
+		return 0;
+	}
 
-	NT_LOG(DBG, NTNIC, "%s: %s: end", p_adapter_info->mp_adapter_id_str, __func__);
-	return THREAD_RETURN;
+	if (profile_inline_ops->flm_update(dev) == 0)
+		nt_os_wait_usec(10);
+
+	return 0;
 }
 
 /*
@@ -2346,8 +2353,16 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 
 	if (profile_inline_ops != NULL && fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
 		profile_inline_ops->flm_setup_queues();
-		res = THREAD_CTRL_CREATE(&p_nt_drv->flm_thread, "ntnic-nt_flm_update_thr",
-			adapter_flm_update_thread_fn, (void *)p_drv);
+
+		struct rte_service_spec flm_update_spec = {
+			.name = "ntnic-flm_update_service",
+			.callback = adapter_flm_update_service,
+			.socket_id = SOCKET_ID_ANY,
+			.capabilities = RTE_SERVICE_CAP_MT_SAFE,
+			.callback_userdata = p_drv
+		};
+
+		res = nthw_service_add(&flm_update_spec, RTE_NTNIC_SERVICE_FLM_UPDATE);
 
 		if (res) {
 			NT_LOG_DBGX(ERR, NTNIC, "%s: error=%d",
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index fc06cf12c3..c6c448312f 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -6,6 +6,7 @@
 #include <rte_flow_driver.h>
 #include <rte_pci.h>
 #include <rte_version.h>
+#include <rte_pmd_ntnic.h>
 
 #include "ntlog.h"
 #include "nt_util.h"
@@ -13,6 +14,8 @@
 #include "ntnic_mod_reg.h"
 #include "ntos_system.h"
 #include "ntos_drv.h"
+#include "nt_service.h"
+#include "rte_service.h"
 
 #define MAX_RTE_FLOWS 8192
 
@@ -543,6 +546,13 @@ eth_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *flow, struct rte_
 		return -1;
 	}
 
+	struct nt_service *srv = nthw_service_get_info(RTE_NTNIC_SERVICE_FLM_UPDATE);
+
+	if (!srv || !NT_SERVICE_GET_STATE(srv) || !rte_service_runstate_get(srv->id))	{
+		NT_LOG(ERR, FILTER, "flm update service is not started. Flow cannot be destroyed");
+		return -1;
+	}
+
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
 	error->type = RTE_FLOW_ERROR_TYPE_NONE;
@@ -580,6 +590,13 @@ static struct rte_flow *eth_flow_create(struct rte_eth_dev *eth_dev,
 		return NULL;
 	}
 
+	struct nt_service *srv = nthw_service_get_info(RTE_NTNIC_SERVICE_FLM_UPDATE);
+
+	if (!srv || !NT_SERVICE_GET_STATE(srv) || !rte_service_runstate_get(srv->id))	{
+		NT_LOG(ERR, FILTER, "flm update service is not started. Flow cannot be created");
+		return NULL;
+	}
+
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
 	struct fpga_info_s *fpga_info = &internals->p_drv->ntdrv.adapter_info.fpga_info;
diff --git a/drivers/net/ntnic/ntutil/nt_service.c b/drivers/net/ntnic/ntutil/nt_service.c
index 4ef1233f12..86f709e401 100644
--- a/drivers/net/ntnic/ntutil/nt_service.c
+++ b/drivers/net/ntnic/ntutil/nt_service.c
@@ -12,8 +12,8 @@
 #define NT_SERVICE_UNKNOWN_ID (-1)
 
 static struct nt_service g_nt_services[RTE_NTNIC_SERVICE_MAX] = {
-	[0] = {
-		.tag = RTE_NTNIC_SERVICE_MAX,
+	[RTE_NTNIC_SERVICE_FLM_UPDATE] = {
+		.tag = RTE_NTNIC_SERVICE_FLM_UPDATE,
 		.id = NT_SERVICE_UNKNOWN_ID,
 		.lcore = RTE_MAX_LCORE,
 		.initialized = false,
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.h b/drivers/net/ntnic/rte_pmd_ntnic.h
index 7a491319fa..d6236dae32 100644
--- a/drivers/net/ntnic/rte_pmd_ntnic.h
+++ b/drivers/net/ntnic/rte_pmd_ntnic.h
@@ -41,7 +41,8 @@ enum rte_ntnic_event_type {
 };
 
 enum rte_ntnic_service_tag {
-	RTE_NTNIC_SERVICE_MAX = 1
+	RTE_NTNIC_SERVICE_FLM_UPDATE = 0,
+	RTE_NTNIC_SERVICE_MAX
 };
 
 /**
-- 
2.45.0

