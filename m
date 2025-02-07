Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87297C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 15:50:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACFB042E9C;
	Fri,  7 Feb 2025 16:50:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 68ADE42DDC
 for <dev@dpdk.org>; Fri,  7 Feb 2025 16:50:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738943409; x=1770479409;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LjrSY1oz07B7cGBJppjqGQ8gghNgIvjuz8UZm7QD+CY=;
 b=AVzztFL3kfm6Ut3SQKMmSBgCF3U/YdSWXyQBVvIzvtKx+B0IvXPlM7+T
 vm7waIxgKKNsfwvKfjfeGfPNS9cbvLAyOXAmqDvq9/gqXsk0YFS7WHnDI
 Hi4TAbgSBzSSEPUB0imP1AgNtBS2X5Revoqszf9FiBn2WiWf1JceWyNWO
 HqB075CQ92nB2G8A7sjrgp+TD843yefNTCbt2xvvwJol++3oMtN5c15A+
 WqhcPLke6wOU7XzhxY1oh4snvCwwSxn7d7A/qF3Y8iSzBI/GcVCoiQy08
 YyrEC6EEQopjD9VMomTTV7Fy93Sjp1siqyBUhkHpXDqQqs7rqVtgzW634 w==;
X-CSE-ConnectionGUID: m17JT8SPScayLMPC4rHEaA==
X-CSE-MsgGUID: Mubg03xwQYaSg6H98TO2vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38818678"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="38818678"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 07:50:08 -0800
X-CSE-ConnectionGUID: GZkqQQEkQ8+2y+3AjONg1A==
X-CSE-MsgGUID: UnjiyXEHScOwvK2wcqpowg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="112187025"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 07:50:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 07:50:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 07:50:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 07:50:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF/hEpnoiwt7BTUKAyeGmGPL+xUMf+qv6lqX9M/S/g8cR4cwvsxI7o3Gii7yPCJFTQH8G7C+/sYqwrREv7Io7EgtHda6sTEsIS0II5KU3vvO1tmJ7/B/731YN7+3Vex3mUls4q7F98PTxuauqwuULFCchFH5nl6h3jbIBYXq6sHlKQUeICUy9KnK1NOdMmfNVDzNdiUuLsnJtR3eFKE3daOdEXm4TtWmBdi2I/lBcBsM1GNHQ+kG7a2vLCL6LQMisBNkZE1tULIKqX7Nvki04+l3Xp/0b52xiOb0XQzGDWdJo2y0vKZf125iICaQSl78ZYCZiIRW9A6spl2Y92UUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKohrmuTZR+bLvHheLRI65ZcXBBIE+SOqGjucxuni24=;
 b=JBeuX8Ox6GtAmJm4VUHrlwDNwLCG5Hxc4o3Rzybfz2kyY4bc2JkUYHCjWKNGe1NJ+Nmv6zjWciZrgB24LVcOnYayVKEdTcZl/u7xSf5OUM71IAVjUZFn3yaDMK5GaZiZkAPIrBPj1K9cRIBCiOcBcz0ZPx0/M4hu4/oAz+Kotf27B0zutXEclNvSIt9syeptx4NOwMkaWEphuCBVAEanijfTYFoFIuwqh4eaKUeWsGXg18HLNOBi56rmV/WU95R56znkPwGmP4DXOaDy8kJEzOxxEhkmOVOFLDHhdzJz5BSQTs+Ud+pwIpMVIecxQHt2aHrSAILPzRD9y1CRwlca4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 15:50:04 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 15:50:04 +0000
Date: Fri, 7 Feb 2025 15:49:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 07/36] net/e1000: add support for more I219 devices
Message-ID: <Z6YrpU0sElpJ66Zg@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
 <aa0df2ccd3864c368e93367b1c38b5bc98b53bcf.1738932115.git.anatoly.burakov@intel.com>
 <Z6YE9HWGelGN4ygU@bricha3-mobl1.ger.corp.intel.com>
 <b703ec08-80b0-454d-a62d-8f7751eda7b8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b703ec08-80b0-454d-a62d-8f7751eda7b8@intel.com>
