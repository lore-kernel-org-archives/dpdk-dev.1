Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E91CC982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 06:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E84DD400D6;
	Thu, 17 Sep 2026 08:37:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8D651400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789627077; x=1821163077;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eWCYC9sYUvgOktx35w6Tn/6UPnGzcplmJpInFTw5CB8=;
 b=T8ROyfJxMDNXTjvweHth+7J1saschs1mP5izRxN1a7h1DXBhgAO+TVOt
 Go1yS/uXsas0/XsE7r9VAgcU1xb4T1+1Aisng4KbR8KmB4JC5vivPBQEJ
 aZkj+UMgQkxVwmdMxMNbeY1pxCqKjn5c9GW17BKZA6rmIy0LVoucgME5L
 DMVZAl6dc8KB9i65nUoFpx8xHMRuVklxg2Yk0fLAZ5lxwkc+8C1PiWJBD
 iKvHO8kYm4G0ShjxmEkIXhUaRcDeXiT7sHD6UJwPX5sXT2B+pWOdjoZGX
 /2V0NDlx62lN5JzinJue+wKpe6PTl21NpgWewY8N5YjPkkVhCCv4GrKLh g==;
X-CSE-ConnectionGUID: 1v4njRaPR9++ZGVMDpvZpw==
X-CSE-MsgGUID: d/ACXGuvRXWKKa5QD+5lYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92527244"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92527244"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 23:37:56 -0700
X-CSE-ConnectionGUID: FvK7Pr5bTmekyT288XzKwA==
X-CSE-MsgGUID: L1FEU1qTRoqKTcqJdQ/+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="297098053"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 23:37:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 23:37:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 23:37:55 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 23:37:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2xAqZ9iLsNQYoe6vEmL+DPjYbg/wRFAP48AUAJ9hViz/fY8vdlLkqJhH224KH75ItLrB65GAoKpoqWDKqD6FLYysVF9moEzuLeRl7ZesVkoReeBkaiFkKXUYc7kVmyo1XEIZjHhVhL2MECuXe6V6BeQteT/a498LB15FH+0Dvv08fUwibXoOXZ2sH6RKQ562h8pH/0iacmfdYQdXM2lQ6u+OUBVSweD7zYkSsuzHFiMXWBd6PeDxFe7gj6djjc6TDIqBwFHEiv8VF59hwRyyOzJspr/PKwyPY99Eg1DCn28FqISzjtc3LEKnRUWXd6J9eljJyoKH6HBKwZ+jHAJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQt/z6k8dM/svS/+Ro9ZubBHR/GB+v9HbYSRowDROqE=;
 b=WFay+QYyl7SaM3fI7miUvn3+Qr9JoTZnnRqhZ7cfA8k9voWt3KuYIyRxHiynfe7H2qUBLb9HyySk9Ykxnuosj+Z+lJHs7HZtV1ZsbwiCocCbiuKJkENrzuGT3KqHiOGda9ldgU3Li0Rw1am+lPmkWAujmHtFwDfQE0oVVoV4JqO5XGyHJmgCNC7rPpbdQj7PF2QhGxRamF6q+0nMAxSEnzSXXtYYberd0G+eD8vmRIwlUCa6Vy25CJhNWKgYafXChX6bmalid4sUizwMxlbeBiiVd5tQ6frmQHpTUGP5wv/fZLJ3e9gLYzLS/56nqb7zR8OijDGIa48f/I0e0/vdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 (2603:10b6:170:110::22) by DS6PR11MB017978.namprd11.prod.outlook.com
 (2603:10b6:8:469::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 06:37:47 +0000
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c]) by AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 06:37:44 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH] net/ice: add per-queue Tx rate limit support
Thread-Topic: [PATCH] net/ice: add per-queue Tx rate limit support
Thread-Index: AQHdQQt/mEEgr3dwOE+/3zpwKRLUSLbHnIqAgAfQZPCAAHvugIACctCQ
Date: Thu, 17 Sep 2026 06:37:44 +0000
Message-ID: <AT6PR11MB0445269852DD60A18C0965C241E4B82@AT6PR11MB044526.namprd11.prod.outlook.com>
References: <20260910100432.207328-1-anurag.mandal@intel.com>
 <aqKGofPyWqWVWEwK@bricha3-mobl1.ger.corp.intel.com>
 <AT6PR11MB044526A42C6B7BE8BBFDFA1C35E4BA2@AT6PR11MB044526.namprd11.prod.outlook.com>
 <aql8o5UgMKjq3kbz@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aql8o5UgMKjq3kbz@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AT6PR11MB044526:EE_|DS6PR11MB017978:EE_
