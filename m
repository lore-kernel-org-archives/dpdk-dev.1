Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F6ACAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 13:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7422340289;
	Wed, 24 Sep 2025 15:45:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id EC7F14027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 15:45:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758721515; x=1790257515;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=r4jMHELH0bs5PBnj/H2KstHQX2QOt93BvZtfQp8t7rA=;
 b=QbSlW86kcDANnRFGvFE+l3b06uG56KjMGh4V8PihL019mV74iRd2l50E
 DNs+b+4dG8kXUg+sKH2RPQMqzOUSHiyavhLUdTlYG7/gs4pgI8O3E+gBF
 LH2Zto7PKJ0YSSHk6Vv9pxSxDMTNiFXzoCKU/hQGlLsEuvs/AK9YcXcEV
 uqkcfTjKLk4x3y84lyC0AUppR9P45jwsIuCud9/K5nmPRGPGHtuI4GVNa
 4/+G+InX1z8hJySg9itfhtPV8pseK96BD8b2dJLw2E3Wk+NwnLoiOJOkU
 Ot11RmltlBoj32ByzY3AoV448LBKdwQHP2eIf7zAObpEUJusZsiWZsOl2 g==;
X-CSE-ConnectionGUID: y4lHDU5jTXWnMTA/Fn3YpA==
X-CSE-MsgGUID: oKAGyEAyTsCqpZ3qjarIow==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60056952"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="60056952"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:45:14 -0700
X-CSE-ConnectionGUID: KocqzkweR2O9UNJ+oQZ8MA==
X-CSE-MsgGUID: cIH+xY4SRrCWJMtcTMGf9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="207777367"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:45:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 06:45:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 06:45:12 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 06:45:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2pNtXuCOS0kjMEwnYRvzAM5D4L41iQQB1l+K4gU8W+a5FgXtE/P6qzgcquAgHG1TNEl6ZmQoSjdUgOUfFDeLKfpnajYP/6VBj6YkMV/NdTgAWjLagSNo2x4OQ3drw/Iy1sS6NHSMWRnWoHQxEPVbc2b3ooiZR4XTYaiePLJiLOnnor1+L4wtTcJwAvB8f3Jx25pgfC6FdOsmFu0AYbLOFDkwxkg5cBy4QrpZHYD+9mUUotFak3RLzgrAXaiqZ4G5CJzRc+1M83y2pG5aEYHkbRA4+GT68SV0qiVA62ovywGvT1f8/5Z6HiAbccQsP0rBlukyPnv6qC3jhdjBwP0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GscTD+LBuv6JiCS2oX5WwajR9ZQCLxWidLDHXTG153Y=;
 b=nmHkvN0KbEMEy05hVmeWkSlGmS53Jku70UN0LgRe3Rx+Z2A/avbCu4k2o8FuwrckMKYq038Naf8ytBJuTUTZ0FZZIC18nGa1dMhn0vD0u70KIYYpSbuRjvYaaG9U7zggiAyWga86tyNO2gwegYjRp8C5G85UgkF5kgBPibhp0bJaOwdtbz5ERfXH56l1kM9mfdw9FvmZ3keHCPoY4uPI/d/t0Bf1w7XIzaMtacD2gjSzAPF/uNfMJJc45eg+0bVcJYH+7bggqr/62ZhospGiBSnkP47z4tYzegtwrPCrzjv3gUq6HOMipNIZOEznS0pqxn7DFVI2TDdSf20qx5FeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 13:45:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 13:45:09 +0000
