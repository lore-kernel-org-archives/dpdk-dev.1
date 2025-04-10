Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA65C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 05:12:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E922C4066C;
	Thu, 10 Apr 2025 07:12:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8E24D40288
 for <dev@dpdk.org>; Thu, 10 Apr 2025 07:12:45 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A2EHIX011420;
 Wed, 9 Apr 2025 22:12:44 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45u1vpbddv-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 22:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgkawTl/jF0dYP5WF1NYHQNM1uq5iHNtCz374WvQ5zr+dguWZhCj8vSiSUIY6KDlwhlAKo1Cw1NXxF4sdogaKGhVco3NCmlaG1wwsGp/oFp97yz7vg8Ach2FybNFi/i+D9tNUNoPqVoawWJQmY4otR2ipe+op5bp+E+iPbZSp491soKjKPKPGJirB0bha0hLg4mBE06JuGY5Pcj38i4eZUlhk1sZK2bfh/R37UzEw24f21dHPnwhHvSMUIo/71R2E7tzPYv5XYaGbYffNU+0TMBKKJTmyQfvjb7OSHRk77ValFry3itErXzvenPCcuj21PMYUTX60WRqV2lKBZLpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07TtKMVFoN2nkYU+co2a0OapwV5pR2DA+ZTndJz0kL8=;
 b=X51ssyE44/LFikE+cjwv6cpBZ12wuiifIegmtYgu1CsFVzXrUOAgoBJoSTcXHK0rEbYyAARNhDMW2r1kGWjeOKSrpep9l5eGDgTYlLxUxYNgb288uFod/pDotmlOBkuU8sIXkoZR42UUQY0bpNGwgbwSFCw3e/759WQxJ847/LfX9WCcmqPfLcVrIPM06rXyjhPQBzewWmJ1EoBtqmtz8jvbGeGxwwJFFaQxJoaqxG55eLF7HaGoNjmfTIGvGMt0ikS79JEdO7sRPVbUDnvvjZIMy0p8m91r2GKJZFZLGuav81GG0ZAXmYw8dIHJ4DDy5LuZst/8xoulqNi2tcDl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07TtKMVFoN2nkYU+co2a0OapwV5pR2DA+ZTndJz0kL8=;
 b=FiU28CDkmnZ81/SonQfD1AZXjFlc7TrCfNfooQ5LzGHUkxczeNoH+yU/oGXSpwOxYbH56gOPggL+o49H0+MzdjTqDRBAJZy2XUkUocLF/kxO5tc0b32uFsMDj/dkBnLeZJcBOk/46Y+tOJnbPmwaj7mJ6EjIqNryW5a2Brp4u28=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ0PR18MB3833.namprd18.prod.outlook.com (2603:10b6:a03:2cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 05:12:39 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 05:12:39 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Rajesh Mudimadugula [C]" <rmudimadugul@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>, "Rajesh Mudimadugula [C]"
 <rmudimadugul@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 1/2] vhost: fix cipher data length
