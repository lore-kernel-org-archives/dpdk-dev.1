Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321D9C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:34:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C10E40695;
	Fri, 25 Sep 2026 09:34:11 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11020088.outbound.protection.outlook.com
 [52.101.193.88])
 by mails.dpdk.org (Postfix) with ESMTP id B53CE40278;
 Fri, 25 Sep 2026 09:34:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldVgnav8lCZ/V0PnPMoOHALxU0tGKaQIpapQDIp0Jqv0YfqxncGVuKJ+7OvtGx/iF8wsx8cHuUxWWPvU7MGWwDyTrpgyeYJ6sIRCCeYh9jI093869ktA/VUpLzfTpLvgDHJVtoFOp66BLYwz+XqYgbrb6fkT12FO32f8FWRHry/DZcCETlqxecOCXANx+KuKbr62lZhztUFhEqf5p0Yn8FLR85tlVKZ0HZ2j417se82dtrL6FNCN7Ffla6HTu/OedZyepnaeZFLGZkRoml3z/YyoWhZZ9YVyXeXRVcTt4n37J2nwuI+fNY9IwYNsZtZrD3uyyZJpgISKS2RnXMbU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUeORLkzPOBeSWpFW8NoFtVwssuzoJwk68AD5/NN4Q0=;
 b=ghtSGh6V41pLLi0rb8hIJJBeBP57yrj4/JYruRC83zfW/Fc28kZcR8yRrWqmqMk2ttnSpraEtHtKqVKpdaPrSiBQsxzjrk/mvZZ4yNE5kQL96T7DC/YWMIjk/ka7Y7wMlosLGI/r/XgdUL7P8WXs1+oBz8FBeE8oaw95AfkskZT++tlDMp5+PnKCdnEGEbayrGk2uGhgNsz30bxjkq1WVdFGg/gtyTfCe/H3sZZRZVYkLVT+prGNkHvGOT1muPsxkShTiFppYHJ5fsWxP7WiNGiVL4OHsJFo5dS3795G335YnrgArvwKP8KjocW39RYIuLuD/yN/PLSh+y4+0cZ/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUeORLkzPOBeSWpFW8NoFtVwssuzoJwk68AD5/NN4Q0=;
 b=SzXo6acBNUaDcz+gVUrNcvR0ASr6QEbX9odTBHf7NU9r2Wp+kMjfHmY5CVwfV3drEXKq7Cz9k7UxVkxgs/dw5sZcRBfT8okeOKbdZt/qSPz1iy0xir/knSyIbqxAXZDzoyKjZHXh2eWbxDz9j7yzPyXEIoMiQUN58G8W6DCy6EQ=
