Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD32606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ieZ+xJjG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A521400D7;
	Tue, 27 Oct 2026 16:56:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 89A8F400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:56:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793116564; x=1824652564;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=E+ClITwRt8JUr8azjI5JSI8c9VKAOIOTWKdgvMV+JDo=;
 b=ieZ+xJjGzjbj3/huzOw8WTfzo4FPSR2ezeWxStNmmSNr19Tzk+1rMO/0
 Up7RixDgHzAopjq1UQjGXg7A9eOrHHw6gndFbl43n0+Y/dS2fcZDNymq6
 7BgQnrL9EtrW3ganr3NiZELtB28zlX5MienJOvxgvdkoDOAkAEUXzpSE0
 P3Ier0AMNF4IwCQ+ppynkrqc+TlnXb1u/VR2dJChY1vzses+3lUT4TYTu
 izL17VByb1C7MztbJ5jrILssWhDS8sKrkXhCnpdhi+sQAaQVdcz/BMNUa
 0AUbR33m8LQL7NwnXlw9CFAh+XydTN1GJHsp6F/ho3DzfAlYTEC/M9JLY Q==;
X-CSE-ConnectionGUID: tP2jLb73RQWBn+kWF9mSNQ==
X-CSE-MsgGUID: +epaT6HITB29ughp3cSkuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1829140"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1829140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:56:02 -0700
X-CSE-ConnectionGUID: Iy55Pd0XR5+PTovlrbrlXA==
X-CSE-MsgGUID: F77ntwLBTkCkWmxehsFsoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4582078"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:56:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:56:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 08:56:01 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:56:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQL+tIGb4lvob+IOR1ebKJpONATWtVBMC+q37sn22ARvxy0EsC9/Qzywi9BHe2pZ0Wjb47xKqU5LDHpH6SxJae4RMEE6XEdmJs9Uf1QmhC6HVX/OMohOfs14nWpgXRNiygMu6knzxfguyLPJg2y40/T1hDbGJOKLnRKRZUyONXBvm6SRn88VxRCkDrlmtB927jM4JeSKZs5NuBTzt5DjN9oVmUTVIk+UNlWVzTY5qQEpSFM7hBCdHurpw8dI2+qWbFoc81JizXuImL/ADxYzSAuQKwVjeSYIubcxCP49Jbn9idvtP+UIK2aYdUTsDnfktozXUgR9kydD/tO5W+DmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzqhDaauRLpzJr4PCaALKJqKrIoOylVbP5fjvO9jT98=;
 b=yfZCTbuyy90jBN+tF5kBhoqgeQUbvDfH8n/5fWShYRY9dIgn+rj1IRdPnb9DHX1OyPp1jOgWZF+lQIxKzYHGgB/UjxtiLo88TgMbJtAKiCmlZTfYd+BUPXXsjx46eaasrbNj+xJ2CaspjH3uWqU2H/NAS/667F/uIHHeQSm7/4wSfatqNt/FrYrU23sp9+OS9Y3QXfvoHa09j6IYkG4SY4VGdYqSeUQFc8tmFIHa4aKdoMqlPLLCdPHzqlGr+j2EXFKwiJbrGOd0e0WxcyqUixYt3FIAwQcp3hG8ZOEIyRM/D08FPkQPews8dgTq+pM518F/I3hX/t76wOfl74gPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH9PR11MB524908.namprd11.prod.outlook.com (2603:10b6:610:333::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:55:59 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 15:55:59 +0000
Date: Tue, 27 Oct 2026 15:55:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix MAC address removal without VMDq
Message-ID: <auDJivczz0uu25h7@bricha3-mobl1.ger.corp.intel.com>
References: <20261027095832.358077-1-david.marchand@redhat.com>
 <CAJFAV8xHTKLFB-AgN5iMhVf5bhHk6qoGW82dpCD4MEYfbgi9AA@mail.gmail.com>
 <auDHcgAimL56mUIT@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <auDHcgAimL56mUIT@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH9PR11MB524908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0347d31a-b0fc-4d1a-9aa1-08df3442cb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|6133799003|56012099006|4143699003|11063799006|10067099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: zzDkNA7zVHXEyMDjDLvVR2NPSCkl5jNVbch5Xw0SEPMtzSXEWuAlIc9RxinjchNDxXNc8ELU5GkBJbG4XJBMUkBb5g+OV1lLikxg0wLCYy7lnyaaCkoDecbFxaD3oWvShbxuM/NFvweSjk0L7odK8GpHRJ0CUugXYz4A056XRplJaOJUa339oVvjeU4mZLd60cARPYyorB395gajX//dLZB5PW/sZaJ1KESZib0gPJEpL/VT1SxB9dx314bS71SpvxNcrxsvdDEXZYodVUyIz7dDzqEIMp/6cZqoy9GauBWVvYxYp9wNt4VCrkecX5Q8zyT5l1yie8GGDXsOmVwXFAAelFHVdskL9L7K4jL7gHaC7KvTWEKrD4qxrK7CtZnMTdGjRMwIFfK10+C350JUdyVZ8yjiUZudTerKZBT0YSCcp8vUuCk5Fptsxw19+FKKc3tsncekouNx/Os96Ph0UaWKQFs7dKYK3S9aNgVV79wTlkiHhJLKeYkuAUstnMjLVMoKyMBRiuAXL1SmhYeNqqL/hqpL+aiVo6qXuq0y+j8k9b9vRXdH3deWjsS0ixaANklfxRFYLM45i6xcGXpOlj49nZ0Kf7v/iJ2FaIvPy7gh5HY1JpqGK+6SLyQSsyi13xKpq6RiGdZEpx7aqXINEymgEaMFear+4bs6c+lM1F0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7b7lZP2fyfkQcUc65IJDLRcMYItKV9hgvIStVdMzYemFGNGlVRtws/Fj+z22?=
 =?us-ascii?Q?5SDkCzWCINFnwVFn3M6jdZ21fsW0rG1B5OKNoTzMXa/ccOpGlOU38HYSsoNv?=
 =?us-ascii?Q?NhbKaYFwr8O//qwFFd6mdhRc6MkXwy29OTFoWDF+Bm6D6MbLl19wfNcTxF/l?=
 =?us-ascii?Q?N4f0/9bwHZkjcqaC4Jp3iv0D/vq1+8Y20rUytm4b5gPfxNbS6UX4nQBOQly6?=
 =?us-ascii?Q?g6U+iNy9xcnBCU3+De7/aWteo4Pc3a8P8GQSZaq9eG4Fq8RPGa5jojpCSlna?=
 =?us-ascii?Q?uePieaWyb4cI1ECNwD/IG0ZAChen73gAzVrZ82/vS0kVdAmdkEGg4zxklK+p?=
 =?us-ascii?Q?BdOdnfpeeUvnLtXXj/hAIFdEM6uudaWEE92Xsjd34dJG3vaiR+l+uf8pS9mw?=
 =?us-ascii?Q?DAEZCePECgS5uusDqBko5MBsOHThCv3POf0W3ZzfxzGhfav4XntSM6kjBnUZ?=
 =?us-ascii?Q?GUaiiiqKZ/F2tByt3L1zzZrpT04A4r2XDQifoGwO/Eu/p56VsTjZm8CIBPke?=
 =?us-ascii?Q?hiz+wDHZNhRTt6IHt/Foqx8jKpl9EvQX+OILbn6vZS9xw0zGiqBY6WJM2jGM?=
 =?us-ascii?Q?Ixsx0NvDMcT6ymXhZoEp3tnKFydfeyJAJpx2qG5d9NqmFo/B7ZlhzBubHk2K?=
 =?us-ascii?Q?LIkorbIAERX+xnN2cgWriDf42iOJC+XdNUYoWfRsCiyN8SCsuWj/kg8pZtJj?=
 =?us-ascii?Q?xLl4QvFtl8iAoxbPq6j8UkLWpw29kpPICMa94tOoc1gMiG/FyRaSLtiR2/UZ?=
 =?us-ascii?Q?mukmCELKBF9AeJNPnWcAw2C1NBUm15K7CmFaskiOQy/EpRf1GsaQC0aJDeYU?=
 =?us-ascii?Q?1gK4nOzDn9UvInSFwmzeK2p0GGSFg9Ub3Fz/Z9Gk+6Z9jjJZZavT/rp6sCsx?=
 =?us-ascii?Q?2mUC+QTVQboEaT//czqta5cuR+ZUPJUaOZm6xr9OYK+91OoDPvZAlgTMOi+O?=
 =?us-ascii?Q?mOqLYjhqrgdot6qsYTOdfy0NVJ2689quTkqDgxcBt0dTd+b5JZ/OPmNTFPEq?=
 =?us-ascii?Q?6bNDzgNADcFbpYz8ril8bFqFQCDgjuI0pil+mmmum7XHOnhU5GpMtlRr4ZDD?=
 =?us-ascii?Q?u+grCVHGnY7Tl+mbwB3q6D7/Of0kyD+iSDUx4oJfoqMISUoshtM2lEMNRYKa?=
 =?us-ascii?Q?4BvwbGI8Wu5HPCr1tLQDlmi7oupA8irP9vSOa/ZsILlmNF78uGQO5Dno9cI1?=
 =?us-ascii?Q?QGKGPK1S1LfOIAscSiuaxkiUGtlwBJ1hhgF6LAAk7Uqe7qAZkYmVn226ZveP?=
 =?us-ascii?Q?/FXks3T0ou9PxJJxdKyrbvRMaiErIwnGajW2VLyluTXiFezBbOakVdAVZijr?=
 =?us-ascii?Q?07ZCvy8Ac9DFEg9TbiHiIRpRXLUMZzkZzzaq7Y13l7FCqfbaPXMqTcj7hE1/?=
 =?us-ascii?Q?4Cy5/5XYTq5h8C6647J6gzq8c3RpKj1deFGL3CdsUDyGWG4EjOk9fUo8p+DA?=
 =?us-ascii?Q?c/XbU3rymvUsMEvcVOnEeWcSjHAU6dOhDDR+ZdfjT/M//XoxqtjxDYmyM7yE?=
 =?us-ascii?Q?cQuiJJhNKPJfQVjvtWtfq+UTgAynS+nl470yj5qv5sDWQTf23SA4eZSF/SIf?=
 =?us-ascii?Q?GqCYktCPLb/bvukY/f5ixGLUQCbLdmijV9Mav4+JFKRfX20OAXYJ9bGBhviJ?=
 =?us-ascii?Q?p1JGP9fb3o/K/u4EVOulSSpje5exq7ISpI2mt+mVSQ+ib7wtaR+8LV1Plq5K?=
 =?us-ascii?Q?swG9XWndWXj8ZuEFN6YIqpgjbIyHTHgfZ1+vkXZzQb7CaNZW5djYJYYKRo0g?=
 =?us-ascii?Q?vZuYkbbTOcqSbh/7HPvaf2X408on1ew=3D?=
X-Exchange-RoutingPolicyChecked: w2wVSQfUixOJ+2z6GwY36J0nOSxlDa7V6kYOePUHSac7YsNhCWwWyKY4G2jVeMGuDI9q1jE186ynsL5rwCdP5lbpNT/fHCeuzRX9Wft6vY8V85KscpMO23/39VvhGR5qk2C+yhOHenL9aFogQQRCb4jCgKxvZjhksTYHqdY/4Ix79YpZEobpPhSYhDLMWSI1Tb8KPG/B0IH59/5CSSTG9yLD7W2x0uedvJA4tbsgb+Wlgh0llUz5X8YMgVsT5HKLKJLimp35AOQIBtJyuwoc4CR6ABLtIaTcpfxWa5amD3N8vUUwi7r1e3ASPOC3uxRa2Izg8UzNwFTUhkqFd5Bgpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0347d31a-b0fc-4d1a-9aa1-08df3442cb65
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:55:59.6786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqLB47FaI2Vw0/6diNcbbt63jvt+0H/O+1EwW9QzuuVNFmlgxJZvpD/NzJnF9OhvJpO82t9gfh2vgcS0H8mkq6xvPZephmc6RS5i2ZsOyUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR11MB524908
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 03:46:58PM +0000, Bruce Richardson wrote:
> On Tue, Oct 27, 2026 at 02:02:46PM +0100, David Marchand wrote:
> > On Tue, 27 Oct 2026 at 10:59, David Marchand <david.marchand@redhat.com> wrote:
> > >
> > > The MAC address removal was checking if the hardware supports VMDq
> > > (I40E_FLAG_VMDQ) to decide whether to use pool-based removal.
> > > However, ethdev only populates mac_pool_sel[] when VMDq mode is actually
> > > configured. As a result, when VMDq is supported but not configured,
> > > mac_pool_sel is 0 and no MAC address gets removed.
> > >
> > > Fix by checking if VMDq mode is configured, matching the condition
> > > used by ethdev to manage mac_pool_sel[].
> > >
> > > Bugzilla ID: 2074
> > > Fixes: 774365884bb8 ("net/i40e: fix MAC address removal")
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > 
> > AI review raises a concern that dev_conf is the requested
> > configuration and proposes to rely on mac_pool_sel[index] == 0.
> > This should be safe since i40e max mac_addrs count is 64 but maybe
> > worth adding a build check here.
> > 
> > Bruce, wdyt?
> > 
> I think it's fine. After a successful config, the dev_conf contains the
> actually used config, so its fine to test against. And if the config is
> unsuccessful, we shouldn't be calling this function at all.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel,

Thanks,
/Bruce
