Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B3C021A1
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3518840156;
	Tue, 11 Feb 2025 09:44:43 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 098EB40150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:44:41 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AMrdea019292;
 Tue, 11 Feb 2025 00:44:40 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44qg1babjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 00:44:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNq2VXG8TskA7Ijbnk6Z5Q26R63nOIeOnPTEd5z4BCEJdqFNc3XJPeO3C11N1fYdDhlSVl+iiirY+ohUH5VHywrPQeKEDj7IDFPRo3XzK7owheN/bzipCtEJOg8rE200d8W38uUVRL+eyujPZQ4lDjW6HW8OXYeTAh/oaJXLa8wuMNuI33/Hm+tm1ewPXampD93yBGtTy/8st/rEWXvb1Aosqm+q3DOBLpF8OCAaRk1mvP/FZ7g36b8a+Nyzsz2Z34imbF1sqnMA6lGRALwIuzkcitoq9MR/6DSjKzT7C//mU9z7wG0lnrolv2DFWZaBxdu7eJ3zm2P5CR5HnjgALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNdUUv+us9NI0jbCkiq1FZlQUFMw2dt9ubSAOTq0Pcc=;
 b=YepU+BrXB5GhXgwTqyI1vwJa+Lra6P8xWDnQBnaNiHtAlyq1xAxwWx9dVcfZRKmXjOmuBMDdpZEdwWfC9buK5EththOrlCxeZ+ZqEgO3PNMZjx8YjaSfL1SXw67ysT0lrQGM+rEthI3qiKce7erEfhIK/fEdXOBReUMIR5JdpSBME/3eDEaepvn8PM2bBU0LvovLMe3BLQwKqLI6+1KhADXbwGl9ZY6El17c64iHk+ahMuvR0up7TSuoN0Mk4oCDbMymxkxe0FVC+KbgsoBSYOwnCnuk40Dw/t3+vX7ZMZrItCPBWz71D93q+OKxbXgAFcQppnrywqVrSzWMuyYmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNdUUv+us9NI0jbCkiq1FZlQUFMw2dt9ubSAOTq0Pcc=;
 b=LvhATKJPY/5uGeh5W62TGv/djKdLdMFEDSWCRC/ASTK25VdsgPMeZpPrZqsAGxG/C/W48nXwkMqxw5jbCpHzBqYfCSxfMzNmjvk5irkOzL2F9ZfsB9LLkEoNI/41ihsSzd6HIUMRBxXuQdIEUV7ECjCoL4F2n75b0sY2lQMDeec=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by PH7PR18MB5283.namprd18.prod.outlook.com (2603:10b6:510:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 08:44:38 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8422.021; Tue, 11 Feb 2025
 08:44:38 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 2/6] trace: support dereferencing arguments
Thread-Topic: [EXTERNAL] [PATCH v3 2/6] trace: support dereferencing arguments
Thread-Index: AQHbe+N+1RrkIkA4JkajwQI8zdBQhLNBydUg
Date: Tue, 11 Feb 2025 08:44:38 +0000
Message-ID: <CO6PR18MB3860449F9DE83AF498DF2788B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
 <20250210174424.3364021-3-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-3-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|PH7PR18MB5283:EE_
