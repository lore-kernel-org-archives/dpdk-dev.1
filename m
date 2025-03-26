Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF3C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 07:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 034D8402E0;
	Wed, 26 Mar 2025 08:14:04 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by mails.dpdk.org (Postfix) with ESMTP id 96C32402DF;
 Wed, 26 Mar 2025 08:14:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cwd78L4xuOmJp7vUJ27Q5PL6AR1StxPXv2c7KGthJQIvWNqmRSauiIFwJ5RYh3d5clXXNOx5xiQSACydoS8sw3v8rAFwwG8csHECyuKPs7H0r4FDd34K1tChaDqQvArHp0jIJH5NTI1Ss1XbkQ6JNd5H3XIT0RXmokumeoeffPnL0DJRcz0Zm4NuSeqW+TSE4/fAgxEroaKJB3slBL5/xQEtxXgxDNpXQssHZ//RWFmhqugb/iDNv+50h0BN6nR+DFNPc6hvVeJkgOn3CKK2POvnzExM0VXRr0E7gV3TRkcz+VBpFCkDF00KvR/sMvRPGbX0S9NWin+3lXc3GiRMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYqOh+Ld5XW7O0cFY9nIDKJ7IWwHFdIFjVJqV8uRdp8=;
 b=yz/nUxxKiDRzOA004gwUk8Hu75DuwDrSW+jiY/isWw0A7w7fMAVwjDWvW4VRhnTekR9ZV8NjNIwxc1p8FrYa4uSSol6c7B84oLfibNAqYIjeh2QvnwKuXuBW9Af/tv9MqVqWRer3bKWgnGJcQc7QxCd4k3r5y71IJjHLE6CPUX3dAqDFB1LNUbiYILFiGGkxtuNtzzvOSmr/Jy1kpfChJEnc7t7BjXzKsBnd7zZrTXnYBZRBsDco8HGEbIjGJ453xAtQDRYXOy9g3Ied7PkdMbNZ8HFBlpl6Awu8a99XjmrrUhF0FfRokFf8ndw+5lv6qq8ZDLY0lgIO7jZH2SN1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYqOh+Ld5XW7O0cFY9nIDKJ7IWwHFdIFjVJqV8uRdp8=;
 b=ihL9IIg0F7koKnfrACP3D8vYY4IBWGkZSsurswYstDp780SnyXJdhPeIoBW9MLUl99mbqVqHFX6o6dOLrdGWRydyiv2e8DH91N2p7UPcc4kXvyNVyqVe073y/QNzU1Y5O1/uO8QVJsAZA8jUJC56iG/xKH+oUt/kFaAHuWzJEoTGcFZhRgJphZJ4ybpnYNuNW8kwOLPr9zUBqizkDDTvOCBeCR1lggHRMN99tauau5Cjz2JQB3HkD3lc/Q2aN4yUS/aDqxx2onnrM6KxcUmKIoAhocatEtHN55Ek4wTQSkXLQwc1p8+s8pd9WHvidNTQ3RzNX3eVyDxSAxVRUVVTMw==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 07:13:59 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 07:13:59 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Suanming Mou <suanmingm@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, 
 Brian Dooley <brian.dooley@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: RE: [EXTERNAL] [PATCH] app/crypto-perf: fix aad offset alignment
Thread-Topic: [EXTERNAL] [PATCH] app/crypto-perf: fix aad offset alignment
Thread-Index: AQHbkmQ2fHSrVkDKA0W0UfYk+ZI74LN3KDKAgA3v8yA=
Date: Wed, 26 Mar 2025 07:13:59 +0000
Message-ID: <SA1PR12MB9491AB9BB59AB52B0D3A37FABFA62@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250311090122.121190-1-shperetz@nvidia.com>
 <CO6PR18MB44844B0F7C3BA22106DD9620D8DF2@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB44844B0F7C3BA22106DD9620D8DF2@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|SJ2PR12MB8182:EE_
