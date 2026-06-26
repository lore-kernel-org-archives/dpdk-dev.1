Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D467FCDE008
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1492F4064F;
	Fri, 26 Jun 2026 10:48:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1F421400D6;
 Fri, 26 Jun 2026 10:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782463736; x=1813999736;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/RgYfTGC53HIfySqZYOMwYVpCTth5TV7QaLc0QRPtqg=;
 b=XeEHOjKKAFlxDa/pakz3uaUoQbWXC0o1vzmGoi45q2XwIg8RWBkUh6fX
 mxjUXRlXRfg2v0VgmvCkfMKpWImjoiCxhVSKWnuKuRImjSKlDyXATvVvP
 QPe6M8/URnOt9jO+9Is9WDTtOpnfI0jocPBprBPtKwdS+XyNcT4F5rFMa
 2vpbnuwfq6xmpi8/KgZgS23Fpyu3TEiJBFM9g2IWH5JGgzoGJk/LstZkz
 As6RssyuK+d9f520w0zUDi9hqezY0FKxwakAgdodLyxDsFQG2APWchuxp
 0vd7ZCjktkPEZR+igju4doYfR3KUU3KZYFF5A8llOk4BjVewiXbx9eXXE g==;
X-CSE-ConnectionGUID: CZsjTldKQPS2tKyk/pKeHA==
X-CSE-MsgGUID: Sr7vgSbpTNu04ivZEoi+3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83392052"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="83392052"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:48:54 -0700
X-CSE-ConnectionGUID: nf8tln2XRiGBKCV2MZodYA==
X-CSE-MsgGUID: YN1xu1XeTZCqNviXtnKlRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="247312248"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:48:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:48:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:48:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6lp+bGRdKNcOvnL9WVLeOg7yM1tFev9nbBR8GeTw+tw0PBT2P6c3QZvk5kfwXQvZfmDNOjXhjjKjApez0pbbA8I+BsBUt2wtAcA0SXItovEbM2eKj5hVwIXR1ej4tZIXWCISEo6Zy2VlOlGc9C+eRDpKlEBXmBOT85U4CNCnqbp68xwR/ufa2BK5SN667CPc8AkWF69leF55tOTmm8MJVbhIbJdbOq4ckEWfMCocJ1Ynw1fGID4X0mHq3Rp3o695kNws0aOTOel4vMC68SR5DS9ZcTSWTjJ4LwFSWYSMUlpP1XCIfOMXDwM0dQW8wpliqZzuxQKh97g/eTZFjaQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW3eL4uZMZyO/UTfDEhRKqzYK4XGhYKVnxrQCoEb2G0=;
 b=bMGHTU+2XrvuO/PCisiJi1/oBg6l7K5JtyNKFrUOc0+bJQ1CmzdAg3W88Y/wMMcmB8DanT8k25toTeTnN2a5GtdJ5aKewuiK7DQlB1P3tJHWjdT9Wt2GMlw1uSflKNZOYC7U88m8dwesZ4nJLerIQx6LXDg4hFeaqRc8mPN5Y/qhGwljpha0IMoUOblnFILYC/GbDGhy+30fWIF8mi+HL4hxFSRpu6sLRK4poy+slP9NDwiey0gxMpqpyKnElWsqOx8rqGDhqtLcIfg2KzfaI/E5gppwkdE3I6SUESstHrWMSv9phj3VgkCXxOLzlL9CVpGWLC5qQH4TUKF1w1kLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5661.namprd11.prod.outlook.com (2603:10b6:a03:3b9::5)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:48:46 +0000
