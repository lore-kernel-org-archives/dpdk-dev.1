Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63DAC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF6BB40E15;
	Thu, 20 Aug 2026 16:43:42 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013016.outbound.protection.outlook.com
 [52.101.83.16]) by mails.dpdk.org (Postfix) with ESMTP id 132C940DF8
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:43:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbT7fxqGuKJTLH5acI8IXydGEsfubXNIh3+ZiptDYj4JRE2iWk7U/2zLhmN9QSCKhaMGn3c70g7NzEI0OHaZ9BMBHlONquXYs/dJp4PketAWeDHCQPtDjNeyaJywRGE+FWqmd8C7rDJtSgjyKk3rWJPC3HlABtJywgJ7R2zZ4v8QhtAZvARRKiTZnoyGdPah9d3BaLqGWvk8AExw1IzHoOeGbjkBJ9KKQemjIPJf66Dl+EODRmsX7HL26S6v4r0rfT3kh8ymm66a4uV810VD9PUIVBpx0U7pLD2+lrUC7Ymf4B2qZYw61bZbY4+XkTEWREP2Y9BzahqMvZUH/NCR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5+FvbtVVUI8dgWotzZiWA2dhcCc+VtMg/c/EE2QZ90=;
 b=jP5Mc26eSwwesxE3qOOA9ltpzZgi+tKSn+KC13DRW6HfxoXMiT0/1IeBVvGWVTZj8AT9K67TibAhwXU8jc69A0FUtM7P9NU6NdQEb1g/AtAn+GTLHddTYWr48Igv7gj93cM3mHTGAGPGSGF3QXo0xu+2J68b+Z57dvya54ei9CB4zyA8Dypb+T7UhonAXbUNqRabOYIm8QIoSmxkZuJV1uGh8EuRTBoMq55bzhhY0OC6fEc8zKrmQiGKK+tSn9L+aNQfAzc/APpLEe4R2RrnWtMTCQoi/QYczO3BfaNqfUtUP6JNRyBnqRLdVxTw9GPaLW3pJU6bZKOOoH7OSnTsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5+FvbtVVUI8dgWotzZiWA2dhcCc+VtMg/c/EE2QZ90=;
 b=aeCLE8vmDoDM5dNo1bYvZHaC4btrj3KgxnNU+ODjSyVX0CW57MHaqiuf7TwYliIENU5/kssz9RxyLZ9gWJAoGrg8oWeQjC1QcbLmoyf90T6Px/C/YszkebOGvQk086WjCspgH+mqpJRSD2wOI/YG+stEVer5v83YE3kuiusjTipRFLa6vRPnWyN4cNp/CkIHONzs9TdnQMDpyO1Xb5FnsXy8eI95fPKGitJ27Y+6h7S9ezxHtFT88i6sXBSZB+ljMNzwbnm3mkISgyscn4sx1/rO2T+ndnuxkf2UVyk6k1uLp9851W5vvtQiVNc1jmPOuWshPdXpW+u6hxyJjDBGdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI2PR04MB10667.eurprd04.prod.outlook.com
 (2603:10a6:800:278::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 14:43:30 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:43:29 +0000
Content-Type: multipart/alternative;
 boundary="------------sQsMIfIQABKfpBp0j7Z38iO6"
Message-ID: <80063fe0-ccfb-4112-8f7f-444d452651ba@oss.nxp.com>
Date: Thu, 20 Aug 2026 20:13:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/25] NXP DPAA driver enhancements and fixes
To: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
References: <20260818111730.801760-1-hemant.agrawal@nxp.com>
 <20260819105004.2272880-1-hemant.agrawal@nxp.com>
 <20260819130835.17faad6c@phoenix.local>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260819130835.17faad6c@phoenix.local>
