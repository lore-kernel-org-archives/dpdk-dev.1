Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C56BC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AE1440E1E;
	Wed, 25 Jun 2025 13:51:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id ADAD040A8A
 for <dev@dpdk.org>; Wed, 25 Jun 2025 13:50:59 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ONvZdY022124;
 Wed, 25 Jun 2025 04:50:59 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2095.outbound.protection.outlook.com [40.107.236.95])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47g5r919gp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 04:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njqz7UkC/VSaHyPl9v+5cY9OKKSbKjvw3E1e0fNgIH8JDclGwgYsDcs3g851Bfr28D6ocZdpdFIOPignElekEtvytluGpDOUXd6ga2oC/6adSKg/9zjBcTxdiwyAt0hwbudPDnho3HzTodWhrWeNx0Aol3TM/oSKGwZyMnmnMx3aD26uTgRDB3PYBNRbUiewfRhxgkydv3tMPIkfi708x5JwVGVL38ptv5gR6RnJcmzfrsQQ5m1KY6CSrIlBBjBtWLu5M1Grx7dyk9y8Be41m8iryLyF6Ydd/wZ6vJVZA+j390epql+TdyQbyeyVF7MmWTYk+EZLnPfxEHEzAZEE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IcX/6q8VIgMv0uZsKYS/xCMJi9ZoVg/ceQwfstmjjk=;
 b=envNeWOCwZNVYUgh/QTlOEqfEc9iwzzqyCTyqYdQGdZe9fcRLet4qwkG22jjiyXyGB/XblVLcwOrTa0294wNNXwT/6r2ZwFLWebtNer3DOCFqqulS2iRSxiU/koIudLB2C4FWPO6VRgeykhKpdm9vKOVQDs9AtOiOZA8OU77fgG2JboP0ZnwrzkDNVE6E3Fx0vDLZ3JV398/kz9QpSl1DkuuqmCOL+/cuxO608liUdnjbZs36Sl9Zal25WGxPzcN25OO/hUVDiaUGEMy7CHwDuNiO4fNoslr/Pzw9u7ZPq03YZWaXZz+/N8XMye5sDiohPrPLYfQqgjlacijYc9jWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IcX/6q8VIgMv0uZsKYS/xCMJi9ZoVg/ceQwfstmjjk=;
 b=gLQj2RkGHV/Wr4Dwwpy8Mgau+s7E6fLIfzjDmDH0Eyi2W17PbeM2oY2cSBzz9I7mgr/TqKVkpJv5/lBTDFWoIV0Iba+0w2w38lACxW1sfewmJTj6NQ7kYuBZ+vOaA4B5PzGF5eskK9jA4odb+gT+gLAVRc+o+K8M0Gd4hU17kNk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5051.namprd18.prod.outlook.com (2603:10b6:8:43::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.27; Wed, 25 Jun 2025 11:50:54 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:50:54 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, "fanzhang.oss@gmail.com"
 <fanzhang.oss@gmail.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] app/test: update EdDSA test vector description
