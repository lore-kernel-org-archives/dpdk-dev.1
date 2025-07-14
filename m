Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63449C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 05:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CA05402CC;
	Mon, 14 Jul 2025 07:30:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1E8304013F
 for <dev@dpdk.org>; Mon, 14 Jul 2025 07:30:41 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E4dovc027808;
 Sun, 13 Jul 2025 22:30:41 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2102.outbound.protection.outlook.com [40.107.236.102])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47vu2f02vk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jul 2025 22:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gvgarx3XRc6U5ZLv51SEAUhesQt7WHopmmZBVJzi65ezeaF7zqxNOA/cvRw/jWLoOOgzfCmWTBcQDZ36CcHcyUr9mzjGGkeEoCFGuGny22f9Vi8Ch57nLeR++z69z9ntcxxOw2n4qRTtl0c9Cc+WCWiLtIrbRHvnn2F2/XjCvXeFrRVXIu7fw7tTifw78CjlMzCmLQ/jD3PNKdagjGklG6QqZOBfAhnMmjMe0PRpU/HXWQMEKucNtwOgcsNOqMjlGMoiE7in0K4Xu6oe9rKXeppJWqowHAJ0x+ztCxsnataCm4K35rFtGP5OfX4+wBTRoW4Cdwy0jtDRPwKXOZ2Q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZHWq7kth6LhFambiuHQGpcvGcrN75w9uril/P42vPc=;
 b=jyFT6uQFbMVU3Mu/bsnfSvLk9x8UduWtbHN//UuHndqt+WwptSzEHH0JDr11KfKqKn8E1IqbNcmJcaF9kqyWf7YEqsUIC/0eoXFfEUe3qrUsSgr45UXV2Sd2TsHrg4oQSrGYQKzkmx9ALCuLCyl/NhTYMr9m7Vj93yULCpBdYbcwWjKjlCj0grmMHVGaFzqB9lYvfoO3gintwCf9YvCMFR+jXB4khOP1o/WT3P/vYcSQtv5HY9r1FQ7oDoVaLxaRVkaP8ESXy4l8b07aYutfF2uwfcWQn3MOb2mPJNvUTaev/r9z+ogTrF3luX7fPqRccE/K0yPCSlNBmoPks7IIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZHWq7kth6LhFambiuHQGpcvGcrN75w9uril/P42vPc=;
 b=U3RqLBWcQUJSONwhx8RMl0eUTsBcFS1kl5qdOz+5mC4MeuAXftnagh264wfh+zWBSw0W1cBI+266vwfpvCkVN3tjYlg+3iWapu04Vjwr+TQgCyhQnYuUBBW+Vg6ONv7eq0CfIUNUu35VZSBX0Wq0bIziu2+/soTkTkfBqfZE8dA=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 LV8PR18MB6265.namprd18.prod.outlook.com (2603:10b6:408:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 05:30:37 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 05:30:37 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Anoob Joseph <anoobj@marvell.com>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>
CC: Jerin Jacob <jerinj@marvell.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>
Subject: Re: [EXTERNAL] [PATCH v0 1/1] doc: announce inter-device DMA
 capability support in dmadev
Thread-Topic: [EXTERNAL] [PATCH v0 1/1] doc: announce inter-device DMA
 capability support in dmadev
Thread-Index: AQHb8XfRd4fswZ8Ev0iGb0d3nsi4SbQxHD0AgAABRlc=
Date: Mon, 14 Jul 2025 05:30:37 +0000
Message-ID: <PH0PR18MB4086496D9FFDFF62A20C4B03DE54A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250710085101.1678775-1-vattunuru@marvell.com>
 <PH0PR18MB467232EDCA9A5B6BFB829585DF54A@PH0PR18MB4672.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB467232EDCA9A5B6BFB829585DF54A@PH0PR18MB4672.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|LV8PR18MB6265:EE_
x-ms-office365-filtering-correlation-id: 55032929-76dd-4522-591b-08ddc297903e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Rry53b8V/KDHcsDfVCaOWs4inS3MVIEEuF8AlJ9lUo9VcEh6qNquDgoVxA?=
 =?iso-8859-1?Q?Zpwcmz6gBNhJY4AVypjUlK+cJYah3gZE81qSSk6ZhKsntSUKC9fRNjLhHu?=
 =?iso-8859-1?Q?WaWvryV2GrpQtzgOVlT7E/R6n6iPicXSJ0LN3A4wiWMLCtf0aNWKkXtX0B?=
 =?iso-8859-1?Q?tI4kA37K6Fr5eSICaLkn1meEC1xgy8Plk/uYxEvIYML+3DOpYNATq9JsCQ?=
 =?iso-8859-1?Q?8R8+eO1EFmf9IMS2IuhaddStBQdjk+WIwEptvy/m24QmPND7EimKVjFEli?=
 =?iso-8859-1?Q?6MM6JICX09I8WlVHQn+oyBFj+3oBzugCd4MTSE+ZG+yzESIC2I3Qpy9Wdw?=
 =?iso-8859-1?Q?Ske7qkYSWS0MRmY/lvC6znDmfV0d2Db+euZ4bCnpSxd2G8H+dQCiNJ9WLc?=
 =?iso-8859-1?Q?Vrs+guqUT6cwlRmvoYUHQO3FRehckHdLTU5qc2ySNPw/OyeYEtHbprAyre?=
 =?iso-8859-1?Q?rZ/HGeZIKoHW0v/CS7Qf4DbG6D8iJXfldHsfjaLPxpOKvptecibmaa8YqU?=
 =?iso-8859-1?Q?ktggAxYZe5LdrbrL1W5zH/lOdSzyiBcLO23/nhEAPRvdQFARfnf/lbKzbR?=
 =?iso-8859-1?Q?GVtZdhSvBu4l3vUkHHXQYSuJQa4ncP++aRGQhh+xnCa9BZHfx22dGgaoLO?=
 =?iso-8859-1?Q?lU143Sj+M2PRaUpSw67ngGEFXf6ZgkIpOgT4i8D+yFgOUh2LFu4am7a1ra?=
 =?iso-8859-1?Q?zilV0JqTlaWIBnplEvyfI5IYKJStviFHXsDH0TghbNhUz63dR4xvinC3/H?=
 =?iso-8859-1?Q?xzAU8YvXD+Y+aOE1wCRLcf0PIGkHgxNoGMcdr9+w727cF3DBnEcF1aI0tW?=
 =?iso-8859-1?Q?lnrpheSaOpFEOkHGvS+MzFB+lbZS/uCFHNlbBUXdFIExU/m6OswRRxNgIC?=
 =?iso-8859-1?Q?X9IhFZR6m6ahAL6dQDyyoxdhexozDgZb1xTQI8K6cAISLIpYisTBYDw65M?=
 =?iso-8859-1?Q?p/DKJpqWFtxZtLbrMfoaFWeiGtD5Rnf9TIDsgifqY5oEcXf+InJff0cFod?=
 =?iso-8859-1?Q?gnxZUpKN2tpCOadYcU/j5eegMx7E+n/E1r2/SQSu1iW2jXL7THWDhd+nwZ?=
 =?iso-8859-1?Q?y05iEOfO2yeN/pzuzF4HYIdt5kjxJHj5C5Ls89MaElToH1kF7NCP5QXVvJ?=
 =?iso-8859-1?Q?6aCoQITeEeVy8wlZ7R2QsQSektrcqAEC1XHw9XW1wQYAiPaOZs1G/sfDSl?=
 =?iso-8859-1?Q?dp4pU8GZsHSFhmL/BnMcm5m5H+xk1QuD+U3q+xGyN3cYYFcx8zUHXsO6jD?=
 =?iso-8859-1?Q?pmhcsGt5wneq1ER/4W/jAs6r3QkIs7KXVU8ACcqaujE9XYiQWxYjwUQG8B?=
 =?iso-8859-1?Q?XzckhUMBPQYZrZRPIbLeqxMrT0xxS4P6PNmgDaypvRb/TH2Gn5T5f4Y08n?=
 =?iso-8859-1?Q?zfu3yLcAzEcarpO7gjcQw+XyjvIwFg8N0/fVe/aDTOpUNWG3UltoDIAfcA?=
 =?iso-8859-1?Q?loTR2fIvLP18n7/K2AUUJd/0ReHT9kVOIwWlxX3IJvSELagOiKGRFZ6MS7?=
 =?iso-8859-1?Q?wWRoKLAWTJ1B8M17fQPwEDiZEEM3e2E8eUtZ92r0/qIA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0S/j6gIX0CXS08ckVqqfFnuq7jBa+q8C4DaG9FUqeG4/WZQEtc/+IsgQdn?=
 =?iso-8859-1?Q?J3j1QYSkHDVjmeay6HzKv9UYrWiXgpFfND5egGDSYJ4jEl41Gt9tsm9a4/?=
 =?iso-8859-1?Q?gJBFUiN7Y1CjrCj4p9HLb4ZKdsv1x5eqytbF56Nry8KdtwAUH/5rkZWonC?=
 =?iso-8859-1?Q?B79+mTUP3xIsxi1xdJ9gOzKRkTR/b85BnwPj948NEpdUnBWv6xWst4EB1K?=
 =?iso-8859-1?Q?VsunmL7ndhdECGZRSFEWDu9EscJlZcBuPFPijVboRGtEBOJymPZ9x5U37J?=
 =?iso-8859-1?Q?F2j66lIWJSvKvsTo3lqJt8sPF7Jn1OZhQPRNVbaXxgLDTrn+3y7t9A7x2p?=
 =?iso-8859-1?Q?7PcRScto57JbYdskdCOMWKKbwSIi4M66sMKzad2xopsHBYR9fUGp70xBrq?=
 =?iso-8859-1?Q?6Htyi1CV8fmLALSUhN+JeKq3ILc3iIkvWsdlLcVG/VmN2oaReD4dxJVPN/?=
 =?iso-8859-1?Q?ASwUadRVx64vw0RDKfXyLIwHBFPQhblEyQyERviNwpJG/sBPDn4zGzb49e?=
 =?iso-8859-1?Q?6IDJlhr4IaMX4dnlCkQ9KbDGkxuoRSRH708KiEqn12onh2xLnT5KELxrvo?=
 =?iso-8859-1?Q?1oSUVvornzZIxMGyOwrkp4UktwGJbEJTvSLNppKUhxo4fvts04P/vcFCAd?=
 =?iso-8859-1?Q?LTgs9a3Cmy0t7gauWqS4h3Zfs1hrHF9ekhr5PAs/0h7aGL2TbqtePSi9x2?=
 =?iso-8859-1?Q?9Rx6tK5XZbf1/fiYlXTZ+Y3JISaCAAkMt2c/Oo+CqQaJFBiSmh9/YrvlNo?=
 =?iso-8859-1?Q?oMtDJurVUQb27mJMWYFhQ5QMKI1VcXmyS1KLpQSUuPR3w2iaFgu1+CJmze?=
 =?iso-8859-1?Q?fdAaWjn+vLAAamuVM6laAD0z4ZbX2fLQm0YY4TwWelNn2wg3dMaJJip363?=
 =?iso-8859-1?Q?dF0chfMZd7np3ztV6n8tjnYP6L60m70qxKv2nIdnSVWtlg3OErr5nE5EPU?=
 =?iso-8859-1?Q?m1FQnoIpWKSLXWwsbne814csqAM2j8I/wtuedQegp7KbC/qI9D9Qd09FWK?=
 =?iso-8859-1?Q?gxXqRkRNaC9DD/MrExeMnEp0q3lk1DCQA6WNbCwBVgul34LCv+P6+qOHTm?=
 =?iso-8859-1?Q?uu+hE25g7iiOEStU63LMzQBrmAs4N98mOo2tzdWhSY1ZLwJVolz1ghTJL1?=
 =?iso-8859-1?Q?R4pmKF8wvxV81hWHCDVLgSfyRHaYuacjPHaNyby6WIAEmiyT+8xeW1zEPe?=
 =?iso-8859-1?Q?LsXJ0ObpLnI80BDN4q7xabzZkfBaTCAh06iHjm9vNad5I6SeTqgVWIrAe7?=
 =?iso-8859-1?Q?tg2v2oLeG/uQIE+x3HzPh+nuGbA8tsNrgnaiEfh7RAnVD2PwWFpnHwncJB?=
 =?iso-8859-1?Q?jJqN0TbqcJswnvDY9xI5sIk/UMRgjPKY+GfCbQCADVEHHbHKGIDLZC8BOi?=
 =?iso-8859-1?Q?+MSQuyHGgtfkir7ZHiFl43osu0uyOXlMM+jUT5RQWV/sv2RIXMVxN/ZssT?=
 =?iso-8859-1?Q?XY2cKgzJnCvtnTapEfLsrzMqJpCfod9T179eoMKQ41Pkk6Ea35gBbXA3kk?=
 =?iso-8859-1?Q?HjDGs+m3xjLOMsL1IakNUWkm41XlvrSp7Hs1da3ZeqD6f5sitxX+Hb4qTt?=
 =?iso-8859-1?Q?lm02UoW9juNV/6eyIxSaDpxQfVRXW6W8FNzBs2PeEqb5raFjHQ7NZBlale?=
 =?iso-8859-1?Q?O6nkjWvWsm46bmcH9cY5CbVcGCu1E+hP57?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55032929-76dd-4522-591b-08ddc297903e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 05:30:37.1846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ar0RCkfQK1Kij0DPXCRZG29KXYF7u2Q9gKR1qaGxw26GkJtbwCvQRe/NSWjXmEcchYhg/090czxX7nKyfAq0U9AWT2ykWJpvpZfruUli5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6265
X-Proofpoint-GUID: 9slX1KsUIAfRhxt5n3sK_5khBT6aKJGt
X-Authority-Analysis: v=2.4 cv=MMxgmNZl c=1 sm=1 tr=0 ts=68749600 cx=c_pps
 a=G6ldE1qBn6ExQWwk5g5X6g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=7hVSmsld0JzDz3m3tlAA:9
 a=wPNLvfGTeEIA:10 a=ZXulRonScM0A:10 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 9slX1KsUIAfRhxt5n3sK_5khBT6aKJGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzMCBTYWx0ZWRfX00Bn/pANxwAb
 Qt169cJjAyMcufwfRC6EzkuzLTAD5SV3BtcGvGQeNroX26k2FB6vDeTs1kirZneBKRrtofdMvFb
 oLmCdS92L3DFxrbzIlvVyfdJiXCMvLvPwS4T6sbKnvGEf5cnZgoTr9PkqZxQzhPH5KZl0GTHr1W
 LHAaNNhfW6ijY7iwrtqsYOKlVEIRTs8gYrBslJO8YUlF1ccUhpSFp5Sil8H9UZSG4JHHFC5HzY/
 cMJxwtqrMSCRcGnYDlXcbi7tR1Xfdcroec+2Ynil6vIanoTw2aUcK7+BeBU/6GOwIBX+fOzdPyp
 BkVr+nT/FhB+cdkUogv/u+HBZTsSCxbsahI2lietNi6o4A+5ciipsdoec5BURAwQ75AlhUGfPnj
 4/cE9Sg40sVYseNCmf9P58dsIlOzdZrtBVF1cb+gt+S5CAo2204zWf8TWh4+bOXMLovbwVhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
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

>> From: Vamsi Attunuru <mailto:vattunuru@marvell.com>=0A=
>>=0A=
>> Modern DMA hardware supports data transfer between multiple=0A=
>> DMA devices, enabling data communication across isolated domains or=0A=
>> containers. To facilitate this, the ``dmadev`` library requires changes=
=0A=
>> to allow devices to register with or unregisters from DMA groups for=0A=
>> inter-device communication. This feature is planned for inclusion=0A=
>> in DPDK 25.11.=0A=
>>=0A=
>> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>=0A=
>=0A=
>Acked-by: Anoob Joseph <anoobj@marvell.com>=0A=
=0A=
Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
=0A=
>=0A=
>=0A=
>=
