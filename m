Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E1CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:46:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB3EF42E76;
	Mon, 20 Oct 2025 18:44:20 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 69BC840E8A
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:58 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023123.outbound.protection.outlook.com
 [52.101.83.123]) by mx-outbound44-20.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ8jtCz3KLZjcJRZFYY7hUeAkFE905PlgdayVt3tpOupS8+ANOgIOBkfWnBb442Ar+zDIFyQG7ikq40Z2oWKw/jO3SoTg3tOwWpKhu8a/k2ejX9Pp0JUaL/0wB2qr5k97vuYpXX5rYTl71YfbVACEQLxV9Ph0UIgaDCGOPjVBC64qaiMUhM+pFbZbHWboc0ylW7IVhf87kYJNVFsEPjst/SubTa7TmQcWsBj6SiO9WBhyJ5uY6lMlbSoSC6t6sO6spfxmZsDHe+J2PDYjo0tXxOQTfA6JlPuI3J/2IpBMoJQDcJ0L42+Lxb2DWRxwnvxVBHjBQbdAvPVmDZNoOs7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr9N78uwQzEmG7oZqYnFRK2pIQjzRzWdknGCrYacXhU=;
 b=RyYEBaLO0K3auL6HkrXkmDdUKzcshRp5EpubEBwlrsLx70C/dak9Z3tBLbbalWYjtBMo8av2aKyh2PVNp1xM2puWKb9cmiOwqjFU8okUuOSgOmHpFPolkj8xa2oeF+B+MzkL3WCjIGTcEfdIp41OERGIX48AHWrbqXr8mDKm38qKfpsYwSY0QJJGtXpFgkCVkkC0Fb+2ffwl7/2WZCppc7oDXB+H9Y+267e8PPqIossCgobOHGLu+0c/TwVmDLmyq0OofVF+uUlMC8PRrtHVIu/7kmDGB7iBatWsm3MCzVOQbpgnbePn2eQk6Sj3MMXtZWnk5Db4oj6+iy34Aiax1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr9N78uwQzEmG7oZqYnFRK2pIQjzRzWdknGCrYacXhU=;
 b=jVzcadygdi9TD6c+WXqMRpIEjkwdo2ivccIoaHwEEMON65O0O6Nmy5H6jbMedvD84COmGmgnghxUX0ePJUUppLv1b4ZMEIyLnbGEKGTM4tYqZMfCH0TzJrQGUsFj3SXKOY/75PvCVFcmNimPhaX/kEfn5KYCZJHASnvf8Cp3QHM=
