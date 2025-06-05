Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA4AC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 07:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D28F4028E;
	Thu,  5 Jun 2025 09:51:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id D5B7A4026F
 for <dev@dpdk.org>; Thu,  5 Jun 2025 09:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749109861; x=1780645861;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hXw7g9hX2JOoBgJTMHPlhbnq0EVKniike6IHXtTFD/4=;
 b=EZRMjgUbUz4J/vNsKunT3FiMBHKCvK+uu2GTSbxlIHk4ks+Q+EDyly1l
 uxlWwRInG/aOuuRHqj4zfbveR3Ibyy7+fAyRnFmiw+qhfB7kpqFqLfbTS
 99XYljw410kGgihwwY2+Ev/UWlH3ZnyCTwbJRyGAGQ+gXEB+7bsAMHyrV
 lottxq4BL7ejpshokJtGD3kFxf/qQpccF/YDp1Sm7vstrcUc2dQORRDaZ
 3lKAPjx8dlw66RBfLYk/MNfrCBiRuG63DjgPmjN0/v1ByUM8eX6fbyCdu
 NwfwroMPICTmp1nY5PNd/9DmDCCtLNNO4YJ+MSL/8JVrXz7kPZIAESoyA A==;
X-CSE-ConnectionGUID: pB1nxZXnSz+mrJUu2fF7Kg==
X-CSE-MsgGUID: ONurQL4vSmyrSlEoPbUVfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="68656607"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="68656607"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 00:50:56 -0700
X-CSE-ConnectionGUID: 5nHRir2HQNyYq4PrUu2I/g==
X-CSE-MsgGUID: zURe+sTfRHOpt+rFJ3NfJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="176294787"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 00:50:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 00:50:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 00:50:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.77)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 00:50:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SF/94TxnwIwpMqvpUlDmPTpJ75m8vZf7OsFUo9k0MDGA2xSAulW2On03KEVEcQiDHWF00iLWdTSjR/gUhaL0ZKc0VnEtcFoEL/FbEg8Tp8ILRWQM05PeZfUUcpPZfl4fSWs4O0FeI5H8gmoyRQbn1ldN2yPGsOutBPtap77LHPl2oCJZYY3yh6oXWShAlpxIsvov1iw6GzotN4nxUWejE0HDH5+4tTKuWZUAlwnKLoC/L5bmXphCmSUPUK5fhWhIGCx/TQnFYgJGkkts1zfIXdEul3JzeOEhVmJ39WHh9WE86NfoNON2epsM+UsIm3M3pm7ZmQUaJOpcPOUzc1PUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmfcN9lHFR9KLKCi8N/KM0/dTFkvRzBi5AD4jXcKL1w=;
 b=Il41yOqGNSSA3SaHovxf6pszZm2gBD5KcjPEj8tg2zn9wM5wbrs6BXk3AlVwMy4v3+bsW40c0WzKd77bVNrmN8akfoytx8/QYMjB3WtWHNDCyZDpsKOyxgGaxEW2vRASNLf6DvkwKJWcessUmgTplEwHD7ulRcJioX4Tf1slBD9pQAe/XhpBnTRmoIav4iGYPfhU1WkVwScgxzvI2XNLENn1qVCpD4KxZRSixmTnSZHXxW3Dh/5qI1bgWQFOkBu/v7e7JR9B+SoI/Ms4cTQ9qQSP1FKrnuCJoXOtEpGQCJA9PDVhZTXvkG6KH8MAiYY+A0p29HLsFgUE0Ibet0ZnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 07:50:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Thu, 5 Jun 2025
 07:50:49 +0000
Date: Thu, 5 Jun 2025 08:50:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
CC: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Gaetan Rivet <grive@u256.net>,
 "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>
Subject: Re: [PATCH v5 2/4] bus/pci: introduce the PCIe TLP Processing Hints
 API
Message-ID: <aEFMU-aeau_WOvCQ@bricha3-mobl1.ger.corp.intel.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-3-wathsala.vithanage@arm.com>
 <aEB6VEFCKr-2t11p@bricha3-mobl1.ger.corp.intel.com>
 <PAWPR08MB89092A3A53CBFA874B1AEA729F6CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAWPR08MB89092A3A53CBFA874B1AEA729F6CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
