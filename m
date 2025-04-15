Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81A3C369B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 02:55:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FF26402A1;
	Tue, 15 Apr 2025 04:55:19 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2136.outbound.protection.outlook.com [40.107.101.136])
 by mails.dpdk.org (Postfix) with ESMTP id 4A81F40289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 04:55:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttCkToZcI7FlrDgSX3muZugHaaF7yjNCNAVJswmIToC1bx8ROYq9KUd8dAOaHcPEDNFi73YFWlSwl3Pl4/1w06ZKtas/6/O3S+IveNVr8djySDuNc4iV6RiJFHSiWq2+XEsd1cESyPGiuHpSXNwc/A6rFmq6iFdBKWZV+rXTsxXdUQ5PoSBQnaDsOVgSaClwvw5sRgum/SJuIbBNe920BCOcWFdWhg6n0BdNzr1E1kJ14DwfX/IV1/3xNf4ULtSDtVNrJ0HqGfg+Uf+GzuBbq54LuekUz/Fd/+sOVPJOOYN3aH3JF0+7De1PaFTzp1pbI5YTRdWgfnig31CyaJ0zrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34+6RCGnqApyPVh3mQ15vl+jyK4Rn7GU+6tPIlHvLfk=;
 b=PSDdse5aXMAiGaQ9RHCXum4jam9RG7AxLfsBfGso8JGkVfqttMN1MoQyCF9j+3wWm7sEI9tvLt2DLS0DiaWEii1KGyg+LZ/ACJzKDeZ0wkuw1VBQQ1r84tbMzBTNxHF1bDAZAxeP1UySD+UbTTPF9lFkwYwBJlpnAC0Au7mT7qZxY+B/7x0WynRXd8hpy3CMq2vFRniE5muMHlvcVjjbFH5ho6mlXHr7DZKR8ojckQk+J3mjfDXj+yP9b0FukmBsWd48FvtS9ioFOGtRwiXsPvMBIPosaxC61KFXf+rYCYaYzIsKcty0OEyI1/udQTlSSFRdTk9o/kcY4WDSWsaV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34+6RCGnqApyPVh3mQ15vl+jyK4Rn7GU+6tPIlHvLfk=;
 b=h+aeVX5lNdTdLPSX4NMnUd205ZH2Na3l6pmsfar0EFo8s0rw+0NaBhT01L4zCb5kJkGr60ZObZSJ/CauHEiJQ8DtipNLLiKWP/EOxAV7HuVzcKBEmgTFfai7gaD6dDt57Go9iSG0MLOIYcUKgNDY5b6JHSGXsELqgE81Ookt2Ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SA6PR13MB7010.namprd13.prod.outlook.com (2603:10b6:806:40a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 02:55:14 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%7]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 02:55:14 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 0/3] standard the data endian of descriptors
