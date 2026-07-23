Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1854C531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:35:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6AD4068E;
	Thu, 23 Jul 2026 15:35:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1610740663
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784813735; x=1816349735;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Uycg8ZrngybKJW1XGjFNNKxrnpZrSxCsw9qzEpJOMeM=;
 b=berA008dpehlsDby52K5lNFNTRDRfJsbV7KTolrpTlw3vcqesEQvtrAf
 7jk02nGkdE0SByBNNJtDMm5CsKiAzctz5fP03FdMYOvzor5GBSY21Lgnr
 U/uGWYs/ueIlIs/qDM7o+rcY1e61epxoQarIJ0v5bYKvba/OUyb0uOXUG
 CVOjK9hkOrBTTcsx0VeVVbjSwE+bCWxXymavmPCTwh2Z2v4oaAf8SRpuz
 uDfZjnj5OE6YSKUjijQzC9UNgzSuxIk84xiVNZ5khujOBeZQ7aqBQFQUo
 wAX/BQFYEFpJAEnKgMyRdwNXPm1Prr26p0QEZMS6sbqw4eINI4XozedhH Q==;
X-CSE-ConnectionGUID: RfGiwnZ7RCqawb13r3YAyw==
X-CSE-MsgGUID: grunRqFtRaylMhWuLRv5YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="73012906"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="73012906"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 06:35:34 -0700
X-CSE-ConnectionGUID: O6Q2jrS6RWOEKQG9oh373Q==
X-CSE-MsgGUID: gbakTDlbSJyUEwTnXgphIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254483737"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 06:35:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 06:35:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 06:35:33 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 06:35:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U78TODNYBinh2qYLNFF2Ph4tn10XFOQkrEjNeVLV7FMvHukW19AxUEqspxtwagUEDJ+N3DbIZ9RBoqf1nXyVEeyJmhOay72iFO7QAa/kLGY74OChTS+ENTeK56Q28YNmET0WcRWw48NvSorxvYCN7ZCBqN7xV9bwHlp+05/QbxLYhm8yHRGOaJsIKVhA/Qk7CiBD+i5pD+kpizp1hGNjJBdn4fmRTJEbu3sltHl69r7G1Jx0lxKm+Pfe9/hIJqtBtcNmMswu8ZVm+wIMsYV4E4jIFWuWILdqof/pzlIua1rY/AuI/s6Vl3v0fk1ejWgtzWyfKYCwlCvA39nF99ZUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u242wCin0JLZ+am+UJawNBn5UurIxK+D3Cr4wCSPTcA=;
 b=mYsGB3wvRKqUc9OH3Uo+EU2weVMdqKRDkFbcL/DVaIySiZSE6dibWtm6IFmnwzIn3GODXWv2AsvuzCZbH1iTuVSknm+AzWcRTsnKkMZGytR07XaTu8znCnKLXsNILqMKiAbRJAU0NRE4/oozNkhh0D3lxdutVZPjN4e65rY51jRoh1v6U27XWB1gRgvCuBqgxnorNFi7OYZn/3/7BOK2gsp+mcc/dAiKwHpFewM5TVtIqaAZKi5kVrx1RNmhSxHup2oxTtzGylDSkGAeZcTnGJYhBLRqgUeL+JPP56jhCRlNJ3Flz6jGubwwq4Ea5x+z9QklPLzj3hLn3VUYXdiEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 13:35:31 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:35:31 +0000
Date: Thu, 23 Jul 2026 14:35:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <hkalra@marvell.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: Re: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
Message-ID: <amIYn1U_a0WmjMSs@bricha3-mobl1.ger.corp.intel.com>
References: <20260723131908.3313223-1-david.marchand@redhat.com>
 <20260723131908.3313223-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723131908.3313223-2-david.marchand@redhat.com>
