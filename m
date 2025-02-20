Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8755C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1862C40E40;
	Thu, 20 Feb 2025 23:04:56 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 7732A40E1D
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:40 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 mx-outbound8-89.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahT4y6l7DBuPgpGCy+jQPUAxteVFPTXBD1vh6YRBbMcrXylZQLlNiFYNpKaAmI0YbCZWDnvNN6ivXuZPH/BQyvtEth+GVMGno6rAi616j1QZhJy5OkQHysp6Y/i9u4UBUb/6WerVT+nbnbMiQi9r0w9rVCVlY0eaGeNFWMVEc/dY1I2+BRYFmym48E/qEaYDFNZDaZWiM5KX5IIvlZJg5Dx1Whn1TurSrCFe+qIhdiBovs6Of0z/E2gtn1O1PrifKIxIGr4GGMud1dvkEENq1PBWPNpCTObQZVPeggIYiRqfLfskl2d7Q0XGrPB77FyrioUXWFAGBvY2ii6TCgxxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFsLgiyKSDOd1sEpOrAmZ7n1tI3o4d5FNjTZ6SXuKg=;
 b=EfR31maGEKoUwEIMASjveuTxNM6Edf1STNC+GOB6T0zsT6OaKXuuqVh8yfvjXGan583SrUyr2UcgDM5h7Hrfn+oKDulMgUjSdYM7XoDf//NCerdFnEulSwkVqEsS2lU3wtkca346IBvkQ+hogSwuqZCyR24Cy2epMJmk17FOFg6fa2AGkNI3b4Jf30NxexklGLZ9QhxCT5kJRF6ejCGK7ONDh4JujPIn/DuxSB+vALm3DpxOfhPOCWGGYJ4bna0qxseX4ZeAsZWpB6M1u5z4WJJCX8OK8SqR/nDX1Bdp4p5njFnGV6OPYKlopS1PD9Sy8uiG7BMBr7wr83xL4hU8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFsLgiyKSDOd1sEpOrAmZ7n1tI3o4d5FNjTZ6SXuKg=;
 b=DMqWTMXZXKYRGBdQ6H6d8++lTn7r5sTTsK27gS02J1fj8Y3GCuMrV/h428I9Gh/Miz+oviTO00JsmvQ5Mi/QC4AKs0tuG77hA43yR1h6YD68Sg1sRM2o+5NDJVkAAKGMYkLF4XbjOpzPzpmj83LQTmdgC29tz8eOKSN7ErgW8R4=
Received: from CWLP265CA0493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::20)
 by PAWP190MB2189.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:468::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 22:04:38 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::6d) by CWLP265CA0493.outlook.office365.com
 (2603:10a6:400:18b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:37 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 32/32] net/ntnic: revert untrusted loop bound
