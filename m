Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C1F53D67
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AF5B4025E;
	Mon, 16 Mar 2026 16:05:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 759F4400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773673542; x=1805209542;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/nDDvFXvd22tLFsIQbgfwn2DoBHqOGHu40w/SVW2Uns=;
 b=iRhKwrra3vRtncEfKyHRcU8g2+vMUPeThTbZO1TqZl8mXTn+IIRJxYfG
 avrl9xO9utuOFCqyam9JjB/vpPUEqDy+cJsx6zUyMoonxd7Yz+vdJE6lU
 9+dLDIGJLFbdZ16AUWbHRhEFNEBGWkTXhAIHJB5POg4TCGiTarSiFL3IX
 ukd9h5KyhtVzkyRhvD9sIXDiY7CZkw2xD+6gmOP3o4YsYEf1Qzdgq7M0D
 6FIC0uQXVgqHVIw5qnY/23EwAQRBbNJfUR84X6Lzj648bios390uYI/kD
 N8noIUXYuA3f9dbciI6ptfT8Bpf+dp7Oxk2zIdx3R72mkuFl8KruuZwjc g==;
X-CSE-ConnectionGUID: D/X+rmC3SmyVtW877Q+SYg==
X-CSE-MsgGUID: 1jKdfU/USl+IhpY+SyuNlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85772574"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85772574"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:05:41 -0700
X-CSE-ConnectionGUID: HFcYfklYRommah/3zCqj3A==
X-CSE-MsgGUID: SDgUn1BjT3aRcYnmEaFyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226072448"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:05:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:05:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 08:05:34 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:05:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIoqPbZrMLvuVsFnWzZaIW5W+cfyIv5FbhLAXkipuz1H5WmuyNv1fNYOo7uX6MbvSW6jyusUYgPS4O/iAeX9YgprO5S5gFYIbYpx54gsmsj0j35uJX8IVlEaUIGyz58Qori1pJfG48PKxqtK87omND+HytOKLbmbc0oyac5/902UwPLlqCysD5YM8ltHzNJo8zJmaVmg3cjhh5IB7HRkWMI/MVvbO02taxCvc9WgBDGjeA+0QHtlKtLTA4Jt5Vdxn2HmZAwOKjwXi1gnHB0WQ1n77C4R4X2kErxwzUKNwSGP5UGgEKiy5Xpzlb1pWwAcodpE9GLBea5vnksL78SbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nwf171FbSaAOQdeun0+nRKRYg55ui4sqgUvwqN3KLA=;
 b=IbRkriRBH3Gn1nA8JLsACbPiyZd/tXy6ypRYMGdgQQVWqQHXHB3polb0SfW1mYL251Y4dx4IVAQevTP9TYTBx5IBDDwg8WOQ1wvjjn6l2en1TX6CNqho/JG3iAm/EiD3IpLach36tosbr2jUDoWSRfRqS6PjZUoIoJ4/gJT0R4cNcpyzfFHoRczTRH1p9Cn/S3C+XzlXGIn+EQkokctPS7HWCR6bMMTAcKuXf1Rf+6p/XbdsAAfMgEQl9JJmjU7qv3Axm6IYFgNTKOui475R3Q9MghcmqlahhJ3bjrOq1OurxteMbi+GzJNa8RSvhky8CLK+RH4qtG/lhCo9tyqc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DS0PR11MB9503.namprd11.prod.outlook.com (2603:10b6:8:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 16 Mar
 2026 15:05:28 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 15:05:28 +0000
Date: Mon, 16 Mar 2026 15:05:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 23/25] net/pcap: add EOF notification via link status
 change
