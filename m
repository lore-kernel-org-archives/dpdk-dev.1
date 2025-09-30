Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C824ECCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 15:13:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 052174025F;
	Tue, 30 Sep 2025 17:13:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C0B1040151
 for <dev@dpdk.org>; Tue, 30 Sep 2025 17:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759245180; x=1790781180;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hWF1DjIRLR9wQerPnlQ/hfOO8nDhb7bhVcQd7lJxtc4=;
 b=JtFkSW/sDvBhrneBwdLfmuKeY/hGgyLF3IIBR4rtQTWj9Su5aavA1ATz
 BUSA7xoEPq0UWc+V16vxCJRVs3z5XpslHBsLgUUtXQqHlorJzkNj4ummf
 nMr+mN1VtTywlOa0GEZwy8kvQFFtPzy6Ec+nspXKTUp1otcYfhCMYqbAK
 xjIYXTlVJHP2ld47mrwvdnoRZ2jNTNHVSleI7jRaKA+eNejYo+nmJZf5L
 z2VirT28Rtsm/dB2XbJNg1jAfahBPjZatS4NDeVY82/hUPNwAwcI490ZW
 6SPp2sJUVtVv5Ky10KBMj3yJPzqaFMRE2tp5IC4oUPmSfDcOUVJlcKE4i Q==;
X-CSE-ConnectionGUID: bVxeO+a1RwGyDcRHA5dr9w==
X-CSE-MsgGUID: X09iKoAJSj6a+Yp3hUuRsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61612792"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="61612792"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 08:12:59 -0700
X-CSE-ConnectionGUID: 0LFlc6RDT42rzHK5eewf5g==
X-CSE-MsgGUID: dHxP4UuWTnSwiugY7WkRFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="177666670"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 08:12:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 08:12:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 08:12:58 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.38)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 08:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNWDlO0JAmlLSJzHZaFS3VlsLfzuS0hEP3l348j39WCtiQRqPJKjhYQnIGIRcn+vm0gJ7zDBGOaGmjSMUUDyhUWbmCL6Q7jjqpxraLWnkVhZ7nMp2RkPCBNRJRp5WL6UbmuCyWcEseH+tG0edYwAhq09KgSAejZfvhJdw9ukdYSZtebAk9Wbil7ZzHvbAW0ZSHZpxQXAn9oYx9dnsBYEyjhDAQ7+V413KbYB4YyWudSGjxoO0OIsk/Rwl/1r7vPXZYE3wK4ts+/NEVY98A38j0iXK6uGPLVsgpatjQWifnxQ2YdsVaR45ilPZ9REJ+pYRbXqp0FhcukbcS9xgq371A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy2RuhMAZ7zZmSYnoGMlXpwN5odsW7PnKiNUqrXTRJ0=;
 b=wp3qxe43BJwMEts07DVmbB9T9yC+aURJlduDIjiJMETiTUJwlEKD6y3qNpDFxZnZdAJFNkKi3vwaG3V1e2o7kjNrVLgHVx84Ljaa+plpO5lAl7JG/N87fGR71W+uiJ5q4o9qZKapSOBWnFX2YRcotUQ6axtIs6cWkUDPvRfLXeIVSMBncrYSIGBrW3HT7jY1DMB6VFAR4kFQAmxGlqHT0VwEl7Jg+SDJsgUZnNY7G9Sb3HwzRt6VpnVgGMglqone5muzoHAS6Lxahnr3CHRRlGklvNpYSHiN/SenRG8NJ4J0/N/+OyMtzJn3sZxVSYRYYssgEiEGtEOby6t42zVf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 15:12:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 15:12:54 +0000
Date: Tue, 30 Sep 2025 16:12:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 06/13] eal: define the EAL parameters in argparse format
Message-ID: <aNvzcRQjOwRkydn0@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-7-bruce.richardson@intel.com>
 <CAJFAV8yroWbRDO2CYBwvKCRkYotBEvA18aQ0HGa7HMJx5-nSig@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yroWbRDO2CYBwvKCRkYotBEvA18aQ0HGa7HMJx5-nSig@mail.gmail.com>
