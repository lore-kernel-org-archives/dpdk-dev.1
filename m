Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD0C79F89
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2AAA4064C;
	Mon,  7 Sep 2026 14:57:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 505AD4027F
 for <dev@dpdk.org>; Mon,  7 Sep 2026 14:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788785875; x=1820321875;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NB7Km+V+rSGSvliFqjXk7HBDT0OwA/ZvMmPIUUH4Rjs=;
 b=FtvMwX61pEc1lwPg1rYPzN65jkugF0KvA+ewUed0/FmV0rj43IfvUuYT
 dPrtij+ybiIgjoQGyXtEzt2ZxUL7RGMA419NN09BftHCgsDTdZw0FNe3f
 nO4sO2vzlyfUmq5Ina5rj6uZU+pb+WuvSH7qeY/yBMFruz1P4427+kJ4W
 EZVlVSIGdmVY7ZFOHaSIxKqtwo0VRlouLrZJNWjfyBsKq6bthmqIuaikH
 BQyu/8xSps1UJcOcxvdsHbKxm6nGoOsNx4EZZiVrVLiXLh+hLhafnGQ0e
 A9E1JLtgGXMpcpK9CNzSAigjxOGN2DonUqKcY2Q0splMpDMyRrdAqicVB g==;
X-CSE-ConnectionGUID: G7eWIwnrTmy8VuNo7h9anA==
X-CSE-MsgGUID: iYjSPcoMTGWz1XyI9Jvzhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="100709989"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="100709989"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 05:57:54 -0700
X-CSE-ConnectionGUID: DlscgyfzTtmM0BGrnH2lSA==
X-CSE-MsgGUID: kPKjiXzSRv21l9wp5MTyTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="268975719"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 05:57:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 05:57:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 05:57:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 05:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4WudE/gAVYROimhh+8fD187PUBEQ1R++q1QYYodwbKl3FmbAGJkg9MPJ+JdI9vWSotbPvmzHshynoRCkU+/9oVOA5j1E9cQV6Hk8ifvIrEG1if+AbJ/pJrjIUs8SG+kQYbNGfRMxBf+BrYOgR8Zuvlh6+plzmRWcNVKtrcCtR7gSt2vOhC5gzdXZO7HG75j3flGhveaEk5uL4N4wmhWul2W9UQgQVdS2RKzIdnqfT2ea30mvcJOmNFl64c8kfl0k7LzHw+ElwcRPEDSVfxTN7HOUA9n9IrQelX0lNrHyknfTt0I8tLtFwCD/4CokSaDSV80moKPbJdtkFamXXdd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1fxMD/nbgrag3n8k5uVUD1DTZ8527ovMxuMTJ2y23c=;
 b=bndiSCXdoHWnM1tFjhWm4nGqDUkbUFPc+zVizHH42htahk7QGg5nMDcrWhIcznRLGE6dI0iuM63O3wXbtjBimrDUrDlQx1jMeK87Up6kk/QNQITBDHOLeXlB1Mor/2DWI1Cca7uwjYSkLwcYkQw3T5LD6OvKIv7upxWus7hq0wY+7Y0XJ9O9DDozjfc7PptfvxDOz6TKVJBXN6hVQ8myLv8/FmeG1E6Lq6TUHTFJ0o9EKJJH1gdDgN/oKRpwQCF/r8vU5l1oyunRb2sT8c00+9SsQlC9q+ayOknaYFNBhYJJ/hOyWDrVUcCpN724rzlRGNKKT474oHhzZ8byK1GQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:57:50 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 12:57:50 +0000
