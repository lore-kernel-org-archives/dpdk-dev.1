Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8868F33A91
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 15:30:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E96884029D;
	Thu,  5 Mar 2026 16:30:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id EA74940287;
 Thu,  5 Mar 2026 16:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772724641; x=1804260641;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mp/pXCdyat7LRV6UX3ESbXmqVm2BV4WhUzxh7NgJDhk=;
 b=Sy/MsERRFYy1/tLYN09OiS4PqraCH//izaR20V/AyGODVnlom4YWPJYg
 ehspxXocFFyTEEhqquX5X4cw3lriSFPUEqNcWMUe3b66QPIF7xS8Ll6lT
 JryyXlO5+ncaJRwXSu+0tZh2aCZJZKq9OJeLIMEUjg+EcHE4PJmXRo/xx
 aln5F5+cq3V7A4cICa4Xd7+ZxhDHKaEZONIOqBkFHtt+DByyJnTNi9Z2B
 S2elsEESpyWhKXVlRibgz1Q4lOX7Dm87ex0iWsQWN8npUJDUbK7NrdYFN
 MlvLmF6JfKi/DT90GuOfpiU/0XaOPrAxRDYXSJu9g2+2u1bI7jT7Z2eH5 w==;
X-CSE-ConnectionGUID: fvdnsHjBTuG+Db32AgsGZg==
X-CSE-MsgGUID: juq6ZxWVRdW1nVL0A5m1Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84528514"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="84528514"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 07:30:39 -0800
X-CSE-ConnectionGUID: fhDm6Z+ASoKygsrxvRJdZA==
X-CSE-MsgGUID: QqROU3+YRSGonAyqA2bsRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="216987609"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 07:30:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 07:30:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 07:30:37 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 07:30:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR0Kcjt54GL/JmxK23mtkOjgbSr+tVoi/3Y1NyLDU73un1uu96+GDzZ8k/i3T79Y2f2mc5DCHp6qVU4Qx3Jg4yVWHDwnIwjzbf/mqiqPBPpDcehLT7vj3GXLJdnjk50O7wBW4zszdkU3WiEGMHXbgCgfGxV0xclbzTzGQo/G22LlAP+L8VRXBcYglGQckTYkFdZvaDc9kypffk7Ua6EyQ+erJQP3HhuBWKTXfqrBLa1ExD+4DpK8SNRCkqhJQn5p1JoGX6cM7yKRC1CWAUA+w69m5RHS05MdoddUvE5vaVIY09W0iiOo9lyhr/pQhv0Ih70YWkq7soxACysloAuOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QVwjjj3AQaPg+f2MS+8gnDcU62YtRRUe/QsXAYbx+A=;
 b=uQaskLcL11DGsvoVEaWAb1c7Qj82wnaS3HNFM9wdfnHsM1hVbodFkQIKr69KYe5C9VND92K8DvV5R+olLAFsPPOEGnhqpFREjFCzYGth2ojSezcI9YPYXj0BeRJEDGqhqK88o7UAsru+c4tHszKp4oDvcLD6TMa8M8r5TGiBVqw9wvfZJ3TrB+KxHaWB5hDzpvkEh2xje6IA8LYy4eERNi9YxP27iecO1VrvmnLTTV/h3mi21KtzmVGcQ386gLamMk8ZoggXQjzvCp7OF6FqP0hzwKdXZqcfs5uZu9mbGw7fYohOmqodaA8a+cRBvl7oKjz9eEc0tlkR0hmL8SXIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:30:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 15:30:35 +0000
Date: Thu, 5 Mar 2026 15:30:29 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "albe19021990@gmail.com"
 <albe19021990@gmail.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix old primary MAC deletion
