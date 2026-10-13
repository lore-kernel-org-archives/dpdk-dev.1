Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5FECC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:02:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E839140279;
	Tue, 13 Oct 2026 17:02:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 00A9240274
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791903725; x=1823439725;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6QbKYAfnzhrrt7+7lO1XVaun4bxfSf3VJ/wSfTBX27s=;
 b=eqvkBWVqOJUS8ewCeJxuTIUzdkJ/UEImwdK3Sye4Lq05j93jl4Kt0nnl
 Pxglb2JxZfMqiRdXcly0WTV4qy8yjB3tzqn3nYU4UUdDoOBYdizcsHCzy
 ZOhx8tYvWZutI2o9sBjBm0YBtcL8eCL2eAu6pWafrAMqMKjwMVP0DYqDk
 U8lO/5To1pVIGv71uRCJJTbW+njVXAkx3aQiUDP6rtNb5HkDLvCB2FSI6
 oWqpPpKWVmjabKqKE/34IKLbNLDA7i02l1tUQDubGFKi4cWohmpwsj8NQ
 KZNgZX/gxKDIPMLH/eU3ppWmZgyIQoBh5fM0nMEuUdrOoT/BuS90iH4hh Q==;
X-CSE-ConnectionGUID: yHS3QzAfTJeUuAN/8NxFIQ==
X-CSE-MsgGUID: wSqfr5irSnyeKV9Xanpnig==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="639583"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="639583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 08:01:52 -0700
X-CSE-ConnectionGUID: o+kAtGzKTd+RKVRJFtg/KA==
X-CSE-MsgGUID: 5cErDy/cSbuJfAyj1iTxcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1289755"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 08:01:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 08:01:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 08:01:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 08:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvCbdarowePlNbtPd4GHlk7SzeYQVxv2DT5NN/SCpZWkK5pmQmK8SI/H46e9O+PwLMkc7lycgt1iIoq/1R3gwuwRme5r9aWoSqtDl2/w10rh57Puri00FbpXCSRMHtk4FJXFqL9Lnwv5nQn7Hv+mQBFxn93T2Ct9aLrUbuhqJH+WLMJf7tGq6jJK3k8P6Zc6zLgCpcTuzj0fdh9pG2A5RATQSoA8R+6g9N+3jWdCshD2knn0KVMnxbRsxMmscvJ2kq9KdcLsJngVdzEavZKdEun/4w6Px2PiZVR/FNJQ45syugaCrlyKY4/ZVmWdaFvEY0rMULvjZOen0+BgLH7voQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcSsQ6HfL2AZqMbdl0Iu1tZ3S+zTOFvaWTioq2aSpy4=;
 b=Rv0CO/gUnqayNrPDVNRdRR6PpWWFqdy+7qKxnKClYAX71lom9Y9zCobZDXtfla4LWq66f7BPyYYkU8uLod1dGZNjN7n9xQ8DU+uQr5kYs+1zNBesLPbNZyrtxfSX8CHXD/FttghCOoMMLT0rL50xMEuh226d1WgA4lfOIAJuCRCrA2HPDxX4Inaupk2rWcfjesmJ8qpuGCw1KhXZPU7ycjmmFi2mltOL4DHBA2wk1v7El1nLXZ4BVfhdyd1knanHeVpk78Oohpsu7XUa+0whw+PpK60VnszAIiqzkedbTInRMwUQCdcUNsNfBdY6BgP919MoYhFSxlsNslc2z1vdtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB5798.namprd11.prod.outlook.com (2603:10b6:303:185::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Tue, 13 Oct
 2026 15:01:24 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 15:01:24 +0000
Date: Tue, 13 Oct 2026 16:01:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v7 19/25] net/i40e: add support for common flow parsing
Message-ID: <as5HvtPo1v5cHP5E@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1791892574.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
 <cb384c5494c00bd3d1b854dc6312f35c105750dd.1791892577.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb384c5494c00bd3d1b854dc6312f35c105750dd.1791892577.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0238.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::33) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f665764-1fb8-4c3f-6b81-08df293ad92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261009223027099003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dIHF+yYYz4YCIvaaPN8H5HVd2EOvubnSA2Jnw+dd8f4msE3ok6OUIwXYxoMUqxU07KoBC/46qKLE6q6FuAkL89bAKdIoVmlG0teeRw7WIb19+2z2D4dHc37x+qyqHUB4mYT+SMWJwFe0KAoCuRmrVMTVHeSGFNP56mA7LwDYBSXNgtR8TFpLDPtTyfZXfXuMvEHMhbPgWZfvnlTMLMzbpkokmguRgUbRVevOXcrHtoew0jzD1Xz0yVxolF+/EyE42I/AIZ89fIadQt3fzZhQwcSwToUalQN5SPSmBYUSMxzz/AOW9yZbyVXJm/NC3lTRwsVFwX/O0IfwOabCda9RXIOV4y2+l/DsH/l+WCGEoR5ei7JyXAFLONXxYqj6UUDHxYYP1Ky0Gza4DJYsZ+wvEtm69lfSrmvZ/Mtx570GomOPCyCz6zKjA+I8JBwMpicLREK7Udo7KG/1pmIhL86+X3KkPKArSHsQP6Ii1ixjmEEyMkVrKDaS6EUXYyGJC6bHdTsSlEKv6t9cQCYn0Vs463vzwop5Dti7CYfAGnPl00yRefvQZ5D4DeDw2fLlp286lu/OlDf9/RdJlnNcL4hKGuJTGh6U2rzQhFVRMb5agAK4P9wUZ0c6bvUFOt3ueQDaBF8RbOYR4GjJccCqmrqTcvm4Xffock76D+xxpyhe3OY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261009223027099003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9tdVg3NmCAQ+yVPi8CIW9c6ykF+1iHe9gMuVp6nXu2GPAxloSGqQFiIFl86s?=
 =?us-ascii?Q?DifDN6Xtte/5Tl16QUk6hUQsozmE1EWTphE7VmpZPicsiLSYYrOO5SZaD32M?=
 =?us-ascii?Q?dSAdnIgqj4DXP7R/HmOx6OnAOBClURih7H9vgTahQ5LM7hx02djvafuwZsUI?=
 =?us-ascii?Q?5Ap2RmDLOVEKMswfCzrcu7hKS0V3XdTtUuwLM7BRERf56VBwa2cSt4YkqS8u?=
 =?us-ascii?Q?F7AecXbMgYXbA99CLscs1QGo+IdCZ3Cj+K53hBCIOVrPtDoJmaOI+hswjkzJ?=
 =?us-ascii?Q?Q4lt/qw9w8kLmGxoa4lNIOuh5giubtkSTcZ3AAHX8OjV0olMy6LXkMCW/3Hx?=
 =?us-ascii?Q?X+Eci1qlvLXUcjQpEUmegcrisQjjedQFj732pbI8Tq+t8Nw9cE0Ixp4bGom2?=
 =?us-ascii?Q?aM1zgOXTQ3ngGDAJ5nCBIN4yM5tfFmOVYH3xn8gf0J2Rk9e8KbiGHLzR0MA9?=
 =?us-ascii?Q?DKE9V2tyTMWtcdJqw8AgfjeLQ76wB/pzs0uAi151ywYelXCRymuRwddHmKim?=
 =?us-ascii?Q?ErfH3+OgbpxBekB0/fXii/GHqVxeioY2COvHXCpYW2q8SROBX54/Dr40bFRd?=
 =?us-ascii?Q?03HJtORgZD9wVB7R/6p7xBYtBPkbjfGtuvECqOCV1qAzwK5tubDsa7uv5WCp?=
 =?us-ascii?Q?zrFrigBhpSYskKsN+mlX17eC0F4kw48Yd9ouxS8y9qx6bVBqaLh0f03zFW14?=
 =?us-ascii?Q?npQRXoEAy7loExpqbtDeRL2hCbWskv5pp1+jeuhhnru0ft1NKb9FfK/nC9WT?=
 =?us-ascii?Q?rZOyXjMNjhZFlgsKRhRHfHixJL0QIa53Y/jhPbIQro+y1zCq7xZAG8onm0VG?=
 =?us-ascii?Q?Ru3doqOfA69VmM9T/S4EUmH6iJ5/pHYrz8Y3I1SqDoemhd+qK74xF5FHBDi+?=
 =?us-ascii?Q?nYIFldoZotYTvinrAT0VrSBIHE21k4ZejrFxu41vVwcgh89YgissAS2Mx/dA?=
 =?us-ascii?Q?iUAAhABs/Un+qpBWflN1bDnckP7qeLaOc+W6S7qM/ZvoumYSTmOEXCdqMgv4?=
 =?us-ascii?Q?muFsmBcxLU2R9bOOB+XaZf6xbFxB/fMzpKOzzUcQvrLHcngw3J10EvGJER+L?=
 =?us-ascii?Q?ZdxRBX5xi5gVV+jBEBljPBU9GWfm/PEQiMZk3T+BFmnvO/26qepoWEF6Cn4i?=
 =?us-ascii?Q?Q4iNX5rdP6IVnxEBUPb+Bbw+IMUx0J0mO4EJgG+5zmQywH7TkEvi97oG3aQl?=
 =?us-ascii?Q?Fa3aZzF3ynNBU9X7B2yq8ngzYeKJ3GMdxw35R5+xTweZtLMkw5DCMkfGd/oV?=
 =?us-ascii?Q?lq6urHgXrXPmTnMgz33ge6W10t3lzEVzEaVGheBQXqFs0Wo+anPO2JuEF2q5?=
 =?us-ascii?Q?nA0WLazhT8Mtn2LtB/FX9agA5ia1luhaVedWdiYfrhQgTyKg1l08jqLmT7tA?=
 =?us-ascii?Q?72BEXOnQfyOYQ8VzDMgHkuYLiS/K4zRmYMQ0xqtvFERZnqJ95XWHFJQRdJv3?=
 =?us-ascii?Q?BwYwgJ6ovg9knZY8rEOLBVUPfEtkUMbTtFS0wFHDTdgbPJ5IewMhxVnLZ7VQ?=
 =?us-ascii?Q?fQuwuGUss0iPRrXmnISEfWg6pW9OyrvIDwh+G9rK56xcBvU1+LZuHF3W9QYM?=
 =?us-ascii?Q?J0YyAJHrRJEO5L10K5Ykao/LzgSyX1+UL+ynJCErswqKehW3ub7q5/0wG2sH?=
 =?us-ascii?Q?MiXqph8H7fuIv1t/bIg8nOxpvs5Z+IeDUZMe2F+9FQ0NB7oA0Y4oq7i6K1kM?=
 =?us-ascii?Q?0BcbDccayp6XucuYun8CZV8aJ7VdT7/K5rf/ZJM5IQh34jOCmL6rcvbNqW/i?=
 =?us-ascii?Q?k9oc4p1mbmFPCbme6oXOhkQ0gFJ4yKA=3D?=
