Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29377C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:50:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5496240674;
	Wed, 30 Apr 2025 15:49:30 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 14BB1402C4
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:20 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 mx-outbound21-53.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6S2nkQvZ2oREeR77dXKGbF7k4zBaMBUKXLE9uw6+WtA8iVGvBWFtx80MwV1anT66M7DOjJfufoV0u29jLWEhaHZkxXhjfdQ9KBuRFVnvb4zkf86yoVeobgeaUDRy6Dxmwe0Vbjf7iFSYzeZ6juK0GSqwGyUSUqdabRxlp6cABMg1Si33UdYnt36DESqjpDrT0RVSARuJaJ5dDLmS7zMrIfp1PTaUQON0AuNn2XVQ6ShxZg+a3JmagA5wjXd0jHAMRRKUJfN34c/ojM7TGNH7mgDHei6XyF1FIavUHA/gLpWiUj5IFiy25MDV2tzSS8jVQKUhJQqrQEAjndrtKuHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy54sW1UskmLFRtQl9GxiyZEBzf4vOw5FJM+xSXU+1A=;
 b=F5STWGaG5BKXPYF5lSye9ynfRnoBjO9GFf+70xLT+z51nz349/hTKrj+uqXVcIWCQE6g5PhGqrrDeXWXH4iFGsHSctp0m92UkCDDp1wSeUWmf9ufXYrjv4PFDjkjzmEVOzbYholnxPszLLAA+XBFfPKmsszWS7zmaywAOcHURoPfrqSf0msLC4bRifmQlb6j4U92X7pNtPSwBmrl9rrrsaCAzW0Eggr8JKFhRW/33DqKGqEgv6iwzv7z9lMm0LBNUZXwAR2GNtCx8IDImbM+utEjQ87YhPPBstGMhdIGpLGYYlULbikJBajb5ZFCmKcSASRhUlBbyZbLx8t2OYkMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy54sW1UskmLFRtQl9GxiyZEBzf4vOw5FJM+xSXU+1A=;
 b=Gad91HK0d53R/WaGnIiYICF6PePiTnmEjUgdoF2Co7DdeEhYO+9eJH23WMMG3wWrPYHVAuHoZn+nIjRWdmQ2HKK0XOWL4PGId3Y0cHTp9Xb4aAISdP3bdtokI4uzSsPpkQQcIAJtpFI8nKZLYk0JP7ZTbvTKFpfKd/pfZIRy6y4=
Received: from AM9P193CA0030.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::35)
 by VI0P190MB2138.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 13:49:06 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::63) by AM9P193CA0030.outlook.office365.com
 (2603:10a6:20b:21e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 13:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:06 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 01/25] net/ntnic: remove usage of the variable-length arrays
