Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8555C44533
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 07:59:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F49D40274;
	Wed, 22 Jul 2026 09:59:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9A2CB400EF
 for <dev@dpdk.org>; Wed, 22 Jul 2026 09:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784707172; x=1816243172;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=quqek8OjaASNbRnRvAh4XG78R5fyb7mkRTikm2yW55A=;
 b=YZHNJTrL+R9aj7+8o6gnNP1ibCyrhqj6fAvVU58O3dcMWiYFmjQqUyLT
 5R/mKMcRdb9qc39EMxUbbCZza1GmN5gBng719g0q5WBRT0aoPECJJ+mpf
 PQbw6G6Sa2PrQo/nvndvwP6i5U37BAizrcDbK8SYLrrSwCQj4XMZxxxW3
 Ud7g0ZpBSWcue3t4z5DiaFen80UUhVS48w/bN6WocVBEzGoLcSMDinaPU
 pgNH35MdDz+L7Sjscanmc4Xxqb52t+A2047VrXzm8ubWhG3CIFxnu6+fj
 H6X78JiC6BB3MFYpABtOfZo6Fzurk5dQcePzPhZg7z2M3YgUzL1AND2uZ w==;
X-CSE-ConnectionGUID: fVbfppBqRXq16qaa14Grzw==
X-CSE-MsgGUID: sp2GNdggQmu0nnP8Y2QXEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="110878848"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="110878848"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 00:59:28 -0700
X-CSE-ConnectionGUID: Dwa+uXVxSMmithJuBz363Q==
X-CSE-MsgGUID: kfKMTfOVSTSF89a/iUpPlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="257477726"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 00:59:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 00:59:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 00:59:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 00:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk9qWbJBF3iaCKEh3CXBs+lMltArCAByUZ2pRfvYNz5X846EGNZl4OybXW/5OW/yRmMzGaJ3J5yXLt5qICXNQv0hC3imAb0TQEmBpUNtYtpUB12+ZtPqhkb/esouaOXMgaZtrsAItK6bu1WmjM6H1A9aLHHhU5wHF2Z9XoW0gWaHiiff0A+NyW4fKSGInXxS7DL2zSiVUVdv80Yin9yBeUvfdTgBS+/VwKc2lFyoLxc3402MuD1psgLh2vnOuvU/1DhGFwY36rcrm4SAwvDeC16m2yPIDa1UhQRGuul2jvI+ZxmtrjPxfwRkTYHkk1ea5fQLJFiWbPhhyPToo5YHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y23dQrZsoSuHretgci24RGeSvmb/AqItBnOtwtNY9Uc=;
 b=ceX+RWoZOaCcjFRu299LEc/163J1PLeKTBuEyOf67L1zxpZkwpgKNIMEGFUnQ+k08o35KkbpIrTmeacTSIDdbuJgBMoGcuHJv8nLlK3kr+N1M88V0bESPsUaCLt6bNs2SGYc/VJ4vOTAVxepAptKbe93goML3Tuywkw6N3CuB8V9ss8LiRaL0iBFMCCZlMXmb2saM43ll45xu6nRM6KvnVoYW4VaLvkCLUJMTRwB+I1KZubZUNzD61sJTpuH5O1LG337gED7wKJSgV2kD8VagBm7NaBsaI7r0FWuIoJifHFEi98sCSgilotElM6SHTq9rX/1LquD+3P5/TkzugDAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA1PR11MB6243.namprd11.prod.outlook.com (2603:10b6:208:3e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:59:25 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:59:25 +0000
Date: Wed, 22 Jul 2026 08:59:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 3/6] doc/rel_notes: keep library updates together
Message-ID: <amB4WC4XSIjsgSt6@bricha3-mobl1.ger.corp.intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
 <20260721151325.2698283-4-bruce.richardson@intel.com>
 <wjhKUFwCR0mgQVZuWGEQ4w@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <wjhKUFwCR0mgQVZuWGEQ4w@monjalon.net>
