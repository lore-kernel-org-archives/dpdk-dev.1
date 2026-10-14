Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A35DC3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:36:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DB4040272;
	Wed, 14 Oct 2026 18:36:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 002DB40144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791995795; x=1823531795;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kXhYYgGY0L9+V0WcmKZl2lz2Qgs0/wek6S4zTWOHYXk=;
 b=c5i9W3PtMvsVcu2B71CvhkNCSUkqEg5FA0RjUY7u4u7jzRg4GZbDD8vB
 0z6dij9KuIVESKS71c6ao4jyh2e/P9HfC6qgA1FARCoxlZHCc4cVe1tPy
 PPoGyzpX5yNjSjmJkosQ0oa6DWp3tWAghjmF5vqbc63Oqk/EDIPvEdMbo
 gx2SdFPvzKM7YzGfhntyjqXpQaYVWiyKzFvof9kDkTsqQUU/M3gR3yoUZ
 5jIxrdst/w7r1NgKLLElpixsC+rhYULzKN5Cq6nkzD4J/leCe4utDcm/g
 WMjxi7f8eU8Qi8hqaLzoXlYI5Yrbuvv0alK3+XHgJWw67Vwqa2kLor9y+ Q==;
X-CSE-ConnectionGUID: aQY3wNBcTxCk1EbpW9lbwQ==
X-CSE-MsgGUID: MH7Hu8odQ6uZBdsX1DIW0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767904"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767904"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 09:36:34 -0700
X-CSE-ConnectionGUID: HhLojTJzSHiKL974LYNH0Q==
X-CSE-MsgGUID: 755gxsFASkqJVp+VeALPzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1359177"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 09:36:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 09:36:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 09:36:33 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 09:36:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJX9RYQLB1ziCORxoz7wZOBoHk829D2Xb3CjQbOK5cbYKpdh8coi6Y29gPsKBmnTt2EvL3h0AF2dZ+zeF4oNzvolwpXa66RJc/HgzagMGNo5UZsmVs1p2upFSj75jBplyQT833J5nbfmyJec/l6PtV+7eazW6zvU/09JDYAhABgS8ZAHuU3WoG1Fxv/OACRyFF8w47KK5RTHIV+iE7CvGygE2XMRQ83xQ+30gQnHph/8RdCOaTpnqSLoIYAU14pL2A5gY504hKlU8A4BsV7TwIDD6V/P204/1GHTOTsrDaP+1w2p7f99H7QA2J/G6RXbZDYH/9/7UPkT2f7xci8T5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1icRffJ0FLDVhiveFVySmg0hSsdrJgm7b0ufz46bx0=;
 b=VJl0D7P9HijGm+VMRcbV6Z2AR/R5IjPPfViSPww+47GgWYTrxNxgWagK3Nm8/j70YyL5KQQhl3rx/exxCLNMjE/ljS+9HIIJ6cSatxBD6HZQPBqZMXIODhAaqD0skPBlzdn7hMGEFzkwX29Ob4wGU1CAbPTIyyQ0p30+03oxkkDLBWuhXAC/q886pdig3GBIZxpF1HOeDY8GqgFlNcUGKJ0Hj4xWytTc14vsg37FXoG7XKheDusQFC1mIgVlPWKBF0c9GLSdBrg4Xj7K2SQXBw7gQDOBe212ron0afotLRGHh69hEzBC0bwcsYshYXUXJ77JVKMyCKP3zWhva1qkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 16:36:30 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:36:30 +0000
Date: Wed, 14 Oct 2026 17:36:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <gmuthukrishn@marvell.com>, <gakhil@marvell.com>, "Maxime
 Coquelin" <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: Re: [PATCH] vhost: make cryptodev support optional
