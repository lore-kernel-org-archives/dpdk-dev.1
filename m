Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CD6CCD184
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:49:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A81340E01;
	Fri, 17 Oct 2025 06:49:05 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
 by mails.dpdk.org (Postfix) with ESMTP id 1253C40DD7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:49:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjGfZKcghq5yICXCRkizQFJlN/kd5eOjfsWIih1SjESgmuFEg84I8/evoiZCW7/pRPwCKOQ8rmj0sG8+fxfWW1JJrHUhraxhjeA7ZYvm97yrdwsjq2VQTrqNZV+SThwYJTSj/fuFWN8A83w4qP2fdoHJ0gNcQOoO0qRCC5rnydLGqRq/Ji8Xo+4oiYiIq8d8heJVKPgCvGfdkcOgjcds8f113PzjXOc7CMVua1gIzsd1hCXwV6St7neZ6CxO74XDDaIlq3aI5nO4bu2FUnZ6saohKZemm707wp1JQbU0OgsubGGp3Bt4yXWYmf/weCW/8qe3QSVxOPNvuNTfeaI7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwUOWugCyI27Hi677p1Xu5qM8Fj54OfNOWwzZhjOIYc=;
 b=wUhasVpOJrepgbpIbfuW8/Gco9g201b3ERHghUhTOleKxghFntZMQ2LdWjYN0zEbzMmHXgJmTxc0c+WdjNmMjZwEUlf8AUMmwXUUkKGtHMHdCznN2VGs38tcltrYj3sTu2IC9CCyOGq7WDsa2twTorMGvpwU9wGDO4RAE+wVJWyJAjVoEEki+P59URYtUSXmdd4eTcLZKwEe4Bom1rHPkW8bRsQhnRTC6wuKzJqfGb9+5RJP2qHH8nC2kkhbRXqZuJCEQVrGxiTbrmfkK1mHx7MvZ3FT1xc+zymtSn3Gw3Vk1uomKSG5mL4tSZhw+3XZ8KzJbz60qK6Vj/Okie+UYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwUOWugCyI27Hi677p1Xu5qM8Fj54OfNOWwzZhjOIYc=;
 b=VI5inMryWhw9YtQaDi/j4m4fFUwDnKkfVBC4dr7SGWt76z+8A9eYkKpfh8UQl1tPQ9OyznxcyJZZQJTkkLTSbrimwNpIQpyluwejdzg57bE8PsvSt5EfRw2lJZBH/ZWMCEqOrz6qV1nOvScyiB0RUfj4gG5Lwc3ds/mdZEzSe8H/wEVgWC5/x9jdqxUUk1QojRW1Z43rwxUMPS6tccKX0gGvd2gWpJMcX6ObbLChm1oYKQmSOiuS7tagWX9fzxCkNt1rjqC5Uo7H/PFIRxcNmxj6R44yukMmmePkxwVdntau9zIGRMZ5o2Qi37yqkHf8R8rg25wdLwt8G2P8XcGmZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 04:49:03 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:49:02 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v5 0/6] DPAA specific changes
