Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F3C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EFAC402DE;
	Thu,  5 Jun 2025 12:03:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2B47A4026C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 12:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749117823; x=1780653823;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Mv/sTkIiuDG92VSOv1QVw1Pi8YTYdmz0nGKr2ur3Psc=;
 b=j73Fd1chTAscFtrkXzgEMGYslBgyTNTyAGBQs/waVXUb2tu5ceUby/A4
 O5j40e8c+KHiEuCV3R9FRq1sOp3pc8D3dvUpL3FMya8V9+s45Ioo/Kpbd
 fPMdxLp+cBJD+d9zOlOaQbdKCo8QRX5lQ3fg9DnQi0iXoFDDVfS7vHr18
 YwTbPJSQYe5WNitAMqYOBoDzKcdPNYA0miCBmZi8CAF4kW07tm13ZcAsz
 S2WXGW9b7Ib34WZuX0VR9PeT+bf6HFUJdU89qbrB1FUNbLxsY2R2AeNsp
 7ZI7vdSIjnlEIbaH5ZPdViupxTSsRFvJcUsxr++F5cNofmDN5BF20hGND g==;
X-CSE-ConnectionGUID: 6EJx55mVSA6EIPHHTr/Eng==
X-CSE-MsgGUID: RlwXd3fTR/m1nXK+o4XCyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="53858253"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="53858253"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:03:39 -0700
X-CSE-ConnectionGUID: 81fx+EqiRsahK8R56VS5YA==
X-CSE-MsgGUID: FRT4qPTOTV2Opn2yC5/vLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="145431407"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:03:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 03:03:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 03:03:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 03:03:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5WcnjBhYfPOAjqZIKDqeHnJoD/2ixCkQr7O2Jh165SSs+2P7KquFhV+CrSK3he7gQHr9rySeug1ae6X36yrQa09+Dmkw23eQo9AivmzJbhBe+ESUj2UlXI7SJoNWZ4ZGIuOOQ5OyASoJhCKUcbpbRGFfVtNDMrybdix8jrzhslwDCuKiFKVbIVRVtdehwGLIrA5nYi+NLtlm0yJtxfSRRL5y3VDCQmwE3reMe0ItPiSZU7sJC9cWRVXc9qFVxFssP9QyTvCkAQDO4xlqvw8kq+lG0fgHyy6RY70YOUn3RIi6DwdYtIHKZkSEPFpe2rg2GvBJSftJoQuszbJWBFbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nolG7yViVIQ8MxLlLuzLdbRhsAsxfapX4EeVeoFbMUE=;
 b=zGduNu6MW2w2u3D6VFLegh0Eist9zK54BF6b26hPIw16xgk9pcNfbowC8xJcwLmbJejUwLgvQzBWJ65WnwfGttMla8um/fr+DWPCcI8qsZNdrnoAlRpeKI0xnEoRmMSh4FKawcUH3YCIuzujeVA6DA8QkDou9pbb8C29YpOhC5SgAmO3sCfGXpPxzJvX8wSEJRqOLjBDcxFCJijkqYY9pOp0XDNg43Pdx3+SuC/luR4hVdgi2WHqDKtV4DcuDK9MEMvIvL+cdTU75TWTC8DUHRksX8Y8LQaUKw+3z7A4o7A0ZMuRrhnEwi5c8amhWaMD2/13qQlts+dW2c/Z1qUkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 10:03:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Thu, 5 Jun 2025
 10:03:21 +0000
