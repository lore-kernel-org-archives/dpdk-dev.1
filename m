Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BA5CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 10:26:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41987402B6;
	Tue,  7 Oct 2025 12:26:52 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 63E55402B1
 for <dev@dpdk.org>; Tue,  7 Oct 2025 12:26:51 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5970mGXq018718;
 Tue, 7 Oct 2025 03:26:50 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023105.outbound.protection.outlook.com
 [40.93.196.105])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49mkqyhj6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 03:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu69tBzlhEH9BXbO+aZjHRXHp4VUfTfO2/bHaaCKw+GblZyNOUBlC3R3b4Gd+acL09N95hEorPdOg+Us0oYB0clYMOFZdbXRARSwM7jhmPPbuz+Oecl/Mu5FDME9vY06L5PtWeZLDZtAwuZljrRlYZAr8t++2My/DMPA0UvlzqQ7JmVK6FPThxMyDAofCVw2567ZimCbGti3R9aVILBymxKTNgV5QdatYp4TLvTvaxBDPuvq8YuRqme6qM1WjEdTQIyM1OvdrO2jOE/kAWpfX1cJ1FEg269DQrQvLAvr+SR27urrbFaFZJgGIQONATTcjGN8XLz0X+Hzq+vRYAgvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D537v1GlboumyR+E/QbzTP3C1UBmib6o1edv+3ZkIhk=;
 b=t3VynjKgLQRjj0Qv+PuO/rDenxDUwkR91PPLkVRePhAfTFhZ9//CkLxwSlu+rumxNWsasUTrCfUccwcxwiVlPkJFyVil4740gdR2qnAx4mREg/f7PLM4K212WFJUa2hMtNG9oCe2+Mqb4DkPlRO/Dw4PtUFy/Na7n6VM9iKwOAoMHu4jThRwlG1vtpwnPqESx2xF35S2yC+coMRRFmH0AGiU78JAkHFmCA47Cv0K31ycAuf3VP8L5nnCSc7arLAjJt5wXQrvAmZ5azSW2DotGYaxfRfIiGPdvL6AQNyQ/Nqi+2QGCBoIp9ii+mrFXYG3winxrIVGNCH7TxCqO0nrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D537v1GlboumyR+E/QbzTP3C1UBmib6o1edv+3ZkIhk=;
 b=u2hpHqsts4kCBSdqPCMxmi/VQ78EV3VU+XnggKOwPDGsfk7NwY8ztJ696PkdFt1DV5G0PAxKcZXEuiaGTaDLIh53pE5h0dikAwz9RdOjkl3AMKUS2/Z0k7xpfGfrCVmoiYkh6X0Xs9dACTU+lE8/nZB0Z2jTv+bmSClHWxKGdQA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB4583.namprd18.prod.outlook.com (2603:10b6:806:1d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 10:26:43 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 10:26:43 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v4 4/4] doc: add doc for dictionary option
Thread-Topic: [EXTERNAL] [PATCH v4 4/4] doc: add doc for dictionary option
Thread-Index: AQHcNv0toR6XpFHsFUCjgQNjLViborS2e5RA
Date: Tue, 7 Oct 2025 10:26:43 +0000
Message-ID: <CO6PR18MB4484961ADB302B87B6A473FED8E0A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251003194901.3375364-1-svaze@qti.qualcomm.com>
 <20251006200904.2467957-1-svaze@qti.qualcomm.com>
 <20251006200904.2467957-4-svaze@qti.qualcomm.com>
