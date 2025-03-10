Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9839CC282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 16:33:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A930E40270;
	Mon, 10 Mar 2025 17:33:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8092E400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 17:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741624418; x=1773160418;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7VZQPxrFR2IadIyq8u4bs4SR9cx4696UAHvzN83W924=;
 b=P8fb5LTyJgBzPvqxQw+jtN8YqqpfKgoDvTHOmEblVnRvu0BeCQ4cItfA
 cAfhIx2fwcgmdQ4LXGz1w+Dr3WXe5dZgJuOQwNvHZc7BEKl0iyeVqdI/4
 Em1BOx4voLPE5MpccbQvmWT8XlL7QoGff7lA1iyLoO3lLjDX5VB4A1zC0
 oGaHlAS4cqXZS7lZMCNgLvF7OVRQMFcP7EH9tU2/wGwXo2NxnY1DFjZaS
 iDGAgIv7rIrguiyAd6+oqBWuty24ETxpGFN2buxrR5bvT3L9MMWnOgX91
 OKVKsxrvvE4Clf/M1LC40OrPWGBrxbYykov25OfcTsdYVFEvOfq54Et8x g==;
X-CSE-ConnectionGUID: thkJRJbSQAyKr024LBbnAA==
X-CSE-MsgGUID: J8GLrdI5S1OpYTxSCWdaRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41797397"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="41797397"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 09:30:57 -0700
X-CSE-ConnectionGUID: lImIFlMnSCmYEaJbt+X0Vg==
X-CSE-MsgGUID: 9G273tRyS+m2XxErNLMb1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="143241911"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Mar 2025 09:30:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 09:30:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 09:30:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 09:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObdHIxBS/WgUhW+1jn4hAKbSK9MMMcKxfW7c3Mf5rEFL0IR8rb+Nu2IvzET8XUKurjwzd+DHNHh0ctJ5PGf5/mCawYu18ctm3i2eMzppP8Isux1wuPZ4Zp1FT2p1Qfa20mcjApbsA0QntQP3W8SBoe3KxEsaQBY9Y1nfAkywJkfcE5P3DCTTi/K/fHQHb/2fOr6gvWpu1WY4YmhJ0IQRV+YssuPBtLZULAQ7IO45SkELfKGICB5SZHrkgJ5uOSbkhhrU9GhIqSd5ZPKRnFZ3VZUISuNdyHBDh6WuDv9hObhlqvN/m3ulHKOAP83mgFbERbX3VvR0b3Bpup0jiA/CQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVZ9i/a6UdbOh4bx6jCap7qCsI/C1+jiwqRuMnNTaFY=;
 b=xXr7/KgxEvGamWyXMdO7qMsYpLVaVaZedAN6Y8Hqkt2MF/rrzw43jDDTUjST8CvoAASZmJ6qRVFoUkjEO4mqM9Z8YV7EJf1o8eNlQTHzFu7YW8uIZy46G4OhILuDANKaxnRImkX33B0BF3+cr0Dh3TDHYdoRrVDe5S+ftovG7uHvw0Mbh5wWJQzsaashpZMFXy+/hA7zCYHzW5EojJM7BKJm8FtPn6BrRL9yOMiYXOw76dn2BxFqQnkpC9emHNcdB5xNwf+r7CAKTaJ3ERcq/eTMgagebYK4FiJP5etWAg0EboTiKLupCjVCZ3ve2143YMQbJQHuIcCicm62kGnyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 16:30:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:30:38 +0000
Date: Mon, 10 Mar 2025 16:30:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Gregory Etelson <getelson@nvidia.com>, <dev@dpdk.org>,
 <thomas@monjalon.net>, <mkashani@nvidia.com>
