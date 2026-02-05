Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE78E9128C
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 07:56:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B9D34026D;
	Thu,  5 Feb 2026 08:56:27 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by mails.dpdk.org (Postfix) with ESMTP id 41BC140264;
 Thu,  5 Feb 2026 08:56:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHCF3iOJMWSG5Zz8Nj4sk8WKMe6EbMBY0UHi8fjeAfRNX1BC8Ic2dusDXNTUrupofY9g/r0qwZPmcN016OmLilOWPe48ysqQf2qUCmUzvhxxr3fQzBA401O0TJrKRyvFumT2vVPDp+OURNm7tTAnVEUVji/atL/0QDOQFmDcrBZReHFugPWqggYSo1OLCkYfdwU5wTR2wZ+zbO6DcuVpfDaT1Acz7KkZ+qLLc16O9wkp63UVLq8vRALMFj1OlnSBr7l3SrEQZdNlKScWHXBdPJ9wpfLA0raztesCi4tWMSfVm//rw/uV50Ubrihd4NleYO22gvjaA6uuL97ugDlfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpE+R8EtVrzAxDEzV0Pi9NwXQTROD1qg9snnkh46eKU=;
 b=duuHUCuIirllPUDNxzPCF78sx9VxVhRNgJNxwsscoVrjlC3xIV4Eft4krydXhe/m/PC2sriaRPy6KeMmlBXrbW077MNKr7Mhe5KlGfZ699BGCTxMnmhKpa0jW4DLSu10m+HZPR9O4VYkeIbKXz5hJAhDyKsd1yD447395FjnKwkkvTY3OYqiYcKSeLIxbpneZF1E1q04MZiexeBux3FJ59i8znwAr2ZAbuM3bYv4auZrocO6IrgGXC832Sle8yg12AN9p87RwNbDRr5thTcvnV+zBdGqRhxfVPoVELrF+efZNYzuGhOK+hYbMqlRSDRhT3Nf1RMh/HZaykN3/DDg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpE+R8EtVrzAxDEzV0Pi9NwXQTROD1qg9snnkh46eKU=;
 b=pGlDjwyqLAKgqRExVRv1PFSg9dVpFWfhCkjcteOXXVdyYt1QsMrRjLkIvpDvQBFWN1cJ9Jtv9rgrnFgicZpxZ80mVqf2nOAPIndznJXge9iR7Fb50i6jYOcWUYVOK5GqyEal0/Yrlr8WenF+WP/VeQRPqEJdeameT6pLrujg/p+582hdeJgXgS//IWRQnxKVB+F/JnIwmIaZ/sbtxXzIZyrE79I/YWyNAaZ9vhl2aMcOaXnCCLSxc6bOGn/kqaKmh+5Ow0+PmD/50VvSPSGl2NagLCdZsxCRj7/4AlavGDnZvdLpoxUGNVBMZgPaQ+VSVBwluqIds0ZZxZy7kzdFbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Thu, 5 Feb 2026 07:56:22 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 07:56:22 +0000
