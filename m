Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221DC3ABAC
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:41:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0619C402F0;
	Fri,  2 May 2025 17:41:39 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10hn2240.outbound.protection.outlook.com [52.100.155.240])
 by mails.dpdk.org (Postfix) with ESMTP id C3F05402E6
 for <dev@dpdk.org>; Fri,  2 May 2025 17:41:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHE+3eZU8A35D50CFd+STtXtxEoRZNzv5FfuoxuBD7KtXkohWJlKYCbHrXJEdBSJgFd/JfxDQlFyKOBRAGIRjvFbnrJRNTei8wiISerNrsmduxU6OqjxwNoi6IeuvpkoNOdns9+rlGK/oy+KO1qh2uQkmtO1kE7b/j2QN4hg+9/waJ99XScbVxli81le+ySigWxeH+mBsxpmBshlaKEBoutXqrfLZFfxX+Z0Gz2YRjkKNZScIoHmkpOel3W+rKAv3ozdLZWQX5ajPDzt1x229z2XROtFsw9LS+JmM1NOpc6YKG6PFZIhpxV87zWy9GD4AygAxETc4OFCNcNAfcQJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N40gyai0E7CVhgj2j8dnF2ANRr1scMGMlXTM4rY29NU=;
 b=EeIliTJ1uMnzckvCeGaYVXe17qnTnWujVsslz4WWFrqOrUVpBo2eXOdMfhQyp/rGIwu7U3HvIv2QewNPe8eYnVWodmpJmTLCuTbRY01AmTllxFH+d/4bIhnx7IIKXzapFVrM5pf0wupsNwTDQXik/AoRO8G8lK3CrmbPJ3eYmmnWhenfs+5dqX0Etbs094jPmo+FxZoCiLWLrxlOuTrU+CdjXKYrGYdSsQoWGflJ14c8Pgx2H6fP8ZnKzwvLg0dJBsD1FnVsJrjtudahJ/A7FQNNdOeKLmGcMtMH20bDxtdUFNZP0n+bPQXHUlHPfyuABQMDIkzFK+IF6MyGvPu8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N40gyai0E7CVhgj2j8dnF2ANRr1scMGMlXTM4rY29NU=;
 b=j3JDQmtCPFT84fJTEcChRM1gXbb+omhVJbwfhjQn6cWydzhiZzCmSz1Rx94X2RO0hZR1HNKlow7tZFu+05QRuiFfUSzLqyivEUAWBV1cs6QrHC1J/YM+8vSTZx+ZaJeq41Itpe2rWQZVGcBTZXXrH+sJ10lb43CYUqmtEHboFQbjKBjZ1rFefTi7xnUxz/Z0oPFv2efyZ4yegEIW9HywIZUejlaOqYF34kV6Q1FlRFzJYgUpU9mw/4F12EuXCJMrqqY0URtI03UBoO5UvXXUu68H19bGFmXhOBmgsLFDgm5VUDraeTt2UgL35CP05+Kv6sHD581f0eQKVxBHO9u8AA==
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 15:41:33 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 15:41:33 +0000
From: Gregory Etelson <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "owen.hilyard@unh.edu"
 <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r1ijGnPC1ap0e+6CWAdV93u7OoNgYAgAEX6wCAAvBHrIAGyB+AgATktQCABK7JgIAA4IOAgAHmrICAABRGAIAAFoJv
Date: Fri, 2 May 2025 15:41:33 +0000
Message-ID: <IA1PR12MB6330B75B3A6E4781EB147F78A58D2@IA1PR12MB6330.namprd12.prod.outlook.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
 <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
 <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
 <a1161f7d-1a55-6200-7440-d615d5a41a6c@nvidia.com>
 <PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR11MB6803.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR11MB6803.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6330:EE_|DM4PR12MB6253:EE_
