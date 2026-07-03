Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D16C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 17:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C024E40A6B;
	Fri,  3 Jul 2026 19:21:19 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
 by mails.dpdk.org (Postfix) with ESMTP id 7CF3940A4B
 for <dev@dpdk.org>; Fri,  3 Jul 2026 19:21:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHhUD92mHU0GdkWdKIWJgYMn8UmkOM/Ibn82KxUITXpj9jMxdVMeQmJC7sd8uHXV3ZLxn6wSHcUN2urOb+pJzUjtBDRvvc/QR7GDe7LPVL1OXK8LdvNNDZdODl60GJhe9hMgVC7jAU2OTfG7AD1h4Oc7hkrY4m9yznFKeV+5SBOMChj/wy24CHFBs/SYQCEDJFyRXpNL6f5we0rspiBJmx8uab38Whg73dTl2z99Kw+7ejaS5ppXq0tXIrlwfW79qYzrA/UnsGDkI7sSdMPRtue3gKIYDIeNVfq5gsJkMG1DtSkUjSGMH3e2MqyNUuaHKaPq2NjULGELQmiuVgJf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RPzjzymEdaYbO0I3Gl5ehkvsRyH8tpY5U7FQFsgvik=;
 b=Kn6mLabUxH44KgSa7FibIrk4wPYk+DUNSiwuEjs5axm+FoVtcEx+fFW8Oj0I7/nEgbqi66xDxSh/dlQMZRIqrz/YFCBFI/wogFfu9Fz9rmVZMPzAOUoqzDEHqxVD/x6Ajev1s12hnhhkbpny/LgXtIGVEQv7cvwKI5mniKPGLyMZqSY6ytudhZ6WpPJW5hAMRIy09svsvsIUFWGW2JaSIzPHJrbLFT9FnuYuHvPIUOfnq+7/VVMEJmKMpXXXP3EN9Aft8VlUNNZ6HxboNniXqCm4hLSCqTEw0eFau5KzLNo/kA1ASUWBbHYchTVK44Yfv6VctA9IsB4M6eGpsKlsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RPzjzymEdaYbO0I3Gl5ehkvsRyH8tpY5U7FQFsgvik=;
 b=Fa1TR5OInsQ2xJomBbRmXK00NLnXwMmfyqhWXiRzUvTnY/f7S5yCQ3mr6AQUpVxs4uylxYReqq3qHpV1TxsrTM2WFlFAK0U0yXuuViq7KdNYAoh3mhz8A2g1j2UHe5nnzGFRpkk7rKs6hkIX052v2sXgwTMzFvGoyQ42INuyR3y3MXXS7AaGKQn8JuQuDAmuA5yRPQp27oweC+bcgJVWmrxHJqHDvgMPKlPRmiZ8Hy/dPEjr2QMgSkCYt7VDy5zKpOy3JWeVACh5vd1NSr9jBRCium0oUxyiCGeLm3sviPZbl5Ymnx1cz5oeY/6xb6xTOX+L5Il/dQU0VW1sp6HALA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI2PR04MB10857.eurprd04.prod.outlook.com
 (2603:10a6:800:271::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 17:21:16 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 17:21:16 +0000
Content-Type: multipart/alternative;
 boundary="------------B2xu2FJYWIaTsopxVQ9c5WcX"
Message-ID: <19dd309f-a2c7-4ccc-9067-e8116239bcb7@oss.nxp.com>
Date: Fri, 3 Jul 2026 22:51:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] event/dpaa2: disable channel before closing it
To: Maxime Leroy <maxime@leroys.fr>, dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, david.marchand@redhat.com
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
 <20260630144329.457643-2-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260630144329.457643-2-maxime@leroys.fr>
