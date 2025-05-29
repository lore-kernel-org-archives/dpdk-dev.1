Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275E7C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 12:28:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B183402C1;
	Thu, 29 May 2025 14:28:58 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
 by mails.dpdk.org (Postfix) with ESMTP id 18A3F4021F
 for <dev@dpdk.org>; Thu, 29 May 2025 14:28:57 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BPJHS41HMHlqf3ZFyqq+vnIUwPbKY80lp4VWliT6zmE9lXPKZQePdapJF6bEqPLEu4GevP0M+kwoEUop6buqQ3DADWjBvIK8m7Cte6+VSrTJxBb/4+BCE6gRjAg8CuTerZnCw1/B+spc4N65YiEbteLhtL1gSEZMaTUOgVhMeJkcdndYDz3nyZ1s8cZ3i28pGDvy7AFsD33kXg7mhz3tJ3X3JX5qGoXgnxM/Eb9X1hVqEWcIGy0S+/0TQ0C8N2y0txDPJcQrLPjsOO8WT8cKA6BJBMTBzH1jC8+rE/cZ4kHj3e39lo0HLBF8EGfVCm8ocnT4Xz7+8wrDxrUTyqHwtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UpCwRR4Rwq0Ipk+O6vINRZUY4yz02BSvSjXwSWajJc=;
 b=QP1kC/oxr//6jQ1RO+Hnylmg0rJj2mpdOv90oocJEOzWCgZYSi7J01eErDl5S59OJiIN2CO2035R/9tqi3DSlp9HRc+Waw9QAuIQybCd1khKLpeQV/Oc2NVlwOAd+5XOaxPGqLyzbBxheAnFPtwcHSblD9mRCjMxm/VrAc/iRvCbU6f5kICcZIta93OPhG+ePCyixvagze79GncKdkMMI26+S73LjcShGl3ZRsS517vw3DSF0y17gBkFTQwQ9tlLU+SMgSdTR46VzYraR44pg8r3GpEMgMya1/xsDGy0p8naR4/Pj4NM0bV8uP0f9VVYCVbkdk+MH1nAfwr9wuv63Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UpCwRR4Rwq0Ipk+O6vINRZUY4yz02BSvSjXwSWajJc=;
 b=qy6Q+jxSmvsahcS4tyTXkKU1fB0kZa/gQsRWwhwIgTusJG042w84PD55olPyzMi8iavSIl+AH1I1TtXTELh+B0/4zz2cuH+VnPdxMLa7Ipj4yv48udSStojcCJ3McMyFGtKy1Gy2X/rsoP+iYFMbb4y0Od5aZnlhrMiaGoZ+LLw=
