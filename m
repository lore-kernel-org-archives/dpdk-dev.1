Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46205C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBA52402EB;
	Wed,  5 Feb 2025 11:46:03 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 2ED53402E4
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:01 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2042.outbound.protection.outlook.com [104.47.11.42]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:45:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEZjO904zD3DEWOvjgx0qNAACT6ntFHuuBekM4VmCtNtk2fyzfbi1AqvtUUEM0TnLnKE6u0XPANVfTUkpGuk2ttWnfXvZcmojx+zgX8QpIPR+/AMu6D5W7QnXNJc9XqjYpeMomY3CyVovkbwsN+DmegYzS9ChGEmjyRLZNQ+O1EvOLiHK6NSMaZC9V1RPhpBdIe3INIJOzruf6uHjyLj3Fss9SvvVKd2+MoHIAKhZMZMKtaYrzhlv4hVYn0Gxd7sFDg+SNY25f/ZLsWxsxz5BQ+yz/C6C+dNAXsFhPjqDA/OWodZQm+LVNxSEJF3j95vMCBNKRNXARc0sBYVqq1pOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6pqbPqev+nEobRP2hbDefDxOlHnesnAcEPwSULv6kw=;
 b=oSRSqGcbqJk49TynV1QlC0ozgrO4ULD3N9/o7TmbtLePjR+Umu/AWIrYjgg6k8b77y+T3regyWEzivZIJCb7glBRB3DKWN9jVsyyyUa+gH/zBXSqdL8ScNFkiDRzcmPyWDQTKCkjxIOCf2eYVnchgUa6QqqRRtgN36r2rcgSjmLZw0Ab0PIOVyKOSV2NMZ4tFhpJTE21YvRRM+62m+Sj9M7ION+jne+pzOocAgXue48aAN3ZH4ncGRsbzyT3fWM+pkz1TPph31ecpeHzduLaVfyemB2HUVvLmIUyldCL5cJtg86oHIV3ZO4fisZJeycOWJbFMsUzoPBsa1UlXMhrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6pqbPqev+nEobRP2hbDefDxOlHnesnAcEPwSULv6kw=;
 b=ZIoXiRnUp2jj6IXQGx8gtgVvBqM2bueCDp7ZdvAIMIX/b5Ms9DKrEtzWlp193w2y7ifnQzCvBTajjUx3uvL6/xdxzulLEHnFfUqVD9ghcGI7PhbnGh5RyqN3pYOaoN3cETMjAJVoOn6om1qFblkBdCQotoEcoa5g3BjAPCmAs0Y=
