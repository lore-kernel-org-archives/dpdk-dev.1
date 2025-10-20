Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6B9CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 12:41:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF508402E1;
	Mon, 20 Oct 2025 14:41:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0BFD3400D6;
 Mon, 20 Oct 2025 14:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760964107; x=1792500107;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=kfpmcI+zlnZbjsDGN0h502VXdHYasRAmpAxBMjfQQFE=;
 b=MOWYXr/aJF7euaqorcjUnpivSLUCDnN809Xso7D0UUNg1NZkafcO0dLI
 IFvNJ9PePsqi3noNzJVqcbXI2UXpP/U2mim1pSoQWNiYzf/lxe2YZmvOW
 3rgjbuYuHNRfNl7I7+pUyujPXiivc7ZRRKZk+ccEUw/bAuBsoKu21100l
 xve9/WFQmoTUSCbvkSpnOWEeabEHQjk2LjfAbGSpy7XAlNvWO5RyaP/dY
 avhtCzUSlGv7Z2sIY1Pb/DHZivYFsR/6HMX+NN1zkh2jkx4HpelobTUdt
 dTqAyovx+Ad6YRQj/seZYBSwwMSlG6hb0LdembQS+AnvvNym+6vm7UbXv g==;
X-CSE-ConnectionGUID: QYVACLCLQqawzxMLT4RyyQ==
X-CSE-MsgGUID: zqVgPDwkSPOnNmjZMljBlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63118365"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63118365"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:41:46 -0700
X-CSE-ConnectionGUID: PMFPkdVMSlSQQgUfEUptNg==
X-CSE-MsgGUID: tpruDNOGTquMjRhh6gK7mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="188417854"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:41:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:41:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:41:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:41:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0KRSpe+rTBjBohqag5SJVYFUPbcCbUoKY6NzsaMg1eC6e+GnDbYD6y4+sL6lvPicXwodLC/VDkDn9tsogc8PR046HWLd4OAPmJ50z/NQR3B5E3ckppXkHTWQBa+xP570sd9iUKb+aKOvYDXOm1xhkru8KgwCOagXw129J5wlwRGWog/AFK6NfEVKZn27ZW7Vfke3kstCEs4l9rb+3G5WAa0MT4vvhyk/6pADYKAWuR9Cr5EPZGkBAL+AmgBUjnCwOBFO+eByxOlYlvZfbjshnjyDeKOdDVvCEnYMmuxLTH30y2SGEME4Xm0FS4mXMohpR1TqRp7HEEoaQuWlvDhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/LH/CVXWD6yijzKPMBmQM8aR7KJi+WZTyvcy5rapdY=;
 b=i/RewerQUrMkkZuExkb1aqtm8ZVq1oTEH/bd4rSuB6ife/WSaD3nVZ6ucbSRnfRS5g/aL9FtoJDN26ukwiGQlWdQwY1U51Fbi/Q/B5ZdUbd8CAEXGm6654X5GBNit/Tg8fkCmWYgGOqrh8nXxChj5f67WEkZbVlt+1lNDcfijm4lApmhBPy0MRu3Zz3TmR7+/iY59HjuSUXpgLujrT0SbqJUmZSaYmjfQqVHbt4QUQlZIwWDdaFVMoDiEQmytf55LXBrjojMut4bO9l1QmJR3d3FpaWD7r2+wKGrAeFPPmoDFvwD0byno5uXRX7YCJJOSP+7oLefwscXFjNe13vE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:41:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:41:43 +0000
Date: Mon, 20 Oct 2025 13:41:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, <techboard@dpdk.org>
Subject: Re: [PATCH] ethdev: revert reject conflicting TX offloads
 configuration
