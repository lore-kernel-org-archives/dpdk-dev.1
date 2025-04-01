Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D433C36008
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 07:49:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D1644067E;
	Tue,  1 Apr 2025 09:49:11 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2097.outbound.protection.outlook.com [40.107.236.97])
 by mails.dpdk.org (Postfix) with ESMTP id 4CFBF402EE;
 Tue,  1 Apr 2025 09:49:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxqPxMgQYfaMtViU22YPkzSIv/uEu/92aX1nN1T1JXhJAzVFCQ1Y/9fLV5ryTYgQ0qBzxlRVh0B7IoENBULBeUoaUPo9ikEtX10YthZJV2bPw1g9FF29aAw0/XAckLYugIObNJagSnJ29HOuINRZB3Ui9enFgVfXfr7tLmyT2dek8IN+6jYYvY8pzeOFcTmZ2yNBJ9yK7lDe3kKSg2Kcr2U7g/rWNMqv8tKvU8imt+sKf6zEh0/xS9BXjPnuRbQRt60942sYlI/LcfnJH9USo22aeSEOMyJnkG2h29H4X/iC+0ifm/mK3lfUzM74aJyzxDQmF08Xe7N2OTPJKFioNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbBzdT5/glm+WeF7JAcaW4t0QViRhSKHJKx+J1hE9Mk=;
 b=ORmNju86xenRaXMYtaItz2i35hQa+UmMmJnl3P6y8LpSCEoYwpAjmf3SPEYtCuWxdtb9yvJg407I2Xn7aDRJ+rjJrrvX5aRmoBnfzDCkJLh8/+cTlvVUnxnOV/IFmdzFMbdP8dndlxDgjFfBA5gphnbDzeFgZVvwoAfX3WuY8/DAS7WfoU/+XqTdcJpD6fHg/iA868HdY7gImTSkAUO0pQrDRNqnToJLJ2o8c20emM/gIDzTKeLWE4gVWWoULUJrzLiqVQIbaf5q8zt22gXH4V2a56nmbz89s0Hf1zrsclJHMC4XjfS4LyQGHM2N0WQH//ZJQ3f+qjfD2z/NP2q69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbBzdT5/glm+WeF7JAcaW4t0QViRhSKHJKx+J1hE9Mk=;
 b=FgwCOMH2rpFiNytYCtO0Tnsco4MptwiUtM6fB/plxzpQGz5b0bTZFShBIYXEP5laTFLb4westiwnxpmz2Vozk73s/RiGv7q8/B3cuqQVQlqr54vwJt0QA1ipS+BKH6TPt6wAxl4sfSXSl7PVhP0axRfxIw1v0qUTSDY+mlfqIiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SA0PR13MB3950.namprd13.prod.outlook.com (2603:10b6:806:9c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Tue, 1 Apr
 2025 07:49:06 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8583.030; Tue, 1 Apr 2025
 07:49:06 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Chaoyong He <chaoyong.he@corigine.com>,
 nelio.laranjeiro@6wind.com, stable@dpdk.org,
 Long Wu <long.wu@corigine.com>, Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH] app/testpmd: fix hash key update problem
