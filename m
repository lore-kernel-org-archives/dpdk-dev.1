Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8593CD65C49
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 13:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CC9B40275;
	Wed, 17 Dec 2025 14:46:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 91F9C4026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 14:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765979176; x=1797515176;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8AMJUnQQoJazhErLcBJQzW5Xhp3tcEbA1F6UEVux+Vs=;
 b=CXtUiuCvMLL4j77R4dwucPiAgRKq5kig15o00vRfHeMtKkOPgP76iRwH
 5XgIiDjaRtJxyNfZbjpnj3gu0oM4x/gHY9QJbpYA9ZMZKzcH8FeqHKP3P
 6jRMTBhmWdz5JAsY1VE6WHtZZtV0CuHAVHCVUUJ9vpujPrwiEKglng6XR
 aOPJfObddA9xeSczhVCxcbTolneMm5z8lK/qn21b6NBLs29sFQsfvD/Vs
 baFEQOUVpbXIKeQBAMAivEikGoKRBnEisSnMxHs8f88q7Rvkbdv81vHkN
 C4fMzJEaIn+f4HsapY2fcC/db+dRSk1/bqovK8lzulhAQ7tD9VlEAaxbV Q==;
X-CSE-ConnectionGUID: JpOsWF22STenRdVnZYoLPQ==
X-CSE-MsgGUID: w9pEyAK0RRetxSyo7PhRJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="78626797"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="78626797"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 05:46:15 -0800
X-CSE-ConnectionGUID: klzH56I2R52Ptc4P/dKrcg==
X-CSE-MsgGUID: 8YwzcD1BTJ6p5imcg107CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="229368690"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 05:46:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 05:46:14 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 05:46:13 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 05:46:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jio3yWb7ghTGrCqKzwGja01nDedG7eKLlmrsy93JBijd5U7yp6iwbFH3UTE9QNsoZx1DSzaFlzgBJDYSPP0mit2K6JjJNzFAwl0uRei+Vsd5FVjiCdzaWKYFsArpoppLYfbnKdzBdw0+WTHRdO2MxcZ321vV8hv5L4SmZnKeHigJuxnLgaJBNPm6NbBzmqy4OrivmVgs+2t0G1BmhoP0C5EnYLljVfEYd9jSIKf/IP5tbvIaPGFjlOxlzMRlErdqTaiEwAF4fRn8ep9g9qo4AGMaWmLklyXYWhz91SWs/6J+NEgfDk9JUosbz9jkKUvCubkJW5mRyMOylp9HDic36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KENtuzYXMy09iW5Lc1vqqQOr2F/wUWa71zYW71aIhvw=;
 b=oT1Qbzx9ZD4fOKQeFPyYL3QsyY73eoK5CsEfTaZc/Kyv4LFRDI/0IyfJq4OtiHo1q/N2ovddUttjJtlIz68wCz8qu/g2tlXfuyJrCF4glzzm5M4vyLCHfpYJJEHXIxmNAlLR2Z6dxQAn1acwccm1UaX7KB4+KYcd6X5DgESxXmqeRAQzz4w05zfBPk/8jzEmwRpCPBBNvqoYDPJ2clLDS094IXydAO48mjIUEHOceDN69H4omaDp0VOrSZTtFLLZWUxKKVP0UA2DpcAB9rl7zTLhJkQ8Z1x0A+K9w95cGC+SrFB6DIPJrZ+2oarc7t70rr9FAV5rPNQDPxKu6Ivpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 13:46:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 13:46:09 +0000
