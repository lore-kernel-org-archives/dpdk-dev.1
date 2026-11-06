Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6F606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B6R90CZJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BEDC42D87;
	Fri,  6 Nov 2026 12:59:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id E152F402B8;
 Fri,  6 Nov 2026 12:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793966352; x=1825502352;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=itZmBnC3I/vbjDoGkftx8BuE98h7clA2oYfhhYspqgk=;
 b=B6R90CZJpn9DoQx0BPBdhznN0QN16GaK1wxiitS5rvzKJjgp0y9gI/IG
 af8FyCEMxawGvvbfOfecYnwCl1Qt2WdRisbNp0O8YwjHjYyI9uJ9uZFpW
 BzyubkFWdO6WIGW5hWsVmWS+KmEfYNC+3uns4RzjUaNOLeLinYogi+WG0
 ZDLTWKOf9b5gTRfc6REQT8N4lbxxxsgVEfURh64CaNtf71c8a+IUPoRSE
 /x4PMyqOSIB5OMmFvR7bDlHKJIHBFEMMLHCmbUoWJjCbbo/pRlAwX8w03
 v2sj8JkwtedZKPzs++8LbIzMuzNwqUjOhCzHzXYSsdGqgmeyudzArUGxW g==;
X-CSE-ConnectionGUID: VJP9aLfYQ1+3Tpx4+xfwOw==
X-CSE-MsgGUID: kLp6uEPUQ1yiFI5B1eEnPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2675874"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2675874"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 03:59:09 -0800
X-CSE-ConnectionGUID: KYgGxHlZQX+BlGTEpWZ/OA==
X-CSE-MsgGUID: L4NvycQMSK63b69ChYnwhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7376564"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 03:59:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 03:59:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 03:59:08 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 03:59:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5hfLDJbeoo3M9mzYkJjV9KErGaQugR6Vj8QfOO6ytTOQwlSvub5dsCr1gRY5on8Ce31QA89qNDnFCCKgbCCsmNaR6SAAOoksxaOMpo/07vAFmv5dUQisSY3dcCT0eP9kRYyrpKNmHmSgB7EW2mZY/0dyLQkDf+jr6IGn0bLSUExtmwrhGhUbcCM70saBnaaRvhowboJInYNHwElK/8MpKWmeG75TdJ7lzq08KfTUIj1GNrc8icktCkOG8+eex8NlID/fYdOJPA9Oz1GJxeCIOhNdKKKopr09VUOVjdUwMqAqlpuc1HCBCIMwjyRaVWnpnRm0j6TJdoA+5Tim38tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i1tp1DYpkhOpmpz5PNPxyF5v8I0TIoPuNT3pMtWIkE=;
 b=j8b9mZvMHhbp/dZ5MY738YjDIaibwkXlCophDv7pnXdgTNz3hf7Mf9LgfmpUrhASiu5gGMEMiMm88xOg3c+yPsz86kbVaR0cIpfc2vU1VaprPPkw3X0SVbNQbU9fgMPedCxvgNvVYcpQ/DrLkU+JfuZjwMxffD1OAuUhvYRvRboBLaATn3R47E1A8TLtuhYe0LEU0pfvYUe6hNjUuujzYJ87tryTYRbEQd1umPGOIiJEJE7ZQByuI+snKdQiPK/hoKF0Vl7ESAvkeUUvljy1oiE+rVsVRKGi/d2pjadJdiqOkyELFjUx2AH//GqEzWzjl1HqSeU0DptSlMKY66rZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPF691668CDD.namprd11.prod.outlook.com (2603:10b6:f:fc02::2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 11:59:05 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:59:05 +0000
