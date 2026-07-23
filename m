Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98976C531CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:31:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A255540663;
	Thu, 23 Jul 2026 15:31:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9AC0140274
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784813472; x=1816349472;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qu2ru6RIE2qdBLtEVF9vvl3ucuNHOdt7ytvhtE+ct2M=;
 b=CsTEEVYQ8YNjwK6APJ4IL634Y8a5uHDcIXcfMD5poVzBRwtzuNdliUko
 qPW9ICTh5a3yZJaXQjQHGLCMOnF8F2603br/SCOClD9FwhRvdMhwqionq
 b2bAG6c+pncO5UOMA+74kb9L3OZ1sIHuv5wTf71lBrglJByjVyPKJp5eH
 XIacmpKyG3fqlcBUruldK3wRCsnFePTmzX0QpyWk8SJ4VXGmPBkMPjyBj
 4j57Vgn0LJjmlDCoVnh5BIJRoacI7twEf9R8GMY4aci/GKtNC1uODDAiL
 PczzJUKFU0xAK9hTXDO++qJUEy5NGofOSSFs4/ZEAQB2WH2vjfuUhiOKN g==;
X-CSE-ConnectionGUID: jKlRsX7JSxm3eRl1z/mPgQ==
X-CSE-MsgGUID: gOH8hKk7SuGazL4JxWDHQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96056508"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="96056508"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 06:31:10 -0700
X-CSE-ConnectionGUID: 5SnoXzuGSS6MJZ1zEWNi4g==
X-CSE-MsgGUID: zYiXfJclQDyzU0koCFC4Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="258479445"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 06:31:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 06:31:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 06:31:09 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 06:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah26nx/WLe+kB6zc8m0vJ7AdUflAmSkBOBxMFRqzGAsTmMwKlU0A49v54QmEtU55QxygiKXzOk6E5SULCMbMw4GUuC1Rrd6wC26qfRPCnH3A8YEWaEy7TFk4lpHbe5NwcCpqQED4SJ2xhNnnw85/LjQAmezSKly3cmuyhgMAJfk1b1I62DZ/awA9HzWOSUk/vKCUN70Hb/r/cj/qEBGYEwjT2G32WnZSfPs/VSTbJ51enLIyJDPciryuKQrlzJ0L8EJ/n+Cn2OsvljwtaMyHWj9MY8xx8xirER/qDUQBjJ8StkwIFZeg2Wpg3aK+WigxONXtplKuVlcE9Y3xNYSAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO7PIwRKDh6NcWsMomBzpzXAu5P/L+79H0PplzrcoiI=;
 b=RNGpkHvQPUeqIRTJ+0ekglfCAmN06u6eTwQ/FKWtXsME3tAHvuk5YmPcm1BJUNkiuPemYNK002zF0s6GQXOc1oYsC8rjk0W6BAJ/wmZub3Rr8hRY2xnheOnUZkFgO4Xwz9zGcCvZSPuy1tMpuh+Jq0NnRh1TAoOpLVgWZibcrSFBugO9WdF3NiIz/sGPE68QOTFznf9hhXeKeJx8elkxl3XZ7CB6jb/atd2tiQ/5h2F70np5iCvczTh4SiNBGz9uFWdpSYSzW6VfGysrt8mzQ1x7ZmQfB5FKxkQeQ36R8RXpnNOznDNFeVQ2TcsoUS+95GLw4tHdOr5PhTNAtad0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 13:31:01 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:31:01 +0000
