Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFA606A337
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=aRL/t0co
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8284340A81;
	Mon,  9 Nov 2026 20:51:26 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 7BC1840265
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:51:24 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HXku31270378 for <dev@dpdk.org>; Mon, 9 Nov 2026 11:51:22 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022119.outbound.protection.outlook.com [52.101.48.119])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hujp6rjp9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 09 Nov 2026 11:51:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvBWuFWDNAdnEFokkoDJCeXK7RID4acCqef9L7b5Z2JAM0+SiporCEdVSs9v3RjXc1YvuH7FQUY857hGHeRMFxZIY3MNqZkqcyfvyvQIANdr0pq67mzRPkCMJ8NqXoNXkUkKEqrs1fFKhfNIBVgmVSGsKB1R2H76GydlxPZSNOhd9S7ZjL7gxvp0b2nAswdTk6D4EmAa2KfzU7kPIaXZ4B1b099eQa9Q2SeYfpQI3TGAuvz8GwEH0ubPa/t/zcuiC3swfRSVar2Gu0udpmbstqSB62Hj0pvLLxCYywUjUW60peWQAFY1AYYW0naZitcq+M/+G5qXneINZcwPqj0xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OToT08Zbryt8Hzti/hpTJqNpdcXeuZbj312dS0kcre4=;
 b=FP47rT741roP3bO5lWCIDVK0OEK8zdpVqWkNr+8FKAhrbKl9kYrIPMS8SElOwhUBXH4hAx007BBd+RF3P3NIMBven7BPyW2xoNLIOv7+A5xDVQHXpgRPAtIwU4fGcITk8lLvSKDpwEfepkYHsI6UYkZN//9Kl7YyE0IM7sbagslJkDabr9NODZbVrcnwsoIM7ChkUUCLCogb00cvtLIn2th/cnTocs4IX9VFYBq6293Y5ussAMGheFFrwspsmHyBssVJ/G3lLDfRgOmINEHou7kE8TNx7DsaZEhyKswfUKBFUnvdCzBCamO5sLbwebcmEo93Hu2niRWV6Eks2HIG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OToT08Zbryt8Hzti/hpTJqNpdcXeuZbj312dS0kcre4=;
 b=aRL/t0coPDDSQr8h9JC6jWUdd7fBfkukaEczUVROztOwKwsfztFQn2Iy06XWcQz8LQiaD//A+yhr9OgaOetgpgbZorIKW/G0fSW7SdyPiQOaZvIJWjtUPxsFXM1to92MXZ9esh5zr2NScO2YeiX9bRv4TozW7xsd6Fc4Ypt0Rnk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB4552.namprd18.prod.outlook.com (2603:10b6:806:1e3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Mon, 9 Nov 2026 19:51:19 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:51:19 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] crypto/cnxk: changes to align with zuc256 v2 auth
Thread-Topic: [PATCH] crypto/cnxk: changes to align with zuc256 v2 auth
Thread-Index: AQHdYuNeqdRR7uIlqUiyoXemxT/hT7cdxcGAgAh7tRA=
Date: Mon, 9 Nov 2026 19:51:19 +0000
Message-ID: <CO6PR18MB4484750EEB87EAA0CD69974DD8732@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261023114050.2939835-1-nkaithakadan@marvell.com>
 <MW5PR18MB51768FC72DA623A72AB78F92A8682@MW5PR18MB5176.namprd18.prod.outlook.com>
