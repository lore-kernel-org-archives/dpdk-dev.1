Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDC9C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 11:47:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2092400D6;
	Thu, 17 Apr 2025 13:46:59 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11013059.outbound.protection.outlook.com [52.101.67.59])
 by mails.dpdk.org (Postfix) with ESMTP id F38DB400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 13:46:57 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NKbS3BD705PAyr5xDVDXRwuT5de400qbR7bznJtnbHaL6+hgwEUzgHd5pHQGxZ+QZPLj/wm8NrNQBWIoSxINiXoI/WHVYOIJTRMmct+O3iVmi8BdT9DbOmzdKNRzweb/8EHqqyxvr/071+kLMfgJlI8cV8+u2N4ehAJXQVKf+k0xN98yw7WXqCaBBTzNKPicBH2OE8dmPX9WhoNvPeQz2drfpuJxbwiPIungp2IQwt0lhSTNk5PHJOkelBiR5bOs5YxXULJpb81WE3rrpRfBCMnL7UD6QsJp6WeJG7sDN7uGfaXPfT26UC/p5H0/kgBBU50Jcrv4eer6Q13anKjEEA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULxbQw9dgNYFnL24iCGLbUsOJoJR5MEGlnOyliPgRnM=;
 b=s43pXlZshZFXlfi9cKE5SVRGRjlAdIaa6axND/YjZYoQFh26rDrD4L7MwjbE9yh6VjIGLboxfUbpMYkOSA+Tp+q+prBMIjfOO0RBj1eQCkuxDGGQRvbRCRpyNlp2TbsqgnTnYq19lZipfB7PPogsMQUBZPFFUwpKZayckqqbJQnV7k1E5wtKDbfCvV8q1pwZDYTNjL6jHV8T60/5AaMbzTGwaR7Rre81RbvL7bnUJaXLyvrrIMMmpB6vI8Zs/MVn/YTmJwQVxHx3OZeB/XtQpTyQa0FczQGQ+sbbEXzVC8MYJvywK3ZeBkP1QXb9LDbpGade2W6u2HG2P0ncm3E3+Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULxbQw9dgNYFnL24iCGLbUsOJoJR5MEGlnOyliPgRnM=;
 b=MK5xXPHtsFMsYocsACRmrmsvl4Bp+NlDJscXjyQQCDwr1gz6pY3FSLZE9yt3Zo2WomWEwJgDyd582+dkhXr8DDGKjWtiZNtZ5hBuwArL7cV0p38xHg5f0/twyFDmtxJCmosqbQAczZKC3/pJl+F8L8zMsp+pa9WGZjeOOa7GTbg=
