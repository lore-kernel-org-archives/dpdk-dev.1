Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922E8CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:57:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B713740616;
	Thu, 25 Jun 2026 17:57:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id EC8B040430;
 Thu, 25 Jun 2026 17:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782403057; x=1813939057;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=abJOH/s4s7hpLZF0eJPeqntDG52c6IFVh1dpekW5RFM=;
 b=CcJJM8S9x6iBMF4+NJTbV+iK7mjes6qaaQYAndl2fgV9Zk1wbTCcZ6SM
 jyYVNDY5lgUW+6ZCxdamh7vqqM9W5PEkVr00MMZ2sXlT3EjQtuav98lFs
 Zx9krru4xtXBuEAIHmmm4JMuO+npP0KN/hVlZzsKgJe3XPP86w910EffP
 qbt/7BenERwKevY5uiWed+dCbvdH+xRqMYf/kjegRVziM6Rs4AW8kZlwP
 i7cm57aYFBJYXab6zR4SkejxGWXln9wefVkJtBM9PTk2hpV2bqPpkCd82
 CEdn5z62GGGDD9VhChGwtnr6ie+HCpM6X/FfxBHGzkmsPbeURdp97NiR+ w==;
X-CSE-ConnectionGUID: pKgs6CWTTHyT/DdLT2gO2A==
X-CSE-MsgGUID: LLqKUmyuSJGfJ1iK82b0hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83067313"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83067313"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:57:36 -0700
X-CSE-ConnectionGUID: sYumxa31T2GBTErovmMDOQ==
X-CSE-MsgGUID: Ig4YBGVfS/yrnnrYN/lWIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="249755980"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:57:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:57:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 08:57:34 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKRU+TzAjJGI9f5snXQ/eH8b8FyZbNUPFl1TadBUcx7a2/dPBBZqdOyp3NjcGcVh2Z8j0cgMfZcGWBo2cCSUHM7pUiA4iFB9psUseZ8fk/MbkiYZ+yObEOMI2LquI9DhtnTcwVcKk7Xy1c2yaCpaNGW4HSut2qEZbqhgiPZfIgrtT29O1EsspCeMQxo1pncM+pimCxbwJ2cR9Fnt6P6Ln4oqvMfjmV+OOkZ0GjCuu2f+G5HC1cCXex4jwVELfykLvj9g4zJu+dzolU/1UDWe+L7YN4bzQrDxRuIZUY3dkKHJylIr9tbBpZUm0gUUVXsvFAQ3cOxWuzUcnED8vD40qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSb059U4D12oR5wWU5zS9qDkeV8DtkEtG6pPZCx6m28=;
 b=da28IQhYNrw3gT0sWe7Ql4aQyGra7VQ6PkBTLltKlZzKC9ZWSMVIww7QIWj3ihsF/r0bLLApsoIdLvxidYNU+JjDqUhsXRKmtXKUpi1Lo/K5oAGYTj3faaaScUVzlsJbvYesu046WEACGedU0C+au0Ln/VEtpDFhTuZ6wbm8VCl5OnEHVTn1h6gctgqW2BXKulxfhOf2nIz969fk5NPxiBgb0Mh8/TolJ5swPaF9Hh8hpgAlUY/Ewr/uEUuy+afNe4kmUXl3aW79pybnnWk5eonQ7QTp9cy4bNh7Y+J+yN0VehCXlzHmTFPrH3S38agHDyXYK+iBO2K0fGRYdLallQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by BY1PR11MB8030.namprd11.prod.outlook.com
 (2603:10b6:a03:522::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:57:26 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::2271:3ab6:e9cf:4ba2]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::2271:3ab6:e9cf:4ba2%8]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 15:57:26 +0000
