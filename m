Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C1CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB1F540395;
	Thu,  6 Nov 2025 16:09:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 74330402E1
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:09:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762441792; x=1793977792;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=luIY8FelbQIoFkyB26xdwPnU6OD3NUmkGufTItDX+3A=;
 b=g1wy78144lZg4TwR0LKtSJ1Pz0Yt1ClQHGDJUQBJYhDEJqd2RyXai8Vo
 yJPzYN4YgvTxkLcEQgOnTb3PCeAqTILeBD/wzbmAQvG576PPsVDYa5uvx
 Y62bXESCS1MJs30Q/na5skm1FPAMdEAdoBBTx8QwAWw33BRhu9fpBKYI2
 s8DjGoLsG+xiRm7xTyoDvRfO/329yTNS+UNH/irupV6XjzAR7zGopd8rC
 vPgTesNiG6G0s0ACDrCcLObDg4bz4bzl1sPdvmN2U4uvNjQq3qTx+nfTj
 EfE98C0T7ogGEZUCY3eNBLZt/l5Fe1H/cvU6VV4NLMuVRCvZU/x57EFId Q==;
X-CSE-ConnectionGUID: rzIHwCJmTeiQK/bJZyEQzA==
X-CSE-MsgGUID: gsr4iqOhRwa92lsGlSKZgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64495680"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="64495680"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:09:51 -0800
X-CSE-ConnectionGUID: 0NXkMclcQBSdqRqv0clipg==
X-CSE-MsgGUID: Z9aHFLb2QA6YRs1nQtfAvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="192136817"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:09:50 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:09:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 07:09:49 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:09:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyVhSs173hqj/yqv4jhLfJAds+ng6xA7IMzyRFbJddlGM3SrGmVOY4mSltda2iCBG7jhIOcn06fQDFg6EF/Sdewl9yfJ2lguenkExbxnxL7OFfdV1bQWXBOB6lL4J1twLa9Bbc+2VTg0JLe7HC/EyZLwDkBzTJ0RYfrDJ/mfxza+UG/nNhQvjxGHdQaU1AJ/I37BkEtkXXGR/H+MqCYhUvfeSxfOipiZtacopIMIxhcFN9BSV+ITnO5W8AtN9+fA6mzKBykIMK6Ea3mP5b5APov48Oc87AUYegf9+d4AxvsvejQrG+57kPhAdV69vBvyRh7Yje6nv6z/eaXYrFLEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoU2tAmDTGjOujyFuNBBqps2BGrNcBg6QJPTaPHdrD4=;
 b=D/RGNtrV78w2BCY9OqFIjmiiUCKNOuoaVunBnj+Z5eECGVVrvUwX26BuEVt8IbCWaD/qOXatPjKFZR1pyGRjMa5i1Llmy3OnrBvHSpH3F/pBrvFH7a5LhPpeNv/F/HVvEc2fsAjcD/RSCXEOUXzMmqNUUfcnNbDHfktI17vipzGl9wRQ5z5kfRaouiRnrLgx2ub9Kfe7xYvK8c3BanUYBO7YVx8yjCzvVLy5NSmlgmFZ8iyXtVFgV1DdvF9MkxbVop6hcBxXBTZ+wulV7Abv/Mnie9UKcFAKnW1BeQTKNP//6sR22kJ3zXDNVBy8yCi1u1585CjOsd/W0J0tYr/qyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Thu, 6 Nov 2025 15:09:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:09:47 +0000
