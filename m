Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402F0C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 13:09:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 052FA4025D;
	Fri,  9 May 2025 15:09:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id DDBD54025A
 for <dev@dpdk.org>; Fri,  9 May 2025 15:08:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746796139; x=1778332139;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=sP6TGk3dKQRhnMjC7jm6nKJYuaybG9bqRCWUN5tnEMA=;
 b=AXW7MERH+XRtTZGDu0ni3HwDrLWZH25GorVPUKGl2JC8bJ1C53IOUOzk
 zlcJgBPxjNPN733dTxS6Hq3AOGin94yRAN6HXppDEgVWaHEBFKSVUEtzh
 mG2uFVLnQQ5YjNfjQh+R+tpq12Lvsi7C5BK6IgZz5LOSaqqBAVXx8z/Co
 PIFy/F32zYsSGxhhUyte1YQ7pRIYmUKHfqtSw6oYFI0Uf88tP0WrhLAc7
 bt96KA+cX1tnaYURFvJPo7IoizC03P1H9x8g1xH/5S6bXY/weUhgq5R7D
 Ry9naPZpcB5JtRJECoXjA23bbeudT3yilOQFGAGVw81zVybmQd7TS/Alo Q==;
X-CSE-ConnectionGUID: dQI8G7NESBWWjWBIb+3XoQ==
X-CSE-MsgGUID: PH5hjr5PQA+iApBKYfWTig==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="71131620"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="71131620"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 06:08:57 -0700
X-CSE-ConnectionGUID: czU4fDtcQqeh/3DFvfcJ0w==
X-CSE-MsgGUID: CUyjwg0VSqad3wWMbtZBWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="167547086"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 06:08:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 06:08:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 06:08:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 06:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDkAqecFVsAF7CtkzAb3G31Xjkhbli6jvh1aKoGN9iiQbZvj6+cJjgLNEoHCdOuUCbBBOx6zACMWw/trmvnCPDw1FziWZEb/EcVpCzFMkcNHjYe1MKPbNZlRpB5oQG2rkif6hmtJlffQKF7ZqK6p8QwjGS60+sXIG6BzVRwxCFMiwAaavsPTXPG9A7mOg3gJRiM7nTL3cwujjm6Dfn5cuBP95AyNJUcRAPCas4uH3WYzoRXSZ+ZKgjQNsyQZqy8YBFeTWUHkVI6NPUzAoGihHfoTllsuTuP7plHklvRv2zs+R+atBC5vx58a48QSY1+Qon5tnqIOBNINWqqovhUa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOk26gOr1WZSds982lrDSv64Zdekpqu9GszQVBj8gWU=;
 b=HDvXxkL6/bU+iJ41wy1NVazzLcf3MN1q/SxRaXGFVOBKLx2j9YRn5dTgFJNza1t67fsxMVkN46oDz30QSR9w6s/EG33mXJrYM9Y4es66SNrHTMojCIPO7qA87zgHZ0HYcjefyBtnkXpHvUSkNqZVmdCvO754GnHWyCO8Qh3RtGki1/MRUwHy4NU1zDzp4jBFLt5PuprMC4XRF5FPTWRsUIkB3UgZQrxOYI63T00Bga8IfyrMafZlt2dIfijZilyy/0oS3YP/YdBvkYRf1UI6NE6W2yzxFyqYxywfRryw/t+MoR06jSKM90DC07U1Dw5i0IYX00ULKxZMAlBNxj4uLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB4942.namprd11.prod.outlook.com (2603:10b6:a03:2ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 13:08:27 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Fri, 9 May 2025
 13:08:27 +0000
Message-ID: <53015359-0725-46a5-b186-aad90f01a81e@intel.com>
Date: Fri, 9 May 2025 15:08:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] cmdline: use C standard library as number parser
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <7bebd92be36f945c175382bb1e0482e55844c1d2.1746710154.git.anatoly.burakov@intel.com>
 <ebb1b821-0138-4f64-bdb0-d86b7eab48a8@intel.com>