Message-ID: <c36a5ab1-79da-4aee-afd8-2ca4d409393b@nvidia.com>
Date: Thu, 5 Feb 2026 09:56:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/mlx5: fix job leak on indirect meter creation
 failure
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: getelson@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
References: <20251208101203.315647-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251208101203.315647-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: ec69a56c-f8d0-4527-def7-08de648c0d7c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTl6c1BrcTRrQUxHN3ZHV0Jqb1M5OEtHT0pZSzhFQ3NERmNiYjRvcXN3SUxt?=
 =?utf-8?B?SG5Gb01yZ1RRcndqWFhmRnRBeklNV0pzU0p0RHRybzh5S2pRR1ArL1djOGo1?=
 =?utf-8?B?b1J4RERGVk9ocVBxMlJnMksrckZUUHRkQW1zQU9GWTc2dnBkKzh3VUlmemVp?=
 =?utf-8?B?Tk1EclBwWDE3TzZzeGVqZzBuaG1FOFJkUEdGaU5BZTVGV0g5NkRzMGtSVnNU?=
 =?utf-8?B?alQyalJTdGdzeU5zQ0ZGWnpLSTA4VmgrMzVkWjJUeFdTN3NoVEdweDUyaDZJ?=
 =?utf-8?B?VVdsak9NUHNEQ245OUdXSDVJKzFTUmZsM1V0NFhUNWg2Zm9qNEZXb2MyMnRu?=
 =?utf-8?B?VjZsV2llMk9BY0FHbWpqZm9qR2lBZkxVY1hNSC90TmRsQ1JENXp6MzhUcUF2?=
 =?utf-8?B?a2ZUZklpQzdyRjB6QnlYVWJMcjlQYlk0RXdCYzFuK0JxZzBGRlZFT0VkU2ZX?=
 =?utf-8?B?cTBaWkhFTVZMdy9RTVEwZ05oOUdNNDVnRkprRUlIQnFia3puMTdnZHFXcGNq?=
 =?utf-8?B?QlA1TlNjY0FVL3A4REk5cDltUzNMdDZqQ2d5aVo5RXRBMzdSWTMwcEZYNXYy?=
 =?utf-8?B?WklNZUwyaGt3K28wOTlmZ05iQ2E0SEoyallUUE5TL0l0eXdkM3lqRHRFYjVK?=
 =?utf-8?B?SXptbGFrejJTd0J0a1VLNDJMZkx6QkVJQVRSRmJlY253d3JZZzN1U2xLMEkx?=
 =?utf-8?B?eWZYRWQyNWtaSHZKYUdwanYyYllRaW40YUNRYkgxSWx3LzNzcGkzVGJQSGFX?=
 =?utf-8?B?Zlg1dFdUMTZmdVFibjE4eUxDZXJkVGVzVTVrUXdvN1Y2NzFubE1JaVk3Vk9N?=
 =?utf-8?B?UlRwa09sSDlGbEttdm8vNXZVaS9BSmRvZDQ5SGVRZzk3aFhTRjQxUkxETUx6?=
 =?utf-8?B?aGh2c0hvMFB3azlnbnpKSmN0RTRIQzFkS3YvVlVFMCtramEyNTdEa1RpZ2VL?=
 =?utf-8?B?ays0ZHp4U0N0Q01ERGZFakVpVzh6Tk4wM0dZamUvYWVpNjhLa1NGdGdNTVdl?=
 =?utf-8?B?dEZIcHVzNmNEM3BOeHQyUnRHaFFDekFKbWFxc2xLZnNCYnJPeER3cHRZVzg3?=
 =?utf-8?B?TE11aWdnNVc0b2l5UFNTdkNSTDRJRjhXV0ZUelJseExPSUNYVllUbVRlb1pZ?=
 =?utf-8?B?N2tadGcyeThwamVoazJOc0dHZGM4UmtVYUNadDlsbzVING5ZYlllZ3pDOXFr?=
 =?utf-8?B?ckxMZmhaNVJhOVhYek1sRENhWU9mbFFaWDRrTnB6clhvb3VHbldES1VvVm9N?=
 =?utf-8?B?S0xDVkVuNHVQMi9xLytwTjRibHJXNXZLZVR0STJ3d0lUblVZZWl2QkdtUmJU?=
 =?utf-8?B?dzNFQTBtWVBickR6eThNMWRmR3RpczF4MWpweWFwSU5wb3pPZ1Rrbkw5RmlL?=
 =?utf-8?B?OFh1bGZNaTAzaGd5amJQR2g1ejJuUkZJekVLRGNtMUwxSE1UWGhVeHJUYW5I?=
 =?utf-8?B?NzRFSHEvZnRxZFk5QnpmNUFlWjlSeW4yQTl3c0hYZDNkdDhUTHVpeDk0aEZt?=
 =?utf-8?B?aGMyTVhkbWlJSkVoZnI0M0RmVmJqR095RUN6aHZCdTlWSGpCWFVJMDlwbDB4?=
 =?utf-8?B?aVluTFNyeGxuK0lNS05FSVhITFQ5SFExelU1MWR1VktTeHE0ek03M0poUElZ?=
 =?utf-8?B?RFFaYnc2MWRiNnUxNnRiMVJ4UHZBanZhckxHKy9qOW1vWDM3N3hYaEtGMlBZ?=
 =?utf-8?B?b0c1YmZLeGp3WDk1eHprRjZ5RVN0bFJCaGhhMU54MDNEeTkyOHBMMjhjb3c5?=
 =?utf-8?B?UVdSNFFwanZVMExBRTVTdE9ldEZUSDdiU3hEWFNWRUN1TWVpbkhQYVRzZUx1?=
 =?utf-8?B?YWszMzc3VEhENHJ3bVFJRGdVOVpPN2VSSlp3NHEvZnRTNWJMVTZSRlhaMDVH?=
 =?utf-8?B?TXAwaW1WUk5XSlFnUTErZW9lNm5TUWx2R2FMQ0o0T3UyYThLWXkvYkZyU0tD?=
 =?utf-8?B?VDVvSFplVHJhOGZyRlpUQmRkRGc2UXNKdVdMcnpSS3BOaDMvbWlBcVVndFQ0?=
 =?utf-8?B?cFo3L2VkVGhodnB6UWNqVHoybUJjT2FQUXF6UHFZS2w2ZDhLOUd0bVNhMFBE?=
 =?utf-8?B?ZXRjZVR1bGlnOWd2UVBGd09iSVhPODFsNS9LREZSKzlZZGVVblFNQkpnMW0w?=
 =?utf-8?Q?YQlo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUNwYWFzNEgwSzVjYmJEWjNFd3A0VjVJalJDMWM5NkJVQUVBSUIrbDA5d3Zj?=
 =?utf-8?B?UjJ5bGhTWkVpa1VSSnUwSWJGb1dZTmNSNCtabVB1bDZjNEhmWlU0MUlEZ1lv?=
 =?utf-8?B?WFRXUnJpNTN2OUMrTFR5WExMRjZRd0V0Uzc2TEtOdW9hZ3pBVkRrU3Naakts?=
 =?utf-8?B?bUxjU2F6V3VraCtNa2VZZnlIdHg0bWlEdFNVMG5kTWdiWGxtaitCTEc0Z09U?=
 =?utf-8?B?QU93djI1T1oraFhGQkFyZDZMZ0QrU080U2NXUmxYVkVmMTZrbndybTBhNUgw?=
 =?utf-8?B?ZGVYUXp5c1VnbkJFbENOQW5RVWg0QVlFN3BaMXIxL0J4RWZjRjBMcEtic25o?=
 =?utf-8?B?cTdmdnMrZUYrdjJVVDRtRnhYdk41OVc3TzNPUHRvRGwyU1RUVy8reFJ5V0Va?=
 =?utf-8?B?UnZsU0VPd1Z5U1JYcG1ac2ZTcDg1b0xmblB0MDhVejFsaWxJL0lxMnZZVlpI?=
 =?utf-8?B?dHFpUHlSbm5oRkpQdW1Iang2MzRyM1IwaXV4eDUwMm9WK1pUNGZEa3pFWDk4?=
 =?utf-8?B?MnMyQjRYNUlOS0hCYTd5ZFMyVytRNFBpckdhRzFsMzJhM0ZxaDFLdkNFQy9y?=
 =?utf-8?B?MTZoNkFmQVBBTXhoWG10dkZmaWlMZ2RkdTNXTVY3aTl0MjNhbG9LaERRR1Zn?=
 =?utf-8?B?NEc1TEdVQXRrcnkrNDlDL3ZOTGNuZlBXUjhSdnhONzI3bU92Y1VUcnNrUWhZ?=
 =?utf-8?B?KzlORE01b3ZTMFpNaWtOU3N2c2p4cEp4WW1acHBQN3ZmV2ZLQkNaN0IrVUlT?=
 =?utf-8?B?TldsOGd4bFkrQjFQY2U0UHBES0U4WHNwUEhvV29FeGw2bTM4alE2OUtOV3Bv?=
 =?utf-8?B?dkNUMFJ1YkZ0Z3piZHRCa1BEayt0Q0dEL1kxbTJ3QlVDTE5lSnc4cy9EYXdI?=
 =?utf-8?B?L1R5STUzT2kxRmZ3b2R6VFhidnNmMUNjbzdpekxtZUFoSjZidDZtb2tLQ0Ix?=
 =?utf-8?B?Uk05S0hVbDk1R3RwaUQrQWg5MW0wUXpKYTIxb3JMdDFuWERvZ3g4MXZkdW8r?=
 =?utf-8?B?OGM4Q1hJbEJRbnZkTHpYTyswUEY1TVZZUmpPK3czMjF1RzZKbi9KTDdWeWFI?=
 =?utf-8?B?azlmZjJtS0IzdVpwVVZFcmEzUVRCVXVoaHYyUHBGekRoL1pFQWMzaDdWVjNi?=
 =?utf-8?B?K3o5WlpZaUxtMmFYQzFrb09pNDIrY0JoYy9BbUJCTFJZN2lOVkFvNkE5eG1T?=
 =?utf-8?B?YXJhYXA5YUtVQXN5b1lrM2RVZytGQWdwNGIvNU9xQ2xzMFduWVJac1RIdFRx?=
 =?utf-8?B?WktJS21nVEdBNU8rSSs0MUxNTjJDS2I0WFNvTVdvTGRkcjlYMXBpVE5jSDdE?=
 =?utf-8?B?dVAydUk0ZWhGMUJpMnkwaWJkYk82bHMrRW0yZ3BmaWZJU0IyM2pPTWQ0ZVVv?=
 =?utf-8?B?dUYwUjhiZWI2OHhlREVVOWVvcEdDalduYWRhNHJjOWdmUGNaT0Fqc3hJdFlz?=
 =?utf-8?B?MkU0SnExeU1mQU0rSWozaE1zRXVCQ1dlMEZGYmxXbEdEK2tDT2hwZ1ZaTThV?=
 =?utf-8?B?Q2hhamJSalhkUEg0dzFoNElHNE96NGZTVzhGQkNqUXo0OUtHODRmd1hXZTNH?=
 =?utf-8?B?Z2ZNNzZna2pFV2lTVUN5dVBWQk8wcXh6N1dCQk0zR2dFMEVTdzZJVGgxajIy?=
 =?utf-8?B?UlowY2Z5am1uNGFEZ1NYSVpFTlhkQUJ6RjRjWVc2ZjA2UWxXSWVMVDNoalpH?=
 =?utf-8?B?eC9LcWpSVWFmalhXall1SGx2dUplSzVUamxCVXI3MWhSdzFhelhMSFh3SDJX?=
 =?utf-8?B?Q2tIcllMMXdjN0E3R3htclBiRWtPN3JNUnJZODFlWUxwaGVJajdadFpjeXgw?=
 =?utf-8?B?TUtWU3Z1VkZYMEhtZ21SKzZQMzdYZkI3RVJuM05BUTREUkxRcXZzclBXNm01?=
 =?utf-8?B?QytlL3FpQVhTYWxGa1RUK0tTTGN2ZXJyN0phazdaRktEaHVWUlUvQmdGNlF3?=
 =?utf-8?B?emRRc2pWaEtaMWRCd3VXRFVnSEd1ZlFFQVc3YWVEZkFnQzhYU3hacWdmSUxF?=
 =?utf-8?B?emhVeDByTUxaK25GVmxvRlZxRzVMVU92YkZoUlpyeHRnRnlWRnU5TEtMWDNi?=
 =?utf-8?B?dWQzaExCZkx4cENOSktjR2NYUGlucTd5VVZjTFBMT3VXMEFTelFuYk5Zbk5Y?=
 =?utf-8?B?cFFDdlgrRGVYUWFLaGdscVkxT3ZnK2l5bE02bDRBdlgwaEVod0pLVU1jQ2t1?=
 =?utf-8?B?TW5PYXJSM1VHSVE0OFhKT0JSRmFPSmZIay8zNnVDcm81K1AwQ0RDRmI1dExt?=
 =?utf-8?B?cFNvdEZ6QWFIbWx3bHg0Wkd0eVhvZWFxcndEOFRvOUp1bTJOemJraGJCbTcw?=
 =?utf-8?Q?D/+COtNn4XkYsey/Hj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec69a56c-f8d0-4527-def7-08de648c0d7c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:56:22.0336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycM9TetQJBhlIP7RwpOseTP8HpkCy+vGAx6tx8xsOP4x6Gk0l0nXlBztnObnWto4MiEmqX5s7prb7zy2/nPdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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


On 08/12/2025 12:12 PM, Rongwei Liu wrote:
> Indirect meter_mark action needs to allocate a job to track
> asynchronous HW operation to create the meter object.
> 
> When meter_mark creation failed, the job may have been leaked
> because there was no job cleanup code for sync API.
> 
> Add necessary code to check if meter_mark creation failed before or
> after HW operation is enqueued and call job_put accordingly.
> 
> Fixes: 4359d9d1f76b ("net/mlx5: fix sync meter processing in HWS")
> Cc: getelson@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

