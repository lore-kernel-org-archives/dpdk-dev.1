Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB6BCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EB9F40695;
	Mon,  5 Oct 2026 17:23:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0DCFA4028E
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791213780; x=1822749780;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=EzVgUtphoZa/BeGP711oODywUmHm4GXS1y2G1XYh0KU=;
 b=JGI08OeKqLPEt6JcMsWLfhELO477Wz8In1FRRxkIIUe7aWyQo1+FFnhe
 auv7oAP0T1+EtvkTnZMFvLQCF5gCjhB7B+pvkMWcKm45lNdXF466h/MVr
 wvxTyheKl23jzf72mKjZIrkqIzkbIbVJ8Yf+Mw0Qo+4eK5VgU3ALCy7hc
 taL1IAYWgyoidDNuOvsPLOK2r/aIAI8lTGiS41Sg56xnbleHutlYerFox
 AeuS9KUtrcaL8/f1pROXXaSQXNBtY/QGg+/3LA2PYA6TkdGTr8Pqk2QTl
 Xcvyf4c20T1as+WxJH3PlX+HbB0upPTzr34DLVkOw7Kw+QCiQ4JThq3jb w==;
X-CSE-ConnectionGUID: rPP2BN6ITcOjZSVK2Z12iA==
X-CSE-MsgGUID: ohKmSzOySPm3Ari5BsLLcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94376894"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="94376894"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:22:59 -0700
X-CSE-ConnectionGUID: nP2jyiHITVarVyp3Gfc9ZQ==
X-CSE-MsgGUID: A2+FcrJDSbq3KfNsaV2QQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="275492932"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:22:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:22:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:22:58 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMXIF0KeJA6dRWl2XcGK/A1r/4uxJ5qMxifcNT8Z2ARohVXm+QJDXrECWjRIANHbhL5pyaEGTSDoT09Rk256MBskO82/l78hkTv/HCY5OxcPIXVe+cS2BTnMlsDGuoEk9OxKfX8/egLXVsaSBTZHEQyNPTotB18rNXaLqwjUG3WurQX4JLvgU9Hso+sYk6EQ4b8Vdh+sxT7oDXCaMCDCb8Ct38Z2quYFw1isgfaPcMhAHd7VsC7C3AJkgPUiiyfsu1ND1TvyJ1HKG7XRoGItg5u4YSOAYpl36ZUeBR8V91MRs9Xx1bqYiKZx0EsJ5Po4gZwt9hnoypJUZAyZ3i6URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh7BPWlBcnjN8DKNPKDY2fz6dp3RHgHzqnMcPRpYx9Y=;
 b=UdbcG7ml5mYm8p0g6Qr6l0wDywCSNz6bKb93335WDkyAK/x+01kUOvttucOD6K7XMsmuP29oYCZqHkuQgxiDLBBlnjXUuRN/vYb1g5pqKAAIadcADRmiBkufOnUH7XY4NpJCxgYCuG1gfAayBBoYv97NxYRLBhGQdoAJ16XmtJrf46/kJ8eOex4wWILDt98Zfp5IUqTzhFtdSTBpaqc1qomB0Okm1pRe/dbxEDxWDyj54s0g4eDhAj3vWuD0F+FZ30Df5YhyyO22aGbfRzVnzB67u3r+Ia2p/tzk9KWusNddxfkN3OxJCv5VgApAP3m6ZruPUiGKHBAqWClYjf4CUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 15:22:52 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 5 Oct 2026
 15:22:51 +0000
