Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E609C02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 12:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B7E8402CE;
	Thu,  6 Feb 2025 13:36:19 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5F06B4026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 13:36:18 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516CCGoY026529
 for <dev@dpdk.org>; Thu, 6 Feb 2025 04:36:17 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44mvvpg100-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 06 Feb 2025 04:36:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smnVc0fvEMqJm6GP8t2iTsg7bG9+2PXv1oQ8pugCkzCf1UevcJRoAlsKhxK1b9SfR5gmQrca9Bcb0RhMmIhxY8orScT7LwHwOK7oZrFPChRFI3tkGB5m1QCB/yzxO/djkfgG8tfksuf2o7eqeeXb2ZoLEmf/ZwqheubuttU9aNU3xTxmhsihugZA8ZHI+yAjNHtFxxiGltsrYE49M8UGxTlZbz9hdV8rCP6qTbEnIxKVgEj/E7Ue3Kaeg5ENvxPCHKLe9B0y+GNXb5zL9jsbcni3Wab0d4ILO6wpBUEsCUsbxy0hlFbJSeusHCoAo5rea08dEN02ze6T6wTx0hyYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXeqdsmnr2j7qs4V1331DD/vUU1CGqoLIHGVyDbL1Go=;
 b=QX45j+ZSiX0utXt+AxoWMvFk3dOGnytPUnP6FqRyjhAsLjcpJbAh+GJ4xMpE5HEx5/3y8nC+4mt8ReuCG2aEvHRAru+oFfeo1X/8001Ct20YL+d82jpk7TGQeYW2lrWIMAvOLiXiwGPmNYAK9YtdGZFvEqU40FGS4MCdaGt6BtzGTlulcowoKgUrCUHTmBbgs7bFL/FNeVoZDAD4Oreputt2lExaLKk2gP/mqRAQNQ7kptLWAAFTQ9NID2sT0BdLHWOP0jTXURg7y07tKPiatCbPiqGhq0iFCsWwZX2exhFQHhtUdnqO6rEtLCyrnejTdQRn19P7A3/X0cmQmWrPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXeqdsmnr2j7qs4V1331DD/vUU1CGqoLIHGVyDbL1Go=;
 b=WpeUmbYKAmhwctIG1rHCAr7lI+zxDRBHXplyOyYwf3j43IAFUSyZL+oLGIJK52Dhunj3SeGIr2Bak6ySjnva7PakTa7JeRizrrOCsExgdEQym8e7BXlDNQ6OQqCqwlED+ve6YirTwnKYMbtUjsowt55HYmpDIE6YdMoSBV9pxtc=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY1PR18MB6041.namprd18.prod.outlook.com (2603:10b6:a03:4b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 12:36:14 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 12:36:14 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] test/security: check MACSEC offload before configuration
