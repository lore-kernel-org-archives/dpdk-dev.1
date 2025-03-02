Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54784C19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 20:27:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FC4140041;
	Sun,  2 Mar 2025 21:27:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A74994003C
 for <dev@dpdk.org>; Sun,  2 Mar 2025 21:27:15 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522KKf3R031439;
 Sun, 2 Mar 2025 12:27:14 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 454kvegs58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 12:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXo1RhKNne1HuRGh1zGvpRCeiRnvS3Q73OfOBgJLKD64fN2RqJ+4Yj2w2p/L7o7W6hs6olVCrQ87RR0Ps92jDqznW6w84IqDT9l7DDDLzMzMYM7Vtd5Aw55zbOCc4PkoSjU1zMoCbQtcgt+c0kG3A7EVApd+n+P1qCnfXEsKmtnnUFsdyERU4PtES8WG0tv7Jn35U/NsfNCx8D8km6Rxyzy1N/bstsPsANvFEvRHeYZnqNVdbTjujOiAld32eQQ0Lquw3uopRCQTwdBnj7VIfNq2qKmFuMEEjvtXCGz5VOc+cMJ/rIvFY9st6A/zIxtnt6mpD0TQyxmUu+vaqN3r4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arehU2u7hXwj+O5CnmLrk2JaXQT6V0Q+lbM4VCdrUkI=;
 b=WI/ECDxy9SS/53+EIEG6K99vYebD9EudZolF4mOrO14/dHUm8j+WguRlns+Qjv9qlnBLa5Pqk7vER4OG7/X//dWhY7o1tU01P2f19vXZc6O+a3wgxJIVxl1+kAO4D1nPgPGi+z3SjzmsXq/6k8Ji95qudpldhHlkaNHKIKMgcJyGe0dvyGQ93x7xM3axH3A66TuVFmFSPbE4PX+hPqkVn848ojidI01XzEI5MHRbaG/UUeBYLxhrTyT36J/yaVM8ynMRvmR76dE7vrKDOmUfl0NheqQL33UruUyOVykh5CP0aOaFsVs1qYbHVFKq5L8J4+DgJHyoELlCxmz/K9NdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arehU2u7hXwj+O5CnmLrk2JaXQT6V0Q+lbM4VCdrUkI=;
 b=chuf7v0TRsuWY67HOOVuYXb0pSbvEUlh2nD6AhpkX4RgfAvRJ6LHQmz9hJTeq+lwVFj/h0X+9zD7dyRf3uQ//FDsLCeToagT9n7xJ3viN4HIsmaKdjqbjyC6iu8HN3lcqKTpWLdaquLpFeNBRaRMnMHH63vi5bQsxwM8MIIPPZE=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5525.namprd18.prod.outlook.com (2603:10b6:8:17d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sun, 2 Mar 2025 20:27:12 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 20:27:12 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Radu Nicolau
 <radu.nicolau@intel.com>