Date: Mon, 5 Oct 2026 16:22:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel/common: avoid field pointer arithmetic
Message-ID: <asPAx9oaPF2GfJr1@bricha3-mobl1.ger.corp.intel.com>
References: <20260914100433.53971-1-naa@amicon.ru>
 <aqfZThcX6bbSqi35@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqfZThcX6bbSqi35@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0154.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6cf4c5-c312-44f1-6b93-08df22f4855d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: T/Pxe4HWsGciGmvwIM6cCAsznzzQs7a4a2YqzwQOu4qapA9/OtBBC1L3SV2MRVUNHbOQWKsDCxYnKauEPLFcMbfjkCCGGE25sgiyEGdk4r8WV9r/LpLXA4BArKqA/tWH++E7P/VtV/vvzGqqPTxZiAxevxZfkgnz1iIDp/9kFTHYSBwIeeTK/AE250ytQkyINTNOCKo5vOe+PJ3meuMl/7INIcKABq1TNf9Ls1N/RaRskr3tarDmJ3QrqyHWDjJgRA35E7n5cnMnim9rEj6Sak71yqZSM1TDX77PcvmI+tPlxUeLwC09geKpYUyQ4h+UA8Xz55NulWY3hBbpL1TAhCsGD5EwFKDaFdKvwF2MpWMo3xxYMXkzwJPN/piSbJZKaGaGC9+Ih/Jh7NLeuVMWNYZtFIKt7PVcG3Wx498cYBKbDqC6KmIV/7NJycezVo+WPBBprj1Ro1HT2YiOpT5BQJAgHoNK00Fd5rNuVk8MZzWAF47bUFu89HKAZC1wUyHa9jtuZRpCymNG7tW98IroFywdcbSSP/ldXbNyiT3bXRfKnGBf2/yEMzl96FMcG4ekzt7+as/NNJko4qWM922g649iW2Gv77CU7rGP3Z6eds8mJDdN4ePLgE1TQPXZM4czP6EMK5X+ukpGJns8TldV2qw8epiVE8xvru3EojZdsnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sK7hpQk9IqBxa4kVA2iZpqrS/p6hkJTWz1k2RTWLzYphftsmRlR5BlHVBXvZ?=
 =?us-ascii?Q?Y9Vo+LQsunFliIKNt/adc+moHJIvsy8OKbN3rT3UGASMYBLEPHAx4YObJeaq?=
 =?us-ascii?Q?8JfeE08dukZox+EvnGm9v2et+RvmcVrIB4lB59MoFz5TGe/YNsH3Er4L/OD6?=
 =?us-ascii?Q?0xkZGy4iB8brYfXabxZqby5vOIhlbvlBoI219WD0ScLJJNY95SPTLCR/Gjqc?=
 =?us-ascii?Q?naxcmsvWEdC3O2tg4NaFmyJ8iOulWZlARNCUutD//2weKKX5ab1eQsBXv8CW?=
 =?us-ascii?Q?T21Sq/DuXlxOFnSZsZl6XbUh/sQfnnlv/fHuniBDu/4IXtw7w8OXz848ey1b?=
 =?us-ascii?Q?dqcKRMFNfYSRwp8awLXfb7jiI1r4upXwVUl4LXZFBoQPdJg2jFaERUPZy/So?=
 =?us-ascii?Q?azn7BbzTyi0VwqwOSe8LUMRu5gqGkz7aVmlEpGFfJxR3zhmwmEpujPTUlZ7s?=
 =?us-ascii?Q?d+FXgfWV6B+yLqbGo9nVe0f9GGIzB+0SZFPXdVfqrAG72fcEGq+oTbuO6pnr?=
 =?us-ascii?Q?qNMvF9Bw2racn9bX9e6GkNC5ufT0XNqktJLjsHSMIGKSV5VuaIRVO/WSdetv?=
 =?us-ascii?Q?4r2GbNA9hYo9MmiQdppt3dwGrb9+mlTtuDEAjjCp4mUbJyelHz6a1N4MZFbc?=
 =?us-ascii?Q?aBU6yWpy2g+a//zn+E7Kz4bVCIfHwc1vDeCjGIrcUSLZ8wvjM+c7HMuYcV5d?=
 =?us-ascii?Q?waGzer+iXFqzi5ohKpHl68pyUINzBm8gVDxuSpfwhB1oVEpImbsFMnGREPf8?=
 =?us-ascii?Q?6hncMAc2ajlqp4zGD4SVNUdn1BoNb4i/dNG/5du2o9BbRBmIz6XQ9J9a+CKp?=
 =?us-ascii?Q?VEZpmkSzoCVlBXVsQn6Td8DgppbTWQe6Zp2jbhyyWq9C27fpgW/aAS8imyYH?=
 =?us-ascii?Q?kCZFyM4mc/cP1MP7U7i7HyMRRREwjvv6aUEgGUGGigtIahWihNiaPIXN0AEo?=
 =?us-ascii?Q?T7eZ/VaRJ5nXVulHVjpTDUUcY0Iv1sRdcmX6KnkFy+GLjxZggK7eBET4F3S1?=
 =?us-ascii?Q?1auDYlLAlYT7SklCmOtcaug9zojox4/rjleoir3OWNGuOKXwhAA9NvsdCIi4?=
 =?us-ascii?Q?KwoeLQ8KPcjONYUBJXaxQMqCwxmPONl+rK6J+QGWUp/E4wtgE/JC4JOcN3s2?=
 =?us-ascii?Q?tr+IRoYCFHStANF++08igi+NRK8CRkzdVdQUZEzX8K1QY+VbMhUGVGKNsbPh?=
 =?us-ascii?Q?rbcr06p9lZ+mTka4K/1Bw7iNpCn/3OoPk0zQJXAHtOzuWmOtL7XD+TuPPVWE?=
 =?us-ascii?Q?67wUyIVBC06TpOv8S2AMCkHX05FEWrsT+44TL8rE9yr9yIXNkhPWMVvwYmNG?=
 =?us-ascii?Q?GUD9plI7wBVBkFXamM2lAml/5rvL1rrLRpEOW0EqLMjh/VRGrrQ+DDARiK+O?=
 =?us-ascii?Q?gCAq4ml6QjRZSQs3zsxy99fPk3kOi7fhR6tt9QrarLtOZAn7oFzKI0mzTc7D?=
 =?us-ascii?Q?Akbj/fv85XuTiDM/dNRmpo4C5RyVAFTRALQJ+G9kbVe3e7q+31No/r55Opsl?=
 =?us-ascii?Q?v9xGHaMsw01aNvqdZrDLRu/HO/7l/bUK6e2uR4POWCQV57LH6nHFGJQqmDLX?=
 =?us-ascii?Q?YFn1E0U3gw9/MfgtA/fGWK355Y4uT5Kqkq73ZO9EpOhe96TqlH7LEuSsGWTA?=
 =?us-ascii?Q?xmv80lMoGFaUSdti2P+GON7+Xh3E0C0GsXT3qYyJ089WPgGam+E7pgZB5K7P?=
 =?us-ascii?Q?FKKdvW95s12wXet7TciSHXlOXdp0o/ZPkAqV6PSE4ww03dYftJwsj7yPkFgM?=
 =?us-ascii?Q?ceNWmgRovPXvRBNxjG3fmDyqeFjEfRU=3D?=
