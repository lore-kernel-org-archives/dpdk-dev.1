Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63068C98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:54:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5521440608;
	Fri, 25 Sep 2026 12:54:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DDAFA402D9;
 Fri, 25 Sep 2026 12:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790333690; x=1821869690;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=G/DP7QxiPoQfOI6keZc+E032T0PyoZ03BT4Sc/9PHC0=;
 b=IRoARzcLeJwJpoBD+BDzJqIqcnDHwi+ejUNj9mD9rEnGpz+aRJ8ByicX
 fHF+htLguZb32uV1ucbDKGgFB83tWz1eV//OSZCKM0xEzRPXNiBnOMXGR
 aUXWELRZmcJXGCSWgF5PI67I9ir/ozEvcpyAx/w/wEjGi1UHAbjD7symh
 v7MBSVJAIL07rEyjvuxaVjgxCGIRV0ShA/nD77QAXjx7VgQ05lSwtG75q
 +4Aiz0VE8UrXn5OBz2bG+nPJMpld20C4hcxM/GrK74GK26ULqvHTVieHd
 9ck3DQHnkcaqiC+mrt4iQnmbDXMQ0d30ilFc85rVQWT1E/zWkA6uE7DTx g==;
X-CSE-ConnectionGUID: LVekZcb3TvGQNo3bW2Oe2g==
X-CSE-MsgGUID: tfDdUk/tQ7qYjR545wPSWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90076235"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90076235"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:54:49 -0700
X-CSE-ConnectionGUID: a0/lkQkDTdacWcrYyswAEQ==
X-CSE-MsgGUID: 7VDg8NwERiyeHsHEM0XTqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="272883340"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:54:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:54:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:54:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw84/5gE4f9W8Fk4wWxELbk6LvMngwGSONMaNsmJmqrF3MSpspf3EZkesayUW+1hgZ2zEzuLb37mboeTUsbTFCV9WzDrf3pU0ydFzKSBBbxSS0ctTkxtF0hJvF5Bny70iQUn7o2eYxzvQQI+D8s0Jgel1s8q+MiiHMQ2MW77qWPItmwlqpDavqBPUL0mWokpBRBEkrA2QEIbPHHIjmskvUEQ7hCIS8siU4aP+iPSOiwU7zXTFQqNJOJs7B2o86FXmkzgRY3sJ7tQwHNuMoLXGhfbfypNqDUe9T9QOyYg4pRMQVgPgQmVtthp98hAB6p/MgoqOiUT2A+gPfvwvskVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKSctnN1CjIGulqu93sOMJMzlFV2XHfUIx45z2Nv2T0=;
 b=PFWNyhGnve5EX7QXbZv+K1K20wzYOyZlelQl6TILXGEIh2/TfgsFLuzQYpzhSJ7yIf8LhBlnwGFZL/KtciNMqYeaCtt7UVJ+69YY0a6czMWNFtw+AHj2sAjLCu33Ryw3Og7HkoUCkC/7Qw0iLwKe+Kq8Wu8lv1jAvASidtnT9zjV5ybmUN1omPewduTh3T7R8uGdu8FLz2169JV045GBB/JmAILoGlNKu/vtEh0jv0024D3VB1O8VFXt5TqNBIoZnmpJYiboOj+v9oOw4Y8Q61iYQC11Z9HWHjmE+BQ+l9qOKWrI0ri3fMknvDLGX8VYg+pkViAuJt5rX9ElwBj0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB6730.namprd11.prod.outlook.com (2603:10b6:510:1c6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:54:44 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 10:54:43 +0000
Date: Fri, 25 Sep 2026 11:54:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>, <stable@dpdk.org>
Subject: Re: [PATCH] eal: fix C++ builds when stdatomics is set
Message-ID: <arZS7u1zo5ES3SCZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260924141246.4037433-1-bruce.richardson@intel.com>
 <CAJFAV8x2qg7x_g=fQq3odv8cmrP_a=Ax4_HYZVpg-jwXVAujJA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8x2qg7x_g=fQq3odv8cmrP_a=Ax4_HYZVpg-jwXVAujJA@mail.gmail.com>
X-ClientProxiedBy: DU7P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 85747429-4045-4b1c-a562-08df1af36819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ZRlARh4Y9BK3AsuZzeS/sIztZbexcBysZgxU74JrG4PFK9lOGZTfKcqbu8TldcMvaFMNhg1Wdm1ms3zJw0nWIfohuOxFO/SBOviNKbO12D7ABkWy4qte6eO9FVWPFvKax9CFgaLYevHANbhdhGQJUZqpFNnm06WFDPTt7IxAfr/pL8JlFh/8A7z2PavgVgkEMUX7NLa9U9IpdYv9DDal0DaufyhDk2KkgQ7r0RuHZDxYrtFCmX9KWXaV+ocDiVBD5kBRSfd10aH0lOlSk0VFV0eGkRt2RvWk34PQfafVOCHottdaGJKMyUetYZdhZZuZI8TdPZTKtSgmPzTCBux1NcG6Lbutjk9HpygBukxP2TgcA4iPXVnGBmkGsWR+dZRZseEmzJrP+VBW9/h4qWsPkS57rXH55lDTdZyBdyeEEXC3xjD1DLwuDmAc5MQYismYZG/U8rUDmuWR1bLI7OwiEFOg9fWOst1IPSmiQZN93TU00sEMZGcSs35/cXC2zvuqCeZIoVj93IQIIzpMPEBlQne9BvlHEZrL4Z3AzJYjAZyvLGJC7JppQL9Fuz3pyROwQQclMFROMCjH1FRcTkiYdMocoyLxHXRj2zs7AR2R15l1vbLL5kg1ON2aGomMtAHPwQI8z2fGKjiaCqwgKjo31i7XTd7cuFum2L7g21CCuPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MktNc1o2WklJeXlXaVkwWUtIaHNENWN1UkRHRmo0L2FSZDlBdnN5Q0xwNjN3?=
 =?utf-8?B?d1V3V0dGVTN1MFVaZUhtRE9QaVo5TmxyN2FPTkxUM0ZxUFdjNGJyV0JCdGxm?=
 =?utf-8?B?SjloNHoya2lBK2dFaVkzQkMyRjN1Wmp1WUw3ZkM0V3VKQ3hJaWxYb2tFdG95?=
 =?utf-8?B?Smx3VWlEYis5a21TSEZhUGhVS0pHQWhLTjNlRFRrZ2k4N0tyS2VaZjAvdFdR?=
 =?utf-8?B?dFViVG1SWm50M1NVcnVmT1dwbVFuL1c5U0NtTDVYNzFXOVVob01mYWEwNjc0?=
 =?utf-8?B?QWF3T3VpZ3dGVUdzZlIwTXJiVWt1eXlEV0FPM3VpNG9lQzBJV0NCNG03eEtB?=
 =?utf-8?B?K1hkcWhLZlVFV3lSUm14UW10RkNKVjJnTjVxOGlMclhjNVJDc21QdmNxTDZU?=
 =?utf-8?B?RHYrOWE5amJKNEYvMmFqYVZzcXh2UDU3UUZJYUpuV21CZnRXLzZWQkZkT2xs?=
 =?utf-8?B?UE5Sb3FlMVR6Ri9KYU9vbTl0NWI4Tldubkl4ZVVkeVNzcTBvNXF5Um96d1Y5?=
 =?utf-8?B?QUdvU1M0YW83VzR1ZWR3Ti96OFNtMGgyTlplNVdzVEFya2RsMmx1ZGg3NnNZ?=
 =?utf-8?B?akxvTXU3MGQvOU04Zm1zME1VaGZxVUtndzNoSjY4THc4alpiajFEcU1SeE1W?=
 =?utf-8?B?WDlNTlpjaWEvTHlkbWZodXF6cEpZVVB2cDRpVUVRczVmWEsyUHF4alJhbDc3?=
 =?utf-8?B?MkZBcnQ1bzlOeXJoV1BuQWdCdUNDcUNJUGNpZTBnQW5BdkFjQjlXcEpkWjU1?=
 =?utf-8?B?eGdZZ0JHQ1FFTmVpbXN4NmIwWWlGcXYxV2I2c3ErdkJvZGZGYzF5aVk1a0g5?=
 =?utf-8?B?R0dzUmsvRWVVRUdpOFFlTUhLTEQwRVNVUUNaMlY2cXVub3h6Rmh5RmpTMFBm?=
 =?utf-8?B?Z3RDMktES3Y1S2RLb2tadHI4NjlnWEVpd3MzTittemhBNXRiYTBLYi9IMjJD?=
 =?utf-8?B?NlA4Y2tmdndESERydmFjaFkrR0c2dXhjYnJiRTVhR3cvRDJuSTRka2FqQXBr?=
 =?utf-8?B?Vm9tWXFtbzUxUzE5UHJCSXpxRGdITWw3Y2lsQS9nd2RFVWZBbWJFOVlHdFJu?=
 =?utf-8?B?ZVJFY2pqSi9DUFMyajRNd3c2TjdPaTdHOTJybHdrekhFWGtCemlHejNIaElK?=
 =?utf-8?B?RitIZTVlWkx6VllWMndVeXRqdHdTNmRNMVEwbHFWUmV0N3hkc2JDcm4vWDNW?=
 =?utf-8?B?b25xbHNpRlpZendqQWZHdXlpS1lFMlpDQ2FvblV2b1d3UXBMNmYxWEQrRW9E?=
 =?utf-8?B?ZXl6d1YzaU1aTTR6Mi8rR0hzc2V3M1U1dE52WC9JUU1LK21IQ09vQjB0L2hM?=
 =?utf-8?B?WjRTRkdiNlArZ1lFY2FOQ3NpQnFyNVRmdjBYamxyZ284b0s4Wkc5RmlseVNU?=
 =?utf-8?B?WkRUWndjenAzdm1DNEIrc2NhcTl0YnNhcmNvMllNNTVMVys5YVpUMXRoTVB5?=
 =?utf-8?B?MmRXVDBGeDV2ZFBTeGlWWTRxZXBKQWo0dDNKT21zYVh0ZEZVNjI5NnNwcmR0?=
 =?utf-8?B?QnZLVm81V0hiZ2ZWVUFJdUZNTmZLWFFGV0ZyWktQSDcrSk5SaWYveU1uV1dG?=
 =?utf-8?B?VkU2amQ0azZrSVl4U0RFbmtIMktlQ0tNMHV6Z0s2SEZLK0VUZlAvdWRlZ25B?=
 =?utf-8?B?U0liSnFDUEhWUnl1TWc2Mit1SGlTN2tDUzBoQml5ZUlDcXNNU3V0Wkt3bjZN?=
 =?utf-8?B?bU1nWXFTbHBSeDhVS2pVeDQxdUNsQVFjNXZZbWNsSU9BOGQya1ozcG5iTGNX?=
 =?utf-8?B?akl0VXFjRWN3Y1BURm9yTTRsTVR0RTVGUldFODYySUtzZFV0aWFDK29pZ0li?=
 =?utf-8?B?NUhQSE1mdHI5ZU5vdmtXZnVMaGNlaUo3NldUeGlncndjN2s3Nll0UVdzYWlB?=
 =?utf-8?B?QjZZdUcvNUdYalZJcklwQzQxczhISHVFZEhLcmdyQXk2RGxKdngxTzM5Yk1P?=
 =?utf-8?B?Nk9pSG5UdldLV0hlTTQyRmdKYkRBZko3Q1hGUVNaZjNaVy9ReVdDVUlHZzZT?=
 =?utf-8?B?aDhxL1Z1TktKNStOV1pnSkV2RWVZS2VvQk5zSzNYdDFHRUV3RFFtMGZveU5i?=
 =?utf-8?B?cytiVnowMmUya09WZnVPSTA3RGNxZEVXOUdvV0FiWmErKzBUYzhFRlBCRFlx?=
 =?utf-8?B?eVVwKzg1d0NjYUJRazhacFVhZDBvYmhSUWJMNk1jVzkxKzg2bDBiOVRCeTAv?=
 =?utf-8?B?eGdSLzhTYVRCV1RwMFM4bGVZZURrMzZDc1RpSHRxUDV3eXlYUGt4SFV3STRL?=
 =?utf-8?B?QlJtNUhzdWdBb3V3aXAxczFJOVVVU0wzL2Q5enpoZjVXWVBaR1NNSy95RWxY?=
 =?utf-8?B?bkNrMXZyeXBPV1Avc2Zja2hzZDJEQ0dETFFZRXJ1dlh6dkRkTG5ybzFKV3Ni?=
 =?utf-8?Q?XDRyDWkRBhe2+cd0=3D?=
X-Exchange-RoutingPolicyChecked: e/4OUvXxi9K7p9ftbAHYk2iXU3scdkRSSVZB8o5MIfddeI4ApWZF8Ss1gBJnEbYTpqN25Zrr5bQTTE3qYWnPcXhJZNRBqFZBpHjW0WTFXlfLq9DK4UGc6niez8vlDiF6fYQsq0cQzl8EcPv5zWs6qRhOgxWlWW4cXgLUcfTGaUpHv0TnuAAwboG1kCyccL3YdFkVXe/IRGcdqzLGjePKpKWhwLh08M4PlUX00/Qok00FaQM8d6p1jfxUyz47EHTw51HHWSM8PnVvI77xX239y2GmpGAco6g1XXPRls7GitXPR/FegWA5m0oAW3l6vxBygMLN1vvnffX/SK1Zua3IyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85747429-4045-4b1c-a562-08df1af36819
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:54:43.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEJU43YO4CUDivTa7nqAUNve+Ba16IqLJj/NXnzKUBb8PWp8JV/jynLGsGONDUBjwm8ff4IHxvVWwK8yjTOFHCWwBS6JLANlwGrJQIFiiD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6730
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

On Fri, Sep 25, 2026 at 12:13:41PM +0200, David Marchand wrote:
> On Thu, 24 Sept 2026 at 16:13, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > When the DPDK build is configured to use stdatomics rather than compiler
> > builtin atomics, the C++ chkincs builds were failing
> >
> > In file included from buildtools/chkincs/staging/generic/rte_atomic.h:18,
> >                  from /home/morten/upstreaming/dpdk-stack-std/lib/eal/x86/include/rte_atomic.h:12,
> >                  from buildtools/chkincs/chkincs-cpp.p/rte_atomic.cpp:1:
> > buildtools/chkincs/staging/rte_stdatomic.h:30:9: error: ‘memory_order’ does not name a type
> >    30 | typedef memory_order rte_memory_order;
> >       |         ^~~~~~~~~~~~
> >
> > The cause is differences in atomics in C (C11) and C++ (e.g. C++17 as
> > supported by current GCC). As explained by AI analysis:
> >
> > " _Atomic(T) is a C11 feature. In C++ mode, GCC 15 does not support it as
> >  a type specifier, and <stdatomic.h> in C++17 doesn't expose
> >  memory_order in the global namespace (that's only in C++23). DPDK
> >  headers also use _Atomic in anonymous unions and under extern "C",
> >  which are incompatible with C++'s std::atomic<T> mapping."
> >
> > To fix this in a resilient manner we need to go from two blocks in
> > rte_atomic.h to three. We have the existing non-standard/builtin
> > atomics path, but the standard atomic path now needs to be split into C
> > compatible and C++ compatible blocks. This fixes the build issues with
> > C++ while keeping existing C builds unchanged.
> >
> > Bugzilla ID: 1985
> > Fixes: 5c381a3587d1 ("eal: provide stdatomic API")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Probably worth squashing this in (I tested in GHA):
> 
> $ git diff
> diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> index e0b914a142..b09d72dd87 100755
> --- a/.ci/linux-build.sh
> +++ b/.ci/linux-build.sh
> @@ -111,13 +111,12 @@ OPTS="$OPTS -Dplatform=generic"
>  OPTS="$OPTS -Ddefault_library=$DEF_LIB"
>  if [ "$STDATOMIC" = "true" ]; then
>      OPTS="$OPTS -Denable_stdatomic=true"
> +fi
> +OPTS="$OPTS -Dcheck_includes=true"
> +if [ "${CC%%clang}" != "$CC" ]; then
> +    export CXX=clang++
>  else
> -    OPTS="$OPTS -Dcheck_includes=true"
> -    if [ "${CC%%clang}" != "$CC" ]; then
> -        export CXX=clang++
> -    else
> -        export CXX=g++
> -    fi
> +    export CXX=g++
>  fi
>  if [ "$MINI" = "true" ]; then
>      OPTS="$OPTS -Denable_drivers=net/null"
> 
> 
> Compilation passes fine in my env and GHA.
> 
Sure. Shall I do a respin to include that?

/Bruce