Date: Thu, 25 Jun 2026 16:57:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/3] net/ice: fix Rx packets statistics underflow
Message-ID: <aj1P4VUYtYs4wLCh@bricha3-mobl1.ger.corp.intel.com>
References: <20260625093619.726471-1-ciara.loftus@intel.com>
 <20260625093619.726471-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260625093619.726471-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0072.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::25) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|BY1PR11MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f9b031-1951-41d7-d642-08ded2d273f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xXYuL3Ua0TzX8k4eeaUeeT+wTHM3QayAB5QQZLp3nCnclSG4ZFUMB+pV9342zt+b9EC2OZa6Lld3Ji/w0g2BOGn7ROhG0u0B1f1lZ6Mqm77cNLX62RlNXIFwBhqQx5rH3hfJwPygSAoYBClUrXuxOpjg06TLGxwc68jD/YFu0luZtpfsXgpN1W4rcYzVTLpx3Purta6UI6lOGMcZCArWxqnE0g61y3nLyaeAe3rEDa6VBaf1yv2CHqw7LSUpegQef97u2eyWE1Mc/7sMs5TF3R512fzVfMS9OdWsm2DAnYXpYhpV4zCoSBXvBS4wz755IrEanudw7NW+HoncbLz9WqG3cEnDzMsL95Ii6KH9hrxeYHu+Dyho3l/1YcDhDx5VcPclMSBlO1rWTdsUH2/3aYtXd2JSXIyJb0A2YT1ORNRFja4pWi3LiEYyNnqQnojzlgN6jeSLuoUaZYY0zm+jkosZ5yrG/YqjQTx+n2xNzLu/ePmJ2KG5clq051gbBsweV3Zlh9ZfkSvUCG+ogWeAOHw5c2PQJy2dwLhPTZNyvntG/2GIuFiz3gWbiyE82Q+QeUPaEUYStozwRKvek9l8gl316g0hcyRxu2PZqb6beaLbRCWOCWJdBwtnUY8biey3uKNsTS7m87sw3RyVzF2UjO7QXP/UQdlDAq6Rg1jEVRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22V2yr2Mc6QL3DNNl+MTBQ0l/hll33XgH/FOlv+IxohooqwyRJK/CflZwuDG?=
 =?us-ascii?Q?FhIdVT+vLY9sHBYbpdW4Y5wTVx0XJ0fdyKCRsmt77IzE/ujfqwjwyi9gp4hl?=
 =?us-ascii?Q?YPTkesyV0y/plNKtMVo5gX5yzinapSwqYrse1UoL5sEJL4mQT8VKPYKY8Q8C?=
 =?us-ascii?Q?u+D6b5XXRXmfh3pLp8PIc3vi5isDeo2qpXouvhbaAgoZWPXnxBF2OyvI7PNz?=
 =?us-ascii?Q?tsiRKIhr5T/9egG4FdmFe2ib+RBPL+sh2BBdpS45gvepfAXcLIcFnt6Tty4K?=
 =?us-ascii?Q?MLM83QSJiHf6gSxIHPvooXr2q3p4e1RVeg4wdB0JiY6YLMSa4blkfIPBEtXf?=
 =?us-ascii?Q?/XyhmwkvrbfVnGDBz286MRKQvf8FpCNFVwEEAGv9DlV8E10b1cJdJFw+LTlo?=
 =?us-ascii?Q?vmQnrMsDQTrbcIlYwfUQWFJSwRVcnTYRblmgmLMpYrX+cP9LSRrC8DCPV1Qz?=
 =?us-ascii?Q?Bf9ZlWt3J5+IUlqbw/Jfm20wSfBFDQPS0fw7ArI00t6svUcPv2IuaWAxih2l?=
 =?us-ascii?Q?R0TDW6VHzYdG4jLMywJZxSgdFwSLf9K0mSUGr+ISDIeyzAhNoQwffRt6Pjk5?=
 =?us-ascii?Q?Xo3UElTiwl4PvPNvnrgN7nMM11nPLQ9iwWEYd+39Nt2GvqMKn4ZQq3CFlytm?=
 =?us-ascii?Q?jdpzP2MUVpOv5Ll0faFXzqznPmh98nHa7PRfW8pgielGFEaKRjMA70EUFZwJ?=
 =?us-ascii?Q?DuXeYSbVS6QttjX7t4g69R1n6HVCKw8DGqCXWwEkrkv6jyP4lTXgbihlj7vl?=
 =?us-ascii?Q?TWku9E3ePL/m86Vrer6liX7eWxe6PS0Hyi7QONRB+lVQ5ztmGL+e5+ET9OgC?=
 =?us-ascii?Q?JI/wwocNt4MR7Pyy4api4rDIr7k91wuZ3VesA5akprvr70gpebxFDARJ5vFa?=
 =?us-ascii?Q?lYxeHqEjWTljenrgVLH/rkEuhcSUWBU8/W6JnjzlpiGELRB02UnDz+8ghcuX?=
 =?us-ascii?Q?Z+x9f2RF3U8RJka4NAN2w87Hjt4pmZ3jJ5hfXadSiNDROa3klmCGsKT6Uitk?=
 =?us-ascii?Q?YA7CfiimZqiX4FIJUvgwVqu6uatwBx0gtkWo0agGrJIlzv6YhJNeh0e3AYBd?=
 =?us-ascii?Q?TmAImAF8cBWWi5Qmm360ZCWIKIVHceiDK8tC5FX5FMQbPXL6d6PY2//OsJNi?=
 =?us-ascii?Q?F8nPmUu3CN82yvbt7xH9q5zKCd+2i9eQgRfHOaEhXEWOFcubtKhMG/RMY3ao?=
 =?us-ascii?Q?NYsCbzYqbzbMZN9y7fT1DVW5a9CwqBmZZ8uxs6aRPmy8LlwnSOfHVFXr5+wf?=
 =?us-ascii?Q?vah1vBSmwPdlehOdLJw/vmYhkdPIgJaCdYdC3Z+BN9yGhOxv5WZ/B3iYVPdV?=
 =?us-ascii?Q?2gJyD8q3zP1dJ4oZDcTS811Ic1aPvB6TI+8HNA0DY5zeuRnQmsa9B4j67z6v?=
 =?us-ascii?Q?RkDzE2TPdcplu28oQMcPM5PPThT+hE0L/R/tzKLAU5toP5d5zEGNvzErpnl3?=
 =?us-ascii?Q?2rKyx5DROPbzWQfPIE3u4GY+pIjwsYTVO/jzGoJGvw/x7g65ncOXm8go5Mdd?=
 =?us-ascii?Q?rvqZCPsR7GJwdMOP5o5/DO4idA/iw+nPK+Z3BIwboMTYH/EiImgxgSirkP6k?=
 =?us-ascii?Q?4+7Z4/mVj506j+T7qoPIF4DzChpBNNqMOEo59nq1lrqr18FEAlC127E5dg7W?=
 =?us-ascii?Q?85ikVdgxmQg5PlmtBwEl0Hv3F0Z0ey2qknvPG6ntHfvEaGv8KmyrhRguHNmD?=
 =?us-ascii?Q?rdZjlcfNhbV+61va1boO23P5IkYuc3Vs9lCaM52DMNodXbwWRQ4Auei4O17r?=
 =?us-ascii?Q?Bmh9pihpJdohLzUA5Ya1RK32ctP4zM4=3D?=
