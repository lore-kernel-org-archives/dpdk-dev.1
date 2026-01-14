Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213FAD38FEA
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:01:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09AF2406B4;
	Wed, 14 Jan 2026 18:01:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 47F3D4064E;
 Wed, 14 Jan 2026 18:01:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768410077; x=1799946077;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/t4nbrLg7+nQrsTkueBNsWp/VRwFBgpxqA/avkYtH8g=;
 b=LDR3/rYK/4/AQ8VXR0uPL95bgaB0z+/DjNz0vgRfKlr5wbsH3EOLKXyd
 jjFPWYTczZEKLD2qwSL5vNu+/SQoRabIeNNgLnERMOlJsd/TUtfiq/6qt
 4M9QKnbA4a1R1p2m1Rwn8n681Oc+eW+Xklf0DdzdDGqBVQg3ke8GP6UWo
 uuJT3eWYkUr9XIKgJWLlhjJ0EQU2489vAC1eygp2jibSjLe/TE6Pkjdk7
 6f6xNsgQ5uvN4Zld8SwhtSOG0fsXLIFgFD4gM0wEaOg/G0ApKzZTcUTXi
 uUXZkMpkrLLWxRvMzndnM26ARRot4oE2hyXzanUW9hW6TR9Ex0cKc/zLM g==;
