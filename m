Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07815C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 16:40:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C39B402DC;
	Wed, 14 May 2025 18:40:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 08B5D402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 18:40:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747240806; x=1778776806;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=i9EL8AP8N7oZieGOS7vdEDhyhINd+WMVzenP4TTGPd0=;
 b=luyrdWRFB9EntPjjhKNn2VAZDNllcHJ+GIrZt+01zA6fDTfCVTbd5an+
 TqKWSt8oheG2nDne9WJRD8+iVQqM+okSFIFdhthGRYSvXoaIHWUqfOdT6
 F6o+arf/QkpgDaq3eKqsWdRZaG4peNvVz2zRnkFTcZPm0DUxqgTwqMn+i
 tmSBBZyG/QdX802o8F9VpyE2VunkaYle/gzhZe1Ydqy/NGR2PMeoxpj5k
 i81uQtYjTHItVFTQHTBmaTjclhzlmSdTBwSe9sGinvSRaRWQmdWZiEeqr
 0JS7DEaW8cxFWqoyzzBIZTxxjMz//qVS2ox/ZZrwO7P8EHj61yNWp1aOc w==;
X-CSE-ConnectionGUID: b65bzWFiSZ2KEKkCr2vAfw==
X-CSE-MsgGUID: XrWgNIheThaBUgDWskL/oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66706044"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="66706044"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:40:05 -0700
X-CSE-ConnectionGUID: IcJNSnmSTqinwnqt5+KjDA==
X-CSE-MsgGUID: SSPw5jv+TgCNFarNs8FQTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="139095982"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:40:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 09:40:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 09:40:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 09:40:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6G2YC1C7IckhyLCrTZm+ruufPozd7l3i5/I5eFhzFbWQBQjYd+Zre1WbwfDFxM1T5Qkpt9u9S6jnfsslm5g4H8FhCpa2K+Rs2St3Dv7VHZLhFISon65J0Hg9jd9ju8fxiiyJXAeGM0J/lnLhJle5SYFMLT55MBa6kr0IZ0UqSmVXZ6I5paE0h38BhEvu0EoSvoZf0cxYElcqbQL7fnK17ODGfq41tOemWpC+51y3zZQq+n2dklTp1zwrgNtqd4yL1y1hf+qDDT0QynaWqg9N5oEb+Ac5XrlWDWOB3hV+Pv3YdOIk8O+3sdoaMTJQ2hdD4R0gsmvJbCBTl0YiJpvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58qUXFhWEcJFYloJyhEpJwCv9fBdiSh9XD1CY6bg2Hc=;
 b=t/5kbVNL/pl/D51cOAwHHm6fsKpclhatxbwFC3FPd7Idnk8f5xODMBtmxSVXzPggV6thgXiUcos2O4i8tGfkgZWp/ZNZxlY9IC0RggTROWl/fYrFNYDFlKzHhDlkq2d9JO/cflTB3sgloFg06pFuiRCgU5+Bh6Yw33m5f4ahJ5+oxaNrB3NN077qyFQLumRsAlPytTTZ2dovAGOoqXMFnC/W7n29n2d9j3YY34fXRuWZi5vzfIFFX5kJ0s+497LANAgRRGNAdlQOK5kWM5zC4Ryc++tPEjUX/LbxCz4KMSv2hj0QTrl3oWNV5YYn3f9A4wxQbADpINnmyCrHWkTjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 16:39:20 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:39:20 +0000
Date: Wed, 14 May 2025 17:39:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Ian
 Stokes" <ian.stokes@intel.com>
