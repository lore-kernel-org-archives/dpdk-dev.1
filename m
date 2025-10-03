Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CFCCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D4F4028B;
	Fri,  3 Oct 2025 13:52:42 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52]) by mails.dpdk.org (Postfix) with ESMTP id 4694940262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 13:52:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4/lXL+aiyVvVkaUN9YZ/aTnoy6Se+ChBWcEvSCOhitnaoY1TIULafAMVyrugTw8GAjVVKOuhEp0n9xhus9An9GjA21ybQV2Q2/4IwY1Z6IBe458siEeEhHGiQDluywthwm8p7r1e3J6GLXZJC4mpooOl1NuxF8UrhslkpebRRAU4VqRn8FRatADGi2AZEESmjPvK1Tbq/qC0CWh7Qwq+AYdV5OloTF6XrbaGORiBK9qkC/KbqbhcMhLZxyp9eTvjbldU4AwukZKsSJ+JrJKoXx81bhpitsSwnJgCPzDlVxheAiu+4AkzzmNCVlGmXR7sTl2GlnSJcvt3lxH9WUvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHnBljtFhan0BEuVjqwgJm/zOuN+OI+sAH2sqkpOKK4=;
 b=XwhmKJhLuycJh9aZ1rE9uZ/AK0Iyb48eJp3CbE8bWfuO8rS3U9JuGy7tWfvKlumu2KRhm7T+0m4HIbZmFTKdMi4yVXTvoISZWB27emf0beHwMX4ZFoV6RUf9QPu+jYWMO9IzBw86fTbzWH3Uc+6wXFpCp8f+HBDR68llfkdlT4IjE26KNFsmtB9mmcW0m7fnHxd5J2EkhaySU//pwixp5iBG1tFN8GwJbYRW0pkm2ocrTSrXWEziJ2LrVK/gfDuev4CQfyb+rQR2cr9zJX9n8mLM3xRU7tJv1mrUBWgxxoGwrp/n+37vSr/FNGEPWjay7RcNH3Cm3ajN0kvKiTXaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHnBljtFhan0BEuVjqwgJm/zOuN+OI+sAH2sqkpOKK4=;
 b=P0EK+Iz098m9jIMyBpW6fn/sYKKdf6Z/mHcKjxZTUuAmG7eTsrjsYbeAPIEIbwt0xRVDWVmF1lQq7GDwfAxyp2pA3oBoUU2tkRqMrKUeozklGnNTllCVDL+7wfQ+S2LhKPvUEVjSml5KroZGAntqK4hdHBZ6QSNI7+IxQshfePJuQ0x/5IjxjUG3FPdwIhcSqLix+ZyviqSlkyXhpZyzBdtOAbx+smgctnrxccPBMbP5WL6s3zxV4Gs0JGLq+k8Yi/l+D3HYRv1hsQ/Sa59pg/Ps4+8KL+ANzG85wgAgFapBKszS6Idv3pg13txMtcHnFSzFlCfvE+kQmcqB9HCeag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 11:52:36 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0%4]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 11:52:36 +0000
