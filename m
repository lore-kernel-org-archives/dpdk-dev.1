Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8FCC7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB84540B8F;
	Wed, 25 Jun 2025 13:50:16 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9152140A8A
 for <dev@dpdk.org>; Wed, 25 Jun 2025 13:50:15 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9jjxm011055;
 Wed, 25 Jun 2025 04:50:15 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47geryg6uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 04:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRJXr9ZVSxUUHGuE2fGe1kiHBxmnYqwoAWZgW8ApLpXVdtwqG6w8TOPF18/deD+OCZcXG3YJv4Yb0QdtyVZUbEPFCc2KN+BQd9rM6aEnMhWpJgFz9RaawuxG+IHsqer7CWi/5FomT4+RY1k75iuNsN/GNB4j9/LRbtjRfyPvdxpCci4xd3SGmBfWW0UM5hBQHPn9h53Zya829mKmen9D4ktlEBHnoRzxjEoOP4uS/4E4qrifpw46TCMMB8PdOQ6fqlqaIZX1+M6+5poVM6SV3Ow+33qda4FFaZhwGKutwf29Snp8qIBsLHJV04uYMB7fvkWupcwYxgmmM6wjRTAJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfA1nnxp7yjFYa9sVq23V/WE8OKcfX1dCmp+NSjF9aM=;
 b=as7H7qaliPf8afCpkCy8xNNqRl6+EawB4ZY7JTOObVhe4hO42mwo/o9GyMnRFZ9xCk69ul0Dgl8AgZD3LYpmzF4lUpOVeLGCWktqpWHm9AQJE6AqojikkFWZqvsCN7ieH4i0ifRU5bMzEcBZRcRLqHphNnNQjYc7ysttS20bucltbTEyscpo2jen84D27M53BP2LzaP97t2qlEk4wJnJHLr6b716R7EJo6iLsLdz/X/ry8Dz1glUPMiodyiNO4TKfJ+j//g3KwuWwbp1PWksyOmxjKrqbZMaEVCErykZQTzZ8qddOEiYau9vFtVmufnnydcgKPxyflAq41aUWZUzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfA1nnxp7yjFYa9sVq23V/WE8OKcfX1dCmp+NSjF9aM=;
 b=fRZKst9kdy4y5VQYMcKALXq/z5L0aKBC5QlI/KNThuiw7u7ZKe9ZpQMVaox5EaI8Mm07xi1fKKzTMpDXr6aMB/KJpw79P3FXyVL49+JE6e49QtxIzI6qY3yl5h96OWiEnGj6V0l0BbJQePRCMscFh1N2UyFAacZ7WoAVwVbbkC8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5051.namprd18.prod.outlook.com (2603:10b6:8:43::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.27; Wed, 25 Jun 2025 11:50:12 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:50:12 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH v3] app/crypto-perf: add support for RSA decrypt
Thread-Topic: [PATCH v3] app/crypto-perf: add support for RSA decrypt
Thread-Index: AQHb3oQVVJEWosX2F0KmONM79xBKfrQT0UaQ
Date: Wed, 25 Jun 2025 11:50:12 +0000
Message-ID: <CO6PR18MB44849422DCFB8C838757BB9BD87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250605092404.3882473-1-ssarananaga@marvell.com>
 <20250616060103.2503415-1-ssarananaga@marvell.com>
