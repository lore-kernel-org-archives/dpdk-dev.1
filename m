Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5939C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:01:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13B2742D66;
	Wed,  4 Jun 2025 17:01:40 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by mails.dpdk.org (Postfix) with ESMTP id B166942D66
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:01:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbdrgntgZR15JCvmtS6su8RXvxq7/HLwwFPGcggI/CGauwOlbjs56R0OPisNI2R9k0KLugJV/R84LAa2dXYTIz1IVL08Ej22mL5GeQzagaEMGNP57ehsZxpGGgNb73e0sMzsDarXIWRkyFU4yFaL2FAEt+H8Y2Yfl1KuO1FT3SGe5OtL/oPItzvmYpWAjADQlTwVfjoejLKb6ElDASg6D/6rgJkZt4WuFOsEfs1EotFZpuAQhiXBArLIizq7m824CLTG8lUWBLDBn3zC1+POa9FZ7OGu9lnjyWHTHA6+bgEPdHQx25jSfXVDQNgw8MGCrsbpSmFlNg8XzhmWF+wkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIoxc/PLz3tsY75Qplrbt1CmEVP4zfiqNkvNHAYkzxU=;
 b=XKOKIrH+Qgc5keEFg67CzVRYD7YfnA763J3cdCb3DO/wJ51gGUao7sOxjjT4CTqJZWu4QJtYLlkLogRaeZ9qDUjigQ3h6LcKESZ+rGZCeIaNiYFNqyhLiq9FAoxCpMp9ya1pOn7HMSEfZE3Knnfv+NHD85TgXs2vy7XmwRzvBoV/UYA+Q8opTeC5WSiSK8Vm3WFZgKUOueogRmI93+iCBpxz2J+zdAmGeD4V46KwmnkPzhIl6JIg4MQ5GAPDDFnTpfMxmWGNIMYgO8KbyveRBY3+zFSwT2xnN7WzfUAvTnTWZDePIRGQA5XnQ7+dUjBXk7HBW5DEOOw589ULZMaM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIoxc/PLz3tsY75Qplrbt1CmEVP4zfiqNkvNHAYkzxU=;
 b=CZ0S0ucjeKRyI9CdUBIfvuxEBVs0U+Ck/gnwnwjKWRst15gKlST/9FQaMdqo2i/lLZtyIxKKA/WrK79Ns5FG5ZIe9k/ohI4K0HvGVqsstJvEQiTtxlQHUFH8UojNv5+ZumUP3OgnuJf6xHF7KeOEy6fEz5mgjqkiSrk+JXzKjzQj9PW8idmc6jcUVNPajmMzEJiBvC0/oo6o27OorZJu4UiKIf4n6FY3yFoRSSdL7aPcRnSoAPkevc9BtnUYk4CrEG2sBKjSzD5KsXVQ8Eb7IGCOy42jgf3hBdVMnY/26EzMUIoT1GC4FoQkJwE8/7wT2YHlJ3iRgDWOQ1fjY3Gz7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Wed, 4 Jun
 2025 15:01:35 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 15:01:35 +0000
