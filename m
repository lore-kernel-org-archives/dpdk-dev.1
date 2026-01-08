Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E08DD185CC
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 11:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FEF94028C;
	Thu,  8 Jan 2026 12:06:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 167A340261;
 Thu,  8 Jan 2026 12:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767870375; x=1799406375;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KXVn9i9DfsN1mR98PeHMI7fqkJixxkikCttuqlkBHBQ=;
 b=kJap12TaTtYYkL9OvJDqb93OPv0uXdUsiOrnwrHIOZhQZs/odty08P/f
 NuqrRVPjajZZdXcrV1TI8RI3WFJhIBJEIg8xMtHEtUJ8ZMnRdGtv8CW+x
 sdKEEhnPPmvFXwuUHvjrY65+0Hf/gS0HCUxJCi1LtvKQAkgfrIMnOxFa5
 nceSRDdcyVZ5Pv+Z2oDYPyysqHJYzAzixsd849nRgj0wu4fQ4oWshkdPb
 spqaZbEvyphtXMUKWfyQZ77WexmnRB9c3SM3/LRk5aKGth0sr4irQ+deH
 xFj/KGJIzBtmviZ+18ZamggouUnjljhY2ulhEVdi5a2BsISclOgwCx2qL g==;
X-CSE-ConnectionGUID: hTRJdWI2SySI0FVxb7zfDw==
X-CSE-MsgGUID: OsKqWy15Ri6HkGDOrJU13A==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79887401"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="79887401"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 03:06:14 -0800
X-CSE-ConnectionGUID: yPDicRGFTJe65b4aQ/0UsQ==
X-CSE-MsgGUID: Afdmyc2ES6mdxtpzXXK8TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="226602610"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 03:06:14 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 03:06:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 03:06:13 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 03:06:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX8rdrNbzGNmVWhD0ICAZT5Sf10RMIs3QftnF3p7QdGEomZIiZ0qM9bWcyL6M/MQ42CgbOZIrIOB5dzACcRaggNMz/RIPTc+2+SwZR3PKjR1hDn+yRFvZz+JZNe89VmVBWxypzP7ueSSl3tHOi5mUNdtLSkGpUE/HhE2tguwnKFz0+a7v/Zzpas93GL35YXQG4MJsL/uPICFrGN8/JQLf1xXfRkCBNP+sCa2kTHB9UFEfYaG3X+v2I1nuJgVQv61mGGQ/wuVKQNI5shpIyOl/lv9I8Wj1HU9g6HEeSn3CfrHoJFuAcu5E+krTIDP3l5dX18dokD9nvL5Zz8jZ+RYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8HU8oCG3V1dp+wvRkN5Wi/vGoVHZAEirTX7qgzp08c=;
 b=h0uDPm0RDLhej+4TY24aTTpU7VkZxqQ17TDGTcuEIHptzZt4dC3d/S7YzfKwQZfTjYSf+DF8icLHVfiffGbDdJr3JOiMbMQreU9bGIPveJl3ZdEaPDfFWMDUjJbDOUk31ZAd0tEo0BPogioe7VYjGejYFN9fV4wvP6FtZ3lBNT3MgdnyiSMzX16WH3/rQvTuwU0/T/TtOqKzcoNnOFDPwZVXmFyMbVLzIqvxcopxh3Y9dOPc+eyDJA2cGXGNwPevopeYjkaPqTtk4fKcUwaOJzhpgrVjqpc8AwhI0nWi7EoDayH/lmjvvuDsW+79n8qHlW+S885AhCT3zllwxUZFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 11:06:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 11:06:10 +0000
Date: Thu, 8 Jan 2026 11:06:05 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH dpdk v2] telemetry: fix adding dicts in container arrays
Message-ID: <aV-Pne_XsGUwV0Oq@bricha3-mobl1.ger.corp.intel.com>
References: <20260107215129.1329960-2-rjarry@redhat.com>
 <20260108105036.1341037-2-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260108105036.1341037-2-rjarry@redhat.com>