In-Reply-To: <20250616060103.2503415-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5051:EE_
x-ms-office365-filtering-correlation-id: e2eaabf7-d202-4ac0-adba-08ddb3de7156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HSYvBcrjWRJQyLV8cj6BmDVEPnO/MqXDZ+XrHMme4DELl+cWsDcMWu+R/nIo?=
 =?us-ascii?Q?rC4ZPTgLOoIKWuOqt6wIPO3bhU1Bi+O5gVX9fb4eZy4cuUHiiePRTk/LYL2A?=
 =?us-ascii?Q?/Vu193A3eHFYwetYWjWUqIN32Km+YbMgOfJRLcj3cBzt7QFYuQPGPmQ1i1ep?=
 =?us-ascii?Q?kof3YU95UtNpqHGbFvmkEdmWU9xc0kGfMlP0MhHlTq40e9rI2xc4EOBYGa92?=
 =?us-ascii?Q?lopyr21anUMxHahDB/kuZ7h74jKts8OT7Ir69jr6qs3c+goRthglBRU7Du++?=
 =?us-ascii?Q?3m1F0uUt89ml3/cZ4dQEChp9nT4IDtP+zB4Uma05GNSQzsWn4C7al/cSE5Bf?=
 =?us-ascii?Q?XNySCn1VYsdi+vJFeTjw5xh/7OcJ/T6P1xvhbo88yk+8j9OCGB0Wh7ghZLhm?=
 =?us-ascii?Q?PRXZQz6HSdD8FZaJ0d5/2nvP3Dq54B/0a0+pk8VaBDY5x9EFDS2wXOiN64Z0?=
 =?us-ascii?Q?GnjiUGIEicuKwzohnsgcrm8IF8K7aM9KMPBSppsC8c3rU1rvqFjrGn47Tire?=
 =?us-ascii?Q?gSXxcPbebPFMbE0lNW+cBsBjFS+zw+TJie6BNEPd4BTIo1nOlLYNdtflKoGo?=
 =?us-ascii?Q?2i0lPfYoCAze+dv5fsgPXTFVmGY1PhHV2hP2/m/4Lb1xpkicShjBW+xjm/0E?=
 =?us-ascii?Q?71wOwkq3SHwvMb+jO5AiDwA+AT365YsvnkTqlK9i7gKH4QeJd2vDx4FnmHSg?=
 =?us-ascii?Q?vFBSRIRw+DTbVguDhIz23S/StxQwb3FmNHWFRT8hOzx7WRvmZ/1WvfMl4Ijx?=
 =?us-ascii?Q?sSNqVddbO/yDbScjlQtxQ+klVatlcOiuBAQHlk1vNnWMIdNrEJzFEGRwF7TB?=
 =?us-ascii?Q?txae3Hg5lwji9MKlJX7b/hsAr3JYD0rKCBGUi9ztdvkC3ixrGyJSUmC6b5wo?=
 =?us-ascii?Q?ZmlpXU2c+8eJ51v5MP7hne9EPjo6GQjr33O229MLLbz4AffYzXWSIZs/teKk?=
 =?us-ascii?Q?gDeivyyJN2kQ94MgHDD5VL3QBKIMo1bFSqLoHK9UTw70HLDV1/cm5sozBbbP?=
 =?us-ascii?Q?H8VoBOztHhruGB9SI72Ud9/gCmO/fvJkf/X22ldH3NURNm1hU8Dp4M3YomXD?=
 =?us-ascii?Q?uw7VkQkXGHrZZCpWcTMY8M5yPY+IaVVKlMmoAREs4rx4vDuCyU0GzbN9kYZI?=
 =?us-ascii?Q?X0erFpPCK8q/Z3xVluQxJKTJ4VRKeYgoJFD6zPtJdK1oEtfDevXuYRSV81Xa?=
 =?us-ascii?Q?lenSv9kl8J/a68Xtaqa28mFVcE/sbwZtvlclmk0HNUIL5pIcFHghoIWnVrVA?=
 =?us-ascii?Q?JzKa9mGhCqdDkm398ypcLj9Vg2mNMIVWgR5Hu1pEzS8wlQKh2MkTqQWMAIwS?=
 =?us-ascii?Q?ul9+1nHshVswx4G9RrLPmX84/91CipghRZPL0qDSIoCKQxdg/gcWrXI5CSOG?=
 =?us-ascii?Q?dL8vcbOWkCT0HWnaGjcDSwOZxpUq6JRBkwClV1uWuBbw0kDKtrgt2f/CGhQI?=
 =?us-ascii?Q?vrXmFwol1xQ2POJuSEclae6PmfJ9jO4VAC4JbzKIz5VdUMryhQ8OWuu7jdIs?=
 =?us-ascii?Q?surxb2Rhg/9YueM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6g8G9fomitmTID7LUpFbzaRa8Uj4iBWRHLlgBcitQpAxHqA2NunmVcrwVE+w?=
 =?us-ascii?Q?ZnJh0wdKxnwuSn9+yZD5c4mIpNR6L+NDDJeYCfawseHz3MdwCOj+n2jlU7Cc?=
 =?us-ascii?Q?I+Mfk9T1EtbqOulsWrvnUukC/R7sukS+0DI1obsMbxDfTYERypXJb+iHIkcG?=
 =?us-ascii?Q?apr1ML73h0lDZeFfkCy1d6KszKioGQ6zoheTKhdnHpcXdgoR+veXtNouIMhw?=
 =?us-ascii?Q?xM7+O06naWbYyEm9hoJYjaFwALWtjmdDeznXoDuvBAIkW1anY9VEKyjHwF+P?=
 =?us-ascii?Q?A1yIk/T88TkcEFgtTWAYWTfooEgLwY01TGsa6bBJCAc8U3ETE/tcBSNTjKy0?=
 =?us-ascii?Q?Md/QcNGHgfeQIVVdyoTMHSmSWyHRL2TmtXrXxooV0fDt2aaYrBs0MAXI2Wp5?=
 =?us-ascii?Q?XOtWHTGPCeo6CzlwvVlGV/CwT9SpKv+AElu5b2vBNwApZOd1bfzV+V0jME8I?=
 =?us-ascii?Q?0l/Fpn0jJHoWefi239uCW4BndHMFRiX62UO5FXSaZLCdgYqmoK9OpD3neeSL?=
 =?us-ascii?Q?BrgF5Wz0BjxZ+/+vs4Fd/X7Y46Ghsnys6TaP8ejlxouh+4EbKCliYTxko3Mh?=
 =?us-ascii?Q?7sUVs5xzjmTPDA+3Pji/26c9H/mdwsw3cypmOL0/iMU4t78Zu20DC25Oqvrz?=
 =?us-ascii?Q?NIvHNxh+LkEJbtoaxeRKZxdEBCX7V7S2Vq0+qapr4PholWNHJKlvGK+ZJD0d?=
 =?us-ascii?Q?Ydp8T25ozbBgIqqoKCyaKZApk0kKYNDk55TCNbmw54Zw90yleVqyuOCqbswh?=
 =?us-ascii?Q?lIdN8b86Ce2DTR3AfZgwEqfhjjG9gesSAYPBzxwAUeR6ZHXBsCebqTUf/KQi?=
 =?us-ascii?Q?McRjeSEzXmt2EJ1rldk7qTO9gLLrw3d/kwViRp1p7vdMB8OItdJ/QAA0TRiN?=
 =?us-ascii?Q?YHGv4ddXAALhgwCFW+HM5dUiDj+hBQVWJyJYEy9DyxQi9AlotWl58XxBjUxA?=
 =?us-ascii?Q?6EGgfktTun5z/5Uj+QtGhLsjL6QEsBijHQi3ahbMJof+IHWbOU3r8cuvih3q?=
 =?us-ascii?Q?cLcbyq0WH8miOR1PFPOfMXw6/BvC2DVhYrat8NruKNYP78bYjao+pyeqUpkg?=
 =?us-ascii?Q?v8+fnY6ujBAk+T3LVQW2b3ATsKMnQAzRxHTiQoCKhv1Wig7y8wTiIwdtx0SB?=
 =?us-ascii?Q?hS86VOzmEAx625nsIrU9D2bwaARwoh64G6gzghJPr2aO12GsdYVgYykuHXQX?=
 =?us-ascii?Q?j6qxnJtzmKUQ8RCGNOXaMSlWv3OpoT2AIBK905mOSrteqkdyTFtw200hSzlt?=
 =?us-ascii?Q?16jdv4zHyJd7mhXC51H3Vkj6qKJqjEirMo8/oDKdnYqXgvNAg10VXOaY8nCR?=
 =?us-ascii?Q?oqRtbSFSNxVu6jk8bTZP0n8wsmrcVyIHg9Qmh7Z9UmI6/nT6bMFkyjYsxg7t?=
 =?us-ascii?Q?JSoSb9MXANBm6S0c4weCln1wQXIHZqehpq5PbvAwNRpgAli2Q5krnQtlD1ek?=
 =?us-ascii?Q?TNOfzV7YpuzLGRAbSrhm0KK20ENTkUpM12w56iwabY8j6pyRyGlz2dUeSdFH?=
 =?us-ascii?Q?dMLveQGIjjMuOi/xYr+5vEVuCo816ISbGe3pi0Z9Ms5OvdfuNs8z9hK3zDVT?=
 =?us-ascii?Q?CGACbrm4TykUXsuUX79DG/GN3KRbcQdSeMqJH3HB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eaabf7-d202-4ac0-adba-08ddb3de7156
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:50:12.1599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/oy9xxvkAHlSfoOfK0omaDvYirguobdGkzGJwKwlV3wWJ+zvaaIGDg3taxmmhw4yVZrcMw0jP/tq+hG1GhINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5051
X-Proofpoint-GUID: niqV5sD8oLus4ZvYtJCozebCgXy_Xkr8
X-Authority-Analysis: v=2.4 cv=d9D1yQjE c=1 sm=1 tr=0 ts=685be276 cx=c_pps
 a=SfKpAED18FmY9QLmYdbp3w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=jFb2w2hSSHAPNlFlsmMA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: niqV5sD8oLus4ZvYtJCozebCgXy_Xkr8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4OCBTYWx0ZWRfX9LXISFweM/WC
 X01jF+860oFphtaju0+r91lT2ncug5W5gqLUoTBbAS+ycNTHpc784JLOmuPTa3dffpCcUXDR3bE
 ZoT7spilrBXo1oX/lPP4CgTWdl4WIbc4QxLMEeXxeOx6saHYrzTJuf8fmoaYTNPev7qWWTGKGTg
 EOWtJ9CahENvox9tQpEkw+gFlLBqQNiDkEcDggZfuwoi8Lpc1Ih0JglpNpRxjF2KmV84/PHlyyf
 xZZYud9tKNrQ1LYIsYj/ST3IHWd8HzL2BKt5mOxTYNEun9Skac8yuUHVug+yGVRnlD68SELhAr4
 o4404bdY6GfQ73ieLNCJYThssxJu7xSb5miUuj2w8e41JpNSAOaB1Op7ofsXJZRkkV+qI3O6S9g
 7vAq2T1h1p7Jmt2UFWSXUw/FyN3Fzoow0ppg30AxnvZXcdbCtJDg99xKnDd6rPP5+pb8OaNY
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

> Subject: [PATCH v3] app/crypto-perf: add support for RSA decrypt
>=20
> This patch enables support for RSA decrypt and verify operations
> and added cipher and sign test vectors.
>=20
> v2:
> * Added macro for buffer size
> * Fixed RSA sign buffer corruption
>=20
> v3:
> * Restrict default public key usage
> * Use a common for all RSA crypto operations
Change log should be mentioned after ---

>=20
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---

Applied to dpdk-next-crypto
Thanks.
