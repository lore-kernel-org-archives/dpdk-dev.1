Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A8F8A16B
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 12:11:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7809240297;
	Thu, 16 Apr 2026 14:10:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1B0CA40144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 14:10:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776341458; x=1807877458;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZwrN6MbV1/c5SPimTOxePbX2ZW2MajHWrdGJs8PpmP0=;
 b=Vcbf1l8gf9rR0ZwnvjXLhGRXnLa01QEXLRxeS7ap0PjxvJ5zdXjMrHyO
 n9iMW1kbeoevolJj1gse+J6z5E+Fs3tsg9BiAqbAZk5aJgBKHKe0JPcfK
 pVYeaWLowVw/luWQ+7eb8c1r6K6upUCmjt9kByYy5cX7TLH5apaBB4Mza
 bsZ6UAPdZpZdq7W1MNHsr3l+kbnvcgvAiHQZ7kdfdILoSsGYhpoczhuY/
 EUelvMojMnCQgpjqrQmJL0pNWpGL+hNMguZv2gFV6oVsJTs46IWp901Kj
 Nlf0KIz91U/pVMSLhLobRU4ye2HIjw7ERPMZhsA+8PaieudEXetG0YZDD Q==;
X-CSE-ConnectionGUID: qvzaMAGSQTi0IJ27IA+e/A==
X-CSE-MsgGUID: I8iv5eAaRASBSdQXhetmfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77453173"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="77453173"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 05:10:57 -0700
X-CSE-ConnectionGUID: V+ApzwHnTluoVzLhM6UO3g==
X-CSE-MsgGUID: V6Rhc+erRIujEr0qwAceZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="229696165"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 05:10:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 05:10:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 05:10:56 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 05:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVBtCDf0kz6TRT9cybl5ZF5CdnpPTMnp5Rof6CIjQiFGDvDp2uMLIktbHK/6PORltuzLlmMMpA5LrkxFbm1D6ZTslPQzjYxpqjO/6tugGNI1VyMdJPOTAyj1/gSoVlo65SO5cWDXqhbybAkK/hxrv8KO03PB2Tz2xkW1/c1s/wPJ5znA3JUjrOsixIFLntMyjcJ96T1PEkYxrbzGZpSMRTlCadVQWXGvhbUi4peaUGjTg9aMWhNenZ1rL0r7pk9KCE+wis35LoY9/HgVTZNnxdGg+Fc+T701R/JT7f7rlKQqSl5lvBXeR3NlymF9D8cY+TVOZ/0wgH2oRCLYNHoveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUu6bu98WlPddvOQ0QP74qqCYoaqMdjxyAshYJKxZoA=;
 b=LTySibXTWFZeoa0jUmSA/PSLWE3ZN/1p2VKiHNTX2sNyfsMY/vox+KpUgUp+1q4gCe17xJ2CHs3lYsR2PY621lp8D6Q6U75iZDu8SMqk3xZGyKcqSfBSm6+DtzcyrygkD3fVsEYPky9eeJGOXXYvW+u/oZB+ZnrHWkRxaeOrIpqCk9yV09w4f02DdEbRKa7OKgavuxqdPHkyQxWOXCo/Gbr+jsysCUlqTULkOPf4P5LHHlAmgQXwt1dh1UYIB0l2LSo/DM1gUTMfCrMplIJNiCRcbdVvUNqo6iH9PajQZ4PM7BCiNxsCSUXP1/WSbM9hbFxy8RYZcA3LSQInEEiYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 12:10:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 12:10:52 +0000
