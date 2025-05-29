Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95616C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 12:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61FA1402C1;
	Thu, 29 May 2025 14:27:50 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013027.outbound.protection.outlook.com
 [40.107.162.27]) by mails.dpdk.org (Postfix) with ESMTP id 9C0BB4021F
 for <dev@dpdk.org>; Thu, 29 May 2025 14:27:48 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LjemuiRyOBaNgQB0dIDp8Hz61+/prvLnk2Jc3ca2pe3PD7h8uOufNxDDMX7ZInXpxxZEDD9jA0FfwPqXozHJItRruQvwKDQhAsolBGmDrIIaQ/XGn4v3VwJrLGaHqOg6CJVrw6bWzlZWH4R6otg9M+13ixkKs05g3z7XuQXHNq3ARpohS87XkjcpbINh4TP2gKqeRngbZvSeUTrqcGgWO4aVG5kNLz92Rqmfo6REXffgWxKFxOvzaBwiUMI5lXyJqg4Yf8Z9Kc9t3/KgqEH2R50m8PjW2bjD+oHULY8OBt1sT2g+/W0wDF52B0ckogL87Xf++rmuvNe6oGVhUP+npQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scFD7c9C7HiyBHPQOrZB1yTqb/mCAsTDqhgR0Umj+mM=;
 b=oSBRMBA/HyAQUPR/aGza3cyYXDRmLBW/LAwP4ZjoNTQ8MGXLsw4OtBp1iEFAKGcGbSqux106/hVGdcKIjylMzxX0cm83LUJfzeg8J63ivCQrn7Q5tAjlexUZfhP0Pi6s2tp9eKAXrgzuPA8mAD93spKpFCE/Mu5LPbmR/Kg0DzTnZ9z7joV2FYgakJ1k4kWK+mavQNo6BXDktgT8iEOKWwBMK4yMJR7OOA5ffbtSRc5XkYN6ODPnPXllaEyKSJWCxl0jbbY5BSOn7aiD7ckcQOjoo/ca04YXR8LltcITPQe4pitW2Ctupq1YHjdb8bhVne9M+TcntPmLqmUQRr4AiQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scFD7c9C7HiyBHPQOrZB1yTqb/mCAsTDqhgR0Umj+mM=;
 b=LsR+dwW1PvXJcW7W2XSs9V2SgpoHz/pxjb/4kxgbhdJnXCZUWG3MjBWWoit3LlOYEi46FC9HD6Qu16QdmVj98QxR0NU7DMy5d1U2D1KUQJidsXKmDlSXhAyps3qOLQrNj/xc1jUg/4wHKW9QwhAG3AL/fkqMSjSwt0THwf+kITA=
Received: from DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) by GV1PR08MB11051.eurprd08.prod.outlook.com
 (2603:10a6:150:1ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 12:27:43 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::f3) by DUZPR01CA0030.outlook.office365.com
 (2603:10a6:10:46b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Thu,
 29 May 2025 12:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Thu, 29 May 2025 12:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QofAE47jzCGFN7Rs4moGlX+8RGTBtUUR/6BnjNomZZB2UalOHz8Buvd/ONDnWIGXxEzLMaviYOr+heUiru0nNGQmNdi/4b8Uia3US/SwPvvpBLuCDkGK0Aor5IyRuew2kzX51LbNz+oVC0tmMgSSzyFAkSgnQP0LZdVgYRn6GVoW5UY7bNbakoHCxxD4byT5ZqiwyL2N3qZsUgjZBGAzIiSzlylcc9sOUp9mmYBGXU7KrVq/nKAG//3kEmN+lb5qkbaaFf8QLgYW4Vl3jLFFzMzczKpA05cKDyUOtpq9GD+g7Rr8z1KpYQIkrXFFlwF/qEUprYE9urNO1mpYmJ7jXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scFD7c9C7HiyBHPQOrZB1yTqb/mCAsTDqhgR0Umj+mM=;
 b=lnN6rSTaZD6nVmm33g+6pTXN0Ka7gd3wQW97DDcRauDsyzhTi+ouBXJ+RVL5JzRBIKAaV2yNiM7S5W5pZd1sbMypimzQudjSqqmo8LDLVnmTFX1uXfmVvkUMeLpgvYNAiJzi+Cy2ggz1aop+0CghOKlVBew1DQ8K+LghKnmfCmNQ5dhmuTPPcuIx+5OMpRL49djYvsj8c17UiLM34zmXUPyq36AmhkE/pwSskTIo2aiEVEn4Cs9eqULKBUYbPgZGkLeH+7PJpsPql80orPtomPMoYcNUyldb3BuhqggU3hpIOnLRw6oay5eWlIu2HULgRph7fWcAX4eYpAYgGdsH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scFD7c9C7HiyBHPQOrZB1yTqb/mCAsTDqhgR0Umj+mM=;
 b=LsR+dwW1PvXJcW7W2XSs9V2SgpoHz/pxjb/4kxgbhdJnXCZUWG3MjBWWoit3LlOYEi46FC9HD6Qu16QdmVj98QxR0NU7DMy5d1U2D1KUQJidsXKmDlSXhAyps3qOLQrNj/xc1jUg/4wHKW9QwhAG3AL/fkqMSjSwt0THwf+kITA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16)
 by DB8PR08MB5467.eurprd08.prod.outlook.com (2603:10a6:10:11b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 12:27:07 +0000
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733]) by DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733%3]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 12:27:07 +0000
Message-ID: <0d3eac8e-e684-4b16-9131-069f12c4741a@arm.com>
Date: Thu, 29 May 2025 13:27:06 +0100
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, dev@dpdk.org
Subject: Re: [PATCH v1 2/3] dts: rewrite dts rst
To: Patrick Robb <probb@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
 <20250527153734.368235-2-dmarx@iol.unh.edu>
 <CAJvnSUCBu7Q2nzqyWyZis3hu1if7MZejKhHU2z8RHwdakpEktQ@mail.gmail.com>