In-Reply-To: <MW5PR18MB51768FC72DA623A72AB78F92A8682@MW5PR18MB5176.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB4552:EE_
x-ms-office365-filtering-correlation-id: 653f0bd1-b7cd-4b6b-6061-08df3e9ad30b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261028144727099003|261026121527099003|261026140227099003|261022105027099003|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: IAYXOJC5ElqIip23MFEDKw3xTWLuyZ3pncVibAO4R22RWE8Qa63r47gTRPoZMxuu3XZtP1EEYZrVcFY13MdbIstOECPpTk6nscwQ3yHPDQmLKglT47Mj6nk5YcAaejKp+4YOva0GZr9cuxfoBL8k5O2oXQX1j5KWk9yS6Fpjn04VeHxBzK8Uy/DU9EwX83Vj1aNBJ4dhcrxoixS+t56xzcZTjnK4v+s9jYS7kqe1fw/57T0c5mrDBrrg396eRFBieyfuIHtV0bUsbT53dpsHac4lNxglYzlFCaGkREK6OV0LYRECyysmkzfkSKMI23lyrlIWYyKAUM+B76E1KmAadek4odoOvQXh9BOLL/wdL05k+RYkzyFZ20P/OxjO0zAtIh4T6aBk5EUMHmHgmpgpnPdqPv5W+1yhES5e3A5DhhJZ0JbCRIdIneSjVDgK/d+6XD3VGc8vf9daOrnmrTsjD4+sLOymwUvf8IA9jpFFno/cJg3Y7HPTU2EyhVAKtogp+AE+nSRmmFVMVcvNwhFldwDsfi9Pg7PdIE3wMY9jvLWqG0FFJYPqY2noopFHnOqoNM4K112l3wFB34EWz8Jye1IQHbQgQQVXoyOTpvU+lBJqHZBhQb+EkW8uFy+poUHwKassT/4fAyD6KdrMRzkrg9FqG3qCEsdJrep9O9Obqx5p3LHCdLCE86/oo6g/5cCzc741BoL59EwCMMtznh4nMs181K8mIFJguRZviv++ehQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J6aiF/s4032eUEgR7EhEBnhNwVlJlMGywMOJPGJYE5a5GIYiZMAxR2JN6Z3/?=
 =?us-ascii?Q?9zmeBpruc0T52hqICI6NpGh3HAOk5SXn5e5eJk8AlBj1yHVTl8rCP777cWNc?=
 =?us-ascii?Q?UqU8MFHY6qxCb/p3NUIXQ2L2xwPUvfIUTRUsyeVbVdK9+U+wM3hhac/ZShEB?=
 =?us-ascii?Q?d8pGH8St+16aWpfZvIMHvS5llvvym+nGK5RJXURw2WufxfMR4Hg5KcKqoae+?=
 =?us-ascii?Q?ek8kFQ0IfVXzhRoaWj289wL5AWuzGY8IEOUywcmK6SxerWcSRgvU1meF+fdA?=
 =?us-ascii?Q?pFJBkKyKseOiCkwekmRESZmrWtSX/LRXEzLiMrykN5Xr7VnREXXk+owfyJRV?=
 =?us-ascii?Q?2v1B1zzLmI8T99o9opMJXfor6rpdU2Q1qAuspQroge9hq3tbg8HeZUD4NyGx?=
 =?us-ascii?Q?Sm6u26vQNiWgrnZK0+I0wCGL0jgmdvWYgwp6c203GrOvyMi/wzhL77uxnYV/?=
 =?us-ascii?Q?IykviM86UUvpWQlZqyP5cjUxpYkk/kz6ZNw1bJmfQnNIW6qtQXlr2heW9d7U?=
 =?us-ascii?Q?Eytc4ItZNmiSY+ygaPFQY7vk57XQFa+Lt7XPe+5EA3sRQh1m0sMovLq5Bpn4?=
 =?us-ascii?Q?55lOU5Kt0shBChTV4a3/y5dZUplieQVG1uf842tWTnliUrE/ORFcfmQALXmV?=
 =?us-ascii?Q?PIiKvj3Z9UpK0DnRLdflA9mFop5gq0P3qpmJd7wgMCXgMWoPkoEe+Zh6bbtT?=
 =?us-ascii?Q?HAL1kEmrmHhOCnlloAnXgKXmQ+fn51/xZTO/8wFc1CCfDM8IhpdN9nrC+Ajc?=
 =?us-ascii?Q?VxggW9DDahtL26atmbwAxvqmQPKCuGAdp7jXn4Mb/KNsiXOk/Ba4pwCicNiF?=
 =?us-ascii?Q?3H4gzxAaqcTfEFkKepEltC5RtqUV7S2BoBnV3KvnYl/Y7T0P/HtgEw/wPdbY?=
 =?us-ascii?Q?91a3Afx5b6koYVgfKqtKAcQGGIodqJSUt+TNHXE8EVk/ttz6xiEZNoOgksM/?=
 =?us-ascii?Q?t1DXYFbnOV/sr4d+kj40V/DMTeOor3wzNo3Yye0UhgIHfKubO6S/xfeNHG5S?=
 =?us-ascii?Q?9aQvxjOop456oStrugkNA8wTh0V5MmXSJGONh3s1/RvebTqFF3nqF7yQO3OA?=
 =?us-ascii?Q?boh0ic8hy8mlYOokFqJ/o972tyqfJ1QtLsuHwha1EO+ptHSSCA6Fnm2nC3CP?=
 =?us-ascii?Q?Rmx4qjNeRKj52QT+rIWgzG9uS1YDBR9hLbuR1bCPDemm3G8NMFJTlmk4j3kp?=
 =?us-ascii?Q?WFnabpM3F0cwwMIztBd1emOeqwNrRROv2jvRi8VakYsQy8dcVvKTaJabl/TA?=
 =?us-ascii?Q?KZm3nqWfnWmo9uTzILD6NQTNAKvxWPyMb9HyK5Bbk8Bq2qyq5yKTUWIeV5Pu?=
 =?us-ascii?Q?O6mSI0ORG3GxhLlNdu31cMmwFhHwAuc5xMP++DL5SaNQ5ywBuUulIeYvEeu3?=
 =?us-ascii?Q?Bn786unmPjMdmvzDsJZVW9WZ82ys34+1bTO1O63FdwEGjMHR7f6FLgSbK7KQ?=
 =?us-ascii?Q?utJuwvFrvFmflVeJDukLB+FrLC2Wzk3Ive9ThN39W+9wULFrx/qiHfKOTpCN?=
 =?us-ascii?Q?oo3UzUSYCuEBW2fA5sd2S58p2t0tEwV5BQTapMo8TjCfJeGyR+8REhluHQSe?=
 =?us-ascii?Q?APr4/w0n581nsLeO8TS6ffWhPQzEsA2ZYVToGYS4iffo5/x8L5/g+7uM4zHZ?=
 =?us-ascii?Q?/m68ptO6/9N7znSmBcHPkznv724oewPRVoSvuEhM83oERfIi9xZU2gWy2acz?=
 =?us-ascii?Q?eMTeb6lyC99e0dsp8Wzgo9EXKbh05jv1DwqWE4PC3TCwmRWd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q63WjCwsdtVu8f8F93kGso4Em/aSvaU8dTUCLoBKtOHnywCrh6rtJkD96MF7mJ1X8Bfxm9IAjyHWXqqg3M194N9UFr/jHQQ00xa4SLFFi99P3buGUP1rkORA0j28X7+MfJvDKke+e9PmeImHig2hkXkXHg/rUiChdCpP4pahmi0eT1R2MlnbjRaIHqbnbnYU/8acjaFZkJia7jPNh/gt7WPv0dO+G434jrwq2G7Uyhj4EtIoklnX4JiPlCfeE96ijQ+TZZYLKSVnZ35O2+8Ld6FXzBDXMLNzk/qnF0JQI/CK7SZgoksiGyjFY72eHroOSm7gmxst8aXx5wQgI27XfA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653f0bd1-b7cd-4b6b-6061-08df3e9ad30b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 19:51:19.6253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQ6LH1eFPVCnrS3XEr2Y8vHxnwZvkcXzxS3EyvXK3pKMpQL4MFTwLxm4Ufgjj03shHLJ3RX+PqV9clJiYnfCNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4552
