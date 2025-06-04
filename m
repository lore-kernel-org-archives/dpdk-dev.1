Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF6BC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13B842D66;
	Wed,  4 Jun 2025 17:00:55 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by mails.dpdk.org (Postfix) with ESMTP id 4E99542D66
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:00:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGOyJ14PgkECv86Ix8m59Zrll+6MgeLq8i3Q+moVYiuxoSnvCHtgs5VMLnXSmwGnPCnaJNWF5I4wj0S1wNY+1Bxd6k/ov9Q1crdlH+BT95OL4nnqzOVd9Dj+HoL45QoQZ8/ev1RwFPgs8q7MszgFA+RFKGxq0M41ktzavM+xDhjvlJKRRu54dKc8p5ceiH7JGBTH1tvMG739UNUFgDSV6jF8uAed2tZ0N3rJkgZ6Td3B09Ukmsu08OBobyk2NpQFi0CLdid+GYNDuDasZdkOu/veIA41s/DiK5WwX+CCNY3VCkBhjfmwQRell1aguQL8R7BFEnFmgqEphNGd6H+qkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXf2uQ7cmekHJLcdUd/NLLSv1C6js/I60DXRkbLNAps=;
 b=WBOABdDKgkbX4avkJLsU3IVp8criMmphJcjecQltYO3ZCFGO3AAo+/VuLoNO1SfHwmPKAveiTfwowLAaoIKaYUDhxIuPlWHAksAkFCCpd7AbVnQXMS6w726q3lWa1lVuKHTZdIrhZ4AZfpYT9qwKjmPeSFB4CqZ9YOsKPfoAvob36qRDLI/60Wr5BN+O+PdEto/wfyCkZH0wJEaysDklgP46FAWyiKyvXhJs5E53ytHKlZ4kum4R8r3aNGm7c5VaH3dJ7dx7FoD02oFyXVZ4ShUuN6cqBml9aokl9JePgOrs5qzm/OhtCztq3U1nXcgY9ZbDTtQKHIShazImmIhSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXf2uQ7cmekHJLcdUd/NLLSv1C6js/I60DXRkbLNAps=;
 b=mVE4GP3D5wDYl/TC2XFE6ot6kCb2BVX9TGksPLamzDFUCBr1qr3OvQzscELZD+2ZG6ZJ2sgalV+POOFf4Fd2AlLdVDoqrqeysmlzgx3hZnpxoOobxqafZMAfpUpXLKm/Y0fkNtNbDVCHb+UZIWYOR+yUZ6esukPRjDiJuVrTWb1CaV6WmMq1DhB8ZJ1i7ymsrDQGZkJiq1I4AN8RaouSdb2Xfky+eZttMPCG/Z3obzj2i6HRpUgl16+Dj/1/WiKDsju2EwpdJiJvo0hatH6NcEkD0A135+gC+kYfAR0bBUGv6ASMcqWjjMPmLPt1NYFxxrRvyIKjsGFTZfVIktV/qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Wed, 4 Jun
 2025 15:00:49 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 15:00:48 +0000
