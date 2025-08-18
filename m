Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D09CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2D5D40267;
	Mon, 18 Aug 2025 10:18:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A44E34013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755505097; x=1787041097;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PWL8bNe7eylNi3/V9WISB6SGiRWjjx89PdSMjxJyrf8=;
 b=ZXinSTc71prtEROelH7LON/GaxEB9vJFgzSv+/yXBZnRW5+G16jNFFrV
 FFshcVqAojBgjWeLlIJQ56mvDrko+2sCSuI7CbrUMLq2EWUpgkKwXZFgJ
 jl9o3N0whFavmBFbfg3+qGTatcy6s5FfJv2urWG2KNhDMmaZDmySY/6Do
 CaNi5NYOddIKAAukrTdyFD0YA1KdEJCv1JM0UJArJtw6j0NBEuVu8xvla
 zX4NaQQ7q7LcgD3D/z6grH2pE8QXpmDjJmmrh2ldkmkzmTHlPnCbAgnxQ
 HqQvQSPmCL4ejdxeKJdvHfvrRN8sCCjX2YMEw5QzDHd66tTDWntrDTjsy g==;
X-CSE-ConnectionGUID: PkicqkFzQIWAWTSk+x8/Bw==
X-CSE-MsgGUID: y82PsqYnQ/2kAwjTG6NLHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="69095143"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="69095143"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:18:15 -0700
X-CSE-ConnectionGUID: JdP4do/fQVe/7P0WsK683g==
X-CSE-MsgGUID: DzlQ/Ac/T0W7vUBXWs7xbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="198367104"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:18:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:18:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 01:18:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:18:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEd4nr89/PQAy+tJdtikVEIcQphpTJTrbhScxZWYY1rFv0K7P075H5wOfX437+ueCXe23ZO6yBBevU/CL/2nUnCUzBwGE8x8p9Agk++3805Icw2IQxGg+fFc2EzuToO6sOFRmuoPVP+Sh7YGC/MrPzM1ogwp+9HF9JzHF2DpFsLaXiMNn6a4r/qQb7WgXiDOLQSehutxFHWV4EMdlC/NoXnBQ0xAhOkjA7f94q7dJFSyazbW08L3jhlS6p1erz4OqS4w19JEaLVXdxw1DvWhHxtRZmdQPPW+i9y9QWKv6eWvZjuZ228PddP94bIHr9DStK0szXcryx9SHEGJL//mPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=404hzc5M/Asgzz//vpytzgr0kSgKyR5jr67fT9uv/Cw=;
 b=vJ5t5lpNO0oVaMERBln0vgavP2uPTyHsMNIgoekrsHZVB4lbRY2pfxY61mfXTThnnNNfcWfwejHPhC/TMbqysNQKjzQlxs2t1y5HhdqkSBOLfa5rwWzT/c2TMd7ukK8qLEvShRTGftWw/mtS1tjWXJmLoaZg04ruGtZzm/b107SbGuKhEUcj17XtmWYQrcN3qkWSEuck0gXTvplqSF11fql6eCsfv3jaTo+y4vpax61LT6kUknT8Mx/9sBEmh0e/zESsGnDjrY4ajrNHvaHFzJyhVAUR8jt/TUOOxMAySUhyMtdvh7aOZw1oJIr7ltZpKgEVVoGTadYeyBCmewfjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:18:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:18:11 +0000
Date: Mon, 18 Aug 2025 09:18:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 12/15] net/intel: introduce infrastructure for Rx path
 selection
