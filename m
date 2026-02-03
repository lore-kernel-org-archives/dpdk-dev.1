Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22E3E87843
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 15:40:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D16594029D;
	Tue,  3 Feb 2026 16:40:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4794E4013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 16:40:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770133207; x=1801669207;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MAu/160C81+6Ff5ssNAHQCAXQyO/rbrGTmRYntTPnac=;
 b=GwGFoWDgRpEXUaFfEzlcpkQEEzJdvvSY7d0YbdTJimYutXSq+MTJVMix
 srNESE1996j/vnCUzGaqPamNstuDgDxmTBrl+BkHgQwbad0J4z1UtVdPg
 kzMYZAyOf3vQuZiJDlLhUrT/NwXKObMAQ0etBjQjW0BaLWAs+IsJ0Trij
 oV0ej35xHR/aAAwTSj5+ggDG5EZAjMYf0plIDvCVP/Gq0mFkIVz2UzJ/z
 os511YgPPuYv9H5TIcXfIEjDEC86h/TsFwCRZJh7EWe9A3BI51cHwO6YA
 yszyPP6F8dk5yT5pHWzArmvb4JXYpqmRksPMB/bVXZrh8wJSZ9tZTwTQg A==;
X-CSE-ConnectionGUID: TVU4+iIiRL2/M+cfXLA63A==
X-CSE-MsgGUID: 05FIXiFmTeCeRyfH1UNLtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71205060"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="71205060"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 07:40:06 -0800
X-CSE-ConnectionGUID: 21IJOBRVQPGHuTdiXegzvg==
X-CSE-MsgGUID: di57EOxaSPqHJsobCzFWzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="247481211"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 07:40:07 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 07:40:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 07:40:05 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 07:40:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plc5e2qBaVmUucXVMJiDTTL5xArt2fNzHb7EoT3s9A+8q07wX/XoEQcC8qDEFvzILiOxGvh5b9pwnBduhxZ/rPCsmMYplqDGwuRtebemZIbpPzHAZ6ivDKXYxSOUM5v+kZYfOTbjLdwuY3q2P3a5zxJo9mXk/bkFheIfqfJe4ELLRt9VUckiXgSIfuSsJfcVuoin/VwM334IsjR3DqlLcu2Oh1pzW4PCSQzGntkO3NUV57hk41oY6ZNHlLC4UX9rYwpjS/PXrgvwyG2U5kEI7fA2zLT+x/Q/sQ+rJjlzx1XOujqvLIhjSUi9gWnNsXJeyv+MNhxRv6Sl4WIWx8iGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P0KEZah/uKbv7VlE41Rotd2gM2CMC0/I4t2wfhuP8c=;
 b=mufPJ8xYCyogN4E6W8GbSewThK9vw5v/+0jZz6GuY5K1opJgolgv3pA1xXlXuMmfnt71tdpnd16GsiqyI00GtlT6FDFV8x8yfceCkO87yUKOnjfiie/WlBroq5TiR1cvuRQWZzaQb/6wSYJTP6faKJWDgHuPo1cyTxNC7S8a/4O0yxngiZgcWJR5D258/xfVNJRKJab+TnGRAz7aVK0xu4g1OupVWThV8JXhEqHJgN41HEtGPGAdjVRTKbCeKw38mNpRQSnM5SaCFb2YLLJmw6nWdOlmSsRWSefqJsGC5WC7LUMsnT5BzXEfHcrNK3ll6/TJVEUk5U6bzQwyZo5Wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:40:02 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:40:02 +0000
Date: Tue, 3 Feb 2026 15:39:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/2] test/eal_flags: add EAL debug logs to recursive calls
Message-ID: <aYIWzrmzknYkwcNw@bricha3-mobl1.ger.corp.intel.com>
References: <20260126164519.3029952-1-bruce.richardson@intel.com>
 <20260126164519.3029952-2-bruce.richardson@intel.com>
 <CAJFAV8yRYXKjQCniarc=u9fYuh-1GYTnKr-fnEJDQwEOrZuSeQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yRYXKjQCniarc=u9fYuh-1GYTnKr-fnEJDQwEOrZuSeQ@mail.gmail.com>
