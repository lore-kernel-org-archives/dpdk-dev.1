Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8840C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48CBD40B97;
	Wed, 30 Apr 2025 15:49:35 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id A5381402D2
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:22 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2232.outbound.protection.outlook.com [104.47.51.232]) by
 mx-outbound21-53.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVM/hELlr53O/81X9/zo4RLHocj7iKNhU4U4sqa0rncyOztdQdAihZKi6HMkF3BlbGCa5PbaOZM+9k4XlIaN/rHU8VHEoje+CLtIxvNgnK3/vN94cBq+/dDSMdsm5ehr0MzJXDllqRK0BxZK4aKkrPRfe3hXNr1VVuVUBVOr8Sa52A1VkhqAQDPl8ddMQru2B+mxXeAaSBM2v0ORMq+ZN/FPA97AR2tJeUWaH8WksyTeRqzW7cegNpklt8R6cil0l9W4ZB6n0+g1RE9TCrkD2x+ulY1uVBS9KGf1XodWRjtBipKRaGXDEHLXCADyqJ89v/jKWe5KgKrxJw+yUYCEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejWmrTWxQFcHAOdOCONJpfcT8a5kl8NfdqJ0rmKBC7M=;
 b=uxD+xlp3NYYZYS6tVkk1HJjESgc63XtQAVCLG49gysJpxoSRNs1d3sEMaPEFy85OKMzu9K310VExyOVJEts7grd/4bdjaaJ1j/M1BLpInSUFcckW+xvv6bPLjqyf7UM1Dk631J+QHr5x8tNwpwmitHgKNf3sqjGGxTprUvQEEc+pg8WRiJlqUtDLo65W4CHN39XoH2Syp0FWYAdV1PvtNv5wCsYrIPQvdnVlEW9KLlrIBcRyZbnXqtlx8rgrmQsOqhvyDdnxB1l6QOZEjitp072dJ6yvOl8zZKkybhSBcSwMih3Y3rg/nZVL00No7nQs3N8mkzd3x3CEiztbJvh33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejWmrTWxQFcHAOdOCONJpfcT8a5kl8NfdqJ0rmKBC7M=;
 b=SzR0nA382fJpXqpSPbXICYqWZ/gU2YOOI6HhykbgdGrq2mrY7lfGi93AMZeMUWFsMiXVUcRfCzLFnSb8chA6FXwvfqQC8/eJZfBr5PgwAsl4Z4fdfg5PH8o/LJsLVo8p6oi6nn7qiz2xa72BFrOfhChawCtelU72hHp4vyhj45k=
Received: from AM9P193CA0026.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::31)
 by AM8P190MB0978.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:49:18 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::4d) by AM9P193CA0026.outlook.office365.com
 (2603:10a6:20b:21e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:18 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 17/25] net/ntnic: add return value check
