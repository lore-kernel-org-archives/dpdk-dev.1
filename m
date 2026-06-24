Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C673FCDB470
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 07:24:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5A2F4025E;
	Wed, 24 Jun 2026 09:24:28 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by mails.dpdk.org (Postfix) with ESMTP id 6EE4F40150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:24:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7QCR8+dcjkPAyLrfBNoAxRbZNV71lYhSDbxbkPPMj3oWLB8z52Lm4h0ZLodb5Ez/5flUuue8KQU/j0VX1xUZOGDo6cQbq6ueuhAZIoGc9cPgbEtB6Y+CzcvTqeiEiberxhd4vBYmLZGJomYzc50akMJGa6NNbt9yTNe+EA7hR6T2AV1NThH0sPMzwWkt18VCNApG0CLQhOddVP1gZwelvymgSGNJhxeXMn2h0imAylJsFAQMtinJWNvcgV+P8A18QCYlKJKCuHhFn0oej8ZzHd/GjPWL8ok8si8K5QGyCgNr/Vl6zZTMzmpa+jjfFGQg47axBaSPIB4ixSaQTzKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhDHRk9jPIghB8gVH0eYsQp08X6kbvH6USV4Nsx1WSo=;
 b=XXhYWL1oaKbWZH4GZ+6bw5KRwHOxSyjs5lQDI1BeCw1TlRy//+XgrwfJB0HhRSuFY19kwvhJj73HTulsGPCN2tT3jn3MiI9WAtaCWlTgMnIqB1D7DE9WHHH6W4TDQQDdJ5Q2T/fOjMn5xmHBMpS+lVKMrKVxCEcG9cREZJZveeaH+cGu1gDn7EDTkNN9vRqSbYWVPGWTaC95fi26XveCOc2J2T19X/LeZUMm7DsK3+28rFPfnFAEfURQzOKFdAhg3JAr91M1DpTdLz9kqcLiUnOdWIFdgMD9norSt4HH3bjLWEqD/PmqiQYVECOBoX+ucSydrjTvOPbIph0coMhLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhDHRk9jPIghB8gVH0eYsQp08X6kbvH6USV4Nsx1WSo=;
 b=iZ9k3+pICkBDYXz9DJ7BrlxKn9YlitXQb3DZIg9KHFDfquJx6LWEHJQ0kQCecblJZoXvWKpxX+9oos4XpkDyb/HSRrq++YP15qX2jQoZqmK57BGygwtE1a+lY/qCWoeG+NlAkvhKA+Lk+daw1HPTXBLqwk6xOfgcwsyVs/3JCCZq4mF06N+B9Ng0HjRUYucvNux7fVbueJWR6Zt/sddgyXcD+y5+eP8kcDN6r3DRW4/dfnETaTemD/KDwdZTzQ5fnJ6fIgx4xy1UVCB4iBf1rXLxtUs3HClT07/KfIHUyA/ZF7XUOwQA9lWZIsTSFhhi3aqyg/DJMtmYUL6kYoLqcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 07:24:21 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 07:24:21 +0000
