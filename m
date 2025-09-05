Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF505CA0FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:12:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E10D40612;
	Fri,  5 Sep 2025 17:12:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A0BDE402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757085144; x=1788621144;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MSR5cjxzQ1ou8GzfHw9y1iVCPn48eCm/NHhEZxkCtSQ=;
 b=Sq0AoCqZKJXHPH37GxJcaoX4kXjOfwmgQr2BdZ1h2Uupcg/pnydi8sBt
 g2p2279P8OCeNMpPwJ3asy0WQgplDgpIq9m7FH09XKL6UvfUtXhsD2MIU
 kSk/ikIRY4g/SoHN4QxV1nakyK2ZufGWr4RsoWSpuR2OqiEwDD1hfNBhq
 RBvIqaHl/pdzCmnLw2AhY6C7aiM0/XbRdO+VugywSBaTe4CFh9FmE5J90
 30TGmefvOoc6H5v6iJET74rKp5+FBZEfD/S4jyPl9RmJNOwBM/vUCsJ00
 EdpE9SnP0xLxD/HOxT6hPMxYDTUy/RnTiB3cJWGZF1z2Ba/30DJuLUaMe A==;
X-CSE-ConnectionGUID: qul3r/hvR+CjHeVrIalpDA==
X-CSE-MsgGUID: SQhyX2J9QxyfgWFWE+Wsww==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="84874020"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="84874020"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:12:22 -0700
X-CSE-ConnectionGUID: YTD8d55gQiWvrSydGYzc2w==
X-CSE-MsgGUID: +XMeM3blS1GHP6yGc6EjxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="171464512"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:12:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:12:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:12:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eilhxw93iFDct6yqLBcHddc32nLOIax65ESafrQaNTg+vdpBwOCJoqJThqXNBYFZKoFJGRMGi7YWiVSf6Gee3jWdTP3AxIDmFCb7qa89q5cbeiwRe5hqvmAnbiwfcAWuinRAdamAyDpBimt7X9s8nymsUpWAAET/hwsiCDrPSmKH8nQnnmWoDBOSihyIfenGf62eSAkwyE+pnwnP20HmqBLKb0MYBmFUuDVhIkpM7/MAL4gIibTNQrQfJB4Buh0ik9CHbQUO31vpBA0wzWc2Jfyyto7YbZRAcM/hZ6V99wSHm7wL72ThBIaJQHSwZaUgkBF6r5xTTc+EETBVoongyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YsfsvBESgeCGdM//QIAnBASfdzAbW6at3jkfl03/LU=;
 b=bOFUZ/smIw/ZoxMVGWhmJ+Og/Kt5wvaRSTDlXD+gfkvktid2dLbRK4x3BxHXh3k5xeuuuJQMM7b/UHm/I029KFTFtovmGaKLWyUYv+3Aod37v6RuTtti8u8n1lV6ZvJNIoJKWpLsB+qR0qAyn17i97A2vieRrf2jyUajvYzuWyUyTMtJWHxKx1l2CLhFzetQmSmd8B5bZQTtfh615ExAdWIRFkxZslsc2T1pqA98FAcNJw3DWv3bX1mvRTpu9TuOTrFAWcem5c4O9r6HRFFrzdPGKihZ2Mqc8/wOIUvDFeA5OwZ2xaPcLjyg9Y2hFwq9bEBN0qXpz9cJYSsjPpTnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9396.namprd11.prod.outlook.com (2603:10b6:208:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:12:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:12:14 +0000
Date: Fri, 5 Sep 2025 16:12:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 05/12] net/ice/base: clean up RSS LUT selection
Message-ID: <aLr9yVhGnqgJZ7w8@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <247421eff2190715c8ec74663620698757b11c5b.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <247421eff2190715c8ec74663620698757b11c5b.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:10:234::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: c638ce3e-9c03-4a1d-bf78-08ddec8e9843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HM+OD/f+ky7DRDmQ3HIRMjsKSDX3ZpgomS6ig9AAHq2Cf1VXbNfYzLW97cwR?=
 =?us-ascii?Q?iXka/pzUjGHimRcwDwqnN0V33GwObyRAHSyr6BVMoxlQY+5/UQ51lxWj7xjK?=
 =?us-ascii?Q?dqqlRdurHQIotsGxeZ2E4kQq8SvqJGHDSZBTurVWEerRCeyIGUdzlZjY/Mux?=
 =?us-ascii?Q?8HlULamnsulsNUX+8JYkRJ/lYomdmCdAE2tZuHJmVJ0snkhSfqIPkhpxfqrt?=
 =?us-ascii?Q?sSkvB/YOZhMfgFcL3eer9ga1dj+tdVRdkM31Be+R9OMEfg8MyaO5wP5RBIGL?=
 =?us-ascii?Q?HFb/ZEEo+CwMAAZ1kK/nP3VflILTUrqhdPv8Bys3jebgnLSIFWIeCxJBuQ0V?=
 =?us-ascii?Q?uvRDn7kGObfNEg8Bq7TQgoC7PQI0yp/NGDOFeU/wFMYQlAiShMnVkXb2lCgn?=
 =?us-ascii?Q?2gLlhz02He80BBg5ysgAswgOq0kSqBqtkiROKCJOaXE8R8JVxLJ1z+1nMdRK?=
 =?us-ascii?Q?kV3b7eB83tTMzZNJ9t/cpWOoLn9IxzKrymOm4Fnh+Iv3LCY2wkpPuwpg4nuA?=
 =?us-ascii?Q?1AWG18SwrSKrqD8Jn3Vb/WJkMTf6uWlm+Q77YS31FpWuXBdrPi0oLF84IawF?=
 =?us-ascii?Q?PEX3ByKv3e6tT1fuhTAiIEQKf94U/qJcSOMsnCATSGXuSomF39VRxYmPQOht?=
 =?us-ascii?Q?mZKFUhjIgHsblvclD2twbIuAa0itJDkvQhI77Ey8op25N48Tw4ZIjNpNybNv?=
 =?us-ascii?Q?EovkfVkpi6veY+qg09K7R2mV8b7S2gAEW5jsEIa/qZoGGG9rL8R4ha1vokwO?=
 =?us-ascii?Q?hX+wB/oVnlMDUjf66FAcWKDerNusV2FQ/KmRbBfZ9zjfDMXA5kY2psmCpeqi?=
 =?us-ascii?Q?u5/5FrHxs4N6qzgB+Sn+hPGSPo2avc2R/CKDPsSjksjOjhv7+/YdbnseQre/?=
 =?us-ascii?Q?jQlepg82pwu/vsB3fSacVQo6BOXJAL/1ydLn6g65lUDUqcr8+psNQDQ8f8hp?=
 =?us-ascii?Q?OhLMQLhXmA4P4fRS42wDysj1hiItm2uDE8vlz/0yeL6prBzs4jlb7EZ5JFe+?=
 =?us-ascii?Q?51sa5IOpfIqQxDnA+kjrFiqtrWQqHfLVrbutCLBKB6frpie5fng3ClTmx4c6?=
 =?us-ascii?Q?FvHl/nvbkEBm0xmDifx1Yln9Ib9I8I946aiavMRwq63wehBC+pXVYthYFMh5?=
 =?us-ascii?Q?XSixdrc+ZuPGlNu2OmFffo6YQMHqjbt8v78lTjXr3HijQo2DePJfYlBI4Eo3?=
 =?us-ascii?Q?XbscsZIgC1DOK0BE4koAZ8jmrwy8l73F3JLnGSEnJbaH6E0fmiTxtmwMbSG+?=
 =?us-ascii?Q?18StKn1xBHijcF5UpFL2NI5ex25ERScNagXH2dGihkL1gtzSinfvtLT3Q9ga?=
 =?us-ascii?Q?EV1NZkX/kRLD/0JeAq7MR/85PSvdNiHsCcvaJTYmKbaaxb0E9BrtMXDJh7LQ?=
 =?us-ascii?Q?rqVJ1EMwita3BRf0X1G8gZ7u0JKEWFX9k67A0QI4/+WRa3KP6wRTrXTTiI5E?=
 =?us-ascii?Q?H8vr4+ZpCYY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x3a7S3vfHW7EHUhCbtF7o4eiQkYrWOWAMLasJm894VNTQm/E/UQKm171xpsb?=
 =?us-ascii?Q?Ong1rcIJc180b3MwOOpYBNzkOTp9y5cpHgIpNNOLAplUutHuuSkukkPlsfqV?=
 =?us-ascii?Q?LkJmXP5QV/9pw0GfTk37V/ih3N3vCbG/kSvYdbXKSDQxQjmfVxQd/rJxaKp6?=
 =?us-ascii?Q?efdvgI7FXhFONJl5sCfwzdFknNM4V49M4HXtzjJbLE9x55iWLvaOtBw3Rai8?=
 =?us-ascii?Q?q4vUepUi8764HLnx1kcwHtX/4UHKxsf+Zr8PAkjXdr1G2CgtwMVNXvwbW+8n?=
 =?us-ascii?Q?PL1Adk2MnXZt3RwoR2nXvjF/SnpCAa7QxZSkSocdtah2Sea5eYPelk65K0uK?=
 =?us-ascii?Q?iJeYt7KhSnMANUg4ewrJXo/stR4+2XfzeehkfkYOppmeef/YGnZY85GWXyGA?=
 =?us-ascii?Q?rb7iZlRpdc/gqIvmlVuMX7eR/VWcMWN/s77IT8c5W5uHNHUdFClh1Fb2v33A?=
 =?us-ascii?Q?FLoPsOnxsShmmzbG5O5gJplVsQvxAdAsnG5qayS18WpZhUge3OS+q7TiFIH6?=
 =?us-ascii?Q?E5DdUGQ7Igb/OBjcAE5ifnFk6Vbi7SPBPGXrfB8lyz6AJ7wmNbrhwFSTX4Pe?=
 =?us-ascii?Q?EWuDvnWCa68z1uPgXkKOXJcYOjzXtPdUbrGUqpdgX3u11WYl8kuEyLH/94Tn?=
 =?us-ascii?Q?acLfnH4encm2LrOMlhPEEMAAKm7M2DF0CSwdmUFrh5Bv/AGQOr4qRLTi22+E?=
 =?us-ascii?Q?dknEo/kZX9TAFKR10TM+do1GnrZnaGhD7lgvEv1CO0xezQNuD/F5FB8v7MpR?=
 =?us-ascii?Q?3TBa0p6IfSvDUYdKbQoycY6sgR9HBWXkM5+wzFpAWirZPpA56YzKRIHoNzug?=
 =?us-ascii?Q?BnFCVMTBIxZfWLC8z21geovrnmEApVdNkGN/KrPEqN73G06B7W89nZEQzJBc?=
 =?us-ascii?Q?mXyPKsp+h+b1FXo24rklenI6CWLJT8ux/mGH0AoAIpc4CeJ2MT0sftiZ7HjL?=
 =?us-ascii?Q?K5bcFxscwZliiEcgL6lfT76xRZ0hyrK1ok2a3RnpsAzR6NwyhJF8WGE9tYFO?=
 =?us-ascii?Q?DMZsJU9X5ZZCTGh8ICHTsEIhRmR0WWbm1Z4doLQWkKiQE7THBJhKKTzT4d3B?=
 =?us-ascii?Q?joNmHq/vEUqj8/c+uSWpGvgh/U7Us/k+BNDbg6Muz2cgBnZJA5ft0xMUBYhu?=
 =?us-ascii?Q?Q8QCm/p+37qn7FWGJeovN9NySRwILaRPw2c+G48qjFcQ/j1P+BL5P135KsH2?=
 =?us-ascii?Q?7/z+nrAx7n7ajOk2hOOEpX5JKH1816eYBV+tfesudNVJxIEWCPLwcVSdrpyc?=
 =?us-ascii?Q?z7pcLDTHbyzRO5vfNsdCkMVGqYx5gSpT/3cxkN8msEOAJUShVg6+8WgP/Opv?=
 =?us-ascii?Q?xum5GbfU+9/5YV58eL9YfQecV/0MhlfHL5bgLTpQruJzLAhq4+GcwHMGdkiO?=
 =?us-ascii?Q?f/xHPtDNx2UVogQkg/CJc08OMxxe+lHFEugxuuZ3zmB+qcP99ZQTYJh+n7QI?=
 =?us-ascii?Q?kDRQVwtC2DmbxOzxQjHp2HQkRSPc/kaeg+GN3xu/93CWXjfBHGkCsz9YOJCw?=
 =?us-ascii?Q?JNliFm/EHPKODXKu2Z7GkqcSPMLorOv7CANGDbzk65UitI+pV3Ezs63mQ6tL?=
 =?us-ascii?Q?gUX26Bq3t7ol/VeHFvD2gJL7jjp5tCbEiOnOU1aqm67KvuEEhoiREj7o+nyb?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c638ce3e-9c03-4a1d-bf78-08ddec8e9843
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:12:14.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNWNoCl6nj0gCQFxek3TVll9w6UZ5KFXix+oIt2rpFULfzKpO+rIiMDAF1AXuqEe3+u/oFypTDxogiaIc4LcwC3F0YB/XVa9VNUK4c0EQEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9396
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

On Tue, Sep 02, 2025 at 06:26:55PM +0100, Anatoly Burakov wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Refactor __ice_aq_get_set_rss_lut():
> - Use enumeration to specify different available LUT sizes
> - Use enumeration to specify different LUT types
> - Refactor setting/validating various LUT settings
> - Use params->lut_size and params->lut_type to communicate LUT size
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
