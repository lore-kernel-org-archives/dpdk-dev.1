Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED7EC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4412840C35;
	Tue, 24 Jun 2025 15:58:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CDB804026B;
 Tue, 24 Jun 2025 15:58:22 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OANBuO022682;
 Tue, 24 Jun 2025 06:58:22 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2103.outbound.protection.outlook.com [40.107.220.103])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47ft7h0c3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 06:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srnMBglcfJt3gyifSsHAFemRmNVlRSTe8MirdJAN4Jwu1KX2VHTIj3moZQmR3kIajHumhPGUmM+C4hTuWL1ADjXPhxt7kpru/yDh/ZryeqmLa96Tld8VfwgSGVYVXTIijK5A6E9q49dhJxNcGg4m4T6u3OzofYXd1QYMo585EYPdSlMaRqFiqhTj9C5FOZLkvh/BO0jEo/RdYuQ2eCw0omGNWwHPQ7tlPwl6TgHeX0zul+5+0t23WibI0WMQfl6mRVmLW0YFBnnhKca9FJM7m4MPIwHI1HVww9jLAEZKJVsvehPVvE8WFnDJI32Lsrbs7PJ2roQwjzuoP+U29ArQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/bHTjJ2smmuZU0F7iFjhnzku89ZSOJahwCeZzI6paE=;
 b=THNavHWUR5E23cr2kxVfORL6bq++96odECxjub5q1R27Xa57xAnZyXqDk3BrL02xLK+nSWjpQqNfkE0Rk0jn+5uwfbXL84B/uqY1daQpr8zT9CEDn94v/teA30TGmuxSNWRRvin/xtYxZt0xlyTMIByA9Y7dGJsUcrq5Bf61dvnkZX8bTjaw4hIvL1HxU3ttK8Un72Dexp5E8hMel8+eu6EvxHZ4GuDa5f6TBxFW8budsoRepuqVM+jQQ90baw7szg6q5zoZXSMz0XUYsq0kePlS8hCmFFj9SkfyD1THf0Bf4aaW4BMSgvhAMNdkim5luHSfhVhQ5WZCz8wbnpO36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/bHTjJ2smmuZU0F7iFjhnzku89ZSOJahwCeZzI6paE=;
 b=mn1zc+3Xm8exAAG/dbL0d6b5mFum1XQc4ZUxp29NGJeSlMErM5bLJl8nGGQ9dTkvF2VbU6gqycCo8GDWn156yw8on14GmNm58Y3RDsmx8dhILI1rjdgWqurW2eWoQnQkBHQyIzuq84UcupLkPip7xO2dCD7qbe16pI/ZBapMXBk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB6099.namprd18.prod.outlook.com (2603:10b6:408:231::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Tue, 24 Jun 2025 13:58:19 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:58:19 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
CC: Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, "fanzhang.oss@gmail.com"
 <fanzhang.oss@gmail.com>
Subject: RE: [PATCH 3/3] test/crypto: set ptr to null post crypto op free
Thread-Topic: [PATCH 3/3] test/crypto: set ptr to null post crypto op free
Thread-Index: AQHb4FAumiN+EPWza0OCHWWaXuQQPbQSX0lg
Date: Tue, 24 Jun 2025 13:58:19 +0000
Message-ID: <CO6PR18MB44840658E28ED45C855E302ED878A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250618125410.767919-1-nkaithakadan@marvell.com>
 <20250618125410.767919-4-nkaithakadan@marvell.com>
In-Reply-To: <20250618125410.767919-4-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB6099:EE_
x-ms-office365-filtering-correlation-id: e07a2a7e-478a-4977-20c0-08ddb3272ccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2JsZr71gL3KpADOIPTKAghojfXaxx2ImCZ8t7SXb9OusEaY7AV6m0I/xRliu?=
 =?us-ascii?Q?vg6r8hKA3pKKz867g5U0WoLfzqiOfK1Nmk2NG1xfmWeqqZkAoKS2d/9vQmV7?=
 =?us-ascii?Q?vw2zMvFgqQLEgPpr+SOnUe4rCLwZ6PkdlRkWSa1o2lJRuSCjEyMeoCvK80aa?=
 =?us-ascii?Q?ey5TPLZAGSGX/9hUTUutfdsw6eGVDYvS3KmoenbEnFpHF1jnwD2ataGGkvPi?=
 =?us-ascii?Q?Mo/IxECDZEkjDwGaPkoDm6yTnd6LaKH3DWuzdm/fKW/1NH6eGnq9KITSPi1D?=
 =?us-ascii?Q?swOqeSwJz/6O80FbfSexzL4ESbNUhvZdFW/mlSHFtCbN5VE8uHNF1VQs9mnn?=
 =?us-ascii?Q?Ckp+MtorFaseZGBQPM88QA29mMZSya07gNqD1bXROpAVW6LgJSCOkXFHoDWT?=
 =?us-ascii?Q?IinE4XLQqrwgXOjxPeQHlfM7AqPjAw/csGODxl96D85p04AIbNmCjSCVFZKy?=
 =?us-ascii?Q?6D86M0bsCkyQRy7WRVD7xHFl4o4Z8nUiPnVaG/yuZ7YWvnno+xGYU9J7CSt2?=
 =?us-ascii?Q?rE1RHph2NMIu54mofmwhF0NRY/TMfvAw8DsZxV0fEXbAX8e3m+ukZP4T0sK8?=
 =?us-ascii?Q?id1IHh3/iAR1PaPTKhvf3kE9HIF8Fdt/uN0nqcLjEKQpO1s++yOBysJQQkcg?=
 =?us-ascii?Q?vti/ISf3QoPTF8Edtzj2qsdUtEeysvvYbUiIKQAf45wxi2hpPs4k08rrSn6k?=
 =?us-ascii?Q?kU+LxxcoFwp+cjg/73oSvDwdUyPKMFrfL0Ci1W0X2Yw73k6djJQUiTH0Rcml?=
 =?us-ascii?Q?9RrdF9p/0OfwK2WW6aYpzBGBrEK5m+Da+5nJE8+GM7dRyE0HrQA7llUZrdL0?=
 =?us-ascii?Q?OTYYYSCa6OWetrswnsibkOIbREhYR5g9XrfCm8YCRHYvwdXzVg6w0Bhh4pzF?=
 =?us-ascii?Q?/bHLTpeIcrdj/RgQs0RgAaDyH2x7a0FLwBlxhE+3PO3llk7bVeMyLEDLRXT5?=
 =?us-ascii?Q?0KK40gXs4HPB+WAbqGMGoN70dFl7I4uZaMLM18MA/g/vOrC4+8oImowPmSUu?=
 =?us-ascii?Q?kYXoE99PM/mNJMc2ZZFkds1U+hBI6C3DCyIZW2Zs6MD+UdD/yfYTc0JvkiL3?=
 =?us-ascii?Q?qusmo6H/QZwzQ1tkmkZmdFVZgfMRUMNnapeFv/xAtZM/Z3+k4dLfSiFZ+BxS?=
 =?us-ascii?Q?afGRFhH0jaci0a8ksUjAYGTv3m7YVHomL9gebkgqNRpe7dC6j8kMky4PnMI3?=
 =?us-ascii?Q?z0U8E0FMuy+KYF7AcCCn0u840qKEEyG4f/v48EloXsW2/CNd2af7lVXntz+2?=
 =?us-ascii?Q?3c0zzxf/ybwZHR3o3H8X6qVQ8zEFtVqsx3yCiCcmxR2bdKBJt6D/TKB3X4W9?=
 =?us-ascii?Q?D3SQf82FpE0geEEDZ1qxKiv9xOwUdRW7EBELRlO+HjqeOscYVDd+unSKfKm5?=
 =?us-ascii?Q?Mlb9zqwNh5xRDgFByai1q5PUSz7l7FhstBC1OII/udtgNRER8E+5u1ORMphK?=
 =?us-ascii?Q?+F7/cYEI+CavGHXQRDhaICPAsoLz2sR/DxLpbaS7ZY0zHNsHaUUOoXldWeZT?=
 =?us-ascii?Q?PZq8o5StrFyvV7Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InWQ+AOgdhEuTYm2fFZZXpF9qa2Lgj6fsIU87saCtXCxVLeW0O+s9y7g9I1g?=
 =?us-ascii?Q?UDA6OPn8TwKUK48mGNUa3OGYzcWBbfghyup6V3tHnYQHkvEwKWy4oan/NoSs?=
 =?us-ascii?Q?pchXMUHVOaMUI1nplkmslZKwrqpilMgvEjkVcpCRFfhqDxWIwKyINQBL9qEj?=
 =?us-ascii?Q?d73nIEBUqMMwRgeqYAKqhdkPKAVqh5I5lbHD/uUgkoLOvJwCVuFu08Iay1u0?=
 =?us-ascii?Q?NI7i05j9LbqagRE7xqcHk4u8/lhfTM7IvOB7C7/UmonKLFJNzb4BcVKMzuhe?=
 =?us-ascii?Q?ErKexOhJmqgrnvxekc7Gk/5okBgGhTeaZ6zm609YViYD3NcRdf+4GZXHpTCP?=
 =?us-ascii?Q?QadLB+AcsXrNabn81XYfVtlmXXyPDRPrargTACnW40SHCZIzzV3ofrbZE5U0?=
 =?us-ascii?Q?QNKWMlePv8t6ie9+FmOfa+1Ih6rIUur9pLakqbW4UoexbJK7pbu6dn0cdOcj?=
 =?us-ascii?Q?UsE3wtzJIbu3gspPXIQ21noCSorV5gkdn5nXqKNVvV872Xze86UKbSHPypCe?=
 =?us-ascii?Q?aGEfVI1Ty0h4Ta/IaM5LslzjsBnYi6iiDpGRFMUqU6mlPLonbbKSLaR+/tPP?=
 =?us-ascii?Q?Ln6D8zqT8mq93MBMdMBgxdfue8FqsMNKXHTqbdux1U2czfSX6gAhHqXuTfZM?=
 =?us-ascii?Q?dck8uCcXvH4LAT55bjBiz5FvBocx7/Ay8UAez2Ne9lKCJ4zbQ8XkjfBBOsdn?=
 =?us-ascii?Q?ZCHRY0QuTLSRCaWn7eh8BvGsXFq8/EinOvT7AW3nceUhYhsUuxGgPJ0Am+5y?=
 =?us-ascii?Q?Ztc4EEYn5tfTwSEay5t6+haPBgL+U4hX3TljYRN39mSGMsqOjBnNMyxqpeBa?=
 =?us-ascii?Q?Tb4gzg0CfhBOmiehqyRaxQc+8Doyadf5rzjU38ndSuP5VXA6wxeIMDP0NUyB?=
 =?us-ascii?Q?/QOJdRheaoLcoeE875bIMxWzgzO3VppUVlzp7Fg0ejCqIfBpcukQ36U+3Oaa?=
 =?us-ascii?Q?F7vt46fQ/R5s/Q3mN3Ox8B1W3eYCzqLkFZ2hOwx4Z/CRXZzsbTDomOJDW5C3?=
 =?us-ascii?Q?qvnNiu2cVSoRPfexx3ryh1t9/L1HMn+BTRthjYTymGAOXVV7436WoSMTtDhy?=
 =?us-ascii?Q?YlCHeg1Sg8ubh8tw3/xGtOOC+5mm91DEc+pM0GTa80i+D2i1mF3e9lLgo3RM?=
 =?us-ascii?Q?CtKvwfXDGc6s3i5+MubIZZw7LFIJlbs1O15LCorhJ0oj2iN0r5C1z5YdQLA8?=
 =?us-ascii?Q?CCO5HU2vWoMIxvdR9Spe2Z8CY9ujJOYNVMUuSD2lmGbBbzsczIrjYpYtkJNd?=
 =?us-ascii?Q?0YpCuoTxjgftGPz61vgfLYZMyHNsqfTAlFAbn9vFhM8PYvBLLR+SkiLaScx9?=
 =?us-ascii?Q?rPRAP4EKylnytRCW/Kj9jm0Swjtqmy1ZAan/E6S1x4irJlvTGiZSBNEWbX9Y?=
 =?us-ascii?Q?Em9oT1jCMPpHqCpwt7dVJiW7iHSPisWhePppayqJ1Z1wbSxQuL42tkYOWqIq?=
 =?us-ascii?Q?8UPSTwu2ngwUxCGSPJ8OJPo8kRwUCCHJ+2vsOTg5AKzUiP+dPu5N3BO4brfW?=
 =?us-ascii?Q?ubo/CjZrcfOfwmZxkSnl5RcmnhcnzODg97x/IUTLJltiKoJnHvCPAHq4IZta?=
 =?us-ascii?Q?VKVQ1VlhZHUszjcn9ojDrptXSZAlqSfc50ePM+vJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07a2a7e-478a-4977-20c0-08ddb3272ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 13:58:19.3106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Le+/DIYVGGCikhq9KzIXbRYsINB7sBfdbKjZhmPPk0wRzbMEwsv5EAezIadBv/ZP7E+vSpjVcwTNzf6PSGdgEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6099
X-Proofpoint-GUID: xO8BPWaAN5E-_YeI4Bl0TykH8SZ4A6c_
X-Proofpoint-ORIG-GUID: xO8BPWaAN5E-_YeI4Bl0TykH8SZ4A6c_
X-Authority-Analysis: v=2.4 cv=Nr7Rc9dJ c=1 sm=1 tr=0 ts=685aaefd cx=c_pps
 a=qkvVI0a6NpPKroYfssW1Yg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=yn0K7mMhma4_TiNU2RUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExNyBTYWx0ZWRfX1zNN1MHiJl6a
 Ax5/jbiT+WCd0EmezONrXipVYD67cEF3/Kg9fCBjxfAZsvv//REdjTEmJnxcD5oDb85LPvJHDZT
 r3G8Wr27bVvNq/37o0roLz0NSs75Fy5+Cp5+MDbMkS2NqWmEJaz+eSJ4qAvT5aZe2YN374QJVj3
 93wMIBaJPY6pVbhbBuHBwAGEEaKPruYFrq0NQuMzaqTij2nX8m4XiWJq0IVZXji7C6BtU9buJOp
 7dTCcp8zRwDMRynXCPi4flZi5Ozb/9ueuVSD22VVg8srGZTnR/EyXhFZFzLI3zj6HsQjEhXo95Z
 G15yfv76ZNhkBHC7/9muXSjUtBXAquAAjF+xo09qxu1iQyAV/NT3QIXExZQ1g/J6NMPMtLjH+YV
 cH67hX9VHiAgIk4vWEC8qy0J9yME5VXgnXg7CmpMg79Y+/0m3YTjsyvWXGCWxUi1X+jpf5Ot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
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

Recheck-request: rebase=3Dmain, iol-compile-amd64-testing, iol-unit-amd64-t=
esting
