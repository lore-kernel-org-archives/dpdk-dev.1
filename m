Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955ECC9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 11:40:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B38E54064A;
	Mon, 28 Sep 2026 13:40:28 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 58DD040275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 13:40:27 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBA7iv2545716; Mon, 28 Sep 2026 04:40:26 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020087.outbound.protection.outlook.com
 [52.101.193.87])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gy2a6k0g9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 04:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft6I/ToyGvxjYt5NaVLLBaS3wL8Pt1Dyy25VR57SDzqaHZM4Oz2/Xfw6vrm7f2Esrh5Tk6TXmI2CsOj7TAp7VJ1/Ga90CPe7ebcXocxjsnmfEP9TVlNaZk2wplBhekcEDNRjylZpB3MnkZcAnameRDj0Tn4Yc/XkEjcjGnmfnwxlB4srV1qItHquZkY7myoG4jC2uiSwIbldxc7roqP9i2n3NFpikRpcNMkBM72+4I5WT+CkTQaXqxUupP0NCG+wVnY3wkq3dogjRej+czEdFYoZXqy8T0/LhOjT75NWohKPs+OWoy6gmkbCUL7GeKDqpu3C3metJj3qxWqwEYa8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZKrYC64/CH0CuFVuM5EHU4THJ7KJKAW1jsVPuOWLs4=;
 b=CbTjwZBX9hdQbbnybCrM6j2oFlw83LdtGy8KRjxuVWhk8SJb1TvQZdA1cN2XKfb8vof5MbKvj4pcC5/s46M79IUIxbeI+D0DUGhRRAh9eeBEeeEakDHtEbcZbyG8E6gGKg0zRc5kQS63NCoSL7an8FbtkocygK2FAusCIuLLyClEuYzlxdNrizN3UluofV+GIS1BzDETfkKAsmmeh+r1efaB2POkU6mqufBcfq44jbJ9yLw5YpFTUAGFbK1u9+mBcePaK05JlUO4kwJ1y/GbPBkmCHQEowYKZqrf2ExQb6mvyYYvgkoGhVj040oOMQC+fkwyu5bj8j/h7VK6ODKP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZKrYC64/CH0CuFVuM5EHU4THJ7KJKAW1jsVPuOWLs4=;
 b=iJoDomuLRu4cLYz6OIiNIEiscpddi4kitDpni2yTJg17H6qkIRaZ2eGWLLP7v8o23DgBEMo1kKR9l7KuMSCu94isSOvKc/Ewhi492SqXdATUaMXMVwkUZyHc6If9qaaZ/hxwbHvFyt1Afu8qQ275VVdoVEwiKveg2BS4dKaz0vI=
