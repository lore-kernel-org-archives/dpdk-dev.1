Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741A2C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A206640652;
	Mon, 24 Feb 2025 08:28:11 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0B4B640299
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:28:09 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O5135S002612;
 Sun, 23 Feb 2025 23:28:09 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45007b1ryb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Feb 2025 23:28:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLHK+/wBfDIF3PxCqbntljww4ZjKrM7AdBn8I+Zb+pQoBDN/pJVA89v1NLuEKn7CiqkFIRDsA+JbWPpiX87fWmAxzKKmpCRJiOLXLP0gnc2JKyz+Zeh7fAOpiFvHdFLC3EZmam4XfEpGZvmN1lw+r5YwzWpHyQtuxDUGklbWsDNBL4HGQkddpKFvifDkbmYKCg7S2ORCwYI5/R67cSiR8r5x2SezksaGXvvTIJhE6W1ewKmetPyb49n3pV3OwlLoHVJ/ONwwa4e18k68WdG+MjRd7FB5TQkASZFopCBIjOc+ty+WzVi8uMjN2hGEmIL/uYQSkzbwmNbmCERr45vhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p3cGZ4WucAW6iaK5vHrmP4paJurcFSkfqSaWk9Rpic=;
 b=LzxWT5bG5qu3HasxQqb+nTPStsHQ+22xic1m6YlWKkN578UIhpb2axXrk0qu9yeVYtOTeZd7x+2QtZPbLOVWW76w16p8XqxFxv3eQml+4SDsA1UHq/FVx34u9JxH50u0ENC6aoUU8Ix6eojbcaDNA2I2nFLu6HlswcCCPUSrpnfDmiWGJohSYjcFRgP7m+V0h/5VpSurSU+X4Jti8xcrVLKMFeRrlKbKW2epEi0QJA86YjDgfh6nGpmZUu3x9PCC3SsfuwtdODZ1RdH3DH0Q4rYaGmvB+2fI5QlbQ5kmqTo6mOBqb86Hdd6WEK4GhkdrvF67cNY76eKcICM1Em7q9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p3cGZ4WucAW6iaK5vHrmP4paJurcFSkfqSaWk9Rpic=;
 b=H5VgcRpOxEIvZkPxVw/D+nD59B9zinQBl08xz/Qw4OiLs3GlqZ7k0ring7lhFuDhSrsgPmHtxP5a05HTv0PHz/snOpBmM4yAZVrR1AuCydV0DJassLe2vZX9eRpG8qwV3OjxK81Q5rF8EMtcWqBH1cfDT32Uq8a09tvbEWxSP2E=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB3793.namprd18.prod.outlook.com (2603:10b6:5:345::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.21; Mon, 24 Feb 2025 07:28:05 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:28:05 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [v4 0/5] vhost: add RSA support
Thread-Topic: [v4 0/5] vhost: add RSA support
Thread-Index: AQHbhQUjf9dGrf6M9kq4nMHh9EQWwrNWEKEw
Date: Mon, 24 Feb 2025 07:28:05 +0000
Message-ID: <CO6PR18MB44846AAD97390FD5813E657BD8C02@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1740156665.git.gmuthukrishn@marvell.com>
 <cover.1740212213.git.gmuthukrishn@marvell.com>
In-Reply-To: <cover.1740212213.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB3793:EE_
x-ms-office365-filtering-correlation-id: 4ebf652d-bd06-4a7f-26f4-08dd54a4c766
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MGzR0RhwkJJ+de04MGbNTTTQHe6VReCuOPoj/UhqLiy5HYgEVOARDMhC3KJc?=
 =?us-ascii?Q?vOfFx5LghO/eaRDi3TRCCIoUqhwQjRN4nkSMhlEar6hGzuE4wMUkfkcwd7VS?=
 =?us-ascii?Q?459DZe1/O7dw+darKuJQ5swSv6AtIPwRxDyoMij02761P6UvhINVpnIyNIVp?=
 =?us-ascii?Q?6r7rJY0MnKKzm5yLKbPDk1IfydC3trcuMh7CgNF6JqxIvqCu3Dg/vqDo5/BY?=
 =?us-ascii?Q?h6Y826d85S28iSAvmAvECpciAXhik6Owjz1+XR172KV+T7QwiumZ6Vaukj9u?=
 =?us-ascii?Q?wD4IRloyqLsC9vOTfaHsaOpU8uFJ607qNujmJRODbyPxTr9dGheEuuoSQqsF?=
 =?us-ascii?Q?1lN0TAOT8XXdTpuKUJOMFXrbeciorIisF6gtAyoQ1nKafK9jP0wfTxkt/9Ci?=
 =?us-ascii?Q?vs+W9ll1kFXT4cdj818i+YuW7DZSs5l0a0dd61E9hYhdgxwAkQ8n/aswtCFo?=
 =?us-ascii?Q?KVDbGQOHtq4V08d4NuwzMe5Ka1pzoxdLhiMzMUES2yqg0UXaNRkJ5tcN+43d?=
 =?us-ascii?Q?J6rZv1w2Q7f7xzYa0ogrRlwTtQj/Q722UI55rS39TAHazxZYofphfORgWAKO?=
 =?us-ascii?Q?Ias2Ot28ln5z2Z6B9gMPKwE6MCktR7Lhda7znLXfVWtTiAUsx+Ca5dQFb0uy?=
 =?us-ascii?Q?u3XjbSCr8zBAEP1FCnj4/BtImhy9iQdAkGLTmfc5mWCofw/EcCzyGIDvH4aT?=
 =?us-ascii?Q?iWdG4nKckOO3y3OmMCmRdfl59An412V5lDBtIIRWRJyIxDAeRK4yT716rSDv?=
 =?us-ascii?Q?h4GftcKrNyKE8Xxy0ilIfV9OEkNTHq8SEC7fIm1+CPSjd5uNf1QD8XsyMvBV?=
 =?us-ascii?Q?zpXERgh/UIqlPZOjLAnXL9nhHK3LeR9JGWxYpNbJL9UR0rQAuSRNoOWbpMiw?=
 =?us-ascii?Q?vrQ2xj95SRUpwjzji0my9gloTWbS9LUfLVfR+jWZw9qDF5UresyjD1Dyketb?=
 =?us-ascii?Q?ZEvBX+v+3Y+EFDzCGcG0mIBBAphV4GwvV5zlxs3yrrV9uDITEIFBkhPd7Vb8?=
 =?us-ascii?Q?t55pyLFx29/9+IwJVKzWkFGAXQbU52x5tuaMCOkcuJNkFt3cA/9CA2Owt3W2?=
 =?us-ascii?Q?ORID0wtpnCOG/Kc3Fcd6ahu0Q3dsVzr1QrOkoCtWN5xUrEymazPBbdw8uhK6?=
 =?us-ascii?Q?DjGiHQR4JL+SKWPAOMDC2rWDrgshlpkO8bpdaA9RRCuoZbnZ1uvFh8+D9ZTR?=
 =?us-ascii?Q?4IFRxZ8dWY9O3eMETmLdrdDEaLFV2oKdDuHClJ7qWtUQGd1OhZU3HAFjTLEh?=
 =?us-ascii?Q?U/rjeWeQkuE6rlRL3gYbomVmromYjI96ickAWLkKBZhk82zPpfixRlc4jXqe?=
 =?us-ascii?Q?CNhscOuqgX+FlBydjSEd3VTX3ApeT0DVPnvj5N/EH4sNd/eRlp5tmVPPZ3E4?=
 =?us-ascii?Q?5UQKdZh0J7Prn8+/xix/t2ovK8B/++z/Vwz1vNI195x18YpvVzy7PIqIkQe+?=
 =?us-ascii?Q?AUU65Xo0PXMlE9vW+u/B+lLhY1MBH+nd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tbEi6+EzgjAyo5rUja6KYnNfbCqPu0A4/mpQZGx3VPmsww/MvqiZWYMJ+8+A?=
 =?us-ascii?Q?/Y5rQUoFJyxRncxqFCMso5b9AHNz9d2BX6fcqDIBRMKrwPhF7Xa9CyAlktYp?=
 =?us-ascii?Q?lx7RYqZzvUtWgfJOeacJxI08u3y0LZi3HyWtj0Vtaqa5Lbxl/qCF3AB/HPah?=
 =?us-ascii?Q?gewe8HaPMjWI1WtnXaiRfFSFGnB+XiJdVwq76CCWSU12wJnbUVmH80m02rpE?=
 =?us-ascii?Q?oyF7Z417QQvn/12hhGn3FnVwiEBCjD8GxjdnbwSJ7iOr50OSetLDN+ki3yLm?=
 =?us-ascii?Q?dKFK2oS4OH+gB8USeZJvirms5+y5XD4iAGt/AOgAFJ5o1DZVAOuq+NV04Fwo?=
 =?us-ascii?Q?vBCUSpVnBIzGxFql7wIXJnpX79PDQQvykE4gH33fP8FBficKXE2KZdv9M38e?=
 =?us-ascii?Q?z5gmN474zyIhpjd2NJtv+X1YkbNXD+XV7q9JJLB1qyjoXhI92lb5wGai1s4Z?=
 =?us-ascii?Q?krwX48U8JJvnKZ0QYUfBRdu0EV3rHRxg5euBbXlDRa5F0scx6hYbn5MAN+Jw?=
 =?us-ascii?Q?77vhybPZwUo91XhWGp1xdZSEWSpPIxtSkMoWzj78NDfpSNMl1p/5XWSOjlVm?=
 =?us-ascii?Q?n+RCtK4Eptb1M3C1ACBLHHXzJTpD8vrTnfH69GYBtqqsuU4eAA4GB5rkfxQx?=
 =?us-ascii?Q?bRoewAGqZUvn8KyZv3+4dnwKPSytrkponc2WImOMBvkY46CcfmvK/Qsr0kox?=
 =?us-ascii?Q?Hvef+5CmMyTTWW7Bc5rbnfWTUlTIqpy10yeB+hclY7d/OUcwDl/ICCtOX55W?=
 =?us-ascii?Q?l0qJ+aStftpCTp0XbtTjKlNqU3lPl0cARbdUZ2WGh9wmG1rzLdd60KtSq8eu?=
 =?us-ascii?Q?y6q1IB3gMqWiHoiMAN5OJS70ZaEu3oAzFFeSNGjNiRFV2j2gcy75BF51wY3U?=
 =?us-ascii?Q?ZaHL2ledTpmiiLl1OyIc8F4vDR+fpKz8ulpBfqWdCd0M4WXiGKsTOPbJyKb/?=
 =?us-ascii?Q?NPJkT+C8jhpiA4rwgL98OhrxLEO3FfipTse+ejvkwlOt7BBmdpLxKKHl04i2?=
 =?us-ascii?Q?MFKMgcY4/ML5tMZSdMYjeENFoPSJy8CwxFjesuvTXqK2WVUxDk9Qqu92d9fd?=
 =?us-ascii?Q?4tvL34i6JcATM6iI7gLKrhgnwwSHGzuxMKsEOGJAekx7FpTBakcuk0/dPyF0?=
 =?us-ascii?Q?OuMlefvi/Y0RCjbvga7W+2h34oWYBa6w0xY+Qx+jMSd3D1hG8Elde84GlLdB?=
 =?us-ascii?Q?24aOr1EDoijSUG3Ap0+hApFT28k2pI48aeG4fU2tRzMCJWW0vNQDZVRlC6xZ?=
 =?us-ascii?Q?eJh+fLvmXJV+UWY4IgOp2CLkgIdGGWOtxcR5Zm2xz/6/pX9kWxT+Jd0mEqrG?=
 =?us-ascii?Q?AtgmQir8vs8dV9k+m2iM+GnqFD48I4yX/+lwbpmpd8NrPoM0GUq3WexAfeWA?=
 =?us-ascii?Q?FrB7zHpdlXjwCGuvQvoigSATQ/J7y9Ur0sl5p3VeLdCK9W0G/mquzFfXTXgb?=
 =?us-ascii?Q?7lek8/mY2lP1CIg9T1ZOkL5uOe7eRxehwFfzjU0BZnBuEcVpcenn2xB78dpc?=
 =?us-ascii?Q?WdNHfzAZJvE79QiU13e/AA6HVbHXIvN/138KbJRMshpsPAHSsLZlA4Ep9ybX?=
 =?us-ascii?Q?ylqKAfswNJ8ZuaXCvq5GTkUvGkLfjRiakF9lCyPO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebf652d-bd06-4a7f-26f4-08dd54a4c766
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:28:05.2931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXMCuXgg4/t4ZO9KiH18r7/j9sh/6oFrVv97gfskEcjz3Eg7g2cNm+Rrfm6rP0ITcQq7/2FB7f59r7KfHIgt7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3793
X-Proofpoint-ORIG-GUID: fgtEVdHf9WtHolzc2Nm-QsV_iqZLTYZW
X-Proofpoint-GUID: fgtEVdHf9WtHolzc2Nm-QsV_iqZLTYZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
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

Hi Maxime,

Can you pick these patches in vhost tree first so that virtio/crypto patche=
s can be merged in crypto tree?

Regards,
Akhil
> Subject: [v4 0/5] vhost: add RSA support
>=20
> This patch series supports asymmetric RSA in vhost crypto library.
> It also includes changes to improve vhost crypto library:
>  * support newer QEMU versions.
>  * fix broken vhost_crypto example application.
>  * stabilize crypto fastpath operations.
>=20
> v4:
>  - fixed CI issues.
>=20
> Gowrishankar Muthukrishnan (5):
>   vhost: skip crypto op fetch before vring init
>   vhost: update vhost_user crypto session parameters
>   examples/vhost_crypto: fix user callbacks
>   vhost: support asymmetric RSA crypto ops
>   examples/vhost_crypto: support asymmetric crypto
>=20
>  examples/vhost_crypto/main.c |  54 +++-
>  lib/vhost/vhost_crypto.c     | 508 ++++++++++++++++++++++++++++++++---
>  lib/vhost/vhost_user.h       |  33 ++-
>  lib/vhost/virtio_crypto.h    |  67 +++++
>  4 files changed, 603 insertions(+), 59 deletions(-)
>=20
> --
> 2.25.1

