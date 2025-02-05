Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBECFC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A4C540648;
	Wed,  5 Feb 2025 11:46:07 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 09A87402EE
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:04 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBk3XHZYPx87PIx2iZv/1wM4s4OHZXGjeSSt+fpmYC3ThVzuecQmuGx3VynyjDl6ZWYkPGWT2bPodHfoRzoIhMrB2uF54cT+rZel1G4Fg6ZaaTagAJBc+bQ+P6kp26bdIphyYMMOV4dI+jgLa9NbuN18rQ0P5WE1mCbGVMhlqz9VHDOgu+MSGfY8JqnyX12J5DXLkqBdrFxkzG+XYNwPpDsFc1qJqAF+GBjCL3BeNy8XB6LQCfDroz8aOIj4bwNalJPaCcNuKUvAcie2V5bQSZoPikLt++j8J5nPkxY/w+ZU8y/menSZPOfng6F5RAjgGLGqmRgPggdpCETD+UHCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlHhZZ9a2kkHpFMqW04E5US1XIu9MeYVaZ/Yzaq1AAQ=;
 b=iR67VSI9UVFBCbhGVETflJBu6NEmJaVLIylx0+tIJa4ZpOjtzwj+hu7xtRGhZVRk0UDhG+pPt3mqcR6089/zHsj5Ip+2NjfW8M2HSgeRixMs9F7UNv1Mvf2EIePJaWgByoMn5/8hIWLqjK0gzayJZ5BYn7iVsaLad4XobSvSZzRbGnmCOsxowcSrW7cfCFqbrleuq3KACYPFNxNURTWTdH7J0VSeBtyGEsOF5V6Qi6u8ihmwS5wrBDz9qVKxNR1bDtN37U125IHswQGd17/74uM6R/HdqkbS5kZ0/08KK4yBS3eVXb6ZgRi5A1mvlm4EdF46s5F7ENi8tSBPkn4PZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlHhZZ9a2kkHpFMqW04E5US1XIu9MeYVaZ/Yzaq1AAQ=;
 b=DrDEIwV1YU9mh5V4BXdcNvY/Qb/FemXPCGuwPHChdWt90TrURzjdHCdvZfv758UnPPNsvYsb0QZH35+wBkIXU2xgT1G1u/7afHbW3I8FaGT0mcRsaXxvPZ22pAFfKKgz90sooPHP/kzE5RRZBpP/rmx0u+PKMvTon05x2YMc2tg=
