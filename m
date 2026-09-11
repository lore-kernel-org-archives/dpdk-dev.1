Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F5BC88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:53:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3199E40269;
	Fri, 11 Sep 2026 11:53:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A947040264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120419; x=1820656419;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5O9cyfczYB1GtrOjA37d4deGle2/OIBMD1/uiu8O0gE=;
 b=IOwkEfpD0NeWU6bPK5BI4YkMRABHL5ag4Skha0MqM3QcbD4I9nfoq96J
 Pr9dIghL22PgjvbrUKbtPtXvkeyRONYqBRPW04Z5n8pJqH4LZw5/7lXfc
 VRLZAZv88IxBDFxw7+U9Z9eLztUp9nw5ADErh+/OQcOpyIeW3HR29pOi+
 sOkr5ZnyZhoT28IF1UANQo6aMAXb3vw/ogi66la4/x/mKYED50MvuEmwO
 +4lI735hKOIeMdKB7ILTP1t5mUSWoQEwW5pySCSQmGcuLbeJjF5Mykvdb
 7QGR5IDkZL3cebHHofXb1wSUmep3s+dPshfCuop6C97ymh3N7Le50kHmw A==;
X-CSE-ConnectionGUID: kl5soqZjTi2Ae1zhCzZ+OA==
X-CSE-MsgGUID: X83SU1wlSIyfHhfY9EVSkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100933966"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="100933966"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:53:39 -0700
X-CSE-ConnectionGUID: eKZGTc2GRCO8tHT+IHD4tw==
X-CSE-MsgGUID: A3NOzFfsSDWtZvH/976mYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="296862177"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:53:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:53:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:53:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8sIxB+Zdh9oQ9yND0TfhNuh5LqFQdYP4hKOM1+2vG+D+s25Bd1dzrV/eltE8gSdpi2lEB1kF/Hns9U2zwTLxW4JUPB+l8BRAWDdN4XBKOw5GJ1gFQH45uZyBBA88qK+FJU2M4p6xIFRswQOWGSgbWebBHhy+CC7BAq1ao+ViM8GlEUWWDEwQ1VI0qLxxAoisglQy3aS0Sxa6EdOzXYJo8R+ZFAAMWsT55WAublEqtZwe06hJzYR4AT2eIjBSu53BpnH+g2guKBEAiSPXPG2GqiRq0K/edoXQpNe1awDQapFs2JMHo53DxpoURrpiqcPpWeEogUbKyfjm+7SBBTgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7W0UnDGEK/3i6gRdfwndb7ZePlQ8Ri3EkUQBQGQtZA=;
 b=hkQZ5PmZPZe/2UaPCKFoM71nwh23k2uXUodipF86gKr/yCG0bfsv3hD14c0jqr6NBLARiYonAwPu/VPXPYm3KmncgroUjeF4Y5blnbfncoMYvNd+zV4Qyu7w9/xlzOHU3pjwDES1hYSlPIh9GfuRBSgjfxaEoewQE8hELR9vi0l/AmnX/zebVPJNPG1lGB86i1dl1kGtTQaZuSkqmmcIcSiAEzV4X4jsDcaBv4iIkqaIFzGe8Hj9n5yJu5yob0Q3BJ450L0RqgabYjfhuEx6D1duulf8f2Ys4kQB8+KIf0ybpI1E94SBj5hBUGl6QwYfOuglgmXXhIx2bbqInDi0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:53:36 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:53:36 +0000
Date: Fri, 11 Sep 2026 10:53:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Nicolas Chautru <nicolas.chautru@intel.com>
Subject: Re: [PATCH v2 55/68] test-bbdev: remove unnecessary include
 rte_memcpy.h