X-ClientProxiedBy: DU7P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e351b6-3bd0-405a-a128-08de0033d47c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SThYSt21YZcM6ymaPUXYAFKq5Bmx8ZC9IVe9WM7tALwOkgX0M2I3AykQqq/G?=
 =?us-ascii?Q?4ZfnXVE+p3QdpOxJw9O3o/Z3E5r4FS+zJClI+9LCVuz+WBEc840m5HtzuuQi?=
 =?us-ascii?Q?j0FJUbgVfit633VEcy4T3nRzbdOJDb9Q8r8gDStSv4iBbF32OAanNKzGpXH1?=
 =?us-ascii?Q?A5BuWwqiajSPSwku07jlnwRR59u7NeIb4zmYd+JIC8UPcjHPl0NA81ixRyXS?=
 =?us-ascii?Q?AWkDfmZmJpVQDKY5DaA8HoFrLIC/AEZWQaKF45bv99qNvAExyF6YTDIXGxZV?=
 =?us-ascii?Q?CNaXE+jBsb6opEPDu3ABFNWjlQjQbH7/P7mbSlCPbiuaQkIINmdxnCOKn6dt?=
 =?us-ascii?Q?af5ZptNcMhM0dfwJrLl5JEQqbd5GfpoF+2XiKwoOmnslbd70X0YD6xlSCUor?=
 =?us-ascii?Q?FWh1AIZJHf3hox2xhA7JJXIojvFHrsmTiPw2vk7oioiDBSv0fJyXi1Cfmxds?=
 =?us-ascii?Q?9VPYZz2aQm9mXEknxmQKdOQHlLamWGsixHBEKxu896q+AsMTOl39MPX5u0Lo?=
 =?us-ascii?Q?+M3PZ5cfGvpH/VOu5mpCAjcJjwuRNIyTrn2tTdlqdXrxWDLZUyeL7gkB032l?=
 =?us-ascii?Q?WpjCo593EhaMqOaGQEXobRYFNaPt96a3IbVHtIOtJVrrIQEjxgVRCm4drbx4?=
 =?us-ascii?Q?DyCsTvGGeHqeJAfZIJkmlKwCn8FNfimXgA8/kj64tKkYvNz3FH/K/pgs1oVs?=
 =?us-ascii?Q?CxUlGq3vb6L9vJTXUj1kxJWQa3TWDUIJ3yUc15g3UnedcpN+gRGXFgE+RzDz?=
 =?us-ascii?Q?hmWLy0G6dEhhvV3lQ6TB3EpZOlfzAQJp4ALEfjlCSjVUibAauwkuMHTtQxsc?=
 =?us-ascii?Q?un6a/08v2JV/HvDfO+iK8Dkp+uSFCID3XzDNdrLD9yMGc7Q/kVWFrwMnRhgP?=
 =?us-ascii?Q?nUbwepgiTP4Y9gaTtFr/Mp1mpFVSNQqqPejd0T4Dbmow7VSS620bb7EXDS0P?=
 =?us-ascii?Q?GLBOj+ZFQfwo2LfYtOQC2K9/qKrgmp8+eDPAbslRSHqnLiqpiWkplykYbN8E?=
 =?us-ascii?Q?ON39fpcF8AZPHF/Rdw4MNhfVxPzZRDZwyQCidNSqGV2tpWZAgclQjb5k9CNB?=
 =?us-ascii?Q?jpWEWLZNiUnZ4QqqoRxwqz5mvPgPdSlZOHN3U4WDzuuvMAEG6RI5nJW3d9Nc?=
 =?us-ascii?Q?UzEBYBk01pfgnv8s1VVP+ckxhWIm1GYaicFSk+c7dWxkjZeNHni3UFoH40Xn?=
 =?us-ascii?Q?LRXa5HJ64jnP16te1WSeT+dy7EC/zHVdhqp95us5jpZSAjLY+WNVhJfcpIOW?=
 =?us-ascii?Q?CrN0tCH9VU5yOgJcLABaU9SxTuZWK/gJ0mCjNXUrr1j5xEly5PQB3BbISGfJ?=
 =?us-ascii?Q?+9v5D8tPoROcIbv7xrKEesB+IlRQNGi5zrrP2r6eTAzAwgPKo1rVs602qzpf?=
 =?us-ascii?Q?3kR7ATNlJKDLEMj+KErhzcuagpZv54sksvQ3sqRnDsmT9beWjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+AOSQyN6ekgS1Gta92wxTrMAyb9ufTUNTwH0Madn7Qkf/yX7RCNuNgX8kD/2?=
 =?us-ascii?Q?cH0vQaPNbcnTVu8f91F7UQFnpxeNvkDdOm9YYQ3E43lclvuj6H1r4MJDK/xo?=
 =?us-ascii?Q?7uhrsZ7rAVi3J4RnCAqMkgvXMmPLSBhiqSU/6u7fgcBEMfbDpVqJRlNwXGJP?=
 =?us-ascii?Q?ip4NKMEtgrdnyUC7Vf02e+ZTXO0218B5CzKhWq7TbHKsU7Pww0XbqXVeVKiH?=
 =?us-ascii?Q?34jAZ+ZxWG8YCnLj500ve0y5HeTjBLSUg6db3/LcnSdsEzqic0ee+MLthJ1I?=
 =?us-ascii?Q?Xn1LAlnz0SJjS6zwE4TY+bgoz5Huq+gZNKwcWNxxGiA9TOfGCHUgvGLo5jfb?=
 =?us-ascii?Q?/CulPxbIFRhhVlD3o+tBFeTeeHDqwt5QDHIInGzROOZrTmkuOwq+UtkMGBLU?=
 =?us-ascii?Q?sTyrwbM4o6mPSCt0ncGMrl8AA9aksjgiNzIXry+Q615SHkTc+R7ZdzmrZI5q?=
 =?us-ascii?Q?BIAhc1uQ1nTzJvUeHlncaXM6h8XKBPbkcvs8g5f6Qw5XjECbHUsP6EKAmOLd?=
 =?us-ascii?Q?hYpA/19KhwvpsYAReugMroxLYLyee4lkN4C0Ry1wjWhEiKZcxXhp0G/vP9Up?=
 =?us-ascii?Q?b8Gc9TOuQnmU3nbaF+o/3IqtAKgPI2bCms8lKDdlJCg3RiuL6zTRmp4Tg/iF?=
 =?us-ascii?Q?lYySrn/Xo9YUbU2OdcYqeJUS6Pf2jJ3HiH3swEi4kADT7PXdIBzyhNLJ7gbw?=
 =?us-ascii?Q?AkdUT80JAObuEfXJDekdj9sLscwLAZzzMWg5VucMwmwmDZFpspZfOvttNAl/?=
 =?us-ascii?Q?9anf9JORAR8SFz26KBwu1ZWaNOLjxVXdFcLzwZ7YQgBPDVU3I0HqrmJBI58d?=
 =?us-ascii?Q?nXnNW+4e7w3nkFTNUCZQvtFQDuc45Jl/O+uRKQiik22efnBAHLWHanSlEJV4?=
 =?us-ascii?Q?L29Biz5+1RIlV1vMqKMD0Z2CWmT6fRs5fzQYT186LiLnPR3PC8APJQhZGSaL?=
 =?us-ascii?Q?cqNBRLCCwF/+QU4rphAnLggVndIiWJs8gxPEJYN2jMyItXRRSW3d2cO81R3L?=
 =?us-ascii?Q?zYWdVx8GgM7qjH/O0uuzwg0lfo9IE24PP/YF3pwSJy9icYyHZsmkizfH67w3?=
 =?us-ascii?Q?wmS6YIhgrgQSHJCfAK+POiykwRFDayvWDeRTjFsIrO9UJ8sfe9SrAVRBJ+Fg?=
 =?us-ascii?Q?RLAXo8eo7T0YlyMzGtD8tO8v8BA4nJi9AGhnogs8Uy0mGupVPQX81FfIdt7n?=
 =?us-ascii?Q?RnsxADFvbKEz3C+0t3B+DQ45yflcgi8yzDAt1dSTelZNIBDfXWAIA+0EW7nQ?=
 =?us-ascii?Q?ZIfm6Ye3w9N35OX7FNCNQ6ZmO9SxVocGoSj6V4Nm9SWgTwmQsqri5W46k6AL?=
 =?us-ascii?Q?FXlRXy41qDID6T4HC5Fs9euKKa99b/jwpHN/gAZWeNgxsqe5oewPEr6vA7/A?=
 =?us-ascii?Q?2qJ/w+b5a/7uhCa+FxhsU+l0uatq0x74WTpxJemwKT++go7xD4qa/4mEeKuF?=
 =?us-ascii?Q?pdYtk7K7WTt4kk6ehVP5iZFFOggwUfv7BDaQr488UO9246lAslA//sX+1Rb4?=
 =?us-ascii?Q?qqYED/T6l1AYmpjS7gOTykzxZGDnRtdJk6Ik5ppD/WTEGxuV7gQ9eU/zz5h7?=
 =?us-ascii?Q?E4dpsWy80fqK2LtDc+ky27THASB+ZItr9w3/ahDXeyQ/KNCVONVfxRd9cMaF?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e351b6-3bd0-405a-a128-08de0033d47c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 15:12:54.3537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXYcGjSw4nmXsnuXppc6BvGtI1UX2NZycfGLh+muwvhUQQ6zn77cOVrewfsto/NSUIu+xkYBK5Jz5Iu1O8rSKzhDkNousQUmQRHBSvB8V+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
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

