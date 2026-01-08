Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B1D185DA
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 11:35:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 026884028C;
	Thu,  8 Jan 2026 12:35:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 34BBC40261;
 Thu,  8 Jan 2026 12:35:26 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 607NW8FH2095193; Thu, 8 Jan 2026 03:35:25 -0800
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020130.outbound.protection.outlook.com [52.101.201.130])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bj1819a5e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 03:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/8R98BZAwNHClA4gkrBjoShH8H2z2UAoMr3rtXrG60X2VE6VYa7dDrc/YCsRRqxxKNMoh9RoyBeXAXa8WoT/c2KTOWsO0sd7qBqUja89lsxpUEI0TaB0bDOQMeETjCKMxqr5zXJyOca05ujDJFfl4EhT6scQGceVGmxKgTCGogE2D1v2Q09ATmZj4vVbliGQWHSvWzkcNxi0dQwK5iZwWsl3sFDs60mdi1c6RJJMGVefTmXINW1kilxvIP8brH7SQ+Nm6dMy7ddgy0HQl0URdFW6Af5ltMPd2nMnro+dbvQxIPQEulBmUx0oCUoPCFjt7w0jZ2eiyFJQDETmUtJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dFt1+QRKLEm56qS8guY5agvpnRIN//ayv0h4Ao3HdU=;
 b=PA3fHVz0rKlpp83mHRojSM1TZjkNAF2hGsm3+oN8wV7+us2shaqWL9h/1V+QFtWI/eDqBMHTZXxRli6MSSXDrbLY4CM9MY5r+O7aJSaKX+qAsUbaWL6p4ZkGjow0cbMmtpAVznk0MjD4KZ/hTwqOai4I/jKEIAIt9FL2/Bs+XiKhoB4GXWSHY/RGqNPutvX4jIRVbDiUraJ48yq3rwgNSiCmMXpo/7NvTkY3RRTRvmtv8/AYR4pUGp/Lzul05i0rC0ORfgqECWLlZgEzHFIiUbVnMT+z/8qUv3pRYP9exYzFVUGNJmmrkb8cdzNSQEa4bLTRmYRgHzmarkRt483qww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dFt1+QRKLEm56qS8guY5agvpnRIN//ayv0h4Ao3HdU=;
 b=g5ODS9RZ8kOiMKoaYKl+aySDGlxIQ/D52UQJcD33cyNz0F2FHt6N49DUSLVfAJxrmdK+VYeOzq6QMQLZmz5pE6B+p+Bd7iMILn7xUkIQ2hiLyT+EGK+jITTnA618FHvp+aLe789T4QFio4bb2XMRMjBbZi5Fi9/JgoaqyF9RC8o=