Message-ID: <aqPPm343AF8l_SXk@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-56-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-56-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c0657d-ef40-4e9f-4d29-08df0fea8c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: H1/2HjLM7EAUGmCEJUh4mt+pMjbBghaayHsKbKlEqzsjPeGcFv68rxvaSYx2tbl8MnUGeBqUFqK2tMsm42yXFYcBkXNcF5kA2VJDqVYwtAdYDK3DyjxcZDDPtILzI8mPJuSWIh6f01TPvDtONLpRAspYanHLn3KghuJ+wM6YhnCmeES6KjaPSXBb6c/lqn5Ugx3yDlv3u4wUWJfQZ0Zxsvgug/Urk9LkcIwzDcwdRUc8sbdVySwQOxjFMfRG+yio3Q9ttZAuY+1y8y/lIPI8KfDQnBPFqwGlB7JvcKXYK5d9h4hgxfT6ekfkr86AsQo3bC2VRaHJzHm0WmdXhH1MDkrnjE2vdrwfab2AapSfWDluPbAITVhiBpOzsu/XqqdkPYztUVRpONiipWT3m3HQ95tyViS64NVM2o+s7N0jsXPWLTU+bTyC4jghbXYizOibLN8Dmkq6XPv9cM7EsqaXjgViU8Xs/KeVeE27EXwxqq8dFcWNT1dahyNct0RQcQmfMnlTF847QSy7ad4JebPUSMVD7ynfvVt+UhxV0aHT4MCLzc9EtvAtcIzGFZYw9H3fPPLrNgMetWVUHZ2MRgKtlqUmSFmG3r5RJ3IAI71f/9ODj0ROLOG3AT9piAqUHJosduht9UykuGjzE86l6tqw/9s9cXRKichUT5641Coj8M0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fovEMYURU+cRs5vriNjUEOcIwH2qYkrNxunsApsjn5+JisY81w24zQeomk94?=
 =?us-ascii?Q?0HoZSaFJRJY0cv6lJAiOdQbKJNAaVcWXM889BlcgL4GC4YvbTE9tOIQiwb8u?=
 =?us-ascii?Q?4iVJMugN+W/pwxtr3wQLUm7vgF/UoGd4FtiYLiM4iIyAWBUCAxw8DohEOjlk?=
 =?us-ascii?Q?Qa3C7LmQR7SS4vE1wlk90QRaxoAst6poXHqEtEF0jNKDRudQ2n35i9fAANUU?=
 =?us-ascii?Q?c3d1FQMZR6oeUH0uHfhW575AMqRMeZMBdJdDrT+Va6paelE8zLMuH5dDPNRI?=
 =?us-ascii?Q?Ud6GlNiQ3OlFM7ngE+cUaCGW8ePfSINrSLixrolkBvTAEKia0CSd0idDDdHO?=
 =?us-ascii?Q?Yoe7Qsp8cpxq+AsKrR/FRIUK/wZhlKjFWOipy4KXvI3mkilaOccQifQABn3e?=
 =?us-ascii?Q?pvFPkqUyIMwdh/7pQ+eWrPubOrLzi1EWW7OLtDmmni5aWIVMmdvD5JFtiZ9t?=
 =?us-ascii?Q?LMr8ozq03R1+g6h2+K5BEE9HGjQrJxIs5vVvlbcliFQZgc0nFQHOmKMzrFAM?=
 =?us-ascii?Q?bTXFnGIhusRy1UozhfWsLt7+llFVuS0gb0xPnTX5j2/AJdSy7Xdyt0kjW5JQ?=
 =?us-ascii?Q?y0TSiU49qRVL289svVjl+Lz0FHKVur2ZmhEWog5nw+Mc1CSkz3MAlxb6WvkX?=
 =?us-ascii?Q?xawIggaXRh92fxE+MRbzOuCKUjQatcusKxb3Eppbkab80Azfeh7ggi/ML67Y?=
 =?us-ascii?Q?nVN0pWwJc2RjGqgsknZSFPrl3ZrPXgad0OTXu2hL9w8i7sxEfMrUbk9q8w68?=
 =?us-ascii?Q?VJ+YJgIuYG8G/7BUGXpdBNJO5N4csshGsCeN2F3UHHrepSoZGaLR6OZmuI3Q?=
 =?us-ascii?Q?nHPGcn4+GUo1+4dgg08NJXfmn3Dbe3NRJwIUnGOm3o/3ETEsIEjdvsG/BFrp?=
 =?us-ascii?Q?2EfDEAEbKnug04lF8jJBvGPRADxKVtrIwwQJwRRL1Ba+sym45YWXUzuwXE1B?=
 =?us-ascii?Q?X0HT7thGpnEG1sC97Jbq4dGuSlqYsTVnKltu7cmQZG7xU/Ntfq+QvPAAhj/u?=
 =?us-ascii?Q?tx9CpPl6/T1hG9FcEy4vj6EhZrdbj6SY3AIkYbhC+VVtfUasUU3aqrDf7fqC?=
 =?us-ascii?Q?3onHY32Y6JWrOxihAhhTDIRSgL/YIrGyj2srHMMi/448mOEnSjcIhBpQgCD8?=
 =?us-ascii?Q?7aneuioiqlYlX/5t64e/vwLflIRGBhGZcxWVWNAobSy7UDinsudsa85K1XCo?=
 =?us-ascii?Q?BR/61BjRDgCvSVUrAdtTuJj57P1KyHM5CZeWSgMSwZCl2XpiRpvJ+SH1ag77?=
 =?us-ascii?Q?wh2J+B3lekONPz8RdV1wjJ4KGkvC5P0AqT4W12J/Xk1qwbDysX0XFliNLvD5?=
 =?us-ascii?Q?Uto30tbxiD84qbxvV5rnpY1ahNMBFNMMF8zWiuSKV/0CdmAIfMzNUl1lhGVq?=
 =?us-ascii?Q?9M/cZKT0aXJNYfwCm2z2F0MsEuntsisL3dbFJ6QGTPr2EgKbS0V88E34KuD5?=
 =?us-ascii?Q?g2ZmmDa0pDkMS6ClJHy0oI27tAoxP8fgtQ+A1UFrz//T+WwOeAeqQHUR7s/r?=
 =?us-ascii?Q?LfPBccNmtgkr3bP7YGR+XKw2UnVk6hs7gLpzaFHJ8RKr6AnKSKKwyhSU7jeS?=
 =?us-ascii?Q?bQPzoCicWv33b6AWGlUB3WzMIvuNe4DAxmJyMr3s0IwR3lQv0aD5Eomo0tJT?=
 =?us-ascii?Q?RnUnh+2bFJwJK88TEabQbUkFztPCG3rlg8cAfITu6vebx8rfw7B7R2wDKVYs?=
 =?us-ascii?Q?KCJYB7EGs8rObk8MLK/W1tVHQ6UxbO8Q6MAOUhIo77pK3dOOM/QxYWhDEnVX?=
 =?us-ascii?Q?1Dft50eFZLIFzDGrltxojnQDHorkypI=3D?=