Message-ID: <as-viUuNpodj37AJ@bricha3-mobl1.ger.corp.intel.com>
References: <20261014163138.1639970-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014163138.1639970-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU6P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::25) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffd4882-83b8-44c4-4707-08df2a114cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9Pu+4XuXyq0d857aQVWIkmEDXUHKjZeIZFTyYhPlFLaB3LM9KdhgnyfHBfbYcAcHVWaXy2FImoZIYdM0A5p5YpRIdkin6fh3f29/J3RPYs9489WBMSTnrvSuXosEGOaqF6L0IXA/rC5wHp5X1r9mcsEIGWEKsgO8h3D1hIJHFyLoRe0w6vWI2YxMLH5h/Chf04kYFfhBRyiypl3wo7RC5qW2Z2P9mejRWknxxvoSuprbE825Tgv6LxBi4qk2Me0t6VR0zz7EPaRknofuoJNsEwuW5xpAkd1ueHNI50cFNQiMSCFB7rdSE8pZvj3nt9zBTRKZApC8Ocym3/zshELwEl7tva3aFAK0AyDTfPpad+whBACT+AZ7uapGvy+2z479mvlJWGoc55v2+74M8Tjc3P6O+/tDNlpO+3OTtrec++vD/FqnBgGHSIK0ypBLB/T1OPNASEA9Ioy9wDC+3wn3KYqNV6rnEcoV9AvnssYqAZMOtWdWnQCejIcBpe1v9qGl9MRuv3h1+Fv55eZmjC8zH73Lg1hYVGcYIFeDfl+wMbboUw5TUSe8zE7c2e4IPqF+w4ML1GyNU72OGkdpOxAR3xy0q05fUut6uDXueqsmAAKlT8z/CUzSjcU6G020XKT7dlhwbYA0HSf5PssReud4kXM+o60c9T0qdtHR21HK3gU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c8uwmpcqlgIKUF2ZG4F7fEuBhYBOsW+37OFPAtpTp2NhGCOncGIc52dPwW4s?=
 =?us-ascii?Q?e5tIUNiXkfm7ftzo6hPe9VpWX4vSl/ZTG/pXXtPBXkXKX4Om4/ekKXYpt4lL?=
 =?us-ascii?Q?vTRqc3ZsRr503fiSzfB336G0J/ZPyFWlp66sb3wlffYmcbBk6tH2j65zJXgq?=
 =?us-ascii?Q?eCEy2nLGLv74jXM80H9bDdVLQNozwR7AqBgBKa7CaZtci93znMSO7EgKEUZm?=
 =?us-ascii?Q?RzRboLQ9D9zbsrj7CF4gzw0hG0AdGVh4zhYa0lP9FNXBQ++LtzuUHr9fKkAo?=
 =?us-ascii?Q?+ZZuROw41dz2Uy9utgtZe6jx102jUd063MaN6sjULdPNYgvHwHhpqFWohZk3?=
 =?us-ascii?Q?DEJPTBA8GEuLS4tuam4RoIIbLChX/o4nKJCY/W3gLWnI0xu5yhXYXzD2rfx+?=
 =?us-ascii?Q?N5sE+lZT8zYaTn3AxF4aw1ShvC3/5QHXiIjcCMSLwmjf5erl3Y6W6IHrGnDF?=
 =?us-ascii?Q?6nTQPGgq0tUp1ZUH+Jiy5QxBG9ulH9k5TT7KMBYAj2A6E8FCC7suQAZ29kIH?=
 =?us-ascii?Q?gcbWsY7fgCn1VgdXQYABWbXlWgIMTb+ic5RpQ0uPETBkRaxDrZ8G/eaeDaiM?=
 =?us-ascii?Q?g4xD3nSoGW1RWb0Y/+KgSItEcUW/b+8LEf72c+c7m/eL91YGatTPP0/Vpgti?=
 =?us-ascii?Q?bpmwifXEgy9NCUoBs1V5VR4XMpdtAJPY0G4IwLuSH6MSUu1uxp5z2Ome5yG2?=
 =?us-ascii?Q?IKdipBARAEOLHVvCkB5xZVDZIUswnv2bE/Ia5sstq0bFoD8PQ0otjmo3aFjV?=
 =?us-ascii?Q?mtVyGYtTcHbp5vLme6wlD6YgXFAj1yJPuFFtFaDl7cxUfcserQT3K38Klpmh?=
 =?us-ascii?Q?A6qqjUzD3YPWgDg4UyZFWS/5P3X/kNdOcpelFmEvWsTghe3CRZJI8P15EYAX?=
 =?us-ascii?Q?TzNMyglshnM3iiRfkEFJcD/noBm4mcFfNr/psCHwbRRTiAg0kb2cjk7sJaEg?=
 =?us-ascii?Q?xZo39duZfEKCdGp/c4o/OySnL7p3LoXSx3/dFS6skJhWs3s5WzklnTdEcOuS?=
 =?us-ascii?Q?nwbt1jBTDYF4pEe2YoEdgdTvqmAlfrxj7JFpu3mLXrvq7nmizS96wQIqRmsn?=
 =?us-ascii?Q?abbNbnHJ1PC5DHVDj7tHjT5HMw5Q0rmdVOCnDoyMY35tqUQs2HBZQE3mxadT?=
 =?us-ascii?Q?+i0nTefl8J2k39/Zi6QEs8vRlZDwVJv1LZ4It7EItJr3uNNLQa2EQzRpZhE4?=
 =?us-ascii?Q?pUBftw/r8+8rgjT9PZGllRSmfElNuxlH0HimAtk95aS3DlQqzbmfMWZ2Jdnh?=
 =?us-ascii?Q?w/xtiXLFzMXdPwDQK3OxUVf+7Pxvd68KGcuhID9pgv8hUvjAlRZGg4CgLELF?=
 =?us-ascii?Q?rPMHzfv3qCOwgTjEubNSPE8C+9hwLyvS2pLj8bH4HbM4E9HvRHjvOUKJBw+l?=
 =?us-ascii?Q?bjXVuOW6nPEeS4hAG7fNQN+Kr8ChqImGETTzOlqmotxsaRKm7h6HTUm9EZQY?=
 =?us-ascii?Q?pea2gN0Z01MeNehahivF4msh93CAWCPqj5FtyC3VPrKi4TRtl9qWwqLdij4A?=
 =?us-ascii?Q?nx145DbqJF8zZvKNMP6FgBNxxm95GfLx9NudBySBj6qdeIUpJbugLIArUc25?=
 =?us-ascii?Q?EZ0c9N3WvM8E9lBXFCyNmqQYxaSztTDfD1v1zLgVKV1eShWdI2dFQhBPgbFn?=
 =?us-ascii?Q?oT9HiI1zgNQHycE6RkC94wy7+QPb7L4lcWSsHtsbO67tiJP8zCfxWxUJ3h7T?=
 =?us-ascii?Q?dYwCWEbfwV3WD7fnaEA4VBIt476PgyNFu5/5xKg+zNFPJaZN6+6xAKAwgHkt?=
 =?us-ascii?Q?LTUbNR+697qlpywuJEmlqZBJc8FhYmM=3D?=
