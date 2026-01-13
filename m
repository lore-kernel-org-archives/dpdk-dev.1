Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18002D29DC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 02:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7E34402E6;
	Tue, 13 Jan 2026 03:58:53 +0100 (CET)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023085.outbound.protection.outlook.com [52.101.127.85])
 by mails.dpdk.org (Postfix) with ESMTP id 9199A402E0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 03:58:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnNv8fQphznVWQOnO/3r7XJfE/7HbqKf2vdzjrSsnreDZq5riUW7L8WHT4h1QWSId5it4NDuXhym+91l/4Qbd25aUIScJI4iE/2cBYhTb/WYjwrv8LeabkRxec57Osmy7iXeICsYCOwb/o/iJ8i14mnuzb6f3lAHDm4w8qklzXCwfzet6A7BSoPH42RvwkLeSTPdk3hszTyq4DFZjvO0VRQKbGsv4Z6IM+EqWZPBPOWtXmK9Czgvc1/CDytTpxVCOSbJKLdf/gnbvfDAz/dPkmn++HSwisGtTrrz7dMszW/vqrkGFxkoW6afkoCAa87FFOSjvhr72sOpc99MTPJOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/XBb0mWI4J+16WL8FekiI8tIWTbpQpeRDrzPIBMbyw=;
 b=L5eOVv733RM+WqkfQyM/T2mZJQOcCX9KTIJTSa2+5e2aysUhhb37256a/fEF5jKBh8JrNi4/AG0Rj09h+b22QnF7p+6OJIif3jJlaFaVPJejnKBFZs3QQbuHb7KEBwWEmb6kNH/GsABly6jO4s7RWjFSXnelSMzBi/xD90+K5ArZplZBDhN7U1bfAkwomWxFg76DC3heOyoVVHpnpLAzGvgzryOVaVzAakUCzh6sSCA6gqyWQYEuqR0mgUST6e+95Jtinobo4YvSVrNjM3/1ErZS+A21+yzID2AM7LYSC8qPOItwr71VkA/BQ5B+BkssJs2scmexGOJMa+D5pWYNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/XBb0mWI4J+16WL8FekiI8tIWTbpQpeRDrzPIBMbyw=;
 b=XNkjuHtbTKYiE/SUtNwnkeRYAeNr41lefa54MLsuTAI/EeWw3wr6D4zNAIPsaNd9ofghdwRmh+6izusS/t2Wp2qHJiUsM9nCj/ZBPrghfRbAFV5SfVzdPlYuV8jrLxuWgcNVWGRN0H7W7JVsUb1xkI+DaJaRU1dYtNUwWXLlHUutgFGUi7mUPfaHDqCB9NKOZxvkLQcsF1ybZ8MQXK8QgPO9SRppiHy97YTwoeHq5BnWDlbTYnEj5fSETgaLMzXKqtp/WiR2fjUySKa+SkJH8x/WAnd1X43xUhW/9/rb3FisEOThKm/SK8yGQa6pqQgYvs0uAssAYIJtlBfuAqgaEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by KUZPR06MB8060.apcprd06.prod.outlook.com
 (2603:1096:d10:44::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 02:58:48 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 02:58:48 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org
Subject: [PATCH] doc: flow-perf: document the --query-rate option
Date: Tue, 13 Jan 2026 10:57:38 +0800
Message-Id: <20260113025738.33944-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|KUZPR06MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 478a1433-7ccd-41c0-1943-08de524fac42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VSAezC22BbIOvnon+7ZCtHLWzN6nIBpHmHNpA0+LYfCvgV3D3I5vjtnfISqQ?=
 =?us-ascii?Q?6G3VhsZTYYwY0pIxCZiVSMk0OOhiDlAr6+l8aTNbWgdpP17VNz7WX4EtZMsX?=
 =?us-ascii?Q?6ppxIAzNk7mIKYkZpD2SdFPkZn1QXCssG3zABZ5lPE78HyXcMpA/MeKcgVgf?=
 =?us-ascii?Q?uuCdpMRsZPLrV9Hgz9nJQaNmcuQIgGYO5rg7Su2CXqfNCUgs1+m90cECN0CQ?=
 =?us-ascii?Q?pN91Sshq5b5GY8DEKwf9uw9PFzNX34qKg4grOkJ9YeyCb0v5q3o4u7EeDRHf?=
 =?us-ascii?Q?9pt97pP6k+ZBySz4WdrVum6UW8clvO+F+h1IXkQ+oe9hnqw+hCIfOqCzmhAa?=
 =?us-ascii?Q?UKuqFbNaHFKd+NvnHSouJLY5JrJaUrQhq1CSfl3CLV4N9mbQP1Gimi9DmQWF?=
 =?us-ascii?Q?aiZXSfMQy2m+lBRWcRn/dCE0C1M+6+gVa0mNbVI30Kd7mZZQdVzK8M1pSIeT?=
 =?us-ascii?Q?2PVW3MO8ekcW3xCAj9WLwRagQkqmI4k4UpvZOCncykWLcZKxC9+h2r0SYq5E?=
 =?us-ascii?Q?iPemzQhYbTRMeo9y/Ee+OqO/vj6gQn3eOiad2cfZvz9gSbMR83tqfTjgt98y?=
 =?us-ascii?Q?KkCOFm/qFTw9g3xck7r/8Dl3rAig0t02p2KUfyPAZpFvIAu/OrH77EKM9mbF?=
 =?us-ascii?Q?MvQBro7cAG3D7sHJC8Gf+QaJlxak6O7hCNY4nnsyPL9Q0aWbEPts9UxXvec5?=
 =?us-ascii?Q?adj0SSumaZIoCUlkcwrRK20Vf4w+3Ue2DZZmvOjCDuqlG7sSm/f0nIabczO+?=
 =?us-ascii?Q?b6h1Ctwlqrsz2Ov7CzkY2pGAZm7ZE2AJP9Na9Cmgk/vjs+2TaUp69NCY4QS6?=
 =?us-ascii?Q?JTxIpItK4HlZvIRqHgOP6Agtg7kqLI+l7UCiAD/yX7LlIwkFsRorXDW7NWXE?=
 =?us-ascii?Q?grn6HUXv+O+YkzjqiWPIxCBuPUo/LYOK2MlF/c69Hh6ESCHta6Y+5oxc9wfe?=
 =?us-ascii?Q?cvZbOJORoXaiUncLHI+YJYwErBlE0x/Pz/KroakFhKrqpFq+gzqslfdVniKp?=
 =?us-ascii?Q?Qf9/B/uZESWmwP1ef2HV7q+5gK27xxm+MaOsCAB57u5uQ5uS0xvDb7FNBnZH?=
 =?us-ascii?Q?bVygD8anxXEyipLe+GdD9DKqA4v4YsuYXws5a7SZBewXrwD7h4kp+/qNSzU4?=
 =?us-ascii?Q?5S2Ref2fPrVw1/FGIKgumK9DgEC3aF54YOw6bh8pA3ADFOPdsiC0arR9S8dp?=
 =?us-ascii?Q?SSJubIItvFHKBLykWCk9wVUdZX7m3qGQ0BfOFMRCOFniyLtLBfBWRJ7elvie?=
 =?us-ascii?Q?ghfCvEwc0WUx0S3B5ulFjwaMVYxQNZRUzcTXurtMvPyeE4PX5pIf2FFnFxP6?=
 =?us-ascii?Q?WOuU5qUL3qUoKQa4L1DC2rUO+tZ2OPeYxo4/79JRhTHiRi9nohZo74iMm2CV?=
 =?us-ascii?Q?aNbtu+3y09i2msdNfvpWQkug/92HKglSjhv0q/UCiNnZSJ8li9yLob3+X4My?=
 =?us-ascii?Q?3b23BnXVLOB0RvrHN3guOIuZEemJzrQrdR7XAbKuj2rumZQTpLkG0yL4B6ee?=
 =?us-ascii?Q?TcBU6NxHAZjjoW/5CJmHL0/rVeDbhBqZuNZt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgyhVMkw/mwYXjjZSFrSqZpnI/WBn1ybGLtxnqZsuzuxEs9zKI5QCk2XsCty?=
 =?us-ascii?Q?RULPFwsoE+Urnr8yh0qegb7zEA8MdYjmc66SXeidIL3hVRsCWZFOHf1lUeQF?=
 =?us-ascii?Q?AnoE8w2oflT/ZpdZGaNIYAoaInMMxFaOnmlC67YufroxrFoF2Y5Juga3+ny6?=
 =?us-ascii?Q?USOGildjwaQF1UWeIxudDpL6mSr9TvbjzJaAIXDe0JSXKv1KlqhvE0WMjuR0?=
 =?us-ascii?Q?9jVaILqdfbt/lZxQTIJlGKGdfruVZAeSJ75F9reXkWnikpvkI6YS0YxK0OKb?=
 =?us-ascii?Q?R6Fmc8UqJZAhq3hd17BxavsChVmPeVdTAz2Jz7IgaOUE06rusl7rkr+195Hi?=
 =?us-ascii?Q?Pn4BVh646BfcDea5sp1dayz0xw34pc29LV6LhAWplYduSjhdl5rsd+qe+NEM?=
 =?us-ascii?Q?wL68y7RoTbuDdeGqm/xcANCIXhIIvMFhtAHTcnke8E4272fKuumvsdLao1oJ?=
 =?us-ascii?Q?GM7a9y17B43ChaT0tsWiwAOCNLx0ltu25RL62p4pGA82eKmGOJCixPaNb1FN?=
 =?us-ascii?Q?iVZd/TMvp2yjYUxhfbWKoRk2YYoh8HTU6DoXLmKRESCX3N5Xc+Wcl4T35YtB?=
 =?us-ascii?Q?UCePOoLJ59GIwYiG7vkhxHVKknH4GCMWIb3lhHD+O+LLfgldEYVlyxsEKGF3?=
 =?us-ascii?Q?iEJApLFWvKNjR45Uyf40g4ivYY3OiWix7b+csyMcFDXDdfvGTRCDvucutJX7?=
 =?us-ascii?Q?UYBI1dhZfQHp+cpsqAbJ5xMYWCmMNf0vOX4Oi/f9nOLbu+NgOks+CZoI534T?=
 =?us-ascii?Q?Qf6dscMKVkj8gGdu0MFIHNVkA3yIfgwPsFTaWkkbzE5OfTO3Tj+YcRZcM5jL?=
 =?us-ascii?Q?qrVHCePauIYC6CnIg4UnWE6Rdw9TUgeGBu6TCv2CV0H39cvhxk+x37g/g5gx?=
 =?us-ascii?Q?yjctJGp3uxbTf7hCUDMjOKWH85KlYYQx7JLhFjwQ8TD2iequxpCQFWCAy6K1?=
 =?us-ascii?Q?I6s99Q+n79gG8P27gQitgFUtqB/ZyPUddsAFwKzhRw7L2mL3Ey7mZB37QGaG?=
 =?us-ascii?Q?0uM5kcLmjdDT0AGV63IITmfaujs4OMJWDNmSQCLzHmr+aTCKAUa4rfNXtNdK?=
 =?us-ascii?Q?oHAIUv17cpvqeeWTpMD+vylTqWzvtxaE3zs3ioq9Sde8QnGy5w5fwQ/cfzEi?=
 =?us-ascii?Q?mR2zNIww7nKv6dPt7hMo0sOUZT7qd77IEsVlk1l/rCv0b8ZDPDV9Cd6550us?=
 =?us-ascii?Q?/6z79CdLY8Ow13bFi5ocJd6MsqdpzNpIe7GDZBe+dNsMdOepn+CvAJBYfNSS?=
 =?us-ascii?Q?P837JYpkInxVP3KWl+iteT2MB5envNKCZ7DQGenYzpvLCV5mBIBamoN9WCiL?=
 =?us-ascii?Q?BpQcCsyJKHlpkKPAufQnD+4XF0iP5GtILdREepVMW3vFF+ASv/KTCZs8PgTA?=
 =?us-ascii?Q?DYQk/hty/7+AloLFgPqs5yR+5wOl71F0j8KPQBNofEBRAAxLqB9mhK6thV0F?=
 =?us-ascii?Q?ktnyGdJj6S8MzFNYLhsDFrAFmnBDTnWPBtXq6gqQ3TX07fGX+rT3I7koeJD8?=
 =?us-ascii?Q?fLZbbKAbp7/foPd1az0faPdYI9ho32ch0y4pv+HDmUt3kBpjaW7JFnUWRRqn?=
 =?us-ascii?Q?3jUhiLEvixPMCLZBVNw9uW8+FfdgIE0PRVjIQYJfCOkmlRnnc2jT0S9aGK+i?=
 =?us-ascii?Q?2sxLHTraklfHoDE6d84rGoR2QNb+L5moewZnk1EmMPlUm5BaVonmBJ1v5GJx?=
 =?us-ascii?Q?5kq1ZUGZzhZFjaOLe5uNVciP0rMusHPKp2XYhFs89yxkSUw16W6ND0r3zxgi?=
 =?us-ascii?Q?CmTY1PFdrJgDfG99NTs1h2UzI73s3AY=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478a1433-7ccd-41c0-1943-08de524fac42
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 02:58:48.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fkv5k22+dqyZiu2+6ZqKR5SH3RlK5XiShyOgC7vmCNhMtWtQL0QnyB9o9Qz2XeDzQ0i9f7WUmOZrcc4t4TxDi2TREW2MVN1yw6v9a9pKQT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8060
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

The flow-perf tool already supports the --query-rate option to enable
query rate calculations, but the option was missing from the
documentation.

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 doc/guides/tools/flow-perf.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/guides/tools/flow-perf.rst b/doc/guides/tools/flow-perf.rst
index c0c7ffe577..a289ba482b 100644
--- a/doc/guides/tools/flow-perf.rst
+++ b/doc/guides/tools/flow-perf.rst
@@ -87,6 +87,9 @@ The command line options are:
 *	``--deletion-rate``
 	Enable deletion rate calculations.
 
+*	``--query-rate``
+	Enable query rate calculations.
+
 *	``--dump-socket-mem``
 	Dump the memory stats for each socket before the insertion and after.
 
-- 
2.19.0.rc0.windows.1