X-Exchange-RoutingPolicyChecked: 3DAQDGym1Pv8S5inQsNTTEb3fcgW1CeCKw9bK3TQ3ffr3ATicv6Axfbp303uwDIRpFz3/tCHMhcV9saNovfJc2pc8/f/RZVTuOVpBnfaNhD3b3cuZSVsU5tmUIu80nIgAfGL8Ip7J2u50AlcNrk4+h+vVvcPDHYuhEfVKtwRDpiIWFX4TZiF8wHrZsKM8kzZVTNYuROyf91K+bCpSnTsMYQS07sAlEEczxhGrK8PIqe1Al+0BW6aXHgzykPboYvAh07V9JchQTGv08uFZ9lobTJbJwfgg5UzAAhkl7LC7Ny4dzcZmoHk82EFdkOeBsJsyZ/XW8++Vuz3NJ1LrxFSXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c0657d-ef40-4e9f-4d29-08df0fea8c57
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:53:36.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JMIY14gS2s2rB9iDfDQN28J0RBH8Es8c3goO5XRbgk/0n0BQJIf/cVE2nfdt5UivqF+V/+T/I4+lgMu0iX0LFFgjTGDHC3OavudNfqJV4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
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

On Fri, Aug 21, 2026 at 12:24:50PM -0700, Stephen Hemminger wrote:
> rte_memcpy not used here.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test-bbdev/test_bbdev.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