x-ms-office365-filtering-correlation-id: 585893ec-50ac-4396-ffa9-08dd4a7851b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWRqZml5Umt4K3NsZWZoNHVIQzZNWUYrMnA2cjVpQ3p3SkYrN0pSU0cxdSts?=
 =?utf-8?B?aDFvNWZJbXhvS04xaG5tWWVOMVB1czNHdWdTK0xlc01EeFVvOHBZVlMwU3Y5?=
 =?utf-8?B?aXNvU2RjcUEwaWYwWVlNM25heHRPUFR2Y2RrL3B3SUgxV3BvMDhONDcySWVB?=
 =?utf-8?B?SmxNbyszNUlHRk1DUDZOcmJuYWdxbUVuVjdqbFFRbTdXRkg0MDF6NThRamZs?=
 =?utf-8?B?VjFrOVYwT25nWFZnRHEzZklsNDlTRzNvdENWOTJlQ2ppRHozclRUTDcwNHFD?=
 =?utf-8?B?YXExTHhFakdiRzZ6aEpSMGY1OWlnbWU3RXVpU285MDdtMUtCNERNaGFqZXlF?=
 =?utf-8?B?c1pCODVVMm5aaDdRT1FPQVFCRnlwTUhIZmhIWmtxeWZXM3pwTCtDcGoxQnFG?=
 =?utf-8?B?M0htcjgyNXhNR3dwS2NhUWo1MXNPK0c5Sk9HRi93TE1FVVRVOHJGcXhnV1dh?=
 =?utf-8?B?YlJrSS9QZEY4bk5BbmJjZVpxTVl4U0ZzNTN1ZHd6ZXlVZkhKRmdXanc1Rlpt?=
 =?utf-8?B?NURTdmFvVkJiZUtmczBYQ1BIWWpiUEVxQ1lRa2IrREJaRWdvSUx5d2lWYzdD?=
 =?utf-8?B?QU5GcXd6eUlvS3FmMU9FREVkSGFmWEZ0eGpVMC8wTEhHUG43ZXNOY2hPRksv?=
 =?utf-8?B?U1pqNk1SRDNmWExXWDR3SzZ6UEpwc21ESC90djR6anYwYzl5MzJjQzVzQXhz?=
 =?utf-8?B?Mk5BRnpmUmhPK2tYSEdEUjJoYXJhdXhseE0wVHorWkNBOTBJMlAxTWFzWWVX?=
 =?utf-8?B?cXo1Ym5Qa3dxblpwOHVSYkhNV29tandYWm5BTllNZGozejVMOEVNYkU4MDBm?=
 =?utf-8?B?UWp4emJ3dkxMV01GcUV2bkJnWTk3a29GVU8rU3NGZFljODJjazFpUXk4QkI0?=
 =?utf-8?B?ZWkvbS8yUWNWV0lROVhsb2c2VDUvcWttK1hDc0hqc3U1S05EQXdKUkxNNDUy?=
 =?utf-8?B?TjJxZWRERS9saUVoV2lVNWxsenc0R3d6UzJVZHI5ejUweDVYekZGNnIyZDlM?=
 =?utf-8?B?S1VqL25wM3Y2eWlWVVIvNDhpRWxnY1lhdndUaURQdmxyN2M2bUNuZ3A5eXh3?=
 =?utf-8?B?bXhUMkdualVmcnBmRWovSTZUZ240bjNZZUN3U0NGcExWWWlndmREbkR3dEdj?=
 =?utf-8?B?Wk5GN05reUExOXp2R0ZJdlN1YUlSN0E2dVJJK1RwbnJJdUV3b1FUUS82Qkdq?=
 =?utf-8?B?T00vM2M1aTdFTzliNE5wUlN4OEV1ekRUTTFKRzU4WmxON3N5anVSdXZsOERK?=
 =?utf-8?B?U0N4WU1JTVlCRnJkY0NlWWM0aGdEeXdoSXJLdU9keWh3SCtXbHpRSXBRajVN?=
 =?utf-8?B?dEYxemVQbEMwNHZHWkp0T2Z2bHN2RUxrY21HcmFHYW4rclg1K0NGUnRRVFhk?=
 =?utf-8?B?NzhIQWpOeWFxNXhTSHNYdDYrYmhVeW5RbmVmb1BGbVJMY1YvMlZPZUg3Nzlp?=
 =?utf-8?B?TmFQdDFZV2JSazRDYVNDdUpYejFFSk4vUFlvR0RZVEk3UUdLQ3ZLLy93QVV6?=
 =?utf-8?B?SWtuM0NtNWtLb3E3dGtXZlIxMWhKRlNRYmFqS09TVUpIZ3ZqdFZOSCtzNlZP?=
 =?utf-8?B?L2MxVFlxNHZhOWpKRE84QTNVbGx6Z2ZkZXp6ako4YU5LSjZsUHBzUkhndzFN?=
 =?utf-8?B?UjBsUEI5MTFNV2ZmTlhNa292c0F0MmNPcVlVK2hVYVJncXE2N0lmV0FyT0l3?=
 =?utf-8?B?UnJEaEJsczFucHp5aHozaUpOT0xtYkUyZURHaURUZkkya1NocmczOXBwQzhE?=
 =?utf-8?B?WXdleUw0S2tPMGhSdWJ0ejRCNkgzQXpWWklQOVBzbHE0VUJmVjAvV256MGQv?=
 =?utf-8?B?cHFIZ2k2UTVMTnd3b2M3RWkzWTZSUEdrM0Y2V1hnWlc2QUZONUk5SFV4TDBM?=
 =?utf-8?B?cXM5SmdVWDlUR2lORmdJOXVDK0huRVNINmdaMjRDYlJKRi9RSitpYUJhMzNh?=
 =?utf-8?Q?0hLxlEkn64ChX1td4+npRte0+CWcrEYG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTNqazRFZjN4dDFRT0ZQVUdsZTAyY0Q5SkxWLzFXQXJHd2VNdEZSMjZJS1VD?=
 =?utf-8?B?Nk5YMk5CUjZjaUdXbWJGWXo2R3A5TWZHQXplSDZIemo5M1pnMGtFYlBSSitC?=
 =?utf-8?B?Q29sMHB3VC9LWklnbysvRklwZ09nMFRxOCtPcTFSVEFxcEVKTnEvNVNVeVlT?=
 =?utf-8?B?VWhyaDFPUWtNZzIwN1dLcTZxK3ZWaVV1bngrSG1renFYWE1pR2JuRC93TjEv?=
 =?utf-8?B?YTh6UWdwdExkOGtDV3hSTCt2ZW1SNnU2ZTRiVjNhUlpJbXBaQkF0MVZBYnZ1?=
 =?utf-8?B?VUljcnlVUHBZQUQzei9YVFM5cmRSU3NobVhERVVuOWkzRnIrbTVRcklWOEx4?=
 =?utf-8?B?TXhNdEtBZk1pS29CbzJqNCs2MXNlYnpWRW93YTdMZ3U5Y01iQ3UySnlOZ1NM?=
 =?utf-8?B?dWR2NS9hWHhESm9XMmlRbXBRQ3RXWGYxTFRCWVEzMnA0dEpicVB4Y1VhYU9i?=
 =?utf-8?B?THlteXdKNThSOTgvUUZLNUpnamhYcHRqYXdGOVhFS0RQSEw4U2hkaEh4Wm11?=
 =?utf-8?B?S0FWU25ZbGtuWmpremFnVWhNTmppd2ViVkdPNDhFeEZsSEpIaHNwa1ZOZFJX?=
 =?utf-8?B?QTJXQVpBMzhWUVptZDR5dHRnbUt6UFNRZXp1cDJUNHZuc1RsMnAxVzVhSGN0?=
 =?utf-8?B?WEpYbzJUazQyYjNQeTNxRCt5a0czUGdtaTVtemhpYlNBMEUzV2N0VjJqdU56?=
 =?utf-8?B?Q0hmamJ3WDNPcTY5Wmc1MHNwamRNb0JIZ2t4WllRMURjNjlLSlprYmVmYmdH?=
 =?utf-8?B?WmM1Y0ZodXQ4M2kyS3VsbUZDeFZxYXNQWDA5SFJXT1VTUnVxN2tTK1l2QU45?=
 =?utf-8?B?V3ZHeFcxTGlSV0RYaElJd2lWcXIxcDRGNzVRdWUvTVBiczdyVzFacysxRGxS?=
 =?utf-8?B?YUw4eE45V0gwNCtIVjVWaEJxNUZZMUFMc0ZpTGtHaXhOS2RUNGw5TzdkaDRq?=
 =?utf-8?B?M1JvaE1YeVBjaFd1aG40aHR6Q2U0WmxwdjZVNTdyZDgrZnJSM2libmVnam5U?=
 =?utf-8?B?TnVIYkNoYTJ5VXB5dTBHcFduN1I0STdNWmFzbFU4VDh3Z1F4T3lhZEdxeHY2?=
 =?utf-8?B?VENza2lvVkJkR1BtWHR1QUtMSUFZY3RsNE5hWmU5M3NVVkxxcnZsUVM4cStj?=
 =?utf-8?B?V3JCbFduaC9hY1NKd0JwNVhCOEFrRHJZOG4yRXhLMDFiUjYxTVlFSmlIelJU?=
 =?utf-8?B?WVhSTTN1bHBzMWR0eWNCcnlSTUhIWjdzeVFPTVkyQy8va2tBTFljeGhMdFBs?=
 =?utf-8?B?cTgxcTJpeUxHM3Rqd3ZNL0xMVUpmTENTdWVmcFdRU1UwYlFSNVJBZmowUTFC?=
 =?utf-8?B?K3hEdWtxeWp5NGVIYytVemdzdTZQWEY0TC9sTXp1V04wdnBvaUhJaVFBbW9x?=
 =?utf-8?B?dU11dzRXUkRCZkMyeU1QWnVRb1RqR3U1N0RsTFpBeGIvaEJ2TFpSMG8yL1pF?=
 =?utf-8?B?eGJlTCsxYUljaStJd1pnSTQzeG9qNUlrQ0tvSUVOcWZqM0FTZyszQXRHeTkr?=
 =?utf-8?B?UmNqMXg1VmJUaGZXSHlJMTYzc1pEUmUyWUpVOWF6Z0hpWWJZTFJvdUp6TkhV?=
 =?utf-8?B?ajY1eTVYdFFTTDEyYjVydjcrc3pIYVRjWkFybUkxOVE1U1htWEZ6dVdCdW5x?=
 =?utf-8?B?VlZyV01WWXBFWWVVSWlNaWZIazk1RlpsWUZsZFVDSmo2ODFCbGEwMEtpckxZ?=
 =?utf-8?B?eFViNVhwVmovMG8xNDQvRENBejU2SFN6RGMrUUN1Q3hhalFvVU00VzRoSmhG?=
 =?utf-8?B?L0s3KysxN1FNTHhERERHMm9EUlhQNW1wdlczZmYxSTNZTXdVaE1QV0w3V3Bh?=
 =?utf-8?B?aS9TU24wU1E1cXhuL0hwdmlIcjZ5dUFlckhXUklkVUFzWk03S1poUGZPazdY?=
 =?utf-8?B?aGZuN2JqM2NjVjRtdVR4bFNVMWVsYWdjbGxDS2RkZ0hkdHR0YjM1ek9VOFJP?=
 =?utf-8?B?RnFDSCtzUUhqS1pYcUt6RVdqV2V0ZHJQMnhjc3JWQ2E4SmNOd2N4QzFkS2RN?=
 =?utf-8?B?UW9VNEVCMGEwVEs2L3VSdVVIQXpVZEJHQlEzUTYrUUlUN0dMN1hVc0llcCts?=
 =?utf-8?B?OXUxdHR1NHZxa3ZiZ0g2VlFvbVV4aDhHcHl3NFZCNmNWTWZIZGppTU9obitN?=
 =?utf-8?Q?U/YY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585893ec-50ac-4396-ffa9-08dd4a7851b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 08:44:38.3682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ae8EguD5lJwbmLEqylS83DlGJb8nJeu/dhuVTj4f3+Tu8LYWh9JDCMKZKO2zhttmaionuBKrhnOrhMqQxhTpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5283
