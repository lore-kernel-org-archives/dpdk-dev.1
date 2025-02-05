Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CD0C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7252A4065E;
	Wed,  5 Feb 2025 11:46:10 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id AFE7440615
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:06 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz7O2o4jFdVmY9v9kkLnu4wroLJEGtTQSLYBJ7fEIvUUyeBxGal0r+aQVkb+dD8dyn+tfQjG083eZxu8A0eUL4SdS1VCkO5Ky7Q2UGO31RCDsqneFRD103ASHc0UxEGkJhYvINNZ1zXDgd8CAV3xkMTTKoxlKpVBI3c90FCbJ3d0ZM4SUxkDkFlzF+Y8KG2iJKHWnx2vg5pllVu97bodoZKvqWruJP9SlVDToQm5pHIp8xGnBnCzk3ROP0LBtra5KcfRL0+rrjOGYAOVt7jaG4Hkv9FbMov2FBBQwqfeipIUBaAu7Ba1U1nEueuFhesLidDkABFuyzsfe52rXwTvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhvdolLTlLGbEu8RzML1bG4XV+ks+dEXFfJdZdzteZQ=;
 b=wFOeU9K8unX6XbROw8IVXPpDZ/rDBUzWrfV+ksp9dIoUXG4oyCNqTSjWKTP3BQLulehncO6L5Ddk1xEW9bXCTeaEFPIQcMGvueratzbI9KbvkQ7doLEAzRKsrA+/N5nxzBF+ZhDbsv8DsbPFFi7uXd2VAOBP45TAjd0w5DT2lX0J115+ujQHu7RCARIcwD426oaUFBY0HnR6+4mLa7pUkdE5PSnayepvltmpQ8RLyuzAbvKMKPm0U5lDCFoAfHaRLfcCk9G5ratNhheUPYpKQ3srF8Cf/s9iebY6l591XDonBAFSkTWrOgQo2nUHwfN1w6wWdrwYyJR0Nru3hggP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhvdolLTlLGbEu8RzML1bG4XV+ks+dEXFfJdZdzteZQ=;
 b=RdKq6F+wY5O4oKzuFUxfflbRFUP5sxzxkxWXUdyrWfIjn6mfhSxy+nNrGJdWbOBQymHMbTI0hZJ94DbXep/r0WrRCLIx/j51ZEdXbVLcZs3dbzF7LcvEw8FGmr1kpjCpk8ysc2i7nSexpTJQFZ4ORHDZ/E9P/LuoAR9/FYzUVQI=
