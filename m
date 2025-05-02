Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA16C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 13:59:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E8F402A0;
	Fri,  2 May 2025 15:59:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 596BB4029E
 for <dev@dpdk.org>; Fri,  2 May 2025 15:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746194375; x=1777730375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1TWk20mZ9KFJcGWFSCPsiqIOubyZJQxGtpMzCFH8ZZQ=;
 b=XsnimI6QhuGM3Pqt1Cv4HobU0gjmnKL5jtcOqIrceybBGMZ4O1N5GlcS
 E/Zf+/JmxmVwQVSGbZJ8xKJUJQxHf5L0M+azW6h5d7IBVfLtGUdEpcRl/
 JHpD/2STLZ4oXC/P4S37T9LFAt4myra5HkbkNksc3DkmoCpgqznlmF/0F
 ubTj9MPy94n5zLAs3mZVvDLSUjalO/meFeyHBZwGUoyW7v8ieyYLPkyoF
 abJFBHpJ+phmJ7zV9a66uUtwaqt3d9nHL+chQakITmfGcqpzYWO7oL+MO
 KLNnJ+h3oUxOcbwdasuuKfetnGiOow9Tr2Gvhpi0Hqtqcf5HUkopWLMVV Q==;
X-CSE-ConnectionGUID: N/sArCFETMmRR6Ql7hwzyw==
X-CSE-MsgGUID: Vw+26ElxRTWx64qSwDppGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47762559"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47762559"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 06:59:32 -0700
X-CSE-ConnectionGUID: QRrjCjHDTRSMnIXKXTmipg==
X-CSE-MsgGUID: K7sJz12rQxeOzdvQJGE+zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="134600725"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 06:59:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 06:59:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 06:59:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 06:59:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxwXbomWl9AyGKlqnYqMEdIwiLDR2qmDEgSLSNlSKuf/M9XrOrjdDNSRjMklAhp2novu4tpWr5AOV03dODbAAPoEPNpSwd9zxd2BNb/sFX2xPW2g5Q/c/OQ9KJkgOV48hAxrThxWXCqY0fqf3Kr877L57zbxDN1Nah9zGbo66DzV/Yguve0V2rQTKUw18SQYc9oQV7QHaOhr3p1WhWsMlazu8dYv1cunczeT+p7lwnhQHIl3HzaJ0XllmkcPn+LIWLy6QREsHUKekc1NXwknMLlYWMyoTbWbk+8DdeCmPT1lzt2Xw2wx7bkBUNH/doXMt4IKpCEWHAo5TETBOYuuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN5uquacmj70t32s6f4YPSpviL++aG2dT0/4XeEzDPY=;
 b=Jg+Asl52lIosf4W1jqlErO44tTVBbKpumpVHaSnxg9SzAcwwRbuS4LO0/ukIXHteqMcHwfOG/JkS2SZI9Wm3d1CkyvZrYLv5SdrN9saQiYlKHWOn9aPGbz1qxwUbkjwMfdKwgQdUjB+I+1WPPIsriCXYyxLhADGvrQLUZQ8wk6XJFYR89sSN0jsmnp5t/SSVoSUxAO/p/KWO8YYIb2VMlJo+BuUzIxEV+o66i0QE2m/VkB3LSX1RhCtXIe+y2tkgg4mK8jD9Yh6mu3X6QrquQUqfd83KDpNHfwSHufVi3SQrUY3vClSZboGihjITekHTVxcpc7VHbsyrwwp1kgf/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by DM4PR11MB6167.namprd11.prod.outlook.com (2603:10b6:8:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Fri, 2 May
 2025 13:58:42 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%6]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 13:58:42 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: "Etelson, Gregory" <getelson@nvidia.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "owen.hilyard@unh.edu"
 <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r3ow4K3xJ6vUu8VgAr7QGxzrOoNgYAgAEJ8vWAAwUpAIAGmn3LgAULbgCABLEMgIAA3kCAgAHmrICAAAsp6Q==
