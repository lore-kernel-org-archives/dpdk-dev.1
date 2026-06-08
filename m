Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB02CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 07:49:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB43F402B8;
	Mon,  8 Jun 2026 09:49:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id DCC51402AD;
 Mon,  8 Jun 2026 09:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780904954; x=1812440954;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sq05CmlIub6FTRqaySOigK3TKPUIQBn6hvpsv8tl1dA=;
 b=TJO8naw2U/ISPmQruS0PFXAfi4Y8yoUsQThY4Z8SlnfHX3v/AVIF4Mqw
 28CAe1GMLYaqoB1j7i6uiZfxxl925vVeE+AtfnxLA093s90Zlz4LyPAQ7
 Vp+EP4bJY35vXiMcyvxywGilJqVRUM71oHCkvi5wKM9imt1lGrf5qCQl8
 38DDwZIPlAN0dUHukXcywjctnt5cD941+L2x4xl1BCI1VwOtaEnRxtMmd
 0eBOJvt24OPbY+ofFUFY1EihrF8G8vsqJH90h7zN6wzWb7EVvyWPQWZOE
 w1jsHTUq3moyB7nPr1xSBUSPrlFmLxgoJEPKvLUNIMf18XPtTKw+Q14g2 g==;
X-CSE-ConnectionGUID: QX28tT0+TIuDEIcImUQG/g==
X-CSE-MsgGUID: qwwi9gR2RDCujhc5XGKhsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92738886"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="92738886"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 00:49:12 -0700
X-CSE-ConnectionGUID: 0tnq9g22QsyiwITfuUnREQ==
X-CSE-MsgGUID: baErQWbLRRmaydm3Ivbeuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245576926"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 00:49:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:49:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 00:49:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:49:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzkvekqLfaWsj2zcp0HJQ6y0bK36GtzzQVGwdADN84Xt1MDGn0YAcJxv4TkO4Q/Ph9liySxbpvx/FPz2BFRrF1TIuZdTcBvUzOdeRtcGwg7eWdFf4jtyuoOaWyTkmuvW1ks17EXUyRFBuqbttqqsPshX6hyCgTCMxXA0rZwSAn8J1qiEtIUcq8uKTBw51A8/Ie+3k2lGRhzvlK0DbAl13gGHXnoiRCYD+FxEw3Rb0R3WFlwMsxWzw3dmyXW4chiDqFfBz13g2hxDT73pCRF7Z1FvMqs9xkZ5R/AOocECw0mMz79aBNwBZ580vQNOy5ztbBtF+hk5Mk6jmZqCcEbT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eihQPq9/b2f9OZspFvsM3t83jPHvjADvl3kmCqYSR4=;
 b=XH4KG1SeWzPqm6C7XpK2nn1RpZpVQg36iieNgcQGs6ooisA4canQIMMXbsuGraI66nZaiKYgw8bEDkC7iQ0FD3Tc8+ahTenU29f1UOhnDTsIymZr68n3KnAvQwrR77VRmoXVIfD7DZbdX+DvHFtKAoP1gqnSxKOWPhNeR2IBhehXLcO0cSz9LmO/ktYqCq4UzKYZR6SbXDb1HKezn0DqNrNePPOfTqoqp2PKWx6cu/n/6et0zRPvMriNdRtx45mJCWeCSl+J68h3hEndW8yrCdtGoxk6wfGYDcBYjznIbo0XkU5YOsftJF39vUmOvWWqbBQZC83qbJEGvstnsJOtJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6658.namprd11.prod.outlook.com (2603:10b6:510:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Mon, 8 Jun 2026
 07:49:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:49:07 +0000
Date: Mon, 8 Jun 2026 08:49:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Ciara Power <ciara.power@intel.com>,
 Keith Wiles <keith.wiles@intel.com>
Subject: Re: [PATCH 1/8] telemetry: fix thread-unsafe command parsing
Message-ID: <aiZz7vAfu-VzYQ_b@bricha3-mobl1.ger.corp.intel.com>
References: <20260605205253.520196-1-stephen@networkplumber.org>
 <20260605205253.520196-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605205253.520196-2-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: a159a09c-9f4f-497e-2b27-08dec5326b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099006|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: 4YqPFDrjkiQyAd45b6AJwhsB6u5kZP6BjB6SM6xo/SxnfQLm9BWGaJwDxG4DIHjDMoJXyFO6BMYcaqEK9bWL/9ak6k0oFvhMnfIK6SuWueMEx6cn2YWraj8J5/H1VQCXfnh+KPoBo8DHBm4LmxqqvQEJJDmMQASLg03RyfGn5Bb3PZ3fMCvvWA6xmzx140O29vadKpehOjRP78VPB71NWQrt8W/TFxIpQyX2lErcoulom433MLqKHjmqAAUFV8xuyeHh1LO00sWf6upyrPCXx8Zb9z/Mzxz1ZyL+yc1xTr1xKDunb8XQeSgLjFRaD1+T5zqW4+aOREAUTgl2P3I4xuk69jcOwhwe2ySyQq8AtAA5UqYPGcY/MGhx20pVJUx9ehOlZmrPcnhD1vptHpJsRhAVREgP60EWSnmBqTp8VtUODkUuwzTm8IxNSCy9M5TDfUhqCGnxS9PAzbaZgrKZpF/mlZ5dEMleMdpzv/HzTg96h3hUWTU1U2yRssU6XBzSWVdECLmgctnd9fAYvdWYsL+MH0FrVIHJZW6xJC7X6TV263GHlKheTYIoflVxBqfe0guotBSnuVjH+5+NtTR358jTw8zjKLtNykxde/2D5VJw1P51l2/UpmVgXuf0+2ZURYIIn3oLlWFh3nJ8OakDgjyJA2bbRexZ4982HbypQJC8FbRGZ0eyR3a23J4GRMEo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099006)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iJwKC8QIUxOxTAm0CyFeB8x+FihiXMWfUZZN7/nnxbhK1EsRAHpMNr/rU8oB?=
 =?us-ascii?Q?c24+QGqGEl+Q051ddbvTLQC0p/+wMa/yEgOsJCpvHjBjSCH5UU1HHsks8j5f?=
 =?us-ascii?Q?RtLKDjBbJ0yG8S1G5Y5Mw4GvvwliFB5nJYISnjZDEo5wDaRXRnH8GQjNc/Am?=
 =?us-ascii?Q?GgQ7MemEF939F5B1o+cLvBEZ1l4WBjQD4ZT2+Kam9JMLaNSciOeeM7k5lQwi?=
 =?us-ascii?Q?hdG6hQ0W1VuEfDZFhXnb4ElZ+OW7QqVztbN54NNKg/Y6tI7PMUJKramfDwaa?=
 =?us-ascii?Q?LEuWkzcgM27c8KjTRryjaWFlpNEq1Nque/jp2jsE3TnUZtUyMj8wclKcUyfc?=
 =?us-ascii?Q?g/QEKTML9k3aLov0cg4pM9O7PX/7j9kFtONuaKDD+7cIiPb7n/nAeg/dbnqk?=
 =?us-ascii?Q?V+GQHk0fGVOp3ngkPeoP+rJYpZFqPmR8kNshWy1zrnOfX5UjPfbl0uzXI5zv?=
 =?us-ascii?Q?+m4iS+Z2+W0uKUe/cy5tTN1pN1EE7DImK6cwEhQHDILKgIVmCg/MbLuyJkdV?=
 =?us-ascii?Q?Y1/ywSf99pRER9CmoEFRvfC9aDKSoxUkdk8ho3VOBL9UIEnudGlBGOyupE9R?=
 =?us-ascii?Q?ic+IZg0QUkaQsukPylRYW/aHXx15pv4OiOXT0uEa33gj7OG1cLiaAcfqXosY?=
 =?us-ascii?Q?KsNDv0hgqcZIu0D3EU83qBqVjM2i8i3HpLzDWvn/92gZrFHLQYT+OuksTpzg?=
 =?us-ascii?Q?Vtq1xvIgI67oRpALv1nfhvm2FZOWbuWhLnfmwtbh1CG/1tdmV7QgRV8y89Ax?=
 =?us-ascii?Q?zoiQRyhu0x4J2YtRT3ZebxKpOiP4uM2mfwyNg71EG9AFr3PTlCJfII7Ig2a3?=
 =?us-ascii?Q?el77oy+59RgQ1vs6sX0WZ7J94wAXoTgoFSZEtwV6U5Pgm9EEuM+n+2YateU5?=
 =?us-ascii?Q?5/65mokxRB3VUpcc9Hp27zZDbNl56uPAh4Y2kiUxuigfdFqu/PZOcC4kqzUr?=
 =?us-ascii?Q?D0jqvFnDQem3LItyaavGBAzsXqB3njG/iXRCFTubJu0O2KQ9PnxNspVKnsTr?=
 =?us-ascii?Q?Z58DSGwzmHmD27rAqjRfkMFAXnXEYZteaGoMqAvE9/JJq0IbpCGlLyZr5gAp?=
 =?us-ascii?Q?q/KFmPQU/IJdrSijdHx+Wk5xxf/MKPQ5H/0jnwL88oLoTbJG7ep/T/7ZZqIz?=
 =?us-ascii?Q?vw3tAaVuXvpfceKleEJ8e4e1NF1W9Sh7Bx+TXoS//SPolylU7ooePUbe52AB?=
 =?us-ascii?Q?spdWB/zrSrK1gHgeXs/AchboUsSz5ro9/1Ei0UvUhWfbOdNJLkyu2LEQIBpW?=
 =?us-ascii?Q?AzxBWf7XuS5apSi0EHGAmD9fgltsyQjjVbo5tPXwBaOF13G4Pi5UXxcHA1LK?=
 =?us-ascii?Q?0vqxDvpEGHjcu+40Uur6YQLtKR9GP2gfzB9+vjZjrXOXYX2gdkSRC3miuyyY?=
 =?us-ascii?Q?/z+WeHTexLZ7mMfAllHwz/kIX1ESd2NGtYi0jvNm90dXQkTFgb15L9Da+x2d?=
 =?us-ascii?Q?H5Nw34s3T5VFo8hW0OjRuDxR8iKP23LXf/uLfFWIJ2ewT16DyZLnBjDUusgu?=
 =?us-ascii?Q?ccx9irQQwBsW0daLaysxpMr/Y3hDFtF125lQVzREKtx/AcUJAU90Uir+HIwp?=
 =?us-ascii?Q?h3UII+0iBb/9TY18NoC5tiAjOyai12S451DkG8kykagxWcRWJ121PWqLSOW/?=
 =?us-ascii?Q?aeaffqDD4EMJz9RJDRbtUsTWhYGvgfQUggP/NWLt2g1tu9m5nlBgjcXWWNCD?=
 =?us-ascii?Q?hE3xTZxa1swwUJlWr/WkHQHH2HFK6Sp6sQ5pSZa54HdxjnMvqR8bldBJwCjE?=
 =?us-ascii?Q?fLqjfdqP2zNtRE7LpAyA2r2s9e7k73I=3D?=
