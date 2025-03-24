Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4946C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 13:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA26C40A7F;
	Mon, 24 Mar 2025 14:16:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id B2C5540A71
 for <dev@dpdk.org>; Mon, 24 Mar 2025 14:16:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742822202; x=1774358202;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Fm1E2wHOUR+Q4s4uRQKAJbar+R+Zq/Txq9J5D62bJSc=;
 b=WRfmy5fUHw82w27E71sBzMEtZPuYV7ovm7CZign1fhR1E5fhBxn+o5De
 rrfKOliBXpGEVQkInirCEqpangE6p1KyJB/DM1tcKYIX8sGaKJxAtcQ83
 2j+R9CCN9vF3ICVUQf8tdq9DemZ2s778YMNvU7exMvdE1hLnVbwMhJ1gm
 2j4sGiuAsHR6KAkvOELJnoNfwEWI5HgVjeDQqMKnolQrb6bPZ/QP2c3s5
 j+e3qPPL3oSS+VPngpOyOx1RBLxmxXODHBZ9IUhE3YO20azcz9PRPuhHZ
 72UzXiywpg47R745+PDVjMZfixEBTtegfBfJu/dBVRLnFvAQvCWmLUQFN Q==;
X-CSE-ConnectionGUID: GMHJYmrhRvKllaBW+AVTgQ==
X-CSE-MsgGUID: +Gii6v8nQ2u9L8KOq+abnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43262507"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="43262507"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 06:16:41 -0700
X-CSE-ConnectionGUID: ot8+gvpeSbyjFuQjsSU0wQ==
X-CSE-MsgGUID: G9MxHWV+Q/SvYAf5xSO6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="124206472"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 06:16:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 06:16:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 06:16:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 06:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umltuKXAtGuryx1wgG6j4Tgyci1oHawgY+Zhxu3gJuacgTLjwZqNMvk47AVJUn6S356Bq1GPF/ZWpY07pNZif9kPx4SKowk08g9uTyIyXhzwLzbY1ozk59ORCgcinLkWVl+C5nMREviImnZkRbfowZh1CyVeF0pJiwYOhiILIFLXXhK2IM51PwwFNyl2gOXgzlUa1X0q4jgkS/TRymi0sgbenoFIQDIROzXGOqbUowCGIWV9+HqH3UAAq/tsgvvw/+9Tzr8cQoGEdwSr3ppgNa2wSav6HU4OY+1z4eDofT/93EWsni3vO2EG2NKhiqE+NdE1ysFNi1seG2Mz6BT2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4asSbZRt31KcJoMIBB2UFPcUL10EOnJ29LVAJKXRQ8=;
 b=ozDU1a1zwQOb9fvPUx/+siA9kO9t0WPq1Zjx5sShdzwKZOhGt7wGHzp027M9xI8LUs84i7y2U6VKG/oYkRIwOTZhV3EK4yLyGDKFQvwy8CYYU8kj1m04AUn5fZl+wdlao+UHXM0iSbw9zB2SLcYdkBcSrXpCupOUU/ercf2YO0hm/mkEMNCZdIh5agq7ZJmFfZJ/fL6xVtzQfhrlOTvfkqqti0oQATtbqa80NwEIWpFqgoB+I1HcHbXkwSiT+HYq81ycvAwLHPU0mfNJNhmT5Ar+D29EEtfqrdop7Lkl2jfOFQarTSfIZMy2rdR9KnxfsDjfKNBqKsYqb3tJh0aEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7348.namprd11.prod.outlook.com (2603:10b6:610:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:16:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 13:16:04 +0000
Date: Mon, 24 Mar 2025 13:16:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v3 2/4] net/intel: align Tx queue struct field names
Message-ID: <Z-FbENt1K31FcW3-@bricha3-mobl1.ger.corp.intel.com>
References: <20250324124001.1282624-2-shaiq.wani@intel.com>
 <20250324124908.1282692-1-shaiq.wani@intel.com>
 <20250324124908.1282692-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250324124908.1282692-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c55fdb-14ac-4689-d50a-08dd6ad607ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FaJHyatlDPaHL/Rr1wtt2+v23zlDVa8p5FTkj/StR8GH+w/k+EQ6GJY6KLf3?=
 =?us-ascii?Q?fZTUtyF1MHi0mX20Utg5QGHcWNMa1sm559CdBgHwwILXk7EbY0FJrxZ4baCE?=
 =?us-ascii?Q?rqVZ30FjWkX+LAgITBCiCMGVwYL03nt6xDY59mOC5rDmokmaN/dw9QVQD6kq?=
 =?us-ascii?Q?Mulop3T8AD/kp/rtY3qp4PdBUxm+p6zvqhpA1JWeeOUMoHBwXZ24h1wi7lSK?=
 =?us-ascii?Q?8/PgKi2zOaqcwXpP4y8UjRx1KWb61Gm8JKqhwEaYIirir5zLp4v7GE2EkSg+?=
 =?us-ascii?Q?4wReUr5wFtc+BQc/PkcnG+Eg2h2uPR8zlEk47eskfXXkkbdzF6wxPibT9koC?=
 =?us-ascii?Q?lB+IXdieLVwN0dd/YhH2231zs4IGd3Wy6OFtxq/W/Y9WtQu70fvvXVbYJ3Ee?=
 =?us-ascii?Q?oPFH9MksY4wNLc6dTPnWXeEQff9srNRd5Yj++4FugFBeb1Ys/F+7GvN4K/dl?=
 =?us-ascii?Q?AiVNkdXUQtOHjbU6s+sK9pfjv/7ve/2MidSrWKvr2c89JI01pN74psXoHATs?=
 =?us-ascii?Q?I/pXdEYndwzRiqJipJDjiT8t17OE2e4QEyRVDFRSKbgBA4B9VUEx6WAsZu61?=
 =?us-ascii?Q?A6SDEkrUxmGX+5wctV8k79VBNj8uy5kt7mp2CdJCWDW/aNjAY+Ntg2Ctf8dh?=
 =?us-ascii?Q?LzMp+f9RAhUQ7BCPbyyY92c/7TgqpfnY5HW65m78t+bnHGb7kb0ftpBHfHxF?=
 =?us-ascii?Q?KOMlR4kwupRm/Y4R5pD5APLfDLyH0XaoaJ7BiP/m3W05KyCoCzaAKRNht0Yp?=
 =?us-ascii?Q?Ej7HKTgzGPcsg6c+heQGrDTw2X0SupWfzh5ImG5xwIDx85RC4gWos7Z/WQAK?=
 =?us-ascii?Q?uk5m4vI3MsKKHNrRuruigPdx7HiLmMbtiBToW4hqQKp0afD+gQbbkekTYNCQ?=
 =?us-ascii?Q?G2noeFlZt6FloxzYIwUFeBGkNMTDq/fTksaPfvy4a/PF7sIDLTbgXVq5bV+4?=
 =?us-ascii?Q?yN9MfhRwO/WytJ8bJCFs83tCt1hQYUBQ7AvXOiN5eAaCFG2VRuSQq7pDBUIS?=
 =?us-ascii?Q?LlJXHxK5i7ijP4pNgODUR9D6QHIVDnt5lA1W0I9wWRrKptqeQr83DMAlIrkY?=
 =?us-ascii?Q?lZhNGd5HRJGe/aoQ6P/QeyQ9PNB/cM1mGFf5lAh9VqhxdN0zxjmY1XJNP+cP?=
 =?us-ascii?Q?Zn6bV3uhnr+KEThE6hdAfMzaTk4HewE4VHmnr/OXt0Kx32OcOgwa1AHd0Axs?=
 =?us-ascii?Q?bZNRARowqIUvyltxLlcrLJEfdpn8BLFymbuO5IQhtHIugpxLtAx6kODFLNQ8?=
 =?us-ascii?Q?bKe9ZrHCmDi4fIvY0GtMRZK9RWxBMzZONPJOgWZyI7eJRILNeBjYjkpr6PJv?=
 =?us-ascii?Q?hGg4G7Rj5CdvxrBKobodQCep0RLbysTEhLZZk1GyjI+Wrt2iw6GbFnxGiSQm?=
 =?us-ascii?Q?Pc9n0weCEz4FAujhor0K+D/ctO8D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y5gtQDoetBGeUgok2yFq8El2K3JYMCAMYb/eEuyKlxn8hlQXVHZls3FglIMR?=
 =?us-ascii?Q?zUVcL+tUnlYTQIg2+A3vGLt8s+JHD8kS6Pdz1uxy0bOoMHzYWaRHT3ENVokp?=
 =?us-ascii?Q?rseXUWlW2eShjOs6/qUt3H1S4nrJBgyyVIo/v3KeZ6xnMj0xKJqPmOtwKoTq?=
 =?us-ascii?Q?WIt5p/Qk26K5mrBycKLQiD3zu0PsU6X+oC7FlBy6QLJyp47/Udlbl97M35OZ?=
 =?us-ascii?Q?cSdmsUdgk/7Xb1arn44Jv0llP8ipvALLjDNtS5spcmMFm8B/fCH6KdCGRwmE?=
 =?us-ascii?Q?EWdkt2PqE7xLbrr6RYVzSj9bK6sDU5Jis2NMLvLYYsu6scm1V1OAyViVjH3M?=
 =?us-ascii?Q?WjSp/l60GT43coUis67M+XteM7PN772sWETFfy0GcpxLSBTIBvrVQukmHY50?=
 =?us-ascii?Q?h/054rGy/p7HmYO/QbnI7LH0XtgApSoSST8f9538qSYTLXlXsN0JhrPWj4Uf?=
 =?us-ascii?Q?EWu4bX332k6vF/xP8clbfGVM6UU8cPUZoufADs7WmuoRHhKBozf5oL9C8qLI?=
 =?us-ascii?Q?EM+7W4/q7l/4paOt91hmkC28t2z2HWKyVchzrkb9SWkkkVbvKqHJYMzJ6Qhf?=
 =?us-ascii?Q?Ir3xx+DZ4ZqLmdHY2jYsj2vxpcI01rIuBGeO2YcLE0O2omtKgeGXqqpnLSVZ?=
 =?us-ascii?Q?aVDJAznY6RZLYUhS5rpQhc3vHiSr9wHeFd3rq4Ug1rJ0OQ9Da7OnqAw3QA1c?=
 =?us-ascii?Q?2ArSyI4Q8t/3nZJQzHS/zzBPyA1BXAbHGxKyjBGF/9PtUd3YidcM0GonlZdL?=
 =?us-ascii?Q?gJ2bIxX9UJLVLu0ePyhTS4hHN/wLKEITOLAijNQD4c+gJ2pYsCoojB7Wb+Qz?=
 =?us-ascii?Q?skqC3kXmZ1r5Z8n/wsjkutm0mkkt6rTZb2u7ZsVz47VnIrr5GePtjiBel9N7?=
 =?us-ascii?Q?gvGqyqZMaMnGYYcQhjGgJ/tXHeOnWK+3f5r8kqnD8kpciq2Ptf+GZ1NIeb3a?=
 =?us-ascii?Q?trZWAZESKV55NoHkrVAPwW9Puy9256ULLhSYqFesOjxDnYOZZ2/gX7q5QVow?=
 =?us-ascii?Q?WioakIsTXMMGEy1RlxnCpNGT4mLGAwvSXhIQQCNgRznMXSJf9hHRNY2aZnA3?=
 =?us-ascii?Q?rJJ/7rnhcVxJU6PpL6VsjKhaDQZOhFLQGzllqFkg7ouxjDYg4MDPIfGDPyHJ?=
 =?us-ascii?Q?9jfZmlDgHWckPzd8QnfSE5IpxQdw8OQmIoge58OlU25vqxi3z+ACoPbooQ+t?=
 =?us-ascii?Q?ha8GiBggLJ8uJX5QizRlwGledQs5DpoQ/IidGZrhyIFGcu8hR8U6QomJ7fX9?=
 =?us-ascii?Q?b/oBGs63XzeY39LoZQnTjEx50xJnHzpMZGPX9N0wl7GnkdkBeu1WMpfTYUaH?=
 =?us-ascii?Q?AuTOMl7tRo66TvZUMKVd+BCkBmyyDtd4C4orrZOiTqzQxWoSvhdXF8fHkwN1?=
 =?us-ascii?Q?RWgm4TQxkPDxFjNhaN/JMca69XSb1GWoHcctdbfaoX01pmy1wBrOlhyiTWMn?=
 =?us-ascii?Q?clD1WpiJFcCYEBXduyx2m+FFq8mAup5w07R7RAwfyyPN1q8g7JzNPaM9nsYb?=
 =?us-ascii?Q?eqEAaHv5oITmuc5qlG8NTB4J4jx3v/j7SNDE11WTk5vMdE4sicj7xIuylBV/?=
 =?us-ascii?Q?71JUp8PVxaF+TgP9Wr2E2eER5gUkcIGBeeEFpdW98xQwQnuNmH17XhJtUqqO?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c55fdb-14ac-4689-d50a-08dd6ad607ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:16:04.4608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TAuw3NMj3U3pQYcCBDsu2UDzVJnhJlWK2aCgmf9nLR80DAY89RSGjkaX6qDYiKnn8hctEpa4JiVYdEmhH5FLGfOG+GEvWSyW/LaBXh0pNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7348
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

On Mon, Mar 24, 2025 at 06:19:06PM +0530, Shaiq Wani wrote:
> Align the Tx queue struct field names in idpf and
> cpfl driver with the common Tx queue struct.
> 
Do the field names not need to aligned before you merge in the structures?
Remember, each patch should build when applied individually in sequence.

/Bruce