Date: Thu, 16 Apr 2026 13:10:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v3] net/ice: fix L2TPv2 outer MAC in training packet
Message-ID: <aeDRxwSq305_elb6@bricha3-mobl1.ger.corp.intel.com>
References: <20260406081355.3241393-1-shaiq.wani@intel.com>
 <20260409074441.3424824-1-shaiq.wani@intel.com>
 <20260409074441.3424824-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409074441.3424824-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0209.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 081468b8-3723-4ef3-1bd8-08de9bb13465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: f5u9P0BVtohdie9ZY4Oc4Wd/k4lbtpX4UJd23ZY1fGM42lX+iiFa+P9pAzkYORrqbnRT2IkS5jtfECOF51YWs2hzqG8PMp3sWcacLNJWfAAYW4b4exirRSfRhVoPFjHQXCI/gKbze4NVXHaqHGlti78Vjem40D89U1eFOBYiLS8WZ9nwIxGuSF5cP933B3VmyghkXLh7zmgcPAzk0a1y4Xcf/NdbogM51L93KQYyooysOG5zLs1a/Htnhc3GKCtNwuxa/6DLsWOgEI4/FsiR9LBW6Pc7KpSa1KxBenaFczeQGzuRHSiDFnH5Hfy1Mo5seKOJPuePs1Exu8ZIzC7yOwnk6jtY6GGOHYhRkJIt+X5xZqVa5japxoZo3LrK93hxekuQGbmq9TNQQP2QBixj4hGbx8pnHathPxgyfLH1oJtzrmL14+hawGjzSjxYVjo6BnUZ1bG8EPScOLx1JYHg4A6tI7Yj1creaw2BIzV4iw0K1GgWHHbY39Beb2xWIH1ElxA3gfd3C3uXDhU2zkYGoWAvRTgt+5/Jy74JWNasqXP1w3gqMnpFxuJi3a31XSWNDA5l8mfGyzCxARhVIlKgSrl9WHdguFosWmWmyslvnpyb5MYmcxtjbaaWOOucpRgVwhuCED0ulNZOtMI7cO17C6JYbkBHUxqzl1tlu1lYJqgDvpd+XfBc2bK1cQm+l9/1HHSgFAnoM8i6YIL34laAcxnRMLy2ikeLWzuA4KbWZuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c203RFJvOXE1Wm1YdHJRWjc0NE1ja3NraFY2U1l2TFgrL3JoOUdYK0Nld0V5?=
 =?utf-8?B?R052ZzBoZ05lOEQxdmw1RDdVVVptdDd0WTNjQzVaSDFQdlVTeERyaTVmdEVa?=
 =?utf-8?B?NE83RmIyTlIxdG1teDYySUxBMG40a3gzUjJhcHprSTljSzF0dnROWGZkcHMy?=
 =?utf-8?B?OHlKazZHMXRTY3piZ2ZxR0hHa2h0dlJ0Um5nMENPUTVIMmhTd2wrcTFhLy9l?=
 =?utf-8?B?V0VHZU9taFc5b1phUVBUVzd2NFJlTFUzQ2FGMnBmSE5ENzVEZ2tTL2N1VGwx?=
 =?utf-8?B?SHBab0dmdXRlNVVXcUpOTlcrNTJEdFNIZUIyckIvVWFVTkdiamlmaHFQRFpL?=
 =?utf-8?B?QTg3Y1lvbEl2blJsdnh1eHFiZkI1OU94VFZqeSs0TUw0eVcvVEtHTzRjNzF2?=
 =?utf-8?B?Mk5DaGhzM1NZOVBKQjI0WnlLT2VFcGdGdnN1ZzdybzJNbFF0NWFGT1VYbEh5?=
 =?utf-8?B?cWhFSXFZa2EyZWI3SVpvRW9uOHUwb3EvTmdlMjdvVEg5V1c4TWVrUnJUcHJQ?=
 =?utf-8?B?NUcxdEQvWGVTb25URjZqTlA5bmZjdHpnbnpsNWRVODBicmc5bEw5d2hZMUIz?=
 =?utf-8?B?NGFZeWtVTUluZ0RmNHNqdHZob01xYWlyRm5qcjlhVmZ4WC9OdjhvSWJBUFA1?=
 =?utf-8?B?dUVvQ25Nbi9LZTd4cWpxT2lIZFB3UmRWdVRtTWNjVDR5TWhUbDBNRXo5UDBT?=
 =?utf-8?B?N3RyMHZPMXFWdjNXMXYzWnZTeG05M283Q2hBOVc5WjRzMkcvdHFqLzI3SnNJ?=
 =?utf-8?B?WkVyWEZtV1piU1M2SDlqWFBvVmpvL2pyVGRpSTRoU0lseWxNR0FWWkhoS0FR?=
 =?utf-8?B?dzVjZTZoMllDQ0NIWE5mRk9ldFFjZ1FXcXFXVFp6OUFja05mbHlWQUZkOWln?=
 =?utf-8?B?SVlCOEZveng2MEw2QkhFbFl6TXNmOGtQcW5BNEdydWx3TFRRSjVHbWJjYlcx?=
 =?utf-8?B?SzVqWDAvWkErcEFEbTAyRlhjSllHVzVPbXVrRWFmZ1lnT25wanl5RFJnSWk4?=
 =?utf-8?B?M0JWUFoxZ21OWEcvQ1lZbTVhN054SVJBTkJDMW92YjdCcXQ0NTBZSGxUbzgy?=
 =?utf-8?B?QkVzZXo1eThqVXRWV1dvci8rSG5Jc3BKS2JZQ2hCRWVaWXZ3QWplTGRyWmpY?=
 =?utf-8?B?REFSbTRRcVgzMytwRjNtaDRhNEpqWUh2OVNTd2FqNUFzaVVSRmZVZEdnU0NT?=
 =?utf-8?B?U0lucGpGcUw3RXJZelZjT3JDblNNdXh2aWRZUDU3WkZnNkllMUZ4dzFXcHFZ?=
 =?utf-8?B?OFNOQTNXbm0zc3ZIekx2U3hsYUM3WE8waWtKakxmaWVNcGpleGxkKy9kVzdO?=
 =?utf-8?B?dTF4ZkttaDh5UnIwTEEzQ3hwNEFYRDRyL09UNUJXOVRsTWJkOG1EN0hCeEZP?=
 =?utf-8?B?TXdwOFlNTXcvV2hLNlNwM051c3lva0k2WjFOckNNdG04MllzN3pxOWVJL0Ru?=
 =?utf-8?B?aEZiSDNiRGRvUFlEN0ZXNDZ6WWFaQmxkSURMR2xuU3NObHZ3dmtjZUs4cnh2?=
 =?utf-8?B?ZTMvOWZ2R08ycDlSK0lCdWIzR2NNSEFxQUE2cEZETWpSMjhBcTlEQUdDZngv?=
 =?utf-8?B?Y013N0tocHo5QVVkVHZPM3VDRmNyT1JuWFdiUm5va2pYVEZQbDNoS1lMMU9t?=
 =?utf-8?B?RmRzOS9mTHRXclczbnhQM2p2bnhBemQ4YkVFbG5kd0dsUXp1dlFVTXNPQkNO?=
 =?utf-8?B?QjhMdXREV1pVUkxNd0ZhV0M4Nkp4cUtxUU41Vll1cUdjcUhTVXh2Y3lkV3Jv?=
 =?utf-8?B?V1hheDJyZHNFcXBiWWVBQVVTMWR2Rll3cjBlTmpNK3lqMS9WL1c4TnBOUU4z?=
 =?utf-8?B?blZwejRrYnY0RXVBbHpNVGJ4eWdXT09YUndyb2ExQVU1ZGF4VHg2Ujd0NlFK?=
 =?utf-8?B?VjNZWmFheW5YOTBWV29Pd2RKOFROUVYvbEpRMWJRNDV6WFNML2hySGZqV3Vw?=
 =?utf-8?B?VXl2clQ2Tll5OURxMXZmWjRxZ21YNXg0NkhqNVVGaFRqaTRTYUZuSmxlQWp0?=
 =?utf-8?B?QzY4dlpIYVltRVJDS3R5LzJxUGJMVWZwMGpva0V1YWVvMTA5a3hqVjgyaDAr?=
 =?utf-8?B?TXAweFVTN2hKcmhidy9QYy9xcjJVVFBKZ1ZZNHowR0dJK1JlOW96d1dubHpE?=
 =?utf-8?B?T3dpV2h0b3BTSmtrNHAyZS9DYmpzOUlKWnNsNUdCTWVsWVdzWmp1NTc3NHZz?=
 =?utf-8?B?VHc0RWhKNVVucmFwZWZaK1dUdGUyeEtsMEJmVzZsM3k3QmFWR08yNkE0SFYx?=
 =?utf-8?B?U1RLdFdENWM2d0FveXlGelRYWUwxVmt0V3Rld1M3cDg2ZDgyTGNIS3NqZDFt?=
 =?utf-8?B?c1IwZjVZa2QzUFBhbXZ4TEdEUWUzWXJDMjBDV3R4bDlYRVkvcDY5WS9pM1F4?=
 =?utf-8?Q?7iUnG7ciyYUEIQ8M=3D?=
