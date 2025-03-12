Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93880C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 21:45:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B61DB40DCD;
	Wed, 12 Mar 2025 22:45:56 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021134.outbound.protection.outlook.com [52.101.57.134])
 by mails.dpdk.org (Postfix) with ESMTP id 0791540663
 for <dev@dpdk.org>; Wed, 12 Mar 2025 22:45:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoEwmdLGj4G5oFOTfY7mywcPz2SC0BVmQG4zydqG3QScIJU3gAPztX72YsP2j2mwBr5D8lOz0zNVkuqezfK8cLMooZf63HBEANn52lXofCubWO0kq+saGu+l9GGNkf/66MDCS1YIdWmOXZFcbhuyBVLLPEwQLTSk7YawikJCqaeST7QbewequkphqjGStP7NOj0sdtqIiaQal7Qt/1Y9ilBIjYUN17Ch6+0nXKEJYgKQvfUmF4iR+L917mxwTviCBTeSu7YaSu2UK9YEM5+G+zNpjdvNEIdRYPR0INgmNs0oPk6lxbZ2NC5vRdX4DxWe6jLp8CaGguEFtPshpgkaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3VQRvWRQZ4Fk+SIFZZeZ5zEa2dK0FcQwbJl6qZdDJE=;
 b=BMgMWFRoDgqHtWLa7F+4eEIt4O6l1+U3FBEhneDEg/6T3+pK+l1DwAto+9ckOkKdxapFECRoZrXzYpk2FTnjS9r1JoxC1DETpNsy1cT0Xe6LHBLCKE0pGH+zh8QXy+iK2tOgVllKBEEMMWCS7KiKmblj51b2CAtH47YnzMFexD0JFZ/Gs47O4fTtNBoyIPKZ6E38vpOAv6TPlva+X+Nz+8pzVaVnKf23UBcvPoynpZOogdJR/YfEQ+nfITMM9TltkYZWxHcN2kbozZa9Z0sLmJ4Jby1YRDFAfQLBWjAjS372im1bX5BAb/9uCpEkHY57mUoQTZFN3YKSatdrNKb8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3VQRvWRQZ4Fk+SIFZZeZ5zEa2dK0FcQwbJl6qZdDJE=;
 b=MNXL112CMVXjy+LBCgK1AgD3blAKoKYn8qPZLV60GjgJ3TO2YEBX4uTeePRUx6e5so3vSMyYYtZcNpjU9+rYgEwRoV0n04zgGb4SkpLDxuGOeqFaTmXsigIfw4AmOFFJ5BoFYxLmn20PaCpKtjEjYgPnJZBt5IG43her2cU7BgI=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN7PR21MB3953.namprd21.prod.outlook.com (2603:10b6:806:2ef::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Wed, 12 Mar
 2025 21:45:53 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Wed, 12 Mar 2025
 21:45:53 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Wei Hu
 <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
 monitoring enabled
Thread-Topic: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
 monitoring enabled
Thread-Index: AQHbkhMMqddCMyfSsUuQ4ghuHsMq3bNulhjQgAEOuICAAGb1oA==
Date: Wed, 12 Mar 2025 21:45:53 +0000
Message-ID: <SA6PR21MB42314991334FFFCDB1309F34CED02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
 <20250310162038.5c05ce8b@hermes.local>
 <SA6PR21MB4231702177B6AACAF54FF40DCED02@SA6PR21MB4231.namprd21.prod.outlook.com>
 <20250312083611.5d34cd99@hermes.local>
In-Reply-To: <20250312083611.5d34cd99@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6ab1f865-59e7-45f6-ba23-500697714f64;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-12T21:44:41Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN7PR21MB3953:EE_
x-ms-office365-filtering-correlation-id: 15748e0b-66ed-4364-a10d-08dd61af4371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QJjTxVwhs7xt0bM9ImWiMKe+wBlY9nHIPXgCg4HJ/ocpT62giIZeT94E5h+3?=
 =?us-ascii?Q?ZIiPsLwen5HNegEflIJtqRi2uUY1czETAVOIi57P9434MVwmR9U713asIrkI?=
 =?us-ascii?Q?wTK269AvXN31pe9irhthLNV0TdGVOuonra572Adq7pgjBr/7b9dfI2G6XadG?=
 =?us-ascii?Q?MlVVJ55lQlMAST4TDvNrvRoSysrum2eoKfJp7kx2xLjyDjH9Y8riqKNuD59d?=
 =?us-ascii?Q?keEi4vol/Isc9rp9HNMIYqGz6iDSkSnaQuInJmkRwOy8HIM8lbtkm8ofShHM?=
 =?us-ascii?Q?xUumVxFbVaIn9qpyL/VF75ZzmpmA8GXx+anyDgH4NHwzrOvs1ii+EW2k8MwJ?=
 =?us-ascii?Q?JjipJ0Wvqhp3JUuoQsk0YEPJScwKrDyHZ6kBNF5xSuJe89/p8XGvAoHF8IwH?=
 =?us-ascii?Q?cJelXvHCe73eT0mb1HMzi3v3KyeTxBTj6s52iX9CXv278Ydm4UP8f1ZjRbkr?=
 =?us-ascii?Q?AdDZT4ZiFY1f9k47C3j074o5HnHw7NZYaOFuE/mhWLLxBHmBTYkoFgBaH0yY?=
 =?us-ascii?Q?kkGJSwiDDe++nQuDWvqzSa7MXZeo1SSyWD2iU0uKJVC6SBU2/bMYM80VFVMh?=
 =?us-ascii?Q?9SUvfFQUHorXseV6k90GZjuGgD9iv+XBM6ALKQeTjhCs6uYxgYx2gLBiFNbH?=
 =?us-ascii?Q?WL3Dji3Vpgih60tnlUXv2pZkOOKAZq93K/vsD3wsj8UYB4nF0YS+8QGKE/Bg?=
 =?us-ascii?Q?IPuujxwtcsERBbhgcsJPkT6n7jt+900h0+QZ086YtOdLSUzxrs1T57gI0lMn?=
 =?us-ascii?Q?3MxJalVMHGBMbaXf9xLAvZHbaAMN7z2aghW+2taq4BUakaD1qo6yrn+5pKkb?=
 =?us-ascii?Q?728GEX72qnBTT/N2kiYqOlKbiMaSTMfG1yOoWXXK034jEp0eH6e8+8fv+6fA?=
 =?us-ascii?Q?K1dfviQjThTvCA52QySfK/XP0lI2/EzDGnwMjUgfUUWkZKH8gZJlx8P3nnz1?=
 =?us-ascii?Q?muCl7v2oi1cFXpHi4yIGlXvxs02jqoQrmgoUMvbvkqRKpgAjkrz1r99nfA49?=
 =?us-ascii?Q?vKGuLNxw/jpzYPKRHXtFz3MLcuOvFOW3QTwHF58+HbrEoe2VFvbqTsWboQfp?=
 =?us-ascii?Q?Yltra+xSubkjXbqWrt5gLJwAWpK97aoHqLshlE4Qy8JI8p4mD4A7JU7BIJDK?=
 =?us-ascii?Q?whr/d5QF56xSeda9DofNvzvzZDqlZlhWlIgfrXMB02iKY7PtaZuzj7iH2jo7?=
 =?us-ascii?Q?m7M+Pob+FuJsDiBzkJyWaKqBFF4Cme5AIYPTmacAHDQSddR3mGInzDC8y1PB?=
 =?us-ascii?Q?k1otiPhrDvIeP8Db0xlqd+LET7bVqWmX5avn6Gf79PIq5Rfx2KbaxxhceE7B?=
 =?us-ascii?Q?HLofsEyY0eStQgq3XnzyWsJVKP0EGLuxPw6Z5DvANAMEc0ELVDUsULwcoDLb?=
 =?us-ascii?Q?Of+7tceB816KoVdn0LtceQmO5UYg6js0n/+27atRLNTNPE08z/x2GRXiBpGq?=
 =?us-ascii?Q?5+hiMm+ZxAxvb9IY0t1kvt0SzGA7RqF2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L7JTa9dWDun6Voci0ncFgWAnyTV546pbITH7FLFiU+lKXgSGy7Gc9zwFPPXY?=
 =?us-ascii?Q?YptpqO6J8d1ocSrf4bqeiD1epQB0/EvcKs93e9ii67r8u2bQ6h+aOctpV95o?=
 =?us-ascii?Q?NvyBKreXVZs9OU+/LKQxpFel5Pbmm5WUmnO6quWhAuxuOw4Sennckvq+QU61?=
 =?us-ascii?Q?EKH0xERzJsYUJ18zFHy/OqN8lWaSksScA6cQn7ZVAtvWsVl1M8cuyoh6OZvH?=
 =?us-ascii?Q?ykSwKUlt4WBJmgPGbMxkZR1wSthnozGnMS6/2CJdZAu1hqRLmR/cve/dkX15?=
 =?us-ascii?Q?yyajIeAAoN1jdV6H0abmbX1nMhHRYFkIILHtYq4SUgBkxD9rPxtlJIsx6kVf?=
 =?us-ascii?Q?cP1GZAFPFz4PXxbYiSvZzdZwQ+FNL4rbUhBM4IA53ZsUwaTB3lMLLqsxqqcV?=
 =?us-ascii?Q?C5ZnxJaogrk8maIYGD9bjoaWSuDOU9KvwZ8l1qCg5m+9hOaM8qwO4InmU3nz?=
 =?us-ascii?Q?WlBsyZ3RkvipNMeHvySqYrj4WWb3NFWTtULVvrusQ7A3C8Yw9g72l1xkdu7z?=
 =?us-ascii?Q?o6WXzz4cSAmSU9l2xkusM5wY6Q0+XTNibHqDXP0ho1gI97AnfZaNKVjTkKNW?=
 =?us-ascii?Q?GQ5okgbIvdGfTJEoOxQEvaGiQ0v44/ck0Qe9sFLH9VnUXFTG5idKi9LeqZ5V?=
 =?us-ascii?Q?1g9HGfE+eROIJIX68YiRf/JxZWoZvR4cwyO8nO6p9yhXWOWwJMyEL7aQXLBG?=
 =?us-ascii?Q?lzIrnwk/1sewV737pMxLJk0ldm07W3R9P0MdtdwIbXB2OzSNiP2TdkElNFon?=
 =?us-ascii?Q?6rP8rNVDwQrhxMj/UhbICzszay8evPN7npPvCdd9mGxnHr/oR/hRv0o/JLZp?=
 =?us-ascii?Q?0payxc+NeLmhp8bniphCUc1DNHSyIXvqaHTBiV+0/MomL7AVdS/De8zoqNew?=
 =?us-ascii?Q?oF8DK4C0hfbkA/Z+5LPECNJKv+UnOOZx77Qx1QMBM3uvpaTJtQnLDbe6ppgg?=
 =?us-ascii?Q?1+aITEAlG4IIjSez3yw5bDQHRkU7UcT8D8FEsMrXwI1n1cRVv0pF96tjDnAt?=
 =?us-ascii?Q?HvZ/Br9iKo8J/AKne7DnuypKiUBl0PXDutJvjZrBF2d1ir+8oxLCmX24j826?=
 =?us-ascii?Q?PmKprdJqorfxVkaAOmixVHmRvgbFhL5Zb2HdICXJfmMdcjGH9pyPbeW7HHMs?=
 =?us-ascii?Q?v6wXG2/gUdcUVmVp7Ujk+5pY0JsND5jEOvqqDxVyvuArpBiOZ6+oPMiKA4aR?=
 =?us-ascii?Q?TCFm2ExwooZOXTXV6zdJFh8fMqXwTWzuS9lDafjTrrZcVFbTNBY/4Rhf8vnj?=
 =?us-ascii?Q?H6ArbemBGv7/3PAITUbHanonF26c1jufYZus+7j4EcoQ3+s6hgMzRL67Jmxz?=
 =?us-ascii?Q?57c6fcblnHgLilempqOodAKxtzJ3aoZs4FSmJrmSEnqMvCHMMTKWrrFZ8Yym?=
 =?us-ascii?Q?3NlX4Ucei6usOXYol7V8hf79T6NC3nB1I7+F5+W5IuWQC9ydmrLvW+52Qy+X?=
 =?us-ascii?Q?STRqmHsELO6ECGYQFDpPuwS2nJMEdTlbMPNX0NXYfGy4U6A4vTf4hIS0j+qB?=
 =?us-ascii?Q?SMv89iYh+zMG+GkJSyB6bU2RByCSezFKgXeM2eERnEoxmA3rKt85b7097QQH?=
 =?us-ascii?Q?7JOS9dUopk3U9TMnMJKJB81t/96WS+MskZSZSe27?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15748e0b-66ed-4364-a10d-08dd61af4371
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 21:45:53.4796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yg9JNeBgxwFpjyyEW4hFKySQjOZUgtjjmdYzjOfqz9bXMYMdOExeQ6x1dW8LDS5NEG3tPYpms6u2wVsEqUa/Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3953
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

> Can't take it as is, here are some options:
>=20
> 1. Version the API even though should only be used internally. Use API ve=
rsioning
>    as transistion until 25.11.
> 2. Wait for 25.11 and just fix it now, and do deprecation notice now.
>=20
> 3. Mark the API's as internal (in 25.11) and do deprecation notice now.

I chose option 3. I have sent a patch for deprecation notice
https://patchwork.dpdk.org/project/dpdk/patch/1741815831-22977-1-git-send-e=
mail-longli@linuxonhyperv.com/

Thank you!

Long

>=20
> 4. Make new functions with different names, and mark old ones as deprecat=
ed,
> then remove in 25.11