x-ms-office365-filtering-correlation-id: e0d2230a-1840-4341-4d13-08df14862e49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|18002099003|22082099003|6133799003|10067099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: RnG6grvNQeFf1oRCBx5ouDZNmgF3rNO4qjSqrTXTCUHF1NoEUdzHyF5qYgfH4VKCmJb1D7q2GsZpLmgvVgHH/FmZIyOdMQIyW9SUKhBoxmxpT/gGVR29WWo2ecEJ7X5uPUzEaNyZVbSfCCGqrc+UCw+v5AlPWd2iOsH1YNLL4Tq53B9ulBDCZaS3PqUQ1bjHTZvooqbRzYyRDgv80KXbaiETpJ1bOZ8rpvVfLju6rUXBMLV/+vV2gE1K2hu/bGpbU/6r1WIhEXfWKDHdabJYJCJRK2JTlZ1vHLoyM2b33q/uJ4jKCgF7mpgMNuN4CXyBhLtbLoOoL+pDz30hP+7PtlzZ51SrzbW5A8nPykBxP0d3JmnshbamU5wlcUheL291eGoww4b6enVqk/X/HEpD6Xe1qKWehNkgQUKVwdRVXYAOQ+JeXCGzpu1ALEIlvM8M5MAZPH96R6o2TuDAFax5Cg4heB2SNP1K4LO5Dg6jNM2a1B1lrlukVq8UGQrZlxGWxC9P4x2Ph9AAPZsGBkTDdoeSNQu2/S2T0PiPf4Xr9l8MY7qxHYPZP/gyhdJUeFCxgDRB0FEZxV+8b3L4zB92r4ORN56C17kNcFDD2MVMDg7KAnMCt2f6efwMpicF0OqC6gwuB0t698o2QEN7FREwlZnO+6BoaBQmiUsmKSjh0ss2coSwRZk4+tojE6ROUx0SK00BtMYV6Jfa6b0BgA7PEaZ5tvztovdGqqQskZ7l+/8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AT6PR11MB044526.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QP48yZrkkKwNwV6yXV6uQ/xUA+rrWbCigiZJkXXxgUpe0vKEXWa4TyuDkasI?=
 =?us-ascii?Q?K1DF4WPqLno8R+gziv/TMfTUabyKkyazsxDG+zB82ek3lMwK9Nninr8h1Wus?=
 =?us-ascii?Q?LqkNgB4X1TM3jZ1c4Lo60jmaUFOIfx2JsoUNcdZAhzEgeOnKgODQdhynu5g3?=
 =?us-ascii?Q?tNxK23JQr1Z+6aPV5n8FCx3zk3Qs/StvGvLA6+lkFjb2zA1pE9ai4gz0llYh?=
 =?us-ascii?Q?EZYgoItK9ZUcaJ+TWb42VRBjX/KBlIkt1kkuB+HV8ZY88rdS9xsaYScjEoFj?=
 =?us-ascii?Q?kAYJB1sFB57qQsQ/BE7wsv/TIPNrlwmJ6PMzmVD8T8LFdcjLCSEn9oDJxSkE?=
 =?us-ascii?Q?vuO5JWYCFpcJdy1miG36l9SSHBSoq3PkFDEkh38b3NL0f3Rszjokt8OeT7Ff?=
 =?us-ascii?Q?poHv15xcNqE/7R/z3o1oMuojcKWg2ylnZa70ZTzwH2DNTyzqrBinkwgWJm57?=
 =?us-ascii?Q?KT2yOxKyT0ibLBGOPTBT8F6Vk/PREehTUE3IJpWkbpfggLFngzR1iZIy7v1h?=
 =?us-ascii?Q?TusjWY0p1agcLn5O5XisY+hAKc7s14ZSn7ZFK67yOxo66SvJ9swb5P6I8uI4?=
 =?us-ascii?Q?c9v/9piJalBZs0ZblVcQt2iwFbFuEu3tdQueuMZ8AfisEDT4veb2teXQ9tf1?=
 =?us-ascii?Q?EHjZlMxn8ogfC4bfp75mhwWMmYxBn0y1bq1nPLSv28DfFsg5hJXKHC1tBtBI?=
 =?us-ascii?Q?ta3F1LK3THmB2LWangy3FRkFokvGR7bvxPTlBcqeO4LEHEcs2HgTL+/+fWjq?=
 =?us-ascii?Q?Owe0gTA3e6X1Yu8lrZInTBXfTCgq3DRZtUu1D+O1SmUQHf1+vepQ8TSeYmOQ?=
 =?us-ascii?Q?YMNXncn5FAX+tG6TzSx8Ytsz/LVqgBWmRwoJyyEWfNreHge9mDTWt1ucpRDQ?=
 =?us-ascii?Q?TkpPnfjV/LYl+qlkAIunCslWS4n7lUfyxM9M8mSVIJMbpW6wDWyFobUFjSsm?=
 =?us-ascii?Q?QfSWIk0t8emH0N8iAe9NKGXw7E7uAMl3c0rarYMXuKu5QYCfzJt5CTKAjOgH?=
 =?us-ascii?Q?IcT/OIRNwfolNt9b/xqezLqwjmyg2fPwDV4u9qk2rgL1nl5CjBt+Wqcgor2x?=
 =?us-ascii?Q?n6x7LprxwDFUojqZXUoKAlEEDbesnbWvDazaO3xUBUhitBJtk5d3qw6EToxG?=
 =?us-ascii?Q?ol4fjjnbs2Ly4RZM2OQghqaHbw6wmusY14mSdw9wdsgWO8i/tbUena88JAj8?=
 =?us-ascii?Q?sV2i0R1XbnERO7TUI4kxyJaQd+VdXVwd05vCN9nCcwHt/X/EBQv9rUDwb1g0?=
 =?us-ascii?Q?cFeksEK9jU5Kl5azI1M9aswut5siSPHWPW4nEFI8xB2GK9SA/PNehQ6mNGu6?=
 =?us-ascii?Q?0f6uJF8a/fLZUoPMIAqxDSMx3cxE0gxdNpPmxWnnrLbbhk3J+jK/KMMTxqAo?=
 =?us-ascii?Q?uf0Ro9u9bbK03V0Aa5AhPszG0MBQLbpzuXDuR8wjoE0/kIagNvC6Uv0ggiae?=
 =?us-ascii?Q?nsAeyqjfzMn5rBc/xpq+y6GcxRmEcG4hN93yBmU1/qgaGq4PAu/fCUzgh1Qe?=
 =?us-ascii?Q?4lmyIg5FqR+L88K83t0Ba/ST/4jxLpjMLluNr7B++R+7CCSsXp0YaZZc9Qdp?=
 =?us-ascii?Q?f0sr/xZdXOrzvzwY4M5f/C4df2pfMELbnDSCNjyenMTJRD5HHMFAyH9XgvCX?=
 =?us-ascii?Q?fbV7xVJdUl1futsz8fDA98y0MLWblownKaJ9CGGQtLmGh2syvmTsnLjMdzVH?=
 =?us-ascii?Q?A+ev9T03aO7dncEzBo1w4SAamkFBZTOrUXqvGPpbWmgn3n+HHpxN1xtlT+Xz?=
 =?us-ascii?Q?MTDlEmuv6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L5/3+gK4Oherr+QpiIkEREkkPJmwHbk05fCz2LiJ29cwpinDsXq1Pv/3Vgy2xE6jpME5vfw9ILvjd5yJN10IZ/CCmHCD4CmpryBj73xhv8hbS/O2Nao3SFWbB2m2aAYjnWtLTWy0DV1m/BBEx8DT/QHH2qY/kKbY4A9ede7MCOpdmC1jPDx9birNjvbpYI7ZwwdeXanXxDsfXT9yQJv+b+btPWzUrYLxHkpYg1b6dwtOSPKsT5gv7shHAGlTk7fYixJbRGFmpDtrx6xL2jpVj/6YOO5zH7xts5AAc25Rpq9xgJaEI0Sp1EMN9rOK26Tn9geK5c1P7jXDkj1yv1ls+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT6PR11MB044526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d2230a-1840-4341-4d13-08df14862e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 06:37:44.4028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pHA6sbu/xxaCwWtrYgK+s3dmiqSlqpNJ2Y8PrBjfyVkztb0U36aC24vtPYRd395xP3Okx0Q5x+7+LSUgLNlNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB017978
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

> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: 15 September 2026 22:43
> To: Mandal, Anurag <anurag.mandal@intel.com>
> Cc: dev@dpdk.org; Burakov, Anatoly <anatoly.burakov@intel.com>
> Subject: Re: [PATCH] net/ice: add per-queue Tx rate limit support
>=20
> On Tue, Sep 15, 2026 at 11:19:08AM +0100, Mandal, Anurag wrote:
> > > -----Original Message-----
> > > From: Richardson, Bruce <bruce.richardson@intel.com>
> > > Sent: 10 September 2026 16:00
> > > To: Mandal, Anurag <anurag.mandal@intel.com>
> > > Cc: dev@dpdk.org; Burakov, Anatoly <anatoly.burakov@intel.com>
> > > Subject: Re: [PATCH] net/ice: add per-queue Tx rate limit support
> > >
> > > On Thu, Sep 10, 2026 at 10:04:32AM +0000, Anurag Mandal wrote:
> > > > The Tx rate can be limited per queue with ethdev operation
> > > > ``rte_eth_set_queue_rate_limit()``
> > > > and can be read through ``rte_eth_get_queue_rate_limit()``.
> > > >
> > > > This feature uses the hardware packet pacing mechanism to enforce
> > > > a data rate on individual Tx queues without tearing down the queue.
> > > >
> > > > The rate is specified in Mbps.
> > > >
> > > > ice_set_queue_rate_limit() applies the requested rate as the EIR
> > > > (maximum bandwidth) limit of the queue scheduler node using
> > > > ice_cfg_q_bw_lmt(), converting the Mbps value taken by the API to
> > > > the Kbps expected by the scheduler.
> > > > A rate of 0 removes the limit and restores the default bandwidth
> > > > via ice_cfg_q_bw_dflt_lmt().
> > > >
> > > > ice_get_queue_rate_limit() reads back the value cached in the
> > > > queue context by the scheduler on a successful set, and reports 0
> > > > when the queue runs unlimited.
> > > >
> > > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > > ---
> > > >  doc/guides/nics/features/ice.ini       |  1 +
> > > >  doc/guides/rel_notes/release_26_11.rst |  3 +
> > > >  drivers/net/intel/ice/ice_ethdev.c     | 77
> ++++++++++++++++++++++++++
> > > >  3 files changed, 81 insertions(+)
> > > >
> > > Is this functionality not overlapping with what the rte_rm APIs
> > > provide for ice? Using the rte_rm hierarchies, it's possible to rate =
limit a
> queue, no?
> > >
> > > /Bruce
> >
> > Hi Bruce,
> >
> > I am guessing you meant rte_tm APIs instead of rte_rm.
> > Yes, the two paths ultimately program the same hardware field.
> > But, there are few reasons I still think the ethdev op is worth having:
> > 1. rte_tm commit bounces the port. This does not.
> >     So adjusting one queue's rate through rte_tm drops traffic on every=
 queue