X-ClientProxiedBy: DU7PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b89884a-5ca2-4433-750b-08dda405afce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XoFGVYxzRjvOvqXU2BZG4nokOoX7bl5T5e+HzI8DqhbAIN81zwBeJA1j0IpP?=
 =?us-ascii?Q?dE5F/eC/FrXZ1QSSL6/8qpG0Feje80LToVr7adihfENp3SMEEMjr02JWPcMD?=
 =?us-ascii?Q?HUmrlIOV838nyKkjZ+Dbbf1CHBEVLESq6UQFxuxRHOyi0xx5fKnQMII0GkCK?=
 =?us-ascii?Q?fSoEZS/ryUshet1OkBlq53wxNMbXbYg/zw+XXuJMkXZvbsH3EOE97m4A+AUG?=
 =?us-ascii?Q?1fV/+kCE8walLL6XgbMqj1jVaKNEbK419HBNyoWWhjlOZ4ew5yZcR6v4b5nU?=
 =?us-ascii?Q?Wa7uacVXPRXy/aG5+2+BIYMal6FKRRyklN/6bhDY2FS5xyxPQNuMGBTphKds?=
 =?us-ascii?Q?oJNfpX14KQKMNBS5fh9kx+7zj99aU7kU46EQNYhHLY8C4wghA2jYK0oqyYxk?=
 =?us-ascii?Q?isixfdEeWxTioOWyfM1re6ziFQAgMrxXTe3oXMLPHWTwUJlheyAFbc3mtXb3?=
 =?us-ascii?Q?9Sb77vaeuj+CEbAcH0p/rFAnSk3F79YBBAU6CjiUV6LZzkjprkpxz0QJZTiJ?=
 =?us-ascii?Q?H5ritr78xvAzoXI6CFfCsc2xlhCfndvis23iAZFI9Rq4fKp73vJnp4995p9+?=
 =?us-ascii?Q?cFKj4XP61y4ebwCVwOu6bBCUpHCMHfqTqsj19RoWTbg/vYIdrQT/F8tko9NP?=
 =?us-ascii?Q?MKDacOWDROqPBr37JzRzzRCyFEywnJAO8mLs9dp/UwlzjK+/uLP3UGWXHybX?=
 =?us-ascii?Q?fzfuPeB4HwFWu6beZHyDXau8mWvPWtGN5tbK7lUhEHP1WLKFCHS13vZ1o2mi?=
 =?us-ascii?Q?gj+6ItEDCgBhUGmYOIg2f3lBpi57+mcqSTKejU697EsO4yRz/C5R1v7JIHqv?=
 =?us-ascii?Q?EzrmzJD8VV/eG41rI5ChBqoNNBJB5toZ4InOQPuubQ4uOARnMy6amBileRWc?=
 =?us-ascii?Q?2TmOjKU+Ba32OmuM49BPU698Y4SUP30Ty3l2Mp9UCLhH34axgy6SSvvlQK5F?=
 =?us-ascii?Q?BJ/kyFlMbHT9aJg+0mu8vxwMjPp7unWX0fxAvYkuKzuHMqHzW53vNWrXyull?=
 =?us-ascii?Q?cZOtfdxl59sJJYxHK3bXQUWioFrC7ShvxJBgv1q88UTSk8J18UwR+zmVazre?=
 =?us-ascii?Q?CP2WCwJD2nm8bISjVD9PV8X/IH45fKzgYHrYRq0QfXP6f06vRooxpvId+L86?=
 =?us-ascii?Q?GiBKGGZJOtvBij5vxgB3Jl1353o2TKm5QauxQso0FMkp8fF4YfO/rNrgNkQj?=
 =?us-ascii?Q?NfEpQbiOSwpiZD/xocvdDtK2xzb3SIs1yCVW/OUWbtRsvvDtfRj6XuTGEhyI?=
 =?us-ascii?Q?He0BMF4ZcnsstvknMVUuMZ4Ic8kL0v+4O9VIRY8cfJFjkFzTLpTnwuZZFRcS?=
 =?us-ascii?Q?3mqS8MsPi3NPUjsueWUP+mV/1AT1tM64qWJcKoiYuGKAsxufrY0RXm0kmqcC?=
 =?us-ascii?Q?vcrEckI1FolFFUENpCRQuA6PCFEZE2/rKWS6P3++PCI5b+jt93B4MdFrObLk?=
 =?us-ascii?Q?Zew+Yzu09a4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+r1ZGT3YuwvDVwSM2549OI6BJiv5QQES4ByZxvAKNO1nXNPf1NCTo5OVYRUE?=
 =?us-ascii?Q?Vj+tge/zNKGoT/KI7drzxmXNZD4FxI4U3VAf7zhxbQvSP+aqis9JxR3J69Cc?=
 =?us-ascii?Q?1m0J8LeEuIejLkPCIQA/DPZU/i+Nc9U49i291AcaBF8Ybxi2cksax0OSHkBV?=
 =?us-ascii?Q?5ARZ0cu6++JMehGKGP9xsk6hwlNdoXrf0Qm4msqGeolgDEe0IPmqNx6Qr2sh?=
 =?us-ascii?Q?0/MfqNvXdaELrDvFsMKYRdDaK0hGQskTAzKX2TB4+LFF/X9OnY5Nsq4dVyL7?=
 =?us-ascii?Q?Y+4UTs/XNLX/Qe0f2AxKbn/t/ZJtqg4OyqPW67IxamCou6WxCWw6M0JITiqP?=
 =?us-ascii?Q?Yed9PeBFH8GBmbQ4faFLUQ9/CnLwBKcZKRaNhCapQruxF43BjXEStujhjMUS?=
 =?us-ascii?Q?Uh2KJQm0dvo9pbXJ8GUS1pqcNMKjP7wesRsN/HRjKtG7cV43O0pfGcGpLrWs?=
 =?us-ascii?Q?JPHsy+XQZKIQea/pQoGBYniR4LjtAswYEIk9Rdyi5mdU5x3nbvATGlnEBzKo?=
 =?us-ascii?Q?fJe/l9vF3gOLhvL3o1HnutHi9WfBUCvlbPmDfPLnT1DLpQaHvGxQCvzxc1iq?=
 =?us-ascii?Q?KHJJmIkETT1llDhjMTRDA7dm/8tBek95ybx5zdzBjgkJBVjd6DaUladkCYYk?=
 =?us-ascii?Q?ewO9Mv/T2DPwF4U2dSKCcqfwXDAK9iVLCzeaFslOxnfrxJ2q1tXZtewSKlV/?=
 =?us-ascii?Q?dI27LMGg7gHTF3zno6f1XeVRIDGbf0bdT52c0IAbCDIw47wEHKh0sHe6z7Yk?=
 =?us-ascii?Q?4ao8QjofADdT5QWqWUZnXSm1h8J0pGYIl1mQ3YoLyoIzR3heAA/JOBJdzNFi?=
 =?us-ascii?Q?A6kEitQejDCIGK0jG9huW8Mr/wvKboNSPwjkW9PQeluYqHEZ5FqqZl/QIq4m?=
 =?us-ascii?Q?AdWWlXWVA2NcVjUKLlU7L+TLf+IiLl0ZIA26PQ5HvpInwkcyM8d+sX+YOyj9?=
 =?us-ascii?Q?VaAJHyFkZMiUA53HJPJ2l3cG2tbblsIrDkZYG/Jan8dQi1eDdXY1owXm9vw/?=
 =?us-ascii?Q?jNItl3aMWdL2eWmyk92uYJrO8HMQ2Czn1xEXP0kBy9F7dJkbCU4L8Xyon4KB?=
 =?us-ascii?Q?LNb5uVyRbW9/EXXFqI6pQGjmqcvPCIyAXBcjNgt4Md86vnlUbZ/EunnXJHXd?=
 =?us-ascii?Q?O4weKDgXv//v+PoG+bAzI3q03omrNg4E7R4KJnrrRDRo+seufacqdEfTETNC?=
 =?us-ascii?Q?3wQU0cPDNaWOVDlPA9n8hVV3OQfc4w5ta+S1P1hKoP0sab/SoUJdB6W7ibNB?=
 =?us-ascii?Q?au3X1FhLLkUySuz0jnxjNkDDIxkRayP0Z8v5G+wPV2/RTCNG3CSpSWCycFB9?=
 =?us-ascii?Q?Pq6T3Z29T5/xE7WTtyNKIMdGVrfRv5RUDsxjvWNKMSFezwme951jn1k3b5Ez?=
 =?us-ascii?Q?irFrv1kF8kP6p4grBRLloPdxme5e+pkhpZf6SRIOUWzHUeRiOyk9nfDmASne?=
 =?us-ascii?Q?jZ39pzEgEPz2bh1l+3Rd0gJ18SUnHldSu5x/BKMM0X1uCS+r8mcpxHJXu7is?=
 =?us-ascii?Q?QYS4EGT3tL+RKacp3FWKS8JBbRTbi+hRoBFamnKQukyYjEHnesdSytPzriDY?=
 =?us-ascii?Q?mf8ixHyx70dRRhM5bUKOzoMhPPXKKbtKOnIdYOprGt6s23k+WgXZOdcO/Yq6?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b89884a-5ca2-4433-750b-08dda405afce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 07:50:49.0998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruVrfNp24+GreyXIsLS4UMubXX3eo0qhMRw1AVt0sM7AYTcYif1nzbxx89RLz0EcVLv5kxnAbnypq9IMFVK4j1srNSdZgG0c2NHNb/ApqqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
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

