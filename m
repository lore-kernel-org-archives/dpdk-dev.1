Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF5BC3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 09:18:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 851384060C;
	Thu,  3 Apr 2025 11:18:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 379AE4060A;
 Thu,  3 Apr 2025 11:18:39 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5332rNMQ028940;
 Thu, 3 Apr 2025 02:18:38 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45shsx8k7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 02:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g38ChOM+Eg6c5J3UKOtc6n+ikU34oUxI8hxftAMrT8w9h5KDq6Rr7kjBE9CxomtXX898kkF+GhNiJ1rliejXGiA27i+rqd1FQEwrFoudDGCqAwmFDhoRrzyGLafFEGGb9Gu0C8m6szrY/wLn+c4tA0V4jgKEMMAS0VLmtURr8Qn/K+tzGVP0Vk6ykyFLJHDxV+l+4ihWxK3umlUpZMATRGBm94sE7UXDytsuh52stE02GAEtxuuyy03V9CA2HZEDcIbbZkj03D6kmpRy3skTtOSOWRvrDCg3mq9hUJNFp8FyNlaXY3sTym/w61f95VPN7vFXgLrh/AlQOCWXDj2MKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqoDc3dg7ovoqReO1WDpLDL6V7KzRAw3VpLwzYjAOY8=;
 b=fhqU5NFJ3RxAMsP7hzcwmXH/P3//xKzcF/QODlQ22UAOWU7Lb7+G126mxHETVQMW47IZolQz8iXPSCWQmkDMaDESHeplIAx+mLsdsHFIMGZrxQ1Dm8A6aQC5jFsZWwRXBppZpQc4ljZnQxOn68NR7h8zR/OSmRcQ2o6Qc2v2IymMOyjw/O4yB1Hf/ZO0Pw3UQ4GQ1SiQgMW8tum1QoR3XD0qZvsuaUKYlsu+EK1ZCihETVoU1X3krrpMS5Z/yAsNjp+2qiKBDD6kDEpMk6/5hEu36ortpMILwyh1uAdMokXDyGPcXoD2VBn05+nYKUG60WoGzXdTAnGgHqNBO//aUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqoDc3dg7ovoqReO1WDpLDL6V7KzRAw3VpLwzYjAOY8=;
 b=eA0X6tjC64s2rMHoUayxHZWCE/Ye4GbncY9LVuD+8EDSCcKYgSZ8NLq7BDQI6iyhQ9Js72sRqfH/OmLsg/C2SIHdJ3V4zf2IXm3pxTwZA6iKxb+50x8iVrMUxYlPI9GC57Jj6A0w/wzXR/upwSXnohdBRZFSZkou+saJIm6CD/w=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by SA6PR18MB6245.namprd18.prod.outlook.com (2603:10b6:806:41e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 09:18:35 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%3]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 09:18:35 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>, Jerin Jacob
 <jerinj@marvell.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>, David
 Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] trace: fix out of bounds write in
 __rte_trace_mem_get
Thread-Topic: [EXTERNAL] [PATCH] trace: fix out of bounds write in
 __rte_trace_mem_get