In-Reply-To: <20251006200904.2467957-4-svaze@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB4583:EE_
x-ms-office365-filtering-correlation-id: 3b160121-9582-4d7f-c6e9-08de058c02ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UHVOVjdWR3daU1hkV0Q2Vy9iWitmWEdQTjUwb2VTa2Y0UWw5aGxQOGlUTkVo?=
 =?utf-8?B?M0QzNWNqbXFaMkltZngrckw3a1hZZjI4MWJEUENSTTI1SGdNQ0FHWUNMZGlM?=
 =?utf-8?B?aXRqanlWUFBCMVpjVWpHc2pZQm5ZVU01cGdyWkQwN3dIYVg4dElJc0tORTRl?=
 =?utf-8?B?RmI4R0RMUHN4eS9UV0gvK1FVYnk4VVJaOHZHRlhkRTBVNmVsZmtPamR6R0hJ?=
 =?utf-8?B?Q3h1VXYxQ203OEhsTGhFNUZCekt5UmxKSWM0cVA0YmJQdklBRmdpcXp3Q1RB?=
 =?utf-8?B?S3pDWFdWWnlPS2t4azN1Mm1tNnplNit1UWducXRwdEtNYVo3S3NYbllNK2kx?=
 =?utf-8?B?N0hlTmlCZFQ4ZWJKYm43Wk9UTzJ1cjhTY1VmbFlKZVB5cTZZcVdvK3FCQlZa?=
 =?utf-8?B?UWN5aGlrbVdWNEVVR01vKzZhdVFJU1c3VDhZUWwyYnZid0FNUjRCOG1XNnBh?=
 =?utf-8?B?cDBRWG1leWo3QVQxa1paL1ZlRWowYVFYa2tYSTNlTlBMKzVOQjVHeG12UDk3?=
 =?utf-8?B?TGgvYTNlMUpHT0hTRXVsNFd5c3YrRjBXS080eFBkVStZN3cxMGs4NWRxdXov?=
 =?utf-8?B?Y2tUYks5elVIUENXZXlQSHJma21lVUM5TmxSSUZ3T3ZaeHpzL0MxTEpNQU1J?=
 =?utf-8?B?MVFrajFzaHdLY0lxM0VSNlhXQ3dpRElkb29Rd09vNnBLUWx3QWtaS25XdnFR?=
 =?utf-8?B?Mzh3aEIwa3ZscjMyaHJzK1ZmZ1NZN1NuanpsWndaZ1p4Y0MrVzlEUWZkWWho?=
 =?utf-8?B?Z1JUQmxvWDNhaTJRYVlCSUZDSmx5Wll5b2FUSktvejlkdEtlK29iU0Jkanpz?=
 =?utf-8?B?VSs5Wk1aUGVQRnA2MlBJREozQmZOL1o1cEtpK1dFOVpiZDJvM25wUFUxRmRn?=
 =?utf-8?B?QThiaGV6dkFERmZmRGNtSzRiZ2k0NFpIOUVTcmRsclR2WThYcXBrVTNOOXRj?=
 =?utf-8?B?THFXNVFCeXlVb2Zvcjd3MWYrU2JjdERMbk5UODNCV2FMcWlONW1HUW4xVDNp?=
 =?utf-8?B?VUZiZ0JZaXBudkNTVytzNjlzNWZZeEhxS3JyQlRtQ2ZKMTNRT3pDbGhOTjQy?=
 =?utf-8?B?VjdRTmtnYlY2Nmw3dERObENwcFBYa1NLbmpGc3p6VmhySXZHQ09EeUNwY1ZI?=
 =?utf-8?B?TEZ1QnNSem4yS3YzTDRvYW5jZVNGQXhEeFdHRC9WZWI4QS9QSFpZYnNxZVNT?=
 =?utf-8?B?RUFEa0RSc0VDdWdxZms0b3g1b0Y5ZVVuYzhnUHVITWxZb1hOSFNTdjA5V0VM?=
 =?utf-8?B?THl1V3lXUjJVK0xEQ0I0UW1iTFJYTjJhQjRHeGZ1ZGpGVXppd2lzZ3dMYmJB?=
 =?utf-8?B?dDg2NmI0ZVJzdTBSamRmcXdPMHVGMVZiM0FYSTdLR0RySFgxVGtnTGt1VlA2?=
 =?utf-8?B?RkZNM1NwS2xuWTRtV0Q2dlVEZGU5U2VwZkllYUFUQnk3RzExZ21jeG1hZk0x?=
 =?utf-8?B?MkdFOWd4NG5qajBiRkNqMnE5eUhUNmtaRTNCdjJxTC9OWEFubWVyT0xlZ2VL?=
 =?utf-8?B?ek1BSTN2ejRIS1U2S1V5YjJQNW9DbFRhQVRCVG9FNTUvbWFDQjRNU3M2Nzgr?=
 =?utf-8?B?TjEzemFUSmhhNFVzR0Jia3VEK2gxUjVJL3MrZktkeG1ScVcrN3JTRk82Z0JW?=
 =?utf-8?B?YUtseEhQQ2s5bE1hL2REcWd3VzBzdHRRQXRqbWpHcEplSHl4Ny9wQ2gzTmdD?=
 =?utf-8?B?S1ZMUWhjbnhUdjdIdUF3L0hmazIzU2VzYlRqOHVlSGYwQWFtaXVwdFRKdkUz?=
 =?utf-8?B?aXk2UFJMQnBCdEw1QzVkNFdUZ21SL3lBdVh5Zm9wb2hMUkVqaTRXWVdkWWxY?=
 =?utf-8?B?dU9CWWJlZjJhUi8xR2U3MTJSY1QrZmNSVHZtS0dQQ2M3dGhucDJvd1BSbXY2?=
 =?utf-8?B?Mytxc2RCNVMzdFBkbzhBdjBITkY0N0d4MHRTalJoVlltS09CcVR2NXRYc2sy?=
 =?utf-8?B?dnkzYk15VE9MMG14K3FhSjZkNDhQZDE0dlJsU0NiTUlLQ2NITmx6WXNuTnI0?=
 =?utf-8?B?OW9WU2ZYM1ZFWXp1YkFtNTFOcjVnQUZqYlZhVDV3emtVWG92SHp2bEJpbE1x?=
 =?utf-8?Q?cUdiZ6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmZCa2MxYm45U3NNbDROcXVBanlwNlZNYVhZSzk0UW5tdElxelJZSjhtS05K?=
 =?utf-8?B?REg0dHBpd3VCd29jaFBTMTBkbVd4STBPTzdBWkxxaHdiRHNWNG8zU2MzdGcw?=
 =?utf-8?B?UnNiWnhoWnF2UC8xdnJkd2pyNExTdk9xcXozc2VBc3FZczNSMlRkSTNESTlS?=
 =?utf-8?B?bE9DTXM5SkVRSTRGRzFDZG5BMnp5cVRHN0Y0N1NmOGVuN082MXN0UnFRdERk?=
 =?utf-8?B?a1d3SWdXQm9zUWw5aGlXM3ZYSkozeFNtZmhTOWN5b3d0elJNQURnU0w5Zm9T?=
 =?utf-8?B?UzRSNUFOUDB5N0xkSWswMThyR1N4MXNPK3J5eWpzOXY4UTlWSEk3UXRYTFZF?=
 =?utf-8?B?RXlSNXErRm1icVZQT0N1ekxaUHBpRUJNMUg1eE1LSWEzVzRIRTFubk9GcHpR?=
 =?utf-8?B?TmsvOE5rblhMSnBKSVZ4dEM4VEhjRXRzZVozd09LVGNaSGcrQVpnWGdSS0pC?=
 =?utf-8?B?Qk5DZVBlZityNmFwSXIrcmE3MGZrdUoyVWtvMmNJNFpuT096SXQxVlA2cEQ0?=
 =?utf-8?B?Q1VFMzdBWmtTN1lDRkZZYVhOeHhGYU84ZFRPR3FlaEtFOTB2U0ptNmFkN2lw?=
 =?utf-8?B?M3IyRnkxV0tmK1FrYzlDbVd0TTFjQ3VhRmtyOWtMVEVrQ0l3dEtZcVRMTEZB?=
 =?utf-8?B?VC9tcUJtTDRYb2sxNFgrYmpUQmxaeUwrZzg2eFV4MlZ1K3V0K2ZrKzIvdi9w?=
 =?utf-8?B?L1M0dVJQT0ZGc3lLSUhZLytoRkhPSE41RVhqSUNiUzZaeDdZdlJhQzlGUE5Z?=
 =?utf-8?B?UUlnSlB5WmFEQktEVlpDS2RPOFk4ZENRMjlWMnpnY1hhRjd6d2hUK2NmQkpo?=
 =?utf-8?B?N0tLMEhFNllhMFhDWC9NMW5MVUpNR3hWTHM1MTk3ZCtqcEFmR3NzWnJza0oz?=
 =?utf-8?B?amZkTDlkWXkvRG0xdC94UVdadXBSaVIvQXBTSzlHUmJ0L29rM3VWL0MvVStG?=
 =?utf-8?B?NWplMWp1M2tEM2N6SWp2dUdiL25ZMkJVakhFR09pcHltdmZLNFBQOG93aWpX?=
 =?utf-8?B?SFk1Q0dYcHhMcmdUR3hza1pJc2VTUWpyUDlQRXE2VHViWkEwVXlsdnQyZXc0?=
 =?utf-8?B?N2J0TVRQalBxeFd0M3pkdDFuOXZUbkpMVkUvb0x3RzcycE5wSmJMQXFidEM2?=
 =?utf-8?B?bUVrSndEL0oyOXdXdUVKSERudFYxTGpZNVdFN1JPMnE2cUpVMzdrODBaVHZy?=
 =?utf-8?B?UFA5d0hCK0ZTTjM3eUJuNnpoTm1jM0RXTG8rVGI4eW0xUjJBWHduSkhSek9l?=
 =?utf-8?B?QWdHaFNhZWNhMk9HZm92M3ZURTB2WFdWNy9EZk53V3VMMTV1bnpkVGhTaGVU?=
 =?utf-8?B?QUk5ZnpLY3h2YXpxakxraUx0OEQ1UGxXTkg3NUF1NE5SRXh3d3BvK1Z3cEJy?=
 =?utf-8?B?MmJscHcrNHExd3JRNFU5VzkzT3dqNHNMS1pMcXBuTnd6R0Q3NmpCRVp6djhU?=
 =?utf-8?B?NUE1V3o0OEpPZndQUWc3eWNCY2hHZGdVU291b2xCTjBESmZwSXdlZE9yOURz?=
 =?utf-8?B?UElHSUNObVV0bmpaOEJIeE9hbmF3NTNVSHNaVG1udzhHejNSRjNoa1hKcWdo?=
 =?utf-8?B?UXM2QjZpZ2pwVGs1ZmdZSHl2SzlWOXQ3ZjZWMm9STHA2R01zSnBEMWhqSTFn?=
 =?utf-8?B?cFA3NzdiLzNjK2hYMWk0L2o2UVV1NlVVVnNqc2E1Vy81M1ZCT09KYUEwekg4?=
 =?utf-8?B?ZEF5RWpBSXFuVEwrcld4T21MUUx2dkZyYld5TGtteHlpeVpjZjFlMTYwTUFk?=
 =?utf-8?B?VGpJelR4Zkk4SjJwR3hLY3hWZGMzY2lDOUFWRG9Ld3JyZG91Y1E5aUpzVmkr?=
 =?utf-8?B?Z0tVUHdOY2pMRWRPU0NHZHZVZHhyeVFBU05QV2dlRXhxLy9YYkFyQmZZbW1Z?=
 =?utf-8?B?RURRTDBrNTVmTERtMGZJM0t2d2Njc3hQakxoNm9jNjNISnJRR3FjeGtRME01?=
 =?utf-8?B?Ukl6bVBndkFWcFNFQVJMUC8rakpPc2N0WURvTHFPblBiV1VKTms4QzBON2Yy?=
 =?utf-8?B?dEFLazZ1MlNmSkdBbWNtR2kxWHJ2RkJvRlFwVkU5K1l0bjNpRWhWR003Y29a?=
 =?utf-8?B?ei9DcEVrYSt1dEQyYzFzRTB2Qkp3aDcvQXJzcmcxSFVxbm9sQURJVXViQjdY?=
 =?utf-8?Q?CjaKeWoGWNNprNUpF2HumkWke?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b160121-9582-4d7f-c6e9-08de058c02ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 10:26:43.1349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAfF6nETY/a3cHdRcSiUTI8HS/sZNL40o9d/6eIoe3lsrfeQtRv1nzNBsejVTK2qJevnEFuK9mw8CPZGQ5qFYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4583
