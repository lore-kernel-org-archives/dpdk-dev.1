Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D663CCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A30F40685;
	Mon,  6 Oct 2025 10:04:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
 by mails.dpdk.org (Postfix) with ESMTP id EDDE540613;
 Mon,  6 Oct 2025 10:04:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRrYnci+7LfwZRWVrIl1iv52RqGXX+KQmJiwU44rntJMe73cl0emjDccAfd5y5K8tEukBvfoPgnnIIsk8knprK+Uo6eieXKI3Z2yRifgQbao0QTgp4Ncg7bfWIjtmUQdqHs+D1U6+iaGaV0qEXXY9OrmHTd8LBXEp0krLOOME2KhsBDfcE4kMFRkDOnEgz0TznN/xB/8CxTpXwy2KFUpdbunVgBQ71GJOpKF64Sug8xTxbULjLhX8NHf2cG9wPAwQUkNhk+Zt9UFAI+Sp4mhQsPzNAcADW/MTWzyFGA9zzBCgmUvdeTJlFlwfkoInj73V/LXOqAJq5MT0orwxIU9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg1Kof+kZZAS2KZhK1sVdvbY/ffcuOUR8jWdjAnaLjU=;
 b=n8nyxUl8enkiEdTNfsPUetJikH+B+tD2SvDJZT5QbI6ckObEk6swnsgyzyYppd0CLwBoe/VwUSYWwxa6tRZaUhbAsuRa1vS62ldOAvLVamTf5hVoRPF0oBARmeSjZBAroya0oIu9R86pbDyRFBwlWYKp/XXhWx+Ryjh22pT+qs+I2MfozpWKjVoMhhlwRdy6G8HtymD5WLcKgrMBoG4laodQ1+Quh6MjrwqHBH2LlmGyGz+EDrrM/wmFxOHFPTmlHSvYJmue6yMsjN/LuWBQfIeJRSJzJ3UATfl0gyRhr8EdWu/MKL1V1M+ybos3TCkDUxQ0kzV3AFjAuli8N/u+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg1Kof+kZZAS2KZhK1sVdvbY/ffcuOUR8jWdjAnaLjU=;
 b=Q1f4d0QML/bSUkH7DqckGsqTyv+1DZRVHhyNvPIM6JA8TSjaGBdSxFtpX+MYRTc8wg2OHK/ZHmsN0jNNCvParXTj9VXWAxVYMLjuAvJa3EUYooCsorS+Gm8wipakRS7Tm+tqAjZ/is8kpZZyw6/PcEGHBiRg3OVser/TcU2pBdwn0q953RJCVxtwPEQ/RlN1/z8gXlJx69lBdqEiE5ktie2wUd9wwavLfKzOCs0UwJPf/Ip8W9qE4e9YioSHNjzyJO21FtjYDqUMALPIE/QsHSwc/1jU3f6khl9OMMyP2brM6pkCkiC5pgnTV2Isqgi7Uun4Rk+68/kFm3FvXVnJdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:38 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:38 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org
