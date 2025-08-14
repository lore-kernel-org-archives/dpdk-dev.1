Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07EACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 11:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84DDC42707;
	Thu, 14 Aug 2025 13:03:13 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011057.outbound.protection.outlook.com
 [40.107.130.57]) by mails.dpdk.org (Postfix) with ESMTP id 88BAA4026D
 for <dev@dpdk.org>; Thu, 14 Aug 2025 13:03:11 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=A64FBFJJKqD5ffOOAIwv2WHxeXXxNOOM9CpiPAi7yP8OUvEIkj0d+VwFrrQYdko0WOH+XEGripaPNdhTg+b4ffmt6T8Aii9IPpO1zKf/+6l8FRJO5ewhT09hzhbdnjZgG580VTaGYuiYpTFi4ztzF7ggjmd09stxE2zl9jan91v0PII5YlV3i1Ok41JlCqMOxzKIicwLuV6Ju0jDsXeph6P1cKrUU77siLfQ3XVH6nCfDb2ViYHS8Db84kTnQh1e+o1VbhtK2CmBOm6CX1xTMybwl3ktzIEWztALc8XD9aV4ALq5CqWjWZDZ51rc5R53P0UA5i1IYYRBNloE9HdRnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGIKm/Uc0kOY+RG3nMA8u43q87nDl23yvhvJzTTSCpU=;
 b=Fq2CW2igvxn7L4xs/uEIRRVPtWXo14nrJX9Z45AXn0xgqhyp3K3Q6MhPjPPZx/Ngd3S2r5W5xH5sIgYnJRzPLj7x7OVxDvd704z3lQXV36gjIbGA0kGpSYzLglhE1uVh1kpjXU8Rur1rImQrYX/UOXzDF1ro6e6uFPvx/bvcKJi5ZFwG3iNEs9U5vxJf1q+Ja6FbMyv4YZ+yFqxo60bUJ+sCTQMM3tp0zhC7iYXTeYbDI7ibfIoYXdo9Z+lKn1JRLCfZUuagAUvf0xm5+VRr8cQFJSZ9q8too2AcB6pVtZmsUJ5TcoJVuEfjaMQyyfFA6SufqO/HSYaSSNTkXPnAcQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGIKm/Uc0kOY+RG3nMA8u43q87nDl23yvhvJzTTSCpU=;
 b=fhuuuGiotg8ULpu0xYNuTcfnWg8Mbclv7WcSxBPoffNTG/qz193Sg6y2zwugTw52Y1CSRuemvTRnoaK9niTrA4u/YjNpLAkapHZ6mxpIj+FJgwZpdTVVCj148L1NpsOeoKl7cY//R3C6ohvx3RPAUy1SaZn9QbBNOVstkQK37+g=
Received: from PA7P264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::14)
 by AS4PR08MB7880.eurprd08.prod.outlook.com (2603:10a6:20b:51f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 14 Aug
 2025 11:03:07 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:102:371:cafe::63) by PA7P264CA0248.outlook.office365.com
 (2603:10a6:102:371::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 11:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Thu, 14 Aug 2025 11:03:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1gbkdOnl0FYKwZOBmD7CB+qwnZJ641lt7ileA1c2JiKVulOTDQ0PPOzU2sHkzs/mlwyKIAxcPfvxhia4t78AdQCNWdBIIkOWZ0l9cjM/Q8h4sdpP6QOlqzi9Bcgf6CNLa5UUaodhnZjNvwKU3LNV0hCvChtTFlk/6Lpf62LEhZTh42RZuC1E6zknM/wpV2GquF2P5OmKCi3sBo8feS3vKPZ0GVLPH5NcLiWkkjJNC+RyMbAz+7AiAWDl1Okr1AleDwjAXGYzIAz7GQcTau5uE1CZO2g+kROvsRaFor7NWtHMAh9Xho+z6utb+aUj5otdarrQ2v5hKYcnjuNEYN0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGIKm/Uc0kOY+RG3nMA8u43q87nDl23yvhvJzTTSCpU=;
 b=o6af5UYDEkiPOHa5MRUtFYCbY2Xqiuya8N4a8Um2+SKYLgDo7W8ehLdo/YvXC4zQ36Ybqhlc0cXM0hzGPsc5+OclckQrYGN9juTAa+VHwy9xr3vK6H/5bXkWo1QbkjjoYcDU1IMNjEQu00qaKfQw+gHe/R3mcWZIH63sB6QfRyBKurDB5i1Ee02TlH3fVrXc8o8XggqxP/Sm6AhHu53eub4d3QSeCLiwYrHklYEggKRQVRr6VXeof/AVQytwCYq69va7MxcTntlGaVqOzp8qjnERyhfkLSFapNluisMY0X7X1lzemb2CPJNtvlh0azRDb9SsD4m180oFCCWVOQgsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGIKm/Uc0kOY+RG3nMA8u43q87nDl23yvhvJzTTSCpU=;
 b=fhuuuGiotg8ULpu0xYNuTcfnWg8Mbclv7WcSxBPoffNTG/qz193Sg6y2zwugTw52Y1CSRuemvTRnoaK9niTrA4u/YjNpLAkapHZ6mxpIj+FJgwZpdTVVCj148L1NpsOeoKl7cY//R3C6ohvx3RPAUy1SaZn9QbBNOVstkQK37+g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16)
 by DU0PR08MB9536.eurprd08.prod.outlook.com (2603:10a6:10:44c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 11:02:31 +0000
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733]) by DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733%2]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 11:02:30 +0000
Message-ID: <43453c78-bf9f-476b-9c8a-7176a4d5f27b@arm.com>
Date: Thu, 14 Aug 2025 12:02:30 +0100
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] maintainers: update for DTS
To: Patrick Robb <probb@iol.unh.edu>, Luca Vizzarro <luca.vizzarro@arm.com>
References: <20250807143019.1986881-1-luca.vizzarro@arm.com>
 <CAJvnSUD_DPxRryK_FcdZrS4vCikvUA+75e8tKtAcz9_T0BbPmA@mail.gmail.com>
