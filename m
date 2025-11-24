Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5302ECFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 10:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A1FD4042C;
	Mon, 24 Nov 2025 11:06:43 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by mails.dpdk.org (Postfix) with ESMTP id A9128400D7;
 Mon, 24 Nov 2025 11:06:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk41Kd6M52+a46u/lutaWW5EUo7gs9tPX97mZVHr7270gTSULiRimOfLsUnhvI7dAAxaX9zkUJQCOdhyLgYwBFIg/9BHzaPSVLNt2WiR1uA9Y3EhCrl7VQTU3MdfF6/0WGFZboIZy31sG716YPk3RTi7dko/pPbcrUVQwHz64c3z0s7N2QinBxj4hMWCpggeN2oqNEKl8JSib462dMVsyt/mgJzBNOxzMrYAQNxPbyWeqiWOWNByukXnvDzdyEPsS73WsVDT0zDzMsfaJlFoYeAgRJUzNS8Q9X/h+u79F+H3Vg6G7+CGXl5ux+EE0xdFmGN/mdtlO/W4W02r4UaM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZz8sjNBZHSGqkfW+tbyebnNkFf51VgDRmEmXLwxuKk=;
 b=rJYi8/mLcPR/Gc5QMlcC1RDJ6kLLKgHn0ci9cpfIw8jZKPogZT95ga4POw190tSCYaxjVRmnjZqdTkPGhQP0zaIqdIs5UjyEDnwCJg3oGEXWW4FZaXypByJ7rpXRA21W/Zl8+Dfr2mr3tctI2LmANW6SyB92BHOK2P8QfN+POxfkzs0GCdXd9yG9w8+4MioVlqo6ylpSUADw882fsRT33W7dQOXXf4G+bs5CYG5IxN45r8yDZvlhGFr/IFldlX5vJt06o7gSXEkl0P4/VLVU96ovHnogGSOZnuhp3MPindr307YA+d0IWbvZO2JRMFu3g7eX/HyvYP1jufcTM9qBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZz8sjNBZHSGqkfW+tbyebnNkFf51VgDRmEmXLwxuKk=;
 b=beWwMIo25bECwUdi2gPWBDR/XR3rN1OaJ7B0cxnOEA4cG/1nklzWUDfZ/ES3UNhKNWtCcVQIKcajUpjCw+CknpIwhGQo3nJgSgJscmVaoCLYU001unyGcQ7GXb398Y39a/b/P15S6gpf8AdWu1hQ+UJTlwhhnfEtfKy300XcnQZ54STlfpdvo+vFtvMH3ZhJCxF+W9ckm6ZrWvUrHx0s2YBO9IA9eu+l4FEPQszA/5iYnTcXQiMZ7EzKmSYZmqeICHOkQTnAtX4ojfstkfP7cN/mt6Ik2AdVt9lERkYj/mOuXqncs5wMnBfjOzBUnCxaMDuoT/qgO6nv2mVtmUJpyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Mon, 24 Nov
 2025 10:06:39 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 10:06:38 +0000
Message-ID: <015ac18f-2041-4579-bfbb-94f64dc5c052@nvidia.com>
Date: Mon, 24 Nov 2025 12:06:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix flex item header length field adjusting
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com,
 stable@dpdk.org
