Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB401C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1009410DC;
	Thu, 10 Sep 2026 14:14:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 466CE4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789042439; x=1820578439;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IINlQSwyjjcmw0iHy1JYKW8eGVe+7Ef5kSlWugP3844=;
 b=nKweYDBsA/VUeayxsbGzyrr/v2eOM3fP5s7GlJtH1zehxhGJsuX3i3G0
 LUx5I7f1HoTNU5NOGtRHDmyLkbjy6XdtMOL3KYRp9L1mlIjSNx71DD14X
 2I32im4E2OiNwqUS7vA7tLYHj3r0BqePeSQuBERdtUTz04pLGLQLE4QT3
 xlEXpbnCkn8A26L9hKhTm4bvT58CbHcoxGI/OhsxvpLKU9PMQ50I8hH+3
 HZeHxKE4CUDBwO63Xnse047lrMdyKY07BNo3cV3sweGyA6sH8GhLZHne/
 Qn/kNN0Ii15Du72FBdxWYhU8+K09Djb+q06ah3UmWeLJA1jCyq/R56fWt w==;
X-CSE-ConnectionGUID: hQPxYFHGQRaKwDxRHpGWUA==
X-CSE-MsgGUID: QY4DK4LKR7iTvPcfGlkRjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100151770"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="100151770"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:13:57 -0700
X-CSE-ConnectionGUID: Moa2W/xOR9yd1lt6Rye1dg==
X-CSE-MsgGUID: NzK8R+wTSmmjicGVUXtYDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="265403430"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:13:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 05:13:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 05:13:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 05:13:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLurDYaFJBx6hI+XXttGzZK5jQcwQwuj4x5lwBD3KRcuAoq/ypIJ+i8vUmg9D/Y/nTJN2BvwpCql8IoVxKxt2UuWHvQ3sEk1pWSnMwPTaScQbe4+PAME81Jr6JkB8D7+dV740bCjABZKXwsOy/yUgU7bjfBYFlQCCMbmnOuGSFPbTEX7jOWsZFfmsoup0ngEBp4DyNfGubAwJ7aIHS5sagtCTGfk7Uf+TLKvOIPWAnvQf+UrvnD+R/jdwIOwkzpNfO+Ni+IIDmfQTI2K9V/9j1KNQh3oKXEhLqA+O4EjFW168xPofz5fUmQiR+zBXdDYs3V6qxtSa3bUjxi/smALRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDoGVeL3xNli3LQ8hnSP3NpcxBe8VjS3CKbyYRGZ6Nw=;
 b=dGgQFrbRPvqZoVOpn/sm1wA/olbvRV2Hoh+owcapk2+6HdPnSLC7BsHNvjoU+LEYdfP6YGFilSrjriqG65Q+aboYwNJ4qarrgVn2cm1CcYrzLTZPCggo+0FCXwptNKqYiTw3WMboejbTqznjUJgi+IWXaILDCC7fLLWWfmEBiMWaG5nMFBgSL/72EwcbWykZWUgmM9xEfNUtpRKuUx9kkRhNA6e3HO+mxZJP6bo6Cc9ntua84zh39oCpsYPN2xwLn95nIKo0UsKx9ugwY4/8DbotBHFj8sr2DRqbr7YdL/jj26jiNjoB4DNw26baeh8LY+C126SVmPP8QGlxiZ2xHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5111.namprd11.prod.outlook.com (2603:10b6:510:3c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Thu, 10 Sep 2026 12:13:53 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 12:13:53 +0000
Message-ID: <115329f1-ef86-4330-a198-2471cf3d69f5@intel.com>
Date: Thu, 10 Sep 2026 14:13:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] net/iavf: accept up to 32k unicast MAC addresses
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260904122804.2256481-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb18314-77c1-4a08-18ff-08df0f34fae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: VlHcyadFtDNGNiM87JTs/3UnCaEBE7OK5uUV385pilSB46V5Y4Vu9hBiJBCELt7J5UAO18kCCrHMnQmdik8QXv8J0b9Awvv+xuVSvTwcrIb4SyUOqgsM+CWm7mSGhswY55cfvOt6jHaH73DjEGPk/M3ZXyBvJ+ZV8aVLRH/LrBiImu4lF+ddyWhR5QU3wLCuOOMbWRDNDAbuOSwYzRLKxMVUkJvmu0A4/6uJ0BqvbXlISWatAOpqEoxXp94UMyVNMe6U6fXjWrXYqJ6Uhxk0/lXVQoXlWTHGfwaI2OitVSM6o3wmU45CQKONgUJ8a9Uh/oV2PdSlqhIuUZadIv0UiVEjb0KSuMHUacEQetKA3PCCVi/toCveJvFr1uJEZPuvv96R1Z3eCrneKy7/Kljhs4FQSncBeIFO/KGTuSaEUe6ul8PWMrTAYWz5jeYrtu3JHHZznnElZTmpPejRPuB/qW5WrY16vK+4QGxhHs8TDigX+DycpTGgFZbkuC4MOaVxk3rH8cHfJKCW+jxJJsRc4Lrxomr0rrN8bvqe3gJumLzOdj6ey4X0rhXqeVQri2jo8F1+/n+b4eky+BeLziFtWlTo7uHjE94pqMfLKfpZnONMXku5jDwfd4S3h0dJ7cmZFb3wOyA+bUQtntKPWqx+Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlAza2xJbTJFNEt4NWtYWjgyRE55M0NOTC8ySXh1MTh5SXZLT1UyTllCOXlu?=
 =?utf-8?B?MS9maEh2a1I2YUF5WjlmalUyQkVtNXRicDJZYXR3eEZQd20xNzdmN0ZkUUNG?=
 =?utf-8?B?ckZtQlNsM0dQb3prT1Fmdm9mVnNIRDYzcHdKbzh0ZDBXMmdQQW5nd05rbUVO?=
 =?utf-8?B?SWtUdE5XbUJiMTdzU0pUY2Ywd2J2aEEzcnhCekgzWVpQQm8yeGh5SGtRYm0w?=
 =?utf-8?B?amlVcElubGZXUjhIYllsVkc1OCtDUXhkdzRMNW1KYWhNU1JzSUpOTitMK3k0?=
 =?utf-8?B?dENhNVZqSVA3YWM2bUZ5Snh2OXpsN3FwVzIrWmtaaEVhZWN3Q1JQdnREU0xw?=
 =?utf-8?B?SXdYd0VQR3VXamtTUVNVZzdZSVlNTTR2ZmJMMW55L25hY055ZTVVSk9zRk5W?=
 =?utf-8?B?YmVXaUcrUnJLUS9EMXU1TkluZSt0dHJTcVY2WjRnQ1UrYnZPZFByU25HaldV?=
 =?utf-8?B?cWdRY0U2UGZNZnFBVG43eW51em9WeFQ3WDRyaHUzZjJqR1loTE9mZjhoajRi?=
 =?utf-8?B?d0ROTlA5TkR6OW8rYW1yRmNqNG5vM3FMMDZ6d1J0OW1TZW93Sk1ZSEZtaFlW?=
 =?utf-8?B?cFhCcnJoYjREdm1mSXZ6RW1mVHIxKzl2VlRMb0xKbDlBd0xKSWozVjhRU2lp?=
 =?utf-8?B?Mk5IVnFUWWFrNnZDRCtPU0lOQmtiT3czZ1BpRU83Y3Jnd3Z0RXNaMmdscmd3?=
 =?utf-8?B?STdEY01CbC9HRmtwV2dqNk1GWkdTSDZveklHNE5iL1UydUI4K04wZEFZUTlW?=
 =?utf-8?B?ckdyRnh0SnJGVExQdU4vTWo3djkxTEJxRm14QmhXUkU0NmtnWVdxd04ycG5n?=
 =?utf-8?B?eEl0Y2U0emEyQUZ3YzlRcERUa1hxZVgvUlpoQk1Cam91a1pzUXFmb1NLdmtv?=
 =?utf-8?B?UnJxa29wWTh1T1ZMNmljeGxLZ2NaSm9LdzFib0dTaEtXYmx0d0FkNnduNFdt?=
 =?utf-8?B?cTR4VHlPa2U5b2NCa3JoekhCaHpWZHlScE15REtEc0J5cUpNMk5icFQ4VjJa?=
 =?utf-8?B?Z083TWZZOG83Z3M2RmdMaldSYURZYklGNmxXa256bmdId1NsUXhDWFphQS9S?=
 =?utf-8?B?ZTlOR3dibGorLytudW9PNEZTeXpjV29ZT3NSb08yN2RQOG1yMkZ0a3pvQVRY?=
 =?utf-8?B?T1pldmdrMUFvZDUxTmJ4TEhESkVrTUFNZlZ2YmloVUp2OHk3ZFljNzRTaGZC?=
 =?utf-8?B?aXhZNm04SWJYQTV6UWczSmhPL1FoNU4xQ3dvT3BkRWFjRW85YzJVS1NhaHZs?=
 =?utf-8?B?eUZFSy9yMzdFMmZ2Rm5ybDlwQitIL0prYnZtTzdQNUVIclpzcVdBd1VDL0tm?=
 =?utf-8?B?bTZHSmN4VkRLUWpDaWFzWVNGUWVrY0tJSVRIWnRMWjRCbWlVcnd2cStHdEJU?=
 =?utf-8?B?SzdVdHlFRDFyaStHblBySlVlVUVzWlpDYjh3SlZSbG1qWnM0bnRoNW11YlNP?=
 =?utf-8?B?RUdJQkEwQWpDMENpTmlNZDZXQU5ybm1KZFRiTFpTb2gxRnhSaExQWE5EZVhD?=
 =?utf-8?B?cGhneG04bnErWUFlOGN1WWF0YmI3ZmYxY0d3QWR2YVF4OXN4eTYveXpabzZ5?=
 =?utf-8?B?YVRyNW0yVGJPQ3FnV1BUSzZPT2NtM2pTZ1JHU3RQKzJhN3FNc2xZUy9sdmdu?=
 =?utf-8?B?T0tZSnZUNEEwR2NhcXRncWp2aGFqdjlzZFBDRVIzb3BaZDB4VFVUYnFCRkRS?=
 =?utf-8?B?MUI1YlE5SlVDeGtaQzU1akV6VlN4YmFheEZFRWRjZ2ZvakxMNCt6NEIvcEpJ?=
 =?utf-8?B?UjNRc1lFTTVMdm1RSmoyaVJwWmR4Ni9JU093UXJ3d1Zvb2NaL3NxalcvbHMr?=
 =?utf-8?B?eURNRDE3alVBZmp5L05XNXF1TTgxczltS2N0QzNreDUvTFhodXprVE9UU2xN?=
 =?utf-8?B?aDJOaTJjMGtmY1dXbXlyV0VmN2FIcUFkbTZyTXFJa0RzZjV3K2JIK2V4aUNF?=
 =?utf-8?B?cVV2d3lnV1N1VjUyaGNFdlk2a3EzakdCdmVGTHNwcTNzNTJ6bUxlaTVPYXA4?=
 =?utf-8?B?cGJMQTJjR1hZa0RYZTRHUFhER1NlK2t4U0lUci8zK0Q2MllreEZLQVVxV1Qy?=
 =?utf-8?B?WXhRRDkyVjk5SzVFeng1SW9MVmswZDZNKy9aeWNGZFJubmhmN29vKzRkRTQx?=
 =?utf-8?B?RUY1dFZnMWhneENFWkxFZmFGTVY0TkdkU1BseUhhZGdtb2ZQeDlnTjRmc0hP?=
 =?utf-8?B?ajJ1blFXOWp1dkhkdy9wK1BFTk1DT0lHYXpuaGF1d1F2YW1lWFpZcURPTnc0?=
 =?utf-8?B?dTgvRjdKT2k4akI0TXppVks0cU41clZmM2VCR3hxMmxBaGhPNE1DSFY0cDRq?=
 =?utf-8?B?clVhMWlPVktkT3Vxa2lGQkFxanhyMkhVUXVMQ0liazE2bmxoSUFIY2J4eG9Z?=
 =?utf-8?Q?tOREmY+7o/F/oHto=3D?=