x-ms-office365-filtering-correlation-id: 1dd18812-37d4-4b30-7635-08dd898fd0c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|38070700018|13003099007|7053199007|8096899003;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:9; SRV:;
 IPV:NLI; SFV:SPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:OSPM;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018)(13003099007)(7053199007)(8096899003);
 DIR:OUT; SFP:1501; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j6Q0cj4D9Ubu+IDtvRPEsXzsH946CPof5bvXmVrWj3r6XRVg1/mvz3SxUFnM?=
 =?us-ascii?Q?NknZmW0HczmXdtAAt3b3zGX+Zh0gO5/ZZCq2yrAn7wZVwTrv2M7fVKKHLysD?=
 =?us-ascii?Q?0IXCmk0w2NV1TtLqp3n0VJeqNfHjfgAX45lOhUUGZJKKkpGnuM5PKlq2AJkO?=
 =?us-ascii?Q?DgP4FtrBXk9O1rjGGIuOl6NVFhbyK5Tce+151/tYLI6D8jr8gMZeBF+2satu?=
 =?us-ascii?Q?beqm/qMrnq/4NKo+2aB7DHgw4dhGGmS8KPre/rRs1e2LNjVGlgqyIQlfFGor?=
 =?us-ascii?Q?OEt1bjQwVO2pRFEQu5xVShsTySydmkvsJNlBh3oAOe5WxZq1LPnxeCiNZr5f?=
 =?us-ascii?Q?uETi1t6hsPJMygQGktdZjwQmw1b4l8kPYyzE/1orXGnHWB0vdYo98jAPFJrb?=
 =?us-ascii?Q?wLOBabY9raaNbcFwJjRZHWsmKViIpU1hQHhWHiApzQpQtfN5kcomZMd0kHyk?=
 =?us-ascii?Q?JZkY/EljnCc1RF4ziLGr+GGOZB/kPhkukJIk/Motd89Cafb1Dgl9bbbPgOYP?=
 =?us-ascii?Q?2hJTB6j0JcpquGe5UXCHj07MtgkuY/KsndNDgE4g0nopzgpQtKA/Ee7B9E8W?=
 =?us-ascii?Q?lk2bsgSrqmNOcIbA14ctsdHiVtLuoixNcGgCOg0kSglSV10KFSDyDjsE1reN?=
 =?us-ascii?Q?y8HBkXfS7dUofsJIMnkiBtO9RE+lEGkI1HiQI+/fnyYjQQL8VyB0xcVj5bfp?=
 =?us-ascii?Q?dQN43F0ZFKF1/Uon6/AYorbHowG75PrGD/MKDQ/Nrl4Oezt3gLReR5erbSVs?=
 =?us-ascii?Q?kTzrrS36RtzxXfYr1iXqC/I2tH59dhCgZuc5A4hLJJ6t1n98JUs5R3eLEu/G?=
 =?us-ascii?Q?7l6hnA1vdORAkWOi2//pPDIRNiyIcPYvD5EZTMbMdHCt4e+uo+ewRcWjDbxH?=
 =?us-ascii?Q?WWIbJ5vdfvsDJWo2sgCHcFrv2oulBSUaOvdWbCvEkn+bapld0WOr6wkOtDty?=
 =?us-ascii?Q?Logky2CtRaaPNERoWJCx56o5huaZinp8CHBAjscvApQHhWqA7oLVsAhasGak?=
 =?us-ascii?Q?YgfHKZHEbk2eq93QLA03SvR3aHCOaf3sSbefd9b/3O+ITjjWJuVl8y3L87Sd?=
 =?us-ascii?Q?PNWMZvNZG+Pm5PKJx0a9BeXiG0PukVtbedEXQVy/GCwZhE0EySW/6hBnNFUD?=
 =?us-ascii?Q?vhSyA44P0NSNq4yJ0kpBjJORqqGDZCKD95hvgVxoc18pxPxrTPT+vikaxY7l?=
 =?us-ascii?Q?ZTXJUw0BgFUTPhIKTyHjfuiLKknQfHMCi9/a8S05QMAh+LNV2K3ZFg3bZ2iE?=
 =?us-ascii?Q?48qCKmSwOhSu+St7HmKW2nc4/nRYEOFt+l+8dFJ1LDBDvx/EGGHeX/BweJul?=
 =?us-ascii?Q?TE/Bw3lmHPMDx7qZkZ96sxziF4sX8mhmh1eLL3hn6/FATKtiLRuVrZy3QK5C?=
 =?us-ascii?Q?3+hiYJNVtJebDmXiMVOhDl6fJzhiM7K9zGFGyfjhz/yzGYeX9UTEgD4JxYe7?=
 =?us-ascii?Q?0iNoDCEzYgVfpal9ErDs5etYpeFuykwZA5eOWdGi+xANf3/Xslc7d1c6MXqv?=
 =?us-ascii?Q?qMsVIYTqIjJUEs0LmFmHhld7Q7iLJpw5SzM4td6zjT20qoYgVzFfUjQfNZDk?=
 =?us-ascii?Q?ulox+e9AcShqk7Z79ZelkAOfayPAPzHbCnRkSfLqK2CYIfewavuB1fKh832h?=
 =?us-ascii?Q?2d57x7Zlohd/QDp8NqlnnduMop/18zQ8rsTjE1jbv5rQ?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB6330B75B3A6E4781EB147F78A58D2IA1PR12MB6330namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd18812-37d4-4b30-7635-08dd898fd0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 15:41:33.2174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 926b2g2hmof4LoPWDxoYIf3EEWM2iMsr94HfKHXnNU+DA/qpMkAZlTw5c3fqdNpW4o/jiU74WO01t/4AE8mbbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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

