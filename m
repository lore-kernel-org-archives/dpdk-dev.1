Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF77CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:38:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B95740E1E;
	Mon, 20 Oct 2025 18:36:50 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id A0A17406B8
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:41 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020138.outbound.protection.outlook.com
 [52.101.84.138]) by mx-outbound44-20.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGFnRXqL8gmGBO9yqHWhQZhNRy12Ay+IZn8NpeaZKnQ7TZQZu/iRQ4+UOfAjCg2aYmQ2bjbfHUHG+4FG50uJX+rtC54372IZnH75n19gH9WwWNWmpJTTunRmKZ+IZuGjYXlN+w5eOvq8alyBg3AxgpWJfp2OUJAvSX1p4N4aqSehTGI4f1Uaw3PRk1dtpSQWeW+ogcIlNKy98tez5/3+SWUEuUIfM3p7HAVLeFOMJD96Cfbyb8JkX4MeWGENFIilERZu+VqVEAEoZPJz0FnSX84b8qMx0YI6PyRZN/KRVoVTIsjxsMqPeEKvxkp7xEyfNbTgn6F3E+DC+bKOw0cDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOTra67tPlMHO49znVXTJICqubhbubTOjGQ3sjC07iY=;
 b=QwjwecT6CxZ8LJzsigqYzKSFRUbSAQ682VdlB8nWredwO5spOcZ5q5V03TC6iyuEcOmGDKlWWhcpYORx85lPvKv0l+lWDUfLJ0nyJTeIjDDd5aFn4Mtld+1Q34jSm8xNzteKQ29vzYZva1Wyyanxdd+4c5dDCg2xgdhuxxuu+4lXiEQc6Q3YmOQX2Dc6dK2RlHI0++EDSYr5vRR+6dYvvUv3nhSRdSTapgvGOOp/BYixium09SisYo/69SVHBFTYHgoL8JhLSf31msgibfqaFNFXo+RN6rUGEpPjsZn18dpnJtp29ve+AOtzV2lzZrFogVpNJxaOGWZttuuefIaEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOTra67tPlMHO49znVXTJICqubhbubTOjGQ3sjC07iY=;
 b=OdG2YBKKHKJdMHXQgeCkGK46DmHrCzjDUU03xNAOIgj0vBy/itOgX30Zwye1uoP6jlFD5ZC1zmgAAM08c9uqUZsi8lu+6S6Bbw6ynOp4twf6i624R2iKkaE7ttYnHCJElhEttV3BPMMppyNtXr2lKj1V3M3jUDrKxtvtj3vLgjk=
Received: from AS4P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::10)
 by VI1P190MB0621.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:12a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.7; Mon, 20 Oct
 2025 16:36:33 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::aa) by AS4P191CA0027.outlook.office365.com
 (2603:10a6:20b:5d9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:33
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 09/24] net/ntnic: single file function as static
Date: Mon, 20 Oct 2025 18:36:00 +0200
Message-ID: <20251020163620.282312-10-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VI1P190MB0621:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c7477742-c5b6-4486-7b6d-08de0ff6d480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PPLyTM08GBw+dS9A3HW3iFdo2Janbbj6sz1io49Vuq8t8HFsfPLO1KqU1Xe9?=
 =?us-ascii?Q?1b5cvsFS7FtOjP0sbeedgP4IwJ8e0WnWHX0XvwSqADpr+33NUuryJwkV1fap?=
 =?us-ascii?Q?2Omxj53WdM/5tNhGDrHyPMOePb2mJ/fc8Mw6RXrbr+FijmuUHWoQwREBWX5U?=
 =?us-ascii?Q?7CoqmkubB/hDoN3vECQFYIL4uUI1WWboeT7Do+ju7n5+zIr8mcsOMcXTpSui?=
 =?us-ascii?Q?WTSzoFjFfqMCuh8iO8c9h5Ehz7USQOsv2NWxd0HSUHnJIungzqiMYyDa3iTf?=
 =?us-ascii?Q?6mZCGvqMmbBMzKBljNqbDR64vCPCYltOS20UcC/dwdX9xRXGgKbFREi/dzyJ?=
 =?us-ascii?Q?tFXcsn8+HqMp/mda+cAmlG9Op1JzokjgKiZKvmC/BmzRj+vir0C+WED/sHDb?=
 =?us-ascii?Q?06rPKxy1Qr6E2v99ab1OI708aDbkf+pyvwOowAF30IdTqbakrXCezVt5+11m?=
 =?us-ascii?Q?XwjXQ3J81I0NKuSOubfzXP+YuFyOqcmqIxVa5j1skrAsmxce1tZKH8/t9Gqh?=
 =?us-ascii?Q?KGFj0cJeH5habUpiDh3A/JD37e1yuf/ZlFfNqUlHVJPptY3VttVXAZmp+4s9?=
 =?us-ascii?Q?paUdxd2mrgE8RM2r1FIIDR+Hwnz8A7ip/2gyJXCtduOOcMqWsDz4NUt+2jvx?=
 =?us-ascii?Q?9k82HaGhLsm0vMCVEmBctihEZNtkKzMX/fTQ6OKruCawqWjINHIMtdhb+p1M?=
 =?us-ascii?Q?O+yOh2BvkAqN30tp6vARvl5H/ewEHsXR1cVxo4aoZ9PoUiJ0oIZD0OMCJYKu?=
 =?us-ascii?Q?B0fJ82IOdByZNowF+YWukVD8cRW3nNDNpkG+JrQDXHMwh7Gj4MNrMIeqfmqY?=
 =?us-ascii?Q?YpnMGCkzeAaTQ6Y2e03KW7iUroAlIvHy2tmzzYTh80ljGfk3fYVuBPA/J6s/?=
 =?us-ascii?Q?6wj7rXf8cBaTTN80FH4KPtcChd4+aUKPEnAsQ41XA7dZ87gcSvn9NnwoorQE?=
 =?us-ascii?Q?IaM0itVcJc4wwzQZEb5uBjkIrxRsJaBt1beqx73j6EaGkOWAIaEaQbZ/gZSg?=
 =?us-ascii?Q?JgxrN6hzBXBzBBt8suLZBspuv34qxjH76oI5fNUxF30bMVxiVGmRpBwCUu9v?=
 =?us-ascii?Q?XQIxmVn55RDrx6ej7gnRYyV6wqwqQEnAxyCclo9rDQSCw9ig42aR0gkJPxkI?=
 =?us-ascii?Q?FZQpQeSXmFSJjcTN7l52PzgAnp3YNoIzqyNm2CweMQZxf9FlsD3cvyS9rhdc?=
 =?us-ascii?Q?GS9yWJcJRyg+TJIYgbbfn4EPkjtgnvNiqBV3wv3yCrmoPb0p5zj4kqU6nV1D?=
 =?us-ascii?Q?AwWkvoUiRPlGK/Ma/SanCqg5jsJ2ETroruz8cmrruRx3E3YOBLiEEmi10/f5?=
 =?us-ascii?Q?ppbQYcKw3318Iiz98ycr3jNuz/UbTOIVjpO0NRhMmuJ0Ub+UJoJZ0c7XzUgG?=
 =?us-ascii?Q?MVvDOYzyYSbhB7I4SmNg/SerDiJ8ev4l5L1+69xk8dNtXcaOb3n/I/bqfLHR?=
 =?us-ascii?Q?IqrAUExmAEtmnFBA+uH4IAomGy/MXjy1Vq4wL62tsi898evJ1Ya3eKtkzMaG?=
 =?us-ascii?Q?CmxLBDwE1pBG6wDS565kbvekVCWCTzcNCz1NbYZMiJ8/wBBtqH82Qc0vFGpn?=
 =?us-ascii?Q?t9tq5YjraaGJ6yUu504=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ijsrs5Ax9sMswlfk8B3yDvjK11cq9FAepg67lWxLSfU2XDCPfuefLU+mzzOeuT9qXQyoLrVNMcIlw5JkBTohvuWSyXGr3Xiq8Ziv/3p1wI5FQIL/51uvfQSbL6to3AmWSYuZa1ztqyJeHy9QCcXASz13YJPZTb3c0e7V24+PAG7pLDmIeUkCO1I67Q27MZLcPFyvGCHC9yWaRUz9LTXVOwur1m9XKz6uTRlfM3W3VdeSfRTKmKHIsAQc5KBuxEPIc1B40gUTghZwA0ab4yGi+1FQS1SB6C6/RF8Ei0vld8oFxi3PEnRv/7DIIeO8L8OjfWbpYqAsBJJSZmqHgd0UXUG8mZr1AXCCzciIWgMfdMh99vqQ8BST75+grFBfWWHUMpUVT04H9bW6bqa41rR2KFHecFioyAFA34k/Jj8lo6cslKJIa06dYq8tC+dH5/6urQebuEfOq/tyouuKCmV22vmarvYjTFprPPYy3yrMqnySzBcD/wXVKlT515wD8ca+6a0ZIOGmSp/MARkaklrHxX8ruOhl4cRkP/MD4eLeLTiCxw9sGNlP0zJLp5LuDkFQ9oYikMYlHQQMuvK9HkmrGAl9j//YA2EVyH8oQyn9KKHEpUvHIXXTCLV2Wbp0zxjoGm04wWpfV9nJ8vx4UnjIAOZcueuY+OxYBUFGavXZNZQ=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:33.3652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7477742-c5b6-4486-7b6d-08de0ff6d480
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0621
X-BESS-ID: 1760978196-311284-32706-8204-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.84.138
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGZmaGBkB2BlDYINXMIinVzD
 I50TTN0DzRPM0ozcjEwCLJPMnIwizV3EypNhYAsnF7x0MAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan12-246.eu-central-1a.ess.aws.cudaops.com]
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

Refactoring:  make single file functions static
to avoid namespace pollution.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/create_elements.h   |   9 -
 drivers/net/ntnic/include/flow_api.h          |   2 -
 drivers/net/ntnic/include/hw_mod_backend.h    |  15 -
 drivers/net/ntnic/nim/i2c_nim.c               |   4 +-
 .../net/ntnic/nthw/core/include/nthw_fpga.h   |   2 -
 .../net/ntnic/nthw/core/include/nthw_hif.h    |  12 -
 .../net/ntnic/nthw/core/include/nthw_iic.h    |   9 -
 .../ntnic/nthw/core/include/nthw_mac_pcs.h    |   9 -
 .../net/ntnic/nthw/core/include/nthw_pcie3.h  |  13 -
 .../nthw/core/include/nthw_pcm_nt400dxx.h     |   1 -
 .../ntnic/nthw/core/include/nthw_phy_tile.h   |   2 -
 .../net/ntnic/nthw/core/include/nthw_rpf.h    |   2 -
 .../net/ntnic/nthw/core/include/nthw_si5340.h |   2 -
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |   2 +-
 drivers/net/ntnic/nthw/core/nthw_hif.c        |  10 +-
 drivers/net/ntnic/nthw/core/nthw_iic.c        | 238 ++++-----
 drivers/net/ntnic/nthw/core/nthw_mac_pcs.c    |  52 +-
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      |  11 +-
 .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |   2 +-
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |   5 +-
 drivers/net/ntnic/nthw/core/nthw_rpf.c        |   4 +-
 drivers/net/ntnic/nthw/core/nthw_si5340.c     |   2 +-
 drivers/net/ntnic/nthw/flow_api/flow_api.c    | 125 ++---
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c   | 226 ++++----
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_km.c    |  79 +--
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c   |  30 +-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c   |   4 +-
 .../profile_inline/flow_api_hw_db_inline.c    | 461 +++++++++--------
 .../profile_inline/flow_api_hw_db_inline.h    |  53 --
 .../net/ntnic/nthw/model/nthw_fpga_model.c    | 485 +++++++++---------
 .../net/ntnic/nthw/model/nthw_fpga_model.h    |  28 -
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |   9 +-
 drivers/net/ntnic/ntnic_vfio.c                |   2 +-
 drivers/net/ntnic/ntnic_vfio.h                |   2 -
 drivers/net/ntnic/ntutil/nt_util.c            |   4 +-
 drivers/net/ntnic/ntutil/nt_util.h            |   3 -
 36 files changed, 887 insertions(+), 1032 deletions(-)

diff --git a/drivers/net/ntnic/include/create_elements.h b/drivers/net/ntnic/include/create_elements.h
index dac2cd7cc9..7593ab4687 100644
--- a/drivers/net/ntnic/include/create_elements.h
+++ b/drivers/net/ntnic/include/create_elements.h
@@ -60,13 +60,4 @@ enum nt_rte_flow_item_type {
 
 extern rte_spinlock_t flow_lock;
 
-int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_flow_item *out);
-int nthw_create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr);
-int nthw_create_match_elements(struct cnv_match_s *match, const struct rte_flow_item items[],
-	int max_elem);
-int nthw_create_action_elements_inline(struct cnv_action_s *action,
-	const struct rte_flow_action actions[],
-	int max_elem,
-	uint32_t queue_offset);
-
 #endif	/* __CREATE_ELEMENTS_H__ */
