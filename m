Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB717606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sxYZ6bG7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC00042E63;
	Fri,  6 Nov 2026 06:51:42 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 67A2242D7D;
 Fri,  6 Nov 2026 06:51:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G956lpWY9BD4p6tPbRxH7mYRTvawrvPZxn8zj/z/Wqst/5MVVGCFxmSRU275aYjGxusdcgNJU2MTn8i8jcNHVpPux5u21c1TsSDzFep6s1uUzmKA3jWjGrx+qJFcb/rV7DEFvrhueZoD9L3jvyJYpPlYZhGC+tE3s7hFCOoEW1T46PiGWhyPX2uaMsJSDJ21wL0/zwh5ciz934xt/3pCg7jqWwEsXNK8EGW3Z4th64nn0yXF4CkUJXz7Ei+XcI4CxxZ5Putml8+El3mTpJLjJiW8D5ihgIZILZ8PErHiUYMF+MaY1ORT/cpmGwnVoC3HIUokjKFLzM/023wLZL/HCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIpi7ecqbO7vu6UrGQ1bs83khK59017WuRTn2WZsEgk=;
 b=V6nyVtP2hNqiUhKAiy859s0GdUhJGi1KQZyAgjj2ItjFj4p9N3aNlY0OK035XDSaENnhcb2ieDwT2pOJK/BhgyzOd7npPl+QdrT/CQ1NMZw7URlllSfTEj4V+jM52delHFcCpfOd04kQ2bpqHi/r0NrsvbXyeati9xDrR34odV8TkOyODuG9FgKZDX1BM6cit2VvCy4n5GVr6bSLMJ509McFfGQF6vJm1pDL8Ol+JZfgeoGkVSQ8kD7Eed4XyBJVgTHf/doJWsxsNUQCWIW38yEovH2PM0a3bNgpv3sncDGr6iRVfqQgfoXxRpAV9PQCN+hdDUJY4C7y5YwGm4ftqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIpi7ecqbO7vu6UrGQ1bs83khK59017WuRTn2WZsEgk=;
 b=sxYZ6bG7uz15H/Ozi4rN5pB5e02LbxI8SsaqiivBnFklcvv0Qkh4Genpsf6Rs5ygCFypr5OTka4SWJYJz3Z8oc3iJSE2Je3zh5A/nMU5qD6sD4cuzQvEslp0Gs6HZwNr6eqOKoT9NGLwWsl9dRZlt9SQ4kuGoBS5CHECsN9UEXo=
Received: from PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::15)
 by SA1PR12MB999083.namprd12.prod.outlook.com (2603:10b6:806:49e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:51:37 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::26) by PH5P220CA0005.outlook.office365.com
 (2603:10b6:510:34a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:37 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:34 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2 14/15] raw/ntb: fix peer device status access