Received: from CWLP265CA0344.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::20)
 by DB9P190MB1243.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:46:04 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::dc) by CWLP265CA0344.outlook.office365.com
 (2603:10a6:401:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 10:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:04
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 09/34] net/ntnic: remove unused code
Date: Wed,  5 Feb 2025 11:45:18 +0100
Message-ID: <20250205104548.1533554-10-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB9P190MB1243:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf8eedc6-ee9e-45eb-253e-08dd45d24a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?39P9NdpjGYwx/wLThW1DCmCcMOYhHVCoLnZwK9+r/eqtxMh6b9t4LBH7oUNk?=
 =?us-ascii?Q?pABtnoAK4D8er0QWDmZMXolXiVOZtBDN/ug4rAOdcu67QItYZmy5gqEjMw0c?=
 =?us-ascii?Q?JIDmGH8DPSf7o5wxBuPoLcaVBSSU+UCXwdni1FQ/zBZQ2W9PFYSo3NK0ZinA?=
 =?us-ascii?Q?lX5kVewD5e9+wKxF1tDyIDLSXkcL5VFFeNJJ7aIXdiH12jF98gE5XHZyDjOK?=
 =?us-ascii?Q?KWo1OW8zV68SPJ1qLN/N+9DohXmNZBy2R4M37sASY2nl5u+VkkVcKlWCigb1?=
 =?us-ascii?Q?cNImUak+Nq8S5Z6OD/omn/NYwah8P3lnWuwRI55FEHwwlx1qQv/1S0Voa4BI?=
 =?us-ascii?Q?RXLXyYY212Ddw+rQETvNUdQnttRo5s8pyKYcBUohY1xnT1K98jvFRMJKOwU/?=
 =?us-ascii?Q?Q0WjxVsQGy98Hh05b/YIPTCn6wf5NJI3Uqb8cIjywtIHO3eUCzPfYKr/+8OW?=
 =?us-ascii?Q?h3z//VF64alkDBotcXSSAGYK2D/ZnlCuhE8Db10Z24wnlcHS/0oSTtkEHQTD?=
 =?us-ascii?Q?22IZftA4/OWUMnSI9imm7hTG3iLai3B4BWUrI2gXAeFO8mdZjfhQqARz9udS?=
 =?us-ascii?Q?M5VzMrGBJoUnS4Nw4N14tT7OY5c42i1gDyjbC75ZbyKBpA4a6Nge9r27k9a0?=
 =?us-ascii?Q?Nb48xnRjWNZ5HjQuHYsiUiBT/b98aKJiP5+qEd4WhUePySdbr7/pqmVHbw9N?=
 =?us-ascii?Q?WbW/FyqJHFvVJNxZ+1xKi5NdKIgF8IPMm3NI8DMKHaDmDkKytJtrvpKDJ17N?=
 =?us-ascii?Q?S3CO0QK1chuDyp2l1cL10iN09pKmRfGWS/8hWhsqqCiCPfEDOSg9aogBNgKG?=
 =?us-ascii?Q?uizxw5pcM4yYM69I4wcmjjVeiA8N+rGTkreudci0X+j01hLW3AJVBldQiBE2?=
 =?us-ascii?Q?gMdnxj+gjEnY0PU/lyVscIv4D3W3/HlkELHZsPoAAQFJtguzeZ0rqHA48jq6?=
 =?us-ascii?Q?XMAuN9LPowPC0DkUDFJZZaykwQzBwimot21cSvDDNd7S7cKnwj3ELNQEOBEL?=
 =?us-ascii?Q?i2RFL8I5Kw7VESKDM6q/WcYZNN3jhCueTHMhqZHy1h5WPWBxUfFHuTf7g+bi?=
 =?us-ascii?Q?ebplNRUiLnNgjazGaPUryya9RnSAgXj9zSkKIYLJjYgc2nYs0M/HTq2mReAr?=
 =?us-ascii?Q?pkbhY2t39tpRamOzlCfCMqu3llYQZndYT3/Yf9GQv6NbeQXmtXLktrVyexrr?=
 =?us-ascii?Q?w5vkiDRFjQ57Omt0SfA5oRS77PeMomGVGWP09oHwb+9Mg8my09VDpZYVPtaT?=
 =?us-ascii?Q?me4Qsvmms+BwJTzkDU5Gwe4nL0WPf2zfNPhUeLmK7/Xm2BWkIGDn4+76GGto?=
 =?us-ascii?Q?a+wXdKq0JlF4ikbUiKtOS29fst94TLis1mIUwmXfk80KHX44LJZuPV3BxdtN?=
 =?us-ascii?Q?AoT+JDDeOYPiGA8/v75kkvitoqmQZuL9dtDIZnSC6NXH7Kli0V/RTGQ/Dy4A?=
 =?us-ascii?Q?QQ3gsGc2ExCV4c3DH8R4pTHmlqzYLdteX0WeMbC81U6SVRbPSQmkM+5bYxHO?=
 =?us-ascii?Q?PtB7a4OIkSUN/94=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lHbZKqfwEe5i2q/LE+fwR5egPGx3s40mGyjIV0Kg8T6O2AB5fd9wuV/xlWqTc0CW1bMJ1hZ2hWbMkkKO4h2mC82c+bxMm08EaKjNgST99Ju94nRq8qS6plAgZ+DBElxCn1UFO7z3Ywk2OJtP1Vd6X5wK+khK1cLbLtxf3Kbfdc7nI2daPkRsJFJur/qE610aHxadpyKnkluabun9oablUxdjn7GzTU6Qi0DI+PQYP1NSlDNnJDm30+9cEJtQMCQqkMEqaWSipgkPScpebCITas67aI/t2iDk4E0LIbQ0Cm32bRAVETR6Fw2K9pkDVxQtCo12/ocbf1PvVcNz2c/ZsQEdlFCjtno6TcXopd/GqpwzI1Ae5wX/vdmYInrzvYLDwXZ0cYNBH7IjViu6XoO1yfX66NIjJYjAypcvVVjsb97/G4bZFEYWFacTcZWW3PD9wETbymdYej2TT3/01VyIU4v89VcwF1lzWQ69pumd/0Fk2m7b+lVFjMJ1FArEns3jC6NNzu5I5wMWG1eFKIg5KJAfCvFQfO0xO4pqNkWLgJ0kjEVObZNtnoKNnIfzX/AwXVFIWe//Dk7FV9zBMXFxObVV9eF37qxBR2NHQDSKQG1JRr+ayoZnpj7rxV7Oh7G+GxgBIC2XGgAJG53C/AX/wg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:04.3395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8eedc6-ee9e-45eb-253e-08dd45d24a17
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1243
X-BESS-ID: 1738752365-306009-7770-598-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGZgZAVgZQMCUpySgtMS0pxc
 g0Jc3IzDzRKNHE0jzN2ALITzZNTVGqjQUAc/ZbXUEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan17-75.eu-central-1b.ess.aws.cudaops.com]
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

Unused code was removed.

CID: 448981 Logically dead code (DEADCODE)

Coverity issue: 448981
Fixes: e02fdb65c2a8 ("net/ntnic: add flow create/destroy")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../flow_api/profile_inline/flow_api_profile_inline.c    | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 1c7d5cac3e..535047d246 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -4268,13 +4268,8 @@ struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev __rte_un
 
 err_exit:
 
-	if (fh) {
-		flow_destroy_locked_profile_inline(dev, fh, NULL);
-		fh = NULL;
-	} else {
-		free(fd);
-		fd = NULL;
-	}
+	free(fd);
+	fd = NULL;
 
 	rte_spinlock_unlock(&dev->ndev->mtx);
 
-- 
2.45.0

