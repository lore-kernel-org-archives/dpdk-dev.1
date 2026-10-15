Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1A1CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4533B402E4;
	Thu, 15 Oct 2026 19:09:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C8BE24027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:09:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792084188; x=1823620188;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RjfOyeMtPEbr/Vx2KLFwaXKnjkj4feYKRbGm6w63qlY=;
 b=RzomW6nQVy+g/ViT0TwyxRQWkSUy6fi4qahSMgw0txpTA0TKqB72fCyY
 Fc0jgdBWE484SdD3rIaAA12Z2UgHzeX9xg/Rmbq8qnphJHL7K6Y47f53c
 gKqys9GcSHZ5h+f6wXa2LnK11pD6ephRHtIOXKwilcVDZVqOqWAD4OCNz
 /r7Q4NKmHzwJKkxCWbEIZbK1q1Iq8YCLcVNdho5HBVQd0YORKjhlQqiY5
 b8ISW0Plf3PzBH1zDrqM/Ap5yGwuP+vRlghzFnA661BTmKZFVW401gfFi
 VD6n+tH4dtO4XVi3IwICqg2DUxCap1DeigRj+3YDpzzIf6gOUSM7so58V w==;
X-CSE-ConnectionGUID: e96N3OKjTCqZfEDfJqYWyA==
X-CSE-MsgGUID: rFZJgm+2REKvx+Cb8u40Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="759507"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="759507"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 10:09:47 -0700
X-CSE-ConnectionGUID: v6V29q7FTHOy7YPmQi0epQ==
X-CSE-MsgGUID: o9td3DDHQ2Kr3bSHJWEXBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1701930"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 10:09:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:09:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 10:09:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:09:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhX60qmYZyjdVewCX6kO4j2geOfRP+efGebMJ3ej/W5t7rMy3EfRcN5Kidf7dsseppcHklJn9Ib45aacuOhmHVLDEzLZVsG+wgdoch8gjMNLmmTCerQmrSxmZF+14WxyccaKSVh7mUU03XzvdVY0BMF780tdqmIkTuxk6P4tbD3EGSZqanozgaN93Vd01BPjMy5hW7TGMlqq2O4c81XiS9rqVcTl/5HIqve+FsajvQRTSG7BLdVS44sUcrfKN3Nnpu62BJEKVzExzpUUjmyHQExlgjFmJDQh/pVnOUAVhTbC0bRRlt1aSU7dKQZpfGPr6bzpunYFEDIcM4fKrIavng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuJHoMBqB36nLlqSYg0gribvgWibRzb5EnStr17N+kk=;
 b=dQyJ5pFI5/R7CSh/hrEpxeqLSmfcwaecgGHAvEJD+GVwVw37e7GeyEMw/NfQ/QWlJl0ZKu7zjIC71jmGBP52uGOXMWxe4nggkw2xSepJucdZrsuXdoNc1fAt0chKc+HC4mNI2trnB3q9niRCH+9QDtHvC7mvcxcmd5hCUKExlS1HyS8rO+fEOQgkedjbCFlN1G9r1Fm5JOzZyVpOa1xnhmK+V+pHkzYkfmYg1Wd5sbfxyqT9KJE81tqsh2IBQSfoYnrPZjVxFrDYF3IZT9Y+T3FaAwp0GwxA2wcE6Repikl9ygUZ7GP060JCCGOO9SR9GA6LvOmzFCYivDMNOGGEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SAWPR11MB9547.namprd11.prod.outlook.com (2603:10b6:806:4e3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 17:09:43 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 17:09:43 +0000
Date: Thu, 15 Oct 2026 18:09:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 1/3] net/ixgbe: avoid private driver include in testpmd
Message-ID: <atEI0t8DcVn722R2@bricha3-mobl1.ger.corp.intel.com>
References: <20261014203435.583064-1-thomas@monjalon.net>
 <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
 <4ee35150-a166-4a6a-9be0-71f4d2fcbac0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4ee35150-a166-4a6a-9be0-71f4d2fcbac0@intel.com>
