Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A11ECCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 15:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5664E402A0;
	Thu,  9 Oct 2025 17:52:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id C74C340267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 17:52:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760025160; x=1791561160;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=aVeQhtJCdzrzDUkAaUs9oGiSycTGr5wVa0gDCzVD6Do=;
 b=BarTy6/bX/D8V4PF5FQxCSi6eoNKUfHIwuK4tHvFmt8hmxKO1MxCn9ew
 UUnDzRj6umXp/0DVdl/2Lg9o4EmA0uclJFdxoRHTeaMfmRx38XkPGESfx
 Y9AnVLAqdOM+1W0lGQWsTlb0v/U5HEq+PAPBIBFoCF+oA7gQCbFKvYkk3
 ZsBedAly2kpaGB/NsmxNvcqSK2eYeUgmOZLGkVnvVGVE3UovCfDh0OzOQ
 3WVd4ky90Xx5mKInqtjZ73oz0C9R42kaZI0nNIQAl+eJHs+8ZW05cSuRf
 xuSYdXBv0yC8y15TMOrlt9ZAs5bdfk406kX1p6tkaHDRlMlpO2SK4/Cor Q==;
X-CSE-ConnectionGUID: nuySojx5QUOdrTzksFKCHA==
X-CSE-MsgGUID: ja+0L6/wQmihPeDqk6A4aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="61945197"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="61945197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 08:52:39 -0700
X-CSE-ConnectionGUID: ddQ4ZuKESxij3Wk/OCrFdA==
X-CSE-MsgGUID: XVHV6fCHTVCTIbQYVcpKqg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 08:52:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 08:52:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 08:52:37 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 08:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5L0P8j6xBskZpvHPzUTvNIKdySpc6AVrsmhEugasod0emcXCg51i5kK26MnT/tzO/fZVvwEEVTLX6MO8vsMA1laf+XrNQVOGkTCbr1nOdfwRnNFxixDDbkc5byzW7nqFGtXZzR4jlagOhHNK/H7nyVWAusEnZTpLaeLMNSAhnSYQv8S0GUbbE8+ryn0hVH/lJdV2yTSaY8u5/Ximw7YSzOXGuyaJsHnkav5ZuLpTzzmQ1/dXBu6EkXTeYXUHE5bdtdF49rcQuaigRS/pdHMk6kGQXa+HxABfRKlChEaaIf1JjSzPQzKAe3z8vj0gpsO1m3KHwgYKsXBYzYd60WItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4abNrLQMScJYuOUklBJ5e5So06j5+ifByrWxFKvyDXs=;
 b=Vn1GY8mOmbO35aPa//BK7U2d6F4oVPkJ9OYeWCwKaxGot39EJvd716j/MNxRqYkzQ337C72bK4gFPfmnczdjTIoAMyx9zJk9FI91zB4bn1ZK7b9jU3kd5RNoEYHle/kk9OI/OMjx3EPbJpNzIoDrxZgYoUtJbKQtLxoHgSN3FZeNJfnKma0A4+uskflcj9xKmpgwW5Xiip2Uo+PAIEJCtYhmFKSfrHeVTpl5G8HOhdbdVN9vLvvModcaoAcsvh2F4+uxnPvI+1+HN12NVhNsHzPz49WCW+n0/5JhXhFxc/MlvtnxGHjL24snGmEOQVQTpOEuVAY9gcwB/BOYcIBprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 15:52:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 15:52:34 +0000
Date: Thu, 9 Oct 2025 16:52:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 0/3] Enable DCB/PFC support for ICE PMD
Message-ID: <aOfaPY3Jw7pnPoaO@bricha3-mobl1.ger.corp.intel.com>
References: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
 <20251003124037.342760-1-vladimir.medvedkin@intel.com>
 <0eb6eb81-dafa-4f47-92c0-b83e8b04ffcf@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eb6eb81-dafa-4f47-92c0-b83e8b04ffcf@intel.com>
