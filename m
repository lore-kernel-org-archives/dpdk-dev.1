Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15847E8782F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 13:59:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC17A402D9;
	Tue,  3 Feb 2026 14:59:42 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 548CE402BE
 for <dev@dpdk.org>; Tue,  3 Feb 2026 14:59:41 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6136nPJZ815985; Tue, 3 Feb 2026 05:59:40 -0800
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023111.outbound.protection.outlook.com
 [40.93.196.111])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c28mxvneh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 05:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWWJ6w2R6W0QHzWIhu4gcG9dRVYR+nehvo4OWUKp3Eurqa1WNxJXs/oaKpsTMGgI04/TLTwhwHtZccQ/fEWrhatTQVqcwyMvmLRL0joJzT9ZwhGiqgtvD/uNZ2ZAana0zsYXBLiTrKU6GD6oSem+7XBvc+9YEH2n2civ2QQtEnHiWVHozcvoH3oOIfrqMfaf8D37NKcSnfQfw5O1aqN2GHl8N9JtnAQoGY8ktVDL6+Krecc4hqqAPl4ZgqS6qtc/O3AMa6xKjUrXnXyORavfq+d80z0gIr8lOLP3h/BpjiEyz4TbJhPvqReOoIKz8p3JzeHp+NumS64AB2pWLSDGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jcvLsNsjvkkkAGvCZgmRP/TZWuPAi5O3H9Y06TD1x4=;
 b=xozdHEHC332xUp13JfwVeiOXmfjPBrtWya1z+ryqDIzx/0lSqLDsNFl/rqoyEZXeI1Fj0Tsm7LH5FVU1Q+ZlMHG5o2xrKdPG8FkFtNV5Adw6axFasSDve1rEc1MZn05q25J37iH6l0wrzcmJKV2uO8A4/UCq4ldRDz94Y/48a0A+Z0Ew2S6wYBgND9xBbOo2AdtZ3CnnaZehHFtgvoofRcRMH4VCED0cqcDz58xSK7qG7JuNq1NY/7pg5QLW3eNrspWpye97d0uFCKJjDfAWCNSurd0F3Lo6VFZ6hTQwPCl4MAjywfkJP5vIBNzIIX4ogt1puYG12BDfJW4dEtWa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jcvLsNsjvkkkAGvCZgmRP/TZWuPAi5O3H9Y06TD1x4=;
 b=g3Ic/ymNiM5j3FkFZPMPHzrmIUSlIAazJCb/NADFDvppyQGdIrfT++Yu14JnDlJiGO6m63s6k7kYEefFRe7hi74tTOTc+OfLRn5QK83lmpbIlEDoObIon/lRr7Ixjt5EMZcOVqjxNQxIEG2RNhHwsZgQ97Qkux6XJTN1t3jVKe8=
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c09) by MW5PR18MB5809.namprd18.prod.outlook.com
 (2603:10b6:303:1a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Tue, 3 Feb
 2026 13:59:32 +0000
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::b876:8173:5121:dc8f]) by IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::b876:8173:5121:dc8f%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:59:32 +0000
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Anoob Joseph <anoobj@marvell.com>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [PATCH v8 1/2] cryptodev: add support for 256-NxA4/5/6
 algorithms
Thread-Topic: [EXTERNAL] [PATCH v8 1/2] cryptodev: add support for
 256-NxA4/5/6 algorithms
