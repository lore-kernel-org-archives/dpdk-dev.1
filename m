Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D337C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B050E40678;
	Wed,  5 Feb 2025 11:46:35 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 8B55B40270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:23 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2113.outbound.protection.outlook.com [104.47.11.113]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYZrjkAvD9KozomHSZLSdPxwszRorx79ijHoHqJRdVtzR+9ar/6aQfBKFvYsdGpG1g3fqTyRfen1wWRvp5oqp4QnWkaTcKSn/lHAyRGoZ9na9mhDLI3nWEHdTLRZFtnOCTXEbPducU6NyOPBPTWQHUabRgxedlvKgf3m1NOOdi1nGaIZP92H9uRo22zM0QlbjvCOeL/x5cZqu7WX6sXuLXf8yMJoh9TGJhAGurmWMuKtBT9fx1C3JYZuvpxv8+yq1hMYUay1tS7bPBUujQXKS0w5O/fMJm2aF6U0LuuYXt5Hz4rb+iwkxzo/R6g7nWJ0P1RcljwZkTbCbx0L5xa4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkYt3GIIkEXCmLtECNsUXyQGDE6dqTjPV4R3oRmJiyo=;
 b=apwt5R81Id0OfIy6DJUtRFIh80+9K8DZtCPbs8GccehcDfLkoZV/HRPDKyOQ0L+qoRtMLjnUec5zcPAkK+XXQ2btB1jSh8PYY2NwPvl5fy+9HQniQD0xgcIozzq3QBvGxK+dqKE6bqDGictz0X9gX4r2qsfnNI/xrZMmlNlanEw0m/HywzQFW0K2wxdQW/ufDGfAYosHpHTSBc43aaR2F9LDe2yYl8NO9btTHlm1Q78s7jdKtmJurp7ADZ6aw9ws4tCcHn5bmDuHShgWnINE5d+X4NKFjD9+DtzbnU9iK4AvvuWs6PQifQHGwNewXJRsbkM0om3OMrSSmj7w3Ia8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkYt3GIIkEXCmLtECNsUXyQGDE6dqTjPV4R3oRmJiyo=;
 b=Pu2dhpF8o6ceF+/CGc5Ssr8ofC0WK1vb8zimyGnA0xIOJ+4OTLxQOnDKkD2Am0zUhZsyobbJx+lfx2y5Xn9zxggPOW4LEPkJcoweGm6WfN0Eyi4j9iJfzjLiopAWFfvHb2Mn/PKMAAlBK3Wg6szRvX4IRWyim1UnTk8JXgH7I6U=
