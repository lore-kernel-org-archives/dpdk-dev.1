Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D272FCA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 10:23:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6C9E40263;
	Fri, 29 Aug 2025 12:23:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 89C444025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 12:23:35 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8mxeI029092;
 Fri, 29 Aug 2025 03:23:34 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2106.outbound.protection.outlook.com [40.107.223.106])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48u0pc13h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 03:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYh8onCurycu2O3RaCBxLJZRAVA68tT0X/5LxULRONqEWnMWm1ldz2VZeIy2sUAXftSJZDfv9rauoL+FBGWhRFCQJK4jXq01V+RIup2mJpZkjXwuftFXe9ebVMcwhTPaEojrZpu+LjCRAV5pLP4zjPcpdWO64DQZ56A9UEM1WCSpmVqJbmqaM8PfdxBDmJOYfqLJ2vfOurI4RzyLZwY65uuJ1hpI1dhOSCrdEgdqez20lo7cX4nXJ/Q4twUI1pHyKkwgC5LZXEUjW2Zga8s5h0FBFJdQeQyc9zptpyJlf8uZMQjH5R0O4XBJhHA85f34rTWIkEC0yVHhdWiJcwcnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iToyrFvflJX3xD0JNMOxubo3ZVbQnFGWylTxOY+xbLg=;
 b=Yw8Zy5f7fbMCdQNTj3LYE8UXfIkl2tdxEZZY5VKVqarDwnTaLHyzui6loPkfsGj57xOz9ltCiBM1gp225x5U0R+SZqyJA6XTyBRlvP1erExMO4o9UKxQ6qDamUULd4P60NcrWW4XozT5aReu/g9XwxmtocQuNiFFGChG60P2ahZ6QIaC9WlVaUtEpYjPAz4lxu5Sx908AhWdmoea9QuJDBYj8l4WSCF0yLZoIbkU7PGoOagjs9yL07GMiV0hJpR9v1saZu8QeiIunkMs0wExq3C1jbN7iVb3iGjB4VDvpPVPDXJze8OkmYP8bRY+39reOLuUBr2BtQ1arGOnteRhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iToyrFvflJX3xD0JNMOxubo3ZVbQnFGWylTxOY+xbLg=;
 b=c10iHgn8yPWw7xairkQnboA1oPcseicBAMPPznDd8UPYRZ+31l7d5ORaP33cZznSlPb2tApvWenO7UcypYLCqIck9boJvU3kQYfivWcVi+plStqeY1xLBnEPrv87cHXRnpW+RuoylJNXru4DLg/DWusdup4DBUF8JxutMOqttV4=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by LV8PR18MB5916.namprd18.prod.outlook.com (2603:10b6:408:223::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 10:23:27 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%4]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 10:23:27 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling pointer
 for SHA test
Thread-Topic: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling
 pointer for SHA test
Thread-Index: AQHcF/4n1AirPyIQZ0eW5+X0CURUuLR3zazwgAGexICAAACsQA==
Date: Fri, 29 Aug 2025 10:23:26 +0000
Message-ID: <CO1PR18MB4714A60A5FEED89BA023628CCB3AA@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
 <CO1PR18MB471416C114E8D59E97EEBE2FCB3BA@CO1PR18MB4714.namprd18.prod.outlook.com>
 <CY8PR11MB784530D82EB6D7A7D4EF1F99EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB784530D82EB6D7A7D4EF1F99EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|LV8PR18MB5916:EE_