Message-ID: <aKLhvoclHxDkyVpy@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-13-ciara.loftus@intel.com>
 <aJnVvjcg_nhgnesS@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A14E9758E3D0F2CCE373428E35A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A14E9758E3D0F2CCE373428E35A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0318.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: e0652c1a-56fb-4496-352a-08ddde2fc57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pGDBb6xB93LVQfm5PbS4BurEZUBnhwhpuLYZoGoPCs2/7mAIoorOxQrSOQOv?=
 =?us-ascii?Q?Z1+MbdtBOfF+X10MLw2bKz6Z6ZPR05vjZkbnNRqtBYB7c3jWYuu+5cL2yqjn?=
 =?us-ascii?Q?B/aDfHMSKhiVMZEqVEFgG9YcuchbdSp/u9tUy6FE04XwNwPJISj0iUvlkb6g?=
 =?us-ascii?Q?0a2nMdgz71WSO5ESLWi+gaLiKwQT0J/tKhjT/8UX9rqf8Atthzj7X/cPXYvx?=
 =?us-ascii?Q?VAcBAg/FCvJ54dReHz80Z9wR06uQbFjMxtjBE7aNZ3JC7kAQivWlbjH5nUsM?=
 =?us-ascii?Q?99myJiEEFPxdhUDFWSq5eBIRZqIyxXxMbhXmRoldWd0weK3cdR5Nn8wBFJqJ?=
 =?us-ascii?Q?2tPx1Oelcdl5U3vuJpKN8WfpKiKYrFt8L7TpP/xWNRAfj5VDygc4lKo7v456?=
 =?us-ascii?Q?+p4VvuYIG6JLfycAD36yu8Glrotpqb31ioD6G7O2bHQd9AJ6LyA7WnDRBu2D?=
 =?us-ascii?Q?NlO+acF3lI5FY6Stwfgrii/Fm1llg9NbT65IXMayoNkoxJ5HFl++ue1ok2sU?=
 =?us-ascii?Q?tO/GwQgGTqhj7MVYC24lHoct+v3L+hrZ/wGiC8ffKTOYyavFIUT2IpwjRKRt?=
 =?us-ascii?Q?v2yLsfTflxJ1R8v4XvcO/YHqGgpUh6DLsMN3L/CfJF26VfQD0Qagp84DbJTz?=
 =?us-ascii?Q?XuqoYNjy+Sei5Yh05U1E8mltbww3wIc8exdJm4A6mcQB94bl/6LMho9O2zvY?=
 =?us-ascii?Q?m7Uy5UNm2ZtgJyyB+QQ909Bb5oEHaWI5Yu1XB7XuFXUvEfF1H8bN9Rh5rlx8?=
 =?us-ascii?Q?6nCvRXEbmNFQAhqb4Q1r3xRAnMH6XVmWH9hbxr4y2IDSWDyPWi+mrH5zU5Ew?=
 =?us-ascii?Q?aTOj47OMZUFKy17/v3Oywdn2MInz6ZXCDMg4S+FhDBcUYliRc2Lg0RCF/L0P?=
 =?us-ascii?Q?zGBd2NKj7tnuPhyGwNIvSf5gZpPWf6ifHum3WWy46Wx/cYfWy7oIdzgXNipK?=
 =?us-ascii?Q?jr0+VBwxNltBjPwN772WKfIGlLPf2oni7FSTM5PcU2IVlvBlvK0yhFrbTorg?=
 =?us-ascii?Q?4ipKDfNlGAIsQ/rOfPViqfnBbTBIHT4FShjMCl0I8npTliSRtvdsAlozVJtX?=
 =?us-ascii?Q?WC7LFCr7wFYr8T7fqjaDqitHPasC7vOgZ9Y63rnnPvykfZubCxXj0kAswVg/?=
 =?us-ascii?Q?+n04mcXT0w/pwD0vtOeXCmM0AjnIL7rNCaIseNSfMBDquFowBMu1OWFa1mAF?=
 =?us-ascii?Q?5t6zAxs4kLKCSPjoDb73LKK9khOKOMwOr0nAAgl2h5834iaseTnf2TUkSBev?=
 =?us-ascii?Q?yWObNHkQmD4ZPGjYkXx/70NUzbNIe8Yv0rOcllWrALTwQdNF+NGa7CzvV2TQ?=
 =?us-ascii?Q?H4NseGgZTnnppb4WwxtO5kOnwo7I3Po6RBc7p7FxVP9HdefRGkVRCPSYGdaD?=
 =?us-ascii?Q?IkGCHSocry1sLboYrMySC7LTtKX+4il/sckIAhZFN4cL0KWq/25BSPjcNKPL?=
 =?us-ascii?Q?L2BcAhoXZkk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/T198V1Zm6UhiM7zpq4JZu5pBNCWErnwEC0kZLGy3vyoiF+Nu76c7O0r5Blp?=
 =?us-ascii?Q?4IjiNjRk3kUTUtgkBoL+76d1wOBb6ks0MMo/7wgSuL5H1pw0YxTqBG19kLo8?=
 =?us-ascii?Q?BN9jC1BwjGhrmH0W1CIY93HWluUKWqxlS/wW5h+etsopeyBqgL7B52REE6Q4?=
 =?us-ascii?Q?wK5+QdSmyoJ8Y49QB713JUb9qgNT061wUnZe9UMoWRZ0+xKlI1tEdQ7DqWPn?=
 =?us-ascii?Q?0lnxa2yPcsA2tcpJhVtYg/Z6s/GlVT8MFIO1+e7IejVP32Mj+3Sq8I0qkYal?=
 =?us-ascii?Q?875mJvchq3vWJppdUqZEF1xAIUDzzUE/MpSGAnXtknKhFWqIQxyw69aJy/y9?=
 =?us-ascii?Q?cwaQhzkokZr0YXBqDz71W7H56FjUbexXshfLJlObwxE/XkZfU8h0mugvbvqR?=
 =?us-ascii?Q?rtsiba3+YGlKoXt1kKogWibqJfL11u5a+HlI06OL+32Yd4sHz5BC4oWQL1O6?=
 =?us-ascii?Q?rw50PQOeIIlv6T0jKGDRsj7RKU4Jn0hdDGYHyXGb2TVR1Gbvv7qGDCpwvcCl?=
 =?us-ascii?Q?2ApwyHGY4aHhaI4+/qSHcUQBlY/2A5r5+xblJR1J2xiHYRiOSHPevR+8FVEH?=
 =?us-ascii?Q?3Rlv4O/bWD9inRntQur7m2nu5nY3p1ZSfQPKFTzyNfgLVjHiCIIfcZiKwXz+?=
 =?us-ascii?Q?6s+/SqWQV6WKx642ycyutlgMRKG+5e1C8nFJVTj/NyVO4alxk/TIpIUcydy9?=
 =?us-ascii?Q?M4EX3TUUuL5XtJwXtImNVd4I1fyuOt8VoSBrfwK0peJphqS1SRkgJSxvAjjT?=
 =?us-ascii?Q?clP2BFa0w4+1e9l43vZsr+OdCqwKwkKR8hrAfasWtSdlFJtQan2O/EGEwWC/?=
 =?us-ascii?Q?Xlppzk4Lf/E4bdEaM1lgypNvJu5wJU1nTIgl7yLbvAGbDGh25+3NptwizEpA?=
 =?us-ascii?Q?CqlSPWf41T0q74UUmXWjIX4hxwXTAJrfQo2WNJeFJ+IUDbYTXMMXF8fCHBOf?=
 =?us-ascii?Q?CTSk1qTkDxZu5YHoYXG6Thvy4418HnbW+Tqbj4AJci03X3I45FYNRe7FmwQf?=
 =?us-ascii?Q?Tiy5tL6zXDGuu0KdbdoTPUUiPtTyxe7OWw4uMZGf46ULBRZgi/+caqv30pJH?=
 =?us-ascii?Q?J+oCk76ci442c+45q2CzmU3dwRj0FCDV6FTrCb4QgCLKOloHNXt5ml1FhozC?=
 =?us-ascii?Q?o03WRy0bMSmQIoMRKyUl8be+f4EH0RpdGnEe8e1+6lbE9ObZG3UZ6PaGlHWE?=
 =?us-ascii?Q?Sn1V3EWd5genr5DNKoWnB+T0jyhCeijujpkzuGSwjuQdGe1/Ww2M9KYUkPce?=
 =?us-ascii?Q?PgLL7Byzag12KQo37krlfuYLleiI74VxfbaHitlvFd+HdbACGaw6zNips7MB?=
 =?us-ascii?Q?2BYW8XYwgLKkkGyozRGBpRgxuJAmc0FEUTueMFvl38jg+kdEI5NzmD9wdRaL?=
 =?us-ascii?Q?WZeONyRIv/q+zHaaDZyQB+7q5wtufgKWz0rqaVAa4Q19IG8aILc4HxidSoav?=
 =?us-ascii?Q?1pzpwTsobe3GnZGrbVwtBptA/Gzsc/iBEq0pRg2kwKyiTQ2sLcist3BX37Zr?=
 =?us-ascii?Q?IQ4Q3LT9hnSYTEgWHi1qpD5L1tH5pEyG9fMNrbdJMyOxv/U8Cx24+tgCWxm2?=
 =?us-ascii?Q?1Jy5t98wO4uXDhoDUfLnJ1i/4UargrBdNnIpfBkazaQttWjSL5qd5dcGJ8OY?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0652c1a-56fb-4496-352a-08ddde2fc57a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:18:11.7156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r03BxE8hzcBReMPolaew6cQSw7whH63XPOLsnOYvMdgx1Mt9kA/XKD58EiTm6kPvSMJ3UqdRKWabDHQT/86SYqwkboKykAIE0seXfCSq5U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
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

