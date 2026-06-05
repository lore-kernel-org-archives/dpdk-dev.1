Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8431CCD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:52:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF015402D3;
	Fri,  5 Jun 2026 16:52:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D232C402BA
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780671143; x=1812207143;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=t4GxVr6AzNAiQet6NVyYjOgNhsgikQ1tKPE8mBHiGpk=;
 b=c7Mi8TcNlmeSwXWqGtA9UQ+sWbQHrDB4nhVJjGJIceSgRlDrRxaUyrzL
 cP+3CDfjc2JIBxqNWcgOxarFCYAHljy56NzU2vy+0ckkKuw7KCyHVAl2N
 jlz2YV/ejH7DWlfTMExcusBDdWDHdYvRnrtesZixk2JV+rCRTKjAtDBFT
 aH1wou7kk2d28Oy+gaDaEfOF2MnHzcBBL4pihZBVEN9YA4jP1ujn8/5km
 UgauzEz1W8F1tZzaSlBatUxBS8c2uO0tLMIWfL7JRRPXessIht54p4FUN
 QyvDiwyw0t717XfBkwPxoo6zn2Hwmf3wUQ2pLus3XJx4nfQLljQPEurll A==;
X-CSE-ConnectionGUID: nMKK7bHnTOW/P66ezEWXcw==
X-CSE-MsgGUID: LnbIiO+NRcmS/ajOhEhXJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81413732"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81413732"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:52:22 -0700
X-CSE-ConnectionGUID: krCfUtxQREa+LdJBarfo1A==
X-CSE-MsgGUID: rfAGelPaS0KqrN/rUlWQHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="240408019"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:52:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:52:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 07:52:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr3u1fSGWk7iTxcAVbP55GVm2KrchA0sy9TZH9RlabKc+aOGzty7HGu6tNrDIMWo/Hd2cm66gvX1IV0lBhGa3vihQ5to5D/PtjZrsy3v/D1YdYrLf8JsN74c+aGPYoC6/bMaE6XplzuAbCuoSBtlclxyG3te1poTDHYZJ8zu4iiCQVsMUhhew8fPPVXyo07VJaSlpal9pSimFhr+T5rtUa1fEg5OqsAGdWOjYN00tMfjmxXS1LYAau4cRIza6WKBi6LGgJ0L9+/pAFDe3MSOlxuA0xM8jMz/HCXXqWifLxSSa7EQdtFRYLgUQr4IY82DUUe7f0cBwzsY+/qHupu7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Dq7OhShMqfrIYm22xIrYsdr6uX+ws2XHfDdozQ4iU8=;
 b=X+kNcFcfbmtqbQEAftxzYOYUZKun4Y3yRTLbzOTzdSLrVwfD+opZ2o3Y5NRrDlukiKFTaUouJ6u2RdPRy8IYYR9CTkJNg7RXNGzT3o7gtweHVimy5hPJRWFy3KR3CqJzDQo2xxi+1WuIFqSkdK6MlDGrkPt+a9c8JrSJSoRJdTFKQgpdo5nDzNHI1+KPH2EnOTNyZBY03+MbMXybvqcskpVSWvYzSkFpx8KxukYw28wukOXS7RreVv9aUfee6YqT/6FX+WCqE0kyY+uJKbO1uYvvh0ZWSnnAOjtvDbg1VkHM9cGGh8iQj2zws8uMoZfJ+saxrD6UZiJB/9T+DE3gYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 14:52:12 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:52:12 +0000
