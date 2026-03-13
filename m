Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F9107BCC6
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 16:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B55402BB;
	Fri, 13 Mar 2026 17:16:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CEBFC40279
 for <dev@dpdk.org>; Fri, 13 Mar 2026 17:16:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773418591; x=1804954591;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fK7h6/tbZU1FxL1U8ifwd5TSWDmkZqflH/NYE5hZABw=;
 b=fgwAUaEn8fNK0drH05MtKMwSpjtVoJvPSR/Y6/DRtbJZVWSjUdlelgQD
 Ndr5jHUFdhpSge/kbLBp8Ng6yrUZHRH66bYZfytrrQN3uS4cHYCkUpaFj
 Z6srNy+LvjMo8gvnw/ScvIDbXDJRPgTnwDjfFNpCACnLPWYecmMKhrzdo
 FYCeXbb28NjZkG5l3s/jJZgcw097GsEZIgckQKOj0KosvoVJLWMAh74hT
 JG987VFqggDdnFi99h8OQFnKliocMuFcBuA3l7gY7rCjdjIQk8txuVA6w
 HbdGr4ZkmhxC9sAuajg7BVbVRluUQtnWK5PslaFiqrl/GZAma/YQMOMWt Q==;
X-CSE-ConnectionGUID: J/t4fBGgS0G7Cg7jyd/Ffw==
X-CSE-MsgGUID: XM5G6QjSQiC80PtxsdAkYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74717202"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="74717202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 09:16:29 -0700
X-CSE-ConnectionGUID: 2D1ygijgTuWgSH2JaWyhWQ==
X-CSE-MsgGUID: cBLYh1O3Q6ezhx5+bDs48w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="221279608"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 09:16:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 09:16:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 09:16:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 09:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgBR/btgiQssUBEHDK+uSoWr6EMqyjROrFsKqH0yX+77qoh3cfq3Cig30LtSwrOAHVcQirYMLAQTo7mKG3WsYyZkOjv4PBNfjZV48BF2eMGYlmg8qXuoIzF1qMLAUKFP0L334DWsC2BVMcXquRBJcrJlZLpXZzEzaRAW+N4ihZC/bY39hElN20uGcH8Yo3GCmHrX8/hgq/lioNXQTbRUYp9AOTGcW4G5hUW91ZBS68tI7mNCFI8vegJWkC586pNK8ST07PRpBlVCAz73sLXIvnETvQTM6Fqi2NjtLBNNHzn/4+WBJZea1Hdd/NixoaAX4gOSfH/oQ6xdmos5VfYK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/fqPF5smFsVhjw6dLUF8mAOx9URVvYuZFVWqGE6D3I=;
 b=GIq6V3rto/ew45dX7K6PA0WAx0XikOzAxlYeBQzlJP73Lco0ig0MhiRNtHE+oiUQ1m32BWwwI9eHcQjQwCK5PczfEHojkjyt52k8tHfJ4giXp8aszY8BBXsAHGrM9Ob05nb8tgbslNPZGyRpVyJlnE4kQO55GHZdWH3hI4h9BPnVO6QTQgP5ej5TcH73lA538MvpsUqMxzXd6fod5P/d8lgGtsBjHCTr8FdyebU0lWMyVelfQ5TJcPy6zKNanRdqkl8dNYwon5KUQ0LVK3Lo0z9zCBu3n3rIwT9H5a9xapLYIWnM/YsIAhCtmSrgWLPZWM9CvpoWNeSM0qMJXo8f6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8521.namprd11.prod.outlook.com (2603:10b6:806:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 16:16:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 16:16:24 +0000
Date: Fri, 13 Mar 2026 16:16:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/6] eal: reject non-numeric input in str to size
Message-ID: <abQ4UyIQ_jeKUjv5@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
 <9a66399f084c1e1b4deb0ed61210c7918c9ac2a9.1773417833.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a66399f084c1e1b4deb0ed61210c7918c9ac2a9.1773417833.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0324.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 998b35b9-bd5e-4030-4b3d-08de811bdf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: xkMAtWgWSzGvpEjmgMOUSZTQBB1oHneSZwfHoJTdQzBjPdDrni0JSwvG5AEXnhh+XypYg81KEWDiL8TT5yWzIRZSsz9EoqaJdMI1+khA0XwPxVYYtofz8a8q6Y2CYb4NOhrmTSGCGTR+nU2ckFBozw5Y/SkyQLD/0EcPVkv971CHqUQT+KRBOHTffGeYts+Xs5Ffavc3+UuG5tI6Lu3es8zzG+0bFmtsgppwEgiyreEdHp4HYWk7sOVm7zKSAoy3knrWZDs88k6kkd/R86SBBnXMBw7lImNcmOJhhGpaabH3H7QKVs1/6ewaw1V7KJ/Qy0oPesokeWLoq7sS2LW5FvwV0oFQuxNuVlF2VDo6P7ZXpSqkdcmXMV/ZFMqghzY46muvdVNneRPvcm71xTdNDYVG7cf09eJ75HFvcBG9LRgQL4abXT7k10AvVIuIU4Hh+QkwrdAS5xUbxlhG2pPGVLZSTQpBEDkA/u1C+aeT3UrN0ku4yJgkH37QhAuqRHAB747ktWj30//gfcdy0QqdHVH2wRqKq37IgDcWNbR400w4epSmihclVcCXD9ukp4f1aCfI4kUT4NYoJAX/+F6qaumlqVJ+XTrhhWhd2SXrkwU+k1J0laWJh94DU7CcPRi3hbVEeW4vPDb4C2ln50UIzW50yzIv21YALxSogcd3h7qQjekc8L22vpvOkVwGWoX3wlnoaYdRTiZNSDV5TUOKolSzdGGIpvEvkBMNY51p8Nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CaE2iXhYE1SkXhZQDoqk4ko15XC1PymRw4HFxbaX/Ko9JnnFcKJF6JKMAIO8?=
 =?us-ascii?Q?1/8stIts8k3O2Vu/ClKHyRLazZwpgJI/KjQUciTnA88oGyomb5+6HWMf2a02?=
 =?us-ascii?Q?EIo3upgS4wrh4Iz6tM3wBsAb8GHnJ8IHEFqX28WRacBzqodWPZVmtZO/S0S6?=
 =?us-ascii?Q?TNVlsuCoZ6G3smoNAGdlJ+ED0P9cfG+WilHWnY8rDfV8IqwJJilppcsEstiA?=
 =?us-ascii?Q?mVCt5rodSS5PLN+hiVEALLzuDctVvJEvk+v5msS0TIi8AMmvkuWIJuKSS1in?=
 =?us-ascii?Q?/mwiinINfvcNMn/nTw1IMJU0GTnywPeV/bNPPrSEOB8LE08c1yMgLgkNIG8a?=
 =?us-ascii?Q?zlbPRhArubxfWO5BgkqXkXfuFREHAvl+QWly1SD4HGEgOX1/ibXm0FdQhmMA?=
 =?us-ascii?Q?D/SnLXp9jpisCzm1cX9xJLb8M28bvWVOzBrKMxD5oUNqmK/CJzI4KlCUKjNm?=
 =?us-ascii?Q?97bWU3ql0I41IXGrJHO6pLQgxUXD8L5Grq9pHXYVwpb/FItpj7t8NBHfpw2n?=
 =?us-ascii?Q?lCu/yEx3M0rvFbPo9y+ss1OE+YiaKu+/b+n0m+A4awtDg7MWPmxrk3+2//yT?=
 =?us-ascii?Q?oxsn8qJ1ff+qwm5/X98hXF496ipG82MLSRwKSclanKXZvhGIjHCj/OpL3N5l?=
 =?us-ascii?Q?j42apnKVFPL/0PwZly1DlwvhRUQIJ7T+UuwBVDf+sO8DG45rCrPYcGMttv80?=
 =?us-ascii?Q?5fiVskMta6pCeMukPfW4TbBu3lJ37vm0QITxU91FK5nZQ4kX5wrOTr6dJ3tD?=
 =?us-ascii?Q?ukB91gxS/yQhF0LLuLYrw5GeU1IKRou4a65XmWe2t8oRwqs+QddFk6HUfjWL?=
 =?us-ascii?Q?01f3j7CbkMOQgs/HC89M+PKWtv4gs287LR12QGlxYrhpB2Pbkr70SK7bLQQS?=
 =?us-ascii?Q?iAbaMGE6FLfaqgg3b9WvzIYwH2DlOKTMhhwyJYINkdxn3ayQUrAqDxOMcUUR?=
 =?us-ascii?Q?uWCqkijEK1m4NKlid4+dtDV4Dx2mYfFK0iuSQVmaomMn1/bNLhmz7NTvXGhh?=
 =?us-ascii?Q?1sJk+ed/dDJqlTRJK283HCP62f6eXuV0+e2F1aMlDiy3NLvcIONwIieo4gpZ?=
 =?us-ascii?Q?UGfgVn5OV8mJ1wvp2UAHIvME1xsJ8CHspbg7PvmckiE0Fuul0pV3/5xU31Vi?=
 =?us-ascii?Q?l0KhRTTxinPXI5u3DgM1oPuSV1m/3rQlkEH1Dx12fHvqdE/bjjXsjjVrw0MY?=
 =?us-ascii?Q?E2kIs3wso0ExvYT/kKmsKxFZ//WcGjK7eCkHKjxqMhTgJTjEa5ru3M+VLArZ?=
 =?us-ascii?Q?Rgd2l4AekuFW0UZfLlomeL9QN1d9oT1kSLiHA/8xnWJOCq8c6n2Sb5+rCVR0?=
 =?us-ascii?Q?Br+x6Jlmkx9mbwnRvtHLy3ieQPwCyZOK9MB5goQ/Db05Tv8Wmepw4JwZZZFA?=
 =?us-ascii?Q?lf/biWmTTouylZiF5h/AhB/el5yv6nrfdiUUHkasnoCeIfkM8b4esA0uY0b7?=
 =?us-ascii?Q?Ib/MjUmslSF/LVeUcnrfX0qAGTBhCxm0JbtmExlxhZyuMFE1rT3++hf9foy4?=
 =?us-ascii?Q?5D46zLrdcUFZLXCLbYTBSf4YumCqW4ZyO0yc+sGTmVr+kVNhg/U9Ps5xqecT?=
 =?us-ascii?Q?qp2yyk4SfDJs0EfX/4/Nb2uMQMCLA6mDmIdS0vf7CDtlxubs6tj1w1dhadTq?=
 =?us-ascii?Q?k6+bzGLPyVGTI7BsqtbhEASHMKnTjKMxq85sS47oFoQnEk1R47u2Lgn6RU2l?=
 =?us-ascii?Q?fLk/AoTdRJS8umLhrMjLaj8IIdp8+OlzVfy3JECwgyHsPPxjVht5a3wSvKoy?=
 =?us-ascii?Q?BLz+IN9CS55OujSZZ8i2JGFRaHaXw5s=3D?=
