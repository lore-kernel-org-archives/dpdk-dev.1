Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E584C4450A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 07:48:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BD9240270;
	Thu, 16 Jul 2026 09:48:03 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
 by mails.dpdk.org (Postfix) with ESMTP id 07252400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 09:48:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WypwhikwhY2xbFeiWJ/AyRgIDnDmnaLxVQkkC6J7Xw9lzbmFzKgbTY/APEDpsE9I/Qc5viecYUMeU8x218LEhLcDtSYcqPI85xAjxffwipA5CLjnxHpytsEJEfm2f9zfPlpO4W2DfKVGdjMvVCIQiJXA0SrC+nwM8eK3Xvgk6Tvps5f26OpJnfbffaBa7WhfpmvJtphx1X8P0Z6JihN+7GRPRpTgd/XzUUe/88yd9sm0RoTphQl3bDTdG3o/UIU7Pym/e+rIr9TCjs9MEmETs/YioCtbofWPYI5HKAWhsWlQ2ljF+yWL3kX8dPrT/Wdh7aPtaXkYXEW0LeDv/KQbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DsCoXjp2NEp5+E3GKKbZYvnzy0V7Vmpl99hutsdlrY=;
 b=pmbuwByKZf5k3IQ58kM07g40AN7gctWs3EBuI9+NycFQd2WFCCuTCb2Iht6mV5p2q1Mvzn1w/Ofrw/xQUxvpIR9N8B57JUf1HUNnrwV9tY8SoJPTbEXR8YTLSNshq3VdSWRLHBVxInvxM93t6LldRKrg2qN3tnEAlQARmHg7NZWVrAkHgNPG3Ep63+9yE3FBJSTtF7vK3GvaucBLAa+b5mi774P+IKot+wqyhMqtW/cdutXyCD2mnUsTFsINYFPPV8udf0GU9zKszcgf0qZTYX6XOKnqORQwMWybkFulg+sZ/hqdPiLJ+wjCh8urCWTC0ysMo4Cr4OctriQemF1hdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DsCoXjp2NEp5+E3GKKbZYvnzy0V7Vmpl99hutsdlrY=;
 b=M0H7k0wpd1+9Kay5XHuBak3zbZqRk4PM79oG61HWIsPBSgjWzEnvvjJsZtMluiThh5wWDFjJ+IpUf5f/S5xSYmAh4XICcWTSPTf5etPE3wDujtRjERPxmU9a1ujMk1BOa59vB6/v1py/uKO1joc0eSY/pHIgT8VlmjLbjQwXmjSy4lr5VzGVBDJnN/bCmVQKwRYMN+sJOJmHP00jZSJkK8wpjUoiYHCrtZXpqJ3yGPXNgWTxysFHuzgvyIrFxyPIGfxSjAPTOYDbJf5ekFd9nyq+C9K7L/PpFzeebsSN1XWoAj8FhRW73aWS74t5Ms0UaLyNIj+uwbWMd8FqrkpQtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DUZPR04MB9869.eurprd04.prod.outlook.com
 (2603:10a6:10:4ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 07:47:59 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0202.018; Thu, 16 Jul 2026
 07:47:59 +0000
Content-Type: multipart/alternative;
 boundary="------------eBLeHTj8vMPjB0z9XtUKvydQ"
Message-ID: <8d4177f8-093e-4460-9245-0a1e9e744826@oss.nxp.com>
Date: Thu, 16 Jul 2026 13:17:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net/dpaa2: fix RSS at inner level for non-tunnelled
 traffic
To: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, Jun Yang <jun.yang@nxp.com>,
 Gagandeep Singh <g.singh@nxp.com>
References: <20260630123857.392884-1-maxime@leroys.fr>
 <CAHHRULVvBsUjxVJh++BKsV_tGJLnh2Fuo+fJYh-=M_rsTKmVtg@mail.gmail.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <CAHHRULVvBsUjxVJh++BKsV_tGJLnh2Fuo+fJYh-=M_rsTKmVtg@mail.gmail.com>
X-ClientProxiedBy: MA5PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::14) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|DUZPR04MB9869:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c0b01f-2b13-4baf-a306-08dee30e8e5b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|1800799024|366016|56012099006|5023799004|11063799006|4143699003|10067099003|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g+E1N+IU23yVT8oLR4aLA6/R+zBFBCwkfxJkvcEo0OhEkDFSFYazhUUGl5E5L+rlLlQGBr3NmvrHWfa0DOqt0CknGqkpndXOOxHYPMXpBkuEGm8KnIkUg+IFOHiJ1RFxT7czI35BKiJaBDhmDdc3beh+ywGnRlLhXjeMMHSgWGsMdLT+CCXVZA6oTkbtHRRfHk26ePLh38SBVVR4RTHUGkhdDDvgCcvN4/VYV1fTXIdtsubrNxxlUEqhevwlCcCJ6/KfPdPauHqbasmx153JcaV60PEpToDppDupcJJemk3bSRBfo1uodouLsY02zDpI+j3jEEcb7qchlr3Dz4Ownj/uleVlXoaT5zCcbP3Q2XpbOy1cxVr+pV/Z58YuEB5jQFK6XHN0iXjdsFNUxQWf5RxkgclB8MVDs8+XgN9mg8kc/y/2Dmq9LtAotF3W+G5LoJsN8/ImtvQVuRVre5gyFG/kGGyE2RGRKbZ5ud9xwTzqQKTMNSPOypnldwd6Elr+rxHFKTu/oRkTYLMChzxc3S16+XLH2R8+/ImrdxcIJEU0ugFJeciTrp+vMFFd97WmSmPyWyfStvwmQAYtSFJuMQLAuv8JlyRR4EGBahgS5SYrXvV5E7Wrc3SHMcQ0GNJCIG9F4JoMVlLfYovjF+NhpJeANVVJBgr+u5vhzj081Ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JlMHNHbldTYWJZcHN5eFovTFN4eEllUDh0eGcyS2ttQzRTNUhUSG1RelVp?=
 =?utf-8?B?NlMwdFpzMXlRVS9nbXN6L3dJbUx0ZkI2VjZIeUprZjhpU1AwaDU5UHdkRWRI?=
 =?utf-8?B?OW9KOFVvZzMxMTVBNHlaTm1NUVFsUWlmd1JtUDArd0JBNUc0My9ocU5hTVRO?=
 =?utf-8?B?NmkyT1hJRGZsM2d6c004bllXT3RJZ00xYnFFcGhLb0hlbFBhZGk5Yk1uWTRD?=
 =?utf-8?B?SThMc3J1VDNXSkM0dS80ek0xZnQxR3lsaXRiSGF2MXRBam5rTDVIS2hIcVNv?=
 =?utf-8?B?eVRyQ05qQlJ4WFFjSmNPT1c1bDFUSnJLZTg5S2ZMc1JZZ01UaTdDMkpMTmlG?=
 =?utf-8?B?WnQvUy95ZHU4NXZQYUhYdVI2MTQvRXFhNXpKamhxZ1RTRytDQ0x5dWcvZksv?=
 =?utf-8?B?TjB2VFR1eW0wMGpyWDQwMzlHbzFVRkt6eVVYSWZScUJlQTY2bXJON044dDVV?=
 =?utf-8?B?NDdRUnV6dXRNeFY4S2FiZk40Q1A5NjVSNHAvSXFFREZZcXN5RzBrUGpXdkd5?=
 =?utf-8?B?dzFuQ2NoRjdCZWlLZGs2WlRxQnBmOTM5Q0pMbE0xbWNXZUR5VHNoN2NPSkox?=
 =?utf-8?B?UkcvNnl3V2ZDaWg1T3RkM3ppb01BS2wwbXU4THNmU3pwUTdZRE9RdUVwa0I0?=
 =?utf-8?B?ejRQczB0dWJUMW4xVysyeE5HLzJIY24wMGY2NmUwREFLK2FTK3JlYWdGMVF0?=
 =?utf-8?B?ZlRWbEN4eTV0TXJaVDBld0pMWFdaVkp1czVmUldFNGo2bEF3WENxaGM0N1M1?=
 =?utf-8?B?UlFhR016ZForUXdoMGJDM3J6V21Bb1prbzJNRTg5M0l6dWtoMUNETnduaWVT?=
 =?utf-8?B?RzBMZG5Ec1BPcTJHdkxWYWtrYzBlM1NFVUc1cS9Ra3BkUEU1UmFnVVZ2RVk5?=
 =?utf-8?B?TTFGeld3RDE3eHY3czgrRTJGd3hkUWR2UnQ4T3Rhd2RMY2lyOWEyUjdiM2VH?=
 =?utf-8?B?dytHTXY3WEl4RjNJZWhLcEx0UmIvL0Z6bFZlbzRnWmNsMHdhNTNDMjNyYWJC?=
 =?utf-8?B?ejBQc0VOOUgvN1JxRFhNZURNTUZIQm85NjF2Q2ljK2hsVFd3M1duQzV2NjNC?=
 =?utf-8?B?eEtHMDZuaVdyTWtXZkw3Z1BFaEtBVU8zYmNGQmtUVlcwd25SVDhld2t4dXJ6?=
 =?utf-8?B?d2k3d0dIMTVFU2RQbUI2cmhYYnoxUVZHbCtCZE1nNitiWjNEVmZ1MytwOCtK?=
 =?utf-8?B?U0tkckNCMm92T0VtOHhqekRXb0M5YUo1d3pmVlZ2d0FJRE9QcXlNMDg5R2J1?=
 =?utf-8?B?WWVINng1RjlBd1pNQUM3M0V6Z1pCU25jUGVyeWR3MmJvWlBmbzdSRS8rVlg2?=
 =?utf-8?B?Ukw5QXp2U1I3V01XQlZPR2ptSW5LZXU5SlQvdkFjTFVvbjhBQ3RXTjhjY2xy?=
 =?utf-8?B?T3I2ZXVzMTJDRndCbXNvT0pKOFgzb2k4UmFSblhtVXZUUitwUUZKMjluQ2lW?=
 =?utf-8?B?M1VnZFVBMDhUdGJwVVJTbVowdzVKMk9yUGxjK1RuVG5vVFNOMlFLY1lwYlU0?=
 =?utf-8?B?VElSK0ZFOGxlVjJKbzBGTmNDcHhwdWxKZ0VwY3kzRS9oVzl5U2NocGdJdkNC?=
 =?utf-8?B?V25QYjJ2VVBZL1RocEU1VHA4OHhvTllpTUVFaGtKb0lTa2VHdHNIWUhDbG9v?=
 =?utf-8?B?SVBxWXo2QkFwV3lvVlVkdmUyZjVLeGVGMHUvVU9sVEh4SHdFVVAvOVlSR1o1?=
 =?utf-8?B?L00xZC9qR3hFMnVhSVoxcVRRa3hGMm1GMHdnVHBEcG5BZU0yWXdobDNjQ0FF?=
 =?utf-8?B?a25sTm1Oek5kVkdyRFZ1Z3YwcjZRNGs5WmZxRWh2dmNCSjQ3RzlzZ1grcUVE?=
 =?utf-8?B?UnVXaldvVHdmVmxFNUJDSVRCRXVuZm5LMm1jUTdBVW1LOW1HbEp0aEthUjhZ?=
 =?utf-8?B?VWM2SkRqbjNaNGFxelJzZENGSXdaU3lmNEwzckxqNWNRTTkwaTlhTVliMEMr?=
 =?utf-8?B?SjFIRkJjeU42ZFQ1b0JmWjdmSk0yYitEdVFmZXgvL3lvMGxZVjdqSkFRb0Rn?=
 =?utf-8?B?L0paSmxDTGhSWU5qR3RPNU8ydVlOa05YemMycUlHdWd5WGdGQkhCRVlnYjcv?=
 =?utf-8?B?Tk5ZYmg3S2ZaOUh5V3VCdWEwRS9FWHcwdXoxZTJBdDlxRUxiNzlrd0h0TU93?=
 =?utf-8?B?dHZGL3ptRGRJd2RSRDd3ZVR1dFhuNEtXRVRGZGZYam1BNmI0YThWdlpmTjBo?=
 =?utf-8?B?WFZ6Y3hZM0tOa052Q2lBUk14SE9oaW9RVG9ETGlISlpQTDc2OXZ2WnNHWHNo?=
 =?utf-8?B?clpUQXFseXQ3N0cyUDhPTmR2dzhPUWZpWkM3MXVjQVhYUlBMN3o0anNwMmVp?=
 =?utf-8?B?WjVCRldhNjRTOGh2VDdlK0JFOEthZnZ5V1l3WkFOclBhb0xjRmkrcmdXa1Bt?=
 =?utf-8?Q?8gyYryI5Mgqxinq8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c0b01f-2b13-4baf-a306-08dee30e8e5b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:47:59.4380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFWrjCpZYjl2Urd+ldwSR7atxaclqgFZ7wcv+WJ3rrBwgjHVsxiQdzqa6ls4LTW4R1twW4GeIxj65jrH6PDN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9869
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

