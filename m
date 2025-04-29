Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45519C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 12:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 111F6402AB;
	Tue, 29 Apr 2025 14:52:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0DD81402A9
 for <dev@dpdk.org>; Tue, 29 Apr 2025 14:52:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745931165; x=1777467165;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=89cYVXG9Zy8Q/gn+2L7wsN1Wv1Ns9w1U3ly9iewtxmY=;
 b=GClgIF+3WEvVRM321cChyGXvrNG9O0xPfKz2jdqQ/oq6oEGMXbJy3ogF
 iAw0y2zD9BCu1WcG7AK1Vixv/nYo0p6OJBpN4b+diXGJGdkidjmqUwe4l
 kOFchKviuIFvNURp/rqisi3v9stXLRTXIxUsw28y1XDRvOmUtPW8Ro+9b
 Y2ntcHKnPBhlOJTIgLDPYxeJCe2ijrQl/Z1V9kgDUZXKyjBmMbQ0/I/if
 bHUe37epiHj0qXgclZwEy/MsvvKU8O1TxvXjrKXKGxJrS8KxihSAYm6hz
 LCubc1D5O01lGCH9kzWCWZZkKWSP4nfgdy43pvprStURGKgFzBg18IWnT A==;
X-CSE-ConnectionGUID: xeNYm69GQtWz524v7kdcqw==
X-CSE-MsgGUID: YdN46otwTTi5UbRtMKYdfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47460727"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="47460727"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 05:52:44 -0700
X-CSE-ConnectionGUID: HR3xVmCdQDKWpDX6wWKerQ==
X-CSE-MsgGUID: ctyLmDI3QyCIkxzC6O78+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="164770807"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 05:52:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 05:52:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 05:52:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 05:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waJR/R4ipNS0XnZXCde81vUvxzfTWn7XkRq/E7fnO1uhNBphDVZP2hDyCOI4Eb3qSUrCg/8ItLIV1C/VZATk7ZGjO+gPUva+s9ER5Kfxa0kFRDLKdNxtS4z3NbrKW9gkefQ0P5VBFKen2gACEk8goY/oCyrWv20sgAp/pcA8kayid9wbofVnHb/9pBxtyvNLzKlSX4TgIN1q56aoX0K73Bi5MIYHUh7gN+5FM/FKuWYtq6RcxMcx1qycNhOUSzBN9Jkio4/SK1l15dTTyEGW6KIjzmQlcEHWtooVXTMAaNYVHLvbplGUtK+ewS1HxIHQGGRbPttgrS6ejerGRR46GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TKr5PI6yhVviSASQ2URsEREQ9Q9Q6dy/jIfTz3Zxn8=;
 b=khQZHjJT3iRfRe9fCe3EOhmvddRyAQYvx1hyjHoAaBZ9/elg1EjmwTbGtPbs23MGUUuqrdP3mLAcsUQECTBY5ww7Vh/V+lQ40GEsyUEV6ycrR6TwAT4eEvPD9r17nREcqYdhqh5BIKNTlsWt8rvG8ikNT1cnQoydVAQnUo13EGt4C6+PSLDzSrNVF2nTwpdwjM0rRYVUe5zyV3dYUodLgPUbEw+bvebx0mIig0gopq+4ITbNGlkvO1mwZ3mi0CB+cj72ppH9rlxCMDq2FaG0oaEBhMAFUbLBELGIRNybV/MuiUQeNtRm9KcmnuKu7QDaRJI75yYCXSnxqiL0wwx1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB8891.namprd11.prod.outlook.com (2603:10b6:208:56d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 12:52:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 12:52:41 +0000
Date: Tue, 29 Apr 2025 13:52:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: rte_eth_stats_get seems slow
Message-ID: <aBDLk4GKhtJzn6Ye@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC02@smartserver.smartshare.dk>
 <20250426082352.260b9b5d@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC03@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC03@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0188.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 36153d2f-b56b-494b-4f22-08dd871cb9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?HP/Xkj3tvtrNyeDMvFu0oJnJwZPSpqudgytpZktV95xuBLDZyFWy3X+mSL?=
 =?iso-8859-1?Q?+uNucOtN36YWlKC6sWyn9JVIN6Zmt5lr9lG7vP02MPaH3GgHAZykmSCGaF?=
 =?iso-8859-1?Q?GhWRu9QEGYvPp3LhUL2w2NS7mjY0f9bFEdINx03UUrNKlAMn72gNKCDpLL?=
 =?iso-8859-1?Q?pG6Uau0HenYsIJcwYHzffCmzM23gL3k8h9YdoCrvqe3rKXDsungQp4l5D1?=
 =?iso-8859-1?Q?sHDRxbxR9kw8FlViTI+ZIwlTHPDyVRxN9zDftTaSJfDiLJT5EC2whKXB/0?=
 =?iso-8859-1?Q?3CetdACT0nsUbFpK4LsQQ6+vNARL2+si1Qr8efmzXq4gLK3ltwEJGT7sG+?=
 =?iso-8859-1?Q?D9PmuBIDtmr8qYctW11aVEt6zCoVocZh9ya8e8iF/RvY7qCwj75o1UZJtO?=
 =?iso-8859-1?Q?qAdCx+mg2xmmV6xQf3I2jz0syKT5+Xn3glU8aYJq20HN96U/RCwco6u90m?=
 =?iso-8859-1?Q?QFGNlrdk9nR9UO2g4xLHnAR0xF4M57wE77jkwl3KOP5TkiIcxpfaj+Fj8r?=
 =?iso-8859-1?Q?5aCa24vVzJHxinOl+K0mb89Jd9GVwf7XUSa0Q1HxhaD/NleF7j+KoRHHTg?=
 =?iso-8859-1?Q?2MW0he3+Iv4VscYnm/B7wd6jWakNyoDnL87IfM9zSMaqxrGW+P1AAeBgaO?=
 =?iso-8859-1?Q?U4b+Uh9Z4+2/k8s1daXosAxv4IY3VuNBhiFAolQcUtBC5UzEx+zo7XH1lJ?=
 =?iso-8859-1?Q?A2RlfTTauFTsU90VmdH5gjCgPIfErIvxymfeI79WH/umXRUO163DTQFszI?=
 =?iso-8859-1?Q?uIVkZPZPgn94UYQL0SYUn5vkSnnHAZzjU2foTG/PC3lsnQSDC6HvMIiBy/?=
 =?iso-8859-1?Q?g9572d/9FYb1sI54Lvb+fxezvoVxiUN30+W+8tLSXUF7HSzpmG9IMEELZg?=
 =?iso-8859-1?Q?BPFXXGWBbGUya0y3rXYlrNEfo/aR+nSPlp/Y14cpji4bOMzUDvEXH2AEkq?=
 =?iso-8859-1?Q?5UnqdU2TzRb0kz1bnC5u1NAa/XDUiIcM84WMdfxEjw1MAyu4e99QKzuprS?=
 =?iso-8859-1?Q?btQsYvq9rnaU0XA1YIjICYGs9L9oK11kZd6hL9SbRvlX6ojvASZdxljmPn?=
 =?iso-8859-1?Q?7wuQlQtQvB9aow3tL/SIt9qL/cjMYp8C1wE5aKAdnk5Cj8vee8Fa0tkllu?=
 =?iso-8859-1?Q?11YpfSTNH7/Y9w4xmOakErvrjX9kMjoGxb18d6E89TAipIkzBa1ljGycJ3?=
 =?iso-8859-1?Q?LgvlvFMoJ1NG5G2EqrJiNmYLRLICjwy+o8RwNRPEJbEjZMa0TuI8kduaPH?=
 =?iso-8859-1?Q?uaaGI0bpKrwHz/8Fr4ByookQVBbIXvLXGhPqFLaoRV9fHqoGYaCAPeo2fl?=
 =?iso-8859-1?Q?HxuG48YaqVr1eODqDA5pgJt8WS4qa9avqYNBLLvJy1J3nU7gZHLPmP77eN?=
 =?iso-8859-1?Q?/kaeRPX3nSSTbFp0Jp+DC+xjMUyWwGIf+I9RwLV/r5fBpDF7sbmmU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PnPhXSkQwcUTCXAUMy4Ew3/nJP6OgfDq6gvCuydY2MaMO0c+nVdNvwiBr2?=
 =?iso-8859-1?Q?DA9Q7Qd9/UsvMOb2CJCv3TlO8KzSvUDJimm4qV1zOi+8w8hP+nrddRZUqc?=
 =?iso-8859-1?Q?FE+A9S0dQCR2n4ZRV1ul32BabdYOLNU4aNmIhG42YFMj9IwLvLD+2favQH?=
 =?iso-8859-1?Q?q4DScSzgm9ni3Hsbt9DE2r+D8iM14PrxrG5jj7Ofili08bVeYsBArPYmpo?=
 =?iso-8859-1?Q?uvuHzRCfYeSi3EWkOAgyNQk78lvvHwsllWGVR6hi4xGwgLCjMV0wZq8jfm?=
 =?iso-8859-1?Q?E2uFThRJXvsrHJjrWFHLAL7h0xff+Gh7/wScgKrPfAoFpdBXsR3keM27zi?=
 =?iso-8859-1?Q?vebiP0fktkfsQXiL3J8XN5JtgFKRpiwkcDC9TC93i9Y0jPlRfjrR7WY8lB?=
 =?iso-8859-1?Q?va0tMW0d4oVmqqlpMJs/Cbc8WqYTXZGWz9rKY+o89O++xw1isaB1bu4txd?=
 =?iso-8859-1?Q?pDEbvwcDPNMTqzNkP0IZPV82DerQ9xkY+nzF+zx3PuKl1lQvyx5kvHnqd3?=
 =?iso-8859-1?Q?BJCn4WzH8f+dfJPXPAdVn439pCc6hMXzgNk5A68kZTdN0kQnrry8Vw9EX7?=
 =?iso-8859-1?Q?1I6+dIMCLZWnv7p+HqNO8zjd+sBMX5lS/vGaHfJcDuhiF9KmaM6yag2/Fj?=
 =?iso-8859-1?Q?3Q50oSJtKZKf1cabDFJEnxaJqIiWeGNjDdCxFTtzv6ZnlOOClYhyRdcXAi?=
 =?iso-8859-1?Q?t+aJgfZZfkjTrLcyvudnqdi6+huLacArQTIrM0yNeklHtQSpld92Up6O2P?=
 =?iso-8859-1?Q?JQZ586booD3WWOg+q2vXxTblng/jyBlFJ5Iv+A0AUMHQjLf3YQl9hf9cpF?=
 =?iso-8859-1?Q?DXCp23eMMEYlyVvpNDyJ2PNDtT5I8N7xqehDkhuCx46xoazqET9HBg1lsH?=
 =?iso-8859-1?Q?/BsoOMbhjfwnylohUGlcov5KILv/SW3QEBmoYuGpgrTIohtkgGUty3l+XN?=
 =?iso-8859-1?Q?lBzeF7HtDfgL3vcjKgD1GJ6knXcUypi+PKOxU1AVBAmicbXFAAqJzTupDY?=
 =?iso-8859-1?Q?88LOqpqca4lrNZVvZAkDsciSdcHxualcGD86OhsMNHwPPXY6X9hI7CUmM4?=
 =?iso-8859-1?Q?IW24UJYqMrRVQseN9mEMkKhFsW37D8Ijw4T5LLQfqbeKvJ8LBFsS+ZN8Rz?=
 =?iso-8859-1?Q?7pGTQ3zDH+PSC8Yk/R38SruB4aY8geM7+ioUdAYABPUQysqU005nxr3r48?=
 =?iso-8859-1?Q?5+JqiFKrBeW7LHcNWKF5H2chfhIPGjQ7pQE96PEITpw860cG8+G+EczNlE?=
 =?iso-8859-1?Q?7rD3b42gzB5wW5Gdna3j8c/KxP2qiPz5LPgu7fqOtU/EjT5z0ZgotWDBmu?=
 =?iso-8859-1?Q?8wMzO6YIg7S1WF2+ifRN2seslffW8rmFEXN0SXZTyTsK6dcZGO+JOyNDme?=
 =?iso-8859-1?Q?/VLhpOEy3z/rOrW1UO57ddYRQmLTEIDYluN0i4hZ2Q46GjTj5rwl7Ajujs?=
 =?iso-8859-1?Q?PLmJtdBYx9KpKhLfGcnrAu27i90W2vENfeqk6dtZMmEi9KmbvFBmwJF7h/?=
 =?iso-8859-1?Q?3AeQ9lE12i1dFAfTZFeaTLtwIDdAPUSQhc7A/rjraxofUnXYRPFxpKk80q?=
 =?iso-8859-1?Q?0jNt8gRwNZeeug6JVbpGAISAOxKHb1nf4WR4bkxdE5i4+H0nqq8i34In52?=
 =?iso-8859-1?Q?6wlkNxZiJ91U7dxNsEyrG3y8oWf+gsZhc4xbvb5JMx8cHW9Z9FmLQ0xw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36153d2f-b56b-494b-4f22-08dd871cb9ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 12:52:40.9394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fupdyABed1pRiIjI51vk4KBgy/bWsH0aXO612ZqFZ70giX5bZjzMynL7PnmP8RXEW+py0jl6lU2Q/x+I+alOooDMHC+SWZQkRdQmSrbeiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8891
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

On Sun, Apr 27, 2025 at 09:00:31AM +0200, Morten Brørup wrote:
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Saturday, 26 April 2025 17.24
> > 
> > On Fri, 25 Apr 2025 13:52:55 +0200
> > Morten Brørup <mb@smartsharesystems.com> wrote:
> > 
> > > Bruce,
> > >
> > > rte_eth_stats_get() on Intel NICs seems slow to me.
> > >
> > > E.g. getting the stats on a single port takes ~132 us (~451,000 CPU
> > cycles) using the igb driver, and ~50 us using the i40e driver.
> > >
> > > Referring to the igb driver source code [1], it's 44 calls to
> > E1000_READ_REG(), so the math says that each one takes 3 us (~10,000
> > CPU cycles).
> > >
> > > Is this expected behavior?
> > >
> > > It adds up, e.g. it takes a full millisecond to fetch the stats from
> > eight ports using the igb driver.
> > >
> > > [1]:
> > https://elixir.bootlin.com/dpdk/v24.11.1/source/drivers/net/e1000/igb_e
> > thdev.c#L1724
> > >
> > >
> > > Med venlig hilsen / Kind regards,
> > > -Morten Brørup
> > >
> > 
> > Well reading each stat requires a PCI access. And PCI accesses are non-
> > cached.
> 
> You're right, thank you for reminding me. I was caught by surprise that getting 7 counters took so long.
> Perhaps reading 44 NIC registers over the PCI bus is required to calculate those summary counters. Or nobody cared to optimize this function to only read the necessary registers.
> 
> We periodically poll the ethdev stats in a management thread, and I noticed the duration because of the jitter it caused in that thread.
> It's not a real problem. If it was, we could easily move it to a separate thread or poll the counters iteratively port by port, instead of all ports in one go.
> A longwinded way of saying: Probably not worth optimizing. ;-)
> 

I actually think it is something that we should consider optimizing, but I
also think it needs to be done at the API level. Even if the user is only
interested in e.g. the Rx bytes counter, the only way to get that is to
retrieve the full stats set and use the counter from it. Therefore, instead
of reading (possibly) just one register, you end up reading 44 as in the
case you describe. Maybe we need to add a stats mask to the get call, to
allow a user to indicate that they only want a subset of the stats, in
order to improve performance.

/Bruce
