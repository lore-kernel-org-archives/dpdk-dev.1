Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE301C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 08:01:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE4604028E;
	Mon, 17 Aug 2026 10:01:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id CF30E4021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 10:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786953664; x=1818489664;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sfa4lpL1SqeDaY4E092nbuX0tOwmuFPs8T5wj5ew39o=;
 b=X+6IAqrdLxa5ByMaAVTe5hCqxmJ5Au6LPnewKu9z8z00PoodLxoZc7DB
 ocsmRkDISc78m7FyA5QlDaMAimohmX17ISjVxnT3En8rrfWF9A3vVp+EZ
 3eN5uMfBjTHkw63X4bEDqt4KQCQ6Af+dMeUAylitORwvC2MtTodH0IUk+
 3D/u+6frmWKmUB1LFWmPN8c/hFkeH9huodDdE8T7Y2E5dosQ67lC5sV77
 JOC8yDGr4bNbua+PoiVA4rNYIGz7tjO51QRb36CaUc+I7F5OogfQVCH6f
 vphN8XIG6b8c6mf2SVJLA6F7jdZ+8GeneetNA786JsHveJ6c38h9RHUDf Q==;
X-CSE-ConnectionGUID: 1lMsdJYATgu50mX/ETwwyQ==
X-CSE-MsgGUID: QUsPRefUTnGIzrWM2EZOew==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98938047"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="98938047"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 01:01:03 -0700
X-CSE-ConnectionGUID: fFdWcqC5SrumFyskuxDZeQ==
X-CSE-MsgGUID: piJaUpzMQ7eoj7JNME2axg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="265460169"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 01:01:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 01:01:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 01:01:02 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 01:01:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc7CuMPBpEKPK95dHLKrHfou5akZ3fzYfzeHwiARKMMBE8RUnef7OG4rueSSJCrNnSiz8SZZfcVzV6RomFsLUaXuGc19k4OBk1wGc/aEJH5WI1EJH8NOTBgDnjC+2YbhGwdi4YsIH2bbw5MPh1dwb/6BYxa+k1pjledp+NNdprl26Q7ouKF2wVdA+qMbxJ2QtE7BYK+L0GSbvdBNfHG4lj9vEnuy7hWQrA0jUA6ui8rj3MVgyuMSCr3m9QBMIJ+GlEsoDkPepClZW3nynmpiIY7NxRXdOqb+8cQRsPjbGZQop8iMB545De3Rl9KE0ipbR9s6AiccQN0UlQG/p3agew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZPCzN2ncWf9UTqLIFEu6MdXHnqI41y1uNIVghF+3UM=;
 b=dw4XMkXgQpXEB7PJmpiNoJht0fQ6/1aIz/GjnauOelJElshdn5K9a3d0wEYR/D4pRbo3m1IsGv62DTQIj3oKRmi0jLong1tE+PXtgoX8p5Tiy7KbRDxrT+zOmyO189rgUGC3+3wInXP7GEcR3kt2wzZe9qZhYOKyqSI1C/D+FPY8rvSWfOcBmzu7JyWogAKlvgw8sIy/CWLv3ZlGJUJ6O2SEkt0mU786Q9oihDtGZN7/vLvUVeukh8SI5yjl9C8AOO1OSp7swcOj3aEpUsltRVK1eU8cFTmAtekQHv1SUvGbLLCQGoAVJtkINQ918tYBP6t7oUsS3Vh4h7uumhNFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:01:00 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 08:01:00 +0000
