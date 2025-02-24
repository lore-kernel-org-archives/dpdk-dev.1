Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A5BC021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:14:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D601340299;
	Mon, 24 Feb 2025 08:14:49 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5DFB14025E
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:14:47 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O514Aa009504;
 Sun, 23 Feb 2025 23:14:46 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbse2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Feb 2025 23:14:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAUqKSQ4y8GPDTE1BXvjTaBquri9J4qM37A6c1YJPnOWVl26Ixpc0NRL1ltUjvuyY2owWGJyCXmVOdsxilR702irLhOkbD4USkWitnrz1DTtzHej5r8tFKwh7nNdDN0QG8dFozE8PQwosb/EuzkvK2xB2pz+mdwlgzFrwPVsRm6iGKOmkLIDNPv4Gf6FZr/oLw6HUNZpe/jxoCnSyVOZsk9wAQDSE+4jpNs7gnTenmsQyW30zS91DiOxIlfR30mvt8oIVugJlSbGIYF4WMJiDsSXIoA/gnMua6AFVjtTKii1d7rh2xOsPJeplefSGuQDJKHPhQsYzt/qgBNBsuiY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EQgEysDZyUZLRPUiIJFCcwGy0l/5K3o2+nX9T5ngmk=;
 b=X+vksviDaoHyngpe0ch01DTEEIrgh6RU4yy+MoeVYcE0ea7rw9keCqDxVbHeJ0IOWOuqbVnsuwYBgAR7djFYZRvLfG1IPLRcvzpLjefsQyEfHrlDtA3BjUFzGkxq7BoFoCBsYc/zMt+TiXKodAVnvrrqfLA79+3Rfkftn2u0mqi26xAIjnyBoldSRRemG/Za64abKFVohq0h6ZMbHeJqlWn7Ts6OUO6XlCSeRPxKG9ckvN3+XXwAY7JjxM6PAo4DWSVXONhjyfCS+1ymIaqyNZPbz53sfSE5PSEqzEhWvMjHEBCziXmMWoO9qCMrUxi3AlkSOsouYvCOEE3h7zgSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EQgEysDZyUZLRPUiIJFCcwGy0l/5K3o2+nX9T5ngmk=;
 b=XKGosqpCvXotsLKqy7uiBlsrUgAuwt/dUXv8zbXEwEqpE7vmGUpocwa6r2Z39/M3IDgytyS87Ukz0FMIJRPpcZLa+3UQMS9vOYXeSPAQ5xWp7zzEs533vhQdNCb+gHviPEdm3zJkIYXC1pmSPKKMt/i0Fsui3RMEIF289IYo5xs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:14:42 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:14:42 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [v4 2/5] vhost: update vhost_user crypto session parameters
Thread-Topic: [v4 2/5] vhost: update vhost_user crypto session parameters
Thread-Index: AQHbhQUqtzRsrgCGt0qfDc6qorbPzLNWDSpA
Date: Mon, 24 Feb 2025 07:14:41 +0000
Message-ID: <CO6PR18MB44840BDC4C414B1B10AE4B45D8C02@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1740212213.git.gmuthukrishn@marvell.com>
 <c4c8430e62eff1d67863bc89b1a309e435aa2c2f.1740212213.git.gmuthukrishn@marvell.com>
