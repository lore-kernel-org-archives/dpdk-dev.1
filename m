Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF47CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D73F402EB;
	Mon,  5 Oct 2026 17:42:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 38A5D4028E;
 Mon,  5 Oct 2026 17:42:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791214972; x=1822750972;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7S1Wph1bjefCqZYPTwwK3sjmQ8CWWLWQxFf4JOl3D04=;
 b=ek22nrs2+uACj/vWuJN34rLd5c+BFW2u5XXxAateQbjWrFOFFHT3X4K3
 ONrMbjaYocrBQSaEC8lJx7quIP7mhHnclEcwQa4oZSiu+tuyVmYHUp9Hm
 nVapU6h9Gv/Z+hTQToG2lgs5UZJBzOxs3M5Sb+Tk1Vd4x1+lhugLD8dxG
 /Ecvjn237Gr6peEDUjHBlPaSz6jFP/vYhMQjGk3PeuYpCrzbAj6qwx1mc
 3ltRIMC3N3MGb3dsy9lBlEBTRU1pqoUBq2Gt6A+QIucx1C5mWZ2hvrNlV
 gE0xg47qXYBGM8PXasWKe8k/2218J/NTLTj/UJl6GxJJ11Ke++yABu9sz Q==;
X-CSE-ConnectionGUID: rLZ4Ysm8Qs2m2QXoYPK5dw==
X-CSE-MsgGUID: eWLzsgWtT8qHkm53MH/wBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="79448856"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="79448856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:42:51 -0700
X-CSE-ConnectionGUID: mQGehAOPRiWzBdLE1nl3vQ==
X-CSE-MsgGUID: N9yeXgeeQHKYo+Jj+mU01A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="306361331"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:42:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:42:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:42:50 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:42:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5pcwIHYTnnubK7lBcsYxbZZs/267Wh1akFwMIV9bcAA5VjrAKZ5H4+cKQBA/iRztmBuSESWgfRP1x86SZGDbgIQfCRz8bUzt1q22EqfBRVc2dCpxELwc6Dvv7QP0MxCUqygyTW116QWA6SwyfgyscU1jG3RkmnaKbdR3l85iWzIbGlZArx/F2g7gC8A6Gu802PLIJqWiR/n4In3mVnKc36d+uwf67c5X3jOpY6pfxVWy7BJ6ivnsUHk1Zx6OhHUhzf9Gx5CHOsKlfDCsexFLaBRgwAf2tgv7CJ+ejmEB8sRIVPyghqwKHtrSvgU+Cwk/UwQEeSzVEd4MJ8tyYGP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3bQUWFbSRVZ5q6F2nqjI60zDMYbrz6b/AzYK8NHVwc=;
 b=qADjZ5lVIZS+M2rFtjZ9aNlzeV5SO97KY6d2Uf6Ci9XVlAIWEVKbQ16hRguSbi9QkoN6sKHdHV6+5KWgb/hqvgXQasYWEOWEkYmEBxWlR86h5+7u9/14Xz1QUzO9IWfqAebJcsiaBuZGcOpuLQbndAJaqcsueeTPmq20E7hbDX15xFsN53yb7B+GTG2BgbOM/M1i0qm1SP269lECrHyFWOMiT/HFQQa37csVq0uuiA4cxAw07o3azKeHU3wj07eZfLzyLk0ec77ajnHoibYLNB/9wPfhYhNV4AX3BVVK08QHe1a8GzaB+MXU4WNnPYMFsL2i/HtABdyDZeU3YrhzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 15:42:47 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 5 Oct 2026
 15:42:46 +0000
Date: Mon, 5 Oct 2026 16:42:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>
Subject: Re: [PATCH v2] net/i40e: fix ethertype filter restore diagnostics
Message-ID: <asPFcdeN4uPTzuSy@bricha3-mobl1.ger.corp.intel.com>
References: <20260914100823.55165-1-naa@amicon.ru>
 <20260916093143.100776-1-naa@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916093143.100776-1-naa@amicon.ru>
