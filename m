Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA91D41C33
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 12:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF8D406FF;
	Thu, 11 Dec 2025 13:54:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5A4F340151
 for <dev@dpdk.org>; Thu, 11 Dec 2025 13:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765457655; x=1796993655;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PKk0LJ2D5871b25jOI5iroVZCVnFhARZlHT4H0bNtG8=;
 b=ca+szYYKTNluYk2pV7S+OpFhR3O2kcTvQAtd3ZO08uP5BNGPivKT0Kyi
 HCHAhjYHFs2TLoL8JkLDlHZ/AsTMcfPlZWI+e22pUkZhdR57Nk0xrhF0T
 AkODdekMhG/KVnpEUofzcKbREqO739J020GnGa510XLeBrK8BrsAhZiCN
 lo7G0QY6CTkJ0CSlie4t54ZcpgSu4k6T1wRu7oUhzKdcPOZ5UClKrgsN+
 CK+5P9YHydv4UDrwZC4wRTG9TuKIwH/6etqWVGg4jdtmAGqVi73R1YgH+
 9FSnCf2WG9ZHg8fMiKyrRpFhOKzkCf7+/bk5IK8dUKCVTdvFpjxWfEArA g==;
X-CSE-ConnectionGUID: bl3gyD4eRdeaXmL/2VdpGg==
X-CSE-MsgGUID: raQunQzISrG4gvj1alATQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="54985621"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; d="scan'208";a="54985621"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 04:54:03 -0800
X-CSE-ConnectionGUID: QEDcFqWEQNWPiQ8WbqIMPA==
X-CSE-MsgGUID: cu3W7XnAQnOHaV3yPht5Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; d="scan'208";a="196057382"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 04:54:02 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 04:54:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 04:54:02 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 04:54:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrAR99i7yRe06Ah42q48XV0oOR2lPd+5quMUVtRQ+3ktFDrVZYk5AYTAAirQs9oMFIdwMgd9OXsrGoNYdavKKqFPPIK3p/zGLUCcM+EfK1DLxSGDvUUoUT58bXnY3RsdJ3BXCd9Q9zjoHeDaQbbwmsZ9K+Ph+A7KLM+1mt6WDg63/ftTX+RPigicibKSZO+aDTaqJH3PwD8PqRCS/xD788pt1RkSceVas44Oz4SMInIUPdsIXxcO5bRdgSOBmzooOEQbyaor118FQ66/m4Yc1vUiC8JLSez/hmgU/BcsBVqrFw78JytbQZ04aqcdOrPU1BqeE3VhKwVxK7DbI4NDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBaH5hriCZNs/VqwHaLOiTK5y5a8z205KZrlZrzviKM=;
 b=JeXNXCUMvGmFI1zfRFX+53Gx/QajXwNP9ManRWaO2Oo+p3oObAUlgNtu19oF4Yv09MIUhsq4oNgbf6RH3KNklpl7nORiJEsPuJswYgTf6TFebdd94NY0Es72yjs5d5pGkzCkZ7BamCeL4uVPVAjmQ+o1kmRHM3y5HglJDjfzPEHNx930mzrss7lqUceizHMqbIePevEzD7MOYPi9VY/Zw4p+mxhPIv/NOiGFAZYrINRrUqqE8gaz2zr+I1hAAKsWjk5U+yrIAVcZ0HbtbKQFiw4cdyvOsZ9n5UCBlFpB1iP7EC9Q9PotZHD8+JH06o0AlCDYCcppsPOnRKAQJqohHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7093.namprd11.prod.outlook.com (2603:10b6:510:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 12:53:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 12:53:58 +0000
Date: Thu, 11 Dec 2025 12:53:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v10 1/3] net/idpf: enable AVX2 for split queue Rx
Message-ID: <aTq-4ShHJyOhIOVh@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20251028142202.137392-1-shaiq.wani@intel.com>
 <20251028142202.137392-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028142202.137392-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:10:234::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: ee92e944-898d-4b79-74c1-08de38b459be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Om1M6sz3XWBX681jxg4HQ060UZQxhT1q1C4xv+ureAR3xPXhVghajNzjhz+F?=
 =?us-ascii?Q?yvwwsocFhomBZC987MQ0VO746xCN/A9iy/Xcey8hXZ0aEuvMYCpDTgKaMvHa?=
 =?us-ascii?Q?xUUvV+Ucn7kIEuJj8dOzEuMlexGz04GAFUTjatXN9RFoa/iTG4JLo3HaUkd7?=
 =?us-ascii?Q?rBJoMEtyG1El8VPMRvaQ7Us84YajDZ2GfmzsZ1DOCS+IKr5gKFWUvWfAQhr5?=
 =?us-ascii?Q?yTPB45haH9MdjtQKE4qKkhctyxjd7qOv/YoCVW4mkQgdDQzUQykKfxzbochi?=
 =?us-ascii?Q?S+axdIEfZKT1yUshv0EBOr3fFhLgmjYsTSp1zGffrDvCycx9xFerUkcDDJzF?=
 =?us-ascii?Q?d4IFnWwKMkPt3D+Z3e5vkBS6bztM30c2ArZtdKrMnYg5rZUojcHvCtHCF3jd?=
 =?us-ascii?Q?B+tg8iq1F+g/tnnE+dNMNdZCfu6upaUGhGAVkxilOTZhD4PnpJOWks99WNBg?=
 =?us-ascii?Q?/8y3Eau1befXNSOAH1Rqaoj3waJ6sjzbgsbavuc6TcNE5ZMzQJiH83koEjyv?=
 =?us-ascii?Q?suxyoljBe+bBcvY5gbpTuI0jbnf2rAjq2RIWUgtBEDjR3TMMuu9RJIxj5Q7X?=
 =?us-ascii?Q?xwYTOLPaU3qk5R3rol59Iq+YkFgVVafmMGgpmyoIvUqOY71gZwsHexAWiVrD?=
 =?us-ascii?Q?UqFoCwu78/unPamDlp9PRhuuytNjYj4sZw8xLtBHEemB+BQnmpOxRypyEiFH?=
 =?us-ascii?Q?tUlKkABkEzU2p16CaGdaoIFUZIBXHmhLcD4XZbB5ZYDjVPV/7r40X3E86PSb?=
 =?us-ascii?Q?9uiQ5qd5v70uJXFiDHcH8xobccK2BNjoIgHqAFG/q/fW97h1oZMqlG4rvCvA?=
 =?us-ascii?Q?bQoI5O4bGwLb84wB2iM7OCm4GqwtmW7jlG4D1pP7szsSRHaA5lhpswOBCL4k?=
 =?us-ascii?Q?RIxk11eNYi/4f2KU7yuST0NrI57fvu+R/EygP3Y1aIHZnqGTK/qy7vTw2Bko?=
 =?us-ascii?Q?Hgg7aO8HziS6fTR7yKlGHxq4R8e/wM0WxhtrhtJBO4q7asKfJtSCdzTYkrrV?=
 =?us-ascii?Q?hhMSPbLkTwDTCPrmuHRkLJ+rxwAy4OzgNwNDftXjkWlqt1t3Vqyh9kZ4WRyd?=
 =?us-ascii?Q?Poi+VtVYTAybHDvd/xtvSBtMAIj6TEdPvyX3bWeaaAe7Kal7PHSgBA4Q6D5/?=
 =?us-ascii?Q?iELF7+a4htTVJGeNeQELJwL3mdHs3NkkvZ7HGQaz+6q+KQCA8HeFJOB0hQUZ?=
 =?us-ascii?Q?bEgVaNjKzp162QuIETheFH2Ra4PIde6gOGNhHaKTaRK6iIPigXKli5+cM+t/?=
 =?us-ascii?Q?LLHTN/paKSfP3jWnv8SA812Jb/hFsVS6zrA5waENQCv7p/hWcmdRuKvNy2Wa?=
 =?us-ascii?Q?7fZc1TMGSWTH+0MWV24Ks8eborBjL8fMqflYg1+/76jEk5TLeu/fslQ4smHj?=
 =?us-ascii?Q?pUYWXSDwEk2E5HbYh4BEGWHQRrKjKDgnoskrSYvo6djYlHmdAZ2Y2jN2VwH6?=
 =?us-ascii?Q?DIYqK/oGz4xOaYpszojylUTMWnjq+YhK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cfs3yVGoIFk4wTM6GUqpfJy9oFyA/2pILBFJh2Fs5Eclsn4fbjKaZhEuDtNd?=
 =?us-ascii?Q?TaX/3lZdYIVhvFVa3Troj2ofKT4MzmhTCFdZV0Z5Avc6D2+sSw2ok4GhuYc2?=
 =?us-ascii?Q?KWU91R2Dam9UGcX/r3eMsAm2Mz3/Xsf/X91mL1LTvhwG4LF3Ib5Cg4JSXO6K?=
 =?us-ascii?Q?j25p8yFRNYGsywJrblmKXxIX1bQcO2bkhKd6jl6QcgurzIiCkV4J1JqHrbcI?=
 =?us-ascii?Q?hOh0GPpDBo/a0ujqmL3YkGO1SNIYq36Q7UD70Fb14AygZHhoxdoofMtE/PAP?=
 =?us-ascii?Q?zhsNSjSBZuWqYFM6+cPAwPPrsonfPCh33nbis0SM4xhfMJtkm815a4YXqBFy?=
 =?us-ascii?Q?SHnW6bM5DTdDkU6DtcgiFpAWf4EkdzPHGUbuIu/yfervyzZfjCt3x5gHx3AC?=
 =?us-ascii?Q?l2OXwnrIyVIhYERj+Q2Oo6kImuFBwTyxJ7fmO+L4zOjbr635dVoHCRxLkn6L?=
 =?us-ascii?Q?2HMWkcUmMWurJ3Fr4huRIeqUgC8e18zIPLhPkmnrXzn8LVAcfYSkF9YcYoB6?=
 =?us-ascii?Q?Xux69BJo1Xi7KS6rokXEyonXaYN+RW+Lu8uppTusKKWAL/ZRPwFigm+wg5Wr?=
 =?us-ascii?Q?bpkBGwxK/kyMPDH81e3JsK2deNDjBO/rN/eaIh3WbNbeX0woRyxNXEElCauE?=
 =?us-ascii?Q?UaiqBugmBBAxxgr+e7QOvp8Wbo026OpbrayOjZAnKBmTW0gqylCaxA1gd9Lp?=
 =?us-ascii?Q?a8PhnRfG9oT7aEjRw7Ayoq6KP4KxFlmvLd2Zv4Kgp5c7Zie8oq1hVBIrgXI+?=
 =?us-ascii?Q?T5jKdqjO980lFaF8fXKdfYh7j0XnnY0mY3AQQ4tcshS4FMna8k83/wP7q+Cl?=
 =?us-ascii?Q?D2rcirq/JLqWwbr7udQs3UvAlX25cOMIjMRWcMrScRfdPzwJr/7cCmtmxh1I?=
 =?us-ascii?Q?abHigfFsFq0v/mrMshsWCnybFhQaiOoHILxnlOyvqPO6HT5wK8akr816ijEp?=
 =?us-ascii?Q?7g0zwpXbEkZXHHA7JcMKZDpENXT+8Kzz14lF18dzRbuk1tXmWkELpTz8AgrZ?=
 =?us-ascii?Q?1QAnWZbU0wStpgyVO3usCZwdQbwg40RKYOL/JOS30kkYDBjQLbbcengEQRqs?=
 =?us-ascii?Q?a0hjYjKjBvUEsqbfw+QSHj1RJJigu+W9zHGC17AHmhBLWTtg22qpK5b6Jlok?=
 =?us-ascii?Q?KcmOWWS7Rqdpoh/oGYMblKkEscHlfoW/V0nwRSgLGpzlFPBEOwe7KGCV9BKp?=
 =?us-ascii?Q?RlBOCxBVp3wCAJAoYPk0oolIX8s/x1pk0jr2a6ddcc79ONLjgzwaOe9Ef1m0?=
 =?us-ascii?Q?EFN9TpIOEeovsbYsKuHzjs4zaL/SH7v0i4qNjLclRV7mui9ceQOroNxvEq2g?=
 =?us-ascii?Q?WcePCDUolxQzxkjZ312sfKJTMm8BLMXiASvnRQ/h3HuHNqHiaxGdpgQx9e84?=
 =?us-ascii?Q?DEKzH0qBfFKr2HukwE/VpBYADXogVVMqeTQ6eTzgejTLoUQamNxy2axXUf+e?=
 =?us-ascii?Q?0Zrrq+hcmjl1CGlUK24JiKAQDEW4Fj1uGqXSOFxim/d/uMmCpSv6cRv47EIV?=
 =?us-ascii?Q?1XMmLbmoD4RccDBlWZ48cZwnMXGPtm+qzAbyV3DsY/K68ibNMgYS8mXZHA7G?=
 =?us-ascii?Q?bKf5GFV0xH54n1RdJ2Ln193i1zk20dwwkl1HSwd6PZacpKQP6y+sxoaqAWJK?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee92e944-898d-4b79-74c1-08de38b459be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 12:53:58.6946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkleiWk0pne3mIzAh5aAzWRiNk94rLSYjUf1gdHQOn/3RyMS+Zi7lvddxnMQoYtgUvhVGKRoXG12SGd7CQpmjCic4I1BuYd+sXrrwLZzZ3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7093
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

