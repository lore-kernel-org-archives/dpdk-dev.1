Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D9CA5FD9
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 07:32:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 844CC40144;
	Fri,  2 Oct 2026 09:32:43 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6EDBB400D5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 16:58:33 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691DgZEQ2638291; Thu, 1 Oct 2026 07:58:32 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022105.outbound.protection.outlook.com [40.107.209.105])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h1pms8vs3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 07:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cY9wnCF/RyI7uxtG4NFuHYOZwmj+X5Q62Oeo1nl/qfZbtXT8wpQiNwcOFnE0ehlVPTV7jKhl8My50ed1w0kLLMGfG50B5TnJhHXy2JBwyJM826gubQkehnF5ay4IWVePCTGpwKyyrj5CpFuYTswAK/gZhWYP1tf2t3UkTAjaA7RNRw5wA86QSbUDJjoaBPYgBJYoMs4kPMf7wDb04TPIzXr73/rpgQGOHsi7nZ7c//CqYktYe0tcrbMoAbox2PwWaKvCtitOnJDwoMP2ou8gR9/Te8/0437vhjFT0cczKGUOFpzqwLOuxSCyd7Pf2uWTeZIrEryCP0EIDKrQmOZ8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFiym5F3aPrlEO/iwgma18KjPw8vWvXRIOtY1Bl2MEA=;
 b=xmvMfvivNHa38dILnPFOv/PzhluxEYPWHqp0nU33lAfCsVZ/n8iw3amlHWc0YZ3I+9/2rLmIeia5WCKpE0D/4OgElXo+aWAx3zl1tyiE+nOUmYdk0Iu+qn+cmU9DoxuFXsgwnnYj1xMlIVnICtyo6nJyHYw0cr0nn/EdseP7a9gKR3d4aDo5dxTq+IAgwVXe6vdRFE/17p4Qp40u0BFRquUbJiPwEEYt5HjtqTmpd2H2pqNfJ0e8wrs5DRyzS2SukKMeIhxSjVJCWo79N7KTR0ZBq561iu9sq8STMZBF3hhDHDmOZ4BZ3IMJWljiKhQx91iu63sBencdtJ0Mo6IYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFiym5F3aPrlEO/iwgma18KjPw8vWvXRIOtY1Bl2MEA=;
 b=pqU5i0bM0Ih6H2Ht0wxd79OZJlCWtC/JLtqpkQeyNtv1G49Fu654AKIAasQWcVRvTaeKvcLn81ATJegt6dHnqUPV3lGhohmC6Xnjr4aNnB5so3N5KLVX0F/wVasjlgQhoFIKKrwwQvKf41Ud4eVsegdDzIsfnwWhOJmTmqhEPow=
Received: from LV8PR18MB6078.namprd18.prod.outlook.com (2603:10b6:408:224::5)
 by SJ2PR18MB5713.namprd18.prod.outlook.com (2603:10b6:a03:56d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 14:58:24 +0000
Received: from LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2]) by LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2%3]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 14:58:23 +0000
From: Pratik Senapati <psenapati@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/4] app/crypto-perf: support mldsa
 Sign-Iteration
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/4] app/crypto-perf: support mldsa
 Sign-Iteration
Thread-Index: AQHdUNMO4kpxJPSEtEK5+qTuymlXQLboxxNR
Date: Thu, 1 Oct 2026 14:58:23 +0000
Message-ID: <LV8PR18MB6078F14394D1B1812C574D15BD8A2@LV8PR18MB6078.namprd18.prod.outlook.com>
References: <20260929105851.1305127-1-psenapati@marvell.com>
 <20260929122044.1344518-1-psenapati@marvell.com>
 <64d81a94-4578-4362-920d-a049e0207c68@intel.com>
