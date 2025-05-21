Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB77C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:57:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B005440EDD;
	Wed, 21 May 2025 08:57:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
 by mails.dpdk.org (Postfix) with ESMTP id 05A7640EDB;
 Wed, 21 May 2025 08:57:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKlSSIdKuiAMu8BmiBWnVA8l/MP4b/JYUU3D6hU1ztQEOqW3J56WixQ28BLCqcTrvMAh4Dvw2nPkprLbYbCNi/OnBPG/7HFWFuXgrg23tWzZ3kg9ri9rmyh3vkYNStjPDAIFrV04PvkhX/+l8jrfrsApz/wBSEV2Qam+nFMpV00PVAX74m6D0uCh4URDzVuNA0t+7TUDHSfvayqDC+mKM7YpqJXVr3VjRam22+qgCchYSHCA7KDoVUlK+LAs7vQ1v3l54d9OipXAl7Bzoo1kM3Ai3dwitIEK3ApRPl1gNoOwK1ZnFl6gCQW6nxUXls/jcKWs13GtVyVV/TKIRnDyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0XFDLy4ZhI4mTw1GHdbgwg2iFRDRwD7VSK6bTXtikU=;
 b=FpvBP0crahnZLv4tC7XdPzjZxyvTn2S82owByUI/rNZaxqZstr4B2vI24u+NKSqhb0ekeAFq/79wKXzPzgAKTUnPBpuFgqseBkce6rJqPWgcXPgqhDQk/c/094bQjKipxQXjs3kcxdkM8iVNoINpuuATOluQL8EjZzIwnbHxf402OIpXbvySs1+8UfG2G0MOA9z6OyCHjLjkIebvR5ReNHtit1zM3oibm7L9EKR3QW4YBezr3CO7cbZIlmKQhiHV6T6lz5qF+u9yhnrkQ38XLqLmRbQYy9olEttIVAgH48II0g7RmLoLX+WfghzF6OP+ZdIDEZCHhT3KkIvHjT6HLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0XFDLy4ZhI4mTw1GHdbgwg2iFRDRwD7VSK6bTXtikU=;
 b=QMzikaX1Yc2V63N1fWcUs134D3x7dCzkL6CruM1j0EJj9RBW7AicUkdGJJIECFz1YrqJbIPt64aDHFilQA/nd2QNX9ZsUPPzcv4VPJW4du/Q6MZQ3oIZ/7O+zQ2XhOAdsq88Bygrdun0UK2ypwBiyT+dOrqtb4WnbnciASAHWr1htUbXusxgwiSneOoiEmqg0W2SNORw7XIYAjkJT0yf0PX3HhzTMob49it9XLLYwHS15cgLni5qwc0GSSwIBsc4XZkI5VgvqYDH4UhtGlJK4iRl3Lr69Hs31jyzP6YYUtv130lDE0dDprJEJh9+83TeCuDdRLgHpMjy/BlilSPJCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:57:20 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:19 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Franck Lenormand <franck.lenormand@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v2 2/9] common/dpaax: fix for PDCP AES only 12bit SN case
