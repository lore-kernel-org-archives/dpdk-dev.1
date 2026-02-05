Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BA4ECD99F
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 20:25:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9A5140684;
	Thu,  5 Feb 2026 21:25:06 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by mails.dpdk.org (Postfix) with ESMTP id 9D5A5402BC
 for <dev@dpdk.org>; Thu,  5 Feb 2026 21:25:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcCtJ01RBiPxM/6kleswWAp6AH8h3682DlnPpCKTo9Kh3RuHPvQrJf83mJkKGCEJNLXM6THrHbVKknOBOp27iTb6624uHQGcQmXXUxkA4o+RKq1XNkfE07jkc+/EKN4ZY8nMQHhBAy+66gxslc6FGqLfnW+HmjB1Wdyjb1ytST+TJD1zX5lKX8G+aeaU9HWAC3IfhPtgQjltNfkSy8YH8sxU8F/6lDsaZ05ylMt51KbCRhwqBpEXWUCdQKFxqYrmVCIaRxXe914YZAjDGePBFBqzPY7kOO90p62+CLjLMOWJDpMdHqPgDRpzQF6JXHqfSXrkcyIMHhhk1dmOs60oBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIBdwy3A2zCI4Y5bmjEWwgFeaXzG+cFKJx8H+4/s4kw=;
 b=OjOdaiQXsBpdnkz03RV9jfmkW6/sUfz1/xIKkAPRiarwUeBM409AN9cR9OCMrHjZ7ysNwFXzv9b3Lcm4KqqBjqDAwWOyih98ARlVuAaKOD44x0aCfcwErDLyZkTFbZTN+vVU7EcSBGvhbzhqSO1Yvm2gZpfMgjPEf93Z9ecRp1IpwepSbOADDe09sn2KoIduRAZowmQWDj0Ewm4r78cHYROr+tn1r1IvB2YMR7BOJxefjGhzTyxh027z7cMKsFx16hPUkEs+nNaF/oxi4oknYB8/hg+HjK6gtWfw/XgapbHring9hAJc9jlRR2bVV+K3eq8JcQqvktXC/9MGLmrC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIBdwy3A2zCI4Y5bmjEWwgFeaXzG+cFKJx8H+4/s4kw=;
 b=MCVjpYjzeLk2noe/zEI4eHOHqk2a2taDEDV2ALoRu2DhLqEbIY40/HN9zJPLPMrKQc2Ce49XJLuUHbM+Vg56RXzRGVsw+9ikm0UyO87igxb5jyNMHObjG7SfWdHcvbz1RRM3WO0HF5/gWQsRr2Ddq9Ws9NwWVDEqJp1xfSLYbOFRYhzK5nsyje4Vxy73PvjXwe1CxXPJPtlaZCPnCQYsFhrI5WVrUCV507dMdV6SLWFNAruI+sW+Z/E17b70wpWabAPACp0gXtUP5x8Gd4gpQFvxAtvzuP1A8mMFaWut5tGm0WQI49yR99rpMnZt4vK5pypDeYGy9WVdYcl4Axu7eg==
Received: from SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Thu, 5 Feb
 2026 20:25:01 +0000