Message-ID: <aamhleyVH7x5A7iY@bricha3-mobl1.ger.corp.intel.com>
References: <20260304111606.283035-1-anurag.mandal@intel.com>
 <CY5PR11MB611638120355BFCA2B2E5696E47CA@CY5PR11MB6116.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CY5PR11MB611638120355BFCA2B2E5696E47CA@CY5PR11MB6116.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB9PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: f688bf82-7ebb-4376-91c2-08de7acc2535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: cGEPhj5ZPRVbu7eHoOVMcdFzCj7kPpcQQkA9P2t+iYexiiX7V15R2Yl01ztg88IrYcj2uErF9Wad0HT2p7EMfUu7m8xSaxRiip6k0r53IQq3cahUYD4btJMvS0oceyKjQ6IcAwfllrHurd9HXA2LKdKBJK1qc6LNCYJW7fQ5cNi08z74ik+pOcn6xsi/7rkxa49d4NAFCObwuSHh6dMixgalzi39vFUEJwJ6e8YE/fT+D3v5w61grWXVjKXikFM8a+n3uGJlpZxOyFLuCQNBw7lTS7mnSYuNiZaTpABJLwFRLF+yZgjn0WsLoPtGE1tj2+bSDsZ7kBLPFi2HhoFzqxr/lEoTS2D99aC3S7MRo4A7OXTR3lOtbjmi+O7bWI5JmkXTcPKrLILXki6629oV7+RMfOKfnXDKZPX5omZj2AdZen6YBNu7nHVQ6ynnhfJ1zRuLyGXkoXXoSbm+J9u8nmktociIdEd0F5eHJ0fcU7XIv3B1jlfAPIjq/k+GpknMXZhSaYRXZocIrMgjH+UpaZFF+5B06r8Gx1YudX1IlntxO6BP2+TRyFO/06gUv4973JVXAv9OOQDi4Qeu05h7z56tMhqeT1L8qpbjBILyk1ts4xFT780W+KsNV6oSTSdLwCg4L/k4mTR0dTILQUWekP2h0PKepLO1OPCSMQZ6pXc1ABc2hEOI+IHmvWS2gepr/cmGpax4MAnkmjeferRbTG3HWaqp/w7UFbR3Yb+ed/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFXBcDTC6JDCMZ4AWZzWxm2dNP83hVaHRLGboyfsw3jFh14PI3I16MGrYPHT?=
 =?us-ascii?Q?ZVcZt6Hi/prmPX4xJ67E2WrUEFNKx7fYsZZEGhMx7gGtIHjjB4I7ni1LQfGS?=
 =?us-ascii?Q?R4PMNEBsFnwK3yzYzUeg5zk9qzfUOa6iCr6FpGQHPBqQHxFqyPP8RySm6Lmh?=
 =?us-ascii?Q?m4OxNUB4OkF8/Z7x4kjNApTnM+KsXmKdUXnqpfIKkUT0AWurf1uxtvKMQpsm?=
 =?us-ascii?Q?tF/ZluTB9YPVSNAk/NVeZs4Ycin/ztNFlOJllRRyvBcJmUG9RaRO/LGK2Rwz?=
 =?us-ascii?Q?C/HGtDh6/i+Z8bLw9P/dZGBUs2AnVa0I5Q6UJpJqDslhbaHh4T77aocrS1u7?=
 =?us-ascii?Q?hLJcSX6I3sfMj2De/z3Ugkq2LXeH750oQX5ZZc9bQbnaEr30OLXWHmGnt4Jf?=
 =?us-ascii?Q?jp7VECl0Xbs6npIO+nmwn+fIE5e4T3HwgN0uRx7aXkzRc9DGHtDnMJxDyj4r?=
 =?us-ascii?Q?G8UxTNB/NGm2lO5zrBlVI0U6mdrVPoAwy3fHxhx/WHFTxG+bb6GNRoJrqXwR?=
 =?us-ascii?Q?10HtmnxV3uDm3zAPdq8P0272MDqyJZnBJi1E/QupwkoUdYAmSwwbklZ1iLbr?=
 =?us-ascii?Q?7S2NQXGlxv0oJiwXgLfz/jfwg4vN7tdlkNwqQfzxM9wiwO1xD0IHn16hJoe3?=
 =?us-ascii?Q?TDrRa6F10+oIO2KGzczBuIuHXjm2rKzH9HXWWEx3qEgqgbAHPVmtOXk2co+9?=
 =?us-ascii?Q?wGUhCtrNXtDEN96Y+L8ZHHvNDaLCN/zNq7rErLzIoDHSSfJYSN2EWOyG9ku9?=
 =?us-ascii?Q?o4znAKpkPrDdWJKsencxL8Nn9u11DRCDUzkFtWiVQ4iDVOCL6D8Tnail3KL5?=
 =?us-ascii?Q?uE6+4S6sDPzat3Gp2Wwt1M6eg+XmgApEja6Z/uUNE7IRxD2pn2ngQSW0ug1Q?=
 =?us-ascii?Q?wQ22SaU+ZVo8zLxkTUFTlcUgMPOHQIpf0tKdnlFvWtLHCqHU0UAw+ZhfJNqF?=
 =?us-ascii?Q?gk44rM5tdWhpzG+h55XWKxUHem+qXD60rwbXLr7AwTMWtIYaayaqUGK5LhCC?=
 =?us-ascii?Q?t/h+lynRlgCnolVNe0P0U/AeZ7mX08mDjol84x4KEqCwk3idCTCB7b3NV2Cj?=
 =?us-ascii?Q?+tAcOTRHJu1IRiQL2jlEEswSlRsAcmo1cZw2+31LeDeO0vkFmjvy5lA5kQje?=
 =?us-ascii?Q?5fAF5xAz5ae8c60X6UUdcCXp0qPp5Z9DMpYeju9uLdDtdsmo9Le9smBGTtf4?=
 =?us-ascii?Q?qGPZzrHRP1sFzp2ejoXx13TUX7hm/dtuFuIjPEws5TFhe88uyhqGRd3Sdq15?=
 =?us-ascii?Q?C+caAgu0la5bcxDRlJ204G2inoGCuKTLwFbFVjv4kmoxdg8se1e9mOKeM9CX?=
 =?us-ascii?Q?9I/oE01fl6ZBkm7HbOs784tbGPtvrkkBoIjqTZlNhWzkPad0x0E/9DypQr/0?=
 =?us-ascii?Q?VooFGmrWOb80saTemNBl8K5ByQGKjNG6LWGPlgdBl0yJnUUUp3YRuxTXGtO3?=
 =?us-ascii?Q?76YSufa6gh/+A9gJ9J2xu6LUJu84CcZkcJIle7GT9d+b7H9lhNZKA1tXVAAJ?=
 =?us-ascii?Q?JtJfNT7/eEcBuO3/6YpAlse3RdZL/TxUY641TBRyoR0SuFAU+15zh1PDEDYk?=
 =?us-ascii?Q?dENclRAupVLG5QjgubVUDZWvx6fhqEIrL8ovgKdRbb4c1cMjss41l4knHpj/?=
 =?us-ascii?Q?vWAR3UpL+4Y8cQrsy18UpeikeUF0O+Pyr9jSY29lWw5sdTSlAlFH6J1roXOn?=
 =?us-ascii?Q?VGBf29axy9MwVJWPm6X0+YQDEPOmXV+m78CpubSWvcVq8g1nUm/ppMrfaFns?=
 =?us-ascii?Q?5qRlt8ZItFiLWDtoL78IC9NdISym4OI=3D?=