X-ClientProxiedBy: DU2PR04CA0351.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ2PR11MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 4431cf03-a4c2-4a71-bfad-08df22f74d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ZAb7pxVB9Ffyxl4B7smtrwqkyJO70EvITE9WC8KmHdgaDhPRFSgjmmujlPw63ziuvXjyMPUMWozamWm5GQj80GPHIRgV2/YKcnrUoB471MMCJuT7myYJql9l/AyUKc+PwmH9E2YfCsOL8Nc5bhFQujIZzXKPQEtAb877B2nyMVnRWfte3/5DbIAycJ3x0qKLGahxZOv8GUccKr53LcQDsRSBKEcdzUBpGzZsxWlnaDaXxk0a/+pzziaQ3gwerVaEJYGXW2zsqLYm0BNObEx841L5+fJfr0pRojFY4xgu/3GjuZPn9eKv7TadGJiBPZHTO2yoSnVqS+WZedao7a4k960A+TTOar5EKtFq9dyueJT/KjfzubvniT8PgTNzXru8Wqz+xMjFvqwQjdvsYFidsUrJYjn7U7pPiD/De4g63vtCAb+WhwJi+FFzSNbwtvPmY99uSVkHj5lKKtT7MHWcdgaigapMJAWJx0C0iHdzb60Pp0CVsN/nCdvvrco2gfY99EOF+I0//F6fP7KmXerwgWeLvug001uww9YSS8baGI+g8Sd5DbXGfMcJS0wWZgEWXN9ukP2xFlHO2RxMnumNYyCyQ3nv7xa/vPRSKxgfKBl1qFbkruIwc+INhtZ/jPV0GEAPswPOOjKDOzctW7txBYyIaaEvio94VZTXk0EoUZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DrkUif01SJ+YiwAStxb2UMHLfJM+FKadQyC2ukJutC22NPSD67yfUMEKzzD?=
 =?us-ascii?Q?X9bK45RpCML4pGmbqY+p0pHlvrK/bnu/dhOkPQ7kxYZsda3vpHTDUXyeCcYj?=
 =?us-ascii?Q?IgA6hMJJyoJuiZPMa1R8Sc18iSQqKD/Z/UQozjKirFnLIao2zRi5HqtQHdGm?=
 =?us-ascii?Q?/WbvlKhhzp6iE+0g19TdxgaqCfETw4b5KFD8Uc0U8iHUKWLwdkRoFKZtzjJR?=
 =?us-ascii?Q?Q4qcD5/lxXpBpZBUfKW7rACaNdDd2Pzjfds48PzroA69GNmYGBjZ/YqQHrJq?=
 =?us-ascii?Q?KuQEO6LhJx77XxIRjzj6bo20i5SiI9xy9wA1NMJVlJb32Q9reIP45z0UWv+F?=
 =?us-ascii?Q?60uzQ7b3MmI6mqmNfXVRhef9Eh7bPTUcdGWVeb037NaJj6yuyvelP4ROQNBf?=
 =?us-ascii?Q?r0Sga9EwQ6ObVXPJaSR/QJJGGEkVYYM2l1JmFyKT5aHQFQoeVPu3Tw3Fuzh2?=
 =?us-ascii?Q?CykEN6C12vxI6iqbdgPQ0pltErHg2KJ8vLVmlbuwIkYjS9gd1E5ptyfNIi5y?=
 =?us-ascii?Q?zklMWlGlrHYdTHZx5o/XX7diy4V3zU8i+6mbzGeZUKMRWqnUuKPeBgfzzcZy?=
 =?us-ascii?Q?TYVSnk3Ase82g8ExTSV4bsEFC0EKK1Wvx2NvOb/ugJuGPcuhSiJRC0ffpksn?=
 =?us-ascii?Q?SGozBsf9pFGQtbROJ/XlPlh8pxTMS+h/BVqlV9QKOj1FSFaerd99QG/ToDwv?=
 =?us-ascii?Q?V77Vg7ISswPWBpwUadxFk9PlpIvKBOU0hFotViyiLXiKrPMf6Wcsz/6RvLQn?=
 =?us-ascii?Q?8z75rr6o6X0mnaA13rDtxMW8mpHE3Y9wIDlpmfu0A/YPGF9NvVZ6dZa5Erno?=
 =?us-ascii?Q?+V9746VF4TzSg6/4nT60AgNkezH9EjWj2pewuKomsbycDjjFwAYWnzqaX8qC?=
 =?us-ascii?Q?Abjl7VHOtfDtDEsbvH8WFGBHYX0PQT3ADpnFbZ/kVl7Zk+ktZKymdWAGsLL7?=
 =?us-ascii?Q?yIuxksUsR0DSvdoKb7tEYHAWfSF1LvIjdl9npzYYdrqoMfjssCBVC8gcTX8v?=
 =?us-ascii?Q?HqskfgAE47iluv+GCrvkjb248KtgaM8AphmDd+s07/RjFmyaPmTapuMAOJzz?=
 =?us-ascii?Q?mtxvB35F6ZnDNZM6+W1sHkZOvJCHwq+NE98dq5ddJ3z8hOiA30V5A+ESaa7g?=
 =?us-ascii?Q?L8k1Q49ChQq6AGx9EYbXEY65JIib9CtezFMCZGyvVlFfUEem5/RZYYR3cW0w?=
 =?us-ascii?Q?rkisgi+iSARUczOzAQkzR3eeMk0x6bYPrMB8hhkSqMcbCcsi+rEC/lib93z+?=
 =?us-ascii?Q?w6awMlyboGl9YvAj4FHgq1woz17dWb29uQVMEnE4Q2J9R//Pv9rtCkHsESpO?=
 =?us-ascii?Q?fqgz+itjPaIqpPgB9sghJVItl79TlNRVBDRO4Bp2A8Hq1Udv0Epnx+pE4Bd2?=
 =?us-ascii?Q?gh9lZ3BNn1Lsm+nMGgOL/Cn9QVap4PSXHd+E42hO/HSYjmhpswg86/Mk4di3?=
 =?us-ascii?Q?aiRLW035RNwKLaI5ozUGKxWpw/Z2eWN9280F5epQyo6FJYxXzTa/MbvO7Ig+?=
 =?us-ascii?Q?CyOWseM394HsfJtJd4TMyeL7ED4YQxXrj5rODdarNS6efH2+NqSGAltok6op?=
 =?us-ascii?Q?/dbZqjmsP9hmfplk+grdNXnl6i2Etj0Baw22JxI6YTyjVYzM/aa1c/EjgV5U?=
 =?us-ascii?Q?7F7elD1ejvfVjEmWtKPoP+qOnmrTkh/VrgyEBBAI3OJ2WNwVDkB5fpuj+CI0?=
 =?us-ascii?Q?FKWLbcPqpye4C/84xE/pIjOU6oUb2ZbjeyJ0AXWvv0zsSoxEYHS+XWtTFXp6?=
 =?us-ascii?Q?JpJwfUrgK7g8cWfK5Nh2zPZw76d0Uj8=3D?=
