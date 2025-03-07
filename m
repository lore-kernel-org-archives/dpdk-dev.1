Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8367C28B2E
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 21:52:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7875D40EDD;
	Fri,  7 Mar 2025 22:52:06 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id D549C40E96
 for <dev@dpdk.org>; Fri,  7 Mar 2025 22:52:04 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2236.outbound.protection.outlook.com [104.47.51.236]) by
 mx-outbound45-208.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 07 Mar 2025 21:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCnlBAPx8Ej7SQHeOpTFiyAHODr9wE/0Sp58detjpay1uaAd0myi3pzptlKgerpksSjW3lRU36va70wzzjSgqEZK7xCeAOyLVHVWZuooGt/iqP1rBtwwgX3zmUYzUGZuOo5ykT2QPRC0QkO6B4idi9UwHuIKVUSDB7G/5XVe7nfH7fR77LUFGXII9g3o0g9PwAyUAMIwttOk0n1UMNvMRIpwA9Q7SFFR6hyOUuimStpcmVtTQ++yPynPqw4rA8eI8VA23tsrsea0Nbhu/T8OWnHWU6MIyShBD5DwI0nLU2mT4zyy1OndClsP+fpKAZckgDr0NCfu98ECCjJK1Q5Y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXYFan8ifVN+T7cc2vifktWp2+QBpOoyE32o+n+bXGI=;
 b=dSrivp3xSjlaZnipRRFWd6G1i68BmvbIeTTGW1YEgzoD7hVSuJCt7B/jlCznK5IjYurw1lrhoNoEKdE3Rdtgp/UXimPhI/DHjJrzcMzLrZgroOLLaDD/gX8Do0XphuLMC0f/JHYBP48GagLLVpcEaQv3Du6XktuC9i8BmF2XPPob+F9cEbp60EE8A1+XkhTcVh+c4VxQc/J2dLy8R3Bl0j0madk3nW5w+PFBT4a3u7GyBR0fcFB4RxFbJJwavlUdSNoWM6hK65KSACVKPUCu5ei2XKy6lT2BYnRqhp1jORjAXDEKXmbQ21tXST5LTtPcjzBF1EWTngG8T9ZnZbojdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXYFan8ifVN+T7cc2vifktWp2+QBpOoyE32o+n+bXGI=;
 b=c5JbubJ+huYzLxt8qjj17aR35CphxQUYog9mazkspPjw1p2tXbQafYkYUsHKObeHr17a0wPg9UvjJG7GKyVLYG1f67kUPwS20QUsex+UBTLZ513UNzkl8fa5PODQElj7YygCIb5ebfJVMdZNpuCPm0X0oqOOtyVfA0Nx2XHNluw=
