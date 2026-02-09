Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF338E94622
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6C744066D;
	Tue, 10 Feb 2026 00:19:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id CF837400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770679175; x=1802215175;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=+2Qk1yx+gy06jrbNXA5GSho4DZZzV2/4vxjxTqZFmCw=;
 b=JY8Fw8dJn+/N57kYohnmFRjnLXh/YCvorDfZCMM/aZFVED/YS/Y6Ypwz
 UuODlfUgcWoaCebP0MQJkTq2cj5IZNQI93lMaJk+B6flCUIn7arlzZWK3
 FXUIjt/Tv37INZ/ZUBHyyGj1RpzpE7DtC7aig2k8b8lQRGiHeQQWQ4Sv8
 9oHZ6VZGzxWuBvm+uAYGMFOhqP8p4LjJNfZiXAGiwq0+9uFNGTUi3i4XE
 12Yz4JyY817wj9RcYEidtX7nKiH9wIO7mTXKva+FcUcMyBdD0D7nXZi84
 BGqxPjvEo4VOZfwXNc4hMZOn4o4bIe2tsfPf5JzXUzk8XENOgVXZvRklm A==;
X-CSE-ConnectionGUID: H91Img4gTAqNSsAHZJY+ug==
X-CSE-MsgGUID: NMzHO1rERAi25MvIrnaIOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89382876"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89382876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:33 -0800
X-CSE-ConnectionGUID: j9CN3h9PT2iLv7QcIX+WFg==
X-CSE-MsgGUID: Ct4NXCvVS1+dHBzr3e85oQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:19:33 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6zjHX83Is9zQRKpve1nJFxGkNTP/MD4RdR7S/G0r1uRIRSWjRVjTVjEBWrrITruvgHDDs1ICX5z2YbwQgPkEPQrjNBXit6CEheV3nYeCGuufuhLFjMiU782lCuNW4EYIKkUi2Xq6DgsemvKUwv3e4mYZz3V7W5IE+NgVYqLfjA782SIp090xHXPoOXZ8/ZCHERMGkFTtUp8wZ0Sc+SW/PpgtLfiwpcpMdhFop9S302LP9bEbKrfSHbR0XBbRnd//h7rHu2tPt0A09UW+K2KMdT+gegpTsIq/AyuOcvo5io0EzbywQ12X6meQ6RW0vXwbtrODuskBZ/M+G28QMvqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSnfD/s/trF4/JzpyLwU1EV6uN2V6yPcEqfYHeoqo/4=;
 b=iTuV1EJmyokdj+rSZnSfP1ujbF2KDkHVArBrivVAUMKNLxo+jtdnc78gk8Bj6e2CnZ3Kwqrjc5nGc3I1Nnnorsy7RweIlZtK0hXUjwhLuOpxEUAp8Wm+YIh7fr1Zovkqfm0286nNCNQf8oEuSjAfDLwhS7+xV4PNN/a+uim/XjcI8ff3njr/wiTNKyFZwvD/0n6EpUnldO/0URU2/VInXFTYWZshW4ZlQUVUBPl3U+B+WYtDKQAAlALh6G1oevpdAB3T7XSP68z7vY8rqoL9Gzx61H3WYNC9bzmH3JaAZpFdIrQWIxz5KZ2oBvxK2v6baxAEdfjMQuD5cjtNyf+Vew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:19:29 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Mon, 9 Feb 2026
 23:19:29 +0000