Date: Mon, 17 Aug 2026 09:00:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 06/16] net/e1000: remove queue stats mapping
Message-ID: <aoK_uCb1WFlDYBEN@bricha3-mobl1.ger.corp.intel.com>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
 <20260814194757.329424-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260814194757.329424-7-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CO1PR11MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: 5306be16-5423-41fc-1143-08defc35ad32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mGtrEOxsporSb+VlUQo84FEaS7LNM2SgAC/iO2aB3mcAWHzJ8BewQiwKEXENljNL/AFYLiYgoID8m/OtqWmNqx0Xsc/mAyWFMkjtLmrteH0kP6hrSOUOb1L5DrZ79DcmnatdMXDAvUjIb5IkuI7zs9LdZZIA50fMJMYqkhx+vplNUfTssa/yHJplTvVKuFwcEKqizcDqy/gE2PPWqt4maHJzgpGt7BXRM0FBM3gkSJf/rDtkJ74C+ni6hR3SHnrLrjqwjvLFnhiGaYL8+a1IVX4DhhN7W+OqBSOXMrcdhGmP6ruDbqPYi7NUy2T8okf6nVQyfpZFijA0V+VOjf34sAniCGk4DXFPinbQ9t7LDQnsBxd7mtRsc2L4CTOfbB78eu3KAKzsuqN1a/uD54MCbPRXbslQXfFUyX5qiVk2raXRwAkmhg6kSKBfRLJ0Nd+TQmWz07B4koJ+UwTJwIjjUqj0doW9TapZW4IXMxJg4v60bDTz4B8QPa4cFBYEXxFwCFd3unanJ9OJ2y5PDVvDRvmp8vk0KnaL7Ahlcq7Fz9AUBCNUDr7DNxMZdalwGE3bdHW5B3d1SF1n3X1unxyoUTBdBzy/09K0cq0ZzUVOqAnQ/+mB2amtaZ4wNrVMSCLP3YGgI83Hdy87YHAY5Lw6ufBz8/4IvB7wxukio9HlkFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9M+jBOCxCWajqUJvQteooaG58VArGny+VUEWjjdKswSB2jlhQP+DUPAAgV8T?=
 =?us-ascii?Q?NCt+dzHp0DQJRwjwDwbenQve4TY9iUY0b/s95tbcs0q3jmKc1qUtqZgaJTrb?=
 =?us-ascii?Q?dKtEXyjohioEnmqjVdGdoYr3hQ8c7COXAEvwgj6rqBXiLQdB83t02orxs0Hs?=
 =?us-ascii?Q?Jrsv+L8jVGJqeI5M275cF6KbRV4MbJDLPHCIzMGWxW8Y+xEFQ587rIB3ZF5O?=
 =?us-ascii?Q?hrFjj6FHzMSvtjtHwVs1NqT9tvReKKM1EQ9GcTerHep2vtNviUSx8EudUrFl?=
 =?us-ascii?Q?0ESqbWw7IxJ4edQVRSt2cRgbOt0Kz4P0it1zbnezw3juaLLss76cDbib1Yw2?=
 =?us-ascii?Q?dKr5MslDh/w/z8VC6t+NoAA0iQJ+9Vo5x8VMjgfP0eKdejUE5sR/MzW5dzt4?=
 =?us-ascii?Q?4gxGPaaJcm+kbaC8yJpx9O/AYZ08xMh1+NCDxMOKuotYsja7mhb5ACGBck6u?=
 =?us-ascii?Q?1aHbjBGjV+OKaqcuUqBrwRNm3u5XGoO2NaZ9sr6bgYjXjf5n+dXKpdRUJXnY?=
 =?us-ascii?Q?39IZ7/0ncYOIGajC3NdvOKsFUn0VHIKGSo9B4P/wI09/gbFej3fEWozXwG/d?=
 =?us-ascii?Q?HAEnqzZA84LXTut1VtaTUuoKB0n27FG+x/nGPF7viV+oIYUJAQWtkXqaLUvY?=
 =?us-ascii?Q?In+VbKlfJAw7sGEGHIi94iFSzhyaKC6U0Zq7sOmMrRgztFRN54aVgoQVmYBH?=
 =?us-ascii?Q?qObmklCZTYCx3V9E6FEbg9Wdrq6O6pt4RUvQ1ABxmGMRgBdScyspWGGwpTD9?=
 =?us-ascii?Q?sylAJZdCveOEXicdnCB6v485zwp0S7/WtPrnDfVlP6VrrlQhHycDH9mSCKVq?=
 =?us-ascii?Q?NM7r/Sr6ZhYnYOn9YmDa15NXspit7uiyFdfPkKcEF5dD6z3jrqsXiwKZnDFl?=
 =?us-ascii?Q?/wz8zDdZeWa1q/M5sxfCPgtqR32jQdXc43q7kZVzpd3KmXmtygNjlxiPfeSE?=
 =?us-ascii?Q?yrAIyOzMWc0zhkgz1RUJnbmElPJ7VDFxcIzDU1OEmybMMjsqXpCU0GmVgnmj?=
 =?us-ascii?Q?c5sL8HoSUUFSf1RgsmLG3V+nol10bhWeeqH3D/bQ58srNY6wGaZJY670ZF19?=
 =?us-ascii?Q?YcPeWzNU70Z+x9ETOV9OTnGyW3g7efnAQXsi86ZuMm6Xc3lqVZKGIs03D2EK?=
 =?us-ascii?Q?XxxojB0t0KSDSPj0QsLAP7n3Gb7RLziLJPs+zpp0t08zzMEGUh0hZMw+ulMF?=
 =?us-ascii?Q?mrNoqEYg6Xs8vkpY5/AMe6Pd2EVZXb0oR+H7CxvNQ3a2KvnjLJ2B5rz3RVqr?=
 =?us-ascii?Q?lD6ZiHAcWtqoizu7NXPSBrWqTCaUwhNj6m2rWmxy2h9oGFwuUGxVrhubBQZU?=
 =?us-ascii?Q?ZVpw4cWVU8wHEU99I9aWmJuVGHjmtrXElzY6JSXIlerxSVc13YMiZ4Oz1JBN?=
 =?us-ascii?Q?GpFBOFubr94XybW6mjYXFE2qlBDUAlDfNxkCjM3+5zeOQqWTgJR/ENQTZpd/?=
 =?us-ascii?Q?7MjT+GxGd1ogFlkRacNj29HdMTY2qZ65q59n7VMDP4HHppOQOyCB259Zo7IJ?=
 =?us-ascii?Q?vnmfQMk7F8o8UQ/I8y7gLBiplcoJxCI3J3tfPJKSNrLBUSpGK8M1Z7TvTi8b?=
 =?us-ascii?Q?aE4Nl6xIeFhzo+P02062aZswnuM0MqcTiganUcomkekJgETckl0KEYZ0yOue?=
 =?us-ascii?Q?cqwUGMfzQqz2NlIvOuUm97PH0hc6VHS/V8Dg0I9dTAt+85JeYP4lIK/E+OMd?=
 =?us-ascii?Q?HItahz3fk+ZXKLsjbh5RMdC5DaB8u+PH7icE6myA6zeSITlvHp3Cn4XsqmKs?=
 =?us-ascii?Q?UyKKxEoL+BHfMn1mZlV7tdDEU54M/KU=3D?=
