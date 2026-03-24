Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB1F4613D
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4C92402BE;
	Tue, 24 Mar 2026 13:57:23 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4DA514025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 13:57:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKB2biNXIBxyBl4n6+Y7B2FU8Ddty795bTp6bpp3bjeuksLUeZk8eHEkLsPkf1ecbsavj+v6yX7gMnzGy+1vgTdpkI+zuEGavf8V4EoqIJEkZ/7THxxHMgSPINGK5UkuFwVxCquTS9WSDhiBIyMXp7JlpezX+UM6zi34rngyG9yPCzbhpBwPu8St9DbL8dBeiMJ185ukWZ4JC8lRF/RkCpoevHSLSC0GoyMZ7lMJ6y4D7JMFwJnDrEY+djFNC7BvHqBy1cTN/oz1VtkIAcZ2+bneDqbtNiZto6Cpfu5tcBaD3irFj/YMcGaHdva1d4rzx/E/SODeNUOe7EWdGtcnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEucfeJwpLTIrjwp5RMpRZg2qg3178JVY/5u5XWlm0M=;
 b=mG1P3/RvXnua2ZOswzPBdvHXPFDHlpsGODMB7KWtsswSRIH1T1nZzmhYFss8j2PErdgBsSAbo3kYz9qwXXtk5EvdiQ9WbpihVa9kohXN1d1bhL7cNAAnfSpiursbaFuPb6DP8ccwX4IASyVbEeF8qhfqye2vzyrOuPS7NFvmIsQKgXZNHH0iAXzFIjh/LyuMP0en/JKLKUHP8dVN1mYL1v7e6dmO1L6+xXI3FPtXQj6JeaqzqUYxVwc0ZSeNszAmo2YtcZ6dZlko8vGq6Srq4VwBrfqTwZ0dAJ5zllnWOWnPQXM+UDA3ILk/7aQgIUJdpWkUU7hV4VB8Ydn6UgQAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEucfeJwpLTIrjwp5RMpRZg2qg3178JVY/5u5XWlm0M=;
 b=UnHAnLjImLNvmxdbthX7eEq1u3SjNQODA0prt0BJUahNl1qRkBLYpT7Oh6JZJ2hXZfFyuKouZQnm/waYjOrrBG73W21aVx1DFF0/NQ4Y49wgfX3BXc0uH1Yqy+KBj5HV/Bvg5zMVQp3MH2QzYQNoAHXA9VgJh9bgcYUU0czp+9l5vrJMSZlX0TcFS89siK7BERezfcx0F3B1MAuhuK254uex2R5HVHwNW8d9Pb0H9toQepCWKpi88l+JaDVmUF8kt7uxVbffEeGE8leDn3egiBT/n27hg9CrHWxzv5/TL+2nhlA+k4UfAkAeYjn9mE590q+3KXrpie2rkCJAynlILQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Tue, 24 Mar
 2026 12:57:20 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:57:20 +0000
