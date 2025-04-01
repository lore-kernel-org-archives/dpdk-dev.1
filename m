Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EA9C36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 09:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A0D640DC9;
	Tue,  1 Apr 2025 11:00:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 42DB84067E
 for <dev@dpdk.org>; Tue,  1 Apr 2025 11:00:32 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5311mndx004016;
 Tue, 1 Apr 2025 02:00:31 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45r6t88pg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 02:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyXvaWfS9sthkLvvNM/YYIRHOeAxzwdlZCf9QR6ahp1EvByjnv1XO+IXaIBNWG5pJ7221HOgKnyzD9NvsJgAYqZKs2ZpC4nnsdvLD63ypghtGOLI4xXQDHi/kw09+SFEeUqXM6kXqMsMQ4v08hZJQSxhZCwBRaVNamcrvHtIiym4POm7kUDlKGjNPKetMwjyRtWrU1K1fhv6GIMJd1Ug2jzgxzS4qwG2Vroikwdt/zLywKqgSZz5lTO4Jqqr/Mb3bveF+tfP6s20ufMBDNORZ1XJOERid9vP1vYyANwDx7WGIap1m+ISlbnt8uchzebQaOTVKfSDylUe0jr/w7eQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9kaN0ZXm0X8QBSpUJAuylEULQWf3U4KVxwKdm0HYiY=;
 b=CbtWICD838c6GBo3O+0K8RLD49SMDp7SzumBE+lv49G6w8EpQxdBZxZ9AlRNGMAT+DHY6mlBDqaYHbTeFcW12hTs6OckCeMP5qewXMD4UkeM5A6uJkV8Z52gCe8mX4o69ZYYq1o9vClFHYa58kurrlZBMtYWjytzCxnuN5W2MThZXtFrERGp0m9nWArfg1GxjeKjXdjsDWWBXYypG4bCEv4lGhydu6ZB98i0JwoyOSU7nu6cQSyE/nwc+MQXDNES4I7XU+JNUILtyVvLNXOgAgQinKQOmfA0Uym86Ycizrehr6DdoACbNBygo2HrlgB0TypXOmL7ykf6XjT+SVHwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9kaN0ZXm0X8QBSpUJAuylEULQWf3U4KVxwKdm0HYiY=;
 b=glBU+gP3Z2rUppxSb32pAt0HyiOwdjcy1vTmBP26Fnyln7kWnUPb7NO/MOc1DFTZoCN5MbVZ2bjdplw5bAe4Z5eZpcFkH8UdJ0cfXz6UY9VXp42mnpnVW+TLQLLbmHXl9aAxXQPprkGYPDJgUx5TEpwaggnZFlxMz+rtqpPH6vg=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by DS1PR18MB6228.namprd18.prod.outlook.com (2603:10b6:8:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 09:00:27 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 09:00:27 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Luka Jankovic <luka.jankovic@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] eventdev: fix dereferencing null atomic locks
 pointer in test-eventdev
Thread-Topic: [EXTERNAL] [PATCH] eventdev: fix dereferencing null atomic locks
 pointer in test-eventdev