x-ms-office365-filtering-correlation-id: e6765df7-d87c-4fd1-ce5f-08dd6c35c768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mk1pSU9tRjdFV2FFZ0JBakdpOXQ5S2MyWVpZTEVBRi9EQXFvUFVTSXdMYmhW?=
 =?utf-8?B?TEp1MTBmRXBXT0RHbGNCaUMzTnpiR0JyS0JCZlpZY3lNOEpXenZZalFxSHRt?=
 =?utf-8?B?bngyZm9oTUdxOTNUZUtHQmlueGVWMkZGRDRzdk01dGwrT3pYeUJKcHF3RkVt?=
 =?utf-8?B?eFZMZzhyUCtGN0Q4aE96REhrb3VkcXZOM0NKM3BaVnFGaEdGcEZmcllIdDJy?=
 =?utf-8?B?aWJCTWVrVG93UzlNTDU2RjV6eG9yVGpONnBncUlJZ0w1NG1CcE1lMmh2ODdz?=
 =?utf-8?B?UFRJdFNNYjBWelhHVyt0WmpxTVQ2SlFvby9tUU5XbUVXZDAvcUVHbEI3d0Mz?=
 =?utf-8?B?eVhEamIrRVdtMFNVTTNMVGlXZW1EM3FnMVhJWlMvZHFzck0vSWQ1ZlBiWEph?=
 =?utf-8?B?Wit1ZEMzeEJsNlNqWUNsZzJ4Z0thcnY2OGhhVVp6Uy9RZmxPa1lTRGF1bmRx?=
 =?utf-8?B?WUJGTnVMUWhqTEhndDhGQm81enRVRWpVMnNtSklKVm9DbHhwSWpEQlBocXJU?=
 =?utf-8?B?NC93WmdhMnlQcS95V3N6RFZ3cHBOdlMyb0VrNnZUdTBTQVc2RUpTSGNJdnJw?=
 =?utf-8?B?bkY0TmQ0WHlkMmJkTDVVZWZ5enUxVVhyTXIzc2poeFBaRFk0blJqYUdrTFpW?=
 =?utf-8?B?UDgva3dMSXR2Y2hhTnJXbWZsditKVXgvYlBpSDJCUDIxdmxOQXgwRTFnTDk4?=
 =?utf-8?B?L3lnMDlzWkVlMnNOQU1RU0pIZGN3ejBERnlDbnlVMWhIbnhaNWx6U29rNk1w?=
 =?utf-8?B?OXJaSFFaZlV0Skw4QXdwRk5oQXRxNlZuTlBhaEhRNi9wZUx4Wi9Lb2J5NTQ1?=
 =?utf-8?B?dmdlbE5aN3hoMUNHZlhVVkJPdVllL05BNndLa0RjUkoxdDlhcUoycG9pd1R4?=
 =?utf-8?B?R0FpdWNRS2lQQUFSVDdZcVVmUTQ0VWhXWGU5Zkp4VnFwRVVoLy94T2l6SVd0?=
 =?utf-8?B?WDF2NnI0SXZ3M2lRd1pqeWlzdDloQmkvaCtzTGZBd095cGVXOHJ3N3RGbnhW?=
 =?utf-8?B?MXBONk9pV3dnL1NuM3hTdlZsL0E3b3pYMzJrTEgrRGV5bC80aWxYRFl0RG1w?=
 =?utf-8?B?SHVZd0xhTHhnUitQQlBUbDczcTE2K3B3UmxqcFlyN2U1SWhWaUZhWVM4VUM2?=
 =?utf-8?B?VWhqQ1duc2lzVFBFb1ZNUjErczBNNmFXd2dsQXp3MWZVNndKR0x4ZFJQVzJK?=
 =?utf-8?B?RkEwNW1WZUJOWkJaeHVkT0phRTZiS2FVTitQUVhMWlk0R1JIZ1lvVjRsWGE1?=
 =?utf-8?B?VmxDZVkxSWhxSGZFb1RBK2MxN01oYnhXdnU2Z3l0THBPLzdRdUxmVXZ4U3FE?=
 =?utf-8?B?NWY4b2dIQk9rcTUzS0x3eVZmRXJCcnZaemxhc21nUWloVWVGYlhpbkRaaE5i?=
 =?utf-8?B?SHdkSnZVR3dpdWp4QVZYTVJXeWdvV1BDd0xxTUJVd0dQb1VYOXpZalYweG9N?=
 =?utf-8?B?ZS8wUTJKOEhpUFZ3TFhEeUczajhGVkR6ZDBjVHlUZ2RGMTJQQUxDeWZxc1F0?=
 =?utf-8?B?TzJ4TmpFUlpGa2V3NG1RT2xSRzM2TDhKdmFqU1Bkcy83V0F2cmp3OTNDQW5Y?=
 =?utf-8?B?bThqVXlvMVRnTjZ0NFdzMENZOXN1TXhVTlVBRW02dHNrWUpDWCtjQlFsM09X?=
 =?utf-8?B?SXBTNE11bzlncnoycGxld2h2YXdLNllnd2locWFDTm42cjNaZ0Y1cS95MVF2?=
 =?utf-8?B?WXNQZVdsTVJYQUowTE52bGFUbjRrZHM3V3puT2RXczhCYmduRHpTR1htbkNn?=
 =?utf-8?B?MnpJUjc5cHJTZGhRMmNWa3kvZEtWeU85OWNvd2RFMlRhNlEvaEYvdlhJaWIx?=
 =?utf-8?B?ZkF3NURNaVhMQVV6QTJ4aGRyREVRNWp0clFtMWJDWU5hbXRRSmpaYmhleE10?=
 =?utf-8?B?aXpqTXJ0NzZSM1pUTVpGc3lZNkJvVzR5VVRsRjJkTkZDR3AwS09way95YlFl?=
 =?utf-8?B?U1FjQ3pSNlRUeUhlN3htN0JISlNEcElnTjdwZEVyZG84MjMvQUVCaExsZnF2?=
 =?utf-8?Q?Y002q+ciN3F7da+adJcVtkCkL89k84=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bklGeEJyU2kxaUMvQUExNEZ6cEhCVlM4ajgrcDNTVG1JTndDaHdzeU81QlpX?=
 =?utf-8?B?RWVMelNCTWVXa051UDYvUHJDLzd1dEZETDIySTR6OWd2UjFCN0wwQ09tejBJ?=
 =?utf-8?B?cmM5dEhBNSsxbmJDa2Zzd3lQS1dkNjJVTUVDTWRXZmNpaXZOVm5ETWRQSS9q?=
 =?utf-8?B?RVpnMU4vckxkTHdWUnRDZUUvTElZa3UxWk8yLzdFbDZnY29EYlhlWFlsVDlx?=
 =?utf-8?B?eWRBdHQ3eVFnRU5uU1VXQVRxNVJ5RG1tY05QeENVTW5iSWZRUFNCRlpqbnlF?=
 =?utf-8?B?L3luS3V5VEpDUDJEclhDb1JkNjRRUkRpQVdxMjVWVGdaa1lPdHhKQmNJSEJ2?=
 =?utf-8?B?UXlzYStxQ2pwTENOTUczaENUOTRJYkZEdWZUWnZNcnk2WEswbUx6ekZEWE5z?=
 =?utf-8?B?eTFkUUJtSktRZzZFbU9lRzRpT0pPUC9wNFRtT2VpMUIvRm9YUmNPYmQxVlF6?=
 =?utf-8?B?K1NnN1FjZDZQMTdlM0E1TVkwOTFSelBTbGtjVG9nRzk5WGVmdFV2NmRvYW50?=
 =?utf-8?B?SnNycUorYjFoRmI5Z1I2Y25OMUR0a2Y1TkhBbnhiMGFFWmZreHM0M2k3VFpz?=
 =?utf-8?B?NUxLYWFLTzloODFyemRFQ0prQlBTcFpNdm10dWliOG5jQ0thSmZUbW5OSllN?=
 =?utf-8?B?aXpFZUViSlZ3RUhFdzkrSW5yMUVzL05ZUDdxSHphcEl3L2xPZTRySmw5QmIz?=
 =?utf-8?B?V2toRDdoanpGUFYwMnZoSG9ncTlWS0tqOHZhMUdiRDNUZHBLa0VtenJydmNX?=
 =?utf-8?B?U042NG8yc1NteDlKTVNjVU9sUzUwOTNLa1ZNUmErT3dLTWtZOWNGcFl6eE5z?=
 =?utf-8?B?d0hUMHB3V2QwVDFQWW8yM0Y4NjBQa082cmxEYmNscE5OZmVIRzc0ejRIQ1pW?=
 =?utf-8?B?eTF0d0UxT05KbmxHT2VDZFA1N3Fva1I4bTl1VjFSZkZWYzBoTWlOcGVMVTdk?=
 =?utf-8?B?dG8ybDBuTEVNdWJsMlB6MGZaVjhoQm16M2VlYXdNNzRWckd2UVhITkJqN3ox?=
 =?utf-8?B?NlBzOXFNNWJ0NkVvN1VIM0xKdjVVTXZLQTJJV3UzM0U5ak9GeEozK041TW1P?=
 =?utf-8?B?anRTYTFUMjh6Z1hZN0I1YmFINmNzNVpjellPYXZkTFBHQUwvSVo5SlhnQVVy?=
 =?utf-8?B?bjB6ZnFUYUdVY05PMEprY2JpNHpISXlYQTFHMGhjU2hjenNlYUFVUS9FdFVZ?=
 =?utf-8?B?YjhxVW1SMzRLc0xuQ2FreGZQcWk2Vjk0aWl3WU1teWZmY1l4N1ZCaHpyOWUx?=
 =?utf-8?B?a2FUWFRISGoyY1ExcjZYbXV4QzZUUE83K3daeUhjYlNUNWp0Yzc1ek4vNmZ0?=
 =?utf-8?B?ZXlPZzEreVYvd25HWVUyZUVzVU1OTDlGckcyY0NMc0dHQ3puN1kxSGdxRTBZ?=
 =?utf-8?B?VHJ1OC8rWVV0QTdWMFlYRHNVajIvOUJNTVZuK09MMmQ2WDI2UjZjeGxhY2k3?=
 =?utf-8?B?a2pndkE3di9rTW53eDAxdEpvQlRSTHNrS1lzQzVKS3UyR2luWjFsR3dRczlL?=
 =?utf-8?B?UVBkRzR3TXIvdDZPd1JhcnMxVUtWS210U2lDQUpSem9Tamc1YnFPU0JHaG5F?=
 =?utf-8?B?Zzk0RnFyY1JVd09EdE1hOGVVcXlVcUdTQWxlYW1wYmsrQXVsQXZ1SFVNUCt6?=
 =?utf-8?B?NUZPUmw4UkkwQkZUMUhQV0cwc3BGNXpQeE9wRWNVSVR3VXo3QThFL05leTM2?=
 =?utf-8?B?UFhqaW9idnl6R0pXTFRHTkt4RWlaREVpYUVFdktBRFQzUnQ5Y1NpK2FJYUZC?=
 =?utf-8?B?NkpjTHZHcVMwd05oWFBUdnF4ck4rWnNTQW1COVZlU3JwbG5YMklVa3VlenBR?=
 =?utf-8?B?MTRmanQvcWFFNUR4ckZPWHpNQ2ozVW9ZQjRDamgxcG8rYlREZVZDS1Azc1lx?=
 =?utf-8?B?bzQyMlJrWTZRVjBBbkcyRDVkUml6OVh2YUFlUXk0RE5SLy9wam1TWVlpNWJG?=
 =?utf-8?B?MC84czJKSnIvM1BydDlkNnA5Vm9xakFnbSsxeXJ4VFJwUmlYSlk2SEdHcGNK?=
 =?utf-8?B?bXJrSHdsQXVwRFNjdjRKME1jMk1hZC85VTZHTGdFRzYzQ0tQcDdUYlJoS1VV?=
 =?utf-8?B?dFQxZnRiZ3N5azBBNDBKdVplLzdJSDI0Wm5ycjRXNGxQM2dDNlZDUUZGL0h3?=
 =?utf-8?Q?EEDlW68KhuJIGA6UwytlNZAcT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6765df7-d87c-4fd1-ce5f-08dd6c35c768
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 07:13:59.0593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCpv2bySWxUIDnLNUhs1/tqVjz9s/HkXuwqQm+rkxrMrUodTQBfVd1o3hl8Ng3jeTum7feINSJ6fN6AJ+YwTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWtoaWwgR295YWwgPGdh
a2hpbEBtYXJ2ZWxsLmNvbT4NCj4gU2VudDogTW9uZGF5LCAxNyBNYXJjaCAyMDI1IDEyOjIzDQo+
IFRvOiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+OyBkZXZAZHBkay5vcmcNCj4g
Q2M6IFN1YW5taW5nIE1vdSA8c3Vhbm1pbmdtQG52aWRpYS5jb20+OyBzdGFibGVAZHBkay5vcmc7
IEJyaWFuDQo+IERvb2xleSA8YnJpYW4uZG9vbGV5QGludGVsLmNvbT47IFBhYmxvIGRlIExhcmEN
Cj4gPHBhYmxvLmRlLmxhcmEuZ3VhcmNoQGludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtFWFRF
Uk5BTF0gW1BBVENIXSBhcHAvY3J5cHRvLXBlcmY6IGZpeCBhYWQgb2Zmc2V0IGFsaWdubWVudA0K
PiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IA0KPiBIaSwNCj4gPiBBQUQgb2Zmc2V0IGluIEFFUy1HQ00gY3J5cHRvIHRl
c3Qgd2FzIGNhbGN1bGF0ZWQgYnkgYWRkaW5nIDE2LWJ5dGUNCj4gPiBhbGlnbm1lbnQgYWZ0ZXIg
dGhlIElWLCB3aGljaCBpcyBvbmx5IG5lZWRlZCBpbiBBRVMtQ0NNLg0KPiANCj4gQWdyZWVkIHRo
YXQgQ0NNIGhhcyBhIHJlcXVpcmVtZW50IGZvciAxNkIgYWxpZ25tZW50Lg0KPiBCdXQgZm9yIEdD
TSwgZG9lcyBpdCBicmVhayBhbnkgcHJvdG9jb2w/IENhbiB3ZSBub3QgYWxpZ24gdG8gYnl0ZSBi
b3VuZGFyeQ0KPiBmb3IgcGVyZm9ybWFuY2U/DQo+IFRoaXMgaXMgYSBwZXJmb3JtYW5jZSBhcHBs
aWNhdGlvbiB3aGljaCBtYWlubHkgZm9jdXMgb24gZ2V0dGluZyB0aGUgYmVzdA0KPiB0aHJvdWdo
cHV0Lg0KPiBEaWQgeW91IGNoZWNrIGlmIGl0IGlzIGhhdmluZyBzb21lIHBlcmZvcm1hbmNlIGRl
Z3JhZGF0aW9uPw0KPiANCj4gPg0KPiA+IFRoZSBwYXRjaCBjb3JyZWN0IHRoZSBBQUQgb2Zmc2V0
IGNhbGN1bGF0aW9uIGluIEFFUy1HQ00gYWxnb3JpdGhtIHRlc3RzLg0KPiA+DQo+ID4gRml4ZXM6
IDBiMjQyNDIyZDM4NSAoImFwcC9jcnlwdG8tcGVyZjogc2V0IEFBRCBhZnRlciB0aGUgY3J5cHRv
DQo+ID4gb3BlcmF0aW9uIikNCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+DQo+ID4gLS0tDQo+
ID4gIGFwcC90ZXN0LWNyeXB0by1wZXJmL2NwZXJmX29wcy5jIHwgNCArKystDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9hcHAvdGVzdC1jcnlwdG8tcGVyZi9jcGVyZl9vcHMuYw0KPiA+IGIvYXBwL3Rlc3Qt
Y3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMNCj4gPiBpbmRleCA2ZDVmNTEwMjIwLi5mOWJlNTFlMTdm
IDEwMDY0NA0KPiA+IC0tLSBhL2FwcC90ZXN0LWNyeXB0by1wZXJmL2NwZXJmX29wcy5jDQo+ID4g
KysrIGIvYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMNCj4gPiBAQCAtNjg4LDcgKzY4
OCw5IEBAIGNwZXJmX3NldF9vcHNfYWVhZChzdHJ1Y3QgcnRlX2NyeXB0b19vcCAqKm9wcywNCj4g
PiAgICAgICB1aW50MTZfdCBpOw0KPiA+ICAgICAgIC8qIEFBRCBpcyBwbGFjZWQgYWZ0ZXIgdGhl
IElWICovDQo+ID4gICAgICAgdWludDE2X3QgYWFkX29mZnNldCA9IGl2X29mZnNldCArDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgIFJURV9BTElHTl9DRUlMKHRlc3RfdmVjdG9yLT5hZWFkX2l2
Lmxlbmd0aCwgMTYpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAoKG9wdGlvbnMtPmFlYWRf
YWxnbyA9PSBSVEVfQ1JZUFRPX0FFQURfQUVTX0NDTSkNCj4gPiA/DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIFJURV9BTElHTl9DRUlMKHRlc3RfdmVjdG9yLT5hZWFkX2l2Lmxlbmd0aCwgMTYp
IDoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgdGVzdF92ZWN0b3ItPmFlYWRfaXYubGVuZ3Ro
KTsNCj4gPg0KPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBuYl9vcHM7IGkrKykgew0KPiA+ICAg
ICAgICAgICAgICAgc3RydWN0IHJ0ZV9jcnlwdG9fc3ltX29wICpzeW1fb3AgPSBvcHNbaV0tPnN5
bTsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KDQpJIGNoZWNrZWQgdGhlIHRocm91Z2hwdXQgdGVzdCwg
YW5kIEkgaGF2ZW4ndCBub3RpY2VkIGFueSBkZWdyYWRhdGlvbiBjb21wYXJlZCB0byB1cHN0cmVh
bS4gSSBjYW4gc2hhcmUgdGhlIHJlc3VsdHMgaWYgbmVlZGVkLg0KTm90ZSB0aGF0IHJlZ2FyZGxl
c3Mgb2YgdGhlIHBlcmZvcm1hbmNlIGl0IGZpeGVzIHNldmVyYWwgc2VnbWVudGF0aW9uIGZhdWx0
cyBpbiB0aGUgdGVzdC4NCihUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIGFsbG9jYXRlIHRoZSBjcnlw
dG9fb3BfcHJpdmF0ZV9zaXplIHdpdGhvdXQgYWxpZ25tZW50LCBidXQgd2UgdHJ5IHRvIGFjY2Vz
cyBhcyBpZiBpdCB3YXMgMTYgYnl0ZSBhbGlnbm1lbnQpDQoNCg==
