Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7063C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:09:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A373040695;
	Fri, 25 Sep 2026 09:09:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5FF08400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 13:30:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5eRCn2060760; Thu, 24 Sep 2026 04:30:51 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023102.outbound.protection.outlook.com
 [40.93.201.102])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gvkhhbh32-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 04:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQb2mCzyJBWau/rC/YPVm0t4GthunGYod0uysAs3BFjPEUrcwIq8enQU9oDffuaiDn7tfWnP6SoV4yhS3C1Up45zhMZQ7j/RNTNpmhIBZiiKtWMSFbjkYmvCQHBQottNGOA76c4o8Mj90+mZNAblnJPDCXMWEkAPTST3jFeSwUMcX8Afy99RzfCxB0KtJi7EU9/EalfMWsi8+iOnZFCnTrXUbgTiipUgcadZPKCImEhNfC2fJxYab6Ga1xTMW/6cJNsBS7okcRMCUkd0CYxD9lsI6V1dQntGFcpey1l8myEoVr+diXZ/+K7TeADICUpweKvNqHFd7WCigZ5PX5m7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIpjZ31GCJGJHhr/YWGtopX5m2aLODY1WoKtLdK9g+c=;
 b=Ct5aFdjRkAcG5kXnVCBB6YPZl/zwBpPPGbtpse/OhK2IYa6bFw0zJnNiTSIbCClQbdUXuwbp50tPVbjHW8enLy5GF0LKzM3slSg1QnoT7Y6ORQVQ+ixRqMyRE7m4zgGEm2YQl8a9KXBc1ntKgCFy6xMnrDqZEXGhkkwDRCLvIIlnKbg9Of9UzwaVI7XK7FZdMnbY9SGLqM6VTqy+f/RJqLsEBBhrI7S+nOq+2YNuAWEA6kCW0b2A+1Z9itFsjLDV1tEKzwUNB43PRRXFV/7jeG5bYBB27w/l1B4560UuDHHxYWf+ZJHSoHCwJ9qN3GBq5TuUaALkrNwhuT/QwVTekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIpjZ31GCJGJHhr/YWGtopX5m2aLODY1WoKtLdK9g+c=;
 b=WYvIQjSztjlXGw5gZzmpr4Xg8EVxWAJRjI4Sef/pHb+M48u8sNfxRvaERMH2EzbfRenyTa0d6RrJmY/v/JTAC/fCYURHqi5hnR53b6zG4XJmaezENcUh5Oxrdrrm31OzKH+kna53oM7CRTYJh912W9hbOjSOZ+eqOmoEoUT4K3E=
Received: from LV8PR18MB6078.namprd18.prod.outlook.com (2603:10b6:408:224::5)
 by CH3PR18MB6074.namprd18.prod.outlook.com (2603:10b6:610:1dc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Thu, 24 Sep
 2026 11:30:48 +0000
Received: from LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2]) by LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2%3]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 11:30:48 +0000
From: Pratik Senapati <psenapati@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: Re: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
Thread-Topic: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
Thread-Index: AQHdRo2wwv3D84xYDkuxjKKJAro46bbSmVBAgAAFD4CAAD7GAIAKwAiK
Date: Thu, 24 Sep 2026 11:30:48 +0000
Message-ID: <LV8PR18MB6078C87C7F16C9DA0692213CBD812@LV8PR18MB6078.namprd18.prod.outlook.com>
References: <20260917101641.335926-1-radu.nicolau@intel.com>
 <SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com>
 <5ac0b690-b340-4cfa-90e6-33cac4c30eac@intel.com>
 <29a23773-d16f-4065-859f-f85646442cbf@intel.com>