> and bounces the link.
> > 2. VSI subtree is rebuilt for rte_tm :
> >  	a. Stop the port if running
> > 	b. Walk the VSI root up or down to the new layer, freeing sibling
> subtrees
> > 	c. free_sched_node_recursive() - tear down the existing scheduler
> subtree
> > 	d. create_sched_node_recursive() - rebuild it, ice_sched_add_elems()
> per node
> > 	e. Recompute pf->main_vsi->nb_qps, then ice_alloc_lan_q_ctx() to
> resize queue contexts
> > 	f. Restart the port
> > 3. ixgbe & txgbe pmds also implement both.
> >
> Yes, your logic makes sense.
>=20
> However, one final concern, it appears that this feature doesn't interact=
 in any
> way with the rte_tm one. Therefore, if a user configures a full hierarchy=
 using
> rte_tm, and then uses this new API to tweak the Tx rates on queues, we co=
uld
> see problems later, e.g. losing all adjustments on apply of a slightly di=
fferent
> hierarchy etc.
>=20
> If the two features don't interact well, we may need to put in place some=
 form
> of locking to ensure that you can't use one when you use the other.
> What do you think?
>=20
> /Bruce

Hi Bruce,

Thank you for the review as well as feedback.
I have addressed them in v2.
Kindly check.

Thank you.

Regards,
Anurag M