Message-ID: <abgcMh6olpoIbnxQ@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-24-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-24-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::27) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DS0PR11MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: c723a52c-3272-4637-8b7e-08de836d757a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: vPo4IXSuddDRa8aU2uZojEtZZkLMCqaLzWQ2MecNLI4SITCZauUGBexG7Rtncr1BguHQZUJuGVYIsM6PvNdNUeN51M1zDziYFGPXbhsSvcwUSenMpqGCaEm66B7ubQ39XM3GsIDvvPF9rhy3PrRAjOHczNOnzLEh132NgUJziC3A9hsJU6F0B+F4NyVpiBW01O3vAIfbS+Ce5N/aCopjSOkPofV3Jd86VoWuWRR59K6mLouZs14GgSzH11NN2/moJ7AkchQZD8eqGYvawC9h/VSk7zDK2XDmPsLhwpcHYDy9bWZ5hiJ1+ejaDrUsIh5I5QSxhVhP2vOwpmoWD0bpEGJqDqkj8R79bxik1K/CrW2HKxNg5SdBgYlA+5q5zPnvsBnwIIyCrgJugptEAyKS5EkspVeZ8hofBR1NQ1n7uZpVU5dSvotT9KtVjp/Iie4eKJ/eEWQNURFZTx+FduDHGD86Dm7X5qvC3CYiFnPyPy9PV5wlAaSmSOd402rpj81T0Jzbm4gWoHF4Fv0V8aAgcOHWX9iBJEKQ057CtVymcp/3BKVW3nJbNoxA3GmP4x6RUYxBbruBBLLFYNYh0PVI54j+DelhZTYl/D5TfBryz6v8ybKuz4RdbcrCCKXY3g84RYkh7INdSerd7QfAxKmwifHx449WUUhwBIdeID8n4iQ5jYkFsayX3Fpwl77GK/nXyc5hGq3OeBHsRa8ZN0a4UtsTYH7nbG1Y6/5vTk3hEB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yGME0A95HHGEdnr8+2USZjJpvYwA7+RReVo2uexQiu+ob+4yVzGwePuB4jBo?=
 =?us-ascii?Q?bE4upnYuma1ul3NdYpVubJAy7zuzzHqLOWlN5Wsh3bpOYxWRa1h6cfyoP1I/?=
 =?us-ascii?Q?7j7pHoE7m9GePXYpm/HvE4vdTsZsiIlCXPwS9qlWzOk+/yf9Ijy7Ui33m5LP?=
 =?us-ascii?Q?QQ/k9g835bB7o+M60KZoujwigY3Y8TJPXOFz8TxSV50NU7ITKOpKRabiPJII?=
 =?us-ascii?Q?eS/IIXMfymzy09cz6Wgf8nOth9Y+MCvQFRs5Z+R0ojk8o4jNvy2+3UIaR66F?=
 =?us-ascii?Q?P5eAui9C9qrBi7DjqnCDO93Q3VjURGylPrQOBvAo6+IwAIa76/9vzaYjpdLt?=
 =?us-ascii?Q?WTWtiDYg5RkLni3PkYDf1czeFQ79HG6o+I9LGjBkrWMqA6lHGvmPl3dFIrQB?=
 =?us-ascii?Q?UCj+fVHHVjhAuH8ei4V7owXLZXgMCWx5RRqmMi3I1BdG6B1apYQU0l+tpd1x?=
 =?us-ascii?Q?4TBEyX9LnQTTImI5jAr76jlKGbVqpDnU7BNML7iE8iJ2T37CyXBvjPExZBC6?=
 =?us-ascii?Q?zDptYbR4NkxzCslvwYEYVdWwlLkO6RrXYMPyGseVbnO/Db87n32x+8bxZqw0?=
 =?us-ascii?Q?mEFI2TMbZXwhRqkcR7ij+CaCvhK0Ijo9t+oqoJA2xcfA/e8ELWoardZIRJUO?=
 =?us-ascii?Q?OTZ61vVoCjn1IaUasTwMw6/wMPe8ZZHBTe8UA15vz2RK/HNyipeeIoI1tsN0?=
 =?us-ascii?Q?PKNfs9Fza8q9ZeNsxuvSaRAutLYPllW1kte+8hFXXWC4rlesExiOqOnL+AdD?=
 =?us-ascii?Q?Ct85lX4vD0x9UJwonwZuE3oaF4i+BpzBR1BtkjYGfvhpkgxVY8NCHLzs35MG?=
 =?us-ascii?Q?g5hLFYMp9JMKjVPS/wVR4ozQw5+NUB7S5r/hnp3InTF/2tD0u3rwfuV40APb?=
 =?us-ascii?Q?vwjZxfjD1vYjxt6PzUhJrxRe0GlHlWG+TyP2O/dEEyRHsuARiNnvLTruX/lG?=
 =?us-ascii?Q?baM12OLUKjF7Gew+FS+v0azXAIhqRQDd0rYTTNMyuX73HuZGnuaqUeLYWXOD?=
 =?us-ascii?Q?nFw0kpCwaxM/qC3S3sgCWLzkC/V5K+C5OlOBegmnyfiv8+rYKfVKyPQ60wdv?=
 =?us-ascii?Q?jfZjlWZZN3a9oylZKAGuW5pC2ZCYAPAWMAbDihZgSe7GNK8XlrnhVeGY6BGY?=
 =?us-ascii?Q?lpu/NOoIqGzWKkbhmybB8oQlhUUK3TPEHDq73jCXy2GSJNcyX7NuIf+1e/KU?=
 =?us-ascii?Q?CUalz3q/KmaEtgifsi4pS8tMGL5F7edqpz0M8tFeI7pNZlabEhSQD8jGKMqX?=
 =?us-ascii?Q?25pSeTdlVlFpLiK5XjlGmhGN63rHefzYe1ZBDexVC6itVY4JmAGRurzNw08f?=
 =?us-ascii?Q?NBKJpCJ6J2ZsfyFvwkSUQZ8qhegc8ewg0fGhKfXn/Syvzphke6jSc3qrOZfN?=
 =?us-ascii?Q?ctfkSKJCNoy4Wi30laok5txLBgHtqq5KvMuIWS6MbSIGNESrfhYkQxbXKhsw?=
 =?us-ascii?Q?uhr+/HAccR4kO1d4tGjM8tbXKmWX4XQCr5wMyjnHQh/oND4vHBoRsSo9H7Nv?=
 =?us-ascii?Q?BkYT2O0/N8xSnz1lft23+lfdaPNf15NGtGMxnh4b6AOAxJdxv4LeyAZamx1R?=
 =?us-ascii?Q?HJ08JkdvfknTPez3RNa57pEw97mMKi/fY7AL89e2kD8XrCgqsDCsMO3jndvh?=
 =?us-ascii?Q?/E59OTyJndKqpnlvpxQmT+FFkJK7PH8P9M6ro5KFkL9ePBcBFBIz9HQdRtqE?=
 =?us-ascii?Q?Ej8zhzX8+bnsOiboKONmcns+OOpVnX+D+yTrqPRFivPZYgLq4tqZT+rPSEU/?=
 =?us-ascii?Q?XzNGHNpzfMdXIPaiWRUSdqHKKivpK+8=3D?=
