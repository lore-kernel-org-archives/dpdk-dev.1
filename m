Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57975C982DC
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B1E843289;
	Fri, 18 Sep 2026 13:50:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 170A24027C
 for <dev@dpdk.org>; Fri, 18 Sep 2026 13:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789732239; x=1821268239;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=7NnUJTIlppYyLGW1Zp6sjzZv6FZtGkuzvGBr2aHilVQ=;
 b=f7wX+qeE2YGxzLUL4XYOqiAhJs53HrAtxZgow1jcxXcQ1jTILfA195RO
 Tv7LKA4HJMdy/p3JhNs6N1SdXKYbKJKLepA5geoqmbgknuA8ZAv+6HaRz
 Nr+MfqbGHP5IBXTsDY/xmxpQGkCUrrTlQLNw/SLhAX0trsE2nm/yWUewY
 vI5KuwzC7Z2ws9NvHomT4kSGm5EbZBacsvqSbb6K0K5fI/fJQWVr2KhpB
 2r4OFPzejvEcaIqB1NjEQ3aKWa3QEfii8mzlegNTseeqVmbGh6M7E0nVY
 zAFJDie4vEb1XKZlGEPSPSddZ0ykyJGYJqdzwDL0Nt4OdNm2gJhPGL+Cq Q==;
X-CSE-ConnectionGUID: M/gid0kUSNym4sP0Nv7Eiw==
X-CSE-MsgGUID: kPD1dY2bQEue3DIwP1ZX0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="90249053"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="90249053"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:50:37 -0700
X-CSE-ConnectionGUID: wiQpFGiNR7Kv/17/2KyBvw==
X-CSE-MsgGUID: cRMOaB7LS3OLIH4gZcG/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="268106618"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:50:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:50:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 04:50:37 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiR/SkeuEwnmjG8KJe2xTol4OkTsoDk9izObN3bEa6oeqI/w9IlX3OKPj7uy6Nghtq0djzGuQjplgk9biyI5x6JR96J0hPNKmCfSvdLHfG18gGQV/2Ttz4EfSilIJNfxj20gBlkoisvx/LX1nLZ0qjNH2N3mwQaIDab+qCK9cnjXpPEhcbWg7YxRjJu+QW14OYZJuB8hUUU2f2WAXT3UufrzJHScFOnHbXzuckCK30Z69866DyRCwzBfiaJS2HQL/GfLrtn4h48heaggyvoDrOQ3AHmFigX0CEwcWx9RXA0Ccyfng/2SrSqE51K61kOPPzuO+hjJmVC58UWQIsAocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10LfB/zXqydmxnei0zmAfiintIUC0Zb3fe3OpQOgIp0=;
 b=EJEPLPXgdpiua2wfsFMuDQ58FCkNrh2ffYby6T24TitIBtx/oCmMKkqJvK/KmWRX1BnNAgGYYTxOcr6BKEK+X+V22XDD0Fk6LeEI71vzfGwo0DahxSomgfJBQvuhh8ho+jCsIDusks0U+b8sao+W4VMOjzl5CDmeAivD4OxmYvI2EVafK8Or9ipzG2bRpqsiUNnteEnsiQ4EBmGWP6NIdDqDGKm/D6qfZ1BWFsc2YzJCEZsWI2w0hDIR2MBLMFP1NO6Ooqq4Qmd2dkP70sX3mEMH9kblNryFwRe8LyKoMwyFTBsUOHUNb1AeZVAyZUe2zZQdNYKGIUrMnhnx1MtJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 11:50:13 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 11:50:13 +0000
Date: Fri, 18 Sep 2026 12:50:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <qm2k21@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/6] provide a complete set of BSD list macros
Message-ID: <aq0lcOoTJk-eVWFR@bricha3-mobl1.ger.corp.intel.com>
References: <20260917172116.660120-1-stephen@networkplumber.org>
 <4aae7483-8b7c-4baf-bed7-f932fc0cce0b@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aae7483-8b7c-4baf-bed7-f932fc0cce0b@gmail.com>
