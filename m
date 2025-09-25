Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4ACAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 10:32:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F007B40695;
	Thu, 25 Sep 2025 12:32:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D69CB402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:32:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758796324; x=1790332324;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=reKV4xv32sJJvEmpFzQoGMlSFp3DDIcpOJUMFkO24rc=;
 b=GYDqo0sODIzSPff91Wbte8I03qoLYPUpu0v1lZz5kLmj6DaLSn8bprgb
 HsIwtV/I5l6sYJ6an8uMagx//yVJoBE/Jun2VhpAgq9jUbWZ4KzFS69Ad
 5uDEyxIqAEBzhqT4LjCpsOYzeVni+Zjpty7Pmv/wc8OhmFytNwsywHc/o
 u/PEULTQRkcifqNKPw8ITw3J21tTe7JxN7OjQ0ntAzAN+tlqXMG4CFV8J
 O1/0jS94n9+KIo3RSAXIw6wL8bVzDZSClj0BsZJCv/qxVldXsfKJVNrP0
 879YTiokavkq+1gZNKsnHmdbobMGC+Ajt1xH3cK1kTfLgm52WEBx14npu g==;
X-CSE-ConnectionGUID: 9Pn2iXueSDS/buvKAl0cKw==
X-CSE-MsgGUID: pT2zUYzyT72pRE219zHE5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="86554891"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="86554891"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:32:03 -0700
X-CSE-ConnectionGUID: ozjZjYHWRW+sOaef1/1KZQ==
X-CSE-MsgGUID: crVMV9lLT+OQMJ8/ETOmNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="181302300"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:32:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 03:32:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 03:32:02 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 03:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHXupKUQMXc5SIzChPO+y7WdG/NRZgFWxbx0oIivmQHyJwNmnp1lTFkqK29XwntBi+DvRLffOwHQ+cM6g6VtsR6e70BYBlUFrNqYgfgRD2nsgwFs+qil+3kan634XWl/twnT5jGj6OZPOngVXyToLaUyCxXtUQeqS7uIEeoyOjnUA1rIBhCKqdmdXqQ+Vv93Gu6NsDGykJFTIQa7j2wVYjLkDK1l/vv5eiRJ+QH/w1RzzUuABFpMO9rhphu/fCcFFT8VRf0FWDvWxNx3PmayDEbcmFrtcogMAuP0MWQZC6c5+gYz/CjmUNotmAJ/XMwp1vsG5gK9TWG/I4H/EHpp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfAoQeZ3EosdPFti3aKZRjXQuDQxwIm9hMRz5tJWsAE=;
 b=I9gqH6r9hoDedXMEnKxNaiRxA6dmKz/0kdQ1wY8aysKy3dJ74tBtr0RaJnExJ9fwkh8YDpDlrbdoHUvSUJCfKTZUqCczqIuCAqRKhM3hXQKGQSrhWpE3id2Ae2PTXbY5iayqm8hmaSxrELsAEQgG4/qrHcPjaaH+2ZUhHmHAlYtez+oliz/GU4DAdzNvuxytCGYI4cKjVKyuRZHhdhLQdUTxoXHOw0J0ijr0pGJuiJw9sf6EdbFr7Sa35dLQ1lH7zaGRNAoVvBvqVd7w4PHMomNTx9aymdGGJzIxmRzhltPWE41GXakqoFEh59WY7/GZRJJdpIJ70L/MrWV/aEZJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.23; Thu, 25 Sep
 2025 10:31:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 10:31:58 +0000
Date: Thu, 25 Sep 2025 11:31:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNUaGnYEZR46WDhN@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
 <aNUL_Pl6Hf2bmcJJ@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zBxax08GOBDqyL1ZC=S_DzitNA=isrir7RCA5iehiwWw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zBxax08GOBDqyL1ZC=S_DzitNA=isrir7RCA5iehiwWw@mail.gmail.com>