Date: Wed, 30 Apr 2025 15:48:13 +0200
Message-ID: <20250430134840.402553-2-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|VI0P190MB2138:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 369bb87a-7f8a-4155-a2e7-08dd87edc6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NgE2Zni2LM7wVCq9HcVd/NrjSeTkhYwrFFr58bgERIY3kbI8emHCN7NKdbLv?=
 =?us-ascii?Q?gtVp2pSMJjlT67+nAAYEx6fYN2AnR61pX2GVx3Lttlrgop8FAIR+zFzi+CYJ?=
 =?us-ascii?Q?MPwMH686YAPyEQ7TZaF3cdN+XC2q1rKIn0AthA/cA4MKuNmcBBMNS5hGPgFE?=
 =?us-ascii?Q?4z6BpkN9kVpE0ygM+tZRwENB82IPTmRa04wNh4ZzQgDWuxHEzNRxFsTrOLtM?=
 =?us-ascii?Q?M+nV07KO8N3N9F/LRt0c4hyjFkCZIycODwLleUpioVFlPiUPuJbRNX4gySW1?=
 =?us-ascii?Q?9oGmTJw3DlDwa3IqPgXQ3f22ra04WApDOCgp29grdNwwDny0o7Fw3mbM5W+R?=
 =?us-ascii?Q?zmIugy8aBmIfDDTTdhfOZzsFOO7B9/lXq7GO1EMsd7CQdwT5KCUhA9Fsd28U?=
 =?us-ascii?Q?arcKIPobqB+1NPpGKmZG7RPT10OQ2RqbzVtUJufi+avcAkHU14B/xRGkHWRx?=
 =?us-ascii?Q?JoN38SimjAx8zog3/bD1sewcXmmVwFbzhAcnq6t7Gyx5jCv0zw09jm+CtbJb?=
 =?us-ascii?Q?VjeU9q40PkMs6rh9/S+on68D++mDdeBEpn171iYhQcEYsxDG1XjQ3oh7iGc0?=
 =?us-ascii?Q?7xF25IxD7aRQPvPt50+XTT/UvrB8fU3MTlfisQ5L8UpuXAmo/zhqMch7e2X1?=
 =?us-ascii?Q?UbrcKEf27Wos3QcER6FliVAoJCOXaMTREWJIJdmX3j6MJfSB2WxwQ5ZHO/EF?=
 =?us-ascii?Q?RoP8+mbBJFA2m13DgnkLIQQHAGaHDvErF+k6JLr9rlEQU6F9y43S1yTEi8Vf?=
 =?us-ascii?Q?+jrsnH3Wq7RcNpBDQV1a5J7Hlo3XPr9lda7csdZ6PdZ/sZ9liwzJpIuLLlF/?=
 =?us-ascii?Q?Y3zACH4ZxkN26N9uOU1hZ4jq+cRX8XFTYVR4khJg7Eq2XqQtK+h8vSCW7Xjw?=
 =?us-ascii?Q?v9n8g9DxyhLtniK5mDx07Jgb57NbL1I4m/QEoZc3/TPqlG+iAJLt3r6ir85/?=
 =?us-ascii?Q?eKM2AQZT6WdRd3mkqCOHowsQSAgkRNiYwUTJKY6LNkF1IhCFRFlcOCs+Udyg?=
 =?us-ascii?Q?0I9Zxok0VqBtRzS0i/WhLbBVrjPU15MPIE6E6OB8KVvoU05LFuxk5dLoCFMr?=
 =?us-ascii?Q?mLLrwfN85AW/AwRA3s2D8CDtnjZ2mJWF5wiTEOjU+zDddMZQOAmBSCZ4j8k8?=
 =?us-ascii?Q?YwV4FTT6NsFJ1J0PF1qKRlzPrBXeGcSFtN3DLa2D8Wv2naJRNa/blaXoLC10?=
 =?us-ascii?Q?STbN03YiuPBVU7XCHuYxTADbJAT+SYX0Y5VDrnz18YRMOR5haM3CMrjQHaTm?=
 =?us-ascii?Q?AzNs6Cy6qKbqgeTSuI5FTd2CaPrjC2oE9gLIN5CQ0wE1HRl2dHdqw2OJIoBl?=
 =?us-ascii?Q?CEBUXkdOG9GPuhDyZkCu46NDCaO/ISx/rqK0UCdUt2SSeGTfse7p125F91dH?=
 =?us-ascii?Q?ZuDsj7N0dHo4hl9hoAL5dsLulqd26HUdCIUndXQ3/Ur2JuYIhRet2LR3kkmn?=
 =?us-ascii?Q?KYEwcADc2SLpI8ac+r+Wzh5t6dbUOpFoVacaEmNLzqvrqf2LBGHZrOhXD5GE?=
 =?us-ascii?Q?lL3QrXgjb1kPmteYzcwyABx9YUNYP0ezu8Yw?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I2bTtCJPx4jZDG4on5+MlbYtPIqkEo5XPkUqKqK8EYXPFxm7DmH0NlbrQ2+ZOxPsxRz4FRNlvRWws3CdLXh5d6QNbMSiJhEy/3isQWlL4ESzC/5aylVC/JEY0Boh2PvzlvOBjskzxL/j8uzBOgaOlkdSuJLFntRPmxxcTkphlcv1unMsen07TJO/MsmPiJIF70eDHK81PtbNt9gjsVg9c1MK7V3W0gAkdnHnxZth75KQMdh0yy8zEFR6F8R0IbUbpuIDzGHP4tfDIhZyuCBwW66IpnsRX5YDC8iDj5/gnIyqao1cfVcWQu9XLkaNqUdAV9z6SFE2vrFxuxIu15uie8+Zi2UKOyLKBpmBsGu9BhLVolZUKbxy1KHJI9Ws78WdF7ZlJhfUX6/QBZkKBDq0WqPwoa8W0gMMUzj9zqHyoogsY1tRweca+MLZy2cQ9akA9VgE4hflr6IosqXaI5/RxfapVHiuEOsiK/qOOJP5TYt5Ig8ll+fIxaijpIFWAG05kk1F45kzasOAKaErTManriRUuhEQZjO+hNJQ1/vQY8RtOjRGX1nGfjV6vmiWggGxOXREFRROZIc41lH87GZgzKY9J5VX2Yo2C3tRPLlOjQKEHIOrNI8H/VfjIL4ClOm97f7ZZTJeHpB+1oGUGQkRMA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:06.4833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 369bb87a-7f8a-4155-a2e7-08dd87edc6a3
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2138
X-BESS-ID: 1746020954-305429-7660-9229-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYWBkZAVgZQMDnVINHEwMLCzD
 Q51dLcJDUxJdU42dDEwtTUPCUlLdlAqTYWAJp/akdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan22-232.eu-central-1b.ess.aws.cudaops.com]
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