--------------eBLeHTj8vMPjB0z9XtUKvydQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 15-07-2026 22:30, Maxime Leroy wrote:
> Hi Hemant,
>
> Do you have any preference between the different approaches proposed below?
>
> Regards,
>
> Maxime Leroy
>
> On Tue, Jun 30, 2026 at 2:39 PM Maxime Leroy<maxime@leroys.fr> wrote:
>> When RTE_ETH_RSS_LEVEL_INNERMOST is requested, the IP key extracts use
>> the innermost header index (HDR_INDEX_LAST). The hardware only resolves
>> that index when several IP headers are stacked: for a non-tunnelled
>> frame, which carries a single IP header, the extraction returns nothing.
>> The RSS hash is then constant and all such frames are steered to a
>> single Rx queue.
>>
>> Always also extract the outer IP (header index 0), which the hardware
>> resolves for any frame. Non-tunnelled frames are thus hashed on their
>> only IP header, while tunnelled frames keep being hashed on their inner
>> IP.
>>
>> This is a deliberate tradeoff: the ethdev API defines
>> RTE_ETH_RSS_LEVEL_INNERMOST as hashing the innermost header only, but the
>> hardware cannot do that without breaking RSS for plain traffic. As a
>> consequence, two tunnelled flows with the same inner header but
>> different outer IPs may hash to different queues. This limitation is
>> documented in the dpaa2 guide.
>>
>> Alternatives considered (feedback welcome, hence RFC):
>>
>> - Hash both outer and inner only under RTE_ETH_RSS_LEVEL_PMD_DEFAULT and
>>    keep INNERMOST strictly inner-only. The ethdev API leaves the default
>>    level to the PMD, so this stays API-compliant; it changes the default
>>    hash for tunnelled traffic.
>>
>> - Add a generic RTE_ETH_RSS_LEVEL_OUTER_INNER value to the ethdev API so
>>    applications can request hashing on both encapsulation levels
>>    explicitly, instead of overloading INNERMOST. This needs an ethdev API
>>    change and agreement from other PMDs.
>>
>> Fixes: 32f701671d2f ("net/dpaa2: support inner RSS level for tunnelled traffic")
>> Signed-off-by: Maxime Leroy<maxime@leroys.fr>