Date: Fri, 17 Oct 2025 10:18:42 +0530
Message-Id: <20251017044848.3269627-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044256.3264737-1-g.singh@nxp.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 4376c2f8-7972-4bb1-b3d6-08de0d387e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NfPvvPwbGXjqD3zys0nvGDaNcyoMZ63lX3khVlCWKeKDZlT5ct4Dx7Jru191?=
 =?us-ascii?Q?Zg3An/rVN0hfSFPeN/Yp//GujJAoL7fIdHXG2bYi3tPq/yMsZYDattVPTISG?=
 =?us-ascii?Q?bsisAXAPtpbK4XSZajUVmwWCLniZseX4iIOvyVASq1hQPhNCa/zvNPzzgb5q?=
 =?us-ascii?Q?soJIkpmHhfhREjXEPn50f7xpVgMUzc3CAuFNJMAJ/9ccjgJ7D+roU54pJQsw?=
 =?us-ascii?Q?jyQc9frB5XXulcQugJRc2OEzw8agRjJ11rEXTeJKdo5Q9pupBiAvWeYyRbvK?=
 =?us-ascii?Q?bUfOWl1ZkSKIUzJ1JV7JGOg9XOq6pXYMZRYdW3bxmW2PNpUcBF5R1jetOtrB?=
 =?us-ascii?Q?/lu9ZhWELXpW5Dbq8W+QPbf6nR0Nx5fxuOZlGi7BhCqOOwx/si5nooxngBoE?=
 =?us-ascii?Q?r7hM4o1fFulUmLjEorttrVPW5/FXhNxErg9h2RBQuR8bLZskqMKk47F4DOfx?=
 =?us-ascii?Q?yYPb3fgdHz05oZ7DtDTmQCtRJgoIC8FyHoX55Pn/TQ1E9lCRH9kjqgHSqkJa?=
 =?us-ascii?Q?THLmHRXtMZxDPTWnQh1dfd8RAggy7bm4kqKyPh0gnZbjDlx7kkJkJoFEcdqJ?=
 =?us-ascii?Q?hBfNjvvDbIxOVB+NAVsYfyX205Nm+viX+cvj3JAtIXajOcqTuPfBTIBscQze?=
 =?us-ascii?Q?RLFpl6uTSFihkxIg337Oh2CJHxnylP0tjSYhtsdiXoRVPDRWfO+Krku6eVey?=
 =?us-ascii?Q?1QvG3UQCXuIfKfnrvfcDIAl6UK4ahiqyAIdIRC4BtIkpux9y7/NQYrb+q5Jw?=
 =?us-ascii?Q?fDeAiAC7JdYRsK80nZF27x322SjFM3v4EK6PvmQ4IRnvdoABOS0gLqJlNHTE?=
 =?us-ascii?Q?JTgEjdqZllHwvcz1pSxbF0RqjqXHX7v5NFSYpYg+a6m7nfzuVDYkaOCgB+Kv?=
 =?us-ascii?Q?qRN85JqngbDUbGR1DYR4uxpaEuL9FExp+5bTx7DsG/edkZHE+5UZ7DKgbq1H?=
 =?us-ascii?Q?A7z5bLGm1WzWbSUkkLNR+luNScWP7u26idPt2jMjUUtYOgWa6JSIX+NNSAnh?=
 =?us-ascii?Q?3R/JkY4kxtzCSvyFimAoY0hDjvMMNWrmcpwkN0c3OSTWHVC4VV7JYnH5Z7Lv?=
 =?us-ascii?Q?Kj/tEWfnKH7Z1iLRAPuArHrB/vNocpnKeT4tqrJJSjlqLlQjxnv8pwdUFunN?=
 =?us-ascii?Q?vb9QxRPx9H4tyuwWS3uG3XRBoNFZPS/S2KGlY1yyQtkgV5zN4buM5RkUwpUQ?=
 =?us-ascii?Q?V3KfoOEffDfbFw5ebCZ7WHJqsHkmPzQ4Gh/5MW49kQEWZjrzbLRnBNOSkEg/?=
 =?us-ascii?Q?txYDnSMABJNu4Gd87uV37f55CSidsn8aDv1L3kZ8MZhIVEknurCYXKP7my5o?=
 =?us-ascii?Q?IriPW1uttlcQNViZZp+rDcSBh5bIOPf0JiBdj45JqF5POc7nDdlMV7dB0i9W?=
 =?us-ascii?Q?Rs0tL0wi6fHnqumelHqzs11foVSpheanjuSXeK0WMkMsVQDzz7lL6PZhxFeO?=
 =?us-ascii?Q?xLIfc+8hGYhiuPsUyDEwZYcRWEDDwKcVyzX1e3d4KIT51ZkbmeImkwve5kuO?=
 =?us-ascii?Q?i2/K2vqpC7Qk+ovjOMsPOilrI7Zcpthw/UyZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iK8lMMsuka0biz3e6hdsHMDWEfIL8/e2qCSmUJNBI5f2PsojishAZAsY1IgJ?=
 =?us-ascii?Q?8YWTC2U77o8LXW6xmvT6BWwulnmggcKkhgN6Gzq9FVHioXc33L9fMpNDeI19?=
 =?us-ascii?Q?NTHRw/zun4TkR2Q8hjsQskGM7i/8KGxzpv+C7+ixJj42V+94E2kKxxJpxc0h?=
 =?us-ascii?Q?7XHK1G/Bslr2qs4B1kTFhi1yfDrMhMqzpgrKTEywl/P+fdyKSuX6JKdk2yjm?=
 =?us-ascii?Q?cleWYmnNcOh3AzFOrWtLlS07O1PnIvrG3gGIn/I1kywLNdy5lKYQyOm/YLyY?=
 =?us-ascii?Q?WQ3SSmzBRyNxqqY1n95IwIFjboVQS1664e887wvPrgnaB0Dl/2miS6vVA4IN?=
 =?us-ascii?Q?Woij4DMPGgy1P6TBpF1yYUoZkHOCdiYXbiR7uof/VDd5ALUcwaDvyaMG8fjT?=
 =?us-ascii?Q?Bb0zcxvMEjE9ktppabm2M8/nNIxQVN3GzZ48G9XWC693DH5FL1Pxcb9kOOLx?=
 =?us-ascii?Q?1zs8JDYWs4Pvah4hteIvdIlNKkrGLm0eRSQy8aQihz+FpL7KpFOx0amSahsO?=
 =?us-ascii?Q?6WMQ+txA6uW6KP7sC2RWJHj0b092nQXWU2ZedIMvU7j8NFCUd5hfjbFDXHE2?=
 =?us-ascii?Q?UEcOiu7wjYoaH3uj3lDoQV0/1CyB2o9IBCI75poZ9Q27dHcivCWG2xiJuE+a?=
 =?us-ascii?Q?1yqMdTNVeX9XNU7Lrx89ycs3VtsSC9KVYZfRxLoQuC+gUgnAJD0ymIKXm2VD?=
 =?us-ascii?Q?Gx6vJ7/hw1jGIpsdylQ3oUUu8qMsFNnk8TAXZRGsBBOTkAr8hVDy7HonZETA?=
 =?us-ascii?Q?Yrgx52q/alqJO9+3i+9mrFj6YzIxUYN521D8w1KCDlEtg27bCXiBkafF0Cv9?=
 =?us-ascii?Q?ijx/3K0CLOB6UoBBxMJm59uPdfdensNUwAlOapbsI7kJ7IkUtAutnsofHMmG?=
 =?us-ascii?Q?YktTJlweDRY51KvomkCctlwl0Zvu3cQDvU4SGu1RfM1vL0kueCLrdMddMCa/?=
 =?us-ascii?Q?uI7WKS/v5xIVkZMoH7ySM9UcJ7MHXHwCdFb2TwX9CrqHMNynTGLQdT/SxkMo?=
 =?us-ascii?Q?/zXlOw87kh1kgc6f1bJwA1guQ2Ac8By4xmC4c4L+uA455vxrlbuS/+3rMDS5?=
 =?us-ascii?Q?j7SxzFL8qzrGOD6/tOwEnF6oB1gh3F4QJVwEZRsf0W09txE7A0QAvkp4WwWs?=
 =?us-ascii?Q?zDJPYz1pq2YP2BxKwe7DUtc3XRazVFIHRewsaTxT0zeePmq8wIxa4TdTW1Nd?=
 =?us-ascii?Q?Y7luUy1iv+mIIwkUYT/9fN7DnluzjJI0OfTUmrTJ2Oee3ev56GtDPOxaV2hM?=
 =?us-ascii?Q?sMwpDUtucs7SQvPsCh7yv5KY++uaNuLhD/RIHu/znlZKSrNSQq1eOGMMJNFM?=
 =?us-ascii?Q?cr3i83Ok0e5TPk1Rmj5DTzky0+khKTScJM9z8cnSBolzfsldQZw7bfPWLqlN?=
 =?us-ascii?Q?bVVHs42knOibc2VqQlDFRo4H12aH57ku7NKlBOTEn5jaKO/Uj4+O7EfeZVcq?=
 =?us-ascii?Q?8YUBOK78htobu8SPwscvRyY7oUbwTSTGth+2g7SL3CPWfoHomEwccZwVCN4a?=
 =?us-ascii?Q?iQYUcHL35UTbNt/sgHFKkA5EEAWO30kl8pAQty2+RK9tp2psN5MC3ZjDaLar?=
 =?us-ascii?Q?VRNlnLkLg1a0rJNKRRU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4376c2f8-7972-4bb1-b3d6-08de0d387e92
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:49:02.8843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4B4VnX5d1gkitKpjksXCO/vPfbefmrqlxblsofA1Ei5xdOTcWMjUhEZE4lZPPlD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8254
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