X-ClientProxiedBy: DUZPR01CA0163.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::25) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d69d69d-8dfa-4a0b-80c9-08dd478f165a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/CzCQj+5Y5IBPcFS3HeIiCxliEi7BC93E9tc7e11bmWbYP3ogXgsVKa+rupc?=
 =?us-ascii?Q?Dc6iIC9Ie0JgvPw4fNCCTHP4c0475QTTVApDtlzmm1EzIIi18uJky2HXzJBj?=
 =?us-ascii?Q?QkQ1TUDE7ggg6+XPuZsVr+KFpyQePyA9YSb+10inmUJrAYMUMJ+EmaTuSFmD?=
 =?us-ascii?Q?Ao/DtaGKrtkiqa5c2I5XxKvfDJSkc4Hu+ugQif2yDdgP41R7+kkBbOBt+tpg?=
 =?us-ascii?Q?QYCFiDwZ1Hd8SZc96iSMuz/QpfErUyo6s1g4vhcnnKqQIS/c6tHy/gAWOOs5?=
 =?us-ascii?Q?ulIQRgX8OXoQv3RYTQHSIxHhGaDp9s62OWSpQXupZ2vHDy5Py/CWLfhfYGIF?=
 =?us-ascii?Q?Mc/ZINx50KYwpQL9cYdWOgT66bTWJGjIMfzETWQghrWYR5PRNgy3cs01Qkyf?=
 =?us-ascii?Q?g7x+ZDjWjv/0CQpI3qiUkICsVEUfmqh4QX7iYujgJK0c5qaQsEOvkk90Z9MY?=
 =?us-ascii?Q?tjGk33+3UWZJOOTiOFAUZEr4YJH+Tmtr4RBRJYMpi/Rouu0ttZlgnK9HRiz0?=
 =?us-ascii?Q?I682m+GMnzCLzfZvG/ftnAqHdtY47CJXfErX+RgXM/UYQIPjAS8CgZMhNo58?=
 =?us-ascii?Q?sfjm1ETKuAVKNQINmFG0yyqztn9/ipaycP0KbP4rZJzJ3udLYDBGxyEJdaiB?=
 =?us-ascii?Q?Vmdo0xoZ81zCvdWklZkWuPPDMHEfSDkLBAxscUVK/3x5Pqs5aOwvspK/mbTU?=
 =?us-ascii?Q?3u0XMAYvW1idarswBZcbhSaiPkha0w9iNl52jH17v07JiVBqQZF6tXpYJtTO?=
 =?us-ascii?Q?4gy5JHvAik0qGFx4mSGH2mYxYSjh+vz1dul631Zj13sKYDPUyMQCVZo/akf4?=
 =?us-ascii?Q?l1CEK7ceyRbZ+D3t6RAkI9z3IUZcy8xwng2nXuT3agHdkdV0QASKQyXWhoo3?=
 =?us-ascii?Q?BORYrHvUc270oB59ZDS7Yb2ejOd3V2J7/xLp2MRmkRds8wbvrRxgMs9JTcmG?=
 =?us-ascii?Q?YCW6JLKkPxMh6fkAJ9b0GZ27RSH1+9kU+BpaTSHdJbK0IgS5d6y4sU7MPSJK?=
 =?us-ascii?Q?chkjgpS35TXYfVs67eXwNrTqEgGdenhRzAYU4UXla40w11WudQgu0Nmsi8La?=
 =?us-ascii?Q?Dwqme3RQQ1sSTVDvdsep4A3byZY9zPKmuY+9iZ/gFNXLBCfYdX5uB39rRUWm?=
 =?us-ascii?Q?beGjp64mnvqPJGkdghLztCQDpn5un4YRmWtfb0iyXl3/iRSYFAWi9uudBmWM?=
 =?us-ascii?Q?kOlu6eFaD2s6/5a6S+W9nkspx8FpOiwYjjusEuC9KE3jOg+nPpXoHfV6VBF0?=
 =?us-ascii?Q?QZr10UfEbBWFLwtqkoOIlHBHUI4siZz/jl+BChNjBRo6UQmgcGCITEzDeiyv?=
 =?us-ascii?Q?HpAzJbjllHZH+9H2H3kNTY/pdofHd818oqarKgVBnyeYjFLIpg3/+lH1aDHD?=
 =?us-ascii?Q?ne2F10tqRZuzAUaGSTgJIDCxmLNv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6uNeDzy4umW4Doiexz3MPbJRG3kAs7lSR8zxtT/iizrsjDEDiBfY3qB6bXMV?=
 =?us-ascii?Q?9Fri7U4hgHJxiOaeUmE4k737cVoOxovC3uE0D3ss8m1KsgsAUS8KtioyQB0h?=
 =?us-ascii?Q?VJ0l21oJGlQm52Cr4CzTx5BbiR8Bq4VHfbtUBc6U8ILIu1lOQyJFaJ5kf55m?=
 =?us-ascii?Q?dSPvu2MhyvkCEHnrv1/ZuFuW2FHReBDIFRjCSXlkAQCEgHutgyTuwJyWh79y?=
 =?us-ascii?Q?v9MywEq6ege6Rys/U0HgFyx1j0V4UyDfSYlzYMayirTOapQBdqmeOj8GKnAb?=
 =?us-ascii?Q?1NAc/9IRQ1XIzkXG2gPUBbldQfg8VhCWILcDvq0Soyb4N+hs0IW1+4dIU1RD?=
 =?us-ascii?Q?A/bh0pCGsCzaWzIrCzDoZBhr130T6YDG+7rCGwZfZ8DlJUP7hbhTPLtxakqe?=
 =?us-ascii?Q?5qKkEYfKOraEay/C0wfBPRoe8GHVyOzQiupLQmumE8N9zXuLbUtLWuvZOiEc?=
 =?us-ascii?Q?NYTqyCeSG4BhpVXRQEfV4Oc7a+tEGPMzhzbQyWR5wTtrzllcdjwhlmRokbB/?=
 =?us-ascii?Q?ElSG3mW0nWT5DOko5WaGtmyUh1vWh/3clIecehwQELjJR8BlrNAypQ1z3eDB?=
 =?us-ascii?Q?mn1Cq1vdsgAwnIlBLp7NFIm2CczFNHI9iOrJto+qpXx6dZcmXPCAlNLjJGde?=
 =?us-ascii?Q?j0olPa2789Q51f2W4fJXMsrvm1+WV2FvHhFyO9SiK2wV0a6gfHaOFvirI+vN?=
 =?us-ascii?Q?WGDWqRusjR2swPVKoQCPxf9z2eYPHfbFv8QaioUhc6wqwBU//IyC4nc55Syz?=
 =?us-ascii?Q?a+aBogy89Ljg9kQteY102Jg/T/8utTB9MfcyhGnabBs8gIrbeielRdtWMKP+?=
 =?us-ascii?Q?PUMlYXzx//l/9PL9MPLzvNDGlkwDlD3A9ezEVuEDLw5UUmQKfWqlSIM1mFBy?=
 =?us-ascii?Q?BmoiS+WzDgu2z95elHuxg8X6LB+doXfVld/wt/Z2OCb/4V11f5mA8dAugFhr?=
 =?us-ascii?Q?sSFsfmGa3RYxVOsxhKWxOS/JGWqnoQS/mfizeMosuu58SpNONBqGYdsjOIxp?=
 =?us-ascii?Q?Cclao1dHeKcbzFtxUsW7RifELb//cEzDS3izrVSkQK1Dzvlcsz3CZd7s+SpR?=
 =?us-ascii?Q?gv0LXpyYizNHk8S9PZiZjJNxOQpUXhArALIhBtX4n5S72LEkDYx5rfiUOFqM?=
 =?us-ascii?Q?3QwNcJVvPQMMJSYbRG9ssHxS+ys2+ziRrcoiP/+ZhtJNqJpiXuSaDJQXXMM4?=
 =?us-ascii?Q?cy7Wata2OABJLOKJboSGUXdat08OpoqvCm8yF+ULx/WRltWEKAC81glqEw7F?=
 =?us-ascii?Q?4MwpeB6pN/mdoKjNxSyh/Mstyq7MjvVTTrKxIArJ3olzpNx/nvVRmJ2Fbcrk?=
 =?us-ascii?Q?SMWNr9GMVUGHj9KaV6gmmNFYDJmJJ/+SEGxxUHQTjtmneKHyO08O3KYGU1Ye?=
 =?us-ascii?Q?iqJJaaJjroR4Mp7FGKOPkxj3MA0oc/Moc7kQSf5v61liEaBaR60hZEbqPUsW?=
 =?us-ascii?Q?xzHOXHzylMJ5XgW3ja6pSXt5hreiDzwtMMoIcV6l2Jt0UQiNDG24NSiN7Eee?=
 =?us-ascii?Q?7HcUtiLH9Xnbek2NvhuAmqlpHuAK7DZh7GgWTVSsBFcm18luCKSGbYzMemU2?=
 =?us-ascii?Q?JaFLag3Dq5C6yuD+G59h1X7I2pY+mlS/0x3jKE3pCFlA+ln6akyaZPe+nAEU?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d69d69d-8dfa-4a0b-80c9-08dd478f165a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:50:03.9329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuvTgXPttByg1Kb8L3xWjbMuyQBCzLxrli5qQzovIPLKHgMDZYWZhFYi57HaCZjE3PLkH5o1nGNovDH9qf6BcGuy6oDwvMAPhMa0KyPQ5tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
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

