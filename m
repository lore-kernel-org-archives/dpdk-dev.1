Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1457C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 05:22:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07444402CE;
	Wed, 12 Mar 2025 06:22:10 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by mails.dpdk.org (Postfix) with ESMTP id 4BB7840265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 06:22:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbQQtWw5USSFVocWZLjqzbClrr5DfTXJQqrvOcBCTL/fi0dgOM0TbYmD0y/nc9ytk1rkHbccCftLPSiQVzpMBy0F18SmMcexaPqbCaxRKa1FROygGz50Ml6lEmJVjbpRp0r99xYZTBHWkuqvtnzxTszEXcY5pat1oOy52+CppD6EGOcIdq3OMomqoalZcmBWnvH+EGAvuJX5l9cUnLJqEZoryepp/e62qeurH4K4OGnjmMnBt9StlQDVRAjDa/5hQsB0aiKXhM+9Z2fgf5I5QdLOmjLLvqjUrYt2S5F+0wwZjOan7+gLJw/5iXoLKXbkWsMli5xLSefOaqjPtpVKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNxf12dRjianhNmK25Z8J9CTpXdK/GTGcShDnznNMEU=;
 b=BQYe4xT5OlCcs4kdWC/BusP9y2do/39y5d6s3EDbtTpCWQvXAP+YztSSTn2pJqVrIfodDsheypG8RCqyuR/SiuHbMo8a+H0/pyng0+GO7B2Du26lGz4pt2siz0U8Vp5DQWzJmnm04Fk9rOljnQvo2BqAsWBa/lOia5ByPjkzSha0Skj83EqKPIfmw9lvJ3D9NmXjSadFJxBZKYsElOhZolQpZPfacbooRzz0SMug1kNQw9HAlQerDkqMf6y97zdsuWBBbCAxffnChGoAA0K/1xnIykO/dCvjvHTtrrjS/oGxWPAww0pSNvnydoUuczybjSfkwpNYuK1Q8tOmv1eNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNxf12dRjianhNmK25Z8J9CTpXdK/GTGcShDnznNMEU=;
 b=BTVKnPFM6KlDBrYXhxYayFu02WC8he+9vMCtiwNvSNNuraJ5u0bdA7uDhdXvRrF59/ngduw9N5uA7NGYFg7Oz9sLH5cMvA+ppK7nCsnwBu10ODU/pOFYWrvScMLmqKPdaAuHlkilun6Xq4MGea1UUPXDIWxR8x7ucGlayAjnUlLGMpyGDp069tgw+ERdAxoSEj56b7FghGdqT6ZUMojwJZ+Dr0Hqo9xZ74G7fpqquIW/DfAp6ScAds3PsdE8KIq7Cj45fint17Ay7oYTKbGW5/HBMJu6eSoYoWtnqo+u88v2reOmXGhavNSaDLCyzRSfK3k9GF4ifoeYj3GbcfZ4aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:22:05 +0000
Received: from PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8]) by PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:22:04 +0000
Date: Wed, 12 Mar 2025 07:21:59 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: "Etelson, Gregory" <getelson@nvidia.com>, 
 Igor Gutorov <igootorov@gmail.com>, dev@dpdk.org, thomas@monjalon.net, 
 mkashani@nvidia.com, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
