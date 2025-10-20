Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F359CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A300F41132;
	Mon, 20 Oct 2025 18:44:19 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 9F84A4111C
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023074.outbound.protection.outlook.com
 [52.101.83.74]) by mx-outbound9-130.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUPS3NLXGNLVc9AsPpOXHWYZnj5H5m77tUit/kA1/2gl88sWWPg84HWifY9WeQya0Z/BwhLioIPOSJemVUsR9a4ZZnoVIdSTa37sPw4RJPz6JPVI3BNBwlmcwXnu7V/W8egDvKTbs4YTex3c6b/Yp2vV+6M0hRrGoxd0T8XL91/yAgq0cxJjEt4C7Z2T54TcWWLsdVIkDbEM8Q6X+SVyT7IFaeTeE/jpxYGugte7r9mFMoNdBX4zdUnPzWalaBrHPrGeKgagVzR4YHnw9QL8DNuWvub/B20FVUB+phz5SMabghx98dAXe5dUox0WoSK4G6CNFwmthhbGuKIovi10tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHCmwpTKlH8OtHx263R8vxnP9YdylXo/isQ46GyGrTc=;
 b=sIOQ1AKLJEClW9GjybhUZevbPLGK83MjM9bDkyChJ8zarRJK+7qTVqgtt0IsSZQ1cl6h5I+RzjyeBPp07n1Y1+ZmkogNjVTB46WC+rOSS3OA1K2vytpwGKnae9Woakw/le+oiQ4qWUZ3hbDwi0A33pQQX8vHOmH3E3HIRFVlYUkuNBpHtECqZWnMn72VpIJZ/cP51R+GbNQ6fzbt6xvHa8R7xs8DL8+1D+6TyDFvIGHBVh58HhVXVkNMETQNDmTHg9OmNz4d/xrCMwA26FEwRASyGPr4fNAaFsVOns7gN62p6Sv/Z4AU43FjFQujKGUY+OrHj4svungCesQmZl+NIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHCmwpTKlH8OtHx263R8vxnP9YdylXo/isQ46GyGrTc=;
 b=YpDgz6pXgkc5fzidD2SmRryz37VOorq2jQ0SSw3GV2sNVzf9xA7Gkll4wNZhxlXDWYSZT1t5aeMvM1zRITrXGpGW+V0AFT1Hdwg35e8ZTAWRYcRDLMWWTV0jKHiH9qfTw+vs715h1KpDos27tFYQUz2kp8FIw+lex+BshoiAqr8=
