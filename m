Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C56C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:52:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28F8740E0A;
	Wed, 30 Apr 2025 15:49:46 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 3862640667
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:31 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 mx-outbound43-210.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq0a4jw+ObzzKuJefQl0HvUWeNIB+ffG3yaD/yJnAs4bbPX3pzRNoQakuOOVEp1LeDsq7J//SZvppQOxQOrQShRPiIU9uwZBjtVJsjueaj2j3Y+CTnhBFdRw3XRsLkp4CIaBvI/QBzoei4SnwhZVrLF9gsD+XNBy1Tin6iebG9PJAL/nVQlQXif7Utsd0j/NUqH3+jZFztY8VQwE2URkd/iU72i18SbFT/cK52rUHq7WAV5Ve685BjgcWMygUOXwErVYBmyAVwbmFtUJDZ1oiIZeVTeeB6NH9pQd+JDGVtkMqryOS6pdD6856UvSRsP6Vn8wWV7fUpmASQ2rKApV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O9U8OoIAByOXqZAYHaByOJ3UK+Oh0ltokxgUa6IjZA=;
 b=Eyd7N3O+G0keCvdLPKvyae/gMy4Sn9ns4HcbnqvxfcZkD6dW59BZf96364Mu4GCuZYLDWIeWHSSisNddCAMcTZGbPlDo94/RpGeipSEVQQz4o9z2ICvJ3cDPo45Gn8jLKmNuPUao/6hvm3iAkil8DXbAXS2Zw9dCXOO7gS7LNwNOX2+BTn/NZartnhHva2tmralUWqjEvFfse0dHh8JS2So1RKVf+Whu2w+5LXEZ3Ac61REWmwbC2G+eZZRjv9I1ZFIeQ8/rYhh253cGDUvrt6wbo74a0DL/8hkcRH+ik+6dfJzYJS7nobs8ILFmlRQ8a1gOd+WtESKxcSMV7iGYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O9U8OoIAByOXqZAYHaByOJ3UK+Oh0ltokxgUa6IjZA=;
 b=hh8om+IdSYpedO7qXkM5GnfxgvnEkS46gHrNL+KKo+6amN0uKB5liDt0ctpH41Cqiv7W5X6xBc9iH0pQ///fhDQq7PMIxH160vjfWZFi/93w9TzqAhLNF/PYlcVqLAoNQK00+wZX3ISNqS3RbuSnlsAQmEMEQ4QJknOpWYewE/o=
Received: from AM9P193CA0010.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::15)
 by VI0P190MB2047.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:20c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:23 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::2a) by AM9P193CA0010.outlook.office365.com
 (2603:10a6:20b:21e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:22 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 22/25] net/ntnic: remove unnecessary memset
