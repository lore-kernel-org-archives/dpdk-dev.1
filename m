Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5A4EF06E2
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 14:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E631C402ED;
	Sun,  8 Feb 2026 15:15:30 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by mails.dpdk.org (Postfix) with ESMTP id 35DC14028C;
 Sun,  8 Feb 2026 15:15:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvBBPnp1aiCyWWTCBufgMdtBaypZljYWOpzqyOuMycPXBLVgsRbbISqVk+3BhiXDsnIcbpQ9HkkT0BABYlH9gVwxkubLdTsgivrR5b5fwUZEMnb5UygFpKpLVN4mdQMl8BzoT4tqVDRgpO1KTjnUvYC/cI3SgGIBCkihRFVrnJCx29tfb+ddPvcZ+THI9EIyRGF3ecKZn1eZEd2NrP4rp4DgIipoyDRus1QhSyHmK7zaWjPVmkJ7jzKNzYGQDuOiZtrwV2R37N0tOoX1cm2vudwu7FWsMs2zm2QxkQstGoTNoselVgjunzUyYDklnSmWEaVwFtlLl1sekGitgbRUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jdTKMGIQMn6vN1W6YY5O7HVFGYG5JM2BOR/ljL9ags=;
 b=xJDmDG0qFnGyIgRnnkaB6ShF8EKXNAIAZj32uUp5hb3ApilKyX0nAkD5Yy5y97wntpptkGZDr3gJpZiDnWjrDu0iyt5IKSl95ZDq1VlXaaXmlY2fl3IWXrMc9W5cjjFbEGx2WKaWQDvXhFRq4FngibcONL5o1CMOgeKnuEUuhPR0dxRk+fNv6vLLPeBAXocJ+a1kAdARvR0VDGa4Riw6gCSdJxMmZ5jMkoJBfmrOSwwYkZukha0qzwsOPBImittNX7chCTlVimrlKlgKDfGYHM4oGMg9sGDv10i5jK2Id0r4DvAkj83kI7RpmW45zQCCO3BQvdxcZ7AC+PH9M+X1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jdTKMGIQMn6vN1W6YY5O7HVFGYG5JM2BOR/ljL9ags=;
 b=MvHUWeXpe0ZMrSPHI0NwnWykDEl8lSn3Qb1VvxbJiVj1+c//1nGQLZQNkS3/PuOwUmOFUhT1H2/O8vdQphW7G8P9dibPrbRLNjGGQiefJggtatM2a7OP/ahYJelkGe7DWoWxil6C0qgEaFud1EcZ4jxkpH0UH+NTYPBVdm3DexMAP+3wBvgkAhgfLzm3XS6Mt1HnsYO4gcdbMVru954yJ1qciksPX13nId1D/BLqtSdpyFJ8wrd0SMD+irFMGFF2UM+VPsVPvJwG6eCXbl/UYchRAmD/Z67xvS97VMGWkHecDtu51vYUkRG/GDCXnqrQlFUpoLYPuNzlZYwMDPlfQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 8 Feb
 2026 14:15:24 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 14:15:24 +0000
