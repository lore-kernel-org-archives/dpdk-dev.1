Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930DACAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:48:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAB9840B97;
	Wed,  1 Oct 2025 09:48:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1462D400EF;
 Wed,  1 Oct 2025 09:48:48 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UNUV9l026738;
 Wed, 1 Oct 2025 00:48:48 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020099.outbound.protection.outlook.com [52.101.201.99])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49grx0s6e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 00:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI86O9PtwbmISPv359Zuz88oHjXZNOT8rHZrIDBi8s9HI0BCc1CEG4f0CSH+0vh6AIWOGNYOADQTq8Y1/RhXEKBqNdyeg/oOCJHLG0NBh6YNFDBs+WCu2DCto0601vEj9TG1Pqhzv04UpLvUMJZZuySZN2zgICYXYYSK+CVK/LaHbyLf9Wv+LsTxmnBMFSDlOWVIlUAxhFotVn8AKOCpZDF+lfyGt+88BGMCvSTfy0uWE9mL+5JhJ1SqUDqJpPGyM6CpwdO0jWJBRKDdiPjVinh6C+LBCWxSo7LalFHhxb3PoMGDy260D/lhqizdArpQOOHwh4PGqChNQUHhfkeK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg4IBykKSolDjn3AFyo9asXJu0jbe9FPVcV7UFM9MOg=;
 b=xsIZ30GOyqdIgk1k5W+b8mTz9LbAvOZ+g81teOTMYQsZmWJVfEa2ifgRal6N7FHn2FBZ9EYHYERix+nPPDNMd5kb/+1A/lfBU9QI6Db+8A1eku994u+pTlNvhXrAQKiVUymDDiaEngqvoqFnVW4Ijfp/oKEiB8MZ1gLHuQvWaZ4xLP1CBM4LbHeewkidQSwOZKOdGntF8fpK6l8vTHrUy4R8Abi8x8TYYvQqqYNlnxvevpTGjtPeKb48gHnTmcd560BMwfsMe0czf2vst4jVXZLJujZrnCyNqXar3nA9/8bE4I6PMAeJO251OcZzwogi5BKSZXafc6EMwZ5lbtcGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg4IBykKSolDjn3AFyo9asXJu0jbe9FPVcV7UFM9MOg=;
 b=WeTlaOkAkNDFaGxr9Oe2A82eAPVFYknvFAlI/Pikcqbd+jEcTfXo41oDwCkWc8OwW0v6vhETNr+GbHAfXqGspX+GLQXCQoK25rah1yQtrkHQkPhU26xErVQy6H94KBV7d7Q8TSx6OfqjtWP88C7A77YUJ1AO5Kq70ffu515x/us=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH3PPF1E89B88DC.namprd18.prod.outlook.com (2603:10b6:518:1::c8a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 1 Oct
 2025 07:48:46 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:48:46 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Shani Peretz <shperetz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "stable@dpdk.org" <stable@dpdk.org>, Kai Ji <kai.ji@intel.com>, Declan
 Doherty <declan.doherty@intel.com>,
 Marcin Kerlin <marcinx.kerlin@intel.com>,
 Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>, Michal Kobylinski
 <michalx.kobylinski@intel.com>, Piotr Azarewicz <piotr.azarewicz@intel.com>
Subject: RE: [EXTERNAL] [PATCH v2] app/crypto-perf: fix plaintext size exceeds
 buffer size
Thread-Topic: [EXTERNAL] [PATCH v2] app/crypto-perf: fix plaintext size
 exceeds buffer size
Thread-Index: AQHcFZAJO6wyi9M6WU62bJqLZCmdA7StJFKw
Date: Wed, 1 Oct 2025 07:48:46 +0000
Message-ID: <CO6PR18MB44842A90E66252947FB6C21ED8E6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250805063800.225231-1-shperetz@nvidia.com>
 <20250825071450.25314-1-shperetz@nvidia.com>
In-Reply-To: <20250825071450.25314-1-shperetz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH3PPF1E89B88DC:EE_
x-ms-office365-filtering-correlation-id: f1891474-3205-401a-c6e2-08de00bef3b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?z0HFJQUJVBLpVT6Y+oqTiUcvf0VIanVIZcR2F6a5RRf3pJeBj7nE4Urq1qRU?=
 =?us-ascii?Q?buP+y1K9lO46Ds2Usk2G0Q9DdGSBcwLtIKALhqJM1KytWWh0aGmoYTji4NGY?=
 =?us-ascii?Q?aHvFC7tfZh8OseeAvgXIxTbYb/gBW1bgGxOIRPa6g7excnvIlLdIT6FKboMD?=
 =?us-ascii?Q?t8Dvma0JAqsoUzSZHAuukDNnjqf8d7dWNoSJhn7P0ajwphoSAeD4GYB64GQZ?=
 =?us-ascii?Q?0E17xn/47bhueu6ibRxByPdRBTmAqPUWzjMUYKtUADpbrrCjFYh05CZcjdXd?=
 =?us-ascii?Q?lw2oSZ0ifDv0UytoAr0bbcJhb67cEbxqA298Wl75RJSntkFseEcHw8TMIrWj?=
 =?us-ascii?Q?95MelF200sSM2j5SWwrREI9qwN3ujLwqfrfOjyhsoH5CvG7ZNmnfAIhwT6A3?=
 =?us-ascii?Q?oqgAqZg1tCV61L2g6vDoEVj2RCtkg1VheJ/DJ2XNNzfX5gfzHTiawZQWBSKF?=
 =?us-ascii?Q?dVweceBN6YxM3Aed1Rn5+niJIjnzPXqi5DNiT8azL1+qboDgShJ8ZijVgr5A?=
 =?us-ascii?Q?XZm7jsgLSzKLM1KbIkyGOuhfw/ho2ujD5gkLm52nB3eeFos8F/gm26w7ty7z?=
 =?us-ascii?Q?9Evp+ogtrbKiJ8vJF0/+fYRTri7ACEgUsnEXW9nF+WJ4WfvhggilHp2axgpc?=
 =?us-ascii?Q?FGklWGHRBdj3SbrpqOAWyWiTDw/ohyFPdyePpywy4UMEascEpQ1XtfcQFJii?=
 =?us-ascii?Q?GtSJnc7KzkIxOs6cERl486JKXhUj/r28cx3Iemn7TT5f5lBgP4tsjMs/SHsu?=
 =?us-ascii?Q?cVIkXHEG6Lnvk2/p4BA2Jpp2g+hBE5lkz3R7Z8uLVmFIa0rLGbFuLK6OTC2Z?=
 =?us-ascii?Q?Wr8/Ib8Lii54ft7J0rrMNzAIO9ZhkSZqEuIIeUYnF9A/tjAcVlQEV+FDUZTp?=
 =?us-ascii?Q?Nn0WI3VN5Rc4121MW0hHAg+y05jKGiBMm6zljj1mZgsBiPE3XnA4vqqTy6dC?=
 =?us-ascii?Q?4mBTDtDKpR80J4EVVOHG4FNtXv2f2+OSOhLKPfi6HGzjQ92BAUyHY4bTAIqA?=
 =?us-ascii?Q?l43qrfwsK2SEsXqUxRyxVizhwpvsiazLeo8JdV21crlOtqPYsFYD1h5KXQtH?=
 =?us-ascii?Q?Ft4bqgkTANTjnjlvz5a0HVpMRy37FC6Sou/7XGm2lkDfejfGqT8JaJPgu4aP?=
 =?us-ascii?Q?Zu9Pnv3jz40rHr69HPb3uB0QvvlXh5fRxLbxl/2VKSnO9HwNeeEq65YXlOot?=
 =?us-ascii?Q?xyP/WOy2ZofFe01Sq8Boc+xvZgo0PrOfLcM41F0qXP435AgNGV/2OlDkfHh8?=
 =?us-ascii?Q?Cv2uFRoID22gVQpbvtjMj5fde9M/g5kdR5EIfoEu0AZeyjm3BKosbZtmeYbn?=
 =?us-ascii?Q?W9Ba9BMzUYuyeJEninTtJvT6/RDvCe27WAa5R8fV/Jvqq5aqawF0U1xrtTrt?=
 =?us-ascii?Q?/O8+Sd0U9tbD3aG9v7HgMrz9QDdHJh3okScdd7jb+pS7WPj4E/YhBYkxgY9M?=
 =?us-ascii?Q?bp3JK7ahhC1ALSyPRx9CaF4ffPT71G8tEos7Nt2TIdIUjHCYttx3/o28jyZi?=
 =?us-ascii?Q?XBTu3wX8IlSeVot6Gqy0io6mDA7PcIl0vHB8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XmkgZYv+YxX4iMhVQcxI0CkXpVahvCvOQLEE5l5olrdlXfLtd4BdP9OrSjjx?=
 =?us-ascii?Q?YCVmirh/jF5J/JxYvNoGhTIvQWTnygvVfZXm1HnIFfgl43Ae2q/NwQY0oi2O?=
 =?us-ascii?Q?GVEVI3jPMDSQSb2ExdxNVB0kDRa8AeJfp5NCNFH9MeQI9iunRTla/ONldE8W?=
 =?us-ascii?Q?K1GlumqegtysERWdlBMmgQhQYnkAz9TUcLm6GANTX76tpW/PKYpv1QJvDkX/?=
 =?us-ascii?Q?rI2hoDFz7wWMj9XgCM+UoJDozGSse3YF8Knx8GbwQRBop38g2G9rGLEid5rt?=
 =?us-ascii?Q?KlTHd4aFvLQSeBNCH0w7TLC20IdSbQgZr1BMMREz2Bmvjrk7iVCt5V6qZg93?=
 =?us-ascii?Q?zV1TudHT0lv5RyRsQJozZMtEamDTtB92B7NOWN1yCRecabqXUOUBQX0DV9sn?=
 =?us-ascii?Q?7iiI+j7fJtSRrd6oHZ88iVpOocxRSbFnBwDMCx7lpupvOtYz0ZK1712YO7Vk?=
 =?us-ascii?Q?jDPM1cUcOqGR7UC6WNQkJgmS0cPOtZMeJIqRU0SCNpy7r4RqOyxsEGlDYl3F?=
 =?us-ascii?Q?WTxYpOU/3ZnCbgLPNLf8RwW8eEeqQN5QMk7Tdn6k/lkTDo72dVeGc+opRjni?=
 =?us-ascii?Q?7AaUKe/3Xf1aujaj82xpaBChEVj92YjWoUKqUHp4tbwA2oyf/m5/ByxSARzM?=
 =?us-ascii?Q?k8It3hFNZf6gpJ4BWdFgyVPUJfMNswfba7isaCDLuO+ECgnWiotk0GTm9wsm?=
 =?us-ascii?Q?Jc7f3k7SCu+x1g4uFnkc1e0o/NCXGVJpAT2x81CFl9X+uFReXCGG8hrYkb2I?=
 =?us-ascii?Q?4mhCIi198i2mLgpXoeusVwkijRy3VbyJZafC2Hy4K0i8Ci/vsYzDBzmfp2V+?=
 =?us-ascii?Q?L44Jm0V7aNgsbOHo3GVEqtjEYUHOEWLfXBbWwCUgd1KBfikfJwqi3qdaGNyF?=
 =?us-ascii?Q?J2zB5b+8FqOSjE0NhwgO5xxgt5qK5mnd0xnq5PpYcRyn5R97zxAxoCKeNsS2?=
 =?us-ascii?Q?/dNZMS50mkCwIzbFILH1a+/f4ZsNnq+5wokLy2nTMdtfIBotizfBsizRZfn5?=
 =?us-ascii?Q?5i59TdJuQR8aZii3zYNoVV+ynWuwYQrq7Z9ppyFVL3+/8AIaowshXq2dUMfV?=
 =?us-ascii?Q?nfpZxhs+/0gsI04sGAjiDIocHCe2vKNszIJv3j8ImuJeW5uYDCnuaBsmI2dX?=
 =?us-ascii?Q?AdT+02DKTx/lB3ALc1BZN0LUYcq/s8r4vnaB09Z2x3YOiIDlNgW5w0Zz9+Z0?=
 =?us-ascii?Q?ok3Q3EkJPKZgXIMIEj4rXClYdiENY4VoYmAvZx+qu5BH/oyW64xRZXnEi0ek?=
 =?us-ascii?Q?rHL24hZv3pHdg51e2icBEMuFAzbJs3qeoch76F/p/1AkD+LxmROAaZVb0LOo?=
 =?us-ascii?Q?BGtXdawqAZpOwVcRmIw1O8qw0niUkBWuuab7kyssW0/Cf5ab48haGQRu5Zbz?=
 =?us-ascii?Q?jqIUv74ni4oIgjipxIrH+2GKAMl0oLCemTzrF9xaZ6EVcJg5SbMOS8pymUFf?=
 =?us-ascii?Q?AbSSmLfJubnbCu+I5g7YNRj1pJok18k2AEVsXUtMWAuWQJMqPbo9Jav7nt6/?=
 =?us-ascii?Q?AI7nHIRzxOk7sm/63l1LQp7flZPV2mEqBntxW9Wpu3VqmmMOeBFey0M6AjuM?=
 =?us-ascii?Q?6pp1UHmFyk0RbOsQxSGngRUNVf/KInc0LPWCal0u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1891474-3205-401a-c6e2-08de00bef3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:48:46.5326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYwl1TWpnVDkeRqojkpwogikY/lku6fcjScJxqahjeld43cZEfmI/2E7os/D13TOW34OkmVyTAN4NH7iFvGaIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1E89B88DC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDIxMyBTYWx0ZWRfXwTBHYzkJSGuJ
 LjFll5ceNb6AWtujzqpn4ul5Ae4IlB2GL/SgzUVA3IPG4qXJgzjD3/Rzaw2pU3liN7JAumlr5W7
 0NKHpOuuwUlEjVCclzSJya52Z7zOvJY8FyJRQtBf/6qf9d/GeZirvEuNGnWWijWyWwCKt/fVwEt
 u1sYMCp36r7ZBdYf9TeNs6rRfGUlrOtVtD6jjwEziXiHOv/cuU47NEIgcFutny5VI6YRY+8rmRe
 XhU/9GbDh55UK02OrnFeuDUGnAXQomRR2V6KWA4DGev72sA5xk6yH+6G0i9SAX7FqM4Tjf8MFFI
 rxBwDMOyzteG1ATaayba+5g0+xak2+khzfwcwMtIPumWTXiQE1TXMsXUL2fmRNsXs4+or9uFvJZ
 5D+rnXq7dEclyrQs2Uz82LWiAcnjEw==
X-Proofpoint-GUID: fz1yhmYLOtz-CJltx9ZL6h0T-BKcwLhy
X-Proofpoint-ORIG-GUID: fz1yhmYLOtz-CJltx9ZL6h0T-BKcwLhy
X-Authority-Analysis: v=2.4 cv=QtZTHFyd c=1 sm=1 tr=0 ts=68dcdce0 cx=c_pps
 a=kJh41/vVy0mmRivLipeQDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=8rWy6zfcAAAA:8 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8 a=b1Cy6AYMrcpPpNGS20EA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
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

> When test vector plaintext exceeds buffer size, only the first
> max_buffer_size bytes are processed, causing incorrect digest
> verification (computed vs expected mismatch).
>=20
> This patch fixes this issue by checking that the plaintext size is
> larger than the buffer size and returns an error with a log.
>=20
> Fixes: f8be1786b1b8 ("app/crypto-perf: introduce performance test applica=
tion")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.
