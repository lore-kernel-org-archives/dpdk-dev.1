Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E05DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 984974028A;
	Mon, 13 Jul 2026 12:04:21 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
 by mails.dpdk.org (Postfix) with ESMTP id EF82440276
 for <dev@dpdk.org>; Mon, 13 Jul 2026 12:04:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygSnSQVa69jjwWm3J7bWp7WCiv2cZ3Y2qd2hG1b/zz2ULbv5PIit5/jbQ2Aww7P4+IsxV4ZI69/2yg1pnfmxH6VWFF+t/xHClQg2HN+OXCRUmKwZzCdbodyCx1hu6Za0DlN4S7XF6b00wiEvlAOg4LvYTRQDEaScQcn8l/u1U+w9Hk02hXHfHs5I7malaSWI3k1l9QBXIZzGRX8R/NCXy567GCxZch1XRpbDn8hOZ30PlgYcXIqODKD1bFxHhQCm+o8Zb/Fru3OddnHhu2p1yVlxKIbPYP36oHOisf8DWWQFcLThxBsF9EzWY7cCfV3VFECJ9TzN+x6iTGZmvmNG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQf7kjVMvUOUUSAacqRynIlknOPRL6eUamQ5HPtqCQo=;
 b=BOJmls/cnEpgA6K8ruml0Vb2F3ZQanMzsvabV/cC0P5KPXWEE4z2rLECwyMNeSpEglhvHZEnseR0jxifAVv2v7d235deho/NtAmSAaFvK+V6kWym7KmwnMULyFSfr3If3c7WrlBTmrmZxkXehKJdCKHp6Wne5MNYgTUjGzJiLCiMj+cfP/Djl97CSCV2dU/tsMeUKLPeG3OPdsDoRW1jqqI59g1dS7XoMvRrSn5wfaDeGGnNu4sBQ1Hy8+49yxZI2SdH1syVtOK4/HOjTcpKAxrA3PjnQ4ssucnqoIC9ZG7U5pmDz2A4AMTIrBoR8KTWMS7sNiHn5cQSd7YKI3VArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQf7kjVMvUOUUSAacqRynIlknOPRL6eUamQ5HPtqCQo=;
 b=STq/kPbJiNdW7oGCyaoIzbYTYM5m3xqvUCKvbsQ4BeJo0bC2hF8d+/2QZk52MehawtD0yNxRXyP7c1mXWbAn4NY9MvV7EllyGJeHEo/etzWmbbmdRpKy0W2MQ7RpvKnPM9KJ0ruLejmSTZxWORUQVS0CQTFjpNO0qyEUg3Urr3vnL4ws/lv6LW0P429kf6hqVLjY+iUNf3boco0Xq7zbIA+rHq224nB5bdAB+5fbqHcIH+JiE6MygJragYSL1RUdFawvSqUeZTUUhLlDwLZna8h6yrN+MBCUVGN2mPFynEU07tD+cNnjexvKiBWgsJoy+brdhnh3dJWUaM79SG64VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by DBAPR04MB7286.eurprd04.prod.outlook.com (2603:10a6:10:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:04:19 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%5]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 10:04:19 +0000
Content-Type: multipart/alternative;
 boundary="------------V19Yxev0kQ0arPay0R3ys7EB"
Message-ID: <d646d669-0adb-4904-9d83-6a1b25ccda3a@oss.nxp.com>
Date: Mon, 13 Jul 2026 15:34:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: DPAA driver series - mix up
To: Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <G.Singh@nxp.com>, dev <dev@dpdk.org>
References: <PA1PR04MB10770E11CEC25E074365C3E1289FA2@PA1PR04MB10770.eurprd04.prod.outlook.com>
 <iSawvfAuRvCNNdxNcuk17g@monjalon.net>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <iSawvfAuRvCNNdxNcuk17g@monjalon.net>
