Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A446EC02196
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C0CB4066C;
	Wed,  5 Feb 2025 11:46:12 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 0DE2D4060F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:09 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2170.outbound.protection.outlook.com [104.47.51.170]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdjANImlGV/tw7Y7oK0mxFwitwnYe5CKu6TU6JANulLCRb2YKBxuAHjiW67tar7dHuRVFEgItsLsxjbFVexb/K2v3oMzYr2Q2px2FoW3GD/SjjnpVgoxLSna9PAsm3+rG7diouPhui6jjmtqgH4a5iqbF+L+yWlSOMIErMlbvAZNUyOU7uh6RNtjYz7JGmagIJwurCA+VBl44zgMrjYUZ/WxqyS12LeG1rPK+PnxbwTzhtcvbtB12lEETEuQmd+Q+db/1UqVe2hfskUARIEZZVHrOLVcmcxUKU/xvRKZ8tAC07JRJFzm2voXJUFnx2ewYZKzZQPb+62Xh2iBqzVaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AUCH6m+k2CsLhnzSjeDrXzMfdw9VfB3he+PABx82gQ=;
 b=te+nyXx88bDo8bLPPaFDoNKzDqcMAYsIFKG0TC9w13RL/wBWFmqo7oEKiyxUVbQeFIynF45T3ppeIhLqp1f4nzuLfNU9sKW3Y/JpkJpFrUkVtcJe/K5uMbbGrZ6G1/mUZ70bHh9NRWkgisxMvPK3llSgj8k/rkT7c8lOBbb1HN13l7JcVoTwxEk9GpJ63fw4iVuZhLJiyqExDovl35Y1bKsrcnQ5Tphjt5Y1T9lhCXzWtN8J6Tn6k79fUtdDjo5fsZkslytaMKtO9XEofgxVfjUQR7/pv0/RtOuJngXYTu2o3cbtpP/Acjl9swfCTTsmB2MvQlYe/wP0alZ34Ps4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AUCH6m+k2CsLhnzSjeDrXzMfdw9VfB3he+PABx82gQ=;
 b=FebVYic8X4DfegacfWDneUsPwi/JoQqU70Zda9r/+odHi1j8oiXJYZq3NdeDhPggZrJZFqv7TPlkFRheIYCWaltdx+nqzy57N+/ksYcHz6fZKmgBgiwmXALYkG4tZgnCuH233ofeOK8gcNqixE0Gj8Fey+1qyIF1Ay+pTsBWkig=