Date: Wed, 21 May 2025 12:26:51 +0530
Message-Id: <20250521065658.857707-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2eb2b3-1e5c-4d96-dff3-08dd9834baac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TnNwtzQ7HkTKJtafz/6mdxQodEew+rH9BCSoch9ebdl8lbVZe6hJ4gZ8MA1T?=
 =?us-ascii?Q?GU2RVuvb3Pn4zEqKFY8ncwhSF9aacn/s5iRf8QX+mOQUxE/lhW1jV/5fATgD?=
 =?us-ascii?Q?j02o0o7vnhYxXgUJpt5cDvGhnoddJe2nCzRVkzJzd6fSeLwEC2rwL0hFQJwH?=
 =?us-ascii?Q?BBoHIk+4YbaM1ktFinN0d3ByV9EmVbDRUxF0pdf728W1zN6izFrK0eT8sHOP?=
 =?us-ascii?Q?NFWx53gGJvzYFWIy0lsLbt9di1vcmwpkU3g9X8qGxFq/4amdigIgH7QegBQE?=
 =?us-ascii?Q?nhVWiCC4OnYrl/36RYViuI3XfDNnpYYltOBT/5rDTfa/Kt2ojMQPEAcM4p3n?=
 =?us-ascii?Q?u/liYIju2aeQoKgP8PGBpbszYpu8UGCusZ1QvXXt6Br/XkP97IdI0xNItw81?=
 =?us-ascii?Q?FAKbY1t3QVJ5D0SRPAyyPbrvbKBJASO0y5mBl57+MUfRHEyHqNhELvDmfBBP?=
 =?us-ascii?Q?j3lCFBpaNL78vlgHUZgbk4am/jPnB+xkkbCgJqXdO6PULttpfjNGvUfmjUUm?=
 =?us-ascii?Q?W+GRoJDP86l7cJVNJy3BNHSAMTpRR1wcquoqdO1E61rgrUmIyO5exQRyXZjK?=
 =?us-ascii?Q?Iq0hCo38fCjjgldvcRsJwqdRk6owbMIjUJr7w6IVS8S3RLSwanf/X1zJJkXI?=
 =?us-ascii?Q?MQFwwtO/gbitsL4/yWrTcY6t7KQoFnrrC/PY/vFeQqekO0EUtD5Gm1lah7xl?=
 =?us-ascii?Q?klswesJCsSuMlT6JfXGkDUQOAGImbhhMSrPcew/T5jbCWPtTL0ohTyiLbNMt?=
 =?us-ascii?Q?LTP5bu3d6ySeBa4DXBR3g6RR11GoGUltuKz9/VQ12LxqNkgKgskgafh4B82o?=
 =?us-ascii?Q?4XF9k+ms4PbQYQg/yfruE+2dVF/3NvvXZ0UGQMrIBvYGgNAFJL2Hcp96Y7ZS?=
 =?us-ascii?Q?A8c+732t2h6dKbjrev56CSOux0xWafm76UyJhhB1hRiXMGhfFGRKm4rEkQJu?=
 =?us-ascii?Q?uNJ0IRpzUjdL2kXOxNSDB9jmdzImUowYaivrbJU/avFxOMH+KEy50d95mIf4?=
 =?us-ascii?Q?bgYJ/q9Kor62kGuh/4Fe6HdIQVA+ZB7Uyc5lA3KM4gUcqVo4S6IHF4HR7JEP?=
 =?us-ascii?Q?/n/BMwenUsGoZt4TdVaigl3Og5tGBK/UX8MKsTmDxYiEml5021pqr2aUhH/b?=
 =?us-ascii?Q?TS+65Fk2LZwp/jcitovvGiXgyOjeAb0LP/VILTyujUlLDPfjXTCuXEOuOya8?=
 =?us-ascii?Q?GA8PgKDdC04H/ow6fTLqFSzIYwqqFhYhxkK2hEGmFmTjFRczDo/ZtMEx6EM0?=
 =?us-ascii?Q?Z5bAWNIO11GsPaLa4aYcxW03zZZlsxqnVwaeXeb8M05qht/rD7aBXEdFrSfT?=
 =?us-ascii?Q?Kyp2nBmfCGKnjhi6w3xJ5OwdgYJHrJtfrph/qw+O2BpVwjmXSZWsZu1mLzFK?=
 =?us-ascii?Q?U6X4HHyhayXIx2kWTRuYhwLf/A5G/piCnzMfllZ2pXh+ieq6lqxb8qzl8Pct?=
 =?us-ascii?Q?Nu5slxIkD7qyXLl2QAUrMVbm0RmNxefjV0gBcpgoqMQ60ciO6Wp2Xw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xUC81HjZOKQ9TWpMvwhqy8SWjQ6v9NUK/y7V+dySHhmjm/XdKwGjWBBxjknd?=
 =?us-ascii?Q?C1bbUYTZyydqmfQhlKdHhC/WVakHtujDzsNuDLtIoCJT5eH6lY1igprz8I5A?=
 =?us-ascii?Q?MbR1MYJZT5H20iMlcryk3uarS2mDaZwCeY6cp7PmuQft8dvWlN+1JHJocxtK?=
 =?us-ascii?Q?Ssa6NWfXrHXD5dAOLoLy3eBQ8KPj155PyIqhnnm2v77JaPOG53P3Bc13Z6nQ?=
 =?us-ascii?Q?TiiraJwKO27ot37hA1wZtTRe67IGLKmqGTBz9HQoTkroGqCJg/hbscQYdEer?=
 =?us-ascii?Q?6a8XbF11HgyQI4tsuj481SAvoOAQc4N/QvcFwfkwfV2ZerhxSGmIFbUSik/N?=
 =?us-ascii?Q?qzbz8cp8r0Nk+cZw6I5RvzzeHEH2MW4dtAfhY0SlIh5gIHAw0dluFajI/28b?=
 =?us-ascii?Q?1dN21TNw4Y9UQxQBU8RDC/jZ0w4+C4SFck8Hm8J0xeFvh0r4JMH0PejInmSN?=
 =?us-ascii?Q?Dm85kq3DIKLkTKTDUJTuizwWlFeVERbE4XNseqUsZy/MvALfiNsMvhobIrC5?=
 =?us-ascii?Q?XQnjpIg9FT81DF03KrYadnrW4nPE8XZqZuydC8sjqHDPgxV94l9qxzajUdmU?=
 =?us-ascii?Q?minJPhnQt5FF+hrFpxsUvjh50SFg9FeamgxjbpYeBsuIsiEh3EY3cLupvBot?=
 =?us-ascii?Q?20S+vpKmW/SUzi2RE0JHEGy29k2GztjCeHDINlRo2qjFu2QIbGHLGROXGzxg?=
 =?us-ascii?Q?ZgartQ2pk0mP57SJ5TqTg098ovpDqRJs3fHWi8irDyCejMUGiD44ta5chEDx?=
 =?us-ascii?Q?t+yShk49qnRy5HK0WyXtfGOLbZTVaejMH+qp+CFGLOJlF+HiPW/ZDtD0TGFb?=
 =?us-ascii?Q?RBvfZ87E2JacvRfZu/Dg21Bpadk6pW7gA3YxisqfTT4Yu6KoqWFHcqWqdZPx?=
 =?us-ascii?Q?o9vy10Z6njy8WtpqwHuWNVkoS76ogruc4qZN5n0eMhjZepBSBw3dJ78vN9v3?=
 =?us-ascii?Q?IkXxyJpT9+/f+bW2ZZAkDTKtCy2PcckFbHHfdbbze5seVGo+fKr0SRyZCxeM?=
 =?us-ascii?Q?WpxjaxRWM30aCUL02QJpMC75KzxSi0aDnz3v5mceiA3W5X/5S/i5xYoCuQ/Z?=
 =?us-ascii?Q?HumNFEiXrT54Mva19bqHTjyF1awCEQj4iYQ7YE7Q+oDkmpKFYoDu2rsJ/Elg?=
 =?us-ascii?Q?2ulJZ2HAbFNzRNImAfyIa0gwvFIB2fbBIOoRUAyOIuVJHFQ4ncf9HZ6HMEWM?=
 =?us-ascii?Q?OhXLa7L8120u1dkOcUXn+c4i1OEgB17pw3YyLrHNCMytRcucvVwBQAqz38ZK?=
 =?us-ascii?Q?blffwx7Um5JyIMAjp+czvtVng2Neys4nP9Gm9dWN+QNIpZzzw0WCh/pLfdcX?=
 =?us-ascii?Q?EDlRHnBDMyeBtQPePj790Mn4pxhEAvpPeqBvai4suF1MlbiXI5bfDfw+edpU?=
 =?us-ascii?Q?iuW0pY4ZJ7kGsx73gKqaiflF0V05Aww2XEaRMhVhEz4T7sSjwbVXyn9jx/As?=
 =?us-ascii?Q?CFX4Oa5amPQiG9/Q+AFL6R0gW//ppErn9fWQqba3H/IhZX4dgvk6wEAU2NIP?=
 =?us-ascii?Q?rZcn2c2vO/BQDtRpk7i2m/RRyewcc48qyDgGkgazHf5sH1PBA3HRnLdVJh9U?=
 =?us-ascii?Q?R5N0EfPj7WaVqxGoX9s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2eb2b3-1e5c-4d96-dff3-08dd9834baac
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:19.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6ACX4nDgVsZQS1y7SqDyr5afCbEsFDQC+HkfOBPZ6ubL+9KWsNNm+RO6SX3R3K1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
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