In-Reply-To: <64d81a94-4578-4362-920d-a049e0207c68@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB6078:EE_|SJ2PR18MB5713:EE_
x-ms-office365-filtering-correlation-id: 7f875085-b56c-40d9-a7a4-08df1fcc70ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: fgEVou4z1NayyBMuJ3efVSvk2n9cXXORNeeaTOHVjqknTwjpd2h7cqnQ06tvPi7GFAJXdbCXW5yOoUF6V1EUOHNSDpNDWXUMcGAKB2B3l3cGszUHGeUMvV91UZn2voIWcoqjbElKDwWYeHWNSlHm2D1pgu2xUUSRiGsZK0L50+CPfClEyjJXEuEynBtMwAPL0/++T8x6dirZIxoza3c30kqmfMgQGl7sohNNeDOqH5OfNwnsMLiNbDlI4bQAL15yCNcxyhV27PtD/FMkKrwwqq1vfgr7Hc/H3Fd0CnhIkNwnL3DHJJ6RW94FIEDl/+KBovwuBrsZlLOVRDr+j3HcYVHBfzhPQH3sUNBU+J2TTVJI/xjk1ssXYOkJ1lrLzBTLXZMxtGuuEGZc6uFXqRitYgn7nzVcfdkyLDasdvfKW/GRiDkvMqc9/NKEDAtq7R+dg9h5Yn4+EGw5E4tUwv6rvtKcSeOaNIuH5ZMfe0dFbJTzGaTOw5PL+MCMGYqh98/nK2JEXmN/cdsoxamGntK1s9cl8Oyjs0oKcVhNQ+a8CQ6vF80cGzDMahrE69/LiboRnnzmlQ+mdjQO3eRqo61HQU/WEnYksxSmw44k02dCIWljWgVOvhJpe4vX90uF+B0z1hUTsQkQc1563FtyEZ+OerUFDezirYXDcIv7jYM46QNwcIgAucojR6z7I+BTUFNUicOu03LUpfe+mHA7CTlLUJhysKeIiMkdWTluFrs9tuc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR18MB6078.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sqJjXOYJStccRizr+3qFq1PkRs5CUj3cQNaf5qTlt1Wvn1MJ0PgXXct7hp?=
 =?iso-8859-1?Q?aQ4+eJTLQ6ANmq+TZ805jDMmmDER1QiuqQ/5ufpyBOt9OyvRstyEZ8X1V2?=
 =?iso-8859-1?Q?rTHwpngDDcDgt7uvcwomJRsc5SOgPR+Ex4btzUIw01fbNGvknZ2IXZfzK5?=
 =?iso-8859-1?Q?958005iKt4ZmAROvxdLdB1iM94J52RX6t3yhoLBzYVHLOuveypJ5znaZIg?=
 =?iso-8859-1?Q?5bFKD41BoPTntQkm/vLtiissEBcE/jeWJepI5Np7X7W4eVWnxLwfa1Rrro?=
 =?iso-8859-1?Q?i3Jy99tC+gtXRSmy8xdQ0JmFOBpf435fTdDmnuYO/6ylKJddV9quMEhTJp?=
 =?iso-8859-1?Q?GPeWwXx0Bn3H+1ADONUvvSFU5XhUmglpjqyiGfduMCZkiyxb41UHIseQt3?=
 =?iso-8859-1?Q?Fr2jxdtr24kHkpj9idWjgh6o54GDn/n3yRJcn48Gkzfzrp1KukdjbC7Q14?=
 =?iso-8859-1?Q?SHLjsQa55j7EoJqpHQIZCCggF2CheqnWSeqk0K7BEuU2pWxVG/INn+j7e+?=
 =?iso-8859-1?Q?jQhnVpkgpdz6pPunCXLw7oBY6o4N2uc99Rr5NwDARp38iP+lVLfQA52ekB?=
 =?iso-8859-1?Q?+psfdN37hEqb/SM7M1DV8bpZZXJNDgkG8gT4hmZfkMqeGVeqNhg9Fp0Kly?=
 =?iso-8859-1?Q?MuaccH0ct0VqP1y/tvfeJ+vr6aj1kSRbgCKCBQepGSqAC5weNRTQFZ+W2x?=
 =?iso-8859-1?Q?Lff8qK9Ch5ODHZc8LCVXDj+nTJAyLNRXEPTaQyYKEI1tN38OeRB/Vq2XVY?=
 =?iso-8859-1?Q?snMZRcqYJUauZ5WdawDUCpq1NhV/lySJ301RRpzl0AInGnXA9jt0KvADEg?=
 =?iso-8859-1?Q?dVDTqtjkAxdmMfni0XDf03mys6jcIyDHu+rF23jbULN2yyLpG9IIjmNgdr?=
 =?iso-8859-1?Q?R/BKArxAz2HieK0AEziTszZZJJj1MrOujbFhULqXivOFvII10bibPnU/nu?=
 =?iso-8859-1?Q?CyObd69RP2sIReszJKW6nc14EPqsMUpLs8AqSCVguLpRxT8T/Jawdq/a6u?=
 =?iso-8859-1?Q?nQ2G92Oyy671LR0mf/lp2s/ENBC+k78jUaCiQJb2Fn7/Ysl9+iLIjS/pqX?=
 =?iso-8859-1?Q?FajhJFzI6KklsGwwwu9FLQmx2DS2b7doS0Y3ZJo8VLEalx/oAZDUHGBs52?=
 =?iso-8859-1?Q?EzYisc4ECw/0OSmFtF9GuhsLOzWV29QUUihkxCzOlzu7Nat6CWzyc8ExUc?=
 =?iso-8859-1?Q?vaPMRwVYIPleql0GDNDyVexrdEwqlTkU/jpwvzkij6AdtZuMV2XM1ALQsG?=
 =?iso-8859-1?Q?vFsxQalVWfLN7uivQJehYCZ4LjCyGeX/+e0RSnCKEhJ9Hu+uLu+7GO4/1U?=
 =?iso-8859-1?Q?ZY0EJ64EQnX3pMui95La7AwjIGJlnHAimiHzCTdjThIYzbUQjlNpEF1dMt?=
 =?iso-8859-1?Q?63XaZ8K50M6On5sBR8dj7tePGrMOlOALQ/lb5vnf3RNdOrX7loEs25ex8E?=
 =?iso-8859-1?Q?VIRoRnDl1JxENWgVoIIKkCXFOkRxs2i3SoF8zBdnte9SjGsDUL/aGlbbTq?=
 =?iso-8859-1?Q?N961D4P37vHUG92P3NPCBS5spmS/9qfLCl5xwU5ovBp09TNnALAHnuBicX?=
 =?iso-8859-1?Q?I1D6Y4T3xDa07b1CNTyqR50rHWi31bGYTJc/dR1vmxVVEzBqTYK12NF4f3?=
 =?iso-8859-1?Q?3Fb6DlPvmNm2t8zl75Pu6RhswmbCjUfszDeF8N5lYCouY0AtKwbwWnej5z?=
 =?iso-8859-1?Q?Ta9odiwTbBHioFd1EXnnYHfCxss0XU0VWvGjAJkoM5AhU/PtQPSJmPFIgp?=
 =?iso-8859-1?Q?EOCngUEj7yT+ZE6t4HOVZHI7rWrWjYA3ZFU4SOPM/fyY97?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cPBxxjBoPHhWNr/2g3BfHvDroJS93qWln3b2dEEvwCUYmIrvfiay1Bb6Yl2m2RAcqq5nkUzY42CH+xojlIZldre6Wul2u0VJmXtb8bR59z59XnUYqLGDDefpqHDvNt5RxaNQY+phTPYJ/c4V8JG+PTVDMQ3ooxCqWDbIWBpnhC7qHwbVFm9iTlY8saaFgCFCBpZNI662cSGj7CjPqHdGpTHKus5sxMxsxrGoy7X1vBdO93x2BMFzPVJPSC0aptJa2xtNqkFl5hmFmsfEUNYTO210brwrIuSAZHm5xMqoZxJLszntu6zEOBY3ZiA6A8hriTFs2Y7j9gdM0XwQGdBxjA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB6078.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f875085-b56c-40d9-a7a4-08df1fcc70ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 14:58:23.7711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riPiOKYU2osl/vWkXVhZaIPIHJCpdb2nV52HUWa9MzZQ4xhBbgiCTQz6FzjonOcYOJsfO7SahNCe0pzrGhFIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5713
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXzV2xRETEKo6n
 8ejImFr7y7ylYMrjAESxDIpPM2taKaI3EH4/pvKBlslfT6kBIzBoXvu2mQ9Sbwc7/ag2LEJR0X6
 T6cOPvyaW8HfLxgq9nqkzxBw4eBD3BE=
