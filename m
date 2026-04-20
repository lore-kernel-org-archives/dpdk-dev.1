Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD01F5A8A1
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 17:05:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EAF5402A2;
	Mon, 20 Apr 2026 19:05:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7800F4028D;
 Mon, 20 Apr 2026 19:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776704723; x=1808240723;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6RY5XjOgAE78Uw/MmK9maXwlL1Y2FXzLyEo12YOVrsk=;
 b=C0DjbO7rUHg/jJpQH20d2z7Nm+vKINXuwsChOZ/cUMEgkT8zwPJp6RE9
 GlgUwt1aQAQ54pcm6bUEP17R7At+1ZdDbWk/3BeBDJ1VEUUC1smiylLn0
 ULHltEgkOwMDh6gCPxNtzb+SwyGbPB7aCPiPHVW0V1wP4KKszmJSxYVSW
 wat7zVz5Bj2AF51EzFykmmD/GuvYDx7oOwU1mahCJ8j2DP7YBSZGEh5CN
 W7LbD3s3tpJxAYbhS7KcQoYRvgwbC8J/Fs6DfH2bNDTtA013aSkVmssuX
 ayeMl3bz88S6IZqOjamv8mppjlZJx/WLFSZXv5NFFH9bFw6bsRgzHTmel g==;
X-CSE-ConnectionGUID: QhcmSSFDSJ+LOMeTV8EKSg==
X-CSE-MsgGUID: CA1TWsGkQ6uXoIwdRQHppw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95037624"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="95037624"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 10:05:19 -0700
X-CSE-ConnectionGUID: 0otnaBXKTvG5up3LsxXEaw==
X-CSE-MsgGUID: k4oUVUicSlaVAkBWmlEcsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="231684330"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 10:05:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 10:05:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 10:05:15 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 10:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doyubhcCIpG5U40I59/coUyQq450rzZPsN/nMfEOYjMyK8j6tbi7mY/2z1eqCXXl5a9wOPvoEJaUATw46qtFokmPmllxU7kNP6a2DvQhlhusDeKJqbyyZkMuTis9pSoGgZd7iFTKiyQe33fzPEpvpjPfWLlDyq0BnwziBO+MqPbnXY1+JO7HcaaiQmWX0WtjEWbFWbYJMFMezVrOFfGzs4Qy8UK+G53Fif0fr5/e7XWNvPuh7NhCi1lY/WQ1XpwzSeJZAml5sxrGn9d92PTufT+qKB1epaaTA3t2GO0QUcuj+OoRre3vo1flNYyUlMQxPz5xpKvs0J/thlKYiKiOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdvNigREM3tyyPOShVWmDUXJED0FhNcU5yGem/epLzY=;
 b=kdbZgNWRfkCoimwFYZ3AWO0UCA0aM7ITF6e4D/AZMiwwJrMaoxZuQmuzJpPrnSG+TYd6rskJHBfwf0F0WpJh6pXhbD0f8hfmEPSu970ZEiYFjim1wrsvBSCSDFSDszw04xkLmHbvwb57CjlOoXXzhJwI4tmMwJtIuOvkhyDB0MvpidPe/H8arYNDYXPHr84ptwrWCUoAA2gForWb5l5GDZQvjdEQhJC0vV3mSkRBi2/CXX53SZ22KfXzKpNQcxm3IzOibFqWQ6yQjjrTlDQyrAWVwXVR/g1ZLsrSEkMpIoGh2L91ujajPujy6pin0ArLxsCNImTqbJF81Fos11ukgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 17:05:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 17:05:09 +0000
