Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BF606A32D
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OtDIMIW4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2511E406FF;
	Wed,  4 Nov 2026 12:20:52 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B7CD427A5;
 Wed,  4 Nov 2026 12:20:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW0+TAw17zg8Gp00LTfsffVr+kiMRvn6jJSWukYHdIXcRNhiu0VHw79VsLc+Ted/1/WzgJbyD76f3OFhS3MpQXJrwn3JqVzJAH+ZqWLJHDraQjeMV9Oe3TzYf+4lh9K1BYyWcB6HB2K3OdD1kRuyMpk3dEIW5lS70s24k/ZCYLVfoS58FAFNFif/RIBz/PKdp/b97Cp/R1ax5YbxoRqKNMIKHreXhY4anFCn7U+3OlD1N+YakoHwdM4Oe6aMCMFtjBzTVYBlYAlgE8kb2NLq14plbrC1808pYFBmv7JRuirSkMieA7wWdjR9w7/PE/GuRNqgM2qAi+ODR3sOOebLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmFtnvb6RWsP14DCwTXYGSaWzcJ3/iiMIZY2AYgM4Pg=;
 b=ZDtQbc6wco1U0HxkjYOJPzK2SJYCXxNamiIBD0X/+S9Giy3OU8I7o32JroZCBzFAQWhsG0ldaiSwyIbadTVRChkHfOB67z6pA8xgvCuaU9d5jNLaQgLseDH4/qB1rYbfRPikWDPtrM5egzV5zkWTrxnS2BtdUb65ilfb7zPGCBYxRXdWWk8Ld2m+TNAAzrbQXrNfwL5Br3LBY9qZRqfMTxMp6iUaAmtNl/FmI8Vxx6q4rX/2HvrmLU2I2lpEWo8sqRC86yW+czewldMsO85yzCV3o5boC/6fmn3tm0j34FFP6UTZOrpzs71YDgrNTVFu8ADAvtVCM9Br4ejhfyo9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmFtnvb6RWsP14DCwTXYGSaWzcJ3/iiMIZY2AYgM4Pg=;
 b=OtDIMIW4MzZULfdf8Uu5Lx/naM6hUOrc0wdKHgfvCqJ44UdPDHfl1v9meAdi0FFwd10GSbdm4zde9W+gD1wzuCUAB2AtPn9kmbxUGpRr/ZXTSLxhFM6ma9Xs51WtrAqP2IreaeSAktV6Jruv+AikJEton5OyXILaH6IQMxcj0KI=
Received: from CH0PR03CA0434.namprd03.prod.outlook.com (2603:10b6:610:10e::16)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 11:20:45 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::22) by CH0PR03CA0434.outlook.office365.com
 (2603:10b6:610:10e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:44 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:41 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH 09/13] raw/ntb: fix double free of Rx mbufs on stop
Date: Wed, 4 Nov 2026 16:49:57 +0530
Message-ID: <20261104112001.661769-10-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: d9da32a1-9b90-4109-889b-08df3a65ab39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|261021121427099003;
X-Microsoft-Antispam-Message-Info: yvgMnbaWHNhyZymP1DQ4k5B2kepCnGf9sLIaOXlz/IrB8K41Hz6OnLhwZYW71AHrjgQC2cWCmPoG7UIHy4KVx06+3NQ7M+Ik9xnkscR2Vv2p4ASQ+vf6aZxEOFkdo/4c86zs0uK9epZakiLS6wcogl8+SrDUilAW+49dROfPRkHsbnG99h3NbEJVvY9CJ6A1kdMScRX7yflW7RriyKe4zyfXM3YRw2H4hO3ly/pstUq5x/AgxLX4Cn2NflOlOXjAOyiANfclTeYbXvDnQnZjUfKYIenW8gg3DCOyt7jKak6+pJAVK2QK5yX6tVmUmRua99mFGL85kUSkUbhfmR9y2lwG6fXAkKewkj7xlPS85SQ35jeSFY+J9pdGdbokHtpvv9lymGeYOxfMd4NoI2830DRWha2PEZCqD6KFojdI3mXloFu7xPxchd6k/x6VIxTL56/nf0/uu+KKOKeQT5FP6GcARevl7iUH+/DlPtkqmB1EvBOpef3XpOFjZCRRy2nxxhr5hPCpE7Q/XLky9buraGEnv7PuJxb/K4it8f4aJ0VaCCKesM0munskvYkt+xSgyyJMIz3kJD3A2yisFJ8jUztXHnIEyOEcgirzuQ6a0f9fg+p/+iacQh6ioZTDk9P3vRZqCPcmspVHOBvI7oyLNfTSlt/iIiYH7u5+uYO/r5YGijGtS80Ev+/Pwe1T6i6pZK8ARw4M4uunRLGgx/DlAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SHwP7f7dUOvkqovpnBKHi75cLMVGomiV157VR9h6O1XSoVbzb7SW4ChKWzxDiuVkSV+lft+fnzsb+v0pc82LboNtMJJoNMCxOvGYAaANHlvhqbEktj6Oz+5nt5bLiIQscGUqu0NkprsrqJmXjgPXaGfLtPmH9E/BDLrWBa+Dqm8Przg0WAIQfl28RtMGr1GXzmruWG1Fya+GWIM8zpBOpUIgYOvd0B5TzSoi5+PA8Ckd5d1/LBxMQppWOEpUR0yXepiYBjxBenRD/ImRBc2UZqnjQqxYYBOr0nDYYE+IE6B8dqvWLyTtILsziT92R230B6AmupGeiPORYc/+qUBdq93qLDYjcJrVmAiLXkdw2clssaX4wnT1xcik8Y580xgbxvug1r4D6WVs5WorcwukGHfcvSqvFZW1jYtiZS+bakazYQCr5Z7YbozhrSYgK1CR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:44.8233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9da32a1-9b90-4109-889b-08df3a65ab39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
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

Once an Rx mbuf is handed to the application, its software ring entry
still references it until the slot is refilled. On device stop, all
referenced mbufs are freed, including the one now owned by the
application.

Clear the ring entry when the mbuf is taken.

Fixes: 11b5c7daf019 ("raw/ntb: add enqueue and dequeue functions")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 87a35c796c..d4c2de60bd 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -694,6 +694,7 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 		for (i = 0; i < nb_segs; i++) {
 			rx_item = rxq->rx_used_ring + rxq->last_used;
 			rxm_t = sw_ring[rxq->last_used].mbuf;
+			sw_ring[rxq->last_used].mbuf = NULL;
 			rxm_t->data_len = rx_item->len;
 			rxm_t->data_off = RTE_PKTMBUF_HEADROOM;
 			rxm_t->port = rxq->port_id;
-- 
2.34.1

