Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A4FFD8FD6
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:35:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FDF040611;
	Thu, 26 Feb 2026 17:35:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 54E06402E6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:35:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772123728; x=1803659728;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=M8SuSkxzOcE4fvOj1lsh5WEO16wCm2x3IzlX2KeN9lA=;
 b=HW+vDio5VRGjTvW0l+4VY8CRDpgf5pqjtimkJ2ojsL+5BZ5OHWujTRh3
 6tsGPEOyxaLU7UN1Rv3BHZNl0fAPqZQ4yx3IGxEkMRaqQCis0jGprUcN0
 nC99NN4YSxM9p3K3usv2nXyKuYuhIaMdY2RbGA6l+J5u9nQr2zTUBRMFR
 yn7bi1e5nAZEI12Zy2dbwDgdpDrRdXXOQq+EzESzucD1P7J9HW9Btj50B
 A0laiITM9G0K0GIYz7dn6GASyshclWZpnHQEOmKX0OWD19FarPyjsgpLm
 DrLuD3HzWGzLmyhgK2k3Hp/iKidk1TRRv9nc352QmS+UvKn9ZvaNd5E1G g==;
X-CSE-ConnectionGUID: ulTcPfydSF+heyyyPT60jQ==
X-CSE-MsgGUID: ROqVRv2cT+q7maYzA1jn7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="76801807"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="76801807"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:35:27 -0800
X-CSE-ConnectionGUID: tTi7TM7ITAmFUs1iSKx/ig==
X-CSE-MsgGUID: B5Muh+gyQ3K9L1786nYo2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="214141584"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:35:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:35:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 08:35:15 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:35:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZBQBqzyv8PGt7/NINO1KAE8Slve3qqMERcdR8IlkeRTdhUDHi/UOWZ4jCAzkOPQGOwCUl6UzH7lVcLHZWrOm8MsPg0a+8e0dzVUHU+fP7h5uu4T7my1OGP1nSDLW3HOfjhPdeAWzLGT5LqUjapvOlLSGZ0orxOyYrLhkAR1FtXqh5c1SmTECSkd5z8iturBRLJq6CBBo/ce7v/h9Zc6CGGLXqiNw1o08YImv/wa2mkRlUA4qlT2WsSbhgTpQiZFXKM3yjQBJamNu8EOJjFxub2iDGiA2NVrHSWkPoT14i1QV48Y8FWSCG+W4+/7YuffvXmD+mCxKL0fEXcUU/G34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErE/L0guC70GKrGZls6uRNXKJwoyIpIzcrsflJ+oh2s=;
 b=W4a/PDXc1POpX16zrpGX/ZSs4n89UABR8GcQCr4z3WyUd5ZFRrjPZwAoAdBNWwoeXw2xoCnQTbMENuXd3T+gY7CUk9Bx4oABwfRRE3mji8SyLOx1KAstZguWyTIZH865f4b7rIpf90hbmD6pfIrYJUCH+H3l91FxFFy0DkVNFoCs51kc2rE421+07iht15xBlbTjyvenbJOo3TLuNoEGfkvG9RDO/E4OX5LJY3j1S1RujC69PUjOwwTK/bTU9d5/Li6vQbiUn2WspQKpsHELsOXYW1xxwiBJ7IhAUYdvfQmOOFXAkP15pX1neIO927FYBHupkjosk+YXZDtEKst/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:35:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:35:10 +0000
Date: Thu, 26 Feb 2026 16:35:05 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC v2 1/5] devtools: check packet forwarding in null test
Message-ID: <aaB2OXQYrUBHrhFv@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
 <20260226162057.207202-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260226162057.207202-2-david.marchand@redhat.com>
