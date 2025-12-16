Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C665D5C0C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 08:48:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53A7F402AC;
	Tue, 16 Dec 2025 09:48:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 244EA4026C
 for <dev@dpdk.org>; Tue, 16 Dec 2025 09:48:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765874921; x=1797410921;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Pp+AFhugCPufb1F805KscEq+RRB+zpkpqVTVG5BdoP0=;
 b=PSkp2P3WEkx6gEAKtYbd02MKpi7eNcq4ECqzPSFAYToQZOPtj00uYsGC
 G/t+fqvbKRX/1QTS3YO5mWZHAYGXO1HkdmuK6ZlwLMIRLo2q22JKq+rO1
 sZ6rdaskynXVfIeS3so3JSEHCjfZDSr+V6R9AoRgS4dyHJ8RzA2Gv18vB
 hTzSBdwTkicxWcL0xhhchtDkfyOJ5yt1OVDi7ICXHeEKF6I3ixaEcHtuc
 IVWRv29OpkHLO4o7envBmHS0/Z7zYFmvIcDcCUQnsvHWXg9vDAGMPLZNG
 Se2MtOOKzhcBImOMxyTS3BWJ+hptd+yzepKXmpOxnsiiX7iF/kLkJdS/P Q==;
X-CSE-ConnectionGUID: 3YZacoqEQ6SBc8PISs8+eQ==
X-CSE-MsgGUID: E8pL4RYeROa7LZhIKas3rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67664991"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="67664991"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 00:48:39 -0800
X-CSE-ConnectionGUID: ZGgpToKmSmSPyrek/A9YRw==
X-CSE-MsgGUID: i4cTp9/iTjWPX7VAXHQo/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="202874454"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 00:48:39 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 00:48:38 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 00:48:38 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 00:48:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIBgAEjuioGHofammwJQgfGZ9ESdfC5TtNftMvkclOghsFxf1zZBWx1tV5PUNxpdec15E6KHXdZmyFWU+bQdXb1ffY6Y19QBb6rrhdQIteJx/srWuSDhZDTGBsdiznBmqDoxP2q84HeLKQ9i2nG5IBHL4schJWSX1sdjTb7wE/a0N3ZDjP5LBugi91Eh3y6E3YE2avNsxlsmHEivOpgtO8A1DIB6usRIGKDb+bxd/064CRmkepqUtIeZg7QJd/IdAV+uirsQQFyRS8C/PAEUO7A0WdYcKkVQUW5XMSgVJLNoGXnk2LEWMbYkBt7w6OnJsas43YzUCeGUrIOIhaZDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0teXrMAWbBt9AxcqFxWcys19tLdUPZLA7w7X16kk7eM=;
 b=mhW9wRRr0U/2hG/oEG0KBTJkZTqcSBVTfefzZnAqvTOZ5EFwtEKAR6Ws8scD9W90LaFKKhsAGqydqe6Dx0rJHSWkdf/lRV+3a/ANOd3WZT3jB9DIlk3Ze/0Nj6LJJ7SQefH8k+SmnvYkIKq9CE38lTNm7GmZNXw1vlxYHS0MGuUIHjKNPQUcSfD673u0aN0z07RNw8gpHbmSnoRkP37RnmsdSyaz5sCuWkTVHBrVJiE8Pgs8tOHcd6UucSSf+6IytnS2Zn0cSR9xdG7jpsXKwrKG84bsX0mAwkmR/Xppx/k1TuA8emuPHBGQXVnCmknQmiq+O5mRnu52m9zQ89ljpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:48:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:48:31 +0000
