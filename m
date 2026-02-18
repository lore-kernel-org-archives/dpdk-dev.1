Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D63E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:04:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56AAE40395;
	Wed, 18 Feb 2026 11:04:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C8A0C402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:04:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409088; x=1802945088;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cfMfitjTzyHmhIv1JWU6GtR2HD6F7GBmZfCLXqFXQg4=;
 b=hW0cs1it2uL3PY4aD8k5pME7DNXm0tm9lsvcVGQlfTbn44WwCWOGQDbd
 0mS0Y41mHjOd8s9s9efGOhQIHtSdH8sRLEq+8Q4jSFerF/qJ3ZnEJJsvw
 OUxcjr2y12O+kM0oywhZyH7dhAttCAj68+SimgcIBCTICImgqbns0Dyhi
 tmLhhd/SE+dcXExd/efxsGDcTTcjbTwyvX3dHtjVXPnb2tKDaBH7Cb58j
 nA/njlPjZ3hNRD6W1XRM3WDr/pZgUwsUt/ZShF0Q2c9ULN3iEz7GO+cC8
 6MQ2A4f75wc3NG3KmSkeZujoFIyPXAZEq1/LyhJ5g0SugeVY9gGKKZFPM A==;
X-CSE-ConnectionGUID: D8rZCS9nT+KkyQpmGhhPKw==
X-CSE-MsgGUID: VHkkY1FwS6W+OcHvpXxlwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="89894808"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="89894808"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:04:47 -0800
X-CSE-ConnectionGUID: UyL8HeQ8QpSExqeDB37SvA==
X-CSE-MsgGUID: 6SUcrfmVQWSHbQyQetXwAg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:04:47 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:04:46 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:04:46 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:04:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWvZSd5qvkVDGyf+uYB1Wfh3JhcurLesie4yFBd17hs95cdWoKSqR+R3RNdq1XIN5qouaZbY64kM9tUxVfm/ZorpifSheIAsOCMN6QYOPav211/+7oBG/X9PtgYWbCWeCZIOnl8ID16ajFr6P6dv1o6TTvG4AekbpA37xvkEhfaWZwuk4VHjYzyI6GW2WU/We69lp6WrRPTYr+qPrTe/nnMP7f1FOpHAOrfd9MtbNDsBOR6j/sIEavZPMSa624J8xKfvfqVfoyAwP3VsBUg7Yei5Ua5kh+H2O6RicT+PZ23efmMjBzAGeP6Q9z260qmReK54M8Ie5gtAiZZ9phptvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFnGZ8jVIDdD00JwXwh4jCdI2/zW6ckJh8ihpMPbGLo=;
 b=fNrUpOx58hyqFq5Cx7nCFZrxpj9Pq7IFGyWErwmIdgEiG1XtI6PNsIliWs9dDeC6pJtW3BS+cz8sSOHDynxBSUc7Vv8suu2m/QxoZfNrDKFakPs78pO2dEGH1uELfavjcfoR3yQm72GiON+t0DJBmM1YFAIaVGzrhyzM5QlrXGVBZaVQLmw6flwxTK4RpUrw0f0Oy4p/Wyps+UnuRANBV3kTRRs6wPvP0C1oRzhxVnjHYYYO99P+6h7l/K5G4kJVUmk2blL3bA7nC59FLzurLtiXk6ofNePCoD+VPeAahBlsyVLGvsMJKIx8AuSqPratodPaj4QUmf701wriQ7oPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA7PR11MB9542.namprd11.prod.outlook.com (2603:10b6:806:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 10:04:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:04:45 +0000
Date: Wed, 18 Feb 2026 10:04:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 04/10] net/idpf: prevent Rx path selection after
 device start