In-Reply-To: <29a23773-d16f-4065-859f-f85646442cbf@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB6078:EE_|CH3PR18MB6074:EE_
x-ms-office365-filtering-correlation-id: 539b5d06-335f-4170-32ff-08df1a2f47e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: WXEY4NuU+po7q/OQGkMbMZ/IxG5K+L4RuruJVqPZHTBFCRqtHl4jlLgrb3hRiYBTKOLVVhM64NwNprcmdh7X9UQoaa+hpkd2KaoHKnW1iA/IuleTiT7ETlbObsECBN1OQAAbrJ9whuGrMAKt4dS2xAcwI+/+9G50kNctLqtuIGTz8zKz0HdnIhnRvpneM7TPTJUiCkdFUprbo4FXzYNR99QbYRqHzNylZOSX9vKYyXgWW6N90LTDOK8K+ROhnTDrgFLEvO0jn2fs/Lv+rO0u+zvsX25fTrrHEs8UE+AJFReyRsc5afBopaVO8ppKPfsYEAoUCNGdMcCMGoyZzHOERJ+FCVdZXlroe+2YL7jOMfA+0SCQe9V4AKFFJI20afVJrUYDRjvCZZnL/VgzyeC7fodzCPGD9ZE3XBlYze//7EHj6M9Iv7tx8oeYPAxQtBfaR9A2L4myhHh33zwXeoTar61omS3io7AeynvZoIfLHn47R9zxDa3ZgnmxDg/9i/YUh6mKy6ygQWJQzV2Ml9zlL62I0FDrrYcibZLkGMgg9r2GxVQ6IbeKWWSdkj92FsWCxtVd7Bc5AvQWDsG4CHerHzF6hoCZJla+9eGzCdU9GqaYH6FD2g/Ut5VXQfUhcPMutr9eKG18nAA8jWTmrlw3oLwNYcl0zum0hEoeiCc2Cg9WoHhesYk8NkiWDCF8RcxueO7B9wBYjLSrnr6RLRzuTLoEI4gFVR2wEU1B7aKUENY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR18MB6078.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jcSwb2OCU4WBIXsQpEOtyPteACJFV//PvAfwNAF0Nwy81Vh7dYxI9jU3Vn?=
 =?iso-8859-1?Q?ptVpEZr6Ro5PGpJlgg2Z6jxe/LlLPTEeEf4GOhbzIKYHKpkci03+doy6tg?=
 =?iso-8859-1?Q?eGAxs0tkDKt1ygJrD6a6Z6Rr33ynzlIkrAvRdwE8vHKxdMny7Jfl5zPZzw?=
 =?iso-8859-1?Q?gF1UM0bcFaneJGHxkXJIO2q2PciRB13Ora0tIWsYZNODWz433VO6m6CLeb?=
 =?iso-8859-1?Q?BJkxYGePHvPKE/dOrkWHrpBNaB/6JMZlAydj3cE0cPVTK0xnHHHyCg/wA7?=
 =?iso-8859-1?Q?U8ksJ8JwVn/G1OS1d4a5JIMJzLiWjFMZ8G6Iv3ogUPaMog+1TDHaLtMXmX?=
 =?iso-8859-1?Q?plajImEvghTqPUwXwNROFVFDjj6VOs5w/Tk6gVRUh08L01JiG8KUqtIPwG?=
 =?iso-8859-1?Q?xCKVMQLiofeyyqj4+SjcxO4sYH9jIXzgGzagmSo9VWqNkHdiHStNnO27G3?=
 =?iso-8859-1?Q?CVkNiU6WhkYcrY9vWCUmdx2/LR5xvXHIWxoWf/ulyR5aV74PfKgbRDl58K?=
 =?iso-8859-1?Q?4cdOvS6gQMaqJJ0jpmuygpBjq1jC7WbQk6yCdOtlQHlM19JGvBQDC8Y7NC?=
 =?iso-8859-1?Q?QtWTz8RNSjaAGcVenvP5eav9e0F7NHFP4uFdB++B+PR71uV/sdOwEWGIr6?=
 =?iso-8859-1?Q?3bGGUkVb12aiCMLBRYqBmgk6kMO0B2wvgU6iAl+3W1jDG6P5HbQfcgTPgz?=
 =?iso-8859-1?Q?76THLu2gP1u8AqQ6YfO9EKleMYrWF9r7kEaKA40Q3zZOYBTTZByLbW1ZMB?=
 =?iso-8859-1?Q?0wJS8rKejyooVrgm70rgrIZ4nj1vAdz1nar7z4L30m1O9QRwgyMXD9ebN2?=
 =?iso-8859-1?Q?SPwWaIp0oR92y2jpRKK6Y3u64NslY4/2NhDBRG5ZKqsQxIsOPSVWRtMg7p?=
 =?iso-8859-1?Q?p9wpnxiuH7hrXuL4imWagah1IKkwbCzR7JEc86GKbZnRbKrCVf94ia2Iom?=
 =?iso-8859-1?Q?7yH6yKV3WNToEr8A16YohEAuqQmIJpx1iYrP+4Pvk4KSwC2q4opEDgsWdq?=
 =?iso-8859-1?Q?ZnpiFfDl3NwCW1IMEBGgPGuDWJPLMmhdHz0pKtvGYlgtUxlRiyEALa/Y5E?=
 =?iso-8859-1?Q?F0ArhTUxcuM+XpKvB+rIw3l5hPZyJMVCzXTH9apk/n0LFY2mICejHCeL0V?=
 =?iso-8859-1?Q?qHdQYp2fAp3bqFHWVFeXruvvMI68Y1BD4YymZIXY0nxOFmUZ1m7idJoLLF?=
 =?iso-8859-1?Q?xyxXxUfVUWONlLx/p+VEvocBpTiwnuQDqBO8QaTYl4yjMwwnBNQfVFyjcZ?=
 =?iso-8859-1?Q?IJjpb6/5k1trh3nIk4+ciI5SnjG/Jr7tswtxSCtvYQzLmzSDs/rFZxhT7i?=
 =?iso-8859-1?Q?CPCoWvXc99TqDG0C0mPtEwq2TfcFcHB3oOMq45k0XbijaT3Nwlr1KkZHWo?=
 =?iso-8859-1?Q?ru+q8A6Zws8Oztr6Cb7DNzdRULH9fooRWUYSk/RtPwHTqtQj9R6OZCOuTO?=
 =?iso-8859-1?Q?Oe+TEHDefIziz00uR6iwSRdstSJX9+ic81NHuDyAKHrs6XDfj8iXZDVMmu?=
 =?iso-8859-1?Q?pYxdyGWnt/NvVs34LU0ClmE4Um7ZTFOPTnK44nQFRNiNAEqemfmYT8geXY?=
 =?iso-8859-1?Q?/8m6emvs46H2L+xlMVaczUyiL3OjUOprDMX8LP7D2W4oWWiKfrFBnfXHMQ?=
 =?iso-8859-1?Q?Oius4fiyuSmbpxnkg5UtSO73GBGjmHUoFDLYov6Xfa9S0X0y2AWhjedB9D?=
 =?iso-8859-1?Q?/PeHm+zs2hHuRo01usviXvC/R2v0ZxxXa0XUbAs4uvJgCkG6wmzZrBDi/e?=
 =?iso-8859-1?Q?9ZpVYMGyt5BD3WcaAwo3ZKy+4HfhxEvWnPwmB0MK1a5ZwM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CzuxPWj6x47kpdAt6or8n4IZr3DH4Mlpz4zWaUG27hFxUVlXdd/63U+DQLh+lKgk5rTcrshlCmhJwp45SpBcHSEwyuao2bjTHV8Emns7BaINWzwrspbmht06Ls+X/bjX/O/kn1ZdH1M/Bg+ShThh53NnaPHp7PHYJvN4oFP03Wil76q9I+K5ZnmMDz9jpwZCz0V2ZbT+zoIFJ8vljGWW0POIqvtwqnD8BcwxEfl0V6CCvgz5VmyjQMPbG3+e5s6McP3URQRgP6JvIiQyCaIvXIef5lV2mIlAPDwgT8gIH4ZxljE5eAddT2y5ch948r1QTuSqVDYA1MYktjzJ28HK2A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB6078.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539b5d06-335f-4170-32ff-08df1a2f47e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 11:30:48.1331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoh+hAv3aYuKdKjBOTKW6/hUqbrH/6H4MXD3pg/Avw2IpAlBkv44w4yHhr1wqMeOhNheaLeQpuZbtZmI58+b8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6074
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6ab509eb cx=c_pps
 a=V5lscarYawUrr6zEozVj7A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=3AiFtWxwNcQeFGjNhAsA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: K5aJOevUVItuyxkLOijNUhbDs5TAv3qX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NyBTYWx0ZWRfX5yHclDYX8oqn
 Ic/q+XMiqj+ubTrfqNhgrpPAVc8qMIcGYdUhPQ1o6qIfJnGVaXgrsOR7opNzvGCsj7vgU2P9SHB
 j9woyCJM7lj3wxaVMh2D4RePR8SBPcU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NyBTYWx0ZWRfX9VyK008kbtXZ
 th69rfBlcYU7c7LbcMIn7LSIlYgMLQ85Ro9g4NDlyIqT01/5DUmQyrFwflp4qtt0NfF7sCG6xnM
 lFFlKwULQkdfwu2m8reu1Hgp4jpfl5ciG4cmw7F6wG0RwEU8c2rIhA4nTP8iGnejFLXj8ciVW9z
 M9b2jxO1zKKNy2pMcQWbHoetLQx5bOSqKM13mOCa34SFKdkvgHbJQENAD1+ATMe+7dR34s0YCaP
 zk9/w90UNYbvPRunnLfgjvIY4fzrAnUUlstQClXXjP3Fn4dqEHR/wFaVlhcwlqAe/bVNsIvsOmB
 SFD0tjCU7Atj3vsD9FCOFw9UY1TH3V2JM/udfC3+qIh17RDuN9/T42UvBBoO8oESOXOGsKO13tZ
 /Dht+7asyisASX3B5qTPF187jhUSl2xhDZ66Nkx30LT8LlgJJVURYX9lEzErMcfpyC1qlsTBYFx
 Y7jo2hLDeKqQMuHjUvg==
