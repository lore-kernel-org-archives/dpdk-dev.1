Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D2606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ard5ypbJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 846D740264;
	Thu, 22 Oct 2026 15:08:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id E7D0B4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 15:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792674526; x=1824210526;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4makHSZg1OaYbJi/GiGaWOADu2wWTdl+Ub5C2L+6kQw=;
 b=Ard5ypbJ0uIOBI+ytKiWbpQwbvzG2Y23m1W9dUj3MR4fShkP+19igu6F
 FgBcgTo3SuI8k+yY2TTAGWYU4L/dDGPY8mUCsFKOOo04i2yIcVCi8AJkl
 dge+GHPW/GpgzvpdgUkbMK/wPoZvlyYoSc75JEwL//yO5Uzo3qcXiSa3I
 r+r16IaHpZ3npT9tkiocZTGBLhMrxcCjxK7umz6JR1k0Njd3Kmhji0PNi
 LByJME9RgNL3MtVVKUEa4llhI9qcD+ICyNKoXlh+pnAEMii98t+ZM6zu+
 FcxBr6yV1yGQSYqMrfhShdZS4szYvcck1jYyXiUIN9QiR1560li4VliGa Q==;
X-CSE-ConnectionGUID: lDHI/+SPTQ6sPEFB6jIXsQ==
X-CSE-MsgGUID: 1XCQ5lDORfySNnML/ZBibA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1456681"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1456681"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 06:08:44 -0700
X-CSE-ConnectionGUID: 2eMHfI5PSn6MqK1EIwTShw==
X-CSE-MsgGUID: y/hWIjQHT6WiNiJR9X+ErA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3716946"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 06:08:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 06:08:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 06:08:43 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 06:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMpbErrchk1xB0JQN6q2h7p9o94nDW2wYQMUcaxlxEXHT2MFT7dtm3ZpQmvUI/55KbpIeF3l7sUceLnr2CLm8vxDcy0VbACaCxPijgZky1iQ0Mi87TPAbYwMg01YdAWObqQQc0QJEN3P8q6Syx21qP1CbmBbZiMIgOsxs7QPW+IiTq1vC6ewFnBcbVg8Bi/Y/cVHjJlZxGv9SvhWlK4yFw3v98PCE4VLs6B6WkHBm2tmwOGFGXuS6/06UIVs+NvySWMkYeBwWt0nbCIC9XOzkIlQH8zPeWXJF8o94MKefGgdKtH26jNaOMjfnYjXH26U03ZNd32LOIG7KyNa0EkTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKYhM+eIUZfbNKw1lOwTcffn6tJo3aHKvUpS3tE8vBY=;
 b=O7hUjgNJaFDTOIB+d+kgTewaf/lK4odYTHhwHeRcCsueHTo6sZcCor7Ikh9sT+5u3DpKBHSPi0gCBxEYYKDqxq5+YoA1mrqDAUq927bZOFvRBbat3IWHgpC0uNkYO39fb28IhCKAvrhWcxKtAQ3ou1DNfAqkOHGVpyMV+dwd9PQv04PRlF6pqNMI+UNa4PZdksB6LA9z7qFmSFFaSjRt8f5khXg1ux9zq8J3kNVKoEBegO+BTIDhRYiAYxPsKaFRtkBDmOxqOXno00O5JfTCfgbi+ueHwn9cbq5DUQAv0jx6/LMw+ihD7wo+9ufBlg5kUkwNicxJpTaWU7UeuQtlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PR11MB263615.namprd11.prod.outlook.com (2603:10b6:8:509::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 13:08:41 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 13:08:41 +0000
Date: Thu, 22 Oct 2026 14:08:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Ting Xu
 <ting.xu@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: Re: [PATCH v4 04/10] net/iavf: fix memory leaks around IRQ resources
Message-ID: <atoK01Nli2pPfElk@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
 <595c771fac2dda2d602c01ba171d56f3419db917.1792592724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <595c771fac2dda2d602c01ba171d56f3419db917.1792592724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::25) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PR11MB263615:EE_
