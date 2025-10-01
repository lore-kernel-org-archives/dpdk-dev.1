Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19686CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:12:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A92EF410DD;
	Wed,  1 Oct 2025 17:10:48 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 3439E40E45
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:41 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021106.outbound.protection.outlook.com [52.101.70.106])
 by mx-outbound13-239.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwyQQwfHx/WgMwuHSuIFWtxJcOF2JVKiNFA90Qi2uXJKx3523WwCncXF1wNZIS3oBseXctQqw55i3clTHEasuKr/Tx+TxW+St+8Mf3PXLhJNn8B60C93ImdUZkGjpJC1z7oxd9FY2UF0HbAgecTvx0+Y9sFT5yyYx/TyucYqb+txAbfTBbVEO2LTdMCL/BEeotpucM2tyuIZAQvawEj/Lm+WcdBtjIU4JMGYGGrn64AFXIbO0wmk11A7z9/CAqVnXXNSbnr40Kc5KDVo7fSAtBubo1n45BOQiVd+ChLytPaLmIhC37Xuwuey8YQYwHFoe7tTZ0JtyFJh4nBpVy2H/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHCmwpTKlH8OtHx263R8vxnP9YdylXo/isQ46GyGrTc=;
 b=m1sHR9GWO+5poPJ9XRL8qj9GvbVFKy6qQn3yFxRKM09QKEYFbwe41VPuGu+Q46emardG+mbXeaKy07t2ZoSzwUnDQAgqHId/gujq9P3A9RfL19Bu0ANqhra6XBr3ylg3xtpanhB4BiaKCqxh3ia7dtKm5WauvDSI+cBkV27l0QLT7dt/fSglc1iX6c7Dobo0QhjRU+qhwvjXHSY4IAfzJTejuzy8/7oOx38KUtk59c7CC9ahtUKykJYoPyavDSmchmVdEujwi7vCrfbj3e/I92KpwozlCuTX/zxt19NzYnPi/rMvlZQfrewnwC06RgRJwlPBBgUjsx1XS45yGm7LNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHCmwpTKlH8OtHx263R8vxnP9YdylXo/isQ46GyGrTc=;
 b=OHh1hNaZg19HCFGo0jnctXhNgvDCi5iz32RSi+BSe2IyVOTRmp8C42t0LIq86hYyduhC+g4weaGUO1G4i9IVA+Nedv7jJUmD2erzw9KJmRRu/KsfMQtKi9t9loYCc/zaEQYuPE8mPrQYFTgNYBMLoiTzBqsIXq0ZKK22XuKesAo=
