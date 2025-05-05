Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC1FC3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 901AD40E12;
	Mon,  5 May 2025 09:14:24 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id E036740E12
 for <dev@dpdk.org>; Mon,  5 May 2025 09:14:23 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 mx-outbound16-191.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TA7NVAhq7jsgueNzyvJd7N//3ycsJpxZnr73XDRXPUUxSXcdeO7EfuP80qckDcryxV2JSQpRdypz0ERE2Ii+iiYUSbblQtzqH95Jo6B4mK1zincpi1xtm/0MwK1o128hvjsep1pJ+19WZOAmGL/JbqxHJqUDfdlDA8V5kA5dTieBuaFWsTWwj3G53lCmJJcE/nomSfqhNJ/tCyK/A5wSaTskTLZjmPLkhKb1YRBXGW0Z+WCN/FRiwh1ddrV3fXk2M92xEHicOdvN9dQapgf7qZX8G7OqTrV8jU5S9N9OYUZLR96W6iK7V5auZBby9Tw9PCl0kVQRpLCeyVYGZIhLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuCjpSvwqJR4EAFLjQOjGHHtohwQTN7z9zP2c3+6uJY=;
 b=nSYPyWr48/xzAQNVcv62QC/uuHq+byGI7TliRjm6IdYOGC4k+BZz8fSqZSmY3XcffC+GGWbscWpFfqfx2eJNyhpx/IeMpElln2VjOY1/a5irRz/iPkQPGIOchDDU+hPuLS1VZHiRXmNS0Hhi8zrD0XbMD1dLsFHZF1a1E/LArm7L+At0Nqz9SQey1dQW/hGyacblpA0sMUdkjKM+pFNDriqYRPEdGVtxU1rU7TJbjvqAFRGDyZKKKAIbJ+Zlb1ed/8bk6pK0yfGESd2LKzBR+Lh/B2JZWYVCvNM6nb1GXMOJAneBclH06F8sFwq0wIAXUQu/Wqnm3Df+KFBwIU8LGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuCjpSvwqJR4EAFLjQOjGHHtohwQTN7z9zP2c3+6uJY=;
 b=AKqdfIG72senIkRliEYc1ztfkztKha8Gr/qIbWEEFfkNyKc0lRYDy0iHfNlUO7gYl/iEKzJ0I05N0IXhzysbVRm4Lpw+bEPeFCn/uNJDlajS2Y9mob6SRCGwtEBnQgPNOcTjYJaCTBIa0gx9wUeRmbT6VQnjTc7H7c+v7hi5M+w=
