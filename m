Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3BCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAA3140E44;
	Wed, 24 Sep 2025 16:42:40 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 250C540DD3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:22 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021109.outbound.protection.outlook.com [52.101.70.109])
 by mx-outbound13-221.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmrrVWrjXFLm8coBTHsIyBTm0lGut2BQQmpJl/hcngopR3ZYxEwXuxTYSbuT20LqaHoa1qJ90jdlmnV2aR5mINqsR/jJSXzRsuPbrfMKpnXz4xs85kl1cWgOJTkN3McFLDFTaytuEhlnjT97ng2p8L+BcFzDtbKMS4NJIS3wSRQetuP2HWD0ICu2aRcbVVxFbYUVobCntq4S97oMmcAmgYK5zEihoqEsF8TqlfXteMYwlNVLaqPVM6tHkdKgsUJC+jABnH5qNC88dmE1vO79YB/7WoWGxys/6INy55ocpep744xzqtnI7lqSZ3COaiHI9DPD+b0lbeYCRfop+F2R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEeo1+Y3gTDiU7p7qosYgVJ96utSoAHRuueLVqeMh3Y=;
 b=MuxlpKf43QaH6CUeNZV3LyA5V+xBuY9WUpRc+jlY+9CfWS1enevHmxgXs4MGk3XoIH5w1ErA+p+rrwxdnAauBAmbYaJaFpXT5DWFDm5hVhyDyFZvIKST2SPR7Lm717p24elKbGnUveUiVVRmNVRqKSAD6prBN9Ye5PI0D9ZmjsCLYlE1zjRwmIE18ElVTqM3eTucCxCfVQvGHp2Z3rjZm6WyxTp5G5Wf3PvMxz0MCUJGIUxzWFjI/uj2DNhLit3+EtXd/WFS3dJiuMRehKxDYz/WxR3Tr/J25zN7rxLNAwXQFJNPhvjClmTfEMyp7edDTOAEmS9RQarxQ1ED1CV7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEeo1+Y3gTDiU7p7qosYgVJ96utSoAHRuueLVqeMh3Y=;
 b=ZTaPrphVorzN4NgOspsyDWoOWtzb1/9WGmKq8D16PZ53N7/c76Db7tVq9BiNFa7yEcgyG2Gqn59cybUrVBnPEnHnVUyjBzHPeSn1KdN2sKVqF2eFAqKvt6l5jMfeqZNXay/k0Y42A49vj7VPenAtb3mgnj6ZCNUWDTzuHjCk8VY=