Thread-Index: AQHclP4slhGVRsm0a0SvfYSQEhAaH7VxADgA
Date: Tue, 3 Feb 2026 13:59:32 +0000
Message-ID: <IA0PPF0A466555A7179EB4241CFFD50390CC99BA@IA0PPF0A466555A.namprd18.prod.outlook.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260203111338.183138-1-radu.nicolau@intel.com>
In-Reply-To: <20260203111338.183138-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF0A466555A:EE_|MW5PR18MB5809:EE_
x-ms-office365-filtering-correlation-id: 30e8c15d-04c3-4c67-c81b-08de632c74d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SzBhUTE2Njc0OFZaNHR0UkNHOXp0MFJZT2E4VW1nMlkxQk1QUnRTcyt0aHNR?=
 =?utf-8?B?TXpXcEpEU3lwb0xOa3RORGFiclZkNElZUkoyY0xOUnpPY0FzVnd2dElBT0o5?=
 =?utf-8?B?YkVDR2wyc0dUaVZBSk0vWXFyOEg5MjgxeGx6VDZEU1l2NWs2RitOYkRwd1pY?=
 =?utf-8?B?Rm5zVDVSQ3RjaHcxSHBxK1dLODZQUXhuUW8xVHJlV3g2RDl0aXptWjVBczN1?=
 =?utf-8?B?Q3A5b2RJZFpDaUFlQ0UzSzlwVnBHRVA5TEJXTFpaNUNkazVIR1BhcW5qbDRo?=
 =?utf-8?B?ZUVaZ2IyNy94SHd1SnZra3dJM3k2a2IyaVFwY1JVZk1SYk5LN0E3VnphYnVh?=
 =?utf-8?B?MXo5cDdRQnkrdXg2Nkh1U2FOYnlYWmpPNU5STnhlKzZERVdJZnY4WkRmdGVR?=
 =?utf-8?B?b2k2SE5pL1NrNGlTTVp0aHl5aUt1aVVlN2hZNVZlOCt0di9SMzZwT3htRHpG?=
 =?utf-8?B?WjJKaUlFMmJiWE8zL0QyTWQxSDBqa21xdm0yK1VOcUhOcHBJWXpnVWVKNExQ?=
 =?utf-8?B?RTlpcVBnbGlGTG93NmJHbkRCSy85ZDkrK0RjRUV5OHkvTERNKy84WVowSnRH?=
 =?utf-8?B?Wmc4ekRoL3I3M1Z3RlIraERLblpJNHdmV1NrSU00UFpWODB4MzMrblFqUGJW?=
 =?utf-8?B?WnYza3phbHFRYkQ5RHlvdDRpdTB6UmRCazBrNEZ6ejFKemxSUVdHQXJ0aUdM?=
 =?utf-8?B?ZFlKeWR4a1FNMjBQaVJ2U1RZYVVLbUJidDllTXdFT252ZXQ4K2pTT0tPOXRw?=
 =?utf-8?B?UGNHeXhtaGZIbTFmVmNQanVmOWp6N0tXTjNCVzVTRXZYT21Td1FyVzZNUHA4?=
 =?utf-8?B?bmgvL29IMERNZGF4Q091SnZRdjFRdUo3OW1BMG03dnJzVE9yY0swS2JRWmJy?=
 =?utf-8?B?QjZ5VDBTWmRlYThmSmNaMzZJTVFXZDZhdUhUa2VVV3VUc0JDR01pckM5VXlj?=
 =?utf-8?B?TVZvMWN3V0kxVk9pcTJib0VhY1ZzRGNsY0FFQkk0MUVHRnFyMm5oNkh3MzBs?=
 =?utf-8?B?OFFBQ0hiZWlHL2kvVWs5d3gxaGtuYkw0WHg5ei9VejFoUjlabDBicktFTzVr?=
 =?utf-8?B?YXhIdVlnNnJ0aFMxUlNNQmFSakJONDN1TG5HZUJ6c3IwV1h1THhLdW40NXZV?=
 =?utf-8?B?RVVzRkVPdFF6RC9PRWZBZlhkQkVMLzM4MG1yTkMrdEFxaWppdnptL0FVOGt2?=
 =?utf-8?B?NFRjb01vc1N2b3duODN0RzFkOXA3WkhxLzZBdzJyRVhUMGVuNGp6ZTBLb3NH?=
 =?utf-8?B?cmtlcGhQYjZ2aDBZMkhJNnJxQUtBVXBtOE5vOG9VWVNHVHRpNTBjQUZ0cEph?=
 =?utf-8?B?bk4zMzc5ZzZoUlNkMVRyZGpGbndDS0lMdVpDOXlLeDNOL2tGU01hd1pPMTF3?=
 =?utf-8?B?V0EzLzl3UTBwOWk0MnpTMTdTZVdjbDJMMUZyN0VHVVk5b3lWemVQM2R2cVpR?=
 =?utf-8?B?aFdObWRGZ0Z0Y01ycnl1Mk4zS2p4TFZTNmlxaEpxTEoxZUh1cHFUdGNrZVdp?=
 =?utf-8?B?WnUzZS9XWXN5b0tPRlF5amoxM1phTmNLalkxWitKY1plYndSRU13dVYyaUpu?=
 =?utf-8?B?RU9MZlZJMS9rZVovcWdVdExMK2FVZVQ5RzR0NmpMbzlDdGhKYXQ3UVlHL1lu?=
 =?utf-8?B?VXp5NDZqUStqNk5scW95UWRrRjdlYkxZaGhtM2s1V0JEYXYyNzRob0dKam5j?=
 =?utf-8?B?M0IzN3BQVTZqOS9mRUFaYm9PVGRJMzJQT1FuUGJ1RStueU5aekNFUXZ1UWhE?=
 =?utf-8?B?cFpPcTFSMEZ2cWRZSWJLSndoSnJUYjVSK2hJVkFOMlQ3OU81QmJ6UThpSnNG?=
 =?utf-8?B?WXJ3Ny9jT1Q0cThHTEExWEJ1Q3VOSnhoa2N0QjFDK2N3dkV5YXo0NSsybDVa?=
 =?utf-8?B?eFhDQURTWUhORmt2S2JTaXltLzBuWmxPQTZ1cVdZMDRCdjRvR2JTeXVhQTFm?=
 =?utf-8?B?d2NHS25LR3hKZDRzL2NnZ0hHdDRKL0JJa1Z3NU9YVXdsWUNVMnpDSXhqZUVl?=
 =?utf-8?B?eU1BdExyK3ZGcnQwMEljc3YrMHI1SVMxSXk3WEJTcGZ5ME1Xak81TzBpS0VJ?=
 =?utf-8?B?aUo5TmZsU0F4NmI4WC9vN2VDb2tvcTBueERrSWgyMks1dVhtVDBaZVZiWmQ5?=
 =?utf-8?Q?qEyCRLKS2m6UoSiRAZ4awiocw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF0A466555A.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUhPMyt0YU13TUVwTGErbldlbEZVUjhGbFpWSGFTZ1c0UWR3S0dtUXoyenBt?=
 =?utf-8?B?amFBNlBoZ0ZUcHRlaTlqSUlXNGVCbTdpU0IvMXpkcm1LM0daeDJyanliTEJ0?=
 =?utf-8?B?ZDZVd25IR1ZtOFk0M2JJQkZOT2h5RzIvWmxsSDZBYk1zUkZCaTQvRWttN1JH?=
 =?utf-8?B?bEpPNUNZOTVQQktxMHA4eVlHSzZsTENJa3pFM0dSbkI1UitWSFdxaW1UdHc2?=
 =?utf-8?B?azVTVU5rSE1nVk5BUmNRcHF1dzdDSVJQRk1iTGUwZ3gzQ3lDZzdDRTlZbllF?=
 =?utf-8?B?SnlXdnNwZXNwVGh3dGR6Rjh2MGFRTkRITFJtNkY4RjU2am5YcU9aRFIwaDdY?=
 =?utf-8?B?WUtLUnNqSmxKZTZjRlg0RklxZVdGNldzdlc4R2hUbmNneVEvaFZ1cmVUU2RJ?=
 =?utf-8?B?REY0Y0p2K0RhMUpGUFdOYWF1d3ZuTi9KSGRpdlF4QkJmRjk2amExbEdWRE5G?=
 =?utf-8?B?S0hvNU5BNzE3NVB6ZXZJaThkaFdkSXUwdFJ4aVlqMWtVZEJUQXF0ZUQ0Yyty?=
 =?utf-8?B?clVBWHgzeXE2ZEV0L3hHdEdEWVJxWjdGdEFSSms2RlpISTlHTFhNTUJaVmZS?=
 =?utf-8?B?NlhjTlNxQWwyQzZ3bHNLRDI5bkNuK1FiaGdwcmVNSjE2VlBqakc3blZGTFU3?=
 =?utf-8?B?bVNoR3VDN05vR0JOdE0raXNWby9BYTVyRVpOcDVtMW5LaEQ5TGluVjdyb24x?=
 =?utf-8?B?cng2Ullvemd2eFVsMXVHVGNNRFVQVWRzNzZFdlorTzFqT1laaXN1dTRlYm8y?=
 =?utf-8?B?YUNaY1VYSWRVbHpDamk4Zk5GUm9LRG94SEhnVGpsSDlrNzhZN2Ird3JWQUdn?=
 =?utf-8?B?Q3krT0w1MkkyMlN4NW5GQjNQb281RFFpaS90emczQ3lIUWhTcW9wdnpDeGpM?=
 =?utf-8?B?YjRsMVV1VFFzV2pnQ3VoSlByLytSRWZPZGU2a3Zvd0ZpWVVuR05jaW9KSkpU?=
 =?utf-8?B?MVpJd3V0akRwa3E4aHBQaWs0RFpNRWlTR0FRdTBpejRzcmJ0aXFnWmEyVnVv?=
 =?utf-8?B?ekR0MmxmVVFCbUlHL05NWXMwZ0RyVnp3RnZvSzlwSGtMUVN2aXcvTGJqOTNn?=
 =?utf-8?B?QU5sQXVDakl5MzM2MzlYbU1jWWx0VjM4S3FUZ3cvT2FicjJIcEdBdlZESWdY?=
 =?utf-8?B?SFUrM3FpRk00ZENrbXo5V1ZLWTVXdVNvTFQramp4TG4xL2JuRUtoUzJrLzU3?=
 =?utf-8?B?eVBtaE1MR2I0SFpqVlh1UWFDbzZWaFB4ZVdnVzZZTzVZZnM4bnVFeXR0SHRY?=
 =?utf-8?B?UEROWFF3WFRCUGNZNUlHZ3pyc21YNWdCNmFYVmVjWGk3ZXlTSEV0VEc4cU04?=
 =?utf-8?B?Q25VRWNoY0NJRGVPcjFpWlp5S2ZsaHdPRGdBVHowRGZTOGI0ak9OdFh3TjZ4?=
 =?utf-8?B?NGtJc29yQnI1WjFzTkpoRE9kc0J6Zng5bUdaSHJZUFVIcVUrMzJ6cDJFejVq?=
 =?utf-8?B?K0d1QTJ6LzdDSHBXT3UxMExvajNEZWtBcm04OXE5djA5a1h4Ym9RUXlFc2dV?=
 =?utf-8?B?cWRNSWNXQUNyT2dFMXlhZXNMNy9NL3ZvaVlpYmJBbWx3TmNBcUVRbW1BdWVR?=
 =?utf-8?B?R3BsNnVVcW5VMVF2d25VMC9hUE1zMnM3RUtOVXRZc3lLSVZYNHFzNGJYUXdh?=
 =?utf-8?B?ODQ4T21KcmIzVUdEZFQzQjlFNVBJVDNwRDZIdjNSNnQrcFYxMEQ0YXRTT1Y1?=
 =?utf-8?B?Sm9XYlE3bG1wUXdtZzlaYWk3YklHOUU4SzJrQjRQaUZ6RUkrazBlUWF4bExX?=
 =?utf-8?B?RlI2ZzJKd2Y4c2hMZFJMUDk4YWxpVDdQVmNUNC8welBwN3hQWWJmaFUxc0xH?=
 =?utf-8?B?OFBPNXI0WlNIRm14c3htNTE3Z1UyUXhuYTRKcUNEbHlyZFNTVGVNOXBvTHQ2?=
 =?utf-8?B?WnhFUDNYYzN4QW8vaDlXOThmMWhoTFJlanJ4cUQvWTlGa1VDY2NiMlFXQ2Nj?=
 =?utf-8?B?SituV016VFRMYVZBM1J4RDJmYVdiZmJxMStPd25WWkJlQUdObE1FeDZoYlpk?=
 =?utf-8?B?TkxCaHVIY05Fc0RLU21LWDZKYlY3MXUxNlZiTm53TWd6Y2N6SkxBMGp2bk9n?=
 =?utf-8?B?ckVPUzRxRDcwWlQ1ZGlZZlpXS2pRNFAvTTV0Q092MzJHU200OXBIV1V6d0hL?=
 =?utf-8?B?WjRvR0hlWk92ZDQrZ2o1Zm1xcHZOaklsY1NTcHByMHMzbHlLOTluMU5rcjYx?=
 =?utf-8?B?TmNSMDllSWx2ajlqc2g4TTF6bHRUY2owdkRzTzJEUmIwZ252MFNrdmQxbWo3?=
 =?utf-8?B?dUZnQ3FaYnpQWlg2RlhHM0pLeXJXaWV6VXZGYWdNN1dVMm9MTWx0dDJDRGZm?=
 =?utf-8?B?b3c2WVhCZDZHMnR4djVNUy95bENmMzVEcktqMk15T3R1bkhNUW5BZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF0A466555A.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e8c15d-04c3-4c67-c81b-08de632c74d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 13:59:32.2981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: II2+fsRDV6qfP3h4s2mypu9LRpdoGTOc95S7j8IRHD0bTDgGESwQ4OSVPy69uajQDZSBJZyTsP4zM99xRBMVhx+eA8DkmPDJGgpapQOBqiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5809