X-ClientProxiedBy: SI3PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::10) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|VI2PR04MB10667:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2df251-d245-4e08-b76c-08defec96667
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|4143699003|56012099006|10067099003|11063799006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Huf8aEyQ9jcy2ZsfjI9FNFdW3rwcGPXFZw6ua24yHSQH119O3LFm90uIQfwOa+6utzD/HNGNs5djOkwvfK5zhWtE8ruZ5e1YfH6BAR8LfUsdQ28cvwdrQ1SUjZ8njgWjDiTrhXwEPQtpQSf2pHYKh88BR3+e9SfuhsVTSOMlKuLxg7+aDCXGj/hinXB0kUHjWauQomeR69wf6tNwICy1VSoLZFZYxbiq9FeM5sdX4YeOAScHPUsKsbxUQWow9wXTrte2KcyyF1ikWgIfey8GgORAmqRtadeKdo4J43F1/hFngNEbhA03+A/RV/5Td2cSP+97GtvSW+KzdFvvjwgaJ3bYYA5TJMfAkc0jg/qFexw2ayWoCN6pRi0vBwjeRqeeKWkfpjV7yCNRqRA3+NOMJMEfkBqGVzp1eiNpFnsCd4cTvnqAdKeMNmq6gzDmDO4V4WzEWPZ2EUML00GNNtrQYCwoaUMXiPr0qmnrrGOg9J9ntof4mZtmKpJHMlpjM//+YSF9zy4Ea3EaiFf/Q3pdSjX8te3/pE6Zoz5mnqRQ1+uKO7h007alOWx5KmEj/deOe21O5xZ5YunGIy8ZogieHGqyx+z016Y9+9U/UiiNz3uhuxXzad9fYa4F+46NfiJmbZ2X13Gv62jjxWFyvSJn/KH0Z3nJfg7wcORMy1EwFBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(4143699003)(56012099006)(10067099003)(11063799006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWsxdm9MYWd3OE41OUhQRnpEOVhCbnZyTVV6VnlCZWtRbElQQ1FEK0J4ZGtZ?=
 =?utf-8?B?aS9zZS9EMzNtcWpyVlBiTWxNNVlvb0VRbUE5MzFINmdudWdCUklSdWNmeXUv?=
 =?utf-8?B?OEpzazdMUEQ1ZzJGb3NuRzgxQThDblN3RDdzKzVFT05nbXFINzY4VHlvZHlC?=
 =?utf-8?B?d09FWGhGdEFFdS9RamFzQ29UOWhMb2ZCeis1YlNrWThZZGF2U1ljMnQ0bjBN?=
 =?utf-8?B?Z3h1RVpFU1hxR2gvZ2NYeTU3eWRDSGNtQUw2ZjZNZ05EMy9yYmdlWUVxbnN6?=
 =?utf-8?B?RzZqT1RBSXFpTlQzWloxZWZZU1hscVpVa0M1cktHYitvZXlxMVpmaGdPSGpD?=
 =?utf-8?B?cUIwa0JxZ05MOXNGYldPMmpPL2xqL2Zxc3VHNWh0cUFWRE9MZ0ZITlRlQkVI?=
 =?utf-8?B?ZTNVTXdsYmRIQmdsU0VvMmsxTUkyOGlyNjRZVE8wNFl5T0lkQ1ZmRHRFOG42?=
 =?utf-8?B?T3VSejA3YzVpU1J2S0hLeEpxY1JlS1E2amNsRnFsTVdnZG1jRHZBNTlzaW93?=
 =?utf-8?B?MHBnUm5jV1VUakZneGFYREpKZ282OWpnVk9DWExXM0xvL2dxZXFQQ2hpdmhZ?=
 =?utf-8?B?czVxU0hnUzdFejRhNmR3RGh4OTUxOEtZaTVtZEthYzdmem0zcXhjeG1kbGQx?=
 =?utf-8?B?YXJyUWlIcXgzZU44LzB3RlRpcVpYMjk5anRlTXMyMjVmMUhuLzlscTNPWFZt?=
 =?utf-8?B?ZVBkcFNIWGhHWDNiUmlLOWlKM0VIdWY1TndETEYyUllZZGF1VDlaSXhzSGFo?=
 =?utf-8?B?QitqbHp1ekllMlgyV0QvaHpaQUFZL3puQ255RTF1YXEvWllmSkNvbWNpM29o?=
 =?utf-8?B?eGVVZE5IWndHT3NZQjVIRUhaS3d1ZjA3QnluSmNZZFJGMDV3cVUzSi9IUitO?=
 =?utf-8?B?dzFYb3BKTXBBRDBaZndWb0ZldVZvcmI2QjNabjdsRHV2UEF2R3dYb0w5STRQ?=
 =?utf-8?B?ZEJVRHd6OXBGczNmQWdRakdsZ3dBRmwrc1JqdTJLcnN3aXJ5N21DbnVseExZ?=
 =?utf-8?B?Y1lMS0hWUExFZ3dmQ2tIQ1RCbUZIRU9RektVMTRkbWhQdnp1VW80SEp1dmtw?=
 =?utf-8?B?a0MxeWpYUzhzRDllRWs5WEpabUlxbHpWTFRBNkdOZENtYnBKVzJucC9wVVp3?=
 =?utf-8?B?OTNRaVZ4ODBZN25KUGxZM2dJaG94WDlWT3Vjb2kwSEw5bGNxRExscDdITElM?=
 =?utf-8?B?V01sQklTcHhaZmJNVEFBbklRMkhHWDVWR0VmcWtwYmRyajNoc2pKSVRJQnhR?=
 =?utf-8?B?Y3F5SUkxSHYrTXBoVEFjd0QyRzk3OGkvRXR1N0lBeGE4TVJSQzY2MjdwcWly?=
 =?utf-8?B?RmRISFJYanRYaXJKZ3NjblZwdjhaRU5iL2J1WlI0OVZya1NFTzFUOEdZTzJS?=
 =?utf-8?B?T00ydldLT1RQZXZFS0tsbkVZQTFpc0FSVjlSa1k3dFR2eHJHYXAxaXQvUkt5?=
 =?utf-8?B?QitRSmMyOW5TZElSVG5aUCtxSWJXd3RYTjh3a1lGNHRlclpzeUVWOW9wK0F3?=
 =?utf-8?B?TStZZzhtV0NjelcxaUlEOGFsSHlRVDFINHlZRlZxd2llalRzYzNnYVhWRmpo?=
 =?utf-8?B?NkpSbDNjZXRDdVZLWUU1dE5ncXZuQVJ5SExTTzF2cWROWkl2eEhLcHNxWnA0?=
 =?utf-8?B?ODZEV1lVRkx0ZjVVdUp2R2VaNEpTYVZoUGw4MkxVWG5Ddkp2c3NUcldyMjdu?=
 =?utf-8?B?UTJaeUc2TVhsRHNla1RNd1RZczRGbWNNYVVwMEZxSXFlUGN3Zm9Fa2FYSVlo?=
 =?utf-8?B?V3Y3Uks0bFFwWVpxT3o2VWhkMVVPOHVFTnp5L1o4M3JiNFNmWG81REdWZWU5?=
 =?utf-8?B?TmxHR2xxSmpGUjRzNlI4ajNOTEFOeWU3aDFJdmFDdUh5K0xMcTlmUnlCU1NP?=
 =?utf-8?B?dFUycHVNT2YzSGtQM29IUTVsTG4wRlhYYnJ2QmUvWVFJWExOR2Nqa3Fudy81?=
 =?utf-8?B?VDdLSzlhcnJBZitURUFBVmpMcnJ0aW1ZODJvSis1R2E0b3E3MUUzQTZyUERC?=
 =?utf-8?B?TXVuN2lJcVB4OUNMUXhzSHFVWS9FbElVMW5CQUlQN1d0RldybElDK1N0NTFw?=
 =?utf-8?B?Q3BReFh3SEJhQk9PRVltUm1jZVE2b2RlUkRRVkVqdUgwekY1VStTWS9qY2h4?=
 =?utf-8?B?L0xuc2FneGxla2pMY1dYeFJya2JMQTB1TkJianVOQjRXVVE4VTVHNThSVzNt?=
 =?utf-8?B?cHdwLzdiZUhEV3NERGtBWjZzUlBOc09XOEQ0MUVFbzRxbXh3K2lGcjFkUjFy?=
 =?utf-8?B?U2k4YWw0b1FUVHErWGlzLzh1UkFPdkdITnRvb0NsWDMyQyswOEhqVTZiZmhN?=
 =?utf-8?B?eTdnbnZSa25KYldaSFVYUVg4bi9nNlMvQUxpelV1UmlHK1dnQUpXa0lTSy9o?=
 =?utf-8?Q?p/cFeK5Z9bgfQYs4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2df251-d245-4e08-b76c-08defec96667
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:43:29.8181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyixYxgWnccfyyBz4xDFFh51NNVg0tEYnqx28yhvKRUh9hD7h4rTHrEJxJUS64wWrsTMVCrfn0dgT7LswG3uHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10667
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