Received: from AS4P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::20)
 by AS8PR08MB9953.eurprd08.prod.outlook.com (2603:10a6:20b:635::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 12:28:52 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:5da:cafe::11) by AS4P192CA0012.outlook.office365.com
 (2603:10a6:20b:5da::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Thu,
 29 May 2025 12:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Thu, 29 May 2025 12:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0c34YWXG6bNYqFZtwjbiV0qxozXj6y5iK2YOHDLxc14ZBlpYBYe/+8JSjctDi6wgAgC4UEmR5rdWx3iOLOVgJG+j8Clntyo4U7U8Qi3JoS/tCcG9jgsk8fKXwKxsS7IHLvz5QSak2+oBj1KABKujK5HmOYOBgA4MgxwVEsM+JsGkQ8g5ODO19eZVi4fxEX7tLBLbJyYkP0bpYzJNHgFuBbFu1XUE8fr8YdurNFGXXqSVz2sZLaL5k4qM3oaNuRqfDyCPnUFpLBVh0e89cABWc8bszOJDQd9z9WDRi4x/C4cFv2Q6jp9J4hXMUsx5yNsEi478HX57s3U1Ij+To7n9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UpCwRR4Rwq0Ipk+O6vINRZUY4yz02BSvSjXwSWajJc=;
 b=zSIfe+E75XLNCGD29TvLyWrG3t7VfXmiHqlIuXMSFrtMNRS2cy0CDBiodrCKNHnvKXbv1oC/obqWb1QpCfHYwcWASzjspWRaqv/Ut9kh4ZsC6vFWX3poBIcsMMyt/4/f1g45FsobiDaBc6531No5Nm5iBGfhF2NcYOB2UwCnKIQV2wJXn7PEYF37+trK4snBPZ0ycJkxH30lyu2iw0a54n1g+PnUEq8QmCX4o+2Om0++qo/c4ZgpkjIxIAjRlGPA3E1Iozj6TsxTn5HSvi1S/xFsvN04b1OL7NFcmkO+aO/DpnsTDEeij6xPFnxcCtVlFA8k87c+CorA8sx5c+rNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UpCwRR4Rwq0Ipk+O6vINRZUY4yz02BSvSjXwSWajJc=;
 b=qy6Q+jxSmvsahcS4tyTXkKU1fB0kZa/gQsRWwhwIgTusJG042w84PD55olPyzMi8iavSIl+AH1I1TtXTELh+B0/4zz2cuH+VnPdxMLa7Ipj4yv48udSStojcCJ3McMyFGtKy1Gy2X/rsoP+iYFMbb4y0Od5aZnlhrMiaGoZ+LLw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16)
 by AS8PR08MB5912.eurprd08.prod.outlook.com (2603:10a6:20b:29f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 12:28:17 +0000
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733]) by DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733%3]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 12:28:17 +0000
Message-ID: <b1bd3025-db4d-49ea-b80f-dc1e3fb74a4f@arm.com>
Date: Thu, 29 May 2025 13:28:16 +0100
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, dev@dpdk.org
Subject: Re: [PATCH v1 3/3] dts: fix doc generation bug
To: Patrick Robb <probb@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
 <20250527153734.368235-3-dmarx@iol.unh.edu>
 <CAJvnSUB1cU0kzaAsLQv57y3Zbmp70FkKyK0BGBRg8Qb6m7Bs9A@mail.gmail.com>