Subject: Re: [PATCH v3 02/13] net/iavf: make IPsec stats dynamically allocated
Message-ID: <aCTHMq4HKQn1hGl9@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <e3d7db911f9d0d2e85102a14d2fec6333c3fe1e4.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3d7db911f9d0d2e85102a14d2fec6333c3fe1e4.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0177.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::26) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b659d953-c546-4b26-966e-08dd9305e01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oLfnk7u940/6N8Z3z3lRcKnRQQkxKoW49oJ5LO+YHQEh9/zWEUCI94phBJlG?=
 =?us-ascii?Q?36/5rqWpjGU3LOapF/t8dw8wq7KXUQJq95VUXwhenBPdCIhaZVvKNlNa/71Q?=
 =?us-ascii?Q?VWyOziPR/46FG2djS2YDJ7xlVbzpZ/L4143M9O5U+1b1N7JCjbhpFbKhB53y?=
 =?us-ascii?Q?Wgxe8Odq1KGLejGLQmdHl0LuSZEkZp/AwJ0VhqBSsZLme5toSROFMXI/sc0l?=
 =?us-ascii?Q?Mgjp6JtoHGxDf4YRGRRTxvDRr50GHA6cM1OjXIora8MI1A7uZ/Y4Oc2zaXmT?=
 =?us-ascii?Q?71KWvUZQ4+KD+eNF2/C1sxu4V4D1hLBmYqFox5I2885BcipgLOLEGcCKbrla?=
 =?us-ascii?Q?knQJBM5y0KlxRjYDckyVyjHpc04EkzZOjbMMWQNP+TaCJKxCuwTdOHr6bNF3?=
 =?us-ascii?Q?CcqBvjumjYu24sP98/6hJPlAHomSxFmXM0BIQtHfHEBQspxBcoI9SQDucCsU?=
 =?us-ascii?Q?VfxRIvI9h8a5+fYKaxI4zHLGEUoK/yRYo6/GteKhT2HLsX+fluDayzRZkzka?=
 =?us-ascii?Q?POnxWvIIdQe4bMIqsKynyHecy4oWLK5ORz8MVzVhbVL0LfEaZwSjsGBVDy3Q?=
 =?us-ascii?Q?0GBJi8UhyA9kN2wOl0ACs7B17FgeoRuiA8ftLylMsZoPFVxKFyEZvNvDMXSv?=
 =?us-ascii?Q?af2N8J4VhIR6At2xbwR8qgiiYe6wdKrIIS9zSaixVU69ZdvwTIl6Ydi3HyNo?=
 =?us-ascii?Q?D1QOvLbBgmvnm2KSZg8Z0EDCscPE3C22gJvU6UU4YwBGaeT1VXiN74QEEKDx?=
 =?us-ascii?Q?Bzgdyx6Yya7IHhop2SBsSSOcFNYVcFUKdcG+Ab72X5RchLTUlEh8ce2BFl8Z?=
 =?us-ascii?Q?SmxzCjFO5+n8MKuM9U6ydRMpgRg0OJxZh2HqlaWN0RmiLW8kpmid7lsl7Fj5?=
 =?us-ascii?Q?ge5k1DanN+UoNbHKnHugj3nxOPcgdwlvMSMqg7jvJTnoMjCQSNhUHrK/dFBa?=
 =?us-ascii?Q?e8crf9Iq/jJjNuEvcjfB7KlfElEuHg6SYOpzh+x35auA7ICY+XmlvtFHgLGy?=
 =?us-ascii?Q?e9AyFGX5qCPUmY9EUPvRdWPF5zom53cFv4mkxbl9Rf92nhDzEBpVZR7Bt7la?=
 =?us-ascii?Q?64e7p62X5kz06ISgibxbucSNzDTVxbUjLjTVrWglzdjyTAtc8P4XeT43xa2z?=
 =?us-ascii?Q?EYwbstlDzuXJDm5u5uO94agaOcOw7ezDpIK4yy1fnj9W+caSa50VLJKBwAqD?=
 =?us-ascii?Q?csYxTZFGOoN6jF7XfMDrfnScYXgD7pFSeuyxz2sSCGUQE+zEQJDq6KrcyFCz?=
 =?us-ascii?Q?CLNYfumLTT1qXJQs8ItVbTuyuULLypkRepAI4xpIgUiSld0J569qwjrnZzPL?=
 =?us-ascii?Q?KcYF09lyTNev8H/aSEY2b5wX2O9SjbSD/5Mzl+LYMGm4uCW1VzUJE0ADgrkZ?=
 =?us-ascii?Q?a/qaZjosOFLzO3u2ceah/66ljc/xfNm+fgQ4BmJn+j73o1YEeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/en/VhTIoTY3EoNWAARbcCu99RkX9gkGDop/zo3BLFligxO35bZ4rOobO0dh?=
 =?us-ascii?Q?MDP/OB1VhoGYGkjUxiq/k6IbvH+oLLk6DOAO9PY11dKyqiI1jTPinHvwMzgA?=
 =?us-ascii?Q?FWSlbeTI+g/Kb6k1E/ukZDk+xV7Xf52BXzBvJTGQBxaRXg8rF4bAX+P2elM3?=
 =?us-ascii?Q?7ZXwPiHqITd7hGuKy66H4N7WrC3lhw18xm4V/PJF3C1eaudfaylLCjTUsIDj?=
 =?us-ascii?Q?v/Lk0bJEGlvJVOhyG58xtGzJfGo1NSyriTAUAGlMBoos7hLowfD5lD+pwxPn?=
 =?us-ascii?Q?EIE6V0UDfD9QXbLcZegl8Ez9X8jJZfPYA7uxORyTMaNOiOuYDgWrLrP4POdF?=
 =?us-ascii?Q?vKuFTf03vJsw32pO+Z1Fg/t/s/nKtSvSS+ERvUEX8+hm5DhMc0AjkPbYRjH9?=
 =?us-ascii?Q?DcCjjmssjXnyXfBW2k+JBtagI6TMfm38VKyBOaHonn/3hLZIJfn5FEUY28e+?=
 =?us-ascii?Q?8x/mQyv8y2XPaAyNwv/n44yQ03eeDZVq6MC8peErO4City7/ueZOEggWUnwn?=
 =?us-ascii?Q?eWxL5N4GVCxmXTbQh7XpYkY60PKaHTe5Do54dpfO2N+4Dgu8yj30HV+NSdtV?=
 =?us-ascii?Q?noTJBUwZr/3zc12ZxZriI3LjSLxvCLC+Mi44fE+1Z3MecJY7tFIksZdTK+tm?=
 =?us-ascii?Q?u/uHKOsVCqfyiF7HU8Wqa3/MbCr45g3GTibBGLArTxAda1p4D3YMVdBSyoaU?=
 =?us-ascii?Q?VHWKlr0x3jQnT3POWAsVG75x7q6HsYpwVkL0EHlmbPVSWmEMs5OCbN4VJCKl?=
 =?us-ascii?Q?e8rkXOuuLKLL2NoEQywG6NWFj30k+7feU/WXT4Ex/9bBv04XO899J95eveyF?=
 =?us-ascii?Q?t4hHZKTpeSJwTy4h83iP92rl3XBr+iIStjlRzDbKwvLiOVv9LJzbm694WvuG?=
 =?us-ascii?Q?DX+SVkao6wAWpJApez7JdESywa+6Q/x6KQ3g7RUHEjY/ZkkfkBXK0zfwdUhL?=
 =?us-ascii?Q?hmFFyo/1TBM5UQDe8rZ0dUZcJ+MuxwXI07/+qJ6lVICb2mD7yJagVArDbagU?=
 =?us-ascii?Q?e5G/lFqmbesyuPMex6jwVF/2ERhpJY2belf7sLiQnSLqg/b4YNnlFrl2J6EP?=
 =?us-ascii?Q?8c8Ebp5Vwkx7PB7Eqgblo7CX5yY+bJpclm0PdoxvHhwgdQn3xqGB4DRRKELI?=
 =?us-ascii?Q?yVI8RbZ+XyR2XHdAh3f9GulcY4lFUQ+UIzFYvzGAZybmXAkNRQhTm5AvjBWL?=
 =?us-ascii?Q?5Ffp7ULVnTaJNpNl1KlbFpIrnqepDK4n/BVLCNrfGFrLNiMMkbvHSedkNkDP?=
 =?us-ascii?Q?yGvqvoJNxj340X2085TP7YDesK6VO9Rc6FvMiKCTt8eFgIb00EutFxWHEv1q?=
 =?us-ascii?Q?+HE/LHf/3/pTSK6qJenteRZ4tRD5gqWKgUGQ51TA76IXwhPbaQ7+i43s9fk+?=
 =?us-ascii?Q?6CLvYVcCnJqhpgfll+R7SVxd/uJj0u3zepr5dYvL0o1lY026rc/UjeSHgFOf?=
 =?us-ascii?Q?7Lzw/bQtFZET0Um6mvoQdBcwEvqBvN9n86ASb/1KAzwZOnBN5GAsRyqQBhPH?=
 =?us-ascii?Q?ZwUiWgoJtXMrw4mnZQwUHWWf+n2iXKa2WzfIh6KGoOZZLKemEPbV1FJ+A0HG?=
 =?us-ascii?Q?HZ7N5wm7mprNsShjKQfaMtCdSJqq9T6k5jxkCUMzP80/hKYiobHzlNMRRZGM?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b659d953-c546-4b26-966e-08dd9305e01a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 16:39:20.2042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKtPfoiyoKjV4rX3AOM22aFA1av7sAflGmwpaUB86XxGLUGa3YHK9qLlTTK8+2+RFScqWZ2SCSZmj7E6fyIEVvKu4/t+hdtTG5QMPkQiXOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
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

On Mon, May 12, 2025 at 01:54:28PM +0100, Anatoly Burakov wrote:
> Currently, the stats structure is directly embedded in the queue structure.
> We're about to move iavf driver to a common Rx queue structure, so we can't
> have driver-specific structures that aren't pointers, inside the common
> queue structure. To prepare, we replace direct embedding into the queue
> structure with a pointer to the stats structure.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c   | 21 ++++++++++++++++++---
>  drivers/net/intel/iavf/iavf_rxtx.h   |  2 +-
>  3 files changed, 20 insertions(+), 5 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


