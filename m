Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87B6CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B169F402AE;
	Tue, 14 Oct 2025 11:48:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 85B6B402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 11:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760435336; x=1791971336;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RJI8j7Qm3qi3l70ukp9SvEiKe5KloEmMILeeoGRvALY=;
 b=BSN3j3NCYzDskZR8Cztrh8g7yF0eVNjz4eYQGIXoISboyd0zhC21LtHS
 RkeYA7uAo8xHYnOYLpHwCY6DIE2J8neccVrtBd+uAPpDJgYcsbGtvQGl/
 24Ub/DnKOKXPmVX85dgj0wdc43Cz1x9RETpViYA2TYtpFWXMCcbG8jJxR
 pqp5NyA8auplDRWvExJlvI68o+Ka1sbSINwOdnl3WA2Pef9fk0WqJIrW3
 LQg39BKwXFT3wKCuwerXzzkeO5aZ0IeemgG2uYEUCSpZRfKpbeq4rYRCl
 0hMGeR8Q0s+zFhqDxpTtsOP+Awue75SnTo+CCP2MvGPIYdo1xogD5zVd4 A==;
X-CSE-ConnectionGUID: xcaFjYKiRZCvjy8H8B6YlQ==
X-CSE-MsgGUID: B8vrOvpJR/S4LpBfHqxxRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="72859395"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="72859395"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 02:48:55 -0700
X-CSE-ConnectionGUID: k/BwOUTYQ7CsujGnW6c33w==
X-CSE-MsgGUID: g9imM1pNTpy2hiqvk8GpbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="205538345"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 02:48:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 02:48:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 02:48:53 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 02:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYGGlZcR/augODRDGKlP3T/zCg4aZdL5mNEGT5js9nB8GEmvpbze+eGSOZncfQvJA65LhG16JDc+T0vHUuarxgNHifhYrxocB346aqLM5O7f6ANZU3GG/yQ6V2rl16ydtUCvBoVEo4sWxeQQQXftgQr4zluGKlR8V0oE1J7WNWc2EmFSKZ2iPAj8PenR/RLSZDqr4TNvhT1LGrE2ucv2tU8pHef5R+D48NItOdJSNSkxzSzgBC7fF16iUti0ZjlmqE5zMfLTgMss7nZ5X3iy5gegJNLxZ3S58DM3F5lIxG43V8QP27vGe+o4XVY9p417H1mZD8EBLSs+ZeO5TOAWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MorZkA5/G/AIy4TVBESVeB34iJKRgmrvNXbZhi4PQU=;
 b=LEOy53mUqrvuM/hpaI53dGm3Xe1xcloppqUn66c008pDS5g7Ay1QPkBCTv7zv/II2EQuiY3407ZYISPX8HhWIdBwPVBcZpDp6ENxxwUNJNjoEbT6jnIDLQ65hHXMPJBaAE3udyTmWsk2nAZMXYz1rHJVGiVcPSrdGt4nVwFvA/CwUUYcJG5ggOHtiWQoyCviO1Kx5tccSH1XuRs6q0+A1dJYuz5eNU2m2UKcgJEoRd3bJY3Ih5oPrb6oShg25YmQrZuUrnEOstZOk4q4g4e+ZCbHHrOBrlE4Cr8ZW81Aq1OrF6BEg3fzD6CTNHKIBvKlTxqOLXH2kXkovKGClMzkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 09:48:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:48:48 +0000
Date: Tue, 14 Oct 2025 10:48:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <stephen@networkplumber.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 6/7] app/testpmd: add commands to dump mbuf history
Message-ID: <aO4cewme2ItIYMPV@bricha3-mobl1.ger.corp.intel.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-7-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F654C5@smartserver.smartshare.dk>
 <3472245.88bMQJbFj6@thomas>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3472245.88bMQJbFj6@thomas>