Content-Language: en-US
From: Paul Szczepanek <paul.szczepanek@arm.com>
In-Reply-To: <CAJvnSUB1cU0kzaAsLQv57y3Zbmp70FkKyK0BGBRg8Qb6m7Bs9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0042.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::6) To DB4PR08MB8151.eurprd08.prod.outlook.com
 (2603:10a6:10:381::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB4PR08MB8151:EE_|AS8PR08MB5912:EE_|AMS0EPF00000193:EE_|AS8PR08MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd8d13c-0432-43b1-887d-08dd9eac5dbb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?akZqWFFoVHJoamkyTEhUMUVjZUVycWFiV1FMRXVjU043a1NPMGdnS0hOemhx?=
 =?utf-8?B?ckFhQ29HVFZiTUtzSHFlQUVpbGx4aVp2MlJpeWFTOGl2bnBIdVNwSDVJbWEy?=
 =?utf-8?B?V1FMbWNndlhnSWFycHZ1MUg1UUJCVGxhUzM0dzFRL1dMQSt1eWRENlU0OWU3?=
 =?utf-8?B?MkZ1dWh1Wm0xcXlUMzZxd3IyL1NqT1p3UUl1WUJzOUdFU2h3bW9iRm5NeWJQ?=
 =?utf-8?B?MEZhTDJSTTBKbmdIdHAwaGdtQ01SSU9hQjRlakV2UU1pK3BVK1FMZEl0SUUy?=
 =?utf-8?B?SXM0MUdSUDN5RzJyQVNJWkQ2Q1kwcFI3OE5jeHF6cHZmNzRJYnUva2xwbUF2?=
 =?utf-8?B?SnloSytELzU1eGR2WkVYdTlQSHdoNngyeCtlL3dFZlZSS1FwZHRMbWpTMktk?=
 =?utf-8?B?SUkzUkwvTWExNlFBczQ1a3lmSFlWajFEdUVuYWEvd1ZlSFJUbFlpeW1UMzFU?=
 =?utf-8?B?aVFvQUxwMGRDK2Q4WEIyWFU4WGFGbDI3UWF0cjFPU05sV3B0MDZET1ZtcEZp?=
 =?utf-8?B?OEFmWjZuOVY2bzFZM2doYk9CeG1xeVZXS2Z6RDk4NjZpTXdoc0dpdlNuLy9H?=
 =?utf-8?B?dndZc2xlZUduSDNBLzIzUGVtendYd1Jha0p6WkFsVHhMbTFzdCs3SlRkRlQ2?=
 =?utf-8?B?ZFFxbE5OYjF3TzlIQzF4bzNkQVBLREdLMkY5YUNmVC9ibGJhamo2UG5tSDlI?=
 =?utf-8?B?QkpobUNNazFGK0ZMK1hyamlzL2dvY2VsQ1lxUmFvOWFTajZMNXNEdUszWHUy?=
 =?utf-8?B?cUliOS9pcjQ5aFZ2dEFHN1lrM2NBc0dhejNFMWUreTNoVzhQYklHUTgrekZC?=
 =?utf-8?B?VkI2dVJoQTZNK3ZxbjhkMXJ4RENRdWRUc2NJUUkvL0hkekZwbCsyeTNQbTgr?=
 =?utf-8?B?V2VZYXJ2ZmJyZC9vazQyQkdTTWttUzVRUExaVG5kY1lnYW1TZ2lBUEh2ZTl5?=
 =?utf-8?B?Sm1DK2JBQmZRbzJ1Q2FKK3YvMytjQVltYVAvRGt5STV4YW5Yb0FWcEppUGFU?=
 =?utf-8?B?a2dGQ2s3YmxkdmxkTlFJcHlvUG9aQWFwT1FDR0xNbGU1RzJyOHNrQ2lIM2o0?=
 =?utf-8?B?czFUczIvMytqdDlCaS9tZVpWV1g4eUdaR0V2TmU5RCtNV2s5cE1MeEhpMEpZ?=
 =?utf-8?B?RjM2R21FQUt5bUpBWmxaUEREbGdpNWxNM21YanVIRHBhbTNUL2xtUHNpZm9l?=
 =?utf-8?B?anYzYitQRDRteFBJbCt5TndKZDlyQlN5bDFQYVNlYWlBUHBUNURLZjJyNFZQ?=
 =?utf-8?B?YWd6TURDbnNnSkF3cFFUSmVydy9xaGdFOFo1dEczQ3J2WWNzVE1pMWcvdGk5?=
 =?utf-8?B?Tk9BUjZFaHpxSnNBZEsvT05FOTdRWjV6MFpsTlQrSWVxcXdybytGMDVKelNt?=
 =?utf-8?B?eEZBMHFvYTFodTJGU0c2NUVTcURhc1NzWXJmVnBobnBHRDZiTmlrbHEyVE9z?=
 =?utf-8?B?WU9WVm4xOXJKY2tLT0Q5c3YxVlZEdG83NTNGb1ZRZmU0cFVRV2o0VUpkUTlN?=
 =?utf-8?B?MGx0bGlrMjlsT2wrYXhkRDRsd2RHbkYyR1VYTXRibTZ6S3BBYXgzTTB4NXpC?=
 =?utf-8?B?RHNSYjJBSWFvNVhGd051V2E2bVhqT0NmUVV1YTlMZnlKVkNCcCs5b2xYNTNt?=
 =?utf-8?B?cG1oR0JuZFNBQ1lrNFRlMHVUSmxMTmxFZjU3M2xud0l5SDZzVDhzMVVFZzAy?=
 =?utf-8?B?YmJkbzl5N0RwV2F1VmJzY0lTS1cwWkp6NkNsc0UyTjRXL1Y1Q0pQSkRYWUhH?=
 =?utf-8?B?WW9SSWNEd1M2NDZ3UjJmM3ZIcWxHVWJ1aWhYVHo5eCt1NGpJM0xZNzVYRFI4?=
 =?utf-8?B?c1Y3SXFHUUhvU0JRUmFFdUErZUlzZFZxVEozeDhxVGU2VVpVZU5JQnRYVzRU?=
 =?utf-8?B?dUZ0NlZzV1c2dGQ4S0ZURERIbU8ySVhZMEdMQUd0Z1kvekxtakdZM3VJL1JI?=
 =?utf-8?Q?MR/2ZbBj/Uo=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB4PR08MB8151.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5912
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e1a8c860-9738-4d53-4cf4-08dd9eac4a37
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|14060799003|35042699022|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjlZVXNTRG0wZnJDclp3MFI5UU9jYm81elpDNVBNRkhzWTJvSHNOeTdpSVZx?=
 =?utf-8?B?ZnNXVVpYWnRaV0JzbnVObC94SU9vdXBZMTNGdjB4VTFsM0pjbUNFeG5maFVR?=
 =?utf-8?B?WTk2SnhsSUpxKzVjZ0g4QWNNaUttUmhFUGlzQk0wL2VjSnN5a3dpQktkQzE0?=
 =?utf-8?B?QkVsSWJhTkNaSzBvOUZxTUt1ZEluMTcvZzJCSDkxRHdaRnRiaEJBU1dvakVI?=
 =?utf-8?B?NEhNazl0NUFTb3hwbWgrbko3OGRuT1IvVzloRFZuNTdLakZ1cTFtM3kyWmh5?=
 =?utf-8?B?aUI1M3cwNDJtc2FjdjBkVGRjd0NSUER0QlBIM2cvaTRhb1lLL3BUdE5WeTJr?=
 =?utf-8?B?QkRRODd2UWtEOVZUeWswZi9IRUI5amZ6SVFtek9kYmliMTR4b1pUNVdhNEdv?=
 =?utf-8?B?RTdraU1BbmdGSzZEekhHTDh2cWdHL1lCK3U4MHBqditwTFA1MkYyVkdORW8y?=
 =?utf-8?B?c00yM2tWSUl3QzdtOVdFOVMzYnNOdjFjdERHUEkrcU5iWHI4eDlTMjVtc1kr?=
 =?utf-8?B?NjhPdkxHQnAvNFdLKzRhdjkwZEErWmlqOUE2SXlCZGVIWHdpS2VzZU40Z0lM?=
 =?utf-8?B?SGNBRlNMZzVPNEw0UmpIVFZkMUdTMzllMmI2WGR4RU9Ia3haNzl1U3B4RWx1?=
 =?utf-8?B?MzJiRS9vY2Mwd1pOSVlrSCtBbXllRHFRSm9NYlBPVzNEZWFDTUdHdzJDUG5u?=
 =?utf-8?B?VTFseDU4ellWT0xzWVk4RDBDUzd1NExnNzMrTDlzR3ZtVGNyTm1USElrc2Jj?=
 =?utf-8?B?WGgxbEEyRHRzeGVYcDN2ZHJ4Z252aDRDU2xYbSthRnEwc1BXWC9wMWgxS29i?=
 =?utf-8?B?SlZ6ZGoyNE4wTUdMTnhTQWI0WXVwNHU4QWhOVXd4NE1PdEJZeXNHUnN1T1B4?=
 =?utf-8?B?VHBHQis5Z2tQT2l5MmdHb1dPLzd6MnhaS3Ztb1B5aUpXL0dlL20zcVdtaFBs?=
 =?utf-8?B?QVVJeEhuU2JvWG42Y2dHR3EvSVUwcGNsUTNWOWF6TWtwVThzdjE0alVxd01q?=
 =?utf-8?B?MlhJLzFyeUxZYkdnamhzNUZCM3IrRXRTbGhvQTcrRi92VXM0bHlMZWVHSTI0?=
 =?utf-8?B?SFg2bkZZSEFyVzNKVjNWeDlEV0tDa3BvQ3JYYThGcmhyVGNyZkt5NERYeHo5?=
 =?utf-8?B?UFd6enNLdVduaGw1a3Vmb1JmbGVCQ0lFTi91NFJjd1pOajN5dmR4WkZ2ZkJp?=
 =?utf-8?B?aUtxM2l0b1dNZW9GcXkwQ2hsWHVkNlBoaFZIaWl3aldOdG1QODgxOWVKY25m?=
 =?utf-8?B?T0J1RkZJT0VabEI1VVJTR0cyZXc0RS9lZ2Zqb1ZGaWovU0VWV2M0d3Fmc2hY?=
 =?utf-8?B?eU9TWTArMzVsbzZQazExazhUMWF0eFFRV2YzWUhrQ2JvZ24zV2JWRmphU1hR?=
 =?utf-8?B?ZENkNVQ3N1QzYkY4UXNjc3c2S2ZQYUpXYk1iZ0FNYmozV0NXVDI2dlhhQzhJ?=
 =?utf-8?B?WlNSTlQzTC9qVFp1Y1dhc2RVRHZ1aW1XQmZDVnpkRFplbENmdkl3KzR1b3U1?=
 =?utf-8?B?UGNVbkVUNjgwVU5FV2RPazk3YTRrM1V4YjgrVWxMWklERVJVL3ZXNTJEOVo0?=
 =?utf-8?B?c3ZndjhROFlrandwSjByUTg2TVZaNjBIc1F4SHV0S2swUlVUWkNHbUFwVEtM?=
 =?utf-8?B?bGg0OEdsVFJNemJYM3hZdy9rTmJSMEFGdXhpYncwSHJISGJmYlpLaENqRWF4?=
 =?utf-8?B?UDk5UkFocjR6Z1p4b1ZZVlN3N0V6VUUwN0hTYWFPNmVFWk10Q0RiUCtldEE2?=
 =?utf-8?B?cENiTHhreU56aW5GbmNlbWxJZkF0NHUwWDJiQ2ZQeEVHUWJRMmFKbTQ4Zzg0?=
 =?utf-8?B?YkhPbW5MRm5hUFgyQzVRNnQwQWdzZkM2VFlvV1hzMzVpNStXRnNoaTNVcVJq?=
 =?utf-8?B?Ny9tUjEvbzJlWmhUTFJxQ1VJd3NLdDlqc1YvUm1vSUtua3ltS0IvZkVkYVJ3?=
 =?utf-8?B?QzZvT0xqQk5RdjJmMVI3ZzVOVk82ZWNaaEt2YWxzandycGdjTjUyNXhyckhq?=
 =?utf-8?B?VjAxdFN6Vjh2eGRvV2JUL1M1ZHRQbFFHV25keUFiQjJjWXFyeURuVlRwcEpM?=
 =?utf-8?Q?C0uAHK?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(14060799003)(35042699022)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:28:49.9780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd8d13c-0432-43b1-887d-08dd9eac5dbb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9953
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

Patrick is right but it's OK, I'll merge as part of the series - in the
end it's a separate commit.

Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>

On 28/05/2025 21:28, Patrick Robb wrote:
> 
> 
> On Tue, May 27, 2025 at 11:37 AM Dean Marx <dmarx@iol.unh.edu
> <mailto:dmarx@iol.unh.edu>> wrote:
> 
>     Fix a bug in the port stats check test suite that was causing
>     the DTS doc generation to fail.
> 
>     Fixes: 8f21210b1d50 ("dts: add port stats check test suite")
> 
>     Signed-off-by: Dean Marx <dmarx@iol.unh.edu <mailto:dmarx@iol.unh.edu>>
>     ---
>      dts/tests/TestSuite_port_stats_checks.py | 13 +++++++++----
>      1 file changed, 9 insertions(+), 4 deletions(-)
> 
>     diff --git a/dts/tests/TestSuite_port_stats_checks.py b/dts/tests/
>     TestSuite_port_stats_checks.py
>     index 2a3fb06946..491c2263b6 100644
>     --- a/dts/tests/TestSuite_port_stats_checks.py
>     +++ b/dts/tests/TestSuite_port_stats_checks.py
>     @@ -51,10 +51,15 @@ class TestPortStatsChecks(TestSuite):
> 
>          #: Length of the packet being sent including the IP and frame
>     headers.
>          total_packet_len: ClassVar[int] = 100
>     -    #: Packet to send during testing.
>     -    send_pkt: ClassVar[Packet] = (
>     -        Ether() / IP() / Raw(b"X" * (total_packet_len -
>     ip_header_len - ether_header_len))
>     -    )
>     +
>     +    @property
>     +    def send_pkt(self) -> Packet:
>     +        """Packet to send during testing."""
>     +        return (
>     +            Ether()
>     +            / IP()
>     +            / Raw(b"X" * (self.total_packet_len -
>     self.ip_header_len - self.ether_header_len))
>     +        )
> 
> 
> Looks good. In my opinion this should be a standalone patch, since it's
> unrelated to patch 1 and 2, but it's not functionally relevant since
> there is no such thing as a series in git, so you don't need to
> resubmit. Keep in mind for future series though that they should be
> logically grouped.
> 
> Reviewed-by: Patrick Robb <probb@iol.unh.edu <mailto:probb@iol.unh.edu>> 
>  
> 
> 
>          def extract_noise_information(
>              self, verbose_out: list[TestPmdVerbosePacket]
>     -- 
>     2.49.0
> 