Message-ID: <e35c5f3e-d9bf-413c-a1c0-0a8d4474ad21@nvidia.com>
Date: Fri, 3 Oct 2025 14:52:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] build: validate libraries returned from meson find
 function
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 thomas@monjalon.net, rasland@nvidia.com
References: <20250923165830.527416-1-bruce.richardson@intel.com>
 <20250924111318.567771-1-bruce.richardson@intel.com>
 <CAJFAV8zv3GzBQk7u8qHjuq=Y6yu2WNuGCZMc0B=w_-PUsG1NOQ@mail.gmail.com>
 <CAJFAV8z9e9B7BfwXRr_H76sm_5kTGyjnv8MaT5NriBTykbyQgg@mail.gmail.com>
 <54ffb23d-0720-4dcc-a6ee-9bb1f9007670@nvidia.com>
 <aN6oN155Gqcdnz8y@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <aN6oN155Gqcdnz8y@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 10045616-cbd0-4094-3d86-08de02735889
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y05JcVVqT1dadWJQYWplUTFaTzR4OXMwWDVBc012T3U1Zm1UU2NuSkN5c2cr?=
 =?utf-8?B?T2E1dVovYzNzNWNwL0hyVVlUWG9OcC9NdnhQbzFSTnpia3dRQ2xzYWw2WEw0?=
 =?utf-8?B?RnlsSkxaanlJZThlME5tVGdvVktnbit1R0pXbWxSWG92R05GUFEzc2dqbUZw?=
 =?utf-8?B?NnpvYXY2YTJEOW43VENZSXRabzFnNlVKWWpka2E3NHlnQ25ZajRGb1hCaFli?=
 =?utf-8?B?MkE0Ry9YaVlyR2lNbURJUHdGallDcXI4NjhWSkdqU01MTWN4cDdRYURCaGZB?=
 =?utf-8?B?Zm9MeUJJM1QwRUgxaHZnVUZuK0JoRHJZQTRCQXYrQTgvbVAvcTFQR2d0c25q?=
 =?utf-8?B?VkpzQ3YxMDYzSUFWdk1WZUNlNGR6bkNlMkdmQUdYQkNiQmV0MUE0K1crejE1?=
 =?utf-8?B?NzU4NXFmQi8wb3VINzhpeXkvMXQ5VmlTdCtSL09FODBDRzh1MmhOeHQyVmlw?=
 =?utf-8?B?dndpWVU5M3lkUzhuZjN5b2x0STlhTkMwcTlFMVVLcHptbkRxcUN6bEl1Wkh2?=
 =?utf-8?B?UFZYZmxzUWdwSnFNc1FjbkRjeTF5SzBSaUF0bXJaTVJiMUdVTUJqdmNqOUF1?=
 =?utf-8?B?WnJZUDBhckJyRk1oWmEybllvajBaVXFqT1hUckx3ZGJNUXlUL0JOVklxSVVW?=
 =?utf-8?B?akRtR3A1NHY5VW5JUFA0U2hvNDBRRmpEUjM5ckxwdW0yaWIwRDVPci9JK3Zw?=
 =?utf-8?B?U2NzbTR4RFUrcUxqamdjVG8xMHJCOExKTzJWYTZBTGYvTGU5c1VuOHBCS3lN?=
 =?utf-8?B?Uy9pUmhGbk1GTitKR3dST2xWTk9TTVY5ZHE2R3NCWU5FdStITG13YktzZUMw?=
 =?utf-8?B?cFNERVBzQS9Scmw0aUl6NGIxdEFPbkJqSWxCM2xxVGZUWWJlemt3YlNaTXdy?=
 =?utf-8?B?NWZySmNjcUlYRjRvaHBheWI2bjlYWDdQdUdrcENraVlNL09OUDRJV204MzBa?=
 =?utf-8?B?MStBai81Ny84MnVBOXhHaDhpbXA1R0p5OEpQNk01ZEI5eHRwNjhnYmJCaXlQ?=
 =?utf-8?B?dmNuL0p6RWdoeEhIWnUxcTdjYzFhSTNYYTJqYWFDa2JqRk8xQlhHOGtLa2pj?=
 =?utf-8?B?ek1yZWZweTV6NU9RS0hNT3E0eWNiMVR4ZFZYVkFnUWJxSzExV3pQUEoyeExK?=
 =?utf-8?B?ZU9hNVRnYjhiRTVZaUhUMTNNOERzKzMxR01ORkg2bXdsYWxETGFBSzhyN3Yy?=
 =?utf-8?B?RHZmY3BpVlMvd0prUWRLMUdzTHNJQ3ZkeFlIS21XYk04RVRuZVpXMzU3QjFi?=
 =?utf-8?B?OWRBbjNYQ1lRKzZJY1hKU0JYMnM0ZUVjekxhOS9obVV0WFhDbGhzVEtWYWQ4?=
 =?utf-8?B?Q01iU2Nub1VpNlRjeDVYZWF1MFZiL0xSa2N1OHh4blQwMHV2RGhpTkI5MGpz?=
 =?utf-8?B?L3oxRDZwK1F4ZFhDRzdxYWs3TTYxV0VjcFEwd1RqclJhaGJQQlozdy9PNjR2?=
 =?utf-8?B?UHNSTEcwUUZHNStRQkd1b1VPR3I4OGt5Wlc1TjhGdk5QMzc4MTVqY1EwNjRH?=
 =?utf-8?B?VFRKZjFBWmlIcTVCVmFNK29QMEFQd3o4T1gzeUdMRWhwTnNuaHpaeGdEb2lV?=
 =?utf-8?B?dTNUdzNmTWhEOHJuMU83d3VENnU4NmtpYStQZEg0bUVoUG1NQkpEZzlDWnVk?=
 =?utf-8?B?Rjlya2M1aFkrTEJ0R014WlhVbDhLZDgvTlMyMkc0TER5c0JiYlQ2SnMvajlP?=
 =?utf-8?B?ZjR3bGEzaDl3Q2tQR25VbitLeDFJZjJsUlMzU3RWaWxVRkJGdFA0dzRrZnRl?=
 =?utf-8?B?YUlVcWVHdWc5SllZR0RwbXpSY05iSTlVeHpBeDhvbS91RW5SOG02TnI1RThF?=
 =?utf-8?B?MkZMUE9kR29PWGkyU1pRQWlrZi9zY0FiV01aWlBxbkMvYi94SzVjMmhEV2ZW?=
 =?utf-8?B?bSsrcW1WWnEvVXBiVHoyTUkxb1dPNkplVUk5ejNpazB4emN3bDZGb1NpZ3NE?=
 =?utf-8?Q?cxLEsdLio7mXECuMmUEGdieG7Q5XSR2p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBWakIvWW01RkNiRm9XV3BoajNBUGJMUmcwalF4aU1Mc2k1WG1LZW54NmxD?=
 =?utf-8?B?MmZXbmU4MDlLLzZhWStlNk9wY0NmVDJZRUpSZjVqTnZuZ1ZzdXZPWTV3dm55?=
 =?utf-8?B?aEpZY3d6ejhGUFpBakRNaDFrc3BGOFplSXV0N3JWNFk1MlQwdnR4MnFyS092?=
 =?utf-8?B?cmZPM2tBVnpUK3lubTZzS1dHa3llMEFKR2tuVHBnZ0QyZjNIaU43SjlTN1Ar?=
 =?utf-8?B?K01qUXo3WFg4N0hUZ21yMkFURzdHZHppc1NzZGZHK2k5UjMvWHB3WjZoMHFw?=
 =?utf-8?B?Y1VIZSt4L1pidzBzWms2QjNtWFE1a0hNN1hvYlVBTG5VNTVuN0lnd1Jxblk1?=
 =?utf-8?B?SThuVi9PZUtNVjRYbTVueTdJenZ3aXlXdHBNZkExQnVraHVlc0FyMzUvYzBB?=
 =?utf-8?B?eXprYnAvdURBWXpIeUVEMEc0QUhEd2dOVXVzOFo5UFlSWTU2WjNYZDBMaUwv?=
 =?utf-8?B?TWRjWGJ3QXpjWGtIbXFUa2o5c3FBbXE2dU1YekNVOGZrYXE2VG42dmhSUklk?=
 =?utf-8?B?Z0NXQ0U5VE9Wb2gvQ3hrOGIrTUpCdjNBc2xvK1dPaWNCbWRWcWFZdXlyQmZ1?=
 =?utf-8?B?bWljNUthZ1VGM0hqUU9XTWUzNEI5V1dhUXNsYURHS3FHcTdSOVhjckNpRElh?=
 =?utf-8?B?UEhDbHRMZWo1NDdEbUR2ci93N0pyYVRZa0xqWHVrWG5kYk1WeHIvYmZtaTQw?=
 =?utf-8?B?clVnSE9nL3hDYmhnQW1ZbUVXZ3ZNV3RNaUxGaXBxSk1xNGNTWUNsY1Q2UDdH?=
 =?utf-8?B?dWFFOUhBald4Q2J0NFVHQ096a2pXRDErbEJNaFZGd1ZMSjBYY1pkTktkNDE5?=
 =?utf-8?B?Z1B6ZTdiK0dDQnRrUGM0RENadXFrMUx5QzI2ajRpREsrYUJ0TWhGRmpvdGh2?=
 =?utf-8?B?SjVzM1c1N093Ky9KVHBNYXRweGgvMm5xNVZod3NFZGhndkJycVI4TExrbytC?=
 =?utf-8?B?aG0vMUZGRzkwakRYS0xMVjBjT3ZxbDNIUlVxRkVPVm0rVmk0OWhJZy9HNzJi?=
 =?utf-8?B?b1hvMnRNVzJPRkRtV3F1b0I0cmE1b3ZES3pUclJ5NEpneFpyQ2hPTzFCNDRV?=
 =?utf-8?B?N2RHR0RIMmhpR09uNVA0VkZsSkNQc1A1NUowQmtUSTdZcU9tZGphSlFZZmNK?=
 =?utf-8?B?bEMvY2hQaUZNSUcxaGJhdk1ubk5xMDhZNTVHWGllcFV0SGNuNG1KaGUzLzJ2?=
 =?utf-8?B?VGZyQVlOd3lVcUppWGhieUdWSTF3a2s5OXNmTWhOQ0tQVVhIb0UzY0hQc1F6?=
 =?utf-8?B?ai81L1VoWEt0cGpIdTNYcjFyVk5FcXphTjZzTmMxaDdNVGtMZW9UN2g5N2tK?=
 =?utf-8?B?cUpXbUlwNXdiOWNxVFhBcnQ1akYydHgxRlZKV3lBM1FNWFV0MEp2RXJFc0VP?=
 =?utf-8?B?THU5aDNZQjA0b0Fsc0tPVlpKanZpeG9Gb1VmT3ZFa2JDdDRrWTV0VjJsKytw?=
 =?utf-8?B?TVJSRE50OUxUZVBQZjhraE4wWE11NWwwWDFZaDZTTnVLeGlubndVN1Nxc3JC?=
 =?utf-8?B?cytJQW1Ycmp3a1lhRUF2WWNRMFhkUWQxSDVrMFV1VTc1Y2grd1JQOEZaZWNo?=
 =?utf-8?B?dHNDZERCNmVFaktkM2t4RFVTalBDdHh0SFJjK3VzbXBnVFRiN1hXT2IvZlVl?=
 =?utf-8?B?T2xTelBveG05OUZGVENBWVF6Wmpodms0RW5FVUlldU1WMUFFTEZObE9OMVJr?=
 =?utf-8?B?UHVBUTBxRXd2UlNpU1U4T1RlTStQQ1dybnJxb0Z0ek5PWGd2dDBSWUowOU03?=
 =?utf-8?B?YzFOYm9QT3F2Q2FxZW1PWWRUNW41dDJXNTVIZ3ZSUVlGalg0ajkyQ28rcWp4?=
 =?utf-8?B?ZXlqNU9LVFE3b2RjeC8zazczWXNWR3pFdm9vN3hmVlJWaXVXZXZacjdQSW9X?=
 =?utf-8?B?WTFHOFJoZnNjc092aW5xWCtKSFg3Mml4akwwMzRpV0VTb0dVSFIySXlsTWQ0?=
 =?utf-8?B?cUlxL2kxRDBKajFiUlhXaFR5L1BBaDc1b3N6NDZCdWpaTVFBcms5TWtjNlE1?=
 =?utf-8?B?djB2WDVoM3JmajlwOGJaSFJYeG9DbDZXRGVOUGNEV0hMWlJGU3QzYURZeFRR?=
 =?utf-8?B?bEFaem9MYjQzbnZlNm8wLzdGNzJRWlUvdmVUMXRJT3MxcEgvaWxjL2hFWVlZ?=
 =?utf-8?Q?saiPv7MtrUm+u0OrDEnziOksE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10045616-cbd0-4094-3d86-08de02735889
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 11:52:36.6711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyPh/g+fhUy0m7MSRG8DtsMxiYZ5ntfY1Kj8ePQvpluBhDw9yhLUb1Aev44zgB9HMoPtZMmzfdKUMKUWBcijag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
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