Received: from CWLP265CA0342.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::18)
 by DU0P190MB1780.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:348::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 10:46:01 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::1) by CWLP265CA0342.outlook.office365.com
 (2603:10a6:401:5a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 10:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:00
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 05/34] net/ntnic: fix realloc memory leak
Date: Wed,  5 Feb 2025 11:45:14 +0100
Message-ID: <20250205104548.1533554-6-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DU0P190MB1780:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29ca1c55-61f5-4211-2aca-08dd45d247f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KUBhOkG2JNLzlr6PCwYEnF9XEcNrEQmNma6kaYlxKUlcl1rIpRafNycigO08?=
 =?us-ascii?Q?CAESiGb9XV9z1EuIddcMDQDqJUAIz/kEQd++sDWUA1Nq9HDoZGn4LwShJaO0?=
 =?us-ascii?Q?etadwi6RNuWXP/NfCafFdipxZ1J4Y/JkZwM1mdZYcZCXpcGOfOM7qDLVKghf?=
 =?us-ascii?Q?UwaLzqSoInh1ZQLBDGs7srEc+cFeuA9aYh/Qgm/+5/oxdJx77eTA4ZRGXhcK?=
 =?us-ascii?Q?1G3c/SFNyZ6XbMONFIUg5/pKJtP2TjxdlWBrCFJfDxz2M44dYKOU6T3bdoro?=
 =?us-ascii?Q?hrlJsrev97pytvj15UJMI8GQBMhriHtkc4FLprinjRdwFa/hzesLesVQA7Nk?=
 =?us-ascii?Q?Y19j/qm09+wq48Kan1R+QLX6I2CDT32lRhiZsVdVv0Zsn+c/Fwq4HyJmGoLa?=
 =?us-ascii?Q?ZxyUlElKQHX+8VPJWiEcF/kHmo9rcnpFuQGt3CwdVCuivWOIHjlXYl51A4iA?=
 =?us-ascii?Q?clmRYrWOLkXmFT4QRMVonyW5T5eYS4h/Zd4hZ95D0F0k+Nzryhl04bzxGlwl?=
 =?us-ascii?Q?W0Dmr7A57veTBJ1HesjPK+Dw58Mvb+S3TbAM4qFo57Wz1n8C4LQWV6TaZTzR?=
 =?us-ascii?Q?HvyCD2hjRQnL1wEZsEfnFQjx1XcxyLRoP9ulMvC/OCLf2FB/Af+VgXNVMZI3?=
 =?us-ascii?Q?SsSgNGz6XnHbvfn/3u6Ohp7aD9YgqMPzQtI9e1vBi7FAh5G6t5LdFjXzL9fq?=
 =?us-ascii?Q?YMtwdgsJtEk+gCkA6f2X5gxdfL9mGO4JonqupsPGhmGNK7oeX9CCmG8ecjty?=
 =?us-ascii?Q?Fs+vcO3UzgBmALOoFBq7fMCp1ZICMfazIovjnwo02KiXJv9itowfNdFLE0CK?=
 =?us-ascii?Q?vCuT+2YP3CMuW+1YWLDv6ATchE/GrTQ3qlNExWUsz9PGw5wHNtfbIMPlwihm?=
 =?us-ascii?Q?MCeD2yaCM0hGou7XFB11p8pCdekf76C4gM//H5Lp7dYwLpUuZS190LKtTKDN?=
 =?us-ascii?Q?+qklyNp02bi8zNpAq2lKuQxg8dDAbkmDH+NMeTvOLYrkHXgdA2McUg4ob2QJ?=
 =?us-ascii?Q?jhrqbQmTIW7t64y22e76h452YrC4u51Oc1iU8zbDK/CzCWU0Qe6zVBryG4sJ?=
 =?us-ascii?Q?St70DZvshTue1FhcQeoRsD01WdXGK0KwY4WroShqO/R/ldL549Ow+vcbPM1N?=
 =?us-ascii?Q?pBYn/LkVfgWewbXXwiWylhKF3Xlt6oCf5agbXC+mpAWoaUUVsGQ4U8T/1Ywn?=
 =?us-ascii?Q?JRpHkS2o6k4EQSC24rmZgtRw6LQchezo0ivbG+If2HVxUS+nu/x+ui5qcxE1?=
 =?us-ascii?Q?Fw4JaPqwfYoha68RNzqsUxuO7Wi4VA2M15LFgbIHx7I02r7TW8AVwrvW23jW?=
 =?us-ascii?Q?aMF1qtzh3KDGcZ3vGpfoXxCfoVLFvyuAbVRuf96e/G1NavtH15m2sB+vobrH?=
 =?us-ascii?Q?CFovEqFr7fonXlRD69UdXIt08PhB021pX9lCh44T+AfV1vV5tvQ0Qhn4/8L9?=
 =?us-ascii?Q?F/AUdthSs6i19o2qB+BUDwSsmK4pK8eSpLEWtazYNjk7t1PnuW61jXjLXMKB?=
 =?us-ascii?Q?iUeIbAe5Ir0wW/w=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gMzUA5BrItBgE+OINBczsJ6dazeVO3e9Do0XciOCRrW/rwKe39qsBX51W/yJbtqmpD9jePDE3qXpbBj3TIBH1X+ALikIoMRCFIadgWeWrfz7HUreuMByZs8b/9awb0UslGeEwsJ+JopcTl60qJ/npwAhhHV0vuI5HhmVtB3Xj9SUAphB93+B+Y+jHBFVDc2BtXAwvnokVm4pMemHJnoSSykLhkR5lPbQbkTI77f9Or1QHMbvqY5cSHbqAKs1OKinlI7JDCzbLzixGsB95li/BCEK3DcmSaYupGehc2a+aD2zaSLEi4IyTgTvVTNmWFiz4tUR7CB5dzL7oMWJ01m4rlvvgO4J92vrI6jjpHQ8++B5vKsg8mpzd8KdQPz7Xw9pn3fvNcEUJECiytql2xw4NcH48+AU4MXxXZ09fT57iJVXBNEOT2RMtsYWB1CUM5LQ4ZXADUY7vNd61ih+XEgr6JhQJjjolymOlVHwI8PlPK1IYvqNHZgK56k/JMDiwYjJ8dik7b1/EPCfEQmoWRgUc67TPW7dbD499InKbNbrmKbbVjYz4jjBFlu0w0w86ZBkYwSLlr6fXWXEsCUjenInQXwdqZBHnOycyYr9F7khzEAJvs+A5gKjiUdQGtvTFVJhGbzSpCgj9RP2PbAXr1PDRQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:00.7770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ca1c55-61f5-4211-2aca-08dd45d247f5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1780
X-BESS-ID: 1738752363-302364-7584-639-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamppZAVgZQMCXF1NLE3CDZLM
 08JTnNKM0syTLVxCjRJNko0SA50dxCqTYWAI+ihkxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan17-75.eu-central-1b.ess.aws.cudaops.com]
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

Issue was fixed with verification in case of the
successful memory re-allocation.

Coverity issue: 448959
Fixes: 4033e0539435 ("net/ntnic: add flow meter")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../profile_inline/flow_api_profile_inline.c      | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index ff8eb502f4..1c7d5cac3e 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -5523,11 +5523,16 @@ int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 		struct flm_flow_mtr_handle_s *mtr_handle = dev->ndev->flm_mtr_handle;
 
 		if (mtr_handle->port_stats[caller_id]->shared == 1) {
-			res = realloc(mtr_handle->port_stats[caller_id]->stats,
-					port_attr->nb_meters) == NULL
-				? -1
-				: 0;
-			mtr_handle->port_stats[caller_id]->size = port_attr->nb_meters;
+			struct flm_mtr_stat_s *temp_stats =
+				realloc(mtr_handle->port_stats[caller_id]->stats,
+					port_attr->nb_meters);
+			if (temp_stats == NULL) {
+				res = -1;
+			} else {
+				res = 0;
+				mtr_handle->port_stats[caller_id]->stats = temp_stats;
+				mtr_handle->port_stats[caller_id]->size = port_attr->nb_meters;
+			}
 
 		} else {
 			mtr_handle->port_stats[caller_id] =
-- 
2.45.0

