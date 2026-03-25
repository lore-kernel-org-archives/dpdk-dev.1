Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95355109C033
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1A05402CE;
	Wed, 25 Mar 2026 17:22:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5266F4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 17:22:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774455778; x=1805991778;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=QptVRFZfHSEApfRF5bLVlXa6JNetMl0b9VSGtEYHsc4=;
 b=IkR2fyGHnQW6C7GNtIWj5aX897N0rsBLG+SqfD5fjXeLrcQSEbCUWkhG
 E8s73gQwVfTPfXuRgsFhjm2gxgrkvkg6/12A4bEnv/uynv4ZS0gXhYJdm
 aBlANBwTOgtDJLJGSwC7gBOvXF1DF4QtLsI3Zpfu+muTZBrKmynaIOsRe
 rnfUIgeg+yrpWGIXmrNu+itYGEtTJzheM4lmO/wpNXlQwindhzO3lwjch
 UmZ9HYbpdCIiO6XC2/6NFL4qbzTlxucOH9yYR+P0ebABNV4+K5aALqNmh
 ixi5dhNKXKwbR07ag6mutYIY4vt2HKixf+xgMWLe2b8fPoR4H2J8O03xt Q==;
X-CSE-ConnectionGUID: Vm2+aPauS8uozJqX7UpGKA==
X-CSE-MsgGUID: qtPK0yl2SxWsMZLNZukLmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93077779"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="93077779"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 09:22:55 -0700
X-CSE-ConnectionGUID: RLVnyqfgT8e+bk3poY9+Yg==
X-CSE-MsgGUID: 3IeNis9jSYCckNk6xrSQ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="223795500"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 09:22:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 09:22:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 09:22:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 09:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpuwA7s9PRGC01G5fEruMOlRJY4hqqGtyZIPn9XUMIdV4jzDYBbdQTaBZHIYtSUvZAzuwDa2gaf6fjiUdJ4WZxglFdz+RUx3yTf+FfNGpTsjLb3ry6ehmtqNWC7r3bfbPHyn6AVLlbq5mvtJR74QqpxDPbHIuFScz4y9SeEAEZyWR2540Feo+/phQPegoJNzyGsBLMyBL1CLKO3gSxmkE4Vk7YHGUw2hpe4YgLNl74WXxh2RRZlHCu2f+hTA0aEFklGwegv5AevnUl0M7QZF7qk1Wvk6bk0QER7rQBysMLjoBnpnjCm1Df+UxL6cNbSeZv2+mIypkq6wJsMAxe3eNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3B8Ol5LxJ4vEpzkLKg3hL5SMbyz7pRox19U52g6nIo=;
 b=Fn+Wgu6ryv0wir6qNomOeB5cDK/E6hCLpJSV43LTnWKZ+fYMeEijcr+66GihHL1HSIeG9mcumh5FKKUK66sTHad9DKuB5ND9x03GUfxU4aXN/wIv48SQRf7Y8Ekk/mDnMuEKPWJCTqp1W/gpciJN7Gs+7YdHJtMaB6wo+nj7RcIEHPfnUOz9/q335S5w8UeIkyYXCtpOjVMXUOr1PiZKCvl4+1hN2Q3vglB8gvZT9Vd7timfyGrLS2q8zxV/YcxakAu1M8kTPSHzCC4jKZfOAkIz6WIZLfjnymEialpRyLWAkvFVKdum9Xqr6QAZj7FRgkesE50jly4SGFr3o920QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 16:22:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 16:22:50 +0000
