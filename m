Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B34CAC582
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 17:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 579764066E;
	Fri, 12 Sep 2025 19:09:03 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A1E6C4065E
 for <dev@dpdk.org>; Fri, 12 Sep 2025 19:09:01 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CGeNk2011269;
 Fri, 12 Sep 2025 10:09:00 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2138.outbound.protection.outlook.com [40.107.93.138])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 494q88r237-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 10:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm0QGvzhjVkrHkKq8KktpG8s9uNz+nDBpOypwHPS9++lE8kd8/ucnjLF3HG1YJxXiIuTLev66NsySGclno103kmAF/28P/54I+2ao77MB3/DKqogzZQtI7P3xIx+Ei0soOx4GjlKkQc7lEA4xEN7u/JGsXl7GeGDCGSrF44v789A0ZmCs5g0rpPmN3VDmqE5TZMwXV4RovWECmE4eC8RkzqBVzle4b5OqNJhcMKd200WowOp3RxdoB1VEj2DPOuTl4TMhV/NNczxFL3TKyWhdiXNzxOZQMslh989JMClO5mLYAS4Xa2ZYM8VWd0Ai05f20KJLqYL+97OvI0RUsgNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEgVucAzhEfjoQjtWQaQ3VR1BAZ9l4yrRBBgoSijnms=;
 b=zCw+a68fPrKO4Zmv6VYTf5nKnpe10376ti14K346CTuVyZ2NIJRYZ5k/nzBxa3WYvb8Wk7n+3m4ZjwdDXlLP9I0VOaLkqNh881Q7QnfhcbVJd9mkgN4MDuJ7IMASaihwCHwKUBCIRHKm3vRw3wLPsdzSL6X5jr/EHj+ByQQcq/xbqJMnzpFJ9qoFJtizstWF9hdMCcQEt9pfyDXN/m4FrigCawh49VTcpC3VY2lYK3OaCs2InoBVNAyIzovl78T2N/sVmSXsqB2ROdvuk//uZzPR5XnyEz4eBa3rOgfHFp7nAo5xHbkBD9zF+0Q10x079EiooRPpCHL9fm2Hl9TkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEgVucAzhEfjoQjtWQaQ3VR1BAZ9l4yrRBBgoSijnms=;
 b=qoJLtHQAGUya1jBlEChq9Eeb5Y1MRBd4P7Fwsjee07VioVRUghv7n9gqCSLeh+7O3s9zTbrqBWNVdqsaBAQ4/tCB3AKRn0yJF5rO9o5HsOpm54QECvqnaAb/qXw9BKqLpsoc8t6nvN8XeRralBbMN8qwg3Hd8bG8cUVSGyWuIDs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB3942.namprd18.prod.outlook.com (2603:10b6:510:28::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 17:08:57 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 17:08:57 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
Thread-Topic: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
Thread-Index: AQHcFzcWJ7TeuTx1VUGp1mFxffzG27SPnK5ggAAQWwCAAAUEUIAAD2CAgAAYeDA=
Date: Fri, 12 Sep 2025 17:08:57 +0000
Message-ID: <CO6PR18MB4484D547CF7B8E03F6AB473BD808A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250827094338.767062-1-radu.nicolau@intel.com>
 <CO6PR18MB4484F38CE9989A01F49C8CF7D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <114c4b2b-f619-4a12-ac0c-adca09fe6033@intel.com>
 <CO6PR18MB4484C9F7FBBCC5AA04405899D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <6157cf0d-4a9e-4f4d-9278-24dd0507ed77@intel.com>
In-Reply-To: <6157cf0d-4a9e-4f4d-9278-24dd0507ed77@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB3942:EE_
x-ms-office365-filtering-correlation-id: 62509120-0191-4d82-98e8-08ddf21f0fa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dDFabWpGeThMbk9SaXNsdnJuTE9vV1RRalZpZno4eE9TTnB1YXhxVHY3MFZU?=
 =?utf-8?B?QXY2eGl2ajgzQ0txbUZ0T0ZPWSs0L1NRY3BpTjJ4dVltamIrQzFoTzliOW5H?=
 =?utf-8?B?RFk1S3hIelY4SEhyNzcwTnlvNXVuY0FZeGI2RkhSdGtpdlcwUXR2RSs4SFFZ?=
 =?utf-8?B?QXNVN2c4cDJqcFNsVWRvYVhPbElMaTdHSXU2elVpWnhrcmc2aVNXYTBIMkxR?=
 =?utf-8?B?ejhLeU5wMDZOQ1Z4OWJMQ0xmYUwrc2Q5OVk1OHMzaUo4bWJ0cHB4dEJ1NnVX?=
 =?utf-8?B?N3VkbGw4aGd2Nkl3dTdHdXpOWjNJMTlFYTJlQkNHREhQenoyeEphQXMraUtv?=
 =?utf-8?B?bVNGRXpvSEhWb2ZaUjI4VUNlcTlDZmJnZ0EwM3p1ZW9Bd2thcjdwUXFsbjUw?=
 =?utf-8?B?T0hTVDgzRm9TZVI5bTBKMktyK2F6cFJKSDIyclFxQndBSHplaTc2ekR2S3Bz?=
 =?utf-8?B?WDFlUXcvdWc2aEhYNEd4WENkMXVrR0RMVitxOW9sYTA1WkVBaFdXcml0Vnps?=
 =?utf-8?B?aWR4UEtJOElNWGxhcGNtTlZMbHFsVGNTeldJMFIxMkZ5V2Y5TFBtUUttdWpy?=
 =?utf-8?B?WHFEdXQ0NHpDYkg0K3VkaUIvSFBkcFdTdEs2UVdnZ2lic0pjSWJLWE5ITHBB?=
 =?utf-8?B?emdFdGZvbmw3REhyTkp3K0VwSW4zMHBUbXZaVzB6dERqdll0Y09wUVVBS1hx?=
 =?utf-8?B?SERNbC93QVdTYjhhYkJKckxEeTUxeEg0cXUvS2tZdDV6Zy9sclhFVWNpZ0t3?=
 =?utf-8?B?YXg5ZEhQTzZtaW4yNWZJcVVEaStyYVZST2xYTjQvb3ViTFh3Y244UzdDYi9x?=
 =?utf-8?B?ZWhPMTZuMm5WSjdEYkg0dG8wRUlYTkpMekpTM2ZSQWc0alY1bWJqclVjMUVk?=
 =?utf-8?B?TGtPZURSckRBdmY3NXVDWmtaSk5BdU5nVzZka2RCY2gvZ3BkekhkNHI3TFU1?=
 =?utf-8?B?ZXdNQkZlTFhEWm96SzNGemlOTzRHTmp2UnJ5YTlrMWswak90bGVOUG9qQ21o?=
 =?utf-8?B?TlFUMUxuZXZlNEVLSGE5bmxJRXI3SDdSdTZNT0ZzcmZ0TVZ3STN1Ti9oOGJB?=
 =?utf-8?B?TWFLakpMUnJGbnRvSlk4NWpKSW5pWHpNY0Z3cDNVaE9Dc2kvTXJhSjkzaDJB?=
 =?utf-8?B?aDdwalZJYUE0TXdIYlIwcTdDUjgxYWg4MWpOVDdqdFlFanR0bXBVWGp2Ni90?=
 =?utf-8?B?ZzQyNzF3ME5BMXBjVlIrK1JyanpkZC8wclFtcWZ5ZmpiYU5FUGV5d0FMakVo?=
 =?utf-8?B?YTVQbWMrRVpYcVFiSTY5Q2RwYmg2dXhFUVhYSXFQOFJ6Q09Gb3hYdGYrS1ZH?=
 =?utf-8?B?SWxMbWs2d2d3UENjb0tJQXROWWY4UElqYUxkSmlLMVhkZWMwd0syQUZuVGNs?=
 =?utf-8?B?eS95OFlHSXNNTE9xT2tpdVR6SFFPZWo0WGtVUHp3VTFyT0NjbFZKL3EwQkI4?=
 =?utf-8?B?Ukt4R2cySXRBSmxoSmtUSzJPRk5zeEswcWRMNmRRTWVwa2FMRWxWMEhmTERJ?=
 =?utf-8?B?YUx5T21VTWFHNWlmSVJlL2xpamRTTytiQ0FSSG9VUmcyaS9PYWpka1hJdVQr?=
 =?utf-8?B?cmJ2cjZWR2dvYzRRV2swY09SOUZSWXU0MlZDNjdKYWQ5VmdhVkM4cEJDblNN?=
 =?utf-8?B?azRzcC9nL0tJN05ZR3ZnY2RkQ1ZOVGZSNGRzaGhlY1ZDZkhmZzVyK3VFQmdE?=
 =?utf-8?B?eExWTzErTVpTMjg1VHdLOHNVWEtuK2VvMzd3dW9RMm44a2V3allacVE0TlIy?=
 =?utf-8?B?NTZsV1FLdlBUSnJYV1I3dUlPeThvMEFXQzhMMFI1eFhDK1lHQ09OQk10TTQv?=
 =?utf-8?B?UDFKK3VabThLVDBxUnVUcDkxVXJGcjNTaGVDbkZNYjkyN1c5eVBqMG1hZVlX?=
 =?utf-8?B?V0RsLzdHZVdoTmJpSEU3My9adXk3cmhWclU2d0hMQnozcmtwYkZGcHdtYmZB?=
 =?utf-8?Q?5wx7AJrLX1k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUxIaVE2STd5RzkzajNsbjhicy9MTVo4Ly9YVmp4UnpnY0syR2xOYXVtNklK?=
 =?utf-8?B?ekRTWmh1MDg5YVprUE0xdGVXdGpoTVRUYThXY1V6b1R6a01FV2pabXk0bHZQ?=
 =?utf-8?B?czNaSVB3Ukp1UUtaM0cyOGd5R3FBdUEvbVNpMzhSZkI3K2U5MCs1dUR0YWF1?=
 =?utf-8?B?bDN4K2VUUUlsU2dGRlZ6RzZDaWhtVmxNQ0VoQ25pSWNpSEg0emt4Tk5pVUEw?=
 =?utf-8?B?TFJkR29vcmo3U1lwWFY2d1J3dE1YUEZFUUUySUlMelVLUHN0UlhST3dmY29l?=
 =?utf-8?B?RVhpV2h6NHhIeDNkN3FVRGpGZ3A3VTV1d2VvZzQ4ZjQxNjVSWXpPOGFpSnVE?=
 =?utf-8?B?NXo2ZjRtZU5sU2NKMWlaTDkzSTU5SFZLNStGU0RvSXNOTFFIRmZJcW1EWmVS?=
 =?utf-8?B?b0xOV0lqcElyZ0FIZ1pXcGxmdW9udGNBeWRBdTVjbzFRWmhwN1BvME1RRjlm?=
 =?utf-8?B?bldHVlNHWXowaTI1Q2JoenViMTZ2T0l5bCs0eU11SnJhZHhYTjNwSlQ4cE1i?=
 =?utf-8?B?MTVXN2w1Rnhjb3dseWVLTTJqNy8zWFhGaTl1MzBPdXNaRDdXeFFtWXlFeXFa?=
 =?utf-8?B?S0ppenduSkkvLysrazN5RkVXQkh1bnYzcUFCbGw4MndBeG5KR24zZHRPd01r?=
 =?utf-8?B?T1pBYmRPNnFFd0FiMjBlckhrSVFuMnJiakpzQVU1ZlptY1dWWmF1bHpQcUFV?=
 =?utf-8?B?K2ZZejZyc21oZWROemJ0U09PY0QyMU9JQXNiSC95Y2h0bDV3cmFVVlNZZzZI?=
 =?utf-8?B?R0N5ZldISGJVOEpFVVVtYlNqLzZoZkwrVlF0NXlGNnFOekhvV3Npem5zbm02?=
 =?utf-8?B?bDRiNUJNNEY0MlRXMGpaUXZJTG5kbFA4VTdyVDRwT1pMOS84b01lQm4wVDQy?=
 =?utf-8?B?WG1QZEc3NjJuR0lwdXhYSEJkY2x3cEorZWdVSE1HWFh2YTNCS1M5YVBMNkpr?=
 =?utf-8?B?SDhPNFlKSFpOVndMYVR4SFVBTXh5NGxOYzhsbEU0NnBqT2Z3TzJoYi9CUXdG?=
 =?utf-8?B?ZHEwamFlQlNDNjF5VzlyYXFhMWkvRFVoK2lMdFprZHczNTZWUUVYUllLM21l?=
 =?utf-8?B?UjNzVExoMGZjMzVkTU9xYkdNVnE1UnJKNWZoVVYzeG9ERUlVVnU5enE3STV1?=
 =?utf-8?B?aGNZRTN1WWZ2MEk3MDdwb0dhUkxMOTl4RitlNEtXci9idzVXK0pmT2dPb1Fn?=
 =?utf-8?B?REpJSzBQVzJkdUtvT0psWVZwQTNlSExrUTV1elVmR3ZldmwrVmNFOHkzanJ6?=
 =?utf-8?B?TFNLMzdpT3BCbXUzMEtnblkrUWdhQXZpVEF1WS9MZG1IbmVaQXdINnBjaml3?=
 =?utf-8?B?UjBOTHd0cmFJbnNqZUFNWW56MmRtUU1ZQlBZM2FBMzhUdHYyaS93QmdEdU53?=
 =?utf-8?B?VXdXR2ZtWkZ1ZTNuaE9TTXNTWEQyZGU3TUo3dHZYSXhnN1UrTlBDTEtWL1JL?=
 =?utf-8?B?MURvRkcwYndsNDVMZm44SWF3UGp0Nnp3bGJqREJYbDV5SlZ5M21OTHJ0Wkh5?=
 =?utf-8?B?SVBCbUtBcnBJbVVJaVY0cjIxdXFOaExsL1l4ZVdIOXpQdkFMTTN2K1l3UHlZ?=
 =?utf-8?B?ZnFaNkVQbWoza1R0dXZvL0R3OVVINGlMaHNhZU9ja0RGV1IycSt3eHltQ0Jh?=
 =?utf-8?B?RGpZSGhuOTBvYjU2NWo0bjNOR0twVnZNVzBwR1ovbTlmcTRJMFl5SytPUEwz?=
 =?utf-8?B?MUZqT2xOc0E5bEw0UHRvSFJvZWtSV2xHcDhJK2ZpaitUeDJUZG5BTVhtb2Fk?=
 =?utf-8?B?TXpDam00eDdoc29CenJmcnJJT0RHcVZWRVRIY29zNDkwUmNEZ002a2JVMy8x?=
 =?utf-8?B?Yk9OUnhVdDlrbG1hU1dnSTJhZXlRKzJJdEd0cEFlak5NSWRiLzQ5blZ5d29X?=
 =?utf-8?B?RW5TeU1Mamw2VHFHdi83Szk3VTZIeEZ0STdWa0hCOG12YXFTZjhyUEo3aGNF?=
 =?utf-8?B?bS93eFV4ZEMzNVZXMi9aTlYvbTl6ZFpmTk55c0wrVkY2YUZFdHNDZnBqZ25k?=
 =?utf-8?B?TGd2enJKbjBwbE5mN0I0cVAxdUxkaU16MFlZK0lqeHRBRzdoOFRpL0h5aWZC?=
 =?utf-8?B?a1JpOHh6RVVsRGZPZ2xUZjV6ZmR2UGdHVTc1SFdwL3ZEYnMxTjFKM2VGc3BI?=
 =?utf-8?Q?W/B8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62509120-0191-4d82-98e8-08ddf21f0fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 17:08:57.6647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BK3IsARx33kg2wI1BoNEbSjAdN4hy8qB7cZQvgg9YPytMYICRYWeNTzw4oFtuz66sE9mPH1LVeICi847Mh6REw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3942
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDE1MiBTYWx0ZWRfX8zbAlQ4DPMYi
 1DWFraKdtG/k+XKd+Sq78W2XVyR7jnYajiV2BrI8ElHGDKHnKwjdTn9V0YzAa4maTDMNbZh83LV
 R5QZGPZR+OCiNpFULQNLjZbKnPpg7zT48ITh/aeJzTt1NVTA2IaBHfvadnOzwruv6D23UFyiCSn
 slIFWBCiEWP/WpLP246ZdOcS8V6cylz1tUDHflvC8588aalZ9roVlm88qlg1DC128ofmUuwNBkF
 /qILFLPKFQ/rID94bOsOIbrqWkbzhytbTkDqJ350spnqNzu8+70UQNl6MeU/UPIqtSN1immukXN
 vZC1LpxYjXDmptWgY9/atqZQZ5WqASYbH8wqUcrfdReQavXmOuyXm8Rjscb5reZO9xCKu99jLUp
 pA18E2r6
X-Proofpoint-ORIG-GUID: RDotKJ_DIfHc7iLRxN9fdcUH7ppCcksU
X-Proofpoint-GUID: RDotKJ_DIfHc7iLRxN9fdcUH7ppCcksU
X-Authority-Analysis: v=2.4 cv=W7E4VQWk c=1 sm=1 tr=0 ts=68c453ac cx=c_pps
 a=jKI1xF7KBL6Pubb8ieCg8Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=8rWy6zfcAAAA:8 a=O__AX2P3vDOQA3-6lM4A:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
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

PiANCj4gT24gMTItU2VwLTI1IDM6NTYgUE0sIEFraGlsIEdveWFsIHdyb3RlOg0KPiA+PiBPbiAx
Mi1TZXAtMjUgMjowNSBQTSwgQWtoaWwgR295YWwgd3JvdGU6DQo+ID4+PiBIaSBSYWR1LA0KPiA+
Pj4NCj4gPj4+PiBVcGRhdGUgdGhlIEFQSSBkb2N1bWVudGF0aW9uIGRlc2NyaXB0aW9uIG9mIHJ0
ZV9jcnlwdG9fb3AgZmllbGQNCj4gPj4+PiBhdXhfZmxhZ3MgYXMgdG8gYWxsb3cgUE1EcyB0byBk
ZWZpbmUgZHJpdmVyLXNwZWNpZmljIGZsYWdzLg0KPiA+Pj4gQ2FuIHlvdSBnaXZlIGV4YW1wbGVz
IG9mIHRoZSBmbGFncyB0aGF0IHlvdSB3YW50IHRvIGFkZCBmb3IgZHJpdmVyIHNwZWNpZmljDQo+
ID4+IHdvcms/DQo+ID4+PiBJIGJlbGlldmUgYWRkaW5nIGRyaXZlciBzcGVjaWZpYyB0aGluZ3Mg
aGVyZSBtYXkgbm90IGJlIGdvb2QuDQo+ID4+PiBNYXkgYmUgd2UgY2FuIGRpc2N1c3MgdGhlIHNw
ZWNpZmljIGZsYWdzIGFuZCBkZWZpbmUgdGhlbSBhcyBjb21tb24gZm9yIGFsbA0KPiA+PiBQTURz
Lg0KPiA+Pg0KPiA+PiBUaGUgZmxhZ3Mgd2UgaGF2ZSBpbiBtaW5kIGFyZSB2ZXJ5IFBNRCBzcGVj
aWZpYyBpLmUuIGNvbnRyb2xsaW5nDQo+ID4+IHNwZWNpZmljIGhhcmR3YXJlIGJlaGF2aW9yIHNv
IHRoZXkgd2lsbCBub3QgYmUgc3VpdGFibGUgdG8gYmUgYWRkZWQgdG8NCj4gPj4gdGhlIGNvbW1v
biBmbGFncy4NCj4gPj4NCj4gPj4gU2VlaW5nIHRoYXQgYXV4X2ZsYWdzIGFyZSBub3QgdGhhdCBz
dHJvbmdseSBkZWZpbmVkIGFuZCBzZWVpbmcgdGhhdCB0aGV5DQo+ID4+IGFyZSBhbHJlYWR5IHBv
dGVudGlhbGx5IHVzZWQgZm9yIFBNRCBzcGVjaWZpYyB2YWx1ZXMgbXkgcmVhc29uaW5nIHdhcyB0
bw0KPiA+PiBmb3JtYWxpemUgdGhpcyBwb3NzaWJpbGl0eSBvZiB1c2FnZQ0KPiA+Pg0KPiA+PiBh
dXhfZmxhZ3MgYXJlIHVzZWQgaGVyZSB0byBwb3RlbnRpYWxseSBjYXJyeSBhIHZhbHVlIHRoYXQg
aXMgbm90IGNvdmVyZWQNCj4gPj4gaW4gdGhlIGNvbW1vbiBBUEkgYXV4X2ZsYWdzIGRlZmluaXRp
b25zOg0KPiA+Pg0KPiA+PiBodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL3RyZWUvZHJpdmVycy9j
cnlwdG8vY254ay9jbjIwa19jcnlwdG9kZXZfb3BzLmMjbjg1Nw0KPiA+Pg0KPiA+IFRoZSBhdXgg
ZmxhZ3MgdGhhdCBhcmUgY3VycmVudGx5IGRlZmluZWQgYXJlIGZvciBzb2Z0IGV4cGlyeShvdXQg
cGFyYW0pIGFuZCBUTFMNCj4gcGFkZGluZyhpbiBwYXJhbSkuDQo+ID4gVGhlc2UgYXJlIG5vdCBQ
TUQgc3BlY2lmaWMgYW5kIGFyZSBkZWZpbmVkIGFzIGdlbmVyaWMgZmxhZ3MgcGFzc2VkIGJ5DQo+
IGFwcGxpY2F0aW9uDQo+ID4gICBPciBnZXR0aW5nIG1vcmUgaW5mbyBhYm91dCB0aGUgY3J5cHRv
IG9wZXJhdGlvbiBzdWNoIGFzIHNvZnQgZXhwaXJ5IHdoaWNoIGlzIG5vdA0KPiBhbiBlcnJvcg0K
PiA+IGJ1dCB3aWxsIGJlIHVzZWZ1bCBmb3IgYXBwbGljYXRpb24gdG8gdHJpZ2dlciByZWtleWlu
ZyBpbiBhZHZhbmNlLg0KPiA+DQo+ID4gSW4geW91ciBjYXNlLCB0aGVzZSBmbGFncyBuZWVkIHRv
IGJlIGV4cG9zZWQgaWYgYXBwbGljYXRpb24gaXMgcmVxdWlyZWQgdG8gc2V0Lg0KPiBUaGUgYXBw
bGljYXRpb24gaXMgbm90IHJlcXVpcmVkIHRvIHNldCB0aGVzZSBmbGFncywgdGhlIFJGQyBjaGFu
Z2UNCj4gc3BlY2lmaWNhbGx5IHN0YXRlcyAib3B0aW9uYWwgYXV4aWxpYXJ5IGZsYWdzIi4NCg0K
RXZlbiBpZiBpdCBpcyBvcHRpb25hbCwgYXBwbGljYXRpb24gbmVlZCB0byBzZXQgdGhlbSBpbiB5
b3VyIGNhc2UuIFJpZ2h0Pw0KU28gc29tZSBtYWNyb3MgbmVlZCB0byBiZSB0aGVyZSB3aGljaCBh
cHBsaWNhdGlvbiBjYW4gc2V0Lg0KDQo+ID4gQW5kIHdlIGNhbm5vdCBkZWZpbmUgcG1kIHNwZWNp
ZmljIGZsYWdzIGluIHJ0ZV9jcnlwdG8uaC4NCj4gPiBQbGVhc2Ugc3BlY2lmeSB1c2UgY2FzZSBp
ZiBpdCBjYW4gYmUgdXNlZnVsIGZvciBvdGhlciBQTURzIGFsc28gYW5kIHdlIGNhbiBhZGQNCj4g
YW5vdGhlciBmbGFnLg0KPiA+DQo+ID4gRm9yIFBNRCBzcGVjaWZpYyBmbGFncywgaXMgaXQgbm90
IHBvc3NpYmxlIGZvciB5b3UgdG8gdXNlIG1idWYgZHluYW1pYyBmaWVsZHMgaWYgaXQgaXMNCj4g
YW4gSVBzZWMgY2FzZT8NCj4gPiBPciB3ZSBjYW4gYWxzbyBleHBsb3JlIHRvIGludHJvZHVjZSBk
eW5maWVsZHMgaW4gY3J5cHRvX29wLg0KPiBZZXMsIHdlIGNhbiB1c2UgZHluZmllbGRzIGFuZCB3
ZSBjYW4gZXhwbG9yZSBhZGRpbmcgdGhlbSB0byB0aGUgY3J5cHRvDQo+IG9wLCBidXQgc2luY2Ug
d2UgYWxyZWFkeSBoYXZlIHRoZXNlIGZsYWdzIHdlIGNhbiBtYWtlIHVzZSBvZiB0aGVtLg0KDQpB
dXggZmxhZ3MgYXJlIGJhc2ljYWxseSB1c2VkIGZvciBjb21tb24gdGhpbmdzIHdoaWNoIFBNRHMg
YW5kIGFwcGxpY2F0aW9ucyBjYW4gdXNlLg0KRHluZmllbGRzIGluIG1idWYgYXJlIHZlbmRvciBz
cGVjaWZpYyBmaWVsZHMuIEl0IGNhbiBiZSBhIGdvb2Qgb3B0aW9uIGluIHlvdXIgY2FzZSBhbmQN
CndvdWxkIGJlIHVzZWZ1bCBmb3Igb3RoZXIgUE1EcyBhbHNvLg0KDQo+ID4NCj4gPiBJbiBhYm92
ZSBsaW5rLCBjb3AtPmF1eF9mbGFncyA9IHJlcy0+dWNfY29tcGNvZGU7DQo+ID4gaXMgc2V0IHRv
IGdpdmUgZGVidWcgaW5mb3JtYXRpb24gdG8gYXBwbGljYXRpb24sIGFzIHdhcm5pbmcgY29kZXMg
YXJlIG5vdA0KPiBleHBvc2VkIGluIGNyeXB0b19vcCBzdGF0dXMuDQo+ID4gQXBwbGljYXRpb24g
aXMgbm90IHJlcXVpcmVkIHRvIHRha2UgYW55IGFjdGlvbiBiYXNlZCBvbiB0aGUgdmFsdWVzIG90
aGVyIHRoYW4NCj4gdGhlIG9uZXMgZGVmaW5lZCBpbiBydGVfY3J5cHRvLmguDQo+IE15IHByb3Bv
c2FsIGlzIHZlcnkgc2ltaWxhciB0byB0aGlzIHVzZSBjYXNlLCBqdXN0IGluIHRoZSBvdGhlcg0K
PiBkaXJlY3Rpb24uIFRoZSBQTUQgaXMgbm90IHJlcXVpcmVkIHRvIHRha2UgYW55IGFjdGlvbiBv
biB0aGUgdmFsdWUgb2YNCj4gYXV4X2ZsYWdzLCBhbmQgdGhlIGFwcGxpY2F0aW9uIGlzIG5vdCBy
ZXF1aXJlZCB0byBzZXQgYW55dGhpbmcuDQoNClRoZSBtYWluIGlzc3VlIGlzIGRpcmVjdGlvbi4N
CklmIGFwcGxpY2F0aW9uIGlzIHJlcXVpcmVkIHRvIHNldCBzb21lIHZhbHVlIGZvciB5b3VyIHNw
ZWNpZmljIGNhc2UsIGl0IG5lZWQgdG8gYmUgZGVmaW5lZCBpbiBjcnlwdG9kZXYuDQpCdXQgaWYg
YXBwbGljYXRpb24gaXMgZ2V0dGluZyBleHRyYSBpbmZvcm1hdGlvbiwgaXQgY2FuIGlnbm9yZSBp
dCBhbmQgdXNlIG9ubHkgdGhlIG9uZSB3aGljaCBpcyBkZWZpbmVkIGFuZCB1c2VmdWwuDQoNCg==
