Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A3DC0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 03:11:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C44A6402D1;
	Mon, 10 Feb 2025 04:11:33 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 65CAB402A1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 04:11:31 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519NluFt028702;
 Sun, 9 Feb 2025 19:11:30 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44prwb16be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Feb 2025 19:11:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js+jIhXHOIPR90nLOVLLmsBERtmL1T+CQJSr+ox+98SH9nNbOHCN+PtOkFv3BXRNwMe283TQT3ld/t3Tk4j3/a1YsFxqoCZbjuA+ky8i84bfZt1L0fZfJA2xVCp02cmJAM4+F4PMTj8AtlrfItfeeknDMJx5QWOzCZ9VVsW5c5Ep15pU3IDqLZkHVU2RwAJDt0i6vV/V2USIiRMUwgJML/e9c656YTMdtGdhgGDgEApZWziLxLY/kflmVQ7FUZqgkQeDMVbfBxsYH+hXUdByEJj2MYj+Zl546Ko5reHC8yATrckVnSfw1sIFKMxF1cGvYmJ6YQoOlYCjUQAuO+l+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi3Wo6dw05wvaekveWVGUaIeosKIov4yws6J1xD8kIM=;
 b=lw/zpFmUc+PGZtdI9E8Adj4OQeI9qwMZOow8UJml5gb/q/JFnjHJSi4x9j8VJ7ijF+44y3C4NXxMnNpoLBaOP/ugX0IC0WCa0kTwsAf0p5qpfC52BjNRfzQUcTNIyWIvdv8z8UkE04E0UDU7hjqx7mcJn7q15thWpomOllX1YEHTuIYMb0TBO4xS1wTj7yt0sERcOB+jsYeRYqJSmhY179mB7S2RuR/AcXxb2LzZrkOwr3z14SduHK+Du0CWY4nOJ6AwIIJXPFRpiMjas2hwyUxgDaZjSRBwjcLBrdhsJC0IOVBTcFEihGJ4Nz9F7mQWuAcIPcZLDdeen7fkjbVhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi3Wo6dw05wvaekveWVGUaIeosKIov4yws6J1xD8kIM=;
 b=fkwgrfCoKdPGYXIc/us7cKeQMQpxf8q8aukKQHXLx7X+NelTsNCvHd3ma9wRykYbtNaKHhdgAr0Qb4hKYfvLBUapH9PcsGkTREq2fHKuVvg2t9Ts4ULek7XFn1nriqxUio57PmwHiL3qYCu4aqWRlGJy78L+fL5kfTBEp2x/Wow=
Received: from PH0PR18MB4672.namprd18.prod.outlook.com (2603:10b6:510:c9::16)
 by DM4PR18MB5832.namprd18.prod.outlook.com (2603:10b6:8:44::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 03:11:25 +0000
Received: from PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c]) by PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c%4]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 03:11:25 +0000
From: Anoob Joseph <anoobj@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Radu Nicolau
 <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
