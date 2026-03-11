Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458111125857
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:25:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F34D410D2;
	Wed, 11 Mar 2026 18:25:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2F0854060A;
 Wed, 11 Mar 2026 18:25:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773249905; x=1804785905;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WpUFI0+ywk22vai9khTQJ1Y1h6Q+zkH2r3o1n7OC7Q8=;
 b=H67dZdqcOdYg0UOR/cLfZ1xzB/GGfwR+XHmQK3+uGxKCPNJI6QuY/MT4
 tAPqvA1cO4JbVWGGIHqTBUhd5sU4NF1WRacMctiFSG8t3bcu9Q9oxJ2Rs
 b5hhCSfcnUfPyYg4Rlxn2aR7ij4mn7YO04tt7rnnPFF1HEgzk7GtW9jSz
 xJupjzzdrwaYP2CnrZjH/4q40mJhcwE6SwvogQ/OBPGggsk9AMaxY+MvA
 Voo0M0Y/wcy+5nUOc1CPZ47EVvsE4M0j8Kp1n+eFVeJTvQUYj9gor8yUC
 nrmn7g3C0tnM0jPZRQvjrraluNqAnURbN/mjv2LTGyTbh3WS4WMyQ5hOp g==;
X-CSE-ConnectionGUID: spqPq9c9Tsq6P/zLnWVIIw==
X-CSE-MsgGUID: 9SnnJNh6TiCgMuKSTb1ExA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="96943188"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="96943188"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 10:23:44 -0700
X-CSE-ConnectionGUID: zNlzBOObQqaHREpeP8Fx9A==
X-CSE-MsgGUID: YeeL6hDqTviAoTVD2pP09g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="246075339"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 10:23:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 10:23:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 10:23:43 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 10:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPSfPAtrn9+cF/7ugJwbtDSi4QU5hiRRIYiAKfy5f72yr/2XjwCC48xTBx1SX2vH9t4DYfak7JouADOFYFBNS6gQq2MOBbEQkXRlR6xnXqfvCtYCaTRm6FeBEJPK4ax/GQkFrw27kiMKKYv3k/z5nc9Xl3zA5t97a85phDCxAkzIaDY9c0+h+yrkTdPMgkPM8ubq2kxcdpLmSBNC5hN1R55M+wQOnXn1qmitBAjaFB1NY9bNAtChLhNfYugLm7r1Kl7uqNY2d6PZHiFebKAk3TWBGT40WyJymQnquKsM59y4lJICbxMOl4xZPd7uKDHZAtw47fuEuJwfwf+4FYRxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHWExWMznJ6cetYpCAf66kW1CbxgKRDk7K0LmF2QcCE=;
 b=g0lZY/7LMGakHnqCfZVWcSI/1Ts7zToIE1QnG4LYiKTSLd/o3mz5zZ9/SmS1Al5PDfrGMntodkrP19NtD5Qn2znsEqbEhX4C1subW2T2XKc9xPVIaMDZaCskQf0RBMMA47MbF9L5Nnkwfm9fa4bwPVHoXpu6l3hdw3yeavzTNtXBGmINLUlm/w89LbFAMWXkbjmhTkmGBJP6QSp4tVXxWoPzC1skBqOkm4+yZoCfVZpG1B4ahLgJfJ2bMOiK5iy7i9laVxNdGtQRpSRyzKDJQUWRW2n0eA1mjXjjki0Ajun6MU7DN1DMyZDe4OzXcmWiN3mBlrxFez2Vw5b51VoI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 17:23:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:23:40 +0000
