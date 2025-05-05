Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D36C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:13:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6276740650;
	Mon,  5 May 2025 09:13:22 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 67CB14025D
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 mx-outbound45-79.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rol5Sg8tQcsRHb61QD+9Z/HlWO/9KM+bavebPJFLkYc2H/tuAycKkmwdKZrqOZd25AMXyaqpo8HCByxBEkMBko29u3s0f4PxyUQwTjyxYqDBu6gYyZ6d/rZ2ocpVxpsOt4OgOYkoOVBHVfUKhIDNwGC4DDoCiQ6I/ABOtqpa0kQ1ifR5lAtcuVfocOWBRAEUniyZvO1Ma3uZVr5nD2I6eNNimr4r9qSA5PVMg9zXZk/tsubhY/9PCOC1uAEkRiKzDghWTEnSopr7rBYTejZoVzFSerG9x8E+pyByfh1ZflWd/0c4sR9d5Lox1dphrGVKEd7iwGPHGMkc3rLF6m5tEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy54sW1UskmLFRtQl9GxiyZEBzf4vOw5FJM+xSXU+1A=;
 b=hNU7FYfACU7x1Xh53s4vRWhsipNIWU/Lci/+GOFIYiFO/bl6u/FBUas8l280rMTb09svnkx64Zu6NsA2eMcFDpoCHdRlv4cIiFaFUjKHh/RFMD5x2fbpSRaw8MtkUb6V87McJUAc8QMynH+R1ALuA3LOjG9df1c1oOnjZlmPYbt4g6L9k4tVDBMm9oqWEtMp62HrgLOFrjlmRGmuoHdnwM8+PYpHSjHr9Kn1+7ffGgQP/bsCbsbZHLhzZMQSG7sBrh0BVcno5AJHGuMSZF9/Vv6+GztazZaC3UCGJdLTALjLCfD8GAy+hPGwJSh84Eno4C3QiqZg/NWZQuB0CQY20A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy54sW1UskmLFRtQl9GxiyZEBzf4vOw5FJM+xSXU+1A=;
 b=dQUYjqyLiUq5mzWsoZb9XZzzSi/agZFWHmiEVljCcXbNvmKoCWWRR/TLVewF+/2ihFE4MMCcNjEtYYVsKwaWTy40JD3I43BABZOaw+Vc2cjLRYZH5Ic/g7V4Og1A3xY9sp9TSKo/gd7QLVy0vIO4OA9DHQ3gfTjNHPUnSVTSCyM=