Date: Wed, 25 Mar 2026 16:22:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <acQL1eLeTbsnHuPp@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
 <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
 <20260325091921.687599ec@phoenix.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325091921.687599ec@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 770d4158-5880-46ec-d8b3-08de8a8ac275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Qx7oLXrQJWwASsKMtlyApqlpSE9a26phBL5r8oCDwXY/zJFww8rVx3hbk0jGQ+a29p2BaIleFIdG2WzQO1OwvLWjlM+tfUWZOxMmT3lbWb0V2DX/WokIqX3TqhJopCmMLEHROzqNsmAUOnJ4A+XlPa8baFaCroYYEi0Etd7oKyAPyuGRyto2LAW4hfyA15GPp4df+mKOwumk2R7wcmFUitae/fpn9nBzLPOLm3x+S410KaOAzLCYVuopI79tcsnmDZKXFKOS+BJKqFuxArMk38VBnrSNlIo6f6fDxBYwmwc81gzgUhQfAaBnuM9xRHHCAZ+oIgWOO6C9vh7FcYW393JXsDoiqNs8HUl7VoK0Jbor+TgUSj1pYRY0aDVgvohk7TvdoXUTcKPSdTv8qf8uU3hO1SP4ST5d5M4cANMbqTMh/9DrzLS245SBWpK83NIteKiExUqaExXcsjfNMBW12faGocBbBOpLYupcPKODYpPbsrKmfckfHxUvnB3VDaVBloJLg3lPiBplZcXqEkjson4KShHa4kQQV/9Wa6CGjnDaKfd54U/cV5o26PuB97IBd2YZ8Ziq42dSEWRTlzQyN0zVZB2pUFHsQsgPvi1j9wCKIbr5T9jKLCvL+rWQcVBtONxRT6ZZruFDXwsWBKlIktbrKBwza4FNgcky1h8wEwkiTmA3jHz3Aoon7QdwTgFV2D2p1X7gxZq39MuZtwLLQa7CN/qULo4udr6G36vK8y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1ol6WEcc8E6scAA9rxawyuAoQOR0fcqpXOaUfGHSmCO3j/NZQiTGPS1icO?=
 =?iso-8859-1?Q?f43C6HwbFTPjO5/vugmva+uLSj21+9UX/bvIwk2Iea88QDIxau40azcySo?=
 =?iso-8859-1?Q?piLJD5NffHc0VNLmyojSRpWOHLW0clLA6AcxtivxaPHLB7Pr1oohGM/Z6i?=
 =?iso-8859-1?Q?n652+lnoWDkZl+Dg5/JEU1bDZ4T9s3oeONCu7RFZnw/UFkKMhPVnzdvq6D?=
 =?iso-8859-1?Q?1w91uOJCwRZHRd8bETvHTHH2KsBerh9xarFBO67joWYSgr99B6E0SNlxtt?=
 =?iso-8859-1?Q?R7qM2FYdntZyVYs6lWAh4FK23i2htoxer+rx4NOVfw7PdEZ3Ea9qJsYUo8?=
 =?iso-8859-1?Q?kr9VLVFsEKDcwoD6UTooplSrQ1N5G9Ou730/ZRpE96B3FNqqsktpoq6CzK?=
 =?iso-8859-1?Q?tPbmzmlmkDPg2R554noL/9MykQiZ4v1Oimzx3ywnKqppOJbLgYwoX3caE6?=
 =?iso-8859-1?Q?t7nrnr9ELA8gORJob+tQjClwjX8OSv5MJAgFIXUDvTrIaETvLYUovtSzh5?=
 =?iso-8859-1?Q?y0Ah5IWEpaLYwW7cWn/2xjFQGLI/UMV6I8iDjju0bIbV4bBsezLBPaYu7V?=
 =?iso-8859-1?Q?ftQivOYpMfKu+RkJ08SYT2KE2stFiLmuc1BAikOCigCAQl+zZ8HQCZ5uoE?=
 =?iso-8859-1?Q?Ns403XGnqXx+cME2YYQYM8nkzIKrDepccc+KUJIUPevaTfV+2bxwnnt5r0?=
 =?iso-8859-1?Q?fAXI2uTldHmuSESS6G5IsmyZPJq+QvwvoJN9zWUWgzcIMHASTA8S9Cr/Gl?=
 =?iso-8859-1?Q?+TnYoRptQJZY9lRrIWb0/48SzCpKj+4bbn+n8AXVsRzYYhjRUUb6GpulrH?=
 =?iso-8859-1?Q?Ai+x7RYwN+WBQXd9XAjWmVGaesudAceQueWL1gnPYu4QWU6QptsNWXJXzi?=
 =?iso-8859-1?Q?i4KuDXVQZlJkHDB7V7kSmGTomEToHsbISUl5+t6q4GszxVhKxx2fqCEdTU?=
 =?iso-8859-1?Q?YvvjBlTR74ELvdk9uBVdJTTUJgHiiCcoFa34aY2TW5lTB2EchZ6ebHR0qr?=
 =?iso-8859-1?Q?NkXJYcqB9Q2+bm0tq/jHD7ybWuGzhJP+BgAWSBFTnQ8NhQfvUDsTKQG2A3?=
 =?iso-8859-1?Q?yOZSM89RYDDtUJJwU1BoKTuY2VCTtrYUTgSOxb561ws/zc3PsBxs2Bys0F?=
 =?iso-8859-1?Q?13d7j0sAeWAtSlbTL9ql1s/lIrfs1PurOG3gqDD7kTnPysOJMycphGMQC/?=
 =?iso-8859-1?Q?pncE5qHVL3VWXt/DDp3X73HQqjGxnDs2h91VyKjj2xZm8V8Cpsu4zMY5t7?=
 =?iso-8859-1?Q?wPecqbn1EFPS3W+uZGGUt00YWSba7X2ico8bMfnoyxKCvc1xDtMrko+PXy?=
 =?iso-8859-1?Q?HiqzU9sdPEb+PQHulkSKIwF1YDw/Lrw4jxS4DmxRULarkzjGeN+IJBHsOc?=
 =?iso-8859-1?Q?WQogxf8UYRp1m9bJMoYJqjvFSudb/c3+hzCEs8uQwwPlDB8JdX9bhGoH3t?=
 =?iso-8859-1?Q?CEJqfzT358yrCw1bt6GzsoXeq8MvBskQbfkvqKMlxtWe2fPrXDE+jCMpsJ?=
 =?iso-8859-1?Q?+eDC9u3ugVf6ebOJefPS1WIRYBfFWzGvkzeeFXUHKBR1M1HTH9gCFcdVnT?=
 =?iso-8859-1?Q?2uTehhk3nfAaompkJFSmSHeVbmHUXu9mTAhQCgFo7EyoriGpzyyKflT1xq?=
 =?iso-8859-1?Q?h5/YOu+F9SeKN0e250k9dgeCmV95FZvIkwvRdImulfsfpI67x0peMVtnto?=
 =?iso-8859-1?Q?Ux07XPqiqx2EftUAu6lqhG+tdimCyOrNCNwirsgf4l3SHYOleVxo4lclJ2?=
 =?iso-8859-1?Q?xUqju5hiDUf8wU3OeGiFxWrRBVPXPYMkmXbTBNUdfKSCcNu7Y0Rgb1Vri8?=
 =?iso-8859-1?Q?8A63EPv8BQUEHOTSNN3Sp6+uwngvZGU=3D?=