--_000_IA1PR12MB6330B75B3A6E4781EB147F78A58D2IA1PR12MB6330namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Bruce & Harry,

There is an aspect we've not discussed yet.

DPDK is a framework. It's integrated into a network application.
From the application perspective what is a ratio between "pure" application=
 code and DPDK API ?
The exact numbers differ, but it's clear that most of application code is n=
ot about DPDK.

Another question to consider - what is more complicated
rewrite entire application from C to Rust or, while having Rust application=
, upgrade or even replace DPDK API ?

DPDK provides a solid framework for both stability and performance.
In my opinion, binding DPDK as it is today with Rust can significantly impr=
ove application design.

Regards,
Gregory
________________________________
From: Van Haaren, Harry <harry.van.haaren@intel.com>
Sent: Friday, May 2, 2025 16:58
To: Gregory Etelson <getelson@nvidia.com>; Richardson, Bruce <bruce.richard=
son@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; owen.hilyard@unh.edu <owen.hilyard@unh.edu=
>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq

External email: Use caution opening links or attachments


> From: Etelson, Gregory
> Sent: Friday, May 02, 2025 1:46 PM
> To: Richardson, Bruce
> Cc: Gregory Etelson; Van Haaren, Harry; dev@dpdk.org; owen.hilyard@unh.ed=
u
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
>
> Hello Bruce,

Hi All,

> > Thanks for sharing. However, IMHO using EAL for thread management in ru=
st
> > is the wrong interface to expose.
>
> EAL is a singleton object in DPDK architecture.
> I see it as a hub for other resources.

Yep, i tend to agree here; EAL is central to the rest of DPDK working corre=
ctly.
And given EALs implementation is heavily relying on global static variables=
, it is
certainly a "singleton" instance, yes.

> Following that idea, the EAL structure can be divided to hold the
> "original" resources inherited from librte_eal and new resources
> introduced in Rust EAL.

Here we can look from different perspectives. Should "Rust EAL" even exist?
If so, why? The DPDK C APIs were designed in baremetal/linux days, where
certain "best-practices" didn't exist yet, and Rust language was pre 1.0 re=
lease.

Of course, certain parts of Rust API must depend on EAL being initialized.
There is a logical flow to DPDK initialization, these must be kept for corr=
ect functionality.

I guess I'm saying, perhaps we can do better than mirroring the concept of
"DPDK EAL in C" in to "DPDK EAL in Rust".

> > Instead, I believe we should be
> > encouraging native rust thread management, and not exposing any DPDK
> > threading APIs except those necessary to have rust threads work with DP=
DK,
> > i.e. with an lcore ID. Many years ago when DPDK started, and in the C
> > world, having DPDK as a runtime environment made sense, but times have
> > changed and for Rust, there is a whole ecosystem out there already that=
 we
> > need to "play nice with", so having Rust (not DPDK) do all thread
> > management is the way to go (again IMHO).
> >
>
> I'm not sure what exposed DPDK API you refer to.

