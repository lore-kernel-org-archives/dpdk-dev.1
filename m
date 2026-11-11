Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E256606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.a=rsa-sha256 header.s=selector2 header.b=jyL+coj3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF6DD410EA;
	Thu, 12 Nov 2026 09:07:39 +0100 (CET)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023072.outbound.protection.outlook.com [52.101.127.72])
 by mails.dpdk.org (Postfix) with ESMTPS id 04E9C402A2;
 Wed, 11 Nov 2026 04:59:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMX+d8xdAbQuIQKXZhRniEPMKlSFpLhEjqzZ6p9CBYX71VrPCadVDsd+Zxwqz80V1Pqy1J7NFN2B1ujLWl1JArxLxo4x7CvZwwp8TaXpgPbLcoz03xqPUVmhjPWr1R8vpxdyeUo8aATR4nvRWdq60zI/ACndEElcuKcxBJVsAI/V4p3+eCF2t0IN3aYdeKbrVNYURTBXdXzvJshl7WsBzo1/4+Y9sGg9FqJriIrz7uqFHQUUtTEBbCCmB5pXKyXLoHXY1kn8brg6X/xEXvs6hLsqrq4VMewVv4N4evfBrmNsCU2LmJzHK4Y9Qi5mp7jPH49W8Szbt8DBVtO/fG58Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVRctyAkfsid9Vep6RSS6gT36Dfugck1OZAxuodyL8U=;
 b=k2fYB0VfTuk2i7iG5Lw8JlK+ojhK5wV44KduGd7iz/Ry/uWHe5TjQeribRQRbgTgrHhU5caMGRspkBvC3LD/JZmECfLIVqmyp7CtGz3rg3fs2BmeDeNnjzpTJwOfMQngjiX18RKGV0XPHbofTb0YmCXP4MeypneH2iHw8x0d43h4uA3lQr6l75nL/ozbkuRfLaYr1ZgZ0hqbuPhm/EUKjQ9oeDX/ojoaYMYe2TV1qVU4AfKQzaWGur0SoLT0IjnbEWtG7McRgDv8KqyGF4DFn9jZVwgOPxHeVQBGyf8BlQKTnG4QlNycByUpIzzwn4ZBmqe3F8SCDq9HbSKztI4Uew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVRctyAkfsid9Vep6RSS6gT36Dfugck1OZAxuodyL8U=;
 b=jyL+coj3GuhQquvSQlPQ+FfkXETJ0oRbgCkkdkO01okgWtWcvIdoMftJPwzxTX1nmBJ9dbXL2AELnYokR3YSWoUDbRcQ3/uV92cELHfCjnReKPRmksywoCe0vu4fRve5SJ+ndx53QpgauzmmAvVlYCmV/Lu8bx+9OCpuj3m67pVekvVv9m3tOlRes3mDJaj2sVLpAQpj8D5VzEElrGan4+X2ZgEdosNZbHdLmwhX4W/6QAStczwaLt+Q3g7aQSqq5wsMF7QzxvF3Q1Nm0abuzZ80/u3sqQpeb48MMZ2UBhU+mITjsX4XEByfXJle3EE5Mlj3TcKFY7MhrtIS2O1I7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEZPR06MB6958.apcprd06.prod.outlook.com (2603:1096:101:1ef::9)
 by SEZPR06MB5224.apcprd06.prod.outlook.com (2603:1096:101:77::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:59:13 +0000
Received: from SEZPR06MB6958.apcprd06.prod.outlook.com
 ([fe80::4dc1:6d4c:47c8:4928]) by SEZPR06MB6958.apcprd06.prod.outlook.com
 ([fe80::4dc1:6d4c:47c8:4928%6]) with mapi id 15.21.0615.005; Wed, 11 Nov 2026
 03:59:13 +0000
From: Linda Wang <linda.wang@jaguarmicro.com>
To: dev@dpdk.org
Cc: orika@nvidia.com, aman.deep.singh@intel.com, stable@dpdk.org,
 Joey Xing <joey.xing@jaguarmicro.com>
Subject: [PATCH] app/testpmd: fix buffer overflow in sample action parsing
Date: Wed, 11 Nov 2026 11:58:29 +0800
Message-ID: <20261111035829.2204-1-linda.wang@jaguarmicro.com>
X-Mailer: git-send-email 2.55.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:990:74::23) To SEZPR06MB6958.apcprd06.prod.outlook.com
 (2603:1096:101:1ef::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6958:EE_|SEZPR06MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: fa95036a-06de-4e4e-06c5-08df3fa825cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|52116014|1800799024|366016|38350700014|261102123227099003|261021121427099003|5023799004|56012099006|261026121527099003|261009223027099003|55112099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 8YbUZAnZc0w/udw5orUGgAhMLPODtI1CUvOWDIkA/wNuyfpp40Ym8qNFzj5LqUK575TzW6UBTIVpkW1CTLGHWQqMg77ln799ylq+n9HkncOpAdznSniSAEWapu2Pu5Hmp0qPX596/tcf+YLkbyCzvQMSLery5bj+RyBkdf5NjeCYi4cd8x/3w1ALLmHQyTfyttsMoJfjSXCF3EBMs3vh8lLAQrYwJY0qAYsiA33g5zLWxejqMhiazfaU4FL5zzDXbhtLgNXo3Rnu9ISjJV4NuUCQzKwh9qj+911nDrTGRSuILJEKu9jCl8Qo6BoaG+rvdZLpi4OT9GbUaSUre/Xq2EKhcCKuPwv0m1KRuaZ8b/7C9U8hQmniFW7PLgvnG5xb0RQivK0Ipz+YLEwExNSA0nOGoHCO/KWM+L54EqpkaOCdNRnBJrHWXYy4faKI8ZbaRmqZO36ldYvmZcTXOtPQnjqadPPNHYBWEh2lvkqpTpDS9oOA+f8mPohOUaPTEwjCwIF/cVEVUK/Bjj/ETj36eSd9NnOyO1rG88Jfm5FhmfLWQcNM7dKZrzEx5/wBk1f0r71GKasSyLaUeAApKQsWA9iGMxmyHGfC5NpXlyZ630vlhmq7qMTwgsXCZcIhueSenB/AqraNfAIckvNWeZVue+wlDfLM5IwzQchvJroSiVvztik1ztJ/QV5jgJxWJ1GG8c/LTgbABGELKdm6ywZayI7iwb3m3He6zoumwQXnxd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB6958.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(52116014)(1800799024)(366016)(38350700014)(261102123227099003)(261021121427099003)(5023799004)(56012099006)(261026121527099003)(261009223027099003)(55112099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5idOxUmIX5YeXD8JM7iOuB4wfifi3m5/2DG9+4ekxf2sQd5gfIpnFVqYzFa8?=
 =?us-ascii?Q?FPgJU8RtZ9e6Ka/pEWllsmxK74oUq7kKXB/wYRjUDxu2av6B+hyACo85Mx0a?=
 =?us-ascii?Q?WbyL3xV1f4niLdHBaqCGYBC1Z30AGbd6pNq3HP24/x5YeueXo02SuAcsyKtW?=
 =?us-ascii?Q?Sd+wgpkXMjXw+rqibbknTaHwacUOyyPFCTQHWJblEfF5eqkC0Pz6B+x2LvYK?=
 =?us-ascii?Q?CRpGpayuth1pPpGfQxgwwuEoEWYwZVS0N9BdU33a/r1JJmVKELJxF5e3R8uv?=
 =?us-ascii?Q?Y2T3MUrFCJT4SjeA5R3Cy4mVfborDg7f05RjxDZrMch16GBPOZW5vGhYNYQH?=
 =?us-ascii?Q?E18NVAa2HEKYv8ShuSlOJGx8jSuFAIVRiRJge46xIJy5uphEJKQvZrk0eSVh?=
 =?us-ascii?Q?s9NmfvOaFbN8ipooMtaDJivz3NC+Qj9M/WwsZO7v36ndaLwwZqL8okyfJ4xP?=
 =?us-ascii?Q?xklXHEXuQMP9mZHpSfiM+vgIFR5rWNcesvddtGUVmXIrTxtpPP19dGIhjl16?=
 =?us-ascii?Q?5fiVvDBoHTgRahaYRdwMaKrtiztL/oZW498hyP3ef69VCWEaj9HdQkTtKZG/?=
 =?us-ascii?Q?2Qw2tPPbDStWKiRR6nFxroZLv8cUBWHDRlPu2fBu4TJMVFuza0sE1jG8juGX?=
 =?us-ascii?Q?XcBj/D+/zSQnFWDnStFuu7kyso/DH7GFgaDJJOCS3MCSDlGxAiWTwlWAInXs?=
 =?us-ascii?Q?e5aFwB2UK956VyVkvEyN+wdHzCRkhXIKE8btlEE7vlT/XVZyqizDZFelieHQ?=
 =?us-ascii?Q?ynxz8meuWY0uWT41Ezsmp74D4QSIHEi5n7+U22zsD+H6pbgZ/UmiqgQt7Fc2?=
 =?us-ascii?Q?4smWFRHyutzzuJ1Xk0+njeUQEkAlfa6H0kh+EXfLv1n4zTiS4LNOuFcIZA65?=
 =?us-ascii?Q?2t8vQtvgR7ywYp1n9zGYwJcDFX0bpYf9rYi+K3Z8vzZ/ozBlePA6A+6LE8fy?=
 =?us-ascii?Q?7fN9Ho+lm8GI3pTrV3pVlWeWy6elAGqWMvf5LCyErtwX5g1N1TErzuVMc98Y?=
 =?us-ascii?Q?N3JYhsE4c29glm3F8DlAqsGxrwg6e7msn23FiZgO1wmgW3gv/Ayj0YHMqnrp?=
 =?us-ascii?Q?8g4naMSqKUI59SRVi05KocKO4ivyy1h01af8OYeDqQZR5KuFmMvQ0Yux9e+B?=
 =?us-ascii?Q?qn/ZDuyvOHlaYL8Fwr1seKL5wOR62zs8DCrGA7I3VHLms+/stpsYeyHc8YMn?=
 =?us-ascii?Q?hBXsN0lrGIW2ejZgrC7HskRkWqPGHkCnCFCS7/Nccdvy73SPaZkXJD11Ia0/?=
 =?us-ascii?Q?7iO2ROf19P0zu5i4PAMyUqMmpc7eO8VP5lBoN3nfuhAUImliubeo4bXtg9QP?=
 =?us-ascii?Q?finyNkWyuPbOd0KGF4eh8fnhd13dXKDUHOWhCX9q2VvvjVAfd/Qoyl5GtCP0?=
 =?us-ascii?Q?DmUVZMzWvJ4/7qd2FS7q2rOs+DwVXDuIYcLDxQwv7401cfekgJv9433ba7Dy?=
 =?us-ascii?Q?WsgQaOZEx5YHgApZAD41kW4n8v6PqK2O38LzleSFoQ9HwM0ke7zCaSluBMxA?=
 =?us-ascii?Q?YT/hUhb5kbduVB/YSQSi1IMejmbFUuAOjUSbh6KddiRW0YhKfYEQJMfjpspu?=
 =?us-ascii?Q?VovLLC86/6NOQuhRyp6QL+PB2YHFqxxa7x690Si0xzq32Qun0zKLP6msP6o8?=
 =?us-ascii?Q?aO4/h74dOUmi0+geKezvLkt5AlqoZusyTlrNBO6/93qzqp0h9eR2nNxVb/Hc?=
 =?us-ascii?Q?o3zZW6Ddey2ZmPkVDqvLpATdqAHpP6/Rl+2wDjE5Yjw3nhVCxbnrIt2tMNqg?=
 =?us-ascii?Q?ZvC053kVKCmsy80NO7k8e1H8b476Mj4=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa95036a-06de-4e4e-06c5-08df3fa825cc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6958.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 03:59:13.3412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7lR5sx0g6TT1IpLY6U3QevWBKeC7Vrk8KnAhCIzyOHUGacc8Mi2G/a3nFE5+hRgtkm+ktWzJu7QI6VY/WNyffeagj/+nBRp3LZ6/4S9DXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5224
X-Mailman-Approved-At: Thu, 12 Nov 2026 09:07:37 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In cmd_set_raw_parsed_sample(), the action list parsed by
"set sample_actions" is copied into raw_sample_confs[idx].data, a fixed
array of ACTION_SAMPLE_ACTIONS_NUM entries, without checking how many
actions were parsed. Supplying more actions than the array can hold
overflows the array. Supplying exactly as many actions as the array can
hold fills it completely and leaves no room for the terminating END
action, so the action list is read out of bounds later on.

Reject the command when the number of actions reaches
ACTION_SAMPLE_ACTIONS_NUM, so the last array entry stays reserved for
the terminating END action.

Fixes: 135e7de93258 ("app/testpmd: add command for sample action")
Cc: stable@dpdk.org

Signed-off-by: Linda Wang <linda.wang@jaguarmicro.com>
Reviewed-by: Joey Xing <joey.xing@jaguarmicro.com>
---
 app/test-pmd/cmdline_flow.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 68560673b4..a2e6f1f59a 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -13967,6 +13967,11 @@ cmd_set_raw_parsed_sample(const struct buffer *in)
 		action = in->args.vc.actions + i;
 		if (action->type == RTE_FLOW_ACTION_TYPE_END)
 			break;
+		/* Reserve the last slot for the terminating END action. */
+		if (i >= ACTION_SAMPLE_ACTIONS_NUM - 1) {
+			fprintf(stderr, "Error - too many sample actions\n");
+			return;
+		}
 		switch (action->type) {
 		case RTE_FLOW_ACTION_TYPE_MARK:
 			size = sizeof(struct rte_flow_action_mark);
-- 
2.55.0.windows.1

