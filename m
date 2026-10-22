Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3F606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hRm57LUu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8B4C40264;
	Thu, 22 Oct 2026 16:18:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 30B864003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 16:18:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792678734; x=1824214734;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sjoIfjSnImWrEN7WDZT5gpkCoCE8qdfGWpQS61z5U3A=;
 b=hRm57LUu3WiYmBWKI5cu23f/E19RQyUjrQmc+LUpfeKQhNIpkwF9rmOX
 7crr4TcgIK1xbeDmRzqqHn2vg2hyWf9DpCw7bbElYjW0hpOcmJTWirG58
 U0IdFKwdvJpWOv26Iqg9P9ZupwKSKsHFvDlN1K8CT2lQahKLcg5zCR527
 kA/eQ6LqypNRC00FxvWblMJ+v/sdw218J1oKPZfA7JI77z6DYUPwgDQiR
 jzXSJ2vu76bymOpb0lAzD0S3JmZaM6wQgWVi2gLgmNFvfhgQfOgy/1cgW
 Qu9J4KT4dGLvKY6flyFYz/BnMdeHH5Wq8qeh3B1q9+fdKTkgaNnzyJW1c w==;
X-CSE-ConnectionGUID: 04cpdf0MTxaENeU6AdWjrg==
X-CSE-MsgGUID: FrSs4pOTQXunkgR0lvP+eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1439751"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1439751"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 07:18:53 -0700
X-CSE-ConnectionGUID: s+pYtDcESIWHemfhRfGfiQ==
X-CSE-MsgGUID: cZL5ii/VTTa1i9elkRYz4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3499862"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 07:18:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 07:18:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 07:18:52 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 07:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2nhhh2slyvSd6SWAR+Zxwz5LCTwm9tegCQ9Zd4nUCwOCiSbROoS46PqWjxQC2LfnLlNRIjzQUP75KiR8ziINv8EoOVJEErx5TiU/KLAX145Wm+aEEchFXqlg7RaUy+WpvouPBnaF5fjefOQi/kRCymFmkJtH5uC/PhznGqVQ+LD8SxOR4Sh72jm6Xyk6aDeOq8vg/jLUUOFVBUXtj4/gzo5+44CBy18u01tIOiCzG+IKH0+HG+Krq/gEHovygbTQhIbPd2qvjDVhaPOvez3V2K1aTWjQC9LUAGUcme0cscbWoFXNYWFWkMsqLP/rvkasT+Gh6n/qczBicBmWmnmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hJUJXJS7HkJ7TxwOFCeMnev3SdySLsEkO5MYDnx2/Y=;
 b=Tvzss/hvBsWQiPstFmaX6Cy9egvm14GwTzIcteR23VLcyXeq/nzA/KKKpxYv+2j0LHfDieCE8iW5QGpJ/QxiYEnCrCt/z3qJ1YXO2nRdRcKGLKWXYIz4lCNnNEluog/2PCOMTZtefHFAd43g1uqmTY9gG3vV0P9o4j12KI4LVA5i1YS+DDlon8MWifnIJzBRlO1OhJXOJAKlnz0PEDC3NjS7Eo0PdM914INy9vll3r371Qwff787YWyR3VdR5FoMsTR8dYmWeR1Y3hcsudcnVuKqFyxHm7DYoQJwd3EdKeLV2Ayv1baZcSgEO4ThDmzmimquQd7FhtPzaQRaY7DNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA6PR11MB469167.namprd11.prod.outlook.com (2603:10b6:208:5e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 14:18:50 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 14:18:50 +0000
Date: Thu, 22 Oct 2026 15:18:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Anurag
 Mandal" <anurag.mandal@intel.com>, Ciara Loftus <ciara.loftus@intel.com>,
 "Qi Zhang" <qi.z.zhang@intel.com>, Qiming Yang <qiming.yang@intel.com>
Subject: Re: [PATCH v4 06/10] net/iavf: centralize memory management for flows
Message-ID: <atobRQGRDukDqW-n@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
 <740d93b1c350f52ef1e41d5591ad2a7c2531ac15.1792592724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <740d93b1c350f52ef1e41d5591ad2a7c2531ac15.1792592724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA6PR11MB469167:EE_
X-MS-Office365-Filtering-Correlation-Id: d64a7ae6-0b7f-4399-1ff0-08df304764c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|10067099003|18002099003|261021121427099003|3023799007|261021123027099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: uQg7uDL3A7/RI0e97BRzcz2qsLh0cKetjPt7yU9QEmhzmV6QrYAFeNXrlJ+sC8q7yrKtA8aFY2Il8BjI4v7q9tDqm/XAXxl/krrTcXSvXaUNvLowJIJc0v/DotNlAq2n6JYEnRWxNr4vLRb+RKHKgaH59PGSpBNeCMFkOi/fNNEpcyxbHGQjWub5cAIS0JnyDtZvYhPAas4wNdOSWe6S0jKO0Vs7Z4ieHUAd9NE23iQ3ZR3wgm42oncT2d10bmo2ab7mcEu7AiEibGFUV0YwLFKkUj7+JbG1I2XMCYp0hfVEc6186ejtwGpbtZmCbWPzHsjrkAtbu8trgSp6e3nb2gzDd/sdAmvqR3lgoKt7jC/35dpIiFAmAWJfsjwIuLRaglC0GDMZq6Sl0KMwV/bZi4UouBJTWgYq36HuQkKnGsLrCZLTOEymkfMNTV5OrJ1jXIjtivP2hZjav41jUS8bVA4hjkt/P2AVDcad7GpK3pdsuLH08AJoBFMDIstMY88iq7NruhDashhaTrOds8NtIFotT88bhYFLBUMetJhCkk/ts4iCe9MrWU+c3ci7+FJrsX9I5L+NDAoZ5zFHRpcuX7KZNLrP5KJjCpXPVCquCUUmR2Od2wU1q5UbOINZLuINUuQaQvepjWYkCQ6C56O9lvwEc04nSfRmo+qU3fUmJ9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(261021121427099003)(3023799007)(261021123027099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BXUFgpcIlCPmL7eogqFubBkb4PuIeowvGZCG8g3waYM4PG7YenX1kpwe0ARu?=
 =?us-ascii?Q?AQu/tF1pTrMeYmqTZmJXaTxtdTEiolabMJuL2MuK5FnODfMQGB5lFsmZOv9x?=
 =?us-ascii?Q?bOyJV0HWWHGrte3/IiK2ElJZ8CURafk+8Kp1YElVZWAit6tUvIEfheorlZi0?=
 =?us-ascii?Q?X0hQMaRe9TwS4upRVs6E9zTRQpFIqbgbX72o4sTxJg8RpxzSPgeHqEIrN6ML?=
 =?us-ascii?Q?l3cfpZEbPBX7BaIi0TELfh12EyMV0zDiIHWnrNIaAVAQTwlh+WFidfXslluK?=
 =?us-ascii?Q?TobHRLBdxJyDnrDH9trc72L9dKgqwxZYos4a1LOMhtRVqdUwAVMSVa/t7bxh?=
 =?us-ascii?Q?CH7EJ72mOTtPp9eKSBGiizHWi3bwe6Gz++BvtahiQwOTR3v/7GSad1GK4p/G?=
 =?us-ascii?Q?6UZMKo3XA2PffCAhQijhZ8Ar6OEMpkwOjVrjTjzAuKpmp06MVlIbykCpE9M1?=
 =?us-ascii?Q?8R1cNVoY9JsAtRUddDleRM4hN33t9XEByFMEXMypSG58f+Xu+wA0n/RxOYvS?=
 =?us-ascii?Q?XI+qYv76Pp5fhybRtMQzt1482KHV/u5tmJdjixp85Et6KBTGOyvjV6YN4UKN?=
 =?us-ascii?Q?RsMy63vsR61TqjBb+keP+5P5v7jA1vRN0wNUfFV4J3pbxR9PDWkqcjunRD2f?=
 =?us-ascii?Q?YVv+yXBnW1IvMVR4h/DmI7bK3Ha+RGOP5YgQBc1ax+vDXX7qJwJhc/elnaSW?=
 =?us-ascii?Q?rrRV6bo1tcpfD2n9zLUX4iayXAZNEvplSkAz2txzDhPA01RNWNxgrHvZMjcq?=
 =?us-ascii?Q?kuZr4e3XGjGZLw904ppXoZJ+3VdyhIBuItpaqlHL1v/rzw/M88bZivSjEY8z?=
 =?us-ascii?Q?LlFdKbYKPtLzWGuHClBXi4y5fIUIIhH6XAhTcxkrxVYy8U9cmE6VJ7S0LfQx?=
 =?us-ascii?Q?wvOFJpGiguJOjAO+2zq6dQmC/oq7bmcKULsseucJJVZK9534F32QtAXB3Z8E?=
 =?us-ascii?Q?n1HZcdYr8nws+xVTYvMQRlKx8cGZbBdt6F1uHu0GD9wDgF/GT1vU+6brQ9eD?=
 =?us-ascii?Q?/J4vxkRoZnSmnuz5Kp7f6jPI5gbcHEuVVI9BxXcHljwyeQwHqRREh7nF/2AB?=
 =?us-ascii?Q?wZ+o0D0qu0mbHP9XRsdXYxJbmKkPmEc10fyPWo5jfp9Fu/eTWBsHoxwcH3OI?=
 =?us-ascii?Q?Wqt3G4r5JVcQ2o0CF2p5XpYtKRh8wJKROvXhSY82nw04GDeCq2M35J4fPqSB?=
 =?us-ascii?Q?X0mGn3eZFNdR1T6h14aEF3yzjHiKx3de1O+/CbaKf7+W5f2Txoj+tR0f58e1?=
 =?us-ascii?Q?YvoSOgSIALczd09sr6syi8nB8Vm4qx+fEcxfPMceoMQAnHWj0ttPhoLLyRJs?=
 =?us-ascii?Q?l4j/F3ie0REVdTQ07MRigCWi3g4rsUjAjlQrKp+6pzfcI+Qb539ztDfm/ZxU?=
 =?us-ascii?Q?J4OhIxGfeG8csl05zvRgMDcQrAo24JAz+UdTLz344Sy5CqmAmE740uWsbFO8?=
 =?us-ascii?Q?OqCHimSDcWkbtdcq57IKhjKxqWdqVvkDK9CNUS+Bw5U3NZ+mzuL/JpN94T6B?=
 =?us-ascii?Q?gQ2mOxoKcLGoNKvEPoIqePtsQ4Lr2WujcLyhw47PnLLADL5LQBZhPXGL/bQn?=
 =?us-ascii?Q?cRoys8M0F5LBRfl9iP4ZSNqcHIEjx+fLm985AzlV+1SYHwlVOua0Y+JeAOZ1?=
 =?us-ascii?Q?LaXso80C9Kq0RJGSSJ+Y50SM9fuQtsu5n+gvQxT/7jrbbVo2Uqmo20rS4Ml1?=
 =?us-ascii?Q?zFprO7bCsT9F9gR+auYvMZrK7+eJEv1g6jr+VLItbekrbjLIaZXKtnf65w/N?=
 =?us-ascii?Q?J0CnFcxBxPGIvTgW+37Xgr7+8nIMmZQ=3D?=
X-Exchange-RoutingPolicyChecked: qFNG1mFBMHKN7nmho/JrvsAAchLTQMb4XQtkc1luOYfQexTkIfmxf1JZfosRSc/et3E9phdmsYzFrhe35olOL/mq9h1XVCvtXeyhXPB1VDnOmxKzbB6kz/LZbvyqJCeyqtmTzE381Zx69PLXjuxf9MNjxDGZe7BrrHnwTg8Bqm4n4ucgGaoe/uxe9N+q/nvoHbo+Y+eR01044yL84CgwuNNmSupHHyWs+XhK2ZUvKh3nvUb+tYdatZwOYFEIEdDFLiN26A8Go/76osbqc4+b/RKrF47Dkz6ZDUDfQve+4ivO49ggwigcERwpAt+fkOosnoXq+5udnGURKk89rhCYSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a7ae6-0b7f-4399-1ff0-08df304764c7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:18:50.3698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7Y5098LKEGnGg5QNlbRGiWfpFYXNf11VoA8TRF0n1FqNPgQYq+gqoJuSqrxBsXmRTLiv42nNUBuDr8XtK+d9oA1lx8mzqQNo3yzYBoUqFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB469167
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

On Wed, Oct 21, 2026 at 03:25:46PM +0100, Anatoly Burakov wrote:
> Flow engines currently distribute rule allocation and cleanup between the
> parser, engine create and destroy callbacks, and generic flow code. This
> leads to a lot of potential for memory leaks and bugs. In particular, one
> of the issues currently present is that when PF initiates reset, we are
> meant to just drop all flows without sending any virtchnl commands, but
> because not all engines implement the `free` callback, some flows will be
> leaked.
> 
> To address that specific leak as well as all other potential leaks due to
> misuse of memory by engines, use parser-allocated rule objects as the
> persistent rules and centralize their lifetime in the generic flow layer.
> This requires fixing all engines to not manage their own memory:
> 
> - Allocate the final FDIR rule in the parser, use it for action checks,
>   and remove the per-VF scratch configuration.
> - Have FSUB create adopt its parser-produced rule instead of allocating
>   and copying a second object.
> - Build the final RSS configuration in the parser and remove the
>   intermediate RSS metadata, including its unused raw-pattern flag.
> - Let generic flow code free rules on validate, create failure,
>   successful destroy, and uninit; remove engine-specific free callbacks
>   and rule frees from destroy callbacks.
> 
> Fixes: 4dad1a6815d6 ("net/iavf: skip flow flush during PF-initiated reset")
> Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h              |  5 --
>  drivers/net/intel/iavf/iavf_fdir.c         | 68 +++++++--------
>  drivers/net/intel/iavf/iavf_fsub.c         | 23 +----
>  drivers/net/intel/iavf/iavf_generic_flow.c | 36 ++++++--
>  drivers/net/intel/iavf/iavf_generic_flow.h |  2 -
>  drivers/net/intel/iavf/iavf_hash.c         | 99 +++++++---------------
>  drivers/net/intel/iavf/iavf_ipsec_crypto.c |  1 -
>  7 files changed, 97 insertions(+), 137 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
