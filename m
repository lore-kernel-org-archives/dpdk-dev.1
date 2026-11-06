Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EE606A328
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kNONKOZt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 000AB42D26;
	Fri,  6 Nov 2026 06:51:37 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by mails.dpdk.org (Postfix) with ESMTPS id 0BA1842DA3
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:51:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEJoKiX/u8eFWjp5U5q+ef358E3Pvz/A/YAtXw68FuHZW97YwXqGxp7oZYq+RtBCjwJ9BMVt10Ig+Z1MdSdjv6laLjj/EQ2gQwoH7V5cfwiwf2hflgs9vL8pn80ilhcEw3Me0O9q4hfAd9e2hBHeR44sRQ83GTgUAfce6VpK9FfsXyyWSO/VbVxHXUY5+b0CoTY4uDQ+Yyz4RkPakEsixUA/f4x6FP++5rhgIOYEyJ09XcZiZZsmfU9c0SIY9RqPPbDxD30ZacNSK7wFICmVJUdKspV1x/qjluMTnUf6WLs7wF8SDFEDD32Ntt1bRzHA8IonO+nHT+9rhjChZ5JWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwnRqIbYJxv425iOWAIEJKGZF39GWylhAnsKeKerHfk=;
 b=AH5m6fJE2SEcgTrFYy7r01NddsJ2bjgTQCM0v8nxdqsAv7Sa6w9YSffD/zE530M0akbY6ykkjEK5nkJixm6uDAhbjtNRl0cTedQXLo0f2LafE7J2E1klRLqAv5puTGnZaKmGim2kVRep8L1K82BI60Mmw+EpLG5p2eYyufAaCRYL28NKldzIEAuEs7LmCw9syAZEpm2wmsoW+KnSzn+i4OOBI7Qo5Dplx9QeoOmt2C7VFyJI7CLhDBo/nx2YlpL+8SlNIRfDyRXKEKALi6s4jv4+3x/x4BBpVWg+SGE9Q00SFAYPTMBx9HnzET/EzlOCP8CNdQFnPV44PSsxYzI0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwnRqIbYJxv425iOWAIEJKGZF39GWylhAnsKeKerHfk=;
 b=kNONKOZtXs2NT4HhH6/qolH6k8jse749pDaNiCjxs2RJuPr6dNmIwxdLxzdtisMnE5Om5ybS6chHfkIYQj+z7/gjUcibbvWkZDOdnWMERNltZFIo/qsgRLb2xfvD/Z5dJzaxYOezJ4CJ37Eo9gzYCEQ204bYrbcuf5AVDGOpw+g=
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Fri, 6 Nov 2026 05:51:30 +0000
Received: from CY4PEPF000392DC.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::68) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:51:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DC.mail.protection.outlook.com (10.167.247.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:29 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:26 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v2 11/15] doc: add NTB device info change to ABI section
Date: Fri, 6 Nov 2026 11:20:41 +0530
Message-ID: <20261106055045.720805-12-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DC:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1afc41-09e8-4d64-ba5f-08df3bca012a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|11063799006|261026121527099003|10067099003|261102123227099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: KjjQXzEAjt4FBT8whqi3NT3dZt1V8dHrWja203+iDSMxn184QZ5wXFXWoK+/yl7l5EkdI3XjMrFgDTtlgfZXAz3BpRR392to4FXbmJQnlMHH3sVU5fnHDjCSWn0lWo//h5oUao2dUJ7hj8pFW7KQuuAnkkV7HwGhjXZ/1I3FkkFXkFrlUwMPK1NHucbHaUUCzuhbSFdpCoetg8nO+Np/lgQ5/BctXik7ACOvaxyDQK1bk5i6NJ3jUl2x9ByKv9Zelps9jETKZDdo06HFH5JA69gYs2Zcs0SVfIdRBrgklsB/78KnmkRGxnqViJ6Q1LveRZOyDGpLg8WKk1/sm/ymPWzhgm3Jj0gy1qYCYFEvE9nR/brGxIfOTOP0zizN+Uy2U51mxKSoLBHVMORqsuMJE9/cac3HIhYQpds1gjxE43idY/20piDgXI/+2HE0XAJhLpk767BHn9DDEXlglKskba6uH3CBSeBHeTEEVIIIALrVwutYRV70SIgsTwtq3nf5YUcJioJO7ZtGVKE8M6Wq/vRnB8ufRyZ2jUSuFsbtGzlQSZOQIaCQ1xcVtzJQFzh7J5Vg+d9HR2D1QEyERfHLoBU/UQQxtSGp2D28D5TgO0B0oACwYAgwgIvpSELWVlzQNmujNXg4Dk+jVsLeLP9BdTwjHWFE71D90txWoshcDHCKpituhM+Hbgo2A1WYZy5oTpeT90dXQYMqT7nluz/pkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(261026121527099003)(10067099003)(261102123227099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bbU3y1xKQMnD/F/9RFnK67+wlxNs6sXa6z0kOHPGmIsTM7EL7yi222W393+oc5js3yWiXsWJcun8bOuES6aXSYz3gZmqirouyrA6zlRzp68TUEZ6PokBxEA92VseNkepAIfSJWnQb8I5gp08yUy1V/S5SDVPC32QHp5ahYqeBNG3nrLLhRqHmZ+hZkFZl9HsG26OPJYQLWx+8IMOBaA1OVVlAMJxabimgMLTnwl0iX5o/0yQ25T3rhYkPFtA9lnY2cOCsmpqdkjXpWyPG3CzlUeWeobthaDI3LAED3YBBT/X5wKlwnlKSxIIaE8nReww3iYs1p7gjnV8Hv9WVr7tSpgLJTyzsEVj+5O6g9++89ddAKapeWoXlXLm7ZwCA4Y9KwNrbf5PpZl3G4wvRIVgBoJ4PyONuBFHtkoVSNAvyosUtwHWu7zqk/GS2U8SqgLH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:29.8281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1afc41-09e8-4d64-ba5f-08df3bca012a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
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
index 6c76c60139..23980d5364 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -689,6 +689,8 @@ ABI Changes
 * cryptodev: The struct ``rte_crypto_rsa_op_param``
   was updated to include ``pss_salt``.
 
+* raw/ntb: The ``mw_size_align`` field was removed from ``struct ntb_dev_info``.
+
 
 Known Issues
 ------------
-- 
2.34.1