Date: Fri, 6 Nov 2026 11:20:44 +0530
Message-ID: <20261106055045.720805-15-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|SA1PR12MB999083:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a18764f-8731-4959-6a8e-08df3bca0580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|261026121527099003|261022105027099003|261102123227099003|261021123027099003|261021121427099003|261028144727099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: vrMgtF0/IYVT4yEfkxVmw0IB5f89Mmi/5yAuzxUqL8BUGs65pXYaEX20INar2zYlTlHd21n7y52uKOoSwwegnBC2EFqvv8gJ39kV9uc/5Pk7z9Atx22+31CjfY7kNULo6gFbsMHuX6zhbFBjGsn78apQnJayrPTTcWI/u5HM8MVlvi8bsE0JH+MlOzAQ4mZPMhUoBJR5EA0yOLPlTFkjpHacbGBM3iGTaMtvuPuC1b0hCz7dqPuBhrLcp5YrHfLQLs8wEaUil/FRRZ3gSAkPBPqgLhzhK0KL6rX6L5Q6NrcumPydJmdibRsCwhXjRU6K3cuw6EZ8VL9iayQ9cecZaP0DWTlrEfy8Yyct+67qMdEMqhxnWraxMQ5fcA2C7Z6l3O7O6Q2xQ2pHjdPk4oX5E66quUhIwv3lcqHrEluMTNfNngDKhf812ZUuINle6zKsLoYk6B09orGFdEe/VaRgTsSmO+23wczCU2olKfmKBmsRWPRvdLTr286mea5ALjw04DX0Dq+Y9b10xUqIwWqoVpnLil9o8hl25G5vpWZD3Udxd2Pe+uuh7QGQEtKdmpjcyO5SVWZNAy6frEyw8dcrvMZ4wqu0VFALjpZvLrpt3PWhtzVa75y65eqnr4nd1tXk+TlyejgAe2/2lfpFJBzkx+CnTIY0Ci3rNV96WktwyZUPHI7SlVaI+/+GOu+fd0YJDnkuQhnQ3HA5wECrp/WpWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261022105027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ts6HYvet7GAhJX9zBJ/URtj5gLrV2mtWIpYMa5oNeM3N80DepiPoMtBQybx/dbFy8Du9kC8vW7rJgJTYH1p0cZYtkW0pKD2E3sjL6LfUXllK4syJtD0P5poswhyt3PWrpHUkteQHyIze8N+nehYOhGfbJAXZVbSrw2mW+0ywN3bicnyJrCA+NiW5+DSqhDXe8/FUXTkWt772Si69RUq+QEctnbOjwOXKY9n/MhxxYs+qMmYgGv6zLSdcxYZ8JrZqVsTKWIxZxczo2kdYI2nIcr24RXXZksgPuqDAikKIBKCy4LYr1TlKm2SV9/wPkAk+Talr3dEoup4+R5DfdRqcBWH/RGufonzXVwu7f0fSsR4Vj8T0l4UEAOv0jz9tzdZDAbTIdmc1L1axUDdkA+T1KyUcOPCc83rN03Km2Rj2DphtUkMHP+LX4P2EWhrWSS0E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:37.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a18764f-8731-4959-6a8e-08df3bca0580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999083
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

The peer device status is written by the interrupt thread when the
peer doorbells are handled, and read by the control and data paths;
in particular, device stop polls it while waiting for the peer to
acknowledge. Plain accesses do not guarantee that this update is seen,
the stop loop only works because the delay call is opaque to the
compiler.

Use atomic accesses with release/acquire ordering.

Fixes: 62012a76811e ("raw/ntb: add handshake process")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 28 +++++++++++++++++-----------
 drivers/raw/ntb/ntb.h |  5 ++++-
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 5b3abcb008..86405ad57a 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -48,6 +48,12 @@ static struct rte_rawdev_xstats_name ntb_xstats_names[] = {
 };
 #define NTB_XSTATS_NUM RTE_DIM(ntb_xstats_names)
 
+static inline bool
+ntb_peer_dev_is_up(struct ntb_hw *hw)
+{
+	return rte_atomic_load_explicit(&hw->peer_dev_up, rte_memory_order_acquire) != 0;
+}
+
 static void
 ntb_dev_intr_handler(void *param)
 {
@@ -69,14 +75,14 @@ ntb_dev_intr_handler(void *param)
 		 * Peer dev is already up. All mw settings are already done.
 		 * Skip them.
 		 */
-		if (hw->peer_dev_up)
+		if (ntb_peer_dev_is_up(hw))
 			return;
 
 		/* Check that the peer memory-window layout matches local. */
 		if ((*hw->ntb_ops->peer_mw_validate)(dev) < 0)
 			return;
 
-		hw->peer_dev_up = 1;
+		rte_atomic_store_explicit(&hw->peer_dev_up, 1, rte_memory_order_release);
 
 		/**
 		 * Handshake with peer. Scratchpad and translation programming
@@ -104,7 +110,7 @@ ntb_dev_intr_handler(void *param)
 		/* Peer device will be down, So clean local side too. */
 		(*hw->ntb_ops->link_cleanup)(dev);
 
-		hw->peer_dev_up = 0;
+		rte_atomic_store_explicit(&hw->peer_dev_up, 0, rte_memory_order_release);
 		/* Response peer's dev_stop request. */
 		(*hw->ntb_ops->peer_db_set)(dev, 2);
 		return;
@@ -114,7 +120,7 @@ ntb_dev_intr_handler(void *param)
 		NTB_LOG(INFO, "DB2: Peer device agrees dev to be down.");
 		/* Clear received doorbell. */
 		(*hw->ntb_ops->db_clear)(dev, (1 << 2));
-		hw->peer_dev_up = 0;
+		rte_atomic_store_explicit(&hw->peer_dev_up, 0, rte_memory_order_release);
 		return;
 	}
 
