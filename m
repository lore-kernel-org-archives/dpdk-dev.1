Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A146CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F6BD402E1;
	Wed, 15 Oct 2025 11:44:54 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
 by mails.dpdk.org (Postfix) with ESMTP id E91FE40276;
 Wed, 15 Oct 2025 11:44:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyXkAfDytmxfSgx/VL7O/06vjpBBueJjPGYYLSViJl8K/rIHyPNFAqZSrP+GT9itBbGuH6ynIIh2vIQo1ZP7Oc1TGqX9L944wc2YffLP0ZSX6TVyCx+A0F3m6hfqaVjkG5VprZ/oFDwUZ//df54zxh9Vmn13yBG5htq5hpwcq6xO1tFfBPlAYEeWE/1FiiDpqq1hY2IkZr3xrBKkrhEHLjlDN5M1Yjx5lJhMsXMgu+VB82YCALgPEONhe7n8rb8wWnPxp7UANoracMhC8zpBBVId9GWLyK4/d/9Q+cZpPJHq/Y6PcnC3FzF6Y2JoI7+u9l464u4f4040D7lDnvj8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuSdmbTTYN41ftLTPFF/dg7wZ1sGD2MUYxElLlKIkDg=;
 b=UZKQB6ajjgM5Me5oDlCnMzztnz4ba/+abHIrxicUc8aJOzmdqBVw6JHMCauPh9RwRExPTqCuK9w0Ls6QgXYNg1WTG2mfUZjROb3UG82g6sStSWScQBeS3LAcrMHgTxoEquyoj4vva5TYA4wvpnpTNpdQm2g/109a2DtgiOearJKHdOkHn59cnDHE+FGMNLQ/24s7+HW2d3cS8c+61o4fz1ZIopRrYoY1U3qSkbEhMk3sxp1lewA1M5MOflubSBDCkMSMIbFHkPlUtXU2P+Au3GXhQERoDjQ7r9Fl584KbGRonPdnGldzngTrIP3xIY5xyyiG6ne6CghVP0caeaRbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuSdmbTTYN41ftLTPFF/dg7wZ1sGD2MUYxElLlKIkDg=;
 b=MKE60HeFBqgKoJ8TOc8gCd7px/np5//9loEC8jAaqHV3L9o+7YTLqchjgkh9wrtniJclGci2VDYNxGIEw045LxlHBCDZ8b57AmShmrugy/170in6tfl+jobzWAO38xB5wbxgQoTJeVG5M8u8/uPOXqtKiqArgxlVlnK1ljBvZ6dYFrIpVn17ZfqfEsHUtabBS7SUG7L7zXxX2wYFhttMhAxZ2BqR7A8y+Q6WRziBuNWi5SYtcW7wIpajwiw3PhBNiSOioRQC9YhAQImrpH+LN0mt0Fc9AuzNexEUjzlATeb+uUlH7CRCx1mX83vahR4PVSk9U0xdJs9hp/VdK2wjWw==
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19)
 by VI0PR04MB10831.eurprd04.prod.outlook.com (2603:10a6:800:25e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 09:44:49 +0000
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418]) by AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 09:44:49 +0000
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "users@dpdk.org" <users@dpdk.org>
Subject: DevX UAR allocation failure on ConnectX-5 (MT27800) with DPDK 22.11.7
Thread-Topic: DevX UAR allocation failure on ConnectX-5 (MT27800) with DPDK
 22.11.7
