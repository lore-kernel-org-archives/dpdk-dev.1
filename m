Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DC4C83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 15:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C9B402EE;
	Tue, 15 Jul 2025 17:10:27 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by mails.dpdk.org (Postfix) with ESMTP id E3757402E3
 for <dev@dpdk.org>; Tue, 15 Jul 2025 17:10:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkqiqoRysMPk4bFKs/bdPuWjeZLSyt1wZj+752zJrtdahwn8IGoetpsEM+MFf430rczPLGRcled1g8AfnRUQjomLALKTZ3qXBxNpekCpcEG8L7eR/jYqggsT6wQKESkaKz/aiCFKbBc3bNRwaXFaodGN5x28usXVqMEcY/HezVsgJEgM7+GpqAooIN2YVWa6HUrs4XRcqIWpHkxqX+z+o68mfQZ+1i7gfXQtjx0mktD11BXNwrkERvMCXV2Ib8wC8q4aaVurMhyLGOQ/bzjZYI5F21nDnQlQxrfs9BYKP6y71sUgJHqb2HZBC7YSJIIhKK19zzsYHWNnm4/rgPAidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0MJZIzLpBMGZn/UV2N0OvP5txwLcHHotCEe/rTA2TU=;
 b=XRxbyhU4hR1I80VlKjgtfpCHirw534ZOzLFoYKaO43WjVYOoSyvxO0aTUYFHYfHmct55eIfCLgc5VsBPZd/5ba1cz5igh396qkMREH5IJauuM7cNl9QZF4L40Yy56qAAmg3viorqYIWzcBfLqGZc/rfKkwWzlOkExLlYf/l5u8yKhptcp6hRaDCdNf+RCXKMhSL6A6d+zU7R75VrZRsU08CTgPZdFHpcMAUMcp+PrOrIuT7MEH7tVA3Gc/o8XhTOUwMfAgXJNVaHJvE9mmcaX4omJzx+2zgATy2TxMn/RtrHh6mBMCuxMvhPPhC0+UjDOMRgn0pYqWGYtzzthrF3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0MJZIzLpBMGZn/UV2N0OvP5txwLcHHotCEe/rTA2TU=;
 b=hLbgdF1EJ33dF4aFJ0AYf8TdOaD6r+CDmxFmVraV1/6NnlYLbzjv7e5MYPcnDN2vaq+vnxLQIdtXvq5BYaM9KgXUndhuA1BMslUqSfzzYWMCvxHP0sFlozhiUsV12EE0AHlqQHVG7e+tCPzievqrkpbXrLzh1lHzLhamlWH1CIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 15:10:22 +0000
