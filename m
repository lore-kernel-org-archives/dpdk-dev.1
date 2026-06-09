Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A07CCD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 11:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 889F4402BE;
	Tue,  9 Jun 2026 13:55:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 583644025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 13:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781006139; x=1812542139;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=46AbJZfTLb0FKq1I4TtXm9SCo7HVm0LcKLnfrpUvK88=;
 b=PXgkziWjdHmbqcs1XlsZ78d+JkPe/WWiUxbyRYLlUwbZiKWS/UNtQGTp
 fCGwUr7ujpNBZ/YNQVOE8hi3HG5zp6Oq5F0WBf/cNYus8F4FJpTZRNue/
 x+S7cEaR1DfK+kU15gIH1jfwGQf13iQ+V7vBDr9aT13V0HB62TjMRM+C4
 Kj8IVC/XDJUpOO4K65gIUDglAeaipVh+SR6NJBPNmFQdSb07hLfbZYRtV
 iXv/geAnAMYNOVFMJdwf/GG44dRex2jsn7tVF69r/ukMhOZAFwq054ttX
 +q1LkhGdSCA8VHTGVhGx2SF9FGqcKEo4B9Wdo8H0WMb3Z6h/5LDVJJIS2 g==;
X-CSE-ConnectionGUID: uaDx1kw7RTmd71eocvX+SA==
X-CSE-MsgGUID: alzsJ3CISsa7H9oN66h61A==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99339318"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="99339318"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 04:55:37 -0700
X-CSE-ConnectionGUID: IzxAZchgRkGsFx4GlUcBKA==
X-CSE-MsgGUID: X1eOoAhISnCxWSc16ChRhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="244986063"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 04:55:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 04:55:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 04:55:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.42)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 04:55:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xyp06w+oVx9//YgCp4WxOhYHc9mfL+E5Csz/sXl4yd8p2yfVVqlCR/cNirxf6rY4mW3FSZ+3EIHsur0F+bk4DHcwuY8bTxOvMKkIf86c3t+zcG8Wdz7npQomzRPGCWzIJv1CVvgONUVcmfD6WYqrezJVjgnM/QTmyibGB8A4uhhUB7vFGVkDYqYIpzT5rs0dsAsf4vtYcrWkcHI8c2mTFbWSJ/cDZGbAcQ+sRZmaUKTLGr6oKX8p360CRI8uHYJ/reKAdBYd2+7CUwP7bnZVFbE794KnhwiVYR37HD2DHJctPU2GxhaI6CyPMjxFdoJe9aRTF7906+qaoDxgW+A4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCg/P591N0Z3igghb2rNMhY+xbW9H46pEfdDmi68kT0=;
 b=LiM9Y5WsWQ0MPoHDltaQT7EomdwcIqGLfxIcKQH/QDzvigjyuUe3NRw7le00U0X+B4YVaSeahO0uLdNyFIs+4+pcTfiLozZg/X2qQ1fkCdzOW4EVCVCMpS9/3B9BvNoSSX6j+g1aVAkVu2ssk/g4HY1ToQ4RL9L8G6dZ7FvQbQvhNNDn6dKb2PojYbxBW/A4UxXdAfwqc4EcjuPqwhW6bAc9sEgT94nLQLD7WXuTZWad4xk5s1li5CdHSY5hnopGg/eBQZGmKvL4nUxch1STJYJE00yHl7QUPtf+Ao6H8cg0C/J7Ec0AS0ZUqxg2FYoFCSofA1gdny+4KfY76FTSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 11:55:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 11:55:34 +0000