X-ClientProxiedBy: DU7P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SAWPR11MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: da29310b-a879-4427-c558-08df2adf1afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: TmxCU0g5w1FIdMiNbZVdQh5UeClNdsG/Q6QmnH7jEa11j8ulur1HuqgeKgxi/vwTygqHES3WRVQ9NrRPla3VAEI5IYlNhMkMIgkfZ3FC33TO9e6ZVE1VwBQQlk516NYROjdxut0d535FD1GcbCMN9EBI7shpL/xEibxg6dcqezgfUa7oSRyCdfnprAD0aE3dSrCrAX3HzegJXdwLI4B8y3Ln20shb6Yt1jbkjMgdFxaR63TgpQFXk8g79Pmx1TpuGrgS82eBeEmirkDvZIrUmDqzviJEZ8nl50i654FEEOCifrSBY7aHOwZeeUjU5RpfGPO92bUY3pN+JKEx2rMe3mX+ZpfzDyE9yuDy+LfosytaAfy/8EL1NkGXEXcRnmdWM1u3mt5NIAL3LrZs2+2Kbfj9gQ2ukOI8Pm6LWC5M4R3aUAkF3GRM3ANZcvMqa6uX2V+aQ0fj7jbMuU3Tr7EpxJXoUf0DBu7GzF/ofL/KYVf2YyhUu1ipceUriQJzEa4XLMeKajTrgWCGfovoweGZ7byQyZe4KWymvsabZ9q0IfQyjiUEuuPnk0tpzcwDEScMaWAqC/TdWQmaFFVLY8m+Kf5ZgYhNj21YeDDsRCq5yXWqwYM84UBsj4eLLgVumpm5AalyuO1wm6A9U/uA4QJ31mv/8E8beNbRQK9RSjhf+FM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GuGBbBt0BU+h2M63swBAP7I5Py/dTTfYudX09bEOI1zjE8tpl3gOU2Dhwvm/?=
 =?us-ascii?Q?lmF9kFhMK8xt36A58BdN+pPmoQsjOUJXnFeulj+tpby20r8+n8UcU/FdEJnf?=
 =?us-ascii?Q?Si4hxIKNa/phPpHe9Q8oMb+uh4uf7DK2Zs35VCMucTRI16zQERvayqWnWKeI?=
 =?us-ascii?Q?Ccd4l0O3Z6Xi2izulfgTs4++D4GmwgPWs5RvZ80XlzNSRCqLbB69KD2ruoFy?=
 =?us-ascii?Q?/lTtCRXj3u5Yvdg7cCr40g1CyW5hBhcSSq8rTFF1S8cJyDrn9OSN250uq18p?=
 =?us-ascii?Q?ySveFpKsZsqOGbjGvH6kqKyR/ewVbldMWkhzTmD3g+h5V0+N195R/ZltIJ/8?=
 =?us-ascii?Q?pFe1M9khciNd3qLL6Earo18l7q5ph60UPDks5CzvvOcmpQ1NfYunXpzPJwx7?=
 =?us-ascii?Q?SMT9+vIJLqMElJ5oqYCxPQI3AlY0G7huH5nVv+86DJUnxyR5rWoNTQ53ZvVb?=
 =?us-ascii?Q?lQ/q3nB7cYclm1xu5oiWlBpXMGxPslUM/dcLkymQbiJbcPmHMSERjYwVu5P+?=
 =?us-ascii?Q?/F/EJX7bTMtFug216OWPl78ReC5EASXtK5Z+P7ydKJDNC10uncKdhkf0lwwb?=
 =?us-ascii?Q?345EMR5qln7sQ0fq8Q6G7184ijkuktGauxOoywFahkbo1nw1uhcHRiQWWnZs?=
 =?us-ascii?Q?jO7AXgx6CCnvQxPLATBrhq8FFa5E5hZGGORP2dTn/nuCeYX6r+g7+7i+71Bs?=
 =?us-ascii?Q?/tsDido9UGpt7uBWydCIjljyhIPPA+cXfUOFG3H5pnvkqEPpj06eOKI+MFvg?=
 =?us-ascii?Q?etRopFCmknxD2+7vQRIhoKwnWUQlG26kQkVt+om/E7gI6/oieuDAkJ6cNpQ9?=
 =?us-ascii?Q?S40hi8yl4oKUtgUpUQYDpN3mICAYZIU9wMuPEBGHLWNq+mcYoNzsPZWSizTJ?=
 =?us-ascii?Q?0ytUjaC45W+HRzSoQ5fBrmK3xTWq4OK3yJDWQopocAZMrjCwF8BkwAZ1g66L?=
 =?us-ascii?Q?H+OFNtqhF7sys5PyPF01SppCIOYgFMketesQWK//Vpf3m2v/9yrlAJh3aXwJ?=
 =?us-ascii?Q?YPHG1v6Dr2XAqiwH3zg0ENcheIkMGAajFpORTQLoOL4/EHxVFas6ft69tvEZ?=
 =?us-ascii?Q?QkiBe9cASfqXhxV7Q1IDf0B8IquFMTn5bEZlz57b8nBwsHpLOEAit0Xw8dUA?=
 =?us-ascii?Q?uTnV+K0VGWl3jlXPylCpZQYzqJg6PsM2XGPCkxMWYTjUPiEOP7PWVopbk9Hn?=
 =?us-ascii?Q?YxERbIvHCAZ83CLoEG3WnDqjuSXv7B31/n2cyjyKXdgYxqfOl1haGosHPICa?=
 =?us-ascii?Q?D8t81VlI95Gi55FYmcYnV39pQAINvHPnPlGXItDKdG7MqgKmoPSC2z6JA1Pj?=
 =?us-ascii?Q?TM8Q0BIfy4qtU5XTuVQafUDBJFgMzWCyOHyVIewlGc0wgZ8J1RduWT+fM9Pr?=
 =?us-ascii?Q?EOeuFlSitEzlP3b9ziSTrjHE6gj05Vbh5+IJFk8/tiBaqBq4YnyqwuV7yxhe?=
 =?us-ascii?Q?/aEI/RGfgngzjVxpXOwXdQF4oGZxirzZ4tCp4iUntnvgW/vnbn+GB85dd3ZO?=
 =?us-ascii?Q?xyO6hUuGQy4yYAmB9aK3FtqBfOU/gbByKHCuHRfy/rLy7wYOp4E3hmhTFnNj?=
 =?us-ascii?Q?WfvZWB4sZfxDx0+jV4rWJK8azfgEp09eWpd/LHyRHZjfOC+Q0s3uEiBQCkpq?=
 =?us-ascii?Q?REAXZ+7z0HEJ12sUTJc9GfGEnMO1aydFA0lphZ6DK386tjw4UJRol/f3S2wu?=
 =?us-ascii?Q?FEK4YTxPU/0kzaV2bLJX0dkPk4SHD49qMv/6nnrks2mntQTa0xHekfwbpkP3?=
 =?us-ascii?Q?cgBVUZvpIVxfzly4MxvRur8STQiCzpU=3D?=