Received: from CWLP123CA0229.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::16)
 by DBAP190MB0871.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:42:18 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::bf) by CWLP123CA0229.outlook.office365.com
 (2603:10a6:400:19f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:18
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 23/24] net/ntnic: rename nim agx setup function
Date: Wed, 24 Sep 2025 16:41:46 +0200
Message-ID: <20250924144152.53203-24-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DBAP190MB0871:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a984fca3-0e9f-49e6-309b-08ddfb788ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KH6Dsm+7RkL8ghrrkVbB0eg5U1GnxCpnLAEg/66iZ9RrGi5HMPwhW2DK5zBP?=
 =?us-ascii?Q?9GqKc9pM4QzVJbBza7Qyqzv+6+5OpMeYLjWUvHV22rfylApg8qwdWRW4ySV8?=
 =?us-ascii?Q?89TbLq/pntjG2dej1LZG/m9m2jZOGqSKupu8Sp+kPfboQVgJStYAUSL4pgTk?=
 =?us-ascii?Q?YJ9QlaMZVLkg0A7trNBKYovHC0rcg4vVfxBjpawfJonCpD8rat+1t81KUl+3?=
 =?us-ascii?Q?L14/6K21o7tSqJZEeNExtVbyVfegYWtateWDLLN4oGmQC/PG9CDr5EmnRFR1?=
 =?us-ascii?Q?qTptQoXYvxbJNJdJ91CIEFB5KnBeo+5bJhQhqG7KKaCBgMGXiaR6+ooNDTEt?=
 =?us-ascii?Q?Uw1WLaO7m0fphmJhEcv7L8k8SGxwhD95Ul1x9huhjm+53qFWNmU4mzyvGeOE?=
 =?us-ascii?Q?4JPEqRRsMbiaGuNzMa1E0qYw1G2LdpxJf51cb3nb+R1WsmDMszROphJa4Tch?=
 =?us-ascii?Q?3+aOg3AQIaMVOevnYqE64A5ENbUYscaIyb3OmsFZvI13SuJmiBRFfoWK1llO?=
 =?us-ascii?Q?pxYfy68V9Go8vCHhFC638ace8X+dURZDA6dSB1kyDkerJsPgDRg9Op52OJxz?=
 =?us-ascii?Q?ZiMmlmDYiz+2ipTMzKtoKfX/UKvF2IAQp81Zcg5PCVntJ6bgF+Kdg87rPVAw?=
 =?us-ascii?Q?DRBWVyXwH00YKGtM6Eq+ev9uueMoOjHACN4rzUdHvgKb/VF9vXSJkFUeyn6w?=
 =?us-ascii?Q?Is0W6HhrlJj85Hxo78uziFS7wLdZwfDBbeolfvEqeidNmDuOWmp+lUzVXsTy?=
 =?us-ascii?Q?8Zhm6JwrSNo/3vGRl4L0AbDVDToRUOUQfVW4pIeC2ChlbEZ7Y9RQArT/m7+Z?=
 =?us-ascii?Q?KSbkGyZV5ZNL6egnSq5CICMg9VC42YZHSrp4U7PB0qa1Svw4rdWAj/YgWOzW?=
 =?us-ascii?Q?jhDQWk1KCNY34pOF2T3xTmtADPqSq3L+qocPjTUQDxyutaoC9/djPQSCv0/c?=
 =?us-ascii?Q?rp1qorQFyrIRMJYDLTk2AFlSQR8VHSCEETcYXxwXSwtZvFuWsc73Z16SxLm0?=
 =?us-ascii?Q?QBOtG0/Px45l4V2z5ViXRnzA5MT7dqCDL/CVMkup9qxmAmdwb1yAALw6lyLL?=
 =?us-ascii?Q?8apsIgg6Li0oZXMhGlSm53Q1R9zqU2tF6X+FkVg3Pww2TqaTShyeo6uiLDcU?=
 =?us-ascii?Q?OYG7VEk42ed/AAZYXLcsA5+z3nq7iLKi10DO1A2cFtL/GWyboF5/wuG3Tv8Y?=
 =?us-ascii?Q?HDef8cYVoY7zdPSEy3gMDi7X71B8RcnA2kMjqm232AOKGtmhTkruHhjqsjPX?=
 =?us-ascii?Q?gtHh0QdG1uDnT5FuPU7l9Oguq2O+YR93oymBC4WU5zKmK3QKNHOEd4vNmj5g?=
 =?us-ascii?Q?iKOTOt7EetSqD00eO/ZlkWa7TKBsIpoblI1iJclF5s+Zq2YdKdsPiyI8bHh+?=
 =?us-ascii?Q?8sSpnwvaPfjdYbvuYcoIJVeAn6SgcTxQrD6x3sg1GPfBs8T3pbhNe0gPFPXd?=
 =?us-ascii?Q?XpkoXyKBpI0UP5Fsg0m20vL/o73POBs4gFKjzTkQ1SCBHwXqiXy9dBJdf7gl?=
 =?us-ascii?Q?SPC+z30/dvkcYXpacJWtgqgu8MZSwsyOkrDJ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bmokI+y1XFXIMExOB/O7s7WUF7wURmM02jDwFTTEFB6CCHXK0XMqV1W5ChjqJfi3uASnaMxeJjRt5y4jklPrdnTaAlSVp0qaA+dpF24Xksb+WKqW3EIXeKLw8j+DzBc9BNWfJdQJHAi8E0Zx4j1F0VWmUhyzAxHOuVYi+mD7K1tSLlH0A96bSSzw5QFE2fQEAl1Ge/Xx31Wi8ptz9OJz6/ignRHeu8jgRRp8ypI4kXgwdbjQZWvz29Bp9Kr00EyKQYvQtAL7vQS8nVuANduYUoei4RSOS9oAUa5BD/cNGUNPKj0EOBG7h+GSSbQzvog92zyM4oS+EnaXCo0hADAHHJcXnVdk/JcRERVizq8jWgJFgMxbbzqUIyFBf4fqebBEAF8WLM+yLSD3V6Oou+42hmXVXxuBcyL0QOXT3A9zG5irmjf3RqCKS6Vv38SoA5j9aw78ZJjFvkX5aZ+KBtu/At9/we2HuAVgUZ8SKitn4XmDDiOdegqRpUmQ9mtyhZwExfYROvNfW1m25MafO1UfsmwN4KnDZT9v0XynGgGYZCn5Rzee4yHSzTDR3ObjufHpkNBjAX40nctV2YM1g5njt82zUj6xd1Lqzu5Z8GYpS9UhBGwKt3yzCBJRRNvCS5pEilhM2mS+r/+pFlksNRZRJw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:18.5713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a984fca3-0e9f-49e6-309b-08ddfb788ffb
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0871
X-BESS-ID: 1758724941-303549-7635-8096-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYmZuZAVgZQMCk5ySzR0tjc0D
 DFMNEyNTUtOdHM0NA4NTEx1cjIzMxUqTYWAIFDFUZBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan18-36.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_RULE_7582B
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

Add prefix nthw_ to nim_agx_setup to follow naming convention.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c | 2 +-
 drivers/net/ntnic/nim/i2c_nim.c                                 | 2 +-
 drivers/net/ntnic/nim/i2c_nim.h                                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 36ecf0d0ec..8bd6584b1d 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -991,7 +991,7 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 		for (i = 0; i < nb_ports; i++) {
 			/* 2 + adapter port number */
 			const uint8_t instance = (uint8_t)(2U + i);
-			nim_agx_setup(&nim_ctx[i], p_nthw_agx->p_io_nim, p_nthw_agx->p_i2cm,
+			nthw_nim_agx_setup(&nim_ctx[i], p_nthw_agx->p_io_nim, p_nthw_agx->p_i2cm,
 				p_nthw_agx->p_pca9849);
 			nim_ctx[i].hwagx.mux_channel = i;
 			nim_ctx[i].instance = instance;	/* not used */
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index a394b4c5d4..9393467904 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -881,7 +881,7 @@ bool nthw_qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool hos
 	return true;
 }
 
-void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
+void nthw_nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
 	nthw_pca9849_t *p_ca9849)
 {
 	ctx->hwagx.p_nt_i2cm = p_nt_i2cm;
diff --git a/drivers/net/ntnic/nim/i2c_nim.h b/drivers/net/ntnic/nim/i2c_nim.h
index 61dfedaa4f..2fdfd37a03 100644
--- a/drivers/net/ntnic/nim/i2c_nim.h
+++ b/drivers/net/ntnic/nim/i2c_nim.h
@@ -36,7 +36,7 @@ int nthw_construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra);
 void nthw_qsfp28_set_high_power(nim_i2c_ctx_p ctx);
 bool nthw_qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool host_side_fec);
 
-void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
+void nthw_nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
 	nthw_pca9849_t *p_ca9849);
 
 #endif	/* I2C_NIM_H_ */
-- 
2.45.0