Received: from DB9PR02CA0022.eurprd02.prod.outlook.com (2603:10a6:10:1d9::27)
 by AMBP190MB2422.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:6af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:10:39 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::e4) by DB9PR02CA0022.outlook.office365.com
 (2603:10a6:10:1d9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:39
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 20/20] net/ntnic: rename nt log types
Date: Wed,  1 Oct 2025 17:10:02 +0200
Message-ID: <20251001151018.250671-21-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|AMBP190MB2422:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 23917bcb-56a3-4dc7-748a-08de00fcaea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G9WbM/qhUs1tEoYNr1WageB8/eEDBMR/U7kFG2Kdcihv8bmp5RAQ49C2CIQb?=
 =?us-ascii?Q?LukRZ6pcCpqN7yRvuSmSHWw7HrSQDrP0RH9U/C6Yy0DRJFKsekn2zUcXcWFK?=
 =?us-ascii?Q?APNUZEH6PCyBP6cpu9VJU1EQdZ0raWKFZjy7fToGHYobR1TCOIWBVRg9s6tr?=
 =?us-ascii?Q?c/DHkur0mxjBdnxA1MFsOh/8lDATbQQo+oeh45cPHHQB/TZjF9OvUL0eNORe?=
 =?us-ascii?Q?+fwzC4LlguHvM4w6ZwqWNdJOnHCrB5wPaXrkqotxZufidfCT/hOyLpX9D5b/?=
 =?us-ascii?Q?Bt31KZWMrUsQi+v5bS7rGofs68UCimhhuW0/Q3p7zS8iUwjdcA0OI0ZpP0sX?=
 =?us-ascii?Q?O1XTG7D0mq8hhoNV2yRW5+j8LGic1r7naCqCG2wiJCA0ts5B9gpCWO3dQ4f2?=
 =?us-ascii?Q?R19SxwX116YY54msCZtT8ymit1e0li36UZakJMzHsWvkiOqCZmt9mDnzfk/s?=
 =?us-ascii?Q?qZeZPgYOJUB9mafPzWB64+AgU1YlRWshEvTtElHlvk7VeFVseAGQZJK8MvMu?=
 =?us-ascii?Q?cLbvzj0B9HWnqkRUEkO7HRGL+zWkCr9mMILlOgKu5fo5Ymy8RKaDobvT8eRP?=
 =?us-ascii?Q?emNYz00B1U1i9hMLwV9zBL49glbzKr3ZPaiRwW5JJfLGLz3c3ZcW37bAUDqS?=
 =?us-ascii?Q?AGc2WFhQsMoHit9zaa3r9Hm990MHjrACvjYluhRBhmx+rOyVVfbqADV1CQhH?=
 =?us-ascii?Q?4BTpURmlYYqxk29yZyj+3Bvjyw/A01HLESnBqKfuB2FNEmrnE0hcA0iA/ayH?=
 =?us-ascii?Q?WLzumshhDDa0qoj+zEGc6Ptepu29l1978Nhg2lfkxzX4ZYsbdJbBLkAdHr5Y?=
 =?us-ascii?Q?ju6rEPBqcrsE9UQWU21JtY3vkYDSAY68eGPhUaaIOOdjG04E7bKaXvVFWRPU?=
 =?us-ascii?Q?e955erqshhlXrcYq7mS/bfmPj0PqkVah983GamHnBrV+5hUd+ItOYV+TGOaZ?=
 =?us-ascii?Q?bcX58rNzsVZPUEMcMiv3ZxXjmppYiUHvA02UrvNTZOJq/i/2Y9CaVb0kxl26?=
 =?us-ascii?Q?NbgwaUGTWl3ps7/aCNSMmHJsMjFVw1+o8WHPqYvbejbxdOYHtzwl0bIbYlcG?=
 =?us-ascii?Q?2y6fIqftiNNnLoKkJzRXRYRYkMQ90GOy5MU37XoULtXRZUjp69uY4BB2ghtD?=
 =?us-ascii?Q?GScaZzuCR/fpQUs6rlLGgVFot1wE7cwDq7ddcM0eY5JYmS8LM+SROUBd/vzI?=
 =?us-ascii?Q?S8HCBf1dOa8N2fqEy1aEP1ZHTnAR39hzEqj09Y01wknXQkirv9rf3LEQi5T9?=
 =?us-ascii?Q?/ndYOOYmxRKQGONQachKEYsQakcLdf+I6fHf13uX5TZ6k7rxSj0tIKMoye/0?=
 =?us-ascii?Q?Q83kxwKsYr1qDjFC7vaCRNCCsDI7ZVUN2ONY0yOZATv51n/SA1GRgaSosvbe?=
 =?us-ascii?Q?oe2RVgRUm+g9qAZlVImONXscQ3EVovX+tbYdtTwh2wp1/Y5/5x+wJfSMWT59?=
 =?us-ascii?Q?EtOAnLZPJ5otGBwtZS9lPAvRRT2UeFm7ufDuyk1NU+n/QtT6CwYx5RhtUcuA?=
 =?us-ascii?Q?qCI7hHt1WXEKn8Okbqrk4/EUCKB6GyQSxAS8U0EiSkDCutq5h9okmSPs+3Sz?=
 =?us-ascii?Q?l7N63pOXKnClSpHQtX0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jqGzASzb6IQj7RIw7MiZR+E9TtDbX+dBLwndtorl5sqq5J5W9x5SXYFMtC/uUX7QZn8amPLv4c4qzrV6K5pso1Ev57bAQbAHe7CSah6GGSLRYFXIiIv5juZT7PNFXmsRtFHRHuz50o2XifIice5tDq1Naft132J3799GiXfpTyhP9idASFWQ5VecxlTx8YZYo0tGtjvdJv4Jps7WRkTbREtzBkNqnMr6Qv5V6PsPQuZRhmd2BARvQ+omfw2wx8DV9pt16RNxdEjJOR09d+n/bK4Jdcl+a5332V0SRnYpxukLfbxNoYBXPlLYGESIesgwRvJ1+j10+BXoC/Y8m1dczK1+DYtaOZT5VykDlGLX65OSwKyB7/g4Yyl8horDV7l+3rjGlZvIgBK3l4NEFnIWolgMubLEPz03bxrg4wyEG0T+EfvhvDF/Fj123oedQ1McnWFX433h+vDDcTfkJ0sX/YYCPoLvwWiUkuTEwfkc22JlS/KyvqFuCDyR3GC6PA9z+G8RX1Wa56DvNw9o1f3Dwj//1dt+g1a0jgIu69h3/eCoLf6yvdeooHnfb92AczZS+i+ta2/jWyQ+8BA2y0h6yphjUm9xgDLK6em3tQoqV62tBAj4+Uk+7jyNAe8CZFyXzS0es+/a8sstg7Gn95QxNg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:39.2478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23917bcb-56a3-4dc7-748a-08de00fcaea2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP190MB2422