X-ClientProxiedBy: MA5P287CA0301.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::15) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|VI2PR04MB10857:EE_
X-MS-Office365-Filtering-Correlation-Id: e64d0873-0489-4c65-51ff-08ded9277d7b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|23010399003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: Z0/lQgBkNNl0JXUnkumb71tRwgjdoW0mj+13uC0UTfiJnpc9P1eBzzhVmkcyIg3jHtxlBVj7uazsd7oyb9l6E3bP6z6iJ0oGQzzX2F94ghJ81/2YnL84JQvx//zIkePrtQwb3X4k6MI/jLgpjz9h+sA6uKcNB7yhX54Jf1wPnd6LBW3TYQBu1H/OV1C9a3pzx2s/sa5KNaTOwJQKsE4uw05YjCinCGgEZ/3y3fh2Znv4JUpesUvQVztG/AgGXOXOooDd0EOnu26Fg3pH93mlKkgmV7xPfQh3XDtqZ3B435zQhlqFIsVK1hIJV1J9XqaAmImpHyvTVVNwfKfi/BON6LuHwu4rQM05/TfilB7ZVV5qi4sjyXDLqeJN07C8Ko0JQGeWXcltewqpozFcTQJGrTesgqrpfpSXWTM2NTqbQMM4cf3MJe/mU1I53FpNxC7OaZDsUFs38oB5qTSs6ASJLazwWuWr3M1JBYC6kYAnpz4jvYVYgu92RSj+mIIKo6/023c1f5bP/bOYzwiw3lxQDWTbiwpwLb6o86DlXToVzm1R+muLKwE0jORsKXT9rOuC//iZ2lqkphrl+sQugrZ1u7S47JMfrUCBvzAJ5gtCOgDymKj1qaNpeY4VnGkyOvAkym3g8UcsfPQFKR/YAWwdiLT6jhNC6AAOXh3Ho8RPVSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtoSWp1V1JweDQ5YzdWYW00MEFHM2lRMnJnQTZtS29JaEo2YmkrMXNNbHZi?=
 =?utf-8?B?KzQ5bjFjaG9CRXhvOWlUMTVYK3ZJV09TZThPL1dUZzZWRExURVREWlY1b1I0?=
 =?utf-8?B?WG4xVGQyVjRFOW9jVXVOdHpYelNBSHRpMFF4VWR3REJLa2FJTG5ZbEpnNmtw?=
 =?utf-8?B?MkRsMGUrY2ZoNUhBN080UDVmMll1cU84T3gxbWlSTXJMK0t2NUlpbEFFc1pO?=
 =?utf-8?B?L25Sd2VYbUZqMTN6MnlydjhpcnFRZmh1T2pCa0FJOTZOdHNtcTE3aHpYYXdM?=
 =?utf-8?B?eDF2Yk9lMGxSemU0UktxazFiclRxOVBoM3Vpd1ZUL1RpMzdJb3pPNGJnRW56?=
 =?utf-8?B?MEVVaU9rNjk2eDc4VUNGbDg3T0V5M1JuVjVoMG9LQWR5YXBPTXBtMFMzUXFL?=
 =?utf-8?B?SXVqZlUrdWdUaXdiRnRDdFRGMklXd3o1alp6YkFwVXhwNjhCcW9iZEp1VkVa?=
 =?utf-8?B?b05jSVRVbG91Q080VUpsZ1dvR1lEcnBCdVFoemtJcGNpU2JROFNYbDBEWGcz?=
 =?utf-8?B?NWxKaTJrRTlhdXJuTXlEanQ4cmpWS2VZZDFYd1AxLzFSSlRyWnFiK29oQTJI?=
 =?utf-8?B?SUhHZjNDTDZ6WThMa1JQMmpCaUZDTVdpUkthR2wxOEJROUxwcjhRTDFneWR5?=
 =?utf-8?B?aFk3bVpPbFVuemNUOVFmVDZZZFpvWVIrTnY2dGc1N1FIalJVVzRlYm12VmFV?=
 =?utf-8?B?ZzFMMkxaYnlISVpyTmhkYVNaWGlmd21JZWlIRjlCOEVvRnpLejN4N3A3OFYv?=
 =?utf-8?B?ejZqVzZIbnZxdVVwRTdCelV5TXRFRklIcXUzbVZXZnFhRGdZckNuWEcvOXlu?=
 =?utf-8?B?bWJVUHZiNzBEQlVDcU1GNG0wSERucGc0VUQxaGtiSVNhU3lVbk9VQ05HSDYx?=
 =?utf-8?B?VGlLOWlnMWZEVkJCUmdwZ0VSZi8zUU1kQ3pGbjU3T08ydDhUb3hzSEc5MU9m?=
 =?utf-8?B?dFR0dlFhdXlpTlh6SW9idndJUEt6MzhCT3pEUWhNbUV6a3RtaEdwVUdqL29V?=
 =?utf-8?B?VTNyNXVnUFFxbGQyWVRRMTlYbHdVSXNIeCtVV25XU2pxRFVrSjlXWEpyeExs?=
 =?utf-8?B?dDNGc1U2UFQyeThyTmIrN3c2SEVmQWorSGk2UldxV2dvLytRYnZzbjdHdmZq?=
 =?utf-8?B?MldlWDZJYXJKanIvUHp4a3FybmM2OUlEYitvS2FlRzVuZ2VQTE1UOHE1bkk4?=
 =?utf-8?B?eUtLQmx6VURmeWV2bHpIWjNaZStrYUs3ZmdCSkhYeGhOajd2cnZxNUxGVTZt?=
 =?utf-8?B?QWhvYXJsNy9SNVFLSEJCK1ZOd2pHYlZLMTJjUVFnNVFDeDlMVXNRWXZuSk1O?=
 =?utf-8?B?WGU0a3dXbEdvS1FJeThIZnF0ZTBLdWJGcXU2VWZldVp3RFRzRm95ZGxHZ3BN?=
 =?utf-8?B?Vy9PL3VDbDlHRDZtWXc5cjAzajh4OG5Md2lrKzczWWhlaVZTYTdoWVZ4emVY?=
 =?utf-8?B?WGJicUJSekZoZW5PT1ZXM3RDNWRqQUR4VHdlczFkalc0aWdCVW1FNXQyNHhM?=
 =?utf-8?B?MjFxeXIvM01QeWlRMnczSWhobGJ0dTlMdVM5OEYySlB4a3h2MjY0cHZLVTN6?=
 =?utf-8?B?akY1S2xOVkZWc3lnOWRPQkRhWE5aMU5ub3JPOUJDUEd2MUMyZ25MNzJqeGlx?=
 =?utf-8?B?Tmk3bzNwK1FwWGhQbVEyZEVBRitkczVNQVlJdFZvR05vMFBwTlFpN0ZodEZI?=
 =?utf-8?B?TjRjT0FJeTRiZWk2b21aVHFlYzI5VjdVVVQzSTNZcmkvaTR1OFRVYS9rMFBJ?=
 =?utf-8?B?TTJadEhXOVRNbGgxc2RUMWNpWGpUN3FOMkRNeEtOMjBPVU9zVXNEUk54dXE5?=
 =?utf-8?B?cXF0RktERVRrVHFoTjFFVzFHOGdKSmhSRkR0UkN2cDRkSkZhaC8wcTNaK3FX?=
 =?utf-8?B?S01CWmtPRXdvdWdOK1RHR1FmNlVKVXU0bkYwUUZCR1pxUDUrdjViNHdTUEhL?=
 =?utf-8?B?MzBYaXJvNU1ONENUZ1l6L0pIaGFuV1BtdERXdnA5REhZcEpRZ1lyenhBaXhG?=
 =?utf-8?B?YWtXOFdaNFpFUFpMbVE2MG04UWVWbWRPeDdIZWZ0OVplZUJQWXE5a1UzN0dU?=
 =?utf-8?B?TnN3ZlFtb2NUVGcwT2FsMktGdmJkZ3EwUW9pcXViQ0FHVXQ5MXRqQXVUZk9p?=
 =?utf-8?B?Zm5LYkZES3pJbnhzZFR5S21lblBuYitwMmk4LzJmMXFjZnJyRUFVMVVtWFV1?=
 =?utf-8?B?TldUNSthaDBxTmdlM0tJaFpZRzJhcVRIQ1hiNFZ0Y1ZzVkVibWVMdEo4TWhW?=
 =?utf-8?B?dU02SnprT2wwQ0h4dWc4cEtvYWdVT3JPNkQzdW5QaHBKaW1vNTVtaUtjTVVC?=
 =?utf-8?B?NCtyVlhGZERPdXRxT2FLdmNBcCs1aFNZNXcyKzlReUNtVkQ5WFlLalJlQjZj?=
 =?utf-8?Q?88IDdNayxxRmhvBM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64d0873-0489-4c65-51ff-08ded9277d7b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 17:21:16.6488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEzeukqunCdKR+EZnXWIRuK7igOEncO1iAdtRZzxmwQUDYR75sC/gXDxuDHOeRxLjTPbB891vsOMni4AVG4VQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10857
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

