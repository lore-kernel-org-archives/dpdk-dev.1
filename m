Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79773C021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3C6F402CC;
	Fri, 21 Feb 2025 18:10:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C916D402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:10:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740157836; x=1771693836;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=blJ5zYB4eWT4nPA3PK4kJWSKnyelML/gZYaKcVvydh4=;
 b=PrKI2vJo7RmggsPDHEQSdElOHTpjpn06wx/BbTiR7lxlojspagO49ROh
 J+sxNn4O6ATwH6bB47AN+dqP/UiTuN03vOaPGPDxHCcCF+Hc74z1cfCL9
 kXQcIPymHCDkcBvpw77e2TyyuqAgQEfsNHEPFlsjeg88IsIzTcek3/TyF
 +LSWeGDAJRv/d99cPpJJhllNGPfjsj2wVDv1bcTqzj7RRpnudcz572Cf7
 1+d/qU0NQpHNg8uRo53Qqm/4IpxCpY/0nuRx3ZMPXdGIiKWYqI72umXbl
 OcWF4p/u4oVdmBA1YGqabwIsh2cKATIjjjUM1nifZg9oeDvBtHMBQfao3 Q==;
X-CSE-ConnectionGUID: YhUQfZBSTGaoK3LFmGAt0w==
X-CSE-MsgGUID: 24r8VxxwTA2aqOzme+8Nqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="51973988"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="51973988"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 09:09:58 -0800
X-CSE-ConnectionGUID: nul/QCInQjCILWaKNPh2BA==
X-CSE-MsgGUID: 3/WCjF15SuOiaobVTKIDPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="120347256"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 09:09:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 09:09:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 09:09:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 09:09:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDfCkZZpbMgdMlD+LpxQKULkQOgMVko0gKpgMH9A6TDI6GK6ZrLK4K3mx4D1u5CH4NxLh2IZBmgnRZjSvKyEX+BgzhHUbb8Bvv6AOLpKfyzsYuxqSpNz1A889vWuobQUZPfxMDMM23IjeZrYl0V2XMSD1ivayWCaiu73iefYX4VogIEO8DG4UeR+talMRBnQwo1LNkNu9IoJXJywb8NSAe9m5k4tSUJWe+hMNKLEs+eQV4CjlZbDUIlpk+HICg5xLBiGHgUXeykONOE95tTJcv4ESZ3B0rjmPYwcIvI5wJVEoC8bhYdckd1mrU1U+Q/PVtzQNPLN35MMQQB6YdEGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVDRjlsGGTWPky/lD5keAeHmXJ3aLrUkoHpxW8DIUjA=;
 b=mGaXvkXyUTFUuDe1niNrUKXvS691fTPsr/KWjN3OwDQnXIpK1V4RqnDQhCaEcbI1j25AzWP+ZKDXVeZflXVDzknfzSVoMnK//e5XlqTdpbvPu3HGTjRpeyAMcLHUjlQi3+2TbXnHu6mpyi4Tbo/BRLj46HHNQV1JBGu9rmijWH5ctZ8hU6aelKO9FuenumZ/WEE/9oIRFiQ33YdmERR8Tv+fUgqgTamI1nBnqka1tuA0sR9OOr1fwqQsT+s9HyeVXxz672MRZYJV/bDxzXUxmPUU51LuosaHlNwqhfUEcUVKJqXYNlGh6cD5BGGidwnaFenTDRjihT5h01wkvXZxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 17:09:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:09:54 +0000
Date: Fri, 21 Feb 2025 17:09:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Ian Stokes <ian.stokes@intel.com>, "Jingjing
 Wu" <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>,
 <dev@dpdk.org>