Date: Wed, 11 Mar 2026 17:23:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] doc: remove references to obsolete testpmd flag
Message-ID: <abGlF_Y9fQomaUsl@bricha3-mobl1.ger.corp.intel.com>
References: <20260310104945.3271920-1-ciara.loftus@intel.com>
 <abFslPT2vVsJ5q7L@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abFslPT2vVsJ5q7L@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW6PR11MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d576d36-7bf2-4e40-f78b-08de7f92f022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: QDKg+DVuvMl6Wv0Th+qROe+3DKBb6p6boQAsAM/XAY8MCymkWH3My1isLh9EyQ/TXxcP79JF1nYtYpVa66iGOqF6dO2TUO4lV5k3tNWdwk73inhVExjwGcyRsMBhz8vXo/CzAnzfRLF9YNZyhUg5ywfTAhqBDyyiI4RZt1ZvVFwtXtaWwe5JFmGcc5WcdyROInUiK0gKuThm5Ws/vf+pdSUMitOsSW/NW6sJVosUFiPl/vVSaNlbVWxNSbLiOhwuFWb4fjLQvLEsMdeezmAxyNaelni9Xs/xNfcWNSXLef0YWrW9Qa1nEzBjFJC3g4meD42QZG3nJnAIxOt8iH3Jn75gKuPGH2UrAVm/wF5mid9U7I+/OdcUZ69uXqhLoNRDRQw6MVP6+j3rtmbspM4UQQ9fYU3FjDA1vCzW+KLYe6ISIwdtQgz5RXWC5r2Aw0PYEz/78Q6nnxJXQx1VHnxCocjyK4610ze7Rr85bG+eqFj+qfkZqQ0WI8NVHgA6RKjIeMQWMi7cP0adR9m1eEQqQiwAcew5FL7pmPmaSoPNar/8T5YwEly4BbooGNO+eICEyC5t0M7ckuf3DldlEqavvOmuusKvDsyxn4A79iT8ClTWsnisRCM598A+OgqKUpV8/AdW3KIIXEHKCMaeN736Z+kXCAMS4re36wQ4jINovgTRoDeE8Wzy8Onbhjlt+BHJfT4EekSBUk3QMOEAVQCrf/gBuvp0bF1AOz8+w6Zq07w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c6Gk8SlFHBw7Sp1Es5ccQ/56ZWYNvv30HLDum1a+OgJo/7SmDNOn5vQWKnP3?=
 =?us-ascii?Q?wH+xbEz5ds/orwnps3kaKnTXIRqp3v/TQ0cywJ4XSapWEjlTj9skY5bcKMSP?=
 =?us-ascii?Q?2P0C5CJ2s3FCHzY7EYWfIypJeOsB/7Qn0a6UP9AkDvFiRS9+Hju2XeDCklKQ?=
 =?us-ascii?Q?XSdkUg0CO6UKkja6pAeLkagxAQ95MB89L4Uu2TSNoPc85jAjQFn3Hp/DCLC5?=
 =?us-ascii?Q?5lOb88jsvHMh8IK7yzSQ6ZX4MwG1hSMS5mIAtgZ0YQopfkjuL+iYT1KctLuM?=
 =?us-ascii?Q?DUFyDix2NDVVqoTbSWV8nWRQSK/dycvr8+QaIN5GpXWiOpqFJFpl5pweFgoX?=
 =?us-ascii?Q?DB64Oc8Pyad5yupCWmSc3rEEvxSN8A7ZR3AK7cBrGYgnVAYmWBVlC6dlfz2m?=
 =?us-ascii?Q?sM8nrOm3TkAsWda12FaZPpjfpvxkuOrNdB9VPD8Eh2YkBjV5lr5/NENtAlnB?=
 =?us-ascii?Q?op+yKfOZ4NTpwHimnFJnS7AvnwjW29oggKnzyoFxItbur9mVGmM6ZkE6Cr2A?=
 =?us-ascii?Q?O2gK7aKHtfuoVUufN23omsKXh1pHmWG8ka0oqjyO1bhnhzgWbwmgg1BgLCkB?=
 =?us-ascii?Q?day8EZVBUbdAdmotXktyRRrdaNW0WZpW0kxa8VbtGTlKSL2e2UWmrNXT1wsx?=
 =?us-ascii?Q?m0ZXnkbD6s+GzOh93f6l9cAJ+ytzaHFkjja+zVb+gVB9CVpCTejf+b/SsB7m?=
 =?us-ascii?Q?P5zr2Vse59RdDmDztEyQWiUSKPupaXVde+6+vRH/PR1nbFbuAuB2m6nTVfgZ?=
 =?us-ascii?Q?xm78DKb/fwfBFtEsuVhhpBDYIo/BbOXiV413Ek7VO2GO1D8/YzZbVqJpqwJt?=
 =?us-ascii?Q?NzWzK1gSOc/CIxIYGP4KnxBO9mFvSIIi6atTv91ng9dGjWNIHc7anm1MLNph?=
 =?us-ascii?Q?v7dbwv/uo03aiHkk3ka4hFCDVc++DXdooI+F19KkfHUJMQjdbQLFHIqj76oX?=
 =?us-ascii?Q?myqlz6oYxtea+dFCdNyLPloEVP+VXjRZe24ES947RxUPHG0dBf1WoUxPcqyk?=
 =?us-ascii?Q?v1lTtWzOAT7pErWsJjO7P0GtewgxpA7Kh0pRVoGsH5bWNGBt6oAPU4WxMeoQ?=
 =?us-ascii?Q?iebx8DprXj+ay+BF/1FRZ4oYK4nAx7VlHKpN1N2zYy0Clod0bCynqkTEdOrQ?=
 =?us-ascii?Q?JWlWQ+djbbo1dwn+rZ0W162oAPaWQjb9wgySAN7oEirxAJk7hpVQF30rCoMo?=
 =?us-ascii?Q?R2qY1STzLbmF4zW408iYO+YtF019qZyUmDcWVDZXQNNYI1YnBLdo1eCiJ4Z/?=
 =?us-ascii?Q?OMojd0XgaMuz3Mn3UEuHLyJRHp8S4Kwt29eVx5XeVhEejBP27puunheM0P3i?=
 =?us-ascii?Q?7a2iCem/B8vHqKdGWHiYFo0yIm+Axu7wmpv9kFDCW7kDRnbyQEY0Cz3vnZyK?=
 =?us-ascii?Q?BihzZ1R/TMH8LwWsXf/Z6v0z86WfvKQMyQKQLH/nIAkM6Qr2GL4DZV/28G0n?=
 =?us-ascii?Q?NmarM0Cqan9aZIcDL7kFV9fsU+LgycSiux1yTdbiUNQ29G+2GSTe63olop+3?=
 =?us-ascii?Q?g3qDhMAm6WPajYL6zzYyNUnpdNXBrfqWTFoQpc4QrAKu1iW5qGD6W3CCa0Pm?=
 =?us-ascii?Q?dkMGewzQdCkJ4bkDc/+LibC0+dklRACMpkJRIj1zwvk3BVdEmAqPTEMLmN+N?=
 =?us-ascii?Q?SsGyj5II2GD5ZHuwAW+OApZ7B2VQzE+QlUe8ngqVTNbn+xPP1gGMLLBmkrm8?=
 =?us-ascii?Q?Xiys+BAg81YTtBumWSPUi7VegTdoYDHm27svp31ns42//GUcjbqezDtpQUaJ?=
 =?us-ascii?Q?dxG2ryCmokmNG7ANojYYoTJ6ZK/Q+8g=3D?=