Date: Wed, 30 Apr 2025 15:48:34 +0200
Message-ID: <20250430134840.402553-23-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|VI0P190MB2047:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c45225d3-ca69-4ffb-d26a-08dd87edd050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fv2m82J3EwofqRLrE9NbJ/F5HZmINW9e72UZQs9w19ybgBT65+Ss9nYydbg3?=
 =?us-ascii?Q?nCngeholLrJCRAUW/K43s7OuzPJH6kn8I8y2kELRr792++3EeGF+FwfyqtfF?=
 =?us-ascii?Q?/HJD/cf9cGXniJ6yySQiKILhJKhaKiwm4F6jO9XZaz89iZfoghqB27vFbw3K?=
 =?us-ascii?Q?hFjn7RGlScAb/WH19xxsbRTo8AMaJ963wxwB/MpmnLIaPpyGIvpDor1B8aTt?=
 =?us-ascii?Q?bSBexlwP8ERAlSKJ8HW08CbWvy9IkglD7Y8bILCHBOjnlkKELV6Oa46yekTw?=
 =?us-ascii?Q?a18SGFAspCnCRUSO+9r4H1Ds7tJfxFYPU1ckZcdq1/RWeQjQt8Kfo8AXNdF/?=
 =?us-ascii?Q?dk47GnL3LMB+Ze/UI4b0BaYLokU/IAyiUbBDQoikXfVUfLRrv4SjyJOoaC2M?=
 =?us-ascii?Q?0QpvbNRtPYLj6HbFVnVHuKVTY6KZS/opjE5+WO3bCQ5cj6SoLSjIy793AMdU?=
 =?us-ascii?Q?0I6trLuwdVfnjOtTOW/32ICbjyu6zxu3lv8c7bZltBrf1i0FlKqZZz3PW9xK?=
 =?us-ascii?Q?MjmpMs8EY8uIsDlAwCJBEISz/RsxMNKbNcMli29Rmshu2Owy5fe2RQO6GEMP?=
 =?us-ascii?Q?xenttCGqJZJIaGPl+pWpPfUolk4LhwIAUMy1koOEZ7ThgTMBBcjL8pkr1hXI?=
 =?us-ascii?Q?8bK2jKyYFdfKzLvo4y+h5tTlmcnJPX/HLvU11UrkzhPwbJrYsSLdfe1YbcTi?=
 =?us-ascii?Q?VAFMKLoK6zrhiE1Z7YQlg3gAi84jjUdjDJQE+LLaouGkEyd68EbqKX50Zr1H?=
 =?us-ascii?Q?t5NxrPqpTX2hc2USIWvjPOHGXjranVJ6M1DTZ36nQL5fHyebstQQMD9qbqzF?=
 =?us-ascii?Q?4yMZSUwg5s1MMAyvg1avijxinE4IVVSp2wWqpdn1B1r3z2HP1CgLo+2cDriD?=
 =?us-ascii?Q?8XcAfQFnRauDTadObT1xd2Ifti7dgvswm/9XzqhRC1aUlkzZAbGiGMr1EULh?=
 =?us-ascii?Q?JxVjwL/43VZHjmDLk70zMNdNiIxXKU8/drqcN8RcaioWUbuDzmBqpHU+O+pN?=
 =?us-ascii?Q?9unShBTDM2pWz9+6N3VZZraCqBzmKaZOO0OJxP1Tgvt7i7ysUptdvQXGJHfD?=
 =?us-ascii?Q?bV3RYO+wYZkd59pMIJXp6BgyFYw25iqHgomVVobd2r1Az3l4XMzDS2VyZqdI?=
 =?us-ascii?Q?ETnV8XsM/1tAutsUfOGUSzGrMa9+PddHig2F00WfUEoZly/qJrwFYGhQJbl+?=
 =?us-ascii?Q?is0ISeSpvC4ibcOlVR+EwoTAx2McP1QMPWPp4G5m/LUkh6MR88LTkirw6LZ9?=
 =?us-ascii?Q?+dTN3iSlz5VwCAbpc9WwWBHQLyVGDey2dUX8Z4zfTA+5quX3B4UoiYCN5v/v?=
 =?us-ascii?Q?H5qo9yDUQdJTxArwgQBj73jAMqicI7qD1vDYLPffeBnlFKfW/iKBz8hC0m7B?=
 =?us-ascii?Q?M+5/NIEsOyxtJjAOQ3ugUMlHTCT8oJxgErb5Zbu32s+yIy+wORKCjsJoQA3M?=
 =?us-ascii?Q?rjTwaBvWKd2klySMQXgEfLhIEEkmBeSvkEyGR/u3KVEAThRCCg2+nvuLtGvV?=
 =?us-ascii?Q?jQ2OcMRrUIhm8RbDJzx5HKET9p8zl0i0w5xG?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uMFpYP6bOgy7qzNZ4QpqJ58NSlx77YMxcRJJvNcuCm7GYlt/X+vf1wp6y95bXlQI1S0Dj5vx+cx7AdBrZFXmcmuoaSaDTRfzCvc0gCif4WRZNKWO9HM9I3zr8b3FLQlQJXlyDNQ66qTyrev6YuSr4VpAJDbiMFJiloLvVcRmxAl0zAKzSodq9ykjRn++n10O8aamsNXjBNqcqaWs6JUM6LttqIoHEcQMGHysm6i7ILZ0SW/ptf0UmFl3tDNcmasSA9gZuJsgzRFaISXfHQeytvMrWhE0VzRlNN8rL4S/gJfgR4hJDTe7lT3YiPtvlKgX98G+Ro7fkmViIYjUQQXESYRyD8VEJDCyTCRfMquCAyw7rXc+iQ8zE4SWfZcm4Y1e+0i/VwmicrdvOYPw8/Ch1UVnqj4mvYzY17ehKHdHFSEZb58Tge22On+4176airfjXkb+FIzGwz56ZgZD0W8grIOaMOBZBkxgYbz3d/EY53MbpGzuPpvQLv5uF+qto73AmMsh4J50dPOeiWEdCOSqRGU84IGamR6YvWzxn6PjKUsrtZEXJMh5h0IhEISu34JnuQeLGssvJVRRmE3Kdt33Gu6ik6dzRf9qoN/IAs78dkc8st++s5cEacLEY0rPeTk+GSx80ZUO13dgRHpiZwZJ2Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:22.7021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45225d3-ca69-4ffb-d26a-08dd87edd050
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2047
X-BESS-ID: 1746020968-311218-7644-8878-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.18.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYGxiZAVgZQMDnNItEkNdHA0N
 DELDE52cQ0JSXR0tDMIs0o1dTYxNxEqTYWAIkbugBBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan9-176.eu-central-1a.ess.aws.cudaops.com]
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

