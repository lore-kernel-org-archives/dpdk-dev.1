Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9B1C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 18:00:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C957440288;
	Thu, 24 Sep 2026 20:00:19 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6DB844026A
 for <dev@dpdk.org>; Thu, 24 Sep 2026 20:00:18 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OGEB7Q3282432; Thu, 24 Sep 2026 11:00:17 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020122.outbound.protection.outlook.com [52.101.46.122])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gw76w0g4k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 11:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np6YTy9c2/JnFCwkbB45P+VHJnZ8+qWVACG71KEplNALa34DL5H8LTi/MSXrBJcBWdA5dH99f1/nv7+Dd0XGqzyTKbq8MTjah+HA9TRKTZZKBva0D5hJsy+4PhozsV11RJXHi3vpkSqtd6sbDomgTFytgCL5Qwuld8nDr1N4EX+qMLThoPzGZ7EmIGtfwA69DPgh1a+Q5OMugkZHu6UYRaFjP8vwX5KB+RbwIwLR8PhMSDoCe0ASWemXcOdENtLrGcIrPSr4fdXIIqCJnN3+n+XCNidQ5hGikdp4wBXIsVydXtjOP1F2eFZW66zAS4oR+dmFYeJI9Q+4Vkou9bauMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev7r9zxnPjq3n9J41rbmRaxytcs2yAy/qg+77eL21ww=;
 b=R0YRUisQw64czrN2OBn/M50y4Dz+U4SNfSNdeGrAtVQEi8nV6XHdadJMs3ltycSPm1kaJdEs443SBXxsGrHSGTpKdmSyEXSsxSgm6utWit+5186CctBQNy+qQ0u2xsLBSC0Q9QQre6vpvME9iUIPsdC5qA3TbaMs5MsTh2HSZ4xrWP7c/M611oKuKwzGJwSDO6Whw2MkRc8X3ylrusFTRumJrxIU8LBzewBbuJfKp4P8xmA9ZPn6Fue0o2Ek6fMQ4pFFmnmyCvFJuDaVRHXsmuHA35R+A/rWVudfE1tm7cy6Cob4s8EzQTlPNPi9CcuAeGJ+s/ys9HdRPjLlviLG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev7r9zxnPjq3n9J41rbmRaxytcs2yAy/qg+77eL21ww=;
 b=M0LIdNq6//nd8+uE2p3p/XAD3+YyAKZyTsOri3im1xCWDwSSdS+PQn+Hfvl1CAFKeJ1hjVDW48Y8q/d2cyMnN5Nzs8VgIdIMugBQOa6YUGtpKwAB4TBBaHF1+3MdBAqTH/M8+mx42cbBqjbRlfnIh9Rp9nKTx+NEiAhg7wRWfhk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5830.namprd18.prod.outlook.com (2603:10b6:8:42::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 24 Sep 2026 18:00:13 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 18:00:13 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Topic: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Index: AQHdS2zyS5RF8y84q0yzRR0X7h1hNrbdy+1AgAAIWYCAADCr8A==
Date: Thu, 24 Sep 2026 18:00:13 +0000
Message-ID: <CO6PR18MB4484077A45CBFCF6CB562E20D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260923105003.2811322-1-kai.ji@intel.com>
 <20260923150454.2831132-1-kai.ji@intel.com>
 <CO6PR18MB44847C8EDAB63BA96FAA586ED8812@CO6PR18MB4484.namprd18.prod.outlook.com>
 <LV2PR11MB6045AC38B49432A2FEA9C20281812@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB6045AC38B49432A2FEA9C20281812@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5830:EE_