Received: from SN7PR12MB6960.namprd12.prod.outlook.com
 ([fe80::faca:1bd8:d3be:a464]) by SN7PR12MB6960.namprd12.prod.outlook.com
 ([fe80::faca:1bd8:d3be:a464%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 20:25:01 +0000
From: Cliff Burdick <cburdick@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v4 0/2] support dmabuf
Thread-Topic: [PATCH v4 0/2] support dmabuf
Thread-Index: AQHcle5Y2YdL6MHBCUeJzjyyHvTf7bV0dD4AgAAaPmA=
Date: Thu, 5 Feb 2026 20:25:01 +0000
Message-ID: <SN7PR12MB6960C2AF8C689108DCDFF356AB99A@SN7PR12MB6960.namprd12.prod.outlook.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <20260204155206.2345189-1-cburdick@nvidia.com>
 <20260205104844.6d2ffd9a@phoenix.local>
In-Reply-To: <20260205104844.6d2ffd9a@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6960:EE_|DM3PR12MB9391:EE_
x-ms-office365-filtering-correlation-id: 65886490-ef55-42b6-0a53-08de64f4a3c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?MgwaRLWBFk5e43gd05Cr6VA2gIFwzErbL//DLeawEJUkvnrh1Rd/6rIvy8Q/?=
 =?us-ascii?Q?07piADFjc3+YOnoSgfWZ2P1qMyGd585VabpXd2FBr7qcqdqLbR2aCNinKdlu?=
 =?us-ascii?Q?AlZNIw4TNmnoTdgpiXJpCzk9dlD78AL3BnTlRpr707+BDUxfKvtgaliVPSrQ?=
 =?us-ascii?Q?1Sv8irUxbcPB2rM/DT4vGdJ80ns5i15umphIBBDMwY6i2DAkI0w+QdNDztu3?=
 =?us-ascii?Q?+LxsgXImtcB28tp3b0mhoFpuGMJy4AhycDg0z08b8ASCp2OshyMl5rTBpczR?=
 =?us-ascii?Q?2z3cMyMSm4aI54QJ3cpdSaVF5FrIBwUnfzLVDUVGqn065itlWftZuXQLEcEy?=
 =?us-ascii?Q?7yMIwmA1WKANcGlpLC3TWXimUAtLMZbgaCAYelAtj1s2v4yp5fBcfwFqT1JV?=
 =?us-ascii?Q?k/PrD42VUSoe1MsQBsedTFPpa7tKcPYBXXTsk1B5D/VtwnJRU7M+td9/iheV?=
 =?us-ascii?Q?NuqVDHHpTTv09e22q0r8+EevQwtMtUqUr1gjhHL0hM36BxuCpiJu4XM/vqO7?=
 =?us-ascii?Q?fypjlMUyIZmR8j8//6U5Iyq8v+u+pTVleMrIr7E4YBfuIkEMfI0qJufcjSl1?=
 =?us-ascii?Q?YLXsuswE5aJm0xG+T5B16lA6UzgtsPziKQUhK2iC2JE1yjONwpM6rsoWWyBC?=
 =?us-ascii?Q?gaP4MyhiaQ4cKlNuSBis6/Yct+Uy29jiS+x9Cbo3ltx3Zv+lsgJLs2AP03hN?=
 =?us-ascii?Q?D+8l75QeP/96PwHaPlGpX1g3j0FVjqtzKJAYulFf2XirjlxPbQSi2URRFHYe?=
 =?us-ascii?Q?md4fxBn/JLXDcVP5zZwq73Nh/UBIJU4HlVxTL3nu4QK+hJF32U0Gyp/wGT0Q?=
 =?us-ascii?Q?LYCrLZ+zevrft/MOaZUBPVy1kRVom6DRHe6oFSNJok5wnTHvwTBcTnGdFeMb?=
 =?us-ascii?Q?vS9FgdxfXl2+ZKblakxdDUFbNip052QfVwP7S25moav3K6QipZuHk5K35buL?=
 =?us-ascii?Q?6GAqZojeCAYjThjqX2lh3CtBLiys3S0xGpAZ/+6WnHkUrUwoEGieh8tDSUuR?=
 =?us-ascii?Q?DrXyByWSpKYFhW9u6sOGmLHKLyT8s6UWpgSrnW1nz0D/N8mza6yhKs+lxtfm?=
 =?us-ascii?Q?OfL87Yz9o3j4i9Fa2PFXqMizUH/zxD0zDQJQb/E2WNIeMgfAGwAzgjZS397s?=
 =?us-ascii?Q?gO5AF6aW2YjwBqiZ8dfagJuhMThJVndGEYU64vBEiI15U//hCdx5M8DQgkOs?=
 =?us-ascii?Q?IuNNsQH0S3+xpWfFaJ8ln7so6vbAlsRJUvDiHJKKHLChooTmTMSIsWxO+gMi?=
 =?us-ascii?Q?hImtSe64kRAv0bR2WLyJ0ye8kA9qHJ5Fd9WdRw+KMVAzW6F749LBMmtfcDOE?=
 =?us-ascii?Q?62UaZD8Jz16/1AZ0ulzCm5oy17g/8AYKQ0ivST40RYPpjfBKwXeVGq2RBYLC?=
 =?us-ascii?Q?rif5Md0K/Uj0JeV0CHjbpS5bU2Gzh5i6ay1tJRuBE9Li7eu9PMXNgXlnBHJ2?=
 =?us-ascii?Q?lK+0+hLqcjKvfsyI1plaJrBmLWsNj7k5CUXEi6cbOjm9U2qIMEnimP7plawz?=
 =?us-ascii?Q?aJWQm/EtPNwhqpHdRBaiq3bPYT+gERXdNemen4e5egGeLAQlHXe1UL/bCOQf?=
 =?us-ascii?Q?WEHrtt/pE39lqlh6nOpaQNPc/lqddiaC6kqezoEhjHIbUukGAXfmbqx0syyg?=
 =?us-ascii?Q?ydCKe3kiU3no/quFf6oJ7N8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6960.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AwHhcY/AD9HY6cvTOtcuNQ4NXs83msXGOB4XVaQksjSZNUBnNa1Gir5uKxG5?=
 =?us-ascii?Q?/bRyvnDB6XLqsQ8hxmmsGy+NeoNoRSdIvGAlvi6u3eVpRj1k23dUtmVFEcb3?=
 =?us-ascii?Q?aYwd3dtPS3mnV9SM1q+mDtBWAKdZsc5DW+8fWS93dvFjiAvB8Qhu00s99qvP?=
 =?us-ascii?Q?204KbIBWj+VVNAZhSiM2rRLFyY679qwXJ4kFLvXaD3AQyyF7bEDEnwdNkGNF?=
 =?us-ascii?Q?FAp2c1DPxEqDsL4D0HjoMRCMa6PGewVU/p8fKWV52EKSvubnEwTPjifk7loz?=
 =?us-ascii?Q?+cDg/zVmq+x6DdtR4MZCG1sBT5CiD/z2PeuxdfYdzC0NZcJC8pvxovYNB00z?=
 =?us-ascii?Q?eOXiDoyTsvZCnR4QFN/Nqnbbsg9oxMSkzqS1VoPf3KBg3ruk6CVaFA8GMxWY?=
 =?us-ascii?Q?e/cY2ERF+tHZS9UpVWdzRwPJVWi9U/b8w4XQR35IIUIjanjFfQ5ey3a0PbDo?=
 =?us-ascii?Q?OMdMZe0dT7LbyUIrJG7BKEQ8RswH6mNRhjUN0Cj9wpXc/Yty6/FTKXVFTokF?=
 =?us-ascii?Q?kL9DJ1yViAKqMg8trF2Vx6yBfnrSkjDxfNeEH67plxIWJolhA0VshOFDqf/E?=
 =?us-ascii?Q?Y0r3CltyuChlq7/7BBbcyERxYhBWwqFuS2xG3Sdt/HAck7RD3FagSBWXkKPu?=
 =?us-ascii?Q?3kZ3uZYKLoElewoyVvbANrk5L4lhKHPV/9Gau3oVfJQecm2iqw2yyjSXLpB3?=
 =?us-ascii?Q?/mYxk44aRpWp6neonGJxcAUCAHkdBis09ifYO5CwF033oi1czTJ6oM528X22?=
 =?us-ascii?Q?VIN2Cj7qXAFZ02OfKgERC1LdNP3JQgLM+oePFz+ANza93m6PNow0E2IKNf3U?=
 =?us-ascii?Q?wtzjzL1vqE1coFe+ykla3fNIfIuwFnipcDAeOl0DmiS3PaBBs+Yi8lkCv+1z?=
 =?us-ascii?Q?KPuPaLVuWJY9BC+FSqdquwGzFisxgeeBu3XJtu7gHs6ukvJwdSswuQjsXH5w?=
 =?us-ascii?Q?JSVa1eFy9YovN7LqjWpaQFEA0cPWAUaaVNrSiDqFGMhpbuyZlcUltIHiTSh0?=
 =?us-ascii?Q?wvrcmDow/eiHVJq+IBy9s+EcfGLWtiyv36EBJ+lFtBeW+lnfdYntm7gm4tQQ?=
 =?us-ascii?Q?H3vDyq1mwcSZWE1G7TY631eE26L2BswMZ2fyM+GT58VMkpEybXQzvIsFwYil?=
 =?us-ascii?Q?Jv32ExEJ/A8odqsxpWLoqVkhQhohKxQ31AH+UblQ60aNR7p4JsBiV79mtaC6?=
 =?us-ascii?Q?6oHy46ZwXjvIAp+ULmAkRO1nB6k482/Lb1jLwC3fgiOdg58Mj03yOVla/MUJ?=
 =?us-ascii?Q?WUmOaHVRk7TMZycIsn5c23+zwedopsc4mDLFRv9E2Bfnca03NA+FWH4Ge4jv?=
 =?us-ascii?Q?rokLpPh3xH/ViNo0bmRZy3qdr27YsEQCWS0BqeaPc+ZJgm1b9rnHQAQilEzW?=
 =?us-ascii?Q?HlNqVE4mdMFT4UUYZzHGxtTn4eutKxIsbqzqV11c3zcC+qzLmPyuAleDcYuS?=
 =?us-ascii?Q?COGSPm9G8hAWJAObEmSaA/2LbN8l8ccbuo/7zlUDyZvka5YMQD1gQMJ0PrgP?=
 =?us-ascii?Q?9s7PXas/Yy5vzEb/FV1sf3gzzBY2KArFZ5/ym+0dGhaFxGSslxKiYhRw3iAB?=
 =?us-ascii?Q?tVEMacmGVPVwFtFksuheJFvnJyv05b5aNNtCwgslg7aTqcSpOmCh0grLOtH/?=
 =?us-ascii?Q?3jIZU7TDfj7YhqdKfNhJtMQeyL42DVljjUaI7Y3FCQ8vY8BT7lTrQJ6S1Df3?=
 =?us-ascii?Q?IwG2nw21XJ0kIiiT+tocEWKMplsq39u76d4tIenhgxM3dZereMETpbtBsf8X?=
 =?us-ascii?Q?xfm4nNXLAw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6960.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65886490-ef55-42b6-0a53-08de64f4a3c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 20:25:01.5245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezz1q05vVpK6RrwZm/Cq5hFkWLkiBXqiI+Mls4vZrCq/YskYh3T/ubkOfpncGmWfzwMoiyv9ojzjI12qlvpABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, February 5, 2026 10:49 AM
> To: Cliff Burdick <cburdick@nvidia.com>
> Cc: dev@dpdk.org; anatoly.burakov@intel.com
> Subject: Re: [PATCH v4 0/2] support dmabuf]()
>=20
> External email: Use caution opening links or attachments
>=20
> On Wed, 4 Feb 2026 15:50:07 +0000
> Cliff Burdick <cburdick@nvidia.com> wrote:
>=20
> > Fixes since v3:
> > * Fixed version in RTE_EXPORT_EXPERIMENTAL_SYMBOL
> >=20
> > Add support for kernel dmabuf feature and integrate it in the mlx5 driv=
er.
> > This feature is needed to support GPUDirect on newer kernels.
> >=20
> > I apologize for all the patches. Still trying to learn how to submit th=
ese.
> >=20
> > Cliff Burdick (2):
> >   eal: support dmabuf
> >   common/mlx5: support dmabuf
> >=20
> >  .mailmap                              |   1 +
> >  doc/guides/rel_notes/release_26_03.rst        |   6 +
> >  drivers/common/mlx5/linux/meson.build         |   2 +
> >  drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 ++++-
> >  drivers/common/mlx5/linux/mlx5_glue.c         |  19 ++
> >  drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
> >  drivers/common/mlx5/mlx5_common.c             |  42 ++++-
> >  drivers/common/mlx5/mlx5_common_mr.c          | 113 +++++++++++-
> >  drivers/common/mlx5/mlx5_common_mr.h          |  17 +-
> >  drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
> >  drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
> >  drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
> >  lib/eal/common/eal_common_memory.c            | 165 +++++++++++++++++-
> >  lib/eal/common/eal_memalloc.h                 |  21 +++
> >  lib/eal/common/malloc_heap.c                  |  27 +++
> >  lib/eal/common/malloc_heap.h                  |   5 +
> >  lib/eal/include/rte_memory.h                  | 145 +++++++++++++++
> >  17 files changed, 612 insertions(+), 14 deletions(-)
> >=20
> Any new library like this needs standalone tests so that it gets covered =
in CI etc.

I did not see any existing GPU tests, and this would require a GPU to test =
along with a 5.15+ Linux kernel. Do those systems exist in the test infrast=
ructure?
