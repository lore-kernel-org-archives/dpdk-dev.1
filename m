Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EA3CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 09:50:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BD7C40E17;
	Thu, 16 Oct 2025 11:50:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E7EF040BA6
 for <dev@dpdk.org>; Thu, 16 Oct 2025 11:50:47 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FNT8Mu007753;
 Thu, 16 Oct 2025 02:50:47 -0700
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022098.outbound.protection.outlook.com [52.101.43.98])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49tnars473-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 02:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfYzujFZtHt6vsr0ULu75a1+zrzxdC7WFb+3XU23f6V8K1Yw+thDbOrWkgTJqn4maxG2ewZxut2iczbMIrdBOrUGEM0CsfqL82afjDznp1SiSICrB73vbyhgH7HUxh2Y3J6FNwUERt+oEYPWJby6Ex46YK9ApNwTceSNBcMyjI12HpQyb8FQvP0r2maSuEIpmxf86a+l3obKwZ/8PbZRcIqElCDKIdGXiEDb/bOmXiZZ24Fry1fDXnvFozxmJGCQ/7ACnI7Piu5xNjW0PKDRiQhwQxud8BUxhcor8OaoJeaMxyzbWmycG4FhcW3mxKgrwgsRCnkv6bcKhP3Kh37caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m3gh0TxioL1VrCaAqmauTmoP3fPW/IMClEo+4GaQ2s=;
 b=DVfeE/k3yoThD+6N6psdTXUGUVpzZpkfvGknsP/HPvqhoCjXntgHWr42B1+V0EN9JSM5aKmOAc7/IqV6r3fNndFvE8dkBdcfQIolelwQzEV8UQ/ud2oYwUKTQStH4017Qr4wPDj7azoYjqbHEmH8LKBMmyByp2nZPJTsHS/8GcNk9hwmWvd+Y3XTJAQM58ZFJ04mQDURAR+lzvL060dgAj3F0EsvymCdl+wkPn8EHMvmDT94HwZ0aebWqJOQKAJb68uLfSdFaFtw1lSUkOtt1QahfejUcqtUZsV0Q2YwMXhRIP7UV7/3Fgx52eZT7OUolWF1MYPCJa3iraCxXo+wCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m3gh0TxioL1VrCaAqmauTmoP3fPW/IMClEo+4GaQ2s=;
 b=Xpf7SYJvpZ3okxpnzaKVIOLbn/SpOduOZd2wHHnk5Q7zF3RDNe1F4iaxQnJnn40YOjVESfuvCRGLhGLhFJcjyMOwAUZ0QKE3U9QNTcsETqFAHUK7gxRnwZZQjr7O9PN+5fsz57+KOlRYAc9ORTlD5bazdpiBcTxQ4pM+py74wEs=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 PH7PR18MB5177.namprd18.prod.outlook.com (2603:10b6:510:156::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Thu, 16 Oct 2025 09:50:43 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 09:50:43 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH] dmadev: replace zero length array
Thread-Topic: [PATCH] dmadev: replace zero length array
Thread-Index: AQHcPoH0sHP/3jB1ykGdl7v/f6Uu5LTEh2NP
Date: Thu, 16 Oct 2025 09:50:43 +0000
Message-ID: <PH0PR18MB4086321DB97D825FF9E44D86DEE9A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20251015185946.338417-1-stephen@networkplumber.org>
 <aPCpiEAYt6YM4-Ai@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654D4@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654D4@smartserver.smartshare.dk>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|PH7PR18MB5177:EE_
