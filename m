Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC97CCF2D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 07:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 848254028E;
	Mon, 19 Oct 2026 09:48:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id D5A5C40269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 09:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792396091; x=1823932091;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ix+vD7ZsuwLMwesVlYF77DqQV31SgGePF5IZNQISj9I=;
 b=lGodfKrofD5QHIOA2fYMX0r29EsE+TH4JBFu5yN1fA5pNKwm3Q/Cz1jU
 JmR3UygOrdanww0zZYIHnK8Pl2UKNQBaFA27YYXVYKviMQRi1LB1Mbi2Y
 eHNEES05zMv4mldByupMs+sE925Op4Q+XKxVZofgkm2Ovm3TYQ+tC3bry
 9wdAWOrlKfJiKobfEWKUkz41TNwtuDV+0+PRqG/6PHOQWxq8clY5pQ0p2
 tdMkI7DoDvX9I3Fh043lJO8fekKFoAFEBp9VQn+m94T/RohiiQ6+awUGq
 jGzILkxgOYRfqAkOTNjMbRoJ8/UJmw0OrAp/3SzvJbCpHKBfkD6H5buRL g==;
X-CSE-ConnectionGUID: e/J1685NS0i8nG1kl/2Gjw==
X-CSE-MsgGUID: r39HMz/pQKqhtclsUhrgoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1057427"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1057427"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 00:48:10 -0700
X-CSE-ConnectionGUID: gwtk+Q3pRAO2MgMIN0aeZw==
X-CSE-MsgGUID: Y9Gb12ZMSdKHox1fow76Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2810645"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 00:48:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 00:48:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 00:48:09 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 00:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI6RBbD1q2FtmOsPNyCMmosMAuhtwjcEpDNuHZFSULOiGE5IvW5sIjcy0kUVjbcMmihWnDCG825yikjOovEkpSf6EF9iWmvAauVmHW0uagaO25VtoAaJlFhaq6V8FaemFVlFKIzETO0/P3sT9ArAZNgZ6Z5RJ2HDVCzf4LUA485HvXPyP+oFV3788JRq6KEsyxDG6NCn5NAmoC+LdswfaurugMUj5W5216i3Z/BQclJ+PfO3lQDOD0mWI9E8LhsV8njpuz5axeD/PU6JjvL2RXgBhGbN8lPklvLWZnKw1jg+GgGzgkutINo9IquXk42x73R0kxOhEmIZ3ocPlxLdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCHoY9qHL50Irx1am8cAspoVSraywt5hriFa9oRM6pA=;
 b=w8NAMBlrn7Csgz0qeV6q50ZI4Uv3uHqRG2aBRpjsvGJGkgo0t3C4F14LnYWUpL2xBkKnqYsHv96GZEff35BNg6hS3xcLCTIFAfNYohVVtxZd13xA2v3g2YJ6H4C1uC2EB9y7XmSm8Nx5Y6tmr8/LqqzNsAr/c1z7hWln3OQWVa/OioDYigxHRMQGYJfxAtiu4HjE3LRT30n67TXMbBenYvwxAVkGJ1nHVY3g6osJ+1PiIYJmv/QvcIOTpmWfIluJHrmqqE8rQhCRX2Tu2ujTYqK+p9lbpZi4HBTO54L4j0gWTHeH8se9oxo5t3AL2QxcclwF3CoJNr8L9HxtXKlqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 07:48:02 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 07:48:02 +0000
