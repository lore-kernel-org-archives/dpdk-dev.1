Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11181C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 14:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EFC640649;
	Wed,  9 Apr 2025 16:27:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 0B7B5402B7
 for <dev@dpdk.org>; Wed,  9 Apr 2025 16:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744208856; x=1775744856;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=o1pz0VJL+9VQpIA0LpnuApUxc+yB4qBjQuHYgMh2g3o=;
 b=SZb7tIFRxQ2F9mOwG0Fncs9LDiPfrD1vcPhZREQVlnhlQOwJ3V5Y75+5
 QNxP/osDcSpCyQ29O44+J714FhMyKnxQNLTeMUe49u8Xp+AHutKKcNNqx
 WjVDnMnXGiW6Lu3+NiMkhXyFZOls31X/lg5EmNJE+p2Uq6GbfjPZizUnD
 RrzfhwF6TQySNvR0DIuDIGAr9TJTTytsDnSJFoi7HozNmn8cNsehrHOL3
 kzmDe+rrNgaWzc6Ce+KIwem85tHsmQ8rGpm4eVf59hWHSUxmEXjhk9YXW
 f4SUooFBa1NEMa5FwZtgdp6GeFLOqh1gJ3aMYMRRZolSrhTFjf7iR44Na A==;
X-CSE-ConnectionGUID: nLL+MeLKST2mXGUsNcyp1g==
X-CSE-MsgGUID: M+Rlf7k4QTqOeHNZBUAwOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44933544"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="44933544"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 07:27:35 -0700
X-CSE-ConnectionGUID: XcjW7K4DSmeP5G5eSyW7EQ==
X-CSE-MsgGUID: OusboFnIQCO7fE7Cs3NpNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="133735132"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 07:27:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:27:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 07:27:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 07:27:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6276yIMl9LCO3TrjcGpDeCXEmKukBialaMM8MQcdzFmEjF/jdVjefts/z/pRUiAetH73I6Mq+8pHkoTi09fGXeiJGvDjafz3aB2VgoDEa2hb5Qhpjsuvk89lBERACSkV6ao20J4ES7JtB4eYPohVdZJ73EQThxbk8pYCGasb+Z/7c1jmmhyW5Jm3alUdIBO20zdrwSgxnpPX7DlduZTPjzm/rCyNF7EM8ACkMwbg3CNsajbyu4m05xOtP5xRzlx0sgj808V9lopNk6zOmYa10/rhQ+9eqqgm1t6avwavntA+ZTmWwEMit3cTfBsmcdD7KgM8Huuf2fBJZ9Ky4h9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRtAlAjJLVFLT9gJhUw2AXdEiUeQZeuUBi57ZXWG9aA=;
 b=illFHvIJYQtGNBgdcPDTxouCC7vP1irNbljetFeZd+wqdzxnMikc6nUTyw3lBOKF+bxx7clPm2RqwS+lO3JKZ/cckq6I08S+iR8QXGWE5Z2nLdc19shaE8z+Lf0XYTRtZ270CVC7PDNxIZRqGu16/pBxC4/5IOIfDE4SvMf6NzaXtB1Q8nn9kaTleAKM6d1qa1EYtNaLOJS2NvquJURFUHHWQ5K15wOzpEtRoAI1D8CTwzf12mPzrYOgLKjwydpcAwjQd+LeVc965kZyKPnP+mzUENm8Oig4EF2JUwapf4+sZAD068RX9l19+rCPfNKxY2bvSYBTNfDs9Pxbht095g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 14:27:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 14:27:32 +0000
