Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B25C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 10:58:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A030040299;
	Thu, 17 Sep 2026 12:58:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9599D400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 12:58:03 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H9e9od237752; Thu, 17 Sep 2026 03:58:02 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022091.outbound.protection.outlook.com [52.101.48.91])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gr7tvsufr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 03:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0PPcQ7R9pmlzwV/5X84TfWfcBSBm86csRIrcEEMPhzkDuJ9+R16GOJ1JCvZp8bGVrUrPWPeirzobpu6q0BtmyuCGUDWX9RDGISNyURhCH3eCJ6/q721Ak/Oz9t7V0G7A4yR0vd6vaGoj3RH5NUImiX66dKZrAoygtSdfM9W6n6pNd5WzGtrRRDuadFfBQI63hoH2WfepztJ1PxUFY+xiYErTvMFFNiwkiLBoTdd6HmqVpxILqbbfeFYi/JkwEX+tU8W1dYAJI0IjNK6P3vO/vTTFRi2dsTlNG3iyP4qOx9Pr/OvNxpl6AomXHQywdSCB6d8dRmW4bL5Rx7PUhC8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ4higMnkpOJg9r41LPdddp8V2ir2K3rRB6IAmbAmoI=;
 b=Xf77Srpu4XzwhQiGZf1vhTvmS8Nc/TFBDITQj8QreLytZFvw5cpMjomFBuW/hVzzgupk/iqHoRJsR5RoH73phijxSmC9PASjXkqZ7or7nfnhdqMA31f2xdcILigcazLEbV03ELVjkVYZym3+iS5xlnCfxoZE+t+CihPlvyIgl0fNqNC9G7jPX0pM2TnRADRQrajw2pKirw3KbcMBEV5GEuGPprcguefESeV5YghDNNP4duQ/iCXVf66DLU5nFPjSOm96Neixv/s0jow6cVBNNIu3Xv9rGyFzgDN3/Vo6mJz1O09o41MqPKnxSejJg6DFP68vPYCLMhBaMh0pcwGj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ4higMnkpOJg9r41LPdddp8V2ir2K3rRB6IAmbAmoI=;
 b=Mzj2HsxJqFW07dEpydLtsBS7YtAiVHAPAMqioQW2sX3V37yfiIz/3iyj3PVXouzPLx0mo3ryXE6PClsDxfVBJBfYxjQJSnWRiT0z47lyJALo/bCL5X4WLnFH6klWKYNiWC5Ac3gxtjWA2sQalKDK7NxNjBK4aaaOfXsrZ/8wCts=
