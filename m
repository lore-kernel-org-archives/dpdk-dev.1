Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D86CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 08:59:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5043C40B8C;
	Wed, 15 Oct 2025 10:59:36 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
 by mails.dpdk.org (Postfix) with ESMTP id C89FA402CA;
 Wed, 15 Oct 2025 07:33:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8V3dbMHN3l4Jdn2ihssKI8ANyjr5gZqx4XHqLBUX+EH5Ph5utXfSLMjczde4yDTJklIJ0pqDBgaa+/c77FSimLIXShiIPnji+rcyog5iQJZAfmeLxtTAav+hS+DlBKllr8knjXMhdMfEF7gXmH0bTASBmeQEXJbamXLIHZ6uT/V/O9T8cOZOXFcff+MmxfWkJWIdDB46Go1NTny7h56JHxvtjA7hIpCRgo/vuc6dWhXJzOT5Wl9qSQtv5BAqShRbaP4LGLq2SeoSM3KAP27l4klgYu9pyw3Mdzj9gwdlBTM0y2g4eKUsB+p/mTJZxOo+f648vTnKRR07lyGhzn9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO2yjPpyuF75W2oo+V7biBJMle5zSKT7GlZlA7WhOno=;
 b=SnCj4x2kMutCDxyQmRjpAOctZKQq7IviwskJcPIkR4sezw6H6GaYuY7Kto02TXVrNI9jNpUrsa8WBQFmrqL3eoX1dCJjAfZ9mhIdHMvOQKhTQhThonxJ44hSFH+DNw/51YNja31rWOcxhttc7NP8NuB6niUGJr5zTyvoI8/zPU+8GHtp6XUblA3AVafcNNz8eaMvw3kq0fiEOfv5wiCrCjViGEEO659j/jUiB2aUBJXpvDNurlTudcG3eHk4ySbLVnyUb8yKF7neLv6vYe9XsbEEaTt2PXDEJ7J315DUq3WR+d/wwVdWX9z2g4L3NWPXiPZMJDzxgAIWqVCErNpUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO2yjPpyuF75W2oo+V7biBJMle5zSKT7GlZlA7WhOno=;
 b=d6uEHB2cioBcVUt3/JJOrKmQ1UdvFR8dxc7RgmDUSnLEt8WG3rAYkkxYBLZGWdbSy7Md9JurLVxJFw1/4RJzVpUxihIubGyn1kMD6leib/vOnajLuflRT9xehHJNDO/FgWfDQOaETeTWfNrFqHyFlPPS9PlZoxYvyTgoFOVL07BrJ1EPIECuiANBiF0m1nOZnjm6VUTKeEfcK0Ov9yBDMypMiP/5cXpAPsWoQbwLsWCew7hQIswWs4mEOr3f5hSOTZ8D6rQHQfkrIQfQSt1UFvrACPmF7VoJ8EApbpRQP8gj1uz1/kntPWNK9GZmHXUcdtFR/jcNnFpONzSJ3PgNDQ==