Date: Tue, 16 Dec 2025 08:48:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Praveen Shetty <praveen.shetty@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: Re: [PATCH] net/intel: improve Rx descriptor ring size checks
Message-ID: <aUEc2jGvHlg13gOm@bricha3-mobl1.ger.corp.intel.com>
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E6@smartserver.smartshare.dk>
 <aUBMSa4u2Qjyy4t3@bricha3-mobl1.ger.corp.intel.com>
 <aUBReiTLkIp-M46a@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E7@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655E7@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0322.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 2029c545-3861-466c-a157-08de3c7fe394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wOSzV0Kgwp6Q4YNCc0zqoGH212DWrBwpIJdW4SXmWx7Mm+U9SnXpWTI7wc?=
 =?iso-8859-1?Q?85hPFAdn6Avd573/wbkrQJbRdaf0C5HKss7CrrrF9f0DfbaRjH4w+yVxEu?=
 =?iso-8859-1?Q?etPchNdMX+LMGj9am2kDUBdxNCZDnLVsf6dkK2TyIIIpEp80hR5Bss9m8d?=
 =?iso-8859-1?Q?9k2rsKEIFmGPuDhHGAjbCcKBWYzawb56e16H8NMnMolaJXHct/9QLzAH7V?=
 =?iso-8859-1?Q?m1Earsa73xdlgGpaEtuxdNeTRjh2xh+foDnRAgnNGQ7PhqTDqXv92bnAe1?=
 =?iso-8859-1?Q?KS8+ueayFGyxlEneMg1QixM7ZuS/bu+HZvC7BnD8T3xQT0vGzXifdMyGMS?=
 =?iso-8859-1?Q?p77kNMZQDUEgkuy47s6Bbr7gcjIvtJ6cL7kT5W8rHPgz4Y5HdifnZbzVJI?=
 =?iso-8859-1?Q?Sso3oABYgAmkWuXohjzFHTx8pvxxYUUaTxo8xVQ+vMiHQyN62FpX3T3ogo?=
 =?iso-8859-1?Q?/bUtCqpPdNTpLT74MdPgHvPe5W8oH6lwqABE4trVB0Df+cGQt+4APmop9d?=
 =?iso-8859-1?Q?u5l2kZ7Uw0/whSK6/kPgpUoiQCYaNkATgtwgBxmdzQVnBww6ju4aXWNMpI?=
 =?iso-8859-1?Q?m6w1SRAeellJV/EXBY2y117oIs+/ri710hxDtmLhZDl/G5cYkWL/Tw4KIU?=
 =?iso-8859-1?Q?CUUAXz6H92PJoWpBQ9ad1Q2H8oy2+K/TjEFZ5OSGRbiCBgsREfze3dt3yy?=
 =?iso-8859-1?Q?YP6JXsxmtprUTnN6+hpUwduYhbV70lxVw/rQ/Ap07ujxqAlSN24Ft7zBdl?=
 =?iso-8859-1?Q?SA5DZ0sAFNZf/9AG1Yp5n0gCS0I5gUHNWVxKt2ak1oU02e1IfpH8lQ6HkV?=
 =?iso-8859-1?Q?4b9CsMDu1gdwGPRFx5u17paol7I3qs8rVeI4uy/jBiDm8lP0IfjW7wBZDm?=
 =?iso-8859-1?Q?OHzbB5CUO22L5/mdLFMhDsNyxJ0Pj5jxGuQ+QD/nIgrwVp0kV67eEY5Tju?=
 =?iso-8859-1?Q?zo2ieKwQjrAWbE+TP74bCQvajrwoqTIKkUfc47A98PejShv4HNsnEDb9X4?=
 =?iso-8859-1?Q?nxMpzP2kUzrKAs5TgD9ycJMjE5Ys0lsW+andmMAt3ov2HoJa3jkqallCn/?=
 =?iso-8859-1?Q?8pYJDwgdNbGlXWtRfVibUwVmYgbrjDPGEKvz97JWHjGlZZ87+c8mx0rZtf?=
 =?iso-8859-1?Q?H1U4Lop7Eqe9olvpzu5fFsQkC5iln0V4DPvHSl1d7qxNlzb8veAk+fmFy1?=
 =?iso-8859-1?Q?80zvTGAbDGbqJTMPIGKvMKVxPgep0KKhA1s+4BWvRLAHzWgM6isJj/tLY1?=
 =?iso-8859-1?Q?4KS57qXqlT2Ga25VN75Z1KIqVaSMIVFSKa1yfI1UckQNj3nYBI5mS+JqJo?=
 =?iso-8859-1?Q?RhhMpdiiMjbhR1afeHbtUv6PEMj1HvfefSp1W28j9T3ILen618YLtDfJBT?=
 =?iso-8859-1?Q?4xirqFNwdS855Vhp9a4Qjdeb+cLW4KnFB3gd5/AxRcZIJcvf0lKkrnNvku?=
 =?iso-8859-1?Q?IIYPJV8J0YAeqJAMX6vC///nvqHV0/IjR3gBzPFGjJNyuLojKj6rjQop9y?=
 =?iso-8859-1?Q?B9x3ytjY/m/x41+MRvkwlV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SpUcruPwfbnWM1nDO5s892W1DOzRn+GCsGel1VWPfSMumr40VUmOCNear/?=
 =?iso-8859-1?Q?VQEW/ldTCBZbQzEHJktGTVVa0AzJEaqUhP8FrW3xOqLGQX7i1ePIPZktCt?=
 =?iso-8859-1?Q?wDqWsGjeStG88GAB54P4vIgQVMSUJCSk4MFltsOcPc4hK3LdpNDCtTy0ub?=
 =?iso-8859-1?Q?vQA4tJMvBTiOMNmfCLJgVgm4XTmokZ0X91adnE7HKbMXRlI3dojTa3q/JP?=
 =?iso-8859-1?Q?EpoYTp09N6cVxrhXXDSkWpuy6jFs/YcDVNBWtuQCfnnpnFo0MqJIBHM5v3?=
 =?iso-8859-1?Q?LU8f9AmPjZs+qZpB/FKKUlj8Bq9RsV+r8ULmXEQiDTbTGmhwU0AQjDe98s?=
 =?iso-8859-1?Q?/YJLgxvEEDS89TT0is6VSxt1BvCC6ST5zgdYcrjBeUuKQEO/eS8yLAK47q?=
 =?iso-8859-1?Q?OHn3eJFUkuqWwvfGOm+vCZRfVc/ljouowDbSTrzFvVE/E0ckOfxSLnHWIM?=
 =?iso-8859-1?Q?83Y5b8FQ7a3w/dCy5XA5g3x+pnOrC1Yrk3lwHg79HhJyRol/47ccRoyFLs?=
 =?iso-8859-1?Q?rvzEfNc1VPj1J8BKyAKjQCRCN4/1rSREkaOcBAoxiMhowOTmyWliTawQCR?=
 =?iso-8859-1?Q?d4NuK3OAXhyYvsyhm3Cu3d7va0/hmWy9zVTgGtPU52WHfffaGXuxpAUlfg?=
 =?iso-8859-1?Q?P7HdydMJxWxNhrtT0jm6XYNZxqQqYwqEaoQQXjoisrM6tj8LG3eLMwWGSw?=
 =?iso-8859-1?Q?UW9i1nLX2cZR1CJBbKW/98KL+bwWW1w0HZJWS2ayz2+PL5k8y3aQ/CzKeg?=
 =?iso-8859-1?Q?KWa6Yzdxl4YIM/Mr6l48A8Z297kReiPIFC8dc2+zJ4JMB7I4N+0fDPsh8u?=
 =?iso-8859-1?Q?oKyW2xObMKnvUkElM1GCIWwj0UXe6U4pGPgLq9WI2HszUG9YroD4IeV1Qc?=
 =?iso-8859-1?Q?YViiEuK+NbzA+RXrNz7I9jk3Z+NVrSDRAh9AXXeOoTiPddplY3uTbt6E3K?=
 =?iso-8859-1?Q?hqX5SRNCZHW/zp9VZBbgDGgO2Z0n4SGs9H6/+an54dNWx4Vv8jFwhc31bZ?=
 =?iso-8859-1?Q?Lta9tmJ3GMC+cbj/CxBJps6Pwpt/yH1fWG4J1pL8VkujhrKb0vpVJq7MD5?=
 =?iso-8859-1?Q?JJWTHiX3b9cF8PJ+U+kppddLwkBl9MNi6WWuB+52xyRacKOl7hDbqkKSEU?=
 =?iso-8859-1?Q?lgPgIWgQTgA/w86xhi6fV9eCUhD6Uc2kyI6eyibjDig4Ri8g/kv0oN61vw?=
 =?iso-8859-1?Q?THT6l4SX++w1Iogq3W7goYpRmHYPjxSLc6QzGsC+khn/1GWer86oW8qTYo?=
 =?iso-8859-1?Q?dSmsvbB/fn8IDAoXbM17Gcrk9XfXHjEBa801166OUwdUPYSCQiIHrm99gh?=
 =?iso-8859-1?Q?uUVz1iQIynkErdJo3g9Lbs3nLeLme/dWkDtL/HpoOq3CNGMjXrQcsb5nyr?=
 =?iso-8859-1?Q?KKMsTJucJmBXUJ7F7skYYlNbEbFE/r3BUmP28GCNm32lYYxAOsxpalgAzM?=
 =?iso-8859-1?Q?XWMxhXiZj8aeQKncubVq4OuX/wQSYYM148GbbOww00fKMsSy26xchDr0NX?=
 =?iso-8859-1?Q?QzO4hxRjvQ4RZBUqQrNLR9CzAWSwWn7qSCSapvfXDJSG94VL/yjmTCxx8c?=
 =?iso-8859-1?Q?wFoSPH6xwzvDQG1fVh303Ey8UA2jSKMe3NIq5sA2vP8zwA0/42o7eE00c2?=
 =?iso-8859-1?Q?Klk6DAs4mbuvuNUqrDtRPS8IP+206OJmDwF/8H5qP8qKvmCaG+mMWcNA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2029c545-3861-466c-a157-08de3c7fe394
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:48:31.7248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Enrbeec8GjCVCwnh3vocwjDVJseKElaEulGKCyLF2ZJiPXBut1V5/HHU+rpdiijNeUcgLQllDw/K7q+AKeI6uyciopyisZu8gi4otQ14lWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8127
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

