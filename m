Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A9FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 15:19:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64E0340651;
	Tue,  5 May 2026 17:19:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B8C614027F;
 Tue,  5 May 2026 17:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777994383; x=1809530383;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=x2jdm+fw13hRMrRX4o1WicrCQOK72ZrDMXyZHzlv+Co=;
 b=DaPyPRcUOoLe4fVzCDVMJ8LbC0XIXdrAVhLWtZYf4kGonxiVfO6tqUU+
 DlEoYdlLA2iaJXRV+Dv34g2zqTZuCp603/4cAjfHtorxViDBDPvGTDYkb
 W7/vljhxy132r1TnXT1PPtNpeOylpSDhEiTGZYpg9hUQ1xDlxb6lVJNg1
 yey+gX+W2eFnivwIRYRjMRBSitRYbOD0xKdeWD9amCbRUGbJMlLf95cq+
 IY4tmJHACjlYz7+YyY+EtkRQe8hRE60L+PtMaEQDxYR329fGJWOAe+pT7
 ULq61Mjkqvnor+VjQP2rCD2Aol0/MGHta6tselPccjJq+mRTNvlA7e/DB w==;
X-CSE-ConnectionGUID: TlqJqEETTPWYzkeqGBzAuA==
X-CSE-MsgGUID: r6Il7bxmRner9aIYET1Jxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89565570"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89565570"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 08:19:41 -0700
X-CSE-ConnectionGUID: RxQXvzIQSyGzOnjFOpP4lg==
X-CSE-MsgGUID: QYqTj9urTBObzkF/4c8DxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="273973650"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 08:19:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:19:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 08:19:39 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8wqaBveYQOvcur2LZ+4sHtLKa85RwUVDiiSRgbV7RwJItW8RbG+TY8tN4PBUoDvPlzMVo/WGisdEWOIYYaEbmgd1Dnfbfm3xDGdOzJmwzvdR39SBL5OdRD265p7bi3oRdf05/HfiTXNeHxESlKVyrcfBKwKCrjPZ6MFsHq+zJuL6o5hjmwKoi4mdmf593VrhsIkC8y6EEm8DGeXSB/5xRLfvQXoqN+zEb28VsA8NA1HMLsxeGPwoxC6EVJn/0zgqrVtuw5/+4effpX6o7iR3iBFYG2kywE285BUYJFZz+0slQA8yUblrZh5xY0257WIX5U2ovQ0gsVnz2bHEPtFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0fNq3ot5CwOr/xDjMP4lAJUr7jSubRaI5M3BL40LV8=;
 b=OLxPhhZe4v/5/dLzMWc7yDlvSrYGU+5CBsPrAR3sCZRO2EaJemhsfgso8iK00GL2gcuxuSHLj34sM1veNgdcDXdMFBsxbj4ki2jl4X10VdGyQWT22dZmM3GwBKatdlNxHVzBOob3HXneDQEEPHaDCsFhomCqedIaPd9ceLauZc/2R/iLSnI2jLUy3IO84nfPF+0xRoFTEBpPZB5DOmdSSdg9oJlapOcGtdpXZGEs2oygSyd6Y14nNvNtk4A/1tmpP+T+hLWd/27+4mHnaiQN3jGCMCPOZN1eeFmRQ8utbzdwtmIWAdRLjyc4H/8d+VuMSTalbua1xXKM2rR8bI/Fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:19:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:19:33 +0000
Date: Tue, 5 May 2026 16:19:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Wei Zhao <wei.zhao1@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, <stable@dpdk.org>, Daniil Agalakov
 <ade@amicon.ru>, <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: Re: [PATCH] net/ixgbe: incorrect MAC/VLAN item validation for ntuple