X-ClientProxiedBy: DUZPR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 563e6cf5-66af-4c8a-096c-08df157aff74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GuRJS2W9n49QmR4DiUtwB0vhzMi7wXyu8+VbTvhh++VvTDJHazOpTH8XDqTfQEEpfRgWXBKh9XzB7seuWB7PlCSgKPIbAUUc4vxpshtazW3LXWQ9RtP9+m8qRSoWnectwImC3ESJ4WuYkL8zKzZ4HlHcF+uqhR8Txn+pkFQi26WuozkjD2j2fj88iR0u8TV0MD5a/ltHFCSBeZZaNqV+OzKdHkEL8gfMxPN6ksmhY1qLVC/tIh2nRRvYo96yrLgLK4WfzKefAkyogTKJNa6/f7vhtXDkHRSl9tTN7DWxM3+pAT7jzEB/DwmSk2rkhhQHBReCZJQTGZtpWtajaRAPKRmiIIOyrhbhJNazuE2jBLs8wGj/TyeGiHub8h1VA+PKQMA+gFPF1P+crVmx+7+zKtHc5Y6BeP6sKQoJUMO9KTUrCdjsso410+eGcQ8lZ7QhwvPh5W8+z/vzOBDggB+gTr3x2qvZjDDIaPSnDvvIx6Z5vrf2jV9NoeRiC58Cecu65/wZwLY0PBGBhFi34UhQzjUHYkR6SBzZ2kQpHTLwkmLEKyQYWpm04efIwyxA8Hh7lyR2A1SWfi1uWM/QTfIAOEaa5M5/4J+QiwEmrt7/jA8OKbKGa8W2qoIB9KhTlQDQFZUiYsWyTVh5/AOd2/tPs9HSH6pDza/5ueE5rg/95HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Q3FmId7rmI+XjMIfg0Gyb4dFBDmu8aA8zXqIY4f2fve8IyggH0Z5M3g9UC?=
 =?iso-8859-1?Q?GmSC10Nok5YOwLpECxbGw8KRsHmrOS6VEb9z6crM1K0i09LFEaKLJ6N+Y3?=
 =?iso-8859-1?Q?w2gMk0gM9iyNCBVQoEBAlGhCjKnSUBXn5HqjgxjxbqUM+GxauwPwy3zovN?=
 =?iso-8859-1?Q?kebOygo3WqNd1qOpYo8RflSd3bbje3YMlKcVlUHxYWIQVQTuw3B9e8UUYR?=
 =?iso-8859-1?Q?UuDaLX+k11cTpIMh0gU4ZUjPbc7o6yijKY8hSLMHJRPm9uscx+WUPf8pgX?=
 =?iso-8859-1?Q?sfTC87CY5r6/QVYdXAocsuJpb4vNd8FLhG4E6eDRqgqNPk5Z5RUUoG2DiZ?=
 =?iso-8859-1?Q?bw8vHh1tiqZW9FWLJq7pzacG+hl6dFGeFP1nrkArNS7pLTSYGoW7U63LSR?=
 =?iso-8859-1?Q?PxgPKPdrHNKjIOJG7d7Rnm/PpkYQviQo4abNjjHDoU+atyiVvcJFbEKSzx?=
 =?iso-8859-1?Q?ZB6cEhigVMh27EIExSfDy5KkmtD5rFfaCVIfOYSOjA15IbEdb+J3FpxWT9?=
 =?iso-8859-1?Q?/F1jTN03DlFz6R+OlguVoCi9P9/RHRbWoH+ng15TFqi7AOP+cynd5bFa0C?=
 =?iso-8859-1?Q?c40FKEnvtBi4pvv8r25Tr7SxYYayEo8nRi1j7OvekBQVdNMLdcfMsyCk2I?=
 =?iso-8859-1?Q?kjQoC4vjS6tAiIBa75IloK2mRoRTwgb4dAVxVWsba0XP3w4tiUWmBTzG2W?=
 =?iso-8859-1?Q?cXJtFbyoToqe4/Arg0XmSZCFIbrZcBvEpLihk9I53Wf3ufnq6dQ8mxmd82?=
 =?iso-8859-1?Q?SApk5AtumUKrND+MAQf9TNDimRUB2R09ycVJhWfNJibuJi9e6qWAYGRzlN?=
 =?iso-8859-1?Q?NIv/9R8GXoKTyq2Q9kOvP3Zad0A2GktSvxzyAzBCQyNfK6Z97z4HIAKM4Y?=
 =?iso-8859-1?Q?8/Z9W1xqiCi7jiuJ9O8YssJqidUvSi+lMuKPmAtts9r4rkgKeWA4Y05ZIf?=
 =?iso-8859-1?Q?HNezKsVrafHoo8EMWjq3dTEi4Qth2tQoOyX76BwspY1tg+hzrkHVpoFtQd?=
 =?iso-8859-1?Q?YnTZEM5CUc8D2lkcEWDvMBvs+igyJwC/jKcyWnqvmzGevdNo3tmA89jmv2?=
 =?iso-8859-1?Q?ZviM2EoT5FTpLfE5oV0t+yPxZhSHgMk9k/9eXW7lG9FrTpjUtvy9wIZYwX?=
 =?iso-8859-1?Q?7pWyusvoKyLeS6irwi7l9bOOcIlnibugyvZFZ/fbwLCIAjcAnshzOnSKHj?=
 =?iso-8859-1?Q?L/VmJAYp5xWXacuB5QggVewTFhmer0r/xNxxOAfpRQfIi1kV6s/tFxKbnC?=
 =?iso-8859-1?Q?at67gmFeL0IC/KqbkkAIX0DGGZmIvoIppUG27We9uEpZ0Pi22MoiIfSW7t?=
 =?iso-8859-1?Q?TC+2iKNrnjsMRC1PW5gn1Hv3IoJtdMy49Da2Fp95NkY6WKAcMfc1rgGdrF?=
 =?iso-8859-1?Q?AuZ7DOi/vp8iOpwKEq+VYTjD1Flb+CBVjd7C88/IZS9J/5RWvir499LKUv?=
 =?iso-8859-1?Q?BxGrZIB+PiK5UobZ6hClFbvqsYkdTSm1z8DlmzuxMFhVTJJRXnTG37SgXu?=
 =?iso-8859-1?Q?npanZ6G+VTGR4XNJczPF83k1oLUPnYx2ZFCYYx8+FZ+ZxwaR0GwXJg9eDq?=
 =?iso-8859-1?Q?6jSy0CzP69jplVHxHBC6wSSAFj+HnO/dcq6df59Mhtr+CKA5TYnWX/AkE3?=
 =?iso-8859-1?Q?8jb/+Hr6doG9mf+8bnw/PfWRu1KcIeUy1qc/Rz5Q/tOo20ohJmn/prUzTi?=
 =?iso-8859-1?Q?nbiWoFkDMiD1PdOvfCnSAWCqDwBBMh0GUz+vtq7rhSY5Dii6oDVzOd5ZCF?=
 =?iso-8859-1?Q?LBIqnp+sMlVh0zZzn/Nd88R36cp/lnWGrY2jwCCG6JGA5xV2YU3fUofNiS?=
 =?iso-8859-1?Q?lDzS9R9u4V5Pd7OOhpFVidmFYdk4sPs=3D?=