Date: Thu, 20 Feb 2025 23:03:56 +0100
Message-ID: <20250220220406.3925597-33-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PAWP190MB2189:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 48b0bed8-3f02-4440-420c-08dd51fa9169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/5bwNL20DYP/M0LnxBSu3O8l204A9BmUHFXrM64QMEBuqOlmjWRy5qvXGvsA?=
 =?us-ascii?Q?ceufoMN/Z1ng6fYuaDvov5RUoQicJ3dWaxPvKIxUe1XZJT9cPrmqXb90NSyA?=
 =?us-ascii?Q?rJru4KEYPk7d9HbTispQS1UPlrXIYZwQuvfotL6srQ8kdG/OtCQ8aL/ioIky?=
 =?us-ascii?Q?kl9iWbP4pVqA7LRSkNTnuXQcPWmrMuAvX37Ur5kgk6ceQC1okrvbcPsGqB+C?=
 =?us-ascii?Q?xlcPYuPJD/VMdzvvd7JpBl2wmRhnFPKrnwjvoFmyCXOSlF9FDGJmH8WZK+8Q?=
 =?us-ascii?Q?O1oVSwGrZF1lN3hPTX3Rbf1QJL+caLOoUZQ11teQ2aM847213vxc8I2p2Mza?=
 =?us-ascii?Q?CAbYXOSYaIoT1vuJm+K8TAE+B51ZTEw3NKs4epCEJUbrsrAteQU7OJGCYgIU?=
 =?us-ascii?Q?Ilz1/i3is8m9bxiAoyophOgBXDHf+rMhJFEyKanJk9gI6bRvN9AU6GjCue7U?=
 =?us-ascii?Q?e77/hrIZHSN9MN9euEA00snAXGSGIxCK/2Pf0Gn1/+u/ikCWYBnLTng/HJjt?=
 =?us-ascii?Q?R+1/hHlCQCadx0Gp+x4hqz7KBXOtNN14lO2fmq70e1J+97LSpCG6sDYFlA4S?=
 =?us-ascii?Q?Q0vV0eRIvPnkGZtvx8Y0XyA0wl/cEAcvGKj45xJrjUD836hzmfplkAYmDVA8?=
 =?us-ascii?Q?7pOJr14ZEPTToE9m+CPBMieg79UzwpZoYd6ikh8lu1EVvtFrzUwadN6Kf+dD?=
 =?us-ascii?Q?agYgsQtXMEW/MqGZV16dRYr60ZGZ6OGEDiibzvAWnp8VwBHkxOn+T3lKo6IK?=
 =?us-ascii?Q?zxkHdN7vDHMrLwwwMqZ8eYl0VCbw/f7m9jpaZe1ZbPRGG+aFlrO7WJ7Eb1RJ?=
 =?us-ascii?Q?oIoAmjWtMpvoPBK3jrQc2pXdtKIc4P8xqyVsA4yqENSW3SIcMnPzNg/VAvDS?=
 =?us-ascii?Q?zVxXOlKGDu3Bxo3E46kq14J77v/GbOoVFh9D/0MHHgAGFq/ekllR8vBCUmIf?=
 =?us-ascii?Q?VGbLF3b8/RwllUmK+flP/qT5YGnNOKyGpoeud8qbCA94QiBLy8p4Ml21NHVf?=
 =?us-ascii?Q?J0djS+heKfAehKtZnO2X+3UCTA0QG1HIZyFeCwsJxTq5MCEicgOnxs1O2Tkw?=
 =?us-ascii?Q?FGYo/mMHXfSxk7DW+A4Pw3OcEIsyVbmwbImhyvBrmElJ7UpKP3ZM0hNZIGSG?=
 =?us-ascii?Q?vOwFYfREGxYaklzbfefkaib4PsEFr2CfuuGWR5EBRcHEUJsx59KGEg+un65a?=
 =?us-ascii?Q?wBEgWiPQgHgu/FpVw9DdV/hwPg2KASiR2BF3rJMTaw8tw1dcQS9DMjf2yrUk?=
 =?us-ascii?Q?i/wqRr+t0gCI91pJKbnN8c5r9OmawhdjO5H02raahZIWgXxWZ6BOwvMWJrnZ?=
 =?us-ascii?Q?X5tn0DY4/1VLbDToQsZXEHHlEoIphuhVAkLoAc4+yjSpMOiU7MNk3dH6hrgr?=
 =?us-ascii?Q?YpynV/a8/ZOhRgBgxCDO1pvnhslUThAYRO9+8DUoHFg841+PBuZAV+XD2zXC?=
 =?us-ascii?Q?wZZgy26H/Yp0MpgFqL90s6E4xLFs7fzdn8Lfc0vaXDVLmyM09Un3fG0Bbzpu?=
 =?us-ascii?Q?msQJnaJWG4qvB4U=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9syIyb+QC06j9M3npICR4MG6JcVTZkw5Sm53hB8U1P5ZWJXC+N3eAJ0vHlCn+UyQuyP7sT/Jx2r0q/nkBRDrT3A6d01xaNprGdjf/SOVniYsr0N0502lYAGjaTPfurQvH9t8b0Z4KZ3IPDHWpt+5OshkyGbVN2hZX7LdakvpwKBYKU/Et4wDzXWvBL0JpJ4R8hx5WHjgtd8FrrqSstGuWvXoNgtR4w6Z2ggylxC2inFsiXoSgf860wLOBFkiQk2CErQjmT0Nj84jyihdV0kjRMhhSywuj5CtbR8iCqvffvay+TEnXhXAV/m/3KuiA7+hJn5Ki6+bR7pIwov/nhEWPS003EFTJEU/AKIcKt9ICarpyrhprzi5zhY0kb/UiTkPdQ9OcB9z8gzB4iGhxm8gRMR+/N5hv71ym0TXweKjXA8+lgniL1L3whSOhOCcmoVZ/w65zRJGXO+IC2wm78rAbNomzHZvgYfZiRCUAxT5aqdk0Q+rxYDDET76QpMQ3grq/MsfWEcm5pFh9Nl1KBuRiuV4DwaczW7+Ul4MW67nAgTDsmp0758TLj6s95Xg9rpfbSfoSRW6WIdNrlxj1wzVNgSCMDn/z0vgD3Drf7AURcswfhSBeH2wbtZ7dMPTZUaJnk4tqU6sI8Sol4ytd2d6hpp3VsAbn+zNXf2qhFPFdFw=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:37.8809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b0bed8-3f02-4440-420c-08dd51fa9169
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP190MB2189
X-BESS-ID: 1740089079-302137-23555-14703-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYm5kBGBlAsMTktzcQy1STZIN
 Ui0TQt1dzcwMLcyMIoMTnFzMgiMVWpNhYAsMkNJ0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan21-197.eu-central-1b.ess.aws.cudaops.com]
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

The changes for untrusted loop bound breaks VLAN processing

This reverts commit 36cd2cb0eea49813dd59ee1df2eb592e8ae5b6b4.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 70bff776be..43f45ebe34 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -53,7 +53,7 @@ int interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_fl
 		goto interpret_end;
 
 	/* VLAN */
-	if (ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+	while (ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
 		ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ) ||
 		ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ1)) {
 		if (size - pkti == 0)
-- 
2.45.0