On Wed, Jun 04, 2025 at 10:52:24PM +0000, Wathsala Wathawana Vithanage wrote:
> > > rte_pci_tph_st_{get, set} functions will return an error if processing
> > > any of the rte_tph_info objects fails. The API does not indicate which
> > > entry in the rte_tph_info array was executed successfully and which
> > > caused an error. Therefore, in case of an error, the caller should
> > > discard the output. If rte_pci_tph_set returns an error, it should be
> > > treated as a partial error. Hence, the steering-tag update on the
> > > device should be considered partial and inconsistent with the expected
> > outcome.
> > > This should be resolved by resetting the endpoint device before
> > > further attempts to set steering tags.
> > 
> > This seems very clunky for the user. Is there a fundamental reason why we cannot
> > report out what ones passed or failed?
> > 
> > If it's a limitation of the kernel IOCTL, how about just making one ioctl for each
> > individual op requested, one at a time. That way we will know what failed to
> > report it?
> > 
> 
> The V1 of the kernel patch had that feature, but it was frowned upon, and I was
> asked to implement the IOCTL this way. Please find it here (V1)
> https://lore.kernel.org/kvm/20250221224638.1836909-1-wathsala.vithanage@arm.com/T/#me73cf9b9c87da97d7d9461dfb97863b78ca1755b
> 
> > Other comments inline below.
> > 
> 
> I will address them in the next version.
> 
> Thanks.
> 
> --wathsala
> 
> > /Bruce
> > 