On Tue, Oct 28, 2025 at 07:52:00PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>

Haven't review the code again in detail - I assume it's correct at this
point (V10). However, some indentation issues are present below.

Regards,
/Bruce

> ---
>  drivers/net/intel/idpf/idpf_common_device.h   |   1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 ++++++++
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   5 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 139 ++++++++++++++++++
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 -------
>  5 files changed, 204 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index c32dcfbb12..74a5495d59 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -70,6 +70,7 @@ enum idpf_rx_func_type {
>  	IDPF_RX_SINGLEQ,
>  	IDPF_RX_SINGLEQ_SCATTERED,
>  	IDPF_RX_SINGLEQ_AVX2,
> +	IDPF_RX_AVX2,
>  	IDPF_RX_AVX512,
>  	IDPF_RX_SINGLEQ_AVX512,
>  	IDPF_RX_MAX
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a5d0795057..ab3d088899 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -250,6 +250,58 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
>  	cq->expected_gen_id = 1;
>  }
>  
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_splitq_rearm_common)
> +void
> +idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
> +{
> +	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> +	uint16_t rx_id;
> +	int i;
> +
> +	rxdp += rx_bufq->rxrearm_start;
> +
> +	/* Pull 'n' more MBUFs into the software ring */
> +	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
> +			(void *)rxp, IDPF_RXQ_REARM_THRESH) < 0) {
> +		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
> +				rx_bufq->nb_rx_desc) {
> +			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> +				rxp[i] = &rx_bufq->fake_mbuf;
> +				rxdp[i] = (union virtchnl2_rx_buf_desc){0};
> +			}
> +		}
> +		rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> +			IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
> +		return;
> +	}
> +
> +	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
> +	for (i = 0; i < IDPF_RXQ_REARM_THRESH;
> +			i += 8, rxp += 8, rxdp += 8) {
> +		rxdp[0].split_rd.pkt_addr = rxp[0]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[1].split_rd.pkt_addr = rxp[1]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[2].split_rd.pkt_addr = rxp[2]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[3].split_rd.pkt_addr = rxp[3]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[4].split_rd.pkt_addr = rxp[4]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[5].split_rd.pkt_addr = rxp[5]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[6].split_rd.pkt_addr = rxp[6]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[7].split_rd.pkt_addr = rxp[7]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +	}
> +
> +	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> +	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> +		rx_bufq->rxrearm_start = 0;
> +
> +	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> +
> +	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> +			     (rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> +
> +	/* Update the tail pointer on the NIC */
> +	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> +}
> +
>  RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_tx_queue_reset)
>  void
>  idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
> @@ -1684,6 +1736,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>  			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_256,
>  			.extra.single_queue = true}},
> +	[IDPF_RX_AVX2] = {
> +	    .pkt_burst = idpf_dp_splitq_recv_pkts_avx2,
> +	    .info = "Split AVX2 Vector",
> +	    .features = {
> +			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_256,
> +	       }},

