Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E0EC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:58:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB51140695;
	Fri, 10 Jul 2026 12:58:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 166DC400D5;
 Fri, 10 Jul 2026 12:58:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783681096; x=1815217096;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mvWhRDfkZJNnGMFMV4nsls3YEzXIZ7Xr33c9y2/IZhM=;
 b=kJBvH4O4Ld2EhPGB0sGiUiFsQzis+um/zcKjH6maYxMJfljMiqAGyA28
 ITPRV9fRc0Z1ZCAeFbyso2HGFBC53H+UN3Tvmbd4sxyy0zBHEeR1k2iAW
 3DhqbmkGTn2OL3+QXMQ+r8nYxepUzRPAL+T5LTOFIgTcQYB2SKdFPtHNg
 0sy2wwBWmrNI0Nr7CywhAXroZrfrRNHhaNrTNjgg3v9zpSXj3Q9tCG88I
 hejZael+sYls0wVZ+XyydTxGeBBr1pVeHqljK/xHIxOERfpvSl20Yv/q6
 ApWN0m1mUni54/nuNNK/kVVMRwV8KmMpPuxGjbXju/s/e8tauaTg1AOBG w==;
X-CSE-ConnectionGUID: TwKPAbs2RzS06bbhsDTnQQ==
X-CSE-MsgGUID: m28JJ6jfQNKQk9/Mi8JdIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95750629"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95750629"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:58:15 -0700
X-CSE-ConnectionGUID: yrpM7AlCSCuzYhnW33qWtw==
X-CSE-MsgGUID: KBnEizSlR764sMumPvHZfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="250856179"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:58:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:58:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:58:14 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiM/kkeUjHyLexWAFdEn+Uem6yUjoyoUWNQEA21ydhiuxi/wVBMbxibaeff5rm70NP2AgsezchJV/Ff6rwf1FQ5gyW1rGlGYQW7aCNjUYO66YfUwzyIs+KFLCN1tMlSrG8A4z7ZDEmQUFQvKhs4RXVqzjBNTyBA6SOBdhoWFPG9KYYYUtB7EKxiCjD7b9cOct+wxhVFOn74HGJ6TRbpN3n52Bsv+gSdefgNhPLY1JhxuGBBwC/KnW9MaKvq5Q2dqAaO8n4aYsZk2MPG6Bf26tCE87+46HLS0Tcx88gmuOROqgr/Tcu9fKT+AKFGYm0ZHXbyEF7ANw6eI1YMzFCB2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM0ujFTCbDrscEK9Q0OalG02mpl6OfPgsmBixpuxYV4=;
 b=rjq9XecqK3qOTm24UE+MaiU8PAm9ApqLiqfRQWGisSAXBA85koKIzN+T7GdpA69yqwTjNDPNONWbXRNypW9LReNuvR7HSVhD4vzzpAa5tEpi//0+Z4FyS3vr3tmL6qXsq+3UiAH9GfjFeQMFOuG3M4zYVbDrHWyDvJeUJCft4/NvYJxjuHA8AOMtnYz+2/xFNPIsskYo1RaSl4Pdz7UT2IHa1fl6BCQWFOM125WBi+QaHSpEorIvx8Xw/ruLKGEIbLjRt4Xr31MYyuCtwGcgfsH+72J48bjf2s3ipI0y0AK+xZydlZccEIxCNeZpAunoI7Q6hTU+CM780rhVKNTiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA6PR11MB187491.namprd11.prod.outlook.com (2603:10b6:208:5e4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 10:58:12 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 10:58:12 +0000