Date: Mon, 20 Apr 2026 18:05:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: reduce debug messages
Message-ID: <aeZcwGty0qvQUIbc@bricha3-mobl1.ger.corp.intel.com>
References: <20260414052603.201114-1-stephen@networkplumber.org>
 <DM3PPF7D18F34A1AA387BF494651F0DA4918E232@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1AA387BF494651F0DA4918E232@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0166.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d5dce8-2125-41ff-128f-08de9efefa03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WhqNU5V6Fit8LVAt9/WnJbUClSNA1CK614Ye/xiCiCijUDtAEZp4QN1qIrQDYwxobNejAcRcGPDY8rEQBvDSBtFCEV8mlXuNKn4nxKi96xkk7hzpFIazzFDUFm/ha3FS0B4TIsOuonYisr3vFneQ8+onxmz11DaQyB2zlj0PQx0B3dH1bXK4qHoby17bhH3b8xw4Bzjb94NYkNptJNlaRHvfWmASLh485hkNhsdSW3MyGVjvmWRlSwoA0UTydKYVmkwnrEICaid6QJVe+Ao3nSAbPpZowcmLNlRuMooz3rd+o7f3LeFClcs5g3of9dMyxtpYO8JQ/9PreSERzjBkGfS5w3jRjrtLIz9gytAER6eBAIGlrJeEHnZvZKEJCA7sI+UMaxtgbV+XBLyE7KOPVQwe2y++BjjmnGT1WQ2XTs5JtXsf8HK2Axq9Ag48FKjoOqJYh+eKyo8XirZeCDNX/YcDjbYpnlzZEVOv1bXyDutgxC8d39gAe3dZahwwDHlW6Ceto+YDQFqhR6/rWn5SQKEU5ze88qK4YqsvGAGBW0cPYSPpWmfWFDaSeZRMWokgqIRcTWp3i3aconaC0X3j/cY7hd9n8Ox+niCk0RS0BImk/1unT+vrqfoyBAInUjtOpJN6u+816Vwx+E2EOzklpLdW7R7w0/OMR6Gz8gZw6cCjvVOb5CihtfGEPAWqYDHDXioqMYyN+j3O1Wl1cvD2xx121uxzZZ56Jyh5NdANXpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ej5Wbx6PvwacQsmAwJdAWRxMzorZ5ASMTwYkcuxzCDaR+BKLM3TJ98Z1GAG1?=
 =?us-ascii?Q?4MgZrzQ4MxmGp6uFRJYgG8urcdh+HE6ieQggl1+df3KDuDJWpirL6P/HVhcO?=
 =?us-ascii?Q?55/Dn+NcgOelrK7e2RwLRaQYCNjkUu1s/Qlc0GDYAMPnf7yf5xFgmAzrFCcI?=
 =?us-ascii?Q?+wQNUZ6cRSljQGk6mfPLpJjJwg41tbi5o08du+oqlED09U0IjnvcZ4nIeIAz?=
 =?us-ascii?Q?TdwstWRClphCyGYAeIsoKfxYas2IrBpwalYEU8rdh45unFoEv27aEqF4QluA?=
 =?us-ascii?Q?vJN5nFUZJ3DXF0RBrvPsnOGLcBPI/MHWSa1xZyd8nhl5chW9VnNk1GpwN+p2?=
 =?us-ascii?Q?AzGIywL9Ch6YNdYkFfuJEoYyFpdKkzFeRgNH14AcQRRQ03gybqO+XxnXEO1b?=
 =?us-ascii?Q?gFPSlmWnYvxV2U+P7FMJq5r9eJq490VGCeD+xpV5pWbraMswe5eD8oDjbek0?=
 =?us-ascii?Q?pG6pwdO3ScWuLgSzQBAGmQloHAepQgvBmeKCKNIWChWs09vf5/fpv8OzR1z4?=
 =?us-ascii?Q?mUbtma5aEN4kPIRSVfVq0WrlC5BiJ9ToJd1R7srYroPC/xkJa4baC/HNieXq?=
 =?us-ascii?Q?3dOh5vB76IguzglM/DmRsDVcroBGp6s2PfIeKgLTpn8D1s4QIBW6G3Ujnl3g?=
 =?us-ascii?Q?bRoUfZuZuJY9H02Hhe6tP2xI4cQbuO4ls3dnLvlrDRVP/MCblLUSQr8Y+eJm?=
 =?us-ascii?Q?asDFi2xRTQnwY2wlU/LGW84kV5xOFe6SeUKSQqUcf870gE7umV2OI3nKlg1S?=
 =?us-ascii?Q?fc+5bNktzhh/PgI188BX6WCd3VJXhkfq+ozBQsA1iJCn3VaRjd3wZnb7WrHW?=
 =?us-ascii?Q?nwHrxHcM63HbOmFvNhZjQXKj+zNEUAVBbZY+FBznU+j3+NNeDOmEh3w40AzE?=
 =?us-ascii?Q?xu4KuBoIUMIrr3Mr87DWT8wrojwkVbutEWio7i+JjUmNC2iSQmMmi97AQHv4?=
 =?us-ascii?Q?rEjavMiHp7ZpgNGNxMBlnCrZiu05Q4PVjmwLqX8J9168i3vjFCfBvppy12TA?=
 =?us-ascii?Q?Dd5zD+lTjHlKsn2ol598R6EYzPzNhv2m7Rzt93uWaPiamtOdwm4NaS/xCA/9?=
 =?us-ascii?Q?wolD2WU8huQx4PSzUiypzDgCNWGZHu07uJ2gW9GEMqN66WlgbQWt+D+NHj0m?=
 =?us-ascii?Q?O16EVA2ilFtqK91VF3ypwVEqtcsGbdsWWYjy+ZkqjBHj3YNAireVafYUTiRV?=
 =?us-ascii?Q?y4CRCfNaYVhlmUXHL7DPFwibcO7vIRi6aSot32QIUk/vymy8/s75J1VlLwxK?=
 =?us-ascii?Q?VJsXYnBXmKxwu9piZN8duSfz5IDTwyXh96NJWAs9XC9BCzA9/8L5ZmB61dkv?=
 =?us-ascii?Q?n7rFsDYSQp+ODlFXnt2UCRy8BJ3mHYfRmCeeDj8Mc0BOJhupr260kwr8T3W+?=
 =?us-ascii?Q?bUSoVlGi/w8bckc2Zbpuelg+y7xQWAZwZ4buVuwz+dZkO0voI6wIV1LlfO6i?=
 =?us-ascii?Q?uBW4LLPRtt16zYxkFJWCi74FGxInebRFqN7IvrK+fM7ti3RcrtnttsfewwrD?=
 =?us-ascii?Q?/SJyNdHGg90Y4jOIgVlk0JFz0g7nBvdfwQOIrSbIVkoYu/8NTxsit/R5YrZ5?=
 =?us-ascii?Q?/YCNPDrzXkCVzpAT6vugLwkNEWHqBI0fHlDwKiBivdL1ZtQLPlqKdCOopmhw?=
 =?us-ascii?Q?DTX7E02MrMTbCfLOuFe7bI/KEvvT8wo+HLW1USSLw8IoLvcie2/xKkaJKyoA?=
 =?us-ascii?Q?lW9XVUTaACzuszw2Q9Nt8JMJokrgvpJYl4w6tzXPOchqji5As/42STUbPn9/?=
 =?us-ascii?Q?Zs/DddpaWPh371OOmxG4lkc5cbFlrMw=3D?=
