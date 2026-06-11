Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBBCD98D5
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 10:07:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5F3642FB9;
	Thu, 11 Jun 2026 12:07:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5595940041;
 Thu, 11 Jun 2026 12:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781172464; x=1812708464;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pkgxDVPvDWiAHGdWrr3hDaJ/Z/rVgexsL/nmPqTMGsE=;
 b=EU5qcOKE53BHIcMt3Qv/VVnCNYdaTyhBn5OWLjpd4t45SgD7+M6DoVMR
 SL2xecWpJVTc2hGiUVPI7KOb68USf7f8BeHd8OPeawl3/0bAgxICzLlhP
 Ox50NCv3yM7zwXsiDzxRmKWJpb6+x8QwdffvTyo1fF2pAHRShWyoj7Q8V
 IimhcRUJWrbtZJ9tnwf7fOBYitaF5OMZuYMyAjg5WfXxp83jVJYehaTkW
 JINNlwHz7mngZWoaKj0sZeTqdi/xXOM1/7gQMMqSHceWB38XOJg6wW0/Z
 ZNhkD36nGZBT/HGe/PQXacw4cUZztcLMtuByE/UF/8cw+RDq9vsrr/2A2 w==;
X-CSE-ConnectionGUID: q4XnMXzzQSqCREGEC239rg==
X-CSE-MsgGUID: b7h1TILhRKyfvNt386t7yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85879662"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="85879662"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 03:07:43 -0700
X-CSE-ConnectionGUID: TDjaETxIRqKvUNhiQ4XtTw==
X-CSE-MsgGUID: 8Lrg13QfSsapANKM7gdGFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="248312031"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 03:07:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 03:07:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 03:07:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 03:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SariUPh5DyggyY18w77yX9V7OIPOB8oLtJomCWdRNzJ0kiPD2JuXO4qEn1WAhJgN+xuMgDG9/DgIjPB5+DyilPKJ9WeMYNR1LIgN3BuyUTnuTw/7Wf2pElbyQYHwi73fTBszQTjgZUHktFcO/WaSBlioWrbSiO2Q2UqTJx4pOWqs/tExBtGHwyR3A4Ql7qpLBIFsGH7qysgGKskrp5eK7uLv3BN09NYEnaP7J0FeKgv6hVw+vI9hops5z06flQhkrdnK27RpKmmyjLwbmkaNG0mr/Tr4Ing9iLmecrIPot9bxefTGulXnvpP4Ddl+cyPfUqzIYcgUvhuY5gbTLqQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRyjQiz0l/4dKcObuw4ix5ZJzT1pr60mhpmWMKmDYoQ=;
 b=FJqkJ69fHA/vjH24lX14y9F7SVZYjerqXlgqox5BvRoiRA1A1m8gvm/JcE4XppwDzltbT8KP9YKn1fp6b0PyvCMia2UGcP1a6LtBx9JCMbWGkfKR8Y6uUzTqwGwxyne+J6CV7LgwYwki780eadRls2Nbh4WcOBq20rDHxxBLcRoxs+13XYgna+SfhXlKUc2Uu4HSLJ3oTjMX3kZaewb0XeG0y8AN/oIxEcJ35hC3SpMcOp0KX2O2WeRjriTXpmrtA4qjMRZIYgIn0/5PnH2lmc/M9GyLWueTSaa3hxOe67IN+qaKqtPoAgQRKK7bm/muoK6hRwSlX9pCQAH0eD3NnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6389.namprd11.prod.outlook.com (2603:10b6:930:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:07:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 10:07:38 +0000
Date: Thu, 11 Jun 2026 11:07:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH v3] net/iavf: fix to consolidate link change event handling
Message-ID: <aiqI5XxPOvu1m0Bj@bricha3-mobl1.ger.corp.intel.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
 <20260610141230.369232-1-anurag.mandal@intel.com>
 <IA4PR11MB927893A5541358313C538CA28E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB927893A5541358313C538CA28E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: aa882e14-2c2e-401f-f20d-08dec7a14433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Fj5RHms87msAgd5FX0g900nHgHdeZpDpDQo7cB0mPQQALnS6M/bcZlV6aDJZV63YMqdNxY2fqD1kxFVrwY38+8PQL91h54B/er2cut5ZZQsxmTUzJyxer3ztWCVp7duij+A8+LnEFYwY8yClmlkJSzzJKi/vkEwU9yQ/tOR/f1vM3BJxwnmVTGbgNQUjbL3EdAA7BjpfWcjKcVMJcPMBwWYN9/ywmM5hu64XXshu3zjih51X9J6QXlnEAjynx6IwWF9lRg9I2uUYdw8DTcO4B+NxEj3HM9FCZGPDJ+Lprebbox10Joh8DmGqR8Ri9ak3rKFzpCLECpH4ABwm2Fj9WQdag+5OhQZ61tpt6LjzeXCfA55OIRThbUHv8qL2/fteoF+cFd5vh+snOBMT2jrTraXCSZjAYQce04YaKPmMKHziIE8cfOSc1DuQNF4WvzBWrGWgQTk4yVLT9TQcPZFum6BP8omr1KDq0vh7vfV/p0t4poiy78EjEaesen8WhulJ+nBbmQiTZPc8jKnE4dEuEa+F3nonQYVVja0cHtK6IE8BGI5QSRfx/nbEwWwA73AVvYNSZh56sU95K8pr/9htaPIgHn4X9hCK5hCmxbn6l4es394jRR32rwTjFh7KFwAWcD0tb4k0Poq0iLACydYRtFwfatWrck07Yb8QO3bkMr7RMn9LysXLDE0ELV7ZQlA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGN5jCA80g/UgDfBztF3vnQmgh+vd1ehGmcl3Eo++1EeST1NDN7W8ZsbF7pO?=
 =?us-ascii?Q?1bXIvlSiQqlreZU/OVG8rOjs40UaxYqKg+XZ8K4kSzcrR5Q+HiZrzIhZxx4S?=
 =?us-ascii?Q?IbuXcdyGFJys3nxF+ViVYKoMP2c+14wQY2x4SAkSGOcyzNhifx1+bfMe/Aah?=
 =?us-ascii?Q?wxOmgYP/IsNztSuxyhBLKjlaCrEZYJ3Pw+sVH/HUXdqJ8h0NvOv+xIUuNlq2?=
 =?us-ascii?Q?sTLCME/ydm/yWfW1/8zT9Ft5WFummxpFsb1ukOE2Hw/FpQnMI4Zi21iXRkNy?=
 =?us-ascii?Q?rWdr20T3s3JK3HBvAlREd5Fi1oByNXdCoABP514cZU/eDgVs8br3EiD2EBX6?=
 =?us-ascii?Q?w6+RBCdN3YOxzInVyqrgfji7HWv0MbyOmbFEUpzKQWlf4FN5SEMev/7AKI8O?=
 =?us-ascii?Q?LDjTy3yD5rZIJ0Wzb98X9a/mBy/1OLjcGiJ4Ns2xin6BpUSl/AeXhFJtVuZv?=
 =?us-ascii?Q?nKc5+zeCUgaQAhCAxZJCZiY+i+FW30w4b6247q//VCaQ7Tf2xcCbztl4iJ7K?=
 =?us-ascii?Q?tYjmzbfjFJdGf5xEXeUuR/8MkBg6HLKODi//xFTdKNGTkPZoMSBCeLq4Td2D?=
 =?us-ascii?Q?YDNDz2WkQTFM5r+6mLlMkkOn09Eh19E/aUncej4T8djxLy2eHJGkO8KpLYLd?=
 =?us-ascii?Q?A0MpCc9wxwH3PuaBL1LbzvrAu88t7BayzMHjoWMNbVXNtSyhp8apt6dA4nQK?=
 =?us-ascii?Q?+C8CfO/uSpYuWjBAwE2QPW8orSkIyqRjAUDG+/q8N8rQBDGnNbu5fP7B6PC9?=
 =?us-ascii?Q?AUs0zhEpAw71JRpKNbX6m3pc7DDQzpTgR/1WgoRMIDH+ksTWZtxm0+fvtbGg?=
 =?us-ascii?Q?sqSCIpmmiGOP4pd4mzJzdby/b2JCTvLZt+5/oqiv49g+lx7jif92ozbps9E2?=
 =?us-ascii?Q?fi4MoESTV7SbY9F9MeDL8Zot7SbsrJdshK9K1nCe+khIFnHtWL5rObKy4kgV?=
 =?us-ascii?Q?jdflB4XhnFxbyU04YwJhANoHSznQl7tIs54OKxBxsAfuydQteVbfjKZk/lhb?=
 =?us-ascii?Q?juzGnLYX/CPC6oWWJg9L2N574Q6B/jm1J8hDhUIZ6dQltJy4ClQg3RvaU2HX?=
 =?us-ascii?Q?sJYfPgyyKA2Say+Cs34f2OGQc/nA69T0vSaUO4dJ4I7Vn9U/t0Mc5efZIqnt?=
 =?us-ascii?Q?pvSUbBjF2Dh1Frk0PhqiYEG5iA73CsAzEDgXBojYsDvPBiGw8Cryfl3rTBky?=
 =?us-ascii?Q?8s7FUrTFWjSTdum4rrrkWLc+lK1lE5EnosGFVmOQ42F68f3z9IX6RZZU04MJ?=
 =?us-ascii?Q?9IP9mkcNz8chapHU+FfEDKKF+u4lEGSPC1YEGN9gocuSMafQEob7UVDkSrPs?=
 =?us-ascii?Q?PUdMnNfx/9Gr9qglW2p7Zp2W9oLbPRJpKxyz3rc0UuFkbifZVSmTBVpO87xE?=
 =?us-ascii?Q?8UWd7UedpGEz2ELkkHjRqGrrIYSKY2KB2jimwWx4JuqPBjaVTMRfTT/Qo3nE?=
 =?us-ascii?Q?EHiZKGLQN0qJy/Xr+TD0uZ9ZG3bAlTR6KG+d0r5b68IChFLBkMqRPXDgi12t?=
 =?us-ascii?Q?VZpKUc3Ah4UBTlXZSErPJ2i+HUjaGJyV72DVjG8dLvGbftnpnOTsRAqY6Pmx?=
 =?us-ascii?Q?iLsnDd4xYhGoAGxVCePfbgjzZM2wDywNXENTeqdVIV19Elk4F/fhczdWZFpn?=
 =?us-ascii?Q?YdmLrJ5NDK2i2zAGGv2tB/qNJcdDPWbvpx98ZmQWHglQW2nHaG6XM7Xn94XM?=
 =?us-ascii?Q?dbkVjlzpcQL5+y9NPZF2zag93zgnnB4/GvH40JgAc6+I0vGckek6eflKgUpz?=
 =?us-ascii?Q?4Blp4+om+/u/euIWcLbYgsluBETo2Nc=3D?=
