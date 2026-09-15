Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26725C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 06:39:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9673406B4;
	Tue, 15 Sep 2026 08:39:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 05F4A40290
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:39:33 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F6Z5111047728; Mon, 14 Sep 2026 23:39:33 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020094.outbound.protection.outlook.com [52.101.46.94])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gnqg6yfnv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 23:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FskwCHu1FInzlB8hlubKOLOeQiqpWIwRwZpuRn47FyqRjdUIlOx0sADbjE2Q3fQS+apumWRRUDaAIQONHtwWCHyFAeFfyUywHpx2ntpgz+woqdDswV/buIIvLFnETZwZjKG+AxfeI5KoTMP9RtKWwMocLrlnxvwR2m0HfL6kPEQs+mBV23qGgFljZJNIouL4DrA1RxvafySrdHHpFEDSNdZpe1EPqtpAcfeAx21h7+2B6atFjeZY7cMf+xqgTn526SO5mF+vHdykalh3sBFCIuL3GERM+avdSOyYMch/qZqSpLrVXXMuEdGRlfInq9JjKYCi5Oexo/q88GjhpfETeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McqTvbDmA4caC/AC6i+t1MeAS01V959v+kunr+t2woI=;
 b=GybiGgkCrW0MiOTi+LPa3nVWONf+D+bfQ30AQge/ZVK6WbH+QfoHzSaeoSDVUyXRVegqQlP0F4mA4/UX8bTuP3QP/NCjYgI41hFdnm2YdvyGlQKa5TzbG5pgrgfvroIm3xJF1QBq57AvBmH7YCmo7dGydJjU9snT6imA9YX5NuOkAulCLWzskdoornS0wzC+7wrCmYZ8kU6QrHQIMA6b6Mr3/X5vkb92m8ie0D3+sCRS8MXj3oYjo19PpfK6BujR7VteSd+hsChFby66yp7D3ceDns1DLVVxJgZxj2CUNAvJTDbNBfmL6IiqTANq4QIBKFECojjI2vA8TswpL2NT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McqTvbDmA4caC/AC6i+t1MeAS01V959v+kunr+t2woI=;
 b=pDydExcismGGp+ue4Rb0BlXXS6hQf1XuRCT+l3xc9XwHMN1Qnab5KNR82mG6Y6ellu1R6cKXbHkez0izaR9WpasN4S75LnRrQMiGNtJXAcpW7Smv0QVOu6l/V8iHTyJ0mPamBK346dv1N+/StISncA0kAcVn5YmiTM6A26ySDJI=
Received: from CO1PR18MB4796.namprd18.prod.outlook.com (2603:10b6:303:ef::23)
 by IA3PR18MB927648.namprd18.prod.outlook.com (2603:10b6:208:544::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 06:39:30 +0000
Received: from CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7]) by CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7%5]) with mapi id 15.21.0382.012; Tue, 15 Sep 2026
 06:39:30 +0000
From: Ashwin Sekhar T K <asekhar@marvell.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
Thread-Topic: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
Thread-Index: AQHdQ04sGXQ4kNNvFky3nezGJBPtwbbPMj/g
Date: Tue, 15 Sep 2026 06:39:30 +0000
Message-ID: <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
 <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