x-ms-office365-filtering-correlation-id: df388ded-472a-46d2-044e-08dde6e617a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dk51OWY4L1h3UTJ1SExJRVR4UU9iY1JXK2hlVGJQOFE0L1E5dFFYZGloQXBa?=
 =?utf-8?B?WHNibFhPbFU3QkZkd3V5dGkwOXNZOHQxQktGbDBQSE5jNW8xWUIyUTRYcFNJ?=
 =?utf-8?B?V2l3Tk5mTGhUSFlFd3lOa0xrN2lzOHk2QTlJZC9sQTJoc3poeFFOdi9WRFRV?=
 =?utf-8?B?endqWXpqeEZrRDQxODBKbC9MUGxxdkFNTU1UcjQzeXlqNER6TU1xQ3l2c0pk?=
 =?utf-8?B?ajlydENVZmVDMEhBOTd0UTJuLzdlQlU2c1RGZWRTM0ZBRklzbXVyellnZmh4?=
 =?utf-8?B?UDZkUitnTWp0a1NROTYrYUhwVDFzeFphcXFQNXhUSnJOQngzSHVxMEwwT3Fq?=
 =?utf-8?B?Y3V5ckx2aGlJZlJreXBORW4rMlJhc0o2TnpDVmhzTVU5TkRZMFkyeWZVRkRM?=
 =?utf-8?B?dzlFcTVIOWhRMFVwbUo2akIyWStsMDFNYjZHQVpZOXVQRVk3M00vUVJ4NTdS?=
 =?utf-8?B?aXl4QTJJenJlSjVYTVk4UmhHZ2xacmdsK3U5eElzZ1BKcy9QOXBOWitWOEcw?=
 =?utf-8?B?SmkrZkUvbUVZaXk5d0dmVng1U1Y0RkowdDhGaWJwSkZ5U0xBa3A4cG5GTmQx?=
 =?utf-8?B?WHhVZGhCTXkwcG9teTJnVUpoUHRxU1R3SHdkMzdVN251b0p2MmZnRkF4cGNM?=
 =?utf-8?B?NUFBQ0NmbWswUXE5bTkxa2pKVmZjWjhkVEhva2p2UVB3ZDlyY2xWcHhPTTFl?=
 =?utf-8?B?Y3FKTlhhVmM2aUVCQzM3UW5raTBXU2lUbWlKemFoWU02SHlyWTYwc1ByU291?=
 =?utf-8?B?S3o4L0FIWHBCVXcreUNTUVUrdG5aUDhxVWxuLzFQcG9pK2NWa3o1dFFkNlhn?=
 =?utf-8?B?TlFhdGtnVkZJa2NwS1htZFVMU3NoZFJzSGlKVjA0MmZHT25KcXlCdEw3elVp?=
 =?utf-8?B?NWNtSTRUWm4vL1Q2OFhMdFdsUXBRU2doa2I3a3l3WEg4N1RaOFJ5Y0JtVDhU?=
 =?utf-8?B?L0J2czhBM0lBeHA2QXZkZUF1YjZOQWxUV0ZTUkpST2tjU20yV0FiQlB5QkQx?=
 =?utf-8?B?SVdLVldWZU5hWGNlRmRFalluWkJmMU9tZmYrZXQ2M2RqK1phZjY3Nm8rQXJE?=
 =?utf-8?B?R0QvcUloMEpDTlNZL3JMY00vR0V2OUNZYzlqK0p2VlNqLzlrN1I5KzB6SkVy?=
 =?utf-8?B?aFRJcWE0cUgwbmk4WlZKNHlvMWNFMTU1Ymo4VWs2cnJ6NnRqOGRpTEZPU0ZP?=
 =?utf-8?B?TTEzLzlidzVrS2cydzB5Wmdwc0kyVVBoS1hTZnFoYndPQmk1ZGh1UkhreHVW?=
 =?utf-8?B?ZncwZXBIWWR5RU9wYmJrNHpISkVNVkx4dHNLamUwUVEzRFBIRmJpVVovMk5y?=
 =?utf-8?B?VkRpUWU1TVUrcHhqbEV5cHNIVkFMOHNScmpYR1NmYndoOWNvV2lUMWpjbkwy?=
 =?utf-8?B?a1cvTXMvaDVSVmtFS0tSRlo1OVFQVkxOS0lKS29CeEdLMncrQmZIOHFrK05S?=
 =?utf-8?B?Y1FQdWdvb3d6M3c2UXZ6WVVFMFk5b0dHTytkdURiK3JLeDlGYTc0SW5mM25Y?=
 =?utf-8?B?cFVtVHZPZWNobzFFMGNqVXU3Nk5CdXFtNkg1T2RCeVFEL2VPQWJmYkFoMExo?=
 =?utf-8?B?SDU3azlIWktqWEt5NXE3cDB4UGp3NnA0REVzNk1BODZ1akF5a2Y3a1FXd1FY?=
 =?utf-8?B?VU5CTUJmS0lPRG1pNzUwRUZ1cjVteXhWOVdkelF1TS9QR2dHK3BEeHVkUWdS?=
 =?utf-8?B?M2l0eDk1Y0x1UmUrTFVSR21XYU92WXN1T213QTc2aUIrb3hlNEJFUU03UGRr?=
 =?utf-8?B?OHkxN3RKbWNWUnpEb0E2cFl0QmxvckVQeGpZZXlWaDc1NFhGZVNpc0xjQ2dj?=
 =?utf-8?B?VmozQlltY0E2VmpYNGZ1dzBjZkFDNkh0eVJpejY0QU5RR3RDSm5ndG1wblp1?=
 =?utf-8?B?ZmdxNGt5YVV4c091NkF2UlJGeGlMcThCNXR0alFWUmUzK1RJRmQwQU1MdWVx?=
 =?utf-8?B?Q0pFMmZsdCtvcHlaaHFkdWpEa1hHWmkvTUtGZElRUmRsNGorT1BxcHNuaG9w?=
 =?utf-8?B?dEZEa044bmp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2xRdVBKZDllWDFvbUMyVXk5eS9EbElsaDEzM1dTR0RrQk9OVzdnRnN2N0xm?=
 =?utf-8?B?UmcxemltVXRLbFc1Q1daa3l3Mlo3UEkreVU1QjJ3VWk1NUVlazF5QkRLUUk3?=
 =?utf-8?B?aUZ1MXJxa3BnNDVBRTRzbjVVSmQrN0wvaVJHbDVTUUJwaUc5NU92WEtYeEMy?=
 =?utf-8?B?aytaSXFQSUJ2Q0ZqcnR4Rm4zZWVYbGlTMVNwMDgrN3Q1MzAzTFVOZTYyTG50?=
 =?utf-8?B?WTZHRDVZYkJ5empBU0ZaSVk3M3F3NU5LUlhXTXNtZXJQM29ndHkyV3Z0SmFN?=
 =?utf-8?B?YWg0ZmpuZVg2NHRYalp4QTlXVGNHT0tHSmRSNkpUVGE2NU5lWVlTUW5rZnQ1?=
 =?utf-8?B?Vk5sazB3V1V3cHpkcDN1MXYvRVhUK1NGTERpUmNBQmZJWWxvcS9qN0RXOFQz?=
 =?utf-8?B?SXE1bkoxb004N2lLczhSMTJpZUdqcXY1ZzZmOWNKbTJsTThPMytueXRwS3lx?=
 =?utf-8?B?OFJJaUpGQmtCU1RXL08zTnFOeFE3RWxaNzB1ajIzcld5TUVNUWJzUnphSkpG?=
 =?utf-8?B?d0V0YVl4dk11OEo0Q2lNMDZpRWZXZmFYclFvSGhTOVNmaFNjb3V6ZmJRM0Z1?=
 =?utf-8?B?Q2lDZWtVTHp3c0d2aE1zc1pIRElsR09pWEhQblJLUGlTQkF0TStJVDlwemVt?=
 =?utf-8?B?dXFBK21LZ0htMGN2KzVhSEZEZDdPVlBUaW9tWThaTlJjMjhNUkZ3REtEUWpa?=
 =?utf-8?B?dGl2dEtkUmJZL2QzdlNvT0ZEMEhaYTRrNUJJMjR0T3RtUDhINmwvUEZBT0c0?=
 =?utf-8?B?K2kvcm5iMlNRT3dzN1l6VG4vd092Z3dmd0pFalcwZkl3dmxoVmhOaSs3Z25x?=
 =?utf-8?B?eVVTRVlJcXBHMnV1UUNpL0VIS3psSUZKU1FuSVB1amFhaWFhVDZUTnREV0pH?=
 =?utf-8?B?UWFrY3lvcm9ZblVocXlqZ2hORU5GTk91S1FraUp2Q1JSQlFpajI3RnRGRC9k?=
 =?utf-8?B?bFJ5MzIxUWRPaDVkREZEM3pWV2xVQVVCdEllK2RmakZERytlNzA5TG8wRjJt?=
 =?utf-8?B?V0JMYWMvQ0hGMm9KL2RyUUE2UjdvREl4OVBMUmJpOGRtMGF0SU1PNjljR2xw?=
 =?utf-8?B?S0NlZytmL0tsbk95bzdlLzFub3JHblNFamdoZ0FPVXVkZ3M5T2Z0cStxT2Fx?=
 =?utf-8?B?elJSQTFQb0tjTlFYRmI2OVp0ZFBwaVgrRkpvQWhqVnM1UkJmUHlza3lqdkQ5?=
 =?utf-8?B?aUxXQVR6KzJwMXlCcGVleU5zSStpZ3lVTHg4cXFUei9YbWc3OGZzRXM5c25S?=
 =?utf-8?B?RGNTMmlkMzFDWGRUdVB3c0tCSlB5enpjRHpoK2hLNjUwUWszMkVjcjJOOUFn?=
 =?utf-8?B?VDlxY1p2ZWh0TW5XVCt5Q3B0LzkyUnIzWlBMZXlIMXpaVG54bG9qY1RpS1lH?=
 =?utf-8?B?TDMxVURSQXhBczg5Nk1VbG9DR3R0dVJCQ3YybFVYV2wvUEQvVzVTTktpSHhO?=
 =?utf-8?B?Rnl1dkxrUDQ5d0twOGpYZWpaenVZL2xibzhtNGFIU0YvSm5QQWFFRjlMaTE3?=
 =?utf-8?B?b0wrVU9LamM1S3lLQWtwendVbUhnMkRLZlZSUjBvUjFqQTZpcWxDbkRNRThN?=
 =?utf-8?B?OURoeFBwdXhxbzN3VUJGUnZ4SHlZanZna21aY2pWc0R0ZzRnMmc1aUFRZ1Q3?=
 =?utf-8?B?ajJ2RVV1V3Zwenl2OVQ5SG9UNU5SZmRldU5ZYWp6bVVZWGVhb1MvcGNNZ1p6?=
 =?utf-8?B?Uk5SenJuNTQ0Tzl0MTIweDNEVXYvRm84R0w3R1c5RVhTdmpFV1hXM2tlNkJr?=
 =?utf-8?B?MkFkRytQS1JvQmJuUldKVXh4eXc4VXlZTGRYSXk1QWVzYjNqU0FQQ0Z4SVl4?=
 =?utf-8?B?WFFvOWNTS3Voa3BCNHg0bEg5KzlsUFVLbFJwbVM4WFhQUGg1UU5IWU5jN0Vv?=
 =?utf-8?B?bUhOWEo5czVheWxvZzFBa3AxaFE3VjU1S0tOOVVCS1owd0x6NFhUdE5FVXND?=
 =?utf-8?B?MnpDMW80dlVIUEx5MDQrQTVPb282QUJ4MisyVVFNU0ZKSDNiYzA5ODEwaWMz?=
 =?utf-8?B?K3ladC8xc3Y4SGNxZHY2RWpIV2tOZG81Z1BFQUNmTEk2UU9FcjVmVmc3QnJj?=
 =?utf-8?B?L3FhMDlDOGlpZWdGQXFWZEc4KzlHVjRhZ2o4TjBONm83UmtqL09SN3BEZmtr?=
 =?utf-8?B?Z2s0OWd0WUZvaktRdHU4SlJsSGFPOXQ4UkxuQjhFZFRaN0doZHV2dHU3d0ln?=
 =?utf-8?Q?773JK78tUJbhGlY67daFIjmvMLN31ZgutSACCxNnI2Cq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df388ded-472a-46d2-044e-08dde6e617a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 10:23:26.9820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mu/cYfcIbeJ8t/m0aMuCWdk7/Ll0MSQy83Ukn+H69YgpXfyT8sA6/UOzp7g1CzpophHgN4xwyeKtI3OAzB0V6JKI6UaSVr1f8mtsbK4Bx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5916
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDE5NCBTYWx0ZWRfXxpdKMPhBt0SG
 km/cNxMhIUipDxOLUqoDsimGQj8ESkeVsywhWJwFFp5L8qUGRe1Mgq6IomBvs6sgzKxLKXAToFp
 ZaBw6ni1/ZHEIGOZfcccKJW3Qz+FYbmQPdrhGIT70j46zAV3d8spBFLZG6r567DmqP3SNKIRKRd
 GknbsFvNAXEpvgPuZ+W3vFWoiiDevVQmBJeY1FrgGSknz/tndcQ9mzBwifJ8HAHT5h4GRCok5t4
 KgXWQHyRlQ/pemHwhOBMlhRRGGG6u443Gv6Y4YROUt9UKjHHQFrn4k7PFZjJ9dBNE/ZvRWIKSVy
 9l/cAMAs4qC5LD1OSAhmkI9luWSwtGZL6Lt3JKMQOAjd2G54RrRiu+KdWKu3I99l6vP3xqAJpwP
 PHCoK3X2