X-ClientProxiedBy: DUZPR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 12505d76-fe99-47cc-4087-08de0b06df6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?xGd7TNavawDZRIR5Cbs4u4dGkqPU8aGQTKeqRjmkNBU8NwgpSvl8WSqD4x?=
 =?iso-8859-1?Q?sBQ8kuM9ZFcozRyyVRpouXmqXf/p6N4yiuTFBPiB9vNFPX1iAtITS/Zx3C?=
 =?iso-8859-1?Q?ceRc8tAPO4+S7Ht1dLiGN7RuQWd1RPlrN8nrm3+CU22FBxuUhdpuGY+b0Q?=
 =?iso-8859-1?Q?VAtJmXGjVkzUm3wwKg5EdqwbErp0EUPt4tta+bRO5kcTvwgJg5gqqbfqOy?=
 =?iso-8859-1?Q?moZTWjmOH+Zpis1wWCwOKnzh2ybPLnobg0euc6pNpmSlBBb8acq+O2DFR2?=
 =?iso-8859-1?Q?xKqMbf3y2aJGFhmlga7lI5kTN5F2p1yHvR1U7x+zUKNhAx/ltGZ2PTQxVw?=
 =?iso-8859-1?Q?FY+PpHHrz3BVQP3quZwAgy/eV97ecTcmcwPs5Df2fgfuKSkg+rozHYKK7b?=
 =?iso-8859-1?Q?Ts5I1Pb80B5ZAfnzDG0Id5VOxcn/Kgc8SpcHAHVyAqsDvUm08lMlVXAHkh?=
 =?iso-8859-1?Q?7XFS09Pq7hTgVYzJCdHmnkElTEp3ZrsRC/isNV8tdHyjUEJ3pFUqZUOhDN?=
 =?iso-8859-1?Q?YM1cGnG+BQZ5q1I2LmD74+pkxwtC8XU9H7bqQNduyim9JZn3o+ROK1+rPY?=
 =?iso-8859-1?Q?1ry0lzTl2Pjlv6kZUSvFNnKLDvoNTCpB5+efqHdOBPd6fxeApHFRlkqz08?=
 =?iso-8859-1?Q?u4Qybp02RksHImGLe5c6acsuKQRxd90l+Z5KmfPnsYYHcaxyNMjY7/3C0m?=
 =?iso-8859-1?Q?sxUmBdmNXKM/oD4oEdViQVrpuMW8ow1crnk+GeXvg0QHhfZ3MOcrZxOesq?=
 =?iso-8859-1?Q?AoPsVSKyVkz5pvQ4IXSIIcFh68JLM/GiNBPTLaNcFtSy8qDzjTl8b/Y78C?=
 =?iso-8859-1?Q?P4y1Dy6SujP42NSO/GYJyDpLhD2IIdQNmaf+ZKQun+SGHAkvQVUdWhFKMX?=
 =?iso-8859-1?Q?HdkHS+cyHBKZX1gM3fSdYro4XF9gljPDoDiCVZaSMktBKE3SCsNpBpfrzR?=
 =?iso-8859-1?Q?Hv5Plw8nF3/w/GPFUB/O9/pkPQAACkQDTCW8BJT8CjjjKRPfOQGmE4ZyD5?=
 =?iso-8859-1?Q?XjEiPtEhFHeaUtHpB3P0RTg1E1TT3xFKUXbDqDz9wYNKzYWEYHmf0WeUC9?=
 =?iso-8859-1?Q?RZtCtOuh9vSSAQvQubDFfYw46BPoh6L0l06PwSPUYn3f2FHxp+U78Xo8Hg?=
 =?iso-8859-1?Q?mS9UKP8gp0twIHcmco9N8q6pVPwy1ikaBoaQxPqSToB1QZV6sdsMwaFUva?=
 =?iso-8859-1?Q?m0oWbhvEqFhSo1AVzMdrPTrTq8EdAhdDwWHB2lEXgSctS2k2hXPKRbLhDl?=
 =?iso-8859-1?Q?VEHjwzWccccPCsrijbkaHL8feeKoG06BUoLiEwnHDyjvMowJNsnsbsJAsk?=
 =?iso-8859-1?Q?jy7+4bqz5QBE3vhlJqq7FQXmGVyK5UcVBjlke/NCydu77KuZd4riLmtLy0?=
 =?iso-8859-1?Q?q1nmD91GqZ0ZIv59dC/2dzUjvM6/iZVYEsppn4AuII50DtNB+6GagBbSmO?=
 =?iso-8859-1?Q?AifYvbg+XbrzSlAw8yQIU352n+eelOY5rvpF1Gd2WSMQu/Vjd5SoxsYa7W?=
 =?iso-8859-1?Q?yByGOIL9c27ZNieqkf3y6n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9pbQeMMWUp1WceK0lJEmwcKIEeMtVK6ZnTgqP6rXH+ZqHqgbkmKKnhumwt?=
 =?iso-8859-1?Q?6bT5Fp8gh8oQDZsU4tyuUULvixdq0Jhfp+f9kPzsqHdzq1PEUb0bHfSvDm?=
 =?iso-8859-1?Q?W+JCPgPxyf7qVGGkqaDS3PRZXP6N38CHXY/34vG77EFVzP5/Cyo3shzoVp?=
 =?iso-8859-1?Q?VeXkMT4f1UuZ75YAXNTGIRLuHCsax92K4a7+woXojfuljDBL1tGxS1aWwf?=
 =?iso-8859-1?Q?6d1jRLgKnpYGKW1GnZ8yUFxiTCoKuT7uIB6ibQ+f/oXwXfsVwRCevQitQh?=
 =?iso-8859-1?Q?WG72xI5O7wJUhMQmRJ8bs/0wUzsQZfRJqAQZxbfnUn++hhZPyPhf8vDYT7?=
 =?iso-8859-1?Q?JlEAaGWLjQvUrPVV+tCUu2hHtgTaunh8u3Tear4obej6cbn1dFVusCE/pm?=
 =?iso-8859-1?Q?HTmL2bVnM3qG2TWV/+yW9t5vNBVk1i7g0yb7Yg7JuKUX8ZI899HS4nl0p6?=
 =?iso-8859-1?Q?PjDqHTVU/5sak8JpoCmp0vIbWS3U1lM0sD2FLh5qmA/Kv2E9U5BW1PTaiT?=
 =?iso-8859-1?Q?qKA4xatUparaExfuqMF0Wxz5HDEmTMcqpuBCJHy7uYXdPe1d5SFL276WzI?=
 =?iso-8859-1?Q?VjBsXzO2TOeoxk28p+dj2DQ4meXWNsKVoh7eN7o4lN8ZLRK0mRynxMsqKo?=
 =?iso-8859-1?Q?ja/cGOrJAo0zFD6xhjU6CCDpxklca5Sj50vPRmIJUgcHSRmnucAsFPLDE4?=
 =?iso-8859-1?Q?gpPEpH9W3bK7sOL++XdJJlhQcj2i6rqM7K14oMgdqAUA9CYQjot7OKhW2s?=
 =?iso-8859-1?Q?OSMt0HQHkIlId00oXTCC1IQsCTQNHMCJcqvT0nY1OQo5C/fdEE7OaufN9R?=
 =?iso-8859-1?Q?oWTEEolBX6eDq5Yhq2hvD33sUoPguaiDAR/CDGWg+6GG3XS50O0T1mn0no?=
 =?iso-8859-1?Q?jSo9HNDnkqwI12AVc6fT38qpkf3kIjs6wij7W6F3N4KBYw5MDGiMZO7cQY?=
 =?iso-8859-1?Q?d4JolseOiS5pt5WkyY7uxYRmZCNQdJ/qYlWzZ8784ruIpGmjTFDYmCZDAh?=
 =?iso-8859-1?Q?2LidHvNg2UmyRjugnKZU8L60T5cq486voaZme+WGeUCtmtBz2hhCeWfTnZ?=
 =?iso-8859-1?Q?BuZ4oLUXZNr6snUqLrs8J3pwysNsrFxhivjOHT6MO/jQAexsHuSsbLZgvv?=
 =?iso-8859-1?Q?nGRkugPnRMogsatSqt2A+JJaUHxX4UrUqgspngZqBTOFQSmOJgAwgjg0ct?=
 =?iso-8859-1?Q?UVipX5pIjiwmqJcvYjmBy7GYhrmqLUnELI8bHpTpwPaArOl3UpojdB2K5O?=
 =?iso-8859-1?Q?EdmRWMu+rZV3i5UhVpFQHH2SQLctQq9KwtVmSVuC9uiIi8Gsheo9sogzsE?=
 =?iso-8859-1?Q?ZRjD7a4jWC1S86CYYxQJewO4b2z7Z6J7c4dNK9cusGPALkMRSVDw3IQ/2W?=
 =?iso-8859-1?Q?H16f1nsdFD5HLO3nojTD4u4ITv9FLk5JzbawDcEUKlByZqQWBncoOAUyfl?=
 =?iso-8859-1?Q?U4ltau1El6EW1w7BJ/gvT6/Y29hL2BSYXPYhN5SpDVAPqX6Hg1wzRh7Gyg?=
 =?iso-8859-1?Q?CnQSGViIlcHxXBNImP1UltUGD7opbgafu2m8BTnzakOJvTesTDMla3CG2f?=
 =?iso-8859-1?Q?5rRUvrhBNoFKFvR+hb8GYdmwhTZndRMdBSAUkBe1sAHbJvydK5qj4vFmBw?=
 =?iso-8859-1?Q?9x7AyiqckjRsf0Yd7jfguI10C9kPOCifYC2doGR/hvh7uDypqB7ISUUA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12505d76-fe99-47cc-4087-08de0b06df6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:48:48.1821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIrSKAgmyIO+U/5x1VVF7weNfS00N7gWorc79WvdofvSbhlE4ueLMF0iUPqWESpqwdBNYUIU1MWAXdFGlWpGHZD2mSNh/AeF06vNeBKlJnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
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