On Thu, Aug 14, 2025 at 02:35:34PM +0100, Loftus, Ciara wrote:
> > 
> > On Thu, Aug 07, 2025 at 12:39:46PM +0000, Ciara Loftus wrote:
> > > The code for determining which Rx path to select during initialisation
> > > has become complicated in many intel drivers due to the amount of
> > > different paths and features available within each path. This commit
> > > aims to simplify and genericize the path selection logic.
> > >
> > > The following information about each Rx burst function is stored and
> > > used by the new common function to select the appropriate Rx path:
> > > - Rx Offloads
> > > - SIMD bitwidth
> > > - Flexible RXD usage
> > > - Bulk alloc function
> > > - Scattered function
> > > ---
> > > v2:
> > > * renamed various items from "burst" to "path"
> > > * added missing doxygen comments
> > > * attempted to improve the logic in the select function around the bulk
> > >  alloc feature
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > 
> > Two comments inline below.
> > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > 
> > > ---
> > >  drivers/net/intel/common/rx.h | 103
> > ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 103 insertions(+)
> > >
> > > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> > > index 70b597e8dc..6d134622e6 100644
> > > --- a/drivers/net/intel/common/rx.h
> > > +++ b/drivers/net/intel/common/rx.h
> > > @@ -10,6 +10,7 @@
> > >  #include <unistd.h>
> > >  #include <rte_mbuf.h>
> > >  #include <rte_ethdev.h>
> > > +#include <rte_vect.h>
> > >
> > >  #include "desc.h"
> > >
> > > @@ -125,6 +126,26 @@ struct ci_rx_queue {
> > >  	};
> > >  };
> > >
> > > +#define CI_RX_PATH_SCATTERED 1
> > > +#define CI_RX_PATH_FLEX_DESC 1
> > > +#define CI_RX_PATH_BULK_ALLOC 1
> > > +#define CI_RX_PATH_DISABLED 1
> > > +
> > 
> > Do we need these defines? They are not used in this patch anyway. With the
> > values converted to "bool", using true/false should be fine I think.
> 
> They're not necessarily needed but I think they improve the readability when they are used in the next three patches when defining the features of each Rx burst function. If you don't agree I can remove them.
> 