X-ClientProxiedBy: DU2P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: accc6fd9-0690-4f28-5c21-08de4ea5ee36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G66V0pG5DMZ4LFp4CmLGzATKAycjfoabTr+POfli3UK14M2YY8JLo2YWpmuI?=
 =?us-ascii?Q?NPpC8Gkwt+fL2vfmDdmyWitm69CX2469KBhuxmywamkCtitgcsm6DwEN9lbY?=
 =?us-ascii?Q?oNrGQ3apADToWPNp+uHmOl3PPimdqRa913zFRQnRaG756MNhQjDhdpxBYEsn?=
 =?us-ascii?Q?OzBLWtDzAQfHwWjC+1Oe5hpIwi9lxX/9euqYOM6iINpE7RDWA+saa5o49Xxg?=
 =?us-ascii?Q?ifqxxrmXkD21eY/+IWNY1V/xppNjZev9lTf4QxEBW3ghf5VQ8LSsKA16i4cH?=
 =?us-ascii?Q?2TxsTMkcvaZ3be/rgFgwZnVHyog6EI4MdnN8EHm+IPTrc6tPoCRzg+KRsBzU?=
 =?us-ascii?Q?1QWMRdfi8sJCGZDmT5qv7xS6iDo2zvmaSyvJBDRs+aPQ2+QeAECnBM9A3aUk?=
 =?us-ascii?Q?CYzg/GVEtsRuMqYlopWYOMaJY9qU3YOzO6cxzwlcypsZcdTFlh+f9MLOKq6K?=
 =?us-ascii?Q?pgW9Efzo7XsjItJO4RRH5etpz2aKDYke9QUi3IByYVLGPLbmJneisQtyrSL8?=
 =?us-ascii?Q?GFl4eBKxcjLA6EyvG7FRygT0M02EXNMQe62Gwk8FvmOCL4y9hAI298zq4Rh0?=
 =?us-ascii?Q?GWiZcXwpqY9MPtAkd7IQwWVAz6r1g66et9VrrrfTZholaigQJyWcMfV5LAS4?=
 =?us-ascii?Q?WBJ2aNPqEvAOs/qfDVVCWuhO1eH9FpDANbfojm0HRsv9YoW1MJq/nXNXtgXL?=
 =?us-ascii?Q?dtcrW/CY2la87pXfhxF3lEzWoWzkcDAx5LHmQwrjNl9rKjLirxa+H4Gp6G49?=
 =?us-ascii?Q?XECc1aRqFk+z8KHw7kt0nFkLzEg9otr7CRjz8qLELwsDpawomDtZh4ANikol?=
 =?us-ascii?Q?IZuh0T1BifunBWVuIFJD2S0eZhA8hMwKkNI3TCXK4pRj7YHTKf6IoQHKGOAY?=
 =?us-ascii?Q?yPwo607swYPfHz4nZnnZhSvQmirBNdodmLg+2tmRuDHAmFc6tZiW7VGF0ZqF?=
 =?us-ascii?Q?GScgl57eqH5QMm4XLNBmnaBDKkILx7siB97m92P4kbACYPNABucXgAIpa9Jl?=
 =?us-ascii?Q?MYrSwPocnfv0LBFBE8Efznd/uVzYBivLiVDiHhf/OMOH0smeNp0b8Han/Ct5?=
 =?us-ascii?Q?vZAQqpZZbvdM3tZ2w4u1s+s6S1o5hvbwZwXZ2BMAvhv45GIFY7r64XPEXrO6?=
 =?us-ascii?Q?ImNS4UygKh6ndLJZrEFJI3UjgxEzzlOtyTVVvRxjW7xwxRSNJIyXtkMwWu/G?=
 =?us-ascii?Q?AhcIchvqPr8hqj+VPxHyss9BM+43d3a9pTtguwRvzWwLocQ43I7a1GO2iLSi?=
 =?us-ascii?Q?EixbzsAJ6PLE8xzvU8ebAIeFz7T6nVqYjY7ePEYyGLm11Kve0IYITMUUrMIg?=
 =?us-ascii?Q?LeQmYqlLNvz/cqVl3xofBgfXiEShzs+xaz72MKiXBCZaF7Z7zpLE2d87kptE?=
 =?us-ascii?Q?KDgwEGnTO71MG7M/vASwQPY6vnB/9eufZLQxefcIaXY9oTYdH/a3a9tVbSEb?=
 =?us-ascii?Q?PSDF5z3p08Qwcjaz6K1z4zoMxBy9wUPe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GZZJV1HbHa+tKfvKBQJKsqsx2gwFygUc58NwJ/UmHNjGsAvmuQ6iw5eqzHSC?=
 =?us-ascii?Q?eaHs1oTYULr3rE/JRNgVxM/Oxb/kdEWQM2IM7f/cA+Ex2DKdIjGz2jppLS5z?=
 =?us-ascii?Q?vY9k103kUoBCvzlUF9LQXR5VRDf3iDavvxTcSJuCP4ct/LO/lyUKN2c/anBH?=
 =?us-ascii?Q?WDy1SPyZO6yKKCeMQYqlGwzer6IO3xplxLDBtpeGXXHLmYHaO5yRr1f8DRYa?=
 =?us-ascii?Q?UOiQEK3Q9I7cLG64no5vWrViDU4VxXPcBJWDoLb+LhIT74hXF30NrzB1iMsx?=
 =?us-ascii?Q?uCjkuRKJpn8B4Zsimcei1v4thWX8kD6Nh277b45/AbXtRmNA7BkOJfdRdmRF?=
 =?us-ascii?Q?kYzGOybvQ98M41bC7qfMRQ/iXoCeicPq9qrvIAn3W2tE4n8qjNhNfuQdjQKV?=
 =?us-ascii?Q?+jlU+Hs2zumX5C9EPuYQh+gzjLo5Dwb0irMYCTN348wAv0ifMEaC+P8puBkZ?=
 =?us-ascii?Q?jNWXRD9pBUSd6hhWi7LWpPKquvGe1sAX12sznYU3iAzcNk/KqgSGvUEZfMaC?=
 =?us-ascii?Q?wFESuNUPAoJKye/ksH4e3z+IfhZ6xIrtXTJbGBlge453Yth8fZQUCThQztPD?=
 =?us-ascii?Q?LVy9ECtA13rwQvA1gEbvtDi6f8eQxWZXD8FR3BvploRv0RA5fP2vRXmR1+0/?=
 =?us-ascii?Q?uI4I4QETiVlZOpsYYj5e2jZhqg7OKHr637eGg9rffV6GjbUhVQAU10Dt4UwI?=
 =?us-ascii?Q?lA1SXtR1ZdcBWoS3R1GcLF96qs4fQj3gh6anERMt/4mkcVmnMrWroZ0zQzS2?=
 =?us-ascii?Q?WqvxthFVAnJxH/XPvDZZ3uWWyr22sCDEgstWm6cXTkYumNN6Iqs6QauYRy/G?=
 =?us-ascii?Q?MxAACzttsINygM8OOQ6kmXOUpjFfLPZB+8LAQYaV5VrviMmiTx3984ZNioqa?=
 =?us-ascii?Q?I9w4R2mWppawtiLvvWq8MtEYz2qxkyE1UZ23FUpzr4lXzhLP8aMEgQ+9TCHr?=
 =?us-ascii?Q?Bzx5AVBPD1/S7F5qUJWyRFrKqawWfAYNZdmbhNGcfhXGnIpyfENZizbWSy+p?=
 =?us-ascii?Q?rdPd2Iow11TA83nXsIoaHVgW/GruGa4a7Xn4S3SmgaNsCEJaS1T0v2F8mFMb?=
 =?us-ascii?Q?tP5urYXt4r1gHG46JyauYQg6W+frpdjvC+HvdNPs1682Khja9sgCRfacpYh9?=
 =?us-ascii?Q?nfS3mM9USAU3xrs1hJS07YIJzz91lXCeIpzHsKer4uvUdMpMYMnWwuOjjNQ5?=
 =?us-ascii?Q?JxxVS/liz08nkUO7GOD6sf8linwHcFGnwORagPGtJ+BDvjGjVIc+fgSd9GeU?=
 =?us-ascii?Q?gKnJiYY6uqn+vm5WusZk7X6P0MWCm8XhsfJMsyV32flIvNSCYMxA5I8zwzpZ?=
 =?us-ascii?Q?lW1t8RmyNjDw7+OSCM7sQN5ZypUw3W8NP0RqKvPmb6eel5CBuLdXkVFqW4hJ?=
 =?us-ascii?Q?3eKhKg0R56yg4+lPCwcSw8Tsyuwa1fsudV23BqU9GkUY9myV0KybMpcHMaae?=
 =?us-ascii?Q?+BRkENeXZWfWZHPmZOYVqNBKBBmKIzS6lEJBHvBRnTasABlMO0SdZjOfeNTw?=
 =?us-ascii?Q?bqzt3IZmIXvXzZgdWrSXbMDmuBYLdJKs1kZKf6zeIzb1x8rdrulYWo6it6Kw?=
 =?us-ascii?Q?VkGOBDcm6d5TqhE396wpEJ4S84R1SzFqpOebQSt0R4ExGHI+3QD8MDL9Q+Hc?=
 =?us-ascii?Q?nKz1MdJ3Ay3Qa6RwcvqAb6fb2/V8aOIGhslWmiaqwX7ogy6VqXhExtTT+uOW?=
 =?us-ascii?Q?eHiWPNI9EQN5MKygQuvSZ3uIDa8JuErnltbcJUuP6TTmiGu1EJNZ/FOJYoAH?=
 =?us-ascii?Q?NpB9Mztgvi2BVtU0i5BdgXLW5G5HHf4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: accc6fd9-0690-4f28-5c21-08de4ea5ee36
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:06:10.7721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDLVGz6DQzFwGsTFuOBM9JqIOY9lzW6AMrdPnNZVk4Xw4H1GWxq2iyUK6Kx5ozf5hxr2jLHnzCrzYi75gd0WG89CxvDOVTRGkRSo3JXIcJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
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

On Thu, Jan 08, 2026 at 11:50:37AM +0100, Robin Jarry wrote:
> Currently, adding TEL_DICT containers in TEL_ARRAY_CONTAINER containers
> is not supported by rte_tel_data_add_array_container. It wrongfully
> returns -EINVAL where it should allow it.
> 
> This is supported by the JSON formatter.
> 
> Allow the same value types than rte_tel_data_add_dict_container().
> 
> Add test case to verify it works as expected.
> 
> Fixes: c933bb5177ca ("telemetry: support array values in data object")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
> 
> Notes:
>     v2: added test case
> 
>  app/test/test_telemetry_data.c | 21 +++++++++++++++++++++
>  lib/telemetry/telemetry_data.c |  6 +++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

