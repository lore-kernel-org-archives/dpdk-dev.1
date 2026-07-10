Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06164C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 15:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90507409FA;
	Fri, 10 Jul 2026 17:26:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2434A400D5;
 Fri, 10 Jul 2026 17:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783697216; x=1815233216;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GeAKzpr3mKUqvWKUd6/o61joQMp4tfWH350f3yQX3N4=;
 b=VM1i6UbTlNAMRBf4Pppc2db29mgOQQisQODAdWpcNb+LvTNdvxHCzQJO
 moZiOey6DIqlUdd9R27w2PBFgu8vVZtkYG2jrtsxPF5mQPlEXm8CbF+aR
 o2mYOzv37gj9GTK9VP+ujYJwIBm8qwoJ2LniiYD+qG0NL7PUo5Pxmw99z
 yZNNdxmXeMAyIjFtYmEYmAO4TkBF8L2V6i04qsjLyKDnppznCKgWFRQ3a
 pyWprR5psvZOocac4YzWYiD+XYinYG7j3EzkWH08wPPN4HS7y+JsESt9Y
 4q3cLQZDDlDCrpFdrrfl7AZNe+URmX9g2NxOqG6gOnKumHCZn75Fm478M A==;
X-CSE-ConnectionGUID: yyead+X2SEO3vdf0+6BygA==
X-CSE-MsgGUID: mDVEbLGERmqaZFi7e235zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84419120"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84419120"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 08:26:55 -0700
X-CSE-ConnectionGUID: 9jl59cV0SAyylh5kCkm8tA==
X-CSE-MsgGUID: 3Sd+8FTyQ66DCv23A9lYcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="254410297"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 08:26:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 08:26:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 08:26:53 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 08:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9IgwICi0rL1r+FSsoHwjzqUbMWbyGiqKnViiNIvxxjn4aLDbt+f6NPugN/gqg4F0kJ/cg7A65BtjCHW72Z29JxXvdMRkDjUcwweHQeLgVAy8tV8vN7EAgioWaFRP2nQ/fCrqlv9BT2akEyiWS03jXEzasXU+2AoWikJR/UqVgOmeLPcgdlnrBkFcIK3bjtNbPUN6pkZ+3vrhSE/E9YbCFASKVUsZlmppwBSWpLyYH4VT1wEZmtdLayJGZiyXAUFRYYcoDrU1W7J3pmPMBeVNaxe+wgm3fKHC7hGt2FvTcKiphFQ3aXuLxUCfh3lYm16NsT3XJGEXLv4lXrS8ZeflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+zcnG7/fdkJ29zFK1xtpkm0JJTH80Yc5A+fdgsNvX8=;
 b=u1jbSJTljL4wPyECeOv0xU4YKc2gUWr+LRbiq4C0Z3aK1JWZ1Luj7SF1fqRzjq2ivK3NPVt6h9QU1AC1i0f5S71Jk4CSGvuZa8SG0+81JUsFchdXOWTlDHTHhoXyfQBAO2IIq4jccW4xC7WjNiT6N1NBM4KPAOBrIlrML3kJPZSGBS8/fgs6Pq4quO9sD83BNyj9QmjHPSiOlBg/VHolhhi4TO6KqNKzbEzXtdit0V82TqyPcMHHAj6qcbkagM+MtN7RQp3M0vYCV/WEgzDF8rVtE+0baOI3YbrrGoiZ5QTQwGiKwc982+x+cXRCiS/EiNfRDh1HbNL7+v8c04zqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 15:26:46 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 15:26:46 +0000
Date: Fri, 10 Jul 2026 16:26:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: SidAli CHERRATI <scherrati1@gmail.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 2/2] net/ixgbe: fix return value of close operation
Message-ID: <alEPMeDmuWXYwKDq@bricha3-mobl1.ger.corp.intel.com>
References: <20260710134639.108129-1-scherrati1@gmail.com>
 <20260710134639.108129-2-scherrati1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710134639.108129-2-scherrati1@gmail.com>