X-MS-Office365-Filtering-Correlation-Id: 47399f9f-47f9-4d33-2878-08df303d97ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|5023799004|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Uqg3JU63lJnvw4GfS3A9GVWN5WdgixF7xnp17NoIEook7McOeHfHzjWrXgviXQl+62zKY3qY5gVrIY942cjWB0eBcDgzobvNvNYBFTBQG2jpcw/vL/5sdu4DF3U7891V3RRw/SDE6/fxbWM3wDqKv3tECkYBQ1hdJszSYAjvXmR8To06o/Who30hHjEpuzI/GvlcFXzowUFoMR3StReaVq6Y1uL/0MCNNVDiQwVUm85DwpGoylfLc1vgevIfZTkHtMyIaIGhtdFrQsScq3TLE29D7li0MZ2I3krwFb1WSujvSncP/O/OHZ1+MZUATswHiOimhIbQhlmAkvEgniXamzWpZu9OY1qYfCftfNNjB02MZzlltzpo6DFH79JZqyAEThGCD8lv7ouMvZ3IBLRdiCNOvBIZrc/htfi5vY2H9my/8UTQdbfBNALuvOe/yCZOl7l1AlbKu9vpREKtk6TelMWo3w5ux0OqMa6sQVWMix1HVxRgjkE6ePwqQSscb232wxoVJtx8CFzOI7+Gl50OzJvHrjishO2DpTq9SvnE5Y8JCi6nZQGErVMla+/Jh552dAOPYk3W1cP+S2R/Rdw25bYxR21YHYr8oBCBcNCvxZqi0jV+PZVWFUVkIf4vzYjCluS/acCtYnp86jx19PbOSjyLRYvb6meIDoMJHQnhHdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(5023799004)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wRk+1zf18CpBJenLqJ+3S0zFBgN7Xc21ehXLcQ/5JkfjFIGkByJxOVfZnhdo?=
 =?us-ascii?Q?whHMtSmQPTxE6xTopzf+p63AseVoTtzyzIXfcIpGoZdorYZFmxcaHOw2Vhqx?=
 =?us-ascii?Q?EOuZyTetvv5BuB6frNdIBjFGNgSL2SR6H/0EvvFsRpE4xEpzTPKwuzKqGzNe?=
 =?us-ascii?Q?OX4LAcQT/lBc4XgtHrsKWWKLafXT92nwRE3mu3MkUWsvudVrJ7wfHd8rZUz7?=
 =?us-ascii?Q?W4PS1n0AQu0KZvdxPj0Wn9WrQp6INthZo/f5+qkhjT0xQZ/bVS9pm2NFVZbc?=
 =?us-ascii?Q?0Y5oPaw+tCae/xk7DWIn/ZTJBY8EEDZqAXROa4LNjC9Kg/VBOtxMkYj1rTb+?=
 =?us-ascii?Q?PmOD0QGSOVDI+ivO/ro0kxM5dmqCH6ocM8OnhI+MZ+srU5nu4klXD3a/tQpR?=
 =?us-ascii?Q?baWpLdRNxZUDBJFSEl1CseaxOfxR2YyUWUIQfWjaS8DrBBu31bCHVnPILxIh?=
 =?us-ascii?Q?raZbnnMDNufCog6oJFpSHjhmafgx3gsgWJkG+xLYex1BUiKYxXExUkaDQ1HG?=
 =?us-ascii?Q?mzzHpdsMS80p0OSXNXWH3RBiJTJaOoC43Iq8EuCT4KZaDz56tHt5LB6lPUzX?=
 =?us-ascii?Q?gkNIgobkLwHJifXnKLCqy7XPNbyzND2A1hL9GcPiY0Fhck7KGjxEaZIEn/VH?=
 =?us-ascii?Q?F5b6ySHaX3Fu0epUpOtBh58X0oKTA8F0U/yQsPh4i5J9dPjlM4z7v+L2XDkx?=
 =?us-ascii?Q?xQGBXjQPYpBnSJ1t7/fq/RAz+u8f8sfWadcUwqVK+4KU2KshM4/Ou8xgpNaa?=
 =?us-ascii?Q?8P7PXtok7oMotUtflkQIDqXtrE/ZU2YtOFjrJ2b8xZFGPP+1+9f3xZy1LvHl?=
 =?us-ascii?Q?J4KibD7nsXZ1dQ4e153PZRebPUym7mDAyCfGCx4E46XZ7xFnXTZG0AkVB48s?=
 =?us-ascii?Q?6yD7Z4/y0is6dpPHdRb7afOOg3vpdhEwJRIQ8YvRpxc6nSvuTPSbCGQXUef5?=
 =?us-ascii?Q?s9L+afpZqx9WTMB6iRcyvgiO9l7Cs8qe2tCkGl6H7rKtYQN+JB/csXQ0B6Jv?=
 =?us-ascii?Q?8lOzqTi6YnG2EkfSUmDwQtfJ3FfR5BYsmch8qBL3CX41W9jrd0p/p8/eMqYN?=
 =?us-ascii?Q?7tgM5bu1MJVRGI+gQmKc96bCPOJ4dDX4f93sHWH7VXozgF9UbiIrjInuIiEE?=
 =?us-ascii?Q?dOO/uuwOtrC3vF8Qf/Wm7ztSeROlPuaREHvllIdle9gsUfc3iAZgIxn07PRD?=
 =?us-ascii?Q?wlAOu1a7KQwpAAFBvfdyF7GKXd5pWLZiGVmZ20WAQuW/hujw8geq9Cb+HEs9?=
 =?us-ascii?Q?B/GxSxpuATQKl60qZP/vS/Jl0J2v5doFu2nlG5Ap8j51/bnlD6QJ3Sx9MNno?=
 =?us-ascii?Q?tNd/MvfRNANohMG+nijFbpOrr50iroD5T7rQs2wuTdOno48xRzMNJLSMyevb?=
 =?us-ascii?Q?TGye4HwLAD5ES+HZDZrVdMVzUCmETLHx0LqtzIlszD0I+jXlWbvQ86xcS2yM?=
 =?us-ascii?Q?vcBM45rXzqTUJqNT+VmV1JFl+SzThDr975kdSIaZIP2HgQ9ZdHF7v3CMXWr/?=
 =?us-ascii?Q?37MkXdVSvzw4eks6i6uC/2ppAU3/Z78gnMSoHUyHwcdhhR/eehznUaSqfZ4V?=
 =?us-ascii?Q?WoRlPbH0filQQ6VWw93eRBlZSrmIFJanZvCCCpvi8/Uzgq5VOmAEplZYBq9L?=
 =?us-ascii?Q?P8oqfIKYpKkbRa8UdYeNyZUFtSZ4+m7Pr/7olycoc+hnZnbU3rAYie20Vamw?=
 =?us-ascii?Q?NtvIruvJx4LFe6/vZnJ5elnt39KpJUKWbsXE8I2zGkuCnckrS996Aaalx0gQ?=
 =?us-ascii?Q?mzd99k0MmQnrlIf/1w8MfZzn73mnrTU=3D?=
