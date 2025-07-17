Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B491C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 12:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5D074013F;
	Thu, 17 Jul 2025 14:16:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3CFD0400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 14:16:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752754590; x=1784290590;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lir0MMJP4DcCVSbwBzs6xTjUO3Wbmtvc/b+TLCi+ckw=;
 b=b57v2b6PBOgQszzxpW8pmB7zbWRncwcaACnZq1dxPKyamfKSDQsrkncx
 ML6K55QvydSJi+bce85xCNqHmh2cqRB28pA6MdLCdwfRiWCZpJyRhaJT0
 wfeXiCbWI3fkdWYLGu4ARV83MV0peFISj6YXhcpeBOXNE4EMfG3ZA/3ts
 nhOT78zMEhBSAAA2kRsMtC0AXnOkQVFDaKhU9bHhO4fHZ5Vcuy0FD9lH1
 xqwFml4LI8h0Hv0H672fEAesT0FPo8bRNfdckP+UkrvuSZtKS3sy6vSSW
 DmLgY54+dV8t0X5GvThzFi0odcjBWy8zORsaCjce4PExYPNmo2tfq5Pr9 Q==;
X-CSE-ConnectionGUID: wzx7qk3MT6ue4HjG712c5A==
X-CSE-MsgGUID: v5OjFyMTTiOU+ob44Uuvcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65286101"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="65286101"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 05:16:27 -0700
X-CSE-ConnectionGUID: k6z4pK0bT7eYHE7vCrvN3w==
X-CSE-MsgGUID: myfado7GSVGRDYHw7IV97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="162070834"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 05:16:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 05:16:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 05:16:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 05:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBqOuR2gyhW18FB6k8J57iKVPuWJjgZfSyyMH2n2bBMBEfGqKpz1LJocp7nbdewdb9untFElU/Gi7Ol4BaPnwYlvOQeYOr5j/zJYjLA2ocLAaWelnCAzXAIi6GNE6esHGaiUNJemy7XgxKL3C+66cFaxHAXJTfGQBMfinJ6WaZN/5VqTnlYBOHd0qVCQI1J8dh6to7d4fqVNY/rSPJapOv/CTNvJDyPhpNjz0UvbhKCxRkUoD1BAxMOZ6LK/EE9uv9I5EApMo0Vs/GswAZcXKS9DD7UP0p+EpGHwsFyttcnBHgcldZ6hWi7c9MJVk2YY/WtJIkm/hQ6Dr5bbvYTU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqYfe2PEdWh/ieewipATvmSIzhRjOwK8TRSfD9AAaK8=;
 b=MjF2iQWg/PnABfXDVQTIosaSbJvRoePvAdPIaXVvIMa37WmZbujmNcykxW23m+lxqZ3dsRA2Znjlmnbfb2hfwqTjyTdDX6YBbqm/McGWUTT1MzbsEs/fCj21U2E008gbE9O7/sg3J2Yjk+t+9BiwwcWny2+9hFZAUzJUIAJm6oE5JMZsmzua0QzMAC4VJ3nIXB2gcFT8falYeA5PG3J63j8ZzwrGVDv1B/+B0dpnxPCJUzmz2G/At/c4PHXiAF9ixd8KRLMm8PXdi1zUHRuEMznqntSUauNVWVgpS8tpTTMm2FMnqKGvqz8ad0Yz/BoMOk1hJcyNR8UJNVBNgC8sGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Thu, 17 Jul
 2025 12:15:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:15:12 +0000