Date: Thu, 23 Jul 2026 14:30:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>
Subject: Re: [PATCH v2 4/9] test/bonding: get MAC address with public API
Message-ID: <amIXka9QJRka28RB@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
 <20260723125559.3087579-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723125559.3087579-5-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0253.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MN2PR11MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4ffbde-29db-4553-f6d8-08dee8bea364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DPOajx43O00WWOu8xzgf4W6m+EJyH7Qg7CrX3reIXoriTTtirRKW8CWmiQ6gORTFXP5YmYwic+KBVTq6cfTUP/QIFZYOTOwmnb2KBYr1+A/+CAGSKNlIO7qX6Rb4fJFC22065bVjb6ld17174iSQLZNSCI3JYa5ZhQXesHbPzSONBleqpikt0KfZShdQs8soFCKl6xWYyKaVbKTqdKIBbJLI/7cXw6oy5etjP0zi+LTHuIKWyay8QoFbjFDcx9XseyOPQ20Y35w1YeWfmgCgaO7tKAUHq/JP5Y9i90VmC7cH1tS1k8J5IrMZJZW28mC7EmGDWx3FeA/IzyQjXr53nlHrBCBGEp3clrIAZsYaEUHcBqhTox5b7R8CAwvg2Tc3mKbSd4cwJs3MbCI+wcTcx/b0Dfhk9i7d4dw4m3WF/fVZPOsrhIunnl0YTwTcx3brySaQq8IQaTtUxK4lHZXO1GHEaDnvh2FS8xvoz0sDISsZ7J+v3CwMjrfVoya0VHgD1oyekXDz80la9XfdUjdMC59dHqje7mUnHOoVJpUE//i5mSXPDfuomfrMwOGyb+6t0aAIDooRU/a2B9u/SHNQRI4bKRNtgn33cQjcs84EGUoF4RvDdX3Hm2foaA2AFtgeAg6+NElR+GMzcx7dgm1s7TSlAQ6obPX1HpreNBF5thE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XSYE1low+h6ogMVjd//hV8mAWXwTukgJbKyIFPU8MigJTR0+0Q2NcVQsmW5+?=
 =?us-ascii?Q?O9G1fgA3eacBUZTP3nc65/vctr+rBvzAKqV7hISEV/EGtOUnR9gsCXHM1Rvh?=
 =?us-ascii?Q?5PtX/Lo2PMGG/LgEQMfV9+rnYgO76+kwjitC+eBqctsM0oscJrjITFdMFq6Z?=
 =?us-ascii?Q?nLvl4oe2j1eRGq+Eqs8rkWccWzl3okM60Fr5U1jXzbzk7ESjLpU0PEg95oEE?=
 =?us-ascii?Q?MBX3C/KHu5Kg+bt9hisszrBq2rV0u6kbAT0rGqrWmiqOZu/DRZnrBgeEBisa?=
 =?us-ascii?Q?HVQmLco0O644bCsY6k8qsfKxOthXevhYjEss7Z4L5AfgNRk/t/39fOx1Fh6C?=
 =?us-ascii?Q?VjeyXcfXo1OdyJeoUNFwyffxl4WdYJYZKMdxDPhBAjc7emtRcsKzdpemy70c?=
 =?us-ascii?Q?vnVdwXDcGKIgUjQIbmxxbItVKnPGscnoCGMJJaejTSVBrvYAvN6mEjNGKaa1?=
 =?us-ascii?Q?/97X9Ds/yJQ5ondz+TCZzKlXppYIiL9HwK3HSg6y4lrDN/b5QYLJP2avEMOj?=
 =?us-ascii?Q?2LWNxkLYSa79Tnhjv5ZKbcQg0o4373hkQAP9C8H7fpjafMmbGvwe9muFHTlv?=
 =?us-ascii?Q?01M9TtgavHV+MuIhianUdlTWsXXXjznmrTJp5hyLNIMx+MMhudP3skku+B4S?=
 =?us-ascii?Q?lf8XY4XnnTg0pQV/y1iL8c5I1jBu1r2aMLpWwH2UkdYm4XgY0v3TR4N9zDlO?=
 =?us-ascii?Q?EDVJdsto8pRvpoad2ViHhQnMAqnZChF9WLN/FYEIGiOyCJwUpM7qSzZnHUAx?=
 =?us-ascii?Q?rz8lH6wIKbDaZt5dENTkcrxCJsT5hbYQa7P7+IvKZfRuETxR2G3bIZ++gaKk?=
 =?us-ascii?Q?W7Zrz+ak3CM2PiP/LMLJcpbOy0I4UpD9k3UakDvjFgaE6bK6lft77oN5ZT7c?=
 =?us-ascii?Q?KWJbBwsdbfqI92D19BQJ8nRtRUMCBe2Q8idgELNLEp6LfctPkG8xUzevbPzz?=
 =?us-ascii?Q?cBRqcTcI2JrQaH68Sd+6J7XY2bD2xKIIKdgrlkFciBa7iNxQFmpDGFg0Ouj5?=
 =?us-ascii?Q?zfYs9nYPF4k8s0IdTo+VEukCaPJTdnaO0WMlMZEylQofM26jtXocUiaqxGvr?=
 =?us-ascii?Q?J1sASMDxZzt+H1pdMmFRBTKlp2KUBRizs4O0Ha68dTFlbJ8gBI6jfKGx7IAd?=
 =?us-ascii?Q?v6FCUIcKqAbZ3T+6FIVLRRaHQf80rL/DK+TjgcrPOtySRg9YmYPPu3qWWihm?=
 =?us-ascii?Q?OW36d9edFhGHovuoFhuLFozZyRRK4rxzUL0bQuEMmNeMO07DRBBd3KcfuBNU?=
 =?us-ascii?Q?cQJQmda0NDpK0a7io7nWVOhftidNpw8890qnKy7jSQCxi16XQx0FezvzLpv1?=
 =?us-ascii?Q?qNtoOxA8betQgFWxjmH6fWz8kdHhCs7/2Q4sUc9zj/VIacUz7pX3gjNOpZrk?=
 =?us-ascii?Q?BW6TzrJ4OyHCL1mPVsihee5gGwimwG7ayyt66c6gk6Y5S05/JdR62gEjt4NF?=
 =?us-ascii?Q?XrSmuLJqtnoUgizXxNGfjo969sIvcDjbKYEvGcToosuUGuNOyDiSwoFq/SjM?=
 =?us-ascii?Q?xNcTLIrIHXpaZk9QSnwNomSlZ5mS5npqkH3gHYyFrdzmb2ohJnGXuAPWa2ta?=
 =?us-ascii?Q?OHWftXv7/1oOApWXdO4VmcSGFJPL4+lCVQfT13rkqVWTQA6G1JUoQt9ZFA1a?=
 =?us-ascii?Q?SGJPTXtv0s/oNEbc6gQPnEtQcvs2J/8fYxzR5FPv/76zJHtl5ce08n7ymFGg?=
 =?us-ascii?Q?9grzrgSmk4YrVZJOkOVJyltFLOAcJjbmTC+0XP6DxVL3lr75tSqHrTu4UUsk?=
 =?us-ascii?Q?seFiXiPBTcc6my8Rzk4x9pEgaHE4AVc=3D?=
