Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75075D3E792
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 11:59:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D846440A7A;
	Thu, 11 Dec 2025 12:59:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E506B40285;
 Thu, 11 Dec 2025 12:59:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765454389; x=1796990389;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5BUOgduPHhgNTZik2paYjXaZYqpJypolm+Kwt0NBSQc=;
 b=DQRnOWiX3Xprkgk1vKOXBwNTF/Cw1ynmy0RnHnqHKWJQAP7Ut6o8qj/S
 Y/gzQ1WAn/VrEkbCU9raaqv8mlOzltDU2zzamwohNPQNwxD0PUJFFEsPq
 RKbZuhqKmoW7891VGPAYktOxGFazyFZ54oiTCy1fQQtqOlaD6xJtaBf4o
 dJM/O7JUt8fMC3LIIpUSrnQsJE22aLMZYzdxw429l68Z9JvxdZ3i0wQDl
 AULBKeOsaMkyh8fJqpkw425C2SA4iTz2Tztr4bqRHuykYdfgdDG2kEHPQ
 eVMImJAI+YrEku9xuw8a8fPomBogqk9q43wWryWBzXuiVrHmxO3ETS+vC w==;
X-CSE-ConnectionGUID: wZY/3wPjSmGmpcNWVrEjqQ==
X-CSE-MsgGUID: W+bBRs1xTbWNvkkcw54KXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="85041040"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="85041040"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:59:47 -0800
X-CSE-ConnectionGUID: rPfc+CQXTdOlGIHNHEOhGA==
X-CSE-MsgGUID: MtN+Sub2TfKYxv7t3mqvtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201869965"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:59:47 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:59:46 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 03:59:46 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnBcU76KOrsOCftC8l6JSnrUBdZqNYel9xsuI63BGI5I7RuCBG3jbJn+7KlhNNIH3oVJO7T8foCMle3+em+mAloD62XzMSltuuvgjzeoN7wy2d9evaksmR2jgukiDrnv7ynclQYJMVuA9MHvs7RzD3RtHCYMphDRMOKYsT6WThwH8POqqsMyALiJcjxYTj87FuHfosHchV3kn8lSt9YZ9g5veKCWecYt4qu/uiafCvHAHnssurEipD3QUUi/Ov0fK5Rwp7wTvJdYYwyYgjZsCJtrlyePdNaEVcqRmop/U7nQvd3yAuicWNjewlxWcDndExXLY9zF1ct4rR2iz7cTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7tnEq42ojeu0v8qQJTAsCIga9X9OxGxKHVBGR8tIy4=;
 b=BiM0FFwSJfeTP+kR8JgmhyVFgDQCvXP6xfnxxWol009zUQ88qgFFvNz0ao3MNvqxa25ERAS6myrOLa4xAVKQoai5UTjgfhmkANlEFWtufHy9E7kPWskkTloCqd8rECp55RfWn0XWHFtzbWVM2Vb/RP/MIJT+04euNqoAaGIabNc8JHAEuONy6U+7WyTGSTZ5AjAP5849QjA5MFUoYWDyztdrPS7ZuR2JPsHP2apLskLKOtnb5xLD7jPc7B0d+WgYwLVDn8gUWgy36S56KwnPXu5gG6wDklUAIJeEBWYh1tvc98fCksWuyuuAapysWefoKLpT1j+A1uLRrrl7pw7wDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9441.namprd11.prod.outlook.com (2603:10b6:208:569::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 11:59:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 11:59:44 +0000
Date: Thu, 11 Dec 2025 11:59:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 13/13] docs: fix TSO feature status in i40e driver
 documentation