Date: Tue,  1 Apr 2025 15:48:36 +0800
Message-ID: <20250401074836.4127018-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SA0PR13MB3950:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2e8c4b-1351-4b73-4d38-08dd70f1ad7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bmCuNpL/dcchEi/2ZBQjfvLV8Uw7SUPUFLDZGOU8zT7VQAMbPdVH9j/bydal?=
 =?us-ascii?Q?ekGPz7Kq9xg9xBsPt6N/1oF36NIKANTn6QSvn4quwbY+suJrcncC6o/ZNjS+?=
 =?us-ascii?Q?13fzCOIUxZW3OE7pMlqH3X/+PxeQCV+3N9am+3YgionjjRmYOKiSml/0nzt5?=
 =?us-ascii?Q?GHqRONrR6/ogNlPiYOnq03ELW5fmJuhb0RSHJSz/N3oyAzzJbBdVbUYdHBYA?=
 =?us-ascii?Q?j3hgynjNck7DdTxH/42QlEH0uwL+7mdO2ydU7K/YPXTwenYaglVhn/Yvc79+?=
 =?us-ascii?Q?rXT+YNfuEgovRmYhTP2yH6Mo7sGQxV39ccHZQhn72z0Cl3Rz/voJuDGi8kZL?=
 =?us-ascii?Q?oyHI/NCeQj/d8IHW4PJo9G4yuRRj5E1OETyW1dDyOoxP9I2y3owIyn3DlUKP?=
 =?us-ascii?Q?03oS2c77C9qI14cybopWMrG4V8XXPsdIjYUuph87R+Qm2TAscljj4+bTguum?=
 =?us-ascii?Q?zKLcWA88MYKMR9mwSkG+odr09v5459j7KazbKQIYjoXxuX22hEXQnUvg8obl?=
 =?us-ascii?Q?eySHidfAmN3iYlLGImT5MW0EvjP9cM4l/IwQZrIHuM4n94zHAYZWb3ClOA0N?=
 =?us-ascii?Q?lZnKUAkWIWFcXtjPHqL6ejWUtTw0LCFFYL82u+DlBn79H+45MjmEzDQCjWj+?=
 =?us-ascii?Q?HJWDMDowDAWOpEDOWANGDyQFxYaHhmsOPk9SUeVTx9IZyasz3kdVpgrYLuD2?=
 =?us-ascii?Q?MdkSA1QbNO9hw8aIK3Ypp/2HUB5lZ7RBLLr8cpm+zCmbMywKupTTHg4bpl3R?=
 =?us-ascii?Q?WMR9jSR9+AK2xoZaZ6dKXK+dHMsxXpb2h1CZ4oUGLZYkc+s1bgJhx2XQDhut?=
 =?us-ascii?Q?Aj/W5FKGBgnlbhr6w8fq0tjTQVFStrsGobAh4mG4DRzr5ewS2TnJSOGx6FuL?=
 =?us-ascii?Q?5Y4B1FgI9gPGvFiLjh6ml9So8vLKiUS8dHMZXrPZBU/n6OswC6yKqctkK/X9?=
 =?us-ascii?Q?3dJjHdDkI0WyZRPPTOiRJarHFj+LCw6hy1VUrYzu6DrndeycCL8n2xuGD/uM?=
 =?us-ascii?Q?nxdGwTtTtCp2YU6DKnGTj6h4lVI8wR3SfmZDjwNI2A7nfFY2zz4VKkEfjUqK?=
 =?us-ascii?Q?WqtBeS5ZXvpyrZmuv+ZpsEbj5WOZvOG0b93DwD/4ao8V3oroATrIG2+Ju7rC?=
 =?us-ascii?Q?QWAMqQ0yFOeaJ6ViGTgwMcvrAhDOiFaNwf0XhyQNv1zqgtcZ46ChllQskplZ?=
 =?us-ascii?Q?Nde16iC3ctFswwiLHSqZlzECXDdab9kxg2U7k4uCVxdFH0ZYuR01Zcpzv//C?=
 =?us-ascii?Q?jklw3+G8QpNa/7MPgT5K7fYjYionWuga6zWn5eEhd9ddDZYnXw19sSM82ZzA?=
 =?us-ascii?Q?aJ6EgrdYUXOxXAOMMAiYacjfSbSnlk2HMwEPj1vgzE6U3CCy1MrcKm6svoNr?=
 =?us-ascii?Q?gB2NY/zyqMisqgeFuXXQzuszgFUrBb+mfPp/P6VKOVj9G7kz5FVXiVZAZWDE?=
 =?us-ascii?Q?S8K/BOxt2qMmd872OlCuaMDEyexYAE2h6Q/v3umcNu5t+3i54D7Lnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SHvPGgkHz8mkD40/0YWaQZGCZuGRP4agsfNfYyUZrtBs3tVCXM5d8L7u5gYs?=
 =?us-ascii?Q?/lBdL4Ylndm94UjNeuTyGsVDeT0qyNkzz82+9rNZLWprPnWDpbqH5qwUjYp7?=
 =?us-ascii?Q?DEyYYuAUQOK3jTyho9RWXd3ssYr3liikquVbHJPKUjP4QRltKd0WMNXb1Rz+?=
 =?us-ascii?Q?2SqVRao0o3XKhKlXzQpFlKbiypyhopivgax0UWPgiXHzJM9Qs6vkEiqk1dco?=
 =?us-ascii?Q?ZLio/gF+YUSxCDuMTXnAw7sqkPYXWphgJZwSuvDHFZ8LBQ/OWM6iIjc7Ofoe?=
 =?us-ascii?Q?dI11tGs9uBXS6mGT+VbARATveDs/E/n4EHKaw7F+eJOsMNgRZY4aTOc9Pr8A?=
 =?us-ascii?Q?RazGfojzPolv+IbE+QYK755N+Q2IBOwxHE2GemBN7lrVQW137YTrfQ6hRWNq?=
 =?us-ascii?Q?TtiIylagsGtutmqztCLrZSpxZanjgfAJucvBVe3Th4pF589KNXXXF/pIJBGN?=
 =?us-ascii?Q?4vWEqe5XCT7fEUwn6jHMNpy9HvvO1TWSBWenvLYABfdhzEOFI7N9vZLwD1Fv?=
 =?us-ascii?Q?r4JoULxfOxt2IjxaMvHRsdJVNLeAHBFLvwtacWl9rPdE7gTrsQonR+3FdfpU?=
 =?us-ascii?Q?W7LhXDGPoGhZTtHD5eYfd2OGJMWL5OhhGnpsX1zABic/Ci56SO0eypoAKqbr?=
 =?us-ascii?Q?0eq3XdHDqCA7Zvk6Trl60JpJD8LSuskfBaFTIPZOlmM6PKGA86coiIrMBTFl?=
 =?us-ascii?Q?65GiDcru7FELlFvbMMl49jFKucWEr2UasT3bK4n7E/xtGgDWNBAnvWmEAZSW?=
 =?us-ascii?Q?JrJRwCj5G0LePTpiwGU4Qwk0/miGrPWIuh6vxhjMuouGl/xH0kZSvLTxlgej?=
 =?us-ascii?Q?JZfXpkm75NvJCMauftnzxf/9H/RaujqvgGFO5L/KpskSCLLMqI3t9yQppfNk?=
 =?us-ascii?Q?SU3zkzfuU9Li2xKFzGnQw7aLj4dv3whcQ3XwJv3yQwu+6PaYaphYUvF6jses?=
 =?us-ascii?Q?tlOwjuwD09D9Ul8Oskvxz7xP7EuBc2dES+m81F2NDip/qCXzR3EdJzXWAWhU?=
 =?us-ascii?Q?hbgLL81FpridhlkmQvJGbwygwk92MPwesgdRMMfpg7eVuoLFRbHUTwGs+1TW?=
 =?us-ascii?Q?P95GkuyXa1ny15FRydE9e7EZoyh4Pj/T5Opaz0g9g18QfIRyluJFzSA7StCo?=
 =?us-ascii?Q?6en+SOVYI3w8jsJv09Iv/o2J+pOigr1W/1s/j+D9lNY/jqIyMkyv3TMCySYu?=
 =?us-ascii?Q?7U9/iTNgfQ/Wixrg/XE+kFr9e82zb2gpWYb63ng8CMJILpqe2RWD3yx5AhgQ?=
 =?us-ascii?Q?ofeWPOKFFsZQEv9CELkoqnWTlehJLyMaB/lcRW+NsGxbUi2tu7wEXcgFp5sy?=
 =?us-ascii?Q?D/0Y2C4MOWAz9dilOxjEMdmCZ9Br9cJqedoVAJcbuTqDZJJHBQYoBmdhs+Hc?=
 =?us-ascii?Q?RDc7/Z4fCfTi1H7ZsWfpG2mPlVK89xz4WCiy9CX4+u8n6RwZL2N2ZemluM82?=
 =?us-ascii?Q?9/VD/YXahyFLVvjA1IqH31BDu7vn1W0YN0M+dr/2Gr5AmFKSaQtd8C4rnosH?=
 =?us-ascii?Q?mYlWrYoaqOLE5L03U443fMe2WL+9OlEx+8VIpuYPR59cjKWoDKd2LWsL/0xb?=
 =?us-ascii?Q?247Wb6VlX9ZCxPPlepLoNa7XzEhELyNLe1yMnwbE/VMxFhICw24hJbCoc7lM?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2e8c4b-1351-4b73-4d38-08dd70f1ad7a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 07:49:05.9246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJmaCpvY3mAYHQDjYrovpD+/xPT3smre98aft0hITVmZuWDuTIi6DCkvgDV+P1tqEz6W8+3V6jbqjQzuz3qtpwlgKUZ4w8ngSk1F/HJLi9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3950
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