X-Authority-Analysis: v=2.4 cv=Pbf/hjhd c=1 sm=1 tr=0 ts=68b17fa6 cx=c_pps
 a=EebWuFOjNSpnsyZumeNqcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=gbaEvu5v4CgtjNNSL0cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: thholK49m65WiIXZ2M9oSq6t1Jm7IWHR
X-Proofpoint-ORIG-GUID: thholK49m65WiIXZ2M9oSq6t1Jm7IWHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
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

PiA+ID4gIAlydGVfZnJlZSh2ZWMucHQudmFsKTsNCj4gPiA+IC0NCj4gPiA+ICsJdmVjLnB0LnZh
bCA9IE5VTEw7DQo+ID4NCj4gPiBTYW1lIGNvdWxkIGJlIHRoZSBjYXNlIGZvciBmaXBzX21jdF9z
aGFrZV90ZXN0IGFsc28uDQo+ID4NCj4gR29vZCBjYXRjaCwgcHJvYmFibHkgdGhlIHNhbWUgY291
bGQgaGFwcGVuIHdpdGggc2hha2UuDQo+IEkgY3VycmVudGx5IGRvbuKAmXQgaGF2ZSBhIHdheSB0
byB0ZXN0IHNoYWtlIGJ1dCBJJ20gaGFwcHkgdG8gbWFrZSB0aGUgY2hhbmdlIGFzDQo+IHBhcnQg
b2YgdGhpcyBwYXRjaCBpZiB5b3UgY2FuIHRlc3Q/DQo+IA0KRGlkIHlvdSBmaW5kIGFueSBzZWdm
YXVsdCBhbmQgc28gZ290IHRvIGtub3cgdGhlIHByb2JsZW0gPyBJZiBzbywgd2hhdCB3YXMgdGhl
IGNvbW1hbmQgeW91IGV4ZWN1dGVkID8uDQoNClRoYW5rcywNCkdvd3Jpc2hhbmthcg0K