Message-ID: <3b33492d-cb43-4387-8b27-f663741d9567@intel.com>
Date: Mon, 9 Feb 2026 23:19:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 32/35] net/intel: align scalar simple Tx path with
 vector logic
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-33-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260209164538.1428499-33-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0442.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::15) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9f64c9-34cf-4cb9-8f25-08de6831ac61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3dIS3NtVlBOR0NGdHZkbllSWk1KNGgrcVN2TWN6SVYzRCt3YTdxZUJGa1By?=
 =?utf-8?B?T2hyV1JhL29ILzRLVktQcmo2SU1abjN0SVVJKzJjOWlLcitwbUpIMG1TNjhr?=
 =?utf-8?B?cm9CK0FkdklxcStld2ZZUXJsbW5oTHVCMjN0YW5maWZraTc0Q1BtbVZCbU5Z?=
 =?utf-8?B?T09HMVlUUDBZUmN2V2k4SU5mVno2QTdpNDhuK2RGaGJvOG92QS8xL1h6b1ha?=
 =?utf-8?B?NkxGOURYNkxvYzZMY0hFRFR3elhweXRLa0ZpcWtqV0tmUmlNM1l3ejNuY0tq?=
 =?utf-8?B?eTV5WlZVK0p1bWZ5eXNhYlZRMkhIcExkdUZXQiszTHhoamwrTUV5THZVRnND?=
 =?utf-8?B?NFBlZkczMUp5QVk2dGhFanpmTzJFOGhYYitwUG5za3pUMVJscGM1eE1VN3BY?=
 =?utf-8?B?MDZxWjJZcGNldHpteG8rUzZZMDYzL1RTYnlqV2lDN3BGaGlkQlJNNTBCejY3?=
 =?utf-8?B?K3lWdEFJZER2UnRIcEhhVTFWRVV3Y3lqSllsTEU2cVZvd1VCNTN4a0Z6K2VM?=
 =?utf-8?B?Wk9JR1VXcExpRFB4eHAwM2FEb0J5R3I0ZXd1Vlo2N2pxVVdMZXI0QVBhcjJR?=
 =?utf-8?B?ZDVIV3VLVEhpQ2duMlpaOHZaRi8xejB4NEk1OTEvemFJcGxSV0ZIVHc1ZzRE?=
 =?utf-8?B?MXVLbmdqVkx0bTJhY0Q2VU9nSDBGWFpMeG9xQW13UVFPNjYyNWRpdURCYWlI?=
 =?utf-8?B?cnJOZjk4Y1IvVmNTY2IzaUdqUmxWZ0ZFQ1F3UERjL3BhazF3WTF5K2I1enlK?=
 =?utf-8?B?RTFyUFJ3WnBTZmh3WFNxRDlEbkthMGZOU3Y2QXcxV0xaUFBidFN4a0cvblor?=
 =?utf-8?B?TlVLUGZNaWNJNFNFSEkwVXVzdlhyY2hGWU9CVEYxL0xyWERmNGZEd3QzZERK?=
 =?utf-8?B?NHlJZnY0VmZoVERwZFQzdHJvckFqNjdOM2Z0T3pOTHJ0Ujlsd2ZkaDllV016?=
 =?utf-8?B?eHVLdkc2TUQzN0hTTWc1djMzbGNUNXdFVndMMVFzQjNlazlpZTEwRUVTOHF3?=
 =?utf-8?B?TUpHV25XNk8yd3FROFM2YXdPcUZTN01TVW5CZmxwVmJnQnRDTDFJb1JubWpj?=
 =?utf-8?B?UHRKRFZRRmhhNkhJZkR6a2Uvb1M4UHhvWjFsSnphc3ZjUGdQZkdoNENDQmFM?=
 =?utf-8?B?Mm5XY2hMRklIWm5TYVFwRE01MVNwdnhMQVRQUFZLQmJlc2RuMCtHMVoyWm1y?=
 =?utf-8?B?eHFPcGZ2Nm1rNGR0MDFSMEtaRnlHaTdjTWZqRkh5bXhHWDcrMzdWV3ZxbVlw?=
 =?utf-8?B?WXlZM2FDdGtMbldRbjBSVTh6UDdPVlNGVXpsWURGSHRCQXh5aXEvQUtBV2U0?=
 =?utf-8?B?c3lPajYrcGNsVlIzd3BlazdXVHFJazJHbjZna0c3RXE0cDZLWktCcXpJcmpV?=
 =?utf-8?B?bjdHRUh5YzdBVjFtRDVObmJ4TXlvRHVzZmJLNGllRWJmRFdhMEFDNlpmdjNn?=
 =?utf-8?B?ZHpHWm5kL1Y5QUdMNDVDRXVHUWVYdzQ4VGxzcVU0ay8zVGhydzkwQ0NuR05l?=
 =?utf-8?B?RFNpbS9OM3RBeDM5TytFMXQvdXI1WGVlaFpkQnR4YUVQZFBjTWF3QlJDc0pi?=
 =?utf-8?B?VDJLOFg2bWJnTTdHSXk4VGtsT1BuelExbzFSY3lTSWRXUjNZa3YxWlRJaEs1?=
 =?utf-8?B?a1RJRW5oMFpHdjluZTJPbFlsU0hrK2xYeHova29iT1diOEVVd2N3Z0RPakIz?=
 =?utf-8?B?aHg5dW9rNll3R0lIMUp1eTFVOUdTYi9FTTdmREdibFVQZlFlWnF5bkhxL2pJ?=
 =?utf-8?B?WGlCVjZGeHVGR2JnVGJyVGJaSHhvQUdmMVIvWXhwYkdwRmV1ald3dEZEZzZm?=
 =?utf-8?B?SFU3NmtWYTkyNkt6NUxVNmIybWIyOHk0VlZOT0l3MHBIajBxUW1pcWNuL1BB?=
 =?utf-8?B?N2N1TURQTDBVSFZhSDRnL3p0UTVJWEY0ZFA3VHRNTkxYVTF5OW1lang4K3hB?=
 =?utf-8?B?N1I5NEJWTlpuVVN5dTlNU2JaYUxiMFdHbUFOY3FOWkZQNXQ4NzZEVzl6Y1Bs?=
 =?utf-8?B?cXhQM0tBelB6aWNwU0xGMk55dC9zdmxXRXZXTGhua1hmWG5mYjluSXUxU1gz?=
 =?utf-8?B?a1RQempTcFFvbEhPM2cvRDZ1RUxLQjh4aFU3d2RoRnFtOUduZG1DWWhIdVFm?=
 =?utf-8?Q?NSuE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWVtOFpVcHRGbHh1SlkrK2tlNUcxMk14V0FCRnlPN01vRk4yVlRxQkZpOFFL?=
 =?utf-8?B?NEIzQ2FPK0REMkRla1p6aVl2SGQ1TlN1QlNaMFF6ek82Mjg2aEVUUFZYUzBF?=
 =?utf-8?B?MEdneDhIc3B1eGpEYWtVS0svbERXRmtRN2VKN3JMWW8xM1RteHNNUFZyVlZN?=
 =?utf-8?B?OXpUUDVHY1BUR2ZHV1E2ZUFUeFFqQ2IyZC9SWjB6c3JWc1VZNlRDVFpBdGFY?=
 =?utf-8?B?cU5VWHlEV2NYbVFqSURaVzJjVTJOZ2JTUXRNK3NjaTZxUEVpck5mQXZBNGt4?=
 =?utf-8?B?RkNEWThnRGdEQVo0OUwzTkpxUWt1dTVzVENISUFYK2RZTjRGQ3FMc0F2cVVx?=
 =?utf-8?B?YnVHaFk1TWhMUWRScDhwSWRvOUV1bjdrV0NpSm1XRk4rY3hCdFRNU3JkM1BL?=
 =?utf-8?B?RUxqbnI3bS9kYkV0RDl4emt5dVJWNkxZSzBqZzBWL0U1TGd2a2pEVHhFMzJu?=
 =?utf-8?B?Z0NaSFozK0tKSU1SbnVJV24yb25Gdjg4M3BiWFVxcDlMRzQwOHM0Qk1CbkRp?=
 =?utf-8?B?WUY4WGVTdjNXbXBqS0RwTE8zWmFXa2w5c0xBZGdwOSt4eFZkalhTYThLUHFO?=
 =?utf-8?B?bXVOUXJlMTFiSUNTT1FHaHdDY2dBUExsMHdWd3NaK3BCeEJFOHBTMXg2KzF0?=
 =?utf-8?B?WjRsWTVtSVcxN1NEN3hkd2FzbTIrMmpqc0RkUzFmS2xiOWZSV3VlRTZCTXhS?=
 =?utf-8?B?YlRWeGtidXc3eEcvRzZrNG5acm54NnJvbkRwZWR3dGMxQzZvNElQSW40ZU5x?=
 =?utf-8?B?d3lTQ3A0NUdueXQ1MUY4dmpnOS9yM1FKWEZlSWViemxtYUlMTXkyelpqaWVW?=
 =?utf-8?B?aExpd1IyeVVDdDdnOTdHb3RjSDBwYXBFYWd5WnJJZUZ0bEw1dTZyTWRhTXE2?=
 =?utf-8?B?M2sxQ0FubUQ5Q3owKy95V25xZmkxNTNFRXUzeHlsVVVDcWlBQ2JOT0ZjS2RG?=
 =?utf-8?B?Q2JTNVpyb3JFTzhtWEtMZldXdzJhOHhPM2VuMFd5dldibmkvRE1zRHV4dmdy?=
 =?utf-8?B?Zjd6bUVOaFhPTXdPUjY3UDNvL0RJODVhTGRIRS9qVTFqUjh1K2ozZWtKTnln?=
 =?utf-8?B?RXZuYXJCQ2pRMTZybEZYTTkwb2Z0Y1ZmS3FaSUd4WWtDU3JLbFpVZG1IVFpv?=
 =?utf-8?B?K1NHc2kxTkNLcEdBSFYxMi9DTVhYM3NUL3RIU3h1citsNFBVVFh3SUFZYS9T?=
 =?utf-8?B?ZUJWejdqWnloZjNFMzB2WnRxc1BHUHF4VWUrTzd3N3FaWGdydWpRczVVY1gw?=
 =?utf-8?B?ZjdCaytDekg2UWtVaVM0RFdWT0tNK2N0YTNmemw0NGRZc0JDU3VTTm1BNkJ1?=
 =?utf-8?B?a29CSVFLMm9rNlI3OFU3Mk9jQ005QkJ5V1hsMUlFQUsrQTVycHBqdnNkakl5?=
 =?utf-8?B?R0MwL1EwZGlTbEh0eDhtOUt1a3JlaEpuaW9UcU9tYkYvMFovcmFFK1ZGaXlw?=
 =?utf-8?B?OEdIOW5UM3pDMkNkWDdJWEwyR1Z5NnNrSDJtanNzRnVsZWYrSENlV1lHbWhP?=
 =?utf-8?B?a25GRUxva1FZbnc2ZFppTXV2eTZYVVRxdXRCQWRKdEVlYUtRRGFoOXNvM0pW?=
 =?utf-8?B?bXFDTVlTeCs4cHdXdys0MXpCNFNHQ1lDR2N6SHN5V0wyWGJtTTNrVmcvV0p6?=
 =?utf-8?B?NURXcUE3Q1UvS2hOR3dOZ2o4TFdIaHJvSzRJZm4vV0tNMSs4eHdHN3JKOXZW?=
 =?utf-8?B?bWdKdUdaV1NXREg4ZUZmMEZVU3IxK0lPUFNWdVlnYWdkOHBKQURXbUx1aDE3?=
 =?utf-8?B?TmtUMjhtd2lMMktwUGlQRnRNUkgvckFyaFRncG9FTGN4QWE1NHgzMEN1YlBN?=
 =?utf-8?B?aVBVWUM1RVc1MGxMYUlIQnA5czZORW56UXQzbUtocVJ2cDJBVHF5RzlRdHhX?=
 =?utf-8?B?QXl0Wkc0THhzK2pDcTNRU25OM1dQNjV4Q2VOTkRhK1dTNk5MaW1JVllHdnRJ?=
 =?utf-8?B?Vk9NRnIybktaTXhSbkxXU3VuRFJrMHV4c0sxUTIwaUdobG81RG9DY2ZJcThE?=
 =?utf-8?B?bDUxSUwyKzRHVkk5WGVSNHpSeDhSOFU1WkNIYmZ0R1FyN1RRTVdYVmd1T0NO?=
 =?utf-8?B?MVpVMlBnb1VqSXJBUlZVODBlUU1yWmpyM2lJVXRSRTdJdmIySTY5NURyL0Vt?=
 =?utf-8?B?NEZwMWlPTTdwNmp6RFBhQzhqdHd2eEJkd2JoMENXT0E4ZUFMUjhMakdxNHQw?=
 =?utf-8?B?V1ZmdTB0WTlxaGE5cVFnanJuNFZuRzRpWU1wamsrRDVXVGcrMTBHei9XUzZk?=
 =?utf-8?B?Ynh0MWlKTkFVM2ZFZDBKMGxzUFpFalF0Slc2dWpwU0lpVS8rZ2YxdVhaWGJy?=
 =?utf-8?B?SHJKL2R4clJQQ2FUZkdiMUpoWjcxd0p1MmNPYWlzM05aR3Nob1JTVTJKdktI?=
 =?utf-8?Q?y2TBZ813okLFbXT4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9f64c9-34cf-4cb9-8f25-08de6831ac61
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:19:29.0500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O92mjjVo3V7qYgsbDX9Zvh7Ux+gr25PsYPhshJe2QZOvc1C47Hsw6TGREK8D4W3uWtBzdWqcqC1NkLxyhCx/gGIMSvJxZpJ1ZNumsKu/xc=
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
> The scalar simple Tx path has the same restrictions as the vector Tx
> path, so we can use the same logic flow in both, to try and ensure we
> get best performance from the scalar path.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx_scalar.h | 54 +++++++++++++++++-----------
>   1 file changed, 34 insertions(+), 20 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

