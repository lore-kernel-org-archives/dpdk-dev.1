Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF083C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 12:15:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2ABE402CC;
	Wed, 23 Jul 2025 14:15:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0A06940264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 14:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753272947; x=1784808947;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YlzA8bbiVlQHjKyc3o/w6xMvTNqzulw9KxwMc2taB70=;
 b=I10AdF0aik1W6xSeuuzK+Sl3KjjbIb876QgQrp6+37EmqC1UYBOcSXBH
 xXEH7kOBOpmx8Pz36Nl1IpKsu7adMC8BOiIkzMz6H3H8qIlpOOH6jYlAc
 vekJQG2hluPwuRvx9z8KvZqGq5eY2yUhKrL7nZgX1mUFWvny97zCo0YX9
 Mpjay8z25c0RHdUxjEpTm1cuw+qKFA+tuXw9Rr6Vu839T8MLor57QVO9+
 riYvlcyithU9xweBEvA2QaXlWM6rA2g2YmeWwE07Ilg8xSifzFf6pFSaB
 Yywx8+HCfarLOUpri7muYLfv2nkakXXQJTvAtMbm4V43Vxz0JHwXUAngO Q==;
X-CSE-ConnectionGUID: sIUMrbSjQn6k8sotK9dGBA==
X-CSE-MsgGUID: VShoPLS7SEOpUu4MXu+jkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66118827"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="66118827"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 05:15:43 -0700
X-CSE-ConnectionGUID: fhHoeeNnRQOqe/eRPwiD5g==
X-CSE-MsgGUID: Dos+v7fqQG+JEaGhJUcOIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="159875883"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 05:15:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 05:15:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 05:15:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 05:15:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjosO7CV68eXc4ZVPPQqodsRhXiXcgL1CAXouxPdYII1kkH0JN5nnAtI6vU2L5vfalKCVj/iCrcO/slfPD+RkbkVbp/0tYzmHYL3qK6PHI5k/0tDOhWAkWemZK0YjZ9a99GRsCB3sNAShhno6Ra0TQoRcyjnlaHCooh+yMrruCKAWfg0uClt9kEOxsxfloybqErpaNQJ+1eonw4bcqCVDTfut3E7LYa90Gvz13TgsFQGEOeSwTXiaSkuU1Iq9sUiyhGvvwMpm0XlQvEoTx1BLv99jWq+Bzki1kbTNsX7TPilpR78whkT3TfaYThoo7u1cUPT5nsTOWSydVdbOX1Qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YydNL8jEMQyUAMZwlm3rGgxeIx/NaQjpYgUMB+kaDw=;
 b=sD1cywn/1W2hLawOH9j59/cf6NLDvSjAHTc6j6cQpZBfzFuYg22XDVBP0BgcYeZ91NREemnNIYLgipi7IK7r6LS1TKFPOo37Dt9d94EfMl3oT4Y98jJGT1nSvHoIb6RldEF4EnNmJbPiSGtCGM45Mh04bxuy/+E5PIUufCXosQiqcsBnWWmGAG5WRk8PRc3pUvuvkMlECwrs4JeK8kAR0v6YmqPN+UHAevkT2zjLDNuZULX1NpMSp7mXT2OQ1XLbk33dUt8lYYevs3Y22AvHjslULvqDEVp4dqLt19SKqr1J0vdPoHFBEW9OFTNh6t8dySy3MfVJy2LAdz+uhoR/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB8130.namprd11.prod.outlook.com (2603:10b6:8:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 12:14:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 12:14:58 +0000
Date: Wed, 23 Jul 2025 13:14:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH 2/2] net: remove v25 ABI compatibility
Message-ID: <aIDSPdozAm7JUAnd@bricha3-mobl1.ger.corp.intel.com>
References: <20250722132441.3700305-1-david.marchand@redhat.com>
 <20250722132441.3700305-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722132441.3700305-2-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0259.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b540d55-d466-4c42-07a9-08ddc9e28a8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RbViQwnRv0Bcvs8BzdepF/M+/TBUInICWqdSUXghZ7o+kQ0wzomEyJRDmJwo?=
 =?us-ascii?Q?wUJMVphFi0Et7aRz02INU7ic2P18hLkivYDkoK5bKWWMN4hQjG06bKJA2/yO?=
 =?us-ascii?Q?T5GtcAy79NbjXXNT3LGUKcklLkfK9ijjtI4CiRbMXSyvzE8nKgaDiwiYJyCH?=
 =?us-ascii?Q?kHcVmuIn/RDOwm9TQY41AweQ9rxDkO7fQUzJD2pqCyevVVOApphGIy21v67c?=
 =?us-ascii?Q?//BsHwFP2YGgiN24bq8j98NbgESmg2PJFIQcwBANMfJ0lTCzZ/CErwGBgkeX?=
 =?us-ascii?Q?k4xqgDnpInW2oxMElPsRcruGy5wSY2fYhdfBV2RuvchNkrtDfHyp8yqrMwMv?=
 =?us-ascii?Q?QTyhHIwV8jzUrSDCoi+TvyfXrKROAt8ngrcQSiVEM6DM+zGXX71NobPU4b88?=
 =?us-ascii?Q?/vWvZrOjrRuhcJ9t90n+FoDX74MXL/MX+e2vtxsrTFVrD/UIMwNaryV3YHri?=
 =?us-ascii?Q?0bEQatR57yRCOX5Imv8JTbsuioGNSpTBqhG9RXSbmZDOwKMjjVvGtOXF5K80?=
 =?us-ascii?Q?JJLrwGbemSZw41uA0kBdHQxtginaC3+6Rxp75bpnLcUammbE395r317Di6Tk?=
 =?us-ascii?Q?BiRAaq8IgdvAmLYJ+9Ws7fL+TOH8i9MbsckrLIlcUQpMAQTpdmxpV4xhB66K?=
 =?us-ascii?Q?iNJhV+zRFW16QPeewhLfFtZ/LTEQcl7M7PLLsFWRHDn5C98jpzSeNpLH6UF9?=
 =?us-ascii?Q?M0QxW0qGTUsF7kwXC1e+70hvNRgvIgA4b7Gv13fMjImWx6mJrC0tymQNjfoR?=
 =?us-ascii?Q?2dR8hD5sjGl3zdbrUVrmWsd7q3Ly1k8C2CH5/APl8tlD0iCbOHlm7UIlDT/r?=
 =?us-ascii?Q?Fgsc5xE2D7+tJQKBcosNkWtWI0H0hN3RCJooz0yVQeo3uRK92lolVqyWAfUs?=
 =?us-ascii?Q?B7xdJHfESsdD0wxqwGCJLqE9jqB9YlkQlouEINh6EJ6nrYVKsHe+eZZtQQwm?=
 =?us-ascii?Q?7YwmUwcbYHWUWzIl2SyTVeW3Reu6SsVGD1JhsBqDhY+9m5b5A5KDDCGGXJAW?=
 =?us-ascii?Q?lk+A9ZXi1YWT8YS5anz9kjSAlagLt0ZlSFlNFWsv/eH0UNrNn8RyBFCsMCzJ?=
 =?us-ascii?Q?3vTs29+WovN/Oqz3obXYVu0M6dEh7jqrvHs1daARqd99d06cTmfPjnvMQvj9?=
 =?us-ascii?Q?lIeL20BlcRIgDUWUlOKkE7bsLdodiZuj/My06masrCmTpUNngp+e9BPpkvjG?=
 =?us-ascii?Q?4vI63ceZIC7mxQJTD4KpjwhMpa0QimoQR0wePrzisHWP6qhBNa93HOu7bilW?=
 =?us-ascii?Q?0LpJETwU0iDr8HZYhE3muZG9SlK3HgakMJ4Mvs/XmxwgO2HSNVUZiZdybOmT?=
 =?us-ascii?Q?kechgz2gVZaZlNS7QmZMT9Cu0eRZLspk+11/ZZwK+TwM9vP8c970csv04G7K?=
 =?us-ascii?Q?kz6DjOILDcKrjySXNli5XF+H4PSMautNbZ9PHUyaTUkqWcfaF0OVXq39vjtJ?=
 =?us-ascii?Q?cbCIuZtHkJ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0WucKiIrqyPEpKjcbXsZzjDJxmODZHP2HAKtRBGO3Tg6Wh/loDZyZko+xBtT?=
 =?us-ascii?Q?g108Eb/+ppu6F5SorLvWqZSdZdB9t4amzaVoAz25gkW/oWxyrO75MOLFe7ED?=
 =?us-ascii?Q?7wiD6k2WJEUdld4Y5ZIiMgWBR8MbLHzZSXLPoSuB15JL2Gxjvm24aqp9lXdz?=
 =?us-ascii?Q?W4orpiVCEm4vGR0G7wVxRCibY3nEi44GleZiK+SLnfvysk+JiQDR/aOzA6eQ?=
 =?us-ascii?Q?Va7ma5uaAe1dqsP25MXfXRY0KyPsKS7ZYbFY0EEue8Th2M63e6HC0KN98pU5?=
 =?us-ascii?Q?5fjSJUE3eXsLeu8ORswOEuhGO+zLu9zLaOXfgVpfPGFsUIrFAONgmLx0OMn8?=
 =?us-ascii?Q?VNREKN4Q8HgLdtdnbqIQayW1vzcqHDklNLTh5d6CmcKlt4TRoj1d+UjgL4m5?=
 =?us-ascii?Q?gwHZpfrG+/lH9g/kyz2aA0cTPZ/sH2gPtIdFolWN9ataGy1xqTv7gDwPPpwu?=
 =?us-ascii?Q?wy8LxO5clBZznpnhuUyRpkQiPy4N0yG/hO5Pp3tSLWweeo70EgVaS/IJOqPJ?=
 =?us-ascii?Q?Vq5QFkZCvZbHQpy4dTa5aciEwm0iwjMjOYwERzChaQGc7YlK8d+1RFwItRPn?=
 =?us-ascii?Q?MhlU6GHDYPlbsDoJOSKO1ITluKm1WoWs9Ew1K6TGe96HpdKcHEbuz8mLdlN0?=
 =?us-ascii?Q?u+QU3lY9zz7ge9vwECCBtpovfjFB/lfgNKgXbbactURLk/xwGjtNVXLtti7y?=
 =?us-ascii?Q?n/TAmODd/AS4YsebVvxJGxmbXogGbX7PnD5i742A3rh8Afoth4b9xa/4h5Z1?=
 =?us-ascii?Q?9IxywJMFlBgZzHc/id120ubQHHkd8DPvV5PSOXgsE7kcFstV8Dynpwq15GOG?=
 =?us-ascii?Q?aSmsn5gFqxAt/Freyczlaw5BjRzAY7GHH6vUAXOKtsLZcnQVxXyqEg0AKIy9?=
 =?us-ascii?Q?5VbAWDtg/DlbkomT8pVTgW6B/6XcW8VaGhFWDk4VCk12QWWU+RXo1boHP3YA?=
 =?us-ascii?Q?wBQIvbW415hA3w/hhlGUabzrxGRCPrWwvcNdSXpS9zGrvMtVSkUB00ehuN49?=
 =?us-ascii?Q?JRVgl50Jhce8FM7wOw+NkcYCZdY/xa/IxvUeHn27NhgsSpHSlHt/jnOK98uS?=
 =?us-ascii?Q?rqQAn3aSN2BejeHlhopgrd4soM6SlSqYaNlNkO4dj8VyC4tvVyxuyqYjeWsG?=
 =?us-ascii?Q?s+sMXQ8rFxhy4fPcb4h/tlPjaugtno0mKuJmC/+r/CtCtNVRVgfkwzFkkOPd?=
 =?us-ascii?Q?oriSz45xQ7RJGaV1iPvQPVSrogVvkluifOm6CMwVU0Sgxm1X803YHOUDF9sA?=
 =?us-ascii?Q?z35FxDSRh+Dcz1xRD3AVmCe/SmWYr1bD6ixmFX+CS6lDSzlksfmKEWW4uQht?=
 =?us-ascii?Q?fa8/YA3sKDy/gnwcxAXifLn/vsestEe6LHGz9M5ZJ88llPa25oLIhYqNkRx5?=
 =?us-ascii?Q?8ODGHWDqB/btNe2XTdSnkC9yC06cPXDvKP8IEu5/G1B8rq8X5uEGK/LUPuys?=
 =?us-ascii?Q?Vmq6ou4nrL0us7nbrIJ3yl2VqKIK2+I2JpuUJbPQfFeMUcJbqx0CGCbglaAN?=
 =?us-ascii?Q?aaw+Gnhn0044Yr0BfjM2TUwbLmjqTpGEhCq3oeo2ScvZYbPZQaJOc+dl7b8r?=
 =?us-ascii?Q?wa474YjmxCX5SMlbBf9zG8jrzHuASSgY1CDV5a2qIv7ZY0q3etMjJ4E+SDD3?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b540d55-d466-4c42-07a9-08ddc9e28a8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 12:14:58.1800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+Ukbj8gL9Ga9tpWzQT3BDRzYHHFZxQpMZT+nTmXrr5NqZj11CLl3ehL2U+gzueC/aMYrDDLZPugBng5zXILSS5AteeFmXC87sKe1o0nc10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8130
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

On Tue, Jul 22, 2025 at 03:24:41PM +0200, David Marchand wrote:
> Now that the ABI has been bumped to 26, we can drop compatibility
> symbols for the CRC API.
> 
> The logtype is not used anymore and can be removed.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Not an expert in this area, but code changes look ok to me.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


