Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B2606A327
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mz16aIqI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F02E9402D0;
	Fri, 23 Oct 2026 15:56:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id E5FE14029D
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792763794; x=1824299794;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bZSZKouYIlSZ79p9vqIH+d65AxFrvoQkniRUR0AcuOk=;
 b=Mz16aIqIQGZmKv9D+GxhgDYfQw44MOB8pC2NQLEW7z7cU90FtPYq2CkR
 ckKZtgU0wDkhPPWVWol5LOeppFBPhoIEMEFR0GgnnwPZc6G3XesXV5wCe
 4HH+K1VPsKfohYxT99Fivnl1YT9PtxSRq4gsBs4HhtPe/+aAcQtrzCU6f
 7h6NgF1kg5UB5EhVh1baXOFp0tmqqLYpPGtVULYwDipIF8Qz+J7bTuPzI
 SV1gkIoPOVylFlRa78DUgkJQlHpvXNTaZ/wrAwmt71GbjxpGSofKsHwAZ
 ro+BImFY+5leuHpNZgcIz08yOt9MT/nkP7TuKNHD5EUUMoFVcZ7gLBAPA w==;
X-CSE-ConnectionGUID: uM6SezA8QnWNV+qJ0C1hxQ==
X-CSE-MsgGUID: kMJ+nB80QgGd4VMwzT2Vww==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1404125"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1404125"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:56:33 -0700
X-CSE-ConnectionGUID: XPpcV3tmTpay1YUdXtaBlQ==
X-CSE-MsgGUID: Nm+DTWdiSKi9vVE08JDCKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3763098"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:56:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:56:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 06:56:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:56:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE3D6QYI1ALrA0DOM/WP7bvt4MD9e+7OBbDtxqYYy8mXLAql6mJI6IsYNfW26Itm+lzW+HfrVJZL0hERrxWf3BiFFOsHh7qhWLU2U6sX2tVM5ygnVEkosfeKuv/L/+ljjyDyfk4KPczD3qLOwy1SudtmSWBklaaChLoPdsB+sXcz4ob8tTgrNj4a2VHb0y30IGcDTF2ksSu7ycHaL7/5rI8L1i+R1uAFx5KgsxCrN+bMH+W4tUIwPXKuj0Cufs91OvRgEc/xjw/sFmpJSSZGO4YdSWys5HOdL5VhB6pflTiFytBVErk2n3G/x5uFNtsjxLmkFPw3Di77Au2qdvzZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws15374Lx62TMgGhiReARdHw+4je7mykbB+7fKIsADM=;
 b=B6NoGXmIBq+bjnEZEu8heZKBa+WU4gGvqJziNu2WIxtzlhvEfA36Pb+/KgGVMM5SkGlZPEQJyOt77USYpnOFOt+FmF8dI93ppwCxno/SA/i8w1mSP1vC9VtfgIu6r4Lo+VwzXLCeQyayv05+j6P7CEYyavCb5elpSLJBat5wdn81FLWPoI5QapE0S2HVZrvmTKrAaV/yPXEvmUtdzX+Nmfh8ZPAMnzbsIyhmPGL3hqQbUDhgRMyujS/WeT4s4BBhOr/8mEhIWYEgEV2z3/aBKSl7RbIwh9HpNBQ8xWkvegydkqggcebUh3FXdgVkXQWb7gI5EHJ/gZOr8r3w8aSwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 23 Oct
 2026 13:56:27 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 13:56:27 +0000
Date: Fri, 23 Oct 2026 14:56:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 0/9] Update ICE base driver
Message-ID: <attnhh2u_kca3JlE@bricha3-mobl1.ger.corp.intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
 <25893dcd-99b0-44d0-a9dc-2947f2da59f8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <25893dcd-99b0-44d0-a9dc-2947f2da59f8@intel.com>