Message-ID: <afoKfpPQFn6Z9bVp@bricha3-mobl1.ger.corp.intel.com>
References: <20260427151605.1789289-1-dish@amicon.ru>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427151605.1789289-1-dish@amicon.ru>
X-ClientProxiedBy: DUZPR01CA0319.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2862a3ef-5abe-4180-00a2-08deaab9b593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: sMPCXMw78h4/CVZs2RoGBCRvne2MI+kGvfN/8THCWOVurLLCCfOe/P9PeS86jTqpWQLL9NdoWhiis/9GNhNf6MkdCjRrIG4HnvFzTMReenV5UzGlK15M4kIMxswIOGzIYBfthqbnv99XSE1zt/oujo4er3b3Ju+mYnWHSk26yKuyIHLaJkTW78C8TgQUVX5AVmQ0hOiXO5kDKtmxtdcE+4X7P4NGqaqG+Amis6HGypUgVZtVEkpVLoDi16ElMw23ZPnr4B9bqouvF2B+kzlu0Ul5opC/a29GVnknlI0aoWsuGeSon6B4fLTzSM7sRux7TjutLs0B6ju3h1qHgLtb/2Pcb8prfgRYVHkB05cVHvcEmisISw//H+wfPMfbQvSvfhAQn3TREQ6qLXAksBZ0gVlHSWIG8Gytjp1ai6iHEg/BS7GQtCFZrxcASEPjPiMTv0u0pRy3aF7dW+VotI+Na8xAqRjaTz5NPa20YSkZGDvqnB1HRV7YneI+6iIfiiUhocYzmfEZg/ENzkOy4KH4YnPPUdr5o9hgez5no+3N4pRNO5Ag08HQS7ubT1//D9GSlPInaWcPiH5pOZFpwh3tHl1mENQjbnZWdm6EVO0XjZ9xVJraCu6KfxiEg6paVYCe8LjToFcWwrOQn8u8sswxtrFbDA+fS32yg0O3iDaWJSzZHnZp3SJqoLGpzuxOD0eM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNOU3A3VTZQWE5FaWVTa2IxK3R1OEJ4aE84NDFVWk15UkFIc0tLUnlvNlhs?=
 =?utf-8?B?d0puNzVwSHJDWXM1aUNUeEo2VFZBMlljMjZFZ1lNZHFWOFJjNFRkTW1mMnpi?=
 =?utf-8?B?aWV1dzBMajEvVzhtMUlXNTZCSzZ2N2o5QTFmZEtXcXJ6QTY4MTdIVis3UC94?=
 =?utf-8?B?cFRzZUVFTnd5dHJtVWZheEwxZEk2Z3UyelZjV3Z1NjZCMnZSc0hBVVMwWnFH?=
 =?utf-8?B?WnNVSmdQWFR3SFpDVS9id09taWFWaU9XT1R5NForb25FaXh3d28yNjI3Q1By?=
 =?utf-8?B?Y3N4dDkwb1ZNTFFlejdJVXpIMUtYUHdIUHRqTGVDcU12RjJQYlJUdkkvUnhD?=
 =?utf-8?B?R0Vycm54VE8wV1Rvc251NEc5YlBxU0JGRG5CRjRKMzM4OEdUK3ludUdCYUE1?=
 =?utf-8?B?NStXWStiNCtoNUp3VXZXWXNCOWFHVlBpa25jVWM3MFlwa2diRi9lajRaaWp3?=
 =?utf-8?B?WSt2NFUvUTBxazhueFdGRVJTQmV5RktxS1dQSnhBV2NVZWlBeUJRK1gxL01p?=
 =?utf-8?B?ZVkyUWpDaGNrWXNoQW9qTHBKcVF6VGltRGFSK3pIN01WMkgySzJ4VWFudDZj?=
 =?utf-8?B?UmVGTW40UEJNcWdYaVEvVFFqdWg1MVhBU0hocGZheWMrRU16OFhVVnRiWVpl?=
 =?utf-8?B?UDZQdHMyY1QzS055NjIySnZjeWJaZTFwa2kvOHgxSW5MdlNLZGlMeGJoNmMx?=
 =?utf-8?B?WHlhSDByL1QzQnJmeWVIVm54ZDhkNHplSFRoaDVSQTlvNzNuSlpuakRrYmhX?=
 =?utf-8?B?WVNrWjh1NFJ6a2t3Z0xIdk1ob1V2Y0Q3U0JwMEI5dFVtVWlMZ3lpZTNZS09a?=
 =?utf-8?B?WWpyUUlvTDgvTjRCWHJzNTlCR0Y3Q21kVnI0Z2Ixd1BpK2JwTkMzZk12dXBM?=
 =?utf-8?B?QzRNMklCOEdrTGlRZjM4N244REk3R3RRbmI2d0t1SWR4Ym9OZVhVWktmTkJw?=
 =?utf-8?B?Ny9WdXJRMFYrZWVPSmxHNEs1UGRJU0FyMk92MDkrUm5TZnI3a0liQ2xJQTJ2?=
 =?utf-8?B?aDEwNmVHQ0dTZktiNGtTeTQrNTl1WjAvVEpydjJwYWVWRVBCckU2VHBuOVBi?=
 =?utf-8?B?QXg3RTZ4bC8yeVd6Qlc2bTVWcXc4QU1YQjUwSWhOSjgwcStUcjZwbkpnY1NO?=
 =?utf-8?B?dk1SeC9Qa05pdXdEZUw0c0ZhT09LNEhMREFZY0RMTFdZMTZONGtiYytwQVVs?=
 =?utf-8?B?QWRybWlJMVdDeStMaEU0VWN1Vk9pTkNyb1Nhejk4a1FPd3pTSTNVTnJSUDBL?=
 =?utf-8?B?azZHcXUreHZ4eUt1bzF1WmtUZFU2TzJPYTRvMjBjcjZ2RFN0aHhCYVFORUd4?=
 =?utf-8?B?YTViYlZpSHVuVHNwYmJWMS9CclRaNnl2dDQ5cW04aWhQUnFYOTFFTnN3a3Jj?=
 =?utf-8?B?VUNoWlpJOHV5aHM1UVdKdklqQjJjOC9YMEl0ODFZYitaNXoyZ3ppcXN4Unp4?=
 =?utf-8?B?ZGxUTzRUb1ZhRnM4a1hIaThYNjcrL28yWUZwWTNBRHBZM0JaMHd1TmVCVHQr?=
 =?utf-8?B?OHEzQ3N0VTcrUWtmb2w0cE5HYS9MU1E3WHRVWTZKNzE5aFYrbWY1ZmNxNU45?=
 =?utf-8?B?LzYxV1orRjIrNXdsaDNvL3RLR243aXFmdDgxSjI5OER4dVJpYVVsR0EyaXh2?=
 =?utf-8?B?ZWtGQklJWFltbDlWRWV1YnNvcjBwM0xoeEw5M2YveGs0enRHaWU1WnBPSnRK?=
 =?utf-8?B?UmFyWVREa1RvNjlSOW16Sy8vWURwSWNLN1RNM1libnFFMGM1RmZEa2N6cWFv?=
 =?utf-8?B?NmczNHE4azBKTGpvSGFBeWVZZ0lrYnF1MVk3ajNXOHd4LzBZN2FzeDdlcEZz?=
 =?utf-8?B?YmE0Z1NJT2dkanl2Ty9kYVVYd2lSUUhFSzQ0OXBBL29kcEUyZFRwWGRoNVgv?=
 =?utf-8?B?NFJGbTgwSUxBK3lxczdwclR3UWxLbnBNQXVvQUp2Rmp4TXZETnIrUVVIQm85?=
 =?utf-8?B?cUNodzV6WVhJZ0wwZkQ4bCtORnZSdzdoOTl3Mk4wRTNIdDM0a2M4RzBnOG1Q?=
 =?utf-8?B?TXgwL0J6YUxUcjJBVEFsOFRXSFVKUHNzOU5WYVA3Z25qOVVQVmZpMkxiTjRp?=
 =?utf-8?B?MUlmQjZMYU5GdkIzdzFWb2pDMW1wTytJYlRuRllReUcvSEpTS1hkejUwc1My?=
 =?utf-8?B?Qjc0VkNvTld2Mk9rODdOT3JPUGM1Ri9jTVpaMjdmbjd2ZzdKZkZuOFE1eTdO?=
 =?utf-8?B?dHl3S1c4RkpPbDZIZXFtbzhBVmw1eTRUaTdEWXFaU2p3dXV5V2E3QXJLc081?=
 =?utf-8?B?REllZ3J5UVNRZVVnbnVDV2V4RXIrMWxRdVkvWTd2RlJLTnFiQlRWS0ZuWFJm?=
 =?utf-8?B?OHFZYWFwU09mZjRjTXE0cUUrNFNKWXhvcUFieDlmbE9VSjU1STA4bEhBSzg4?=
 =?utf-8?Q?eI5OnW0uX0MY3Ir4=3D?=