Received: from SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 07:34:07 +0000
Received: from SJ0PR12MB6856.namprd12.prod.outlook.com
 ([fe80::f806:f24e:4978:7e50]) by SJ0PR12MB6856.namprd12.prod.outlook.com
 ([fe80::f806:f24e:4978:7e50%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 07:34:06 +0000
From: "Dhanush BT." <dhanush.bt@chelsio.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Potnuri Bharat Teja <bharat@chelsio.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/cxgbe: fix use-after-free in control queue teardown
Thread-Topic: [PATCH] net/cxgbe: fix use-after-free in control queue teardown
Thread-Index: AQHdOr2U4I+anLEoQ0iv6Pj6oI0u2La7Lo6AgCPT8UQ=
Date: Fri, 25 Sep 2026 07:34:06 +0000
Message-ID: <SJ0PR12MB6856BF24AD0B0F52DF87487397802@SJ0PR12MB6856.namprd12.prod.outlook.com>
References: <20260902092938.111197-1-dhanush.bt@chelsio.com>
 <CAJFAV8z=uuUzFF38uR1MM85_QQfP1mqmcLw94T5nGgPv=oqkBg@mail.gmail.com>
In-Reply-To: <CAJFAV8z=uuUzFF38uR1MM85_QQfP1mqmcLw94T5nGgPv=oqkBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6856:EE_|SA3PR12MB8764:EE_
x-ms-office365-filtering-correlation-id: a291ba4c-4f7b-43e5-e96a-08df1ad76134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|56012099006|8096899003|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info: QKiKBPIu+DFx/UV1GPbkvyDYPvUapBxhsmthtGLqOrgNUth1NHe9lJhssoxN8igdQMcB3zoo2oXYBC6JVoqw1HViWsFHUIOydHtUicMgJDNqR7ZL6fJF2hC2M/DkfG4hCj7ScKKOAovlVcrrmnwMzEwyHb54E1u1QxdbG2mPy8YeT0kF5+dvhyTCH8spW1Tpek2rFT2RZNeiY6NMnrz2WICIJhb8ZpBwzA5rkc2UYEAY4gGeBqpJUtVsDlHCC8G0SVEL+w+beo7xhwAbQtZsQGggyoagy5/EC3vK2giA+rG6C7OOeMNeRCc9vGO6Ko50ZCfuoLgu7nrXJl7ron8RWnrrng1QN5IV7SXYLF7BUMH12ic69zop5ynD1Agwu/xPrxD+6iqMTGhyejEujqhRmLSFUDYLnTFX2ZHSXL7o5L/g5EhFj57MWm8UawjkSdqf/GEGMFPTF9CadcO9sbKE7bjNbph3weyiXc4GRf3dN/JtDSkURTM/QWES/8lFM+YB3x8UnDc4mnzDEN939Y5RXDuae7Lnt5EhmOIp1kqANavSiiFs48txqFbcKqOuYShZSIjDgu4ul2YYyMey7aJOdNWjWT493bUBeo5C6k8t2k9juRAbhvT8fC+/ZjTWj9yoTcA1hPTuS3KjKyAlksXjaqZZExt7cSGdG5B2ryosuiZ5bxH5JP5uuCn1rbLiaEAgWciGuGTcbRt3+/JEsIpKnKX++rroXJikd6SuNq2O9Rw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6856.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(56012099006)(8096899003)(22082099003)(18002099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BwvsumxgtGt8HgTdh2XOosxEGIrEibL5pTvndEyjb6kN8r8vywWsY6YvojSp?=
 =?us-ascii?Q?GnFrN8r16fvq9uavA0ErHB2Fksxho4nDcNEYO6fQ/6LWelU1UwD5I7GdutIx?=
 =?us-ascii?Q?dO4y2ikkDOpyOORTabo5T1hUYep/tOTgT1WYo3O0pRxIDXi+SiauHmCo1C8K?=
 =?us-ascii?Q?bW5yY/y777nRPd6GYWrWCxeQoOWMSSfhJSou7wkiYTfLyJl54fLr2NDUZ8Ee?=
 =?us-ascii?Q?SiG386Fp/DZPQmz7LdMlXNAYTl0+xfEyVNXkxfEAwCCo4JBHgK+s7uEyWtTc?=
 =?us-ascii?Q?7PcglnmfptVGv2m0KC9MNzaDo/uXMKNSOzmq0LEjignxAVtQtJa5zqvawBaB?=
 =?us-ascii?Q?MyFGhEQQwt1wO4jsJ513HsE+17mjTN9RFFmgkmZWR94tOakZ083Tdmad/tVN?=
 =?us-ascii?Q?vj2a6RaC9cidHzNvCIEmArYl1yTxRBDXoWKtGo9b51nBMguffPSVPYHBSAEH?=
 =?us-ascii?Q?gEQ2cbFczVRzlSTNRr1XQeLb47ry99VnaqknfkDg/oXQXnQNWiiAOyauj/sg?=
 =?us-ascii?Q?zG3o/0xGDTedFoFdw7heb5oQIx1iICSM+ljMHz3tVP8UyKTfVQmRcIdLArHZ?=
 =?us-ascii?Q?K2X44KhMIh8pG82VZY3M46xwxUZc5o9/P8MFJw+sMEro1yVh1+NWE1C5/teB?=
 =?us-ascii?Q?pFa35tap/QeA6b1pLoZCliIMagwDyun/IlYOckil3B7MTKI5ryWQzxvXTypx?=
 =?us-ascii?Q?ivn72aMfr79Q4D5SOQnODBal4Edm+Tg+MdMzyYgLyF7Ac9c0O9ae9AZWLbpa?=
 =?us-ascii?Q?+5Y/laPQ1hC+sQLsrTAlN2xa/2IGHkmN/6ytTLl2cOx8wnFoSITf237nwHNw?=
 =?us-ascii?Q?dNRdSpAjjwMX1uletRpJU3ojLKxHK7UsWOWAHcMaJdKBiFRIxSyYA1TLzSXg?=
 =?us-ascii?Q?HVUdf/yB6IoU3WTyA2ujNgtaycuHs0r8Lh2oPCBdvYu/TRgcNkhHY3wQHxg+?=
 =?us-ascii?Q?JAFHid1S8MyGbLy4tM37JoRMBFD0iUwdicEvtHFzTS/4lOMgyZd2u+OHdXXE?=
 =?us-ascii?Q?SFsmqMzM47BGky+/PzjUAYGBgmsZDus8wdXZ5ltOa/4lGPHpHygSuqfXcGaU?=
 =?us-ascii?Q?ab2BLM6gyYisydooEubaPK8VPPlDpUnoWFI1HZD1PnuuoUPsCB6XunQiasFU?=
 =?us-ascii?Q?9/3HCXhvDPefL9G3bKoArL3QZ58CozQjcaRbAF9lr7FvEfMP26VD7UQbaEQd?=
 =?us-ascii?Q?ytOX+tkiBw0fxamLS79KbaE1AsVi4MCfftcbHp+3yXSJvb9Rg5VhUBR5P2nN?=
 =?us-ascii?Q?6TaU/E9y3NYe+5CqkYrvLd593L0ZL1bJxgfXdKahr7ZQfGDkcc3x7R2CHzcc?=
 =?us-ascii?Q?dRNF0aHzxJ8J2ts0UK4bXMWZH7QcZk7bNJIVEG0Pvu4JPPWA0eBueYgjfnRa?=
 =?us-ascii?Q?ewsuB+RyhEmf9vdZylA6I87qxOtiLE2jmK+aX49hHjb2NevS6n3G+k+N1hg1?=
 =?us-ascii?Q?NQy9QkxIPRWMSjCQN/eGtKh/JKg8QgF3gnFsvPcyZXiT72sqVkBz/bnEmxET?=
 =?us-ascii?Q?BmcM6uypBfG1bQ3T7nUIsF8vnDnyhZp82JvQuT0nRIaMstMVKB99EIZInXjm?=
 =?us-ascii?Q?XkbT7KugIznDTDsjdv1KCwqRWnlYKAnkxR9rWu76lHIu6gWhpV2YxcOCUxkH?=
 =?us-ascii?Q?6/KpBnMwRep1iwPLgjepMoEhlMRHSOqmoThsebghcqRyKjqgVrBTnGgdQ6Kh?=
 =?us-ascii?Q?q7RTn+uh2ej+rKZJdVqvGddxvJ5pTKlq+FIo0ZXSqtCRBHn2LAUy8GtmTVAZ?=
 =?us-ascii?Q?/Uh8N6uKjg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6856BF24AD0B0F52DF87487397802SJ0PR12MB6856namp_"
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6856.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a291ba4c-4f7b-43e5-e96a-08df1ad76134
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 07:34:06.0920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emEWygW49dbJr5QG01PzwR3n0DQVDuBCkcKCNMJpktd/BucVwJd9W7XVk1fZWf6l7B0f4FD9Cnqwg688obiBWn1P9JLLnjXTr1n5rElXutE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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

--_000_SJ0PR12MB6856BF24AD0B0F52DF87487397802SJ0PR12MB6856namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>  I don't understand the issue for now.
> Something looks wrong in the driver, and the description above.
>
> The adapter object seems to embed shared resources across multiple
> eth_dev objects, is that correct?
> If so, any function taking only a adapter pointer as input can only
> deal with the first port related.
>
>  This is probably the reported crash and then I would point at:
> Fixes: 6b78a629954c ("net/cxgbe: fix queue DMA ring leaks during port clo=
se").
> Which releases only the first port DMA resources even for another port.
>
> If those DMA resources are shared, the driver should not use
> rte_eth_dma_zone_reserve() and this driver should come with its own
> helper.
>
> But otherwise, if each eth_dev object has its DMA resources (which
> seems more likely to me), then my suggestion is to pass a eth_dev
> object to the related functions.
> And a followup cleanup would be to remove the back reference to the
> first eth_dev in the adapter object which I find really confusing and
> could be a source of bugs.

Thanks for your review, I am working on the v2 based on your suggestions.


________________________________
From: David Marchand <david.marchand@redhat.com>
Sent: Wednesday, September 2, 2026 5:25 PM
To: Dhanush BT. <dhanush.bt@chelsio.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Potnuri Bharat Teja <bharat@chelsio.com>; =
stable@dpdk.org <stable@dpdk.org>
Subject: Re: [PATCH] net/cxgbe: fix use-after-free in control queue teardow=
n

On Wed, 2 Sept 2026 at 11:47, B T Dhanush <dhanush.bt@chelsio.com> wrote:
>
> t4_free_sge_resources() frees ctrl Tx queue and firmware event queue
> DMA memzones using adapter->eth_dev, read at teardown time. This
> runs only once, when the last port on the adapter closes.
>
> rte_eth_dev_close() frees a port's eth_dev->data right after that
> port's own dev_close() returns, regardless of other ports' state. If
> port 0 is not the last port closed, adapter->eth_dev->data is already
> freed by the time t4_free_sge_resources() runs, causing a NULL
> pointer dereference in rte_eth_dma_zone_free() and a crash on exit.
>
> Fix by not dereferencing eth_dev at teardown. Store the port_id used
> for each queue's memzone name at allocation time instead, and free
> each memzone directly via rte_memzone_lookup()/rte_memzone_free().
>
> Fixes: 36c46e738120 ("ethdev: cleanup shared data with the last port")

This commit may have made the bug more visible but I doubt this is the
reason for the reported issue.

> Cc: stable@dpdk.org
>
> Signed-off-by: B T Dhanush <dhanush.bt@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>

I don't understand the issue for now.
Something looks wrong in the driver, and the description above.

The adapter object seems to embed shared resources across multiple
eth_dev objects, is that correct?
If so, any function taking only a adapter pointer as input can only
deal with the first port related.

This is probably the reported crash and then I would point at:
Fixes: 6b78a629954c ("net/cxgbe: fix queue DMA ring leaks during port close=
").
Which releases only the first port DMA resources even for another port.

If those DMA resources are shared, the driver should not use
rte_eth_dma_zone_reserve() and this driver should come with its own
helper.

But otherwise, if each eth_dev object has its DMA resources (which
seems more likely to me), then my suggestion is to pass a eth_dev
object to the related functions.
And a followup cleanup would be to remove the back reference to the
first eth_dev in the adapter object which I find really confusing and
could be a source of bugs.


--
David Marchand


--_000_SJ0PR12MB6856BF24AD0B0F52DF87487397802SJ0PR12MB6856namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; &nbsp;I don't understand the issue for now.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; Something looks wrong in the driver, and the description above.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; The adapter object seems to embed shared resources across multiple</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; eth_dev objects, is that correct?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; If so, any function taking only a adapter pointer as input can only</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; deal with the first port related.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;&nbsp; This is probably the reported crash and then I would point at:</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; Fixes: 6b78a629954c (&quot;net/cxgbe: fix queue DMA ring leaks during =
port close&quot;).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; Which releases only the first port DMA resources even for another port=
.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; If those DMA resources are shared, the driver should not use</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; rte_eth_dma_zone_reserve() and this driver should come with its own</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; helper.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; But otherwise, if each eth_dev object has its DMA resources (which</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; seems more likely to me), then my suggestion is to pass a eth_dev</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; object to the related functions.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; And a followup cleanup would be to remove the back reference to the</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; first eth_dev in the adapter object which I find really confusing and<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; could be a source of bugs.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for your review, I am working on the v2 based on your suggestions.</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> David Marchand &lt;da=
vid.marchand@redhat.com&gt;<br>
<b>Sent:</b> Wednesday, September 2, 2026 5:25 PM<br>
<b>To:</b> Dhanush BT. &lt;dhanush.bt@chelsio.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Potnuri Bharat Teja &lt;bhara=
t@chelsio.com&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;<br>
<b>Subject:</b> Re: [PATCH] net/cxgbe: fix use-after-free in control queue =
teardown</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, 2 Sept 2026 at 11:47, B T Dhanush &lt;dhan=
ush.bt@chelsio.com&gt; wrote:<br>
&gt;<br>
&gt; t4_free_sge_resources() frees ctrl Tx queue and firmware event queue<b=
r>
&gt; DMA memzones using adapter-&gt;eth_dev, read at teardown time. This<br=
>
&gt; runs only once, when the last port on the adapter closes.<br>
&gt;<br>
&gt; rte_eth_dev_close() frees a port's eth_dev-&gt;data right after that<b=
r>
&gt; port's own dev_close() returns, regardless of other ports' state. If<b=
r>
&gt; port 0 is not the last port closed, adapter-&gt;eth_dev-&gt;data is al=
ready<br>
&gt; freed by the time t4_free_sge_resources() runs, causing a NULL<br>
&gt; pointer dereference in rte_eth_dma_zone_free() and a crash on exit.<br=
>
&gt;<br>
&gt; Fix by not dereferencing eth_dev at teardown. Store the port_id used<b=
r>
&gt; for each queue's memzone name at allocation time instead, and free<br>
&gt; each memzone directly via rte_memzone_lookup()/rte_memzone_free().<br>
&gt;<br>
&gt; Fixes: 36c46e738120 (&quot;ethdev: cleanup shared data with the last p=
ort&quot;)<br>
<br>
This commit may have made the bug more visible but I doubt this is the<br>
reason for the reported issue.<br>
<br>
&gt; Cc: stable@dpdk.org<br>
&gt;<br>
&gt; Signed-off-by: B T Dhanush &lt;dhanush.bt@chelsio.com&gt;<br>
&gt; Signed-off-by: Potnuri Bharat Teja &lt;bharat@chelsio.com&gt;<br>
<br>
I don't understand the issue for now.<br>
Something looks wrong in the driver, and the description above.<br>
<br>
The adapter object seems to embed shared resources across multiple<br>
eth_dev objects, is that correct?<br>
If so, any function taking only a adapter pointer as input can only<br>
deal with the first port related.<br>
<br>
This is probably the reported crash and then I would point at:<br>
Fixes: 6b78a629954c (&quot;net/cxgbe: fix queue DMA ring leaks during port =
close&quot;).<br>
Which releases only the first port DMA resources even for another port.<br>
<br>
If those DMA resources are shared, the driver should not use<br>
rte_eth_dma_zone_reserve() and this driver should come with its own<br>
helper.<br>
<br>
But otherwise, if each eth_dev object has its DMA resources (which<br>
seems more likely to me), then my suggestion is to pass a eth_dev<br>
object to the related functions.<br>
And a followup cleanup would be to remove the back reference to the<br>
first eth_dev in the adapter object which I find really confusing and<br>
could be a source of bugs.<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB6856BF24AD0B0F52DF87487397802SJ0PR12MB6856namp_--