Date: Fri, 2 May 2025 13:58:42 +0000
Message-ID: <PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
 <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
 <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
 <a1161f7d-1a55-6200-7440-d615d5a41a6c@nvidia.com>
In-Reply-To: <a1161f7d-1a55-6200-7440-d615d5a41a6c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|DM4PR11MB6167:EE_
x-ms-office365-filtering-correlation-id: 09fd3c3e-577f-4bc1-00ca-08dd898172a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:9; SRV:;
 IPV:NLI; SFV:SPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:OSPM;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1501; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6gsJrnrT1U+NXLBu3skwhqyPVQxJuavgW4YMx7gdePobLav8upIQpmRicu?=
 =?iso-8859-1?Q?Dbg00pO2V1tn4GZOa43QpuZW/w9kBeGhBJHwNYzkhfxe3hLlLu00kutkDO?=
 =?iso-8859-1?Q?o7wsrgeCyyHKGBNUhlnDovbG+DjrqaJZu3insQ/g1skWpTY7Hbi0bmAAtT?=
 =?iso-8859-1?Q?c1d848diBMGS8LHmKx0D5J1dbluc9XIWKhGgdxZmTXiJKavbOo399t8zFi?=
 =?iso-8859-1?Q?LFlFYdqvcVBsms1dkNEpiITb4/bFHo367iVpI1JlolJkblI8D0X7NfBLZz?=
 =?iso-8859-1?Q?4ECzhjPmIKuVkXsaK8kQ2XFchXibtLi3X0T+UqTfUiFzfc5JYWqJY+h2HQ?=
 =?iso-8859-1?Q?CrKSjM4Wc//52jFKJFSae18/Iu2BFGbfHl2PhY9XhCiGV9Onvctw/Vc+vk?=
 =?iso-8859-1?Q?LQ40saKUCubvKNVqk/ns860IjhlKtqgJMU3Ihn4IJCnrf72PJmrIdjjgg0?=
 =?iso-8859-1?Q?WP+Ahqk8Of8y0qBASKJi6cO5vwwfpU1x+wGTRJCu1qOeIvH1cA/RuUxmbT?=
 =?iso-8859-1?Q?+GSVZPLNtEvuNZWJP7zZk3x29iTb/u7z4HrZts/1pMUa/ozAK8H33C7rx0?=
 =?iso-8859-1?Q?1Cv1pXIUd8ouRJYK81cjsWzu8E7L/vUD5GuJCtMJp5rMYYPpTibWezAexG?=
 =?iso-8859-1?Q?w7c/kyNdloS4UiqFxeqHOgCDGaY3GWc5VYpGq9OUeNsSKjGa8liuHU533O?=
 =?iso-8859-1?Q?Vm+UKoCt0kIw085qT9WHo6SpdjgAr0tUgfcyqjCvi+4w3sDd8xyyqvD2ls?=
 =?iso-8859-1?Q?vzySvBWWFPgMGlpNk29X/vJelMJGEM/V38G49lneHsVoVIDMf25PgY1f6e?=
 =?iso-8859-1?Q?vqzQMQr5Fb0FlJXDhkrUHpb4+flYRBiP6/60VT/rb8Fvxjn+P6Rj9yUd61?=
 =?iso-8859-1?Q?qmasJqoojhDiuMMya2VVxDqQSIuTSVnPAmYw5/K2zEeljrtGJYwy/nPjaM?=
 =?iso-8859-1?Q?pn4WtBtUyWN9N8F+iuSpuCXDoqeCqCOxp1YnKtjd69l6zOqbtzKlv/PupX?=
 =?iso-8859-1?Q?7nGTh02vvdlS5QlDlj5aF+TtnUvAAFVF2JKGu1A7Ixe3yXZ5kg05SPIjLW?=
 =?iso-8859-1?Q?n5RLWt5zCXIKE+i6F54eDs6Pen6CnEWVDluh9M7DSzODhTixea4jF8N4LU?=
 =?iso-8859-1?Q?cTMbxvh69gNlTvjK+Galb7vPo/k/93cIXzOUDIRKuCuQmWNAcdJD55qFAi?=
 =?iso-8859-1?Q?emZ5JwdQRVtL/gCou1dl8UxFJyQFVcr6DbZZtCGGIGNo+4VDXmA69FLZfT?=
 =?iso-8859-1?Q?am+K/fbOveiwQM6AtzeW2r1np3Ee5mM5zXbNtGdsTyO2+ADyNgcCng3Lhv?=
 =?iso-8859-1?Q?ODG6N+I/hSRAoLdh/3bBSEIjd9mmmruP/qrhKewBdgoysB9SyoJYk+WYXF?=
 =?iso-8859-1?Q?gZ0x7qAtH+JPg7P9+kiG7j26b84LwCjI4vvU7R2HOsDMM/2h7kSaCMt3J4?=
 =?iso-8859-1?Q?/iVRQ2jzr5rYZXk6Q2jXYfXqZRvrt8AXm8H1eBBflKjIus163g+vVyn6Rq?=
 =?iso-8859-1?Q?A/UX/CeosLi3pOzDn8gtFfkIM+Nd71+pkrOdhSw7baG7+F6pY6wrOiJxeX?=
 =?iso-8859-1?Q?WHwRT+LII28pDkrfUcW2/bzORs0+YD4rHSe2hDV9lCe94I5Ja/mvxorAXU?=
 =?iso-8859-1?Q?1952Cvfl7yfndqxAxyqaA95RECp3BZ57KW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fd3c3e-577f-4bc1-00ca-08dd898172a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 13:58:42.2956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RmBvCQREuAOYVOvUuhSC0J9Zg6YoTkwOwL/8IVwcszXzzh/LWUCQE4ZiCd19SYGaymRFypR1xF8ikFlpTQGjUtcZ/5rPL89qgXgMAIp8X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6167
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