This series support timesync APIs, improves
queue reset logic and include minor fixes.

v2 change log:
 - fix 32 bit compilation

v3 change log:
 - update commit message of coverity fix patch

v4 change log:
 - separated queue shutdown and logging patch into two.

v5 change log:
 - update commit message for FQ shutdown patch

Gagandeep Singh (2):
  bus/dpaa: fix and add FQ shutdown
  bus/dpaa: imrpove DPAA bus qman logging

Jun Yang (3):
  net/dpaa: Support IEEE1588 by timesync API
  bus/dpaa: Disable qman Invalid Enqueue State interrupt
  bus/dpaa: Set max push RXQ number

Vanshika Shukla (1):
  net/dpaa: fix resource leak coverity issue

 doc/guides/nics/dpaa.rst                  |   3 -
 drivers/bus/dpaa/base/qbman/qman.c        | 459 +++++++++++++---------
 drivers/bus/dpaa/base/qbman/qman_driver.c |  27 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |   6 +
 drivers/bus/dpaa/dpaa_bus.c               |  51 +++
 drivers/bus/dpaa/include/fsl_qman.h       |   6 +-
 drivers/common/dpaax/dpaax_ptp.h          |  95 +++++
 drivers/net/dpaa/dpaa_ethdev.c            |  69 +---
 drivers/net/dpaa/dpaa_ethdev.h            |  13 +-
 drivers/net/dpaa/dpaa_flow.c              |   6 +-
 drivers/net/dpaa/dpaa_ptp.c               |  50 ++-
 drivers/net/dpaa/dpaa_rxtx.c              |  93 ++---
 drivers/net/dpaa/dpaa_rxtx.h              |   2 +-
 13 files changed, 580 insertions(+), 300 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_ptp.h

-- 
2.25.1

