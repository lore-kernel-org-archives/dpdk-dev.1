Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D282C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 16:00:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C3CB402A3;
	Tue, 29 Apr 2025 18:00:34 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
 by mails.dpdk.org (Postfix) with ESMTP id 139D540277;
 Tue, 29 Apr 2025 18:00:33 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nV7Ry204zLbMCyd0KD6JhTmBktdrBtBgKRIOAlmyRK1fggywt1YvtcBaun/MfTRJXgWIZSyIlKFQr/CShXVvNnKdOof9l895+yMsWU4AlGZYDlKjIOl+VmiY5v5WELaD5BK8vMrbeEzlD1vgJq70IwqHf2O5ptGstiIg6qr2gjgdzybfMFDACRMI+m4QS+wSLdNsxKFz2LA7rZ2I2YOftYyteOfdqHCcZaxMgzXpjcd0/NcyeCw9HNmqWCIGGWrrXG39rM86RkozQ32/Hi8alGUlWY16O5agEbPcXOn9WGLuPuWDQebqTGMqLvpHnD+mZBtJpzSdQXLDLrzLeKRRGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgXS+5gIeNsHCooHrgcAI3beQ2AMxWrQV3zsk10kS64=;
 b=xgo7jIF09AHD9/jcjlLPN1uqdyb6u1LcIo7w3Nm1tVtGxWWUqHsd3jXmoZQW3sANqz+Ui+XV1r8X7WMeG7225ry9XnFACCp9Dxul+U2dOMHmXYz/NHW9CgcpwLY+tYTX/Yc/FPZSaY+/QKri3WwJXcWVgZh9DUQgjI0sBloW1jxrEYxg/i13P9ZN/W/R4X7BS8t4O9sqSCaiGUCBeq/0i3D5zQStYqYh6i9ur0ex+Ubu/F9WTSatAwED5bMypzTVwAMgsnQiha9Gye2g/WSh2MluCJb8a+/8FSs0nia2UPuz7wKsexg7/gLQIph4AdRxw6h1PGK3+qNdcVwJYtFibQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgXS+5gIeNsHCooHrgcAI3beQ2AMxWrQV3zsk10kS64=;
 b=N1E673gYVpMVu1RGZe2dFPFUY9qCRDNgFk2yqH7eiF0lOnJCbyV1fvga/9I8JmnA+50Ar2KsX8MeoK4+fF9UnSBLDnbJAgy+Gebz0wxhd/bftJWVNJyV8HLF/c7YsBtTU4xZONDhlwY+FLd5AndUskcz+vw0fA/tG1i3kfyzz1s=