Message-ID: <82b0e55c-57f0-4b58-b353-e91090e6d1ff@nvidia.com>
Date: Sun, 8 Feb 2026 16:15:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5/hws: fix null dereference in rule skip
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Erez Shitrit <erezsh@nvidia.com>, Alex Vesker <valex@nvidia.com>
References: <20260121081822.224431-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260121081822.224431-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: d225f79b-6d5d-4826-66b6-08de671c804f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWlpMUtBNmhFYlJBMTR0YzkycHpnaVkyZlhqYnBzUHZnL2tnUmZwMVU1SzRZ?=
 =?utf-8?B?TDFib1ZCd09KbmtHdVpSM2VJOWhELzR5cG5iNG5NelcyaUJqUDlQM3o5cG5p?=
 =?utf-8?B?VDAzZ3VCdTQ0NEU5czJURDVGQ3pQckFEbXlXTmVMN1NML3B6QjZyRWcrVm5N?=
 =?utf-8?B?dU10bHpweXVnMUpiSE1sR3I0d1ZTejJlSWhOM1dLaU5BenBjd2RZZlFMeXEy?=
 =?utf-8?B?THVnRWVra3VUQWF4dEhERExDWEdhWTNqZTRnSlJXdXRTK3hRVStYUk55cTU4?=
 =?utf-8?B?ckExV1VMRTBXQmxOaHBmbVBVa2FiZklMWTc1SnBpL0lURDY0Q3pKQmFsaGIv?=
 =?utf-8?B?UlFLWmFIdTlRRFBMd0lWMHVpbHI2QUVNVVJuWE1PdjNZTEhvcTc4VHFseEFG?=
 =?utf-8?B?Y2M1ejRsSkVBWkZ2QmRsZkphTmRVeU5HUzIzVHNpU0NuOVUyaWFBVXZtdXFD?=
 =?utf-8?B?akRkeGZqb2RKdWxKNHFFWWlGUEdQS3d6ZUVCNENJbks2VHJ3RUFrRU5WWmNG?=
 =?utf-8?B?SnVXZXh5WEpxL2RUc21TUmxkMkFoMFVYZENNRlJoNm93cTU5VGp4UGhCQnk3?=
 =?utf-8?B?M2pJUVVxWFRRcTZDMkkvc0wwZytQRU9NRUcycDdnMmc5cUpENkhHMG5ucHcv?=
 =?utf-8?B?T2FhVDdJdmxkQnQ5UXZ2WVFLKzgwMkVFVmM1NXArOElndWJIRzQ2QWtuVXZi?=
 =?utf-8?B?MWRGeWhYWVVleHBUNC9xMlU2Yys4WmpMOEhjaXZodzl5NUFvU0xXdTIxNjVL?=
 =?utf-8?B?YXdhM09NV05Ma3R5RGJ2WEpRWE9HQnJ0Q0tJemJJd3hLSUZ5SlFOQzIwN0Qy?=
 =?utf-8?B?QWdoU1dnNWRCRGRtZk9rRExxUFdyNW9MaVFuRFV3VG9vYy9FNjVjS1QzelNU?=
 =?utf-8?B?M1UvT0FzZU5lK2NvREMyVENjUjNOT21XblRicWE4ZjhFN3Q3eEZzT3hFZlds?=
 =?utf-8?B?NDJqWW9vRVBtckpyZ3lqUytSKzBXa1UzdnBOSWFycXp4elBBekJnQ2loUk5Y?=
 =?utf-8?B?bm96aXNkSVVwSi90VWlXN2hNbm9INXlJdVQ3NEJFVzVDUmRyeDVMdTRrNktZ?=
 =?utf-8?B?dTFUN2h3TnMrVC9nVUs1QzZHRXdXZGZEY015UFptellPc2NuanpQdG5IRXln?=
 =?utf-8?B?bzdSSHJsWTJhK1Vwc21wMVkrOEFJN2lzT3h2SXdCUFdJQTRES20vVE8wTkpi?=
 =?utf-8?B?UmUySUE4d1lqU056YzhqTjlncW02c2F6M0Z0Mnc3S1JyUHJiYWFiUlRQd21t?=
 =?utf-8?B?aVVjV2F1RTJrd0ZvdUpuUnh2K3UxRmV3NUVETDlETzhiTVpZK3lYTHY2dUpD?=
 =?utf-8?B?NXNGVzlyTXJMRHYvclNCNDJmWm5kMElZeGF2SHZKUXF2cHl5YVJSQlIwWk1Z?=
 =?utf-8?B?SVpsS01TWkhwMCtTYmNqanVyemh6eGMxVnNaTVBURDZVUEw5YTduMjhOM1lC?=
 =?utf-8?B?dy9ZSFh3czNmVW1lTDNUNllkRE8wUnRhM1FNbE5FSk5YaVB5ZjlaVmwvWmlH?=
 =?utf-8?B?Vm8yZTBLeTlmODBXMTFwZEM4V3pGYlV4WnUxMUI1d0prRUE5c3VTTmQ5akpS?=
 =?utf-8?B?akRIUmc1c1VrMmcxVkhWOEJPeU92R0FzQzFOamV3cjdtMUQ0REFrVjBkSWpn?=
 =?utf-8?B?d2o2TnpoVWVib2xJc0tmMWNpRVRvRElNYjhEeEN1WFBhU0hKMnBRRmd0VFlo?=
 =?utf-8?B?YjdoaVo3ZjRtdHhPMGdIb2txUHBsdXpqSWZkVlhGa1NaM2hqWVF1OFdjNmg0?=
 =?utf-8?B?V2F1TldVMmxUbHpWSWQxdHQrbWl3OFoxZGZUbEM5RnhGRGZ6NGdaeSsrSVA4?=
 =?utf-8?B?U0ZRYlVOWDVCT3JkdzZsOTY3QkZOZlJ0TVlUamovK0craVhQRWd6Q2wyRE81?=
 =?utf-8?B?TnpobWYrd3JyOEFjRGdrY2JERGVHMGcrQ3BQNVdJamtHLzM4bXBmVVpxa2E2?=
 =?utf-8?B?VUwvY2t5N3Nra3lSekNlYUV6TWdVUi9kT2tYSVBVVnRqRWJreHkzc0QyUkpn?=
 =?utf-8?B?RXBybHNlZENVckFlcXVHc2FVWlE2M2Q2YnZBK2d0OFFpRWxnM2pxTnBqbGRB?=
 =?utf-8?B?bkFBOFBUWmhXeUxRUm1JVElmQk1OdENPVSsxWlBScTY2am5vajBJaDIrQXoy?=
 =?utf-8?Q?YkoY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THllV1MwU2NkTGZjWHJNMDc4bFo3Q0dud0lxbVRNa3kwMjBpbHJ5K1RyOFdU?=
 =?utf-8?B?UVNReEdNSyttVWwwMU12amZUOVNIOU1PdDRQc3hNaUR1SHRoMWFSclgra0tn?=
 =?utf-8?B?dXc0T01LVjUxYUdIUVpUNVNBcVBibEJ6cnlkYnduMUFtRmlobFNSMDVEdUEw?=
 =?utf-8?B?K0RuTHRqVElxbjJOQ3loU0dMTnFXeXNuNG5hNnIzOWV0VEJlMlNDOXhUY25p?=
 =?utf-8?B?WE9NQmNhN25ZWlJ6ZVhjdkN4WVpEblNYTWRyMFF4eTIrRG5yaStMSlpNbDhl?=
 =?utf-8?B?bzhNRXpPT05UZDArTXZxY05wUGNOQ3ZIZGtOblJhTVlWd2xEeWVBdUwrYStK?=
 =?utf-8?B?VGRnWmpuUmd0UW5CdjVRUUcrNHFVYzdYNUJBV2pxZGg5TDFBcVJUMEhiVGNv?=
 =?utf-8?B?Y1VSVWk3ZWNDTnJybDh5QjFXcHRMT1pCRmUxZnF5QUdDcDczMGVYenR0anVK?=
 =?utf-8?B?RStPYm1EYVNLaGN0S1ZKSDN6eDM5TUs1VnQvUnBsWUorYmFXZG40c1FPTkxM?=
 =?utf-8?B?TTI1K3VRVzFKUTlaL3dra3htR1prMzc3Tk5WTVpadUYzZEtkNXR4elpaUnRi?=
 =?utf-8?B?a20wZHV6RWdjd0VQUmc3U1N4cXlLRzZraVg1eWJaVjNEN0cwc2NncU0wTU9N?=
 =?utf-8?B?NG9Lc1BKTVFLUlNJQmZwSmNvY3YyVVMxNy95Tmc1Y2ljSVRQL2dqcEtzaUxx?=
 =?utf-8?B?M0t3RTVGMDhuc09xc3lOZUlqcnVrUm5sRGdyTVRQNTJEL2swMDI0NXdweVdu?=
 =?utf-8?B?eUpISWpuendlT1lhTlZGQXhiTk9rMFRhcGtTdThydURteGFSN2VsaUdJVjFn?=
 =?utf-8?B?ZUh3MmMzcWJ6bzZsL1J6Ymxvd0o2L2NOemxLVkVLNzUvUVB2ZGk0Q3c2bUR2?=
 =?utf-8?B?YmdCNkQxUVV2bEVLc3licXZiTzUzV2MyT1FOUjJ1cWRrcHRDWjZhZU56U1Bw?=
 =?utf-8?B?UXVpR25BVWlYeUdkMk0xalJuWDd6Mm5WWFNJWkJvdTc3MWlEeDNCc3U0d1VD?=
 =?utf-8?B?U2RxVzdnMDZtTDFtRXBsTXRyR0FGUkNWTEIzNVcxbWdLdlc1aGs3MFZJOGl0?=
 =?utf-8?B?QjBoS0tReGp3WjUrNHowOW02OHlrc0NydTNrZmVLUUNoSXAyOHZEaTh0OExq?=
 =?utf-8?B?UEtHWnRBOE14TkZVZnBpU2RqMXE5a3ZENHNWSjE3WUlEWmNUUFpQQWpyZGVW?=
 =?utf-8?B?ZFJxdzM3RHlPUXlDL01JZWNrSnE5a1RvNURuSjBCZHFpSEh6MW9TdWwzeUgz?=
 =?utf-8?B?TlQvWWFyNkpqTnN6VUFId2Q1Y0JibnBxcC9NREZjdjcxWVRlK0JIVjNaMHdm?=
 =?utf-8?B?UWVzTFZmWEo2YzlOY2d2ZElxMjlNSVo4UDFLcGFhcHZsVDhDR1UrRmpKTkZh?=
 =?utf-8?B?U0YvYkY4Uk56WWRFaEVsSmp1ZzljS0JjZ2ZaSnJKNW16emNnU2w4Yi84NEl1?=
 =?utf-8?B?d05Yei9yVStNazR3T1ExbWYreXVWVUVhYnhhRVZOZUlHbUpoL3Y2VjZPdCtC?=
 =?utf-8?B?eE1Ua05sb2lSckNpZ0dpWGozREJjZkRKV2lYQmp3eHFtSkxnbDd0VFlsTUlC?=
 =?utf-8?B?bVNyUGxqcFZua2hkdW12RXFCeHhaek1UaEVidFRnM1c1WXdKZkN2OTdHak9x?=
 =?utf-8?B?OWVUOGRxeGl3SHlQWTMweEtmaE8vSWp6Y05VSnY3MjkxWlIvY0JDYWp4eHo5?=
 =?utf-8?B?YTI5amVJc2JZZElueHQ2YVovRjQvbm41K25SVm1BUEdOc3FDTzdNNGpSVTh4?=
 =?utf-8?B?NmJrOGx0UWY1UGxCWFhaT0FZcmp2QU9MSWNmTElaQVFqaTQrbm1kTVpJaE5o?=
 =?utf-8?B?ckNXVWRDNERDUjF0MHQ5WUUxVzg3UHRHRmU5czg4eHNsK29HeE1SYStKYis5?=
 =?utf-8?B?UzdtcFpOU0l3SUtxLytBbi91dXp0Q2JhRnRXSXhPMDJUOW45NjRpSTdHWFBU?=
 =?utf-8?B?VUpBcU1vUGJ1NjdaMGFaYnI5SmNIbXNhaFNBY1RrdnRIM2w4L3h0MTlvZDF1?=
 =?utf-8?B?ZUowNTRqTUlkRElaNDVIN0gyVHFDREovaUxDVTJGSzhySGl2cm41bWk2N0hB?=
 =?utf-8?B?ZmVueHBFQU1WNVFMRlpUa21nbzRlcDhKMXZkeCttQllQUFQveG0zRXFMOURE?=
 =?utf-8?B?VGJHQWZubTY3NjM4SjljeUpodmFPcVRpRDlXRW4rNTBqNmFEb1ZUTDArOVR1?=
 =?utf-8?B?QnplOTYwMVFmbUFLUDZra0IxeHRXcEJsNEV0UG9XSmxUZkFXQ3BwREFZUFk5?=
 =?utf-8?B?U04vNFBDRTA1Q0JOOXZWWlpyc1l5dmQ2OUpVSXNaVlp6V3F2RDlBYjFIc0Zt?=
 =?utf-8?B?US9YWDl1MDlxSFJ3Wkw1R2NpRWxiZFVLVWdOYWtoRG5HTCs2em44UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d225f79b-6d5d-4826-66b6-08de671c804f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 14:15:24.5744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW3WFY7QdQjncy4dBGmycxd/7miuIuHKAdBQm5FUpHLlm0rP+jeMVNJc0w6caeKLdMDFvIpXdQjh0kxgtyPsfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
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


On 21/01/2026 10:18 AM, Shani Peretz wrote:
> When using template API with a represented_port pattern item that
> has no spec, mlx5dr_rule_skip() dereferences a NULL pointer when
> accessing v->port_id.
> 
> Now validating the spec before accessing port_id.
> 
> Fixes: 405242c52dd5 ("net/mlx5/hws: add rule object")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