diff --git a/drivers/net/ntnic/include/flow_api.h b/drivers/net/ntnic/include/flow_api.h
index f80414a185..582de3b281 100644
--- a/drivers/net/ntnic/include/flow_api.h
+++ b/drivers/net/ntnic/include/flow_api.h
@@ -27,8 +27,6 @@ struct hw_mod_resource_s {
 /*
  * Device Management API
  */
-int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev);
-
 /**
  * A structure used to configure the Receive Side Scaling (RSS) feature
  * of an Ethernet port.
diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index f7d4085e5c..455bc7236e 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -415,14 +415,6 @@ int hw_mod_cat_cot_flush(struct flow_api_backend_s *be, int start_idx, int count
 int hw_mod_cat_cot_set(struct flow_api_backend_s *be, enum hw_cat_e field, int index,
 	uint32_t value);
 
-int hw_mod_cat_cct_flush(struct flow_api_backend_s *be, int start_idx, int count);
-
-int hw_mod_cat_kcc_flush(struct flow_api_backend_s *be, int start_idx, int count);
-
-int hw_mod_cat_exo_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_cat_rck_flush(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_cat_len_flush(struct flow_api_backend_s *be, int start_idx, int count);
-
 struct km_func_s {
 	COMMON_FUNC_INFO_S;
 	uint32_t nb_categories;
@@ -531,9 +523,6 @@ int hw_mod_km_tci_flush(struct flow_api_backend_s *be, int start_bank, int start
 	int count);
 int hw_mod_km_tci_set(struct flow_api_backend_s *be, enum hw_km_e field, int bank, int record,
 	uint32_t value);
-int hw_mod_km_tcq_flush(struct flow_api_backend_s *be, int start_bank, int start_record,
-	int count);
-
 struct flm_func_s {
 	COMMON_FUNC_INFO_S;
 	uint32_t nb_categories;
@@ -874,8 +863,6 @@ int hw_mod_pdb_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count
 int hw_mod_pdb_rcp_set(struct flow_api_backend_s *be, enum hw_pdb_e field, uint32_t index,
 	uint32_t value);
 
-int hw_mod_pdb_config_flush(struct flow_api_backend_s *be);
-
 struct tpe_func_s {
 	COMMON_FUNC_INFO_S;
 	uint32_t nb_rcp_categories;
@@ -961,8 +948,6 @@ int hw_mod_tpe_ifr_rcp_set(struct flow_api_backend_s *be, enum hw_tpe_e field, i
 	uint32_t value);
 
 int hw_mod_tpe_ifr_counters_update(struct flow_api_backend_s *be, int start_idx, int count);
-int hw_mod_tpe_ifr_counters_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
-	uint32_t value);
 int hw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t *value);
 
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 66729e3ab4..4fd882b8c9 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -13,7 +13,7 @@
 #include "qsfp_registers.h"
 #include "nim_defines.h"
 
-int nim_agx_read_id(struct nim_i2c_ctx *ctx);
+static int nim_agx_read_id(struct nim_i2c_ctx *ctx);
 static void nim_agx_read(struct nim_i2c_ctx *ctx, uint8_t dev_addr, uint8_t reg_addr,
 	uint8_t data_len, void *p_data);
 static void nim_agx_write(struct nim_i2c_ctx *ctx, uint8_t dev_addr, uint8_t reg_addr,
@@ -931,7 +931,7 @@ static void nim_agx_write(struct nim_i2c_ctx *ctx,
 	rte_spinlock_unlock(&p_nt_i2cm->i2cmmutex);
 }
 
-int nim_agx_read_id(struct nim_i2c_ctx *ctx)
+static int nim_agx_read_id(struct nim_i2c_ctx *ctx)
 {
 	nim_agx_read(ctx, 0xA0, 0, sizeof(ctx->nim_id), &ctx->nim_id);
 	return 0;
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
index 418aea8277..fb47807a2f 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
@@ -16,8 +16,6 @@
 int nthw_fpga_init(struct fpga_info_s *p_fpga_info);
 int nthw_fpga_shutdown(struct fpga_info_s *p_fpga_info);
 
-int nthw_fpga_get_param_info(struct fpga_info_s *p_fpga_info, nthw_fpga_t *p_fpga);
-
 int nthw_fpga_avr_probe(nthw_fpga_t *p_fpga, const int n_instance_no);
 
 int nthw_fpga_iic_scan(nthw_fpga_t *p_fpga, const int n_instance_no_begin,
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_hif.h b/drivers/net/ntnic/nthw/core/include/nthw_hif.h
index 7d5e1f1310..f91f7759a7 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_hif.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_hif.h
@@ -137,18 +137,6 @@ int nthw_hif_init(nthw_hif_t *p, nthw_fpga_t *p_fpga, int n_instance);
 int nthw_hif_trigger_sample_time(nthw_hif_t *p);
 int nthw_hif_force_soft_reset(nthw_hif_t *p);
 
-int nthw_hif_stat_req_enable(nthw_hif_t *p);
-int nthw_hif_stat_req_disable(nthw_hif_t *p);
-
-int nthw_hif_get_stat(nthw_hif_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
-	uint32_t *p_ref_clk_cnt, uint32_t *p_tg_unit_size, uint32_t *p_tg_ref_freq,
-	uint64_t *p_tags_in_use, uint64_t *p_rd_err, uint64_t *p_wr_err);
-int nthw_hif_get_stat_rate(nthw_hif_t *p, uint64_t *p_pci_rx_rate, uint64_t *p_pci_tx_rate,
-	uint64_t *p_ref_clk_cnt, uint64_t *p_tags_in_use,
-	uint64_t *p_rd_err_cnt, uint64_t *p_wr_err_cnt);
-
-int nthw_hif_end_point_counters_sample(nthw_hif_t *p, struct nthw_hif_end_point_counters *epc);
-
 int nthw_hif_read_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t *p_value);
 int nthw_hif_write_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t value);
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_iic.h b/drivers/net/ntnic/nthw/core/include/nthw_iic.h
index 41574f51f3..f6dec4a938 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_iic.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_iic.h
@@ -85,16 +85,7 @@ int nthw_iic_set_retry_params(nthw_iic_t *p, const int n_poll_delay, const int n
 
 int nthw_iic_read_data(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
 	void *p_void);
-int nthw_iic_readbyte(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
-	uint8_t *p_byte);
 int nthw_iic_write_data(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
 	void *p_void);
-int nthw_iic_writebyte(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
-	uint8_t *p_byte);
-bool nthw_iic_bus_ready(nthw_iic_t *p);
-bool nthw_iic_data_ready(nthw_iic_t *p);
-
 int nthw_iic_scan(nthw_iic_t *p);
-int nthw_iic_scan_dev_addr(nthw_iic_t *p, int n_dev_addr, int n_reg_addr);
-
 #endif	/* __NTHW_IIC_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h b/drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h
index 8d0e81bd73..a4119e4efe 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h
@@ -198,14 +198,12 @@ typedef struct nthw_mac_pcs nthw_mac_pcs_t;
 
 int nthw_mac_pcs_init(nthw_mac_pcs_t *p, nthw_fpga_t *p_fpga, int n_instance);
 
-void nthw_mac_pcs_tx_path_rst(nthw_mac_pcs_t *p, bool enable);
 void nthw_mac_pcs_rx_path_rst(nthw_mac_pcs_t *p, bool enable);
 bool nthw_mac_pcs_is_rx_path_rst(nthw_mac_pcs_t *p);
 /* wrapper - for ease of use */
 void nthw_mac_pcs_set_rx_enable(nthw_mac_pcs_t *p, bool enable);
 void nthw_mac_pcs_set_tx_enable(nthw_mac_pcs_t *p, bool enable);
 void nthw_mac_pcs_set_tx_sel_host(nthw_mac_pcs_t *p, bool enable);
-void nthw_mac_pcs_set_tx_sel_tfg(nthw_mac_pcs_t *p, bool enable);
 void nthw_mac_pcs_set_ts_eop(nthw_mac_pcs_t *p, bool enable);
 void nthw_mac_pcs_set_host_loopback(nthw_mac_pcs_t *p, bool enable);
 void nthw_mac_pcs_set_line_loopback(nthw_mac_pcs_t *p, bool enable);
@@ -240,11 +238,4 @@ void nthw_mac_pcs_swap_gty_rx_polarity(nthw_mac_pcs_t *p, uint8_t lane, bool swa
 void nthw_mac_pcs_set_receiver_equalization_mode(nthw_mac_pcs_t *p, uint8_t mode);
 void nthw_mac_pcs_set_led_mode(nthw_mac_pcs_t *p, uint8_t mode);
 void nthw_mac_pcs_set_timestamp_comp_rx(nthw_mac_pcs_t *p, uint16_t rx_dly);
-void nthw_mac_pcs_set_port_no(nthw_mac_pcs_t *p, uint8_t port_no);
-
-uint32_t nthw_mac_pcs_get_fld_block_lock_lock(nthw_mac_pcs_t *p);
-uint32_t nthw_mac_pcs_get_fld_block_lock_lock_mask(nthw_mac_pcs_t *p);
-uint32_t nthw_mac_pcs_get_fld_lane_lock_lock(nthw_mac_pcs_t *p);
-uint32_t nthw_mac_pcs_get_fld_lane_lock_lock_mask(nthw_mac_pcs_t *p);
-
 #endif	/* NTHW_MAC_PCS_H_ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcie3.h b/drivers/net/ntnic/nthw/core/include/nthw_pcie3.h
index 846c09b1b9..21b5d7d22a 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcie3.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcie3.h
@@ -80,17 +80,4 @@ int nthw_pcie3_init(nthw_pcie3_t *p, nthw_fpga_t *p_fpga, int n_instance);
 
 int nthw_pcie3_trigger_sample_time(nthw_pcie3_t *p);
 
-int nthw_pcie3_stat_req_enable(nthw_pcie3_t *p);
-int nthw_pcie3_stat_req_disable(nthw_pcie3_t *p);
-
-int nthw_pcie3_get_stat(nthw_pcie3_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
-	uint32_t *p_ref_clk_cnt, uint32_t *p_tg_unit_size, uint32_t *p_tg_ref_freq,
-	uint32_t *p_tag_use_cnt, uint32_t *p_rq_rdy_cnt, uint32_t *p_rq_vld_cnt);
-int nthw_pcie3_get_stat_rate(nthw_pcie3_t *p, uint64_t *p_pci_rx_rate, uint64_t *p_pci_tx_rate,
-	uint64_t *p_ref_clk_cnt, uint64_t *p_tag_use_cnt,
-	uint64_t *p_pci_nt_bus_util, uint64_t *p_pci_xil_bus_util);
-
-int nthw_pcie3_end_point_counters_sample_post(nthw_pcie3_t *p,
-	struct nthw_hif_end_point_counters *epc);
-
 #endif	/* __NTHW_PCIE3_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
index 47d2670cf5..312dfff974 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
@@ -34,7 +34,6 @@ nthw_pcm_nt400dxx_t *nthw_pcm_nt400dxx_new(void);
 int nthw_pcm_nt400dxx_init(nthw_pcm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_instance);
 void nthw_pcm_nt400dxx_set_ts_pll_recal(nthw_pcm_nt400dxx_t *p, uint32_t val);
 bool nthw_pcm_nt400dxx_get_ts_pll_locked_stat(nthw_pcm_nt400dxx_t *p);
-bool nthw_pcm_nt400dxx_get_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p);
 void nthw_pcm_nt400dxx_set_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p, uint32_t val);
 
 #endif	/* __NTHW_PCM_NT400DXX_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
index c4ec100c23..c35d39e61d 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -133,8 +133,6 @@ bool nthw_phy_tile_get_rx_am_lock(nthw_phy_tile_t *p, uint8_t intf_no);
 void nthw_phy_tile_set_timestamp_comp_rx(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t value);
 uint32_t nthw_phy_tile_get_timestamp_comp_rx(nthw_phy_tile_t *p, uint8_t intf_no);
 
-uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address);
-void nthw_phy_tile_write_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address, uint32_t data);
 bool nthw_phy_tile_configure_fec(nthw_phy_tile_t *p, uint8_t intf_no, bool enable);
 uint32_t nthw_phy_tile_read_xcvr(nthw_phy_tile_t *p, uint8_t intf_no, uint8_t lane,
 	uint32_t address);
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_rpf.h b/drivers/net/ntnic/nthw/core/include/nthw_rpf.h
index f893ac1c47..4916fb926e 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_rpf.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_rpf.h
@@ -37,9 +37,7 @@ typedef struct nthw_rpf nthw_rpf_t;
 typedef struct nthw_rpf nt_rpf;
 
 nthw_rpf_t *nthw_rpf_new(void);
-void nthw_rpf_delete(nthw_rpf_t *p);
 int nthw_rpf_init(nthw_rpf_t *p, nthw_fpga_t *p_fpga, int n_instance);
-void nthw_rpf_administrative_block(nthw_rpf_t *p);
 void nthw_rpf_block(nthw_rpf_t *p);
 void nthw_rpf_unblock(nthw_rpf_t *p);
 void nthw_rpf_set_maturing_delay(nthw_rpf_t *p, int32_t delay);
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_si5340.h b/drivers/net/ntnic/nthw/core/include/nthw_si5340.h
index f56883d99a..0e11855b92 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_si5340.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_si5340.h
@@ -25,8 +25,6 @@ nthw_si5340_t *nthw_si5340_new(void);
 int nthw_si5340_init(nthw_si5340_t *p, nthw_iic_t *p_nthw_iic, uint8_t n_iic_addr);
 void nthw_si5340_delete(nthw_si5340_t *p);
 
-int nthw_si5340_config(nthw_si5340_t *p, const void *p_data, int data_cnt,
-	clk_profile_data_fmt_t data_format);
 int nthw_si5340_config_fmt2(nthw_si5340_t *p, const clk_profile_data_fmt2_t *p_data,
 	const int data_cnt);
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index b74a1607fd..9153b31cea 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -18,7 +18,7 @@
 
 #include <arpa/inet.h>
 
-int nthw_fpga_get_param_info(struct fpga_info_s *p_fpga_info, nthw_fpga_t *p_fpga)
+static int nthw_fpga_get_param_info(struct fpga_info_s *p_fpga_info, nthw_fpga_t *p_fpga)
 {
 	mcu_info_t *p_mcu_info = &p_fpga_info->mcu_info;
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index f2d6f372b0..2899c3706b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -217,7 +217,7 @@ int nthw_hif_trigger_sample_time(nthw_hif_t *p)
 	return 0;
 }
 
