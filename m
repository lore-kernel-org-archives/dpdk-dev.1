Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B5CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 16:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1E6D40A87;
	Wed, 30 Sep 2026 18:37:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011066.outbound.protection.outlook.com
 [40.107.130.66]) by mails.dpdk.org (Postfix) with ESMTP id D6DD1402D9
 for <dev@dpdk.org>; Wed, 30 Sep 2026 18:37:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/I8ZfBz6dy9ocYxqNto3FoQ7sQlPfRqWU+yQD+QADtTUxkoCioSKP42GdBaNg7/4BW4x330uMHgfX05Y70yT/E3QU2hNir0sF+bj1xumJYfVCcFO5HVqzIH/NGnfRacVhszA32CxVr1Jad5vcPWvFe1T9g3faWYE+wdg/MNR3jNj9npMuW0Kj7xaVN02hnR0Y4W3X8LR1/ci+f7ClsRKM8LAGgLV6I14f8qIbXWEUzzLCBqSdI9uR+BMx7Vcwi2qT+snrp1Nb4rXemRx2u28qkEhM/gbMbXy8hl2twbWm8Hir2kCUOdvwvjY9xoaH8eV+YXCnzB1MhyGZU1vv7hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9ZaSTxEtIPCHFnmej0PFJYQEeWjKtVunrQ397oroTU=;
 b=CCkoEFjEWBSQC/XhqGDN1rn2iSSam30VST31OCp7oOt6XHQ7TVwzEKBWA53tToZ447P8Epoed8s+jooZrbHW/+IU0QeQ+XaKl3lbl1Lgl1hgdjFxZUSiAoFC3XbzL7MBK8tJBpHz2wu+A3O6wOT4I+ayy60VKNesNPN2EAqljn5h4xU+mJxZx36vSJh5X3KUtR4+ET3TKQcqy5PA9bF1ulc/Wh3hXS5mZ/hDgbmshj/rAOoit56MtrB5MNpCWB3j7L4nOEWLirzJ7hozNfj8fVbIy4HiIljdAdKejUdjXmy2plQPcNLQfFQEC5/dXvmrUr95mcWLTbg3n9ce8txBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9ZaSTxEtIPCHFnmej0PFJYQEeWjKtVunrQ397oroTU=;
 b=gu41jU1fV8k/TOerjjcLfq0GI5AeJVd392t6HRBiwEzfSRK6O/nFnhvca1FAHYPHuq7iGyLj4DsUYyai8VGHypmQENw7KrHFYw7wZoyGWz4um3jgtdDZgAlfWW0EUaSYosOFCA7s70nuy3L3Vx3pr5NVms+a/qCfTRb0Hxvcs/YFHmraMpVD2Dum7+c8fCRue9dr7cvI+dRt8JFNERWyWwRph3pJLAzfCZPltWhXJHRUwJDkOeqaoAoTfpo9bf/3fNLCiCCzXqfFsvoRQ8cLB+yKnzd8BE2ce7fGMwaOV+8duJZZGep+yhBiuxnWvSFtuSA7PqWNyEwRELzENjPTYQ==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by GVXPR04MB9926.eurprd04.prod.outlook.com
 (2603:10a6:150:11a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 16:37:07 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 16:37:04 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v18 00/24] NXP DPAA driver enhancements and fixes
Thread-Topic: [PATCH v18 00/24] NXP DPAA driver enhancements and fixes
Thread-Index: AQHdUKRkyTkkOmsqeUyYLYCeQk9f3rbnSg6AgAAIbAA=
Date: Wed, 30 Sep 2026 16:37:04 +0000
Message-ID: <GV1PR04MB107503F62126F240700002EA4898B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260930062437.3019096-1-hemant.agrawal@nxp.com>
 <20260930090637.1125cc72@phoenix.local>