Hi Maxime,

My preference is to keep |RTE_ETH_RSS_LEVEL_INNERMOST| semantics 
unchanged and strictly hash on the innermost header.

I would rather use the PMD-defined default level to provide the best RSS 
distribution for both plain and tunnelled traffic. Overloading 
|INNERMOST| to include the outer IP makes the behavior diverge from the 
ethdev definition and may surprise applications relying on true 
inner-header affinity.

Longer term, an explicit |OUTER_INNER| RSS level would be the cleanest 
solution if there is interest from other PMDs.

Regards,

Hemant

--------------eBLeHTj8vMPjB0z9XtUKvydQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 15-07-2026 22:30, Maxime Leroy
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHHRULVvBsUjxVJh++BKsV_tGJLnh2Fuo+fJYh-=M_rsTKmVtg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Hi Hemant,

Do you have any preference between the different approaches proposed below?

Regards,

Maxime Leroy

On Tue, Jun 30, 2026 at 2:39 PM Maxime Leroy <a class="moz-txt-link-rfc2396E" href="mailto:maxime@leroys.fr">&lt;maxime@leroys.fr&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
When RTE_ETH_RSS_LEVEL_INNERMOST is requested, the IP key extracts use
the innermost header index (HDR_INDEX_LAST). The hardware only resolves
that index when several IP headers are stacked: for a non-tunnelled
frame, which carries a single IP header, the extraction returns nothing.
The RSS hash is then constant and all such frames are steered to a
single Rx queue.