X-Exchange-RoutingPolicyChecked: T7N3A78LGif5husWgj88YMhHb+AetI70RxULh+diyy19+tgMdMNDCSWph6ZgIex54H1TvtGUyTpn1LuRn3J5WyI++w5tMioYT9hxnDyoV50cr8W3DqntxLKxOhHFuhN0EylUU5Hfi2h/7/zbN03U889lEung6flQKWwFDlWZmkxkpphCJahtaZ5Oa3dg3FuM//pShDt031GIEYmLOVAbJRY/aJbOUwKY5EBRzLKvxuln5ofkMGTMo/AWMenF+cziM06kuu1mdkOmWiwN35UfYybdfaqiOF19CTYlZrW3ERxru2ROwgng4yfiMMkGKrygeOTug2fQQ8vONNCMuuGyCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d5dce8-2125-41ff-128f-08de9efefa03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:05:08.9325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4wbSxg0Jr3cT/gf2EF7QSaGA2HFrUQ09jWXA9zDf04ummt+mzzVTvLyUlEsh3l46U3vz9uJYzMrJDXjEOgdhpORKDkLCBozhmxEYXCD7ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
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

On Thu, Apr 16, 2026 at 09:13:35AM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH] net/i40e: reduce debug messages
> > 
> > The driver logs normal things like choice of AVX at NOTICE level.
> > This shows up as unnecessary noise to regular users.
> > 
> > Bugzilla ID: 1936
> > Fixes: 3f24891594c1 ("net/i40e: use common Rx path selection
> > infrastructure")
> > Fixes: 8d57c1788806 ("net/i40e: use common Tx path selection
> > infrastructure")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 

As with the other patchset changing the log level of these messages, I'm
not convinced they are bugs as-such. However, since we have a bugzilla I'm
keeping the fixes-lines. Dropping the cc to stable, though, as we don't
need this backported.

Applied to dpdk-next-net-intel,
Thanks,
/Bruce

> > ---
> >  drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> > b/drivers/net/intel/i40e/i40e_rxtx.c
> > index c5ac75e0f0..d00548ac89 100644
> > --- a/drivers/net/intel/i40e/i40e_rxtx.c
> > +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> > @@ -3042,7 +3042,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
> > 
> >  out:
> >  	dev->rx_pkt_burst = i40e_rx_path_infos[ad->rx_func_type].pkt_burst;
> > -	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
> > +	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
> >  			i40e_rx_path_infos[ad->rx_func_type].info, dev-
> > >data->port_id);
> >  }
> > 
> > @@ -3124,7 +3124,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
> >  					 i40e_tx_path_infos[ad-
> > >tx_func_type].pkt_burst;
> >  	dev->tx_pkt_prepare = i40e_tx_path_infos[ad-
> > >tx_func_type].pkt_prep;
> > 
> > -	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
> > +	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
> >  		i40e_tx_path_infos[ad->tx_func_type].info, dev->data-
> > >port_id);
> > 
> >  	if (ad->tx_func_type == I40E_TX_SCALAR_SIMPLE ||
> > --
> > 2.53.0
> 