I think that's the point :) Perhaps the Rust application should decide how/=
when to
create threads, and how to schedule & pin them. Not the "DPDK crate for Rus=
t".
To give a more concrete examples, lets look at Tokio (or Monoio, or Glommio=
, or .. )
which are prominent players in the Rust ecosystem, particularly for network=
ing workloads
where request/response patterns are well served by the "async" programming =
model (e.g HTTP server).

Lets focus on Tokio first: it is an "async runtime" (two links for future r=
eaders)
    https://corrode.dev/blog/async/
    https://rust-lang.github.io/async-book/08_ecosystem/00_chapter.html
So an async runtime can run "async" Rust functions (called Futures, or Task=
s when run independently..)
There are lots of words/concepts, but I'll focus only on the thread creatio=
n/control aspect, given the DPDK EAL lcore context.

Tokio is a work-stealing scheduler. It spawns "worker" threads, and then gi=
ves these "tasks"
to various worker cores (similar to how Golang does its work-stealing sched=
uling). Some
DPDK crate users might like this type of workflow, where e.g. RXQ polling i=
s a task, and the
"tokio runtime" figures out which worker to run it on. "Spawning" a task ca=
uses the "Future"
to start executing. (technical Rust note: notice the "Send" bound on Future=
: https://docs.rs/tokio/latest/tokio/task/fn.spawn.html )

Other users might prefer the "thread-per-core" and CPU pinning approach (li=
ke DPDK itself would do).
Monoio and Glommio both serve these use cases (but in slightly different wa=
ys!). They both spawn threads and do CPU pinning.
Monoio and Glommio say "tasks will always remain on the local thread". In R=
ust techie terms: "Futures are !Send and !Sync"
    https://docs.rs/monoio/latest/monoio/fn.spawn.html
    https://docs.rs/glommio/latest/glommio/fn.spawn_local.html

So there are at least 3 different async runtimes (and I haven't even talked=
 about async-std, smol, embassy, ...) which
all have different use-cases, and methods of running "tasks" on threads. Th=
ese runtimes exist, and are widely used,
and applications make use of their thread-scheduling capabilities.

So "async runtimes" do thread creation (and optionally CPU pinning) for the=
 user.
Other libraries like "Rayon" are thread-pool managers, those also have vari=
ous CPU thread-create/pinning capabilities.
If DPDK *also* wants to do thread creation/management and CPU-thread-to-cor=
e pinning for the user, that creates tension.

> Bruce wrote: "so having Rust (not DPDK) do all thread management is the w=
ay to go (again IMHO)."

I think I agree here, in order to make the Rust DPDK crate usable from the =
Rust ecosystem,
it must align itself with the existing Rust networking ecosystem.

That means, the DPDK Rust crate should not FORCE the usage of lcore pinning=
s and mappings.
Allowing a Rust application to decide how to best handle threading (via Ray=
on, Tokio, Monoio, etc)
will allow much more "native" or "ergonomic" integration of DPDK into Rust =
applications.

> Regards,
> Gregory

Apologies for the long-form, "wall of text" email, but I hope it captures t=
he nuance of threading and
async runtimes, which I believe in the long term will be very nice to captu=
re "async offload" use-cases
for DPDK. To put it another way, lookaside processing can be hidden behind =
async functions & runtimes,
if we design the APIs right: and that would be really cool for making async=
-offload code easy to write correctly!

Regards, -Harry

--_000_IA1PR12MB6330B75B3A6E4781EB147F78A58D2IA1PR12MB6330namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello Bruce &amp; Harry,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
There is an aspect we've not discussed yet.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
DPDK is a framework. It's integrated into a network application.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
From the application perspective what is a ratio between &quot;pure&quot; a=
pplication code and DPDK API ?<br>
The exact numbers differ, but it's clear that most of application code is n=
ot about DPDK.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Another question to consider - what is more complicated&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
rewrite entire application from C to Rust or, while having Rust application=
, upgrade or even replace DPDK API ?&nbsp;&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
DPDK provides a solid framework for both stability and performance.&nbsp;</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
In my&nbsp;opinion, binding DPDK as it is today with Rust can significantly=
 improve application design.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Gregory</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Van Haaren, Harry &lt=
;harry.van.haaren@intel.com&gt;<br>
<b>Sent:</b> Friday, May 2, 2025 16:58<br>
<b>To:</b> Gregory Etelson &lt;getelson@nvidia.com&gt;; Richardson, Bruce &=
lt;bruce.richardson@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; owen.hilyard@unh.edu &lt;owen=
.hilyard@unh.edu&gt;<br>
<b>Subject:</b> Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth an=
d Rxq</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">External email: Use caution opening links or attac=
hments<br>
<br>
<br>
&gt; From: Etelson, Gregory<br>
&gt; Sent: Friday, May 02, 2025 1:46 PM<br>
&gt; To: Richardson, Bruce<br>
&gt; Cc: Gregory Etelson; Van Haaren, Harry; dev@dpdk.org; owen.hilyard@unh=
.edu<br>
&gt; Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and =
Rxq<br>
&gt;<br>
&gt; Hello Bruce,<br>
<br>
Hi All,<br>
<br>
&gt; &gt; Thanks for sharing. However, IMHO using EAL for thread management=
 in rust<br>
&gt; &gt; is the wrong interface to expose.<br>
&gt;<br>
&gt; EAL is a singleton object in DPDK architecture.<br>
&gt; I see it as a hub for other resources.<br>
<br>
Yep, i tend to agree here; EAL is central to the rest of DPDK working corre=
ctly.<br>
And given EALs implementation is heavily relying on global static variables=
, it is<br>
certainly a &quot;singleton&quot; instance, yes.<br>
<br>
&gt; Following that idea, the EAL structure can be divided to hold the<br>
&gt; &quot;original&quot; resources inherited from librte_eal and new resou=
rces<br>
&gt; introduced in Rust EAL.<br>
<br>
Here we can look from different perspectives. Should &quot;Rust EAL&quot; e=
ven exist?<br>
If so, why? The DPDK C APIs were designed in baremetal/linux days, where<br=
>
certain &quot;best-practices&quot; didn't exist yet, and Rust language was =
pre 1.0 release.<br>
<br>
Of course, certain parts of Rust API must depend on EAL being initialized.<=
br>
There is a logical flow to DPDK initialization, these must be kept for corr=
ect functionality.<br>
<br>
I guess I'm saying, perhaps we can do better than mirroring the concept of<=
br>
&quot;DPDK EAL in C&quot; in to &quot;DPDK EAL in Rust&quot;.<br>
<br>
&gt; &gt; Instead, I believe we should be<br>
&gt; &gt; encouraging native rust thread management, and not exposing any D=
PDK<br>
&gt; &gt; threading APIs except those necessary to have rust threads work w=
ith DPDK,<br>
&gt; &gt; i.e. with an lcore ID. Many years ago when DPDK started, and in t=
he C<br>
&gt; &gt; world, having DPDK as a runtime environment made sense, but times=
 have<br>
&gt; &gt; changed and for Rust, there is a whole ecosystem out there alread=
y that we<br>
&gt; &gt; need to &quot;play nice with&quot;, so having Rust (not DPDK) do =
all thread<br>
&gt; &gt; management is the way to go (again IMHO).<br>
&gt; &gt;<br>
&gt;<br>
&gt; I'm not sure what exposed DPDK API you refer to.<br>
<br>
I think that's the point :) Perhaps the Rust application should decide how/=
when to<br>
create threads, and how to schedule &amp; pin them. Not the &quot;DPDK crat=
e for Rust&quot;.<br>
To give a more concrete examples, lets look at Tokio (or Monoio, or Glommio=
, or .. )<br>
which are prominent players in the Rust ecosystem, particularly for network=
ing workloads<br>
where request/response patterns are well served by the &quot;async&quot; pr=
ogramming model (e.g HTTP server).<br>
<br>
Lets focus on Tokio first: it is an &quot;async runtime&quot; (two links fo=
r future readers)<br>
&nbsp;&nbsp;&nbsp; <a href=3D"https://corrode.dev/blog/async/">https://corr=
ode.dev/blog/async/</a><br>
&nbsp;&nbsp;&nbsp; <a href=3D"https://rust-lang.github.io/async-book/08_eco=
system/00_chapter.html">
https://rust-lang.github.io/async-book/08_ecosystem/00_chapter.html</a><br>
So an async runtime can run &quot;async&quot; Rust functions (called Future=
s, or Tasks when run independently..)<br>
There are lots of words/concepts, but I'll focus only on the thread creatio=
n/control aspect, given the DPDK EAL lcore context.<br>
<br>
Tokio is a work-stealing scheduler. It spawns &quot;worker&quot; threads, a=
nd then gives these &quot;tasks&quot;<br>
to various worker cores (similar to how Golang does its work-stealing sched=
uling). Some<br>
DPDK crate users might like this type of workflow, where e.g. RXQ polling i=
s a task, and the<br>
&quot;tokio runtime&quot; figures out which worker to run it on. &quot;Spaw=
ning&quot; a task causes the &quot;Future&quot;<br>
to start executing. (technical Rust note: notice the &quot;Send&quot; bound=
 on Future: <a href=3D"https://docs.rs/tokio/latest/tokio/task/fn.spawn.htm=
l">
https://docs.rs/tokio/latest/tokio/task/fn.spawn.html</a> )<br>
<br>
Other users might prefer the &quot;thread-per-core&quot; and CPU pinning ap=
proach (like DPDK itself would do).<br>
Monoio and Glommio both serve these use cases (but in slightly different wa=
ys!). They both spawn threads and do CPU pinning.<br>
Monoio and Glommio say &quot;tasks will always remain on the local thread&q=
uot;. In Rust techie terms: &quot;Futures are !Send and !Sync&quot;<br>
&nbsp;&nbsp;&nbsp; <a href=3D"https://docs.rs/monoio/latest/monoio/fn.spawn=
.html">https://docs.rs/monoio/latest/monoio/fn.spawn.html</a><br>
&nbsp;&nbsp;&nbsp; <a href=3D"https://docs.rs/glommio/latest/glommio/fn.spa=
wn_local.html">https://docs.rs/glommio/latest/glommio/fn.spawn_local.html</=
a><br>
<br>
So there are at least 3 different async runtimes (and I haven't even talked=
 about async-std, smol, embassy, ...) which<br>
all have different use-cases, and methods of running &quot;tasks&quot; on t=
hreads. These runtimes exist, and are widely used,<br>
and applications make use of their thread-scheduling capabilities.<br>
<br>
So &quot;async runtimes&quot; do thread creation (and optionally CPU pinnin=
g) for the user.<br>
Other libraries like &quot;Rayon&quot; are thread-pool managers, those also=
 have various CPU thread-create/pinning capabilities.<br>
If DPDK *also* wants to do thread creation/management and CPU-thread-to-cor=
e pinning for the user, that creates tension.<br>
<br>
&gt; Bruce wrote: &quot;so having Rust (not DPDK) do all thread management =
is the way to go (again IMHO).&quot;<br>
<br>
I think I agree here, in order to make the Rust DPDK crate usable from the =
Rust ecosystem,<br>
it must align itself with the existing Rust networking ecosystem.<br>
<br>
That means, the DPDK Rust crate should not FORCE the usage of lcore pinning=
s and mappings.<br>
Allowing a Rust application to decide how to best handle threading (via Ray=
on, Tokio, Monoio, etc)<br>
will allow much more &quot;native&quot; or &quot;ergonomic&quot; integratio=
n of DPDK into Rust applications.<br>
<br>
&gt; Regards,<br>
&gt; Gregory<br>
<br>
Apologies for the long-form, &quot;wall of text&quot; email, but I hope it =
captures the nuance of threading and<br>
async runtimes, which I believe in the long term will be very nice to captu=
re &quot;async offload&quot; use-cases<br>
for DPDK. To put it another way, lookaside processing can be hidden behind =
async functions &amp; runtimes,<br>
if we design the APIs right: and that would be really cool for making async=
-offload code easy to write correctly!<br>
<br>
Regards, -Harry<br>
</div>
</span></font></div>
</body>
</html>

--_000_IA1PR12MB6330B75B3A6E4781EB147F78A58D2IA1PR12MB6330namp_--
