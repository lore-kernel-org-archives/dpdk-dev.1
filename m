Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471AEC98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:46:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DE9740281;
	Tue, 22 Sep 2026 21:46:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B277440041
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790106415; x=1821642415;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Sh3+kTod8iWzwF2QWRKqwZ2yBf2PCWzO4xK9U97rip4=;
 b=CM4vycdc3CyRtUb9TfCMlQUhrPA5weHzcZRc6UuyMjCRrKRPgTAhsVwi
 XYKwpq+qB1Gq7Jwa+pCSOGCfGmMvFXOGp0KoeRwGq0FXKtR219Hl1VLq8
 tPdddWWi3Xz7Ehw1d9IPDAc/T03Z05z1ZpeZohSgBclONKKRG/rN+TrKL
 wStfmaEeRg0fayQBS5l6YcO+gqndNmShRIEVLmp9DtjbcL3SGPy+2PGn7
 VHxA8OS38/F4A4GWGxWnKA+xg2PcM3O1mcm42FMpvbv1bEBCLZdRYKS6x
 I2qmobvK9knulI1NOzmabgqbJg28S4jNTwdJpTzJtiNur4IGnBrDVNGMG w==;
X-CSE-ConnectionGUID: J9MY+PjSSk6rXc/M7ppS8Q==
X-CSE-MsgGUID: ZyatJhm6TQ+TgKq8+/y6wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101407878"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="101407878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 12:46:54 -0700
X-CSE-ConnectionGUID: /jDP26uIRYObcVfeBooLMQ==
X-CSE-MsgGUID: I1xW6feJSNKD+jTc9yOrpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="301191302"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 12:46:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 12:46:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 12:46:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 12:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ8KZV8GDrEqdBTa4/QU3XzODR8AQWiHM9TR7RmJkXYIQwDLaLKhUQB/Tx3Y24e+e3gLreBIWPNzCV7RJtSXSTICkCa+hzUQ9L5wvJeoCq4skU0FJIjyjObY61O0NWLzpa/A6zbG5cA2Hqshcp3hDqO4lBDt0UfvWn8bGwHyVQTRdU6IYSIfo631kCD8jpnJG4/A+wVSVUkMU+WGxUag8x0ayNui40K0hfb2JybXR9dWusF/THGO900Ve2Q93iQHmamWGKnabWZA5e/BcgzYE2r9edV2Ep+IaaA7k5gao2B0Betw/Kwl8BKekSPjoS9qzSP79/vJh4XNp2v19s9obA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkPEwNQ2k1bDbheHSTS/alTtlKFMliWsXWPxrYmLLPI=;
 b=OO1x/7Zv5JfyS0uP0IgvRxxfk1AfO6Q9eQ417e0UNotcquTJlhHNz58piUDyfBG8q2D3Lpl3YW9I/DDRiKaR8YrCYquGZ86N7OKRkjIhcD9Viuz1qRLM403yOLOw02RUSV7eWOuPCUWA1zeJdQwYAqcGrxR9gvUCYU/SElP5xQz/Ak9JeILlRdregr/opBUwN0wZDqSMfOtqjvJQ5vTK5tmNi0/iMQtIwW0rbxjaT9CtdJ9lFYZJ7b0mZxHv0iCA6A5799MJc0LvS1maea/meLrHvsHzjXa6FKLJ7e3E/rYCKj5cq02XFx+9jcFxHoadFLwuj7Qh1SrzpKPskeizvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 19:46:44 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 19:46:44 +0000
