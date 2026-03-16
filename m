Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F533F53D6E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 16:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EAF94065C;
	Mon, 16 Mar 2026 17:05:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C4D8F400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 17:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773677146; x=1805213146;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nvUZBJe5KzdnFuRJaY5pPhuURjUySkjyRvlLsc0JxgA=;
 b=gePRk7seawL7T1bcVZaOgG2Rvbh4nwAbjEkkAvZEwLvUSab8XxaEG//k
 VpZ3jVrSe87ocrq9c42Az9beGiw2Lxb4C2dvg+xvPYOSD9O1Arwj1+U+T
 V2x4/h70FMuT6/38DZk3abRVhajQBggUcBVje9XZgi043tSsKTQ/4i+QM
 R3Qw5qAFgS8mm7hbA9cnVXxnYv/7HQPXnPYil1knwFeDFKvcfNRy99AAB
 ia8ob3XLVyWzLJEWLfNSnJ3aC5Ip/UbyCkPAbvmbQJwFVjd33JvuVWmuZ
 rIgkOgs/4hkI+a7ii2XSKBg3CUSR9KyqgSYXwq+YMyhD0u1X/6lt1x6lO Q==;
X-CSE-ConnectionGUID: pY/hSx35Q2Ct2RAwBsU6DA==
X-CSE-MsgGUID: 8a9Ir+hkS2uK535cg37FPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="92081025"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="92081025"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:05:45 -0700
X-CSE-ConnectionGUID: uXpL9BWRRt+6VWkZRQ2EAg==
X-CSE-MsgGUID: 83z31NmiTZKJg7kg9ZdLMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226956616"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:05:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 09:05:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 09:05:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 09:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+7RkWD7/LFTuwXVxEvdufB0E5lYHSIvmCRQCP4g4TYfCSrJPxwDHXPkn/9pWyyfWRI2vTr19s/erymv86XFPjfL2yhkEaDvIKRi92T4I43iE3eL47Yg7Cu4bXu3tKrZCz2F+vveYE/leVXyFiCK8e9Snx59wWgqSQq5oMwQfPCr01ExZCUbyKTZgLOt770Tswz21I+G7RrcYxpN0rIlTRDJoBzaRdOv6mkeqxlT5+JlpYDKKVNV4qZ2+UTr9L/9j6Nuv/HrSYaUeeVsoMJqgzOpzYRY88B3qT+8U92KI59syIAcQE8nFycfO3rxk1BGiECZIZbxeQoDaXpond3elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFTYT+y+Fr3VDm31yKwH+MZWwTjlJZJvxKpwnezsE5Q=;
 b=YEyVKqM3KogfST1CAiAP/eG54qSUY2TI8h9X8pW93qLrsJBM0+mBR9XcDmKnl8OhJsvwf3uBZpA+11rZHNxJIm+JxNw6qxI7Xd0SUR4O1vGsnLad3uD4a9ASYFFPdSktU9NvGZNGXW2GzTjSIkbzfudZ88enB+MtXDwGG8SIyh9rA+oLnH1BNNTYMHYufx/pAYKD9+fnAHgACIgx7voDKKhW4ZzJz9xex3d7IBIa1ks4ZM2uPPL383apcMRmmC+1UHKGGj2Z0WJ+78+opB/LOBrjR9RvvMMTp2DVdHI5skl21ygVQubulPqGB1mozgfsX+5KVRmwW5oXF9xxYhsM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 16 Mar
 2026 16:05:39 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 16:05:39 +0000
