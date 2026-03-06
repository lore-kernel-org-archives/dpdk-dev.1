Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D056F0181F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 14:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4D3040A80;
	Fri,  6 Mar 2026 15:17:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9E32F40262;
 Fri,  6 Mar 2026 15:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772806627; x=1804342627;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bV9xW6zG6Bf/dWBWlo6/5Apsfm6KEGmzwPLCp1IkvSc=;
 b=dX/GfcWwY9YnrPpK8Aez9heau6mMKpe+DQYN1agW3nXUu28JV8Alo+ab
 1kq55iiPDzlbz4eNWk8qEvx5Zw6eSgSiU3IC9CRqbg+IAvdaEQYsvXBUJ
 4y1k05RwWdpTDcIjDcm24kWWsUbmV60dtOylDM0ktUaliBL7DVbeuUVM8
 YsLpnolPhTGkEo8JxXHQ/OcSkEiFnhpRJz4x+V5zEJsQ5NfnPq2Ypf6Nv
 OxyPol7FI47AsA+tK4PBJzGJbi9Ok1ZTi7XQlWSSZJ4XVJiu8dOILPUxb
 nqE/IzPpQVSdVBRvTjgJzm3VhWw7IbnsebuiTJnVg5x7T/xqBfuC3s+6h w==;
X-CSE-ConnectionGUID: WUofzCkcSr681wL5jUCpvg==
X-CSE-MsgGUID: awpjxJ2qT+uFZAfvx0hv9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73881953"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="73881953"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 06:17:06 -0800
X-CSE-ConnectionGUID: Jwyg4uh0TO2gatDNq2clAQ==
X-CSE-MsgGUID: m7BqZXmOQCSPQD4saBAMGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="223506707"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 06:17:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 06:17:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 06:17:04 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 06:17:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE+BWc1e/m2BK4l8n0j3f4EKRstKycGnv6ikBBGw5AiCB6P2b+4A1KQrL1gz2A3ITmNDMJWSTEQ6ygylzkqLZ76+wubGU9zhN72PkKEB0bJHN7gZFfxsPcxk4qN6DxeD+SuCQZSMEcs8dgbjhwva/VKhfSmg5yQ6Oxs7paCMhaDodUSz1apVBkU3Pdfckk7xElWuZ5e8IXvkCtAP8p5YXDvWdA+L/zFF/DwXU57g59PjUkWS6x3QBEi3hADTceMfToFzY2t+nuX+Rqr3wtTBQCoG/XIRevtSM/HATNrAVxnv+KG2N6AWcqrq7BGRlrhmd4Jd3jGbqb66ZMIPjgASRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuAgtf1ANh7f66/dUeaxz3ZhWJy0CNTq+kUnfQ50AaA=;
 b=dKurE98+Qntxkf4os4XFwDyCk2FsgRqJ/lFMb+45VMbW7A6pmZbKU3QO+stYrr4luVeQLFCRDAORCo+sE8yH0zsK7za9lAbCBVOTKgc+lH9YLHOrEfTK2NNX/+maZefcS78YPqpanw0ozPpdqO51YBHx995BsEaofW32PbxHzdLCnnxdedGoh+n/GCx3ryOWhwvoYtw7XP8cQR2XrV8qXDbSYSrrZlxV8IwlHfjwzcxIPK8wTDHf2TbTLOnCsN/w+1Sm551TbbNnPhE25RZNsajInoSXZnNxA1Lc6tenLb0V6osI6r/zOeK+nPzAgk/26LumESn/BmN7bwmytdZyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5146.namprd11.prod.outlook.com (2603:10b6:806:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 14:17:02 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 14:17:02 +0000
Message-ID: <596c136b-d742-4260-a45d-c317b3664895@intel.com>
Date: Fri, 6 Mar 2026 15:16:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/idpf: handle Tx of mbuf segments larger than 16k
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Xiaoyun Li <xiaoyun.li@intel.com>, Beilei Xing
 <beilei.xing@intel.com>, Junfeng Guo <junfengg@nvidia.com>
References: <20260303150026.1601461-1-bruce.richardson@intel.com>
 <f46aa723-75a0-41dc-a063-d79420365b3a@intel.com>
 <02e2c11f-d280-48bb-bb6f-7c28bc3c89ac@intel.com>
Content-Language: en-US
In-Reply-To: <02e2c11f-d280-48bb-bb6f-7c28bc3c89ac@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0017.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e52a774-a0ac-4585-c54f-08de7b8b0952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: fyMdQdIuzgmMgfUOhRzoEjKWEFtEGkU6QNwLvqows0g1ATilW84xz9colAH+hYsoCprDEUauL6GRERCqcnfDHXPJ0LuScFfxXY0zhxyEnKAlFpWgZLLx+sAqgnl1pNAWfrgJg7+UFd13vXqI5bjiqIcmAoBndGgU6/PKQgFLArWz4vsHEILyDYoKv9bWAHXx1amDBo4BUiSp0CvS6rXdYuz+7XqZM/nNKbzMeg4cqPZ3iOEGRt6MpZM8zf03DsC0GaX4vw0O26hi2XER41f1WH5x0Zo2zk7aWoJOI4g6oognSSLLd+6ZOZuR+a33Kh8HO99KT6/ld7JOGGWQtkyr4lf9ANHc0dYR3OnUbU1227XU5FbKcUhAP4wJ3mheuxc9mMi1nfpZ8P/yxe19QfaMFIfnJdKIJeCeGEhBNp1BmteI4aAFxc1Ew54O2uaPv1TJ8qWj1mnzR9QgMk/8lyIzvPIcxjxeGgMxWIwcemckZIqp/1xEpM6iAMZc3Zfo4c0/PAC47NVJNXkt0TirpsIId/iQihZwOHCMtvmMcjQjk5AlVrMRe2y32AzETSfjLS79V/t/vVihV3xhANogZNKj56unMunExqRYVjNNxIhbtF7eqsG0NU0Qz+QrEAhqAclG8NlKYwfmQL0KEeUm0vii22viyIEHHjEijXKg4RdpBKUopaHGaozemQfOPJYycGCyP64Sr/pAHKEeX4xkYMls3Q5W4++pHZuTjxdeCFMEQDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFwdDN6L0l3WkFxNFRWUTAzcmY4T0tGQkhuZmVQd1o4N2R0Z3g2aHgvSWJC?=
 =?utf-8?B?ZDZ6NGlYNWNlRFB3R3BTNjNST1V2TEZMK1gvbUhWV2dVdU1CNXN3OTdVTUV2?=
 =?utf-8?B?OVBaRVprZ2U2YzRlMEQzYVZ4eTlFWUxXQ1dlZkVoQi92VE9kK0l1RmVlSk1x?=
 =?utf-8?B?RWxYQWVuNHpsY3F2c0x5QVlpcG1PRGVmcXZ5Y2x3VE1qQTArb2RsbmRnWGM2?=
 =?utf-8?B?WkpaVGx1dWFyK3lrbzlrTHdEd1JCblRaUUo5b2RkK3BpWG5pR08vbUNpOHd2?=
 =?utf-8?B?VXArLzFqUFErdFhhVHRPMndHaWIvekNINnplV1pWanVBWS9BSlh2UVRtYzdI?=
 =?utf-8?B?TnB1WUV3TTFpbDNkeHFtdWNWUWZRT2ZYenBiRGZzc3FNdndJVC90NHVwVi9y?=
 =?utf-8?B?OCtEa0ExcXVCMVdvVVBSTGVXZng2eVBKR1lLUHRFVUxEN0NheHd3TDdSSVJr?=
 =?utf-8?B?eGJEZ05OVUcxbmh6TUxiNy9RRytiVEIvbVV3bTBTb3RBaWVuSHNDYXBVK3Vq?=
 =?utf-8?B?QXRmc0pqRDZtU2toOTYzR0xJc2lYWHBQSmM2RE9qN2wxR3JqaUh6MnFXMy9M?=
 =?utf-8?B?cWFidU56eXJJWjIxQWhHMkFkdmhFZ3J4T0xwU2tXdlkrLzRudVV1cmRwNjQy?=
 =?utf-8?B?YzBZbzMwZ3UySUtmMDFIa3ZBN04wbnlsZ0ZmZ05HaXB4eDdMOWlIcnNzVk5G?=
 =?utf-8?B?dElHTTJaUjdEOTk1ODB3bEZJOFFqb1JUVjNoTFFPb0NLVldmclJqenEyZ1JX?=
 =?utf-8?B?TXNlcFRCMXBwZ2tUTENkaG44NENvcWs5OTY5Y0VrNzBFMkVtUTVPekszNTZF?=
 =?utf-8?B?TVhxcVFHTDlZYmtqWkZKT1NZZnJTdDlPdGtUTFdZTjRVcXU4aTJtVE94UlVm?=
 =?utf-8?B?WEhpOGRiNldFRjVIK1QxU1Y3MmpSY0xhWldwTUNFamhyclg1NWpwbndVZXZC?=
 =?utf-8?B?ckc0R2Q4TWlxWW5qaVA3VDJmQ09sRmsvSk9ZSjMyS3BDYzdGNkRDYi9VSlY1?=
 =?utf-8?B?cTh4WG11azZjd1ZJNkpPSEVxU2t1bW5hR201M3BBR3hyWmJSNEZRS3dDYVNn?=
 =?utf-8?B?M3lIdVJtbU9rVFNtcDMzZ2NDd2lqSUtHbnU1ZXJKL29XcHBUVGp5N2pQazBQ?=
 =?utf-8?B?MzJJSlEvL1llQzBCRHg2TVd0d09nYWszbG52blJkQ3VndkxzUzRRaC9UbnFC?=
 =?utf-8?B?U203bWxUQ1d0UndEajFHby9hbGh4NWUzRzEzSFZHcFQyM1dzUEcydkRLR2tp?=
 =?utf-8?B?aWVIM2kyWlpUSTM5MGhXMlc1S2Y1RytPTVFmSnpUOXhla0VWQ3VIOFBqckVW?=
 =?utf-8?B?bk5aUzF1eTEyOEFjUGl6NVVPSXlwSjQwMHlQbFdWRjFnZzBXUHJRakt1ODd6?=
 =?utf-8?B?Zmtrclp1bGdueUFaenhMQjQwZ3hrS1VKSWxCanllaG93d3ViOVZFQThKdW5L?=
 =?utf-8?B?WUZvL1QwNjNpSEphMVBWSW0rV2dTaWZJb1pXeTlTdkRRbWVUZWdFVzY3cHFp?=
 =?utf-8?B?NlU2Ykx2UzFMdG8yUTQrZXYxY0krSGh4cStOTHNQZ0xkT2RIbnNZWTExV2hO?=
 =?utf-8?B?a2xjSXNEVGJrM3lQcWU4QjNFZTFFK05uU1JJN3ZHYXc3Q0NuMjhSOWxWaVJL?=
 =?utf-8?B?c2s1bXE3RlYwa3NOYXhsdFNDOEcxbWFrdW5jR1hZOUk2SmVTQnhLYkRwamV1?=
 =?utf-8?B?QjZPeFlsR1ZvZXdRRVNhbmtzMTNQV29jbHNEaU1jYnhJSUd4R0FnU05tYzNw?=
 =?utf-8?B?ZUFHeUdJYUlybXZCdFE5cTdPVlRJWWtwbzVsc1VXRVBGQjF3d09DVEg4M20w?=
 =?utf-8?B?b0o1YUpJUWZsTGo2Nll1bWFibzREVE9MYkthc3JjZThxWHh2ZXJHZEpqMnR2?=
 =?utf-8?B?MDE3UmVhRStOSE5pTE9tM0Ntd0lFTlN6ajZId0R0MTlDOVhFeFFpNm9od2xJ?=
 =?utf-8?B?ejhoUjk0RUViVnBDM2lUc3IxcldMeVNOV0JSb1pQcysreFozT3ErWUhmbGZX?=
 =?utf-8?B?b05EVTFRWVhOKys1eTZsUjgvQnAxdEs4Tkw4Sm10dk1LWXVWM3JnOVg3dTZ1?=
 =?utf-8?B?a2xYMU1yV294RkpzK3dualc1aCtUdFd5TkhMaURSOFY2ZGtsYVF2YUFqZlRL?=
 =?utf-8?B?aWlRbmNNSUpGcUZxZU94V2M0M0RMQUxaK2NjcThSNUxEbzJXOG1yS0hEZC9N?=
 =?utf-8?B?N29yRU1hNGxiTEZGb0xjZUxpR1VSbnlmbUhmVE8vb1BMejljYzdIc28wbjdw?=
 =?utf-8?B?Tk1nT2FPV1ZXRHZyK3F3VVJQNDZ1R1FneDVQeldnU2JJMUtmb1cyclpMNGNz?=
 =?utf-8?B?QXVtOFd0bWN6SUdwRzF1V3lhL3JQNUp5dmZVQTcrNW81aFBqNmpZVDNFekxp?=
 =?utf-8?Q?Rnr/B/WVz1mhr4p8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e52a774-a0ac-4585-c54f-08de7b8b0952
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:17:02.2861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUEmoyJFXJfKyuuTTVFQnfKjrwV3G/qtQdqJNkgfobc1XyqzD2oaOQOGCQdSALMfxfzhEqFy+S+5flJ4T4Bl1/fP6g6RgEvmYXfQS6+GjP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5146
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

On 3/6/2026 3:03 PM, Burakov, Anatoly wrote:
> 
>> CodeRabbit picked up on something here, and I think it's worth 
>> highlighting.
>>
>> When we're splitting segments, we assign txe->mbuf to the first 
>> segment...
>>
>> <snip>
>>
>>> +                txe = &sw_ring[sw_id];
>>> +                /* sub-descriptor slots do not own the mbuf */
>>> +                txe->mbuf = NULL;
>>
>> ...then set subsequent segments to NULL...
>>
>>> +            }
>>> -            /* Setup TX descriptor */
>>> -            txd->buf_addr =
>>> -                rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
>>> -            cmd_dtype |= IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
>>> +            /* Write the final (or only) descriptor for this segment */
>>> +            txd = &txr[tx_id];
>>> +            txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
>>>               txd->qw1.cmd_dtype = cmd_dtype;
>>> -            txd->qw1.rxr_bufsize = tx_pkt->data_len;
>>> +            txd->qw1.rxr_bufsize = slen;
>>>               txd->qw1.compl_tag = sw_id;
>>
>> ...and we're supposed to write the final descriptor here, but we've 
>> stored the mbuf pointer in the *first* descriptor, not in the *last* 
>> one, which means when this descriptor gets to processing completions, 
>> the mbuf pointer of that descriptor will be NULL? Is that intended?
> 
> Actually, digging in, I don't see where we free mbufs at all in splitq 
> path? Am I missing something here?
> 

Yes I am, RS bit is set by the hardware. I guess the question is then, 
does it set RS bits for *all* segments, or just the ones we marked with 
EOP? If it's the latter then it's definitely a bug. If all segments get 
RS bit set, then it's not.

-- 
Thanks,
Anatoly