There has logic problem in 'port_rss_hash_key_update()', the user input
will be overwritten by the call to 'rte_eth_dev_rss_hash_conf_get()',
so the RSS functions will not get update as expected.

------
testpmd> show port 0 rss-hash key
RSS functions:
  ipv4 ipv6
RSS key:
6D5A56DA255B0EC24167253D43A38FB0D0CA2BCBAE7B30B477CB2DA38030F20C6A42B7
3BBEAC01FA
testpmd> port config 0 rss-hash-key ipv6-tcp 6D5A56DA255B0EC24167253D
43A38FB0D0CA2BCBAE7B30B477CB2DA38030F20C6A42B73BBEAC01FA
testpmd> show port 0 rss-hash key
RSS functions:
  ipv4 ipv6
RSS key:
6D5A56DA255B0EC24167253D43A38FB0D0CA2BCBAE7B30B477CB2DA38030F20C6A42B7
3BBEAC01FA
testpmd>
------

Fixes: 8205e241b2b0 ("app/testpmd: add missing type to RSS hash commands")
Cc: nelio.laranjeiro@6wind.com
Cc: stable@dpdk.org

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
Reviewed-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
---
 app/test-pmd/config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index e89af21cec..c32e011fa6 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -4806,11 +4806,12 @@ port_rss_hash_key_update(portid_t port_id, char rss_type[], uint8_t *hash_key,
 
 	rss_conf.rss_key = NULL;
 	rss_conf.rss_key_len = 0;
-	rss_conf.rss_hf = str_to_rsstypes(rss_type);
+	rss_conf.rss_hf = 0;
 	diag = rte_eth_dev_rss_hash_conf_get(port_id, &rss_conf);
 	if (diag == 0) {
 		rss_conf.rss_key = hash_key;
 		rss_conf.rss_key_len = hash_key_len;
+		rss_conf.rss_hf = str_to_rsstypes(rss_type);
 		diag = rte_eth_dev_rss_hash_update(port_id, &rss_conf);
 	}
 	if (diag == 0)
-- 
2.43.5

