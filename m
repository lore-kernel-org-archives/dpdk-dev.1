Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545B606A335
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XzBHrFu5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0566A40B9B;
	Wed,  4 Nov 2026 18:52:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 4486B40281;
 Wed,  4 Nov 2026 18:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793814728; x=1825350728;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BHPX0uhIvbVY3dpEU2etDOKb5Tbr/NP6U6Ph/7EjMr0=;
 b=XzBHrFu5jKuTdy2YpoRsD0McEffPfvUskfZolb/U3n+tMo8FQ3EBTOja
 CefCHCqb37G0hEgcJm0R3AqWFniUI0dSnYYc2zj+ku7RN24hF0K479KK2
 CQNEfynwxzdGUd7RVdr/zZs00H+JPdtUzEzmAZlhZnQSct2haOeCnVZFL
 Ox1JpW6iKP5gXMYWCb0yeiHLbXuyWy7B0N7R89rMbOtjj5V0yUaeGZ+ug
 iDninkP7itQ+/oPrE4t3urWgB5RCOf2zHCjhpk6FvFVnAzWSIPAJgH04o
 9GSDbR1uTjPoHZwNOIYUGkulIRlLo+hJGUZ1RVSAGsLHH0EZbae8TOPSp Q==;
X-CSE-ConnectionGUID: XPjHS61OQV2cqnvj/+qwAg==
X-CSE-MsgGUID: XakkrHTaRdqhMZP9Es1BOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2575845"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2575845"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 09:52:06 -0800
X-CSE-ConnectionGUID: hnQzlrBDQzmpXUMRBaAvMw==
X-CSE-MsgGUID: qp5CZhhfQoGrr2csq34QBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6657945"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 09:52:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:52:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 09:52:05 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:52:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T95mkmS5YwehOIM1SgM3paLdAuuq1DXZix5Cwf2R39dsHpWUXzCuFfNjsbJ0Gc2Q4AHIb9amkzmQ/kP0WktjrPM9hUqiHeo2+zSi1jL8L1/gR5EYxgCArSXEL6+sALOSHkbE5eHU7/Am+Owez9cJOvzano4l1DeA17VfUbNhlMTeGzjg4vewmT17MiwOjNPCCgGIKQRjWUXDtcDwKmiFZgEWMQbar5KNpxZRoTRTCcCN8W+0cLfjt0TeSSc+ouFizBPIOkwnLcWXDtXOgcqw2N9zJq9CSRjylzszx32/zR7Ui3HLz8dCPEOX9rFJqSEMeCsyHfadSfjGrYVxjD1vRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elm5ziNj/UpewDJcKDwbDOpdagElrARyt4dJpC2mn1g=;
 b=SYmrClWuEjehv/xTfBtp4xlN5vVyI44R5MVCzYQr5FNASbuJsDk6YbnTZEHlmepM63joeCLRffzYZPdbCvuZFxicir6IXSP2RuSBLdgnCoqalqEZv2zTiO1hkr1zwmi93kTcmMsX5eN8iL5+sP3Wvd5FNRhLJc7ob6QLN4kqxrch5UNHnIvP74Krp9LfjaOW2qgGlgCNgIPOJCwBoDu+yC/o4+1EtjUm4GemCy1b/dgJsNQjzPb98jHjyxLqhSd/xXa+VyFFfQuU8oBRUOch2D3g0RsQn8MegGLPjENM33nL4iD+mHRq0kqi0Wmp5ia4FDNV78kouAIJ/Pht74UseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH4PR11MB704740.namprd11.prod.outlook.com (2603:10b6:610:51d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:52:04 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:52:03 +0000
Date: Wed, 4 Nov 2026 17:51:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/3] net/iavf: fix crash in Tx drain on PF reset
Message-ID: <autwv5TPa2cey85W@bricha3-mobl1.ger.corp.intel.com>
References: <20261104095510.10246-1-ciara.loftus@intel.com>
 <20261104095510.10246-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104095510.10246-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:10:110::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH4PR11MB704740:EE_
