Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D6F532ED
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 08:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3EE84064C;
	Tue, 24 Mar 2026 09:11:11 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by mails.dpdk.org (Postfix) with ESMTP id 4C3774025F;
 Tue, 24 Mar 2026 09:11:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYq687RPgkhGoe6trjWIxePYRoWHWzGsaQVHCA5xNci9bZfbzuQ8yqtGe8BUMYahJAyrksXDNcnhicU7UoTS8+1OLlmx8l6QIrjJNgoX8DSD8qepgXN1go8qRBKHgmXMyLt8zCXx1poez33kn0h0jJIP0wePlbTm4+P8eAYSkNUmCD2NlukYVoLhayh1tCVXu6wfcdOhWQQnGJaBNhasCPY8LJd5eVyhTJ3leKk801rY0uCkxvwYkWmGDia4U7XJ+FIXAPCd9za86osUjz1EKl72PJiE17jdmfMmSwaB8BrOIgk3Rwk2AhH9x2Ediitvu+ffu/UaWT8DDWrOOyYB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnF8r8WoUPGkffhl2KRFLTCxi9muYLxqK2/ugUdxMhw=;
 b=YWFxXkg4KK7pYz4RXsyuR5DM//EnrVQuWWbXp13U/vlBaC/CRFhOE5l4ARcsja8cmONN03mkwW4EQjOdDlaKIyxG9K+TXxqnghLm45QhDkCNPVhVH7I7jVtk//WH0b24IV20rQPAUr7AECn3jByVHiUplVFt3sAaSydb1Yj/0agSkOa1mv8Bcq02rosstHXw2KNyddjNCbtOJ5ZcROxPdEks8rMIjhRRBtDwWEmFN/24WhcNHos10mVgdfcxW5ckGgx5K0UWU16NC0TtEEp13lyYvYk5HhYuiEevPtxAqR8Glc64WcqeR2osHm5T3x+e/oOZcJKS+PCNrVDJG62BqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnF8r8WoUPGkffhl2KRFLTCxi9muYLxqK2/ugUdxMhw=;
 b=h9/cDvAmNnoEgCvgjnFVwcDsfvnb3ickWb5GReVCwi5iE5ZyteXdP9oqvLW3RHPONVyMh2qmb8xfyaxLsDHrtcxzMNcr4orw57IUei3O+HTdDgmHHXu+7USBFVFcW7SCrlf2Zqb3FzV8U8tM+11LU43RzCefgKGJ2OpjByBb5b7/dhX1VkaxSuR3hlXc3q7+Bcij3Dw8zpme68VN+En933JZ1kEpiAFkP2mUPqDLducTMhFpM0MxlNekWFZLzrvQTNLyYsMPOI0oy7RDoNo75MVah3fAEH6pZDqf0zWFrAtnxCKg1EgzR83nEVb9sN2qZKAu1l2Dd9Pg6FOsXwcyBw==
Received: from BL1PR13CA0062.namprd13.prod.outlook.com (2603:10b6:208:2b8::7)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:11:05 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::38) by BL1PR13CA0062.outlook.office365.com
 (2603:10b6:208:2b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 08:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 08:11:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 01:10:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 01:10:50 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 01:10:48 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, <stable@dpdk.org>, Aman Singh
 <aman.deep.singh@intel.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: [PATCH] app/testpmd: fix memory leak in port flow configure
Date: Tue, 24 Mar 2026 10:10:44 +0200
Message-ID: <20260324081045.6022-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 3247765c-2692-4d9a-6fc1-08de897ce57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: SZR+QdoBy7PR5fR9TcbC8yyr0znRKKcMT/WYgjZC2/2T1Ve4zpdZT9LN9beqv2GiDUZQ0W1z0aesgG8WETgalcSbdqomCaQdQxZV+tGARMTXPX08VCXczLIi1mvaQH1eIOKZKUhypFCKU3CexbtIXbX73HD7irSvaaReSrjN3iLKYIoCIeHdqROxXR5gPJdqn/gSDC+4Q6vtX79pGv1U/5how++EOFRvDRb2wV1eYEidcl3VCi29qMHeZn1/g9fVuDVXJfrorcNjUx5BLec5sdvzgCzppMx/OVzx41F0c74+LKWBCS5w5OiGG2UI3ImWt3k5lCoAzJ95inWFhmirsMxfoqbdf0eakUnlmE6r/O4LMvQeGPR6oRi+uK/UHypvNJIe0UsaUS9Ezyxad2GlE1iOnBNLhBwnmNeSQ4oElMWr+NYjQFBmC079Wj1Gr5XYnVmIvnC1+rxO4AGLA5MMfZHj7GCLOO2ps/u3nIAVe0ym21fQYi0L4+HNGKNKmk6tJPuHpBSdfBzSNmp+hvEk8Jpz7q0BKgjBx8rpDeVCYCWgKq5vqlm9bUbw9LMYiKkZNq+jfNP6winunB9+Tw1EXIs7b6qHnUqTx2cT3NGjGUVDw8B+RXYqyF/PWpdiKKZx2A62mNymmPQ+dfGOcUFJI4URFhdWQaWgPaUgVZDTdrLsjmY5tIwHe4eiTi4kUjYWc6w59pTbc6pEUx3/AkAKX29L8X9KOfT7QnO/742EhaEECkDxH9x5qg5xrQ0UtyCn2KTqpyGVg8tJXB6VxyDwAQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZmcNPM8+8MEkWKT8TRLGrdXCch3zDHc8vI9LflwAUlNDAEqGrhnydjtPy5porW4y2BxieBERvhNT5sf8tTsY9++OYGcw1C2+eGvHKwP7mCrtxDTTjbom/EZTOQdxWD9gZEiLByDwLU+BdgkTgjFJZJ0HwIbg+rfw6Ic/Cl6GxVbW2Bdl4+YWKbgOEjQ/2L4TTKEdipAfD6VD4USbEz+2/xizVxAvv82xKzYy7qG0kWsFedQLgUztTpQaWpiPxBC9e2wLE82MZyOduumin4+aPXATbGEdZ/ilTaK7YZuxtxJZfEibufLdIcAIRCPsO61i6qqhZTDXd/Q4Bx1eHGV8L1jzQGalQsmieYshSNpRDn15oV6yQh6bn2tCzWefil1DlXQdOYUDPy7X3LxKMGk5ZTP+MDwV9k0KC9CME+swc5HQu7PIAPQ3PYvG6GcbvnbU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:11:05.0373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3247765c-2692-4d9a-6fc1-08de897ce57a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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

When "flow configure" is issued multiple times on the same port,
port_flow_configure() allocates a new job_list via calloc() without
freeing the previous allocation, leaking it. The old pointer is
simply overwritten.

  testpmd> flow configure 0 queues_number 10 queues_size 256 ...
  testpmd> flow configure 0 queues_number 10 queues_size 256 ...

The patch fixes this by freeing the existing job_list before allocating
the replacement.

Fixes: df503d757b36 ("app/testpmd: fix flow queue job leaks")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-pmd/config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index f9f3c542a6..f0a784bf2f 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1836,6 +1836,7 @@ port_flow_configure(portid_t port_id,
 	port->queue_sz = queue_attr->size;
 	for (std_queue = 0; std_queue < nb_queue; std_queue++)
 		attr_list[std_queue] = queue_attr;
+	free(port->job_list);
 	port->job_list = calloc(nb_queue, sizeof(*port->job_list));
 	if (port->job_list == NULL) {
 		TESTPMD_LOG(ERR, "Failed to allocate memory for operations tracking on port %u\n",
-- 
2.34.1