Subject: Re: Intel FAST_FREE offload question
Message-ID: <Z7izW7ckMhzb1jL6@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 808d0afb-3eae-4a20-d7f6-08dd529a8f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?0qbJbvbYDJTAoeRDxYM8wJipBaTEs8QwE5fnouFIJ6dpNtqHOrkja4A1CO?=
 =?iso-8859-1?Q?pF7nW8ivK2znFOEsqCl+/ht3Y0LEGqT4MlRGsSkJzWKPupEppz99qPDlrI?=
 =?iso-8859-1?Q?Z7vSza7kLEqpmPn+gQA0XEgo5pd2fKfCJIOQKOF1f/+A7DRlurJA4XONsi?=
 =?iso-8859-1?Q?3S0kqAIK8yqcaBEbMgjrgvQ9ZKF7UG8+ly3Y3eg0HtgNcIXUeaM7oVBvqg?=
 =?iso-8859-1?Q?AVUnPXk8SReIr/wuLnWPCUVnPbF0yN0St+BhBor22jeJbMDTv4mGMQmrA2?=
 =?iso-8859-1?Q?9JBhGh9I8m+XelkSpC1DfbCshGXoa/QzlU6fiA2rdzHe3r/0WOReW9qb0I?=
 =?iso-8859-1?Q?+Xx2KUv0gR6c48jlhBiYirQpPmuY7KVOsnPTzKjuMNVuS0dLLy5rchvOwA?=
 =?iso-8859-1?Q?slKJt+05LZ76wGCT9gjUHVFiIVfNN/mD5tm718CX5z2ehLtH6qG9E2Yvj2?=
 =?iso-8859-1?Q?UEUCNNOO5i9vM5ortiYQOeUMxN3ZCnmbEJg0RKuOflGsvHi5Shr5Bep/rE?=
 =?iso-8859-1?Q?i79sT4fLfV13Rs7HwzfDC7qy0xj59dloYU9oWWfsVsQHKsChfBQNzEsaKX?=
 =?iso-8859-1?Q?oAVhrrQdek2cPi4dKRoDj8bmfgKKQEBC2zMrfX8L1NXvYgrQvtST15imtm?=
 =?iso-8859-1?Q?8iGi6rjibNDL/6uf0sGoofF9g8I5lNNQnEzZx6iCMsLZgK8PaGKBd3uWnG?=
 =?iso-8859-1?Q?dGFh4L3Rzs5wzcSFj2fpd3zEzAy+F3jd0R/iIsOKKFHGJSaX0Q3zqb/daq?=
 =?iso-8859-1?Q?lYV6gQxJY9rKpZzgxhVVjujFR+orxvBWttQmICo2Wc8NMPS5Euy/upVc82?=
 =?iso-8859-1?Q?0M0OJE+8MNGh9E9Y6ZY0vJqOlVLJZwdkQhcH6ezqToP+OSyZVPNunw3Erv?=
 =?iso-8859-1?Q?ZmrTgKFdGi7BqsHOGh/+7NTHkgmCVx3RsBmNVb5k2c4R6tByCSQ2YxVMn+?=
 =?iso-8859-1?Q?mv8gow7l5e6ZzVsjoKLUbbSHKdG2UhDjRH2PDmPVacNoozlR+M9D8sGpOO?=
 =?iso-8859-1?Q?UGdCmmxZcBY78GDOR0+UX/uH7iA7r3jA1YsvdmeKHCCxpBkHdN9z7RjbZ2?=
 =?iso-8859-1?Q?QGnDZKVTAlzIHTxEYyIgU9gXXJFKzT5SDHpBDM6nR+jduhhLIcTMsSOduq?=
 =?iso-8859-1?Q?AT5LZ+O4m+/sSKd7u6HlO02rw0YD5CN6gnrFSmkIu6Cz/5HzKcAf1dWkde?=
 =?iso-8859-1?Q?2HKpH4Xzl/lpp6zKtaMHYU4maUncdleQAFiBrZr6z02Hz/xUv38z8xTF6S?=
 =?iso-8859-1?Q?Pgneib7Ttpagtpa4kV1em5hyovLybF+nYePRc8JudKGWnNCTHbjVsHGUTJ?=
 =?iso-8859-1?Q?Uz3yfEWrPWOjIIYZnHLZcctXVR7T7diX4Xms7vcpjEyYCBIjbvgqVpmf5J?=
 =?iso-8859-1?Q?vfMtWF7Xs3x8WDVJAu3aYyenm+/ZniBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5Nww8mcwrOF/x/RKdfTVN7/3f4JEJcoKKRiZH4sJvODT1eArvumoFAJj2W?=
 =?iso-8859-1?Q?rGlgy/0K2PEq3kUtom2HOvy9vANywDtXBPynh8yZJwSoCMvLjqsVPaUZ9X?=
 =?iso-8859-1?Q?AofvE0mqR8MjRaJCVWjZPDiqh/FTnRMP1UeCbI2HqyHt8sDBNWnlJFDsX4?=
 =?iso-8859-1?Q?zuRL6ghXXPPNB0GqdlYqdFuO5f6iLeX2v7OSh3p6/sJvXYxcmU+tcCGFsB?=
 =?iso-8859-1?Q?OIvk7WwwmUbXumT343MYMk14ou+4l4RofQHdZiLwhe6ncjaA+7Nv2luutG?=
 =?iso-8859-1?Q?NGeK1gOuy+96bYilHasuBvXw2VJfE7BHKQ47yxYlePT3ydme/BENT2e0Ax?=
 =?iso-8859-1?Q?sqrwUNWtypNFIxNjY3dCszIMP2QVuRdcv5DbXBzRUjcJ8eC7v8ZQzivW7O?=
 =?iso-8859-1?Q?Boa631qloprIC6Ei977DJ1ip8RPifZ9E6B+ucDcvS1ZLYUYWs5DwZPLMe4?=
 =?iso-8859-1?Q?mRCZcL9qlpf2O7aNXoIVNg9SJuaDgDXxvP4JeG8XSdp2/WXdKpEWyeY7s0?=
 =?iso-8859-1?Q?2OQvVuWxEg1kO6IjfL11qNxus0K5ij8GZk/GvvFTDtf5v42Vm6HwszeDUP?=
 =?iso-8859-1?Q?YeDkY9i6ifZi6/HxNGq/VPjeRZ2KcuzkcRE1xhPG+dZ966ImCznh/UZIgr?=
 =?iso-8859-1?Q?Xkj+Ol9tOegEA1oduPpByjcZPwnAFleL0xuP4eIpLTlP8ha4Z7sJXhD6RE?=
 =?iso-8859-1?Q?C8g28I+T7JvOmvatocTrbqi9mDE5zNNbyKXhm/Wu8/r2vcfQbEq3lT/3Jk?=
 =?iso-8859-1?Q?kvi0zty75Ph6tNSn6nSGVz+eK7dB9mFMhx98HmKo0+MD7LMntjw2SemQkY?=
 =?iso-8859-1?Q?ltdrldnJp0Pkr6F8LUENtNx3s3wlCMzDglTQDCFrf1NiqNGWqOnfGVbVV1?=
 =?iso-8859-1?Q?J8ukImI4jbQtmtUqBYDfrBQmmjsj5fl4U+0L7Dz9gif64bivUc3n2O8GLo?=
 =?iso-8859-1?Q?IvRZzoD3u8GX5R3rfiM5bnWG/gFqyXwQo89gaPQsfhDreGr5Iu7IY7db7F?=
 =?iso-8859-1?Q?FeMh0oRiRNngN1iWa5CTSpvH7uMlGZWmmwj8msPTtJXSlbA/lx0iIIyWf/?=
 =?iso-8859-1?Q?0tamLOyhtc/T1VlW1teQxTfdTfNF10iNEIVEdXRa1v0S0EAYR216+r7tOZ?=
 =?iso-8859-1?Q?6gnl8Wzn2CTsidCHknh+8OwP2X8b7Q5+XgnH/o4Bqs4SoVJ8Pj4fwYMC40?=
 =?iso-8859-1?Q?thCcV8nhO/+rQvcDVRESRyjOHfz0cDPiOPGLcwbPc/5z2xN+QTptMHe/U9?=
 =?iso-8859-1?Q?Sw+YMCWFkHZhgLnssj9gnjBCNzSDHxfvbqgyLnqDnBDfKdvDcGY1SMeqbE?=
 =?iso-8859-1?Q?M+pTP/ZJGatqMuO+8vtMcfQvxfP6cZVRO8atUGxs286z9nv9hTGhfn4Olo?=
 =?iso-8859-1?Q?5P9LdtqiJjJlOuVp06Nez63jNGVfGK5RyhBiBFlKLmTCTDOFs25qdTOeE2?=
 =?iso-8859-1?Q?pWDrHgh+TYzYYcx73DMFHUWbaTeUwd5xXhy6nJQZoWW4eC/IbmPzBvdMTB?=
 =?iso-8859-1?Q?zg+5TD4ohqR9pnX8Jmul3CDf9bSq+GXBxD5FszvjhDaR8kMEmrbWvNE/FM?=
 =?iso-8859-1?Q?bmhvA2M+j9IPytPae0CE0yYpnmlOqVhLmwC597IprjkQwZYHP44vTCrp23?=
 =?iso-8859-1?Q?RipU98gZ7AfvNKBlMo2VOoNnBGnSSO+GcIiE+ybQ/R9mYFblRhu4ul+A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 808d0afb-3eae-4a20-d7f6-08dd529a8f34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:09:53.9407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT0ZjeBzRiAQJUWkk/JHTCVsGTqGydqWEJwyh/SDzL7v3FOWWvReEuU6qT6H73IEsH5RtMEboq9kBt/RmgFDODgre9t5eVEu8nvDvhUR4CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
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

On Fri, Feb 21, 2025 at 05:58:21PM +0100, Morten Brørup wrote:
> Intel NIC folks,
> 
> Why do the Intel network drivers, when using
> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE, fall back to normal freeing when the
> mempool cache is empty (cache->len == 0)? It doesn't make sense to me.
> 
> Example:
> https://git.dpdk.org/dpdk/tree/drivers/net/intel/common/tx.h#n146
> 
Good question. I suspect that it may be a bug and that we meant to check
for size == 0 rather than len == 0.