Thread-Index: Adw9lCH4K0B+HWh9SYKK5ZixcnFDuAAJC0JQ
Date: Wed, 15 Oct 2025 09:44:49 +0000
Message-ID: <AS8PR04MB82933143CF52A473CF05B0A0E5E8A@AS8PR04MB8293.eurprd04.prod.outlook.com>
References: <DB9PR04MB8300AD6E2DD7ADD25C0C4F1FE5E8A@DB9PR04MB8300.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB8300AD6E2DD7ADD25C0C4F1FE5E8A@DB9PR04MB8300.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8293:EE_|VI0PR04MB10831:EE_
x-ms-office365-filtering-correlation-id: d064326a-7df5-40ad-d705-08de0bcf7bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?F0JYWPyMCuZQf7HOy2nJZpVjWHpyxAiE/bkGZDAVQOJhHkXXaKo/w/meAd?=
 =?iso-8859-1?Q?S5o+f25/DEAX8RKgBzzLKE/HSIgMQjQX7T/iEMg1zU5RJQi/KIN7RdeIRd?=
 =?iso-8859-1?Q?wy2lDgyl/Hus8go0Stn9d+Pxjfz8lhb5kpV1a5gNEo1lA2VJnMa9aLDGSf?=
 =?iso-8859-1?Q?zc0yCRDFjA82QBJ2NxcYJZIgulmuJYa/HhO2nNeYwJKoXjOdAUq0dFodjW?=
 =?iso-8859-1?Q?gREH66/sz4r2/IVLfH8Y9ADKENFli+B1C6ktVJAB804Fm46d6oFpG/zKpH?=
 =?iso-8859-1?Q?ytc72C0jEe344316/xJ2QEW7dyAIuBWO3wFEEmHaYYzz3N13Ye4FI3xLr0?=
 =?iso-8859-1?Q?+HiwXWBolSEHjcyXy4ZHLimogeUFDlo8Rkh1yW9sqYzvRTjRVmxL7CT8AC?=
 =?iso-8859-1?Q?iVWbl+Q1KxG0NsqfB4Ka2C8fz4Q3Vp2RWW78+7dTurv2ID594ZZaV8UyT4?=
 =?iso-8859-1?Q?Ltc4YnxvUUctz5zQ7a199F3M3Fmy+TU/Scx3q+9zW/oMIia/Rw5l64WzP1?=
 =?iso-8859-1?Q?89momhkXvwXwyMRNPyKIsEwgXD7TsyyAWMJ+T8RdSAnxoiPJcaMHGvp6i0?=
 =?iso-8859-1?Q?IyVr+yYwoApLl+pFmE4McSiUGR4qeCMix8oZ4gfMR/H/0SsNp1TS/z3pr8?=
 =?iso-8859-1?Q?mqCae0hZD3fMJDEy8drtGa/ZOVth41x7zBhRsVI5OSfumM3q5NoF/5nqGk?=
 =?iso-8859-1?Q?zLo4Q0tVxdzYaXMvo50U1cpah9DaXUVAxUOOyrwbsRLm3RyfkaJUYZ6gKa?=
 =?iso-8859-1?Q?U7NFxTPkC0zN8R9hcD31/A4jFM88JRG8VNp6Xk/anFR9rPq8n7OA458rEm?=
 =?iso-8859-1?Q?UvkRU64uOdnIqj5c4HNy+2kQ9Zbiw5lYY0KMdBpr4R3yuaWJszrZ6/I/7c?=
 =?iso-8859-1?Q?k6mze4Dk8Ek8ZqEWARpfhiVzdhhcNjwooz9c2IsG3PfLKay0uE5ZzVkMKG?=
 =?iso-8859-1?Q?mr7EBvCGAlZB4SnsjYGG9H9Ib89LXpd0lWtZ7iN9iO9l4TCRkBOMnPlp9f?=
 =?iso-8859-1?Q?R8RZNSforM7fYOZX9f/TmTU8k3DwgI4ws/0w7MVItDszFyIHtMXsXtCfja?=
 =?iso-8859-1?Q?ulmiLBWRo6mjWVOv4/9JQP1zVVg6cHK54Pli2GfCETv9TG3pmWinIJPwV8?=
 =?iso-8859-1?Q?8VDti3M3KhnuBacIwQAogO4gvFtGC0L6/dQ934VJmS0gSWbb8vChqElhdC?=
 =?iso-8859-1?Q?ChJmLwkEPePeIq0UDh9I3Et6RxVYZ8Zkkw3GFiro1sVAJrw9wPVQhgof82?=
 =?iso-8859-1?Q?AgfpXhgIOM/FzHYwkAYtBZXFFs3s63ocj0Q1z0KRTkUYuy8NOEnHwA0lDK?=
 =?iso-8859-1?Q?3JW+6v1fBd5LmBD+5J60o+I7SMvxWomO8e6a8J0R5HPyrU7kg4+72EzQDG?=
 =?iso-8859-1?Q?KzCoPTEDw2AId12L08EawM1fmCzZSO/AnRApxnqEfkY8I7N77JMlOEUtrE?=
 =?iso-8859-1?Q?B1Yp+8RHeEuYMI3M731zOF5NsIbaLT0LPxe2o/EvWEOkNVkpvMLGL33iLt?=
 =?iso-8859-1?Q?DQaNuefRKX/kkTmFdu3pF70zwd1kozhLZ0t+mLviCn4OBgEII3GO+//bUm?=
 =?iso-8859-1?Q?raHTt4O5Cenhpz5PRqEFXD/hwbm/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8293.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TXBb4uxH437/8ma3KR6v8dQ3/byw4/MJ06jZBEt7YC+QLq89UL+G5Hn8Vy?=
 =?iso-8859-1?Q?HL3nDq+CjpxZVEzDMvEXhFtlkVTloWcWjOWx6KYPfHHpwPdpYncuquuA6V?=
 =?iso-8859-1?Q?eG91Nw8z1C9zMuq8GC5rZZUDleo+PS8KCclcMMH6ASwCT4N7/N0DPIPdHc?=
 =?iso-8859-1?Q?bEAUyuriCoeCagBWPGl+VZQSQpyKNtbOcFpF4UGMrkeq8diObllCkDLxjI?=
 =?iso-8859-1?Q?g7xYH3O1HQkdzQB/lVKz+K2NVUizjEpTaNwYHccGQ+p36qcM9+prBib1aW?=
 =?iso-8859-1?Q?R9I1uUrpLj9rMjdsqOddLXsvubenqrlCgQx9Giyl4l1JpVu8tMMmyClYX3?=
 =?iso-8859-1?Q?xxrysb48EiyBkdk9yfLkSp5VVN1FAjUALLgHNQDN/6p9yE2U0QDuyEPI0X?=
 =?iso-8859-1?Q?50PcjCltU3hdrAUX3UxVNB1hv+n+7JZUAJWE2y8d7I6rN62ao5N2ncpcQI?=
 =?iso-8859-1?Q?gK2/qBu9G2e8L8mCS5oTDMtqAB9W+Th9tsvH68TnMweE14LIkMwSg4EIhk?=
 =?iso-8859-1?Q?OnsP5au4qgRETihItl54Z/L5bz852X58nUIafNrmYdtPZ35orqUSddqNI9?=
 =?iso-8859-1?Q?9jM97xnDmExW4aj6Z8Rh5dXpOiO63aL0Juq68W4KWSYjtfQrWe2rpaERFX?=
 =?iso-8859-1?Q?25/fx825gxgSL9ZjEk8wV7Ht+I6iiEAeEz7dAfjMi924K8UTMbk1gWLShM?=
 =?iso-8859-1?Q?2CgsbA5uPoZkU5D/lQdfByTflEgtiaDyTpTJEc6rOjI+2sn/BftOXsUAWU?=
 =?iso-8859-1?Q?qRoAjsYGylov4eWCq+XcJehEKav6Li54ICuVp74seAy/ty6Yy/qBkm5rtT?=
 =?iso-8859-1?Q?9/+RsMNvabYXizBQxunzWtPjlnqACk3R4c39O2MT8w2BQfNJ8z47wwlzEf?=
 =?iso-8859-1?Q?HP8rN1ReD1JU+M86jKFT9o6+hxtBZaUO3zP1PwYNcijm8ekKsxYHGxJ85Y?=
 =?iso-8859-1?Q?PShzbogMJi/36A8ShVmEYJfin4zYYept01HYHjpQIZ0m0CNwX968zEfy4O?=
 =?iso-8859-1?Q?VxSIzHJly3WZZ4gJu8y3NMfsDdX9uiM2M6l904mHJnVW04R1FDtmfVjEnR?=
 =?iso-8859-1?Q?jsWjqIS2pSJpsDwE7nvq6mwPSR95WTf4ju70Nm6a9yujDGIpyzufojcWD6?=
 =?iso-8859-1?Q?7crMqewZ6N8AtVNBWMg2d2jsr7Boq9rYnF082XpHI/QUBpGNdHz0FSsyAF?=
 =?iso-8859-1?Q?UeOTyk5oejoQwqkbJ90G6W4c1K/u7evzNECdOGfK/YyNe02ipgEGwHXlsd?=
 =?iso-8859-1?Q?KV9C7QBcur05Xxmz0e36Gq8qa0+TshYntov5e3x6H8Hydtm7kCO/u8fkrw?=
 =?iso-8859-1?Q?wJqEgpqKeug5EqwsEm0PYPAtwY2abQr4Gvle6BzxXDGC8Ok1b4KqusXqgu?=
 =?iso-8859-1?Q?zDRfrpMijjHQeFSjhGONZy3y00ouFSnSPWj477BimvEY8DpCRtzShGqtPz?=
 =?iso-8859-1?Q?XczR5PESqolBIqB4ulNnk/1OMYybcK0MdGLSl3CoEdnoW+idaMqIMlg4ml?=
 =?iso-8859-1?Q?slUbZSBacDNe3hA01yzn5Q+Rua5J1QANP4A2XJYSknsssWDmb2FcwvFW4p?=
 =?iso-8859-1?Q?k9uMsRR49tavyncvPnzjFMcGxbwIbMEBxStOkg0k6+3kox9njLQ+zUIqMm?=
 =?iso-8859-1?Q?PDhGqNgeC/3k+Q0PWn+x2VDz2QYpZjxxsS?=