Date: Fri, 6 Nov 2026 11:59:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 3/8] net/ice: fix DCF queue config buffer leak
Message-ID: <au3BBKimpegD0Hej@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <8ccf28d179a10baa09fe9c3f04cb836b08afd069.1793871697.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ccf28d179a10baa09fe9c3f04cb836b08afd069.1793871697.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPF691668CDD:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdde5d4-3379-4de7-5b30-08df3bfd5b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021121427099003|261022113327099003|56012099006|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: emOsR3fdtz608K911YmAygCF/vnH7r/PHkLhmYz+By+G2q6CBfjpnIO9Ui+ex9h4Y1g8ff9hczjkMuPfriwuXHz0GH9AnTYgIM7BvIpg3dP8wTgIVqFhI56Ul752F3GVctsZXQ/3rtdrvfaWl8LRMHKhj5kswCHVKP+nUhn9/CTWWTT7IhPv7oU0aoiguvJGvQux0Qly8r9Kh7lDOJZB/pRmUr1lGSvp25QePN7MqQnnb5ANt5C7c0JZ9xnSsIW6FNxpV3p/Kbw0BgEwAGjmWVIsquTkqiHnH9ekLpzWHVYVRyDjMLHKomjlECC7mVN/fa8rT0gQ4pZOpQ/fkD48jalRLvfcz71QF3pA/jSFcakoBmlMN9cRjZQXSAjStVmudUi1yLImAQNEPxNwNI3b36paxTbgYrsbb5m/otLJiI+5iQw0H5DXl+iDQA5bYOABJK56JiNYcfcHIGNxCfpqnFabYDuzRffU4nZrikTx1rDrp3KL+GYr1NCRqLv59EqRprj7GlQzZqu2iogkN8SWlw+IK1e4KBn0Khj7W5kiyh5Po2YNWOmyQkqI7YKG8IJQhlLCOw+14qAdVgMhnaj5N40MRgQFNvuceJq7SSm9V+MYNocFc7P/oEE8IEZjNnmSd//7OuVTp7DnJlC9CAKzqtwNLE1vmrXEhUKYnmTsB28=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022113327099003)(56012099006)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?en/5N7Kbko9HsJNVECmZQFa9MPsOcgd84tozb+gm+ysz14lczx+37xW+HhfG?=
 =?us-ascii?Q?exmTfg96rNHHAQKt7B0Ni3l5e6v+oJBhFQVAEyNb5cZ0qFp0RllLuxQZe6Gx?=
 =?us-ascii?Q?Fs+3wzc+IKlO97klt+eGZjdT/A3lsLM7QEAIVC0py50n+oYfDVWSFPmKn72U?=
 =?us-ascii?Q?b4MDqlPYiT4PvodaOvOqumKaxwvboaCbutXCnxM5SVUP2twX67n3EctxruzL?=
 =?us-ascii?Q?RI7X1ooIwyrkdckn6JbxgGUNJPUzSmdriB837TRv3vUnxa5arCT8FBeXlkfP?=
 =?us-ascii?Q?a7QBKD7cPL2smgJaDSIyin1A4hkhSCStVzI/KEW+IrSg4h6Y+e9ShwUV/Yl3?=
 =?us-ascii?Q?MITOfWd5EDC6kj0PwV5oKHoELTxItzB9I7ve64rH7mi2iGPIs7wCg+mEFSpb?=
 =?us-ascii?Q?Nejv2Ored6JLO0oHugJK8WyxBA277/rW+UNXtWKOc7db51dYRlVlhXKMwRGM?=
 =?us-ascii?Q?tc0+pcJ1Kj4UZjqB9/budhoSw7QS/PnUH/nvZ4gFQh1XTaoIMUZmkBanfhQx?=
 =?us-ascii?Q?rMtrj9dVk0flITplDh0F6yurKDVS4k0XQ1rZ8icQl7fjaeQ+3dhh3ffklN16?=
 =?us-ascii?Q?Sge1xd6aN2iJdT0PirsOact0oEvvBQwSMVuZCDOiuX3Ee6fnZS1TQ/ZX83Gx?=
 =?us-ascii?Q?LgI6L9BP7Pe7w968MgLQ2cDw48OOh+qH/hyX/1k9rneCWLn1dzznaDd7uaEn?=
 =?us-ascii?Q?JkTc+2rSMa0G62R72gquggt+zuxo2SJYyee4quYWm8r/Fy7vfTQf7C8siMdZ?=
 =?us-ascii?Q?obgSk3nMeSc44/0ZnPoTyynVdwRj+mqHOXHRTwAQgyEZhj9kGop04QQI8rnD?=
 =?us-ascii?Q?DAlylK01OvL8up2iHq3ePdSv/9aK/Lsdj+qoSLBaP5uz7JDu8Ueea9rsls7r?=
 =?us-ascii?Q?nVrueslTzEyjkS5+QKg/r2hB/PORmqWA+QCYLrHgBdbmwY0mqcoFJx0H4VTo?=
 =?us-ascii?Q?Cfobf3l6Jmrh7vXYyMKJAtXYpTZxx1t/Qo6BScTmx8GMJNmoyLsLX6Kxyayx?=
 =?us-ascii?Q?ftizOmdays4RxJxvepZsGe/v8+8BWpvF9mL2vc+K0Khtp5JYhbrXmqXvb4R8?=
 =?us-ascii?Q?tgeQCStng0fso6LIdjkaIEFe9ivvN8ySoQCMHq0xSNF7zi8vpU8wIUq4O0M9?=
 =?us-ascii?Q?hzrgL5C3rVJBSxRoIwMJk4tElhgngL8d8CTRQ5JuC0oHVHJ/F5p2XLb9OqUh?=
 =?us-ascii?Q?vZ+zMvNCuplRyvgHjQMPkHsx1UCovzUG3aDyjZToO1RWoEIx1+gyFke2AjfD?=
 =?us-ascii?Q?rbJI6BqMLnubNh8YbAHxV2Uz5AKxDAc6n8JrlGp6IjX0n+qRRFS4c+0T6hZ1?=
 =?us-ascii?Q?owmEiGaG2dYJIzXSXQgjRJu3MN4hyp6Ob7wJk2B5Z4rZyEE+FDSSOZlPE4Ju?=
 =?us-ascii?Q?Hv/lvDwd/OQUzBVEVP9XdFT0iSghEMQixINA7D1t0f5tKY7HwjX6/ZtbU+e7?=
 =?us-ascii?Q?/7QHzEryLHz+XALfGg5wilvv5oq5n7QWoXleJDqQZ5ltKtJrJOOLSeYsh33X?=
 =?us-ascii?Q?iFKY5j3jdvIXUmLDF5y4QynZLkXzOmoGxQ5DzS0Mrm2ohkEMD0G774rfWl5T?=
 =?us-ascii?Q?HW1f6lb8EDhNbdkX4ls9SHrYz674zEJUaMklgb6M1vrIZJL1Dlq7Ecu17y9B?=
 =?us-ascii?Q?o6yszls8SoblJoH6zt+mA2g0wbodcR6lnSbKU25ga2VhrS8hvqtNhK12H2uJ?=
 =?us-ascii?Q?+9Y4dF5+r1oQRUcuMXyjug7snsmO015uTpEM6kysttzISQ7vtXsc/wCJwc5t?=
 =?us-ascii?Q?c6xZI0cjbw=3D=3D?=