Thread-Index: AQHbo7KYL/SMVcOQu0OS4FTIRZ4NGrORqxkA
Date: Thu, 3 Apr 2025 09:18:35 +0000
Message-ID: <CO6PR18MB3860D9D76C10AAB8A034CF1EB4AE2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
In-Reply-To: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|SA6PR18MB6245:EE_
x-ms-office365-filtering-correlation-id: 23854e11-3201-4457-110a-08dd729082cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TWp2WkFxTHlBMllBejZFODhvcEtuNzZIRTBIOTRKR3hlcFcwbkt6MnhCVm5s?=
 =?utf-8?B?NTN0V3hnUVp5OHpySXBEc0JIWE9mSHBtbGh1djlTcUpqelV3NzdCWkNPNHRk?=
 =?utf-8?B?ZHFPTlZFNjVYZVJTSkl4Q280bEtaQ0VvbUFSTVd3S2Y1N09JbGg3V2thT002?=
 =?utf-8?B?Zk9KQklnenRYVjZGdGkzbXhrWGt1MlRwYXZGeitRY3lWcUNmNnU2QVdSVmt2?=
 =?utf-8?B?bjQrL0JuaWx0Y0FSdG5JTUkrS3YyVjI3Nmd5dzU0eUVxbkt2am5NcTBneXdz?=
 =?utf-8?B?dE9xK3BkWEgzSFNzK2hnYVFMc2xocXd2Qi9sTCt3a3o1TE5PV3IwSlJJT2JX?=
 =?utf-8?B?andMY1ZUejJtWjB6eVBVUis2NmlIUVN6MzBJZDhLNUlsMGRMbDBjcDBLRC8y?=
 =?utf-8?B?OU1wWFRpNDVHZzNjclRYU0dlekwxMUV6MncwS2MyallLTjNVOC9ENm5UYVNF?=
 =?utf-8?B?dFVUaEFwTkh0dFVoUUdmWm8yV3lhUzVuZTh1c1dRNFVVaVQxbXJmMllCYlZj?=
 =?utf-8?B?WjFIdXN2SFVNK1hrOUVXTnJ4bWhjUEw1MnFnUEV3eFNDQXdkRktoOTNqZUdX?=
 =?utf-8?B?UU9pRkQrQWZEajRHOXFXblJFNVd6YTk1alYweXN4Q2U0ck9pNklJMVkrSVg5?=
 =?utf-8?B?T3krcXIzcnczMmRldFdJNVNidE5JWWtwWG82Ui81VlN3dUZNRjY3VTUvMEFU?=
 =?utf-8?B?eXluL2xyNklTWVRSUjFoZnRNUFF1aUZGMTN5M0RvdmE4SzlpY0VnY0NzdkVM?=
 =?utf-8?B?TVJpSVY0UTYyV3NQOEJnVUtPb1JIQWJhTG95bUtHNmpXWVVHb0gzM29DWDds?=
 =?utf-8?B?WHd0ZGdnNWN1SEI0bmRKaWVoSTBFbFJCYmFjdWNtNFZRZmpRRDNySm9xUkpL?=
 =?utf-8?B?bXpYQWRFaFFKSE83aER4c2xpWEk2NHA3KzRuaUNBT0NMODFEcE1BK2V3amNp?=
 =?utf-8?B?NmlKM3EreTVodlY3MmdkMUhZMDJqNGFTd0NPVlRjZVFIeDRWd1ZXRkFDbnhP?=
 =?utf-8?B?K3JQcmYxcHpuQ1l6U013VWVER0JiN2gycE0yK3o0SGdwT3hYYWN4TytMU28r?=
 =?utf-8?B?eXFyQmJENXhGOUJ3a2ZHeEYxL1ZTTURIL1JVbG5rTFMzWmprTGNSS0k1QVQ5?=
 =?utf-8?B?TzdCcEozb1Y3UmN1UWRXcHg1V1ZHRlR0NjRrQzhlbEd4N05KVTI2aFYrU1Zk?=
 =?utf-8?B?MEEybUpCWDJyS3JrcG9RelFOZVpyNDRGZ0J1enpKc2k4dFA1UFhjYmhaQXp2?=
 =?utf-8?B?Skx0ZkRHR05MbHFmblN2ZFhYT0locVFWRUY3bXRRRjg1dDAwZGxZWXdlcjBj?=
 =?utf-8?B?UzRhbUF3Ums0L1BXdkpTTFFzdUQ5cWZkaUpsOHp6eDByV1puUUo0UGlXTU4y?=
 =?utf-8?B?ayt5WHZkMUlBY2lvUHJQbU9iaWdhL3E3cU9ZZjErZEF6c21JQjZPWEpTejJj?=
 =?utf-8?B?M3FDdjdyYXZOQk0wUnFLMnVJT21qVUlJelF5b2M3QmtzSkpkZjNQWDB0SEta?=
 =?utf-8?B?Y243R203OURJZTk2akp1N0pYNmw0ZXdPaDFacmZHVkxISEw5NmZCM05lanZh?=
 =?utf-8?B?ZHZFNC9mVnZBeG1xS0Y4S1Q2RmwxZTFHUE5xcGM2eU9lVDljZ1hYZGVWY0l2?=
 =?utf-8?B?bXhSdFBpQU50UHJGcjR1d0h6VURYRXNZRmFvRXkyTVJZekdZQ2lzbldQRW9U?=
 =?utf-8?B?Ui9uL05vd3lFbzZFZXpEZFhTTUUxVElIWkp4MUt3M010QmdlQmN1MkdYMWt4?=
 =?utf-8?B?Ym1QYkhWdUlnaUI2NDVrdzFLYTBVUzZKTVhOOU55b2g3TGZ0WTBzUEE2bHZ5?=
 =?utf-8?B?elM2WmVnVU5leTcvRFpLUG9sQkxENFE3eHpLSHp2dWhtQXdSZ3Q1VnY2alhu?=
 =?utf-8?B?TlBGQ3JwcWxvaUpWcmp0b3NicForamQxODl6Qk9sTkVWNzVWanFPdWFkN2ZX?=
 =?utf-8?Q?dGlwbPIT0lt8M91owPQm4XWOuNhMvKTK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pWTitRL2hZcDVKNzJreW5OYUJ0UTdOeEQ1eDRFTG1rTVk2aGZ4VWRUYmJU?=
 =?utf-8?B?S0IvNmJHdVF0ZjBtdngranpvclRPNXRzMWNwaGhnQ3ZOdUR2VFhQenBvRDFa?=
 =?utf-8?B?YXNiUUFHR2NzTCtlbDNaRE9EeEVUWnFkVlZCK0tqSFBHcFU1aG1FdkVpNGdZ?=
 =?utf-8?B?YU1JU1pqUi9ZeG5iR1JvQmhhVGxjbFJnckNQTDE0TDlaMXJqVGtlYUFheU9K?=
 =?utf-8?B?cVBFWkthdHNCMzBCMU9tUHljWWg1bGc3TElUZHlDMUhPR3BEcDZRYk9iV3BU?=
 =?utf-8?B?cElrQmF1MEZaYUdLRTBJeTJGNHlBeXo5L21nZS9uUHp6eTlGK00vSVg5RjBz?=
 =?utf-8?B?Y2FjeTN1Ukk1aERUaDZsUlJkYmQwbEpkd2xyd21iRjgyUnhNbDBqREphOUU4?=
 =?utf-8?B?M2tpZ0RqMzJpc0UzYkVJNTdCaHZYZFlBSmZ5eVlNZ2wvTFd0NWpmVUJjVTYw?=
 =?utf-8?B?QzcwOHRMbmVBdWcwUVI3UXpkN3NtRmpGejMrNWMwMGQveE5OdjBaMXNPbjJn?=
 =?utf-8?B?ZldpSkFlM2Z3UldwT0Ftc0tBVVZpWUdTVDZnRlo3V0kvVVRxVERGcU04dGh1?=
 =?utf-8?B?TWVTd2dObG41UlNYbGdzTFNKTElYTEQ2YmJBZ2h1ak9TMS9rbGhwd083ZUJv?=
 =?utf-8?B?K0dkNVgrV294aVRUYjNCTDhSVDVucUlTM2pGZVllc2IwY0dScjYzdWpaMGp3?=
 =?utf-8?B?c0hqQnRmdUZ0Mi9URkZoT2tSZXN5OHFJM2VPam1XNDNUOENQaWxNZUlNelR6?=
 =?utf-8?B?ckp1ZGVDQ1kzNGlFS1kzZHlzTWVzdGNrMTZXN0JBZ0NueThjNE90YTgwL3gr?=
 =?utf-8?B?WGlKbVRORGxLNTVaOFowaUYvaG5tR0lYbk41cklxZFRyMG9aWWd5dTBVK0c3?=
 =?utf-8?B?bkp4Q1h4L2FZWnU2Vm4ySWdCN2FHMER1OEFsdlNZN1RWb2FIV1lraGN4QVZh?=
 =?utf-8?B?NTBXU1ZyNmhKQWF0Wk9RaWhLNHlDejZmMCtnb2d5M0ttQ01CUlE4aTZ0YkIv?=
 =?utf-8?B?NURRZW9DbkNMWFVGWmV2L2I1Tlk2OWw1Qzc4UXVSdTExaUwzcDB2bmpOMFRj?=
 =?utf-8?B?Z3dXNHB5RFJ6cVIwV0hIYlBmck93UmFHQmZXWlZqblB1bWE5ckpycjVLeFF4?=
 =?utf-8?B?Z3R0eTExZlRwS3lvOGZtcmtNamV3Z1BlTlBmTDcybnoxanBPQmF6cmRUdlZs?=
 =?utf-8?B?VTRKcWdNc09SdDBiejB2R3BWRnJwbkJFVms0dzhpeFVCQktPWDR3YWlHNDR2?=
 =?utf-8?B?dTVsaHRmMTJidTkrQWJLZ2V1TlFjdTZYSGZrOExqN0RNaHNjUEJJbGE5QnM0?=
 =?utf-8?B?eG90cHFnWTd1YndoTTdwQTRWK2RtbUZUcER6ZnpXZUFwaU5ZRXVtN253TmNr?=
 =?utf-8?B?a2JIelAvcUVvejMzaUpKOGd2SVhWdlJoSGRENDNocE9kMjlhM3hBdm1HV0hn?=
 =?utf-8?B?SHZ6a3RvSWFiYWdmZnRYZ3hSVmVsaDB5aS9ZeWlOeFNWT0g2QXU5ZmZQbWUv?=
 =?utf-8?B?bWRzQm9rM1l1VDZreXdhM1VhY1VXbGppMnVTWk9waDRmMFh0QytiOFd0YUhK?=
 =?utf-8?B?Q3NFNkl5UXI2T0UySlFNVGZxazdIang3T0hJZysvenJ3NVd2WHN2eXUwaWRK?=
 =?utf-8?B?Z1ppOXQ5ODkzZ1B1VHFUME4zek45VVVnaWNlb1NhOFJEQXZyOXpteDlXZVll?=
 =?utf-8?B?bmFKc0JqOFppMnhLM3hlVlllSnVLYURMRGlHSk9sT3NSRmV1aUhPZWJQMERR?=
 =?utf-8?B?OG56TlhUZkRwS1V6Tkg4MlNMZHgzMEJycnJ0cmMvaGdGdTU2SFZWSlgxWmZG?=
 =?utf-8?B?eUltTlRUcVNQRThBV2JuT2QvNi9Lci9EbndPK1g4NTQwY3FkRkRIbWV2WjRt?=
 =?utf-8?B?VEJoM2phUEorRTE0RSs0RDdrTEtBa1lrdDRVc0NJMUh5b1dicnhBNXR1WHNy?=
 =?utf-8?B?eGhTelFiZUVIa1NhMHh4SFNGcXdweklLdE5FZjZBTXNsdk0wd0h3ZkVMV3hh?=
 =?utf-8?B?cVFIc1MxcTRyMHV3b2oyZEVCVXhTMXZFZGVsSFhINkkrUG5LQW56aXZrN3dK?=
 =?utf-8?B?WEd3MEpac3BNN1lQUjlYV2kvbzNEUVJVUEdlQ0crV0IzallsNVpjbmlwdFJn?=
 =?utf-8?Q?HJhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23854e11-3201-4457-110a-08dd729082cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 09:18:35.1569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5MDhhH7HKZ2vuG5dTszGWbpfVBv/7pI2cViRBPKJCjiSWxHL/NY9P4FC7XvAzVEk+MHyXB4hG30nVso8ff1aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6245
