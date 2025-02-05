Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AABC02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88DD140289;
	Wed,  5 Feb 2025 11:45:58 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 5948840270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:45:57 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ig5UNp1wO0mqyFDBEZr0MgD1VZvNgoW3SaogSYUQOJXKwhJJII45ZuT4tr3FPZAf3f9Lr+inSHY3kBWWshgx6njJN1/AdHlARUd9Cao78Gz19qsiTmzkmss7gt9DJBeNFMNsDbLxYiq3zMu6IJR9OXXLl2irxCk3NpH4VXzc2R1hpkE79D5nLsEU5hipnsRQgbfhJzUUltSkn2FHg6TfWoE0Io/PpCGmddrTFX2uDf79iQ/PoevRBVqbTGsdN2+qjODrU72zkQ+4NmUXka8qf9Dz5MfCqEvM5QLSjVrAd+tCHibBSlne/hdo7iwgf1nzoatJnPUKyck2ReyDrHzN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVIH8/dvec91XX2uLMfuS18hD2JwWvPWwLrQiTzfGwQ=;
 b=YLEi1Bd5OsnxVy+2zYZWg9HxhCeAJSuaXO7/O8IlX9sIKd3aYeWdQCsqygMxMwQ/Nm6Ns4Ty8VaH9zVwOXUdFcntJlXETvMgFmlHdtOn0ewdTneSr4AMc1RQqa2dwHGHcc3d/Pbr7RTIeIkXDs7hGoDjSGBG01ZirCs8hvtNylnb9rijf3dLRCif+tFcJr5/ZWT+3QQCKd4WbbTShn5nJM5t7T7QHSkZsLQ/zcbamD5h4kODve3fJQLc60h0hZS1Gs8QjD2x112Fnj9HlEKJdGhXYF//83fYNBDYlXtrTCBCAYqYeKVcEKdY3Q07ud7DVR0J408ltdzryvut3u21tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVIH8/dvec91XX2uLMfuS18hD2JwWvPWwLrQiTzfGwQ=;
 b=RTCKJs8YBZsBabMG1FRuQqBbUfBktksOE282ZW5mcP8kyXqM3/ZP+Nl+ibF92/i4YVwwA/gvlb8H6vqCmKB5l7UC6ojdGwnDPegCEWRoY8t/JpMp/r18tVhrjupGd6+pTv/yTaF3F43X66MQ3qw22t/++4P2iOaX/N/KsfU+xg4=