Thread-Topic: [PATCH] app/test: update EdDSA test vector description
Thread-Index: AQHb3oiqtlgGOScRj06P26Oz2s/5pLQT0aXA
Date: Wed, 25 Jun 2025 11:50:54 +0000
Message-ID: <CO6PR18MB4484C107229C38DD8B905493D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250616063350.2507803-1-ssarananaga@marvell.com>
In-Reply-To: <20250616063350.2507803-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5051:EE_
x-ms-office365-filtering-correlation-id: 0bcea055-1a8f-433e-ee94-08ddb3de8a80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?o9ZTrTAUGX4ge47M/GzFrh2txqclnqg2YhIkkoqFFYvWPrjc3TjWDk7MiGvc?=
 =?us-ascii?Q?3FrPua0ima2J1ql0YDCTqDIlU2DWKiJaJjS+sEDxKiNyeCCuCBAqUnR2QCZm?=
 =?us-ascii?Q?EaYqdmRsnUDsWQuP7l/xrzGY7W9MiOLhq/uYC9idKYWTbygJ49mfjbIPi7mL?=
 =?us-ascii?Q?JlSdaWcOF7nbbC4AAS85uv7VJansnP1xokahsgv+ugrcj1hOZnFfnkS11o/x?=
 =?us-ascii?Q?eBKZ+UEKwe+wrh2v80NVjrYKPq22ajLOEChPVD9QS7Vln5KJYUW22TaHvytv?=
 =?us-ascii?Q?Sftm6NAHmoJdanBZHApJmcsrZz22PsFpRBvUDPBhkhx9wa/7TSl8XX58xzvD?=
 =?us-ascii?Q?qaYYsCYAsiElBBatWAOKWRqOnk8m9P222xxysHNjK3sq+cozfYsN4/sUcim1?=
 =?us-ascii?Q?8mgPU3Z/dZOzHUG2YQvqmgqa0KZizZxwAVVQOb6TR1QF7Z3Rlht3QqDGANrL?=
 =?us-ascii?Q?lYhZ6feVMraEu7bJXBZ6WV/nP/za5GVCjY28iW0TsejLT6yDjQtKicRKu/gb?=
 =?us-ascii?Q?icWv9GVSHFAbnMmy8q475Bh9noT1QZku88nqxcioIEMgWNEGR9Z5v3E4O2Lg?=
 =?us-ascii?Q?aEfECmI5p+mzT5tbR3k5Bl2++ekWkSx3lSH4VPZfYs9avoUedMpnIMJcqheK?=
 =?us-ascii?Q?dHaD4ya6mS2kNtlqxrJw/v/FFvymUCcybuKWsxLk7VwtK06kC2OPtPkR907G?=
 =?us-ascii?Q?FuEvd77bRbf31YB9LuISJob1F4P1O+Lamr9bAwNhh0XfsmXiTlD/0iAdp4Gt?=
 =?us-ascii?Q?/U82LK0YADHAiovA1jRoTnR2+TraKTNEZhJDimf028tZxxEzmEblq6+vUhz7?=
 =?us-ascii?Q?tJF8gi0MC8HwO2a5KjX7f5LvhS8CNeyFz3bUIuPpCUg4Wlr9ewh1E6y0D7VT?=
 =?us-ascii?Q?/kd4A28zwdMtr/80reP666VXK3OdQc6IRinXYSGjME0P22fUlmOzwiRYSXqy?=
 =?us-ascii?Q?JpUViqn3SHnbbA3utlK+nHdEpA8UiZrs7gtxPwoEnYEPzotTdYU7hZYSgxjk?=
 =?us-ascii?Q?hMNV/+2djPikZVPI1WNx+HeTF6lzskgoWd7vPkkgDF0IkOHq1PTbQyBGJ6fS?=
 =?us-ascii?Q?0+um2XTBrSVNB3BWvI9j0C2d7IiRFrOHmJs38PFlTQbwdVuvnm/ZbV9yzDVk?=
 =?us-ascii?Q?B+DYbSX+QIfbGPaUTatWaoHpmp9lwJzMkZw1sOix29dFPLd/JdHr3DM2L3KU?=
 =?us-ascii?Q?RAZYsqwaCZzhEci5rAQMhpUBylE0LYcT1pO4/Y+mAdtenmNiYA4t+w+jDOEi?=
 =?us-ascii?Q?7adV1jxnJaigkOA+ucqXaxZTZ3EzHFE5u9m9cyXzRI96Epugd5b+AEkddnfP?=
 =?us-ascii?Q?goy+KTiC0ut/6hSyniPtvyy36xp4KVZYg28L1V5TgFS3Ih+IzLQDI6csGwBD?=
 =?us-ascii?Q?pM59z/3TQuAJomKtIsqVydTwxr9BhqOkQQWC2GWN7ndcWIhBDVK2t5X8kEyX?=
 =?us-ascii?Q?VTOSnPtS+90/j0MvsvjuDx9OLX7uGCJNkhw94yUuJ9EFdHFz60dnUwcuzoDx?=
 =?us-ascii?Q?VCg3zdubCjsqsCc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nH1NKmWFSyISlz2j5mXT4QjbMQ5p7I2ml0gnNMLerwLiiMkFiGRq3f4YlP/a?=
 =?us-ascii?Q?cixQlucDYku5frFISxODw0JmQVq5fD14RjGFwTK7M4t+dLMI40mViUVevpo5?=
 =?us-ascii?Q?262lMwQ+7y289eGuTtBPKSpd5fMuYXFkrfCz9GBdrv1P47OCJ1MMCdjO75tE?=
 =?us-ascii?Q?uZEWihQov6FvkQeQ5+sn3hoh8vWj+qC7rAvl7OEXDVOTgATEhudlR5+AJnl9?=
 =?us-ascii?Q?D/cGqenxKR6opEFeX2nVz2QRYEaqM7l8SjHmPqewFIDzWUwV5STGDh6iNwAt?=
 =?us-ascii?Q?1SujLbol44TCh3kdX0nkIgb8kFw7HzvkwwVOomVITt0WynWRNzZq2B4PWbMb?=
 =?us-ascii?Q?2K8XzuLa+sF8J1Y1V8WPyl6Ul230XWMg0IGiTO08lHzdbH2tNrqVWHiOb1hq?=
 =?us-ascii?Q?w5qbPV6XpLvNXeq34RNBkaofjzS76JTEPkTAcZU2z/FIO+teh/ky/rbau5uz?=
 =?us-ascii?Q?Ze4GsZ8gHYuDiQwUl449s7m6sp4YzL3tiZh1B/tuSM9TgoVWBwfS1AZJQwKh?=
 =?us-ascii?Q?l8hCPPRgAtLyXEYu41PmqSzl2+sXMaga/86aLc+E9G8p67PQkm6Lr0MRuRLC?=
 =?us-ascii?Q?ZdELFkknF52lbiqAIZbcTv1DemZjjoiq24XjYOG4vQo7xjNGSXWQXW89a5ni?=
 =?us-ascii?Q?D/k0+lBwUcSymJkufyQIAFV26e8NGkEJq1Bo9nyR6vPUXmTnnmSaxDBrLjtm?=
 =?us-ascii?Q?A9ZR1XWE1NyNpJP6UgcEpC6kdu4RSe0eVHbc2AcIu551HbZbJbfaCzPNdctn?=
 =?us-ascii?Q?RRS0B68SxioRxWIItJGOJEbj5uoUA2EO4aRs7QZeNbKBWAi6XHBKjuDLCFsc?=
 =?us-ascii?Q?BPzm6bWTWnqwW98J30wUQ4F0A7pBKWWILem+njQeTqQ8w3hQ0YGYeEYO+rj5?=
 =?us-ascii?Q?XgUm2r4AL2yZmku673g6/+JuM9m9J3lsP+wg+af06SZEm5kkwuSv2vyCPrG3?=
 =?us-ascii?Q?EQe4djZJRBqJqANfSldlNuhmPGX8JtZhllTkCf6hJuiPzbaIWvFmF4GgkioO?=
 =?us-ascii?Q?3jsJ54cuqEtmXPGQnZfEyqV/gJUneCAm33/nzSlcyt18TIxu/xl4MNLr6TBA?=
 =?us-ascii?Q?V6/TJFGoGBDsZrbukp/SmBJckpkIm4+zVHWyR5pwFUt0vtB5TPuankw2YebZ?=
 =?us-ascii?Q?W6ctXymV48duhfTWwMDPK4z9S+JJtPAholHblEEHPCMxGj+1gL/mjAONYCEn?=
 =?us-ascii?Q?cRP8zeSxO0HqPH1qDlG3sALbyR2T3JJboz5ZzxqK2f0Txz55dTPD4gaLobm4?=
 =?us-ascii?Q?3EQhJVscDhNJnr2k59gLyJ3dQj4Ksh6Bx7sW/VMY7uZkQcneRf0UvOiZqyfJ?=
 =?us-ascii?Q?Nr05Dq+p9XXKJzOFTsnrL7iq80aiua+Ba5KrBs4kWbsM9c6lsI5wmNoS4Kbp?=
 =?us-ascii?Q?CTCbfLWuEr1tvUJcgKHT/9TrPSX8b526ZBboZ/RSISdSkYKBbQH18PK0TQoG?=
 =?us-ascii?Q?o8HuCkRN8kuHha5AJKk4L/WzicHAxSmxP8eK1abEpPdtm1MwpR3To2jfFyKk?=
 =?us-ascii?Q?Ypl+dNSNbbZ7atpT03wxZe0c5iJE/vMbMa/2BX1vWVU/PjW7I3GMOoooZYLh?=
 =?us-ascii?Q?0oVvJhexbXL4mNB/caEE/TJ49P5HO8AWsELvLVKj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcea055-1a8f-433e-ee94-08ddb3de8a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:50:54.3748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4mdEQu9DXpnFNT7C3BdEhQ7/TF2lajLCEkivRn28Rn9j01hFAuTkgAUBvHyA3u+vR0/fcaguBQ+nB52tDOIGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5051