Date: Thu, 5 Jun 2025 11:03:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <nd@arm.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH v5 3/4] ethdev: introduce the cache stashing hints API
Message-ID: <aEFrYvpyc_-Ji5U1@bricha3-mobl1.ger.corp.intel.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-4-wathsala.vithanage@arm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250602223805.816816-4-wathsala.vithanage@arm.com>
X-ClientProxiedBy: DUZPR01CA0287.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 85158cdb-49ab-49a7-d072-08dda41833c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?F8mLYpVdArvdv55C8Aco6zbepUeaZq7e67DVPhIdqllAdh2DsPUyXBT2ST?=
 =?iso-8859-1?Q?8prqzvpnT34vzwTpx2pEPmnEUFgfV+mPy+NkgiFtz9XEvlf8sClt2IARUo?=
 =?iso-8859-1?Q?iQJc+3V6rOovJEJ7b2l2nYvVn+6AKMnelxXfCF67RNYHeDhdHmJbB93vaU?=
 =?iso-8859-1?Q?RwF9NYRqZ8+K5NGbB5jrcNZ9HiPEAlPBO7ysd9RcxLnHjxvmNNn9WnuGbT?=
 =?iso-8859-1?Q?FLqcvsG2oV73YTcc+feOtmXfq2lsJFbrA3bU2zONLd+3D3J7xXTsEB4V0V?=
 =?iso-8859-1?Q?lEI+wqygbrVxeNber5iHsOYuYy635IhNUqEVZ5I9c2WqVdiGhbLdKy8ack?=
 =?iso-8859-1?Q?5oEJEMfsnO80nggMkGd0K2txnJCPUyWesZVSIkWvsfziFu/APu4dNRBAbX?=
 =?iso-8859-1?Q?D2BscLHes0e807KamtZwD5dP+Z44NOzfg3SPZVphxHEAzTUQm1Akg83G9w?=
 =?iso-8859-1?Q?e5wALUhcIXS2F2G9Le+yRZPTKbyXPfs42Ff6V0EW6yMxfgee5GWgXMmIXO?=
 =?iso-8859-1?Q?bubQ4fmRfjSFQaCF2mt53pLQPUwEDWYG+26I1ZJRvnDnpdsymNlkjedfFR?=
 =?iso-8859-1?Q?NCK5ELP5MDUyX8vgiZHmqKCRIMACFNQ4OzjuUQOOYQzs5rXNAhFZkaMdUT?=
 =?iso-8859-1?Q?9qWELj8a6U1MOZ2WjwjbCJbnxdcvgoII2YGOzEuNCwoA0t/EyCCfz7SoAV?=
 =?iso-8859-1?Q?RCW6RKSVpfvgKzQv6+TWg0nGdWDOQTZirGEgxWR7Zy+s4lzNjOUySS4mv2?=
 =?iso-8859-1?Q?NWjNAECnRvtQb4Y8oI8+vJSaPBU0o59+BTYW5O69LpWSLdDWQW7sAuJfKB?=
 =?iso-8859-1?Q?8tb6TACcYQ5OD9yLdHfX2kdN8A9hQNi/rF/fniZJBSvAOj27LfqgVkCgzV?=
 =?iso-8859-1?Q?xcghWBUjL11E67evE3zjvC9udCzJyQI1wGotcbq5zqs5vOMNml+EfwBGI/?=
 =?iso-8859-1?Q?+f+lG0sWA3RFj4/GRkDgnYaQ4Ju28WRHmgbPjK6i4w1EUnlJvMUwlGekIM?=
 =?iso-8859-1?Q?6a8TSl7x2c8Ljo4dBYuZ58bhFZd+7XTHC0abFhq5EOIZZCEjD8+QjqFxg0?=
 =?iso-8859-1?Q?GX6MDj1rgSmBjzzCGI5KWhPjCGZvkUYb9LRlIgJfYVIdA+hNm3NdXV1URP?=
 =?iso-8859-1?Q?+1j1YBK4blkNK57O086+Qzv6ythuN+W20eWDi7N39zS3tJ/ObnVPjI67ck?=
 =?iso-8859-1?Q?iDDF1SsgQzrLql+bbeFa7jdFKNW7Fh2A/N/wFyyKxxZ05H6DFeZxWnhSkc?=
 =?iso-8859-1?Q?4zgbSV+LDCaNmDlt2W6KV634v6EduYQZpTQJOjcbLg9sBRDzSQeNLDM+Vk?=
 =?iso-8859-1?Q?/qrcy2xVNq5qxDTbGrdKywNcekmET0CCNRvNY77yMvjus4Hw8rDuvSPrTV?=
 =?iso-8859-1?Q?sPEuA2nYCQXQhme9eT4+MU5ywJ6Zwp5cheomsfMsAeTyk05ni5PsTn0NF1?=
 =?iso-8859-1?Q?hiUnF5/a48tgp98zG3aGP+jgtLysYa9cMFn8CnhdQIVa+v644Qz+x0jXhg?=
 =?iso-8859-1?Q?g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3evgja6CaEbs/6hBT6rYMX76gBkE9VLheViCb1ZIh6G1b1tsfkpSdwR1sz?=
 =?iso-8859-1?Q?zH/qAYBFmLfTArH/33Dr81MuwUQit/pxtLtnsPkoDUxI03HMcLsfuKs0IY?=
 =?iso-8859-1?Q?TdSuC3jI2Q330tp8d9kgOiS5yluEubKeMPG5SUsD6ezV7/mKpyNXuCEYFV?=
 =?iso-8859-1?Q?IvLkN2ABDx8ETEv+uG2Mj6f4FxX03rkCcYUHuaNqannKuHLXIzDHh0W+qj?=
 =?iso-8859-1?Q?277tuStHasB4NlKJ0wOxLYmJ+EpAG9qhx/eYtaClKbzrI268kfDdwzLiPV?=
 =?iso-8859-1?Q?5QzCB7PAIVi6ARINXQ5nE9O/jjFE1B4NgRcLtf5CcuKxvwUtizRPVoKpiy?=
 =?iso-8859-1?Q?nL1q/YVU+t2G6F1ecAcaiXRyIwoM3oZuu7RQ5FaAUVe4/HiGeC5/3g+lbi?=
 =?iso-8859-1?Q?+LukteTJH46F0aWzBluV57WwQ730903ybyXOn1iSFl30oZ5UI8y5RhvMfM?=
 =?iso-8859-1?Q?h3NFGNh8dAYZxvZGdr9Un2IWL+G6Gf1ODIecVxZJc/gElG4Bp2Zh4+wNwR?=
 =?iso-8859-1?Q?PHT6U6D0b7gvS39de5bIcvJpI9+z8HylNbmHTbGFeP4AzcS5oM8zLyMjOW?=
 =?iso-8859-1?Q?H4Ggs5qpmdit3txpKr6XPF+pCu8dp2uYzzugDYAO5jqbuR4boJQQFcE7Zr?=
 =?iso-8859-1?Q?trQ35xtfQ0+QJ8AObWrJmBwZHFrBxEx4cP2LHi8WTtTY/jBIhWoz18/WNr?=
 =?iso-8859-1?Q?iyQEwPF7Y0iX53Yoj6SvV53mdXPSrMCHMQGXiWayjImQmy8WcjK4S2gjOC?=
 =?iso-8859-1?Q?8pZIM1dy5re9WmrfQoLWJiScmPRJiHm2nCT+AIA/ZNNTfySxIdRrdFBlJc?=
 =?iso-8859-1?Q?tV+dh9MrYALIWK1JfpIk/B3l/nbB+Qb1clqMF9mKjXlJ8kx380Giixaaz+?=
 =?iso-8859-1?Q?iB7s8G+ya9xHIhdOG5ObDrK5p01hRxOrk5j56E++CpSPIms5uL+B0HSMRd?=
 =?iso-8859-1?Q?oYw9nTVAgdYNIXbnzCeNQLWD4hVMvwbV5khkJrwz7cBLPqV6ys4tpcdG+3?=
 =?iso-8859-1?Q?ASbuRK/ZIZP66IeXoxoMk/Rya9vm40eSoYbVwDafIU8lrHr7CWCCGLyGgJ?=
 =?iso-8859-1?Q?0VYMEYZCg5mZNxlM2qokJT6iohD2L3yPa2KMPqxHCAF07TNNIcJ/TQ71oR?=
 =?iso-8859-1?Q?udvCIaGfCphamT2zQ5s9S+Z7L7CgvVzhsja79IqSQd/I8gESbpuOwP17V8?=
 =?iso-8859-1?Q?T/J4VookUy33LpsoviGgQAKCvYdKt/EJ+oblUIZGzxGRCJ49jeJA2dePfS?=
 =?iso-8859-1?Q?1TXOXLgoom3/JiVRxlM6Nd8Tnz4KoK1wYR8poj0DB04ct9Qwim6DUhT0h0?=
 =?iso-8859-1?Q?yel28L5jAjgMmJPrhTXkWYCf9JT6Pf5jSuCGbz++/ecZkkMGBUhmMwU5tJ?=
 =?iso-8859-1?Q?54MJnz/EKhwMUpZqz8VneGTwuXvviiqw9xieQcsls0fagupGPmEwlDlyl/?=
 =?iso-8859-1?Q?amTHiw9xbIaPIxySIgJn42l5qxg5H6UXTOzzYs1WdDbdBAPyGeUei5CqcX?=
 =?iso-8859-1?Q?0iJSpZk3Cc72kdJLg9UiirXeURKdvaiNnmZu6QoEFNco1yVegM3O6e+AaJ?=
 =?iso-8859-1?Q?x8GEtfkLyipIeOZFOwzD5EU97tLEYP0lBSjW3rQ5z7XBqhsyE1hTQW7cbG?=
 =?iso-8859-1?Q?GdosMkau1aO32pr7FDSjGMg5lkR6eFsWwVGG/NKVvF2NvMCj6KvRyifw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85158cdb-49ab-49a7-d072-08dda41833c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 10:03:21.3592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2lgMVuig4XWDSJ4PmG930MTiI5u+/UtroKtoRD9yiasHNrXqaWS4tz9qe1R1sHS44jx4I+PmRFI1Yqw4E3JX3CQ6ZSox4SlS/myS8dq0ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
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