Received: from CWLP265CA0347.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::23)
 by PA4P190MB1086.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:106::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:45:55 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::a4) by CWLP265CA0347.outlook.office365.com
 (2603:10a6:401:5a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 10:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:45:53
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 01/34] net/ntnic: fix index verification
Date: Wed,  5 Feb 2025 11:45:10 +0100
Message-ID: <20250205104548.1533554-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PA4P190MB1086:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9b8a1776-0e2e-4359-d080-08dd45d243ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ro7Sv4Ne+K4sB5YgTqYhKXyhpTXLL4XqlBZBclRhAi5hwv2yade4elO4cJrH?=
 =?us-ascii?Q?j07AaBqwkOFzTeIr4xDnxdOYRzc/zC14ozoXLyXaCN2I0UAruoPX2B7UE6/i?=
 =?us-ascii?Q?Ui9QnuAfqaFHasgTJ4wbRwYUzEJI8lfSHMuhsXxR393GvDC7QfpZqPpDcN6g?=
 =?us-ascii?Q?wZ2tWn5888ly4WexXjFd2pxRs+tsm+Y/1rKI0ggUKS7TkIB3y1njy7tlKoYW?=
 =?us-ascii?Q?DygxB8H4z7E8e0s62zo0gzIWVgph+KYawmH1pXuExwqwucO1fg2qUmOSx58v?=
 =?us-ascii?Q?xRiuMa4205odMfzBBR8GgwsW4ZCzD8No2tLZxS4JrvPdxcn9C/TvZ2NRuOuV?=
 =?us-ascii?Q?G0w10wJIfrifEhbfxtJgsXBp0g0znl5+MapsguwLm655yPrwgyOxH88MqaKj?=
 =?us-ascii?Q?997vCwSdji4qa1SCwrIgRbyHQY09HGVrIE1FzpHlWcItizsgtAYx5PLiqlb6?=
 =?us-ascii?Q?jq/p8eURvkKcOoDuMh5aWi5SJ93zZ1OUha7vK+TKM6vPFq6ZfZ4/s6Iinqet?=
 =?us-ascii?Q?4Zql7vUMoQKGXcFRHf8XJ2xWkMMmadU77cS90oSMYJLVJxpNcM+eSRK1Ssp/?=
 =?us-ascii?Q?oUk+G6JpmOEz5R8mVbzHW8Xhp4SRq22Wt++sY2YJzaHKH/smH+ivN6F0Uk39?=
 =?us-ascii?Q?AaubZUv1pjAEzAS2numVo0mjpHq0HFjkT7T+lFSQ49znYouVSYIJMGlADMfe?=
 =?us-ascii?Q?yj+yodg2fhTCK+/PsOOdJMOrg218MCK5I9SqmJVtUgTN/8llEe6PAOlINap4?=
 =?us-ascii?Q?XF6HpduBZF1JIiri9Q/5V3h1aK/P5SSvkETShXH4L2V+zFX8oOIlmZ/hX8Ru?=
 =?us-ascii?Q?Rfa19ruiNb0yNJSVAGjJL6e6VYnLDkbAHAJ/kTMHW9yLtpHdAycijBpFeOIf?=
 =?us-ascii?Q?pVb59DjJix0hYdCWaEpb2mY+UAROns8YE2IGoFBUqTIDlQKMxBUO7yMcN8f+?=
 =?us-ascii?Q?hBh/OmC8gy/Gstvf5RIW9Q0QgyLSnxLW+baHy6thtsSRFtG/7UAbHq3c5xBp?=
 =?us-ascii?Q?eXtMEUcRk6LkyBe++psjiWboGn2tHnIMPv1EIouTmVqdQyql/g9nignsi/Bv?=
 =?us-ascii?Q?3D9+lQPgd75RSP1QqGYgrftI17Nz9Xg7N0ZOxDjcPMKEwbRrDtDlubeqk3kS?=
 =?us-ascii?Q?F7fwavjfLVdCJMg9lzie8/p/3w21RMSxQT4ac5DYw9jhflCrp0NITctiSUzM?=
 =?us-ascii?Q?lYyzi9RO5MJAg2Z8moS88w2X3fARCLe97yijXHcXZ+XzFOUsu6cVXKUFB84P?=
 =?us-ascii?Q?MZrbLCHIfNx0xK4DbdZbcayR+kwUIZ4EnV6Ans1uBGhhAQ87aXYP/y8EL8iZ?=
 =?us-ascii?Q?bG2ExPxACtNBMZX7Ob+DjyIfeiFckf78Abe7mB4LiOXMtGeFiYbf0yeoWgiA?=
 =?us-ascii?Q?csN8PBLYzUFHlZhukWpGt0pz51lOM30yoc2IW4oGRrrsGpk5+a+2/+Zrp9VE?=
 =?us-ascii?Q?+bpWR9NEuKU5pIqwsQjrGgDqMb/AZrr8eLcVMk2w0PPsuA0yleORIQltnvPq?=
 =?us-ascii?Q?53vvIJxi0s5cfbM=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UeAfyboh5PWyPCU7wQ78QIq9Kx1XRjfD/bC7pEIB0mOqARW3++XbHVOQloKO+l5SkdPtmGtUZVzPbMVS5YjCl71U5MeAsYa98ajrswK234t7wWEwBULjiEJjsbVMY6f55bkkecfcYEfyavKXGDmPW2rvpr0FriLw4XmYp+SqAT0J8Gd+mC1W1IOVxY61TYJ90Qs+mz2nYPHfAdFP4uqk8QJMXu/lq4RG1EHwUVvVGA00HAS/oN821P0LyEYZ6w3pbzQfWaDmarPs0ZhvuoSnc9UopcKLJqEgWIRgASFvGtbqcqIRqPSJgtHGamdkjz1HkopH+0h6AHRFl1PBGybtbLBwHyqH8VI/qA/vAuLIHKns24Yi7c3JyndpYUcayN1gvK0qVSs0EKvtp/zwD4+3laa2EFPCKa2RIeBfvtEzAWf1tCtPS11YuvI6QAuAWFzSx0yBNcpplf2igEJ0voEkHTxJ9xeQPh6ClCAZY5wwBGgZoTU9y1qzTaag8a8EM3pl38q33VUuwVh9UO4C7uh2R50+Dpox+LYX7D5jHXLFA2IMJ+w1h0yCyF471lYrYpzsEfDPgEWDCRFrLJ0IPbW22dUybhL9mg7Cwjv7cVK5AUoKZbtgoDhuWDr5+dYi5Qf79+5mXoi6a4g6NHrYFWw1xQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:45:53.9958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8a1776-0e2e-4359-d080-08dd45d243ec
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1086
X-BESS-ID: 1738752356-302364-7589-626-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYG5gZAVgZQ0Mgg2TLF0CIxyS
 I5LS0pOS3RMi3J0NDcNNk0zdLI0jhVqTYWAJJNXIlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan18-131.eu-central-1b.ess.aws.cudaops.com]
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

CI found couple coverity problems which were fixed in this commit.

CID: 448974, 448977, 448978 (OVERRUN).

These issues were fixed with updating index verification statement.

Coverity issue: 448974
Fixes: effa04693274 ("net/ntnic: add statistics")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 4c8503f689..e00b10ff82 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1201,7 +1201,7 @@ static int poll_statistics(struct pmd_internals *internals)
 	const int if_index = internals->n_intf_no;
 	uint64_t last_stat_rtc = 0;
 
-	if (!p_nt4ga_stat || if_index < 0 || if_index > NUM_ADAPTER_PORTS_MAX)
+	if (!p_nt4ga_stat || if_index < 0 || if_index >= NUM_ADAPTER_PORTS_MAX)
 		return -1;
 
 	assert(rte_tsc_freq > 0);
-- 
2.45.0

