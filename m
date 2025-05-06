Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165DC3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CF6840615;
	Tue,  6 May 2025 15:31:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2100.outbound.protection.outlook.com [40.107.20.100])
 by mails.dpdk.org (Postfix) with ESMTP id 0FFA640650
 for <dev@dpdk.org>; Tue,  6 May 2025 15:31:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkyWDh1Wv5HnvaN2QohDw1rdbOAG6LN0lmwZMNUSNunwv3g04myRSd6XVrn8pNMv8BQQtm/xcI68JL3sawpjMD/OM+ibz7NilEeRgAK9KGxo3xwe9oUF2AbC4Q28US3e6Z3lav0ywWRiP/+ZSj+k48EcCQiD/U5YzbBiWsZzcfjWwnCICum7XUVNe9798YtKv7DVEftR/B+xJI3uwzpmuboSiy6H0IToCykcmm7k5gSGks/6n+DO9nl34c5siocnoY2lfOpGu83/PmklPo2KwYGHJerlbBjqLFamYS52M9KbdkGM7nwRO/2Se3C4hOxdGTpV7Ps9c3s36diBdC+S5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE2dQMyw7vR8Orat065oUsZwmAPUG4T4TFI9iKUasjc=;
 b=lJ1YBfP+OFlWpoH9qEGRByq0nAiK5xEaeXQx1RYd3j6FnKCfK0+tFWKv/AYGVTp0kaeARBv7xxY5DRWV2Hjkhhb+ZYFA7ypWZgQRjX3S/qHfrf54TD8tBn8cPI+WQHm+ZGFk6ineCK37nwhDMkc4fKsFXuBg6Ou3w/sLk8erXMPcTsUwdh0eRYDmpFftUDW8dWfiZPXeenbojE4UAKxoVIbJ/nnikZmPizP12cuqMEl28VuyBesjxBOSAALWKw8z8LLo+MbEyWDS91+8tQnIwE0EnqMYDM5ebhcuLuMgtwc6bX65RcZ5mIxX8Sd4WK0lmaXZc3AEHA/uJ27VCxVFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cgstowernetworks.com; dmarc=pass action=none
 header.from=cgstowernetworks.com; dkim=pass header.d=cgstowernetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cgstowernetworks.onmicrosoft.com;
 s=selector2-cgstowernetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2dQMyw7vR8Orat065oUsZwmAPUG4T4TFI9iKUasjc=;
 b=D1au3vVyhoA+NlUK/8cIDlc2m8Yw+n8PWh4yVy3PgSnnGxb37wjF3TaaLLJCXyiXhFQVbL9QqqdsZ+IyiVx473RtCOLyKfWWdZs2VfR+PgGIkjqZMvO9skNJTESTa19BIrfZ1C6PQ1xTu04xsljNVadF9XpDrApvemiddGUVOxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cgstowernetworks.com;