Received: from CWLP265CA0350.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::26)
 by AM9P190MB1345.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:266::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:46:06 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::b9) by CWLP265CA0350.outlook.office365.com
 (2603:10a6:401:5a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 10:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:06
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 12/34] net/ntnic: fix overflow issue
Date: Wed,  5 Feb 2025 11:45:21 +0100
Message-ID: <20250205104548.1533554-13-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|AM9P190MB1345:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c6092b5a-8bf9-4a35-511b-08dd45d24b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EOCXoNxH2gU0vxbXsXIH+RtjwXr1DxrSRSrZqh/wqIKshkESviLcqYDB+GgZ?=
 =?us-ascii?Q?OA+6dFKXLg1eU3wHJbusNlptMZ+1xa+tquXuvLuGi786DcSobD0wfXbj63q8?=
 =?us-ascii?Q?ObiMlux5EOvSoIyY0LdyKnrKrdpt9qT5xB0IBja3Jrahv2xFp1wryvP3GWKt?=
 =?us-ascii?Q?e18DOwA3Kx/hNM6G442Kxce9jTGBQQgQaknmcJxLpuQdD1w3CpNJdlllFPG2?=
 =?us-ascii?Q?mEMzoN4xgkoSzxjiG3W1MqztKJ72Q6wY6e0mb98rLpsIF2vqlg+lWJw45l3E?=
 =?us-ascii?Q?+U76iIP9aJuzNvHubCXg8qrQ/YLz7BGCSLbBiB3SBAa7OVRQ50ZqiqIoDQXL?=
 =?us-ascii?Q?OibnlwjAOkgDXcBddVtG4IOBIliiYfvpPXyAqtA3hmbmPg/KGHVMpGHhZ8QU?=
 =?us-ascii?Q?lKiViNLfnItfhazO2J38RAiy+WymthQkvrLnC9pkJm7L1hjGlQxLSZDSkPpE?=
 =?us-ascii?Q?Ow3j+RBS5oL2eJDPhZy5magKXrH/pyWA9F/i9E9VenYh4V+GpnzwnALHmntZ?=
 =?us-ascii?Q?h1UUrTerusQaJRGJlnT44i4aZVeQrkFeWgnNwTYTz9L0A6b3KdrCZg71yzfR?=
 =?us-ascii?Q?s5EBaPS4QH7lD/o7feWyKuccmwCdgxYSrWFrIsIrC2Z0hCrMyCkX1+8pNeeB?=
 =?us-ascii?Q?M6+gpB9r6xNL176rp+q5hoNaMqsMFSMvYsOB8l8vIOvIxZ7e2y+x1FGRvHLJ?=
 =?us-ascii?Q?t9FPPFGjZrevi9B3T4oqdby+8hwSDacCzkiZA3vzVBxCJWlCnHKYAyhNXami?=
 =?us-ascii?Q?SRmCTtb9Cqt8HkCoW7x3y6wliwYhJlhQ/zXi3jCwXOtGYMTrcjyk0lHeF7kl?=
 =?us-ascii?Q?OWo9htJ927c1wJZYu51GHPYYE9E3qD4Z6NzmxuQwQoYucUHmn25sKQkkZy11?=
 =?us-ascii?Q?4Fn9YBsC2JXHrjApXiVbynz01tui7+Izh/UlJw5Bn+puf3JQFz4VnoxkFrXQ?=
 =?us-ascii?Q?9LNQR977R4YYK9kUXWB5eDorJovpsp1SK3R4dYsPa3FC9RDsC0knOobfSD5M?=
 =?us-ascii?Q?SHEM0mIGQEqSuukAKHNSs3Um3XufLrO2kqDO+iUKJkgnANEqrwIiJGKVFac/?=
 =?us-ascii?Q?JzDpOc0kKkSPPtWYBHszpEa+6Iq2rhr+kMg3OEmwPl0QB98z0UA2t4dSUB6Y?=
 =?us-ascii?Q?8B6Lrndu9OPOlMGzgh24xQ05qCRAqAVsykVymM2hGXjpuvS6Zg/DcnAhMnaC?=
 =?us-ascii?Q?uYZxdvo1YnLaojaFo0UvOzfHqIuUNsIfkzrIZcEHAUGhIm3HGBlBP+B9zSKY?=
 =?us-ascii?Q?KpsYVvnHtDOZDNFEf1Nb88cnKXu0GRNu60SvKQTCq89lYuM5/0mRUQGUF8If?=
 =?us-ascii?Q?OJfP2xgdIKO5iUG4aRKYsWBbl0liKeo1qIu9B9e3mCrrZDqxuN+x0DDU4Pa3?=
 =?us-ascii?Q?JNtjUkI6nA96nbjKYBi7TRG/nbc+s/hZUCIMIMLGd8JV6N85YggkAD0WyH7D?=
 =?us-ascii?Q?58jyiI379BlCax1w78jCUSSDOeTG5dRToa9GfQBlaTa6HsWWkkMPBUS0UjgG?=
 =?us-ascii?Q?ObTW2OM6H5h4OLo=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cOWCJ0JTMudQG9azZoUjuYBWV4TuSqH+vOZFA2BuWwRAkryRt4bOddlElBqcKGne/sYOYNSunZ7sAhHaqT8q7GhFtM7DwyNmBJS4Z/WA7ZcbOII3PvuOJmBQ+/DPclNSSfxvym7xBQLFk+M2itCyf7WowgBiUZTLSW1SNkkbcEIZfALT37jDKn46GAx5iPP7nzKfj4N63AS7cLQsD9Y8yeJMF6rt+EIGRjfB4NXak+ZEtO0+/QSPncQH/6PfqKtsg8gtCyXV3Vbr56UGQ/B2pATBRuwDXrQ2INwM7NIxU7tuQBpM1cg0kXrbIQN8CvaSDDqC9NDpqyme3k7QolME1nuxxGynqkRMXXmJrbkQqhhtUx5Vo+MsMunooJxopflMqXn4LQ+WuqLGllNrMY9WvHpK78R9DCbQfocIzd+BRMt9clJT24s111G7tO6xPpk8I2MkhXsi3PMcHqRa/QaH6apl1w6U9G1k/14svZnksADVZmPDODUPC7wy8ehwYfn+Ad/Ywp5D6ZKCnw3XqqfexJMOMZVF3a7EU0lQzU/ZaVLCpLoxeUfRBbfhuFfsQb0no6VT6z3BMnRb3qDFBK4GaH+A52Jzx6iz6szbbmyOboT//XtH6DqXIamM+2XQcrZkMZ7qgaW7aIp7WNea+cn7KQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:06.5583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6092b5a-8bf9-4a35-511b-08dd45d24b67
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1345
X-BESS-ID: 1738752368-302364-7585-650-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.51.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaG5iZAVgZQMM3I1CjN2DA5KT
 XZKNXQ3NjczMwi1cjA3CDJ2NQoOc1QqTYWAMz9zWdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan13-83.eu-central-1a.ess.aws.cudaops.com]
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

Fix overflow issue with checking max bit shifting value.

Coverity issue: 448921
Fixes: 833962ebb893 ("net/ntnic: add CAT module")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index a68c3ea702..574e51c2fa 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -3605,7 +3605,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			.err_mask_ttl = (fd->ttl_sub_enable &&
 				fd->ttl_sub_outer) ? -1 : 0x1,
 			.ptc_mask_tunnel = fd->tunnel_prot !=
-				-1 ? (1 << fd->tunnel_prot) : -1,
+			-1 ? (1 << (fd->tunnel_prot > 10 ? 10 : fd->tunnel_prot)) : -1,
 			.ptc_mask_l3_tunnel =
 				fd->tunnel_l3_prot != -1 ? (1 << fd->tunnel_l3_prot) : -1,
 			.ptc_mask_l4_tunnel =
-- 
2.45.0