X-ClientProxiedBy: DU2PR04CA0035.eurprd04.prod.outlook.com
 (2603:10a6:10:234::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f87d19f-af50-43ce-af2a-08de074bdc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?rAU4nEbg5IfcsS9B+CJDQjUTF4YQUOhvctEbGw2BQGnHfXLa5/O6JaIEcJ?=
 =?iso-8859-1?Q?lSn1lUnu/1uaILbCWo799rbX2BKzPAZ3d5L3zN5QcQbo6efkKWqM+E8yuJ?=
 =?iso-8859-1?Q?hRto0ZI6/MlkO7JEMaNo4TCqjGAFVepWfi0apLp8uL7fJpFdTZ3LhK7s6p?=
 =?iso-8859-1?Q?DXiUB1SLnLJkMAmNWIMJps2HbNRqcsixt1lWaEzpXf3e2bEsqPXlDGFAio?=
 =?iso-8859-1?Q?GyBClE41j36oUZTxMdA7R7XcXpGvG6X3YXBN/nDG8GVTigFbTG0Aox78Pf?=
 =?iso-8859-1?Q?GoqSNJ/xOXB44zFmCqJf6uBsdelz/Q7vAuIl7cYs5xtRwZCFHCoJxD0WDo?=
 =?iso-8859-1?Q?GCR7LKLtynDXO62fjLC+pwqJMGlLOMBwoJaUIbuoU2lz39CRcFYhw1ESCI?=
 =?iso-8859-1?Q?tiIvvpbb8m8ytQRudJIzy+VVLqzbJdDuQgvl/vw+z5tSnxmbKY+JOhMIC1?=
 =?iso-8859-1?Q?jTCWWavuyLAntdF03n/j8hE7L7o8KCM/i2YpAFI1aaS4fKEfElYmMxIwug?=
 =?iso-8859-1?Q?lsyPaWc0RHS1ldPGN09jYkpxpbsKTqqfyE3vfQvZiCkWFKKKxkQxMD+ovH?=
 =?iso-8859-1?Q?n3aNVlgzUJGpLfzzgZPtO4vUcWvC0DJzsHxshwGqnkygwcX5ek3IIX02NQ?=
 =?iso-8859-1?Q?OTHavHhFrpffvPzh1gO7Z+ALE0sZpBGry5x56BifrqyHfCn/TJmNoKdBWu?=
 =?iso-8859-1?Q?b+tsQGaHrNZCHs9aPx/X/RshYPyoIJ0X0vxYdR9o0mt8z1R02iRbpLn8PF?=
 =?iso-8859-1?Q?y207JcD5TIGJmz3WlpJ95Mq5pQN/QTf1XAIKeOvtsLSPkj0ALhyA0s8Tq8?=
 =?iso-8859-1?Q?jiHwVQwHt1JmpZ2GuHb240E1mv2RSc/RN5FroMKPW5y6/1QIcOcv4wQ6yg?=
 =?iso-8859-1?Q?otU6LfrOHiukOE2g/+2SfhPX4l4Xf51Inf3/pG6IjCNOnUleOlWA/XKxk5?=
 =?iso-8859-1?Q?R+KVocx0qIw5GpGwvf71xwuff1I2qBHEjFLpS4TbCDV53EoQlmB3HIdyN2?=
 =?iso-8859-1?Q?wzoGTlP3wnADKG1VAzpvNXk6W4150jZmbZ/VlR7wdW0xQkpnlOYLBMOzNK?=
 =?iso-8859-1?Q?JjszysIdmrKT/K+x3PqSQnTMOm5/ktIFmijdEHKqHzoEyDnXjI1EumOPEX?=
 =?iso-8859-1?Q?v+bzZaKVlbAf2D2ymlwhrR0PqE06vA2/qPpud9G4hcvN4+LL37K+wGZ0CE?=
 =?iso-8859-1?Q?VwGJOepqvWCUK10BmmzRfuuuFaRt1rxygeV/JPFqZNJ6RuwRl7NvFantSY?=
 =?iso-8859-1?Q?5/jdqdr+2bwZzcFS8z4JHYzeTFLlHAPsKYIzwV5q9A8TDtwRl0irkNBK1e?=
 =?iso-8859-1?Q?o/PYUG1dkyckvM1B3mY1UlOXYUGyrgxZ+FXVYVTqm/4JtIgIVYaUXVqdkl?=
 =?iso-8859-1?Q?/pwcVNUwYgFCPL4cAhqMfkV6bne9vJ1/Q4+gYQNbQApD5rParHHPTQx0UY?=
 =?iso-8859-1?Q?rKfVjKVDeKHSA+ZMWwHVNtTFR7PYsiDX3ThCcjxdGCtXK8dM+XqJO5bugB?=
 =?iso-8859-1?Q?5mNDGVahHjbt3dUADaVolZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ERCiFpDO7L/S/lh10XMkET3OGllOZJp0fPSe6V3DZcZZyqbd2HPRSrTnPg?=
 =?iso-8859-1?Q?OfleFEgoQ9BFbzQRGkI06ZQn6/4KPdki5mvrxx8lrW0nCWK3kOg6SeDv/e?=
 =?iso-8859-1?Q?gWA6Anr/iWWUF5524N8SpYeHeqAI1KPAB3cjThSmUEiC5O0Qe0zq7Ax/C8?=
 =?iso-8859-1?Q?8MX4xRZ68f9UpPBKLJ/WWCUi5NPReDavrt1+7hmVgEexG9bSjeyLIw05ar?=
 =?iso-8859-1?Q?SNuy8ZBYWzgoIy4EpJJW1hmKmDeo0/UQbjar9Xi9oSjdOTlJUc+2OiX8a3?=
 =?iso-8859-1?Q?yZQuf53D9VawvPnPcv3PfqT0shGDz7l3mH/5ezBkr68OGSuiJpl39zsEIc?=
 =?iso-8859-1?Q?mEpqJVO9K4sDHf8s0K3Hsr+KBMBSBCKltsCz869rAlB1PVDnLn8SovK9b1?=
 =?iso-8859-1?Q?+nYPmUZovD/RET47+tMWCWMLgo0ZLYZfLd28JnAIF07TGLF/n7zobIQ4yQ?=
 =?iso-8859-1?Q?7vu973zjSe8s9iewgIUZiEujnCaVDid2ucrN5qQF5ObUYIEk2HtiMnbf50?=
 =?iso-8859-1?Q?Kwll28pS7xz5XrfNP8syohQR+DcUWL3gTvcqOL4VMbucktWNXbx7RfCAdV?=
 =?iso-8859-1?Q?SUhzDnxlTtL7U72BT2vZeM6HnZdn5iv1ts67CY2uOe6Y9fLzpHNRSFFbpS?=
 =?iso-8859-1?Q?aBdfnu7y7FzgYRDr7F7CySO6kNUKsEvTf0s+r0Z1IgnatO8h6xYf/pgYmq?=
 =?iso-8859-1?Q?f5Wc1HeLLRYvOp4MlBi91Eon35DtrHpylt2uHYrGwhJssVQ2QVziwwiHVj?=
 =?iso-8859-1?Q?xFBLLcLPlk2W2ioN8QjpZi+hI5VhG+CmmwjoVUEF9El7/mxAaBJjJYa5C7?=
 =?iso-8859-1?Q?mp3FDB9otTx5LS1s1ZUmKnxVmoQAUT+H4q913fEIP0E6nkNFRE75Dj0O1P?=
 =?iso-8859-1?Q?5MaWu7atMDqpqDvcT1zicQHL7gxkQIvNDaxFoC5EMu5tQhPi+H8tnBp2WO?=
 =?iso-8859-1?Q?VGK2Ffp2frWcwaArFmx6rMq8+ST4o7xFvUQSVmJBw7TTGWwYiWhn1/PThi?=
 =?iso-8859-1?Q?HXcFbjVbUv+6iGoRvWFheY5tNtFfAVTnKLEO1HGvAzyguSyfhakinZaR9f?=
 =?iso-8859-1?Q?3kZ2D5UPmHZ+WoxeiILDxkzI2GqG2lF9mcSZu2GsXbm+OwXS9tjZ3LR1j2?=
 =?iso-8859-1?Q?uWZm3ViVGsea4HPlU16jykW8xyv/v60NXTtUB6uJbeE/EiDjuDUYF1jPxz?=
 =?iso-8859-1?Q?s3jUoZ1Jk20tpHHixEVHmbMQLDD5mZ+NCslt8DMBEWrK97kOmt6a3aoshC?=
 =?iso-8859-1?Q?a3AgN0wLMnnc2K8tY//CYa1GU6pZjm0RLE2F82kR1BBzTQFAJWNSXmMgIj?=
 =?iso-8859-1?Q?EecQQT2E2RzjyMOfU2nukbyf+4LpHK14ZYBe04XScdYI5KBRKdBe1496sD?=
 =?iso-8859-1?Q?SkokOnvJDta4nPU/JzHD9apkdXAoxPya7eCQL21vGWbDBuUEKTJoa0PcqR?=
 =?iso-8859-1?Q?HSXe+v3+UMpmUBAIwV4Vo/gH7WmGxmIM3OWaoOWGVNom0gaucxsO6Tck/r?=
 =?iso-8859-1?Q?kqvXBKFaW8ztmQTTCGSLtff7Oin+abkDTSNaMTxBCFuci7y/Y+o7hN5wgR?=
 =?iso-8859-1?Q?Sxh5e3R2pumb3+Gs8rKqGxIIGBIXPZX2pLSs5OUOHABnH9O7Iy8lYdh2K4?=
 =?iso-8859-1?Q?IZuL8m3+NNs4mTK5cV8+yP8r8Tt8COsFDwhjfS8ny9j3kbS06toIQXoA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f87d19f-af50-43ce-af2a-08de074bdc79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:52:33.9600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Jbj2ZJG6fQ0QrWvVxI6U1m3HHq0kUMtIyB7ofm1uP6JBgoMyVNrGjkKZpUnVamlk8AvVE4pGM4TUtWoF0N6LC+3qQZoFBo1wUdT/jP24/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
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

On Tue, Oct 07, 2025 at 04:05:11PM +0100, Medvedkin, Vladimir wrote:
> On 10/3/2025 1:40 PM, Vladimir Medvedkin wrote:
> > This series introduces an initial implementation of DCB and PFC to the ICE PMD.
> > This includes adding support for TCs in ice_aq_set_mac_cfg() and asymmetric DCB/PFC configuration in base code.
> > 
> > Current implementation relies on current API and has a number of limitation and assumptions such as:
> > 
> > - Symmetric DCB configuration with respect to RX/TX, only dcb_rx_conf is used
> > - All TCs are configured equally with respect to BW they share
> > - No support for Low Latency TCs
> > - All existing queues are split evenly across TCs. Number of queues must be power of 2 and be no less than configured nb_tcs
> > - TX queues assigned to TCs the same way as RX queues
> > 
> > v5:
> > - drop base code patches
> > - rebase on top of the next-net
> > 
> > v4:
> > - fix more endianness
> > 
> > v3:
> >   - ice_get_tc_by_up() is renamed to ice_get_tc_by_priority() for better clarity
> >   - added ice_aq_set_mac_pfc_cfg(). Old ice_aq_set_mac_cfg() is a wrapper around a new function to keep better backward compatibility with an old code
> >   - removed rte_memcpy() and memcry() with direct assignment
> >   - addressed various style-related comments
> > 
> > v2:
> >   - fix spelling
> >   - replace rte_memcpy with memcpy()
> >   - fix endianness in several places
> > 
> > Vladimir Medvedkin (3):
> >    net/ice: enable DCB support
> >    net/ice: enable PFC support
> >    net/ice: add PFC statistics
> > 
> >   drivers/net/intel/ice/ice_ethdev.c | 370 +++++++++++++++++++++++++++++
> >   drivers/net/intel/ice/ice_rxtx.c   |  21 ++
> >   2 files changed, 391 insertions(+)
> 
> Recheck-request: rebase=next-net-intel, iol-compile-amd64-testing,
> iol-compile-arm64-testing, iol-unit-arm64-testing, github-robot
> 
This patchset looks generally ok to me, but the CI is flagging a
compilation error in a number of builds with older GCCs. It looks like a
false positive to me, but it needs to be fixed before I can merge this.

Also, with the addition of this support, I'd expect some documentation
updates to be needed. For example:
* release note update?
* ice driver guide doc update, perhaps?
* driver feature matrix update?

/Bruce