In-Reply-To: <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4796:EE_|IA3PR18MB927648:EE_
x-ms-office365-filtering-correlation-id: 6d058387-2d52-484d-5687-08df12f4189e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|23010399003|10067099003|4143699003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: ZuA9GtAHKIrNnfHblbQudZc+3ACRVaOqzG2IRDaZb0qn1xTm+mW4C669EW0Sym4+RF/bJr0RUi2whjxYyEzfMls3Y2ar8No5MBbDZ5LcjH1r3ByKRAytOQMipRRBoo7IZhSabhFFY2psE0q7nJDF74WOUppdup0VIWryVTJ3gvR9iLmQl9ZDUY4LWNpXBQZZ+lFBG+WHOU5WKpwfr8/Alqz0DAsg+CulLcjssjmAeoVukhd687sTEd+u25uxzQVEaGMVY0Oc5nk5M6fqLpV9NoP11GSbyPbjQlZX6T9QZnDF5skbbjnL/TJ6Klv3DkpKBMgFtSeJ7HLY6H0mxiPzPCzTa8ABr3yewo83IVDN4ZR7DVWaFBV0bTco9ozcCbLUOii2r9Ih8IRhkhalLO5cDL03CLaawp9lNsDtMPejyJ5rQQPNAggzAZC0MAWqh9xEXwiCdaVew/ilTWqU/lZvU+idoaE+qJCDGrqI4sB3AxHyWFBsIhiV4sVYlo2hM3nwYcCEscwpyCMRh7kBFnq2qszZBcZG7nIC4LgRRnVcPy5agt6ZIGvgcDcx7zO+W/oV+f7hk0PZepQ9hoZOKge4Nyzbtlwc5IUMtOgmOxAVUd5e0eKsjCp3rtRLLCy8vRODEAZDEGlYpWXvSV0NjYZKO2b/fHuAVZJgm6meB/Muo1ElpQzGKz3wX9HdhDoeHmL/m0eYSg5JhqSeYJWPaUdFLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4796.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G1kPbS8oohXEGMMWPs6qF4v1eA5KFQuTVFbaOkeXpAJOBlHVjaJawbxw9gXr?=
 =?us-ascii?Q?8rf9p1bzvHtT1QFf3D4DconPOuA1SsfrHTJUAv0+4PRn1cxhyy5QRzvpHWL7?=
 =?us-ascii?Q?6Hx6CK3XVrjAMFXH+nKlxio8EcS3vDPAgU4kZ3cwvEtoY2mmRraCdlbSIahJ?=
 =?us-ascii?Q?HMnLHhjk+wQ1qWqaYznWlh9J9rgv3qfDpZfRRnJyQXPh/m3ZD7GzWHge6Qno?=
 =?us-ascii?Q?u2tERvQl6G2t7YshjdvFqAM8M1+i12zXfJDLS38pF4xhy7f85xJGezfzL3FO?=
 =?us-ascii?Q?ocWuauRTw/jPMPHtN0xLPl4fYev5ZlL7cg0jYQKkGyeqgWtddZmZLig8bxtx?=
 =?us-ascii?Q?Psxg3ZC9fRy+JqQZ1WVc+UaLV+Kv+HWkzRzctPBFiTlZWtIK4Jx2BlpTnqYc?=
 =?us-ascii?Q?6nOZUDpF5m6fFVsoPa3j8VP3LAsPCt4UrAR/D4D7Xh6uyR/23g8Ju9UnYmfo?=
 =?us-ascii?Q?/roZCp6aK9ZuHn3vYB4CCnhDIwpwO9ETnR7VYQOVB437EgLsBMqsYv1og+hJ?=
 =?us-ascii?Q?LsRIExtecExFLXoG0f8g/7RBkdO/FWSOwzFUHJswjkFzrGY6hO0cPfNrReQf?=
 =?us-ascii?Q?SpWFmrqniBDhAcqoiSzUuU1Jnb/xD8l1SHYpBMYbLLZr5klWHNEIPmY8GSlE?=
 =?us-ascii?Q?r9et0axH7rs5+FU0Vc24F5FqPBUI81qZHtFVBs976PJhNl1IqvOXHm4O/Vzz?=
 =?us-ascii?Q?gWyJY0yL7E98Sd6c+pCYgAo9BDsuKN/iR45uLLauJcsqHrwdN20o4D7j4j3m?=
 =?us-ascii?Q?l7HBPINB0aR3Ru+WqI55FWkIGZWNufJ1M7rqpv24mHKMnPnXdmQIKX5u6zVq?=
 =?us-ascii?Q?N9oEmZJyP0ijVY/0LL5IGGUMBSnSJah+q4iLRJBoMAmwtJ331bOypHk8tERR?=
 =?us-ascii?Q?jBi++aiRr++c6x4xk3Khd3JjHg3Inf8jdzb73mxNgm6zC8y20zcsXfLB8vXX?=
 =?us-ascii?Q?/U3eKmpUIfh7WoAEzrWDBppak4yOCcd4w5lQ34A/4cG+5frVyIQa/rzQwfLo?=
 =?us-ascii?Q?U8PB9b4xBSngaHOt2nlqv5wcSajM6+ChVolZ+m2zhlwE6E2cke6pJoEe9Ss3?=
 =?us-ascii?Q?eH7GEDLB3WIAGE528XErTMinKRFUAQaolRv1HhupzUy1V9sJk7Ejf+COSAHi?=
 =?us-ascii?Q?8mj45cwexeS2VbQKunAUt9StS81+pEbrrmIS2JGuBDK/3icoWiNpWewV6mcp?=
 =?us-ascii?Q?u2/zlpPtfapuAHGtJagHfij/8cjFCyBwnxSX+MYYa60ZBFgvR0rWcpZH+QSw?=
 =?us-ascii?Q?Ale4Y2LWmppzHjmRzfXIJmCou8Q7vjWcARiMA001qvEcG8FSmbSEfp1gr6+r?=
 =?us-ascii?Q?mSPVZXNvMyMPKsa+U7XoCMbvFlWy84gu8iPaZxWiF14ba8D7xCRzRqL5Ovw0?=
 =?us-ascii?Q?lHcePxjPQrF7fT1gvAj/P+AnpNQ05MWqr+UObiG/Y99IZTRsQTD4RbTG0fOR?=
 =?us-ascii?Q?5/N6vcl1BngisW1AqoSkHdqP4iHfbgWNY05IwmSHu81pNT0XL1hu1M3L0TEb?=
 =?us-ascii?Q?caqIIEveLG9gSP6bfn6RZxswugxoURVed1cG7G3sjideMMmg9kTNBan89jna?=
 =?us-ascii?Q?XcBojT/tebm9h6C7Xz/gZcrUI483wlQToCUDE9+gptjM1c1cxvniJfZedZZZ?=
 =?us-ascii?Q?wI7UWvIgsXph1AOhEqi0IMGzOg/pBDTZ64IazHkWN+LzvWA3iX9P5h5DJWQi?=
 =?us-ascii?Q?Ov5cKe/FSc0CASGaqNE8XmJIsYeUaDevEx36wi5B7iHGDxazap7opqskhnMj?=
 =?us-ascii?Q?K/+5MVOly4h4VSgqJsLRzGalGbhuZyqcZP5vpQKsFTygve7BduQX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: of7TdoPVWl9Oziea4g2498SieDNHV4uUkiHyG5PqL3wvE4p5i1Eg2PiqDTt6dwSLrrc9fGFQYYPL8/PTNNrU9kT0CFL/cJPXhZ2co67y7AfwAi7Nom5wlwOVMQZYq+xbWZvF9KqPZNME8xlN/yzFuKuS8rxHviMNQy//To+qaXBLRMrN4DocLtTZqA5MIHc5YyXjvcHN5yERoFv3yThl1ET+m3UzlfRTgf/zFzFkbf5xfzW1smw/JYW4YCxm/WMA0TMBSL/DaoSi8jYdKbPK/NaSUO+2/gt+jn3O7VGcjfoAfM1u4v3VwV13ivKwWEZ/qGqkh9Lr64to3g9e2ErK2A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4796.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d058387-2d52-484d-5687-08df12f4189e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 06:39:30.4043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPco++A66fGZkk138b6uiww2YOnUEx0m76RG94wDmqRGrw6g15MgUfSDTDnpugY59JkgH9f0vVKNCjYD/i9eYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB927648