X-ClientProxiedBy: DUZPR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::19) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA1PR11MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b519c8-24ba-4e34-4f65-08dee7c725e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BlPzniu61A3uCampn8Qz+p0gqLuAQZi7RZR25ULxoFeST5FtMFwbaBDy8MgQJvSWWq5le0ooagMmLDM1vZEx3PFXhw94L3jjPPm9vNlsy6Z4NwiYoBM1ShNXzW03p0DACGmwwrgdVWGBsut2wNIBHQOZqoa63L8lEm8Ad7FodZhcce0q2L1pnlRMIZRq8jvUh5yKhjPw8ntc1gOq07GX/fMnyC/5ki9UMLBQOFCtK8OS+0KGuZw4PqxeByuJtT0K2WyJRh3iqZLMOax+B+Ffyr7dwfu8rMA+vip8ZjPaSBtkgC8qKpbSOEocETJVmd2cIg7gcwyOWAUL8ntNxGKcm/JrjE6+qFEutYmNk14Tf/6qJXFElk60bLJVfAiIctVrxW3wfVwjX97t8sAkozQJpjybTkHVW8l5OHHnHleQ+DBRiRzZV3CzbKU4EFQjHn1lWkKrsBo90ZBsmt0p9gvkAfdwKmGvCrNRukUtEDCOTI8zAKXBsqW1Dst8EFPS4bU7oa0hlLIclKOP2KUgkLQCPlZ6CXT2rPqyJQBslibGMcd1IzAZXc0L+XPJoSaRKa8yB9e2r/inRYIJ824A6CDMwjlrK13HHsBsWdAVtjx8u5EK/aEr2c3HyfbVSgR1BxYcIZ6QLFX4dAQePOIzBEoSVIEk6sUWJMUhrSmJ3IRxlME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0egjAWIIfGrH+c6oUvFWksG8ZYXeQbPWHx7T/Z3xyxeR8GSVXZXn9junnOt?=
 =?us-ascii?Q?Iuwx0cuFKYCRh8QtEO4zKaGFJNnPitUweRZSvLExprAF4niieTOR7NPy9fBc?=
 =?us-ascii?Q?F4tmR/ifUkWBwmZ8Z4iYskagXP+v+OXJSiHHKQSV6aiNte8MrYQvQ0iAHEcw?=
 =?us-ascii?Q?gZyR+NYPaNFGG4fMuOfETUnN8fHxL0yYNK5do5ddJ0czIzqv8grcmBWlTEcQ?=
 =?us-ascii?Q?DNX2dN2QCKl0ttafJhIK35w9WOqz/1b0lBucAJ3JeDPPnrIfxPv1UuPCSeiK?=
 =?us-ascii?Q?ewvERgYgVZs7OnC4dLp1XlVRX5T/fmk5SNzXpYbaoW/h8VoWJlDJOVq2ksIa?=
 =?us-ascii?Q?/Ek6gFVL2rEq0DmxDA1p0UHiANhIVGSpxUbVpYmG3AYAZwVuVhzMYCF3TPyn?=
 =?us-ascii?Q?h7259vllGqr4tHTGYK7jOTF2M1VCwCAbemP1UuTKFQEZJFUwrSv3ao3NBKjL?=
 =?us-ascii?Q?ce7m2CZ6bJyxuxhf8DUp6q94umz0hd68W7JfVCcxH5ypC9V9ektSr7lofXKn?=
 =?us-ascii?Q?FzrpzOFigPPbe5qKC2jQOFKLaIp4mGLZhxYMdmnd0g0kLrPWBfe2tsnF0aWv?=
 =?us-ascii?Q?8RB2T4i2u3/sBwskrBuPcynhC7A01sICY4ztrDKs57iAHJ8+OLA1XQob2GoQ?=
 =?us-ascii?Q?FjWJPYE3x+3pTKC6KUOT8tk9BO3b461YlEXKi5/lLNeZVsAHeNwbQVhDLEg1?=
 =?us-ascii?Q?MP+n5h3DWzvySfU6pWD0xbl7RXm1t8sPVyeFk6JWZWR1YMklOG7RYItZCFTH?=
 =?us-ascii?Q?eae3sE8/9vLuhb7JyeJKiKK1w4qffpbtPO/v8tOTcMymo17uWZ6yvCoUkIBt?=
 =?us-ascii?Q?egLDe2JhQGhJZnZF6sCAfk3Fle9PJ73w78W2C2qx6pAXWE3u9wuzrAf1aM44?=
 =?us-ascii?Q?f7qP80lrTVJhifOX/GE5xlwzYG+iq7B37VEObsi+4BXVX6aq4Ie6TsXN8vOg?=
 =?us-ascii?Q?hAKsXbjnrKyEzKd/ryhf3UX35z7vPmpg4Sp9ViZ0fYGMkZnQ9X9ODAl5LFi+?=
 =?us-ascii?Q?ob7ei7Sy5fceN77xdRzzRamV/oOvlsrOaPVKQn/r/l198OM9T+0kGwiAkXTg?=
 =?us-ascii?Q?zl9MG45O/Pem7CbZKRD2TBG6l/QiqjrmcBFuXBVBc2iSmnB8ggqUmh+Kst5n?=
 =?us-ascii?Q?lKkbfaoRkj9DvArd2UXA11g5lcw/8fS89suuO5XQNrDJVo0+bsiw/FeioYjA?=
 =?us-ascii?Q?EZsE5IGfCLKChuSwdSg2wrk5TyR6h2mgtxb7GEW7m4+Djn/7UJNgi1NHrk2P?=
 =?us-ascii?Q?+IyzzNMeqa9InlLdjnOf9rPSiI0KlGwmiA0t4TYqOsC01/NGDSQUsyg+DHna?=
 =?us-ascii?Q?TJNal5WtOk4HJ7skweZMJSprlf5masqsIZxiSJNOOEgM49UeCcsD7JDR4zBd?=
 =?us-ascii?Q?ZexcEaTz5z1qUSeWumOvh2PY6XX8wjFhfxDEzBQd3dEqzhZ9+THLiq8qimhH?=
 =?us-ascii?Q?AQvLqQiRLH2dO9TRUusFXmX8Uv06AaxHmNfL1/wnGlODYay0Yu7KiHzpqffd?=
 =?us-ascii?Q?ckwUqJQw+FDbQYk8gB2TPo9s8q6GiFwaGVtnZkWKYeE/0jI60rHiOjKsQepg?=
 =?us-ascii?Q?T2WMfVfjbnLfX6b87wDoc5z/uPWK3qyMfHnS9I33ohhuKaxX0lRD5Ictl+V/?=
 =?us-ascii?Q?nPyeyRAH11vhk8ww7NOueJOf0Lafqnblv2nI2mncVxTeiOqD4IFQFCt730+m?=
 =?us-ascii?Q?eWw7yJs1K5QbB/0wEujXa6KO6Vuqim37GHiKp9AwAhvoBoG/0YUfHuYcPmjl?=
 =?us-ascii?Q?fWwT7asJqFIE3kYB/s6tcqmjtIK7J8g=3D?=