X-ClientProxiedBy: DU7P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6068afeb-d506-4bc7-ca81-08dede97a726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pJs2EgEVgG3GTXE7r7Hsn7Fel4qktVG61Zi06wJdoOpFlX3WC7dF+KynXL0zr7HeHberFO9MYBusJA/zgiKtfuB8UPQK4ThsYDNldqrgP9ILA5Viz1ZjfhZcOa1v2UNfkFdCTQPPyZbESnxFTeJBqfzHGhRPgZ7wr//ltudowyuyAdW5EQAQ09bRAzEI/tzGNMB3HjfV9mw6smwAEpHX/VXkAbtWC72vhg2lWg68VAIfesxK1MQWf4WO5rfoAqF4ABq+WxrKrSRyJ+/mm88TrDLPu5ovI+VoNgPH6x7bnQtdgCFGdQh0qU0WfjG2T2heB/L/qJpylqML+xxllES1KdV1dfF3joj4letzLRTgczqs64Ft9qwDuL4mMOKdJGbXg3AX87hvvrq8vbN415D/4miULkdJzEHR2rkcZosgOFzJjETb/mkyzAWGvsWHCl2AT7syCfBpP/hxVLDVMHB6LZ0f+jft8894mlIgjtpWOgibzFcs12XXB/pjqXS4qAsHZoV2w5tcmMAQfSVpGXfwwrKwb5FCyQHYNqeL7FnndGyhEdrWDsDVb9mp/uF6+b6S8+//FQHCpknsVMDNR8nlLorsH+qGW8Wsdfu/KWm8i4DCBdwX9gYJnQa4l7oIkcNkXdEVR1Jh0NR3pqmVnntlKHCFoPqSn8a7D2Mce1PFuK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bSvgeQzVdJcR8EDtpW9suOPAsegkXln8KHF8PGC+2zZ5rYEHFMqllbGYFGlj?=
 =?us-ascii?Q?iQe+EDbs5K+2yds4JnIkI+//lLrHqtq/CpOWP/RRBd4yP7Xx9eJZuDu3oChY?=
 =?us-ascii?Q?ZLOY6ArsZR/hNM+RgwsIOyIKLlEed0854+ID3uu6WwsPPSP7VbT4n23SLaZI?=
 =?us-ascii?Q?9YJhDIFpiGQ8akl5RYgSyRJmKYj75yYHuZvXS0Eem3e/D2LSb3QQdTAl25cA?=
 =?us-ascii?Q?trp/3FW06fM0JqR5lIsXK7+QlAMU3JdlZIdBFCieVNgItNdnCDjz2F+dOyWb?=
 =?us-ascii?Q?9Mny7Zewb+O4pMRM3QXaetOPa4ZlxVN1hkQP9cGMmnsC4Rv2vS9693j+RJfx?=
 =?us-ascii?Q?Lo/dGNHMOqICJUPF/lYlEG6ZWkeJ7Wqf9PZ0ND8EXpQwxzCZkL8IZhvL7L+A?=
 =?us-ascii?Q?2erbRvWOKQtVxDVSYx8gnZAUwvSTZBhFFRemXhWlLuyi3Z1rZ+BRDrlRUPik?=
 =?us-ascii?Q?p7dDlrTqRI0gNsF4DdBdbpF5+ZM5n7vd0NTMeLPRFWjnyOAMnafZFr2Jz2g3?=
 =?us-ascii?Q?Lih3s7R+bVuUtqBym1a86TaTbk1cjkPsIHID23EgkSMorIXwW2oQToHAilk3?=
 =?us-ascii?Q?4uKJ9ws79kaFQqIO+EWS80y98D4QPGdyVxrfqi3+aXHekNhB0fgtEzdE/YLm?=
 =?us-ascii?Q?YKrPsRSJylHur+O72Qw3w8yA295S68Hs+oTaLo5BZrv/8FjK5hbSuvp3ZW4u?=
 =?us-ascii?Q?5XvnTCABwwzjQucBfSa989VHSEA5/T+rr6uIzTNemL1BMnPr6TVx3RWANYAr?=
 =?us-ascii?Q?yDTYSEnQhj6+lq1ibkerKS8LdcRmMqIu2alun1Fdy5SEpY/idq48KTesy9BV?=
 =?us-ascii?Q?YvEhUzxkBlOolt1tZuC61H/R1SpqQdKqpp1BXlYNqyfAYoeN805BaY2CPijy?=
 =?us-ascii?Q?634768TuXPQStGppmJZuM4oHzEVMSUA8bEYx9jrYfiDTTllii+MXzlk2xKPf?=
 =?us-ascii?Q?W8WUxJw24V/lpIY1ATApW3GNRITtM+GY2xFZNIfF+1RTJ2cgIQzUNXz5ahcR?=
 =?us-ascii?Q?VFEDAa/pDLROId7xQX8MMmVTTuH2v7MgtGu0q8Cf3uUIHut7vrPZ738QOJ2G?=
 =?us-ascii?Q?Cw9awGt2IvURvHehFF/DW9AC3jJiHQljYsD2sLXAe047czJaWZYNvB+x2PJh?=
 =?us-ascii?Q?M1a9x+4DvvuNLwVhx1/rN8SJ2V84KDVx43MU4q4/Iv4PMdZf1eXDDhcgOKZH?=
 =?us-ascii?Q?8ouz6IzWHl2vcAvrdZW6yA1qqP1M6V+2wnCysbecblhB4vnxuIaOql6Jm1hu?=
 =?us-ascii?Q?giDhRoWcgLSddoMS3Mb7EsIPiPOkWka/bNaXlMVEuNuZOPOSbH3jZuv4Lt9R?=
 =?us-ascii?Q?T6AtCQ9Su5kwS8oLXg8noXMbKDY27WInsDNZ41HYiLulLZCu/b8fxb9Bqrqd?=
 =?us-ascii?Q?RBuK3xsKfI+REvtKp5MkmGkBO6ksdgWfVt+tWT0LVI+yKFeAG7Kda86PL14r?=
 =?us-ascii?Q?ipnHQIZ+Y2HMoZM5MnL4+TLHjB6kNdPyY+vAx83vbOMQuzEwxFg1OIQg26Qv?=
 =?us-ascii?Q?JHmYb2WFV3YLg1Ozto1+BrxTUR/K4nB2I0WBYGBwLdNHnE65ULk2da6pdB7H?=
 =?us-ascii?Q?rC0wNcxLBIWAxSBPK7R8twS/+loUHW9vf76LKIYUEE5VLArzuxwpibvg9Ow8?=
 =?us-ascii?Q?GruUg8XARgF7TaWNkaSHZ5NAfd32ODdlYKSFDjqnH5iMvWHerLw/qbtXBBo2?=
 =?us-ascii?Q?4HoTt8LhWOiR5QspiWMdIwk3xIvXVfqth2NW4PTJn20mmmf57bOG8Z9MSFnk?=
 =?us-ascii?Q?XOQFmaXzsPx/T6s87WnW7IMtdKPjvnc=3D?=
