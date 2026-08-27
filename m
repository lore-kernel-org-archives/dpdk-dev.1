Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50886C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E7024027D;
	Thu, 27 Aug 2026 17:55:36 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013037.outbound.protection.outlook.com
 [40.107.162.37])
 by mails.dpdk.org (Postfix) with ESMTP id DDCCD40150;
 Thu, 27 Aug 2026 17:55:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY0nJ/2ewGLRrjkNXX4LDB4B/Lk4sTlMOl3T1sC0lPG98QMNPOi0YyiVkjIjC4qZjmfRx1e1Sbwatlk4hxD6dTFm/J1yhRleDrhFu9/eeKM/Zoi7czoWrugK1Zh7PUdVtr0HCuwnAUOL6oCg+xsKCvWg8HYvp4+vYabxyKVVvjd5M2O3gyBZUf8Otgfaimk0s2KCbGaPBTHwIa8JPLsHIL1NRRR1P+tOZKviPTr9JJ6mgNNiaUcrSw1zUYGzag/zTBgIsRl27mv9DoJ87S/PfpyAjX/DS9Mb5kyGoU9yftPx2mRBLCxGmeRQdGJ8jqVxNT2SWr+SoJwz9+bAG5R6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdJ2hmXRKifi2H+GwhOP0FqOCtaE/1B5AYWbwis9BfQ=;
 b=ypw4cFpeE+Q+woFLZ3Ka9okZxMWDudbtOSoC1aa40ytaGOzJnGF33DnhcpuSOtts5vy5/tapV1pM3csV1UC3GpXoAxfyc8VaI+Lg2fwLLeToXtJEiNKJJdOwuJCNRGi3mrYnyQAlWw1XXh/wXpVPawOd1f11Rb5DB0Xm4Dk/Qn12dMvNsLj/DEnNfVJDk0FXra42O0C8gL0jj2w583W4aJf5IzHKUhhZmm+zKoDqu3PLfCMkXmGMbEIwBWqlGz8sSI8IDQYYuOiQbb5kKxzHrKNni3mVaWTdLstuqQ9a7lrwKflpump1LBxMPqHTR+VlAh8TRbWMoLJIb/v5fYPD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdJ2hmXRKifi2H+GwhOP0FqOCtaE/1B5AYWbwis9BfQ=;
 b=Q/DAGMFClowiDTl1v+i5iM3GfIIhddGU4aqhiT6awtTaJ0ywvysmo9WynylChK2JaMQkYUFdGoDJMtH5JDHdfDhTcPKjDBxM2cDbF1s87V8Cfw1EKRyh03YR3h0MQfgLGD7BmOT0NU8aAL/XJ3nRwyp2LtDmCOWIvXBqWX2kkXcm3KKEqwkFecp4RaOhRyGJDBhZRpwjjoIlPCc9qLEWakeyuEk1PpJtmZwrDrDFx2ioXdDDUWH4VmXXi4raM1pqFUadSEWoBH2jSSkJuBu+LvsPHF+Ezig2ElU1Gy4plnY8S4lakK8V2fGRFWvmxjmkdLXiXby3xdX4eTkGKl/6dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:55:29 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 15:55:29 +0000
Content-Type: multipart/alternative;
 boundary="------------QEgjLwXxSYXBLkH4UbmwlR2v"
Message-ID: <690d2c85-b716-4400-aeb2-8f2fb3dec266@oss.nxp.com>
Date: Thu, 27 Aug 2026 21:25:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] common/dpaax: fix unused variable warning in
 non-debug build
To: Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260826235933.194681-2-stephen@networkplumber.org>
 <CAJFAV8x62b_zeyF5P-X4KSMxaD4Sd=XanED-7PitDztxtnUFFw@mail.gmail.com>
 <20260827075721.1344582e@phoenix.local>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260827075721.1344582e@phoenix.local>
