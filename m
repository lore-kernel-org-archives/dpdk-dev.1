Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B088DC531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 09:12:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D69A4028A;
	Thu, 23 Jul 2026 11:12:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 38CB74027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 11:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784797976; x=1816333976;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=6Au8qgx4eA9wQv3PzBdTtL0Raz7RZjH49g4qaPkjAF8=;
 b=Nk2tTPyLFnlHiAE+D05g3SXSYpZ1ShdBTu9jEGjPvPQJ2YV8oYyxKM65
 uUfcgbO9JedUichZrPWshAnXMu/7Ed5spxHj6Trp19vH8h3EFIrCfjLMH
 l6FVPLPoxzqHFfnc81FNTg24uyIYLbUkm48AdlLBIX5I/D640/l9Wgzbe
 sHruYXsM60MlW+GeEnBWoVpyXCxlmtLf3soBSrzSoeuM1VEsHutTsHPYF
 CbRLcdjzxAH+pwdATgqgOZ/vEbk8brL1UtOjZpfaYJMOJtkjSLX6FPRCn
 WU8WLuPN/ylWYnn8HpFhGaa1snZLb6NsEgVWT8z7QGiZr3foUYOlBy4Bv g==;
X-CSE-ConnectionGUID: N7ZopLIATY+v19Xu/Ek2GQ==
X-CSE-MsgGUID: FJNEQKJJS4iu10sIqPndLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="108237656"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="108237656"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:12:55 -0700
X-CSE-ConnectionGUID: uoQMJedVQOGGCXOMpC8SBg==
X-CSE-MsgGUID: PYO5rg3aRhinpym2g4Rt4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="257105360"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:12:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:12:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:12:54 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzhKIZx+N/assokYw84PeOmhz3V0wrzitTXD+Sw4VHcHf+yhjLX/gHK5RbvglVrYaZsgGFpYDO3xtcMJcbKWucu+6uuYcce97s3cea5GsLJRwB+pY3Gs7P+oaWL1J9IaBH2lzQhXQJphl4YsLgNgcTMViAz8oJBuj9twi6pfwRoyN5EIEBcU7aOcpgL8ZHDUFqbB2ubf6Xz/tQvF9OyxakP7OdLHN1rc/5XqRU3kUQTAU4nLONaqCFTod4WclecykAZi+Q41pNpxOpubt7IkfjXLBWHZGmLLF52IT9R+raZ8V+10fTX6NTE3iBFqfV9FtAP5zkw+zoK8GygCyc+Vcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxmXiR38Swt2Q5nw8G10mXjQK/xpgZGV8gfKYqBy0v4=;
 b=B01jAMq8vOSWDpp+9EewGvRZB5JUjyuqEifUHWfaY1OxN2Nk3ncn9R+eiHKs9g/isF7RsPurBeCFDR1p2ZhuJ9j+jOFUtzNyziCGUN8ApJl0tPm27xcLz9nLePE6uNU399AWl8p52aSbp65guKrsndWNhTq6urcMUgIDp1oWHvGCpEQ6eCEMhcuGQxpHRCUWq2ftzzWVkUIHSo3ZZDbZHvORwb0DmwxXBYYQTm41QWFTDAvcGj6Qz0TuqZhxNOiEsqEYOk1prE/4g9p803QXmqcl4Yp/vhmR5w4z+kiYLLabn+q1xkGiN4YzsOU2bKCdj+f1/3ktP0QXP1QANauInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:12:47 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:12:46 +0000