In-Reply-To: <20260930090637.1125cc72@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-30T16:37:03.415Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=1;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|GVXPR04MB9926:EE_
x-ms-office365-filtering-correlation-id: 5e50dd50-e11b-44ad-3420-08df1f110fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|376014|1800799024|18002099003|22082099003|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|8096899003;
x-microsoft-antispam-message-info: xPdF30w29iZTWfmOdyuADDxThn09GHH08+pT+XnQN8C3ePr3MHSTNlaOKbsvA3ooRUjU57HOpWIy/lw67XjnR+OcEM55nvVUdealC1efqDo15AteuisNMhYCaTMsoCLaXoLM4n0jlQu//xGNAxVrNW52Evt6R2Pke4iNvC1XcDmKfIlXAwYCetleOkLhUSTHwJz5ZbmRE8giXarc84NWsr5YkDgd9dQUrpRznjjNrE5RwQCmPY3n415cQdaTGX4BxIph6Tk7VZ7F6B4XrVQIH8nyaF5WgPgsl+5e2qIvr4Bt4VufIr40Gcepw4Om0s0+KV0/Hln7cT34EO5xhX+HRnlSncnZrG4y8/znmYbJfzpb/zo0tw/mqpeF446TJ4i2mqyB7f86u3UQqUczoNHWUvmTF3txmlCzBKNTGQsehVlouYvUdai7mUhyWMmzZ4QLoStUabym8SX6ijVobW/We4kuOJrmm+BQAgjsqStI++SeRF1th1kKOvFpr1UUKGrZbpb0GumdI+eoz/5EDpcbwr/85uIohnxoEc9bL5R6n2FgZ3oji9inrN/RGU+JnnkWgTVB828HY6+e3c3T84iOBlVy3QUrBEHo9Pa0xTBhwwUB8rIm4Bcjusk44BfpokN7tL2RkorQfClNa6DLj9ndLOukJ6ZIByJGG4nhip66AWXT51DI9JtTk/0prgfUwi2pKmXC1Qr/vvqxo6OKGMLWiSZ3iJulEAb4FavSnL13lGc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FVv9968dSXvUyDYziZyCO22uQOx/Sb5Rxf+i/C/jRlodazNLv8/W2GlsCU?=
 =?iso-8859-1?Q?sNmqfrxy9O0jkfDNf0qZboT/LQsH5+1/V6tWCjPDHn+bO0PH6sRKpnV1uJ?=
 =?iso-8859-1?Q?RvXhLE+bcgPWdiioFCNR3e6KHZmlE9Fu6ayXtGy2g/QztsrMgbs4TVQqPT?=
 =?iso-8859-1?Q?LNPETPpwDr+KrI4TPSqRAYSsPn1AGFt1mKzZ8yqxlePAQuyKDN5DRqoE8r?=
 =?iso-8859-1?Q?3/7NeSDUOacOAIGcs3xbG9tPTn7YT4EExMvf/3VzJhAVp0nAt8NmcyCcTp?=
 =?iso-8859-1?Q?ZqW9gMdOVll2eJEdADNYOOwEXeq/j42bfNczPAz3x53RTfg3yzTU+AsBGm?=
 =?iso-8859-1?Q?6+Fms0z7HEu69J7FfGPzaf9e7WEl6hUhicLH34R9X3ljzg5MQjG2NmbR2X?=
 =?iso-8859-1?Q?j58MUznFT62c0D1kloGfyI91n0DF4IwNPe+3anp3Qnfn7+E/ykaiIL6fZ8?=
 =?iso-8859-1?Q?Pnh0crbjoS93II/k8/BP1rkSZQKZr/03YLxTyAZ91WC/aJj8ye3aZjpWJ7?=
 =?iso-8859-1?Q?RrYXstXkMuFdxHwwCm1X0W771+3yHGLQBTXjJhQxmYaWSTat1Mdz3sKnMl?=
 =?iso-8859-1?Q?sfHCO+ZAsFgcXULuBQKKj0rACen890ZXceQtiDrXO3SkRladxv3EwxxNoE?=
 =?iso-8859-1?Q?CTMceOIGBeW9bFk+FUdb94GD1blzNLgpj/9da7r4LOxBVjlW8R0fIlQS6Q?=
 =?iso-8859-1?Q?t3snEozO0dpjBFjr0LpfJcorjDBv3DqQoLfptGTsKHHnQLqiKlBXlivthH?=
 =?iso-8859-1?Q?Z12teKFllcg8qeK27KG0J/6ikiDWV3vLoxCFm5wEvXPDGlH66yQDWP3Uqm?=
 =?iso-8859-1?Q?ci6PGTvjLtdEmJtBFKevaJhel/EkxOLbW/GAKs1zh769pXZTZxzK7HgVDp?=
 =?iso-8859-1?Q?hVEHivXE2oi69Jid78XlfRQhD0AhN1fohr9cdccxfwBigshSPKoGHQbr12?=
 =?iso-8859-1?Q?m8d3sKlvBBKNW6c5xF5mQ7IqvArrTXP4SDvR8gCDJmTZjRkCrHNMzTgzQO?=
 =?iso-8859-1?Q?R/tZOiAmD498KNWkAVVQZCdW/StRVg8qkdJ8Y9fUspZ7eH7wyliyumrkcx?=
 =?iso-8859-1?Q?PAvVHOj3EhnwRmKjOxqd/X9XQ9hZY+IvkBEXANrFoFXjY1IQnEg9CBi8Jn?=
 =?iso-8859-1?Q?//KjgLnughJaUYiomE20hKr0pS8Rpi6PVrJkmgIsVrwHgSujU5b2YsD8S+?=
 =?iso-8859-1?Q?ZkbXGbFDzQ5lQrJIslIbr8ooED1ZnnWH8NvEw7OxtoiachKYCFYqtB1+lo?=
 =?iso-8859-1?Q?UndNXBLm9LHq6dLj3xcGbhsP4naY8OdXtHFmIKza0tUDI4qpGMOQlZK2n5?=
 =?iso-8859-1?Q?EenIb/Peb3ogTlvHc1jZHIN3J4bsspM/WndU12xjFWTxDO2V9sIaeNNu8Z?=
 =?iso-8859-1?Q?ByVkb8Lc3am39JqLBEPUX39mP74h5PCein4pv0L4dnKeLZ6X7bN7gGUwvf?=
 =?iso-8859-1?Q?/6hfpRT4jvvrSMC7aQJARD4RZKa9skFXue1PWPH/uYHCp2zd6rcGZ0UqkP?=
 =?iso-8859-1?Q?ofm3RoTKDJt06HExS9rvoOXFgDsZhsVICf+7YADNv8MpjcquR2TqOG9VHn?=
 =?iso-8859-1?Q?yA1L6eBRhucadInTzuExEXA33IiQ1ernLd9LIzp/p57P8JCpXNTJgcSD43?=
 =?iso-8859-1?Q?ww81Vls55xeCRyofpBGLn+MsHa9klyU6wLAUIkQPvAOZlRhej0EUoTFrIR?=
 =?iso-8859-1?Q?H4RefgT3DK6PkZu+b/ldSyfYvvwCLVWaNw8grD/QIY1e6Eu1e86/+Fvz1U?=
 =?iso-8859-1?Q?830hLJBm4UPTACFjdziwF4hp/8LwJ6GZEKgPna5ZlcCSPTLMJmFvy+il+3?=
 =?iso-8859-1?Q?Av1YnjLNOpREckUAXl2MKYqnJ5F+WOQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_GV1PR04MB107503F62126F240700002EA4898B2GV1PR04MB10750eu_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e50dd50-e11b-44ad-3420-08df1f110fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 16:37:04.8188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1d9NVqzmKbB28yTlMYf1c/bFMkgePDQui1+Ir7BtjmXywZohaE9stPlSAS+WxHQ4JKW3LHtYTK2v8OB0t3JZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9926
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

