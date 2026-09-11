Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8649AC88E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 15:38:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5594442D7D;
	Fri, 11 Sep 2026 17:38:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id C50BD42D35
 for <dev@dpdk.org>; Fri, 11 Sep 2026 17:38:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789141111; x=1820677111;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+VrYaSWaARHdvGXOjpqgKWGXaNg99XI1HdiPmWaE8ew=;
 b=GGgpvTWQ4j2TLOlVNTPIwmFPj0BhOhZJdG+wJQ8kwlgZbIxJMgJa7+My
 F/wmIQmdVR9LtY5BSXOFoUBkj7ZmrJaTFleM9VXzAtqmm/AJchCkqkzlK
 rpRenDt3wMv25xUgYJIpMJvr2doc+nAoqN/UxINqBCmYzrdgwG/f2p9cB
 DzT5PYBhzNSoZNtwj6S7H7F1DFuxJzL6hqiW4N8JaZcv5B8xcqOsyH39M
 YiVvYbyqp6+DKYYnfin9efdxvu0L1nilUnjrSQcXzIKgy2BZKfJxS9Wsq
 8ENbKW75r1dBb9Im/kdymbO7rgvAZXOcBYYdAfJg4z0cJ8D0osqN4Dw2k A==;
X-CSE-ConnectionGUID: u/kYxkv4SXauKnGCCw1Ecg==
X-CSE-MsgGUID: xMR8rOyeSuWyQnbvRN4vHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="99935055"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="99935055"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 08:38:29 -0700
X-CSE-ConnectionGUID: hQN0zXlrRLugTYRN6U7Y8A==
X-CSE-MsgGUID: roIsC+THSIq4RHQdqfr0FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="296938532"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 08:38:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:38:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:38:28 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiC7N4shyOcT1iXClOx3GzQ6+mqikDk88Vi1h1B1dwMvVQMxxSopI+GvXKBIuVtzfVMc67MTGCA8/f+bobnfoMsWtnxrgVxrDnwn24j3vesREk18vxrR9miake8iSABdN8WU4OGSTghNz8DSpt7Ct2w2e/ZrtRLSLEM+XIuD8NU+2K/5a8fTSVXWDdBOGK4Sjd0eYL00ZXKLBLx546brPjoNMBzZ0GzjQeXAMr6wv/Er31LqVKA8Vdp5Gv0iwvDfLkT5OYjnfY3mjY/DHdhxv1b7M+M12DWRzWntKbISq60AMwj57LIKOGTX1n2W8hi8wbXVcgAM2jbAiB5Cg9w6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLWuTHCMTgzqE2aaxuzWjiKz/0zobspCze2qeKVxCgQ=;
 b=t4e8rUryq9QmEl+Re7c4kyiGih3EikgXbuGgAIX8N646HJs6VAoL2I2/KO3+se+3WeGSDLaTpTNz+GqXzzUsYTWiPtmAKUJQVnsRTlzfjlvIODgJhkTX+x3P3boUMyDStAHKYUrLBWGNCvCh8QpoVSvpdVDsKxrx8bRTFTFIOTkjXh+Qrv7kbcfwGRI7v375zjjyf0aTq2rUn2DMgTUiPubzOpTmlqHEoZePC8NR1xMZH0X6rKm0SqWHbUCYdu4fEzyEF8bRzjEYjOfotoKVQ7DKInHT0CwIV+/G/KRx3FoVuiyMfj6Yaw05YJGmGkbEUeoHZTqPiSjBOAItZKZuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB6789.namprd11.prod.outlook.com (2603:10b6:a03:47f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:38:24 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:38:22 +0000
Date: Fri, 11 Sep 2026 16:38:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2] net/ixgbe: add fdir_buffer_size devarg
Message-ID: <aqQgaUuh8yj_1Es0@bricha3-mobl1.ger.corp.intel.com>
References: <20260908155858.126042-1-zhtfdev@gmail.com>
 <20260910155812.127658-1-zhtfdev@gmail.com>
 <aqQcaApthiWR-T_W@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqQcaApthiWR-T_W@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c2d980-5494-4c35-bfdf-08df101ab63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RPPQdtu5Agio/aXgDvM1EUaz7tBoDBu9rTwn/qJWJHqyYanzj8xlY7/sG6jqpM8EjXoh5aWvReOOTAxbxXmuCQX9qrpIhaSbGY/SFl8tWuSXyaYIrMWAs4XNFQsIpCqB3EiL34gNSGQ5R5YFRx6Y7EvqCp7jsRDL6/FYaWYc1TdDLPu4AaDWo0rUVpttPFbyy+jYyguD7X5j6mdzEzCPxdFMH/7I48UnDVdhWyDXV8AQtsucGHj3gspM48Fafneg+ZjWOrnbnSbvEnH2wnzgVydxswv3IHWJA68Zh7M+eiGA9q56ZBboam167why2kgUe2a8Hg4OxwKcHZ93g6nOMSx9xzUlXjYTSKHMb/5jNLEIvYlepPNJ/FrPg77KnQMMS9DOWeFz1LHHYnr+UR0XFQhU5DBiflNfsva4Xc5mB1ozcLHzr0DyB7R7IjLH1+11vDlcdlLVcvpGI/nqVEYLFCEuCgu42gw1DDsLGrMux2m4QyilQHA/oc6Azo/STarBhVoxDcDOvrOeX8HyUiIJBL5p6V8Y3cczdkWpZradUKO5RNhTaObmJ643vecBVGivrwcLhJwc4dTsbPSKsD6HKUqJDZJY67TMIsPNJiqKQ6J59trv7zmNfQZyzpbl59PdJ+7Lh8IuN3zXJ3ZMFnAReDC9Xnt1bR/W3B0pBLEGBJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4QzyvYfbzhrLuiTegJ2X4zMhonK2dTZe6Rfy3jvclnKMyL6albYxOSBnSstM?=
 =?us-ascii?Q?8G2hp6cXMixRE6Gi64IwY7ZYz7VAQjOpJShfhQdMCxBETNluz6Kr9dcobct1?=
 =?us-ascii?Q?ju97r0jS9vo9kYvbJxrngmVBg4nz8vYY0lhK4xCyXuvRHF84gfbgkALiPweQ?=
 =?us-ascii?Q?lTbLAaT21gGG0CXHG2dIieSmlesmgLBwR2qvWfyjVRs6jz2cL1MQ3dW/a42i?=
 =?us-ascii?Q?Db7XQ+W6SP5Q56nmp/jrhWlGexndnpoSF/hg8pYewJH5d6NoFxlCqnOVGVDw?=
 =?us-ascii?Q?5BRkZzR60rDKXe8+BkLEt8L46hVKqohbkvuXBFebJF84J4uqdlFHQpUoal0/?=
 =?us-ascii?Q?dCsFi4xUfi4Aw6qmLX6IOSKxToE4G4KvnOEHda0hXaRpDNNPQjPjabYmtuyf?=
 =?us-ascii?Q?50Sl2563ZrJyWjL/TXiVDCgBGp0pkof0Zpdmmj75yDKsgur6AiJdUSrg2fyZ?=
 =?us-ascii?Q?KypEq/7490Y7lgGClTuS5gqB8fH/JyrEtBK7hLXaTC2wDlRM19aWOIm7+HHe?=
 =?us-ascii?Q?+UJgPhtOJxjc+5JqdZGflBeif9+XgszfEn3RWXRS8lEZsOHaRBcXonLNU8RD?=
 =?us-ascii?Q?ntbRutL3JRH7wUXaoNcguvjvFN2EeAlAN9xdlq24BtZK6saa4a4ykjKHR1MY?=
 =?us-ascii?Q?T/rJSez4vAEx3aW7na/giCrmnjo41cm9Ny96NppunjYLl5lNPVLsyKcBad0O?=
 =?us-ascii?Q?J/wwHhwtG0yqZwUiV+9NZLA0YDiPUyyJORWJDFE1XKtOxQRiB8acf7s+6R+i?=
 =?us-ascii?Q?A/VQugibqioy79bzrYi+7nbxQUnyZhldWF1rjr5v3G60zgNiw58tR788g2J9?=
 =?us-ascii?Q?ze/eaYELfXj9wM7TA1pcm4+yJaS6RRi2maQsOJJTrwj3Q5vOaMi51WK3gU8d?=
 =?us-ascii?Q?0SYeAoxrhnljFG4rsR3qSR5M/zEvKzrLX1C7EPRX+uRWCEi/+R1pPGqcLErm?=
 =?us-ascii?Q?Clcgq6tm05PYR6RRZ3Fk8xyfkdT2qqf+SzuVaKE8bxbRJbohFmkOECzPdw8c?=
 =?us-ascii?Q?Fp8VggjcvWuj8UbQLknydusx82S/JGm1DNA9hfbdmF1pFeOsTuUacw6zT1Bg?=
 =?us-ascii?Q?LX0yaIsjZ0X9XDivquZ9/RJdY7q7S9+Qur1XnhgmQgiscdwToMNhSF36W2h4?=
 =?us-ascii?Q?pqCVxm4RP9IMMzukoMhd8kWH3upetWK4dULabxgaLBVJ9scUo5kuQkUZR8lQ?=
 =?us-ascii?Q?c4oUqe3EmMBBamj1D68jfwss5B4fLKlKH1nL4nA9OgFlN7DJWvxaHw4x2hRs?=
 =?us-ascii?Q?yRKs4hIb4nqvqGECiCAhusyn6QuhfQf4qFiCXQPg72yIjVILnqGdxhOOEnKO?=
 =?us-ascii?Q?JYfb6UxlqFkCVyKFZGlcWJX7eX57f/7shgzAEwBf+FKHA3QdFMOTSubNkr5F?=
 =?us-ascii?Q?8hcm4H9fRP6M6DaAWobc0XGU40KdlUqI1nnwv2+X1/PW3JEsN98jFG2yrqti?=
 =?us-ascii?Q?MuKmG6fjRT+gTsxv1NYAOAHOSf58jZ0NU63feLslXT0nm/WZqRH/NIXUmhAE?=
 =?us-ascii?Q?TReANPaD0TC0ETvMsmWvo9zkjHfvRRvrq020j/TJJ4srh+5+mdXjZRiau3bU?=
 =?us-ascii?Q?VF+hTSfJOHTOwePRiq+y7Ltdg8RPzXlkM9m1/mYxROaPuyRxub7NxHPWMIii?=
 =?us-ascii?Q?iSKKg0q+R6fVcWwOdoNHdGtgcbZg+uV+nxzgDix4ybXtJgHr2yFxmeekkWoZ?=
 =?us-ascii?Q?JlF3YJabbw26BVIR6g9sik30U1L2MeAcky9d+oqxwjhvxbrY+MEU3MqWns70?=
 =?us-ascii?Q?yvY9g4OjQV1T9ENifUabXMLiylbBkVE=3D?=