Subject: [PATCH 05/11] net/enetfec: fix checksum flag handling and error return
Date: Mon,  6 Oct 2025 13:34:04 +0530
Message-Id: <20251006080410.1433284-6-hemant.agrawal@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: d6edc658-3099-4e10-bb34-08de04aefec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5q/0SBOgI5PGai/HItwVuRZtP5cr3CfuPOGB6EAlMREqihAd6RmNveOCxQaX?=
 =?us-ascii?Q?ayTb2VMpIQj+dn56pNnkfXZzl7TRAW0SCyGWJ+zltGTRvibiO2QPymtVMSXY?=
 =?us-ascii?Q?0jvQj/y34lCF2MMR4XbRvOsB4falKQJlCfbMisJhF5clvkbFBBk9vw6mG1uT?=
 =?us-ascii?Q?oodWd4cv7S+5yLO2xLtE8KorECHeNTLWPaMex4OhNbSgLZLpVOIdZnjzVOuP?=
 =?us-ascii?Q?ZrlAT7K7zN2OTAxbd/0+hRksmB/2STBEj2kQhkyyXTwIelnAh6dq9AWJXJZA?=
 =?us-ascii?Q?v8lFCfT2NVN2DKf7Hne2E0JdXR/JX/eXMTrdvZhMu5rbOPRrlBJ0w+EecL+Q?=
 =?us-ascii?Q?tXE2TLaJHkLL2AnuTIrFb3T4PVh9nn1MRV+irg5/g7zDPFawCnxLC77UsSSI?=
 =?us-ascii?Q?Kr7qUUoqdR4Ye4IkPeFxwx4LBEBSCPaVywChTr4r9OGc3jHXoFSLgKW4dS7w?=
 =?us-ascii?Q?dQw8KAHGL3Pjo05lS7Fs6k4iCH/j3PhfnQh5n4TblKad0j3JvjIz8n6BbY4C?=
 =?us-ascii?Q?FtCm5fo5wctEcwLfoPxmLa66mIlP2Xq56rddWA1vEAICHfzK1MDaBVBFi9HY?=
 =?us-ascii?Q?wAvGvLMIp3koV6+u+UJ6oWrbVk5BSrQy6xMdpyrOeIk7xR5CkeT8HpRk//Go?=
 =?us-ascii?Q?RDd1Tc4joGW3jCFfLSWhWNUrPblE/Rn27A+00/gw2f+BJMu7gTchfHx2aMuG?=
 =?us-ascii?Q?dG2QVBJRUfQPyuvo1RkdgavqGlWRO+Xr5AcCNtQA/327Z7FxjKvuJk32c6DS?=
 =?us-ascii?Q?adGtV32Y5xMQZfKz9W2wBd2lAvZJZLBAHKymnjQJMgoGddaJ4gEjCCfyouM0?=
 =?us-ascii?Q?wVcy0LbfcHOvQITYF9llIlJKGAWxngGiTLvW4kCKP72ywhQlekJI4xcpcNpn?=
 =?us-ascii?Q?Y114we/F41dDPZYYuXI4eFSgdqW4KGwYVgKhEIk6Yc3qsoAQW+3d0A+bIYI9?=
 =?us-ascii?Q?7nWuqsrQs0EvpC6rCdki0nVK3Jy4wSIyL+8cUZhlYzS/TAFtcF3x9P4AQHgI?=
 =?us-ascii?Q?10+1j0OMmLSy1dliJcj3AoRQRoZb037nNkQzbkZnIX7A7bCkAwjGD98qm/XD?=
 =?us-ascii?Q?Qx6EFsDEQlyyDtQZS7VCcaIb9a+mHt4xh7MSAfhHh7qha3o04ywR4HgoLjuT?=
 =?us-ascii?Q?cJe1FJgri4ZNeQWOr2IYyjurxilcYYAD6/1iTsPDLwiFhn6GxJO2tckqTNjt?=
 =?us-ascii?Q?2WrC02mCDEDnz3ok1NHvfKgTbeLu7hxypxk9Cl0HQtymGKm68i6yPiN30IVt?=
 =?us-ascii?Q?7svcmULI8HQR2eBndheg7LHpxCdlf4YGr3EeN3+9QG8zqlfHAphCKaGcVgkS?=
 =?us-ascii?Q?AGNqaVlmTOQ0GVDoZAdpzEDXa693lkMFwku6NE3jZRmR4Ro3nLqQtYiASPQ5?=
 =?us-ascii?Q?JYLJVnHRFM5A2kBVL4hXc7XJCM9rF1yWd8dixIDxbEor3JoCr1Wc6lqBXKT0?=
 =?us-ascii?Q?hj3gaWX2v4YccEusDGjMpwO9JitkLL+Sq3pOv3jht0MrKZgoGmw9NFW85p1G?=
 =?us-ascii?Q?QnzdBJZ4a6ZxU3XxVF71FAviWqcLKLYYiTl4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zfGD6S8Vr+pOGL2W9lpp710P+Cw2nhxm3s/qhI4s2dV2w0aOtfGNE7mgrrxX?=
 =?us-ascii?Q?xZgDOyhst2pkGmPXpeaSR8hcw/n/K1HMy/AuWlsE0ayowgm8JTo3Wo7196LD?=
 =?us-ascii?Q?weZIMrKW1I0s6+Gl48xGbst1CjAfn/b3+eUUqQi7vvp9162swi9m0EAcD7Xb?=
 =?us-ascii?Q?5RY+yRkBnLSdeaK22iuAhmcUPbviGWgD6CFqHhKK+YSUjsz77QJaJRNM8x1G?=
 =?us-ascii?Q?m+rYJUjFs3MyEO0QGtmUU02oa+OFrPt1UoJ0m40ao2InGXwNkR+YzvrjUcFz?=
 =?us-ascii?Q?9CNlHEXxMvYGKp7Lf5LH4Jbikl/lB/J9iyWcmCPTg5y9UgDq+oCUJcdyBDJx?=
 =?us-ascii?Q?u0EUgVOgkobBby5eRAFS+cPa2lJKs1YpOl59k/pSPCu0x3PQjNI0uS9FRQYl?=
 =?us-ascii?Q?K5IfESpdrH8Fa42ks80qUvdgL2NmdJXk4jwUmFB0Mm/O/t1owLMnVOsqrKnd?=
 =?us-ascii?Q?+KLD8WIvCbtMUj5YnSdOptrjoUTHYPsw3f0OE/HcPsZ8dZdFQtJIMf5/u9YI?=
 =?us-ascii?Q?TMB2zprRC1cVVkM/VWrXRDn2heKkSP0e7JMMEpMxgDaPZBOi9j5wlKZx/KzT?=
 =?us-ascii?Q?qlHccnjv9swBnFXsD4OIU3/LIPV/5hJTowALi0VMgoJoSdr6z4GUKuaZTCd0?=
 =?us-ascii?Q?+Jyo5E3sPVKxoCWYRkNjMvsdElaxWBd6USHW2nfsYSw5UElNomx6D1v5dGOl?=
 =?us-ascii?Q?wjIys8VPoXS793dhhrh76zzbyPkGGgDWrQstF6i2cXbO+WnomTwnc6vFnSQ5?=
 =?us-ascii?Q?5wIrV790/xyCEuky9mrzsoREUZjZn8XzDqR3PigaNtk2lIGB/IkPuCQr5h3U?=
 =?us-ascii?Q?Im3xGa0L27C5GiEIe8pxTwRT2HT33Qsp8ArHr13cHJkGa/sL78KYVucUp/A7?=
 =?us-ascii?Q?o9YKtEM3/6U51OQ2HRFYHogQZM+61/J2Mefm6yWWq3nh14wjmosDOVJOirS0?=
 =?us-ascii?Q?vBhfMsYFewJwRz54c0Ztu+YR6OZ3/m+fJfLACnHwaldCLo2NotAaTkspuhlw?=
 =?us-ascii?Q?Icuxgy3IoWQh1yPibTZmwYG24Zoys9l9djiGygts+Rb+9xHom7odxLrZPRSC?=
 =?us-ascii?Q?G9d4il/n88eIs7z0QOjatB/qeJKmiETFvBIM4CLwR4lpKpncZtBq0JseWyl2?=
 =?us-ascii?Q?uLqCzQCgmzKQX3PH5eM+dUvL7it9b/X98djT5dFXd186reN9BOwP6en9PGBS?=
 =?us-ascii?Q?vO0q2Xrn6UdhN9fgbqj8HG/HRMk+x4FhpHvaTcT0wpLpGP6ClPvwFij3zUzQ?=
 =?us-ascii?Q?O6Vxl1oGOKBSC19Y4+/xCjGMgUba2jp9J+ayc3xWbNpqHRyJl97QZbhagxX9?=
 =?us-ascii?Q?pKFGltceXtk/5aaX3zjvpNBp+ofWApx9VV3F4CYuPii/7JiyZijO5NRlB/ZE?=
 =?us-ascii?Q?t+nUDItmyI0bZYzbTcG8Cb5a4cs+xKeMoM6hwxN1JJ0D405y+5zQNP8OR5+q?=
 =?us-ascii?Q?AL+vsDN4RfLlJSXCcPGpboing4rm7HVO9VtCllk/Td87So6byS3IeCKMeYZa?=
 =?us-ascii?Q?4S+4XLlUeqqeWg/jZCGm9WJniE8+FBJG7YuS4+L3CZa5YLeMrRlpc7ZgQNHo?=
 =?us-ascii?Q?4jVoEDAthP4pM/2RKxz31eSrMdb21SqSUOrLL9ne?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6edc658-3099-4e10-bb34-08de04aefec6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:38.0805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhOhn7181CZBMiopX+K1jy2mZlnsm7Qe+EvuVBSpuwWkW90IuBqqgoe+FA0yAx5+BaqaWiRVavjAMRTmOL9iQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
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

