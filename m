Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A96AE94623
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EE2E40664;
	Tue, 10 Feb 2026 00:19:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id EAF2540655
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:19:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770679165; x=1802215165;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e3uTWg7v/zBYMSAjKw1zjUqIhM0lYR9a2eMZoBoOrrA=;
 b=UdFl8HjL3VDI6oEGU1D+iAmrd4AZFke2RZsGvOd26VSHRzF7+MOx2sh4
 XYbCV40I43l6TacmYJKtHxFbtxO+k75+2c/EO1RdCOWOEKlnQItA4hJ2y
 Sgb1y7SmfZBilpGhQANtGVaU3QA2v0HHRN5tMruIoI4BAnhML3MCnXcpS
 MG48FnZ0N5VwEYyBwPs/vpV2wfIJmNJ2N05pDYHbfvI2j5hz6K53cxyfv
 0so7DjCYF+xIioDsUY1tx4ZSuRJHQkVvcsssnzHxjKg1YfF9s/7E5h8+M
 uYKaY7UV/t2m1yeZQzuzRZ1bdu5fszW6a3CkknQXgRZcGl2fMQrp9WxVL w==;
X-CSE-ConnectionGUID: ggHHsxVzTqWFRdAkpKuk0Q==
X-CSE-MsgGUID: NSG8AmqiRe+pp3bAmxYU/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71840314"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71840314"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:24 -0800
X-CSE-ConnectionGUID: pUCWxsN1QM6gXo83qlXh8Q==
X-CSE-MsgGUID: YVXJ7tRiQFGWjXKcePHegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211749853"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:22 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:19:22 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6x0lIC9MXy+XNQtSvqkUvalIAEmUpsTBbTGfI98ncuk67r0ZGKHVEnS8WiE8Sj+E76nI9P9IKjYwY/Rau5TvzwiHylSfurxOvqwk0gPoeYj0yid/N540oJCY30h2jOqDBYZOgsFlqWkcmCapi6MQ0YLjCnJl80Kp+DbKewt3uEBb7yC9sxhNRSBGjsyFLVPFwUHWM2wyhbrfp9dm2m3el8v1o0jpkkLzF6ubHFdB+yvYlFOcHsJZeR+cFjFKH+ozZyeQ3kuRUlrVNSJKZR1rhhHsjLbh+mc6bHEVLOHoB7W8ByfGQVaruFu8PFqs0/qSUjVEy9RCkuWyqCDt1AmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecbAFBEWyVWmulPPO/5DBI+GkTlTYPnF5HJWNvBFC/A=;
 b=rvOMOeGmeLaFIEFMsxVn8Cw5gEgE7gklLIzYuTVXGy57MxDf+RqZamiGf58QEJfaCIURjL1eKzGqs1ir/i2GrGshRxpeCpnzG5ufHFH9MtozVZG9g1fCkb6+6j9jJNr+G3b/SiA/BZFMk45UupDp0vLmBY+M127SyyTdBT6rkv+v491gttwoGBmleQGonh1qVpvbMTHnYwZN4X9bWOO8M/mJ1LsC1CEUK/IxILjel5PlLP2WMW8UAeMykWH1zwGm9qssY+OE+DNhGx9BCOCesVmdKxPFN1/JuudS649YpeigBEo3adAodZ4Q7dLtwBvA4MBlbIp3U8JSuMUQOB5hRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:19:20 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Mon, 9 Feb 2026
 23:19:20 +0000
