Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD88C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 14:26:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E017402E0;
	Tue, 27 May 2025 16:26:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6D9EB4028D
 for <dev@dpdk.org>; Tue, 27 May 2025 16:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748355965; x=1779891965;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2UBgH5Kqxj6bx2ftIE8IP4VqCC1+C+nZMInrQ31v6L8=;
 b=nogno+TGfdmlxmRljk4BwDItNKDMouCeUaZiuoKBEjGXS5tAFD+TwkwN
 JjNIvzhzKOPdJu2jHmX8a3PSNbrftP9l9/mJ+gTcAvzppot3dpejzMs8i
 zy2S4Oipey11wybKj3haMwicEeULDFljrB1fR08FAUHgjkIwBcxFVu+U3
 +/Hon9bfyOUHrSzsm/i6/fuBuaPrT0JOtFhAiBl2ykEHYsvf0mzzEVSuv
 R3+w8JkPlnZKwYhL16VE20xERCcg41xfqoJ71EgMhNaNNJr/8jiRP/72w
 L2tmMkf5yxxPym+dBCEE8Vr1oDmfI/LkguPFwZVuvJ6aUsg1D/wyxtWIA A==;
X-CSE-ConnectionGUID: Nq5RoqwvRValc+781kktRQ==
X-CSE-MsgGUID: YGBXtpe9TrmNm7BLC37bhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="52970425"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="52970425"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 07:26:03 -0700
X-CSE-ConnectionGUID: 9ZIsOEmMTb6Zcha6czgAiw==
X-CSE-MsgGUID: 2XPXSFwtQ2m2+JPSHfQ50w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="147862536"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 07:26:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 07:26:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 07:26:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 07:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE64exYSA+oJ+kxgn3KzJpqlrbRtEINATOkN2R20p6yPw8UGzW/Xs5TwP/nfufSw8wtZHyR/0bLppKK6yC08f8W4CtkJm1qWZkGBD8WOl6G3Is+Cxg8fvI2U8FsacKoxJbEWIMPFMXHiP9EkiUWG8IwYqbepGv67V3s4wsxbGSR7ibQa4MKrRJvNUWFMLXZe7u+bOjUGIrzp3YI0y02+6Hpf2ahIqiZoaZXNQEgX+tyM9PM4UMcDAgvEiYAkBfOvoASXn5F5Getr0kF+QPPyJAACNQhSC+NiUOfzfnX8KS8kdxW8eUlpW2FJSGkiLKqcSGqJ9Wr0Wu5GBPFFUZ/UYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyE4qCzk67jEuUvZX7X9VH0mqflR6hBAGQFeRCC8WNk=;
 b=tE6qy7DSaN3IqopTOesu+EpqiQ/IZ31QlnW/qWT+He5C6980jqYNvu7XmJuSvEaR+4wnqKSoOEAZD4j/wUaIUppbvVJ62V8F5VC1OjUu7GQpAbFkvtCcvs9m13C4xLuH9Kw+DQYBRtgobjt5FeBmjTPCA3NgLIaNMMzQM4ik+Xl9HOdeukBvB5LnRN+H6pl/SuOy+PvGAiFUWVAr8UdrZmdsl7XVuES5mDz11/MxSTpUOXXsWszSmlijZjEIScFCZAYuCqIfNx3Uk3Bh/AN9/FS+Q33wlcpBkDpg70BZLJyXrPEehEWsNTzp9HIKrweoQNtitPwnZfCFdjB9rjYB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9084.namprd11.prod.outlook.com (2603:10b6:208:562::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 14:26:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Tue, 27 May 2025
 14:25:59 +0000
Date: Tue, 27 May 2025 15:25:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Nandini Persad <nandinipersad361@gmail.com>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, Ciara Loftus
 <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, Julien Aube
 <julien_dpdk@jaube.fr>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, John Daley
 <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>, Ian Stokes
 <ian.stokes@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, Matan Azrad
 <matan@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Liron Himi
 <lironh@marvell.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Devendra Singh Rawat <dsinghrawat@marvell.com>, "Alok
 Prasad" <palok@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, <dev@dpdk.org>
Subject: Re: [PATCH] doc: fix anchors namespace in guides
Message-ID: <aDXLbglk_hLfTMXT@bricha3-mobl1.ger.corp.intel.com>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527140435.21361-1-nandinipersad361@gmail.com>
X-ClientProxiedBy: DB8PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:10:be::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d462f5-f0e6-4fc4-8fbf-08dd9d2a66d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ko2wv48DN6o+lhWzXBzvmXNMFhFpbUvP7zWrQqdLdlbUmbFWMn63J2hYlhkR?=
 =?us-ascii?Q?qJSeKmCOTGWNjza5qvYPTIvJTR2BBB7nZ1WSug2V/36YOGAvPZ73h768bk7e?=
 =?us-ascii?Q?maVo6MEzMfJ487anQ7TQLb2Sv0yxaPhXrkocxariSeLsYEXCwNzbdOlVjmSZ?=
 =?us-ascii?Q?FG57FfwmOL15XG0FBNxtiydpHpZrAfIvlMfXZq/EVkxoWdrbBY6UF2Dho0HG?=
 =?us-ascii?Q?8QU5kJ0AJO478E7t9HstMZUbp7MVSkvq1KS6CgwpDSSnpW9atAr0YmZ4lHyI?=
 =?us-ascii?Q?gGYUlaHSMohI0mGYVl8Bi9fI+LKyea54hXrF037zlrFsv4kkJCD1SsqHa+o8?=
 =?us-ascii?Q?B7gytOpcBRU8rQ82SvrFkZf1OIi8USWV/a5iWd+1ujGmxHFuxUJqPf6FjI8D?=
 =?us-ascii?Q?6tfalr9lp79LreYOiP5NvcqB8mx0BUtabJkL+ehT5BvLMtpHu5kt21tG70Ks?=
 =?us-ascii?Q?eri5jRD9OJxVjuYKT4IX+tWryiK90+XUA1PUKnPM5X6z5zWSO6Hj2PUyOM72?=
 =?us-ascii?Q?wteILMtyCQaowv6//goFxkPfAVRBplnd3Jv4xl3/qQJlpBRBvAN1f27VhWya?=
 =?us-ascii?Q?Q8e2MdpJy54GOlZKUlwW8Yqoqipm6mH+S2O/73Nsb9j4ah1iPhiS27ExQ68b?=
 =?us-ascii?Q?t9GMvCM+/f+DMYzBZRL8o84tkt8wsc72pubYxdzpXKV7OGJVdsuEmJYYfoq9?=
 =?us-ascii?Q?mergNcU4Bq4N+EXmfEk+s2Tcnzt2vy8vygGNrvET/D/lARuyfwGWtY00d47U?=
 =?us-ascii?Q?zM1FtWWsCtARLqCd4xwax5+nP3pFC/TZtWuzRPKLrk7eTfZjQkwNAaRsv3As?=
 =?us-ascii?Q?pLkQB8hqn+vRwvW7EW87TRBrB5Q799UrfDIGEq5t8/xAS4iJRvQ3Y4akjdLT?=
 =?us-ascii?Q?8kZ4pw+jwFn+e8RbHJJ2qD3nnknMfnH0IaRduN88VEHnZFssV/pKsAXPMKBv?=
 =?us-ascii?Q?gXgDOvQunHfQwoadHBVSplx0AP1kj1l9P1jEeTJH1mu1+/Vw8Uou6bcVwLhV?=
 =?us-ascii?Q?+xMtsf7N9gE0sjJULu+K4uPs7DvfN0QjQoAR13GPwpVPqjVTSjCRCAcS0CI8?=
 =?us-ascii?Q?rV5zYhbGgVEravUfN8AYGoi+DxOy+zk7BthMyViVgUA90CGvRf/08P3am7Xt?=
 =?us-ascii?Q?uYwCy6WmMs2OzpH5ugNkgGaCL1UDtxmt+n03OMgH5jii+NwBDTLKnn0QKIeF?=
 =?us-ascii?Q?ESNLUf986yWroE6W0NgnvZLm1Yxd3I/GY64nX84UYa5qQ/ky9v1J3G+ffEam?=
 =?us-ascii?Q?Marnc1P1ULO9eaSgTIo0q1DSJmiUFKLq2Kj1qLpckNzpHOlevYwh8VYOO1zX?=
 =?us-ascii?Q?d8w8FiZL7S8K3Ep32PjIuhzXtgWPCcWR4TpRP1WooKAQm8hazm1TyoJ5wvbA?=
 =?us-ascii?Q?JvJAcQ+PX1jMbmuYu/ZlDyh9Quz4oK19xPqNODavRatiwXPZJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bbYuTduoy/FRtjFQZBMQ1fIN3JTd7rUiylpsdSNwBRkBN8MjVq/BKlLQbztG?=
 =?us-ascii?Q?clSYfVFF7KzMy3WUX8gur3QIkURqvU47QULx8yyvQhvQshe4/zm5v8bTP9n7?=
 =?us-ascii?Q?V6KGgLeKm/bWEdXpBYPDvU0Fb3B8Za3NSOAmSiTE0aq0cC5yAeGUOdTpkllM?=
 =?us-ascii?Q?sLTdZN8j8tXBPwx1uFOqvJFd23amY8z1Q7tIcNeuRl1bUY+b12siT0pMdV9w?=
 =?us-ascii?Q?d5swFdnENiv72sljN8suK1r66JyhkWSrUe5Iu0GA/YOrZLHhRT3eP34JATRn?=
 =?us-ascii?Q?7m3RE18Lw2ycmMYLvQAds1ul88PLvFewsjGC7y/TZEi2dIrR8s1lVTLYOUbv?=
 =?us-ascii?Q?dRWNpBtEPfmOUuTMLAR6UvxNAb0rGxn6sGwDv7OMQIop7rduTmr6YOweqoQB?=
 =?us-ascii?Q?lEB4eQgdUlHsKWRAtkiDk52jMLcescIGPFFwXU/Fa4oMwU2bXVLo5iHqK70r?=
 =?us-ascii?Q?/UD1fAu/J/kTsEfTz2CfZ1M8lsN3ZbIZLRuKXu6gYU/xHPrHvaGdw1xdrES7?=
 =?us-ascii?Q?y4x31h+m7e9FRi71CVaLZWlgx/GNGP/G/nd5BvK0AZmdAT/+K3yTCxQVpJ8Z?=
 =?us-ascii?Q?dn1qNi95621BTdiA2mqdzlxRIRSLe4HGTrcx/CGcAOwJ4uZRuqTClcHrNRJM?=
 =?us-ascii?Q?eCp8smUxZXAn5jRnVSV9zAiuh7pLWfKofg/qFRoFV8WQ7ylm2EKP/jKFio8Q?=
 =?us-ascii?Q?vAg3o5K+mQn+mrh6XXzMDW2BR4kImqU+TwSDjVocSAQeASUelF4X4pvTbqGO?=
 =?us-ascii?Q?4mVDqemZBSXDqqA1cByDPRE08t5p238pW4W8N6cu9s4VfAwUS922IWPOmx5P?=
 =?us-ascii?Q?abAoKv+VxJJKSQHYPJknx6+z7r0MAmVldG+7eaxDkRPcw9f7NQOQ/JyRkFn5?=
 =?us-ascii?Q?FYxhvgTRvfpSAQrurbaDkgXl1MauJRjMwceTCcicgEhoS01jIe/2BRKXKVlb?=
 =?us-ascii?Q?D39SRRkEAjoJmqg59mk+PYTssYLDblVnTwHvk1m1XG7KOX87CSl9E6vHJqzi?=
 =?us-ascii?Q?YCByxWHbteRD/OniD8CZpeO7w9Uf9XhcyNbm08X0OIRiN8egMSh6t1rH57mB?=
 =?us-ascii?Q?yCsvqf81cHN/2z0cAHYJGcK1QJYWhr1eyTQf8mm4JhRPsIYFvF//gob8O2OV?=
 =?us-ascii?Q?MRFGwkfzFOzCq6dkWzUphCBfhFf+HQxU8p2Ewy8I6sXpr83sUiVFxnzyYJZ9?=
 =?us-ascii?Q?4f+7lBVDYVLtu70spHdlBQBA3ZQRpuJ4X/z1Q2JppgQQfj+R1Nyg2NEFx5AS?=
 =?us-ascii?Q?gB5lvGW9oLCVs1hO5BMLcTlYcnTP5qteBBZ6RWOpLDDYwVsjsbcvPs/2QMhe?=
 =?us-ascii?Q?LMEmsNZCnW65vkzag2uHcfGacdGlVxnDI8opr807ot+N7WmHmiIhXUSdapGf?=
 =?us-ascii?Q?KL83kmeMTJuZ6Mx+TrkgW4c4ejGZ2Yeqr+oCGo/qOB/ITQSyECytNLCjxfJ9?=
 =?us-ascii?Q?uiRaaSsTCJD4UqFBWeRrF25W7aTdahQSXgxUI+9PQIRr+2iXAYQ30LsujHsu?=
 =?us-ascii?Q?jj2TOrYZA1JygPj3/tcnsmhdMYdNXeGNRBjjiv6JXirl5RHxWtPCQhJRUH8i?=
 =?us-ascii?Q?VX9+fo07O1xvXTOT8HKAXzI6qmVL+7N2kxZkTJWsj13+3ZQcIJErYFm+KPEl?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d462f5-f0e6-4fc4-8fbf-08dd9d2a66d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:25:59.8244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulKiZYLCHRsLDGwwN6T+pFjG+ZTq0RDrHcMM7KhjKxAgGqPotoNCaKJTKCFWqKEYTyIQt5ddHlYL01U+UqLfRm6ObI8XWBpBgv+0EQ9OlRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9084
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

On Tue, May 27, 2025 at 07:04:35AM -0700, Nandini Persad wrote:
> I modified the anchors names within the guides to have a
> a clear prefix so that they don't collide, based on
> advice from Thomas.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---
Good idea.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