- Corrects the logic for setting RX checksum flags based on error status.
- Updates TX checksum offload condition to check for TX flags.
- Fixes incorrect error return in RX queue setup by replacing `errno`
with `-ENOMEM`.

Fixes: ecae71571b0d ("net/enetfec: support Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_rxtx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/enetfec/enet_rxtx.c b/drivers/net/enetfec/enet_rxtx.c
index 0aea8b240d..ea2c28a26b 100644
--- a/drivers/net/enetfec/enet_rxtx.c
+++ b/drivers/net/enetfec/enet_rxtx.c
@@ -121,10 +121,11 @@ enetfec_recv_pkts(void *rxq1, struct rte_mbuf **rx_pkts,
 			(rxq->fep->flag_csum & RX_FLAG_CSUM_EN)) {
 			if ((rte_read32(&ebdp->bd_esc) &
 				rte_cpu_to_le_32(RX_FLAG_CSUM_ERR)) == 0) {
-				/* don't check it */
-				mbuf->ol_flags = RTE_MBUF_F_RX_IP_CKSUM_BAD;
-			} else {
+				/* No checksum error - checksum is good */
 				mbuf->ol_flags = RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+			} else {
+				/* Checksum error detected */
+				mbuf->ol_flags = RTE_MBUF_F_RX_IP_CKSUM_BAD;
 			}
 		}
 
@@ -238,7 +239,8 @@ enetfec_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		if (txq->fep->bufdesc_ex) {
 			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
 
-			if (mbuf->ol_flags == RTE_MBUF_F_RX_IP_CKSUM_GOOD)
+			if (mbuf->ol_flags & (RTE_MBUF_F_TX_IP_CKSUM | RTE_MBUF_F_TX_TCP_CKSUM |
+					RTE_MBUF_F_TX_UDP_CKSUM | RTE_MBUF_F_TX_SCTP_CKSUM))
 				estatus |= TX_BD_PINS | TX_BD_IINS;
 
 			rte_write32(0, &ebdp->bd_bdu);
-- 
2.25.1

