Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DEBC79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 13:40:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D711F40689;
	Mon,  7 Sep 2026 15:40:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 90DF94064C
 for <dev@dpdk.org>; Mon,  7 Sep 2026 15:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788788441; x=1820324441;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QKvHohV0YbpDH2lAHysNW7cUWZzLtO1vL7/5DfV6WME=;
 b=lFTWSxqCPKQEOuCuvxOBBGV/bKwWx4aHMG2WH2PiP4QhSU23QtF2d2o2
 KXrReRrfuTJhZBv6/Kjh/dF+XvvYEtuGWbCbXVDBml/81iI1FoOAHjwpf
 k/rRaY6UTIwgAkhFzSx+8rU8Js0T0h+d+LRu0aoxs2GZAdLvQDkIfeHxB
 rmLZisIIi84+2L5EYybRxn4BC5r/mhXY2V7yIaOm9ELJCsYkTUtcGU0vi
 irpF96uAwWj6C1zLbJ/92VELhECOF2UgORBy/6IQqYTGMj2P1SEegJcS5
 U5SB5nIJebtiauABOyIffyueSP88DUvQy5+GIol2sJcmAftmmBwYfJzrH Q==;
X-CSE-ConnectionGUID: sOra0N7qQo6XN1mzJnNOBg==
X-CSE-MsgGUID: KewDVotBTwi4JBTIMr8A0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="88952924"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="88952924"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 06:40:40 -0700
X-CSE-ConnectionGUID: 1rttGDiCSe+kfCTJMgWOww==
X-CSE-MsgGUID: Hg2qLquDTweyz2AABOssww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="295596480"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 06:40:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 06:40:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 06:40:38 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 06:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP/AsyYU94Qic4Ciqj37+38lydw8W2kSmUyHBpBoEyfxwNFsVmU7mZHzq7wJBo5eQniubLmk1EBe3NGD3SIxlsAN+SYFLXRjrE0u2u1VqhFIMosDOucSVUKXRxklHoWyYPJMRg4xNazc4rXhEDa5q9f7QKmTepPhsPcdBf0rEcXkQPCpGbjeCIwRDgJR2+zCj9JksHRRnNusInmWdPjr+628ah649fuZswUhNnn4JpfIeyev/8SMwe0ovW8hxQAj/nBpObP6QmIn6hVC0oH+5VGMdigADuD0QmnvimtrTX84ic5OBbCbxkTGSSA8Vboc9gABUuSq4y7EE4TtCoQ0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6XvVEAz4xVu7mU4Rz2fjaRp89Zn17Qx9X64MapclF4=;
 b=Rzs25j1Uim9hifPNyBwgYbeznfTJIsT3lbzcEV1CaFIQN3XSVlWIRdRfsoESNe0DAMgQWM7SQcOLrceI8fT3fdDZaYrmYlUwMe7NLLl/AaXnnnd8P/TrmJokFaLNrMvxas4DGO/cvxTNn5OPe1/u9fglnnFNNw58NGq8Z8qMd01I3YYv3NMniYm3fv44BtuXsNWUvW1/UTwJP+3y45ECRQWKPb/z6eoWTW898RuEyP5OoViTjUqDKHzvoYDkQCeiOhhDJklDOGzu63FlX3U4Ya2yFgR01aYoFIpzw+GXES5Nl8CPkqnv62B7CG1IPLudFFFQh6VmpmhS0+LV8RIJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 13:40:33 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 13:40:33 +0000
Date: Mon, 7 Sep 2026 14:40:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 1/2] net/i40e: fix MAC address removal
Message-ID: <ap6-zDJs_tJHR6Ci@bricha3-mobl1.ger.corp.intel.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
 <20260907111724.3043887-1-david.marchand@redhat.com>
 <ap60ylEX-xAuROSN@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8x3QpkJxa3_crRLLHHKHscdceadDX2GEqEyN3sHU2DEYQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8x3QpkJxa3_crRLLHHKHscdceadDX2GEqEyN3sHU2DEYQ@mail.gmail.com>