Received: from DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) by PA4P190MB1342.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:104::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 20 Oct
 2025 16:43:55 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::25) by DUZPR01CA0023.outlook.office365.com
 (2603:10a6:10:46b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:27 +0000
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
Subject: [PATCH v2 20/21] net/ntnic: rename nt log types
Date: Mon, 20 Oct 2025 18:43:29 +0200
Message-ID: <20251020164336.283664-21-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|PA4P190MB1342:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f8c773dd-a9f1-41a9-8197-08de0ff7dbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oMIL1UL3ESkvhAusDC2Yp3lRr8adJj9J/AGAlRcMwpNEGF0N3agyJRgRIq1a?=
 =?us-ascii?Q?SP1wmDsDd5BaKgZ19I36cGjBnYiLzh9twuEA0YdL/lyJp4K4DWlrVqgT/kr8?=
 =?us-ascii?Q?ga1M2HTqPV1bH2zN8EeWJJjLgWn18QUku11mexoT018J2lD0Y+Ym3F0jYNhT?=
 =?us-ascii?Q?tXtTcFwx1NQ3JtunjN7mYB0pL3+DZbjYCTHZg00hGeGivrfSw4K7FT9W7hMv?=
 =?us-ascii?Q?qlpisnUsrCFH55Exgm725XY7AYG7s29hrZHUARtEB/c+gS9KDPeWC0IJtK0z?=
 =?us-ascii?Q?/eVAwdk41GrapXFki36lwjsSlbmJwdQX6pGFPrdtWOHx30REkAk8HItjLh0M?=
 =?us-ascii?Q?WLlppbOJgYR3Y1qiVqMnehUfs93CSh1/aeRkCYVVcLK6WcCgvsHQWSzmPO4I?=
 =?us-ascii?Q?HSh0halE8o7G2rllTrS6V8V7R99fn1+IC+uuSTqX+wvxOxu1ydbfc/V5XJwK?=
 =?us-ascii?Q?J5OZ/1H/KcTed7fZkcRWL9G8cRECsT97mv+ja8o5CzXNMcdXIBwdwJbGASnd?=
 =?us-ascii?Q?ndWckcg+uGvGxTGwWbJTOPZC4jg6Cb080SluBOuTeAXxpK3MzOLqZuV/pmTM?=
 =?us-ascii?Q?AhWd8jBYImoWHnT7j3fk3hbk34uhwYqUP3wAYZKBSq2TWu4EwX0Pt0pueomR?=
 =?us-ascii?Q?JIwONzGk3TIl38DXKcGqwMNwlPM208jRE2YYMnNt7FaSwKzJ7nKaa3C4HoSP?=
 =?us-ascii?Q?s5AlskS2/+pGau8O0oVby7JEAbwE+EDtaUL/eFP6LNpu+gUd+iOJ44Qi6aSa?=
 =?us-ascii?Q?uhdv7SJ/KHcjlN3K2sB+KO7TTVl8SO3/cwk+TTel5O3xyqNj+91L1/b+HfKN?=
 =?us-ascii?Q?Ntsnu//xhXc8bSi9Osnxdxty8JSIFeLUQPrC5cr6mhAlpXzU63iyRGuPLOdR?=
 =?us-ascii?Q?V1MJ/Xcsfz7mRpsvDvHXLKlPlQS4M7przw/fr8iTY7FH7dML60PQWtbnFpOy?=
 =?us-ascii?Q?zVrbAeAHFuqkMdZtlZxqyoKvGWaKm84uSOla8+kl8O84PD8SgWjOu5OH+BKU?=
 =?us-ascii?Q?QPtT93M/Glvl5QJSBhJwsDDw0Su9MEDgEg/tADEBrUU/ZjOinO3BJP2wX8xH?=
 =?us-ascii?Q?Z3wDjY40cBXItkwC9BHBHUNKMtBJgXO6YlKCjKW7KpgreOwsL+LLXqLL0cD/?=
 =?us-ascii?Q?XOlZKQCz1N6vZjmcfp5cCl64OmY76eYoOcRXJfPvDt4zSENWxAkSMIP8EWCJ?=
 =?us-ascii?Q?zTTjH/f30Tw3kAgUTmNwe+BLyTkPK+NATZTxfP3qYMUeofJ1rCL/zdaDgnhk?=
 =?us-ascii?Q?6xOIsBA66OqoWYkDT4mM8DKFphJaR9XgdaY5NxC8+UdLTQGZmtPF4XMEpwqo?=
 =?us-ascii?Q?wdPaR7C3Bi5syh6Xaq8mOWEjCuAaVkls2039L3IzVLJXYwxeTdOMAqcrm4A9?=
 =?us-ascii?Q?sbdizQhss4nuyUtGwI8Rox6wh5vAlcAIQ4ovbJglgJWvkptmIiNPANHe3p7e?=
 =?us-ascii?Q?8hsOMrDJz59/sekFXW0Z4aQ9lCGtmsaIIMqH2lup8EjEsxlC7LR63LXFjQQT?=
 =?us-ascii?Q?CRLBUWX4kMQyIpbrvf7FsZPTNKDMXceI7Kj3UjN0QzM33Zf/CDokkdMMh5n/?=
 =?us-ascii?Q?+d9b+ZBkBi+bFt7WyDI=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P+bRKEoQ/qZcS+10DpeuMT55ykpfuBmazBjo4gR3m0likbCX2V2jPg0IhqxXnbHgT41223nLBenTLxUAHUCIKjW9jd7tixoNSuJJT7bbikodWHndAqYRsJDw5ocum4C15L5XCVuz2yhjzeRUN/vtQe7OM705iCVhvQtedyOhueDSAcnqTDbI0Y8ElqbPbY2kb+a2te8sqJWLra8qL+OHUz2e5C8dfa9V5qDv031tV4yUuzrdFf3nLkAelgOrcI1mGGlKYVwOvisX2LgQ29xEDFxb1Be8EmIhugFprd+p+vwlwcUI7eJu8HJHfCyNvUS2upqxplbDMtsNuCNzl7wNFsmgijVVUg1zot0z7VtDbGMZKTH4+CVkgLUO+kAN1/jL4UgUyXhSLBj3h/KRo1vC8/VI7sXYXDYMwL5G3OPZ8CJ+XWLlGJkLVowrOYQmkN1I6J896NDGEqbSuVMJs5YXXfAVfG5eLnlNKByOF28pF2dwBv5OwFiV34krBLwjTKAzyVLrx9DrY5fZw7wYGmfjM/aXn3dl35RSU9QgmDVYf+Xts3AQEIT07QzxWsnySSj5xxHps1cgLwOk24jpuXuwQLzC/dCzLVNFyF/8j6Isllh/uDzqRyj5D5owVFa52KYAceVzTMTZSPM/jLlZPjVMlFXvVRavEdbAuQlv3kscOBw=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:55.2421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c773dd-a9f1-41a9-8197-08de0ff7dbe6
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1342
X-BESS-ID: 1760978636-302434-10214-72929-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.83.74
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWluZAVgZQMCnJ2MzUMsk8zc
 QkMdnCIMnUJDUpycTCNCXF0CQ1McVUqTYWAAi3OAlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan16-189.eu-central-1b.ess.aws.cudaops.com]
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