X-Exchange-RoutingPolicyChecked: pl3Tq6098QA9UAVqxD9w8gQM2td57EJo2Orgqhpf1ZPSSrKoiJLQeOdc9VC+tVwXcFLO1W2KgffIEZnvbBJBCqC53AEYyAyHkfg0eEm2L8g/ZmEc/f0uAGdXtTT2jHpQBh1gxDRmIsg3AJkJUGvUCbWjufWFw21AnchkfBlhiblkz/cJVC+QFVkwA2QdiQ20ffF01h/HT+S0lhGxU8xDMvt/7fDshlfPQElE8wCiyLR6KtEMedW9/8/YYZpbo7ClDvUR9CC26/mI/uHMOZkDx25XocdwgisT7xbGyLQxMPM2MDLVdg6LVYKAe8ppKG5PJZ0deyfoUcgbu4BGJDUjvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d576d36-7bf2-4e40-f78b-08de7f92f022
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:23:40.5863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kKT/EiqUQj68K5IGyBxAckeLDDvp00X6825u0YKr6yMCFCrrirGHNmmCdJUFV7xxc5leM8CVGELCeIdu5vHnjuMXNG1RSjYXVKLZxWU6tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8389
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

On Wed, Mar 11, 2026 at 01:22:28PM +0000, Bruce Richardson wrote:
> On Tue, Mar 10, 2026 at 10:49:45AM +0000, Ciara Loftus wrote:
> > The packet-filter-mode flag was removed in a previous commit. Remove
> > references to it in the documentation.
> > 
> > Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