X-Exchange-RoutingPolicyChecked: ri6NAsybTemBH/lGEuuj9jlF8nwfJEjpS8UZJwVYJwlXe+51b9mIK6GXUmy+sllKsn2JtCAIGg8Qm2/auAyetUNgMfBewmXt8e+RN21ifwgxK1ZoLS5k2C2sNBRtFNWXBF4rEuuUlBNcYaoJ5iWwh5jI8R1a6CaKB5nP2/YoZpEbRuj0aeLQghbbeSC1ORx8XBLAvSjjH6lMU0wR3WZk+7Zd7l0kyKjB7I41PKRwA7WrP3ZH4obEYggvbTFM1gTZqHNOvC0JJ7CkXGgfnjZUoIr1E3uEGNAlQELg99OHEfgRgFuZC2kqhIYkRC8N4BIOaMmfGgWKBgQEuVXH33MKtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f688bf82-7ebb-4376-91c2-08de7acc2535
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:30:35.1778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rgJW3EqCK8RtyxlhaIgX7RwXceXQXFiPd1zZfUMr6jx0W5UKwIKlf7RBCqQgXlZVBQyC/B2x9udcZFRhxF+aeI5a+z1ayv1pK2mf1QfPrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
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

On Wed, Mar 04, 2026 at 11:43:12PM +0000, Mandal, Anurag wrote:
> Tested-by: Aliaksei Belovus <albe19021990@gmail.com>
> 
> Comments from submitter in Bugzilla-1897
> 
> "This fix works at startup. The only thing that bothers me is the iavf_add_del_all_mac_addr method, which has no error handling and doesn't take its result into account when setting the mac_primary_set flag.
> But for me this fix is totally good. And my problem was fixed."
> 
> 
> > -----Original Message-----
> > From: Mandal, Anurag <anurag.mandal@intel.com>
> > Sent: 04 March 2026 16:46
> > To: dev@dpdk.org
> > Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> > <vladimir.medvedkin@intel.com>; albe19021990@gmail.com; Mandal,
> > Anurag <anurag.mandal@intel.com>; stable@dpdk.org
> > Subject: [PATCH] net/iavf: fix old primary MAC deletion
> > 
> > Old Primary MAC removal operation fails while trying to set the default MAC
> > address on a VF via rte_eth_dev_default_mac_addr_set()
> > when VF is yet to be started post initialization.
> > This happens due to non-assignment of the old MAC as
> > VIRTCHNL_ETHER_ADDR_PRIMARY MAC on the VF as it did not invoke
> > iavf_dev_start() yet to do the same post initialization.
> > Logs indicate old primary MAC removal failure even though
> > rte_eth_dev_default_mac_addr_set() returns success causing ambiguity.
> > 
> > This patch fixes the issue by introducing the flag "mac_primary_set"
> > in the iavf_adapter & is set to 'false' upon VF initialization.
> > It is set to 'true' when any MAC address gets assigned as
> > VIRTCHNL_ETHER_ADDR_PRIMARY MAC on the VF. This flags gets enabled
> > only once for a VF.
> > 
> > Bugzilla ID: 1897
> > Fixes: b335e7203475 ("net/iavf: fix lack of MAC type when set MAC address")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf.h        |  1 +
> >  drivers/net/intel/iavf/iavf_ethdev.c | 19 ++++++++++++++-----
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > 
Applied to next-net-intel. It would be good to have the additional cleanup
done in the next release, but this fixes the originally reported problem.

/Bruce
