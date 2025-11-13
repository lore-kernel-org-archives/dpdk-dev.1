Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F27CD5BC0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 10:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B246740647;
	Thu, 13 Nov 2025 11:37:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0741140151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 11:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763030248; x=1794566248;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=195fD0K0K8+P1nBcn+/3p57G52PvT9Bp6wTpPHHaPZs=;
 b=avHipOvcMuF83kz3wKpvuPbQDjnR4137vsewown5+fKBOhI8Owa+mNd2
 m00fBNjb7LlGgDnDLopBbsXTKzqS9KXRtzjqke6vNOHytaJ4q+CTNaH/k
 ZAmWQErm9BaFda9D9IstEC5iP0Wa9ciVsx4CtpU/SmgTy/piE1t1lHVzV
 l3WEh4LRDSjuv0WUkUFVOWutpnuPq0H3WFi7VnpZX2ZefH9aiV/FjScQS
 u+IZRi2aqslNUpRKyAJV3iuVyEp+MMJWgjUk9L/pO6dlDHsJDwe1BFuyM
 KuLyiIFVf6csawzPovHMcwofmuaRnuCNfs47tULdPSzmRlQTjYzxe40Oe w==;
X-CSE-ConnectionGUID: tLTfz5E5Rr+2FQDXt2+DhA==
X-CSE-MsgGUID: pbYptiZ5Qt6v/xV6TPIZrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76566533"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="76566533"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 02:37:27 -0800
X-CSE-ConnectionGUID: XYO+Oj8aTKiK3ktQ0yBd+A==
X-CSE-MsgGUID: 3dRze47aTeWxWfv1ltNEnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="189648825"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 02:37:27 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 02:37:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 02:37:26 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.32)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 02:37:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXg0Tc2EfvD+F3SSmSEOJ7LIyFJIM5roxPxmJiIoz704uI+YIuiKIaoStVT6WpuvQLrvPuXFvp/QkauCZTh8Mb0LmaqTwH6o43LZGlLF7X8hfF2iXoHjWhLU4PMRLXLAIHdi+cRIQ/1s3PiR6YgTM2csxkDmMgNg2jWpdsiHRa0hjq/hvU3qbFEPO9XNxAwBXZ2vAPmFaCxdengFZ4U65TLRc+jNxA09zwEMRrCXrsTV0Vwc1StzL0EM+AMD7TyJWgN2frlU756halsch03rc+fRxATS/t+N0hCzWnmEXrEDlsxhniV0GFeCwUdyiv77+UmuYJPKas1qj/gGQ3P7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/ENYDwHzlEcXI+Cktr0+SFmM9CIk3/SHIkhczMSZc0=;
 b=PmGOw1laUr9+AdqiHi19q2c9FSLRkJn/OrFNKHgSAVB4FLkBGw0yQ3YqlIbeKRPC7WZWhQFRjklTaijUH9OG6l6M4+w0UN8c/u1PIDGsVz+MCROhhZNif4ZXWol0yBKEQ7xNc3Y4r1JKIIS/Cl5zl1ZELmMTPvLi77yjrisbXeY4JcGxo9vybHCiByeAuvdh2FMlEmcwcro5Qb/VqA3Ue1qXyE6MJxRZ/h9YRnBy2xYA5Td2PkNl2OcoXKnUP8EQXA3iYRbqyg0531c5rIrMXYZfu+rV6puC8cUcpCKbRKZ/Vs7czA89a1+7f0NnO3FYwPi6eh0ot8BALBW/gMiGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7556.namprd11.prod.outlook.com (2603:10b6:806:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:37:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:37:19 +0000
Date: Thu, 13 Nov 2025 10:37:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 1/1] doc/ice: document protocol agnostic filtering
Message-ID: <aRW02m6-LMKqfw9t@bricha3-mobl1.ger.corp.intel.com>
References: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
 <5d6aa3eed2827e1f7c8e07c1e344e232f010f0e4.1762947241.git.anatoly.burakov@intel.com>
 <aRS-Fk088_bRM3gB@bricha3-mobl1.ger.corp.intel.com>
 <a3d380e1-cd2f-4953-99f4-f3634accc675@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a3d380e1-cd2f-4953-99f4-f3634accc675@intel.com>
