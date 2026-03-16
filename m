Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8002FF506D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF9044025E;
	Mon, 16 Mar 2026 15:31:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1CEB9400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773671513; x=1805207513;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WocJOFWb4iUjqJV9b4KKV6zEkPKcQvtRj6DZz0iLLbQ=;
 b=KFVzH2WYHTWUsw9fyB2knLAytJi2hFV7gmzNNncbfjBS1fSj4a3f5I+E
 UgNU4fEUfSNS/nTtrP9/AESDue688GO7m5vFEw5+QsTBQ0Bt8SQqn99IS
 2ohEIglJ9CcFQoZLVdhfRhqkrdJq//cxm7U6z8RjW1EdGWuPDJSLFsAE4
 wGqF5L1vGuOar/R4yslABTbHO8ovO3vwS3YtLllM/Oxpa0r2guCaYhDzp
 ax3u0XT7M8R1lQ6Sje9nykOxo+sAD+QqySdS+yDVkepMNK2Q4Xhd9Dkjw
 TV+Vhy9ZOk1jfe9DITj2ZjBE8cqpStsaQ+UWI2sXbd9gU/AZiNnPagrnA w==;
X-CSE-ConnectionGUID: CBBvlgT4SCSmkSJw0UiF6Q==
X-CSE-MsgGUID: SEkpGIcHRp6n4gs2EQih2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74874446"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74874446"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:31:52 -0700
X-CSE-ConnectionGUID: yjnWXEvjQaOrQaZLTtCSlw==
X-CSE-MsgGUID: GeCHJRl7RSuXyoqsrg5+Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221189532"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:31:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:31:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:31:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:31:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIlJfX5xBLCk7g3spE3N1yTQiWRcPGajBpvKLi25uW55y3/DcOhTODCf/Bd5WMG6JfuWh6z8/oQ9lkGFaTwT4+foM7FIABZFmhjfrYf9Iz1l2XzLyKNoLf6mURsGfZz+UAABZeV9OjhGzMljI/9yWe6/JSEo4ibUM2tCfhLINxwY3jW0NRBH2v7ji4Oxi1i31+pFQy9b+h+M+3Ff9+qeDXO9ejSaq/wPMWkFJ4B28KL47BftbAW+lXPNB9//0zC4iGYXr1fAjSWUKPMy66rSOEf1ydIW6WEH9ZKkDfECh+7mScdFQYHDB9U9LMzA9RPxjEiTj20IYLsXk4mRhEDemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sizJn8fwW0yMo0bgLxFfyFVUtfCh981tTLWHVOxZLw8=;
 b=SbSbsTCO7QhVbIm2DBQ9lQOsCNQyHQtH2oQu7XDAEF2BoOpFRvN1zaD53s6Jbvu+0atq58qDR4+q5Z/ynKyEJMP6cd/veN93PiclfD63EPZo3O9+l2rPL/pWf06ZTtjVIDgwRe4Xeq9op7Pj7UKuvjPE+Nttdqh5caB7mqB7U1j8l12F48rUwzE3yfDsi0ilmd7qwarr3tE1t/ikRtOFMTJHZB8/ZQyz2uqPMOuC0zPWg0lelkwLVZ98+aaAePGQ8Q3juQZJbjjffmk5Fy4bIFaZbsFvvY4cRS+SzFSeEPJZBQ7HJwds3WVm3kbb00kGY3MP3hbnEistue2tMW7Z5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:31:48 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:31:48 +0000