Date: Wed, 30 Apr 2025 15:48:29 +0200
Message-ID: <20250430134840.402553-18-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM8P190MB0978:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c295f0ca-85cb-440e-dd49-08dd87edcde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HtAkM1bR5l8xd024fa52bRI6PRPHRqi8v5GJvMi0dKwOyVh5b57Q/VYE3hXY?=
 =?us-ascii?Q?w4AGMM6NkkvUwguPL2o9ouDDdM/fmjPwPf7KgOErGwaohGOdX8FiMLYKx0EQ?=
 =?us-ascii?Q?yuRhtfR0lHN+jMVTIAHJQuV+RR3KP6o1NQK6INx/kOlLqENHLB3nOfb6GxL2?=
 =?us-ascii?Q?IhdrXlO4N+jvVBRuCfTLObGtIo6KWaGUqpppMKV2okICOyGcy7Nk2tdqMNs2?=
 =?us-ascii?Q?Kl7hMeYE0qk2WHqhxo0n8lZ4+pl+g7bYvRabOzywVnNIVnJhu6gH2y0m9rx/?=
 =?us-ascii?Q?dlA0xOcqfwPpx6o+0DD9oF3kh2/KH/0W/X43OBjgszckFz+JKEFpjv/89tzC?=
 =?us-ascii?Q?/nt85ckHiKls9uMdr2wiRPxCyh/rz++yLf+LQ0rupn8aGdOV32bRjuIInOD1?=
 =?us-ascii?Q?uL1R055OXrFh1Q/E0zCqtNEiLSrYjY0G3Ikevi2OTJckpCcWJGx5hB7fV5cV?=
 =?us-ascii?Q?WzrbiZBl9jQsQ0HvLtNTMFuSDEyACxNB9bvsBOfND//gnEmTZ5IZLb/9Svxy?=
 =?us-ascii?Q?o5y+EmtpKBfLbBUp6j7NL76XKQ2PjdQwnlb5eYVB0sBQSZVOChElFkDA6o2o?=
 =?us-ascii?Q?Im4XD8smLSiezD6xykIp5lH75i5JXd8y+67GLM78i+jf39tz3PUqASQqdeFv?=
 =?us-ascii?Q?m5Y6BRk1hTjA+IGbzmk2gIq8RQU7ggyyxwcmjjqmrzZBkmPaQh/TL2qdOEp4?=
 =?us-ascii?Q?H2y5T2oCUWf3ZxupPFe3ZNeBtaeikSdyFnYrUCtQ3/QFAz34lLlfaWj3S1DZ?=
 =?us-ascii?Q?mQOQQ8STidsD39jcfihBtYIfoW2PUKWSxTDqJObKC9K6wuu5SsP4hFRqz+6K?=
 =?us-ascii?Q?8naOjFyqBnxGpOdnPkJo/1Zjb1P4Cc/xw1uVwuhyMob42GeW6X5V1WS1VREr?=
 =?us-ascii?Q?/MvxpNLagyiFDvJatzG6oC+2ERtmreLI1rvatpsFd+80e1G2ZA40a31s4sn9?=
 =?us-ascii?Q?+JItcmpnLeM2+/QmDKSTarzMRV/m4yytjvwPb56YOtlG5fv7Twfh/zs+kx+Z?=
 =?us-ascii?Q?2pn7/v3uvMmn9QJQn0gwF9YvSlCPAT6f5c8Ze6pSPuV+yCt2mfReGdNVs8PI?=
 =?us-ascii?Q?zJneM9cxIRyaoheK1BEs3oBXWwLjnIH+kSwUVlIO4v7UaY5tvgOOUHaqQjw7?=
 =?us-ascii?Q?fUYRuqY1v5iqJ/Kb5K3uexErVeymNnzVkgsP4Kn8i1EhcmGOTa2aRM4LN1Vb?=
 =?us-ascii?Q?xkyHeZk1d2NXAfTvUFrZmUatxVS1Z2XSu7n/lhB2RzSGe2R8QEcthyrg2F5a?=
 =?us-ascii?Q?7GMth3OvgXURrUXrBxkGA9IZQBX8cuhCA/PKjPIyK+gMMZpfbj1XQTlAGeDo?=
 =?us-ascii?Q?G2ln3BlnWGLkxe2kr57SXtox06PNXPPeFG0Ki4UYb33bl8XwI9HAlS4uNPMR?=
 =?us-ascii?Q?cQWZ6RoSZ8BnkQAMphrYS+daZa076Rk7+99pBLgFYTlBvNz1Nya6ELJern7s?=
 =?us-ascii?Q?WU1qLBFRXyhIib+HnFlrNC0mRMSOcZ3+CZD6+UGHRA3Dq2LlZec4c1wRKO0y?=
 =?us-ascii?Q?xwDHiTyS1qHEh+gvz03zGCQfRCdZEZj5RwQc?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wvgxiDa5P0Ue1pw+C6tWmYxyGXAOEbC4k8DIQa1a0whGP4AJxRPZbQJsbpmeRd+ypSRPZoNOXiExohZnGQtx+vdTyu/rEkrKExYWztCfeln20bl4w1w5ni/COef3yBJupSUxBNHuYTaCkHrrAaXtfXbP5Hfjd3OUBt4GMM6QEc7CSjtx/akPYfLsN6JLcGgjDIeKbDkf/+umjbi3ouy9ikC2WY2fpjB64AkFXX8g2hndqxMGjK9Rs4Kufa4lgpkU7d0nRHuZgrjhvq3sf1VUxVdGOmMfitsIeWrXUAd1uYZTbtPNALJSGDbS4Hz35HPZzco+h4noVWp5vYMwYQRFei00jG3Ig8k5eGGa4QNBsApmjzdI0TFh7IHMiEZwhra1ty0QmT//dhyefWITYA9WG2xx6fgfdLybng3cvFZwxjxVpIafdgRMLCBxnhaqygZE/FxX5ug2aDUwhVyRmTtCsuU5JDvh3WyAyg4s2eraw/haBNoh7EHhA5Xb4Lp2EyvhrfECB1GZDxkZEPYhAi3JDo184KtyQ3fwOGFet1RCvnE7Ueia8Le3TrWUbl0NVPWv+BylIHi19qF0CByWK53cH4pNGPQwbVnEy1N62gmcg4ItXBH6HchKdifN9uKDAzj07QeeK39ctRKIHBWI7SY9Dg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:18.6259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c295f0ca-85cb-440e-dd49-08dd87edcde2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0978
X-BESS-ID: 1746020959-305429-7646-9236-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.232
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGxhZAVgZQ0MzEODXRINU82T
 IlycQ8xTDNwMLQ3DIxxdjMIMksJTlFqTYWAMv2roRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan18-242.eu-central-1b.ess.aws.cudaops.com]
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

Add separate return value verification and logs for function.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
index 3528792845..cc6f7d13b5 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
@@ -528,7 +528,16 @@ static int nthw_fpga_rst_nt200a0x_init(struct fpga_info_s *p_fpga_info,
 	nthw_rac_rab_setup(p_fpga_info->mp_nthw_rac);
 
 	res = nthw_fpga_iic_scan(p_fpga, 0, 0);
+	if (res == -1) {
+		NT_LOG(ERR, NTHW, "Failed to init iic instance %d - %d for NT200 (%d)", 0, 0, res);
+		return -1;
+	}
+
 	res = nthw_fpga_iic_scan(p_fpga, 2, 3);
+	if (res == -1) {
+		NT_LOG(ERR, NTHW, "Failed to init iic instance %d - %d for NT200 (%d)", 2, 3, res);
+		return -1;
+	}
 
 	/*
 	 * Detect clock synth model
-- 
2.47.1

