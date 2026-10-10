Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2850ACA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56E244027A;
	Sat, 10 Oct 2026 20:46:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8B31C400D7
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657960; x=1823193960;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=aNmZI7o9qBEVXVJJUAcgtuv47nDLGUdVr2uoNoCUn2E=;
 b=F1i+WB1zbF8RfyYiOFua3dvO+uaCrj97nQy41GfD1lSLuzCeYYvrLFlJ
 M9JrHDxHw88cAdOhdx1bI89yKmin/Jmj+8w8Hw1OLVThHYqO4dg1WwyNm
 q6kOq/Lf2rmIsTKN6uaeTe24vPs3rHaSziHsvfBc9ltyhVxwczr2s+pKL
 kkZ7lzDdIUKFg47xm03atUyJ+KMTqWO1dI/F7m+xx5e6cRSou5opUxpoC
 WoyoEXy/n/LxohSfz2Hqcga+mkqB6o98C2FJKOClxgSs3pwwF4JMNTY9+
 2y1tLpF86+eShV8jk+QOqZ3q8X4IzB3A0uGhUDuQMEWdCwZMu6DKURRhu w==;
X-CSE-ConnectionGUID: 8sxUzIHKTgayyGv3ZQOyxw==
X-CSE-MsgGUID: hncz0kaAQ+KUNnkDh0ddPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="419198"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="419198"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:45:59 -0700
X-CSE-ConnectionGUID: QhCiMXB+SMu6WkmXYjSlCw==
X-CSE-MsgGUID: XvBXNNpdS5K3QaHWAAlh6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="655310"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:45:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:45:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:45:58 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYM1H8Tj1H4ld9j0V90dkKxFgZRzJwZB0s98QpUFBnxKzxJqVw8x2jfxr1D1wzUgfoSxrwWUjRDzKbvMPHnVpovKj25MKS+II9I6mAg8nyuYXaBB40BAyW8HNMje93aUzlxJnLWyYaQOpusgNqLzdC02oS4VUnwIMoTvT2ONv+eLO92wsrdEt/e8f3DBcCZeKIjHUZYyXqu7dUlIiC5IHN2uYtYik4n2c0qwje2n8UweVFu0rHfaXXdgcher1WQQzN/3w5HgZWkTUXQ6vWwcD8k7/Qy90m1jjc7k3Ol7msNgmnstkYIf86qa596/3VFBaV1pxjzh+Gskn9J6F5NTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeOraEC2GYRxZaML3eeLr852zosvkBoYW7GPPOIG6t0=;
 b=mMA6et6G5fFT62FoSo2YmH7EG/mxMmGe/Qm8nOjmUeD5DnstKci7XPd5THISonU5wjc2cdo1COAM3sWJYRE6SD+AadFyvynLDLASarZxf1rfCh7zCmTRzz7PGztmiZjRwdLH3nH1wXx3KuRWhDpaaPuZuw28ND6gkNVXB5MiwdZA5WC5F9PruBz7ju/xB5zkaVfUeka7MxW9A/qW+ttDtSZ7m2tHdng0P/E95OgNDu7qKioZxf7icwzrXp9WsYx8RuVwn49/Tvdzomw71SSgCfz743Tkt5OIqcdSsbj0DFaLZ5WNkR3RlHaAIGN+iUslu1PX/1OWiFDxF53GJGTi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 18:45:50 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:45:50 +0000
