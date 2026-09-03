Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBC6C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:27:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 859ED427B2;
	Thu,  3 Sep 2026 16:27:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 7A5EF402D8;
 Thu,  3 Sep 2026 16:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788445660; x=1819981660;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fJotPMKLTVOWGieCLD6O+uzmWyFMusr2VjV8ccrLdIY=;
 b=kMyJZ4Bf3RckovzKWwydI/H+A8UDUS4rR+FMZvmjFu/a67lgf6whrEj2
 ohV6HtRcm8egGg2rNj3YGYeC59pqy+L/71FIk0BkOPFLL1s7rHQPamVY1
 4SFnAc5gI9qKi0M6m/mIDeMiYtiRzVcr6Tt4wbEJtTxDsKz3JD46K/eTq
 zL9Sp9xWU7BiiBWSoqSfOL4sL1DBbwn0EU3uC6hKJ+kYP/5VOPk/d/GTj
 5YjKAT6nAM3Ys0+9hWCEeqWz+fJE/Rdw1hOl+FHu41M+/voDIe2w505v6
 xvOs34/lMqtK+eVlXgQNBMBB+xaUgXIgtJVQSabbNybK2a0Cm86mds5aO Q==;
X-CSE-ConnectionGUID: ETPN1iyIQ7mv/sVbjk5FXA==
X-CSE-MsgGUID: ld0mv8BDTD6VWuZ5xUvx3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106450703"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="106450703"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:27:39 -0700
X-CSE-ConnectionGUID: nsk8DPJ5T6GwWxLTuQ0MvQ==
X-CSE-MsgGUID: K0JW/QSqQpa/hnDL0OjaPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="299607763"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:27:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:27:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 07:27:39 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:27:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYyso1T197WEwil8U81xIxi5l1yqbPDp+iZrx0W3iUfB+RhgQ+4GeHhJbwLkYTE92rpgwIko1TYW9kvkVyywWu49ECmBy935iF+QIqwXSclhMBCW5cLzd3Y/SCqaDc2LKZQ+yxmEuarel/i4AU+FZDvp2zYUA720nu9lXobN8zNbg+xrJ5+0TSzjsdkZzCeV4D//4I05flj02S8inJ83RgGEurXYdpSlcIeMQMDVorVK2AL/KfOs74sen5IzEquFNyEu8wlvZEkQ4ndxO8oa297zaeNDJrCQ7Bu+j3H6g8IspBGn+yKylDgKeO5rdvkj4zsH/PQxSSa0ZpY+E+lgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E28hqccbob2XbYsotQkJH5OdVmILCbp92QYCZvSUhQQ=;
 b=Tf6SKr7QHetSnMQCakr263o01gbyOv4LZyJxUEeRFRd8ajNFXempm/vX6XGNaf71vnGcNwTnthmBPYf1UFu96xq9v9G7n6X1VWTG5kQa1pY54VAl8K5TcGa7fDEqwDjCf6fyFOkKOd5mDTtQuKOPHr6s/9kiQ5jEczIxS+pHR98Ul4vYuMTYZXJbKz9m6L26WwmUdLUx+cNQIm9vvEHOMbcHFLIkEb46nuo/apgNaCqhax1G6tLsM/XZbXX8U3+eTcaf5e7TrrJY3dPrqDZxzkTgyedFbrqpdz4ntrtbaJlpQFgfk6WJ0h4ElbUFyL/xNhyD5t1IqM6pnz5PCczBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS2PR11MB035193.namprd11.prod.outlook.com (2603:10b6:8:3c3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 14:27:35 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 14:27:35 +0000
Date: Thu, 3 Sep 2026 15:27:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "Mandal, Anurag"
 <anurag.mandal@intel.com>
Subject: Re: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
Message-ID: <apmD001iKe_Tut6n@bricha3-mobl1.ger.corp.intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-4-bruce.richardson@intel.com>
 <IA4PR11MB9278A14D684FBDBF1A138F158EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB9278A14D684FBDBF1A138F158EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0063.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS2PR11MB035193:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddd6724-e09b-4150-e8f0-08df09c77f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: c/5CHsfVNjB5YxipO2Z0KfcGfSg+17/o4qDBDbR3/nbwo5c8UrY0G7jv8SaS060zVwri1NokDak8O9A07UG4Kdql3bDf6ayEb7es/Vj973evka/1EocsvOrZU7oQsv5v6RoYERmyGZUeyrwPEe8lIEcRfQyJlHPhK3aOeH7A7q+bBT3q6BUdSxQmJHbG6HpwydqgLcsPtInC/HnT1fI9VUW2/PpDOpdICb6LkTs95zwUGgHDJREuY5IxaCiFSLsSpL9+D/FiltUQIXxu9QHE0Z5/Wuq/RBNQhZF0UqtaUTx7drERB9EXvlEJadsfnE95DlfhCfj0+ucuftvbZQPf+dG9IeJhac5ToBm2/E32BxbL0a+qNMItLjwzUyqtPHKNneuVZHWMEVLEcDl/a//7UeNxUEuNJD6H06oAycOB9SJXMLyADr+LcocbmOAQG5ohhzTUGE3tm8oxl6ThPNI3SE+GVlcCdU25jP1jdsISO9mkMQ3N927ETUSQnEms8JfeulFoD8pgm777Obz++Hu6IbDzUkHcoT4ZbfdAooiSAEUesmpXoAUjEg2QElpml0uZyrHL4/B3S/zdcLHI2tbwEQ1ssNAFutaAxyi0UqVjt8Fh/ZMtQGuFk4JhEU94MhhnioB2fjE7IBr2zy5OVzaaLw0XUGJScrkJRKRLs1g3jLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHSxrqCbPFG0Aqpnpj4qEATysmWQ6Kgy9fDdIIBvvoaK4I1qElF9TDs44Kk9?=
 =?us-ascii?Q?AmSJOVcJkbculCX52v1KuymALEHt4bqxcR0XaE27MK8/fo1pfkd7ce1QiApU?=
 =?us-ascii?Q?Ua8TlxyzHCH99f9+satzzQukiaRd1ieiAqBckvP/xoJIgugswxTzA70Cn4YZ?=
 =?us-ascii?Q?KA6mTBoypsOmIBrnqycqkWYGesHt9hiHbEuJCJaIyCFT0W4Pv6EJOoeawr9O?=
 =?us-ascii?Q?lANtHpgfdDb6GPIWmaYQJvc6h8zz7EIL7dLbYZxnZZyG9GRD+D+C/SqTdZil?=
 =?us-ascii?Q?ysTIT9DPmMwQUrc3KHA3hPwz+vnCQMS+eIMZh/lzDI6zC/z9WN55LlVV/EIA?=
 =?us-ascii?Q?EsAYPJHufufCy7oeB/yDxMAuNq2FTHb85fBp6ni/px7heX6nAhB4C5xBKum2?=
 =?us-ascii?Q?3PskfbKO5uKyWV6+mI0t4Awlab9nEEziDLshG73DXuKJDnV8W1aH5KlFFTma?=
 =?us-ascii?Q?BA7S5erwP8yA6wWDE8snU6Wh+od74XnH/SKxFYsX0qxV9x6EzFle4vF0v6k6?=
 =?us-ascii?Q?eR1mm0V8muMhCCigwhKD92BXpLPhXksQZNstyRCfCOKrbAZHfNRFwtgf1nnk?=
 =?us-ascii?Q?3sVSsj5pWt0EY/OehamwwETFzlbs0uiGt80dDSeA07iW5TXTinQa1EaMx3HH?=
 =?us-ascii?Q?DQOoM/h3tJ0a/K0gaETcq1y7YKngQT2GPvXAWcrzKnA2wQP3Lp2ASdfsLN3B?=
 =?us-ascii?Q?qVJinzmSbRbVSFCXxvR/AEuwx/YeHR1XFwkuDQPOq2mMPnyE/haNSGy9vuFH?=
 =?us-ascii?Q?ijAaXhqeuueTmKeIsZZO2ZbcoBAvQK2DhdvZxzyVhtrq7AjLxW/qy6zNbCJS?=
 =?us-ascii?Q?mW8TI+dOmrojBqsVeaDBhB55cJThAi5Lna6tlBUPlvbySJiBHonMCkBJ/v0E?=
 =?us-ascii?Q?7KrZH0DALI0AlLy/WNqSEZVeIARxuD/mZl41FsOyVCUfR+4geWHGIGxPd7+M?=
 =?us-ascii?Q?hAyn9oWpTxcUfuB8ASOIhuoyuWz3NSloaIIVtO+Qb69au/3kaN3mbwIWCfmA?=
 =?us-ascii?Q?cc9yne8vvp2fnPaH8BUegMB4qCE/uLfe2mQ1lr6Pe78XdbZ1R0VM8sww3tEz?=
 =?us-ascii?Q?kE+B6I09we4TBApVsdi6VpyUUfREnyi4j5gLocA6u5BdULwXfAaXdnWpTXlZ?=
 =?us-ascii?Q?aInC9QpTI59DMrfH8HrvGj0jLrzQnbZWFMM0omS2OKATwXqDJTMb4fOHCjqG?=
 =?us-ascii?Q?YNOCHVy8YF5dmI+aPExQkbndC34If6f438Bl55QiWPleA0N8cwpNgmHUwnpZ?=
 =?us-ascii?Q?dJs4khxFTFtUk/EiQ6k1vIjToimtQ3IHaM22Gcy4O8QzrNPRnR7kx/7WJHSi?=
 =?us-ascii?Q?t0badkEP8O8pqYY3O5HrmQ/NOOs/H8glGW5+iaL/k66MHSCjUMEuitqgrQql?=
 =?us-ascii?Q?J7SHWZcJN1S0hW3BRqfXQULn6/guFylb/PYWHX3do8O/Zy8ig6algisWslDk?=
 =?us-ascii?Q?28CwuZSwXIDhi/R7wYUx+6pHPpmAH5W8EJ+jwU2l7uvdWj+CAsTiqx8OTCYX?=
 =?us-ascii?Q?gWeUN4OSOl2eBwDRpPU0UgocelEoPKGUBRgtMDaUFJCeawqgLCzsvHgvnqiq?=
 =?us-ascii?Q?ZKP2YMennu4bX1a5wRaiJjkaVt1jVu9TjSSnVoipydckzE/wmagIgVCZ6Pmw?=
 =?us-ascii?Q?H8ZPt2oapt9KFdhFZOLNh52yQc/7e+5aFpYBLPr48zjmtWDGGyPnM43dBkQn?=
 =?us-ascii?Q?oJQJN4PUnjc62bqB1LcaQ4ozocvDgJIBdMCaD6YW9ZU8PWoa6c9rRX4SwLRd?=
 =?us-ascii?Q?BaI5JNgxKTvnC7f/DA5tjNRMJmg88sw=3D?=
X-Exchange-RoutingPolicyChecked: o2hNmvZu7+PAMc7bn0ZCHfYKUmo+909XMRIBjPTHN9Hr8LMFIVn/dxkjmpm58rqszo5iIJA4EjzESkrwnqE9QCL47PcbIZ8aop6sRKBTyXBmTYSkYDTuqCSE7fIIkjHBA2nrSyCQoXbiV6U6wLgCfMUpRf4+W5C7UHoSTRnsf7A/r/E7ES7AHuv33rWi5zvJh6oYMDseYN4o1Jl9FH/CG69Xyu6bvQNq2X5NIeM7FgfNrha6RdUNzriNOw+llQ39rLUAJddvJixuNAc1xXVDg+7wt37c8UeIy4Oxv75D2KKKQ7hRB53FAoIWgATs4Nq6And5YICyvuMen2k11epkAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddd6724-e09b-4150-e8f0-08df09c77f6f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 14:27:35.3007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJtqEZl6zaOi1XGKNQ4tPHC0xIX6/35xtGIcPKORorCbcpDbGhbag5IpjqCNqv65G2qVLq9aiMksVwja9zONpo87LvLJRcD+6gAusAeSGDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR11MB035193
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

On Thu, Sep 03, 2026 at 01:58:29PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
> > 
> > The outer VLAN TPID setting for Tx was cached in the driver but was not
> > properly pushed to hardware (via PF) when changed. Add the necessary
> > push call to the update function.
> > 
> > Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
> > Fixes: 7ce1363b424f ("net/iavf: support QinQ insertion")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf_ethdev.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > b/drivers/net/intel/iavf/iavf_ethdev.c
> > index c4a6763f28..126be4c9a5 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -1461,13 +1461,17 @@ iavf_vlan_tpid_set(struct rte_eth_dev *dev,
> > enum rte_vlan_type vlan_type, uint16
> >  		return -ENOTSUP;
> >  	}
> > 
> > -	/* This API only fills internal iavf_adapter structure
> > -	 * and does not send any signal to hardware.
> > -	 * Inner VLAN always 0x8100, so not set explicitly.
> > -	 */
> > +	/* Inner VLAN always 0x8100, so not set explicitly. */
> >  	if (qinq && vlan_type == RTE_ETH_VLAN_TYPE_OUTER)
> >  		adapter->tpid = tpid; /* Outer VLAN can be 0x88a8 or 0x8100
> > */
> > 
> > +	/* Re-push insertion, and stripping if already enabled, so the new
> > +	 * outer TPID reaches the PF instead of only being cached here.
> > +	 */
> > +	iavf_dev_vlan_insert_set(dev);
> > +	if (dev_conf->rxmode.offloads &
> > RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
> > +		iavf_dev_vlan_offload_set(dev,
> > RTE_ETH_QINQ_STRIP_MASK);
> 
> Should we check the return value of this call and fail if an error is reported?
> 
Probably yes, will do in next revision.

/Bruce
