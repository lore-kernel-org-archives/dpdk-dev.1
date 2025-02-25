Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B8BC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 09:07:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72E9242D3F;
	Tue, 25 Feb 2025 10:07:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8AFBF427D0
 for <dev@dpdk.org>; Tue, 25 Feb 2025 10:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740474427; x=1772010427;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NorSjNWS0Jp7DPnf0r27a50uXB8eIGQb0RqaqLP3cnY=;
 b=IS/bnOOm51KwxN0l618hdL91o83G/xQyGWn2UqCHKRvAKI7rCCsbQ+ro
 hbfvt/n/06+hlU6wlel1qMbmDvujZmUn1WRPFJSmp5JFX3JXDMJcZPpl+
 Qnb/ow/JYxYB2xa5p7hTwF8iK/TsGiO+LSFlyBIwFTHGoWO5KmduTk7gR
 m58jRAcXSkepKZcSxadMWGFu1xpMdJWHiawjfnbW5VlJc1Fu5XPz5NbKq
 DHuCothyQtco8273dN/whZdSfcErkPi/qe42MLpAokFiftMyDQhnpR0HC
 Xg1sp8nztBpTJZoX1lJdhTKRpKU2U4DXCoB0PxSTfdp2tL+4o2Wr0Ka07 g==;
X-CSE-ConnectionGUID: QKMiXmPWRfOSg0X5A8xpWg==
X-CSE-MsgGUID: 6XPS1Qs0QiizR7fOVtD4Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44094620"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="44094620"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:07:06 -0800
X-CSE-ConnectionGUID: 6sV31Ry1TWeDn9QOuyxrtw==
X-CSE-MsgGUID: znAvXAfCRzKSFRx9LFPpmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="116529063"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:07:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 01:07:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 01:07:04 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 01:07:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYHESr8jAqKFjKZ5BdR+cLEkhRp8o272Gj7mW6O/B1+OGkodH9ujoDHsDWSKWB0TONfQYeew8rxvYUur0D/4E43Nn36JWM6V4giRIg6zlGYbLGn4TJkEgZC5v/2gfoO9bEjxC6IBaPBTbBd+WrXRc9wtIfy4EUh2gxq8faMRomTZilUSFLIDw9yyh3luG2yG5mlP2zlWzpVD3QBwkYcqVuclDTYNk9rwOrXfwm0slXu4cx2/PpTtwvebe0IAqDIrtutspAj3ImUkZU2CNOBHtwuVdiiy2gur0fnGthwDGD1f43XkJWheFkOJBm+t1AoHEDHyTfyk+p9ZpY35y5Iq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vvVaF4D2JnTU+LPBP26tyJtgQFEVKwPUiifgYTQD7A=;
 b=xgjm+kSZQdEYKv8R1heWUFb2EbrLDaazfmMa3JpjkfidA/TPxd3XZouLAK6m/Mqbyj84jQwLCYEC4PXzlYc3cTEkU6TO1Oiw0af70rChMJcadO8TJk7tXvDuY2O23bECyKAnAvyTosHnG198bMMiNUtB+psO8SsiXDi6eLwjFvvh+vuN7CHosF9uenI26xVtIiEX6C4lT4YWmzozMyzyJ0ErJlzh79RODZvbZ4IoNbzNWMH1ytgBrErCjIyxXN5Y67oqG3NxAUk2of/8heZX3RYs3nhK2ECStfPQdB7z6FNTOV5/Iq4BhGr4KrdWG+jW7Q2Rqq4Zq43yn3ASSjsx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:06:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 09:06:32 +0000
Date: Tue, 25 Feb 2025 09:06:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, John Daley <johndale@cisco.com>, Hyong Youb Kim
 <hyonkim@cisco.com>, Ian Stokes <ian.stokes@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Chaoyong He <chaoyong.he@corigine.com>, "Vamsi
 Attunuru" <vattunuru@marvell.com>, <dev@dpdk.org>
Subject: Re: [PATCH 4/6] drivers/net: make compatible with instruction set
 updates for MSVC
