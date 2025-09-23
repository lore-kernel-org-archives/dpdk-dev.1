Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3CCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FD9D40615;
	Tue, 23 Sep 2025 16:48:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2A6E6402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:48:44 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N5LHCG023495;
 Tue, 23 Sep 2025 07:48:43 -0700
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020082.outbound.protection.outlook.com [52.101.56.82])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49bnags4wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 07:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0sIDwR67iOMcaeXucZysa+AnQX8GB4F5K6j8w0190DTA38Db0kH/5LE2evYQJ1AjIP9rjxd89s/O5xbNiHheymJAW4UNMjL/DYsj72tDOHwrZvJ5sp458jputA6+q89CsPopHSuF6/QbO9DvT83N1NB0Lc8NwYU6hJ9c9kfMc8esX/K/7cYNXx5l004awhgG13dH2OdvOAIo5f4nJltKialwY7sulMVEgfgGh9q8nSbigvjofsF/AB2+dTlpMqfdPIYFOE1PT7MyF142kakKx0G2DOD+Ru5ARjV5B+ODVRkP0TJgRjODPeMFdkwFx/g9RC+ZoIrOdnQ3q9xdb8TOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+RVDYWSlovUev9PuqRY0WdwRJO3ZKSfIfFE+ovgqso=;
 b=HZSZzcTAdAaKFid/1x4O6RSgGXt5qdud7eQLN9J82K6aJxCrPWM+2+L6ghpmHPbnvU4mOkxNNWNnHom5VzT06w2YCbL7d2/7hGmQy9vKB1I7DvX+Yy9l2mPQLE++9/U+RmfABU3Kg4ONnCF7bmveMBAhzqxOwzju5p79LvJ7cHCoMC2tEbwd4KvKUpUubx0Jhav39K+foCh3XFyKEv6p/gG7nRZXphd8AGcFTAkUYo8fHjSukgVhMLpLaHuyzz84RaqCDeQE2lp8raskyUe6XQorw/viECSpNrcwYVlqF8MvBQP02yN3li3Szo1wFihlYwjrJe3yvC4PydevviVw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+RVDYWSlovUev9PuqRY0WdwRJO3ZKSfIfFE+ovgqso=;
 b=MG0YCtjpv8VOLEk/RuhfsRcx92lxhxnfdDikmIRcQ1ftNPzh3aOm8czxX3PymL5V8HB/8Y4X423AGI8uyecLyt+EXt0RDJ0Os72UyI5m6KFX8uHjcv9jwSYJhdCsjoeaRgpF/d8oMmNQchcwEiEU6noO2bdVzg1T3UEOO+VRXa8=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 CH0PR18MB5418.namprd18.prod.outlook.com (2603:10b6:610:190::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 14:48:39 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 14:48:39 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, fengchengwen
 <fengchengwen@huawei.com>
CC: Jerin Jacob <jerinj@marvell.com>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, "g.singh@nxp.com" <g.singh@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Thread-Topic: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Thread-Index: AQHcJY0Ql0OU8ZwQvUa55jGKlVvicbSg5tXy
Date: Tue, 23 Sep 2025 14:48:39 +0000
Message-ID: <PH0PR18MB40864782009501565B46BAD8DE1DA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
 <aDQjDZowik8E7Jfh@bricha3-mobl1.ger.corp.intel.com>
 <PH0PR18MB408699863CC25944A04C2F18DE6BA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <PH0PR18MB4086AB67CD19C038A19472EBDE0AA@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB4086AB67CD19C038A19472EBDE0AA@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|CH0PR18MB5418:EE_
x-ms-office365-filtering-correlation-id: 510d11c0-73fb-484f-7fa2-08ddfab0485d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/GZrXABXQihqOZn/RBgzRKQr1AS/raFCA5X4zs9sCxCWULdtLo4js5AFtW?=
 =?iso-8859-1?Q?956XDvWPREQRkqYMQRklQKVu5+mIonfOXYu+NwoFB+CRb/WyKj4/+SUnYn?=
 =?iso-8859-1?Q?DnXSY6jlyAPR65Dj+VTo/Fr88Up08GJwJmHC84maDb8TSe9Wengh9WUQyF?=
 =?iso-8859-1?Q?O+hA7iF6W1iOs2Z6YhDLnKjCKWNDHCEWAEVoiiycg2MUuXuXvlcZmTM3QZ?=
 =?iso-8859-1?Q?vPiLtO3x9veXo1Ak1Z0r4QtvU2D5xEfOept+nC0NaCYLsMCUkvh5OyPVTE?=
 =?iso-8859-1?Q?jNEazl2H6MS+ewGOWoiba2aCcNMj1kk94KMDbusPdsQJNzEGW6R25Tx/zk?=
 =?iso-8859-1?Q?6cV98tn8QlVZxt4QDhjCu8E4UFFP79O1pD418C8K0407NahETvNsI5vGVC?=
 =?iso-8859-1?Q?YiUHRFpAM+OZeFECEdQUV83Dd12heJ2lRb2ZaSGhwRmTdibYUtNaxhyHd9?=
 =?iso-8859-1?Q?kgRAM7yxqyvd2yBk8FMDp8CdwXda0GbasdDwymBF3BL6Y1lI2T0VSVsA2I?=
 =?iso-8859-1?Q?nkZz2jxAwY5fM9vW12L93uYJSJkjTjEB6nLZtVyM7jLLSnWepPEIkpZTM4?=
 =?iso-8859-1?Q?ZrtI/XurHb/KAaYX2WSICkirT3oUBB65Yc7ZHcBYlV1Pt2peulTfgvDQG+?=
 =?iso-8859-1?Q?7TGwJBZfwoHlHl7dMG3OhUp5b5xjjPalQvKYlSeWZTaI0nUflkYSByeWzw?=
 =?iso-8859-1?Q?ajkww12OTBOopT1OvdQyeNjbzWSh/fRLiCNEv4hGjk3ZDFLM6xbMLyvrNW?=
 =?iso-8859-1?Q?xlyQWz6Zrlvpm78AhwLYI34yNLUf0odygp9zfksntE+SRD1H0eNcdu+ecg?=
 =?iso-8859-1?Q?bGTO5pXALswr1jrAFF/nQcDnaZAdqiVoWJAmFvZ1ERAwFfCtio0DNTlVgT?=
 =?iso-8859-1?Q?HUEdgqPlrrQmMr5YwD5hFCjPEUQWFLeO93WMXA12bh5gSLbMOR0bW/2D+g?=
 =?iso-8859-1?Q?snLNVSqQDDPhm26ZNJ0TJCyoe+WwhcdhKXiR1dqrRFFURi3UhHYMvoVdhi?=
 =?iso-8859-1?Q?CDnaKm57w2la5079KcO5M2RCAY4u7ogBdq5j+gstEMhrsG3ohjOB7r042N?=
 =?iso-8859-1?Q?aDcwXhw2DJsSTyCqbxMxWd0n27IVfwHRQhrBsFoD+zm+59OSrvbqjEBd3G?=
 =?iso-8859-1?Q?aEH6ZZasS7+2lXyuzMZYIuKO2ita6VJFYA0iscGBb8WOJZSA+G1wtd0WWq?=
 =?iso-8859-1?Q?u6qerMkhn/EWUZTWUPQK/ezwxRVFiYWzV39+Wv9xKXp0B45+JDWkhtk8eB?=
 =?iso-8859-1?Q?zAKAFUpW5SzVjOSfDTsSh7BfGXPTwc273UD/x2U0hyr0ngAqbkNLy5yijj?=
 =?iso-8859-1?Q?7Bps9/7urSRPQ8eJfxHYXle6UehatdEJHsWTMpEpWpF7B0RMrJ4i0Efo+U?=
 =?iso-8859-1?Q?xwIeTzff3fbePTo8VnDOX5ckd0JjNqDXhZAdXLbvwlSKRcBg7O1DN5D8N1?=
 =?iso-8859-1?Q?9jW9g0qADn9QthVwMbl52mH7s6p1N8kjvPOjCJBVGrkDBqoPlDiWZk2lnJ?=
 =?iso-8859-1?Q?GhyYBAqD5eJWdXPWUIrUuVbTur2sp8fBgOWi3i9oidhfx8TEI4/2fgalN2?=
 =?iso-8859-1?Q?RDJa4vs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lgycxqvbGnyEywTnvxBjoqQdGaRc3xkeYQAsoUUrhIrmz8J2Xx/u4UZdGP?=
 =?iso-8859-1?Q?WpD03/+BEnV16r+OmIvYKzSrm1k65xKjKgOnxIWbaht/GhzZrhTSxsTHZp?=
 =?iso-8859-1?Q?RXjNs/Gub2FmddAPjDOclaIyVMMVMQ9YknTuDk8PX3+DD952pSUytyX5kg?=
 =?iso-8859-1?Q?GM4h00kurlD1YQp3hzdPQUhDiGxPdt8EeHW8Jh/dnn0If9itRBQllajDZK?=
 =?iso-8859-1?Q?AkIlMPVL3MeHUoxdv7IRn8VeZwiaNMnMjk/+q9wEIkTbqJ8r+9qqLDwlIA?=
 =?iso-8859-1?Q?TnlwT8C0w8a/YJRx+cKyeQ+AbWaKAxInOCkYU1EkI6PEYnizcGCvQ5CS8W?=
 =?iso-8859-1?Q?8bSXTnFwzMUEqjfrJhD7lK0Qqj7OG5A0+IB28uvibs6BVLmwLjoh82hDNQ?=
 =?iso-8859-1?Q?XbCfdQcT/J7G8wrAI1kk9jIpW96FgaCuMN5pAiZuy5A0aY/duOzMv0dVVH?=
 =?iso-8859-1?Q?aiCHVfa5RiWutyCOnFz+ouUFxmSLPSNrxaluH7lu6FShgfnq36OOPDms4A?=
 =?iso-8859-1?Q?nxIDnkrGFpKN5R6Jh6iI+hX/FRofCT5miivPKR2SM4Xa7af+0I8KjrHm7z?=
 =?iso-8859-1?Q?XCNrt3iuKzBr8VPqmdALlk1VFTUCnexvvDDg1hMnfU2b8qe2Qvl64S1+dk?=
 =?iso-8859-1?Q?ji/Otq6FTB7qJDu9qkeqCaVF7poMDiaOTgmhEdnbhiqRL4xYNPhRAcTPGB?=
 =?iso-8859-1?Q?FKv8NeLooUmKF6BQwmBTQvacDB8mxL+G7N5hwtnt2ZpvndlNdx9va4QrzH?=
 =?iso-8859-1?Q?LZNdmWu8+louWrscJZ5yD0x3KVU+021mFjE+QawO+HX0dweKgtRM4D21ia?=
 =?iso-8859-1?Q?B8T2/JIxsCDrGqcClViKYBWxtiicc8fzKGSdpW53sbLQAbcqmDNnItU0um?=
 =?iso-8859-1?Q?v7BGJfBOkjw20+3VKD8cuJJNBm1OTo8P2QLWNkM15OjUwqRNEp9tqpTx+8?=
 =?iso-8859-1?Q?0IRwEYyJpEoX1hwJY06oqCEbmQOIl7RPapfnAsPJLlTCKU3GN0wPQ6i2Zw?=
 =?iso-8859-1?Q?5l9dSbAq6NpZzF/tU50lpRb49Yi6iWYT/rUI0NmWxyCxRRR+bP2GpHly81?=
 =?iso-8859-1?Q?wud15UiTRAjR0tvSyxmN1S6fVXBvjyKSPZ8KmHn2x1H85sDhakqqEI6+fC?=
 =?iso-8859-1?Q?+LnrjIHrlm1KJt47NPI1cjgCYgSrRjG0fNifY2FF4iqAgSKLFb0DaeYV0r?=
 =?iso-8859-1?Q?35pSnHqUV+UgmMM9IBY1qOyr8aLRt2gfm8qtvBBSWjUT3sdjM88oAIccr9?=
 =?iso-8859-1?Q?Y2q7+7Ptnmi1Stik2a0UaA/JvO6c60GPvZvgBecFXcCUht/H8Iw5Y6MaG6?=
 =?iso-8859-1?Q?XQmVjqgm1UIYy55j/JNAalP4eMx5dOa3Ojv4NGyW+cuPOZInx+beqWX9j1?=
 =?iso-8859-1?Q?lljlLhPVBbivqZDOyUgXdMtDtNpI9K0D2ECJm+FmTmD85gGA4NKBPP3t4/?=
 =?iso-8859-1?Q?ukd1pA80c1f2S1gtQYWj8Rmi9sxJNnIXtebOAd09IYduH9M/+5eJfXP3c6?=
 =?iso-8859-1?Q?mFDKufRHa5dETPpjznR6YlbpmXh0uED6vaa7YXtz2AG1DP0lmyIj4Rb8zU?=
 =?iso-8859-1?Q?fSv4EusfY6Nuj0HPP6O9ClA3oU33suudnC5Zs9X7iZ1Mog2s588Fu8Y6TP?=
 =?iso-8859-1?Q?Do9MuKi+jxpp/3ZXvsbZ8vo46x4nijMmW7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510d11c0-73fb-484f-7fa2-08ddfab0485d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 14:48:39.1349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJIDipq/4Gh7tqIkxdOpUfdznT69cdkbYAY1Q0X1qYgSu205QwK1j2Pgbza3/RqQvnM+Csrj3Vhl28Jb8H2KmRw/kQ98Y/vNo1UlBhxe5ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5418
X-Authority-Analysis: v=2.4 cv=X6pSKHTe c=1 sm=1 tr=0 ts=68d2b34b cx=c_pps
 a=o2lqJXFw7WzsGQLwBBQY9A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8 a=fUSa9ZSKsGB9THjxU0YA:9 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA0NyBTYWx0ZWRfX57MzK67B238x
 ViPY8QGFRZXBKhIY7czlCdYws0bUyFMcF7JSvnQu+GzXQRzqR7TZLVAMF0RbaeCcs41tV7wdKtu
 Rs1id0R2M/mtpvke7Es6UG+5CFOt8Blq3IEBV6f+LAIskTvnM60DXS4QqbC9Hx3f9uch5FVikZx
 /hICsYj6KGln3jKL8tn4H4FndySdHtPy8Z3P4mltE5iy8VZvjUVyO+FOta88odrM8nv4sv72BA3
 Rtp1mSPg4QYYlIwMqxJw3aj3sgDLzDMRntETOpjZzfs79kvNJD8UJDaIF3Dowu6faszmmqi0q0V
 3ze884N9hKeu0dep5OqLo5yncg49bK485OcX88NPM9FaIrb021DF4OyElzoYjqB1Kimmv51AaVN
 gKRgzM7M
X-Proofpoint-GUID: GWOG6v5Y_zXFwstvu2vp1cEObUbf7p_8
X-Proofpoint-ORIG-GUID: GWOG6v5Y_zXFwstvu2vp1cEObUbf7p_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
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

Gentle reminder.=0A=
=0A=
>Ping for review.=0A=
>=0A=
>>Hi Bruce,=0A=
>>=0A=
>>>On Sat, May 24, 2025 at 02:43:10PM +0530, pbhagavatula@marvell.com wrote=
:=0A=
>>>> From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>>>>=0A=
>>>> Introduce DMA enqueue/dequeue operations to the DMA device library.=0A=
>>>>=0A=
>>>> Add configuration flags to rte_dma_config instead of boolean for=0A=
>>>> individual features.=0A=
>>>>=0A=
>>>> The enqueue/dequeue operations allow applications to communicate with =
the=0A=
>>>> DMA device using the rte_dma_op structure, providing a more flexible a=
nd=0A=
>>>> efficient way to manage DMA operations.=0A=
>>>>=0A=
>>>=0A=
>>>While I have no really strong objections to this addition to the dmadev=
=0A=
>>>API, I'd appreciate if you could explain WHY or how this method of worki=
ng=0A=
>>>is more efficient in your usecase? When designing the dmadev APIs=0A=
>>>originally, we looked at using both an enqueue-type API as well as the=
=0A=
>>>implemented individual-op-based APIs. IIRC at that time testing showed t=
hat=0A=
>>>using the single ops directly was faster than using the enqueue APIs, so=
=0A=
>>>I'm wondering what exactly has changed, or is different about your useca=
se?=0A=
>>>=0A=
>>=0A=
>>Here is an example where we see enqueue/dequeue ops to be useful especial=
ly when=0A=
>>integrating with Graph library.=0A=
>>=0A=
>>We had to write an entire wrapper[1] for tracking sges with the current i=
mplementation=0A=
>>making our nodes[2] very complex.=0A=
>>=0A=
>>[1]https://github.com/MarvellEmbeddedProcessors/dao/blob/dao-devel/lib/co=
mmon/dao_dma.h=0A=
>>[2]https://github.com/MarvellEmbeddedProcessors/dao/blob/3f364261de91e355=
699bd9af20d60ea6459f7d67/lib/virtio_net/virtio_net_deq_ext.c#L51=0A=
>>=0A=
>>>/Bruce=0A=
>>=0A=
>>Thanks,=0A=
>>Pavan.=0A=
=0A=
