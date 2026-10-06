Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F53CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:06:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA0A740262;
	Tue,  6 Oct 2026 17:06:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 265054025A
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791299215; x=1822835215;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=S9MnF1SOM17Oj9Sizpwir8KVEi/Vl7Mh+47gsVyw+GM=;
 b=GDG7I67VR2nopV1XOCYo2ThzuScyLafFYEzuDDMionW8gfpOdYhfnzBI
 3R9zBtfOnk+CTQmRxgZW7PmUD2adQpP0o/yf8KU8rBTF30p/V4YSVtBDc
 qosGzQgGHt4HUSUNIK+gjCFyOM3e/ToZMyc2bShJLy8M42tljk1QQUIHO
 AJobu4sUu/u2leBxBwMv4LrhgqwhpJu4aNNaJkBC0xd68wQ6DkbHmeTc0
 wcyoLssAnUinme8P8Sh4OF9igsvKonL/pWxXUh3fgA/GrsstuF6/tepKN
 T1SgJHeqnXM1jubEFfP7YFlUHsnSKj7nfnetOig2SQPIh0WRuTPouVurm Q==;
X-CSE-ConnectionGUID: S3eTM+uPTkurHRrXRPFOqA==
X-CSE-MsgGUID: ql0xMYJ6TFey98gvfnX7Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="44676"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="44676"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 08:06:54 -0700
X-CSE-ConnectionGUID: q3jgF3cxTayJ/C2J13Gq4A==
X-CSE-MsgGUID: n/fbhTB2QN2kYKIIjzygBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285077899"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 08:06:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 08:06:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 08:06:52 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 08:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixa925KR7r74T3Cbeb/OsxHqOqGfGUNjzSHKS5MvxJdAVFsfemF4T5yUYWDZ3I8Lhj9v6x5x5DJViTI1ixvvetQnZ028qghUERYOvJAjyMT0LuHpkPxgOFUXkTfHRvWXlGc2rt1160RIhfAiofl076/0gmDpR61bWTB7WzofaeEyOXjXu1CF3uRFypFdieNYr2kdC4GSJtMWX/Eg+SzA4kjZf8VX9vzKnXd9shle4YCjCYFRgsa17Le4nuddKwqDKLj4ghS/3HZfDAhKbm2f1fPTSriucJzoUZNB4lPQ2vEmULZ9l2AUnKiAjxIwFTw5lG51bXpufX5AGRaztFk6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP+Z3/I8w8PiO0StG2A2QHj371PjJCcd6etA13qXE+o=;
 b=lhXupxf5UbuSL86gJG/n0nKT3xMBJqbPpeIlDBDcvMN9R/s0hGt/cRY0A7eCBULaot8334Z9DUGZoD0ojtB6aIAlHKqvoyJKTOYwF0EgMJcTC71V2Qd77C9YWwigZQ7jDapdHyndxD+SrnudCd4SOf3FfiRg3Nau8XZonhaCkGqQ6NXVZEqDw9MxvpxBrmQizVias1o/ZlIS3/jZhqSYk6ICxFgjSBByxJhOsvgDcL7prH3YQAZ2cEa+N1WVcTP6fA3qCKfiqVnSD78sC6ysIYUBZVH9PUPnx6t/Hb6zadjZk9IhWqbyhBIZulSF5LwiZ13NJNXoM7cSg+kgEx9BVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB7031.namprd11.prod.outlook.com (2603:10b6:303:22c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 15:06:45 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 15:06:44 +0000
Date: Tue, 6 Oct 2026 16:06:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Omar Munchaev <omarmunchaev@gmail.com>, <dev@dpdk.org>, Omar Munchaev
 <omar.munchaev@gmail.com>
Subject: Re: [PATCH] net/ice: use macros to get field values
Message-ID: <asUOfig13OM62UwR@bricha3-mobl1.ger.corp.intel.com>
References: <20260928172759.3369704-1-omar.munchaev@gmail.com>
 <20260928172759.3369704-2-omar.munchaev@gmail.com>
 <86d76bd9-0b96-4304-b8e4-a70814ab7144@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86d76bd9-0b96-4304-b8e4-a70814ab7144@intel.com>
X-ClientProxiedBy: DU6P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 395a8d65-2995-44e3-f90f-08df23bb6f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|5023799004|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Nf8Ed+M/dujU6XuEw5MTcLcEq/9QrmsTYAWDjNlgTxh4+G2O7jv+lMRJjgw966xUremu5o1RAcAzf4awAs3k9BPyvrN6rJdMK7dNezl8B5I82SMDIgzBwvd7/WatKqWRxWmWnhNLBmqXkB/Y7GunjnuYzTfBrKsVy5/mwCtJXoVBQC/A84rIDtvnG+Wbx4+S1DVyhwzw7X8ziRz2cPuRFbIJFAogKkWX0pf9WEh+SSRYAuxg2sZlG5/qbFV5e9/22MUlbK6ovlVzhykbhHJEYrjnp8nsi5ekN3zBSxZ3pUUaw2c3oIBMP2kfHAm1S7Dm92IC7JBE61qTQYa4evYxXPNUf7wVTZOT/TuS0gxXoA83/jiL1URmS0HZHGg7e54qGihkG8/lOHP9V4QB0eL1N8r8HIa4yDXH/jbRGgORssy8nPtKSOagv8srlXDg3gd3eArnHdSxq+Odplv341hSDCJNHjG7/Mq5rIskeI/w9BGXhEHl1VQUou653JUNmglEOPt300sVAlOSxmNrKK54NIs2EdWa8M+DdLcH78KtkvVnSa/d53VK5LiQKW1oBoV/Xj9OfRyxzrC2sPZ8SM+rUJKpufGHgnIoJ5iXIII0zI8gJsb3NWLRzO7GBGJ6fXZa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFpZNCsxUjR6WFJXN21DZmVrbEtLN29nZjVpMTJDM1BFQlNxcC85Ti9tSHlY?=
 =?utf-8?B?UEpyekdtclFJWnR2K0ErbjZnU2Z3ZUtvV3FDd1NVayt0VmJxKzBRNzhveWpp?=
 =?utf-8?B?KzlBNlNNajEvNGMrbXNYd0xQV0ljQ0tTOWtYbml1TmhCUVhUclR5SnhQZFIz?=
 =?utf-8?B?QUg2RDBUZ0J6b0hJcEh6c0FmMmsvTFNCRjJoTDhBY0ZEU1NEaXFkWm10UWZm?=
 =?utf-8?B?Y2M4OW81QklrMi9UUjlhRnRURTFzZEp0dFNTdG5scmJOd2MrZFhERVQxa3pH?=
 =?utf-8?B?SEFJRUFJeUFZbVpaN051Qyt6Si8vWm43U0dpSWEvUXB0cnRFM0VuUC9hY2Z3?=
 =?utf-8?B?ei9LRVNzSXJmWGhweFpxWUZvTVJkRjdwWnd1NWw0L1d6dTBzbGJlaVZvU0JQ?=
 =?utf-8?B?UVYvVUltQ2pqaUN3QW9lbjI0OG5IQkRzUFF1VVBPSEdpM2lkdzZZOGlIMnlz?=
 =?utf-8?B?ck0xSHdQYWV4aU9oMWY0aUhuVHFvRXBTajFSR3MzbFdHWUFySDNCbnRxTFNu?=
 =?utf-8?B?ZTdqUXVEMzkvRHlsdGdLOFgvd1pTbGI5L29PZFdvRUxFelY0U0dEYzdRcG11?=
 =?utf-8?B?OHg1OXprUklaNUt1VmF2eGdjVktsajBzNnorMkU2WkkyRm5NYmpaNzRFQ3gx?=
 =?utf-8?B?ak5pc2tCVEhFOWkrNWx6QXdVRUY0L3JBNmFOY2Y5aUo5SkJWenBPcVpGamNH?=
 =?utf-8?B?M0xOS1A2RnltK3BrMXdQQjNSSkVDdDBBL2cxMGlZNHRhazZ4b1E3SEJFOGRF?=
 =?utf-8?B?Nk16WTluZUdtbXFENDA2N2pldmFheFp6clNKbmtxTWRFb0wyNHd2QmZ6VEU2?=
 =?utf-8?B?ZVBTMmY1cmpnazlGTFR4dVZiY3UrVnNjVlREc3dwanQvZFJoekNBNll5bXMx?=
 =?utf-8?B?U25GZHJHTnFVRWtLZ0twUUhSU2VUSlI5aXh5UmVlT1pZakFpSVBKNGxOUXQ5?=
 =?utf-8?B?d1pDQUFRZjdOVWpuNCtmSVozM3IrcXlocUQ3REY5MDNOWnJRaDdvR01SYzZt?=
 =?utf-8?B?d2w5b2ptNWpabG1BeEwrd0JRT1VMM3BIRjRSMmVlZFd1UklQejBDcCt2Ymdk?=
 =?utf-8?B?SkRtdjFwUVJXMzRTN2UxK3lORmkxNlZsS2x1b2t6OWFDMVR6MDZ3ekIwMlpo?=
 =?utf-8?B?aERMREhhVndxUU1rZTMvR3NZNDYrUG1TYUxTMGYxc2plandPQU1XMGhHZVh3?=
 =?utf-8?B?MzJIWFRIbUpYUHFnV0pkZ1dESVAzWjl3TS80VmFCZWZac2h0dnZMdFFVVFZ5?=
 =?utf-8?B?WkM1UHlDRzEwakRPSFFnQWVrOUMyMlBOUVUwaXhDbjJ1ckxkY05Da005R2hI?=
 =?utf-8?B?eExNRkRrbjNHRmp0aTM3QTQ0TXgvdjRkbVNOYVFVQ0wrNTZNb3lDd2k4dVZp?=
 =?utf-8?B?aDZrVFZQbXVqKy9IeW8zUzZlNDF4cFI2UlRndHpnYlM1TEJxL2pYOGZqRitr?=
 =?utf-8?B?Z3pTV2VFb1ZUa01peE4wNC9DczVscHMzc0s0Zkc2T2V1OFRYQ2ZRTDR4N3JC?=
 =?utf-8?B?OHVrZ3NBWWNCNXpVMVIxb1VpWU5PRGhxU2FXSy9qT0txUHdVdTFraHVrWEc5?=
 =?utf-8?B?QUpadGxVNHdLOEZkZzVVRk5iZ1VsdHVQa2JzMi91YWhKQ2VZdjBTcEFLaGYx?=
 =?utf-8?B?Y2tQeDBlb0pKNDEycXpkbjJld3oyOS9EYVBrMjNwNkVRbjkxdUF2azVDWEpB?=
 =?utf-8?B?YmRWcUkwaFNVeGhmaU9xd1Z3LzdUUlI4c2NwRFY4WUpTaGVOZVF5a0cxMVBH?=
 =?utf-8?B?QjBqMWloTGdsMnp5OFpadDJkcUE4akFFL3ovcXFoS2tLanhDN2VxTkp4WEho?=
 =?utf-8?B?QkxHRitsM09IRlZkVEV2ZzJJcDBBTURLZGRTODh0Vlo5UWhvMU85VXE2cGx3?=
 =?utf-8?B?dFUwaHU1cG9ZeGlJbTdtdzFBN3ZqVVk5SmwrU095ZCtkOTc2SmMxaktYUDRF?=
 =?utf-8?B?VTRXTXVSNlVsbnplRmZMQ3Z4N2dDWFhaWVMrSnZxNFVDakI0N2JHNnl5T0NM?=
 =?utf-8?B?eFdhWGV3N2NWcXBIRDhiR1p1S1h5bzgycTYyRkNySGYzcnYrMnFDQkFkTTBU?=
 =?utf-8?B?dnR3S3NmSXV5c051cnd5SE1Oem54UFFPK1BORmtMeUFLdkhSVG03ZEF5d3Fw?=
 =?utf-8?B?KzR0WTMzNWtMaThORWVCNGd1QjBBZnIyVTBiWUwwYVkvMFNQdmJYajlLaWpm?=
 =?utf-8?B?SWx1OXNKR2JrVUEwVHY2SDBhYThheVl0Q0g4VjRSaEs4cHU5bjNhN1JLTU5O?=
 =?utf-8?B?cExKcnJOaVZwNlI4bzZ4dlBwNUJRY1dFTzdhTkVZNC9YR25uUEdSUFhlbk4x?=
 =?utf-8?B?WWl4cVNNV0Y3R1lmSlgwM09lcmRodVV3NlhmWXhVUlFVUzlIUXcvbzdJckFT?=
 =?utf-8?Q?A/Qx3G+4o4MupU0A=3D?=
X-Exchange-RoutingPolicyChecked: lDiR7uDww12aygrr2/QUYf4ielelaq31/x/PnOOI1IL5Vq5qZt4wEiYyHy/0rSgKNHvUKAp48MLkl5rc7Wsk4OzyUVxxwDV6/EkcsAmWbCVx8k/5W6+jRwwBuSftxPMzryZ7hPpL+0c0aqLLaKx1tXbH3zxH+5Sffens9DOux1H2fVnP604LoFcNIXuxFQTRO8jGIfGXpkRt/h2sQ4bAARpZ1lCMrgUt0AzGlvvU0rXQaRpGc3j4WL443ODTui+w/q2BVGsxS5vja6ZLUT2KXofW/E6v7+vtSpLbGqFInte6xEoOxIg2J7WgQNBVKI1N1grBaMm5XjFpJZppBXnltg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 395a8d65-2995-44e3-f90f-08df23bb6f5f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:06:44.8460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYJhwG5/GnNEIhLadTg7gJ4yKCM/jMBTJ3u9NLrmf9MR90Maew3YhX3Ph7CvH+55T3dlW1czk/2zODFT60Q0jg6UR/mFVriGP3ZMmTobOmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7031
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

On Tue, Oct 06, 2026 at 04:30:00PM +0200, Burakov, Anatoly wrote:
> On 9/28/2026 7:27 PM, Omar Munchaev wrote:
> > Currently, in ice_check_fdir_programming_status,
> > descriptor fields are accessed through direct
> > bit mask manipulation and shifts.
> > The ice driver has macros for this, so rewrite the function
> > to use FIELD_GET macros instead.
> > 
> > Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
> > ---
> >   drivers/net/intel/ice/ice_rxtx.c | 37 ++++++++++++--------------------
> >   1 file changed, 14 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> > index 882af80833..f14e5e56b5 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -4465,36 +4465,27 @@ static inline int
> >   ice_check_fdir_programming_status(struct ci_rx_queue *rxq)
> >   {
> >   	volatile union ci_rx_flex_desc *rxdp;
> > -	uint16_t qword1;
> > -	uint16_t rx_status;
> > -	uint16_t error;
> > -	uint16_t id;
> > +	uint32_t stat_err, error, id
> 
> Missing semicolon, so the build fails. Please run
> `devtools/test-meson-builds.sh` script before submission. When submitting
> new versions of the patch, you should increment the version, and the
> patchset also does not have proper threading. Please refer to contribution
> guidelines[1] for how to do this correctly.
> 
> [1] https://core.dpdk.org/contribute/
> 
> That said, the rest of it looks fine to me, so the semicolon issue can be
> fixed on apply.
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Given the missing semicolon, I decided to ask AI to review this patch
before I committed the patch with the small fix. It flags one logic issue
with it:

  Finding: FDIR successes are reported as timeouts. In ice_rxtx.c:4469, ret
  starts as -EAGAIN and is never set to 0 when a completed descriptor has no
  error. The caller treats -EAGAIN as “keep waiting” (ice_rxtx.c:4550), so it
  consumes the successful completion, continues polling, and eventually
  returns -ETIMEDOUT. Set ret = 0 when DD is present and both failure checks
  pass.

This finding looks right to me. ret is set to -EAGAIN at line 4469 and set
to a zero value nowhere else in the function.

/Bruce
