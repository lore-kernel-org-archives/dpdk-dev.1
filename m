Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A1606A329
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kNUptndD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB1A40E09;
	Thu,  5 Nov 2026 18:40:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 7821B40E01;
 Thu,  5 Nov 2026 18:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793900423; x=1825436423;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mFUOS3lcahMSbFZ2I6LKt+fN14mrtieQ9t/dipNgg90=;
 b=kNUptndDFFpVdQXE9Ghvsv0EKTJMPZZfNaGUxzLf+aD7Mv5V8YjcSqdo
 trJGz/ePZ18q0F9QmwZ8er6xt/QnetwE1qf0WyjljVVukqSR4ZB2xtcLp
 qXp3WKn5h0ziWA+pfd/K3Z0mriZQkoaDdbQkhTX4zirvtCjZ4BK9z6fzU
 QfEUA8SiJhVS1rzUC8bR+2cuZFw5wPPQwitoqKlweGPuQW7ZvzJf4dkp0
 YxVidD4iTFkEgjYNhCY03U2aB9tv09Zf3Dy31SmZc3Kptp+12iQK0SzAB
 Ju+3z+zEhQ1/I1e04phjX4OC+K1UOAyx+OmKM25uz5mohUSV4fr2GDV6z g==;
X-CSE-ConnectionGUID: 0vHb/uP8RKG06FYafcRueg==
X-CSE-MsgGUID: JHYFMQWpRrOFMmPcKQzrmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2571298"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2571298"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 09:40:08 -0800
X-CSE-ConnectionGUID: JWba1HzaSz+RHYJizbyo1Q==
X-CSE-MsgGUID: 08tTCuRhQFOcwxsj0zGBsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7635683"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 09:40:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:40:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 09:40:08 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:40:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnZvBjBBw2gPWMSvJmTkgGVtQH6PGuvbbVYQGVQ1EItKEl4NENE0mOW1Kn9LUtp4ETydcZfkweTlnmLDS6m0loATtKJ2Es7ijJwxeES5PIdQ9PiJRf96PzlRgQT+KgPQzTHNM3aX0PEeI81omOBAQzxTkS/cZRnifT6NbsRR1aGXslyC29V763hgTkGlXrif134/dUcPCBZbS4JrsUb2rzDzEQZ8UaOzoUhk+HpAxA3aVTTT2/XJz+wy5SgXqH7sF5T1ZrO4N8T10V/dX/g2scyBPXNoI3/Lvf7D3vGRk/NW6TRbk1PbxdCBXPXFeVX4eK+ITDhY1+RjEIUAzEgFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOD33fvZLR1eGEqaEwIl4EZJIRGx90MjUhXEg3pPXKc=;
 b=mxGkHttI0zJB81CqEms/i3z11v5PVxPvWTHel159+nXByp44av2uC8kNbxJHnoEX/1csu4rzOyl4sMPEeN9ikHys1rq95KJ9JtrpCHHjBghYWCcFB1apPmy5X6LO0+EiU+utjzjTWRGMEoYawRbUUxMlE05PTexE9TZMVhk2U2bgqCZfNUv7cyyjhy9IJhMMINp+eoFLEEb4nOkvuYbKJnT4Gi0jXUDFwojUnJelbZ7tyKExai6YtwvqlepltDooKqYK/U0XXxy3uAMrfozSi3IGq90yFvzCiQkLdTgZMof0fz+vCCosI6sxvJR0fg9ZF1uSsApmLGJTFBspa6LD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9444.namprd11.prod.outlook.com (2603:10b6:208:563::22)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:40:06 +0000