X-ClientProxiedBy: DB8P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::34) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MN2PR11MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b672cd3-d5f2-455f-7f5d-08dee8bf441c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: gZg2W42KjFakVYtokmDpGwMdvCCKfl0CG2qcYXL4VtVHT9goePqul0AN0Tqkxuaztc63nheNqxZAbZJ3kzRhEVUyBwMgb5WMquL6SrkdvhjRM6JIKuSH1YbXgDtqHvu3Ibp1plkmyPc8U3/1Uvb8FzW/zrJoU47JYz+e/+DXHxrWO3PeK3ICoNziAxueB0MJA2xfmHI2lVc3IbL/mee932Ti7MuR0VplGlakvKx3r4wrlXn4d8XXHU0JBauAxt07ZautzM94BV+S5ku5LMKi6X/ZJpcPHrO4EYyrShfDHDV+Cr266CF+N6kwsqFnxlaYn1TXZeXZ3dLOKd19nRRrfB+M9N0/8YY25Euzjyw1lS1jERO+WooqS5Vva1LMzwWfW4jSzAEG2hjjylkM+fPg12nmtZYoesqM8tqSyYCJWSBekvIMfu5OJgUhdQrQzxLM/WQhKeSDsTSs7rTheHF4jUeRB674kGEtuPi96VXyM2+bxNxk3iOgH/CsGfsiZ8hQPuFuTFN80IVzNXKy/hm0I5jh19nZ188KzM0x6QPO/gAoQ+/DwQBZ8km9F8x5zCJhz3OYZ9iNK6BMZ9NYTvWKsxxHmIxx4sPbQovzA7H684KnGrxX7JUy2OaALIZOOysNJVBE57ideTHv0mA9MRJDhFESlLp+1TvYSj2ex+VMfLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GrnUdvm9k/1ox3e8RR9JtLB1QXMNm7T0IABw1kw2ZteSrlEbDRKXGdacPoqo?=
 =?us-ascii?Q?6kX3Tq8/nlvDflUbvnqo91fLEfjQ7lbgzqoT43WfGvUdzCOrcSGTi+h6kk9a?=
 =?us-ascii?Q?YAhIzTaa3YHYJ/4sfieA5YPHapFMgUt5+D3FcdYy5VgiTNlNXXgH4O2DeGc8?=
 =?us-ascii?Q?Oi6fa2gH7kvNQCEOgv2She9hvM2TZnkgDJeU+EiwBgs1VV2N9FmJYKWCCH5y?=
 =?us-ascii?Q?Vir0NknC8RCwcB15sazn3mHic7EwLWZJ5uqXiuPoFSGWOl/D9jmxxf0QCyUD?=
 =?us-ascii?Q?Ijgvqq6uSrJaGkKtXbjrw8DcA+V+uULYNKgPYi5fBVR+zA+VlDtWB7mHrEzJ?=
 =?us-ascii?Q?PYGXX4knW3nwbKjrdLBPCI49n/8acytsUvfJ+Patfrn3bkq8guZP3uIOeJBh?=
 =?us-ascii?Q?WFjt6ByyAO9FmtoC0nNMs1YWhSddnnrFGAU3bElumaprXjt+nacA4XouMp+S?=
 =?us-ascii?Q?+C667rgP1BzK2oAlvdxBJHprEvt8NDNOY6Io0pzYWPNmM4+Z52cZEGXVepoO?=
 =?us-ascii?Q?Ct5GMXOeEQqFvZntjOuaS6WYc12aS542dk/WCuTHZgkbjeaNo3zG7p2XmfJa?=
 =?us-ascii?Q?3VyDYs5pp5r8THWBWfyTZptjo4Mvcz4AjsRz+MBjwbQQFXCCVkOuccXIcytZ?=
 =?us-ascii?Q?Clf9djEu63C/crxIPbCnDG8Pyxf5vSoB8bSdKOJQtRnxnlrW+2cra1mhny9A?=
 =?us-ascii?Q?qkh6P991W/GU3o/WR4f0MePBCpw3HUtSx4Hk8AjX5L1naQd1Hx8oP4xmOAq+?=
 =?us-ascii?Q?hARPohdz9GHL/9duoeloAIZG0+LtNvR595zdJpU5vYRaPcp9y93+2yIkeKDV?=
 =?us-ascii?Q?ylTjXkSNf2f2oB1ir6Gh8DzYHAYnRCK8b+Q0IdEItwcmXSKt8rAcs64egXyt?=
 =?us-ascii?Q?eta3nBn+Hvo9sRJV2q5Mm3Gj6+75TGFFmzkhLie9niHDtQ1AmnjYMpkDUCdK?=
 =?us-ascii?Q?P3CN1ElNxt1PllhB3YTvVLZClIK7uEcYmNCadA96QC6jj/Vb3vfYkHcef/pN?=
 =?us-ascii?Q?joIKc+6gjWUv8SF+a8hnM47pZ0Dc1d+3vt+xrcfPrtsde3e0tLD1ZYpMeJOA?=
 =?us-ascii?Q?6xJrM0C20/HJS+U86Xja70YDXrXXsXxzH3cu6F90apN0EBcZunVh0VWJSVZU?=
 =?us-ascii?Q?p8bYqwIC0nuAG7r4ss/nOO+PFkHvpDQujF82YmvrW0LbzNMw01SMgdhWMbL9?=
 =?us-ascii?Q?ozzQdP9doche4tqSWMyHDGhvRQygXyRNn+sQ6wFVCuf0C0EEAzJXim/Ze351?=
 =?us-ascii?Q?nv9j9LXjUdxGveuIu7N27PDE7vLWrukMeQa394uWat0bGUHgCBtoK6eZvotF?=
 =?us-ascii?Q?5BC5ZuZ7L3hU1ooYUICOR136qnDAZIKHG/XSASepOnN+NflofjW6M2IxDgPg?=
 =?us-ascii?Q?2ToTPEZT8X3qIdb/8HpqbaV3ECjOrDNYEZLFHx/BI3WRY0Iii4B16x6AcbUL?=
 =?us-ascii?Q?u5wycIFevuSLKlhbgIyrRrGBKoMr5XlHV0+uRf+UQahwtBgVigf9p4pNExmX?=
 =?us-ascii?Q?bKYVIeqwJv07ZfOcyCe6QEboNRtU2cmG5pmwDTvKlqP/mZ7A/ZeBpWisz/Jl?=
 =?us-ascii?Q?nRXcVvYxD7h2g9givdVjGQ248TWdsSXcaNfVgYjA5dccutIjeMtf0b1V5IXD?=
 =?us-ascii?Q?b8rx5EXQzUXJGLZbJpeGYLwW29FlAJQw9GWZMVygNeBViIRZmVJ3Rt5sNWnX?=
 =?us-ascii?Q?/QGLVOnysgZsj61wcrCUgDIk9gQKsXWMCxJ7O5mWtgSMSOa2D4c0LsmemPbb?=
 =?us-ascii?Q?SATZ3rje3w46GePK14Hj3lHHVKavajA=3D?=
