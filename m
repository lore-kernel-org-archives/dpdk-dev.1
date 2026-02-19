Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5504E9A04C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4F84402E3;
	Thu, 19 Feb 2026 10:29:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1BF01402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771493396; x=1803029396;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xxgO+KPuAI06h5GUqSO01A9lpgDvIWN+eUnJSnmpdSM=;
 b=Abj4YjNSzppZNavpbkc5mCjcwQUP/326bo6bV/x4SMtfo0HQb5xXvhUB
 yOB0YuNBgJNyqB0YVBx8qJj3xjAe7cEXC7W5COAzfpvSc2pjy8SBXoVvS
 g/B8+qanwvlgLeUO36GTnT2ob0LtvRTSl58ji4hsQ3mgClGa/Jn1pDr2P
 OVDCnsK7DXqoSlJFBnS8ANiYk5qRYeOB2dn0J/3DxKewHxefovtAu2Im4
 hA7ArEYUCZvJe8LAEoMC6GfL439IHndGVX/5z79Ae3jDuNG4mlMmH5u7A
 2NaD3ExcFRD8o/J2Q0kPYqHUblTMUrCDd6tYYQndWMwWZ91XyUzlHdrtC w==;
X-CSE-ConnectionGUID: ZYdAiV+vQxqZdgeNKZswVg==
X-CSE-MsgGUID: bbv9qeziT1eyu9rSAfUeBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83936910"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="83936910"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 01:29:52 -0800
X-CSE-ConnectionGUID: NOJx9dwsT46arNoY58feUw==
X-CSE-MsgGUID: RRsZTEM7Twa/n/SxmiLoWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="213085809"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 01:29:52 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 01:29:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 01:29:52 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 01:29:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcy57JVuy1vBqb4DjaB72hQ3RZmMduLHw+4Xx7+VzT1+/jpyNTT+NdvkqtvGQJZuGfG2a2qq7uJ9seJfqxS2+j7TTy4Wixji2vbnIhydAfn5LZIeD7hemPE7mLwEziMQp6IzwepuyWQ8C92xXGVlU+eGQXQd2FHO8ghtTduLUKzLAFfXw87ORTtA0RO8gILkHBlLVs7/FXOGm6nPlG+W4bme5K1HeZoS68c6G55NCFwr6WJX4XYGH9A7QYIw+Dn4XSPkGkfkzJBMHbRTf+Gs6JFWjxB2a+SfNqy63UrsOYYiCLo3IoAqiiMTJ+WhjetLPyn8zg6w3dFItVSUjfzCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifMwnqMQ2btsQNmOm43f6TS+t+F8WTrAmk0GiH6ku0U=;
 b=nsEOgQQa5Bjs6W0wtAmLogpbKcUCUjWFlYYTCfx/Xa/75VmeruDAKDJp+n3ZfHGBbbQfJk0ZtEN9XYPWZ/eEqvY4U/ETSBY4qDvCSHrlJgjyybywQriwCquJTCrUuJaGz+ZNEfpsrbOvmOkrp7eXlhcT46im/NJWoW6RjUvbPYv1udvuh1DF1sVZiZ6gSQfLFhgVt+TBhhXzSJHPxJGrdwjYEId7lcCldpQsfLpRwtbk/ghtYDqdPzp5KTYz2Y5663d7clfylKFobUPANr2J2ZsA0qfX9ARy2X528hc9bW/OWYwElKwtm3Ek/vQNWW1Ow5BdGyC36xKSNYf2fhkjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.16; Thu, 19 Feb 2026 09:29:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 09:29:44 +0000
Date: Thu, 19 Feb 2026 09:29:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 20/27] net/iavf: avoid rte malloc in MAC address
 operations
Message-ID: <aZbYBIoAonxgBpiD@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <ad3c77be6c74565b7a9e4544b6565ea91f94fc70.1770978324.git.anatoly.burakov@intel.com>
 <aZNTkvpt8ahCdoSS@bricha3-mobl1.ger.corp.intel.com>
 <88f7b829-83aa-48b0-9de4-fbdcf5633603@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88f7b829-83aa-48b0-9de4-fbdcf5633603@intel.com>