x-ms-office365-filtering-correlation-id: eebf0519-d3c4-4990-b1dc-08df1a65ae9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|56012099006|5023799004|18002099003|22082099003|38070700021|6133799003;
x-microsoft-antispam-message-info: FwtLxoFeS/f2loNNwCcbrnrs/YjqT933FMJBHh0sGIPx9PlNATTcjGgLh7C86VjGbn07NiL8IzrC1BdtmMFuZPGw4KC/Ib+K5ISe2ejdAVCKK49V7VERZT+wMBlzuSyupmQQR6blQk78BWNktpTy7EWwLTJDuzuuQgLH+InJDxPgmBo8mzp+XHo9oxkehevLPzpB2DCuwdlasSvxf+RQGD1ZxnyU60M2yMiVXQoTzyxWsm8hrGPrItKKA7NZOzGuxRbmqfL6ZNcD+iC+GSRL8ueDObwCqgrtozzdHekqBxHchYaevk6dOIsGlNR/F6T572SSI5vpi62WbyrNXUt0u4ky1CqR+rm7EokraXv5XFKbKo8SNgyDH/dg/t0iJrJU4XPtUyW3maij6TbDVhddlBadOqe68SxZxJAboiZHmQeAOEIgJLCoWGtU2Zlut2gdhlqfYqcGlTxNsKGzO+oMoxaR3SIaJlbrytP3d6c6cjWhrE0MXEYLlFTn44CvNpYS4JrcpgmsSYfjmBLufT2NQk2DJg+DuET78G2queZEf/ozSTRhp92P9xgZvE97vMm2zmxApkFmvysF2DzwSopx1cHitHvmbzzSWQ4tH4T7c346btmZCBLYM6ZK7FJWqlLz6icHMOvSwOGt8FjynzZYDnLQNfIOpV6KwbK+mXLpVFuKqjGKuuXFqzIQpljqqlq4IIcf9WrO/BRrm3Dz1AE4mxPyM2WpxuBY294hBFTaJo4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003)(22082099003)(38070700021)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GQnBbOzsV4qiCpSj5xKi4XANKK/L6/8IPovhx5VH+nugkxBsTbbbZ9PalwmE?=
 =?us-ascii?Q?VTst4yzh1UyUTakVw3+uHCMYyEGVpAQkcXqk1oWpJimZ6rPe2E5CDRmdqZ4t?=
 =?us-ascii?Q?YkpLS0hlE2FNqUDEBBrh0vRsIui2LsnLGOOfl6Xz2EzDkHhylzJj6lTvLtQZ?=
 =?us-ascii?Q?5d5/Em5asQ6hKHJW0NPSqbSidWjnPWDi5GBxoeZjm9+XYEaMJggkWkYNjVFa?=
 =?us-ascii?Q?dQ8XJNnzJmd3lhmAQiu0uJmi8muR82e731TfINXbBnaxgIDBUz3+5xEjmBuy?=
 =?us-ascii?Q?pGCzAQhYtWfj+wKhMTpGLxCohVwIuDpM4YI8siodvteDmiixwckQAQIWU2Aa?=
 =?us-ascii?Q?S8cltxj+4QY/iVPWQ3uZvh89h0DABULfHY7Dak7A10cw0q5PvQUU7coTQVWi?=
 =?us-ascii?Q?qIQo8xdI1RTejjtuQHaHVCB7DeZGCgnL3NhF5ZTqoesao9Z3BGsVogTQuNo8?=
 =?us-ascii?Q?YVyv3U8xX4E4L511ev1a+qMn3EFm51X4cA0GtLc8/8wNIKt8PpQ4nfgZ7LAy?=
 =?us-ascii?Q?I1Ihoj39Jg/4cmCZ9mjGqGZva6RkQ7+7nFMtjkI5EGPYd0trT3tQvogkrV81?=
 =?us-ascii?Q?C39LgJga5SPRvhiTBVNbL2/XQ/EJx6TZ9ZEy2Cfi4cjSE9esMLmOj6na96FR?=
 =?us-ascii?Q?EH9Kzs4IBAYMXpAoU0QTrC7Al5ea5hOspW7FLHLsazoVwuEjtnLOXFEj1tOa?=
 =?us-ascii?Q?lly0ldblYs538X7A/UbIYzkthowoNjqLx3fHJKuQc0PBSeIqNFUYsWEJiP1J?=
 =?us-ascii?Q?1B+Ft29m86yK6siJDMsfAjD5ykrwboRZmGrB8KZeHfVefzSUFgD7SAmD4NfB?=
 =?us-ascii?Q?Mh5G2Qs3Qj7GmEvhZ6mbrsiy3aLPFRDAVGZJJqD1bRzT3pXmjO6lwF4ggzOb?=
 =?us-ascii?Q?EPT1nvjXIVWOhYH633Ey8su13cb3fEf2PVJBQth6Luh4g4YlMcCj+xeiZEIs?=
 =?us-ascii?Q?lCSdiHojeFJ532KbOYayYoZHK3mEWt2GAohOd+cnA8vpEZe7P6eq0yL8k6VY?=
 =?us-ascii?Q?zIiuIVQndnhQ5eOenL2HlYKtZJ+0pLBFa6TPA7OCiecpM1e5pV9BaitOmITY?=
 =?us-ascii?Q?Bk6M3y6rlz/g6L6wKdelcoymt0dbzQjgql5KLPmbiKSRVEwWfqO0UEZuL8Nn?=
 =?us-ascii?Q?u3ri6kAQ9N3R2L1BW/UTMpsJQIijYezXkK9CeuwE+tBLY58bQtO6ElBDUcGQ?=
 =?us-ascii?Q?pQ4DMVxgNj41z1XPO/77tr3+/042PTUw1HSCC4E5FCLpDL5ZJ0z19XjYWorm?=
 =?us-ascii?Q?Sf84KGOxN0qJXu1nuKRJDCBYe5iaQh4ZiN3yKM/IQrO6+LZfnM79sjdTiijm?=
 =?us-ascii?Q?wYumqhenqh7VbrQqxxa0z7ccjYLUbJ/gwHCFA3P/dw0K1pVW3JB6pvHusM6Z?=
 =?us-ascii?Q?iTKk+8cmdZvlg9YneQFQBnTJart2fBDPgZyGcN+HFkyTl+2+ff6fMsSh3ZD5?=
 =?us-ascii?Q?Y5QsQe97G8JFW/FMGabJ0iNjm8IgGc9bD2oAVSww14u86Y6nFwKvYvSaViza?=
 =?us-ascii?Q?5Zzna3TxYmURyCpDX8daacF/v0BzPkjcmCgDBB1c93k+ln4iCPI48AJzfYFj?=
 =?us-ascii?Q?vWkXp73sx5G8H18SlKh8kAO4EkePXLz49z7i6Xiy7VyIdJ0NuGgtDkudawNw?=
 =?us-ascii?Q?DWYsrrvIIzmMtIWwEuZxYbp4y+wabol5n7v4LAXeBJQr7E+8M8be/JMsJig/?=
 =?us-ascii?Q?OG7r7Zm0o3jFThB8u/KV0//22taGBMiPQbJtN5YKTj9fxVl/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c1lqiFanKX2Ttv0Y1L3h2V7VEDs1MPhOXDpZkwaonpPHcvnJz6IV5viArZeWQNunTWo7+m5q/Nil9TB/1o0R13AreKCE+pVQh4qwbkGHz9Q+hTtNaWZhLXyOS9Nd14dLyJSFu98ZDXo8ylS7/75LjSR8cWEFEnK4oNIv4FHE1n+891DcarRxvpUsAPUg4NlA9R6fhG1cPIgR15qUnaxH8HmvKyLB62TnrwHLSBrhjVnJum+y0U1U3q2ubc4XwAQo1AYKhbfIK3r7Oay90PNbGhocRawp9GLeAAVJWGd99snnb02/CMnueXGwRYMk1CsGA9BNbIpXZOq76EjE9DK07A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebf0519-d3c4-4990-b1dc-08df1a65ae9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 18:00:13.2936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgs1nSTlC6wcXXKL2vv92lShfcULuvB6/2b2FtzdbqGdk0arrE+5IjNg+Ui+cJr974Bo9F2n7/VHh0T9NvR2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5830
