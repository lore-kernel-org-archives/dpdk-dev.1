Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CDEC531F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 17:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2438340658;
	Thu, 23 Jul 2026 19:26:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3927040280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 19:26:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784827602; x=1816363602;
 h=date:from:to:subject:message-id:mime-version;
 bh=ibdIEzSHPv2WWWrhTmhDnnEiN0F5l8aaJM1ioa9USb4=;
 b=LsJURes4OaEjviGtsMHvLruh2QJG787nc63kIg3AwlBZp+rll1tBpFiM
 4Y1VPQGUgl36r4jiMgDyRQYN/xYh/5zISXX0qwr4VbDMJ6aDAPIydnqix
 Nsp5UJ+YVe2WzJMgbH9TQK7ReMo8BL8YpAERL2+nCRLooSCYcSqNBd8uu
 rO279ulvtuVmszax0e4KQD4wQI8iklfhXqcM5ySxkvVTVzPgEf1v2S6Vq
 bpnxyH5aQb0jAdlvrIc5G6w99s+B8pb75jYMYqUJjG42nP4XbTTHZ4SDS
 9DYPb4UaMphngKcOLZsAK5AP8p1tdgl4jOU0ln/F3S1WnwDXLQ8jv2nIm A==;
X-CSE-ConnectionGUID: GdV7OXc3QbCVskwGQzFQdQ==
X-CSE-MsgGUID: Z6TFLFIFS4SmXI/sdmui6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="97005615"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="97005615"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 10:26:40 -0700
X-CSE-ConnectionGUID: rJMSt+0ISk6rxQjhm7bWCg==
X-CSE-MsgGUID: YvF8kpy0QqyLci+KUHnB6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="263439020"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 10:26:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 10:26:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 10:26:39 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 10:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH5ANP6hlNXAYJYFND0lT8G26EW9/QE/vqN/aIoc4gA/Dz2LJ/mKZWRew49a9Qdi7b7VbOsQ0EJ1Qycw/Fx3q8xb76xfi5wl/w7aazov7VG84MIeuRzfjCY29I111tsvJcE2rkEwDeJlcIeDo9SRXAvWKWlqkchNa8441CdV1XPfxOE8sax9wmZrcc2VzErXNYRUgPXvMZZX02S2OLNDcImRIirAiYr3JYW2rn0cP2/bmW3l2e5iPif1WaxQmQHhdCBu3rJbJKMz23JSXVd/vsFVqUoKxIhlAP/V9SJHKJ6R7rGoldd/8e8ewvCNXQdPrVUgm46JMscytir3VUo7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck3MUmcQBKyGmtsBczp1HddJ6dyMD6tqK49RaTwR/ac=;
 b=RUsXZZbmVqABjyxeuQ69DpKz4yd3/raQpIC3sj10zYDSG/MKea+yRmoSB0an0uOfe98z4ym3Ud57QWi7Yc2TOYQlQmgj4NmAr49csMuyd+NqXWxGmcHTd8GxC/HQ6mrEzsq04G6yo+FLRakQ1MuaQUq/7L6fqs+cjLw4YiH2uwzOa1iu/NMmQ8t5wR0nqrv6lp7t4p9fmEsHwTAM1RNESW92ogWbXif2yzJ87/LwRox77XOmN+Yh0+ktfj0TejEOTRQg+0A2SBFDR/MqSn5YIkwzXRWefLYjRhaW1O9s9HRo15u4BlCfx3Q80JEy8gg84Y7oMjdvMOf2wGFzRJD+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA3PR11MB9014.namprd11.prod.outlook.com (2603:10b6:208:583::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 17:26:33 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 17:26:31 +0000
Date: Thu, 23 Jul 2026 18:26:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Minutes of Technical Board Meeting, 2026-07-22
Message-ID: <amJOxBOjChh7AmJG@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA3PR11MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: a69ba54c-cfb2-4ded-cb38-08dee8df8983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: YG91Q9WgQ6b/26PhovPrPEwuvBDp+p6zkV7sFYqbV7OEilvnxF0ElCjV6r9P5RBq6zDl3CeZT8F0Ps+ZdJSfnMJ8RKQLKqonfZsKMg/EakdpZVKECZQGPFEqvuAkFbk7enSSAjzaq40Gf7EuHj82TINejb9roqY+MFV5jk3G/kbHzGS6J2MlI4rU1nznehkj1xi6ZBDotdVZPMywNJYwISGrTTvFCvvX6HhFyBnX28JRFgM5PEOFJcshcus5D/JtEDuVixM9Vl43PRWFfdFUagO/kuNwfpAa+VOuDKYfJuoZbQ7nFz3fjFRwWNXEBPnizXV2cIBBRPuMqXJb2dGDGD/rAwkYWGqduoEs4S+fy/NcONfNOwGifVS8rm3tIZ0mm23w44Rc8E21EyP+SGg6XcnWcUyBAUg5AgVSr2Tef1rZDFkOiYRs255YIYtykxubhtmiX9poyQuz3i9VmFJJO1Cacwy7b0Hf1pqtXvImHJd+TVYzajgCs0d5iRmxz8rPYpBIcAXKECoURiiH//NUKnTS/kss7jgX0f/JeVpJuVmMnfH2VvbW8xG019gva526pDlIBe8n39iMjRgADUL2FhIH2cdql6ZtUIAR0x5I378xdsKHh1hSJxYfPch/g2cRN7nZXZt2J5dnoKVSYX2hgF0qGya99qhp/yxB//eWhZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5Rsa47xpflCcsCqC2m2B3Csk165y8a6CoJg3I0X/WYEY6FsFpSzlbkctxFX?=
 =?us-ascii?Q?Ym273UwgRJmevIePPvvprAkys8Oi2mPqpn9jkrrmQvveTM4US7Vim/kC0/ob?=
 =?us-ascii?Q?qbnO7lizwlw7XdF1ZQ95XR727AhlTTihMHmE6TqnBpmA2yK0bPnE85Y6s7e7?=
 =?us-ascii?Q?pSSDPmtKZg804nmodvNlj+YbX5CheSymNie+D5I4iDON1JGuGIILgsNyBf7q?=
 =?us-ascii?Q?J167Gada1noWJIOAg7cAS+7rxv1kYrexApuWnNEgR1lpkfhYXhTC0mVFps4k?=
 =?us-ascii?Q?7eZEqvxojvVkzlGwLNVpfLSM+U7lFIwJk7UZX1hU9ftl+727TE7SkRNCUCDx?=
 =?us-ascii?Q?EECCBdSCjJmcAlWIN0FqJmxJsLRAFsaC0BmUzu+XAMI7Xt+whDPHSldx8aGk?=
 =?us-ascii?Q?VCMrkhJG5bKpNom5pU3CTo4nItY7AjoGRD7hKQ3t4qgDohyXWkdid3LRg36R?=
 =?us-ascii?Q?rXBfC/YAQleXZHVjDg/yaGtqAiLEwCt72nx5uCwggZ9QhIsGSsFE68zbuecp?=
 =?us-ascii?Q?DhfiRKi2JSeY//9JlejgrXnw3kNqusZ1eDx2kx4wOxxnnlfy/6nP97ynluOk?=
 =?us-ascii?Q?nBz8LeZf/zVA80coRbT+ZDNL6OZ44VHFW7u/tn0LQz5sz6Qxjlwdgwapg0NI?=
 =?us-ascii?Q?zO5yJAIIv9UDn78dy4silrsDxqDBQzf3EfvGyLonPtIXgX6Glimw4ZpAAz6K?=
 =?us-ascii?Q?vXxBXiXhVd9D5trVfWycsA73gUvs2UaFR45qDj3ZChp/XvKXtk0vC1TislBw?=
 =?us-ascii?Q?JMDRr0Ipxvc09RzReY6i8CA6gzo0ZKrh2T+lgJ4kJJhmv+mBG8kqyja5ehOL?=
 =?us-ascii?Q?uiSY+gKgGvbDQj3gWIOiZG7kpa+j9KOcasKfTwhNCr9YlvlRvKOgZWIENH91?=
 =?us-ascii?Q?HSaXtO8Z4jNQ96UT/iC2xd/XIo/hPz8yRS+EzBr340RLT/9SZG3950QB4q0R?=
 =?us-ascii?Q?rz+3HFWZkXFX2hhsQVWTR+AZrBl3T1EzzIEPJFKOEQOhie+B2pfeOZOmjfl/?=
 =?us-ascii?Q?BXzv8dvHrsL5J3rRdCJLyH9zYPo6U1nyM0Im1THF2MF1fffrUb0enWGHhpLI?=
 =?us-ascii?Q?bHARzjiOLptJBbp5NzRS9+Otu2Cjr60zOBHuAKmyTNbY+AUxPhLRoPZJkrAY?=
 =?us-ascii?Q?6lNlRDybs3xPHDOIk+pi9rNBC8G/sS6IxW+9DVz9eEMyK4uxYD0o5SF2cfCq?=
 =?us-ascii?Q?JzXZtEjvTrk1u+RIjim93FWxjMg+HvZd/EIFOIeGu0u7Uc6+vzBR7pcBYnYe?=
 =?us-ascii?Q?PRghe8FE4039hwgNgtSH954I+AGkEbplj2PPrx22VuuVSm4pmil5xhI5E4fy?=
 =?us-ascii?Q?hV097x+cNtmWjTMmkjEqBZXCJTBUpfpyh9FzGdUFH+DUP9rf+ei6aoX5RBMO?=
 =?us-ascii?Q?sRd+IQzqr+kcOuZsfZFwfab+TIWAM2uOVbge/jdoh3FUDRBh2SB2/V8JHT8I?=
 =?us-ascii?Q?OBZTGZ7EO3yzxMAeO9NdLXXFgNGbgW73ONjpZB9r+KC4OZuobQaodbuCg7lb?=
 =?us-ascii?Q?HUcfoeSj9K895NEY5FH6IgzR5YuMXwEVMSXNLY0mmXgsc6oZZDOB8+V9szEM?=
 =?us-ascii?Q?VLxpS3WgeyqYkxpChT9kQ/ZAivrZUx4BioA9w9dyHOQj3lQeZxMzcShvtOE9?=
 =?us-ascii?Q?O0/jbhaXnedij6gKL4v1Hjo5Hnke1vRu+Mlh3g2l/3ewRQaLpX+XSS/kOvvL?=
 =?us-ascii?Q?cXxkeTvd5ytUwOCKTTWK2ivo6rfoMgxT7OLEiMnpDAim6pNtjrnFdVUakxht?=
 =?us-ascii?Q?iLK2cI4PB93uNYJMro540YtVeAUHuok=3D?=
X-Exchange-RoutingPolicyChecked: fMSGotBwdm2gHY0xXedR+7Dl3x3ydxvDa9f3TFefA9PyrzhLGaz3ZUrr/8/Ri7Cy3e4QGlIBWzLQUv01HLH3moWc+wx1cSbQJKeniOfl7lGF2VNPrbSLGbJM0ql0pTrdpzCK6PqXIqMDgDcyF3KJw7/5PQdtIssf9HZUixRmslrenv5geszL6SNXFWpHEZ5vTk2qE+BtMdGiM9KQNPIxPd7inybf+KaCOmmAgulu1/tobf8zW8DwoTkW+URAJev465gKkXwxCF3ny0Mri9fIKbt2gnwNWnFcAqSDgRSkjlfvwJuw8eTYi8J6tOphGwJ0ysqocka7PdTKdRPn+E1Cdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a69ba54c-cfb2-4ded-cb38-08dee8df8983
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 17:26:31.6839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwQaaNBePU8bjtJqYHf3WJnj2RhPFMbUUAHAc2zBnudXdWHjCA5F+KmwLApvZQPCj1+pPqmGuSK3i4kXD+QCmGVRDzRyI7hB1z9NqBoU7xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9014
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

Techboard meeting was brief, due to a low attendance because of holidays.

NOTE: Next techboard meeting due on 5th August has been CANCELLED because
many TB members will be available.

Next meeting will be on Wednesday 19th August.

Agenda
------

No discussion as such. A number of updates were given:

* Thomas provided an update on the 26.07 release:
  - Code has been tagged
  - Release will be generally available later today
* There are discussions ongoing, including with LF from legal side, about a
  potential new CI system for Grout project
  - Expectation is that systems in a lab will be provided for the CI work
  - Not directly relevant to main DPDK, but to wider project and
    ecosystem - Grout specifically.
  - More details will be available once it is all finalized
* For DPDK CI, David gave a reminder that for 26.11 release cycle, ABI checks
  are not required
  - Lincoln reported that his team was already aware of this and prepared to 
    disable the checks
* Aaron reported that he is investigating getting help for DPDK in managing
  security reports
  - University of Massachusetts has expertise in this area
  - Investigating if we can get budget to get some students in the security
    area to provide help to DPDK project.