Received: from IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1]) by IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 17:40:03 +0000
Message-ID: <6857425e-6101-480c-ae4d-66b9c96f9e3a@intel.com>
Date: Thu, 5 Nov 2026 17:39:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fib6: fix overflow of tbl8 indexes
To: Robert Sanford <rsanford2@gmail.com>, <dev@dpdk.org>
CC: Robert Sanford <rsanford@akamai.com>, <stable@dpdk.org>
References: <5f260c1a-3f03-4e7d-aa38-15b8d6cdaeff@intel.com>
 <20261103004903.3616661-1-rsanford2@gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20261103004903.3616661-1-rsanford2@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To PH3PPFFA27DACA6.namprd11.prod.outlook.com
 (2603:10b6:518:1::d63)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9444:EE_|SJ2PR11MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 48933990-eb5a-44e8-2b95-08df3b63d24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|261028144727099003|11063799006|56012099006|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261022105027099003|261021123027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: DxLvlIW2ABBGnSaLw/VSMBSJS2yRR1tHC+VMLyb3DJGR/h0lamP+WlaJtknDE1zUN2gTYuFBr2fDvR8Hdlf0tHZoE6pu4uxQCutDkVXHNSRRkvErVfPmnOJRhvKsHeJFtRHPIMNC3hH5j61MRqrIjZSZ/rARuVocKrMdkH833EXJELjTInEZ0XLQOVrLLNjgFNls55aK+nww8tKlxtnfBW3znmBMUEzDSbuWXl50JFuXJNS+vbOdBwJ0/2kbNvmzPLX7rBgN+lQZbHDznVAsaKXCCh8NGoba9MUfgGR1UTpGDVecBrrw34YzSnwJbuVtXsD/TYC09OpOt3A61hu7TjeEaYQJT25l4q6CZYBmhV/7TBsdDbi15nBDV3Nlm7at6td4JTtjq+ST6CQVbm+E1QFT3fwzLN/sEhZoAgwFIsN1/efiXceqTVE90Pw2rF94DIK4K+EUjt8zNvhf4GGD8XDyUA6c1lRSwuaOwDmJdlIxEHtcd1Xii5MFlfvHmuk7PGpCTVzG4EMdGTDdj4UEclQWXe54+DHn2lADtfUa2vfUL1nMqXeMuO7nwL4h73lZwdmY1OEV1k/RTihI6wUzeRsOIbSEyvLGPR0oYVLLbnmM0dD5qTSSndI0WTe2kDwI6DzlKzlIfB8+A/71xdakNoezJf6zNIc3kLAlwOtAUjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9444.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261028144727099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261022105027099003)(261021123027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9vMFE0STkrZEZxK0dFZ2YxYXJOVlZjZko4NGc0R0tFSkxOL2Q1MEd0WGIr?=
 =?utf-8?B?dnhjNW1xR3B4b2FPV0hOdVczSFI2dGlySS9DOHlOSzgyb0wyRUhvdGM4UnMx?=
 =?utf-8?B?RUJTdThqbk5PVFFxL01Rc2pPZE84YmNVV2s0VjJadVl6YjVQN1ozOHg3SGpn?=
 =?utf-8?B?TTJPWmpwQllKekdmVHE0TW8rUHJ4YlRyZWFQdXpRUmhTWW5YQmdiVTNMdk1U?=
 =?utf-8?B?ODY5cDRhS3A0ZUJLdzYrL2FubVVUSm5kTGlldEN5Q1hGMjc3bTIwODhsZTRp?=
 =?utf-8?B?T3NJRWRYNFNpSDA4OEZYaitXUkl0dUR2ZlN0L09XUzB1RGNnOVJWU3VBOUdP?=
 =?utf-8?B?WXR5dGtxNTJ1eU4ra2hYT0kwK2EzQW5uQkJiWDFnQVkyVWw4Tkl1REJmek5E?=
 =?utf-8?B?ckdoblhTSXUvWWFQc2hGNUIzbExGNzNXT1RQT0NzWmNoR1Vlb1labWpCektR?=
 =?utf-8?B?Z0c4MVpOU1RvNkppY1puV2ZCenBzYjIrVWVKa0diYjhVYWtQRDRjR0hZbnVu?=
 =?utf-8?B?UXFHR2pkVnlONWZiVTJXa3hyTkI2QllmMzBKTVRyOTYrenJhT0VGbGpiZVZE?=
 =?utf-8?B?N0laY1NRY0MycEp3Z2FtR0xJWGtTRGZWVlBDZTYySkErVjA5d1NEeVM5T1la?=
 =?utf-8?B?dXFRU21XWHB4d0VZK216amlUQWFuZlI3ODY3Q3VtWVFyNmlWT0taVmxNRGRP?=
 =?utf-8?B?TlpaK2d2Y2ttTnhybllHQVhqUjdYNWgyQjZNcG5pUVBYZ293ZHJBa2wwMkN0?=
 =?utf-8?B?NEp2WWZFN0JTaFZ2SGZVNEJBWXFpdTIrYnFsbm11MFJMUTJweXcvUXIyd01C?=
 =?utf-8?B?cGJJVTlrT2dHV2RESnM2ZkVmUC9LTnNRekppY0RoZXNXaXdqMndXbFA5Qk13?=
 =?utf-8?B?MW4vWkh4NGVodzNIckZSY2JPSklPUkJidEdqbW9KUGtlb0duaXcrN1l5TDBy?=
 =?utf-8?B?UENpNEsyM0R2OVNpb0sxZUlMMHNpMDlLWW1wNERLUmNmK2o0K05jWGpFanNa?=
 =?utf-8?B?RHRBQlRiVTlMcnY5MzJEMnFMM1hDT3REamdVeUdsOHdGdVE2enF1a2hKeEMv?=
 =?utf-8?B?QjAyQVZGazBxK3cwYk9JTHpZeHkybFZWUDA0MEpzUlFoRWVXN245WWJNNk5i?=
 =?utf-8?B?R0M4bHhYZG0xNkpDWjlvNG0vWEdJTDgwMkpiNkRCOWs0eVA3ZENHL2dIc2tN?=
 =?utf-8?B?KzMydnM0NHNkZmp4SEpreXRXdzlVYzhIUUlJSEhwSGdFc3AwNzNSN1paZlp4?=
 =?utf-8?B?dXNOM204eHNDMXpVWXJsaC9RcHJXTVV3RFFPd3N4aE1kd1pnK1U0UWNVazZS?=
 =?utf-8?B?L3RrdnFucHdjaXVMcVNvZkhlWm5UVk1FOFdBeW1SV2w0N0x5bWVYMWpoQlEy?=
 =?utf-8?B?MlUrWU0yTUU3VUFYbUppdkl1bWE4QWxqcnpuMnlLZFFmZENpZHlwTDluSnZm?=
 =?utf-8?B?UFhmb2hKWVhtajFpaEhtdnVaV1BkTlMrL0VWM0V6b0NtSGRvdlRVM3VkU1B1?=
 =?utf-8?B?ejJLaXhKMkdtVHdBMVBTMkRJc1g2VTYxbFNSY2M3WWR5Z01sbVdSenROSXh5?=
 =?utf-8?B?WG9LQUFmQ29DVi9vbDFxaEJ5cHB4cnBCYmgzK0wxbUZDSGR0eGlLeFFkcXds?=
 =?utf-8?B?ZmtoZXNuRHVETXBjTmlyN0xha05tdC92c2tqQTBPeXowa21meUZoMXZqcU8x?=
 =?utf-8?B?QkY0RWI4ZTVYekxQWm05U042YUJ5emlCbnlwR3VwVVFQd0ovNGRiVVFRampX?=
 =?utf-8?B?RkVVYUxiOVY2YVJ4R3BiYUJpbkwwTERocDA5RlRxVG1tenFWTGFGODQ4SVMr?=
 =?utf-8?B?Sm56ODRMVUxLVTJ6L2kyQUNNUmdWdTNqckY5a1JWZjFRcnZPdzdXcjdjRFBH?=
 =?utf-8?B?bnBPNXBuRFJXY0hRYWM1R1gyN0luYjJlYmZmQk9yNXB1QVU4ODFxSldoS3R1?=
 =?utf-8?B?bjgzSURiUlFNN0ZrQ0FyQWc3bEI2ZDIvTFpKcjJVcEJIVStYakEyWTIrOSsx?=
 =?utf-8?B?ODBmeWhGNndmaC92R3ZrclZvRjJsWmtwb3BPRnFISlRFZ3RjdXJGQlFFamRJ?=
 =?utf-8?B?VUZtQnVZVGlHbXEwcWgxVjNaYldUZmdlWWNCalE5N2MybFlBeGdZOTFVS2Mw?=
 =?utf-8?B?NUpNZkN6Y1JBcEhIQmpLRmNtZ3pFSHMwYWxZOElldHpOeEQzSHErc0U1QTJJ?=
 =?utf-8?B?RFRjaGE4dVlaQU53VjdZVFJHbHpwa3hBdnlLS3lOeFFoZ0syN3htOTMvZzI1?=
 =?utf-8?B?Tm01U0g2TDR0VWVrY3dNNXdHenlEbjRIVnhUa0tQUVIrTDFpNlR5Q24yb3Rr?=
 =?utf-8?B?T0M5bzdmOFZQZFpOcWZRTjFVUGx2cEh6OHNZT1djWC9UT3NIcFFFVURpTHhx?=
 =?utf-8?Q?7t/HiwjuGfyUycrI=3D?=
X-Exchange-RoutingPolicyChecked: K1QC3OOs8huYS4w4XvwRXfx7XwQlNKalEYqakINW7Sx+yl4PmyRgKH9qFhomueroBcB6GhAaqwQopBIyeGWPHgBQ1OS8IIGy77yWvsqjdyHnqcO5/aEyFHO93Xw2/k47Zb8bvr/joXjxyYXMYyIQg6lZScFrnACERZESBlP+RVKUNVTlEMZt0wuGuvGsjngNyMuauaLpuHQoZeppcKjlSWwgho/HST6DDyiC/k8b+/e52ufrFk4rZndMWpGPPKXX83gNAqRmZ9QrmwHkAVMeWivJ4f9sQQPTt+LcI/umZCv3nxEyraSIKxeokssHxZRbR9tc3Vs9aBuEM6cWq6XkLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48933990-eb5a-44e8-2b95-08df3b63d24b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFFA27DACA6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:40:03.9300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK1lAoZYDLHiLE9JxmAAsQT05jK2vMH96OiW+Ks5vbbPz5+5yQNd4VI4QHOzL4+Jp7NRAjeGuHUoXxvgTn7P5zaZ9iprZqs1UKE8yWbu5QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 11/3/2026 12:49 AM, Robert Sanford wrote:
> From: Robert Sanford <rsanford@akamai.com>
>
> The trie keeps the index of an entry in the tbl8 array, the tbl8 group
> number times 256 plus one address byte, in 32-bit variables in several
> places. This breaks large tables in two steps.
>
> In build_common_root(), the index returned by get_idx() was stored in
> an int. Once the tbl8 group number reaches 2^23, the value goes negative
> and is sign-extended when converted to the uint64_t index passed to
> get_tbl_p_by_idx(), which yields a bogus table pointer. With random /128
> routes and 4-byte next hops, adding routes crashes with SIGSEGV in
> install_to_dp() after about 640,000 routes.
>
>  From tbl8 group 2^24 on, the index no longer fits in 32 bits:
> get_idx() computes it in 64 bits but returns a uint32_t, and
> get_tbl_val_by_idx() and get_tbl_pos() take a uint32_t. The truncated
> index points 2^24 groups too low, so routes are written into the wrong
> tbl8 group and the add still returns 0. In a test with 1,360,000 random
> /128 routes (17.6M tbl8 groups), every route added after tbl8 group 2^24
> was allocated returned the default next hop on lookup, and deleting all
> routes left 853,337 tbl8 groups allocated.
>
> Use uint64_t for the tbl8 entry indexes in get_idx(),
> build_common_root(), install_to_dp(), get_tbl_val_by_idx(),
> get_tbl_pos() and get_psd_idx(). Keep a separate signed tbl8_idx for
> the tbl8_alloc() result, which is negative on error, and cast it to
> uint64_t before shifting it left, in build_common_root() and in
> write_edge(). The shift was done in int, which can overflow before the
> result is widened.
>
> The tbl8 group number itself stays an int, as returned by tbl8_alloc().
> trie_create() already limits num_tbl8 to 2^31 - 1 with 4-byte next
> hops, and to 2^15 - 1 with 2-byte next hops, which cannot reach either
> problem above.
>
> With this change, the same test passes: every lookup returns the right
> next hop, and no tbl8 group is left after deleting all routes.
>
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Cc: stable@dpdk.org
>
> Signed-off-by: Robert Sanford <rsanford@akamai.com>
> ---
> v3:
> - Also widen the indexes in get_idx(), get_tbl_val_by_idx(),
>    get_tbl_pos(), get_psd_idx() and install_to_dp(), so tables with
>    2^24 or more tbl8 groups work too (suggested by Vladimir Medvedkin).
> - Change the title, since the fix now covers more than the sign conversion.
> - Rebase on 26.11-rc2.
> v2: use a 12-character sha in the Fixes tag.
>
>   lib/fib/trie.c | 23 ++++++++++++-----------
>   lib/fib/trie.h |  8 ++++----
>   2 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/lib/fib/trie.c b/lib/fib/trie.c
> index 9ede1a5bf7..4346789972 100644
> --- a/lib/fib/trie.c
> +++ b/lib/fib/trie.c
> @@ -257,8 +257,8 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
>   }
>   
>   #define BYTE_SIZE	8
> -static inline uint32_t
> -get_idx(const struct rte_ipv6_addr *ip, uint32_t prev_idx, int bytes, int first_byte)
> +static inline uint64_t
> +get_idx(const struct rte_ipv6_addr *ip, uint64_t prev_idx, int bytes, int first_byte)
>   {
>   	int i;
>   	uint32_t idx = 0;
> @@ -319,7 +319,8 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
>   	void *tbl_ptr = NULL;
>   	uint64_t *cur_tbl;
>   	uint64_t val;
> -	int i, j, idx, prev_idx = 0;
> +	uint64_t idx, prev_idx = 0;
> +	int i, j, tbl8_idx;
>   
>   	cur_tbl = dp->tbl24;
>   	for (i = 3, j = 0; i <= common_bytes; i++) {
> @@ -327,12 +328,12 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
>   		val = get_tbl_val_by_idx(cur_tbl, idx, dp->nh_sz);
>   		tbl_ptr = get_tbl_p_by_idx(cur_tbl, idx, dp->nh_sz);
>   		if ((val & TRIE_EXT_ENT) != TRIE_EXT_ENT) {
> -			idx = tbl8_alloc(dp, val);
> -			if (unlikely(idx < 0))
> -				return idx;
> -			write_to_dp(tbl_ptr, (idx << 1) |
> +			tbl8_idx = tbl8_alloc(dp, val);
> +			if (unlikely(tbl8_idx < 0))
> +				return tbl8_idx;
> +			write_to_dp(tbl_ptr, ((uint64_t)tbl8_idx << 1) |
>   				TRIE_EXT_ENT, dp->nh_sz, 1);
> -			prev_idx = idx;
> +			prev_idx = (uint64_t)tbl8_idx;
>   		} else
>   			prev_idx = val >> 1;
>   
> @@ -361,7 +362,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
>   			tbl8_idx = tbl8_alloc(dp, val);
>   			if (tbl8_idx < 0)
>   				return tbl8_idx;
> -			val = (tbl8_idx << 1)|TRIE_EXT_ENT;
> +			val = ((uint64_t)tbl8_idx << 1) | TRIE_EXT_ENT;
>   		}
>   		p = get_tbl_p_by_idx(dp->tbl8, (tbl8_idx *
>   			TRIE_TBL8_GRP_NUM_ENT) + *ip_part, dp->nh_sz);
> @@ -448,8 +449,8 @@ install_to_dp(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ledge,
>   	uint8_t first_byte_idx = (common_bytes < 3) ? 0 : common_bytes;
>   	uint8_t first_idx_len = (common_bytes < 3) ? 3 : 1;
>   
> -	uint32_t left_idx = get_idx(ledge, 0, first_idx_len, first_byte_idx);
> -	uint32_t right_idx = get_idx(&redge, 0, first_idx_len, first_byte_idx);
> +	uint64_t left_idx = get_idx(ledge, 0, first_idx_len, first_byte_idx);
> +	uint64_t right_idx = get_idx(&redge, 0, first_idx_len, first_byte_idx);
>   
>   	ent = get_tbl_p_by_idx(common_root_tbl, left_idx, dp->nh_sz);
>   	ret = write_edge(dp, &ledge->a[first_tbl8_byte + !(common_bytes < 3)],
> diff --git a/lib/fib/trie.h b/lib/fib/trie.h
> index c34cc2c057..e0f53e0c47 100644
> --- a/lib/fib/trie.h
> +++ b/lib/fib/trie.h
> @@ -80,19 +80,19 @@ lookup_msk(uint8_t nh_sz)
>   }
>   
>   static inline uint8_t
> -get_psd_idx(uint32_t val, uint8_t nh_sz)
> +get_psd_idx(uint64_t val, uint8_t nh_sz)
>   {
>   	return val & ((1 << (3 - nh_sz)) - 1);
>   }
>   
> -static inline uint32_t
> -get_tbl_pos(uint32_t val, uint8_t nh_sz)
> +static inline uint64_t
> +get_tbl_pos(uint64_t val, uint8_t nh_sz)
>   {
>   	return val >> (3 - nh_sz);
>   }
>   
>   static inline uint64_t
> -get_tbl_val_by_idx(uint64_t *tbl, uint32_t idx, uint8_t nh_sz)
> +get_tbl_val_by_idx(uint64_t *tbl, uint64_t idx, uint8_t nh_sz)
>   {
>   	return ((tbl[get_tbl_pos(idx, nh_sz)] >> (get_psd_idx(idx, nh_sz) *
>   		bits_in_nh(nh_sz))) & lookup_msk(nh_sz));

-- 
Regards,
Vladimir

