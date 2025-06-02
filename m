Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690C0C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 23:12:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EB804028E;
	Tue,  3 Jun 2025 01:12:01 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
 by mails.dpdk.org (Postfix) with ESMTP id E245B4025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 01:11:59 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VYwwiHNdCpQwXl1A/PqfqWAcsZX2T/JRQj8KmOoqpC/XErEXatqyuMN0Cly40ZG2BFpBJpDEgYW+g/T063sOXUErpnY30ko5D/+9QjxfBAQb0p00b6fDegeLLSURpSQYS1aZkkbM/f2YE5wWEcnu+dnHF77gZUzVpa8I6IjHYjg/J587jbbo+pto8cCYr1Wei32MMnEP0DYCSC2yQU5n/GNHUTg9yH3EIBooBhI4mghzG/+HImEzYA3a0dlDv09AmbBWmCNdCR6R6seKaQv2QSALtxfWjpxl5889UYgbuqlysrxdOgExPbs1sHRWAo6PAOd2VAhcNo4cxLyLKl8Mlw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQtqEC5oEg1hQXcHKRwpJDoKMEa6nGFx47LyePhqcl0=;
 b=MfTLhRtrHcJiPEJarE7Bo95OQUQX9mLm2hn9jkAu66AVeR10aY7tI+81zW4NObA1JSe0zUYqF8vsUvAqjLmxUX/CB3/XZI43bCceGkZZBmhOl4btV4D8ZMDjXqCUQRZcXl8wpKn2y1z5RwjLuRVz8/z73ARvdo9bkPriUGUhHNmS2dl1O2TZyD/zGtLXMe6Evmazu+MUyneUj8JHsOnz1IvXvzyv/i9qTVBY6RA5dDU404M/mVMOg5Sc8dyyN6W8DiA9fGO11Sn1HB/JfydWQ2Veyp97JCIjpoqmA2ze73HdsjncG2w7pMHRNEd+Ln931CizTeUawgpoCRPbA7JSSA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQtqEC5oEg1hQXcHKRwpJDoKMEa6nGFx47LyePhqcl0=;
 b=m8o5MfMqgR36z7t/L+k0eB4U5+mfQmtQdqYK8rG5LQ3u0kK1UWl0yqp2MRPOf77lNjmpZEuz4hpnAjPrO0/FxxCpe1XH7ZTywHPDEi30iNyEoEgMmm7JHnY+Y22dXXrPU4QCrIifru2Ddq65iVM4FWdOw+GY9LuaejXp9Eh/tiY=