Message-ID: <7516c4d7-cedd-4f57-aa66-9a125d085ee6@intel.com>
Date: Fri, 5 Jun 2026 16:52:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] net/ice: fix stale profile after L2TPv2 subtype change
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
 <20260427023115.1225843-7-shaiq.wani@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260427023115.1225843-7-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faa2fe5-e88a-497b-0ed5-08dec31206b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uBbTyIdel10Ww/ZUCNgHfeaUwqrb00j74pYpHsF9vY04DHLB1rISE7n4hZVzrwwCff2Z7M1xqMrM3tEDpHW+sTKnUWxkbhN8FGfjuQKtDgjJWYy1eP8kRNCKp9C79gjPEJCk6mBDi1Y4selelK6YyCVLyWt8wxniCc8NtY+hqOcL5Oro/h+TMQSrqfH6F6KRcrAK5dUqEJBh++E1kPNLXCFqh9i51WDYzRfckoSdukKJg/VCQ2HJlf2blOedhA/zHTH2Vj2vzMVHGDWzejRW6f4fSSWTzbqXV1fpsmmkGVcoXBedf1tu7yhmxFPx3swHNfS3jG9eebTMBrrxb3GE3SbrriKiaTqAgUBXEFCXXGRwVg+l0cwLTSR/DXQLzCKOGuwOW7E4KT8jQeg6DY7I+z40Y3uBhqrEIM4LVKZg7GXVKe/KGyh9aQ0hEQ6erS09wogk8KKxMXt1UzqWsJDEKy1hqG82GO1AkfKNwEeARTEyCWbBfWo4ceiJxXtZD6hMVRo8606LNMj9kOTnQiFWJt7j4+DBZZdQ6d4/gEBkD4dERpUoLNM6N8NODOiO6Hg6gxugwADOP8dpumUAwBG0Zws/O/5EvRqNO+OjCYWKeQBVGbjncApeR4/q4kJWlqbDprLCYnkOWeJUTLywmxxbFyHwhPxkipVe/emT/oh+7qunVrDREf9gqZdVOZ3Y/sL3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRsK0phTlhNWld6NENvdS9XMjhYNHBQRkowTE5Bb0VFZmR2VEdjSCtES2U3?=
 =?utf-8?B?bmlhclpqQzJDeFpMbWpoRHZhNTM4SnhSejUyeTRuR2ZxZ25nZ3JIcVcvc3Nl?=
 =?utf-8?B?eGp4cEFmV3BwRHAyQ2NiZ2tHanN2eDNpeFNpYnYxcUszalVVSG9MdVVtazEr?=
 =?utf-8?B?Y2dpRlRZQ0UwcWR5TkJCVHlLM2dmZjdFcjhtRHE3Mkw2YWl1Tm9DcFpUa043?=
 =?utf-8?B?K3Fvc2czbGJZT21kYStWSWlMRjFDTEluRGhwWVZZNllmZThFQ1JzRWhlY0JV?=
 =?utf-8?B?Rm5nbldrdGZ2Sm5tNGR0V3FLVk5DdjdmNlpJczQxWkNwOW1FTDV0Nmd0WGVr?=
 =?utf-8?B?YmRkWCt0U0VjQWh5M3ZKSlYwdHIwOXB1VCtvci9PYzliQmwrWUx0YWJac0RU?=
 =?utf-8?B?YkVhR21pVlBsRFl1amJ3a1FoNkhYUVRTVHQ2cjIzKzVwV0wrTXNUcnQ1bDVo?=
 =?utf-8?B?bFVxc2IrM0JVcnJ2emZCYWlGMFdhMkp5cGpmZEhReGlyekJRZnE1c1plRlNw?=
 =?utf-8?B?aXNRMzhjMDlxS3hDbTVlNGVweDQ1OFB2d1FJSmExaGZSY1owcjJ6U2w0VDRL?=
 =?utf-8?B?eHNOeGMvVFdtQWF2VUt6Z0pEZExmb2w5NUcyekozTlpqLzVlR3REVzNqY25v?=
 =?utf-8?B?dXV4Z01xaXdZTzZoaUE5eHo4RFE5RnZ4U3JscmFKNHo0SDNwVWNwdlR3dklF?=
 =?utf-8?B?ajhFbDFiVTMvQnJWVE8rUS9xL1BGeW1pZWJlclY2V2N4dWRvOUFwbXRIbXAz?=
 =?utf-8?B?WGpLQ2pFaVdlaVo2T2lzc2RvN1hXM21VaG5JSllzY3FmeFhMTlRNSVBvWXc3?=
 =?utf-8?B?UUxuaFBvUmlORXdSTnJsdThMTEFSNytaK0QwRGVmSkMwSDYzck9IL3FhbEN2?=
 =?utf-8?B?TjJNa2xEY1NOYzFpY1dwZGhyamFCcmc3QTk5WFQ1bFh6MGlNVjV0N1l5Vkdq?=
 =?utf-8?B?QXl4YTk4a1ZYenV5U2NBc3RuVE5sK2hzelVVaXJ3YU8yQk9NYS9FZ3h0bjZO?=
 =?utf-8?B?cncyV2FDMHJ3ZmlMZzIxbzhrU0ptTXlNZHlGSGtHZlh0azVFcGRyT0hlRVhC?=
 =?utf-8?B?TWZMNGZraHRja2lTYjNoeVNyZEtZcGpPVzRCVVdwVWlPRjJQaktsbFNEWmlX?=
 =?utf-8?B?bUw5S1VOZ1NZS0FQL2NLSFd1M3FUME45Wm9kZVhQQnhMSllaQlF4Mm9YRi80?=
 =?utf-8?B?NUgvN0E2WGZ0dGQvL29mZ29GbDJZOHVGdWlXNTh5SSthRWlZYlQ1ajBRTytO?=
 =?utf-8?B?UnhtK1VaUVBZQkM3MzRVV1NZaktQSjFraUdTMG1pVVV5YVVtV0tIT003UzRR?=
 =?utf-8?B?UllmVHhKaXJvU2tWaDdWU1dTek9MZlBBdFVobFRSZW93a1A3YytWV1pNZjVk?=
 =?utf-8?B?YzFPenR4SzJTYjl6elNwajd5ZzlGYkxFaE1qMFpsOWVsZ09haUl6ejA0THYv?=
 =?utf-8?B?QVVFenZGQnNSTEx5Sm4xSE1zNWVreVdVa2NjRGdNeThoWUY5RC9lUkRZeGc3?=
 =?utf-8?B?UnZsTnVqaHltTEV4czdrajZoaVZUZFExK0Y1djhmU3duU0lJb0wzQjNiQ05P?=
 =?utf-8?B?ckJKQVM2U1BBTDY1cXhmby9SamtRVzVyN0dPUmVxUU11eEtISmMxb1ltcldS?=
 =?utf-8?B?cE94RitrR3dseVo5bmI4NDVJYi8rWU5WNVdpSmhXMnlEdzlLbEtKZktqWWIr?=
 =?utf-8?B?bjRHNGF2S25iMzJOcEN4VDdXZnFtZVVBMW5IbUJhYW5qeXNMU1prVGpqcEVt?=
 =?utf-8?B?ZXVHcnhTZVNLK1hIYWZpbGlVckdyU0hFeTM3YVBObk80eGdoQjlJNGVPbkFn?=
 =?utf-8?B?VitDa3l2S2xJZDlselNPMHBna0NVaXkyNjN6WDlmYTFsWFF1MnJYMmppbFlt?=
 =?utf-8?B?YjZHdisvdHhHV0ZvU21XaFZCWkQ5aUdSN3g1dnJ5UmMzaTd4YnFtamhEeHVj?=
 =?utf-8?B?QjhVNXFaQWFTRklKQlFFYWppWVdYWjJRc3A0NmIzSWFzSDJsWldPTXNwMXBv?=
 =?utf-8?B?cXJhS1d2MExiZmh6Ui9PY2ZHdDVMY09sVjlzalB4L0lsNUw1QkpWcGN4SnVj?=
 =?utf-8?B?Y3FhRHBsYUdTTHgxaXNuRnJqODdvcHlWbWNFc3VnVnpLWnh5dGN0VklRYUZw?=
 =?utf-8?B?MFhzNFBId0RpOG1sQ28xY0k1anFwKzNmaXhoU25SMG5RdXA5azRxSythaGwz?=
 =?utf-8?B?VFJjbEtQL1RpWXZpb096VVN0OVp6T1lNdXNpc2IzaFEyaGs1cEpqdUNQdkFu?=
 =?utf-8?B?YUdtMnBvdmdYVEhrYno1MDYyMnFpNUNEWjNDSDlpN1g1N2htVEZSa3FRdFlq?=
 =?utf-8?B?WWdJT0Zsd3lZRW42ekgyOXBGLzBjOG0vUWtqOWFST2FncGE1NmhNUjJFQ0kx?=
 =?utf-8?Q?HWIzVUgOihKAU2wM=3D?=