Received: from DUZPR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::10) by DB9P190MB1723.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:327::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:55 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::cb) by DUZPR01CA0019.outlook.office365.com
 (2603:10a6:10:46b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:55
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 21/21] net/ntnic: fix potential name conflict
Date: Mon, 20 Oct 2025 18:43:30 +0200
Message-ID: <20251020164336.283664-22-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DB9P190MB1723:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d5c54d7-d0bf-4cde-cf30-08de0ff7dc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bNLs1MIjUcYQXeNAIHmOqTgqzBc0Tr67xwJgw+l3sixGscqUtREvSVLt//HA?=
 =?us-ascii?Q?y8B8rnIp2/4LmY7e4EG7RLRbDMZwGIgJfkT/qSf6iuyub/9BziwWvi3+Bt5b?=
 =?us-ascii?Q?DKn11S9KXsTgha7mkak+zsNQZHW51Xxh7j3OTkCsHdW8E+2ztoYbWKhb2jGj?=
 =?us-ascii?Q?IhVBqBJ0FrZ1aG6Vdx5+BumAKBjdmYSOgDEQ1Tql1bvIuayGnEjCsqwSAe0S?=
 =?us-ascii?Q?enZx302IpoMktD5AQCREB7s4Q+b7VcAJT/x4Lrq0khVQWfE5sX729ERHbSDi?=
 =?us-ascii?Q?SBIovVwIKv/PIeJ2Uqc/4EiVxPfbpY3heJcCExUMxOuTuqAL29IlJ8Nup/yu?=
 =?us-ascii?Q?YhAPoej9+KVNRb7sQuKcQ3sRSIogBRCXoo526uAnOuUuCMnlMNkRFb0RiMm5?=
 =?us-ascii?Q?UxjIwQ7NYV8psvSG9RPCzsduNDfqD2S5EylGjWDpHS3T3Bqm01xGEY8omUnt?=
 =?us-ascii?Q?AK3FcSyyBYs6uSDSE6n3/QiMTu62/ylDdjVZhTXl4NEUnNtqWwoOlVDiMg9d?=
 =?us-ascii?Q?tP97fYgJcj8uos7gRLw+vv+C2pmZydm7R33cslYy9the2+EE36llXXuWkww9?=
 =?us-ascii?Q?b98XKw9Y66ox0cRd7/MCgJgJOgS4hI0qg9WyjBHkwaV4uf3UOtYlvZpot1lK?=
 =?us-ascii?Q?6jly2FthqY4r1eiHOvIPgYSwDVnJbMvgEat4lZjpVpJ+7IoZ/6hjOVC/swJz?=
 =?us-ascii?Q?e+mNTqp14LHLLvzOAUNmyMdudhulCRjYduqhrMUfLGQ2mcGWRlzMsuiO/RfS?=
 =?us-ascii?Q?MLl1r4VNtRBm7XFetPJhAj6YCCFS4I9SCGQYIa4YYoY9PyoEk2PjFRxv+eop?=
 =?us-ascii?Q?U4tsWQphTPDabRLrgFLw2pQlz6ilgcNCm+ftMngcBvjVZJKgSMePsm7TSKPb?=
 =?us-ascii?Q?YxquuFnt1K7o5FIo8GYeIf3N+7e8j6CopVUsQ5cFTaZ4fffAGSQe9SFt2BB7?=
 =?us-ascii?Q?V95HoroU+cVKFWKlTjeYwI6qAj05Rwnu1a4eAHip9JMnbbZ6PvbNtgQfSAKS?=
 =?us-ascii?Q?h59nifCKg9ryF3WPK69DDa/41K+FUFjI444ZF+vdifIrUMWDYJWQQpFhpIC9?=
 =?us-ascii?Q?hkKop7oz6xJH+7MHDrc+sQpFyuVVSTJo3G3E3YH70+0oU2wzdElEnn0WNrjp?=
 =?us-ascii?Q?ePs+zK5XvsnvPNleeTmh+H0I+a67Xv3DYNsIOWy7opXGbcw2htJ36xbVJRz6?=
 =?us-ascii?Q?3riaPuXQiaklr+JEZnSEFtTb3OvtjTa6uI8uaQ92297W8OLvdJLjsguxA/oq?=
 =?us-ascii?Q?HL1MjFBSP8XkjSgQSs2C4P3ck8otQwxEpVQBDI3+VtHSY1ut4r/RyqoHxx9l?=
 =?us-ascii?Q?9se2Xt3VpgljI5pN0Bv7ZyXHARpJ446S9Xs32zAfafrbeK4SlHJV5Ax1cAiE?=
 =?us-ascii?Q?x6Z/XyLlepxOCxTg3O+YPqJMWHFWjuhgpQGnX1AkgmTOATbGR3NI5EK7SJ2C?=
 =?us-ascii?Q?M5vXrbzXB7heQDD81pOw3BllE3c13NTWSzoS0VD+v+2s3VhDu3pKlSAbtbNB?=
 =?us-ascii?Q?VRDS22T8V3NlBnLnKko6m2Ryu7kbnISw7uB56JPHzCtjFK9utGxGLaDkdQiF?=
 =?us-ascii?Q?veBYdlZGjjp3jp0TEXM=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NO4jqQn4xwR7eyypiLAk7yO7vG+sQUudr0uOLio0sFo/6oIAA8C3bEktMu0JCmoNMzcXE5mSgEmLDMrihbx8gtm5VZrutw/cbuVYoMZqo342Hxl9xmm9dwBBT8Ur/UBtxNmxPTM30GNqCmyUatUFM2y66dqJFfQvsiHMsL3D8iy4mH1mxaSOKYzwytJAVZjkgdkxjU1uaRDsM4i9tJPSK2k5bEcU1Y37O00R/lTvQihy54qCmE1m+7Jka/X+aF6QSLWKJj1bqvccH1WCm44WZgaHRmCNfudWTPxKIYq7BU04kUWv7s1Nr+/9lK9moxnN5JAgq5y6kvQiTM6VgP3JjbMka/FEKPThrCqZGNTaEJ+kD5C8AiOeo2ASbJJInTi7mQS1pwNTmH7wpUquEBnFRymBuHfUkxIpj+ykcJo6WxrtrnEhzSUMkPUZXMT0JND4EottVEDzVDuHxKr1ROsjKP+r+TaYmJo9U7JvuQLwJvnyQMG3iGTe1kwQiu/jW2FE70Cb3db8TH4Yyx4NxfDF38FogY46yG5xaRQX7kxqOy53XinQ6NTuSjrfE887zQ/ubOdgwRhVorTX8nnNIjBEdc//Isn3MDW7jWIIL9CvM2ogXHsnDwmTx6sxVk09LOVZ99P1dS8bFndG3o3sLPzXEcIDuu93YZ/sGCFNj9KTN8E=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:55.7878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5c54d7-d0bf-4cde-cf30-08de0ff7dc39
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1723
X-BESS-ID: 1760978637-311284-32706-8336-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.83.123
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbmRuZAVgZQ0MAsOc3cJMXMxM
 LMLDHV1NDUzMg8KTE5LcnMyDTZ1MJYqTYWAEFoJLJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan11-196.eu-central-1a.ess.aws.cudaops.com]
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

