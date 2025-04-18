Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58967C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 19:03:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CFF5402D3;
	Fri, 18 Apr 2025 21:03:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 21694402CB
 for <dev@dpdk.org>; Fri, 18 Apr 2025 21:03:48 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IFVntF005747;
 Fri, 18 Apr 2025 12:03:47 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4620fdq6vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Apr 2025 12:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1SAMyfxO/Wr3ygIuPxzs414T4Ka5i0sDZKmYKjenomnm3Novsy+hata5uDocIxLVBvEsfOGRYtQmYL1Xc0waYPOCfeXcOHM8GwpyXDgCXNUQVjlqqzfUMsbiD5tba66ECmeezvBuy3FSxWxwPCD6kewK8mzJ5t7bXZhjtiVC0C6jIZO0qqrJlsKBUxZyU+mWZ6T9/cNvBgsQGiihh0QWklvMlXyioHd/2xUecm98ocv9hUnm5wXPTlhzdaX94/KTl3BxHrjSMfRbvwIv7Cu66ZIG47fjEywp78YPP+t8GM0srPngQbnLqw5Ja5HG1Qg42GqroHzThGAKhzJjIGEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gvlMDeB5wLYfcoDSnG/rWWPKUqMV/USJM2In8oCtis=;
 b=WKY1u4D81bvpy63i6Z35l9J4BQrc0bGkgVr20XQMCfX2kYhBws7/vNLWV1MxBxdcbR+lOiuZie8ujy8BqvA+b3hwGF9h/SGjMf97RnXU8fi3up8QMj1qa/ZMa457Gnu19fVtMzQztYuvTzJpvgh2vttuYjDf9of9YTGRdMB/YrhIa5vEIDTAP1HdtoOVtCZkwYu3wK2Dp6s1JY/NQN9Ar2LaA8cQy42Caejr7Yyn2GTPvMVJAHJV7Reb0W9XPuJbQwEtAB884WqO2UAhNug2TxxXyy6mOY5tLrKwjyUGIRIPRk7Qp0WYPNuj2yRhSqagmIgZqu4Uo1s2+raiIVOBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gvlMDeB5wLYfcoDSnG/rWWPKUqMV/USJM2In8oCtis=;
 b=LtiwhTrb0botrBsHINXOIZ48pxQ7JoEttE7Jf56udcaYCvUva5qlDGNrpRB0MY1yIfIx3+2oNaubvfBNkIXAgYwWEQrY7oQRQzFbmbEvJAnWKOLGZWSLmiTRB4rtl+4Mk7z8TdRUqraQB3KhmKd1HlUhUWH+v9mWONavT8Yn/Oc=
Received: from CO6PR18MB4084.namprd18.prod.outlook.com (2603:10b6:5:349::18)
 by PH3PPF50CBFF55F.namprd18.prod.outlook.com (2603:10b6:518:1::c99) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 19:03:42 +0000
Received: from CO6PR18MB4084.namprd18.prod.outlook.com
 ([fe80::c296:9e34:99f6:944d]) by CO6PR18MB4084.namprd18.prod.outlook.com
 ([fe80::c296:9e34:99f6:944d%7]) with mapi id 15.20.8655.029; Fri, 18 Apr 2025
 19:03:42 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Robin Jarry <rjarry@redhat.com>, Christophe
 Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin
 Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v5 1/2] node: add global node mbuf dynfield
Thread-Topic: [PATCH v5 1/2] node: add global node mbuf dynfield
Thread-Index: AQHbqVcktFPm9TaXPUqLc6PKHcZ/+7Opzvpw
Date: Fri, 18 Apr 2025 19:03:41 +0000
Message-ID: <CO6PR18MB4084AB7880F9D37F0862C636DEBF2@CO6PR18MB4084.namprd18.prod.outlook.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250409135554.2180390-1-nsaxena@marvell.com>
 <20250409135554.2180390-2-nsaxena@marvell.com>