Thread-Index: AQHbnjdY233nM/sTWk+Q9imLzZ1gd7OOjCZQ
Date: Tue, 1 Apr 2025 09:00:27 +0000
Message-ID: <BY3PR18MB4785DFD4760032CCB055DA6AC8AC2@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250326100952.114143-1-luka.jankovic@ericsson.com>
In-Reply-To: <20250326100952.114143-1-luka.jankovic@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|DS1PR18MB6228:EE_
x-ms-office365-filtering-correlation-id: b8dcef56-a4a7-482a-56e6-08dd70fba57c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MW1obHFnVThDYVZLRXhtZ29tbkZyT3pvbEFuQk9TVVhYT1o0OG1jSHF4bkJo?=
 =?utf-8?B?Qnp2cjMxTlhqNms5L2xUVXpLTXhnSnpqcHEyVjdDSFhnKzBkZDZ1NFFOUlBl?=
 =?utf-8?B?K2dZWTNjM1ovNWJLMElmVFJwd1JJZnI0Nll2eS8reE5xZ093SGR3dldYaDJP?=
 =?utf-8?B?K3liWkZ3OW9JOVFOc01yQWVoMDNxMW9xMWUzbW9EbWZjc2ZYekFuTE0wQ3ov?=
 =?utf-8?B?cmRxTHllS3VxNWZFcVdrWHJ3eTJRMllXK1QwalBkckV4b2tnbGRkck13L1BR?=
 =?utf-8?B?S3FTN2NRdHpNYkg2cnlOMjNqcE4rUi9IQUswdWQ3L1BtckZoUzFPeUNLTTM3?=
 =?utf-8?B?MUt2K29LNExnUjJLaDZzc3Uwem9jZm9naERBVnprU0pLTWQ2T05FZ1ZlUFJX?=
 =?utf-8?B?ZHloZWYwNVZ5bUtFZDQyUmYrQlBhM2FVdFdoZ3B2RjJaSFhzTmMzMmZHLzNY?=
 =?utf-8?B?YnRNbUFsSW5IQlBxbStxWXN5V3o2c0xsSURFclVTdHVLZ3hhenczZFBCdE1S?=
 =?utf-8?B?bmx5cVA3Y2ozbWtpY3IzcEFMUjZMTFhVeE10eHl0b3J1YUlxRVB3cjFDWDdX?=
 =?utf-8?B?ODFocytvemhzZ2IrcnphT3hKZm1MeExvcW1nY25sTk9GQ3lFcjFUNjc1akhq?=
 =?utf-8?B?S0cwRGRZV1pNTHpGWnBVb2MycXhJVXA2M3dhR3ROazhQOTlWUWhuTUtaQmhY?=
 =?utf-8?B?MnJhbi9MU2Qvelp6dTFrREZxVmxHcTlyR2ZuaWo4VlA5OEhCVFZUTENQSEZO?=
 =?utf-8?B?UVlWemFSZTRsakV0OUdKM3VsQjE0aEo1ejJtLzd5NEtwbDlYZEFjMHQyOStE?=
 =?utf-8?B?bkhnOE5yN05CTHdscWlTUnpTWENvS1RaQWZjaGRRSEo5RUtnRElNZHY0ZkZh?=
 =?utf-8?B?cVZDZlp5MkNYQm1ZVjBnQ0RNM3pwaUVVVFRYd0YwUDBQQWE4V2lwWlR4SVhn?=
 =?utf-8?B?RTYvQXh5SWd3QVU3WWpzbnlFWDUxUEdlYnovQXo0T3NZUUY4K2ZoQnVNVHE0?=
 =?utf-8?B?M1VZaHgydC9KL0x2MExRL015T3M5Njh4NmlVZitrWXdEeGtMbGIvWnkwV2E2?=
 =?utf-8?B?cXAzRFZOS2tiY203b3kzZXF3ZWR3RUpqN09RS09MYmtlV0pZY3ZaOXhRcDNk?=
 =?utf-8?B?WS9heUNiMVNrR1E0WVVMaVdYcXNQb25oRWg0UkowZHZWTjd6MEVRdHc3c2E3?=
 =?utf-8?B?QWd1SFpNK1NrYlRodFo0N0tmSkxvWlh5NFJ3ZDZTZU5xZVBzNTNYcjBWY0Fn?=
 =?utf-8?B?bHJBWnJuZnJTb2JUZHFyS3YrTUxPRWEzVE1hU0d4RlY3WFcyZ0Q5V0dkelpI?=
 =?utf-8?B?Z1FPVXZUR2pIQnhyWHNEeko5aFRybWdmMFVqa0VtVG0vSXZxM252MnB6d0tF?=
 =?utf-8?B?alNRc3h0MlloU3Q5Vmo2WmpFL3Nrck82K2kvYTI4M2JBN2JPVXIxVlJmUWRv?=
 =?utf-8?B?WlozcDgzc293Tjk3REtVSEVhcmgzSU5zY3ZNNU9zTGVTWUFqVmRJVWZVdkFD?=
 =?utf-8?B?TmRDNXBhK1U2YVMvejJoc3htK05IaHJkY2ZmNDN1c3JCcDNXVVZOcmJWN1NF?=
 =?utf-8?B?d1U1eE1DYzNaVnc0WjFoOEpYb3g5L2tnbFg5VHY3YWlldFZKc0dIY1hNd3ZQ?=
 =?utf-8?B?SWNlTWxIV0ZOV0ZWTFJONnhZVDZnOWFidnY4ZXdJOXlUOFBDdk8yNnAwUkds?=
 =?utf-8?B?YUhaVnBYMFc1MlB5bWxsUUVNcmRmU3hMZkdFUmxNeXQvYXhRTmpXUkpubEM1?=
 =?utf-8?B?YzZxcGlvdmNTKzZPL00rUnpESmRuaGhHM1Q5UllPbTdwcjFCMVQ1UlV1Y2Fy?=
 =?utf-8?B?alp6MU1aTHFvTGE3aTdMUENJazFOWlhxanFtNUVlZEtpUGVzbDZ3NTBwQVp6?=
 =?utf-8?Q?mSdt26l/yo6I/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVh1THZrTlE3SDAzNmJrTHVyR3JpYkx4Y1RHTVorZlBhVlNEaXpTWlRIYzNu?=
 =?utf-8?B?V2prRGlBZU1QYnNxZmhoNU5vUkxVMnQyVFEzayt4ZVYwWS9BZ0ZSTVlWcitH?=
 =?utf-8?B?c0hOMW5TeXVmL3JhNlMrZHhpcThXWU5uMVFPUk9ka3pPQWo0RDIyTTFUbnBG?=
 =?utf-8?B?Vzg5TlJGdnJHWkIvMUhLRXpFSzNuNS9JNHN3cnFseXFYUFMwdC9PYWtmODBq?=
 =?utf-8?B?NEh5TXMydGUycFlIMFIxempPaTZIbEhwandGcGpwZkNQRnEySVhIOVdTYkx0?=
 =?utf-8?B?UWYxYzZmczFJWlV3SFZhb2NLejZ0OUVQYUg1MHI2aFp6T1JuYkFsM3NIYlFX?=
 =?utf-8?B?M3RLR3lSbXozUGIvbzdGdEpyMmw5ODB3NnRqWEo5bnMxcldPYis3OEZrMEht?=
 =?utf-8?B?bDhtOWMvcEY0MDl6cnp2akN4ZldyWTlyNlFmVEtXbXFhY1orU1ZQcktkR0Ro?=
 =?utf-8?B?K1hkUms4dVpWQ0p1dXc2VVY0S1U1b3N4M1ExMzJlZVJtU1VHb3U5VGlnR3dK?=
 =?utf-8?B?dXJTZW5oVnNqQTdrMXd1MlczUGF2SDFrUDFYR2FQSzhlVkJ5M2pGY2x1WWR0?=
 =?utf-8?B?UFpiaEdteHk1NElqdm1GTEd1ejIySHpHRzFvcGk1eWhiT0c0b2pMbFNRNUgy?=
 =?utf-8?B?K3NPQkF3Wk42V3gyWk44b3lmTHFocnJtMGJWczlyVmJpTEhNSjRvZUhnVEpa?=
 =?utf-8?B?TUVySzA3TlN5UG1yb2lnTFNRRTlZZ2d0WVlLZTVad3hmYnRDQnc2ekhYdkdn?=
 =?utf-8?B?cmhsMmRoVnBwdnVHb0tON2FoKzBFd3RmTE5vd1Q1R29PWkhzZ2VBaUtzUmIw?=
 =?utf-8?B?LzhKR3FNS0Q3b0xQaDZwMDhMS3Baa3FqSFhsYVczL2tkTlM4U3ROUTJrVmp6?=
 =?utf-8?B?UHBNM0VQdGFZZVpGdU93WXpTdlNYeUxla3h1akxSSHdmV1U3YXpUUHVCWGEx?=
 =?utf-8?B?eURDLy9ZaWs4MWovV01vbkpyNW54aCtJQVZpVzRXbnV1eVB2WlE3bmI2SnN2?=
 =?utf-8?B?NkhWZGhPTERncXBsenhlb3RLM3lRSmdHWHFwUWZPTU10QWZrMWpSTnkwUkQy?=
 =?utf-8?B?VUNteUxTWjIvczlsY2krbU1sdWVrVTM5czlXNi9QbXVvSUtPNXgzcG1VUzM1?=
 =?utf-8?B?SUpmVnYvYXlTdlA4SlVLT2JZaHBCU1NyWEZUNDNTUFNnVmgrOU9NMEtXYmU0?=
 =?utf-8?B?aitjRHpGd3ZXL0JYb1Vua3NWbTRsUVl5Q0taRHN6KytxNjJLQlBwTTlLVVp3?=
 =?utf-8?B?bjJPK1Y2ZmFnZzdteFRWNDZ4VEZ6a0ZpemNHR0UrVWpxcUZ0UUlkRGdWdm1m?=
 =?utf-8?B?OStCd0pHVTNLTnBxbnNMQmFzdVA2OFkyZll4ZGNVM2N6VmQzR2wzQkU1eWxT?=
 =?utf-8?B?bmV6b05DQ1FrUUdLQWlzT0VLQXRadnRSWVUycnZMVVhjSFJJblZjV2kwcnU1?=
 =?utf-8?B?bHRUNXA5WitTaVlTelV1UTZReEU4S0pVVUluREI2T25ESHQvZUY2YjZjUnZN?=
 =?utf-8?B?YW1CTWpERWN2bWJjVXdSRGU3NjZQcXllTGJqK25jZy8rb0V0WE02cVV0c21B?=
 =?utf-8?B?NXUyTjM3alo0SlhaZXlkaHZUUEtpU0R6RzFsQ3hORFVSZktJd1NCaUhuV3pl?=
 =?utf-8?B?Q2htS0dZZmRsSWEwTnprMU5zSkx1VTBrelE3TUNhYUFucHRHOEFCejF5ZTFv?=
 =?utf-8?B?QUZTSlZJdDdSVzl2VTRIbkRGcjhsT1pNbmpFRTNNeDQ2TmRZYlA1L0xrZmtH?=
 =?utf-8?B?V0c1R1B1SVAvVFRyakhNUlpUZWxNVVZMSkVJeko3VGtsVkZORWJoNnF1TVBR?=
 =?utf-8?B?a3dUUkttTW1PZnE5ZHo5Z3gwQndLbTVWR3ZhRkF6TFU3VzRock12YW1PWTRO?=
 =?utf-8?B?YU1ja040alRUMUJNbk9xbmJCWW9JWVErNzBjdnZhc0JqckUzcW5SOHZzYnFq?=
 =?utf-8?B?LzJhL3hNbzZGdE56eTJJRGNSQkVhUVFsQ0Y5T09WOC9YbHZheTRVNmpiZGpN?=
 =?utf-8?B?YnpUdUhrM29CN3FxdVltNzFQRUhTamkxNkRUckdLNE54eiswZGRrVnd6UEFC?=
 =?utf-8?B?cHRWZFhUNnB2UGhmRHJ3MHl6djJtK1oxNGRLeFVKZGpWSFNqN2J4c2JkS1dT?=
 =?utf-8?Q?u6oc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dcef56-a4a7-482a-56e6-08dd70fba57c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 09:00:27.1490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gy8M0GnnuMabh0/4nrzkwIjTmsFMqwL+sT70R/AnJ92mnw55iMNTPYZxXF5AEKjw+Tc9/s5ksWVk53jjBqIKUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6228
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: buJht-vOMgcjHfO7CE4ke44w7F1FJ29b
X-Authority-Analysis: v=2.4 cv=QZRmvtbv c=1 sm=1 tr=0 ts=67ebab2f cx=c_pps
 a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=0FD05c-RAAAA:8
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=RpNjiQI2AAAA:8 a=dwzdsqvyiRBxaUfyJGMA:9
 a=QEXdDO2ut3YA:10 a=l1rpMCqCXRGZwUSuRcM3:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: buJht-vOMgcjHfO7CE4ke44w7F1FJ29b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
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
> From: Luka Jankovic <luka.jankovic@ericsson.com>
> Sent: Wednesday, March 26, 2025 3:40 PM
> To: luka.jankovic@ericsson.com
> Cc: Jerin Jacob <jerinj@marvell.com>; dev@dpdk.org
> Subject: [EXTERNAL] [PATCH] eventdev: fix dereferencing null atomic locks
> pointer in test-eventdev
>=20
> Update atomic_init_locks to immediately return if memory allocation fails.
> Atomic queue and atq tests updated to handle atomic locks being null. Cov=
erity
> issue: 457876 Fixes: 9d619f82321b ("app/eventdev: introduce atomic tests")
> Signed-off-by:=20
> Update atomic_init_locks to immediately return if memory allocation fails.
> Atomic queue and atq tests updated to handle atomic locks being null.
>=20
> Coverity issue: 457876
> Fixes: 9d619f82321b ("app/eventdev: introduce atomic tests")
>=20
> Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>


Please check the git history of the file to know the starting tag.

Updated the git commit as follows and applied to dpdk-next-net-eventdev/for=
-main. Thanks


    app/eventdev: fix dereferencing null

    Update atomic_init_locks to immediately return if memory allocation
    fails.
    Atomic queue and ATQ tests updated to handle atomic locks being NULL

    Coverity issue: 457876
    Fixes: 9d619f82321b ("app/eventdev: introduce atomic tests")
    Cc: stable@dpdk.org

    Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>
