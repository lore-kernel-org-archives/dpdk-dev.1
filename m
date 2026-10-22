Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448ED606A330
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QAfcCcd0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C2DD40264;
	Thu, 22 Oct 2026 16:31:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D4B434003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 16:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792679490; x=1824215490;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lWUTSd/4Pil+8jUkwENgZOxxloT5iZPVKZQqT70yg88=;
 b=QAfcCcd05ifVS4Bq2eRgzHGsYWTvI5h+Gcb3qxwWL68ZzjJV1UOcqBE5
 9LaJ2V5uswyP9kAfYwgeoYjaDVFqlv7f0hgTaMRKZJBAMW7zv9Wd1YWnA
 DuwVffH+2HSBVTX14ZCdQxVMiUSraiihY8ujzumfk9nc2qAGlYJfuLKRO
 J5NNwzyqCKTBOVswSI17p4hdUE0r/YawOtPggqxZmJcA7PsEzdGb/zrQb
 DPtlD4OIOf0fq6Q9AOUF0EWCC0rXAzFgduLoZEn/15svKky/ywZR4hwF1
 tWBDZIbr4przXCdDqZf7jGbfGyIIvu2up5uucrcce3JOcTgPG6nB7kfri g==;
X-CSE-ConnectionGUID: L7Bgmz6lQDivFc799pDGXA==
X-CSE-MsgGUID: SmTNdhPxSImr63lOW8AnuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1462310"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1462310"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 07:31:28 -0700
X-CSE-ConnectionGUID: iXZeNqFJQdKW2yx77LLaMA==
X-CSE-MsgGUID: 7wt0NozmT8au72IZWpfsmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3709787"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 07:31:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 07:31:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 07:31:12 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 07:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Szsgf+Kp4Mpz2P6mHg5c0byCa4kbolbIblJMUuYKfTR5ror1lGtbARGFK4P00/PHclu9vp3jv9aODQcnoyMmV77QehekhFRgrkN6J1hWOn0FstU72+LVSkS1//KMpnf/4lCbu1CV/Z3BODm3VFGNW7KG0ThSXTJT0PCMVumA9V8mfF6D2Mv0+3t3LfCCeChKKB+9nWfwUY6QX6n9TwoYlZTCNftuCd2o8bn6PdsRzyR5oo06X9H2jQPNsxGa3RIs4hwoaVMpofl3NOlpBDWNdy0HOZ6FNkBuzG1TjOFpo5+2ZlTJHaVzq+gxaBkHum4qB7zjmcqGZYMT0Fi/mZmH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTn1Yk9fSptrk7MscKG18DVlcfYQN+ISaSw6zU989VE=;
 b=S2CQ3aamvgmlPGEweuHuEzUc4CrxOyXhgsHRJmoF9B2KmdxAemL0Xt23Ex1WCO2BCUd95CBjSuCtD433zT3834CsqmLHcjX0dT6TZp7TIsPHlAyFXwTCf65Dg1g4fmm2LQ6kxuzpDCscn8lwxOP1yemKemth9moHUssRJ2cOMzJQgPR3MNw5dGV3P2wxlKyZmC+w/r6FKMhhohdBh3X0V7m1CYy5B/I/SkKWDY5B0CaF1w5ofipu0I5PQ1kokGJgk0C6hbqqY47ouRVfn7jq2G7PKqK9aDhiKa6LQ4E++zxjjbHvmYg/WDmlNy5IDYGbjIrFal0ZM0o7m4KC1JZFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS7PR11MB6174.namprd11.prod.outlook.com (2603:10b6:8:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 14:31:07 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 14:31:07 +0000
Date: Thu, 22 Oct 2026 15:31:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Anurag
 Mandal" <anurag.mandal@intel.com>, Ciara Loftus <ciara.loftus@intel.com>
Subject: Re: [PATCH v4 07/10] net/iavf: skip RSS teardown during PF-initiated
 reset
Message-ID: <atoeJrYydnm6vCL3@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
 <5a5434a307a61a2463a154db7b30baeb40834fd5.1792592724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a5434a307a61a2463a154db7b30baeb40834fd5.1792592724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS7PR11MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 209b29c6-a99b-4feb-9439-08df30491c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: sD8CUeG3SQQ2IofvbIMfdkCLeON5iLwC2pdQ4w5k72tDUBLVudNzln0b29nHkUPwEaKT02seseO0Cok7Y/F0N6O7/0zIN++pw4C3ePynntUnLvrWEoiE3iqVbWyk4TLhJDH4fKSi+8pzw/6/SyN5ShVFZYU74WyHGJooP6w/86IWlzKusP6ylZPCWvvBidWcpCZfvtseaSlcdDKQIUNGbcW5zqkzsQdF/uD9FNhCi3zFr+gyFxwzBTc/dc701Ne867mZ2Is568VMOHwktJum73iA32jy0WK8sOuZRQr2NphIcsuNdXY8FLwCRIVXxEPuODeorruM4HThiwm/K+IdRWyeOEwgYcVZu4x7zAAvPJPUBsqM2eF8feIg9PUr3lgaNg9AetOJU/8vkNl7vXO6k3lMWdV38ZS32mDPBLEG3dHWx62xjMV+R2YInXUL0YDjmbryiQ8jZ1ZGlyb8w/2anG4yR7+46n7tuX9m6EZdJa2zJiGf3GEv8cR/RF4vA1Bh7Xd9Pjzenja8XPO9mVOn17iGLBWwuJc8O81VGQBF+XAjbAVNny+6pHiJErSFq+UJc3CJWvPP0DqtcAY458B/ecE5rN8RySYe9Tu1QzA4zBRx42nAJYvO0BEpmbR338SEVfJS9MBGsC5ltMnPXmHxgtpDyKi0qHJJxBiC8SmagyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AvpsAJu7WITA12IqB77EZD8yBOJJd8dpLrb9fFeHequL0PAu4KgFxpZizgpi?=
 =?us-ascii?Q?uH8FhmvE1/ROzt/Bzp64bSkuJyfAQvWdZEj/5ibDC8Adb5JlaBYAFoDkXJ1j?=
 =?us-ascii?Q?3P1ajL1jvTmlxRh05Et4Adl1DGk68PVXgUZ4Z7vBUhCcWfd/ddo6gj6A2GR0?=
 =?us-ascii?Q?ZA2Ldq1xtDYu7XEbcLfbHOGgN2fZZuMG1DrCm9znnPC7Z8TO1EIXQsrzIRc8?=
 =?us-ascii?Q?57q0ej4dFzxA9BaAxqK/h1u2b/ihqEJA5NGs5U8UmwSAq9lbKAfqAlvaq79x?=
 =?us-ascii?Q?cvPyVn4Q4q0lJid0nlYvHbcUFbx8wq9J+oNpNvGKh1Qb4IXAqlsPr5l1ZRkz?=
 =?us-ascii?Q?TuvC1BElH8XwQahRWLKPgoctyDMqE+Oq5MB1vBCGVWVchlUT/99S1hYyewbI?=
 =?us-ascii?Q?cXd1VWeMFOdSfFau6S7MRHUKzEBRtZ39u9mZbNwQLYmAsxh6Nwc1G6K2Md6p?=
 =?us-ascii?Q?DEsKsNicN68t3ESjXVGs3ip0QcpQZmcYf7oFoi4Q7DxKOwgHEJgpwR35DGOx?=
 =?us-ascii?Q?yb9Ph0nsaRPoQawygOYMH/SfDdgJAyRY09gXhcEwTDeac7EXy+hzpaIKMWwB?=
 =?us-ascii?Q?mC8vH8KcUqmHHgSlBHCsuLRZZfD6C9AoSuIq1hAJHXILEvHDst320RuPGQev?=
 =?us-ascii?Q?YIUQ3bLt9PKAIDU+ZvHhLR0S3QhqJm5/ljRdq91ZsymmUqJo4kcIwpGtO2+6?=
 =?us-ascii?Q?fL23Z5YVvu96kF4FxLk46TqwtmfTgJrdae/NJvpO2sqwKLulkZ/vp493AQ8I?=
 =?us-ascii?Q?T0IPgJsws/7hknUtM2HdjZReMuYWABRSw84yiqDE2wi4s5jg5n8uRt4E/C++?=
 =?us-ascii?Q?1hA0Q57jD7olJs2ApcOhFACB7q8+JL2LtZ5MaUWrpEDVkvqAlW5WiSYE5y1H?=
 =?us-ascii?Q?wUkJyhgIqvRfZF6yJS7B4E3Hkd4pkspJCGCrGIOG/CtwqXZkdCpCqtDNLQlr?=
 =?us-ascii?Q?9cFhZG7N1zKJnbZW+IxJam1NSZAfHA0O4xXUUb9+C7l37Ga24I9VcTVWmo22?=
 =?us-ascii?Q?XRiMN57TAj0hdWawD4LIL7eo7khBsGfzskNrBLziClL6VKHi0Bhroa9JFvQs?=
 =?us-ascii?Q?q+4PvrmZdVyaRMVxsK4Ic7siIALhMyvkSTJDcn54WuWIyu0j8novfEeW0ZDc?=
 =?us-ascii?Q?MQDixaasK5h4pJ90NAVknqxkW443GrHZRKw5FMepCrn7rX8JN/9Wdj73iaeD?=
 =?us-ascii?Q?+Ss3+jLu4q88qZtNmSrx1FDzzI5jVGeVdOl3VaOBiekr/N0ZX4hf4O4m7n6U?=
 =?us-ascii?Q?wiRsAHJNTJ19o9VmLzS+lTqjtN0FhgqgJ0peyq7N6x2MDomhPQBFXKAGEMIe?=
 =?us-ascii?Q?UV0y4sLuAo7OeMSr5CT1CfVvarBKK5DG347dUt81fs2o6awsfT51IdwAn72A?=
 =?us-ascii?Q?kbqZFfXDi6n8kbgwiTNbAf4DzaRx63iFN2zMQncrKlNKrnFwTUTTBZt/Nwra?=
 =?us-ascii?Q?MRx4BNePvgMH4/CDdg+47QArR2IG5A5F/gws1/l3gwj6UCmrEb5NV6pey+gw?=
 =?us-ascii?Q?77ntUpfp79AqE9qP5UInoabps5lrFWU/emhqHSbrLYDMMUzs48fjbnJjE3xs?=
 =?us-ascii?Q?TOa74HjPGCV6jpLYC/Rgz41XNVcS84zaJXjiYiSl16aMG3okMiStO8aE9RdK?=
 =?us-ascii?Q?SE2vd/nS8/YW5nFouyk7xBcRyuy0tgn6eu0mrxGR8wPjcT86RFhCZT3a64C8?=
 =?us-ascii?Q?twRyvY6+Nuwhzm0IXWKkddL6xnAtrlNQCaI0cf3eVRUBrCnmz6FTk31qqy4x?=
 =?us-ascii?Q?9VGEwilplAYoSfYAeftusipZDYgou0I=3D?=
X-Exchange-RoutingPolicyChecked: a8oLE72By0LY6NeoRh+RQdzKCDc1Uto4Sz2sROpdHQT8R3inQbIrxtnRMTlytzDuw+STuXoS+Q2V2YWjmHkLg2tu+hDZNPw6OqmHS2y2HvzP6YsHpDH7Evtw9568j+BssuGOy5BLbftdhqnCXM0o3tK5D64JtGiyFI50d6lfGLJp3ZOjrfFyeg3FL05MiwfO6WGYGfZWAmJTKiP4lSD+liwAhzW3ckiD4+oa88elLFuj6cTxu8eWDiYt+3pczz7tgXdMmJuCq9e5zH7GibEx7VpF8i4Cd9w6RiNGbG1sNoz5KZHDqTUvlE30+JDdLP4NwWFp32SMAdl9JMOOf4l4BA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 209b29c6-a99b-4feb-9439-08df30491c4e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:31:07.7574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qgix7rCAIcPhQOA933pQqulxGww0A1Ni6yetlZTHBK5BUNzhfuYYHHcAgeiWy1IgnhBsaL9zbJbF1zkTY3HscPlB1sZlrHVnD2b0hALEEPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6174
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

On Wed, Oct 21, 2026 at 03:25:47PM +0100, Anatoly Burakov wrote:
> During PF-initiated reset recovery, `iavf_dev_close()` skips flow flush
> to avoid sending virtchnl messages to the PF. However, `iavf_hash_uninit()`
> is still called unconditionally, even though any existing RSS configuration
> is now invalid because of PF-initiated reset.
> 
> Move the RSS teardown under the same `pf_reset_in_progress` check as flow
> flush, so that no RSS configuration messages are sent during PF-initiated
> reset recovery.
> 
> Fixes: 4dad1a6815d6 ("net/iavf: skip flow flush during PF-initiated reset")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