References: <20251118145706.1272370-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251118145706.1272370-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: bc508b7a-84db-4d47-9e6b-08de2b41287b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWdYcllhdmZsWGNDaVIwRzV6UDE1Z0svdVNrNzJXaW5rNlRFRUYwS05mTEEy?=
 =?utf-8?B?cjFiSXM5WU1XQ1BnM2RGRkdPVFJUT1llZVY3RFV6SWZ4UGJwZ1lkZzZnNDhu?=
 =?utf-8?B?S09ER2FCOW81eHBtRjVrRzhkNXhWRGlzR2xicjlGdVV3MzhOMUdhYkIzeVlB?=
 =?utf-8?B?Z25tYmJsNTlSOFYwZitIRGozc1djSXREeWdOOFdydmtlSUVqdk5YR3UvSlV4?=
 =?utf-8?B?NGlvNmg1SHVlQU42WHNFWTJOS2RGZGxjWnJMdmo0ZVA2SGxjRm1BUFUrZjVC?=
 =?utf-8?B?VzhRSmQ1RW1LRjFTaDJ3bklwbTJXVlA5ZlhGbHo4ZUhaSGZ4dW4xOXYxN1ZX?=
 =?utf-8?B?ZWZmNGVhb3pkSlRObFBHS0RNc1duUU5wSWJrNzlyUmVEbUJHazd0YitscTRH?=
 =?utf-8?B?WlpsbTg2UWF4QXpsUThiWGpLTjRDY3JjQTdlb3lMRFNnRVFPaTNpQ0ZVcVZL?=
 =?utf-8?B?amgvZXU2ZVhmd1hpMXA4TzY0YzFRYnBWRkxhTmcvcGdpL2NHL2htQzUxYzZK?=
 =?utf-8?B?eDBtUnJQMzVuQWZuVkxVZEtMQlZsZzRxRWpvQm9taTBJUHAvN2J2REo1YzBR?=
 =?utf-8?B?dWd6eG1relFMU0kxZUZqeUdIZmNIOTBseDdoVnhNY0h5OTNyWUdZZ3dTdFJ4?=
 =?utf-8?B?dXNxVytSVC83NCtuV0dtWC92NS9UWGNIM0ZyakxENURtcit6QkNvQWJBTTBx?=
 =?utf-8?B?YXdVL3dlNUpxMGxqSmlyVGxjSnZTNVg2Q3BhMTJzOHZvUmlJQW1yR1pPeUNJ?=
 =?utf-8?B?bHFWTGF3UEI4Tmg2SEREa3pZNGE0WjNQNVRZRXBsYWFFWUJXcUg3NHJZUGdK?=
 =?utf-8?B?bHdUaHhGRFhrckdaWHpYTFArVEdrY2svOGxjNmVsQlR4ZC9OczR3MEV1azhm?=
 =?utf-8?B?NzhHWU1idHRhNW15SEUvdllXZW9hSXJaWU1qOTd2aGxrN3RSMTNpcG9kY3pO?=
 =?utf-8?B?SWVQN3J0Q1hHYzRpQ3VDQndDQWhrNGJzZERVRHh0ZUJWS2UwKzhLbzJPSFVr?=
 =?utf-8?B?Zm1XOEdUNFVac0cvd1I4TWVhQ0FGTG43Y1dicUlMNll3SFFDbVJOdEtEeHBj?=
 =?utf-8?B?WFRMWU1YSkJTOGE0c1hwc1NYTGJIdXBxcGo4V0k0VVduRTUrQ0RWZUpZemZF?=
 =?utf-8?B?VzU5TmtUQXZqZURpcGpvRHMvS0xVZU5VOXBLbDFiM2pKWkdxQ2UvaDhKUDdp?=
 =?utf-8?B?U0xBVEpGQTdHTGlZbUxhaDd6eUNTS29sR0F4M1hxb1lGbXc2UXROdFFMbnd5?=
 =?utf-8?B?RXBXZGc0bUpoRDRBR2V0WExJN0V6TW8rR09XTWRoK1lBWDdhVVdSMmtpUFRk?=
 =?utf-8?B?RzlLZnRQaGFCSHJKL1RzOVZBaTlXZkdWeXRUakdvM09ISmRHakZYc2plV1FK?=
 =?utf-8?B?aUgzeXZONVVEOTBOMFpua05HT2pLQjRUTTVOdVlOaHhObmx0V2kzNG93b1dV?=
 =?utf-8?B?WTh5TkZWbWx5N0dVdmR6Rk1RZXk5YmN1S1lwNWswWmlNZjhjRm1PUFF6d0Nl?=
 =?utf-8?B?di9jQnhNMEl6a2MrV0xpTXNYcU5FdVNmQmhYWnZOMjRaUGJJVjRPeXFBVUVM?=
 =?utf-8?B?cnJEb1pqUUZUamtTbUMxaDNYRGhPUk96dTZvSllkRE16azhCZVk0Nm9Jb3B2?=
 =?utf-8?B?VEJkSEFuK1J1UGlIMFJyRXFCNTVNVnA5eWk0c3QwOUtLUVdDYWl5UzdEa1p0?=
 =?utf-8?B?MDQxRnZ0U1NJOEorVnlFV29VVnM4VGdnQi9FS3VLWUhZZ0JwcnZSOGlzbnA4?=
 =?utf-8?B?a3cxdDJHbHpobjFTU3NvcTlWWHFHNmIwbDFEcEFIckJ0N1NKMmhDN0xQVzZp?=
 =?utf-8?B?enJVNkZRaGY4dW5MM0FGOGRKUjJVNUpGajRnTTZINStvL0o0aHZNdkx4U2J0?=
 =?utf-8?B?b2RzTjlHK082bUVZR0tHanNYUmdhZi9OSlA1MEpCVWlGV0d0Wkdnc0ZGem5p?=
 =?utf-8?Q?5Yv625DG9Wv1ip+r+XEu81YR+rzVu6+x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZzODQwbkpFTyt2WVVIUThDY21HS2YvMnpGOHR3WENhenlhTVNOWnZmVGdo?=
 =?utf-8?B?WElERGhXaE1KbkRud1AwUmwzSXJ1Yk9PVUhnREZOMlVwVUhOUnJIdi9UR3NE?=
 =?utf-8?B?azdZc1hTbEFlaWRwY245WE9lS0lJcnVkV1o1VGlVT0xVbHZkZGtXM3ROOWRD?=
 =?utf-8?B?NW45S3lSRFpuNFF0emZoTTZhaVBMYUN6QytGSG9GOW4xZ1hGV3VZUmFnQXg4?=
 =?utf-8?B?RHZES2NIZURudnhNemg4WTRnVVFxbENCTlVKRkt2QzZRdzV6NVNUSnNYTnd5?=
 =?utf-8?B?TG1USmRvZW11L2ZwaFJpR1lSWGZFSEVTeC9wN0hhZks0WnVCdVovMnhDM0tL?=
 =?utf-8?B?bVN6ZExpMDFhdy80QnZ3L2ZSMS9kWDJ0anQ2V2hEbDVhK1AxdG4rN1I2aWJw?=
 =?utf-8?B?K1c1anc1TFNndWcyQ2M0SXZUaGFQMER3azBHZnlkYldielBBdmpjNTQ5anp3?=
 =?utf-8?B?WmU3SlJmSWhPSDNpQ0RURGRoZ3ZHZ0lNZUNuMEQ2WXk4M0xHc2pqSklRb3JJ?=
 =?utf-8?B?NXAxVnUyOXV4MTFOQ1FzNStjMVdmckRyQ3pZdVFOR3FyWitwUndEaU9nSGpK?=
 =?utf-8?B?bjhmTHNieURDWFJXNjdhMjRrQ0hnQjd0QVdLQTVHNklpQXU5cGNzaWkvalpB?=
 =?utf-8?B?SXBlNk0xeVlCdWVFbzZQQjRIU0xpRmlyNVdrSGZScnZsZzA3SThLa2JpUkNK?=
 =?utf-8?B?cktOVzdRTmgxN2NhVDlUK2FOaS96MzFxbHlIWitTd1E5dDlObHFiRUJjb0dX?=
 =?utf-8?B?MVdJSWh0bDZtV1gyWUtEMHJHYUh2bkcvbUFZSndKUVo4eXlaRzNjSGlPaENp?=
 =?utf-8?B?OFUzZDBRY1VTN0EwdjlKN3l3QWt2V1RKUjRMT1FSK1BvaWw3am8xS3hxZnQ0?=
 =?utf-8?B?LytIb1VlRjNBaU5FbVpnc0tidzRIL0NwbzYzL203TEU1V1R1bCtUWEpjODNw?=
 =?utf-8?B?MERLSWFPZ1FZc1Z3NllTTkNrQ3F0VStDcE5OSllZeXpHRmduMzhrWGp5Q2tp?=
 =?utf-8?B?Mm1adXorTTJLUGhKbTA2ckxmelRFVm4zRFpJWW5ZenNqMGFlTEpYU2VUc1Rl?=
 =?utf-8?B?YkdzM0I2Y1VncThJaGU2UXhGNjRkL3dKanBYaWJsUUR4MGJ2b0FveEtOVURp?=
 =?utf-8?B?anAxd0FrTWxTeWpjY0VwRGRoNzRnVDNDdi85WFA5WmwrQ0txeGJENG9NRmV5?=
 =?utf-8?B?VVgzVW1nTzdhWFoyRVBTTnM2Uzc2OS8yYVN5d2xqcHdiM3lueWpUbGpLMDBW?=
 =?utf-8?B?bjhrRXhuYU9pYXZ0cHZWcVpZSzVKdnBIYnZUTTg4dUdFMm5YRkh2WDFxN2xu?=
 =?utf-8?B?bStWNGZmd2toRW01QzFmRXRJSktQbGgvd3h3a2RScEowdEpBVnA3MmxiMXNG?=
 =?utf-8?B?elU5S1d0RlVhZWQ0cHJJb3pmQmtoMGxWUzhoUHJJYm93d0JCalF1OWozdCtW?=
 =?utf-8?B?eHAvSXBpRkg4MnJaZ1ZxZEd5M2ZOVElqR21XYnkzaWpuRDVuOWd0Sjk5My80?=
 =?utf-8?B?SmttVEZMWDQ2MzJpamx2YWk1dUo5MzVKRkcrWmNSTVlUblNwelpUQzBsUW0x?=
 =?utf-8?B?RzQxelFyUmphcTMvOWNSdUtTS3RFYW5TVmdTUGxoRkdUYzVaaTh0R0pFcjd4?=
 =?utf-8?B?R0VBL3lNb2pRS3B5QXZLUE9IcEp3Y2Z4NGZmcDQ2UCtxaUViSTZ4VkpCaHFv?=
 =?utf-8?B?WFg3NmR4a1VlT3JYSGZPWi9ESFBNL2lWVEFOcEhzWG5ZaDErditBUUY5eXJs?=
 =?utf-8?B?WHdsTmI0T2RsN3pjSTE3Y0t0UHRTanpsblM5TVU1cmZlR2VsSzA2bHhxR1Jr?=
 =?utf-8?B?V3RvbDcraDNCWHF3cXpyVEtJWFZvSmJ2UE9XUitSRnhTdFZvc3MrSzJxcXFF?=
 =?utf-8?B?eXh4Y1NUSkZWczE1c2UvcjhuWHY4bEVvb3RHTEpoQ29IOHJSTFUza1kzVCty?=
 =?utf-8?B?ZnluWVVBTEJtQ1ptb25QNDNWQXp3WllrU2wxeVl1MDF4NVh6QmxCMG15cFo1?=
 =?utf-8?B?Y0VKdmNJZ3RQSGlmSWl0bE0zRGxqNHBpcndPZG5MRWhIWEd1YTBaUkFMZW5J?=
 =?utf-8?B?SkJuNW82RFFWME41L2t4NFlBZzNtc3IrRU5jUzFPdFMzNHVESUJmN2FOSDlJ?=
 =?utf-8?Q?VBgHH4hmmNgMrEa71HOilAHoA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc508b7a-84db-4d47-9e6b-08de2b41287b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 10:06:38.8324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9TXwf1i1qgH6VR/yjCmUkEd+hU/uS0kzFWVqjJOCWTkGxkBNUr5cNwhiAZXzswvRSuLzGljCMwiH6Hi/SUcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
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

On 18/11/2025 4:57 PM, Viacheslav Ovsiienko wrote:
> There is the updated firmware providing the new capability
> bit "header_length_field_offset_mode". If this bit is set
> the length field offset in flex parser configuration should
> not be adjusted by the supported field mask left margin,
> and the bit "header_length_field_offset_mode" should be set
> in configuration command on the flex parser creation
> firmware call.
> 
> Fixes: b04b06f4cb3f ("net/mlx5: fix flex item header length field translation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