Thread-Topic: [PATCH] test/security: check MACSEC offload before configuration
Thread-Index: AQHbboz3qgZ3IjXN7ke02Yxv9t2PdbM6SjwA
Date: Thu, 6 Feb 2025 12:36:14 +0000
Message-ID: <CO6PR18MB44845A88D971937601CDEB45D8F62@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250124182235.3587648-1-gakhil@marvell.com>
In-Reply-To: <20250124182235.3587648-1-gakhil@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY1PR18MB6041:EE_
x-ms-office365-filtering-correlation-id: 96b6ee95-1e06-4853-2132-08dd46aad865
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GvMHoU4xaEbkOw5K6gUgmEmTH2MJdJZrRQgGKuyyzszvRcBVbL/Rt4ZS0715?=
 =?us-ascii?Q?KLZsgy3rhfBT+oTO9Gd2XYoC8Lak79nMt5MntaaE8xvo9V9kBFgVZhEgb4Bi?=
 =?us-ascii?Q?BnMQh0Oce/NXmMrro1RbvE1muIQUQqPA3TxKNtHTI0I7mZug2/y4bj7GioHS?=
 =?us-ascii?Q?LSsuNus5qMEVsKEeRB4tXXaHia94iM1BBFV8aAKxBH76GV908u086sHpSi7q?=
 =?us-ascii?Q?PXQT7umz8t04vex/q9seCUkj4TZhSxBcsBziqXHr24iEQchM35jmrL4ZUXVP?=
 =?us-ascii?Q?oGCpZxC2VFlT31gXtNoiFh8aiUslnAlO6pszpE7UlpxLqsEewBn/bwrfUJR/?=
 =?us-ascii?Q?w80W/yCjTENvlFDmm7onDpnYQ5w4Xe3qsfnAelSXGhrCopIEjIeMKI1UKtos?=
 =?us-ascii?Q?UMQjiOdRcyohUZDwI+7k42uL+gj5bwN9epl/hmdzLEmbiXOGcZt2x+0H7gKf?=
 =?us-ascii?Q?i1NXoX+tODLY+M6EUgJ2+m88DDMFJKwWCBFrX0XHaFBzFe1PYGpCK/I+qzMI?=
 =?us-ascii?Q?hQUFxdS4uN44qgZ+ko7Q8OqgZKU5FThhxRdxwhOnuckPx8FPi2o0Pd0dWHxo?=
 =?us-ascii?Q?G7SdZxiahvPp31sQt1L/26xwwEXUVIhL4FOSc1Bdvh8gfGM9gGV59GI7lQT6?=
 =?us-ascii?Q?p3nTmDnn6dOcsQNC08rdMgXbPXMuCuXopHKmpGMettltxauUgUiJqjHDjQlU?=
 =?us-ascii?Q?IMehYEhc0MiS0o3ikn8tOlskvqP6qUxF1ESpbX6sdBON6ootY2JVr89WVceC?=
 =?us-ascii?Q?REWS/hDWsr0tcRCD9NUVhELI1CtHqMaRr5HAAUCc763w0dZIfjI1SjE35gk0?=
 =?us-ascii?Q?g7PLO+yt3HxeZKN9OvYYRbjMDcRh86/lHAy3uuteZCsgJtQXC7Q7cV8c3i5u?=
 =?us-ascii?Q?gBzWyTsPEfUMyP4CLq2Sffsnm1ofEy8k6JenJqqh5J9QlpZvad0jMk2ZdbhR?=
 =?us-ascii?Q?7pvGcrWiFHSMTKqHiWtsvzQ47yzUaGoDbAWnGUXaFZ7YdOZ8wptrVspaebYM?=
 =?us-ascii?Q?yG2pZw2pl9FgJW2gKZ9V2dabjxEVDVKc2tBH6yFNZLGxGWuBgrclJ9UhC6HV?=
 =?us-ascii?Q?Df39o/xRKKRuDD/eg9aV1XEX3kLy92asuTiHeIniOz+7hN65O4sB8s+AfSHM?=
 =?us-ascii?Q?AOf57kxFAWYX+B1OKh3QK8+ai1uGtm7d0elRowWTz6NLPZGwcBQvJF6FA0qa?=
 =?us-ascii?Q?x3DIJTVhT19C690ppuSKvweLkbNOqnGPexf+88GinUfVR0UJCn03gugtKoNA?=
 =?us-ascii?Q?xbTnBsEBBHiruAiCPWqjCGnAuEoyt4xKjIAJQfmZb7/p7ng5MmCeQ86+DIge?=
 =?us-ascii?Q?jZrBSuiaYI+Tlnj61YXD5EpISG9asrK8YrSfe55yxwpj0jv6ZbCfZn5AUHCu?=
 =?us-ascii?Q?ZEdTvpSpob138RefaXUYM8xMc2jICiXuR3K91c/5Oy0f5Jj6GOjWWYkPjvYP?=
 =?us-ascii?Q?RqB9bARgczLTxns51CUIPa5LUEL30++a?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9wGFgy3fNsCHv8MEpvSKjNRUNH9yCCYI6FAxhkk7vPfKLSVILcrIbiQSKg1M?=
 =?us-ascii?Q?QnsBczKNB2hUbr7We1boaSxwrhxGxoJ274N9EsSQBOw+c/QwJo8VPs4tXNsk?=
 =?us-ascii?Q?aRd4mcw7mmip1pQrKJ+taIgVa6FUxjx0uFQi3kONU3SElwxmyhuVAARkyeMW?=
 =?us-ascii?Q?n/U1igPivPp+hiPCepDeCPctKYPCaH/btaFjkiQEqOsTl0bqa1y9CbfzLEc9?=
 =?us-ascii?Q?IS+YoV3XX7DCfcSVTmhxjqsvWBShNwGcjQOi4hqesl3qLLAN9/mu7+0WtBnf?=
 =?us-ascii?Q?YnL949bxV8aVgRMfYE9K8EmDBdgYgI/rnjBrrv5FHNvZnMv0MNs4GAGK8naW?=
 =?us-ascii?Q?EsO0iyZ3Y2G06NYMEhjikyJCr6qie/5+FvVQITOR6DYm+4JDER76zZ/xk6e0?=
 =?us-ascii?Q?Og9jBCMTT4wS5CgAG+B6oyybRatenYneIeRahcvfG18SGnSB7PXNHoQs1be0?=
 =?us-ascii?Q?I5DktsNayfrJlSwggDbQzbL+rjJoPa096n36DApRnVCeXNLWoCOnmJCxwnX+?=
 =?us-ascii?Q?GAZ4acbXgYtAnesrn+yzF6gJLhTme7BfMOnpy2VaqA4edkDF6viLGtHcvGsk?=
 =?us-ascii?Q?5LL9EiExNGEsOPf5IHwjyAf4riWjGxGNDBbBNRWpf9tZQDCNP2k6eQzkAsiF?=
 =?us-ascii?Q?Z1PLVdF/Aybf6FS73QbZ+ZAUH7QHhDNgyPv5q+Nz4M2vcfKWM5e5PQxF+m7b?=
 =?us-ascii?Q?QaWLTK+MuRY5PaQPDw1GCCpp/9Rv5Pau+phMdQt4P8T7bM/RzIhkjDKlcP38?=
 =?us-ascii?Q?FwECrTuGbZlLSCAdV6+6BZVdr0LKClwH1iWQ+jPL+UMw/T3vvNCI9WBi7WJe?=
 =?us-ascii?Q?SJiCOIHUlFV6XS73919RFN3ujLdIMGaKpAPMpkGL/LOBHZVTofa/f/YZKcDw?=
 =?us-ascii?Q?PqOPj6HtelRor5ZHaOy39rVZ3tHU/Cci26tCvD6795PoVaGZbakhhRv52a21?=
 =?us-ascii?Q?lrSyZAS5nJXWhdZMt4rXh4B4pgKif3eDTOw5+1vB4shBqIPOPkbHcDxk8Gwm?=
 =?us-ascii?Q?9prqEHYusESxzi3q7TWyyLZXGHRLMPklqcpAuAQqpCgUim5JGa1OXst5PZMG?=
 =?us-ascii?Q?vn/Tvc2RRtQzCogC/sYbtNxiyFNfDDJ0Z8SwrAZqv/6VzVGcDO7sQDcsN4m9?=
 =?us-ascii?Q?9a7mgXvFfBzoIeS62tw0VFfYX7U0D/Zs4cJKnTkC6IqYbNbZ3wTEvoViVgJ4?=
 =?us-ascii?Q?xsXqc+1Jsj2LABZxsLE9XO5E1UtMIReKCvqv2u/ja/6DEAVWbKcJW8W7r9DT?=
 =?us-ascii?Q?Jp3xni5jT+Kec/DN81n/ti/oaW0zCUSYyBDx1sUmPD+bHvvGKeAS+zTpTfdN?=
 =?us-ascii?Q?41fGaSkTXP7+inwZLEo9M0vpY2UPG4ZoPF6iMvtmvUUESGlwBP1GY3C3V6qV?=
 =?us-ascii?Q?RxpeHTnfLqyckbGNR1mmdqcnQZiQ/bmJM45CsPmhcFgkkrsniRwXY9UtB1nd?=
 =?us-ascii?Q?3Y8NtYm2je42HIoVF1oLav8EU4QdQgkEqzrluqQm/eR3lzvCCn3lCZ+/zy/n?=
 =?us-ascii?Q?BJIBNaveUPIq/uJ8RwzUY35UM35vwqeFvL59YIEFY319d750HJSVtuKR6XQ/?=
 =?us-ascii?Q?UJa2CtnSt9mcAZW6fxXZLWGTRDFzuV+Rmk0rIkv9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b6ee95-1e06-4853-2132-08dd46aad865
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:36:14.4839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqm/Icdrvrjme0yL7u1Pmu5ME10SlJOqzPEkVNPBf5SXk7BsO9sIFffUic+RqWEK744CD8a/Ys0UUdvndLnNBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6041
X-Proofpoint-GUID: J0mJ-O4zJh5IKlhvDG_LInteHNgcONYp
X-Proofpoint-ORIG-GUID: J0mJ-O4zJh5IKlhvDG_LInteHNgcONYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
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
> From: Akhil Goyal <gakhil@marvell.com>
> Sent: Friday, January 24, 2025 11:53 PM
> To: dev@dpdk.org
> Cc: Akhil Goyal <gakhil@marvell.com>
> Subject: [PATCH] test/security: check MACSEC offload before configuration
>=20
> rte_ethdev_dev_configure need application to check the
> device info if the offload flags are supported or not.
> Added check to verify MACsec is supported before configuring
> ethernet inline device.
>=20
> Signed-off-by: Akhil Goyal <gakhil@marvell.com>
Applied to dpdk-next-crypto