Received: from PR3P191CA0059.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::34)
 by GV1P190MB1900.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 21:51:58 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:102:55:cafe::48) by PR3P191CA0059.outlook.office365.com
 (2603:10a6:102:55::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Fri,
 7 Mar 2025 21:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server id 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 21:51:57
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 1/5] net/ntnic: add SPDX tag
Date: Fri,  7 Mar 2025 22:51:31 +0100
Message-ID: <20250307215136.3110019-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250307215136.3110019-1-sil-plv@napatech.com>
References: <20250307215136.3110019-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|GV1P190MB1900:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f702444a-b8a2-400e-e9f7-08dd5dc24893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?slu+XpJUExI5xXYm7Rjs9KFEOvSjbQ7pDR4USUOCrQSZM+evba8hBOgVNOaw?=
 =?us-ascii?Q?eMi/QZFPVyANQ73hjXR5ZfD3zD6zsup40Ti+rSodJm8O1H/qay29iKCNQikg?=
 =?us-ascii?Q?5wj0mjkerUve0wi7Oqeqadk9VwAn50WuUHp9cjwlof2wb2UtIRYj1npSVeuJ?=
 =?us-ascii?Q?S7mVAvbKqF0DILvUOPgXdTS/Lyxb3XxXv17WHdb7JVT9kSf7n9X6jvwyUkdq?=
 =?us-ascii?Q?J3z0fkyUloJz8V1v4UjbFJhPeM/Xv/ohfvPazwSdfloBsibtiVOPKD+Js7W1?=
 =?us-ascii?Q?Wsou4B1sm143hyal+P3YVawvgCXNB9KfQuROMC/BevjjCC2AXBJTtN0W9BZx?=
 =?us-ascii?Q?6fpeFoupSTrxEtjQGNSZmrEo2/SStNmo7ktLjQ+qRwYa/zDo9Y3Vm+hZryI2?=
 =?us-ascii?Q?+tkQewOTFtmaYysludlBXEOkG6lLKysS/ecyxkgx+VPDedxcYlyUX7F0QJ6Q?=
 =?us-ascii?Q?qG0ZoEMlj9FHoc8FsUnr7dX5JanY3mT86Aw8cqPI+/gKNuzXN2u0rVFrWRhr?=
 =?us-ascii?Q?+3/4J5tFB4HiNKhbnNJl6ms0gSawo+lLw29KtPU5Ge8Zacxh25mAQQQKzWJs?=
 =?us-ascii?Q?E/t6f7kgO8uEGcy6ysyVaYaFxUNYcoKibqUYvZ2MEXPtVEkI8mWxF3Xcy2sG?=
 =?us-ascii?Q?jrAclSGcWWgn3cs9mGGlTmc03UTPB66W8yLY/iOqJUGbgtWwfyAGmBGeZrCW?=
 =?us-ascii?Q?s5KOXYw69hffNh9jRgrB9KRzYxuAUZeUqpg1kZMgXkCEFQEYbu4naaFK+yiQ?=
 =?us-ascii?Q?A2diMBrfVmfVi1B3RI8R+saGXAtmNOAimRwXOAND0/7r42nEZKNbpxRQsJQ5?=
 =?us-ascii?Q?w12wOVe7K7Q8z+UD3RE7NO9tbVMPKKO36jagqDqB5pcB1GflBcamGzJKXd6C?=
 =?us-ascii?Q?Y30wG+B2Wzdo0ZtKb4jGgThCTrz/c9VJow+wS/y7r8b3b4Sk90UG9SaHolg1?=
 =?us-ascii?Q?l55uw8pZ4YFFhHbAiN39QtxKfX3291S5Rc7yfTk/wmjtOlx8e/1hYxaARgK+?=
 =?us-ascii?Q?KlcWyjYz+6ondAkeZYZXGVjjD2XkozzW2MbNOWSClTK9/5QdHc03YVeUmQ3l?=
 =?us-ascii?Q?aCgGlCCEz59z3+/vMJYqq02UU5pPbBejE1D1WXBfiWhOcQqGEn3lbGNK1fhs?=
 =?us-ascii?Q?CgWoy2D01W4tFS4uI4VcCTfhtWrE+H2iVFtt3PXK4iAvhGaxuv9ENCq3Ski3?=
 =?us-ascii?Q?vhBO33uABW95h9gnlmyXsTE9Oy6FQEl9FH0B4oCia936ljAEWGZHH9HcK/hi?=
 =?us-ascii?Q?Rxwgj329BHFnh2nGM4JFk88aQD8ADFybEveXGCwnd5qCJ2noCsRgp4Iiqwy2?=
 =?us-ascii?Q?qI9kI5kSSFtCPVq+cBJ8c2UPLoz7/WR9fRkANNMUn2QYkcTc6K/55RcBh/VP?=
 =?us-ascii?Q?MYjmBH1YtoVl1CZlVFwSgkxRlBaAbg3mf67DbQRruIzaL+yWnytgclgXMqvQ?=
 =?us-ascii?Q?v0u7m0tmzLJXEMtc+DPSGrmAkSOGV5PHNt/kzPUsRlDv5MzHDl2/fLE1vW/W?=
 =?us-ascii?Q?abUq2YQrmdO3ckU=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pk4P6VhDNMR2Nzr19BLYF2zz8HzsTDbI1tdMuiKZf3xsEF6DTOU6GydSJjQ8xfYGinjEiIcUi6ISEQf/4HRu+SwzYoz4sv4I6kL6UXmdQwWMQmpYl2qgYKH6GHuVZrnjpy+5+ybNqtgZzOpZMkYxQyS0p9hpgSNZ8qFn5P3sra7ZYRt6wbNOnKOCiiviU3iOo5efKLgQA76DnGIoTm/V35u31RyZFUSbD1o0qyvnFlULCbkm5znZhL2q7nHNI0nEMd2mAFg4Mrpttp8mlWZpjstrSZkgSZ+mFKZaMYeyAblKjp556lrKIUbS8BafdQsLQFgjixk38Z0NI/cB3gv5gpzFOgTb66AMmmiO4YYA5ZzWkO27aIK4KdP/+Fnzxayv6fyz+h/kljZgGwNI5kiJrqpoh7xa8hpwszxMAzCALHRmRv+eFt42V4ain42qZ9mjMSSgTtI5wDLM5XhYPFbGH2eSaI9sbDdOqyP2mxTj2s8s98/NzqpYTeagZmCDblUqO2Tje2UKraJJC53XVY9RTE29E/p4UG3Lum7FlsTLkvgRGFOTQgGX7XrEtEspfBL+n/mALZvZEMeNiTIGkg6sAKyTUu/aAJFrgC5Mw2smPR3XKsXSDEVtWE0l+Ydy0LrMzS8a0SMqO0iyDP7QEO1xAQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:51:57.8076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f702444a-b8a2-400e-e9f7-08dd5dc24893
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB1900
X-BESS-ID: 1741384321-311728-7637-41532-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.51.236
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmxkBGBlDMxNjC3Cwp0TLZxC
 I11SglyczSNDktxdgsOcnUwtAi0VipNhYAsVGvk0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262990 [from 
 cloudscan19-89.eu-central-1b.ess.aws.cudaops.com]
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

Add missed SPDX tag

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h b/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h
index f87828fcfe..43664bcd8c 100644
--- a/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h
+++ b/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h
@@ -1,3 +1,8 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Napatech A/S
+ */
+
 /*
  * Si5332-GM2 Rev D Configuration Register Export Header File
  *
-- 
2.45.0