CC: Tejasree Kondoj <ktejasree@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Thread-Topic: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Thread-Index: AQHbeWMLuQa9T2Mq5UKMry/19GQtjrM/4Agw
Date: Mon, 10 Feb 2025 03:11:25 +0000
Message-ID: <PH0PR18MB4672A83588F201B7A1C078BFDFF22@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20250207132016.62482-1-nkaithakadan@marvell.com>
In-Reply-To: <20250207132016.62482-1-nkaithakadan@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4672:EE_|DM4PR18MB5832:EE_
x-ms-office365-filtering-correlation-id: 8833c60a-89fa-4c92-b98f-08dd49809a5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dYgASU6kyiNmPQrO5hbfBzT3PP21bZF2FzCn0qG1SDaSQTYG9xP5ac0pqCAh?=
 =?us-ascii?Q?78wV0sa+8ZrhilWwXlpStzeiSZ2ZhhzWd2wrcIK4kldvCx3KrXt7gUrEL36O?=
 =?us-ascii?Q?yE7n9f1kUSu9czBy5dR0xF+hez4Kt6pv6d2+fg73Fk3EgPNZPpkOHHhmYsvS?=
 =?us-ascii?Q?X9OMW1vcaeiglQlV4GKazQIISre69IHK0E5geDHMrFU6ehQ9ncNTpwqZbkzf?=
 =?us-ascii?Q?MmkVv3Lj8SLcEgAp4R50GbVJw1b3l1nHk/45uha6/f2uD/TGhrNXyFsVQWgo?=
 =?us-ascii?Q?Ic15dFhg7lyj3hzJhIx5OwUp5kgFD30ixYwlaaUV81qsla+2Q4SynjBshaNN?=
 =?us-ascii?Q?y9h5V/YnhM2IaLA2dvk5VPWyBRTqZMF28qA0BbOGzwEqlZSzldJtqsSV6uqr?=
 =?us-ascii?Q?JpnmFZB5hVhURp6XnP+mNHcanRNz5lmYMNCb+A1K0Aglu16wggB4CPvJmtoX?=
 =?us-ascii?Q?ZvELpXe0eevOYDXHUw/KcI7Gb9T9WNpROvzF93BBOft8OBf7RPh5eelpl5+D?=
 =?us-ascii?Q?UOkim696bVATnN+cDIcnUEoM3DMEeA8s3zajvToOdUS8zNRADZOvghY1p26p?=
 =?us-ascii?Q?7aqmsq/h/kV+wKTDyk2HmLeLeN884Y4PPQDx6Hk2SroyIBLIOFrk8nNZeGUc?=
 =?us-ascii?Q?VoSdrx3thWZeT4CjwtXQgE5u1yTaY7opYfngR6LPVOAL8Xk8PZSeZTPjIT0I?=
 =?us-ascii?Q?Fb65IOVM90ObzDbbJ+ypq3fMs15xN4Rsx3u8h+QtGVtvZjKmMBGjoMwxsxT3?=
 =?us-ascii?Q?PzLSDLNAeN+Dfoc/Y+juiRB+uKJLvLjxfqMpYew+KbQG7275hrvMm2znApIW?=
 =?us-ascii?Q?Pk/akdV8NAWMtSrvfVW6zx6n+Yo44auPAYUpcU5Vn1FE9ILteECwez157YWO?=
 =?us-ascii?Q?SHEZQC6cYV59Or2M1Es4sDNzyvl+H1qytB2AxxToRep7FuIaArYBgyf5Fth3?=
 =?us-ascii?Q?8YqUI8YuqpfZJ0shmfAas6Idl1bEmGlPwGYGQ/BsJ9M2R4rg2SZo+RB8VXop?=
 =?us-ascii?Q?mMnGl2F2YiRSxNHWXdH1YbXA5vQcoztkAZ/xCW49sQQo0/0yyzl767yytQuR?=
 =?us-ascii?Q?UhMsEjL6pa2YfYuYMtCQs5usmhpE9gsvXC2RyO2CKD8y8FU5IRHOP+A4FcO/?=
 =?us-ascii?Q?uvT1lp2siAreY7V/RXCTsy9RmcCFREQ0MXIr2EcDXNVNVLxjpVDOT21ocM/N?=
 =?us-ascii?Q?ry2+lyxQ9fAtwkUaUsqZSYyIUqoKU/8Qmiz2XkJJ8oUc2WNcaiUruLtr0yio?=
 =?us-ascii?Q?V4rpEFc+JiZjwBrwZZH6vSdbjROwQa96JL0yA12ccBtHqq9Fpr3lNM9WKmg8?=
 =?us-ascii?Q?GkEIlEMSKEBCjVXo3OC1iQcrbgzpBnSV5oWJuuQysFQmkLOTL1brOldz4MSe?=
 =?us-ascii?Q?YXoJlLhcr7vhKd4Gh4CFd2QkStkHDOteJlFBheQRZt/hX78TXvlGKM+JDkmN?=
 =?us-ascii?Q?179DHYER57j8+Kl5TyZqNSWLSgzMguJZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4672.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cDy4/1kjWiYwMnSiXXWfPl4H3u3eHoV2dlcWX/b2DP1pJtfSoOlax9uVOjhq?=
 =?us-ascii?Q?7IagYMRRBv4zRmI0hlnlXC4lzKZBHdT3LWX0S6xnG9DwNLj1QCT9+eJh0Nbp?=
 =?us-ascii?Q?2Vj9Ecqb6Anyng+d0BaY5Qj0NhHlymKh4FO+ddLWZ8R1uFeneFjuKeObGmq3?=
 =?us-ascii?Q?YvrwBN0BqOoqXDzpkRRjiNn1qbFBwRn2i2qxscXwxbCLsD1Hwvbo2enl03yh?=
 =?us-ascii?Q?lDxuNtkVColOtI8dKWdCbkznxf6kKdQg0J7s9kjGl7voFGQ4V3aEB4gdhjM0?=
 =?us-ascii?Q?8CaEouyMHXB57PLify9+9462lzKE/f3qdd2fCddVE1TlWV6T/1PQaWG2v1kR?=
 =?us-ascii?Q?v8LmAVpIKTmDXdjNA67Xj5q7T68S4XRXl0Dly1bJDVm6walL2j43XH0o86Hn?=
 =?us-ascii?Q?awSowwVout/tyWfT/Zyv0yUB46Z41MiSIFiCkXvrnDt+ZThIorumNyBpNniA?=
 =?us-ascii?Q?WzbcaginouBWYR6VshCIjF4HY/NLFjDzJ5NHiMZQl4CA8edDj8rCELm/b4fX?=
 =?us-ascii?Q?aU3/zs1uduflX+zlQBLNZDZk5hcWx1cdpKQ4Ol8nUcJzYrlvt5MMSz0c3bRq?=
 =?us-ascii?Q?dI5pUHiVqOYKiyNGSvikN2BvYMzLP4XxHeT7WVXEovRfOEYCN8r41lWGOtVN?=
 =?us-ascii?Q?COOEi0IlVdEu9KUoQs4Lj2x60T/3Xj/ikmTnLcIi4dFoQvUGu+nQunrdTkID?=
 =?us-ascii?Q?VwNKQavctKCxPJHxyjHaFXalPJvSjpi2eYjNF+cYdqd8jPtO4iSHsSqkfQzv?=
 =?us-ascii?Q?1aL8xFRBRRd8US58SwnYY+/DAIpKfzHDT5SzWjI8I86ui82wtn7G8hoVIEMO?=
 =?us-ascii?Q?VExGE5u8jYHf41t9hdwfGyOjzgH9mvNGIckXvZrEhhi7DskCrY6YEgPsG9iN?=
 =?us-ascii?Q?XF2byj8oTmzVzwsjeLdWY2HtmyJNisZJUzPSapOgTZs8X8iSkXA8g6g/qv77?=
 =?us-ascii?Q?MY6y5Od9FAv4DfnrnkNEN84nBkT95ZsDj/+AIIVFUmX3X7WVFelWIHuLyf2G?=
 =?us-ascii?Q?FTSPltCA4oWBcevcgFXC2EdU7Q+yoP+SDpAhAbla7GgrOu9gsdXUCyQxhVl4?=
 =?us-ascii?Q?8amQK+DCTl2By38+FlkylZlL/kuL8tcUibWejobZSUz7y6XNHCeQzREwRIEu?=
 =?us-ascii?Q?/GgS700b5RRTbkkGlfrsOKt0zPFz3Q9Wa7lKyOBvwTvz3PCFgwTFLw1YlVIQ?=
 =?us-ascii?Q?6Csx+yGrCwF6n5yf0QFQZKF3rFPRq0nMf5FYQKmPbmwDYJzDzTyjnmDG0SRC?=
 =?us-ascii?Q?8fnELbl4uXH46SOaUDtGssAlBCgFhT6JwMd+vO9Qi0qKN3Lw3Z8rqHMDS5e1?=
 =?us-ascii?Q?qq/Hn3/5advXMszc3nnxOtzBAocka732J7hkgLWsxaMIBpZV5T+/r2+OwfYO?=
 =?us-ascii?Q?uUiFF52FXUN2MICYvDOLRJ+oPrUBgIXkhUqcij0sHiJxy/ykD/MtVagoEE3u?=
 =?us-ascii?Q?qZBOB5bk1hUF4A75DlzzNoXopjE2fiy3if8/qXPIxuMGeiS2LKzhc/3ot1Si?=
 =?us-ascii?Q?xIl1iHIoSEz7qfavgsj+Z+ti4fQmbiUhCPsPT2wIqRhAZZrVJ/yoOb70XzAb?=
 =?us-ascii?Q?amGAdOEZo6sMP1EdpVA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4672.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8833c60a-89fa-4c92-b98f-08dd49809a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 03:11:25.0665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kc3nn+3C/vOgLUxvD6Z03mrmISbXlrUfxTmh+W6KN2pXPlKPIQI70k6lhjR55VXZgnhN6ie10Fq/HUXLfBx+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5832
X-Proofpoint-GUID: UfizGn33pp7U_ST0Ite21rLCnX5FjZty
X-Proofpoint-ORIG-GUID: UfizGn33pp7U_ST0Ite21rLCnX5FjZty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_02,2025-02-07_03,2024-11-22_01
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

> Subject: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
>=20
> This patch fixes IV length to 8 in case of AES-CTR 192/256.
>=20
> Fixes: 9413c3901f31 ("examples/ipsec-secgw: support additional
> algorithms")
>=20
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Acked-by: Anoob Joseph <anoobj@marvell.com>


