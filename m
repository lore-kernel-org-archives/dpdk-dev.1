Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4420606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m0YuCdZ0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83FFA42D72;
	Fri,  6 Nov 2026 13:18:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 609AE402D8;
 Fri,  6 Nov 2026 13:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793967528; x=1825503528;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ZSom1j7jTu9XbVwKttZyumzR6VKI6QspF6giGXLpzgo=;
 b=m0YuCdZ07YQ/ZvgRzi+YRonNNQLROL5vT6hovmOUYp0yBHZ5GvTYLe0I
 NYmrjoPkCRHUq6FgrSfef0oyaYDBTcU95nLbpkYx9S9SENmWRpnE+3oF7
 9Gj8wtKfYvdZQJUaHyEL+5f4PVdDX7J2UTejwdg4NLHI7/DJ3ytkBYtN3
 Ssj9BVQPfKJDJPhBq91SzG3GL/behKwrKANIhgXaWGNCgzTsO6lc87iAv
 CLuabam9+J83F3priYvFLvf6mO8rypT+MBQMUiJKABEtOUAclPKI7Akof
 EtWgtMkUycpqRDX2GA41wlggmX1876ET9wBjyIQF1Yc0uqr+YTtQfjqVY g==;
X-CSE-ConnectionGUID: 2e6Dn/81TyulgzYI5QQfHw==
X-CSE-MsgGUID: 1SGWh8koRRmjUMuOtqT4AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2647850"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2647850"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:18:46 -0800
X-CSE-ConnectionGUID: mGSuW2ApRDev5oSkqNc7Cw==
X-CSE-MsgGUID: OIGIeojYQJm0Np7NioICkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9133689"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:18:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:18:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 04:18:45 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:18:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWm9YVJwtkyN9+iNYb3EslUf8NGP2GBsEx9Smq/t6p+SRMRvGGPMtKziD9HECV5iWK+BwpE2BQv4BoYPPfKhfMRzHnEUd0quHsWu2n1j9Jk/KoGm7CW7afMLn4NDjnZmotM4hu0LQrRjcUXVin5mpgCZ1zozYAvzAr9QGRpobipxwq3H8DSacZ24+lindZReTIA50tUGXrXsNyaXfAUaNYmSKKOznjaI0VTvONV71mDG7PtYfb/rjaMS+e9xu1ZPM9MrNTVdhBUebxAL4CXmKXdPkB+hn7ztzoHO+z/Yq+WgWRXtBWhLJd9BOrzk94EddgIISAbSQRwkI5UEyYL+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaKxvVmj6RmJoF+lWbg+Q52lctsprij6loPW3d5+FMw=;
 b=Tb9xOg6Fbclin+lxsSrY7HWjHoHRHu7TcHxpb+PcrpsKcdllPJFSGU8VWiKkPvSUm8Oy9WsYZRWhBvcIRe3niXwBala6r922sSPLCSP4OgmsctfkPxa/OW++2DOV1AyAO7kYQStvypFjwlPt7nB2kwgWIDmSTqI8IJuuXTFd8P13vQlXCV0PPYebEBUk3Qetx5eVSvDnMR0aaGLTzjADVRVQ3VHtc8UxnI6jt6B8QNBCgzckjI8EbmL9neYdAFxUABrkjzj8RJ5l7yzWzE2YmG3v+1yIsLZl0BZX44ODFZVfF+ZtbSJZ7am3VgsL8CwS6TKBbwgnTmRAzrm1V11MJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 12:18:43 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:18:42 +0000