Received: from DU7P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::7) by
 DBAP190MB0856.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Mon, 5 May 2025 07:13:27 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::1) by DU7P191CA0015.outlook.office365.com
 (2603:10a6:10:54e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:27
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 21/26] net/ntnic: avoid divide by zero
Date: Mon,  5 May 2025 09:13:01 +0200
Message-ID: <20250505071309.586015-22-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|DBAP190MB0856:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60c29e9c-c54a-4d76-30fe-08dd8ba45501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N/arai5nJkFO7As9AX9B/GzLxxhgj8neQEror56ujWn/rKVqY1fk+mPNRqJR?=
 =?us-ascii?Q?9tdCPtvihgiOqlCzs/hxu3JI1eJdKlNbSbG9c34uIesfiME/OF4gmt9To67j?=
 =?us-ascii?Q?lfruVR/3oYxyuHm8R+JI+/SipdZrLQUh1AdOVICwhlTyfL8Yi9hRiN1K3qoN?=
 =?us-ascii?Q?y8OGgeZf8kQKnnNotPx6/hzfVpsY/hJH7M9fK1+6ZbLxNIeVmBdct1K6LPaS?=
 =?us-ascii?Q?5W3m8wN3zSbNMqR+WPSGzfRmnItjcjM1rIKZ3aB2nFhU1lv0edqlhuTI2cFQ?=
 =?us-ascii?Q?65ls7aNalsPsB8mPvXInWbQSREL0uhJ8lNQMy8zPfh3YTIKYAHRbGTPRHrD9?=
 =?us-ascii?Q?IfcNvP4X6VPGtVUXHTfGTCHUi02AhW2n6DEccjXm3NUCugSv2j6lxpQm8c5S?=
 =?us-ascii?Q?lr9YEAgiY+dJdEYkrb1+ddHhf7n130DfQbqkeroHnJ4gej1vhrBhkqTnU1Y2?=
 =?us-ascii?Q?iawFKpKZ6aVtqk7mFj4PFpoGv6ud/lPbjjgCnhAuVG4tssxX7pSPz3Oyos7Z?=
 =?us-ascii?Q?1CxXDZ4AUyUHNM7ECNhUUVg38f6bN30cjilGE8DxET9GVHi0NDzs/yWzFXW/?=
 =?us-ascii?Q?rbn2dyjFB+BA5P+idoMa1JJ0RIHTce1Qbl54PbwDz63gUakxst8KnJz++5c+?=
 =?us-ascii?Q?qEKOyR6Pj2tJAK7eDCRNYtN+OZdSWEgLs+2hYZHVDCCt3iASfa0HjFoPQaEF?=
 =?us-ascii?Q?EA7BwlD9eVaM16Koc4rj3LWAy/M3orI1PCPd+eo3xp/EwZ0/oz+RTW4kUJv3?=
 =?us-ascii?Q?5QWMmn++ohwb7iU334owwro/zU733tZrR0BFyPHgkJk7JCLN8nmtQT9lEl/4?=
 =?us-ascii?Q?AZaLe8o3BTAMkZvNNKXnCaSFz+72W91QD9fQeTOvpCKXj+GPpByE08e1qQlX?=
 =?us-ascii?Q?hcyG87Yd92atruWr86W5fxtjJRT3hVpwZdOVr60a5gtoBdPDJrpdgYeSleCT?=
 =?us-ascii?Q?DWdLrftzOj5OIl3Bn1I3UuDcPNQ1IR5Yh6MCZtb5Ig1uBU8/yWarOgaVDKF4?=
 =?us-ascii?Q?y07GHu5AKXg1GFmp2UE/A6TZ/65vi/i/tA1MMKKNJ/HQ6m66GkDBvhmWgm3Y?=
 =?us-ascii?Q?dz5y+ZW2S93ZZ1OZNPQvPTbLKFGb5b0oJCXQfC8z4Q3iCelhzBHNoPCwTz7j?=
 =?us-ascii?Q?czxcmwHDAf0RsA5x7y/33x6gjDJESmYlPrss9PSgJLpMRXsk1BPvBFvPR3C5?=
 =?us-ascii?Q?UTxwXCmV+65fZKG6Q0tpwglKw9Lv6QZbx4c4nDD6I9aCs7iZx0K+ukt4cLn9?=
 =?us-ascii?Q?y3XLOt/CEuzYa7ca/QanRJKNOda1M8R9QOzwGbeA6lcqDaUimkKNY5KtlyPf?=
 =?us-ascii?Q?N+PwAMpt6R/MTt7vAT+cLUvHZZABuEZG6VJo6WqGTUNx4ivB5ZQAYIAiufTp?=
 =?us-ascii?Q?oWRzOY5msmHaAnOcB6nJzEikIWeUFHfgjTofwIbKyziiiI7Wx0iv7IODuolO?=
 =?us-ascii?Q?9FNzT68bLtpBaUb0Zg8MGzvSbAFVBg4SdcD+nqmwZ5yHZBMgepAGLe1UrPSc?=
 =?us-ascii?Q?i4OxCXGOncfNJVJzcH30tFx6f/zmJk0CtKZU?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eV+xjT5rA42YDwC/1n07s2x9VGu5jadYDNB+KdFsQ06rO0M9IZ8uqcIax5rjm0l/TIs5JXAc+Oeg6ODjY1MsA6L525wxLK/PAUSv0/G1QquDkOy1YmSruC9IV/FpMG2GMl6Cc/uSZEWoqYSB26sPA7d2/f2mA6lXICNxsLWu4v/408OtoQIDCf/xMd5BjzzCPDgo8VzOhilPGbCDV+vVD43cVFirxSXADkEOtBGNErk9eChjs26vIGCoqT1NkEFj+r2W9uENAd28DqYGzFRiKSe2ClVTKBztAVlpojjIBeY1iceeqvUeMQqIcquEaUOPBdYeWsPArElgcG/32CBkZWYY6N4vwCrTy1pvCsatiOATgU9KT7PH/UpmmR35wpHYOoKTaqZpp1/Jc7GAwP+RM750MaCwjSLY/0QC1E3gu6BAYHgv1IUMq4/efM442SzcxlSfzN5Ph49CdINOF2vTbe/0lwTnyI0HUKNDdZFicx3ekLaAkOIao5gQ8O3VKCSihmBECBPCl4JGT4RtyDRc3OXLQO6pGptfv4MtDepu1KdEnU0pk8yS0ZQSSjIFCE5/ueAP41+zQZb5rDB0/TvG6mObF8dMBTJ2PGkal6Ef9TfbB0bnaRROypi5jgrh9WlFt3abEMGOZQKcOKA4O+SxHA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:27.1619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c29e9c-c54a-4d76-30fe-08dd8ba45501
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0856
X-BESS-ID: 1746429210-304287-7662-5300-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGpqZAVgZQMC3N3DTZJNEgJS
 XV0MLS1MzCIMncItk0Nc3QMDnJIC1RqTYWAJf8z0RBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan16-45.eu-central-1b.ess.aws.cudaops.com]
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

Fix CID issue 457736 divide by 0. It was avoided by
adding adittional checking on the return value
for function.

Fixes: effa04693274 ("net/ntnic: add statistics")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/stat/nthw_stat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ntnic/nthw/stat/nthw_stat.c b/drivers/net/ntnic/nthw/stat/nthw_stat.c
index 2ddef052a5..9bb97bf311 100644
--- a/drivers/net/ntnic/nthw/stat/nthw_stat.c
+++ b/drivers/net/ntnic/nthw/stat/nthw_stat.c
@@ -319,6 +319,10 @@ int nthw_stat_init(nthw_stat_t *p, nthw_fpga_t *p_fpga, int n_instance)
 	/* Set the sliding windows size for port load */
 	if (p->mp_fld_load_bin) {
 		uint32_t rpp = nthw_fpga_get_product_param(p_fpga, NT_RPP_PER_PS, 0);
+		if (rpp == 0) {
+			NT_LOG(ERR, NTHW, "RPP has wrong value"); /* Avoid divide by 0 */
+			return -1;
+		}
 		uint32_t bin =
 			(uint32_t)(((PORT_LOAD_WINDOWS_SIZE * 1000000000000ULL) / (32ULL * rpp)) -
 				1ULL);
-- 
2.47.1

