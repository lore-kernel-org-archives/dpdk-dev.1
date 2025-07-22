Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA87C83F25
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 08:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8749A402A5;
	Tue, 22 Jul 2025 10:08:32 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
 by mails.dpdk.org (Postfix) with ESMTP id 1B6B940265;
 Tue, 22 Jul 2025 10:08:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scQmFFoVJObGICc1iM5qPnHqBRPw4wnWv6qFoBNCP7lM0Xc9IzUE7Hgai48shN7hNVMZx28fooljCyPj0uLpMh8gQzcfQ7SmTKFgUfcZkElT4h0T54UMeDO/IQ3h43iO6VP6cRYzuv2fZTUetBWPkSOM3qF1JWljlD9umkP6dvipP9YYURs8aazAB0gqNSQ74UJ3TJ/kAS9MOYmzYwDrh4wLNlI6+NL+qbfq9nKZYGgUJ7uQ0AuW/8mWOlk60dvgDii3EN43qp8YPj3J7aIOtTquK1DYnVL7lCnvWLnWjqfmxvoCqkxLMyWuTpwpFBDis+scy76yW8O1ezZwxo48EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zgRu1joFRqKPfXzoocUoVjynQTsQUZglKTFmMVSJ1U=;
 b=pMmT10E0JNzCxWFiaUHj+5Ksxi64j5KJ/T3tEzOY69ATUCkb1Lya1Fc2cxFmpCSNx5Rk5Jt6cN9hesDPNyT2jq4dG4dz/0kAtRJbdFHkum4gL1ImHBiZbidocoFyAMTr2YEgCy7sb3GrI0RB9MXSu4iZx+g0wwX7bldxjPHRNesvmhR/Bq8UAhcmOxk4MQczQs0OEnnkrRKJ4Av9h92mlsf016CUHZDq+Dq9UQ3wuQCCdjGB9XuFl0HlHCXDni4nGCQ62Pr+/+te0ZA9LjKOPRFL5lNllAKR13c/5/2leQHDotrM6Dp6YBfHX53iVI/3X3VqiKZy5p+XlNDPYELpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zgRu1joFRqKPfXzoocUoVjynQTsQUZglKTFmMVSJ1U=;
 b=Cl2/sxBqaqRYoUj9R58xGnmT28/RKkgzBS/TiKaUrVf29Lss07rguF/398ZrTlYLBC8UnRbMm+zZdVd92y+EHT2FVtrVFudelMdbRpU2AXBeUwwPBiaw5g2AOvkPtodIBqf8Zak3+n9Ft9bwuHssntWRI2p0cDa3D/5/xaI2tnsjwyyfr2GAJcdjt0TJwLeC9xwzwLoXFTzIlKKySFKqADWUZmfLwWaK1lqgDlBRwzYpSu4EbKX5m9+0Azb9nUvEqGCTNG6WAE78PZcjYI8qC2YVrMOPws6KiNM0i1zdWMGZ6oaKneWQqEhGPzhbqd5VSga71kahOyoWz59oeebO3g==