X-Proofpoint-GUID: K5aJOevUVItuyxkLOijNUhbDs5TAv3qX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Mailman-Approved-At: Fri, 25 Sep 2026 09:09:55 +0200
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

On 17-Sep-26 12:14 PM, Radu Nicolau wrote:=0A=
> On 17-Sep-26 11:57 AM, Gowrishankar Muthukrishnan wrote:=0A=
>=0A=
>> Hi,=0A=
>>=0A=
>> There is a series already proposed for extending the autotest:=0A=
>> [DPDK patch series 39137]=0A=
>>=0A=
>> Can you please check if that helps?=0A=
>>=0A=
>> Regards,=0A=
>> Gowrishankar M=0A=
>=0A=
> Hi,=0A=
> I will have a look at all the patches, they look indeed that they already=
=0A=
> cover what I did, so I will pull mine down.=0A=
>=0A=
> Thanks,=0A=
> Radu=0A=
>=0A=
> Hi,=0A=
>=0A=
> I tried to test the patchsets. The one for cryptoperf cannot be merged,=
=0A=
> and the one for the test app doesn't have all the test cases=0A=
> (e.g. there is no mldsa_65_verify(deterministic) test case).=0A=
>=0A=
>> Hi,=0A=
>> Thanks for looking into the patches I'll fix the cryptoperf patchset for=
 =0A=
>> the merge issue and any comments on it and send the v2 patch-set.=0A=
>> For the remaining test-cases, I have patch-sets ready, I'll send another=
 =0A=
>> v1 patchset right away.=0A=
>> =0A=
>> Thanks,=0A=
>> Pratik=