Message-ID: <b00304fd-b452-438f-af5e-08925e5d5c72@intel.com>
Date: Sat, 10 Oct 2026 19:45:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/25] net/i40e: reimplement tunnel parsers
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <cc97b9b4926a29c3b96631d87d6a5b8a5750838a.1791543156.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <cc97b9b4926a29c3b96631d87d6a5b8a5750838a.1791543156.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::12) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2eff53-4f6f-45f5-b970-08df26feb480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: eWtjqiptqXf6mz485N+0gcyx3d7LxjsmexSeJ17RX8JuBQ3gPcHbvzTxDmdp0s7xT1+Rlm573bFN4+WsTjNGKdl4w4P/FMRZBpVB3v1hGxGA85noeBEb/KGtm3n3W6ZW0AanU82nxPrSM3VnGE7PhvouBNUmxLVcvRPgObBA0/TOAXBjC8VPsfJI4MphWh7PvN6VyNr+okwHBiEiGTDxiC9qwzLc/AmeAkVxq7DOqfLFT5NaqdqZFgwzAeHf4sil8cDWhYBHQnszTkxmgSoFNBsZ443QgXa3LBuQbdWX7+POvPnUop1zSeICaQ+koVFuiNzJU+117um7iMGpsBXIEtZF2fbApGyDTFZ8YlJfmCrZvoC+PZtAcI/i1hJhv4jJYp2RnyS0iGwowwAW81Q2V485ZAJ+zv6TuewJS7DYdr9tEmnr0NsJYF1s+4cZJbwY+DOCYneo9qWpJlvaPH8dG7dDPD4ZdRVwaKhpwKvDdDpOmGzQ3AiWX8bsjzIGCHgdsD1dpLQDEYwK505s9J0eOj41UuGk92TYF9es2eQ2hGztNkarhPZ6j10ZnnwgQmPUN6pzDdVUgzPElO+6SPZTcdyxd4EXwvHgqjjDdUvNaJQbWkZK/9DdW7LXl45Uod9vHrOiYUT7GS6r5WETuZov1i19V2oHF+26XAgMF4jJ+XE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NwelAxUGxQVGxuQnJGcEtaYllrNkFISUNsRjlwMlJGVjMxNlpGU3BKYTZI?=
 =?utf-8?B?cE5mc2hsdVRoSjJSQlR3RmNvUVNVYlpLS2lrTFVBODU3cjdmMnV4Zzl3UDdZ?=
 =?utf-8?B?N1psRWtCNnBaSDJBd1NhcVJ5VEFQZ1UwMmc0bFVNcGJYbjFqL1pEMEFreGl3?=
 =?utf-8?B?UkRuak91WDJGdzNlRVUvWWcwQUphZG5iQ05Jb2IzUXdRNlBjZFkzZnJjSHJy?=
 =?utf-8?B?eG1lNjV6NytEeEVtMm1KYnlEcmp3WGo3ZWk3ajQrR0pTNm5PUkZsMGYrZ0tP?=
 =?utf-8?B?ekpiY0t6cG1mRnpmcjU4b0QxUmJvOXZFZUdZSGRFaURxK2N0dVJvNkJsVkxI?=
 =?utf-8?B?cm1kcFFoeloxYTZVUXU3TndKdUJqRlhWYUh3MFo2SGRLa2pwdDFCQlVJQ2Ni?=
 =?utf-8?B?cWFRSk91ZHBkT3plOXRzK1dOU0h5eDlDb0tBT2pPNVRIZDNTS0NmTEl0UG9D?=
 =?utf-8?B?Zjh0ZWFIUHY5NHJDSi9uaUV1VG1vdFkvTjYwNmVYSkcyV2hHbkhURVdtay9x?=
 =?utf-8?B?d0NWa0ZWSFNwcmcvUmFrSVVrYnRkZkh3TC9XKy90NjFqT212ZUdLaXRpcE01?=
 =?utf-8?B?TjdLNEI4WmNPbkVjbk9sdUFBOHhaaFJXMThwVW5vY2U4b1RTbEU2ZTkyTEto?=
 =?utf-8?B?V0xZRTRyRjZBWi9IV1dQZU81R1VRUFgrWG5jSnAyTWU2b3l5RkVpQ0F5aFpJ?=
 =?utf-8?B?NUZKRTdBM09CSWRreVZ2eGIrRW9obVdLc21ISFAzS0VhTVNEQUNoa1NDRTBN?=
 =?utf-8?B?alZXOERYbGpoMVU1WGNhdGVQRHVqWXl4NkgxTUZaNHlpa2J3VjNNRzMrb2hN?=
 =?utf-8?B?M3UxZWhtV0xOK3ovRDNNME5mRFZoK29kS0VuRFo5TVFKeGZNUUVpTGlYOXhM?=
 =?utf-8?B?LzJPcm1Rak1YYk4vK2Q3Z0tVeVJRZ0lnVUYwc2NjUkhYMVNKYkNvYlhEblFG?=
 =?utf-8?B?T3R0cUtWYXRJQXFkY2NFNVRBU25HMVlFTW1mK2RjZzVGS2JzaU9OcXhKb3Bh?=
 =?utf-8?B?Ui9Rc040bmtKKytyWVkveUlVRSs2dm9ZbEIwcUJaU0JGaG5XdXB1QkxWWXRu?=
 =?utf-8?B?MitiTkM0aURicm0yVXhXcWR1SmZHQStHQjB4VEhBNGMwREhBY3NwTjBseTJq?=
 =?utf-8?B?dDRRNi9qNFVqNStod3hNWUxIQjNZS215YjhTUTdVVC9jT2tLdEhPQTFhQVYx?=
 =?utf-8?B?NVNKUWQzZzBxTk5ueS92bzNCcWNyTkppcGMrcGliSXNMMVpiUnYyR3ZQYmlo?=
 =?utf-8?B?R3ZoNEJOYlBFTFNySjlBeHdQakRRZ0RQUy9kOUV5V1FFdGtTUlFkRlNMcTRU?=
 =?utf-8?B?UkZlUjR1a29uNEVVbVFHYjFyZlNtUGxBZEJwQ2J2WjlPSENUeXJleXBMdnU0?=
 =?utf-8?B?M3RoZlVTUnBubFEvVzBRWmtha0lxdkFTOURLanFleFl3TFJvbGdCZVR1Tkl5?=
 =?utf-8?B?eEl2WHpXd3FBR3I0M1J4cCtWZUx4TEVLZXVmTFF4UnNYZHZ4c0ZrREsweTRl?=
 =?utf-8?B?SnRXa2lNODhLMlVMMmVLTDJXbDh2dDdVNlFKVXNyZDVWalNyaS8zTVA5L0tM?=
 =?utf-8?B?anl5Ryt4QjVWYU9BM3o1RHdTelhRcUZPMm0zY1daV1d5TTAwYzZPV3Z6Ujhq?=
 =?utf-8?B?bHpDM1cxZG96MHBCTzVhNWJ6cExkZVhDOUErT2MxMWZVNGxYeU5DZkV3RnRN?=
 =?utf-8?B?SmJhR1AwZFdxaXZ4TEFZRUF6ZUROaHRtcGFCSDFZSzVIbEUwcllCbzRlc3VJ?=
 =?utf-8?B?MWI1NFhFeTg4MnZVT0l1ZFBKYkVIY0JPWFh0WGRUT3VFZnMxdXFSYmdtNG9t?=
 =?utf-8?B?OFFIQlROS0NWZzltWllJbFBsYXZDbGU0ZFlxa0xjM2k2WXloajBkZWFoTmlH?=
 =?utf-8?B?eUZqL0E1Ni93UXNqRzhSeG5XTlNTSVNUQ2ZIRU8weE5yQXJqYVIxTW1wZWV2?=
 =?utf-8?B?aHRJSEpVSkI0RWpjaUVLb2FGaVRpKzVvQ2pkbVR4eWovZ0FEUDhNeDd4L3h6?=
 =?utf-8?B?QkhtNFRXZjFMYTNoMmtGM3Rock80eDNVcFJNZjdiSDUyMWhJVEVveXhrUDAv?=
 =?utf-8?B?QkVXYkg2S1J5d3dEaXBPQlJaNFB0L3N3UDFiNHp3WWFMbHdZeUo3eUl1YjV5?=
 =?utf-8?B?Z2J0SlM4T2RMb3BIN2lod0g1dEpTVWh3RGpiRFNCa1UvMGVqRzlITlkzbWhp?=
 =?utf-8?B?ZWFzaXdJM3k1ZmduR2ZEWWJzOXF4M2tKZFNYeUdmSEVOdDJ5YWtXdkI0Y0tR?=
 =?utf-8?B?cVhsYmR0cExia0ZIK1VaR2pYWnZVcjNYVnR4RkNpb0JwNGdZVFcrK1dvSW9z?=
 =?utf-8?B?TXkwcDZPY3RzdmtKOUZuUVYrbmU3Q0djYTFKQ1dqT3hXYTcvMFppbGJZTkRG?=
 =?utf-8?Q?p6kQd9obFzvrL88I=3D?=
