Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9260CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 12:37:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86C2440150;
	Mon, 22 Jun 2026 14:37:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E7BA540144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 14:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782131858; x=1813667858;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=cCRspjWLqwOADOYxrtrmtTrIu+uJjvvuBGsV6XD0ur8=;
 b=EAy5QwbuyySsC5XX3wfGq5D9hHEkco3V91vYVxZlT4hqsjayXSZMtH2P
 rQ2MEQgYvWxFvoZSXZhChKnwH9knRaDaNiprYWbqWJMzkiN0eGVBOGRwd
 6VIcHXXbeR3NJiW1V5lvgqIy8PbS+8iIiic7ff1JrVLsjet2CcidmqVqK
 3IcQfrAf9g6sb2b6jrWYDt8rYVAy0XUgXElPNgrmY5OOo02dNvBRW/WN+
 M5lh2z3zkGVDFE5rYzlhdeZzqdNca1Y2CpvW5V/e/eBZAD6cRhVnxoagB
 1ir3zbQzDgXIlsKkkLZg/oerqngk9cFHTQBF0SXW3ob75PR6gqDVFQGuO Q==;
X-CSE-ConnectionGUID: LLRLt1JSS8yEwr3SIZUvlg==
X-CSE-MsgGUID: d+AJL/QrSC2F8oyyT2uQbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="81838434"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="81838434"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 05:37:36 -0700
X-CSE-ConnectionGUID: Zjw1XK0JScWYkS1oiy2jdQ==
X-CSE-MsgGUID: q/Bb/M0HTTKpReoZMC3f9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="248332950"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 05:37:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 05:37:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 05:37:36 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 05:37:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1ezrnR7Tv+DTuGeAdxRL593YGbBkLwhWldysuUAxojhsun91lcLurTLLxvVwAUjLmYLsrxbkEHP9Xe3nWEpGRXShIebpwB+Totx0Q+kI3+EQ8Wa/ePhCVN+xAm/fQkqeJ/XFRymd0g8dEtkBRAcQskprHIqxzzI4LiJ5YUp8X7F4n4Yatxjcv3zpgFoYckG/xr0IDPTDCvH94cDsyUvpTGwfDK/J1Uklz7jua9ydbxf4DOkM71fpdoJs7qE0pEECriqLpfnLZvIhlzs0BDD90a4yPkOIwqpwyWaoV3Z9XJ2glrtDAydAeLXzwL+7tNqS/vSPzcgZMaS6LA73eaINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlczPx5C9lm+XD3zPMfm1yNddAkfzg2Cuy4/YD/Dvtw=;
 b=vQJ4DiLCprV5Tx8+4tGfXnMw53mnIMATDA1rWY06dVHlN2UujaFvQDP3swNntZbNMgVUmcgCbGs9bvKSvTcKcgnycjlCFCNJLCXz4YIjBKxbE8j4IM6aqySCqVs1P3RxROlFwqd6g/NKkA/NMPlSl501ShdatvjkgyngU92L4ZK94COSjCxqGgro7aC9Arz0p5hWIOaGD0+Cp6eVgZGAPGCB0b5wqjVi7gkd7jhklRxyxwM985wWzA5cPPRBRaLEV5IA5RCQQYysq+ucbbRtutupvpDxQkkaJprR8jPW4iPEXDkykXXqxdTjOKtaJg/9H0qmy+ndoQMAkwcefl7ucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 12:37:33 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 12:37:33 +0000
Date: Mon, 22 Jun 2026 13:37:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, Bhagyada Modali <bhagyada.modali@amd.com>,
 Robin Jarry <rjarry@redhat.com>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH v2 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
Message-ID: <ajksiENSh0pGV8mo@bricha3-mobl1.ger.corp.intel.com>
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-2-raghavendra.ningoji@amd.com>
 <CAJFAV8xPs4KiHJ5koucQyfEUk0S77zGQ1jM3LxtQvT2qxyX=nw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xPs4KiHJ5koucQyfEUk0S77zGQ1jM3LxtQvT2qxyX=nw@mail.gmail.com>