X-Exchange-RoutingPolicyChecked: dEE8SrAoRizQpNrusTK3fHWfcr5IELvZeJpCGc3ZZrRLpNbnKyg6lTq+TJ5yiPMcD24OYlPVxi5d5W+GGy3KnxRYcNEki81sdKiv+vLMAys2Cz8fHkxHT2pme5nqPL29EZaFD/KkkYT17haZpBFpAiAycTLcmSkyH/1jMnwEi1LC4bshcY0oQAO5KDSQLir6SoolYYY4/Up54UFPzA/hTbd9buEDP2/qX4SWY0tgZoonuCNt6zw9oOkj4QStzX7uft0ZYmZq/rgL7V+fnzglZYfKGk26h1Tpd24mzoBQ68Ywcg6+yx1QNAJgPoXN3cOfJDl1yWtpMZwbENKA5v2UhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47399f9f-47f9-4d33-2878-08df303d97ff
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:08:41.2661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hspKLrXqN/wtmD+QA96Yq81MjMPcTl08ilR9uu1F1W2r1maPdo+N2ajS4xwbJmHqa3kZGu3GzjS72yr26SFeVCyj1ihgLszV5MIkFGcyJGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB263615
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 03:25:44PM +0100, Anatoly Burakov wrote:
> `iavf_config_rx_queues_irqs()` allocates a queue-vector map and may
> enable eventfds and allocate an interrupt vector list. If queue startup
> then fails, those resources remain allocated. The queue-vector map is
> also retained after a normal stop, leaking it across start/stop cycles.
> 
> Release the resources on failed startup and free the queue-vector map
> on stop. Clean up eventfds when interrupt setup fails as well.
> 
> Fixes: f593944fc988 ("net/iavf: enable IRQ mapping configuration for large VF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index b5beaee8604..891880cf6e6 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -863,7 +863,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
>  	if (rte_intr_cap_multiple(intr_handle) &&
>  	    dev->data->dev_conf.intr_conf.rxq) {
>  		if (rte_intr_efd_enable(intr_handle, dev->data->nb_rx_queues))
> -			return -1;
> +			goto efd_alloc_err;
>  	}

This change doesn't make sense to me. If the enable fails, we should not
need to call disable when handling that error.

Independently AI review flags this that you might want to consider:

Info
Pre-existing and not introduced by this commit: the new failure branch at iavf_ethdev.c:866 calls cleanup after rte_intr_efd_enable() fails, but that helper can create eventfds before returning an error and before recording the completed count at eal_interrupts.c:1580. The cleanup closes only the recorded eventfds at eal_interrupts.c:1623, so a partial allocation failure can still leak descriptors. Track and release partially created eventfds in the helper or cleanup path. Confidence: 9/10.

>  
>  	if (rte_intr_dp_is_en(intr_handle)) {
> @@ -871,7 +871,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
>  						    dev->data->nb_rx_queues)) {
>  			PMD_DRV_LOG(ERR, "Failed to allocate %d rx intr_vec",
>  				    dev->data->nb_rx_queues);
> -			return -1;
> +			goto qv_map_alloc_err;
>  		}
>  	}
>  
> @@ -981,6 +981,8 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
>  
>  qv_map_alloc_err:
>  	rte_intr_vec_list_free(intr_handle);
> +efd_alloc_err:
> +	rte_intr_efd_disable(intr_handle);
>  
>  	return -1;
>  }
> @@ -1034,12 +1036,15 @@ iavf_dev_start(struct rte_eth_dev *dev)
>  	struct rte_intr_handle *intr_handle = dev->intr_handle;
>  	uint16_t num_queue_pairs;
>  	uint16_t index = 0;
> +	bool wb_on_itr;
>  
>  	PMD_INIT_FUNC_TRACE();
>  
>  	if (adapter->closed)
>  		return -1;
>  
> +	wb_on_itr = (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) != 0;
> +
>  	vf->max_pkt_len = dev->data->mtu + IAVF_ETH_OVERHEAD;
>  	vf->num_queue_pairs = RTE_MAX(dev->data->nb_rx_queues,
>  				      dev->data->nb_tx_queues);
> @@ -1089,7 +1094,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
>  	}
>  	/* re-enable intr again, because efd assign may change */
>  	if (dev->data->dev_conf.intr_conf.rxq != 0) {
> -		if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
> +		if (wb_on_itr)
>  			rte_intr_disable(intr_handle);
>  		rte_intr_enable(intr_handle);
>  	}
> @@ -1107,7 +1112,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
>  
>  	if (iavf_start_queues(dev) != 0) {
>  		PMD_DRV_LOG(ERR, "enable queues failed");
> -		goto error;
> +		goto irq_error;
>  	}
>  
>  	iavf_phc_sync_alarm_start(dev);
> @@ -1118,6 +1123,13 @@ iavf_dev_start(struct rte_eth_dev *dev)
>  
>  	return 0;
>  
> +irq_error:
> +	if (!wb_on_itr && dev->data->dev_conf.intr_conf.rxq != 0)
> +		rte_intr_disable(intr_handle);
> +	rte_intr_efd_disable(intr_handle);
> +	rte_intr_vec_list_free(intr_handle);
> +	rte_free(vf->qv_map);
> +	vf->qv_map = NULL;
>  error:
>  	return -1;
>  }
> @@ -1150,6 +1162,8 @@ iavf_dev_stop(struct rte_eth_dev *dev)
>  	rte_intr_vec_list_free(intr_handle);
>  
>  	iavf_stop_queues(dev);
> +	rte_free(vf->qv_map);
> +	vf->qv_map = NULL;
>  
>  	adapter->stopped = 1;
>  	dev->data->dev_started = 0;
> -- 
> 2.52.0
> 