--------------sQsMIfIQABKfpBp0j7Z38iO6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 20-08-2026 01:38, Stephen Hemminger wrote:
> Summary of longish AI review..
>
> Still open
>
> Patch 15 — no response, and unchanged. getenv("DPAA_TX_TAILDROP_THRESHOLD") is still the fallback, and the RST is still a bullet list. This is the one item that got no reply at all, so it may just have been missed rather than rejected.

No plan to remove getenv for backward compatibility reasons.It is very 
helpful in field debug without the need to change customers application 
which generally embed DPDK devargs in the code. Documentation comment is 
fixed.

> Patch 19 — marked fixed, but only the commit message was. U48_BY_HI16_LO32() still shifts hi by 32 with no cast, and BIT_SIZE/MAX_U48/HI16_OF_U48/LO32_OF_U48 are still unprefixed in fsl_bman.h. The new message also says the macros were "dropped" when they were moved into the installed header.
This is common firmware code. No plan to change every macro with 
prefix.  However, the U48_BY_HI16_LO32 issue is fixed.
> Patch 22 — genuinely improved. MAX_NUM_PORTS/MAX_NUM_SUBNETS are prefixed (the collision that actually mattered) and dpaa_ip4_addr_s → dpaa_ip_addr_s. Still unprefixed in the installed header: struct ip_pair_s, struct lgw_subnet_s, and the DPA_ISC_* macros. I'd narrow the remaining ask to just those.
ip_pair_s and lgw_subnet_s are prefixed.  DPA_ISC is already a prefix; 
no need to add more.
> Patch 24 — unchanged in substance, and the contradiction is now sharper than in v12: patch 13 deliberately made dpaa_mpool_finish() the only place rte_dpaa_bpid_info is freed, so that function calls dpaax_enter_destructor() and then rte_free() on EAL memory a few lines later. dpaa_finish() does the same — latch, then dpaa_fm_term() and rte_dpaa_portal_fq_close().
Removing patch from the series
>
> Patch 25 — new inconsistency introduced by the patch 14 fix: the release note still says "Added NXP DPAA DMA scatter-gather support" and "Added scatter-gather (SG) batching... enabled by default", which is exactly the claim patch 14's message was corrected to drop.
fixed.
> Patch 16 (ORP) — on "NXP customer applications use it": qman_enqueue_multi_orp() is tagged __rte_internal, so it isn't reachable from an application at all; internal symbols are restricted to DPDK's own libs and drivers. If NXP customer code is calling it, either it's building in-tree (in which case that user should come with the patch) or the tag is wrong. Worth putting back to them as a question rather than a demand.
Removing the patch from the series
--------------sQsMIfIQABKfpBp0j7Z38iO6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 20-08-2026 01:38, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260819130835.17faad6c@phoenix.local">
      <pre class="moz-quote-pre" wrap="">Summary of longish AI review..

