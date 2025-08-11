Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652EC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:48:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 219A140A6E;
	Mon, 11 Aug 2025 12:48:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 2A275400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754909296; x=1786445296;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zJ2cgU6kNXfKW//5jzVOx0ERKDAbdoxngUIg4PeF8aw=;
 b=UYtpNUZ162Zop+6COMW9gYGIamqqfexdWUCUyNWoznQ1WZpNE/0/uNoU
 aQZAYG/JalZad3enmPtF+Gy1Z/cOQbEihzwuTYUW9OyD20/VkFr3X/h0C
 gjtTLxjDLflZFfm04foHINEllQUJbB6gIMG9M1Y77nW7S1ezWReLOE+vL
 qTV3PxGtf0hSqIB8zcRcMGoJZPyimalzxdAzyIbqp8Tm4PYtgZI7YfyQw
 sDuNXIYQ5HCoXVHJ3QvsS87FzsreN+jqtktRocUKR+8xTdtQvzKZ4nqkZ
 S2Ppld6C2Q8Tk0toK+HepRjEsaLQHRxZwoxJ/d4ytzxPI6tyH4gyCghEl g==;
X-CSE-ConnectionGUID: 20Gt005TR3CbtwqQghMIRQ==
X-CSE-MsgGUID: S6R7lmLiRM6D4kSusRVOSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="82598394"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="82598394"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 03:48:15 -0700
X-CSE-ConnectionGUID: dlTqmGuhT4a8TgM9dkcTVQ==
X-CSE-MsgGUID: IEtWUYc+QBe0psau+8hlzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="165120988"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 03:48:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 03:48:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 03:48:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.75)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 03:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKIDdKAeTMHjzqvq6XGZsZfu5Xz1FPJapMr1B1q9lnhQ9teyrnAcvhtlnrd1IOozbNbKDkVttO9Ft4Wcfh9fdnDsr2UXFIu/K27GeF5Z1AX4RpnkVqDriPovJi/CnLhGaGbWL+5p6tgLa6mH603pyPP2O/MZdt6XDgby5im3ckoE6j/qTJ46LR4QOw4fOO5Q+HtxVFqe0ZQA2UrtWKhI1RmzXs0cPBYLNfTqEn54BRARsS4WH1FADIclqbjlqpfsnjmP2HJqdkHuBY0SQ6qMbPDeHxvDmX0Skt3pov6Jv0uG3+q6nsUkwUykz+BCOc6e0jLwIWDWk96yw6QnH3XglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHZ8lcbyHP+x4PmNfwBx1Ev0J/bDXJ9RfFDRC79nl9o=;
 b=C2z5ZTPuovjXRTcc9efOQWj2kvX2JokIeVnufPS9N/y68G6ZiLNz8LWaM+CrVUpk3ujtKRkRjPEwNaIMgRrGVZ4/HB2kwlNB3grDgJOGV3diVK/h43xbnroTTYWhouqzp6rKnCHkhCeaxTMcVuDbL/VnXqoF2m/0sT4s67TAJFDRXUspMQL5vgSREesmoktTX1CFfAZysiu+IluofL7DP1VM+Jv+FP91ZRyDuCluLSS+wMeEeZoCDpx8XIVNU5QzyLW1aNtcggSkuCnmoeCRzoKdRuB2WSpydg0iVNm45JXtMpxOYX9CO4ZVODOcotvGmEC8+aice4vVpOMMCfBMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:48:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:48:07 +0000
Date: Mon, 11 Aug 2025 11:48:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 07/15] net/iavf: use the new common vector capability
 function