<snip>

> > > diff --git a/lib/pci/rte_pci.h b/lib/pci/rte_pci.h index
> > > 9a50a12142..da9cd666bf 100644
> > > --- a/lib/pci/rte_pci.h
> > > +++ b/lib/pci/rte_pci.h
> > > @@ -137,6 +137,21 @@ extern "C" {
> > >  /* Process Address Space ID (RTE_PCI_EXT_CAP_ID_PASID) */
> > >  #define RTE_PCI_PASID_CTRL		0x06    /* PASID control register */
> > >
> > > +/* TPH Requester */
> > > +#define RTE_PCI_TPH_CAP            4       /* capability register */
> > > +#define RTE_PCI_TPH_CAP_ST_NS      0x00000001 /* No ST Mode Supported
> > */
> > > +#define RTE_PCI_TPH_CAP_ST_IV      0x00000002 /* Interrupt Vector Mode
> > Supported */
> > > +#define RTE_PCI_TPH_CAP_ST_DS      0x00000004 /* Device Specific Mode
> > Supported */
> > > +#define RTE_PCI_TPH_CAP_EXT_TPH    0x00000100 /* Ext TPH Requester
> > Supported */
> > > +#define RTE_PCI_TPH_CAP_LOC_MASK   0x00000600 /* ST Table Location */
> > > +#define RTE_PCI_TPH_LOC_NONE       0x00000000 /* Not present */
> > > +#define RTE_PCI_TPH_LOC_CAP        0x00000200 /* In capability */
> > > +#define RTE_PCI_TPH_LOC_MSIX       0x00000400 /* In MSI-X */
> > > +#define RTE_PCI_TPH_CAP_ST_MASK    0x07FF0000 /* ST Table Size */
> > > +#define RTE_PCI_TPH_CAP_ST_SHIFT   16      /* ST Table Size shift */
> > > +#define RTE_PCI_TPH_BASE_SIZEOF    0xc     /* Size with no ST table */
> > > +
> > > +
> > 
> > Where are all these values used? They don't seem to be needed by this patch. If
> > needed in later patches, I'd suggest adding them there.
> > 
> 
> RTE_PCI_TPH_CAP_ST_NS, RTE_PCI_TPH_CAP_ST_IV and RTE_PCI_TPH_CAP_ST_DS
> are used by drivers. I40e patch uses RTE_PCI_TPH_CAP_ST_DS.
> I will remove the rest, added here for completeness.
> 

Having them all for completeness is fine. You can keep this as-is in next
version then.

/Bruce
