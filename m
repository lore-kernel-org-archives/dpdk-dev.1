Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD707606A326
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fel8T2S0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3210E40299;
	Wed,  4 Nov 2026 17:26:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id B355140281;
 Wed,  4 Nov 2026 17:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793809587; x=1825345587;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dje/fR4eTAnRTQ205P6MIJGapdBAI8OvomiZKBBiqD4=;
 b=Fel8T2S0ACHnS2B0cXGOu7M3aHaDGUkcUwoGoBGKm6pdJHSHcDwaRCS3
 WaY25FqNfcslKWQFvdjdtLXLg7DUTizwHY6FqoHF86N9fX+pQWVx/uqyj
 c8ZvMEBzXbvGFU1pSC5VzteKu3+QA996LWKBfKLeBvTeHhF9lXqhOMIFs
 /pDoVo3jYUHEviIMpqYemHg6Njr03YMj9i+QI7bfcbGexcp9aU2xT2FA5
 fYAZ8RYl0FkoMkTkbfoeYmuo2aswkbhLeucYD3BvC6RVzuUxJXOMU/9Ul
 wHMlXqH9WJMFUy6wIkWR6AIDaLQ5f5IrmqR6wUKmfehQqsDtxgyeUJFF7 w==;
X-CSE-ConnectionGUID: MGEVY+52QN+7MlGCSgXz5g==
X-CSE-MsgGUID: /YQL4L7TR+mcUrsW6E/Mig==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2608689"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2608689"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:26:22 -0800
X-CSE-ConnectionGUID: nCPbhrn2R3aiIBO0eRjhug==
X-CSE-MsgGUID: O08QMysLS8yyywb4mVaBTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7108048"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:26:22 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:26:21 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 08:26:21 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:26:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/puVnIp14cKWtc7qA+GP0Hhpc/+9AjdTtK8hRIWtKzocj2nU8L7kpdExjYWcfi+UyJZjiG2Cfral9fcdY0SjznD7tWmQRO6ATW03Sk1bep3v1+EAiFaztbJ+Zq+L92adPgYATXeyHgje5qvZqlj5102Yfnb5zaghRrl9NKVhROOz1psXMw2I7tzdRhlLcli9UZAR2zjUBg/Nn/1JUOQeKrHCyza+9JWJsqPz9p6jh6yLKF9qYuD/ZatMZVf3y0sTe+DirJWWg5pLk1CAfSh8hev/1IkQ0Osflc1zV3yZyVyBR0Dk0A21GS0t8FKltth0RX20UNHmJ0o20ay0JceqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPkd8A7vd/MA++vvEQviKQv4EZtXVj27YZpDQMkKi2Q=;
 b=Go2UgxkMObaR9lRFQP9Y4t6H2yxngOewiqrg1xybv1GH4o6+J6As1xCTrxaHaQcDhgmZ9+g8zertW585E7dogP1zQqvsr/hRGhE1oAfCOohVuOYGd7gCN7jqtL1JnNSpPuzPgelkZ5jcOZoU7OmLBmwYzj50zbRMe/SAMCOnqEcW4S1gTSHkjgXvUWgCd0KOfzkgWZdJzsPtct2fJr8u3HH0Kw+fB4B9qdZ4aPNkge7EZTxAhpyTn9rRk+9NUAqwKKE3vvUoj4/qOLp59trb5DEenYfj09wgjWQsAuGKxNDWmTWjEH+NQlz/bEOH7a9ExSXHexoFqyAnt9lxN2/tcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:25:44 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:25:40 +0000