--_000_GV1PR04MB107503F62126F240700002EA4898B2GV1PR04MB10750eu_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Wednesday, September 30, 2026 9:36 PM
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net <thomas@monjalon.net>; dev@dpdk.org <dev@dpdk.org>
Subject: Re: [PATCH v18 00/24] NXP DPAA driver enhancements and fixes

On Wed, 30 Sep 2026 11:54:13 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
>
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> errata-workaround devargs. Documentation and release notes are updated
> accordingly.
>
> v18:
> * Dropped the "net/dpaa: fix device remove" patch. It papered over the
>   symptom in rte_dpaa_remove() instead of fixing the cause, and was
>   replaced by the two fixes now at the head of the series.
> * net/dpaa: fix the double dpaa_eth_dev_close() call and the eth_dev
>   dereference before the NULL check in rte_dpaa_remove().
> * net/dpaa: unwind rte_dpaa_probe() through cleanup labels so the Tx SG
>   mempool failure path closes the device and releases the port instead of
>   leaking the port, the queue arrays and the QMan FQID/CGRID ranges.


Much better but still see some leftovers in AI review.

Please  share the AI review comments...

NXP Confidential

--_000_GV1PR04MB107503F62126F240700002EA4898B2GV1PR04MB10750eu_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
<b>Sent:</b> Wednesday, September 30, 2026 9:36 PM<br>
<b>To:</b> Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt;<br>
<b>Cc:</b> thomas@monjalon.net &lt;thomas@monjalon.net&gt;; dev@dpdk.org &l=
t;dev@dpdk.org&gt;<br>
<b>Subject:</b> Re: [PATCH v18 00/24] NXP DPAA driver enhancements and fixe=
s </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On Wed, 30 Sep 2026 11:54:13 +0530<br>
Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt; wrote:<br>
<br>
&gt; This series collects a set of fixes and enhancements for the NXP DPAA<=
br>
&gt; bus, mempool, dma, crypto and net drivers targeting 26.11.<br>
&gt;<br>
&gt; It includes memory-leak and resource-cleanup fixes on the device<br>
&gt; remove/close paths, more robust frame queue and congestion-group<br>
&gt; shutdown, secondary-process safety guards, BPID and cgrid lifecycle<br=
>
&gt; handling, and several new features: offline (O/H) port device support,=
<br>
&gt; enhanced virtual storage profile (VSP) port support, fmcless Rx queue<=
br>
&gt; configuration via devargs, Rx/Tx taildrop threshold devargs, non<br>
&gt; fmX-macY shared Ethernet naming, and DMA scatter-gather and<br>
&gt; errata-workaround devargs. Documentation and release notes are updated=
<br>
&gt; accordingly.<br>
&gt;<br>
&gt; v18:<br>
&gt; * Dropped the &quot;net/dpaa: fix device remove&quot; patch. It papere=
d over the<br>
&gt;&nbsp;&nbsp; symptom in rte_dpaa_remove() instead of fixing the cause, =
and was<br>
&gt;&nbsp;&nbsp; replaced by the two fixes now at the head of the series.<b=
r>
&gt; * net/dpaa: fix the double dpaa_eth_dev_close() call and the eth_dev<b=
r>
&gt;&nbsp;&nbsp; dereference before the NULL check in rte_dpaa_remove().<br=
>
&gt; * net/dpaa: unwind rte_dpaa_probe() through cleanup labels so the Tx S=
G<br>
&gt;&nbsp;&nbsp; mempool failure path closes the device and releases the po=
rt instead of<br>
&gt;&nbsp;&nbsp; leaking the port, the queue arrays and the QMan FQID/CGRID=
 ranges.<br>
<br>
<br>
Much better but still see some leftovers in AI review.</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Please&nbsp; share=
 the AI review comments...</div>
<div><br>
<div style=3D"font-family: Calibri; text-align: center; color: rgb(0, 0, 0)=
; margin-left: 5pt; font-size: 10pt;">
NXP Confidential</div>
</div>
</body>
</html>

--_000_GV1PR04MB107503F62126F240700002EA4898B2GV1PR04MB10750eu_--