Message-ID: <30a4f88e-72c3-48bc-91cc-2f9ff7dfa108@intel.com>
Date: Tue, 22 Sep 2026 20:46:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] fib, rib: fix name prefixes
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Anurag Mandal <anurag.mandal@intel.com>, =?UTF-8?Q?Morten_Br=C3=B8rup?=
 <mb@smartsharesystems.com>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20260922155249.3115271-1-stephen@networkplumber.org>
 <20260922155249.3115271-4-stephen@networkplumber.org>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260922155249.3115271-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::9) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|MW4PR11MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc99a9a-345e-43d6-c505-08df18e23ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: b53uHvGjiDd5GB6Rw1KZzsnBcNOzaJouj+u36EeIlzL0tJFKSEC+2YmpDha4YoUGvSpoLK85It8QlH+WNjJmdrXdodxaxq12i3TyxEy8tSXD669oYXHVGZv/mwoyyGDmL8rjsssOWVeS7eFCnR+YdKA6bijqbdG3ZeW5YWdG6ODlrHjwxaREDZ+uE9LHkgftyPWUShw9Zz2rw1vJNGfDGhFd+ya+AetpJgNmo3cL8iK/AqleK6xAy9rsQdHaRPhPvZ9ZCFd/g/FZ1Qy5VXOEnvp9N8ekjnb/sfm9wpiQeoKuUPZln3YUeOomO99ts6asOOGUSBagDdhWXCo4duFE5dgSQLf+9pcXzNXY8d+3+80gHiNdbJOF1UqJsBsXzgjU6URmcNmna50lnioyz9yeogH4B8oSX4W2XlOo4Dk0/cMTYtRKz1BcPCQN71iecJQH9HD3Z2OqrjOO8b82C/JSfgUBptC2rP1WpLjAE78TisGnlvk/uwf6jAaFewN5oXwQFazbLMxaFHbIv1bxI1birnKmyPgfFUsDFNUPExwwscGWcW8tA1rWb8xXK0QPeY5rN0vMnW0BIlJjIH5VKRrXnScnlUd3el4UVXJxOkrzbMe4VX9dsQQYSlXVp4sasX6ZAeqk47b+Ny7G/hL8Vb+Qq25mqLBLwP3IjB1w6fFeoUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZXdjM3MTZIMnNEZm5ZY0xBMWljb0JXaHVHZElENWJoeVdYWWx5aUtMZlVW?=
 =?utf-8?B?MVZxbVVrdElvNnhSL3F6RktUUUZwS3ZwdGlSZldlRENJWXZEL3hwMHBuUVNJ?=
 =?utf-8?B?eDZNZmQwcTA4Y2lSaHViZlRLUDg0TUlSMmpZMU44cXk2dDRDem9WcW5PbEJQ?=
 =?utf-8?B?L0t1TUI5c2dWR1lsME1nVUlpdjA5S2pMSEo0VTlUQzlvNjk3UTZMaHVqTHp4?=
 =?utf-8?B?RTZzN09HWnJLQjV1VnM3aHptZGZ3VVNHSVdBMmlxMmp3MHlISnIwQ1BLRVJw?=
 =?utf-8?B?RTNicVkrUWN1VGc1ajdraUdLZmwzMFZ4dkd3SlFvb2UvcU9ZcGtuTlBvS1Na?=
 =?utf-8?B?TlZuelFPVkdrQm8vL042amdaL3EyWTZoQVBTaW5qUTRFYXIvUHVzeUphSTE2?=
 =?utf-8?B?cHI2TTJibisrMWZtWndFK0t0cWZaam1Uenh2TEZTU2dVajU2akM1cENxY2N3?=
 =?utf-8?B?OW94ZXJYTXZYaU5HU2x6dkl5MVlGZEZsbjNoRDFXUmhod3NremNpQWRlQVFm?=
 =?utf-8?B?N2NRZzhPdWUvd0FrNWlFc2dNQnlDNisrdzJIYVVqb0pwMFkrWkpESjQ5T1hn?=
 =?utf-8?B?MkFUeWF1RWE2SS9FYnljYnpmbkl3SHl2Qlh5UzQ2OXVLQ0RkblBpV2NNT1J1?=
 =?utf-8?B?V2dCOVpXT3J5Y3BWUW1XU1BjUlBORTNHL1cwTWlhdnQxbjZLNlNwcTNmKzJp?=
 =?utf-8?B?Q3ZWNDZGdURLNUczWTdrV21pZDBOSTU2UXBvdkN3VFZkTngyOU9XQXBNcFdp?=
 =?utf-8?B?d21CTTBvYzZUN0NiV3N1ck5tMUY2aU9aaVFmOWp6OFNuL2NRUm1idzE5a3lt?=
 =?utf-8?B?NGNBanZiZVdCWXpBcVVYeWNBYStTNVBMdFIrRVN1czdNNkhKMEg1aDkvcWkr?=
 =?utf-8?B?TU5qV0N5ejJXb1RDUDlPVWxHa1dYbmVzZXpHdjFCbkxpbUd2VzZTZjFvaU9x?=
 =?utf-8?B?ZTVGWlVCK294VGVWekV1WnNhSVRhYy9yK2g3VEhDRGxoQzJvYktkVC81YWd6?=
 =?utf-8?B?ajkxYUdLaTlhSW13Z3ZodTROWnVjeGR4Tm1yOE5YRjRLVllzQ2VRTVozb25L?=
 =?utf-8?B?WmFmcEVKOWtCMUszWjVQdEhJNFMrRWVYQlhsa1dSSzNacEVCbldHeC9RUm9q?=
 =?utf-8?B?Q1ZYd3pOV0Z1WHZsUnRlVjJNWVI2S0x6d1g3RTlDTm5oQ3BVNlVGdUpaeFVX?=
 =?utf-8?B?K3hIb05oSmhLVmw5bnV3SVFFR1lPSWVwVWZnUnhDM0JMT1pZcWcwcUFLSGpL?=
 =?utf-8?B?Y2FJcHd2UExGVHppajYzdWtEcElkQVdNOXZyNWk1bGF2WlAvL0ZUY0ZXcFFE?=
 =?utf-8?B?NkRxREZ1a1Q1d2hnKzJWbjBFVitLMG9OcGtndUFZUzRYRTl5R29wOU5zdUwv?=
 =?utf-8?B?Z1pIOXBGRTdMQ0piYjgzWldoa0orSlF2VlFlbkwzeERCODZsYlRHeTQ3eEFR?=
 =?utf-8?B?c3RFY09jeGtFT0R0dkxvRHJ2ZktWY2J6NWdLbVREWFBodXRLUUdvUXJqdjRC?=
 =?utf-8?B?WkthMFd2QUUzSGYzOFZLTStPMVBoTktqTXJyYjcxV1JFL2hMZ0hoVVpYTmFo?=
 =?utf-8?B?T2FGYVJ4T0U4d01ZSFdvZFhOUDM5ZnVhbm1UTHJtNkRMOWU0bTgxdlZTTDVr?=
 =?utf-8?B?MlV4L0pJWVZrRW1wY0MxbmdCQnk0L0RnTlNtRGtYMFIzR0k4ZHpYVXEwZjVU?=
 =?utf-8?B?T0grZktEdmhmM0ZNSTdEdmhpdGsyTG5VSEZtV2FQY210TGtET09sc2hZaFh6?=
 =?utf-8?B?a2NDNnBhZWRXQzFlbGtNWUxucUdTSVNVbHc0Q3Nlekg2eTVTbDc2Ynh0bFpC?=
 =?utf-8?B?NW5MMGhoS2ppaS9WWThiVHVXZ1QvQkM5clNteWM2QjBIdm5vMVFpekVBdFR4?=
 =?utf-8?B?bkVhQlFRNytnOTNSaTdKVm5TYUxlZkcrb2xKVkxMM1Z0YUo2WnBBTzBUMllG?=
 =?utf-8?B?OVlmelViOVBRSUVwcTExZ0pHay84WXFGdUVvNjNXTlg1ZzdRTG9TemVidEdG?=
 =?utf-8?B?R0FiRkJreXRkY1M4azljWW15Tmc1NDlVZCtnZUJDUWxGbkpaMUE0VW9RaDBH?=
 =?utf-8?B?ZG9FeTRNbEJ6QlRMU0VsaEV5cCsxcEZUSjlxSFJYd0VwSkQ4ckxrRUVxOGtl?=
 =?utf-8?B?NXFJNzFkQWYvbUpaVzhTdVkzWGgzaVV3Y2lQOSt3d0hDeU1peit1Z0JPMkpa?=
 =?utf-8?B?RjRPRTJnQkVDaTNGZGtMaVhELy9Za09ycEpET3AwOENuY1dEM08xQ29TY1Rj?=
 =?utf-8?B?Q0JXUjlnaEZTaE1FQUlIK3M4cWN1bUd1TnJEOUVaQlVNcExOQzBhNWNaN1Ev?=
 =?utf-8?B?dERYcXFZc1BKcW1VYXdRdWNvdFFCYUNTbkVNVjRyREVIc3lja0NubW5qZ1dt?=
 =?utf-8?Q?LARpmOnEuomUwuYs=3D?=