Content-Language: en-US
From: Paul Szczepanek <paul.szczepanek@arm.com>
In-Reply-To: <CAJvnSUD_DPxRryK_FcdZrS4vCikvUA+75e8tKtAcz9_T0BbPmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::11) To DB4PR08MB8151.eurprd08.prod.outlook.com
 (2603:10a6:10:381::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB4PR08MB8151:EE_|DU0PR08MB9536:EE_|AM2PEPF0001C710:EE_|AS4PR08MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c355fe-47f2-455f-3fca-08dddb2225a6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?NE45R3kyUDJFcFlZZUVjbkY5OTNqVGlVZXg0bHdZdUFYRW01dU52ek94ZzF0?=
 =?utf-8?B?ZHQ5ZHdFRUJGdUdVd0FTTXBZR2RDOGZmelBEcExad2drcmI4dnFBMW82cGdJ?=
 =?utf-8?B?ODVhOGZqUy9MYnRXa1FyZzFpR3JxdXpVVitINEVZNEo4RC9lNVZ3MzBCbnhh?=
 =?utf-8?B?L04wVmU4VVVoSGZFbWUrOEgxOE8xcVFPWnZrVTFoQnZCUm9USnIwTENoM1dB?=
 =?utf-8?B?WndTZ0Q4S0VNSDByai82VmNFQnlZWUdFZlhaNFU0ZlFoMkp5VkdHdTdDU0d6?=
 =?utf-8?B?TkcwNVM2UlA3dVlUNk1ZMFRVbFhpNm9vL01HMzBSb3hWT2RMQlNqa3g5QXZn?=
 =?utf-8?B?TGE4eEdPUnlzS0tRSXVQaTZRVmhpaWE1clU4UUJJeFhLdHF4bURLZUFvUlVl?=
 =?utf-8?B?RFp5QzJUaC9CU09VYmd1K2VHb1ZWZWVwUnpHajRqTjg5RmpiSGhwcG5WL3dl?=
 =?utf-8?B?VnNSYU1FWWFSV3lWRmxwbEhMbkt5M1dBSDY3L1RMUm5Mc2pMU3hYdjU1eW9x?=
 =?utf-8?B?R3lzYXNzN0NZeTBCNzFROWNKcTJwcXlaTS80T3lCL1dYc25jMEJlRHZVc3Fs?=
 =?utf-8?B?cE1LWW80ZnhBeE4zaGFJSEY0dmJTd0ZFVWRzdlExTDRTRTNYd2xiSGZWK0xz?=
 =?utf-8?B?QVVjbEFzbXZEYU5pZ0VONnUxUi9ZRFZFMkZCMkxYcmhXeXQ2QVN2UGt6dXF1?=
 =?utf-8?B?RjRlV21wdEhmQ0lURVZMUDFISnNsY0cwN3RDV29yQlFyOXZDT3piREpwVzlD?=
 =?utf-8?B?SkxUREh6NndsWEpVdjVhRHFvMUNyUFlHVWV1RlZKOEVSNFd6WnpiT1c3NXpP?=
 =?utf-8?B?dGJKcVM0WGhoNzBLWStQNHBONWN5Rk5aakt0YWNTVWhKNEs1WEQ2Qjh4N1ZW?=
 =?utf-8?B?dmdBb3hFRzZCL0QrT2s4Und6ZmFja0MwYThyYjArcmhRdm5ldExoQzd6ZlQz?=
 =?utf-8?B?Qnp5R3A1UTFWRC8xWVlUMnJ1ZEdiVUVIbHplUzZ3ZUEyY3ZlQVRFeWlIY3c1?=
 =?utf-8?B?K0JYQUJqaEpjV2FtZk84dDJTZk56eVVhbXVKK0cyZHFUY2o4WFdVTFd1S0Ri?=
 =?utf-8?B?bFM0Y01LNVlxYTl3K01wVmVYYzJBMTErZWNybm1WeFRjVkFCV2hFQ0R5MSsr?=
 =?utf-8?B?OWlMMWllemNSQnU3Nm0xS3N3alpvRDd1ZWpnN2p4UGM1TWR4L212UzlSczVz?=
 =?utf-8?B?aGNqMlVRbjdiUlc0YVhwN1N6KzNoN21saUhJZWhRak92bkpIbGtUaE4vN2dx?=
 =?utf-8?B?dU8zcTRpZksyT3hsMExic2hFSXJLME5NWmh3ZDR2V2llYVlzcWxWd1puTXFt?=
 =?utf-8?B?bnlLZWRRMVAzQXgwKzdPNnNQdU5VbGIrZjFHRWZrdkNxRklmeTVsd3RwKzlm?=
 =?utf-8?B?RGFsN05HcjBxbFRtblAwNTFqeVp3cGJ5WkJNeTBwN0NpSmlyQXV6KzB0M0c2?=
 =?utf-8?B?MXRWSXNNL2RvaTZZS1k0aHArTE5Ha3cxR3IrdW9iQkpZSkFtb3lycDJmREdN?=
 =?utf-8?B?blJ5ZnJjOXpPTjVKSHliN3VJakg5SkZxdU1TRk05Yk9IL3FsT0tUcmJnNXFu?=
 =?utf-8?B?aTVCeXRRMTZNTTF3ZEdXeFk4ME5LY2pIdWdmZW0wQ1g2WkplaitsVmZzek8w?=
 =?utf-8?B?RVB6RElIampwZDFUQ3pjSVRaVmtpOGJoZTBTVWY5K0g5NHQvbm5UOWlKdnMx?=
 =?utf-8?B?WEx4WWIvNitITlNoZ3Q2VUc0MkxUU3NaSlE4Y3YrN2g3WVBwalFUV25WYlZh?=
 =?utf-8?B?MEpKOWJiRER4Q1Jra0R3eVp6WSs3VlZrYnFTS1A3U2xpU0NTOUYzVCs5dno2?=
 =?utf-8?B?S05FSVBtb0h1NnVIbjd2RHNESi9zLzdnNG1nbEVjdEZvSytiTUJDVkorVU5N?=
 =?utf-8?B?VkpTYmZ2eDY4ak5DM1NOQjZUMEpDUzg0V3VWUFhXNE5VOGhJWEg5R25JYUlV?=
 =?utf-8?Q?qOspOdu7hec=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB4PR08MB8151.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9536
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f5132f44-ee31-4f7d-ec50-08dddb22103f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700013|14060799003|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlRVQmJsOVVLUVNDcXo5dDRQQkNxeEJNSlZ4dzNlcG5yZ0k0WTI2RVhJaG1K?=
 =?utf-8?B?Z1FVTXp6RTFpN0FQbUx6MFU0S1orTEd3bXdwYW1rMDdMVmJhdHllQ2VhYWln?=
 =?utf-8?B?bEFPSXlwbzFiMkVTRWo5UlV4UnZmT1VxUjZJWGg2MW5OMVZjMXgxMHpyYnV6?=
 =?utf-8?B?L1Jvc2RzYkZyaTJrZU5NelUwbDFKQU9oNXlLOWd2TDNPYm9UeXB2eDFvM0xT?=
 =?utf-8?B?QmV2M2hUbUtnOEZOL0lSU3dsM2FBeUZWdVRHSlFud1hUMFNVWUVuWGMwRlIy?=
 =?utf-8?B?eGd3VXVzSThWcjhRTzcrbWFzS0xrS1FQcU5pblRDN3kyYnVUeks0ZC9TR3pk?=
 =?utf-8?B?VUNHVVZEeHFWVk9KMzA2WEZBVWxrMGUxbnFWSFRwQkRFbFhOS3FtOGxWTlov?=
 =?utf-8?B?cnRBeU94THdNVEhUOEZUMjc2QkVteUtlQTh3c3h1RHhGZTJ4RzUwUm9xd1FR?=
 =?utf-8?B?UWZHODdxbkx6SEltdVp1Qzg0R0xxRjZjWGYxQnRrcmcxRll2NlFoaDVWelpT?=
 =?utf-8?B?aGpMZ0VIaG5FUklKbnJrOWxpWHY1Z3N5UVdnM0FTbllPQkRZT2Y2aXBrZTVl?=
 =?utf-8?B?dXpScXhaa1RLQU4wN2ZZLy9Kc2lyWE1Ed3hadEJmbTl1ZWZwZ1JSaG5lQVlP?=
 =?utf-8?B?OFJlYUpHcHcyNllnV3pQaVdYOXVnZ1JDaklZdFhRYjBsbXpBL0JkTmRtQ3hI?=
 =?utf-8?B?bU1UUUhIR01kSXJDSDd3OHpKTU94SGtwWTFJK2RENVpLM1Jac1E5dVIvOUwz?=
 =?utf-8?B?QXEvbnlEdFJQUVY0NlpKeklzb2hxVzlQZ0RKWXJaM2o3TmxFV3Q4NGdkUXJ2?=
 =?utf-8?B?dG85dmpiNmJoL2p6TWR6bUxJenQxN3M4UytMdVpaTzJuQTB6QmJCZmJHNUwv?=
 =?utf-8?B?U0QwMlNFaGJMN0RXWktBdGdEQU1xNXVkZW1CRnBxSjdSQ3hmNTlzeU0xWFpr?=
 =?utf-8?B?Z2NmakovdDMwRk8xamJ1ajJEZUVFWHhyQno5NWx5Y2pySnkxaHFzRE1Kai9P?=
 =?utf-8?B?RDJvZEhaZk11K2FSUWJ5L1B5bUdLYXVwV2ZoM25YTjlJeFVNdW9tN2dhSWFv?=
 =?utf-8?B?QTlqeTE3UmlXNzE2WDV1b3NhM3EvZlJ5UjZXNVhuRkpCNjEyT3FydlNBUmhs?=
 =?utf-8?B?bGZ5RlNpQWhKRFRVeGo2NnUvd2o1eFN4LzdQWW9aWW51UVlWOC9YNjE4MFRH?=
 =?utf-8?B?d0EwRklaMmxTL0pkR2k1bEliRWdOL09PMFpiNUpiZTNVTFo1T3VCNEpSajk5?=
 =?utf-8?B?S3AvY0hCMEVUOGhoZkszU2hWUzdJTzhmSytwRXI3YmFqdGdId1puTkUyZEE2?=
 =?utf-8?B?TlUwSHY2WnozQ0tkV2R0Z3dZZkdJemM4bkZIcjUwODRFN2ZWekQ4RitWdnVy?=
 =?utf-8?B?anhqcEJzQzQ4V3ZhQjhGc1h3Uzd5SkZrSUw4N2F1aEw3YmZCQWdibWZRYk9q?=
 =?utf-8?B?anNKeElxWWRNUTN6WE92SnNhTytzdWtFMXUzMHFIdk1jSTMxaHR5ekNxa2dl?=
 =?utf-8?B?NVNZS3VReU5oc2ZmdjZIb2lQc2pUendZM2w0b3RxOWdWNUpZZVFleUpXVjgz?=
 =?utf-8?B?Nk5oc3V6c3JqdGMxcHorNmdNcEJWbzBrQVkwZXR3ZGxuV2t0d3F1ZkFKUTFG?=
 =?utf-8?B?ZEgwbTRJcmVHMlA4aUlHNlhqR3JoYmc3UzIzQW03aTBXck5PcmZ4QlhXc25o?=
 =?utf-8?B?ZVk1c0NnSGI3WXRxMXBpanYxdUtwd1JlM09YWmJCV05RZkp6WDRhL1lsQ3hB?=
 =?utf-8?B?YXROazJGTDkzbFVaME5FVE5ubVpCcEhFZDdMZElTNGlnMi9WUHc3aFFMa3pM?=
 =?utf-8?B?a0ltNWx0Y3BjWWowT2FKL0MwSVpTQ0s1QzZwclp5MEl5R1l5bUNzQ1JZSjNa?=
 =?utf-8?B?T0lPakxjVlJIV2JvSmFiNEE5KzZOQmJpc2cyellPbWU3cHBPMGVzVEdibFVi?=
 =?utf-8?B?Mm0weTVZSFUrMVMwY2hZTVlnTUdPZlVzUlhWdHQrbjBCVWlRbXh2a3ByaGhL?=
 =?utf-8?B?UkhpZzZTSVlsMEpSQVBCOVpXYnV3Y2I2QWZPeEJzdkxGclJDWHVuNDY0S1Jy?=
 =?utf-8?Q?yshmZU?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700013)(14060799003)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 11:03:06.2577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c355fe-47f2-455f-3fca-08dddb2225a6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7880
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

Acked-by: Paul Szczepanek <paul.szczepanek@arm.com>