On Mon, Dec 15, 2025 at 07:53:27PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 15 December 2025 19.21
> > 
> > On Mon, Dec 15, 2025 at 05:58:33PM +0000, Bruce Richardson wrote:
> > > On Mon, Dec 15, 2025 at 06:54:50PM +0100, Morten Brørup wrote:
> > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > > Sent: Monday, 15 December 2025 18.36
> > > > >
> > > > > The default Rx ring size checks did not account for the fact that
> > the
> > > > > port would not work correctly if the Rx ring size was only twice
> > the
> > > > > free threshold size or less, so add in a new check for this. This
> > would
> > > > > generally only apply in cases where very small rings sizes are
> > being
> > > > > used, for example, with default Rx free thresh of 32, only ring
> > size of
> > > > > 64 would cause issues.
> > > > >
> > > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > > ---
> > > >
> > > > Does dev_info.rx_desc_lim.nb_min returned by rte_eth_dev_info_get()
> > need correction too?
> > > >
> > > The minimum number of descriptors stays the same, however, if
> > choosing the
> > > minimum number of descriptors you may need to reduce the
> > rx_free_thresh
> > > value.
> > >
> > However, I think you raise a good point. I'll see about adding a
> > specific
> > error message in case the user is using the default threshold and
> > setting
> > the min ring size.
> 
> The applications need some generic code sequence that always works, on all NICs.
> 
> E.g. if an application uses rte_eth_dev_adjust_nb_rx_tx_desc() to move a requested crazy number of descriptors within bounds, and uses the default values for all other parameters, it should work.
> 

This is surprisingly difficult to make working with the way things are set
up right now. For example, if the user wants defaults for config settings
and passes in NULL to the ethdev API, the ethdev library queries the
defaults from the driver and fills those in before calling the relevant
ring setup functions. Therefore, the driver level has no knowledge of
whether the user explicitly requested a value which happens to match the
default, or if the user just wants a working default value.

Another option would be to set the default low enough that it would work
with any ring size possible, but that would then cause a perf impact for
apps which don't need such low values (as an extreme example, think on a
theoretical driver which allows ring sizes of as small as 16 or 8, a free
threshold to work there is likely suboptimal for more normal ring sizes of
e.g. 1k or 2k).

> Nonetheless, more detailed error messages are always helpful. :-)
> 
Yes, for now I think giving a meaningful error message in the few cases of
really small ring sizes is the best approach I can take. Given the issue
has been present for a long time without issue, and given that the error
will always repeatedly occur at init time with the offending values, I
believe its sufficient.

/Bruce