X-Exchange-RoutingPolicyChecked: YgJq/gdahCa406rTet2IotVZdl+F41wYmnIE9NQXqsIp3VmgB4gPDS736wDotnHgJiuEvYxTH77CpVb63DfqsQ6GWpMNN9Gm5ZdSyYCF3vNnoykulmt2InfTrtW9CDBz7PJoYLSolRx3SWzDR1te/Abds/tRAJZl6UTG4JyIK7ZQHBdqYCY5RxGY6BmkxYmMFBPxdj2rdLZnyeBJmhMAd0m5Y30VfQd+TaTAlbS7Z9Sl/U2S2Okmga2uPZTBwCpnh2SNXN81tTEn144jlGVxBl2PeMc+I/+Ky/Bmj5GDd8Y3uOT8hRFreHvAfndUsOj8ZYdzVZFnhB9q6hGffAwqiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c723a52c-3272-4637-8b7e-08de836d757a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:05:28.0510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKCnbsNqpNHLOsCnGgQt0UORuQrkhSxXNcs3V6A3VMxBBdL6Ek6p/zt1H4P16+vvB9aL5VO4vUrfKUceQGc7STpz4tn450JhK5clWYgqgBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9503
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

On Tue, Mar 10, 2026 at 09:10:01AM -0700, Stephen Hemminger wrote:
> Add an "eof" devarg for rx_pcap mode that signals end-of-file by
> setting link down and generating an LSC event. This allows
> applications to detect when a pcap file has been fully consumed
> using the standard ethdev callback mechanism.
> 
> The eof and infinite_rx options are mutually exclusive. On device
> restart, the EOF state is reset so the file can be replayed.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
