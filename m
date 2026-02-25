Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9F5EFD204
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 386DB4021E;
	Wed, 25 Feb 2026 09:01:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 54FA1400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 09:01:23 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61P1ORwi3894768; Wed, 25 Feb 2026 00:01:22 -0800
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022085.outbound.protection.outlook.com
 [40.107.200.85])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chqcyrp53-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 00:01:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGWXLMsIwm47NVXY4g/x7oy8HHJA9d6HSmjAXHNWYLIMMZVgBTSposrUuvLCynFyFAbtiTCfvI0knY/i/feupXsmYmbU6e+MsEzzrlchj/4EoJiX4wgbTJl5LJb8YGm1rC61mnpN3XWscAjND6tJ1tfhvnIVxakyIQm57hIQC3vocIJO1FCf3PqTEgrbHWdtl7Mvzy+T7Lzl8POfMP8LfPA/cTozilMhC19BamDikxCymm6JqTGTjy+Y7i0w0f4Ttn7po4xUHHFLYh81sw7rG4dNUTUsGhJZrco7i1E6177zC+1akgi7aEwATrWA9j2iR532oqURMzDkYoXjDuOm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWqFM/otXCFOyN3SQd7hcBOKvmZLRVB/LXVNsy6rJYs=;
 b=e4hbOyyZ4jS0bPn92IvW9L6byYZfIF0IiW2d3bXJB/zc6yfzUJ2cZeH+DtunCz/Xfd6WHW8WFwI+k8jbYvnlxHs4R9PZ4tFaaqu4q7pJhTx0UuaVtpRkUb56iDoC3UPJnRftXV4zTTJVAQKvTPy7bcHUtZrXk7ziUi5JX/5XuvfKmnFUe2CwtezDNPAEDhLsc8vvkLeEHDhe2Go2T7HxmpLtnq3AXNMeRpGs+Tt7v+ZKJjMratLEP8cNYKYrt6LnFD0WCWp0+ZHDCKq2nk4Nd9MUtK3HxxZr2FRAqwNEKITgUMEc61fmUv42VS2383J5RyKNldFmF3QNxp+p1Ae/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWqFM/otXCFOyN3SQd7hcBOKvmZLRVB/LXVNsy6rJYs=;
 b=O6AOiwdj5uRkTeEB/b5v60TYEA9zDQMhB1/66bZ+ZeXEd4WGFZKw9kwWRCa4KMudupMSdaj10O0Y/jF2ZA62IpJIeSyg4qRKA0egiSK+IXwXAcn6jqEsecmexObSR7TmnU2QFRr+ZNpRAf/ZZAGSwHpIVE+CO1cfE8EtQ+k+cFw=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 DM6PR18MB3537.namprd18.prod.outlook.com (2603:10b6:5:2a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 08:01:20 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9632.015; Wed, 25 Feb 2026
 08:01:19 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 Kokkilagadda <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: Re: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Thread-Topic: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Thread-Index: AQHcpc1jpvvtk8CaqEm1+ZmUQ/c2TrWTDb6z
Date: Wed, 25 Feb 2026 08:01:19 +0000
Message-ID: <PH0PR18MB4086434B58662DA7BF5F5F00DE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260224203709.27696-1-stephen@networkplumber.org>
In-Reply-To: <20260224203709.27696-1-stephen@networkplumber.org>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|DM6PR18MB3537:EE_
x-ms-office365-filtering-correlation-id: b15df381-1710-4197-1036-08de74440f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sCoCN7vUysJqZfsP3E2bMKYodIDVHUTM0iIRB5DY8HtqDfM3PV86UHC6kT?=
 =?iso-8859-1?Q?5lq1EBnEnMjbH6/HysK04IX+SUry8TzgFx41UT1CGcAvnQS1ehuj4Xx9Vn?=
 =?iso-8859-1?Q?xDn2BYoF3owJszwNnAo/oF8X5VVNX1qLz/JcKxzhGkqAUcaOXa0I1z6533?=
 =?iso-8859-1?Q?AOy3KKuhH206VPgVSAUdojIsbdbv+kvBbkOkBhOZYOGGdkX5oW34KCrm4x?=
 =?iso-8859-1?Q?9AIGAR1L6KethigK67oO4VJ72gEW49KOcfeQPP6CjRQumsFehvq6szbrYV?=
 =?iso-8859-1?Q?zuBing+cPdddC+ssiTKcC7DnRYueEiNcR63U1Od3hXDzAogILjAWM/ZaJt?=
 =?iso-8859-1?Q?IBNdfQf0lBWw4sawOlByBv/JQzD8qoRwnPFz0Wm26YLmthBMOd5MGkmAm/?=
 =?iso-8859-1?Q?VMeKPQOBcDipisWCU7o61OsZ7kr6t5QaACfbSCeWbhfmN0y2EoRBGOIRie?=
 =?iso-8859-1?Q?uPtoiGXPWMj4u/dTy33KOAT0/QhA6+3X5V/Q8BSY3ikKVLHb3i0diGspIC?=
 =?iso-8859-1?Q?LfzcUrN0EVFDpEB44PmRooPuKCohvcMYlZxMUgFnxvPJKTBAqE+5qdxVhb?=
 =?iso-8859-1?Q?3SQrPCIELrLjwFjiLsqI4sEnoKkB2TATbuvwSE8HgFm7fosGP3AQyStA5v?=
 =?iso-8859-1?Q?0GGDi/oDLXBXY/ypDcxFU9h4dZv7clLLMtGbKjM/K1Q48AZfGn5E9unWTo?=
 =?iso-8859-1?Q?YqEZ0jX+AUwg6u3FpA+9/OZN+LEUccJYDBiYi+/SB3zMPD7atmUk/9bbAp?=
 =?iso-8859-1?Q?mNEYdRqQC6ugUAD4DqWHrP3NJldPCMnmjjMW1hpKbl2M/y1oqGFC9pJENe?=
 =?iso-8859-1?Q?7oLF/OKR/QPPLJLaySTean25Oh/lsnDcGpKWymgFYxUsTPovvb0/9qDkNg?=
 =?iso-8859-1?Q?l5YRD1jbyztG3ywYahApuY+/gm2gLVQz/J9b69aBX5/7EzCGd658Ggi7KG?=
 =?iso-8859-1?Q?hQM9mmdkHfcW0ClZgipWlo/niQkYHFXiwxu+Bs94rIqOKFAw2bZdJYpytm?=
 =?iso-8859-1?Q?UuSuNyYU/wS5n9vD7znCWpl3NMjYT3TVD9QPTAbwkV+DFDz9q7bTcSlj1u?=
 =?iso-8859-1?Q?4MIPhaksREWgMeCJgDATeceoi8gSslm8/XjE7JkLCvmXJ1rWzTEXX4Y9e7?=
 =?iso-8859-1?Q?/h69dNHICdlI6cmofE6RREgTQE+EHV6kqNm3UonA/kDCXX/Y9oNxHTIFsw?=
 =?iso-8859-1?Q?E94OZudtQIf3a1CZEUEUXD2aVkIlJEdjkVFlpGIHWG8rkoIG0s56gLXr5W?=
 =?iso-8859-1?Q?Fq3jll7LILhEKQq/jPCmlgJxuxQ2iH/+WyDrP1ODGA7eH0Om9oinA7lMPb?=
 =?iso-8859-1?Q?tOBjTDgCxgHO2G32sfxCOyX8tJAtkZxgxZs4iccDMTC/uICFf9g0iXceXg?=
 =?iso-8859-1?Q?xu6xAKPI2l7Z5GJ3HDH0dQJtWM06AiqLVGe1E2jWWzglE4Q/j4HZ3oHnjx?=
 =?iso-8859-1?Q?iOqS35AnT1mGHqDdLjbSqWudUKA0EILjF3aUfVVEQnxbKy967KUf+MQJO5?=
 =?iso-8859-1?Q?GnJwwDtMrkxCzd1/4rhtxsl2Yoq3QrltqDgUEUxreKgwV620wB2th2fauc?=
 =?iso-8859-1?Q?rgTzpbx03yJ78S41K4fNxP0jk6vsowNvlVV2Bm9DV/CmsAsg5nh+bWxEYN?=
 =?iso-8859-1?Q?K33RW8e4eiQd4X7hSGNATBi/IYarexK+V3ioEz9EyaPTWu4gsmdQcbLmtX?=
 =?iso-8859-1?Q?5lPf90W6XqT++yWzgak=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mw0ZcZ9BiqdM7XkHYtWOlwB4VGsh4t0sudIwg14YWw+iadSwZGAlnptiBy?=
 =?iso-8859-1?Q?bo04rlFspe0a0wpRUS2UY742fkYmhyYpNaPaJtpOcpFufd9cosYFNIrlew?=
 =?iso-8859-1?Q?p6obF3GWQpAaXLW91iVpL4gYiarZddAyaeo3+xKlmqd5Cx1iMUcDywoS7E?=
 =?iso-8859-1?Q?lK1/yEbGmd1/0376U/+Alcy4ek51JwpRlk0zB11fRR4zS1AzqUvrcxR+ip?=
 =?iso-8859-1?Q?/b/RqHfy7JvM+v8qVuP6V23o9EKbvSI13YIMrOW5Sev2d0nQyZFofbqi78?=
 =?iso-8859-1?Q?A3ytrPuL/4WQkuiJXWJ62AS+7/f721tNEzRIdBJ/DCZhK6zgklStNCu99z?=
 =?iso-8859-1?Q?f+o2j+R1a2iuXB4WGf0G7Ulapyr1VlbrtePbI19/FGJ2ApegyxUB+HrkO1?=
 =?iso-8859-1?Q?o4B22BtY2T1MPXBOHHxI7ZkM44AJbPZy3FBTOZjiXXtk00AaeGRrw6d35r?=
 =?iso-8859-1?Q?aTC53xZ73lyBELfJKEVDGvzCrvjOd7tXavtO0UASf8ftjgo5G+m6m2zLmZ?=
 =?iso-8859-1?Q?Ly/PGftuU4Qb2qg0Fg0Xr81f2MOZyyaFuSoK1AD1U8BrSbb2xBpjJXsysY?=
 =?iso-8859-1?Q?K9vYTWRx71pbz7FvXqREB5w1ZFlUdVPia5P8R8DQrwGtd9VpNSJgt8M8sE?=
 =?iso-8859-1?Q?63wWjBrIZPECKJvpe/CciOX6chwio0zjhc1g42zMsJHHVkTuRo1onpwFXE?=
 =?iso-8859-1?Q?iO8TDuPB3fQURoyB9N5y6OgVqDANdxIms/8uoUvhOcUqu97X7nAyJSrKw8?=
 =?iso-8859-1?Q?cAnENo7U8VNg78eR3fppL0lxfNLtccGq67j54JRjO/dxBlf29r/dO7/KuF?=
 =?iso-8859-1?Q?UPAXLRxgUdfFS5Cz1Q3VeJhtaBm3hshNHr8wwvgfd49/e4A5wI9gH+gfup?=
 =?iso-8859-1?Q?MUtsv+6IT6vUAwROOgsk0q6qJHo8/ONakvZQFGSZhEuvgNsWqEPkrYmK3w?=
 =?iso-8859-1?Q?aiCtoGzY+o3f+O7Zoapoi8yefXVuBDanPC0MgeojmELtEPzCtkWSEHAwpK?=
 =?iso-8859-1?Q?wVbxxIKoyJSN/sgMSUeROf519cWrl0csjTJSWupK1OKWHx746reXSUVXQ7?=
 =?iso-8859-1?Q?PdIdm0D4ml7z54n5BRmLRKGOqWfsxYcVP2x0b2pBIoC+VBleFXplNQCVl+?=
 =?iso-8859-1?Q?ePlHeEk5EqxjpoaJ/xRg/oy5nhpOQhZ7w3tMRpcpgcsDWLZ0rLZ2Fhxjhw?=
 =?iso-8859-1?Q?e9EO+y3mX7RH+st6Rbh6Lg1kxvzH+5ZRxOusfoS9Ul8oDtlh40f3eJbuFM?=
 =?iso-8859-1?Q?srmwPXKjRv9TGC4oFpuzQ3qZBomii0tsL0aCL/JAGkTedelJzDyJETZvYS?=
 =?iso-8859-1?Q?GOpsilRDl3tAiPx2WWwf8lDk8S1pwaYRxpbkPs84CNPLxDJIaCOMyCu/8J?=
 =?iso-8859-1?Q?FfAghifR/s3lpvQpuh4/Rr/Ys8+xb4smTt5MI3gi0LPKt8qu87nOUilfcy?=
 =?iso-8859-1?Q?hDTuSly0AS78s45YPTD45DeTIVTh+67/GerTYDfdozgNY+HLS4GQhmJiJ/?=
 =?iso-8859-1?Q?GHcKTBhRPRbfoAVv5Y3mygV4oxIyN//n93YD8NiEbWIJdUugDP05TMHY6r?=
 =?iso-8859-1?Q?VcmXY5epWr1lMp2hoTkJrShJa9FO8vBUIIaJIAAMEpY4TdB+gTnoWqZasi?=
 =?iso-8859-1?Q?OkmYEWHqzDagHci1kie6bq4vJ0dnFFUeiMbLSdlfqEkXD7oZGCBay4tT5n?=
 =?iso-8859-1?Q?vsm5jEVQZoiA+OTdnd0ySLwP5puRcqe5qAnmzikQsct68UibLCj4Y+YzX4?=
 =?iso-8859-1?Q?m4iBQpuHg29yac6fqNxtfLJ2zfsnsRu4BVtavflp9FQEVuegEMEnY+9P7u?=
 =?iso-8859-1?Q?b+Osx4qmaQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15df381-1710-4197-1036-08de74440f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 08:01:19.8702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSiTa8vzfF5EiasG4oT0Y4qcGRvZ4l0HwJAcKPvqVNqhuNsGJsdg1BJhIInGNPPVVf86mS1NX++msLqoRxX9FWl4eqab8wfvQ86ogcO9EFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3537
X-Proofpoint-GUID: KKClIe1y-Ii_f8xd1wV2SSymbc1Ex_89
X-Proofpoint-ORIG-GUID: KKClIe1y-Ii_f8xd1wV2SSymbc1Ex_89
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA3NiBTYWx0ZWRfX0SBE4vTFb7BY
 S5zo3uv5bBWP2pLpsL1snWeHPBgRJTbLOvyuqTqP4zVz3O1Z8b+kqMh06GkgVLiT/YiDIzTn6gB
 UcoeS4MQe95sbxhFlE435hCmyuC8qEMPmeFp0YN7GBkyojhImxGQtTX48ykctUz24gXVTzzrJjt
 pU4GJnIuGj1FTiLJ67Y2uy1ymtoOB6annaA3EkwjZLSiAAKIssx27pPg5sYzlghY7YAudVf76Ca
 HkVn8GUn59xJtpauaVyOR0WlHEBJ6jIcJcy1SOB0+u6NtNf4hoTbaPkJqgDSjxXAqlBisCVcK6B
 9hJDKMsN0TK6546izg/SnOC3HWjGJhVXJmPjgPzHPrYCumD2uU0CvkawYMnMGJj7evNsvgc9SL+
 ysYw2twXrlza0jdo8IDvcbpwcqnzh+GoIMd74BL7H0lAq8LEp0buDX6XfsYiKjVCrCJWEu9OtB6
 +mZZSsL77LsqqRDGWNw==
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=699eac52 cx=c_pps
 a=jGG6JRppMrTRDPguzGMrcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=jZVsG21pAAAA:8
 a=tqVFVEjJBIdNH_iC7K0A:9 a=wPNLvfGTeEIA:10 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
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

>The generic build was building for all SOC types and that=0A=
>takes a long time (like 10 minutes). The driver should only be=0A=
>built if soc_type is set to one of the know values.=0A=
>=0A=
>Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>=0A=
>---=0A=
> drivers/net/cnxk/meson.build | 6 ++++--=0A=
> 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
>=0A=
>diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build=
=0A=
>index 53caa6c171..4a2f4e1a92 100644=0A=
>--- a/drivers/net/cnxk/meson.build=0A=
>+++ b/drivers/net/cnxk/meson.build=0A=
>@@ -14,8 +14,10 @@ else=0A=
>         soc_type =3D platform=0A=
> endif=0A=
>=0A=
>-if soc_type !=3D 'cn9k' and soc_type !=3D 'cn10k' and soc_type !=3D 'cn20=
k'=0A=
>-        soc_type =3D 'all'=0A=
>+if soc_type !=3D 'cn9k' and soc_type !=3D 'cn10k' and soc_type !=3D 'cn20=
k' and soc_type !=3D 'all'=0A=
>+        build =3D false=0A=
>+        reason =3D 'not supported on soc_type ' + soc_type=0A=
>+        subdir_done()=0A=
> endif=0A=
=0A=
Instead of disabling the build, we can just diable template functions when =
soc_type is 'all'=0A=
=0A=
diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.buil=
d=0A=
index 24b48d045f..00295246b6 100644=0A=
--- a/drivers/event/cnxk/meson.build=0A=
+++ b/drivers/event/cnxk/meson.build=0A=
@@ -36,6 +36,10 @@ if meson.version().version_compare('>=3D1.1.0')=0A=
         endif=0A=
 endif=0A=
 =0A=
+if soc_type =3D=3D 'all'=0A=
+    disable_template =3D true=0A=
+endif=0A=
+=0A=
 if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'=0A=
 sources +=3D files(=0A=
         'cn9k_eventdev.c',=0A=
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build=0A=
index 53caa6c171..9382491ae4 100644=0A=
--- a/drivers/net/cnxk/meson.build=0A=
+++ b/drivers/net/cnxk/meson.build=0A=
@@ -52,6 +52,11 @@ if meson.version().version_compare('>=3D1.1.0')=0A=
         endif=0A=
 endif=0A=
 =0A=
+if soc_type =3D=3D 'all'=0A=
+    disable_template =3D true=0A=
+endif=0A=
+=0A=
+=0A=
 if soc_type =3D=3D 'cn9k' or soc_type =3D=3D 'all'=0A=
 # CN9K=0A=
 sources +=3D files(=0A=
=0A=
=0A=
Thanks,=0A=
Pavan.=0A=
=0A=
>=0A=
> sources =3D files(=0A=
>--=0A=
>2.51.0=0A=
=0A=
=0A=