Thread-Topic: [EXTERNAL] [PATCH 1/2] vhost: fix cipher data length
Thread-Index: AQHbpJMoMSOehtmSEkaBiMfPKw0cu7OcZOdA
Date: Thu, 10 Apr 2025 05:12:39 +0000
Message-ID: <CO6PR18MB4484DEB8E9F670C6213FE6F3D8B72@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250403122234.3508100-1-rmudimadugul@marvell.com>
In-Reply-To: <20250403122234.3508100-1-rmudimadugul@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ0PR18MB3833:EE_
x-ms-office365-filtering-correlation-id: 927a919f-d268-4d95-71af-08dd77ee50b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3ZwcHBHVG1rZ1d3ZHlPUzFpQkF1K1VFc2pqWDcxZXVCZWdWMEJUR25jZW9r?=
 =?utf-8?B?OWU5TFFUSFRPcFF6QjlXc0p3L3I4ei9qemQ2VnZrbC84MmJvbjhLSlhsbnh1?=
 =?utf-8?B?UVZJOWxkR2p0VEY0WWdHR3lLdCtGTUtsOHZYK1FvR3U2V0xBb01mRkRicWc1?=
 =?utf-8?B?YTQwdVo5RG1qcHAxQzU5OHgyMURkSnQ1Q01BTlhJbVVZalpMMFcwL1FHSjRo?=
 =?utf-8?B?NW1QcnhiRnE5R3VrQmtCQU9tZ3JGeENBK1RMN2lnN0ZjWng1TktLMC9VbGpC?=
 =?utf-8?B?NFhlYjROblNBU05XRTZSWWRiVTh0cUtNeFdmdzg2OWlTYUgwb1hEY0o5NG9o?=
 =?utf-8?B?b0RzaHhFUGQ3ZHZtT2V1K1NhQXZ5S3g1K0dTeVhSS3VML2RoYlQwQ0FHNUw2?=
 =?utf-8?B?SlQ0anVBY0U4b1UvallEdWZTYjgyV3IyOU5rcnNteFEyakdoRmNWT0tVakJa?=
 =?utf-8?B?QWYxOVJzc3cvdXVjZisvL0NxZ3V2dDRqK1lORWhYdzl0V2dWaGUzbEdMMnRv?=
 =?utf-8?B?TFduVkEzSExHSUU0QUpsaGtTczRKT2VNSEorMzlkd25VVnZ1WGhXZVhydFA0?=
 =?utf-8?B?OGs5bE8rY0d1aHViV2ovZGpobWszYkpMeGx5NXVOSFBNQmFmMlZId2M1Z0sx?=
 =?utf-8?B?VmJSSjcwenptbHdEemJ2Rk9yc2hiTWJaSUYvNDRCL0NUbVVTcXhkclVtbjAw?=
 =?utf-8?B?MUlsYkFRbzlFdGNxT1FjZ1M2R0ZqaDVyMEhuaDNoWTZIaVdTY0Z0Z0wxOWFL?=
 =?utf-8?B?TVpaWjlkdHZZNERSc0tab0ZUWW0xdS9idG1ha2Nia1kxTCtjOWI1WnVDR05i?=
 =?utf-8?B?KzJBMTdlcDl2SFFXdDZRNFYwWnJ3L3dyMmtPbHJhRjBmZ3luNWVJbkZ0T1Z4?=
 =?utf-8?B?WVdrclQ4VnpUQVU1SitRU3hiT3BOdG9NRmh2NmZweFJnWkwzOHZZVWVrOGgr?=
 =?utf-8?B?U3k5d05ZOG1rNWdhS0hkWEdrZWZYQ2pLTzlpRXRDQ0tYaGpCNWx1MkcwOWFm?=
 =?utf-8?B?TFV2ZWtiTGxFUnJCUm84RjlVcjFxVHFnWDZMaUdCcDJvV0RveFg3WkpuM2Jp?=
 =?utf-8?B?QWRXVWhrSm1vK3FvRmE4TDNqWFRONjcvcDVnQVhMcGJXVUlSRFNpODA4bUQ3?=
 =?utf-8?B?Si90b2hlcjNBSFdsZElteVg3Mzltc1Q3NXgvM1RHMXhncUM3bHNIQ0VFd1J0?=
 =?utf-8?B?SlhIam0zcUFYRVVMclFPOHEwSEdlTy9xKzR1QUo3UmJDbVdNSk1wYUhsbzVu?=
 =?utf-8?B?TGpldksxS2lLRU5WVjBEeVQrNEMzTkI0QmhoL0d2TzRkc0ZueDNCMjQ1ZGpL?=
 =?utf-8?B?NHBFM0JRRnFTaTQrNnVPQWpIS3UzOEtwVEkyY1ZCVzF6dFpXUVVMR1N4emRn?=
 =?utf-8?B?YUpwOTdrMDRQQ281b3ZIRXJ6TzRkWE9LNEd2S2NST1VhODZtTENyZ3gxYTBw?=
 =?utf-8?B?K0dRdEdlRm05VTVMTTJDODRJMmQwOGJtQ0pPQjNpSjAzMkRHeEhXb2dkVW9C?=
 =?utf-8?B?YlYyNUNyYzN2QlFsNUxkM1JnaTg4VFd6V0g2U2prdXFzK3JFbzFvaTVXbU80?=
 =?utf-8?B?N2pMNWZkdGdibG5ZYTNpM29vV29JcHZPSUI3aGluS2hFZExlT0Z2MUtDSXdy?=
 =?utf-8?B?eFNlQ0hPNUwyQzIxdDFwODZCbEJWS1h1NXkwbVdsdHA2ZkRicExDNHQxNzRi?=
 =?utf-8?B?V0dHZk13VUFjTDIydnhlRUdQUUtyTVhKVVV2ZjRlajhNcTVnQmJXU2doV0t2?=
 =?utf-8?B?RWZGb2JXcHFCZmpDK1BMdUJyc1hlUGxMRWRxSTBrMm1QclNlY0I3ZzNnMmE0?=
 =?utf-8?B?Wk5vMEU3eW5UNW56TlhnMERoR1JKeXNXWU1SRWpxd25QeXZXWjRsYlRQMDF2?=
 =?utf-8?B?Q3U1M2dZTTBpN0tmVDNuRzlFSXAyKzQ1MmZNMVZydDR3NlRMaFI4REN5Uy91?=
 =?utf-8?B?YjAzVm94c0hYOVJkS1NteDRQaEVHanBKZTR4UTM0S1BWVytFWHNyZk1rRlIx?=
 =?utf-8?Q?gSulWK5J4UYokQR4nbxfD31ks+LGLQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVFNdkdqaU5mYktkcHMvR1ZoL2U0aUVxemtDbEVXNUh5eDRYUDJZTUlYS2hZ?=
 =?utf-8?B?WFFGdlpOdk9Zb3dMSGwzSmZKcy9FbnJPeUdpVEhWMVIrQmtrT0ZkVjFKK3Q4?=
 =?utf-8?B?dlhoSTFqVUF0c2UxcjdZU0E2bFlJaFlibTlPT3Y2MlZtNE5hMTRDaGhHS2Vo?=
 =?utf-8?B?eDhsYkE0aHRxaUt1azYxcktaYVRqaUtwL09YOEZjODhtc3gwdzl3RTUwMDU4?=
 =?utf-8?B?S2RNQStPOW8wOFJ0RlFPNnQxaXdtUW8zcXNQb0lHbmtGNEw0dFdnTmRCdHBP?=
 =?utf-8?B?V2ZhOTRVZ0prTE5BbFVWQzFCNWNMRmwrQ1FlMlczWUZlaE4yd3BJZHhjcTBw?=
 =?utf-8?B?VWtpaHBKMHM1NEkxSkcvQ0psR21veXkvWmRMUDdNbjR2cUZkWFFIR0p1Mmxp?=
 =?utf-8?B?cFQxWG4wL25Lam8rN1Z1RmFvREx5dlhQK2IzMWFlb3A0SFRrNXlPcEpCbnk3?=
 =?utf-8?B?Q2pFNVVIeGt0Tmk2NWltc0dIMGVKZVdDZHlFRW5YM21EZEZrMmRGWjdVL1dJ?=
 =?utf-8?B?VjR1VmVLRU41WmNKdEJGUXdNOFFUYnJnSk0xbFRLR05xZ3YrZUYzYVo1SmQw?=
 =?utf-8?B?aVJBS01NcGJUWWVHRjh4VE1RdFJhTFlycDAzZTQwRmlOTjNJMGN6OUZtRXdv?=
 =?utf-8?B?TXQ0S1FpaTByWTdEd0FlTlJWNGxoL3pPczRyd2lBUCtjWFd0TkhUcmJ4a2tx?=
 =?utf-8?B?TmdHY2hjYU9KbTY0dTd1dWNWdTQxQkE0blprQmNOeU0ybGtWN3hJQWNmYVpG?=
 =?utf-8?B?eVVjUDRjaXMwRUhXN1JRc3VhSkxaU3k3K2haT0RudVpTVitZOWRxaC9oY3hI?=
 =?utf-8?B?SUd6aUswei85dTl1RVNkSGtWckFkUVMvYWFrMGtnRXE5WUNlaDVid21HczZp?=
 =?utf-8?B?Vi9oUGx3cE1ZYzIrL1JGNlp0ZDNtUThMaWxmNGpjZEF1eWlTUGtzT0x1ZDFD?=
 =?utf-8?B?ZGNzYVJCeDJ1WGJCUHgwU0dyak1pU1VQc0RRaERuSkRUemFJOWhxMTlzbldn?=
 =?utf-8?B?K2VJZ2I5bmFvQzB0WS9IOEx6cElmeHVrMEpSY0QwMDNYZk5KL2J4V2x0WkNk?=
 =?utf-8?B?OHFzei91SVQ2R2F0Wm1iRTRld1BRT3gvdzVUbWlhVUE5dklJYmFwaGY4dlBn?=
 =?utf-8?B?ZCtiajA1a0lFcHp1cGtqS1JJNW1tc3ZacUI4NFRNN3JCb3l3WnMzWEdCS3FD?=
 =?utf-8?B?NWx3S1BPbnk3eTVHTm1RL3ZNWVNZUzdxYUFFaFhYMEtDdk1EYnZjbzRLNUFh?=
 =?utf-8?B?aEZuUlBjSlBiU3owc1RFcjlYQ3JvdjA3R0V0OFhlUW1Ca0cyT0hid21peC9N?=
 =?utf-8?B?R3k3NG9hUVRneWxzT3BHL1pqNjJZeWpzd2ZoZ0JTSm9hTXZxd0ZJU1FUTVdT?=
 =?utf-8?B?eGFJcVhWVGJCLzN6Z1dFR2dnRy9WNU9Kb3g0VlpRU2o2SFZvNUVaT1hBVStR?=
 =?utf-8?B?aU5rQiszcGtMcEVjcEtZVlRYRkc5TE13QkRrSWl3NVcxOEViRVM5aW5FVG15?=
 =?utf-8?B?N0hsdFUrd3B2Ry9FY1NkRytlZXNLbDBaNUZGOFBYcEFkYVE5elhaQ2lkUDlL?=
 =?utf-8?B?RkdtdVdYRUN2UWVueEZMKzhvTE1JeTIzbmJxdVJRNWZROW1uakNKNkFSUDMv?=
 =?utf-8?B?MEVUNi8zWWFLRU83TDhPS1dITTJaK2gxODRYUmZtMWcrL3FjamRSdllnL2Fo?=
 =?utf-8?B?MFN6SE12cjZ3V3BPODdudTRsS1A3K2dCeTNQOXlDUVZGMER1dTZ6WXN0NGpx?=
 =?utf-8?B?WE95MUFydENPOXFWU2F5MmswcjNDT0NPSFBNU3YrWTZEUUhqV3NpRmNKWFc2?=
 =?utf-8?B?MllzTGZCZ1ptb1pxMjJ6T0d2SjJ6ckRCWmhDS1dlWHVMeHV1K2dWMEZ4WGc3?=
 =?utf-8?B?MjkyZ1NTcUhFcDhMQ3p0VHFBUmN0VUNEOTQ5ZXBnUDFtendWNEpsYU50SmlM?=
 =?utf-8?B?SHFYMmJFdDNsZ1JaTlF0b3FJNVNaSitySU5KMlc0K1c4MklONlUrVmF2bmFV?=
 =?utf-8?B?UmNpb3NETm1tZmhuZFRHL2RaS1VrRFRyZ3V6L05tYlVjUm9lL2JGR1c2cmxG?=
 =?utf-8?B?anRmV1dkZFB1QUxOS2xsditQR29JNzUvYUpMNzdFcDJna2szbXRFYXZDTDZ0?=
 =?utf-8?Q?EdfY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927a919f-d268-4d95-71af-08dd77ee50b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 05:12:39.5944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CubdgsZ6e29MchtY7vY0t4hYU8bcYqTW1S9XbEwwWN7RM1zVI1LBbUHEatWR/yt6pApgIw7qjhplXmXCnFObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3833