X-ClientProxiedBy: DUZPR01CA0124.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 98197081-a31d-42fc-3b9c-08de6f996ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u4DnsWB6jOL9MJ4O2YBNPNwi+umJrtfo/1uFqQdC9nv1MHEY0FFVCVIlkrQL?=
 =?us-ascii?Q?zS1qR4d22mckRzZs+/tzuGuFfWvskkoaT4MnGnQsV/pmkPU8pJiKThKkgD1U?=
 =?us-ascii?Q?WHc0IoOFudpGDNXjB+Yb05ip7f32i8EABkrnPf3T/15cikFhIenK6jdYASLC?=
 =?us-ascii?Q?6eua8JYR6QbrI2DXFZYcTZJtwriScDupDNq4hx/dNNdmUXmVvg8jRyQM4D3r?=
 =?us-ascii?Q?CQlFFLEvBj/AVmFrbWWZjH5uJHCb2P66q/PTftmJxdRN5Wq5Rggm3ELni/NG?=
 =?us-ascii?Q?pY+U+3H3MQjSV0up/b+vj5Sr7RVO/zMn57jKXzWYAm6rSxRNLsldKhy7mV+O?=
 =?us-ascii?Q?kTmH3FEfeFp65tcM3YCukNwdVFyNQApyX7897Noe+B9bXkTDOpNyhrjje/lw?=
 =?us-ascii?Q?BWIlH/liNQQP6Vqdw1IXQWA+EFuo3SfNgiyTzcd8czKR8mfvP2Grsd4yJeZM?=
 =?us-ascii?Q?I836U0+MDRV4PjXYGye5zLOY9IHhsaLgw+A3QnThOT/vEWTBxXKs5BkiZ0zK?=
 =?us-ascii?Q?fW4oa93ZPRH42c9+3btVg+VeZKtc8UShZqUt79h+iNUZ2kmihr7IjgH7sGpR?=
 =?us-ascii?Q?ZQx/uMzMgzTm3kqxtCw6q2bM97yGj95kc7lmX3PH4jMWT8myvKrmLpgM1Eyj?=
 =?us-ascii?Q?a1xhYTabDpF/174ps99NDsdrn1YMac0I2Ffhz9Y/gAfuRj5bIZDKneH7JKaF?=
 =?us-ascii?Q?CzgFxdKOqw4Eqgv4Pw/UC4fAwkGxPXgTIaOlyxo49njpGLC/S6uZncJTK2MQ?=
 =?us-ascii?Q?lTpyeNSm0wwuCyup9O4u9As7dP383uagar0LghPoGLAZcRnZD6ehKIMMFYie?=
 =?us-ascii?Q?9sBDOxuoJUPqH4G9A8Tp2Hjdy3/0eHL0mnoYQrz6w2kytCuuGbTUBv4r5Vz2?=
 =?us-ascii?Q?SHIPwW03Dv+8XKNnXE7x8P4OVSP9Paba0ZxlW7c7+MPE25eGeTvOhx15KsPg?=
 =?us-ascii?Q?pDQ8xlpb5YcSrwZnQ8x0rCqbLlYy/UJ3aeF+j3yRUoqmIFOsxkbun5MH77LK?=
 =?us-ascii?Q?Fn5Df89I0D0azUUqo1Ta245Z9YjwNjOf29weXdIseHy0o5FBV6UNAMgCEqu0?=
 =?us-ascii?Q?3gYIMA5GvOrQ+SnamBpukXKWWeqTdcndaXH/HP56GOfKLgRxaIV7K4AX1fVh?=
 =?us-ascii?Q?wqX46cT6Y9F42UctLnYG9gSPezuvVRPwQ/I917hxy+2EV8Nvi8XMotXjaVoq?=
 =?us-ascii?Q?dNJCy1AfdaaFl7TxJCjJEwWWcTbsFiMxxGjpZOaY37ywIF/HI7AWsYzghPPT?=
 =?us-ascii?Q?Y8zlg/lXxhXw8ghr9ZB/CasutfMeed6eW1ayB17vAOmhiNJxXk9HZDMuVVxQ?=
 =?us-ascii?Q?SwNWK6UfnQTtbdiUjOlDe01aOXR7IOZrY0BDq9/2GYXP9l92nOSISZHTUPby?=
 =?us-ascii?Q?g/uJzfKh2zyMgkwlyP7ZajHzdq5n/0nDypPvsLuPX1L57y345yKzG8pVIWLv?=
 =?us-ascii?Q?+hT1Qp63+cnuuXZ2ZlzuRyzFmQBKgYZoHojzHamxhB+AITCPzKzo8e3ZMdOd?=
 =?us-ascii?Q?+STJvn58hp81hZY+g9hUxxlJbYnw92LESYyuQKZLF9Ql+ssKNwiU/aWYdCJ9?=
 =?us-ascii?Q?rCqNJD0vNl5URSBrIGQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TjX11YBEqUJeK4BvbRyXnfYtrD6eThZkAKGVlKylxeTGHpV/YPqN5EN5okWP?=
 =?us-ascii?Q?yvxnKSv8WZlEtc06ANEZ/KiTU3S+UvJrkxPX2oS41Ku9DF0g/4wazeLNLDGk?=
 =?us-ascii?Q?PalnYcIhUEqZBdudUQDcvxC1TjoakxBye+ionH4bmX3broxLccOZ1xFkJnKg?=
 =?us-ascii?Q?J6FeH0xtlVWBTBOHuQDJNTjjuAVezAVmYon6oVpvjGf63nKPseUphXF/Yzf+?=
 =?us-ascii?Q?lRgQ28Q+wK7sBMIEVKkwrMdKmo+BtfltSos1jvYS5ixp1OwrTXtg0N+qYtKi?=
 =?us-ascii?Q?H0I/NYDcjKCtzKXurJ4fneGlcaK4e6EhZdFUa55xgOMjqkymY9lEQAkx5MVw?=
 =?us-ascii?Q?u10ZmfEQBr0NOT2kyBNJjGuj0cfmLqAcwCOZbOS1hB1p7jsNjw1vhSB4aW0g?=
 =?us-ascii?Q?w6kCwRwG2XO3gYOryXARB95mw5N7TZVsLKqBQNejQ3ix9U5YxtOPWC5xmy8B?=
 =?us-ascii?Q?Sj20lR1h4Bm9tK1Uj8UFQcssHutbqEXVQYnrlZtwC89b1GEHJ8ajQWYzTlbv?=
 =?us-ascii?Q?5ySNiUJQqcWT/rmRLtfMO2khoy1Hklt0AB0eItXTdFefY2gVX7NsoK5Uh+IW?=
 =?us-ascii?Q?qtepmk0uWmA9SIH11GPjFA6RsMNDOx4Y746PoH7XBBApQ2z4cgs+4sCcFOCv?=
 =?us-ascii?Q?Fym8GJVBkpsaJWiwrNlHAV+tAXTbI9zTengARSlc39yUn19Ubv/X7mxfuMcQ?=
 =?us-ascii?Q?8qC4STo3/mZrJ9GKyoVnvq/kR5fN71DrUAyKjpy/WpjY/Yk9BaT4HMY3Myzm?=
 =?us-ascii?Q?ERs+65X2OJwAaE3+VSF+JBs8px2doJHnxfYj72UzIozd9vsh1oNbSBtIiiJJ?=
 =?us-ascii?Q?HHbARytUAHbnCCyWX7de6IZzFtKssjaBKaSVM/k1xUlSXlz16Dz5icffRXcq?=
 =?us-ascii?Q?90gcxyiBF4PLRuRo40GzDTm8gLDZtG1QNdEROGFUmreaDJ5V2Jzmc1ckb5yL?=
 =?us-ascii?Q?TpV5wkF1OVtRVBNmdOWxEvyNyr1mBPtcxVr7pTDwqb5gy9rS/mSyV4rmoUrq?=
 =?us-ascii?Q?j9huTq4cJXe2OwDXbrb9pG0cQiBpJRE++5zDcT2XW3ogxN0UK9R11UGvfU/J?=
 =?us-ascii?Q?SZ7m1/kQUf75Q6YPd353Ut3o+mRVmwKfG4KFMoABwZTzpWEbXWmZd8dL94gr?=
 =?us-ascii?Q?LcKq+wbCAN7y9dX9hiHotRvTDDQbnrzyl3Gzr8PYqY19s605LaCwDCqZTMUA?=
 =?us-ascii?Q?o9RJ7dZcibcD3cEAkQf0W+U9DW4+6fmQiKh+fg4SwlxD19fTdCR2Rup4DbOj?=
 =?us-ascii?Q?E9/shB0FyRJs5jpur1e04Bl6vQans1yiekNOrLqC0pZ5pGL8GDA6ko29YAkI?=
 =?us-ascii?Q?0xMvy5DcUpgqpRu/UKLjQPhU/BOY0R5yvHt2BoxDi8P4ibTBv+KG41OZrn3I?=
 =?us-ascii?Q?+ko6d8RomLMULwGOzdD1SpJDtdtj05rwHhVqJ6TbQe2sOyNEGTUOOZeukuSq?=
 =?us-ascii?Q?8dq0hnKiWhFSovtAlEjardnvrLUmRxi10O61i8HCgK2OZWPSJ8x5RRCk94r6?=
 =?us-ascii?Q?ipRPrLPpBvnqVDxPRWrBydErLT+ywajiecsxyfeBhsqZ2Yqi6JhED7pv1Rhd?=
 =?us-ascii?Q?7VIwHzqNSAMNQ5BobdMxgfiW5k8ojc+dAlrvkmPhpO/TRiTU7dUcVh/5mvda?=
 =?us-ascii?Q?Pxus6cQuTCgB4UGIsTSgiqMciOk41zIu/3RqSd24LzlfYkyI4UfG10ABZBQ0?=
 =?us-ascii?Q?SvNXpI6uhalu0lDNQRiIUl2RJcczS+82nRvdBD9Ff+5Y2J7hCJxRz2u/0xZ5?=
 =?us-ascii?Q?rOO79C5ZDSR8HQSy86kgKWKdr6frwrM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98197081-a31d-42fc-3b9c-08de6f996ac6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:29:44.7088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3QFa0jwGYzUtBarrQcEBnPb3M0ypGKeGusEYQamg3xr9sx/P2JBEE9cFw9rwTmt9o8upjvLPWP9kH903FilsVWSdSeEd5hsgNDB8WvmtZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
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

On Thu, Feb 19, 2026 at 10:22:24AM +0100, Burakov, Anatoly wrote:
> On 2/16/2026 6:27 PM, Bruce Richardson wrote:
> > On Fri, Feb 13, 2026 at 10:26:31AM +0000, Anatoly Burakov wrote:
> > > Currently, when adding or deleting MAC addresses, we are using
> > > rte_zmalloc followed by an immediate rte_free. This is not needed as this
> > > memory is not being stored anywhere, so replace it with regular
> > > malloc/free.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >   drivers/net/intel/iavf/iavf_vchnl.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> > > index 55986ef909..19dce17612 100644
> > > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > > @@ -1402,7 +1402,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
> > >   			}
> > >   		}
> > > -		list = rte_zmalloc("iavf_del_mac_buffer", len, 0);
> > > +		list = calloc(1, len);
> > 
> > Given the loop above has a threshold set for IAVF_AQ_BUF_SZ, maybe a static
> > buffer of that fixed size might be better?
> 
> That size is 4 kilobytes, so I agree that we can use one buffer rather than
> constantly allocating/deallocating things, it'll still have to be
> dynamically allocated.
>
I still would use a stack variable myself. 4k really isn't that big
nowadays.

/Bruce
