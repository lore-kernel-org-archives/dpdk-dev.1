Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE3E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 12:30:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3184402A3;
	Wed, 18 Feb 2026 13:30:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0C89E4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 13:30:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771417824; x=1802953824;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hx3iCS23wUKvy8muPK2A83W/p1HFUK7UvHpwOnmm8GM=;
 b=iL1AnfUFXF7nX/tK92b5608ghpildzxKuNA2gMpZ3XEx/yISJ1G6ACCq
 oEQNOSyoJbB6gW3tXYH1fMVYfQ5GzDzryVOkUO4H/ORK+B2kiXC9ty7wf
 v+b0Hq0hMSXUjAz1WXj1Yt8YP9dBUF6p6KHk/GeNMPOnhlFFgPwBI4sdK
 4/BWQGO0DjsxyxAPJfn0ULtk3JIaOqCbaPjBgq9I4vspyTBjktIUMhNiC
 0NtQK7JjOo0CZnPGPhDjV2T565WypkeRnoVHOe99RSQalhhEyEMQCCYrt
 0Px/vmH9Wi8EjEOJa2nPHhRjqSBkBJKavbF8VD9FFEC25qBtuV3vGzTou Q==;
X-CSE-ConnectionGUID: Ve7JUTuUQZ6Z31J1O06oqg==
X-CSE-MsgGUID: uKpHCewoSH2d6lM3stxaIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83115770"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83115770"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 04:30:23 -0800
X-CSE-ConnectionGUID: Wu9C+zF9S2ugwQ+CBOTfUg==
X-CSE-MsgGUID: /0fklIsjTPWEWVpImsekOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="219174726"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 04:30:23 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 04:30:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 04:30:22 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 04:30:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUmBjQrHaqqKuVR/axAN+xrQsNs0PbXnDI94JPutoVA1Mex6X2fpMB9Ig4MgAmzwGuZ55DpTfjy5vODsVGsEhON/McwSAfxPSyEDsjWpEzjKenoYNIR3Y7fuYH9R0AUHYLbgaoNxvW9AlK+Yn1kCR7PUXleyklZtF80K1NOnNQNjKogbi8/4+oXJjCtFbSsXhN+G0n/fDeqz5hK/iAWnvjJ7ybQYsaO89Nw/ohKSND/cq9iVmTEt1sSsCN+JeYB8/dun3gU75iI/9mhkcKRRmVIrggEH4PAVM9c1htNtKUF9/VuYOJWUhEVbchUlR3mP4JMwtqLealCYHJikwzbcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skdJx/lIjOcm3QSOesJKYb7wz4Cf4iJjJQ9IvgZvXxs=;
 b=riJs/ijWPRpN63e1pV+/YEE6o+uweCTDXiRBY8swtMkXLU2LeB7KdCz15rNs8xhDNoXfV5JWveK8utKPLSPmVx2q1aBQsyJpDf6O1JsgH88g96MNkNqCA9RFeu0fV+13lNQOMti9XSNLbd99j5bCFVyaUU7IRI2t8Aq8XNl4+gtYfcWrBzjZ7ylW+WwCcrSabVShlvsacbTYvHObAeyineGKL6iCtVzbQTQqpqIgzMc7ks/oaZCrSSx7H85TscBHJoftICz2looPtFl8OKXpvOyeiGRuyJBWIDxVF9JLQOabIKe5YyVwn8ypJDC4R9sBwlPISMayVwXbHkibUn3cbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8113.namprd11.prod.outlook.com (2603:10b6:8:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 12:29:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 12:29:59 +0000
Date: Wed, 18 Feb 2026 12:29:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 00/10] Fix multi process path selection in Intel drivers
Message-ID: <aZWwwwUD5e_GO_CF@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8d0609-9253-4e36-2d4f-08de6ee96ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HM2VXA1OwT9lkWSUq7FaCZkXwjmiZ56+6tlULn7wfQw7vEOsjB9nho4svpsY?=
 =?us-ascii?Q?6Cv+AHttCIjYCn9R65Tz2G1e5Fc42Pvd6xLTXHDW4HSnXXcBdeZJlFXIl5vk?=
 =?us-ascii?Q?4BUCIVXkJ8AIC00ISg/FIfQf6Pcj3WoH+7ba0hR6yzszshJX1ZUISR2e1ogF?=
 =?us-ascii?Q?WXZU1AEreULXMlq4oJCYf5r70rLrG5NUjsEEMBrtT18qw2/QAqisQ1eF4YGW?=
 =?us-ascii?Q?6j3rjxkAh2gzDk7sG9OPQd1aGh1FA0iyMpzOW6pDtk4z3Rf73bc0O6yuDsuK?=
 =?us-ascii?Q?Bg6Z6hkXrmmF0wvok5lwl0a2lX4FvFavW0ZuqS3yQG7dvwqXJJl23tRW841Z?=
 =?us-ascii?Q?m2/eUy7fes5OopG0x8DFvB7McPgS6Wgiyv64IF5/jt7J6p9eR1BNn4Sfb/Ui?=
 =?us-ascii?Q?dtkL5wz7S9OI4aaOcFEpqpY/mbtJd+eshdUTU/WkkW0U0huT2HHS2X227YvU?=
 =?us-ascii?Q?rtaqVjineUzBmYQiLb/Zs9fcXc7Q1vs3UamI10SLdWUTqv9TjUdMIG00Ojo9?=
 =?us-ascii?Q?dMd1BOtYU2K+DVe//LmX64XUza7E+HUHHf6e5aienR1ImXbmTlJvcXH7sUE5?=
 =?us-ascii?Q?gYbltnXalLyXCFjc8QeJlSSWcL58Vkiq7NKDT0QvhvMBPtFH8iQYhTErEXph?=
 =?us-ascii?Q?ybptSsQAyTebLwaK2bu/P4CXhtB1BUeOMrsxr8/8ZA4D2NukYiSVlOvVbbQG?=
 =?us-ascii?Q?q/LicsbluTcy9arVhywpcA+ahGfWICEt5VG/rMjh5k1yaYD9FWwoUjDu1Is1?=
 =?us-ascii?Q?dMN/2AB20PAPBATYSCJOWyrcuwXVPsTvyGhxCMKpLYmGqReZ4C8EDpZy2kEz?=
 =?us-ascii?Q?lTVG83NntvJa6zocNlt26YvcjpdM3EmbOWQnsshGAEWfC9NGyAYLnBIQX/Mr?=
 =?us-ascii?Q?6C3EDLW4h0qZR9iXdgvndLd2dPqrvjblxu+dFuvWX3J3ADqdJ8kI2lPNGiES?=
 =?us-ascii?Q?UFiFVObTd035Sfu0xElFYuvRhFPsobPJvHadohqPwEexjFF9wyGkNgJyMqQD?=
 =?us-ascii?Q?qY+xiTmO1a4S4ReyxHG9iqditXjCWyYrx0yzYDUZk/suEDxawxwKRmt0FWaK?=
 =?us-ascii?Q?fMRB+2TxWfR/H4CH2wzcUUJr2shkAd0DkK60WK70KkWxFKVhnUlh3mpaLlsB?=
 =?us-ascii?Q?OXVu0hwtnU2QNlp8q4ElNxvmqT9alQRFssdM2B1/JiyzjptIsxVpT/tEpZHk?=
 =?us-ascii?Q?Q85JwgsmhGFk8Opm6aGs3sIx4Qa6rUe7k2KhKyDeI8NcoRE0hieg/B8PH6Z7?=
 =?us-ascii?Q?xgR1whSGPFswAmPreJkzpj7jy72+rZJd9w3MtLv+10m+68c/tPr4Qb8ypMEV?=
 =?us-ascii?Q?F8GT4PzHlLpnEOF/yZVcij97sfbAB1KolfSnlDGLvADinnBAo0eUKET+JZVl?=
 =?us-ascii?Q?U9PTrYgz5UmGLHRSObUW+63NytUaiK6M2lsTAzJyOR0agT4NtMCY9Aga1SCk?=
 =?us-ascii?Q?tx0Z7OQ5UGWUjD7oFVGtC5Vf3d7qNwdPkuOChyoYp5Kh43cGsmInbn82SI4V?=
 =?us-ascii?Q?cm9NGvHFSIPmI3B/pu8PvM5SxOtqAkAdrviOEGm+cKMrCNVMO12/Q/kyOSpn?=
 =?us-ascii?Q?B21V8e2U2AH7AeLBS90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nX5wWzrkmsVXHW/mv6WQve584uk9pcx2cxgzSVtJGQ2avyMVksLJ3o+M+9Nl?=
 =?us-ascii?Q?tdpy+4Vb94ZsnD3R0fR4P/ttJa25cu1hbBuWk45DGpavwBYBb3NV5Rj4fT0x?=
 =?us-ascii?Q?4Rpw61K+5CDxZ7bPcolCQmPUXjJ3JIBycWV0rYUzdoGFrWAUTmN3gfYFUu/j?=
 =?us-ascii?Q?RmAGEy4QS17Dn2iKdc5Tu5qoW2xkbPA08zSFKoH8dreDHrdxZu4lSVBegfED?=
 =?us-ascii?Q?L1nC23KmRCh+qXHSyQo0C0wbvZfiEAWLf/Lqb54IWMJLHLSdeaYI/7HxQMBC?=
 =?us-ascii?Q?HJgkM8+l/ihTzYyDfJJ87IKtzVjngQuBeYMSs4auGxhPLxIZE66B4SmAubwz?=
 =?us-ascii?Q?6fSLRThvySiwZZ2PIH6SCYW1Cf/uctxwHOvbaVA027clw2Mrp4l2c9UvvYXb?=
 =?us-ascii?Q?Dtcnk+FWm63b93avHZXNDry0US56LuSzRXC8A94FAqhZQE3pooD0fmHBdQAR?=
 =?us-ascii?Q?e3fG6t4ChaR2Pwwz3f2bqMjyTVBaW1cvJn9w+QZ9NIcOxDGi9bSYYXMKQJq3?=
 =?us-ascii?Q?9alo2uPf6vFqVCnvrpebiiBZiyG5H2A5PtwEtRK1Hi0pW2cqBh+I9FQiD8hF?=
 =?us-ascii?Q?uqQF8X/VFWvuXk4lkqZrEiDsJEfTcRJVN9OJFs9dYs2aizb55jRibiphB1aR?=
 =?us-ascii?Q?VjjesAH+Fx72SPxJ+zFh1E2tm0/YsugaIIfKVC+YgKkIAnX6UYwCy/CkcrsJ?=
 =?us-ascii?Q?PajwEOZuKMk094qDUdma04oKW0ZuKDnuW/aAHIH8/MSIeycOEbpUAimp43ai?=
 =?us-ascii?Q?kBKzJJ9Xt9P2wLSFbCdKYCti8r/QyWpnEHh4NUSEcf1QxExlKVx6AD/HqPkC?=
 =?us-ascii?Q?1A9Lk1wDQYgV/P4fzNtEot57Psa3oqPFlJ9HofnqkHsXj8RLKSYYGhG2/U/m?=
 =?us-ascii?Q?vGQ2U93Brzp6QjB02ocYJ5Anbnm90X0PDcaEs6Ame6+T0pgA17iq6+yZH4CD?=
 =?us-ascii?Q?6ayDXGQYUeXWXQcOwc9YE1oUYWPcnboRhevk4jRaaSfBFNKCPI1rNSCaoTGg?=
 =?us-ascii?Q?b9VwflikdiyHvndbWsZ94Eulc0VdzjreuxR/lqnrJMNdgDBfQCASyMeV1vLR?=
 =?us-ascii?Q?5Wp6XQ8lQ2VbvRocDu7NPpoTCSBA3hne7/QoGVgaOX/YfZVpQqlfWN7dcQMq?=
 =?us-ascii?Q?isR2EV5/sTE9wWepAfvsKqaUmc7yoG0JtjnoQzluvHIq498NIMjTeNi+7tEI?=
 =?us-ascii?Q?ZnKYPHlw2aJkM2TC5ffB/Rijxv3Vq1r6QXx0HJ5YPL0R3nes6VQRXypdTL/F?=
 =?us-ascii?Q?e2sbRnxPytE+Frz0IHNFMYymD9ld0lX64ICR6kB+rk/w8qf74UNAW1Ewffqc?=
 =?us-ascii?Q?ei0iOc/BHgUeShurQ8pfmfa2g5tFPt91w0O/QZaXV6LTO9yYSF1jsJMwMnqg?=
 =?us-ascii?Q?e7GzlRq2HDscBR/O4l59Jh3BA6Neo5Qq+N5G/rk/XShmopceciqhIl5zQpIh?=
 =?us-ascii?Q?CT4/TMD1HdxsflhQpmGLDc/hb0uY1OJBmrmtKbzzrWkN5bAuSDeN/IQyaHrg?=
 =?us-ascii?Q?wbF5y93vb3IB0LDsGyGSuLZF7ugBi3d0q5tT06hoVU0D9CrAXjaaP3XiqCuz?=
 =?us-ascii?Q?xaI5rgpdC/8ro2sVa0aJcYf7BDl8HLKKhJmHY/b+vC9AAS02QDsS6DSSJ8MB?=
 =?us-ascii?Q?AnIJCSTM5MZmrbUWc/suDvog3FxXt/1A0hWDj8mZ6xhqcmiz/LGswrbH2dKn?=
 =?us-ascii?Q?f3CGQqCR7oYMFXVs2M3rlvB6pe5qh/nFjCjyyGdAZcBxIhxX5fikqhs36neP?=
 =?us-ascii?Q?BTCgsPKUvTpqfESa4wtAToUx8bNGIOc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8d0609-9253-4e36-2d4f-08de6ee96ea0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 12:29:59.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2WOBSyS3cWwqkEdHVX141sX5mHMm4PXjFztl5xKzOW8wD4qG91HtU5CwjfTCKqOi5yeYRk0KhX0S6gE0Xnvqj9WZVzmFLjR6EBS3ry0L9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8113
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

