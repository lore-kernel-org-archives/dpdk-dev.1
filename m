Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C0606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XF3guoa6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2AE142E4C;
	Fri,  6 Nov 2026 06:51:38 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by mails.dpdk.org (Postfix) with ESMTPS id C615E40DD2
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:51:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6/yB85xdaXAQei8N7QxvS1QZi3gMTA5GDPL/r8puP+6Rnje/QbSUQnDgSau/r82u/0bHEp8mPu5SHyv0WgN9qr8e3ot6N7l4ysjJOTs1dH92fT1Aig9mMWE3cKJchnq8a67CdqzTBWcl4ldh1v8aSgBv4rgxmXq+b2FNjnZyzh800A602MOqJp5fcYv4x2RgVKWa68W4odKyroKxlmL18ia7p1hkGkXmGcOFl69YDcrfkvL+BZE6zCnDHS4rfM/sfNs2mwlOcbd+67OKnXTj0QQXjzfnpQaBjlACVfqo2DqswMij5jOMeV1GAW01EQJwMJnUrKB9W1gVKXEGlsBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3tUR6g+WoRn/Y0VVlRdDdSgq30uCSwHR4XtKMBV0qg=;
 b=BOVBdIH/jXcxHky6vQMBaNXEv1i/U3HVMf/rOI6zqSUnZqpzIOvFpUZyzcnVfEoV6Z35wi9mcGsHhg4/G+N1Hq1jB1TT2c0pSscQJshPzG+ykAOo//kzM2BYfQaxtd7PKHL4Idn5WFAah1EmneygFBLL3qB9s1pl2wkW3J+ByQ4zv69UCJyi8NFoPqeb0ZWYFsh4auYHk0UrbHU1ODqVGD3c8gp7V+i7rzz3OCSK5DAzh2w3PhWj926eztqqfQUBOSmr2sQUmJBszQ+jzWDTRwKSihTptwMCWP6npZdrvYoRUxjgWVUzJCz2qIV7e9MHMQgNSU0k5sa0hOXsoU9vHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3tUR6g+WoRn/Y0VVlRdDdSgq30uCSwHR4XtKMBV0qg=;
 b=XF3guoa6vlRDCOyWX1BqIsfUlX6ujZBxqcLZi15uH5O7pzsbYEiywVrViudmxi4xJkrASdj3/AV8pu0vtgxbXvKk88ZrfZdXz/B96LoKO8mOP+vbAJ1w/gyKG2jPHLWUOr5y5dWyr1c3K+qCh0bSLotCrYatb0XJgjlwBu4MZhI=
Received: from PH7PR10CA0004.namprd10.prod.outlook.com (2603:10b6:510:23d::22)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 05:51:32 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::58) by PH7PR10CA0004.outlook.office365.com
 (2603:10b6:510:23d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:31 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:29 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v2 12/15] doc: add IOVA requirement for NTB
Date: Fri, 6 Nov 2026 11:20:42 +0530
Message-ID: <20261106055045.720805-13-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 869a3207-caf8-4a25-4304-08df3bca0275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|22082099003|18002099003|56012099006|261022075727099003|261028144727099003|3023799007|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261102123227099003|261021121427099003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: uKCz6VK5KXIDxtGs48WrFoGiiDapJugxDS9eeIPHVck57lzvjUESWi+t8fu4jObEdBI/vicwiZYEyspLH8M/AQs7bhNO/ymZSusFDsis7OuJqkNk5AdrSRXHfuA3Z81VDAG7+vOcN9VLflUjNIRHMjdMqPf1Esvdg+kre/mg7pvWAvffuSVBhxiy51+0C4v73GxF0MN6dWGOHZJlkpvul7p0cetmyOemmP0PRoyOoZHtw65WH8Iv6xSslU8n4OYZHXYJ4HjIc51Xn8tRWFeRULnPDQlX3fVITzt8mE47MsCFDRPIRhfAZFFmk6lo4Af9T5o1bq1ToV4gmU/NfzPkOjAaNEf1J9wM/hls+GYiGieptx9MtoFFKHE7jBKuDNwvTdyquU/eIP0hy7Mb+c542UfNEdR9iLsmgk6fncfUtV+hwmRT/NfgsvWHnFgEoo2ZdXV0g0fy9B9bh5cDdb+c1Id+HBsJndf1paA3/aN31GdcBgR44ve+ZExq7QPeELt/Tv18cNamf0LRHPpjrbApvQ9bs98KxMbNwYPyQfh739BJwdjKjH+9l/yF8kX4bGkXlhL76wMCB4FkKe1RQfltgFBBl17+m/rcFYSBPn9G3iGmcxpk2banIzcZY77nQnQALjzHqMv75Fv5zjsU6hNBpIpYMYoNnFnxZy6lFz4LIZDJfaYG2HpSmv+fcXlwSDB6XS4O0WJgQCTvhVBcbJxsZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(261022075727099003)(261028144727099003)(3023799007)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261102123227099003)(261021121427099003)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9uZYZTB1bIQ348IRBk4w1KRjpbE6ZoXbKWuCVquHj3jf/Ft2NKRzZeXrYrXlBfbL4dNgpOaFyxbSK5xOcqhR03Z9sRoZdgzrRbksYOIa/bOUQgZW+MdzE+4DmdEdXMvhTvSrgpkZLWO8AD964z1ajJ2zsKj0gS+qH6MpFqqwgSe5PvchRfqcf1DrKGEXGHH4i4CVoEO+HM/E7NPddWXydvdJWqiEsCXhElyIbW2Cg7k1WyVGMdimg79kQJLe2hOJo23Cs5ksd9l15kdpc4FniRMxLNXtNfdkKEF1RKujE81OmEIQjtCwEs4Im8ldxxC77FCgwQPJHoxQL+tzKWkaS1XIRRxZ3N+uEBPAm8Gpw4zCTggaFWeVdLS8t3q3guYyEjiJehN3pceniVjjleoHWnfoesavdBhLJMAXSJSN6JQUgReopb/g+gppqcRCyjeq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:31.9676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869a3207-caf8-4a25-4304-08df3bca0275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The memory window memzone is reserved with the alignment required by
the NTB hardware, but this alignment applies to the virtual address.
With IOVA as PA and a memzone larger than the hugepage size, the IOVA
may not be aligned and the device configuration fails.

Document that IOVA as VA mode or large enough hugepages are needed.

Fixes: 5ce50c234ad1 ("raw/ntb: generalize framework for multiple vendors")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 doc/guides/rawdevs/ntb.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
index c4ad2f05c4..8332c27de9 100644
--- a/doc/guides/rawdevs/ntb.rst
+++ b/doc/guides/rawdevs/ntb.rst
@@ -66,6 +66,10 @@ Different NTB hardware imposes different alignment constraints,
 so applications should not assume any particular value:
 reserve each memory window memzone with the alignment returned by ``rte_pmd_ntb_get_mem_align()``
 for that window and length. The ``ntb_fwd`` example shows this usage.
+The memzone alignment applies to its virtual address.
+With IOVA as PA, the IOVA of a memzone larger than the hugepage size
+is not guaranteed to be aligned, and the device configuration fails:
+use IOVA as VA mode, or hugepages at least as large as the memory window.
 
 Device Setup
 ------------
-- 
2.34.1