I'd tend to prefer assigning bools to just true/false for type-safety and
type-clarity. In terms of readability with defines like above: if we do
want separate defines for scattered, flex-desc etc. I'd tend toward having
them as enums and the variables below typed using those enums.
Unfortunately, that's not really feasible with the struct below, because
while bools only occupy 1 byte, even a two-element enum would use up 4
bytes per value, which is padding we cannot afford. :-(


> > 
> > > +struct ci_rx_path_features {
> > > +	uint32_t rx_offloads;
> > > +	enum rte_vect_max_simd simd_width;
> > > +	bool scattered;
> > > +	bool flex_desc;
> > > +	bool bulk_alloc;
> > > +	bool disabled;
> > > +};
> > > +
> > > +struct ci_rx_path_info {
> > > +	eth_rx_burst_t pkt_burst;
> > > +	const char *info;
> > > +	struct ci_rx_path_features features;
> > > +};
> > > +
> > >  static inline uint16_t
> > >  ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs,
> > uint8_t *split_flags,
> > >  		struct rte_mbuf **pkt_first_seg, struct rte_mbuf
> > **pkt_last_seg,
> > > @@ -222,4 +243,86 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t
> > rx_free_thresh, uint64_t offloads)
> > >  	return true;
> > >  }
> > >
> > > +/**
> > > + * Select the best matching Rx path based on features
> > > + *
> > > + * @param req_features
> > > + *   The requested features for the Rx path
> > > + * @param infos
> > > + *   Array of information about the available Rx paths
> > > + * @param num_paths
> > > + *   Number of available paths in the infos array
> > > + * @param default_path
> > > + *   Index of the default path to use if no suitable path is found
> > > + *
> > > + * @return
> > > + *   The packet burst function index that best matches the requested
> > features,
> > > + *   or default_path if no suitable path is found
> > > + */
> > > +static inline int
> > > +ci_rx_path_select(struct ci_rx_path_features req_features,
> > > +			const struct ci_rx_path_info *infos,
> > > +			int num_paths,
> > > +			int default_path)
> > > +{
> > > +	int i, idx = -1;
> > > +	const struct ci_rx_path_features *current_features = NULL;
> > > +
> > > +	for (i = 0; i < num_paths; i++) {
> > > +		const struct ci_rx_path_features *path_features =
> > &infos[i].features;
> > > +
> > > +		/* Do not select a disabled rx path. */
> > > +		if (path_features->disabled)
> > > +			continue;
> > > +
> > > +		/* If requested, ensure the path uses the flexible descriptor. */
> > > +		if (path_features->flex_desc != req_features.flex_desc)
> > > +			continue;
> > > +
> > > +		/* If requested, ensure the path supports scattered RX. */
> > > +		if (path_features->scattered != req_features.scattered)
> > > +			continue;
> > > +
> > 
> > I think this test should be in a similar format for the next bulk-alloc
> > one. After all, if scattered Rx is requested, we must provide a scattered
> > path. However, if scattered is not requested, a scattered Rx path should
> > still work fine. So:
> > 
> > 	if (req_features.scattered && !path_features.scattered)
> > 		continue;
> 
> This would be a diversion from existing behaviour. Currently we never select a scattered function when it is not requested.
> Like you said it would still work, but the path selected may not be what users have come to expect.
> 

True. I suppose if we put this in place, we would also have to put in a
later check for whether the currently selected path is scattered and, if
scattered Rx is not requested, choose an otherwise equivalent
non-scattered path over it.

Given that we are looking for compatibility with what we have now, I'm ok
to keep things as they are.

/Bruce