X-ClientProxiedBy: DB9PR05CA0027.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: d2be7e18-5863-43e7-1a35-08ddfc1ec1b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PO/QvbRke0BJQkSV4DYh5Fzw0manNRscNPseXJsxRDQ283VxfrkYB4izpoWl?=
 =?us-ascii?Q?2HB/P820mTVnLJl87WSkmjLQj9tBTOcXphKo+nT7oEVdqweINkFRTCCVpCEh?=
 =?us-ascii?Q?rS1GjvIplpit8cpS41tJ7ydfzzKia+j5Tl3OODJfYFvjgn6ohK/WSb1cC/xt?=
 =?us-ascii?Q?NahLRxHuRPP3kTldOaO8PSl9H1qoH8tByo5FFCNiSGHvfWtAWZikwur0d5lY?=
 =?us-ascii?Q?1Z5e3lmTIx+lkvIAXlDtjjSbau5vhOHIqFJpBGsMvf+B0ItTgAfsObKTNQJL?=
 =?us-ascii?Q?BOAXunTU6noxJV+Ml9B5m7wibiumOHeMrnELZ4u0ubA73y5PKwLNoYovVlWu?=
 =?us-ascii?Q?968FngH1+geECi3isc6jAmTsf9pmp7NQ72JhrptIcpVDgtQL6YOTcwOR8NuY?=
 =?us-ascii?Q?Blb0zLi+p6vcr38EUeWDBhEGqXXIFv2Z9/ZBZ9mSKaIdQPyvK/EgMgNx2/4u?=
 =?us-ascii?Q?tPdZGh6BAxB2oE25vq5+RvV2Dm7FMs6/5YaTHHd5BxF5ORdz/A+sx+Etp7N7?=
 =?us-ascii?Q?hUJXA8vTfHt2J9YSp0c3oGS1frap8fj4cIBV4DzRvNSoLJxkInLrs7m6plvQ?=
 =?us-ascii?Q?QYmWxqWlcBg+leMFcrSz+qn/4CKW3nSkQnOaBhxOcMAWJYQ46rnYVorpgpnW?=
 =?us-ascii?Q?4emZNsyEzD+qeywlYDdfPANgRPtK5HrxpU1L0v8Bp5lMLYDLfStc2SBfXvl9?=
 =?us-ascii?Q?qZlUU/6hnhAkUfbYOwQ+I/nRO4aIDSUtMhiJSS5OA+d6jMEZBPl+YSY6qRyi?=
 =?us-ascii?Q?QLbBiHM72q6QF3OxIM5zrq7kZJNIm0lfROKUWOc23Bw6YecAbcrEIH693GMB?=
 =?us-ascii?Q?If2Ebsgrj6/1uVWlAo6MNYuWjdEobwkD1Bc7F0TAg9HN1hciLPxdccv9jX8J?=
 =?us-ascii?Q?cy5TWiu7s6/ZwP+WnbJgOa/JLETw2HLc9P/96p24U27QvfUu4BYXOLewGYsN?=
 =?us-ascii?Q?RgH/59KWoGsgzmFzp5uBz3LBdgEG8kmW1YDKfq+m8UCxH0fFgR2GE60yu2gq?=
 =?us-ascii?Q?UtDsFqsxBmVE1lT3M6SXxY7MJ6yFsUl5hoiDYrfIr6tH03oqt7b66yUjRklC?=
 =?us-ascii?Q?Njr5qtWlq8YErO472bi6S5nMgtHgG5CwwXFIB38jn7J4PHqIB8oNtsOxgj12?=
 =?us-ascii?Q?mYx+tD0XJZtKRdab4rNi0HROqA/PS9weTCHQM5oEacPIj9Sjmkrrghg+0cfz?=
 =?us-ascii?Q?xoLOGKTpCBUGJe/fGUDap1+OMQrSQtDngRKKxCfqn3Jzwc9OXoDTTivSEn7d?=
 =?us-ascii?Q?tJ0rFeTrjxuOIKNvGZZIf6xA/aG0SD72yf4L0nTzDih6wrGUPVhSZb0ScrdO?=
 =?us-ascii?Q?BO+MthhAc37dcAFspzWu+q1t76eM7pG9vXtxlALgAL2UARfJn1yyG7N5Id9y?=
 =?us-ascii?Q?2j55lOdK/2uNDKrKENUZy4xaJ2lEkD9x+tkea7+cwmd7gtnAYmilBQraSxMF?=
 =?us-ascii?Q?rjY0+9gPRVw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FOj+QGOzYudUbCMEu7bLL+ik9CqXiOeUbyxqIpdmp8UR3MoU1DLba86/F+Lf?=
 =?us-ascii?Q?V+Adv/Ozd80Xwh01oIaqK8bvlQWWxoD+G6kWiq3RW1V+XODTE4HPvChhQY23?=
 =?us-ascii?Q?Rk6mNJx/RUbSml45Szf5Z2jO0/FPFzj0+PDuHV5ANaTiIQ23oq4q8yaHGAh5?=
 =?us-ascii?Q?UALImw0xlQpAVayNQv4gXZ+OPIenXzKDs76gyiVnPA3vlIcs0clAesv29Rya?=
 =?us-ascii?Q?RJkXS/3O5rvPUbzIAhhgXKxG9IjVmKOxTuFS9zksuBz5ZzcWase3q5UEP3NG?=
 =?us-ascii?Q?nNX8RqM0GnVK4QxfGo1P/4FCtBlxGo9K0pDXl3LDL6W0JsHouAF0pL32UOqN?=
 =?us-ascii?Q?WCfI+sc9f6pXESZSEF+q7XaJ3Ev485rOwk1P/8SGj8CZUcidlnhzrEoV3lui?=
 =?us-ascii?Q?AkqIYySV9mEQfhUW6HH5K93rdXpz7e7Leh5gyNbrFfBl0umdD1aLRxPWgnxG?=
 =?us-ascii?Q?8KB9yehnZ0ZYK0/Vlp1DLyTakQXPLjdcyZDx6zJctYguHNLXSG+S26OSyiF3?=
 =?us-ascii?Q?1idwAwqhTnO482TdPEyeHN3/t+0XPOobfWO10O1GXWVHHiIBHIgwUs/vBfTh?=
 =?us-ascii?Q?PemTjPEfOccmrXFP7vG9Fz7x/V+bQRXIcFMQDIm+PZvAIl+RqJ7RUaV3d2rB?=
 =?us-ascii?Q?2dbFz+Y+qlViOsWXdO3BUzNQ7yJT72uIdi6VWkEpkCe38VeGGNyPOXmsgG4o?=
 =?us-ascii?Q?TkLm0VUYUfVo315YKfNVaEonb/ShLsr3U+rTiTA6v+g7mCw3t34sksDIcKl6?=
 =?us-ascii?Q?ljJmUXkaxlA6T6xi4rdpOq5HR3AC7W0VRcif+5rYM638iwjThn3rLhCskIuP?=
 =?us-ascii?Q?+QPjPGLyiut0Q6N46hNAxzc78NkQbbCNSMq6/84gqResxguqlfua6x9NvYDi?=
 =?us-ascii?Q?GDtvz+wwwoxaDXkpYc5r4FLSEQUMI3EYuYJZjLlukyFAiq91FxF6C2hiNGls?=
 =?us-ascii?Q?yQPI/cHF9OPNHrtUoePAhSAxwlYoFftengpCrwCYcmRyMs52IQt99takN1lF?=
 =?us-ascii?Q?72p5rC7KOuN/D4m3qauSOnVdxfH2RLLnCyAY9HodNMYKEatrbgrrWbix2+SX?=
 =?us-ascii?Q?jwNh53QCQY3Bt5DE+pRUaoAAWC6vyDd7CjIoI76mRPV4J/X0pie9YC5tJ+/k?=
 =?us-ascii?Q?QG5cjgYOx8DTQXiNfW24wyP8Yjn3mzz6Y05lSmZ8qDDlNTj78ijhF6gcJjeS?=
 =?us-ascii?Q?qD7WK5P0hBEVgKFblM8ak/X6A/eWpeV88slRWZ3/3xlfB2biQPXHSicVGEXC?=
 =?us-ascii?Q?+NB4PNmByjWz2xZ6vefLUsJVtDLZ6o8OiRhmD3kG7rDFhHbiweSnHUhrsPOM?=
 =?us-ascii?Q?Mv7lHEioe3Pi9bOZkbxsAq7eVNGvY68TvkwrmACUWSzDeBWgSqep2LhrfZGh?=
 =?us-ascii?Q?Y4AA4vNBpULEDQ0QnSyl7FADFCdpaMnhi9hYzWhWcAth2nMoZVYDdV2VX9Vv?=
 =?us-ascii?Q?GZYhafJ0JRc371Ak3mFpvrX7mqRT+69IYCE06qjEYOL4Zk3gWG84ecPkWKxE?=
 =?us-ascii?Q?4Grl4wDtc/3aoruPbbxSgm/wBdRdyAy9BrmdSlmiehZLOkVeJz27+6EZHFid?=
 =?us-ascii?Q?3tiGJzRjTdhWTveo9wiI8+oJE+kWthPXXJm3TxaPljnNlQaaWwOJsDSn1lvB?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2be7e18-5863-43e7-1a35-08ddfc1ec1b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:31:58.7731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihZdEouGWZ8Jp6k3Rd3KKO1MPIBzjR6hrmhHwWOK9qinpwHVjIIfHC6BxAjaM4NjFVPc2XHTybYM+IJOcEVHe8pTw6aEwf0Z/oaR9nap5Gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
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