Message-ID: <aTqyKzdWYNL0pIAc@bricha3-mobl1.ger.corp.intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-14-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209112652.963981-14-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0327.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::32) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a84ec0-a0c9-45a1-d7ff-08de38acc5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+6bEgxth9xsp4d4XxvR+/8x1Eh8BcyC1CswzcfNyx2kAoon63Y61TedAf0LT?=
 =?us-ascii?Q?+2UxfOhmpKOfZjsqIh3iuuRGXpVGi+XQ5LmA+wITHq5CL7aEi7mGCSSBmpAd?=
 =?us-ascii?Q?Jb/KsQmd11YW3oehnq5qKfnR32wzt3LDKHH3FmXkNAySDRAhKmHfJMqLsSwi?=
 =?us-ascii?Q?ujRmxt0H2cX6zBUhum+KROjQJDLbOImp8AaSrGPIoNGq+bmVbh8Lo3yC/VHe?=
 =?us-ascii?Q?vR7horA+DhorhGDzGCIUgCLV+eV9TqduIe6VlfgHybgu+RuFmjg7r+VVJTiW?=
 =?us-ascii?Q?IPcHDB/ppbIpbJWAQb+bfYy9q6KdBumqu+R9vbBHgkJKBnltWZukYkWfilHZ?=
 =?us-ascii?Q?cZIyZMVJ/JBUEBPJnNwc8VSPx4/xf0tlDwysZ7YCDuJRJ3PX3cZ7cwDEfnUG?=
 =?us-ascii?Q?uExBR9VZIh/mvwdRs69jJearvG1lsma0JqgOdYgdRHduiFDt6/QaCX5dvoGs?=
 =?us-ascii?Q?MeP2lUh3bgM5Nu2Pf7fuMQBHrsaaiwHi2IfD0uVwyJPLxl2x1MasA9S9hIYK?=
 =?us-ascii?Q?8bqconpYIniVqjuVe/oclotdYLfw98q3N9arqZFen+3XZ1mWQqv4OLuWrJwI?=
 =?us-ascii?Q?SMAajwZgGzP3d9OneF3ziFsMw0VyfQeewzulUiIqjXVOw/EhwrpDEkjbr8J1?=
 =?us-ascii?Q?8Y55NaGnb1IpQTkMPU8AKUjPa492sPJUcCxwAkpn4G1yF9QVqXmKb7PQ5mn9?=
 =?us-ascii?Q?cFY5Zn9b007Ad09y7tbcq6snmBtVXVeTejw7Iw3sVV/9hf5LGSUTuYaB79Ff?=
 =?us-ascii?Q?zojySWIGeTkXw8HPToF0XgytAsYdm0Zch8WIcIZRfW74e+0TZy4U0ig/iAA1?=
 =?us-ascii?Q?Xm43G6V2twp3KbEz/7mS1pn0yx3gPULP3IvWgAW6vkpk+p1PdFGvUdCJoAx4?=
 =?us-ascii?Q?ZDCZzluVJ25Fcybrzrg8mZYn2hcuJhz43xuhwrBM8PQTyvYmYF+ZlcpYQ5/S?=
 =?us-ascii?Q?tpwYd4x0ebUmX3RkIBc6RFU7gNsp0e6zb6NkwQhjOjdLJh9r6GfbE3vpKEwt?=
 =?us-ascii?Q?aWWp/ibv55YgiPrs92urwW1ytrIOBORM95w2xdDxv25oKHaTaVNiJqaR4cwj?=
 =?us-ascii?Q?O3YsDf5ABLwPewVAaD0pXZQcRUGntiKJgQlByAbhfYrrxf2bRrXZZe1h7v4O?=
 =?us-ascii?Q?s9XgBf5qQa1EUWNXmnRAz5xm/A1Ej5vlNmia15r9V50LNIxpT/3w6ZAgarTd?=
 =?us-ascii?Q?jKhQOMG/A9Bd1siJzgsWJeWuUmn0Sa5KawI+0PpTLHl9qgOEvebSndBK9HNp?=
 =?us-ascii?Q?dhmuFYL2q2R/zZ2hBIs4jha5uvNQ2y7opnXo0DK6UG6xAobJZf+N27tSCPOm?=
 =?us-ascii?Q?EhVkMJTXq/xyF7xfX+BRskNbHG46Nrg1duytzwTt9T11Ps4pekzl5cPw1XCl?=
 =?us-ascii?Q?2a+WpoKyXRK3t6N77jA80hPKpU8odq/NXRQi/WWkmHB9NClcUfYuGVPhny/z?=
 =?us-ascii?Q?+HPHXhvvUuZh1dz7AjASBRJ4X0coy8js?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?28ytz56TFvVrN3pg3mNPQxDYV0NtOVGk/c5imftF+yqDKGll90CsrqbBW6kB?=
 =?us-ascii?Q?wxVGzilB1mcfI/z9VJ/S5sHIyUVK+hm9+68Xfn7O0NdcMbMbeTg/dlcwOp75?=
 =?us-ascii?Q?BZiowLqMRbjHkbacuJw+1NOCEQoz4Ni4sWlWJqZVpV/kgZpfWMBs/aRkSoS0?=
 =?us-ascii?Q?9fFNcfhia2zOaqyFy3B6Nv+v9zlC1Lzo37G+H4p8aSdoLElYu92qsQgH+OJj?=
 =?us-ascii?Q?KeYonl78OdJ+sXrOFmYr4ebDwRHZ93WaGB8d51aWblf57rfXI7YcT/2bGaac?=
 =?us-ascii?Q?TnpWhvLY4W0P1F4FNZ627qhuUmg4imGpYkIl2ab9/XyviF2BHYwegAkTf9+K?=
 =?us-ascii?Q?tmmWzFBALHP2Q3yPqCu6HTmH5v0tpj75SG/IU7RjYNr5zM6lrzxApuyhw+Iw?=
 =?us-ascii?Q?cL5YN9tpSjuFK/9NAedzdAMmvGj1C4tPTE5duhTCIzTHSbjrFJj/SJLM/lEZ?=
 =?us-ascii?Q?12EuYlTxaqgtMIA/mnC8bV7UlCWCzDkN1qFb/qxQfBDKuOy8Wi1J9oHd+iEn?=
 =?us-ascii?Q?cGn5gRMwiGdbCGuRmajjZ5D5Uu67knQV1QQoEeeDoimeZRWD0EDPmx4ifQaS?=
 =?us-ascii?Q?1il/FFNrcDE4KsW5ijNiaxASSq1lgNLQKC7YgiULN+4op4l8T9UsS14Y8yuC?=
 =?us-ascii?Q?b7utwvvs0prJxXWHk7hyF7fAQvvE8cd8+lUElb0MysaFRGVWs8eQUAmypMTh?=
 =?us-ascii?Q?wDNfdHXS4BjD+YRFmkCX4ZsiVb4Vqo68PkLGxalDB05HYA4fHZrTk+eowtsg?=
 =?us-ascii?Q?xHXZsSmCfoTNhx2oT0OF5fEYrxZlemqPopjgYFBYSV8w/RISzk1gyFxhVUn3?=
 =?us-ascii?Q?S5ipJGkK5WwfESsS+3RT7bFJl512vyB25sVgApn4Z37s+6mkXyLBeQb83Dc7?=
 =?us-ascii?Q?BzKryulNcBZBUczAYJGumgrvZqeOgSCMIBzkNMr+PoC0eetF3xFD1tyTg+MO?=
 =?us-ascii?Q?H3RPJ73ijZASlbG6swLLboNZT7DenLohLLAiNb2BEk/v1DoQ1Gb4AdBvoU68?=
 =?us-ascii?Q?8dkHpkLLxgMwrzLg78ZZ4xF5d84cftS/FoXZaKfKgByDs++CSCqEu359Eckx?=
 =?us-ascii?Q?O4oC7MQ75+ijxnV1RRFU6gDmOUQszMcNUNL9WduDY1zbfyBFs5DrQ0p8qNdM?=
 =?us-ascii?Q?WWW1TuMyHg5w6HFiBRVBTBZUYILwsmewodsdTsiHhhMw1v6rN8TGuQEFXbOY?=
 =?us-ascii?Q?j/4dKxlzsBR0n+n3M0IHgR4zyKWqQcAktol1B9TjcJf0kVsTWNx6oUY/WQ8C?=
 =?us-ascii?Q?CcnNcYwzfIL7elKLC8eNXpkrsv7lwhkzhUN7TZVAbfqsCz1BZEekat9NPgq2?=
 =?us-ascii?Q?vcAzBIRgq4y98FzXusVGZfBg82gD4Dvnrn+C2X6dRK19+hul7GUb38PeF/l/?=
 =?us-ascii?Q?g7IO4EJj+flHUGDMrhYUDrq3H5SguoF+3RzGRenIBDDoh53LEyWXxrYkHV2u?=
 =?us-ascii?Q?+YNFzkTdsNu8Yohd/kYlhbuFhuG6aDSVocFZO0VW1CqjL1KCUdA27RTIjnj8?=
 =?us-ascii?Q?1+3gadmyK6jgY3u/utkRby5oRXP/0e1Xw078fUCugVI8yqjWkGHDvp4rrbel?=
 =?us-ascii?Q?lQiH+u8xbRRrB5IhH0gtY8cgrRsqBt3lgNH0i7ZGhDyZXx4lcbioNKrOB633?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a84ec0-a0c9-45a1-d7ff-08de38acc5d2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:59:44.4174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7YfsUXS7PER85aa/dC3xgEdT/iziBHKffYyRg8m3E69rwhDufgjUAd9N4b798O2JbucE7ob0wWYEMdAGEAsvszo298w3UgRkmEa4iiCYco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9441
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

On Tue, Dec 09, 2025 at 11:26:52AM +0000, Ciara Loftus wrote:
> TSO is only supported on the scalar path so change the status to
> partially supported.
> 
> Fixes: 9ed94e5bb04e ("i40e: add vector Rx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  doc/guides/nics/features/i40e.ini | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/features/i40e.ini b/doc/guides/nics/features/i40e.ini
> index 4610444ace..fb00b69830 100644
> --- a/doc/guides/nics/features/i40e.ini
> +++ b/doc/guides/nics/features/i40e.ini
> @@ -16,7 +16,7 @@ Runtime Tx queue setup = Y
>  Burst mode info      = Y
>  Power mgmt address monitor = Y
>  Scattered Rx         = Y
> -TSO                  = Y
> +TSO                  = P
>  Promiscuous mode     = Y
>  Allmulticast mode    = Y
>  Unicast MAC filter   = Y
> -- 
> 2.43.0
> 