Date: Mon, 16 Mar 2026 14:31:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 17/25] net/pcap: avoid use of volatile
Message-ID: <abgUT5fN_mWeW6mZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-18-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-18-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::16) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA0PR11MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df67bbb-b3a5-4a3a-5e82-08de8368c165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9ufUwGZxtp+j1bkrsni/j430w2AWCwkV2veQVxdN2q/nVQXXiA36TUqPR5TusJslFkgYlE9K/EzbxGkvt1A84yOoKzay7d7wxxI+HPdDGWL60CYSGMDauYMtEux22SQrXNoCBWEtJRfvTWNkFPJsby7Ri2ykkxH6i2I2RgtRqsFrqvOeuQVDcrEGPRnWjxSQPCzyWb73kLM8Hd9Vs4JscOVxyyC2lopaTKhIZ/whDMOlwfRNYaHKI8GFsXaSzi/HPA5QTDFPvhljJl9gFS1wEPO4FHfFjoCeomWxJCAAPsKaSQRngUmyJTeBtqBLRk/jyL2lJHUjwlr3Hi3/2VNx9SFdLZQCQUpA9lCIMHSndqoVP7+xT6Q7JINPS3kffzHbgI/ROv02wqj6nkGGx4zS8F3CecUiGXRIpfF9DiZOkaIXiGxR2M93pCpUHLXUsTNE+5r+5/JPT5gdCABXw3IlpGa0mN87lh42z8AGG3KVj9bQ6JLzwjZ/qS85JYi/WWJm+9Han+Mjjrs/H89EKs8ROoUD5R+l/LvCgV1lMmbmEQD3nhCweVnb76bo/lJIzrYuescYYEvdUughOw33zFWtXOOxzp+iF6WTlKHCpW8xC2cQCg0+gPLORWsh2EjPG+mw6sQbFy0UFq+M3+nFbJMcK5HyIMAW1XMLGktW9k2RGNv23Rtj5SPW6XlLTLmFN2JDt8dWEtEb9CNPbLaZbIWS3YkxzpL3BqpbOFOGoP6zxfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?njSjIvMYPWs2/Q+iQTDeQyKZLtvXGoavhljoh7ZJX0VdFSpDUyHOm/K1jFeb?=
 =?us-ascii?Q?M5bCPetoqyjZRTY87v7UIvn71N4lUhcIaBMVDBoJJTbkReANd9ehri4LGMGg?=
 =?us-ascii?Q?03lVYjUYBek82ne72XfArAR8XBQNCG5blj7b7odCU5Bv9fS48NZnO7Ew8X3p?=
 =?us-ascii?Q?o0hxSvNmTwJSegHLnHg0AAmwdg5X4leL+u3AkAJ92rNb+rJ929bQ8T0o9O8p?=
 =?us-ascii?Q?Ij1DUSXB7g8SiTtHiRF2NnKEDdYutFS6SM8E/LOJjdUH2yxSVd5vaDV3FJlL?=
 =?us-ascii?Q?nWriAwbK0VHFSW0bNXYvF4y2GW/RuUH6sVOO1HqCtJ8ZEDmAwstvoin3dGh3?=
 =?us-ascii?Q?79Ngr3XSH4VYOa5tadR7cB0Yx+P3NVzj54hpdWHMqL46befEooaourpnjDhS?=
 =?us-ascii?Q?jD/r//pWNeflEolVQhuIIz2/3JnlRMTVp1EtrZHXnk6VVdFwX0Yp9VB+EooX?=
 =?us-ascii?Q?DVnxX2+ZuQVM+vUEpncOj0ztYvc82SOaIOsqzZhUhzsVTDay52ljVbzNQbQ9?=
 =?us-ascii?Q?nieovGI/xb+8KwgWiwootvQjH70aGdIkyNQAr/Cj3giZ7CJ14Dx9fMu2Q75p?=
 =?us-ascii?Q?rKUXY5XrfsqbJ8rhdIR6oM3160onjFh8G+WMw5iM7yrIu9pea6f6zIL+B5Km?=
 =?us-ascii?Q?p0pv9Eu6vjCwHpo+rin5EdAHlZY8eswwmBRqwLvk+VVfgBbfSPOQ8cCvi1oX?=
 =?us-ascii?Q?Uq+sGmcwRgnQ2nh3x8C/5/h9hFSAnmg4IO4mazD6OoJgSCddaxNszi0zzZP+?=
 =?us-ascii?Q?Vca4fA12DsNYQ+6rfZw5AbJbhaCvp61QkTrMrQt/c+BcRshVrytZQS9izc51?=
 =?us-ascii?Q?3Dj4MRDKEbdqoUbWk9E+FOuddT+chZkuUy7nRLzH7Agx7GUuQFRifTQ/3LxH?=
 =?us-ascii?Q?HbP9gX5LWJv81nrW5IHgKP4/0PKZ0AqhSBUjXejEXTQDo30NM62E9Bi74dCn?=
 =?us-ascii?Q?sBQmVNnYj8D5zwBGp+6GLLN6CQ4KAJP2sqwboSSAu9mXLSTcPAbSj/01zKhK?=
 =?us-ascii?Q?BpD8rpjfxPkl4hoeJ9xBbEgT93PGOO0ni7XjZXxbcc0Qd7IoAsqOiAv8anj9?=
 =?us-ascii?Q?YKj1KXPXHVO1l0OJgDcOcvYpeDHK1KEhgCzWCZpt+AUQhGLyqnjbkeEDetwJ?=
 =?us-ascii?Q?yKTnfPTpBBI2vVWU8SWGMRsa3UkJRWgpQOOJWGN+4qtYhdtRFjfGAhAqYEo/?=
 =?us-ascii?Q?HDfuPmm5I2CpFrL/oNbHUE+VlPkpObC9j6sDVSGVjh26JpQWzCdm1Bh1HY78?=
 =?us-ascii?Q?LtZjbu5koh46mz/WLPboWEzDYkZu4Cn20M2glbkjSl+v8pEiNiT6IN8hkF/F?=
 =?us-ascii?Q?ZyZDp/djW55/rvTWwvMN+OWxmOHyqxwKHKtAjNZs0+4WsjgX2m8hJJ966XiA?=
 =?us-ascii?Q?vUm8j+NkyEls4KAnQsXhLYBMdVbBOCC/boElUbK/P9B5sNWdQ/LCUmQoDK1j?=
 =?us-ascii?Q?Jj6ZbTZMiLQ2g3TRYdyXB2UdFpKi+y0gbTBHZwb9dRrDFsuOh5kdE7RlNe74?=
 =?us-ascii?Q?hSQlmuiU7u0mryd0ZUbLf7Krh5F3wjnnxpIOio+X2ecKTdchmS2huarbEy0U?=
 =?us-ascii?Q?XNKgsA02vI4/I6Xjq99XwLkAMJWeaQ0hAOFv2soe2dvipgFb3Z/zmyZSGc2n?=
 =?us-ascii?Q?5eehE+ZtpEgBdPocJC/FHAi0myigDlegm1HkE2MQO1gJQg6Kin00/1dr0eON?=
 =?us-ascii?Q?rbCaV0+8S5HOdYTWfQAKtRvBb9d1xE8ffIG4TcuzrSobla4NO4c//eaIadch?=
 =?us-ascii?Q?EtUmQ9tavbfEEM9fXORerT9x3Ca9GoI=3D?=