Date: Wed, 4 Nov 2026 16:25:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kevin Bowling <kevin.bowling@kev009.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Soumyadeep Hore <soumyadeep.hore@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix AdminQ polling after interrupt setup failure
Message-ID: <autcfx5ozj07yiuK@bricha3-mobl1.ger.corp.intel.com>
References: <20261101232140.94324-1-kevin.bowling@kev009.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261101232140.94324-1-kevin.bowling@kev009.com>
X-ClientProxiedBy: DB9PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: e10b8508-c93d-4a53-d975-08df3a9043e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261021135927099003|261028144727099003|11063799006|56012099006|261022105027099003|261026121527099003|261022075727099003|261102123227099003|261021121427099003|261026140227099003|10067099003|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7TKquuT+JxsVMNxDtq0KF2Frb4BSvDMpI12C4Yop1w0xus8ByEpy2/6y29QN7qN3CCgSwc5b3atbzDZHLsbljCJCQwrm06dT+PfIB6EFYMSX01y74wRjBf9RlrmFqdEAER9h1PIgUMXb/PuvDBjrBB7r+hc1kFUQ+hXL8Gnuz1mI8DtVZjfIjcWCMndiLaYqhL2KKeVoLup1mroL9WkYettFy6g9yGJNuno/Qsf2F14Bv2PSFDSQXpq7n7fZBJANHiR0niEeq5ZgTP4k7ka+ReEyd1cAlYQazjaA9fskWSlwvzzGqlfTUOEwuSKbCjOizvXiGmuM/xIwVSCI6RuukLj8cjppfm6+cSwOTc9Q2oTqxCX2EgpEC4P0k2uZLULFWh07JXJjreoT5DWvP2pqhvM2HbbWzXHpxjyx47HyJFgPbzCBn404UeMkPzSRGsd4rnJRlP2Yz7mi1kXg952HD124zUKDHS8r4Xes8Ciz1vWvSjEEkUcgmP039MXL0bc9Vsje+B5nIiRecHx5+cIqNBNfv2WUGrXfY2LBOLy+04zvTuFrqUVxxuxV5usyn7E2rcQnKZk1H2iLJuHSoo8ZJ1CihLwEmwBJ6Noal3djx2lfavhPiuw6/o5NshhJBn/yUKRcOR00RAsSRYOzZXwNZk/NnZrpWNJJYBiKiyLdbLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261021135927099003)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261022075727099003)(261102123227099003)(261021121427099003)(261026140227099003)(10067099003)(3023799007)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zDbxGewnBLy/H4NKLhXlOy1bvTJb6dBwSn3JK2F8xT15hS6xil8qL6ZFNYpQ?=
 =?us-ascii?Q?jHNMCRR7UA6Qz9DMAeUEM47HiU1ooMAaKj90SklB+vHxm0YrOTFRMx5I3Yrm?=
 =?us-ascii?Q?1GH/OGz5ptxcmc8YO/xXpmjWCAdr7Th45gJP+3YHEj6RrlnPIziEnqW4B9Gx?=
 =?us-ascii?Q?PGMEaQmuJLtykjL6mdXOMdDRnYBxTNz1r+R7LhTcrgHUJBnh1fmh0lRbrGbB?=
 =?us-ascii?Q?V7TDC8p4S5mEMZQC1It9n/V0RpWR8OcEFvrhxtz1ssi8ujZ9xQl+VOx9LIl1?=
 =?us-ascii?Q?ZAUfpEv8mtRnOeoe+cON2y7TO/cr90NGHIfhznCe/vjDB54tF9VYE2KrtXhG?=
 =?us-ascii?Q?lsrB2xorSXmRzhs1KxsblMfjHyTJ7UCfEtV7/SC4IpWMEsk4UkQNXsNNMlsX?=
 =?us-ascii?Q?JQbpoldhCeHhgy7lSXokq0ZlVPWBvEft/9wqb4GyrjVWZP1iEZydYlbGxJd4?=
 =?us-ascii?Q?1LZu20KBaM8EwypkyDRn35WFyDAdMXoSXl1KZXtzJ03HGdW31mRE96Dehn6M?=
 =?us-ascii?Q?lHQGVaSk1py00Dn+TPFDCRtcMDGE1JFtWlPBxUDrhAOdT1kDf6FgeWe/yqBm?=
 =?us-ascii?Q?R6vAWrguEh5qLT/eWoOnKdQQfegjl5lIsr6c2JX/3RK6NgKZOrI2M3Ri9i4d?=
 =?us-ascii?Q?KEk/fjwSq6cciDmvP0xWgd+q/q7F7Dd7OCc3OL6RoAlsy3//K1iLtSOFAWuB?=
 =?us-ascii?Q?BEX5xlvLdycrizFyXDy+6wMygOCCRDXh7IJMmgzsF93RBlCtMkLyI8PD+YB4?=
 =?us-ascii?Q?mMYh99ddSX6Rej+I91sqkEaL01Ul1hBxZSrTj4lY+zWJeRJEnHqCkpivJmQU?=
 =?us-ascii?Q?C1lcaTWbBUgP9KmQwrFGPQ7nBkLMkWZwD2cW9vl7QFZ6Cf8QiqSill0mF6dC?=
 =?us-ascii?Q?oY6xs7CYVvUxLs029okLdwF6W56B2aiVIsyGkRP9nkxUBS2dLVgibHpVVRwB?=
 =?us-ascii?Q?apAfN9uB13ur00SeTNWeOnh5tgV7gdDTOZM3KNNE98cVl/sqJ1hOjKlnoYpD?=
 =?us-ascii?Q?USJnBRCFgb4Kap0YF/wl3Gqw2K2ZIZgm6tkcSqEPkaVD0WO8gbAzix8Exeow?=
 =?us-ascii?Q?v1pl3GG8F5Lf7eMfOr0Ktmn/PzpHZDRLHV6bUoqrQ41cIVLFT+jV0Tp+oNVs?=
 =?us-ascii?Q?TgmWjvFVx2CnQ1LpSrobLFXD7ES4BaoAXlHgWmsQHEiWgBSSFiY9BMUA4Twm?=
 =?us-ascii?Q?zZ1KVy2bvcJEYsipiE7OK75mq6yATBkz19WvMjuh+2soZh7UQupeUbqCGDNu?=
 =?us-ascii?Q?57GfOWFwV4z57DjLBpJT4Fom4HK2+LUIzDeCGeyZHmZInUlQswYRwrR7jYTn?=
 =?us-ascii?Q?XLq9ecTUAvLqWLmouqsKiT5pbGL40cL3SuLqlpEMH1htpChK/84AvhDGP3Dl?=
 =?us-ascii?Q?b1PFBRPXej9Ix7tDoYKFLSMJ3HVh43IwAMB07qRxkHBhLW39pGjoHt3cljvi?=
 =?us-ascii?Q?cdHrojnCrj5BRK7jSDl58mnyjWOMpTRBetqiShf7IRZti8N3EmpcPvvkK3Cx?=
 =?us-ascii?Q?aAio3Z4kZfST5ZJtE1F/USsp+ewv4HOIXftdpOOALm50IYJLLTeMpDpx33ZR?=
 =?us-ascii?Q?QvzJ2eqZBAoeKnL5J56JcQfFPhS1mPvnEnFPPbTqJU7Bo8SdImEZ/vyvYUPk?=
 =?us-ascii?Q?pM5B4vFiFwtoGmaVN6Kz0JBVLbf5/dUfHsf5O8rRLxwu662LuBCYzLn2fRix?=
 =?us-ascii?Q?rQrqyerutCOl3MJnW+GjFlWx07no7f7hZU+G+qWx7o8o1I1zCHw8m16BWOue?=
 =?us-ascii?Q?dXJJSnuRgPg9vxxKfPblIPqzc3M8n9o=3D?=