Date: Tue, 9 Jun 2026 12:55:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/ice: revert fix link up when starting device
Message-ID: <aif_MR9pNjdT9S21@bricha3-mobl1.ger.corp.intel.com>
References: <20260603143407.1108527-1-ciara.loftus@intel.com>
 <20260603143407.1108527-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603143407.1108527-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa12eb1-79b3-44de-4c89-08dec61e0349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 8B2h8I48bFhQxPM9R1uHLqGmc36SZ9yDkCQtfc7Amhh+BRC4XMTwqbRGvOgteHQrZddPX2jlwLJOJykK3V9d2oSPDR/eP9N9O7nOwth1g8RSyAQOigT5GjS+AwVJiw6eoRcc6gZJvMYrDGBxBfpXfYTXSJv4DiaAqInuwYEw0vr4Vh26jvxgpBN/2VxYDSvRreegUDPSbBdDiF/cWzAAwnnvxWhxo9HibNq9s5tNEznHAOycpwcWW2tCfGtpvYZ8NnmRat9oNNoA1/YeTSUo+JoHCwcyeuacL5JjAqXOoDqvDMQkw5QYfwUDZQhM2d8dsArd2Du2hZeywLpDWQ+Kpet8F654B1oOAY88zQYio4xoeSIboZza/iDSok5WVjLfL9cwfSpmUoiGTFMevkyn7qvURguWmkhmv3hbwZtjtEWRTfVU1XERXoa0IqIxnrg8DUUrh2iWVBB04b/62fPZGRofkldG8EWWnIq2AoOEdHWshB41IWcchRROcz+gJmoeJQOcjEHZ0KqWk+5xtNQRXsByX3DNlBl0zPP1FFZlJs9RVEH0MZq75Zttu3aHRX56TURKg17h+/ii/8JzDWgfzhJqigQ5kUleH2gk+7Y2o/6syARTT+sL3e2JA2pJW3F4WBckzG9CnAh7Sqnf2l7FNnAbs18ZuquTZ1OQfMJbZQ4808fp1cOrmnA0DYAVj/sf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGKdU4oz0bsqa71mf6wGKNz0DckQ94B80tW2VJrQ5F7xW49SF5frfA8avySH?=
 =?us-ascii?Q?3OVz78wXCpPknO5rTsdEgRzwiSemW7hMihRTQyZsAlVqy8Oly7CzIWnCiAyS?=
 =?us-ascii?Q?C0XYk19VeMAHm4hoGYYakHOIDHxp+7UN9iokekYWeJQs3YJyyd3aB19s/lIP?=
 =?us-ascii?Q?i+xaeYTcByAzk5p/JbqzNWCpKyspNyZlxpgYVW4GlW774twIL7smNeDW1Zt1?=
 =?us-ascii?Q?0WYG768bxQ0+xJKd/6L4r8vglMQqsSX2niI+L76kGMemo6zPxratMJszB43G?=
 =?us-ascii?Q?J5gUc+ods71UqettbmqeMWacBQcdxtv01ZixNZUclKag7PzZYu5i9eGfd5Nm?=
 =?us-ascii?Q?hH/RlbDeaAZwCRroIpbo7DkvZl6JexOUkVEklsrQ/WOgDBJjn/ag394jcco+?=
 =?us-ascii?Q?KcUE+YM40aViIEwXgtz8mgdefdszlRGKhc3Ctzn4xbB4zkIThLyGLbiUqz53?=
 =?us-ascii?Q?SJAGakzzZ2gQxxE++kvJJyjQjCEzQuOvSb9B1QJhKQ9RgTFJx4LkDb0UXHVv?=
 =?us-ascii?Q?k6BxoWs5FE/q5lbJF6xNozKYLh49uDTQzRUNKRKI/zjOnEqZ/2TKT31SZIVv?=
 =?us-ascii?Q?MUQ+MyNfbCWX54WGbMwL1AtkZDbG1ShFd+py3DZC6jAkJ2KP5gail9mpZU/t?=
 =?us-ascii?Q?Kg03dQUzrMbKzEfsA/xtoD8/vHq0s3qKRVQLYP2j3CMJ77f4AvX5nVpTaQ1B?=
 =?us-ascii?Q?5Eeku7rJ7ed3aO+Jn/d8RSYetuGsE6gQBEX08GRm0iqTKERwv33bIBUpnUqO?=
 =?us-ascii?Q?rI7QMkC7Mwa7FHVOjZcmv4A7VIhGpySGZ2+Sc9H7pSkuJ0cSUiYyvrJGE+wF?=
 =?us-ascii?Q?W9hzm2sPSCRtY3yTFK/xT6A/ia97JWVUYILYNDVoYFLWQDx5sj7raqJjJ07Z?=
 =?us-ascii?Q?uTRyY3/J3sOq8SfLzuYFkjByd5w9/FKsLoChjqtpNEzm8iJMLV7UTDtF4F+/?=
 =?us-ascii?Q?8cjdUxyKBEOn4nt9/OHaQsMvnWUu9wRaAXkeMJVZPa6xih/PQ5NpYUIp8/V8?=
 =?us-ascii?Q?PIHWS0pqSZrwoC9ktMCOJDrYdczisdhdMMIs0hPmORmdwV6SeKUBrZxyqKW+?=
 =?us-ascii?Q?wrUJYMhCST1779wY9qgcWOdssoWi2ZLj9mtRBLdbs5HXMIrJYUoB+XOwNfkY?=
 =?us-ascii?Q?ctJM8c9ouDubpUgMujjKG2Uro5MZ8tz1FOcpKE/z5ZIUkCy02u7w6DwOnepg?=
 =?us-ascii?Q?w1vBkgENQm83ncXpUM3qH0f8oM2sg5m/lnrT3cx5yFAsbwstaItrtsqtBRdf?=
 =?us-ascii?Q?XRJUpyouYyjdYWUPRiD05/Nk+Tmp3XqyP8ahVuXQTs/HjYrfZiGQqqjEnuQM?=
 =?us-ascii?Q?Lu9wxEdwBDxQSu4Vmc7eUSo2eIHG09IlA/Dx2uFXbaMZKfhXJXfyQ9hpzqty?=
 =?us-ascii?Q?PtezS9QIj9oorsvjKyn/Ba2kYXvgF6dm5JvryH/pXKB7jCyL4T4HLqpVo6wy?=
 =?us-ascii?Q?dYx6/v6FO4Vrr00hOU8WuXLh1y6QuH8DpANZRGpTvQSQxPOUR8aCqptZyinQ?=
 =?us-ascii?Q?XnM8o7lKKa5oORax5PNcJnpiIvcDq/QETBMH60S/zqi392wqQJy1ccaML2lP?=
 =?us-ascii?Q?yKSuiSFrQnqvF+znvqGxfXQeOBgn1n2kSyXGqL68uZjQWlqG6q/sKPawLX7l?=
 =?us-ascii?Q?HahG1P7DOp8tTsU36/VZt4RdejgKFwqu4yp1o6BHqwyCNZK9reqJzfaYiok6?=
 =?us-ascii?Q?TIfo62AG3WSVGM10g4qk2L4lJF8p6mdq+3v1r8oR0yeUJIEc8JA3z7dHnws+?=
 =?us-ascii?Q?Py+FuIQ6YsclY7BxcPbbivL3AnjKK+8=3D?=
