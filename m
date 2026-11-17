Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D995606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=Oc9j3tfj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42AFA402D5;
	Tue, 17 Nov 2026 16:54:06 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 9041E4029E;
 Tue, 17 Nov 2026 16:54:04 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFSk384192330; Tue, 17 Nov 2026 07:54:03 -0800
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021101.outbound.protection.outlook.com [52.101.52.101])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4j0ar1bnr5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 07:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy+q75l/Bh8Kel1hknZmgWBpAWAk/35lz7UrhH9wEEwc/SuKha9s775GI15ZLkhjCmGS1ux3/37KXKy2vLOzzQKq8yUwdtyDenAJqrNnEgkTkQtw0oXTOJJ5cV1lOc30rTKXQklQj+G/9FCkgdh6hU2qV1le44cthH/y9j7XPdf6zrTZRu5JhJBulvMdIz2enz75MRklAKMt/iu/mvYwE2oun5ANiz+F5mb5dWRW4q2d0OjuXCB9G7xai1mXNAjR91oUueB2Ar7tCg2sZAfEs9vOcJ+G10/4VyIdyz6wvYO8bwkJWUhFk1g2rYoFt+anqJoNzOfdxB9YbVPNKBXYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7lvmDUczy20Ja4jDir39J8WjIm2L6O9ZeDCMtPh6xo=;
 b=l8NW9Is60UnTAXsSZsepj7a80mMMmySLCXtMQhT+6wZl6KGUrNuHndbNnoR5BYUK7skdt/BwUvEwanVGztgtDECiHaYW1wMNucgVmh4EiAuLpoIjCrUufRIsGxwgyd1che/4zbbdPKQMSbkfCrU7K6866tx+Es2lEgORT9xeqnOwZJlg6XB9akvSefoUgk08JGl/OPioGqXfYqLAij8EbVtezBRTsdCameravkE0q8jwh4tsTByekY0keutrnCy5im5FDzei7pFUh9k61/HINIq0HGkhum11J0/nUCNSXZn7AtPWmLKUgnB7x2ka8mwrPvCsJCDUtGdgvcgOvCMhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7lvmDUczy20Ja4jDir39J8WjIm2L6O9ZeDCMtPh6xo=;
 b=Oc9j3tfjeFlPoREwFLtUFIVvE8KiVOOL9qHLapfOInAocaQ9UKmVnYAyyJdT+YEiSpN/PJH2hDwPVrDDNuAEH0ru+mjdvGUYmk5hxj2pv1VqgC478iShapN2AOrZph5U9ZE2p2GUiVGXnltt5FiPIgMsDOjnHcVVzjw1StyZzpQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS4PPF72E692E73.namprd18.prod.outlook.com (2603:10b6:f:fc00::aa3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 15:54:00 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 15:54:00 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>, dpdk stable <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] test/crypto: use standard memory copy for
 wireless cipher IV
Thread-Topic: [EXTERNAL] [PATCH] test/crypto: use standard memory copy for
 wireless cipher IV
