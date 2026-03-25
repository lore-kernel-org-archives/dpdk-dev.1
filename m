Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0790FEA83C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCF20402CE;
	Wed, 25 Mar 2026 10:42:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3E1CC4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774431766; x=1805967766;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=V3LCARdhI+Ow3JZIvAL8aUvg4WCGaiHBX4Elr6RQNBM=;
 b=aN3SGLWuYpeTEKs5qWsQjSM74VyENXfDZlpupDXoSv6zqqbpstQta52v
 rCRpKjOaNiqnU4IWkmpxOnmPOkV/3is+7xXdhH98kb5frIK9FGZGuXYNF
 SwvTCvnKT5V9Gfbac4gHXO9Pzi4IZitB+9DpkT9vj19loHCKMR6cknTLP
 ylxQVlu4k8vRPVtvai1phZCrHAcwv9YJuLFIkBKZ+NoOO+gFIWBqCTxsV
 FNJ76OdRK2OQzIrZ5dNp9nQ6X7zQQpTJdLshwv/DFsopCItoSdv8CqeNI
 gCKu9FTndVfmY/m11ZosacweA/tnyZvLHCduQa2FfVOnTEw3IZ8Neao3h w==;
X-CSE-ConnectionGUID: s+esmx4gSnaFC28tTWkjdA==
X-CSE-MsgGUID: PRug9gIkSa2xw41SfMJ69A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="93041449"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="93041449"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 02:42:45 -0700
X-CSE-ConnectionGUID: buczMmhGQuqsJmWOdjbdqw==
X-CSE-MsgGUID: P+WQKTMgQW+baKbn79xkkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="228692594"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 02:42:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 02:42:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 02:42:42 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 02:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEZsHIL1JuXcPpRjdiztQjSjDdqvF0yNr57mcgPq4flXYxvx0ihDZAPt7IsDISoI6XhS06mU1gSJOlnIgHfodW4S8Fq4y9vSaDEEZCpMsZs+xLXVeCWFopjC5gbTNCCudNdFWdxQupyeP0Qh1XAEkBtpMgEI49Ez7zUVOIw5JzySzS1V3m4BJRyTrYMhg9XM77RSHK1QDwyNM08eXrWdtkPsMXm7jk1duuLDmAq2Et/rAUchHVHRpDCBKD06mI3Lg6ffpefiogMeOSou24CKyPnyGIov2nBwzF7nxik/5mwszCutdCvYiwteSS9xgkO3zRVq0sVsFmxf/vDMdGFctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08lCCoid6D6k9Hv2hn2bremEYLRRFOYn3shf8pTUd0U=;
 b=RFOKuQMUR7RMN33sKeg9S2qTPLBzVVrt+yWgDD2zj7vBM4ErJf1Ge2eJakIas7eNfw5/riCY7X+A2Cr75ALFVP3THGRaJxqxyf0zyE8TPiPzM9eKPEi9cxfJub06Ola27AwUekx5JKB8voKd04Wpz9pfBWSJdHnCLr8GlCWQJIxo6tBRp8wgOqv5Fmr4YxrbW/meCQ730A+qdrHCLfebfFmTHwohz8eQBG6JUUpK9DCd9ka2ABKfBW2mTKHmVJAP3VCi/gdawxzXM9Muy7xg/GgYVrjAdTibksNTPBs+S+TNlXx5zYqqWPNfwY1zxzy3qaZRsBm0EHQapykDSE9CSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:42:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 09:42:39 +0000