In-Reply-To: <20250409135554.2180390-2-nsaxena@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4084:EE_|PH3PPF50CBFF55F:EE_
x-ms-office365-filtering-correlation-id: d0937aa3-8f98-4620-f451-08dd7eabbc54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rkgtT4fkNTOeJn5v55nebBp4dYT4tDU+iYSEStg8a7h6KP9CT1etnVFIbIp5?=
 =?us-ascii?Q?YpWCJ/kljLOlJ2X/JvFBsdgGWtBZMgsbRaqP4uC57IN553DgE69Nia+QMG44?=
 =?us-ascii?Q?zdXrYnlB7Rs7vy8S11eZan7t7P69WBx1tn8N5cnT+JdRpndWYetXzLZtAhFZ?=
 =?us-ascii?Q?NOWAV2FFi2PIPj9LMcy3iDpHSFtJ8fsODeTE35hG8AeHa7+DLO4VLzXydLdi?=
 =?us-ascii?Q?1Cq3No7d79lIspXQoxsoipJpsF5sKE0e0wpJMgnvEYkh323sxR3m3q1mjCgc?=
 =?us-ascii?Q?n6CxDXyHFDz9cO8tSs4Ma9bEuSSC9dH/BwJ6zjQum9/B0kBWJVEyw3bRh/SW?=
 =?us-ascii?Q?cq0WqtFZ7bDS+A9C2KyPl5JqgTLfVpOS2B4YUw9kruVMuMDAf0DzXDHwSvpB?=
 =?us-ascii?Q?Te42fdzE2Kcz27/+AzpeEs4E9wWf/mn3LNhuQD976hiyl4FzTnO3rTwoaxM7?=
 =?us-ascii?Q?kHHaYyNiqUzKbCUpM9ClngZI9SfvSABKXQAUD3lmpWhHzyV8RWuEUj4CcrO0?=
 =?us-ascii?Q?yaM6PqGmRs89Fp/6Lchkw5gi6pkx83Xl5rrd5as614O9avIa9xdnpD0p0a5G?=
 =?us-ascii?Q?JkvrZqj9ohMUVRJzU20Qna7Vk9fYOw78u0Bz/iD1QcG/pte4HKRf7TwJ9sbk?=
 =?us-ascii?Q?53CxBrki8YJUsyvmPlJ9Ki7HTqGLJ86TxLAymsvAsDSbToLWMcF2qQSV66Y8?=
 =?us-ascii?Q?kp99OA0+Ae6FHsVwFByDrI47FLus4CE5iuOjl6pT98r2lPW61/+9DcsyoWmx?=
 =?us-ascii?Q?2b+48GaWqVrgCxbVrtd9cNUXsRjD7GA28EGj5IGLvUwagE11wh4ZP2AG0Hfp?=
 =?us-ascii?Q?+QgCc3cq+kwvEXxoySebr3csOubtlphkxhqj0vcuG+YLvwRnXWSIwk6NqT3A?=
 =?us-ascii?Q?So8W5auUSRnFsDgmEbA5abBhZgjaWqPFEkbhCs3sjjl619QQrhL6W14HlEXc?=
 =?us-ascii?Q?P4qa011QTLcq0afQF9tAODwdvrwc9f1lHrg4JUvo3BsRbGmY375qyhI8apUe?=
 =?us-ascii?Q?Co5r55pkj7XgFbqlbpkCL+pTK6ckB3ip6npvTIVCd+fia2+irxsWMf7ts5Ia?=
 =?us-ascii?Q?eFv8VTYUuI+VJPpgLLTN8LDMl5EB0HJwrddvrE2eiKpXavcANjuAxVW0731M?=
 =?us-ascii?Q?VE7wP6RqsjjtoCqV4luLafdBGy1agbmBKS0XeGp0gMGTPNrqaFn1+2bBUrbQ?=
 =?us-ascii?Q?sYzJFZtrTrpMDNHW5ZQZ6fi/+oSQfH0DlxZm8Wu+Q40ne5uou+kzS02HvGk1?=
 =?us-ascii?Q?t5cms2n/aGzjWbjtAPm/2VXW009eOlPpd5p0nhxjKgEZ3obj156ACjbniAkl?=
 =?us-ascii?Q?gKe72zBivLhtfnvhVIRoHJHUAqEqX4EpkMkzwbt2Mt6ndR6fBllW2+OsLiSl?=
 =?us-ascii?Q?90PAyojq1JdC3MDtbt6EccH80UHbm3pYx6ziedClXmdGuTulVLtMwRp82S1z?=
 =?us-ascii?Q?GIIGF4dnJFAtu8+Q+vFHqHhLTtafjcEIifzVz+/OXRCFk2S1f+bVE0eogNyU?=
 =?us-ascii?Q?QM5WZb5VHRD1ImU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4084.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gt1qQCesYXUv04MbMSsiNcFlgAxDdGuiDBCVoNeJAbcLnKbFEC+VeG5XJLqc?=
 =?us-ascii?Q?10iyRyk20LIaKKD9iVBDPl0gOWZvE/PPa1VEDRcHsrkV4UCuZ9fAoQcXjwjo?=
 =?us-ascii?Q?Jxm3q+7HJeBobDPyWPE8laJLPZtPGDiOOt2RsiwFM9Ek506hcc8acuxnRClf?=
 =?us-ascii?Q?YsmiFpp/luraVgraU8Mfp2/wxQ/VrYYsDr6Fzq4GM/elLk3TewcLQTIntzK/?=
 =?us-ascii?Q?NYkmu4ZRkWrD7SRP1jSERWtLgzSpwaKg4fCz1XZ0rH2qDbg9621QF9K9zPHi?=
 =?us-ascii?Q?X369K7zyeh7UTep016q3pReeureszMXaLArxS/GVHCFb6eDD5a/UscU1NdOE?=
 =?us-ascii?Q?K4SCByfqbRPxBwc9IFsz2ucA10jTo+zO5nMKyMpSH9wYDcFiJHFxFUxKkTtr?=
 =?us-ascii?Q?1N6ZLycURKZEWNATpomjsVYHZWkn/zJgYF+9UTd4buzuIwzNfwmTjl8n7gFv?=
 =?us-ascii?Q?0g7W4LI+LlOZ25TL5a6CPNueTBzHkHL4yiijmoVTNYsD7ZUkcnii/PnbmhnL?=
 =?us-ascii?Q?SLJCDlIW0naZZY9AvbQja3mq6GWtVG1zFtxDMCntbupy4ZQ9/YYTprf8nZYh?=
 =?us-ascii?Q?t3PXlZW3dJmeexUZ34j7WywTR0bfPAJoO3AuXO5VZtmYHoiBFNMfxIcfY46d?=
 =?us-ascii?Q?JrisFTl02EREuG5fDcwinPhtjWSHzSwcytaZCRS9bBWq0JuTqNExvMjGNLBL?=
 =?us-ascii?Q?nvth8Rd7INZO36SWxDtHuwxaEiNkaie1KCMl7vH3y6drwvEeBSoyg+2b7r8P?=
 =?us-ascii?Q?6iif3wmH3HQNTGPOZPl7X6U3z1PbADrG2nve4Se+i8N/DGeBfcWXA6QOerAs?=
 =?us-ascii?Q?anrFiELqmX1Kfx++0Vp6+6VfcuIB+l7UfzQ9Rtg+EsVIvy/PN8GNqLl9yaQZ?=
 =?us-ascii?Q?CWjpEgHNHWAjcJBiynC0AdHiai+T9jrCrOX5VJXDvPWLSLCaaCA6UC7/UdNr?=
 =?us-ascii?Q?dCWgOFDc4viHoevMZa5Jqao0xsfeqhbVVPTUSOgQkXGc7Npwsn+MeQtpVCQy?=
 =?us-ascii?Q?dInFmJMBoOuz1iTniRA13pBuhZPS/QgXLBF2KSyy/WEwC68+H8zKogNoAF0X?=
 =?us-ascii?Q?TUfHFk2KDx63pIun9t4V9xejzSpbMCPbsCCwzFpVgKoXIg2eo16twsqvV73l?=
 =?us-ascii?Q?f40KQ1bdMkci+XfuQucpgbaXqSG7mpKqoJYBNEL8r8EsrMSrXEvZnKPYQtLn?=
 =?us-ascii?Q?yeaBdgWRF3r5j4HA8fbsTb89mgdhRW+/KI39SGOS+79ftTwYvbszSnnZCiGI?=
 =?us-ascii?Q?LXPguITMFBpKdEXIzrflY9HUmqnTJQ2TtdlnwnHZ/UdLcaJPvmEGWoI5inLp?=
 =?us-ascii?Q?knUUChnETEjQyu048vMNmKAdIshLFDRouWEAbIzjkGlb37relL05+pPeC8HZ?=
 =?us-ascii?Q?pUHPI4sg/T+YQLZyETLFHw85gxg60kupSIb0kPjj5OuFrlaQ42UY8sIqlmg1?=
 =?us-ascii?Q?txzOtXGciG2dTlxF+oVL469sAIF1bGjIl27kOwuVIRmbf9MPV+pFev8Ftlqz?=
 =?us-ascii?Q?SULhnEUKTDBbQ6OCSNyr4oXwSAN2k8OdNMWGKYTN7WVZKGg7T55JXPsopcpl?=
 =?us-ascii?Q?/rPoG3XvmBRzj1+5Zxz8WpKsHnB7WrBFjKNZaBHp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0937aa3-8f98-4620-f451-08dd7eabbc54
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 19:03:42.0304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29nm2Qk23QtahPSemNLGAaYmozpucQwm57jLWWSWvJ3sCaGJ8XxaPiIDhYJo9FxeXYwXiamo81MtNMDDI3ZtQFjjjJeWfGnxTUlJzw/bsV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF50CBFF55F
X-Proofpoint-GUID: qAURr4VQYXyk5-jbEk2H1nIZOrd5AvGY
X-Proofpoint-ORIG-GUID: qAURr4VQYXyk5-jbEk2H1nIZOrd5AvGY
X-Authority-Analysis: v=2.4 cv=ecA9f6EH c=1 sm=1 tr=0 ts=6802a212 cx=c_pps
 a=hHPfuxNGWHHq0fQgDGst2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=WqWNMuYQ1R48OzgPkZcA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_07,2025-04-17_01,2024-11-22_01
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
> From: Nitin Saxena <nsaxena@marvell.com>
> Sent: Wednesday, April 9, 2025 7:26 PM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Pavan Nikhilesh
> Bhagavatula <pbhagavatula@marvell.com>; Robin Jarry
> <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>; Nitin Saxena
> <nsaxena16@gmail.com>
> Subject: [PATCH v5 1/2] node: add global node mbuf dynfield
>=20
> This patch defines rte_node specific dynamic field structure
> (rte_node_mbuf_dynfield_t)
>=20
> rte_node_mbuf_dynfield_t structure holds two types of fields
> - Persistent data fields which are preserved across graph walk.
>   Currently size of persistent data fields is zero.
> - Overloadable data fields which are used by any two adjacent nodes.
>   Same fields can be repurposed by any other adjacent nodes
>=20
> This dynfield can be also be used by out-of-tree nodes.
>=20
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> ---
>  doc/api/doxy-api-index.md              |   3 +-
>  doc/guides/rel_notes/release_25_07.rst |   6 ++
>  lib/node/meson.build                   |   2 +
>  lib/node/node_mbuf_dynfield.c          |  57 +++++++++++
>  lib/node/rte_node_mbuf_dynfield.h      | 132
> +++++++++++++++++++++++++
>  5 files changed, 199 insertions(+), 1 deletion(-)
>  create mode 100644 lib/node/node_mbuf_dynfield.c
>  create mode 100644 lib/node/rte_node_mbuf_dynfield.h
>=20
> diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
> index 5c425a2cb9..763cfb3f3c 100644
> --- a/doc/api/doxy-api-index.md
> +++ b/doc/api/doxy-api-index.md
> @@ -219,7 +219,8 @@ The public API headers are grouped by topics:
>      [ip4_node](@ref rte_node_ip4_api.h),
>      [ip6_node](@ref rte_node_ip6_api.h),
>      [udp4_input_node](@ref rte_node_udp4_input_api.h)
> -
> +  * graph_nodes_mbuf:
> +    [node_mbuf_dynfield](@ref rte_node_mbuf_dynfield.h)