Always also extract the outer IP (header index 0), which the hardware
resolves for any frame. Non-tunnelled frames are thus hashed on their
only IP header, while tunnelled frames keep being hashed on their inner
IP.

This is a deliberate tradeoff: the ethdev API defines
RTE_ETH_RSS_LEVEL_INNERMOST as hashing the innermost header only, but the
hardware cannot do that without breaking RSS for plain traffic. As a
consequence, two tunnelled flows with the same inner header but
different outer IPs may hash to different queues. This limitation is
documented in the dpaa2 guide.

Alternatives considered (feedback welcome, hence RFC):

- Hash both outer and inner only under RTE_ETH_RSS_LEVEL_PMD_DEFAULT and
  keep INNERMOST strictly inner-only. The ethdev API leaves the default
  level to the PMD, so this stays API-compliant; it changes the default
  hash for tunnelled traffic.

- Add a generic RTE_ETH_RSS_LEVEL_OUTER_INNER value to the ethdev API so
  applications can request hashing on both encapsulation levels
  explicitly, instead of overloading INNERMOST. This needs an ethdev API
  change and agreement from other PMDs.

Fixes: 32f701671d2f (&quot;net/dpaa2: support inner RSS level for tunnelled traffic&quot;)
Signed-off-by: Maxime Leroy <a class="moz-txt-link-rfc2396E" href="mailto:maxime@leroys.fr">&lt;maxime@leroys.fr&gt;</a></pre>
      </blockquote>
    </blockquote>
    <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
      <p>Hi Maxime,</p>
      <p>My preference is to keep <code>RTE_ETH_RSS_LEVEL_INNERMOST</code>
        semantics unchanged and strictly hash on the innermost header.</p>
      <p>I would rather use the PMD-defined default level to provide the
        best RSS distribution for both plain and tunnelled traffic.
        Overloading <code>INNERMOST</code> to include the outer IP
        makes the behavior diverge from the ethdev definition and may
        surprise applications relying on true inner-header affinity.</p>
      <p>Longer term, an explicit <code>OUTER_INNER</code> RSS level
        would be the cleanest solution if there is interest from other
        PMDs.</p>
      <p>Regards,&nbsp;</p>
      <p>Hemant</p>
    </div>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style></p>
  </body>
</html>

--------------eBLeHTj8vMPjB0z9XtUKvydQ--