Received: from DU2PR09MB5486.eurprd09.prod.outlook.com (2603:10a6:10:27b::22)
 by GV2PR09MB5965.eurprd09.prod.outlook.com (2603:10a6:150:c2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 13:31:23 +0000
Received: from DU2PR09MB5486.eurprd09.prod.outlook.com
 ([fe80::a8b7:d0b7:ce2a:24fc]) by DU2PR09MB5486.eurprd09.prod.outlook.com
 ([fe80::a8b7:d0b7:ce2a:24fc%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 13:31:23 +0000
From: yogev <yogev@cgstowernetworks.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org,
	yogev <yogev@cgstowernetworks.com>
Subject: [PATCH] net/mlx5: fix transceiver warning when not exist
Date: Tue,  6 May 2025 16:31:07 +0300
Message-Id: <20250506133107.4432-1-yogev@cgstowernetworks.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To DU2PR09MB5486.eurprd09.prod.outlook.com
 (2603:10a6:10:27b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR09MB5486:EE_|GV2PR09MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4e970d-9db1-463e-83a1-08dd8ca24aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KSzQPO7EWtXDgUtY4bipmK+H4RWzfdPsy4addkE/6Y2bdI6R9ho1FkPVCSaN?=
 =?us-ascii?Q?QmQ9U3UkpjB21yJivTkNvJ3pbw1/4dkhf3k6PZh9+YqWxrWgf+Qt7QpD2xQ8?=
 =?us-ascii?Q?K60Uv/QI3JaHLW+1JIHkbe7QE/qanAkmj6ImQaoSfobTKk4RSXjzb0HnYo8/?=
 =?us-ascii?Q?WzhikDZX+4G8bl8QSkUC7J64oiKg5YTfT/kAUW2tV58GbiVejjaZloB4olY0?=
 =?us-ascii?Q?uSdVTBEVAVgFgcYHKVplwcDkeovpzXhGkSg4hYwucDlAvipMa+GDL1VDG3+o?=
 =?us-ascii?Q?6WcBSSMUnv64if/EmRUEMPEnxU0q+e69DJaCul1t/sMcupW2kPzAtmPTFaXH?=
 =?us-ascii?Q?w0LMjF5BqfCAqG28b66gqrW6kLqtFo11fINaTHO+ImEm81YF9wegMpguEpQZ?=
 =?us-ascii?Q?K/hSOfB5/ufELToAy3/qPyLmsHZ1U3awQoXhEym1q70ZwpbrZgfMEAuZ1IVZ?=
 =?us-ascii?Q?b8gFvFGueKlSgYRoQGDGCz8mDG4Z87NfSDIkek03uYNdcD/9pa20JFvzH8g0?=
 =?us-ascii?Q?hqlYxxw9Gt48FEMprCqZj40s8rT31fN8lf/F3nLurD0QMZrYrUXOqLuf1Wkn?=
 =?us-ascii?Q?mOLA1HncGLDlBPke9RNPOQiTiIgqVFc8alQv03IFAeeL3GSYs9VGGbJHxbYk?=
 =?us-ascii?Q?VFM6BlmvsTqH3kuH9Zzgg7JOZF/15uokO8Jf2Oe8acNxInqg/+2ET1g1Vc2v?=
 =?us-ascii?Q?1RM7U/aNUChgtnHw3xfRxmfrCgFl+FirNuIt5p60WtQkkjGZFS65vqABV8bm?=
 =?us-ascii?Q?fhSM7+Gay2ut5+rpV5BYMaD8JmDVwIHNHXm/MXQvgwSwucoSRzOWgksS7Ijr?=
 =?us-ascii?Q?ykKuGRXXemeDIwgq0vq47MfvNHKdt1uHb/auANEsKxM3S3siwHnzSxg5JZnq?=
 =?us-ascii?Q?LP+xXBYmXRy7j2g77X+jM1zRrejyZ9YpXyS5H6hU2jTRD/G6/J6+HdmKMwhF?=
 =?us-ascii?Q?rRMvL6s4tXTY8C7Z8Blp1+EMadAwBjEFERKvHiKEHXFk6IT8tyiJmyACDaQP?=
 =?us-ascii?Q?ei4cl57UB3nUZgnnHhDT5mXJItDhmGYoQY/3593w3mitSm2/WSRI4mvqUX2I?=
 =?us-ascii?Q?wMy9gl9SiejExGPyCHHGC4hY2dZBPtkgNMad2p1TiPmRQS+xB7b76JMmnBMs?=
 =?us-ascii?Q?wkx2vNUFAkqZ+1HH15O1hCX5RjJZyubNTfFKKkc/ffCsH/bJquUhzI9cGdYs?=
 =?us-ascii?Q?cN8nPWnBt0StwLb3z8v+IEY4udwTnh/vYrpdy4KGfTvhFSDWPFR77+Omxr5H?=
 =?us-ascii?Q?raitRUB48Ibu0ItacEzRd3sLmPPxE7tWEaER+pfMrAqWykFMIgTn1WKpBSek?=
 =?us-ascii?Q?cmwpMC7ozsEcJaPhyU6sz4vGwfD/nLtxZsn1zQ0UIjBTkcxB8mKSGk9oU30d?=
 =?us-ascii?Q?uStWJfhIWtVVgXhKPFPlMFWLF1uexvBo4YeZRuKNnFuRAt+CgYbTMkeAoC69?=
 =?us-ascii?Q?zCby896t9qPVKfOGYfZEeFS+O2e8uJVBoPb3H/P6jPxamjzxzZun4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR09MB5486.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PYk1ElUX/2+e6aPjVA9ZRUksHYx2DosXPzfinC/dsx+AR6gd7xQU5IAkKGVp?=
 =?us-ascii?Q?xkLi4pjNXlpR0MCXHwFA7vv6aOeiUgX7OT6hlkq7rxP4Zocx5vnlggoPZ6mY?=
 =?us-ascii?Q?OJaq8hTbjQbm+0Hs9DR1uV9ODpKHRA8td3Tq+gBuSUG9Ig5udOaZOaD88+2o?=
 =?us-ascii?Q?jagCwxeT+N5PrvbT7E21a8L5AZJQa89DYAm7eXHrOJcxtJ7yfo/ESA1LwLSg?=
 =?us-ascii?Q?UtbjVB8GbuWauja6IRExs+W/j93YEUCgUp0OgH4/U+Irc8iS7jY6omkT+NmI?=
 =?us-ascii?Q?MqnOdujSDV+EsZXmnEd8LEWUIBp7dbp9aAv6oAr1DnICqJdpVjhfNDhEDXLm?=
 =?us-ascii?Q?Y9rNdWnoHrUckMyPeBeL3pup/26yGP510l96op/d2z+BFgTG7I8YcPwpWnwB?=
 =?us-ascii?Q?D5klYR/kk04YBP6lMUGiXD0xz8TEprdkud2dYapV50GEFIjvoAdTB3qnTrtA?=
 =?us-ascii?Q?9sWxMWPrLxwfPcIFnmIuwpMltTC1tIfAIJ3/Tlh48kwUmDzN36Oj6V8lMepd?=
 =?us-ascii?Q?F/1CEVln5HfB2gbm7au3k2p4yQpvMhlczwTV/e2tNhGGqet2XTMlLkVVpApD?=
 =?us-ascii?Q?5YOtv7FoJQI2n2ZnRxBhMzy1itXuytYL1JNETbEXVYFtUUJ6YBhdRHaV7OtB?=
 =?us-ascii?Q?SQo9fpTARk2XnOJinnDRM1Jt98ezICRnICZKUYNKckTiF9bqT8yYTwfVRyM/?=
 =?us-ascii?Q?96R3nXz8ns6F+FxFzjuzwrHhweH4WfGlUz6RTpqWW7T7bhkDiPhGbB2LOeOn?=
 =?us-ascii?Q?fXB/uy3OCzbpTf76Pw+f9YMSwJmek1/k0e6CwuC1pmtbcGzfQK9xXicuNmPk?=
 =?us-ascii?Q?SlmVHh3MmKSApeMoAoEz4eMZmA7D415gsrbHbMpGlcyuIAma+UFXiTmA0bnT?=
 =?us-ascii?Q?lzKiw0wBxMRppmhghWEmoemHIdG/q7cvQkIVLzm70ZzIysYvAZdWIy7ntHne?=
 =?us-ascii?Q?esA4SCPaEpfrDSJzv2vKyNKZmSI9GoQJdyPZ3pX3KP0HEUG9naqkWXq1W3cg?=
 =?us-ascii?Q?uMt+uVySA1q/izlYKE77D7Vk5zPO0EEIUyif6SCirX7IXMY8U1+uQS5WEsTE?=
 =?us-ascii?Q?QGSxmxZsLhfbiHzdda7GQQDr0cELKnirD6GIw2eh3PmrmHY7elzyd0CK+E8F?=
 =?us-ascii?Q?dIM/h3CrhS4+lOIXBTmqU0DSTRoOdH9slZxLUu2oTCZK+mKqa2P1PFv1P6dR?=
 =?us-ascii?Q?d/jTzcIP+FJydVn+Axud2s4jOXvP81kHdks/GIfnLrq8EVUvWVjS4tyFkTF4?=
 =?us-ascii?Q?zMN0pZWgpcYjVKI6d/q8h6kzyXEvpklFY3xfT2U0tiyiEzX+hKkWErXBewUy?=
 =?us-ascii?Q?Vx4r6nBnvMnecFerFJiFevYyFB7fveT/3ppTKVII7FNAb6N6FWOUghyLA56l?=
 =?us-ascii?Q?c886NmjWWQfBH2wJWA+aEVKnCHoKS0YfA0+zXnkn5zkHFBMsi2k88kXu//Qw?=
 =?us-ascii?Q?GD9BA63DYxtpcneIE16R3mXvW7Jh0V8PIThen+vJjVDd664F+JjELF2JIOtc?=
 =?us-ascii?Q?WBFUfK5rAwwlF4hnshPGGhBWr9VQeVfwZsLBLaSztpE99alrK215YfoOmb0Q?=
 =?us-ascii?Q?Ikz0QHtnQ7ommAkDI1n5Dsqls881sUl6tSracwEsd4Tzzkqzy2OKX+5U9/YC?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: cgstowernetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4e970d-9db1-463e-83a1-08dd8ca24aeb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR09MB5486.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 13:31:22.9675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fc9e9498-07e8-4b82-b4cf-365bba23cbbf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCy1w0ouc2cNQKQL4DzxgjVyxGoszj+hn2nkoJNN1PENFRIOkeXRrDGceKidr+2G/jVhqnqJFH3WnNLPPL59MTIl9PtOVmai9zX+NIADvmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5965
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

In case no transceiver exist when trying to get the transceiver's info
There should not be an error message from the library.
The caller may print an appropriate error message using the relevant rte_errno if required.

Bugzilla ID: 1690

Signed-off-by: yogev <yogev@cgstowernetworks.com>
---
 drivers/net/mlx5/linux/mlx5_ethdev_os.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index e192f698d8..ba5fd2d253 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -1253,8 +1253,10 @@ mlx5_get_module_info(struct rte_eth_dev *dev,
 	}
 	ret = mlx5_ifreq(dev, SIOCETHTOOL, &ifr);
 	if (ret) {
-		DRV_LOG(WARNING, "port %u ioctl(SIOCETHTOOL) failed: %s",
-			dev->data->port_id, strerror(rte_errno));
+		if (rte_errno != EIO) {
+			DRV_LOG(WARNING, "port %u ioctl(SIOCETHTOOL) failed: %s",
+				dev->data->port_id, strerror(rte_errno));
+		}
 		return ret;
 	}
 	modinfo->type = info.type;
-- 
2.34.1

