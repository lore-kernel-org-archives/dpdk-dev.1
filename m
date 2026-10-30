Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860A6606A326
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DlC0QnUl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DCA640289;
	Fri, 30 Oct 2026 18:54:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 0BAFB40288;
 Fri, 30 Oct 2026 18:54:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793382862; x=1824918862;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=x9f+TGLhGUXvnM+ah3TFiT8RjbGTaGXU24clU3Psut4=;
 b=DlC0QnUluLeuam6zJPjkayw6Tn2fUAFHRi1+z0wmjGV1OCh4AmNQ4tEo
 FCkRb9aBb+SQ3HIPw5Av6pFOLtXf5u1xJCO6bRc3wtV4ApVXbuuEDA4A8
 +BDIGT17pLCCSmRpUKXCM/ZPQB4dTdb9OfTBMEmg7+wSD/kAjfW2lN9fP
 /XZgh9/oXY2cwotxo3O60BQNlHM2E4gsG+Up84ePc3V2U/Yp1+8szf9K3
 Qp/rRfojKViQQqNEIMWbdTxjTGbBExYS7bX6VNmJmeprXIsgyxbudRn4T
 ABc+254kwFpfl5O8RWpD/kkpuNIpXyHlgXMQjsudm+/kWIlv0in3OYfd/ Q==;
X-CSE-ConnectionGUID: aulkRJtDS2KXaYvJYD6c9g==
X-CSE-MsgGUID: Jo7DPPoXTSmdtweLCg6haw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2158570"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2158570"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 10:54:20 -0700
X-CSE-ConnectionGUID: E1+SkJhsTsqEr9TddI3LfA==
X-CSE-MsgGUID: XoDuZ8nVRSWzdg9j5D4k0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5382730"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 10:54:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:54:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 10:54:18 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGAiIip0aNraZMSQREnDWfYn0uyMkRWPKlbHQYtQPnQM5UouBRfBRFVVvLndHCYx9PDv5QxPQ4rQVL1UXhkLuwdUIsi8re0UMDfIyu39QD63JOXg5XlGvRGnV3G14mQSgSHNw099FSld4li50gc/Fw0w4C9VLtMrU/DX/jgQRU9slHmpDVAIUO9AoROoqeTmJtUtCTFOAdacExTpZG4+/I7I6achtkb0GndE8FMnpZl6r/6ZPiGtLZ+l0s7+Z7j2V/mGzqqiBq3e1JDAVOsqJGaX5ViuriuW4/0F6wqP8ccDhdSINjWpHJchEFIDL6A6ajBrXiUNCzSxhGCdaOa58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRA2bg2nCEFLTQ28HgyK3ipFb6zyoNmHUmmcdlBUCQk=;
 b=RCxPi6KaYKNygU0DU6Y2NLYJ70MPZMFuFZCRmKIiUXiXiqyUtceKUcVPFy66sbMbysjIxFZMkB/5bKBJ7vfCs3KFn2iFg9B4g41aa/5FwpX7iA9HRiO0yRydQBV1IIYb5+SwSYCPPt2SCYtWzfxD3RtvexBKa3XpmViuwPd4bBVw14G7+XK8+cEvQbCqawV/phNcNN5XhbIarV7lusGpU/YaCwlU5TC3FaN0cg13woN66Ke16Yb8XW3vYmFqHR2ekfp/Dw0lHFExYTYTbciY7r6wL9t0a4dcG2gq++PBAXSjP0tfeyOanvJahkcPJ9KI4F9ocslMc1vnvEsjjWMB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA3PR11MB953716.namprd11.prod.outlook.com (2603:10b6:806:536::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:53:16 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 17:53:16 +0000
Date: Fri, 30 Oct 2026 17:53:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>, <dawid.wesierski@intel.com>,
 <marek.kasiewicz@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v1] net/ice: fix read clock to use PHC hardware time