Received: from CWLP265CA0356.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::32)
 by AS8P190MB1255.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 10:46:21 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::f) by CWLP265CA0356.outlook.office365.com
 (2603:10a6:401:5a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 10:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:20
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 27/34] net/ntnic: rework age event generation
Date: Wed,  5 Feb 2025 11:45:36 +0100
Message-ID: <20250205104548.1533554-28-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|AS8P190MB1255:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0339979-3709-4626-b14c-08dd45d253e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JNLtDjX4Lx7HpwkBD6F9nOzH8CIdc/pGcWiJvu4mOhKJFwSzE3TY8lh7ufa3?=
 =?us-ascii?Q?FpPB1sVzJ9AlPOF8tTbQ6W6edKuTBQAOc6Dcakf6TIGmEmYxkg3+Wp4Bn458?=
 =?us-ascii?Q?ha/XX0chFsSSOw+pJVZ/vQCgjooBcVKWqH/Trb7lo5Cgh6kTAwcfnYBxphs4?=
 =?us-ascii?Q?1UElKKGikDgVrKtwB0xusE622Dd3MM1E8/kLBy8rqeiCoH3xm1FXIAdGSqt9?=
 =?us-ascii?Q?gKskv8YCbtl4hAVdnMkTkPLsSin9Gl2yv+6rjBTmZZSf82NJrVQOOPFdiMQc?=
 =?us-ascii?Q?saYXnZ2DMxSVRplxPAPFK1mHXqp58eBWOfxuSXHD+/co+tJgz2hIOvg6pky5?=
 =?us-ascii?Q?9oqydAvtlAoULv7TOBKoGpdMTtPUCTBWtTJueJdDjCBQCbURdnpf38mDTUng?=
 =?us-ascii?Q?fnpysbTDhoOHlWDJiFTplCwN9nf0ja+EYCwg+cIWxrZMYti8IFeV66vZihuG?=
 =?us-ascii?Q?kTqh9yatet3wlxdWCg82DmhxgHHyOlXIIE3KJjZ1nSMA5Qocu9j3uwwnoiFY?=
 =?us-ascii?Q?jRweZdIZpNsnx2fqjb7aCZlYcMIiBz2HIg4W0ETx0oetc7c27sDJfhiKUjXH?=
 =?us-ascii?Q?nvSmwNQZvxayvkzBIJ1lbJ3oZNpFWulDtV+SdkqrhokSGcEYpqP56pZPSEwS?=
 =?us-ascii?Q?/rZK5ScsRkjjPRB5WCpv50XO7vgwQwMOwAbDEgtpvJxyGr8O/CfeNbFFkkKw?=
 =?us-ascii?Q?9jqZxINBPRGL+3CB1YRbKhDCmyAEIH6CtrAHwLOhbfCuoHJ8CEg75Boqbxmz?=
 =?us-ascii?Q?KzQSaegC1a1cW0LY7h6GbARKo5OW6d3X1ywK63WeZrrzT4K8ccVjKZdqcExY?=
 =?us-ascii?Q?p3RpTwb+bYSkA47E3xtbSM6AaxsW9KBmdyiJ3nTyLQ4wHl0KdxvZSpT2l6gc?=
 =?us-ascii?Q?g1P+LbvPpHWXflm1eo6qa4WoB8EFWoUX1ncxbTeaHPKnBRhQO+EaBBFtOzSA?=
 =?us-ascii?Q?vfps+71LYMSFTSmId1kNAPwRBV/lAAAJyXimznGUKpUVrImFU/kAxc/Z2PbN?=
 =?us-ascii?Q?6qSrbDuNczXCgmwGCNA/MPUVyhdh+T0TIYro5Y1VIiCaARWSWYE2U6Vtki17?=
 =?us-ascii?Q?gqm925WBG4YJ58fhxuY1HUbXcdaUz2fv0roQFBhVxaT1KLDu54BJ+6zSSllm?=
 =?us-ascii?Q?6RdBpvEqYMyQeEj8FawMuYUWypODokwqo8Q/j/2phNU02I8Y8QRzgGXVI/Jq?=
 =?us-ascii?Q?tEaZMTJ2O3nOqm3MsSc66PmNdIiZg2jshTUs57enDYQaAYL207q9cirlGDY7?=
 =?us-ascii?Q?G/sG03tuBO8bUdVWnOUV7rJMoKYSqHWOH91RQGroI0jdxbmrfaGyBFLBuFSi?=
 =?us-ascii?Q?8y8xH9VuzSk/Ix/NDjvlTMyCpPsogDXKsYcxJUdIzheYh9dI9Lg/Qed1Ny3C?=
 =?us-ascii?Q?bEy/AoI8FxA8NcWIR4uvdV/LsHxNiJdYu5221jABZ8XunOV1PXLUdegsLbt4?=
 =?us-ascii?Q?JFaQ1MzmGO2atuLPJ5K4LqlnuZWPesN5HwK2Q0XMTjWEjRVAUSDRew=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bcU18nU2rQHjoybNwTNALuBk4XMYS47m0ZP5Ufylu/tOJ4m6VLNNIriCbpL0GUzidgz4rF6rbSrqgXZdJZeJjOmKLGJE+SpSzaQdRI5Vkk+e0Ret/GaO/+OupaUihF1D1C7bqwtg9BBYB+TcdotuN8mpCSKcJDloy+hAAvMVQGRmoASaBIsT6hmk4AkRnfhIn/YUSMuIQtdaAfbGQxzxsipjErO3zq8kNXzcLrxemKghYsiYQY6WxMVPults2Z6IwONs+V2fFa/hA4+KAfJ5QP5RE94TaXkNFyM/7Ysd7D1zJgv8BYOktTbVuT042WXKBGGfmva2GA/SE0eQuP+lq9+bsgGwI5Z1ZiDP/V7j9RN1hKImvuQVAI4w6lWn9OACWlGxYhC41LGGXDCgJnlpDE5uvYMARGv9rCYZLHs905sMbqe7H31z2adV1ckLFETEsHgzcWzjMlOY9MzXfV7XekG2zrM03aL+EqUGZqJnsrh43mYKThO7ONolNQU9LqJxHdHonYhs1jlPKMhN1OgOs8nw5HnT/JNtBWMgleMYAvf+FIciZqaRmWJ3+gkM97CV728PBGQPs2GLm9mQ201/AQn9QcNfGEPCl+MAlBsUET+IblmfNm+WdsDHhhjRNDtvKzw39kgO2UjsIjwmbZlsLA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:20.8082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0339979-3709-4626-b14c-08dd45d253e5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1255
X-BESS-ID: 1738752382-311016-9613-523-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.11.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGFhZAVgZQ0MA0MS3VJMUs2c
 TU0sjIwCQ5NdXQ2NQkzdQgydDcPNlcqTYWABylOldBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan14-207.eu-central-1a.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add age event generating only for physical ports.

Fixes: 4033e0539435 ("net/ntnic: add flow meter")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index e5abd372bc..e911860c38 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -479,13 +479,16 @@ static void flm_mtr_read_inf_records(struct flow_eth_dev *dev, uint32_t *data, u
 				struct flow_handle *fh = (struct flow_handle *)flm_h.p;
 				struct flm_age_event_s age_event;
 				uint8_t port;
+				bool is_remote;
 
 				age_event.context = fh->context;
 
-				is_remote_caller(caller_id, &port);
+				is_remote = is_remote_caller(caller_id, &port);
 
 				flm_age_queue_put(caller_id, &age_event);
-				flm_age_event_set(port);
+				/* age events are supported only for physical ports */
+				if (!is_remote)
+					flm_age_event_set(port);
 			}
 			break;
 
-- 
2.45.0