> From: Etelson, Gregory=0A=
> Sent: Friday, May 02, 2025 1:46 PM=0A=
> To: Richardson, Bruce=0A=
> Cc: Gregory Etelson; Van Haaren, Harry; dev@dpdk.org; owen.hilyard@unh.ed=
u=0A=
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq=
=0A=
> =0A=
> Hello Bruce,=0A=
=0A=
Hi All,=0A=
=0A=
> > Thanks for sharing. However, IMHO using EAL for thread management in ru=
st=0A=
> > is the wrong interface to expose.=0A=
> =0A=
> EAL is a singleton object in DPDK architecture.=0A=
> I see it as a hub for other resources.=0A=
=0A=
Yep, i tend to agree here; EAL is central to the rest of DPDK working corre=
ctly.=0A=
And given EALs implementation is heavily relying on global static variables=
, it is=0A=
certainly a "singleton" instance, yes.=0A=
=0A=
> Following that idea, the EAL structure can be divided to hold the=0A=
> "original" resources inherited from librte_eal and new resources=0A=
> introduced in Rust EAL.=0A=
=0A=
Here we can look from different perspectives. Should "Rust EAL" even exist?=
=0A=
If so, why? The DPDK C APIs were designed in baremetal/linux days, where=0A=
certain "best-practices" didn't exist yet, and Rust language was pre 1.0 re=
lease.=0A=
=0A=
Of course, certain parts of Rust API must depend on EAL being initialized.=
=0A=
There is a logical flow to DPDK initialization, these must be kept for corr=
ect functionality.=0A=
=0A=
I guess I'm saying, perhaps we can do better than mirroring the concept of=
=0A=
"DPDK EAL in C" in to "DPDK EAL in Rust".=0A=
=0A=
> > Instead, I believe we should be=0A=
> > encouraging native rust thread management, and not exposing any DPDK=0A=
> > threading APIs except those necessary to have rust threads work with DP=
DK,=0A=
> > i.e. with an lcore ID. Many years ago when DPDK started, and in the C=
=0A=
> > world, having DPDK as a runtime environment made sense, but times have=
=0A=
> > changed and for Rust, there is a whole ecosystem out there already that=
 we=0A=
