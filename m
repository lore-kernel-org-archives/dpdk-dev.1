Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15F7CA0FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 394A6402E7;
	Fri,  5 Sep 2025 17:16:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id BE197402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757085388; x=1788621388;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=khmz3L2igkeGHiOIqXEyuXtOvqSKh+r1Aas+p6p0qtE=;
 b=gRpOFoOVAOlcrFDYHrIzoqlO0Z+zs9m3tZJuQDcxco0rT5urlBDQc18p
 1STXyiVH8tKNKomkSi+ZULLgnbvzLcwyGcL/9cEd8IZQeC/WaJn0seyXe
 bi7Vu0xbhCLukArjAbOLM/jtQ+466GB8Lh7jzrzgxvf02IpMiEXtFdJG0
 S3smLuO+3iV5FjFjWfaCWzLIvOxAbsIlb9Fdks+HYFphXRXdp0N9wX9Ey
 XVfxz40IzBoXGDLSA7K7ARu7bsHMhePbUgKKYQSFBoQX4nnKuXJJa0o9E
 bpomhQaOhWkAfyEbGfj+k6dNWBRkxhAL7qSeT07jiXcozte8drYyTJjW8 g==;
X-CSE-ConnectionGUID: aCMAyD5/S1qF9gLN/TYqow==
X-CSE-MsgGUID: RvjZYSbBQEajnwNa0ze6gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70142335"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="70142335"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:16:27 -0700
X-CSE-ConnectionGUID: rQFAd5kRRWGONZl7RK9SRQ==
X-CSE-MsgGUID: X2ZyXoTCRtm3VxMdAlETKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="172066382"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:16:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:16:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:16:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.66)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnCqopKERAEl3nZu1FEBGDjbDi2e2/P2ipKP0LbIepIT8b4eJvH7yFkTpe7S99kz1QGZe0EOsbP8jH0usoRfvWxitR1CHzPS5lFxLvhbJ22HwS0zbT+PdLRkCHkQThXQPVPvI6faHa436pTogGFMzaMcSYmkQhdndraygRMzbD0q5C447J+/EFjzelWV5iRmXuky0QXp75aDOW4YS9EPhRG+UdK7XWkH854cXrOYoTfQ3ixM5DTvbmbzLr1bnyo76UdG3Bkj6MO3JfGJyvcGNLM3XyLcNgNz5/Y5k30Kmb3kX0PnDCIMdTGV1g8gn0jem8Q2sJeukBfrMsMMFntmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/xUAonPGx8pQdSMMLtAh31Vjl79XEnew84k9P1lT3o=;
 b=MEX4CA1IDkMdUvmrlITgQh2xpn6AoSaei7LWvV0YNn4dbC1/fIU+SjGyV/clkzsa63kElEDJms5CweJHgmczZef5YTS0KlRKQv+KYRVy6LVgQyaKqtycWFVogKlGbfxBilngbfs4/BLZzFJtKZCTUEKAGiLnD6YvdrLMuLGbzanKQMk5RhVdnzbRPQPJKXk62pCsBC1q6imZjtXrz2L/fu22pbu+d+7C2VAe5bePYUnINkN6fgT6sTsMp+j3wB+1jeO3Nk3EiyAJHTWRPbnebMDyNDsX0r0nJwQ58Psceu1qnBY2ayj9vnWbbqREwkSw6h9JDb/IN2ORQAwpMeFmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:16:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:16:17 +0000