Content-Type: multipart/alternative;
 boundary="_000_AS8PR04MB82933143CF52A473CF05B0A0E5E8AAS8PR04MB8293eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8293.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d064326a-7df5-40ad-d705-08de0bcf7bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 09:44:49.5882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RR156AwbhZk9oP8tjYgd7fFgQ3ZtKmhNsQ8dL2vvVg9VXuLqGyStSStp+TWRwArlzXVpDZ24bbrYkG8LhqNCqRdvGWz0HI9IxpJGs9gIOlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10831
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

--_000_AS8PR04MB82933143CF52A473CF05B0A0E5E8AAS8PR04MB8293eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi DPDK Community,

I'm currently working with dpdk-22.11 ( also tried current 24.07) and facin=
g an issue when initializing 2=D725G Mellanox NICs (MT27800 Family [Connect=
X-5]) on ARM based system.

During device probing, I see the following errors:

EAL: Probe PCI driver: mlx5_pci (15b3:1017) device: 0001:01:00.0 (socket -1=
)
mlx5_common: Failed to allocate DevX UAR (BF/NC)
mlx5_common: Failed to allocate UAR.
mlx5_net: Failed to prepare Tx DevX UAR.
mlx5_net: probe of PCI device 0001:01:00.0 aborted after encountering an er=
ror: Operation not permitted

