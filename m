Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2A3C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:19:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A00C42E5E;
	Wed,  4 Jun 2025 17:19:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 24844402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749050376; x=1780586376;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2xes2pBTPLQzjWE6fJ1lY+bOXgbK5d9G0BWn+BlcJPg=;
 b=J/ZZfcxMdMQelpHg8PKHVIYaPF0XgwD/uufWPv6Hek61pWOqilzRYw3y
 9Q38ktVoKI4MEOxmOphmpm1s4w3SBZQsA561d9bwjMf4fKZCIVfTuilRD
 hdce1l6YIfM7Fx4noUY4KcL8UKykIPDrirhLsaUXedbjz7BfEfnGX6LP3
 OjVsKvriU7hsrNT1ITD2Pq6JCbK06N2+HylGhgD+nmiytad9oJcShK5wm
 LFhsUWxXJIbr+arqyAxlG1pAGm/Opzv78nyWREFT0FnNZaMpGsFDxCYcR
 aMQtsTZiP2On+XRuKR+uTH6/9CcKYv8xpY1QGAsFxHskJRf15ylMuWc8A Q==;
X-CSE-ConnectionGUID: Pk3tKn0tR6e+UT6fA47s/A==
X-CSE-MsgGUID: bCm709uaSUSABmMpzmqQGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51006436"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="51006436"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 08:19:30 -0700
X-CSE-ConnectionGUID: Uu8uEOpuTOW1gy78oM0UAw==
X-CSE-MsgGUID: GXERzEcUR5SGIk7ioakJCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="176102932"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 08:19:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 08:19:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 08:19:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.58) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 08:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwlGySVAsgOvl/xvi0713ZaBJ1Ad/PHGJeDJUclLrenH1wPOYOGaIibWGVhCCqtEF9zc3uXCSuYYMIQR2UIMXJMpzd4zCaX9r5Kc/4txBmbFDsOo9vIVYfUBW826wep+KAmNtxFLkhhovaRyEdGCsCHhESDXKZ8kLl1MXNwdJm0HrBDmHqYboTjGsLuDIZlLIaz8S67nZhj+Uay6Ici52f/v7isEWyrCw8ppxwSv8G7kAkSGKVb7kKaLu4lKmdVbY/SZIKE5kTRCgXBJCkHPsOB1FLgNgX+XweYZaeKsIkn8mNqCqf5qpLuL0SJXJyh08Cdx/bi8RvtyiPSUsYlJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftewK5colhgiAH89dz27p+5ZEWUo5r81UWHBpm7FBxQ=;
 b=JcipLWyCCMzlReTofCXDRx2vr7TH4sqYL0mwqm44C2OibBefgO3wPkGJblct6dR4QJxj5xKiKtk0EYmzGGRW+6XxRnKJN33J4y2nlKdUDGAmYBpj687nf5dE0Lja9cQFbr6g/O4o8mOwaLg2dhftUOuzaBYLE2uPm9FMThUONpSr3L+4OUrXQw3//eCi3iizibYgJA3uFX3WhPVCSS9vaY6x95XzW6u15MzHbtyqaZxVIZqVPMq8PF2+l3ea9O8jK/EpEEQPx44tQZgg9tnGqfAJQIy1y3JNfJtsU1nPk9aX7h5v3YUTfemJPItqKhtrfV5A2Vg3I7cWwJk5Gh23Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 15:18:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 15:18:25 +0000