Received: from AM0P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::34)
 by VI1PR07MB6702.eurprd07.prod.outlook.com (2603:10a6:800:188::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:08:29 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::55) by AM0P190CA0024.outlook.office365.com
 (2603:10a6:208:190::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 08:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 08:08:27 +0000
Received: from seliicinfr00050.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 id 15.2.1748.26; Tue, 22 Jul 2025 10:08:25 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00050.seli.gic.ericsson.se (Postfix) with ESMTP id
 633E01C006B; Tue, 22 Jul 2025 10:08:25 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>, Jack Bond-Preston <jack.bond-preston@foss.arm.com>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 <stable@dpdk.org>
Subject: [PATCH] bitops: improve power of 2 alignment function documentation
Date: Tue, 22 Jul 2025 09:53:21 +0200
Message-ID: <20250722075321.121254-1-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|VI1PR07MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f92ae6-8fd5-4895-cc0c-08ddc8f6f05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU1xZTB1U3R5a2hSckN4eEY5allaYXUzRkdaWG1JSG1IWkVYSFl3Y2VnMXQy?=
 =?utf-8?B?L0RoWTl6akduakpOelVJZkVtUnFYZHdtenBOVXpLVGNRMTZSRjJRWU5IZll6?=
 =?utf-8?B?eG45MEwrNFdZU2JmMmVYbEVQR1FZYnNEdDlHRlNIdG5pbzB1Z2RvRklpQ1FW?=
 =?utf-8?B?K1U4NHFWTnh0aW9NNkNkZDVIOFp4TFdCUzU0MnJpTnRFNm5Rd0dnRnk0R1NJ?=
 =?utf-8?B?b2QwWE50RFpTVFc5RU9NcXltTXhBdndOb1E5L01CNHdaNUZoN0djeHdESmd6?=
 =?utf-8?B?Q3ludFU0OE94cVhxWTduNkJjZnFHTVVRNWlyWFh2QUsybVYrV29SbmJrQ2Yy?=
 =?utf-8?B?dmh6amd4WGpqUnJOc0szZ05hUVlTaVZxN094bGxJMk9oKzhQOEZuQ081R0NE?=
 =?utf-8?B?SWxUY094d3ZkUDQ1S1I1NzV2MWY1RzVIOWN6bFJkTnJmRlEwQXBPVFpKWDhB?=
 =?utf-8?B?Z0pGbXlMdEJ0ejVIM094UkVCSFhQUTNOc0dhbWNQQkVOVVFWL2FNZUdWeHd1?=
 =?utf-8?B?R3o1aEJKZkdURXdOQmZJUGN6bWVZTFplNmZaYmdLdHd3Z1dLVGl5ZjU2enRv?=
 =?utf-8?B?QnZGMG9DTHYrcjVXOGJzenJqbmlja2JkRDNmNm4yOHJ3NFZyR1VGb21HbjFj?=
 =?utf-8?B?Z3dkTGJGellGREpDSGNYSDNpa2xxRVNzbHc0K1gyQ1c3aDVGV3k0S05GczRx?=
 =?utf-8?B?TjdYWGhkcHM4ajVqOWptWkkxTG5BZk5DMmdSbm5VVDh1Qk55UTZVSzNLWGN4?=
 =?utf-8?B?azRQTkNkQmhsQk92ZGt4MEowUDd0NXhnSm1QckFXaEp4eWg3bGdMUUtmbC95?=
 =?utf-8?B?RXNCblQzZURvaUJEYndoZmRDVUthcXZnb1FPRHFGSURTejJGOERrU3J0WnMx?=
 =?utf-8?B?WmtPcXVtamNJSS9yQ08yQWs5ZUN2TTlZUFE2ZXpubnpwd25KVE1BQUxKZiti?=
 =?utf-8?B?QlA2ZlB3WE9ERVc2cDJIcmxZMXB4dHd2L1BPamRwTnYrTUlvbmhVV1RWZFpS?=
 =?utf-8?B?WC81amN1alp1S0hGNnFoRzFYMVZCclg2VC92OWtNR1oxcC9GZGk5N0lPeXZ0?=
 =?utf-8?B?Mk1hbmJTWUVabmt3TTRXM2lySnFTMmZnUDVJVlVyVVlPSVVyZTVyTTZjeUpy?=
 =?utf-8?B?QXpJTkp6amViVERkSnlGRUxUYlhOZzlSaVdweUdaK25pcGJVNFcwYm54Mjcx?=
 =?utf-8?B?U1BmVitGWEdDQUVwSEdYOEJUa2xKeHh2SVY3MlBqTnRheGFQWmh5aFNWSDZh?=
 =?utf-8?B?TWRiZXBPT2J3SWJMdHdCZ2UxTkdaSHVubnF0azFQV0RaVGpCekRRYnRFeHBV?=
 =?utf-8?B?T3dQa21Zc21YYXkzSjNvNDFaUTN4c3djcVNVTksxODdPL2dUZWNXUEg3MWJD?=
 =?utf-8?B?V2VWSStNK2JPK2luclkyaWNCMy9nVmVtWmtvaEx0V1diUTl5OVlnUzBRSEVv?=
 =?utf-8?B?RnJmOHVKTzBjT0VCUUxZVndDT0J0ZDU4NFI5NDFxYmhySWp1NEU5Y08xY3o0?=
 =?utf-8?B?dWhwaFVqVittR3plb2gwVU96Vml4RlFBT000SlgrZ1lVZGdXekp0cHErNGJn?=
 =?utf-8?B?czBSdHhDYVIzdUNORUJCT0t6QUxDWVROYTg5OXpjZ1FGNjkzWm1odVBFYS9q?=
 =?utf-8?B?OVBLVGxKOHQxb2xmUGEwYUVkZlBoRGdzekwzQUdkT3k4WXZlNHZuRUVqWkJw?=
 =?utf-8?B?b0d3RlVlYVJQL2k2enc0U1pmNmZvYTI4VVkzZ0hua0FPOEdjNWwvR0Zqd3Ir?=
 =?utf-8?B?cWhJUStYQTBuVFI5OTdWU1l6MmNJNFVsbnZ5U3hXakZ4eHVCZmc0VjFIUUJ2?=
 =?utf-8?B?OWNFeTV3d3FUeXJNRDJHUExjamRDeXdMZktaTjdxTTUyU3l3WlB2V09GUVdZ?=
 =?utf-8?B?aWo1TXliUmFNT0Jjc1g3ZmhNYlBRV29MWDZhOWhJN21sYnBXQlRnRm5IRlFw?=
 =?utf-8?B?MmpVQW5VVjJiNjh6K3I2R1oyWVczem5JdDJSRGZaM0JTVG9FMjR4WkF2Z0RE?=
 =?utf-8?B?K3lFb0FBOWZVbnIxa1BQb0VuMVFoN2Vydk5vVFlZandaQ3lCMWNqRzRmQnhj?=
 =?utf-8?Q?g4U7Ci?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:08:27.6134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f92ae6-8fd5-4895-cc0c-08ddc8f6f05d
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6702
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

In the documentation, make clear
rte_align(32|64)prevpow2(<n>) -> <n>, provided <n> is a power of 2.

The original documentation stated the "previous" power of 2 would be
returned, potentially leaving the user to erroneously conclude that,
for example, rte_align32prevpow2(32) -> 16.

The rte_align(32|64)pow2(<n>) documentation, suffering from a similar
issue, is reworded in the same manner.

Fixes: 08f683174e94 ("eal: add functions for previous power of 2 alignment")
Cc: stable@dpdk.org

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eal/include/rte_bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
index b9a6af381b..2d1b9d281c 100644
--- a/lib/eal/include/rte_bitops.h
+++ b/lib/eal/include/rte_bitops.h
@@ -1320,7 +1320,7 @@ rte_is_power_of_2(uint32_t n)
  *   The integer value to align
  *
  * @return
- *   Input parameter aligned to the next power of 2
+ *   The smallest power of 2 which is greater than or equal to @c x.
  */
 static inline uint32_t
 rte_align32pow2(uint32_t x)
@@ -1338,7 +1338,7 @@ rte_align32pow2(uint32_t x)
  *   The integer value to align
  *
  * @return
- *   Input parameter aligned to the previous power of 2
+ *   The greatest power of 2 which is smaller than or equal to @c x.
  */
 static inline uint32_t
 rte_align32prevpow2(uint32_t x)
@@ -1355,7 +1355,7 @@ rte_align32prevpow2(uint32_t x)
  *   The 64b value to align
  *
  * @return
- *   Input parameter aligned to the next power of 2
+ *   The smallest power of 2 which is greater than or equal to @c v.
  */
 static inline uint64_t
 rte_align64pow2(uint64_t v)
@@ -1373,7 +1373,7 @@ rte_align64pow2(uint64_t v)
  *   The 64b value to align
  *
  * @return
- *   Input parameter aligned to the previous power of 2
+ *   The greatest power of 2 which is smaller than or equal to @c v.
  */
 static inline uint64_t
 rte_align64prevpow2(uint64_t v)
-- 
2.43.0

