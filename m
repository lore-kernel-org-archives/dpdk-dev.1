Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4D2CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 18:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2C36402A2;
	Tue, 29 Sep 2026 20:21:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 972C44026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 20:21:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THcbV6292826; Tue, 29 Sep 2026 11:21:52 -0700
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021139.outbound.protection.outlook.com [52.101.52.139])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gymvs80ju-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 11:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGSdntC/EI/yk4AkePGgr+W+L5hb9w4lCpeAMBXeGIms98kvypsq/KNECB0/jU9Wv61KHYuNNyqyWLtl0B/5MZj2gCjGv3rNJBOZNP/478aMsOPbJhMYZJ3KF2FX5UqsdWZdkKb62YYKvhomHSwTXl9dDsTLEMz4moM+uy4l9EhvIABJkQV97X/+Azjce+KOBCxmVqXldHmrpnd48ubx4/qrOBzkHEYKapuC1x4Tamtv0f97oMX3xTZ9ZLSbqVPjbxsFMr04Ah2iSHBUhRsVE2CN2t6PmcxtDtOCs9tDDhmlKOm1fW054Z9lt14J5BnkHNbYhAABmkrLD1VyBV6/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUqxUJ67D/J1DgoiIJBq4Pp8LJG1CKAjU2Jeb6xAAHA=;
 b=RZf3OHb/n7mniOWK6ue0Ag0R6N7uNKA0gOuHLhMWbCDCLFZ08YkWc0gQvu/XAIeJGgU+9Ahs/vJntA52ZFiyFLlNC++q/hfDIKk2SZfiVPB/ktKr9b4UiFiSnN4LaK7sk6cU365VStEi2E9M2t0ko41PAF4Zmh0YeAKlxHdttMLf60xeUUGh2o+AVuJUz6rAykwICk/fd9pVm/cRSN5Sr3IHEgqUAipiZqXe0b2uXkR8n1eaLM1w9rETwDCPyreabgNZr+lL2GmuBfE4nzco309HndCoMkk+kLxYSSxZ6ySlO3YfJ72EeCfbKzZXMBG+klfg+MInGVEHYpTMRKd7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUqxUJ67D/J1DgoiIJBq4Pp8LJG1CKAjU2Jeb6xAAHA=;
 b=nFSYSzW3Nuh+t7SlHVs6fZzsutS/Zvmtzb7r10i+K9FyiyyPf5xyWdY/zyurxCcMlG3fU/Fmr51hO32Ji4D09kwfM7zX7uVQ8zosZ0jEey8m0WbnJ4uRCeWcMK3bgye2EpHjoSrSEPmZpIYdSVwLpF4PTIurTK6K29xJSLG6RV4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB988463.namprd18.prod.outlook.com (2603:10b6:806:523::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 18:21:47 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:21:47 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Topic: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Index: AQHdS2zyS5RF8y84q0yzRR0X7h1hNrbdy+1AgAAIWYCAADCr8IABewwAgAZDroCAACI1YA==
Date: Tue, 29 Sep 2026 18:21:47 +0000
Message-ID: <CO6PR18MB4484951F385FC621B350D0B5D88C2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260923105003.2811322-1-kai.ji@intel.com>
 <LV2PR11MB6045AC38B49432A2FEA9C20281812@LV2PR11MB6045.namprd11.prod.outlook.com>
 <CO6PR18MB4484077A45CBFCF6CB562E20D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
 <Uoji51ajRt-6kVG_ZXgD_Q@monjalon.net>
 <LV2PR11MB604567127AA4D4D950804D13818C2@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB604567127AA4D4D950804D13818C2@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB988463:EE_
x-ms-office365-filtering-correlation-id: 86fb3f08-4a22-45d8-0156-08df1e5685f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: EGjK/z9Tb1f49e/NrdYlkFY/4F6W+wzkC22XTo3VH7nWRy06QdtteFDYgBP+I5UPK5TfSkMakjAo9kNsVRhtmoh7c4oXl/XwuY8jPnMTxW0n3Kzhi4CmC+6Mw79VFft/KjRCgxMqIdbBm55LSFXhcOQE9Q6aJAqyd6yumGGdLoR23ak3Qvvzny5gS9gZK+Egtf+L0QJDRnOgb7vr2mKEbB62b10axDrsk0+M6uCvNSac2MZvOQo6Rx9Y34JeWdUSdxbWrWJKcXut8C5DZs9o+yYXQ3IYn2oxV+/WemiuOa6k3JlO6zDh3rYdPQHbhph185uKIAHgznYZLA7cCra7I/VnTVvNLgBQjwDJN8aKLxWktVJHFhCZKQvJ1vg6s2YG93A9Btn4wgAJgc4M/eeVMGKJsjOw9aU8IrrJIsQBCYsmzytkwYSjkUhqZnY/MYHbf1LujTShvtJN/U7cp7/pEWeYo87gNLYmjna1ocAQrDf2mX6NpKopId1/b0E08ZItucGZMajtKYTCTuzSIbvEUeiLdEn+/pAWxScX/xa/K4X/fcKSaDEmKkHKMfryTtxDrG93zJl2KFoesmig0Ig3DQahC7dJXaU+5/gvPseKqwzVWbZo0IWgrTTXx5hlYESA6tiRiO9ZR5HYa4rtelSwG7azb5W9f/4Da6Q9/fxHZGIASmzZF7ipn5sNgdMQYedFBukGBbxg0+tyfs5DZ3xtVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gxS6NNGZqoHhln2n8ePmFKgwrFJmQ3ceeCX3M/o7d33jkLPsBj4uodVXjtU7?=
 =?us-ascii?Q?VHKMz/9XBePdcOVHmzud32WQrrUfCToT8rIRR/VLMlSSK4imx2fuzgIQjJgP?=
 =?us-ascii?Q?hBxsVx7oOnsvyMfzvpWDs/LaNE/unHJaNLduhceJERSWL1oLT9P8hvf1zP38?=
 =?us-ascii?Q?U9dd8+S+fIBfobxN/5zf5ZB9hO/T/p8H7Ry8hTPF6H1hc2NE3l3UrwWIs67q?=
 =?us-ascii?Q?UuqC1aoRZ4gOJkgSTEVlz+Pa/CsVGi4lxjVkaUVDRwJs/HD/88T279sdnLcN?=
 =?us-ascii?Q?j5EhlffkKuQNazuqG+dzi0brBU7C+13usGV0xfhbb/Uotukh0neRc3Yz56dw?=
 =?us-ascii?Q?9zb5eM/kbaeY9XZo13MJc6MG8wcTsPih5H5GpDQ2FVXcZjx2cTksew7KTxLF?=
 =?us-ascii?Q?4olwhp5J+LChOv+COkS3xB9sf8GvKnhLv+IHrnHMOkr1z/NvGEzYOZWw417E?=
 =?us-ascii?Q?U2kBwW/QBkEsr8x1el7vodsehI5huCOdqnoJ84GWpPU2hOwjgSWfzFuCpT9+?=
 =?us-ascii?Q?Ucha6UdVBBhH5V1jHfh7S+/48vH5eQV5Xlvt6DexCwY/BXURhJ6eLMEs/prI?=
 =?us-ascii?Q?T/9UmEPa/X4A8nP0jmamKKnKZ+u5KL3lFEDWZJvJt/7EHvIU/3YHxPv+TG7N?=
 =?us-ascii?Q?MNckIyWZgTSLWW0hVqeuKFao0CW6JNACkemzABMoIZ0T2t2hv0zIambNjc42?=
 =?us-ascii?Q?NzFzGTlD6Mvt0V2kgqF20T1BMHnYlYeOJ8LmUXABmOjXULXxQcHgY0Jl61AD?=
 =?us-ascii?Q?UztAaqXDYXEEkiKpP+VwlP3KsznJ7QnRB/7SRxYwz3FMwLZo4ywrvJIutquu?=
 =?us-ascii?Q?o2puGB/aKH4W+DAP7urbmKeuRcXXkEhnt9Ik+vvTEBmHYiFgjfiZTzS36w6k?=
 =?us-ascii?Q?TvUKt46J2hHcTSw9G+YMKaq4SFIc2hfQ4RiO3y1+C4DAApZdZB5Bnz+iWYNO?=
 =?us-ascii?Q?2FLfysqBjV1NcIBwYTp5iIUqaOijUyenjubvF35SEUNCVEskkjV+zYBHkV3X?=
 =?us-ascii?Q?QeJapnFv5hgC5TS7SE9vWt9H1ZbcbZfbbNCFrIMLTcHFZkYfVRkReKyTQo7W?=
 =?us-ascii?Q?RiVL4PXPHvKcQmtsfeHpAhl6AeSpJxS2RC2M5eAQZiIjNgybIBx1AR4k8IHQ?=
 =?us-ascii?Q?4uoqf/jbRPMB5BuLKWROqKrfZPBIhylfqVbWiq90+q4PsP2q1FhW9DDZNstk?=
 =?us-ascii?Q?NiGrQ+HVJnv5OAYBb89g3n8SR4775MusDoTKJHnbYlZKL4npz5Ae6t7hlFBK?=
 =?us-ascii?Q?sRIhrfh7BLUaw85ZHBvawXNwu8sI2ErIVTWnQUWjQyNu/he457RUuP/C52k4?=
 =?us-ascii?Q?VInEdMexL9hWvcJwhy+zi7XtPhyCZvbGGaxhM8u67ESFNAW3KpjmGQgUfHXD?=
 =?us-ascii?Q?I3pzYg0P9vBHNmn2M9yleqaUYV2dMK+m4MBwlJNxQ6xlboiwec8Hgwg4Zjd7?=
 =?us-ascii?Q?lgHvSfalQxfPCxjuXFAfdZlZpQpHCWcNc3ZTz5Lf/Wk9aRp+U5HXhV7WVRxX?=
 =?us-ascii?Q?SxuB4RIXMtMYMOoiHrLxmMKgbhXVZf/UnfBc7HlPbrWvmHbaxE+9xV51OWFf?=
 =?us-ascii?Q?lN/4xtXw4IMGw7xetFY9J0wj3ceOIk0BYrWoC7onJ0dtXnYYY/Sga8OLpHgh?=
 =?us-ascii?Q?3e8MuOmeZIHI5KbpZSN2cts/q7EMmFnwtskkdPLd9hQIT/QSsAwyirSEZgpf?=
 =?us-ascii?Q?r77kcMXrOlm1JziUDxsY3GN9QF9aVvATH347HtQKtfmBmnFO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C2eAOsB78Ac9dJdnn6v8stAdRQTzAqoYCECxQ8IOahC1l408Y/ykSsOnLD/Vy+FWSovw2/uaIdJTOlxozbviPLt+lNvl8C4DKGUoFVSk+2IksTWbSUVM3LJ4cXFWgWBNeUfNYCS+kmhzpdwPZOBRprf9VlrxaAyvDynNWFa59UtCvLwl6LeAl50iQdDFGahYF0qhUlFvPXJzTmgzga6c/8i7m3CQ808nDAZ4WchbhJsRPwK5Vno9IzkdIdn2bInpzKsq4tsuuvqp4zgXBj7UQfLJ9iuaIm2Ad3wQP22/W4CZF3E/cTqSjEEoK3Xe0GI22TeepCcxGoiKN/wR5uAClQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fb3f08-4a22-45d8-0156-08df1e5685f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 18:21:47.3014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v302wspZHn4/4EZSe5R4Clj7W4jWUC7Ugl9ivbbiXYD2/RIBPCmjVCOwNPjkcZf9arXuzXOidoMLgMXJP0md9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB988463
X-Proofpoint-GUID: HFt8eKjdkSTEdyTk0d1FOqvI6dP9Sdht
X-Proofpoint-ORIG-GUID: HFt8eKjdkSTEdyTk0d1FOqvI6dP9Sdht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MiBTYWx0ZWRfX0YA4Y6nuvXHq
 RdbsTOrlqUGDYCjLokK/BqJKHcvRupLqEIdWa4/v0o6LssV3lDL/7F7FZA0Yu/t1983Z9MTKFvb
 WTT2NIY1/6h2mfw4nGA9+phfcaHMJ0279lAroyP+fzsZxxOIl5IQzm6HGn6gL38+wHGZQSzNrUR
 OFoC4nhbgnV6spwucnVm6njh1SP8BU4WIknawZE0SQqUdEaVQImZSH57LRDNuPkVE1K0HPqwc0c
 2hKzk0JmIAD78uUIYJZpD9InBEdUIj6c+e4wMmZIZ19rsRtRQwpiTv63Tj2eq1PIHcKzp5coZGX
 5FMgEV4EgD5vSdK6SUm1qbgj/x4RhLD2EJqINc2tqr8nT9z2Y68sYUkN+8axpTlapwjhRu+iK8+
 gR4R7/o2rdbLlV7erffGjBGaEpOkI2QYXEvds1fZu53iQf0OW1DQM+4RfB9cLf1labVtWH6ktCw
 tmhPhXE0X7rg5Vcm2/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MiBTYWx0ZWRfX44GQ1YRp8ERw
 W3gjHnCSVMWUzMgk9bmW0p/gi8oZsPg+2XztKwrqIhs1RLxZVda/5Oad221YaBOirawgio6c5RI
 dDcN/atqL1ogHcBQ3t5PF5i87wGRN8s=
X-Authority-Analysis: v=2.4 cv=JuxkP84C c=1 sm=1 tr=0 ts=6abc01bf cx=c_pps
 a=Wom93TYtTqcYiR1jdFbvTQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=3jpsHq_iuZqLwE1WVccA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
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

> I agree that a single validation framework would make cryptodev validatio=
n easier
> to discover, document, and maintain, and could eventually allow some comm=
on
> setup and reporting infrastructure to be shared.
> That said, the overlap between the two applications is primarily at the c=
ryptodev
> API level. Their core purposes are quite different. The FIPS validation a=
pplication is
> focused on CAVP/ACVP workflows, including request/response processing and
> conformance testing, whereas Wycheproof is built around externally mainta=
ined
> JSON test suites with valid/invalid/acceptable result classifications and=
 different
> requirements for asymmetric devices.
> While there may be opportunities for code reuse in the future, merging th=
em
> today would likely introduce additional dispatcher and lifecycle complexi=
ty with
> limited immediate benefit. It could also blur the distinction between Wyc=
heproof
> robustness testing and FIPS conformance validation.
> My preference would be to keep them as separate applications for now and
> revisit consolidation if we identify a meaningful amount of shared infras=
tructure.

The idea is not about code reuse.. But it is to limit the number of example=
 applications.
For crypto validation we already have fips_validation as well as dpdk-test.
If we move this new app under a folder examples/crypto_validation along wit=
h fips_validation,
it will make more sense like multi_process example.

We cannot just keep on adding new examples for every new way of crypto vali=
dation.