Date: Thu, 6 Nov 2025 15:09:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 4/6] net/iavf: fix single VLAN insertion positioning
Message-ID: <aQy6N602ebi6KlQ_@bricha3-mobl1.ger.corp.intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
 <20251106115016.3035639-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106115016.3035639-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 44abd53c-0152-46fc-42d7-08de1d468670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uHs1NJ+6gB5i5EShtDm5uS8n/i78SJY4Gfd0XjgZ8iX6Omdy70cmlL8+2gwB?=
 =?us-ascii?Q?9P8Bdqn6vttR7lq2BLmcgpQBzvGxjaPFmPdZPr8n88ACQwEwgqnKZx/Lnic4?=
 =?us-ascii?Q?uwaXS21clE2UoPTlszz3dmwK2nXnWcT6bs2iSxfUXpHgipdzH/casXyVxtjB?=
 =?us-ascii?Q?tS+4xLgBoYYynWWuZCbz5KruPHwRPsfZpUG4MT59EBX7dQai+RnZl6EsEKP3?=
 =?us-ascii?Q?3bl4gHEf6AruC5BTRuFLKkDolya6UvjiBxfHVZaNVxVIZvtPjoffXjgRVRHo?=
 =?us-ascii?Q?1UpyisMKr9msPytPbTxMBRtaIwXVnG/AmH8lOZhdOOS+reakRpQBMN6m7g8f?=
 =?us-ascii?Q?5Py38kMwKkiWFewNK4vdC9yrfre+6XyYEBqf1zuFQ7XNscOYDg3ILtG2zFz6?=
 =?us-ascii?Q?so2ggKodu7x7O9OEwa0061QkfU//qUzBfp8e6hinUqHflfEUuYgNNAZG9nsj?=
 =?us-ascii?Q?cjDKOqXVQJOJZu3mmEUbQ01CHOXDIZzgbOercaNpZM3Rlm7TLM4JWMH3Co9f?=
 =?us-ascii?Q?Do8zfp9tBa8mvknLXF90yGmHEuGRwSCwzCr8CYoXA2gCjpHvsxN0Q+pmS2rd?=
 =?us-ascii?Q?NA5c33bZ5CbgO23g8LTQ/6pIYtMnxQcUj88IQEPcAimvhfanb+tHS35GckE/?=
 =?us-ascii?Q?yTovhisk/Yx2KjqsgqUcktlVDFjT+wJ1W68jRPqd396St8NFNa5mOlicBcw6?=
 =?us-ascii?Q?1In7NnU+hZ9EL6f7OsClzoEKb5rNGlvdGS0GEJAaGOrEiIJz4z0EjrTPgXJF?=
 =?us-ascii?Q?BIqw9QSDRX57/3Ti+G3ZyOe8aqSQnOR8Pk3w++eXsg26WdUGzMJ2eLPRRywZ?=
 =?us-ascii?Q?pplyySMYuTWok7+E6F9+zNSLgQW1yeO1nrzCg4NcwfHPCcwX/tk7S8ix6fPt?=
 =?us-ascii?Q?vkJN3DGb4BHZ6VEQb9Ht+e/p8e+X2obBJdzf9qp9AqBKLtHwbLihQmt/kNWO?=
 =?us-ascii?Q?ZtiH2AM4OtV9qUDG1NoRGUiC1vXhjY5Tbo1p5x0aNU5lFbZZEvpC/3FAXXEr?=
 =?us-ascii?Q?mwpUppjxXCamqiAyDHLIPkO8ZdayZtomL08Qc0bF1N+rBr3zNXsGjNEGlx7u?=
 =?us-ascii?Q?uYBYzVn2i3ic0ben4MNSM5tCrVhqpZG2Ly4zthfOnJCHuyTZIIiLTK+Ozeai?=
 =?us-ascii?Q?UBv4zxfa/HZb1tBtK2f7SLPD8RwTzTYQTRsLhc0nCR7uEdY86WcQro0nm+1c?=
 =?us-ascii?Q?HbFePhgMYfeGLS5F9EdtVqUcSGimJ4aF/MQ8ltdHy/2pPDZL4iFAjxe6Kcyq?=
 =?us-ascii?Q?jY/r7AEh4LSfjA9PX3H5xu0hcctallSiMUNShnnZuni0sVao+3zffTVVBeVP?=
 =?us-ascii?Q?087PTmSpJJV8EdfMGVR+kT3Q0MJadrFHZqGiAlLZFO9XwQ3mfohk2WGu399U?=
 =?us-ascii?Q?UyB8itZqdSDQ59WNIQFmuXdy/nH6EkZJuYisoigxJiasJD+3TMyrjF7ZeQyX?=
 =?us-ascii?Q?x1336nag4EmwS1u1z9S7/rVdwazcA3Lk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iw5bQx323H4ILRZ7S9TuEqKvYrMfJBgToFifKHIcyOQifser6CcuTAOheZWL?=
 =?us-ascii?Q?AqTrA0GwhHw+evBRnssouHNLAGGYhw94QodOblPRcwKi9ZTlTulHXas4mloX?=
 =?us-ascii?Q?BMW7kUSyoOy0vILLwh4AA9/bnCSL/9Gs/iE7L65zdNjQsSY/WTEeeMcssYvE?=
 =?us-ascii?Q?8TIQrprUqM4J4kebT16Rm0fGR1Zsu3AL7r1VrCtJxdxPjdD+frUKkc3Ebj+Y?=
 =?us-ascii?Q?Aid8qljIP/uK3scyswkZSK0uZ3vKhZI3sZRAeiSPzCvoHSlo2Se17NyHMLxo?=
 =?us-ascii?Q?IGQxTX/cMhbxuUCt2cA8BvjW2Z90sXbTNPSfaqGdLLGYG7ZdU1+QQtEftveL?=
 =?us-ascii?Q?9gvzyJSBm6qUZKw93AJkN7IeXGPVkFY8MzRnCDM+yPBW9eLAhZr1oUeA9Ipu?=
 =?us-ascii?Q?Tm8OH/sXFCHlnes/e4zX8t/jzwgLs9OwmL0XotPT7o1cRnX1gx7XPPlLOIUG?=
 =?us-ascii?Q?RHxjo50V2dleV0Z6BPNM7AFVHDQdZB+xxcDCbXmhkP5wMPCGXrJ4DRWZFTVn?=
 =?us-ascii?Q?YsTU4SQVVOGIyoXlo2dOMrUA/PFsVADac1ewmggjKvdJoG3N1uPfX7dHkjdv?=
 =?us-ascii?Q?tol5WKxLTqj81tog+gIgS7NBv9wK2+v3AcwpKtOlp7ONSupHD6pLtkr/u1CB?=
 =?us-ascii?Q?yoKkBJjr7plo8JIYBwmO3HTbU3QtI96HchtDUIV/DAQ6nJKWXuukpF47feIx?=
 =?us-ascii?Q?iMwDYR34515zijofZyJk3AiwA4sZfpPV+BHTT+f5zvnmg5zv9DbsJ7d8Gt03?=
 =?us-ascii?Q?5XsZYx7/HJGznoQ5CkWojbbycLgEP0BSJkeAuUA+PWSrYbji8WYMaddq0FLN?=
 =?us-ascii?Q?lVfNNYfEjGoX9Evk0yClQwBqsiq/Fu/qIsaqdU/RbzPKfppGJ7GSNAfb657l?=
 =?us-ascii?Q?M7yZtR5nLmLxVYFaJoUmxuaWHOyll6nr0CVLciNQVlbRetp1PFRbAAaWDrbv?=
 =?us-ascii?Q?GV/D+CK/7+X30G/Fbd1tAdI5/0VBQjRTj+sR/cTMhgk/qPalROsDaSmGhNBd?=
 =?us-ascii?Q?asFvOWUOJdx2m9J76mHxlVsXnSh58E8N90QrySN5KtJDIX/HOZslQ0Yd0CW5?=
 =?us-ascii?Q?/W9d0cVDpsHn1hklM7WjDGkv8LnCXuCwsLReyxHrTQ3RJ127dLlNWRPxcMDH?=
 =?us-ascii?Q?wx5xD3laNGC9Aajmxf4nO9aDK+uZ2h5Ol8K4OJv/lZcmBiidPjc8iwM3JnHG?=
 =?us-ascii?Q?alUYQyaRnLG7RwhZqaZLq2mt3EesTbiZ+N7De0dqTPo1AOjAzYVXAQJwpza2?=
 =?us-ascii?Q?SiZgkxWB7ok/RcDKhaWlNcuEH3t08E7DrkrGLhM9t3S72OZUMEP57YZ19rkl?=
 =?us-ascii?Q?sL6p73pkAcReioc1tgTSv6pP5MTxqh8MFauL6xWYiax6dm9rxOOsa41yw31C?=
 =?us-ascii?Q?qxRp4h7JNq0pW4zgrShFWOH9CWz01a6t+HFfR7VhNGJ+UPgSBjpvSq9RYrs5?=
 =?us-ascii?Q?7b9YegnO+xNJPIozad9Wk1zLsvQI7kaBTiFXmLQYZaefna4ZxVGG4jGrAlja?=
 =?us-ascii?Q?BnKUxWuzRc3blghioM+VkGmH4tbl5Ki8ZTMRUAqxdbEw9gASHM/NP4X4h4MD?=
 =?us-ascii?Q?KkR5Cv8RRRa07ePJPBI+Q4AYsSAiomuckTtw07Fk9bCRC4TSt3srUBkh3SpG?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44abd53c-0152-46fc-42d7-08de1d468670
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:09:47.5944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0jV4Q3toKe1lx2ka8B5Qmcjh/BzG3mKqA5ihnyc8+nh4aiSQsJkA4sLrSwIARlLfxUTAkbrYRndT2DFBR5rzqTlt5PjNaDRAZKDCB9y6ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
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

On Thu, Nov 06, 2025 at 11:50:14AM +0000, Ciara Loftus wrote:
> Commit fdc37964c2bf ("net/iavf: support QinQ insertion offload in scalar
> Tx") broke single VLAN insertion offload in cases where the v2 offload
> capability and both inner and outer insertion were supported because it
> caused inner VLAN tags to be inserted instead of outer.
> 
> When an iavf tx queue is being set up, if v2 offload capability is
> supported, the driver queries the insertion capabilities and takes note
> of where VLAN tags should be placed in the transmit and/or context
> descriptors for insertion offload. In the offending commit, when both
> inner and outer insertion was reported as supported, the flag
> "vlan_flag" was changed to hold the location for inner VLAN tags.
> However this caused inner VLAN tags to be inserted in the case of single
> VLAN offload which is incorrect behaviour for this use case.
> 
> To fix this, revert the "vlan_flag" back to holding the location for
> outer VLAN tags and update the datapath code accordingly.
> 
> Fixes: fdc37964c2bf ("net/iavf: support QinQ insertion offload in scalar Tx")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.c            | 53 +++++++------------
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  8 +--
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  5 +-
>  3 files changed, 26 insertions(+), 40 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