On Fri, Feb 07, 2025 at 02:12:27PM +0100, Burakov, Anatoly wrote:
> On 07/02/2025 14:04, Bruce Richardson wrote:
> > On Fri, Feb 07, 2025 at 12:44:59PM +0000, Anatoly Burakov wrote:
> > > From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > > 
> > > Add support for new hardware ID's from the I219 series.
> > > 
> > > Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > 
> > Should i219 be added to the base code README as a supported device family?
> > If so, I can just add on apply, if no other issues with this set.
> 
> i219 NICs were already supported by the driver. This is just adding missing
> *kinds* of i219 NICs. However, I can see that the support for i219 was
> called out in 17.02 release notes:
> 
> 	31d4210971c54952afc9a1455ca40861634206e0
> 	net/e1000/base: announce supported devices
> 
> 	Document all supported NICs.
> 	Add Intel I219 NICs support in release note.
> 
> 	Signed-off-by: Wenzhuo Lu <wenzhuo.lu@intel.com>
> 
> It was not added to the list of supported NICs in igb documentation. So,
> yes, I think it is worth calling out support in this patch.
> 

For i219, I see that it is actually in the list of devices given in the
REAME, with the list in that doc not being in sorted order, but more in
order of which sub-driver (e1000, igb and igc) supports them. The original
e1000 driver is the one supporting i219, so it's earlier in the list, which
is why I missed it.

For other docs, the e1000 driver guide doesn't call out the various
families of HW NICs supported, so no minor update needed there either it
seem. I'll therefore take this patch as-is.

/Bruce