X-ClientProxiedBy: DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 751196f2-0911-451d-07ca-08df310d6ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|261021121427099003|3023799007|10067099003|261021123027099003|11063799006|4143699003|261009223027099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3r/Hx232ZUFvwvXPidUI6bAdQtwCVdG5BHCqxWzefQmVsOWLa6bt74SHxJ24KsRD78hm7NKvIQNte8m6dDgUFgK1XHR1YYd3BahHIBJGF6EJkzbQsBIB3qr59B0zrMrR33Wgz8GXXRURRAtMm8fmXOx1bayiIyRFKQfwouhKQE6gzb2Y+0wihteGVJX69wPJbdEhlM/TF9Av+Mvw7GCnqFVCBF3TsuYoz+IEbgEfHybs1Q4LU4Z+PABANxhHe3YIlmaaeYQCcB0jZlJq23pfdQw4CWqm3xS1YOnNW0Ny54/mS/3Cqvez5kVoGkD/4UBSN1EZa9U6MGZx4viRA+JbH6mDbgcagWP7OEFuEubNHvyWoQ6yfgXUzCmJiffH01IVo4dcP4fUQm9glW3VzMD8sU2NwXe6SV4fctbkvDt0A1oOji2DuxVqP1KeWE4SjeshBX6/qCERz70/l3nF46YmOBsSaIPfU34E25z8J8s7AxyJir5RcFS8r7xn4IE3KKm18wuWmBWvBz7WgMB9OoTa9BieA4cU+1kIjBISVpvEG9kqmHiXO+0WEfDDLEkkbRNFdkClWTsFiNz3KWOqvWmJJ+3a1fD8blQWpANdAj6TDjiQcrRp7ODLfqeh3GZuZQ/yDn21amXka6woQ7QS8UQMDoCdt3CYArLluoK6ZO+CxTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261021121427099003)(3023799007)(10067099003)(261021123027099003)(11063799006)(4143699003)(261009223027099003)(261022105027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TP8Cqy2yCQinEli06xMOsDZQ3S8apb8aMvlcL4ts9jyvhkxhEiLgLscLAcgB?=
 =?us-ascii?Q?p2d795O1uhrXo7vjQeZhqGEaDOLfhu4LZbf2eigTDAMIkHzwZiXCLnTfZFZb?=
 =?us-ascii?Q?NtEsRcQxir9JO+579I8pQt1e0icyFIBF7DgHjFZMlvLvFJ6cbimlwDI+1lv8?=
 =?us-ascii?Q?SquHkM20S5G8SQ2/kzM7vjI5vlIkohjPIIHjpZ3cv2QrWp0kWCx9V15f9XIt?=
 =?us-ascii?Q?v9SHbZRLRSfJvwlO/QEUKFN9fnFIjbSvDAVFU6mqyu73z/rY0GvC+yI2hAqs?=
 =?us-ascii?Q?wD6yWKrH6IzTBYgEK2u0fDKDRTczar7iZMg2qo7bklD9ogP7iN3R91+NCyxu?=
 =?us-ascii?Q?qCvSQA65ltPhUY1e58GllpeinEL7hf3aN9y82rpJUmAL2QcYnjQRMGPKwEbj?=
 =?us-ascii?Q?QD8Ce1AkLvY7koRjlGgfvADu1gMdFlocqsu1wzwf9OsVxYbU9hn6ifRtxHng?=
 =?us-ascii?Q?A2uSwq9P9hJC9/F2TqkmOgVmyu2s/Jy0TcnplVj4cDH9YQxuZGs9PGVNNaH7?=
 =?us-ascii?Q?iJqBdykXCtagiXYJbG+INbuuOceN/fki6TMkEeRvLeXAzHzBaT3nbk7QlhMJ?=
 =?us-ascii?Q?HKFZ6PLMeBKXrA6eJP+PFbQdtrgf/xYvQPJ/syG8S5ujGNYTtBC8V3UtrQkN?=
 =?us-ascii?Q?FEe1GfPvKYI7w+b00h0niE4+uhNqPvLobp6LZq2eWRuu98JdeFYKZEx6JP1O?=
 =?us-ascii?Q?U+m/t7Wot8PO5rWe7enluk6WG9AImJ3Z8taPh6oyoEO4AWMERyvX8/6Br/JG?=
 =?us-ascii?Q?n5YFgBBceFVy4WdX7sF7IOgo5+GKU5o5cR/DKQwAN/uVHpkzlyoa/0w0tZXX?=
 =?us-ascii?Q?Z9Q+2wX48qs0v+mwKFWhF4xtH4xreIdrVJnIDbz2q6c7E1omudroXn6SaxVl?=
 =?us-ascii?Q?QJPw371thNT1Pig3sGN8KuZkDWbQbXPFFuVfaTHcJFKL9Jjy+W8/qgyiAdUR?=
 =?us-ascii?Q?fdS60pTKBktDSJTHQ7Fe62oSxpxmCBHW4Hq4cdjOHv0cBTHVl8HVP3aMqFxU?=
 =?us-ascii?Q?+PbSEZTd3PH1zPkUNShyn3ZzlWoNjL8H5RZRiSP4qjq2qdrEDoi2H/lmP2qK?=
 =?us-ascii?Q?rTzSmBkUypniXSShr0mgMeCDjnFnyXzEU+PME7vusUKP0pOXcnFVCp9CisZX?=
 =?us-ascii?Q?ATJJ69W6XRB7TUx+KiIi49zr/m0EttyNKllj6C61BNI/K5SmKdiX+6Dv/PX9?=
 =?us-ascii?Q?z5S1fVGDifqD4Fz0B5TvNp3mwTQE82Ock9/sFgUdQfBnpLOOEw6MlwZHwydo?=
 =?us-ascii?Q?+7jArWRGGxzsmfriYN8i98LM+P74uZcFhEFYITjyfInZlKQ0eZnSJazQTwmn?=
 =?us-ascii?Q?hzriWAQAy0i3EJryizqEQg9VYbbaMoxD2sOJFPKDUmW6rj6CK0In/LVv8PX1?=
 =?us-ascii?Q?0lTGJ2TdJ6KFGFTOMEUevMmKSdSLDfFvUih0cqhMu7zmkTjP0Bl7FZKDfRDY?=
 =?us-ascii?Q?aJJhsdySzfHJ46/NgFkJMLpQTktbd8miTrp/xlt58x3xRvdHz2Jl7L1UoO/m?=
 =?us-ascii?Q?gAr1nnPIK4+bG4AUxYhLOnKhGpi2mjheoARd+nM3E3CHYYRXwk2uaq5XB8+W?=
 =?us-ascii?Q?N41WcGpoQPf4tqKlIrpZkgyCBLrElIFb5ik4KZ0HM8EUB2YHeBEuXX8/j/4b?=
 =?us-ascii?Q?PvX+wATvWIZTdUAeNfZNOLYqW6h1ghTJ1S11pgp+hQ6RT0LAsJb6j4/P/u+2?=
 =?us-ascii?Q?NxhSQZsIjh2PXEhJ+H9VDZqoJhrhhvfeCbIvbDhpq6jdPLXojEOEw1ZkZsAR?=
 =?us-ascii?Q?ZpLs+fHwvspecRKCObIJqxaUx0IO09g=3D?=
X-Exchange-RoutingPolicyChecked: NFDh4Z7OwPcvS5y8uNGmX5KxPQ/5p3F30TPv3rLmvYRPFWcmFJjzNmYLRygtwd4yR4B/blqWQVj/1PCEgmKAo/ruabaB4fSvpOY7Gb5y6tI+KCwFoiAlJGQ9bUKE38KBQwArnUVr3YYvaUR/Ho+p943myWmj8TN5NlZOi9UFW4fM3p5vMgeNrvwykNKx74sVAcAVKPJZHuULUNfdWP5TjawFE/0hD7SatQ6YEcDPKft3hMUpt+YvRgObt5bAzK65uGMqkYYTJxlUVOy3F/1anuGLKS9lXUuGTse8tSCOkKCXhxK9PteDET9B3ZJjgodixy1mfR3fFycbdARjQmQXNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 751196f2-0911-451d-07ca-08df310d6ee3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:56:27.7342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Em5pS6M84+nlw2U9UwbXNeGk3HyiKZ9W/KbCqPhO4jDaANh06pWv0p3OFYaZhC2gzP4Kd1jao0j4R04kmg8tyjdKtYKEKXRVVv+dHsN7k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 12:17:25PM +0200, Burakov, Anatoly wrote:
> On 10/22/2026 6:51 PM, Vladimir Medvedkin wrote:
> > Update the ICE base driver to the latest shared code snapshot:
> > 
> > - Bounds check, integer overflow and type fixes
> > - New capability and NVM definitions
> > - New E835 10GBASE-T device ID
> > 
> > Chinh Cao (2):
> >    net/ice/base: add NVM definitions for Wake-on-LAN config
> >    net/ice/base: add E835 10GBASE-T device ID
> > 
> > Deepthi Kavalur (1):
> >    net/ice/base: fix loop counter type in recipe creation
> > 
> > Janardhanan Arumugam (1):
> >    net/ice/base: fix out-of-bounds accesses in DDP and NVM code
> > 
> > Krzysztof Galazka (1):
> >    net/ice/base: fix integer overflow in RL profile calculation
> > 
> > Przemyslaw Gierszynski (1):
> >    net/ice/base: add RDE WoL override capability bit
> > 
> > Stefan Wegrzyn (2):
> >    net/ice/base: add PQC certificate provisioning capability
> >    net/ice/base: add NVM write flags for eRoT minSREV update
> > 
> > Vladimir Medvedkin (1):
> >    net/ice/base: update version info
> > 
> >   drivers/net/intel/ice/base/README           |  2 +-
> >   drivers/net/intel/ice/base/ice_adminq_cmd.h |  6 ++++++
> >   drivers/net/intel/ice/base/ice_common.c     |  6 ++++++
> >   drivers/net/intel/ice/base/ice_ddp.c        | 19 ++++++++++++-------
> >   drivers/net/intel/ice/base/ice_devids.h     | 14 ++++++++------
> >   drivers/net/intel/ice/base/ice_nvm.c        |  4 ++--
> >   drivers/net/intel/ice/base/ice_sched.c      | 18 ++++++++----------
> >   drivers/net/intel/ice/base/ice_switch.c     |  2 +-
> >   drivers/net/intel/ice/base/ice_type.h       | 16 +++++++++++++++-
> >   drivers/net/intel/ice/ice_ethdev.c          |  1 +
> >   10 files changed, 60 insertions(+), 28 deletions(-)
> > 
> Series-acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
