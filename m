Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9679EC9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 15:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54410402AD;
	Fri, 25 Sep 2026 17:40:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6CD4240294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 17:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790350855; x=1821886855;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/FLiViFtndR3ljfO37IyDZCe3wa/4ChfRGvvcy9n4/w=;
 b=C9yItH19RKrFg59MtokDlWf1xuRJ4mlJv+SOkaLF7PMOtOfw6LsIf/Sf
 8vNg7DIdh5uurLOYGvhy3Zx7xNlyfa5t6tdLgg0rqNt7+iBeY6udkZ/rZ
 E3d/5auB/dSg5/2INh91kS9HYFTZWHcOfmK58FehfEYD47doZYOSoxAHw
 pycUBpK2c4Pf791cNwSNVSR+IBDWbCoPlzbfMuNKJs6H+/hTsrRkzOScz
 jZH4QaeNCGtRUqB99kw9G9qD7kxMQBUeZmVHjo+o5kughGbxC4C4sBS9q
 liko6gR+40DFq+VqvebCYVROiPnFsrfIf2UTLVfUkKgZb3akDfBFve9fl g==;
X-CSE-ConnectionGUID: ism34VPrTYC9X1b7Mcw/gg==
X-CSE-MsgGUID: wAj97doPSOGEHG3Sx7M6ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90264991"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90264991"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 08:40:53 -0700
X-CSE-ConnectionGUID: ow7B3I8kR9Wpu6ku2RmQ7g==
X-CSE-MsgGUID: Dj+WYtoBROikapVlwWUn+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="278148670"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 08:40:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 08:40:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 08:40:52 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 08:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhLLXBIIs2UrXCjdtC+FEykSZmWJZ4ZcP6T1BDiZLGXybREJqwY0RNsD4DWn4gdL8hwYsloMPpLp7jeSwhC7/5uNMyN3CNrA8l4orAPkhusZcCf8NCkJpJ6hyIct8gM6tRO98omD5Y5a7B3W8ePMpCIJq08A1AJeOQ+paoL4agucc2dA5HnmDmmXzDSBC5rkFi5s8Q0udOaG103UlHkHNrZ77z/67v8GhoY/wS2AwJVZJb/lB5rHdU0IHY60yXXuo3BS5uxYwSvoHNyk9PfO3czWusBJLA0zYAulzLPd1MdTCRvY6/lyuxdm5Ft98RT6wNkndnmeXbvQxQdeMKoO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4X8pNGLm9EblLTBewCspP6mRewuMznNq1Bs6QmuacM=;
 b=dYZGKRGV5uD0ieDl0UBP3KOOLQ4jTpKc9I3E+9DpPV+xjgnmc+9xyxC7fkBHaPFTxfYIAWvfPytJz5Fli2luV6qhWxcNMNetKllOVtk8gJUEMWsAQ+SwYGOLKFEh1xuZjdRHWhTpmaVf+kZFtC58Yx0GKIC978tRkIHZFF80frhAuRHIJAGxVrhNjgKnQzlGuPirZVznvDlIlgcx30rE7KwgvzK/xwG73oFS8b/zu3MXgYgokETZFzcWq8uhtTCvNT14/JlKiNT/rzt65zLPgWzjwIwrhbRtTnUvxNKqpaDFpHZO+rxNF3mkh2hmaFg/eWi84rI4RJpRuJLwTArg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3002.namprd11.prod.outlook.com (2603:10b6:5:6d::29) by
 IA3PR11MB9374.namprd11.prod.outlook.com (2603:10b6:208:581::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 15:40:43 +0000
Received: from DM6PR11MB3002.namprd11.prod.outlook.com
 ([fe80::f3b4:28e5:66ab:113d]) by DM6PR11MB3002.namprd11.prod.outlook.com
 ([fe80::f3b4:28e5:66ab:113d%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 15:40:42 +0000
Message-ID: <dcd90574-9a30-4dcb-9fd6-bfd13916fbfe@intel.com>
Date: Fri, 25 Sep 2026 16:40:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/ice: support link flow control
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
References: <20260910112524.1547156-1-vladimir.medvedkin@intel.com>
 <20260922182333.2288005-1-vladimir.medvedkin@intel.com>
 <araM_ipV6MgpPqH8@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <araM_ipV6MgpPqH8@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) To DM6PR11MB3002.namprd11.prod.outlook.com
 (2603:10b6:5:6d::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3002:EE_|IA3PR11MB9374:EE_
X-MS-Office365-Filtering-Correlation-Id: d41c024a-1d65-4d87-c51e-08df1b1b5b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|22082099003|10067099003|56012099006|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 1V5OV5zqYYb09CalIi7KuQ+Hbvu4Cs74Y8SjocIJJTWbeXAXgae+z6IMNF6KD19Gz8Pf6rEMbr9g7Ije73eZFh6lsJty7BpLSHTg/5qjaRXFE9T3rmyp7Ig43WIaNqf5rnw0npFdfE+1/ZauewLC2xhQT8z0LFMxFXtNXum6EiM5K79DJI0kc63bURRyY/E1YcTM40onANh7TKvjoirxeB0jTHI0N+UcDRz2xdSboQVYXRthJBR7ebShvZId+DINoUXRLlY5pOC9q5jWwScyqx/Iv6lXeektvo/hEOH9axNi7kMQ1fF3beeBCdvk18tNf/Z+Hd8WjLjnrIWjeHoeLAVE8QerkawsVBXpDOi+jRGP6Sw7gfbaMxJrG4K1gvj+UpIQXg5uoeU2+sNrtQ8BkZBP4ERvDW9wGLGA6rorMDP0p71OAN3nI2wOIux2Ai5E3wOny9P01eFPWqd+ixn5N4mEtcbc6IJh3YkoRlYI9DRXxxJS3bTJLQoiRkT19NipLNVuQ7IZ6+1GlfqfDnMs+Tm/Hk9lfF1NPCBTdloUSo9n5zhoQmbC3q3xWItOsxLXA06hEjy2nUFQd60GUCuw7kxPbgeaFrL0A5lDRGc/UArdlxWR4eFq0rh2jlOiahfXda0MtRQ0WAGTUa8wjdcQZdAbXGIDPg+7JVZlKYQcX04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3002.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(22082099003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFJV1RVMnBTSEpEMC9pVSt6NXBVVFpmVlpkM3pCTHFaNHdSaDBWMkJoNzVo?=
 =?utf-8?B?VzMrU29OVU5JaVVpZGVjT1ZSK0NETkNMeHZOVnExYWs0M0FPU3lKWlJjVHV6?=
 =?utf-8?B?ZXNRaEpMTHNMeWU0M1kzV0FIdy9ONG5BbWh2QnhkZms2eXFjV0h3NFZiNEtj?=
 =?utf-8?B?TSt6dVV1TGhWWktLN0NrYzFibm1ob0JDdjQxVzVqVmpjSWlMWUxNOFNwcGRj?=
 =?utf-8?B?cXJTTmVCRUhjZlNDU29oMk9yaVE2ek5qQ1pHU1NaSmdCUWVRemlGRk9MbzlE?=
 =?utf-8?B?L0E3bGF3VUVURTFzZXVmNURhdGI1aXBVRWFxZmxYN1EvSzkyZWJHSkVDWXJD?=
 =?utf-8?B?UkV1d08xVUtQaDV3S2xBeHN3ak9UNnRrTUs0bWt0R2pPNVp5ZW4zSmtORW5l?=
 =?utf-8?B?WkdKdEVDUFR4WkNEWEwyb0RGRmw2QlB6OW9JbFB0WWZ0RXZROU0xU2ZOTGJN?=
 =?utf-8?B?eDhnSkl3UjR4S1gzMThmVEpoWWY3OUJObVNpemZEdlg2QS9pZkppRjVrODJk?=
 =?utf-8?B?OWt3R3NKNy9MbmdSWGhJNWxSeG8vM1VFN0VtVS9NMUdVanNJZXN4ZWx6VzJI?=
 =?utf-8?B?QytHNlRuQmtQcW1Yb2FpWlJteDR5TnRRRmVIbHAyWUFwZUc1VmtLdzkxbkZO?=
 =?utf-8?B?KytJbEV5NDRQOC9XM0FmU2JsRDIwbmJXTjZhSUV3SkpaVnh2L21OeWhJMFRB?=
 =?utf-8?B?OXJDTHBPa1RzUVdxQTk4VDV0WmVxbzdjVS90cU5RQlBHZjFrbWorUlJtS0dC?=
 =?utf-8?B?bjI4RFBmb0VlcGU2TUdMeDIvdHdUdmh6b1JTQ3VSV2t3bDlCSktGRVROa3pK?=
 =?utf-8?B?d21yKy9sVHZ6MEJ5NHZqRDRJT0tUWGxGYmNFamczc3ZBb3BGV2JhVERsYVBj?=
 =?utf-8?B?N3psS3BIYVVzMnYwNWxiZ3dZS29GYjExWlZjWmJpbjMrMDlQdGp2TXRiSTQr?=
 =?utf-8?B?cVhHRlpmWFI3dzNIQjM3dW04Mm5JblpoT3QzMkdlTXJMQW10L3h0VUdWUFhz?=
 =?utf-8?B?RXFJN2lnb3hVR0VDckxDZk4yY1M1Z2xGU2F3cXpmcnp6QWR3SDlyc0Y4NWJZ?=
 =?utf-8?B?SlJRQTJEV0U1VG12TlRSVHRiaXVrQWNQc0d5Y2NWOEcvd0xJOHpVdERSQU1x?=
 =?utf-8?B?VUJMMEYweS8xUTRXZHZWMjJjWEhvbHhWY2xaWkhjUTY2YkpoeDk0OEs4UXla?=
 =?utf-8?B?MjZZd01sTnBmMHNpZmZOMGxCR0pIYzQxanBad3UwWmNGN0ZHZjUwdVFQejZ4?=
 =?utf-8?B?Q0V1ZEN2ZjFlUHg4a0dHVys5OGllTzYyUXJaMmJQdU5xV21zd1RXNGkweWpG?=
 =?utf-8?B?aDBsY0UzS1F3Q1BZWW94WTErbWNJZ3dFUEJkd1ZYbUxHNFNyOWIrV2p2VE5R?=
 =?utf-8?B?S3ZaQXEyVXhydFN0VnViMkFjaU1SQUlwRFZWTnR5VCtTU3VZSkkrSDNhbHpI?=
 =?utf-8?B?UkVVbm8rZzB3dmd1cXBZQVFmM0M1WjZFUFdycTdHU0JnWmZZeHluWU43Ykds?=
 =?utf-8?B?MW1BcHhvajliTFlqQTZOZm1aOHhyK09UclphRkVrM3hQQkt4WjBVZHVFamt0?=
 =?utf-8?B?ZXVDV3Baa2R6QVZTZDdERjE2MGNsM2JDQWpoZEdtVTFEQnFXTEE3TUtwTkU5?=
 =?utf-8?B?Z2lZODlIc2xvSzFpMjJ4S2FObEV0aTBVdVl3VjVKQklPZkVRSjJEQ3lUVUlL?=
 =?utf-8?B?QkV2S213ZmJXOUtURERNMVA1Yk9CQUEweEkyNFo2ZStsekx3ZzVMSjhxamdG?=
 =?utf-8?B?WVNaYXNQaEhvZjZId2FpeUJMVGJuWVkreGdWS2x4SVAwOFhQZkZmTHArRGlW?=
 =?utf-8?B?T1dJbDh0RVhXZjlRQU02c3RkVVoxNEw1cmN5WnMzd1hJdC9yYXlYc2trUmQz?=
 =?utf-8?B?b3JFaVhQcG9USWlXNGVrUnN4dk5DeUYyZzI2cGpMS3RSM3g3YmVUUDN5OXFx?=
 =?utf-8?B?ZDc0cjVjZloyeFFMOXRLNEJ6dGMxMCsxc2ZLWU9rdVdqdU5NYkEyRkJ1S2FL?=
 =?utf-8?B?VGNVOE4wWnY2b01hY1FiN3cwNys3YndVT1FvcXJzMVJ4cHZ4YWNQNHN2UmlL?=
 =?utf-8?B?ZjNZaFh1dG9UU1VaMDJ5b2EzcG9kYkYvTXNsa0ppZ2JNMy9OMUtZVVVvTEY0?=
 =?utf-8?B?RTJZRzYvb1Z4OFdDNzlSNjZKTUFnVEZLbm1Wd0hRYlA0WU45SWQ0UFBZTVhm?=
 =?utf-8?B?KzFBSEV4dW9nbUlFTkJIZXBELzZlUmM2S0VGL1hwVzBzTC9ScnhGOFBoQWc4?=
 =?utf-8?B?YklJYldRRXdXb2hFdmVXcyswYjQ0QjZjVkNqWWlML3FtckZZQ0U0bHNMS3V2?=
 =?utf-8?B?ZDJ3RFBpdVVSWisyTFYxd3dUQk5CVmhseWhLQU9mZ3ltSGRYVnpIamNqSjFi?=
 =?utf-8?Q?PZ5o08MSCUWBpbi0=3D?=
X-Exchange-RoutingPolicyChecked: bwRgOO5b7iN0/ovrgHdUxGdHysYIz1cIvf83AUzh1ucpFQJbNK61FnRRzDMnXNeWbdGAWG1CDs/MbS23cQSKa+AyjCUbCvrCqzGgIcHLxrMWKbyDOcwi+xx+ElxRU8dF7V06NstMDwM+/ueRW1vCrGPDpObnWbZphi+y3lcRiaJlp+haFd6vQ9TIpAMiMFZ5mIi/94AplYl8jHS9iKebR5/yqKZZn9l8HcCuMMjHLJDFSbBNi67GxUzy/vPm/I79mWThEEnzGrsUAgNepAgoJKTE0VM/K9vYvuh7KMOXZkxlylyV8Vi68cF6oW1kVCR1eFobue7aJVtspTUKPD10tw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d41c024a-1d65-4d87-c51e-08df1b1b5b85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3002.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:40:42.6943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVHqw5IXj9ltfKtnw19bhEs8q5BfqeUDCY209ewGBWtsL2nTmNUzEBY/5p/ZCmSLtZfBCaAOuqE6JD9yD7kmuHmfL6nqWBBqdBxTttiU+A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9374
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

Hi Bruce,

On 9/25/2026 4:02 PM, Bruce Richardson wrote:
> On Tue, Sep 22, 2026 at 06:23:33PM +0000, Vladimir Medvedkin wrote:
>> Add get and set operations for IEEE 802.3x link flow control.
>> Link pause is advertised only when requested, retained across port
>> stop/start and re-armed on link-up. The watermark and pause quanta
>> programming is shared with priority flow control.
>>
>> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>> ---
>> v3:
>> - Address Bruce's comments.
>> - Add documentation.
>> - Retain LFC configuration across port stop/start.
>> - Fix various issues.
>>
>>   doc/guides/nics/features/ice.ini       |   1 +
>>   doc/guides/nics/ice.rst                |  50 +++++
>>   doc/guides/rel_notes/release_26_11.rst |   4 +
>>   drivers/net/intel/ice/ice_ethdev.c     | 296 +++++++++++++++++++++----
>>   drivers/net/intel/ice/ice_ethdev.h     |   1 +
>>   5 files changed, 310 insertions(+), 42 deletions(-)
>>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> One comment inline below. I can fix on apply if you agree with it.
>

<snip>

>> +	/* Update forwarding of the non FC MAC control frames settings */
>> +	if (hw->mac_type == ICE_MAC_E830) {
>> +#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
>> +		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
>> +
> I don't like this definition right in the middle of the function. I think
> it should either be defined right before the function or else, at latest,
> just inside the function opening brace at the top.
> If you are ok with it, I'll move it on apply of the patch.
Sure, no objections
>> +		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
>> +
>> +		if (fc_conf->mac_ctrl_frame_fwd)
>> +			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
>> +		else
>> +			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
>> +
>> +		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), mac_config);
>> +	} else {
>> +		fc_conf->mac_ctrl_frame_fwd = false;
>> +	}
>> +
>> +	/* Update pause quanta and refresh threshold */
>> +	max_frame_size = pf->dev_data->mtu ?
>> +		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
>> +		ICE_FRAME_SIZE_MAX;
>> +	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, tc_bitmap,
>> +			fc_conf->pause_time, ((u32)fc_conf->pause_time + 1) / 2,
>> +			false, NULL);
>> +	if (ret)
>> +		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
>> +
>> +	return ret;
>> +}
> <snip>

-- 
Regards,
Vladimir