X-ClientProxiedBy: SI3PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::15) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM8PR04MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd8dbf1-0817-4f25-e528-08df04539e55
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|1800799024|376014|10067099003|8096899003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 4NIQIb+RGlBzs5hmhJ3ojkKZX0JF/BW4I6k7cUDyrzMIlTY73ObJVw0aG9LgKF3toqzKojlfpN0DM9JKsLhParixtDIyk+cSozYLmHq/mxWH7pG8azKAhZ9u5I41XX88q1YmknLWsb2i9iKCSq94ds4E0whMOcYwLbGJo+2cLqdhJp9q1vwE0YiOZTqp5Bb1GzCCaSBUVLqH3+bbG2TDchSFIphrEmvD4b/ypORKm44Nn2hk0SDN6spJ2OILxayAnurxDJ8VdGaLQnUEk1m4+Q58nx3IlvVMQ63fCESTHBawWcbRSPsKDP3UYpU4K9cGGXDEt00BIIUr9/nyiSdhzXrEl+KYpqGgmm6OOvbw9r9Gf5/WB9ND6OI8d0IYiwTr4P3YlKBNxFEYSpCNdKcD265nfSG7IrU9hGHcEKXLvCLMLZ2dsM0agCbr8YotOyPDoHtc4Ive4Ap7Ux22JkdL7JIEJTiTJkfJXZW1SsVCjwkZR+gFdxvEhaPutDh0Sus4mUQR0YaBl4hMBHv1jgNyeGrYqJlNZl1jd/opNGDRnrmULA1rGy8F+6zDE7MqWrTnVHitIHdzfGyqknf6buu8UtqVsG41/JX8cocv5vlno0vhp4BYNiBKn/4bsnYKd5FNlwKacGRNV3omX9ZWlccaEtrR8+VZKbLg0ClNUh8VnCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(10067099003)(8096899003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDZYeWhUREZsS1l4MzQrUTYzWmNHYTdCR2ZaR1ZDSWFiUjdKZ0RnQWRtSTVs?=
 =?utf-8?B?WFl0YmQrTW4rSUNwMTBqU3RKc0xPZ0tsdFJibmNnQ2dXWkM5YWc0V20yQlYy?=
 =?utf-8?B?L2ZwZC9QWXpnbU9yR3piN3UrbllUZUdPakNQVGJRNTE4M3VjR2VicDQyNG43?=
 =?utf-8?B?aHZMT3oyMUovQm1WWWJqSWJpam42aU1DOGJaeUJQMmNyQUZ5RDJKSHNxRVJD?=
 =?utf-8?B?cW9CTHNkTmFnVmhyNnhIZWhMaFQ2Ny94eENMRTZqZjhkeDUrMkVYdmt5eW9Z?=
 =?utf-8?B?dzM5Y2FJRWduQkRFS2gzWUxiUDlSY0p2TzlRMDdsR2d0MWk4dEFYQ3ZoczdV?=
 =?utf-8?B?WG90ZnBOTkJDS3Rvc2pWaDhlekFxV3NtTmswYVFTNWlRVUNrVE5yamR5SWFQ?=
 =?utf-8?B?SVNla1RDYjBEYjRTbExzU1pHV3ZVQnlQb2RxRTZtRkxJVEhzU25hbTRpT0NT?=
 =?utf-8?B?Qm9abHdpL1RZV2M3TytrS0xSc0l3QUY2cjdOaGhWVHNBRWFWVkQ0VmlPd2p5?=
 =?utf-8?B?THlFd3NuSTUvZThNMTM5aHNGMVdWcDQ0YUZ1R2Q2YmZMcHZnUml5ZXN1ckRR?=
 =?utf-8?B?RVFvaXhqWGFNaUxZZ0FNWTUxdXF0eDQxMWZDd0IrUWlDVjZrcmlBUUxWTjdq?=
 =?utf-8?B?VkNLREdXMjV1SmJwNzBrVTFYM01lbnFabVNXUGxsb0tEdUlzc3NmQnhJdFR0?=
 =?utf-8?B?YUVYWS9zNHhnd1FqSDZBT0s5b0lYaDZUbXB3cXlNcEgxaVp3OUpYNnBpVm9h?=
 =?utf-8?B?b2hiZlFXTTdzang5aVA0R0JGWW9CRHhlQmowSk9lL1NWalZtNU5yOU9HT09Z?=
 =?utf-8?B?MFovSTNTSTlUeFdFUk9HRGh4b0p5SiswZ2ZqQ2RhWXlpa3A0L3dVY2FzaEVV?=
 =?utf-8?B?c0NjM0R2dERTYWl3UlBGeERUdGhFcXdML2ZMZ2JLalE0ZXc5MHNHODlHVlIy?=
 =?utf-8?B?c0k5dnlhZ1NodzFiVjZ4Wlc3Q3RzNnZ3RS8zUTVMNG5yMW8rRFFnMzhFbU05?=
 =?utf-8?B?NE1PbEFpY3dqRFpuaFk2YXlReGJiMzh2azU5RWZ1ZjVIVkdJQ056L1c5eW51?=
 =?utf-8?B?aTBkNEJCNllHMFVVUmFtMklRUThTQ3FaeElrYTZocWZJQ3JaZWdRL01xVGc5?=
 =?utf-8?B?dGpoUWJxMm11d0t3eXltR1RSV2hwODIyS2dqL21KQnhLV1l1SUlIQ3htZFk2?=
 =?utf-8?B?K3o3d3FOSkxLRWYzRGxDWFlqZUNWL2QrWklGZm5NSk9scGt1WTUrVUFzNHR6?=
 =?utf-8?B?bVlsb1lhK0NlbDJkMlRGVlBGZlROeXhqV0NiQlVNR2E1T2FrTmVOR2MzSHhT?=
 =?utf-8?B?RlFlRldzREVOMDRtcloyTkdGWHJBSUJNajA4SVhvWW1yT3R2WmkzRzZla3hK?=
 =?utf-8?B?MnZYbW1rM3F2UTRobG1IbW0xQ0N1QnpYZ1Uvd09JYmhab245MFB2RVlrdktV?=
 =?utf-8?B?dy8wY1RON0tkUmxXZ0svK25sZTdSZ3RQSVRIaWk0bkVha1BzL0pPamJxdUR2?=
 =?utf-8?B?QmMvbHE0eG54MEJnNFpXM09CTnI0UHFJUnRPRnJCUUxmb1llaU9VRU1abG1W?=
 =?utf-8?B?Q0J0R1hWZG1tRjdsV2NpVk9DemFxOWFodFhmb2FGUllyN29BaXBIcG9sdW9V?=
 =?utf-8?B?bTB6YmtEVEhyeDVtR0xSZk0vTFh1SkhFRXc4a3RFT1BDeFZkUW8zMzljU3U2?=
 =?utf-8?B?WXhxdU42YlJPN0E1VmdEWmlmTi9UV2lZeXpCcWVMZkEyMlZBT3JDbktaY0hV?=
 =?utf-8?B?SFd6N1BFWTdrMjRWSnNGRmpBaWV0MzZGRWtvT1pSZFRFZ1E0NjIzQktZenY0?=
 =?utf-8?B?Nm9VekhlTGpXTUdBV01OVTFxRmR4Z3JBV1BGTW1ZQThBckJxWEk3UjhablA4?=
 =?utf-8?B?RW1wMm9Da3pucDFnektYNXVDdHNkaWpQQkFDUVhrN2dCLzdEM2xKK1pwMThQ?=
 =?utf-8?B?VDhLTlZUa2hNcHhHVWVpVFdqTlBkTnZuN3l3Y3ZXamx6YVM1OGh6L0dHcmli?=
 =?utf-8?B?N0IwcTB4VVBPLzhhNm1vaUo5d3RCelZ3dERBdmg1N1RqQ0ZWUjFGR3k5VEpB?=
 =?utf-8?B?WWpPUXVBWWZVWTZRUEtTV0R3WjcrajRYU29TUjZqUFRkQzRqTFUvYXlkVmhh?=
 =?utf-8?B?R1BZWmc2VXM0YjBESGZHSGV3SVJHcldsSU1HTW1UdzdLSU1pUWh3RHFYU2NG?=
 =?utf-8?B?S2tOMlNZNXRHZDE0VXBudEVOOFQ0QjFoTUMwMGRlUlovellBeXZiNVdVcUlO?=
 =?utf-8?B?MkY5RU8zeXdUNThCL1pqaGJGN0RZS1I4YVdYL1k0WFZyUFFyL3BkUG9vdnhM?=
 =?utf-8?B?SDZkT0NPOUNVcUNPaUI3Y2JsUXhoRGd3RStpTXNTN1IyVWZuK214b3BEd001?=
 =?utf-8?Q?f+NKq76zJcZd4HgM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd8dbf1-0817-4f25-e528-08df04539e55
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:55:29.7361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqKmTCKaForLnPjRU3Mrl9fnEkZ4Fb3/ZubGXmmylwdeLdcasO9aEC9CRoDxOBt46dLv1d7Z7yyMyMEpJNKKQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7779
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

--------------QEgjLwXxSYXBLkH4UbmwlR2v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27-08-2026 20:27, Stephen Hemminger wrote:
> On Thu, 27 Aug 2026 11:07:50 +0200
> David Marchand<david.marchand@redhat.com> wrote:
>
>> On Thu, 27 Aug 2026 at 02:00, Stephen Hemminger
>> <stephen@networkplumber.org> wrote:
>>> Fix compiler warning on clang-23.
>>>
>>>    dpaa_of.c:14:12: warning: variable 'alive' set but not used
>>>          [-Wunused-but-set-global]
>>>
>>> The 'alive' flag is only read by DPAAX_HWWARN, which expands to an empty
>>> statement and discards its condition unless RTE_LIBRTE_DPAAX_DEBUG is
>>> defined. Make the empty expansion consume its argument so the condition
>>> is still checked in a non-debug build.
>>>
>>> Fixes: 8c83f28cc8a4 ("common/dpaax: move OF library from DPAA bus")
>> Not that important, the issue probably predates this commit.
>> And looking at this change, it seems DPAA_BUS_HWWARN is dead code since then.
> That is when the device-tree warning was added.
> The history scan looks right.
>
> It seems like it should either be removed as irrelevant or made into
> a regular warning. But that is up to Hemant and Sachin to decide;
> I just want clean builds for now.We need to remove this define.
We will plan to remove this definition in future.

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

--------------QEgjLwXxSYXBLkH4UbmwlR2v
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27-08-2026 20:27, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260827075721.1344582e@phoenix.local">
      <pre wrap="" class="moz-quote-pre">On Thu, 27 Aug 2026 11:07:50 +0200
David Marchand <a class="moz-txt-link-rfc2396E" href="mailto:david.marchand@redhat.com">&lt;david.marchand@redhat.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On Thu, 27 Aug 2026 at 02:00, Stephen Hemminger
<a class="moz-txt-link-rfc2396E" href="mailto:stephen@networkplumber.org">&lt;stephen@networkplumber.org&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Fix compiler warning on clang-23.

  dpaa_of.c:14:12: warning: variable 'alive' set but not used
        [-Wunused-but-set-global]

The 'alive' flag is only read by DPAAX_HWWARN, which expands to an empty
statement and discards its condition unless RTE_LIBRTE_DPAAX_DEBUG is
defined. Make the empty expansion consume its argument so the condition
is still checked in a non-debug build.

Fixes: 8c83f28cc8a4 (&quot;common/dpaax: move OF library from DPAA bus&quot;)  
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Not that important, the issue probably predates this commit.
And looking at this change, it seems DPAA_BUS_HWWARN is dead code since then.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That is when the device-tree warning was added.
The history scan looks right.

It seems like it should either be removed as irrelevant or made into
a regular warning. But that is up to Hemant and Sachin to decide;
I just want clean builds for now.<span style="white-space: normal">We need to remove this define.&nbsp;</span></pre>
    </blockquote>
    We will plan to remove this definition in future.
    <p>Acked-by: Hemant Agrawal <a class="moz-txt-link-rfc2396E" href="mailto:hemant.agrawal@nxp.com">&lt;hemant.agrawal@nxp.com&gt;</a><br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:20260827075721.1344582e@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------QEgjLwXxSYXBLkH4UbmwlR2v--