Date: Wed, 17 Dec 2025 13:46:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, <dev@dpdk.org>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3] net/ice: add MAC anti-spoof option
Message-ID: <aUK0GxJjmJDB0ojE@bricha3-mobl1.ger.corp.intel.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
 <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
 <aTrhuMI14CVK27aS@bricha3-mobl1.ger.corp.intel.com>
 <aUKZmzuLWYguKOlE@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655F2@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655F2@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecb3e11-6014-4b0f-a678-08de3d72a280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/qGZ2B6hXzzxxhiRbZr8/Sn227bbes/VeTbOhMwh5xogTyE4O77r0tb75U?=
 =?iso-8859-1?Q?U3F7ejAVNmhS61ojVZQXhVDZ3UXbewX+BwUAhXt2B0gLhY2LyjPd5TCxFw?=
 =?iso-8859-1?Q?e/yUf6fcw/OcBpreJLUKcDLXbPNuu+p3X3B9Pvly7mttympcCB+Uz0Cecx?=
 =?iso-8859-1?Q?Bs8YyrqEonlxFRQ4Ai9rXpD1hdvNSmpglvXdBnJ5SJNRNpXhRU6TpyxedM?=
 =?iso-8859-1?Q?1yt8ew9owZiyddfKpCe4ir0KcT0HSk4/wweQRymc2WydxsIs7tZjoGahtK?=
 =?iso-8859-1?Q?Db7rerKrV8hnTn7XnN+Xl9CniPsm39rOD2ipUJzMlCYJQI4tChwHEE5mjg?=
 =?iso-8859-1?Q?/ojmj/DRtpqxBECZfAoLFY2MjcvwpTpn+xZ6Ar4P/VHy1ZGmgcdZAy8/mJ?=
 =?iso-8859-1?Q?Jgk46uyOLrdOKxa0l15cTjMh6OgAWLaqO/PXrdP7NmV2JB9D2u8zZWynuo?=
 =?iso-8859-1?Q?FQtNJOhgTt/aLuZRadU5gZaGPn57gHImj4zoZgLqBwzZWGNbyCbK2o0uLL?=
 =?iso-8859-1?Q?cFm3kFMpXg2pRyoMDdwnrf4LK0g/1L4VBGJGTHIj1BkLfx2RGPKRJlsnEk?=
 =?iso-8859-1?Q?e/SIWgzOwsG6Xw3igSqAsW+bzjw1/6tpzUblAxyebj6V4DL4ENEAskG32Q?=
 =?iso-8859-1?Q?bO/juDdP/nTI3tNpF9zIq0cSYsPmBDyx71U2owV41yKhUSoiNpGJVnZBrA?=
 =?iso-8859-1?Q?fv21wg5HoA0NVmCp9/vauvRSP8uN5fIYpZfRNem9ZtyZypLKMtCWZDHeH6?=
 =?iso-8859-1?Q?wmE0VF+NSMbQDaWBnXUp1xd9J/A1V0miLX6Xcs0lHEV6snkTq14lbrJhL1?=
 =?iso-8859-1?Q?EWLUrvOF8pX4iVZck3XZcFAxkVIN6SvWES4y2jcIKkhNEISfpbh4gcarOK?=
 =?iso-8859-1?Q?vfqtEy0hBqv79Jrrujf6kriCpNBan7ajbTUZXCFQLvRPn7Y8VRToZPX2BC?=
 =?iso-8859-1?Q?TXH3cKZ00h3vQAyNDe9Rjnhp8uLJ+36uKaici79xMdoJIP82rj0EuuY+8S?=
 =?iso-8859-1?Q?H1S2rci0uCjZ8cag2QTy+vVcVPNtlfk6M5b2iq9A5vucOPnLBAY+5A6RRJ?=
 =?iso-8859-1?Q?ByS/xXFflisqY647/Sa65IFUwje58UGNWXLIjWF1xXQUngGOOO7/sasXKD?=
 =?iso-8859-1?Q?XtigclVXsfB8Iioc1NDuVqFKCAInIcWcXKMgIcwrgubF3HF6Q5viVOTdk8?=
 =?iso-8859-1?Q?s3dCRd8f7JlKRWFPSYsYO0JRZAMyNnwyyAlBk0NgTVABRTriCNhALCGe2d?=
 =?iso-8859-1?Q?ydK6OLVQ7ZyoyzeehD07+kPYpsFn1qw8Ezt3VM3jnqyxJ604zMR/Qimj26?=
 =?iso-8859-1?Q?VV9tEwosiJHeS0gw09BQVegdFQGniX0y1yAUrteR0G6TbCVxdI4hrLw31w?=
 =?iso-8859-1?Q?Kcdmq1W4A017UqJRbcGIfozUFwXEpXPhpoCkBsflWwVR5/R3fxd90/7+9J?=
 =?iso-8859-1?Q?tiA+b5EBEoPIn8s3vNX1B7hfQfU5ZgM2sTwWfWj3/kYXu0p0WPq7Lt23yR?=
 =?iso-8859-1?Q?CEW3hvXCggGGtq6mlB9S+S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?STuTJzedYPnjgqMP4d74eDUxv0aLeT7b3lVWwi0yH0p0WhgSa6ztXviryo?=
 =?iso-8859-1?Q?OsbypPRcJw16FXMKzzNAFNbavooovWhK0GvcZjA0Da5ZFIIkfDOOPOFhOJ?=
 =?iso-8859-1?Q?eh2SbTpqoNKjdo679Sbc/dwfLx9FMZwaOA2P0l3I5HKzdM7BzloOKFSLxO?=
 =?iso-8859-1?Q?sOKV9hfHdP8AO9IJSEOjW1+HV21GeSf3yOrSb844+5FVQnuP5/sSiItU6l?=
 =?iso-8859-1?Q?2engTuMvRrIgihXSBzGzl2TEwRSqvVNTR/60Mi6QEiUdu1sLa3rqgAjsE+?=
 =?iso-8859-1?Q?xa+9HY+2C/qvfecvV0+N41lnEcbdm5dhxPR/NZu6FeyiehUO/0cgxxuPAk?=
 =?iso-8859-1?Q?4OcUxdw9+x3Sy5KDdwYmzj+3PnJhog8puUm2XiGLWkO8H2ec4zn900KF6l?=
 =?iso-8859-1?Q?FHBZclVC29jrWeENFK25X0WS/oIXlvQ5FM2reecEaj8ezSGyn/n/s/irw6?=
 =?iso-8859-1?Q?0ad0Wj+O3RtSz8UiM7l8xil9tmVd/qMmyTcuQ1Ijk9ugBNajnlSnvvFqdt?=
 =?iso-8859-1?Q?qBd0lead6ztMLTPGp5HZWU3NJrPuJg58G9AvJiEoNDrUhr0E4tZMVft7jg?=
 =?iso-8859-1?Q?ejw4/v41XlPaAbijLFD1KA29nAvl4TwMGdD0KSew+K/vEv8Vl/U6Kzz7Jr?=
 =?iso-8859-1?Q?o/KVZZoZLQGj48vXIzfxiAnV8i828aqTyOjHD8HbBfFB2OpviXPmB8N4Dx?=
 =?iso-8859-1?Q?xNSJ97E2Jub2L3sul6b+Zxt+6W0TgYKgZR0btVn5gKLr/5FblCy8/7Wg9i?=
 =?iso-8859-1?Q?h25hIoKKtkj+Z9Y/mh0H5/w1ExqsL6QxIi9QExzy0HtQ4zcdTV4dh0c0XI?=
 =?iso-8859-1?Q?fAYDPf2y4ql24v2SjAoD9A9wtD9PsR859LqcB8vR6XCVErBN2sxchA872l?=
 =?iso-8859-1?Q?xfDbJWh8Bp6BOh/jG+ytydfIrSbsK3w5GS+5bAbJopkfocY8+z7unmDa7Z?=
 =?iso-8859-1?Q?DafHpFkJgSFG6SJfpFvQI+YzIHK4jXLLTifGt4rgPJCDeTmGcL3g9Apefm?=
 =?iso-8859-1?Q?84dY0oDDY7SKuGO5XqOI8A7Detpqc5oq1wzur+4Hy5BwkiR6PNNYWc8b3h?=
 =?iso-8859-1?Q?8W7i0QL3XFfCrhDAsP9vxeiVY94ckOPp7ivPomNubC8hHMpn3IDKJvfarV?=
 =?iso-8859-1?Q?4YAwKqeloXpaJ0BtWswXkR6yaMVST4/OkCGDmkjsxhMDsKy/WccTWdoD2U?=
 =?iso-8859-1?Q?UdnXCYzlBqvg3BkuvlSOxFH2HxOiIcZDJCE3MqbjaBViyEUG4YPOPfTlPV?=
 =?iso-8859-1?Q?o0/TJDUTFqyGRqRNQchiI2dry/6LRag3yD4jcuC6APOEC3jk/KOrAYg6jU?=
 =?iso-8859-1?Q?pRKCo96WQVLaLKUW9cVfB6Ndx6RbkJwsEZs4wLLTHM4VMpIcpeIQ3C8hQ9?=
 =?iso-8859-1?Q?MHS6rbcOiAZukZvV801wIDdrm98RkmeotGmbopgomt6MC6QRLFH+5ZMpdg?=
 =?iso-8859-1?Q?UDfSIcslzMmiV9ADhEAYkaj1DLKwvtDRck9ktCnx/ctdaknE6N/nYJ5r8p?=
 =?iso-8859-1?Q?ptcrLl34ov5SYq6Yob3iu80vpNGRwtJV7D6ntOv5q73/CA233WhhythgfM?=
 =?iso-8859-1?Q?HFTgpu96NZDJAKiEi6SOv1Lo97LGMF53pSfqOh9JUGLnreDh5zWVMeXKZk?=
 =?iso-8859-1?Q?OYD+Yxrg+t2EkTUSpqTozMh5JQUJT9rwr/gZmID+tr9mN6ivoQ/hVQ9Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecb3e11-6014-4b0f-a678-08de3d72a280
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:46:09.6698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qns+AsfEcHxm9TUlvfLRUmb1S2OJ0na7DSxJy8T5pl4gSCmmjwlKPPJ10pK7dHSVnlGx2tFONgyi6bYfmpVE9Lyt1yD5fHlyRgsdRSI7+hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
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