X-Exchange-RoutingPolicyChecked: ncz4/61Cmz61VN0bDa1no3uaN4gIpTeTEr2RqgGN5aYxF9RzFFqT0dKlkYMMz33BINAPr54e9XIhsvz2RUXBI3IkDqPUlWxcKih+tDFRVc4NCO/0gM7AV8ek3b8tbnigijkve8cQE3h/RLVPMdDr76C3Lxpnk05YhpKZK/lyN8vcjcj4137rTUzISxtW2yhtbmZ4t8kEHIROXT+d0mqVr42aF8JKi4NIzbVk6aRzg5dqDoopsh5Amd4PvE/qD3/5XpmBEHhXFAHbad9C6QBT5ZK4b3gXlWBKS3LLi7I1bSdrKrQ8QRN7rXL0/a5qQl9R3r0hbrCFP7wMrcuj0mbeRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f9b031-1951-41d7-d642-08ded2d273f8
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:57:26.5744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUZjeQ43yxgDRztyQbuCzFXrktNdhfWxBYeUO6RxObbtltNgufeUD7r+bk0Vkz/vj3Pe1kpIrC5ZBE7eB1EqP1uWd1YMaI9K9h12nrxpXAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
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

On Thu, Jun 25, 2026 at 09:36:17AM +0000, Ciara Loftus wrote:
> The number of Rx packets is computed as the sum of the unicast,
> multicast and broadcast packet counters, minus the discarded packet
> count:
> 
>     ipackets = rx_unicast + rx_multicast + rx_broadcast - rx_discards
> 
> The unicast, multicast and broadcast counters already include the
> packets that were subsequently dropped, so subtracting rx_discards
> yields only the packets delivered to the application. However, each of
> these counters is read from a separate hardware register, and the reads
> happen at slightly different instants. Under load, rx_discards (read
> last) can momentarily exceed the sum of the unicast, multicast and
> broadcast counters (read earlier). As ipackets is unsigned, the
> subtraction then wraps to a huge bogus value, reported to the
> application as an enormous Rx packet count and packet rate.
> 
> Read the rx_discards register before the unicast, multicast and
> broadcast registers. As all of these counters only ever increase, and
> the unicast, multicast and broadcast counters always include the
> discarded packets, sampling rx_discards first guarantees it can never
> exceed the later sum of the other three, so the subtraction can never
> underflow.
> 
> Fixes: a37bde56314d ("net/ice: support statistics")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
