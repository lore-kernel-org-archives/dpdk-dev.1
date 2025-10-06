Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C440ACCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:06:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2391D406BB;
	Mon,  6 Oct 2025 10:04:59 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
 by mails.dpdk.org (Postfix) with ESMTP id 57EBB40A73
 for <dev@dpdk.org>; Mon,  6 Oct 2025 10:04:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woU3ipLoErOdm7AR79XhU2OBG1w6VxbAF0mdjoYWYLDvRAdYrvE/lXMpkgz6a4sTDGsjGPbsIz/Im+cQC7b93VRlGq3JA8EYpcKWKlN2uUYHRB5Kdu6fKFzOT/8Nm8ndJLbpMM/SnMXHfAEXUl1nOoPC6PwM5ivE0NMerhX8awHKPZwj3hsQMnXsUBZ6/D0mg5laIOdT3CYBQ909kkPWUKK7Wf/ptZ5Em35Kv1wRTSLq10j+BC0RWhrSBx9IKfAvx3OX8v7FjTOF5vicm7RFsgfyoQFQ1yt21gMn53c1a1K4Vf5WJuSdoL5Fekpv5eDTbub9AEQpXezfk1NC9y0bXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLxClkT0w9dBWqRcm99QkiCAb4Q7KER3qY9IYNoetCk=;
 b=LFtXW2wQJ1b9qAp5YBHeJHrbhAzgjcKg2nE5HVVT1VPceHL3C+BzibRl+nq5f27AIb4MhxnWJkWj2NEEEvwh7C7dkP2YwuPpVhcAoA4AnSR7q31etU19h82tX7ganqBIbTBK0jLgcrk4aaAd3NIF6pqRcDgVtO2RCFDzXYZCF9Gd7Mn8fFEMi2BSSOXvWyOODtaXcWpsI7uBr+swpMK73zF8wmpKNyUtT/c5eYXf5GT/yOoP1BjrgCmy830whK5DO+IGmrYOZP+HtK10szSFNkZ6kpjlq3T3jhM5AUb6aK2VkTzXs/PdryhJQnrFerSj4vNJ5bUppb72H03JAMWc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLxClkT0w9dBWqRcm99QkiCAb4Q7KER3qY9IYNoetCk=;
 b=YiLbBGHiYcotjJ+UKCfAJmbqOScmqj4SzRYOoIh+Aa+sJCH5cEy7Q9nogR30zWC6fVqF6G7grl80q9zROGnGNZWLZNigVVLJr2+ffhsOA/71UAl5Q440RiQik3T3TRMSLh0SjHHnSpLcsHHyTJ41PTITOV3MUgw6u9rRe6CEiu9t1RMlKrzHaun39ZCE2DG47EFwQqaCbTxDRxURe0YyjYZftIH4Vu1hfFzv9o+GDC3RcvTOuYDNnDo+0zbEksMPkXg0InClXsKG5mgJ5PN2wJXSJWZDTOH9sEYaSI67Rfc6sdDvHq59z09iBFhwCPOUXjWhXD9LY4aLXllhESeUiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GV1PR04MB10274.eurprd04.prod.outlook.com (2603:10a6:150:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:49 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:49 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Subject: [PATCH 11/11] net/enetfec: add software packet type parsing and
 cleanup
Date: Mon,  6 Oct 2025 13:34:10 +0530
Message-Id: <20251006080410.1433284-12-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|GV1PR04MB10274:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d6bb43-3fe3-4813-af16-08de04af054e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YnyfdbCBE1e4M1ssDPChfGCez2OmZX5m6mRB3tvB5pOBHPVQR9S0Wm/dgiq3?=
 =?us-ascii?Q?9iHLn9szXIUqgUcbrniZiJ6TXoHG65fJDKt0tmiLF3nHvj74qqehoW8kWsGd?=
 =?us-ascii?Q?tRxiX01p+b1SCK7G4/wFEXCWysa2Gc2q/yYP3zFRG1+HeaRCr2ZY2YJNXQlS?=
 =?us-ascii?Q?d8EkKwMLaVZopEc1+MLB2jUE5K6cgWjN5z8SHg4UwVXEUeiiIS+Xd7QNl1ev?=
 =?us-ascii?Q?sklEVmrOM8L+W9iB2RlrVlN+coQliWZlEOLmrNUzC6Kib6dcmadTdEAKSR3g?=
 =?us-ascii?Q?b40A+25mRWuQc3FICCfd0HBlsyxNxRyMQrGnexuQX3Pa7J9jvxwkT78Sy5A2?=
 =?us-ascii?Q?qNvzxeSA34DdPc2b2pE5eO/lFgKKijiIztWNCyhXwfMMCmxc3bjOZ8eHysN9?=
 =?us-ascii?Q?uhirwa2PjGDkDgz7Zgmr2BDErrcwPQutpXrxeNUUa9PY7e0U3wZT4vGKYIcu?=
 =?us-ascii?Q?X87DN4BD8x2aXxEZLg+iCdzM2hzoOi2EZfCCBP+LMOBmdhZqawr8SeuWCXKK?=
 =?us-ascii?Q?I2M104Xdu62OLYeurPLC9SZbA+0OyZcZQsF+wIzE+b4FsKJWsBGDFSYfMYYY?=
 =?us-ascii?Q?U7tt56r5h8Ko+tycGOL5tSQOXq728shy8Wr5D++pI5wEgyaSY3/6QocXCNoY?=
 =?us-ascii?Q?7IWgoDoAOo5P5J4Ybs0BUPodCd6xoTeCyb+5riHcZlwuSOzCw5dwXnaIPy8I?=
 =?us-ascii?Q?0P1UrKiH2xHJ9caW13yNCJtiF0r7ZB8kIJm6UTKF1WEJoR/UD1f/ocBZSXBZ?=
 =?us-ascii?Q?Gfsa1PJo4OPbZqUcoVVAAgZ14/zCBa+P6zdR1DDV4G3CgdnGm+lAZRhXdEHQ?=
 =?us-ascii?Q?qo2N8dMkWGrq1Z9BWrUGZkA0b/Sf1Zgo8+GsXFw9g080QYJLQ99VLVUP01yY?=
 =?us-ascii?Q?wune4h21Gfwimalv30LtklGsVMkW+PLxmaarXb3XrDQU2E0v6bfBKZpaww11?=
 =?us-ascii?Q?RpPCnUOSW0K4nvrlTtToI2C6hZ5+bdt4ZejNLzb03ZZ65gCdK7ys+nEqh8cr?=
 =?us-ascii?Q?KM8x5ZlM14dDII5fkA2plaDlXN1HTWBiNgoIcau7n/lzEH6KMvtEQAolIXZN?=
 =?us-ascii?Q?VZyMhmcjZadCwuPKL33ZhhI6pKbEIqkTmobehzKui67IlNp+SfCQZxonwSZP?=
 =?us-ascii?Q?MnW9vu2pHjuxi5bpUzoZT0ni9XwhWRyaO8V1GJEsp8yZNjjoBd/2dRJ6MTDU?=
 =?us-ascii?Q?dWmUNIiATPaEAbd72N2lK9953p0B76fWtNNhCRGaGci3A8LWQgNWQ5XOqcOm?=
 =?us-ascii?Q?Il5vQ83lXEfwoHqnGK+AiAA+Jdt930+95gZ48YK314c5oWSV47lJucaX0XSN?=
 =?us-ascii?Q?rCYqJXReMO2X25bMlTUjm02vZDL5eBWLK+SJ39WQUzPZkTUS+g7FDM8UWRrH?=
 =?us-ascii?Q?8J7f5mtlIj9HEN2XOAJ5VUGT1YmLUrVVJHxxNrtJTFQ0rqXeMBDgF6aKmI0I?=
 =?us-ascii?Q?PY98c9NVPtE2zfh9FiDxaneqFB0JOnQ1oDS8ZhK6FY8h0xRNhyIwUdW9PAv1?=
 =?us-ascii?Q?ZZxqDKjjaWoqlmEEbJZbjhmSye2hVTpeKpds?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LB/TH7JkzOHW6vZLjxRvk7CNDXDh6TYnRd7afptEYNElmr6mTd/4iab8Ybjk?=
 =?us-ascii?Q?jk+4VkhfQAMWJlGRdYnemMcsDsYtOMX73Grnr+hAdn/nyv8L6OhjLFukfAOw?=
 =?us-ascii?Q?yvvzYiDrE3U0bEU4vbPHfn0MDrRgl2EhuclYMDmVelz92kAmNqzHNaeLQjbq?=
 =?us-ascii?Q?zdUrBlvqpD8CZ6GaLH5WZybby/d8vvRkHN8E+g86cXhrYQAhAoae0Wz1OXVh?=
 =?us-ascii?Q?PUMCemOeRnK4ZBdcgXn40Cc06Y8NxORHUyeKo42a95i4MTVRS/5nQdswdNbw?=
 =?us-ascii?Q?WXxoThTiFgL/UC0iLWpVf3pEeuHbaw7VXJgYhAHywsb+FoQO9HuySjCDACXu?=
 =?us-ascii?Q?dXbNQ5sB7SuK1+xJHWPDCkOB6FjMTHOfBsJJ3roZ7XGHtgkYRrq5e/oWC9xR?=
 =?us-ascii?Q?eWLNiWbumsfauTaP0UY3qFgGLW7cwHXZYblsmgzltQtFRCTTUTkNSSkilEhw?=
 =?us-ascii?Q?Nbrh0pb1FBs6fFjP5qaEdbVCZdb56NxYQiUPkY6xzDdubybYyObiQpmeFtYX?=
 =?us-ascii?Q?3WfjM52U7R/rSoiS4aYqJlblL/hZoT+YrgS1w0ya2tznCnnJsnDmQ1JKX8Ku?=
 =?us-ascii?Q?uzpVNwy2jlA8QEZ/4+5wckstbe7OpQaaaMre7Kpj/sr8yVqwdpz6c6NEnQ63?=
 =?us-ascii?Q?KAJsgD+8Zuqp2N2LCmE5w10wHOFkNkUyJ7ZWRI0Fn8tBIrxBIql50eTqeyyt?=
 =?us-ascii?Q?hbGmp8E/gOd/rrx7Ssh5wEug0Ct6fkpr9V9sUmrdNjpvi+9AJfqrE2/nI8WK?=
 =?us-ascii?Q?2HoSx3i2jePf3mVNIQC5rdZ6JQVpx3rnroM9TNtkMpgbjOYGkBq1QAMxW499?=
 =?us-ascii?Q?5zAVyRBgSN36SsbmtWT5IW4xuSJakVKMZ+KnBfE2tnx7Dp25E8Nu2Hu+R5iX?=
 =?us-ascii?Q?jPsjEa6B0ZQopayExdhrliRSy5zZf9rDjKGtZcUnAcjmPm271KxkK+qDwGsG?=
 =?us-ascii?Q?uzDmRbpXlTFWzH5gpCLxcsDchO0Bib/kBrkpM38Xn+1Vadv3wwWOsU6oAfV/?=
 =?us-ascii?Q?lz0Y4nyZFG87TDqniMCAhw9bSvBnpni14GtqEaZIMNl3w1iaDgrpaKCXp9uS?=
 =?us-ascii?Q?dSpniuDJp/+dITMIoG7LT+MXgQoh8ykQeUZSC1jef9y/saA1zjygjdT731lR?=
 =?us-ascii?Q?E1Ktr1+gbL5UotgzgUkhOwRYgh19WfLxXSn1SW1wexBprC/rzFkQGqP8Jz1n?=
 =?us-ascii?Q?AcU62todD33L+wU4XE02ME2lgimsyDEVv6keO9MMYbRyuaVro9wSmPVp7dHx?=
 =?us-ascii?Q?lc5vafH0CXQwfFKri6gbK3DemiSxdq8g1mPrmUoUrh5aC3nTAnHp7RsZK/Pd?=
 =?us-ascii?Q?n8RXG+Hn5L744J5NyxOsRN+i6j/dsAX7iiQHzgGbS5gUST/uxv8P1DBxAVZk?=
 =?us-ascii?Q?5nbiaiaDLHvfiXw81GXoBDsgzHUbauN6O+FXuQm/8b5LABDtVp8I9hbUpLQu?=
 =?us-ascii?Q?H/FA1fXHWx24H/nK9F5RaQ88XOS7nCnCUPjt7kIbbc+e4GZgJywdRmc7ME3A?=
 =?us-ascii?Q?X4/4Jmg3Jn7/4H0nVRBFnPI3tDW85vMWDE734f3xfWoZ7Ff0aK6bf5gPnyMJ?=
 =?us-ascii?Q?lwPb3n8IivBXOtmzo2JhBobZ5NPOyq/sE36AfNN5tyR5tpQaAXzBi0vV01sU?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d6bb43-3fe3-4813-af16-08de04af054e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:48.9925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVRwFjlDvEItOBVldJ/rH/2VbSi+YuNuCXkz49K4t28sB/evG4aZPwsp6RRmMvlKk1odFEp3kmI03JzYE07HIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10274
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

This patch adds software-based parsing for Ethernet packet types,
specifically identifying IPv4 and IPv6 packets. This is a temporary
solution until hardware-based parsing is implemented.

Additionally, variable declarations in `enetfec_recv_pkts()` are
reordered to follow reverse Christmas tree style for better readability.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_rxtx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/enetfec/enet_rxtx.c b/drivers/net/enetfec/enet_rxtx.c
index 95767b561e..91a231af6c 100644
--- a/drivers/net/enetfec/enet_rxtx.c
+++ b/drivers/net/enetfec/enet_rxtx.c
@@ -17,12 +17,13 @@ enetfec_recv_pkts(void *rxq1, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts)
 {
 	struct rte_mempool *pool;
-	struct bufdesc *bdp;
 	struct rte_mbuf *mbuf, *new_mbuf = NULL;
 	unsigned short status;
 	unsigned short pkt_len;
 	int pkt_received = 0, index = 0;
+	struct rte_ether_hdr *eth;
 	void *data, *mbuf_data;
+	struct bufdesc *bdp;
 	uint16_t vlan_tag;
 	struct  bufdesc_ex *ebdp = NULL;
 	bool    vlan_packet_rcvd = false;
@@ -92,6 +93,16 @@ enetfec_recv_pkts(void *rxq1, struct rte_mbuf **rx_pkts,
 			data = rte_pktmbuf_adj(mbuf, 2);
 
 		rx_pkts[pkt_received] = mbuf;
+
+		/* Assuming Ethernet packets, doing software packet type parsing.
+		 * To be replaced by HW packet parsing
+		 */
+		eth = rte_pktmbuf_mtod(mbuf, struct rte_ether_hdr *);
+		mbuf->packet_type = RTE_PTYPE_L2_ETHER;
+		if (rte_be_to_cpu_16(eth->ether_type) == RTE_ETHER_TYPE_IPV4)
+			mbuf->packet_type |= RTE_PTYPE_L3_IPV4;
+		if (rte_be_to_cpu_16(eth->ether_type) == RTE_ETHER_TYPE_IPV6)
+			mbuf->packet_type |= RTE_PTYPE_L3_IPV6;
 		pkt_received++;
 
 		/* Extract the enhanced buffer descriptor */
-- 
2.25.1