Still open

Patch 15 — no response, and unchanged. getenv(&quot;DPAA_TX_TAILDROP_THRESHOLD&quot;) is still the fallback, and the RST is still a bullet list. This is the one item that got no reply at all, so it may just have been missed rather than rejected.</pre>
    </blockquote>
    <p>No plan to remove getenv for backward compatibility reasons.It is
      very helpful in field debug without the need to change customers
      application which generally embed DPDK devargs in the code.&nbsp;
      Documentation comment is fixed.</p>
    <blockquote type="cite" cite="mid:20260819130835.17faad6c@phoenix.local">
      <pre class="moz-quote-pre" wrap="">Patch 19 — marked fixed, but only the commit message was. U48_BY_HI16_LO32() still shifts hi by 32 with no cast, and BIT_SIZE/MAX_U48/HI16_OF_U48/LO32_OF_U48 are still unprefixed in fsl_bman.h. The new message also says the macros were &quot;dropped&quot; when they were moved into the installed header.</pre>
    </blockquote>
    This is common firmware code. No plan to change every macro with
    prefix.&nbsp; However, the&nbsp;<span style="white-space: pre-wrap">U48_BY_HI16_LO32</span>&nbsp;issue
    is fixed.&nbsp;
    <blockquote type="cite" cite="mid:20260819130835.17faad6c@phoenix.local">
      <pre class="moz-quote-pre" wrap="">