Content-Language: en-US
In-Reply-To: <ebb1b821-0138-4f64-bdb0-d86b7eab48a8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2P251CA0009.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d127efe-4a80-4958-7149-08dd8efa962c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTE2NXpReGNZV1R6WUh1NGFlcXAvL0Q4N040eFNHdzFYM1Z2dUdZZGZ0QlR3?=
 =?utf-8?B?STI2aUxTL0RzUUIyYmoxRDFVMVEzTm5jWWNsckZaUkI2Y3NXUExwckNHb2xT?=
 =?utf-8?B?SzUvVG96eXFxODZOOE1FZmFDWGJacmg0UlNDQU9nYUdXWFdUQzhwSEdmTENB?=
 =?utf-8?B?NlptSzVRcW5MVnJHeFZjbjZDWVZaODdpWEpJT3g4RHhqVDJwM1VweXVpemgv?=
 =?utf-8?B?b3FEeVljWHJRTWdXdy9SOGszWlVjNmt1cnVlWnkydkE2QWwxaTVJb0RZWmlP?=
 =?utf-8?B?YUdIdWMrMUM2TTFCU3ZxRm5iU1J1cmlqZXJSTlc4eUt4Sm80UG5jUU0zczl0?=
 =?utf-8?B?dTFhT1ZPbTBZUFNGazhqZzJSUTNhd01oekxST09uamZ1a3N0YWd4VzhUR0Vu?=
 =?utf-8?B?QWxPQk11S09iRzhuQWRUR253MWJTQlB4ZFEzWEpvWXYwbTdLWFQ0cDRtTGZq?=
 =?utf-8?B?Nmd3c0JFdHVkOTNUZEc1YTNMbGtncitMbnBCbzNyRldkdzF0c0Q1K3gwSHBV?=
 =?utf-8?B?M1NsT2x5Zm00b3p5c01KOVZrZjR3N015d1RmZ2Nyc2k5MFFLNFhqOHFoOUkr?=
 =?utf-8?B?emU4QTVlZTZya29tR0dUVWtmeHJURk9Ia3diblV6Z0tGU05ZOUZmRmY3T3R6?=
 =?utf-8?B?M04xdm9qM295Y3g3RUNyN2J0MC9YdkwvUU1YQW5qZnNiYmFHZjFpTGRVcWh2?=
 =?utf-8?B?bE43NDNIT2ZLbXVia0VmYXhmSStobjhnZGREc3FacUZ4aWlZaTJoZmVJT0cr?=
 =?utf-8?B?T1ljbmVhMitTSFRNYkdreTFNTENLVnl3RytXWVZ0QTlIdCsrdGNrTmR5QW5y?=
 =?utf-8?B?VitpWUJMeldQcnhhVzFqdlN5M2NqbFB5bUNoWE1tU0ZGTm5kbmRWVy9oVXd3?=
 =?utf-8?B?dy9UQmp1enp5REZKR1ArNkJmeWd2UmdYWVNqNDVhd1U0a1FuOEk5c2xzVFFk?=
 =?utf-8?B?WDNEbXA3SGxqWEcrSVVhNlVULzNUSVdRNC9GeGRJWm1UZDhoWllGRE5BVDly?=
 =?utf-8?B?WlZMM1g5QUc4NXBIdzg5QXFJT2hRY285UjkyUmdSaGNXaFdHWXhoY1BReDRY?=
 =?utf-8?B?RUloMmV1bVF6SXU3d01rd3JCWGxGSHRITWpIWEFsNWtRRVJDUkJIREtnUCtz?=
 =?utf-8?B?ZExidVk1bi9MUDR5Y2VzLzNrT0ZnbG1PekxKL0J1bnRNME45VEFCRTloVnVm?=
 =?utf-8?B?eWpTK2pSVDdWdHV5d0cxRzQ4c0UrSzQxck1TMTFaMk03RGdlb2ljRkN1d2FY?=
 =?utf-8?B?bGMwODlMWjViSjlyOCtmc0pNRVpSNDU4YVhXYm1aLytiVlVWSGxWOVlPT1d6?=
 =?utf-8?B?d3NDQmEwdnMrNDE3QzdxR1FtcG8wQWlxczkxVTUyT2gwQXM4dGhuc2FmNlZF?=
 =?utf-8?B?UGVnbnIzNC9FcmZnMXhaR3hENURZblMrMjQ1alEyZEJOcGRCR3BNQURsYXhq?=
 =?utf-8?B?a0wwOTRZN1FLcnN3NjZJcGdXVUN5ZEhKZWRocElUYmhhWCt0RnpSNjUwdTA3?=
 =?utf-8?B?MFpZS05iZTljSG1MRFI5b3NpaGJSWnF0M1ZHMmpqUjJ0RTJkc3lGK2lTUE9z?=
 =?utf-8?B?RE93US9kQy9oTWFiWDZIK0NBaTNZMkdKNGJ6NXQyTFk3Vm1uaE9VdGNJMHVR?=
 =?utf-8?B?TlFTNFVSa24vcFdIRnFoOE50M1p2QnoyWDJLeHhXaW9nbDE3NTRFWXpQTDRN?=
 =?utf-8?B?TEJsYXk3K2JDZDVBN2h5NHNxT0Q3eHIzUkpTNzE1YkYwV1gvRFh1Y3B3eHVh?=
 =?utf-8?B?ZXpRUlZrUi9zT1pXd25aMkVvV2cycWdxQWwzWVp4aC9ROVIrNUltVXFFaGhS?=
 =?utf-8?B?UDhZRTJmZHZTM3NsVXp0WW1YaDFnSW95SmpUd3p2c0FmNXFBWkd0MG9QSlA1?=
 =?utf-8?B?N1cwT2FBd2Ztbk9sMEx6NkZLUEZZUmd6LzVobWN3azBrVXQyVXNJZDlIYUFW?=
 =?utf-8?Q?eywYiDDCrYU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3kyNVRGN3p2UytkNm9VVHBuV3U4Z2JnZGw4VWw5WmVvWklkSGZwT05DTjZG?=
 =?utf-8?B?SFpjN0l4RzBSclZPcHN0NHIyTVlxQkZxVk9ZdkNaYzRkRXNwRDQ0NzgrbVhS?=
 =?utf-8?B?NHoyT2pIYmRaS3JtS3R6WG5XY1lLTDhkdzUwRjJoWEwwUTRSMHQ1R01VNGht?=
 =?utf-8?B?RitwNlA5QXl5MHBpUVZueERkNDJXeTBKSGVQM1VoYVVTVXRMTU1EMmNMcDQv?=
 =?utf-8?B?RGRIY1UwbUhVQmJDc0pWOWUzZkhFdEZ1WjlYQUwwdms1VnE2dXVNcWFNNm1M?=
 =?utf-8?B?R2o1Y0NiVnNDT1RaUVRNaDhOdnBSUkJrK0dtV1lZckdnMStqSnRITVhjVkRs?=
 =?utf-8?B?ZmFFT2tldUgyc3daUHdmcVNDaFdobHMwR0lpUGIwNzRhMjJnOE1GUWdzYkpZ?=
 =?utf-8?B?RG9YaFgrdFNFbngzWjBRREdidkZ1OW80RU53WTZLTmd6RlBQS3VORGNXLy9D?=
 =?utf-8?B?eVdXSDhJVERyWTFvQ2YzWFk1TWd3aUZDRmMzY1RPOE44QmRZN3lkQzIzQVIr?=
 =?utf-8?B?UHphWS9GTEFHYUpCQm9wWVRVbVlyOGk0aXBXeFZDaHZaaFBrZWtKbnI1S05x?=
 =?utf-8?B?Q3QvcWNXcEF4V1RaYWpXd3c4a0FnOVZZYW15bG5rMGNwTWtQLytkcFcwOUpH?=
 =?utf-8?B?L1FhckJQYldJS3BjaXFMcUdNNGEySEUrd29NaGltZ2dvd1J4YzdudDIrd3Vj?=
 =?utf-8?B?V243NWpUQUFRZzl5SHlDZ2ZMRFhOWUdQaDZEME9CdU5xWmU3TFBON1RrelEx?=
 =?utf-8?B?SFNUSGVaQmg0ZmNGMU5VaTdRSTBQeWVDTzRrQXg3ZWhhUXVEaUdRdDF2Tk5z?=
 =?utf-8?B?Qmo4NGtiVkVua3ZGa0hTMGc4U0VRSzBVdUZsaWZvb3hhVXJmUGZuSlBodnE1?=
 =?utf-8?B?YW9rOHQ4cDRQQ0VoT1R6OGlnQzlLK1E4MVZUZGF6WHRONm5paFdjRjhweGt2?=
 =?utf-8?B?MjlCak8vMGMvZnJiZFF4aW9RaFU3R1V3bDE0aXJsc3hvRnlGd3E2SzRnM3hy?=
 =?utf-8?B?ODFWQmJ2WXJnZTZtZmxheWx3WmlVYTdwNk9tbnZJc09HYUlxeUVrbUxhampJ?=
 =?utf-8?B?REI0ZXJNdEpMNE1GeVkrak1zNGdyYVZPYTVvc3ZqQ1BVR2xDRzlZbzZ0RlFn?=
 =?utf-8?B?NzVqWTRaNVFzTCt3b0F2ZlpIdGpIZWw2MWU3dU5sbHB1Vzd4T3lkZ3dOL1lV?=
 =?utf-8?B?cGhjL04vWCtJZXIrS3JHQld0MiszemFRRVFNR3BJSFVzM0dENHR0L1NLc1Nl?=
 =?utf-8?B?djdOU3hqTE1SMW5SKzg0M05tR1RXUkM3dTRFcmhZU1dmL2hZZ2VXd24rQU9r?=
 =?utf-8?B?NGFWa0R6SkdUUWdOMWZiMFd2Y0xzNnFTVjRJSmZwa3pXV3ErZWVvK2M5cVEr?=
 =?utf-8?B?UHZZbXdpdE85VjZFdUFKYytoYzQ1L2JjNFV3b1h5ZVZlcWNOUFdRS2gzL3lH?=
 =?utf-8?B?VGppSDVQU2ZtSkdXV3AraFpidWo5bWEzbkJzclUvL2ZHSDE3TExUV0tUU1F0?=
 =?utf-8?B?eE1DUitHTHArcDU0VTJ4TThhVEFSaXk3aWovdzI3SW5BNVRLZmk5R2NnNjBM?=
 =?utf-8?B?N085QzVkOGxwMEhLbVliVHpHZGdYVlIvNy9RaXMvL1ZuVG96ZnVVd1ZsbFM5?=
 =?utf-8?B?UFNIemhoekVyRUZQb3JQaHZ4aEFOS0R6V0dCQzhDcmVVRnVQdmpKbDJsVVhG?=
 =?utf-8?B?MjR1K0ZhU0N1cWlULzRMVEFleWpLZ1pDeGs4dHBtN2htK0dOdFluSnJ0bllK?=
 =?utf-8?B?dk56ZTF2WjNUYUQrZklsUnBRMTJLWTF1cm1GeGxpdW5jSE9rZ0Zycno4Q1Ix?=
 =?utf-8?B?M2ZpWHl2YkpoOFJ6RXRqK1llSGsxWVJNS3BaeCsydHVrRW1qeG15bTZ6WDh2?=
 =?utf-8?B?ejBXQ2VMQ0xsaVJXaHBjdlNTaTdUTEZNaHVSbHZYdXFRYW0wSm1tZ0tVWVB5?=
 =?utf-8?B?aEJUaElYS2t3c0gzRWV1SFc4bWRqbkI5cUhPU0hHZ09lais3eUZsMVlMN2JL?=
 =?utf-8?B?eWxqdGQxWm9sVWVrb21jYlZxNmJOVzVXZjJqS0pQRWFBMWxwV2JPSWdsV2pt?=
 =?utf-8?B?MnJrRXhlVUIrcytZVlYyNWJGWVhpdWs2YVl6VXlibG9laWRQdExLNDlUTm5M?=
 =?utf-8?B?K2h2RHh4cFVIOVY3Z2ZsZEdLQkM4bTZTY2RwQ2tKUm0vSXBpSTkvSWxGZ2hU?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d127efe-4a80-4958-7149-08dd8efa962c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 13:08:27.0017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2hMSckTl2H6Y9bsAZY8h/jIdEgxxizWv+x7p5+qCfTB7mbFF1y9yYW+XQcDEyfJo7cPpRM2RT53m91KXjYkqOIIENC3xTjkO+hjeP1mUKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4942
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