Date: Wed, 25 Mar 2026 09:42:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>, "Reshma
 Pattan" <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <acOuCmNY5-sbidIb@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
 <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0299.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 075415e6-ac30-47bb-a3ed-08de8a52da5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info: d5iJz66xY05zlHpxTI9wDVqRJNNIGIOqhJOAVzdECUTisn80lM2wyrDiSg2nV0u3/ALsm1+lb5tP7XZxL/M4wVJU1sHDM9B79i47h0IGzhaKSABu+b3OSBJwEDdhhBXqCFpxh5k2922oi1O84+960R4ru2QDhGcLVsqcD0krpNyXJaXTQaWVyLce5pAviqYx1dKPsnCxxg8hKELypErK1erXES1yklbyIpYAgqOOLVsMPtOMGDNmrrI9hewTS6Wei6VWiIFvMUtNKy/9BUDKE/EG5JEMCuj++jLdxoNeKGtaF42u+B8CTKTnK92wEMfqjAqMOM/o4taEOG0Udd8Om28eQRC/BSL1w1lM/cEyt2LqIin7g9OqveVD1lVoiuQ0ueK8abMFF/FYuwLUsI6a4vxLy3gmmhv0MBrjYOBUT9FDlgMYVx/Plw3v6xmkof7RcCcirhfhYS1pQHhglnuiYtFt99iuaRQblChnRdpALmTwVd3tuAR3+fRDTmRSaaeJC3OXxGA/Tgl5v72SbDxWhOO0ur/gGN8O5AiiUdChFws6xUKOhvP+/N5E/5s7tylCLKQJfYsBhLJiAnONMvwkSyss3KhBrHoU8oDuu8fy2Ps4iq510A57/nl1tx06Y7uZyAQiifwru0VaWRLy/D99Hux1RImwuUqOQqcDZ6psrIRdWJb961+E4YUw6bo8eOW29+Ek2WMbkbh12UoTaO9se52ouWNHdAheV7xLf16OQ0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(7053199007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JSJtA1gNFVxrBKj4zS2S8AnJMIf279u3mCf8hF8dKjPgIj6SFvgG0j95hE?=
 =?iso-8859-1?Q?pFCTGdnVqunRmZ9luPQLjMmdW2RlcCpOVsDKgT8liUh8J9S6ij1RQju5es?=
 =?iso-8859-1?Q?baj4zGCDEngsjQeHNUbUMipJ5E4AKMLaJq1nmNUOmIvzwpIadYI42H9PhW?=
 =?iso-8859-1?Q?ioUxI3FBg0wcDfBYbYayllB3C95vlPnl/23ohzDJDpmt67fxYIsM1dVa0d?=
 =?iso-8859-1?Q?q9cpenPo1PvbD3970TiE51RXvBHbnsz1M4Nfj1eWCCkdbb6uCJ63lcCDbc?=
 =?iso-8859-1?Q?bq5Ye44r1YP8/7qPn4Ys8fwmCDglRHuM6FmqH7IJNkT0eRdPy1olz2+Xcm?=
 =?iso-8859-1?Q?SDJcw+qmtJzZWeY8kxdCsCA4bQ8twHQ9b7uVvOG6ZIH7XjUBFMX3b0yFUT?=
 =?iso-8859-1?Q?nrIAcC+L/R4ZHxYN+t9K5/qw0QuKvcArw0tdPn05Pnl/+KErSnZxEFeln6?=
 =?iso-8859-1?Q?kna7gnNOL5gVDGn43lYM5Vec9AC2ATe85BolGIDUTxvCEaUNY7THSlta7b?=
 =?iso-8859-1?Q?lHQjiHNsbQtkMViNk83CPL52HN67b1oOcsxIYUfpRQKYRcPuA5p4jsvYXr?=
 =?iso-8859-1?Q?NbpK5FzzJxob43r7kaQkfDBLhXQ1lrMod62aJjK6Ji3h1Z6O1Apv92feZV?=
 =?iso-8859-1?Q?ibjgqD/h+92uxPp4hl46WXG9PJbaz+ipeWJ1OgQwghY8h0ekiBHdsq9KL1?=
 =?iso-8859-1?Q?H1guiA+ruuEGKSFN+xLYSWQmQxqx/QfI3y+buqS8f42W1at17g27NHTfSo?=
 =?iso-8859-1?Q?R7J7sg5xnGqk67DtQfrvknC2HWBgAEKrCtloJMtQH+rrauIGBmaV7oa8BV?=
 =?iso-8859-1?Q?ejWh6lHjf5NUli98sC8LYa0i7RVXQFzHTi/MXEcqeC4FuRqE2UjbG0INvi?=
 =?iso-8859-1?Q?W/yvjgJ23pgWZnTBUZTqB11+aqOHUeHc2n90VwgpZLTNwNrUoeGYrk0uCh?=
 =?iso-8859-1?Q?F0OcJPSFgTZszICTpbAsmFWP2oUUe5Hv2L7FFTZDuY58jxtvOOYSN8ON8g?=
 =?iso-8859-1?Q?3T4TgfxxZBZexUpPGWhpIksYSMM/O6W2YcZkI/cUlNo9xCFz7RsbKthaRJ?=
 =?iso-8859-1?Q?Ewn+pld26zMm+4dgU91oex//tszV1pHwXodW/wVBWO7tGWw5pg7yfMGj4v?=
 =?iso-8859-1?Q?JCTsmsXX9tgarYVT7N1TFwNi1RaUEp9ilyiifXeDff8BZD8lUo1SotEXHh?=
 =?iso-8859-1?Q?CSk1QARw4nrm3pyE4H9u/zJ3XA11f0pJAYFYOzrDvwhsAHbIBw7vYf0Ttg?=
 =?iso-8859-1?Q?tQpiitZrwkpv5X82t3AgYWOE8SB6ELrbAMTjZhhljX8798MOfGIUIJhZV8?=
 =?iso-8859-1?Q?TrLKQVDe9+Azp1D8DlDlNEuwZ8JOGYWRKs3NwkA14g1qYyLHrPoS+WMV+H?=
 =?iso-8859-1?Q?aKictQOQC9YTmDBVSb6fVPcxAGjTIZYArq1PN/08Yb/95HlNEsgbbPocTO?=
 =?iso-8859-1?Q?EXZghwnFz80dKN3HQqcy52pzve4q7BFBft4/emtjCBNTSKY7QDNLvu7Chu?=
 =?iso-8859-1?Q?jPJQmKE/KaptayidC0X29JPQF2EP1RrbeDyXODrvCNMkD+fLJUPKiFQoMb?=
 =?iso-8859-1?Q?2c8Pe5iPutgwav4lUAPGZwr8NBokIWH9KkanNGtsaCOgzhUR3fneHNi0MG?=
 =?iso-8859-1?Q?c2KGKcbFQJISL9QjktBIX07ctWAjjIZ2xajQpO8XTWpJfNPWbuMR4q1GD0?=
 =?iso-8859-1?Q?bjMNRgjxqj9L6CWxpWuTUxjoLCDRD0gfS049fNNovYWMkJYo4jLLAubaJD?=
 =?iso-8859-1?Q?II8Qybd1Wf1gR7+1ElI9qIoZJ5FDO/O3Vdi2DF60hbzs9wfwwRgtaEuaBo?=
 =?iso-8859-1?Q?dg8hP8ONjzyLSyZ3p12kKyewaWsdxmI=3D?=
X-Exchange-RoutingPolicyChecked: S69+nFDQYGPBHKxRB9eIuzA0uMaNJ0bufEhFLX3HWAWHXcv677PiZoK7EmPaI/dNRyj5eqfrhRGT6EtPVKzCUtb4KymLyS4wexoMquM/CTNejbh1JnttFW3o06UWLT4OLljDO20MOuX1Hq9B7JI8bTFYgBmiG3OWTuED7QLkyT19fyCqTBkqZGicTPoz4Y5oXjG4oX7pen2ZKZqusoTF9O5pBsME/TAiqNGEODYdldw97zpjFBVFfH+FS2h+XYdSvb3CMkxK4I9NhqhTwFULL5Pvw0oKedtobUSiMTQidEzmFSDlxJ1bqHkkXOxorFkOiWSiG2iy67utSsOFXv51SQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 075415e6-ac30-47bb-a3ed-08de8a52da5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:42:39.1064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/pr3QeKKEMttcg2aYUX07ed1HRe6JHR/ftEJlCx3WoxwvWuWZLwZpZ1I8DAoOw5C6ZkldWPOrYQDOL1KUO3iC9wo5/DoMxp7SlRQuxb2CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
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

On Wed, Mar 25, 2026 at 10:36:56AM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 25 March 2026 10.13
> > 
> > On Wed, Mar 25, 2026 at 08:41:39AM +0100, Morten Brørup wrote:
> > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > Sent: Tuesday, 24 March 2026 18.12
> > > >
> > > > On Mon, 16 Mar 2026 16:55:29 +0100
> > > > Morten Brørup <mb@smartsharesystems.com> wrote:
> > > >
> > > > > >
> > > > > > This is an example of something I previously flagged. Like with
> > > > real
> > > > > > hardware, I think the PMD should be inserting the VLAN tag into
> > the
> > > > > > packet
> > > > > > as part of the Tx function, not the prepare function.
> > > > >
> > > > > Agree with Bruce on this.
> > > > > For simple stuff like VLAN offload, applications should not be
> > > > required to call tx_prep first.
> > > > >
> > > > > However, the Tx function is supposed to not modify the packets;
> > > > relevant when refcnt > 1.
> > > > >
> > > > > Instead of modifying the packet data to insert/strip the VLAN
> > tag,
> > > > > perhaps the driver can split the write/read operation into
> > multiple
> > > > write/read operations:
> > > > > 1. the Ethernet header
> > > > > 2. the VLAN tag
> > > > > 3. the remaining packet data
> > > > >
> > > > > I haven't really followed the pcap driver, so maybe my suggestion
> > > > doesn't make sense.
> > > >
> > > > The prepare code and VLAN was copied from virtio.
> > > > I assume virtio is widely used already.
> > >
> > > OK, that makes it harder to object to.
> > >
> > 
> > Yes, but I also believe that the topic was not previously discussed and
> > that the virtio driver may be wrong in how it behaves.
> > 
> > I still think, for consistency with HW drivers, SW drivers should do
> > the
> > tagging in the Tx function.
> 
> +1
> 
> > 
> > I also think that we should provide a DPDK-lib level helper function
> > (be it in
> > ethdev or elsewhere) for doing this sort of thing for all drivers. That
> > way
> > we can put in the necessary copying of packets with refcnt > 1 and have
> > it
> > apply globally.
> 
> If an application clones packets instead of copying them, it is probably for performance reasons.
> If the drivers start copying those clones, it may defeat the performance purpose.
> 
> <brainstorming>
> Maybe segmentation can be used instead of copying the full packet:
> Make the "copy" packet of two (or more) segments, where the header is copied into a new mbuf (where the VLAN tag is added), and the remaining part of the packet uses an indirect mbuf referring to the "original" packet at the offset after the header.
> </brainstorming>
> 
> Furthermore...
> If drivers start copying packets in the Tx function, the Tx queue should have its own mbuf pool to allocate these mbufs from.
> Drivers should not steal mbufs from the pools used by the packets being transmitted.
> E.g. if a segmented packet has a small mbuf for the first few bytes, followed by a large mbuf (from another pool) for the remaining bytes.
> Or if the "original" mbuf comes from a mempool allocated on different CPU socket, the "copy" would too.
> 
Yes, agree on using a chain of buffers for Tx in this case. Not bothered
much either way about the separate mempool.

/Bruce
