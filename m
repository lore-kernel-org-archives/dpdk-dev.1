Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A7CCF2DF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 10:45:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5541E4025D;
	Mon, 19 Jan 2026 11:45:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8678D4025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 11:45:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768819523; x=1800355523;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/WMRM3N1SsBmXR7PZKxJuoVuKzA3fN43gzr0MMlwt0k=;
 b=S4MlSTKjgwa0MOACHtgNCbmXPepGDuQu2oq+P5DY3nYigC98gf2a015m
 qMTiHLsTeluviY3h0L1Hf2NVR5RLFUFp65LBM5pViLuDLVEy1sAz1Yk1j
 Ye1stetl/c2n0KpfsCN7gjGTmBvW5ZsrwNLvN5523Swi4Fdfu2m5dZhh6
 0OLW5bD34WnNyvnhuymy8jF/kuStPsLAWYoCany6y+kxC9vtMpc3ey1ep
 bcgF2G3pF2OAEsrmHWvbuQggZgpfijWtZhHBcc7hMMSdb3SJGfApWScae
 k6cuBxlVO+qYRLrMZGorSZ5V58PkI7F0iLQJ0mr4wpWTQ5Yf23aaO9pF3 Q==;
X-CSE-ConnectionGUID: 6N4oowFtQWWiDE6/xye0Yg==
X-CSE-MsgGUID: +HeHXEj3Q5iGsKhbCWY7xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="70077072"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; d="scan'208";a="70077072"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 02:45:21 -0800
X-CSE-ConnectionGUID: 0UKyut8OSoerkv3+cMVmZA==
X-CSE-MsgGUID: mhnH95xpToOkgN7psDddwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; d="scan'208";a="210852993"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 02:45:21 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 02:45:20 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 02:45:20 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 02:45:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4aiFeirM6U6I3hZYVGR5d1frXy9Rm5e4Fv/YjcgdAIcF+STi+B4tZmKR77SeA+uQeZ9JkWYWKj8QJ/zYEGQutxln6FuyGgPdOmFtHtyZFyyQ3d2cFFgfYKy4I40BUa0ImyJ+Qhn/xVWwxwza3+fxsKUWEPN1eRO+JsmtPGwlLJkQBN2t8vtFc4B06fuIgu4HgnEtSLyn6oGakOebVo2lBfaIAOaKSIzCHQShSLdiRAJYUW6oMcKmf/RnIfVbvfaCSD5tiseJKRmqFMFHtbq8qEHXTmOjrpxeN5hQyugfCxvC3i0/Dm7pyceF4JEN985wROhEUwzYURn1yFmLFNMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ow2zZgZP3SFUUeuJ4NkL0o1YcQ8EsQ5/2cm0NFUFz8=;
 b=gQTrwbuzvRImVvMoSjcQCwRRD8hXeq454Jkrwy7G19wom8jUlfLfCr3i2m5ipgBoRmQ/ttdjaLnTDqgbYpgz2M7tq/aUVRPiwGjID6dZt1T/PwdcamhqtnKWhmSUFTBXirSs5UvCnI3NFTJPURz0dtW1mTI0QSZrvs21b+kUqsB1TpxHnZlzJXuBlglNyGcNJfH5lux+GvJ03++niwGhbdMIS26EpooOzDhsbfp15akXLp++YJb3QVhN/g8lSLgLoREL1qLivQctUqJAvJFf4wga4LVTM5tBs2x4taRJGdqGF5C+FYFylGIn3afHKoNmk0ia4FyNRTjTHnkjW4fvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:45:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:45:17 +0000
Date: Mon, 19 Jan 2026 10:45:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH v4 00/11] Assign all unit tests to suites
Message-ID: <aW4LOImpe4wh8rmx@bricha3-mobl1.ger.corp.intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
 <CAJFAV8xQL=w1rA30jfgp1oAxancAA5jESFO8GRmko6am7Te6DQ@mail.gmail.com>
 <CAJFAV8y8rObNjwotr0FDCD50pZZfXvekA0m-fZeXMxGJKcLweg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8y8rObNjwotr0FDCD50pZZfXvekA0m-fZeXMxGJKcLweg@mail.gmail.com>
