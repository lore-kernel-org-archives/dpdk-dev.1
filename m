Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF52606BDC9
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hR6wmI7P
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2C2140299;
	Wed,  4 Nov 2026 19:00:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 18FB540281;
 Wed,  4 Nov 2026 19:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793815233; x=1825351233;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=DXEAPzNPtxef6deKH7BkOOWpAgiofxOm10fW6XvsPkE=;
 b=hR6wmI7PTCOlIVhln7fj8rxrVQNAb9zkeu3O/nNMtVcIIMweByvndX5f
 ZYyDFT0yc/Y3vyTqltDuFyl8oOh3Pg9KCO0BKKNyvRfrNuU6xPtAfcgn+
 9lI+GqSPMwzYyZ4OoSAneuId+dBbT0j8Uc7dHsDCAXqcRCTc/Zdxy7tkf
 Ml/74CxcpXyOGvZpqgPRU0nmrZkjoGYKPuRYEhyRiYJSPCmr25v/vOA+D
 4I6G/KJWNlcdML/dcrLh1IWj0X3FH3dBqXLzRMxE6E6Dl66U3sJ2qQx9v
 VZwKGS4vHOHkiF4cwzauK0f3coXx3cFDzYPn0I855K9CjQDZAnN4i9b+/ g==;
X-CSE-ConnectionGUID: /1UwmXD9TZS3+yEnyO+ojg==
X-CSE-MsgGUID: UfSlqmVpQeyEiuTVp0SCnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2480882"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2480882"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:00:31 -0800
X-CSE-ConnectionGUID: ZzsF3HrtTzKPoDUc2Gwaaw==
X-CSE-MsgGUID: LLv0gW94QP2yQF8p6IR4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8564685"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:00:30 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:00:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 10:00:29 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:00:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkFVN82mZZPfWcGHLylX04rgNLzw0y/YS1tvHsqjqQoPOekOvtSawYuhVUkBx/ysGSZTJpqJgMkn7RT4+xfP8Kq37kDklk337E7T36KIJiDcZibjompHpXsUowTzOsH8Wy/UWP/4FEZRK0pl+azcEdXDjRqkxjdxoOLvxufGy2ok+fautAiN0awx42443SXH1zZGN51HiMqNFcPieBrmYVqUZ8HrlZNGj7nZR9h2pGUMOu2LqpuRFsYUTTgIg6ILSTuhif9ya2uyFXQ0FUsYjcJ0yXVEr90iwEjC1+LEW2RE5QXnxIzJeKWOzz354dyyT+S44Ugb2dXPDFbSPolDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4o3JpaZu6I7WXOoU/cG7EkIl3srk0unY5v5Mnwo25Y=;
 b=CBHlItCtbBFTHeVcu2l0r9rZZ8REm7A30DG0LSVzIR9hxVjQWfrQrTxtLa+hNLPyzNFF2gUwoPkKIPyOf3AbDYozH9+Lss+Ru2bn8Rl63mgCnfBRsVKgQk3H54D3mTWAjOjzZ65vsCBM7Ncu8D3DYRSUbNiCqYnTM2EEeRqCazP4jGRlCPzxtM7XlbhTfSuLRC8Y3rlZvSrVxV/ZxtucQYCmGxSMPGi35N8kwQ4CVUpAH34pUyO64bc1MayaZaH607w5xHSu1Mx1pxi5UrOCA300JCU4WtHZ73hfBWpnEbTy8inslVyjA43oOWQrYk1FPmejmF4oXG1QtIVlSALGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA4PR11MB201450.namprd11.prod.outlook.com (2603:10b6:207:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 18:00:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 18:00:27 +0000
Date: Wed, 4 Nov 2026 18:00:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Declan Doherty
 <declan.doherty@intel.com>
Subject: Re: [PATCH v2 3/3] net/iavf: fix watchdog clearing reset state
 during recovery
Message-ID: <autytuWo6-EA9dOs@bricha3-mobl1.ger.corp.intel.com>
References: <20261104095510.10246-1-ciara.loftus@intel.com>
 <20261104095510.10246-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104095510.10246-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR05CA0012.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA4PR11MB201450:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf8fa83-27d9-4ff3-e9d8-08df3a9d81ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261022105027099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261102123227099003|4143699003|11063799006|56012099006|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: BZEG+fMPTV3u+FVCjZcIvMWBuW4hGNDV8SRsTbPzaewBk2S+UP0perVULm5dIdDmm3eA7w/5S0xDjTqPP1+v5IQ4vJlhKM5yqF3YuSF0dGUYnt7MlERiZvewCyN5N6iLumdzbSBxKdjN8AK05H7+V997365Q/gTMeYlvDvQ4bWZINNWYGi6Urm/iRkd8uQbxWUy4dpkv4jl0hL6mqUke73nfmkldnV02eGjIogdAcOMQfFkku89GpiT6Y6HDJeBcPdw3z0k1gBtq0TnG4BBzTS+CeXDRpHASAcJrVCOP91IlU/VWGf9ij1v7UvYnc+8fD53mTF0tQhtkfNb1EMVUymboPEVwOFmVgebZGrxVvfTjyN0xCI+h+uT+V2+3+0gPolMaFKFchmcsKX789BTYuomgxbxKW7bv0pCAUFs7U25GzqpVCA6IMmkyFyakRrrg6hQBf1fnGsF9Bds8ER9i9ELlRgY4EDE2zHgovNoz4Hq5CmlNV+nRpT/DsQXBEGTX46TI9mv8W1eDyyOc9PPZeKb1odUgn84hk2SjOEF/feVq08wJJdDS4W8GqLN2WHBhxyIQ6iSK0zqyov6hsHf1oTGEnPnbVApm1XvROqxEE3jURcKfgOsKXSW1T0nRi+3Z10gpBKY2YnR9nJ3j2tXvd1tjEGmHP1DfAmB7a2mWxUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261102123227099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(261009223027099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTY1NjUvT0tlWFZQdFpxRWxMVWRrUjJUNlJDdWRkMUdQMFprMVdTek9IU0Jp?=
 =?utf-8?B?OExkV0ZrYS9FYWlURFRLQmJXeVFob1JSSFZpTUJSY0V2QnV6TVltVmJjMkN6?=
 =?utf-8?B?QTZOUnBxUGFra1Z5aVZmT2hmaVRNYnBOSHRDUUJVZEVGbW9nS21XRklUMGFk?=
 =?utf-8?B?MXJ5a0tQOVJsZVRybUVRMmo4Z21kUXRmNTA5WlJDVFFYdHNib1l0QW5NL09J?=
 =?utf-8?B?akVtVkYvZUdIemNpck1FbWY0NlEzNVhjTHZoN3JjOFR2Z3hXWmNsWlZvS2lZ?=
 =?utf-8?B?N214YkloZ2ZrdHgvdzY0djdnY3F2Um1IdGJEQ0pSVVkyMnFEOVU0NWRTbzZw?=
 =?utf-8?B?MFd0VVdmRkphTU5JYXpEYU5TUmFhU1dQWWg0UWNObmxkbE10dG43ZGt3Tll1?=
 =?utf-8?B?UGFSM01RQUxPZWt2c1Z4bkp4cDNkTDd5Z2JGQk92NFpMQ1Z4OW9pM3JPY3o4?=
 =?utf-8?B?NiswQ0pRKzJTS1FhdjVvaHZSRHZBOVVWamZLT0FBRVZRSTZ1Z0JiVW5NK25L?=
 =?utf-8?B?Ym1GTEkzZi95MEZ5b0tVeFR6KzJlVjFic1IyRHNnekYyL04rTk9UMUZONDh1?=
 =?utf-8?B?MFJCemlDKzVBQXJPYzBoSnd4Z0VqNHQxWXQ0SHV2R05pZFVkYXYxdkZOZklt?=
 =?utf-8?B?ZXFvUGlmUTJHSHJJWkdYZlZSaFc5QlpkV25KY1RISWxYOGV4dXNSUmdBNG1m?=
 =?utf-8?B?QzI4bWdxMk5kc2pSc1ppcE5FN3RjL2o2R1FGcGZkRTRuYmdER1o2c2s5OTd4?=
 =?utf-8?B?VHBIaUluTmhJU1IxYkpOdVlOQlR2U2ZXQzZsS1cvQVpTRThYVlFTVUMycnVj?=
 =?utf-8?B?SC9WMEpwLzJFT3FrVVZoY3hFNTZuOVl5empJVEo4MHVOTzZsS3FGd2VNV0NX?=
 =?utf-8?B?NXRTZFJPckU4ZEJqem1NOXBsSXZ6OWFKWkl0Tys2cFpUYk8vME1pVndGa2Zn?=
 =?utf-8?B?dHJkbGtzMEtuMSs5S2Y2UXVaTUVXSnpwTm5TSjhtZDhRR2hsQ2RZVUxjYnZ2?=
 =?utf-8?B?bmt0RWRnOG0rcXBNeTZYMjk2c3J3c2kydGtlT0w5cEtLc1pITlh6TGJXSmtD?=
 =?utf-8?B?dS9GZUhneUZjSkNuY0dTM2lidGQvdUppTlhGQ3dtTDZCb1NIN3JyNllIc2E5?=
 =?utf-8?B?V1pZVU5SYjhIZm1pa3d3MzlyRXJxZ0lpOTZQcTlSbnZ1aGpiUDFZa2YzdVVr?=
 =?utf-8?B?VWhuY3YwNWF0Ri9MZFZmMGhkcHYydGM5WkdUWUQzWVBTblpWc3BGUVdKdE1T?=
 =?utf-8?B?TU55Z3lmOWNVcHY2V3lremVockVhbFQyenpCN3BsaWlHU2ttUEJ5ekljbnBi?=
 =?utf-8?B?aVNxMUhBL1ZURGNXRUZzVGFmYjZLU1FSYTN0MFJlTG13ZDIxL3ZVSXVpcm05?=
 =?utf-8?B?Zm1mRVBaT1BmUmhLalMvb0JBOUhHZlN6M3pNK3l2VlFSbnR5cCtqSWY2L01H?=
 =?utf-8?B?WUMzWlp5RnZlcGNvOWVnc1VIWENYSUJXa2ZwSytjdm1OWURtT2dGRk84a2Nh?=
 =?utf-8?B?S3pPR2o5S2ppTE5qNlhkZUNDWnFOUTNnT3J4ZGZxalo3R0VVYTRJbjJKNVhu?=
 =?utf-8?B?QnRSSFhlZ0ZkK0g3U2Ztc0tWZFd6K0xBUDI0NC9PVFh2emtCM1YzeG1sQ0lz?=
 =?utf-8?B?WktPcmRWR25xalJlRDlZbTVSSGFGVm9PRG81ZCtxbWRIOGVMSnZaMlU2eU9M?=
 =?utf-8?B?WUFMRE1OYXVaSlJhRnVzWjlsMmpzejFTYmJnTDljS3ZhL1VsWElrc21JdUl6?=
 =?utf-8?B?d3FSa0wzK1RScmhudkJGVURUNWgvdWZLWUJPRHpEMkJzcUpudGZTdDFvcjRy?=
 =?utf-8?B?QnJ1UkplTzNXTHFWdFNLMk8wVzAwclhhZk5IOTVxN2ZBTXFGNC9xTE9hRzls?=
 =?utf-8?B?Uk8vR1RvaXNmc3MxRjFZc05QZGZLdXRiNDV6WDNyWFptOXRTN05IckpDdnow?=
 =?utf-8?B?bWR0dHFGM1g4ampkenNHV2NOT0cyZlB3d0VUWW9qVzJOVStHYzRPbTk2NWNv?=
 =?utf-8?B?bnh2bEgwY1B5MzJ4ay9ScktXa2J5QkErOXFQRktZM2h0U0RLK1Nyd0o1TlJL?=
 =?utf-8?B?OW81MjF1dWJSbWQ5emZUNVNmS01nQ2VTNXVBVjNPb1hvTTNTQUdoZXcwc0FM?=
 =?utf-8?B?dFYva3ZDZmxKZDIzNUVOZmhHUlRSNW1XV1JpcVBma0hOQW9OaE40ZkZkMGFl?=
 =?utf-8?B?cUpydEpVZkhjbnVWVFFLR2NJRmZCRTIwYWp1MXRzQWJ3c3prc09DQTdFd09y?=
 =?utf-8?B?enYvcVMvcUtjUUExc2dxZHk5Qjhpa3Bhc285bDBocFMxUkUrMEdsTWxQNE5y?=
 =?utf-8?B?NXRFK0lPYWxDT1o1RHpNbHoyWGhwRzU4N1dnREhvY05ybmhtc1dDVTBPMmhC?=
 =?utf-8?Q?MRLMr8HKVVbVD0Rc=3D?=
X-Exchange-RoutingPolicyChecked: nSHXBr0WqApQqhgu0NrpaIvc8m5iVhh+42tFbrJfBYEFtoDBp0EPH6aW5GvqcBA3EnvCtqwCf6kk9vbWVQ1XvOApwKeaPT/AQzYCPkkZckpizjF6f2l0PC32Vyodu9dicy3hmCz5O/A2VK8zvmAuugtDwKZ5HgTTjdr55tT7sM4LvsxbufJ9+6epapTSMgEJG867KdzS2Fr/pn4GWzPgmmjlbrCiFHhZ8zSSMtcJkiYD5Tdh4aOoSR3j9EfD9qLAeR9TBTpSQ1DR43Bnlgq3hwuBZHOvLo8d8NnN5BwuMatJdG9y9BCn5QutGkGhqa01R+nKGVYfUoSskkqvNc0Jbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf8fa83-27d9-4ff3-e9d8-08df3a9d81ee
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:00:27.7206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVfYFimO952Muz5UUm/riP44vonfYYFZ/dmuNFWPltYP7FcukMuklpoeklWjIC1gfm3OSsI5zPmoNcQjFXAaT8o6ROaONaMuLKj0zjRG97s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB201450
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:55:09AM +0000, Ciara Loftus wrote:
> Since the watchdog is kept armed across a PF reset, it can clear
> vf_reset while the reset event is still queued or being handled, as
> VFGEN_RSTAT toggles while the PF resets the VF. iavf_dev_close() then
> skips re-enabling PCI bus mastering, which the VF reset cleared, so
> VIRTCHNL_OP_VERSION never reaches the PF, iavf_dev_init() fails and the
> port is left returning -EIO. Each toggle also posts a further reset
> event, causing redundant recovery cycles.
> 
> Count reset events from before vf_reset is set until they have been
> handled, and do not let the watchdog clear vf_reset while any are
> outstanding.
> 
> Fixes: a0e296420a70 ("net/iavf: keep watchdog armed for the whole reset window")
> Cc: stable@dpdk.org
> 
> Suggested-by: Declan Doherty <declan.doherty@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  4 ++-
>  drivers/net/intel/iavf/iavf_ethdev.c | 16 +++++++---
>  drivers/net/intel/iavf/iavf_vchnl.c  | 48 ++++++++++++++++++++--------
>  3 files changed, 48 insertions(+), 20 deletions(-)
> 

While the AI review in CI shows no issues, my own AI review flags that
there is potentially a problem due to vf_reset not being declared atomic.

/Bruce

--- 

The producer and watchdog can run concurrently: the PF reset path handles
messages in the interrupt callback (iavf_ethdev.c:2847), while the watchdog
runs separately.

A concrete interleaving is:

1. The event path increments reset_events_pending, executes the release
fence, then writes vf_reset = true (iavf_vchnl.c:349).

2. The watchdog reads vf_reset as true, checks that hardware reset is no
longer in progress, then loads reset_events_pending (iavf_ethdev.c:338).

3. That acquire load is allowed to observe the old zero value: it
synchronizes with the increment only if it reads from that increment. The
plain vf_reset read does not provide the atomic synchronization, because
the field is still declared as bool (iavf.h:264).  The watchdog can
therefore clear vf_reset while the reset event remains pending, which is
exactly the state this commit aims to prevent. The release/acquire fences
don’t fix this: they do not make the plain flag accesses atomic or
guarantee that observing the flag publishes the counter.

The fix should make vf_reset atomic and use atomic release stores/acquire
loads consistently at its concurrent access sites.