X-Exchange-RoutingPolicyChecked: 2dSDjKgxeNC1LFint4L4wkKWfDrpqMJTc5CfVQ/tY5w/ZpFtL5JXqSK1bdgJjc9IckkFAaxnb6DlU4b6zFN13a4V4IP2eFNuyTKMCXeOmm0nV73BOx0cmB1oGvmToYM+ga1yTEjh48OJtgUp5L7N/iBjHs7fzTNV/tH/AoDAD8wa+pUjSwehvH1/JmhX+4bK6WzTd4PCenf6oGqKbEZenmcnsbd18Ico/vxbScYYj1copXAWpB7X9hm2izQX25Pq7GnRsOv1zT7swTFbrCTTA3bSBH3iWSTr6Fplaz/aha9i2UezsWuBxmuDT9PFIx8BEY+evrvy5bl9/5TXHNmlxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffd4882-83b8-44c4-4707-08df2a114cd1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:36:30.3131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkTzcfvoTSjRXTZj/wjWMYrj37J5hdkVhfp7FLY3HIcNwGVhO3aUxuQ548c65ZK3f7Dk49etMJe/cXRSU3CWu4sAWZBjaH9ECp7jnIH7H3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
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

On Wed, Oct 14, 2026 at 06:31:38PM +0200, David Marchand wrote:
> The vhost crypto part has seen CVEs in the past and is getting a lot of
> eyes those days.
> 
> Contrary to the vhost async datapath code, the cryptodev code seems to
> have active contributors, so dropping this code does not seem a good
> thing.
> 
> This change here allows to keep this support, yet disable it for
> uninterested parties.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
