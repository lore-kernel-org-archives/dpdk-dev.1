Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A0CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:03:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABDF7402B0;
	Tue,  6 Oct 2026 12:03:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BD680402A2;
 Tue,  6 Oct 2026 12:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280993; x=1822816993;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GwJ+YbfxTynkteoj8YgeiDmClcGp5aZvG8Zng3Ti3+o=;
 b=eivO+CcdIJVe92ITqLpxX79xTi9rge/5jXuvcPqeE2cc99hM7diwvzSi
 ZGXhpxphV9zHZk8zOXysxtgfjtwm4m2IiirFU/MMtPcc4h7EsV5mcaU9h
 udExOhDBNjVh0P0k32ZsCsBuWexJP2aLWL1ZwZVKVThtMaynCQSS+MY29
 w1O6VUSP03Z+Zcpo54lO0y2z26aHr9q3AAfQxsYH1cTeLYVwVJVdFGFpm
 yXNuAstQSf2zr6NqBJxbYkyd481MsAb5zrOpXkX5ni/MFJ/OxXtifj8Ze
 7DqIl7QxuGsmr5LJjSUGsWhVi5+Br+Sg+WtmvVIZVD5dhYVtNmrk+SaA9 w==;
X-CSE-ConnectionGUID: T32ut3gLQrCtbHRCdLNmkQ==
X-CSE-MsgGUID: m2AJzo0MRVOUptbjKSTPCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="108339282"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="108339282"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:03:06 -0700
X-CSE-ConnectionGUID: Jd1EmDKaQ0mrCQaB330EfQ==
X-CSE-MsgGUID: vwp7+JKDSdC0EwwQBFZ3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276635995"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:03:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:03:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 03:03:05 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:03:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srkyNvfvcH1ghP0ESxGy9801FmzgyhnyMqgYKJ+118EKHCNTPxZFfc8qjIQOBBFSP5wdVk3tVV2WzvBXqRuloux+/gyIYHqAfqv4pNpdrbZMpN22KhupQklopvIcyhk1+lyHF519FbeR1MwYFXQVbpCl64u/n1qt9jbuyGN+PzBZMro7hzBV7gLnHniQh5c6s8I800VjGgSCDj66p2lI0wp3zbM82FpxyNLsqedrMb1r2qmPRo9uLZDtHt/YE1jVzpUnbBTl5kHQuncKJIO9Uy3RVwSpp8fQIlblbvmHAB20sTl1OuuS3Wwmv4Zy3yoka6If81yk5dbq3l27XXR38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQiwWfnMTErZxkKmsVcKe+QlBkU0hKK9sXyE6jEENJY=;
 b=kfj3jCoiG9qa6hlWmH/CYB8QdgC1GHKf7WZinhfgcIS6UAccXzv7B7NPn3Lp5XdB4ZhCStBmxAbIhuK32Iz1hzEXEPx91ZDnyHH96ztZ2k6E166xbqxWT9FpkzTFEFd7OGgM0ndF3B6jMYOLtfLFBxvK5PvHihe38RrUQloWQk9EmtYvCTMbAvW8wjPQK2jYV+T6GIOZSk6LqI2z5OVYqcZ6X2lQeXJRgYU5g2k2VRKwTibP1dUV0pdEBK8v2AXCZEqkAefjSQq9OBN30OFUiJuyCAHhmIJn//keVEnl0SXQH9YoD/DwS0W6ey13QuLulpz4N9LtgPLxuLGML00NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.19; Tue, 6 Oct 2026 10:03:00 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 10:02:59 +0000