X-Proofpoint-ORIG-GUID: mYvndLHdHKvImG897Tg0sN_tqbWVjlAf
X-Proofpoint-GUID: mYvndLHdHKvImG897Tg0sN_tqbWVjlAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_03,2025-02-10_01,2024-11-22_01
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

PiBkaWZmIC0tZ2l0IGEvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl90cmFjZV9jdGYuYw0KPiBi
L2xpYi9lYWwvY29tbW9uL2VhbF9jb21tb25fdHJhY2VfY3RmLmMNCj4gaW5kZXggMDRjNGY3MTQ2
Mi4uM2U0MjI4ZWU3ZiAxMDA2NDQNCj4gLS0tIGEvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl90
cmFjZV9jdGYuYw0KPiArKysgYi9saWIvZWFsL2NvbW1vbi9lYWxfY29tbW9uX3RyYWNlX2N0Zi5j
DQo+IEBAIC0zNzMsNiArMzczLDExIEBAIHJ0ZV90cmFjZV9tZXRhZGF0YV9kdW1wKEZJTEUgKmYp
DQo+IA0KPiAgY2hhciAqdHJhY2VfbWV0YWRhdGFfZml4dXBfZmllbGQoY29uc3QgY2hhciAqZmll
bGQpICB7DQo+ICsJc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCB0b2tlbnNbXSA9IHsNCj4gKwkJ
Ii4iLA0KPiArCQkiLT4iLA0KPiArCQkiKiIsDQo+ICsJfTsNCkFzIHRoaXMgcGF0Y2ggaXMgaW50
ZW5kZWQgdG8gc3VwcG9ydCBkZXJlZmVyZW5jaW5nIG9wZXJhdGlvbiBidXQgYXMgYSBzaWRlIGVm
ZmVjdCBpdCBhcHBsaWVzIHRvIG11bHRpcGxpY2F0aW9uIG9wZXJhdG9yIHRvby4NCkhlbmNlIGZv
ciBBICogQiwgZmllbGQgaXMgZ2VuZXJhdGVkIGxpa2UgQV9fX0IgKG9uZSBleHRyYSB1bmRlcnNj
b3JlKS4gU28gSU1PLCBtdWx0aXBsaWNhdGlvbiBzdHJpbmcgc2hvdWxkbid0IGJlIHVzZWQuDQoN
Cj4gIAljb25zdCBjaGFyICpjdGZfcmVzZXJ2ZWRfd29yZHNbXSA9IHsNCj4gIAkJImFsaWduIiwN
Cj4gIAkJImV2ZW50IiwNCg0KPiAyLjQ4LjENCg0K