Message-ID: <aJnKYiMMT8ihL303@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-8-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807123949.4063416-8-ciara.loftus@intel.com>
X-ClientProxiedBy: DB7PR05CA0039.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b9f167-8039-4a4a-8e92-08ddd8c48e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5+W2rDs83+cl/OmfJhIPiBlzyMNxj6Wrn8vdouXVdmWSPXgBqhir+0hd50mb?=
 =?us-ascii?Q?SIkN2N6c4fUuBUGEu97FITfJUQokiVqcVAxM3LMOoMPQygdVeWGxFfOo7FTQ?=
 =?us-ascii?Q?/sFH01CydzcZb6ATXWw+oORcILDDx5yRwRZfcJWMtmpJarqV5DjvOZAJi3F7?=
 =?us-ascii?Q?HMNmpvhFM6n4B8vioFnYBY3ORzAoJ+Q7rNQyF+1OotVQFP1rgiGBDoVEEJk5?=
 =?us-ascii?Q?9zY1w55NNdUSYR1BLzzfahHMpGfViEBCX5HbFGzPebz4ulLQmYcGIlLSjR4o?=
 =?us-ascii?Q?k1TbZuYd/desKaatM2DezXhEndKNLS0xR8nGvcsUUCgcKxutwraz3gjo7Sfq?=
 =?us-ascii?Q?Wym70Lz02hlPlw7x9JSKlNi0KVLvvZH4JMpw27oC9BLQEow42oM9sKc24n88?=
 =?us-ascii?Q?OtDaFOM0fO3X3xqH4aa929jUZxVnsP8YF+9AnTi/HWEN8YEhdSKrbOKBbp7i?=
 =?us-ascii?Q?o2BIDHPTtnup0ZqvhBArdAWhDkb5cCnIVgYlI1SUHzGS/HltXCmVM//LYqxs?=
 =?us-ascii?Q?C8InSHN7Mhpi7SRXmQhCqPNX6/oEWUxzjv2Gr1bxkqgQkO21b2xySk+qydSE?=
 =?us-ascii?Q?PRZ2RQ1CWGs6AtsBHYQDmjKMCuUHKT1GDQDNhRMj+Nal4dCU737AulJ874NA?=
 =?us-ascii?Q?x3gz2YK5fD7eqqq6G8oHEviEr685YlucRFfP3sNNEME6/pBsN9JKnMhyBJfb?=
 =?us-ascii?Q?94B9dVEhPdf/PfsUIE7H69pkv9fEKfAsYY75RGab/kp6Q9+ed6iFkitRG3+L?=
 =?us-ascii?Q?oId1EP8XUZWM5RFTtBphMrwUk7H4mxhLwm/zwqR9NhE8U4nEoMdIiJuch8Ru?=
 =?us-ascii?Q?NnxVFiS2B2AohHJs6CVlgw3PUjW3kAddiKMNgPy6JSvf7Y1/p/y84mbJ7hlg?=
 =?us-ascii?Q?xKhAEyS6CeMrbujDR7Dwch8SC8RpFG2rieJrXLDWaXOTI5IxPy4OaPrLguKD?=
 =?us-ascii?Q?QtZACMWfrKjqdgW/DFqp2Hdmqu5x6C8W3Hg1S7+lKEwJyYoMyVf9Jg2YNJqS?=
 =?us-ascii?Q?TPSuP+glgJNd8F1Nnod0CvvtH74LXX7NJ9I7Z7vhu4f6l4W8YBzd7wtXBWkw?=
 =?us-ascii?Q?OTXvDKd6mhtposUV0PM0WYW/HVB0cWSFXm5FNuD+GxabSov2Xs587PApxmkZ?=
 =?us-ascii?Q?Zzg3hf929bWEBYEiH3mOpIbTccHX1RF0xr8Vc6bTp9qH6ayyDZlXrEOmxW/I?=
 =?us-ascii?Q?3nz0r6VENjsOgKOgVfYqlV9p8Pv/q/906cbkRz0aML13cUaYu6LuilfWpcWV?=
 =?us-ascii?Q?rUSPMbSitoeBGJVrSB9lvGfgnHIhBLSkef/5O7h05pvN/uoxVmFgLkKEENag?=
 =?us-ascii?Q?4tHsBB0ZKCHYjqFsBVK0ZzBkTwbba39/QJ9Z/QMgdv/UYTEWjRMcFWa2uWyT?=
 =?us-ascii?Q?Z0yDDXesQyrrtvFlqNuFzqnUsERxcSFj8PttpOGLxY8boPM3hLxxGX84+IaJ?=
 =?us-ascii?Q?VeWHzHUr7yw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7JcKkbaGoiB3rlx8R8VQvjF1kqGMDAxyi8ngGVnG7WA3/K7R+2j4Kq+hvUue?=
 =?us-ascii?Q?GwTh1yUCTZjxnHhxNi7cZYtooDscHMsqOj4rNPcH/BSIMcBJXKoL6FjMLKqa?=
 =?us-ascii?Q?X+YhbTWJ31yN86y/ZFjQJfDKhitPgItYWYS4nJKc5GApCf52iuVya+Y3eMh0?=
 =?us-ascii?Q?E20mgEz9i1G/MLag1OFLtqEBhTwwPJ4AljQE+QToZDQXZI/ZEM7bb1kCYG2a?=
 =?us-ascii?Q?+wtEKLAgE+6UlmTIQOABHE2ayeG1WMThUMji7KKWCN7DFFBo3OfVRRVVfDUJ?=
 =?us-ascii?Q?kipQLaLAPuptRae6UPFNlIgvn/YlqviF2u4v7a3k1dXcGTnvzGFl/5NGRTON?=
 =?us-ascii?Q?LGZ8o5ObpHPmS2rXm+qUQ15X6j/XCEOHrjvpvAi0rI9KXnx3oTUqEEA4sUgN?=
 =?us-ascii?Q?Cs/Ef1M8NCNcJuiICcaEjVQtv20pgTzOLoyprmv0hjUStTz9Lehv/OjYo8Y6?=
 =?us-ascii?Q?q7nw/nwNqTJS9016K3upugsDnVyLEFDn3B7555+Dh5TUUQNIl1rhlTwIf2Rn?=
 =?us-ascii?Q?9GMbM/GwdIkF8yC+/eEAakBj8dnnKD+rFbl91WIe9uupeO+uR15Nq9ZB0yUN?=
 =?us-ascii?Q?GMFpira/E4oUQbw8HKEwOYoJuyQ7uS4jDJ7VkdMKkK9uY5LUgPZm9YEIttqW?=
 =?us-ascii?Q?CgO+Ac/GNFKYogYJWtVct0vCtC6fxnX5AGT6CTrmb1Jgi8n2hvii96Yjz+ZJ?=
 =?us-ascii?Q?tdwDues5HHIaeD3pPZp+9Qo8XL7rUE6VLvxS1WX/otbv1X/NGQ3C+yY8mJ+P?=
 =?us-ascii?Q?exFZFl3BpXaz1SS6Z2dreVQ2dAXWW8XNobbkeA6qocCLbDZFYlbo9ucZi+P/?=
 =?us-ascii?Q?2x4r20jVRZeZlWKg13MTLkU957y9b/kL/IC4NlYO5Qfo5IeXO3xfz8zMVUbS?=
 =?us-ascii?Q?QYfwznp414ieoUx/NMSgs0iW86gt+ac6JYUwEeoarjVXzNISZli0q9DpGuu9?=
 =?us-ascii?Q?4g8KBliKtZUz1zAMJfU3tWsOcxFcJpM/njgRZJ9Sy6Zt/v7afwcKod4PYIod?=
 =?us-ascii?Q?RPv9F8hoBc+fksd6uvqLRV7RgD/LgdfcVmf59tbmfQSZI3uVglJppZWaOU4X?=
 =?us-ascii?Q?CEYEIpfevsAFSAazsPqlOj/lt+cn8CmHuhu/lB9MEB6+NgzjvxZ8gM76NJAv?=
 =?us-ascii?Q?UIUrRf7UnzVN//+ggzSJ6z3UsUi7YrOPTG/0u8E8nopcGF2KtsdLOjxCkn3s?=
 =?us-ascii?Q?Dtt/K23PKVZELkMWFZWs0Mi8ROAQN9Y9tABnSaZ35HSQcPd6MJXy3LviAeyz?=
 =?us-ascii?Q?ewZhfnnvSYSF5pbvgca4Bv9DXpHzwHr+u/UAJf5qLYkSW1LVO58GW6OKv5tH?=
 =?us-ascii?Q?6I76RDJ3sns+5TPlcY78sfP3QT3TfGMUjtqmGZmVNZ83QQuxDgLIHIG6yIms?=
 =?us-ascii?Q?ozZ1po+ZkLXRzeEZS4Pq40rrhxDarNWDBZuS2W/dwruTdJ4Ysurh+NUT8Tbs?=
 =?us-ascii?Q?m557XN1alBRQYFzE6fCwKdw25PoabVpLe85Svfsq4BEajmgRjogqFz5g42+/?=
 =?us-ascii?Q?9Sg6pOYWvuH+hZz1I5Q+DjzIxeLjxzK11Dif437dK1t4WFJMSNIZp6IAgLcb?=
 =?us-ascii?Q?gGx+cKiMof1p41ZAZymoUtnpXQFV3FabrFyuAWCWk+L9rZzeZT+wCrQgZq+P?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b9f167-8039-4a4a-8e92-08ddd8c48e60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:48:07.1281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiP+y/oW25s97VKN4hXDfSqudvENMBwDosn2O20F2z0zyt0Bzm8CtQA104Wh13XNza/wV/lAa3FI7hU6/dqwIxauMVrpiaicLkASaEDGNnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
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

On Thu, Aug 07, 2025 at 12:39:41PM +0000, Ciara Loftus wrote:
> Use the new function for determining the maximum simd bitwidth in
> the iavf driver.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