Content-Language: en-US
From: Paul Szczepanek <paul.szczepanek@arm.com>
In-Reply-To: <CAJvnSUCBu7Q2nzqyWyZis3hu1if7MZejKhHU2z8RHwdakpEktQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0044.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::25) To DB4PR08MB8151.eurprd08.prod.outlook.com
 (2603:10a6:10:381::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB4PR08MB8151:EE_|DB8PR08MB5467:EE_|DU6PEPF0000B61B:EE_|GV1PR08MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: 07812496-59ce-46d7-ba27-08dd9eac352e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?KzQ2TE5kK1hscHRSeHI4OUZ5b2E4NXY2NjYwTk1vTllYMHNhd3F5S2ZPTDNw?=
 =?utf-8?B?R2tUbjRQTGJWWk14ajQ4NzJsRjMvM1pXdk5vYjlZNFQyQWNMVXBkNGQ5UHE5?=
 =?utf-8?B?QUNFS3FmZkV3S0lZeTlscENtck5ZUkM2UUw1K2dFeXpwWlp1SFJFcUZBMUo5?=
 =?utf-8?B?V0t1OFdURWVXNlkyWWJUWEFaejVjNzBpTHNGRU9wY2JPOUtmTUJmM09JZXlx?=
 =?utf-8?B?cEVIMUpDY3hicG1IK1hLK2RxNE9kVDEzUkdzUG5MbjVUamxKWWZBdnA1YmxF?=
 =?utf-8?B?cGhESnJEU1BkSUcwYStoRk10SG1KMWpZQ2h4Rm85L21ZRk16Q2IzeDcvWUhj?=
 =?utf-8?B?ajVaM1hJUXJrTWZSOUlXTk1HVjgvSEQ1bGJRem1pRnhUSWJUMDFzWEhnREpV?=
 =?utf-8?B?R2hjZ05UcXZ3c2pMclVnN01YTUtjZlRYdHBwVEE0cDh1VmEwNHplck10R01Y?=
 =?utf-8?B?cGo0VkwyWXNQSjlXQzlEM1dnUDE3VTBROVZMeDdyZENaYU0zaSthb1Jzcjgv?=
 =?utf-8?B?VHdSaTBOV2xST2llVWZUY0Q4ajhpM01ROHR5cUxTQzhFQXRNczF1ZU9iV1Jk?=
 =?utf-8?B?aXliRUwxa3Q0aVlBeEhRQkxoZTdPNSt1YUFiUlFRTzlOdXgyVElEb1pQN0NF?=
 =?utf-8?B?ZXIxVzh3SzlFN1JjOFNJZnc4ZjlXbFRHSFgrdWwwYWViMjVCQVZCV3JwTkRz?=
 =?utf-8?B?ZnZIMXdMSVpabDBEd0k4NC9HdTNEMnlwajVIVUtHZDVjRnJ5ZnAyWGpZY1J5?=
 =?utf-8?B?SU5NNE1zOWFyMmpwSldBVHVLd2s4RDBEWHdURTd5a2twQVcvWFlzblR0cW0r?=
 =?utf-8?B?WXVWRkNlaXJlTlJmODVBRmFLc3g0R21EV1I5MzRMSDZyNUF4QVhnL1BvdG0w?=
 =?utf-8?B?bXR0bVJTRnRGb0ZDWnBnVFJPVFp3VDZ1L2d3dEJLZE8rSVNkdzBSV3BCTGZN?=
 =?utf-8?B?N1hYSGpmdXNqOVdnRG52eHFMNGxhQjNhVXBJTVRYQzFDMXFOTmRlNGpBK0pa?=
 =?utf-8?B?d2hzamU4d0piaU9GUE84SU5aZFZ6NU1Tc3BOZWRueStEVWdtTGo3N3BMdVRB?=
 =?utf-8?B?UVBUb3Z0enh4QTJqS3g3bXZxKzd3QWF3Y0x5b0tyZ1RPMzZvTm14OEFsVlRR?=
 =?utf-8?B?ZER0S25nb2Q1OSttOUFYbEc5YjBhamlkTEZUYUEvelpabFBRSm93U05LbzdF?=
 =?utf-8?B?VnZKTXRYS0xmUHpqVGt3dXVsQmtJTWpjTEd2RVNieWZ0SzVOY1RxWUpxeW1r?=
 =?utf-8?B?VG1zYjRKKzBoa0krRHRDdFRFZXpBMkRud0lsVWRqa2N2THJwbnloTVBBbXVT?=
 =?utf-8?B?b25iYWdydjNYbkNsejVjN3ljOHVZdlQ1di9FRE41Mk8wSjBTbGpNZFdpM1dK?=
 =?utf-8?B?RnAxRkxKTFk1ZDh5STJONzRLU3ZBdS9BVXVZUWtlRUF1blNJbEk2d0x1V1JT?=
 =?utf-8?B?Wm9zclI2ZlBsKy9hOElaTHFUM3RKQ0xNY2pkOXpqODFFL0RXTm5CR2o1S0Z3?=
 =?utf-8?B?QTFDRTYzNmtmOGlPRlNiS3hMZmhBS3p5cG5wUnVxdEppbmdCYnVncG9zcWJF?=
 =?utf-8?B?UjJrU0txTWdJZ29LcUxqS1V6aWJDZVJoWGJxNVJYWlc1RTBLS1o3QnVkNTVr?=
 =?utf-8?B?cXdqeVdtZGhaaVhkK0FIazc2MVRFQ3pGbGJ1aVdoVHVjQTFFTHN6bUVPZXFm?=
 =?utf-8?B?aUhDQ24yNEFQWStmQnliSWNkWW1SRXg5MTU3c1dOYnAwR094Mmp6R1hua1pn?=
 =?utf-8?B?YzZZaEhCRGV4S0pvL2pvdkVaQXBPaHg4d0RKMVVKaHdLcjc5ZVE2SzFNYU9z?=
 =?utf-8?B?QkIwQlFqNXJ1c21VNU8xR203ME1YMzg4eXpsUjYzY3BwYUNlMCt5Y0ZyWkhw?=
 =?utf-8?Q?wrua4W4b/Ghdm?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB4PR08MB8151.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5467
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: afaf82e0-84a1-45be-c387-08dd9eac20a6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|14060799003|35042699022|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUZQVHNESFBuMENsb3lZRjJEUW4vbjFESUtRMjg1SkhueUpZYWpIY05pRFov?=
 =?utf-8?B?eGFKMlpjc0tSUitEMUVreVE2ajQ0RFYwTzd6ekN1cDE2eXY5RHJoamNmTmV2?=
 =?utf-8?B?TzFzSTNZa1J2OFNqanJoWFBEdjdOTlBKVnNaYzI4NXg0RjVkY0oxYk5RaDJD?=
 =?utf-8?B?MlNsVXlIVEJnV0dHUzQ0Z1V5MDlwSHpaZnAwdWtUWXpnUkpJeGlFVTJ1Q1pT?=
 =?utf-8?B?d2d1SVorUEVJdGw1b2YrWjF4YWlGZjFjNXJMckhMSERja2J3MTJqZS9Mc0V1?=
 =?utf-8?B?RVZkeXhVNkJjMWl3Zjg1cWdaYVkweHlSQ0lYL3NaejRXVmtTdXhMckJRRDlj?=
 =?utf-8?B?VXRXMndKN0xKbnNpTFVYc3FQZGg3ZllGaDc2OWE2QmMrb0w2ZnErNk1laTdX?=
 =?utf-8?B?QUd3bWVXTzVoaGNsdG1IbklSbWttR2VHUC83bG5IVGZBSFFkL0orb0htUCsr?=
 =?utf-8?B?Y0NkSWpNWVRSSHhEWm1NSGxXSFEzb0VMT2RaMEpwRy91V0M2a0taSWhrZWVl?=
 =?utf-8?B?ei82ZzB0Zy9mTmtxV1hEM0g5ZUZFUUFwd1luajNjRnE4N2pvVzV5cFcvemhG?=
 =?utf-8?B?b2NHV0xqVThzQlhDWWNRbmplWXhTbGVDeDhaWkxYbXh2RjdUWGZnV1c0SDFY?=
 =?utf-8?B?M2lpQisxc3k2Mk4zUlEwSGRIc2ErZHZQeUpqTmMrTzNKeS9Vc3dkbjM3YmFu?=
 =?utf-8?B?NmJzaThUb3BjVmxtZFRWVTBKZDE1RnV1OUExdlR5bDc5bVRQek5QK2pVZ0V5?=
 =?utf-8?B?NmlNWEFJdkdyMFJtSnFmNnJyOER0eCs3endQNWlJQmVXT2ZHZEE4K215TjdN?=
 =?utf-8?B?ZUw3R3VuRHd5eWdwS3ZBMVJVSDk1ZS9sWngweU5iR3ByYll0RHdFSm9aSktN?=
 =?utf-8?B?VUFlSWtOakZaVWtpQkpyTFB0eE5WR2pRVWJmR0dPamVRYkpQTk5BeXVtb25X?=
 =?utf-8?B?QVkrczA1Ykd5VEU2VDlOSDZYZXVmbzVNa3NPZlBLK0JjNDQ4blFVa0tpTVc3?=
 =?utf-8?B?N1Z5clVHT3JRSG5hZERDODdqK1NIRllOS3dtaHRnbVg1bWN4OVlGaTFISG1B?=
 =?utf-8?B?RW4yekJmdkQwd2lnQWpHdmxqemx5d1o2eEV0RlhHSXdzOTJmcUxXTldhSzd1?=
 =?utf-8?B?c2pVOUZ5VHkxaVBWUnU4Y1J0dmU5MEQ2eU5xZmtFWmttRUxIdTRaakExakxV?=
 =?utf-8?B?Yy84eW9FcC9EZHZORUJZQ2pOTUFFWGgvZEJQSVBhdFphTHJiZmtXQ2RpRkFl?=
 =?utf-8?B?Z1AyYWQ2ZTZFZVN2b0I2dmVsZmRIV0ttRzdoOVQ1NDQ0UjI2bTgwS1FhVVZy?=
 =?utf-8?B?UW82NUt2L0MrTVp0eTNxQkZiUWFTRzVUSGVwdXFUZUpWbm1CT243TnE1dVVW?=
 =?utf-8?B?d09GWXVrWFZyZG5NcFZFcDJNNFk3T3p4YTdlczk0TDl1S010YVZUWjhHZndU?=
 =?utf-8?B?NDIycUxmeXlTQXdmTjAwSlR3Z2hmQ0Y0YlFpdUxTOEhDeWhTUUdlb015cFJr?=
 =?utf-8?B?dDdOclVleFplYWk4Vm4xVTJFV0s0R3hxRlBzQkZ4L295cmlpbk94VEpWcG1X?=
 =?utf-8?B?aFVuM3NoczdscDc1aFpCaFYrYUh0L0VXS0RyUjB1SlRxUGtrUTdteGxIT1VH?=
 =?utf-8?B?Yk55d0xJY0c0a21OZGVFazEreEVyQ0xSblZveEV4c2E0OFc5Q0x0UmlYZ3ls?=
 =?utf-8?B?SCszOXh4elBXUkVBNkFrU1luYmdCamxiSStSdmFjdkNTV3ZPYkJxWkJkYzdY?=
 =?utf-8?B?SDY2NU4yYS9JemQ0TWhzblMrTFpHMTQ4YWJXd1B4Q1Qya3lqRFhLRWI0V2lm?=
 =?utf-8?B?TUdCMUpnTllqMk1tdE1GbXNaTDRsSDAyZzVDUGJzNU5zRUswVXNBV1lKM0ly?=
 =?utf-8?B?VGlDTlQrNTcwaExhaTR3MjFtbHJEYUFJOE9Ba1JhMDl6V1NwMUFnQzhRdEFu?=
 =?utf-8?B?MDIzR2tjYkYza3hXTEprSEtZY29wbXJBUHZaZ2NhZmh5VEtJMGhucDRyRElR?=
 =?utf-8?B?K2JVRVg5TnVBPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(14060799003)(35042699022)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:27:41.9108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07812496-59ce-46d7-ba27-08dd9eac352e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11051
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

I think shortening it is great, less maintenance overhead and avoids
going out of sync with code which is already plenty documented.

Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>

On 28/05/2025 22:25, Patrick Robb wrote:
> 
> 
> On Tue, May 27, 2025 at 11:37 AM Dean Marx <dmarx@iol.unh.edu
> <mailto:dmarx@iol.unh.edu>> wrote:
> 
>     Modify dts.rst to exclude redundant/outdated information about the
>     project,
>     and add new information regarding setup and framework design.
> 
>     Signed-off-by: Dean Marx <dmarx@iol.unh.edu <mailto:dmarx@iol.unh.edu>>
>     ---
>      doc/guides/tools/dts.rst | 310 +++++++++++++--------------------------
>      1 file changed, 99 insertions(+), 211 deletions(-)
> 
>     diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
>     index fcc6d22036..0aa6663b9f 100644
>     --- a/doc/guides/tools/dts.rst
>     +++ b/doc/guides/tools/dts.rst
>     @@ -1,6 +1,7 @@
>      ..  SPDX-License-Identifier: BSD-3-Clause
>          Copyright(c) 2022-2023 PANTHEON.tech s.r.o.
>          Copyright(c) 2024 Arm Limited
>     +    Copyright(c) 2025 University of New Hampshire
> 
>      DPDK Test Suite
>      ===============
>     @@ -20,31 +21,18 @@ DTS runtime environment
> 
>      DTS runtime environment node
>        A node where at least one DTS runtime environment is present.
>     -  This is the node where we run DTS and from which DTS connects to
>     other nodes.
> 
> 
> Leave this in.
>  
> 
> 
>      System under test
>     -  An SUT is the combination of DPDK and the hardware we're testing
>     -  in conjunction with DPDK (NICs, crypto and other devices).
>     +  Node with DPDK and relevant hardware (NICs, crypto, etc.).
> 
> 
> Maybe change to "The system which runs a DPDK application on relevant
> hardware (NIC, accelerator cards, etc) and from which the DPDK behavior
> is observed for tests."
>  
> 
> 
>      System under test node
>        A node where at least one SUT is present.
> 
>      Traffic generator
>     -  A TG is either software or hardware capable of sending packets.
>     +  Node that sends traffic; can be hardware or software-based.
> 
> 
> "Node that sends traffic to the SUT;"
>  
> Sorry for being so particular. :)
> 
> 
>      Traffic generator node
>        A node where at least one TG is present.
>     -  In case of hardware traffic generators, the TG and the node are
>     literally the same.
>     -
>     -
>     -In most cases, interchangeably referring to a runtime environment,
>     SUT, TG or the node
>     -they're running on (e.g. using SUT and SUT node interchangeably)
>     doesn't cause confusion.
>     -There could theoretically be more than of these running on the same
>     node and in that case
>     -it's useful to have stricter definitions.
>     -An example would be two different traffic generators (such as Trex
>     and Scapy)
>     -running on the same node.
>     -A different example would be a node containing both a DTS runtime
>     environment
>     -and a traffic generator, in which case it's both a DTS runtime
>     environment node and a TG node.
> 
> 
>      DTS Environment
>     @@ -195,12 +183,28 @@ These need to be set up on a Traffic Generator
>     Node:
>      Running DTS
>      -----------
> 
>     -DTS needs to know which nodes to connect to and what hardware to
>     use on those nodes.
>     -Once that's configured, either a DPDK source code tarball or tree
>     folder
>     -need to be supplied whether these are on your DTS host machine or
>     the SUT node.
>     -DTS can accept a pre-compiled build placed in a subdirectory,
>     -or it will compile DPDK on the SUT node,
>     -and then run the tests with the newly built binaries.
>     +To run DTS, use ``main.py`` with Poetry:
>     +
>     +.. code-block:: console
>     +
>     +   ```shell
>     +   docker build --target dev -t dpdk-dts .
>     +   docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/
>     root/.ssh:ro -it dpdk-dts bash
>     +   $ poetry install
>     +   $ poetry run ./main.py
>     +   ```
>     +
>     +Common options include:
>     +
>     +- ``--output-dir``: Custom output location.
>     +- ``--remote-source``: Use sources stored on the SUT.
>     +- ``--tarball``: Specify the tarball to be tested.
>     +
>     +For a full list:
>     +
>     +.. code-block:: console
>     +
>     +   poetry run ./main.py --help
> 
> 
> I think we should keep the full list of flags here instead of removing
> it for this subset. It's a bit of a maintenance burden and it make the
> file longer but it's important info. I think it's good to present it
> here even if it is only "a --help away."
>  
> 
> 
> 
>      Configuring DTS
>     @@ -220,71 +224,6 @@ The user must have :ref:`administrator
>     privileges <sut_admin_user>`
>      which don't require password authentication.
> 
> 
>     -DTS Execution
>     -~~~~~~~~~~~~~
>     -
>     -DTS is run with ``main.py`` located in the ``dts`` directory after
>     entering Poetry shell:
>     -
>     -.. code-block:: console
>     -
>     -   (dts-py3.10) $ ./main.py --help
>     -   usage: main.py [-h] [--test-run-config-file FILE_PATH] [--nodes-
>     config-file FILE_PATH] [--tests-config-file FILE_PATH]
>     -                  [--output-dir DIR_PATH] [-t SECONDS] [-v] [--
>     dpdk-tree DIR_PATH | --tarball FILE_PATH] [--remote-source]
>     -                  [--precompiled-build-dir DIR_NAME] [--compile-
>     timeout SECONDS] [--test-suite TEST_SUITE [TEST_CASES ...]]
>     -                  [--re-run N_TIMES] [--random-seed NUMBER]
>     -
>     -   Run DPDK test suites. All options may be specified with the
>     environment variables provided in brackets. Command line arguments
>     have higher
>     -   priority.
>     -
>     -   options:
>     -     -h, --help            show this help message and exit
>     -     --test-run-config-file FILE_PATH
>     -                           [DTS_TEST_RUN_CFG_FILE] The
>     configuration file that describes the test cases and DPDK build
>     options. (default: test-run.conf.yaml)
>     -     --nodes-config-file FILE_PATH
>     -                           [DTS_NODES_CFG_FILE] The configuration
>     file that describes the SUT and TG nodes. (default: nodes.conf.yaml)
>     -     --tests-config-file FILE_PATH
>     -                           [DTS_TESTS_CFG_FILE] Configuration file
>     used to override variable values inside specific test suites.
>     (default: None)
>     -     --output-dir DIR_PATH, --output DIR_PATH
>     -                           [DTS_OUTPUT_DIR] Output directory where
>     DTS logs and results are saved. (default: output)
>     -     -t SECONDS, --timeout SECONDS
>     -                           [DTS_TIMEOUT] The default timeout for
>     all DTS operations except for compiling DPDK. (default: 15)
>     -     -v, --verbose         [DTS_VERBOSE] Specify to enable verbose
>     output, logging all messages to the console. (default: False)
>     -     --compile-timeout SECONDS
>     -                           [DTS_COMPILE_TIMEOUT] The timeout for
>     compiling DPDK. (default: 1200)
>     -     --test-suite TEST_SUITE [TEST_CASES ...]
>     -                           [DTS_TEST_SUITES] A list containing a
>     test suite with test cases. The first parameter is the test suite
>     name, and
>     -                           the rest are test case names, which are
>     optional. May be specified multiple times. To specify multiple test
>     suites
>     -                           in the environment variable, join the
>     lists with a comma. Examples: --test-suite suite case case --test-suite
>     -                           suite case ... | DTS_TEST_SUITES='suite
>     case case, suite case, ...' | --test-suite suite --test-suite suite case
>     -                           ... | DTS_TEST_SUITES='suite, suite
>     case, ...' (default: [])
>     -     --re-run N_TIMES, --re_run N_TIMES
>     -                           [DTS_RERUN] Re-run each test case the
>     specified number of times if a test failure occurs. (default: 0)
>     -     --random-seed NUMBER  [DTS_RANDOM_SEED] The seed to use with
>     the pseudo-random generator. If not specified, the configuration
>     value is
>     -                           used instead. If that's also not
>     specified, a random seed is generated. (default: None)
>     -
>     -   DPDK Build Options:
>     -     Arguments in this group (and subgroup) will be applied to a
>     DPDKLocation when the DPDK tree, tarball or revision will be provided,
>     -     other arguments like remote source and build dir are optional.
>     A DPDKLocation from settings are used instead of from config if
>     -     construct successful.
>     -
>     -     --dpdk-tree DIR_PATH  [DTS_DPDK_TREE] The path to the DPDK
>     source tree directory to test. Cannot be used in conjunction with --
>     tarball.
>     -                           (default: None)
>     -     --tarball FILE_PATH, --snapshot FILE_PATH
>     -                           [DTS_DPDK_TARBALL] The path to the DPDK
>     source tarball to test. DPDK must be contained in a folder with the same
>     -                           name as the tarball file. Cannot be used
>     in conjunction with --dpdk-tree. (default: None)
>     -     --remote-source       [DTS_REMOTE_SOURCE] Set this option if
>     either the DPDK source tree or tarball to be used are located on the SUT
>     -                           node. Can only be used with --dpdk-tree
>     or --tarball. (default: False)
>     -     --precompiled-build-dir DIR_NAME
>     -                           [DTS_PRECOMPILED_BUILD_DIR] Define the
>     subdirectory under the DPDK tree root directory or tarball where the
>     pre-
>     -                           compiled binaries are located. (default:
>     None)
>     -
>     -
>     -The brackets contain the names of environment variables that set
>     the same thing.
>     -The minimum DTS needs is a config file and a pre-built DPDK
>     -or DPDK sources location which can be specified in said config file
>     -or on the command line or environment variables.
>     -
>     -
>      DTS Results
>      ~~~~~~~~~~~
> 
>     @@ -308,140 +247,89 @@ Adding test cases may require adding code to
>     the framework as well.
>      Framework Coding Guidelines
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>     -When adding code to the DTS framework, pay attention to the rest of
>     the code
>     -and try not to divert much from it.
>     -The :ref:`DTS developer tools <dts_dev_tools>` will issue warnings
>     -when some of the basics are not met.
>     -You should also build the :ref:`API documentation <building_api_docs>`
>     -to address any issues found during the build.
>     -
>     -The API documentation, which is a helpful reference when
>     developing, may be accessed
>     -in the code directly or generated with the :ref:`API docs build
>     steps <building_api_docs>`.
>     -When adding new files or modifying the directory structure,
>     -the corresponding changes must be made to DTS API doc sources in
>     ``doc/api/dts``.
>     -
>     -Speaking of which, the code must be properly documented with
>     docstrings.
>     -The style must conform to the `Google style
>     -<https://google.github.io/styleguide/pyguide.html#38-comments-and-
>     docstrings <https://google.github.io/styleguide/pyguide.html#38-
>     comments-and-docstrings>>`_.
>     -See an example of the style `here
>     -<https://www.sphinx-doc.org/en/master/usage/extensions/
>     example_google.html <https://www.sphinx-doc.org/en/master/usage/
>     extensions/example_google.html>>`_.
>     -For cases which are not covered by the Google style, refer to `PEP 257
>     -<https://peps.python.org/pep-0257/ <https://peps.python.org/
>     pep-0257/>>`_.
>     -There are some cases which are not covered by the two style guides,
>     -where we deviate or where some additional clarification is helpful:
>     -
>     -   * The ``__init__()`` methods of classes are documented separately
>     -     from the docstring of the class itself.
>     -   * The docstrings of implemented abstract methods should refer to
>     the superclass's definition
>     -     if there's no deviation.
>     -   * Instance variables/attributes should be documented in the
>     docstring of the class
>     -     in the ``Attributes:`` section.
>     -   * The ``dataclass.dataclass`` decorator changes how the
>     attributes are processed.
>     -     The dataclass attributes which result in instance variables/
>     attributes
>     -     should also be recorded in the ``Attributes:`` section.
>     -   * Class variables/attributes and Pydantic model fields, on the
>     other hand,
>     -     should be documented with ``#:`` above the type annotated line.
>     -     The description may be omitted if the meaning is obvious.
>     -   * The ``Enum`` and ``TypedDict`` also process the attributes in
>     particular ways
>     -     and should be documented with ``#:`` as well.
>     -     This is mainly so that the autogenerated documentation
>     contains the assigned value.
>     -   * When referencing a parameter of a function or a method in
>     their docstring,
>     -     don't use any articles and put the parameter into single
>     backticks.
>     -     This mimics the style of `Python's documentation <https://
>     docs.python.org/3/index.html <https://docs.python.org/3/index.html>>`_.
>     -   * When specifying a value, use double backticks::
>     -
>     -        def foo(greet: bool) -> None:
>     -            """Demonstration of single and double backticks.
>     -
>     -            `greet` controls whether ``Hello World`` is printed.
>     -
>     -            Args:
>     -               greet: Whether to print the ``Hello World`` message.
>     -            """
>     -            if greet:
>     -               print(f"Hello World")
>     -
>     -   * The docstring maximum line length is the same as the code
>     maximum line length.
>     -
>     -
>     -How To Write a Test Suite
>     --------------------------
>     -
>     -All test suites inherit from ``TestSuite`` defined in ``dts/
>     framework/test_suite.py``.
> 
> 
> "All test suites are a class which inherits from"
>  
> 
>     -There are four types of methods that comprise a test suite:
>     -
>     -#. **Test cases**
>     -
>     -   | Test cases are methods that start with a particular prefix.
>     -   | Functional test cases start with ``test_``, e.g.
>     ``test_hello_world_single_core``.
> 
>     -   | Performance test cases start with ``test_perf_``, e.g.
>     ``test_perf_nic_single_core``.
> 
> 
> Now decorator based.
>  
> 
>     -   | A test suite may have any number of functional and/or
>     performance test cases.
>     -     However, these test cases must test the same feature,
>     -     following the rule of one feature = one test suite.
>     -     Test cases for one feature don't need to be grouped in just
>     one test suite, though.
>     -     If the feature requires many testing scenarios to cover,
>     -     the test cases would be better off spread over multiple test
>     suites
>     -     so that each test suite doesn't take too long to execute.
>     -
>     -#. **Setup and Teardown methods**
>     -
>     -   | There are setup and teardown methods for the whole test suite
>     and each individual test case.
>     -   | Methods ``set_up_suite`` and ``tear_down_suite`` will be executed
>     -     before any and after all test cases have been executed,
>     respectively.
>     -   | Methods ``set_up_test_case`` and ``tear_down_test_case`` will
>     be executed
>     -     before and after each test case, respectively.
>     -   | These methods don't need to be implemented if there's no need
>     for them in a test suite.
>     -     In that case, nothing will happen when they are executed.
>     -
>     -#. **Configuration, traffic and other logic**
>     -
>     -   The ``TestSuite`` class contains a variety of methods for
>     anything that
>     -   a test suite setup, a teardown, or a test case may need to do.
>     -
>     -   The test suites also frequently use a DPDK app, such as testpmd,
>     in interactive mode
>     -   and use the interactive shell instances directly.
>     -
>     -   These are the two main ways to call the framework logic in test
>     suites.
>     -   If there's any functionality or logic missing from the framework,
>     -   it should be implemented so that the test suites can use one of
>     these two ways.
>     -
>     -#. **Test case verification**
>     -
>     -   Test case verification should be done with the ``verify``
>     method, which records the result.
>     -   The method should be called at the end of each test case.
>     -
>     -#. **Other methods**
> 
> 
> I see that some of the content under "Other methods" is now false and
> should be removed - thanks for doing so. However, I do think there was a
> lot of good within the original "Test Cases," "Setup and Teardown
> Methods," and "Configuration, traffic and other logic" which has been
> removed. For this one I prefer if we just sit down and hash it out in
> person when you're in next week.
>  
> 
>     -
>     -   Of course, all test suite code should adhere to coding standards.
>     -   Only the above methods will be treated specially and any other
>     methods may be defined
>     -   (which should be mostly private methods needed by each
>     particular test suite).
>     -   Any specific features (such as NIC configuration) required by a
>     test suite
>     -   should be implemented in the ``SutNode`` class (and the
>     underlying classes that ``SutNode`` uses)
>     -   and used by the test suite via the ``sut_node`` field.
>     +When contributing code to the DTS framework, follow existing
>     conventions to ensure consistency.
>     +The :ref:`DTS developer tools <dts_dev_tools>` will flag basic issues.
>     +Also, be sure to :ref:`build the API documentation
>     <building_api_docs>` to catch any problems during the build.
> 
>     +The API documentation is a helpful reference during development.
>     +It can be viewed in the code directly or generated using
>     the :ref:`API docs build steps <building_api_docs>`.
>     +If you add new files or change the directory structure, update the
>     corresponding sources in ``doc/api/dts``.
> 
>     -.. _dts_dev_tools:
>     +Code must be documented with docstrings that follow the
>     +`Google style <https://google.github.io/styleguide/pyguide.html#38-
>     comments-and-docstrings <https://google.github.io/styleguide/
>     pyguide.html#38-comments-and-docstrings>>`_.
>     +Additional references:
> 
>     -DTS Developer Tools
>     --------------------
>     +* `Sphinx Google style example <https://www.sphinx-doc.org/en/
>     master/usage/extensions/example_google.html <https://www.sphinx-
>     doc.org/en/master/usage/extensions/example_google.html>>`_
>     +* `PEP 257 <https://peps.python.org/pep-0257/ <https://
>     peps.python.org/pep-0257/>>`_
>     +
>     +Docstring and Attribute Guidelines
> 
>     -There are two tools used in DTS to help with code checking, style
>     and formatting:
>     +* Document ``__init__()`` separately from the class docstring.
>     +* If an abstract method simply implements a superclass definition
>     without changes, refer to that superclass in the docstring.
>     +* Document instance variables in the class docstring under an
>     ``Attributes:`` section.
>     +* For ``@dataclass`` classes, document instance-level attributes in
>     ``Attributes:``, as they are generated from the class fields.
>     +* Document class variables and Pydantic fields using ``#:``,
>     +   placed above the type-annotated line. Descriptions may be
>     omitted if the meaning is clear.
>     +* Apply ``#:`` to ``Enum`` and ``TypedDict`` fields as well, so
>     that autogenerated documentation includes their values.
>     +* When referring to a parameter in a docstring, omit articles and
>     enclose the parameter in single backticks (e.g., `` `param` ``),
>     +   consistent with the `Python documentation style <https://
>     docs.python.org/3/index.html <https://docs.python.org/3/index.html>>`_.
>     +* Use double backticks (````value````) for literal values.
> 
>     -* `ruff <https://astral.sh/ruff/ <https://astral.sh/ruff/>>`_
>     +Example::
> 
>     -  An extremely fast all-in-one linting and formatting solution,
>     -  which covers most if not all the major rules such as:
>     -  pylama, flake8, pylint etc.
>     -  Its built-in formatter is also Black-compatible
>     -  and is able to sort imports automatically like isort would.
>     +   def foo(greet: bool) -> None:
>     +       """Demonstrates single vs. double backticks.
> 
>     -* `mypy <https://github.com/python/mypy <https://github.com/python/
>     mypy>>`_
>     +       `greet` controls whether ``Hello World`` is printed.
> 
>     -  Enables static typing for Python, exploiting the type hints in
>     the source code.
>     +       Args:
>     +           greet: Whether to print the ``Hello World`` message.
>     +       """
>     +       if greet:
>     +           print("Hello World")
>     +
>     +The maximum line length for docstrings must match that of the code.
>     +
>     +
>     +Creating a Test Suite
>     +---------------------
>     +
>     +All test suites inherit from ``TestSuite`` in ``dts/framework/
>     test_suite.py``. A typical suite contains:
>     +
>     +- Test Cases 
>     +  - Functional: start with ``test_``, e.g., ``test_basic_link`` 
>     +  - Performance: start with ``test_perf_``, e.g.,
>     ``test_perf_throughput`` 
> 
> 
> I realize you go on to describe the decorators after this, but I think
> the test_func and test_perf naming convention is no longer required.
> Example: 
> 
>     @requires(NicCapability.FLOW_CTRL)
>     @func_test
>     def flow_ctrl_port_configuration_persistence(self) -> None:
>         """Flow control port configuration persistency test.
> 
>         Steps:
>             For each port enable flow control for RX and TX individually.
>         Verify:
>             The configuration persists after the port is restarted.
>         """
> 
>  
> 
>     +  - Import the ``func_test`` and/or ``perf_test`` decorators from
>     ``TestSuite`` and add them above each test case method,
>     +   e.g., ``@func_test`` followed by ``test_basic_link``
>     +
>     +- Setup/Teardown Hooks
>     +  - Suite-level: ``set_up_suite()``, ``tear_down_suite()``
>     +  - Case-level: ``set_up_test_case()``, ``tear_down_test_case()``
>     +
>     +- Verification 
>     +  Use ``self.verify(condition, message)`` to record test results.
> 
> 
> I think the important part of "verify" to explain to people is that you
> are setting the testcase assertion condition, not the recording aspect.
>  
> 
>     +
>     +- Support Methods
>     +  Helper logic (e.g., traffic handling, config) should be in
>     private methods or delegated to ``sut_node``.
> 
> 
> I realize this is just a rewording that crept in, but this is wrong for
> a couple reasons:
> 
> 1. We no longer import node/sutnode when writing testsuites. Node
> is purely framework code now, and is not exposed to testsuites.
> 2. sut_node (and tg_node) no longer exists.
>  
> 
>     +
>     +
>     +.. _dts_dev_tools:
>     +
>     +Developer Tools
>     +---------------
>     +
>     +- ruff 
>     +  - Linter and formatter (replaces flake8, pylint, isort, etc.)
>     +  - Compatible with Black
>     +
>     +- mypy 
>     +  - Performs static type checking
>     +
>     +Run checks using:
>     +
>     +.. code-block:: console
> 
>     -These two tools are all used in ``devtools/dts-check-format.sh``,
>     -the DTS code check and format script.
>     -Refer to the script for usage: ``devtools/dts-check-format.sh -h``.
>     +   devtools/dts-check-format.sh
> 
> 
>      .. _building_api_docs:
>     -- 
>     2.49.0
> 
> 
> Lots of improvements overall - keep up the good work! A productive
> Summer ahead. 
> 
> Reviewed-by: Patrick Robb <probb@iol.unh.edu <mailto:probb@iol.unh.edu>>
>  

