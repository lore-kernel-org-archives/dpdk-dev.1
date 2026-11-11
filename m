Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F5D606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kXzW1Ims
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 576F84029E;
	Wed, 11 Nov 2026 08:13:45 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
 by mails.dpdk.org (Postfix) with ESMTPS id 23E814029B
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:13:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApzJJ36drT6SGuvCp3uktSGMH2wVK+vne9ifZzK7DSYVGrK7ArZpCjzPfrVE1S9LnSa9kcDh/J5J4IL4SmBv1jjOBzCInDud8U+RibnMWosIfhUoND6NJlvJyjIjgg+co2fFm+lLa50b5Fn6EUkJKulO3WnJjDCpbxVmGnZsQQmuscbHM2H1skbRbo/zzjZJer9JVJeY+Oy/bFUzr3KxyoitOI06dpRRoXPwl+X0Gg0PY3H2ZkSk7f1qHB32Jm3dkm4WPanA25hXai3Sa2MNsWmwcwnNqXWRD9o3B9Ds88LEVC3c08N9xFzjMtpVZynchRWYm6lA0uEvrtcRNy/Q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0i8eTBoPMRuBaH/GNnTwC5MUWaYfpl1caSRjmNdhl0=;
 b=TtTVUQw7eAIRLlA1U47DbfEI+YnHrh1VpaMN9cNh9R/og4+BmGpXc/PvEFXGh47aKNlLMb1ndnx1dXls8GUsme6miQ8hvX74nLP2C7eEy3E4ohOzoh77BOLBf/yJhrY+tROPfiVr2t5TKnkufKrJJjJFxDoxqA2efAPlF3MiSncdoqQcZL8Hg+B7BKgZHbriBuB+q8WevdZVV8mYs7cCVUUNvOqHywsN0ZmFpSaoTE7lM5QpdQTKGHvYtYp3wbPZurIiXqmgDLYLAsm2HUu8y1WJodTQKizG9vo8hbj/I4q+0GGB74h2l0Xetay+1aVQUEK81BdNtUl0jxbFgQML3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0i8eTBoPMRuBaH/GNnTwC5MUWaYfpl1caSRjmNdhl0=;
 b=kXzW1ImsJHPcUCyI14KngXmtFuhG+LR+HgbNDiIPEUN/MnlR4plxkIa1WYQRhqiq4QbIS+hh4tn7Bdktqs1MDU8DwXKcXcGv5+XWf9QqFQF4yG/wYLLMLZnFtkXpUBVDWbyjQYSy/X9uSww62Amh3xRc1CTd538HpQrYWa90q8E=
Received: from CH0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:610:e7::27)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:07 +0000
Received: from BL2PEPF000352D3.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::6) by CH0PR03CA0232.outlook.office365.com
 (2603:10b6:610:e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D3.mail.protection.outlook.com (10.167.254.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:04 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:08:19 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v3 11/16] doc: add NTB device info change to ABI section
Date: Wed, 11 Nov 2026 12:36:45 +0530
Message-ID: <948c25142a2b84ffd166e7fe0eef377114feedb1.1794377833.git.raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794377833.git.raghavendra.ningoji@amd.com>
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
 <cover.1794377833.git.raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D3:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffec8a1-a30e-430c-1678-08df3fc2f49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|261009223027099003|10067099003|261026121527099003|261021121427099003|261102123227099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O6epx1buoPTIP/f98n1hYQVhdaHsGNTcLRRj88avKcx7nUzpVOtiuM5kGbNLQKXmYLa6EwgUN44hESjt7uz4z5asjSb8K0x0wxbWhWL+0LDpXaIuxKDHj5nHFdCzEEpdGslb+LqsohRNoIXLnm7Ud4kCNNfD9Y4NlRB5yZI/p+rs0F1xbFWZivbZX+MmCmKQOrVCZdgVOEiK+UReVj1c5ugQ2EgGib4XyulUVTP5Dq9sDD2fkYINKtgKd6AxTJxD8r5KnLvjZBjfvuLiZbHi2aAE0qqY7aDoOUEMLvuf91uPX74mBSkoeBdbTrOYicpELYNu29hYk9AefKtn3PmpxXU9bkDJbA+wrKsuzpF7vmrHr9Qwnoe08nwTv5JUX0VYBtZ0TbFMUAZI6F3EjU1kFbYoyoDQjAwcFbbJzZptO9h68IGbBji2GTFoC+JQaWQ6+ZuRWGOPKTFr01MDBy6gZiOzFSyvZc9eAo/myCiJjyGIRe6eSDNoMWdstU5mW51vQWjVm1tzjuAhyvgK12oSwv0W/nJ8drD5eH5yoi1pw9UETtr4yvhaaRCfxGSxLYkKt+xKZYlCHzhss5m3/9ZEPw/RBJzmCK0P8BrjeifSORbYXPvK4Ac5OFs6GTy6sIjIvXuqFsaTWmk5qorkWKEBJKQMBedT/5AJR6CJrvDQu9tBWWrp2JrUQisVsq++fiLMkXH6LwK2MekZxX4GsulRtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(261009223027099003)(10067099003)(261026121527099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ygo3xh8yPTGKwxLDetclK3Ie0TvmFQiR73HqZLKlJSZDgVSozROuSuWsbJiXach1J7uMDCYgBjoUzcSf5PbG/PCBNismHErNik1mg7UTy3Jo93/tM5ll/POgTjfq9crc6GuX1jg/Mg/6iG7dF8NjcDNK3jIXfo7LPOgf3fcC5d3On3JDsBdzha6jJldYn/toYzKfi0tPxnUP6wIChnl2em3C3p4evaIc4GQJYtutFe+nSAqIQY+T7/ebR87BHCO/wS5+7hCRUibxG7Zk/2Z88i0yQnqAlGskEyjIvABvN08VE6GM7RH4SPrflZe1MTfhPejpMt0l0izzlV3EUxL9AO/O2eL3AX34j975w2jXb1ibumjzzw3dFz8fsgQFcQdAcn/KcLqGEijafFGlUqYiMuqTzwHqJXRrmx1ur9iSZzhbSgWhXmd373ZmUYTdNO36
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:06.9622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffec8a1-a30e-430c-1678-08df3fc2f49c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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

Removing the mw_size_align field changed the layout of the installed
struct ntb_dev_info. Mention it in the ABI changes as well.

Fixes: 5ce50c234ad1 ("raw/ntb: generalize framework for multiple vendors")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 doc/guides/rel_notes/release_26_11.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 06133409e1..3d1c8d52fb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -694,6 +694,8 @@ ABI Changes
 * cryptodev: The struct ``rte_crypto_rsa_op_param``
   was updated to include ``pss_salt``.
 
+* raw/ntb: The ``mw_size_align`` field was removed from ``struct ntb_dev_info``.
+
 
 Known Issues
 ------------
-- 
2.34.1