Date: Mon, 19 Oct 2026 08:47:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [PATCH v3 1/3] app/crypto-perf: fix asymmetric op pool name size
Message-ID: <atXLLZ90G06UWwx2@bricha3-mobl1.ger.corp.intel.com>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20261016153949.2965592-1-stephen@networkplumber.org>
 <20261016153949.2965592-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65AB9@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65AB9@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS7PR11MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 154d5c47-cbba-4d04-89f6-08df2db54d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cSET5sNozhVdvuQFfEvXpa2AB+YDO8AB1RVlf4eQuMEa07/AhxPtPa5pWzqd0jpdeDy+GOb4hdPkioAYN8b+9O/QHTDvWM3xHacNwyckiBslhTQb0uKB/XZpR5Twi/wfPiwnxetxvVCx+jmCk6SZGzECtc6s1hUCPVtknsOWLnACfqe1NNJeIM1ufJEdQt1TbD5795b0B040hWvmI66D05L9Uohck5bOoWW34OVYsW/+br4+qQjG+ksf4ZUsmjJMYHT+70f/i1oMlY75KK//Gb0kuXTm0dittX8ylpdkNB1BJyRDgJpGoYear1YjwgAU7QhcWjYlrCLlWNTS1Y4AdzFlrMD9/ExNwGqZb1vs/C+B8K/pLnNNLX5lZhByIvl+zP8m26EENe/0M0GzYt4YITNm0cM7qgRR7FA+8DZvjwrPlcTDg81nPdDXCA6BuB4+kQ1KvLH1apx2bM5GdDBOkkPSY917sklAk7IBe19O7yCK5aqCglxuNSMPKrG9pm71uHDyjg5RagbxDFyyRO6LFy9NIdOsNZY2JC7cr+EvPq9Ki7yLfyCkMpyKozBSM+whjaz2Fto2ag6zz57hgEoW3e+M6RJn02fYx1nzv7nE4dLTpSqgkucsTprxqyvVQ7a5ARLQAhUr0AUr5syCid6HcM+fc0FyFW+hDgCBb/5bWd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jdp0iMGlBwHTvyccaCNVr6aaiFa7jFX2mATnoRHSNg5MZZ+k9spzUpkVa/?=
 =?iso-8859-1?Q?l8OY3WZ6De50oLhh5Wy2zKkUfP34i+2b++LKdMXWwb+1wKolcT7QC9xApF?=
 =?iso-8859-1?Q?+vQuBp02P/ereWHxvJLbmld3F6dEhP4FUpZNSv2cZeeI63UwFL6uIO00kd?=
 =?iso-8859-1?Q?Lp/whpV8u0ICpHNLfpAMS9arbC9gW1nUCcHmezFmYDSqQSEu32P86Erxka?=
 =?iso-8859-1?Q?TRXJIeQiHUjOadv8UaJagdeSazkwSCYMwUrSvkTgayDe4+624xO8NEcjuu?=
 =?iso-8859-1?Q?bGLDrMz15c+hlD+L69q41BDYX4kynmlm0LGrPV7kUlL6M9Fp9h+HmCO9mV?=
 =?iso-8859-1?Q?2fQOX1XpxsE2TH0jB0nPraSpX2ogljaQMo9m1e1q9377ARzU3oJklvnYit?=
 =?iso-8859-1?Q?7CT92UTT808VQ9BCR6cC4fLUxXOWMCYRpkxJhGPI6huhalI7G9yX69uGfR?=
 =?iso-8859-1?Q?qjrEdhR7A/df4YyJpwfykDefoj6HFJHAbi5rFSXigp9E7+BFKElEKK196q?=
 =?iso-8859-1?Q?v23LM2pW6rOOVcojxXSxbHD0n8sZwW/cQE5jooeUHTMCBr3qv7LiMiKSBh?=
 =?iso-8859-1?Q?azxh7uHxGumsB1pKhdic2lUgf+vHwgcetDfSSKYDnA8W0Nf8ZPvcpY8Cjh?=
 =?iso-8859-1?Q?dkonJKcMR8gFduE5CTLGahCrVfTv85WowS7wNfq5P6Pes8K2+2K3ssCGxl?=
 =?iso-8859-1?Q?zcs6SAqTyAIwF2eDCVeNKso3UHqpMMojxCmrtJqZHov/AY7yjSoeuG2Zt4?=
 =?iso-8859-1?Q?7u2S/Wa2T8O5j3MLCB0hzZlLz6qLFshxIv9MMmhmc8IBzzaagha39nnACr?=
 =?iso-8859-1?Q?yFcOzsqxpNV+7rYyf3mfhKzK2aohRa3WyY1wwGDKfCh9zpyfZdm8ABp5sU?=
 =?iso-8859-1?Q?lthA5di8TZYRVavB+qKvLVPEUctzjN48R9DHpWkbaEkWST+3qIp5wjlFMs?=
 =?iso-8859-1?Q?w19gIuJtjbjzawWwMSWAYhvfmIaXiTpSQ9nHTWlWdzrZuh7F1guPawDf0K?=
 =?iso-8859-1?Q?y6EEzp1+yBbBFMPowWXYFjif509lfKuxmkREEw8jEkkrGjYrSW8ztJE+NH?=
 =?iso-8859-1?Q?po3iC4ApxrBnIBlg1pFl6nQ0hsl/T6e8j/5XBB68gKsEwNU/Fz0WSIAlaK?=
 =?iso-8859-1?Q?bxn/1sSdrvplnSAxLTcE8o+m/QgWOhk/cs3Bn+8kpCAW1i1KawIVCr0/MP?=
 =?iso-8859-1?Q?ETFBRhvIkt06Q7rjUx0dG3XUle4p72C4e2jXDl1tXGfD5m51BTLak1Y8iQ?=
 =?iso-8859-1?Q?vLSLwir9oMtS7ThOJ3bmStNsRUWpkxnmedh8rLbxQzMI/0eGoQXDZbjy3o?=
 =?iso-8859-1?Q?ApFVcMsY/n7Rh7c0XRr3pHEDMGXk1WvvGStrga0qONZ9I07dCIv2HEI/fQ?=
 =?iso-8859-1?Q?wwpLal0Jlxv2CLY1Vb5ivmqIpQElWp81FnZUIcRQDi950jeeW0g4tPjvlR?=
 =?iso-8859-1?Q?Gj2qWxv3B6BpfUVYTvIol9u6Y269qaogTIavtwkwIYnAwm5KPRPMeIziHP?=
 =?iso-8859-1?Q?qEin/eJHuVYvfHRqkEkypa/E3omKiRusIjcjj0xaVakCnhpQyAWPDanS7F?=
 =?iso-8859-1?Q?HT6jxjlTG/vstWHV4FiOAWdqDs4vd9wassk3i4wn/lPJr7rKh1Xauprvs/?=
 =?iso-8859-1?Q?24atCmms65TJADq7M9bXY/Li4C00o2Sxqa1xsPYXxawn/8GeBVdmvBmobN?=
 =?iso-8859-1?Q?Wj27eCNo7NDLm57zr47LbIJsXfOacqe/jQdhAmIu7MiXDxcL1JYdUr++5e?=
 =?iso-8859-1?Q?4PyUYkJ6CBQ1N+f2m1xCsDu8iIbUK9uLS+nH7MP8ElUgq9oStwAUrMWgb4?=
 =?iso-8859-1?Q?KibtUgB8NBLIYtkoJexyowxyhSJS3kM=3D?=