X-Exchange-RoutingPolicyChecked: uc0fWQhGtB3WYSWWIeZvlndIA99NmiG3NEXtJVKAjipOHqeRj58XW66GASLk9BDKJlqZNKWFP5zQgPJLcZ1AUwBIr3awB20bfzEBkg3SFnEW0GlDGlOiVeKWytBMWOyQFw//69+pTpP2m3R8yNZEmQg3HTuEGstWQXYnZeQIjbTyznpTCzTgM7mKbQtpVCrKdR/iR8ZtrRQ6N00nrajB6TSYxzWJMwiVGyrTdHiyEI/viX7rvQxi/fvQlHBIxzoBsG52H9iSp9TbshMkpWv1HMJnojCybCfnZZvH9Nq5yrP4UJ1UlGcRwzo0sTF4/QYm1n6aB3nQbWU83CqttgMi+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 081468b8-3723-4ef3-1bd8-08de9bb13465
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 12:10:52.5171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSSr2ahkmfb8s5V+TJ7r8CR4ioaUFswewIY58bUDZYyi37xeYST4VGf/YvlqWJTYIqtworaKxMQqRbEyu5AxUQhhEdjCs5naXMwZsDPgIpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
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

On Thu, Apr 09, 2026 at 01:14:41PM +0530, Shaiq Wani wrote:
> In ice_fdir_get_gen_prgm_pkt() there are two pointers into the
> training-packet buffer:
> 
> pkt  – start of the full packet (outer Ethernet header, offset 0)
> loc  – start of the current protocol segment; equals pkt for
>        non-tunnel flows but points past the tunnel header for
>        tunnel flows
> 
> The L2TPv2 cases wrote the outer source and destination MAC addresses
> through loc.  For non-tunnel L2TPv2, loc == pkt so this happened to
> work, but it is semantically wrong: outer Ethernet fields must always
> be written relative to pkt so the code remains correct regardless of
> the tunnel/non-tunnel path taken.
> 
> Replace loc with pkt in the four L2TPv2 MAC-insertion case blocks
> (IPv4 control, IPv4 data/PPP, IPv6 control, IPv6 data/PPP)
> 
> Fixes: bf662653976e ("net/ice/base: support L2TPv2 flow rule")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> v3:
> - Fixed checkpatch issue.
> - Moved comment after all declarations.
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