X-Exchange-RoutingPolicyChecked: T9V4yOz4nEz7SdCs6gL9qpHWYNzGAq+Nid/JQ9qkT/2uoyGURHWphTKb+MCjoqji+ACkKzIylFcvNd1OjnsBjowZtgj+cKnGo6hK2J4VXwnXeSxfMByrc/N1QfREy20KXmk8M74QjClbQIepm/YbEB2z42B9Rr3w1CchlJ2Hf0FdaNTZcNFz9KNQKizl0zOMC0kdPpk+HYq0IPpkp0OEZEiDU3KWsiwKX51x8VVscc3NP9RGriSvEMzOdisa+WkQBkZ0kn1BOUCiliiXoyd8dCy6zXcOxhgkbEbz/o2Rpr/EesPEtzCTlynltkrsvRmxMh7D2HGCKKQzpUltlCswlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e10b8508-c93d-4a53-d975-08df3a9043e1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:25:40.0799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJQUjjY+dRtoLEjb1s5r1ebDXlHxzY9AIdLsONpMYv6rWdJpKs7cLsGXlK+AOMLuAbTXt6p3MSggQ/H/rk2IJ1zgOheMGXBV+pEW+CCdn70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7323
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 04:21:40PM -0700, Kevin Bowling wrote:
> The device alarm skips AdminQ processing when the PF advertises WB_ON_ITR.
> However, this capability does not guarantee that interrupt registration
> succeeds. FreeBSD nic_uio cannot register device interrupts, so the VF
> still needs alarm polling. Without it, commands such as RSS configuration
> and statistics queries time out and device configuration fails.
> 
> Record whether AdminQ uses alarm polling instead of deriving that choice
> from the PF capability. Initialize polling on each device initialization
> and disable it only after interrupt registration and enablement succeed.
> If enablement fails, unregister the callback before retaining polling.
> Keep the shared PHC alarm and unconditional alarm cancellation unchanged.
> 
> Validated the backport to 25.11.4 on FreeBSD with an E810 ice PF: the stock
> PMD failed configuration in three trials, while the correction passed 45
> queue restarts, 42 full device resets and 6,432 exactly received frames.
> 
> Fixes: 388f0b348065 ("net/iavf: reuse device alarm for PHC sync")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kevin Bowling <kevin.bowling@kev009.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to next-net-intel,
Thanks,
/Bruce