Received: from SJ0PR11MB5661.namprd11.prod.outlook.com
 ([fe80::1aec:2e09:893c:ebc8]) by SJ0PR11MB5661.namprd11.prod.outlook.com
 ([fe80::1aec:2e09:893c:ebc8%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:48:46 +0000
Message-ID: <c2920f91-4c4f-4e30-8626-12f2606a20f9@intel.com>
Date: Fri, 26 Jun 2026 09:48:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost/crypto: fix segfault
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Fan Zhang <fanzhang.oss@gmail.com>
References: <20260624142023.1525497-1-radu.nicolau@intel.com>
 <CAJFAV8wCno0t-oLAtVCmWjvYOdcxGEGohcxOb2JP_W4W3cr7aA@mail.gmail.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <CAJFAV8wCno0t-oLAtVCmWjvYOdcxGEGohcxOb2JP_W4W3cr7aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5661:EE_|LV8PR11MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0b6ef2-76b7-4a10-723f-08ded35fb35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FDaBF0XpJupUdXTzQdgcRgVkeEwUM0qGe7HMXH7McYAw+REBX3wST9azwhwVY6IRjf1kOgmrGl30Rm5BtxukYlR5IRYLx5m4ChBqW1qOO5qeOpkdFLvq1RrvZQu3L2Ui4+9lNR1yLkpRHFaLnaTERLbSBGp4DD6tlLUiIk3QPv7h+siq6KzmAQa1XAU0amRQgUfz5EDOpjL1AjOzeW0W+qK6aonnCZCegkDgGMkLy0KR/wTmR1YGzvqclgz3RqkDgRM9ta/ItvwXsQeJN3Hg9GVU3eJ9mycOOsekaG2NiJaX1oGM1lUiCM7TDdugvNln+iro9jAm+e5CyMcBe3ec210FeyqmC0alQ/Jh1z0RIdoOJeM8TV4iytl+RSmX6FNJ2kQmcVeKTH0gHew9+o1QQ2zjj0+RW6fJ8WydtEU0dXSiMvaWyMrj8ZC/iYNfO9fPAKjLlXbJUCUv0S/QgblnSts2ZfMWkTnHtTgQUmo5pjeQ4tzt1NYwJi6bAwDqP2szqKhGVnxNSXS5Az7Jo2LhavwMgkedXbwp7c4IEEp/+Lc5e1K2F/Vmh0wuGGD7Ll2Y6uII1opeW3gIYzRUQgVe48MgC69dUsqNZqYyZaCA6i+pQeyFRwJpQjosTf58FsREqdqzUip18n+Xs0FHXhaRPtMsO0zBlKrZ60oRezWOTe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5661.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtUbU9rcTNXMVpBaFZnVytpR0pBbDNNYzZueE4wSDlGM3AzMVVKVUIyaDEv?=
 =?utf-8?B?ZXBRQnFiZ2xNNXEwek5WN253SXlscWxXTC9oL1IrU2ZsVXB0eEU0UFdUemFl?=
 =?utf-8?B?bnFLK0p3WmxJbmxjSHRGZm1DMmZaRUl0ZkpaYmwveXROQng4akZYSHhYTklr?=
 =?utf-8?B?Uk95bERtaVpvZFFmRDRUSlNTbUhTbzBhUVBqL21RdW1iWVY4VjVMRVgxZ1J1?=
 =?utf-8?B?NXpYMzZpRlhRL3NvUW1WcmxoSUtTNERQZjdEOHgrUlZFY0Y0eXNhVDFKYjRr?=
 =?utf-8?B?Q0dpakJhSlM2RlBVTmw4cWU4a0ZubEgxOEdHT1dodlJIYkh3cDZBVTl2ZDBm?=
 =?utf-8?B?aGZOMW5oOC8vZy8zNVRTd2xtVHREblBrSS9zSHBqcXk4QWpXbk5CY0tMN3Rp?=
 =?utf-8?B?OXMzeUlHOHZEM0VCcmdSZXpxZjRYMG9oZEFnOUJzMm45OUp3cXFET3FKc3Qv?=
 =?utf-8?B?ZkQrdENCME1UdDB1MWNDdWxTTDEzNU16T244ZDlaYXFTQnhDaE05YjZkODRQ?=
 =?utf-8?B?alVsK2M0eWF5ZmZJVkt2Z0JNZzk2R3JaREUwaUVONlhOc3hkZFFjRlNyR2ov?=
 =?utf-8?B?NDRHWFZPMlU4ZDFjMUZZNGlVSG9HWGdKTWFYclRTZmZJTGVHci9ZMi96anh4?=
 =?utf-8?B?YVhqNTJJRXpmd0d2Zml3ZEk3UGErZmhWRGdQWkVaZzhJdkFmcDlha2wxZk1T?=
 =?utf-8?B?dlBJbXdGMjhYYi9SaHppTW9xcDV4NTVWd0hpMHozbWZETy9TQklBajM5TFhu?=
 =?utf-8?B?WWhoQzFmZGJqRlBsRWx6WHJLMmJrc2dLVHhqTnNLUFBWczk3eVhEWmZ1NkJx?=
 =?utf-8?B?UWkyanFoMkk1NGJheUdTWDRNMTJ4ZXNPaW1FcUdkUkYvZGk3NVVTOVF0cjkz?=
 =?utf-8?B?NDR4SE1lTVdCWWFvR3BVYi9WSjdYY0djbWRRNUdLWVNKeEErMnVkYVQ5RWQy?=
 =?utf-8?B?VE91Z2pQMC9WMkpvNElMb2ZxZWFzWHJRclIrcllMcEp3K25sdmxCdTR2T3Iz?=
 =?utf-8?B?VjBndFZmWXBMTzhWeTNkL3FGdVFadk91WEl5b0J0dFFTalhJNU1FVTRveDhr?=
 =?utf-8?B?VGJXZmNXWkQ3TEkzSUVISjJxcjAyYk1Ld3pER3V6UytWaFdZaW9iMWJtaTNi?=
 =?utf-8?B?ZS8vbzZpQzZ4MDN3U05uS0NNR1RuTm96bTl5R0lPdFljV1hIaURWL3VyLzVB?=
 =?utf-8?B?SC96NHVwS2pJcEJFR0Zvak55WVFJL1ErTmNiM202S1NVWUpjVXNxVlY4MS9i?=
 =?utf-8?B?azllNFZIVmRhU1hyRjV6TzR6WWJWTCs4d0NLNGhRSzB3RzdkVnE1U0RvRS9J?=
 =?utf-8?B?L01PME8rMFd0cU5wczRXZ1E3cktoYlBRRndZNENTWmpuOU4xNjBUN0xzanVT?=
 =?utf-8?B?TG9pNzRIODNZUUFVZ2xBTkhrWFljVjduRmtNTUpnM2NFN0dWb1hERVVtZXor?=
 =?utf-8?B?Q096ZnFRMkRXNTRJQVZHaittejd3WENXdmE5aU5QTG5ZeUFmM3JkZFRxRXhH?=
 =?utf-8?B?MFFGVENybUluKzdGSWVqMkdRZ3FWN0ljb21nYVVPZ0podXdSdi9QSnNKaXl5?=
 =?utf-8?B?OUF4Zm9aUXNBOG0xVmk3Q1dVOE9QbEdKdHZHRDFETnNaUTZ3Wms0SmlzdDFF?=
 =?utf-8?B?ekNPRmlhYnZMQWNsNENsTkY1b2kwSlQ1clJXQkREeEhtM0plVno5R0d3WnRh?=
 =?utf-8?B?OVZ5OFVrUHZSUGxaa29FRFBjaGF3Nlp0NDZ3T01rMU53Q1dJVWMwVC8xa08w?=
 =?utf-8?B?L09DNFZoRW5COFVETHlsa1pKRWt5dE1JWitrTTdoV0FzUHRReWhqSDB4WkdJ?=
 =?utf-8?B?UFRZejdUZytHQTMwL3BSWFlXak0vc1VFTFJMT0dVczlwQ0xaYTBybmVOajhi?=
 =?utf-8?B?N3VUK0JHOU5haUlTTXRLdHV3cEtzcytVcEtIVzZjc0FNMjh3UlJCOUtMazdp?=
 =?utf-8?B?OUM5bWZOV1NBWnM3TG5Gb0g5RjZmSkdhcVhMMkJjR2k1RVhvNkg5T2gxc0xx?=
 =?utf-8?B?ajZFVkN0em13TVdHeDEwV2w2MHdQNjR1Z0ZEbFY2cmVNVGNSWHNNL3NKK3F3?=
 =?utf-8?B?RXNTLzE0TkdtQUZxY2FzampaMGdIRjN6eVlCMGZJay9BZ3Z2aDRVbXFGa1hQ?=
 =?utf-8?B?bUU2VXUwOTZaaTEzaGE2dmR1c0JwSlNuU1FDM011azVzVWFPNnFKS1RtZkp6?=
 =?utf-8?B?UGhYM2gvVXJ1OXBHaTQvcmEvT0NSQXNnYkE4a2VoRjBDV05KSGQwSy9QTzh2?=
 =?utf-8?B?ZDFLejcyeGRVYVIvZ2dqYnhZR0tQSWVRNTFUeFg1N2lmTU9PZlNNeG9MdkNi?=
 =?utf-8?B?ZFI5ZWJqMGFwRmNjbitEZUtGalNWOEJuY3MxVWRGcG9RMytMWXY4QT09?=
X-Exchange-RoutingPolicyChecked: oK54u2tBKzjzfu4pRxIWDFGYw5tcQuM+E51ec0N1sM1Zz9VEPFJl45+XYMsaDXvKAS9JS0bz+YxYbHZy8oIl20QVnzqEtQuA2A8sth7u5JSjtNQY7gTOPkYMvODzKok8JMvaemIWKtiB/XtMqMidVnj42sTf4nFuPeIIqQpXp2n1+cbw9IrescaXmGX1sbFqQTIINpJwH/MsF8NjZPemk2He/+8X9c2O58tKd1Nv+ZZhQTxYF2QLkDjyYcjgFSvtsGwFHwZfbBUt3koyazapsWOwZ2x4FIrd+7xls3MiqcwFF9mgdc7qKHSJuiNLvacESJyr+nJ+Lb30ZHrCV0751g==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0b6ef2-76b7-4a10-723f-08ded35fb35d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:48:46.6548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /snBeQDkPG+FMjWF51ttOTOb9ksZqv+nxEGfZVQzaLLeYLgla+Dt0qBPihGSnTUkGyuD4SnTr2Ol7h6PyrKp6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
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


On 25-Jun-26 1:44 PM, David Marchand wrote:
> On Wed, 24 Jun 2026 at 16:21, Radu Nicolau <radu.nicolau@intel.com> wrote:
>> Fix potential call with dev->mem uninitialized, one common usecase
>> example being running the autotest with more than one device.
>>
>> Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>> ---
>>   lib/vhost/vhost_crypto.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
>> index 648e2d731b..3679eaca1e 100644
>> --- a/lib/vhost/vhost_crypto.c
>> +++ b/lib/vhost/vhost_crypto.c
>> @@ -1512,6 +1512,10 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
>>                  VC_LOG_ERR("Invalid descriptor");
>>                  return -1;
>>          }
>> +       if (unlikely((vc_req->dev->mem) == NULL)) {
> (Unneeded extra ())
>
> It sounds to me that some initialisation failed, or processing happens
> without waiting initialisation finished.

Indeed calling this function with dev->mem uninitialized is caused by 
some init/deinit state bug, but I still think we should keep this check 
in for added safety.

I will follow up with a v2 to remove the redundant () and also I will 
look into fixing the root cause.

>
>
>> +               VC_LOG_ERR("Uninitialized vhost device");
>> +               return -1;
>> +       }
>>
>>          dlen = head->len;
>>          src_desc = IOVA_TO_VVA(struct vring_desc *, vc_req->dev, vq,
>> --
>> 2.52.0
>>
>