X-Exchange-RoutingPolicyChecked: eqD2mG1VQBOpKEs59K4NmNYIOlOomnP7sTCb+ejQ593vo/bHL1eNxZHwTJQVp5TwsL3gxNpUUnMSgJ95y/OS8myCv0w8/XXqM2t7R6HNpQyWbKn0E4u2glmM3DHj9l7CujFrw3yKH9sAf7XgOj/aSdH38Sn85NMvepPF/JQ3Gb2uDU+mk70LToTqr44mlyXbZMKqoA/ai+VYuK98XlPR5tiiF/KnXuacTPMS0UaGl/IAOwzI6X+mWs1KZ9b0zWg+H5eo7sCbHV4tkb0dYCIbEUpSOQbs+TyVxfs9zMu5dMnNKhnwmbgWHFc4RiBbH1D3aCelAYt3mJG0L9yMqegI0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa12eb1-79b3-44de-4c89-08dec61e0349
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:55:34.1337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkBGPZY+l2rdjySeHo3FXwg4Ni2CLAhrM7fOJcl0EKV/Tbw3Uzr10JI3jPtq7xmRf9S0CfNOXE3IsUG7ox7msq+j6yyhc0+kzrB34tH7Drc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
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

On Wed, Jun 03, 2026 at 02:34:06PM +0000, Ciara Loftus wrote:
> This reverts commit 6c76b76dc64183eb2f24a52b90d4ff9feb4872f4.
> 
> The reverted commit worked around a potential timing issue where the
> link could be reported down immediately after the link was enabled
> during device start. The commit introduced a blocking wait which gave
> the driver a better chance to read the correct link state before
> returning from device start. However, since the auto link update flag is
> set when setting the link up in device start, an adminq notification
> should arrive once the link is up, which will be handled and correctly
> set the link status. This means we can remove the delay from device
> start as it does not need to guarantee link up before returning.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Should this revert be marked for backport, or is it safer to keep the LTS's
as they are?