Missing blank line here.

>  - **basic**:
>    [bitops](@ref rte_bitops.h),
>    [approx fraction](@ref rte_approx.h),
> diff --git a/doc/guides/rel_notes/release_25_07.rst
> b/doc/guides/rel_notes/release_25_07.rst
> index 093b85d206..2dc888e65d 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -55,6 +55,12 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> +* **Added rte_node specific global mbuf dynamic field.**
> +
> +  Instead each node registering mbuf dynamic field for its own purpose, =
a
> +  global structure is added which can be used/overloaded by all nodes
> +  (including out-of-tree nodes). This minimizes footprint of node specif=
ic
> mbuf
> +  dynamic field.
>=20
>  Removed Items
>  -------------
> diff --git a/lib/node/meson.build b/lib/node/meson.build
> index 0bed97a96c..152fe41129 100644
> --- a/lib/node/meson.build
> +++ b/lib/node/meson.build
> @@ -8,6 +8,7 @@ if is_windows
>  endif
>=20
>  sources =3D files(
> +        'node_mbuf_dynfield.c',
>          'ethdev_ctrl.c',
>          'ethdev_rx.c',
>          'ethdev_tx.c',
> @@ -30,6 +31,7 @@ headers =3D files(
>          'rte_node_ip4_api.h',
>          'rte_node_ip6_api.h',
>          'rte_node_udp4_input_api.h',
> +        'rte_node_mbuf_dynfield.h',
>  )
>=20
>  # Strict-aliasing rules are violated by uint8_t[] to context size casts.
> diff --git a/lib/node/node_mbuf_dynfield.c b/lib/node/node_mbuf_dynfield.=
c
> new file mode 100644
> index 0000000000..6005e72ed6
> --- /dev/null
> +++ b/lib/node/node_mbuf_dynfield.c
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +#include <rte_memzone.h>
> +#include <rte_node_mbuf_dynfield.h>
> +#include <node_private.h>
> +#include <eal_export.h>
> +
> +#define NODE_MBUF_DYNFIELD_MEMZONE_NAME
> "__rte_node_mbuf_dynfield"
> +
> +struct node_mbuf_dynfield_mz {
> +	int dynfield_offset;
> +};
> +
> +static const struct rte_mbuf_dynfield node_mbuf_dynfield_desc =3D {
> +	.name =3D "rte_node_mbuf_dynfield",
> +	.size =3D sizeof(rte_node_mbuf_dynfield_t),
> +	.align =3D alignof(rte_node_mbuf_dynfield_t),
> +};
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_mbuf_dynfield_register,
> 25.07);
> +int rte_node_mbuf_dynfield_register(void)
> +{
> +	struct node_mbuf_dynfield_mz *f =3D NULL;
> +	const struct rte_memzone *mz =3D NULL;
> +	int dyn_offset;
> +
> +	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) <
> RTE_NODE_MBUF_DYNFIELD_SIZE);
> +	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
> +			 RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
> +
> +	mz =3D
> rte_memzone_lookup(NODE_MBUF_DYNFIELD_MEMZONE_NAME);
> +
> +	if (!mz) {
> +		mz =3D
> rte_memzone_reserve_aligned(NODE_MBUF_DYNFIELD_MEMZONE_NAME,
> +						 sizeof(struct
> node_mbuf_dynfield_mz),
> +						 SOCKET_ID_ANY, 0,
> +						 RTE_CACHE_LINE_SIZE);
> +		if (!mz) {
> +			node_err("node_mbuf_dyn",
> "rte_memzone_reserve_aligned failed");
> +			return -1;

Please return proper error codes, or set rte_errno.

> +		}
> +		dyn_offset =3D
> rte_mbuf_dynfield_register(&node_mbuf_dynfield_desc);
> +		if (dyn_offset < 0) {
> +			node_err("node_mbuf_dyn",
> "rte_mbuf_dynfield_register failed");
> +			return -1;

Please return proper error codes, or set rte_errno.

> +		}
> +		f =3D (struct node_mbuf_dynfield_mz *)mz->addr;
> +		f->dynfield_offset =3D dyn_offset;
> +
> +		node_dbg("node_mbuf_dyn", "memzone: %s of size: %zu at
> offset : %d",
> +			 mz->name, mz->len, f->dynfield_offset);
> +	} else {
> +		f =3D (struct node_mbuf_dynfield_mz *)mz->addr;
> +	}
> +	return f->dynfield_offset;
> +}
> diff --git a/lib/node/rte_node_mbuf_dynfield.h
> b/lib/node/rte_node_mbuf_dynfield.h
> new file mode 100644
> index 0000000000..b5a3d6db3f
> --- /dev/null
> +++ b/lib/node/rte_node_mbuf_dynfield.h
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#ifndef _RTE_GRAPH_MBUF_DYNFIELD_H_
> +#define _RTE_GRAPH_MBUF_DYNFIELD_H_
> +
> +#include <rte_common.h>
> +#include <rte_mbuf.h>
> +#include <rte_mbuf_dyn.h>
> +
> +/**
> + * @file: rte_node_mbuf_dynfield.h
> + *

Please mark the file as experimental
i.e.,=20
 * @warning
 * @b EXPERIMENTAL:

> + * Defines rte_node specific mbuf dynamic field region
> [rte_node_mbuf_dynfield_t] which
> + * can used by both DPDK in-built and out-of-tree nodes for storing per-=
mbuf
> + * fields for graph walk
> + */
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/** Size of persistent mbuf fields */
> +#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE          (0)
> +/** Size of overloadable mbuf fields */
> +#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE        (8)
> +/** Size of node mbuf dynamic field */
> +#define RTE_NODE_MBUF_DYNFIELD_SIZE     \
> +	(RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE +
> RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE)