Date: Wed, 4 Jun 2025 16:18:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 25/25] net/intel: add common Tx mbuf recycle
Message-ID: <aEBjvLo_5iuufEDU@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <150e8c6ff6c3730f5c9ed78477d0b615c7f35a1a.1748612804.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <150e8c6ff6c3730f5c9ed78477d0b615c7f35a1a.1748612804.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e12671-a2fd-46ca-2a99-08dda37b0d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MjP6cdEFFHZwAzdl+EiIH/+k3DZZ0lVEhv6xSHXlWWJbkY/QL4D0skJRiswh?=
 =?us-ascii?Q?aq5trp/E0oS5/bF6uoHMPkuzfEf3+5QrVOfJUWRE14Px9T9J7+B/W9QgQATi?=
 =?us-ascii?Q?pGX8QJTz6PRmAcdbK5Ig+mhIaH5BDdlv1K8ANPKhfsp0yTL7AuSr9x5H3xTs?=
 =?us-ascii?Q?xuTzzegV+uZv9y6n/lMvMheNxxGStJDLNOegk8hyELZZk4+4ueFidSSU8EOi?=
 =?us-ascii?Q?EzdA+qHAqlCLChAiwAqKk2iadqQ95IKX7XA9L9pYWPeLsvRGoK633iWrqZg4?=
 =?us-ascii?Q?5MLJXXZcrKKObgoD8/5oxAreNfxabcie0njxR9IU8hFZC5bNDACS/Balxnov?=
 =?us-ascii?Q?IIlcjketxtOdAaR6PhKMk+/7f+nqG4xQnHtyY0/35ptmIAFh4dPiC8TgtO/c?=
 =?us-ascii?Q?/IeQ1tfdra/GmOy2veNI7VENWutDJ9Wz7gj+fTXXenpIjqtmT92kq+UHgB1e?=
 =?us-ascii?Q?W89kYOg8C8DwWIqe+CrycxIRK6VNnnEG1IUg5uii0w9a/pfgBhGoo8vh/dwH?=
 =?us-ascii?Q?lu5c02ePmugtqh/8Lv1ZW6dyAsLcLDzARt7ZFgxzqyGKhIoG0FdMITcnbulT?=
 =?us-ascii?Q?Xl3cE8tNeec6C55gVgX8qZEtJm6Z83ASvdP4L/Kn1B9sxHmps8cm5wq9nw9q?=
 =?us-ascii?Q?tIHz0PMHv21yUnIk/H2snJ6Era99PqnOSHh2yPUumhwcndLjBg2Sql8XlzXM?=
 =?us-ascii?Q?0cILsfaZsCX9v2z9/Vj0dsZCgDlcgd1ChsZcARx3XRX0bhLFxupMBsrKyyhq?=
 =?us-ascii?Q?KFBNnqhfgZ/MKBdGrQ2UG4eZ7Oe4sG2FUpDPsMCBVBs2yW5jms7jyQl/4c35?=
 =?us-ascii?Q?GKkIrFPc4EZdE7AvRaP+NlS7IZollA6QJDp9R8AZyRSeYQ6HdhWdV4Jey2gZ?=
 =?us-ascii?Q?gwRCrFpQjuTIvNiSNQNzs3/oA0MG0q25nL+RNrnCDw8Rm55X8Aad3dj6dApC?=
 =?us-ascii?Q?6ZJeStGFNSVprhTx0dfTV1tlamIzn7xsI/h3Pz2B/tIV/DRkUmHabTOUkOed?=
 =?us-ascii?Q?USUxy4MbLybgewOuOmYaOFEGX2V4WNc+jvtF5KgjqHL4DGtu1W4jYzc7KVFV?=
 =?us-ascii?Q?xCRDgZ7jCsxRZnxAGrjavJ3ZnW1DJBZ28e6eaZfP3sCZuhB6LQFavw7H4whD?=
 =?us-ascii?Q?+6VceExQoMGPSDRxGHo/LvAhEDE6InpRfXfz/496xCq+IDb1WyovY9ZfJdPd?=
 =?us-ascii?Q?lA0XW3CiS4czy52wJr0YnixlG6ItVDLp3jil/6FA+7JcKoQV4BPooShLc1Ck?=
 =?us-ascii?Q?km3aKe7OG2syTCdGeO10fuLwHEabarkcNeX0G2ukUXxw66mFLha5Sl8vFKen?=
 =?us-ascii?Q?YL7z/XslmM+647Z62pp5771yyOu6peE+m41/l8HSVcuc2vXz1xM3nr6ZB4Mo?=
 =?us-ascii?Q?EQ8av8Q+5naC1FXVOdZd6mMSHtktRJoETR6hk+vhbVxG2G3vK00P4LSmDWgc?=
 =?us-ascii?Q?xeQ4U8oJz4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyTPC8hrQl/7YguQdFlvGY+27cwKPieI9xYKUoyJf1n/bUgL48jZjCRt9jIs?=
 =?us-ascii?Q?8TzbXzuUyq/hH3Ns1n9WQ90LDEhm1qS3WCeQF+ft9v8vsdawS8eR5cJnVgy+?=
 =?us-ascii?Q?6DN6Q8oltAMogKaIICUqzaLbPaQEEBeDB0e3tWsV0+PyRfz+eXsph+oxPN+6?=
 =?us-ascii?Q?CaHzS0cUkmlgMw2uNG2Bhp1kGM/WlODW+wxl97fet2LMYlR1Axhi9InMa/ne?=
 =?us-ascii?Q?RscM4bGA7U5vuSQ2UBAhP8FaHf25Z/rfOOZzIVpFHrKo1+ksFRBl6XY7WYTg?=
 =?us-ascii?Q?Uan8sWbmiQA1B8sFuqta3QG15M0tA+sYV73eo5sJ6YxbR3RWCA8umZzj4Roo?=
 =?us-ascii?Q?NPaJu8df2M4Kgbg2K5l2zjj6NiiobPqnMfpNJAD2mWXM6CKsBhPjXt0VbdVk?=
 =?us-ascii?Q?8EdEXwOZfgzVpcDsuUiXxdwiURjvvNpoRcuOdg0pAOih/rQkKqqmX93Nx7lp?=
 =?us-ascii?Q?EYh7yQwhjRvVNjUXVtINPFHZXTdXI0mtRLztpFfZ9lJ+hGCcNjdOw1+pRG8Z?=
 =?us-ascii?Q?nLARv2848V/5r9CBJJW/FyMEqmYxwzGKByGaUMVJ6tyRRUC1/EDK0hOLjOkV?=
 =?us-ascii?Q?4KRtYXqVckiWGEd1uxUZSDGc61bCQfR0kt1kd6aanwkrDQJz2wp+LAnK2iHb?=
 =?us-ascii?Q?J5Eqcj5ncrFRjuxVs5F6S7pDS3FVISYO33cgHimp6jgzFaCgGY001C4qRXPx?=
 =?us-ascii?Q?1+T+VB52yHxsrkAdotFVSq4M5HTniyVae3LEo+PHWhUAe5FwdTHeCqt0yo2Y?=
 =?us-ascii?Q?8FOta1QvpcmSMg3JG+sSLcDVJ4L3g+97pYUG88C/V7K6pV4NuSsonpk0+Uny?=
 =?us-ascii?Q?Lph9So8nwOWMcn69h9lOVZ0nf24rPU+MQdp4aR+TN11cm4hJ1aW1uj6tDg55?=
 =?us-ascii?Q?IWOFG6WopfpcS/OiuBUKh2WntcFW6kFvkCooMkoWskAKdgYc+Y545tygTg7d?=
 =?us-ascii?Q?qVx1qtTWkf+53jrOETcg/mDFmeO6Ya30cVLcTQMDGgSlpo5smHcUdOI8jo0o?=
 =?us-ascii?Q?+yUv7mlsXF6WfwCvTsYeLSKsQL8Tx7hB7w0QyrIZh7jTsX9qtYOdlNmEZtKf?=
 =?us-ascii?Q?glIMV3/S7ETyjUOmNNnCZxbq6iGIIlrZJU6IocTFGep+Jb3I5ilLM5ExrBq9?=
 =?us-ascii?Q?PY3JthY9dQIdvtqHxJDSypmVbSWe5osbvZ7HbXzJC3e5vEm6l2Af25ApgPOb?=
 =?us-ascii?Q?kz1kGOqNEWQhEFIpce6cIzgPY8PfXKuuN+teBLEiDC2hdzPt3wpLSikqbsw/?=
 =?us-ascii?Q?RyKYXcAHkk+TqXROGpKx/QFYbO3w8B76YBAQNkeTpWAQz3CR01rMKNtanfUt?=
 =?us-ascii?Q?47CdUGMd62goR+ASqpA5mFhhbRN2N0ptiY8XqnVSaS+LGi/bYG5sWROe53tf?=
 =?us-ascii?Q?0o8bCRbOXkdzBCTRbKBgn2PmiKq43B9Lt8q18AYCrGso7E0CMW9CMj+4+YoO?=
 =?us-ascii?Q?DD6PEa0jC8Yq277z9vYkyT3oBIV6qqWTuErtzV+XMjIArc+Iz6MJwxKgYXtY?=
 =?us-ascii?Q?14RphCxStn02dt4E8MMVvGYrHqgenICutStKFJS5gvKb0GE6pRTrzAsbgqLM?=
 =?us-ascii?Q?28uspdQP90CO4zszRTmYFR85JOiv/WT2JNLh89e8vrB1zuWFuoVPM6urHeju?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e12671-a2fd-46ca-2a99-08dda37b0d5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:18:25.8921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk3Sk4v68mHRfg3v1RHQO7A82KWKzvpA9e7LHBiNVLvSeDpCA9Cs2/dHmKrBXQHj9Z2EX28x7e+h/CrDwDwJOUEDgvh5OdhY8H1oO66Rh7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
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

On Fri, May 30, 2025 at 02:57:21PM +0100, Anatoly Burakov wrote:
> Currently, there are duplicate implementations of Tx mbuf recycle in some
> drivers, specifically ixgbe and i40e. Move them into a common header.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