x-ms-office365-filtering-correlation-id: 2c3292f6-d568-41ba-66b1-08de0c997955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?O2NkCGrvOdNpDyAxLyVWH96gt4CwPd+5bnfaiG85+nFnYFiFaR4IXYNybU?=
 =?iso-8859-1?Q?T2ZinY4n70iRJLySfWt0noRbB8cuRu6ECnf/h+37HYkLV9yuqcfvOrGabf?=
 =?iso-8859-1?Q?BNFXTzeq7r8GF5NzMRKxDF0OEUkQ4AfIgnN5Gh+3xsk4i3gRuwVV3pPZOt?=
 =?iso-8859-1?Q?Cq4hF69Q3kujPWkg8C1XhKOjojZ9Y0++HxZZHlFZ5jJAyRXpV8tIej45gW?=
 =?iso-8859-1?Q?ss+o3lSB1kOCfcK1XS1dsKX9mS1+pLWfR0fDIv52oPeUVcrnbWC+tFMo1n?=
 =?iso-8859-1?Q?gS8WU4n42Mjpl051etPiLJ4DAzJabNVAQghLPOR1qVV/nObMPiBNPaB3lY?=
 =?iso-8859-1?Q?++IbACzg/+f+VYwTaId2nT0l1AfxExAaXRI7JmM0tBtoKnGQeA+PSCSYBm?=
 =?iso-8859-1?Q?/rOBjpJZHcO/xozKmmpP2XFdyRhqT5BP2fz6NPMpdwRRgE/rDbOqeIXJl9?=
 =?iso-8859-1?Q?IEX78b5eUT22P3nv3of5jROTfJplojSnSksMlv5MmEzOYBeN4yskAOG4Gs?=
 =?iso-8859-1?Q?wZHQ9ZhuCgIGppE1Nwhmjj3iEKmeAf1U2UzCsL0hYUORAgMnBgtBotMaxJ?=
 =?iso-8859-1?Q?ItwMyLyq0CiBV/0w5ngdDJesuzx1320rsgQ9Mwifkw5hlTZScqaFCUuHCU?=
 =?iso-8859-1?Q?G01aDvY719ayk1YwZBjQR3jNq4RxGLALhMq9EvhcwYMT56PmKO4VQDS0cR?=
 =?iso-8859-1?Q?IGmSTYlfW7dOqwPCw/R7lAAU5B6O8METl6MR5LpSArZ15hw4CV1KXkGyyB?=
 =?iso-8859-1?Q?GqzczUzxaUlnTPI0VEAO1dPglbKbP8cj1scZrYJJvrSywDEIGPSwvKmQ45?=
 =?iso-8859-1?Q?aTKcKjbIpfJLMHdf7dgKcxYapymQVNzsD0ONgtrvf+BCp2zlVGZG3MI27o?=
 =?iso-8859-1?Q?XOEvskqB3SyyFQ1sL2BbbHtLx6RHNMD2MkQnWT/JUGxw+jY1wXtHBda1vt?=
 =?iso-8859-1?Q?OWgNHhZcNwAheU8J2tna/jf11S+x3cBQzomNErf6qiQouax6nTCmSbLA4b?=
 =?iso-8859-1?Q?WZeK2pv/9O1trdSVwlee+oaXO2gmmehonOrqM36si1Eb5SPyWS8OhObVEY?=
 =?iso-8859-1?Q?bE+sK6IehgFPp++X56+TnGl0AganIgCE7jWzAtAL2+6iVCaxNEtXZqeLfu?=
 =?iso-8859-1?Q?eyO/sU4PKZHJ0SIhZqjmFSSBri2oIIAsklFWCUZ5NQX9m3RahVamrgzYLE?=
 =?iso-8859-1?Q?NMyNB3vrF/qvspRxw1WTeEVs2NyNdJfOJRN1imlCnJRVpmZgFaPUi1ecAU?=
 =?iso-8859-1?Q?p2vHoVcKRCjXo210SkgPWCTm+fzGDIYz88v8ncnR/OYzDDrx5VmRnG3uk7?=
 =?iso-8859-1?Q?DZl7HIRcWMmZ6BA6RJb4acj62aDo2yeCYsUlLr7Q8BjakB8l1UveWFKYGx?=
 =?iso-8859-1?Q?xsCmmLeQKYRj0C3KrJZTiC+DBXJl/fVWZaSBVdp9/i312MhxkPXhxm3E3a?=
 =?iso-8859-1?Q?7uFq0+D1bjdLHySKH1tsbgl8s+yVG6kTt0sE9shH7AReeJAHWgrue5UTHb?=
 =?iso-8859-1?Q?GwScg4XIbCIzJdDz0Acrkym714fsjN3KAIU5SW+mBeNuz0L47tHRnATrPN?=
 =?iso-8859-1?Q?SJVLFZ8XB4Ff5PeHUNUFl+BXjBRo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yYVUAQFU5yrIBwlVMFjKoUS8sYWxxnfP5YO5vInf47oRynBm4na49G1LgJ?=
 =?iso-8859-1?Q?EBOoi97BuyXiESmIqu3tD5yk4oQvxCiQF9Q+6mcfcRJCbftOTmi2H8BEB2?=
 =?iso-8859-1?Q?T3MEUb6DLAL043aXbVUpaQkSEoB3cWqNAo9sYE0wFCuqbzIG4ZSFMdhfmo?=
 =?iso-8859-1?Q?KfnbMHc67Il5n9QXb/uHdhSpmJD1FM259Lpe2nMwU1cUwDgVoSngbVKqND?=
 =?iso-8859-1?Q?gEhrr1ghRFSV1dmA4n7HzVQKQH+L4atgJRcJtrmSSyv32D223W+x8c29rP?=
 =?iso-8859-1?Q?XiwETCeIR97ZSi+hDK88rdh+/nI08VB38xMwiBRI3bv9Xp6Saa7qtxdE8p?=
 =?iso-8859-1?Q?PYZxcxJ8QXngnthnizrdMiD0qE4++t3D9AI46LVOe/f6LqUTz3DWfm28Qj?=
 =?iso-8859-1?Q?P1yQJLzJJnUAep9A426RlS7NdR2AxgrEwiQU+nLhRQlIlkwrOMF3B2K2qO?=
 =?iso-8859-1?Q?mD2izQUZ58lmY4phMaKfJLpRu8lHVw/5rU/+PlPFDpCmt3JTVlg5zL8any?=
 =?iso-8859-1?Q?DkZHeNEZeztX12QuqHg/AMLzctEiVlvPQne+Du05DQBxs6vdAq5IoGfYR/?=
 =?iso-8859-1?Q?1b6/h2D5OGdL29vqxOpXTa6HGqUkW78ut0K+iEp2dd3zll1GK9YcNFl7S1?=
 =?iso-8859-1?Q?qjwqoGE8kYglYh/9WuhI6ZQn3eUfT06zbfWvormrtzD9QfbWDvRnIVfmz9?=
 =?iso-8859-1?Q?bUYjF0Jlq6k/r36CYqfrApNe5odMpzZ/c47FEgz0+iD5N6o3ervoKeA3CM?=
 =?iso-8859-1?Q?PO5SmtHS+/UTSAnmiLKMILtfZ3W6t+xRUfg9BZGAd8SwTYI4aRUvuI1KlS?=
 =?iso-8859-1?Q?qZT02TvbgjaapajauIWGhsCoanhmR+XF+f98XMNFb+PTFvvvisPcrF9IBo?=
 =?iso-8859-1?Q?jUJhjlHnhlorEpW1AYJDvRzkKqdCS10MKoTOELSiYK50/0vlWY1/zawvHO?=
 =?iso-8859-1?Q?ZJcJ+5mdXFuUEhwXKAIkzzq1dJhzmXupTM4jT2tvdgYJKiGlB/vqkB5DP2?=
 =?iso-8859-1?Q?7zaY78e1mo36Xljj+4lYkYFkhb/1k0TSBJRhYP2H5l7NOxF0BdhPtrzXeA?=
 =?iso-8859-1?Q?TvOixq7hpt4/g1d+UdCKZ7GtlLRUmhMEXs3WwEYdF4vhoCSaFUZXyc6dWQ?=
 =?iso-8859-1?Q?kHGgd+GKywzODHSU8PGfVc8kGsQ2DIy2YsgvhissN01KsscwCgtuNCvBWk?=
 =?iso-8859-1?Q?+WWPc2ZrGupSgdL7S+GNyWGraMHcWWU1ijqj8xsDr9rPHvOtfFQhSUgvJB?=
 =?iso-8859-1?Q?EEtzdfEFSAZOHMX7w1aokXpEugFM9jOCSuFl/moJovCRazS4ab96vTJo+G?=
 =?iso-8859-1?Q?K2D6yw2gEV5Pq9+8QzAo6fQCVghznRYDehE5ZWDV/8phgwuHc2YNzMxQuT?=
 =?iso-8859-1?Q?q2HKoUsUx0ZhvlCoQ9/TeYv+fTBIL+MOQhOLibH3oJvzAQJCr+jkCsjtIg?=
 =?iso-8859-1?Q?n5SlgcGQAxqhpQld7bijlawckvYz+hNjHsMxWLM8yoPvcuTf+qP1vSyblM?=
 =?iso-8859-1?Q?SD/IZWEQ/kLYMphCP9yPCLzyBnIjvRG6qMIqnVaOFfPdekQxweB1YFkbQ8?=
 =?iso-8859-1?Q?g7p72k4N+odmcsVexJH83FTEgW/8vnkFuTJZeN7JzQF5zYa+OkXKNPAGcv?=
 =?iso-8859-1?Q?EVMugtUyuvsFGxnUtAxLfxWQepY6t/EO10?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3292f6-d568-41ba-66b1-08de0c997955
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 09:50:43.7749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxEm/nFIzGj+GtzYcXQjIAu98bNkI1/zmsm8172iu+Dnspbj3MHLhPTGGot7t/uKCkojFyqx/30+iIpYD0ExGlylx1yd5jvGrKY/5PvTLwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5177
X-Authority-Analysis: v=2.4 cv=Qbdrf8bv c=1 sm=1 tr=0 ts=68f0bff6 cx=c_pps
 a=52G9BLf6iDL1HAe0xuko4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=jZVsG21pAAAA:8 a=n02bokGJAAAA:8
 a=AvEYAwks14VqkTX-Dn0A:9 a=lqcHg5cX4UMA:10 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=rszdq1ld3peujIA30KyE:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: NPs3-TMB6cj9gLuKLuvFhr6neWhkNae4
