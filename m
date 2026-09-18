Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B11C982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 13:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20FBB42E36;
	Fri, 18 Sep 2026 15:50:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C55A740285;
 Fri, 18 Sep 2026 15:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789739450; x=1821275450;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5gZ3NsoUef5YBWS5hcI+t6ycgs4lm5VyfhsyZPx4gAc=;
 b=TpFPHVwrEfs4IRnwzSycmx9EeZjbg5aPwr0ipCYo4k57joAhL9AXAn+y
 ZoCoVi6XXt23KDEr/wg5StIlqPD7PuPREd7M/hxhDXCtjBY8bVwXJ7Fv1
 8PvGBqwS73UPYHw4cVQxhYQW2SNDQQxPGcnF1rnASNLEALvGMMYDL9SM5
 7X+avTnInVIcHKKwDcOUs8m8imDnA86nqQsHSVkn2qB14lwZPoWrDyuaQ
 6qYjtN5EGRbp6f8NGlbaKqVe/m9bw5icca9iQWYE45kRIYs5W44NimzM3
 3+I7hrXgxtKseszHeWWLjjla9Lv1h6KoifDap+MNbFBy/0AugsOZHWfaf g==;
X-CSE-ConnectionGUID: 1Ekz7PyFRMqvjbmW2f6bZw==
X-CSE-MsgGUID: AnuOV/aFRgSx1j8fkEslTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115778351"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115778351"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:50:47 -0700
X-CSE-ConnectionGUID: MxJFEF7yRwmniCqfar+W1Q==
X-CSE-MsgGUID: j1TcgEPIT9OVe30kkAvZeA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:50:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 06:50:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 06:50:46 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 06:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etr+2BR0DpG2Bfd1sn2B0XJNQVSisuNtYycbEZsLHxuJQV8q13Qt+fgdmjr1HfpbHerayRHA99pCVViuZEBYYgeGZhRXIYii8rgegwaA/op/ITdJcIYdVPOi1z3BBhvWAnquYdXEx1XjvNkRcjDZReBBhke552G4keF9dij50mUYE3ByHxvcprKGosPgCXpmvHkBO7fIsJaJbREDRPOGsXHAM8LTOlgkziB1VFz1FfzAG8fNJ8/uB5D1Ih7qrfB0IMY2aA39ELBQiKUa3tYidmx42ElB9au9U7zbU1/rbw6f4M2L1IGJ4C/ZDPtqODamvO2Y+ncgZhNwmLblP/kTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx+POBHmW4i8cVaNiWgyBViZftrohPeh10D8uuR4WlY=;
 b=PZ3OuCg1M2Gn5P8795KX86FYxMULGFs/ntkE8Hqk3pTrXmdA5xh+3B8n+Co8qUqG+7MpqJ1PwC2o8rYOwydsQ/n4jkr5Y8YZQGfQi5/10+pcAZSjkf82AzqHZvAHVZrDbCJyLr6hztIwFtlraJAPKArSCQDuLpAnWWZgDRSkaCoj+fnSlNYTTzTx5+YjW58LMo2ewjNM8lMYd3BcJlY9b+CnAhkZ5qe1fJCXxnyGq4hI1ckm/OqLakN5lw2SKt9wPk+lMcIY3iIPle955f8p7TdqQLaNVY1Ta47/y2Wxyg2lKJ1r1+EowFfj5ymBDjYmHcFl9Gx9QUBDcgzteqlnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ2PR11MB7547.namprd11.prod.outlook.com (2603:10b6:a03:4cd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:50:43 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 13:50:43 +0000
Date: Fri, 18 Sep 2026 14:50:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix repeated Rx packet buffer shrink for FDIR
Message-ID: <aq1BruyBz4euARRM@bricha3-mobl1.ger.corp.intel.com>
References: <20260916135827.116145-1-zhtfdev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916135827.116145-1-zhtfdev@gmail.com>
X-ClientProxiedBy: DB9PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::33) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ2PR11MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcd95df-cda4-4ca5-b854-08df158bd512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|11063799006|10067099003|56012099006|18092099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BDrSEIDwZKTCHY+55G0hFUGasiNuchuu7cRHain3KGnokCcY3Ea6mJQWewpPdKjbtXPMpLIIh4IY7ef/Al1qGIvZkt83cvjflYN7PtYP3mNGcMifNfcO7NDeqMVYQanP1Q6WxxsFiBpp627TP4Vq/k4vdxWRg4N/vv2TSDL8hoC8NT+L2UOhIE5TkS7Cag0w6WwxJwLyulI4Ki/d7Y7qgfbsf+0l8irWxEmx53dEmVAjlHM8+liQcV3fXAYMF1bjWSiccJ09EeMG3ti+mxDac0YJ63bz5pK9P+ye2Z3zHsjNGmwpclyFIoOrvrQ+rokJFsgxmubSDtFQK5qEInqTUsm4WsSMFa+jrwz58SGYwRWObdj66L8rsXdehi+DwMnQxWQQKQUdJOtv/0J9YCraIGWdyFD3ocD1toQYyFb8aTfBSmoOQrxMQsfGIVZzE5zZ3cpSlZzbplaFyJEyW5Eo1OS3Na9QfWZJknAwL3UazvUjBGoV7ZlfM4wx/p7EHuCqNiEcbr8Eb8nDPQSQDukqT2FDUMp9/RHF5VXY8LpfmHlBck0AGLkLSMEM+kZ94YLwx9L6hyb59qcpPrrsyiXaW2FqTvfY7d4bEEQvR+sI1cobOPe6qw2YzUkMfZb/oXTa7Qh7iTqkcXH9If/Ls7RPFIt6c+SX/m3C2LKcS+kbmlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(10067099003)(56012099006)(18092099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1k+MuZ9fiqRNRvz+pXAXciiw7t//y+K/htzGa4rhyjXf3uC7+W8H6esU2xaB?=
 =?us-ascii?Q?32cb+pVMdVy4c5lAdf4txQPVRUrvg887JcmaIgSjaF4VX1QcYp0oewLM58tF?=
 =?us-ascii?Q?UDivbOGLgUwzVQCe1jW1V3j0QpPWXF8KzTmXfRseue/9NCYs4U0qrr8ILqYk?=
 =?us-ascii?Q?XALpOdTXVplIVdVcaTaBb67D8ekImeT4nMrEqNQz8SL9FMrPfQtn/9zWzJxv?=
 =?us-ascii?Q?8ejZrUuToXo0oaU72AIkDpBkslxuFuvD+OPn9Ti03ckg25alzKLk+mpP65eB?=
 =?us-ascii?Q?zTf3bWYX8HhrSLM6znUopB2O2AO2No7YbwtmQfyiW6S4vyZR3hhK4oXJfN38?=
 =?us-ascii?Q?257GPhb6Wmh3/09ePKF16uuOo0fRYUGJ7Dlf8GYQEVr2oVYDK6MPs4CllG5/?=
 =?us-ascii?Q?et5QoFZ3Oa2Ta98cQfp0FvvWifzVQeGeJf8dCZZdc6CfrDWVSqQJslM40E+Q?=
 =?us-ascii?Q?r96mvfT9obBuf+Lq//QQNTQeLngodtpYAYaUIpITIJ/Z5e7QYOL3Ayzfb7VA?=
 =?us-ascii?Q?AgVunMZbhEqi6jfSF+uZGX+ttzeX3DrHugFPCgUyW6BlOkKFKcfmq6MJhtF/?=
 =?us-ascii?Q?gIN92tp4sNKxZPBwPCPXBVLTVnrKE8SJ2oTgOh+FOivhGSVlP3qaMvg6ztGh?=
 =?us-ascii?Q?IIr+fT8uE4Q0lEqyUlL82bffsp7IezFowK/Y1M3/wmI11NiqlRmqqFMEh9AM?=
 =?us-ascii?Q?7eY2tE2PnoHJW8YJ/b6+eolFUEwIc9ABUDBSjsTVguvM5lDeJyjgGHS0t2LP?=
 =?us-ascii?Q?CKKE3FGCPS8nN/chh0ZhQulx23qRLu0wXIrB950iDEcIEhhitJIQGWE4Go04?=
 =?us-ascii?Q?Da/ehop9eaFVMBElsarU9Nb3p7FuMmTSY2sV5+ER+QBuvgCLC3pHgLyFYh6D?=
 =?us-ascii?Q?scI37AahPiSium2NPDRFDfdl05PTU+Ckvw/FTzYd7FgSh+odtnT5rQ2mg0Xx?=
 =?us-ascii?Q?C+HrmWsx1Q0bayP5Q1+hF7h5tDTNKir/ZS4wggLRkCOT4zZdJAWn4+6HeW6N?=
 =?us-ascii?Q?sabYIkcM6oGWP5P+5gjSMXH0anTkZTs89Shy//a+w2nx1lxAUE/NQsCuMJU3?=
 =?us-ascii?Q?X2AEYOjqABrYIPC0sIw09W0wJkWWI+fxT5+RcbdCUB8rjsYaZRXyYfdcv59W?=
 =?us-ascii?Q?NlFHJUSxftaIbY/+OuE03MhYfKbKcsAHM0wB8c+YI63vGDXBzHxovQa+wZXj?=
 =?us-ascii?Q?xf7KGOG7xG/baQQieBF7PVdBlOXO1b1ZkjgH+TP3nGVqs8yiX1UFo6xgPjwg?=
 =?us-ascii?Q?UmqyIk3Wt5REdoqZnh+GbM7TkYd0xKgT+4rObZ/wa55GIjdcb4WW1MXw8F+R?=
 =?us-ascii?Q?sz65KFA2tWAu8De4NCAVwXYIVHtNoUnRZCo2OjiVOYBcfGazjphWXcfxKdgH?=
 =?us-ascii?Q?bt+WBEY09HV8hTr2U4s4gw9e0mw2fbPd2CWCaQxeQ3bTN1BAKkP9JRrOs8Pl?=
 =?us-ascii?Q?GXnzgeE5A4uCHopU4GSCGeYdPMjewp4k0SIe5XZGnpw9+ZnlrcR0FWfpcU5Y?=
 =?us-ascii?Q?VOCp220FBE7KcvqKGSTzoRpUqI4jQ5JWeMTd3q8ByKLMvkLaOGr6N4UPPvYJ?=
 =?us-ascii?Q?Mhf6BafVJDbbY4QcUpzTlzKllgAd/iBbCeb2qfSHVElD79HC1Nlw0geO9H+N?=
 =?us-ascii?Q?F0+3DCXB55S357lV893Ec3zGrWzSOg/oC9iAqD0Hg92wtplFRbv+R/IfqPRO?=
 =?us-ascii?Q?nVoaAPi/l1DazZhVu4ef2c957k/61gC90IdR3OVjSKIlhoXVlmALFsgBPkV3?=
 =?us-ascii?Q?oIL3/XXTXhsfXU5VpF7kKMzdaSAgaZ8=3D?=
X-Exchange-RoutingPolicyChecked: DhopO1az5U+70h6yvW8SLEtfj8+RqdAYAnVq5sth0Gy01Os/052ssUaA1JVE6+TydpjeRMjDPguFWcuWe1KhvwBW6uTijReIPw3rKTtpFihGBBfzcVwWdzzQ1r8FQWcvJV2s7HNEwZaWO/VH/NmRBjestXC4TGrDoI8A9xzFRE1GifakJCh6BlYHoEf0NMvcBBQStmacmY2f5qgQT7ADJPFw/0nrQOXZ0Vr8Vy+nndY9z5Q77PqKqO3Pg+MByQEkcLN0R92o1velYh8chpO8k79jt77+I/gB6mZugoxsd7UVQkCn7a/H5ATqND3j/ilZtgC2G5kuYjMrwA9tJfLc1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcd95df-cda4-4ca5-b854-08df158bd512
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:50:43.1827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qwbva79X0M2v09jcqnlePrU3hvakN+QSdz/vnn3FtrX+c6JaX5xsXBw0xpqGPypfq8D8RO+yNzwxOcFi9G1IKCL13PIZpMugJIBjeQgOTjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7547
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

On Wed, Sep 16, 2026 at 09:58:27PM +0800, Zhang Tengfei wrote:
> Enabling Flow Director reduces RXPBSIZE to reserve SRAM for the
> filter table. Clearing the last FDIR rule set the mode back to
> none without restoring that buffer, so the next flow create ran
> configure again and subtracted the same amount a second time.
> 
> Keep the FDIR mode after rules are removed, and subtract RXPBSIZE
> only once until the next hardware reset.
> 
> Fixes: 301abd26b118 ("net/ixgbe: reset flow state on clear paths")
> Cc: stable@dpdk.org
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  7 +++++--
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h |  1 +
>  drivers/net/intel/ixgbe/ixgbe_fdir.c   | 21 ++++++++++++++-------
>  drivers/net/intel/ixgbe/ixgbe_flow.c   |  1 -
>  4 files changed, 20 insertions(+), 10 deletions(-)
> 
Reviewing this patch, I'm wondering if this approach is actually the best
way to fix this. For example, after this change, if flow director is used
and then all rules removed, the flow director mode is still preserved,
possibly preventing use of other features that conflict with the old fdir
mode.

I wonder if a cleaner fix - which should be shorter too - might be to
instead just restore the RXPBSIZE value back when the fdir mode is set to
NONE. This gives a clean combination of (enable + set RXPBSIZE0) and (disable +
reset RXPBSIZE).

What do you think?

/Bruce