Date: Mon, 7 Sep 2026 13:57:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 1/2] net/i40e: fix MAC address removal
Message-ID: <ap60ylEX-xAuROSN@bricha3-mobl1.ger.corp.intel.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
 <20260907111724.3043887-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907111724.3043887-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZP191CA0057.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af03251-0371-437f-4163-08df0cdf9f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: b0Sg6wBQpwn0EhQTdq7A5k5fDDZ2YZ4oEbnGp14FQry2wW8pMIXzhGw2DxepDjg+bH2yDj83cQ07YpWZu5rHS7QwOvqeqp+3mHv/b3H4CrBOD7NQg/MWoB3ZkZVWH52Hsz2Zw+6TndjITa3xZHQNyRx5Ya1SDY+q4tyVZkitxw8gXOYzvh1U9yGyiAszBxW4rwLQsDmVaKKR8jW4CjkxhJysTS2GLYeOV7/5iiWojHr9GBUDm73PqfTyQr1LEAtTt7nA9Brtsd2pVAChi/95SadR+tZih265OaDa0DNKMRJY3vJI1/Ligk6tfMDMhzrpx4/wiHlLS3ZMXkv/eu1v5IDK+LnNvhxiREJRqgeNZoYhxfo6oC/IJFmzZV9Te8hdQfRlFBYfVdvB1No6EtKdLxAkSczsf49LhBw1Y5W6BkX/Ws4GtL/+Q1TNz1mw1bpOrk2ceFc9IsOt99uVcZWL5an19pS/p8JOQQKPxX3Qy0luhhwCr1RhyWN9iFF683VBBKfaMg5cQKmHnaoqAq+uPM0CZkuiNzSQ1EbI0qkPihysMtDPm7Hao9fThKYE5kOD3QrWVoB6HDBWRZWySlce14YAhggXI2LXSGwyOGlozL+aDnB+u0FL5AvXYm7hQKCiADbRKCCPh/sDSvmNtiND6/QKO1iuzdF3Xql1a4ox/xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IzOFG8V35TcIKfBnFaxpegoWaq0ZWzPEKcCc33qWANW9JQInrMbllT3end8r?=
 =?us-ascii?Q?jh3ZBP5fdHVKizAceXYFVFCq8b2uT6o3WZV1O5op2+brN0duc3jOLJ+W8Duq?=
 =?us-ascii?Q?+aZx93HBbNdY35A/LGJOnDS9FvMrK/5kV+vldK4nC2kkM4gm9Z1XdtwlB08O?=
 =?us-ascii?Q?VZv1HoiE4UHyq5Q/DA37qEd2uuYwh3OUDDYKPSL2zc1ILgU2DcFNb4zNSX1E?=
 =?us-ascii?Q?evxH1anDWJyfkFYAkpf+82Dxpm1tsrbt0/LflI5NIPXdN80Ri55iBUokeSyT?=
 =?us-ascii?Q?eIJJVz0or5Vz0XiLdXJGIbScelOc1IJThrkQHH/TDl30y4rL09qbR5ll6d8a?=
 =?us-ascii?Q?gDyOvjjxtRPb5xtsfbqtZMQ9LrwHMUkQBUksT0h98KMad9YuWSUXyvGuK3nW?=
 =?us-ascii?Q?W+5br3D/DZOSWJld71zZKQDXX5qlOxIkcIE3ov8NbQro7XqQTGK0KCMIYFxa?=
 =?us-ascii?Q?zV93XX7OsPZERp7at5KSA4s2Y/HyqHkJAO6oumzkZEez3FuK0zC6ZgCWmwi6?=
 =?us-ascii?Q?e+DAZx+HIXU09RBNOGYygovjoCaXYPUY8DLyIV2MTY/2ORN+r1p/aiSUT3q7?=
 =?us-ascii?Q?4WkoDro2FJOcUabFn/AvVsQhXNtir4y5nm29PP0RBSVz4YO6yRrzhPugfhc5?=
 =?us-ascii?Q?3s55XVkVLItfsHVIgLU0LahsyM0MoV0q2jdPI6Ooeie5CsyigCZyrgs196X+?=
 =?us-ascii?Q?/47irkiW5enmJ6bmbRWj5JQOVq0xm7Q7Ueeilt5bhifDzpR5SirhgJQ5RGxu?=
 =?us-ascii?Q?UKxJsBXUhWo3LNgGPEt5ZVleZhZWvReRVZcJXAahyzc/6knLmLwiSxdvwFYQ?=
 =?us-ascii?Q?CLmHYwMM3f+qGyrC/MRt1aWj6p0uG1U5V+Ud0Bds9GMdbkISPkZ1n3mrOMqD?=
 =?us-ascii?Q?1ZoFV5WfH3Gh11k2CLD3XpUSe3gzzOlKR5BYOijdUFjEyfKZa5xYPyQbsJgx?=
 =?us-ascii?Q?wYWW4FTF0yD5jRJ5xK5ZQydmFIdcTzXwTCfLsRbLHE/YqBBOMBmR6bUnVU8t?=
 =?us-ascii?Q?vxxavQ1xo3V8L6yl1hsPgYlJUwrSlnSOaRMrafPWpN4o8pj1jNvop7jWRxnf?=
 =?us-ascii?Q?kRYA7drEc5sTrJ1VHytx4cpyUHv6JT6Z+uZzB3wXa0tfGr+sxZypj7aHAp8H?=
 =?us-ascii?Q?axJE1oEDBB0g7my+tWOqkWL9OWOxJ1xbNqd2JT7+4RxPy9lsHe4O7omZKOsk?=
 =?us-ascii?Q?fJjb2M8hhi8pWiVfS36Zm6VkiK1st8aN5IqVA+UK44bRfGx2jmGGxfLOT2Ll?=
 =?us-ascii?Q?TYwmz6Zf3NXnWHCDEFtM+rfRO6WrYUfkfsMSgBzM1QZerMeW438lFdax78nE?=
 =?us-ascii?Q?pC1mOed5B4zSSTuCPYhusb36huVxRxZm0P9b1TT6Ua4mkyv4ZfeIkkAConw3?=
 =?us-ascii?Q?JWjUDr7wGNoL8vffCGnRWhuSfk5QfHslEqCMT50uDjedu7OaMkIWHk3y266A?=
 =?us-ascii?Q?ms/MM3FSDUu4SCq6Taf96JMqgVavpnZi7rNFcRtOMuz4iptoPibc33daxhPA?=
 =?us-ascii?Q?jEs8egO9e/eFyJvYYlY9wn/p6pEKIBjlod0ew6qsAD9FR3c+cdSKkf8zmUnF?=
 =?us-ascii?Q?RqHC9wjVsv4550+rA59oi/NN6PCWe6JGGcdTfgbiFM3JcQ+ooQlJ9r63huDh?=
 =?us-ascii?Q?mVnvAHHA7ZsfKdmRel9GkoUibEwdfmeUtMfAs1sB22xm+QV7Ams/TzMev3ps?=
 =?us-ascii?Q?1WPVCgVQ8Jzl3Iy1PKDHTCl6W7la0gTbQI2Wmn53brh1w1jK8XMaeuA4PXfA?=
 =?us-ascii?Q?aM85m/OPi0QsG3ET52gNZC1GuUhq/Zc=3D?=