X-Exchange-RoutingPolicyChecked: s15Om0wOPQCioX5w8UNdxEi7uY4Nlhprf5j0rJtY43QTf2SOrivDFqf75CjrMlVdGXPExmSAms1oUPupxmUqJBekoGIW9eCGuaOIvv5KXbXViwI+nFLF/ITWFkYeXoOTVRfCwu5h4fDZI9TTI4fUKE1Mc55ARic11iLDGxVDgxKyX52OIPEubtIs6Lfys/91UnjPDM+rJUfHPrJbA8LZ2ZgP88S8YjkRuT+p6i16AAeL5Iip6KIPZGd/oXVxhmNRXCLMFyxrEKPMR9VVuw0YX5G/b26yaXa+eHrTQTL7Sz+ZEVLNObea3jZMXmkkHMU9FMMZE7J1QnyUyhwCl8sLQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa882e14-2c2e-401f-f20d-08dec7a14433
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:07:38.2564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DL1/aoeZdn2zeQBzHrRid5G7ycoBI3eiG/hj9I0rU1eJG8AoggxOqF5OvinmdqdcxIhFI+CEYWMsVEazGzpiypK76WRNG8hhLUxDLaFK/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6389
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

On Wed, Jun 10, 2026 at 03:34:27PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v3] net/iavf: fix to consolidate link change event handling
> > 
> > Handled link-change events through a common static function that
> > reads the correct advanced & legacy link fields properly and
> > updates no-poll/watchdog/LSC state consistently.
> > 
> > Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> > interrupt")
> > Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> 
> Thanks Anurag.
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Just to confirm something here: does this change fix an actual underlying
issue, or is it just a code cleanup? If the latter we probably don't want
to backport it, but if it is a bug-fix, I'd like to include some details in
the commit log of what the observed issue was.

Thanks,
/Bruce