Patch 22 — genuinely improved. MAX_NUM_PORTS/MAX_NUM_SUBNETS are prefixed (the collision that actually mattered) and dpaa_ip4_addr_s → dpaa_ip_addr_s. Still unprefixed in the installed header: struct ip_pair_s, struct lgw_subnet_s, and the DPA_ISC_* macros. I'd narrow the remaining ask to just those.</pre>
    </blockquote>
    ip_pair_s and lgw_subnet_s are prefixed.&nbsp; DPA_ISC is already a
    prefix; no need to add more.
    <blockquote type="cite" cite="mid:20260819130835.17faad6c@phoenix.local">
      <pre class="moz-quote-pre" wrap="">
Patch 24 — unchanged in substance, and the contradiction is now sharper than in v12: patch 13 deliberately made dpaa_mpool_finish() the only place rte_dpaa_bpid_info is freed, so that function calls dpaax_enter_destructor() and then rte_free() on EAL memory a few lines later. dpaa_finish() does the same — latch, then dpaa_fm_term() and rte_dpaa_portal_fq_close().</pre>
    </blockquote>
    Removing patch from the series
    <blockquote type="cite" cite="mid:20260819130835.17faad6c@phoenix.local">
      <pre class="moz-quote-pre" wrap="">

Patch 25 — new inconsistency introduced by the patch 14 fix: the release note still says &quot;Added NXP DPAA DMA scatter-gather support&quot; and &quot;Added scatter-gather (SG) batching... enabled by default&quot;, which is exactly the claim patch 14's message was corrected to drop.
</pre>
    </blockquote>
    fixed.
    <blockquote type="cite" cite="mid:20260819130835.17faad6c@phoenix.local">
      <pre class="moz-quote-pre" wrap="">
Patch 16 (ORP) — on &quot;NXP customer applications use it&quot;: qman_enqueue_multi_orp() is tagged __rte_internal, so it isn't reachable from an application at all; internal symbols are restricted to DPDK's own libs and drivers. If NXP customer code is calling it, either it's building in-tree (in which case that user should come with the patch) or the tag is wrong. Worth putting back to them as a question rather than a demand.</pre>
    </blockquote>
    Removing the patch from the series
  </body>
</html>

--------------sQsMIfIQABKfpBp0j7Z38iO6--