Message-ID: <aZWOuKJ-Dg6Myjp8@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA7PR11MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 819ae321-812a-4ebc-92f5-08de6ed5244a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HifX/MCve/05cubpkH5U4oaD9NLVBdkcxXgIkVHw9yjSvCeddSow46UiClS5?=
 =?us-ascii?Q?xeFKF5II2oQ+AWwUTjlTq0OH+eVkFsOmJk9sHvvLsnI5w2PMtwo4RhFSuU36?=
 =?us-ascii?Q?Y44L3sw81cCUZQ3ctY2HowObaBR/yu8DeGMDEtoKVeHdepqXVGyKRlDUHUBL?=
 =?us-ascii?Q?CoBAjkDS7KxLQPLgh31nrI3JGYJjxsIM7wlNH7sFap/tWRdohMNxXp6Dz/bN?=
 =?us-ascii?Q?qJNhzvHE21vQFSOSkDttYkxe1HSsqCWH3t7uh+C6A7JdFXcyz7ZOLUPxZ0oW?=
 =?us-ascii?Q?Xf54YeypBE8AB/PqF6zlx6XslvHR5sb/uxe9pSgI3qwYJuPd2BZ9pYs8NsBs?=
 =?us-ascii?Q?sX2+swmFVGAo+AkF5KSFwYDGPGPJmV1ea/jR7EdWmFXqPl4UEqth7+DQ2Pyi?=
 =?us-ascii?Q?pGkt12sm/zveNpqGFOA7RUm+sY15FG4rAWgUTptbT+V6WqJMCrQ922DP8PEb?=
 =?us-ascii?Q?fOaF0hK6YYef97hIFKdADIHUEo8zgDKVjCzdw4GIiiyQIgzeXPeWce6EqJRV?=
 =?us-ascii?Q?1ItAZtFjVqQPw4g2R46XvodI1N51yFtmehCYtThX3z3awBlhNTdRDeBV/Ohx?=
 =?us-ascii?Q?9LKcvEcmVWT+0+rU+FpfCc+5gst6Yq+8JejgagMwNQarPv5LyFRPDvFJIYvE?=
 =?us-ascii?Q?E9cxTHz6Smp949qvGw4Rr8TvaxMysYDUqUJIOvN72ju+07nFti+zBnWbyeSc?=
 =?us-ascii?Q?hLCjtgqNUHi9y0jtCQa1OivO28c5xi4gq0P0AnB0b7MV0S6b+36fSqZyvjg8?=
 =?us-ascii?Q?O+MvxhIlQx7rWe/XZ7+6QDe8qPUG6vL/VLLXC7ccLrVf+OYJ5U5ZjqKGb8J/?=
 =?us-ascii?Q?dBt1aOX5Wi732e4rb/13SphVZIQ9cMpO+B/s/8dCbRIB4CT2909xNs5Gldy3?=
 =?us-ascii?Q?7l3QvtA/ZUi0GT4q55V7qAT3JGPYFdSjUO3VhMMpnL3T+dDnVn8u46FkZDUi?=
 =?us-ascii?Q?T7/gPRweIFV1RtJj8NwG85RmfnT03CwEu/KsQhbx0XFF++c5HjtWGmSA+iD/?=
 =?us-ascii?Q?BEKdX6bXp4GKBKb768VVAXNkXEmd2A9ecZNvVRQwXHjMJEaf/pEdG6H9SAIz?=
 =?us-ascii?Q?YtXwGCCk27BP2MtBy5s8KXNTL6N2TfXotPijgkCUkwetUOuJcN3ucyKG67+u?=
 =?us-ascii?Q?q/wDpXrQX+9QAyqBkS2QoKPHoRiqhpb4uSmxYsDzBeE/Lifgw+B9hqOlXqpm?=
 =?us-ascii?Q?mlzggdfCqM+qv0n0IQSWMOhq167DSq9YZn9/gkTUdVL4E34GqfPxzgB8QjC6?=
 =?us-ascii?Q?waGUZrPrT/ngbfAhcy66qpLcs6gHwtIQJRvYznb6AzzAvUW5XtCU4ZiAc3H+?=
 =?us-ascii?Q?l+eYCGFuQ3WwqK3FLoS6OKeGvphmMIuy0OCBIyjOFHzNI8gXhz70dkMgo1TD?=
 =?us-ascii?Q?Go/dXp69vuudcuX9wzjB77K2YOEiNEyEQg0C68mxpmlTzBfMJPswx6eyiJ0F?=
 =?us-ascii?Q?f3uIlni8w5/yVaQ8zBfo4rw5+VfdYyq8uFYZIg4as8Rr81nb0ZpK3pVLXHWM?=
 =?us-ascii?Q?YDRRRlryWWW5pJZdTpAU5OITAC2bPvRst/cWygZqCw2Nyw/hiSeP4vcDBtU5?=
 =?us-ascii?Q?8mgHX5RvB4zLEVWPWEw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TetTtpoNaebp2uDh/FCJH6I5mCjF/qccd6qFCvyfDUYuGzbm92KY8xraXIig?=
 =?us-ascii?Q?UlXljeRkzeTlsR4IhVXRM4mwJAkKbWvAd87mvnTreHjxlKdzOt11eejqE+76?=
 =?us-ascii?Q?FLTGvrPkNgyWqShupQQRrok03Q0PJuMTPfX9ZXX8y4I/nQoRVXSrZxOlW0Em?=
 =?us-ascii?Q?lulEEXoLMVd+WwLdD0skA+A3Ghmw0W9F4FlIcFWX/qaPqu9TNQ6o/ZN3v9kR?=
 =?us-ascii?Q?q9dIbghOdeKVznsVqFsrWW9OcspfhRniTeC/HVk/6hJeKDvZalnqNOoWLnJS?=
 =?us-ascii?Q?I2ZrjKL9p/sKcDQzkRgha4uK3mupQp+Mrd3dlPKoSfb3xKU2C9jywo2Hu7l5?=
 =?us-ascii?Q?fw7v2t9doq1Pvbe5M0RKr28SeRFUoLT2SmPiR6rxV526puMXxA0ajpSwYRPy?=
 =?us-ascii?Q?8pshAtIonwlIgT7xMo1NeMVIXgkg7C/rO+bH6g1knBu06J/LnIII7HbNeWiV?=
 =?us-ascii?Q?X3yrJIBJQVzk2h6YiCu6RL0RV+yLcakvDof/mkMtp4rDGq1eHi3uBc6zhy3E?=
 =?us-ascii?Q?XlA5aBJyQACO23F2xyCanBWOlQO3PClJLKmJ1hFoPn7tuiqV4TjCTcRWdzv/?=
 =?us-ascii?Q?uow3cDIY6hMNkRnG6HCzBpKRsiQN50LGMfgOwmGp/uSN23/3oTV9RmKW2gPW?=
 =?us-ascii?Q?z64Cf8xsCwTtil6rydqnzpmXeC9rkpgfzX5Qe6bnXwyScFcGv0jvEPIImj2B?=
 =?us-ascii?Q?Ey3VmCATi+Fo1H+s2CnlWw8W9ubfJ9xnWXJ4ta3PElGPOHvAk3CQpmFPT1yI?=
 =?us-ascii?Q?ZMrGuRrhmvf0tGU7UftN4TCPM4XvO5n80JnCLYPsmh764PN4VWQennuoHF3m?=
 =?us-ascii?Q?u3LYv3bFB3Ww4W89/v9vHvSqn1ACP0/IIzhqvo6ND+ZBVfti1phDssI1ppd+?=
 =?us-ascii?Q?HtVoyrrXAbEI3rOdwvPwUaOG6ggB8LfTLM545YVBU9R/jqTh9rA5ocsHr/kT?=
 =?us-ascii?Q?YZO2Qc8nUSB5E1C+Wd+4M+zUC1QUN122IuRsO9t6JitbHWtrMwKZmr0rXj64?=
 =?us-ascii?Q?0pOQxHfQhniMjZDj9kn0WxzMfUH0FaKWSykvKxS58zPFJTYkThAcbweIo3CI?=
 =?us-ascii?Q?K+6Tj3MwpgSF2lCf4HV4cpAB0WI6IfNdOIVDbuRa9m4RLu5GEwzPPqyqtrCF?=
 =?us-ascii?Q?KwIoD44Lly6KIAvGx40JcTEW7Yj0+51WUo7sbpgDMx9tHOnF5MRk8zBB5gry?=
 =?us-ascii?Q?kA4X+UjimOKOCiCspqy4sBONS4EAKnrLnkDd0qhqod6SdGxpeVgiFn9RmLKv?=
 =?us-ascii?Q?Gi8uUc87In0NHOpzDPzGCXAq4eHrCCLN+Weq/0ke0r2wWmq/rSw7yfrTQMbc?=
 =?us-ascii?Q?l4nPvc9aL+NUmYRaamIpj4OCxH7lEHTq+lZeJaw+XRX2BNcmu5PHmnJh4yXA?=
 =?us-ascii?Q?YtTME0dbuD8P+qApntaomCXql0saDTEHEiqpKupC6e3EulAE0Wh2Khegn/EA?=
 =?us-ascii?Q?R8oiHH6okETvXzIyGQqXTFtxvhcRjOq2Antk/GjQ4iyj/wWMhGh4Ed4uNZnt?=
 =?us-ascii?Q?GV+xAJAF2+QFK8NSwpkDGssWjsfnwJXejWjPOa+yX8QeaBdXYybv1Q49kwoR?=
 =?us-ascii?Q?u9wYefZuEDMlS1kFaFhYloxLgOPcwRDdNr+qP6u0DRkTRxQ0ov2N8mmlbkj5?=
 =?us-ascii?Q?CjCpc12IM/NW4jC08Bb1ozI7iuqXAmsjd1jnilfbNOY4kdhomRDLy5AVgSfW?=
 =?us-ascii?Q?aJAtXA288vSAGIw46VmaxFnIn+e/U5Jlpvqeq23Q2eM+431nqyr7oEP43fZk?=
 =?us-ascii?Q?EXF08JHobJsAyp9X9uXKpkbxnQRNM48=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 819ae321-812a-4ebc-92f5-08de6ed5244a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:04:45.0103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5td5PkHR8ozMWWvYa3mNsffbW/MET96G78QPYwA552BspI5XTTbpv/d/8iO+cep78XpzpvOR8hkgw/hqgCMNr9As6qHcmTCL/dlyWVHTi0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9542
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

On Wed, Feb 18, 2026 at 09:49:31AM +0000, Ciara Loftus wrote:
> To fall in line with other drivers using the Rx path selection
> infrastructure, prevent Rx path selection after the device has started.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v2:
> * Fix unused label error for non x86 arch
> ---
>  drivers/net/intel/idpf/idpf_rxtx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
