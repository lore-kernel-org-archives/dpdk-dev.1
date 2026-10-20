Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8BE606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i2xso0nW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4574E40270;
	Tue, 20 Oct 2026 12:18:46 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71]) by mails.dpdk.org (Postfix) with ESMTP id 189A840144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 12:18:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGZ2aPRaz6+6e2mNoFlYwEyFTIlrzmwdGyyOssDFWMcpB3S46Amp1JW5WDYwYAuZDDgECbZL+Yo03jDHpm2Ai9zPre+OUBG4+QHGVUuyIonlOuvJC+zB1MwgcRG+e5URm/NctxPThnpbYwOD+RgfU3eKbjF2QfrkPJDKyN3OoUntl+g3l5V+GMplssLGilmNN92tZLAKgYEt85hMXrWyB9+K7AO5C1joD1YQyCaVScZold2V707SHfCFE2i0BRbPPoOt5ObDVFTY/dP86sDUWmAAFt6ItXoS93UGhHJrk+emOYxSt6BHdaN7khA1EGJWf2LFeYGSJ6wjnMeZcsg8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYhPltSDoLWlfT+rHeODVzwZrV0/ghsYfSexbFJcFjc=;
 b=VKyAcfSNBhBChFzFyS8XTLGvacCwGz4X++7sZLdpzswpCyKyAdjogBFgNOta2Ya54qsc2xASH8oqcZArBxpG2csHexq7ytENYkf5cZbBKEsZyKFgk1+nkzbBrzEnnf//17yYkQQzdLcCPW73cxGk423unNxoNdW8EVrU2GmGKvYAo2QcoexeO0ol+TQ2OXg0msQXRr2TLGbevaQqgZOw74R9kAOwaJ1KNkPDknKMJ8v4HTM00jII3dCGhZ13FIjewbTyHUx5cIayoHrjOGsJDHqd/s9zvzYwEg1kXS76F3n0iunE8FBgCXw+WUHRTDCKss/9oUVLmyvLgxgJirqTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYhPltSDoLWlfT+rHeODVzwZrV0/ghsYfSexbFJcFjc=;
 b=i2xso0nWYWXS3nOO/NuNJ41X+5y0WvgQjABHX08RzAVbjIfHJDkvhrXxH3/xE3JiEbqe6rOwf35IALU/Fzx5M737tNnpQhveKwgnlQObDTkQ5LmohrCC2LkrYeKMPpN58+Nasl8t2vxTfcN5zyuRLGdwfhtXoriUsfW08gCYnjNSmr0b+UE4Lo8Z2DR1z8Rk99Sg5LKeP/8aWgNoyWpEfWwY5mLJycvUm7LG8Q9WWZLoMfnQTrq8mtEW48TTNvNTn7DjVUAtSZ7pAwJ8jVcvapzEFhGeazXQT482Nv/2IOqja24m8NX+jPxwdga9S+u+C1Kg7+qhezF8yLUsKCJ4Zw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:18:42 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:18:42 +0000
