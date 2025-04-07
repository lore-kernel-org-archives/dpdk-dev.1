Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3113C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 03:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E0B340156;
	Mon,  7 Apr 2025 05:52:19 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013063.outbound.protection.outlook.com
 [40.107.162.63])
 by mails.dpdk.org (Postfix) with ESMTP id DEF1C40150;
 Mon,  7 Apr 2025 05:52:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGOAvnODzcZe6+5YtXlDvMqDR8BRzA1rjtl28nke9PjaJkTDNpzFwtAgpymvSG8xILzlwqJWKo6ZpZ6roZ83upzFO79B8NwAWKXq85LYUlMNtsMjdRCqRHW/ty30zg9coXvlDVAP27Um32Y50VkGe0xnpu8mIs1y63/74fohdEK2Jkhfxx07pzzqGfKKtqXCkrfE6PtO1IWubLHS32Y7qClKkSyxCzWTYGEeLgP2k2B2b8z1YhDb9JVr1UVYCvkQiXwLPi2BQYyOlY85yhdDEPkkdsWjUA5GSg6F+n1K/YKltxA8bjF9dh7ujGtCXdX+s4oJafPQrKAQoGYFO/HJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5aceqhabZqr6XJRI2cJQEwI/P+4okXItsIIEVzz6A8=;
 b=W3Zt1DRwB4K9titwblru47Ak/q6X0UzXJnTIC7wHuHH5I+nIdWzKc/JLoTlaU0TeKWR0w5XivQWTKDpHsU3LtpXQFqcdhzLewAzv61BplRhwHBVd9iy3XbN2IYc0zlMxmjjLIxOzEGovuWli+bfciNiUKSBFRNfpI+4vwgxaI75ZlHEmVuq1YQ0uwDOXGhL2jjUhPVV9QfhPkzSVb2KrUs5ezN4ipSO/I4v+feNjMNGxucTemdOG+4UsZI8h1okfpeAgi33W2rLLvmZ8BlVOvWXa1J3AAP/uXzxpjnt8yh+t2usuVAHdO0yaEzJ7OYnCQB6RX1E/2DVOMFs/Q+10qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5aceqhabZqr6XJRI2cJQEwI/P+4okXItsIIEVzz6A8=;
 b=kVOPhYWlXX7uCzQf2f/07Vgz0Fq1A3a/h3KRLxC8EwsB1aVq4a/I6ZoP9KnF9ixAia+0qcCFEV+JdlpK9Ek4GGtBLtYIIVP7ugPc7db9skE+c/6gp+mKbKnd0OzneM+2gsK0klu0VdGN2JxIKbYoVptVSUskvtUsj5plxoSp9MAmYHl9rDWA5oHaCzK9cpeR0KMVzU2N5mcEVwSxtdaX3rcUA+bWqxkW0Ela1O1eOR4mqkEEdfFUY/ufKLYMNAJcyOZwgeSgSyvyc+HBTKE2pE2CZm6gJwD6c5ssMxjTMcU3ygnalWxroVYHBeNAqLObFd46MC/eVeAh0wdDPdOYzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AS8PR07MB7608.eurprd07.prod.outlook.com (2603:10a6:20b:2a0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 03:52:16 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 03:52:15 +0000
Message-ID: <d09b4e4b-4187-4723-9e7c-93bf8c6a7ff2@nokia-sbell.com>
Date: Mon, 7 Apr 2025 11:52:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] eal: prevent socket closure before MP sync
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>, dev@dpdk.org, stable@dpdk.org
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
 <20250317065609.79fa3ad7@hermes.local>
 <ed17ac5a-2456-430e-8757-fbe0ae2fc198@nokia-sbell.com>