X-Proofpoint-ORIG-GUID: YKxKbK-iCg-sTCkATj5KURlhlSepeDmX
X-Authority-Analysis: v=2.4 cv=YdSwJgRf c=1 sm=1 tr=0 ts=68e4eaea cx=c_pps
 a=pIxuDyK9WH7y4W83cC0qcg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=EUspDBNiAAAA:8 a=Cg0itWl9grVwb08WFSgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE1MSBTYWx0ZWRfX5eklUODp3geA
 BlOEXgKDKDTpNR3q5Tvet43giuxHTaALX0W0RGeSIBHmSBRVO2NNjgSjEUZ7ajBs4ysJGFQfFVU
 6tuQjbrr2fz4OPPeTBG8yGlofYWZRO2ms0b1bQxAwiP5miFSWXQILguTS8pj75idQV58CNazTcf
 daP0g/mDvZ9QLthcOaSIGn1ySoc7QJgN6v9Vd6lChxU7gYfi6MWj2YNTKIYfG2Wxyfnn0Tmg0u2
 QSBjoipNafRthNVIxJu4Xm4POYaenL6nxsFxPkMwP2QBmZU/xkb/KxkEEGi1By7KsXGoPq/Jz6v
 +qAW+U5MbNNpXypUtgccp/g1CtXx2JxoFnKYa735P40VzJKpJ39L+Jk2ir4B2Cuid3m3ciANiBU
 Nq3Bo+zz4U9lNHqdoUNdlvOgIU8NjA==