X-ClientProxiedBy: DB8PR04CA0017.eurprd04.prod.outlook.com
 (2603:10a6:10:110::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3eab59-83c7-443a-8a98-08df0ce59713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: uO4njkEtkuB1zClAkfVWDQjkMkRlNiRAVqdXLp0I4Vo5viFCBo7Vq0ytuprhnWiZOoHwlS4doZE+ohKiiHgLjTV4+49wwOIWq29jda8cyOuCt2LXm9CxDzxsOE8SFqqgZeApElTtAjSWZdcG+KRGDOYbzKMo1LVMnD4GdNG6gHoHWFV6OHxNHwIaGkBoAogtsLUB71ejsWmJ+BvboNCCIcmIoW8vCli8mnPeoGuwWVJOHUpVmEYTnHe1gox9fTkdEWJNflbq+0c8xbKD8KbHpk8NLtgZLkne5yN6XsHdFHQJEZaJEHgZCOpgwWGxltgAbTU7/3Kd3t/vq1lz1z8+ny3GLme/IsdZ61+f49fAIRKysJ4cxozNKeDkAfjsvtoJFiZHG5TSNM+gcEXwTLTL54g/E/FGa/vZApYck8gvz4+cR0kOQd6qJIpIVGGOEVIrELcxL7UwYQAQXyASi/KVk0MET1L2cQt9Ha3E+j5bensexivu8hOfgL3UWKFUeA1q1rZEd+EjmlGix/VEIygyzf2s5I35ykHaPxtUZsy0ETm9rhNkpNGjeVvGAV50+/9zHHCEOMUUnaKsRjFZzcypnEJVYP+7ySBCJEf5n+EIBBgg+oSKqGpdjt/zZ92YOL3H/EgT+HPvYmbnE2/yFFhtMooZ/UtDUI9ySSEzkJz0NR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZJlnKj+3enloU/70+yv2s7gu0x0gd7xc1lWL8cLiAwFPz58y4JOULCR6RZl?=
 =?us-ascii?Q?eFpi0x2zkIptJafYkC4fPm6kP/VM13I5Zowyu2+55D/cOP0aUpGKbsbrY0jO?=
 =?us-ascii?Q?lYdZ11tNzldaPmIF4e5fkVwINeYtpz3j6bb/bH+EwrVPJiPu0MsN0A5GleM/?=
 =?us-ascii?Q?dkWf/fTvEdkuB8Ao4ZnjYiLyz76WKciRBoxJC6YhrjSteYiB95FrLt9CseEY?=
 =?us-ascii?Q?q3vclYyTgSdAS8ZZb3bMuWnEGNS+6icxXqBIzwWMkJjkjXlPQAw7zb80Jf+j?=
 =?us-ascii?Q?PPlqG53bRRR49S0C1AsPylRasJt0seepIRp3CjxwpL/gJb6TKEM7bMuLOeng?=
 =?us-ascii?Q?Fj4+TZEQ5Z2vxtZmJVRr0pIU7eg/40/nQNaF3uVymiJgZQF6FkKiSfRTBr/C?=
 =?us-ascii?Q?ot4qXBTevrzSWI0Dwnee/3gPHqok8BHal/+N5L8l/gIzI/dlkYPLbRnwq/Zn?=
 =?us-ascii?Q?LwVF63xUSgmMgIIf3OGFdpyQbY5Qpf0TXRebJtWDWfS4RKg3VR1sOzvgsOVb?=
 =?us-ascii?Q?L+qj0pCwODqJ8JQVDIthZkpTJwuMDFF0wSwA6Odd8M4NeXgitr3VLdrl46ws?=
 =?us-ascii?Q?wCXUTDypjfAioYEYwuAkxx8rTfEe8w3EjBwNJ/5JNsDIpkkI9yh7gFGJQsVC?=
 =?us-ascii?Q?MDPgr0x8zYwSjMwA4kytmEHwN5rsPPenZWZXXB/rQkf5qkZdxXw0J7thdGvw?=
 =?us-ascii?Q?qRgVGf+CzulGx6NCydxgCXqY/b8gx+xkVR26BTDFjZRtS0nEnB6fRYtXBQXK?=
 =?us-ascii?Q?CJuPR3JcZAZbRIXcfbu2os9Yg0R3bWanu0TQ6hbwfRsoFOzYLTgWvmokAqJ9?=
 =?us-ascii?Q?EVLM4ZRxzGPJ1XidSMsTdDkBPNCzZiIrTR+0CrQ0bF3eml3aoCkniMd3YbBB?=
 =?us-ascii?Q?uu34tYOKA4HxCFGVqkBIND14wQPV1YPQ8gWVrYXbiBXjeVXxt2KgEHBhb+FG?=
 =?us-ascii?Q?v09qOxBnujdq+83FBW6oY0EGrhMe7ov5Lsfnft81mNl75A+LEDhwynKrlWGJ?=
 =?us-ascii?Q?wfmaCk/TubWDXTS0loHV4JxXAJmKsmJU/ou9aYcjdYPkYH/yWNPeJG09DPVl?=
 =?us-ascii?Q?gD6IAWAKo7ACp+MZTlupVWNil2NwzcgwbPqlpft23N9evXTWe8q0LWwGscp8?=
 =?us-ascii?Q?i2wbruIaCWnkmkurCqcRGzGrfujEmb2NNcgSPguKUMZOSz/5fDjawXbuHRhh?=
 =?us-ascii?Q?3pYQECywZXDT4fdfYQoCON/79QC+hI1eoWXok2XUGwfJYt0b0dJi8grifJUQ?=
 =?us-ascii?Q?3WhfSyb6ML/hH7LZ6DNH72H/YLRI/hZHD8lapQMkadH/Ba33aUbvXmlwxKNy?=
 =?us-ascii?Q?fc6yHcaT182+Tb8d2nxbfy4Sva+2v2eWauxL6xDLK0AZbgBv+UVyp3w56mx8?=
 =?us-ascii?Q?pph/tTJ2i3QSMnuk3Wrjr5kvI1hfnZs59oit7Zorre3aXpRQKtISmJDlLDq3?=
 =?us-ascii?Q?SahT7Ud0n0zZ+YvdofNK+kR9GNqE9I4gHkF8Qi0gH1wW4+UBMIDY25vFbl+Y?=
 =?us-ascii?Q?r/ccS52zBBGpIM3Dpxqz7m6Bjwukm6Keusj+1jzYZxF6DysBkYQxNUDuTddN?=
 =?us-ascii?Q?UbPJHHnHQmtTK7NIRZMlM62a+OT0i2+cAF98JWxSp8noaMqmYIP7dICvSl3J?=
 =?us-ascii?Q?Z/9tyePHNHOHs7/pZWgSkmcdADKjGh25XmNoPv10A8gjQM2xcUCcMgeR6WgG?=
 =?us-ascii?Q?lLb41NIXPv9rAcuQVnR+NgntU6BPF/olaoGBy6AlgKCbxSJLSK+Mmhf+8rEI?=
 =?us-ascii?Q?NGsruw5zOxhR4eR1/Ev9VYP6FygQxxA=3D?=
X-Exchange-RoutingPolicyChecked: M28xADaf80Fvcvpz6JuZBR/mOeyvPFGVuJoh8uU2KhL3T0u4u0o4VpNI9vu+6926WkgSmwBLQJ5SbkAFGJ5PpflItnVVeM8Vx7UggsCx1+n3U6ILs/PHAtubhFKAUrhVxLGpUR8EPhdG5tlwQdm/dkB+/XKuZqgSYsc3AwHtYcD/cON1AGHsJ8xZ0yryH4oBPpYyTjlELoUfVfknPYIIzr6KE0ly8xhk7Pi8lrLj2dI0kT7tOSk3HjrkHhBiHrRowEKaUDHpaYs+ndJtTFw92Kc7eXwD6Mi239Cxa1/ioHTMsjMroJZRCnCMiSN+yyxVghGpMWPa00XuK5xQckZjjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3eab59-83c7-443a-8a98-08df0ce59713
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 13:40:33.3572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7TlYUvGhUYRHPhqSXPhZWqEz0p4+FESgn+ZEA/K0kRGDVBITQx9VmIwI16cqHO5gV4u6kPfZ5tt7UgqrbaakKM15OsfhnaAdBSH0pI3MVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
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

On Mon, Sep 07, 2026 at 03:21:27PM +0200, David Marchand wrote:
> On Mon, 7 Sept 2026 at 14:57, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Mon, Sep 07, 2026 at 01:17:23PM +0200, David Marchand wrote:
> > > MAC addresses removal was tied with VMDq pools even when not used.
> > > So if VMDq is not enabled, no address would be ever removed.
> > >
> > > Fixes: 9de506a6c781 ("ethdev: skip VMDq pools unless configured")
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > > I could not test the change as my setups are KO atm.
> > >
> > > Probably worth squashing in 9de506a6c781 before pulling to main
> > >
> > > Changes since v1:
> > > - fixed compilation,
> > >
> > > ---
> > >  drivers/net/intel/i40e/i40e_ethdev.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> > > index b6b2d291ee..3c01354c39 100644
> > > --- a/drivers/net/intel/i40e/i40e_ethdev.c
> > > +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> > > @@ -4509,11 +4509,16 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
> > >       struct rte_ether_addr *macaddr;
> > >       int ret;
> > >       uint32_t i;
> > > +     bool vmdq;
> > >       uint64_t pool_sel;
> > >
> > >       macaddr = &(data->mac_addrs[index]);
> > >
> > > -     pool_sel = dev->data->mac_pool_sel[index];
> > > +     vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
> > > +     if (!vmdq)
> > > +             pool_sel = 1;
> > > +     else
> > > +             pool_sel = dev->data->mac_pool_sel[index];
> > >
> > The explanation makes sense, but do we really need the new temporary
> > variable, rather than just checking the flag directly in the "if"?
> >
> > Also, the rest of the code in this function, and the add function about it,
> > uses "pf->flags & I40E_FLAG_VMDQ" as a check for vmdq support. Is there a
> > reason we can't use that flag also here, rather than checking the rx
> > mq_mode flags?
> 
> No, I just did not notice this internal flag and I simply used the
> ethdev level config.
> 
> What do you think of:
> 
> $ git diff next-net/for-main -- drivers/net/intel/i40e
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c
> b/drivers/net/intel/i40e/i40e_ethdev.c
> index b6b2d291ee..0d914d86ea 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -4513,6 +4513,12 @@ i40e_macaddr_remove(struct rte_eth_dev *dev,
> uint32_t index)
> 
>         macaddr = &(data->mac_addrs[index]);
> 
> +       if (!(pf->flags & I40E_FLAG_VMDQ)) {
> +               if (i40e_vsi_delete_mac(pf->main_vsi, macaddr) != 0)
> +                       PMD_DRV_LOG(ERR, "Failed to remove MACVLAN filter");
> +               return;
> +       }
> +
>         pool_sel = dev->data->mac_pool_sel[index];
> 
>         for (i = 0; i < sizeof(pool_sel) * CHAR_BIT; i++) {
> @@ -4521,8 +4527,7 @@ i40e_macaddr_remove(struct rte_eth_dev *dev,
> uint32_t index)
>                                 vsi = pf->main_vsi;
>                         else {
>                                 /* No VMDQ pool enabled or configured */
> -                               if (!(pf->flags & I40E_FLAG_VMDQ) ||
> -                                       (i > pf->nb_cfg_vmdq_vsi)) {
> +                               if (i > pf->nb_cfg_vmdq_vsi) {
>                                         PMD_DRV_LOG(ERR,
>                                                 "No VMDQ pool
> enabled/configured");
>                                         return;
> 
> 
That looks simpler. Thanks.

/Bruce