X-ClientProxiedBy: DB8PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:10:110::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 36272af4-9881-48c4-8660-08de5747d586
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g9x466DhwbQRg89Vb4ARYKXmT+ocKhKXDM0KiKRVEfxKhA3jE0pOWXHcIYlO?=
 =?us-ascii?Q?fkWqwqhs4kqtftitpZ5zqiTsuP6auCn3TAm7YxpUvW820EFBtzD2fe43ROxU?=
 =?us-ascii?Q?rqsD5qsOadBwlW5YpfknKY8lwf8WFYaq5ChqmEmEv6OKPp54EfkV+AOZj5IW?=
 =?us-ascii?Q?2YaMf2r/YgjbFJqmE4P1ws4G4QCmYqgT8ra6lKPmx+5R2nvNTq2HexIKjiYG?=
 =?us-ascii?Q?rDX2LDzOpTccO6aSzHkxC+TX05Hs252iq4iA6rv7CcbBR7gyjsMaD31WyWeo?=
 =?us-ascii?Q?SUAJxatGP7VncqdqKKi9o5CpFvwFP0SQHoq0SbM0JhOJ4VtDbtq1NTPTZybP?=
 =?us-ascii?Q?ONZKX5KmPs6GoMCYc0QNj3FK+c3vyi0m7zHIRGWf9maNnXB8XYhGdEB8hVYi?=
 =?us-ascii?Q?hwyglY9aIMBvt/I2kiSMAr5iimOyJoI7b2T4E2t2TlF0OPnwxospFmX4gf89?=
 =?us-ascii?Q?WM/pECKR9JwIfk8RMIBy7mqObB7vtV6+q/zJ4wHbmk7o0OgAW8/eQsSl6LaA?=
 =?us-ascii?Q?XhKvMQzLf18fL9iUrusHTW65at8mH2c+oAyrFZxzh+p5KF1tPXfQeVDk5zwd?=
 =?us-ascii?Q?iBnQxKlZy1PpNd/bAdiiU8ImXp5dpvZI7Z1oSwueRL12SNFRjoAPnyTjLJ0F?=
 =?us-ascii?Q?fAafFEAUcE1HtV8x2m5JWB+WOA62SfW42G7ExjOPR0ALb5sjEdGsvSyMM7iN?=
 =?us-ascii?Q?Q+Q7dpXdIoGxQ7S50qk1XZB5ycWZOw8e9NRn9YjGPTT5EzQScv6TxZUiWpKw?=
 =?us-ascii?Q?l2omm93hhpCSRuK/N9Q1PrBYdcnMhf1cYGoz3SV+z20ZSdc28HHp6xQdsRRF?=
 =?us-ascii?Q?9p5C9BoTvQn3JaO/38Sgdm9RjXQTKc8RCzTv9GeKzyVLI/5Z0pnDwLG1p1eY?=
 =?us-ascii?Q?LU/lA2fLu4AlTQUZZcXblG/qU8BlJADhHlTsGYXSIHt9wzjeJu5SNEAIX+xj?=
 =?us-ascii?Q?4fVMqt13wDrZIbojcCpvSR0vVxy/0HJikZOjbrVyRkATaXs0BNVwR2zkq9ZI?=
 =?us-ascii?Q?rUhDOHU6j8Fm3eIeBB3oqeHOaqQbhMNtrKIeKqQlxHI0ulfDsR+01rIPUKKl?=
 =?us-ascii?Q?i1sIyrT/AYKFIWxVmiXgKqhszG57nFv6aZlviMgkoIhRtOqgwvqd1aRwRX4E?=
 =?us-ascii?Q?0lEmyW5vihbwyYCPBmJisPkAt9w1QW32dTm6EHqr2Q1c0iQl5XMoMDZlNDG7?=
 =?us-ascii?Q?2/sqOIVhIr8qglvD0Q9yyE1WJMOvScD4sogd/eWcdFckKRw/Nd5MCN8q/+if?=
 =?us-ascii?Q?g+MUCA+Nj1bJResgyhokxHop3WvqGtR7Nnq+Py+tvqcemG7AAsdvEvsz84xI?=
 =?us-ascii?Q?eOT/UQlm1gjuTxRgtfR2ImrFjp/rtBA/ta7oZXz6ODm2JX3VZ2Dem267TVW/?=
 =?us-ascii?Q?+oUAsC+pzgGTZUP+WYCxcMxpsmT3fOzSiigFBxUCYsncn9GKSsl0SYxkoHZD?=
 =?us-ascii?Q?QN/WehjcWj883YWDL/xVZ8Ty5AuigjkUfiywgQ3Vqws/G9Zm61g5CAayFRTH?=
 =?us-ascii?Q?/TGqK81xycUV3lpfzaf2ffRazfnfOSLoYpqvudsOgGDqYc+IBQAzdc4tPt4K?=
 =?us-ascii?Q?7t4rx724Oxba6M17QTPv6+7g1nfwKZeiQ/miCL4o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RHpauNlATrVWJWpS0swosopZAsVGlGheDoulKqeXd5yP6W9xz6atGgch2q0j?=
 =?us-ascii?Q?ETqhC05NEVadoq/CcSS1Cy7TTYXP3+A/z2UaE+O5vm9kEVzpdQyZ4WwiWg8U?=
 =?us-ascii?Q?imkuVRSSi1WyUsGD+gbyhlF10MLD4+x/ZWRrS1wZLN8ELMGjYpZ3K2bDpBgN?=
 =?us-ascii?Q?ju2AllaBk1eo3j0O724zQMTU516udPaTPb3LnGE1FhV0kPFZEnUbfDqYu5Tg?=
 =?us-ascii?Q?aF7GmWYFH542MjLuuUYqPBlG4nN4XA0gAj2NWvpiGWgWwKo/yCINPe1MDG3a?=
 =?us-ascii?Q?u0BZX1aVgmj6iTrwQ4Bq2VKq0TKYDiaql78Q6S56xWhCjkbtOvvYpKdwIAW8?=
 =?us-ascii?Q?9n9CvwD4AS95nJzbqZHk3yhqGnGTeonaexXFdeKNRBkGAAhKZesImM04Li4C?=
 =?us-ascii?Q?k9ghGbZnND7foSHPXRH18T+/HRPKH5WG8XJCGa1LmwGTKg9tlyPkCY8LQiFZ?=
 =?us-ascii?Q?zgaj4/UHzILxK2eioOtAUYIM06d7ScUA+etPrkJ2pTDeIKafuighj2W6Y99X?=
 =?us-ascii?Q?Ghb7T2+22gk8fYbbmrnPFU7G0n/xMzdqbz/f3FYmWtkb1/89eg/a96MQdGwB?=
 =?us-ascii?Q?AkEUbsSQCS315XrNxiS+5L7k1pm5m/BDmdTPcFO1NY6gadR4Ue13DZQGqfwj?=
 =?us-ascii?Q?5R+NidHrDgT6mU27su5q11BnFGuxdKrIn464VNl6i3QmNok0LrTnqsO8x5V9?=
 =?us-ascii?Q?JdL72KIThwrjYkRJ34hY1eeMdRd6GVKG0itZPsnvw6W+Dd5pPjuUjpkAsN9f?=
 =?us-ascii?Q?s+qp+6mIXWOxkFvNwLCY6vzqUe+XH4loSALkY8hGPx6m+Q9Em02NqFahomxu?=
 =?us-ascii?Q?wGsNqaG8B0EyRRgHt6GCjgdz3kvMMH3xYRWcBqze2jLKH3i4N+o9MK5d/j2b?=
 =?us-ascii?Q?v16xLvwqj0Wr+xJhQOPXlbKO1P3mwp2bgt5ZzYWZgLoOHy7Av0JjJKZWIXun?=
 =?us-ascii?Q?Wa6YZCujaBK8q/+WTj9HpU/HhwqzkRYNdfgGZvMjKKPtRYbERW73oFIL1et4?=
 =?us-ascii?Q?DuufNXg378kmSDw6qBxewM387Brh0aYoOyrf2DaztTZ/4JBNjWiI3pBpvFxJ?=
 =?us-ascii?Q?AiBCXu+GPaATr8Xh6KXJjsWEr6OtpI33qz4ni0y3dMei/tTN/G9vAn/b8IwP?=
 =?us-ascii?Q?tOOAZ8JxrUPxwbSlSCgp/uWs6ZrtFCGE5vXlUT4RrsuhakMq9rYHEFwOMpA2?=
 =?us-ascii?Q?D3SIWc/KhZiqTJcXTtApQdxK6jSfLRq/LL3M4CLq2x/bfF+YthoQVx1CR5ri?=
 =?us-ascii?Q?JKRXMMW+dpXkRTu+1SI5ahSlX2BOLHXdTNsVMH4Uc1R1dXc+L0MNgp8McVdw?=
 =?us-ascii?Q?Fo0r3hKRMfIqpM6LgeNeUNGz5/CKQyqSvccqyZ8TJ8qnAAokwzkTJ4rlk/AH?=
 =?us-ascii?Q?QPxe6CbCwqwOTYXCtssWxGKUE4sRXlGw4Y8+2ncFIlh8IML0iB7bUvRuxmdv?=
 =?us-ascii?Q?JARq/82aKuSkXpA/M5xCA4ER3Ck8Qtdz89A5KWeP+w9tBeKEQz6rUhDfdPMC?=
 =?us-ascii?Q?vyKT8250mZ9KPbClYEsTad89ftQjDvRA3l62EEr1REHoPqspAQOEb+cJmABf?=
 =?us-ascii?Q?93WEBtpxi+Ok6gfXulCvAxd0e8hZxgvSsTvuyqL8N09+teDi4jcUqvu8HhGz?=
 =?us-ascii?Q?/NXMiWsE058b70uSyz24vwiGg7bbDavRJdxl6vlmavtV5zg+wUikv2Q11+3Y?=
 =?us-ascii?Q?Rmshpcjr1IbuDpygiqO8GWxQhJnyUUVdq+An9DzB36LryiRVUF0wd72ug4rk?=
 =?us-ascii?Q?5j1rYZXnC1hiqxRAZLOFAVn9gPYKZAY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36272af4-9881-48c4-8660-08de5747d586
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:45:17.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLlBUZQ8co2HXOOS/4HH7kbHet0an/UaCruCbxxkurgh0D4eU6gafgOMkaPthFFMdZJYmhNsC4ZfThnN5aZ+Y2vEjRPrcQHDaFYHiAMxk5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
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

On Mon, Jan 19, 2026 at 09:09:10AM +0100, David Marchand wrote:
> Hello Bruce,
> 
> On Fri, 16 Jan 2026 at 14:24, David Marchand <david.marchand@redhat.com> wrote:
> >
> > On Thu, 11 Dec 2025 at 18:17, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > Categorize all unit tests into one of the test suites: generally driver
> > > tests or fast-tests. In order to add some of the tests to fast tests,
> > > some additional work was required, hence the additional patches in this
> > > set. Also, make the parameters for asan and hugepages clearer in each
> > > test's definition.
> > >

<snip>

> >
> > Series applied, thanks.
> 
> I can see a few failures, namely, for the daily tests on the main
> branch in GHA, and it seems reproducible.
> 
> Attempt 1:
> https://github.com/DPDK/dpdk/actions/runs/21121155333/job/60734135604
> Attempt 2:
> https://github.com/DPDK/dpdk/actions/runs/21121155333/job/60756716459
> 
> Could you have a look please?
> 
Yes, will investigate. Unfortunately the logs don't show anything
immediately obvious, so some digging is required. I also don't see the
errors when I do a push of latest main to my own github fork, which is
strange.

/Bruce