X-BESS-ID: 1759331440-303567-7604-4440-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWluZAVgZQMCnJ2MzUMsk8zc
 QkMdnCIMnUJDUpycTCNCXF0CQ1McVUqTYWAAi3OAlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan20-81.eu-central-1b.ess.aws.cudaops.com]
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

All global variables in driver should use common prefix.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/ntlog/ntlog.h  | 16 ++++++++--------
 drivers/net/ntnic/ntnic_ethdev.c |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ntnic/ntlog/ntlog.h b/drivers/net/ntnic/ntlog/ntlog.h
index 810b07efd0..63489e38b8 100644
--- a/drivers/net/ntnic/ntlog/ntlog.h
+++ b/drivers/net/ntnic/ntlog/ntlog.h
@@ -10,14 +10,14 @@
 #include <stdint.h>
 #include <rte_log.h>
 
-extern int nt_log_general;
-#define RTE_LOGTYPE_GENERAL nt_log_general
-extern int nt_log_nthw;
-#define RTE_LOGTYPE_NTHW nt_log_nthw
-extern int nt_log_filter;
-#define RTE_LOGTYPE_FILTER nt_log_filter
-extern int nt_log_ntnic;
-#define RTE_LOGTYPE_NTNIC nt_log_ntnic
+extern int nthw_logtype_general;
+#define RTE_LOGTYPE_GENERAL nthw_logtype_general
+extern int nthw_logtype_nthw;
+#define RTE_LOGTYPE_NTHW nthw_logtype_nthw
+extern int nthw_logtype_filter;
+#define RTE_LOGTYPE_FILTER nthw_logtype_filter
+extern int nthw_logtype_ntnic;
+#define RTE_LOGTYPE_NTNIC nthw_logtype_ntnic
 
 #define NT_DRIVER_NAME "ntnic"
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index dc9202cdc0..3d52889ad2 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2751,7 +2751,7 @@ RTE_PMD_REGISTER_PCI(net_ntnic, rte_nthw_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_ntnic, nthw_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ntnic, "* vfio-pci");
 
-RTE_LOG_REGISTER_SUFFIX(nt_log_general, general, INFO);
-RTE_LOG_REGISTER_SUFFIX(nt_log_nthw, nthw, INFO);
-RTE_LOG_REGISTER_SUFFIX(nt_log_filter, filter, INFO);
-RTE_LOG_REGISTER_SUFFIX(nt_log_ntnic, ntnic, INFO);
+RTE_LOG_REGISTER_SUFFIX(nthw_logtype_general, general, INFO);
+RTE_LOG_REGISTER_SUFFIX(nthw_logtype_nthw, nthw, INFO);
+RTE_LOG_REGISTER_SUFFIX(nthw_logtype_filter, filter, INFO);
+RTE_LOG_REGISTER_SUFFIX(nthw_logtype_ntnic, ntnic, INFO);
-- 
2.45.0