X-ClientProxiedBy: DU7P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: f87deed6-3864-4405-604f-08de22a09ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JXC+FHZg5ukYwHCAMGlL8o/hdzXxb8VkP8d9hCZYustniSDnh88iMNPwlbNx?=
 =?us-ascii?Q?VVwc1ugrWJRCHaSY3bNmjAsEREZZs5UZpjx/7wha//yoNUBBW3j2Fch7VRw9?=
 =?us-ascii?Q?l4opO+TOffVQ37DMOmKsejhbv0jftIIuIzjL3QA2RR/K78tR927pYxswn+gt?=
 =?us-ascii?Q?bJCcaBxfUTPgPyWphOk6dP7mG4DGPC1K1y9NOBLs8ktCofeaEeOsDJj+1JAr?=
 =?us-ascii?Q?XyGbQuCGnSwFIyP5zIImtC6jbi0eew5ZaeCSFQxoggB6Zf8BxNzR9tgf8uz5?=
 =?us-ascii?Q?RWMybNYe9xaZl5ThzII2k0ArzHZ/tIVZyliDvdnROTJoomZ1NLfZFcPpEjik?=
 =?us-ascii?Q?OTib25GWwSJNtab9WOj4aB+PjGOwN6eGMYEojxtAexD70K94FRXbuFOoPOxc?=
 =?us-ascii?Q?vbJNz18NjPnSOymqnHSvDqb4NPNp0cNI1k2H4WKUdrso92+OBT8nCIbcUdst?=
 =?us-ascii?Q?TNJ0Qn/Pi8UjbQpuGdZXrPj1BGWc62PPfNvch9A16V4Q0axU3lnV9EKppsCc?=
 =?us-ascii?Q?ZtIveZA4owUv+INJ8i5VjuUhTbd7USHxhbS1gCuLj/2AgSs7U7T1Ndne1sp3?=
 =?us-ascii?Q?1U0crn0zWPI8m8sWgjrdxMTf03vtvaTwXWU9jIWLgb9sjC4424wkAOH8jTGA?=
 =?us-ascii?Q?RBZk+3peG9fyFB34XrCKK2remGTGi+QslamMaU+xiPcRB8qBK8RL/zIF67Oe?=
 =?us-ascii?Q?cEFDjcNl7tnKRGvaQc7W1wU3zDHfiuk9egJqevDp0/yPGMtfzbDk6lyN7Ei3?=
 =?us-ascii?Q?u1Ycj74tqdNUMRaFuAvtg51J02irtpQOnbLDldVmSkXfimogfhuqeQ/dq5sm?=
 =?us-ascii?Q?gkGn+2nCEtPys6JlbmPW4qwHML3Ia4/QCoWbpNXh3pSeoIgQUVqwFi8fDwxY?=
 =?us-ascii?Q?A4A0ohcweVpfCEdob6DgdjCXZ+fYhCsk1kDdqMVaeIcGej9ZExLyiCCh9zvM?=
 =?us-ascii?Q?492Qf2i4uWDlGPyVsdN2fNF4Z+KhzvLcTBxQdgfejn28fYTNedoBNN75rRPs?=
 =?us-ascii?Q?6I2BA0Z8oav7FyrC7mmF+yzuufB6dlBhHMWLrCYpW8dVxZrhd50dch6Nu/He?=
 =?us-ascii?Q?IoyTLpHTjgy10mH95qt5jqsJuhhhWjeDvAsZpAW1FieO5IQgcxD3SD7FelER?=
 =?us-ascii?Q?kgVvVWvdbeUv1H+SXAW8nrHayCNdCAqfzfiW4vAfRVvD518kXOBNMuJRV+5M?=
 =?us-ascii?Q?/0Sf6OJ5bCT8cSrVhVkwYpr7rDqHqBjOrwzI3KemZoKvWMMXRqF2dAd8pOVN?=
 =?us-ascii?Q?mgnIqXloMT9BRNBTJvnYnVXd8JzneFno42EmYpM9GocqBZHlJgEs9bEKcvcJ?=
 =?us-ascii?Q?eMRPqdFY1GW3Wg9QCIpuz2TUR/hLnZfarJSqpuHJ+a3mrb15ES6zBQNhrAi5?=
 =?us-ascii?Q?h1vD2rgex15jPW9vnjAq2Ykb1z5b+PHL+OE14MAGpaBrZ0kqcEVR/GDu1KRo?=
 =?us-ascii?Q?1fhGy2seC6azw0RvlJrCXjhp+mMhorOV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m4c3Z2dpTrYCe7tn4JRgKptGPVptpUUBG6m3ROBHbI54gx4Yw0I4u41G38Fb?=
 =?us-ascii?Q?6qAVBs/6ST7MG4ae9+TnBqObCXh8ru/uX57OwnoxMuOBIstxOsFYjQlzzS6L?=
 =?us-ascii?Q?UcuvWJ3rs+/f2ICNJlSMXxzKNQX9mFd1C2C5RWDXVBOLPsRZGoTtYsOtRZmv?=
 =?us-ascii?Q?E22xIpizqclR9WbU6xDkuFdm/+bJ5x1C0KnKGAVbFIhltccV6Y+tzef5wWXY?=
 =?us-ascii?Q?zxVshRPP+ZkRX4D5GbhRMB+xdmNoWa4wOiJ47nAf32kyjyeLShjKp94QFFl5?=
 =?us-ascii?Q?wLQaCvsoEXvCuV22J1k/2nUk5EVvdU2SLcLaWcKmHeOH9MSsrOpTNPiRD9G4?=
 =?us-ascii?Q?o3YloUKRo0+Y5IGYd7Gw76KUh7I5LXiDieC8p18GKF4L0WooileEO2QfuBzD?=
 =?us-ascii?Q?eu/D1nPYU8Br4h9g101Ixqt6n9+IGbY+eg23ryHm3myaJF++ef26+FsF5uKq?=
 =?us-ascii?Q?Rpy/KfvVz5na3lDDtu8hk4t0cT7e096nNvYA+HPNMRu/n3sz2b7LKt3uCC/V?=
 =?us-ascii?Q?G2chMuLBZZ4igN+4GpjaBjtF5ZcdrSj1JLiHfph5K2ceQPJHSr5KzwqGqRXB?=
 =?us-ascii?Q?KdeNXW7GJaaqTTk2+bHL0bGN7JQHjbQkNSPsfQQ6c9i+dTtSXfydYc9NH/Ri?=
 =?us-ascii?Q?2c1fd7nEkiRK6/bkJcwmMJUVIZp8apJmVWYaFqdj07XCKyVmFr3v5YiJ1NW0?=
 =?us-ascii?Q?H6u2qQpzJmxk1UrhubGFgoHXYNgNgp80ODC2JNEX+sj6FjyNXNPTGdgZ6IKz?=
 =?us-ascii?Q?UQwYo2ET2J+N8FdjBSuimOjf7EFQMFX1ZsZu6SnVgy582hVjvuv9qMVw675t?=
 =?us-ascii?Q?4z6/FPiAxKB0SGhp57AJUWDkbdV3QKqacROc0K5peJM3v4MiQjR/wXpCcT80?=
 =?us-ascii?Q?yG2JqihxMxUePfaMfklW3N1Ms675Ow5fSypE4g9H8FfyKzPSa4Qne/qDYAwN?=
 =?us-ascii?Q?qE2eRkVYAKhE74Hj1WYtKcU9TIqS5C4R3eSGaxhy191WYNkV/SrMaoktYucd?=
 =?us-ascii?Q?0PwM5CRAvQg+iFBF+Llk3pfAhJaRH4FDRssSoD0AAoc2xHFtmxfdcQ4j0z7V?=
 =?us-ascii?Q?w8ugeVlYYKS1dBOsH/wtkBgWZb6YmIuFq0lF96GK0X95jM1d1IhvVrGGwCaT?=
 =?us-ascii?Q?G5pRkbY4VvzDR98mFU8WFq3VUh8FE6MDNkC/yKM9zeqf1Kmp7X9ungjAphiw?=
 =?us-ascii?Q?fcptjgizBeW/Z8rHlZwyWhGogckOAVKUmEBqRhlMHszH0PdXDrb4MhcXMxfy?=
 =?us-ascii?Q?GeX73izr+FaFffOEuBnxJfzktwBYuwBEvWwUkN4voQfWNrcOpxtO4vI4EnfB?=
 =?us-ascii?Q?FKz2uxkObcXrx/LmU7eoOzov/lPUn9LWrzydnnA6h4fXQJ5qnaHU2u/M0O+G?=
 =?us-ascii?Q?a+I0UvzFlnlzHK0gmdfICpQs9ZH4iyxIjxvx4NRaQRedcE8zHiyYOJ2wsvlo?=
 =?us-ascii?Q?c1XjA/Vo/FtbPNWia5bgMXRPwK8+JO98sluRvXll3yaEmnlaFtEIatO6eDTF?=
 =?us-ascii?Q?iOeyo1rjr2BsfVa2ewSwfdSyBmH50lvX9kD3IRyMzyrQIv1M5fAERL6VcCcF?=
 =?us-ascii?Q?wFlMxBVMUkIkM9Veokte7JO2Ez9fNly3yMxE200TzxIBh0xo1q6pEHiKo3AQ?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f87deed6-3864-4405-604f-08de22a09ec6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:37:19.0055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ci3xS7yXHyXeyoMCVFpOD5qsthSOAQp1LoU/aK+voscjIzqPnt5HiAFf0O6ogwu1sx6AaA9N5R21DvPcaNyQPZX/VfgMz2/hBRKTmooAJsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
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