Message-ID: <e5809107-013f-4f3d-b1ac-741eb6788b9b@intel.com>
Date: Tue, 6 Oct 2026 12:02:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix unchecked Tx time context allocation
To: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <stable@dpdk.org>
References: <20261002021937.391321-1-anurag.mandal@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261002021937.391321-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 919cd66c-6562-442f-80df-08df23910060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GhPJovH0ajsJ0XmCrO/KuK1/H8CZ2S8quNuZQ469QCABxHLrq75otavaRjUN0OoprImdmXMJIr5XYWfP5V98Q3Z6XfxBXI37RTl/CQB7B8YmwQUIJExgI26JF83gqX7NYgT2PAlI7is6PjeQbeYuG8vFEL4Ba0PjOfxdaHqJgR/MDA5P44MpuMlfV8rAj3abBr3wP3+P/3YzN/+0gNClaIrzZNVGUU0agTJbykI/NmMzW2TKKTQc2TR7ZP1STUa/AOzc0uoowfoaIAhsrZjiaDobEYXyDuY9OAwa0BIfabbtq+tYtxUKJiZs8UHbGw/7t5lRr9Os1NcFYm0EpLkpgSxd4jue8PajXW+TJ46LutlqXga7r3ePzMG4wGPveEcx2Pn6zVA1Ce+TeOp9mjijpfO9nKiz/Apk4pIQe8pfEzaXpu4XnAQGmn0TIY6bDgadyNQSrpW9faZ7oX7NONiNCL1WBAoH30TyoHR6aZrtxNoLDF3xWHrhq0vP+VauYnej6lrDtDtb26SEDs5jp2S+vWZXZ3vE4r5AwsfLk/3jXCcM8xZoDR8r3RmgaOsPDgEe/Bs9i5eqyiyb5sGaYsVhCFUO4gO1v/LEySxsVnIM+UwF/ECnoO+SNl0uuMgHYkhZ7wDrb3gjQ2DvZGs7PBmZr4t6fEzSGXA3yytfPt8iC6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDdtVVUrSDhRSlUxUlN4NXVlc1A1WUtkMWdYMnluczlWYmV4MUQ1eG1yU0c1?=
 =?utf-8?B?SGtMdUlZWHVTcUhwNHVEcVZrZ0xvUDlJYjExRkJtUS9LSGE3M1BRTnZNRFVB?=
 =?utf-8?B?VC9QV0dlcnRTbkVtYy9OaXB6aVRrOGVRU21GemdxRlFMcWR6YktGenJaT1dK?=
 =?utf-8?B?TUZ3L1lOSUFwbG56NFNpYmJmSmdua2gvOXh4RC9WRVFkeS9OUGRwZkZCbFZp?=
 =?utf-8?B?Um5jeVhvSTlyT01vdU0zRnRoeVRzcnJOWnhpLzh4SUVJQ1lWekxOR2o4LzdU?=
 =?utf-8?B?V3BLOFNKUW1WNVd1cGVVTmtFVUhVY1dZL0l0SFpXV1did3cvRHFMK01KVWtm?=
 =?utf-8?B?M0xGMytFakRHeFp3SDBZSzlmZWFtSVlIZ01ZeW1yczVubU9mRS82aUtPQ3ho?=
 =?utf-8?B?NklSQTVXQngyczI4dkIvRy9KT2Z1cXR0K1ZJcktKRXlwNVVMZkRFQk9OSzkw?=
 =?utf-8?B?elR5TmJJbEdKR1FyOUU4ZkVpL0gzZzNZS0x2ZnoxdjN2K2gxb2EyRWtiam0v?=
 =?utf-8?B?bGdzQ3IrZHVEcmo1cTFZSnFjek9oVkU3YjJBdEYxOHdxQjBDOVF2WmdSN2RU?=
 =?utf-8?B?R0RZSm1PcnpqV2lMUWRCQ1dRLzVUZUVINVR0cDNra1BTY0wzWTUvYXhhTVg1?=
 =?utf-8?B?T2grQzZ5dGdLL1kvd0xYZHJVOHJ2SlJiNlM2aU5lT1FXMTRMTWlSODV2RFVO?=
 =?utf-8?B?eCtWejQ0cERzdFBPY2tPcmlxMENrK1kyNGlvSmR4ZVhXbjA5NnlFQ0dsMi9Q?=
 =?utf-8?B?NGw2YXJHUGdBNGRJN0xwU0lkN2ova3IyMTc1WkF1eWVpdW05SDB0THRuekhw?=
 =?utf-8?B?SUYzMWh4VDBxb2d1TnArRlZVaU9lMGx0d3RGMmRjM1E2U0VSNFNJSWlhdE50?=
 =?utf-8?B?U25GMnlQcUZNOVMxRlI3YlorM3RxaitVb09DV3I5OVF6M2NjYk54L05qT3hT?=
 =?utf-8?B?K3NOMXpLclloVTU0RW1DSTNGUjhlVlIxNzA1bXRUaGh4ZW5PVGlFUFd5Tm5P?=
 =?utf-8?B?SWFHWmxJRVJoYlNvcVVFVWNvQUdvS2syb2RlTmljVHMwcGNrTmdRekdha2dB?=
 =?utf-8?B?Y2NSdGo4bGUzR09qdWMyYTVudEUzRlAwdzJTOVBOdkt6MFpCQ2pONWhBbWhI?=
 =?utf-8?B?QjVwODc3YTNDVHFpZ2xzRXZGNFFLYmExOGxoUXdBeU5PQTEyTG1sNm5qWWJt?=
 =?utf-8?B?U0lZNGEyc0lYK3dBL014NFk5SDVyN2N4L2JFT2gwT2ZsaTN0TFo2OWs4QTM1?=
 =?utf-8?B?ZU9YTUd6YXV6M1JSQlowVFc5V1Y1d3ZDeHFxNzF2SkFzT29TbGdpMC9ZcVhY?=
 =?utf-8?B?ZFMwYXgwMGkzeE0vY1dsOUU2SlNUVUdYSnpNT1gyZUIrWmFlMmlnNnJ5SUZO?=
 =?utf-8?B?dFNYU0tOK0cwcXp4SGlOR254Mi9hQkw5NlBpRS9MZjVvNDdhblBJQmRZVTE1?=
 =?utf-8?B?cnEzaXZBcVRnakRWT01HOG1sQ3V6N1RYVEZuZzBDaDFZR25xN3ZFQmtnM2c2?=
 =?utf-8?B?eWF2Y2pLekhTVUNYVmxHZ0tGdDVXUUNHRmpoSmVUcFQwaEFRV1BaYmZ1Z29i?=
 =?utf-8?B?OU5SYU0wV2I0Q2NwR1pmYTAzZzFjdmt1NHQzMFQ3UDAyalJSb1VhNDhuSnVV?=
 =?utf-8?B?Q3REQVV5S3FYeHJVekh5QmNtOGJqNk5NRTcwc2plb3Qvd2g5ZTdTN3RFdHlo?=
 =?utf-8?B?dHpkZDlDNndJNTBwODNqQ283YUZXTE5wMDBMK0RBM1AyT3VJUVNGbG1yeXlI?=
 =?utf-8?B?dnpQUEUyVC9BS1BoTnBOaEpWb1NkYXlienZpbWVmNGRWc0NZeUNZZnJ3WHM4?=
 =?utf-8?B?bjk5WVh0eXJDZjU2TEhPZVVFRmdUb09aWnVwOG1VTXVQRjVwOHMwODFTYUFt?=
 =?utf-8?B?VGhuU0h4dmNpRnZPSWNDaWhxaVJ6TDR0OE8yc2NKTEorcmtkbERYZDEwYWFj?=
 =?utf-8?B?c0svZmZhZFJ4NVRCaTFub0RKczR4LzRYZmxIa012dWNLejlWQ3pwaVZqaU5I?=
 =?utf-8?B?c3c2UGpyQXg2R285ZUdBd2RQRHlOVHZ5Z0lndENFYlQ4TWJYTlQ0OXliMHJZ?=
 =?utf-8?B?aTRyTGVwR2lXUXRSY2FrREtXMjNuL3NCWS93aklOSXhYUTIyRjBmcm5xWXNz?=
 =?utf-8?B?c3UzWTVuU0hGS0YvVjN2RHJ0dlNlY2RPMnVuOXl1Vy9FTEpwczNWamM2NmRZ?=
 =?utf-8?B?UTVmY3laQS9FcVhRbFErZ01CaW5pUzcyZDJXTklhK3kweGhIaDhDbmxTVUQ2?=
 =?utf-8?B?YmhRdVZMb1dydy9JYm5qMWJZcU1uVnc0Q3c2dmxRdUNraUFKK3NkUXprdll2?=
 =?utf-8?B?UHdJSHZicnhPanJVd0NHOG9EWU41c2lScG43OWRKZGVpa2FuZGMzc1BYMEhM?=
 =?utf-8?Q?NPSTfSS2FPkYiu/Q=3D?=