On Wed, Feb 18, 2026 at 09:49:27AM +0000, Ciara Loftus wrote:
> This series fixes and makes consistent the approach to selecting Rx and
> Tx paths in a multi process scenario across the Intel drivers that use
> the common path selection framework.
> 
> In v25.11 the i40e, iavf and ice drivers prevented Rx path selection by
> secondary processes, in favour of simply selecting the path chosen by
> the primary process. However, this model does not work if the primary
> process hasn't started the device before the secondary process
> encounters the path selection logic. To address this, permit path
> selection by any process, so long as the device has not yet been
> started. This allows for the use case where the secondary process is the
> process that starts the device.
> The idpf and cpfl drivers are updated to follow this model as well.
> 
> The same issue exists for the Tx path selection for i40e, iavf, ice,
> idpf and cpfl, so implement the same logic when selecting a Tx path as
> well ie. permit path selection if the device has not been started.
> 
> If two processes were to call the path selection at the same time, in
> most cases they should both land on the same result. Both would be using
> the same information from dev->data to build up the structure that is
> used as input to the path selection function. The effect would be both
> writing the same values to shared variables eg. rx_func_type in
> dev->data->dev_private. For this reason I did not add any locking around
> the path selection logic. The only exception would be the case where the
> primary and secondary processes are configured with different maximum
> SIMD bitwidths however this is an invalid use case IMO.
> 
> I kept the patches for fixing the Rx and Tx path selection separate, as
> the patches that target the Rx side will need to be backported to v25.11
> whereas the patches for the Tx side do not as that logic was introduced
> post v25.11.
> 
> v3: In iavf ensure a secondary process can see if the primary process has
> enabled LLDP, which ensures that the correct Tx path will be chosen ie.
> one with context descriptor support if LLDP is enabled.
> 
> Ciara Loftus (10):
>   net/i40e: permit secondary process Rx path selection
>   net/iavf: permit secondary process Rx path selection
>   net/ice: permit secondary process Rx path selection
>   net/idpf: prevent Rx path selection after device start
>   net/cpfl: prevent Rx path selection after device start
>   net/i40e: permit secondary process Tx path selection
>   net/iavf: permit secondary process Tx path selection
>   net/ice: permit secondary process Tx path selection
>   net/idpf: permit secondary process Tx path selection
>   net/cpfl: permit secondary process Tx path selection
>
Applied to next-net-intel.

I've squashed the final 5 patches together as they are the same changes
just made to different drivers + one other small incidental change for iavf 
The first 5 I've kept all separate as they are also for backporting, and having
them smaller should make that easier.

Thanks,
/Bruce