Message-ID: <a1a49430-3a47-4566-b61f-3c604eb5963d@nvidia.com>
Date: Wed, 4 Jun 2025 18:01:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: avoid implicit conversion to 64 bits
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Matan Azrad <matan@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
Cc: dev@dpdk.org
References: <1746458202-12356-1-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <1746458202-12356-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7990e6fb-fe58-480f-e824-08dda378b31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VCtabG16UEpoMmJlWitKWVdNZkhrckFxemlGbVc3blVOWXRaR1BERjRWVWRq?=
 =?utf-8?B?WjhCQ0x5YzhrS2dXdEFYaFRJcm5kbnBZZXIwU3VWQktmR2FVb0I1VDJvbEFJ?=
 =?utf-8?B?dmI2bHNkOTZhQmFIQ2xkblNrSU4yK1FyNEt5UzBxQ1hBL1V5VEZVN1dEQXN3?=
 =?utf-8?B?ZTJRUWloMGhrYlZnYktEZS9VeHBxa0R4dmhESHU5YkJNYitRcjFtRG5ZcEg2?=
 =?utf-8?B?QWJWYWpZUktNbkRyOGhFN21KaW1SRWE4UkdCTkVHV1ZZNEoyRXBrUmppZDdR?=
 =?utf-8?B?RlBuZm41YkhnaHRJZFpkVlVEL01TRzFXYVgwZUc0ZHEvNk5TV3dsaWZwRDkw?=
 =?utf-8?B?dHdVQ1RaTjdkQXU0bFJIUU1ObWI0RUxYWjF1QWZUSGQrMjBNbUVzUVVmZFlR?=
 =?utf-8?B?SU5URDBWT1ZxWlZ6dGpkYklpUVU1aFVvamsydzhrdzFQcFE5MFprdWhldjln?=
 =?utf-8?B?aVhwWWJJR1V5R0MyOCs5WVQ3TTJrU0JDaWJQeXYwWFI0NEVicWxaQ2pjK0RB?=
 =?utf-8?B?elFKb3ZGMmdWOWU1c2hRbkpCbG5rbWQvNElLbWJEdDZra08yV3MwY0kvV2Fi?=
 =?utf-8?B?bmFraGtzVFppZk9DRlAwV3BReHc5bGVzUGZUeUQ5Mk4yTjNpZzhJT2FaRGtJ?=
 =?utf-8?B?dzdPRUJsd3o5NSsxWHlCMWFtd3hKaTcxeFlDcnByVDMzcm1CV3grNHFwdFN1?=
 =?utf-8?B?YzYyZFcrOEYwanRnNXJWbTFoRUt6SWlaV3lHd29qbERldmZ6K0Q4cS8wRlBs?=
 =?utf-8?B?TmR1MG9ZY2hlR005dVR6bzk3SWcwMWxwQ01uV3FlZWdzaFdCWHl6eUhXejU5?=
 =?utf-8?B?ZDBIeFIzVzNxQTJzVTdHdEhCaThhODgxaUlJMWpYaW9IcmpZNXFIRTJkM1Ew?=
 =?utf-8?B?Ym1BU09HQWc2VnF3RGd6VHpybndlemlDUUtTcnROYmlDM2ZCMnlLV0Y5amQr?=
 =?utf-8?B?RnNOUmdTMWl3Y3M4ZWdrdHlKRzQwOGdwWWZXMERMMk56UWx1ZkFrN2U1MGxN?=
 =?utf-8?B?T3JTeXAzcmRvTXZOR09QVDUwZnVJWURteEZqZERQK2FsZWwvS1dya3J4NjFX?=
 =?utf-8?B?cVN4a1FpRlQwNnNDRGhuc3U3VUhJNWk5NmZKYnZoQm1EM1g2OTFZOEZkc09M?=
 =?utf-8?B?MHlLODBiOHNCMkpHaUltODU0UVFuU2FiMTFDSEh5QUJNQlVHS01EY2VQOGUr?=
 =?utf-8?B?SzI2cEtVbHN2KzZIK0NPRGZ2Mi95dHRoU1cxTUg5TTFlb0xQeDlBQ1Nrb29w?=
 =?utf-8?B?bUt0dXVaZ1ZBWHVMemhRLzNaMXZRT3I2UTRkU25IaG9veHJPam1ZMGE4ZHc4?=
 =?utf-8?B?NzI2UEs3b0VxUHpadGt0WXJsZ2xUU05jWUhQVHhMWkgvWHRvekpVM2w4V2U1?=
 =?utf-8?B?U0ZyQ0c2bVFFbDI1RkhYUzNURVg5T2ZjM2lmNG9WZkRrSXBJdDVua0l5bHBL?=
 =?utf-8?B?YmpPaEtETzBPMEQ3b25hTnpnd3Zza0liTTQ1T3crWkRZVjlDZjVmUjlUMy8w?=
 =?utf-8?B?RjRrb3dPaUp0UWM3Wk1vSkovbUUxbTVXWk4vRDduOGFUNGdJM3BBejJvbzB5?=
 =?utf-8?B?OG1YZjNFcnhrdjV6bjdqKzV1VGtiU2syTFhma3VCVE9FV3V1Wk1wNUd4T1hQ?=
 =?utf-8?B?aENTbHR6MUdaY0o4RFJacWxXdlFhUzFJalZQa1BZWVlPNVk1dm15eTh3TUxQ?=
 =?utf-8?B?Yk5pRXdEMHU0ZDlZSHV1dENTdEFRb2RiN2xKN1NYYjJBbE9TZm56RWd4MUFz?=
 =?utf-8?B?enNTc3BHWVpndjA5cXFuRU5NMHBuVEJNNW5kSlV2a25nYnBFTE1XeXVVTHRI?=
 =?utf-8?B?eUVxMWljV1NVajJ4eDc4MktRelUzZm5EUkpoMXZvdjQrcGFRRnlUNkNxVzRR?=
 =?utf-8?B?VHFqWTFOakdpZjY4eDhFdkdObldNeklxUk05aXlvUTB2bDYxR0JpWU1yYjcr?=
 =?utf-8?Q?3muoNaBpoR8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smkwc08xUU11NGNaUFV1VjdQWFVwNzNwTzAyTjBxOEF3TGF2aTVSZ2xub2hn?=
 =?utf-8?B?NE1OQmtseVoxNFBUaTlNekV3Wmxrc0wwVEVhN2dDNzNrUm96aGc3cGJSY3gr?=
 =?utf-8?B?aTdpZVdtUU1FQ3FWb3Y5Q1VUZWRqbTJmeitwVVFMV1NhNXpXYjZ6WUdCNEZD?=
 =?utf-8?B?QmhHNkk2ZmxKYkJ0OGg1N25HSU9QOHpPZHhWcFZtdVk2b0h5TUd0NlQvYWxr?=
 =?utf-8?B?RmpMdk1NZ0xiMWZBOVVXVzlUNWhWdGNvZ1E5RFR2STB0QVZOUCs2VVBETTZi?=
 =?utf-8?B?Yk1GekM1NGFwWWQ5QnlpQ0o1UE5qRHhzanFUQTR5R2VnMWlxN2E4NWdmU2Nk?=
 =?utf-8?B?b2JkUkZ1aFRQTVE1UkNMYjVrWkh4cmhpQS83U2xaYzR6N2t5ZysxV2Y4TTRZ?=
 =?utf-8?B?aCtNbGMzTHB5VFBYdlJZemZ6Zk0vTHlaUng4MlJsNU1UUkFqa0padzdiY0xU?=
 =?utf-8?B?M2ZHMnRxNWoyM2NsSFB1MW11VEZzbG5RWmhJTTdITldFQkxwbm9IdHh4eGEr?=
 =?utf-8?B?MHZUZkljQ0FSMDAzeGk2SVpXNHVma0UwbmhDWXdVZkpNaFRiRDlpd2ZYc0xC?=
 =?utf-8?B?L0Y2Y3pMZ2pDTENIM0pMSVdZUE50VnVPU0pxZUJEenBFdE5sRXN4RjI0dlFi?=
 =?utf-8?B?VGNTZzcyUzdKMUtSYVdLRTdXRWh4Y2lIanVHVkNGV2NHYVJycUZ2dXA4a2ZR?=
 =?utf-8?B?SEdUSkh4VjFRaHFKRjd4SzZSM3cwVkl3MlJTaHVIU3gwdTFaNWJhcUV5aUh6?=
 =?utf-8?B?WThSU0t6dHJmYXM3MmM3YlNsZnlDK2lPdXhVSTZkYTZ1K205K21YZlpicFVo?=
 =?utf-8?B?aHBybnJzaGtldUNBaVY4YU5oTGdQcy9TQTZDZHVXdCs1KzZhK0tjMTd3R2V6?=
 =?utf-8?B?MXIwT2ZwZTI1WDJTSElxcWxVYW9sVm9CWDBobXVRMFFUYVNzaU1UWTE5bzN3?=
 =?utf-8?B?T1BOblNWSGJVaUdNa0VkUUNFdk4zQk8rc1hqemlINEFxSy9JYnlOTjFibENa?=
 =?utf-8?B?ODRDV0crWU1HbStNcDhpTDNlNUoxNnNyOGtxQ0FZOXdBV2I2QjA5M2I0Q29C?=
 =?utf-8?B?Si9NVnhxOUVqWjVtT2tOblRjM3hidUZYb1ZjaVcvdzd1MU1QZFBLZ1hTMWlV?=
 =?utf-8?B?SHlQVHMzeGR3c2lMa29YMUpLaXRtMmpMSVQ2OVhGS3dNMzhyWmVza0xiZlVR?=
 =?utf-8?B?TFQ3NktRR3U4N0VuR3pqSSs4RThuT25WM1FCd3BGUWdzVngxdnVMYThxQlJr?=
 =?utf-8?B?ajBIQWRFVXduQldFcGNwKzJPZExJZUxjNll2dkk0aFBQWGRLZjBBdjJkMkp5?=
 =?utf-8?B?ZEJ0c2pMVk5oYnQrdkIza0N0TkFjYnVHL1BoamhCc3AwdHEwVHBUdUZkNm9J?=
 =?utf-8?B?cTVGZ09sNjdoNHM3bG1QRzFnWmt6K2ZFS3Z3b3JXWkg5dklQQlRyWGE3WjIx?=
 =?utf-8?B?ODBvTTJIM3VzRzA5Qng5dlpaODZ3dnFnYVBQRFBUMXF1TXdjMkJQcFd4VllZ?=
 =?utf-8?B?akFGL1c5VG1hNVdQM0ltUW1QTElCRHFta1JERzVzVVRDeFlMd1dnRVZCY0pi?=
 =?utf-8?B?RjlnanIvb1ZQdWJTc3FpTlo1NFhHMVNNVXVXS3hTY3hpUFRGVmkrREVGQ1FT?=
 =?utf-8?B?ODdMZlZVemhLSytVZS9jc2c5enptVGtEcytvSkM3ZHdiV05rTGNNYjZHNkwz?=
 =?utf-8?B?YkVyU2V1WFg4VGJKMmVOQ1NjbkNhajR0R2dpd2NNYURyWTBoNHFkQndTMWx5?=
 =?utf-8?B?czdTZWkyT1pHRWNhNEk4ZEtkTEE1QjRjNUM2WDlYQS8vTjhRMHZQbjVXZDE5?=
 =?utf-8?B?REVEK3JCVTJpN3lMWDUyMW93RWhaaStaOHVkbUJWcE4yOWZhaCs2cG0rWWlF?=
 =?utf-8?B?bWMzKzF4NmdXaERaNyttdTRaS2JzZnBwN0UvaGllM1ZDTC9BVHg0OUNYOWQr?=
 =?utf-8?B?d0I4bmNBUjQyMzdmU3Y2UVcvWUNnOVBubFMvYXIrb3U3OFo3V1dlRWhTY1BE?=
 =?utf-8?B?UHpaSkUzZ2puMXNLMUZCd0x5QXpER1pvaFdtN3ZnWG9iMTFKS2NRVUtEZjFt?=
 =?utf-8?B?eEcrR1RnOXpyTUNpVTNVZ1ZRcG5oQVdNZVN4QUdobGFMUzBSdGIvS1AvM3Zv?=
 =?utf-8?Q?OKsw1+aGQc4UBDGzdv9weV7HT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7990e6fb-fe58-480f-e824-08dda378b31a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:01:35.5986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ff1jPyjb+3HVjTF1Ci/jtSgGnojJdUpD0w8Fot9Jjvw/rZDHjByL3303+eCw1gTEr1VQb0WS383TrYQmA/eiNw==
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

On 05/05/2025 6:16 PM, Andre Muezerie wrote:
> When compiling with MSVC, errors like the one below pop up:
> 
> ../drivers/crypto/mlx5/mlx5_crypto_xts.c(488): warning C4334:
>      '<<': result of 32-bit shift implicitly converted to 64 bits
>      (was 64-bit shift intended?)
> 
> Depending on the situation, the fix is to do a 64-bit shift, or
> be explicit about the type conversion by adding a cast.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>


Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

