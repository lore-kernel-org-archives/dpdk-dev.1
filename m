Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D97C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 01:09:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A5B540281;
	Tue, 22 Jul 2025 03:09:41 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023141.outbound.protection.outlook.com [52.101.127.141])
 by mails.dpdk.org (Postfix) with ESMTP id 326AD4026C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 03:09:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j545rOdwMo2wQ1o4byNjIJe4mMgbp29oXUNw3/JyxXYrVZr8ZFvLK0wq4CW9eTXrGWoYH3wxWTIxNsmshaUGqMmHlFbgXsV5mDRW4BXTo2YGEB5wN6H9T94Un5gEy6Lc97Ey4GdBNhoZ2Tq8D2bXVZNuUhk5mzPvVqT3GFJEp1SSqBbuWQBazFtd6ozIbKYCWcIyasjhOesbT4bHGfBy0uUqnFVjtRMhyRVihuEMjREm/jbC/BW9p/yJNkjflHwQkz3d+8DeIvqpowGkJTVTC5JVEnlleNOql/TAFLZk45rYo3p+IaE4hZzto/ciX4nOv7TcdKLLO7GaS4XfB1+3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/UjWKfIU3vTkITCuknPT9YFfgpoOOvjoMqhAwYIjVI=;
 b=CtnawJb1TgP+l62CrYeKD/GmJzg3sqXZIRGJXvrlV7NER9yhfoRQlN2ci7564YKPZ1zJGE/6s1yQZTJ/P8B1R175yoT8VTH2um1YqEzYv20y18XBbXxgmpEbpeN2FZUVy41/FhY5nrn1PGqqFj4IY3U/mjD6yDZtrs63oiaJ3OlmAz1Q+2KIuoL3pr/KwGxDIPyisiP095uzCIHlR2Urbwfvaw14dAlPCDZUMfhkUkubuc76yPeFgEB4zvEU8OzJTXAgeDl9HjtEoH5c3ggEgiEgqUKiXcFC3JPGOtb50bj3rpruvvPBOX58hf7SIjXgAyn3KDbjwyGxA99+RjU+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/UjWKfIU3vTkITCuknPT9YFfgpoOOvjoMqhAwYIjVI=;
 b=IEmMCuxnKs9arcIgh78DRQkAXioaYXLO8UI4+aH+Z4IwPHC/A4i/2UBhHNr8OzteBMCSxZ6gAEbvzaIy6xhO1Jf1wZI/iMopR9mn952tEdLwJ1ArOACW+0G2qCX4HekVSlLg9GUh2FlnTj1U3eA3J2nagNPR2ow2E15gx2LWol82iUnKx1H1Tk4NMdV9o4OghxZltn0NeqQwN7YtCvWUVtRHxRW9KLfm1LMDkho1+yG/UC5LE1KjoaNVau6uKW3h27QISeHkya0a9OQdCh7H3D8KMmyBUq945anMEUE2Mo9AIeABnj0XTuVcW10R8ZlNGU1v2TH/ZJkF2OOZkZj75Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by TYQPR06MB8061.apcprd06.prod.outlook.com
 (2603:1096:405:2ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 01:09:34 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 01:09:33 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru
Subject: [PATCH v3] ethdev: Align enable logic handling with disable functions
Date: Tue, 22 Jul 2025 09:09:16 +0800
Message-Id: <20250722010916.33536-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|TYQPR06MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c3b8ad-c6f0-42a5-1fe3-08ddc8bc6b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aX71EOjlkI7f7Sn/oItVjFSnFSsnLNY3dUDQtRnhaBklUOGFwlyZYpheZ6Nk?=
 =?us-ascii?Q?YFQxWISnFGK7sVu55IOR6I8BSrwfzy2kQR5lHF0vt1GyGGGhymcsCX5vRbwU?=
 =?us-ascii?Q?gIxjWxrbu0TV8sbaUHwmrxPMJgBUcbDJ3PN2AtocBWH0RBhETvTv5PP6G+fG?=
 =?us-ascii?Q?d7lUCNHO2DNEk1YzMWJrqNa45zV/LePjU+FpLvB6fbsSbp2Qt0vJibyKyTBu?=
 =?us-ascii?Q?hi2ROnRo4cXC+CZNlY6DTvS5Mj0e+BCSACuV0tftL4sWyJM04Ye8sTWw5vDG?=
 =?us-ascii?Q?wI9lZCUXN26khtbEzVB+2AvkaJtFBhm50rVjnvyJYghj3SLdzuVnmv0VCdHj?=
 =?us-ascii?Q?683b3OrfsKTbreX81EU5spmuWfpsmtNTGGjEQG/Cgawoy3ENLm3plZMJ1yYw?=
 =?us-ascii?Q?tV9A3z1i/MtuzEwdUZGOGzYqKzWLkS2+d8wokffH5i/dKLgkGuwHvfzDLZAj?=
 =?us-ascii?Q?1FAR4AOVMHaOpPsPc0RpuluEQwvmfhsz0Hm5vTuiCDVfHgvuuU8JHuNOXmTz?=
 =?us-ascii?Q?LaRX+2JlmjQ0roe1/ZoqRg9r/a0BCye8RRz9Faca+uzY1c0kZhqlY+EcIGOC?=
 =?us-ascii?Q?3TRQnZkXfmvnr7PNAWN/bDtFOOoaPUQCfaqeCdwtMWNzFCt7GkSrQ7SUJvNz?=
 =?us-ascii?Q?Zhw8kyIfd9wOAo5nJGdvyQlHco87SafcVz+60yBhHU+e/Tx2avmmd49IVQK/?=
 =?us-ascii?Q?BWzCoDlaSIzWrrz/S+cVwt2q0fxVIx4rc62lFZ9kBz0kFeezl8PCaMFrjxSR?=
 =?us-ascii?Q?UjYuOJIKDRL3TbZGb+NWdwhpgB1n6LgHRzV43PtlHNpMVXilWsx5tstDQ/A9?=
 =?us-ascii?Q?ztwHx8Sb7dkXHtZFe8PHP1thI3txIYPcvmIfennP0q2LOuq9ivE3Ogyd+8OP?=
 =?us-ascii?Q?PnHAGGrjhRTQjUYbrEK9Ilq5JRgTL09RvF9tya/9GCA4/pBQyGFnb3V+0vBm?=
 =?us-ascii?Q?2wvZjgtmYK/s1Ok/qi6/45XOjFs1pqPlCMLpShZtVFGOc9qkyFuwMTqrGb7m?=
 =?us-ascii?Q?CrrIdR5KZlgHIpV7W9eFckXvZ4+s8RVfJ5ARPCxCcoJEtERbsmCAQIAd0f6k?=
 =?us-ascii?Q?5pPCnDlbU2FiEprJ4VAOEbNy9Z8dr2VUdgC+dYL7DA+R5w/7+V9YGt+/vkOy?=
 =?us-ascii?Q?hS308zEC9+dT1KmC1TKrkzxPK4n0ntajx0i9RykPKc21IlZKQS0WSFvE09Pq?=
 =?us-ascii?Q?frxtKmD6keehvsSbRp4jzDjqFWJhj1ksZ3rZX8YJRBhhtC1e/AgsKP9O7OIg?=
 =?us-ascii?Q?svOPiKqdwkxdIMnbgfS5oGJ8Tyt7+bZBgYyFOFVn/YcWWIwciN5G+ipWIR3M?=
 =?us-ascii?Q?Yn+/nbBRni8wgYHlOrz8NBxfBcAsqk1JHCdiBOkxjpHxyCa+Q1RXpOcjpC9G?=
 =?us-ascii?Q?1R5KZPkHfiG85m5Lv1Lb8Ut4+WjT/MrDih7szbd3qwuQcI1G6odtwJUM/tTN?=
 =?us-ascii?Q?JZ9xLl9wPeRaBhOUysJ+K84j/9pED37+N5cuZHp9GlnZdNQ+hicDNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzkEBnfe8XZ31piSg+eCYcoD1xU0zANz/xj4sz2xJNi7lEcWldXJGp8mAUYT?=
 =?us-ascii?Q?rQFUt13ZT6ChRr70v8w4tl+rMdR3Ur9P+emxZfLiVFKn+u/L3WTeWTbC6B3R?=
 =?us-ascii?Q?nixKLUhwgr0pX6LOHI74tCU+DnK0PV8HNXfjFv5+EtZkabaEL2xNpvby/CpH?=
 =?us-ascii?Q?YdDCQSx69qoFwZ/uaz0Tr5GDnU6hBtKlZlnx9F7qX5SYDajl6Zp9PnlPpw2c?=
 =?us-ascii?Q?Qy9xQLqXb7HAgH8xFaW8ywpJzf2H/laaWru7pidiNEoyz0Ok15xVO1Z4CuGI?=
 =?us-ascii?Q?QqbolbJPegXifr154D50CI6AIHU0TvPj/tCoHTc8hvQXM+kiYuuQvaj1NO8/?=
 =?us-ascii?Q?le0NAQgwqoMc2X8ZWMTiCYq3GGH2ZX68YONw/unl3nhc9U2AIaD6aHxcupqy?=
 =?us-ascii?Q?sEvaG7pBTr3fiMoErxRKDRFN8082WyyGAuxJ95BpKljoFenqJjgwIrEVlW0u?=
 =?us-ascii?Q?w1ywkqgSS6BY2XSHnCwPl6CVh7tVJp9AGcKg0zSYCxCmRVI+/F651cf5mfNZ?=
 =?us-ascii?Q?5HuOpPdSSSbpW3ZmLNPGsz+WAebMoCTU1BLdLICRxdLD15uCIX8DFa17nYEL?=
 =?us-ascii?Q?Z1DQ+vz6aNxJwm9z6IJV27ysOQv5R8n/gnLC7N2nLjftw5L+Z1IuI3pEfzVu?=
 =?us-ascii?Q?xoiA0d1gmNGN4yUX1ozqQBiNhWft5WIe8+GnCZbzbjrXP8ogOWf8rsRU7TQz?=
 =?us-ascii?Q?WrHaiiolre/evO02wvLzMRNogRn8UOAaV/iYtr3DZkt2qm6fLVp8qktSDn3I?=
 =?us-ascii?Q?9mYU1TQoDLTI+/yhuEeN9uz15erds/AHjr8Hkg+2OtVPtVUq3L3zVvjAket4?=
 =?us-ascii?Q?l9g1sAjIAoBguuCz9DxTq92ZViqZ6sIPKrn43CM9rnfxAbg61SLroIMPmnAW?=
 =?us-ascii?Q?2DzEzEGb3SonmlbmcbxCoYE1g+kqmiRPLcbkp/HjXUycfNyXMkawca1pMmjI?=
 =?us-ascii?Q?DWTu4Od+kfqV5v79lTNCnCuVuJwZZvFLNvbcd0mdipM8dRuAzak6KjnF18Yz?=
 =?us-ascii?Q?A0JSPr3V9X0TvXLIcNXEAOpzUvVEO8Qc70LkcmEmjyo/mzt0AneLly9bz3Dh?=
 =?us-ascii?Q?fjT8PMUTnJlO+daXSidaU9zN2INA4aIEyW4//CETWGQ4nUXJTIPo/QDwZBRD?=
 =?us-ascii?Q?I7lDb4lohGRE23RqDPJo/sHAS6Ba1hAyVtgXZClTCcC0wr4MEqyUQ9m9ovea?=
 =?us-ascii?Q?kLg1QQzBxL4p1vkx0Ac8GBn+VpcqJlF7PrYKuyjqw7+Dcxw3MFdPVMMiuxoT?=
 =?us-ascii?Q?4iHHSSw87Dwz5rxVjyFx+1gZLEUSOsD//hDWERKNT389oenLvUA75umDMv3a?=
 =?us-ascii?Q?RzpFToQXjBF1ke7d/wley6v+hxXcztm2d5XIuXRYrhHmmOkw5sK1b6+LDupC?=
 =?us-ascii?Q?dMZpNqyErDU3bXVfpXhl23HUL3rTT68mwkcz21L+VzZQHL5Mxh2gL0lzw58n?=
 =?us-ascii?Q?n4NR7aMXz8s67h19X4ysThW0x5SXrCJkwpZIoPGsk3VhyzgFftKB3yDekkP/?=
 =?us-ascii?Q?lhPI54ufRYoA6BFoNUn+vG/LpUwSemoeLxi29QhZ2apHM5mjGfPSBASOb4fA?=
 =?us-ascii?Q?/vyRbT3JPf+gO/fZZJAuvKD/z+oZQx1FFaQR3N79xCzVXYt/RsHqlasnhwtU?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c3b8ad-c6f0-42a5-1fe3-08ddc8bc6b31
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 01:09:33.7769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXmgCjKeAVw9+61J0tT6kjBRjxJupUT1o3E7T0/my0AlAz/OtpGbjsf7S3k1bgHjor8ZBOnWEauARl2vTYQ8DRDCC4OxrL5uIqNzzJumZt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8061
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

This patch modifies the handling logic of the "enable" related
operations. The key intention is to align it with the processing
approach of the "disable" functions.
Previously, there was an inconsistency in how failure scenarios were
dealt with between the "enable" and "disable" logic. Now, after
adjustment, their behaviors in exceptional cases are made more uniform.
Importantly, this change does not introduce any alteration to the actual
runtime behavior of the functions; it only serves to enhance code
consistency and maintainability, making the overall logic easier to
understand and maintain in the long run.
In this way, we ensure the codebase follows a more cohesive pattern,
reducing potential confusion during future development and maintenance
efforts that could stem from logical disparities.

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 lib/ethdev/rte_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..41f96071e2 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3018,7 +3018,8 @@ rte_eth_promiscuous_enable(uint16_t port_id)
 		return -ENOTSUP;
 
 	diag = dev->dev_ops->promiscuous_enable(dev);
-	dev->data->promiscuous = (diag == 0) ? 1 : 0;
+	if (diag == 0)
+		dev->data->promiscuous = 1;
 
 	diag = eth_err(port_id, diag);
 
@@ -3086,7 +3087,8 @@ rte_eth_allmulticast_enable(uint16_t port_id)
 	if (dev->dev_ops->allmulticast_enable == NULL)
 		return -ENOTSUP;
 	diag = dev->dev_ops->allmulticast_enable(dev);
-	dev->data->all_multicast = (diag == 0) ? 1 : 0;
+	if (diag == 0)
+		dev->data->all_multicast = 1;
 
 	diag = eth_err(port_id, diag);
 
-- 
2.19.0.rc0.windows.1

