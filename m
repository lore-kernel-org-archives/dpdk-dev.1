Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B10C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:58:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6757402A0;
	Mon, 30 Jun 2025 11:58:18 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011037.outbound.protection.outlook.com
 [40.107.130.37]) by mails.dpdk.org (Postfix) with ESMTP id CB7A94025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:58:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvsW7VQ7tYUl4FYxQZUt4Lz/23WH4Kv/mNVi50Bz/7c75M7nwMZf6mGqKX3Z8YPheDtuw3lZzS8NiKNaTH4NkJSpIUsmzHwqffYq/S+dA3cQgE41qDvJx405+89RXJkrp+O+93qhLYeenK+E1bicUvQ0Z4RKNMp9Grk2I8VBn6q4JZm73LKVcosv0lmp0AReAyTNO6DoNdyG5UuqyLsvcUQa/lkPWRED75P48y9Y9Hf6WwCjgmoTXmSLYfO/FnALBbUZsFwpR+fPqgtxX1Tg6JDW950s3AqZ3q+ZLPo12/sShqFesLEjKD2TEDcdFeS9Sb+EYm5HOnQ3sJcX35J5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXNZA+wBCRsGZaufM+QwckuvEfmFmgKgqn0CXjQ2Gw0=;
 b=vmg/27OAkWenMVgtaNlBNBO6t75WOEXDMlZI0QmtvxVfcISyPOcuFJcHLwSZsh/OsAogBHpVygRWE7KWuDdr7BSXTgMmOQE0LlbUubVdPzRFNTHUJh4miS5CfFWdSnMSHbOQdKgMZQ4xplsbbo4uISqehqM4spEzqRbGZIddRD2OncVOXrIuxBp0XWa/53ZIAPtXAQHDI8iXLug+gTYo6m0l6iGUNudAirPZ6tWvFtJNPvhg8+/q7ITS7nuopeQtnlgwqnujX/btabnc/9AAAxuOiTNDZt2xwGYL/CmDtJam8HJqA6ljGg6fd6u6LLKmWeBhSvfHAmGUnqlTYlkaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXNZA+wBCRsGZaufM+QwckuvEfmFmgKgqn0CXjQ2Gw0=;
 b=CRNXkns+u2UGJEC2O3YF5dO9M1b3CuAP8caWAuBdfgn0+dlP1ZKyCenVKVzg0YtYNh7mnQQRdRtgzu7xyylZbEHmKcM1vd3AcDrOLsfC7JRFBPNd5noBZiZeZE/CZ1ijy/HsKeuBkPrU5ERR/51xov/tohUKB9Szw2zaLCpXBpxDOSEyu7WQHtfkHMlj5LRsuUvLZ1qeH25hty+1CpqIhCsGHVLJ4PrRNSgHJUxNf375/2X9C4j8w1kQ1iKcgIF5JBQaATHBNSpjQ74XDFUXARNblsuin+fl5cnZZoyKz0CD+63dZGdZL6irgNtavrRAHn9RC7AXFPDUeU7GIUP07Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 09:58:15 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 09:58:15 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v6 0/6] NXP DPAA2 driver enhancements and fixes