On Tue, Oct 14, 2025 at 11:43:28AM +0200, Thomas Monjalon wrote:
> 14/10/2025 10:45, Morten Brørup:
> > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > Sent: Tuesday, 14 October 2025 08.59
> > > 
> > > Dump the mbuf history to the console or to a file.
> > > 
> > > The dump will contain:
> > > - Operation history for each mbuf
> > > - Summary and statistics about all mbufs
> > > 
> > > Dump the history of all mbufs:
> > > 	testpmd> dump mbuf history all [file]
> > > 
> > > Dump the history of one mbuf pool:
> > > 	testpmd> dump mbuf history mempool <mp_name> [file]
> > > 
> > > Dump the history of one mbuf:
> > > 	testpmd> dump mbuf history one <mbuf_addr> [file]
> > 
> > The "one" seems superfluous. I think this would suffice:
> > 	testpmd> dump mbuf history <mbuf_addr> [file]
> 
> It's not superfluous :)
> Without it, the cmdline library cannot distinguish easily
> between
> 	dump mbuf history <mbuf_addr> [file]
> and
> 	dump mbuf history mempool <mp_name>
> 
The latter might read better as "dump mbuf pool history <mp_name>", which
would also resolve the ambiguity.

Even without cmdline lib resolving the ambiguity, it should be easy enough
for the cmdline callback to do strcmp() on the 4th parameter to check if
it's the string "mempool" and then direct appropriately.

/Bruce