On Wed, Dec 17, 2025 at 01:37:16PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 17 December 2025 12.53
> > 
> > On Thu, Dec 11, 2025 at 03:22:32PM +0000, Bruce Richardson wrote:
> > > On Wed, Dec 03, 2025 at 03:47:08PM +0100, Morten Brørup wrote:
> > > > > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > > > > Sent: Wednesday, 3 December 2025 15.36
> > > > >
> > > > > Hi Morten Brørup,
> > > > >
> > > > > From: Morten Brørup <mb@smartsharesystems.com>
> > > > > Sent: 03 December 2025 17:11
> > > > > > @@ -1761,13 +1763,39 @@ ice_setup_vsi(struct ice_pf *pf, enum
> > > > > > ice_vsi_type type)
> > > > > >  		/* Source Prune */
> > > > > >  		if (ad->devargs.source_prune != 1) {
> > > > > >  			/* Disable source prune to support VRRP
> > > > > > -			 * when source-prune devarg is not set
> > > > > > +			 * when source-prune devargs is not set
> > > > > >  			 */
> > > > > >  			vsi_ctx.info.sw_flags =
> > > > > >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> > > > > > -			vsi_ctx.info.sw_flags |=
> > > > > > +		} else { /* Enable Source Prune in Rx */
> > > > > > +			vsi_ctx.info.sw_flags =
> > > > > >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > > > > >  		}
> > > > >
> > > > > This looks like a bug fix related to Source Prune?
> > > > >
> > > > > Ans: Not exactly.
> > > > > Initially, Source Prune was disabled, and MAC Anti-spoof check
> > was
> > > > > enabled by default. This was done by following:-
> > > > > Source Prune is disabled by setting local loopback with
> > > > > ICE_AQ_VSI_SW_FLAG_LOCAL_LB flag in the Rx direction.
> > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to prevent transmitted
> > packets
> > > > > from being looped back in some circumstances.
> > > > > Now, MAC Anti-spoof check can be disabled by clearing both
> > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE and
> > > > > ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF flags and setting Tx
> > loopback
> > > > > with
> > > > > ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the Tx direction.
> > > > >
> > > > > As we moved to making both source prune and mac anti-spoof check
> > > > > disabled by default, I thought no point to set
> > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE during source prune disable and then
> > > > > clearing it to disable mac anti-spoof.
> > > >
> > > > OK. Thank you for elaborating.
> > > >
> > > > >
> > > > > Thank you.
> > > > >
> > > > > Regards,
> > > > > Anurag M
> > > >
> > > > Note to maintainers:
> > > > This devarg is like the Source Prune devarg.
> > > > If we want to elevate these exotic features into proper Ethdev
> > APIs, it should be done for both devargs in a separate patch.
> > > >
> > > > Acked-by: Morten Brørup <mb@smartsharesystems.com>
> > > >
> > > Applied to dpdk-next-net-intel.
> > >
> > Unfortunately, this patch causes changes in the driver behaviour
> > leading to
> > CI failures. These issues can be seen with testpmd where packets are
> > looping back inside a nic port unexpectedly.
> 
> Can you please elaborate "packets are looping back"?
> 