Date: Fri, 10 Jul 2026 11:58:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix FDIR flexible payload issues
Message-ID: <alDQQNnjcm05iARx@bricha3-mobl1.ger.corp.intel.com>
References: <20260708002045.166595-1-sandeep.penigalapati@intel.com>
 <alDPoD58N7ssSRhh@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alDPoD58N7ssSRhh@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0253.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::18) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA6PR11MB187491:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b8a081-725a-4e86-a91c-08dede7222c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: evw763BPdeTGDM7aDM2SKiUF8ZuipP4u0K34PPd2Q+T4miq0cOmRq2bkrY5zF8oOH7mnYAGuFuT/ioHrJIndL/tiqadVaPQ4GLK1jy4sbheSyLOV/AtE56FsrgGL6LTA6RhuINIK+tk7v/Z5LmZxe/a9cr5Kz3sVj2SgE/efIsf1+44QXXs46Hz9ZFOX98c/Fe7awKhcQDqJYYiAHNuLADIQPpkA4JOcPVomZTdrPTlIAu49XrgBt34h2iItmRpv4kx088xTc4ygNo2FsKDLRMP1iPBJZL3oTOcBARoCHeG20HJe4+6LKf1DGWSs35lzhEM26oQ2XnA7Y9XMNbOvhVWEyVjae2JI8qpEnWK4mLhepcDFWfESANKfWyVNXmhHMBDON0WXgLLZlvXvAxgHV+gfIFy53d+xqr2fQ8WfBXaXfGcG5batHbh+nQJdsst3QzK6uMApszsM4tD7mOLaEvYVnPyVd9E1GFglYF7Pi3/Ar+PcwBTmLt3eaUVbxojr+tKTJWIUvoxVGpy7kxNcvyzg7MOe5r1Idbw+E9bGhUJGQXtCh8q4+oj7gIrp4EyVgm/26cjBWBd0FuSrL7AVpgqsczt1wPecXoqqPYucMDYpR3UQ8j2V5e9aW0eMyTYo/Zz8fkJ16RzyU7LrpVc4+SkE5xw+R3sHOEXPstS5uDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4sI3C18l3HWjQmAsQn3ryu56bdyddKFUymT3zFi1CEo12OhrN+m5Copyc6Ai?=
 =?us-ascii?Q?3hZ6IDCn8yAOCZ9RJ7aZN5yKkm86sHkuSl4XZ5zIiRoCb92lGd8MEIUXsfho?=
 =?us-ascii?Q?UqxeuvXGIh1N/CsVgM9VR1dfyUw7AUf3T8P3UuUCWSTsum6AD+P+aqbbt+v0?=
 =?us-ascii?Q?G5nL8WlvL8FDj8YAK1cJiStoi9y4lKKjE+fJGvGsmGuP4lePohy0kSdf4mut?=
 =?us-ascii?Q?P7pGGi6cC6Mx2Cl45xAY39Krxf8BUlM5ppJYuwOhz7NNstkkyMLaNUZJ9Lfe?=
 =?us-ascii?Q?TrbPF4DuqwC8tSZEzFWKPQGRcOH2szcbuCosS/vXL2VLKYwAgz+GUtRwZHpK?=
 =?us-ascii?Q?9ZggByfctw2O/qZ/hoaIi8BjH3NXCdIfxsr4Km4wbx6u1+xS4n1PwT4MlvRg?=
 =?us-ascii?Q?PLQex4T4lEQdwFeeBTxD81XoKPITvOEdaK6Wcs5BlsGksqz2XyGBsx2Zalxk?=
 =?us-ascii?Q?C+pIpS/Hdd4M2EL6KN91gBbzcWEOjyh/OLuIuJjOnSGr6KeZ6WUK+4+YGS00?=
 =?us-ascii?Q?8IoA/V7EalpFiGtT+TdV9C4hFWLgWsVAlyGKNw6t+KTqYELoTTxCZoEXcaC4?=
 =?us-ascii?Q?ClfG+2tEEa9/sUzeR7h9ooj6Y2c7dccQd9shAm6iMur+mIwBfv1ho/F35ufL?=
 =?us-ascii?Q?InpMevWNuFfn0AIZ9VCBS7nxsw6OJIbTVJ9B7Wte19l8fmeCychP+TZDxi+e?=
 =?us-ascii?Q?JQpWUUw0t7pvjD21oBO0OUF6GBNSCyonNJ1r/B5TQYwQEEDzDEjLBf1OHiFs?=
 =?us-ascii?Q?IYUiVmyGJcHqfcKMcW8zjgneOimsMFtypQusZpcxJW5ELFWOk9dhdAoTN1no?=
 =?us-ascii?Q?YZCF5X81WXc5BBfJfE1CM7g2xvS0dwQY21anDMo9tOsGOYcUPv29oATqS87N?=
 =?us-ascii?Q?jlHCRJMqMwxg29PVBAmGkwpzYfb2abE/VMHrLE9xG+BHa+anXBxQCxxPMCTY?=
 =?us-ascii?Q?/3zuc6fMfrff0c6fqYelXft2p6XeGVkF7OtN1D6jhFIkQUon268XtkX7yCZG?=
 =?us-ascii?Q?hq95R3dxbGJu2fEhDPt+RPmGM+gv6+qbfxXqb5FMq88Y3Xu6Tk/rnObgkk+Q?=
 =?us-ascii?Q?SfBIAy5iq9G4Ot/9mxe3Inbm8w9t5/QjfCkYytY7Ng77r8tnjL49fST3CYf/?=
 =?us-ascii?Q?SbZXMVv7f8ggST3ifTMrzR13iW7Z2A0Jtn2FBQLDXMLR0dyXHKC3sd5/h3wb?=
 =?us-ascii?Q?NffsXSgiR7abF/J286RNGAgleMxUYltlXA7aLMgUmkhJGQbIL343dx2DosyR?=
 =?us-ascii?Q?qF7BE/ZnKhsl5CYijKGnbWqVZyUvj1VD8BUh1EDpQ5mJp9DrTyLO/QpV3DZg?=
 =?us-ascii?Q?cC36xyXrTlzF9qdlN5sztsoXolKMQ4ik+94mnhAemjo3PQwFULBJZgRCEQFA?=
 =?us-ascii?Q?yvEFjX7ujw1ld99cmym8Aji1oFWgpuNnHa2elDhXXF7UI8Ljiw4zVbh5cNOb?=
 =?us-ascii?Q?jvzkcOwY53zi4pG0HFIw9A+btn6k2LXWNSOUPmUEB+flX5BwWkszEoLKbsOd?=
 =?us-ascii?Q?dLXzGqKBfHl3MihC8AOx+ci9gKiAPvOa/OSGZlHNdKYOMQXd/MqLmkn8jgNE?=
 =?us-ascii?Q?UaXG6F4Ng5q3YbNQPNAOYTvUiqHqQVcDgfkTp02fhzR78sagQdUcte0JuP7t?=
 =?us-ascii?Q?0yJHbkAJpZ9UIQ9l3AzjfYnhZTaSAJVxkVDCTzu/lkdTX6o9Q54cRPL1niBB?=
 =?us-ascii?Q?BkTMWd8IFER3/5FSx5Sdq7CCYZdTbJLksduOD82uqcZA2IGiyAf/bob5yEh9?=
 =?us-ascii?Q?eFGfdi1SLv1ZSC3FDiHhcAtvXHcJDH0=3D?=