Date: Wed, 24 Sep 2025 14:45:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <mb@smartsharesystems.com>
Subject: Re: [PATCH 0/2] avoid using mempool fns directly
Message-ID: <aNP14L_Xlg3w4DVv@bricha3-mobl1.ger.corp.intel.com>
References: <20250822170656.454571-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822170656.454571-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB3PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:8:1::35)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efa7531-65ab-4cd4-d34e-08ddfb709395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oBQ1uNYS1R57jzzGEarO9Hp5jQtPifl3OAIvWIrAIqm3fRGI/E9NJIUV8DsG?=
 =?us-ascii?Q?t75OWDnoCJqwMzDRJC+Yg+4apujH3VypyTT71BW0DUa/LQ8eo9pEqdYu0v3T?=
 =?us-ascii?Q?lFL2tNupmcFcu4ozSQJ9NWZ4NCPJj+Jt8KwvWk5LQIcaBHSfdqseXUCYK5aH?=
 =?us-ascii?Q?X4Hi6wZEitjvv2Yik3/FlQ7ZSHby6x+rtw1WLjOfszuBzRgjcvlZXR8Chxjm?=
 =?us-ascii?Q?pENnCbUYEty36DK5dMTSmqfdTeS6YhW99j/9Crapq1ZpCBCDG0uLVVhlXLZW?=
 =?us-ascii?Q?YD0dxhTwMWeLtRQbXvhQIKum/GVrA48dCWjVshhgZLB3cJbfxwK29+s82RQk?=
 =?us-ascii?Q?biZDqcDlOLWKtD/XMOHayDIykFuCU7qAT+QlzdGNEXqL5xRLMk0NPT8iSPoU?=
 =?us-ascii?Q?NRj9z8NE1P37iK+ZavwuIsGBRRQl/fSE/coIx58TTUV/tXPKk/wWbm8NM++B?=
 =?us-ascii?Q?Gp0U/MY2fQ85oIbqsyQUtnxROa4/Jr1H1MWCYOeM6JisUpofGsmpdD0TUtYl?=
 =?us-ascii?Q?3ELCV/+NnrEhZSIqVAwzAcT3U1lC6JQr/EjMAwkMWNhS475s9lHxqWZYGgkH?=
 =?us-ascii?Q?pHTl+HW73LNUABAylYr3LFEG7i+SW0yAPrjgyQuL+kBOdli09xIs10stPmQQ?=
 =?us-ascii?Q?qh2emyW+8BhdZ/PVG9ENtNVtjZzGs3dNAoQr+n5V59znNp3JQFsneuuJS8QK?=
 =?us-ascii?Q?fHyg+l6hbEjS3XeqxxoGYkWPK0JZSjy2JscFo7yOyXErkgHeQZR3QOqo5AaL?=
 =?us-ascii?Q?r1Xq0ZtU4DGLYAlf0y5zUbzVbaZXN5i3tqkMfPGrWnnETbJNa8notefeoJBo?=
 =?us-ascii?Q?x9N2aWAVTw3uVdggW5gqxFeLCbpOn+3bbigVV+2MFKL9dypD/19tK+9t/zi4?=
 =?us-ascii?Q?D02j/r7JQa+572xUwnvI9ElWnVtMwG/ZxD4f/Ag9OMLVPlrKwK2EInAGQtgI?=
 =?us-ascii?Q?LMYsdA6He2twercam7Rhv5MtoAYG6jfnvjjuhw3MWLKCAoA4XMQAiuwbKssE?=
 =?us-ascii?Q?a42m7v+n0DbtYuoqkPdHAZk9q2ESkEPcT/mUNbTAFtonUFAua0Xm9yIOJ2az?=
 =?us-ascii?Q?XfY6QOIBOZ8KT9jyPNTC10727+6xdZrk3GzNolwRDNdAleT2MX2WDv8zhpgu?=
 =?us-ascii?Q?pZvTacIynjLz9UaBZxgL+Rhi6xboVpjv5tVWCGn6zo/v5jmPkdDPfqIQBrQt?=
 =?us-ascii?Q?gYhR3Wd/6k2g7q4pukS2O/f7sMlsjCDFYxY0oiVk6cJWftki3kwq3CK2+Xi2?=
 =?us-ascii?Q?Xkivvrj9Ic74wlp1y0vn6iGZs0fLhYP0LDdT5QKUU8JPQQRt+8RmKxbbztTV?=
 =?us-ascii?Q?lzXnatEG5KzWfAx8/sYjN+rouMkhVI7RJTma9lHHlbLJQGKLWDFvc6wXOGfF?=
 =?us-ascii?Q?KmtKOny2nzTM/3Ex2GWRor0BsgzSGW5+qLyiCziQ/nSmQTTtkmAS3tniXP54?=
 =?us-ascii?Q?86wTMRcw2tA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j1GAkyTEqp4Uo9jlr2CSFJg9IzGMBhuyhVtFsCzJDppPp7fnYQF0De5jdWdP?=
 =?us-ascii?Q?uqSd2LYPjm+P/uECyfehIsEqbVWX7DxbjtptVXFin6keP1tAzCQrdK7XF6G6?=
 =?us-ascii?Q?FKTk/J18ghMkeVAlvlGSiB4LisSj1tOyfExeBB73Dc/rhTroOR+rxRekd9hg?=
 =?us-ascii?Q?hDOPdUVpRVG5VhKVGAGHbJqBElU/ujxblWIvFJXBDlcRQbMNvBDm/t7bTJis?=
 =?us-ascii?Q?LHGrAQHXOfCvw7RMxSXu7B6EI07SxipXDeWW8eqprRwGuOYpzTf9SkkSDoa8?=
 =?us-ascii?Q?er4L9nwiHXc718z/xx3Yqjw5zmizug/v5PpvN9JJouJtV3AWEY90xoLN1I+w?=
 =?us-ascii?Q?HkUAwM9HVRUyZgtbtbo3/fc+sxdawkWq4rTg7hNPqz1ETTc6YjEVVYmOHlfk?=
 =?us-ascii?Q?FUO9tE9YWVC/407bjpGkqWLt3qezOWNfzxShGFZY9K5u2aQFPbFP2KtkA/pZ?=
 =?us-ascii?Q?RrQyECB5IjmNdPx+geYDmm2R6h9C10WMtkwVWciyih+z0qwzlLRFSJoRLI2z?=
 =?us-ascii?Q?Aml3QcOJa7P0HTHIIeFd80nORwa8brzk3SI7HzvzacJjY3usZ4wpvoqEFhMN?=
 =?us-ascii?Q?2nivaxjreLwqxVM37IJCG14Tr14MhDsCUZp++irdHidWBCO0+vw780ZFitKo?=
 =?us-ascii?Q?1Sx79EoxKt2MydZdvUgwBCbzEsdEK3hNiM1bLagyB2zjXRKxyKKyG9La9qTB?=
 =?us-ascii?Q?H+FL0vfsxmhNqbl2JClywsczqcpCVoRkoDYf12FCzStv7bKK/o2VK8YjxlA6?=
 =?us-ascii?Q?/sghLHOOLnH7D0uPDCy0LeIc/lUZQ/zLnR6ESQlJukF6Ms8BUcyhVo31I8V/?=
 =?us-ascii?Q?o2NcZlyrbTa3v3e5Wdtcfrg5/a/OcjJS02wBY72znjbr0l0YSCYIqMG48JPe?=
 =?us-ascii?Q?YaVeYdO+DckiT3lYhmrgC/40LxgMESP/LJ/3VYuF9taRsL22gO1joJi6CsfO?=
 =?us-ascii?Q?ag4sBuB77t31IHBfjf4CKmkZAJdTtcRHNhDtZxBrYLlf6gJHujDOsfpwvKp9?=
 =?us-ascii?Q?zgVJSBeb2y06rCPgHfpepdrpWaVdsX3m3ryQN6juBQPzuVBoPhhyuvjBxLt8?=
 =?us-ascii?Q?Z2gIOe3Hcy3ochtBHynFEMDlD+L7+PfZEojstKrH9bjmWz7MA+K2cmtXD9AX?=
 =?us-ascii?Q?NAGN7CfyWPSfcyUWa+RA/00gi1FEWgDf00WxWztyuckzx1Cu1NCScCCz9lck?=
 =?us-ascii?Q?HYfwAIFoY2Xj+0UWdWQlld1tMshKCFu6C0ibforFDrKJ4J10XgjQrcxSiSfH?=
 =?us-ascii?Q?XNQEebrp1mQhEs9IaYn6Imi7i6f2ksGqUjfDNDoK6fLS69bUXhf2k+ATBnbg?=
 =?us-ascii?Q?Cf8a16ZEZ5i3dMiIADmioQzJiofVrlhgdWfeIVywWWYtf7Y32BadSfofpHnR?=
 =?us-ascii?Q?/iMsAQagDecnOOkJxUj5N/+Y/SdPXeMin3NmFRyIs6+/ZBGxnaR0OYdlbqpD?=
 =?us-ascii?Q?Fo94DZdunadzLMsl5qPUy2nQcOHLMZkOSwgEofFN6nxIOFhTdRMGPgHL9EZp?=
 =?us-ascii?Q?TQY6Cc+ofqC9owiXBdj0iQRwPfzXcDoHWo+4oThXOj/U8D+gahQfmij3vDP8?=
 =?us-ascii?Q?oqxlxBoVKQcOyaFkLwHQ3ggBmkM8jik6rNWwJZGxdj2BlT3YHd8SKSK/FDyt?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efa7531-65ab-4cd4-d34e-08ddfb709395
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:45:08.9327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGDhXqk/vnD4R6t1y+nOQYBGSplpVGPXZ4q/kzfLMAnRGabCdPusc5DjGvIXQgbLoq5J4c+zvO3toMKyzGoMseibuPHxNNdTY4WEqVurORo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
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

On Fri, Aug 22, 2025 at 05:06:54PM +0000, Bruce Richardson wrote:
> Use the new mbuf inline APIs to avoid using mempool functions directly
> from drivers.
> 
> Bruce Richardson (2):
>   net/intel: avoid allocating from mempool directly
>   net/intel: avoid accessing mempool directly on free
> 
Series applied to dpdk-next-net-intel.

/Bruce