X-Exchange-RoutingPolicyChecked: b6J9KpYdpibhVbyfgsH1seGxRzS0HCS/Wk1rjbzawoeaLbekDv1iLTOPk9jt63vzigz5Kc8CKnJVoH/W+Vf5DpPqMgEZR4VgBD8vdh7aCQ6j1kA97Fe7H+3kY/MVdk5hVGRXssjEufo/ZKPIzcV4WxHemjyASOjZ80sgXzNh6gY6X9KniyHL/Hx1mcZ9GxpBzyjrkSmisbu02mUhPYEuOdI1EbeSQvGpxuuLz40hOFUaJ50joUsYUafKOCF24oBqE4E9ooL2f9kwaKard0FdXzw9DiGfzgWjHB9ehoFCqCly6HnreFHFnT2CJCgHG/IQG1XsD1lljlmVtkXfC+2RIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 998b35b9-bd5e-4030-4b3d-08de811bdf5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:16:24.6530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7trW5ieUHaW6/5iaN+cNfO2GZ2lJ9TGdDsBUwENY3rbLdJFA31crOZlO6krRgv5dEye/Vr6nTcFJ7mLARLwPTgGzSjgf8FNouw37zcKON30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8521
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

On Fri, Mar 13, 2026 at 04:06:32PM +0000, Anatoly Burakov wrote:
> Add a check in rte_str_to_size validating that strtoull() consumed at least
> one character. If not, set errno to EINVAL and return 0.
> 
> Also move rte_str_to_size unit coverage from malloc tests to
> string_autotest, where string utility tests belong, and add a new test to
> test for handling invalid numerical input.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
