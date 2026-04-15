Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296BDF41986
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 10:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42B7640611;
	Wed, 15 Apr 2026 12:06:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9FCD84042F
 for <dev@dpdk.org>; Wed, 15 Apr 2026 12:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776247567; x=1807783567;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0EnIiNC9DfogQKzvPbf7qJtSTzQ+MEAHHfW2rGHT284=;
 b=CvI9aU/Q57liRvFFJ90dcS3vrLes44+oeAumcondc0M0NIISfF1u2x6h
 XU1ZP3gZLjd94YJwnYJWuUTk4nFs6uhIEp8RAtjhNoMXdIrzi+IA00l00
 eL4iO5B0XEtJEaB3lzQ1vrl7Op6MK9oytMw7EMr7uJFSq4NU/0tstVZyz
 1NCiTTZNEnoV3UCGhHPNZ5A9dqajrTm2fAvrRdg4UUwKuKNSJgvg9TExP
 LSahwjI1DzSVl/InZIFeI02DsoW6av6Y/lldIlnfL+KLFBWUqUeBi+pgK
 /zXcaynaoGQixUD8LVB6H9QePb2pFpEn8EkahA0PLtNM7FKFgm1H0Stmt w==;
X-CSE-ConnectionGUID: MfFY1h5LSOe7n9/d+fOtCw==
X-CSE-MsgGUID: KJW3GPALTJWMWS0lAX256g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88670418"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="88670418"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 03:06:05 -0700
X-CSE-ConnectionGUID: 8tFUE5A/RmqRZdWlOzwZEA==
X-CSE-MsgGUID: wPuEmo+FQoqe1LDZ2Rc04g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="253790243"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 03:06:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 03:06:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 03:06:03 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.22)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 03:06:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8+mUwFRN0W5wWgN4AIiC6Vm1Yyxbu33GjjIqO7eAns6yfsU8sQPUF2Hf72oj+KdiP345ZNxGflMj1xnOhX1Aew+5au3rEKX8cSTxosubdWfftpBDySIEE/kvlVK23pnWAYPh4w7GJU56lvGydzj1qgQuOmQBPRASj8wPl3KuSvh9VpyPJI/0dlszpLKF/ZFacPiLyiZGw2vNEsMM9nH/YE8XDi97F5JdVnTxCgCvFinFFovv98cNSjN5xvzWaRNkhwtSMfGY2KY49NOfcskX7W2AgaJDO7dKpoEN/9uo13bqRnpE7wGDgOmDs7+jPSOiiTmmSb2jl6pmm5C+IfWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88z/uj7jtsPMLfevRP4mg9SUZ2SU/qCLYy3vfQ+o57Q=;
 b=gVHW2efanjwIrm1iTJZNEeLLx8VRVBD4M8e0u4R5ska08liX9EYC7R7iZmakTKy979wu6GzjdNjDev4RPXnpnv2mNy81990CrTrZWAwmTEwLPll9aN4GN6Rrly7k1YZmQWgsVGFFVZAxJ8mA2ysP3X+bcJ1eAHmE4XDlvqDFkT9Ckqfd/eEKNp5CxZ5LxzE91OTQfQv2WPContfw6FcQ9EBpc1cB3rFgrE21eiTstwmDTWM/qwKkwyG6/RbPN8gyP0ZPWJ7gKWCOLos/vt09rO839CX7s9pUVfIIuqW2xwuxs5D9pOE9hxSNPacx+zD07sTgiv3QTQ4WQdE3kQCPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 10:05:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 10:05:55 +0000
Date: Wed, 15 Apr 2026 11:05:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, Robin Jarry
 <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy
 <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v3 0/7] Rework device probing