X-Proofpoint-GUID: 69bLumg28OBo0bXTKSz6NbzH3p_goKS5
X-Proofpoint-ORIG-GUID: 69bLumg28OBo0bXTKSz6NbzH3p_goKS5
X-Authority-Analysis: v=2.4 cv=CIUqXQrD c=1 sm=1 tr=0 ts=67ee526e cx=c_pps
 a=OnljjeCONrlUuPUItWmgXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=Y8KpScVGsVSBS4ci:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=47DPPWgoAAAA:8
 a=M5GUcnROAAAA:8 a=uzIOBlUB_Ee0K5CWDF0A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=j_xVGaBrmtlMMe3VQ61W:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_03,2025-04-02_03,2024-11-22_01
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

PiBPZmZzZXQgc2hvdWxkIGJlIGFsaWduZWQgZmlyc3QgYmVmb3JlIGNoZWNraW5nIGlmIHRoZXJl
IGlzIGZyZWUgc3BhY2UgZm9yIGFub3RoZXINCj4gd3JpdGUuDQo+IA0KPiBCdWd6aWxsYSBJRDog
MTY2NQ0KPiBGaXhlczogZWJhZWU2NDA5NzAyICgidHJhY2U6IHNpbXBsaWZ5IHRyYWNlIHBvaW50
IGhlYWRlcnMiKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIE5haG55YmlkYSA8b2xl
a3NhbmRybkBpbnRlcmZhY2VtYXN0ZXJzLmNvbT4NCj4gLS0tDQo+ICBsaWIvZWFsL2luY2x1ZGUv
cnRlX3RyYWNlX3BvaW50LmggfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuNDkuMA0KQWNrZWQtYnk6IFN1bmls
IEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwuY29tPg0KDQo=