On Thu, Sep 25, 2025 at 12:22:43PM +0200, David Marchand wrote:
> On Thu, 25 Sept 2025 at 11:32, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > > In general looks ok to me.
> > > > One small comment though - can we not have "staging" as a top-level
> > > > directory, but instead hide it inside the buildtools directory, or even the
> > > > chkincs directory? I dislike having too many subdirectories directly off
> > > > the root of the project, especially ones purely for internal tooling.
> > >
> > > Well, at first I was trying to change the whole build process iow rely
> > > only on the staging directory and remove all the include_directories:
> > > directives from the declare_dependency() objects.
> > > Libraries and apps were ok, but there were a *lot* of complications
> > > with drivers (what a *huge mess*, especially for NXP drivers with
> > > "compat.h" includes, and Marvell drivers to a smaller extent).
> > > I may retry in the future with some AI tool that will brute force this :-).
> > >
> > > For now, I gave up but did not reconsider the location of the staging part.
> > > Moving to buildtools is indeed saner as it is only for the check now,
> > > and I can also make this staging stuff dependent on the check_includes
> > > option now.
> > >
> >
> > I wonder should we just consider making chkincs an install-time job rather
> > than a build-time one? We could look to build chkincs using a custom
> > install script (meson.add_install_script) after the header copies are
> > already done for us. That should cut down on the complexity within the
> 
> Not sure I follow, what would this install script look like?
> Is it not similar to the makefile solution I proposed previously?
> 
I don't remember that proposal, sorry, so it may well be something you
proposed previously!

/Bruce
