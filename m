Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD80C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EBD8410FD;
	Tue,  8 Sep 2026 18:27:48 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 43C4C40EE1;
 Tue,  8 Sep 2026 18:27:46 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022124.outbound.protection.outlook.com
 [52.101.66.124]) by mx-outbound8-146.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 08 Sep 2026 16:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt4BsAO7MYxa5xrgKkut+Oi+Il8FFmossPwqY19YX809GPSW8r68BWnBDLC/mzwtyyH32QlqWBSaomFj2etZDm9J0dEwWd3Tn2d1mVF1wCcnIpiH3mM3qw3gu58ex7OUFrkzrtN1VgY5XCm0BK6kv4mR7NfVCBK/jhbM/jvuw94Mp0HCe8gmlRe+WVEx7Pbu5vV7ZIN/H7XNz66JdINJ+2RbanKnD98phkzKzevRIPo+E4kqLhhMP3J0A9u1qI5esdT8ctcss4SsbpVZkVW519BNAa1eL6yERbhlUeHwGTfXYYgLj6RtL7FnTwhX7yidGiXpwuoMlv2MN8i2SZlWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us5gA4P8njAymcWB5/D+s1IdmM8dvnrnhnuTrj40Gps=;
 b=XftNjq0lxvES66cxU6BXJBqK3MDEYkpmsuuMWkGpt0ZwfHSqJVMd0dRl9HwqF00Zmdm9IU6l520PMoSGv99i1h0ym9QYLB06249t+v9Ja5uBpdxa8zNimnfIJcFc3LaHWw4EPp5vGlA1zh0iBjAcVn1eZ/Xdh7vQ3k7bir5po/EI31ZH5t0ngi6/ccAlg6AkNJVOO/DtDqpAr5BW8n3UD+yg9re30qsqNEnfaaNwlACf7Vr0uSnKD/zYeT37uvsrTLftVVLKthslb5GpZwtL6NwrLWksvc4qowREGcyLSDlFnMdjdh8oNNNkT8eY8x4uNamzN7bb/v9rAsJltueb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=networkplumber.org smtp.mailfrom=napatech.com; 
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us5gA4P8njAymcWB5/D+s1IdmM8dvnrnhnuTrj40Gps=;
 b=hmAfcSCeSXgw6yyjN6qbpbR5I//SXq7XXEdDguQu1Nc/dBb+EHZLyc2OQ9mYmRD5pfkyrJCpxYeHPjYM7THntkvyba5wz5hWFjsES/PwVDRWY65j3+Onr+Ml5F8jCKJQV+h9EJ/LJKT5fUlVaYc52NxljSIrjVvv/kIuyRkmFao=