X-Exchange-RoutingPolicyChecked: uWFrZt/43qggOX/1hK2Maazql28DQJdkWVZize3mYk338C3pT4Van5TQU26uJu3es+jTXe7hIMHuQGA9yT82pV1YmUJXAz9fdGjO2dCUE3xgm3FWyskhokdVkgOcX54FE/hVT3p67hVX+CUQBA2X1zzADj7geRXyw1RfN7Gg1m5jyuH1YtUleHStSZZFtbaOLTRxlb0LNvJYlbGKfHEWjD2inVqL5DcR9nWGk53sD6ZG0ANxGCNDc67T9jBAELdDYQ+f2Hv4A9QXoi4/vHyWHenOOH08t2hfVCTS0BP0zXHOk3pa7HywfyljBpb1Op0+0jPCalCBadTF7Hhr6QTqAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb18314-77c1-4a08-18ff-08df0f34fae0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 12:13:53.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azaK3YXisYXkIEUGekhvoPbkmnwyDj4U+dJtZgczmIE43HvyxTUgj/qmxZ4I0Ldn47oHrngWoE3p4J9BWzIVrOhO8PiPWvHbG/JqM0mDV5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5111
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

On 9/4/2026 2:28 PM, David Marchand wrote:
> E810 hardware provides 32k switch lookups.
> Thanks to this, it is possible to allow a lot more secondary mac
> addresses than what is possible today.
> 
> In practice, the maximum number of macs available per port may be lower
> and depends on usage by other (trusted?) VFs on the same PF.
> There is no way to figure out this limit but to try adding a mac address
> and get an error from the PF driver.
> 
> Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
> accordingly.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