Message-ID: <ad9i_u8dhtierL-t@bricha3-mobl1.ger.corp.intel.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
 <CAJFAV8xPCsHY4OFLy19jDv4KgVbZotn1pobNGhokbuQcY1AniQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657E3@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657E3@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: c2cc4824-54a5-47af-0fa7-08de9ad6957a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: E2ELWYbawEkUEpqvb/13c2pDlY164/kxG13cwOj6knH0bKJ5v4u2yUUhG9SrrCVO04nQfWvR2Ba7G4EpIlylht4CvqRqGN8+GlZtWgs0PNLyNOYWUGQr9DtQgzrVv1AOUKj45g6DpkSw8IYMato/mAyTocY7RiFQNu0K1/78f4rzqa50/S6r9CPRpubDtpuQ14FL5knos++ZYW1X+V1KMn4A1EN5Gl3Qp5KPctCNRrKdkbag+pwHv1jf1x+g40dbqfrWpcgRd3GRczbOSlt0CRwcbhriHBE6HRihKSCwHAoec0BB5NkDW/zt69VKJJKtXoH60RXkjwNCxOdqYWlYqppgF2VI426mt3n7i8ErGeUTbNnvTF/Yg9Ml3DkXq9Q/YS5IE/1O3OoYE7HLYQIYbux7AifSAuz3/DJkY/tUuknk+j+SZZ+75DXowd8sQ1mMp0Bn4iBzGvDzVO2LRdcKEmtSGTqfUUzUhvvJbLjIRW7DJSAC26DzKiZbSn0NR0RkAtirJ6n0tfMssVDFqpmk1bSQCVxOmxPG3AU0OzgC8TaWtjedSTlYnhZPbtAJNVXX0rZjei/nJWh+4acr1PaOvURY03fLpqQsVhGNMbQRqeWDevg5C6TfuPdWauZXTqXy0qRkPuoNNtXMRFB+5btAHNLzs1VmtYBCl3ULydGz48udveDtWAc9cU9lVOE6sX3MieVtdqgP+YaN1sJRGXLcD2mhCIDLEfpio8DLZZigV4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?f6EEOailhjh8Z8IhtCkkMnfg7V2a6y+dEvbNMw2HQ4GG5SY14mL8D/tS4s?=
 =?iso-8859-1?Q?OXjQCsAzXr0IOMTmaTcxIbvvfa2PrRHjTzSgtDO/+fznxwIC4QnuhqGsM9?=
 =?iso-8859-1?Q?m0T7nLjr4kQkG3N/3TBdZRpU0Nc8QPRrTvzE6dvt9Fttz3NnKDRyuJGKVH?=
 =?iso-8859-1?Q?Zhp3OwVjlxFAOUZ1FGE989fb17GxwLpt9P16a4SBDShcR2naj4QqM+iuBP?=
 =?iso-8859-1?Q?OUwcPNSzmEwt/Br7CAvPQQ/wtOoSzfVP6OhndLrWH6GdHgSkW06njfILY9?=
 =?iso-8859-1?Q?AK9vHqLbfcbBn1mKrbF638TczTwq3de3jhqW2hBtFk0+ufzCBAGwTTNkEU?=
 =?iso-8859-1?Q?8+RSaaIAyFuNUOX07yAeCjn3X4sFV3H1uGCzVCd2Kq9E31ZHuAhxiyjnX3?=
 =?iso-8859-1?Q?Wwt2Q4AfS5tW015h1Dn90UdvbFCFx4/CgagJ8DiF4YSXV81bNyobxzRXQT?=
 =?iso-8859-1?Q?M+vR8s0iWSibz4d4HfR6BVaOweGhthpHk6P4fP5Qt1TJcriFMFiLyeCs3P?=
 =?iso-8859-1?Q?THHftO5yH/HRSVzhrHYErFRlxHASoNvWD08mpN11mHnPugtMuI+st3yzOz?=
 =?iso-8859-1?Q?RCgRJycK0tt/aru+JvZTU+xRIky1Elp5sutyMeM91YTsBw09O5pqNkf8wz?=
 =?iso-8859-1?Q?kH1F09bBpRJj5yLb261STwFgJoJCMO+WLTu+FywwbrjPW7LB5JK3KWslnd?=
 =?iso-8859-1?Q?GoBASiDEAF3Lun8mASy56b7JHePRMjRelx0+ryRatiz6I9HGYDDQ0IMq0C?=
 =?iso-8859-1?Q?myx1RsOhASqm4RjNpK4O/SsdonTJnGCwc5cCmcdERjExcsoYN72MmKP3EX?=
 =?iso-8859-1?Q?eidN+Adbp+3HevK8qDKFM/NIjXHtQpYJ4RBSFc5rHx6u0EBinA9BoaYxyy?=
 =?iso-8859-1?Q?q2BzorMgeINc+iLrv9hFdhnk5gU65bWblHo3Zdn5IBzfFdkD713mAipqDn?=
 =?iso-8859-1?Q?KkgBuqOgJIvM08X61lGGW5Li5GyXzLXbOSsDWLCwuKJI1/sK7f5srtctx2?=
 =?iso-8859-1?Q?O/WV4lQCAxIr+KVMVPKzLZz9oUreUL3l780QH2JEQDylpy3iUOPa25UZXV?=
 =?iso-8859-1?Q?DpmcaTyLARS0CyAbhe67RI2odrpmltnfisqt7IE3o26gm4/oibF5tQLxxk?=
 =?iso-8859-1?Q?86tB1sowqCe2cDsHZoQGcOG4/HO++skSzYNbQhfAFgjFysGByQXhpohhPe?=
 =?iso-8859-1?Q?93rQIaOYw8p4Sr0A3JIRdoJTeKDG/yhXBnh/MC0TTT3RkQhtExvNl0aC5q?=
 =?iso-8859-1?Q?72HKgmCWMEovPuuKcB7TBNIbczYlPSnLmztBqUAOVssuHTl50wvsJDSp/n?=
 =?iso-8859-1?Q?T94TWImF6J13J8MJZCr8GgS1RPD5UUErsS6svl4K5ImTIl5bBqZr5hxX0e?=
 =?iso-8859-1?Q?GsYWmudIsJ0Iv80aeYZyybiaD2Ib8mAY3az4gV3Q/8NyFE53yncWN15L4C?=
 =?iso-8859-1?Q?Sfrktj7i10JERI7ofIBUY/CAnxi8d3s8zzoSYNIPc5yeXknlLRP3VswwSf?=
 =?iso-8859-1?Q?WpPb5FAiUm0osDFJUSQXbEVpTNbtqz+u7zFeyRTJtgEJWK3QpqYZmbWH5I?=
 =?iso-8859-1?Q?Lq7xMC/WG0wRlICObJZXEyNgXtpEMz+40C+2uLOIyCmXZzewWOA4WHUq1v?=
 =?iso-8859-1?Q?Tjho4mngGJHL3eVu/pefg7exEbHF2FVQAdQf6LZi3srfirzV7nQ/jhWYG3?=
 =?iso-8859-1?Q?ojPjMpRATbr3NCSWeOuJsQGDBmyyUzUHrCKj/f6IRWfz1pSnTQvKBOKqEM?=
 =?iso-8859-1?Q?//ZjKbXZi3q1TFq0mMrmncBoMjL0/fq32cseGv7vaZIbt9hYW9ZbY8POrh?=
 =?iso-8859-1?Q?uxYdRfz8GkjwRiO1UcXQfOVN+zrJeiw=3D?=
