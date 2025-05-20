Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C3CC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DB9F40A6C;
	Tue, 20 May 2025 07:52:14 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
 by mails.dpdk.org (Postfix) with ESMTP id 721F540A6C
 for <dev@dpdk.org>; Tue, 20 May 2025 07:52:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8g8EOe5+N/lHdDGwmEIriP3qyrBfRKT8TFTXy2MwM6r04Un3gsevrrwZoXENxaAyIgoCVwA3o3TXNzKOX/dt5bD8asnxx/XyKi2ZMhjn2zOEgZCYX4EQWlE/l1mVH3ithDj5K+3op6VdLFK0SCua42/AhmKguGJuHTjxgo8F5k5/NnU147QZ4HamdcnYviahUQt3eK6T4y0BFQSueRrVIlk3zxPEdQvvPM4s2hE5aYwNyPcEBKo3hB2AwOenGM6+qmT23FcHcJolNQcNz2mbWZAlbKCzaa0LZPKLujHh8HbU1AQO+Zh7XSMSAPVHhs5bMf7p/ysOvPMMGvX/0QYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtQROJQQJKfKc66WaDvwSBiiAtHLt1u5e7D0fi0Uikc=;
 b=s/H8Zebp1AeAsmNO7Re6e7Zp5OJ9dmlaB3tOVz1HJFi2L5OXWJSJIhkE48a5fXaZD6aES+58UFgFFm5CU4zcd3GhGKqz3ytAX3ZM0p0elKhC3HiP0QnLibtRb1FU3mIyE+TyvYpu+3ExAsaM2HQGQdoqGh19Xxp8Zm0WXxhghQmG6CPPbOpEAwAtAnrDG+/k48FI4H3STho1i74lzRu4tgv1hCfoS/XVW8ZelhNSYI4TUsf/JvYgFeHhi7nfFlAvRiqGCXjXMgCYPY1hBUwVcsRjcjs7FEapmf/QVZUkVBP3MA+vpz9qiAad4bs+YFlYLlGZzGToqFsmP9UONTrOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtQROJQQJKfKc66WaDvwSBiiAtHLt1u5e7D0fi0Uikc=;
 b=h/eZbMZxvfGOdawm3inP+s5CMVjPAlHSiMlgdKoSeg6uKgoqYY5UCrCaF2qbCsLXxpU/acaoyH0y22NAZJibDUl3cV7hblmfQo5La0jSCrTkycAastyBfnuZH65eL9Xqe1Vq+ABzhrsQMlYoDLOMdtxz/iCDYawbE1VQOi5y+gMXer6h0+HK4NkwrjN2c8AVFcF6C6kSIJ986j1LI8sxAERyDSFYMEhXvA7ytOiMYqAsTfQKo3ZXF2BN7C1d1Zbkmiq+b3sfq/hEL/5g6l25OJ77bXKA7IISJISnAmrXZVonsWM5WpqRwDiOO/hjk0rXpjyDWsLT5CjZm8cagyAcLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 05:52:12 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:12 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 7/9] net/dpaa2: configure buffer layout