Date: Thu, 23 Jul 2026 10:12:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC v2] net/ice: add devargs to control link update
Message-ID: <amHbCSPhesiBh6WA@bricha3-mobl1.ger.corp.intel.com>
References: <20241022062043.1833554-1-mingjinx.ye@intel.com>
 <20241022063849.1834740-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022063849.1834740-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DU2PR04CA0345.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::16) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW4PR11MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 317afed4-e5b1-487a-8243-08dee89a8ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: jv25Lz2mbL4pq6frWxWfQY5Z3Np06w39gDN2vqMGWfd405kKNLwAR/+U6CZJw2B4TeDs2+YxJ5bnjiF0eXKIhXEETxShHY6JnUJ38wd90HLXKL97pD9yXnl02lz7a7a6D9o3l6fwz+FOTc9dfm+g07SR9pTdU2DeZRcBLtkJEJFJwUYrXpboMhf00ZAl9tQnKD/xUucDkHNLOnwOhQwQA/WXKEi0E/Yk6W10u+HQKAXS0stipG0xBoTOgP18PWbES6DV+aHB7oJbZjzF1y+yXhsOeleit/sTqKMJWiUtbNlDGm1QXIaE3XXVKToNeXdrAtNFComk64ajRfrjxa/s9XIoZcV2+gkK3AM+bBCvupbWrd8Z5c3hEWe85o6/ddUwdLC6PU9Bh2KxHIzB4njeTRzYi8kp+Jhb/o4o6524RLrJVXB/usUJvHzPOz3aCMtvZr7rqcvpuAWrS1GzFem9pGufjgghokKN/yJjnu5t23PWGBURIeWkxik2NgcGRoBdeJsCmKnMHJcPZiuES3VbbjvDLwKoIhCpqb7J/DXtw+4hlDUGuNEL4PBa8HdhLDeUn+yC1rg2XyNVYeLwqoPjkd7EHL2KxIoVvzNx+XnHDeXWS1+Hs03XIn04xvpMwkLx9OjvbLfFq3pRpVlm57rypg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzk1MGJxNGszYTIvR0hvaTRHUnNQZFVzNGdPaFFJUHBjRWlyRVlweDZOd3I5?=
 =?utf-8?B?TU9kSnRoUjQxMVVTQjRhWnFINmV0V0sxUlZmWTFlbmVjSUc4UUQ5akt6NGJm?=
 =?utf-8?B?YjBCdmRhd1FrZFpCaTlwQVdTR2E3VEY5TlJ0Y0ZFQzFxWDUxWE50ZzJ3V05k?=
 =?utf-8?B?cVZaU3FGZVlMN2w0K3RLWmZSZTBkaXV3dkJaK2xKL0hJWm1UYThHNG9sZlND?=
 =?utf-8?B?YURPdjNvNmNQUzdXWnk3U2NBMGFlTXRDQStFL05kT3V5YXFWMmpKTEMyNWxU?=
 =?utf-8?B?OENXMWIrd0RCN0xhaXZ3QS9yQzRIcXliemJwaS9JWVhUSkIzMUxuWm9pS0JB?=
 =?utf-8?B?eWFJdUxsY2F1S2JsMjI1cGN5NEptVEViaVpYVmxqSmJBSEVtSnVxRlBQckYx?=
 =?utf-8?B?QXg0YkREcWJNOWhrZDg5aEZBek5xemtYd1BJL0NScnVScXVUT0RQbi9MQmpm?=
 =?utf-8?B?RlRIb1BlUmxoQWkzSHIzTzB0dXFWMHVNMWNFNVlmSjhUWno4a3R4aW54V21u?=
 =?utf-8?B?aFZYTmh5STJDcmM0OW1ldHdkV3I1c05WYjlCbGVrREV2NURRblNJTzFpWlVh?=
 =?utf-8?B?dU9XUDVQU1h1bWp5T05KbjlKWUwrek5yS1FqNnVISzEvQ0VPblBvaDQxbUVk?=
 =?utf-8?B?bzVoMjNkOURDQzNoRnZja2taUmhGS1ZnODNEd1U5WVdMblJ0elk4bmZiN2s1?=
 =?utf-8?B?ODJTVHpydkRpQkFGM256dXVFMk1WQmJ5VExjbE0wVWpQM05zTnpDdGQ3Rm1P?=
 =?utf-8?B?QkFaSC9VYldLdFA5YWtMNjUrQWdUTWc4OFlLYVVzYVRIbGJEOFN0TFY2d3Br?=
 =?utf-8?B?NWV0VlRHMWlpb2RLdkdVL3hzd1h4UkJFbzVGZGhPeVdLSHB4RzJzQzZDdmZK?=
 =?utf-8?B?WG55ODM5aFRmZDV1blpsZE0wR2V3d2hUdnBWTWt5Qmgwd0U5TC9tREtJb1BV?=
 =?utf-8?B?QmxQRUpzSnJmQ0JoL0FMMmhGa3JwUVlOY0drRm5nb3laaGxxdGp1aVU4VXJl?=
 =?utf-8?B?QW1rYUJBYnF0V2J1RlNHRTU4dllLeHorOTFDYTBHZUdqZUREZk9DMDBqMXlJ?=
 =?utf-8?B?b1NUcE1rQkZTTXNPdXFOaFpMSVhwaWpxNk9IUXZnWm5zeXk0aTBmckdCMDhX?=
 =?utf-8?B?dDJwZkkwVE4wWFRlZ2NMVEZGOHZmN3UxTjVjMHBhUktSUURMckk5bXNjaTFl?=
 =?utf-8?B?NjBGZEViSDVJQnhlTFRqQW5maUZkUzlTN1pmWVQ2QnpNbmI0cExhajIzb29w?=
 =?utf-8?B?QnhmS0JOZGJYeC9mMjVnNk5MUUN6dUIwbC80cHdUdU9hQXgrUEdNWU5HeHVT?=
 =?utf-8?B?Nks1WmVqc2Zncng3MWJ3VERMSGJDeTUrc0JYdXBud0ZlVVlJSm10WWlHRGhs?=
 =?utf-8?B?NVJmRTV0emdyaktLMTRHZHR5TXBpdWNENmhHOVZheTB0OGd5YWJJaWpQMnVt?=
 =?utf-8?B?RThHdU1KN1JSSE9mL3NzOHMrcElKbHM3L1A2RmowR1BBRTJJSi9qMjcrL3lU?=
 =?utf-8?B?Rkg5ZGJRQ2lWS0FTdDFBUWhkOUhMUFY2TlBBKzBpL3Ayblg1RzJxT29idzFE?=
 =?utf-8?B?UGRYblFsQ0M2S1hDWXAzc2J4dExnUFRXbWdzeVpoWFlRWFBtTVZFRWpYWVU2?=
 =?utf-8?B?dzBydU0rSk1yNnJrMVdDdC9IRUFnQnB4YmVUNUltQ1Z5bzF2aGRycFZ0blNj?=
 =?utf-8?B?a1R4VTUyWWpzRzJrNFNZQ3p2TEx3KzBOckZtNVNvUGpaSmxsRG5Da2FKUWNI?=
 =?utf-8?B?eEUrN0VtSnRrVEFaKzNQcjEyZmZTaG5KdUFpOGhsUFhQTXkwQjcySDlMVTRh?=
 =?utf-8?B?MHVzUDU4U1RoelplNzAzM2ZLTGwyeUhtVXZRV0xiVmhpMlRQMTk3V1AxcVEx?=
 =?utf-8?B?eDE0Z2Rvb0lIOHpUcGF2VHI3VGk1UUFGejk3TjJpVmdadS9yVmtSVS8vdkoy?=
 =?utf-8?B?c0tKSWlXNkgvV01XS2xLK0lpZTRITTZRZzlGeGFhNVRVdjV4SzNCWkVwbS81?=
 =?utf-8?B?TEFxbVAwSUZ2Nk9qWHpDUVl6UVNyTjd5cnBOck9rNmtXYTNFdXdSbWFoTjMr?=
 =?utf-8?B?NmJJSzc0Wm9OUDBzS1hVaTI0ZzlRZ25FYi82S2VyOVI3bGNncm9XdEovTGNT?=
 =?utf-8?B?UldacmRTSXVkNTVxc2hqdC9hRXVoamVzUXhsMXVhblQ0K3ZFV3ZTMkVjZEo2?=
 =?utf-8?B?ejdxRFhvMDJBdkQ0L1ptKzRWWGQ4WlV5YUJrRFFtc25kZzcwaXlmNGNPWmxZ?=
 =?utf-8?B?TVJlYTRrUC9DQ3QxSHVSMy80YW94MXQ1Y3JYTW9RenRFL3pHclUxRWdUcTNS?=
 =?utf-8?B?ZXl4NjRxRFBaSkNrTGVmS1VCNU5OTkRMRzJ5T3JlVmhiUk41QUhxWnVrcU9p?=
 =?utf-8?Q?IL1wLHqAM19/TKZ4=3D?=