In-Reply-To: <c4c8430e62eff1d67863bc89b1a309e435aa2c2f.1740212213.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB6379:EE_
x-ms-office365-filtering-correlation-id: 24fac12c-1ae9-4650-e6be-08dd54a2e890
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2ee7bNlqAGvjgAEaYAT8BUY9wFAwPpLfG19gE3VjyEUSu/9+Z8lex2keDHYq?=
 =?us-ascii?Q?0HXDr0YMco0wofIy1/7p68SrEhtnvUnO0YFyiACFAbncAnDHujMU9JKpjca6?=
 =?us-ascii?Q?cmRcMTpBJO13pb1VhtljIuXB0gqpoyUtnDMrQqaylARjgkGLwRHVcmSfbJL2?=
 =?us-ascii?Q?jUunMxCVzfuWibHiSsCij/K60VZLxZsqc2R67a7AZC1hkDYKcniqSzcBjDO8?=
 =?us-ascii?Q?oDOpuecRNM1kvt6ShyE74YM2vzJqH445ewVbaDDP/EQmuGMCEmtthBGcyw6g?=
 =?us-ascii?Q?N7yTDq+6wA/ky/asdvgzo/S92V09hvlR9T3UbWs8G6u8yRBbSmTQUfMvy5Ih?=
 =?us-ascii?Q?pL+GRgwfr5Sc9zLsYiBmfeRl1HEBxz403UbPRxs35XlpnKFd5G2fAKFkFSDp?=
 =?us-ascii?Q?9Ncy2UhPhh3a+SMCBE1GJKppVjKo2hQWwVN2W5RDvh5zEEXX2BW9rLYIHKpr?=
 =?us-ascii?Q?Mcs0hLPIU/jifJUgWh8htnJyLIzxXg98dIDB59LNM3AMRkQHOLN4GlhAtz7M?=
 =?us-ascii?Q?/FJhC1EGlW4w5ecqaJIt3/OJ0Sjg6WdzH/xRhHpNGfklO8YtDkL+07XXdjVL?=
 =?us-ascii?Q?QQCI42jVmh7d4nrUkraNWlC9nrIbIkuITSQh2uQDIfzgu6l0/DfhgXyJf375?=
 =?us-ascii?Q?mR7NE0wPSOcNU7LMg4NFEKm8e3qTiWahx51kOKSrV5tgWCv02mPtKOdK1vNm?=
 =?us-ascii?Q?fzdFjpVkzXgaeqZVS9QThfr+mABz9gJx0WKCov5lt5EGkaTfjbxPU409oMRi?=
 =?us-ascii?Q?yZG0kGbtkWdNW+sbbgQL6DK0K5oSwC2NYnefBNDLFwRAvecEHu6D0+0t4GMF?=
 =?us-ascii?Q?cJnXrMuVM1/txS+7IRz/Qn0Uf2BnUQaQvhbRGcg9CYmCcIyRrqRkXAnKeNN6?=
 =?us-ascii?Q?bROb7OPapA3PXlmWg32vynfvMOzxynbgJzeiGwai0LH5qtk79oTIHQ9nlSsd?=
 =?us-ascii?Q?R1yKoNihHzJkRn6/b/Qm9qEOQlOoQ7PVxy4sLawTEnhdBYkj+Q1U+2GrbYg0?=
 =?us-ascii?Q?d//98EKj1wLijvy+C6MzqG8+xtAaHGGY/2pfNtDa/oaKTh5RfFxjvL1HFDO/?=
 =?us-ascii?Q?1ooqnzzlwP5IhElnFYgKTltvrDfyBgAmE+mdwISwd2tNgogvHnW1X/1MNako?=
 =?us-ascii?Q?m5N2HwQ/JsuLqf9a3aP909Fzu6z32euLcLQy2Y/+vwQR26rTAuWKdxLYb5FQ?=
 =?us-ascii?Q?JPFhWgYQ2gVOdCjUK6MxEoIk9oXgwu4keKLVyjnxqdcp5Th11fwEm0d/h2Ik?=
 =?us-ascii?Q?8X0AuC5p79USpYhRZe3tDyGHlAmwLdstfanfDl2XLtVwEuF073B2X5zd+Jjm?=
 =?us-ascii?Q?hRv+Mczgeq1B1mGpER+UI4nf0dQ/KkcfZebaxF0a09RlNDbIJJbchzzcq4wH?=
 =?us-ascii?Q?rpMZDPpGQ5BNhOCMoFZAs8/15p80tWTEY3THDD4L+/ZRTvxrRqJMYTZHZNn/?=
 =?us-ascii?Q?fQOqdRJXgRuSCSZ4MNAlC4JIMRoZhmUU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0YySqbno2l4ymxLDV9xYfiOLvQcToaXaGoYp2jMe7G2t14kkHuZhMduqyD6C?=
 =?us-ascii?Q?wKQkCcezG1xAlTdlxkVq6IHm/rU8kl++Cnrga9eM424YhWEyjm6YfYurtn6B?=
 =?us-ascii?Q?JwxQQZvWnrxjZ2tiDiWK2T1h1VZ3uWYCQ51ZK6fPFxIpH02jXByqkunqUCqt?=
 =?us-ascii?Q?jmUgAyyIFb55DklIGrW8TAZDUeYwNoZV+Xwr1Cvew/VC4b0yVmUo5Xu2QOST?=
 =?us-ascii?Q?ojlB1FIa56T++j1y6upEz9VtA9niW9TU1y3QQdA4g5FyguYZDaeYJMFGhxTP?=
 =?us-ascii?Q?u8FE7ewCMkyCbsTX7hKDJML+xXzAi1a+Nl1vCpy9hDw2HYuhoxACCQcVOFLs?=
 =?us-ascii?Q?4VfxrYpbj8WiHYDJhpgDj2oMDn7t8rW941jjCi+wrv+kSa4+BJ3lgEBxquvt?=
 =?us-ascii?Q?S4rr4vxe+t95hg1QZvHXvD25As2+CCPFNGWFC27/5wMSKz0/dekS+fwGDN5a?=
 =?us-ascii?Q?3Nr/TVbXqJwTEx7adWG+iTbDuAM090tDHV+GsJnj1v5ZbIKctl0cWWHXB9e5?=
 =?us-ascii?Q?07qHoTvx87HJ/d+cDJ2BxLXoCKNFp300GGXJhPMKTgdbm8XCA9FjGIxWjoa5?=
 =?us-ascii?Q?9ysIB8hR8G439QnMKkU1oz0bOTHOj6F2ru0yebE75kTr09kA8yDpDO4VlZgE?=
 =?us-ascii?Q?7wL4sfLTv1woZzMLwSEMgNBlIGdUptZEesp77Bhr71PdooNQHQB9rt4D0m8S?=
 =?us-ascii?Q?pKh6ktZs/2OI2+qVceYSeWqM38MUbG7tK4smie84DWttRz+vpyTkhnY8S5YN?=
 =?us-ascii?Q?X9wBdumSHXzYEkeZR1M+7WYnA+Mar1YX6TfEVdgHQlQREAsGVADg0tnWpxuw?=
 =?us-ascii?Q?NmJv34ffwqqg+nqnNz/LOC/jVeCQx/aHAFaJxywdFrH+pFjGEm3oG9jMBR0A?=
 =?us-ascii?Q?2NRms8pQ+JqK4/EGjPsOoU1GUuSA25vZoh87Y1PlFgoPU9GoPwJ6Lp1vFekO?=
 =?us-ascii?Q?XlA+4O6sJSpBRlwItRFTwJnGvSBSCCez8aackaxJfG1V+i4Gu/BFh0NNZu5W?=
 =?us-ascii?Q?OpavuLVxqGYQ1OnmEPXXudfqLmIcxM7ZFWug64a0KMp6SXBUoJyIP1yU2V28?=
 =?us-ascii?Q?pK723DuFwSztQShBpZeuePqdZA5TnZr/XwzbpEhewJJR6WHcOCXS2ZkAvbEK?=
 =?us-ascii?Q?32jTF3fBudQf+Nhhvu8dOh04ftDo3HDUjO0Y+dKyVjJ1H/Ys3R0tGXzPf8+C?=
 =?us-ascii?Q?TrGATBqwvL+QACtlMH7ghh5qkawF970Ty1oK+hepfxd4z2MK+yEi35i1mEoZ?=
 =?us-ascii?Q?dYXfl53WsDEGFrmRKk/fnEfWD3Q+aKAFrNihVcGix3EISpfS6wNfMLFQl/EP?=
 =?us-ascii?Q?jTLDQ1p1YbXVpmO7uc4yjJrf7KHiITezDn1bx6nH1+KixX92GHG8jggyH4F1?=
 =?us-ascii?Q?ZOrqzuSi4mWjHTZJfw01/j4TAG5sDvXWc4d4oMp+cLH4I5yIQNBeuO0tGLil?=
 =?us-ascii?Q?WF2NZRQwmAh1CMOMHYfvgWrRFN1nT4M7xZ0I3aNbY2F83c6gvc65nbrld1Sr?=
 =?us-ascii?Q?sEgWmMXgAvK+AoeEg9ICUI7+U2EySpsV8qPpI3+ZJNBxTO8BEQsxkBVGp+1s?=
 =?us-ascii?Q?2dtSck/xXWUO/H3xHfhLi2Lsxs1KHtwFxzk1DHcL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fac12c-1ae9-4650-e6be-08dd54a2e890
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:14:41.9634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bE5ItR6TE9Ti+L/rRpHrljs2CQo1OgymGNmu8o+g8NBkDtsHJGCEL91NQLMrIkhxdcNm7CkYMSE5wIwZDfndPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6379
X-Proofpoint-GUID: YyIa71Jvv_1lu5pN4rw04GA_0wNGnbG2
X-Proofpoint-ORIG-GUID: YyIa71Jvv_1lu5pN4rw04GA_0wNGnbG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_02,2025-02-20_02,2024-11-22_01
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

> Subject: [v4 2/5] vhost: update vhost_user crypto session parameters
>=20
> As per requirements on vhost_user spec, session id should be
> located at the end of session parameter.
>=20
> Update VhostUserCryptoSessionParam structure to support newer QEMU.
Do we need to update QEMU version in documentation somewhere?

> Due to additional parameters added in QEMU, received payload from
> QEMU would be larger than existing payload, hence breaks parsing
> vhost_user message.
>=20
> This patch addresses both of the above problems.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