Received: from DB9PR04MB8300.eurprd04.prod.outlook.com (2603:10a6:10:243::22)
 by AM9PR04MB8731.eurprd04.prod.outlook.com (2603:10a6:20b:43e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 05:33:14 +0000
Received: from DB9PR04MB8300.eurprd04.prod.outlook.com
 ([fe80::3653:1a9d:6c55:18aa]) by DB9PR04MB8300.eurprd04.prod.outlook.com
 ([fe80::3653:1a9d:6c55:18aa%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 05:33:14 +0000
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "users@dpdk.org" <users@dpdk.org>
Subject: DevX UAR allocation failure on ConnectX-5 (MT27800) with DPDK 22.11.7
Thread-Topic: DevX UAR allocation failure on ConnectX-5 (MT27800) with DPDK
 22.11.7
Thread-Index: Adw9lCH4K0B+HWh9SYKK5ZixcnFDuA==
Date: Wed, 15 Oct 2025 05:33:14 +0000
Message-ID: <DB9PR04MB8300AD6E2DD7ADD25C0C4F1FE5E8A@DB9PR04MB8300.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8300:EE_|AM9PR04MB8731:EE_
x-ms-office365-filtering-correlation-id: de586e91-42f9-4cef-df1c-08de0bac566d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?p+8qvwNRuJpZnSBKDHg1HuBFQJjnE7biDkmt1sx7x2IrV8OPl+w7wT3bfP?=
 =?iso-8859-1?Q?NDkR408Ghem//jL5XZf39N5eSNdgA65qwBx2mB//9f31/++depGLbPWJ/p?=
 =?iso-8859-1?Q?fh9lpXWoLxMc3t/IaRchCUfsI/HWy1XbHrBhO78KbaE8rSCExdS1Qpl/4R?=
 =?iso-8859-1?Q?1IvxHOL+dG2yWD39C5HgCeog9Jg+SKfZd3X7Ie6RG28mWb1ze4M+fbNrHo?=
 =?iso-8859-1?Q?miuR79mNDhvMfjs+0fkY5TQUKN5T1gQ1l+cw8/3aYzbZ5Yyu0JvByqHuZq?=
 =?iso-8859-1?Q?qZXSAQKw5Q1rTcFXkQp40aI3qekKdQKPtjUHEncP6sqWdf4rk9rlwHOXup?=
 =?iso-8859-1?Q?Y2WYYsHaxX2KGm8Qs/RJ40FxWUBJIqMlfMEJ7jzpduEOCfrt+zNHsSv9WQ?=
 =?iso-8859-1?Q?UgW6KIQnn6h/tuIJfcFfs7gcaqFtOZ0+qz2XmvNoGlbqPw831I03qVU9rE?=
 =?iso-8859-1?Q?k7Hz6TSM96thC1hqp41NnnmCKo/JImOZ/BzE6phscCA1vAAxEL1UlS8FZp?=
 =?iso-8859-1?Q?gO6t3DLJq/NIujol7n9il5UenMSQ1b+kMfgkK3AxcGMc3WNAFUzviE4pYG?=
 =?iso-8859-1?Q?nvduacE3lTINAS0YrE0eKG3jluGrbYv0ahHtyClvHD5qkaRei9yosIXN7h?=
 =?iso-8859-1?Q?uyS4mNTkyBZn/MtL2O74v3jFADVKV/PusAhH3EmPZ51JlqrAw31HvyRY/V?=
 =?iso-8859-1?Q?1EpWEeADzogALRxXW5m6XFsefgn+O5FcykK/NcEsYPTdqUomCOfqAqqMU2?=
 =?iso-8859-1?Q?zGkz8puEpZssomS64vw2hdPmAxJ2lu67pDFrTzXfXk49byoIqR5h7cvDYS?=
 =?iso-8859-1?Q?MpBX/KQ7HLEHDDiYztHmN7T0P2tMOUNUqduqiD0KQnL9Xp092Bg6NUKFON?=
 =?iso-8859-1?Q?vzbn2QtXZjgKpkcDPlTw/LsrpJxncYVjkQO+rScdfQfLddoozSrJ6CyisT?=
 =?iso-8859-1?Q?190qhCEfnFKK4PjBFWOWsJDRu212a06GAiLiMCh/xk2srGraciFsW5pQzM?=
 =?iso-8859-1?Q?z1/bCse+zeTKeo96MyYi4SirFd5pwwwVJdXC/2Q23F1qyeaZwgNe0fm8W6?=
 =?iso-8859-1?Q?zKz+AQcWsSrBxOt9CbPNMk/syLqCkDd0HGTHdClWUA0HEn1nB1/pkWQh6K?=
 =?iso-8859-1?Q?Ebg/HueV2YMxcqraFhvJ/OOrzV7OK1ORGB1SavqzBcYWHPBZbMl4Vs0G3x?=
 =?iso-8859-1?Q?GPKWS8yseX8HjdC8xgZzhl8m+sC8i2anr7QP7aHW9UsXoL/GrZ/P121oju?=
 =?iso-8859-1?Q?KApcZuoD4gLHX0Mz2q4uGMb79gsO+goCK9+yRybTjcOQ630hHT8P4cM2zD?=
 =?iso-8859-1?Q?iWawkRzVfwFEYZ1JYj33/pBrAc0rJx1i4KVTSkEbouWJuc7KgWx611bP7D?=
 =?iso-8859-1?Q?QFCIb7oyNL0JjeZ476pHyvJcHLYqTEDWI+8fl6OfbRSq4heI0bZTHSeqZF?=
 =?iso-8859-1?Q?qz4OqMiCeZvo5o9QzkFQ05j1FquHRwZqw7D7wtjCLNI4UZdnwxNyFK8PNA?=
 =?iso-8859-1?Q?rGoJKn6F/aJ5ezxfcSzSPKG23vHSd1X/k+PJmWhYuEQCFyk5/U6I5VZkA8?=
 =?iso-8859-1?Q?unR8G2AbBnYzr7K4Xl/6CX0V03LN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8300.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jNMfjTdGE9aql2ohgte01nmwto9CiHARLiGkPIhDuq5GWMtVIeJpkZaiLV?=
 =?iso-8859-1?Q?+myeQ/cW187ST2S3sc2WcklKAY6VEVw9cUR+Vk1z12ECLkW63QOO8NmwWy?=
 =?iso-8859-1?Q?OHWXS3eWQ5dlAc9dI8fkDuJqyj9k3CzvsOHdRo5l4n3/gBQYef65GaglOY?=
 =?iso-8859-1?Q?og3UIwM+DH63Ng+ntCjhBSz7sUxI5b04WcVTSdwAqq3yyfNEE4ZtNLYoSe?=
 =?iso-8859-1?Q?ZkGl+e67ulnbeaQAsQY4FoGyewdUuESgWTCbWPoqSOEZleEUWLRaMk2APf?=
 =?iso-8859-1?Q?lRkFgonAY5cZ79yd4naOpDCjc2KFqbDomuaJaijU2UhKMrnO7BFP73J23s?=
 =?iso-8859-1?Q?oflrjKe9qd0qKChOw8GadXcOnPxfm9Egl9C81od56E7nrA8hpxPABibo8b?=
 =?iso-8859-1?Q?xU0z9aIKTyg8i7IQrrnx7rcwl5QhG9yZjbMuQeN51OrmxHTY/OhITK5gSC?=
 =?iso-8859-1?Q?BvQ2IMFcIpEtkGTCZKqEd7+MaInXcivlxy1JYtmEt43/OfGoy2Ef8vrAZ1?=
 =?iso-8859-1?Q?AflwudHZd8n4jznbLzsKQbVzLIyUBRTZEhDnb7tINDz+GPLPzYeOcrkPz6?=
 =?iso-8859-1?Q?+GqSNn2mC8+A/8p9jd88fqhbRf5clm+J1lnN+PGYbaO/2LWLX6uTdRSnVX?=
 =?iso-8859-1?Q?uPBnvwe809UvR0L6HJ/cBWetMMsmeHHoNgcD5Fh5em1FgpUwjuqPU7pv+Y?=
 =?iso-8859-1?Q?lQ/NAVjx7NIdPC1tRFfRImjtGs+lq0sW3Gvp1VGMux7mLyS7xF25953cqU?=
 =?iso-8859-1?Q?Lf2lzKnIs+Lo2DGdjuB0ILG2g+GxeYeuorsNRCmT1CbZZCh4u155UO9G0Z?=
 =?iso-8859-1?Q?wQLTR5a9WFY2FBPXAbo9nrJMPhmhGoCq7o7ynbrlI6YFqs0DAzM7tfyVW0?=
 =?iso-8859-1?Q?M1lp9papl0h/Uz64MdYxn73Ncll5Q+GCTsc+AUChv81G86/g6GEjcbUi1c?=
 =?iso-8859-1?Q?7Soj1e9bLRTZN/O783gtj36Mm8TDnRq1GFNiFeDVVuHmXLDZW3DYQm8UP5?=
 =?iso-8859-1?Q?9o8jz0L02MzlS6s/924HhBd03ur7LpmKq7DRRn4DxzqDEw9aQdoP64A5tL?=
 =?iso-8859-1?Q?k78ETs8XF0KBrOmHLRJrqLBp9O5Ppqb9a+RKvSLY/o8XV+kknlUUE9kz5n?=
 =?iso-8859-1?Q?v9cu8O1jZG46nA9cWFdquGWd85TZw+JeS0wR/Fb4vUKvP0EsXa7qi41N5R?=
 =?iso-8859-1?Q?ntoksIQHIZ1f9+DoDqqRYGWNdiuSYfQPrR8Z6LVqpYyiMgSfYOQIBO01hj?=
 =?iso-8859-1?Q?pqTV94KX4sdqMarWSBj8MsOsIaXy44NybMNQ4tjdojr3AVvuGh3ElWw+Z3?=
 =?iso-8859-1?Q?5biC/hSnN6cuzJVQGGY9+ha9JknVjrEjnkn95mhcXVT3Dxm9zISdf02Wz8?=
 =?iso-8859-1?Q?Pv26E72PPPsTqt+UJh+clux9Hd21VB9DrX4rOtuCCUr1gbCco12eUW0/r4?=
 =?iso-8859-1?Q?A0GanQQH4PnZyHQFwYkTVJN/hA8qczB1EF5+X9MmU4xeGHvxZw3i7asn5L?=
 =?iso-8859-1?Q?FRhocdT176o5uEsn1mjRNicjyqzHQ8GjnmfMhnEmAsdRwu1kHV4QI4/RWE?=
 =?iso-8859-1?Q?JrJmOstfA5ZtAsTKjs91CtclsQiOVic2d1ZgagOILQqKUTKK0w5QpXxD7m?=
 =?iso-8859-1?Q?IDw453753NhGikfKXuiUW1UNebzqHthP8x?=
Content-Type: multipart/alternative;
 boundary="_000_DB9PR04MB8300AD6E2DD7ADD25C0C4F1FE5E8ADB9PR04MB8300eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de586e91-42f9-4cef-df1c-08de0bac566d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 05:33:14.5221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRfChpaASOyIx2tdxzBIxvfon0LRgQa/JyrvAcB9yzVQ+2TjoEHIZqgpchITICEgzJvpj1bPoFKVWKHIpZSVMRZWirMsKhwcqhbpZVxsb2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8731
X-Mailman-Approved-At: Wed, 15 Oct 2025 10:59:31 +0200
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

--_000_DB9PR04MB8300AD6E2DD7ADD25C0C4F1FE5E8ADB9PR04MB8300eurp_
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


--_000_DB9PR04MB8300AD6E2DD7ADD25C0C4F1FE5E8ADB9PR04MB8300eurp_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo1">Known limitations=
 or configuration differences between MT27800 and MT28800<o:p></o:p></li><l=
i class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo1">Whether DevX should=
 be disabled explicitly for MT27800 (e.g., MLX5_DEVX=3D0)<o:p></o:p></li><l=
i class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo1">Any firmware or ker=
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

--_000_DB9PR04MB8300AD6E2DD7ADD25C0C4F1FE5E8ADB9PR04MB8300eurp_--