X-Exchange-RoutingPolicyChecked: KH6Jgmi+8oVp/orpprg9P/lNmVrCDKsy75R0Zh9qh1cPCc083rr22+97PcNCY2plP4R/xWBqMt4LT7RChEIBTlzdmH3SFR0uBVhHspBrRKkid3tIsJvxPYJM/w13Xd8Kc+Ad3WNs6wYMxtQpP52I92O5l8CaZpCUqVhewGgUOEQsdcnKhJKsjAlmM5hV9y+w3iXwEzoLpaDJB9qJQNPgxRsaCSmUUolXXUX/AZbdsfb+RvUwpbE/ss/e8T8grURJwZyYuISy69P0elWpEWiNI0UF0hPn2ze/xXbOhnHKhN+ZxMXYvRCfAVVZO9iL7Jy2FEKNVccTcpeK4atxEOsRwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2eff53-4f6f-45f5-b970-08df26feb480
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:45:50.2637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piGgDBamC0S9QDJkopXZzbCpVXCSpUhlf0/zYUBQMjxDjcX2wh4/a3EwWbeWWtyO9/twQAZvbxfwQ74orpkrR7zK+4HDF/2Jnzvl+yRxSO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-OriginatorOrg: intel.com
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for tunnel filters: QinQ, VXLAN, NVGRE, MPLS, GTP, and L4.
>
> As a result of transitioning to more formalized validation, some
> checks have become more stringent:
>
> - VLAN TCI mask is now required to be fully masked (all-ones); previously
>    the mask was only checked for eth_proto and any non-zero vlan_tci mask
>    value was silently accepted
> - For QinQ, VLAN TCI mask is now required whereas previously it was ignored
> - Old code did not check for whether fields other than ports are masked
>    (they are now rejected)
> - Old code did not check for whether src/ports are fully masked (masks
>    other than full are now rejected)
> - Old code used spec to decide which port to copy (as a result, it was not
>    possible to match port 0 - this is now allowed)
>
> Tunnel engine now also share a refcounted global state, and track all
> flows and do deduplication inside the engine.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   

-- 
Regards,
Vladimir