X-Exchange-RoutingPolicyChecked: t+fsTAHcq6LmdcFLblnIv30HhrIHZagwmR4b5T/Wz2pMVmxluZgWQ1NTwTVfaNP84jYG5OWQOqYGmRkjEDbSfSwMiAqm9I0DtbX0rukOOaBJNsNS6Vczm3WtRKQl58+RTb2zOXGt3DV76ZaZKE3PvgwsMzqb8C1YhnRAwUOUF8MjxL7YRX3KoYiEnYPtRj/5h9vzOIAIXcYBpbotYf5Z8XfTVmAkvQJ9WYp7OSQxaRAsDLPkX/69WrJBbiQiklHO5IvkVqtjj0ND/vvlJeGpgNAMAtwlfc9RBNBU4ZGesQroJogu3JmeHQvt2RDz/BM7tj1VCDMHE6A5j7pd0kRieg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df67bbb-b3a5-4a3a-5e82-08de8368c165
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:31:47.9630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfMjU9ayk3lUIeBg4mYBUU5KA3ErDTp5M/N4Q76F7D20BKOC4F9kCegQNxqALrR16bD/USXY5C7KUFqanQs/kXwkbfMUziF71nwdRnJCPDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
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

On Tue, Mar 10, 2026 at 09:09:55AM -0700, Stephen Hemminger wrote:
> Using volatile for statistics is not necessary since only one
> thread is allowed to operate on a queue at a time.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Well only one queue is allowed to change them, but other threads could read
them, so using volatile is correct in that it tells the compiler not to
cache the values in registers or on the stack. Technically the compiler
could have the stats stored locally somewhere between updates, but in
practice I don't think that situation could ever arise for stats. Therefore
I'm ok with stats being either volatile or not, I doubt the resulting code
will be any different.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/pcap/pcap_ethdev.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index 8be3a59690..20e4b8e6aa 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -54,10 +54,10 @@ static uint64_t timestamp_rx_dynflag;
>  static int timestamp_dynfield_offset = -1;
>  
>  struct queue_stat {
> -	volatile unsigned long pkts;
> -	volatile unsigned long bytes;
> -	volatile unsigned long err_pkts;
> -	volatile unsigned long rx_nombuf;
> +	uint64_t pkts;
> +	uint64_t bytes;
> +	uint64_t err_pkts;
> +	uint64_t rx_nombuf;
>  };
>  
>  struct queue_missed_stat {
> @@ -901,11 +901,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
>  	      struct eth_queue_stats *qstats)
>  {
>  	unsigned int i;
> -	unsigned long rx_packets_total = 0, rx_bytes_total = 0;
> -	unsigned long rx_missed_total = 0;
> -	unsigned long rx_nombuf_total = 0, rx_err_total = 0;
> -	unsigned long tx_packets_total = 0, tx_bytes_total = 0;
> -	unsigned long tx_packets_err_total = 0;
> +	uint64_t rx_packets_total = 0, rx_bytes_total = 0;
> +	uint64_t rx_missed_total = 0;
> +	uint64_t rx_nombuf_total = 0, rx_err_total = 0;
> +	uint64_t tx_packets_total = 0, tx_bytes_total = 0;
> +	uint64_t tx_packets_err_total = 0;
>  	const struct pmd_internals *internal = dev->data->dev_private;
>  
>  	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
> -- 
> 2.51.0
> 