On 5/9/2025 3:02 PM, Burakov, Anatoly wrote:
> On 5/8/2025 3:16 PM, Anatoly Burakov wrote:
>> Remove custom number parser and use C standard library instead. In 
>> order to
>> keep compatibility with earlier versions of the parser, we have to take
>> into account a couple of quirks:
>>
>> - We did not consider "negative" numbers to be valid for anything other
>>    than base-10 numbers, whereas C standard library does. Adjust the 
>> tests
>>    to match the new behavior.
>> - We did not consider numbers such as "+4" to be valid, whereas C
>>    standard library does. Adjust the tests to match the new behavior.
>> - C standard library's strtoull does not do range checks on negative
>>    numbers, so we have to parse knowingly-negative numbers as signed.
>> - C standard library does not support binary numbers, so we keep 
>> around the
>>    relevant parts of the custom parser in place to support binary 
>> numbers.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>
>> Notes:
>>      v7 -> v8:
>>      - Added the commented-out out-of-bounds check back
>>      - Replaced debug print messages to ensure they don't attempt to
>>        index the num_help[] array (should fix compile errors)
>>      v5 -> v6:
>>      - Allowed more negative numbers (such as negative octals or hex)
>>      - Updated unit tests to check new cases
>>      - Small refactoring of code to reduce amount of noise
>>      - More verbose debug output
>>      v4 -> v5:
>>      - Added this commit
> 
> There is a unit test failure coming specifically from this commit, that 
> only happens on ARM. Log:
> 
> Error: parsing -0b0111010101 as INT16 succeeded!
> 
> That is, when confronted with a negative binary string, it seems that 
> strtoll will report success, whereas other platforms report failure. I'm 
> confused, is libc strtoll different on ARM? I don't have an ARM platform 
> available to test this so I don't know why this is happening.
> 

Correction: it seems that newer libc versions have added support for 
binary formats. I'll therefore amend the tests to account for that.

-- 
Thanks,
Anatoly