Content-Language: en-US
In-Reply-To: <ed17ac5a-2456-430e-8757-fbe0ae2fc198@nokia-sbell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AS8PR07MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 3303b3db-ceec-44c0-9448-08dd75879610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVMxWDE1Z2hsTFc2TXorNEhFQTJwb2pFdnlWTTY5ZndQdHVlZjBYQ1htN3I1?=
 =?utf-8?B?YlNvTS8rVzA4bU9hTjg3T2VkcmlnSHgrRlFyV3p5ZTBXeTdRcUVodms5Rklt?=
 =?utf-8?B?U0Rpbmg0YVJ4OVUrdFNNZG1hWkhSckE4TWh2eWpVWkVYQk56RXpHaitlZmpa?=
 =?utf-8?B?bWJYcUFLZXA0RnFyazcvb0VZdjJsT3l0M1ozYlJiWEc2OTNrUFUzSHhsRVl3?=
 =?utf-8?B?ZHcxbGFnb2U3T1owMU1kb1lKcnJNWEprQnQxMEZLZFFUYTJUOUNSaFgxaTZM?=
 =?utf-8?B?ZWRtZG11TTNiK0pqb3pvZERmdzNUVG9TZW1IZ2JpSStYREFDNDlwNTBGU21U?=
 =?utf-8?B?Z1dFSFhTOU8wZHZkeUhrSnhvM0dZV0diUFF6bDdyRXRHZUJtaUt0THhCVDZR?=
 =?utf-8?B?aS9wcEJPY0o5ZnUrU3l2UDlhNS9OMGxNVGQxMG0rMUFUY2dhL0t1WFh5dTFi?=
 =?utf-8?B?TUxSeTlkREt1ZGMwU1Q2MmYzZXNxTTRDUGI3eFZGd0hoVk52Y0UwYmc3bEw2?=
 =?utf-8?B?SmpqVDhPWGZaZ3hxLzhWZW5PVWpVZWpSbEFNRXFVb3dOT2xDdWpCRllDSlI4?=
 =?utf-8?B?OU80WlVCZXRWNDVBMi9VUFpDRTJHZ1RNMW1ETnc3QW1mWWpJbnFnS1ZvN05J?=
 =?utf-8?B?SHhGMkgrL0RNN2tNbEsrV3JFVlpZb0VuaEZyanJQaWFBRElUUE9LQ1hCcWdG?=
 =?utf-8?B?Vnp6eXcySExGY0tpOTBxZlNUVE1BMzFCSmViYjVnV084ZHlyOE4zcjJPaTFn?=
 =?utf-8?B?RC9Sb3lUNkI1RWdTcVJaNGFvNGltM3F0MnRmOFNwc1kyOEFaU2F4VVhOWEdS?=
 =?utf-8?B?VHNtemJDUjF5RDBoaGVkOENDd1Q0b2dmRGdReFlETXd5aVFwOXV4SWJGT1lV?=
 =?utf-8?B?V3pjY0Q4SlFsdWFDQkNSZ1RmZ0MyaUVaZ1A2UzdqdHFXTU5CYjNMNFBxM3VM?=
 =?utf-8?B?VjdpcGp5YyttbFlzWFNRaWFqQWxxZGYyU1VjVVp0VVRscVBpL1NwUWRnWjdT?=
 =?utf-8?B?bnd1VUtkZDlvOWdNNjA2T01WWGhNYVRXWHU3M0ZVNEZtNE1GNlArNmNYTTd2?=
 =?utf-8?B?RlI4NHZqZ3FhSklrL2hPbmdQKzNPbFhUSDNMWkFYQ1YwQ1d1ZGVRZjFMNS9J?=
 =?utf-8?B?VFNDTFRtWDlnSWk4SXFDdUQ3NFJ6TnQ2aDIwWWgrWDVqT2RpYVg3L3JrbitH?=
 =?utf-8?B?WWRZK1lzeUhvVyttNkxXTkFsSFBvN1ZocDZpQmsvZEFZS2JaYm9FTWRhc3Bp?=
 =?utf-8?B?Z1lCNzlJKzA2RkY1RUhobXFUdGZLdit1a1N2L3dpTUFTblkwUEhHMSsxRGdS?=
 =?utf-8?B?RngzbW0vMDZ4RXM5c2tnbkVITm9lQ1piK3NqaE80NmFqQXUzaGEyaHdGQWxo?=
 =?utf-8?B?T29qZGQ0clB4NElBSnBRNytJZEIyQU9PRVQwSSs4bm1VYi9ZRHBBTkdUeVhR?=
 =?utf-8?B?V1lNTXpVeVRFV0pXSkJXYlFsNWIvdnEwM2xXQy9Ha2gwUDFZbzJxWnlIckZp?=
 =?utf-8?B?ck8wVFh0ZmdqVWZrTU16R2dCWDlMcnVXenJoSWszSEtwd0hPNUN5V2RJeEU2?=
 =?utf-8?B?R25SUXF0THVqcHg1MUtPVXpiOS96aFA2R0dPZG9JQkhsaEVCT1hGdnRHdkxl?=
 =?utf-8?B?ckVwQ0ZaVXhkR3V2N0pOODZ3Z0xzcXJ4cXZlMHJxajVRdFpmcGhmV3ZNL1hu?=
 =?utf-8?B?UStpL3NscHpzcTNLZDlMaWlRWnMvSHNUUDh0TTV4WHMzYWNyK0dPTTdLSWEy?=
 =?utf-8?B?a1QwVWg3NEhMTFg3bjR0TVdlVEttWUZ1UDhVb2JzdFpBVGdDMWdXOHduVHVX?=
 =?utf-8?B?NWdGYTZZQ1l3Vm50dXZIbFIrQ05BRWpuRzNJaGpjNHRZbmNtTFFjNWp0UDY0?=
 =?utf-8?B?SkRWWkxhV1NENzJiaDg5ZERuRmZYaXdJZVBhelZtaVNmVVRVUUd1anBPb2VO?=
 =?utf-8?Q?bJnU1/vco0E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlM0dEc3WVV0aDJWRndVcTZMSkUyaWh0TFZmeDlOM0xBakd6NTFIM2FHL1Na?=
 =?utf-8?B?c0VCcFFQMWxsbXlBSmxhbVh4cmYvUVpOMmRwanpQS2JPNlFrejFtdEttOVov?=
 =?utf-8?B?Ui96dzJVREY5SEI5TXQ2azVuclEzV1R6ZjdjY1UyYll6NTdsNEc2MWFDTGha?=
 =?utf-8?B?RXZMTUFEWDFSNzM1R0hFaS9ycGdDaVd0emdER2VlSDVmQ1UxM1R3T3IwMjl3?=
 =?utf-8?B?bk01NU5LZ3ptaGlEdG14RTVaUnJrYU96eThmTmU2cXRVUVhBTEZweFF1akxi?=
 =?utf-8?B?M1Z0eWxlNFlYb1ZpZm8xTWR3ZEE2bVZvZ3ZabVloZ3pjeC9Sa3RZeFc2NjRU?=
 =?utf-8?B?WGE1SHlWMlBRUE5YR3VmQWhMTEhXL0NTTFFidFM0aHNJRU5VOHcxN1l4YlUr?=
 =?utf-8?B?YzBtbjJNdTEwVnpDVHVselAxWUlTdjNYOW5tWmUwdUo3eGUvWHJJOXNxU2t3?=
 =?utf-8?B?NXhLajNsWGJXZGM2Q25GWlVLK0dhUXdwK1lMc1pJN2VRV0JmMEt3MzE4NzlQ?=
 =?utf-8?B?YlN2YnMwcDdZMkdUMGxGOUZSVVp3U2dIZDlSSHdEK0c4ck53Qkt6ZTZSVGk3?=
 =?utf-8?B?WXh0QnV6OG5valhHZ2xHZkttb0Q4Q3FpN2VCWjBIWDhXYnZkTFArTkdWUEJ1?=
 =?utf-8?B?emV3S0Y2RnRLd1QvMEdRVW5KT0IzdGtHTGk1Y3FmcFlJN3hvSFFneVMrek43?=
 =?utf-8?B?TUxpczBtamRWSXNxNzRIbFAwQ3V3T3pzNDl6QytJenJLWUZWbUVZNUp0SzFz?=
 =?utf-8?B?cFZIU2taUzA3Qk1WcTZBNSsyb25rZkUwTWtFbEh4SmxvL0t3OVhLMHNDWDlv?=
 =?utf-8?B?aS9DZVpSOEVuL1N3TkJJV25WL0dmakhnaGxVM2JPNTVLWkpSazROM1dlRmZT?=
 =?utf-8?B?cDZOY1pLbkt0dHNDVkk2UHVUV1N0NzhFQjltaHdZeUpvd3hBbG4rQ3lWM1RT?=
 =?utf-8?B?ZjNsak1Yam9JQXlKaXFzMWZkd2R6S1U2QWNwSmxVVHJGNGQrV28zNFJtVlVt?=
 =?utf-8?B?VjNMVFg2SHFRTU9Dam5OWTlEeGdrYnBPRHMxUUtmc2dOWWMxeWVqaVJFZG9n?=
 =?utf-8?B?eCtEODhGbTBhNWxxQWI5Y2Z3ZlQ4YUNXODJ6TVBHS2VreGxOalZtZEFUYTZ6?=
 =?utf-8?B?VGZUVDZHWE5jb0FxL1BZTjFaRms4SUdvRC9yWGRrTVNkZVdjR1pWWktrUnkr?=
 =?utf-8?B?WmhDb3U5UkQ2WGgxSkI1L1gxWlp6dTRYUzhXR040V1RDUHUyTCthNS9JUzY5?=
 =?utf-8?B?akR4Y3hOQlZEbG9sai9FMkhiVEhrTGVOU011WENxSUJ3UVc3TW55YU9KTFdu?=
 =?utf-8?B?b0d1YTBLQm04cUgrUmF0R1VkMXJ2VitqbmpISDV5Y3Y1QWZKanpabUNoQm83?=
 =?utf-8?B?ekVwVlJwNHNqSWZPNUQydlZGejdZd2V3RWNFYU5rZ09RMEFTU09vRVRDajRG?=
 =?utf-8?B?WS9CTW52Y2YwdldMTFB1bi9VeU9qVGtqcWc4ZXlzdXR1Ky9OOVM1MVh3M1hV?=
 =?utf-8?B?UFZ2azhKNi9NbGpjL1lDaVRFZ2RQM2tYczEzUGRFanRmcDBpRTRtRitYN3ZM?=
 =?utf-8?B?bUVmL1E4S0tMcHhKbUpFOEVNcmtrdzhscE1NSnlpdmZuTkNiYnB1TE01REFR?=
 =?utf-8?B?eWZSVmJXdkVXYlg1emMrZlZhTmoyRi9SYTRXMmFTblFZaDJWV1JlbGpNMUZn?=
 =?utf-8?B?T0F4M09vekovT2lOZFAyQXBiMm5hdnlEWi9ab3pyTGdqeTI3OHJ4QXhWWmdx?=
 =?utf-8?B?SjVvbUNFN21WMitLNXFSckJ1RTBXL0VnL2NSUDdvNjd0dk9DRDJYam9xUEk2?=
 =?utf-8?B?MCtJcFg2MVVXblRBb2ZrWFdCckF6NDN0UnU2TmdkS01Dd1o0SDJsekMvSjIw?=
 =?utf-8?B?VUEzTDZQcEpYTkJ3TFhjMUpjdW1xT0tzTmRneUNpbUhCVTVsMlZUYThieWJ5?=
 =?utf-8?B?cXpIWElhZHBaamQ0KzFTTGlLa3BPeGhQRnBwUExFcThDRlhOM2ZGTFJ2L2l6?=
 =?utf-8?B?U2ZQcWpDOGRuSGRKdkZ3U0NwZlE1ZVhPYkRSdWlOK1FxRDNsM0pIcDJ0TUlW?=
 =?utf-8?B?VEhQR2d1UVFkeTh2citaWlN2QUNiUlVwT3VPR0poOGczUVJCb2t1Qlp6aW94?=
 =?utf-8?B?K09JZ0piZFVXWWhxbFk3NnFpazBONGpZWFBlSWdsM3RWWktWUDFINXp3RzF3?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3303b3db-ceec-44c0-9448-08dd75879610
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:52:15.7376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/n25Q93P+6EF1MjENEFNUADxMpyrXbfFrkLoND2c+ql2/2eiZpTpXULjWwhQE5Wmf7otYJGGl/aHTk+ABdygYceS0dhnYwpitzumz7tMhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7608
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