X-Exchange-RoutingPolicyChecked: qIzYWrOqV4hJAxYM5Zb8T2ieNHmEpcpPGh7Sp0KdwzaYezZ9a+J2iQILpCSsuoA4BMv6rvEoMI6jENpWa8WEfDsE9NeqFUpgiz8zhWgPQrJhHATo4XATJQpnzPO8l2bTrc5NX0NdVVOsBCgLx6oOsrG704RzefdS0unjphpodpdcA+kRG9xg4aNpqceRd+h2mjc6I8dDofjlEApQYFOAdTkcviS/9bSIat9i+EswzbkYh2nHMuwUqfybFNLBmJMLsvon08pFYHlI4w2rl8iG7qA363Pyo0kdOmggKj4XUzH4wmnUYCl8vmAdRwM3Z43dQBSyYETDZuLp8VK3zJ3qpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5306be16-5423-41fc-1143-08defc35ad32
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:01:00.4561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VJpbkpSzEDvAmn43pYI8rRprbBrIRQr2Akut56zjS+1Mh/GQSdKkxw4hznkwn8YW4NbC2kCxUsC+eK8ztksWow4bqyiIDjJzB1MsTIP5yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
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

On Fri, Aug 14, 2026 at 12:46:02PM -0700, Stephen Hemminger wrote:
> Support for queue stats mapping has been deprecated since 25.11.
> Remove support for this operation in the e1000 driver.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/intel/e1000/igc_ethdev.c | 56 ++++------------------------
>  drivers/net/intel/e1000/igc_ethdev.h |  2 -
>  2 files changed, 8 insertions(+), 50 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
