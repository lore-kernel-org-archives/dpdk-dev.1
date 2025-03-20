Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE46C36000
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 08:37:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C9AF402C4;
	Thu, 20 Mar 2025 09:37:28 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
 by mails.dpdk.org (Postfix) with ESMTP id 5C3B1402AF
 for <dev@dpdk.org>; Thu, 20 Mar 2025 09:37:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUDyu94nXb/5a5sOfHPNJFAxGvsIcQqSlKy+/GR3yHEbZnfTAEf3A6bu3xKvPQCgyeGfTOxJkLnEXsPMJBDUoOQSivlzqgPywUZKDHEJmrmpbrIOxq1y05etUBffXSdtA5CLwQavFHx495OV4tBtOH2llPDExketoU6Hfv1jShYhkq06qSvvkTQUK4NgPhyzX72UXkOeESWKB5A/hkxn7EFC7iARBYlVKW6zJ83ar5elyhdSQK72XIqycXMTecNJxndg999L7Cbz9XQshhkGkfAdiAhPSaIc5rcBeFjVCu8yuW+3XaXvzIU2k94M8CU/lTFbwpC9r50FNEImB52SKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVoK1A/CmCkeMjhGxNxyCONStvWuL6VCtu5ogCuYmUw=;
 b=XezXfNWCmqbTUoCOBiZz2AvwC0/Prb0KX3nrsck1CzmISBFhxiCNEbiZ6tjpZKB9zqYA4NN6kcaL5bV5L5Ob9Ng7M6r9ZHk8dUr9b/+NqJyZ+AZCj8chiFJ3PyEuPUqZ2yFyBxRQE93y1on6n3IYYHflMvvM/taypFz2IqGK3F+nkiPx2eFiwyRndY/D+Y83oXHRfukzpODBQk9XGfuUmRU1aNFDOH1tsqsMsfUbb1c4mirwbrl6sa4oFYYRAlED6HoPm5AYd1J/YpvPjluWPwdsSJp5BFhI0wMvOETvBO6pjfDij9ViwkJLkZlbKW8QtU+yuEqFLieBQ1vhqKIjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVoK1A/CmCkeMjhGxNxyCONStvWuL6VCtu5ogCuYmUw=;
 b=h9qjPMbIwulnCBf42M2TmPNb4GIBA6PqJQ1wnPV/XVxh/3WSUoFyzxUwMo4k2B8ftw9TJDILr1yZNuW/2BSAnXmLnxdnOqz0ZjkEsx6axhXKkKop/NZiQWbLY0FjLZCDAkx1om7RwAWmyE4uR4fUDlLuBDPqy4KNqBivMrG/BgVz66aJUqaSsQEdT8KqX8x7lUpWv7j4nbyPUPwZIPYd5DpdfuUa8QFM806mLw5Jl/wDlu3eZfHHyJfAFHi1rIqVnZajN9Kp/YvpEH/Wc/fInEiU6vr/aUCbWiV18Cz3W4m4MO4uScR4hEOXROaiyLx0qM5/09cXBP76bN6Dwh/5ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com (2603:1096:4:15c::13)
 by SEYPR06MB6932.apcprd06.prod.outlook.com (2603:1096:101:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:37:20 +0000
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4]) by SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:37:20 +0000
From: Shaokai Zhang <felix.zhang@jaguarmicro.com>
To: dev@dpdk.org
Cc: linville@tuxdriver.com
Subject: [PATCH v2 0/1] net/af_packet: register supported param fanout mode
Date: Thu, 20 Mar 2025 16:37:06 +0800
Message-ID: <20250320083707.5594-1-felix.zhang@jaguarmicro.com>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250320081503.5505-1-felix.zhang@jaguarmicro.com>
References: <20250320081503.5505-1-felix.zhang@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To SI2PR06MB4234.apcprd06.prod.outlook.com
 (2603:1096:4:15c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4234:EE_|SEYPR06MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: a6889887-5aa2-41d8-0d6d-08dd678a6da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GTSyfROwuRHZdOVmq3EM2FGOQLWj2kvDumNMlQvbIO4SY/NV3SdWtaE4uZM1?=
 =?us-ascii?Q?Qk3I/DZqStSKTUsIBjkxE7MVvrSYzSvZmR+fQx8IEhsHxCPhC5qpe4pXBjWa?=
 =?us-ascii?Q?4m+wmDv6XvGqEz1hTbb4Z8hmHidsbPvsDXUtxFfgLSKrve7QXWKuMUsbBk3C?=
 =?us-ascii?Q?+UaOHs0Uu6lMCCVCIXnNcQh3oL8K4zxHctQcUhCmea6XRsBH4vfT3syzIREY?=
 =?us-ascii?Q?kB0/9uNwgf5A7aN93rBSEryLnxTqF55R1Px1QOpuiSN1B1gXN/BvE/uwG9+H?=
 =?us-ascii?Q?6y0OUYJYtbCpH00OGjxvCfatm5NoWvNQ2FECSscCaqYmMy9ecIKeoquD7hTl?=
 =?us-ascii?Q?1u165pQGDy05FbO22mcHWptXpUiPjS6OIoygh13w3dwPSHxeNSAAiuttLpht?=
 =?us-ascii?Q?+XSHxHUhM3hTQtj+Q+hQ2HqcTPGNLm3sMVtHQ/yTW1FVvfz/EWZWV97FkqSd?=
 =?us-ascii?Q?fHxfdZQb2RjRSBlEIyyTQMpL5FKeitBCPV4l71Xi36s1lGXBYjyHUGDAE1iQ?=
 =?us-ascii?Q?bllcCoBJhtZ2ptwfov15WKnQCmWSLODhIwJg5oQU4HIfxRnaw1SZC8bxTStU?=
 =?us-ascii?Q?oDc8SxhOWhepzJaMAvD1VT+hZOASnUzWuIUe9X13dUMy9Nb63mrywqn+DJqJ?=
 =?us-ascii?Q?Ql6BesYm8aCtemxMBbUCLv/adkS86e/OrVs3RL7Hj96wQS14nWmQcz6Oah6Q?=
 =?us-ascii?Q?7OiA93VWQ4IaP6LAe6ChfehHoBF2h7F0yEjKpdA42bqmIV0WxWZaEDbDVn43?=
 =?us-ascii?Q?Hoxpk2dTimrB4G0UwD2+s3HZlN+YHMvY1qFgDQf4WkLoRLGbZkniDmf/093B?=
 =?us-ascii?Q?wYlZPsldFNxeq2sdUBh/90vj3tgE6SlwCHpXwFXAv/e4BSW5uJWb3qaSGV0P?=
 =?us-ascii?Q?hq8CdbUdZMxIIryero40ZM7i9sjiJ+2yesizKBJzTJ92q/gWONMwxEOxB40g?=
 =?us-ascii?Q?N8snYwP5sSe/AHKjtQ75ODDdUwgS2sgafN0bwf5HQQs0JcD2b7gHEUdF4cyQ?=
 =?us-ascii?Q?fcrPxmcmws7xzLE3a6q5rGB1Q6USi4NxJAjY8Y3Ah5b7MirqYV8RQHyxvmzL?=
 =?us-ascii?Q?pXlW3gBRqAiWn1D29OX03dkTBl58XMgOjOmcwQDj9dOAVV6HsEFUNg/vhdhE?=
 =?us-ascii?Q?KFTDSjVKO2pvoE4a7lWWm6lSrUChJkNNVkLeVGm1mEmR6rSIuGGb+Q/7JBsE?=
 =?us-ascii?Q?z8YWOkvK+zquZogZOjYUOIZ/pres3XrJi3Qw4W/ygX0OWH/iavHjMiGAFx+Y?=
 =?us-ascii?Q?WsC0q2w11wYl76PNgV6HTj54QQfLfUFo5fGukKoV86FYuRYRxqw+yAUka4aA?=
 =?us-ascii?Q?h9SQAb7Z9D92jqZnHoupHicpsMgB7KQtFAthajBozrM/K7mhjeuGEAEjMfdA?=
 =?us-ascii?Q?uDzdH1CxIoaS7j9oMRuhOfQZHR168nf0qPFEFVVAiMKcEOcno+MZyMtYY+Fw?=
 =?us-ascii?Q?kxjs8SI7DvEZjSRuk/OucCVmrvZc1rbm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4234.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9rG9D1oc4B6W9IjZxiNTECckgZrSNONQwAHRUg8xOGxvoz0T6DyKQBnlylm?=
 =?us-ascii?Q?cARLUNeFlMccDybhQoPdppFemwGKlVYgS0W0yJFqjSv2kCCWViPKEBplVOrk?=
 =?us-ascii?Q?f6SPkEJAeYhEcxzVcjV+hQC/Hv+zL/u6sbivL1OoSGR+TZQlG/W27cPznZh1?=
 =?us-ascii?Q?PfjPeWZCQQelDE3PmXAZ4Cj44y4PmV4mfCrXedTdaWvCQisQ4cFhHYEHFFz/?=
 =?us-ascii?Q?SKXP2swtuPvI0ovoLRKov5N+CezUz5KZF75fsjRwUI8nwgbNbbfu1LAQWJrL?=
 =?us-ascii?Q?DO9MdQWkb3ivHu7xSFjuiO3P2unJSlzuAHh/8709kjcrLfc0QsURzC8nCzEM?=
 =?us-ascii?Q?pnomF/GApB/RqjZxBYh9sUsli5W8a1/rH0FpS3JzCUTqgt/qhnxeuM0VpHAh?=
 =?us-ascii?Q?jIQPSjFAuaNy6f028DPsMWcgpYAPUJydi7M0c9ZhgX/J871xpEk4Ix9hiQ8d?=
 =?us-ascii?Q?cX1+NbUPOWBVdMiUSQMYuOSNfkZNO7AysM86OXRkSru7cp9HxE/BrmSoDaoL?=
 =?us-ascii?Q?LLBgckRQ9ywqW5e/srHRfa20uxxouVh3+mpWzBjqKom65qij5FedP4HE5GO7?=
 =?us-ascii?Q?Q+W01OJAH/tiDoEUDyYEKyiqeQ9Tevuf6f0LpJs+9sQQ6biutb9Mpr2dYv9D?=
 =?us-ascii?Q?/S2YELxlR6ozDCmUT8yIbs3OSi4mo3sVOVNQcy03Sf/5q+9j8leGD7K3GAzh?=
 =?us-ascii?Q?PdclpQcrFxKkePJFacthTeEbR9JdqVi2x36kx7+WBtx9ozv+eXKeA/nl210m?=
 =?us-ascii?Q?QIkZPYlriF0IcpIFfrVy5kja8f/ReMvIt87QeZBWW1SsjeKqAoe3PRAf5R5+?=
 =?us-ascii?Q?Q65Kq/3gM7sJsGYcEZwwliXD/LgFGxiP2Dp17/StKbdEU6hjUUcCLdIonEST?=
 =?us-ascii?Q?rod2tA3wsN3jyMgL3Y8xNPDu2DYPoe1BBdyKKOL1KuQ0DXDFa359pqtVVTXn?=
 =?us-ascii?Q?poCG6p0YZ0SGye0t8dZmgZavAFvtEXKQwXCimOxiDH4kdkc+ANyC6fArNG++?=
 =?us-ascii?Q?Dbcr3o4zTLQhv5eEXXCAEA0azvN3cLyT55rJr32airVAcAdq4fY0T5k/3gsf?=
 =?us-ascii?Q?Z0YF8x1Hs9xqgHyUu77k7jHaPh31hCWptx2e1FkG+6ytCZnqIPlXCqesjyQk?=
 =?us-ascii?Q?yu7A65gEMk76i50QIrVq9D6UChsAINdFjWxGN3qzLhtS2pMeCG/C0QRG/gAn?=
 =?us-ascii?Q?oLFaz0FDUwcZznxKnSRYxze1EuWYxM0Spg5CfziFShAbNJ297ksPkFxKYfj5?=
 =?us-ascii?Q?GhmHZ3F1Z9Vdt0at+aUwiRLRYI1Jr4mNxctNv2q7wWbIlZtjrTUiaq2AlTSI?=
 =?us-ascii?Q?jDDn1ctaNgOIgmfYrXDM1anLcec1X6H7Kvx6lire07rOFILLOQnNvqYQT2Pv?=
 =?us-ascii?Q?mRvb38IaIPzFJ+fTDwJ8nd9OWlH1GQGISgqY4DIReSjcX2o4KyzIKc+dRyPn?=
 =?us-ascii?Q?0bnTUIVYum36v1NvGuogpOdj7EBFyp1k+CL4SzH7uP17d9gEP2fkwiFqpCjF?=
 =?us-ascii?Q?6Qbuo9OmnqdjJKNJ14mL1SjfpUxpYdsLbPS7o7NxRpPpsz7Md62PpMe1zsVs?=
 =?us-ascii?Q?9s4DXM7TgXypjSHtEX4zZ72Z22i8o0+/GShVyQzeOWmMNujJPGc/eGVZOUon?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6889887-5aa2-41d8-0d6d-08dd678a6da5
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4234.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:37:20.2339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/dbNmYwqs2fwrv4GJth/E3IVb84QV3SUSpgiy8rqpHsaAjoVs/cP/fDCUA1wf4didHe5M5WvMj9a1TkKleFcGCPZ7ETLqpOQEfOnGUh3qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6932
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

*** BLURB HERE ***

Shaokai Zhang (1):
  net/af_packet: register supported param fanout mode

 drivers/net/af_packet/rte_eth_af_packet.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.47.1.windows.2