X-Exchange-RoutingPolicyChecked: pTXnm122ty+fcC7Se7rWkH7ZOC5IEGcckFFUuaBCZ/uL9DMdEDf5l5U6Bzql+aFkK8cMqxDZwlrrygJfTRXMwuAP2QmE82YcuiSRYGbXlQVcHqvrP6FABfBYYSV6/TFQJoKnvRToQn+Top4fqPQu2U9HuoJDHZFxGeR8q1Cb4Mqo2IK142J5DPBr4LGZFsl5L481BUxA7rieY6yaOoYlowmLWRk8GmpDl0uoCfwty3d7yfQVZISks4IKmmmByySCltqybYS/d10J8BqeMcecoIlnytajv++KP4OT1+QiYNU87oXBm0DlL1BUjijy3SJcqVsRtw/lpba5XiGzRPbltA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b672cd3-d5f2-455f-7f5d-08dee8bf441c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:35:31.3218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1CU+onuLWWG5PMoXAruwc6CE50EPcSWv/NNzlg85CMvVWjIvHQas0BiZHPyxSamTpRS1R3bjEkeJwCYi+HFVSwrVN6wG/bQjpDaF3yMr14=
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

On Thu, Jul 23, 2026 at 03:19:04PM +0200, David Marchand wrote:
> A 0 file descriptor is valid. And a negative value is not.
> Only close a positive file descriptor.
> 
> Fixes: 5a60a7ffc801 ("pci: introduce functions to alloc and free uio resource")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/pci/bsd/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
> index c6df31d486..bbe08605af 100644
> --- a/drivers/bus/pci/bsd/pci.c
> +++ b/drivers/bus/pci/bsd/pci.c
> @@ -93,7 +93,7 @@ pci_uio_free_resource(struct rte_pci_device *dev,
>  {
>  	rte_free(uio_res);
>  
> -	if (rte_intr_fd_get(dev->intr_handle)) {
> +	if (rte_intr_fd_get(dev->intr_handle) >= 0) {
>  		close(rte_intr_fd_get(dev->intr_handle));
>  		rte_intr_fd_set(dev->intr_handle, -1);
>  		rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);

Unlikely that we actually have fd as 0 for this call, but change is
technically correct.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