X-Proofpoint-GUID: LuQYp3gd0qkYZJXH6TIWUjDiqcOKN3gI
X-Authority-Analysis: v=2.4 cv=GYMXnRXL c=1 sm=1 tr=0 ts=685be2a2 cx=c_pps
 a=tuM2TBo6X2LIU9hvJTieQw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=bkRVta9s5dGMsxqK_aEA:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: LuQYp3gd0qkYZJXH6TIWUjDiqcOKN3gI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4OCBTYWx0ZWRfX4OTsMhO6T/9I
 tK5hAq0qu3aaJajJcOyxTXIFV48hRnqNFR0ZkIK7tMnNSsLOqo+zMBu8kwRKYrYznSXM3HbHYDt
 ZzW+eEAH8BIOvAk4q85aiNxG5Qx6F1QXYsSWsJshGSY8HFPZqMiq/I8sWJbkbNJ+dRS66kgI/nT
 /dRYrMU3bNmG+C+QdjdRn57ZN2Dj8nwelLtvOXW86Xb5WrfK4XwCE/utnQsFjlFMXYGyDZgl1f5
 0DSJQOyanVWeQQ28h2gGPG0NtjG0ZvCQvEWU3NR6DvQp9V/9MJfbOZNQrjq5wuR8iB5Ones5ray
 YRcO3FJ7DApv4F6impzUYM+7kaQ3Q+ZL0n+5vzjBnFMKzfT+md/b7wKA8CqGJ/6W0eGEzPHLuKt
 e3hXqiwS6s8XFXy6dIj99rd0AlvGM4bFnsM+r0gbD8Ar8L/OS1kY7QlIKPayB9Hz0wGpjFRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
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

> Subject: [PATCH] app/test: update EdDSA test vector description
>=20
> Changed the message parameter from 1 to 3 in the EdDSA 25519PH test
> vector description.
>=20
> Fixes: 2fba5232e77e ("test/crypto: add asymmetric EdDSA cases")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
> ---
Applied to dpdk-next-crypto
Thanks.