Watch your indentation. You have a mix of spaces and tabs here.

>  #ifdef CC_AVX512_SUPPORT
>  	[IDPF_RX_AVX512] = {
>  		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 3bc3323af4..87f6895c4c 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -203,6 +203,8 @@ void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
>  __rte_internal
>  void idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq);
>  __rte_internal
> +void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
> +__rte_internal
>  void idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq);
>  __rte_internal
>  void idpf_qc_rx_queue_release(void *rxq);
> @@ -252,6 +254,9 @@ __rte_internal
>  uint16_t idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
>  					 uint16_t nb_pkts);
>  __rte_internal
> +uint16_t idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts,
> +				     uint16_t nb_pkts);
> +__rte_internal
>  uint16_t idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  			  uint16_t nb_pkts);
>  __rte_internal
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 21c8f79254..2ea957ded8 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -482,6 +482,145 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
>  	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
>  }
>  
> +uint16_t
> +idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
> +{
> +	struct idpf_rx_queue *queue = (struct idpf_rx_queue *)rxq;
> +	const uint32_t *ptype_tbl = queue->adapter->ptype_tbl;
> +	struct rte_mbuf **sw_ring = &queue->bufq2->sw_ring[queue->rx_tail];
> +	volatile union virtchnl2_rx_desc *rxdp =
> +		(volatile union virtchnl2_rx_desc *)queue->rx_ring + queue->rx_tail;
> +	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->mbuf_initializer);
> +
> +	rte_prefetch0(rxdp);
> +	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, 4); /* 4 desc per AVX2 iteration */
> +
> +	if (queue->bufq2->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
> +		idpf_splitq_rearm_common(queue->bufq2);
> +
> +	/* head gen check */
> +	uint64_t head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != queue->expected_gen_id)
> +		return 0;
> +
> +	uint16_t received = 0;
> +
> +	/* Shuffle mask: picks fields from each 16-byte descriptor pair into the
> +	 * layout that will be merged into mbuf->rearm_data candidates.
> +	 */
> +
> +	const __m256i shuf = _mm256_set_epi8(
> +		/* high 128 bits (desc 3 then desc 2 lanes) */
> +		0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
> +		0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF,
> +		/* low 128 bits (desc 1 then desc 0 lanes) */
> +		0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
> +		0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF
> +	);
> +
> +	/* mask that clears bits 14 and 15 of the packet length word  */
> +	const __m256i len_mask = _mm256_set_epi32(
> +		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff,
> +		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff
> +	);
> +
> +	const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
> +
> +	for (int i = nb_pkts; i >= IDPF_VPMD_DESCS_PER_LOOP; i -= IDPF_VPMD_DESCS_PER_LOOP) {
> +		rxdp -= IDPF_VPMD_DESCS_PER_LOOP;
> +
> +		uint64_t g3 = rxdp[3].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +		uint64_t g2 = rxdp[2].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +		uint64_t g1 = rxdp[1].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +		uint64_t g0 = rxdp[0].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +
> +		/* Extract DD bits */
> +		bool dd3 = (g3 & 1ULL) != 0ULL;
> +		bool dd2 = (g2 & 1ULL) != 0ULL;
> +		bool dd1 = (g1 & 1ULL) != 0ULL;
> +		bool dd0 = (g0 & 1ULL) != 0ULL;
> +
> +		/* Extract generation bits */
> +		uint64_t gen3 = (g3 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +							VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +		uint64_t gen2 = (g2 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +							VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +		uint64_t gen1 = (g1 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +							VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +		uint64_t gen0 = (g0 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +							VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +
> +		/* Validate descriptors */
> +		bool valid3 = dd3 && (gen3 == queue->expected_gen_id);
> +		bool valid2 = dd2 && (gen2 == queue->expected_gen_id);
> +		bool valid1 = dd1 && (gen1 == queue->expected_gen_id);
> +		bool valid0 = dd0 && (gen0 == queue->expected_gen_id);
> +
> +		if (!(valid0 && valid1 && valid2 && valid3))
> +			break;
> +
> +		/* copy mbuf pointers */
> +		memcpy(&rx_pkts[i - IDPF_VPMD_DESCS_PER_LOOP],
> +			&sw_ring[i - IDPF_VPMD_DESCS_PER_LOOP],
> +			sizeof(rx_pkts[0]) * IDPF_VPMD_DESCS_PER_LOOP);
> +
> +		__m128i d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
> +		__m128i d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
> +		__m128i d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
> +		__m128i d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
> +
> +		__m256i d23 = _mm256_set_m128i(d3, d2);
> +		__m256i d01 = _mm256_set_m128i(d1, d0);
> +
> +		/* mask length and shuffle to build mbuf rearm data */
> +		__m256i desc01 = _mm256_and_si256(d01, len_mask);
> +		__m256i desc23 = _mm256_and_si256(d23, len_mask);
> +		__m256i mb10 = _mm256_shuffle_epi8(desc01, shuf);
> +		__m256i mb32 = _mm256_shuffle_epi8(desc23, shuf);
> +
> +		/* Extract ptypes */
> +		__m256i pt10 = _mm256_and_si256(d01, ptype_mask);
> +		__m256i pt32 = _mm256_and_si256(d23, ptype_mask);
> +
> +		uint16_t ptype0 = (uint16_t)_mm256_extract_epi16(pt10, 1);
> +		uint16_t ptype1 = (uint16_t)_mm256_extract_epi16(pt10, 9);
> +		uint16_t ptype2 = (uint16_t)_mm256_extract_epi16(pt32, 1);
> +		uint16_t ptype3 = (uint16_t)_mm256_extract_epi16(pt32, 9);
> +
> +		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype1], 2);
> +		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype0], 0);
> +		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype3], 2);
> +		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype2], 0);
> +
> +		/* Build rearm data for each mbuf */
> +		__m256i rearm0 = _mm256_permute2f128_si256(mbuf_init, mb10, 0x20);
> +		__m256i rearm1 = _mm256_blend_epi32(mbuf_init, mb10, 0xF0);
> +		__m256i rearm2 = _mm256_permute2f128_si256(mbuf_init, mb32, 0x20);
> +		__m256i rearm3 = _mm256_blend_epi32(mbuf_init, mb32, 0xF0);
> +
> +		/* Write out mbuf rearm data */
> +		_mm256_storeu_si256((__m256i *)&rx_pkts[i - 1]->rearm_data, rearm3);
> +		_mm256_storeu_si256((__m256i *)&rx_pkts[i - 2]->rearm_data, rearm2);
> +		_mm256_storeu_si256((__m256i *)&rx_pkts[i - 3]->rearm_data, rearm1);
> +		_mm256_storeu_si256((__m256i *)&rx_pkts[i - 4]->rearm_data, rearm0);
> +
> +		received += IDPF_VPMD_DESCS_PER_LOOP;
> +	}
> +
> +queue->rx_tail += received;
> +queue->expected_gen_id ^= ((queue->rx_tail & queue->nb_rx_desc) != 0);
> +queue->rx_tail &= (queue->nb_rx_desc - 1);
> +if ((queue->rx_tail & 1) == 1 && received > 1) {
> +	queue->rx_tail--;
> +	received--;
> +}
> +queue->bufq2->rxrearm_nb += received;
> +return received;
> +}
> +

