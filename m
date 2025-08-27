Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36530CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:55:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 672334029E;
	Wed, 27 Aug 2025 17:55:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 96A4740292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 17:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756310127; x=1787846127;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Xn/3fVvrzCGS8xrvesaDdPaTTZlV30Srp4EhdsRBJpo=;
 b=bldtUli1UW0ioTsa+6dl6xfNWZgeMZ8e2HA+LuZXS7Zq6L0wqNjF8KUs
 BA7OUTnl9tR34FivGHSLZHtjWg/lBKgujtP3AC2ekfefyADgohCCAh10k
 3zyDYQAJYz3RuddYt30BbIih0FvJxE1SWW8ORCPt91fBo9AswICjL7r/N
 NsN2p6wbPWQKxOPMIdEqHLb48aDNw/ANpFKO3cqW98/8ZA0E7ab16CvvQ
 SUUOZKJbJWbfRID/zH5r1ehDSMPcdvN2xWq1XgrnOzKSChrYt2haIMPb2
 Fm/FMX3WsHcnjoreFym7ldeZxXsCJj5iemVFkP9YDlwhG/vCC/uUc7Pu/ A==;
X-CSE-ConnectionGUID: DCaiYNphQcGNCRblQN3Cow==
X-CSE-MsgGUID: tXVIrfe/TUGKPsGQ1SfnsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58631424"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="58631424"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 08:55:23 -0700
X-CSE-ConnectionGUID: BIp7JXEJSTSM4CvYyNKuIA==
X-CSE-MsgGUID: l1+3FKfmSri992HLpgrDVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="169389027"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 08:55:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 08:55:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 08:55:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.51)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 08:55:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSK3i2Ti73KyTC6vI4pesGWes4sHNxjlRlnpgmOKXs7wA1hR8n5tHxrXevoGmyoV8w0FRVCHvT/6oy+RnPs1tm/5edmb1WdoZPvB83kzN3ir6I2W+uPB3TQWq9duMfeIJLXvryGq2ROmfgK8z14uenQeeISGUixwr2larLdSxJN7IRZ3CE3qkKn0ZL0Y4XN3go9aRb6ovGSfBzX2BsEaR+3sudpKr87FR3g08Etsoa9GqHMKWEzVy9GVaj+N25dldXW2Il169QYpRbW+xSjXHIE2pbOxBEpAdhVmswiRWwrsb5EZf7mWmSSBl3lfpVI/gql9WPpmMSJ0HWoJcsPkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3x4/k2j6sntMpAJzQh0HmHVuytEaNMUljg0Z76mSLs=;
 b=L6kIf7T+noJ4Krjjg9PvUxncYpPbNTO6RtnxJXxWky9b57RwI+foBvjV0zPzLgB8Lhs8vk7KOyj/Nes9suzzGu+Ab8pmvolD0loK5q7Ha/ZNDXhxtQ5vHJlDiTG1aE9TAd79K/4fgVVEvnYcNd/MW7efoqeTq3M1zWPZFSxppJJTDB3ztuWuqQVmddvU6oVkRyWqD/TKNoqp7wAnt53hJBTExpgSQqU9uh9XJa1xEpdof0afQzepBHGl3eY+x8rxL/cl8hR71naArrm0B5DwL4JhNSyyxUCUmf0yWPHJhz+v7qWXljH7Ta6UqJUmRCzd5D6yrDbsm3CHbGexCwUP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 27 Aug
 2025 15:55:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:55:17 +0000
Date: Wed, 27 Aug 2025 16:55:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, <dev@dpdk.org>, Tyler Retzlaff
 <roretzla@microsoft.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