Message-ID: <adc1b5c8-f405-4bd6-88fc-f0d668450e1e@nvidia.com>
Date: Wed, 4 Jun 2025 18:00:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net/mlx5: unresolved symbol
 mlx5_geneve_tlv_parser_create
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <1746456337-6278-1-git-send-email-andremue@linux.microsoft.com>
 <1746456337-6278-2-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <1746456337-6278-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe9577c-64b5-4096-39d4-08dda378973f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmZGUmdFTy9hNGNFUmpaYkhSZm5Wa3orZE5jUHNGUGtFMG0yWDFQOUdPaDhM?=
 =?utf-8?B?Wks3Rms0NTNyNlZQMWN2UWFjSDhQOEhrOHBabm1yL0FBd0dUWG1HOUZ2MzE2?=
 =?utf-8?B?d2F5Yld2bHdUbUltaFowTGk3UkNoYWxtTnN6Vm91YnpnRnV3WkZKZTZ6VkIz?=
 =?utf-8?B?VnA5RlE5YzBGSWZZV0wrT2ZQK3ZaNEgxdEttWlNZMSswc2w2NVZ5NkllOGQr?=
 =?utf-8?B?NnhIVmZHRDltMmx1UFJId044MEdCdCtNdVJDWlJYSlNjTWljRitsOHk0dmds?=
 =?utf-8?B?NDN5NW9LSEkxSzNpV1FyajRnV1pOTW9mcW52QkQ0clpjS3Jqalg1MFdHdndw?=
 =?utf-8?B?MVJxN0ZOZHVMTkhGaEdtZVUyVVVpMkxxK0ZSTWRLWkNPbU40bDZVeWphVDFP?=
 =?utf-8?B?Y01lUDZDbHpoNHVoVzZEc2hzam5nWVVWLy9ueU1oVzVjQ3JxMGNROWhzU3NV?=
 =?utf-8?B?MFBnOW9BSm5ZclkxL2tpd0g4d0ltdmVVZnVjTXF0QWc4b3dwaHZJR1hIV2Jl?=
 =?utf-8?B?TEZwNGYyMThNc1YyU0ZuaXZROFJPcFltVEV2bG1MdWl0ejRYS2tMM3VsN0JW?=
 =?utf-8?B?blhzMHg5b25vckEySUtYYzJJSE8rbTltdTlJSWUzL0QrdzRjNEU0WXo4YTFr?=
 =?utf-8?B?L0FmYWIyUnpWUkFJM2pHMFNzMnhlUUoyT256K2lRR1lXQTJhaGNCQmQ4WW9n?=
 =?utf-8?B?QlRsdnNEckdHdURWOWl1bFZzUTJDZHluWjRMVXQwQnNxUGhwS3RSZTNKNkJm?=
 =?utf-8?B?djdzaGhhOFBSWHZLWEJtMWs0M05lOFBGRC9HZ0J3OUlvZHJQcjRqZ3hmcnha?=
 =?utf-8?B?SU5qV29Rdi90Y0RwQUs0TG9NdlRoZExDWGNXTXNZMHB5ZjYwRzlHSlZvVUxF?=
 =?utf-8?B?S1Q3T09ZSEJrbFVnN3RUeDBVMVVUWFJrMGNtRENoY1V4UHpxVFMrVC9ad2xP?=
 =?utf-8?B?SlZCYzZzaEdkaEVhYUY3TW1LUXdEcktrbyt0NUFsY1dCVFZUSEVESmJZeURX?=
 =?utf-8?B?ZDVjcVdKdjdLSGU5aFp2RnluREhNS0tnTmUxTG1CM2ZyTlowQ3h3NWllL04z?=
 =?utf-8?B?OWlpbTMzQ1BYaGJ1bDUxeXlBNTlyRzR4R2ZCZDdyZTJsOWJCZGlMN2NUWHNM?=
 =?utf-8?B?NTVoR0czTHhubHpvZ1dJVW9UWEJEUUlMVkNhTnhVSHdad05WbVZaRmVuc2FG?=
 =?utf-8?B?SEN6WGJtaHNkRXJoWlIxaU5hb1RYRWcySmZKREJPK1JCNENQQTlPVEFuNkwr?=
 =?utf-8?B?ZmRNRzErSXZJSlJuMm43UDcyRHc5aFVTYzEyKzRhbjdxTC84VkpuVUNGaVR2?=
 =?utf-8?B?N0ZYaVRxcmZ2THBEWlFvK0dSQ0hGRlBxR25ON1IyY0pOU24wR1k2YVBKK1Ra?=
 =?utf-8?B?ZGRham8reHdFZFlTczJ1N09QRERkS1Z0SjlLSHZqNkZ4NDJvQkt2cXJTMkZU?=
 =?utf-8?B?enpEK3F6MjE2ZnJIOCtLS1gwYWJaU0FSV2pTdnQ5M0crTFBQaytVbXcxTUhY?=
 =?utf-8?B?d2JmVVFjWityU3BzNG9hRXJVTDVqeXpCQ01jRVMvcEZWM2hXc1pUT21jeVpq?=
 =?utf-8?B?MHhLU0FKNkQ3bng2VnJVUnZhQTNJZTZLdEdHUnR3LytMZkhscTF2Q0VxbThJ?=
 =?utf-8?B?aHZkNmZwUXJMaFIrMUQrTEhVRnBqcnc4SjBBRDA5cnZXc3RheHkwcWMyaENY?=
 =?utf-8?B?b3dnMVpUWVFxYUhrZmVaQ20vNG1iM3VoSlViKzhweWV4WHFyUWdydS9rQjlY?=
 =?utf-8?B?VnVvN0hoTTJJU3B3VFJYTW5oMWpKVDhjUWVTc01sWFREcS9WTEJ2WW5aY1pT?=
 =?utf-8?B?UEFJMDF3bFFqdnYyRWxMVWhMdStsRU44eW1reDhJcVh3RndXL2xLZTdhMXZi?=
 =?utf-8?B?RHNVYVN0N0hkaC9HRjBZK2VwZE8xSWlCdkh2cFRaT2duSlFERkpzaWNVMmdW?=
 =?utf-8?Q?GcPHmPBjo3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2RiZ3BrOWtZSXB0eFE2RUNScDFrZmdoYndXNjNZUVpQTVZ3aUFvZURMK0NE?=
 =?utf-8?B?V3VJeW1LNmhrSU4rMkw2cWtaUlhFeHBqRHhTMjNocS91ZkhjM1RYU1JzSXU0?=
 =?utf-8?B?RzY0VzRMRVFLVnJRa1ovbDY3d1JGTXJDOHdoSFEvbXpTZDRFNkwyUnowV0g4?=
 =?utf-8?B?T0YvOUxGSmo2amQ0bzdwZVp5T0xLQmhxUDJWZ0cwTnc2V2VNdjN0ckpjTHlV?=
 =?utf-8?B?RkYvS0ZINXJXdCt1MmRFYTNWYmx4aEtEL2p6SllsdWRucmR1bndoR0hubzRo?=
 =?utf-8?B?R2xoWnEraUFmUW9YNEs2QWZKRG5BT0s1UmZ6YjVWODl4V1hnak5JcnNMUm95?=
 =?utf-8?B?WjdaZDdXS21NNDRNZ0VVV0VwckxndFVNKzN5UDY2SWcrZkhFVC9qRjluWmFM?=
 =?utf-8?B?WjhOT1MxUXR4djlwcU9MclBsVWkwUlBiNlN4enRwUTVEbDZkKzZROUpBRWVZ?=
 =?utf-8?B?UDViMFBpM25HVHVmckp4N0dFNHRqb1JWVUVoY2ZCczgwLzM3NG41RE1XdHBq?=
 =?utf-8?B?bTJWZkRBUC9sbHRHQmxjMjlMb0EyTm9sMEo1cmhuUlZWMHZKc013MUZZL01S?=
 =?utf-8?B?aW93SGl1QnRacTVEMXIrWXlBL2RaNFgzVEQ3eHJiUzBEbURlVEpUdktpaHdK?=
 =?utf-8?B?NkNHc3JGRTFtWi90SStYUE1DZENUVGk3NG1xVFVKa2oyalpHMzFqMXpYWG5m?=
 =?utf-8?B?MGhHb3VZOGtQSTczM3pMaWlRbUxreXNNTExseHc0SUhsV211V0dsUXBQdG1o?=
 =?utf-8?B?cG9ZMUY0MXdVSEpzdDZuTUFiL0ttaG9FWVJTanFkYlQ0Y0tNd1JPb21mMlpD?=
 =?utf-8?B?Z1UwZ1A3MHpaVkpHVHp3YUFpbDQ2MFVnUXJ4VTh5N0ZwVG81cThOQU9kVy9W?=
 =?utf-8?B?K3VIVzRiaGF4RERoWnhvSGJFT1ZvQjByZXZyb21PMnhOOUIzeEtlSFlzL2pY?=
 =?utf-8?B?Ymo4aU5ZenRpWU54MW9TbjgxcVEzMjhETTVid2JqSlg5R2lJWTkyMzBNMmMz?=
 =?utf-8?B?YW5jQWRLR2QvVUI0dmFUS1JYd2l1NVZwNis4Mit4cWdIclBaRHBMQm5zMG5U?=
 =?utf-8?B?eHdibFFWZVBObDR1Nm90ay9oMnEyQTY2bW15b1RzYmt4ZnlUL2NtenM5eTJl?=
 =?utf-8?B?WE1LYU5FQVhoZHBCc3BCYUJ2Q3JlVmNhQnRLQlhUQWh3YTVMVW0rcXQ3Q2hV?=
 =?utf-8?B?WVZKUGYvMzlla0xjemxWSTZiWnR5S3BvcXBvTEF4MEt4cVl1V2FQdnV1QTgz?=
 =?utf-8?B?ek9LUjNReEZnR0FRQzN2YldHeFF0NUh1cVpEVWpKRlNUcWhHWE8zMDJ2cDF2?=
 =?utf-8?B?TWJWbGhBSjFsdTM2ZE9TMVQ1R2ZvV3g2bW9pcFN5Qk5pNC9iZld2c3hoSTV2?=
 =?utf-8?B?ck94OU1ZbGFNRExKMjUxKzB2Q3pnQ0tiOUdiSzhQNUtWdnY0OW9MK2tyWDlx?=
 =?utf-8?B?ZmxnR1BZWWNqUGEyelpoZUZFZ2dBdGNHdEk5NlREblBpbERvdU4xTkdQcW0w?=
 =?utf-8?B?UmRTYVRXdkpsS2hvUGZKaFp4Q1ZpZHI1ZDVaZGJ3NXRQTC9qN2lYS21oblZH?=
 =?utf-8?B?WUtyb3dYNjVWNldVR1o2eTA0MkZaQjZZU1d5WVN6TkJxRGltK0F0UkNWWGUx?=
 =?utf-8?B?eUtpcXdTZi9nYmsyV3V1V1loVUUxcEdZR1Z0V2pMa1hYa29sM0ZSMlM1a3ho?=
 =?utf-8?B?QmdmVWQyRzh6QktBNXllaktqaEorNWNDcTh4dUtpZWtsTzhoNno0NHFCZHJ6?=
 =?utf-8?B?enFxUGRyQnJLWG50by81RTRvMUdsRml5eXZoT2I5WVc3Vnc4K1k4RmpUNEN0?=
 =?utf-8?B?WUdQem13c1pvSkFZeWpCSmNFNE5Fdi9DWkJKV2ZSVGJrSjJ0aEhiMEt3V2Qr?=
 =?utf-8?B?MkNnSjgvM1UweWdLdVRnd29BYVJ0Wk9KQ2VaVFk4dlJJaG4yQys2NmFScVYv?=
 =?utf-8?B?NWdMUStmenZmMjVGZWtzNHY5VjM1RFE3eHNRdFUwcTZpYnM4NzlnT0M4SURF?=
 =?utf-8?B?L0J6cHpQQVBmSHI5ckhqUFhoT1pnVDNEZU0wU1F3S0NKVUMvaHhXVXRqV3Nx?=
 =?utf-8?B?ZG55cWNCOXd0SzlweS9JSFRteHdoODBJUXVabG1XdmFiR2JVVWp3NUp4bmw1?=
 =?utf-8?Q?HosnUJjfhPs0FKbwlUDhnVxVy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe9577c-64b5-4096-39d4-08dda378973f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:00:48.8207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyQKwnwhPeqBBj2yZ7AyhGr0PS6pu57fL+YIVx2NPCwvMMC1zB+mqoZ3Yn6M/3DVJVauxLzvedC70m1aZ4pQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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


On 05/05/2025 5:45 PM, Andre Muezerie wrote:
> When compiling DPDK with mlx5 using clang on Windows with
> "debug" buildtype the error below is hit:
> 
> net_mlx5_mlx5_flow_dv.c.obj : error LNK2019: unresolved external symbol
>      mlx5_geneve_tlv_parser_create referenced in function
>      flow_dv_discover_priorities
> drivers\rte_net_mlx5-25.dll : fatal error LNK1120: 1 unresolved externals
> 
> With a "release" buildtype the error is not seen, which explains why this
> issue was not reported earlier.
> 
> The same problem will show up with MSVC, but patches which are still under
> review are needed for this to be hit with MSVC.
> 
> The cause of this problem seems to be that mlx5_flow_geneve.c is only
> compiled on Linux. This patch fixes the issue by compiling the file on all
> operating systems. It also sorts the file names in meson.build in
> alphabetical order.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com> 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