On Mon, Jun 02, 2025 at 10:38:03PM +0000, Wathsala Vithanage wrote:
> Extend the ethdev library to enable the stashing of different data
> objects, such as the ones listed below, into CPU caches directly
> from the NIC.
> 
> - Rx/Tx queue descriptors
> - Rx packets
> - Packet headers
> - packet payloads
> - Data of a packet at an offset from the start of the packet
> 
> The APIs are designed in a hardware/vendor agnostic manner such that
> supporting PMDs could use any capabilities available in the underlying
> hardware for fine-grained stashing of data objects into a CPU cache
> 
> The API provides an interface to query the availability of stashing
> capabilities, i.e., platform/NIC support, stashable object types, etc,
> via the rte_eth_dev_stashing_capabilities_get interface.
> 
> The function pair rte_eth_dev_stashing_rx_config_set and
> rte_eth_dev_stashing_tx_config_set sets the stashing hint (the CPU, 
> cache level, and data object types) on the Rx and Tx queues.
> 
> PMDs that support stashing must register their implementations with the
> following eth_dev_ops callbacks, which are invoked by the ethdev
> functions listed above.
> 
> - stashing_capabilities_get
> - stashing_rx_hints_set
> - stashing_tx_hints_set
> 
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> ---

Few small comments inline below