Received: from SJ2PR12MB8830.namprd12.prod.outlook.com
 ([fe80::c3eb:df02:eaa9:2055]) by SJ2PR12MB8830.namprd12.prod.outlook.com
 ([fe80::c3eb:df02:eaa9:2055%4]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 15:10:22 +0000
Message-ID: <f5e03ee4-98ce-4c3f-91f6-c2c0ef727970@amd.com>
Date: Tue, 15 Jul 2025 16:10:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: update for ethdev library
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
References: <20250711144326.1288907-1-thomas@monjalon.net>
Content-Language: en-US
From: Ferruh Yigit <ferruh.yigit@amd.com>
Autocrypt: addr=ferruh.yigit@amd.com; keydata=
 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 tHY=
In-Reply-To: <20250711144326.1288907-1-thomas@monjalon.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0266.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::29) To SJ2PR12MB8830.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8830:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb18999-0334-46f4-bb80-08ddc3b1b7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVBxaC9SWW5vcGQ4VUxxS0t0TlZhQ1NWT2VzZGpxOEQraDlnbUZPdGIwU1lr?=
 =?utf-8?B?RGxqeXptZ3RjMENlR0pnY2hVNWg5dHppekt0WWszZzBqR3NFdWxwcEoyb3o3?=
 =?utf-8?B?YzU2SVBoU3JEUlRneElTVEV3YWdVTTE5Qkg5djlVT1l1U0lZaWQ3VGhPOFVo?=
 =?utf-8?B?SFBWV1c0YUpVRVcvbXBSSjRCNmFEWHl3Nmp5aFlTRTUzRldIVVZHdFVrKzJm?=
 =?utf-8?B?RUZ5d0FPWHREUDZaRFR5TTBDLysvdXZuZ0JSRTVha3VaVjhnTE50ZTJZaklo?=
 =?utf-8?B?Q1dvWGJiSHZpRjh5NXZGWlcwWGkxWFlTK2lqbFMwYTdXY3RWZGQ2TlY2WVk0?=
 =?utf-8?B?OHZxQSs3MHh1eno2V0JVNDZ0aThvVHdMMUpRbE9HREtqWGQzRzJtSm9OeXFW?=
 =?utf-8?B?U0pLU1N1VHRIcUJpeVFOVWZyUEk1cy9vdlFibFo2UEtSTjFpR2V1cUNkS0ZY?=
 =?utf-8?B?ZXpRbWhya0hWdzhvZXhvUEtHUkpUWEtTODBJMHEydlRxL0lsZ3RGNU9zUnJW?=
 =?utf-8?B?K3VTUk9GdkVTdzdITTJ1d0hCd1ZHNDgvL3N1cENWa0w2Zk1rTDlyckl1dEtG?=
 =?utf-8?B?UVJYaEJmZzgyN1ltd0pvd2tqWmQ4Ry9BMFNsNUdRNFNOdkxwcU0wWUNZY3Z5?=
 =?utf-8?B?YVp4QnVOVjNiVGFsbStiYWRjWlBvZysyZ3U4MjM1VkJ5YVpOYnhpbG95Uk5q?=
 =?utf-8?B?T1B0L1dwZkRwYXJYYzdNdzhlU3RtMHVKSWt0dE9LWTBmWUNoaW9NZnVFbDVs?=
 =?utf-8?B?K25tbHdCN3JCK2xpT04yTlRRejJNV0tsUldHTnl6Ti8ybUp0d0JzU1hlUDN4?=
 =?utf-8?B?Rk01N1l6SEwwdXp4WlRjTlg3WE5YdFowWVJjNVJJZFkvNGRKWnA1NlBZazUx?=
 =?utf-8?B?dHZUMDlWNWJaU1hZRml5NG1CcUpzQmJkTkhvS3pVVXlKU1ErZXFaVDh6Mm9t?=
 =?utf-8?B?Rng1WTZWaTdQbEc2dkVheDAxNWkxZkZ1TlRZaDJwbXFtQkZKT2ZHS0dIY3du?=
 =?utf-8?B?ZDlEM2RFR1VrYm1VYkVzcEhucm0wNjBMMFlQaGxaZFgvOFZuV2tHQTFqTHg4?=
 =?utf-8?B?N2ZNUW9jT2M3OXlRMG44Q1ZOWG5OaS9VckVycFhwOEZDU0U5OEEyM0xHM24r?=
 =?utf-8?B?czQ5bnFmeElKS2tsSVJhZXZocXYzT2lnQzg4bmt0NUhWVlN5VmpFcVFUaExm?=
 =?utf-8?B?Y05vK1N5TnZza1U4RVN0Y3h0cjRkT0I4b2RSQklWNHAzVmFYeXV6UFI2Ykhu?=
 =?utf-8?B?dGpCSnpic3l3aEJocXpTbml6OUt4ZFRGYzZMeDUrSWZFREhwTFo1VFFxcVlV?=
 =?utf-8?B?dThsS1ZWVjRGbGJTZTdRL25jZndKdUlicldQcnplTmVzUGw1cUJqenNCY3BX?=
 =?utf-8?B?TXMrbnArOVZMdktRNFRHSW1NS1JabzIxc2trMENNbUI1Y0tCQ2ZmcGo5Wk5M?=
 =?utf-8?B?NkVmTW0wOG5ZdFRBNHdyaFBScWg1RTI4dVJWRWY4VzBjTG13WVQ1U0tXdnBl?=
 =?utf-8?B?UzJBN3FPUW92aTBaNzROT1QwQlI0MUtTZUY2TnNKYWVtZEZYUmRrbXg4MVUz?=
 =?utf-8?B?V0NJN2VYZWhkdDlxdXlRUWYvczI0NFBBWlR4MGg4dGNlSm5KYW9LYTZyNnIx?=
 =?utf-8?B?TURVU0lXTC9WOEY4NWhReHNQL0ZYeC9PbGtSTDNuL1c2bjhSOEM2WlIvNDNy?=
 =?utf-8?B?SSt1bDI4UmhQejNveHA1TkQxVE40KytsMmVRODZqM3J6eEtWNmZ3NG1EL0Yw?=
 =?utf-8?B?ckR4UFdhR1IrMlhRbm5aczA3S200SU0zdUtSbGxhQ1ZYRzFSSHNSeXhwdlFW?=
 =?utf-8?B?MWk4YWJwY2g4dk5lTFBkTzlGS1NldmxtR1RZT1JWdWFiRU9lTmdESExyTkFj?=
 =?utf-8?B?NEtFdktkZ04xTEZobndmUXVXRGFiZHRPU0xHQUMydXRlNnpGamV5S1FtbUly?=
 =?utf-8?Q?V8RUgTjrz80=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8830.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxuZE91QUNXSVhLNVJqNFhTY2NPUmt0T1hHQk1kRlE0UmpJZVFFdDhxWCtu?=
 =?utf-8?B?WWV2Mmw0a1N5TGdCc2hjbENkVzlHMGRXQ0xiWUgxT3JEV3BDSmdkbzBvMU9J?=
 =?utf-8?B?WWdGWk0wdForWXdjRGdIMUdjNUwzNXMrZHZxUVN5akhPL2ltLzBuZEZ0dVNv?=
 =?utf-8?B?RVlJR2FEUmdQVy9NekVlTCtFc2FTaXhWOWNCUkl3THE2aTFxN3Y1eThiQXJV?=
 =?utf-8?B?TlB3L3FGQ0lSVVV6RVBwVE5JMmdOT3E4K2VtRHhQVUlPVU1JZWVhVHhoVlhn?=
 =?utf-8?B?QlBjQmM4ZDFTNlRaNFBxcGp0c29ubmxLZGpGRURxWndCZUw3UUo0T25GbFpI?=
 =?utf-8?B?S1dwSmd5Mmd0azhRaHd5b3J6NGNVMXpUYmpRUDdoVWsreWpCZ2cxVzJmREwv?=
 =?utf-8?B?dzlkYkJDcjJ6UHIybHpBVXBPQWNpUVA1VFZ0WDNnSW85andPZnl0MkprUWZT?=
 =?utf-8?B?dHN0d3ZuZDRUdUZqSVdZUXFZbmo4b1Bza1kveVJEZWJOQ3NGcXVYa2NIM3ZL?=
 =?utf-8?B?bXBHS2gyUGtrdXA0b3Y5MXgwSTlVSDVoYXRDQW03OEQvaTR0ZlZGQ0kwcUgw?=
 =?utf-8?B?T2NPVVc4VmJGdHNLMURtUVhRa1dDZlFXZ2VSTFRxZ1pOSjZHRjZJR1NwUUc3?=
 =?utf-8?B?TmNrS1Y3ME9nS3dIV0tuVU1WN1NtbU1BaVMzSVJMd0kwczhUUmdEQ3Zqek8w?=
 =?utf-8?B?YjJxcE1vRTZ4NjRzWVduRGVmSVAxRzAwYisxY1RMVFFlUStkRHV6elF1am5p?=
 =?utf-8?B?TmdJRlpBNXBXYkFFV0V0LzM5LytCUHFadElsSjJxN1ZWQUN5Y0tpN2VXQ0px?=
 =?utf-8?B?Zi9HY2pDaDM2SGY2K05WOW1mMkZ3aXN3MWlCYzhqSVJWVHl0ZFVJNytHNm05?=
 =?utf-8?B?L3J4QnBid0ZOdW95UVQ3Q3UzSVE4SWMrbFBKTHhabU11MkVCNlUzQUFrMCtp?=
 =?utf-8?B?UGtDNXJ4elYwTWtIbGN3Y1Y4ZHRYaGU1V2JzYnVSNWJqN0d3NjNLV0Z0Sm9L?=
 =?utf-8?B?VGsrL1l2Y2cxcVdwVU9xZlVFQXlmNXIzUFFycS9OZEFhTlVkVlJ3R0g5YjhB?=
 =?utf-8?B?MFFxMFQzYmVZcVNYQ3BnVEF3Q0Q1MUY2YS9IVFFlaU1EQzJ6bUNYOEo5ZG1z?=
 =?utf-8?B?Ri9UN0lLV2xwZUMwUDhkNDJGVUJDbW85VWxPZjFMbHorUUEwV0RaMnhoUSt0?=
 =?utf-8?B?VG8wVC9XR2tENUxsTG1DUEs1VWFRWUVBQ216U2ZlM2d4SkNTME4wY1JBd290?=
 =?utf-8?B?WSt0aHZoN3NsU2NRNlBxcTRqMitvRUdOZFRzTVRBTUVNZlhNYzVDcDBJTHhq?=
 =?utf-8?B?Yk9RWS91TVZIZmZGelB6VnNoVkEzQlAwdGRCQ0I0d3d6QnI3WWxYYm5KU05I?=
 =?utf-8?B?WDFnaGF2bCtPblY3VFg2TlA0QThKNFlSOFlMODE5eFpLRlM0emdqTUtYS1Fq?=
 =?utf-8?B?R2Fma3RrUXBKdkQ5ZVZKVjZ1cFoyYjMvTmxwMXQ2ZnppVjhoUFhKbFRSNmdn?=
 =?utf-8?B?VTM2TGVqeklVTWN1VTYvU0ZicVNEVFJJOUorbzQ2ZU40NHR1cURHVWhJN1Fr?=
 =?utf-8?B?RnV3WE1Ydk52L20yQjlKakFOVHJoWWVWeGEwY0ZUQzNmcnFIT3IrV1pjWXh2?=
 =?utf-8?B?Q0Jyc1lhcHlSaW5IT0xlQnJIaTdKSjEvN1l2dTNaN1Z4eFRXK1NYRTR4eWlt?=
 =?utf-8?B?ZWUrTXUxYTN5QUlWUWh1RFZBOHpoeUU5dGNUSVlraWIwMGVvOWRJNWd1aEt4?=
 =?utf-8?B?NGFpbWltZzFibWlERGpqRlExTHkwK0VNN0xxR2FsNVg2N1ljUVQwZjhkbkJh?=
 =?utf-8?B?Y2tlUG1VTS9KQjRsRzRMVEprQkJnQUduWXoxRzhxcE9seGZabDJvM2lJaHJJ?=
 =?utf-8?B?VHMxQVJ4NmtWMTVweUI2Rng0N085MDM0NXo1dUxTT2RhMkNRSGhyNmt3blZv?=
 =?utf-8?B?Q29LeXhyQjk4V2Jud1RyM0MxU3ZEeDlmcnRpV3pMeXVYSHFyZmtRTlJYZmFn?=
 =?utf-8?B?WHR6WTR2SlphbEpGaDhrb2I1NmkrUXJ4VE95TzVrMTBydWZYRFZnVnBqTkcx?=
 =?utf-8?B?TVJMVFBhRkVENTBrY01xZy9ObVhaWHdVZ0RkS2FYaUdJM042V3N3QzY3Rm9p?=
 =?utf-8?Q?l+NgobQ1OykFJRmarlIYxuJnW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb18999-0334-46f4-bb80-08ddc3b1b7c4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8830.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:10:21.9388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHHRxbrI9Rn0eD3uJYbQlQoxZM34wY6BaZJtcL5uit4Ht2aApPRJufkZv3tWwcDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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

On 7/11/2025 3:43 PM, Thomas Monjalon wrote:
> Ferruh Yigit has no time this year for ethdev maintenance.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9357f3a3..b96496adb7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -435,7 +435,6 @@ F: app/test/test_mbuf.c
>  
>  Ethernet API
>  M: Thomas Monjalon <thomas@monjalon.net>
> -M: Ferruh Yigit <ferruh.yigit@amd.com>
>  M: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
>  T: git://dpdk.org/next/dpdk-next-net
>  F: lib/ethdev/

Acked-by: Ferruh Yigit <ferruh.yigit@amd.com>

Thanks Thomas for the patch.