On 10/2/25 7:28 PM, Bruce Richardson wrote:
> On Thu, Oct 02, 2025 at 06:42:15PM +0300, Ali Alnubani wrote:
>> On 10/2/25 3:45 PM, David Marchand wrote:
>>
>>> On Thu, 2 Oct 2025 at 13:54, David Marchand <david.marchand@redhat.com> wrote:
>>>> On Wed, 24 Sept 2025 at 13:13, Bruce Richardson
>>>> <bruce.richardson@intel.com> wrote:
>>>>> The meson find_library() API call sometimes finds a library that is
>>>>> actually incompatible with the current build, for example, returning a
>>>>> 64-bit library when doing a 32-bit build. To avoid problems with this,
>>>>> check each library returned from a find_library() call and treat the
>>>>> library as unfound if its incompatible.
>>>>>
>>>>> This checking is not necessary (or should not be necessary) for
>>>>> dependencies got using pkg-config, since the .pc files for each build
>>>>> type are stored in a different directory on the system.
>>>>>
>>>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>>> Acked-by: David Marchand <david.marchand@redhat.com>
>>> Applied, thanks.
>> Hello,
>>
>> I have warnings like this for mlx5 drivers on Ubuntu 22.04 with clang:
>>
>> Message: Disabling mlx5 [drivers/net/mlx5]: missing internal dependency
>> "common_mlx5"
>>
>> Build command:
>> CC=clang PKG_CONFIG_PATH=/opt/rdma-core/build/lib/pkgconfig meson --werror
>> --buildtype=debugoptimized build
>>
>> gcc does not reproduce.
>>
> [Trimming CC list a bit]
>
> Hi,
>
> There must be an earlier error where the check for a library used by
> common_mlx5 fails. Can you perhaps send on a more complete build log, or
> perhaps log a bugzilla and attach the meson configuration output, and the
> meson build logfile there?
>
> /Bruce

Created a Bugzilla ticket with meson logs and more info:

https://bugs.dpdk.org/show_bug.cgi?id=1798

Thanks,
Ali