X-CSE-ConnectionGUID: s4/xoNbISHuWy/4ebG3BLg==
X-CSE-MsgGUID: 4/KlJYT7QT+oxYrhxj/BMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87293090"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="87293090"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 09:01:15 -0800
X-CSE-ConnectionGUID: JPTBTpbOQ86479miW/6aiQ==
X-CSE-MsgGUID: du0eCzfGRXq+HdQhBv6Yyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="227855678"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 09:01:15 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:01:14 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 09:01:14 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:01:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSgZxYgdDC5Fxk4xMnmC1h2nC1RMsVw+Cutl7GeWYgi6rJUG668Ww6hkjAtwEGO6WFfhXJ8neM0DmW2vJyARUPzzyvYTCCssyNMGps8+RD78wb9WREKuMaXuI1fsZQguWvd0nXoSK/lPFMeG6cPbQI0+Kki6MvL8l3xWMaYoLNp7JqaU0ls2JiyQ/kWAngZLYWx8voKEWkZedAmeaVCpDBCKDuFVPvG6/t4GhgZvrdeGH9aV5ozPwnrbQrqR4O35+TN67hWcCILD6RAw0rXDUnBw5vwr5GEZTMTvhvqqin3JMGN4G92WewwG/ZQB31Iww2bgFpNout5eCJjrfGUPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlA0apgveeC3HxE6TaiB+9nonpmd5J0abezNjQsiug8=;
 b=CQ5WV+Xr5DK2c3op4U4LaIsdRzhbC1XHinkfoWdhBJIU5MD0SBOXRLTXhsa3JFYy/Dg3FcsOfw5qUKNzqJgCMk0bGkEPUCVYLjvFDqAk3oUBwyq1NCE+BoAoh6A8abCepKP3HJDjI3LYX3q+voc1E2UHhWans8PmVqdS9wB3bq2R4/4kj9lSBjejcbVZAUrgOpSeaQiwWt3JQSDeV0iLFfpioUNwBd9KP6vI4wofmApVWr/02XFGJHmLQM7Mq4stXRu+asGIp3SZAIlfR+iG5YnLy6R7Ylv6XSfPFEjhTJPteBGQZAjeC/p1803TWmToVaVYiCK+ItcIV8OJ+f8zWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9061.namprd11.prod.outlook.com (2603:10b6:208:57c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:01:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:01:12 +0000
Date: Wed, 14 Jan 2026 17:01:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <techboard@dpdk.org>
Subject: Re: mbuf fast-free requirements analysis
Message-ID: <aWfL0un-qWa1vGCT@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 304024ad-be7d-4cf4-b01d-08de538e8523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LsqHq7lytrmMdBRYj68wUspcAc+jwNnd+tWS2fs/ZhTsDv7+YomVSNCAck?=
 =?iso-8859-1?Q?TsQ/p/Uss+MLWAPqz/fYFEe7RU03DVYJo43UztIU6YvL2T2isWu6rQDk/G?=
 =?iso-8859-1?Q?dP/gKjv19cUoKpPYYxbqwDdhjhtBZvIOEJjMtvVn1bA6t171p+ZmsHOG+v?=
 =?iso-8859-1?Q?qzIw4BEST+b0CUwz0iQKBnuKqG3cS1UMogLwkk5mFtV/4Ab2I5j2IFchzE?=
 =?iso-8859-1?Q?vkB6lCbK4uJz7KY2Ik6i9pAL6RRLWU9b15Zwsu299f0WGqTaXgoW1XT7no?=
 =?iso-8859-1?Q?kinjBJKOJvxBiY9sq4QDIxNTn/FisyJryCfuUFPIALurXYIhC3pMAp/nx8?=
 =?iso-8859-1?Q?BHjwuFkaKdb3CDzYNOEMBFb3uYzfNBIozh0PxeZZ6MWRfzxKWgjNkbbb2v?=
 =?iso-8859-1?Q?C5LIOsX9iazRz2ClpYGO/8xUZlaLeiDrPri3dAlssoNR5uU6rGN/QK4MID?=
 =?iso-8859-1?Q?XkTpj3ncl9XhPXdHqV7PnC1qet226Er0vlK+pa4qpqr3P3hFiDUKHtGLcT?=
 =?iso-8859-1?Q?JQOkuX59UT+o4hTZ3wzKlz3h5TXXWdwan+nkifFNhNwsDPdk8GOAQ9ZF7U?=
 =?iso-8859-1?Q?YYO4NFE4NgOifOZWcSLQe/DdYHltWQ8AD8FmDjae1PW9xW9v7WMSBkIsd8?=
 =?iso-8859-1?Q?53DkpmObt0aaGEcNABkcIx4T5ZqYE0rkLakz9zzjeVgSVTArp38aIzL41i?=
 =?iso-8859-1?Q?3ywM2bX4VtNZsayLqX/OnEDAKepsNDjQtP+mFuqMrZPbVgbv9m2dHCVus0?=
 =?iso-8859-1?Q?6p+O3i677KaTbBKc93eV8Q2usWtXUXJfjo/zOoeu7bMVra2wHdFh3sNFAe?=
 =?iso-8859-1?Q?doA8ZuPmcbPbpkt+5YPMDbh4UpN7MOIooED5nh6L30RBHwBm2prNH8OFTU?=
 =?iso-8859-1?Q?xHimmuXi7Utf8SwRtQIRhpYdSmp6nSvk49oKVF0ml4epVwjSGQwzuz9daF?=
 =?iso-8859-1?Q?pP4mhcpKihaKuXSnAbHALf75oYATCwq6tv14C0oud7KWsUDn9WZOSOAHBD?=
 =?iso-8859-1?Q?7q1Pi0U8DcpDur2f01S6sgWqj1czf6wlS3UTfaFb49NVJZSU1RQzw/Uaph?=
 =?iso-8859-1?Q?FMqO88N6MN3QnMooqYWyXWGB7JZjJydUnsz8qB7EpLu1iYX8MQoVoUPttw?=
 =?iso-8859-1?Q?KIKlnjYkanzaBNworcZvG+UnCiCLrrqdwC3TxMsLCKA1eAsFBM06GXHQ+4?=
 =?iso-8859-1?Q?aXppc8FpkUyAX3SG0l6plc5McoIu0hByUJ69WnDP2n0ioM7QzaZh4Hogd4?=
 =?iso-8859-1?Q?VeqxmIuXEmtPhYJBV9wtpmDjGlClmSBor6vDQT0K6u4AE7nuAxhJqxJX0r?=
 =?iso-8859-1?Q?5/KoFbwKbB1id+gZwBPJyQfmJpBhFswLAvXTtlv3paZfcE8ZMCM6QVyC5w?=
 =?iso-8859-1?Q?7f7dCfXDEVM8/Euww7OmVXHCRA02EKjagxiebUZEqSmFjhk3Kmwyj7kPgO?=
 =?iso-8859-1?Q?bh0i9YY2ovA5IKacasvA+wb4/ZMyzT1WE5IVg0CqvC8IcAZmW7oJbGraTl?=
 =?iso-8859-1?Q?yOI+U3bXRgbYnYOqiSfsVGNxxehhOUvy6ehcEUSRQEZt+35muGqMb1rUCj?=
 =?iso-8859-1?Q?2GdNcMBR9LF0u4sOCR+gPI1Bvd6KwCI0ljqQoZMXGdut6pNiTE2EIwrua/?=
 =?iso-8859-1?Q?80ctJO1WQUAZE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?K1YHDC9cIsToMF+EKgVMpQIj0R/ntR1+VVG2raS5nf+gQDrR6Xf9vFwWD8?=
 =?iso-8859-1?Q?ZWiCkrlJ9lH0llDiIVp/MTh75yvwjxr5rx7CdUpoCjptIu98tU2TanuM12?=
 =?iso-8859-1?Q?gstf2dVsgeIljIx5qzy0Hf1VWyMw9n+tvOSTisjz26aya0xqTHBKLjMs96?=
 =?iso-8859-1?Q?jZm7c3/uKl4Lk7fgfAT84ASHGPTS+7YqYqlLC4S8qwNMQNoyL6SJ30OnM/?=
 =?iso-8859-1?Q?rdkNUCP1ktJF+hUB6tgZxbOF8HhMrXK9I2Pb+BEA1n3vzVFtSnGDaCMG29?=
 =?iso-8859-1?Q?PYoVU1R8zfz7rsADFTsuvJxwLNrdrus+2xFYaH2kuok0gTSWfTsds/7/JY?=
 =?iso-8859-1?Q?xXDe03e6GpiLZIDSqjNs4/XZmyaxOd6jGdW+BzXnfLKbnTQzRe6xE5BFSX?=
 =?iso-8859-1?Q?ahYhajWcTsz1dtvgh8iQ7Dn6axknx5t0HpdTx/o5CLiidWltJDFgf3aRY5?=
 =?iso-8859-1?Q?1woZ/DZeuJP2IkAXu3cu45SBoKFJnYTe13CrxZPUEm9t9BzZnLQkmpHD4T?=
 =?iso-8859-1?Q?sSA7lQf4Tv6vX2yv3q7tWWEZWr/w9vrO9sYgUiXJ+OrDghd42J1TZgmcRK?=
 =?iso-8859-1?Q?YYTbdyxLhKZ3z8FJi8JGcO+OIgPepNwHBT6TTY6N7hiGo3TCQgMutFgV0h?=
 =?iso-8859-1?Q?8ZVP9r6BPL1HU3fvhu1/ok/U6HdoH6WnIbwDIQE0YJNZYoZOv1URmzxM8G?=
 =?iso-8859-1?Q?abQR/Sitfl/LCee/Y6DlZqp89agRLHMr6dpMSX6rsjhPhGLA6BNiFyaJF1?=
 =?iso-8859-1?Q?8V2KAcBfGON5YjZOK6w8Tyf8KK0MGHk0zyVU3bQyTaPuHptIHG+iHyY95Z?=
 =?iso-8859-1?Q?7K6HzUhFaZw0DkDKg6b51UdXhzEIGO2IGq5L5bU0B1W2RK1man9UI5wnRT?=
 =?iso-8859-1?Q?a/QXhwCAi3rMF5L7/0eYUFvQMD0sjCjeETSUtQIDMUlzryUWVvDcsr0ZXU?=
 =?iso-8859-1?Q?iNdJabFslj1x2C/YUnYQJHNW1EbqUpVmMVxoA+NSnw/d/qUDE7n25ZYinD?=
 =?iso-8859-1?Q?ndVCXYm+uaLcA8IKCzs6+KOhOq88Sq8lcM+N3UnSiXZSJSU0CWPlZnVqcb?=
 =?iso-8859-1?Q?kI9CSgNRGeKTTYox3CW37wSpbycjqndj3OwwTU6zWylyqZSD0uGD69CTn1?=
 =?iso-8859-1?Q?5vF+qOBk4hHvpulanb3QGyN1cFo0xKsZUkQroFoSlXmKqsGJVn+iNU8eUn?=
 =?iso-8859-1?Q?NN3H0MHbZljNOLRIaCJW/UMf0p7+KAkN1iZRhvDmkOA4ysfkBeJAIrDtp2?=
 =?iso-8859-1?Q?tIA2RARaSowSFJzD8oC2CJAFI0wVWZTLhFKAHfGDETvlZHNqJTiUH4Dq42?=
 =?iso-8859-1?Q?WHmgMkP+fcTlMkO5slRhfs95tcErfyAfhMIe+ZrWLl1BbEHW85TnFIJg7x?=
 =?iso-8859-1?Q?4brAg5DtpqTc3DXKFelumUYe0+nOiNlAOzkyqlDqSa0VwT1YNWjWDWT2PA?=
 =?iso-8859-1?Q?jSaa71Lm8A6RIYFpVPpbFLXZcu6AJgKT/KK3zdWab018zXp+m8NNHdZihg?=
 =?iso-8859-1?Q?TkJP+kJ+PCySnuk4eYaEXEFvndn6QSwSPt52sm/wX7iw9Nb+H6MYwDS/Sx?=
 =?iso-8859-1?Q?BKDEb4sNU1VOEur/3ZzbctL9Mkwq3pMdoNyt0LrQk33fxQnNvPO/QGu0ma?=
 =?iso-8859-1?Q?SP5crHJ29ew7wxLzKSfc0crtCwNxN+hDwz2r3OCv6Tt8bmNs1xdJE5AbIf?=
 =?iso-8859-1?Q?WA2JANWuot7vm0Rq/yB2QLpwFCMHXTE50q43JGwCgEs8mqFg922wm+7zA6?=
 =?iso-8859-1?Q?wkVjmD04dQCYcJbHeFUuGgO91wUUTxeeXR6I0vTa9UxDmourFfx6GWtsCf?=
 =?iso-8859-1?Q?8qIxwJNMsYwY7pqOpFf7EDoLYzYgt9Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 304024ad-be7d-4cf4-b01d-08de538e8523
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:01:11.9759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWylKkR5wO60RaIdQejgNLg60Tmz9+b6VIjT5lAKrosXBk2dZ7CL2znm6ewghkeJZCOpjgIuRjb3rKrk+lRxHVb14TkmkHUGAdR4NrRARjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9061
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

On Mon, Dec 15, 2025 at 12:06:38PM +0100, Morten Brørup wrote:
> Executive Summary:
> 
> My analysis shows that the mbuf library is not a barrier for fast-freeing
> segmented packet mbufs, and thus fast-free of jumbo frames is possible.
> 
> 
> Detailed Analysis:
> 
> The purpose of the mbuf fast-free Tx optimization is to reduce
> rte_pktmbuf_free_seg() to something much simpler in the ethdev drivers, by
> eliminating the code path related to indirect mbufs.
> Optimally, we want to simplify the ethdev driver's function that frees the
> transmitted mbufs, so it can free them directly to their mempool without
> accessing the mbufs themselves.
> 
> If the driver cannot access the mbuf itself, it cannot determine which
> mempool it belongs to.
> We don't want the driver to access every mbuf being freed; but if all
> mbufs of a Tx queue belong to the same mempool, the driver can determine
> which mempool by looking into just one of the mbufs.
> 

<snip>

> 
> If I'm not mistaken, the mbuf library is not a barrier for fast-freeing
> segmented packet mbufs, and thus fast-free of jumbo frames is possible.
> 
> We need a driver developer to confirm that my suggested approach -
> resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> preparing the Tx descriptor - is viable.
> 

Just to make sure I understand things correctly here, the suggestion to
prototype is:

- When FAST_FREE flag is set:
  - reset the m->nb_segs and m->next fields (if necessary) when accessing
    the mbuf to write the descriptor
  - skip calling pre-free seg on cleanup and instead
  - just free all buffers directly to the mempool

Is that correct?

/Bruce