X-Exchange-RoutingPolicyChecked: nn7K7ibwR7Ujo9PPTQAbHFLP0qLVLriY0xbHtn6EDtmt5Rowy9oIMog60UiZXbTq1TOWK1b3FCZ4/OV6Cr31th6vfektx/hcUg/gYtPKkgO4EjN1bqY/osdBqjBpgTT8WR2L/bipt8S+juCmJmnT4rrO1cUsaVeTxhVD1uSG4Oj9gfTlH2LN8zkfG9LZh9tL1bYl8Auyzqu162s8S6Dw/R35VegkVz1S5CAdA+Mvk4NQzaGCApg7AZPNIPvasdTbr7fStHMuemX87tlvNOvAs2VQJt7dNwqr9CGBwU+G1CKqfGrYpYbYJK6p0XipnM5NKa1JKACE7/txEp50ZlwWDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 770d4158-5880-46ec-d8b3-08de8a8ac275
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 16:22:50.8863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JsV2E8IxHM+QxcsKBvXb5HiXUuectbYJflnTgx0co+LaxzHNffhhyInC8UM5xCByTE8dEya8AX3ieZMDjuxr/XeGe7BWNaUs0nlfGma/xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
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

On Wed, Mar 25, 2026 at 09:19:21AM -0700, Stephen Hemminger wrote:
> On Wed, 25 Mar 2026 10:36:56 +0100
> Morten Brørup <mb@smartsharesystems.com> wrote:
> 
> > If an application clones packets instead of copying them, it is probably for performance reasons.
> > If the drivers start copying those clones, it may defeat the performance purpose.
> > 
> > <brainstorming>
> > Maybe segmentation can be used instead of copying the full packet:
> > Make the "copy" packet of two (or more) segments, where the header is copied into a new mbuf (where the VLAN tag is added), and the remaining part of the packet uses an indirect mbuf referring to the "original" packet at the offset after the header.
> > </brainstorming>
> > 
> > Furthermore...
> > If drivers start copying packets in the Tx function, the Tx queue should have its own mbuf pool to allocate these mbufs from.
> > Drivers should not steal mbufs from the pools used by the packets being transmitted.
> > E.g. if a segmented packet has a small mbuf for the first few bytes, followed by a large mbuf (from another pool) for the remaining bytes.
> > Or if the "original" mbuf comes from a mempool allocated on different CPU socket, the "copy" would too.
> 
> 
> The problem with the Tx function is how backpressure gets handled.
> Not sure that it is documented well enough that if a packet is not sent
> due to backpressure, the mbuf in the array may still have been replaced.

Most drivers should be able to check for space in a Tx ring, or whatever
other backpressure mechanism is being used, before modifying a buffer.

/Bruce