X-Exchange-RoutingPolicyChecked: MYq6Fj/4h4asDa2uBDgBMeYuzF8/qQj8NiyPAWW6CczWNvBxcW/X5WOn5kGzJR4dwU9ht4M5hawOp3xVp4BG68A+Q3K3resq7TZRSOzDVqUZFBxWFYvGQz+eTBGqfBKbkGUHs6pcRelcd0WKVeRGftxwjTE4tr/hx8TGxEnx31sw2DUQIl7MqRs7n+UsB3I/HGgyALTTp3aPtUx2HRdJMkoCcI+he17lsN1OawASM1uWewvoAbvUHvRgVNDRBKgDcb3dPYiaJ5I39u66ymKfmag9nue1eXbJe6ze9TYaj9AvdSbxUK/6XbXiSuLWqlyAL5AchG2b7Rf/aMdZATx00w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6068afeb-d506-4bc7-ca81-08dede97a726
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:26:46.1122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Y5zgkedcPTvTIIPULy/IqDIaXZHp+WxGO5jspJOXcNK2GS6HU127EkFMaWuH4P0BX+ikvO3KlTu1zIQM/WIspmg52249IfIXB9hIElNbkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
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

On Fri, Jul 10, 2026 at 03:46:39PM +0200, SidAli CHERRATI wrote:
> rte_intr_callback_unregister() returns the number of unregistered
> callbacks on success. Since the close operation started returning
> the ret variable instead of 0, this positive value leaks as the
> return value of ixgbe_dev_close(), so applications checking
> rte_eth_dev_close() != 0 treat a successful close as a failure.
> 
> Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
> Cc: stable@dpdk.org
> Signed-off-by: SidAli CHERRATI <scherrati1@gmail.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index c5010f623c..6b1799d7a0 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -3121,6 +3121,7 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
>  		ret = rte_intr_callback_unregister(intr_handle,
>  				ixgbe_dev_interrupt_handler, dev);
>  		if (ret >= 0 || ret == -ENOENT) {
> +			ret = 0;
>  			break;

This fixes the issue of returning an invalid value from the interrupt
unregister, but it also means losing the previous value of ret from the
stop call above. I'm therefore wondering if a better fix is to use a new
temporary variable inside the do{ }while loop, and assign that to ret in
the case of an actual error, otherwise leaving ret unmodified.
In that case, we probably want to stop retries on an error too, right?

	do {
		int cb_ret = rte_intr_callback_unregister(intr_handle,
				ixgbe_dev_interrupt_handler, dev);
		if (cb_ret >= 0 || cb_ret == -ENOENT) {
			break;
		} else if (cb_ret != -EAGAIN) {
			PMD_INIT_LOG(ERR,
				"intr callback unregister failed: %d",
				cb_ret);
			ret = cb_ret;
			break;  /* on error, don't retry */
		}
		rte_delay_ms(100);
	} while (retries++ < (10 + IXGBE_LINK_UP_TIME));

IF we do need to retry on error, then this approach won't work. Maybe a
modified version of your suggestion might do instead - rather than assigning
0 to ret on success, we assign a saved off version of it from before the
loop?

What do you think?
/Bruce