Date: Mon, 16 Mar 2026 16:05:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>, "Reshma
 Pattan" <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <abgqTqbrJp-jdL5U@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0159.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::14) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH0PR11MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 56074191-c774-41a7-01dd-08de8375de29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: GgSqYHk2Ay0TMbU1okp/uVTD2pHra5r2ix+CCpZkG/vMYXVpYb5iXKNSmxKrcWcVCzwD7c+J6x/50Vi3s1WlcU+8HIkY1P6uY9U/ibwDn847oNrnQDRbxJ4ODK96xHUfQAKyTWHF66k0MuAOnSz3VkIv0YYyWf9bm0H84EolGHBzHMxjjaj8iSzXNpXmcCNyzCABRHH9MbANZthqPffEPtY8xyjjaLbAp18C7fqBvvArFSqcMAqvoPnTix2FjPNXd1myw1mi5pb1ggpgDRnJW6UD2TkiXuEpYiLV3oYm4d3llk/55Kzx7reO/K3/LPrjW1a9nj3geQKcpcngPjmiIb6n8e6JHqQESES+KtIGUQ3xNg+JLQ7K/mnv6H7ioP+BFfTgsIFYU15jh+gMMC54L0eea5K+txO8Gi6uYJigg/18oNdA/P/HbAo+9/3W13Esub8riSzVpa8gIfM+YftdsWXgg2DPvb4DG8NYviZNK3AnG9SemutRSsp8PFSR7p0kAhQjTJ6f3AaUV/WjHfLapUnJoGHUXb5jZqRezekVqqM9fTuye2rEQFi9W2PqzIRjaU//o/YzHIDkfmLIWufTpnXGbwlLUDqQCk6nbEbfEK4DSI8nfuvvmQxUNtvsygZixsrX8l0+mc12Wi1Ho3prDlmfL9drEyulnxKBi5xRQV7NBemM59AbhAzYv1H+IbJ9WchhVuKdc8Q3lesv8okC1dhaYXkb76wHNOHRjKffMIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aWcY1RaLuMjfUgbMdcnz9MW97qqJH/Y8nOH87xbq1Jk0Dbv0uw6DtrpYq+?=
 =?iso-8859-1?Q?wxWtNl/yuVo0CY+ZFBdW+5smz7C8djhs1DCpds7HpmSorOqUHT4VyYhFLl?=
 =?iso-8859-1?Q?FODoQaM4Bf9PkKOKu4dYzFG2MmK461GjnxNM3ny136AYHrtovWKI1Sll/9?=
 =?iso-8859-1?Q?HVM4fIdrzl5K+B4SP5wAM5nKE2ogU09Jz5RubzdMRTkAGCmlux2L99ux0/?=
 =?iso-8859-1?Q?AhmoSZlxdeqoqSEyj3n2G+Sdlph1mwHzdXwjcxfYnNsD7CRz3i1wwdxXxf?=
 =?iso-8859-1?Q?RzAmTF0Sr4shhDYEY4XccqmTbyt5TFLQT5b7SdYIr27lRKMAhOFAqs1HIK?=
 =?iso-8859-1?Q?32RPsBJk3wHOIZCHuTHjX2z4kbPyptMijWbfv7MjIJw0ksEffsNeG+ybXN?=
 =?iso-8859-1?Q?L9FjRNZL+44yrFs7Rf4KBikLqD3LQfKr5+HJlIafx4EzfEP9Zumuv8i0Fg?=
 =?iso-8859-1?Q?njG6a7/kzXD4urpaiqgy990ECaVeU0wx6ZnkpIIuDSgdSK3JfAa3umT+LL?=
 =?iso-8859-1?Q?7ZcedOOVwdbZiVuuNKkFxVgI6XezE3neTV66UpsDHYHDVMfHxfyQRYBQsK?=
 =?iso-8859-1?Q?eHGcYcIYyNxxbXne8g6msb/d++Rzb2+WSd2wpWIQXatbO2cPnjAUUmgTP9?=
 =?iso-8859-1?Q?jzhC2+gpZjdHVHAJ+/yzlFxPUzhmkPeOTuJLw1O/NkTqn5HsytPL/+8Dl9?=
 =?iso-8859-1?Q?CYh5VVQJ9gmJg3BNrsxtQMqGTs/903tE2Q971yIfRQbgr3bpdSjnyprPJt?=
 =?iso-8859-1?Q?+Ib6WVX4LepN9ftIir3nr+WNnof7Y34kgpdgX5Ss5eyPQJmTSrpJrbhN3V?=
 =?iso-8859-1?Q?tmnca+53yAONUuzRSwdqAmqRoCWcSYw4zWh3r3bRcXnJGH5cuWXWJGZEp4?=
 =?iso-8859-1?Q?mukl/ouXhqEDA+mnMIl7YcIjxhXeuk0drO63j5ZAIUwN8GBP5dlwla1vw7?=
 =?iso-8859-1?Q?wCOUFJMd7skPb3hP2PXGmJlq3jSKQ3XqF55x1qA7n+TA5iTfuNVZLlpyPd?=
 =?iso-8859-1?Q?SMkR3YoVS+71JKiDhaebmiF8ESmApTreM9L6P4LrkKinoOFmHMafsQzqUE?=
 =?iso-8859-1?Q?G393Y1UuVL+GAzS3/Ps8lGTtbF5wlpfMxxbg07pgv5PxAiGMwF0xPqWUA8?=
 =?iso-8859-1?Q?/FXsu3Km32/bbatndoJAqiayM7nFSsuExCRuTk/+MglFMIN2oQUGnViMuc?=
 =?iso-8859-1?Q?zXpWeHQCZrabctWsmuBhheg0Z707RR/z24SNdCJVOEqxcdaYPOObLwA+UX?=
 =?iso-8859-1?Q?90woMmxdJISVTJfonuLzTnMr384+AHJ1X6pNzQQvyAeW1djcwnaYIl7GNq?=
 =?iso-8859-1?Q?0yOxVQL/RlSwef0CX0qeBxk72BbBbKJHpCrwSMFH/YlyZa15XmSPBNp0bi?=
 =?iso-8859-1?Q?6cF8Bt5nrDZlhoPdWaAx5rvDlLcfmPQH5iG2aM5n4iRKQdZA+KbRIO1OJz?=
 =?iso-8859-1?Q?lkDTuL4wkNjMXTJAJ0DYW02GmFKTJXqQWhjR5kERZ/zGabq8cDld9C0O+k?=
 =?iso-8859-1?Q?uJA+35H8Dzi2EMJSJne+Z6fQ1ADCrgL4AYOuYTd6pqR4tm31wqFzEgKD7E?=
 =?iso-8859-1?Q?7UXq1R3kBZnIzSf00kOwUO5h5q/xKKuabaLMzZzsBIDH/LznHnyozYYWuA?=
 =?iso-8859-1?Q?TNLuu/VnL/ai5+kPRBEO8Ln8ej+GWxt5Bmv/tAjvVLZcpfBGmhMzrfh/0L?=
 =?iso-8859-1?Q?gbo9qs1deacmiaYEyEsrAKzaloeCSO2uRZT6tePFtFeMRpJ9h/WpOh9H8E?=
 =?iso-8859-1?Q?and8uh4g2noaXlWfFYcmIrKywQNI2XbS17z6x6zVgiZPOtr5Z0a5vddrOH?=
 =?iso-8859-1?Q?II6xisJtDf2RrTJ14H+F70gJmqJwdSM=3D?=