Message-ID: <06e946fa-6cd2-471e-bf45-7d3ca7073f2c@intel.com>
Date: Mon, 9 Feb 2026 23:19:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/35] net/intel: complete merging simple Tx paths
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-31-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260209164538.1428499-31-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0442.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::15) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: a2efc8ad-375f-4b5f-e211-08de6831a766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXd5WjBxOTI1eVFZYzk0Nlc4djI1VTE3VDdxUDVGOXVOa0lpNVY5MGxmVEU3?=
 =?utf-8?B?QTRuc29qdHNDRWlBWHZRUzI1K1p4cUc1WG90RFRVbDVKRTc5amlocjBIWlFs?=
 =?utf-8?B?Ry9CNTdpVVZWeUYzSmIvMmpWSXZCYUg3bjBGdU1UeGhoUGxSL2RCM2x4Yjg4?=
 =?utf-8?B?YUtEbDNjWWQ5RVB3RThDTGxyemdUNm1TMHVRWmxmM2V0bWszREk5M1dTRnRP?=
 =?utf-8?B?WkxxTElqU0hBN2JscC9jaXV3UEo3NDJBMHJxSFV6eW4zWUtUYkgvUkc0ekM5?=
 =?utf-8?B?RFcrczBHZHQyTlBZNGtWQU83UkR4QWsxYk42VG1vRFRoMUNkVi9YU0Jtencx?=
 =?utf-8?B?eHUyaVpmMjB2V1RZa0pyV2huTGo3aVpMdDhzU1NmWjBTMVVxb0tNWEl1NlJi?=
 =?utf-8?B?RmY1TXFPUzVxMUZEVHMxQ0s5R1J4VURaaHZFM29KVnkwVVBsTUFqSXB6TXF5?=
 =?utf-8?B?bEZ5aVozb2NOcEJhQWRQbE1zYTF1cEVxWEZ3MjZwcXRRbnJyZjZLWkhPOWNS?=
 =?utf-8?B?TEdOaktxQlFYdGk5R2k3V3ViS0srelJnOHYxVXZ4RXlENVRFS2ttU1FqSEkr?=
 =?utf-8?B?QXVaeW5jUXJXaUppZGdLREFxQjZPM0pHZnBvRGFZZDU0a2pQa3I3VWhZS0lQ?=
 =?utf-8?B?QUxteVhyWDgvbDRwa25OcTVWTURZc2ZXKzhYUHloY1V2ZDBSendtb01VN3hD?=
 =?utf-8?B?R2JIT3ZmdTV4bDI4c05POXllb0M4S1FGSDFiQVlrc3RzRjFYVXB0bGRCbDVV?=
 =?utf-8?B?b1FsdSt2WlRTR3llV3EwdUJKeHdsOFVYNEt5WDZ4cENzLy9SNzk2MDQ4eWxh?=
 =?utf-8?B?S1RkM3Y2dElIUm9MRlFmRGs2Qko1Z0tYdStJV285Ni9RS1dHUkd0ZXQzUzEx?=
 =?utf-8?B?VFJIK1p1TjdESXdZU0xJSUZUWXRCMmdLTDFOMGNiVmNhK3ZKcDJycTdmN1BW?=
 =?utf-8?B?RnZRTjF1dnkyOHhZMVVFcVdUYUEvOE5MdGt0bFJBV2d0bVh1V3g2dkVpSjcx?=
 =?utf-8?B?TXRFNVlkRk4zYk90MncxNmhqYUpTMllsTXJmMjVZTXNPY2dPRG1XRy9TNHEx?=
 =?utf-8?B?YlNXUVdsTDdLYlBIUlU0OUlZSXBWMDk4ZVpGM0Fpams4dVUybk9rTVEvQzIv?=
 =?utf-8?B?L2JUZ1VXV2pPQXQvR2dvSWdXSGxXTllSTjREeFdhZkNuK1lMNVdGWXQ1bXV4?=
 =?utf-8?B?RGd3OXIwaDRjd3BMbmppYksvMSswYm52NlMvK29PSy9INDlpdldyY3RaYlRD?=
 =?utf-8?B?UnVEQUVRQ3JmTEN6VVU4b0RIN1JidjBVTVViUG0zbGNKY09vZDlqa3RrMnQ0?=
 =?utf-8?B?RjlNa2o0RnNraHJUM04waTlrdG5KVi85Q0RXMU82NzM1WmlzWkhJUlNvZmp5?=
 =?utf-8?B?b2F3VGlNR21yVDZkdGRiNnNGSjZFRDZlNXA0Q1QwMWc2K0pHZzcyK2ZCQjh2?=
 =?utf-8?B?dVFTMjhOMFZ4QWRlWVREWVhia2g1TVhETEpmazIwWXdGdjJHc2VjM25pazc5?=
 =?utf-8?B?L05ia3pWNXFDeVZtU0xTOVNHRml3djh1QWx6ZjBIclZOeWlmWHZIczRwTHhq?=
 =?utf-8?B?V3IxUmhDYzFxNHNlcnFNN1JjMlBkNVhMb3hiWE8vNmhQTU1YRXNzMmlUSzVv?=
 =?utf-8?B?N21OaWd5Wkk1a1Z0dG9NVnV2ZTBNbzd4VDJmYTlhaGhBN0oySmdDUVQ5SkFN?=
 =?utf-8?B?Q1VoR21zZ0hXTUNDWjJ4d0YvcmFUdGUxSG1PT3hqRjZwSUFtdHBwSlpvNzEr?=
 =?utf-8?B?UHVUN0UyVW01RzIrbUZMQldxVzJrZTdNV3VTL0hxT1Z6ZmhUZ1oyR3lQYXZF?=
 =?utf-8?B?TXJydXUyaTdzak5idU1OVjRDMjd6Z01ibStGZ0VHNTZpcjY4Rnk1ODVBcHgv?=
 =?utf-8?B?UnpJRGN2WGxoZG9PM0NIL3YvU2pKeE5yaVRCZ2NGaVpNZUpIOXVLT3pEMkkx?=
 =?utf-8?B?TXVvL0FtT2hraDZLUlNtZlFsVGhhYXd3d0FPTXNSLzRpRG5jcmJYaUNOenBM?=
 =?utf-8?B?Tkh4SktkekxxeEtjblMvYy9KYXllWVpHekpsWWJXemVaMmk4M1ZPWDl1RDFF?=
 =?utf-8?B?VldFUGNQeitxclVYNlhqWDJ4TUk1bWxjWHNBZThGQy81aE9BWHpYKzV2MlhV?=
 =?utf-8?Q?FHxs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US91L09HcXZUUUoxS0hZRkdQTUxmT1NoNG5UTGxycU9qdVJMaUVvaForRml6?=
 =?utf-8?B?S1RwV2xIRml2NTFpdFlEbCsrMWp1d0xyTkhpRHJNSjBUSXdUOWdyYVgxUEUx?=
 =?utf-8?B?bHBxQy9NOUFnSjBkanhCQ1BYZzJneGdiZzNrWTF5M3lJVGFJZ2h2eWw5WXp5?=
 =?utf-8?B?UGFBbUVkZFhPUzFBNXlpUnVUU2EzU2ZPME4vZDFUK0Roa1pPY3AwblJRRXU3?=
 =?utf-8?B?SmpDS2RpWWI0ZEp5eHBPS2ZUcXZqMWhuZzNud09hUHFQU0dhQ1B2VVFWa1Vz?=
 =?utf-8?B?a1lYZjAxUDlHc0VrdWFwV3Q3VWdnYWYrTU5YRElqcTNzQWs0K21BOFB0d1V1?=
 =?utf-8?B?K3BCOTRTOHZNbDZXSGwxaSszUko2dDQ2bmZxdkdvNkhGQ3A5WGdkemVQK21W?=
 =?utf-8?B?eHJhL25vbmRBM0U0cFZnN3JyR1ZoZVpSWFRiSDFpNmhQZ2Z0Q3pRR0ZlTzc0?=
 =?utf-8?B?OTZUOVUrVDNCNERJSlp2NVBrNVhaekdoTUxzd1FONTJRdlF0U1BBNlVpdS85?=
 =?utf-8?B?bTBRNDZvd05qQnl5eUdpbFpZaVkvV3VVSzNwNGg1NDdZR3lINVdsV1Z6ZUtQ?=
 =?utf-8?B?MnM3eUdsYlduNXE1TmpFSHhUMXEyMmIxaUFCSGR2RkltQWNNOEx0bGdtSlBE?=
 =?utf-8?B?RDkrSjN3V3E1Y3ByR24zUi9zbENGRFp5aUM5NndVT2hULzlXNlc5VkpaN0cz?=
 =?utf-8?B?eTFRd3lVRXZkcjZtb09IY1ZyQ0xkaDJhWEtRMmVCckpZQzNpOTY4MElkZU1V?=
 =?utf-8?B?UnRJbWpWUEVuekZrYkZ5SW1pL1kvOXY5dTRPUEpVSGZNR0xKbVc2b05IdWdG?=
 =?utf-8?B?QmwxdjkyN3FIcGNva0NTTGxWMG5iQnZFby9rTVBnWmJVcVFKU0RiUTE5b3pj?=
 =?utf-8?B?QXB0bk9hN21MNHl0OGlXajlhcHdZUXNXcHNyQ2tTa0ViN1d6V0dZdWpFRzNa?=
 =?utf-8?B?L1V6U2FzWDFWWHloL3BHbmUrVmJuNlBJNFFnRndudklkY1YxcllZeGk2aUti?=
 =?utf-8?B?Sk41Q2RnODl3MzRDQWVSUUxVbUZJSnQ4QlF4MzdtRUtrYzdZNFVYK3lQZ2Yv?=
 =?utf-8?B?VGZ1T3AvQVZCSjBDQ2NHUHBheHFPQTg1T0FuUGd6cHNjNjJFN3hSN08zREVP?=
 =?utf-8?B?cEVtcGE1WTQ4em4xK2dyNm9ES3VsQlQyeWZiSUNZbWlUeVFlSy9WUFlIK01W?=
 =?utf-8?B?SzFTcDZmWWFrak83MVRMRnJXMDhCeDN4NEEyd1V1bFp5V2tqcTFhSWdIQzg3?=
 =?utf-8?B?bGdBSlE1ajAvaWx1akk5R0RBdWtsT1J4SWJqUlFrb2EvNk5DemJjZzAyNjFu?=
 =?utf-8?B?WWM4TWtsZGJvd0kzN1I5aGx3T3lrOXdEb2FNdEFHQXQwcDNOcUExcmRuYUh3?=
 =?utf-8?B?eWdBSlNOekxCZFYwQUpHZHdZd2QzTWYvbHhzNGhrclUrbWI3bjR3SklBenR0?=
 =?utf-8?B?YXMyc0xabXdlK3NKTHM1QlJzeTVTT2trSnJXb3dOSElEK3JtQ0tvaU5HcFVK?=
 =?utf-8?B?YzBYRTB5dDMrTDFiQUdocCtIOFdlMXZhbHowZ2Z5aTVBZWNMTXc3elFEbmRy?=
 =?utf-8?B?ZytqeWIzYkVoZWk1UXpMZW01MGdWNTJTZWpjWWRJRTEyQmwvV2s2bk1wUy9v?=
 =?utf-8?B?bXNYbjZ1Rzh2TGRNUkIreGFJTVVFL0QvSWNOL3VzVGRwN2g2RzN4M1ZxekJj?=
 =?utf-8?B?a2hJRlkxN1A3d01ZMWc4NnY0YzUyTnVqRENXbEpiK2Vhd0N6Y1M3Qms5Yjkz?=
 =?utf-8?B?UXBnODNMNU5TR1M2R2V4YXJ0OHBTS1dST0Erai8zYjVnRitINTVZRDNFWksr?=
 =?utf-8?B?NDdzNEUrajVSRDN2VWtTQzNRSERjak9LQmw4UlFJemNFRExRaUk3VWljWjFZ?=
 =?utf-8?B?eTdCMU02dm5SWm4xb0E4MmxiVTFxRjgvV2ExazkxT2I1WVNzWDNYZ3FsZFRL?=
 =?utf-8?B?ZkVYdkZZUUtBTWsxNDVtRTl4N1RmTi9OUVVFdmpmU1VZZVIvbnJPS3QycHQw?=
 =?utf-8?B?R1NCWlBFcmtHUmVxb1VUcnpydVBua2hLZXBkS2NqTVVoQW5ORFNnaUZ5WGsx?=
 =?utf-8?B?UUl3Wm14Qm9tUkIycXFJcUJVUDIvNkU2aDB4aG5NNWY5YlZ6SHd5TFozNlZC?=
 =?utf-8?B?T05HeFpndGdJUkhoVE9ZMG1ETG9uSEdUOW12cklnV1llcUZiMGk1RjlTZ2M1?=
 =?utf-8?B?TysxZ1NVNkRNVFMvWllGdWdBdWNWY1RXQ1JRTzF6TXpHdTVrbzVxdlZTNVRV?=
 =?utf-8?B?SFhnU1RNZ0JUUmk1R2hiQnBYSFp2OVdRTU9JVCs4Z1ZOazYzR0gwRCtWMXFn?=
 =?utf-8?B?S05QT2w5M2VRMmI2aDFQRkR6c2E3UkdGSjE3QW5hWHNTR2pWRWw3dU5tV1pv?=
 =?utf-8?Q?lrYjDjBLeXnPoMVk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2efc8ad-375f-4b5f-e211-08de6831a766
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:19:20.7069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/2t5wFW3k31YL9G4AkY7wRgSxR4zH8/J5+N1ikegbYIUxiMx8SSBTrgQ7017llplwvJAfvPvy6S2/l/ToeNdX3iThoRTh5hATc2aEfiDek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/9/2026 4:45 PM, Bruce Richardson wrote:
> Complete the deduplication/merger of the ice and i40e Tx simple scalar
> paths.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx_scalar.h | 87 ++++++++++++++++++++++++++++
>   drivers/net/intel/i40e/i40e_rxtx.c   | 74 +----------------------
>   drivers/net/intel/ice/ice_rxtx.c     | 74 +----------------------
>   3 files changed, 89 insertions(+), 146 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