Message-ID: <aK8qYCquuQyhrM5u@bricha3-mobl1.ger.corp.intel.com>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
 <20250818093416.057aad97@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE53@smartserver.smartshare.dk>
 <e9017361-f29b-45da-a1b0-cc745b8c906f@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE79@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE79@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR06CA0015.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4612:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0f3822-7b2e-49d1-ae8f-08dde5821e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zGaWC2rtXPwRXoT4rdTLJOBx7nudqSmpOZscZQ1NNdLp8Os7d/yyvHccgb?=
 =?iso-8859-1?Q?2T6Js+/8AkZO1dELoGGB7I2FTSWt6sKdPYUj7kXwq8H0b2ZIohbqe6KN/9?=
 =?iso-8859-1?Q?fSERWynVCOSIUswojw+QpHA3ycU8uZBMO1MWzItpQk+b86tsH1sLXJnjCB?=
 =?iso-8859-1?Q?7QEfkadt/WBY02OihlXAA1h3VqXXymSIc/6N/k3+zqvy+upmLhmDIkAALb?=
 =?iso-8859-1?Q?gFOJrHtWZHBB/1XFlyCy9Zz7n93MjNO9RMMWmwUmAPW9BdKJ3GQi3tFxhC?=
 =?iso-8859-1?Q?g5KW8mX+or+5a5bUVhfZHr8KsLVSK2XjU1FK2+OoHAo9itp3+42ZRLrLK5?=
 =?iso-8859-1?Q?5baqcwtL34/TJFV+n8NtxIVMNCGuwhicWW0RChga1BbF37HTEoW0coxw2q?=
 =?iso-8859-1?Q?bfN5z4wgqgI/xHxLjCM2w0K7gqWGR48+GPh8UxVOdzaFsMKxjC//jzHwj1?=
 =?iso-8859-1?Q?TeAAgnBv4NtgKUMvS1N3BW2qP+gImfaVqZdBnmd8jE258TQzsVdL8s9ywV?=
 =?iso-8859-1?Q?M51+ycFfMwzPZ56ti1ClRGEMNPYwb1S6wC4sHASv6ur96aXpVFFruoLOy8?=
 =?iso-8859-1?Q?wBUgqwRluXTcNNIcjaoVLrbKDJWvh64xMmtQfXI0h+I8fu2bDBXEays3uN?=
 =?iso-8859-1?Q?Wimtv73GvCyeDJhikySMQG0+o3yiw6dqcrDdVQRsGsSBE2awd+pmjgagFr?=
 =?iso-8859-1?Q?TOYGodf5S7YoGEUwW/W1lkVGMpPXynd9Af0n8POQSskNRNU6inlf8C586T?=
 =?iso-8859-1?Q?JTNse5jsardT4Z4n4Zv0CMBAag+MQxr9kbCMSZxWyTMzty9iRLsozmHbEp?=
 =?iso-8859-1?Q?/T710Dl73jMfCCPU178wBTMRIG/XgQVHVriKEKERJVW0W8Dis1PdOMgoae?=
 =?iso-8859-1?Q?hZsRtqDV7kb9bW13r2l55omdHdM+tG5Nir7nhhvSJp7923TSQeRTDamLnF?=
 =?iso-8859-1?Q?WUvO20Vyag11T1fEQw089EKm6BfpU47thwDUTOTqTC5xy0lGUBpPFaDKdZ?=
 =?iso-8859-1?Q?Lin6/gpMPE0zEg7flc7cqTIQeQ0uXdpRpTq4nWQTuSFfn3wA/wWBC2I6F6?=
 =?iso-8859-1?Q?DSY03fFcRxO0tu+YPOIirt0OybmPJ81IT7UKKkihOgrwXYui5iYNWleJ7V?=
 =?iso-8859-1?Q?pnS3cZ5wxZnGGVD6//h6D8NNvqa4qaESGbFSbfqsfSr8Iu8gw7o/fsntxl?=
 =?iso-8859-1?Q?V8t3Xa6rk3Vnp2PrQ9oxSTtS+vHZhbfAuGF9CU/6ZcUrIQgybzX2pGQMTA?=
 =?iso-8859-1?Q?C5rUg7dwRHUpVMIw0dp/8EJ6TMX7NA7J/zktfz5hFhq73ltM1h67HzNhWg?=
 =?iso-8859-1?Q?R09JBZf3nB7xdrrqLktmA52nkpvF1mL6crKjXNVDBEWTlcueE7zhRpgmTm?=
 =?iso-8859-1?Q?EtGqZRHcz5hUU4guxSeQq/IurUouDrkRmckqP+iXqDuOuK78n7RUfl7RXW?=
 =?iso-8859-1?Q?bVn/aUqlJEFiay1J1P1TkepVrlkwCz0MtZ1J5ptpzVANq4AC4Cht08GOCH?=
 =?iso-8859-1?Q?U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nhDqbYYktHiah1U181FxXl5/DEhdXziqf08BooM6xEgo9VItqBuu8hC491?=
 =?iso-8859-1?Q?X/K2+hmgO2/+rfrMnkakITYpAGqZc68VNlHdSG2r80YOsk38xeQw8d3yrw?=
 =?iso-8859-1?Q?MxSXkVl2qitF31N+99buWPkGb94z7wnNbSXrYr6ZVbKRikvHmmGSxIkJVR?=
 =?iso-8859-1?Q?hVvT9iCyJu+2D1l2gJGKrsSVGJRGD69bxfEO9Xpf99dfiDtI4Hk7PPbe3Y?=
 =?iso-8859-1?Q?+qzGASd99Tte3LgEHiksSxx16oUtXr/+Uq90+Ta+SWKWz28lTRAzRPsv9F?=
 =?iso-8859-1?Q?3z5DwPb4IaLDRYxkRZNcmhm8RtHIosRtgDAUUM02ULfZM9LFSqNmDj3UyM?=
 =?iso-8859-1?Q?yz2y3n1I6MfcsOGdj/m+FIMfWET37aKvoQmFF+IsUC0IR30jIV5OP+RZeF?=
 =?iso-8859-1?Q?lR0zHu8iXhjTkJ/CcTfe1rrLrV9a87xt0GpaOxbNJFW67VDHfrjiD67vU0?=
 =?iso-8859-1?Q?G9qvJtgL7/8rsdO+ppVMaabyxblQZN1+/H/9QMDwFT8T94QKEWupCYep1s?=
 =?iso-8859-1?Q?QtaBTeny3bzxYPzJYHvMaIKupPmGitOER+0ee2zdOgTlwtkTyNop0Db+S5?=
 =?iso-8859-1?Q?TD1kg4VvqDZW2esDCVZi1LfUUgkxprzsJVEb8/YnV+mzEc13PxzJjbBbhP?=
 =?iso-8859-1?Q?8WlHndm6JBMCyoOkpHYqN0Q+ol9gkG0UijSdKASgYuF3Ol9ujQ7VksBJWy?=
 =?iso-8859-1?Q?o9pVEtfRAiUPThq9PxxaPt6sU8gQ/y6YaJyZRZVrv2KCha8qJ9yQf+wqEt?=
 =?iso-8859-1?Q?1n3Wqv2sh3lubwcILkudrdkrrGLRcDdcaB62euxn78gr3lb9xcbCEzE9SL?=
 =?iso-8859-1?Q?sZhmHQ7dBumbX7eQvpoUebMyf1W2I5rO8F5dt/BCkWenjSUfc0jojCrPsK?=
 =?iso-8859-1?Q?8i/3WcsihEMqmNhWoQ+ZUBcOlKEF8eznUtcD7MSgyhU1MngXFyJq2Stjju?=
 =?iso-8859-1?Q?feaso4v50f4h+GeVtJotLrd9dB9sA4Fq0VKQRlC+0ds7lE4P9VdhJD1q1A?=
 =?iso-8859-1?Q?nFMXW/fiNl/OpVAuz8cnGRNZZkNvYHYo3l4aM+I3SKEbkfGSgVbS+ePlIJ?=
 =?iso-8859-1?Q?xJC1wrUDp28D3Zsu/8EloX9SpQtax+v9JKCHdz53mLiUtKpASE2PN8Qbqv?=
 =?iso-8859-1?Q?THwvZAN5OmUjkx9pJ6rU96rTxAdpl032aJHCmP0m+fyP59yeg8R1Yvl5Mo?=
 =?iso-8859-1?Q?qqt3BLeVv6ByzaYkPE8BwUuU1knAvkrKB5Rdwn+n6bePc0tjJNQfzGPJj6?=
 =?iso-8859-1?Q?aVpKagaMzb+g86NBA5RRVBnT/NoO0tuY7k0CyNAaQ6EJ9Z8T7zk4J+D3CY?=
 =?iso-8859-1?Q?PcbdTCt9tEUCtZxDdMfs3XDTdImKl2tYRcrrPO9TWZmGLOQGft470Zikmt?=
 =?iso-8859-1?Q?O7fLA4THaLqpSMQVx3Kngy7vr2ZPbOuB1PSbOzLF/jS7i/wwAQmy1aVkFj?=
 =?iso-8859-1?Q?1w0oYEKmrNi+dzapHbR3loGBaO1tHt9P2RcNJHqYGsnK9TroHNM6lHa/iR?=
 =?iso-8859-1?Q?4ZPmlFAv8yGBBa4hCOU4C8BogiwnEGn/4aA8KRPBDXxtIs7IXur9/xZh6U?=
 =?iso-8859-1?Q?kPrwLk3A1X0cj/ZVW7kBwc0T+ti321CzhQOvnroQtlaCOrkwSd6ZEFozS2?=
 =?iso-8859-1?Q?mVrvrEwHC8K91VEX1qgNvxZRDZDV026ca/M+gES6QjGB9N4tKbkNYDmg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0f3822-7b2e-49d1-ae8f-08dde5821e6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:55:17.7514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+mjBhI0o1HIRlzY9YePqSj6LBSHeuQFgPZpLqLu72YLe0da4Wg2s6UCqlqKdJtYuAVAdtpzbygcb/btLQeU0UTr1M8j5CsVQ6pyMpHZN7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
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