Message-ID: <Z72IEgZuYJ4JbCZO@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740430879-17874-5-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740430879-17874-5-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU7P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b066919-fa33-458d-951d-08dd557bb26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q9EarpXi+4UnIt+OgixnFQ1AXZbR1J3jt5tXz1GxJIxG5EJ8CaALRfzyeieI?=
 =?us-ascii?Q?kwoinbO0xeX/zCpa88VTrUq7szqSEExrREKwO2KpzvL8tsOsESzp7j6RpJ6q?=
 =?us-ascii?Q?W9Y2+5v/Kr0WUo1ufWhV3q9zvkltYXi/usX1MvRYUT9u6Jh50n9td7Jqyj24?=
 =?us-ascii?Q?dTVmhWMCcrEGuO9iZTmBgXzXGltFgvcDj/URtkBNX1a2FCuNeFyaPxjcUk2x?=
 =?us-ascii?Q?XXFpjwL9N57qkvC+nn/RYr/0f3cEe+sw1LEPVM6Dlc5ozs4gq8JsVFHB4NPY?=
 =?us-ascii?Q?J2OMsK+P4LwAChp8oJPekYQ2NeCu/W2zJvCuc91F+4/Pm5vumdUUW8VHlaVo?=
 =?us-ascii?Q?AvyQ+9y/ZZnrTaUXxAjvk52Xl3nKhH2ZUJCFjSZqHhAlaS+GxKtAM89CSi93?=
 =?us-ascii?Q?uQSom5ZAa1PND0edUO4oZ8+qQDnpM8ev3KxPFTUA1yzHgdLBTiXHy6pkCicf?=
 =?us-ascii?Q?raaZkP0fi19sXhsDjvw3uZFwqeIRA/l5vAXmU40jEoxR3pG3jnFe305XAlrA?=
 =?us-ascii?Q?6l0Qru5UQ//sVgwjxUKFqrQp259Flgd2+3vqmymkwYlo7OJuMyBG2KpcKjEz?=
 =?us-ascii?Q?l66zUpRQ8GdYgHfpsWbas8crNTc+NwVUKHOMaH3w/tYATuq5z71j07Nymnqf?=
 =?us-ascii?Q?fjlFEbrViQ+1pWkFKC0ADwaAzEbzGj9tP5Us64RDpmuQqffuiZi9QSviUfgg?=
 =?us-ascii?Q?8WHrQdTI/Uyw38rl9l6nu06EQX+X8+1ru0OXaDY6Xmtoks4d0jSuOg7UJD0n?=
 =?us-ascii?Q?muqEKwwo4h8DWL78Wu9EbxhVaFDnJWl0PwKgQL+pS0q0wcq+pMmNvE9kxCy/?=
 =?us-ascii?Q?sU2R2H+LZzcXyvi+E5hzyz0p7Ra/6qZitedMnK3ZpuO7MlNGLJz2srZFVeH7?=
 =?us-ascii?Q?mHFRGOrGCusp7rlZHdzfXkOccZDvprE1ivdW6rcIa3TJO2fkWqHF9kq2i6IC?=
 =?us-ascii?Q?zzt+YqVbpDMk+38hNFpQ1KFtAq5pnvJ9EPnVUBDXm2pRxXUsO2ntrx3ghdy7?=
 =?us-ascii?Q?jc3ys6Y4ll0IUfugf6cArPnUFDYwfYKp+M9pP5Eb4Cb2+G3TwSKiQYVcz+kk?=
 =?us-ascii?Q?nO2UJutVA4Ortc4FxJSF4bfni0EvKNBzL+rf3SHm2jlIFTECysXtqTTAMonI?=
 =?us-ascii?Q?XUv09vgdGyH/N7lZkFKB0sfiSY/qW9T12aQ1O8wx8uaCufYq5nmYBS/TfXyg?=
 =?us-ascii?Q?QMBMCpVoLxCC7G5TqAZogNhCl5ux88RQ7oosTlijP2AV7iWglU+9hD78Igzw?=
 =?us-ascii?Q?VvE2K9b29EJ4gF3BC855D7Eeh/871ksrIoy0O2ob8+tHOdh1sgVc8gwZx0Lu?=
 =?us-ascii?Q?aOEqWa8JbTUNXxN1Ha29i7/hEtGtYKZWgpFWtlyAf/9y8+2wrB0I7969LzFa?=
 =?us-ascii?Q?C+uoxDiBva5cNb2MCS3Y8Z22lBK2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1VobqCl+xKToKNxAyxoKDYEUZ/BfE4N8yJlMJV5/W3Vg5hquqyM//evi2uM?=
 =?us-ascii?Q?GT5Q1U0mfyUSBX2p36eskc8jn6hh/x2N5ilhl6nmPQYtqxsHuvv+uPrQ1Bgg?=
 =?us-ascii?Q?FdF69bYKWDkQHU+9gLmLcl13xJ60XUrIi2AnI7uDS7/LseSIj0tQ5evqiDJz?=
 =?us-ascii?Q?7SFbw+Vp48KLDOB/rqX8GhIdS3ItWswljPybptW4hB1SLlGkkFPXx7Xcyakk?=
 =?us-ascii?Q?f3rJkEIDPXA//sropNcV75PA4vLfJE6dHBs607vkefYQTXw1v0bF/uzDJn/q?=
 =?us-ascii?Q?CYMv31rpOMB+fgQQnEwVHP+srPzYHMlM25kUy6IpURQr8gqnMlTDYEsS/g4D?=
 =?us-ascii?Q?1Uwoh3qeo2oGT+jZaclYIhWwXRcf52hmlLS8Q33S4A2rYBM+ZC8zIk4hkPNq?=
 =?us-ascii?Q?rTHv9YlnwPdQiebpHA//9Rl0cwJo7wg9FbNRBn2nql0+UsQTaqL/zANRY8s9?=
 =?us-ascii?Q?sLGo7BQWpdXgifhRFNNSEczRGfbi1wEkv+2ZWVrO0md68vfUACuJTC+7dfkr?=
 =?us-ascii?Q?7nVCsma13DU1bM9vaBTkWh98PUay4wslCVdHn21uagTbDp9wIaI7KZZ6FfEE?=
 =?us-ascii?Q?4BiE+hchkJ5Hx6ajeRQPNi2B6Kc4oQqlQA2IHwcl5tLLCgRzzNI7SfSUttvA?=
 =?us-ascii?Q?wr8RIrfIa1QmmXAlYK3p9tmh6vrdAsVocqzwR5ER5dwJyQXkrt2GfP0i/usR?=
 =?us-ascii?Q?iEo21b24XOAnK/jHnFGZrkQyyyXOEYv09A89E9uJxkwGBh6rKcSCc77ke9ee?=
 =?us-ascii?Q?tyPtxBfanVSUvxQhH9U+bOsh+mCYV0WUO24RIo/I2SRFdhI4aDjMgzzSZWU8?=
 =?us-ascii?Q?ke6+NtxKbNScfsNPkw3HLDSI6pgLlJVs8Kf8C9Wb9aaQRTxPKuC1hi+R0b7Y?=
 =?us-ascii?Q?PPqkIyftk7EgqO+nKcyFuhwobWJDyOFjVYfrpziUMEThcz5H8WWgAp96TQ2L?=
 =?us-ascii?Q?ELeDlHv2rSXyjLhul6EouudzqFD/qbTxBapiIhtaeyLsW8eDHmqsJBuTyfdl?=
 =?us-ascii?Q?FrLFkwIIpBjL4+zvVVfDhBP7CJPcVRkDLYjChZUvBYhUMewvgy8nv8GeVNuL?=
 =?us-ascii?Q?Hk316Fdn9ANZJWyrGwn7DwEUlJ4TCS7n3Eo7vY45P3irUA0eMqicicGUXFkX?=
 =?us-ascii?Q?adXvVUWHL/TOzHGlIPiOlh0enqXtoaw5I5xtaK0eU7gLVKPIIn0VXdpEwE0R?=
 =?us-ascii?Q?RLV+74zBIaF6MIg38lLAUX+Ke5U3mTxcCtJi4XI6hs+vnIuNiZxryS5c9tC9?=
 =?us-ascii?Q?wjtb9Uuv3Gci3EiHjQEzwYda3055+vnewOAu0IBSSptjxD1hXt625sd8kczW?=
 =?us-ascii?Q?W8xknq8bPiP6P03KbTSIaT2PvPTvr9OY6lFfUlpB0F8+pDqpClz94k8XWYw/?=
 =?us-ascii?Q?u+KqficXKyzjk6rWt+OilHtRL/WAPwadfXCCQVnZjUQHXzK30UoGiUsUQZVE?=
 =?us-ascii?Q?WQ1Wj2fuW94ag3z8VM4VWh+ETbhovYhk4oOyPhxZZ4gsu6+WvC0JtOViJMFR?=
 =?us-ascii?Q?auky/eVt/kVX0bYrYMCOWxX946zdX3XXOYPQOCTcojZYLbw0G0uZBKK2chzW?=
 =?us-ascii?Q?6/Gn1zb+iJKDqjlr5QCq1c2YQxX3xxp6foBTITz2jAAtqNNBX6AF8sQV5zOv?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b066919-fa33-458d-951d-08dd557bb26d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:06:32.1825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVv0G2jMvH7DcaIEzmKMAdcPIe0Mz/uqqB2oiks7OzZwelSqQx7dR4gNCVFRGlDPZfeUbDS/ZmplCExD1FqCXGeNju8l49SJsiMjZi9B7PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
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