Received: from DU7P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::35)
 by AM9P190MB1332.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:12 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::a5) by DU7P191CA0010.outlook.office365.com
 (2603:10a6:10:54e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:12
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 01/26] net/ntnic: remove usage of the variable-length arrays
Date: Mon,  5 May 2025 09:12:41 +0200
Message-ID: <20250505071309.586015-2-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AM9P190MB1332:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15cd34e1-8dc4-4901-3302-08dd8ba44c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eoas93DwgeSuPH520GvD5a0fheJbLrrkquD0wq5kbfLDBIgVW0qLfsB1IQbP?=
 =?us-ascii?Q?T4kp4VtVNI/qJqACR7iHs25nczHYS+IWK4KWH8J/lEko+6J5li63/uqcHFDf?=
 =?us-ascii?Q?eyLMxPUM81GQUA6BX7d+0RXIz/WZbXXA9U/e+h/L+GoLoaUpt1ZU5kt5JxWk?=
 =?us-ascii?Q?JhyZrlmpJIEOMkQ/BgOG9sjxonQ4rmkEr8jw/FQu1LLEmI+H+5EzsEg3Xj2p?=
 =?us-ascii?Q?wx/qYn+VWDtJDysqNgEl9cunCwunV4MXJd0Vsjd3YOX+2OKLVLc9Fclyyn3v?=
 =?us-ascii?Q?IDyd3miKbmKoX+sM0qnGWpBagHEtK6ZutTLUUr7hNWfg6ac78VDyK9RFqayN?=
 =?us-ascii?Q?SSz19e21SrDiy6j2/vKg70cfTB5Vm7F+dAri06Fz28q5Ck3Fkh8iUC8lzfSv?=
 =?us-ascii?Q?DCG9WblrUsAQnPu5D/+lODes4c37ydJy7ocu+onnLGQlXzW9HVO2eSQTRJmr?=
 =?us-ascii?Q?23TpWsJThtSTSHFWeo7B2DGRMGyljlzIVZ+kvsdYJBPfaJPnzErU0w+KveBP?=
 =?us-ascii?Q?sWaDP/lZxRQ8MuRmnLQ5NCq927+VcGPyueuRslTVZoaPCO0yFnNxdi+HhfdB?=
 =?us-ascii?Q?qCf6eiXdpBfeFR/FuHAGCQzxQ9TxvXi3bPhl/LYx8ZvblSMaKh1tV7XYEpKh?=
 =?us-ascii?Q?Rc55r8sd40VT+mx567+L8XGQ93xRF3w7gouh61QgasYdVix7+bHx/hqIGa2B?=
 =?us-ascii?Q?WQd3Hp4OkKa1horwq3zPpgGJ6HCE6iwxzp+s2lp+khwK376LfFx42DZWwL7+?=
 =?us-ascii?Q?DpO3dNJXOaKq4QmB+tdwfOJb+Q81ED4HN9361rRJFXyZz9ABYiJ9BMPsML6W?=
 =?us-ascii?Q?hOjmuiVkAx1x1RBvSPLlduERaa35vJAQKrx+gA3f6kkXO5/4GUJwcrIfOEzb?=
 =?us-ascii?Q?Ubs5DmV0TAa/mL2/S3dLLwQsZF0GlMGgkNyNWIv9nzqmxHQ2f3ZT+ZWEN1oM?=
 =?us-ascii?Q?ckFXV9flsId+y5T26p3odF7NRhAHDODXF2HQgDpraWnP+q2vzxRT+qL9Mr9X?=
 =?us-ascii?Q?K6rdpUS7VxUsTn+8A4JeRn4vDOUJ/G/FrdjnizM++il4gQSTPfpWpGWItyx/?=
 =?us-ascii?Q?yMT1mQIrORrtHzP8GscRK228GVYgLmdTcjBoQVcom3Z5nbErePafA2ghCkJh?=
 =?us-ascii?Q?iVwXSTWoMruxwjcQhdUz7iNVk54sVVrHF2Ib1xJMmjMSIjpBr0JxvKhobuMT?=
 =?us-ascii?Q?WrTUsaBjzg9xA1AMESlT3aCfol2TI3bUKIrOd434UgzX7NRFcfhzM0Ccl/mM?=
 =?us-ascii?Q?ThBT+FkwwOqKVPB0c3wRhusAZOGVdBfj6r4rxPNye5Nx7wA1DlOEJ68TkWPz?=
 =?us-ascii?Q?vI38qjHbBHotTrMrY+NtzJSatnMkM88L7vPGbCqw00cBX5ktNIpUP2REq3ES?=
 =?us-ascii?Q?SSModC72r7wTfxoeZpIw2iZth6cfXCTEZS/uiyRRRiQmQoEbDeqEbq9xa42W?=
 =?us-ascii?Q?ZMAtfee1lTkevaMkz+9hfrthfy/kRwjLNbwZZ9w4DYYTY+roomjzvEr8DoQ8?=
 =?us-ascii?Q?zvyxtiVD279xODw3e7LvDW9z+Z0Q3UyOyIsv?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PemTrMX9xf7qD7kBUN13GUPxvmsF1eVO1Dfx16rX6TkufOxhSIW+ih9e57DUyWCWTGf13bG7baPwnilxNHSAzvB7gPDm3pRJq0uJzhs2b0izP7XCq2uYKcunG+FdHnY/nw79GWlyqioOIMdUtmjxGIPdCMqvqUvO/haVuIZyJ2VzA5MboFRDT5Dy8daKn3EaEZ+otdAVcyZhYVShcakJc3HtPHnOmb8Iv6GWJDF/BiFnaX8EB9jpsy/A7W/rPvwAleXV/P2pn4csOYfQTY8G8fgvAqEmlUxjDnNvny5LhWubocgopn2Z96zqNZWOEM6+P4SsRsqpRjA6YPJPxMrrjxIw9OmrchTtkd53GfeAFvVuGEk6Udy3zOzHCSn6lSjm5sV8+T2YCQPsn9hc4/qX3jf7M2/ZwDZxQo6dhWjLyhZnApmPkVn4Y32B13t7/ws8fXcizd5ZDHeozFXDqWnLP7mTbqNHAcJdVerBcyxmwjCsJvb/wRPJrtoHNAK9H4FCSNt2bbReuajNVaj2TylfhJ9LBV/sqMpqndHiuAquIaWFGCZimH3lZVC4/2tjJczV+kPFc1PXwK68HPt289jQEAO5FY0Zqtrr/aManlh1qN7326z8AR7OeT1pBPa7+ltR4qojNV/WtgGvPBOQwL5kGg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:12.3325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cd34e1-8dc4-4901-3302-08dd8ba44c27
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1332
X-BESS-ID: 1746429194-311599-7747-346-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYWBkZAVgZQMDnVINHEwMLCzD
 Q51dLcJDUxJdU42dDEwtTUPCUlLdlAqTYWAJp/akdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan21-15.eu-central-1b.ess.aws.cudaops.com]
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