Date: Tue, 20 May 2025 11:21:31 +0530
Message-Id: <20250520055133.506071-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250520055133.506071-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 6762bd5a-0164-49de-96fe-08dd97627758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8cZMP5oHV66oGjWZw1fmsRXtWoazbmzBSiljGw271tsgkq/n6v1u5GbfefhA?=
 =?us-ascii?Q?3kOt89ZFGSgfB3ct86CeHKi0FwL/xwUcFBUETV7VB+IkVrmKBlxb2Lx/jbdk?=
 =?us-ascii?Q?SSXnaoDBkI889l/8aLzx2Dt3H4zR5F0r2XVvw32LbW4/K85iIgmcj6ek2yS2?=
 =?us-ascii?Q?fFCIoTZrJ/K4G5A8JMxmAvazRHnDNrATvp+8Wti1wUfLc33zTHjiuwXaNN3e?=
 =?us-ascii?Q?3hZW2OZN96mw3JcvLl9NfURb+IJ6xZQvxhvlXoD67hgNPwmcimzvfKwf+9HQ?=
 =?us-ascii?Q?QBqJ+UQ32yMERvZV3jwPrfzH+CJUxcmBrP63oObcFPl8olm/mt9pX4iW4Mqn?=
 =?us-ascii?Q?X7aP137J7rExCbIlsKD8KJ8tNXbJZxzJKExAbu8+bMMDASJf0hH2+elBL1Li?=
 =?us-ascii?Q?wwIqrc6bGdjaVcYbbnHZHXMK7PoxGwXNrmdYi2ZhRh4FZHuMRBUPQ9Nczouf?=
 =?us-ascii?Q?EuH7k0ngnDL7xwCdpHbt044j+36ETcBYeoFgva0no4POtZhbRgKHf1MQoT4y?=
 =?us-ascii?Q?SmZB87GSU6CBvlD+E09W7VBoTeUcLb8VUHjNVhNEoK9jHz3V5Le6qxHqMAA/?=
 =?us-ascii?Q?8itaXHPVJkHuC7ardMS6hJc71L9DNYlDzw8itD8svHlrNHMKIP7KUUuP4V7Y?=
 =?us-ascii?Q?cFJYb4UU0hjEWqflAnpURG0Zes32iEe/r36L2i1MmwuTke0+aC8o3T0D9bHr?=
 =?us-ascii?Q?uS3hpq8l26m2XPZ/ioaPyviTaS6JKBJm/L7gObfUlfUJWW86hHhTXQVHp3O/?=
 =?us-ascii?Q?zfhItrXm2CXEv+OxEIOC9pFOpcT9Bm4qu7Z7zjqshy3vgWaQXjPMqi35OSUJ?=
 =?us-ascii?Q?7S7tJ1+FRcFcUAOzc6Egd8RmXmNUwaf+6NfQ7K0iq4CD3T4kyjjW8WeulUSz?=
 =?us-ascii?Q?wsvQ+G5uQFhDDqQkXpj0FCK0C1I0f+fPPFO+rYlO38Iapmby4QrrXsq1S2L3?=
 =?us-ascii?Q?kls0rjtOI17ihHlA7fkEpEAgoBOOZsZE0LkSkzdMj8ehFRGSi4uwy1d7ibcR?=
 =?us-ascii?Q?kJtPHsNfPUDO+n2xH0wPKY3FQgeM0xYWxQKjpX6zoovPtth+8g104EM7vXpn?=
 =?us-ascii?Q?8EUcUGyavnps+/0x1aPk9jN/j0g/hwD3V9fAhfjHpQPCgZmDkcM/0ajSWNY+?=
 =?us-ascii?Q?TcZ3+p+1NytizOd3dk+gMn4Zae7S20D6zCYuHs4gjWUu5d0PC3MjunHSBQN7?=
 =?us-ascii?Q?PzGqkZGZtRWFPsiG2RjdoklitW+Om4P4cho2h/JJm66fZUWaATubIABs2oIy?=
 =?us-ascii?Q?Jdttmn3FW652B7CVztV0Cf3Vs9CsfkjT2T/kuB4U6/MqZAjXovocVMz3Mx9e?=
 =?us-ascii?Q?yurSLQVKqDAZRNYLmEk8kn8Hvebetz+Sw6oH64jQHI7T8ZPeDr8Uoe+bz8ye?=
 =?us-ascii?Q?HXbaMba9+Cnl1qcvFn3hTCOTjjmZal2mbjwL6e9HMZi7YynnLBMuRSbJ/RDj?=
 =?us-ascii?Q?wNmXSw5MIzoV2dEW1BswDZ/Q4f0Aio8aJiOAjl7mypAxEgRcx4NLuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RFJq471CVSqHAGpt24v5sc0z6L9+Vttvozb+nP6ZUkR345MZ+AaKqHKz+GGH?=
 =?us-ascii?Q?MHi0+gNR71+YQBCshi/Q1vaXvIqgBjjf6I4oWkt4E/F6txPfjrroJHT7fje2?=
 =?us-ascii?Q?Tc6kcTCX6wSHLxEaKSkm1oJ7AwYZCaGEUIFSgBNYw0WVHVzX91ejN3Qo9Bj9?=
 =?us-ascii?Q?yXCanGA6vmdJ8Z39hdeWm3BTNkCh+x4oa2IeH49jQ2MmqqjRUu/OLqvW/r70?=
 =?us-ascii?Q?zqWpxMXDKxdl/jBKL7t2Z+T0h0e8Im/8kCIXl1ImhZAyeA+2S+nDlNXFCk2M?=
 =?us-ascii?Q?M9yyO9QLbOgd6NnkZmcpld+6OSF+zyqEjen1hRk6S1hs2aajygQeoou9V7Gw?=
 =?us-ascii?Q?UxyjKnk8CKTz3FHUdGH+hGGoU3uqJKa0EiK6lnIzdrj8C9xM/GDn9s9V5tFh?=
 =?us-ascii?Q?SVn1TeudViFu3kb4CsYykP/W8E+zV6XcWsQCm1cM636fSiOP8sXeK21cqSuf?=
 =?us-ascii?Q?T9pkVXaP3NiJfesgx38/ga8N2Y7kadvhrojRUd5Pq6iRxMBC8rb4v01wSBFo?=
 =?us-ascii?Q?NUNMQoneCF0kQIuznlnEfdGCdZp1MS8npWywdR88aisVHbueS3rfa10N1nRU?=
 =?us-ascii?Q?P/75xWGFyAzcWlxIWBJHFVVK8+758LnNu8aoJ5bD14Mqazi+MPVaQ8YQVHx8?=
 =?us-ascii?Q?LSS7Sn5weRNAtzWRHDSa4iFrl+e8jvZ3J7hnkxDjZ380hkgHGCRsETWtfLrf?=
 =?us-ascii?Q?nwLIKXV7bqRMS7sAtXtGQ5BuYubxTJMFl2wdLCXo0zi7V6S2o1Ua8pTYx2RW?=
 =?us-ascii?Q?8MlPKKx2ngnKj3BVjXDjVeYiubS8zYkd3tOO6pqmphrocym1Z1Is+aVyLhy6?=
 =?us-ascii?Q?K22rzpaGxGKMy7T0S7Or7rOuy+5idWq/o8bMrKgDEqN4aXCZDb0IH+Derx0y?=
 =?us-ascii?Q?KchVzSZbCm7R9jiw5FRxOYd19g3mhTvdQqnCIzsB49IHGWcsV4RvlBb8bLGf?=
 =?us-ascii?Q?PJrDvUfIv7Oc8L0aPmHdB+kEM/zIgtgie6GI9PE+38o4AbeZyIQy2SBBgg5h?=
 =?us-ascii?Q?xe0+mSqSdvwdMV5Ue5/jLfZo1w3e+GxbpqGNi58D45TG0/0TOnysszBE/Mde?=
 =?us-ascii?Q?FK3Fmisdq0DfJATWHwg8hYGy1hlIAeXZNvLUqsOaDFvrsh8HpDn5Y+IsVay3?=
 =?us-ascii?Q?AdU+LZASqRtxepHbEN8dmqHqAobGQUUXcmLuQxKZM/WjRkkqD5HKD+hzvMNq?=
 =?us-ascii?Q?GQW45uuSgQBz/73AcIOz6JK6pBCbE62lfKrlB4XgB2g7DfG1d+TeS5AVHgZr?=
 =?us-ascii?Q?nJtZEU1cspkzsCx5QkgRHD2Hr8tyEgISX8ocHm+my0slDtSA9KchrDLpZpzd?=
 =?us-ascii?Q?W/FagQSaRn5yAjRDkDQu2Rb4lSQBjh/n/IB+XSKpCRdo7cDpLOptOlBdsFFr?=
 =?us-ascii?Q?Gl+MCEMGbw9RntSvGdRwMwbrYNwgU2/JWMGPIx3AkvNVE6Qmg5E5dmVXHFGI?=
 =?us-ascii?Q?Nkjv2ThaY83rYk0S75RDCJD58dooqXDh78MlmqHqnJ52Wl/R+7iU+D6ge1VU?=
 =?us-ascii?Q?esnI+41NSlPgFpVAH73Y9ICMGNMVK63u0jD9UxGh0gjXGzXqkN1gIdMW5jJa?=
 =?us-ascii?Q?cvdwV0ePyEhAGRb3MH4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6762bd5a-0164-49de-96fe-08dd97627758
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:12.3198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zICpFhHtbwlRZVRxdHXuVqFr7Qlwb7vTe6Svxh6vrWBBIdtiNEEOjMJnKFQdEJI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
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

