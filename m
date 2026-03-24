Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4385F54AAA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 13:03:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EEF14066C;
	Tue, 24 Mar 2026 14:03:25 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by mails.dpdk.org (Postfix) with ESMTP id 8C5984025F;
 Tue, 24 Mar 2026 14:03:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb1/932csgtPeYVB0V77Nio1SyNkXPeUDvLN4JvgAJYfTt45CHoPOKhcbcGC6YVWTDtc7xP7mf+me/xXm5cecV9gBFsPM6u//Ibxp78wn6GUM/fgr6hcnxQyzxBLg8QEhZfUItKkuPI3XZixG/n+RfWPgwK+cyLLfdzLgkXKhSiAYzY21iZLsM//1d0QkLEpUTLPprFQBhh/RmsBF4IlJNgLcp/Bd0OcewBAop/h7YivIFpEf9NiD0c7yzayH5W2qxhNSrU4GjONTzTfgCCIXaTMmEldelfx4d9+cs3uOiGeNM9hZXrZPwOdd4gmgv0OO1UtAt2Ya9UpdfY5qTFpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfzC8rUvKvxnu08iOCM8FEsh2J3Pfbd9Eo9LEjY7IQk=;
 b=rUUQto3TyE1RQwYdUiHzRBsgVXJ4MsZMTXvIyzqxwMJ+VoS3d8aSWv4XV3uE1CzpaDLywhUr77SRcYXejzVpH3bb92C74yKDU/AWHj3oJoEk74op/uJgFbS4+m0pugjsIM6hgsgM1Rg7RIJHIlzHtBN/aOe/kugqNTntPz/zLolaNVlQUGoP/dTzNtxd9lXu/WbeSgAkEcGtvB+iYVSLVuJSqHQK+dH+M1ZL7MEqeGw8ouSxm3vTFIzWGegqWDnHu9VhYZV7HVMnda8tp0sYIJVinsgeV7X6i9z1owbBuYWnjO0H8LTaUsjtY522+EvUS8/BzCjA2kN88FfYVRGoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfzC8rUvKvxnu08iOCM8FEsh2J3Pfbd9Eo9LEjY7IQk=;
 b=YK/WZnSnH4k57mYCmjUvboxAGlARDHWYV/fJa8lE5rJqI+LUW8gM1fnwk0DsMvbJq9R5XPJRt2gQUe21qy4ruYufeQgWLe1MnT4GwEhTTXqKUyVkiYpwheA9cwphnIVcHopmGGKwjQRa5OVKQTWvn+6DbKP9ws/wWjcLXPbsDJsDRX65CtD3XQd/ShKKyMhdmYl7KGdpPw74AA8T7wvcH8TerFyrsrSOomBhQfLTJwvPHRGOtGHdabdVyhoL3m0ycAlZM04kR5hHz5rz8aTKZ523ya/Pk4FxxQ1HEFKo8lBFkSInkkkxhp7VdJIpqY4WcJ6CydTiKb4sl28xhMuHBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:03:20 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 13:03:20 +0000