On Thu, Nov 13, 2025 at 10:55:48AM +0100, Burakov, Anatoly wrote:
> On 11/12/2025 6:04 PM, Bruce Richardson wrote:
> > On Wed, Nov 12, 2025 at 11:34:12AM +0000, Anatoly Burakov wrote:
> > > Current documentation for protocol agnostic filtering for ICE driver is a
> > > bit terse and relies on a lot of assumed knowledge. Document the feature
> > > better and make all of the assumptions explicit.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > > ---
> 
> 
> > > +
> > > +.. code-block:: console
> > > +
> > > +   python3 flow_parse.py --show -p "mac()/ipv4(src=1.1.1.1,dst=2.2.2.2)/udp()"
> > > +
> > > +Output:
> > > +
> > > +   {'flow': {'generic': {'pattern': {'spec': b'00000000000100000000000208004500001c000000000011000001010101020202020000000000080000',
> > > +   'mask': b'0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000'}}}}
> > > +
> > 
> > This looks like it should have a code-block tag on it too. Was that a
> > deliberate omission? If it should be there, I'll add it on apply.
> > 
> 
> <snip>
> 
> > > +
> > > +Spec (packet template):
> > > +  000000000001              Destination MAC (6 bytes)
> > > +  000000000002              Source MAC (6 bytes)
> > > +  0800                      EtherType = IPv4
> > > +  4500001c0000000000110000  IPv4 header, protocol = UDP
> > > +  01010101                  Source IP = 1.1.1.1
> > > +  02020202                  Destination IP = 2.2.2.2
> > > +  0000000000080000          UDP header
> > > +
> > 
> > The format of the output in the HTML here is not as above. Again, should
> > this have a code-block tag on it?
> 
> Yes on both, they were meant to be monospace formatted (not necessarily a
> *code* block but a monospaced block at least).
> 
> > 
Fixed on apply. Patch now on dpdk-next-net-intel.

Thanks,
/Bruce