On Mon, Feb 24, 2025 at 01:01:17PM -0800, Andre Muezerie wrote:
> Top level 'cc_avx2_flags' was created and holds the correct flags
> depending on the compiler used.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  drivers/net/bnxt/meson.build       | 2 +-
>  drivers/net/enic/meson.build       | 2 +-
>  drivers/net/intel/i40e/meson.build | 2 +-
>  drivers/net/intel/iavf/meson.build | 2 +-
>  drivers/net/intel/ice/meson.build  | 2 +-
>  drivers/net/intel/idpf/meson.build | 2 +-
>  drivers/net/nfp/meson.build        | 2 +-
>  drivers/net/octeon_ep/meson.build  | 4 ++--
>  8 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
> index e26cf13a65..fd82d0c409 100644
> --- a/drivers/net/bnxt/meson.build
> +++ b/drivers/net/bnxt/meson.build
> @@ -65,7 +65,7 @@ if arch_subdir == 'x86'
>                  static_rte_bus_pci,
>                  static_rte_kvargs, static_rte_hash],
>              include_directories: includes,
> -            c_args: [cflags, '-mavx2'])
> +            c_args: [cflags, cc_avx2_flags])
>       objs += bnxt_avx2_lib.extract_objects('bnxt_rxtx_vec_avx2.c')

I like this change, and the consistency of the variable with the equivalent
avx512 one. To simplify getting this patchset in - or as much of it as
possible - can you perhaps add the cc_avx2_flags variable earlier in the
patchset and make these library changes to use it, ahead of the complicated
changes in patch 3. I think it may be simplier to have everything but patch
ready since they should be easy to review and merge, and then we can look
at patch 3 standalone. WDYT?

/Bruce