Thread-Index: AQHddqMYoC9tW3BQtUiq0lzllXLA2LcyajHg
Date: Tue, 17 Nov 2026 15:54:00 +0000
Message-ID: <CO6PR18MB4484EAFBCC5B10AE8EF58920D87B2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261117145104.4140295-1-kai.ji@intel.com>
In-Reply-To: <20261117145104.4140295-1-kai.ji@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS4PPF72E692E73:EE_
x-ms-office365-filtering-correlation-id: 25342551-d89f-47a7-f7a2-08df44c2ff07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|11063799006|56012099006|261022075727099003|261022115727099003|261026135527099003|261026121527099003|261022113327099003|261028144727099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261021130227099003|261102123227099003|261021135927099003|261021133027099003|38070700021|261026130827099003|261022105027099003;
x-microsoft-antispam-message-info: 47QfPuUReEsa0veGm5S/zw59S6sVkdwPD8T0z7tZ+EtfItSf0/y+4Chn6OBbEt3XlaEk8HPz/coiz9jlZoGwu6w7z7npTf85KCmZea6tjmG7AU/3raLoWof+Cz+jxevKR9HZRKXfiRZdy2460iPM7jJ1GutxUn2N3RxlsWeMlUI84YJnCmKJQyYrHYPtMAPuXTp1Oo+AHuNChF4L02g8BG2WYHIwmZ0LZddTstKOax4A4Zfh5dZD0LW8iKcVFi/DqZ7sczCLOdIZcgtkmQSDurSPdirYoHYmIBguPaxhZ0g8i/g2t4WTQ9q+PyPVigbtV22v9LND/bUhV4l58Nhd89VTVto/bo+LlWBqN+NL47m+/f96M2yHfQ/+1yFniU7V88SwjxC7I0ikbz7s05hPO90wy1kZ7/s1hRfUCpxCrSj16HG8+uZpB+kgeSxSQUhM8Cpcw/7hxx62zh2MALWH2NtKeQALg5hcGBNdVazD1YbKi0G5mIf/ujg4PIFmZt6M7iSrLO755nt0tk2/0bS9dQF79V4d7cyc0a7nSOlj8ZykcxOo56dPM9ijd6sP2t8gCytyc9sVrf2YrmtBDjULidy4Xc7c83RSaez7Ya9yD5FkPsHuFw3Sh57aDWK5hi9bna1j7J4q8N3IhBcRqkyryC7DPT3SBZ6ABabS2SYl41jiYu7wYy6blFu8kDp0YKtoNz8bOqhoSvYZDqkcq+/wQXVCEoYD5O8eUwAhROVVDlQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261022075727099003)(261022115727099003)(261026135527099003)(261026121527099003)(261022113327099003)(261028144727099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261021130227099003)(261102123227099003)(261021135927099003)(261021133027099003)(38070700021)(261026130827099003)(261022105027099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yp3vMJqi5DnonM/la+eoRX+DL9GJ8sKe18VWypwt458izneMdMGjOI0fK2ay?=
 =?us-ascii?Q?zgE+TxAP2UzVy5yTh0wOeOpZuqk/3k/pXcDO0owghSsrh/pZKI+w39IdEhu9?=
 =?us-ascii?Q?95tUbeyTlOcmvqko95DNrMkb8/eBQX0CZ1WZQ9vt00Ls+4OnBjzdU1Ie8fxE?=
 =?us-ascii?Q?rDNh/ceMbdw3zrHU2ZCYv4yVYUM64HSRZeddGj+sB8tzfsPKaLziflPidHgL?=
 =?us-ascii?Q?By2gu2PEbHBBf6im1cOxzWp0ywG2jMRn1GMC+uV/kuEbHM0vXq4cdYNzGkcW?=
 =?us-ascii?Q?1z8iK7KZBLRg0QO0SpSWbfoAH0W7llWZL17MRASQfVG1T2hJMTK0fDkQBcSN?=
 =?us-ascii?Q?ezZT7Z0bH4VJbYUaiZI7iBg09FYNl4W8J3Yx6QoSqdN7sBFLrdDpuhsBVsz3?=
 =?us-ascii?Q?MtLSlyC0fKq5ThH0ifK1KVfmPanGP621bdXDG7JhIbmhT+UkLn6IkSsOpncK?=
 =?us-ascii?Q?QVvWFCly4jT5gRDCetFUaHg9Vf8t+qPTE+k1kB5tfS8iR6VhWEQaIBo88P+z?=
 =?us-ascii?Q?q35E0Fie4UqJQ7xDsKm22hP8Mhk730Wh172QUdwti29cUuNxFteuK+VIq4q3?=
 =?us-ascii?Q?os6iyBjORkdj3bg1MfO1oBbFKFiQcmnmJOSjNpcYk7LEoc7j617TWk4gIw8e?=
 =?us-ascii?Q?AojgH06Zh3jHTFT/v2emRpgmMjC/F8o9dSiXCWdGvHBD9Fd1dVEPmxvDGFEd?=
 =?us-ascii?Q?AFdstDM5Bi2dwzttuZu2Th9IuT2+cgs2SfCFq7/q0eSvbVogmAUZjYoWfjRi?=
 =?us-ascii?Q?hUvt2yronrTYWjPypgQ+uVMV4gNYGlzah8Y7gcb816VUECk+TZ+XyPZJ1k8Y?=
 =?us-ascii?Q?tNtglZOZ1vDG8C7hRmLP1B4z7eU5ZmHvY/NK/r21gIkjoN9Mu6+FLjWahf2n?=
 =?us-ascii?Q?fn0cEJTw1KxvUxT1uXDIATX9emmCjtpLI4AuYxERi6wFHMV+htzbTHmnTPsy?=
 =?us-ascii?Q?9ietdmZR3LdSRQZCZO5nkCcHi2Zxd5/Tz2g4yztUVQ5GSboHc3OxJ96+KsoH?=
 =?us-ascii?Q?Khicrk4RYInm/6JZWJur7hJAIgPoaxSV4quu9SaJYUwi8ujYwHEpXVAGExw0?=
 =?us-ascii?Q?6fFq7gYuZO6J5Xbpp4snV+aoClCTeEwdm5SJKsAvpxVSTG3y8NNhY+u/h42/?=
 =?us-ascii?Q?gBRsrh5OgB5eFGSnvvQWFTg5zME64uDjsaLwej85hFRALQilFHTZfotn15o+?=
 =?us-ascii?Q?BuAnFp1XTWXYQLrpDLFFwKg5VsVJtkLyHvKtzmm0v1C2d16O9dJmQVWnKD78?=
 =?us-ascii?Q?oXyt7W2LMtljvHOZ5QWSNTQzMLZKeiipdn/PkyzcaAoabZVWXUPgNKwXKCnA?=
 =?us-ascii?Q?I2mTQfB1X14GCuEZUJYkrFtrbjb7KzBGSWfBrgTuA0QltP9Q/3gY1auPIPC5?=
 =?us-ascii?Q?JioIWYWPp5Vs+O+GUb8o+ovfifBGr/8bNqmKZMexSUDWVMz+ZPXIYoSicsTi?=
 =?us-ascii?Q?3dltj7Z9LHaQ7KRB4c0hVqx5niisNiNZb+Qd8XTVWO9tUSL9YqvS7rml3ocb?=
 =?us-ascii?Q?bvcKLPC79fXpNafo2sSp860oW3mRRSaxAOY96as9PF5Uh+ZaB3JwS6WN9tkf?=
 =?us-ascii?Q?N+acV2doWab+Ab4GqfSB62IbIC2IgrJdqpO+ZxL/4Um25IweRXDlKcx5UMZk?=
 =?us-ascii?Q?RE5q6AFrtS6P1I1iJDjk1JDz5BvOZgLIvTkrPojPbkYjI9bFBQhqhVq3xqJu?=
 =?us-ascii?Q?NlJt7YSR6axn9pkA/ysWcDt/chh4WShIbk5hFlkoY2vV68pm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iWM42EkKb0g6G7vvVijJiJg06lXu5Ju4lekWzTWdgzxgNREndoQ+JS2GVcxs/esjD8CB7cBqzfbscOVnv0Wgpp7ZRIi0qH0Tb+XcCePvWQQapPRpNlz3v4TVjuFIe7tWgm/6mmkakCxvYozzpoKmkT2RKq5E5lheK/Jevt1iJWfKVL4oAl0OMakj+dd+i1znI/+oEsOHvRgE0kuy/A/1WR2ZCKMAiBD2YoVz8kY6k6RewG31MBD7jWXPsqclwvJI7yencizVm5M1oRYien2tC1fkWjAjU4Fy5IePD71DMx8HWEmC4V4YVRwKKoHiRuHsiwGUMFhcK9uniw08/Q7TWw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25342551-d89f-47a7-f7a2-08df44c2ff07
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 15:54:00.2457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11B1lLh3aPoIazTsT639C+4d7hQExYU98XtpmPwC8gMSC7uDeaq/sHfa94a2cIfCy18+81LLa7Y/i78oMrm7FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF72E692E73
X-Proofpoint-GUID: 9q6bzE5bjipGHNdi2WOf-UdGEDB7Mwsr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX/zxzU5Kc90ze
 a17CtH8O854n3IR6ze92+CY4t5LwoMethpl2ULWdETvD7GMx8UehAlcOpkMQsCk3SkiIXmosqTR
 qgz4bxt819jfkakoOZnVnL1Gka3TfruPgD//Ri6yo8oFCGezr3bNnlv1foVoyfWYjPAE4/I+83A
 fVtaY8HQ0KUNdxHF19Yl9ubJGrHOVyroT4VQ5Dghtx7C57HUpn/Eq6Q7tqWUoEVX+MWfWFuqDD+
 YCloWqVUBz6WAEkUOrjxNH7guzazBrqA0C4RxCZSHj2ieA0nbFOQNE+5jHAyvUwoz1cCo/rOzxL
 8G0BmOR0d2wUP6hp2OEBYun71dKuWrqNeoB8SDmc8HuTsgZO88rTgHtjQBHssiGs9x7wVjuYKql
 zMVeVqpf5RrBQtJJf+tnVJB8RLuAtQ==
X-Authority-Analysis: v=2.4 cv=a7ulZkSF c=1 sm=1 tr=0 ts=6afc789b cx=c_pps
 a=3cYuoP5kWG2k1oDcrssWdQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=UF4zArD_25YtzFEsjZsA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: 9q6bzE5bjipGHNdi2WOf-UdGEDB7Mwsr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX1XjjlvzDeJcE
 OHnolTw6PCu2k9/k3+IxY/0oetUKGQbbc4KKfAP0A5oUfreEHvDszovbigOYs7j4XubfLlTOJJR
 Hi7wcaetPRsIjguv1u3kkgxh2NrS5xM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Coverity reports an out-of-bounds read of the ZUC cipher IV when tracing
> the optimized rte_memcpy() implementation. The ZUC test vectors use
> 16-byte or 25-byte IVs, which fit in the 64-byte source buffer.
>=20
> Use memcpy() for IV copies in both the in-place and out-of-place
> wireless cipher operation helpers. These small test setup copies do
> not need the optimized packet data copy routine. The copy lengths
> and operation layout remain unchanged.
>=20
> Coverity issue: 507468
>=20
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
Applied to dpdk-next-crypto

    Fixes: 27a1c4714d54 ("app/test: add KASUMI crypto")
    Cc: stable@dpdk.org