X-Exchange-RoutingPolicyChecked: oITL9kZa8B7QO4NZOXZ1NSzVzMZ408aZBVb906JpyDC18BCCJmdAbAJvi7fC1S6+tBOFzl+RztJljGI6iVukYpvVKkLB9XA0Fa07NkKGBHsv551/h6oBjvx1SoOPdQJYRWKK4FxKX1b4ZVWmNB2QeBxATs7b8Z++1r0pjXlM5nVYvRv9m7lzB4Tufzdxm7kGMnzlAjSeCk78s9CmKSDCqnKu/Y9Ha137NYJvEmpt6YWAFfatTinpQ0AZJg+jZYxh8YAYuZyP9h+Tft+EfEcbJrngpQIO0UnE9v6pqm9VSElKIEJL3LipVwQIXPhR7xGS6uIqCPCnxxOHXr+g4aRByQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b8a081-725a-4e86-a91c-08dede7222c1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:58:12.5680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBUbcM5323PNge2vsjnToHkEB7tko1F84NO/DQGsaZcqBcUrE1NHi3DE4ryHhbwnheyga4fqDXD/d0HjNLGBeL8s6xOKljdUe5h0RLShgMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB187491
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

On Fri, Jul 10, 2026 at 11:55:28AM +0100, Bruce Richardson wrote:
> On Tue, Jul 07, 2026 at 08:20:45PM -0400, sandeep.penigalapati@intel.com wrote:
> > From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> > 
> > This fixes two issues in the i40e Flow Director flexible payload path.
> > 
> > The bitmask array bound was checked after the write to
> > bitmask[nb_bitmask], allowing a one-slot out-of-bounds write when the
> > number of partial-mask words exceeds I40E_FDIR_BITMASK_NUM_WORD. Move
> > the check before the write and use '>=' so the array is never indexed
> > out of bounds.
> > 
> > In addition, i40e_flow_set_fdir_flex_pit() programs the global GLQF_ORT
> > register, which is shared by all PFs on the NIC. It was called before
> > the flex mask was validated, so a rule that is later rejected still left
> > the global register modified, affecting other PFs. Validate the flex
> > mask first and only touch the hardware registers once it has passed.
> > 
> > Fixes: 6ced3dd72f5f ("net/i40e: support flexible payload parsing for FDIR")
> > Cc: stable@dpdk.org
> > Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> > ---
> >  drivers/net/intel/i40e/i40e_fdir.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks.
