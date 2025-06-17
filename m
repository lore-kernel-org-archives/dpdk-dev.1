Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F0C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C71C40E4C;
	Tue, 17 Jun 2025 23:22:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C6A8D400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:22:56 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HI4727010251;
 Tue, 17 Jun 2025 14:22:56 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2136.outbound.protection.outlook.com [40.107.93.136])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47aw1kth8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzmXV6DhHPGqnD0A75QrtsoRWSBu8cdSnYF6VM6coZGRw9rjI2rIgPy8lhkORmhi84QZ7st7r6AHu/W4qEXLyCWPupfyDunHr1hvp71jgHzPB1tEObnyuymoQhA+1PLwuOZTZdVxsoF6SmuZw1bZVjIzn/S3LIDbkLZbVL8Q3aCqYcJ5IR+JgZUTg7kGOnMU68+IQeQag2SmtJozdjtK41dg//B4cGnZwF4CeRybUYHlX0upT+6bzhOCo4tkCRS++jPfzb4adNZIopLrJuMfdN6+3l3w3XqOEjE7NL3URSIPoLPk25tWz6XD5ZIPxvM7I5i/2U+Dbu00AeDj30gsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=476oHCjBn0HREnD4M22BLWjoBfuIW6U72seQgGOxg2Q=;
 b=pc0RWdLyTqLeJxUAg3uaCOk+PW4RXyndki5jj6o61Ce/SzKzCQmVZBn/dlBCd883GsIZ70xujoxMbn+oW5vFG7VVqdO4osAou9Di6x2OfoDN9aSmuJnLWx3d8b7/MnbDkMq1m3qIKtTA7dNgVjWf5llR4paCcgQUUmbR4i9q8MsUbx5XHqRc965wb2+/fk2XM9xpgdsFd50BWXKv1+0JZoC26UvPMgBRAP8SHpXu0ySrUAsdgW7xSxVvtoOhiSHw6pJwmc5h5UhXzX2UaplVvLmW59GoHt/6TQIOX0XcfpVwZALEGJp8xS9FQ+U4OJzliB4KP/OykrtVbrhLInTguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=476oHCjBn0HREnD4M22BLWjoBfuIW6U72seQgGOxg2Q=;
 b=ZNVhT7XsGe2bShh4adjroxq5V+GlKSiFUSAR7ktSsQNJRa5M9AMhKlnLawMKXJ/B9CuEY5QNyNmEyYtsPVqpXF1kHFn3V2kbzyvg+8AFrAbOgXFQN5AOvJtLbHL0Q+Xitry6K6W9ckXNAcEKBuFXE5QUSmaoz8xJtZN30qu1GO0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SN7PR18MB5261.namprd18.prod.outlook.com (2603:10b6:806:2eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 21:22:51 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:22:50 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH v3] app/crypto-perf: add support for RSA decrypt
Thread-Topic: [PATCH v3] app/crypto-perf: add support for RSA decrypt
Thread-Index: AQHb3oQVVJEWosX2F0KmONM79xBKfrQH3t+g
Date: Tue, 17 Jun 2025 21:22:50 +0000
Message-ID: <CO6PR18MB448497185A48E5DFA994D728D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250605092404.3882473-1-ssarananaga@marvell.com>
 <20250616060103.2503415-1-ssarananaga@marvell.com>