On 2025/3/27 17:28, Yang Ming wrote:
>
> On 2025/3/17 21:56, Stephen Hemminger wrote:
>> Caution: This is an external email. Please be very careful when 
>> clicking links or opening attachments. See http://nok.it/nsb for 
>> additional information.
>>
>> On Fri, 14 Mar 2025 18:36:38 +0800
>> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>>
>>> The secordary process should not close socket file for MP
>>> channel before performing MP request synchronization.
>>> This prevents error logs when the secondary process exits
>>> without any operation on the crypto device while the primary
>>> process starts the device.
>>>
>>> Case situation:
>>> eal_bus_cleanup has been added in rte_eal_cleanup. But for the
>>> secondary process, rte_eal_cleanup firstly performs
>>> rte_mp_channel_cleanup, which closes socket file for the MP
>>> channel, making mp_fd invalid. Subsequently, eal_bus_cleanup
>>> triggers vdev_cleanup, which calls mp_request_sync to send a
>>> message via the MP channel. Since mp_fd is invalid, error logs
>>> occur.
>>>
>>> Error logs occur as below when the secordary process exit:
>>> EAL: failed to send to (/tmp/dpdk/l2hicu/mp_socket) due to Bad
>>> file descriptor
>>> EAL: Fail to send request /tmp/dpdk/l2hicu/mp_socket:
>>> ipsec_mb_mp_msg
>>> USER1: Create MR request to primary process failed.
>>>
>>> Function call trace:
>>> 1. rte_eal_cleanup->rte_mp_channel_cleanup->close_socket_fd
>>> 2. rte_eal_cleanup->eal_bus_cleanup->vdev_cleanup->
>>> rte_vdev_driver->ipsec_mb_remove->ipsec_mb_qp_release->
>>> ipsec_mb_secondary_qp_op->rte_mp_request_sync->mp_request_sync->
>>> send_msg->sendmsg(mp_fd, &msgh, 0);
>>>
>>> Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
>>> Cc: kevin.laatz@intel.com
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
>> Looks good, could there be a test?
>>
>> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
>>
> Hi Thanks Stephen,
>
> We have some findings for this change in our product test line. I will 
> do more investigation for this patch.
>
> Brs,
>
> Yang Ming
>
>
Hi,

This patch has been tested and functions correctly under normal 
conditions. However, during testing, we observed some new error logs in 
specific cases. Upon investigation, we identified that these logs 
originate from a separate issue, which will be addressed in the next 
version of this patch. Additionally, a similar issue may affect FreeBSD, 
and I plan to include a fix for that as well in the upcoming patch 
series. Please note that the entire patch series has been thoroughly tested.

Brs,

Yang Ming