X-Exchange-RoutingPolicyChecked: uJVcH73f1VRmmh3zZ4hHPMuIgSYRHVxpZN8p0JAghPlDRj26hDa2WbomhATfwfYipbavq27ObdnE+cA1sEVOskK2cm+o4bhPsE298RgXppPYQBlHX6yVb0e9tAi0echMjf3x+cUSklexHCHxS7tfoaHlF7ZV3dNAdvT/od7Gl21x7X6t3tUVQ190p7IB++I45wUrFuvqK2fP/qRmx10sHbRXJbIUcy8nQG7MK+/VHC7RFQpEQ+DUNYFLU4iASnUbJ08tn9qlTHF+4dKnbCmZTEour4rCZOmUA/eVdJIPTveWawWkVcKrIVQ2iThEf6Dpi54JnHzIY9624FB69//dFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 919cd66c-6562-442f-80df-08df23910060
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:02:59.6935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdLX9C7+fGQSQhbMiImEccVWGFw7bOasgvL2/1ozTEGHNivBaE1eFQQEsmIwxLdvwn4iUnPARFuOd6Ddprt58fOQ2UUx/zsNUTIp+yJb0m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
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

On 10/2/2026 4:19 AM, Anurag Mandal wrote:
> ice_tx_queue_start() dereferences the Tx time queue
> context buffer returned by ice_malloc() without
> NULL check.
> On allocation failure, the E830 send-on-timestamp path
> therefore crashes instead of reporting "No Memory" error,
> and also the already allocated txq_elem buffer gets leaked.
> 
> Added the necessary allocation failure check and freed
> txq_elem buffer in case of failure to avoid the memory leak.
> 
> Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>   drivers/net/intel/ice/ice_rxtx.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index b333444cbf..873aca0100 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -898,6 +898,10 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>   		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
>   
>   		ts_elem = ice_malloc(hw, ts_buf_len);
> +		if (!ts_elem) {
> +			rte_free(txq_elem);
> +			return -ENOMEM;
> +		}
>   		ice_setup_txtime_ctx(txq, &txtime_ctx, true);
>   		ice_set_ctx(hw, (u8 *)&txtime_ctx,
>   				ts_elem->txtimeqs[0].txtime_ctx,

I don't particularly like the fact that we're allocating using 
`ice_malloc` but freeing using `rte_free`. This works only accidentally 
(because `ice_malloc` resolves to `rte_malloc`).

Not a blocker for this patch, as this is following established 
convention in this function, but IMO this code could benefit from a 
separate patch replacing direct `rte_free` calls with `ice_free`.

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
