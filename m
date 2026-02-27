Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C24FEFB56
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 14:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B97074065D;
	Fri, 27 Feb 2026 15:34:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id CB6E6402C5
 for <dev@dpdk.org>; Fri, 27 Feb 2026 15:34:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772202847; x=1803738847;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fDwPNkoNuJjPqZHxw3WHBMoXXf3pO5QHsoi7JZ14c5Q=;
 b=LPRjcBz8rrrtvjTchDITFms5hwPiRnaZRtFP2XT6Os43dYI2JRm0PYNZ
 6trH4U3P7c3QN1bdw3yPewYTI077QNXVNxgqv4nfESu1PzPpfLgWS8VPT
 /ti/u44O9ht8Vy54hrdpmyoBzaorn5tez5BlO2sJi9d2uMgSNOmrv/iEv
 WFWWn+Q42HN2kHz5e13SorixoFi3sSFRDFEYOCBjILKq47aLgBW5/fvf9
 QnKOCzPucn0Uo3/FNWbqdemvt5LOxicqiFr8x6vCn+kNQCD70AyDjvBOR
 mZE1pWVLewkMYGLaWJrB6r7NKN+soXTsG5WtALh7OmgAvS+K4XeBmWhGX Q==;
X-CSE-ConnectionGUID: nNGKh1Y0Q0WnRJGTBt/c8w==
X-CSE-MsgGUID: dPIAbaYBQOq6a5QCp9XmHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="75887876"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="75887876"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 06:34:06 -0800
X-CSE-ConnectionGUID: 7FWC95NzR7CCypfpFc2Ncg==
X-CSE-MsgGUID: mp9BtcDjRZCLmobmdWhkRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="216924531"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 06:34:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 06:34:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 06:34:05 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 06:34:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyQZUSiJ+i5eqJB9OU8I/VRl/GHt+ILq8RJZ1jMiw0Db4sshzwnRBmgYwKZHnRGY+q/dOlBUeUO9PPx0jve90dGkrQ0Ab5rF91pM1vv/m/0su33MN2NNmDUA8d4AFyjTIYmvMukr55NwkCffYhbTydUMny5EOO5rtZU4VVB7Pk6GJ1AwEAZmsD8XusbJ+OzJkPLSZRXa/XAJq3djciX6WIu/YB4l4p2aQQrjq9ud/N7uyEmnq4qNGMr4oHJVs+ObfYO9Nm15f0ZzixTscYvkcIJKgz02tIjfRwu0sbga01c7bo36eDDQDJf7EQRgmk5KUJDoprG/RbIYtAstN9bPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXmHAeUqv7hGCBY+DjrMT2qSxZ0v1HB8jNpeUzXGZwc=;
 b=VTs0MiXkI7j7jzC6JKZXx9/Kl7Vy1yaRJVU2ZaT5jWk4OOFAh3/KSdMJtnF5dMfHblMYia+OmmiI72Bc6kCOiOxAeqwk1lKPvjAHKI03gyQVyffsi+PBr0vWsfOy8bO/MsPATT33fIbX+v4yH+9ElMwD6AtQ9HXfE4SZRtGaHG/b/c36ClFUZumpkc7l/1eyPUNzUMnAsjh+/ahNB2wvmLiWx4kaIijxReNYkRVlJI3DgDWDmkaxHgUVHtH1oz1kXFe0728Lym47RXhkk+dGIt4THJkuP4M7FLLD/OX/T8gqWxYa6+y1QwdTIxcvbTFVh9ur95wADriilYhJctLIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFD80FA6330.namprd11.prod.outlook.com (2603:10b6:518:1::d52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 14:34:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 14:34:02 +0000
Date: Fri, 27 Feb 2026 14:33:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>
Subject: Re: [RFC v2 4/5] bus: factorize device selection
Message-ID: <aaGrVKFm0FFGTKUC@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
 <20260226162057.207202-5-david.marchand@redhat.com>
 <aaB1dz2s2adE8ZCO@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8ymk6hScCT8x+sPC7o=3AdFxCXN7BywjvkPiprs_BjM2Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8ymk6hScCT8x+sPC7o=3AdFxCXN7BywjvkPiprs_BjM2Q@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFD80FA6330:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6c3bd4-8813-44c6-6f4b-08de760d4087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: JKbF1ia/4/ztoWQ41mkEYKm8eurcguCU5RZZbw2sLe7L8+ewDjCiJhGPbECEICI+rwL82HI9XBHNN6aYj45NUd7zQ1rUUg49K9op1pVjOV/gG5+liPjtJGpAHNoGP2dwsiTehDPH9dhdcruyR7i+R8nt7T5q+3k3qitJ3Gq/bhIo2Hv6YvqlG3noTZWUvtSaoSaR5VWxDLS/CuQL5CaVDjI0mkOnVVFTk039NiS+Ux29qimmJ4NqOwFTWCVRc/I1dl7T2TxXSXUWFEYjcJrusETjpcrGbwFGeXvaxy9+biw606+ysJ+b9RX6SMVJaBwQVCnXSCI8xDUGh3ozTqjz1HwMTQKQlp0jdGtegpUhn0KsP8kDLLLQqp+J5+qtxr6hg20sBPYwkdeIiF6HYwt7RA6dcWQd4BvkEWYYSivBfUniMM5XB1c6v1Z7m5kbrcVdkAiYDetW64oYcFjEUUu9YqGmzvb+TdVz+ytQYWZUYbn7IrA/N618pTBEWHwX0fWDgVhSKHJ7BL62x1oa7/e26XXQDVzw2Uu8moGka40L1p0BE+t4OLxTnamRb+UosbP95y2Q7l03zWVjj5aj8sGpln62VXm/XmvVUUnMfRagsf3aE0yJ7Me2gINGWI5Ev+3QJFKhJbEnSLnjsecVgKeVxHox0sGNYaRPQQH/cCTIiAaELbK7ZldnJ8aEs0lXMfLR3NFCtAFi0lRxNDcBAnvPrFuvXyi6tC0g1JyNl8+mdmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LVz+0TpSQULB7hSjTjvkOdtTtc+5bsLHjNh/HP4W205LCnRUfXcO+f+tUSLT?=
 =?us-ascii?Q?kk79bF84xc8z7Us4uilxMGGVwtKjrtQDkmK/WzsBUgyPz4eVygpzkcGfP9lH?=
 =?us-ascii?Q?CIMmi4oJCP6zC246h3M+eU8CA1tLxWD1g1zCyRpjDdQuwbypp0C/BtJntbmK?=
 =?us-ascii?Q?zSFJ1ajFqXiSQK5+/MbOsIJjGerwOU39MHcb4MXDokmKdImsiVwNaswD7bSp?=
 =?us-ascii?Q?whVzqtkGyYZ94x5tgrSCqwvBzFnpZ8k5RbGkT5nP+GerrUe80qovAY+uZUcY?=
 =?us-ascii?Q?oP6MsC+yVRGJjGWtKeB9cu7z94Qu7wEruqgQq7GTcU0ThUTjxQM2fR3wD/KJ?=
 =?us-ascii?Q?lkRPoOEA/VOa+MAYk8au+6AXBX6NSXa2uq+HeKVXNSrG7bnZPETy9xlTqROO?=
 =?us-ascii?Q?4S7vzBM7zakvIFaayQVaLDXggBnf2oe+lPimbzWtBKnV8c7ou5VSIJNqm1/n?=
 =?us-ascii?Q?mWBCAOMveqWbDXFsfDRVauU/GQy73RU1Z+5mcA7XXwwf6EZZGpeCgw9YwtPd?=
 =?us-ascii?Q?JH1TS2cQkQ/S/Q3t7/zivDUBS3WcHyAHuIe5BLTM8Eg6zcloC2i+fLx/6Yi1?=
 =?us-ascii?Q?RM8tU9TDbQl1HjZcWlWYvrz/fk+Zi0ade15HiwNTNLdXOQDXdZGUS81WxfaZ?=
 =?us-ascii?Q?j6ZEvN2q9yHAcr83iKh1g+QLowstHigcrFyZdiafFV8KCEtDoBjMvVbdc+Nd?=
 =?us-ascii?Q?HcBqEA17vmWN23HShVAksLUhMNoUA89Atzfj6MThGcvqYnZUSy9rmQyf7rij?=
 =?us-ascii?Q?yMemYsYe3dg5ZU2TIpi77njB2pnkcQ0Pfv9oAXHOBFV9keUcDNnpo9e0NoAt?=
 =?us-ascii?Q?QUv/yvOv9KVEQjjCuNwA5/O0JMXdtFSwJ7ztJnow8dc8/wCqYEGqY7LIYtiU?=
 =?us-ascii?Q?JvJkMQzPOn2bydfQIEu8fx/utRmHajKKNxpvCpdvCQmzkLChIWYnzjfmDiua?=
 =?us-ascii?Q?F4bQxxI9Nx0uPexDv61SWcbsCENMH598mQVkoYQC4Pq0/F/0CQpPVqCBSMLU?=
 =?us-ascii?Q?rsDt4RuoOQgKUutYbxVTtRcLfDPs92RQJB2yajnzo62ujP0HeUXEGIQDVmvl?=
 =?us-ascii?Q?+RYrdf8EWul03oPbuRLRPDobrgUc4IWv4+Eg5xM4nX+3ObE8hJhIOYVPd2/Y?=
 =?us-ascii?Q?AfBCeVga1FRMgXJdGE7AFNExW8UraFYlZypDJsPkyKEyINDmr6T5H8XCE9xf?=
 =?us-ascii?Q?bRnjzpNDTTsm+LgGELgshZGtuhl3JrtPcvwlDalLu9af8nu0NDH2KRbY9ON2?=
 =?us-ascii?Q?HDpKLcIbBNDA+KgaOZH0DgdnMqBe7C1WLAYDlMqYRO5znV5NFAYfAxPW9vRm?=
 =?us-ascii?Q?BFtlnp/r77pQQvXQKLPPtzNi/ZNhh0eB0lssWCpJemVg9/WHdsNnAsLeIC7u?=
 =?us-ascii?Q?BLSxCwb100izQa5O2USj0++cUaEgT703nD5jUmlvJJZWjcww3NbnWICWHw/1?=
 =?us-ascii?Q?PuUgvEZ81it7o6wo0Na5jn6zU3korv6xOZgiWLxqjnXsiKKje+2HufCRbkIJ?=
 =?us-ascii?Q?aHTvbcCQnqX+PJskBjgHBni0QQe7Mh/ihp7oQTBF7bBLe4fTFwXOMqrextPU?=
 =?us-ascii?Q?0lE8YAHNWZgeXRwS9+uvbLsnQUqNFwDgb674vukpTyH+TSTtcLkqnkdiCJpa?=
 =?us-ascii?Q?qeWrJ3V4WJdMvHf/ceayzB6+yNgj0iSChxq046BsVHgS+51y1eBrpJVbeAle?=
 =?us-ascii?Q?GlThZ5A22YGBWP8g6tFnDR/f8QRgpXguik54rnJSnjaFSdkMZIRZGu1NQTvG?=
 =?us-ascii?Q?HIoONShT0E9REohdZ4qQaCTrxxjfNQc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6c3bd4-8813-44c6-6f4b-08de760d4087
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:34:02.5289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VazErkDgha2riS/xpDfXb/5rt4iMVxvB7YMBXfsmakGUAmMp5QqKI+2DhKUkv1M8QQ/ZFZa2J71/G0DmA4ulYci/4s9QgZjcgm7whs0CUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD80FA6330
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

On Fri, Feb 27, 2026 at 03:17:27PM +0100, David Marchand wrote:
> On Thu, 26 Feb 2026 at 17:32, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > +RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_is_ignored_device)
> > > +bool
> > > +rte_bus_is_ignored_device(const struct rte_bus *bus, const struct rte_devargs *devargs)
> > > +{
> > > +     switch (bus->conf.scan_mode) {
> > > +     case RTE_BUS_SCAN_ALLOWLIST:
> > > +             if (devargs && devargs->policy == RTE_DEV_ALLOWED)
> > > +                     return false;
> > > +             break;
> > > +     case RTE_BUS_SCAN_UNDEFINED:
> > > +     case RTE_BUS_SCAN_BLOCKLIST:
> > > +             if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
> > > +                     return false;
> > > +             break;
> > > +     }
> > > +     return true;
> > > +}
> >
> > I think this could do with more comments. Am I right in thinking that
> > devargs is NULL on input if the device in question is not referenced by any
> > devargs passed to the app? This seems a little obscure form of input
> > parameter, so I definitely think it needs documenting.
> 
> Yes the handling of a NULL devargs is implicit, I can add a comment.
> 
> 
> > Is there any way the search for the device name that returns the devargs
> > null/non-null pointer can be similarly generalized?
> 
> I also wondered about that and it would be better, but I stopped
> quickly when I looked at the bus specific devargs_lookup functions,
> preparing the v2.
> 
> For example with the pci bus, names for pci devices can take various
> forms, so the pci bus uses its device specific representation for
> identifying the devargs.
>         rte_pci_device_name(&dev->addr,
>                         dev->name, sizeof(dev->name));
>         devargs = pci_devargs_lookup(&dev->addr);
> 
> And:
>         RTE_EAL_DEVARGS_FOREACH("pci", devargs) {
>                 devargs->bus->parse(devargs->name, &addr);
>                 if (!rte_pci_addr_cmp(pci_addr, &addr))
>                         return devargs;
>         }
> 
> I suspect vmbus is the same, with this uuid stuff.
> 
> And others bus need investigation too.
> I could try to normalize the devargs names for this lookup.. ?
> 

That's a nice to have, IMHO. I think if the NULL/non-NULL is properly
commented it's good enough for this set. You can probably note the cleanup
as a TODO in the code as a further reminder.

/Bruce