CC: Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Thread-Topic: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Thread-Index: AQHbeWaaVRS8PkAGf0mPPLMvK4XAQ7Ngb/FQ
Date: Sun, 2 Mar 2025 20:27:12 +0000
Message-ID: <CO6PR18MB448465454D99773C13731427D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250207134545.63820-1-nkaithakadan@marvell.com>
In-Reply-To: <20250207134545.63820-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5525:EE_
x-ms-office365-filtering-correlation-id: f42c53cb-6043-4d1b-3b58-08dd59c89d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GOJNUFYXM0MNwKwpH78E7NkS+VPV0lSY6J3yjqrZmFqCUQyxXj7xHJE7MYdW?=
 =?us-ascii?Q?KPqkN+/JnV56B5nqfJ6wYjPnfi4XRVRlyXxyUppHgC7ROUtjTIkYhiNu4qlm?=
 =?us-ascii?Q?+IfaomAqh1DW03Eb7d2SMilHM2vhs+0RtpegM7YNKpQjvNuCHvLLtaHAYToy?=
 =?us-ascii?Q?K+HFNlmJ1OtIJxWhs9mlh6RziGmnHlhyEmAnci7z2k2DScavvB1Q2iHjvwcK?=
 =?us-ascii?Q?pmeaKF4qvFBTk09jjNtW572t1SzTFkqnOgkaV/20D3keCtsmICD0sUx5RCrl?=
 =?us-ascii?Q?LJzRpeGl6vAJEHLTMA7Sa/4DKTvIyLuGYzGL7ZJtcq4w2jMZPyDKTv4Y2SnX?=
 =?us-ascii?Q?OQzVlC7rjQ9wUFYj/yRq+fV0KGMdGf68nexUQha2VN9BzT5ozqRDaw7oKQcD?=
 =?us-ascii?Q?j/umEeOYuV1zcw2L1AuU2d34Nb7ALRfmgUAXhS16+Tt+eu9yuN8qWNJUEb4v?=
 =?us-ascii?Q?RsJ34hCxHjAbFTblmzUDWd23PVWzVdAjfJri82WfoftJGPkbotD+v+qEDdiM?=
 =?us-ascii?Q?jO4zIGPp/smSZcbwn9jVopy1ru1Vx5oVQ8qFiGsu5UUByClolrO2YTUUwFVr?=
 =?us-ascii?Q?lG09Tr2cFnpJMFgKE9uWzScaN+50oaa3zJzzoYFYo9iS+R4u13CAI6XjQNI+?=
 =?us-ascii?Q?JfHGWa01zE8v2aa90OItAjR4m263Hifa7BU5tNSfmGWVDzJ6szUUeNlpILUJ?=
 =?us-ascii?Q?sFjZj+rpH+e+6nVfswe8iLzc+Yu7CkFqLshvBsqWMxJ6NBzWQ3enjpB7I0ca?=
 =?us-ascii?Q?XoLfxh5JrtsjrjkfzeVAim9mGv7PR56bS5R9cxDmJ1YAnC8VejZU+oOlwY4G?=
 =?us-ascii?Q?17Puim7cljfVw1puMuekhD57ELaS14dpkXYp5OGHrSStg86mNVSLodjJ7E3m?=
 =?us-ascii?Q?/43KE4d1b/WHgpnvuFAELcBetVIbdGUoZQ8Iihu8kShYgOIWT2rppsIOWbxk?=
 =?us-ascii?Q?8hJ0919sw6oeJ0Vm5pizB7QZWJPHPlNfZYd5Lcq+n2INotgoKT5FBGyOzb1J?=
 =?us-ascii?Q?2UeqREgVDBagyX+juiMYtW6oXSoD8jlvkCJQ8XNoOB2MQJaX9r+D64xpAEAT?=
 =?us-ascii?Q?5x5MHt91fqnV+yiWf/1Oalrdia8BjcOP0Ump2X8RHNzPfUl5cTNjIDknRXUs?=
 =?us-ascii?Q?G12RL1MEpl4Lbs4+jxVEaBpnehbex/6SwpR7PIEvheX4AvN5U9+s98/L/HGn?=
 =?us-ascii?Q?Hkeow0y8R6rXFph1Ac75MP7dR1cpWdMDCmfwIKTF8rOqcOkBELKs6tsEoLZ+?=
 =?us-ascii?Q?FHbJGQL8NlXDeX+Plgys7q3CzEa26/cp73OT/VR+UvGXaD7IYR1WkYGGWIBJ?=
 =?us-ascii?Q?d6RLzWJwXhvVDPCXfbcvIefrtVQESvL+h5Oe2Uo9fUS9OLU5rYSyO8yDM5X3?=
 =?us-ascii?Q?64s73+sS+d1u2jSAIWVCfJyWYa1pCsfEzbsZtc+rJ3F6PtO2iR8+b0/3OOlG?=
 =?us-ascii?Q?ToZmhxRIo98D6nPDrFA3OHtHz9bKCQxw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QQrPwOcEVj+bi/t3OW96nXpbgWH7agHUCvV8KtGl6byZ8vpntylNBVhuQDyf?=
 =?us-ascii?Q?WY+nJOACbf4V9sVZa81p2CKL+iF8Btnxe/neluw+ELBfUHwng23GvCQ9xBZ3?=
 =?us-ascii?Q?8uHNuupfGtPEMw4a7c94V3tjbe+c6Z713IykyEzOuzYBuHN7f8bUWBsSnpjH?=
 =?us-ascii?Q?lDYbQ/RJte0iGsuJ7lLfHatRss5PCHy/r8jmp6nwarPFi/X0lWbURbe7HLOl?=
 =?us-ascii?Q?Vug7oaSeF/qfk8TD2EuEmaWUlgw1Nn1MbTvhwif0BY8HMmMcS9qw9zD6QeJ3?=
 =?us-ascii?Q?FeIZ55/QiCAaaUY9ZoKLeA3Wi35MWTmWmMIzlxstCgD63in4j4EpB2FMnvb8?=
 =?us-ascii?Q?k+Ma5/ZF9rUcN7mwCucQPxL4n/naTg+j4d6RJiFHbPMexCtNrLbhnsYxwetN?=
 =?us-ascii?Q?gwXmKteEZ7jn0Egs9utGxGyG2lzd0/3pc2X1RFWdfgrz9C0sMqGZ+UT22MUK?=
 =?us-ascii?Q?/aoqauic1LOWc46XF6HgJrszg3BuvThEGdZ1UePh59rRbPBLfrxL3Y90THcB?=
 =?us-ascii?Q?l3vfGLX2QkkwavDKWbJGHYjtsaB8twFV4l01SWBnHN6EiqhALiTgLRlUfi6Y?=
 =?us-ascii?Q?835zxlg+nVgsiA3T/0l+CpV5BzMIOsB2mRUwszMwAmeEJdbJSO6Sr11RW3gl?=
 =?us-ascii?Q?Cv5QL+0voXWz70ZSY9BeVrbZJs3xPH+ras6IykkkQ0mw77MeEdqNPuh7t8D2?=
 =?us-ascii?Q?YLXCCdzQlG7pRrsGwjiEi1s262d5cbvXDaI70ikqwjJXriQLyBe++xN6hlTC?=
 =?us-ascii?Q?oNA79vVd069NtkBKdU2qrfZBQwXx/3mY18kQF3okRBKruH4KLNhk8j30p6lk?=
 =?us-ascii?Q?TWKN1/2sNexXEIzrVUDTIJmls6XlSyxl6hgx9Fz+wfM/rCr1xjmLyqyRt2Gt?=
 =?us-ascii?Q?VMDeasMmblYJPCQpmIco1asaYwewkXHbtd7otm477PKPVwjd+M6WoEDmiWct?=
 =?us-ascii?Q?7dmyDMOaRXviL9t3pCaxY9Sa6zIWHUIIfDnuxiGgYglT+eh//6yL0WZeddOE?=
 =?us-ascii?Q?qOlyMLKbzfBYRWVUhockYQA5A6a+FsaPRcq4rnsFBVOZFFJ5eL4dFQwh0HnD?=
 =?us-ascii?Q?PXkbZFCJERt8uBSUTalop7l5zqcoqZtQgKtC0HKl82aAjsN7Zvs4fzEGZ4Au?=
 =?us-ascii?Q?NDZ4gBukBYUi5HcBWx6Ck/UJ4J4EDJTwxTrHzINAr7BJKkhTYiDqmjIVfKk1?=
 =?us-ascii?Q?/9iUm1Z1jRI0KPl+XOeGZ9YdKSmsTVsP10k0mkKP12tqBTAdRJ1riYi9b/DI?=
 =?us-ascii?Q?9JHNoLpEDCNhVvAJiFMXBGXGgAdSX1QZf6H2FtOAM9eE3pQrAxygEJ3xLa9S?=
 =?us-ascii?Q?zeVON+iC9/hwt73PTuWPmHN7jREosg/nV4mHH99C8dKnqnncXDCW29gYMjp5?=
 =?us-ascii?Q?5sVxBBA+Z5HC//RpD6EiAtsAlAvBKLFBaMfS2AvBjpd8pgMlL0bz8DAsDLCj?=
 =?us-ascii?Q?BWbT1k2+KOBOazkJ+EkdYYsR1CN/EndEovcC0aZ9gtLK4FYbbDDXOteAIyJ+?=
 =?us-ascii?Q?QlgNgKQCRp1FfuV7ab8W1LRIzv/cwYVH27TA6opax8ymnSV+oDbCu0X+IocH?=
 =?us-ascii?Q?8Yiw40OjSTQXFM4wn9DeM3Wm7jJu1Dnayh1cOvOx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42c53cb-6043-4d1b-3b58-08dd59c89d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 20:27:12.4383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3YiPgd80Kk7g++z2ztPxMTlsJ+eGY6OeilaBhiRrJMCnN7l1oMyf8hDr/mJfs2Tk7lC45ER49FdT9CE0mpbqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5525
X-Proofpoint-GUID: PUnljfJ0l9t-XOhuTAdrk0-xpC4xIeG7
X-Authority-Analysis: v=2.4 cv=O73DvA9W c=1 sm=1 tr=0 ts=67c4bf22 cx=c_pps
 a=nskeBUqQUen4dZUz4TdP1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=PohDHrb18W-fSxSDGGcA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: PUnljfJ0l9t-XOhuTAdrk0-xpC4xIeG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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



> -----Original Message-----
> From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
> Sent: Friday, February 7, 2025 7:16 PM
> To: Radu Nicolau <radu.nicolau@intel.com>; Akhil Goyal <gakhil@marvell.co=
m>
> Cc: Anoob Joseph <anoobj@marvell.com>; Tejasree Kondoj
> <ktejasree@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; dev@dpdk.org
> Subject: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
>=20
> This patch fixes IV length to 8 in case of AES-CTR 192/256.
>=20
> Fixes: 9413c3901f31 ("examples/ipsec-secgw: support additional algorithms=
")
>=20
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Updated .mailmap
Applied to dpdk-next-crypto