In-Reply-To: <20250310083122.7088ec4f@hermes.local>
Message-ID: <f0806520-a131-fe09-fc73-3dfebeb375cc@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <CAL7bPf2ddD=Hnw19uO-EzBBYYZz2vYUKxWapYoYK9Qqt7wdbfA@mail.gmail.com>
 <a850dee4-a7c6-8173-2285-22c36292e182@nvidia.com>
 <20250310083122.7088ec4f@hermes.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR4P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::11) To PH7PR12MB6811.namprd12.prod.outlook.com
 (2603:10b6:510:1b5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6811:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 76472d34-dfd8-4fe8-f4e6-08dd6125d374
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oLXjYy5N5CWbUQC4b4nBRzXO+4/8yLkuMttMK+ft0oiM78vKXAUNS0EsI39k?=
 =?us-ascii?Q?UyETeROx31iKvIYPYaMmxYnHypQHtoZU0kIHm2X/dWhysswqSY0FCRvbD4Jy?=
 =?us-ascii?Q?dgxPjaRPtPoZ/N6g+nii0e8s0JBHm/AQniwEPtKgaINjQRGNi7TFZvBBObla?=
 =?us-ascii?Q?Ppydpp2CzXn/jXE52UNwdn65jO3U+CMyBULrbRK2nEDJ6iIST99pZi+03oGg?=
 =?us-ascii?Q?0dZqJUWd0xZcP2YtutkczmMhYA3Qrg/GwAiyBQKn11MIPOHrHd8jaVacHzaW?=
 =?us-ascii?Q?yDwan2KNwkHRveF0mFuveO32I/mfvBTJEx3e/QpOlMxBdxdkvWOP2wKib6Xx?=
 =?us-ascii?Q?wi1UJSPHrKMAMdedjiGNf2lBMpp7o2UafWKp9j1SjtvJ5phQIaFA0B93gKCz?=
 =?us-ascii?Q?ZeKtBezAGSdnHp6dnVakYgCo4u90rfvu5RgoDyuw2kYrLICDBmogV3jZjTuK?=
 =?us-ascii?Q?SxlZ/s9GI6ty3C4WECBb4lSaAYMgEqzzAzspv1230o0zw0c1N7MAse5RJppa?=
 =?us-ascii?Q?H4tlP6IzpQWPVX7xs0P58TUziMN6ED3HxZxVI72WEdvon23zG2hbMoJ/tZYs?=
 =?us-ascii?Q?nr9g4aincr4oMGeQzQp9rKDLum7utmDu2DR3eFzRttkUnb0KHYDtqAGqPpLz?=
 =?us-ascii?Q?9sMbZK32hKcqnUGPmiPawUcYogCyAfrw2yCUDF6FGE/oiIxc62WRiXBp9HRJ?=
 =?us-ascii?Q?6LFitygMTbR2KNYqGqONIXA+udYPC07AaLkDO6wkkNfemAy4DOxQaOJTBGKs?=
 =?us-ascii?Q?XT0kVy38Mlcgfolh2JhASf27zdwGKO4+qo4AebCkF4bxNryLFFQLNmz6rIOF?=
 =?us-ascii?Q?YxmyCQyAdr1JjiZpo0BGzWooAO5Q1XWuXdMwA/91s/KrCQp5JUaC+k55mkZA?=
 =?us-ascii?Q?GFC2v+6ML/wZWXJXpT4esY5tJuJtLDpfEebBR7HQJnJS+pkyiYSm95+gn12f?=
 =?us-ascii?Q?ymEXe/Ocg87vtAAGIx4IWgx3jfLQzkxfaj3AiQFETFmg4OY1lzn3Ku7K4VLm?=
 =?us-ascii?Q?ueOuXkhnIS7b/y83NVGCOv7wpcOAGjtNXZT8dF+jicpKNzQDFnaQNXQxYcnc?=
 =?us-ascii?Q?iHLCIL8NXxsi2Sna4K3Vku8MZAuCv1JHcGn2M6PoajjiS9I947wK2iF9PMKf?=
 =?us-ascii?Q?/WvEy8o9qJ2UOVppKFjBQiFfQF0OtbJ9K8Dc8cK77GF3xusa1DP8PZm/mzAk?=
 =?us-ascii?Q?gJXv8bMIFD185unMY0BH0HT+IT3cdui3RPYy6s2Q1TnS3YRMZgdPbHTKx5yw?=
 =?us-ascii?Q?FB9QXCKzK0Hnqu/M510RYT7gytY0Rz+PVSjpSQdbz33vWPr0w0HCUi4I8iXG?=
 =?us-ascii?Q?1BVV+o+rNRRFG6XTt1Vt+L4qhqVWVeeULDAyIy3tQw5EY30VEa1xoKOZSo9A?=
 =?us-ascii?Q?It82F1boYNDYtdCrXHJgLLO/oitH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6811.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+fLNDnBjXU8JZjZDhf3K07nJtNZRnpFooYv87zGztHPqyZDFdoVwJckO66l?=
 =?us-ascii?Q?9VUZvAiUgxTyYTEzBodfiyg8eJtw/fAdtobjYu6s80fZrS0UNbNJ+hXPf29m?=
 =?us-ascii?Q?Tv7cQu9xrrAfAwnyDeA98c0sobJI35ZHmywRoOdnkZD3tj8XpQnGG8PbB9J4?=
 =?us-ascii?Q?kNPhPeH8aX8iX5hWdFV6NQlfFm5tlvRAr2SkzG0KCPJ8e/ue9i3A9jwu3p+k?=
 =?us-ascii?Q?AGeYNa7Xgzvk21ynbbi/tqdKXU6L31gjq3LsE1RofTqE9BAY+Y7fizgVUnyW?=
 =?us-ascii?Q?E4jf8FxPY7fkMd7QM3PeZQf+/HYIOpwTLvqUdF+VG+BL5pSOoM7Q8CemleFF?=
 =?us-ascii?Q?Dgv29JqTuQLJyqmiTnRP7TbWt2EA8b9ZWjrUbG6T5mgQLDJI5t5WVcWshLBk?=
 =?us-ascii?Q?OOyjt/1TtCDxZZjaEjglF/t2bEkmcX5E0ERbreYtAu0GRZ39/mwM6REURZGQ?=
 =?us-ascii?Q?c/xVKGJc0YMTWILPDs0j3KNVoCoDeGkLtNAsk53HbKEEJryN7uzCFeW1TjMh?=
 =?us-ascii?Q?MzTPPrWBcmiGdMfrzlKI6c+/k9ryND7S3CmLvzdgwOnfUUy324ntrKhEjJVH?=
 =?us-ascii?Q?t1CIUA2gPRl9WDof/ehbQMMfCUQ04aBplBMic0kYaTYQaJUKVfifZ3tUCxlt?=
 =?us-ascii?Q?KWP1Mo54/xc4Dpik4wCidkoStxtM/sJvryr6JhcPxr49gl7dXXvQZISBAyqV?=
 =?us-ascii?Q?XV0IL/0fRxijoliD4gi5r++4NFbVzlHxTD70N6yfW1kuqPksfj42vlIQmy6I?=
 =?us-ascii?Q?IyY8c6KbuiyFROfbKRsksn9/iP3aFgLZMtqUYva/QEuUCz3VslKVKEEswwsk?=
 =?us-ascii?Q?Jui7xvQwwgLPGQSJjAlfjU0E1nhbwDnTHCTi6799/ECX0buXiY8Y7EjKY9xP?=
 =?us-ascii?Q?ay8C1fyKkhazxwm7t3lvvMAvaVr6mqEbPCYzCeNwdGdLIwK6Xs+qEQPHdBfg?=
 =?us-ascii?Q?EpzBLYF7tbwIrYBU5qoEJroZW5ERCnQvm3slNEbZYvvSKQIOWHVLytpnSOQ6?=
 =?us-ascii?Q?Hk9VpQZGW9nF8M1vlAokqACYaHb44pOv3Gy3AblZrW6YThjswlFEn3UDtlQi?=
 =?us-ascii?Q?AGzNKf7HNa543z/QgN+bfIRCa8viGPmWxGbl81oF/pJDHzMKwrqzWJ9VM7yU?=
 =?us-ascii?Q?y5Q0p1DHTYv/NuJnTcnoSWzyNg788xngLEPogX53j6b2dPgEiUmx+o7XlhQS?=
 =?us-ascii?Q?qBWVHbm2tSaxVaQ5grEj58yC1LGJIZZ9x5SoVOP87g6OQhPBWDPBGukU6TEF?=
 =?us-ascii?Q?/7D6+zD/sXH2oFmA3LbpBBsc4VxZ8KlwFcTX6SyHHikF9fcQajiFiuCMmNM/?=
 =?us-ascii?Q?f+xKyII4yH+abVi4MuWiXHLgqvShJzlh6/ABOeqgCQyF5ajfcjtiCLwT1a84?=
 =?us-ascii?Q?crgeIgow3Z0nRbAH81oXMlBv2qrsLRTvOVgF2ZSqxMO9j86beU2fHj55JAki?=
 =?us-ascii?Q?Ef/vBf4d9Md2F7jN4VsFhl1myGiC6eGssD6eFwET4DbuEua0w1xwyNBcmP5X?=
 =?us-ascii?Q?AwRBns6ce4mTAi/DuTawFkt8oRW5ldQw+f9SMAuRLKRUYBlrKbMjw8i2rfgi?=
 =?us-ascii?Q?aA2ZVu1AHIX5jbgebPeI/yQxEjYCVJLfT4X8DGhgZqx9RBBMuFSqG3gVf1Qj?=
 =?us-ascii?Q?7A9ALstGdXI6AVD4mvHP8n3gEWF4lfWaen24j0KKeLVQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76472d34-dfd8-4fe8-f4e6-08dd6125d374
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6811.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:22:04.7689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDVYZXSPi7oDG2TqIj9rS0H8sufwppjUT590M9mV4J/2SIRfkB8o5IVmMqHTq4hvcJfESosXjtsp6XDu+SFLaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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

>> There is no DPDK API for RUST yet.
>> My patch  allows RUST application to use native DPDK API.
>> I'll adopt you coding style suggestions in the next patch release.
>>
>
> I have same concerns about rust in DPDK as the Linux kernel.
> What API's are we going to be covered?

The plan is to convert API in demand -
according to RUST applications coverage.

> Will new API's have to have rust support?

The patch converts selected files during DPDK installation. 
All API in the selected files are converted.
That procedure automatically covers all API changes in selected files.

> What about API stability?
>

The raw module works directly with DPDK API.
It's stable.