X-Exchange-RoutingPolicyChecked: qjc+6o/5l5YeHZLeZ4AGKVMqe551xB0x5eIEMAve+R8zmOzrrJTNp7jgAyhHtwht/n6ZgntbfFnGVRxby1k42uS1M5YmxS6SfVbE+JaEwA/qb23gxl3Qt5adytb9gyNN6JCv8Tq9uINXwavZ5iVlMQ8Vk3274lwf/PnX/TRpd41CILi8JioDRN46LYPSNpuY3cfefUJckDe+4B4lrKq8JF7ypNzkSTvyEX0M7rGZkYcwDOvkJA7g/w2gQCW1S2E47QJa47G78rgrL1uJwuVMvj+lzh8vPYXE+dg0ktTiwEq1FJeXZ6sDBSkXinonq3uxEpjuBBjjN6zSa/HVMWahXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 154d5c47-cbba-4d04-89f6-08df2db54d2f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 07:48:02.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DFkDfxTg+Zenla5ExNy/Wtns70Bi7iDV4Zmpbmd/+5bCPvN1Zt0xlAQefZ3busUlSxd/4WfIQHLq2MWmcT+wt+scPqp0pmLQTdi25bsKSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9498
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

On Fri, Oct 16, 2026 at 10:13:53PM +0200, Morten Brørup wrote:
> > @@ -154,7 +154,7 @@ cperf_alloc_common_memory(const struct
> > cperf_options *options,
> > 
> >  	if (cperf_is_asym_test(options)) {
> >  		crypto_op_size += sizeof(struct rte_crypto_asym_op);
> > -		snprintf(pool_name, RTE_MEMPOOL_NAMESIZE,
> > "perf_asym_op_pool%u",
> > +		snprintf(pool_name, sizeof(pool_name),
> > "perf_asym_op_pool%u",
> >  			 rte_socket_id());
> >  		*pool = rte_crypto_op_pool_create(
> >  			pool_name, RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
> 
> snprintf() doesn't ensure zero-terminated string.

Actually it does. If return value is size of more, then truncation has
occurred, and only size-1 bytes plus null have been written.

> Not new, and don't know if it matters; just mentioning it.
> 
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