X-MS-Office365-Filtering-Correlation-Id: 63925756-e582-42cc-5cc6-08df3a9c55b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: /b1PuhFGmmuiiEpmNiQYKUml71vn/Jtk/8sCvw1ZeF1YWOiWZXxOwJqCbbGS03Frin6BqzokDxqELn3NLs9rD0pBLvdTUZpa1SODZEZjLG3LX3djPIXaiyGxJ4Ha+mGGOWMkKu2bwQhVrkIIN96IsnhM0pWcvNqLvX5wJLAlReZhhSqYz3oEIY55xK2jsMzXBVDmHvSmsJZh263KVFZkofSN0G50MxOxcS6BHQ3tdd7mzxo7D0nG53369kvR56XLP13kkIuIZxWGMVtYZjfu8X0iak1Py8WT5oIPQypg17XJDg753YLpXz88hr3ULCFIAKykGnm3Yx84PPubTqvIZT+hog8WnJA/6G+u2TZPPL+UOu/bppcKhDKq6MrDWIK0s6Qw+yJTqkYT6nvXXxvCnJaW3cNoEqqZgr4iFT/JO+6gbJpElHLl4oH6fOVBtJ4iphuRRZRG7i+vKY+yeZeD2TBHXF+B9Mz3tOgVQ9gb02brrOWRZzNt2cdP4oAlwxj8rnlcWLYaMG623elELTU+coRfR9b3jQYzYGQO1HoRUEYP48OpoKe8rOluMhj6z+No/XyocLyzLbjOyiU8FuKoOMpnQqr8R99Ao0Gqbs+vtsu5FPsR4/PB/LI8ll9zI2G/FNaEajKrDl59Hjjpv/tIVw0WOXiVwlURTHHx4aI35MU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8PLaOPrnO8SzMGiUEAtxaYlRSCHNmUu75S4WSQV7Y+P0AJSBUx/CH3K1p8T5?=
 =?us-ascii?Q?rWIGfYCHq6Vr7IHrrVpwM6S0/NoWznBFCV4KnkEpZGr4Ir1hfXvx/fjoeqm9?=
 =?us-ascii?Q?yqUwvcPQBne85RsdAXT49+yyepDl2vb3mDIRIpYvvpS1TxAc0lZu9tV+O/B8?=
 =?us-ascii?Q?o2b/4aUsJuo3wG+2CZXDjvf8N8m13O/GOFhpcFl5+vw4R2EUGK+HK4dJumux?=
 =?us-ascii?Q?Bypj8WZSUnUB+Zf7X0fV8usk9+MnBupkhs7iBig2N6cxWnCYy1Dlt4coSrtd?=
 =?us-ascii?Q?kv5gQGG1dA5u7K9Jt/aqVCDoDlwAvwUc70Wddlc72NPim+egUuN/tvkeaumP?=
 =?us-ascii?Q?7ScjA8G6jOmkOI28QNH1Mzhee8qkiBDqbmkzv7TouwP3Ys6wd+S7bHWTBl2A?=
 =?us-ascii?Q?IyTb/fAAJdFVlvr9/pfmK0HF+Jf3jl3OdOcrZpoPrCOY3mdaza+NvmEnOIku?=
 =?us-ascii?Q?2OH59Sg4w+cxbfQw4NdINYcXgq9XI/0RED607HB6LyW0UVSO+NHB0ini35Tn?=
 =?us-ascii?Q?i1EGwJbGEWBkIEZCA8x9ifcWoEE64eCl2zSLDw4SsB/2xxSp8ZKm9Ad2AD9i?=
 =?us-ascii?Q?CCKleBl5Ie8fdhd2Yp1x7foZtHryDyz/ORFRAT6SWrLqLkEurPaVpatnMlJj?=
 =?us-ascii?Q?hB5yQYOV0oiJILY0qAHOHFjkZQElxjsba0Dsy6rTcGV1Xl9otN8Ufg/qFgT/?=
 =?us-ascii?Q?2WFsfZ2qjibkRkmoZU1IPiY3/+7TTEhwonhWY+Ss/HOt79C1pxXcBa9tTajV?=
 =?us-ascii?Q?bw5UN7DxtF2uROIaq9SB8CWh1Nz4biKst6kMENvo3ZEGX57V4FjdSl/0UjHr?=
 =?us-ascii?Q?aUaGUI5BPuqF9DjTv1qIj27azI7zvfgm3MauudqfnRUBwjB6SC4jHgYzd5js?=
 =?us-ascii?Q?0Nn3G4t9X6rTiVwjxA4fw+H5xMaeeyi8cj6rgoqwDgVkE3ifcdk5luIeskUH?=
 =?us-ascii?Q?lsVISUG+Ct3zLB7D37ug+iQNIv7LFXb9dnpni5XiCvggkQbxH0ceIPCan3EU?=
 =?us-ascii?Q?jfnBVrOpmp0apM2TlozVOUUArK/e+4P7p9tmxqO9nr1T7WZt3Xed+GCOLDEY?=
 =?us-ascii?Q?17lorY9ew2T84GDW7SYhM3oYsfLCbmolz3LQ9q7bsK8QreYn3SIxEIib7Sp4?=
 =?us-ascii?Q?eapguXSvSLYYpRvetAMAVYXtT3iq1lCxDkWLL1Lfsiht9wrVlGQqnMQIxRf0?=
 =?us-ascii?Q?5d7Hjx11/bmRPG+0YZTxvbgsBukah2TfHFqN5gJey1V1TapF9edEeiM/7M4P?=
 =?us-ascii?Q?5uR5cc0zKotudSzEWpPF+9Dtu074ixr3LvRtforTBBu5HRe+ZH8ZRK4GUO3M?=
 =?us-ascii?Q?U9jppWkDE7nUC53huPjV+/OXWI5vEj5DCzIbejqH1uq7vboNvAKP9jwuVoT5?=
 =?us-ascii?Q?zlxby/YTpcTQ5wpoWDzVa5WOM+8m6ff39RCaMFVwgKY7LHPnL7+xipO+9bpj?=
 =?us-ascii?Q?ECHXZd29rfdG3CDpu/2mo4x0WrtFuhWlo77qYx4Nb8VhBoy5IsOglq1DHXWG?=
 =?us-ascii?Q?8d/gBID1XOqjDLdwfyTrPGdboDSWznKDJtzT24UyOUUi8VbKW/EsBLx5+EbO?=
 =?us-ascii?Q?+PcCM56kXFHx3i7vG5H3ffsbLtUKRDns5vomogcq5jwNJpCIydhF/OcpJQ4S?=
 =?us-ascii?Q?RO3GSQ+vve0xRuHB+QGcbzkligGpvibksfQ8qRSPeaMCW+hmxrRc7RM7+UkN?=
 =?us-ascii?Q?R14F0U1GNqo+k0p3Y03UofyCQRDeRX2dHflCDX4f3idAi13ElMxEXILd8ly2?=
 =?us-ascii?Q?O8k5V+1RHo7qnKTOd5BNu1XfnL4Vs6k=3D?=