VLAs with known upper limits are replaced with fixed-length arrays.
In case an upper limit of an array cannot be known in advance,
the memory for such an array is allocated dynamically using alloca.
In comparison to malloc family of functions, the alloca executes faster
due to working directly with a stack instead of a heap,
for the same reason it does not require manual memory management.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/meson.build                       |  2 --
 .../flow_api/profile_inline/flow_api_hw_db_inline.c | 13 ++++++++++---
 .../profile_inline/flow_api_profile_inline.c        |  8 ++++----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 30a92130b5..b4c6cfe7de 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -124,5 +124,3 @@ sources = files(
         'ntnic_vfio.c',
         'ntnic_ethdev.c',
 )
-
-cflags += no_wvla_cflag
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index a016c82458..ae72b8775e 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -1343,9 +1343,11 @@ static int hw_db_inline_alloc_prioritized_cfn(struct flow_nic_dev *ndev,
 	struct {
 		uint64_t priority;
 		uint32_t idx;
-	} sorted_priority[db->nb_cat];
+	} *sorted_priority;
 
-	memset(sorted_priority, 0x0, sizeof(sorted_priority));
+	sorted_priority = calloc(db->nb_cat, sizeof(*sorted_priority));
+	if (!sorted_priority)
+		return -1;
 
 	uint32_t in_use_count = 0;
 
@@ -1360,13 +1362,16 @@ static int hw_db_inline_alloc_prioritized_cfn(struct flow_nic_dev *ndev,
 		}
 	}
 
-	if (in_use_count >= db->nb_cat - 1)
+	if (in_use_count >= db->nb_cat - 1) {
+		free(sorted_priority);
 		return -1;
+	}
 
 	if (in_use_count == 0) {
 		db->cfn[db_cfn_idx].ref = 1;
 		db->cfn[db_cfn_idx].cfn_hw = 1;
 		db->cfn[db_cfn_idx].priority = priority;
+		free(sorted_priority);
 		return db_cfn_idx;
 	}
 
@@ -1400,6 +1405,7 @@ static int hw_db_inline_alloc_prioritized_cfn(struct flow_nic_dev *ndev,
 		db->cfn[db_cfn_idx].ref = 1;
 		db->cfn[db_cfn_idx].cfn_hw = goal;
 		db->cfn[db_cfn_idx].priority = priority;
+		free(sorted_priority);
 		return db_cfn_idx;
 	}
 
@@ -1425,6 +1431,7 @@ static int hw_db_inline_alloc_prioritized_cfn(struct flow_nic_dev *ndev,
 	db->cfn[db_cfn_idx].ref = 1;
 	db->cfn[db_cfn_idx].cfn_hw = goal;
 	db->cfn[db_cfn_idx].priority = priority;
+	free(sorted_priority);
 
 	return db_cfn_idx;
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 6824b35463..c0407574f0 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -3198,15 +3198,15 @@ static void setup_db_qsl_data(struct nic_flow_def *fd, struct hw_db_inline_qsl_d
 	} else {
 		RTE_ASSERT(fd->dst_num_avail < HW_DB_INLINE_MAX_QST_PER_QSL);
 
-		uint32_t ports[fd->dst_num_avail];
-		uint32_t queues[fd->dst_num_avail];
+		uint32_t ports[HW_DB_INLINE_MAX_QST_PER_QSL];
+		uint32_t queues[HW_DB_INLINE_MAX_QST_PER_QSL];
 
 		uint32_t port_index = 0;
 		uint32_t queue_index = 0;
 		uint32_t max = num_dest_port > num_queues ? num_dest_port : num_queues;
 
-		memset(ports, 0, fd->dst_num_avail);
-		memset(queues, 0, fd->dst_num_avail);
+		memset(ports, 0, sizeof(ports));
+		memset(queues, 0, sizeof(queues));
 
 		qsl_data->table_size = max;
 		qsl_data->retransmit = num_dest_port > 0 ? 1 : 0;
-- 
2.47.1