Date: Mon, 30 Jun 2025 15:27:54 +0530
Message-Id: <20250630095800.2943863-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5f590c-cb28-4393-61c9-08ddb7bca1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?giudUYJeBOTHoAGDpawJ6wcv2/YVrgHOMgQff2m7uyuJ9FDzgOQGK0lhnTXU?=
 =?us-ascii?Q?swKXJfQ4JwJvEmzzB4ro+uGO5XRYl23nMrgwF86IZHGSIsllkdWpBLYhoxAM?=
 =?us-ascii?Q?trf2sfLw2gQT9J80vf8knvrIfLjGHf77DKNahNi78iwx3J0ZyKFv8Y3A2Z1y?=
 =?us-ascii?Q?Yr7uDS/nY2VQVvAiluf7AzEIC5V7qYx9IrIYxxIY6Q20xx1f0clwN8NiVMzK?=
 =?us-ascii?Q?9QKX6d6dIH2Ix+VwIuRz9w492SPkLSN+Zg+C1oOqNga+2uJabwR4iN0xA8b1?=
 =?us-ascii?Q?C+Zw/dnKMqYXM74AftcH7kQIWUz5a2r6JE2OxhxCFFS6NuBMZPk35lSudHWK?=
 =?us-ascii?Q?kZuw6U463VXwhEStXlWSMoCMLj/fUF3yaEPOrgvDYcq7iVNkALsewrhEj/bd?=
 =?us-ascii?Q?socZjRP6+pOMG1xyf55qP8If7bDuzcVLudcaZAOCKQ3BnLuQoaIXlsD9MRMh?=
 =?us-ascii?Q?asqj+w24jlS0Fe9v0PVaCfjXNS5cYHL+q5EeUuMJDiia1PwRsFhaX7AckZui?=
 =?us-ascii?Q?+jQWzze9irPQZQsGXBqDfZ0VgUiaaXVLeKxPC5laPWjj1WPzCLgNFPFsw/py?=
 =?us-ascii?Q?0BXPNBV/sCIA7gnTyf1WCqxEPWq6T9LOedDcKwA/4BEr6ggeDv7Ak4wk0XTw?=
 =?us-ascii?Q?dRxWXibonARQ2A52X6qK0Lyym40pqXuWBfoiPhNxwj0fOQXft3Ed2AvcHfaN?=
 =?us-ascii?Q?AGCCy88w6JBfald0mANix6N6at/kqiNQQgA33nVQ45S7+FKtXDzVOQaEznYP?=
 =?us-ascii?Q?moPJIGQjSiKNBenEfKuRrMa38D4fymiFggmo6wiSY0eMcLYtExEPps1w9IJn?=
 =?us-ascii?Q?svmmgBhesTL/+XYmn1XKka4gGzOZNCJRzagUDBtDrMBrw0O6BPYPIIHYoIwR?=
 =?us-ascii?Q?l0Jx7gAFI2INGVK9ZhWtjo0n/sKVAYZMbQ1LQt6aZGSgj4h+UVmUX7AMwc8x?=
 =?us-ascii?Q?3h4P4bzWFhW86qX+KYecsaPm1/qM8i17WNguOzLxubD/VJQVv1caMVFABKBt?=
 =?us-ascii?Q?omtVzZTvJZfENluTw13E4bJcf9QyVPGzUgKreiHTPJW9NdwuvaF40eGaqpYt?=
 =?us-ascii?Q?X/lB81rZzuLvGLh8+5pldoplcO5LQxbYoynHOIcUBSSkDSJ8PcyY4FuGfrS1?=
 =?us-ascii?Q?lVaMkspUzx7MebMNqq99/ctLlOBA4kOZO1zSPUN6w3XPJh7Hfscysn5nJbv5?=
 =?us-ascii?Q?qXHq6zq0wlRMElSevA3mlSMWmN4y0oYpmKkD/sWNpsOnlL15gvTVwTBvz7J3?=
 =?us-ascii?Q?IoEXJ5tYbwxeRYKQhYBB9dQiX5+TmuWXpC8fh+1NsAubmXGTXHEEl9WgqwAU?=
 =?us-ascii?Q?FkElrXlvmgk6N8ClinWCiGEaz8MMIVfcfDci7qT4+ZgmtueNG9tRoMOuCidm?=
 =?us-ascii?Q?PLmOAVILabvj6YyJlIEuaBVeP63b8xlqzm+UeNLQE+tL12XkrAAr8jFMVSEp?=
 =?us-ascii?Q?Ju0QlluOmqlQh7iULMIG1Bd93pkxX1+KMoXPeUiWFOm23UQCMrdgcV1+Kvzk?=
 =?us-ascii?Q?N8SRbSy2h4DiJHA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tExFVmszmarOboqXJIVlP3rOeoeAIAfKPvynxeYnZw1oqbSE6UB85dVieyFv?=
 =?us-ascii?Q?FzJV6c1fDTaTCZBgWT473VI2SdL6uMQCI0VxZZL4yaVRl2q7Gvz3e7WGH2J/?=
 =?us-ascii?Q?IeNbD6OftFXvrqWQ7aMEfdBWjgx0h6h/rpbaGfEfcS1AzzoMXzK3/7fTNEcI?=
 =?us-ascii?Q?bUkXe6INiKy1os3PaSMvdTJ6JuYWg0z2DU+Q5cAmpx4J58I3Hy1/jRZZ4ECr?=
 =?us-ascii?Q?78J2eu8xOLboBWQWdISXfghc81ZY8fKQi5sPcEmNJmXqb952uAmOxB9nqxdZ?=
 =?us-ascii?Q?8iptr/eD2N6DJ2x+WrZ4Hr1C3RJZhJGBC2ApW8zthu0H0ujOAS03epV0bf4M?=
 =?us-ascii?Q?XUQrLM/zhwPxiUNs2iL3NSakj1IGOVXxIAdFzIHA+lYOeE61Mz74g2VEf6wi?=
 =?us-ascii?Q?1vTarrzHV1jpX5AhWGcbp4XJRIt1VQITEWMW579RqbtnN816kck5eZLj13qH?=
 =?us-ascii?Q?y2dYXxY7Cvr+r4vP/YcmW5e36Bf6XC/vLo89YinU8+Xsu7oWPVxaZS5B0cBr?=
 =?us-ascii?Q?4t999l/QbrRRUejyDZyF/+kygTCsWrRW8JGDrGJZ23XTu220H73rkcL/D6i1?=
 =?us-ascii?Q?TbBnn/QwLFP01vM49K6tF9fe6Yd8oqHi0pyd7Q+UL7hg+Lm85np8cYHnf+Z5?=
 =?us-ascii?Q?jGYew54MKkhmD9GIRjwnjRAdmAUOcy9kq5Wuwa35vbjuHsbxxEdQRJwWpy9z?=
 =?us-ascii?Q?rifIan0U3s/McsC5tnjClhfMnqdnwoPWmqEltj87pqRKg5AjT//Z6521SDPY?=
 =?us-ascii?Q?p0sWl39dG3ONtl2/l3CNCZ1Oq5qEHD4oVykwcoo0EtQD9HpCWwGWg6QSjY6W?=
 =?us-ascii?Q?WsBEs1So6tQbu2ji79J48xxVlUr4v/J1xzTQoA2WKqAyAdh9L/VRG35V9LBj?=
 =?us-ascii?Q?+JjqiwNiMJuIw0O+sev9NHjlcdlRrYUavfVaF/NjNIoXd5ZMqjqPbrRp1MkK?=
 =?us-ascii?Q?/LlabgWVi8mYk9gF+vGXkvlpTl+YearWPJ8ZIbzWruUlp9dP4gLqpIN2DkPh?=
 =?us-ascii?Q?MckMn1q1VrBck6ILtQlzTNkV9CpYR9srev4LnHa9ZtEEC2hUlEHchbC4e5jO?=
 =?us-ascii?Q?D5teZDoB6WFYPq7fTlG0+b0C8V2lc7OzQksmXMzWiOJCIO4fyea7vmyYh7IA?=
 =?us-ascii?Q?rV0/7vDkHr4rhWBPE7a0/wl1kYrxghqtQhKCrqP5r+CbxXNtEkwixsY9uzrA?=
 =?us-ascii?Q?uC8frHKJtOo2NMMLBMvUclTqSw9zFldezySG+hpkUCdswKb2CEFvQImvy7BP?=
 =?us-ascii?Q?uVW9Y9opxKwtlfxnqPj7vdCoEKS+2Qwrn5gKB7Ks6MyxHDW9Vnj17zlihl4b?=
 =?us-ascii?Q?Ip/9ShbOte4vj7ZyswJSnuzM1cuOCOBQT+E3Bgs4x1CSDP+bplmgdad+4SO7?=
 =?us-ascii?Q?RbjXaSrg6EmE0Y3WNAwKm6DnCMGhjdUk5zFC2XCPgVu4nyO/4tRiZj16ipwX?=
 =?us-ascii?Q?MKoE2NRkDNybYV8CzD+zI3HmSZAxQFPjZIuJGt9I5lA6a8wL99EHzDCx2aVX?=
 =?us-ascii?Q?JuRk4A7K5Iizmy4HoQ/orqgX5xY+LckzadmbTICmHQVH8k3Ge0V6KOYnhprQ?=
 =?us-ascii?Q?S2MxmloiQKvy5V5PzWI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5f590c-cb28-4393-61c9-08ddb7bca1d4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:58:15.5463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgF5JNECLxWOZhCwtYC+kNHp3VQxvVxM6lqk1FmqPjmU8H/qQcaZ+FH56nbslAEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894
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