X-ClientProxiedBy: DU6P191CA0068.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 64623665-8d53-4927-bdbf-08de75550228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: MtJvg2lw6M8MBc41NHN0Px1kl8P74DEb/+iivtg0THHcl9Gf08EQDd0Vm3qGKma4PZC2ayafOgSHn7f8SjadhExpXRvrsASQ8JNDLH7IF+1xGzKy28tlx3yIgdFrEt6jOU8QkXKM2crXljIx6KsihiXnyTspdHCi/ohtlAS8mbBTAeULd5/bXyA6SQRv7TayJvXqr+WfouPchSxO4qlIDz6a3snKjmZT6A7ewO74+j+ZTPUd+QMlI+AoFWbu9WcC3LCvg/lK+DdN8dwtHLb6wS6k4G6ZmSCfAQ5+yWwzVYthxPZc8vgd/XxAf781k/gbZCIk44N8EsMgj6k/7QAeMlJqngk9/vwO9O+lJ31TDGlJ4w8wKXC07FUeE/uT3QHn+zLTv9QKx5s4PeEKhFaasOmtFBIiMZeEb9GPEy6ch3lKf2mQhyFG//+IhVRHiEnC5aIRO5emsfEdS6ycbhOYYCaB0rR/OeE8FDk7YatuZmJGSEXv4M2RqoLDXcSgXdBVvgF3GoVVmOMyDwP9Qdybv+7vRrtX6G/0N2Gat0Z/xs4pztlCs9FED1uth1YSfz/vb/8dtRemkhzt4IM3S+tDl3OOyKNX258+NNibWyot+29DnAfrPQfZf9luIE8VMiuJZ4MVrd4lRraKTl7TeLe8jCSCquCL2UC4reiQaCR0eKSJvz/J0vkMEsRjJRv8AHoSGEUS1Zql/fB6RzSCYI1olBgG5tmtMmwUns4bxWvqQpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P/jYeiQPCIVZMaVZj9PT+RNPqlRsz8/8FQHcknlYhQX3d1pTYc7qkJyGtBnE?=
 =?us-ascii?Q?f9okFbOizv0b3tFKQh/fZEZSrYGcG2mM1UmHAaQuIZ+cJ/kkOFAgz++buSY1?=
 =?us-ascii?Q?8i015wUqshMt2m0hj/gCLEdjd3rdccw69FRPG3h1YcevC+3jPur3iRq5POl9?=
 =?us-ascii?Q?jdmrhPseD9IV3pIvWaOC5YpnQ8nf9o2RJr3czZJjbKWfixia2V7SQVSSfC+M?=
 =?us-ascii?Q?8IArXKt7xLsRyD4vkQ4muSqprD29oL6LoBD9Ew8hZHvVdYPpzMNXfTLXvbet?=
 =?us-ascii?Q?VasYF0oVdKtUNQ4fdORJ2Oriqi9qtidkuBSwpUqVtjdLOS5+N/FpiUukIXYz?=
 =?us-ascii?Q?az23bzNJ5ZCEcpJ7qD11G1KH+a+SINnebZSrsG10neqar7r4CoQRgKxxedeu?=
 =?us-ascii?Q?P3gaHcFsSTbZ0R5+MczLsu07gzTB6/9eq4NLoyLDX83C3PmXgHu0NOnecr65?=
 =?us-ascii?Q?xkbcxd7bNo8XCSNi9+zqNymaeb5Yo5Ttfy94yBbFyOut9+R0yB2c9bV8LmCD?=
 =?us-ascii?Q?Iha604dTH0pds1xVj/mhd5ZbTkAqk8Am+nLp3NTX93qWsyYsxLnH26F0s302?=
 =?us-ascii?Q?AP5uVrQXBFTIIDRwYis6SXHfaFxbmOFD92gIrBX9ewbMxaEiWOObDx5BMy8r?=
 =?us-ascii?Q?tVRKw9iQvpm5jj8bWKlkbHON3kItEEwH+MaqYUuXe7eVboGg6z8MAQxfeK2S?=
 =?us-ascii?Q?7LZyHLvNrStCYE106IOBYFPJgFH038Sw4e7N7uLbMjTXYG1Fcv4dzszvNJu/?=
 =?us-ascii?Q?Um3iunx0PPNUjkEKnjAlbtH1A03aENw1MJ9PKNHVPCfpHEWYthct8tiqPnzB?=
 =?us-ascii?Q?RheAQ6/km72aUNQ3CmSXfPPFOPu1GFHEa6CVFAU7hrggnxh99/a7WRW19Rud?=
 =?us-ascii?Q?AVbG/qGaO8MYqqgQms1kKkGJ3U0gTESPhISLKzEa14QXvyYrzNbYuhMXwQOH?=
 =?us-ascii?Q?VgvpMfXokKQZ1QzTiywZ8Vlsm1aynlDGS6w2dbh2BTESqNmNZimWSEiXAT2j?=
 =?us-ascii?Q?+1WJjWu6KML4k6dqOC9V1hX5YIYedxCgqxBiD//lmntkt0/HKM1KrTT0OfRS?=
 =?us-ascii?Q?IIqC0YCwqZP/t3O2YOHi5rKYz8Qh7teq+QEBGujSdQd/hD66brYURj5uAOrE?=
 =?us-ascii?Q?OIELieJlNlfVTgS2dI2W3C0A5QQaeX7jovtWPdWLmIl0aX9mhrY+ZHhzVhLN?=
 =?us-ascii?Q?aH00MW0nCvm2kEXOhiav7+FB8S7K3HMf6dF/42v9cxAeaPvHCIS0QBeR1yYU?=
 =?us-ascii?Q?YHd4UcnmL4D072V3gOu/pUkIRHA2GdsDPZpsElxidrfpo/7+SF2KBE4n5e1h?=
 =?us-ascii?Q?kD3WLazVj0a/iFalrkHTfYVzjnnauUy0fKeaidMXepYbMm5Fq0f/GJaKIzMJ?=
 =?us-ascii?Q?Ub1eg8CiyQb16P+TCuTBAjzyavyEhFXL0D7RTzt9uPpIKiaHCeQnvus5efHx?=
 =?us-ascii?Q?sr8ToIa9HE1HlL84jFhLsQ+9Ov/zJ1z87vgXUFjdROetHNMQMUdAzzV361fd?=
 =?us-ascii?Q?MKhSyENOasWth4lY5whiD+6XCvQ/NKcUDmWWa2jh6yjIHrbre1mJKOaCiEig?=
 =?us-ascii?Q?+xOEleaEgwzW02NW6KlmmuzrjSoyVG/nJdoT7Zymx+Ur+zhayveWx8V4nA5v?=
 =?us-ascii?Q?Wc68XRIrZTwMAJrKQe/XBRXJmrFerl9apjNZ5+z6BcywFnZ7Yn0nPc4Qdn1/?=
 =?us-ascii?Q?uvLDCq7shmJGWmAsOwe+qgJcictj4GtCnUPguo9MonTqmJcwblrbkaNqJSMP?=
 =?us-ascii?Q?ldU7lZQruYOcyK5AjaO9/wwSHU6NAXE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64623665-8d53-4927-bdbf-08de75550228
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:35:10.3426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMzyOXIXFU57HLc/JjKPay9lXqctYWJET+tJ230jXSR2lZ0zBG4YYJk7OnT7X4ebUFU+Wyyu5+0EIV5AVMrdUFiSqt6arT1eXm4CRGyf5gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
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

On Thu, Feb 26, 2026 at 05:20:52PM +0100, David Marchand wrote:
> Add some simple checks that testpmd was indeed polling two ports, and
> some packets got through it.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  devtools/test-null.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