X-ClientProxiedBy: DB9PR05CA0008.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 61525a71-617e-4f18-99ba-08ded05b0810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: hVJgZnFdZSXk/rDHLROzjxE+GCjzCApIbq9pq7mW3Xv/kTC2f7e8EI7QQILrQvfg/brsmC1HQF2emor8KtnMdBCu89vS8bJa+Lkj3YjF6B/lXMLuTB6OPpgAr/DZbRu49gONTOHZKIxh6zqCmSvCAQchQFZuPJGWnXKkXAG3MFZZW7QrI0u9eeJqFV7Q9t0drSpJ8e2CyDg7YfSPrbd1jmSc2OmLiyP3v7tPi+FWQJ4bktxh1vbRwo3Vj/HtmG2WuiaNzjXhiqP0Wg7hhFswyB3tQJ+HQOmwif1LiXufroqdp+l23A1KMflg73xJRRFLOC/iMnGn0Cul9ve4Lja1zq4cx0DO8IzWHMGqeQnq4rpEqtZZw/8DAm89hhqwuNtAqzAheOFgBaX0MZFfw8OKUkHHODbGQ/14AjvG3eI+qBcMgrYId0jvi+mBSpotCPQ0rQs3K2v3RDqVQoy/2ScB8OQRBvWOP2D6UJ2VyMfJ6xYFzC7XOkpQgR9/tNdt4N20q1bNzsgKkFQpW+r21o1Q5rxXx8ai4EIIkH7B2oGs3rgD79J+Nm1yXga3MDlUGdtmdiClpHnqfJWnRAWS5KAgTxTMDxKTYP4vDH6Li12Xm+tccixsIl0eaDz6Tr5OIlK/wBxbc54lwCXPiicdS/0AT+l1J4a+gPY1UsNyezMMN9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AiDW168KvhcqSPVhC3ED4cM0ZvMiPYFaJv3bf4DDDFTXoVjnWNbZGWLtE0?=
 =?iso-8859-1?Q?HBFHxAg4loJ19QydJk8pscC+Xs9BWT8Ys41OvanB7FPxAX1OaUdZxLKQ97?=
 =?iso-8859-1?Q?8STAIH9BBdspqg2BaMtbsv3o03sjG6oAGgM/KdXStaaZrXe//aBtSYWOwq?=
 =?iso-8859-1?Q?6Am0tjAUe3m6LElPuX34YhF0N3aQoEfoBcfZBaSCwMN5UqWCMknYGwKbYJ?=
 =?iso-8859-1?Q?Rj92FQsFQVWqfQMsrRrW34OCLEmr2vzaKxU17ohGOjU0aQnN7I8aKmbqK6?=
 =?iso-8859-1?Q?HEcRb9Q4Pmq7j7KLCpbK4pYfzs9oY52RcmnrjvyHu1yGH65iRRdf66p+kG?=
 =?iso-8859-1?Q?BYFdM/KGZ9UPEAk4YijdhiEa2YMA9BzPJO4ll43HOMmebmDiTtfcPT/RGD?=
 =?iso-8859-1?Q?jDza3yVMxVsjnVj2Cm/nxwqdzSP1CQBHC5dTK3CES/C8EIHvuc53MVOJWm?=
 =?iso-8859-1?Q?gDhuytmd138dZJX2gT6PqTPJH6x4VePgO/b1eA8zLGFnc4kQs9u/nT5D52?=
 =?iso-8859-1?Q?0NtihFyOR9/vWYS06tWxes5GRczg45Tyg1IXGkYPZHCUc8FQXYHqQB2Ky5?=
 =?iso-8859-1?Q?gx0l0D/Z44iEKN/G7u6K9sNsp9yqXQFfgcoJPFy2OSkiQATqH49u56b+uM?=
 =?iso-8859-1?Q?NsP9R18m7lY5LKTo83J8AlxFzLaUZJURka7wBBcu8vutliOIXc7HrEhJtJ?=
 =?iso-8859-1?Q?NKVyt5vCliJpnnjrB6B4cYA9TkQmJqAMl2Nxw6LxAGGpsPOTWfhMAAWlyf?=
 =?iso-8859-1?Q?NlTUC32Wq9KEWzRCsQQVFB6zBPqg2BV5FFDKSzbto18X4jTw76J1kzjzcP?=
 =?iso-8859-1?Q?7vJgD2a/i1dJtKQGfgZ7kd6a5dSC1UU6PRibBSFSwMJlOGVdaIimhYPcLR?=
 =?iso-8859-1?Q?xD42wE5x3ZAYTai8jjcX8KEF8YdlGFrfcftzX8CP2S3eaRPZGnPRYSTJGQ?=
 =?iso-8859-1?Q?07OoiAn1AmDIMMaYdRiUedbO5osa9OgJQ2qee3hKkJWYIuqIwAdfg50olv?=
 =?iso-8859-1?Q?NiZB/PlcXdburoWbCt4JiKjmwGaKvqyrb5hWSsFE9rxr00u8bxfMkIWebO?=
 =?iso-8859-1?Q?b9Nw/JhyUieSqYEGLNJgRB2ZL+AU+nOCZpE6QGh6oAEY0WNJRNW+EeSPFH?=
 =?iso-8859-1?Q?wNGzrjja8/teJYp4T0dpDhy+rQY7WPkcjW1AIaYiShZz1Cs7beCxeouXQ1?=
 =?iso-8859-1?Q?66+5NONnu7ezi80MQODLjBfS0biu1jJPctgYU3u1rl0l41bOAllEWjbWVb?=
 =?iso-8859-1?Q?xiaF01Y4o55LArIDs0iaJR2biberx+Tqe9v81ksFUYW71tW0MbqmcJk2zw?=
 =?iso-8859-1?Q?795WgE5zmjX30m86xXa6OcyKPtYs5TjYQ4h6IXmriwV3Z8B68UWqWDu162?=
 =?iso-8859-1?Q?PdzGG5qZpUOOmd81LtjSITKfA8EIVZ/9SqolDvAONmyhWwe0im2Ubt1Os4?=
 =?iso-8859-1?Q?o4v1OLG3OcoSLnTtgpgJobTZjg2HMN7lTKYNgbvjFctAInt6Zqvb9TxT0j?=
 =?iso-8859-1?Q?UC4w1Ap8vvc2f2QLLhuqugXaLC7bhYTWdvy0cSuDvOG0H837bfrpdNwcYJ?=
 =?iso-8859-1?Q?C7SHgCXbOSquXAnn9AK43KUcX+itjDesq1uoGutezdO0CcB1e82yb6LE8D?=
 =?iso-8859-1?Q?n7kep4PLbHBo0/3eWPTSlYPNiUGontNPMm1NqZHhXbOQ58tjk0pe4miORF?=
 =?iso-8859-1?Q?zvVQiKMKTAUjsCiIfAA7KhVxoc6R557ZZBa+sEVxK8MbcJlpW107VdMY7N?=
 =?iso-8859-1?Q?+pUpdiTF56iDts1r+YSOoBWAdNd6FFFs7AY28nCIKk1GKhpL3apy6xd5jV?=
 =?iso-8859-1?Q?wo4i53o5yy2S/oUagerVz2Zozwz3W/M=3D?=