Message-ID: <aPYuAxgEntSQN1p2@bricha3-mobl1.ger.corp.intel.com>
References: <20251020123326.80591-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020123326.80591-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0190.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b85ba3-93a4-4ba9-bb31-08de0fd60638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?F+SqCjrbeuN3/FfbLDO0aW+rxbaBL8QTbz8UQaWp95OozXTIoPyHD8SYML?=
 =?iso-8859-1?Q?aiqWTQ7qu+QjlF4wPoPnxTmoKiIIUZS8m9qFpMRL1CMdrSkVlr74uphMpb?=
 =?iso-8859-1?Q?qLi7slhH3SGpXZi1eU2pHGuqYgOZOGdJFa06oTm6cEP01TWN/ZVfBAi6GU?=
 =?iso-8859-1?Q?WXDAUq49/fWrBHz4qzENMVycslFeqGks5Oo1xjlSl0g2qqQUNh13umo4a9?=
 =?iso-8859-1?Q?k21OPJMA4gIRHbqHIOwH8mL80pBpE+/I/xqPY2pIKxrUqVlh5pVWvzLIh+?=
 =?iso-8859-1?Q?c6lwJo9KswOmx9U3MAhOvFqRFc51aqEV9+bmTk8I3/NEISgrQ9ACz2g/Gm?=
 =?iso-8859-1?Q?zyaMP29SlXlEPrDHP89HjglVj1c6U7tohVs7BbZw6G9W0CgBp4AKCMUgG0?=
 =?iso-8859-1?Q?iJsC5udKqu6XcbDE4abnVRsCau8tgGpio9HaIvTNYa4OLzgxlXlB+GQoPt?=
 =?iso-8859-1?Q?D4bb3iuxzghQ4P2nrTKE4Y90mZMuTnwI3xMaU9WHEtPdPf8cOK8+eG/6Mz?=
 =?iso-8859-1?Q?1z+3xdAVLc9vGiKvgN7LOaKppdCAxcNlJeroGgrBSLOu+RUcrvM1j459jA?=
 =?iso-8859-1?Q?VVtMlnQV6sizQn4L5E9C5U010GgRJhx5VjJHlJ8LTxP04gVay8f9Vb/hKE?=
 =?iso-8859-1?Q?n+WtD7jZhXjbd85vdpKsH78Ay7xlf70m8m2zc+BQfEDLco5s4ziOZBb89B?=
 =?iso-8859-1?Q?2QT3JhAaKHzO0eebB9DpeRV7x/qwPY2TVcoc3cPPsZJ0k3sivBQGPXanXM?=
 =?iso-8859-1?Q?7QyrO0Q/D7IrV342+ZT88zWOlD04LEKJ0E4ng3DbfCWasuV2QbjvrUb0Sa?=
 =?iso-8859-1?Q?YzPQCwWm1cvG/Z3Y0K6H8wCgIRMEbz/Q+KHx5D11KbFNTMeAC0vQlEHuVS?=
 =?iso-8859-1?Q?b7X8bhHKpPFIqOWYaTLH53iTYXHTUC1o+F5w/e6tdnx28NuUsLy3z+uxt4?=
 =?iso-8859-1?Q?vFxvLOJAMUE8W0JRUGbDnQxeuyfEPI0a4jbexdYxBIl92eYEtgXZc++798?=
 =?iso-8859-1?Q?QGr5NGhluHTmgbkPBWiZy0jOnsZr7IW2GzpRfuvWpG4P4TibLJz9dCNSKv?=
 =?iso-8859-1?Q?+fpjF7cEwGImrPGOwym3oNWfWHlslWzCbVdS/YvWindjrBw3hwOlq+78F8?=
 =?iso-8859-1?Q?rktppzNiJzlyX+0xv9tdFRZnpmlolLGgnf6q+aD9K8QfXaex8n/DZDNjfK?=
 =?iso-8859-1?Q?NPmX04iu4BBY/3+E2+xV2wt0BxELcdn/ifqwAC3iGL2vpXj2aHb2I+iqrc?=
 =?iso-8859-1?Q?WkcEIh73N21Epa4zdAFr4uNBJUHSLGlWgeuC5FlWrVkJeA5oNX9+bro6an?=
 =?iso-8859-1?Q?2cxekRa07CHyxedIbNNYJ3IrRn850gnc1VXFoLdEpf29jsKh/46qWE4cGw?=
 =?iso-8859-1?Q?rXXKN9DyAhsIa+WRg2Pe1TBJCWEIDOnY7j72jbgYCDKsyL3MV8u7RW8slt?=
 =?iso-8859-1?Q?h8McgBGEKV/yPciFeMko1bVhegHptTzCzLU5S/iwinwLJK99BvbTAJh6kh?=
 =?iso-8859-1?Q?td/OtcJinQaUAKyH3gdr5i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4tjIoinKNNnxxIGFoFsYeSbBRO8AX5FrlggYoAXghudR8bn9xGdXOuv1Z9?=
 =?iso-8859-1?Q?pebsVoeDPFqEVzQqj8KBsUF37XINMpAbN3D4sXfr2xotrolENEzp/QD2oJ?=
 =?iso-8859-1?Q?KL8Rc0z5ILhJnzstS3KnKdqCNbGQfF2EefedC/KHjTXhL7+D2qpno2GBYY?=
 =?iso-8859-1?Q?Khmu5m2yqdcRVyhCFnBc33ruw5W1qEVsgS6Pw8oDlZFn67SvyrlxQrI3JE?=
 =?iso-8859-1?Q?U88sCnMNDcSJK5rkx5FtU5NwpY1NhgUAbti5V1ks6YC264jaksUlK6Zbjx?=
 =?iso-8859-1?Q?Q4P0alTmCTJs6+fAvUYzLrCbiCLj8ycKrT2n58iUO/Fkr6bk+bXRlzAYzx?=
 =?iso-8859-1?Q?rcjwpkeqvF49uZSvKpNHkeeb6bDKaPjUP5K8xtcYHyeEKErJqX90sSK8ni?=
 =?iso-8859-1?Q?RHBkYx0l+KNAhx4VlpbLzIq9b4P83Qs3i7HVcFVi8YVZvnROO28in12j5l?=
 =?iso-8859-1?Q?rl391LQFcZF/vEycH+nkTtD/JcxGYEOgIXgrCg/NMS9qnZ8veKeES19lt9?=
 =?iso-8859-1?Q?xFsXTsyGGEUucDfxSmWjuZRPHbayKrxADFgSWt/b5o3Ru4qmn2bnoiBewE?=
 =?iso-8859-1?Q?XCSHxA3VxM3Ir5GRLL3wUyt5WYTiFe9Nxf+zDjbshNUcvbTP5taifn3KUV?=
 =?iso-8859-1?Q?t9nye/bEP7Mcpkgei6KsfYmlwdiFgUdnI12hQo3zayfKsLBEV/jus65DMl?=
 =?iso-8859-1?Q?jPR0d2wwyswfDMcFLqaoKkTJoGKamyW9tN9Yh7O8BRfd7Ef6xL1uXKTWDf?=
 =?iso-8859-1?Q?OLTEYCTtC3q3HA+ZQDmfvp4dgvhy6oGTwXGTQdTwu2MuhdWVI5uIyAx1aG?=
 =?iso-8859-1?Q?bS+h3VRg8cSg1BTdgkKVJ7N/qCbizAzv7qflndH7sqSXoQF55foyYgjxKn?=
 =?iso-8859-1?Q?6FMf6zLJXmQdBSASbENR38oXxROtiR1w2aE0/noTmWOJj8s363gPXC2EQp?=
 =?iso-8859-1?Q?UeU+rAKgZ+yLYisRK5ZnPkpg4FNSCNG2/bAfmrbwnJOvip5Fje87gfFxH6?=
 =?iso-8859-1?Q?ME3HXfxbL7ym8ByMQWZroxKe6Phq8rrPBbl4dC2nDMrQe+qZxy6yF2SgkT?=
 =?iso-8859-1?Q?1ozWvcpIoNax6OeFYXnx+XGvKhqdjdTK3lzDZ1HbHtFUyP7ra5QT+jeIO6?=
 =?iso-8859-1?Q?yIK4yRRGz6WFZV0pj2XcNdOI9wzfFQOT/kTyXGAuV5YqIfP35QTW6NgOY/?=
 =?iso-8859-1?Q?GtCpkrHTZALmvW6Sfn2x+QmOXetqZYyx5mcxxngKYmiHnL+B2IXQqm0Orj?=
 =?iso-8859-1?Q?SawXd2w49atL5d6j3sz23YWL+h2p3gcL8fE6FWcJoJZF0/NVr9jo+K1LIB?=
 =?iso-8859-1?Q?ctXi4/PZgD0zLLUBZKt1brpZAeQdGpYIxp6D/tCb2Q7qQyR2OkYVZQRa8/?=
 =?iso-8859-1?Q?DfDGBjRDEule7jwVLpxvX59Pix7bUaJm5vfuAzDY1jnqBkfVgX0eRpjJSX?=
 =?iso-8859-1?Q?VJW5SAsAWqWOSygbJrkMYWKL4y2NXAux0YDCgPsGv3CjqYV4mr4UQtOEiV?=
 =?iso-8859-1?Q?CdkwXJuII1qh5q59uO07OothcmbLQiS42X1dSrC7x29W9+KXU3A7oFRnaV?=
 =?iso-8859-1?Q?1/Ewl+45wJ9LA5rGM3xH7Pz7h1IA6DrGkmKMyL7OPdYt65wwYfUm1ltmov?=
 =?iso-8859-1?Q?xEgc7p/P32P9/LGlEaVWE2gcQm/Bus59xuSAFAMFb/TCciD/6ahHptJg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b85ba3-93a4-4ba9-bb31-08de0fd60638
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:41:43.7994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rREjyyLmDs0FJ/MTsa9+2mgHTGE1zjDmS15Ht/xcdUseGzH2CmCd5AhJ2TaLTLgVV2WkkK5uEU2xOWyi8DpTve7NtUvoSs68Y1iXtqDRIUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
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

On Mon, Oct 20, 2025 at 12:33:26PM +0000, Morten Brørup wrote:
> This reverts commit fdb840367cf0d6abeb17b05623679b8d1ea4c902
> 
> The Tech Board has decided that the co-existence of fast mbuf release and
> multi segments is unclear, and new restrictions should not be imposed
> until this has been clarified.
> 
> Fixes: fdb840367cf0 ("ethdev: reject conflicting Tx offload configurations")
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  lib/ethdev/rte_ethdev.c | 37 -------------------------------------
>  1 file changed, 37 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Yes, this whole situation is indeed unclear, and often, I think, filled
with undocumented assumptions. So lets move carefully as we look to improve
things.

/Bruce