Interestingly, the same setup works fine with 2=D7100G MT28800 Family [Conn=
ectX-5 Ex] NICs.
Also this 2x25G cards work well with Linux kernel.  The issue is only with =
DPDK binding.

When I enable kernel prints, UAR allocation appears successful, suggesting =
the issue may be DevX-specific on MT27800.

I'd appreciate any guidance on:

  *   Known limitations or configuration differences between MT27800 and MT=
28800
  *   Whether DevX should be disabled explicitly for MT27800 (e.g., MLX5_DE=
VX=3D0)
  *   Any firmware or kernel dependencies that might affect DevX support

Thanks in advance for your help.

Best Regards,
Prashant Gupta


--_000_AS8PR04MB82933143CF52A473CF05B0A0E5E8AAS8PR04MB8293eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:92480478;
	mso-list-template-ids:1961779660;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:594049191;
	mso-list-template-ids:-66712978;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi DPDK Community,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I'm currently working with dpdk-22.11 ( also tried c=
urrent 24.07) and facing an issue when initializing 2=D725G Mellanox NICs (=
MT27800 Family [ConnectX-5]) on ARM based system.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">During device probing, I see the following errors:<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:red">EAL: Probe PCI driver: mlx=
5_pci (15b3:1017) device: 0001:01:00.0 (socket -1)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:red">mlx5_common: Failed to all=
ocate DevX UAR (BF/NC)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:red">mlx5_common: Failed to all=
ocate UAR.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:red">mlx5_net: Failed to prepar=
e Tx DevX UAR.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:red">mlx5_net: probe of PCI dev=
ice 0001:01:00.0 aborted after encountering an error: Operation not permitt=
ed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Interestingly, the same setup works fine with 2=D710=
0G MT28800 Family [ConnectX-5 Ex] NICs.
<o:p></o:p></p>
<p class=3D"MsoNormal">Also this 2x25G cards work well with Linux kernel.&n=
bsp; The issue is only with DPDK binding.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When I enable kernel prints, UAR allocation appears =
successful, suggesting the issue may be DevX-specific on MT27800.<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I'd appreciate any guidance on:<o:p></o:p></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3">Known limitations=
 or configuration differences between MT27800 and MT28800<o:p></o:p></li><l=
i class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3">Whether DevX should=
 be disabled explicitly for MT27800 (e.g., MLX5_DEVX=3D0)<o:p></o:p></li><l=
i class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3">Any firmware or ker=
nel dependencies that might affect DevX support<o:p></o:p></li></ul>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advance for your help.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Prashant Gupta<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_AS8PR04MB82933143CF52A473CF05B0A0E5E8AAS8PR04MB8293eurp_--