X-Exchange-RoutingPolicyChecked: bCSc+GdK/TeimgwFucJZwQ2bSL9HHgN/newMU0RAgoKYDJTl5H8QpIlhXmibTrT4ck/iI8SEbce88k6+Is3OcKvINQqcYjDTg1PE9NJZm5HX8TSHtxqQH9fJk+aWFkQK8cLKflTfK/+kohEjSVIf36xtsCFg9K+IgD9bMb7b68AFnpn8gfBWZQjx5tlLZx3L2DjAYKvU8f4rueT19wiqtQIaFq0T7gHsXp7X2Wu+oeXnTAiuut4M+rOpB6iy1VQGLUgFKvruuJqnoASv5XRrsT8X1kckFm17R70EGIEQkHWf1qPf54JxXwkHEXB/7Zuq+LrcfdAMygF5dpuMned0OQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4ffbde-29db-4553-f6d8-08dee8bea364
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:31:01.7186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87Ev/TIS+hGytHiRciRvRcdefBedqXY7pAmibkFoae+huFvSmvkr9IYpTiydieLSzvQqPZxljTw/9GA0v4k06iVoGpoMfXLwpiWJqFOlMsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
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

On Thu, Jul 23, 2026 at 02:55:53PM +0200, David Marchand wrote:
> Replace direct rte_eth_devices[].data->mac_addrs access with
> rte_eth_macaddr_get() public API. This removes the dependency
> on the internal ethdev_driver.h header.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
