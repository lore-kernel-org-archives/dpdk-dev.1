Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79569606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kpiCnc3z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46EA340151;
	Wed, 28 Oct 2026 15:40:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 85BDA400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:40:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793198418; x=1824734418;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=oG+boafS/s07QGZn8blAJW79X9EwBsNmIs6qK7k6slw=;
 b=kpiCnc3zx0SQqMxWHJ7iTrgqu3KOEQYQ6Wi9mHTto5lVdTY+7gdqV2SG
 6rojOZguKaxoHI2Icf2tiL2hRH9OEDci8eZSj9OXEcoWj3szv/BsAQyCv
 z+eW0EBtHizMbLdQlfLa/4zO85Kl6uqNpSJaiF9bencJDFrOzQHDQDUMR
 7iLgLv7Ke0eSRuKYfHQUNNjnYYqDxfHLvFfDnFSLamA6sSZZMAPJlxD7b
 2hcw+oqh1jpP74QVSiETO0k1oBBvNn9gT3ki4KefCB//5HSO099fNQUYJ
 ncTtQaKZDNWZQ1W0xzJ/qO/FAgI5UomyvK7Kfec+Tnlp2oPL7JWDPgMKl w==;
X-CSE-ConnectionGUID: jdmdDnH7QPmExivSk5bENQ==
X-CSE-MsgGUID: qndSRc55Te2smeMDAfFXDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1918677"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1918677"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 07:40:17 -0700
X-CSE-ConnectionGUID: epVarqM3Sayfm+8/9J3pHQ==
X-CSE-MsgGUID: 3MHXibqSSBe/+/gEKQHdTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4809658"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 07:40:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 07:40:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 07:40:16 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 07:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBVLyABi5irwaybxlGLGfRdtmdIagXDimspNYbn1+yREpXmhbDYluS3UYV8R98SM9fBQdYhy0URTn5Mt86BPg4aE9P/5fVMHJVHgpfTv5XftEp/wEWXZWiXUefRYKK6Q/8XmjbL3zdlkeqCG0H31Z5LdIUDYXQj27D2YhNceAe7LfKEoSm99IZ3Od9/xFGNIhlWbEh4zUEULObwP7at9i9RFRTRXtzbqUIg5bZX9YjHlnhbilEDn++G87EN6QoFpG9cT399cMeHEnECJZQM1DvUZod3TgFLR4PSey+iIePgAQCjTY8ZlgRyDLMqQAojPFvMTMOnKasFF+81IcDu2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgJuw/mfFCVljYwNICtGXimhBh3Q+zO/1DIHsclphkI=;
 b=XFX07/stD2EJU2qIKXeBQI4TmyQjzC9oj30yhXnjDEP88f4zr6eYmRQAEFHD4QI2f8qjpWUuOhDwwx25NN4RLG4kvYv3GQuO7jxP/4XGzPi5MrCYDxzSJTXEZkzUUGDqQBR6adzZ71tQR6CctpnbiVPhScfbZgCBCm9uhoLuotztqiwJWS9yv3Sbg0dR0PhPEjJ0gJyWvjf7oaEPsl+PwZZf+LjTlvtwTgzEoI/H+QsYv9o1UiVd8OEvvuAZZ3Vr2jr6966qQx0nE8L/op4U0Aqwfc+zhg61izFqNpd5dID/DvhdiIiTf+XqPuOWcxVlRhQfVUM1cZeGQgHv/feJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB7357.namprd11.prod.outlook.com (2603:10b6:8:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:40:04 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 14:40:01 +0000
Date: Wed, 28 Oct 2026 14:39:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2] net/intel: add 400G link speed support
Message-ID: <auIJO8rokBi4s6oY@bricha3-mobl1.ger.corp.intel.com>
References: <20261028095132.1110128-1-shaiq.wani@intel.com>
 <20261028104351.1116648-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261028104351.1116648-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: bda7ac8b-fdb8-4c78-42a4-08df350158ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261021121427099003|261022105027099003|261021123027099003|261009223027099003|10067099003|56012099006|261026140227099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: sbny3bIrhvLTdzQYW57wxO9deRAtMNiylwzCGLasRLmsngpXUr3mcUBohz5Gxxn1MyGUKECaLY4b0YoptOXcLCTr34pVwWh/0b8dpwX7PcfisaecXsigwQM8LxW3BKbS1wuOIslo8aSjcU+rp0INUePiR4GBf9PLlNWNVdMOa0sJZ70Cqj8tDBioZFWYEhT59tkw0Av1oHqMmIlzPH9LiM8Pye1ZQ0ZnFGLOcV6Qw1FQQPV3jDWcpMgWu0CmQ6SYkyoAjtrJFCdYay4n5pa5clEWQjuEi531l+xP7q4dz12b0LCvFkEPqfj8Qp4EDzpj3msOMq1ty0Ej06QgLObNbhK3koGcBFnqaUREQisApyGQWRjBjKAJnwUHv0jAcAnohnWJmsnBVHWWCvoQYAL42cAS2Gh7dv8SE3arHO2KqzdRbzmwffPrrqDdUYPYnrf1QOFzM6wQ8oZrFJOXgq079YDdqpbXXvjSYwKvSqjHxzfcIAcU7gmhVSvIzLDGzn+RfvL8y7wXqxcRmkiltOsTqa1UZv2prlhO1HTL/gSjelKgJ5cg7i+kmms4s1SVR2XF6VKCvghownqgIGY4QGzJ0WAGyUMKDsvcLuVJrLBIPO0FMubzBdcYER1FlaIQkoie2Vmwg1z8RljZfbgqij2s+NCZUnhP+c9Wp3eBCzYEpNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(10067099003)(56012099006)(261026140227099003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KDeNqmUISWpAXHVwFd59zF1nKEZ23H0ldWMcSvKtceje7IasPRONFF3mwKNy?=
 =?us-ascii?Q?34yxvlqCkGsCJu+0+fWkUVzWLwbomeXvUFn9pLJgoH57vs/PFVdPnjmEEuZq?=
 =?us-ascii?Q?uhqlCsjnELdIohX+9hvPJ7+WrrQ4FpmnAQfBNf9OEBHFN70OGJOaqxpjrODl?=
 =?us-ascii?Q?LrneCVgZMHn0FsKQj/JFrNJq4ICmtiIcazO4m5kmFOpI2eSfdZ9MESx0QcvE?=
 =?us-ascii?Q?mMNertvGiRPbt2Jw5YOBYKtIWnLZL2AiL3gTcMe376GVAjQ1jiIcvHyAJkwr?=
 =?us-ascii?Q?Aw54lX1XDTmk7ALf1dhG8KDw/EczqSnJD1JfKg2l7shCS4zXxihnxMsYDF9J?=
 =?us-ascii?Q?/19os2px6nL44WHR32CBsnLYpuu5f5DXb8b/RYh+W4tbLMFNRq0odUio19mc?=
 =?us-ascii?Q?8Cvl85oxM4rJ+yfS9JD/8pwKdQsvjnUu2/olS84rpcsdeIdPiMSFKCWXZG6Y?=
 =?us-ascii?Q?gcvdTXVQoVC2dQ8THd6HZyQyYlxLwFMBoi/M1w+NdUJ1CKZ6n/Jyz/555cY2?=
 =?us-ascii?Q?SfLsfMEq/7OhWUpj9U2nnYkCHDvfRKSoM1dRvjfaHhifQibKq5gA9ledaZqE?=
 =?us-ascii?Q?THUrS/9xL0qV2ZSLNOaFuCADufN4gMXN0Z90sFJy4aBXYt0ZYrXgZFDi+TP2?=
 =?us-ascii?Q?sEmesJ6uzSIclytv/sRHM9Bfiz4j/S9RWzCHGQNIKdlOU0oYBhWCUWpzjIvd?=
 =?us-ascii?Q?GrpK03s8RogvJft43stRIJBkl/3OVN1jBfimYz2e1VXQrHW+IPHlm8LePXFb?=
 =?us-ascii?Q?TWACg6wmk4UCWa+tiQ+Oh4siThtW6HkTsOrHy7eyAFC+a+R99EreBY9M45hW?=
 =?us-ascii?Q?wcj8pSa1+h0ch9GIUqYbVx6TE0E2BnFQfHiOltqwciM7btmrI6X0hwQ59S3J?=
 =?us-ascii?Q?TNQtWFP8eOhi9v0gbTQG9Q8UxQY6pSAnWJxm1JNNIftLSItgKwu8bn2EolHj?=
 =?us-ascii?Q?jKqWE88clWHZNexIJ5ZwwmWmXtlQMeycw0ayibRewTQinEOcnJcpB6USsd3o?=
 =?us-ascii?Q?6epGK5hRMvFu/5f5Mlse+8MuJezH3EIFo8czeZ5Z5e1v9pDovnBBe1AugyeB?=
 =?us-ascii?Q?Tj9FpRMvGk7Z8pRwAMVRA+iav/0gmsF7QbHDAtGm/fgRlxwl0OsoE+kiYGCH?=
 =?us-ascii?Q?jq7eR2sPbbDQChpPyF71spKKLTy9z0fnre1jVc+jDV9LEKKTIf0nt/Yae03n?=
 =?us-ascii?Q?Gdh2JvQ1qYHgqQ34NdvNy9m4BAK7Ks1PCgrhJNArE1XLVJMqX9wH09bFfBbm?=
 =?us-ascii?Q?+CpcPk6F3JXPCjgbhSJMAM3KH1DchudJyza0WQoC0H6hhyYIWRp0u5KT8f5H?=
 =?us-ascii?Q?AZxfn6lzRPJVA3AdqPBsIGBq7ITD/tw4vvHIPoXz6piVPNuKuOSXS1ccCFVB?=
 =?us-ascii?Q?aioNyqaiQU1ibdFyWLpZcULNoeFIn+Mzasdg2QRd8wqVDwIhqPIdGUl2Leau?=
 =?us-ascii?Q?FKFFAxkQwt5nqLG9DFnQ6697/HwCYYdDY0xjM9YnEfz0ibRKKl0MOnNayT1s?=
 =?us-ascii?Q?lknuuO/SBYDADacxq7y0FyT3UHFCUvnnNRAWnV2P1CCgPm4X2Gl9tbNxYofb?=
 =?us-ascii?Q?o+Goq7dsPeExYuOTlxVtwRAfDQaeS0DOEelzmkp9BtNnhEqssrNjL6uuJQc/?=
 =?us-ascii?Q?DFnQCYjVKXgt9eutKatEBQYs2G34L4XVVRUdtv0eOrU47za3Ok39AKumLLvs?=
 =?us-ascii?Q?XWmH0WUmaHQ/+6qPfXo9khAzlY6eBi4NCsch6vtBgsBfMkwdHx161d/QcuEv?=
 =?us-ascii?Q?hHwunnn3KQYUyZmStTlhkzFizo5Z1JQ=3D?=
X-Exchange-RoutingPolicyChecked: 4duN1F+Sj6rQC19dHpZdao2QHc2el3Ap8L53SHS4vuYhn+U84rNUp1iicCbYlBpkV4R8XevzlgyHNtqK9sqojNIoGsQ4qXEoRCAhwFX5nxsWfKYPkb4rc47Qo+rE1qKtLOwmxcohnVBe9WXoIP5ff47pVwMYxm1Ylq3EQa903xtOr+tSZ9nRxUgKAxLRecHdqn7w3OPkceZoKOF/V/CLeA3J5U/hHNg6DKWwI+JR800Te/DJrI7AXZjipPa3yxyFcPEKxUCNxBlGBY/vIbRieStrvHZpGoPUhxay/onVezfluACHMkTyaCAhglv/y9WUSJD56yYQv9bnLL8SyLy6Vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bda7ac8b-fdb8-4c78-42a4-08df350158ef
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:40:01.6066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKq9UVv4PJFauc6ZTnX32VAkHnwSPX+B6dZFuD4F82LhUYPG0s4sweWmSX1X+1BmQVOF5UrBphxZczDBETwxC+OASJcZk8WUu7x8c8eh9MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7357
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 04:13:51PM +0530, Shaiq Wani wrote:
> The idpf and cpfl PMDs map the device-reported link speed (in Mbps)
> against a fixed table of supported speeds. That table stopped at 200G,
> so ports operating at 400G reported their link speed as "Unknown":
> the advertised 400000 Mbps had no matching entry in the driver's
> supported-speeds table and the link update fell back to
> RTE_ETH_SPEED_NUM_UNKNOWN.
> 
> Add RTE_ETH_SPEED_NUM_400G to the supported-speeds table of both the
> idpf and cpfl drivers so the correct 400 Gbps link speed is reported.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> v2:
>  - add trailing comma after the last array entry making later additions easier.
>  - also add the 400G entry to the cpfl driver.
> 
>  drivers/net/intel/cpfl/cpfl_ethdev.c | 3 ++-
>  drivers/net/intel/idpf/idpf_ethdev.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel.
Thanks,
/Bruce