X-Authority-Analysis: v=2.4 cv=aP9lOr9m c=1 sm=1 tr=0 ts=6ab56531 cx=c_pps
 a=Ov5XJGn/dQMl/+TwTE/lXw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8 a=bt5KbKNvAAAA:8 a=Oxz6YPNgr3hofVCnLRIA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA3MyBTYWx0ZWRfXxKE85VhTrYup
 M9hnzIJLPaz1dXD4e2a+Gs+e2lOdjfwtha/BVO4NfoR4yQWBoUBjT2yblMYJZw7qPCpFjaJtC8+
 gSU8O8DOnP9uIfpyZoMiC1aSzu91g2c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA3MyBTYWx0ZWRfX3wusYyBXKo6L
 4S3a6Ey7vZDCsRnjFYc0mvgschpTj29iHpdXJYNa3Cw3QbCJk2C3QLOwWKVfP9se1Gn/eXybxxz
 lEQPYFsmyGtnLbrGNhGboUB500i4gD9qbJmmqTOqiOYFq1PCx3cMSedZ1Kf7wOj6alCSE186yfp
 7YbQseNeAOwk5yw/ybL9rJHbVhlcj1HviwjlRTpd83fEYkBs2+kIrjkiy5dNOxo8HAipTEhuGzS
 1sCggEB9iLdJbZNyALLpxk1aUVdt7vobNJMpy2KF8cv4Iun9emGXG8ZWU4Cwl83C7StCp6fwCKD
 V8TeyiNb+1QkcgZGX1aTU3QmtfWHjJCmo8gPgV1+ujR/YyMZIfdRtdQNMw6cVpPP4vSQI8UBIJ9
 yCOEmmOzea1RPBIKsEd4MjR9YyCQi/8CcU02pZSMeso7rX9ugZjQjkFiUcjpkgRRmu1/PScMVXZ
 MaUT+GBfZSLqnfoYI0Q==
