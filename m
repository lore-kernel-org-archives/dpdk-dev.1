Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4593C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B673402A7;
	Tue, 21 Jul 2026 11:12:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id B470A40289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784625124; x=1816161124;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=NjwtCCjfy6QGrWi7wtsLuu979Mk2ykv6B1aarNolkjs=;
 b=gSCghxW0wY0s59wOFmWI0qJ0O1iKkOs3d+OdM45aMJ7l0sF8KyLRaC0X
 sPM0VzlqQ/7Hvh8yS/a5EiBhHUikVR4iU13VElBM2duilZH9ZRQ4fHmRc
 QDXm+YrfSOF6WiKlRGATy9aYb9XOL1MH4lqjqVp1jIbnBqabg3pvVMSDY
 G1bV0W2uvZu7e/PqldCZm2S2j0REZK8UpRoAWxeQhn3WHbAx3G+uNO64z
 HfrVSXXJgJYRPBU4uKzI3D3Iu/9OMzTpJenVoszetefLocEg7oK6AfM6a
 RVs3wKEjvql5i20FyXjczA2tEmM4qWPPdeMKjArC0epSeK0vUFoGFeIYX w==;
X-CSE-ConnectionGUID: 2l//vVBITdiKn2u3liNO9A==
X-CSE-MsgGUID: R2IbvZ6ATTuCi6vG4n3qMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89041949"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="89041949"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:12:02 -0700
X-CSE-ConnectionGUID: dZ7lA4XMRa+sKvfyVg4SZw==
X-CSE-MsgGUID: Kpl9zAkUQTKRMnMExecKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="261257074"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:12:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 02:12:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 02:12:01 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 02:11:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwBUTO4tzddzOO372C3/SRgnTQRAGRpBEBgVO/oLOl5LkwUmUIoT31jKU7QvFai+D4Y4ydVhJk7Dbzp/XMkBtjUs+r1QosHryQ/aAGfTc8Kv57NGqsb4NCcAW2OTc2ZMieXK9jP+FvqkQl8pWiXMEqwcIL/+yzILlt/t02uPAGRsmDuloYYsL2sjuLtVrOzmbHBXW7CtWZoVk7TmEEEMXIxDjx2sqpdVN8QiUOCse+CVmcdebCj8t5529F1l+zTOnnGiw8Z0bVo6dqM9ojt8Ps+lPPalWf/i8veWengTOHbMtPANo4r5dImBvz/EFb856Z/TD97niUVEMkj6T+Ql5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGy9rSMmA93syQxeI+C6mzFZFmn8Cqn3DEQQbB0nVJ4=;
 b=qZE1QmfnSaBDD1kcOXkt26M5+fmsTNlMO4DKVsh68BQ0eDSTztfZaVqTl0kWe8uUCJf4REdKamiykbzSN5jDIAuYkxzap3moAhHIpQ4ssXxQR9mctJpazJd414huPXxZAcGMtvNg3uffpLwWlDqtkWkPZ2TEE7G2IfVnIfascfSIUA9dfhWat+rEtmO4Vk13aUc78XGs0VOWNAUjN/IPEdgcSQWWUsOdbkoSZAPGLACld/baVZfAyarIYI8DRB7L3fSRWVTQODfbPg8GcG416clR7JTJ4ZW9fumNHHAF/f9OTZm0SFGX9sL8sYYByj+hdqEMy3z7mxcqDKQTrvjORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 09:11:57 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 09:11:57 +0000
Date: Tue, 21 Jul 2026 10:11:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, fengchengwen <fengchengwen@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>, Wisam Jaddo
 <wisamm@nvidia.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: mempool cache change