X-Exchange-RoutingPolicyChecked: xgJZV6mIBA6XEzgJi6VC+k4+MxwzPb+UbAAiBeBZQw/IwLPi2YYAmT4doUDMlDMaIPkwYI50zoJKunaLDiuiU6igi9yavE4flQRa6kifu6eVoecyEtss2kU95dOg/uUankYC6tFcVARyyOd+7nEQiYajl7usv9F/GzWGxyQWj5E1YoHF/9URSyr7nE9rmWtXi1WMRCENRSgIYxdaPHFjIrq6BDWtMSdaZFRYoI89evVIARV3nfiFqyyd+dL1rgaK4R9IqMNSpgqDdjWqS05gcsA8+vPweuLmw52ncI3L3SagDqHVlFsusWiexgBpw8LKAoCtnhNtjZ8PVfSc50P31w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c2d980-5494-4c35-bfdf-08df101ab63d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:38:22.5217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oft747S92nTsxTWVpSryyuADe5yMM3d6+8tv8GIguE1T19/MbZFDeDjL980+/hR3Qx1OM02oKUHdnqgAlMvHRiQ3Y6foi+QeKIkwykNU4h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6789
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

On Fri, Sep 11, 2026 at 04:21:12PM +0100, Bruce Richardson wrote:
> On Thu, Sep 10, 2026 at 11:58:12PM +0800, Zhang Tengfei wrote:
> > After public fdir_conf was removed from rte_eth_conf, the private
> > pballoc field stays at the 64K default. Add a probe-time devarg so
> > applications can select 128K or 256K Flow Director table size.
> > 
> > Reject Flow Director with DCB in ixgbe_fdir_configure(), since FDIR
> > steals Rx packet buffer space that DCB also uses.
> > 
> > Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> > ---
> > v2:
> > * rename fdir_pballoc to fdir_buffer_size
> > * reject Flow Director when DCB is enabled in ixgbe_fdir_configure()
> > * document the DCB limitation as an RST note
> > * keep the original indent of ixgbe_parse_devargs
> > 
> >  doc/guides/nics/ixgbe.rst              | 26 ++++++++++++
> >  doc/guides/rel_notes/release_26_11.rst |  5 +++
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 55 ++++++++++++++++++++++----
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 +-
> >  drivers/net/intel/ixgbe/ixgbe_fdir.c   | 13 +++++-
> >  drivers/net/intel/ixgbe/ixgbe_flow.c   |  7 +++-
> >  6 files changed, 98 insertions(+), 10 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Renamed to "net/ixgbe: add parameter for filter table size" and applied
patch to dpdk-next-net-intel.

Thanks,
/Bruce