X-Exchange-RoutingPolicyChecked: tIoj/jGtrfXeNJfQT7kUxJRWgJG8TREdrMqY7jLPyhk5fXy4sWShldBkZBZD6dXwmM9bfNLe7KqsC3Go7uJOX3nolgJluNo72v8s/tAbwISyPZL04H+4suF9Lyx5qQlPbaUwJLdkZCmljEQJiX0vMn2o2Xsg4Pz0yiRbvdCjaBfHlLVft5R8xkWYxPqnr2B7IhMHHu3S6/XOg4qdBXLj/PFFSkXN5PyHuwOa47ZD0MPrkWv7PvVUrhN3hBs+xm7PU5w3lBWDoZmUvWHr5ux7XJOd86tE/TUnIEf6QLnEr+8mWUAEl4ckZcG/fLj+y0oqAK3EpKtYdNnxpeJ2mSE34w==
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc99a9a-345e-43d6-c505-08df18e23ae7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 19:46:44.1018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMUWyxJHb9iKyiQWKN9W33bzCLkPaNJJuIq43wO+WSoL5ge/P1x0EB+HtIFU73DEQtw4ktPuysmzzNE+QFSZCZPdRPUYpQXGPkMFsTRike0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
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

On 9/22/2026 4:52 PM, Stephen Hemminger wrote:
> From: Anurag Mandal <anurag.mandal@intel.com>
>
> The RIB library named the mempool holding its nodes "MP_<name>".
> That prefix is the one the mempool library itself prepends to
> the backing memzone, so the memzone ended up named
> "MP_MP_<name>" which is improper.
>
> The FIB library passed its own name unchanged to the underlying
> RIB and did not add a prefix to the RIB name.
>
> This patch names each object after its owner.
> The node mempool of a RIB is now "RIB_<name>" or "RIB6_<name>",
> and the RIB owned by a FIB is now "FIB_<name>" or "FIB6_<name>".
>
> A mempool name is limited to RTE_MEMPOOL_NAMESIZE, which is
> shorter than RTE_RIB_NAMESIZE.
> The name was passed down silently and an oversized one surfaced
> as an opaque rte_mempool_create() failure, so check the derived
> name up front and return ENAMETOOLONG instead.
> As the prefixes above are added on top of the name, the maximum
> length of a name is limited to the following:
> RIB : 53 characters
> RIB6: 52 characters
> FIB : 49 characters
> FIB6: 47 characters
>
> Bugzilla ID: 1981 1982
> Fixes: 5a5793a5ffa2 ("rib: add RIB library")
> Fixes: f7e861e21c46 ("rib: support IPv6")
> Fixes: 39e927248416 ("fib: add FIB library")
> Fixes: 40d41a8a7b34 ("fib: support IPv6")
>
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> [stephen: recomputed the name length limits for 64 byte memzone
>   names, dropped the now unneeded test, example and node renames]
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   doc/guides/rel_notes/release_26_11.rst | 15 +++++++++++++++
>   lib/fib/rte_fib.c                      | 16 +++++++++++++---
>   lib/fib/rte_fib6.c                     | 16 +++++++++++++---
>   lib/rib/rte_rib.c                      | 14 ++++++++++++--
>   lib/rib/rte_rib6.c                     | 14 ++++++++++++--
>   5 files changed, 65 insertions(+), 10 deletions(-)
>
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 99847e9745..31de764a9d 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -123,6 +123,21 @@ API Changes
>     * ``rte_tel_data_add_dict_uint_hex``
>     * ``rte_telemetry_register_cmd_arg``
>   
> +* rib: The node mempool created by ``rte_rib_create()`` and ``rte_rib6_create()``
> +  is now named ``RIB_<name>`` and ``RIB6_<name>`` instead of ``MP_<name>``.
> +
> +* fib: The RIB created by ``rte_fib_create()`` and ``rte_fib6_create()``
> +  is now named ``FIB_<name>`` and ``FIB6_<name>``.
> +
> +* rib, fib: The name of a RIB, RIB6, FIB or FIB6 is used to derive the name of
> +  its node mempool, which is bounded by ``RTE_MEMPOOL_NAMESIZE``.
> +  As the prefixes above are added on top of the name,
> +  the maximum length of a name is the following:
> +
> +  * RIB  - 53 characters.
> +  * RIB6 - 52 characters.
> +  * FIB  - 49 characters.
> +  * FIB6 - 47 characters.
>   
>   ABI Changes
>   -----------
> diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
> index 184210f380..7a587820ad 100644
> --- a/lib/fib/rte_fib.c
> +++ b/lib/fib/rte_fib.c
> @@ -37,6 +37,9 @@ EAL_REGISTER_TAILQ(rte_fib_tailq)
>   #define FIB_RETURN_IF_TRUE(cond, retval)
>   #endif
>   
> +/* Prefix used for the memory objects owned by a FIB. */
> +#define FIB_MEM_PREFIX		"FIB_"
> +
>   struct rte_fib {
>   	char			name[RTE_FIB_NAMESIZE];
>   	enum rte_fib_type	type;	/**< Type of FIB struct */
> @@ -173,14 +176,21 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
>   	rib_conf.ext_sz = conf->rib_ext_sz;
>   	rib_conf.max_nodes = conf->max_routes * 2;
>   
> -	rib = rte_rib_create(name, socket_id, &rib_conf);
> +	/* Add FIB Prefix to its mempool name */
> +	ret = snprintf(mem_name, sizeof(mem_name), FIB_MEM_PREFIX "%s", name);
> +	if (ret < 0 || ret >= (int)sizeof(mem_name)) {
> +		FIB_LOG(ERR, "FIB name %s is too long", name);
> +		rte_errno = ENAMETOOLONG;
> +		return NULL;
> +	}
> +
> +	rib = rte_rib_create(mem_name, socket_id, &rib_conf);
>   	if (rib == NULL) {
>   		FIB_LOG(ERR,
> -			"Can not allocate RIB %s", name);
> +			"Can not allocate RIB for FIB: %s", mem_name);
>   		return NULL;
>   	}
>   
> -	snprintf(mem_name, sizeof(mem_name), "FIB_%s", name);
>   	fib_list = RTE_TAILQ_CAST(rte_fib_tailq.head, rte_fib_list);
>   
>   	rte_mcfg_tailq_write_lock();
> diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
> index 770becdb61..1a31ab09aa 100644
> --- a/lib/fib/rte_fib6.c
> +++ b/lib/fib/rte_fib6.c
> @@ -37,6 +37,9 @@ EAL_REGISTER_TAILQ(rte_fib6_tailq)
>   #define FIB6_RETURN_IF_TRUE(cond, retval)
>   #endif
>   
> +/* Prefix used for the memory objects owned by a FIB6. */
> +#define FIB6_MEM_PREFIX		"FIB6_"
> +
>   struct rte_fib6 {
>   	char			name[RTE_FIB6_NAMESIZE];
>   	enum rte_fib6_type	type;	/**< Type of FIB struct */
> @@ -172,14 +175,21 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
>   	rib_conf.ext_sz = conf->rib_ext_sz;
>   	rib_conf.max_nodes = conf->max_routes * 2;
>   
> -	rib = rte_rib6_create(name, socket_id, &rib_conf);
> +	/* Add FIB6 Prefix to its mempool name */
> +	ret = snprintf(mem_name, sizeof(mem_name), FIB6_MEM_PREFIX "%s", name);
> +	if (ret < 0 || ret >= (int)sizeof(mem_name)) {
> +		FIB_LOG(ERR, "FIB6 name %s is too long", name);
> +		rte_errno = ENAMETOOLONG;
> +		return NULL;
> +	}
> +
> +	rib = rte_rib6_create(mem_name, socket_id, &rib_conf);
>   	if (rib == NULL) {
>   		FIB_LOG(ERR,
> -			"Can not allocate RIB %s", name);
> +			"Can not allocate RIB6 for FIB6 %s", mem_name);
>   		return NULL;
>   	}
>   
> -	snprintf(mem_name, sizeof(mem_name), "FIB6_%s", name);
>   	fib_list = RTE_TAILQ_CAST(rte_fib6_tailq.head, rte_fib6_list);
>   
>   	rte_mcfg_tailq_write_lock();
> diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
> index 046db131ca..55802f0060 100644
> --- a/lib/rib/rte_rib.c
> +++ b/lib/rib/rte_rib.c
> @@ -32,6 +32,8 @@ EAL_REGISTER_TAILQ(rte_rib_tailq)
>   #define RIB_MAXDEPTH		32
>   /* Maximum length of a RIB name. */
>   #define RTE_RIB_NAMESIZE	64
> +/* Prefix used for the memory objects owned by a RIB. */
> +#define RIB_MEM_PREFIX		"RIB_"
>   
>   struct rte_rib_node {
>   	struct rte_rib_node	*left;
> @@ -417,6 +419,7 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
>   	struct rte_tailq_entry *te;
>   	struct rte_rib_list *rib_list;
>   	struct rte_mempool *node_pool;
> +	int ret;
>   
>   	/* Check user arguments. */
>   	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0)) {
> @@ -424,7 +427,15 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
>   		return NULL;
>   	}
>   
> -	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
> +	/* Add RIB Prefix to its node mempool name */
> +	ret = snprintf(mem_name, sizeof(mem_name), RIB_MEM_PREFIX "%s", name);
> +	if (unlikely(ret < 0 || ret >= (int)RTE_MEMPOOL_NAMESIZE)) {
> +		RIB_LOG(ERR, "RIB name %s is too long, limit is %zu characters",
> +			name, RTE_MEMPOOL_NAMESIZE - sizeof(RIB_MEM_PREFIX));
> +		rte_errno = ENAMETOOLONG;
> +		return NULL;
> +	}
> +
>   	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
>   		sizeof(struct rte_rib_node) + conf->ext_sz, 0, 0,
>   		NULL, NULL, NULL, NULL, socket_id, 0);
> @@ -435,7 +446,6 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
>   		return NULL;
>   	}
>   
> -	snprintf(mem_name, sizeof(mem_name), "RIB_%s", name);
>   	rib_list = RTE_TAILQ_CAST(rte_rib_tailq.head, rte_rib_list);
>   
>   	rte_mcfg_tailq_write_lock();
> diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
> index 918ddbdfd3..7d9a0ba36f 100644
> --- a/lib/rib/rte_rib6.c
> +++ b/lib/rib/rte_rib6.c
> @@ -24,6 +24,8 @@
>   #define RTE_RIB_VALID_NODE	1
>   /* Maximum length of a RIB6 name. */
>   #define RTE_RIB6_NAMESIZE	64
> +/* Prefix used for the memory objects owned by a RIB6. */
> +#define RIB6_MEM_PREFIX		"RIB6_"
>   
>   TAILQ_HEAD(rte_rib6_list, rte_tailq_entry);
>   static struct rte_tailq_elem rte_rib6_tailq = {
> @@ -480,6 +482,7 @@ rte_rib6_create(const char *name, int socket_id,
>   	struct rte_tailq_entry *te;
>   	struct rte_rib6_list *rib6_list;
>   	struct rte_mempool *node_pool;
> +	int ret;
>   
>   	/* Check user arguments. */
>   	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0)) {
> @@ -487,7 +490,15 @@ rte_rib6_create(const char *name, int socket_id,
>   		return NULL;
>   	}
>   
> -	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
> +	/* Add RIB6 Prefix to its node mempool name */
> +	ret = snprintf(mem_name, sizeof(mem_name), RIB6_MEM_PREFIX "%s", name);
> +	if (unlikely(ret < 0 || ret >= (int)RTE_MEMPOOL_NAMESIZE)) {
> +		RIB_LOG(ERR, "RIB6 name %s is too long, limit is %zu characters",
> +			name, RTE_MEMPOOL_NAMESIZE - sizeof(RIB6_MEM_PREFIX));
> +		rte_errno = ENAMETOOLONG;
> +		return NULL;
> +	}
> +
>   	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
>   		sizeof(struct rte_rib6_node) + conf->ext_sz, 0, 0,
>   		NULL, NULL, NULL, NULL, socket_id, 0);
> @@ -498,7 +509,6 @@ rte_rib6_create(const char *name, int socket_id,
>   		return NULL;
>   	}
>   
> -	snprintf(mem_name, sizeof(mem_name), "RIB6_%s", name);
>   	rib6_list = RTE_TAILQ_CAST(rte_rib6_tailq.head, rte_rib6_list);
>   
>   	rte_mcfg_tailq_write_lock();

-- 
Regards,
Vladimir