Received: from CWLP265CA0347.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::23)
 by DU4P190MB2198.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:56f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:45:57 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::6) by CWLP265CA0347.outlook.office365.com
 (2603:10a6:401:5a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 10:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:45:55
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 02/34] net/ntnic: add thread check return code
Date: Wed,  5 Feb 2025 11:45:11 +0100
Message-ID: <20250205104548.1533554-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DU4P190MB2198:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5f41c95f-1a14-4d2e-6162-08dd45d24501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aRVnaLfk0zKNE2PSad4uoHG+hFF/9yw7fb0+fmeaxhal2dXCkmhhtyhkTJzy?=
 =?us-ascii?Q?XZcTOm/aCJw+Rz0+2b/GRsIAd0Sjr5W4BUJG4UJtUWtKMbYtAeTUzrQ8mZdT?=
 =?us-ascii?Q?JTgPNZEjRBKfKwksuZm+eBiVI17sl6QaQnYlHjNupySoz09EArcutVdOc27h?=
 =?us-ascii?Q?/cxvgLK+S4ysp4hyu4l+RVhVl6u+neelnmZcrnTPw1e7V5SpFZ+SFJi4oQW0?=
 =?us-ascii?Q?vezoogksy8Jm/BAnkD5RsipMuXhkKNOJq2uLTl/m3Ew7D5edM3np64W6HdTE?=
 =?us-ascii?Q?EDGNtLWcZVnf1EmMp3O46DYfLS1pRrOIhDhQoEfO/BjxtjGmjazwVYirkTdb?=
 =?us-ascii?Q?a2fh5I3sWKS6brpRFw0LX3NHsqXIP7hXmPwr7VyvpC4ehCNF4z3/mn+cot/I?=
 =?us-ascii?Q?E67Dnu/2kPH1qlmZ2neW/iMNA1fNcdpnqisnwRmxj1HpohleLKsmukjPREam?=
 =?us-ascii?Q?UVzABk56ZfGmHjJEhCJcL9IoemlsrbM7OnN+fu3EyzStJY2d2SclfVNlAhzW?=
 =?us-ascii?Q?Dvg99MDeaobFfC0kjh7Jd8I9UhSr9boCVlA/RylZNudGtd3S+PalINBmji/V?=
 =?us-ascii?Q?IfyFYnkpqhFpk9HW4E34nNOOOcbh+5QjxF56OtuqxZozlq9slNjsVCH9nvOZ?=
 =?us-ascii?Q?+DwA0i6ERpLHe05greTlNlZHDPkx0FYvcWbbrlhIeWtE7UFJHZgpB1hXhcUr?=
 =?us-ascii?Q?SFEwZOx5sv2tdbw81H3tjy8SDS4Qt0gzTrR/qpt/JzmW3k35VhtLyPC1mm2y?=
 =?us-ascii?Q?/hYt2zjj/2Zy+srWNKleZh4C/jszx2uqrud8u8S0gHgKNAWjDxDpSf9JDXzP?=
 =?us-ascii?Q?fjxS/8d84opG5/oCInhOW9HJ3kq83hOoN9/dSvRPVxj7pCIY+fBS345go0Ku?=
 =?us-ascii?Q?jC2yVTZ3xhkN6WGyr4jU37+n32I423kZ3JwJQyp9MJDmEgeV5qCWryX8y1fu?=
 =?us-ascii?Q?P4jgHodMmn09qa2jefNKUvh6ixuwuJyz6D6p3lwZfoc93ACX9AFcrqLJ08fQ?=
 =?us-ascii?Q?XIo9cJnicq6cGFcKZyJbHgdAXG6tK72hCS4dlUrIe01Dhv825SivHtF6EsLg?=
 =?us-ascii?Q?y3e30rd/HN/5kxBUxX/d+Ul3AlqUQ0J7leMIfbEkns4HEKLDjPgcRCNyafW2?=
 =?us-ascii?Q?TSePKB2NNWTCsMg5drPBgqXQh/oQ1S4TAXMOvqXxH1KsyQVuYdSQAOcenuRs?=
 =?us-ascii?Q?QEFVjtg6KqrEziNzeNQV16zi4Beg0UqImCqMVnWU0mpygcTB0k5G0ILsh+Tq?=
 =?us-ascii?Q?7+aXbysdDuge3lVkWVZKMKiQl7h76Kg6mtPIYJ3uj88lx3y/BGeNBc2pIo+I?=
 =?us-ascii?Q?wAZk7tC3uB7fZ4LhkQQm9A8bQ3QlZwjOH9M5tMvbR6pYVuuo9stjmjMN0p/F?=
 =?us-ascii?Q?0pRzdmNyxw8VHCuwUEcfVjRMDFkykKvMQTVxlJAMtR6WVWtsfA/HrIt9jzPZ?=
 =?us-ascii?Q?xWDbl8OpaOgEfz+C+qeQUy5pDmNEOTM0F86Xb/p5ZGM1MNtuLb5XIijMULzV?=
 =?us-ascii?Q?RbGK4jIjDVbYuJg=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7t524CIuJ07oTcn+ynr4NOh0sallN3Uab4DiWpNXbzLSLI2c4+jQv0q9tS0SK1SRGR6IL2Y53U8HpigbxHUr3Ki3K1jArWc41j1c2F6CxdwCFcLpFP+5r6fK6/C9yAuYYomZZthRr3/qA0kKwBcDJHcotj4XnRvNTeOL3suQ4LCA+pG1LNdtoqThUDBAiFl116iGClQUDCBVKyIoc4auTrqGp6Y+ek3QvZuNOsQgTClIQk4DBCiOigrSZq3mpCTQWrzhgtIgeCVLI7qV18yawhkIafk/Gv6Nfm3SbkovTD1M/WtAiRHCpPyv0ii2TsEPlcTB99htvIvIEySWUQfawm6adBy1Dv9JLpA8ZuK/oTybA5+OsczjcFW7gcVxsTgeQYAOn+sJjnp4P7B1kTEjZelxJwyR4P85vFo6cf75eUgXGN+7w/KC19aMd7Pg8Fb3t6pWH/SI9DEReLhwMJaa5/XAs7nADgiG2enf+GgjR7UA4kwvqTFNzQQCbVLoZfaZSAi3ePXRd5/ivGNaO7oBLrpY1BXCMlVhB/aO50e+jAMFRfjI77oF7rToWbsFJbtarEHGmE78LUidJyqj3iqVSN0Ge699ibAU1gquDOyeNLro4M4akmEDjm9AGYRjsMbnxxLAyHZ91PD1TMJH12GjVQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:45:55.8083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f41c95f-1a14-4d2e-6162-08dd45d24501
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P190MB2198
X-BESS-ID: 1738752359-311016-7902-606-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.11.42
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGxoZAVgZQMNHUwswgNTnJ0i
 gtzTLF2DjZJM3AJDklyTjJzCLNPClRqTYWAC9VHltBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan21-38.eu-central-1b.ess.aws.cudaops.com]
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

CI found couple coverity problems which were fixed in this commit.

CID: 448965 Error handling issues (CHECKED_RETURN).

Thread return code check was added.

Coverity issue: 448965
Fixes: a1ba8c473f5c ("net/ntnic: add statistics poll")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 2a2643a106..620d023a71 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2516,8 +2516,11 @@ static int init_shutdown(void)
 	NT_LOG(DBG, NTNIC, "Starting shutdown handler");
 	kill_pmd = 0;
 	previous_handler = signal(SIGINT, signal_handler_func_int);
-	THREAD_CREATE(&shutdown_tid, shutdown_thread, NULL);
-
+	int ret = THREAD_CREATE(&shutdown_tid, shutdown_thread, NULL);
+	if (ret != 0) {
+		NT_LOG(ERR, NTNIC, "Failed to create shutdown thread, error code: %d", ret);
+		return -1;
+	}
 	/*
 	 * 1 time calculation of 1 sec stat update rtc cycles to prevent stat poll
 	 * flooding by OVS from multiple virtual port threads - no need to be precise
-- 
2.45.0