X-Exchange-RoutingPolicyChecked: iTWubLeq45ObOzA6uXa3fQ3sKTLgcmIQTXVz6GDNBqzw0SZKQ4ZaPqmKBUi1A+lrjdJU4G8D9EDmHRdBHH1XC9dnYWSaSDi4OrSYvRdrikUcgJi7S/hwS+yxfTO7a5mfYcvbCjlZydnA/MiDbbpR4vHFs/ZbVmTcTZt5fwzsXfv/FKNb02FkoC3Jskn3sI7KZlSD0lDRVxpjAhrN/IJLccgWdUEjWmHJM6yFDcuh38U5q7Ac0Mr189P+iANaolYdI7+WdOWJWgt0QWCuULNzP9B/fwbJ/yjeRBGh/Tvyi0A/oyz2eQ9nnDDBKcvLnT5/WbMCUnAxswkLA5Clfx7fUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdde5d4-3379-4de7-5b30-08df3bfd5b1a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:59:05.2166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kC9nX8vOtRgZc9quBm0bt1BdJFyGrihGhlmd6CX4ieazxTccHr8V3R27OoT+/xAoITiW34pQqZua2e/GyaIG8CiwMkvWi2ENC6qQMBoH00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF691668CDD
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

On Thu, Nov 05, 2026 at 09:47:20AM +0000, Anurag Mandal wrote:
> ice_dcf_configure_queues() returns -EINVAL without
> freeing the virtchnl message it allocated when the
> required Rx descriptor ID (RXDID) is not supported,
> so the message leaks on each failed port start.
> 
> Free it before return.
> 
> Fixes: 4b0d391f0eab ("net/ice: add queue config in DCF")
> Fixes: f3fddc93de16 ("net/ice: fix build with 16-byte Rx descriptor in DCF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