Message-ID: <al8317iuWn7_MpJQ@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
 <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
 <00fe4a299adc03ff7d39ef943e62b921@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65979@smartserver.smartshare.dk>
 <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
 <CAOaVG17Ay+b1Hio90Mgq0jrYwFegxOmQ-+2ezXF_cSrk1Zi90g@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65984@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65984@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::31) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ2PR11MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e68657d-ee18-412c-f238-08dee7081d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8TyqmDIr67jfsJPcH6iq77msWlDsLp4tEm1UHEw7Vbw6TkZYeqnXV1tCqTGP6nT5Z22z19mpG40dzlbtHXbnSDiBGs7BA2Byx9xllhCeqfQk7U2F2ULC/5Q1KNj/CNHrTY8s9qL+r9/+yc4GgbhBWODV8L036vYuXJPXcNt0pbeTU1VzUbDYpdJDA1mD1HUuoum/yOalYcAJMshGcx/6hmm+9uvtAZDHFmyNYUcrWMhXCScEozJ49gAfi0tenH3HRlFCrNtr50x8IjSaDeq87P7o6hsgx1AZNyvNILveZpVCmxOvqARKb9Nh33f9tJQxRjWUUOUOaFpbjb0kqsP0DP7tDwBex3SXrJR+AbF6lDQtNdVzVq3g7VjFhefKdLBkx+WoiFdp180sgSQga85OWj62TBW44pnWHpuf0csLBkxpRTeMo3QdBEloPkEh/Qen9RZSVVwX1Dv1FsmoaeBINgitvCkvCHbJR4OSET8sT++3FuDu9Sb+EfYC++RGMaCK7sMGQB1S0qixQCjnhOwmCxdSJJPCJ6PCR24pr/K1GMVuIpMnqsZiwsCw2CWWDz7vudyWpe8z1+kUiqoGSoRRkNFNFzXqOci1xUQopz+Rj6ImvtDeCzeLGKkmmuHW1ku1k6iGW6VGqX11PkAC/k+K35ncADydsRkD6Wa28T0FmZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DH+/idvb8vszK4hu/adqTWvKGVXnpaOyPIrXvOQjzMMfL1ukINwL0oVsNm?=
 =?iso-8859-1?Q?7rNoJv9J46nyRp1/mAxLgz7W7jlEM05UUMDCwjoCKR0138MxWp1HSXc5BN?=
 =?iso-8859-1?Q?DwkGga2G6vc8pIOcl7EeHm5bRNCGscdyOaHshl3IbzF8R/3Ifl0BeagX5y?=
 =?iso-8859-1?Q?vAw+SUhwxiRZSC6DnaecNW15d6sUSudifFrCQjN0NpJvwlUDbnqNAOKkF1?=
 =?iso-8859-1?Q?XQqFEuJsLxgb1FBIn4HWYEgH+o/HQBG0t15VeB2AjYK2kXHGp/pfu/eUBx?=
 =?iso-8859-1?Q?n+k44M4WaCcS1CVTdov4PbSTHDzS3Ci/5xi33pvE91UzCGdX7tv8tgXCky?=
 =?iso-8859-1?Q?CUTsVwYgXiQ3d5VK8JhZq1tO47pJYufS6kfLPQuBd8qxn2mimK34eKCFnh?=
 =?iso-8859-1?Q?QAdPGZAqHzndbuu5aF9V8KcZtnK7+i/L5XGzxrQ4LCDYsmgvv0hXkt0FxY?=
 =?iso-8859-1?Q?O6K9WadMRhOvsPKD5lRRL4eKkxzfz78ACr1YVKZzrqVvkX5sOQpJoeACdA?=
 =?iso-8859-1?Q?vxdsntfSoYDfmNZme57YoV+kNcDJ6+NrFzYSY3XHbihecXkTr9h+oDqrW6?=
 =?iso-8859-1?Q?8WZ9vmCzwWKMjvD/HXz9630RH8U6p4x5bliC0zhYCnprRUel32B4cOJlsg?=
 =?iso-8859-1?Q?1L2FZR2tLazyRrATxPXxYohbMVtU3+aY0DEUSfuhnQPKl2TeRT38QnPgZT?=
 =?iso-8859-1?Q?AOEDJ2nhNpbc/LtpoQYKuzH+KwI0Iot9asZtvxgKKTVlzsAVdgMzmC3u14?=
 =?iso-8859-1?Q?xOyAlgIrqXehXRTyiyq3yPO65bZlI5cg1XZSmdsIt62LrbLwQdt4pRSaib?=
 =?iso-8859-1?Q?3nr44ilOuohQ9T9Z+vmlJdmPytTIJePcX7yzY1UCD88NIidQCDbR6kjoRU?=
 =?iso-8859-1?Q?GDZLtReYIdwr9yYUqeV8WiwDNfVF4fMSe2Mr3It0QxlGCTQaGprptcG/i9?=
 =?iso-8859-1?Q?4Ue9Vh9dmB5DMiUvVxFP7cHtOVG6lx4VTQrr3OVhPm6aHTcDLx4QWObzDE?=
 =?iso-8859-1?Q?6i3Uu3BZIVCooYmuwn8aH047HIcvKdOwNCabvNVT1rNyV7FR7Dv54DZFEg?=
 =?iso-8859-1?Q?dZ6+XNvG4nLRaX7t6G+TbY+Gmuok06kmb8C0c6VbADqsfZzA9W3tYCMMuk?=
 =?iso-8859-1?Q?iqUsqrKIFJtE/do0G5nDJ+3nJmNgJR3anSXJKxhq/8qiyDMq7e50Y0fZd6?=
 =?iso-8859-1?Q?mRpZ6d0j89r7OS3oz05DR4Hvp7mn4HUAOCzYq1UE78rSDYTjXM4cKgVLiz?=
 =?iso-8859-1?Q?xQSRpe5FiT9BAoCShFcN/slD7GtJggsAqLL33Iw5zNiKT0wP7xUjfntj5q?=
 =?iso-8859-1?Q?Hvgtz3Eq3fJm1jqVA2sVkL2ROMPv0qwSdVcTtP6e2lBFJZ661p6zVpl+7V?=
 =?iso-8859-1?Q?QjP5YlHoxM6TohgeJqS1aQ0bzz4ehrkuel/esQZogdp/l/48JFOtlzD/Zu?=
 =?iso-8859-1?Q?zE233B1tk3e/PeP4mBQ7MFkwlKdNjFq2YMpxoGu4uFnEV0sidfy13YfMgW?=
 =?iso-8859-1?Q?PcQBoptw3fZsVZdqxXIoIHMwj7H4JEO+7HRG9htH2KlcCsBPaXiVqGi8Vk?=
 =?iso-8859-1?Q?J3H9thqFIp0bx8jMdEIJqWhqxphxPu1DfqzZTZDFe51l31Cd99gMJbJrGS?=
 =?iso-8859-1?Q?QxD9J8Vs1ZmASIlz/qX5W3W64Rs83SxcEYYS4v+3YnlefFyixyj1dMPvpg?=
 =?iso-8859-1?Q?TBVC2B4RMb/sfYJfbHqt8LZPR6V3440ZtVi2r1qtMuGhvXIiTZtHRReh1s?=
 =?iso-8859-1?Q?2Ii/rvMcKrJNzcKu6zOBnj8v1KOln7g92kHZ3pxwpBfv9vdVpWHwh4W5xg?=
 =?iso-8859-1?Q?WJe+nBGZdGBZ0hLwH0x2NFtxdYX7vhU=3D?=