On Wed, Aug 27, 2025 at 05:08:50PM +0200, Morten Brørup wrote:
> > From: Burakov, Anatoly [mailto:anatoly.burakov@intel.com]
> > Sent: Wednesday, 27 August 2025 16.14
> > 
> > On 8/20/2025 8:42 AM, Morten Brørup wrote:
> > >> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > >> Sent: Monday, 18 August 2025 18.34
> > >>
> > >> On Wed, 12 Mar 2025 16:15:29 -0700
> > >> Stephen Hemminger <stephen@networkplumber.org> wrote:
> > >>
> > >>> This series adds common macros for safe iteration over lists.
> > >>> It is a subset copy of the macros from FreeBSD that are
> > >>> missing from the Linux header sys/queue.h
> > >>>
> > >>> Chose this over several other options:
> > >>>    - let each driver define their own as needed.
> > >>>      One Intel driver got it wrong, others will as well.
> > >>>    - rename all the queue macros to RTE_XXX variants.
> > >>>      Seems like useless renaming and confusion.
> > >>>    - Several distros have libbsd package with the correct macros.
> > >>>      But adding yet another dependency to DPDK would be annoying
> > >>>      for something this basic.
> > >>>
> > >>> There are more macros in FreeBSD header that could be useful,
> > >>> but we can add those later as needed here.
> > >>>
> > >>>   lib/eal/include/rte_queue.h              | 174 +++++++++++++++++++++++
> > >>
> > >> Revisiting this and wondering about naming...
> > >> The file rte_queue.h is not really DPDK (ie not related to runtime
> > >> environment).
> > >> Thinking of calling it bsd_queue.h as a compromise
> > >
> > > Since it replaces sys/queue.h, then maybe sys_queue.h (or rte_sys_queue.h).
> > >
> > > But more importantly:
> > > It is not really DPDK, and thus shouldn't really be part of the EAL.
> > > So here's an idea:
> > > As part of de-bloating the EAL, can we somehow add a new directory structure
> > for independent "libraries" like this?
> > > And treat this rte_queue.h file as a "header file only" library, and put it
> > there.
> > > Then, build wise, the EAL could depend on this "library".
> > >
> > 
> > IMO it depends on what you mean by "EAL". EAL is environment abstraction
> > layer, and this header abstracts OS, thereby meeting description of an
> > "environment abstraction layer"?
> 
> This library (header file) is generic, and has zero interaction with the hardware and OS, so it's not an environment abstraction.
> The EAL has become a dump for "everything else" that isn't an individual library with its own subdirectory of the /lib directory.
> IMO, it would be nice if we could separate generic utility libraries from the EAL.
>
We could start fairly easily by extracting out generic utility headers, no?

/Bruce 