X-Proofpoint-GUID: ksIb78mlcAvlYuUq8U7jnTfosrIDWOUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDExMSBTYWx0ZWRfXwjad4SftzyQv
 vXRgjZOyYA9iN6BAR2lRki7p0dJVyN+mwqzUgyYti4oL6/YktVwuJ91UnCp1tWMSjaeB4tk7kS4
 2ys30ZQftE1ljZ5ihSvlipdJ3RFHeUFqZZkm4Sjnn/XXP+ZzZ/EjbvFGFbcXNyYKyRppg4mp3F6
 AC0wDHuntLe1wi7l/P8a4U22ovj4/MnL/gUtMYn6DQJOiCzyAuGpUWsDqQjhhqrdFI5WhZkK8Bw
 KVAMN7tIKq/IuJZcV2xPyb95TaM9Z7r6Y8Z5kF0DV/nT9caklyEZ8m66a1PjiaBouNTRoxF1w2V
 Mqao8oOV/VFGzm9YdOBKPZvFRETNTkYy+bX3YeRiGFyF7wYhZZD8U3fjQrRc7hC9BuT9GhxXS6B
 mMjf+M9m793iKw/3klVGG5tUa70sxycgyKTUquhQ/KljdbLZjUhnNONPVF14VCgKjm+E9Tbp04r
 Yun3/IWacuIS0ByjZrg==