/Bruce

>  lib/ethdev/ethdev_driver.h |  66 ++++++++++++++++
>  lib/ethdev/rte_ethdev.c    | 149 ++++++++++++++++++++++++++++++++++
>  lib/ethdev/rte_ethdev.h    | 158 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 373 insertions(+)
> 
> diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
> index 2b4d2ae9c3..8a4012db08 100644
> --- a/lib/ethdev/ethdev_driver.h
> +++ b/lib/ethdev/ethdev_driver.h
> @@ -1376,6 +1376,68 @@ enum rte_eth_dev_operation {
>  typedef uint64_t (*eth_get_restore_flags_t)(struct rte_eth_dev *dev,
>  					    enum rte_eth_dev_operation op);
>  
> +/**
> + * @internal
> + * Set cache stashing hints in Rx queue.
> + *
> + * @param dev
> + *   Port (ethdev) handle.
> + * @param queue_id
> + *   Rx queue.
> + * @param config
> + *   Stashing hints configuration for the queue.
> + *
> + * @return
> + *   -ENOTSUP if the device or the platform does not support cache stashing.
> + *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing feature.
> + *   -EINVAL  on invalid arguments.
> + *   0 on success.
> + */
> +typedef int (*eth_stashing_rx_hints_set_t)(struct rte_eth_dev *dev, uint16_t queue_id,
> +					   struct rte_eth_stashing_config *config);
> +
> +/**
> + * @internal
> + * Set cache stashing hints in Tx queue.
> + *
> + * @param dev
> + *   Port (ethdev) handle.
> + * @param queue_id
> + *   Tx queue.
> + * @param config
> + *   Stashing hints configuration for the queue.
> + *
> + * @return
> + *   -ENOTSUP if the device or the platform does not support cache stashing.
> + *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing feature.
> + *   -EINVAL  on invalid arguments.
> + *   0 on success.

What about on failure of the underlying ioctl call?

> + */
> +typedef int (*eth_stashing_tx_hints_set_t)(struct rte_eth_dev *dev, uint16_t queue_id,
> +					   struct rte_eth_stashing_config *config);
> +
> +/**
> + * @internal
> + * Get cache stashing object types supported in the ethernet device.
> + * The return value indicates availability of stashing hints support
> + * in the hardware and the PMD.
> + *
> + * @param dev
> + *   Port (ethdev) handle.
> + * @param objects
> + *   PMD sets supported bits on return.
> + *
> + * @return
> + *   -ENOTSUP if the device or the platform does not support cache stashing.
> + *   -ENOSYS  if the underlying PMD hasn't implemented cache stashing feature.
> + *   -EINVAL  on NULL values for types or hints parameters.
> + *   On return, types and hints parameters will have bits set for supported
> + *   object types and hints.
> + *   0 on success.
> + */
> +typedef int (*eth_stashing_capabilities_get_t)(struct rte_eth_dev *dev,
> +					     uint16_t *objects);
> +
>  /**
>   * @internal A structure containing the functions exported by an Ethernet driver.
>   */
> @@ -1402,6 +1464,10 @@ struct eth_dev_ops {
>  	eth_mac_addr_remove_t      mac_addr_remove; /**< Remove MAC address */
>  	eth_mac_addr_add_t         mac_addr_add;  /**< Add a MAC address */
>  	eth_mac_addr_set_t         mac_addr_set;  /**< Set a MAC address */
> +	eth_stashing_rx_hints_set_t   stashing_rx_hints_set; /**< Set Rx cache stashing*/
> +	eth_stashing_tx_hints_set_t   stashing_tx_hints_set; /**< Set Tx cache stashing*/
> +	/** Get supported stashing hints*/
> +	eth_stashing_capabilities_get_t stashing_capabilities_get;
>  	/** Set list of multicast addresses */
>  	eth_set_mc_addr_list_t     set_mc_addr_list;
>  	mtu_set_t                  mtu_set;       /**< Set MTU */
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index d4197322a0..ae666c370b 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -158,6 +158,7 @@ static const struct {
>  	{RTE_ETH_DEV_CAPA_RXQ_SHARE, "RXQ_SHARE"},
>  	{RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP, "FLOW_RULE_KEEP"},
>  	{RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP, "FLOW_SHARED_OBJECT_KEEP"},
> +	{RTE_ETH_DEV_CAPA_CACHE_STASHING, "CACHE_STASHING"},
>  };
>  
>  enum {
> @@ -7419,5 +7420,153 @@ int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
>  	return ret;
>  }
>  
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_validate_stashing_config, 25.07)
> +int
> +rte_eth_dev_validate_stashing_config(uint16_t port_id, uint16_t queue_id,
> +				     uint8_t queue_direction,
> +				     struct rte_eth_stashing_config *config)
> +{
> +	struct rte_eth_dev *dev;
> +	struct rte_eth_dev_info dev_info;
> +	int ret = 0;
> +	uint16_t nb_queues;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +
> +	if (!config) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "Invalid stashing configuration");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Check for invalid objects
> +	 */
> +	if (!RTE_ETH_DEV_STASH_OBJECTS_VALID(config->objects)) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "Invalid stashing objects");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	dev = &rte_eth_devices[port_id];
> +
> +	nb_queues = (queue_direction == RTE_ETH_DEV_RX_QUEUE) ?
> +				      dev->data->nb_rx_queues :
> +				      dev->data->nb_tx_queues;
> +
> +	if (queue_id >= nb_queues) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "Invalid Rx queue_id=%u", queue_id);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = rte_eth_dev_info_get(port_id, &dev_info);
> +	if (ret < 0)
> +		goto out;
> +
> +	if ((dev_info.dev_capa & RTE_ETH_DEV_CAPA_CACHE_STASHING) !=
> +	    RTE_ETH_DEV_CAPA_CACHE_STASHING) {

Nit: check if all this can fit on one line under 100 chars. I think it can.

> +		ret = -ENOTSUP;
> +		goto out;
> +	}
> +
> +	if (*dev->dev_ops->stashing_rx_hints_set == NULL ||
> +	    *dev->dev_ops->stashing_tx_hints_set == NULL) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "Stashing hints are not implemented "
> +				    "in %s for %s", dev_info.driver_name,

