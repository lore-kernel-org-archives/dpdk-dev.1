Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7BAC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 995A54067E;
	Wed,  5 Feb 2025 11:46:21 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 7016D40669
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:12 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2236.outbound.protection.outlook.com [104.47.11.236]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rp5+jWDNFHiB6/TxVH1oS/1aZ40LZWVJW/mVjTejaWzciq/mYPI+KW4tXQwDeM0K/UZaOi5EOlgsEDT2Znmvgd835mX0RhkLei6fc8wu/r91Khs1ZdhfhYN0fY7eWf/+bP+FfQr05t9vUeOll0oPcSeiT4tqWDGGMUtLd12R7gHurnuAMxuyaTK7N01HVh2l1wseBcDHtpi9R90Wr3akN/jshS0Zopz17Z6ztHp+3ENHBDezsnXP84jMuUm942J8o5HM3FjscRxzNJorkT2nRGuDghEMfTPKmMBhceYnEiZEbluMpMQguTLAuUBJ8Q6bS/AbuwPZDbDem6kRP3h8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltqb21JYm1MpJEQhjOgKjNB97hOyn82rFa0dgEZtzFU=;
 b=Nffu83j9gqZfZuiTUdtmsvd5+bMJCupNO0b2tcb2SuCA60sbctZ9XA2BOdA403dOO81LZoZw0D+b3l4bhuhCYHglISMZm0K2G4/7+LmCpUFhfUTKeg+x0oi1ohw/ZQ+tRFux/8Nxl98eNL6/rzZAFEOVV6R/y7o4Fi+el+51aeeDVA3+jrnhIWK+U5sWS92O1e1Kya2zh/dA8uzIk0ATk3odVsDyc25dK/zIJ1FMwtWot5QOPuTHRNY07hOktsyWppVcafbCCL8y6Z7vKBcmddiWoWOGF/tfOGDLGkdnt3Vnkd/gviWfzJ3cYzRghnsXYjwT4VSkO3qdQbnjHNHP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltqb21JYm1MpJEQhjOgKjNB97hOyn82rFa0dgEZtzFU=;
 b=opawVFFubkI1jjmRH704wSDAk208IeG0av/97I3IexKrdrrBcABCxpPuqVOGBBRJYlEzBuLDAyo9l5GVzfSbPVteMG4iVDwOKSQwMCSZjr5ga8MBCvzT6hnVEjB8O4wsDJ13xC3jyt2t7QC2uS11JBQCTurmF0SZ7jS6v6LXjzU=