Subject: Re: [PATCH] rust: support DPDK API
Message-ID: <Z88TqaPhnMtBb_zD@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250310091844.4a3ff0d1@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250310091844.4a3ff0d1@hermes.local>
X-ClientProxiedBy: DB6PR0301CA0087.eurprd03.prod.outlook.com
 (2603:10a6:6:30::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afa5954-0d4f-471b-e2f0-08dd5ff0e3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2JavExOti+q7HZygM+YUdMOsNLYD6TpMQj80czamPD1ac3CprX17HwD2wvcH?=
 =?us-ascii?Q?FkU9PGHThtbHNnb8LORpY9RGMFwj6J7cZIoWutgNwPgWPxoqgleibB5yC6EJ?=
 =?us-ascii?Q?1FaXRmVd/c5Eng5whCFQXG7enO6uJ6z2AWG/TzHmvMNEM1hcK5BJknnJ6MNo?=
 =?us-ascii?Q?wfcIxSeFld9r3mXI/2CDh/kvtER8YCYM/wq0zn2pW+qu4Sg8lIeyydglaVP8?=
 =?us-ascii?Q?gSeiPUPu32IoMvD/ic5q8ol8PRxcp+HKaMbuR3nI2HgKdDuev5QhoixddGLy?=
 =?us-ascii?Q?Kzh4Ul7KaR1sxXFpHSS5CfjGNh1Fbh9H4BbS/E2AlDz++XywacgkwkhchdOb?=
 =?us-ascii?Q?M8LNjyofyfYZURF5FJsscWGxZb1XGTHdL7Bg76i4s0YwAQMw2iXvSjtpm74i?=
 =?us-ascii?Q?zYd3UGUX4BGQv/EI71hjpNY5Gok827Oz9OiRQJeUn+UT72NBLjrc4qfbksXy?=
 =?us-ascii?Q?Szzj0p+ax5T9KJjUgsTiWjyga7LFBC8F82L+GzpXr8sye09CNlTxEwuAEYxY?=
 =?us-ascii?Q?C3llGM9sJoWvOUYHXXpyaTjvrir8kvkuNQVH6hp+8XUb0tPV3C4LiWVQ/WpL?=
 =?us-ascii?Q?hG5cEPtZ8pljdphlc7OCODNnvbh61FnmnGNK+/gl6K8ZZyhruBBN5mzloAIL?=
 =?us-ascii?Q?n8SQyXDPKPbg3jRpO303f3vITQcggpY41wiEjjeCke8gGR9AayXbBFXL5zB5?=
 =?us-ascii?Q?uyfODhs0nC42clSSgq/1Ad5RgFrMUHblnPpYcw5AlXg9RtQO9+pSgvOYOawh?=
 =?us-ascii?Q?ms3KGDD5nqEd7wlLW1WSWgwh4tnUI9eEdiMaelZWN+Y3T1hFLXl01qUmyl5v?=
 =?us-ascii?Q?nvR9Gwr2WBCS2qUtgNRUobwgiv1MLRjPmlsE4+QqXW7zQtciENA4vrYIiRiN?=
 =?us-ascii?Q?Qe+JecOyZhKBlx5or2I8FCL1MgyUsNSdO82cK1pMYZyQKhHa5hi9RRpIU7eq?=
 =?us-ascii?Q?H3osfr3MqiRlHrpyP/dICJH4Rs2J+rmvpbZHdODCccNAzNF0vjmYvAl9lq8k?=
 =?us-ascii?Q?DMwJc3QbhG8LELIKr4+oIQPYELreeMaB9BH6X3lgof5Ny7W6RaMmkKnFP3Pv?=
 =?us-ascii?Q?bZv8OpHTUl6DU07KOM5jGbHg9uuc20v90Jt39+NElMjB6e/tIfywx7I/uqPh?=
 =?us-ascii?Q?KZCZ716KSKO4ebrEDc4bo6kzpGLuazbTUwwo6G7nWRSURy/0b8BlfBhPjrZf?=
 =?us-ascii?Q?g+hbJuLK3E6nP1WnutuxaTzWnjfLWz+Wi8oFEvrS9qr61Cn3Z9gToUUBOJlZ?=
 =?us-ascii?Q?T9GzwG63m76nXMj9H874iANRt6cKKYLonwyOYeUPqotjMpzfH3ASaq69XGqF?=
 =?us-ascii?Q?XWzlOi7/XTOrRzXyUAYDfrQso88Bqjcsfxl3JQZlOqMfc0hh73sCEosJ0G0Q?=
 =?us-ascii?Q?CdLEk96Ct4zSRmUYGoLKs96VHybI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZWSwAN9hSc1ZCCfG2wUxoov2jr2P5eUswU+rDuffjxIGbplZwtR448Mpnamo?=
 =?us-ascii?Q?mbWYGe5NoYcKwpmn2oIsGYMk2lsFCIKgnlHd+3e8OT/1H2L7wYAJGxHg+nIw?=
 =?us-ascii?Q?0M0MZAZt2oDyZdD78DG2Q2WSl0VeOcTMcMXdO0+0SlzrXanHGCxM5vhIx/iQ?=
 =?us-ascii?Q?eYGWagRXAQxG7qrwkr9KpblMmbVKjXHk543X8ShyBmmV36Ve4sy26Y5GZPW2?=
 =?us-ascii?Q?skWaOy90BDf+mfpdA/dERAdAs1QqKKFqNtslArsU8MGzfD5iVZN27noGQgnN?=
 =?us-ascii?Q?EaAnsTZ9NypKBV6sgIbSdTQUzTCZAFAuOrzmEmo33UrmPlCuy3Rd6F6R6kY+?=
 =?us-ascii?Q?pc52njEadIQiGh+XYoHlUXNt173X3irbDd7HAkAreZYScxheYmdC69Ikdn3Z?=
 =?us-ascii?Q?v5eLu/ers5HjoU7xOyuRqLNLR+h/0hwoijw3MoCiAS0Ury+RAuFF0UfpmfC7?=
 =?us-ascii?Q?hNdOl/u4M/D2z6kH0PEPMp5KOIAPC5AyY7ym8bMJD1Ymo/SEJL3LEwMRPpNB?=
 =?us-ascii?Q?CvnfB7UqRmjnjIqYg+VYh+rYWJCv79PDP5232ski1y34mv92zODTcLgdhCRy?=
 =?us-ascii?Q?uHrE6bSBCNBvqKlZxxmxbwFHNablgPPJie43fOwuxO0GZor6mW3hN1L//GFs?=
 =?us-ascii?Q?MjIt84DC7fb/AN8laAxXiCm0Dbo1s1j9emBhFPEqDiXyGtzwS8sb+EkXndKO?=
 =?us-ascii?Q?Vh1hLZwm9g6bucPbHyowbAWTcAhWrhe+qQh4HCO+VBqZ6GgCJEvdR6sR7UFM?=
 =?us-ascii?Q?65IvMnmRURk7XO11QkcgauW5zJM+VbhGlSLy2DJRcjjy45NekW+JKwthDZ0p?=
 =?us-ascii?Q?P7qThKQa5tu/mcV1c6goYOtj4h5gsXCzns8c6I504Y0JCfjAdcdSDohiIKiI?=
 =?us-ascii?Q?Mv0geQeuuG5hjsuixN7yXSqvI6XaVcxgETx78/MTakzqUIWUyHg1Q8vMZyYm?=
 =?us-ascii?Q?txunUA6LrOuV/RbZGdodJZpH2Hbos1NfCJ0zo2/ing24A40S0k/sFCrHXIwu?=
 =?us-ascii?Q?NgUmEpJXV+gomsGPmyO0uKgWDjyNAIrQ/eY6Cuj/MMf/1WNxYjpGFKJWnGrn?=
 =?us-ascii?Q?nscW1FZRarX/lpvekneH17aIl9XTjtUSn/IooIgtHu8ljICRnnWGMlM99LI2?=
 =?us-ascii?Q?pGvwJodPakPvGJnlqkOSuDQobzJ+pcAx3G+SGQZtCM5UKDm5fnvvCKSgtia7?=
 =?us-ascii?Q?GjseLDhdVyPOO7NtUA54/VgMn3M6IZucELknB8EVbqsLKiV/6sMQAq0WjltO?=
 =?us-ascii?Q?v+d5jhYT48d9TDZOUoH0yy3Ocg8Hyi2Z04f24LgNi+IBFyWOqFFmoEjUH1Lf?=
 =?us-ascii?Q?9b7GgWFY5Q8RTuyEabiSJzfMinDd9ONAa62TWA0BVQ344UB+CMwEHqQkvQDu?=
 =?us-ascii?Q?WKDvFruGpiWZBFOGzkLTb8U20M9to6seMtbRMEq1KhFC+VU86qxP6cNOqAQ6?=
 =?us-ascii?Q?dt/Z2/ilH8SdeVKSPdfoFts/JtTOWHQw2O6wFuh3oxyajJGoyj5zM/ZoB5SN?=
 =?us-ascii?Q?OXE6IhJcBAPGAVPhRtPKuiNBnu3ih86Em9GEe/22pvslvfYHYf9SEvOg1+Aw?=
 =?us-ascii?Q?JZdpKRr+FrSQzMk433g+yvvqyVfn8Gaey5gg8C0erI/DIVEwIfAfW2OKQS3x?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afa5954-0d4f-471b-e2f0-08dd5ff0e3f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:30:38.0603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UT+DpySSBi18dIs1QciKcSTS4w63ksCakbW2vEi89fZH7CVKdaIJRehw9PmpwQY3fNslSR7L7+ufAaAvN/t8Biv0e538uSbclDL3eUxalE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6424
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

On Mon, Mar 10, 2025 at 09:18:44AM -0700, Stephen Hemminger wrote:
> On Thu, 6 Mar 2025 15:37:13 +0200
> Gregory Etelson <getelson@nvidia.com> wrote:
> 
> > The patch converts include files with DPDK API to RUST and binds new
> > RUST API files info dpdklib package.
> > 
> > The RUST dpdklib files and DPDK libraries build from C sources
> > allow creation of DPDK application in RUST.
> > 
> > RUST DPDK application must specify the `dpdklib` package as
> > dependency in Cargo.toml file.
> > 
> > RUST `dpdklib` package is installed into
> > MESON_INSTALL_DESTDIR_PREFIX/rust directory.
> > 
> > Software requirements:
> > - clang
> > - RUST installation
> > - bindgen-cli crate
> > 
> > RUST dpdklib installation instructions:
> > 1. Configure DPDK with `-Deanble_rust=true`
> > 2. Build and install DPDK. The installation procedure will create
> >    MESON_INSTALL_DESTDIR_PREFIX/rust directory.
> > 3. Update PKG_CONFIG_PATH to point to DPDK installation.
> > 
> > Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> > ---
> 
> Re-implementing test-pmd, l3fwd, etc in Rust is OK but not huge leap.
> The real benefit would the ability to support PMD's built in Rust.
> That would be much more invasive
> 

I'd actually disagree here. I think there is far more value in providing a
good, safe set of DPDK APIs and structs for apps written in rust. For
drivers, there probably is some value, but reading/writing registers and
descriptors will by its nature be unsafe code anyway. I'd also worry about
the complexity of trying to mix in rust into our existing build systems
etc. I've actually written some test vdevs in rust to interface DPDK, and
the amount of crossing the C-rust boundary that was necessary was very
painful. There were also huge difficulties around linking and run-time
usage, symbol conflicts etc. etc., due to building rust separate from DPDK
itself. All solvable, but complex and of limited value to the end-user.

So therefore, I'd concentrate on starting at the app layer, and
worry about lower level things only thereafter if we need it.

/Bruce