X-Authority-Analysis: v=2.4 cv=b7QncdGx c=1 sm=1 tr=0 ts=6abe7518 cx=c_pps
 a=5fNYnt3/gC+uMcP5UkWVcQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=QyXUC8HyAAAA:8
 a=0j4XR15DmpdQtV40gkkA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX2j4z+BLqLEFM
 9IjA1+wpHdQmZYVcvbmoWtq0kTu6JPnXG93R9EMx7ZDuXOyUxk+ZS+owhghbISa4bdl7vn5/oJl
 A1yi+AwLL+rTR7C8MfN7Wjpqva5Agi1dh4uzstkZXUdhLYUODXQzE1NWcRE+dDxVpPbTnhU35LZ
 6BnU/8C+Jeq1txDbU5qnaBSaM9EWEhu1dxdVBn+9MP9Dub02falbzjLyt/uF31ZOZnJ8uoiZ+MC
 niQNVlCzDG9rX2XkZ0er5B0jc1TOXlQRyFZdWiR23Li7Lmritmc6GXEqGHpp/l6GbBqHPK9S4H8
 /z7h/JXgbIsWZ9episoL557rFjsUXrWx8rQk+aNX6+w8apTOzRby9fAoF7w6jeaPWa++ix4KBGm
 zDeLGNmfYHZdBM+iDWUO3dzQBNnR3HjtnUM9AdeouGWrm1xKAsfPuC0oOPNqs9VSIYBx70EbsjJ
 6NlBhyOXdrNG/iGSr1g==
X-Proofpoint-GUID: xMtpe_kvgWJ20M8jsVDugC1X_MN91kL7
X-Proofpoint-ORIG-GUID: xMtpe_kvgWJ20M8jsVDugC1X_MN91kL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Mailman-Approved-At: Fri, 02 Oct 2026 09:32:42 +0200
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

> Series-tested-by: Radu Nicolau <radu.nicolau@intel.com>=0A=
=0A=
Hi,=0A=
=0A=
I checked your patch-set, and my patch-set DOES NOT have the following patc=
hes:=0A=
=0A=
- ML-DSA sign: non-deterministic, sha3_256, and ext-mu variants for 65 and =
87 (6 cases)=0A=
- ML-KEM encap: non-deterministic (random message) variants for 768 and 102=
4 (2 cases)=0A=
=0A=
My patchset doesn't have the above patches since it was out of scope for ou=
r requirements.=0A=
=0A=
To conclude:=0A=
=0A=
We can do the following: =0A=
- I can include your test-cases and add your sign-off.=0A=
- We can accept your patch-set and reject mine.=0A=
=0A=
Please let me know what you'd like to do.=0A=
=0A=
Thanks,=0A=
Pratik=0A=
=0A=