X-ClientProxiedBy: DUZP191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::9) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 418e18d9-6444-493a-0065-08de633a7f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8B5v0Bv5zofLdICIUBEQhW6RxRngmi3+cEsHbWLG5K4cITKhiA/z+wyT1R8?=
 =?us-ascii?Q?gIO4F21Zzyy9Wg2jHyDHpTFQRo/P4/xE46nibd9AnlD+Gqmfl7/gi+53bpPl?=
 =?us-ascii?Q?4OQmPzoPBrW9yJukuqYtEKzSkaJePJXWZMk4KAykDmfAvWANqorPVnY7cwOz?=
 =?us-ascii?Q?P/9/ZrWNvhlYjricGegZhJm2To2j7PXbQCuGmHYhQ4y5L49WXR1EUc956XDh?=
 =?us-ascii?Q?AKW0mvHeBIJnSFZ9p4Avh1T3GWhSrQw5iD4lxDCpqpE5zKdbj5sz8tde7JcT?=
 =?us-ascii?Q?z2mwQ+SVzJ8qVazeH6c2jL62bfgQeveGOwTqJDIffyg5cNMi8y6EyE+m2nAx?=
 =?us-ascii?Q?kJr2I2KgIbEERXs+TS541FWa8X/kTpe73m3l2YJ039lNZV5E407nDPPbverI?=
 =?us-ascii?Q?Q1N6McwYG1WadI19QDIgFhRGfbRJkGgX1QAg8Ejgw+j1UHFbT5VCKr0JUg7D?=
 =?us-ascii?Q?DvTkjn2ItauAz+KOHF5S8RkDZ6arWRtk4ltixYRc2oE+u7/xMsfl0lmMPkiR?=
 =?us-ascii?Q?gmgpreUeyYhfKWdkQUOuhwrK+nShcGYZV23Aeydo/cHr9o5s4URMNzTB9MB/?=
 =?us-ascii?Q?H3fJZJKvzYe0eEz25ntt6rD4u8fNJCj42aFMnpDv57CV/MO1G189BEXcTlKj?=
 =?us-ascii?Q?u+kzJbO+eOmTjL7rvbGQ6sCwJbjworoXXkqCUWCGvP2BrSf/ahQjy62y117Z?=
 =?us-ascii?Q?wabbDjmvV/ehCItIT8AW1Ub2M0uYs1G60h0C83nhJWu9yamqId6zE7kRZ1Hh?=
 =?us-ascii?Q?0qJxzwZhZ5pr+GI9gXRVjM6m6OonimKB098Du3XmUdH7fPMn/EgrEruWqCS7?=
 =?us-ascii?Q?biEarX/rWBM0Ld+TK+4p74/FxRxlLZ80NJH3AQ+9FEHQJEKqWAMR3Ynb/Pt+?=
 =?us-ascii?Q?ZxICV3lHs4OyLGCndJBawSDMeuMgPjRAQOAWmT1t+aDsoR0W8gsEaqQ9/pGH?=
 =?us-ascii?Q?EqFiPN6HXlT85mHOReiQ83ALV+9MTi4KEodHa2iqbHbO3VAavSGGl+rK3ASo?=
 =?us-ascii?Q?IvKUmuuE1iTECEClZL57VjL2FUgEPz48MZMMQVcYumHZI/5z9tS1Trq32rVy?=
 =?us-ascii?Q?v4eY9jmoU8eCofRynmnBapRLlaIsGLn8aGQn0CLDjvJrVwHhXc1hdWT7JUYE?=
 =?us-ascii?Q?WVPNhfG+7k+2k3r9LN3zbUkHE0wlblLkgRcVy890Pm+OChoPtcVIQdI1Tznw?=
 =?us-ascii?Q?R5EjzagC5evon/CICGHEf8mnq9MsS3Mi8FxUHlhZY+vRrnxXfOU+Glquctga?=
 =?us-ascii?Q?ufzTTW6oKaTjMBaEHtKMzYTf05uZ02cDJH5QjQ2BApB9EAQou0yRFOHC4ZvK?=
 =?us-ascii?Q?XGyI/Kau1wb5xGZd3S1w4SjT8Ap1ednT8tylL8CJXgnf7sGv0ixV0vpP5WKA?=
 =?us-ascii?Q?UQY8pUyIF2ONh20loi4xPdWkK1G/ZL8u+WmDSNkSnzSw27pQzpPu5BZgW7bF?=
 =?us-ascii?Q?n1+00NJIKPJUIOz/lnGrZWkGJJxRE6yKbqlz0K5n+v6SqrMHp6IQXIq2p1bE?=
 =?us-ascii?Q?G//R9ecKuZPZ4W8Q5iSFETUiP2p0YbWAyEKxRf45zk5a9Srq2D2QvJjAVGXA?=
 =?us-ascii?Q?6tNqjY6aWK5SVjMSQqs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlKW2vA9lybm4uvIO275oauhahVGNa3NSipsEDIAyNpDz3Cp3i0P3HhNrZ+m?=
 =?us-ascii?Q?8xh8CUZI/oeAXYlkTrQFbIwm24vR+aIMis5dPa8Nq+lU0MADdQtvFk1r/XeZ?=
 =?us-ascii?Q?T+f3bvFvNcxCvZn7DtvoYOIq4WSN2D1570PbFNoYkA/x6kSvplfMB7bPbahR?=
 =?us-ascii?Q?JSRCIAsSP264WU1HkyabzEgIR4hyo+IlBihRtG56Xf+6xmeuS4pU61OhTObB?=
 =?us-ascii?Q?bUHJ3zfgOCnCnEcNFIBdfv1NQpLB1hPUEIGecwSIfgTtSJooA5/kxbF8IoWX?=
 =?us-ascii?Q?uoEVEZMxDqY5qiy/KGCGHSQ6lyqS4KWdGnpqDROwHshzY1c7qFToPRo55vyF?=
 =?us-ascii?Q?5A5Swg5cMRkd7FPT4GS3EXpHP5QS4poUClf09I1K0mGBM8S9PCQRL7cp2xWx?=
 =?us-ascii?Q?f99SWxn4dwLbs3t1ubMPsGbb/ltyOC7wkU4a4krvhcNTIE0udijvh8Osw8Hy?=
 =?us-ascii?Q?rjuLqejy5ESQOlTA2QADRURQAPUDxEDhti2qBnO3HWW/KxvU6HCYyerclyzf?=
 =?us-ascii?Q?9oc0iXryG6n/Ugav6xgrxoH7WRIwy95cwD4RCO72xqbg4PHjqYmXuGsxBdbM?=
 =?us-ascii?Q?N8qBYJpFTBgltIYB3DAY+6Iun1flSY2X01WkZLJ76Jfhgd+pleTsmRYQ+PLe?=
 =?us-ascii?Q?R+b5ocbOpeHjbbtiyfvyaHWcUD6vZ+xP8H+GVIjY7HeRPg57CwLo6VccFllf?=
 =?us-ascii?Q?qV1F4XPig+cjlqOOz31i3FG1G455CPEgwBH0/RbvSlvuMNUgzsW8K95xIpE9?=
 =?us-ascii?Q?crvQLUofJhb0b3656BtOPY64xTHgO376dq5xBWexbZDFQUqe1SuaHytWwXXD?=
 =?us-ascii?Q?bttiERfxAIZBeInUMpmh1xPNsetysbXuBpGHQAZ9eb0H80UGXZvUVAa1ehXh?=
 =?us-ascii?Q?foZ6sKjZpHP1ItL1yw/CBHz3gwxTAg+Is92tgmmNMg0gpkrl/k8UA7i+wBWG?=
 =?us-ascii?Q?PikX5Hunoyu5N6Ojs0nIq48tR1eOunr9Zd5wZY3083Ba5NrS04t7mket+/WZ?=
 =?us-ascii?Q?+t29tFSNlqrslWrd6gGdVd5DblWZOwHT6mQJjqEGtrzwcuooGlSYeuPEK4iJ?=
 =?us-ascii?Q?PkdQbeunBzuoDK8Km7kChmtNsNm+H2bMO1d0DhG/5NEZMUIiPlL7r3UEIOGT?=
 =?us-ascii?Q?iDHo7ZXKFG3O7ZdAq4pIAMqB+DwaDzsYVZN2RixOb7eRRvIcTGMVxb1GmPEC?=
 =?us-ascii?Q?rcwtzXwhKWq+mmTuV9CEzK88dX2ftS8VappVaBdcVzbhwGf504OkH9/DytX9?=
 =?us-ascii?Q?kZzIgy99xMV+dNyJNCdyt11sDGfjgNmeY4u8vZyN4qzyC5U9+7LpG4Lbzt5v?=
 =?us-ascii?Q?Itn/UuCH0vUIn8GYBz5tXrSuNUYFVmuLaNaoyzTv45cBG8+YYjZsA6uWZ38p?=
 =?us-ascii?Q?fZIvrujIzUHFNfJ8vec8OU/0JSqvJEVN1zQPPY+PRjrzEtUUNxZIavqj2TkG?=
 =?us-ascii?Q?kryW7b+dLtTGedAHHBeSD1O+chLItZ2pxwvoUjHuM2MyhpqyUWvz5mys5/lH?=
 =?us-ascii?Q?9SOZ4c5Owkx97XLmI0F+SrRQet8uzDMgxrZcgR+OMkpHQIYQNCF68ypC4qFD?=
 =?us-ascii?Q?khaKRfRxzeMJGudFqustgoTgDWlc4hXFuU+z41uYFjXbd2hBszdPZz0CJtCv?=
 =?us-ascii?Q?bVC0fHQfQy75BzMFrKAjrdsnDkIYORKXrs14RAsEwgzo4Jp99IxdLjGSt8Ut?=
 =?us-ascii?Q?Fsh+H0HlmTDxILSi+Tm5UWE2MQffK+aCtBjGOzPh/V5VTFJzipvpfp3Vp51P?=
 =?us-ascii?Q?xOjHJTqlcSiTIz11Pd7ulHTEM3QCIe0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e18d9-6444-493a-0065-08de633a7f20
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:40:02.6847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG4pKDRJPDnDSqdgZ5EZ8qN66fTxgxpbafLXeYeT/IBDhl9esR3/Eps0M15jntKQ+oodMTMhqX4gnnrdOYRt2OgkvUq8WjtsVfN5iHh5ZRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
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

On Tue, Feb 03, 2026 at 03:17:43PM +0100, David Marchand wrote:
> On Mon, 26 Jan 2026 at 17:45, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > When we make recursive calls to dpdk-test to check flag support, either
> > as a secondary process or as another primary process, add the log-level
> > flag to give extra EAL output to help with debugging any issues. For
> > calls that are spawning another primary process, pass in --no-pci flag
> > too, to skip device probing.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> On one side, the debug will probably help with future errors.
> But on the second change, the --no-pci stuff is not about debug it
> seems more like an actual fix (or well, a way to hide the issue in
> CI).
> 
> I would prefer we split in two.
> 
Good point, that is correct. I felt that sometimes we may be at the mercy
of the actual hardware the CI is running on, so disabling pci probing
should make things more reliable. Will see about splitting this patch into
two parts to evaluate separately.

/Bruce