X-Exchange-RoutingPolicyChecked: w+wX5To8Ov2rGx/yHWjqDxpy+YyGU1mWRTKqaLx7fgsPZGBf/Fdvhe628F0O3RuIBbAgh4QVZxiaSCSwPOwPik7908lqvndWvgIeqLd0WVchx5b5s2d9Y6U1oxSnyycN8VONTvxP+l5BcVTs67hfBBqRhZroTX7YfE/DxhwIWCfWLM0R3Jbzs9LCDNBsH1rRXdnUlamj3nLSNjHp65AidztTeuPkeKDsQHScENUHlezl02NPlo55LyR0z6QBAPqQThyyu+Vju3QzXzGj1DXEPWfwiKS5Ci08wkw6SYqbcyPFOnfFQA5yMMExAapT5Mk2eAjIyGb9KVOqLsHNxENPYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: da29310b-a879-4427-c558-08df2adf1afb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:09:43.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR1uLly+rzz3OnXhqkkvZS2Q+LxRFDVFPAxomNzgJgQnF8+S/Afi2G47WVStjhmF9PlCo7W7Dokxf9w8YraEyh4jsTJfUQa4EfY1ZvIFHvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9547
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

On Thu, Oct 15, 2026 at 03:44:33PM +0100, Medvedkin, Vladimir wrote:
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 10/15/2026 3:21 PM, Anatoly Burakov wrote:
> > From: Thomas Monjalon <thomas@monjalon.net>
> > 
> > Testpmd commands should use the driver's public API
> > rather than access its private structures directly.
> > Note: ixgbe_testpmd.c should be considered as part of testpmd.
> > 
> > ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
> > operations are available through the private adapter structure.
> > 
> > Rely on the public bypass API to check availability
> > and handle -ENOTSUP in the commands.
> > Remove ixgbe_ethdev.h, ethdev_driver.h
> > and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> >   drivers/net/intel/ixgbe/ixgbe_testpmd.c | 55 ++++++++++---------------
> >   1 file changed, 21 insertions(+), 34 deletions(-)
> > 
Patchset applied to dpdk-next-net-intel, ahead of the flow graph set.

/Bruce