X-Exchange-RoutingPolicyChecked: tKakbLLbq6TrafHxgXpOa4+MmHxGxAPTkxBrwNNpj6LL+R0JRxEezGZU541D9WL4WnyP8wD264yNQSbc/rLrcWu4VCUCtt/VldtlfvuO4+sNGQ7t5A8/LXyZ3f937ca+qOKQwHbLrZmFSdKikn7/fY/nC426NU6cDiHplFza64b8P/PDORUwMpVJTUmJHITciY5RlLbkbQlTs3PWGMx0TmJisnS7s57M2gEouiLwo3U8fMyw+kmJVFSOQY6rThQzpQKVkqPviJfkGiPsIVnzZwLiByBa7jL0nYnk2m1Xm6EkbU7W7rTuqALEHeuLIuihthH2X+Bj8wv8/Hxxh6ZOdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b519c8-24ba-4e34-4f65-08dee7c725e6
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:59:25.5409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ga5ireduLeLdoWDPs+wOe5cRH6tvJPmFvH14EnQaB7Llilr46akyuD+HBD3jFA9nB7H4bCCk8mDQV90E9tKFxuFAo4F4ZqlafjNSR/YzfxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6243
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

On Tue, Jul 21, 2026 at 09:37:19PM +0200, Thomas Monjalon wrote:
> 21/07/2026 17:13, Bruce Richardson:
> > Group all library updates and enhancements together before driver
> > updates in the release notes.
> 
> The suggested order in the release notes is:
>      * Core libs (EAL, mempool, ring, mbuf, buses)
>      * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
>        - ethdev (lib, PMDs)
>        - cryptodev (lib, PMDs)
>        - eventdev (lib, PMDs)
>        - etc
>      * Other libs
>      * Apps, Examples, Tools (if significant)
> 
> So it was placed here on purpose.
> 
Ok, my bad. Drop this patch so.

/Bruce