New line here.

> +/**
> + * Node mbuf overloadable data.
> + *
> + * Out-of-tree nodes can repurpose overloadable fields via
> + * rte_node_mbuf_overload_fields_get(mbuf). Overloadable fields are not
> + * preserved and typically can be used with-in two adjacent nodes in the
> graph.
> + */
> +typedef struct rte_node_mbuf_overload_fields {
> +	union {
> +		uint8_t
> data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
> +	};
> +} rte_node_mbuf_overload_fields_t;
> +
> +/**
> + * rte_node specific mbuf dynamic field structure
> [rte_node_mbuf_dynfield_t]
> + *
> + * It holds two types of fields:
> + * 1. Persistent fields: Fields which are preserved across nodes during =
graph
> walk.
> + *    - Eg: rx/tx interface etc
> + * 2. Overloadable fields: Fields which can be repurposed by two adjacen=
t
> nodes.
> + */
> +typedef struct rte_node_mbuf_dynfield {
> +	/**
> +	 * Persistent mbuf region across nodes in graph walk
> +	 *
> +	 * These fields are preserved across graph walk and can be accessed by
> +	 * rte_node_mbuf_dynfield_get() in fast path.
> +	 */
> +	union {
> +		uint8_t
> persistent_data[RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE];
> +	};
> +
> +	/**
> +	 * Overloadable mbuf fields across graph walk. Fields which can
> change
> +	 *
> +	 * Two adjacent nodes (producer, consumer) can use this memory
> region for
> +	 * sharing per-mbuf specific information. Once mbuf leaves a
> consumer node,
> +	 * this region can be repurposed by another sets of [producer,
> consumer] node.
> +	 *
> +	 * In fast path, this region can be accessed by
> rte_node_mbuf_overload_fields_get()
> +	 */
> +	rte_node_mbuf_overload_fields_t overloadable_data;
> +} rte_node_mbuf_dynfield_t;
> +
> +/**
> + * For a given mbuf and dynamic offset, return pointer to
> rte_node_mbuf_dynfield_t *
> + *
> + * @param m
> + *   Mbuf
> + * @param offset
> + *   Dynamic offset returned by @ref rte_node_mbuf_dynfield_register()

Missing return field in doxygen.

> + */
> +__rte_experimental
> +static __rte_always_inline rte_node_mbuf_dynfield_t *
> +rte_node_mbuf_dynfield_get(struct rte_mbuf *m, const int offset)
> +{
> +	return RTE_MBUF_DYNFIELD(m, offset, struct
> rte_node_mbuf_dynfield *);
> +}
> +
> +/**
> + * For a given mbuf and dynamic offset, return pointer to overloadable f=
ields
> + * Nodes can typecast returned pointer to reuse for their own purpose
> + *
> + * @param m
> + *   Mbuf
> + * @param offset
> + *   Dynamic offset returned by @ref rte_node_mbuf_dynfield_register()

Missing return field.

> + */
> +__rte_experimental
> +static __rte_always_inline rte_node_mbuf_overload_fields_t *
> +rte_node_mbuf_overload_fields_get(struct rte_mbuf *m, const int offset)
> +{
> +	struct rte_node_mbuf_dynfield *f =3D NULL;

rte_node_mbuf_dynfield_t

> +
> +	f =3D RTE_MBUF_DYNFIELD(m, offset, struct rte_node_mbuf_dynfield
> *);

rte_node_mbuf_dynfield_t

> +
> +	return &(f->overloadable_data);
> +}
> +
> +/**
> + *  Register rte_node specific common mbuf dynamic field region. Can be
> called
> + *  in rte_node_register()->init() function to save offset in node->ctx
> + *
> + *  In process() function, node->ctx can be passed to
> + *  - rte_node_mbuf_dynfield_get(mbuf, offset)
> + *  - rte_node_mbuf_overload_fields_get(mbuf, offset)
> + *
> + *  Can be called multiple times by any number of nodes in init() functi=
on.
> + *  - Very first call registers dynamic field and returns offset
> + *  - Subsequent calls return same offset
> + *
> + *  @return
> + *   -1 on error

< 0 on error.
Please return and document proper error codes.=20

> + *   dynamic field offset on success
> + */
> +__rte_experimental
> +int rte_node_mbuf_dynfield_register(void);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> --
> 2.43.0