Received: from SAWPR18MB988310.namprd18.prod.outlook.com
 (2603:10b6:806:4e3::19) by CH2PR18MB6392.namprd18.prod.outlook.com
 (2603:10b6:610:282::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 10:57:57 +0000
Received: from SAWPR18MB988310.namprd18.prod.outlook.com
 ([fe80::90aa:c1d3:b188:105f]) by SAWPR18MB988310.namprd18.prod.outlook.com
 ([fe80::90aa:c1d3:b188:105f%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 10:57:57 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Pratik Senapati <psenapati@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
Thread-Topic: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
Thread-Index: AQHdRo2wwv3D84xYDkuxjKKJAro46bbSmVBA
Date: Thu, 17 Sep 2026 10:57:57 +0000
Message-ID: <SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com>
References: <20260917101641.335926-1-radu.nicolau@intel.com>
In-Reply-To: <20260917101641.335926-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR18MB988310:EE_|CH2PR18MB6392:EE_
x-ms-office365-filtering-correlation-id: 68730aab-a836-46c4-181a-08df14aa8878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|8096899003|38070700021|10067099003|13003099007|22082099003|18002099003;
x-microsoft-antispam-message-info: luL9QLc5lsNZma/k40YUXx+PmzfababT/2wFC55ofMSqb/CTwKtt5Xs/KZcRqS8usOkTk7FxKcv1wNy1YvfZo8fddJ2v9sDL8ll87/Ee9DR5DanMhS+Z3PnIh9Ms24MHW7Rx4owXsCjZRp2Y3tQNJt9rdkhVkxmzrIGmaPZa601yYfDiie8V8LQOVeyAOdAgJOXecZ+ZYRiaKM87JJjS6Qu1qcSHBqb9uicuUGYFgLhxm+eNNTBNrWtssPlsODJer+tI8XHeVzNXZVfyzFfWfU7pNYLf7GVtZtJq+f3/NQjY6Em0VkimT71SQi7dr4j52tVdovkJ9s9hflyEF8KThkRVBtU8COdH1k0yZtXPQW42xzn2+hGOsl2MCDhp4F+Hv3boKwx6x9ENnaJueB9L7ADfXYf+JhgdTnnq5hz64yHFpDndB2O++QZDnwYOMurn7E2ywlLEjUsxMylXCT5nl08GaMFETc5Ql7ZL3+FK6vUl0h+UdZnGfMLWlGQjmDegupC3fPqTaKZkL6ZSmHtkD5h+bMKro1BJEe0+OT7Cxnmle//DyabKFvPsXCSm7uUOTAmv7wS6BcIHBOUGikcGkyc2p9cwrcx29fxKAlcghyhjXL7m9alXrCndHdZ7ggmmrdKNFfSwsgWBTUHp3a6FXnyFjltZiIcR90FMqwyUpx+tTUxF4ua4rF0WkmQM7Ry2odAjj26VE1hyPipBn34mT5M3DR+nSq621ZnVG/Drdd8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SAWPR18MB988310.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(8096899003)(38070700021)(10067099003)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sS89NzEzs6FPbRzCWI8YUph8ihkdAKNy2utMsXlQVzy//RrzwWSmsEcTEgNm?=
 =?us-ascii?Q?BlrL6IDe/+1cQszyS5LB8MVD+h/ztQiZb6X1Z6oiWYoV3Tb6/wJ/z3FjK+ae?=
 =?us-ascii?Q?1aaQcJsEwPy62aQ4DGuoWkkiwd50tF6dF7+oD7XdmgfzGuXU5KSWaRuuC197?=
 =?us-ascii?Q?cPUhqIFrq1erQkXu7b3hjWugib7x29rFUZUMai6AaD/JlSmT5Hr0jgS+ZRLA?=
 =?us-ascii?Q?OsmP2JZqHxu52geHbZ4XZQlEb6ftKMacqF0QGMsji4UzAYO2o5FoBP0bnhph?=
 =?us-ascii?Q?LNi6wBoOUDuMkb8yez6FPzDjXzlg2cicvSvsBbUsVv+avDp3BDZk2UZGtDkA?=
 =?us-ascii?Q?0MuZuTC0l5U7kxvaX9hlGK9O6gq8zEBtFI4YENibjBDOSBpYkW0BdyrNkwwc?=
 =?us-ascii?Q?VBHcVY/6n8a6qysmY+8AWj/4UgLAMz/XRyRuA7HILvsUUVkutASJbvho/Tt/?=
 =?us-ascii?Q?Wx30cprVemcZrAUNiHyFrrb0tmZWpU6xALLU2AZLNKD1jBYLw6/LzIolJlmN?=
 =?us-ascii?Q?sVaNnRaDGwC4nl1/Dd+k6iFNgGIrH0P92UXzDcIbP0ihYnBK8jusO5XFxxrV?=
 =?us-ascii?Q?c0+Pd7Wu+jz8zi69rBC2qCFpfeU/auwmym2SWwVzMRVHDWO4A99qBbhCdoL0?=
 =?us-ascii?Q?wh9++dm88ZLI/Q+oUEoqJ7SCzqtkos0UJrnEGTHIPS/YbAoswxGd/X4mTq0r?=
 =?us-ascii?Q?+/GKPPbbFGTtMPgU68UkINBLrwyU4yCkaRx7MDDVtgNO83FPZKPRwlx8n6US?=
 =?us-ascii?Q?1ukOD1gsfTwJ8XtqyQyY7dJugU6giKVYmElsWUe45gjhi4iVswEsSf9sq9OU?=
 =?us-ascii?Q?Z9GVV45Gps4EQjg+6gfYpk0cntyBxlIKvL5Ul2ttad3mhvdsKSGb3neMFrQ2?=
 =?us-ascii?Q?RbDPbRq19Jf1+6APMd2PJvVeQ9gwRpNKt2I6W7Z62MkE0yZn/2LW7dwqcFUz?=
 =?us-ascii?Q?RXMYinevjWXAzHudC4l3/vJS4U2R6Ccs9L9kXDIN23wv+cor54SaiLCLUJ8O?=
 =?us-ascii?Q?Vic9Cw8tg90adya3UZVBWaOjqfuR9CGlpNYIyceHzoPT+LqduH9A21M6W3Z9?=
 =?us-ascii?Q?tb7b65S9nTJz2GC8SmUbWtYtdk8rCp6f/GAK/sHzAYDyUKrtBSPuMLxo0Ms3?=
 =?us-ascii?Q?KH2i2X47IwEdIiZaQnCQjkZrVQwmG8SW8Iy0wEMZ4AqWMm5Xg7hPb14YJ31i?=
 =?us-ascii?Q?EGUbTcg5NtuCbZC5MQZlXRSWbepj0ooOwT8zfwvue53B6B8delpxXGS9aQDX?=
 =?us-ascii?Q?cGHvsRUbiEFB82cOh/03CUh5etf+Zs+ysfj+G1SCanVZx+xDk5eYq8jZD3eN?=
 =?us-ascii?Q?DbjSXFVTY8mqlTHeXCFkYU+AwEZ9H+F+7qPB4jEMtd0/v11Zksp+5ja5JygV?=
 =?us-ascii?Q?+eoUSb6tKnv3gRTc2XZZW92935ZYBcPVnrF23Gh0t2REIwTlDnBlPxhC0QA8?=
 =?us-ascii?Q?S8aDQ3Im6MY6lrBR7a67QK/mRDyfXeIWXnpO/efXBaSgbf9Ljn41jSocJZVR?=
 =?us-ascii?Q?XkwNUOn+z77K0vujsm01e6jcvhcEq0In/TJyfdwldHemxofrsQehvjLHqpbv?=
 =?us-ascii?Q?OZeBNuxkptBsciNOePxoDQov2QHTJs2sT9gbHRBJKCq49gctNFRxAiavwaQ5?=
 =?us-ascii?Q?ZVi6auTUrWjqHxqv5v0ygoBJBjRstRVua5zDA8Q8rR6vj/maOrASimBXjq12?=
 =?us-ascii?Q?v2SJjs/7pSbuoaAV4IP59HIZybPg+lbTA2fsA79t6Ap/YKZbpIsob9COishO?=
 =?us-ascii?Q?+j3WkKQYBg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SAWPR18MB988310BC52CC8B4B771E060556CBB82SAWPR18MB988310_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EMjbgOK6CNwUuag6ZuRgQv/n2ro79QEWydBL5cDYoDj+eyCKiXKtehtGpO9ANwrTwPDMhRr18LroYNRKeO33I6dDn05Y6qiwhCHFariowhElGuGUmMrjMdso0Gre4r1DmuqVNoZnCKst98Hua72M4ol2AiroXoclF+JJSvdHC9S72ddqDlNZcs5wjyHQOx4w9mNwE6fB1roZ26Xv8ujn1JW0AcEIsVS9VLIpcp76uQru6uSKIw+AK0C+FGVdGbrYUofr4QA4doQu51Z/hy1FCCSUkva2pwiOc9y3KLdMRU1LPSlYWDRCmmJGs8tnb4BeZhknXK5lxHiNIxXbPr5HuQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR18MB988310.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68730aab-a836-46c4-181a-08df14aa8878
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 10:57:57.5992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJj5x/dj3NtGyTkjhseU1vFVEbox6ow0UzdHVmvu8xzo7L5cigjv/uSzEVihrTTHtJolbQfIpkclCwYPLJ1Vc9KmhfKl3hCiZxxrmCgBgZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB6392
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE1MSBTYWx0ZWRfX9Hh8FO2Nu0A1
 tGIpbqg9rp4J8vrqWCGi+DNnChscq1ZmInOcyD4UrlB+NlTBpRhPUzJDZhfRoPI0QM0TDKK4ns+
 x7h8LVreodJJcBYbKsxHSgnNRQb6dy3gJdhNO3ufMvDD+BdcX2faRrZtqNWSd+tGI07DtD++vql
 ZAbMGYEvmnwxraQLj7c0moNaQ1USsJdLKNeNihTkiRg0M/xoQwDD27vpfi+jKiT5ID9sWOlZnQP
 EfWhDlXlYeHXsEqfx4XduhW9VuskCrGYZdKYp34bDaI+mw1sOrvxBMuAgZX9glQWtCe0SSEp/lA
 g9ormyJZ+xoZJRxmpCpbK6I09wpSOq5sszbkDShFXUC91xJp6FCKHO03Ynp2F6ihfZP8PptC2KT
 9+/3pfaieFOym+KlGnPxIn4Ik1/Oo6/x2tlGeZjRIVVj3HYXaVvr0DBsnHerrymMSez/7ntxp7T
 pZsTBKvr8RkBJNDrujg==
X-Authority-Analysis: v=2.4 cv=M5fYuCws c=1 sm=1 tr=0 ts=6aabc7ba cx=c_pps
 a=gqqRaR/JtIFMplGXl4YyTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8 a=73AC_2dAlmjHyQ7Vk6sA:9
 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=eo-vXhHRZRexWK6iHgIA:9
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: TE1DGw1udjf39udy4I8c3F317EHXluJB
X-Proofpoint-GUID: TE1DGw1udjf39udy4I8c3F317EHXluJB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE1MSBTYWx0ZWRfXxneLMthBuPGT
 vamA2mlvxFah4vi0mRU1MwX57Fjw9T8vYP+ij1j4jroQTmSdhSN2DBCjPLbP1zyer9UMzl9JJEW
 vghc96TLfsWNVSPeve35TpX12iyTnJ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
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

--_000_SAWPR18MB988310BC52CC8B4B771E060556CBB82SAWPR18MB988310_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,



There is a series already proposed for extending the autotest :

https://patches.dpdk.org/project/dpdk/list/?series=3D39137



Can you please check if that helps ?.



Regards,

Gowrishankar M


--_000_SAWPR18MB988310BC52CC8B4B771E060556CBB82SAWPR18MB988310_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">There is a series already proposed for extending =
the autotest :<o:p></o:p></p>
<p class=3D"MsoPlainText"><a href=3D"https://patches.dpdk.org/project/dpdk/=
list/?series=3D39137">https://patches.dpdk.org/project/dpdk/list/?series=3D=
39137</a><o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Can you please check if that helps ?.<o:p></o:p><=
/p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Gowrishankar M<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_SAWPR18MB988310BC52CC8B4B771E060556CBB82SAWPR18MB988310_--