From: Jun Yang <jun.yang@nxp.com>

Make header room big enough for IPSec with TX dynamic confirm enabled.
Ingress minimum header room:
64(size of parser result) + 8(address of SEC context) * 2.
Egress minimum header room:
88(FAEAD offset) + 8(FAEAD size) + 8(address of SEC context) * 2 +
114(expansion).

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h      | 10 ++++++++++
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    |  4 +---
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c       | 18 ++++++++++++++++--
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h |  6 ++++++
 drivers/net/dpaa2/dpaa2_ethdev.h             |  6 +++++-
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index be0719aac6..10bc191645 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -84,6 +84,16 @@
 #define DPAA2_INVALID_FLOW_ID 0xffff
 #define DPAA2_INVALID_CGID 0xff
 
+#define SEC_FLC_DHR_OUTBOUND	(-114)
+#define SEC_FLC_DHR_INBOUND	0
+
+/** Consider aligning with 8 bytes to multiply point size with 2.*/
+#define DPAA2_SEC_SIMPLE_FD_OB_MIN \
+	((-SEC_FLC_DHR_OUTBOUND) + sizeof(void *) * 2)
+
+#define DPAA2_SEC_SIMPLE_FD_IB_MIN \
+	((-SEC_FLC_DHR_INBOUND) + sizeof(void *) * 2)
+
 struct dpaa2_queue;
 
 struct eqresp_metadata {
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index e9b601c035..755c8e9cc3 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016,2020-2023 NXP
+ *   Copyright 2016,2020-2024 NXP
  *
  */
 
@@ -20,8 +20,6 @@ extern uint8_t cryptodev_driver_id;
 #define FLE_POOL_BUF_SIZE	256
 #define FLE_POOL_CACHE_SIZE	512
 #define FLE_SG_MEM_SIZE(num)	(FLE_POOL_BUF_SIZE + ((num) * 32))
-#define SEC_FLC_DHR_OUTBOUND	-114
-#define SEC_FLC_DHR_INBOUND	0
 
 #define MAX_QUEUES		64
 #define MAX_DESC_SIZE		64
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 8d00a86032..b1d473429a 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2021 NXP
+ *   Copyright 2016-2021,2023-2024 NXP
  *
  */
 
@@ -492,7 +492,21 @@ dpaa2_attach_bp_list(struct dpaa2_dev_priv *priv,
 	 */
 
 	/* ... rx buffer layout ... */
-	tot_size = RTE_PKTMBUF_HEADROOM;
+	if (priv->flags & DPAA2_TX_DYNAMIC_CONF_ENABLE) {
+		int out_min_hdr_room, in_min_hdr_room;
+		/** Additional headroom layout for IPSec with TX configure
+		 * dynamic enabled.
+		 */
+		in_min_hdr_room = DPAA2_RX_MIN_FD_OFFSET +
+			DPAA2_SEC_SIMPLE_FD_IB_MIN;
+		out_min_hdr_room = DPAA2_DYN_TX_MIN_FD_OFFSET +
+			DPAA2_SEC_SIMPLE_FD_OB_MIN;
+		tot_size = RTE_MAX(in_min_hdr_room, out_min_hdr_room);
+		if (tot_size < RTE_PKTMBUF_HEADROOM)
+			tot_size = RTE_PKTMBUF_HEADROOM;
+	} else {
+		tot_size = RTE_PKTMBUF_HEADROOM;
+	}
 	tot_size = RTE_ALIGN_CEIL(tot_size, DPAA2_PACKET_LAYOUT_ALIGN);
 
 	memset(&layout, 0, sizeof(struct dpni_buffer_layout));
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
index fb026d6e49..d156b07087 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
@@ -253,6 +253,9 @@ struct dpaa2_annot_hdr {
 #define PARSE_ERROR_CODE(var)		((uint64_t)(var) & 0xFF00000000000000)
 #define SOFT_PARSING_CONTEXT(var)	((uint64_t)(var) & 0x00FFFFFFFFFFFFFF)
 
+#define DPAA2_RX_MIN_FD_OFFSET \
+	(DPAA2_FD_PTA_SIZE + sizeof(struct dpaa2_annot_hdr))
+
 /*FAEAD offset in anmotation area*/
 #define DPAA2_FD_HW_ANNOT_FAEAD_OFFSET	0x58
 
@@ -261,6 +264,9 @@ struct dpaa2_faead {
 	uint32_t ctrl;
 };
 
+#define DPAA2_DYN_TX_MIN_FD_OFFSET \
+	(DPAA2_FD_HW_ANNOT_FAEAD_OFFSET + sizeof(struct dpaa2_faead))
+
 /*FAEAD bits */
 /*A2 OMB contains valid data*/
 #define DPAA2_ANNOT_FAEAD_A2V		0x20000000
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index fd3119247a..b9dd9b22fd 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -70,8 +70,12 @@
 /* Disable RX tail drop, default is enable */
 #define DPAA2_RX_TAILDROP_OFF	0x04
 /* Tx confirmation enabled */
-#define DPAA2_TX_CONF_ENABLE	0x06
+#define DPAA2_TX_CONF_ENABLE	0x08
 
+/* Tx dynamic confirmation enabled,
+ * only valid with Tx confirmation enabled.
+ */
+#define DPAA2_TX_DYNAMIC_CONF_ENABLE	0x10
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
 
-- 
2.25.1

