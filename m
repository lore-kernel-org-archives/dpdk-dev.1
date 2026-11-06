Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DEC606A330
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ONALTi6E
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B7F742E10;
	Fri,  6 Nov 2026 06:51:33 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 2200242E0B;
 Fri,  6 Nov 2026 06:51:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNanLFhPIyPYHZwp4Pwj9g+/GwZhqa+kqaRuwUQOyG+Gy9jfzmkAfddqp0ykM9K4FfiYYkNb+Xm5aPOV5pscZq5bW9maLFUDGtm34GPWFNHX+4zx+QeasnwfiHL54jWaM35IWUuM9+bV2fCTNHyzcqw50a28Fs9U2kGYuGAt2kqV2Of+crNIy5isuitEbAYNHKjedhBR0pCgl4z6tpX6FL4e2CBna1+7/99CsakqDSQbIBvGX+tP9dmrrni2fPSJNLERWCapcf1V2309av/1pp4ss0cPib1qhvlL0JvGK3Wa5B6uh16GNyCoqyl9nWJrkHB/IMdctPD1I27/CIWujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0htR+K7Zgu+mag1oywbxBNE4guijH53kAFYRBvszOI8=;
 b=SFqcN/Okagp6QhGAGmBcfBpyFMC1Nwue67ZdfMn0StkpMMTNG6EGkgTahLpsYM7YVj/605W0u9rKoBy/Nux0N9kBZnZYtNIcq5mPlAzZkZRukysEqWeW2cVJG4I7nS514eqWBKO2o12gPdeGwNeoRhIye2TVMagXcWyEabg3Y2+/gO8OCBT780+D69Zz2AGbj011+2tEu1e3j8th2qvgDxZ99nXok99Eu7Khry2jf2Rj91EBHSk/amJxClwKAgYEDqVc3WtfIMaB5s1rBzPMDFbzOe7K6jTy40SfEvPu7TDuSb7XXHX+ag70zL4PPVZYK/roXYKYbp8j3ll4och/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0htR+K7Zgu+mag1oywbxBNE4guijH53kAFYRBvszOI8=;
 b=ONALTi6EbtaMdypQWfKFqv7WoLRF/BynMcykrx5W8ZVAn3mA8uKKWddsmNc+DdyhV47mgkqQ1Ina+tbr4iLzRSGxuQZqG2jzR4RujYFO2Os/YCw9b09RP+nfyWGvb/y6iyTCIraSBNLA7+M5txNB0t2ZvfQjunWyxtm6AJA6PC8=
Received: from CYXPR02CA0069.namprd02.prod.outlook.com (2603:10b6:930:cd::14)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:51:24 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::a5) by CYXPR02CA0069.outlook.office365.com
 (2603:10b6:930:cd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:24 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:21 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2 09/15] raw/ntb: fix double free of Rx mbufs on stop
Date: Fri, 6 Nov 2026 11:20:39 +0530
Message-ID: <20261106055045.720805-10-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcbaef3-95b4-45aa-ad1a-08df3bc9fe0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0t9atpS6jgUUra5LqpPG8/S+Oaixt69XdFfXPYTLhWa1KDMF+3aANF5m5QcA5vRgOg+rZF/DmBss83MjTS5qQ1cRLyuuqIa50hvHO7UtZ2HbmlPdTwcC019SRXvggfAE4BmP+0u9yh+xMsrp8m4iRSxeUB2KsaREhkwWMzquUE9J15ZE8ayYgD+AVXtQuTZUlZI/quUD+Lw3iXH8Tq8vZlUmM7wqyisc3uFRdPjQ835Ks000ByMknA8UIL+SM8btm8yo6iZtaBHJvee1Azm4xssQzNVOUaYlp9dbtQmRXlE/sEHbAEot4Rx7E98bPwcWFd8A+arQkGUngcHL+5pyMsLBQWaW5PVJhlJKVzPhQnRkadTbIMQO5yXEAYVX401TpqVm7qx5zAsyJ92KkvRpdgQ6GkKCgny53GsxMSRjUdrg0XpyEh71pXwMqBpcd/7UJFED6SbreCs69bdUGjvw/j5VJLY+CB5fzS5soio+l4AGvDzgVDjIhS/2o3/Hb6Ci4pY+/45cnihaPhOT6UM/siS61P2ntG4RA6TWTLVEYgQAtcPgTi692/I1o0ep/f7gDY7ji/iB7fnQG1oCllAvSfoXDzEa6j8emzWm0cksjIEki0FJ/9Ws6qdRU3IxQFATktuRfI9cdC4kplGDq3x6z1NgwS2Dg4FB3QQE2nyw+DmGQe082U+if82dhZW8NNnn80RqbaKNMK9QJesmBcl5cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1LKmuqlbtVWmzOnVdEf3J8Km37Ipt9dM/uloF/6VHzYRa+g61pD+QUbJHwW9UY1H+YxpnSJM4xlCF2voT7QvYdbicNGWD3NC+e0oZTXGA0jozB7tnpQPAGdrUOZTHnOzurF4TLGIuOJrycZas95aqerlxrh0vSXvy2twgmiwx+gArGU+7nOSTa6qv9uXWsYP6/5NTaG93xrh5yaAWZTW4+dli3rdXwJSodiNDnUkKikjzbdoYZl29ub3vxauSDPptcEkiF5zcN5KA66sC4l5x75PsUJoqrlsb6DFdER65ViUBhj8x96SRUsMOdadS54PfUbFJ1xVdII4CPnJinehF3E+ulLktdgp0l7v2eU1LikZLTvOP8rUDvHYVr/qValYg4TSQD4MOv+85Vduj3nh5CQTwK7t98Zp6X62GRrvBLh6M2qK5KR4lRGuaVhcRu7R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:24.5847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcbaef3-95b4-45aa-ad1a-08df3bc9fe0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
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
index eb562052d8..5b3abcb008 100644
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