X-Exchange-RoutingPolicyChecked: ZRZyrg+uCXuMPMlBXEoJWDdQLLodnxYaITwsaluFi/50sarDlrq4xpPHS0d0HeZhBrWQI9KrzSl2zbJy8Zn5zWD2jaUFEtKV3ejU+4Jvrw7GQXOTx8z5nwZDUua8SAWOIt0Od+3VRyh3xY4n1Z74JLFfCOKuiUAS8fmKi+x8KNCnrCTTPl7iFdcv0orKnfFWZCKLZ8604JmdvRL3alYhZDvsVzUcGGv5Q/LPFodvCjgx35A2jggssygw6Cbz3zzqtj35itEHH1l+Z3zzJkkGCuWywtVpb9/Z2K7AZ8mgPy4LMCIx9WwEPu37Aak+EwricW+HN5jzHakjXXxwJL279A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cc4824-54a5-47af-0fa7-08de9ad6957a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:05:55.5905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ol+ICG5Agb2lFoDx9s6xMdt+6PYlSdNbaZ/a+ivbFzp2XKyPd7blgy3NxTQZSUUPbXqUn73LXwI0wxiq7Co4lE/Mt5RZTdgS02m8c4FpCCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
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

On Mon, Apr 13, 2026 at 03:34:05PM +0200, Morten Brørup wrote:
> > From: David Marchand [mailto:david.marchand@redhat.com]
> > Sent: Saturday, 11 April 2026 12.11
> > 
> > On Fri, 10 Apr 2026 at 16:35, Morten Brørup <mb@smartsharesystems.com>
> > wrote:
> > >
> > > Is there a workaround until this patch is added, if I don't want
> > rte_eal_init() to probe any devices, but I want my application to probe
> > devices later by calling rte_bus_scan() followed by rte_bus_probe()?
> > >
> > > It's not something we really need, so if you don't know it off the
> > top of your head, don't spend time trying to figure it out.
> > 
> > Well, starting from the well known -a pci:0000:00:00.0 trick, I wrote
> > an incomplete workaround implemented for OVS.
> > https://patchwork.ozlabs.org/project/openvswitch/patch/20260226172429.2
> > 12034-3-david.marchand@redhat.com/
> > 
> > Incomplete, because some buses make life harder with some additional
> > parsing restraints (bus/dpaa is the first one that comes to mind) or
> > requiring a driver handling the device exists (bus/platform which has
> > *no* in-tree driver, though this is a different story..).
> 
> Thanks for all the input, David.
> 
> In my case it's only PCI bus devices, so I found a relatively simple workaround instead of using the "-a" trick.
> 
> I start by not binding the devices to the vfio-pci kernel driver.
> Then I call rte_eal_init(); and the devices are not detected by the EAL at this point.
> Then I bind the devices to the vfio-pci kernel driver.
> And finally I call rte_bus_scan() and rte_bus_probe(); then the devices are detected at this point.
> 
> Note: I have to pass "--iova-mode pa" to EAL init.
> Otherwise EAL init chooses VA mode, causing my drivers to not load, with the following message:
> "PCI_BUS:   Expecting 'PA' IOVA mode but current mode is 'VA', not initializing"
> 
> For anyone following the thread...
> 
> During experimentation, I observed that if the devices were bound to the vfio-pci kernel driver, and "-a ..." was passed to rte_eal_init() it did - as expected - not load the drivers.
> However, when calling rte_bus_scan() and rte_bus_probe() afterwards, the drivers were also not auto-detected at this point.
> I guess the "-a ..." parameter is sticky, which makes sense.
> 
Yes. The assumption is that, if you don't want to auto-probe, you want to
instead add the devices individually, device by device.

/Bruce