Received: from DU7P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::9) by
 PAVPR08MB9795.eurprd08.prod.outlook.com (2603:10a6:102:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 16:00:23 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::bf) by DU7P190CA0015.outlook.office365.com
 (2603:10a6:10:550::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Tue,
 29 Apr 2025 16:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.20
 via Frontend Transport; Tue, 29 Apr 2025 16:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAObOW+w8J3r8oJGxMaXFiIxcsvENd/uODO8yXEWT2uT9s5N+jVm6Hay+gKIjaBupSjcvlxvc8xJjakmZolJa7bwodt/TX0lnxIOsHXkD+zhyxSdYdqIUojv8Xpkw/gFP/iydSe5b9KKFKgDeb35EKdosNOJ0QXWBzqL8b/9VajT/4LswiHFwcmLktshF8lvTyBOBSJuLTJlGb4LxSuFln3DTw8hnEeI8hBEoLIAYiRCVmTUPLHnUqUu7FWzfggF1Ze90tWa1QAX689nMZFrK5BpAf4xZsIG+X6W34RloN4pHTGwIX7CKJsytCA9lOgxGDg40o+CGdlVgUlDG2vnvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgXS+5gIeNsHCooHrgcAI3beQ2AMxWrQV3zsk10kS64=;
 b=LO1RDQgm99m8AE56HcPzFwstDijSbrN+6BdZCZ9ziF11Du8bpaGFGnw6rdQ46GLVs3TQYCcLRlL6cA8pedaQZNYTVpR60f2t8Ke2FgVJoJpT1QheLZD9Dn1KoptSbgvHQkPqgIimmodKpvXINDiOogZG8qejaCnPYiBC4R5g+i3SqVqa4T2nXYAcJHtuFyk0rw303ewUPv76+kZp8nvOaJCdazGl4OKWZfOwUX9M/V6x3vgh3uUsIYfM9OLQeWgVNwp8XV3vNh0r2UJG0GXcCufU1I7UJ2ltQFiW/lDUP1USD3LdM+tMcelliXMoqgJF60UoZ7lPF7mjvc5vda8o/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgXS+5gIeNsHCooHrgcAI3beQ2AMxWrQV3zsk10kS64=;
 b=N1E673gYVpMVu1RGZe2dFPFUY9qCRDNgFk2yqH7eiF0lOnJCbyV1fvga/9I8JmnA+50Ar2KsX8MeoK4+fF9UnSBLDnbJAgy+Gebz0wxhd/bftJWVNJyV8HLF/c7YsBtTU4xZONDhlwY+FLd5AndUskcz+vw0fA/tG1i3kfyzz1s=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by DB3PR08MB9135.eurprd08.prod.outlook.com (2603:10a6:10:434::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 15:59:49 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 15:59:49 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Patrick Robb <probb@iol.unh.edu>, "ci@dpdk.org" <ci@dpdk.org>
CC: dev <dev@dpdk.org>, Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Doug Foster <Doug.Foster@arm.com>, nd
 <nd@arm.com>
Subject: RE: meson error on ARM Grace server 23.11/22.11
Thread-Topic: meson error on ARM Grace server 23.11/22.11
Thread-Index: AQHbuLEfsa7dChG3T0OcCfgSyjr9q7O6yZCw
Date: Tue, 29 Apr 2025 15:59:49 +0000
Message-ID: <PAWPR08MB89094F996EAC0988995DE9899F802@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
In-Reply-To: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|DB3PR08MB9135:EE_|DB5PEPF00014B8D:EE_|PAVPR08MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: a5120c52-38c0-4dae-5b51-08dd8736f283
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?RzNlR3dZQ3o4NjQ1MCs4aTNrTlFRVk9DZ0Z1L2trZEJGemcxMnROYUNRWjRy?=
 =?utf-8?B?ajVuZXlzeGU1d0V5ZCtBdEhlY1VXY1gwdjRnVUx6RjQvUU1pbUVVRkE5Vlgv?=
 =?utf-8?B?TXZuUFlUMC80d294aStTS2hxT3ZwbDV2R2RyVVU5VS9IUHdDblAxYW9VTFdG?=
 =?utf-8?B?b0N3NEhqRko2aDdROUNpSnI1YWxtR2l3VXBrQVA4aE9GN1B6SjFaa0ZWdXhl?=
 =?utf-8?B?b0g0Z21KZjFsN0lKUTFSQnJuWXcwa2R4aHVrZ1RqbHhmTHIwTHJ5MGEzUHN0?=
 =?utf-8?B?WmE5TE1ZN2RrR0RMRDB2T3NxYTFqeThJNlNVcHBnZ084cjh0SXVyeUs2WGlI?=
 =?utf-8?B?K1Q1ZC9FTzNpMmUvMWZyV0wySjYrYy81RklMOFgvZ29jNDQvOHg1MlNiVU1Y?=
 =?utf-8?B?aTZxUlN1SmdzZ0Y5ZEJnUFgvb3lVRkZSL3RjeG90dHhET1c2M1RLRTY4bURI?=
 =?utf-8?B?d1BhS0F3RjFnUUhTcVQ5cm5Qb3JwVkRuNEdCTFcwY1k1Y2pWejhOOUVZcUVj?=
 =?utf-8?B?UTljTzBxbDhLdHc5Mzc5VkFYYTRqb3VSUDRzakhQOEJjeVBLc3FLMGFDSGRD?=
 =?utf-8?B?ckFFUWRSeTVocU5XNGsycjNwakRpVFY0MXA1c3RGVWwreml1ZHRYUlBUQVRx?=
 =?utf-8?B?YzdGeDZFOXhMb0RnSUc1S3RWaHZZVFZXcUN6d2pEUm1WOXpBUkthTnE4Um0x?=
 =?utf-8?B?UDhnYWJWRCt4SlRuN3RjQjhyV0VvcUNzc0VmOFJ6bVo0dTBQUDBRWnc0aEw0?=
 =?utf-8?B?ZG90ZmxWQ0FjQ1cyMVBGVXRlK3V6Z2lzdEpZR2pqMTdoSWFxNVNzTkIrWlpB?=
 =?utf-8?B?OTBZWDFYRnRId2FPRUhiSlJ4elJ3ZU01d2Z0ei83V3RZZXVNOCsrRVo5OWRO?=
 =?utf-8?B?b3AzVExLTVFUSEdKaStXN3NjWnlRd1ZJa29Gb0podjBPK2tWTU4vTksxNUFv?=
 =?utf-8?B?YjhzNVlBN0R2SlMvRlNjaFg1cUlhOERwbHY2cFQ5S0ZacTg2bXUvUTNwbm5v?=
 =?utf-8?B?SjRLeUw1YmpjdnNpRVBHaHNQRkRpV1B1ZU5RM3l0UTBidjZhRVJIMVl1T2t0?=
 =?utf-8?B?bmNRT2E0SE1RaFJndmRQbjA3YXdMeTd1UFVNeTJEdzBKcEJhblI0OTd4VXVJ?=
 =?utf-8?B?NU5QQkVEODZJa09EcDBUREphOW9NaGFHcW9mSDVOSjRxNGhjamw1TXJYN1Qz?=
 =?utf-8?B?WEVnVHZWWFNxb1liWG53YnpzZEFTQlFneDJEdWptOWZZMVFWWlJRTm9yZFNQ?=
 =?utf-8?B?bm9ZS1NDTCs1TWNNWVAyalMvYnRxZ1kwMVduZXFoTDNLTEpOUkgvbFdZY3hz?=
 =?utf-8?B?ekkvbVdvVnZvS21qTmZGZTlZQmcxVXZydWZqOGpwMkhEWVh3bTc0Umh4M1dF?=
 =?utf-8?B?a3ZpUGZTcEUxV1BjRUx2WThBV056QWlhRHUvTlJ2UlN1UE5mUEN0a2xBMTV4?=
 =?utf-8?B?VDl5ZmRpTUpRSVQ0Zi8yVElEcGxJNjE5NHVBQXp0Ky9JZG5SSmpVaFI2RnE2?=
 =?utf-8?B?dGFrNFA0VG5QV214RldiQTRIdmlHN0lPVWp3c3NWQm1ydTQ1VXUvVHZKV1dh?=
 =?utf-8?B?RWVLTGxEUHc0WTQ3RjVWdjYrRWRhSFdrUTlKS0JHQUhMam12azBkY2FDMDV3?=
 =?utf-8?B?OXFocEFFOUNtQ0VyL1JFRTdEZVpvcUtkR2dqWVUyOU9PVU5OMTRCOURmQWxJ?=
 =?utf-8?B?Q00zNGdoVUNHa1FpYXhranFtcVIxTVhJWmJkTzE0RWNacEJqOVh5SzVVNUdO?=
 =?utf-8?B?SjBDSTJIZmVtT0NVMnExOHp0a3d1UGhvY0hKK3hGQzBEKzhRa09sazA4T1hz?=
 =?utf-8?B?U1Mxcng5dnZPaVc1emNEak5jSEZjR2ZzeWVZSWRBbDdjNjBvb1NvdjdSMlVp?=
 =?utf-8?B?MDY1OFU4a3llRFdzNXJrQ0d6azdJYU1kaDBXTzNSYmhnMkVsMmtsR2N0OFNR?=
 =?utf-8?Q?jwXyjLkp9rT+5YyNi0S8+9dC6LMms4s4?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9135
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 303c4ed8-0104-444f-15f6-08dd8736df1f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700013|1800799024|82310400026|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2lrK1BNZUsrMDZQdmtwRTByNExIWjJHM21FRDZYd1ZiUmVFT3hOczV2VmVr?=
 =?utf-8?B?em5vR0ZraDN0c1NML2RxN01ZSVpoZU5CYXZ1R0R2RXZWWkRMV09nVXgwUkRR?=
 =?utf-8?B?NG9XL3NacWY3TlgvQjZLQncyYmoyZVVjSGNGTjY2citaNTUrQXlFcElwdUpH?=
 =?utf-8?B?QnNWcDZITUtNN1hFR0hnYU5jN0NhdXRRUWpXVW83YjRHUExxNE82NFZtR2JX?=
 =?utf-8?B?TXFPb1p5R1FoQ3FMM3MxVVNwcVZlcW0wUW5PMlI1WG9mRkxaL2hzSnpvUmVx?=
 =?utf-8?B?ZXE2VzZoTmQvYWY5SHhJREwzOTZkUXRrYVNNWVB1TXVDdlBQL1l3clhnQU8y?=
 =?utf-8?B?Q0p6NHR4Nm15Y2d1RGZoWUVCZDF4ZEJ6UUdDR3BEb2ZiL2EwV3VFMW9PeDVE?=
 =?utf-8?B?NmEzR09RUVE0OC9SbTJLRTJrN2tKY0FqUzVLd3JXcVhCTHY4STBYT0IxZlNi?=
 =?utf-8?B?dlFNNCtHd1pLRzBpUzQraVlOSTJLanNnb29sTEpySmh4anplekcwRFYyVjJm?=
 =?utf-8?B?aVhrWW1xRks1RTlhMGlvNDdCSlEwdlV1TjllVDVIbzIxeThEREFLejBWQWNy?=
 =?utf-8?B?a1RCckJOR2d5SnVyZTFrVmVaTEQzMnZqQmxFZVBIOEh5MXhPZWEvU2ZuckMx?=
 =?utf-8?B?a0RZQ3ZiSEtzdE9qais5TGxaV2x6alVWMW1CWm5qQ3JNY2I4ODZKY0FuTzdx?=
 =?utf-8?B?YVlwVENDVmhOSlhzdnlidU9USUdsTG1xSFFrcDhrV1QyVWxKVFZEaVdpNXpx?=
 =?utf-8?B?TmpEWVJGZ210OEpybnRTYnpPTnErb2NxMjFxTERUdEVuVEpPUGxJTXo0NHF1?=
 =?utf-8?B?RExmVVpqa28wSmYySFRsSDFUM2RoeE9pa3RFNk1aSnp4ekZJMFVoaFZqSHJ4?=
 =?utf-8?B?d3JxMDhpRHhnOVBIdjVoVG1MSFY3dkVxMlk1UjV2OFBoeGFTOEtoQ3JYUU53?=
 =?utf-8?B?MTdyQWxvc3cwWDFyVWdPZFdXVWMxOFRBM0RHVFFoWTkzZGcyYzBlZktDYjlq?=
 =?utf-8?B?TEdnZnRFa3hEOHdYTFAzUzlwOHYzaW1ya3ZQd21pM3dCVDJuOFZ1cGZWcnBV?=
 =?utf-8?B?dm1rYXhWREVUbHU2aE53aDg3ZXFxaVF1VW04Y1h6Z0QzcEsyd0I4SUVHRG5y?=
 =?utf-8?B?YmlKa3V3YjRKTVJ2TjdHblp0S2I3dW52ZTZPMktWVDNQSUNRZ2ZJNDBOZmVE?=
 =?utf-8?B?T0ZTTTRpUlowV3AwbW1oQ1BoWEFHS2drd2l5R2NLcEIyYzhYTE53bi9OUnFY?=
 =?utf-8?B?aldydXd6SHZFSlFGKzU5MzVhcWJUVE1vMkc5VjdreFBpT0RJeS85bFZmbkh2?=
 =?utf-8?B?UXZyVjhsQkVVanluK0VyQkNQZGpJbk5OWUVrcWRlMGtoOU1LTUJ0Rm00OXp6?=
 =?utf-8?B?end4MlBCQWU0UVJFRGF6WTA3Zk5zS0hHcEdyZUZYUlhPdjN6QTR2MnUrL1lR?=
 =?utf-8?B?MXdCaVVQTHJGS1QrbGRhSVR5S0RPcXV0ODRTR3h0eGVSREoyUDN6R0xZYXBv?=
 =?utf-8?B?b3MxSjIwMDZpdG8velRyM0U0aEg1amwvUXpERXhHalBRcDFjOXl4K2N5bC9o?=
 =?utf-8?B?aU1BYzQ2N3FORlN3TG1Nb1dWTktWbWF4cWVscVFmK1ZIQzE1N0lyTE1YVzAw?=
 =?utf-8?B?a25KbkJCUE1qVFB2L3RQb2ViNXo2V0l1NXdHcEM5YjVxVmMvcGJPRk50eG9R?=
 =?utf-8?B?QTlkQXZtQWJFSGs3L0dYS2twMk9MbGEvSWlLY25CeURCcUdSODNlT1pjRDVt?=
 =?utf-8?B?aThDa0xJZ01lNERGczBmRWc4MldVMzQvQTNaVnFoQkZ6TloxQzBkSzFTMWVu?=
 =?utf-8?B?Y2lVVzRlaXQ0cFc5SGdnYTFJNUV6bDFZaHEzMXA3Q3BIdldmZEtIbVpURFNP?=
 =?utf-8?B?RXVTNXZQV2NIL0ZJdHFpVUhFZG9YV2s1TGhYcE5WWGhaMGVPR3BKQ3d2VVVw?=
 =?utf-8?B?Rmt5SDNFSWNpWFlwV1dBRFRidXhVUVd4MHpOempwZklyTGk4bmtvclJ6UFJx?=
 =?utf-8?B?eWxlMEhyRWxBPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700013)(1800799024)(82310400026)(14060799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:00:22.2139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5120c52-38c0-4dae-5b51-08dd8736f283
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9795
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

PiBIaSwNCj4gDQo+IEF0IHRoZSBEUERLIENvbW11bml0eSBMYWIgd2UgaGF2ZSBiZWVuIHJ1bm5p
bmcgQ0kgdGVzdHMgd2l0aCBhIG5ldyBBUk0NCj4gR3JhY2Ugc2VydmVyIGZvciB0aGUgcGFzdCBj
b3VwbGUgb2YgbW9udGhzIG9uIG1haW4gYW5kIG5leHQtKiBicmFuY2hlcy4gSSBhbQ0KPiB0cnlp
bmcgdG8gYWRkIExUUyBydW5zIG5vdywgYW5kIHJhbiBpbnRvIGEgc25hZyB3aXRoIDIzLjExIGFu
ZCAyMi4xMSBmb3IgdGhpcw0KPiBzeXN0ZW0uIFN0YWJsZSBtYWludGFpbmVycyBJJ20gbm90IHN1
cmUgd2hldGhlciB0aGlzIHNob3VsZCBiZSBhZGRyZXNzZWQgb3Igbm90DQo+IGZvciBoYXJkd2Fy
ZSB3aGljaCBpcyBuZXcgYW5kIGRpZG4ndCBleGlzdCB3aGVuIDIyLjExIGFuZCAyMy4xMSB3ZXJl
DQo+IHJlbGVhc2VkLi4uIGJ1dCBJIGZpZ3VyZWQgSSdkIG1ha2UgdGhlIHRpY2tldHMgYW5kIGZp
bmQgb3V0LiBJIGF0dGFjaGVkIHRoZSBtZXNvbg0KPiBsb2dzIHRvIHRoZSB0aWNrZXRzIGFuZCBp
ZiBmb3Igd2hhdGV2ZXIgcmVhc29uIHlvdSBndXlzIHdhbnQgdG8gcmVtb3RlIGludG8gdGhpcw0K
PiBtYWNoaW5lLCBJJ20gaGFwcHkgdG8gc2V0dXAgdGhlIFZQTiBhbmQgU1NIIGFjY2Vzcy4NCj4g
DQo+IDIyLjExOiBodHRwczovL2J1Z3MuZHBkay5vcmcvc2hvd19idWcuY2dpP2lkPTE3MDMNCj4g
MjMuMTE6IGh0dHBzOi8vYnVncy5kcGRrLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTcwMg0KDQorZG91
Zw0KDQpuZW92ZXJzZS12MiBpcyBzdXBwb3J0ZWQgaW4gdGhlIEdDQyAxMy4zIHVzZWQgZm9yIHRo
aXMgYnVpbGQgYWx0aG91Z2ggLW10dW5lLy1tY3B1DQpmb3IgZ3JhY2UgaXMgbm90IGF2YWlsYWJs
ZSBpbiB0aGF0IHZlcnNpb24uDQpBZGRpbmcgbmVvdmVyc2UtdjIgYW5kIHNvY19ncmFjZSB3aXRo
IGNyeXB0byBleHRlbnNpb24gc2hvdWxkIGJyaW5nIHRoZXNlIHJlbGVhc2VzDQpvbiBwYXIgd2l0
aCBsYXRlc3QuIA0KDQoNCg==