Date: Fri, 5 Sep 2025 16:16:13 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 08/12] net/ice/base: add missing health status defines
Message-ID: <aLr-vcAkLLsyU6h1@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <34878b40937a7b6bddaae1467e307ea52341a3bc.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34878b40937a7b6bddaae1467e307ea52341a3bc.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::37) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 255a0a39-6825-4ffa-752e-08ddec8f2937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AORZ8pZBQpZOjDMfe8XkLE+f3YiMekL0aBBK4Smxmcv4lg4gxTKYxgyiWMx4?=
 =?us-ascii?Q?sN3hQ3kbT0fhoYUMhEVPg1O9IekwdXXbsRQGA9zSSCdXcJsvliKW5HGWi7+4?=
 =?us-ascii?Q?/ZHmKG5GCGTOSZr+JYWpUN4+vJ/uJNRBSZ7wStYK1VeqTEYPOLQCVfWBDaLy?=
 =?us-ascii?Q?Ent5BymWU6rv1U2N8SQbpco6vs901do0PvPhnFOpKz9jrM+j198LQiop4o/o?=
 =?us-ascii?Q?pWok1Yjs/CI2Hmh1Z9CJA1h6qoxud/+hg48FxVfQdks/Ykd7PGZYLPTlPhPm?=
 =?us-ascii?Q?vS7RxHXoDpzVWLs4avVSvBpWQ3FA7+aAFhX7MXiSfoTPJtrQa7DSSv/6bmu9?=
 =?us-ascii?Q?G48qCiQpKdDjqLWGuuEwfKK43qqTh8OuF7gx4DvdcNl0CYbb+TnCCc5M9ejs?=
 =?us-ascii?Q?r3mAJQxnHH4+gVzlPBfaHi9OWsU1ukB/m3AExvBqJ8VJGgmUjnXq4crflCKW?=
 =?us-ascii?Q?ynvQOxpoDHpVB2XO5UpPElyO7UmLY8ORoZfulGxlStwiYWpkGEHXsGx4mSjG?=
 =?us-ascii?Q?EFHk/JWThSUy7SaQ5ENZEJ55v5IqPR9GvBdeTNuaVVSg2CT32juKJqCEcffj?=
 =?us-ascii?Q?j6SIhqTZzTcHD0Ul7MR+jEJSxcq5R+fGglziDfa8h/DvrCzwkyigQfWloQxi?=
 =?us-ascii?Q?BkVGRz/IYT8GFPzvIcY72M1PRVUCzPkEkI0AQislFWB/+GG+K6eLbmUYJ5jW?=
 =?us-ascii?Q?pQIIrkQBqszHM83rSBp1fBNx/S7ePgcumseh1vbhV6EfJwiiji2FKnJhTn3Q?=
 =?us-ascii?Q?vaE6MgcF0f1ILbBiUwGnCQSKjDdvKp4aIhpiD4k67QEU3ThLAWtkEgVbxyer?=
 =?us-ascii?Q?T3ZIPw+YfT+y52G+OK28qa9JAXw7LQGNOVOSEQ72/wrwU25peqra8Fj9XUQk?=
 =?us-ascii?Q?hI+BADrjC1KqOr70L/ghSge6kvkbpbU7biMPMOrB5+svjnFAOSh41x5t/nb6?=
 =?us-ascii?Q?uVioivkSCcjyqVuCL/+dkmvJRluU0YcwrmkXl6ZDOHn2Q3idjYNga4ekjMsj?=
 =?us-ascii?Q?no22RaGYpn7IvRtSrF6taqS1YabCWEeJNCMVlOUYxTmf/IBVY3Y27P9p708Y?=
 =?us-ascii?Q?pgP+4sckCnrbrtTAhZ+D+gKSZlAt9IiWlX9aNaoxo2zyd2i3T4eBHaJINWQX?=
 =?us-ascii?Q?NlrRecWGTzKpCcd5aTyqmx3Hz9yFmOgpn7tRyQRTX1S+LA+oruc35PtgJU1G?=
 =?us-ascii?Q?ancVlgMH3KWUdVbSJD4UWCS97gmTkiYES71zmfVGphKWpcphCWaL2GTCisg2?=
 =?us-ascii?Q?Aa/qMcStOG5XZDGgXpO7B0p8V5rANhLacfe9IFGytt656V3ccGw3utnstdI6?=
 =?us-ascii?Q?CJ6F133/sRvsDxCdrxkPbbf8RapuCNmwK8XHapky7a8+AZ+MWhxjSVfPwpHL?=
 =?us-ascii?Q?YyCSz04deIVGdfPfOxrmq8loEA8dGqszZx0vVTWpkcBz3fpzdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZG3xQ/HDt41KRhs9y1F/cJU53fTUMEG73G/MN/dxR3lOVkTUnHWQHSUEzbhU?=
 =?us-ascii?Q?Lv1p51WZJ+CR9YeyPz11+74opG/ETaB+RgigVk6V5jMB9lHGtC50hJ4IoKDA?=
 =?us-ascii?Q?2nB0L3MReEcBEw2xAag4SUVQ8JVJq5JjaQ98X0Q7jOZITwMLZorDmrfDvgt+?=
 =?us-ascii?Q?2Bf96d9Q1e5aYDocYE/VIUa2XzFnU7+fag9vLoBHMII++BCSF0+63rBkzyRW?=
 =?us-ascii?Q?w/4jxnhqrHcG4YvDNuchXNq6ThH/mjoS+9x+b8lwFmKa2eCmpA7oP1RclHiV?=
 =?us-ascii?Q?Q0DfZ1uG6WRWWWaiYd+UwvQuamzghvRU3GlnEbJeAcb+UUh/PBOJfhd2vDiQ?=
 =?us-ascii?Q?sSH+JkIoCgMhEJq15tg1WwLFC6RIN65eL0bHvRHhmm0uxwVNsOo2hd9nF4cd?=
 =?us-ascii?Q?5vjAc7yg8ddcb9HRIJNrgNSguP8HuLr3VYuoKUVFHJIQzmLUWscj4hgH/iLj?=
 =?us-ascii?Q?AJBbKwHyCnqTegqGRDOMQBtiHyAlSlhmP2rIjNfosICp2987KoEFhtdYQpQ7?=
 =?us-ascii?Q?tGosxq3RLx3Ho8cGCRAc5P0K8aAZwl4dmZA/SiDOnZzqqjKFol7dFmNvSj2z?=
 =?us-ascii?Q?VgaAOArWVLDVMbrD9h/qX+tmWnF3EXwrNAtBbrgZVzw/ePfQfTlkDCLkvSSz?=
 =?us-ascii?Q?+64jHEJv+01OdgLn5G8ZRUnZw128d7dgWJkuNpsKN5743YoRS9Anzzj01Fjm?=
 =?us-ascii?Q?MrXePpaXF78+u1sLW//weaGgc7MO3Pjr8vY03IXK+I8rdm8Jx9vreJRXAabN?=
 =?us-ascii?Q?OuSBkzDRj5bDwmG2KPyOD6LTtTGDezezEAYtBd6PLBxdFgFrWj6t+y/wFjVT?=
 =?us-ascii?Q?7KuzFxU0GIRto2BQkF5aYJ5iP6q73tntNV1xtAXuCK50CA7CzsMnxiSvVWkn?=
 =?us-ascii?Q?xOwv830JYyyd0HuTbzzfHeAa4DFrhhplbea4LSLGlNhiR6MsTDr5EV0QxEiY?=
 =?us-ascii?Q?g7EuH04hxZsVRAAlZ6HMGoKUrWeFE3juPgGXb36fft011RYO9g4ewo6PkQNi?=
 =?us-ascii?Q?w8HuESloFYhya9oq/W5LP4mGunzW+bI+nc6uz/JQwvufvVhju5tcS+xvtyXj?=
 =?us-ascii?Q?bwRuLkP4YBHJF4IixTLIXsH/CyLyOr0H/BfmdD3gCoPTDttEIVKj0y90SnZM?=
 =?us-ascii?Q?0TjK2ve43VhgzRkGUe8oV1KJzY4g2+anUlq2V4q1NVHZLcffZCXbV3h9l0YG?=
 =?us-ascii?Q?i1axo7ENHBqhdoDtYz0lIODqzRxgxlLG6nfq7VsmaJm9lcFjYCrv8fFdfriw?=
 =?us-ascii?Q?QjLJsTDIjKaEmJiTJCBnApgAy2zeNRfScp10TPexpvrY9oTkBQ2Bg4Gl3ogZ?=
 =?us-ascii?Q?5qavGFHzRhn54UVAzppY8KcIJPBLAudDuMls2jGWtVR6CwULXTPSQgZ0riM2?=
 =?us-ascii?Q?7MwvSSgKGetpZX1r3JvS7TXaM/Bj0bHTQY2Zu3PK28cSdXcnmxWC7wiAWkai?=
 =?us-ascii?Q?9Z15gLg/nZGq8flLRvMDvJ37bTaDyq/wbZ7J2GbEUQ70hkhMtFD3mUBuAGud?=
 =?us-ascii?Q?GmFgJjNBsDxcnstn0Ry9lHWhfT2m188YIPP6hgUcL3dI6mxBgAkD1TNmk13l?=
 =?us-ascii?Q?46OmNSH0HjOCAJTwr1ELnXd7yFEKptUWztr0TqLCX3C3j3Ys/ai6oIMtFsTU?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 255a0a39-6825-4ffa-752e-08ddec8f2937
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:16:17.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTkPZvr+Fh5y8jrSSVQbJBKbGeKmD2mGaMSlT6GHc2kvb8mb56IUruZp5paHxGY4XR06B+pSgG2gj7XOdo3LWtLiNgeOiE5TJ3JauEDc2dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
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

On Tue, Sep 02, 2025 at 06:26:58PM +0100, Anatoly Burakov wrote:
> From: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> 
> Added missing defines for commands related to health status.
> 
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_adminq_cmd.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