Received: from DS0PR18MB5502.namprd18.prod.outlook.com (2603:10b6:8:161::18)
 by SA1PR18MB988362.namprd18.prod.outlook.com (2603:10b6:806:4c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:40:23 +0000
Received: from DS0PR18MB5502.namprd18.prod.outlook.com
 ([fe80::d7f4:471d:b7db:4c56]) by DS0PR18MB5502.namprd18.prod.outlook.com
 ([fe80::d7f4:471d:b7db:4c56%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:40:22 +0000
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] buildtools: remove absolute paths from
 pc file
Thread-Topic: [EXTERNAL] Re: [PATCH 1/1] buildtools: remove absolute paths
 from pc file
Thread-Index: AQHc98j5Z/cPsxaqMUGfctTK/wXDFrY12OSAgAAGIgCAm9MIAIAS2k7z
Date: Mon, 28 Sep 2026 11:40:22 +0000
Message-ID: <DS0PR18MB5502DEE807471AE404403A0BAE8D2@DS0PR18MB5502.namprd18.prod.outlook.com>
References: <20260609043220.930405-1-syalavarthi@marvell.com>
 <aifFFS9gvRn9JYKg@bricha3-mobl1.ger.corp.intel.com>
 <aifKOnqQRhJ4z3nh@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zjQi-9MHaiZdmZoK8wS10GtYA9taN3GN4sGgoMFrxquQ@mail.gmail.com>
In-Reply-To: <CAJFAV8zjQi-9MHaiZdmZoK8wS10GtYA9taN3GN4sGgoMFrxquQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5502:EE_|SA1PR18MB988362:EE_
x-ms-office365-filtering-correlation-id: 3dbf5408-e61e-4130-0263-08df1d554818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|10067099003|4133799003|4143699003|56012099006|38070700021|11063799006;
x-microsoft-antispam-message-info: Mp/mFJp32GbD78rAP/IM9V2Rj9BHOD7DvmphnqywbwFBWV+urI+IQlMU2+x/6ApbYVT1A8D9K8n5cnMvZLShXxxa2wC58TmNL22WSckAZ5vMqfVsimEK/Hg4EEYGcSdghzGCauyhUfVMLh8FdXLhEO6alHtHg5QpdllC9a5+A1C7X81VlxZ5T0c3oRtm/4O9I+wMEHG1OnSW5WhIZ+LFzJIucynpCkpd8TbEv5RLbeAgPNKUpACz/Ge7SIV+1ZU+l0k9EYBIyFfmRRJyjTGeEStspEHVBA+i8QSyMnuT4xGr7XniNmPSPK2p9Xk78I3thkxbnldH1owrDZigECSytZDlwPI73EH3VZdC4/c1/CQ0LdkFJLgQMa9Nc6KnCjVsPlLOx26lilhRxryYTlJBR//RFpNlkHZ5KNVpWtzZuOop7AOxiKwulkz+UB2v79+hcn/Wju9f7G7fVpDMoAGF49VBHB3MfcW899mwxyOVy82kQfebH8w7k6KKIy5cJl1CRc+sY/B+y5XzUqyZM5+w4Y5CUkH35D8zEKr9c2J5o6eBbglnMV5Ur/DlMDYXVFbp08jz6BUeEBhEne4eG7hoN/4fYK61zDnrd3o05EMVwvcuCwvAgPF0pm1PsjcWF+Lc6ZCGh4clJ4xFr+6z229xBVUk2t7qhbOM6SEEz0x0IR5rce9Axxm6wolP+/hRuADZ/KYI0Knr1moOdZL/bQolwhf0+QI/9grrANvZRj/6RKs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5502.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(4133799003)(4143699003)(56012099006)(38070700021)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mS4xiEcIZS5l3Zj20mmSDU8rbi6CljJY6Y6vr6CeenLhSQHUMIGD3NRC9M?=
 =?iso-8859-1?Q?1b56EGhLRgS80p9uXnGH+pFZxwVR3fwxW5AVDqLSi7Uy++pthI2QkfTISu?=
 =?iso-8859-1?Q?qAw3mdkoxrbf1BV+ku1LDcD8hN/yCYeIxzHKoFTXp29wjpiiKS88wBdlKX?=
 =?iso-8859-1?Q?PccIR/joF9ngaAQwo3OLuk3JAYsuojLXZl6q97rpAzVWnXkReGsumAOqub?=
 =?iso-8859-1?Q?au/gyqCU6H8jaB1l6jqVYH4T+xiwupXgQmmV2qQfwIviwghLy1pYExptgT?=
 =?iso-8859-1?Q?O7atqBxD+9yEjzBifqq0D0UihWIK+7CYZWDD6EZvoIjsBuzA5f+v/K5GwP?=
 =?iso-8859-1?Q?6I6vqHgiFSyYxiwesXw6QJB5QYf1ERGAmcX0qBA1Qcu2M33zNoxswByqjL?=
 =?iso-8859-1?Q?Wg8UgmtN+bCSduo9Gp8tx9zQxnUFr3eNdt+RXB6ihJJfA9wcKaQO7Gpxhk?=
 =?iso-8859-1?Q?CDUafnD5d5wH4DMKiB02hIL5NrcM07hJUHdCbb9TcO2hID7CsPQXgqScUz?=
 =?iso-8859-1?Q?P0wAoZt3XOwYhP6BXokd/QwwOCIQpLRk60yOO41A+3Z/PwIshvs/jsINPg?=
 =?iso-8859-1?Q?+039uQkNpCEuRmQ388Ga68tz2/Jya0JnyelP1MD8cwoXW2Pg7zNtwdOJ9R?=
 =?iso-8859-1?Q?V4C9n88f6FjoJe15b3iSA/yYaUTRzA28QkW+eERFiS9C0+erPuelmj4C0w?=
 =?iso-8859-1?Q?/kuM95/9NCYSJNnZGKP0SC12XCl5FzOiueHSBEfzFF6xHWHsFxrnsNB81L?=
 =?iso-8859-1?Q?G7uh2bUkfYGpGKl4WMrCtHDkM2yNNgpffi34hsKzEINzPittZeDDe5gJTS?=
 =?iso-8859-1?Q?34iH1YJvL7FgkDQrTS/VjFskNKWjeMOSrNWWeLvdvVaTtpB5bOC8ZuJ5AM?=
 =?iso-8859-1?Q?Ge5ezTksFPA9y4QzUw9JRTe7YA9/SBeGWVeoyFCx5HgWZmSuSiC5w9B/ua?=
 =?iso-8859-1?Q?sBhQrxZgXKZAj1D1Se0XRMW2MaUZIxG4IstNBfGB2Y0DQduSQacAGFzOfU?=
 =?iso-8859-1?Q?IWj4UPoGGP3d0yborc+bd6AExjNj9kDtJGo9MKuQ14WryKj9Ob/tVznRRo?=
 =?iso-8859-1?Q?FRdwTjsglxDJKmBK4YCEI2VvqrGxV17TW13dVmzT0TxsuKTVEQYhoh30NO?=
 =?iso-8859-1?Q?kq8H75F0xwoz0hCzpMzyrG4XMWcfVQFqO4dyGTbEVI3LS8x8SiTvx4zbpg?=
 =?iso-8859-1?Q?gbWVvH/uQwdn5ALtgiFsnwRWaIsyoy7vRFMxR94mdT4F9Y0WAki314zFLD?=
 =?iso-8859-1?Q?Qv17XOrtBCjG4/90+XyUD5WZpTaKizemzPu0CPEu2mapFD8q8mfFMwSMRD?=
 =?iso-8859-1?Q?tQZ+V3wHBgH0s03pei/RoM2YXB3kbx6PhFiJpSolfY7J4cejOPUQkW0fJ6?=
 =?iso-8859-1?Q?ia/FEou6LugWn0MFaR8OniulzYU1I7SIuARTfrppZHhodGz07voBLpBj1O?=
 =?iso-8859-1?Q?8vWJ1+7apGXq2Q8Xt92o7/ZwloFYf2kvkBTZJR6/izxAumO01hHGdoXGrY?=
 =?iso-8859-1?Q?rh2hfIPLMV4EPYf9y+5n9wDUgMe4G8FPizohxP0Pvc9thYQKyfXtMR2fgb?=
 =?iso-8859-1?Q?2UJlTdOClxGVcC0zdhj9iT8uHvRk2KZsPPwa3qAGe5vVFUwDZD2X2Q460W?=
 =?iso-8859-1?Q?soTEV8408w9pDR6/oqbIjgc8clzIKwS03jIDi4T65iqj8BaYfWiNggxQYW?=
 =?iso-8859-1?Q?2pnEz7nV89L/i/qdox5OF289RYYXsfe3XoKJJa5OECESs9Mqdg9i2Ad/7X?=
 =?iso-8859-1?Q?pReVPeJJlEwkRRBrdhqkh+qKMMWqwwvdOTJ0UkM5iZV9/RD1L3g6TuCR51?=
 =?iso-8859-1?Q?E/Y2aL6/KQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zMGvaX4h88FNY/a2+KCf+jpIEn4xVXyu3WjBTkdCLGcGunRuWuW3Jc6kgLBWv36TYA8G051EkNEAe7QVf/Vm0SljTQrTmex3jCb+oOYKHsmwAzmXBK7nkQ74aDODYsR+kabJTevfvbXyDz6LDNZ79ahpRQr4VzUdmDGd6V/u/UQzhYxW3qwSMEkqR2FErm+ACqSCwug29zJ65ledrWLBLVa4rMVMXCX+QLxUKTRhJJjyxAIG7gk7xt7fNmwci+QiqpQUPR6PQY2yF0r8e/dLu1WF4hCWFxq3Pfbe7Odw97uWeZsv3z3Ia0a2y0lRBwxG6iD7v0ASP87J2o+lbgY0NQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5502.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbf5408-e61e-4130-0263-08df1d554818
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 11:40:22.8670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pjeWLnR4HHZaOY87eFyUIkPNVjrlRkBst8XqRw23Yv7+diKLYiTo19avfRXTakqzsqHW1Q7u2LXTy2NncV5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB988362
X-Proofpoint-GUID: H1THCRqQd9dtexpPPV4jDzAKkzjxb8IS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfXy3zufD/6s75D
 jQQmnLU0sPoKbAOCoiZ1yQXze5JSujEJpRxXddt+GGTm1owK+PfrCl+QmilDmumerQ62xFykz9J
 W/lnp1rN+tOB6qQ1dMJrDFliGogxIO4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX7/nf6d6wpfuw
 +Nxpm8Vca2sI6ZnHi9RPasHxIlX6HDjTLobYvqfcfFFsXxmRTvRy6nHdaf5WxRYMerRegxEM8c2
 yGYx0FDmKO551s6TFym+kyELifG5EUHpxXwySYuXcShrmbTdY5/G1E3Xj3nyqqFdkRO+ejfHv3E
 idIkbldZ7Y6oUL7qp1x4VOJDHpbxWd65YtZ6sOtqhxQxLrQhwY5YDrjlfWciyTUD28ySWisA2VA
 XN+aiP1tDH5JwBHgCgXMo9j4JaCwMaNy9fkOI5o6Q5LMymNjtUmV+v1zRfBpiR/zgF3ni/b5DUP
 Y6x5sAPv+nxhfBF1k1ZtrWC0AwkWQfGbr+0vcmKk9zWUIuNTZ126TjMJvvg8OYewtCE3zUubGhm
 fwNbgihXT3Gf6a4iFe7UJE+FrAjSctiWR5mdvBrkQfuc0+V1j3D9W3eqlrtiF4QYaAIcAAQXglx
 21qLqgxk2N6CJYsny/w==
X-Proofpoint-ORIG-GUID: H1THCRqQd9dtexpPPV4jDzAKkzjxb8IS
X-Authority-Analysis: v=2.4 cv=DJIacCNb c=1 sm=1 tr=0 ts=6aba522a cx=c_pps
 a=kBs6TrnBGiNV6zZMgQ8KSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=NEAV23lmAAAA:8
 a=QyXUC8HyAAAA:8 a=ryjh6__ct1T2mYwIR6cA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
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

=0A=
Hello Srikanth,=0A=
=0A=
On Tue, 9 Jun 2026 at 10:09, Bruce Richardson=0A=
<bruce.richardson@intel.com> wrote:=0A=
>=0A=
> On Tue, Jun 09, 2026 at 08:47:33AM +0100, Bruce Richardson wrote:=0A=
> > On Tue, Jun 09, 2026 at 10:02:20AM +0530, Srikanth Yalavarthi wrote:=0A=
> > > When linking with non-versioned libraries, absolute paths=0A=
> > > of the libraries are added to libdpdk.pc. This patch replaces=0A=
> > > the absolute path with correct linker flags, -l<libname>.=0A=
> > >=0A=
> >=0A=
> > Do we need to check if we need a "-L" flag for some of these paths that=
 are=0A=
> > stripped?=0A=
> >=0A=
> > > https://urldefense.com/v3/__https://github.com/mesonbuild/meson/issue=
s/7766__;!!CRVmXkqW!TW48hr51E1x5ePBpkMXyMXUu-DDKqhHWPvS42CAWnlRSm4UIvshQnKc=
W8hH6Gt_pGrSVW4n7JPkAZg5EjZ0750GmQFBY$=0A=
> > >=0A=
> The bug report indicates that this issue only occurs for some libs which=
=0A=
> are missing an SONAME. Checking the .pc files generated on my own system,=
 I=0A=
> don't see any libs listed with full paths. Out of interest, what librarie=
s=0A=
> are causing problems? (Alternative question - how can we reproduce this=
=0A=
> issue to check the fix :-) )=0A=
=0A=
I see no progress on this thread, can you reply to Bruce please?=0A=
=0A=
=0A=
=0A=
We are observing the issue when compiling DPDK with TVM runtime as dependen=
cy for ml/cnxk driver.=0A=
Below is the Lib.private from libdpdk.pc file=0A=
=0A=
Libs.private: -Wl,--whole-archive -L${libdir} -l:librte_common_cpt.a -l:lib=
rte_common_dpaax.a -l:librte_common_ionic.a -l:librte_common_octeontx.a -l:=
librte_bus_auxiliary.a -l:librte_bus_cdx.a -l:librte_bus_dpaa.a -l:librte_b=
us_fslmc.a -l:librte_bus_ifpga.a -l:librte_bus_pci.a -l:librte_bus_platform=
.a -l:librte_bus_uacce.a -l:librte_bus_vdev.a -l:librte_bus_vmbus.a -l:libr=
te_common_cnxk.a -l:librte_common_nfp.a -l:librte_common_nitrox.a -l:librte=
_common_qat.a -l:librte_common_sfc_efx.a -l:librte_common_sxe2.a -l:librte_=
common_zsda.a -l:librte_mempool_bucket.a -l:librte_mempool_cnxk.a -l:librte=
_mempool_dpaa.a -l:librte_mempool_dpaa2.a -l:librte_mempool_octeontx.a -l:l=
ibrte_mempool_ring.a -l:librte_mempool_stack.a -l:librte_dma_cnxk.a -l:libr=
te_dma_dpaa.a -l:librte_dma_dpaa2.a -l:librte_dma_hisi_acc.a -l:librte_dma_=
hisi_pciep.a -l:librte_dma_odm.a -l:librte_dma_skeleton.a -l:librte_net_af_=
packet.a -l:librte_net_ark.a -l:librte_net_atlantic.a -l:librte_net_avp.a -=
l:librte_net_axgbe.a -l:librte_net_bnx2x.a -l:librte_net_bnxt.a -l:librte_n=
et_bond.a -l:librte_net_cnxk.a -l:librte_net_cxgbe.a -l:librte_net_dpaa.a -=
l:librte_net_dpaa2.a -l:librte_net_ena.a -l:librte_net_enetc.a -l:librte_ne=
t_enetfec.a -l:librte_net_enic.a -l:librte_net_failsafe.a -l:librte_net_gve=
.a -l:librte_net_hinic.a -l:librte_net_hinic3.a -l:librte_net_hns3.a -l:lib=
rte_net_e1000.a -l:librte_net_fm10k.a -l:librte_net_i40e.a -l:librte_net_ia=
vf.a -l:librte_net_ice.a -l:librte_net_idpf.a -l:librte_net_ixgbe.a -l:libr=
te_net_cpfl.a -l:librte_net_ionic.a -l:librte_net_memif.a -l:librte_net_nbl=
.a -l:librte_net_netvsc.a -l:librte_net_nfp.a -l:librte_net_ngbe.a -l:librt=
e_net_null.a -l:librte_net_octeontx.a -l:librte_net_octeon_ep.a -l:librte_n=
et_pcap.a -l:librte_net_pfe.a -l:librte_net_qede.a -l:librte_net_r8169.a -l=
:librte_net_ring.a -l:librte_net_rnp.a -l:librte_net_sfc.a -l:librte_net_so=
ftnic.a -l:librte_net_sxe2.a -l:librte_net_tap.a -l:librte_net_thunderx.a -=
l:librte_net_txgbe.a -l:librte_net_vdev_netvsc.a -l:librte_net_vhost.a -l:l=
ibrte_net_virtio.a -l:librte_net_vmxnet3.a -l:librte_net_xsc.a -l:librte_ne=
t_zxdh.a -l:librte_raw_cnxk_bphy.a -l:librte_raw_cnxk_gpio.a -l:librte_raw_=
cnxk_rvu_lf.a -l:librte_raw_dpaa2_cmdif.a -l:librte_raw_gdtc.a -l:librte_ra=
w_ntb.a -l:librte_raw_skeleton.a -l:librte_crypto_armv8.a -l:librte_crypto_=
bcmfs.a -l:librte_crypto_caam_jr.a -l:librte_crypto_ccp.a -l:librte_crypto_=
cnxk.a -l:librte_crypto_dpaa_sec.a -l:librte_crypto_dpaa2_sec.a -l:librte_c=
rypto_ionic.a -l:librte_crypto_ipsec_mb.a -l:librte_crypto_nitrox.a -l:libr=
te_crypto_null.a -l:librte_crypto_octeontx.a -l:librte_crypto_scheduler.a -=
l:librte_crypto_virtio.a -l:librte_compress_nitrox.a -l:librte_compress_oct=
eontx.a -l:librte_compress_zlib.a -l:librte_regex_cn9k.a -l:librte_ml_cnxk.=
a -l:librte_vdpa_ifc.a -l:librte_vdpa_nfp.a -l:librte_vdpa_sfc.a -l:librte_=
event_cnxk.a -l:librte_event_dpaa.a -l:librte_event_dpaa2.a -l:librte_event=
_dsw.a -l:librte_event_octeontx.a -l:librte_event_opdl.a -l:librte_event_sk=
eleton.a -l:librte_event_sw.a -l:librte_baseband_acc.a -l:librte_baseband_f=
pga_5gnr_fec.a -l:librte_baseband_fpga_lte_fec.a -l:librte_baseband_la12xx.=
a -l:librte_baseband_null.a -l:librte_baseband_turbo_sw.a -l:librte_power_a=
cpi.a -l:librte_power_amd_pstate.a -l:librte_power_cppc.a -l:librte_power_i=
ntel_pstate.a -l:librte_power_intel_uncore.a -l:librte_power_kvm_vm.a -l:li=
brte_node.a -l:librte_graph.a -l:librte_pipeline.a -l:librte_table.a -l:lib=
rte_pdump.a -l:librte_port.a -l:librte_fib.a -l:librte_pdcp.a -l:librte_ips=
ec.a -l:librte_vhost.a -l:librte_stack.a -l:librte_security.a -l:librte_sch=
ed.a -l:librte_reorder.a -l:librte_rib.a -l:librte_mldev.a -l:librte_regexd=
ev.a -l:librte_rawdev.a -l:librte_power.a -l:librte_pcapng.a -l:librte_memb=
er.a -l:librte_lpm.a -l:librte_latencystats.a -l:librte_jobstats.a -l:librt=
e_ip_frag.a -l:librte_gso.a -l:librte_gro.a -l:librte_gpudev.a -l:librte_di=
spatcher.a -l:librte_eventdev.a -l:librte_efd.a -l:librte_dmadev.a -l:librt=
e_distributor.a -l:librte_cryptodev.a -l:librte_compressdev.a -l:librte_cfg=
file.a -l:librte_bpf.a -l:librte_bitratestats.a -l:librte_bbdev.a -l:librte=
_acl.a -l:librte_timer.a -l:librte_hash.a -l:librte_metrics.a -l:librte_cmd=
line.a -l:librte_pci.a -l:librte_ethdev.a -l:librte_meter.a -l:librte_net.a=
 -l:librte_mbuf.a -l:librte_mempool.a -l:librte_rcu.a -l:librte_ring.a -l:l=
ibrte_eal.a -l:librte_pmu.a -l:librte_telemetry.a -l:librte_argparse.a -l:l=
ibrte_kvargs.a -l:librte_log.a -Wl,--no-whole-archive -Wl,--export-dynamic =
/home/syalavarthi/scratch/dpdk-cn10k/sdk-13/upstream/release-default/instal=
l/lib/libdmlc.a /home/syalavarthi/scratch/dpdk-cn10k/sdk-13/upstream/releas=
e-default/install/lib/libtvm_runtime.so -lstdc++ -lIPSec_MB -latomic=0A=
=0A=
Full path is being added for libdmlc.a and libtvm_runtime.so=0A=
The patch would remove the full path from the generated .pc files=0A=
=0A=
=0A=
Srikanth=0A=