X-ClientProxiedBy: MA5P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::6) To PA1PR04MB10770.eurprd04.prod.outlook.com
 (2603:10a6:102:492::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB10770:EE_|DBAPR04MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: c95201f0-7112-45f6-22d0-08dee0c61a76
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|23010399003|18002099003|22082099003|11063799006|56012099006|8096899003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: z5HE/3C5P63isImtuLQUxmncbJnq6+Vi+0NZb7kLx2rEnldX19KaKCR/bp81CxSd/xMxRNiNm9JaohGF6+GUQoMJVX8Y2TXOvVR9M3bHegfUobVAv38qikTMdz/+AcVCVzHIGONCvgzWZYC4/wdkmMBwPf9E47GwbhW1u+BRoz/cRqATCQ4YVz2nxgUvqQNA6tfVNabMeh4I4tnLiFHvxO8lhBmR/V766BvG7B9wfoWoMRj9k7PjOHIa1hUZrPJwJF0iy4nJ2gZKunTwObmsahRGE13kbz4l8IuNRGdXXCOSU45lm/qChh6z142k7r2rIOGdRaDAlLPthFNchKneHnLTwzuc8aSarQglvQHcb95E8h29DCXD3aG17+BxypCobZe07VsDbfqfX3kV2FxJtMdcXntPW+vZHagPV36SRbkTVShEsqIurxT8h8+snJybHEkb/JMF6zhgb1qaI+Y/VY5oanZGRBWQqhYAeVJWsXiEnS4QjoxQXTD57kHpj0XEM6Vc7I0/Gb76Ia+ed430N9xubO9g8aEyP0JEh3CJtJomhiLF79LArmwFjgkrUY/3OU1JeTNpp9+cB4uZzwZYKnz4p5srztdQtGZ/oubKx6ea9Cb/tEt3qsu/OJeWkqiS19gbZESHx/lvEXdbk7dqKc+z4CDWJR4SvsZGxKGjx40=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(8096899003)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZLY0tSOGtLcEFxM2FUVFRMTFloeEY4T1FCWEhZUE5PVDNWZzRlUWhjQlY2?=
 =?utf-8?B?cDVkODVoTjFqUVNyTUwwc0VZMjJIemRnYXd6YzRHZ0NkdzBDaEoyNWVzVjMw?=
 =?utf-8?B?ZWFXMUNoQjJnclgrNWVMWUJqK1B6ZDMzQ2dqMkxEaXpVWWcrUE8yYmFyeG1L?=
 =?utf-8?B?TzhuQzNNWlNMSXYrVVh1b0NlakxLeW9XM2xyN1VlMHl0RnRIMVdtbElxVTBR?=
 =?utf-8?B?aHRpam1PVVBMSGRsdTRWaUNuclVIeWNLczZkeDF5UmViVUxpLzJWVk56VzQ5?=
 =?utf-8?B?bWd1L283RkVjZkE5TzAvdUNjenU5ME9pNjdaazZybSt3REhOYmZJdEd4a2lV?=
 =?utf-8?B?dGpMeHhnSDR3UjBrcDdmM3MxaHk4cWJ4TDhSTm9vL3dGWEtuUmx3RXVaQVNn?=
 =?utf-8?B?VlNKUmoyQVFLWCtpTDJTTnFOUkpBZ0drdG96eEhpSU9TM3hzMENpdzk2OW4v?=
 =?utf-8?B?RXZsZWU1QVkwaVJ5K0x3TVEva0ZpalowSEttc0lUcUpWa05hQ1JLZlZtcjdC?=
 =?utf-8?B?aVByeStBc2FtSS9JeTdVbXNLeHYzdVc2TUV4ejlaay92SlQxQk8yUHY2ZFpp?=
 =?utf-8?B?OVZlNDFJckNUc3luSDRwU2xPME1DT1lySlNlb0NGdmxyQjdsaS9qcERhc2NW?=
 =?utf-8?B?Z1J6VGI3YkZHZ2tmNnlrRUdMK1dNVVI3ckhTWUU3ZkxKMVdkSUV2ME1SRS9C?=
 =?utf-8?B?MUlzc0dhRS9HK0hGayswaXpCUXZOb0UxQjQ0MHF0M1EzRTdLeWtma3NrOTVB?=
 =?utf-8?B?MHdJdlRadGxVMUpJOEFxbU5FNDE4RHdhUTFNS3RpWXZWVXJnQWdxdnNUL3pt?=
 =?utf-8?B?bWVXU0x0QUxTWC94a0libSsrbWhLMlVHU3I3bk5kRkZhVHdrKzdpeUFwcEJX?=
 =?utf-8?B?VjZsNEprOUhlanhuSFh0MEVqZEc4QlBMNFcvWkkrTjdXUHBCS01FdW1FUnBy?=
 =?utf-8?B?U0tFbTBpUUcya3c5S2VHZzA2dzBEZlVtNFF2UEgvR3FUZGluazNBUjRLbklC?=
 =?utf-8?B?eXVqTWFmZUE3VUh2MWszdlRYR25vVVd5UWxCTVFSY3dzQ0tsZ2YwdHVKMDVU?=
 =?utf-8?B?UlNubUV4WDBBZmlVK2xRL3Jpd2lzdFcyV0pBU1d3by9UVHFTY1dvZkxKNmNB?=
 =?utf-8?B?ZlJvZ0lkc0Y1Rk9EeDJkbFpSb2NpK1FrZmI2TFI0Y3VPdFR6VlJZOHI3T1FY?=
 =?utf-8?B?eDhKSmlpOWowaDdTcVRBYWhqZmtJdjF2blYzT3ZORU9rTkZkUDhhcmkvMmFy?=
 =?utf-8?B?MlNLTzZiaDZ4b3NPdGs4dFZnUi9yUXBlQUFaelNBa3MxM1luWWcrVmZVWm1J?=
 =?utf-8?B?bFk5U1lhL2x6L1hmTlJNQWNENkpZK0JWdmlVS1NDc2dKZEkrbjFRbEtFOVlm?=
 =?utf-8?B?c0tpeHAxc0t5RnlRN0hzNXRDeW1iY1JUT0lVNW4wdnd5NldvR2JrNkNxNUlK?=
 =?utf-8?B?U0hGM0VIZDJ4Y21oZnpwY3ZCS2REaU9od3ArOFhDM2F6NlpkTi95ZU9tdDFr?=
 =?utf-8?B?cGowSzJ5bTM4ZEJTR3J5d0w5WE5JVVY5SThJN2JIeklVeGRrZ3FtaUl3ZmN0?=
 =?utf-8?B?QUZjQVM4d00rWElSNHpsR3ExTm1BZHkxajh6N2dJU1pJSmtIMi8ralo0VUJH?=
 =?utf-8?B?empwdlN5SlZ6KzRBenoyTWpOdCtEQVpGd051YXU4S3JLNi9xQWdzS2dHU0JP?=
 =?utf-8?B?K2xVYndYSlhPeG55ZWkzWThwMllWMFBubmpUaXFDZkoyajJzV0FHZU9yaVF2?=
 =?utf-8?B?NGE4clVSbUx6ZFlyMlhRTWtvR0xueVFiSDQ3ZTFOU0Zuc2pSVThIUlMxRng0?=
 =?utf-8?B?aXpCOW05Y3FPeWVtWEErd0lodWNBTm0rd0tpMnZVdWZ6aUU5bWVsUGVyTHZ5?=
 =?utf-8?B?aXpIb3FsYU93SzBBWFJXc29ISHl2WW1lY2JBTFdvT0N4bS83R3YwZWJZem00?=
 =?utf-8?B?MGNhV3FlUGwvL0JtaEt4NHZzK1FIa2Nub0hpbzJZb2lCMit2NytTWWJjMkVq?=
 =?utf-8?B?TzJ0T0xEWE5tZU1LZVVyMmlNWmRPdjVFVU5DYUtrU0VvNVZITktrbnY0STFl?=
 =?utf-8?B?d3QxWXRDenJJR3RuSlhqaG9LQUlpeTdCZzNCZXp0WWgxNE0xY3gyajJ0ZTVB?=
 =?utf-8?B?Y2l2ZFgrNWhPNmZDQXNVbnUvSVpMeVdybytncHUwbmpVNklHdWVSclErSmhL?=
 =?utf-8?B?LzNsanRUejMyemZiMGNpNy9SaTR0OFl6UE1zVEd3eWtqQU9zc2xKYytZb0VC?=
 =?utf-8?B?TEw4ajhXMlJJUXlOeEVibkZReUtkVy9FSzF4bFc5VDBXUi9HTWdySEpnaklB?=
 =?utf-8?B?N0tUYU9HOWNQMTM3Z1JzNkJObEtLV01LTzZWWmlUUXBKdFdBSGRkZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95201f0-7112-45f6-22d0-08dee0c61a76
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB10770.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:04:18.9986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8829IJU6GUlUz/CdwBliXqVXQPl0NRMEWLJDknPMgZopvapEQPeJoQrJ/T+T/vUO7+mPR3u57SaeFKTDqEPGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7286
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

--------------V19Yxev0kQ0arPay0R3ys7EB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13-07-2026 15:29, Thomas Monjalon wrote:
> 13/07/2026 11:27, Hemant Agrawal:
>> Hi Thomas
>>                  We sent two different series for DPAA/NXP code:
>>
>>
>>    1.   net/dpaa: bug fixes for bus, net and fmlib drivershttps://patches.dpdk.org/project/dpdk/patch/20260619103901.2274740-2-hemant.agrawal@nxp.com/0
>>       *   This was originally accepted and added to next-net by Stephen
>>
>>
>>
>>    1.  DPAA bus/net/mempool/DMA driver fixes and improvementshttps://patches.dpdk.org/project/dpdk/patch/20260703124950.1895871-2-hemant.agrawal@nxp.com/
>>       *   You have recently commented on it, we need to make changes
>>
>> I am not sure how, but I now see that the first series for fixes has been dropped.  The series is marked as superseded.
> He had sent an email on June 25 explaining you need to rebase:
> https://mails.dpdk.org/archives/dev/2026-June/340944.html
It was my mix-up; I did read this mail. Somehow I thought it was for my 
new feature series, which was having merge conflict on master.
>> I have just sent v4 for the bug fix series.
>> https://patches.dpdk.org/project/dpdk/patch/20260713092616.2902828-2-hemant.agrawal@nxp.com/
>>
>> Will you please consider it for merge it again to 26.07 ?
> I don't want to take risks with new features and improvements in rc4.
> If I understand well, you are talking about the fixes you rebased?

I am only talking about the Fixes;  (which I just sent as v4).  
(net/dpaa: bug fixes for bus, net and fmlib drivers )

The feature series can wait for next release.  (DPAA bus/net/mempool/DMA 
driver fixes and improvements)

> It's a pity you missed the request 3 weeks ago.
>
Regards

Hemant

--------------V19Yxev0kQ0arPay0R3ys7EB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 13-07-2026 15:29, Thomas Monjalon
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:iSawvfAuRvCNNdxNcuk17g@monjalon.net">
      <pre wrap="" class="moz-quote-pre">13/07/2026 11:27, Hemant Agrawal:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hi Thomas
                We sent two different series for DPAA/NXP code:


  1.   net/dpaa: bug fixes for bus, net and fmlib drivers   <a class="moz-txt-link-freetext" href="https://patches.dpdk.org/project/dpdk/patch/20260619103901.2274740-2-hemant.agrawal@nxp.com/0">https://patches.dpdk.org/project/dpdk/patch/20260619103901.2274740-2-hemant.agrawal@nxp.com/0</a>
     *   This was originally accepted and added to next-net by Stephen



  1.  DPAA bus/net/mempool/DMA driver fixes and improvements   <a class="moz-txt-link-freetext" href="https://patches.dpdk.org/project/dpdk/patch/20260703124950.1895871-2-hemant.agrawal@nxp.com/">https://patches.dpdk.org/project/dpdk/patch/20260703124950.1895871-2-hemant.agrawal@nxp.com/</a>
     *   You have recently commented on it, we need to make changes

I am not sure how, but I now see that the first series for fixes has been dropped.  The series is marked as superseded.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
He had sent an email on June 25 explaining you need to rebase:
<a class="moz-txt-link-freetext" href="https://mails.dpdk.org/archives/dev/2026-June/340944.html">https://mails.dpdk.org/archives/dev/2026-June/340944.html</a>
</pre>
    </blockquote>
    It was my mix-up; I did read this mail. Somehow I thought it was for
    my new feature series, which was having merge conflict on master.&nbsp;
    <blockquote type="cite" cite="mid:iSawvfAuRvCNNdxNcuk17g@monjalon.net">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">I have just sent v4 for the bug fix series.
<a class="moz-txt-link-freetext" href="https://patches.dpdk.org/project/dpdk/patch/20260713092616.2902828-2-hemant.agrawal@nxp.com/">https://patches.dpdk.org/project/dpdk/patch/20260713092616.2902828-2-hemant.agrawal@nxp.com/</a>

Will you please consider it for merge it again to 26.07 ?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I don't want to take risks with new features and improvements in rc4.
If I understand well, you are talking about the fixes you rebased?</pre>
    </blockquote>
    <p>I am only talking about the Fixes;&nbsp; (which I just sent as v4).&nbsp; (<span style="white-space: pre-wrap">net/dpaa: bug fixes for bus, net and fmlib drivers )</span></p>
    <p>The feature series can wait for next release.&nbsp; (<span style="white-space: pre-wrap">DPAA bus/net/mempool/DMA driver fixes and improvements)</span></p>
    <blockquote type="cite" cite="mid:iSawvfAuRvCNNdxNcuk17g@monjalon.net">
      <pre wrap="" class="moz-quote-pre">
It's a pity you missed the request 3 weeks ago.

</pre>
    </blockquote>
    <p>Regards</p>
    <p>Hemant</p>
    <blockquote type="cite" cite="mid:iSawvfAuRvCNNdxNcuk17g@monjalon.net">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------V19Yxev0kQ0arPay0R3ys7EB--