X-Exchange-RoutingPolicyChecked: GXj5Xx29br8TcBUNXlMZzAWUjpDuiFVF64407otSMTC39uX0edDM1xwRRCkbW5z+6qprdAgADU/prdtH8UI8e9dnDc6Eqekk2hA5jSDod+y9spW655urkqASiN930UHwJSRaUM8VxrzLejbLYNIE3uxhd/g/NZqzsuwX9+rV0i/EhJB0tV1ipqjp4wZYJxlJoiHMd18RHYYDOXqB+4oVPLzFhn7FntVW7SXUrm4wDoN7JjwJd1ulvD/drbHF2hYOXT5LiWP9jc2A3bGw0n5HNqN2a/T43zw2iX2L0i/KwjANwu0GJ3kseRXCq9sXI7ba7co8ralvGY4jU4UJJ/Xheg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 563e6cf5-66af-4c8a-096c-08df157aff74
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:50:12.8256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrPGQcuWkzjeYOgjVdYHGkAZPiX7p2daqqReAyJJPactxyTsHOAAxVH0CVLne0/MkqN+DF6kLL7YIAOlfYPkQ/sgZ3OioQAGllGr9+mKqhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
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

On Fri, Sep 18, 2026 at 12:34:47PM +0100, Marat Khalili wrote:
> The patch set generally looks good to me, and ensures that DPDK itself
> builds. However, there might be a problem with building external
> applications IIUC: if DPDK header using any of the macros missing in system
> <sys/queue.h> is included after <sys/queue.h> the build will fail for
> reasons not immediately clear to the user.
> 
> I think this specific case can be improved in one of the following ways:
> 
> 1. Remove the _SYS_QUEUE_H_ guard and undef or guard each macro
> independently (the file should still define _SYS_QUEUE_H_ to prevent the
> converse failure).
> 
> 2. Detect the situation described above and provide more helpful diagnostic
> suggesting a workaround (remove <sys/queue.h> or move it after DPDK
> headers).
> 
> I myself prefer #1, since swapping or removing includes might be difficult
> in big projects.
> 
+1 to option #1. However, it probably doesn't need to be implemented for
everything - just the extra macros not in normal linux queue.h