Calling memset before free() has no effect and will be flagged
by security parsing tools as a potential bug. None of these data
structures have sensitive information.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/core/nthw_hif.c         | 5 +----
 drivers/net/ntnic/nthw/core/nthw_iic.c         | 5 +----
 drivers/net/ntnic/nthw/core/nthw_pcie3.c       | 5 +----
 drivers/net/ntnic/nthw/core/nthw_rpf.c         | 5 +----
 drivers/net/ntnic/nthw/core/nthw_sdc.c         | 5 +----
 drivers/net/ntnic/nthw/core/nthw_si5340.c      | 5 +----
 drivers/net/ntnic/nthw/model/nthw_fpga_model.c | 1 -
 7 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index ddb875f625..f2d6f372b0 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -23,10 +23,7 @@ nthw_hif_t *nthw_hif_new(void)
 
 void nthw_hif_delete(nthw_hif_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_hif_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_hif_init(nthw_hif_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_iic.c b/drivers/net/ntnic/nthw/core/nthw_iic.c
index f84eb7eeb2..a96d878f25 100644
--- a/drivers/net/ntnic/nthw/core/nthw_iic.c
+++ b/drivers/net/ntnic/nthw/core/nthw_iic.c
@@ -253,10 +253,7 @@ int nthw_iic_init(nthw_iic_t *p, nthw_fpga_t *p_fpga, int n_iic_instance,
 
 void nthw_iic_delete(nthw_iic_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_iic_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_iic_set_retry_params(nthw_iic_t *p, const int n_poll_delay, const int n_bus_ready_retry,
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcie3.c b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
index 5928f81629..bad1c31e35 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcie3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
@@ -24,10 +24,7 @@ nthw_pcie3_t *nthw_pcie3_new(void)
 
 void nthw_pcie3_delete(nthw_pcie3_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_pcie3_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_pcie3_init(nthw_pcie3_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_rpf.c b/drivers/net/ntnic/nthw/core/nthw_rpf.c
index 1ed4d7b4e0..d5c19e312b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_rpf.c
+++ b/drivers/net/ntnic/nthw/core/nthw_rpf.c
@@ -22,10 +22,7 @@ nthw_rpf_t *nthw_rpf_new(void)
 
 void nthw_rpf_delete(nthw_rpf_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_rpf_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_rpf_init(nthw_rpf_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_sdc.c b/drivers/net/ntnic/nthw/core/nthw_sdc.c
index ae967e5ed9..a7242a8a67 100644
--- a/drivers/net/ntnic/nthw/core/nthw_sdc.c
+++ b/drivers/net/ntnic/nthw/core/nthw_sdc.c
@@ -22,10 +22,7 @@ nthw_sdc_t *nthw_sdc_new(void)
 
 void nthw_sdc_delete(nthw_sdc_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_sdc_t));
-		free(p);
-	}
+	free(p);
 }
 
 int nthw_sdc_init(nthw_sdc_t *p, nthw_fpga_t *p_fpga, int n_instance)
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5340.c b/drivers/net/ntnic/nthw/core/nthw_si5340.c
index 05cadc0bf4..ceaa58e0f7 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5340.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5340.c
@@ -44,10 +44,7 @@ int nthw_si5340_init(nthw_si5340_t *p, nthw_iic_t *p_nthw_iic, uint8_t n_iic_add
 
 void nthw_si5340_delete(nthw_si5340_t *p)
 {
-	if (p) {
-		memset(p, 0, sizeof(nthw_si5340_t));
-		free(p);
-	}
+	free(p);
 }
 
 /*
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index fbaf0c2d6d..0838527716 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -183,7 +183,6 @@ nthw_fpga_mgr_t *nthw_fpga_mgr_new(void)
 
 void nthw_fpga_mgr_delete(nthw_fpga_mgr_t *p)
 {
-	memset(p, 0, sizeof(nthw_fpga_mgr_t));
 	free(p);
 }
 
-- 
2.47.1