Received: from AM9P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::23)
 by DU2PR08MB7343.eurprd08.prod.outlook.com (2603:10a6:10:2f2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 11:46:49 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:20b:21f:cafe::66) by AM9P195CA0018.outlook.office365.com
 (2603:10a6:20b:21f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 11:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.4 via
 Frontend Transport; Thu, 17 Apr 2025 11:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1+vFcoVkpzUltHtvFfAq/AZHxZevTuqemBHbAFw+eayeqZE3Qkd1sC5kgh7Vi8DNBDayOorDoRj8rFvE/T5Ae5/GtUNTBfJuit33Dlo3yLtXftwMveBBd4FxG1vRM5P3YIquuEdWPtCm6yDKJvmVkxIvnCDlo0l2Wu8CH4yrXmMXJdMkGDhccW1eDrvl4KoJKNuQQbLn8zwnvJMQpnRiqeBVMkxNblllF27gka1Z4XmiTBpWwKLIDN8vfkYLfuwKGOP9cCfN+n0Z0lAvZhVr3S9n0LiXpEorjCxJmziF7XbseBxXmVSQ5Z3o5dq7LKmOpSj57QryjuQ4I4K2NiF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULxbQw9dgNYFnL24iCGLbUsOJoJR5MEGlnOyliPgRnM=;
 b=WHR3QBcfPxKVq1MmMMIOPkdFI6mPKsOB4HaGLxQ4uZM7LsNsjMsJp9y8ejxNwinG/QV5uHmNN60c/HLsuCL5a1cFnxCh/cSdxqwiO17udYS+A2S/WLJ7n7BokqMBnI5K8Ic/cfbaNEMsbiKMopNF5mrW5FLAAvCukjrJpqTAznEZuJqpo77g45iV2YnsT9L524PY9McTLgxXPko0BlelLHGzPkTh0KwvVBupo4xizCjpoFpDj6aCXbMoO7hwmNh3LJi6BuVzStINvGUYVf+HxM+e7FCgbsV3wuPEa32gIKU7syya1NYiKqWmbMaqglO4fqlM99RE3h/5jcFHL40VQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULxbQw9dgNYFnL24iCGLbUsOJoJR5MEGlnOyliPgRnM=;
 b=MK5xXPHtsFMsYocsACRmrmsvl4Bp+NlDJscXjyQQCDwr1gz6pY3FSLZE9yt3Zo2WomWEwJgDyd582+dkhXr8DDGKjWtiZNtZ5hBuwArL7cV0p38xHg5f0/twyFDmtxJCmosqbQAczZKC3/pJl+F8L8zMsp+pa9WGZjeOOa7GTbg=
Received: from AM9PR08MB7291.eurprd08.prod.outlook.com (2603:10a6:20b:436::18)
 by PA4PR08MB7666.eurprd08.prod.outlook.com (2603:10a6:102:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 11:46:15 +0000
Received: from AM9PR08MB7291.eurprd08.prod.outlook.com
 ([fe80::2634:2d10:433f:dff0]) by AM9PR08MB7291.eurprd08.prod.outlook.com
 ([fe80::2634:2d10:433f:dff0%3]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 11:46:15 +0000
From: Thomas Wilks <Thomas.Wilks@arm.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Paul Szczepanek <Paul.Szczepanek@arm.com>, Luca Vizzarro
 <Luca.Vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: Re: [PATCH 0/2] dts: use tmp dir and DPDK tree dir
Thread-Topic: [PATCH 0/2] dts: use tmp dir and DPDK tree dir
Thread-Index: AQHbrgeZZEVj9t4PP0G6GJboGW2jRLOnwDlj
Date: Thu, 17 Apr 2025 11:46:15 +0000
Message-ID: <AM9PR08MB7291EAE29871A06519E4E52283BC2@AM9PR08MB7291.eurprd08.prod.outlook.com>
References: <20250415130903.224858-1-thomas.wilks@arm.com>
In-Reply-To: <20250415130903.224858-1-thomas.wilks@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AM9PR08MB7291:EE_|PA4PR08MB7666:EE_|AM4PEPF00025F97:EE_|DU2PR08MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: a6dc704b-3eb2-48ce-6dc3-08dd7da5898f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?odOeCTTrIfyL65aNaUpL3M1H4V4CC2maxGI6jHUaCSaE7jiyZ33bq+WYse0Y?=
 =?us-ascii?Q?el5I7lBvJHuRtxPCe6UiNz6MvnyIsEicmoHKahnykzjsmSends/3An2iNvUI?=
 =?us-ascii?Q?Jzr/zyJyXOs98IuySz3pLm4vWrsK/oFJnVGNlikF3+4wyk9RS5qw0GkyHSXc?=
 =?us-ascii?Q?8PrsgNG+gZisi56lEJy1hnb2cay557l++mIVha2CMv7EAhrOZxUmGUhC9ERS?=
 =?us-ascii?Q?BfYE9imq4LUhUR5e/OPF0TVfw4eGvr6vqM694+dn4gPwY0m5oseADZ9omjwR?=
 =?us-ascii?Q?KmUUY8/bhJnBJHiz6mYNEiPTEUY/1/VDtii6dtmYa+5QD3P3b3it7VZkZ3Tl?=
 =?us-ascii?Q?1pLK/JciUVAmC7jJRe/E+/UCDfPUA+MsAbU6ADhmJZDSF7Bd20m58fDPLwhn?=
 =?us-ascii?Q?KYGMWbegEfuqeHYm1YoXUVfw3e5Sor5RP4YoWh1kI9Xwg9ueLUom3nu/Eisb?=
 =?us-ascii?Q?AIVHpB8dqODTYmjCJCEyV+2RqiakTWzQOGcxPxeWA+4iZEocEUndc3c8anyi?=
 =?us-ascii?Q?eJxKCH+XVfpAdRazAY1C2mHqN7M5lRug/QWv4LqkPmmue6Mkg+PHGO5b9vCz?=
 =?us-ascii?Q?/HKBm2wjlBLFP/vamwhGgmmbtONFd8Rzt0r2SInlxUkmKtUZwKy1vz9yg8ta?=
 =?us-ascii?Q?VAr5ySDox8bOZmMMTFYeTZCrflsYwIpkqR5I4/OHnY2u0Z07nA4owQAtz231?=
 =?us-ascii?Q?O6GnXvezfxtWcHWzzoXEW1kyyM/KumtPaj7Ds5HyzkzhzCcWsLQQ7yauJ3j+?=
 =?us-ascii?Q?D/GxCwUUxHRdyfqj7sQouyD/eh02/8bJ0lRSMgBM7dhgH7fAg+phJh8YDR6t?=
 =?us-ascii?Q?FW+9G04PYlASPUrDkCM98H6U2xF91p9Dc92wK77NZlmSA72J2C/kXgNHJ8d3?=
 =?us-ascii?Q?P71Wueehy12I8EZPOpkl3kLPyGkyXqIIyo7g7pypCIko4y15+F3yDxmiQZ2H?=
 =?us-ascii?Q?6oqCNTVF3eX2Z3tyBsDfeRuvvOayzTA43NMvrO/yW/N6eTF3RUiJHn/naHfk?=
 =?us-ascii?Q?aAQ+CYq7VZOz/0JeKnuyVTVCOOynPLUIdzFGhnKo/mf3WBG22ncA8lNOHXtn?=
 =?us-ascii?Q?rO2Bb1Rch/FQl6BfUEsvKx7TnjHlaJ1QtavRmzH42/p6XvcPSH9gDdtDOFh8?=
 =?us-ascii?Q?gkrPwDqDv9K3VkDqp9xlv3rdUmZ8fUyyZvEAyRqDkRQmre7HFN0q6qW+jwfF?=
 =?us-ascii?Q?JtXkvCvbSj2zlv/q5k1NESFqrn4/ljYAcHrujYoiELqX+KjTBaNPRAiGnpx2?=
 =?us-ascii?Q?npWd04GqIRovMHEkq62wHvH5JxZsrSIsL0dhH+UKj0UPX888yZB46Y4pgySX?=
 =?us-ascii?Q?m/OB3n5eplHa+0Zw6H15DnQ+6b7y5rDwb3LlWn22lg5es6iq48tRBtU2DMy4?=
 =?us-ascii?Q?/IrcVWfw1WxVW0GqeHWuvp6jrYggjH5R3uQCzhfjS5rtEtdXD7dVEA4KD8u1?=
 =?us-ascii?Q?LK8G75/xhRI5fAlkjHoudg62xVR9WkjUxC2YDdnNyDVY8UWBpFosJw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB7291.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: multipart/alternative;
 boundary="_000_AM9PR08MB7291EAE29871A06519E4E52283BC2AM9PR08MB7291eurp_"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7666
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 89f4a1f5-9a87-4ebb-dbca-08dd7da5757a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|35042699022|82310400026|14060799003|7053199007|8096899003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dOmTxATbB+ezcrj7K5jXa5xZpIMv90ZtLLDWP+mtryAROJg5gmvQwWG5+gHv?=
 =?us-ascii?Q?92juUx5DM5KzKkS491fFguedkyc4QWVWuWYkaILN3rng28kVHa97l/a+JcW6?=
 =?us-ascii?Q?dKrKe6Rts01eLwsKWzos8CKDeZVfWEcO0kgzZB2zjONxc4vwJ5rHiw/dJVhV?=
 =?us-ascii?Q?1vCx3PttcwXiJ7Y1FnRDAYA/1s7XmtmD6WszkXmC7IUT1OxeJnmty0xSD17G?=
 =?us-ascii?Q?03qSFsq92uuVKz9m4upXrmF3j13cqhVQG/xdRjPLqG853KFBAwP0wMaAsU5p?=
 =?us-ascii?Q?wo0z0/D9guDMp3DF6bwki8fbHPBGmk8GYHjFPc9PM6OfUHoWuFrdHZOEEOMS?=
 =?us-ascii?Q?LAi6jY+IQab+V8fQLYE65y0SYCbkaeACjPJGFkTp3vDn//775vDtURMpEppF?=
 =?us-ascii?Q?7Pl/E7oRenCOyTOjiC1Yi9DdfmB+JXlqSb6FT1dnsZNu+LxjF9v6omFuwajp?=
 =?us-ascii?Q?du2TvhSJ9icSQrv1dvT1gpUllzt1iRzVuYeH0NNP7dymCiWZ/fbdykUjdHPu?=
 =?us-ascii?Q?9qyVjSlwBjtIxH3TspdPsBCCECMQmUSijPpLSHBsbWkUeFTqO9zbmg29N32R?=
 =?us-ascii?Q?fOwLWlX0NqF04b6fRtAtaUiOjrLOtujOcneMeOCZEGZLGA/XsSWpiTbPVu/d?=
 =?us-ascii?Q?Q/IAhgxibe+YSSrPhxeGCvgW2swTb2zEVY3tUjzzr1U2gl0P/qIFENK3unl7?=
 =?us-ascii?Q?p4vn0UpSU1G/yW8Sx/PLvRl4i5pTlxyrGllHaCmqgFnKqvnlAjOc4lMiHnDt?=
 =?us-ascii?Q?H9GM5jkG/lKKOFzQMIrCbIRUw5Yt5LVS6mS1faqnPb2JVVEoE1JULKyoCMyT?=
 =?us-ascii?Q?5XT+S9OrEByPE1UDhm64rTqSAfiNmgYhcMyeKTMasBH5SASM0qY8VjsiH08H?=
 =?us-ascii?Q?KMRcFmV6fWLNQ0MJPDyaUk61xeQWYZCuIjd92jdw5w1LA0J2zs1efzR7wrK7?=
 =?us-ascii?Q?nULDBJVKoPzBbTSFUa4BL3oZmnktnl3o598yS2t/nIsnlKBwtw67z8ztshZL?=
 =?us-ascii?Q?MjnFnY4IOrpB1AoxVzL/w0ykMCXJ5rKsNIEU3Ezf91/Tlt5GQmZ3v2/qsagF?=
 =?us-ascii?Q?lqitX6DpYJbyuj2cIwPuL1w7+iKqG4yT4SAuQLNgB7xtzvtKMYDhKcYj5jI1?=
 =?us-ascii?Q?pG+oZYnYEV0VKwfKD0AZKn3hXhgHi09BznKGXT0MWSZLM3rAhxPxWnFaGhCg?=
 =?us-ascii?Q?2X6VKs9kPRf3hnF33YAvlkneFHnH4FKuSeYNE1ZObhN3UAxVA3G0eXVcNFDE?=
 =?us-ascii?Q?9zWhasLrL4UPZ6RSi8NyFL1leF+mhsoWkKZXDOpW8SlT3/rDFwPomcU1CA08?=
 =?us-ascii?Q?5Vvo51PC8tyZEyvLsbFtcPbLHRkUJck26RkNjhbvAhGDS+Rg58YZ6YF8V8pT?=
 =?us-ascii?Q?kupYjh+1OdFWEts4EknZGeO6wuBJWgflpKp8cNMoI2nSC905pbnAmTfSQCnh?=
 =?us-ascii?Q?NXNsf6DaTAbcxYB3wn/Y3ihiu5/E/MWdc917/My67bVmVSYg0GBEI8DQkpby?=
 =?us-ascii?Q?ZpV9CO2QrodhOY38kSHL6bljjEFy2TRf9Ijv?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(35042699022)(82310400026)(14060799003)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:46:48.6982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dc704b-3eb2-48ce-6dc3-08dd7da5898f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7343
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

--_000_AM9PR08MB7291EAE29871A06519E4E52283BC2AM9PR08MB7291eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Recheck-request: iol-unit-amd64-testing
________________________________
From: Thomas Wilks <thomas.wilks@arm.com>
Sent: 15 April 2025 14:09
To: dev@dpdk.org <dev@dpdk.org>
Cc: Paul Szczepanek <Paul.Szczepanek@arm.com>; Luca Vizzarro <Luca.Vizzarro=
@arm.com>; Patrick Robb <probb@iol.unh.edu>; Thomas Wilks <Thomas.Wilks@arm=
.com>
Subject: [PATCH 0/2] dts: use tmp dir and DPDK tree dir

Hi,

Sending this update to extend the use of the tmp and DPDK
tree dir.

Best regards,
Thomas


Thomas Wilks (2):
  dts: add remote create dir function
  dts: use tmp dir and DPDK tree dir

 dts/framework/remote_session/dpdk.py         | 74 ++++++--------------
 dts/framework/testbed_model/os_session.py    | 14 ++--
 dts/framework/testbed_model/posix_session.py | 26 ++++---
 dts/tests/TestSuite_softnic.py               |  2 +-
 4 files changed, 49 insertions(+), 67 deletions(-)

--
2.43.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

--_000_AM9PR08MB7291EAE29871A06519E4E52283BC2AM9PR08MB7291eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Recheck-request: iol-unit-amd64-testing</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Thomas Wilks &lt;thom=
as.wilks@arm.com&gt;<br>
<b>Sent:</b> 15 April 2025 14:09<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Paul Szczepanek &lt;Paul.Szczepanek@arm.com&gt;; Luca Vizzarro &=
lt;Luca.Vizzarro@arm.com&gt;; Patrick Robb &lt;probb@iol.unh.edu&gt;; Thoma=
s Wilks &lt;Thomas.Wilks@arm.com&gt;<br>
<b>Subject:</b> [PATCH 0/2] dts: use tmp dir and DPDK tree dir</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
Sending this update to extend the use of the tmp and DPDK<br>
tree dir.<br>
<br>
Best regards,<br>
Thomas<br>
<br>
<br>
Thomas Wilks (2):<br>
&nbsp; dts: add remote create dir function<br>
&nbsp; dts: use tmp dir and DPDK tree dir<br>
<br>
&nbsp;dts/framework/remote_session/dpdk.py&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; | 74 ++++++--------------<br>
&nbsp;dts/framework/testbed_model/os_session.py&nbsp;&nbsp;&nbsp; | 14 ++--=
<br>
&nbsp;dts/framework/testbed_model/posix_session.py | 26 ++++---<br>
&nbsp;dts/tests/TestSuite_softnic.py&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;4 files changed, 49 insertions(+), 67 deletions(-)<br>
<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose,
 or store or copy the information in any medium. Thank you.
</body>
</html>

--_000_AM9PR08MB7291EAE29871A06519E4E52283BC2AM9PR08MB7291eurp_--