On Tue, Sep 30, 2025 at 02:21:33PM +0200, David Marchand wrote:
> On Wed, 23 Jul 2025 at 18:21, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
> > index 226acea467..ebb9f7063d 100644
> > --- a/lib/eal/common/eal_common_options.c
> > +++ b/lib/eal/common/eal_common_options.c
> > @@ -28,11 +28,13 @@
> >  #include <rte_version.h>
> >  #include <rte_devargs.h>
> >  #include <rte_memcpy.h>
> > +#include <sys/queue.h>
> 
> Nit: system headers are usually going in the first group of includes.
> This can be fixed when applying.
> 

I'll fix in this version anyway.

> 
> [snip]
> 
> > +struct rte_argparse eal_argparse  = {
> > +       .prog_name = "",
> > +       .usage = "<DPDK EAL options> -- <App options>",
> > +       .epilog = "For more information on EAL options, see the DPDK documentation at: \n"
> > +                       "\thttps://doc.dpdk.org/guides/" RTE_EXEC_ENV_NAME "_gsg/",
> 
> 
> It seems this comment got lost.
> 
> Options don't change that often, but I would prefer we point at the
> right release doc, rather than origin/main.
> What do you think of:
> 
> @@ -164,11 +164,17 @@ eal_usage(const struct rte_argparse *obj)
>  },
>  #define STR_ALIAS STR_ARG
> 
> +#if RTE_VER_RELEASE == 99
> +#define DOC_SUFFIX "-" RTE_STR(RTE_VER_MAJOR)
> +#else
> +#define DOC_SUFFIX
> +#endif
> +
>  struct rte_argparse eal_argparse  = {
>         .prog_name = "",
>         .usage = "<DPDK EAL options> -- <App options>",
>         .epilog = "For more information on EAL options, see the DPDK
> documentation at: \n"
> -                       "\thttps://doc.dpdk.org/guides/"
> RTE_EXEC_ENV_NAME "_gsg/",
> +                       "\thttps://doc.dpdk.org/guides" DOC_SUFFIX "/"
> RTE_EXEC_ENV_NAME "_gsg/",
> 
Yes, that can work, though RTE_VER_MAJOR doesn't exist that I can see. Will
rework it a bit.
