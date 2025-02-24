Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C58C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B242740299;
	Mon, 24 Feb 2025 08:24:11 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A45334025E
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:24:09 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51EHG003591;
 Sun, 23 Feb 2025 23:24:09 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44yeyku0m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Feb 2025 23:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc1diAxxzYPTgbIiW4alNw1pjO1fnaL2eNjTYTqZwAss/llssGsKIXKeoPfWuVMN36drkAOaYFiTZTer1DLP+1LvlegMTOnBVykQujehNrRmAksqgtp/6H6EUMtE9QRzMfXuqCAZ3vb335m8n8zTcCl3kJREpBsZJxa3JJWRAaUshmq2SwSOnCIWzfDdFpveYO+NVWboQTf/EjTvD7j0R6UB7zo2ypmxxSMfFCrMaZ5G+7RC9tI3jspnHhgjdvakO/l7/5esHbTwYEfKCO6KKVo1v1Zk/XXiJm4ApyIgLnL5vliHBxK4QygpwdZw1QXWmKM5x4sd+UNGjraQ2Db2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZHJK2N7HP0KIGIxqZMTfG6MHO/dnzPDUM5ytUBaEuQ=;
 b=Y8fHsRkJtmVA8xJb9Oat/qnxYZ46xVBSaUDVsmskg79L5CrBueS1hGJzzY5B/2Lsm8wtt+SESgKP2+sPWE3ZHID6DOzx0s8x2w88w+gKcudnMCtWH6yn7ZPXwJgYg1a0C5puXXxbC3vZVpoeV39MWC0yuNxf2PG5nmnQ5MHxdTrQT47ZeRUlZHT2z0VjP6m2RTy/YgtvFh/752MpQjlwCTKemhH9BL1G7RuacBBwT8KZqvUCKqL7EQwEQNoMh/DjZZYH2Q4bBhZIOJc+e044ZxZ9XCVHmrE2h/MLp+eECK+TkhR3uUgfdIZ1V6tNJr4SuKnGKHWgZf+hbUsUJ4q0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZHJK2N7HP0KIGIxqZMTfG6MHO/dnzPDUM5ytUBaEuQ=;
 b=ZEKZ0mUg9LZ5prc8UulJUovwnVS2f4vMgIdVIoIaiWdAqfOXUCVnLww8aEM2O6pDF6k67QwSvfGxRJfnAyP3AC/l4zgGaelCG8gW1x2epGiBBC1kIz5nSfCoflbSA1LhahuxvwHiwPP43rDmj/bKAdPyeCi216X7P/3RNz+Czzg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB3793.namprd18.prod.outlook.com (2603:10b6:5:345::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.21; Mon, 24 Feb 2025 07:24:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:24:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [v4 4/5] vhost: support asymmetric RSA crypto ops
Thread-Topic: [v4 4/5] vhost: support asymmetric RSA crypto ops
Thread-Index: AQHbhQU5LbpFwlygika/C3rYlgT7CrNWD7/A
Date: Mon, 24 Feb 2025 07:24:01 +0000
Message-ID: <CO6PR18MB4484B509AE22C1B73B79CE0CD8C02@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1740212213.git.gmuthukrishn@marvell.com>
 <462b272735022d1d50c88c3966f333fd83e94dc0.1740212213.git.gmuthukrishn@marvell.com>
In-Reply-To: <462b272735022d1d50c88c3966f333fd83e94dc0.1740212213.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB3793:EE_
x-ms-office365-filtering-correlation-id: d79ed185-7928-4162-9784-08dd54a4360e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xAxjAiNGH7zsEsgAzwjmH6h263upJCrkLG6PpL2R4cBSRwErGF8D9VVTEcA6?=
 =?us-ascii?Q?KplF90YU1TmppYOM8pvkhtf8oPiDDx6WtVAnDqyN82eEu+ELhTLdCWe3AVsc?=
 =?us-ascii?Q?1nexjLqSU9tbajW+Fi/5M17Y+bUVeWS6ijSbhbWrPZucdWtRC6fY2UEGQPSo?=
 =?us-ascii?Q?VRqOrHoygg/NFNDBqalIbqqRMjh4sDQd5Qb5U329RSBazjWM+zq6C6JMi97h?=
 =?us-ascii?Q?e+uojlKZCi8u3GmICXPnlZg6+wXHVgMipV4dd0I2tidaOa+Tqj9jSb7byJiu?=
 =?us-ascii?Q?Rl0GcT/pMqxmNBVuBCOCt/xgrv5XT3sxHrrF1ESjuLLYdsgn4N0+7+kYKxhh?=
 =?us-ascii?Q?SnimohgaZU84mQUbXLku4OREPhGE1kXVuC2VBO2JLQcChtwoUh2Xi8DrFNBN?=
 =?us-ascii?Q?odUfRVRD8y8ngQLice/zFnzEsS4GPsgCJ+fP6ZV7ADBw1mV2n1tb2bd09A72?=
 =?us-ascii?Q?OixSMbjPWz5u+7IE8LM4/ruwqo++8SF0EI/kBb2Mi6+qUfq2wNJQWlsWn975?=
 =?us-ascii?Q?Rqzz0MBXyXVtG095EcLLcKzrdKAB7vybLCtKvXtJ2BZViX6nprhLYYiX9Qj+?=
 =?us-ascii?Q?KQZ9GbtMD6XMezz4SmIptACAms4rcwJmB2r5kElJ4p2jsj/Yg9uZaUtjcRK7?=
 =?us-ascii?Q?MBisIg81piWiEY1HiA429vB2umSK05CQZZ9HQjlIET8/XKtKYM6QJUk8qKoK?=
 =?us-ascii?Q?CSOiVtJHkotT3KnJ2iC4RM0fGFT0ToeXBWI2EmTyXs9Q30fJfTckq3/3e7Xq?=
 =?us-ascii?Q?GsVmscFizyOK5fhiurzX2ExUuZyIR/TRlHyAczELecwBRJ8gJ1lGR36IMmN/?=
 =?us-ascii?Q?urrv9Lm1Ke1XpQk13ZS3go4FW9kM8ZHbdZWb5cSGqaQ98F2FfQ7SJch3+vaA?=
 =?us-ascii?Q?40/Qt2cVqg8pB8q8qzW8bRxsaWIt2K7VXwHBVOrMRwVnYIlhVo4BHN/IcU+V?=
 =?us-ascii?Q?iUr210qlc9Z4SdhlQdGaUOvDYWAqNxAWv9j6hE966LER6L37LeRnoI8oaALj?=
 =?us-ascii?Q?JRCzQAGUSv3OcURN7lVeR9qHQ1WB5sQq7xDCilXDriknIhn/AdSoE/Xv/nNt?=
 =?us-ascii?Q?Y08ZS6D1k3+r1t/5QM5TWbcQULnn/DSLcJ/6VAU4PJ5aovUJOsTOGd/XTT1k?=
 =?us-ascii?Q?w1xFGyAb/D9QVxEyjWDmpDsX2tGYbscseCrHmVpU11CofSDPNPZN9Hb8p+9o?=
 =?us-ascii?Q?ksWBlyFmZ3KngTxUHhgI1mzHruche62JzvR4i9UxYiPjl2PQk8EAu3HOw+Wr?=
 =?us-ascii?Q?YJZnvfEWiYVG+ekIsKsxgyBWNkNL2jcQzJUCmssMLNbMdh1mgGikKret3l3j?=
 =?us-ascii?Q?gqUFvPEaouaRylDTm9Shgxv1DFh4LaFxiM7XUgosxV4V1KGxV0aCKa5rRI5e?=
 =?us-ascii?Q?X5qDehadHN4PyECOyyl+nll7qDHWm6bkGrjVvEOOwHg9QIdBKAcVcRaqjZs1?=
 =?us-ascii?Q?6kX/Xiu5x3ATYBLwiUP9woWe8prGp05p?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jun4e5xEaGdpt6rOLz+9iWKDfzLzf6VzdY4f65vJNEJfjmS3r7Yeer4cqoQ1?=
 =?us-ascii?Q?S/ZRlaPGTmfKr37LqMZM1tLGijmuXh+BR8rOPky2JFzXIIJngyE+F2/48HTg?=
 =?us-ascii?Q?7Ehag4yrLrVxmUz8qB3t2SrnlQq8Mja9Id32RjTYz/yr0bBI3pwvszyOWqVw?=
 =?us-ascii?Q?vsnEZYwm15PVg4LkS/7/YMNI4Y4E12f5Ix+h7VjvG0yY43B36Sqvtw/4SfTs?=
 =?us-ascii?Q?p14y/cNBcbyX/DSEFusUdQtYZ2hBiyxoujXTkoWhPv5roJvjV04UQAOVn2kB?=
 =?us-ascii?Q?p88iRVebI0tcQZEfkoBUnOhEpYPvUaH3lZMGJS81eJPztjGbWvCqRbsMFY/0?=
 =?us-ascii?Q?TOggR4bq4YIQcNS8sOgFzkHb9gObx2uwzSOOl6vHesa6Sht/2JTEDFbPdVNl?=
 =?us-ascii?Q?8BjgxOAmC3WeuNe/m7zpvREGM9NHDI0rXtiNvnRL2JJqWLN43RYhqHitYZf5?=
 =?us-ascii?Q?VBK2OLj+aKl37T2uBkSMuoR8DHQwJaJfREhsfrJIReFWxepKCQPEgIoy40h7?=
 =?us-ascii?Q?1lBMHdAB3Cmwivr5ew0Djjl2F8owKl0l4/2FCUUG2Mhx/BvDEe7pIdzgi545?=
 =?us-ascii?Q?DYZ+PzRdTtCvQuH2rSQhq6BAepEFXEeQeXEOJ2PN4gz5FyeEyULYcaewnVSZ?=
 =?us-ascii?Q?idUooref6Oa48/oLN5a6hcDcy4td/5obK4/F7PTjyMVcEZPXopMx3Zure0ZV?=
 =?us-ascii?Q?4cOsq04r6vU6RP8dzCTJDO5xGA04vixtpyjqUQoQwb15o5QEuVdlmdMANfXm?=
 =?us-ascii?Q?uf4hsHosbhQUAKUk4yCBYAGRzsrhW/Cm2QtuZoa0psSPc9J35lzZQElN4obS?=
 =?us-ascii?Q?EQHXSLiIWUEZYG/vxQCEsNSGwP2Al5+hWXzGI1KLPeUFKn9R3zw7mRIFo+Sy?=
 =?us-ascii?Q?wwq6fbbRkyGN+Va50KIQ0ZMNzzeuDlXtSkkM8SWK6/yUoaLux8aHHIJ8X+8K?=
 =?us-ascii?Q?lr4JB7NJFvBE/1aaGDAHC0GH4JR3yYmXOQZceIiVH7k4A4KF+530/juufF2i?=
 =?us-ascii?Q?zZKIcH1/dBqDELwaImOTCkvsxtrFjvkJS3fDJzDFQtSN6T8L66BLmnrsPJR4?=
 =?us-ascii?Q?T9ZQrrUtl3z7tiC2iFD40U6APZ/lRIhoss8YW6c2lnJzPIB5RzNpa4+6a5G3?=
 =?us-ascii?Q?/NAPee7ln8YuzJG5ItQQWboqeqUEoTM1Cr1kWwTkRyml+dwIfo9VpWdyYD7j?=
 =?us-ascii?Q?F7BH1ueFRUnK4jfCTtM2CVR9Yd4nnmaIE/cE9RAuY1Ih7QtxX1vVmRkZTV89?=
 =?us-ascii?Q?i8XhEihMgkyphk+2ydNo2WKb/37cBzJVae12OqSL2ZhzzkBSbKos621IrJ/a?=
 =?us-ascii?Q?zYHa2rTXqrGog5Rg3Ew3u2EOD0z9XOrVLJ3I4y24oJamw946qpbU0a5JcB7N?=
 =?us-ascii?Q?GAAZGgJO1CMsXK+hgDva87yxI5kyPW8xyY6CaR/G0YnxKmiT3ydDTwjLcBFs?=
 =?us-ascii?Q?+J926QNx1nOQEWy7s/BBQiVuiHwwj4Yof2NSZfN6ZWluFnqgcPWIQwUA0+NV?=
 =?us-ascii?Q?udKW65gq+iKKAd/FHfHPNA8JTJset0gKcyME4iEyY0YTD6SV/o0LsFbTxLD6?=
 =?us-ascii?Q?X1mFkBtOKoTidAhyVKof8aB/fuGi3cA8p9KN6zLZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79ed185-7928-4162-9784-08dd54a4360e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:24:01.4402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lmFhe3wUsaMr3RMAsIEvzp6B87BgdtyKDcvPHJWBYlUsCExvFORwkq0aBrq+vFBqpA2XtN+ri9Mj05iT4eDBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3793
X-Proofpoint-ORIG-GUID: fsEEKP1xK_IWY80BJICXFL5-KHkuFq8Y
X-Proofpoint-GUID: fsEEKP1xK_IWY80BJICXFL5-KHkuFq8Y
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

> Subject: [v4 4/5] vhost: support asymmetric RSA crypto ops
>=20
> Support asymmetric RSA crypto operations in vhost-user.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

You may want to update documentation and release notes also.