X-Authority-Analysis: v=2.4 cv=UP7Q3Sfy c=1 sm=1 tr=0 ts=6981ff4c cx=c_pps
 a=xKt9kXuiMwQaJDL2paq1FQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8 a=jZVsG21pAAAA:8
 a=pGLkceISAAAA:8 a=RpNjiQI2AAAA:8 a=bpLqiFhlVsLz5z-7AWEA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-ORIG-GUID: ksIb78mlcAvlYuUq8U7jnTfosrIDWOUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
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

QWNrZWQtYnk6IE5pdGhpbnNlbiBLYWl0aGFrYWRhbiA8bmthaXRoYWthZGFuQG1hcnZlbGwuY29t
Pg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFkdSBOaWNvbGF1
IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAzLCAy
MDI2IDQ6NDMgUE0NCj4gVG86IGRldkBkcGRrLm9yZw0KPiBDYzogTml0aGluc2VuIEthaXRoYWth
ZGFuIDxua2FpdGhha2FkYW5AbWFydmVsbC5jb20+OyBrYWkuamlAaW50ZWwuY29tOw0KPiBBbm9v
YiBKb3NlcGggPGFub29iakBtYXJ2ZWxsLmNvbT47IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3Jn
OyBSYWR1DQo+IE5pY29sYXUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+OyBBa2hpbCBHb3lhbCA8
Z2FraGlsQG1hcnZlbGwuY29tPjsgRmFuDQo+IFpoYW5nIDxmYW56aGFuZy5vc3NAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCB2OCAxLzJdIGNyeXB0b2RldjogYWRkIHN1
cHBvcnQgZm9yIDI1Ni0NCj4gTnhBNC81LzYgYWxnb3JpdGhtcw0KPiANCj4gQWRkIHN1cHBvcnQg
Zm9yIE5FQTQsIE5JQTQsIE5DQTQ6IFNub3cgNUcgY29uZmlkZW50aWFsaXR5LCBpbnRlZ3JpdHkg
YW5kDQo+IEFFQUQgbW9kZXMgRVRTSSBUUyAxMzUgMjQwIC8gM0dQUCBUUyAzNS7igIoyNDAgTkVB
NSwgTklBNSwgTkNBNTogQUVTIDI1Ng0KPiBjb25maWRlbnRpYWxpdHksIGludGVncml0eSBhbmQg
QUVBRCBtb2RlcyBFVFNJIFRTIDEzNSAyNDQgLyAzR1BQIFRTIDM1LuKAijI0NA0KPiBORUE2LCBO
SUE2LCBOQ0E2OiBaVUMgMjU2IFpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydCBQcmlvcml0aXplIHNl
Y3VyaXR5DQo+IGZvciBleHRlcm5hbCBlbWFpbHM6DQo+IENvbmZpcm0gc2VuZGVyIGFuZCBjb250
ZW50IHNhZmV0eSBiZWZvcmUgY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZw0KPiBhdHRhY2htZW50
cyA8aHR0cHM6Ly91cy1waGlzaGFsYXJtLQ0KPiBld3QucHJvb2Zwb2ludC5jb20vRVdUL3YxL0NS
Vm1Ya3FXIXRpM1oxZjhVWW5XYTlHLQ0KPiBjbWYwNkQzbnNyQl94eld2UHBzVE9aZnhhR19oR0FX
QkxpTG5XU0RwbHZXN1VoRXJRQVZxX2RmQl9SQkoNCj4gV0E4UVVlYVQ0bDE1QnBXUU5WV3VTakFy
LSQ+DQo+IFJlcG9ydCBTdXNwaWNpb3VzDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+
IEFkZCBzdXBwb3J0IGZvcg0KPiANCj4gTkVBNCwgTklBNCwgTkNBNDogU25vdyA1RyBjb25maWRl
bnRpYWxpdHksIGludGVncml0eSBhbmQgQUVBRCBtb2RlcyBFVFNJDQo+IFRTIDEzNSAyNDAgLyAz
R1BQIFRTIDM1LjI0MA0KPiANCj4gTkVBNSwgTklBNSwgTkNBNTogQUVTIDI1NiBjb25maWRlbnRp
YWxpdHksIGludGVncml0eSBhbmQgQUVBRCBtb2RlcyBFVFNJIFRTDQo+IDEzNSAyNDQgLyAzR1BQ
IFRTIDM1LjI0NA0KPiANCj4gTkVBNiwgTklBNiwgTkNBNjogWlVDIDI1NiBjb25maWRlbnRpYWxp
dHksIGludGVncml0eSBhbmQgQUVBRCBtb2RlcyBFVFNJIFRTDQo+IDEzNSAyNDYgLyAzR1BQIFRT
IDM1LjI0Ng0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBOaWNvbGF1IDxyYWR1Lm5pY29sYXVA
aW50ZWwuY29tPg0KDQoNCg==