Message-ID: <ce649de7-fac8-49c7-b756-9aafde5764e3@nvidia.com>
Date: Tue, 20 Oct 2026 13:18:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stack: fix pile GCC memcpy warnings
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20261020084944.3188987-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20261020084944.3188987-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: da014e0f-ee29-430e-0428-08df2e938405
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LarlJG86kDe4orkeKPa1ABIkNX9/CzipVJg60ffQAcKM+7rGwE9rkc7o0OqnXKi21jvmF4VphYIfGGlSgjQ8honTIzChDorqqDk9vgvOjBBJcmcIlBsHvtIlwEagzU8uftrV6OtHkAZTGb67UKwf1CLi1ZL0D184HZokvZp/As6EznwHDF7nIl4TW35qbcOKWog+ZR6d+8qVsom0n+W1tQSEJUhS0bQJ9eowUD/k98BMZLOU5y48KmJRwpF7tXa0Bi2TRwbT4fmiDjRmvPEJfUz2XWeNffhtO3hjvGvag/ZTT0O5y8nFOl1nt2IX5ENm6k2CZffDLrrck1hbG45SCGIHMsf8J4/LR2PKHQWiQip1gAslDrd7BhoaCYw8C9HCLgcyiCY4VeknyFssI9Et3xXVdoYG4MOcelP03cvREt/IHCZUW8Mcj0V0NW4Ue6G2mUZgHdfZAp6T0sJG8ruKdlcoRP4vj/xKX3pO57sx21X3zVDerhvkmyOgiHXe55lWaWiXh1UHacI3BZq+EqqyoLjmHlUzMj3+8aWo/uTdm3pNdneC3/e/0ZBIeabiioiJSRobKKvVvPyRtVUZGKNdxQWXFT43OTO3MXGK6GJdSgECj7GxYYwx3SGY87NZZpjVOJtQaRKR+0rkZbb5V9SuuAELo8pDoMYisgYzeIlIdJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VExFaHRKR1VjZ3FteTE0dDRuVUVyWVpxaWdxbitwV2o0ckdNeDRjam1FWEs3?=
 =?utf-8?B?RDR2akI3Y01CSFJWM2xLZDc0S1Fzd2dUTFgzSHBOeFAzQjA2dEY2MldsMWpn?=
 =?utf-8?B?UVNjMDZrM3puRGJJdmVwQ0RSd01hc1lRcGpzSmpiVjhBaklnN2FrcTJURmN0?=
 =?utf-8?B?VHkzaGQwNUtoVTVMWDFXNjJiZmUvNmQrVjQ4YW16UkxwK1hKcDZFSWZnVmJt?=
 =?utf-8?B?SVd6Zy8vWG9vRXVxcWFVK3VPelhUVkVCeU1BUXdXS3A2S2dlTnpBQVV6cHh6?=
 =?utf-8?B?QnhjNDYyaXJuU0o2UDNtck5KNWpnV2c3aTVXRERWUExoWGMza0UzSFpPRmpC?=
 =?utf-8?B?TEtyL1ZYeGF0c2NJWXdGTUdaaW1GOXBMOGkxU0dGS0EySE1nTzQvK0s0alo3?=
 =?utf-8?B?aklWc09yVmdXMnp3MWhOSEttZ3gvRnloSTVTWHpUTjU5b2grNDIrRWtkenJn?=
 =?utf-8?B?eTZBSXpnY0JrblNWV0dVZSs1VDdUa21uWmIva1BLQkNWNkUvbGFEWDJKVzVZ?=
 =?utf-8?B?L0daL3RhWGxxTDI5V1RodFhYRkcya3hrcjNrTmhFOXlWeTB3aVl3bXVuWHNx?=
 =?utf-8?B?TkFqWXE5ZjI5SGtXbDgvTlRuMjIydjR5TlJnMEZZVGdPbW1UV3IxTGpyN3lH?=
 =?utf-8?B?bWVzdFM2RStFT3M0ZG5LUXVZVGVJWVB0dnVsREZOeHZTLzVwaHdFQ1dEaTBN?=
 =?utf-8?B?OFhOclhYOW01bDhiQjFZT29aRXVmTVQrYzN3WDd1c2NYTGVDeWswM2VLSXdw?=
 =?utf-8?B?YStVT0lYT1NCUHd5TTE4RForbkpIRW9JNzdnRlVGd2c0aE41TEdpRWJqQ1pL?=
 =?utf-8?B?MVlDT2dOU2hBQmpoTmh1aGVzTXlnYytLbVFPdFBjU0N0K3EzQ1JiaFYyWTlt?=
 =?utf-8?B?eVJZNGhwRXpIcGo0dUZTMnhHMjBuYysyNFN2Vno0UzFOTUdLQWZBUkwzZ0ZF?=
 =?utf-8?B?UWNXUWtrUmlkWUlwMko0U2tnZDl4OEdlMjAwSjZMM3JTeDhuRG1vZDYwa0Rj?=
 =?utf-8?B?OVB5dzNOdm90bWI1M09FblhTQVJiTUNuNEsxN3QzcUdDU0VqS1ZaVzhKWDlB?=
 =?utf-8?B?elRpT3lhbm5uL2t0aEpUOUxYRHBYT254cnVqWDNNaEFOTnljVzBxcFBYemRM?=
 =?utf-8?B?cHVHNHZyc1cxUjJIdWM0YnNleFNKZk1sUysvTHM3RGxCVTJucjlWUW5MZ1dF?=
 =?utf-8?B?ZStNTDFGOTdtaEJpTFhvSDNVTGZ2bG5XRVB6ejlTQ3hQUXdhMUxuQXNCSmJ1?=
 =?utf-8?B?d0N4Smx0Q1VrU0ZpS01JclIzbzdheXhqcUxwWDIwVytwMjV5R3BNV0VnUUlF?=
 =?utf-8?B?eEdZNjVjNGtDTlFmOGdHMVo4d1hxMW9JSHhyS2tPcmV5eE9wNnZCbWV5SGVO?=
 =?utf-8?B?UUM5VCtUOFY4c3MwSll2dDFheVVrOEIvV1JxdGwvVEh4NDRVUmZWeGt1QTN5?=
 =?utf-8?B?NXEveW4xR0JYYWg0cEMyeE5KSzFuTk5QR2RPR2hEd1JxRzNKdnBnM0NRTXJL?=
 =?utf-8?B?SzIwb1EzaFdiL0xvRDR0clpnNVZoUlhuRXpwdUhnYlRkQ3cyMVhWNGx0R2RI?=
 =?utf-8?B?d3lYWnpLMDdReG4zY3RTYWJOWTdlZXZ6Zm5yZmMxRjMrRStKSFBycmxxalIr?=
 =?utf-8?B?cm1aM21SOGpUZzdlT2ozL0tSRTFPZ1h2ZnZzNENOMUFIL1lScVRCQzhNNkVo?=
 =?utf-8?B?blhvTmQ0eDFBM1hBQm9ZdmIzNEJNM1hmRFZ6OWhYZXY2TkpyN1ptUENMOWZL?=
 =?utf-8?B?Z2c5UStaTHlrbjRuMFcvbXk3UURkTTJIS2wwenpQS0J5OTlvdjZmaTJ4b3cz?=
 =?utf-8?B?SmJYSmF4bVAvUE5FdVJxVXFRTElab1hNamx1THFhN0d3a3hFUi9zSGRQRitB?=
 =?utf-8?B?NHNwSVlLOTQ2M0VFQmkxVmdaTC9ZbXNBOFlzdmZjdXhVT1pqdVY5aG1mMGI2?=
 =?utf-8?B?MHEyc3IycVBMSXdFWlg3bXc4YzJQVlFCUVM5eTR5czlvS1VLUzZQSmtPMUVn?=
 =?utf-8?B?QUhJRHhEWFNtaDZOWUxxWmduc254Ry9HekdtMmJGdEZZem4wRmt4UFVuR3lJ?=
 =?utf-8?B?R3NqN1FSZWc0c1BrcTFYTWlHZVdrekZuemRrdHc3ZHVOUTJoaGtjNy9jV0tL?=
 =?utf-8?B?Z2lzbkJPdTRZTUdJS2VhZUUwU0tma085QmtiNDlsQ29qZmFBaEJPUnRpaTVZ?=
 =?utf-8?B?cCtrNUlmb05BYUNOMExHTFhsV0kvMXJnMXhqOUJ2cG9lSVVOOG5lclg4UWpM?=
 =?utf-8?B?ek9qMXF5RGJDQUJPK0NKa3d2MHBlTHFuNnduSGxnbFlDQk5OZGxMQjZYaFZ1?=
 =?utf-8?B?OXlUOWtYYThQRjREWGdDQ0NnelRXWVRQbm1yNU96anBEeHNUWStIZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da014e0f-ee29-430e-0428-08df2e938405
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:18:42.2258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fel0L1KHf89sHBaMp4C0JDZUsLvHKk9LlilWz6aUKxra/zerVu0w5J8MZUEe13xb2o3fsFhB4RyzmFRnzjee1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 11:49 AM, Morten Brørup wrote:

> On architectures where rte_memcpy() is defined as memcpy(),
> GCC warns about source/destination overflow when copying more than the
> source/destination size, even for code paths that are not taken in cases
> where the sizes are smaller.
>
> The relevant compiler warnings were disabled for GCC at the two
> occurrences, and comments describing the reason were added.
>
> NB:
> It has not been investigated which GCC versions are affected.
> GCC version 10 and up was chosen because that was what the previous
> versions of x86 rte_memcpy() disabled sligthly similar warnings for.
>
> PS:
> The alternative was to obfuscate the code, but that would make the code
> less readable, and might have unintended effects on architectures and
> compilers not suffering by this issue.
>
> Bugzilla ID: 2061
> Fixes: ee0822a0ef41 ("stack: introduce pile")
>
> The pile was introduce with this DPDK release, so no need to backport.
>
> Reported-by: Ali Alnubani <alialnu@nvidia.com>
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---

Build passes with this patch.

Tested-by: Ali Alnubani <alialnu@nvidia.com>

Thanks,
Ali