X-Proofpoint-ORIG-GUID: urPxPmrrgxJQcdNtwt7z9oMvSHaHB_AH
X-Authority-Analysis: v=2.4 cv=YbC95xRf c=1 sm=1 tr=0 ts=67f7534c cx=c_pps
 a=l5p8UTqLmUd1ApN92JXWiQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=6ot50o3G2uS1oDQF7ocA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: urPxPmrrgxJQcdNtwt7z9oMvSHaHB_AH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
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

PiBUaGlzIHBhdGNoIGZpeGVzIGNpcGhlciBkYXRhIGxlbmd0aCwgaW4gdGhlIGV2ZW50IG9mIGFs
Z29yaXRobQ0KPiBjaGFpbmluZy4gV2hlbiBlbnF1ZXVpbmcgY3J5cHRvIG9wIHRvIHZob3N0IGJh
Y2tlbmQNCj4gY2lwaGVyLmRhdGEubGVuZ3RoIGlzIHNldCBjb3JyZWN0bHkgd2hpY2ggaXMgaW4N
Cj4gdmlydHF1ZXVlX2NyeXB0b19zeW1fcGt0X2hlYWRlcl9hcnJhbmdlKCkuIFRoaXMgZmllbGQg
aXMgY29tcHV0ZWQNCj4gYW5kIGFzc2lnbmVkIHdyb25nbHkgaW5zdGVhZCBvZiB1c2luZyBwYXNz
ZWQgdmFsdWUuIFRoaXMgaXMNCj4gcmVjdGlmaWVkIGFuZCB1c2luZyBjb3JyZWN0IGNpcGhlciBk
YXRhIGxlbmd0aCBpbiB2aG9zdCBjcnlwdG8uDQo+IA0KPiBGaXhlczogM2JiNTk1ZWNkNjgyICgi
dmhvc3QvY3J5cHRvOiBhZGQgcmVxdWVzdCBoYW5kbGVyIikNCkNjOiBzdGFibGVAZHBkay5vcmcN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhamVzaCBNdWRpbWFkdWd1bGEgPHJtdWRpbWFkdWd1bEBt
YXJ2ZWxsLmNvbT4NCg0KQWNrZWQtYnk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+
DQo=