Message-ID: <auTZhrPBTJATIor_@bricha3-mobl1.ger.corp.intel.com>
References: <20261030143842.2745225-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030143842.2745225-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU7P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA3PR11MB953716:EE_
X-MS-Office365-Filtering-Correlation-Id: f90796e5-4566-40f0-d851-08df36aeacda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|11063799006|261009223027099003|261021135927099003|261022075727099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9koGZRPqbV+O/sCpHup/QX9ph0WBYd6GqsLO8f5fjj7qTrBRVzanPCcOibJqWn/UfK1ulPbG2geZc5X42VlsQMW8cxljQ8punSsYMMzLIY7exijVv5h7xYFzLRLx9TugyvnZzCAGpLlVL1lGsIR9VKfMczCyI1SsGFtE79WtujdmMCs5nf/S5nwlpOLwNfZSfVXV1rmx1TkAzchqQ/v7AECv8/L7JEqhHO+4HZxqDStZ+/REWjGKv0cPOAaf+I0NDrahLyG7if4+2TQPJadqyReYaIgdj9r2e+vLNETqi8lXPk/hyV+fEqvu5xWjVz6cXPSs1WOmDNMlBKUAfkayl1CSHrogiezxk4bmKInG6ceBuXWwk4RZ+sC/Bu5erAFmnBCMZTtzHA5yln0/wTMx8Qb7tZgO8MbWjSQcwQs6oCCHgbuWz9pfwE+bygRRk63k1PuhHJAUnshozl4VyjOnhfhnL9ZcJYPPWI6k7/Etjl6ANEGp19aQS1sviuhNLKr9at7fntaF4LQOuJMYFjlQyAirmd/w2DB1VBUbUIzie9QjaWpFvN+xyuVePMGqFoFJ3QoytU22mdwAkhaMG2nTvWPRl9P2AkQFSiduGZF2bzzRaJhnLuMa/cam+PJTV4KuXSLWGZbK4ZaIJLCQ8QMWuuj/QCoHaPjZLhy8crXGGm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(261009223027099003)(261021135927099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QOdFeRMYadAi2n9m6avA3DzttNAWkxvnrOv/Ak9X+X1dy1LuheBa+0e9JmR3?=
 =?us-ascii?Q?05/nVZS5d+597WACpsr9JlvcPhGpSQKkoulHAkrILJq/4uK7cZydvkUMGKzC?=
 =?us-ascii?Q?PmOl0F1fEEuotfu3to5ykXc4LhtlUWJ932qbhVMfPZiFTQbTusPO2K54wxkk?=
 =?us-ascii?Q?dZDf6lpKm557r60MfdVA7WRChXzkVuwajDDn7T84sVcOMtqAZCXIB7/SmdtE?=
 =?us-ascii?Q?3jy3iiKYnizcGEiI3quilEuG5cf4T+eZjtqAoWRYmFU8JZtfOXQnjhnJ/ZqL?=
 =?us-ascii?Q?0tH9t32v762uxcqhRbPofn9h9bybVh9MKJss6RnnZ/YgMAbVJrqqze+dIdar?=
 =?us-ascii?Q?eQ3k6iAxQSB2r/e7VWEEzgTtAAv1wyHIlHxMzwLOf8kd6B2qLB4EBE7N39Dh?=
 =?us-ascii?Q?xmeT1yYk17T74P9EgguymiEANCHxXjOZTbjqdl+Guoc86UGSZrv+gwYTGuNH?=
 =?us-ascii?Q?9lGNVSfRvec+/2yLS+yknjugr4gsmcXs0Vvowv9ZgMTgbK6eLXv4zrfykfL7?=
 =?us-ascii?Q?lHLpoYo58LHbOR3F5X8L3nPrJjGz4+uR1eoLySivuDg2by6lWP61pskrgrRe?=
 =?us-ascii?Q?mZrKPS0tURDALGkTPuVAztf6+wF0Q94NkgTrpZoB5Zo6nghMHqSdwBHmWOQQ?=
 =?us-ascii?Q?+Ue8qLW+Ja5lV6/w5c4Ej9qe1XeFlpTx7yBc2u9T5DvKw9ru0JHEFrVPEVo/?=
 =?us-ascii?Q?9MdvICQfNH4iZgr5LhCX6QTnMam+/Cfz7/ii6E0wc4f21g2TRRww2cqYOdM/?=
 =?us-ascii?Q?kZ6WqDQMmnjgdNSmtIgbXbtxRjqKVajpGH72rGhD17X6JzXCUJhf6EzCfh7g?=
 =?us-ascii?Q?dQLf1kmOne1+3ULFa7jjdAOzt9XJEaE9sV3LC7j3iDYSec1M/6fBtglTwThv?=
 =?us-ascii?Q?hNqM6TwVfnFg+mJCR9AggHqCj9qjBMvjlGJf79p1IaFk1GkRatN13O3eB5Yt?=
 =?us-ascii?Q?neawudlY0LYtZ8zt40ZdwGcgCE+GyTUzBe05paS0EO244sQfBtgmf7TVxmGe?=
 =?us-ascii?Q?6YE2twNFvO7I/tHlDg3U0zwZT3oJoynjr+ot3kyf0zRP+VrZ2A1rOXjrrBkE?=
 =?us-ascii?Q?0ivzztgWGxXyeR5pGOE4nBd31bFXpB77MvGc7FBHeBOvAdlP7dmjEopxwfjB?=
 =?us-ascii?Q?cGpfcAGwL3+/8MndBXhAPl+l5+HoMS4xwAqh1PryADkLeuz1OtEUHOBTARPD?=
 =?us-ascii?Q?wxES1n14/RZi4OLp8+o1X9JtFbOaN2f1HumSiRQ3yvkUiqytHKw6zqcRl89j?=
 =?us-ascii?Q?URY3gOyn6QNr8VyFb4eTwjDiPwnPQnUPEyDAAZygS1wcN8G5y6tBzSHsXvA/?=
 =?us-ascii?Q?McesndyNQ7DOy51DfMiVp6VyZLXEjjbY+QPf5I0eFy2yLlkgaGyrjsuZTuYD?=
 =?us-ascii?Q?4lsWXZTH5RtB3EGepF1Q4kpYCbISBlv+i65CWPacpSUiSDmC1UFwz+3/ifPV?=
 =?us-ascii?Q?vQIyk2n7aJbVPVAUnCrtwn7W0V1zqNQSmB3a+XGj38Yvkblz54E+145jOfSB?=
 =?us-ascii?Q?usqrCBkja6ffGEJ6T99olL2qU/VJazUpy6WrYFS2bBxw78np5Ua9XL4QM5oc?=
 =?us-ascii?Q?t3BPyNgd+T7sVyg5JwpOyObGebxE9vkO5k1vWmnR9cV3n0Vxny8htTa9NC0b?=
 =?us-ascii?Q?LsEpmohIyHFCdcrraqN/guu1K2VkmDKEUzzsxa42Mee7Tpt6HMs0V+LiP3hN?=
 =?us-ascii?Q?TMlpXcfhOtzEBwItkR+cmzlvtPuwzR7m1dTBr/Hz8TO65f8qtVCOGymi28Sy?=
 =?us-ascii?Q?BuER8GNE6kvWKvan2qocBYrOM3Wt1j8=3D?=
X-Exchange-RoutingPolicyChecked: eVk6dYnV6qLNpW2ZPsaICaDFcRywhsaOvXA1ZbxgOAZxQ1bdJ/IwJRdpaK6DiHby1xZ6Iqf27n+dL2TDZKWaZBsBQj9BOoTosalg5xZ7XeR+5BsOdRJG/T7yHmWSGwAGMAQb9wNrgP94q/dDbOK//m5j2Tv88XrpWKEkYatGw8eLWWVLKs9xvbEPVZabUOW9tnCZtsqvNKDWOjQ3V4Vv3RC5BbXr0LD8bNP9v345NKWIufNV5Y+ncEcwR7S3SJEmQLHG3Ak4j4F3sSZ0HkRpGmcM3I5GFGWZro8LFKF3TFlSQzoql7snj2rpQUeMGLItugRgI5sUEbk4rcR2NHFooQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f90796e5-4566-40f0-d851-08df36aeacda
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:53:16.4001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAYUCXtCR0dG6iOsONxunlr/eCHoRN/BckIFS6LZxtPVIOKIZmXlHQapjDs60KQvq/nC25CkTYms9ZSBskQbylg8rex5F4bMNg5bvFxWy7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB953716
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 08:08:42PM +0530, Soumyadeep Hore wrote:
> The ice_read_clock() function was incorrectly using clock_gettime()
> with CLOCK_MONOTONIC_RAW to return system time instead of the actual
> hardware PHC time. This caused txtime scheduling to use a completely
> different time base than the PHC, resulting in all scheduled timestamps
> being interpreted as past time by the hardware.
> 
> Replace the system clock read with ice_timesync_read_time() which reads
> the actual PHC register value, ensuring the application can compute
> correct future timestamps relative to the hardware clock.
> 
> Fixes: 327fe144ca39 ("net/ice: support clock read")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