--------------B2xu2FJYWIaTsopxVQ9c5WcX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30-06-2026 20:13, Maxime Leroy wrote:
> rte_dpaa2_close_dpcon_device() called dpcon_close() but not
> dpcon_disable(). close only releases the MC control session; it does not
> disable the channel. Cosmetic: an idle DPCON generates nothing and every
> consumer reprograms on setup, so disable before close only to return the
> channel clean, as the symmetric counterpart of the dpcon_enable() done on
> setup.
>
> Signed-off-by: Maxime Leroy<maxime@leroys.fr>
> ---
>   drivers/event/dpaa2/dpaa2_hw_dpcon.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/event/dpaa2/dpaa2_hw_dpcon.c b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
> index ea5b0d4b85..f65a63a786 100644
> --- a/drivers/event/dpaa2/dpaa2_hw_dpcon.c
> +++ b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
> @@ -128,6 +128,7 @@ rte_dpaa2_close_dpcon_device(int object_id)
>   
>   	if (dpcon_dev) {
>   		rte_dpaa2_free_dpcon_dev(dpcon_dev);
> +		dpcon_disable(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
>   		dpcon_close(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
>   		TAILQ_REMOVE(&dpcon_dev_list, dpcon_dev, next);
>   		rte_free(dpcon_dev);

The ordering here is wrong. |rte_dpaa2_free_dpcon_dev(dpcon_dev)| is 
called *before* |dpcon_disable()|. Once the device is returned to the 
shared pool via |rte_dpaa2_free_dpcon_dev()|, another thread can 
immediately re-allocate the same |dpcon_dev| pointer. The subsequent 
|dpcon_disable()| call would then quiesce a channel already in active 
use by the new owner — a use-after-free on the pool object.

The correct teardown sequence must be:

 1. dpcon_disable() — quiesce the hardware channel
 2. dpcon_close() — release the MC control session
 3. rte_dpaa2_free_dpcon_dev() — return to pool

Please reorder accordingly:

dpcon_disable(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);

dpcon_close(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);

  TAILQ_REMOVE(&dpcon_dev_list, dpcon_dev, next);

  rte_dpaa2_free_dpcon_dev(dpcon_dev);

  rte_free(dpcon_dev);



--------------B2xu2FJYWIaTsopxVQ9c5WcX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30-06-2026 20:13, Maxime Leroy
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260630144329.457643-2-maxime@leroys.fr">
      <pre wrap="" class="moz-quote-pre">rte_dpaa2_close_dpcon_device() called dpcon_close() but not
dpcon_disable(). close only releases the MC control session; it does not
disable the channel. Cosmetic: an idle DPCON generates nothing and every
consumer reprograms on setup, so disable before close only to return the
channel clean, as the symmetric counterpart of the dpcon_enable() done on
setup.

Signed-off-by: Maxime Leroy <a class="moz-txt-link-rfc2396E" href="mailto:maxime@leroys.fr">&lt;maxime@leroys.fr&gt;</a>
---
 drivers/event/dpaa2/dpaa2_hw_dpcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/event/dpaa2/dpaa2_hw_dpcon.c b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
index ea5b0d4b85..f65a63a786 100644
--- a/drivers/event/dpaa2/dpaa2_hw_dpcon.c
+++ b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
@@ -128,6 +128,7 @@ rte_dpaa2_close_dpcon_device(int object_id)
 
 	if (dpcon_dev) {
 		rte_dpaa2_free_dpcon_dev(dpcon_dev);
+		dpcon_disable(&amp;dpcon_dev-&gt;dpcon, CMD_PRI_LOW, dpcon_dev-&gt;token);
 		dpcon_close(&amp;dpcon_dev-&gt;dpcon, CMD_PRI_LOW, dpcon_dev-&gt;token);
 		TAILQ_REMOVE(&amp;dpcon_dev_list, dpcon_dev, next);
 		rte_free(dpcon_dev);</pre>
    </blockquote>
    <p>The ordering here is wrong. <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">rte_dpaa2_free_dpcon_dev(dpcon_dev)</code>
      is called
      <strong>before</strong> <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">dpcon_disable()</code>.
      Once the device is returned to the shared pool
      via <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">rte_dpaa2_free_dpcon_dev()</code>,
      another thread can immediately re-allocate
      the same <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">dpcon_dev</code>
      pointer. The subsequent <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">dpcon_disable()</code>
      call would
      then quiesce a channel already in active use by the new owner — a
      use-after-free on the pool object.</p>
    <p>The correct teardown sequence must be:</p>
    <ol>
      <li>dpcon_disable() — quiesce the hardware channel</li>
      <li>dpcon_close() — release the MC control session</li>
      <li>rte_dpaa2_free_dpcon_dev() — return to pool</li>
    </ol>
    <p>Please reorder accordingly:</p>
    <p>dpcon_disable(&amp;dpcon_dev-&gt;dpcon, CMD_PRI_LOW,
      dpcon_dev-&gt;token);&nbsp;</p>
    <p>dpcon_close(&amp;dpcon_dev-&gt;dpcon, CMD_PRI_LOW,
      dpcon_dev-&gt;token);</p>
    <p>&nbsp;TAILQ_REMOVE(&amp;dpcon_dev_list, dpcon_dev, next);</p>
    <p>&nbsp;rte_dpaa2_free_dpcon_dev(dpcon_dev);</p>
    <p>&nbsp;rte_free(dpcon_dev);</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260630144329.457643-2-maxime@leroys.fr">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------B2xu2FJYWIaTsopxVQ9c5WcX--