X-Proofpoint-ORIG-GUID: NPs3-TMB6cj9gLuKLuvFhr6neWhkNae4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDE4MCBTYWx0ZWRfXzpMmEEQSKAhc
 NceE53bmKDmPEQYZspTprI6Lr/hgamXJAmRfNlMGaRT/CYo9YIVa1NhEqPeR9fFgg43eq9q4JO6
 dh0NyOmmOsPGLT8zkRJeo+9IWiAUZvj7Qn+w0MdL5OObmASpF5gtgMSnWTn0fXiG923h47CFcJn
 bBYjx5f6mlOstnbCqAorpI2f8JOVoemMPRxWZMh3Sb1QscBnsV/u8QNoSvE85n7kO93BZGoiZ0D
 0wKIeiZ5vSrdQVWWcqf7kdP/M/Prm9bFps9ty5Rd4TxTo1MRtX/xBqbRzFFbAOLfkC6hEhFdumO
 fDT7B7mrtS1/0w8VEMg18xELko0aE/dxnMe0OMG8gHhWjDBhEAo9BymA5BJkpe2gXywvug2wR+4
 J4TUb6wMfT7kNLEoheJUv4LRBb/q/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
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

>> From: Bruce Richardson [mailto:bruce.richardson@intel.com]=0A=
>> Sent: Thursday, 16 October 2025 10.15=0A=
>>=0A=
>> On Wed, Oct 15, 2025 at 11:59:46AM -0700, Stephen Hemminger wrote:=0A=
>> > Use of zero length arrays is Gcc extension.=0A=
>> > Found by zero_length_array.cocci.=0A=
>> >=0A=
>> > Fixes: 9674119fbf27 ("dmadev: add enqueue/dequeue operations")=0A=
>> > Cc: pbhagavatula@marvell.com=0A=
>> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>=0A=
>> > ---=0A=
>> >  lib/dmadev/rte_dmadev.h | 2 +-=0A=
>> >  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>> >=0A=
>> > diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h=0A=
>> > index 30e168825e..8ae9ee031b 100644=0A=
>> > --- a/lib/dmadev/rte_dmadev.h=0A=
>> > +++ b/lib/dmadev/rte_dmadev.h=0A=
>> > @@ -856,7 +856,7 @@ struct rte_dma_op {=0A=
>> >     /** Number of destination segments. */=0A=
>> >     uint16_t nb_dst;=0A=
>> >     /** Source and destination segments. */=0A=
>> > -   struct rte_dma_sge src_dst_seg[0];=0A=
>> > +   struct rte_dma_sge src_dst_seg[];=0A=
>> >  };=0A=
>> >=0A=
>> Acked-by: Bruce Richardson <bruce.richardson@intel.com>=0A=
>Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>=0A=
=0A=
Thanks Stephan,=0A=
=0A=
Acked-by: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>=0A=
=0A=
We should probably add this check to CI.=0A=