V1-logs:
This patch series introduces enhancements and fixes to the
NXP DPAA2 Ethernet driver.
It includes support for
 - software taildrop on ordered queues.
 - setup speed capabilities.
 - DPAA2 resource version.
 - MAC level statistics.
 - improve PA-VA conversion.
 - add buffer pool depletion state configuration.
 - fixes for shaper rate and buffer prepration.

V2-Changes:
 - Fix compilation issue on UB2404-32

V3-Changes:
 - Fix missing license information in fsl_dpmac.h

V4-Changes:
 - Rebased the series to main branch top.

V5-Changes:
 - Fix spelling error

V6-Changes:
 - Remove new statistics and speed capabilities patches.
 - added release notes

Gagandeep Singh (2):
  net/dpaa2: fix shaper rate
  net/dpaa2: enable software taildrop for ordered queues

Ioana Ciornei (1):
  net/dpaa2: retrieve DPNI API version at init time

Jun Yang (2):
  net/dpaa2: fix issue of extract buffer preparation
  mempool/dpaa2: use unified VA to IOVA conversion

Vanshika Shukla (1):
  bus/fslmc: add DPBP APIs for setting depletion thresholds

 .mailmap                                  |   1 +
 doc/guides/platform/dpaa2.rst             |   2 +-
 doc/guides/rel_notes/release_25_07.rst    |   4 +
 drivers/bus/fslmc/mc/dpbp.c               |  78 ++++++-
 drivers/bus/fslmc/mc/fsl_dpbp.h           |  41 +++-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 248 +++++++++++++++-------
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |   1 +
 drivers/mempool/dpaa2/rte_dpaa2_mempool.h |  12 ++
 drivers/net/dpaa2/dpaa2_ethdev.c          |  51 ++++-
 drivers/net/dpaa2/dpaa2_ethdev.h          |  10 +-
 drivers/net/dpaa2/dpaa2_rxtx.c            |  24 ++-
 drivers/net/dpaa2/dpaa2_tm.c              |  68 +++---
 12 files changed, 414 insertions(+), 126 deletions(-)

-- 
2.25.1