Message-ID: <bc8972f0-27f9-44ab-b143-e5cc3a4d4294@nvidia.com>
Date: Tue, 24 Mar 2026 14:57:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: cleanup unused Tx doorbelling routine
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com
References: <20260323101410.393887-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260323101410.393887-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe70d91-076c-46a3-39b2-08de89a4e24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: MPk8yRLsUMz9chdJbRxil9V9wdvNk83WUCnLvTh+Co18E2orr+lkX74BY5OQfQXdcCkyrcbta3TrX3AXGXUFyR9cFO170AsI4pEU5aRe18aq0JYh1ah+/iPO6G1ffMMbHuQxbe2dJuV+0uLFJrnUEYlubd3jme1fu1I/AAu8S2g/vbBxuDG9Hzlsdr9aEtVuuQ4mEwdsopyZt1rYNkXX1NlYYHSwZctWnnuzntnmPtkviHDGJ55dnY6b2kgd4NT4piSkwewqUrfjMgo5PcBD/MNCMYTRgNbR8Sg3zntjw/V55eAEVmD1f6D7092fstZSGho7mO5XADV3hZQuAei+nhVqcHlwFAuYBPPTxKMw4Tgf2YhrDwnS+rA6+MMi+urjIKc0oEcxHpiP9qXsM/NETYwLXJUyBb8YL0zT2KKQkcwPo2XFrrIVTBJqiiOnzg2A+INZdzRXOdFEx42ERiGgSBagizIt7rfurv5V+9LrbNzcZ91984LzLSQfn5zX3gLACwstWgtBuUjWg48zTMp0BKrHoTjWo+mOag3T1aoVifL9jsNqORvKm+Tp3UhRwQHM7rsoShDKMJJBTbh5/wJUBTiM4Urn1wXbLHjfRjaOvaBaUrHe7NgfbNSn+jSnzBt/mYm9kg5zRGOTEAuWVcT8kyU88ezlV0Y/GLlW7Cvhgws2v3dPhArE1mZf8jd5mlzWdpf1H14xdrbXjd/EpMPpgOzdjYEW3jkiJqnDhWsSN7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVFRVFdaeW0wVEZSQWdJZXd0VHB2Mm5uZE9oVkRycCszdlR3QmVwelFsdmJG?=
 =?utf-8?B?WTZUQnFPVGdlRjFUK0IyMmh2MFBNcm5GS1lTMis5Q1J6QlQrUmZIaENhbitV?=
 =?utf-8?B?dGpnNmJhRjBsNmhyTWVuNlphNk8ySG8vNGdlRVkxd1hmc0hYN3p6d3BIMFA4?=
 =?utf-8?B?RDl5R3ZLWmJZenhyZ2NScUtTUXJtM1RsVzB0UzE1Ykt3SmJWNnh3RVZFZ1FD?=
 =?utf-8?B?eUFwZW5WSE1wN1ZIT3Evd09LTzRzSEQvdE1LMFBBelNldkFUV0U5eFZNd0tX?=
 =?utf-8?B?R3d5Z3g5bHlhcG5DTHJiU0Z6cXR2ek9zbzJwVUlBeEcwOXNwNUpoVjFtTEY0?=
 =?utf-8?B?VGJBdzFSY2FsdVpVY0FReGtvNlRneVhqMGJkYTF3TDBTMWwzUnNkUVczNTBW?=
 =?utf-8?B?b0VXV1pNL1IxWHhCRHJ5MVMwbU1LWklCTG9YckZjeXhtSm9rdU9pT0oxc2sw?=
 =?utf-8?B?U3Y2RUZFUmRLOTlQWUJkbUM3NklURlEwWGtDS1NrdXp3ZmJKM0pSZDk3ZjdG?=
 =?utf-8?B?Zi9PS3E0WUpOTTFyMklFMWNvaVhlNDhCWHd5ZzcxY29xOEFTa3FFekhTZ3NX?=
 =?utf-8?B?amJYbWNieTlLLzRUZG5wbC81aHBHaU9PZEg4TWtFNnRTTEYvcUk5VDJTS1Bw?=
 =?utf-8?B?RGI1U1VFNkhBS29nanZVd1V1d2s3YkJTU2N3TUd6YXVBdlNpbzd4M21hdDNF?=
 =?utf-8?B?N0dKT0ZjL1l4Ym1jZWhyU3JyM0NrMFlILzlVQS9SODVUVjJPRWRTMi9JcTNw?=
 =?utf-8?B?TUx6YjNsY0xrRW1Cc2R0WkdsTGM2S2hZalRlNnY1aUJ6N2c3b0NaWTJ3RmMw?=
 =?utf-8?B?d2NMTDZya2VpM3ZUbHFmR2Z4V2lzTW1QRGpWMGh0K3BxOTQyR0lCTUZxbSty?=
 =?utf-8?B?SzM2MzdUWGxoZWQ0K0hGQXkrSHJqak5VNXhJWVdqeTg3L1FzK293a3hrblVi?=
 =?utf-8?B?K20wMFFuMkJMQTZOY0lBSUJ6d1FCNEV6QkY2NWU1cnNTUFlVaDFUbWJlT1Fp?=
 =?utf-8?B?ZmhoelhPRDNhWXE1ZGYyVjEzcWJEYjYwbE5wb3oyRk9hTURjNzh4TGxzNHh2?=
 =?utf-8?B?a2dMaTFiSXU1bkNlY0ppZHd4RUI1N00vWVIxZGlYVnZSYzFqU1JnQ244U0RS?=
 =?utf-8?B?NmxtbVRXa29taVFHbzRuM0tRbHBRQ3dVbzMzanNMWEtKOWIyLzFndkVObG80?=
 =?utf-8?B?eUxmeUtZSjk2SFpUc2x2SzRpZkRMb0RhSUlJMEVTRFlvMkdibXU2T2k1a1Jp?=
 =?utf-8?B?OFF6QzY0eFlFdHpveDhpUkFlbk9ZVUl5NkxHcVZLeDQ4SEVjekFSckRMd1do?=
 =?utf-8?B?TnpOK052N0VWOGVucWhtYW9BaGRJckRPVUtWSmgzUVZySnpmZzNqS1ZzdWI1?=
 =?utf-8?B?VzJhb0JzMWRIYTdxcTZ0ZXFKR0pLdDlUZ2ZpKzFaTzhDVWtzSzY4SFo3MTl5?=
 =?utf-8?B?b2NhampVTG56QzBmSEVUb24xcmFnWm4vNk9QVTJFOHgyeVRtWE1ERDBUdXFB?=
 =?utf-8?B?ekZLUHBpWWRGK2tvdFp3aDRtdHAwdWJsdEE3MEkzZEZaL3JlUDlYenJvZ2dn?=
 =?utf-8?B?ZmpoRVFveWltaWpJTlg5SS9Scm05T3NjbWIvNENyTkhPcDV4VkhpcklFNUVJ?=
 =?utf-8?B?UTNRTHB3T3pKSksvOURKMG5mdUVrMkFKUjN3cTczL3RFMUd3dzNCTUF2U2RX?=
 =?utf-8?B?Q2ZtTDZpTVJydTgyWit5QnpPa21VcnY1Vi8rMUN1MnNZS0VNaFdBb3FzSTA0?=
 =?utf-8?B?dWdaVUFlRzdabUMycG11SXlwSjJ1VGIyMzdKdmNjVldNNTc3d1g0UUg2dzFI?=
 =?utf-8?B?Y09RTmJEOHBOVEoyd0dzNFg4N3IzVCthOGQ3aGhkY3ZydzgwUEdVaWxVTnhR?=
 =?utf-8?B?dnFXbTdPY01SOUFxL1FyYjhlS2tSckZPT2IzbFFTNjMrQ3A5a09jS0M3OG8z?=
 =?utf-8?B?NzJtN3Vqcnl2UWU5WlRFblY5S0t4cWY3V3R1TkQ3R2Y5NWtzMWhvS3VIbEMy?=
 =?utf-8?B?SmdEbjBEV0Qrd0xqZDBEdHpUWXd1cXl3UW9WWkMxZkNiZzd2bnBpUS9iakJP?=
 =?utf-8?B?WCtEbXljUXlFcjdVbzZ2cFpXL1NKMXQyemU0d0RrQm8rU0FnSlRUY0sxVmh0?=
 =?utf-8?B?ejQ4TGdhcW5RZmNtQ0xDamdnS0pDOHVmei9iaVJXanIzY3k0a1Vja2FuQUZG?=
 =?utf-8?B?aWExbjRDMVVQL09HemJkVFdZQTEreUtNQzNia0x4NWIvdzd5WndlRWxLR1ZN?=
 =?utf-8?B?bUxMRnJidzdEVVJ3ZU9xSG9RN2RueTIxckJjcUxNa1NGVm1DSnNSMXU1NkhQ?=
 =?utf-8?B?MzhUYitKM1Rmb2piMEUyQ21KS3pZM0I3Tnl0Z24rdzUwS2liZ2R3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe70d91-076c-46a3-39b2-08de89a4e24b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:57:20.3434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY06gxxyoeQ5zMG1KHPL/7SOJmURQS0n9pZgR4Xc6UYYcADSOY6J6HrMWkVbA9DeW1fWR9a2ytTQs1NaFl2i4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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


On 23/03/2026 12:14 PM, Viacheslav Ovsiienko wrote:
> The mlx5_tx_dbrec() was replaced with common mlx5_doorbell_ring()
> routine and is not needed anymore.
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>


Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