X-Exchange-RoutingPolicyChecked: m3qtwBEcUdxDb9f50eoWH4xwZuX/fs19I+OG6VzRBtVMy5W9NDBTz/yT2mdOpm6j+eZIYk/KS/WB9tqFZZegaJCIPXH0/Uh99M01nc3gUzXK9vwz96Te9igqhRah+EkyZaE6oaoHReq9YmnylFJj42aWzf6JbznfcYSLKR4DY1r6Nj/So3UkUfwi3r7Crtz+eGc3NAYzQXrik9gWcQAf5oh11Hm//a74D2gdAjsGTNbWOkkrGpkhbseX42DpqDD0SLEceJldvEV4btCNNQUIk0q4oKuMJUqTwM2cQ24qwljPem2iNzKUoUKuN7dbSjpzARzCnVBhY6aKdkGGXTl6Cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61525a71-617e-4f18-99ba-08ded05b0810
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 12:37:33.0897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEWTxO+QleDun3PS2R9akClDk7LnowMxVEmmsVsSRIUMrePOc2sE52xcpFE09itf1m8jA3fpQgSmEyNo5kuYnXfSCWmuDPGog3T788+JSfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
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

On Mon, Jun 22, 2026 at 02:26:33PM +0200, David Marchand wrote:
> On Mon, 25 May 2026 at 20:43, Raghavendra Ningoji
> <raghavendra.ningoji@amd.com> wrote:
> > diff --git a/.mailmap b/.mailmap
> > index 89ba6ffccc..60180818f9 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -203,6 +203,7 @@ Benoît Ganne <bganne@cisco.com>
> >  Bernard Iremonger <bernard.iremonger@intel.com>
> >  Bert van Leeuwen <bert.vanleeuwen@netronome.com>
> >  Bhagyada Modali <bhagyada.modali@amd.com>
> > +Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> >  Bharat Mota <bharat.mota@broadcom.com> <bmota@vmware.com>
> >  Bhuvan Mital <bhuvan.mital@amd.com>
> >  Bibo Mao <maobibo@loongson.cn>
> 
> Almost missed this.
> Alphabetical order please.
> 
To make it a little easier, you can use devtools/mailmap_ctl.py:

	mailmap_ctl.py add "name1 name2 <email@domain>"

And that will automatically insert the name in the correct location in the
file for you.

/Bruce
