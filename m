Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A039DC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 09:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B95FA4114B;
	Wed, 21 May 2025 11:21:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E58AA40151;
 Wed, 21 May 2025 11:21:48 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNk4wk014781;
 Wed, 21 May 2025 02:21:48 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3purvj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 02:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPhFH/pQNW0NK4JbOPls66QKhM3ZGYin2uS+F7oJrmwvYrfviGv588Wu7fGnQKv94pAXvBeMOkzO6idPAxJWxnLQckpH9v8cOVJ3zShHTooVb+9sX+6UUGwn+3duJimahlobF9SatA2qFsCzsWSf8a0cA0tgvQOu6KfkeUuW9XOKds01FNCnOyYEhWRDHC/B3I9VJctOqBoegNwXgO+WYWVi6Dri/05r3dOhy/76bqkBq7ENeooRa2fUI1J5NalYkW6+ZBGgXumS5bJNHtUDGkVQHAF1yhjuQb3B+tcauW7wJn8Smfa+IVW5g+QHTrKiue7uiTplYX+Cxq48dk8+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX18A+4j/bbUrNjW0M2urhfAPGKkDonVBESkCQ0Wvz8=;
 b=QVZ9d4eK+o75I2r02z7oPaTzUQtdkBx8tHEniue3jtICXfubk4ehAbI8rvV8NMu9z6TMCs45h6WSsIbgZWphpP2GeVu/1FGF0f85wcp3XIymIXOyxD6SzxDKLOwf1EaYtOogPIrPuTU64lVjromLsBeOeRfhNVBl6sDcWl92aSYe9CaH82ocdCc28G4cuXzwE/Rp+d96x/+WmQ/Sz3K5doHLVp0nXEhQAXtxogylgB3YH9RVhnSRbX98dfYlw5v9xjHA2gIEADtF7xU4/I1ZbamoIRu8zA8M5yPGtOy9y1mAyVDvederC1FpLwBqINuIGbwepni0BBalOMWLc/xE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX18A+4j/bbUrNjW0M2urhfAPGKkDonVBESkCQ0Wvz8=;
 b=cccY3Fo7fbOlJalc8YQfTKZ3pczwVQJN/Jq+hfbCra1t51gqA4Fy+v+GHexh/Z3rDq8+9G7sO8T8TRbsJWnfl8qSD3ojmmNOCBOcaES6KcEnTzXp8eQRcbD0bHsXxoNAcjhDCbNQO4F9K1QvSs/2N9UiFOPLI3T+5/lN/Ts0bmw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB6260.namprd18.prod.outlook.com (2603:10b6:408:273::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 21 May
 2025 09:21:45 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 09:21:45 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, dpdk stable <stable@dpdk.org>
Subject: RE: [PATCH] test/crypto: fix return value in RSA test
Thread-Topic: [PATCH] test/crypto: fix return value in RSA test
Thread-Index: AQHbxXCfgFVntwDdckes1l+KCet0fbPc2IZA
Date: Wed, 21 May 2025 09:21:45 +0000
Message-ID: <CO6PR18MB44844A875CA348301F941AF8D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250515080853.1708-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250515080853.1708-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB6260:EE_
x-ms-office365-filtering-correlation-id: e23d952a-0bac-4c90-dbea-08dd9848e823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?onoMSgX/uJ3OPKOh9Ri21Ogjeb4XSm11INSx3xPg4iEQxdWeQOz2ewdKSCVr?=
 =?us-ascii?Q?dJceJIxvJf5299GUcjtSaNz1P9+dle1t081/YV+IiZMMZgXlEZuJakfiMGqw?=
 =?us-ascii?Q?luQ4uKb7u7mdxcWu9yA1+SoaXYeyvPWh12gTMgeB2moYZ+uBeo0wArBd2l/J?=
 =?us-ascii?Q?eNKTW4h7cspryA+58TvTm3zLFP4J+J+5KS0T1+nnNmU31Qand+0jYp5Ntt0i?=
 =?us-ascii?Q?K+Cjzd74KbY8cPHiC+6ACRQ2eN6qzLv2dQheHv82jYJo/m5l6m4mZI0GSc/f?=
 =?us-ascii?Q?atSl5vCnxMM1oxncTxlGWzTjHQGOKXBXpkyrzm5+t53Nm7pk2MiWt5rll9kb?=
 =?us-ascii?Q?HGqO+iZuD3vPSfzmMAEnFOBv0kce8CPdmLPsAKaX9uo36FYiRdhDEj0j3LI/?=
 =?us-ascii?Q?Xdh4drK0DrdcxmpWZ82+bfSV8Jh3DMiaqMIdl2QuQIj9yXbGZGYFkHSuT2S3?=
 =?us-ascii?Q?VC1RkLxxkWevNSgGLT/i3cvwBHykkQ0VBXu2L1ZG6EURCI+/qRHc1QyOVrmH?=
 =?us-ascii?Q?gV4OMcR8RNy8qr8tLjEU6gaEg5IF34rqoCrfaRsEEewQO3kT++dNq6MdUDtk?=
 =?us-ascii?Q?xFdUizsNuxQKFhGwqMzy5VkTuoFDNDzhOqPzLmbbZwlX8jKzkJeVwEOzJaM2?=
 =?us-ascii?Q?zeAVhrH4LAAxNN44UZLSpItQ9KjTO3Qc0ZMriykDnagtvug+FNsg9jI4JiC0?=
 =?us-ascii?Q?zczkKFoL/Ic6A3t0gkF6J5dZbub6ERjWcynGcCKDg2Q3xTLl7/ALgVuWxj33?=
 =?us-ascii?Q?b/7qRgI2puG/Z+VN2g8f23ZJnBg0kL93ifAyODyGvVKDBGL0jlBfK7+hTkAj?=
 =?us-ascii?Q?xYXJKcoxm6hMommiOFrB1VXaLlaZhvI39+9megMjteQ1KGbSpJwcHW9FA4cn?=
 =?us-ascii?Q?HwGvULVV06RQvsQtTLqdAJkN8Knxu/kWX8JuFpsStdt56J1JKMHtn4OhdeY2?=
 =?us-ascii?Q?exs5V/Ownk0Teq4isEps5XuYjn97x1V+j7Uugrm/EucUv2czl0ulXiuYc38G?=
 =?us-ascii?Q?KwQ1FSQeNDrU1Oo3oM1RMqWiFIcdxldtEex4f19Gd67lNaS2hHRMwpx7KtcX?=
 =?us-ascii?Q?EOHHwQahuh0xBdQfKIw0VwxFHeWr5M09NPol7l/jGzTS3KKvHGstcdsCWpl7?=
 =?us-ascii?Q?QqqL1mpAcYYWSE1vB2TLQ1WlaTjBQ3BO6T8juExJS9Trt5vtCjdTMo+wCZLX?=
 =?us-ascii?Q?/oQ95OnYtVcnHn3AgWkRUOBAAi143I0TnDxKjHHltEtP7NFSXVRL2seYvz3M?=
 =?us-ascii?Q?XTROtpWEyuhzqIUi6/oZIRAV7mRaxtKnDSfkjWpmkr8/OjFaiYYVZg9aok3l?=
 =?us-ascii?Q?v9yU3NhFAYJbT5yEOU/LQqLnYbvzqbXnt6ivHomC+HeYWa93E1LMq0rphHpN?=
 =?us-ascii?Q?UIhz0xuc2MgYsy8ti4DwIEZ99+nvYT7jo5RN2VI5VbiPXntnhsAYbY1RCu8U?=
 =?us-ascii?Q?DYMSdHOIJrUYniIa42XjuYv7qQQ88d71fUpoC7FL7cUZ0+lNL4SqAw5C6bO5?=
 =?us-ascii?Q?WUMGxHncE7ROnYQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uDqhOpDYa7C2L/dyiq4Wls28gQ97ojHtcOmv/Z2N+RRVDXreyjKwZpyRj9nY?=
 =?us-ascii?Q?714Di+rR5feufbAd7yEZ7DVTzklTQRUZLT75oJxYkqncfmlS3EMB5fatGnlY?=
 =?us-ascii?Q?HxcxNLxO3pWjTfESL7y4m5tlVuO/s9LWhS1xF9ydGyJtYQFEIH/nsUlOFw4T?=
 =?us-ascii?Q?FqN+YVcpSYLcVPNpFOwtuE/nftxuBlHeWcyuwVASLxb5V2pf0pwspWU52tOO?=
 =?us-ascii?Q?/V61P6lY6qblTwn2Bv/vi7UXONhL1XWewR3SZVJMkaTvrn6KmaouPX6Wx/Kc?=
 =?us-ascii?Q?kDi1H8hDidtwcqBmJxy3s1xLcTOYFVm5oy21aRqJV0fFv2LeNtWafKDlelHw?=
 =?us-ascii?Q?RHtlb7EG1tnRLJkN2UXha/mdHINAXUwnvHSs8Hb2KZDI8XSrr3iVPIQEvoZS?=
 =?us-ascii?Q?LB45K5zc+7cLQMGA20GRLtOeYardyQDr0sxdvSCxzuIqqgAOPfcxmXiJLL6N?=
 =?us-ascii?Q?mClkSVIPapUcElhbcrS0AgWynaphlxJydRc57efMi6w9LTk2H3PpATnsQyw4?=
 =?us-ascii?Q?6gS6DlorKBGzNr5y2fu4s/7ZY7Ypt0cBILxZjt5hgYVVoLWAWJpRpXn1PG0x?=
 =?us-ascii?Q?pHfYRS+PzJFLFHfx8F+CBEancZfurvQY3Hz6Ld8eMTroGQZ6CxCFjTHLxKPj?=
 =?us-ascii?Q?R2lFgwhjO+fXn2lAFi++rdSjLNYbLNQ4WiQfy2d0+BcPa+m4Vcznu3eyXVaX?=
 =?us-ascii?Q?P0EnZ3v5yrsISaRIVtOK30QPj5uCmCot7DLKp0Uj9/xE7cQkmOvfJf39e/EO?=
 =?us-ascii?Q?asWvtBnzVEH9QiU4RlsZsDreAq8uh3ISSfAmmNN7tKBsWmOMo3qUcQQyfwMW?=
 =?us-ascii?Q?YunTh/GBRLP8Y2F9T9KwwXzIrZT6Y1hFSgOYF35VAz8DspqoNg6XbbBpR3is?=
 =?us-ascii?Q?mk720V97N54CkwciDXN0M1Tybeh0CA3s5qHzV5nSeIX0qPw/ejZH1y413ziM?=
 =?us-ascii?Q?bll3oAleux+oDy7+4FiiwkDThw+G4oIBJlno0O5HFCN/SKHwnuLt8MzFDKRE?=
 =?us-ascii?Q?Ft3lxldkfu48x2wruchAF1beBd8xJ8L11apE76oTSI0kn6bhU6jUgFciAMTc?=
 =?us-ascii?Q?k9j9zPgrpNIZtpYyn0pjfiTBhLI4pZcC+xljCUnYk0qVQLMvPigNO14lc6LX?=
 =?us-ascii?Q?baNLIPsh2PEPiSCh6s77R6rgTTacBniSHhnGo98FtbCffVnAM5Hr0/NETn63?=
 =?us-ascii?Q?dfeekck+QN/RWOQ3YyBUc40rXxGVlQQwNMIUkhzrACj+bKLQFIgxvsxYpviq?=
 =?us-ascii?Q?zcO/KCMxt6p0Mm23wV9Dk9ctQMjVUuBSTVQIw+SS/dP0LR9F+8wt/JnzoTeC?=
 =?us-ascii?Q?qttnixILGWv+r/E1WDm3BMelV/4Ip3e2PIICZE+yp4IdVWceglvRDK+dc5aA?=
 =?us-ascii?Q?nb3ZldXDwmc54EoOZh1UQrukN4gbpo9i8JxxHDRcKRAdlatG434MdLD5rAXH?=
 =?us-ascii?Q?pEIFQrlJdpfs8iqZMohh0TtJ1E/SBHZr88/DxXNYqCkFtpIyMg4NjAqAXW3p?=
 =?us-ascii?Q?8QVuh7aut3ia0mweZz8CAJlWYXloAYfkHXuJnyMDZDrfXXdtQ73tPv/6uIgX?=
 =?us-ascii?Q?cA2yRcpCNFbFUEYW6OM2qejfxtC6Naietjrp+BcR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23d952a-0bac-4c90-dbea-08dd9848e823
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:21:45.5680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvIk1fxemfufvEWzjhkbTUf8jTudrgktg1R674OVRuk4gVh4dN5Jvswt6O+JOb+YHHoTfgop1gnw7M8aTQiuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6260
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682d9b2c cx=c_pps
 a=VLWBoSTBoww685Dj7+Q0uQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=K5tycUbfABl4LJXc968A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: b0rpqmuDCUpyjuGg6VdIQx8j9BDFnagN
X-Proofpoint-GUID: b0rpqmuDCUpyjuGg6VdIQx8j9BDFnagN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MSBTYWx0ZWRfX2Tttb5p3fbXx
 mJPlPZS1rHejHgvCHsrg9jpwpON4ExDR7b37+cb0tC45Tt5+nZ7YtDmIs/X0Cw8Dul5KSNybRa3
 DwS1Ph77iubEUA1s72yYk4eDIvufvqZclo9dBF/5oJE4LcOblUSNbhEUJqnF7zTIRFmJX/vG+ZJ
 ENgjswq0hpUMf8rlEm14o2J4moKMsjnPHRqpFn+2fYREl52ePjckfXVMtX+L3fkF180Gkvrj/uG
 N6640QCwQWgZAkJTixcmy4BuggIQRQ7EgS9Py2QLjA8IvgSnQlMPVQnsGp4IwXsspnaJ/DzACgN
 7wRpI3s3zN0rkrjz2VCpp5vU4m9ZtiT9cY26em5+jsxJgX7/2Bxk5oTKSUzTyDC3FyvgcNh/sOh
 wxyUmK45tzvqUADzztEkZWbBx+qN7YZpDCkwb0lQbEV83+DJZyzbcPkQqhTDjwKnBkaBuvsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
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

Cc: stable@dpdk.org

> Subject: [PATCH] test/crypto: fix return value in RSA test
>=20
> This patch fixes incorrect return value when RSA negative
> test scenario is validated.
>=20
> Coverity-issue: 457463
> Fixes: 9682e8246ae ("test/crypto: add negative case for RSA verification"=
)
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