> > need to "play nice with", so having Rust (not DPDK) do all thread=0A=
> > management is the way to go (again IMHO).=0A=
> >=0A=
> =0A=
> I'm not sure what exposed DPDK API you refer to.=0A=
=0A=
I think that's the point :) Perhaps the Rust application should decide how/=
when to=0A=
create threads, and how to schedule & pin them. Not the "DPDK crate for Rus=
t".=0A=
To give a more concrete examples, lets look at Tokio (or Monoio, or Glommio=
, or .. )=0A=
which are prominent players in the Rust ecosystem, particularly for network=
ing workloads=0A=
where request/response patterns are well served by the "async" programming =
model (e.g HTTP server).=0A=
=0A=
Lets focus on Tokio first: it is an "async runtime" (two links for future r=
eaders)=0A=
    https://corrode.dev/blog/async/=0A=
    https://rust-lang.github.io/async-book/08_ecosystem/00_chapter.html=0A=
So an async runtime can run "async" Rust functions (called Futures, or Task=
s when run independently..)=0A=
There are lots of words/concepts, but I'll focus only on the thread creatio=
n/control aspect, given the DPDK EAL lcore context.=0A=
=0A=
Tokio is a work-stealing scheduler. It spawns "worker" threads, and then gi=
ves these "tasks"=0A=
to various worker cores (similar to how Golang does its work-stealing sched=
uling). Some =0A=
DPDK crate users might like this type of workflow, where e.g. RXQ polling i=
s a task, and the=0A=
"tokio runtime" figures out which worker to run it on. "Spawning" a task ca=
uses the "Future"=0A=
to start executing. (technical Rust note: notice the "Send" bound on Future=
: https://docs.rs/tokio/latest/tokio/task/fn.spawn.html )=0A=
=0A=
Other users might prefer the "thread-per-core" and CPU pinning approach (li=
ke DPDK itself would do).=0A=
Monoio and Glommio both serve these use cases (but in slightly different wa=
ys!). They both spawn threads and do CPU pinning.=0A=
Monoio and Glommio say "tasks will always remain on the local thread". In R=
ust techie terms: "Futures are !Send and !Sync"=0A=
    https://docs.rs/monoio/latest/monoio/fn.spawn.html =0A=
    https://docs.rs/glommio/latest/glommio/fn.spawn_local.html=0A=
=0A=
So there are at least 3 different async runtimes (and I haven't even talked=
 about async-std, smol, embassy, ...) which=0A=
all have different use-cases, and methods of running "tasks" on threads. Th=
ese runtimes exist, and are widely used,=0A=
and applications make use of their thread-scheduling capabilities.=0A=
=0A=
So "async runtimes" do thread creation (and optionally CPU pinning) for the=
 user.=0A=
Other libraries like "Rayon" are thread-pool managers, those also have vari=
ous CPU thread-create/pinning capabilities.=0A=
If DPDK *also* wants to do thread creation/management and CPU-thread-to-cor=
e pinning for the user, that creates tension.=0A=
=0A=
> Bruce wrote: "so having Rust (not DPDK) do all thread management is the w=
ay to go (again IMHO)."=0A=
=0A=
I think I agree here, in order to make the Rust DPDK crate usable from the =
Rust ecosystem,=0A=
it must align itself with the existing Rust networking ecosystem.=0A=
=0A=
That means, the DPDK Rust crate should not FORCE the usage of lcore pinning=
s and mappings.=0A=
Allowing a Rust application to decide how to best handle threading (via Ray=
on, Tokio, Monoio, etc)=0A=
will allow much more "native" or "ergonomic" integration of DPDK into Rust =
applications.=0A=
=0A=
> Regards,=0A=
> Gregory=0A=
=0A=
Apologies for the long-form, "wall of text" email, but I hope it captures t=
he nuance of threading and=0A=
async runtimes, which I believe in the long term will be very nice to captu=
re "async offload" use-cases=0A=
for DPDK. To put it another way, lookaside processing can be hidden behind =
async functions & runtimes,=0A=
if we design the APIs right: and that would be really cool for making async=
-offload code easy to write correctly!=0A=
=0A=
Regards, -Harry=
