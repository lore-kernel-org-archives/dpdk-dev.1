Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A1C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:11:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29708427E7;
	Wed, 21 May 2025 16:11:09 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 92EC34028F
 for <dev@dpdk.org>; Wed, 21 May 2025 16:11:07 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDqS91000737;
 Wed, 21 May 2025 07:11:06 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3puse0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 07:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+eLrmN2Fwemm4eG5EDIGnnPITGrOOxxBwxDHGNlDpaNDEMOktwGtmqB15lhImpAwAUljvjh5f/Go88JavOwvMI4iLmUkSXtBzDA5YdCxb3oSYRCS2xjeuc6Is3jbjj2aMXAiHYdQLKq+XIUqpYlpLMz6w9NUtJBoPDtPsUjcn0FBn3jO+dj7/UiAjMAmFEIpj+ifUtvIsgYNEUQbEy+6N1vTHtMShAsXStDq++DqzNZ1ql7u0dakdPfcB/ySOm6C01J6Ug7lFQUFmRqAXrUT9ZIyPt22POcDdumPHugsnnkzDxv8gYpVCIPYkIX/nbaV63EEKF13Lt6U5ruyYqPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b6ACrFtdMp25EB5WNfYZ107gtGksCVj82RXNBlQfcQ=;
 b=zP7JKvuglJcP2V3iq1Uwp2tJwDG52B0BCVuH2m7qaMgzqeYKvQdfWCN56ZEoHgBb1m5PPEkK5dGa1u3F8NWLeOhbjPCB/GVFaUyjpiOwvVtZY4XDm7RMzuSo/8JLHTi3k/Rjv67g3mgy926R1CTJ0W4rJOspFYw5qTJBpGoqj/8LNSfmFho7Uy9w37Y0MuxCd0rHOvm+LYeZL0Jcgs7SceAYWg8MSPUZplSSFboBALjkCTubJ08EFutDizhj1Yz/x/y+1qVBAPVZbR0mNce3yM1DQFIN31sPGoNUO4umtOvzikxPoyQCOBLimlYAcF/0ZGMCXDk0zFxO4uaJTY6+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b6ACrFtdMp25EB5WNfYZ107gtGksCVj82RXNBlQfcQ=;
 b=Xpd6Sao166fULU56IbHewIPwE5Q95vJ6eyvT5pz4l0revJOFjecvgit2ag77SKG83mnzM3BvV8Vx/Ht9o0xXYMXU55pZvSZ64A0CswGzFQJQflUYlhT+78pVVdlCH+d9irKoHuv7975lr5I5ceGCZ5uJwcoH8hP3xWACO5qxWMY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3467.namprd18.prod.outlook.com (2603:10b6:303:55::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.19; Wed, 21 May 2025 14:11:02 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 14:11:02 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Anoob Joseph <anoobj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "suanmingm@nvidia.com" <suanmingm@nvidia.com>, "kai.ji@intel.com"
 <kai.ji@intel.com>, "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "brian.dooley@intel.com" <brian.dooley@intel.com>
Subject: RE: [PATCH] doc: add limitation in using segment-sz in crypto-perf
Thread-Topic: [PATCH] doc: add limitation in using segment-sz in crypto-perf
Thread-Index: AQHbxluS1mB3d/KPz0m/+b76K5lPbrPVVF0AgAfTNUA=
Date: Wed, 21 May 2025 14:11:02 +0000
Message-ID: <CO6PR18MB4484ADC9181F58853CDA4C01D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250516121043.145572-1-gakhil@marvell.com>
 <PH0PR18MB46722C2377C833F92C728E30DF93A@PH0PR18MB4672.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB46722C2377C833F92C728E30DF93A@PH0PR18MB4672.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3467:EE_
x-ms-office365-filtering-correlation-id: b9756725-04de-4479-5664-08dd987151c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?S89iAAfLa3sbCmFjUPQwgDFdl8mBYjLgBCf8bJxmPBkCVJBRP7u5p8tXpAmg?=
 =?us-ascii?Q?aZ9lSXMGQgiJNfIcKGioKQgIHAFQB9eEZ/uYFjZFeFMqkHv2X83PR5+8XC3U?=
 =?us-ascii?Q?6aCqr3jIJnA46keX5O/p7Li1NXSUxASG3pDON6/VtezAxTLaTgwiXQmuLlF+?=
 =?us-ascii?Q?69XLfUMrEwoBcWs4L9Tt1GqteocMxWMCnf9IEK+lvExM7/a20EQauiSc+v2o?=
 =?us-ascii?Q?zgim2UrBlILuq2mVmgHE5hPWybfyM+I3t57Hy9qqdkMu2/dgUkwKhz0p0Z9j?=
 =?us-ascii?Q?kog/0BWl/3jj8lmNCI5Dn+hMGDXs8v/qgnFG6mLCbVKg8YFqWRo33zxjgz1a?=
 =?us-ascii?Q?UeXTyezemcko2tzpr/ufuzkN7CYcco7wQtT/p1WPj6S0QV3X/h/dBOtojooR?=
 =?us-ascii?Q?MEcMhN4cnr794of2cTEDSSx1vahyjS5evaA6KAgcYQjFOaMGv7qzWJN3SViT?=
 =?us-ascii?Q?U5aqFz0VKF9/8roiAPaDCZy/KMHXJcAefW1be9VAhxZzqB76+AUGrhPQXYs2?=
 =?us-ascii?Q?8vPCLlvMxwqxyxU8VWmTOrgIZKNOOISNDrydLhJB3qSIuYapVs8n1oVGxAqc?=
 =?us-ascii?Q?VduVX0ERpu5FJqcmCO2vM010N8CuKG3+5UcY5Qwg1swxKpk/Z7cRAegP7/De?=
 =?us-ascii?Q?IgmOsbYeiTjxY+RoqG/cbj0i8NbrFJpQ5ExhQ+ySgV54NBt978H4xIYT1u2f?=
 =?us-ascii?Q?N3RWpX0l4ZtSX47Vc8aI+nYXqDJ1sMqNI6m58n/KQqDAcGjEJHQJ3v/w65Hq?=
 =?us-ascii?Q?60uP2HZweXO63DWAvKNcgLBH2zWaFZQjqCWmrYaOUdZgEwEA70J7PEG4Q9Cc?=
 =?us-ascii?Q?MTct4YhiJ7ITRC40B00Y6BJG/03TJTX5WmGfFjTLnXb+BKVo14Oqq2IQ8pmS?=
 =?us-ascii?Q?jHsIvGHbNObMwrQ6Uj5EdtGK11VLBODEVUX5AjaJyAbx5PYfkD9SYSHUfF+o?=
 =?us-ascii?Q?6ikt5gk4ArTEYL6VTz5Mi+4eqeATBQpy14rp2IfVfKLYbrtC2eS7DAj/JJKU?=
 =?us-ascii?Q?FZT1otKJgXj9vGE7sKOm+5+BexgiL1iW3gej3C8Vq9gIZQIq2EI2RRdz3ucN?=
 =?us-ascii?Q?rCWHn9h3JfZogK7/DfQLmx5h69NkuXPRmIYpkqPtyszLWZrBu0+tYXeJexft?=
 =?us-ascii?Q?KELW/3VxBvu8/4J/7+KTmwjtYWZNgxiQHdybqzmQR4ZqRLDF/8+e7dfWomrI?=
 =?us-ascii?Q?es1BIfOIwTpX8q0FvlMCCs6N6VG1hjIwoNXKrnaAqKrSmTatwWa7MnomFPCw?=
 =?us-ascii?Q?yUb9NwY3Laxc9673X/bGdS6+/NbQ+k/8EK+t3RDzGw4BDmj02dVskj5IHgv1?=
 =?us-ascii?Q?TG4zkkQBDSVQCdSs2r0amsIhzKeiFiBFCsMrwEfPohU9Rhq4EXsW8pQD6Ink?=
 =?us-ascii?Q?kqz6ydpf0tBLwjeBXsFXugcwNjYEaTTvYzSUswLCgBwTQle05g4ZPclzXi+t?=
 =?us-ascii?Q?dvpDDUC5AcekW/LGmxcGaU5htzacJyhMlDRlGtoTjwKkMe+4xPNsavnRpmFY?=
 =?us-ascii?Q?x+5SJ2q2y+BFSIg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SzMXm2iXJigh7xFSOmVo8AFbaUBHs6t30IyxQN2jXUgCB4lkvHNuJEOk5J4D?=
 =?us-ascii?Q?O+Gnsn2uIUQ0Or4+h92fui365OPjzk0l2Jk3GdUWb6wfLk/cxn3Zes/hkdRZ?=
 =?us-ascii?Q?78O4Sdz7v7aYjNEc20RpytlkGuXzqvsiN6CaYnSOsPaD0Juco3rJ51o/njga?=
 =?us-ascii?Q?+dMllQHMY5zX7xxJDTjGfi+1gqEtF9Nahsy45PuND9SUvYA3JkRGgQm7umOy?=
 =?us-ascii?Q?KMihdQ66BupGQSlvh2hIh0vL+ewVyHTpHSinqQwhSksS5UNE7oC0eGBCLllk?=
 =?us-ascii?Q?6hEg0tgBUhexxcCc1/oZHJkjaXtedz1mC0hWhYFwlI9j1Yo/+Rgueym/V/cs?=
 =?us-ascii?Q?nST59pErAHgiDhC3HyUoBUnvK5kYHnfNmXLa/FJjmtZWkxH9pLXNiH0l+YW3?=
 =?us-ascii?Q?9W5tPTu1d8OUM7VVW5PcI0ljhHzqLc8f6c1RrQVnMhtMmgfS8m0es9aXi0i+?=
 =?us-ascii?Q?DvOZnw8xmpIPGdUlKKjYB730++WZ02DnYLGQhSwC0Et67F/i1tIOvlLXVusm?=
 =?us-ascii?Q?8T/LXmePLoeEpKCnJI3GCV62cQSK5bIijoFTpVtkMOgAe9mITL2oglxPT+MJ?=
 =?us-ascii?Q?vhFubQ98lfUAnKJpGRsMQXMj0XrGH8O5I5p9tH37nCAR+/ZxaEEaGGHRiPzu?=
 =?us-ascii?Q?d/B068xgGHvA6wkiZYYemOwTbq/A2OunhrxBQ5h+cYeuh/24NydYqCZL6QKU?=
 =?us-ascii?Q?xFh5jNzRazQXJPiZ+ZqG51bqgh66VIIAiosR1Kbf9cC2HmJWs6ja2BVwYtHs?=
 =?us-ascii?Q?K5Xwoc3SelkWpjlyZXWWcb099zLmYfhVHiio0LDU8JeJYNga++JgvpX+Sros?=
 =?us-ascii?Q?OH4NlufXVSj8sPywBuOqA2ceL8bCenp+m4HU1AJi2gjJeCurdYS+8LNu5W+2?=
 =?us-ascii?Q?HGlO6X+DVQPxq0EBQBcA7Szq6lPx7+zHRQHkFXSJg3PzwRaxtptgyMStiG9c?=
 =?us-ascii?Q?6rjLfrg5W+2XXiRg7h17z2fAtx47Tu2mk1ONUBnaGwmGMK5AMfwmKeDw4/ds?=
 =?us-ascii?Q?yjm2jgX3GzZnSvilkwR6hhbtGyWC0C3CevY7icQn0fV/ZQPE+Qpxc4obO99v?=
 =?us-ascii?Q?sLDYE55jFnx3X1bxv70G969wUfyZoTu5WSdJBJnTKI97Mhg28KDVVmlZCG5h?=
 =?us-ascii?Q?av25dkyDqeEY7b7w3n1AZJIuq+IWos70iMwK3ZhK49vGiz5VJOaHCEFSdAIQ?=
 =?us-ascii?Q?JtiJkOBnt+K5Ug+jwmlViK6EV7+bGBNMqsr6U2cgAhubaXL0QdvIv2Y/iRyk?=
 =?us-ascii?Q?29u56ja9rLUnk+PCz6s9zgPoGDo1r+ziqBhaxcH7USY+OLPuyF+iRbq7C8Xh?=
 =?us-ascii?Q?XOTKjB5mdsr4Ybo5iCYOYuyq3twp15xwR1D9FAwuCSRHOQHpjxD4Oo66FrwQ?=
 =?us-ascii?Q?z2X+hvcqtIBDEuPXJcReblSCqJE/RbnvnP7JcapsCJuq48sqhYmnzwCSTsCE?=
 =?us-ascii?Q?yus7t4RrTfm8/0FNhjvtGGBVlzA5hmAXxOZUnfKbz5ZKvfPGervje5kIOX2d?=
 =?us-ascii?Q?3vP+dxo7EnVEns25Fo0ox6W+X5ZJG1YcO9lj1nqXDufubKD2dJ5jtMgYZHWY?=
 =?us-ascii?Q?exFiKS4Y/IrFjbMkocaB01XSTryFEEz9g6CwPLPH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9756725-04de-4479-5664-08dd987151c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 14:11:02.6556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgxn+qi9NlMsQchpuWjWNvGI74p3Tk08r7nRBZs4fhbVWHq9QlUZzZNWCP1whHUixO6juyENHvn/5XoNk6YYYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3467
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682ddefa cx=c_pps
 a=Syk5hotmcjzKYaivvMT4gg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=vxN744pzERLlxbrStJoA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ZvlK4SktXvH-4YHj3kp3im6o-3iA8HWt
X-Proofpoint-GUID: ZvlK4SktXvH-4YHj3kp3im6o-3iA8HWt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzOCBTYWx0ZWRfX3rjkE9oFCtx0
 cQBRyu/MgakeSKs73FOz71xsy1pHfH2OJmmtI3aKj36eu80siRzBSYGN4LgWx3FQImQn3sB0yEl
 hseJTChw/1lQxfB2mBqqDwitURNrWQrhHOqOM7hNvPGN3NjhjPv6LLn0cABxESBGqyc2lBeWEzY
 GajeWwchbuSvWdthNodUsFIMaPhVBb6sAlE1/r/zE9xpqV4qdcDz9ChnACTSCpE3jJFCK18ZHuJ
 4FBe1T5E132LKtPG5j4BjhvW26o0VBsRPFNckO89ssl+4Ug0aSoXoMAl3qVddGiMJGdk6WyDfUU
 ds0z+P3WGWJRmelPlzqU2IJGhyx+QBrAZMFcs/SLEjyypN9X9bhCo5lwJf50ValLYZdxyQcOd+5
 lo3JMio4hk8n6OBAYE6brqTUwBlqMcFnwiO4I/2+xVZj/b/3SAG5mbwQvVOWNky5aw64qvEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
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

> > Subject: [PATCH] doc: add limitation in using segment-sz in crypto-perf
> >
> > When segment-sz is given as parameter,
> > use buffer-sz in descending order.
> > The reason is, same scatter gather buffer list is being used for all pa=
cket sizes
> > which is initialized once in the beginning.
> > Now if a small packet case is run first, mbuf SG list will be trimmed t=
o a smaller
> > number of SG and rest of the SGs are lost resulting in segfault.
> > Buffers cannot be re-initialized as that will come in datapath and will=
 be costly.
> > So to workaround this, if segment-sz is passed as argument, use values =
in
> > buffer-sz in descending order.
> >
> > Signed-off-by: Akhil Goyal <gakhil@marvell.com>
>=20
> Acked-by: Anoob Joseph <anoobj@marvell.com>

Applied to dpdk-next-crypto