In-Reply-To: <20250616060103.2503415-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SN7PR18MB5261:EE_
x-ms-office365-filtering-correlation-id: f3af0ea1-2ec4-4139-9ea8-08ddade51d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vees7j0eZ2T59MghBK9AUeTEUig+EFhynnRg9vA7iJtqBcWotaTH84QKiddL?=
 =?us-ascii?Q?ovbuYJJzPZUNVWfe8nyPiN8S7VrBRhAPQHd9mgnCodiJh+BkWRetKofwJ+nr?=
 =?us-ascii?Q?PdQOxd9rKJVsqhc0YxNc9bf4W0sF49PWFlknoUpEMjnKQElPh5AklkhMGC3b?=
 =?us-ascii?Q?ENb7OCIZ83/7z6I4x3spQR8fcQY0PN7PdxCAETiLxxhf+SeotDkqfDKsmhU0?=
 =?us-ascii?Q?8SGYie8JWt0vr/0LkOPSKIkabhIGAnpe42W28DncEsIgRFAEXztKmKlcpm90?=
 =?us-ascii?Q?6aLW10qu7bwbgsFRfRKGQJH179lb99N/FV7jwd1av0QGCuO/3t5anXrVH1DU?=
 =?us-ascii?Q?jsO4ThfK2ZxfJ8zOEIl1rNsAZZiPbZEGKDY+ygxoeNzCos9EbxCBzoQRaaKs?=
 =?us-ascii?Q?qiXCZPOjKmc4fQNTfMQVVFdpih98N9Ux4ibBQ3Uj4kZXajXSi/PYBX6PGlA0?=
 =?us-ascii?Q?Rc4mWu8NVPO1R2W0Viu9fntFFQutpXk0YMvTp+CIKv5y/6TrItbYypl/olhW?=
 =?us-ascii?Q?kVm3nK6bv9kqWQHKt5gcYEK275fE54C9+3emVOqyVBM+ckyK8hFacGdATDuv?=
 =?us-ascii?Q?JZb1qF21IOWMrvSpx5sYGOBayXiqyKMpzlp/xcIgyiPE9DeDDvPiwUMF3SSl?=
 =?us-ascii?Q?kbUrl5cKr5KQEb/cOoEoFiozv/Vs9QPcCbY886iFqusI8h4gTImbPU82oJve?=
 =?us-ascii?Q?A9dMDsoimi8dLPnwMRBqHBq34mDxmtfiyPf4SxF2FrPwEA6ysq5fEXAi1RLL?=
 =?us-ascii?Q?WxNcZ1fvJWULSTd97AFU5/NkO64FvYqFJmrC6dv7RaoRNq3PbEe2pJj4JIvJ?=
 =?us-ascii?Q?4TuzHHWvyRuTzTbZN4UlOGL1oA3mdR1F+nlqCJWZ6v3oEY3jNeUd30M69qg7?=
 =?us-ascii?Q?6zIgW18C4wwkNm/ozEQjDH4i2YONm5XCQcJXxNEyp1wOEVIIVweGi8D2eiy7?=
 =?us-ascii?Q?WyMNnMEa8RA74l6/rb4W20X0+tkRUesR+RgwWyTbzeUgtmy1d7UxJSRmP7F6?=
 =?us-ascii?Q?FJ4IJibE73vhxhV4axrWwHZft5cFp38hMLH95uDSQ20FpYOCYrmeovxAOsXW?=
 =?us-ascii?Q?N9O7m1OciDFw1dMQayRBTRNVxBO1n5aQnUH49cTkhiA+ucdX/m/+imVpm8aq?=
 =?us-ascii?Q?7/N2Eu0eAxMsQmMoGlk3iZzUGKbQqRh4gl4XE9et8Y/lzBZ3+c194RhP4RpO?=
 =?us-ascii?Q?0zhsv5ZrvLsY8utTWK0xl6NXVttzue+k61oru+9ryXfAGNN1ckKSgw7nXX4q?=
 =?us-ascii?Q?uxHs5IqueQjky9sxW/ICTcIQCmRhaPChg7DyNVtXHYEH/jtbf/E6tfa4jbQq?=
 =?us-ascii?Q?KfRAMz1OAM2U496d0rpYVPqOIJL0R1p8mkQwbEowNfQowcdkqTa9tQUQ+WaZ?=
 =?us-ascii?Q?Ayj4nPmPXh6DxRcZ7P+/LTL7/YkwPeo2rBIvw+ErY+dKANeCeo2pGQrLHBSB?=
 =?us-ascii?Q?0/6vtqEU6RLohzMrX2oGszTkLCtnPoQfHL3SdMNE0ICvq4U7YoXNyg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7gaDsNVXcFLs9DMseCGtt49U8dfa+fN2V50Pggj5o2Az3frsdRRje4lsAYdG?=
 =?us-ascii?Q?H7SBWPts6xG/KGtGVlOhJttIP8EfvzHUnynGVRtW1yDwKPCMe8u1B5Jb+3Hd?=
 =?us-ascii?Q?0ZJnBItz/AYCRqnQNo5o9Yeb3H/dx/nN913ugqjTt5PtLxUX53mM/7awlX8R?=
 =?us-ascii?Q?tYKQiZga3lhTOjAsUWj+XNO+pN3UzdsROayYX40WIlbMRH4UwGcy1YY6GpaN?=
 =?us-ascii?Q?KKpPeqPDzPllbxN7+TXqrYclcOkFY2FcBsdBLI4D5Mz/OcVk+wGij6TPitPU?=
 =?us-ascii?Q?2KpNc9S5tnQHsyDx+3Mu9m49I28FJulRfm0SkXvYjuo2dQsEo9CYwLGkgqem?=
 =?us-ascii?Q?Kxf7UVPD5NFjb11HSFqsEK/Y+9e7e/tqKWjoUlSiCArNPTty9jQLc4xq0Eed?=
 =?us-ascii?Q?mEilirIakV5uJfjgAWrN92iaKWyjLgJBYS9t+SZsCFySHfBV3O3VpUYnxLZT?=
 =?us-ascii?Q?3DHaZeTr2ZATOQy6pzGW4EMsfEQ0MIXuCDKwJ/3/eGH7AIFb5AaYcqOUiKSp?=
 =?us-ascii?Q?n5RszbmAEn7M6JhJsRmJq3Lmp1/2IAxmqhaOio+od6ZYQLsv5H/+bNzeXm7Z?=
 =?us-ascii?Q?CAh6bSQ3XLxDnnNbLMwbYernDp1YLQJmb4QI4Tj2N40hnCIsPersMj56uMtX?=
 =?us-ascii?Q?rGC+/XjJN0hlwAR5W7i8AaEQsKrOP3M2Mg07sEORZM8Y5jSTaNLLGxNpjieO?=
 =?us-ascii?Q?NtEc9ovJrY1puERp/LSxkBBqiPCSYSHnsZ+DocEmqMFNoYVsUHy4qW23QpE+?=
 =?us-ascii?Q?q8RizYJsiwPNJ1GbF196AkBKGqvvPvRKDU/AxrdaKnznjKJhA18f9wEBGXJt?=
 =?us-ascii?Q?bJpNLDOuly+o6fSyTwwpwahec8hpvIYNcpwD032Gy/g6WJ7OvZRoddTXY9FW?=
 =?us-ascii?Q?PIgjCqHVFkqkn5PC2X398Nr0nwSXJmrLJxl1zIB/iGq77EdNnEvE+he6A82Y?=
 =?us-ascii?Q?YH4HHa1Io8v2jQwGFDoVU0q0YVKnEJ3Ca8yUq138RFwJeRR/zMNtMx8//Ero?=
 =?us-ascii?Q?nrdA90UJCXAh9gUGRRparzfu90re3hrg8CKm2ks4CC8A8Bqag/pcLlhXtCVY?=
 =?us-ascii?Q?ZQayVtcwHz22a61OyuBD3TzL7sDBZNgEzkhnXDhNluIAPTQ9u9u6xBN9CCwc?=
 =?us-ascii?Q?3O7n2/wL+KqVyFkiMFcBVORJ6mUUiRsFhrUXW7Z2ALdLxAR4U9xLMwcxBP2k?=
 =?us-ascii?Q?w5cF1qItShzyITHviDBkybbbUsaSQ36fTQeRformom32X5a29Dos9fORrHjr?=
 =?us-ascii?Q?mT6yR7H7YlPLYUwXwtSeFWqQzAprLIlYaK6ynyHUFYDXlCTO/2IEvKxoYrqa?=
 =?us-ascii?Q?PB2Xdw5/uAIBwEjTxpnpVBg2wVQTd2/jkLXU71brymIbqxfkPwFDpErhC0TH?=
 =?us-ascii?Q?0LO5/y0HWxaQW55sIDsi5+NvELilmMtPyjc37FnT5EJfjbcD7UbDmUUxGqom?=
 =?us-ascii?Q?H6sXM7OrMcKTy2cZgwbPcHYj3zGFcbhGFrgw/Uh9gNYm81VgdJ0T2QifdeQB?=
 =?us-ascii?Q?SEHVAqLrMh4NEihjE1vatlWPgIq9mH7SJ099iWEkZDt3e0Vih5WjrlaH/FWn?=
 =?us-ascii?Q?FJrvVYwxidfJAwZoz0M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3af0ea1-2ec4-4139-9ea8-08ddade51d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:22:50.4492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an2ZXPEeTaWzNCmOsCE3xzLOK7ZDJ54Fzm2YrpHmIngmSzyR7nCXKAbphghqy5W1B7TC102I7Ub0IP6ZVnnWew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5261
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MSBTYWx0ZWRfX8Yd86TpXIg+K
 obVlhgOLoJ9LuGf1VHqZCaitzic3AivBwg2iwZFuNNdts4nKj8LfcfTM80+B9cBG/NuvdTVTpR6
 /K4leOw8fSeoR1iwtTOjd4gKQg/WLGEa95Hgbuv7ti7bTrMMqH6ZJExdGbzuNbfsXMF+uB//oMR
 Vz18LWzyQkFgVsEIPMTGkwv9t9in+Bw1wiDnx15gqAQNuwqEHA1lkJNkBGYAJLuGJpMoYg+dODe
 nZ2HEJKJ251nI714CsR/p5HUB+M8rDzpUstvl6B8doCZqIqTgfKBYI49PfjvOLY4yjVA5kFDZHX
 V2I3VQqz1qeC0zHmPTRuV1441MpzAvCh+uJMHTC8zaVneFEXuEvlsq0iFP6VRVA1i+af2Urf4eX
 TOD3boK8NF9IKPTp8IXkFMApQlQMucyHFGkWN3RfN4XEzsw9TSXSEkKQXKRaP45M3rC2MFMK
X-Proofpoint-GUID: ozWLeY1HQpOCeLgge4OdoTHh4xOKqMqi
X-Proofpoint-ORIG-GUID: ozWLeY1HQpOCeLgge4OdoTHh4xOKqMqi
X-Authority-Analysis: v=2.4 cv=VM7dn8PX c=1 sm=1 tr=0 ts=6851dcb0 cx=c_pps
 a=m6C/VzIz8X0REkloh6CGuA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=5e4nMFGB6dc_RNdO9JQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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

Recheck-request: iol-compile-amd64-testing