-int nthw_hif_get_stat(nthw_hif_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
+static int nthw_hif_get_stat(nthw_hif_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
 	uint32_t *p_ref_clk_cnt, uint32_t *p_tg_unit_size, uint32_t *p_tg_ref_freq,
 	uint64_t *p_tags_in_use, uint64_t *p_rd_err, uint64_t *p_wr_err)
 {
@@ -241,7 +241,7 @@ int nthw_hif_get_stat(nthw_hif_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
 	return 0;
 }
 
-int nthw_hif_get_stat_rate(nthw_hif_t *p, uint64_t *p_pci_rx_rate, uint64_t *p_pci_tx_rate,
+static int nthw_hif_get_stat_rate(nthw_hif_t *p, uint64_t *p_pci_rx_rate, uint64_t *p_pci_tx_rate,
 	uint64_t *p_ref_clk_cnt, uint64_t *p_tags_in_use,
 	uint64_t *p_rd_err_cnt, uint64_t *p_wr_err_cnt)
 {
@@ -280,7 +280,7 @@ int nthw_hif_get_stat_rate(nthw_hif_t *p, uint64_t *p_pci_rx_rate, uint64_t *p_p
 	return 0;
 }
 
-int nthw_hif_stat_req_enable(nthw_hif_t *p)
+static int nthw_hif_stat_req_enable(nthw_hif_t *p)
 {
 	nthw_field_set_all(p->mp_fld_stat_ctrl_ena);
 	nthw_field_set_all(p->mp_fld_stat_ctrl_req);
@@ -288,7 +288,7 @@ int nthw_hif_stat_req_enable(nthw_hif_t *p)
 	return 0;
 }
 
-int nthw_hif_stat_req_disable(nthw_hif_t *p)
+static int nthw_hif_stat_req_disable(nthw_hif_t *p)
 {
 	nthw_field_clr_all(p->mp_fld_stat_ctrl_ena);
 	nthw_field_set_all(p->mp_fld_stat_ctrl_req);
@@ -296,7 +296,7 @@ int nthw_hif_stat_req_disable(nthw_hif_t *p)
 	return 0;
 }
 
-int nthw_hif_end_point_counters_sample(nthw_hif_t *p, struct nthw_hif_end_point_counters *epc)
+static int nthw_hif_end_point_cntrs_sample(nthw_hif_t *p, struct nthw_hif_end_point_counters *epc)
 {
 	RTE_ASSERT(epc);
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_iic.c b/drivers/net/ntnic/nthw/core/nthw_iic.c
index a96d878f25..7a2247e371 100644
--- a/drivers/net/ntnic/nthw/core/nthw_iic.c
+++ b/drivers/net/ntnic/nthw/core/nthw_iic.c
@@ -271,50 +271,76 @@ int nthw_iic_set_retry_params(nthw_iic_t *p, const int n_poll_delay, const int n
 	return 0;
 }
 
-int nthw_iic_read_data(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
-	void *p_void)
+/*
+ * Support function for read/write functions below. Waits for bus ready.
+ */
+static bool nthw_iic_bus_ready(nthw_iic_t *p)
 {
-	const char *const p_adapter_id_str = p->mp_fpga->p_fpga_info->mp_adapter_id_str;
-	const int n_debug_mode = nthw_module_get_debug_mode(p->mp_mod_iic);
+	int count = (p->mn_bus_ready_retry >= 0 ? p->mn_bus_ready_retry : 1000);
+	bool b_bus_busy = true;
 
-	uint8_t *pb = (uint8_t *)p_void;
-	int retry = (p->mn_read_data_retry >= 0 ? p->mn_read_data_retry : 10);
+	while (true) {
+		nthw_iic_reg_busbusy(p, &b_bus_busy);
 
-	if (n_debug_mode == 0xff) {
-		NT_LOG(DBG, NTHW, "%s: adr=0x%2.2x, reg=%d, len=%d", p_adapter_id_str, dev_addr,
-			a_reg_addr, data_len);
-	}
+		if (!b_bus_busy)
+			break;
 
-	while (nthw_iic_readbyte(p, dev_addr, a_reg_addr, data_len, pb) != 0) {
-		retry--;
+		count--;
 
-		if (retry <= 0) {
-			NT_LOG(ERR, NTHW,
-				"%s: I2C%d: Read retry exhausted (dev_addr=%d a_reg_addr=%d)",
-				p_adapter_id_str, p->mn_iic_instance, dev_addr, a_reg_addr);
-			return -1;
+		if (count <= 0)	/* Test for timeout */
+			break;
 
-		} else {
-			NT_LOG(DBG, NTHW, "%s: I2C%d: Read retry=%d (dev_addr=%d a_reg_addr=%d)",
-				p_adapter_id_str, p->mn_iic_instance, retry, dev_addr, a_reg_addr);
-		}
+		if (p->mn_poll_delay != 0)
+			I2C_WAIT_US(p->mn_poll_delay);
 	}
 
-	if (n_debug_mode == 0xff) {
-		NT_LOG(DBG, NTHW, "%s: adr=0x%2.2x, reg=%d, len=%d, retries remaining: %d",
-			p_adapter_id_str, dev_addr, a_reg_addr, data_len, retry);
+	if (count == 0)
+		return false;
+
+	return true;
+}
+
+/*
+ * Support function for read function. Waits for data ready.
+ */
+static bool nthw_iic_data_ready(nthw_iic_t *p)
+{
+	int count = (p->mn_data_ready_retry >= 0 ? p->mn_data_ready_retry : 1000);
+	bool b_rx_fifo_empty = true;
+
+	while (true) {
+		nthw_iic_reg_rxfifo_empty(p, &b_rx_fifo_empty);
+
+		if (!b_rx_fifo_empty)
+			break;
+
+		count--;
+
+		if (count <= 0)	/* Test for timeout */
+			break;
+
+		if (p->mn_poll_delay != 0)
+			I2C_WAIT_US(p->mn_poll_delay);
 	}
 
-	return 0;
+	if (count == 0)
+		return false;
+
+	return true;
 }
 
-int nthw_iic_readbyte(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
+static int nthw_iic_writebyte(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
 	uint8_t *p_byte)
 {
 	const char *const p_adapter_id_str = p->mp_fpga->p_fpga_info->mp_adapter_id_str;
-
 	uint32_t value;
-	uint32_t i;
+	int count;
+	int i;
+
+	if (data_len == 0)
+		return -1;
+
+	count = data_len - 1;
 
 	if (nthw_iic_bus_ready(p)) {
 		/* Reset TX fifo */
@@ -325,38 +351,34 @@ int nthw_iic_readbyte(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8
 		nthw_iic_reg_tx_fifo_write(p, value, 1, 0);
 
 		/* Write a_reg_addr to TX FIFO */
-		nthw_iic_reg_tx_fifo_write(p, a_reg_addr, 0, 1);
+		nthw_iic_reg_tx_fifo_write(p, a_reg_addr, 0, 0);
 
-		if (!nthw_iic_bus_ready(p)) {
-			NT_LOG_DBGX(ERR, NTHW, "%s: error:", p_adapter_id_str);
-			return -1;
+		for (i = 0; i < count; i++) {
+			/* Write data byte to TX fifo and set stop bit */
+			nthw_iic_reg_tx_fifo_write(p, *p_byte, 0, 0);
+			p_byte++;
 		}
 
-		/* Write device address + RD bit to TX_FIFO and set start bit!! */
-		value = (dev_addr << 1) | I2C_TRANSMIT_RD;
-		nthw_iic_reg_tx_fifo_write(p, value, 1, 0);
-
-		/* Write data_len to TX_FIFO and set stop bit!! */
-		nthw_iic_reg_tx_fifo_write(p, data_len, 0, 1);
+		/* Write data byte to TX fifo and set stop bit */
+		nthw_iic_reg_tx_fifo_write(p, *p_byte, 0, 1);
 
-		for (i = 0; i < data_len; i++) {
-			/* Wait for RX FIFO not empty */
-			if (!nthw_iic_data_ready(p))
-				return -1;
+		if (!nthw_iic_bus_ready(p)) {
+			NT_LOG_DBGX(WRN, NTHW, "%s: warn: !busReady", p_adapter_id_str);
 
-			/* Read data_len bytes from RX_FIFO */
-			nthw_iic_reg_read_i2c_rx_fifo(p, p_byte);
-			p_byte++;
+			while (true)
+				if (nthw_iic_bus_ready(p)) {
+					NT_LOG_DBGX(DBG, NTHW, "%s: info: busReady",
+					p_adapter_id_str);
+					break;
+				}
 		}
 
 		return 0;
 
 	} else {
-		NT_LOG_DBGX(ERR, NTHW, "%s: error", p_adapter_id_str);
+		NT_LOG_DBGX(WRN, NTHW, "%s", p_adapter_id_str);
 		return -1;
 	}
-
-	return 0;
 }
 
 int nthw_iic_write_data(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
@@ -385,18 +407,13 @@ int nthw_iic_write_data(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uin
 	return 0;
 }
 
-int nthw_iic_writebyte(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
+static int nthw_iic_readbyte(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
 	uint8_t *p_byte)
 {
 	const char *const p_adapter_id_str = p->mp_fpga->p_fpga_info->mp_adapter_id_str;
-	uint32_t value;
-	int count;
-	int i;
-
-	if (data_len == 0)
-		return -1;
 
-	count = data_len - 1;
+	uint32_t value;
+	uint32_t i;
 
 	if (nthw_iic_bus_ready(p)) {
 		/* Reset TX fifo */
@@ -407,95 +424,78 @@ int nthw_iic_writebyte(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint
 		nthw_iic_reg_tx_fifo_write(p, value, 1, 0);
 
 		/* Write a_reg_addr to TX FIFO */
-		nthw_iic_reg_tx_fifo_write(p, a_reg_addr, 0, 0);
+		nthw_iic_reg_tx_fifo_write(p, a_reg_addr, 0, 1);
 
-		for (i = 0; i < count; i++) {
-			/* Write data byte to TX fifo and set stop bit */
-			nthw_iic_reg_tx_fifo_write(p, *p_byte, 0, 0);
-			p_byte++;
+		if (!nthw_iic_bus_ready(p)) {
+			NT_LOG_DBGX(ERR, NTHW, "%s: error:", p_adapter_id_str);
+			return -1;
 		}
 
-		/* Write data byte to TX fifo and set stop bit */
-		nthw_iic_reg_tx_fifo_write(p, *p_byte, 0, 1);
+		/* Write device address + RD bit to TX_FIFO and set start bit!! */
+		value = (dev_addr << 1) | I2C_TRANSMIT_RD;
+		nthw_iic_reg_tx_fifo_write(p, value, 1, 0);
 
-		if (!nthw_iic_bus_ready(p)) {
-			NT_LOG_DBGX(WRN, NTHW, "%s: warn: !busReady", p_adapter_id_str);
+		/* Write data_len to TX_FIFO and set stop bit!! */
+		nthw_iic_reg_tx_fifo_write(p, data_len, 0, 1);
 
-			while (true)
-				if (nthw_iic_bus_ready(p)) {
-					NT_LOG_DBGX(DBG, NTHW, "%s: info: busReady",
-					p_adapter_id_str);
-					break;
-				}
+		for (i = 0; i < data_len; i++) {
+			/* Wait for RX FIFO not empty */
+			if (!nthw_iic_data_ready(p))
+				return -1;
+
+			/* Read data_len bytes from RX_FIFO */
+			nthw_iic_reg_read_i2c_rx_fifo(p, p_byte);
+			p_byte++;
 		}
 
 		return 0;
 
 	} else {
-		NT_LOG_DBGX(WRN, NTHW, "%s", p_adapter_id_str);
+		NT_LOG_DBGX(ERR, NTHW, "%s: error", p_adapter_id_str);
 		return -1;
 	}
-}
-
-/*
- * Support function for read/write functions below. Waits for bus ready.
- */
-bool nthw_iic_bus_ready(nthw_iic_t *p)
-{
-	int count = (p->mn_bus_ready_retry >= 0 ? p->mn_bus_ready_retry : 1000);
-	bool b_bus_busy = true;
-
-	while (true) {
-		nthw_iic_reg_busbusy(p, &b_bus_busy);
-
-		if (!b_bus_busy)
-			break;
-
-		count--;
-
-		if (count <= 0)	/* Test for timeout */
-			break;
-
-		if (p->mn_poll_delay != 0)
-			I2C_WAIT_US(p->mn_poll_delay);
-	}
-
-	if (count == 0)
-		return false;
 
-	return true;
+	return 0;
 }
 
-/*
- * Support function for read function. Waits for data ready.
- */
-bool nthw_iic_data_ready(nthw_iic_t *p)
+int nthw_iic_read_data(nthw_iic_t *p, uint8_t dev_addr, uint8_t a_reg_addr, uint8_t data_len,
+	void *p_void)
 {
-	int count = (p->mn_data_ready_retry >= 0 ? p->mn_data_ready_retry : 1000);
-	bool b_rx_fifo_empty = true;
+	const char *const p_adapter_id_str = p->mp_fpga->p_fpga_info->mp_adapter_id_str;
+	const int n_debug_mode = nthw_module_get_debug_mode(p->mp_mod_iic);
 
-	while (true) {
-		nthw_iic_reg_rxfifo_empty(p, &b_rx_fifo_empty);
+	uint8_t *pb = (uint8_t *)p_void;
+	int retry = (p->mn_read_data_retry >= 0 ? p->mn_read_data_retry : 10);
 
-		if (!b_rx_fifo_empty)
-			break;
+	if (n_debug_mode == 0xff) {
+		NT_LOG(DBG, NTHW, "%s: adr=0x%2.2x, reg=%d, len=%d", p_adapter_id_str, dev_addr,
+			a_reg_addr, data_len);
+	}
 
-		count--;
+	while (nthw_iic_readbyte(p, dev_addr, a_reg_addr, data_len, pb) != 0) {
+		retry--;
 
-		if (count <= 0)	/* Test for timeout */
-			break;
+		if (retry <= 0) {
+			NT_LOG(ERR, NTHW,
+				"%s: I2C%d: Read retry exhausted (dev_addr=%d a_reg_addr=%d)",
+				p_adapter_id_str, p->mn_iic_instance, dev_addr, a_reg_addr);
+			return -1;
 
-		if (p->mn_poll_delay != 0)
-			I2C_WAIT_US(p->mn_poll_delay);
+		} else {
+			NT_LOG(DBG, NTHW, "%s: I2C%d: Read retry=%d (dev_addr=%d a_reg_addr=%d)",
+				p_adapter_id_str, p->mn_iic_instance, retry, dev_addr, a_reg_addr);
+		}
 	}
 
-	if (count == 0)
-		return false;
+	if (n_debug_mode == 0xff) {
+		NT_LOG(DBG, NTHW, "%s: adr=0x%2.2x, reg=%d, len=%d, retries remaining: %d",
+			p_adapter_id_str, dev_addr, a_reg_addr, data_len, retry);
+	}
 
-	return true;
+	return 0;
 }
 
-int nthw_iic_scan_dev_addr(nthw_iic_t *p, int n_dev_addr, int n_reg_addr)
+static int nthw_iic_scan_dev_addr(nthw_iic_t *p, int n_dev_addr, int n_reg_addr)
 {
 	const char *const p_adapter_id_str = p->mp_fpga->p_fpga_info->mp_adapter_id_str;
 	(void)p_adapter_id_str;
diff --git a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
index 23ed96e04d..a8d66268ff 100644
--- a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
+++ b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
@@ -16,6 +16,11 @@
 static const uint8_t c_pcs_lanes = NTHW_MAC_PCS_LANES;
 static const uint8_t c_mac_pcs_receiver_mode_dfe;
 
+static void nthw_mac_pcs_set_port_no(nthw_mac_pcs_t *p, uint8_t port_no)
+{
+	p->m_port_no = port_no;
+}
+
 /*
  * Parameters:
  *   p != NULL: init struct pointed to by p
@@ -424,7 +429,7 @@ void nthw_mac_pcs_set_tx_sel_host(nthw_mac_pcs_t *p, bool enable)
 		nthw_field_clr_flush(p->mp_fld_phymac_misc_tx_sel_host);
 }
 
-void nthw_mac_pcs_set_tx_sel_tfg(nthw_mac_pcs_t *p, bool enable)
+static void nthw_mac_pcs_set_tx_sel_tfg(nthw_mac_pcs_t *p, bool enable)
 {
 	nthw_field_get_updated(p->mp_fld_phymac_misc_tx_sel_tfg);
 
@@ -448,7 +453,7 @@ void nthw_mac_pcs_set_ts_eop(nthw_mac_pcs_t *p, bool enable)
 	}
 }
 
-void nthw_mac_pcs_tx_path_rst(nthw_mac_pcs_t *p, bool enable)
+static void nthw_mac_pcs_tx_path_rst(nthw_mac_pcs_t *p, bool enable)
 {
 	nthw_field_get_updated(p->mp_fld_pcs_config_tx_path_rst);
 
@@ -579,21 +584,6 @@ void nthw_mac_pcs_get_link_summary(nthw_mac_pcs_t *p,
 		*p_remote_fault = nthw_field_get_val32(p->mp_fld_link_summary_remote_fault);
 }
 
-/*
- * Returns true if the lane/block lock bits indicate that a reset is required.
- * This is the case if Block/Lane lock is not all zero but not all set either.
- */
-bool nthw_mac_pcs_reset_required(nthw_mac_pcs_t *p)
-{
-	uint32_t block_lock = nthw_mac_pcs_get_fld_block_lock_lock(p);
-	uint32_t lane_lock = nthw_mac_pcs_get_fld_lane_lock_lock(p);
-	uint32_t block_lock_mask = nthw_mac_pcs_get_fld_block_lock_lock_mask(p);
-	uint32_t lane_lock_mask = nthw_mac_pcs_get_fld_lane_lock_lock_mask(p);
-
-	return ((block_lock != 0) && (block_lock != block_lock_mask)) ||
-		((lane_lock != 0) && (lane_lock != lane_lock_mask));
-}
-
 void nthw_mac_pcs_set_fec(nthw_mac_pcs_t *p, bool enable)
 {
 	NT_LOG(DBG, NTHW, "Port %u: Set FEC: %u", p->m_port_no, enable);
@@ -838,27 +828,37 @@ void nthw_mac_pcs_set_timestamp_comp_rx(nthw_mac_pcs_t *p, uint16_t rx_dly)
 	}
 }
 
-void nthw_mac_pcs_set_port_no(nthw_mac_pcs_t *p, uint8_t port_no)
-{
-	p->m_port_no = port_no;
-}
-
-uint32_t nthw_mac_pcs_get_fld_block_lock_lock(nthw_mac_pcs_t *p)
+static uint32_t nthw_mac_pcs_get_fld_block_lock_lock(nthw_mac_pcs_t *p)
 {
 	return nthw_field_get_updated(p->mp_fld_block_lock_lock);
 }
 
-uint32_t nthw_mac_pcs_get_fld_block_lock_lock_mask(nthw_mac_pcs_t *p)
+static uint32_t nthw_mac_pcs_get_fld_block_lock_lock_mask(nthw_mac_pcs_t *p)
 {
 	return p->m_fld_block_lock_lock_mask;
 }
 
-uint32_t nthw_mac_pcs_get_fld_lane_lock_lock(nthw_mac_pcs_t *p)
+static uint32_t nthw_mac_pcs_get_fld_lane_lock_lock(nthw_mac_pcs_t *p)
 {
 	return nthw_field_get_updated(p->mp_fld_vl_demuxed_lock);
 }
 
-uint32_t nthw_mac_pcs_get_fld_lane_lock_lock_mask(nthw_mac_pcs_t *p)
+static uint32_t nthw_mac_pcs_get_fld_lane_lock_lock_mask(nthw_mac_pcs_t *p)
 {
 	return p->m_fld_vl_demuxed_lock_mask;
 }
+
+/*
+ * Returns true if the lane/block lock bits indicate that a reset is required.
+ * This is the case if Block/Lane lock is not all zero but not all set either.
+ */
+bool nthw_mac_pcs_reset_required(nthw_mac_pcs_t *p)
+{
+	uint32_t block_lock = nthw_mac_pcs_get_fld_block_lock_lock(p);
+	uint32_t lane_lock = nthw_mac_pcs_get_fld_lane_lock_lock(p);
+	uint32_t block_lock_mask = nthw_mac_pcs_get_fld_block_lock_lock_mask(p);
+	uint32_t lane_lock_mask = nthw_mac_pcs_get_fld_lane_lock_lock_mask(p);
+
+	return ((block_lock != 0) && (block_lock != block_lock_mask)) ||
+		((lane_lock != 0) && (lane_lock != lane_lock_mask));
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcie3.c b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
index bad1c31e35..2953896759 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcie3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
@@ -169,7 +169,7 @@ int nthw_pcie3_trigger_sample_time(nthw_pcie3_t *p)
 	return 0;
 }
 
-int nthw_pcie3_stat_req_enable(nthw_pcie3_t *p)
+static int nthw_pcie3_stat_req_enable(nthw_pcie3_t *p)
 {
 	nthw_field_set_all(p->mp_fld_stat_ctrl_ena);
 	nthw_field_set_all(p->mp_fld_stat_ctrl_req);
@@ -177,7 +177,7 @@ int nthw_pcie3_stat_req_enable(nthw_pcie3_t *p)
 	return 0;
 }
 
-int nthw_pcie3_stat_req_disable(nthw_pcie3_t *p)
+static int nthw_pcie3_stat_req_disable(nthw_pcie3_t *p)
 {
 	nthw_field_clr_all(p->mp_fld_stat_ctrl_ena);
 	nthw_field_set_all(p->mp_fld_stat_ctrl_req);
@@ -185,7 +185,7 @@ int nthw_pcie3_stat_req_disable(nthw_pcie3_t *p)
 	return 0;
 }
 
-int nthw_pcie3_get_stat(nthw_pcie3_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
+static int nthw_pcie3_get_stat(nthw_pcie3_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
 	uint32_t *p_ref_clk_cnt, uint32_t *p_tg_unit_size, uint32_t *p_tg_ref_freq,
 	uint32_t *p_tag_use_cnt, uint32_t *p_rq_rdy_cnt, uint32_t *p_rq_vld_cnt)
 {
@@ -205,7 +205,8 @@ int nthw_pcie3_get_stat(nthw_pcie3_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
 	return 0;
 }
 
-int nthw_pcie3_get_stat_rate(nthw_pcie3_t *p, uint64_t *p_pci_rx_rate, uint64_t *p_pci_tx_rate,
+static int nthw_pcie3_get_stat_rate(nthw_pcie3_t *p, uint64_t *p_pci_rx_rate,
+	uint64_t *p_pci_tx_rate,
 	uint64_t *p_ref_clk_cnt, uint64_t *p_tag_use_cnt,
 	uint64_t *p_pci_nt_bus_util, uint64_t *p_pci_xil_bus_util)
 {
@@ -244,7 +245,7 @@ int nthw_pcie3_get_stat_rate(nthw_pcie3_t *p, uint64_t *p_pci_rx_rate, uint64_t
 	return 0;
 }
 
-int nthw_pcie3_end_point_counters_sample_post(nthw_pcie3_t *p,
+static int nthw_pcie3_end_point_counters_sample_post(nthw_pcie3_t *p,
 	struct nthw_hif_end_point_counters *epc)
 {
 	NT_LOG_DBGX(DBG, NTHW);
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
index e7be634a83..9004ebef06 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
@@ -68,7 +68,7 @@ bool nthw_pcm_nt400dxx_get_ts_pll_locked_stat(nthw_pcm_nt400dxx_t *p)
 	return nthw_field_get_updated(p->mp_fld_stat_ts_pll_locked) != 0;
 }
 
-bool nthw_pcm_nt400dxx_get_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p)
+static bool nthw_pcm_nt400dxx_get_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p)
 {
 	return nthw_field_get_updated(p->mp_fld_latch_ts_pll_locked) != 0;
 }
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index 5b2af77f7d..5e8055f0e3 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -954,7 +954,7 @@ uint32_t nthw_phy_tile_get_timestamp_comp_rx(nthw_phy_tile_t *p, uint8_t intf_no
 	return nthw_field_get_val32(p->mp_fld_port_comp_rx_compensation[intf_no]);
 }
 
-uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address)
+static uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address)
 {
 	nthw_register_update(p->mp_reg_port_eth_base[intf_no]);
 	nthw_field_set_val32(p->mp_fld_port_eth_base_cmd[intf_no], 0);
@@ -966,7 +966,8 @@ uint32_t nthw_phy_tile_read_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t ad
 	return nthw_field_get_updated(p->mp_fld_port_eth_data_data[intf_no]);
 }
 
-void nthw_phy_tile_write_eth(nthw_phy_tile_t *p, uint8_t intf_no, uint32_t address, uint32_t data)
+static void nthw_phy_tile_write_eth(nthw_phy_tile_t *p, uint8_t intf_no,
+	uint32_t address, uint32_t data)
 {
 	nthw_field_set_val_flush32(p->mp_fld_port_eth_data_data[intf_no], data);
 	nthw_register_update(p->mp_reg_port_eth_base[intf_no]);
diff --git a/drivers/net/ntnic/nthw/core/nthw_rpf.c b/drivers/net/ntnic/nthw/core/nthw_rpf.c
index d5c19e312b..6f06601de8 100644
--- a/drivers/net/ntnic/nthw/core/nthw_rpf.c
+++ b/drivers/net/ntnic/nthw/core/nthw_rpf.c
@@ -20,7 +20,7 @@ nthw_rpf_t *nthw_rpf_new(void)
 	return p;
 }
 
-void nthw_rpf_delete(nthw_rpf_t *p)
+static void nthw_rpf_delete(nthw_rpf_t *p)
 {
 	free(p);
 }
@@ -67,7 +67,7 @@ int nthw_rpf_init(nthw_rpf_t *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-void nthw_rpf_administrative_block(nthw_rpf_t *p)
+static void nthw_rpf_administrative_block(nthw_rpf_t *p)
 {
 	/* block all MAC ports */
 	nthw_register_update(p->mp_reg_control);
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5340.c b/drivers/net/ntnic/nthw/core/nthw_si5340.c
index ceaa58e0f7..27f8653c9b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5340.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5340.c
@@ -144,7 +144,7 @@ static int nthw_si5340_cfg(nthw_si5340_t *p, const void *p_data, int data_cnt,
 	return 0;
 }
 
-int nthw_si5340_config(nthw_si5340_t *p, const void *p_data, int data_cnt,
+static int nthw_si5340_config(nthw_si5340_t *p, const void *p_data, int data_cnt,
 	clk_profile_data_fmt_t data_format)
 {
 	const char *const p_adapter_id_str =
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 90fc3f51a6..97594bd26d 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -375,68 +375,7 @@ static int nic_remove_eth_port_dev(struct flow_nic_dev *ndev, struct flow_eth_de
 	return -1;
 }
 
-static void flow_ndev_reset(struct flow_nic_dev *ndev)
-{
-	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
-
-	if (profile_inline_ops == NULL) {
-		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
-		return;
-	}
-
-	/* Delete all eth-port devices created on this NIC device */
-	while (ndev->eth_base) {
-		nthw_flow_delete_eth_dev(ndev->eth_base);
-		ndev->eth_base = NULL;
-	}
-
-	/* Error check */
-	while (ndev->flow_base) {
-		NT_LOG(ERR, FILTER,
-			"ERROR : Flows still defined but all eth-ports deleted. Flow %p",
-			ndev->flow_base);
-
-		profile_inline_ops->flow_destroy_profile_inline(ndev->flow_base->dev,
-			ndev->flow_base, NULL);
-	}
-
-	profile_inline_ops->done_flow_management_of_ndev_profile_inline(ndev);
-
-	km_free_ndev_resource_management(&ndev->km_res_handle);
-	kcc_free_ndev_resource_management(&ndev->kcc_res_handle);
-
-	ndev->flow_unique_id_counter = 0;
-
-	/*
-	 * free all resources default allocated, initially for this NIC DEV
-	 * Is not really needed since the bitmap will be freed in a sec. Therefore
-	 * only in debug mode
-	 */
-
-	/* Check if all resources has been released */
-	NT_LOG(DBG, FILTER, "Delete NIC DEV Adaptor %i", ndev->adapter_no);
-
-	for (unsigned int i = 0; i < RES_COUNT; i++) {
-		int err = 0;
-		NT_LOG(DBG, FILTER, "RES state for: %s", dbg_res_descr[i]);
-
-		for (unsigned int ii = 0; ii < ndev->res[i].resource_count; ii++) {
-			int ref = ndev->res[i].ref[ii];
-			int used = flow_nic_is_resource_used(ndev, i, ii);
-
-			if (ref || used) {
-				NT_LOG(DBG, FILTER, "  [%u]: ref cnt %i, used %i", ii, ref,
-					used);
-				err = 1;
-			}
-		}
-
-		if (err)
-			NT_LOG(DBG, FILTER, "ERROR - some resources not freed");
-	}
-}
-
-int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
+static int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 {
 	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
 
@@ -511,6 +450,68 @@ int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 	return 0;
 }
 
+static void flow_ndev_reset(struct flow_nic_dev *ndev)
+{
+	const struct profile_inline_ops *profile_inline_ops = get_profile_inline_ops();
+
+	if (profile_inline_ops == NULL) {
+		NT_LOG(ERR, FILTER, "%s: profile_inline module uninitialized", __func__);
+		return;
+	}
+
+	/* Delete all eth-port devices created on this NIC device */
+	while (ndev->eth_base) {
+		nthw_flow_delete_eth_dev(ndev->eth_base);
+		ndev->eth_base = NULL;
+	}
+
+	/* Error check */
+	while (ndev->flow_base) {
+		NT_LOG(ERR, FILTER,
+			"ERROR : Flows still defined but all eth-ports deleted. Flow %p",
+			ndev->flow_base);
+
+		profile_inline_ops->flow_destroy_profile_inline(ndev->flow_base->dev,
+			ndev->flow_base, NULL);
+	}
+
+	profile_inline_ops->done_flow_management_of_ndev_profile_inline(ndev);
+
+	km_free_ndev_resource_management(&ndev->km_res_handle);
+	kcc_free_ndev_resource_management(&ndev->kcc_res_handle);
+
+	ndev->flow_unique_id_counter = 0;
+
+	/*
+	 * free all resources default allocated, initially for this NIC DEV
+	 * Is not really needed since the bitmap will be freed in a sec. Therefore
+	 * only in debug mode
+	 */
+
+	/* Check if all resources has been released */
+	NT_LOG(DBG, FILTER, "Delete NIC DEV Adaptor %i", ndev->adapter_no);
+
+	for (unsigned int i = 0; i < RES_COUNT; i++) {
+		int err = 0;
+		NT_LOG(DBG, FILTER, "RES state for: %s", dbg_res_descr[i]);
+
+		for (unsigned int ii = 0; ii < ndev->res[i].resource_count; ii++) {
+			int ref = ndev->res[i].ref[ii];
+			int used = flow_nic_is_resource_used(ndev, i, ii);
+
+			if (ref || used) {
+				NT_LOG(DBG, FILTER, "  [%u]: ref cnt %i, used %i", ii, ref,
+					used);
+				err = 1;
+			}
+		}
+
+		if (err)
+			NT_LOG(DBG, FILTER, "ERROR - some resources not freed");
+	}
+}
+
+
 /*
  * Flow API NIC Setup
  * Flow backend creation function - register and initialize common backend API to FPA modules
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
index abe09bfad2..e778c7568a 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
@@ -230,114 +230,6 @@ static int cfn_reset(struct flow_api_backend_s *be, int i)
 	return err;
 }
 
-int hw_mod_cat_reset(struct flow_api_backend_s *be)
-{
-	/* Zero entire cache area */
-	nthw_zero_module_cache((struct common_func_s *)(&be->cat));
-
-	NT_LOG(DBG, FILTER, "INIT CAT CFN");
-
-	if (hw_mod_cat_cfn_flush(be, 0, ALL_ENTRIES))
-		return -1;
-
-	if (_VER_ <= 18) {
-		NT_LOG(DBG, FILTER, "INIT CAT KCE");
-
-		if (hw_mod_cat_kce_flush(be, KM_FLM_IF_FIRST, 0, 0, ALL_ENTRIES))
-			return -1;
-
-		NT_LOG(DBG, FILTER, "INIT CAT KCS");
-
-		if (hw_mod_cat_kcs_flush(be, KM_FLM_IF_FIRST, 0, 0, ALL_ENTRIES))
-			return -1;
-
-		NT_LOG(DBG, FILTER, "INIT CAT FTE");
-
-		if (hw_mod_cat_fte_flush(be, KM_FLM_IF_FIRST, 0, 0, ALL_ENTRIES))
-			return -1;
-
-	} else {
-		NT_LOG(DBG, FILTER, "INIT CAT KCE 0");
-
-		if (hw_mod_cat_kce_flush(be, KM_FLM_IF_FIRST, be->cat.km_if_m0, 0, ALL_ENTRIES))
-			return -1;
-
-		NT_LOG(DBG, FILTER, "INIT CAT KCS 0");
-
-		if (hw_mod_cat_kcs_flush(be, KM_FLM_IF_FIRST, be->cat.km_if_m0, 0, ALL_ENTRIES))
-			return -1;
-
-		NT_LOG(DBG, FILTER, "INIT CAT FTE 0");
-
-		if (hw_mod_cat_fte_flush(be, KM_FLM_IF_FIRST, be->cat.km_if_m0, 0, ALL_ENTRIES))
-			return -1;
-
-		if (be->cat.km_if_count > 1) {
-			NT_LOG(DBG, FILTER, "INIT CAT KCE 1");
-
-			if (hw_mod_cat_kce_flush(be, KM_FLM_IF_SECOND, be->cat.km_if_m1, 0,
-					ALL_ENTRIES))
-				return -1;
-
-			NT_LOG(DBG, FILTER, "INIT CAT KCS 1");
-
-			if (hw_mod_cat_kcs_flush(be, KM_FLM_IF_SECOND, be->cat.km_if_m1, 0,
-					ALL_ENTRIES))
-				return -1;
-
-			NT_LOG(DBG, FILTER, "INIT CAT FTE 1");
-
-			if (hw_mod_cat_fte_flush(be, KM_FLM_IF_SECOND, be->cat.km_if_m1, 0,
-					ALL_ENTRIES))
-				return -1;
-		}
-	}
-
-	NT_LOG(DBG, FILTER, "INIT CAT CTE");
-
-	if (hw_mod_cat_cte_flush(be, 0, ALL_ENTRIES))
-		return -1;
-
-	NT_LOG(DBG, FILTER, "INIT CAT CTS");
-
-	if (hw_mod_cat_cts_flush(be, 0, ALL_ENTRIES))
-		return -1;
-
-	NT_LOG(DBG, FILTER, "INIT CAT COT");
-
-	if (hw_mod_cat_cot_flush(be, 0, ALL_ENTRIES))
-		return -1;
-
-	NT_LOG(DBG, FILTER, "INIT CAT CCT");
-
-	if (hw_mod_cat_cct_flush(be, 0, ALL_ENTRIES))
-		return -1;
-
-	NT_LOG(DBG, FILTER, "INIT CAT EXO");
-
-	if (hw_mod_cat_exo_flush(be, 0, ALL_ENTRIES))
-		return -1;
-
-	NT_LOG(DBG, FILTER, "INIT CAT RCK");
-
-	if (hw_mod_cat_rck_flush(be, 0, ALL_ENTRIES))
-		return -1;
-
-	NT_LOG(DBG, FILTER, "INIT CAT LEN");
-
-	if (hw_mod_cat_len_flush(be, 0, ALL_ENTRIES))
-		return -1;
-
-	if (be->cat.kcc_size) {
-		NT_LOG(DBG, FILTER, "INIT CAT KCC");
-
-		if (hw_mod_cat_kcc_flush(be, 0, ALL_ENTRIES))
-			return -1;
-	}
-
-	return 0;
-}
-
 int hw_mod_cat_cfn_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	switch (count) {
@@ -1449,7 +1341,7 @@ int hw_mod_cat_cot_set(struct flow_api_backend_s *be, enum hw_cat_e field, int i
 	return hw_mod_cat_cot_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_cat_cct_flush(struct flow_api_backend_s *be, int start_idx, int count)
+static int hw_mod_cat_cct_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->cat.nb_cat_funcs * 4;
@@ -1462,7 +1354,7 @@ int hw_mod_cat_cct_flush(struct flow_api_backend_s *be, int start_idx, int count
 	return be->iface->cat_cct_flush(be->be_dev, &be->cat, start_idx, count);
 }
 
-int hw_mod_cat_kcc_flush(struct flow_api_backend_s *be, int start_idx, int count)
+static int hw_mod_cat_kcc_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->cat.kcc_size;
@@ -1475,7 +1367,7 @@ int hw_mod_cat_kcc_flush(struct flow_api_backend_s *be, int start_idx, int count
 	return be->iface->cat_kcc_flush(be->be_dev, &be->cat, start_idx, count);
 }
 
-int hw_mod_cat_exo_flush(struct flow_api_backend_s *be, int start_idx, int count)
+static int hw_mod_cat_exo_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->cat.nb_pm_ext;
@@ -1488,7 +1380,7 @@ int hw_mod_cat_exo_flush(struct flow_api_backend_s *be, int start_idx, int count
 	return be->iface->cat_exo_flush(be->be_dev, &be->cat, start_idx, count);
 }
 
-int hw_mod_cat_rck_flush(struct flow_api_backend_s *be, int start_idx, int count)
+static int hw_mod_cat_rck_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->cat.nb_pm_ext * 64;
@@ -1501,7 +1393,7 @@ int hw_mod_cat_rck_flush(struct flow_api_backend_s *be, int start_idx, int count
 	return be->iface->cat_rck_flush(be->be_dev, &be->cat, start_idx, count);
 }
 
-int hw_mod_cat_len_flush(struct flow_api_backend_s *be, int start_idx, int count)
+static int hw_mod_cat_len_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->cat.nb_len;
@@ -1513,3 +1405,111 @@ int hw_mod_cat_len_flush(struct flow_api_backend_s *be, int start_idx, int count
 
 	return be->iface->cat_len_flush(be->be_dev, &be->cat, start_idx, count);
 }
+
+int hw_mod_cat_reset(struct flow_api_backend_s *be)
+{
+	/* Zero entire cache area */
+	nthw_zero_module_cache((struct common_func_s *)(&be->cat));
+
+	NT_LOG(DBG, FILTER, "INIT CAT CFN");
+
+	if (hw_mod_cat_cfn_flush(be, 0, ALL_ENTRIES))
+		return -1;
+
+	if (_VER_ <= 18) {
+		NT_LOG(DBG, FILTER, "INIT CAT KCE");
+
+		if (hw_mod_cat_kce_flush(be, KM_FLM_IF_FIRST, 0, 0, ALL_ENTRIES))
+			return -1;
+
+		NT_LOG(DBG, FILTER, "INIT CAT KCS");
+
+		if (hw_mod_cat_kcs_flush(be, KM_FLM_IF_FIRST, 0, 0, ALL_ENTRIES))
+			return -1;
+
+		NT_LOG(DBG, FILTER, "INIT CAT FTE");
+
+		if (hw_mod_cat_fte_flush(be, KM_FLM_IF_FIRST, 0, 0, ALL_ENTRIES))
+			return -1;
+
+	} else {
+		NT_LOG(DBG, FILTER, "INIT CAT KCE 0");
+
+		if (hw_mod_cat_kce_flush(be, KM_FLM_IF_FIRST, be->cat.km_if_m0, 0, ALL_ENTRIES))
+			return -1;
+
+		NT_LOG(DBG, FILTER, "INIT CAT KCS 0");
+
+		if (hw_mod_cat_kcs_flush(be, KM_FLM_IF_FIRST, be->cat.km_if_m0, 0, ALL_ENTRIES))
+			return -1;
+
+		NT_LOG(DBG, FILTER, "INIT CAT FTE 0");
+
+		if (hw_mod_cat_fte_flush(be, KM_FLM_IF_FIRST, be->cat.km_if_m0, 0, ALL_ENTRIES))
+			return -1;
+
+		if (be->cat.km_if_count > 1) {
+			NT_LOG(DBG, FILTER, "INIT CAT KCE 1");
+
+			if (hw_mod_cat_kce_flush(be, KM_FLM_IF_SECOND, be->cat.km_if_m1, 0,
+					ALL_ENTRIES))
+				return -1;
+
+			NT_LOG(DBG, FILTER, "INIT CAT KCS 1");
+
+			if (hw_mod_cat_kcs_flush(be, KM_FLM_IF_SECOND, be->cat.km_if_m1, 0,
+					ALL_ENTRIES))
+				return -1;
+
+			NT_LOG(DBG, FILTER, "INIT CAT FTE 1");
+
+			if (hw_mod_cat_fte_flush(be, KM_FLM_IF_SECOND, be->cat.km_if_m1, 0,
+					ALL_ENTRIES))
+				return -1;
+		}
+	}
+
+	NT_LOG(DBG, FILTER, "INIT CAT CTE");
+
+	if (hw_mod_cat_cte_flush(be, 0, ALL_ENTRIES))
+		return -1;
+
+	NT_LOG(DBG, FILTER, "INIT CAT CTS");
+
+	if (hw_mod_cat_cts_flush(be, 0, ALL_ENTRIES))
+		return -1;
+
+	NT_LOG(DBG, FILTER, "INIT CAT COT");
+
+	if (hw_mod_cat_cot_flush(be, 0, ALL_ENTRIES))
+		return -1;
+
+	NT_LOG(DBG, FILTER, "INIT CAT CCT");
+
+	if (hw_mod_cat_cct_flush(be, 0, ALL_ENTRIES))
+		return -1;
+
+	NT_LOG(DBG, FILTER, "INIT CAT EXO");
+
+	if (hw_mod_cat_exo_flush(be, 0, ALL_ENTRIES))
+		return -1;
+
+	NT_LOG(DBG, FILTER, "INIT CAT RCK");
+
+	if (hw_mod_cat_rck_flush(be, 0, ALL_ENTRIES))
+		return -1;
+
+	NT_LOG(DBG, FILTER, "INIT CAT LEN");
+
+	if (hw_mod_cat_len_flush(be, 0, ALL_ENTRIES))
+		return -1;
+
+	if (be->cat.kcc_size) {
+		NT_LOG(DBG, FILTER, "INIT CAT KCC");
+
+		if (hw_mod_cat_kcc_flush(be, 0, ALL_ENTRIES))
+			return -1;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
index e1c97f62f5..a1b9abae66 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
@@ -114,44 +114,6 @@ void hw_mod_km_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_km_reset(struct flow_api_backend_s *be)
-{
-	uint32_t tcam_v_set[3] = { 0x00000000, 0x00000000, 0x00000000 };
-
-	/* Zero entire cache area */
-	nthw_zero_module_cache((struct common_func_s *)(&be->km));
-
-	NT_LOG(DBG, FILTER, "INIT KM RCP");
-	hw_mod_km_rcp_flush(be, 0, ALL_ENTRIES);
-
-	/* init CAM - all zero */
-	NT_LOG(DBG, FILTER, "INIT KM CAM");
-	hw_mod_km_cam_flush(be, 0, 0, ALL_ENTRIES);
-
-	/* init TCAM - all zero */
-	NT_LOG(DBG, FILTER, "INIT KM TCAM");
-
-	for (unsigned int i = 0; i < be->km.nb_tcam_banks; i++) {
-		/* TCAM entries are cache controlled,
-		 * thus need to hard reset initially to sync cache with HW
-		 */
-		hw_mod_km_tcam_set(be, HW_KM_TCAM_BANK_RESET, i, 0, 0, tcam_v_set);
-	}
-
-	hw_mod_km_tcam_flush(be, 0, ALL_ENTRIES);
-
-	/* init TCI - all zero */
-	NT_LOG(DBG, FILTER, "INIT KM TCI");
-	hw_mod_km_tci_flush(be, 0, 0, ALL_ENTRIES);
-
-	NT_LOG(DBG, FILTER, "INIT KM TCQ");
-
-	for (unsigned int i = 0; i < be->km.nb_tcam_bank_width; i++)
-		hw_mod_km_tcq_flush(be, 0, i, be->km.nb_tcam_banks);
-
-	return 0;
-}
-
 int hw_mod_km_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
@@ -668,7 +630,8 @@ int hw_mod_km_tci_set(struct flow_api_backend_s *be, enum hw_km_e field, int ban
 	return hw_mod_km_tci_mod(be, field, bank, record, &value, 0);
 }
 
-int hw_mod_km_tcq_flush(struct flow_api_backend_s *be, int start_bank, int start_record, int count)
+static int hw_mod_km_tcq_flush(struct flow_api_backend_s *be, int start_bank,
+	int start_record, int count)
 {
 	if (count == ALL_ENTRIES)
 		count = be->km.nb_tcam_banks * be->km.nb_tcam_bank_width;
@@ -682,3 +645,41 @@ int hw_mod_km_tcq_flush(struct flow_api_backend_s *be, int start_bank, int start
 
 	return be->iface->km_tcq_flush(be->be_dev, &be->km, start_bank, start_record, count);
 }
+
+int hw_mod_km_reset(struct flow_api_backend_s *be)
+{
+	uint32_t tcam_v_set[3] = { 0x00000000, 0x00000000, 0x00000000 };
+
+	/* Zero entire cache area */
+	nthw_zero_module_cache((struct common_func_s *)(&be->km));
+
+	NT_LOG(DBG, FILTER, "INIT KM RCP");
+	hw_mod_km_rcp_flush(be, 0, ALL_ENTRIES);
+
+	/* init CAM - all zero */
+	NT_LOG(DBG, FILTER, "INIT KM CAM");
+	hw_mod_km_cam_flush(be, 0, 0, ALL_ENTRIES);
+
+	/* init TCAM - all zero */
+	NT_LOG(DBG, FILTER, "INIT KM TCAM");
+
+	for (unsigned int i = 0; i < be->km.nb_tcam_banks; i++) {
+		/* TCAM entries are cache controlled,
+		 * thus need to hard reset initially to sync cache with HW
+		 */
+		hw_mod_km_tcam_set(be, HW_KM_TCAM_BANK_RESET, i, 0, 0, tcam_v_set);
+	}
+
+	hw_mod_km_tcam_flush(be, 0, ALL_ENTRIES);
+
+	/* init TCI - all zero */
+	NT_LOG(DBG, FILTER, "INIT KM TCI");
+	hw_mod_km_tci_flush(be, 0, 0, ALL_ENTRIES);
+
+	NT_LOG(DBG, FILTER, "INIT KM TCQ");
+
+	for (unsigned int i = 0; i < be->km.nb_tcam_bank_width; i++)
+		hw_mod_km_tcq_flush(be, 0, i, be->km.nb_tcam_banks);
+
+	return 0;
+}
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
index 4e8bd73d90..c5357a98c5 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
@@ -58,20 +58,6 @@ void hw_mod_pdb_free(struct flow_api_backend_s *be)
 	}
 }
 
-int hw_mod_pdb_reset(struct flow_api_backend_s *be)
-{
-	int err = 0;
-	/* Zero entire cache area */
-	nthw_zero_module_cache((struct common_func_s *)(&be->hsh));
-
-	NT_LOG(DBG, FILTER, "INIT PDB RCP");
-	err |= hw_mod_pdb_rcp_flush(be, 0, ALL_ENTRIES);
-
-	NT_LOG(DBG, FILTER, "INIT PDB CONFIG");
-	err |= hw_mod_pdb_config_flush(be);
-	return err;
-}
-
 int hw_mod_pdb_rcp_flush(struct flow_api_backend_s *be, int start_idx, int count)
 {
 	if (count == ALL_ENTRIES)
@@ -243,7 +229,21 @@ int hw_mod_pdb_rcp_set(struct flow_api_backend_s *be, enum hw_pdb_e field, uint3
 	return hw_mod_pdb_rcp_mod(be, field, index, &value, 0);
 }
 
-int hw_mod_pdb_config_flush(struct flow_api_backend_s *be)
+static int hw_mod_pdb_config_flush(struct flow_api_backend_s *be)
 {
 	return be->iface->pdb_config_flush(be->be_dev, &be->pdb);
 }
+
+int hw_mod_pdb_reset(struct flow_api_backend_s *be)
+{
+	int err = 0;
+	/* Zero entire cache area */
+	nthw_zero_module_cache((struct common_func_s *)(&be->hsh));
+
+	NT_LOG(DBG, FILTER, "INIT PDB RCP");
+	err |= hw_mod_pdb_rcp_flush(be, 0, ALL_ENTRIES);
+
+	NT_LOG(DBG, FILTER, "INIT PDB CONFIG");
+	err |= hw_mod_pdb_config_flush(be);
+	return err;
+}
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
index b2915efce5..d55adc6687 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
@@ -402,8 +402,8 @@ static int hw_mod_tpe_ifr_counters_mod(struct flow_api_backend_s *be, enum hw_tp
 	return 0;
 }
 
-int hw_mod_tpe_ifr_counters_set(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
-	uint32_t value)
+static int hw_mod_tpe_ifr_counters_set(struct flow_api_backend_s *be, enum hw_tpe_e field,
+	int index, uint32_t value)
 {
 	return hw_mod_tpe_ifr_counters_mod(be, field, index, &value, 0);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index 52ca79f104..18d550a327 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -319,82 +319,6 @@ void hw_db_inline_destroy(void *db_handle)
 	free(db);
 }
 
-void hw_db_inline_deref_idxs(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_idx *idxs,
-	uint32_t size)
-{
-	for (uint32_t i = 0; i < size; ++i) {
-		switch (idxs[i].type) {
-		case HW_DB_IDX_TYPE_NONE:
-			break;
-
-		case HW_DB_IDX_TYPE_MATCH_SET:
-			hw_db_inline_match_set_deref(ndev, db_handle,
-				*(struct hw_db_match_set_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_ACTION_SET:
-			hw_db_inline_action_set_deref(ndev, db_handle,
-				*(struct hw_db_action_set_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_CAT:
-			hw_db_inline_cat_deref(ndev, db_handle, *(struct hw_db_cat_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_COT:
-			hw_db_inline_cot_deref(ndev, db_handle, *(struct hw_db_cot_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_QSL:
-			hw_db_inline_qsl_deref(ndev, db_handle, *(struct hw_db_qsl_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_SLC_LR:
-			hw_db_inline_slc_lr_deref(ndev, db_handle,
-				*(struct hw_db_slc_lr_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_TPE:
-			hw_db_inline_tpe_deref(ndev, db_handle, *(struct hw_db_tpe_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_TPE_EXT:
-			hw_db_inline_tpe_ext_deref(ndev, db_handle,
-				*(struct hw_db_tpe_ext_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_FLM_RCP:
-			hw_db_inline_flm_deref(ndev, db_handle, *(struct hw_db_flm_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_FLM_FT:
-			hw_db_inline_flm_ft_deref(ndev, db_handle,
-				*(struct hw_db_flm_ft *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_KM_RCP:
-			hw_db_inline_km_deref(ndev, db_handle, *(struct hw_db_km_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_KM_FT:
-			hw_db_inline_km_ft_deref(ndev, db_handle, *(struct hw_db_km_ft *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_HSH:
-			hw_db_inline_hsh_deref(ndev, db_handle, *(struct hw_db_hsh_idx *)&idxs[i]);
-			break;
-
-		case HW_DB_IDX_TYPE_FLM_SCRUB:
-			hw_db_inline_scrub_deref(ndev, db_handle,
-				*(struct hw_db_flm_scrub_idx *)&idxs[i]);
-			break;
-
-		default:
-			break;
-		}
-	}
-}
-
 struct hw_db_idx *hw_db_inline_find_idx(struct flow_nic_dev *ndev, void *db_handle,
 	enum hw_db_idx_type type, struct hw_db_idx *idxs, uint32_t size)
 {
@@ -1508,6 +1432,16 @@ static int hw_db_inline_match_set_compare(const struct hw_db_inline_match_set_da
 		data1->km_ft.raw == data2->km_ft.raw && data1->jump == data2->jump;
 }
 
+static void hw_db_inline_match_set_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_match_set_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->match_set[idx.ids].ref += 1;
+}
+
 struct hw_db_match_set_idx
 hw_db_inline_match_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_match_set_data *data)
@@ -1563,17 +1497,7 @@ hw_db_inline_match_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	return idx;
 }
 
-void hw_db_inline_match_set_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_match_set_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->match_set[idx.ids].ref += 1;
-}
-
-void hw_db_inline_match_set_deref(struct flow_nic_dev *ndev, void *db_handle,
+static void hw_db_inline_match_set_deref(struct flow_nic_dev *ndev, void *db_handle,
 	struct hw_db_match_set_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -1619,6 +1543,16 @@ static int hw_db_inline_action_set_compare(const struct hw_db_inline_action_set_
 		data1->hsh.raw == data2->hsh.raw && data1->scrub.raw == data2->scrub.raw;
 }
 
+static void hw_db_inline_action_set_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_action_set_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->action_set[idx.ids].ref += 1;
+}
+
 struct hw_db_action_set_idx
 hw_db_inline_action_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_action_set_data *data)
@@ -1654,17 +1588,7 @@ hw_db_inline_action_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	return idx;
 }
 
-void hw_db_inline_action_set_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_action_set_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->action_set[idx.ids].ref += 1;
-}
-
-void hw_db_inline_action_set_deref(struct flow_nic_dev *ndev, void *db_handle,
+static void hw_db_inline_action_set_deref(struct flow_nic_dev *ndev, void *db_handle,
 	struct hw_db_action_set_idx idx)
 {
 	(void)ndev;
@@ -1693,6 +1617,15 @@ static int hw_db_inline_cot_compare(const struct hw_db_inline_cot_data *data1,
 		data1->frag_rcp == data2->frag_rcp;
 }
 
+static void hw_db_inline_cot_ref(struct flow_nic_dev *ndev __rte_unused, void *db_handle,
+	struct hw_db_cot_idx idx)
+{
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->cot[idx.ids].ref += 1;
+}
+
 struct hw_db_cot_idx hw_db_inline_cot_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_cot_data *data)
 {
@@ -1728,16 +1661,7 @@ struct hw_db_cot_idx hw_db_inline_cot_add(struct flow_nic_dev *ndev, void *db_ha
 	return idx;
 }
 
-void hw_db_inline_cot_ref(struct flow_nic_dev *ndev __rte_unused, void *db_handle,
-	struct hw_db_cot_idx idx)
-{
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->cot[idx.ids].ref += 1;
-}
-
-void hw_db_inline_cot_deref(struct flow_nic_dev *ndev __rte_unused, void *db_handle,
+static void hw_db_inline_cot_deref(struct flow_nic_dev *ndev __rte_unused, void *db_handle,
 	struct hw_db_cot_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -1791,6 +1715,15 @@ static int hw_db_inline_qsl_compare(const struct hw_db_inline_qsl_data *data1,
 	return 1;
 }
 
+static void hw_db_inline_qsl_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_qsl_idx idx)
+{
+	(void)db_handle;
+
+	if (!idx.error && idx.ids != 0)
+		nthw_flow_nic_ref_resource(ndev, RES_QSL_RCP, idx.ids);
+}
+
 struct hw_db_qsl_idx hw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_qsl_data *data)
 {
@@ -1884,15 +1817,8 @@ struct hw_db_qsl_idx hw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_ha
 	return qsl_idx;
 }
 
-void hw_db_inline_qsl_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_qsl_idx idx)
-{
-	(void)db_handle;
-
-	if (!idx.error && idx.ids != 0)
-		nthw_flow_nic_ref_resource(ndev, RES_QSL_RCP, idx.ids);
-}
-
-void hw_db_inline_qsl_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_qsl_idx idx)
+static void hw_db_inline_qsl_deref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_qsl_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
 
@@ -1937,6 +1863,16 @@ static int hw_db_inline_slc_lr_compare(const struct hw_db_inline_slc_lr_data *da
 		data1->head_slice_ofs == data2->head_slice_ofs;
 }
 
+static void hw_db_inline_slc_lr_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_slc_lr_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->slc_lr[idx.ids].ref += 1;
+}
+
 struct hw_db_slc_lr_idx hw_db_inline_slc_lr_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_slc_lr_data *data)
 {
@@ -1977,17 +1913,7 @@ struct hw_db_slc_lr_idx hw_db_inline_slc_lr_add(struct flow_nic_dev *ndev, void
 	return idx;
 }
 
-void hw_db_inline_slc_lr_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_slc_lr_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->slc_lr[idx.ids].ref += 1;
-}
-
-void hw_db_inline_slc_lr_deref(struct flow_nic_dev *ndev, void *db_handle,
+static void hw_db_inline_slc_lr_deref(struct flow_nic_dev *ndev, void *db_handle,
 	struct hw_db_slc_lr_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2044,6 +1970,16 @@ static int hw_db_inline_tpe_compare(const struct hw_db_inline_tpe_data *data1,
 		data1->len_c_sub_dyn == data2->len_c_sub_dyn;
 }
 
+static void hw_db_inline_tpe_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_tpe_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->tpe[idx.ids].ref += 1;
+}
+
 struct hw_db_tpe_idx hw_db_inline_tpe_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_tpe_data *data)
 {
@@ -2173,16 +2109,8 @@ struct hw_db_tpe_idx hw_db_inline_tpe_add(struct flow_nic_dev *ndev, void *db_ha
 	return idx;
 }
 
-void hw_db_inline_tpe_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_tpe_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->tpe[idx.ids].ref += 1;
-}
-
-void hw_db_inline_tpe_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_tpe_idx idx)
+static void hw_db_inline_tpe_deref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_tpe_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
 
@@ -2229,6 +2157,16 @@ static int hw_db_inline_tpe_ext_compare(const struct hw_db_inline_tpe_ext_data *
 		memcmp(data1->hdr8, data2->hdr8, HW_DB_INLINE_MAX_ENCAP_SIZE) == 0;
 }
 
+static void hw_db_inline_tpe_ext_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_tpe_ext_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->tpe_ext[idx.ids].ref += 1;
+}
+
 struct hw_db_tpe_ext_idx hw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_tpe_ext_data *data)
 {
@@ -2291,17 +2229,7 @@ struct hw_db_tpe_ext_idx hw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, voi
 	return idx;
 }
 
-void hw_db_inline_tpe_ext_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_tpe_ext_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->tpe_ext[idx.ids].ref += 1;
-}
-
-void hw_db_inline_tpe_ext_deref(struct flow_nic_dev *ndev, void *db_handle,
+static void hw_db_inline_tpe_ext_deref(struct flow_nic_dev *ndev, void *db_handle,
 	struct hw_db_tpe_ext_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2337,6 +2265,16 @@ void hw_db_inline_tpe_ext_deref(struct flow_nic_dev *ndev, void *db_handle,
 /* CAT                                                                        */
 /******************************************************************************/
 
+static void hw_db_inline_cat_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_cat_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->cat[idx.ids].ref += 1;
+}
+
 static int hw_db_inline_cat_compare(const struct hw_db_inline_cat_data *data1,
 	const struct hw_db_inline_cat_data *data2)
 {
@@ -2389,16 +2327,8 @@ struct hw_db_cat_idx hw_db_inline_cat_add(struct flow_nic_dev *ndev, void *db_ha
 	return idx;
 }
 
-void hw_db_inline_cat_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_cat_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->cat[idx.ids].ref += 1;
-}
-
-void hw_db_inline_cat_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_cat_idx idx)
+static void hw_db_inline_cat_deref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_cat_idx idx)
 {
 	(void)ndev;
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2424,6 +2354,15 @@ static int hw_db_inline_km_compare(const struct hw_db_inline_km_rcp_data *data1,
 	return data1->rcp == data2->rcp;
 }
 
+static void hw_db_inline_km_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->km[idx.id1].ref += 1;
+}
+
 struct hw_db_km_idx hw_db_inline_km_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_km_rcp_data *data)
 {
@@ -2457,16 +2396,8 @@ struct hw_db_km_idx hw_db_inline_km_add(struct flow_nic_dev *ndev, void *db_hand
 	return idx;
 }
 
-void hw_db_inline_km_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->km[idx.id1].ref += 1;
-}
-
-void hw_db_inline_km_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_idx idx)
+static void hw_db_inline_km_deref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_km_idx idx)
 {
 	(void)ndev;
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2493,6 +2424,18 @@ static int hw_db_inline_km_ft_compare(const struct hw_db_inline_km_ft_data *data
 		data1->action_set.raw == data2->action_set.raw;
 }
 
+static void hw_db_inline_km_ft_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_km_ft idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error) {
+		uint32_t cat_offset = idx.id3 * db->nb_cat;
+		db->km[idx.id2].ft[cat_offset + idx.id1].ref += 1;
+	}
+}
+
 struct hw_db_km_ft hw_db_inline_km_ft_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_km_ft_data *data)
 {
@@ -2538,18 +2481,8 @@ struct hw_db_km_ft hw_db_inline_km_ft_add(struct flow_nic_dev *ndev, void *db_ha
 	return idx;
 }
 
-void hw_db_inline_km_ft_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_ft idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error) {
-		uint32_t cat_offset = idx.id3 * db->nb_cat;
-		db->km[idx.id2].ft[cat_offset + idx.id1].ref += 1;
-	}
-}
-
-void hw_db_inline_km_ft_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_ft idx)
+static void hw_db_inline_km_ft_deref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_km_ft idx)
 {
 	(void)ndev;
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -2590,6 +2523,16 @@ static int hw_db_inline_flm_compare(const struct hw_db_inline_flm_rcp_data *data
 	return 1;
 }
 
+static void hw_db_inline_flm_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_flm_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->flm[idx.id1].ref += 1;
+}
+
 struct hw_db_flm_idx hw_db_inline_flm_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_rcp_data *data, int group)
 {
@@ -2653,16 +2596,8 @@ struct hw_db_flm_idx hw_db_inline_flm_add(struct flow_nic_dev *ndev, void *db_ha
 	return idx;
 }
 
-void hw_db_inline_flm_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_flm_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->flm[idx.id1].ref += 1;
-}
-
-void hw_db_inline_flm_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_flm_idx idx)
+static void hw_db_inline_flm_deref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_flm_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
 
@@ -2693,6 +2628,16 @@ static int hw_db_inline_flm_ft_compare(const struct hw_db_inline_flm_ft_data *da
 		data1->action_set.raw == data2->action_set.raw;
 }
 
+static void hw_db_inline_flm_ft_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_flm_ft idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error && idx.id3 == 0)
+		db->flm[idx.id2].ft[idx.id1].ref += 1;
+}
+
 struct hw_db_flm_ft hw_db_inline_flm_ft_default(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_ft_data *data)
 {
@@ -2784,16 +2729,8 @@ struct hw_db_flm_ft hw_db_inline_flm_ft_add(struct flow_nic_dev *ndev, void *db_
 	return idx;
 }
 
-void hw_db_inline_flm_ft_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_flm_ft idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error && idx.id3 == 0)
-		db->flm[idx.id2].ft[idx.id1].ref += 1;
-}
-
-void hw_db_inline_flm_ft_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_flm_ft idx)
+static void hw_db_inline_flm_ft_deref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_flm_ft idx)
 {
 	(void)ndev;
 	(void)db_handle;
@@ -2829,6 +2766,16 @@ static int hw_db_inline_hsh_compare(const struct hw_db_inline_hsh_data *data1,
 	return data1->func == data2->func && data1->hash_mask == data2->hash_mask;
 }
 
+static void hw_db_inline_hsh_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_hsh_idx idx)
+{
+	(void)ndev;
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->hsh[idx.ids].ref += 1;
+}
+
 struct hw_db_hsh_idx hw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_hsh_data *data)
 {
@@ -2890,16 +2837,8 @@ struct hw_db_hsh_idx hw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_ha
 	return idx;
 }
 
-void hw_db_inline_hsh_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_hsh_idx idx)
-{
-	(void)ndev;
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->hsh[idx.ids].ref += 1;
-}
-
-void hw_db_inline_hsh_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_hsh_idx idx)
+static void hw_db_inline_hsh_deref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_hsh_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
 
@@ -2938,6 +2877,17 @@ static int hw_db_inline_scrub_compare(const struct hw_db_inline_scrub_data *data
 	return data1->timeout == data2->timeout;
 }
 
+static void hw_db_inline_scrub_ref(struct flow_nic_dev *ndev, void *db_handle,
+	struct hw_db_flm_scrub_idx idx)
+{
+	(void)ndev;
+
+	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
+
+	if (!idx.error)
+		db->scrub[idx.ids].ref += 1;
+}
+
 struct hw_db_flm_scrub_idx hw_db_inline_scrub_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_scrub_data *data)
 {
@@ -2994,18 +2944,7 @@ struct hw_db_flm_scrub_idx hw_db_inline_scrub_add(struct flow_nic_dev *ndev, voi
 	return idx;
 }
 
-void hw_db_inline_scrub_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_flm_scrub_idx idx)
-{
-	(void)ndev;
-
-	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
-
-	if (!idx.error)
-		db->scrub[idx.ids].ref += 1;
-}
-
-void hw_db_inline_scrub_deref(struct flow_nic_dev *ndev, void *db_handle,
+static void hw_db_inline_scrub_deref(struct flow_nic_dev *ndev, void *db_handle,
 	struct hw_db_flm_scrub_idx idx)
 {
 	struct hw_db_inline_resource_db *db = (struct hw_db_inline_resource_db *)db_handle;
@@ -3030,3 +2969,79 @@ void hw_db_inline_scrub_deref(struct flow_nic_dev *ndev, void *db_handle,
 		db->scrub[idx.ids].ref = 0;
 	}
 }
+
+void hw_db_inline_deref_idxs(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_idx *idxs,
+	uint32_t size)
+{
+	for (uint32_t i = 0; i < size; ++i) {
+		switch (idxs[i].type) {
+		case HW_DB_IDX_TYPE_NONE:
+			break;
+
+		case HW_DB_IDX_TYPE_MATCH_SET:
+			hw_db_inline_match_set_deref(ndev, db_handle,
+				*(struct hw_db_match_set_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_ACTION_SET:
+			hw_db_inline_action_set_deref(ndev, db_handle,
+				*(struct hw_db_action_set_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_CAT:
+			hw_db_inline_cat_deref(ndev, db_handle, *(struct hw_db_cat_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_COT:
+			hw_db_inline_cot_deref(ndev, db_handle, *(struct hw_db_cot_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_QSL:
+			hw_db_inline_qsl_deref(ndev, db_handle, *(struct hw_db_qsl_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_SLC_LR:
+			hw_db_inline_slc_lr_deref(ndev, db_handle,
+				*(struct hw_db_slc_lr_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_TPE:
+			hw_db_inline_tpe_deref(ndev, db_handle, *(struct hw_db_tpe_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_TPE_EXT:
+			hw_db_inline_tpe_ext_deref(ndev, db_handle,
+				*(struct hw_db_tpe_ext_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_FLM_RCP:
+			hw_db_inline_flm_deref(ndev, db_handle, *(struct hw_db_flm_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_FLM_FT:
+			hw_db_inline_flm_ft_deref(ndev, db_handle,
+				*(struct hw_db_flm_ft *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_KM_RCP:
+			hw_db_inline_km_deref(ndev, db_handle, *(struct hw_db_km_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_KM_FT:
+			hw_db_inline_km_ft_deref(ndev, db_handle, *(struct hw_db_km_ft *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_HSH:
+			hw_db_inline_hsh_deref(ndev, db_handle, *(struct hw_db_hsh_idx *)&idxs[i]);
+			break;
+
+		case HW_DB_IDX_TYPE_FLM_SCRUB:
+			hw_db_inline_scrub_deref(ndev, db_handle,
+				*(struct hw_db_flm_scrub_idx *)&idxs[i]);
+			break;
+
+		default:
+			break;
+		}
+	}
+}
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
index aa046b68a7..e7f66dc075 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
@@ -298,96 +298,43 @@ void hw_db_inline_dump_cfn(struct flow_nic_dev *ndev, void *db_handle, FILE *fil
 struct hw_db_match_set_idx
 hw_db_inline_match_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_match_set_data *data);
-void hw_db_inline_match_set_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_match_set_idx idx);
-void hw_db_inline_match_set_deref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_match_set_idx idx);
-
 struct hw_db_action_set_idx
 hw_db_inline_action_set_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_action_set_data *data);
-void hw_db_inline_action_set_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_action_set_idx idx);
-void hw_db_inline_action_set_deref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_action_set_idx idx);
-
 /**/
 
 struct hw_db_cot_idx hw_db_inline_cot_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_cot_data *data);
-void hw_db_inline_cot_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_cot_idx idx);
-void hw_db_inline_cot_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_cot_idx idx);
-
 struct hw_db_qsl_idx hw_db_inline_qsl_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_qsl_data *data);
-void hw_db_inline_qsl_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_qsl_idx idx);
-void hw_db_inline_qsl_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_qsl_idx idx);
-
 struct hw_db_slc_lr_idx hw_db_inline_slc_lr_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_slc_lr_data *data);
-void hw_db_inline_slc_lr_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_slc_lr_idx idx);
-void hw_db_inline_slc_lr_deref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_slc_lr_idx idx);
-
 struct hw_db_tpe_idx hw_db_inline_tpe_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_tpe_data *data);
-void hw_db_inline_tpe_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_tpe_idx idx);
-void hw_db_inline_tpe_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_tpe_idx idx);
-
 struct hw_db_tpe_ext_idx hw_db_inline_tpe_ext_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_tpe_ext_data *data);
-void hw_db_inline_tpe_ext_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_tpe_ext_idx idx);
-void hw_db_inline_tpe_ext_deref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_tpe_ext_idx idx);
-
 struct hw_db_hsh_idx hw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_hsh_data *data);
-void hw_db_inline_hsh_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_hsh_idx idx);
-void hw_db_inline_hsh_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_hsh_idx idx);
-
 /**/
 
 struct hw_db_cat_idx hw_db_inline_cat_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_cat_data *data);
-void hw_db_inline_cat_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_cat_idx idx);
-void hw_db_inline_cat_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_cat_idx idx);
-
 /**/
 
 struct hw_db_km_idx hw_db_inline_km_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_km_rcp_data *data);
-void hw_db_inline_km_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_idx idx);
-void hw_db_inline_km_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_idx idx);
-
 struct hw_db_km_ft hw_db_inline_km_ft_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_km_ft_data *data);
-void hw_db_inline_km_ft_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_ft idx);
-void hw_db_inline_km_ft_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_km_ft idx);
-
 /**/
 
 struct hw_db_flm_idx hw_db_inline_flm_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_rcp_data *data, int group);
-void hw_db_inline_flm_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_flm_idx idx);
-void hw_db_inline_flm_deref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_flm_idx idx);
-
 struct hw_db_flm_ft hw_db_inline_flm_ft_default(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_ft_data *data);
 struct hw_db_flm_ft hw_db_inline_flm_ft_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_flm_ft_data *data);
-void hw_db_inline_flm_ft_ref(struct flow_nic_dev *ndev, void *db_handle, struct hw_db_flm_ft idx);
-void hw_db_inline_flm_ft_deref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_flm_ft idx);
-
 struct hw_db_flm_scrub_idx hw_db_inline_scrub_add(struct flow_nic_dev *ndev, void *db_handle,
 	const struct hw_db_inline_scrub_data *data);
-void hw_db_inline_scrub_ref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_flm_scrub_idx idx);
-void hw_db_inline_scrub_deref(struct flow_nic_dev *ndev, void *db_handle,
-	struct hw_db_flm_scrub_idx idx);
-
 int hw_db_inline_setup_mbr_filter(struct flow_nic_dev *ndev, uint32_t cat_hw_id, uint32_t ft,
 	uint32_t qsl_hw_id);
 
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 5256adc648..3655c86f51 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -171,6 +171,191 @@ int nthw_fpga_extract_rev_id(const uint64_t n_fpga_ident)
 {
 	return (uint16_t)(n_fpga_ident & 0xFF);
 }
+/*
+ * Field
+ */
+nthw_field_t *nthw_field_new(void)
+{
+	nthw_field_t *p = malloc(sizeof(nthw_field_t));
+
+	return p;
+}
+
+static void nthw_field_init(nthw_field_t *p, nthw_register_t *p_reg,
+	const nthw_fpga_field_init_s *p_init)
+{
+	p->mp_owner = p_reg;
+
+	p->mn_debug_mode = p_reg->mn_debug_mode;
+
+	p->mn_id = p_init->id;
+	p->mn_bit_width = p_init->bw;
+	p->mn_bit_pos_low = p_init->low;
+	p->mn_reset_val = (uint32_t)p_init->reset_val;
+	p->mn_first_word = p_init->low / 32;
+	p->mn_first_bit = p_init->low % 32;
+	p->mn_front_mask = 0;
+	p->mn_body_length = 0;
+	p->mn_words = (p_init->bw + 0x1f) / 0x20;
+	p->mn_tail_mask = 0;
+
+	{
+		int bits_remaining = p_init->bw;
+		int front_mask_length = 32 - p->mn_first_bit;
+
+		if (front_mask_length > bits_remaining)
+			front_mask_length = bits_remaining;
+
+		bits_remaining -= front_mask_length;
+
+		p->mn_front_mask =
+			(uint32_t)(((1ULL << front_mask_length) - 1) << p->mn_first_bit);
+
+		p->mn_body_length = bits_remaining / 32;
+		bits_remaining -= p->mn_body_length * 32;
+		p->mn_tail_mask = (1 << bits_remaining) - 1;
+
+		if (p->mn_debug_mode >= 0x100) {
+			NT_LOG_DBGX(DBG, NTHW,
+				"fldid=%08" PRIu32 ": [%08" PRIu16 ":%08" PRIu16 "] %08" PRIu16 "/%08"
+				PRIu16 ": (%08i ,%08" PRIu32 ") (0x%08" PRIx32 ",%08"
+				PRIu32 ",0x%08" PRIx32 ")",
+				p_init->id, p_init->low, (p_init->low + p_init->bw),
+				p_init->bw, ((p_init->bw + 31) / 32), p->mn_first_word,
+				p->mn_first_bit, p->mn_front_mask, p->mn_body_length,
+				p->mn_tail_mask);
+		}
+	}
+}
+
+static void nthw_field_reset(const nthw_field_t *p)
+{
+	nthw_field_set_val32(p, (uint32_t)p->mn_reset_val);
+}
+
+/*
+ * Register
+ */
+nthw_register_t *nthw_register_new(void)
+{
+	nthw_register_t *p = malloc(sizeof(nthw_register_t));
+
+	return p;
+}
+
+static void nthw_register_init(nthw_register_t *p, nthw_module_t *p_module,
+	nthw_fpga_register_init_s *p_init)
+{
+	int i;
+
+	p->mp_owner = p_module;
+
+	p->mn_id = p_init->id;
+	p->mn_bit_width = p_init->bw;
+	p->mn_addr_rel = p_init->addr_rel;
+	p->mn_addr = p_module->mn_addr_base + p_init->addr_rel;
+	p->mn_type = p_init->type;
+	/* Old P200 registers have no bw at register level - default to BW=-1 */
+	p->mn_len = ((p_init->bw != (uint16_t)-1) ? ((p_init->bw + 31) >> 5) : 1);
+	p->mn_debug_mode = p_module->mn_debug_mode;
+
+	p->mn_fields = p_init->nb_fields;
+
+	if (p->mn_fields) {
+		p->mpa_fields = malloc(p->mn_fields * sizeof(nthw_field_t *));
+
+		if (p->mpa_fields) {
+			memset(p->mpa_fields, 0, (p->mn_fields * sizeof(nthw_field_t *)));
+
+			for (i = 0; i < p->mn_fields; i++) {
+				nthw_field_t *p_field = nthw_field_new();
+
+				nthw_field_init(p_field, p, &p_init->fields[i]);
+				p->mpa_fields[i] = p_field;
+			}
+
+			p->mp_shadow = malloc(p->mn_len * sizeof(uint32_t));
+
+			if (p->mp_shadow)
+				memset(p->mp_shadow, 0x00, (p->mn_len * sizeof(uint32_t)));
+
+			p->mp_dirty = malloc(p->mn_len * sizeof(bool));
+
+			if (p->mp_dirty)
+				memset(p->mp_dirty, 0x00, (p->mn_len * sizeof(bool)));
+		}
+	}
+}
+
+/*
+ * Param
+ */
+nthw_param_t *nthw_param_new(void)
+{
+	nthw_param_t *p = malloc(sizeof(nthw_param_t));
+
+	return p;
+}
+
+static void nthw_param_init(nthw_param_t *p, nthw_fpga_t *p_fpga, nthw_fpga_prod_param_s *p_init)
+{
+	p->mp_owner = p_fpga;
+	p->mp_init = p_init;
+
+	p->mn_param_id = p_init->id;
+	p->mn_param_value = p_init->value;
+}
+
+/*
+ * Module
+ */
+nthw_module_t *nthw_module_new(void)
+{
+	nthw_module_t *p = malloc(sizeof(nthw_module_t));
+
+	return p;
+}
+
+static void nthw_module_init(nthw_module_t *p, nthw_fpga_t *p_fpga, nthw_fpga_module_init_s *p_init)
+{
+	int i;
+
+	p->mp_owner = p_fpga;
+	p->mp_init = p_init;
+
+	p->mn_mod_id = p_init->id;
+	p->mn_instance = p_init->instance;
+
+	/* Copy debug mode from owner */
+	if (p->mp_owner)
+		p->mn_debug_mode = p->mp_owner->m_debug_mode;
+
+	else
+		p->mn_debug_mode = 0;
+
+	p->mn_mod_def_id = p_init->def_id;
+	p->mn_major_version = p_init->major_version;
+	p->mn_minor_version = p_init->minor_version;
+	p->mn_bus = p_init->bus_id;
+	p->mn_addr_base = p_init->addr_base;
+
+	p->mn_registers = p_init->nb_registers;
+
+	if (p->mn_registers) {
+		p->mpa_registers = malloc(p->mn_registers * sizeof(nthw_register_t *));
+
+		if (p->mpa_registers) {
+			memset(p->mpa_registers, 0, (p->mn_registers * sizeof(nthw_register_t *)));
+
+			for (i = 0; i < p->mn_registers; i++) {
+				nthw_register_t *p_reg = nthw_register_new();
+
+				nthw_register_init(p_reg, p, &p_init->registers[i]);
+				p->mpa_registers[i] = p_reg;
+			}
+		}
+	}
+}
 
 /*
  * FpgaMgr
@@ -204,47 +389,6 @@ void nthw_fpga_mgr_init(nthw_fpga_mgr_t *p, struct nthw_fpga_prod_init **pa_nthw
 	p->mn_fpgas = (int)i;
 }
 
-static nthw_fpga_t *nthw_fpga_mgr_lookup_fpga(nthw_fpga_mgr_t *p, uint64_t n_fpga_id,
-	struct fpga_info_s *p_fpga_info)
-{
-	const int n_fpga_prod_id = nthw_fpga_extract_prod_id(n_fpga_id);
-	const int n_fpga_ver = nthw_fpga_extract_ver_id(n_fpga_id);
-	const int n_fpga_rev = nthw_fpga_extract_rev_id(n_fpga_id);
-	int i;
-
-	for (i = 0; i < p->mn_fpgas; i++) {
-		nthw_fpga_prod_init_s *p_init = p->mpa_fpga_prod_init[i];
-
-		if (p_init->fpga_product_id == n_fpga_prod_id &&
-			p_init->fpga_version == n_fpga_ver && p_init->fpga_revision == n_fpga_rev) {
-			nthw_fpga_t *p_fpga = nthw_fpga_model_new();
-			nthw_fpga_model_init(p_fpga, p_init, p_fpga_info);
-			return p_fpga;
-		}
-	}
-
-	return NULL;
-}
-
-nthw_fpga_t *nthw_fpga_mgr_query_fpga(nthw_fpga_mgr_t *p_fpga_mgr, uint64_t n_fpga_id,
-	struct fpga_info_s *p_fpga_info)
-{
-	const int n_fpga_prod_id = nthw_fpga_extract_prod_id(n_fpga_id);
-	const int n_fpga_ver = nthw_fpga_extract_ver_id(n_fpga_id);
-	const int n_fpga_rev = nthw_fpga_extract_rev_id(n_fpga_id);
-
-	nthw_fpga_t *p_fpga = nthw_fpga_mgr_lookup_fpga(p_fpga_mgr, n_fpga_id, p_fpga_info);
-
-	if (p_fpga) {
-	} else {
-		NT_LOG(ERR, NTHW, "FPGA Id 0x%" PRIX64 ": %04d: %d.%d: no match found",
-			n_fpga_id, n_fpga_prod_id, n_fpga_ver, n_fpga_rev);
-	}
-
-	return p_fpga;
-}
-
-
 void nthw_fpga_mgr_log_dump(nthw_fpga_mgr_t *p)
 {
 	int i;
@@ -272,7 +416,7 @@ nthw_fpga_t *nthw_fpga_model_new(void)
 	return p;
 }
 
-void nthw_fpga_model_init(nthw_fpga_t *p, nthw_fpga_prod_init_s *p_init,
+static void nthw_fpga_model_init(nthw_fpga_t *p, nthw_fpga_prod_init_s *p_init,
 	struct fpga_info_s *p_fpga_info)
 {
 	int i;
@@ -323,7 +467,7 @@ void nthw_fpga_model_init(nthw_fpga_t *p, nthw_fpga_prod_init_s *p_init,
 	}
 }
 
-void nthw_fpga_set_debug_mode(nthw_fpga_t *p, int debug_mode)
+static void nthw_fpga_set_debug_mode(nthw_fpga_t *p, int debug_mode)
 {
 	int i;
 
@@ -376,76 +520,6 @@ int nthw_fpga_get_product_id(const nthw_fpga_t *p)
 	return p->mn_product_id;
 }
 
-/*
- * Param
- */
-nthw_param_t *nthw_param_new(void)
-{
-	nthw_param_t *p = malloc(sizeof(nthw_param_t));
-
-	return p;
-}
-
-void nthw_param_init(nthw_param_t *p, nthw_fpga_t *p_fpga, nthw_fpga_prod_param_s *p_init)
-{
-	p->mp_owner = p_fpga;
-	p->mp_init = p_init;
-
-	p->mn_param_id = p_init->id;
-	p->mn_param_value = p_init->value;
-}
-
-/*
- * Module
- */
-nthw_module_t *nthw_module_new(void)
-{
-	nthw_module_t *p = malloc(sizeof(nthw_module_t));
-
-	return p;
-}
-
-void nthw_module_init(nthw_module_t *p, nthw_fpga_t *p_fpga, nthw_fpga_module_init_s *p_init)
-{
-	int i;
-
-	p->mp_owner = p_fpga;
-	p->mp_init = p_init;
-
-	p->mn_mod_id = p_init->id;
-	p->mn_instance = p_init->instance;
-
-	/* Copy debug mode from owner */
-	if (p->mp_owner)
-		p->mn_debug_mode = p->mp_owner->m_debug_mode;
-
-	else
-		p->mn_debug_mode = 0;
-
-	p->mn_mod_def_id = p_init->def_id;
-	p->mn_major_version = p_init->major_version;
-	p->mn_minor_version = p_init->minor_version;
-	p->mn_bus = p_init->bus_id;
-	p->mn_addr_base = p_init->addr_base;
-
-	p->mn_registers = p_init->nb_registers;
-
-	if (p->mn_registers) {
-		p->mpa_registers = malloc(p->mn_registers * sizeof(nthw_register_t *));
-
-		if (p->mpa_registers) {
-			memset(p->mpa_registers, 0, (p->mn_registers * sizeof(nthw_register_t *)));
-
-			for (i = 0; i < p->mn_registers; i++) {
-				nthw_register_t *p_reg = nthw_register_new();
-
-				nthw_register_init(p_reg, p, &p_init->registers[i]);
-				p->mpa_registers[i] = p_reg;
-			}
-		}
-	}
-}
-
 int nthw_module_get_major_version(const nthw_module_t *p)
 {
 	return p->mn_major_version;
@@ -528,71 +602,17 @@ void nthw_module_set_debug_mode(nthw_module_t *p, unsigned int debug_mode)
 	}
 }
 
-int nthw_module_get_bus(const nthw_module_t *p)
+static int nthw_module_get_bus(const nthw_module_t *p)
 {
 	return p->mn_bus;
 }
 
-/*
- * Register
- */
-nthw_register_t *nthw_register_new(void)
-{
-	nthw_register_t *p = malloc(sizeof(nthw_register_t));
-
-	return p;
-}
-
-void nthw_register_init(nthw_register_t *p, nthw_module_t *p_module,
-	nthw_fpga_register_init_s *p_init)
-{
-	int i;
-
-	p->mp_owner = p_module;
-
-	p->mn_id = p_init->id;
-	p->mn_bit_width = p_init->bw;
-	p->mn_addr_rel = p_init->addr_rel;
-	p->mn_addr = p_module->mn_addr_base + p_init->addr_rel;
-	p->mn_type = p_init->type;
-	/* Old P200 registers have no bw at register level - default to BW=-1 */
-	p->mn_len = ((p_init->bw != (uint16_t)-1) ? ((p_init->bw + 31) >> 5) : 1);
-	p->mn_debug_mode = p_module->mn_debug_mode;
-
-	p->mn_fields = p_init->nb_fields;
-
-	if (p->mn_fields) {
-		p->mpa_fields = malloc(p->mn_fields * sizeof(nthw_field_t *));
-
-		if (p->mpa_fields) {
-			memset(p->mpa_fields, 0, (p->mn_fields * sizeof(nthw_field_t *)));
-
-			for (i = 0; i < p->mn_fields; i++) {
-				nthw_field_t *p_field = nthw_field_new();
-
-				nthw_field_init(p_field, p, &p_init->fields[i]);
-				p->mpa_fields[i] = p_field;
-			}
-
-			p->mp_shadow = malloc(p->mn_len * sizeof(uint32_t));
-
-			if (p->mp_shadow)
-				memset(p->mp_shadow, 0x00, (p->mn_len * sizeof(uint32_t)));
-
-			p->mp_dirty = malloc(p->mn_len * sizeof(bool));
-
-			if (p->mp_dirty)
-				memset(p->mp_dirty, 0x00, (p->mn_len * sizeof(bool)));
-		}
-	}
-}
-
 uint32_t nthw_register_get_address(const nthw_register_t *p)
 {
 	return p->mn_addr;
 }
 
-void nthw_register_reset(const nthw_register_t *p)
+static void nthw_register_reset(const nthw_register_t *p)
 {
 	int i;
 	nthw_field_t *p_field = NULL;
@@ -647,12 +667,12 @@ nthw_field_t *nthw_register_get_field(const nthw_register_t *p, nthw_id_t id)
 	return p_field;
 }
 
-int nthw_register_get_bit_width(const nthw_register_t *p)
+static int nthw_register_get_bit_width(const nthw_register_t *p)
 {
 	return p->mn_bit_width;
 }
 
-int nthw_register_get_debug_mode(const nthw_register_t *p)
+static int nthw_register_get_debug_mode(const nthw_register_t *p)
 {
 	return p->mn_debug_mode;
 }
@@ -660,6 +680,11 @@ int nthw_register_get_debug_mode(const nthw_register_t *p)
 /*
  * NOTE: do not set debug on fields - as register operation dumps typically are enough
  */
+static void nthw_field_set_debug_mode(nthw_field_t *p, unsigned int debug_mode)
+{
+	p->mn_debug_mode = debug_mode;
+}
+
 void nthw_register_set_debug_mode(nthw_register_t *p, unsigned int debug_mode)
 {
 	int i;
@@ -725,7 +750,7 @@ static int nthw_register_write_data(const nthw_register_t *p, uint32_t cnt)
 	return rc;
 }
 
-void nthw_register_get_val(const nthw_register_t *p, uint32_t *p_data, uint32_t len)
+static void nthw_register_get_val(const nthw_register_t *p, uint32_t *p_data, uint32_t len)
 {
 	uint32_t i;
 
@@ -739,7 +764,7 @@ void nthw_register_get_val(const nthw_register_t *p, uint32_t *p_data, uint32_t
 		p_data[i] = p->mp_shadow[i];
 }
 
-uint32_t nthw_register_get_val32(const nthw_register_t *p)
+static uint32_t nthw_register_get_val32(const nthw_register_t *p)
 {
 	uint32_t val = 0;
 
@@ -781,7 +806,7 @@ void nthw_register_update(const nthw_register_t *p)
 	}
 }
 
-uint32_t nthw_register_get_val_updated32(const nthw_register_t *p)
+static uint32_t nthw_register_get_val_updated32(const nthw_register_t *p)
 {
 	uint32_t val = 0;
 
@@ -852,7 +877,7 @@ void nthw_register_flush(const nthw_register_t *p, uint32_t cnt)
 	}
 }
 
-void nthw_register_clr(nthw_register_t *p)
+static void nthw_register_clr(nthw_register_t *p)
 {
 	if (p->mp_shadow) {
 		memset(p->mp_shadow, 0, p->mn_len * sizeof(uint32_t));
@@ -860,72 +885,11 @@ void nthw_register_clr(nthw_register_t *p)
 	}
 }
 
-/*
- * Field
- */
-nthw_field_t *nthw_field_new(void)
-{
-	nthw_field_t *p = malloc(sizeof(nthw_field_t));
-
-	return p;
-}
-
-void nthw_field_init(nthw_field_t *p, nthw_register_t *p_reg, const nthw_fpga_field_init_s *p_init)
-{
-	p->mp_owner = p_reg;
-
-	p->mn_debug_mode = p_reg->mn_debug_mode;
-
-	p->mn_id = p_init->id;
-	p->mn_bit_width = p_init->bw;
-	p->mn_bit_pos_low = p_init->low;
-	p->mn_reset_val = (uint32_t)p_init->reset_val;
-	p->mn_first_word = p_init->low / 32;
-	p->mn_first_bit = p_init->low % 32;
-	p->mn_front_mask = 0;
-	p->mn_body_length = 0;
-	p->mn_words = (p_init->bw + 0x1f) / 0x20;
-	p->mn_tail_mask = 0;
-
-	{
-		int bits_remaining = p_init->bw;
-		int front_mask_length = 32 - p->mn_first_bit;
-
-		if (front_mask_length > bits_remaining)
-			front_mask_length = bits_remaining;
-
-		bits_remaining -= front_mask_length;
-
-		p->mn_front_mask =
-			(uint32_t)(((1ULL << front_mask_length) - 1) << p->mn_first_bit);
-
-		p->mn_body_length = bits_remaining / 32;
-		bits_remaining -= p->mn_body_length * 32;
-		p->mn_tail_mask = (1 << bits_remaining) - 1;
-
-		if (p->mn_debug_mode >= 0x100) {
-			NT_LOG_DBGX(DBG, NTHW,
-				"fldid=%08" PRIu32 ": [%08" PRIu16 ":%08" PRIu16 "] %08" PRIu16 "/%08"
-				PRIu16 ": (%08i ,%08" PRIu32 ") (0x%08" PRIx32 ",%08"
-				PRIu32 ",0x%08" PRIx32 ")",
-				p_init->id, p_init->low, (p_init->low + p_init->bw),
-				p_init->bw, ((p_init->bw + 31) / 32), p->mn_first_word,
-				p->mn_first_bit, p->mn_front_mask, p->mn_body_length,
-				p->mn_tail_mask);
-		}
-	}
-}
-
-int nthw_field_get_debug_mode(const nthw_field_t *p)
+static int nthw_field_get_debug_mode(const nthw_field_t *p)
 {
 	return p->mn_debug_mode;
 }
 
-void nthw_field_set_debug_mode(nthw_field_t *p, unsigned int debug_mode)
-{
-	p->mn_debug_mode = debug_mode;
-}
-
 int nthw_field_get_bit_width(const nthw_field_t *p)
 {
 	return p->mn_bit_width;
@@ -936,7 +900,7 @@ int nthw_field_get_bit_pos_low(const nthw_field_t *p)
 	return p->mn_bit_pos_low;
 }
 
-int nthw_field_get_bit_pos_high(const nthw_field_t *p)
+static int nthw_field_get_bit_pos_high(const nthw_field_t *p)
 {
 	return p->mn_bit_pos_low + p->mn_bit_width - 1;
 }
@@ -946,11 +910,6 @@ uint32_t nthw_field_get_mask(const nthw_field_t *p)
 	return p->mn_front_mask;
 }
 
-void nthw_field_reset(const nthw_field_t *p)
-{
-	nthw_field_set_val32(p, (uint32_t)p->mn_reset_val);
-}
-
 void nthw_field_get_val(const nthw_field_t *p, uint32_t *p_data, uint32_t len)
 {
 	uint32_t i;
@@ -1210,3 +1169,43 @@ int nthw_field_wait_set_any32(const nthw_field_t *p, int n_poll_iterations, int
 	return nthw_field_wait_cond32(p, NTHW_FIELD_MATCH_SET_ANY, n_poll_iterations,
 			n_poll_interval);
 }
+
+static nthw_fpga_t *nthw_fpga_mgr_lookup_fpga(nthw_fpga_mgr_t *p, uint64_t n_fpga_id,
+	struct fpga_info_s *p_fpga_info)
+{
+	const int n_fpga_prod_id = nthw_fpga_extract_prod_id(n_fpga_id);
+	const int n_fpga_ver = nthw_fpga_extract_ver_id(n_fpga_id);
+	const int n_fpga_rev = nthw_fpga_extract_rev_id(n_fpga_id);
+	int i;
+
+	for (i = 0; i < p->mn_fpgas; i++) {
+		nthw_fpga_prod_init_s *p_init = p->mpa_fpga_prod_init[i];
+
+		if (p_init->fpga_product_id == n_fpga_prod_id &&
+			p_init->fpga_version == n_fpga_ver && p_init->fpga_revision == n_fpga_rev) {
+			nthw_fpga_t *p_fpga = nthw_fpga_model_new();
+			nthw_fpga_model_init(p_fpga, p_init, p_fpga_info);
+			return p_fpga;
+		}
+	}
+
+	return NULL;
+}
+
+nthw_fpga_t *nthw_fpga_mgr_query_fpga(nthw_fpga_mgr_t *p_fpga_mgr, uint64_t n_fpga_id,
+	struct fpga_info_s *p_fpga_info)
+{
+	const int n_fpga_prod_id = nthw_fpga_extract_prod_id(n_fpga_id);
+	const int n_fpga_ver = nthw_fpga_extract_ver_id(n_fpga_id);
+	const int n_fpga_rev = nthw_fpga_extract_rev_id(n_fpga_id);
+
+	nthw_fpga_t *p_fpga = nthw_fpga_mgr_lookup_fpga(p_fpga_mgr, n_fpga_id, p_fpga_info);
+
+	if (p_fpga) {
+	} else {
+		NT_LOG(ERR, NTHW, "FPGA Id 0x%" PRIX64 ": %04d: %d.%d: no match found",
+			n_fpga_id, n_fpga_prod_id, n_fpga_ver, n_fpga_rev);
+	}
+
+	return p_fpga;
+}
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.h b/drivers/net/ntnic/nthw/model/nthw_fpga_model.h
index d4e7ab3edd..459c9f081d 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.h
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.h
@@ -159,21 +159,13 @@ nthw_fpga_t *nthw_fpga_mgr_query_fpga(nthw_fpga_mgr_t *p, uint64_t n_fpga_id,
 void nthw_fpga_mgr_log_dump(nthw_fpga_mgr_t *p);
 
 nthw_fpga_t *nthw_fpga_model_new(void);
-void nthw_fpga_model_init(nthw_fpga_t *p, nthw_fpga_prod_init_s *p_init,
-	struct fpga_info_s *p_fpga_info);
-
 int nthw_fpga_get_product_param(const nthw_fpga_t *p, const nthw_id_t n_param_id,
 	const int default_value);
 int nthw_fpga_get_product_id(const nthw_fpga_t *p);
 
 nthw_module_t *nthw_fpga_query_module(const nthw_fpga_t *p, nthw_id_t id, int instance);
-void nthw_fpga_set_debug_mode(nthw_fpga_t *p, int n_debug_mode);
-
 nthw_param_t *nthw_param_new(void);
-void nthw_param_init(nthw_param_t *p, nthw_fpga_t *p_fpga, nthw_fpga_prod_param_s *p_init);
-
 nthw_module_t *nthw_module_new(void);
-void nthw_module_init(nthw_module_t *p, nthw_fpga_t *p_fpga, nthw_fpga_module_init_s *p_init);
 void nthw_module_init2(nthw_module_t *p, nthw_fpga_t *p_fpga, nthw_id_t mod_id, int instance,
 	int debug_mode);
 
@@ -182,47 +174,27 @@ int nthw_module_get_minor_version(const nthw_module_t *p);
 uint64_t nthw_module_get_version_packed64(const nthw_module_t *p);
 bool nthw_module_is_version_newer(const nthw_module_t *p, int major_version, int minor_version);
 
-int nthw_module_get_bus(const nthw_module_t *p);
 nthw_register_t *nthw_module_query_register(nthw_module_t *p, nthw_id_t id);
 nthw_register_t *nthw_module_get_register(nthw_module_t *p, nthw_id_t id);
 int nthw_module_get_debug_mode(const nthw_module_t *p);
 void nthw_module_set_debug_mode(nthw_module_t *p, unsigned int debug_mode);
 
 nthw_register_t *nthw_register_new(void);
-void nthw_register_init(nthw_register_t *p, nthw_module_t *p_module,
-	nthw_fpga_register_init_s *p_init);
-
 nthw_field_t *nthw_register_query_field(const nthw_register_t *p, nthw_id_t id);
 nthw_field_t *nthw_register_get_field(const nthw_register_t *p, nthw_id_t id);
 
 uint32_t nthw_register_get_address(const nthw_register_t *p);
-int nthw_register_get_bit_width(const nthw_register_t *p);
-int nthw_register_get_debug_mode(const nthw_register_t *p);
 void nthw_register_set_debug_mode(nthw_register_t *p, unsigned int debug_mode);
 
-void nthw_register_get_val(const nthw_register_t *p, uint32_t *p_data, uint32_t len);
-uint32_t nthw_register_get_val32(const nthw_register_t *p);
-uint32_t nthw_register_get_val_updated32(const nthw_register_t *p);
-
 void nthw_register_set_val(nthw_register_t *p, const uint32_t *p_data, uint32_t len);
 
 void nthw_register_make_dirty(nthw_register_t *p);
 void nthw_register_update(const nthw_register_t *p);
-void nthw_register_reset(const nthw_register_t *p);
 void nthw_register_flush(const nthw_register_t *p, uint32_t cnt);
-void nthw_register_clr(nthw_register_t *p);
-
 nthw_field_t *nthw_field_new(void);
-void nthw_field_init(nthw_field_t *p, nthw_register_t *p_reg,
-	const nthw_fpga_field_init_s *p_init);
-
-int nthw_field_get_debug_mode(const nthw_field_t *p);
-void nthw_field_set_debug_mode(nthw_field_t *p, unsigned int n_debug_mode);
 int nthw_field_get_bit_width(const nthw_field_t *p);
 int nthw_field_get_bit_pos_low(const nthw_field_t *p);
-int nthw_field_get_bit_pos_high(const nthw_field_t *p);
 uint32_t nthw_field_get_mask(const nthw_field_t *p);
-void nthw_field_reset(const nthw_field_t *p);
 void nthw_field_get_val(const nthw_field_t *p, uint32_t *p_data, uint32_t len);
 void nthw_field_set_val(const nthw_field_t *p, const uint32_t *p_data, uint32_t len);
 void nthw_field_set_val_flush(const nthw_field_t *p, const uint32_t *p_data, uint32_t len);
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index c6c448312f..f498551e8d 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -31,7 +31,8 @@ static struct rte_flow nt_flows[MAX_RTE_FLOWS];
 rte_spinlock_t flow_lock = RTE_SPINLOCK_INITIALIZER;
 static struct rte_flow nt_flows[MAX_RTE_FLOWS];
 
-int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_flow_item *out)
+static int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size,
+	struct rte_flow_item *out)
 {
 	int hdri = 0;
 	int pkti = 0;
@@ -249,7 +250,7 @@ int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct r
 	return hdri + 1;
 }
 
-int nthw_create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr)
+static int nthw_create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr)
 {
 	if (!attribute) {
 		NT_LOG(ERR, FILTER, "ERROR no attribute to iterate!");
@@ -266,7 +267,7 @@ int nthw_create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *a
 	return 0;
 }
 
-int nthw_create_match_elements(struct cnv_match_s *match, const struct rte_flow_item items[],
+static int nthw_create_match_elements(struct cnv_match_s *match, const struct rte_flow_item items[],
 	int max_elem)
 {
 	int eidx = 0;
@@ -316,7 +317,7 @@ int nthw_create_match_elements(struct cnv_match_s *match, const struct rte_flow_
 	return (type >= 0) ? 0 : -1;
 }
 
-int nthw_create_action_elements_inline(struct cnv_action_s *action,
+static int nthw_create_action_elements_inline(struct cnv_action_s *action,
 	const struct rte_flow_action actions[],
 	int max_elem,
 	uint32_t queue_offset)
diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index 1031b3cf67..b1e807d6fa 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -20,7 +20,7 @@
 #define ONE_G_MASK (ONE_G_SIZE - 1)
 #define START_VF_IOVA 0x220000000000
 
-int
+static int
 nt_vfio_vf_num(const struct rte_pci_device *pdev)
 {
 	return ((pdev->addr.devid & 0x1f) << 3) + ((pdev->addr.function) & 0x7);
diff --git a/drivers/net/ntnic/ntnic_vfio.h b/drivers/net/ntnic/ntnic_vfio.h
index 69fef7923d..e070e9460c 100644
--- a/drivers/net/ntnic/ntnic_vfio.h
+++ b/drivers/net/ntnic/ntnic_vfio.h
@@ -24,6 +24,4 @@ int
 nt_vfio_dma_unmap(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size);
 
 /* Find device (PF/VF) number from device address */
-int
-nt_vfio_vf_num(const struct rte_pci_device *dev);
 #endif	/* _NTNIC_VFIO_H_ */
diff --git a/drivers/net/ntnic/ntutil/nt_util.c b/drivers/net/ntnic/ntutil/nt_util.c
index a4d30d8ca4..c4a49d8358 100644
--- a/drivers/net/ntnic/ntutil/nt_util.c
+++ b/drivers/net/ntnic/ntutil/nt_util.c
@@ -85,7 +85,7 @@ struct nt_dma_s *nt_dma_alloc(uint64_t size, uint64_t align, int numa)
 	return vfio_addr;
 }
 
-void nt_dma_free(struct nt_dma_s *vfio_addr)
+static void nt_dma_free(struct nt_dma_s *vfio_addr)
 {
 	NT_LOG(DBG, GENERAL, "VFIO DMA free addr=%" PRIX64 ", iova=%" PRIX64 ", size=%" PRIX64,
 		vfio_addr->addr, vfio_addr->iova, vfio_addr->size);
@@ -181,7 +181,7 @@ uint32_t nt_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa)
 }
 
 /* Converts link speed provided in Mbps to NT specific definitions.*/
-nt_link_speed_t nthw_convert_link_speed(int link_speed_mbps)
+static nt_link_speed_t nthw_convert_link_speed(int link_speed_mbps)
 {
 	switch (link_speed_mbps) {
 	case 10:
diff --git a/drivers/net/ntnic/ntutil/nt_util.h b/drivers/net/ntnic/ntutil/nt_util.h
index 5be84be9c3..39a4956187 100644
--- a/drivers/net/ntnic/ntutil/nt_util.h
+++ b/drivers/net/ntnic/ntutil/nt_util.h
@@ -55,8 +55,6 @@ struct port_link_speed {
 };
 
 struct nt_dma_s *nt_dma_alloc(uint64_t size, uint64_t align, int numa);
-void nt_dma_free(struct nt_dma_s *vfio_addr);
-
 struct nt_util_vfio_impl {
 	int (*vfio_dma_map)(int vf_num, void *virt_addr, uint64_t *iova_addr, uint64_t size);
 	int (*vfio_dma_unmap)(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size);
@@ -66,7 +64,6 @@ void nt_util_vfio_init(struct nt_util_vfio_impl *impl);
 
 int nt_link_speed_to_eth_speed_num(enum nt_link_speed_e nt_link_speed);
 uint32_t nt_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa);
-nt_link_speed_t nthw_convert_link_speed(int link_speed_mbps);
 int nt_link_duplex_to_eth_duplex(enum nt_link_duplex_e nt_link_duplex);
 
 int nthw_string_to_u32(const char *key_str __rte_unused, const char *value_str, void *extra_args);
-- 
2.45.0