On another note, I don't think this is even compatible with ethdev API.

In `ethdev_driver.h`:

struct __rte_cache_aligned rte_eth_dev_data {
	...
	/**
	 * Device Ethernet link addresses.
	 * All entries are unique.
	 * The first entry (index zero) is the default address.
	 */
	struct rte_ether_addr *mac_addrs;
	/** Bitmap associating MAC addresses to pools */
	uint64_t mac_pool_sel[RTE_ETH_NUM_RECEIVE_MAC_ADDR];
	...
}

example of this bitmap in rte_eth_dev_mac_addr_remove:

	/* Update NIC */
	dev->dev_ops->mac_addr_remove(dev, index);

	/* Update address in NIC data structure */
	rte_ether_addr_copy(&null_mac_addr, &dev->data->mac_addrs[index]);

	/* reset pool bitmap */
	dev->data->mac_pool_sel[index] = 0;

	rte_ethdev_trace_mac_addr_remove(port_id, addr);

meaning, the mac_addrs array and the mac_pool_sel have the same 
limitation because they are indexed by the same index.

RTE_ETH_NUM_RECEIVE_MAC_ADDR is defined as 128, so correct me if I'm 
wrong here, but according to ethdev API one cannot have more than 128 
MAC addresses?

-- 
Thanks,
Anatoly