X-Exchange-RoutingPolicyChecked: FWuEvqqe90RSYXOOpoiIVGjyamf0s29/W/czBhX2nswTZRi9ux+E99rQKzA3dsRumkHaMw9q/RoJ4Zc3A5byGak+M1UfCNGxBQdXNTJPzzND8snlZcHsoZBUxRrMFXXIYSbLa1tUu9Oabf9DZtmJvgCDMIn/63NbXAtUvancrV1lE5RW5pljQ3KLTuvvyUzu+IuiicytrD5wSuTuItBs3tPktcEjYwvqoGt0v79ndm4A9J+qcktMX6668zjE5TNpFiEe2zF44aUAM+jkYKR+gqxrQaLrJ08Yw/Zz2bfQQr226Dfs5mQBqwXKawjMZN6pOzXqdx2jns59pQUCTPbPhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a159a09c-9f4f-497e-2b27-08dec5326b56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 07:49:07.6087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skw88TzRdlioFa5HLVhG84k1b3xs6186OTssgTnxcz8XrqtRrNPUVrJUnZ2+t6MsqfJYrrRmfViZ8bmzPBW2Gw6C51EF1NbxiuIBPhSfN0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6658
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

On Fri, Jun 05, 2026 at 01:50:58PM -0700, Stephen Hemminger wrote:
> The telemetry client_handler() runs in a detached thread per connection,
> and up to MAX_CONNECTIONS instances can run concurrently.
> The function strtok() keeps parser state in a static variable
> shared across all threads, so concurrent clients corrupt each other's
> command parsing. Use strtok_r() with a local saveptr.
> 
> Fixes: 6dd571fd07c3 ("telemetry: introduce new functionality")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  lib/telemetry/telemetry.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
> index b109d076d4..e591c1e283 100644
> --- a/lib/telemetry/telemetry.c
> +++ b/lib/telemetry/telemetry.c
> @@ -415,8 +415,9 @@ client_handler(void *sock_id)
>  	int bytes = read(s, buffer, sizeof(buffer) - 1);
>  	while (bytes > 0) {
>  		buffer[bytes] = 0;
> -		const char *cmd = strtok(buffer, ",");
> -		const char *param = strtok(NULL, "\0");
> +		char *saveptr = NULL;
> +		const char *cmd = strtok_r(buffer, ",", &saveptr);
> +		const char *param = strtok_r(NULL, "\0", &saveptr);
>  		struct cmd_callback cb = {.fn = unknown_command};
>  		int i;
>  
> -- 
> 2.53.0
> 