Don't split error messages across lines. Text strings are allowed to go
over the 100 char limit if necessary to avoid splitting.

> +				    dev_info.device->name);
> +		ret = -ENOSYS;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_rx_config_set, 25.07)
> +int
> +rte_eth_dev_stashing_rx_config_set(uint16_t port_id, uint16_t queue_id,
> +				   struct rte_eth_stashing_config *config)
> +{
> +	struct rte_eth_dev *dev;
> +	int ret = 0;
> +
> +	ret = rte_eth_dev_validate_stashing_config(port_id, queue_id,
> +						   RTE_ETH_DEV_RX_QUEUE,
> +						   config);
> +	if (ret < 0)
> +		goto out;
> +
> +	dev = &rte_eth_devices[port_id];
> +
> +	ret = eth_err(port_id,
> +		      (*dev->dev_ops->stashing_rx_hints_set)(dev, queue_id,
> +		      config));
> +out:
> +	return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_tx_config_set, 25.07)
> +int
> +rte_eth_dev_stashing_tx_config_set(uint16_t port_id, uint16_t queue_id,
> +				   struct rte_eth_stashing_config *config)
> +{
> +	struct rte_eth_dev *dev;
> +	int ret = 0;
> +
> +	ret = rte_eth_dev_validate_stashing_config(port_id, queue_id,
> +						   RTE_ETH_DEV_TX_QUEUE,
> +						   config);
> +	if (ret < 0)
> +		goto out;
> +
> +	dev = &rte_eth_devices[port_id];
> +
> +	ret = eth_err(port_id,
> +		      (*dev->dev_ops->stashing_rx_hints_set) (dev, queue_id,
> +		       config));
> +out:
> +	return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_stashing_capabilities_get, 25.07)
> +int
> +rte_eth_dev_stashing_capabilities_get(uint16_t port_id, uint16_t *objects)
> +{
> +	struct rte_eth_dev *dev;
> +	struct rte_eth_dev_info dev_info;
> +	int ret = 0;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +
> +	if (!objects) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	dev = &rte_eth_devices[port_id];
> +
> +	ret = rte_eth_dev_info_get(port_id, &dev_info);
> +	if (ret < 0)
> +		goto out;
> +
> +	if ((dev_info.dev_capa & RTE_ETH_DEV_CAPA_CACHE_STASHING) !=
> +	    RTE_ETH_DEV_CAPA_CACHE_STASHING) {
> +		ret = -ENOTSUP;
> +		goto out;
> +	}
> +
> +	if (*dev->dev_ops->stashing_capabilities_get == NULL) {
> +		RTE_ETHDEV_LOG_LINE(ERR, "Stashing hints are not implemented "
> +				    "in %s for %s", dev_info.driver_name,
> +				    dev_info.device->name);
> +		ret = -ENOSYS;
> +		goto out;
> +	}
> +	ret = eth_err(port_id,
> +		      (*dev->dev_ops->stashing_capabilities_get)(dev, objects));
> +out:
> +	return ret;
> +}
> +
>  RTE_EXPORT_SYMBOL(rte_eth_dev_logtype)
>  RTE_LOG_REGISTER_DEFAULT(rte_eth_dev_logtype, INFO);
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index ea7f8c4a1a..1398f8c837 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -1667,6 +1667,9 @@ struct rte_eth_conf {
>  #define RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP RTE_BIT64(4)
>  /**@}*/
>  
> +/** Device supports stashing to CPU/system caches. */
> +#define RTE_ETH_DEV_CAPA_CACHE_STASHING RTE_BIT64(5)
> +
>  /*
>   * Fallback default preferred Rx/Tx port parameters.
>   * These are used if an application requests default parameters
> @@ -1838,6 +1841,7 @@ struct rte_eth_dev_info {
>  	struct rte_eth_dev_portconf default_txportconf;
>  	/** Generic device capabilities (RTE_ETH_DEV_CAPA_). */
>  	uint64_t dev_capa;
> +	uint16_t stashing_capa;
>  	/**
>  	 * Switching information for ports on a device with a
>  	 * embedded managed interconnect/switch.
> @@ -6173,6 +6177,160 @@ int rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *
>  __rte_experimental
>  int rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config);
>  
> +
> +/** Queue type is RX. */
> +#define RTE_ETH_DEV_RX_QUEUE		0
> +/** Queue type is TX. */
> +#define RTE_ETH_DEV_TX_QUEUE		1
> +

I'd prefer an enum for these.
Why are the necessary since we have separate rx and tx functions for the
caching hints.

> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this structure may change, or be removed, without prior notice
> + *
> + * A structure used for configuring the cache stashing hints.
> + */
> +struct rte_eth_stashing_config {
> +	/**
> +	 * lcore_id of the processor the stashing hints are applied to.
> +	 */
> +	uint32_t	lcore_id;
> +	/**
> +	 * Zero based cache level relative to the CPU.
> +	 * E.g. l1d = 0, l2d = 1,...
> +	 */
> +	uint32_t	cache_level;
> +	/**
> +	 * Object types the configuration is applied to
> +	 */
> +	uint16_t	objects;

What are the objects? That needs to be covered by the docs, or make this an
enum type so that it's clear from the typesystem what it applies to [though
that would require an array of objects and count, it may be clearer for
user].

> +	/**
> +	 * The offset if RTE_ETH_DEV_STASH_OBJECT_OFFSET bit is set
> +	 *  in objects
> +	 */
> +	int		offset;
> +};
> +
> +/**@{@name Stashable Rx/Tx queue object types supported by the ethernet device
> + *@see rte_eth_dev_stashing_capabilities_get
> + *@see rte_eth_dev_stashing_rx_config_set
> + *@see rte_eth_dev_stashing_tx_config_set
> + */
> +
> +/**
> + * Apply stashing hint to data at a given offset from the start of a
> + * received packet.
> + */
> +#define RTE_ETH_DEV_STASH_OBJECT_OFFSET		0x0001
> +
> +/** Apply stashing hint to an rx descriptor. */
> +#define RTE_ETH_DEV_STASH_OBJECT_DESC		0x0002
> +
> +/** Apply stashing hint to a header of a received packet. */
> +#define RTE_ETH_DEV_STASH_OBJECT_HEADER		0x0004
> +
> +/** Apply stashing hint to a payload of a received packet. */
> +#define RTE_ETH_DEV_STASH_OBJECT_PAYLOAD	0x0008
> +
> +#define __RTE_ETH_DEV_STASH_OBJECT_MASK		0x000f
> +/**@}*/
> +
> +#define RTE_ETH_DEV_STASH_OBJECTS_VALID(t)				\
> +	((!((t) & (~__RTE_ETH_DEV_STASH_OBJECT_MASK))) && (t))
> +
> +/**
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
> + *
> + * @internal
> + * Helper function to validate stashing hints configuration.
> + */
> +__rte_experimental
> +int rte_eth_dev_validate_stashing_config(uint16_t port_id, uint16_t queue_id,
> +					 uint8_t queue_direction,
> +					 struct rte_eth_stashing_config *config);
> +
> +/**
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
> + *
> + * Provide cache stashing hints for improved memory access latencies for
> + * packets received by the NIC.
> + * This feature is available only in supported NICs and platforms.
> + *
> + * @param port_id
> + *  The port identifier of the Ethernet device.
> + * @param queue_id
> + *  The index of the receive queue to which hints are applied.
> + * @param config
> + *  Stashing configuration.
> + * @return
> + *  - (-ENODEV) on incorrect port_ids.
> + *  - (-EINVAL) if both RX and TX object types used in conjuection in objects
> + *  parameter.
> + *  - (-EINVAL) on invalid queue_id.
> + *  - (-ENOTSUP) if RTE_ETH_DEV_CAPA_CACHE_STASHING capability is unavailable.
> + *  - (-ENOSYS) if PMD does not implement cache stashing hints.
> + *  - (0) on Success.
> + */
> +__rte_experimental
> +int rte_eth_dev_stashing_rx_config_set(uint16_t port_id, uint16_t queue_id,
> +				   struct rte_eth_stashing_config *config);
> +
> +/**
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
> + *
> + * Configure cache stashing for improved memory access latencies for Tx
> + * queue completion descriptors being sent to host system by the NIC.
> + * This feature is available only in supported NICs and platforms.
> + *
> + * @param port_id
> + *  The port identifier of the Ethernet device.
> + * @param queue_id
> + *  The index of the receive queue to which hints are applied.
> + * @param config
> + *  Stashing configuration.
> + * @return
> + *  - (-ENODEV) on incorrect port_ids.
> + *  - (-EINVAL) if both RX and TX object types are used in conjuection in objects
> + *  parameter.
> + *  - (-EINVAL) if hints are incompatible with TX queues.
> + *  - (-EINVAL) on invalid queue_id.
> + *  - (-ENOTSUP) if RTE_ETH_DEV_CAPA_CACHE_STASHING capability is unavailable.
> + *  - (-ENOSYS) if PMD does not implement cache stashing hints.
> + *  - (0) on Success.
> + */
> +__rte_experimental
> +int rte_eth_dev_stashing_tx_config_set(uint16_t port_id, uint16_t queue_id,
> +				   struct rte_eth_stashing_config *config);
> +
> +/**
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
> + *
> + * Discover cache stashing objects supported in the ethernet device.
> + *
> + * @param port_id
> + *  The port identifier of the Ethernet device.
> + * @param objects
> + *  Supported objects vector set by the ethernet device.
> + * @return
> + *  On return types and hints parameters will have bits set for supported
> + *  object types.
> + *  - (-ENOTSUP) if the device or the platform does not support cache stashing.
> + *  - (-ENOSYS)  if the underlying PMD hasn't implemented cache stashing
> + *  feature.
> + *  - (-EINVAL)  on NULL values for types or hints parameters.
> + *  - (0) on success.
> + */
> +__rte_experimental
> +int rte_eth_dev_stashing_capabilities_get(uint16_t port_id, uint16_t *objects);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> -- 
> 2.43.0
> 