Drivers should not have global variables that could conflict with EAL.
Rename rte_tsc_freq to nthw_tsc_freq.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/stream_binary_flow_api.h | 2 +-
 drivers/net/ntnic/ntnic_ethdev.c                   | 4 ++--
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c      | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ntnic/include/stream_binary_flow_api.h b/drivers/net/ntnic/include/stream_binary_flow_api.h
index 3c6de8899b..0678b284d4 100644
--- a/drivers/net/ntnic/include/stream_binary_flow_api.h
+++ b/drivers/net/ntnic/include/stream_binary_flow_api.h
@@ -46,7 +46,7 @@
 
 #define RAW_ENCAP_DECAP_ELEMS_MAX 16
 
-extern uint64_t rte_tsc_freq;
+extern uint64_t nthw_tsc_freq;
 extern rte_spinlock_t nthw_lock;
 
 /*
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 3d52889ad2..4190cfab33 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -67,7 +67,7 @@
 
 #define MTUINITVAL 1500
 
-uint64_t rte_tsc_freq;
+uint64_t nthw_tsc_freq;
 
 
 #define ETH_DEV_NTNIC_HELP_ARG "help"
@@ -2723,7 +2723,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	 */
 	uint64_t now_rtc = rte_get_tsc_cycles();
 	nthw_os_wait_usec(10 * 1000);
-	rte_tsc_freq = 100 * (rte_get_tsc_cycles() - now_rtc);
+	nthw_tsc_freq = 100 * (rte_get_tsc_cycles() - now_rtc);
 
 	NT_LOG_DBGX(DBG, NTNIC, "leave: ret=%d", ret);
 	return ret;
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index fc5f5f8d2f..f1c7fe22e0 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1213,7 +1213,7 @@ static int poll_statistics(struct pmd_internals *internals)
 	if (!p_nt4ga_stat || n_intf_no < 0 || n_intf_no >= NUM_ADAPTER_PORTS_MAX)
 		return -1;
 
-	RTE_ASSERT(rte_tsc_freq > 0);
+	RTE_ASSERT(nthw_tsc_freq > 0);
 
 	rte_spinlock_lock(&nthw_lock);
 
@@ -1223,7 +1223,7 @@ static int poll_statistics(struct pmd_internals *internals)
 	 * Check per port max once a second
 	 * if more than a second since last stat read, do a new one
 	 */
-	if ((now_rtc - internals->last_stat_rtc) < rte_tsc_freq) {
+	if ((now_rtc - internals->last_stat_rtc) < nthw_tsc_freq) {
 		rte_spinlock_unlock(&nthw_lock);
 		return 0;
 	}
@@ -1269,7 +1269,7 @@ static int poll_statistics(struct pmd_internals *internals)
 	}
 
 	/* Globally only once a second */
-	if ((now_rtc - last_stat_rtc) < rte_tsc_freq) {
+	if ((now_rtc - last_stat_rtc) < nthw_tsc_freq) {
 		rte_spinlock_unlock(&nthw_lock);
 		rte_spinlock_unlock(&p_nt_drv->stat_lck);
 		return 0;
-- 
2.45.0