X-Authority-Analysis: v=2.4 cv=d85gWhjE c=1 sm=1 tr=0 ts=6af2243a cx=c_pps
 a=xSzMZOIKDOBgwsc4tMfFrQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=10mPGaNrhC9U447ylEQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: cfcFd4OLn4fcQLrulQKPOTz6hN8GnElz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX4g2CHECA0lJj
 bdnQb9cGDeWvh0I9gywVd9OSwFXFPFclWoPM454TpoVESMeFa1TPUYk70MIwvae6wJwyxuuz9/t
 qkqIWHhsZ+J7ZUxr+be3P2GCkRn/lX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX5DiOX372U0uc
 KFRViuQ3Br0lrPMhh6wBZSD3xlx+bAc9cHpIMitMI+8XijAeIgkWUw1q/XaboGhjqj4/LkPwTOj
 2x1jodTz+BPtZGbL5r9A7QNAUdL5gcnVqGvoJ3vAFpzNzbhX2z4vz9bSEhxhYlxOhFYxPUdQvWq
 wIgVAjmKQORspzLJXHEhpz1669LtPYj2ixcXyYzH/tU0PpAWdFk7MqbjolgED3CSyduSg5NPZD6
 Gvcx8wLFeAMa3PGnQJ5bLg4TbxIdg7VttEPW+BrsKIxTkmA4MXQeviZqOxspiWg9Tfkg+sjJQIl
 o7NHlRM0n7Dq8ESBdyniZXgC2ZWtRgxU9/9Fm0ugPbSo2y+nrjcIjm4xWFJz3w9iT+tY4PUFNbe
 nhjf1BhvFfFZMrqNyR8VHThNRCDYo3ArTwmdfXPddAB29dLYXN9TJHSFMkBESon7m10WpTtrnpf
 q5OJDKnt0fdYW/r40cw==
X-Proofpoint-GUID: cfcFd4OLn4fcQLrulQKPOTz6hN8GnElz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
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

> Acked-by: Tejasree Kondoj <ktejasree@marvell.com>
>=20
> > -----Original Message-----
> > From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
> > Sent: Friday, October 23, 2026 5:11 PM
> > To: Akhil Goyal <gakhil@marvell.com>
> > Cc: Anoob Joseph <anoobj@marvell.com>; Vidya Sagar Velumuri
> > <vvelumuri@marvell.com>; Tejasree Kondoj <ktejasree@marvell.com>;
> > dev@dpdk.org
> > Subject: [PATCH] crypto/cnxk: changes to align with zuc256 v2 auth
> >
> > This patch add changes to align with ZUC 256 V2 authentication microcod=
e
> > support.
> >
> > Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Applied to dpdk-next-crypto
Thanks.