X-Exchange-RoutingPolicyChecked: jgmNw+Up2VeUMLNEwBIjCnjVGe16gaZkpaW2u3zOnILqlMzIHhgpNt4pViMo5Khn0NlhCKnkcc6EWx4UjQcdo1Yb9y1LSMB6mn6DOYNdrFqscviZmqAYT9RqlLRHHLhfMHsxvlzef/Zuu2RvrZtx5dc6hfiDDC8YIDDjBZPa7eJ0gtbu4V8RnMPxYA2Hc2Q5/HcN40gkOfvpeBpF5jspMYl4SZPpxUGbuwawwzAQOMMZQebX9pjgJhG/2HjBHWzxYPWHeZjYxX12Y84cwql/iXczVf3ZECQ0j6Rs1pl0fjFjk3V6wDlNLo7KAgyCtJvFlkgXMa5iFAwwkm8C+EWjVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6cf4c5-c312-44f1-6b93-08df22f4855d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:22:51.8622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9At7qv6ugP7gz1sn9m3u8uaELSaHXjnCMix21OQXEB5VdtphT+zH/igc4ArLlacTezR1PYDqVVO1zD4VB4RNXKpar3cjuVZ3F0vAyRNLZSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
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

On Mon, Sep 14, 2026 at 12:23:58PM +0100, Bruce Richardson wrote:
> On Mon, Sep 14, 2026 at 01:04:33PM +0300, Artem Novikov wrote:
> > The Rx rearm failure path assigns fake mbufs through rxp, but rxp is the
> > address of the mbuf field in a single software ring entry.
> > 
> > Use the software ring array for indexed access so pointer arithmetic is
> > done on struct ci_rx_entry instead of on the address of a field.
> > 
> > Fixes: 773cbaf2ad38 ("net/intel: avoid allocating from mempool directly")
> > Cc: stable@dpdk.org
> > Cc: bruce.richardson@intel.com
> > 
> > Signed-off-by: Artem Novikov <naa@amicon.ru>
> > ---
> >  drivers/net/intel/common/rx_vec_x86.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
> > index 8d497e7196..9670a21fa4 100644
> > --- a/drivers/net/intel/common/rx_vec_x86.h
> > +++ b/drivers/net/intel/common/rx_vec_x86.h
> > @@ -33,7 +33,7 @@ _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
> >  			const __m128i zero = _mm_setzero_si128();
> >  
> >  			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
> > -				rxp[i] = &rxq->fake_mbuf;
> > +				rxq->sw_ring[rxq->rxrearm_start + i].mbuf = &rxq->fake_mbuf;
> >  				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]), zero);
> >  			}
> 
> The existing code here is correct, because the SW ring elements are just 1
> mbuf in themselves. While the change you propose does make things "more
> correct" from a theoretical viewpoint, I would prefer to keep the existing
> code because it means that the assignments to both HW and SW ring are done
> similarly, by indexing into rxdp[i] and rxp[i].
> 
> /Bruce
>
Marking as rejected in patchwork 