X-Exchange-RoutingPolicyChecked: gEmecFHln+cEtSr3EmxgS+9gcwdyVMxCCzi6s37qX4AbyaycU25ycFQ9ISIK/QVa94+6K8tVAekVLQvdF+ovENFGwduXRr9zlD0jBlvS1+/PveaT237DJc062nGsTJzGpJLfWmAG6pnxjWpzc5dObeUdZDI9OSVt8LRhyMrvlGkQRA62EfiQ81laluBiBNhgPtvnhojcP4co2fdr6farWHSyGr3V5CqzdGmjHNJPpGoQcAMObTQc32j8V0NiIoa/iC6qZdxE88UKBgpwJG18mpTKqOncSvNbmoskiL4EK74A6nNFafaz78hMeVhI0gfmTF/KSDD0vc498OvoERphlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4431cf03-a4c2-4a71-bfad-08df22f74d5d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:42:46.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nME2bfPQQfHIc3XmpF4mbiOBrATmae1nf4ltn/t4as7ZRVfP7+R8ojafg6UiZpB/eB+ZifYfyfFdJ4YIfKxFf/c9mR/4y9y2SHVBfbYcyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
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

On Wed, Sep 16, 2026 at 12:31:43PM +0300, Artem Novikov wrote:
> The control packet filter command only fills its statistics output on
> success. The restore path ignores command failures and logs statistics
> even if no command succeeds. With an empty filter list, it reads
> uninitialized statistics.
> 
> Check each restore result and log failures with the affected filter.
> Continue restoring the remaining filters after an error. Log resource
> usage once after the loop, using the last successful command's statistics,
> and skip this log if no command succeeded. The command helper leaves the
> statistics unchanged on failure.
> 
> Fixes: ddcd4d4dbbe0 ("net/i40e: restore ethertype filter")
> Cc: stable@dpdk.org
> Cc: beilei.xing@intel.com
> 
> Signed-off-by: Artem Novikov <naa@amicon.ru>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

