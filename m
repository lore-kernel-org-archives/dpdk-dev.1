Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802FAFCC9CB
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 06:10:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA63A402B8;
	Tue, 10 Mar 2026 07:10:33 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 972E54014F;
 Tue, 10 Mar 2026 07:10:32 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A4BjH9461905; Mon, 9 Mar 2026 23:10:32 -0700
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021134.outbound.protection.outlook.com [52.101.57.134])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ctc28g646-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 23:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9rallKj+cMrqrLk4hSXh8QU84HkimIfAKmslZ51LlRx94k3CfT8lzJ9SQLRCyVbVHtGuK6f6/yINi87cP9EIZDE+IlI3eO9hM6st/qaElNUsdT5rDkLTil+emVLoPjOoi6oGwZGKFMscU/fGBTZy6wwtFMwk5V7vxc1XVx8oCmTjyciy3B0DwKGtPl4O4h42gM1SjDU64FuC/JqMFty/SjRo4TrQ7TNk77EqKB5zBfZJ3Y+wY6euvK9TuN2Xv/Ypuj0lrwMwwfXn7vhIq+y4rPTogpqbSAkBpjXNWvwv92OwyAZxGwr8yDLP6SsZKXD6pMj3oIwjZbDEPl2x7mAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY2b5YgkHYT4hKdBYnusxzbXsRXYRlmhkKWmx1uUo4c=;
 b=ApO3+BwECJv8vTvSJbkhl37zLguIrY4HtYujT3esRf+DLaEyIewH8+ChRwLSF26JOUXKjZISG9vKpj3QGy44chqf8SUtrDHhtcNhyvkyTBP13t/XtTRVsQDUWRS8Rg4UXgBN6D81lu5UcM2h0W6zvUgHGEanZjKyK3inDkUzhpiXhR9FSc0YpbMwmvrfwn8o1T2Hq6GFEfKpJaKVX578Lwu01+RQmkM9NQgWH3Gd2435fzDVKyBTSjWaLk3FDOkChpKWvzvTlzxgrS5B9pyC8k6GSUrV5DCz1jCpTOgUyFxRBU3EXiCxmJ9cJ4GmIBHdTj8g5nWw67FR8yr24cjY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY2b5YgkHYT4hKdBYnusxzbXsRXYRlmhkKWmx1uUo4c=;
 b=mk4ZkmlGyQ1q230rPm46zPfov2yf55IImgCsTnmmY3SOeJUrmPkNqpdasYY0FmsifHnE8eLAHtyYT0yZz1TP3EeTwGcBB9pQuu3P8om0FKl8pctCF+Va5Hrux9BtBymvkVp0kuthHRtGbShn6R86kk6nr0H9P5HcKy3M0RgxiIg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3625.namprd18.prod.outlook.com (2603:10b6:303:56::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.16; Tue, 10 Mar 2026 06:10:26 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:10:26 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] test/security_inline_proto: skip tests if no
 HW support
Thread-Topic: [EXTERNAL] [PATCH] test/security_inline_proto: skip tests if no
 HW support