Missing indentation.

> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx2)
> +
>  static inline void
>  idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
>  		  struct rte_mbuf *pkt, uint64_t flags)
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> index bc2cadd738..d3a161c763 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> @@ -540,62 +540,6 @@ idpf_dp_singleq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
>  	return _idpf_singleq_recv_raw_pkts_avx512(rx_queue, rx_pkts, nb_pkts);
>  }
>  
> -static __rte_always_inline void
> -idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
> -{
> -	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> -	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> -	uint16_t rx_id;
> -	int i;
> -
> -	rxdp += rx_bufq->rxrearm_start;
> -
> -	/* Pull 'n' more MBUFs into the software ring */
> -	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
> -				 (void *)rxp,
> -				 IDPF_RXQ_REARM_THRESH) < 0) {
> -		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
> -		    rx_bufq->nb_rx_desc) {
> -			__m128i dma_addr0;
> -
> -			dma_addr0 = _mm_setzero_si128();
> -			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> -				rxp[i] = &rx_bufq->fake_mbuf;
> -				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]),
> -						dma_addr0);
> -			}
> -		}
> -	rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> -			   IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
> -		return;
> -	}
> -
> -	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
> -	for (i = 0; i < IDPF_RXQ_REARM_THRESH;
> -			i += 8, rxp += 8, rxdp += 8) {
> -		rxdp[0].split_rd.pkt_addr = rxp[0]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[1].split_rd.pkt_addr = rxp[1]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[2].split_rd.pkt_addr = rxp[2]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[3].split_rd.pkt_addr = rxp[3]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[4].split_rd.pkt_addr = rxp[4]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[5].split_rd.pkt_addr = rxp[5]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[6].split_rd.pkt_addr = rxp[6]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -		rxdp[7].split_rd.pkt_addr = rxp[7]->buf_iova + RTE_PKTMBUF_HEADROOM;
> -	}
> -
> -	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> -	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> -		rx_bufq->rxrearm_start = 0;
> -
> -	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> -
> -	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> -			     (rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> -
> -	/* Update the tail pointer on the NIC */
> -	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> -}
> -
>  static __rte_always_inline void
>  idpf_splitq_rearm(struct idpf_rx_queue *rx_bufq)
>  {
> -- 
> 2.34.1
> 