X-Exchange-RoutingPolicyChecked: s0Dy9pcNQzZ8gUS6+JdhdB+zBcxHT/AAwnL3a2E95wne9JGce6ioWFRrmpKuP7VroHSU09wqIVJy6qT5eYz2A2Q+tqqxbK7Frsh21U1ndr4zjBgs9XwbCLDkZkKuwiqrfLAOArTKvnUsZTFSwKcQ7PYxoIO7NTRBEU4668GFtYUE+TO3ovceHKZ5e7/UERTKVo6+o0eVqpxM9DBvQ2B88hV3JBXtiHF1apZCkrp5Y4wAJMclTNJpnONxBthlBeqbDBl4N2LnJBJ6CKmX6FtHj5YF5EkrlctbGv/3LnFwDxdUBoTnCwz0F0R9mR47uK+WiSYQMv+7dhL8PD4d+lkvYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 56074191-c774-41a7-01dd-08de8375de29
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 16:05:39.6613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moU02/MVBdemsEe1nDcG4FbxieUxScfpCIZwuLiH4OAhZWN5Xz1XqNLjtuT7zEN9EaYPworTttX0Beo4sGOrHKB58bQkCFaHiQpIomAe8sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
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

On Mon, Mar 16, 2026 at 04:55:29PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 16 March 2026 16.34
> > 
> > On Tue, Mar 10, 2026 at 09:10:03AM -0700, Stephen Hemminger wrote:
> > > When the source port has VLAN strip enabled, captured packets have
> > > the VLAN tag in mbuf metadata (vlan_tci) but not in the packet data.
> > > Similarly, TX captures with pending VLAN insert have the tag only
> > > in metadata. The resulting pcap files contain untagged packets.
> > >
> > > Convert RX_VLAN_STRIPPED metadata to TX_VLAN offload requests on
> > > dequeued mbufs and call rte_eth_tx_prepare() before
> > rte_eth_tx_burst()
> > > so the pcap vdev inserts the tag into the packet data.
> > >
> > 
> > This is an example of something I previously flagged. Like with real
> > hardware, I think the PMD should be inserting the VLAN tag into the
> > packet
> > as part of the Tx function, not the prepare function.
> 
> Agree with Bruce on this.
> For simple stuff like VLAN offload, applications should not be required to call tx_prep first.
> 
> However, the Tx function is supposed to not modify the packets; relevant when refcnt > 1.
> 

Reading the doc on tx_burst it can modify the packets (obviously enough) if
refcnt is one, so only the edge case of refcnt > 1 needs to be worried
about. The other thing worth noting is that there is already an exception
for bonding driver - if we need to, I suppose we can look to make a more
general exception for a set of virtual drivers under specific
circumstances. I'd be ok with documenting that "the following drivers modify
packets for VLAN insertion..." or something like that.

> Instead of modifying the packet data to insert/strip the VLAN tag,
> perhaps the driver can split the write/read operation into multiple write/read operations:
> 1. the Ethernet header
> 2. the VLAN tag
> 3. the remaining packet data
> 
> I haven't really followed the pcap driver, so maybe my suggestion doesn't make sense.
> 
> 
> Let's say an application adds 1 to the mbufs' refcnt before each Tx, so the mbufs still exist after Tx.
> Then, the application captures/mirrors the packets consumed by the driver, and logs/drops the packets the driver was unable to consume.
> If the capture/mirror is filtering by VLAN ID, modifying the packets in the driver's Tx function is bad.
>
Worth investigating. We already have copies for scattered packets, I think,
so doing some copying for VLAN insertion if refcnt > 1 wouldn't be the end
of the world.

/Bruce 