X-Exchange-RoutingPolicyChecked: 2lNnO1MDYQnzzc1YfzMJlIzuuR4b3zsunpW2rRrfFwPqeBvn+yDEYgglcwJd9l+DPVrJ0kDFTq3zgp0CFmOPbgVUU7waOnaumxhdJV/5ewYHaw5ofVktm7jUdiYJ3co8pGCofejxR6bBnP3+pD3yHnmgqi9PBwzFG5u+8HsEMpWRvqVR+KYEUtAMMfRg6Rm7j7EPVFY25yvGRjGgUDFKCEJ9fhczR+NkXamnsdkZd4rPYd/zWbbeb3Wztn0MTD2+cJr0zgJZOXoIPIf8Ms1sjvNqI/tJhcaXt3OG/1HVLsksr6F0Eu5B0dIRmLwF0nmykloE/uFS1PoDgwAunmmAkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af03251-0371-437f-4163-08df0cdf9f9f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:57:50.8353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBBAir0t4q/pS8ZJIfKpIo2iJW2B4WG1yYvjEQtgg/yZp8yRaIDA8KyhTZopVZ/zAMrWAeld+FlCC42SuTypJNzOcYYvUS2Nj5qQ9cxghH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
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

On Mon, Sep 07, 2026 at 01:17:23PM +0200, David Marchand wrote:
> MAC addresses removal was tied with VMDq pools even when not used.
> So if VMDq is not enabled, no address would be ever removed.
> 
> Fixes: 9de506a6c781 ("ethdev: skip VMDq pools unless configured")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> I could not test the change as my setups are KO atm.
> 
> Probably worth squashing in 9de506a6c781 before pulling to main
> 
> Changes since v1:
> - fixed compilation,
> 
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index b6b2d291ee..3c01354c39 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -4509,11 +4509,16 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
>  	struct rte_ether_addr *macaddr;
>  	int ret;
>  	uint32_t i;
> +	bool vmdq;
>  	uint64_t pool_sel;
>  
>  	macaddr = &(data->mac_addrs[index]);
>  
> -	pool_sel = dev->data->mac_pool_sel[index];
> +	vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
> +	if (!vmdq)
> +		pool_sel = 1;
> +	else
> +		pool_sel = dev->data->mac_pool_sel[index];
>  
The explanation makes sense, but do we really need the new temporary
variable, rather than just checking the flag directly in the "if"?

Also, the rest of the code in this function, and the add function about it,
uses "pf->flags & I40E_FLAG_VMDQ" as a check for vmdq support. Is there a
reason we can't use that flag also here, rather than checking the rx
mq_mode flags?

/Bruce