Received: from CWLP265CA0348.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::24)
 by AS1P190MB1799.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:46:10 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::cf) by CWLP265CA0348.outlook.office365.com
 (2603:10a6:401:5a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 10:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:09
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 16/34] net/ntnic: fix var size
Date: Wed,  5 Feb 2025 11:45:25 +0100
Message-ID: <20250205104548.1533554-17-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|AS1P190MB1799:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 72130550-b5e3-46f7-39d9-08dd45d24d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YXdci+9LpVLj5vdvmwAWKbA0e3quxXhzcvpNQ5Oik62Onr2SnZsItM1PSxrw?=
 =?us-ascii?Q?I8wEZqNui4zWxqGimH2M3uOJO++T6zpxNerJrUKbRf5edJ3oVEmNESOx9Y7D?=
 =?us-ascii?Q?DVsv++HHyEizCxvIR8T20R5kdw20Z7YFeOWrNPMKnMVkePwIbKkhufVKofgu?=
 =?us-ascii?Q?LMm5Ord6C1CsKu+GWVMU5BSvHIVRI7I4hsJPIJNtnvJ9fuidtiIUxOEXAR72?=
 =?us-ascii?Q?rcsbF+DWSIiO1oMqilxHZS/qBA4zAKX7Pm+cpQ5FHwoEegi2ybAFGAR0M4Pg?=
 =?us-ascii?Q?zX8QEzYLyi0qiMFLXeKqqe9+7KVG5ytEGOUYUryF69ltd/9nG/ggdB3zwPtS?=
 =?us-ascii?Q?SUafofeyOIfA6F+Hi3UEhiP4cQMNyUqiiMqo1uJPB6vREJHD79+l6u/if9xo?=
 =?us-ascii?Q?JsSv9yPQk2gv42yUcJYpU/DhCGhD8tBBv1viovHEIFk+4ywIvBSIw0VnZ9GI?=
 =?us-ascii?Q?dBXQH61zpDwujW8HvFvbRBMPr596vglwd1cZX0M1A+J8Aeiaov243cZzJ9IW?=
 =?us-ascii?Q?wv+rLvuxersIMfv8BrBXRP6Md6LVG8PLODX6RfwhD9Z6c+qOF9eQtmS+P34I?=
 =?us-ascii?Q?GHgISOAZsVGeaHmUpOIDTA3XnfYs1XDmC0NpJ+YbCCtU45MY3hWsiZEMsriO?=
 =?us-ascii?Q?HbJm9+VDXrde5bR2GYrk0i4Pg8vLPwMwdkx4YmmFWeYuEfy6MbTVy71B8tJm?=
 =?us-ascii?Q?VVPS0a+mahuHQm1GLdXw7q4d4JGgPMj2dhOMvszff3LmEEJ6qIR/wOxW+gzr?=
 =?us-ascii?Q?g64gNPyGB3AJZO/j9IrtlkNBFbnFn89h5//O375uGy27ezVBuXibrXZuxg1Z?=
 =?us-ascii?Q?h7Cw9uDjLAbzNAKZ983UxQh+P1TeolGDvE4mNjApvzaJbpRgiHFBmm9/UH3w?=
 =?us-ascii?Q?kcC58u+cOd3uMhStpcxeCwCGppHC3I5fWOwI8yV8YPljOm/wyfm3BzJEptpE?=
 =?us-ascii?Q?YaWe5f/e0ow9XgeQzsIQ9psE/r4FXJs5CDXrwYSwxB+1MIp+Op8IB0dKZXR2?=
 =?us-ascii?Q?vcM9xpWgDm3incLLClMmU4CejZTE7Dmuqp+curgSAcMM4pN9DEzr20EeWYTs?=
 =?us-ascii?Q?Vt/+UiZW6+J29wA/Dn4hdlPUMQOwcUZHHJhw8WNlwgIwb+wN0aeX7AJ+tp/Q?=
 =?us-ascii?Q?HSP5hB9RvQvYY3B7ez3gbHhotHn6rP8qepGf5bVdHoGph0//9m+3AMMPWsSN?=
 =?us-ascii?Q?jNEE5Kt8VeaRYm6/+gXHHKH7lFKQHtHsvkgXkF308f/w+gwdv96mjwR5qFdL?=
 =?us-ascii?Q?YHnpK3cuWkwYQe+61nmHejwUBUzfJ5CxODzRWghhgaMMqERekQsJxOW5Vot2?=
 =?us-ascii?Q?GWI2XJW8zV2kJDWBcCOOb8B7Aaoy9hvnlRei0YcVMRMso1aifRP+GqOU9usl?=
 =?us-ascii?Q?F3T3vPwV+5qgRxYGPvjkLh/Y8+y4EF4WAMj1L6SjpsC/rVEIb5BxsWgx2Gsd?=
 =?us-ascii?Q?C1zXVz73OJapeaTCHsT3NEDsJkTSuFM/+XrvF/bRjE/VekATAZMtgL4pYRCs?=
 =?us-ascii?Q?AZALisb03pQdmEs=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +JOaSt+6aSdq5PcXDiGlss92WsqLOtONVMYbKRBoJpehkpHrBK66udze2Y4yaOCXfGZMw8/SAWjxWT0E+loGQZtYIEt+foxFEo5POdmbFzua8YZGa2cNqV9Pz3bISfcUJzukeoHn6o3de8+CaBxYv2pM89if1AozufcxNpaBHIeKFCnFGUykihG/tjoZsM+5J2zJDX0BtdnIvmUcGOI5X3HYGI93zVM6iOasany3vE4r25EBthVCRES6I+j75jxVIoe8hpJhrAHC1f46CFjD/HvRR2XOWGEZXWuVU1C8adAI29OwXPY7HYe/shjl/WBQgdr2xl2MfGhZhz1ZV9gsHzsVX+OYE/a8xJ5Li5OjFBqTKvCz05zOVXiRwiY+KbO6wrbamnPmCfLas+cthjY3nmJpBr894hIxozJmIuv7+36GZWshnsROTqc52QNIzKpwyzOPUD//LV+EObcehCD4idGK4ZybiOsrUTNFKUvsoAlm9QdOKMjg7GCD4qzWXbF2OFIwwrH9PgYZ8dFYFTHcDzXcdEAL6eesyZdoEtBZoG35pJmQsTu1ZlubIO2DNEw5ScHbCJhXfJjKtqZae47O0IGTd10+K7ErSnKE5GaXsHjzPkPNE1OElkKVWtWRwHFCO42kor1C3COcYDwapUU9ug==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:09.8083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72130550-b5e3-46f7-39d9-08dd45d24d57
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1799
X-BESS-ID: 1738752371-311016-7899-627-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.11.236
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGJgZAVgZQ0MDY0DI1xcLSIM
 nY2MDUzMTCyNIoycTS0Mgy0dzQ0NJcqTYWAKhOugtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan17-106.eu-central-1b.ess.aws.cudaops.com]
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

Function operate with uint16_r value, meanwhile return value with
uint32_t size.
This conversion was aligned to the uint8_t as far as max value of the
return value could be equal 16.

Coverity issue: 446747
Fixes: 67aee0a69665 ("net/ntnic: add used writer data handling")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 279a852a1c..a2c9ef27f0 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -345,9 +345,9 @@ dbs_initialize_virt_queue_structs(void *avail_struct_addr, void *used_struct_add
 		flgs);
 }
 
-static uint16_t dbs_qsize_log2(uint16_t qsize)
+static uint8_t dbs_qsize_log2(uint16_t qsize)
 {
-	uint32_t qs = 0;
+	uint8_t qs = 0;
 
 	while (qsize) {
 		qsize = qsize >> 1;
-- 
2.45.0