Date: Fri, 6 Nov 2026 12:18:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 8/8] net/ice: fix DCF port leak on probe failure
Message-ID: <au3FnQEeAoLNeW1n@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <06b0de0e409a4679915ddd88abf64f41add54280.1793871697.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <06b0de0e409a4679915ddd88abf64f41add54280.1793871697.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 2414d8b6-e046-46f8-bded-08df3c001896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261102123227099003|261022075727099003|261009223027099003|261022113327099003|261021123027099003|261026140227099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: rHXNuWNSMEZo0ij26G3v3kpa7tNUgnJDhquAhvFJg9pE+7ECcDWIVMLPMBI2XbxNFB8qxR0jiiXxETvkp44PR9ubPW36cXNlYiU7FPlNm/6ZefQJu9zIJ0lqrxXOr0nm9v5j15mP/RV2hxfF7HfVAQaCpxDiRRVq8RkY9gUod791MF7rZT7LdxBR9x60dUy6lJ3ZDOs0kVmMniODA0m3jDMfqgH8HwMzX7LPDlo2Ugcxmvw9AbqDOdmYPNTz+jeqsxE/sYP1HfnREfgjAEFJiwqjb6UDVigdGXsoBkUobEHYmVoLzVAw5S8uT0crnp8j3FCGze5uaBLM8jZ4Pn/78aA7XYNNAhSA9Z401LVoonOPoBRZWn4GkRWc8B5uqVfDxAzW73FtbDWKczN2ZIboCodYJkZ8F3amBJardOy4Do+t2of/0AkWjFhf1rJcUAFS6V286ftkqOz77Gn7MDBRAoWyuU9vgGUHAISEZHO2pv0EO14yoj8ya020D2t6MqSui+wUXQmbQ1MV4sbfPUf3JDkAP2R6N9jblVGxljJbdfBS6xs8bdqD9PxzrUg2dddrdt+Ft9tXRW5u/l8AD/fkoToW6xnItjrKJOKxfUujVNB11+oAUoE5loxoQnYk6kUoGB1Y1L+t2uz4mvMjYL0SCnyca3U6hg8dDSunIZwU/20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261102123227099003)(261022075727099003)(261009223027099003)(261022113327099003)(261021123027099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T3CAM1j/Tn6DCZPs4rdh5FTrk2tWWdWfq6B7dg/pXdU1kUxAQHQOop9sfHhD?=
 =?us-ascii?Q?b/J0h1H5eqmxGhesgkv+o1UlDA56KSkP/EnN0Mua03Y6s/IK+r3B64aOCDNb?=
 =?us-ascii?Q?5txp9SBl3jPnBypAB0xrG3Grf/Z0EvT32qmZX1rtXpoK4YSY43wrnmUSpGmn?=
 =?us-ascii?Q?dg0yU7brdc9isrwkR7FNP0hwy+qUGUflSbAuqMb/JylQm8d+Vtz7adHUQ9LY?=
 =?us-ascii?Q?5s4mJcdmYAkMhmNEg1NdD24HEKlCPz4ODKPSSBXFlPmVNj42GpvdF7yjYdF+?=
 =?us-ascii?Q?UP5vmhVEqXUmBH1KfHPyJlbM+Mz+4Gs1P6JbF/4b9vip6FRZdec7YaIfZ45d?=
 =?us-ascii?Q?3JWR48pTmeVDipQJhLhxetQE8wSmhgZ7HX5PTvWpCSjhws6qYfHqbyEH0mlI?=
 =?us-ascii?Q?zOrwR14LES1aq4VgXNWHXU1Ds3b1WvwugjNP1fDojgTL6fbZVMXchMiFN85Q?=
 =?us-ascii?Q?DqpgUmTJnSaEq8a+fjUmnDP65kOvpjyxuaZR5hxuVKMFIeY7YDPAK4pa+7mn?=
 =?us-ascii?Q?NOtCIlDSzozwaElc+drgZpGauclLltaz4osFFnl2cy34I8Qg5rNprinhI1dw?=
 =?us-ascii?Q?2e52mRC7cCeLtdLPVsLqUzmk8+Gysv6svaJ7W3/kidreKyDAoH8zbSkRRqwY?=
 =?us-ascii?Q?f3qpMaRgLJGycyo6W/upvw6gUTBQLt76nP4oLtMKyOHMDt+XfMAKRR3x0R8B?=
 =?us-ascii?Q?fgtLgULqstI7celEqNnmHIfNy4i4j4SnVS+lt6WRkoZgbfV3d+0BjUVAAQ9o?=
 =?us-ascii?Q?PS5dtSsjqNNShqZlbeUFUdknVy8VJRY03hGojz9R1DxTRcCBHdkD1wEmK4eT?=
 =?us-ascii?Q?v1LnR2/Blk3vieG2M7zayJaax8uJtyEEGYeiMehT4OJSXBTslrBzZ96saK3n?=
 =?us-ascii?Q?w2K0YS631zjQ/4PhKQCpbquEuoIr2LIbut6k3Re/9aMobBj2J7PTSoYxjS/F?=
 =?us-ascii?Q?T1VANFlq8U7BEmz0Dedi0iLXo3FBGLJYpXdsCqHqpgLhBBmHbeTnptiL7hWM?=
 =?us-ascii?Q?YsEI3EdNn7GLQl8NPDCE1N8F6C4UfkKs8xeW43IZqvMONLzsYh9LsjeNrB/N?=
 =?us-ascii?Q?Tb72OfP1xD773iI5yYuLd//mRneCZZhK0R+901C/SLWFyk1X/DS3zxdSbbot?=
 =?us-ascii?Q?s/EywNQDlXhLbcb/SL/GCM0hFDwrhGjeDSLvykxh2JAMIzCZrAEgMRXU7oV+?=
 =?us-ascii?Q?14wVhuMX7Wfo9Yp+thS38QovDXTuy/2goOdg7NFwP5CmvCtosBDdNjNqRMHE?=
 =?us-ascii?Q?BZ0E6On1GV5hh8EAa4fSfacWEsXsYmWmfrKr/+dS6MMbyEAKQwNunz2LqQ09?=
 =?us-ascii?Q?uKQITHtkrRT1uf9WdfaZYhB8GTKKdyZUNupmB+sN/kIW2u52UxkMh6Nxp9Cl?=
 =?us-ascii?Q?E9fL4Nw5YD0eG3joMI8WQqlfBB8M7kRJNlpKCzNsHvruoHCa3stVVWom3pA7?=
 =?us-ascii?Q?zCsfDDd1YSqWs2ZTnrrNj73qJDOpTdTzp8ub2lxM5MPoCTONrGicmq5FNZiR?=
 =?us-ascii?Q?8gX/NVTDi6bjEoyPoDPcUo5zH2runzWQW8FNDmc57JiR2vBaNXOUZiFxaiyg?=
 =?us-ascii?Q?QcD1xyN6psHm4okuGmI9qQ62ZUeQ3g1Wlo9uo0zp+wtowUF6IY4zjFa0B3iA?=
 =?us-ascii?Q?hC4bDbf8IQF40sZQUntRU4Jfvh/6PtZuJUudVGlyevNVUjPWelTBqmWCF56i?=
 =?us-ascii?Q?81gQNZ4e0dxUSESeDCEbaxAmk3xsCvAkqoK3uch0R1CfbqzyuU1u4OQElziw?=
 =?us-ascii?Q?VPLAMlJ7J2viWKuWC4GAz3A+opfaC+8=3D?=
X-Exchange-RoutingPolicyChecked: axOteHrA+pnFUATl9dpAioswPXQzav9PGjEWvK96R3H2LtK+k8W0LEsrFJ25ZrHsRGxYKs01YitGPTuDM+EjRXo+o60kb0ybnwewcs/pfgrd94FXOOIokyILtUoXM+8v5RBaOY1k/bg3uCY1mxmniV8UpRWrmaG9Jr1CPlB7yblI/OxO/24cLTk3APsoVc9SyWxz/vRbdqxQD1/tL4d26t8r5+bqJ8FEjDGIXPIcKaKq676Z7wcUgMN5I1o7z8B2g6cPOU6mq9bI5u2GpdDe+epRzMyb5aXbL4nHNoD7abga/8X4MKWC6dfjkm5dvpUC8B3p6lYkWyFoLwRpyPMPqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2414d8b6-e046-46f8-bded-08df3c001896
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 12:18:42.1225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUmggOvY+RImgnFuWyF4lEuvTgkz5J/31m+CZR8nZuEz7KdfARHpayVfAdpP1AqShNVxIYpj9mP9dQKp+2LF3ic2HrIi9bx/Y0nQVMQ4qzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
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

On Thu, Nov 05, 2026 at 09:47:25AM +0000, Anurag Mandal wrote:
> When representors are requested, eth_ice_dcf_pci_probe() creates
> the DCF port before handling them.
> If a later step fails, such as an unsupported representor type,
> an invalid VF ID or a failed representor creation, the probe
> returns an error but leaves the DCF port and any representors
> already created in place.
> As the probe failed, the PCI bus also unmaps the device, so
> these ports are leaked and cannot be closed safely.
> 
> Check the representor type before creating the DCF port, and
> on later failures destroy the representors created so far and
> remove the DCF port.
> 
> Fixes: 5674465a32c8 ("net/ice: add DCF VLAN handling")
> Fixes: d654167641bf ("ethdev: introduce representor type")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf_ethdev.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