This workaround fixes the invalid key command SEC error.
Fixes: 6127fff842a7 ("common/dpaax: remove outdated caamflib code")
Cc: franck.lenormand@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/common/dpaax/caamflib/desc/pdcp.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
index f4379ede2c..c90eff26a8 100644
--- a/drivers/common/dpaax/caamflib/desc/pdcp.h
+++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
@@ -619,7 +619,7 @@ pdcp_insert_cplane_enc_only_op(struct program *p,
 	KEY(p, KEY1, cipherdata->key_enc_flags, cipherdata->key,
 	    cipherdata->keylen, INLINE_KEY(cipherdata));
 
-	if ((sn_size != PDCP_SN_SIZE_18 &&
+	if ((authdata && sn_size != PDCP_SN_SIZE_18 &&
 			!(rta_sec_era == RTA_SEC_ERA_8 &&
 				authdata->algtype == 0))
 			|| (rta_sec_era == RTA_SEC_ERA_10)) {
@@ -631,6 +631,7 @@ pdcp_insert_cplane_enc_only_op(struct program *p,
 				 (uint16_t)cipherdata->algtype << 8);
 		return 0;
 	}
+
 	/* Non-proto is supported only for 5bit cplane and 18bit uplane */
 	switch (sn_size) {
 	case PDCP_SN_SIZE_5:
@@ -2719,7 +2720,7 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
 		case PDCP_CIPHER_TYPE_AES:
 		case PDCP_CIPHER_TYPE_SNOW:
 		case PDCP_CIPHER_TYPE_NULL:
-			if (rta_sec_era == RTA_SEC_ERA_8 &&
+			if (rta_sec_era >= RTA_SEC_ERA_8 &&
 					authdata && authdata->algtype == 0){
 				err = pdcp_insert_uplane_with_int_op(p, swap,
 						cipherdata, authdata,
@@ -2729,6 +2730,17 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
 					return err;
 				break;
 			}
+			if (rta_sec_era >= RTA_SEC_ERA_8 &&
+					cipherdata->algtype == PDCP_CIPHER_TYPE_AES
+					&& !authdata
+					&& sn_size == PDCP_SN_SIZE_12) {
+				err = pdcp_insert_cplane_enc_only_op(p, swap, cipherdata,
+						authdata,
+						OP_TYPE_ENCAP_PROTOCOL, sn_size);
+				if (err)
+					return err;
+				break;
+			}
 
 			if (pdb_type != PDCP_PDB_TYPE_FULL_PDB) {
 				pr_err("PDB type must be FULL for PROTO desc\n");
-- 
2.25.1

