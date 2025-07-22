Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A40EC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 16:14:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53074402D1;
	Tue, 22 Jul 2025 18:14:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id EC48C4003C;
 Tue, 22 Jul 2025 18:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753200852; x=1784736852;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=WkfLLZojk49zg2nE3Jn/f+VHxcfAd79ruB8hPXBPEWc=;
 b=juVW4zDK3PN+anNXoCeW9TUq0rltvMR8W3g1R60XJXESNows5fzct/Zn
 +jWccvoq9g6D/Vsf3HJNefE2+HLcqCAPVDhNNwCmVUpSprE3i/ZS6+YxN
 w3tmrCUef7/8AmLVe/RkzFXkCNq5BAfwsAbN4RdVZPMFP5X6bDhyPTbLQ
 9NiHREt5bNi1hmNL9rVbrxDa80PmMh/3co02YPy6pmarkBHO/FnXZcXoI
 SHw145jGZ7t4bAh8xqIPyc5wwI+KuPKkTiyZbjpn9hoeMpUWk1ysEaUHI
 Y/LlpT8sl3DfzEATOiCwc7lKpKBgAdzlWm9tHXhoyX5u6NiN7VIta8EvD g==;
X-CSE-ConnectionGUID: nUolCmFLShypiFypM+lMVw==
X-CSE-MsgGUID: TPIpFxe9SdmUVG+zrs64qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66890287"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="66890287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 09:14:10 -0700
X-CSE-ConnectionGUID: UVMImtSGRbmHdeeGzY3k7g==
X-CSE-MsgGUID: cFPDj5GpSAiF5vGfwPddCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="159745477"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 09:14:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 09:14:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 09:14:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.81)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 09:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt33JY63R/5H54a2iIzyWzDRG/Xwv5uNOeqvSPqMrOlf/ctJbXmdAB7jG6xvj9Q5IXyBeWpgEbSCDeChn33eIfBrqreUA5xBk5dQA8tzw6hYTisb7EMCM4HPlTWX5ASBuztp8gmp8Q3Qcf2PM0MFbgBdvY4pe3eoAb78EHSn9Rb3TRYggWs5Ug52s6y5eCm3TTlKqsfR8xOyLsnvlz37oYQrFh3a9cio1agIt25UGqsIfSLbip4scWcy1lWfvBjq3CT5c4wTMRGnhIK8q+Hw+P7eawinkkIKVnGou9OudvKq8p1Q0vvVS6YGmgRD3gigQH2zItqG7jE8hfTGTETQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8XQnz76FUVMdsmXOkRbV4HcY9IiPX8EG3UZWfDMSOw=;
 b=AIMPK2xQlBa5VNTt/BumyBNK23cAt+Na6k6y0H7N4khKUWEXX9bflVbpCTrEX2MgfTsHl1iGBt+wRulaTCMELn012xJl+empl+TOrEAds2JRIC0tCTAvcvqNV15v16FVM8XYYjKJlc/Of4ZW3gkQHSHucKqZ55snSe6Ek1y5/JwXBRh1G1MWz42EmhTqlcuqlbbEdvxaVOgucHmzxga2b3gAQyQu4A33bTGDJAfaO7zwVP+yGjv0Tl8ZM8TQKW389AImdTYnvViB3PPAEx7Da9k4tpOA0VmR3MK2X+mGxx0EZdlMZd22yxHWcNlzb+HEVAcHgDo1tLizs9W7kJgn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4862.namprd11.prod.outlook.com (2603:10b6:a03:2de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 16:14:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 16:14:05 +0000
Date: Tue, 22 Jul 2025 17:13:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: Stephen Hemminger <stephen@networkplumber.org>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, dpdk stable
 <stable@dpdk.org>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Message-ID: <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
 <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 7678ca3a-62e9-435e-7137-08ddc93ac7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGE0Tk5sM3gwNVhSWGhmYk9aVFY2alpyckZSSFlBS1Y0U1I3c2ZWNHpWRnFp?=
 =?utf-8?B?T0hJU0ZlNzRqbk80WDBuQkJ6RVB0dU4vMmJmL05GRGJGNGVBR0c0SzhaMWZN?=
 =?utf-8?B?SHJCeFlnY2pnOHZlcnQ0amV6SUYrNW1BKzJJMTVUTXdBOGNkb3FGWWMwSVpm?=
 =?utf-8?B?SUo1QWhUWmhFQXEwMHdEdXdOZE43ZnNCWmllbC9kWkJ0d0Zyd3B3RElhR0Mr?=
 =?utf-8?B?S2VlVERtWWVXMDRRUzI4YUVvK3VMMWNWRmhDSXY4c0lmL01oZnB4TUNqSzNm?=
 =?utf-8?B?VGRmUHZ0aWV6ZWpPWnBpNjM2cEVEUVd2SE1YbncrZzkvZ09NZ2I0QjZzZDdk?=
 =?utf-8?B?TWRGNUp6b1IzU3dhSUd2VVJ6aVBPQTFNbGpMVUZSVXdCQ1RQRVRqeDdrMHYy?=
 =?utf-8?B?M0c4eGx6TW5pZ01OSTlNYnVwQmtCTzlwMUdTa3VacS9IcjZpZVVIZi9ISG5X?=
 =?utf-8?B?STVZaXdLMWxMZEFIZjB1ZWU1ME5sWFJLVVQ3MVBGZ2VFVWNrZWQ5Qk02dk4z?=
 =?utf-8?B?NXY3VjVldm5keG5XN2diSlBJZXRiWGFEZGpiWThTVHZPb2JkYk5pRU0ycFcy?=
 =?utf-8?B?czg4V1hodWQ2bkpsOHN5YVpoNVhLNHdRUG55emhoUEhjazVOL3NMb1F0UDJv?=
 =?utf-8?B?TW5nQmsvSkZjeFltaVgvaVVZRkhvYnJFaTVYS1hMS2p5Z3ZIM0UzN1paYk5w?=
 =?utf-8?B?NjcvRTNKQThXYzloaXlXdUlhdGRXNExmTk50OTdDWnZMVWc4UnA0VG5yQ3F1?=
 =?utf-8?B?SVFNU3lQQkxSQ0NZK2V5RWsxc1ZrcGU4RVhBV3gvVHlPV3d5eHFBVStYNTBX?=
 =?utf-8?B?SkUzNVM0ZlBxalVEdTh5MTU4eW1odThabnpnM0o5WlVHdTlTbm51YTBmMzNQ?=
 =?utf-8?B?WktROUl3TU1iSTE4MnpKUlpzNzc0Zmc1TDN1YkRsTStFc0xMMTh1RzRUekly?=
 =?utf-8?B?NzZjQlJuYk5ReEdNR1lwV3RpYWJLMnE4d0c5aDQzV3F0MFJ1RnJxdU9VUlI0?=
 =?utf-8?B?NmY4Y3VmZ1pnWEtEL0pvUHpDajhlaS9jRzBJYnNRcm1kVnNWVWhvblU2MlU4?=
 =?utf-8?B?WVVmYzdSVjh4azk2bHNpY0ZCVnRoNG1aMERUYzV4TlR0SlFSMTU1U1pJSmY0?=
 =?utf-8?B?UnIzOVlpVVpydnVUczRCaWxvRXdrZktjRGVCZTJxaHVCd0xUTWtlUUR6KzNT?=
 =?utf-8?B?dFR3Ym8rb2llN3JoeU9Fc1hyMEZ3cFh4TnQwRWMwbkM2eU9NTTFzSkhxNGZ3?=
 =?utf-8?B?TTlNclExcDdWbVlkQlFVUVR3WVlQc1JFUVhSNHJsQ0gvNmI0S1dGa3R1cEdB?=
 =?utf-8?B?aWVtNDFOaXRmN1VDVEpqMGdoNXB6VStseE4yY20vdVhtNmdnd21samNnV0Fh?=
 =?utf-8?B?OVdZMlRCMFVmNUZ6a2pleGJnRWtyWjZuKzVhU3FIWlFSeXo5VDEvYXozY3FE?=
 =?utf-8?B?T2dIY1NDNUR4eVZ2b3dkUjVUWUlTVG16SmpVUXBZRm5YMFdqU21yRGdZSUh5?=
 =?utf-8?B?RFA0M1Myd3BvdlRTTFNKdmpoRUtjRDR0Z280NkpucGhWQkJ2U2xReGVwM2Zp?=
 =?utf-8?B?WVFXdWMxRzN4WGhJT0NsSEMrN0MzdGZJbTVKRjIxbkwyOE5aS20rQTUrRHlo?=
 =?utf-8?B?RksxVW1QS2wrU1NPWjlqNnJxdVR6Y3BBSCtsOUEzOC9uVXZRblVDd1p3THpF?=
 =?utf-8?B?bXI5T1hCMnROOHgxNUtpZ2tja0NYbHlwMm5Ea1lnUS9mSkpKbzQ4dDNZdGVl?=
 =?utf-8?B?OHBoZTh2UGdwOXRSeG1xQmkvL2toK2NrSkpZZCtGWnpUMEhIODYyTmY1UWFW?=
 =?utf-8?B?bnY0RGtuSE5lU2VkeWFlbjBBN2hNVFVLR3VkNkVNQlpCaEdia0ZyRm1LOHJG?=
 =?utf-8?B?Ykx3ZE9UNHhWOWxCYVU0M20rendxTUJ6c1hDd3JpSitLUUlyUTNLZmltSko4?=
 =?utf-8?Q?hojecFSHPjo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhIbXAwOXZoWUJrMWM3eHYrUlBqTjVhNGgvMUVPZXRraWU5WWFTUG1TazBi?=
 =?utf-8?B?UnhZcDNRUHV0U0lHZDhSelRydzdHODJKL0svRTFvVncxN3llTlpGTWxJZkFE?=
 =?utf-8?B?bGpNSXkxVkwvWFVpc2FwZXBIRWJDZkVjWjd4ZUtZKzY0Mkh5UlgrRSsrSVh4?=
 =?utf-8?B?ZnZwZjJCQnlqRDdLd2NoU3BqVHpxVFpodWx5K1FpMHBZMEt2QW1xQVhnZ1U2?=
 =?utf-8?B?RUdzSytVckhpTndZaVI1VElhV01vQjU0REZTZDR6S0wyaFVSMURPR1VZdEpL?=
 =?utf-8?B?Wm5nZ0RtM2cvVFI0UlprcDNyN2lpVC9xZVJYNFdmVjVpWmp2REVPdGVCajYv?=
 =?utf-8?B?OVBxaUc4U0N4Yi9EVmVHVkJaUkg1OVJOZWJGYUFnZWdKeDRGVGxHM1hxVXJE?=
 =?utf-8?B?YWkwcWJjUVYxemZlbjU0TEIralFKcWQybFZ3QjR2enliUU9ibG9ZdFhyOUlw?=
 =?utf-8?B?RjNCTnp6Nkh1UVhOZzFHV2M2d0tNN1V6MERLVzlHSzU2dDBmZmc5Y2NTZ2xX?=
 =?utf-8?B?SHBkenc2MlFXZlNvWHVieDhPV052NHZRZnpzM2VFU3FKSEhlbmNRYk5ZU3p6?=
 =?utf-8?B?TmVhekFwejg1dDlDcjFrZlo3SGR5WllDYTNhMXZMVlpVSWtldlB0N3l0eXFl?=
 =?utf-8?B?QVdNSUYzREwxVHBYTTRZOGYzTmMyYmVIVmR4Vk4vdUlJTEpTNGpweXFnVkIx?=
 =?utf-8?B?WHJTMEFCMkFscHF2OFNla0JoTTB1elFaejg5RzNyVG5qM0dobUFnTXAxUFNG?=
 =?utf-8?B?Yi9xMzk2OXI4QmdRYVZqTW5qM21TTktyNkw3Mklma0pZTi8xRHJTWW00SStQ?=
 =?utf-8?B?ZjVkTU5nTkk3ei9QVzhWQ28zN2N2Y2dCbmRvZXJtQ2lrMUJtTGpVS3BOZlJp?=
 =?utf-8?B?bmRjM2NrS040Szl5TERBRDhKUWQ5TlFOYUdMQTFMaVdaTTFRb2lXNWVMWC9i?=
 =?utf-8?B?SWNQYWwyY3RmYyt4ZXdEWHdXVmIxeS8vbHBXY0JHdTYwTkJsQTR5c0doMkhs?=
 =?utf-8?B?UXE1NmNLbDFQM3EvUWxQMy9ieFdYajUvTzk0TEpZa1RmVnBnUmVaZWt0WmVz?=
 =?utf-8?B?a3FpbGM0S3gzd0NtUzI2OGRrT3dNVkJMTVFGdmFleFRMYm8rbkFWMHdaWC9W?=
 =?utf-8?B?R1JpVXN3dEhPb0RvRWI3aG1iOHI2bzk4bnBBc09JZU1hSklxdUVwTGpMcUFk?=
 =?utf-8?B?bTdLanYwMVRNMk8rN3dJMWhwdElFTGxjcStsQ2hzSXZlNzVuNmZNUVJSWWFU?=
 =?utf-8?B?N1FrOThldTkrTVU2M2tCTS91bGVMOE5MNWp4UTNxVDlsZUZXVTZFa09mcUlm?=
 =?utf-8?B?aSs2bU50TlVkVkY2ZkxTVWtVSGgrOU9sUkxOVnZ0RmxSUVdJeERmMFZYblZq?=
 =?utf-8?B?dlJveEhnS3pvK3VvZUxCN3pNQ2ZyWWwxVzBEb0wxS1A1NGlEM0JLTXBLR1VD?=
 =?utf-8?B?czRUcHgwSlRvSlREQXloOWMzQVdKNjZ3eGxHbnMzSlJPTWFHQ2hycFZVVlla?=
 =?utf-8?B?RnByVzQyWXBCU3JWSVlRMkZQQXdiNHJBcHBDUUsyV3hxVTNXcG9GcGYxSTlv?=
 =?utf-8?B?NVpzS2loRzVIVkV0VDZxOTRueWErZDVRQW9oc2hOQjNsem9ZdlBwYi9QbE5L?=
 =?utf-8?B?Rnc4eXRQTGovRHlnMk02U1YvbDdYb3JESEM5anJvOWlJazlBNE5HNGpMcEt5?=
 =?utf-8?B?eTBjb296WmRCcXhIMk5ob3B4aENkdys2WCs0cmYwb2dmaVpMSk1TbVczbmpB?=
 =?utf-8?B?aXhGWC9nZUpidFZNV1pRWDQ1dEMvMlZ2SmJXcGR2OUNobXlDUklRRGJ3NWEy?=
 =?utf-8?B?cEdUc0ZvbmNnSVBMVTduUkdNUXFHM1AybXdSWHJEMks1bkoyVEdPWjRRdGlj?=
 =?utf-8?B?dlBBLzM2S1BpTXBNZVFJNWdJT3l6SzZENXpUM3NNYms5SVdJRmNqV2QrTFlL?=
 =?utf-8?B?VlR3U0NTQ1BmZ3dmWlhqMWdRUldFTkgxYzFsbjlSeEhhbnRsOG5KUDZERy9I?=
 =?utf-8?B?M0VXMEhzNWR6MWZjN3hLRFhYbVNlMXZUUklWLzYySVRiVURqRllCMFRjL25X?=
 =?utf-8?B?azZ4ZVZhOVljSExJTVIwNDNlRE9TZXk3RGtsRjAxaWNRSHZBQWpaUk1Db3pL?=
 =?utf-8?B?dzYrdFUvNFhWbXVob20yMHFaUC9wR2FtelVxcHBXYURWUkRBanpHeEVCSkxI?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7678ca3a-62e9-435e-7137-08ddc93ac7e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:14:05.8027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqKkcShYiRqbT3EFTbSfjA3ySsYkAkhBpKvfhBOkd+KpQlhZm/Bz8VsgAnoBhzyp9nAmMByTloqetzVhSq5/+6qzJ5IDQJQwVVRY0ERYxR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4862
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

On Tue, Jul 22, 2025 at 09:01:42PM +0500, Khadem Ullah wrote:
>    Thanks for the follow up.
>    Understood. That makes sense. However, I’d like to highlight that
>    applications should ideally be robust and interactive enough to handle
>    all edge cases where a segfault or unexpected error might occur. While
>    clear documentation is certainly important, relying solely on it may
>    not be sufficient. In my view, potential segfaults should be handled
>    explicitly in code to ensure stability and to prevent silent failures,
>    especially in production environments.
> 
In fairness, where stability is the main concern, I'd generally recommend
avoiding multi-process entirely. Or, if it has to be used, the primary
process should be a minimal slim one, that sets up the ports and memory and
thereafter sleeps so that it should never crash unexpectedly!

Even with that, if any secondary process dies, you'll still have all the
buffers in use by that secondary process leaked, so for any multiprocess
system the only safe behaviour for the system is to restart all processes
if any process unexpectedly terminate.

/Bruce