X-Exchange-RoutingPolicyChecked: VJmQ8GV0jVKOQVUuxCg77o6R7zE+c8ivL24NE9dNDWE3pgiD/TuBVdHRwO/j8sMX8PVhlh2M5N4FTcXTADYA4+99dQ4QjX95art/mULWP9JAMDNtGmaern/AZaPGgyIfZDa6t5zoxjvenSRIniDe2LmVzYTGW0TPG0FUdgAl8B18u8T8c9WZUq3qRL4n4iCI0eoIhoAoKltKDeLv2p0TKwI/n2E9EgFiktd2UI3l/CIlLdcZIQxqcN2pq0zdmsakgF+bxwxA5EmXMMyo3RrgZy77wXthyt7rzWQzTFQQP3icNxyB8GqPoU6p0wMwiigeBX8LVb4zF78mRt/aW8u16g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f665764-1fb8-4c3f-6b81-08df293ad92a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:01:24.3213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/WICwNl8YNSabIOYclex+kFAtFP25m/8U/KayghgVTw3erQRHZd6+WBGqop9Kspy6y3Mb+lSvEPkQkhR0SwUpNnT8W0nnAg9FgmqxwXyuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5798
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

On Tue, Oct 13, 2026 at 01:03:17PM +0100, Anatoly Burakov wrote:
> Implement support for common flow parsing infrastructure in preparation for
> migration of flow engines. The following features are enabled:
> 
> - Conf init on dev_init
> - Conf uninit on dev_close
> - Flow replay on dev_start
> 
> Currently, i40e explicitly clears KEEP_FLOW capability flag, meaning that
> it advertises that all flows are flushed on dev stop. However, in
> practice i40e actually restores all flows on dev start, so while we will
> not (yet) advertise the KEEP_FLOW capability flag, we will also not flush
> the flows on dev stop with the new engines, and instead replay them.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c | 21 +++++++++++
>  drivers/net/intel/i40e/i40e_ethdev.h |  5 +++
>  drivers/net/intel/i40e/i40e_flow.c   | 53 +++++++++++++++++++++++++++-
>  drivers/net/intel/i40e/i40e_flow.h   | 12 +++++++
>  4 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/intel/i40e/i40e_flow.h
> 

This fails to build for arm, due to missing include of stdlib.h for
calloc() and free().
Will fix on apply.