Date: Thu, 17 Jul 2025 13:15:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH 2/2] doc: use common description of EAL parameters
Message-ID: <aHjpTFbdEszzBSGQ@bricha3-mobl1.ger.corp.intel.com>
References: <20250717114604.2285791-1-david.marchand@redhat.com>
 <20250717114604.2285791-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250717114604.2285791-2-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c40be5-ad46-45cd-ddfc-08ddc52b94a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BZgjEb9+vZPRWqcDSrJMe1N4hzDECtol0fVy8yu3sbWO58sbzLFIs1lYFOBl?=
 =?us-ascii?Q?dqENBBM2uYRS0lCtmyk9NuWptR3WdfhS77X+bbpt5pOjHLw9qaxtp1HdZU2w?=
 =?us-ascii?Q?+6ZD3yTLsbz7FijHTLycaRM/8A2ps/SaqF6NW2MBrjM5UL60+Xf0y6S+s4dt?=
 =?us-ascii?Q?OaUwu8/IhbBafLV+akt8nTBHEe+EZpHz1GGVWbqkRjE60Z+KZZjM5JWCAf4b?=
 =?us-ascii?Q?UiN2wHXEwiQClw8W/Bu7+wo3pbnE2IFnjqWOgFp/s2Dwn9B0Q9Ete4Hipzdh?=
 =?us-ascii?Q?wFs6g0StHg9mW+JQ5O9CZkt1IL7tK+6Mn5jXQKH1qS3rgi4ZW10xAAYjiwB8?=
 =?us-ascii?Q?5H77Jbnky2Eptu3igUCeDfFinNUtiWFGqNXIY+40/LJVf38CQZpfVepUGELJ?=
 =?us-ascii?Q?BE0gp8ZVFoRgMgUeT92oDrWqs23/lmLVllIHHR0w8VSTaV0zeIk+NtgvbcTZ?=
 =?us-ascii?Q?l32coffKLade3F0HXqAF0AShO8yTj62awlVjLeSIItQ5NUmdD0WTdzgBMfjG?=
 =?us-ascii?Q?k6IH31er+m7oRyb9GUtXGQnzloaNHAPOa+/z5ZGI4uJfbh6cvvdFFOeYmBoh?=
 =?us-ascii?Q?iI7TpVu2U7Dhtl1BPcAyfFBdUBWT11gEmDmFYDADxK80SzdD4t7R5rOqnXCy?=
 =?us-ascii?Q?uDbSvPDqkR8YYo/t1Q7x6ZLPBVb6whGiQoTAX4a6ymAP1dyYP55bXybMzu2D?=
 =?us-ascii?Q?rfSKbsKQgTkGy+rIV5eclzd6cZNchG1hPH0j0X2BGLc/rNhYhFSO7rWxyRDk?=
 =?us-ascii?Q?j4I2GAZHh7bNWrb4Yigau2ygLUHc1bo7k/j3cuCGnjs3KhqOb4sYQ7mrgtY9?=
 =?us-ascii?Q?qNfdvU7T7TqHI/Pj+mIL0oAdTIGggwoK31QjKrZhAFBVHC2tWZV7KRy08k3w?=
 =?us-ascii?Q?YzorE3Dl4HvzAYpZ2bt4yqFjh7cR/fUmP7C8yquzP44mZ7WGgWKwhe/qzB1w?=
 =?us-ascii?Q?Mj4cZYXD4sWislHGF6RSTZWDWQZC7lMhf09v7SLlDtp2OY63Hl+LbMJ83HqC?=
 =?us-ascii?Q?VhPXKswu6osiqqjSfmPuX/I3wCimlRyldn1wdtJrqA+3OaG0e/3nfVbllLtI?=
 =?us-ascii?Q?TYOTfe8heW1W8WDhSF/oNf/EhCPTkjklWPv7n2mmmZsjVq90e+XiDh8XiYmY?=
 =?us-ascii?Q?OL7pcrmAOB+++6jA3qYz2rhzuqfaBP20Xvtxfh8/CEcRTE9qmLcYun70T9ik?=
 =?us-ascii?Q?RDxx/Lywhs9YJ42a7i02zDJ+KGi/2w5kUnExNKKdtv3caESYxsCPX7/biYSi?=
 =?us-ascii?Q?4jg97sovUJGa1Nh3pmRBybpRGoLvx5DwkVnx7pcQrBsXOEHHPM1+qdVLivGv?=
 =?us-ascii?Q?wMZNme9Aszy0imXMLL3O4/Vx5yUD5nTL/hkty17aErioGkOyG4g8AyXcVl+t?=
 =?us-ascii?Q?6G05KRsSxuNhXZzIYC/dJ2GnMbo2tVtjglXwcE7mEv84+vyeQ2WrY6GxU/BQ?=
 =?us-ascii?Q?Bd4DZqXS0Dk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wp14eIxO4Aw/CHEC0VvJjfLX8+ziRsd8zvftsxtBv6k/m3v5oMp0YMrmlVoW?=
 =?us-ascii?Q?T27HYNrePoAtl1cVpdoK8zNzDPB1QnmTksGgtjjYv3miD/R5X27V7f7+tvQQ?=
 =?us-ascii?Q?OEgXmxuK5XyRkENTCHtYmyqXieM/q1XXMEuSed7cn+EQWGsBhz3KWWbvXXti?=
 =?us-ascii?Q?PqDsg+zKc1QWwyOl3PD3XGRrOI/5Bk13odtffnhvaa75MuAZnYZKj6nbSONU?=
 =?us-ascii?Q?Vny23tztqpqggOI4Y5dxWfBWqToVhd987yAxhYIMIJ3gQmXhVxEU3BtDzUwS?=
 =?us-ascii?Q?Uto0m6U9yRrKlHtuD1hwA39KT+OuuJqCIiXEGX+XY58Z3LW6XI1CEYcu2WH1?=
 =?us-ascii?Q?k3OEfZi7ky1wm6z4hxXylXZdv2NhFmnKxcrm8zg92rhy9q9gjz6/jmo4tpOL?=
 =?us-ascii?Q?pQFtIxACv31n2msl5l3q+otvXg4tZCM2gUOtcnvtEGI+gRlbVk0Da++ZzdBG?=
 =?us-ascii?Q?RhL4zMZGiZ0Bwgdr6fKu7U+acKfGJDl1D7GXUurDIlJjdo/868x5UjClCm3U?=
 =?us-ascii?Q?VEuLNMS9qdjZtK59wuKLoLQH5Y1yE5UK0Zeyo52OjoUDJk4KhBCf1WHkT3pT?=
 =?us-ascii?Q?xcBUtaIDGiUfSGnGjOc8yrm90VvmXaP8wwokpAHsNyJ8rOrpoq4EtmJ237JJ?=
 =?us-ascii?Q?E+DI+kSKDNcmbdWhtFQEMxV40F93sH0BI6r4cKzybiAo7kSTSUuwdCWBf4UJ?=
 =?us-ascii?Q?86do7tD21U/KQMjVCgRYHeNDdXIFH55ykrHIeH2BXJHrloY8sN+Opl1A+GyG?=
 =?us-ascii?Q?aCcuSMQ6Gux570zM0pHSZQsz7cFBM5/6hRr9W57Z2HUbxMuB46hpwNdsZK+2?=
 =?us-ascii?Q?u6IkXW4rv9XvRYXtczyBwksMiPXo/gicSQVkcLELi/qnVvnO7tXebVyE2k6L?=
 =?us-ascii?Q?O2nrQjIzifSJ20vKskfIsQIckVg6Ee75iVB/BNVEaiXXijcltrk8WBfNvDil?=
 =?us-ascii?Q?sA0ShSprknNv2iCVhm8LSQLABBZ1UOkZfvO7cOnIXRr+nkAcFI9T1xlVdxPy?=
 =?us-ascii?Q?ujAXD3xIrIoC88cLr/4XIwPwFy3UKiBw+BB0lsGv7okf6+2sMnRkNfzSXPiN?=
 =?us-ascii?Q?yxKX485VChp4r/3VDdSDIyOjJOkFVY+sfT6c1Mqt93pNwmjRJ7IKVJv3dNMi?=
 =?us-ascii?Q?d9bUwfV5kLqs6NqrMq4htMlg7w4jLXQDRe6Xv3L8VxEzMNl6fM6l80r4lIc+?=
 =?us-ascii?Q?N4csZ8wo4TCS3A94s2LAXppm0DOrN0B7lwBtBq0Gu2CqSD5LeIeiCMR7AJ2M?=
 =?us-ascii?Q?PlB6QsZuAQjr0UXuxjTw0h/YnkoCfHe3QODs4gS3Ts8uXEPG4hGK7kMtlytJ?=
 =?us-ascii?Q?Bt0oCwJ/FJlbGIFTYaImOktE9HaXCnjAG+0cPZwdptGq3Qzv+sRe/jkP6e5k?=
 =?us-ascii?Q?/5V7uoIG1Lb8eNhqvxj/8OBJFxC3JKDm+r5bq3t1f9d9+HrB07eRZKyKdDZ0?=
 =?us-ascii?Q?rH3VD7EaWF83d3eapGFBOCVYwsbS4dzTxtGsBkKaSzl3t54AWs//D353G1wP?=
 =?us-ascii?Q?RNHw6CLHcv5NElT0v8mCs2m2DUf0ufTEMDw4Doqg4TyJ6XHxVjCzSScQ5JWZ?=
 =?us-ascii?Q?5xXpusJm1r8LM4D77b7eoiyNqBPUN/7N7PhZ50VLB2Xn1o3v53i0kbAIywLV?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c40be5-ad46-45cd-ddfc-08ddc52b94a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:15:12.6480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF+KsDjueFnfgLn9T3VUC4OOqF6qlS1/gqhFuHDNJHmnk9JpVIykSy1hptiw9tHS4jyGH7QgJBGAOEfKm7VNnWZYo8qya/p8PA0BFbjFmAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
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

On Thu, Jul 17, 2025 at 01:46:04PM +0200, David Marchand wrote:
> Rather than have a subset of the EAL parameters described in the sample
> apps documentation, prefer referring to the full list.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