X-Exchange-RoutingPolicyChecked: c1osFBXxB7EPwjHm4jRKvDBVT17vCn00EqPrM/VOdTdhLd9qiegDqvklNXbXBuNVs4i2Kb52M+5ktQ+44n6TDVgUWttZTq/9ix2emdrUtJh2QX56EnQTP9CX6+yaHuYvXLj6M6xxq/kOn9m4vGlCkWF2O0SqZkRltqgO5it/waxyaBsmqZG/EuJNJnXwh1sELiG47EH8yVynGABRDPj7OJMPTemclKgnx9oMk+gmgKqonDpnDlBlxd8aVoW24hts1tTwbmPzoNhvH1PFTcQsyZLc8YJ0X8bMT9BxgmocegfapLxEsYYG315GvJbtDxDOE58n/Ge3JuUmWjGMLPBZvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e68657d-ee18-412c-f238-08dee7081d52
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:11:57.2771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJbefnQHSP2WZM3Y+FDIq8XUfRnTQRqGxb8ix8bVdmxqErTDjBW3cYvgJmWCsZNCGVOw8ONupYVWskt6VDCmCQwSY+zjgeBeoBXmVmExDcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7670
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

On Tue, Jul 21, 2026 at 11:02:34AM +0200, Morten Brørup wrote:
>    The mempool cache size is configurable.
> 
>    The application developer should configure it to strike a balance
>    between the two performance parameters:
> 
>    - Throughput: Large mempool cache reduces the number of backend
>    transfers.
> 
>    - Latency: Large mempool cache causes latency spikes (CPU cache misses)
>    when transferring objects from/to cold backend memory.
> 
> 
Since 26.11 is an ABI break release, perhaps we can reconsider the option
to have the "keep" value configurable for the mempool caches, i.e. for
random alloc/free's set it to 50% like you have, or 25% as proposed by my
patch, while for pipeline apps it should be set to 0%. Rather than us
constantly arguing^H^H^H discussing what the value should be, we can make
it tunable for the developer?

As an alternative version of that proposal, we can simplify and just have a
couple of predefined simple profiles for 2 or 3 values, one for pipeline
apps, and one or two for run-to-completion, rather than exposing the whole
range of possibilities to the user.

/Bruce