Received: from DU2PR04CA0290.eurprd04.prod.outlook.com (2603:10a6:10:28c::25)
 by DU0PR08MB8089.eurprd08.prod.outlook.com (2603:10a6:10:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Mon, 2 Jun
 2025 23:11:54 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::b2) by DU2PR04CA0290.outlook.office365.com
 (2603:10a6:10:28c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Mon,
 2 Jun 2025 23:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29 via
 Frontend Transport; Mon, 2 Jun 2025 23:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSe0V+OpYZAgA3PFko9woHJ2JRwAUqDVZ8JHJZTiyKQwcN1TFYmdGrnCVi0trmVpNB4d8T+5kmV5zLr+/WRZihwlXxw1Om3XLkCUK3r20Ps841CbmVzNi8tAnWxrbg9gfYpE8NaPMJ8CfiqP0iqmnkrjyezk6MOi8hrulteJBMuAya1gWi+FfxGgbO2BnreqhKYiEuYTrgOKpIx9onIv+NlJGE0/vLg/oUHku4wfSq88fAUwRG9kwiU0v/6se0ObdYzUUyW6l1ZfMvDdc2tLmcU97c9n/EWp62/R81PBWaWiGDuD9H3143NWXGQe9FdqNPadoxL9BnOtOvdol125+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQtqEC5oEg1hQXcHKRwpJDoKMEa6nGFx47LyePhqcl0=;
 b=nJmAvhOEl4zosuBHXkZh6XygE4d2nkvyZUiow9kXAKYlBJ8DHiSgl9YzDubXlg7JVdYXtFPlMGD9bZhWM3+Fd1zlRSTT5B4lDPBekYY/NUoaXK72FrbQlaUQjQaBa4xlzBDPqAgJlYdsaFjfLh71pL3BYvMkPmoi5TPBJuP+ct1FjCemExvwY+hnGcSfTzDQ/RpTKHrcOeeAlznZAzNpE6YB3xuOKoLK6Xv3YLEF4+35JmRaznTNj9/YsM+svNfGGer09ruYJqd3wnC4jGDJGO1mZRy7EJpOHy0GlB5hH5piOQH/gU+33GkUZRPTv8nJeBebY2E1hJSnV2/ExklE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQtqEC5oEg1hQXcHKRwpJDoKMEa6nGFx47LyePhqcl0=;
 b=m8o5MfMqgR36z7t/L+k0eB4U5+mfQmtQdqYK8rG5LQ3u0kK1UWl0yqp2MRPOf77lNjmpZEuz4hpnAjPrO0/FxxCpe1XH7ZTywHPDEi30iNyEoEgMmm7JHnY+Y22dXXrPU4QCrIifru2Ddq65iVM4FWdOw+GY9LuaejXp9Eh/tiY=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by DB3PR08MB8915.eurprd08.prod.outlook.com (2603:10a6:10:43d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 23:11:20 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 23:11:20 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>, Chenbo Xia
 <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Dhruv Tripathi
 <Dhruv.Tripathi@arm.com>, "thomas@monjalon.net" <thomas@monjalon.net>, nd
 <nd@arm.com>
Subject: RE: [PATCH v5 1/4] pci: add non-merged Linux uAPI changes
Thread-Topic: [PATCH v5 1/4] pci: add non-merged Linux uAPI changes
Thread-Index: AQHb1A8JRtUOnyoET0aK/WKZvcZEebPwfn6Q
Date: Mon, 2 Jun 2025 23:11:20 +0000
Message-ID: <PAWPR08MB89093235AD3B7FB8AB6EFDAA9F62A@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-2-wathsala.vithanage@arm.com>
In-Reply-To: <20250602223805.816816-2-wathsala.vithanage@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|DB3PR08MB8915:EE_|DU2PEPF0001E9C0:EE_|DU0PR08MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b1595f-410e-4f1c-568a-08dda22add59
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?/1jC7eCuOKyC8zkQSnUygTLguweYc/pfz7mu/z+m0WqSzq80EzU+cJMBeFlS?=
 =?us-ascii?Q?bMCLkCQEcKXXiUIDmultSrsOde9DEN7pshmY9g8OOY1sKqyCrb8GKGVttrhy?=
 =?us-ascii?Q?KOi8FWAI57LaCcbn+1ukNQZTtYm9sIT5WPOYgAh15azWobKQiTuNfXTIP8w2?=
 =?us-ascii?Q?7oiIr/m2S8P7SrqVJkE+X/MmtumhJg++4KO6ZaADKMBVYbPC8l7ilYoqmCgw?=
 =?us-ascii?Q?RFldMZN2YTRDyfYIn2rGOXCuuHEA2h99AlYoKpm+/W5pbgljD2eAwft/I4uk?=
 =?us-ascii?Q?hUgpfwzdyiO13ChiFUCdP6Cr0wX20RRq/HJqNkuveK0Pzv6Da2qovNdLayiJ?=
 =?us-ascii?Q?CYHJwBVjj2jGquXwdnbYybbK1IWeOjiOACeS3R7PeSmmrnR4hFrHmnz1Q0hp?=
 =?us-ascii?Q?lj/NzLp+6XLxzMugVj5oQgEaSWAJvkp9LQu5HJKRdeZfowoH7JnzO5+5Yzam?=
 =?us-ascii?Q?jr9TzdDRNoJXR0CA/jXAfUwAvsJzW8CMeBi/65Ni+SayRbvHCpdAPeJfJpSt?=
 =?us-ascii?Q?O13lIFUfaYRbKHCkK0lgP/pHjbnN0Xytj2c458f3bkrb00nX16DFDpfs9GMz?=
 =?us-ascii?Q?Bg4LPn0OkmjdOAIl9j/zEd3pOerx7HNUDOaW3oOleAY0YH740BIz0dn488lL?=
 =?us-ascii?Q?ioedo83rDsO2quXvaBh9fUfkugZ9SB7yie5SOwIbBC6V7nI6IVZHoXO3SEZk?=
 =?us-ascii?Q?3A7Z6ynCjqmiQzaZMcoFuSj+IwqjQH/gRc+t2ZtbqZpRBQx8QBguV6tTolRl?=
 =?us-ascii?Q?N6n3GaRLpiZXlzT7NZEq7z21pdCpQ/XRl8JUR+itwAB38U+p3GaGjfZMTmly?=
 =?us-ascii?Q?p4aAKdGob0ra48vbQsFrb/SDm0+RKm0AuMC939XDFYZCzDM2MpvaFXloKKDv?=
 =?us-ascii?Q?jfbhkfGkQruBinQZK2xESZ7d3ud0rdwaUr1E8fYQkX8fVXqH7O9ftMsgPyrJ?=
 =?us-ascii?Q?ECxBm84SRX4UdRR+lQ6D35sWmMLWtfKvoBcxEevccusVy92W9D1MbZ9VS/hg?=
 =?us-ascii?Q?QSg2QMW7uSP5Ent1auFKCUokkujD9GjRZB54TcxybqdWvX0jMgs9xRZ9SL9g?=
 =?us-ascii?Q?ecmpRFTN7b2MYfpin984beuOj9a5zUNiQOlbvp7uTJ5T2WNTMyi/WY41/I25?=
 =?us-ascii?Q?oE8RnKi23r0E5zG2gW6cIyUFXSqzqwL9DW7OE+hlNPUjRTCWiUqnXmVEPYuM?=
 =?us-ascii?Q?gle7j3OarCqKAJd7r5zVinfVEM3HyfiUw0C5JOUiiYTOn3404PoXkefZgtu6?=
 =?us-ascii?Q?2OZqXysW1ApHVd8iC8xoMFS3YOP/RbDpjMFI2eiccmhaLp8BsSibqUALSjn2?=
 =?us-ascii?Q?9ghPiLy+NTuwFFy6GQvd/KsxPGTTodEHFuJkZfS88uXa1U/LW2OvaNS9LFxD?=
 =?us-ascii?Q?uIWahc2cYuz6oiBbQw5HDtOVGPMmdkAMmLefHa+4524/T8QCFWkbakzbE/0z?=
 =?us-ascii?Q?c3KHFlT3DQtpMScOdNySldBnWiC8uUEz?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8915
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 93c57d7a-09ee-4d46-b47a-08dda22ac958
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700013|376014|82310400026|14060799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ejwM5PkRpB6Dca3IW5NRBlTsGC1vb9t2RA8A8cgA8w4lxCM/W2dZVnrBqq3?=
 =?us-ascii?Q?grzLaMBv4veImxOhyhIxK+32yUSwNA/jOxZxj/jpE4oVlEaqHhcyixfn1W8N?=
 =?us-ascii?Q?7nl9gnzD7jXpG9B6cpW4VZXEMfzz6jxzb4rKUUdIBUzFxDUWkiJe+f+Uia3v?=
 =?us-ascii?Q?c6qVnZFeB0GHbpvdkx4+IECoIMXmexI5PShdl9+AQ8gE5lYg4vRSuOxytRwu?=
 =?us-ascii?Q?lBn0R4wCVgh1quX+an3zSQRyW93FwSzG/LGATOiamKX5eqi24yUxBgw1qPWX?=
 =?us-ascii?Q?iJlWJ5/OeFsbAs99LWcYA0THO7+DnPGjCAL7O/e8KYDouLvWoMJNfeFfpZet?=
 =?us-ascii?Q?MTJwitM7gbTCjmV3ZZ/s94tugi3xNWLYy1zN8vH3WxoZ5QQbUmm6ghwTKXKw?=
 =?us-ascii?Q?bBHt79PEr0qsTM6KpiDZNkj+4eKrDhDd6MzUuqE4mj5ILFFwAMPyUt+aqcid?=
 =?us-ascii?Q?zSkR6/QNPY871I3P2YJI1044oCOb5zaBQQRQn6s11JIIk4FW9epj3LPnAjDi?=
 =?us-ascii?Q?Ip3qsNVhXdE/GfC0PNfuB6uczckXMpgScEtZciKbVQ5Vzc6ZP114gzr6Z4yT?=
 =?us-ascii?Q?lWnaT88WAz+sRqKe+lLPbCgkKqCALgHg7bSFCwT1+/ZXcSVdVhw3II2KqZmp?=
 =?us-ascii?Q?PWVvVTFy50j3JVeq08gCPGAdKT3RpW4pr1hkk2n+TUS5BzKgoBiGjTIYpMtx?=
 =?us-ascii?Q?/bk+0U9OwjyjGkVnufmQFgWjbzgX9q1/qTBPNt3ozDKhS1WYW5z4wMFLWx5E?=
 =?us-ascii?Q?h33BBkwe+xH0m4gYDxVaH/FkEnA3aieejHsAbjynnc8UnTQD74Wj96PvRvzA?=
 =?us-ascii?Q?sf8PdhDuCbJG9tQrAocg2lm87VDtZeIUH9EtTeXIGNrkI2cmUOVTEVPX5uXy?=
 =?us-ascii?Q?u1y8eEMT4y7YW6KyFw9dTqdrQLOvxxexIt8gz/1Fpehi4npK16RcZTda/kqs?=
 =?us-ascii?Q?EIvhWrSeXIa+mpjkLf9187t6kkLX8wvy1x0dEHSEJCFuvmRSGCd9Gjh5Nd87?=
 =?us-ascii?Q?MOgNlAmvYD2/OFT9ufThI00KxtyfOKdG0yyCzuL4umA4Y6tNsqRkuIqnmtUb?=
 =?us-ascii?Q?jfdUqv3N495kRoIcGRA68QlIeBpj2ozEOe1TZZbNmvPu1OB3iXeF4sAdvV4j?=
 =?us-ascii?Q?iS1ZeMcCP4x+aTM16pL5dEj6Z4rjRFIKBhuZnfaMcbjUEyffonZOquEvqqhH?=
 =?us-ascii?Q?QVTn4rwhbbT0eatZrc2AqVcAMoN5rh7r1xZAb9DC2lV/GOwOTpYwiGFOyBrl?=
 =?us-ascii?Q?iD8ukDlZ3s3+IGK/fxg4OSUcERi2OrxyL7zVGtFcj/T9yZAt1QyL4CAgl+nb?=
 =?us-ascii?Q?+gyZmCmylikwZ2a+sP1W5zt4T4y488vtsNB3rG78PCvxClcRzofERAnqYafP?=
 =?us-ascii?Q?Q2iTzyFa64AESE0t/5/bz55aFXikBNARf8ZQPz30LTI+a+71RvlJAo5VSMUu?=
 =?us-ascii?Q?iNW2tuZg7liB7qJaOY7T8/99zq2v5KV1M8a29k4Seyb3NRb/83KlVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700013)(376014)(82310400026)(14060799003)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 23:11:54.1366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b1595f-410e-4f1c-568a-08dda22add59
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8089
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

Hi Maxim,

Here is the link to the kernel VFIO patch you have asked earlier (v4).
https://lore.kernel.org/kvm/20250221224638.1836909-1-wathsala.vithanage@arm=
.com/T/#me73cf9b9c87da97d7d9461dfb97863b78ca1755b

Thanks

--wathsala

> -----Original Message-----
> From: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Sent: Monday, June 2, 2025 5:38 PM
> To: Chenbo Xia <chenbox@nvidia.com>; Nipun Gupta <nipun.gupta@amd.com>;
> Maxime Coquelin <maxime.coquelin@redhat.com>
> Cc: dev@dpdk.org; nd <nd@arm.com>; Wathsala Wathawana Vithanage
> <wathsala.vithanage@arm.com>; Dhruv Tripathi <Dhruv.Tripathi@arm.com>
> Subject: [PATCH v5 1/4] pci: add non-merged Linux uAPI changes
>=20
> This commit is a hack to prevent build failures the next commit in this p=
atch series
> causes due to missing vfio uapi definitions.
> This commit should NEVER BE MERGED.
> Next commit in this patch series depends on additions to vfio uapi that e=
nable
> TPH icotl in the vfio-pci driver in the Linux kernel.
> These additions have not yet been merged into the upstream kernel.
>=20
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> ---
>  drivers/bus/pci/linux/pci_init.h   |   1 +
>  kernel/linux/uapi/linux/vfio_tph.h | 102 +++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100644 kernel/linux/uapi/linux/vfio_tph.h
>=20
> diff --git a/drivers/bus/pci/linux/pci_init.h b/drivers/bus/pci/linux/pci=
_init.h
> index a4d37c0d0a..25b901f460 100644
> --- a/drivers/bus/pci/linux/pci_init.h
> +++ b/drivers/bus/pci/linux/pci_init.h
> @@ -6,6 +6,7 @@
>  #define EAL_PCI_INIT_H_
>=20
>  #include <rte_vfio.h>
> +#include <uapi/linux/vfio_tph.h>
>=20
>  #include "private.h"
>=20
> diff --git a/kernel/linux/uapi/linux/vfio_tph.h
> b/kernel/linux/uapi/linux/vfio_tph.h
> new file mode 100644
> index 0000000000..9336c2e5af
> --- /dev/null
> +++ b/kernel/linux/uapi/linux/vfio_tph.h
> @@ -0,0 +1,102 @@
> +
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * VFIO API definition
> + *
> + * WARNING: CONTENTS OF THIS HEADER NEEDS TO BE MERGED INTO
> KERNEL'S
> + * uapi/linux/vifo.h IN A FUTURE KERNEL RELEASE. UNTIL THEN IT'S TACKED
> + * ON TO DPDK'S kernel/linux/uapi DIRECTORY TO PREVENT BUILD FAILURES.
> + *
> + * Copyright (C) 2012 Red Hat, Inc.  All rights reserved.
> + *     Author: Alex Williamson <alex.williamson@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _UAPIVFIO_TPH_H
> +#define _UAPIVFIO_TPH_H
> +
> +/**
> + * VFIO_DEVICE_PCI_TPH	- _IO(VFIO_TYPE, VFIO_BASE + 22)
> + *
> + * This command is used to control PCIe TLP Processing Hints (TPH)
> + * capability in a PCIe device.
> + * It supports following operations on a PCIe device with respect to
> +TPH
> + * capability.
> + *
> + * - Enabling/disabling TPH capability in a PCIe device.
> + *
> + *   Setting VFIO_DEVICE_TPH_ENABLE flag enables TPH in no-steering-tag,
> + *   interrupt-vector, or device-specific mode defined in the PCIe specf=
iciation
> + *   when feature flags TPH_ST_NS_MODE, TPH_ST_IV_MODE, and
> TPH_ST_DS_MODE are
> + *   set respectively. TPH_ST_xx_MODE macros are defined in
> + *   uapi/linux/pci_regs.h.
> + *
> + *   VFIO_DEVICE_TPH_DISABLE disables PCIe TPH on the device.
> + *
> + * - Writing STs to MSI-X or ST table in a PCIe device.
> + *
> + *   VFIO_DEVICE_TPH_SET_ST flag set steering tags on a device at an ind=
ex in
> + *   MSI-X or ST-table depending on the VFIO_TPH_ST_x_MODE flag used and
> device
> + *   capabilities. The caller can set one or more steering tags by passi=
ng an
> + *   array of vfio_pci_tph_entry objects containing cpu_id, cache_level,=
 and
> + *   MSI-X/ST-table index. The caller can also set the intended memory t=
ype and
> + *   the processing hint by setting VFIO_TPH_MEM_TYPE_x and
> VFIO_TPH_HINT_x
> + *   flags, respectively.
> + *
> + * - Reading Steering Tags (ST) from the host platform.
> + *
> + *   VFIO_DEVICE_TPH_GET_ST flags returns steering tags to the caller. C=
aller
> + *   can request one or more steering tags by passing an array of
> + *   vfio_pci_tph_entry objects. Steering Tag for each request is return=
ed via
> + *   the st field in vfio_pci_tph_entry.
> + */
> +struct vfio_pci_tph_entry {
> +	/* in */
> +	__u32 cpu_id;			/* CPU logical ID */
> +	__u32 cache_level;		/* Cache level. L1 D=3D 0, L2D =3D 2, ...*/
> +	__u8  flags;
> +#define VFIO_TPH_MEM_TYPE_MASK		0x1
> +#define VFIO_TPH_MEM_TYPE_SHIFT		0
> +#define VFIO_TPH_MEM_TYPE_VMEM		0   /* Request volatile memory
> ST */
> +#define VFIO_TPH_MEM_TYPE_PMEM		1   /* Request persistent
> memory ST */
> +
> +#define VFIO_TPH_HINT_MASK		0x3
> +#define VFIO_TPH_HINT_SHIFT		1
> +#define VFIO_TPH_HINT_BIDIR		0
> +#define VFIO_TPH_HINT_REQSTR		(1 << VFIO_TPH_HINT_SHIFT)
> +#define VFIO_TPH_HINT_TARGET		(2 << VFIO_TPH_HINT_SHIFT)
> +#define VFIO_TPH_HINT_TARGET_PRIO	(3 << VFIO_TPH_HINT_SHIFT)
> +	__u8  pad0;
> +	__u16 index;			/* MSI-X/ST-table index to set ST */
> +	/* out */
> +	__u16 st;			/* Steering-Tag */
> +	__u8  ph_ignore;		/* Platform ignored the Processing */
> +	__u8  pad1;
> +};
> +
> +struct vfio_pci_tph {
> +	__u32 argsz;			/* Size of vfio_pci_tph and info[] */
> +	__u32 flags;
> +#define VFIO_TPH_ST_MODE_MASK		0x7
> +
> +#define VFIO_DEVICE_TPH_OP_SHIFT	3
> +#define VFIO_DEVICE_TPH_OP_MASK		(0x7 <<
> VFIO_DEVICE_TPH_OP_SHIFT)
> +/* Enable TPH on device */
> +#define VFIO_DEVICE_TPH_ENABLE		0
> +/* Disable TPH on device */
> +#define VFIO_DEVICE_TPH_DISABLE		(1 <<
> VFIO_DEVICE_TPH_OP_SHIFT)
> +/* Get steering-tags */
> +#define VFIO_DEVICE_TPH_GET_ST		(2 <<
> VFIO_DEVICE_TPH_OP_SHIFT)
> +/* Set steering-tags */
> +#define VFIO_DEVICE_TPH_SET_ST		(4 <<
> VFIO_DEVICE_TPH_OP_SHIFT)
> +	__u32 count;			/* Number of entries in ents[] */
> +	struct vfio_pci_tph_entry ents[];
> +#define VFIO_TPH_INFO_MAX	2048	/* Max entries in ents[] */
> +};
> +
> +#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
> +#endif /* _UAPIVFIO_TPH_H */
> --
> 2.43.0