Thread-Index: AQHcql7Mfz5o4AV5wEuFakPMsRcFvLWnVEOA
Date: Tue, 10 Mar 2026 06:10:26 +0000
Message-ID: <CO6PR18MB4484D86D5289706A3A1ADFCED846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260302160740.1292642-1-bruce.richardson@intel.com>
In-Reply-To: <20260302160740.1292642-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3625:EE_
x-ms-office365-filtering-correlation-id: b5fbacbe-e8d7-4eaf-cdeb-08de7e6bb8ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: vkH9m9c8r867BQ6rR4uMFVMX3mpfgCDeuakWsBGvXOKa0dKO6mYLIJukkaoURb1DOmmfJ3xfgUHkVLw+m5OtZ1vKkzV9xso+ES6C7jp6eApA82Dx4krg5+KNBnHk9ekFSOWfjBLcFb3W0Z/pRznmRay2FTRUv9F5wSKFuf/K1zOjlmF4pcW5TZVGaexf3l+0SeC8BiIdVUgqcdL6E8c3Mo4xHCecXugIzCwLymO+xYNFgrNYhe/MhBbKdotDn/1wbu15gK6H4kSyU3eSsBj90MsQ0NrEt+feyQU4O9xVUzUhoQE04Ypszs5RpKmSlJD4T3j6IAjW2HWT/s1mGnB91ReSmAKeG7zslAOuWKnix8CaSOnrC/ZHJDcqf8/5bE5cyEQpS8dfxVBpTcc3qPuLDRK5rptWIPNi0j4Fz8gd9Umjst9R9Jj19r4JPvwjclGKcOjtxFjn0m75JGNL0I4gYyt7hQIIs0e5PTwHBgI1SavZHW9UubvD9mIZlABnRJf3BdoGmAS9K5XvL6q80Ipa5DZpkLsnqnj97LLilfYFaoXtUOvBr+N0X6wi4NtTI8FH/GI1SpeB9xfmhBoPs/o5y+/JReV6sNCIk2HL2keJL0LaJDFpuTp4ewSQVvmlXXo2YPZUrUGZ6uPP2uBrI1hkvh6VBdPahMKqUBXwfrhF6tagXFu5rg2VBoqNKYNFC8h2lleGvErxIVeulbB4exAXiBzQ8zxCOIL7NIRpzsDJVCqEGjESIxj3MlF6ZdKMg9V4jwBbNhjE+fs64Oaiv/ozOGA908qmFKZCCBzHjEnfvfY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yx09ufeh+JO0sV5py9n/fuL9j8zp04PtDo75OZ6jkfjtA+Kvy4n1KET4O2HB?=
 =?us-ascii?Q?L6cDrJRLqUfo/gWKw9eYVDfvikDVsaG2X0KIG0RQ5dZdTUcn+p/oXuvkFX5/?=
 =?us-ascii?Q?2WgIzbppv+Qq61wS1u1e9P/Wf9YDvzOTxtpTXH9avwNPYd1WfQ4Wt6Bk67pb?=
 =?us-ascii?Q?z+vcXvsH5KGKLiHTOKz5gGBdPsHXOrWhkZOuyeC7fT6Doj2z49NQErmZJlc5?=
 =?us-ascii?Q?Qn39jtvioIwA172MDpxViQ7vQDSxartLuK5Yj45JSXsKZDTiVNvW1mN0ajJH?=
 =?us-ascii?Q?vZgWUef/5qG2G1Zjhyym9MNAN8YfmHqBg7AMPLD4VInXuuuDmmerZ490jJdN?=
 =?us-ascii?Q?3VFAsu0Gzovv1YeyLCC833TI8268mkSevWe/rckQI2+/jjylGwWBQKi4EpXx?=
 =?us-ascii?Q?+1NH1BwLKf/hrcGFh1zAVS6ompMLBMef8NiT65reiW/FjIUuJBdyP8rtESZM?=
 =?us-ascii?Q?f1QCaEQGiZtog5QblPgrqAZimHlSbYNxIju4O1a/3nZGVIUE2OiWf5pVwFqQ?=
 =?us-ascii?Q?vszo3RNcBpbNZ6Hhmwl2uNCs+jcIZPlz88pmGFNrAFZae65/KHSZKRnGjugJ?=
 =?us-ascii?Q?ZMaekUad/+U/9fbN79vTwAOY+TF6syXqDTWYpJWmmvncbtr5s34MdQUB+ajt?=
 =?us-ascii?Q?O4D4sopbnPeQFo/KiDKxJa/wgsImEp0EGyxSLYJ/Nv4VPlhqWZvb+vJSvH+U?=
 =?us-ascii?Q?naX0d4qAFdXo5AjsplWeJL5Qs2vop3K9K2D+gqZJTqdtBe/yusLi65esMqqX?=
 =?us-ascii?Q?++TbS16mCm7OUieE0QGDOEKfvZJRrkyMOnGq5jN9EpBAAjNAH7gOB4xTclXA?=
 =?us-ascii?Q?4st1yydWOnesxf5MvTZ4r8Qf8gInly/6oxXl2p4UwuxhCtQDUiZpb29YlMzg?=
 =?us-ascii?Q?A9fCYJO9EuRg7XWy/gz3Pj9E38OZIweLUkkG11TwCJuVCNrphF3ApwIcVaCF?=
 =?us-ascii?Q?oR8Kc8pXoWAaUns7M+jDOWK7exc8iEzUltKvMx4SU/vSVMuaERREb4uYl82p?=
 =?us-ascii?Q?rt7RezsVWJQxLKR8d4ixELyw1pNCSra3Wc7aeGqi22j4NyCBM09mW7W7x+gp?=
 =?us-ascii?Q?j5j/yM/598MW0sIBj5tu55ftK0zgQtAbhzzn1R0LcMwQ9ArRYODCLqPBf3Bo?=
 =?us-ascii?Q?EdrnXpxpPm+RZS1M5yi/UPwHlSiG9wAQR/S1Albn8LjP17C4ePyq8o599yp6?=
 =?us-ascii?Q?dSmv7WvI65V8IvywaX+PZoDef6aW1yBNMK3dOM7j191CxvKRrZ6UBqYJ0qqL?=
 =?us-ascii?Q?50Ys8UdepkQ5qG36oy6GlUfWbnjgJG9HjAmYdr6cUd1OHgHXtG31YTiH9dnR?=
 =?us-ascii?Q?D2TGy6CxigagyBQ3uRassgHyG6W73NYycjsl76kGteuIMoshYwoy03Ds8GBU?=
 =?us-ascii?Q?2dO3VDvQLSap7t0KRMApLDtwPsWJW4afqiM1tN2lKBiUqIk0ny8x9Gdf3PA0?=
 =?us-ascii?Q?YKj2uD9RKgyXkRdlCGhW6fYoaV4/34IHnVqW7NbE7eqiQ9XbmmpErhMnd7Bd?=
 =?us-ascii?Q?MNMXceq0SfcbUlxD4OTZqRKEJCXtC9s63piBQFjE9Qm/92IVK+WwVuY+DfRA?=
 =?us-ascii?Q?ib6XXAU7rrg8dY5bhCDZe7ePoUGJhruDYV/QXumcc+fpoNE+gAgmUZmwYCo8?=
 =?us-ascii?Q?29TOBpl6Qyp+joaHOXUDe4V+GxEErDCxL9h7qIpC3HDxSzBp+Ke72+Nrkaie?=
 =?us-ascii?Q?cNEZq3+/JpV1SF97Doje1SeYl+CLrNeGZ1AcBogkMkSN+KmU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fbacbe-e8d7-4eaf-cdeb-08de7e6bb8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:10:26.2297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIJZWn54gs3c/q6s0dckaPJtqqsP5X+kttYYIjsqDkeXALSK/6OTkM8JzReOV/jSQpD54VLg7Rwa6jFxutqO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3625
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA1MCBTYWx0ZWRfX72ndCAZFOJr+
 wFWarO90eVWs8TvtNxuqic7wRZySsegJzQRTb25/XogwZoUocxyyCxkHXN1F9o7r+qCzr9LVcSR
 aAzGTR6UHK+DymKMeaxzQZK3uyYBi6acbQvW+RCX/tweNkMmFjQ1ZLoJmmP0NsIq64NNzpPtkUt
 kZObz9lmB5dCoRlJU7/hEmxyjZEuFsWYiSE3S+iOinp+LbQJrE12m44PD+FIspS7VAHBYy6Sa8J
 8t52pfmFKEtRqe2kQsmMmyjhhaLni4CPn/JDmLukPnflojy4m59IRk3zN1K+IH4s5Xj7JEb1PWT
 /Y1RGnlmRvDCzx00uYK+BJ7KWtPX6rE8QdZk4Gg+PLvJU0hnHLBlopec2S+Fk145L+3JLLsp/0t
 LkA1MFl9dO9I+wwcH2XkrXV86AE96HzIGbebSLQ1XayHfBko9Btirz+Np7vu6XsCQ4J9m58ZYBz
 RIvFKE87lQ3GiyLocOA==
X-Proofpoint-ORIG-GUID: T_5Ijlu1G50RhSnL5JGgH2whEiRg0txW
X-Proofpoint-GUID: T_5Ijlu1G50RhSnL5JGgH2whEiRg0txW
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=69afb5d7 cx=c_pps
 a=5CsiemZREWOr6tJEzaiJew==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=s8gkLCF0ANtFTWEqzZoA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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

> If the underlying ethdev HW does not support the security offload,
> return back the TEST_SKIPPED return value to immediately skip the tests
> rather than continuing to fail later.
>=20
> Fixes: 108646569579 ("test/security: add event inline IPsec cases")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.