Date: Wed, 9 Apr 2025 15:27:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Praveen Shetty <praveen.shetty@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1] net/idpf: avoid truncation of constant value
Message-ID: <Z_aDznlc6Cd7nti4@bricha3-mobl1.ger.corp.intel.com>
References: <20250409125440.7103-1-praveen.shetty@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250409125440.7103-1-praveen.shetty@intel.com>
X-ClientProxiedBy: DB7PR03CA0094.eurprd03.prod.outlook.com
 (2603:10a6:10:72::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: d67b5515-cd60-4d6f-84ed-08dd7772a9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HLzXFkv1Z+dsf1wGmDRUindETqkr0OwP9lr2hnHaZs8ma0bxAxKhzmI7Hqwa?=
 =?us-ascii?Q?Nb0K5YnWwNzJTC8nEMDnPQ92EGJEc+2nh1oX+RinowdLX6g2/fBiGtuWy54c?=
 =?us-ascii?Q?dBM9id1MkPEOjOfEPuKuTz5Vq1EcC1vnikZ9EfiW96kVi1nx4Leos1qn8AZn?=
 =?us-ascii?Q?Jwo3c/1kEO6Dbj6r42TgbXtAJXDbANkf5+z4vkNP+Isml+oGoK9NMFVmDJlv?=
 =?us-ascii?Q?/CIvIU7uzQnBKz/K3co5X/13WjseXaZdUPPgc3sVS6B9Y845uZ95+R1jIPYn?=
 =?us-ascii?Q?4CCUVumt5mtLaU+SojZnWm9Rinrwk1yQQQzKXlKJqDPOT7Yqrsg+69eARW8o?=
 =?us-ascii?Q?1zBoWWuMyWFJNHRSARWw5CpePA1PbRJL8oinQOufb35CLy6wwvxrmiXW5UtS?=
 =?us-ascii?Q?VxsyQH3+Sv2c1RYdymQ+XAb0G4LPaDq6P06SnFcDgK7EEyzkwsyw/ZMrVLQt?=
 =?us-ascii?Q?d05OJzHB/pqaY8ULAfViMWLdfCD+5gH6Qv/SakzAstT3oLFwwr7O5ajL8vrk?=
 =?us-ascii?Q?sQcz/NjNYZc6EV3ZEbh4ONqPfjv8Slek6GBQlVOc4DPtiOTa2U/61kMm1Fnc?=
 =?us-ascii?Q?rsVGmFihOd28UScjy/M8yUXfmgwAoZzDQ9uefdyqBLNo0uQReKEh51XBN3g3?=
 =?us-ascii?Q?+YxHlyHo+LYTgwEsF9W6FWgtuyMn7YXb8aWiKavUEpdFwOEmUrTmQTHVXp/C?=
 =?us-ascii?Q?bBviaTVh/vNz84Pc+bQKNtcQZjCcrw6Zlj63IavkPIKjEpauO6OU2zZJwQEr?=
 =?us-ascii?Q?8lDkrON68RytgsDepy7r+yNxgKDYdpmH31S6KGThywgWQpeaPKYGGR81lCjG?=
 =?us-ascii?Q?1T0wZIIrx3Cls9IV3kyGqwNbiZVhlxp1nDAuGgXNuf6+V3Xld4LPMkNzdNCk?=
 =?us-ascii?Q?/Y7U3mmg3UQ47o49zc89cmg5oFUwS8wt6FbHIMDNBKaun3gnVEP776l9qzEU?=
 =?us-ascii?Q?DgChkJ5jIFsi4+KLA24loVZrQbfhHd4fKhrVpYBOVGPg6DVDp818X1T1GnI/?=
 =?us-ascii?Q?r/Nek5HxrrfXK1PDDBAmIfFZudJlV7TBnF58zmy5kHp2BrVpPTvhVPLPcMW3?=
 =?us-ascii?Q?EVRIlMBkKBSG7HuHJMHEkWISTU0ny0YtOuJwkRfbBC+jk9VjwcCA9HcyrNbK?=
 =?us-ascii?Q?a2kWgZIamdm4yHZViDqQtGqFOGt8koaNTxkY0/7KesKF/pwEdpCal92Inx0W?=
 =?us-ascii?Q?VgefflD5ockza7Jize/JdOCzeyUEE+vFc1Rka5dro7gqJAI5bugWbjHH6nRh?=
 =?us-ascii?Q?rDzQtCPqtdnMex/z9WTkFw4gAT+5n2GKGPrla18IE0B48a7tZFt91LyKz8+1?=
 =?us-ascii?Q?oeuYkiFiMtQg8Cd3YX/OJl+celwdYie0nmyveZolZURd/nzdnPwHb2ip1cV7?=
 =?us-ascii?Q?4FDqi3qdfy+LUVPfqPO8CDzUAwvQGaJ0GO9+CxEwpJP19JfUEv3UHKPqVxcZ?=
 =?us-ascii?Q?JQ4ycbvu91E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7pbYgeQcFZdeWlhQpgKXuGqO+t9cp6JNT5OXIqdTnYtZ9Y1FZgXSQRYT+WNf?=
 =?us-ascii?Q?xrSNmHEiGGHbWP7bKgOBHeR7RDE2SCTULl1qoqXVmyOI+wAynwD6THPaXrmM?=
 =?us-ascii?Q?B0Zr5xXHJrXAru7dvsgjVq9je1G2L2RNLI7YtL4be8ZilFJlf0I8GpJggsyp?=
 =?us-ascii?Q?Mpcyd3/023Jnn75YXJlM/qS4qJldJCugxdk3DucLHL7pX2JI4/wCSC70640B?=
 =?us-ascii?Q?N1Wmir8CPYEcD2mW44ZnjVidb672e2gMyfLNmFsor9HjQ+F1SlAbOVEfqONv?=
 =?us-ascii?Q?l4tQU+6SotO6UqTUrVGwEvHQe4xiJDsd4HwwhxnHchw2E/wxwD7Zd24IX0jD?=
 =?us-ascii?Q?bxiucFviz8i+OmhlYxUK5FHJNX1dqMv0IjnJUR34mUywk9oCNzi3/I3vORr8?=
 =?us-ascii?Q?SObkTsO6qPJS9IWCksiKLWoXyUvnmdHKdpfTfOESykPCPAlDUN5TJB2vmKbp?=
 =?us-ascii?Q?TufxMN0pchTLy69aI/P9ETGhb9yeToIch9kzjq0vnl72Dy1AyUH9c8St4C2N?=
 =?us-ascii?Q?1Nnrn5kBBqUKQGIP74Ee7vgWjadzJ/vfYa/58PAkQNFDPZBgcb8vuCI3+/7C?=
 =?us-ascii?Q?t6aWO1PtUI2NhUw7f/ZQo0AKhQTcqd3Po+7FnGeg4ghz3geEY67GzBDwzEmZ?=
 =?us-ascii?Q?iDYcYOxAvjoUiE5Kq43eXf/9imh6XiPg6hysw5k7s54pdpSl8GaBe7k0h9Fy?=
 =?us-ascii?Q?GZLkwAuYSXFWWOUk5h9CHMJ0DJnX1vrf95+MiyB0/g7sqqj0xCIpehvNw1YV?=
 =?us-ascii?Q?8Yg5Ud5VfcaitjQ9u3Fpuoo7p+JDFXtAga40sY1bqX8AZ6ZCpgnHAitnlLWY?=
 =?us-ascii?Q?cUDr3QCuw5kEhK+n6EqnapUd+lAtTlj8inZ4tueA/OYeqjujjPNXZ0DLlCzv?=
 =?us-ascii?Q?IipRwUuENy8Ge7F/8hSkGPrLZF4+r5FBqhvaYPsIxIxkV3MhSJWnZ9eEHo5z?=
 =?us-ascii?Q?kfIlL2yLqf50S0sKHowTHuis346HDtIpCZK4N6Q5klroKvd7ASuCcBGWcwan?=
 =?us-ascii?Q?TLBuaXbXCMvglnphVkZAkijlQzN4P5uXQhb6O1FZ1CvmiTLbqSoE3yaU0scC?=
 =?us-ascii?Q?BfL5z/4xfbT8y61OeIPC2nR8lqHafK8DMOLDSUVj/0vFyBumj8kIy1Lb1wc+?=
 =?us-ascii?Q?ueHohLuJndOUVTa6NBQ0DPZDFVdfUvgORoS7loHRa1iK9eKx8i4FZcGohjzP?=
 =?us-ascii?Q?40KsoFmIGx9bx4oNrLirfip2K43gpra6anUbCfVjDZPzNC3hOcrXaPccG4Rj?=
 =?us-ascii?Q?zV11sR2JvQw0+qKv+VfNydjc2oxYXTmXbHmGp7gHUe8z0dri8jtY2sr4yWvI?=
 =?us-ascii?Q?bFsPkOTVm/eqrx0a8xTIVwPhhfslIWHM7N/OBq8loJQGy/Tb1m0c9+kOBnVy?=
 =?us-ascii?Q?ylA+C6+DToivL3XOX+up1B17bt0yBpPXTRSWHnwep9WMNP417O86Ie8uuTPZ?=
 =?us-ascii?Q?KCmIez4w4PPI2qKvH1frk4ReJfmhKzCAq34SbBW+3EwCqhKHlz5ZMoy787Vw?=
 =?us-ascii?Q?bMqSMT0HZlitV4B6JV4Le+/jy7CueAziT26QukHGXoy7b/JhyBPL2Q/vxBbC?=
 =?us-ascii?Q?0m2ZpR+pycu4/lDDwEUxexgHpmxV9iUkn40459A4FBEwIaJ/jML1zbCorL5s?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d67b5515-cd60-4d6f-84ed-08dd7772a9e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:27:31.9996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4S+ooGT+6uByqR9CgxUBIxn6VnQVoyBqgHMAcdnOVUeLHJvKOaqWYbCcJ1b7OcHIgUQ+FcN6lsggtYQPn4AXQAl5vpQCY06Kh322pGxTqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
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

On Wed, Apr 09, 2025 at 12:54:40PM +0000, Praveen Shetty wrote:
> Truncation of constant value compiler warning was reported in clang/msvc
> compiler for the VIRTCHNL2_CAP_OEM bit setting.This is due to 64 bit number
> is initialized in a 32 bit enum.VIRTCHNL2_CAP_OEM capability is not used in
> the present dpdk code,so removing this bit setting from the dpdk to avoid
> the truncation.

Please just watch spacing after punctuation in commit message. Will fix on
apply as necessary, no need for new revision to fix it.

> 
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> ---
>  drivers/net/intel/idpf/base/virtchnl2.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/base/virtchnl2.h b/drivers/net/intel/idpf/base/virtchnl2.h
> index 3285a2b674..cf010c0504 100644
> --- a/drivers/net/intel/idpf/base/virtchnl2.h
> +++ b/drivers/net/intel/idpf/base/virtchnl2.h
> @@ -265,8 +265,6 @@ enum virtchnl2_cap_other {
>  	 * if a reserved bit is set in a standard completion's tag.
>  	 */
>  	VIRTCHNL2_CAP_MISS_COMPL_TAG		= BIT_ULL(20),
> -	/* This must be the last capability */
> -	VIRTCHNL2_CAP_OEM			= BIT_ULL(63),
>  };
>  

Although technically perhaps not as good as [1], this avoids significant
divergence from the shared base code, while still fixing the core issue.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


[1] https://patches.dpdk.org/project/dpdk/patch/1734537913-1159-1-git-send-email-andremue@linux.microsoft.com/