Received: from PH7PR18MB5078.namprd18.prod.outlook.com (2603:10b6:510:151::20)
 by BY1PR18MB5952.namprd18.prod.outlook.com (2603:10b6:a03:4b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 11:35:22 +0000
Received: from PH7PR18MB5078.namprd18.prod.outlook.com
 ([fe80::339:a820:953d:3424]) by PH7PR18MB5078.namprd18.prod.outlook.com
 ([fe80::339:a820:953d:3424%2]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 11:35:19 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: dev <dev@dpdk.org>
CC: dpdk-techboard <techboard@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Minutes of Technical Board Meeting, 2024-November-12
Thread-Topic: Minutes of Technical Board Meeting, 2024-November-12
Thread-Index: AdyAkq+BjMKCXUz8RDCFENHRXtAoNA==
Date: Thu, 8 Jan 2026 11:35:19 +0000
Message-ID: <PH7PR18MB50788B9A9F939CC41AFACE71C885A@PH7PR18MB5078.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5078:EE_|BY1PR18MB5952:EE_
x-ms-office365-filtering-correlation-id: b60ad964-1c84-4e94-ec37-08de4eaa006c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?tE9Ptx9uB+CK3NygKtEhMNbjGJiOxQa7wR58kcSD44fUY+TRVt/ClCH+JSVM?=
 =?us-ascii?Q?I2pb5IMaFlrPIpr8gEqMPkeZ6D6NB1dyZ+WwOprUaJXaJKbBIg2qXyIwXMPS?=
 =?us-ascii?Q?aDeSHKgTM7ni4mVIHA8r1Qe8ZaWPyzIhcikOd5lfPX7KHPcTpUPReoEFpQXv?=
 =?us-ascii?Q?jXgoP/EBVQWB2yZavhSskLkytHo5ZHgwKs/wYcES/h3dAZ9teSz9tniRzTdZ?=
 =?us-ascii?Q?eH6qgrhsCWEuxfmwStgfpCKfW3ysDTnFWRMsTcnesxGKWubloiP6BJ/bubuB?=
 =?us-ascii?Q?g2nGKmrVE4IGh4ogApRNhQgCHmfRFP1QULqnPNGNroD6FQaOlbY9I85L8xMz?=
 =?us-ascii?Q?RQzkCGrGlAtoWhi8ZNUwq+jVFaeRW2YQr8cmvYVoYexnf65JkJVJT2VIaUwh?=
 =?us-ascii?Q?Pu0KOxw9IHC2/EpKAapDNVNG1Fwa7aY/9Ksxp04z0L/+tBqnyVgLMSEFXz1Y?=
 =?us-ascii?Q?vOL68m89ejEWtw0QYwcZkSwfSsaQeOSIbipC6fgcd/ipBeItGZeHqzTtdRhW?=
 =?us-ascii?Q?c/2ttuj+I9hLwrRayNCxd467suIwDV1ByGFfluL9tCZUziy70cZ+EuQvvx42?=
 =?us-ascii?Q?MqSf2pCx+d69Z+G/rpwPaXe5BvloV11igCjsspqkPDK/fdpZHZBGl0PGCZQ3?=
 =?us-ascii?Q?6LHQXvColLzBqeXJUSFIYJN8RURuRQ2wXkFcXry6eHWX7yBZIZbS7/tC2tsw?=
 =?us-ascii?Q?n0K+91pBl0TycaRhyG5AniIwLZzo7gOB2erraaDDmlNm5vO47uI8NTQCPu61?=
 =?us-ascii?Q?3kVH0qvZfhFc2wz2jY+3pabklMpSaWEDBVnGOZwWFyQlBLj1Xm078y+vyYpc?=
 =?us-ascii?Q?jn42MDJTygAUpFSPrrvD8/aLEbUSh0y2vXjqnED1WQUWJnIm+U/bT/izl81K?=
 =?us-ascii?Q?xMT06qIQj5Gg54qFPuuSOz5NDKGQgZOp/5qJO7Kgm/PrUJLPE1usV9pvEMwt?=
 =?us-ascii?Q?zX+9GS9h1IkAG1YRoSwGEnxZ5MYzSV86SVFP49yJchdSDHLLik0zKcL3T/Qq?=
 =?us-ascii?Q?aAkdiENV8cgWCjZy/rjlov4xzB28vX+wCJ11mTpQhza21Do19xpmSNP7kpCi?=
 =?us-ascii?Q?hPr81unKE+mt3v9AgPNFNrMFfnI5yIGmtCasfMMOGArm+XVVB8QwCMlBYhEz?=
 =?us-ascii?Q?VfX0Xx9K70TsQQKRvnwUx1yrZfJngjI8PiD1Y9onCper7hqtsYqv8aq3FWlU?=
 =?us-ascii?Q?RIkF+cJpsaeS3EckCRqkj4kcS6XY4nAXcPCXaIkDDL89EBLr7Ux2jPd3ynX2?=
 =?us-ascii?Q?vO/Q8IWr1tbHOH1LjEOP57l4BLslcUPgiJYzagPjYglIlVC82N2j0womtsMO?=
 =?us-ascii?Q?iD3P6l5ZR0sm7e7y/y92DaJEbfvHmeVz+hMe6fALQ4voIeDbSGHmp5ikcP3I?=
 =?us-ascii?Q?qGqVS2kAm3YpLLIaG7URqVHB/eqzhhRniGZTHnI5fmyIMtgD8JMTIioX2790?=
 =?us-ascii?Q?3mVW6hvkp2ZUDnYaP+LYavZnIbS9R8uHH0nGkSiNTU+jZPO5GxAKqA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR18MB5078.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v7Px03Kv8FEUGXBfJc3pPNoJexArc8q6LITOBw+jsUCxEdyTot0I6ZLbx13t?=
 =?us-ascii?Q?xeyf0QLmCdVzjiDIdZccgkd39gD8Amh5GI3KvS7d1it9HNsQJ526XCZ3p/jQ?=
 =?us-ascii?Q?lYu3c2lnVhfupOnhyRiQNMMkZFTrqVt95JogpHCZJiOTFoRRE3bxegFD+wrZ?=
 =?us-ascii?Q?3JhbH8MxsjXY7pCYZrL3KP2xM0m9AZgxlv3ItQ5CeLROgVBXFPU4zT2+IcTx?=
 =?us-ascii?Q?MZjAsBKxtttGrQNfl/FcNg3Ax/O9Y5eyxSG5keM1ZdlL6JyLH8tlWILqcgbC?=
 =?us-ascii?Q?mF7YntVV1d4QljuZpT+1BIZA4kUbumFNT17h0EqXTK6paIdNM8LtZ36qVXFs?=
 =?us-ascii?Q?MnnvghaznEfwctgkCR1hy7xRX4tosCEx1wM7qk+SLaU4bk1XwPz4DLmtZo1M?=
 =?us-ascii?Q?v3IX1frtE5pvR4B7YYHK+POcMzqUiE405/8gWZRISuov0OSCeaJ4cDdtvLzv?=
 =?us-ascii?Q?HUabeZN0WHxMmKlffN65j40jLF3osTZs0UgESgNOq16Hj/O8HLx1va0yyoMe?=
 =?us-ascii?Q?W/HXemqIb9rU+1KoLJSeYmtxL8KPO6vlQUHeUA93w5XIO6QEfKuSAtfQFfvt?=
 =?us-ascii?Q?XghlQCXyqnGsA2iuW3M4prBYLW1E9FY2daBJFnqYCchPqEiHzOWmBJaHjkea?=
 =?us-ascii?Q?8HjBmA2k+OmKVhcx1EcuTShnTHSsheEfBXIs4IoYB8+PSi9OsguGCWc6QRCh?=
 =?us-ascii?Q?YrD14KLKJk5TSq5xkFbMUkiqZ6rybUCc7QjuGs/B+5VPZnAAKqCqSsUjHNTo?=
 =?us-ascii?Q?/NX+HWcJcDtBtUzkxCStnmolPblx5OyBoZS8tI2GPBBhM78oqYMMgcEnWHUl?=
 =?us-ascii?Q?fo0HL5z7+xLLEQ1OIH2pdeyBg4Hp7sjRtb2J7OJe0we3NJqh2vv5lueGkP3N?=
 =?us-ascii?Q?t8OPGUhHqeZlbdMafXtvmPtyjqO2aY/2cF466LuLyD+SZE6Cs6ZLQsARuSdd?=
 =?us-ascii?Q?bl0AUiecSfHA8c9A2u+CQEJCB6Wv7GebaGOtV+ObqvG24aGewGZGMzanYWP8?=
 =?us-ascii?Q?la9mqj9gFfiYakzYIyLu6i4rw6OQd5OLR5MltyTt34jtp03dA7Kz2pGJeQUc?=
 =?us-ascii?Q?lGnW+eeor8bghwYE0YKXiVAfJ/UJFUahRdeVtnyltwlQJzW/aWgMFD9V2Fr+?=
 =?us-ascii?Q?45YqMu+nWIz3sKNZTG3z6HHFSFLdr4GEoxb1bpoUqH3ka8w1ftZsZyQh0vje?=
 =?us-ascii?Q?ZMQHwt1GGMQp2Ca3I8n3SL4b2uzYa0Zy3rCseiwIxcAJLJvwAeAM/WHG5unr?=
 =?us-ascii?Q?9KGAF8E5mZu/ywtZKO0Qp/HetOl4w0oNtYXU1lUReTp/m877O4I+fJt0xl62?=
 =?us-ascii?Q?thfkMwoSDWeW6jkZTMhaHk15qJVcTWHIklMQ7hr1/7DeVtvJfaTusgXb9zVs?=
 =?us-ascii?Q?7DnDyweCGgIwPaziQPfegbtT1Z27uCwChxtLIst4ZlZjhbsXCDItS+YdISnE?=
 =?us-ascii?Q?lFPlgEx3u2ZIHxK6cmttN7SjxHsg4r/G8IHwZlTOXbQECViSAvJgt6GRNf5a?=
 =?us-ascii?Q?xvvuxKxvvKpdtNzXHdbfUMECpP/1w9YrQ3gUZbjq5cXUiCZV+1xcp69Yx3r4?=
 =?us-ascii?Q?O6rjP2h7XIS4vDDTf6pgzOxiMZhPiUhPMLXlztzM5ia/XpZ8bLVNM6sKiEB6?=
 =?us-ascii?Q?bRsuP7ERaWPQn9d2y/mvaNx4ABgWLlIG3o0uWmR3sT3SXRKo51CiDcC9xovx?=
 =?us-ascii?Q?6VxtONB2UYWnTQvjjMmWoF+JM5hoaiINg9MR5HoxQ9Oz3dqP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5078.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60ad964-1c84-4e94-ec37-08de4eaa006c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 11:35:19.1218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2TVtsi9/gRbO1eONDM4XKiOQQJFRsI2vkfneolKazJSedjXLYuxMY0iqo7kDuREhkFxn32vq7Kckj8LRKV2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5952
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA4MCBTYWx0ZWRfX1DMGd1g8VmgN
 zd4dU3lgLs8gSKfQXgpmH1RYPBVby9+w7QqXIq/Da+OVsaJSIEmzR3ee0+HDjZtgcH7QuS1l58a
 QMGSW9PGA9Lfqlb/cCGZtD7WHHJpwE51OkKyS8wbhy5uI3ZE3NczZ8Slf+JzGiQlIq1hWL0EJat
 DTpfXJT2gl//F4rRjHXpq5Y0KuQAw3lOfMYYRshSLRS8XYpHW9Ons9dOCTFuc6Re3H7JZsrbhLO
 UZ2G48mcINDu3Y+sz0yPMbbRgWJQ6QIu4MqonCWLHqkUMvrgaHZLrpw2hxxHR0PUWEEtm4xGl3D
 XjVwkdrZYe63d2emd3MXrTYI5z6BSDg1wLnqjILaSn85/htsms4YkFF6O8U/dY+Ip7NqYMCBqLl
 zrhawLcWMnSXEZQgyPsbLYbIW/63tu1AF+ya/d0U8rlJcNuNWtzJ6+5ZVqSoGgZgzZPTAf417Nz
 Sw7sVQORQ+X+6wk/57w==
X-Authority-Analysis: v=2.4 cv=Vdf6/Vp9 c=1 sm=1 tr=0 ts=695f967d cx=c_pps
 a=pt2/1SnMKDLj9q/aNz1zKA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nXA5WNwiAAAA:8 a=WqG8-Gg32UIo6oAvKWcA:9 a=CjuIK1q_8ugA:10
 a=fGr-7aqQv4RST94IA8XU:22
X-Proofpoint-GUID: 4YeKrXf0CK50AY0crFA7txKFyx54U44A
X-Proofpoint-ORIG-GUID: 4YeKrXf0CK50AY0crFA7txKFyx54U44A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
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

Minutes of Technical Board Meeting, 2024-November-12
=20
Members Attending
*****************
- Hemant
- Wathsala
- Kevin
- Bruce
- Thomas
- Morten
- Stephen
- Konstantin
- Shani
- Jerin (Chair)
=20
NOTE: The technical board meetings every second Wednesday at https://meet.j=
it.si/DPDK at 3 pm UTC.
Meetings are public, and DPDK community members are welcome to attend.
NOTE: Next meeting will be on Wednesday 2024- Nov - 26th @3pm UTC, and will=
 be chaired by Honnappa
=20
# LTS Maintainer Update
- Xiaoming resigned as LTS maintainer for DPDK 23.11.
- A call for volunteers was posted on the tech board mailing list.
- Shani Peretz volunteered and was unanimously approved as the new LTS main=
tainer for 23.11.
- Kevin and Luca will support Shani during the onboarding process.
=20
# Driver Maintenance Discussion
=20
A general discussion was held regarding the current state of maintenance fo=
r the BNXT driver and
how the community can better support long-term sustainability across all dr=
ivers.
=20
=20
- Community Discussion
* Emphasis on maintaining a consistent quality baseline across all DPDK dri=
vers.
* Importance of clear maintainer expectations and sufficient resources.
* Acknowledgement that hardware diversity limits full validation by subsyst=
em maintainers.
* Alignment between vendors and community contributors viewed as essential =
for driver reliability.
* All core components (drivers and libraries) should follow similar quality=
 and maintenance guidelines.
=20
- Discussion was collaborative and focused on improving processes, not rest=
ricting or removing drivers.
=20
- Potential improvements considered:
* Adding support-level tags in the maintainers file to increase clarity on =
driver support status for users.
* Updating documentation to better communicate expectations for new or evol=
ving drivers.
=20
=20
# Follow-up / Action Items
=20
- Await update from Ajit regarding the new Broadcom maintainer.
- Await Broadcom's plan for ongoing BNXT branch maintenance.
- Discuss adding support-level flags to the maintainers file.
- Consider updates to documentation or policy for driver quality expectatio=
ns.