Date: Tue, 15 Apr 2025 10:54:50 +0800
Message-ID: <20250415025453.1348238-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SA6PR13MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7879cb1d-1f12-4280-119a-08dd7bc8f1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8xfkYK96W412cIeTjDNN/+cUfNNqcj2OXs+UBoaNm+QJSZprwBD+IMiE/oGB?=
 =?us-ascii?Q?lu1upnoOg+aoBXxeC0nORyaDV89T4nGOB9HaSjgbtfQstAdN8RFUvhiQWZ2+?=
 =?us-ascii?Q?Uh4/08eHq4IWdfoExH1SR4Ay2YMuk9D9q4Byp9X2cEY+xMknplJdp9+Eceu7?=
 =?us-ascii?Q?rgMbrF2yjtijm2fEQ6Pwqo32PrcfzZeMZy2ZmSZC+mx2IeUxNbmnEXCtR/XT?=
 =?us-ascii?Q?5G71XK6Soh1jNxK5yrroUEoBfIHFXRgL//j8zdIWWzLJ6c8sJmWyao/B+sU1?=
 =?us-ascii?Q?FbPo02GwinbXtAU1l21LcSwqsTQj0CieGnch9dQ8kYbxdu4+NSoCrGMEbm6J?=
 =?us-ascii?Q?+KJWgnhrXITM2M/UoJaTK07CwZp7k96aeUW+52EVsI2n5dOyIFgaf5lcEXqT?=
 =?us-ascii?Q?Y9i/XAJ52EBSGSzw4SVEQ6yCvpLpTCb4B0CZSJ9UrMAYyP/fTxf6ETMm2smN?=
 =?us-ascii?Q?G4pSwbefJ9cMSQc6eOzWHfNq8XEHlSb7YoIv8excV3t93Ywzf7NG6EFWNr5U?=
 =?us-ascii?Q?HbhzbEpAA6s656ythGoxYBFCBPxGmzIvMkbjcn3f1QS2R+k239uxyTyxcicS?=
 =?us-ascii?Q?YQ+FvS48gl5WuBUq8Abv21SkOEvKOXOJ9Te5ASu2rgd0aXteCjdqy+vbx60w?=
 =?us-ascii?Q?kzg8ewKlqmpLRyI1wSktDJNt1RR+4ayoicx+QjvQ+tNr2LjVH8cGO80epb6l?=
 =?us-ascii?Q?aBT2367OY4YTtGrX8QSOBIGVhDbExJQxnXiRpet3sPeqVloBhHGg/XR5gfMn?=
 =?us-ascii?Q?RXs/exeF8Zp19nkYY3suSWVwYgrIf6ZdbNAGToq4gI5ok4gQ9X2GFoPeVgHZ?=
 =?us-ascii?Q?7U6WvPdtTXWrA5XOPOh66sfkMYFbmX/zKtpuBl1aJGOFQeJsv8HKo4gfrPdL?=
 =?us-ascii?Q?0MHNG0hPJQeV8cTdbIYyfmRU+I5X3WYbcym5n31AIJ8Z+NbHBCKF/AqV1dNm?=
 =?us-ascii?Q?11pJ7Fcu4IGxutqGrc63zNRHqaq14F7Ow2n5zfeMlw8nfjItitbJRzAm0/Va?=
 =?us-ascii?Q?oX0Z1OZEF3/uD2SvT5cy72gbbNFTD+0SPsXHQpQ9xM4Z4mruNrQonxrgA0FT?=
 =?us-ascii?Q?UA6LPE7jDdawXzrW/pYfqeY/mKeJTchXIgQwnXJpURGAZecFb0IwzszhZeNs?=
 =?us-ascii?Q?UNTUqxhP36Jbx3EYEaXRAZVYGLA2KMG22YW+aAZsKMGO9ycsdYNWb/qEHNKj?=
 =?us-ascii?Q?yV1ZBWmMvBwANOOFntdBrjmTvGpUv/mlvxujsOP0IRpKpe9BjCNHRK1ltpK+?=
 =?us-ascii?Q?WFMYQN7fh+glBo3ac+NLPJaddj+W59N1dc6KNGHGtComyLas9VwT6+0Rd8vC?=
 =?us-ascii?Q?+A3uyZXGEzIfn56vHhrzXLmADW+WosxJxCmniXOYZh8c49iFfmbpKnKB4auG?=
 =?us-ascii?Q?UdoeSWZ+o1uCY7tX63JEoAICw6C454It0+QSqjNWoM2IOP68Ys+9j2kY2NdE?=
 =?us-ascii?Q?/PIZjq4TdU94yreDUcgnMa8hgTTMZYwWyZxjhwd2XWvXmOgdBtG6MA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ljwwsgzwgxe+UlhFoU65vybGUpyxOEyLSbTUED5DH/eleRxKFruMuJIom50?=
 =?us-ascii?Q?bEBMUGl3STZ66QwpdqMJ5FimjDb0oVLOgUZPq6ZkcB+IUjOf6+M8JemfvNX4?=
 =?us-ascii?Q?Lt9d5JSh5+74Cq+ed6Q5w6nRWgFA9WEhSTMgHXng65c0Imzzues79W/i/4pw?=
 =?us-ascii?Q?t9/u4pwFfQNx9lNul0owThtXWfN7Qy7h840tFaDKITHvfAItBKdR8G8BRhqn?=
 =?us-ascii?Q?rRxZrj85m8mK/EMfRFi0yVApoTBJkcRjK/IEJC90SC1LYLUMqVKFeRP8eTp8?=
 =?us-ascii?Q?3RTgtRHEdOFeOT0cU8cq2pcQW1aCPQgI/pq7y9vhnkC1qmOaSIFpbCVRL6xJ?=
 =?us-ascii?Q?oHJLWXZ0tf9aGs19NK1i2IqU/+3ZQYgpG6r4ksHKU2aQqPc/AijRQWptLcuR?=
 =?us-ascii?Q?IOnFdNQ/5YCAvZAN/8RXohfoOIQ3CEB9Se3E5YmRnErYn2d7zOcoJI5KO3S5?=
 =?us-ascii?Q?cwuacMR6vwf1U2bYjztEA8yBSJQNUks76HgVnuEe4ad8jOsxvBGl5/Nq4t0o?=
 =?us-ascii?Q?hTHV2bN5jfgHweao+Jo3yVO1k3hVYQSn+ixr57NYANIvMUeiNsWYqSIXKyjl?=
 =?us-ascii?Q?wDJp1W/2qSeTeiG++yYFy2hlWGsSIFRHaRpvrSTYanbGfuUXWJqfjCPl8Iqv?=
 =?us-ascii?Q?V3KEpRchV7IQ1nHLua54xVhwDhKWYjgxlCiAacmss7DE4xxGIr5JdvUjl4u4?=
 =?us-ascii?Q?d5lSO332ze8Jr8uD0ec/R+Pe0F5CSKbRvhqB5pOVABnXgkLAlESZu7bDjhBE?=
 =?us-ascii?Q?NnS+6sulLKlJVCztuQSG52zr6xFH/xbhv0Ri12G3w7boHJ5yvDRRiyCGufpC?=
 =?us-ascii?Q?jfp41WhaciOoD2Qi84ldq3oO6fOi9zBa5kvbmPnm73p7l+za4zN80uNycDSB?=
 =?us-ascii?Q?iJC+ocW86xDCdz6y1Z4F6vmwG0+Dkw0TVZ3VsAcWxc0sna/b2Djgnm5b4uO3?=
 =?us-ascii?Q?sGT3WZ8uFUB/wb+rIToqwjWE4KQTDKH+QjajHXXyEqcm4zDvGdoBWCRw3MPF?=
 =?us-ascii?Q?Ab5iBTdIfBhLzMZxA2kQuwmGEg+yx1VOuAtXqOIOaPQZWlEi44y2g7awgvLm?=
 =?us-ascii?Q?5q6jCP1lzqgpn8LC6JZ7rnLRaUBB6svJGHm8WasqkQHc+EGmTYMkXCUalfqh?=
 =?us-ascii?Q?B9Yuod8d8Zuz9DSdVGSR9NT9ztGYM2uNkoLHqXLXCBl8vajK1tdKolN1w5BO?=
 =?us-ascii?Q?VxyLnzyGe9K2elR9PThjgZSJGSj79vQrP9NPtgho3RntIQJjUQHHTX0h2FxN?=
 =?us-ascii?Q?xMgTWayeAUVpA+dj5YiFmbCfkZ4i68QUupR6fjb/ML4u9HaB6dj2PuKP7HTf?=
 =?us-ascii?Q?EST7j8sd9iDJtvHK1jBr7oRdOuex2sSUeJQs2ZjqTGawtVv9ltrl+clWgIM5?=
 =?us-ascii?Q?Jzti9+Rq0gvLXhp+dqgzz0aC/R31lrn98qmCYwTB1bJnLtAN35rKndeCZ/wA?=
 =?us-ascii?Q?kP6POzMUs6S0zWZnWsr+hVZxcAjjAVY8qoUG0DGjpROdfigMtfCNxsV8JgNa?=
 =?us-ascii?Q?YlW2bkIs0aJfO+KTUoSFATa3XrHv4LG5e8BZ4IoKSMBSox41egv+vTjRZdpv?=
 =?us-ascii?Q?hLhw39H9NWNQxgBeDGi+wMpG4ZvWKRz1/dLVWQW1SBTRxdlVFcyEPK8EwK3w?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7879cb1d-1f12-4280-119a-08dd7bc8f1c0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 02:55:13.9781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRLJ5ipbQ0FyWS5sHFWDdaensVarXWm8VKtFeMEnffd+kbroYyzKngithRQUxpV1Nqv2HWzy2PN/qczPGysJXM7i83V3fPKccddC2lZtUsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB7010
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

This patch series standard the data endian of Rx/Tx descriptors into
little endian to sync with the kernel driver.

Chaoyong He (3):
  net/nfp: standard the data endian of Rx descriptor
  net/nfp: standard the data endian of NFD3 Tx descritor
  net/nfp: standard the data endian of NFDk Tx descritor

 drivers/net/nfp/flower/nfp_flower_ctrl.c | 14 +++++----
 drivers/net/nfp/nfd3/nfp_nfd3.h          | 14 ++++-----
 drivers/net/nfp/nfd3/nfp_nfd3_dp.c       |  8 +++---
 drivers/net/nfp/nfdk/nfp_nfdk.h          | 14 ++++-----
 drivers/net/nfp/nfp_net_meta.c           |  8 ++++--
 drivers/net/nfp/nfp_rxtx.c               | 36 ++++++++++++++----------
 drivers/net/nfp/nfp_rxtx.h               | 16 +++++------
 drivers/net/nfp/nfp_rxtx_vec_avx2.c      |  6 ++--
 8 files changed, 65 insertions(+), 51 deletions(-)

-- 
2.43.5