X-Proofpoint-GUID: szvcByas44TW6Wi3NncM-uqyshLdMv4G
X-Proofpoint-ORIG-GUID: szvcByas44TW6Wi3NncM-uqyshLdMv4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
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

> Wycheproof differs somewhat from the existing cryptodev test vectors in t=
hat it is
> an externally maintained collection of JSON test suites covering a large =
number of
> edge cases and negative tests. The intended usage model is to load the up=
stream
> vector files at runtime rather than embedding them in the DPDK tree.
> I think the existing examples/fips_validation application follows a simil=
ar
> approach, consuming external CAVP/ACVP vector files rather than integrati=
ng
> them into dpdk-test. This patch follows that precedent, with the goal of =
providing
> file-driven conformance validation as a standalone example application.
> I agree that the documentation can be improved. At minimum, the .rst shou=
ld
> describe where the Wycheproof vectors can be obtained and reference the
> applicable upstream license, as the current example command may give the
> impression that the vector files are included in the DPDK source tree whe=
n they
> are not.

Ok, so in that case did you consider integrating this app into fips_validat=
ion app..
May be we could rename fips_validation to crypto_validation and internally =
have 2 modes -=20
Fips and Wycheproof? Like what we have for examples/multi_process?


>=20
> From: Akhil Goyal <gakhil@marvell.com>
> Sent: Thursday, September 24, 2026 15:35
> To: Ji, Kai <kai.ji@intel.com>; dev@dpdk.org <dev@dpdk.org>
> Cc: Thomas Monjalon <thomas@monjalon.net>
> Subject: RE: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation ap=
p
>=20
> > Add a Wycheproof JSON vector validation example for cryptodev PMDs.
> >
> > Support these algorithms when advertised by the selected PMD:
> > - AEAD: AES-GCM, AES-CCM, SM4-GCM, ChaCha20-Poly1305
> > - MAC: AES-CMAC, AES-GMAC, HMAC SHA-1/SHA-2/SHA-3/SM3
> > - Asymmetric: DSA (P1363 verify), ECDSA (P1363 verify),
> >   ECDH (ecpoint shared-secret compute)
> >
> > Validate valid vectors against generated ciphertexts, tags, plaintexts,
> > digests, shared secrets, or signature verification, and require the
> > expected rejection for invalid vectors. Digest inputs for DSA and ECDSA
> > use the symmetric auth path, selecting a separate symmetric-capable
> > device when the target device is asymmetric-only.
> >
> > Skip parameter combinations outside PMD capability ranges and identify
> > recognized vector families without a compatible DPDK transform. A
> > --debug option lists every failed or skipped vector.
> >
> > Add Meson and standalone build integration, with usage documentation.
> >
> > Signed-off-by: Kai Ji <kai.ji@intel.com>
> > ---
> >  MAINTAINERS                                   |    5 +
> >  doc/guides/rel_notes/release_26_11.rst        |    6 +
> >  doc/guides/sample_app_ug/index.rst            |    1 +
> >  .../sample_app_ug/wycheproof_validation.rst   |   50 +
> >  examples/meson.build                          |    1 +
> >  examples/wycheproof_validation/Makefile       |   40 +
> >  examples/wycheproof_validation/main.c         | 2090 +++++++++++++++++
> >  examples/wycheproof_validation/meson.build    |   17 +
> >  8 files changed, 2210 insertions(+)
> >  create mode 100644 doc/guides/sample_app_ug/wycheproof_validation.rst
> >  create mode 100644 examples/wycheproof_validation/Makefile
> >  create mode 100644 examples/wycheproof_validation/main.c
> >  create mode 100644 examples/wycheproof_validation/meson.build
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 186cc82b39..580e2c2591 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2099,3 +2099,8 @@ F: examples/vmdq/
> >  F: doc/guides/sample_app_ug/vmdq_forwarding.rst
> >  F: examples/vmdq_dcb/
> >  F: doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
> > +
> > +Wycheproof validation example
> > +M: Kai Ji <kai.ji@intel.com>
> > +F: examples/wycheproof_validation/
> > +F: doc/guides/sample_app_ug/wycheproof_validation.rst
> > diff --git a/doc/guides/rel_notes/release_26_11.rst
> > b/doc/guides/rel_notes/release_26_11.rst
> > index dec96ccbc7..cd2711ddad 100644
> > --- a/doc/guides/rel_notes/release_26_11.rst
> > +++ b/doc/guides/rel_notes/release_26_11.rst
> > @@ -133,6 +133,12 @@ New Features
> >      with per-descriptor mbuf free (``rte_pktmbuf_free_seg``) and prefe=
tch hints.
> >    * Changed the set of per-queue xstats counters.
> >
> > +* **Added Wycheproof validation example application.**
> > +
> > +  Added a new example application that validates a DPDK cryptodev PMD
> against
> > +  the Google Wycheproof JSON test vectors, covering AEAD, MAC, DSA, EC=
DH
> > and
> > +  ECDSA algorithm families.
> > +
> >
> >  Removed Items
> >  -------------
> > diff --git a/doc/guides/sample_app_ug/index.rst
> > b/doc/guides/sample_app_ug/index.rst
> > index 28c4c9a5b2..2458b06ccd 100644
> > --- a/doc/guides/sample_app_ug/index.rst
> > +++ b/doc/guides/sample_app_ug/index.rst
> > @@ -51,6 +51,7 @@ Sample Applications User Guides
> >      ptpclient
> >      ptp_tap_relay_sw
> >      fips_validation
> > +    wycheproof_validation
> >      ipsec_secgw
> >      bbdev_app
> >      ntb
> > diff --git a/doc/guides/sample_app_ug/wycheproof_validation.rst
> > b/doc/guides/sample_app_ug/wycheproof_validation.rst
> > new file mode 100644
> > index 0000000000..17c8bd2b55
> > --- /dev/null
> > +++ b/doc/guides/sample_app_ug/wycheproof_validation.rst
> > @@ -0,0 +1,50 @@
> > +..  SPDX-License-Identifier: BSD-3-Clause
> > +    Copyright(c) 2026 Intel Corporation.
> > +
> > +Wycheproof Validation Example
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +Overview
> > +--------
> > +
> > +This example validates a DPDK cryptodev implementation against the Goo=
gle
> > +Wycheproof JSON test vectors.
> > +
> > +The application reads one JSON file or a directory of JSON files at ru=
ntime and
> > +checks the supported algorithm families against the selected PMD. It c=
an be
> > used
> > +with a PMD that advertises AEAD, MAC, DSA, ECDH, or ECDSA support.
> > +
> > +Build
> > +-----
> > +
> > +Build the example from the DPDK tree with Meson:
> > +
> > +.. code-block:: console
> > +
> > +   meson setup build -Dexamples=3Dwycheproof_validation -
> > Denable_drivers=3Dcrypto/openssl
> > +   meson compile -C build
> > +
> > +Standalone Makefile builds are also supported from the example directo=
ry.
> > +
> > +Run
> > +---
> > +
> > +Run the example with an OpenSSL-backed cryptodev and a vector file:
> > +
> > +.. code-block:: console
> > +
> > +   ./build/examples/dpdk-wycheproof_validation --vdev crypto_openssl -=
- \
> > +       --vectors ../wycheproof/testvectors_v1/aes_gcm_test.json \
> > +       --cryptodev crypto_openssl --debug
> > +
>=20
> Why do we need a new application to perform test vector validation?
> Is dpdk-test crypto tests not enough?
> Can we integrate this in that?
>=20
> And I do not see the .json file mentioned above in the patch.
> There should be a sample file atleast.
>=20