@@ -549,7 +555,7 @@ ntb_enqueue_bufs(struct rte_rawdev *dev,
 	void *buf_addr;
 	int i;
 
-	if (unlikely(dev->started == 0 || hw->peer_dev_up == 0)) {
+	if (unlikely(dev->started == 0 || !ntb_peer_dev_is_up(hw))) {
 		NTB_LOG(DEBUG, "Link is not up.");
 		return nb_tx;
 	}
@@ -660,7 +666,7 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 	uint16_t off, last_avail, used_cnt, used_nb, nb_segs;
 	int i;
 
-	if (unlikely(dev->started == 0 || hw->peer_dev_up == 0)) {
+	if (unlikely(dev->started == 0 || !ntb_peer_dev_is_up(hw))) {
 		NTB_LOG(DEBUG, "Link is not up");
 		return nb_rx;
 	}
@@ -853,7 +859,7 @@ ntb_dev_start(struct rte_rawdev *dev)
 	uint32_t i;
 	int ret;
 
-	if (!hw->link_status || !hw->peer_dev_up)
+	if (!hw->link_status || !ntb_peer_dev_is_up(hw))
 		return -EINVAL;
 
 	/* Set total stats. */
@@ -907,7 +913,7 @@ ntb_dev_stop(struct rte_rawdev *dev)
 	uint32_t time_out;
 	int status, i;
 
-	if (!hw->peer_dev_up)
+	if (!ntb_peer_dev_is_up(hw))
 		goto clean;
 
 	(*hw->ntb_ops->link_cleanup)(dev);
@@ -926,7 +932,7 @@ ntb_dev_stop(struct rte_rawdev *dev)
 	time_out = 1000000;
 
 	/* Wait for cleanup work down before db mask clear. */
-	while (hw->peer_dev_up && time_out) {
+	while (ntb_peer_dev_is_up(hw) && time_out) {
 		time_out -= 10;
 		rte_delay_us(10);
 	}
@@ -1061,7 +1067,7 @@ ntb_attr_get(struct rte_rawdev *dev, const char *attr_name,
 
 	if (!strncmp(attr_name, NTB_LINK_STATUS_NAME, NTB_ATTR_NAME_LEN)) {
 		/* hw->link_status only indicates hw link status. */
-		*attr_value = hw->link_status && hw->peer_dev_up;
+		*attr_value = hw->link_status && ntb_peer_dev_is_up(hw);
 		NTB_LOG(DEBUG, "Attribute (%s) Value (%" PRIu64 ")",
 			attr_name, *attr_value);
 		return 0;
@@ -1325,7 +1331,7 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	int ret, i;
 
 	hw->pci_dev = pci_dev;
-	hw->peer_dev_up = 0;
+	rte_atomic_store_explicit(&hw->peer_dev_up, 0, rte_memory_order_release);
 	hw->link_status = NTB_LINK_DOWN;
 	hw->link_speed = NTB_SPEED_NONE;
 	hw->link_width = NTB_WIDTH_NONE;
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index f9f5bceede..6dce038e0b 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -7,6 +7,8 @@
 
 #include <stdbool.h>
 
+#include <rte_stdatomic.h>
+
 extern int ntb_logtype;
 #define RTE_LOGTYPE_NTB ntb_logtype
 
@@ -223,7 +225,8 @@ struct ntb_hw {
 	struct rte_intr_handle **db_intr_handles;
 	uint16_t nb_db_intr_handles;
 
-	uint8_t peer_dev_up;
+	/* Written by the interrupt thread, read by control and data paths. */
+	RTE_ATOMIC(uint8_t) peer_dev_up;
 	uint64_t mw_size[NTB_MAX_MW];
 	/* remote mem base addr */
 	uint64_t *peer_mw_base;
-- 
2.34.1