X-Exchange-RoutingPolicyChecked: bE50Guvlg5dvxMVDlGIFrytMds3/S12Q7gG8y1gSedx+znlx+Xl9SeXQnl/3QnTi/nPTC+pw1E1+TJFzFH7b37MTwsFg/Pgnagf4dtfqdjYyfygmnlIbRG3mQOZnErvekDMpsqSPEFVIQDu+784HJ+OUb56yZwycFIndrf4HW0QCBCQ9r5jWdPZ4xKmZvDU4xXebXn9sxNnzzHENIQ930/a2ENkI5bfOXERBYaR8Yxmautv4tV+fWnUYeyhruskFNPsK9ftFmhc+yEfGuT4v6lfdJrnrSj/sBkxAwcULfpKY975HeD5grDcz28JOqRjc1pz9S+pBs0RcOqQlZ0DyXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faa2fe5-e88a-497b-0ed5-08dec31206b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:52:12.4315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXJnzJRovKaoqokqIkniF4n7w0hiRP8Rc5yWUEnYgREgFbUcAXz+NYyVHiqAefm58n1Or2ZjAtK1tCMMk76vikgPD043R8TH5R/E8pUY4PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
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

On 4/27/2026 4:31 AM, Shaiq Wani wrote:
> After a rule is destroyed, the HW profile for that ptype persists.
> If a new rule with the same ptype but a different L2TPv2 subtype is
> created (e.g. data then data_l), the old profile is reused via -EEXIST
> with stale field extraction offsets.  Since data and data_l have
> session_id at different byte offsets, the NIC matches on the wrong
> field and packets with mismatched session_id incorrectly hit the rule.
> 
> Remove the HW profile in ice_fdir_destroy_filter when the last
> filter for a given ptype is destroyed so the next rule creates a fresh
> profile with the correct offsets.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