X-Exchange-RoutingPolicyChecked: VLzGRxufNyPwvPFr15r98UMWe5HIoGS7b7ckwO1VqQfNrF7KpWqQ+6sMsopVylqGVauDrnvMPXqojKx+dWVr+SEVUcjD7WzSgBULAgeekmzv4+DCb30tULz1CMo8ykLz5Ly5kjObjBdJ4Wt5a35J9mvjQFvolJRyPSi2daEKfxBp1noKtB1GYNOJ6f3gfG9AW7EDto6qvgnxlPli9pxKaaI9K3e9hbEj8yo8o7UD8ccUqlxpVLhEDhK3f/Ca5ZuLXH1zOgOqXsl4cOl27qFkwevusdNLlvR6m7nHBLeLm6q0XpA6EmCcJgLKc+1LEtuVebfBOrY9yP0N2zVMGyu4qg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63925756-e582-42cc-5cc6-08df3a9c55b0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:52:03.8895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jcj0Fop5q59VVOxoYS8kGL1jMN0X6nKZymCJ4LVB3SGTzBiO+VfN+Sa3tDvDUJuy+jqWcnOKgnpVb0Qs80Nk2oKO+Mi6oc9X/nhRd8eUwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR11MB704740
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:55:07AM +0000, Ciara Loftus wrote:
> The Tx cleanup helpers check the DD bit of the descriptor at the next
> RS boundary and assume software has already posted it. The burst path
> guarantees this by only cleaning up when nb_tx_free drops below
> tx_free_thresh, but iavf_dev_tx_drain() called the helpers on any
> non-empty queue.
> 
> With fewer than tx_rs_thresh descriptors outstanding, that descriptor
> still held the DESC_DONE value set by reset_tx_queue(), so the helpers
> treated the block as complete and freed NULL (or already freed) mbufs,
> crashing on PF reset.
> 
> Only clean up a queue once a full RS block is outstanding.
> 
> Fixes: 30e1aab01bae ("net/iavf: drain in-flight Tx before reset")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