When testpmd is configured for mac forwarding, sending in a single packet
leads to a constant stream of packets being handled by testpmd.

> If the packets egress on one physical port, they certainly shouldn't ingress back on the same physical port.
> 
> However, if they egress on one virtual port, and are internally switched to ingress on another virtual port on the same physical port, I would consider that expected behavior - the same would happen if those ports were physical and connected to the same physical switch.
> 
> If they are ingressing on the same virtual port they were sent on, that would seem like a bug in the NICs virtual switch. A physical switch normally wouldn't transmit packets back out on the port they ingressed on.
> 

Not exactly sure what is happening internally, it needs some investigation.

> > Therefore, this patch
> > needs to
> > be dropped from next-net-intel.
> > 
> > Can you please do a new version adding the feature you require while
> > still
> > keeping the existing default behaviour.  I'm going to move the patch
> > status
> > from accepted to "changes requested" in patchwork, in anticipation of a
> > new
> > version.
> > 
> > Regards,
> > /Bruce
> 
> This sounds like the CI needs to be fixed.
> Why does the CI expect this kind of filtering to be enabled by default?
> I wouldn't expect other NICs to perform similar filtering.
> 
It could well be a testing issue, or a combination of incorrect default
behaviour and a sub-optimal test case. However, until that is fully
root-caused, I'm backing out the patch for safety.

/Bruce