X-Exchange-RoutingPolicyChecked: jtgaG8CRcCopO/n8JhvhUB9jUBYv96wAodgdVCv9QznwCH0eTXRhZELqFRoUgVwDyXfGutbOLDnQEDWOKIDgEEEkgshCVAFRJ3mv6kkGH9PulmqC/vLA08PoK7K4FHGkPC6rYpkflRlvhYPtX/Gry6ssoQY7bPOl4qXYA3usQ/xqBHMDOT5gFkPTbENldmleOAoyP1EXgyUBXppdqvGOGQ2CPOFu9qAlsMOb8PtWxe6uk1i3HNIV9XXYYxYusuaixn+LM6NMVhI5MSVRX5We/bya9GvvO0B14Gjc/ifDW0VU+2cs/+EtNBdArr4GDYlXVlVWeiaLcVz7HamrtbEKjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2862a3ef-5abe-4180-00a2-08deaab9b593
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:19:33.0197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2VlugLvALiULR4DIYtJuNkbe/FZSavM0CshPY/UiEHJWxOkC5ZZgQfYstMSw0NqtSpS9IBrZJocpOZOZ4sxl5/zvy/eOOGYBq9+HS5wl9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177
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

On Mon, Apr 27, 2026 at 06:16:04PM +0300, Daniil Iskhakov wrote:
> When parsing an ntuple filter, the code attempts to ensure that if the
> first item is ETH (or VLAN), its spec and mask must be NULL (i.e.
> zeroed structure). The current check is:
> 
>   if ((item->spec || item->mask) &&
>       (memcmp(spec, &null_struct, size) ||
>           memcmp(mask, &null_struct, size)))
> 
> This condition is logically incorrect. If item->spec points to a
> zero-filled structure and item->mask is NULL, memcmp(mask) would
> dereference a NULL pointer.
> 
> The intention os code is to reject any non‑zero spec or mask.
> 
> Split the check into two independent conditions for spec and mask.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 46ea969177f3 ("net/ixgbe: add ntuple support to flow parser")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Daniil Agalakov <ade@amicon.ru>
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
> ---
> Cc: wei.zhao1@intel.com
> Cc: sdl.dpdk@linuxtesting.org
> Cc: rrv@amicon.ru
> ---
>  drivers/net/intel/ixgbe/ixgbe_flow.c | 37 +++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 01cd4f9bde..9edfff413e 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -238,14 +238,18 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>  
>  		}
>  		/* if the first item is MAC, the content should be NULL */
> -		if ((item->spec || item->mask) &&
> -			(memcmp(eth_spec, &eth_null,
> -				sizeof(struct rte_flow_item_eth)) ||
> -			 memcmp(eth_mask, &eth_null,
> -				sizeof(struct rte_flow_item_eth)))) {
> +		if (item->spec && memcmp(eth_spec, &eth_null,
> +			sizeof(struct rte_flow_item_eth))) {
>  			rte_flow_error_set(error, EINVAL,
> -				RTE_FLOW_ERROR_TYPE_ITEM,
> -				item, "Not supported by ntuple filter");
> +			  RTE_FLOW_ERROR_TYPE_ITEM,
> +			  item, "Not supported by ntuple filter");
> +			return -rte_errno;
> +		}
> +		if (item->mask && memcmp(eth_mask, &eth_null,
> +			sizeof(struct rte_flow_item_eth))) {
> +			rte_flow_error_set(error, EINVAL,
> +			  RTE_FLOW_ERROR_TYPE_ITEM,
> +			  item, "Not supported by ntuple filter");
>  			return -rte_errno;
>  		}
>  		/* check if the next not void item is IPv4 or Vlan */

This fix looks correct. However, the indentation is wrong according to DPDK
coding style. Feel free to use up to 100 columns for the text, no need to
wrap at 80 columns if line fits in 100. If indenting the line continuation,
use either a double indent or align with brackets [Yes, original code is
wrong here too]. Our coding standards also recommend that we explicitly put
the checks in to compare pointers explicitly against null, and integer
return values against zero, rather than implicitly converting them to bool
as here.

Finally, what do you think about keeping the checks as a single condition? i.e.

if ((item->spec != NULL && memcmp(eth_spec, &eth_null, sizeof(eth_null)) != 0) ||
		(item->mask != NULL && memcmp(....))) {
	....
}

Regards,
/Bruce