Message-ID: <73e1241e-2070-48a5-b84a-184106218dc0@nvidia.com>
Date: Wed, 24 Jun 2026 10:24:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: move firmware instructions in mlx5 guide
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20260608120531.1037367-1-thomas@monjalon.net>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260608120531.1037367-1-thomas@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f3e185-189a-43be-85b6-08ded1c19c0f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: GqAwVDYwBHQBSD/JkYTLE/ltAw1hOIhSWWIsQrssqX/cmNRbFmO0pVxkDVQwsUE7J0BI3mKspKhKpJz6GeNk/hN2SlMJWTW0kkFerzNUqozenYZasxNwWmQqfANSfaxVFzREC/cSg0j261cWWaem0E4mYO4resgC9Fr1lKt5lHLSVfJZ5bhzMGok+LtSk/P9CZn+RM6Kj9rHi3zm/7FOcIalFyzjjZDeP17aJLcGy4WuC70pyIG4zKA153cxGrbAjwm4QPlJlfgARu0QE8jZeEvnx4Pq3b8LXoaIH5G8tQ5OCmgzrmZMMixsKYqCJatBZdTIrBdIY+XjpcJtdw3NsKk8Y4J7MKHkoo3O2Dyqno9PLQuJUqJDgpn4FE4rZbtW+ET3YACjmt0pF/Mj5oRyI1j8FXq3NHgyxmeL3FmPnLQnIGWmzNV7/X1H+g92ZBREva6nua3iDnaMGl6M1x5ytsXb5ynrMK2p/wfIQZLPo9h0gjA36Usy3PRty0Czybt+A/ChugifGiQzTxPskr552dAaOQDx14nsAOUzbIWPM/xWmsq95NGX5nPHEX1DjdJquEe9eS/lD2L4qQPOnJs5QioF+qFSWpx1u7d5vaOi/uaS9HBBnkFQRTPhMAqJrbQ1EH9FVyliEXRk+Tlxth49jAMjxiWsu4C+2exjGNons3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlneXpnYzNmRm83MXJweElRUXdSTWczaUdXY1Zxa1FDL1VmUC9MOXFRaWh2?=
 =?utf-8?B?T1JNNjEwbmcyemtYRE41QWppVnlSRGMxL0FTVG9CcytWUFVRQVlwRHM0VVJL?=
 =?utf-8?B?NGpsekNwQUV6c2dkUWgyN3VYcE9aTG4rQkhOVDJKUVdKanJFL01OeTlnNXht?=
 =?utf-8?B?ZVN6Mm1ZU3VGNXhJcGMxSm01cnBEWU96eUNUWUpLOHluQm1BZ1RoQVk0RUcx?=
 =?utf-8?B?QnE0MFpnclNXbmY5dVMyVTZqT3hqd09XVndRTStOTHBveDVSOHdpcGZKd0Ri?=
 =?utf-8?B?QzVzZmIySS9uM2F6YUluNXV6dG1pSVpIb1FnVEg2b0xLdW1XZGd5OUdPQzJW?=
 =?utf-8?B?Qm5NbGh6UWl1cGZBMjdoQW9KNnN3TFpFYUxOWnRQM201SEVoTW5HMjlFYVd4?=
 =?utf-8?B?Vlk5bFZYMFhUUmF1YjVsZDlyRlZacFAwcnhOSUtMcEtrY0tVTU9GSVJOazB5?=
 =?utf-8?B?WFZ0dmhCemRjaXl0cWtLMjRhaHRVZmhEZWhnM1Qzd1JyVEZUSmtVQTJtdDRy?=
 =?utf-8?B?TW1MY1JXMnVoM3VLUHNHbGc5THA4UmFBM1VtRWJXYUdsUFE3S0FZZTI2RENL?=
 =?utf-8?B?OW1xeG5MM3htaGovaUtIa05aQkp4a28wTERmNXFQSWRGTnVyRVd3OGFDOFZ4?=
 =?utf-8?B?TUhHRzVudEdrQlhMOXdPMitlM3YvMHZxYTRHSjM1ZjgwcVd5eWFWVXB2R1lX?=
 =?utf-8?B?VUtDQ2FJdmorc1d1TGl4b2RTd2I4VzVZVVptcEE1dldsUzc2eTdSbU9vNkpE?=
 =?utf-8?B?bFRBMGppdndQWmJlaTFsVWNGZHg2U3VIYTM2NE9XUHlQRVc1eGNsSWlXN3lx?=
 =?utf-8?B?VHpMemRhUDh5VndRd3dOaDJkQ2QvRkJRQXgyR3FpYlFOOUV6cHRuZmpVT3Rk?=
 =?utf-8?B?cW1RWko1eXBRTHpuS0ZsUGVJcllyM1BVU2RNbTgrSU5zcnlhM1BkTm1xK05Q?=
 =?utf-8?B?WU13TnhyME1meXNibjVYZlNxNTRTakdSS1JoL0ZCeE50MzNYWXp2eEdCRlFU?=
 =?utf-8?B?TGoxT3ljQW5TcVJGUDFTMXVKQlFsZFZZRE1FZHZ6ZkRBRmc0WFJXVmtWUDhv?=
 =?utf-8?B?YUdXWlIxczhSNGlHM3RVUEllUksyWHVtb2l2RFY3c05xY1JGMEEwNUxETkcw?=
 =?utf-8?B?aXVQbzU3aHdKMzVFcFJHY3BRVjgxU1BlQU9xdzVWN2cyTmEzYTZRclhoQUE3?=
 =?utf-8?B?SHZGeDBOZW56NURFNVR5QTFnWmVHRERaNThiaGFhTnppOXdLSysxdzFDMWl1?=
 =?utf-8?B?QlVKQ21RaUhlQXJJTTdaVkM1TnpHL3BkWmhsaEdlK01hOUdFeHQ3d3hsbC9w?=
 =?utf-8?B?R0hVeG1iVENTcFRRSW0xcDhHeTduNjJZcnhRZkRybm1zT0JSNko4U2hzZm44?=
 =?utf-8?B?UGtqbWNuNkpnRUF4djNwRGxtSlBieEloY05ucXA0MlNuMC9DalZUUjcxMWhS?=
 =?utf-8?B?YjgyKzZOQkJCMDIyMkhkVllpZkprSTBrWGZHakNOUnhoZzA2d0JHdEhwKzVP?=
 =?utf-8?B?RWY1ODJGdnY3VVVteWx0N053aEE0aHpYNkhOMDZpZTNtRHFqdWxLWjFRVHJ5?=
 =?utf-8?B?ZmhnY2RkeXIvNitjdFNackgxL1NoRmkzUysxeHdtOXhoNitJZE5qd1hEWGJa?=
 =?utf-8?B?Z1FudnRBVlBkMWt5VXJVTm9QVCtnc2MybHBGa1BPRGdDWDF5VTlpN2syb0xa?=
 =?utf-8?B?M2RxQ2N3YVpYRDFTZXlTTWt2T1JDaFMyY1UveE04OE54WWVHN1FzQ0xKR3F2?=
 =?utf-8?B?MlpvUDBqMGxBVGJIZG1veVRnT3p3cTBzNHNPamNhaXozbFhZVG5ITmVtZXRs?=
 =?utf-8?B?cVdtdmxpRWdxdlZ6RjdoY1JqV3NwR0xEclI4VCtweWpDYUZiQStsYTNtMTdH?=
 =?utf-8?B?b2UwYklCZjUvRlUzTlFjWVFOdG9ZNjJRbWRGclQwc3ZFZ1Z3YlFCbmh4S3U0?=
 =?utf-8?B?ODRuN0JVOXAvOUt4b2QwOFZYcDJVa0MxQktZZ1NmWW50MWZTQ3VRb3NzdXFJ?=
 =?utf-8?B?cHdCSDgvQmpsUWtCTXpUbDRBcE15R0Z2RkFXQVFqaHptSCtRbU1HdENTc2lh?=
 =?utf-8?B?NVhLSzV0MWFoNXBFSldpQlArMitoZ1NpK0s1Znc3MjF4eS9yU2lVbU5IYjRh?=
 =?utf-8?B?VDcweUNvS1JzcmRzYjVyTHpuWG8rZDN5aURFWDJkM1o0cW12b0w1bVlVVVNj?=
 =?utf-8?B?cDN1VHBra3lkVHNyOFJhMW5PdzVDbkpNbE9McnZtbjNxWEc1aCtJb0JVeE1Y?=
 =?utf-8?B?bGN2NkU3YUtKRDFoNC9TY3Y5dktyQmxNZm0yOU5MMjVYV05kdEwxZ0ZCQWYw?=
 =?utf-8?Q?Id+1xal5G8e4TrGYDK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f3e185-189a-43be-85b6-08ded1c19c0f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:24:21.3935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3j7s0jJwWjbxN3LO89XC2SV1q8qyeHKQ54IkjqN4Koug1mz+cNOw5wpHgWO3r64qyFerx1w3/Y0Vsb0y/pAig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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

Hi,


On 08/06/2026 3:05 PM, Thomas Monjalon wrote:
> Having firmware update instructions before firmware config
> looks simpler to find than in compilation prerequisites.
> 
> A link is also added after listing minimum firmware versions.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