Message-ID: <a0aed7a7-a6de-4ea2-a44c-e5e1c71841e6@nvidia.com>
Date: Tue, 24 Mar 2026 15:03:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix flex item capability check
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260323102059.791194-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260323102059.791194-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: ba76e9ef-1a66-47fa-b799-08de89a5b8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: iuGXTzy0VyUFQDKMy4OFr/wvfULfLIFsoaD4R+IP+bfoZ9IytquwygrGbiOd3NefSutBUv2V7ToXNbN2w0AKV4K3dW0CagLYPR5AhK728LIP4eETg0hWLh25rPDr0xIkva+4RtZlSpEvNZFWORstuch0yIw9427ZNdruHBTjgrGZmOvo/5zJlH14QdtlC7/ebG1PKWUYj6RlNBc44cP3tod6Thj9ztaKAjTQt2EdjECgsZLq+qFIu/Lm5m7a/ZCwSXJ8LUVIWmiAxMx6hNS4rCLc+8NF2Hn+EFMZoW2R1/6tQpxaXIcqE3vS5hEKHzZBkfb97CjCTdBFL/bVN43mlwMmGnDruUQQbmAGK45C0g4XlQaNw4kjw0Q/Vld92A2GqoAgp5cVIiNQgb/80YD7HS0ESoDBn8tiY7m5VJMU31tEQ6tx13tPkA43ACneBhmosKGg10uoGto0e/3b10Q8GHth19hePtHhcsvnHdLG4kKHFvTGatNf0pWfuL8YnkxplV7ZPx8bAAAx9drgruWlpLmjbRG5e3JZvDpiHNaMwLEbjJdROvMGUxUHWBtZmDL0FWFDslT+PMWcQdrh8VpK+aW/HYsBCzOFP4d6HTA5B9zsTBe6D0YRUViZ2m6vN9TfPSabzvfrxOO9rkO5mlje7mzBlMHxrapu2zB9m82hSRHPXYLF5PWOGqiuidHZD5wfbVSzKWdxThjTW2K3eYa/HdpXGVUZW08q/9RMNZ9f310=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHNUQnlQNDgreW0yWVY2WWVBTFN6SnpTTSs0eUx1amRlUEhrR0toK3hTR2x0?=
 =?utf-8?B?aGpjSVB2Qy8zNXY1cmtSQlZRdCtHQmFmZlRVL3p4cmZ0OXJmaWhiYkpNbkox?=
 =?utf-8?B?RlRKS3Z4MHdZYktHN2trNnhqUWVrTHFVR3ZmM0N2RktVWExJRkJIU25MS3Mz?=
 =?utf-8?B?RktwZWQ4OE5KbnUwOFdTWDJJaEFDVVZHakNHaFMwL1h5Tyt1VVVlZUg4a1Nm?=
 =?utf-8?B?Zy96a0lNanBqMGkvTng0Szd5dk1tdmY5alZtZlc5aVlibUxBVDYzYWdVWEVs?=
 =?utf-8?B?OEJ1SldDY2RGeDhTZGpFS2k1VVRJZmRTNDJWVG5kc0dxU0NVNmkyV0tUZVBl?=
 =?utf-8?B?U05KbEh6OE00V2VFMVgxYzFMVXgxSzJJRTIxTFRsNVF4Y1RFbEw3Nk1SQ0dH?=
 =?utf-8?B?VVllSUwyVFlUUEZVVWJsVEFGQ25LN254K1J0Q1Zqc0M5Q0srYW50WU41NWtX?=
 =?utf-8?B?T2pHSS9tTXd4QkQrd1U4Q1hFOVFPTjhvdmlnYjdySGszS0JTclZrMlNhcHQy?=
 =?utf-8?B?eUtLZENDWGRaTFh3K2MvQ2lCdHN3MUpoTTFoMFVDbi9ycG90cHF3bUd3NkpX?=
 =?utf-8?B?UFdzRHpydG5BSWRoYm5BNDFUZW5XVzZMSHRHc2xLb0RweVhwdlRqSFJUSUhZ?=
 =?utf-8?B?bEpuTnhBOFI1WjhxbmZsOGZFYm9Ham5jdFhoZlFlWUJEdmpRRUY0S1pUdVps?=
 =?utf-8?B?RUpUbDNEZlZmT3YraGtiVVpDRFk2emNLbDhZQ3doSnVVTDNSUmhJRGx6NjZj?=
 =?utf-8?B?dHpKM24rMU5ka0NmUCtvRU9WczFNZkhLZUdUcmpPdG55eDVJaUR3RmdQUHFo?=
 =?utf-8?B?QURERUUxRXAvNEdFeW14OUNXZU5xNjVzR3Y5M0NyTWFQMm85MnB5VU4yNzB2?=
 =?utf-8?B?SDBEVWJJanNFN3ByQ3VxYncxbmNCZFIxYlpzQkJFaE9wb0V4M1E5Y21kTVJP?=
 =?utf-8?B?N0VFUlpuaE1qZUlTQ1R5b2xWalNmSEY5S0c5VGRuSGI1a1hVSEEzYXAzS21X?=
 =?utf-8?B?UFNhUFc1c0hZNjlsUjZ1VzhtRVYyc0hJS0l2bEUwZUhFYU1MR3VzVU5PNUFt?=
 =?utf-8?B?eFB4UGwzTnRtRnYwcnUzcGJHNE5XL0o4b0VwM0YwZkpKWUNNdjFhQ3M2QmZP?=
 =?utf-8?B?cGU4OEFVMFp2eWdsdlhzVVBIZzk4M2dHRUdlaklQY1JsUUt2QXJmQXhSU0ZW?=
 =?utf-8?B?MEJVYmxtN2I5aXFranNSYU9tN3Y4S3NDQkMwbSs1Z2owdzJVQ215bUk2RERv?=
 =?utf-8?B?c0c4NnFqaXFZZHJJT21PN2hlMW1XV2RiVFVFNng1aWRGUHR0MlcxRnpPZHdm?=
 =?utf-8?B?a3ZxSVFMN21laVpQODRvVHRJdnFJaDlRYldMejFoQk9JdWJLUlgrN2R1ckZO?=
 =?utf-8?B?SWhWTm5CZWhrb3NpRE9NUkZqSUVaZGFCZ2Q0REg4MFRzdHpIMDRmOHJHM3N2?=
 =?utf-8?B?b3NUTTZMVkdSQVE1QU42QjRia2VtLzVsMElSaXY2UHU5MSs2dWJhbjNFRXVN?=
 =?utf-8?B?TjhSZkg4cnVlQm1qeUZoN3oveWdYNnFLSUZFZ2k5MzY5Szdwb2FGanVxeC9P?=
 =?utf-8?B?YzFYYW9kRG9vbTlrNWdsY1ZuZXFPdVJkSmxQUEFFMzU2dEY3YllFNWFoK3pI?=
 =?utf-8?B?TVhxSDJocEtjZGNjbHhiSlFQV0lkWjNOQVJVQVVibnMzakczekxCS3oxY3ND?=
 =?utf-8?B?TnRnRVNraTA1c2tQSWpscjRKTWRJc3pUVzVwUHltTUxDVVFvd0dOS0dsVmNv?=
 =?utf-8?B?RW9aZWJnQU1ENEhickczZjdESHFGUHRVQkdoeWJ0akp5OHg1SWxYZEVZTkoy?=
 =?utf-8?B?RVNlWmxoQUJmak1wbE1EQmhNbGgrL0tRdXZqcnI2RXVSWnpTeTZtbFJrSEdL?=
 =?utf-8?B?eVFjUlB1eVcxVEJwVUxMU3p0TFdEWEVFM3MxT1ZoTENGRUtPWVdVSlZnL3BD?=
 =?utf-8?B?UkpERkY4QUhHK0xaWTQxZFJwL21ZdVJqRlpWQ0xIYXBRa3k0aFkraFZrZGEv?=
 =?utf-8?B?aTFndytnTVJhb1hJRTYwODdHalhsU2RveGxqR2p2WDRkOU5yZVc4MGpqa3RB?=
 =?utf-8?B?TmJGOTlJOHNubk5udWluazl1SC9XdWo1QTlybjd1WmsyWHZCV2M2R2p1aUF6?=
 =?utf-8?B?eEgzMnd0L0UvRWpDTE1yQVdVdU5LL3RYQzVjUW5VMHB2bmtNaTVtUC9vb2Jn?=
 =?utf-8?B?L1NkL0lCVHlzTVpjNG9vSTB6eGl3QmgveWU2S3dHMEFqQk9WU0Q4aXNXR1p0?=
 =?utf-8?B?YkhFMnVxVHU5V0NXNG1YemFWUnUzdGI4M0ZhK3VrNldqRlZLUndKM0FYcisv?=
 =?utf-8?B?L1JoWTlxRVUyQ3k4Uk85N1JNU0F5Qko4NTc2TGxOMy9ybVRZRWtCUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba76e9ef-1a66-47fa-b799-08de89a5b8c2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:03:20.3215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWJ6NTLBnipQwGbvJpR52MPC4lt9mGaWH8BelvNKWI8Qs0zDC+X6LXIeKYW/FP6M2Uy98ZsENyMEwVEXAwWlZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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


On 23/03/2026 12:20 PM, Dariusz Sosnowski wrote:
> Whenever installed BlueField FW was too old and it did not support
> flex parser, mlx5 PMD reported an unrelated error
> on flex item creation.
> For example it reported that:
> 
>      unsupported header length field mode (FIXED)
> 
> This was caused by lack of check for flex parser support.
> 
> This patch adds missing capability check and
> adds proper error reporting.
> Limitations of flex item described in PMD docs are also adjusted.
> 
> Fixes: 71adf25dbfb3 ("net/mlx5: fix flex item availability")
> Cc: getelson@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