X-Authority-Analysis: v=2.4 cv=A9/5rKWG c=1 sm=1 tr=0 ts=6aa8e824 cx=c_pps
 a=aWGlcXfvBePkFyJsMZzBEg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=7nnUXl-1-hrF8pdz8xwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: L0Z4dMoIkQEK5K5G5AlbfNBXszdarkaN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA5MiBTYWx0ZWRfX9o5fdrBPb3q1
 TbpwnzRBZowO069iJ6dmGckmmuts98ARJsdkRQrxelyIcOqb0MoX0OtU6Vo9ZPsB9wn3Oviu5U+
 z6cmfOORa2sDQGXcEzeiPugbRJz+I8Y=
X-Proofpoint-GUID: L0Z4dMoIkQEK5K5G5AlbfNBXszdarkaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA5MiBTYWx0ZWRfX59a2NQ+Mb+en
 pJxZrps7O3WB0EMp/1ad3yCQ2qrba5CqcAX8DFlwn85K5ApRmr4pnhNQkW0uu1IbKYvYiDxQ89U
 Y3h/LZT7PYhmhvST6nbVHgY0D0JhfDL5CqK7JA18xGBOMZ7ju1mTeR+HJFtz50rZwb2t1eXY959
 efTaPARUXa5PRHGvOHAV8q6ZcZRGE/BpnBp7vmtSvKy2zx8zd/YfV2kLaml+fOw7SzjIlkkTCZU
 R7bjJfp74GXSwcu4yiSvU0mY7VvDFXyEuZMeTTulf3QtiHqa5ZiJb+D4p9IKTlpuJYVWThHtE/f
 JWqLLikxTsPR3406CxDG4t9rVlHJ9VMgGIs4t0FGHwlhdkxcgx12/DpTFDVG5geOWtF8FU/hS+P
 vID4cnPJPoKTQOyJoYoPv9XnqvbctAjZPDrZRCWw/dhvTLM/G/LS+yvUImYSc2TBipBtnn/T0Zl
 4k2bFOODbwRK3H/wX0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
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

Hi Amiya,

> NPA_POOL_ERR_INT_RANGE fires spuriously between pool creation
> (ptr_start/ptr_end default to 0/~0) and the actual range install
> via roc_npa_pool_op_range_set(). =20
ERR_INT_RANGE is not supposed to fire spuriously. Did you root cause why th=
is is happening ?


> On CN10K this drains the pool
> stack and makes the pool unusable.
Didn't quite understand this part. Could you please elaborate.

Thanks
Ashwin