Received: from DU6P191CA0055.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::26)
 by AMBP190MB2480.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:6a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 16:27:38 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::5e) by DU6P191CA0055.outlook.office365.com
 (2603:10a6:10:53e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 16:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server id 15.21.382.8 via Frontend Transport; Tue, 8 Sep 2026 16:27:38
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: stephen@networkplumber.org,
	mko-plv@napatech.com,
	ckm@napatech.com
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: [PATCH v1 3/3] net/ntnic: fix virt queue data in BSS
Date: Tue,  8 Sep 2026 18:27:24 +0200
Message-ID: <20260908162724.463767-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260908162724.463767-1-sil-plv@napatech.com>
References: <20260908162724.463767-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|AMBP190MB2480:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b24d2904-8aa7-4dd6-eeba-08df0dc6193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WrFVEzyF3BOZU2LAZGVEsttlTYjsCkFFPbPzNE4pN2wy2zxfpOkpEuEQn3NJiNJnqKA1sMiTX3oUgfMD+24Qt7rma5BWBndsp1N2bmGKlZN6lXrnKqO4Ygt9tCPK4xc3KjTA5dhwLIFa6ZQnTfrYZqa9gnJe97f0xfLTO5349OT/s7L3HZ6jkizSRR9L0V/YpUHkXWDG39RHTgpqBgKH+NlMyov7P3nr3OqUEny1M36J3UHU2kE4Q2Q3uQ7aMeMoxPjS8hwzPVTZUvcftf/qBHKzNvPD5vIV0gS7w1UcVTAoQbTH11oQth/btvWLxa/5TRyZCe48E2zxRITgpj+a32ovq80kk7aJZ6kr7R6q8w6PFYV2WUhhJajGH2PLUKHK2JxA+iMe7RdZcKjOWPBeNR9RmQDdfjiZcdc6A7QClT7uVKYqg1dDmwTsdmEFN/v62CNGh6CK0qpyXlfnBZnoymMw083Cd+IOgGa/dxhh37LVqxUoqkM344AM7wJ14DPIpm1EsxCr6aUcBsEJDx8emWQMRBYWJ6KismoTz4cocnZihAMtLNCD+Han6IEIgQX9BlAYPhGZdKB1Vev8PMxQPoJs3CTB2C727sOgtFNDB5IRXItscIITTTzPpmc49LmILuXAKdSGLAQUlJsjQusChMA9CMvKGunQiUM6ON7y+QJ+pwvpk8FCBQcCwLHn4oZFoqrGa6cBLtX8eD+5Tkgs2A==
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ATESUU6l1ae++tyPkS+gbhrZdLwnwj5PW1PshRxiK7Iv3Uw5RxiKJF17IX3k6pq3qVZTprJCkKEBR1LwPNZ+f+K6R4g3EBmuUEKwd1S03Ahx+hxpQ9akM+8lMs3m2SkUKMnlZi+pGE6zSQTnabFyhFsjC4AsHC4EzdAulwx25F/mL7ZqovDkVURAQQUhwxZM+8iNODnrIRY4Tc5YdTG6x9D7j501oLUN2GZy3E84xVkx872nY2PNtPaTKYGGPaNoQhPW1ucNZ8xTOTEa5LetCeX3oAwHvgjA/m2uHyLKIDK4YAtw6UtOTOeP/WTSK/W6ihEwOJCr/8NT8lO7R3iTpjzRwiezx6RKJPTaPr9f2f0/msxA1vvEBaONJKA8kq4V3g6jfYft1a6p5mejAf9h8eyDhi1OObUkIvp4Lll3rPKXmd3ZC68dZUntF8uy5opZ
X-Exchange-RoutingPolicyChecked: j++T3SucCzFbd3nIv4GGb9ADLPkf/xNCMZ0UiURTRekD4BC/CSbi1l1aSFU61ffTUIrSomD4Y1+YJnXnPkzNY9El3uUzj8Gla4NhMC102GjVr45nlXRCwmvmEfbDabIUUVeY+Xs2+LQUI/ZXJ8i1izdnbrmB5cEYg5dnr76RXNUNjcNjvjBVIelTtjOp9rb4as3f9TqwIqWX2ZSm7fbLb/DSJoCVjqPPKYvEiKg5VhN4g6N6MqTcRnwgoDN/8vhikzHXsqnUjIj7iN3+se+afzcCq4i4qujff8zV66rVeG6UkHCG/ll0AZ4+iLfYtka2s7jEE/c7aTq4XRkPDMbrMg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eVox7LSOQA0SatreOXrHBZrngVwSmEoId1njjbXAbGjsY5ZIHPXXRM5SMg6gaJ3LXFjyz1+1YeK4k06JcicDTIHBuznvQVg9nBsN0EReCUDAtnv3nDwMrSbfWzGZAf95l9cBK9rZF2vF7mwOJwDAjBeONvru6tFnMzeLTXFLje9Fp9NiU9gA4tVd9zLt9kRxtRh3WOK/+J0P6a/EvSUn0K3n8MTt7/gJss6Q1ttADuuURjuIR9H0ssHwjxVRKQFAixcd8k5d+aj9/JTrr9qxOWrPI8uUAKq/LsyNt8urrJTgNLmCloUsh/4vzMN9H2FUkvlQcKWt6N3AwVgnRP9LU5tPMKE40WBHTaNoRZSUVBCz2nneCZmEqW6JQo2VaCO2KibnMWVfebE2KbSXhxL+/o42Ksx+nCetwo6Dk7JUghPPHG3hkqV4ufzFDzPmonaUTFwEgNQbzSMhQPqd1jhhfQXtVhhdJSvQfTiYbVqOHSZtjBc+VSDgfWEE6NluqpGLjM4Ml3K0fdXc5OlkLUkRk2f95rrtx/vb7HsdiOdbkB2PNullQP+fOA1R5O4Nd0p16dEyUMPzGMwvKq9BBrE8L7hSTU47ZN0eg/1ky9HLCtJDl+B/TttdE3aZ+vNXnx40p0m9OyCyXeazOMRbxDT1Sg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:27:38.6872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b24d2904-8aa7-4dd6-eeba-08df0dc6193f
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP190MB2480
X-BESS-ID: 1788884863-302194-8927-3336-1
X-BESS-VER: 2019.1_20260902.2230
X-BESS-Apparent-Source-IP: 52.101.66.124
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWZqaGQGYGUNTcxDw5McnA3C
 zRwDTN3NTSwNQyxTwp0SDRIsUy1SzNRKk2FgC4aRFEQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.275977 [from 
 cloudscan9-192.eu-central-1a.ess.aws.cudaops.com]
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

The virt queue state lived in two static arrays of 128 entries,
indexed by hardware queue id. Although touched on every burst, it
sat in BSS rather than in the hugepage backed EAL heap, wasted
space, was not NUMA aware, was not cache line aligned, was invisible
to a secondary process and was shared by all adapters.

Allocate one cache aligned queue object per queue, and the private
copy of the packet buffer descriptors, with rte_zmalloc_socket() on
the NUMA node of the adapter, and free them on release.

In ethdev, fail setup if allocation fails (a failed malloc() of the
descriptor copy was silently ignored before), release the queue from
the queue release callbacks (the descriptor copy leaked on re-setup
before), clear the handle after release, and register the queue with
ethdev only once setup succeeded.

Fixes: 576e77213f0d ("net/ntnic: add init for virtqueues in DBS")
Cc: stable@dpdk.org

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 206 +++++++++++-------
 drivers/net/ntnic/ntnic_ethdev.c              |  52 ++++-
 2 files changed, 173 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index af200432a2..ef8ad29aa1 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_common.h>
+#include <rte_malloc.h>
 #include <unistd.h>
 
 #include "ntos_drv.h"
@@ -12,7 +13,6 @@
 #include "ntlog.h"
 
 #define STRUCT_ALIGNMENT (4 * 1024LU)
-#define MAX_VIRT_QUEUES 128
 
 #define LAST_QUEUE 127
 #define DISABLE 0
@@ -97,7 +97,14 @@ enum nthw_virt_queue_usage {
 	NTHW_VIRTQ_MANAGED
 };
 
-struct nthw_virt_queue {
+/*
+ * Per-queue state. One instance is allocated per virt queue from hugepage
+ * memory on the NUMA node of the adapter, so the state touched in the
+ * Rx/Tx hot path lives next to the rings and packet buffers it describes,
+ * is visible to secondary processes and never shares a cache line with
+ * another queue.
+ */
+struct __rte_cache_aligned nthw_virt_queue {
 	/* Pointers to virt-queue structs */
 	union {
 		struct {
@@ -165,8 +172,54 @@ struct pvirtq_struct_layout_s {
 	size_t device_event_offset;
 };
 
-static struct nthw_virt_queue rxvq[MAX_VIRT_QUEUES];
-static struct nthw_virt_queue txvq[MAX_VIRT_QUEUES];
+static int dbs_numa_node(const nthw_dbs_t *p_nthw_dbs)
+{
+	return p_nthw_dbs->mp_fpga->p_fpga_info->numa_node;
+}
+
+/* Allocate a zeroed queue object and bind it to its DBS module */
+static struct nthw_virt_queue *dbs_alloc_virt_queue(nthw_dbs_t *p_nthw_dbs)
+{
+	struct nthw_virt_queue *vq = rte_zmalloc_socket("ntnic_vq",
+			sizeof(struct nthw_virt_queue), RTE_CACHE_LINE_SIZE,
+			dbs_numa_node(p_nthw_dbs));
+
+	if (vq != NULL)
+		vq->mp_nthw_dbs = p_nthw_dbs;
+
+	return vq;
+}
+
+/*
+ * Keep a private copy of the packet buffer descriptors. It is indexed on
+ * every Rx/Tx burst, so place it with the rest of the queue state.
+ */
+static int dbs_copy_packet_buffers(struct nthw_virt_queue *vq,
+	const struct nthw_memory_descriptor *p_packet_buffers, uint32_t n)
+{
+	size_t size = (size_t)n * sizeof(*p_packet_buffers);
+
+	if (n == 0)
+		return -1;	/* don't allocate memory with size of 0 bytes */
+
+	vq->p_virtual_addr = rte_zmalloc_socket("ntnic_vq_bufs", size, RTE_CACHE_LINE_SIZE,
+			dbs_numa_node(vq->mp_nthw_dbs));
+
+	if (vq->p_virtual_addr == NULL)
+		return -1;
+
+	memcpy(vq->p_virtual_addr, p_packet_buffers, size);
+	return 0;
+}
+
+static void dbs_free_virt_queue(struct nthw_virt_queue *vq)
+{
+	if (vq == NULL)
+		return;
+
+	rte_free(vq->p_virtual_addr);
+	rte_free(vq);
+}
 
 static void dbs_init_rx_queue(nthw_dbs_t *p_nthw_dbs, uint32_t queue, uint32_t start_idx,
 	uint32_t start_ptr)
@@ -236,11 +289,6 @@ static int nthw_virt_queue_init(struct fpga_info_s *p_fpga_info)
 
 	p_fpga_info->mp_nthw_dbs = p_nthw_dbs;
 
-	for (i = 0; i < MAX_VIRT_QUEUES; ++i) {
-		rxvq[i].usage = NTHW_VIRTQ_UNUSED;
-		txvq[i].usage = NTHW_VIRTQ_UNUSED;
-	}
-
 	nthw_dbs_reset(p_nthw_dbs);
 
 	for (i = 0; i < NT_DBS_RX_QUEUES_MAX; ++i)
@@ -358,7 +406,6 @@ static uint8_t dbs_qsize_log2(uint16_t qsize)
 }
 
 static int nthw_setup_rx_virt_queue(struct nthw_virt_queue *vq,
-	nthw_dbs_t *p_nthw_dbs,
 	uint32_t index,
 	uint16_t start_idx,
 	uint16_t start_ptr,
@@ -372,6 +419,7 @@ static int nthw_setup_rx_virt_queue(struct nthw_virt_queue *vq,
 	int irq_vector,
 	uint8_t rx_deferred_start)
 {
+	nthw_dbs_t *p_nthw_dbs = vq->mp_nthw_dbs;
 	uint32_t qs = dbs_qsize_log2(queue_size);
 	uint32_t int_enable;
 	uint32_t vec;
@@ -439,7 +487,6 @@ static int nthw_setup_rx_virt_queue(struct nthw_virt_queue *vq,
 
 	/* Save queue state */
 	vq->usage = NTHW_VIRTQ_UNMANAGED;
-	vq->mp_nthw_dbs = p_nthw_dbs;
 	vq->index = index;
 	vq->queue_size = queue_size;
 	vq->am_enable = (irq_vector < 0) ? RX_AM_ENABLE : RX_AM_DISABLE;
@@ -580,15 +627,17 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 
 static int nthw_release_mngd_rx_virt_queue(struct nthw_virt_queue *rxvq)
 {
+	int res;
+
 	if (rxvq == NULL || rxvq->usage != NTHW_VIRTQ_MANAGED)
 		return -1;
 
-	if (rxvq->p_virtual_addr) {
-		free(rxvq->p_virtual_addr);
-		rxvq->p_virtual_addr = NULL;
-	}
+	res = dbs_internal_release_rx_virt_queue(rxvq);
+
+	/* The queue object is owned here; the caller must drop its handle */
+	dbs_free_virt_queue(rxvq);
 
-	return dbs_internal_release_rx_virt_queue(rxvq);
+	return res;
 }
 
 static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
@@ -674,19 +723,20 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 
 static int nthw_release_mngd_tx_virt_queue(struct nthw_virt_queue *txvq)
 {
+	int res;
+
 	if (txvq == NULL || txvq->usage != NTHW_VIRTQ_MANAGED)
 		return -1;
 
-	if (txvq->p_virtual_addr) {
-		free(txvq->p_virtual_addr);
-		txvq->p_virtual_addr = NULL;
-	}
+	res = dbs_internal_release_tx_virt_queue(txvq);
 
-	return dbs_internal_release_tx_virt_queue(txvq);
+	/* The queue object is owned here; the caller must drop its handle */
+	dbs_free_virt_queue(txvq);
+
+	return res;
 }
 
 static int nthw_setup_tx_virt_queue(struct nthw_virt_queue *vq,
-	nthw_dbs_t *p_nthw_dbs,
 	uint32_t index,
 	uint16_t start_idx,
 	uint16_t start_ptr,
@@ -703,6 +753,7 @@ static int nthw_setup_tx_virt_queue(struct nthw_virt_queue *vq,
 	uint32_t in_order,
 	uint8_t tx_deferred_start)
 {
+	nthw_dbs_t *p_nthw_dbs = vq->mp_nthw_dbs;
 	uint32_t int_enable;
 	uint32_t vec;
 	uint32_t istk;
@@ -772,7 +823,6 @@ static int nthw_setup_tx_virt_queue(struct nthw_virt_queue *vq,
 
 	/* Save queue state */
 	vq->usage = NTHW_VIRTQ_UNMANAGED;
-	vq->mp_nthw_dbs = p_nthw_dbs;
 	vq->index = index;
 	vq->queue_size = queue_size;
 	vq->am_enable = (irq_vector < 0) ? TX_AM_ENABLE : TX_AM_DISABLE;
@@ -801,6 +851,10 @@ nthw_setup_mngd_rx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 	uint8_t rx_deferred_start)
 {
 	struct virtq_struct_layout_s virtq_struct_layout = dbs_calc_struct_layout(queue_size);
+	struct nthw_virt_queue *vq = dbs_alloc_virt_queue(p_nthw_dbs);
+
+	if (vq == NULL)
+		return NULL;
 
 	dbs_initialize_virt_queue_structs(p_virt_struct_area->virt_addr,
 		(char *)p_virt_struct_area->virt_addr +
@@ -812,38 +866,33 @@ nthw_setup_mngd_rx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 		p_packet_buffers ? (uint16_t)queue_size : 0,
 		VIRTQ_DESC_F_WRITE /* Rx */);
 
-	rxvq[index].p_avail = p_virt_struct_area->virt_addr;
-	rxvq[index].p_used =
+	vq->p_avail = p_virt_struct_area->virt_addr;
+	vq->p_used =
 		(void *)((char *)p_virt_struct_area->virt_addr + virtq_struct_layout.used_offset);
-	rxvq[index].p_desc =
+	vq->p_desc =
 		(void *)((char *)p_virt_struct_area->virt_addr + virtq_struct_layout.desc_offset);
 
-	rxvq[index].am_idx = p_packet_buffers ? (uint16_t)queue_size : 0;
-	rxvq[index].used_idx = 0;
-	rxvq[index].cached_idx = 0;
-	rxvq[index].p_virtual_addr = NULL;
+	vq->am_idx = p_packet_buffers ? (uint16_t)queue_size : 0;
 
-	if (p_packet_buffers) {
-		rxvq[index].p_virtual_addr = malloc(queue_size * sizeof(*p_packet_buffers));
-		if (rxvq[index].p_virtual_addr)
-			memcpy(rxvq[index].p_virtual_addr, p_packet_buffers,
-				queue_size * sizeof(*p_packet_buffers));
+	if (p_packet_buffers &&
+		dbs_copy_packet_buffers(vq, p_packet_buffers, queue_size) != 0) {
+		dbs_free_virt_queue(vq);
+		return NULL;
 	}
 
-	if (nthw_setup_rx_virt_queue(&rxvq[index], p_nthw_dbs, index, 0, 0,
+	if (nthw_setup_rx_virt_queue(vq, index, 0, 0,
 			(void *)p_virt_struct_area->phys_addr,
 			(char *)p_virt_struct_area->phys_addr + virtq_struct_layout.used_offset,
 			(char *)p_virt_struct_area->phys_addr + virtq_struct_layout.desc_offset,
 			(uint16_t)queue_size, host_id, header, SPLIT_RING, irq_vector,
 			rx_deferred_start) != 0) {
-		free(rxvq[index].p_virtual_addr);
-		rxvq[index].p_virtual_addr = NULL;
+		dbs_free_virt_queue(vq);
 		return NULL;
 	}
 
-	rxvq[index].usage = NTHW_VIRTQ_MANAGED;
+	vq->usage = NTHW_VIRTQ_MANAGED;
 
-	return &rxvq[index];
+	return vq;
 }
 
 static struct nthw_virt_queue *
@@ -861,6 +910,10 @@ nthw_setup_mngd_tx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 	uint8_t tx_deferred_start)
 {
 	struct virtq_struct_layout_s virtq_struct_layout = dbs_calc_struct_layout(queue_size);
+	struct nthw_virt_queue *vq = dbs_alloc_virt_queue(p_nthw_dbs);
+
+	if (vq == NULL)
+		return NULL;
 
 	dbs_initialize_virt_queue_structs(p_virt_struct_area->virt_addr,
 		(char *)p_virt_struct_area->virt_addr +
@@ -872,40 +925,32 @@ nthw_setup_mngd_tx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 		0,
 		0 /* Tx */);
 
-	txvq[index].p_avail = p_virt_struct_area->virt_addr;
-	txvq[index].p_used =
+	vq->p_avail = p_virt_struct_area->virt_addr;
+	vq->p_used =
 		(void *)((char *)p_virt_struct_area->virt_addr + virtq_struct_layout.used_offset);
-	txvq[index].p_desc =
+	vq->p_desc =
 		(void *)((char *)p_virt_struct_area->virt_addr + virtq_struct_layout.desc_offset);
-	txvq[index].queue_size = (uint16_t)queue_size;
-	txvq[index].am_idx = 0;
-	txvq[index].used_idx = 0;
-	txvq[index].cached_idx = 0;
-	txvq[index].p_virtual_addr = NULL;
-
-	txvq[index].tx_descr_avail_idx = 0;
-
-	if (p_packet_buffers) {
-		txvq[index].p_virtual_addr = malloc(queue_size * sizeof(*p_packet_buffers));
-		if (txvq[index].p_virtual_addr)
-			memcpy(txvq[index].p_virtual_addr, p_packet_buffers,
-				queue_size * sizeof(*p_packet_buffers));
+	vq->queue_size = (uint16_t)queue_size;
+
+	if (p_packet_buffers &&
+		dbs_copy_packet_buffers(vq, p_packet_buffers, queue_size) != 0) {
+		dbs_free_virt_queue(vq);
+		return NULL;
 	}
 
-	if (nthw_setup_tx_virt_queue(&txvq[index], p_nthw_dbs, index, 0, 0,
+	if (nthw_setup_tx_virt_queue(vq, index, 0, 0,
 			(void *)p_virt_struct_area->phys_addr,
 			(char *)p_virt_struct_area->phys_addr + virtq_struct_layout.used_offset,
 			(char *)p_virt_struct_area->phys_addr + virtq_struct_layout.desc_offset,
 			(uint16_t)queue_size, host_id, port, virtual_port, header,
 			SPLIT_RING, irq_vector, in_order, tx_deferred_start) != 0) {
-		free(txvq[index].p_virtual_addr);
-		txvq[index].p_virtual_addr = NULL;
+		dbs_free_virt_queue(vq);
 		return NULL;
 	}
 
-	txvq[index].usage = NTHW_VIRTQ_MANAGED;
+	vq->usage = NTHW_VIRTQ_MANAGED;
 
-	return &txvq[index];
+	return vq;
 }
 
 /*
@@ -965,16 +1010,9 @@ static int nthw_setup_managed_virt_queue_packed(struct nthw_virt_queue *vq,
 	else
 		vq->used_wrap_count ^= 1;	/* pre-fill free buffer IDs */
 
-	if (vq->queue_size == 0)
-		return -1;	/* don't allocate memory with size of 0 bytes */
-
-	vq->p_virtual_addr = malloc(vq->queue_size * sizeof(*p_packet_buffers));
-
-	if (vq->p_virtual_addr == NULL)
+	if (dbs_copy_packet_buffers(vq, p_packet_buffers, vq->queue_size) != 0)
 		return -1;
 
-	memcpy(vq->p_virtual_addr, p_packet_buffers, vq->queue_size * sizeof(*p_packet_buffers));
-
 	/* Not used yet by FPGA - make sure we disable */
 	vq->device_event->flags = RING_EVENT_FLAGS_DISABLE;
 
@@ -993,17 +1031,23 @@ nthw_setup_managed_rx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 	uint8_t rx_deferred_start)
 {
 	struct pvirtq_struct_layout_s pvirtq_layout;
-	struct nthw_virt_queue *vq = &rxvq[index];
+	struct nthw_virt_queue *vq = dbs_alloc_virt_queue(p_nthw_dbs);
+
+	if (vq == NULL)
+		return NULL;
+
 	/* Set size and setup packed vq ring */
 	vq->queue_size = queue_size;
 
 	/* Use Avail flag bit == 1 because wrap bit is initially set to 1 - and Used is inverse */
 	if (nthw_setup_managed_virt_queue_packed(vq, &pvirtq_layout, p_virt_struct_area,
 			p_packet_buffers,
-			VIRTQ_DESC_F_WRITE | VIRTQ_DESC_F_AVAIL, 1) != 0)
+			VIRTQ_DESC_F_WRITE | VIRTQ_DESC_F_AVAIL, 1) != 0) {
+		dbs_free_virt_queue(vq);
 		return NULL;
+	}
 
-	if (nthw_setup_rx_virt_queue(vq, p_nthw_dbs, index,
+	if (nthw_setup_rx_virt_queue(vq, index,
 			0x8000, 0,	/* start wrap ring counter as 1 */
 			(void *)((uintptr_t)p_virt_struct_area->phys_addr +
 				pvirtq_layout.driver_event_offset),
@@ -1011,8 +1055,7 @@ nthw_setup_managed_rx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 				pvirtq_layout.device_event_offset),
 			p_virt_struct_area->phys_addr, (uint16_t)queue_size, host_id,
 			header, PACKED_RING, irq_vector, rx_deferred_start) != 0) {
-		free(vq->p_virtual_addr);
-		vq->p_virtual_addr = NULL;
+		dbs_free_virt_queue(vq);
 		return NULL;
 	}
 
@@ -1035,15 +1078,21 @@ nthw_setup_managed_tx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 	uint8_t tx_deferred_start)
 {
 	struct pvirtq_struct_layout_s pvirtq_layout;
-	struct nthw_virt_queue *vq = &txvq[index];
+	struct nthw_virt_queue *vq = dbs_alloc_virt_queue(p_nthw_dbs);
+
+	if (vq == NULL)
+		return NULL;
+
 	/* Set size and setup packed vq ring */
 	vq->queue_size = queue_size;
 
 	if (nthw_setup_managed_virt_queue_packed(vq, &pvirtq_layout, p_virt_struct_area,
-			p_packet_buffers, 0, 0) != 0)
+			p_packet_buffers, 0, 0) != 0) {
+		dbs_free_virt_queue(vq);
 		return NULL;
+	}
 
-	if (nthw_setup_tx_virt_queue(vq, p_nthw_dbs, index,
+	if (nthw_setup_tx_virt_queue(vq, index,
 			0x8000, 0,	/* start wrap ring counter as 1 */
 			(void *)((uintptr_t)p_virt_struct_area->phys_addr +
 				pvirtq_layout.driver_event_offset),
@@ -1052,8 +1101,7 @@ nthw_setup_managed_tx_virt_queue_packed(nthw_dbs_t *p_nthw_dbs,
 			p_virt_struct_area->phys_addr, (uint16_t)queue_size, host_id,
 			port, virtual_port, header, PACKED_RING, irq_vector, in_order,
 			tx_deferred_start) != 0) {
-		free(vq->p_virtual_addr);
-		vq->p_virtual_addr = NULL;
+		dbs_free_virt_queue(vq);
 		return NULL;
 	}
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 7cc90a7a5b..87d3046f29 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -986,6 +986,13 @@ static void eth_tx_queue_release(struct rte_eth_dev *eth_dev, uint16_t queue_id)
 {
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 	struct ntnic_tx_queue *tx_q = &internals->txq_scg[queue_id];
+
+	/* Stop the HW queue and free its state before the rings are unmapped */
+	if (sg_ops != NULL && tx_q->vq != NULL) {
+		sg_ops->nthw_release_mngd_tx_virt_queue(tx_q->vq);
+		tx_q->vq = NULL;
+	}
+
 	deallocate_hw_virtio_queues(&tx_q->hwq);
 }
 
@@ -993,6 +1000,13 @@ static void eth_rx_queue_release(struct rte_eth_dev *eth_dev, uint16_t queue_id)
 {
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 	struct ntnic_rx_queue *rx_q = &internals->rxq_scg[queue_id];
+
+	/* Stop the HW queue and free its state before the rings are unmapped */
+	if (sg_ops != NULL && rx_q->vq != NULL) {
+		sg_ops->nthw_release_mngd_rx_virt_queue(rx_q->vq);
+		rx_q->vq = NULL;
+	}
+
 	deallocate_hw_virtio_queues(&rx_q->hwq);
 }
 
@@ -1046,8 +1060,6 @@ static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 
 	rx_q->mb_pool = mb_pool;
 
-	eth_dev->data->rx_queues[rx_queue_id] = rx_q;
-
 	mbp_priv = rte_mempool_get_priv(rx_q->mb_pool);
 	rx_q->buf_size = (uint16_t)(mbp_priv->mbuf_data_room_size - RTE_PKTMBUF_HEADROOM);
 	rx_q->enabled = !rx_conf->rx_deferred_start;
@@ -1073,6 +1085,20 @@ static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 			-1,
 			rx_conf->rx_deferred_start);
 
+	if (rx_q->vq == NULL) {
+		NT_LOG(ERR, NTNIC, "(%u) NTNIC RX queue %u virt queue setup failed",
+			internals->port, rx_queue_id);
+		deallocate_hw_virtio_queues(&rx_q->hwq);
+		return -1;
+	}
+
+	/*
+	 * Hand the queue to ethdev only once it is fully set up. ethdev does not
+	 * clear the entry when setup fails, and the release callback would then
+	 * tear down rings that were already freed above.
+	 */
+	eth_dev->data->rx_queues[rx_queue_id] = rx_q;
+
 	NT_LOG(DBG, NTNIC, "(%" PRIu32 ") NTNIC RX OVS-SW queues successfully setup",
 		internals->port);
 
@@ -1116,8 +1142,6 @@ static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 		return -1;
 	}
 
-	eth_dev->data->tx_queues[tx_queue_id] = tx_q;
-
 	/* Calculate target ID for HW  - to be used in NTDVIO0 header bypass_port */
 	if (tx_q->rss_target_id >= 0) {
 		/* bypass to a multiqueue port - qsl-hsh index */
@@ -1167,6 +1191,16 @@ static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 			IN_ORDER,
 			tx_conf->tx_deferred_start);
 
+	if (tx_q->vq == NULL) {
+		NT_LOG(ERR, NTNIC, "(%u) NTNIC TX queue %u virt queue setup failed",
+			tx_q->port, tx_queue_id);
+		deallocate_hw_virtio_queues(&tx_q->hwq);
+		return -1;
+	}
+
+	/* See eth_rx_scg_queue_setup() */
+	eth_dev->data->tx_queues[tx_queue_id] = tx_q;
+
 	tx_q->enabled = !tx_conf->tx_deferred_start;
 	tx_q->tx_deferred_start = tx_conf->tx_deferred_start;
 
@@ -1577,11 +1611,15 @@ eth_dev_close(struct rte_eth_dev *eth_dev)
 		uint q;
 
 		if (sg_ops != NULL) {
-			for (q = 0; q < internals->nb_rx_queues; q++)
+			for (q = 0; q < internals->nb_rx_queues; q++) {
 				sg_ops->nthw_release_mngd_rx_virt_queue(rx_q[q].vq);
+				rx_q[q].vq = NULL;
+			}
 
-			for (q = 0; q < internals->nb_tx_queues; q++)
+			for (q = 0; q < internals->nb_tx_queues; q++) {
 				sg_ops->nthw_release_mngd_tx_virt_queue(tx_q[q].vq);
+				tx_q[q].vq = NULL;
+			}
 		}
 	}
 
@@ -2651,11 +2689,13 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 		while (internals) {
 			for (i = internals->nb_tx_queues - 1; i >= 0; i--) {
 				sg_ops->nthw_release_mngd_tx_virt_queue(internals->txq_scg[i].vq);
+				internals->txq_scg[i].vq = NULL;
 				release_hw_virtio_queues(&internals->txq_scg[i].hwq);
 			}
 
 			for (i = internals->nb_rx_queues - 1; i >= 0; i--) {
 				sg_ops->nthw_release_mngd_rx_virt_queue(internals->rxq_scg[i].vq);
+				internals->rxq_scg[i].vq = NULL;
 				release_hw_virtio_queues(&internals->rxq_scg[i].hwq);
 			}
 
-- 
2.45.0