X-Exchange-RoutingPolicyChecked: AT++iIYii6XOSfpOdlRU3bpMNo6hu3vIuJfdeODVsVbV6jRxUruxZ+lBnOejGj4pFuGItvajUknG21ZP2+VeNg2Wg9qGA+ZzwM1m6iuI3U3lLm6NSocnLQt6FJ/NDoRBP3sKxkwG1VTWQmB6hwayu1TmsLWi7eHbCES0DadOHubf9Am+3N0zgySvvOs46MxkIihtNR6e7V9xxGpA03JYTbzufvpJT2c7IqqNGODF9sqkhKuzL1HZLLbp0F8pghQXWOpe7XsXWfMk/PR7NBpBAJZsKhkfVrRCzsPpxVG/YKhZOXCTMQhpDwWctTaDbrhjFwbvA+Yil2HZV97wViZfrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 317afed4-e5b1-487a-8243-08dee89a8ed1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:12:45.9055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJBrwITX7JLiBLHjt2+ygcJRiMo7Yade4KQlBsplYUUPeoZe/iVSxJ3IDN/TgXQjUT85kVS+C12mt8fRXh7qUcgKKeAD4TXO+6/GcESuVas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
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

On Tue, Oct 22, 2024 at 06:38:49AM +0000, Mingjin Ye wrote:
> This patch adds the ‘link_period’ devargs to adjust the link update
> period (microseconds), when the value is less than or equal to 0
> it will be disabled, by default it is not enabled.
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
> v2: Fix using the wrong variable.
> ---
>  doc/guides/nics/ice.rst      |  7 ++++
>  drivers/net/ice/ice_ethdev.c | 69 ++++++++++++++++++++++++++++++++++++
>  drivers/net/ice/ice_ethdev.h |  1 +
>  3 files changed, 77 insertions(+)
> 

This RFC is now quite old, so marking as "Not Applicable" in patchwork. I
know we had some other rework around link status updates in our driver, so
these changes may no longer be relevant. If they are, please submit a new
patch version rebased on latest main.

Thanks,
/Bruce