X-Proofpoint-GUID: YKxKbK-iCg-sTCkATj5KURlhlSepeDmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
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

PiBBZGRzIGRvY3MgZm9yIGNvbXAgcGVyZiBkaWN0aW9uYXJ5IG9wdGlvbg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU2FtZWVyIFZhemUgPHN2YXplQHF0aS5xdWFsY29tbS5jb20+DQo+IC0tLQ0KDQpT
ZXJpZXMgYXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQpUaGlzIHBhdGNoIGlzIHNxdWFzaGVk
IHRvIGFwcCBwYXRjaC4NCg0KPiAgZG9jL2d1aWRlcy90b29scy9jb21wX3BlcmYucnN0IHwgMiAr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RvYy9ndWlkZXMvdG9vbHMvY29tcF9wZXJmLnJzdCBiL2RvYy9ndWlkZXMvdG9vbHMvY29tcF9w
ZXJmLnJzdA0KPiBpbmRleCA0Mjk5ZWYwYjNmLi5mMGM2OTkzYTJkIDEwMDY0NA0KPiAtLS0gYS9k
b2MvZ3VpZGVzL3Rvb2xzL2NvbXBfcGVyZi5yc3QNCj4gKysrIGIvZG9jL2d1aWRlcy90b29scy9j
b21wX3BlcmYucnN0DQo+IEBAIC05OCw2ICs5OCw4IEBAIEFwcGxpY2F0aW9uIE9wdGlvbnMNCj4g
DQo+ICAgYGAtLWNjLWRlbGF5LXVzIE5gYDogZGVsYXkgYmV0d2VlbiBlbnF1ZXVlIGFuZCBkZXF1
ZXVlIG9wZXJhdGlvbnMgaW4NCj4gbWljcm9zZWNvbmRzLCB2YWxpZCBvbmx5IGZvciB0aGUgY3lj
bGVjb3VudCB0ZXN0IChkZWZhdWx0OiA1MDAgdXMpDQo+IA0KPiArIGBgLS1kaWN0aW9uYXJ5IE5B
TUVgYDogZmlsZSBjb250YWluaW5nIHByZS1kZWZpbmVkIGRpY3Rpb25hcnkNCj4gKw0KPiAgIGBg
LWhgYDogcHJpbnRzIHRoaXMgaGVscA0KPiANCj4gDQo+IC0tDQo+IDIuMzEuMQ0KDQo=
