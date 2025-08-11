Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D5C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF8140649;
	Mon, 11 Aug 2025 12:37:22 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by mails.dpdk.org (Postfix) with ESMTP id AB790400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:37:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6/lSSHfk2yVZJEi46f2F2d0U0wRzfg2QNBKL6AP1+OJuERZxjvypRzJb60WDlDkF//oYfXAgNWGFVaj7qzfHYRsGIuN86Rt5lKZHq0/cHRiYX9M3giwuq4WrbKkDZ+TNt6abdUwiczdnpfb4zMtZXPe3BhJYnm36vp5NhlJX1IeesEs4XF5hBDmAcVilBhtJzn/oqngW+tlZ79tXF58bRde5qtWGH/vImgzvY/Y+lyrfzCQBJmu7hymoY/TYs5YYIRg3ceofeeaW6kkxjZnJLw754O+A1PaG4Lm1HKlzETRIQ1OyTZElAemGOIku0XlRRCg50uXOfuIet2skrrWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NryV9tPiFFbVJg2thOcaNsni2kmW0XPeRv8T7aZuiAI=;
 b=nBjsQ8H5iV3ixBO9vQzFivUbHFnT1PGnpT0O9mLm+KPV6wyhYSdAb7u6N8uq/9j8IPyLB1CUHcv/RwqQ5lp1XwMlSOswL86pMblMSL4+M4Z86/tBkcyu+cGz//R9XAETaFpEL1LJPL4IwMuMTKb3uIv5O9LpGA+5lUT5iKY8vStvueVo0bi3QoXIttMSMr2KTohHAfTTwDIwx/aRPdEGgywoe1pPzjvqfgUuU6Q9gT8NrEOLsiKj6kWOAOD61ZE6MEd35QZ0+CSOhujd6gjrnCct4laeQXUc5SrlXw4rngMw5kYIby8t5ivTlc1y4AJOEjE7JRY5OZoDL7qjDHiKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NryV9tPiFFbVJg2thOcaNsni2kmW0XPeRv8T7aZuiAI=;
 b=f/7y0SmsH9ogVmkiAFUJLW+Dc3ZQSBD6XayOqditu3K8zCNtWzy2htdNddA//U/fwMvfqRBuTtmfOBpDsBCWGTkUIdbAqbqR4N34YlM1QAAx0s/IJQc38SjAiPwqlcIcFlbB2gHSfVoZ4brGAJV8yiV6/RMLERucHzD9pyK2W38=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:37:18 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 10:37:17 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Khadem Ullah
 <14pwcse1224@uetpeshawar.edu.pk>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Topic: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Thread-Index: AQHcBTOmTMs4cZesWkSBbj/ohPqRp7RYGXxwgAArOwCAAFY/MIAAD4mAgABTxwCABE1voA==
Date: Mon, 11 Aug 2025 10:37:17 +0000
Message-ID: <PH7PR12MB8596C293ACF92D446DBD10508228A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250808094900.5027f034@hermes.local>
In-Reply-To: <20250808094900.5027f034@hermes.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: 14pwcse1224@uetpeshawar.edu.pk
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-11T10:34:41.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DS0PR12MB9039:EE_
x-ms-office365-filtering-correlation-id: 0859e0a3-3e68-478c-13b6-08ddd8c30b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R0FHQmlnWllGYnQvS0k0Sk0vZGU5T1k5K3d2WDMwZDlTTk13ZmJEeTlaQ3RD?=
 =?utf-8?B?RmlrUlpna0JpSUl6bDQ5ZEovejFmY0VPaURrbzBJeDJ6VFgxNjQ3QU1OSmVG?=
 =?utf-8?B?SFpDVFFNNThleEJ6R0Q3R3lISVVCVW9XQTNCMHlhL0tWdlJzRi9PL1cxcXdv?=
 =?utf-8?B?d0Qvblpsem1hdWZtS3pCZVlHUmVKaHpEQzU5L1Ezb1ZDMDUwbkhLblY2dWNS?=
 =?utf-8?B?VVZ6SVNNeUJSUnVZRG5WM3ovVElndGVUMUJXUXZkN2NRa3JyZ2ViYWJiL2Iv?=
 =?utf-8?B?Ky9md1BqeWNJaEdWV0NOLzVjbWx3cXl3NkxINHVzOFlQeWtlVlBCcm1SQmt6?=
 =?utf-8?B?RU1MbnlNdC84dWV5Zjl0YkIrUlZGeExSdVFUWHZFUUdYYUQ0RUt4ajJTSmts?=
 =?utf-8?B?UmJ5RmRxbVh5Tk1RdmRrNE1tR0tVL3Q3RGJSR2IwNmlqaFBjRHM2UTAwM09W?=
 =?utf-8?B?eWxaM3h0K29oVmQ2SUpyemM0NGhVcU1pb3RWSFNLK2hnRFVmQkhrUXV3QVJ4?=
 =?utf-8?B?QUlyN3kwdk4ybGtzUDNRdzI3QWV2ZitTNWQ2N09PdXdEUTI5VnQvc3o1aUhh?=
 =?utf-8?B?QW9pSGIwcUVvcU0zYzF0WFJjVHI4TEVFQWdvOCtMYmZ6cC9XbW41WUM5SldX?=
 =?utf-8?B?cW1OdXN4Z05hK2Q0c2tGVG5UelAyMXFqemhtdXVia2JHaFRuL0dVeXVxaCt1?=
 =?utf-8?B?NC9sSGRtOS9jUWZyZ1M0UVJqS3JyUEovTjVJM2ZsdmZCREhZN0xBWkw0eXBX?=
 =?utf-8?B?ZWQyZUc2Ni96MEgwczlLdTlYdFFUVnRRMFlGaVBjeEFzb1ZSbzdpcjc0Q2Zs?=
 =?utf-8?B?M0xKVmxLMm5aaWtFMVpDMTcvcVRnVzl3VTUydDBySm1kS2xpQlFybUFXSHpE?=
 =?utf-8?B?eXpNSEFKa3NvbWEzcldNR29BSHErdVV0YU9vVERLVjVnNFZzYkpZK3FWb0Jt?=
 =?utf-8?B?ek5FOVA1SmtGN3ZYS0dkOHI5eWpkdDlVNlRXTGYwWmxDQUJZaXp1TFFiMGo4?=
 =?utf-8?B?RU42OHNxejUxaDRiWGtLZ3BFb0tIbWRJSEFnVjByN0I4ZEpDUEVKOGltQU9o?=
 =?utf-8?B?WUNrWGVjKzBybm1qbjExV3NINFBabGttY2tKRUNTckFnQTkxWnExZUdIck04?=
 =?utf-8?B?VWRLb1BmbkRjeVVFQXRGYkVucE9PdC8wNzR4RnlMclQ4WGFDVGpqWVZlaVNP?=
 =?utf-8?B?OW1yaW1Oc2ZIVEZ1blBRaVJ4R1RhdTFUT1RycGFlZHUwbXJkdEZ0N1ByRXRH?=
 =?utf-8?B?Q2ZUb3hlbXIzekZiOWJBbUxLc1laaS9DQUF1cXY1YUtoTVdaQU1pcTgvb2FK?=
 =?utf-8?B?S3c0T0hieTNBbkFoZkJqaXhqcWd0NUwrNVZndDlKbVJwU01UOTVwMzNNbGha?=
 =?utf-8?B?Ym1RZXZUYVVnNG45cW9DMWpZS1kxcU9WNHhLQkkzTWIza0FVWjhwMTNCQkZW?=
 =?utf-8?B?amlWb0c4NnZaSjB4TGZSc0p5TkpqbHNjSGdENjNJZGlrSDYrWFBsekZ1K2tu?=
 =?utf-8?B?VUNKTUpnMzRsQlQzN0NJQUNsbTZvSW9MUExoSTBZUVRNaFVFUlZGL1IvWEpz?=
 =?utf-8?B?eUpEeUhXSkJGMThWejdZZVdUNW9BeVdDVGxUZHVCM1QvSjRPd05WS0xIVFd3?=
 =?utf-8?B?ZStPcFR2WEJoRCtpaDh0amlQdkV5aXltMS91UENpM0E2VUkyVTZ6aGNOb3kz?=
 =?utf-8?B?T0kxeUNDTVZ1eVhuMWNXZ0IvWFM4bGd5Uklnd2NDNGI1NmVrYlJ5OUJQRHlW?=
 =?utf-8?B?V1FEd0RMOUJvYm5HYUQ1VENIN2pWSHlZblJPVHhsZktOMmhZS0J4dUphc2JZ?=
 =?utf-8?B?UHVnMFh4VFRYK1ZiNFFYNlRCcEl4TC9xYWxlRE10VWU3OWJ0Q3VBU0dkdUdm?=
 =?utf-8?B?bUZCeUJITXcrRTRtbWdtbENDaXVHeHd3NjI0dzM3MkdoVnZuMnI1SDVvN2FU?=
 =?utf-8?B?V3BFc280RFNZOWYwZnBTczFQTGVwVXhPaStNWkRuTU5DOVhGUjZhd3RpTlU4?=
 =?utf-8?Q?vIFElx+gQhMmWxKyHfcboKCzYpaKpE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WC9RQnBIUmovbnRJeGE4eEhjUXRyWWhGRHFEYkpoWkxqV2IvckV4UmROd1Z5?=
 =?utf-8?B?QVhLdzIyWCs0SWgvQ2pWSFpOVDY4d3ErcVFESjdIZUFEK0JlMXpxYW1pTlFW?=
 =?utf-8?B?eGJsdUxWTlZzZkxvdk94TFVUMXpzYVVjYWhXRFppcW5oSm9WdG5qNndKTENM?=
 =?utf-8?B?Y2ZXWVA3Q3U0cUFuSm01UlB5ZDdjYkQvOGptVkhxbzlOV0tEejl4Z2NaVG1o?=
 =?utf-8?B?NGtrOVNwbjZLdFVjNU1Id3JiSk9EK0tuQWtwanBJQkRORnNBMmhWN3QxN0Jl?=
 =?utf-8?B?THd0Y2lYY2dLaEI5a3lPdmVtNWtqRTNPem80em9sZjgrUE5xVmtHT085OWRw?=
 =?utf-8?B?bUtNdFFreFVENzQ0NCt2Yng2Mm5lb05DT1VwdTFtWEZFTTFFSlBnZVBWbmVr?=
 =?utf-8?B?YVl1TnNLZkZhUFgvM0xIa3FkZG91VXE3VCtvcTVLZGFRL0FIYW9XWFBsb05s?=
 =?utf-8?B?WHhuaU5McjcxNmJUeHhoWU5uRjhOYWMwVUdBWVVVY29SUjRxdW5pQmovQ2ZL?=
 =?utf-8?B?WUVEUkRWd0wxajB1L3JvMExVeko0cHRpeitBVnh3N1o4QXFtVWNITWtvWmc0?=
 =?utf-8?B?dDRidzNrNng0cGFORGhFd1c1WkhaemlNenFLZTdaUEhJamZUVUxmWHg2aTdI?=
 =?utf-8?B?eHk4UjVZSS9EQm1IdXllclkrV21rTUZ3Z2RqeUFiWEh5em5vQm13d0NPdGx6?=
 =?utf-8?B?Wkc5T0hPSWNrNXNFT1VrN1N3QWJ6a2pmMldSU3c2em1uc3BSQmZaZDlRRjFU?=
 =?utf-8?B?ck5iYjIzck5HY3pPVmNYQXdPQWc4Qm5MVGxvV1pyMEFlVllHZUhDMjJnakZm?=
 =?utf-8?B?VkUvdmxiMk5SVWl5TXpUY2VXSFZEZFFPMEpTcno0Wjl2czVzMitNL1hCb1I0?=
 =?utf-8?B?TFhhcy82U3lScmM0THJCbExjNUx3SlhpNVdzL0JFRUxzVTQ3a3Q0QmR1MVZh?=
 =?utf-8?B?RzFRR1p3UGNCV2NwZXVwWUpSb29ETDUwWWpkUWVvUWxWQnBLSXUwbnJ0YTZC?=
 =?utf-8?B?dklUYWd0TWVGVStRdEtxQVBqYTBObCtNS2o5Z0NybEYwcUx1cC9iWG1wVit2?=
 =?utf-8?B?NmNZc2dCT2h3cDF5ZCt0NGs2VDl4RFh0M1hVMHJRaUcvbmZvOFRoSmdYaGl5?=
 =?utf-8?B?QWFUa25vNHV3NEpwT3BNNnZoZCt4bDQ1bUt5MDY5VzErNlk4SjBFKzZSbEZv?=
 =?utf-8?B?bkpEUHg1bDRUd0hCeGFtS3E2Wmp4TGhrTHhRUVpYVDdNZVMxRnJqa1E1UHMv?=
 =?utf-8?B?MGJlbFBtYWpxdkZtUVM5b1NQK0ltYXVzRFVDNEZnMGVmUElmdWlFM2toRThx?=
 =?utf-8?B?bWNzN1VpdVNMSWw5dVMxTkFPamlINTFpNVFqMWdNdzU0cnp4d20zWk1ISnkw?=
 =?utf-8?B?RFBYTEVDaHNJaTZzREFBd1l5emFsbEJWRW1yemRXWkFONEd4b2o1MndoeEND?=
 =?utf-8?B?S3pEbjRWS0dkOHpZR0FJQ3c0aUlvQ28rQ1M0NHQ1RSs4Z1FZeGFaOW8vb0l6?=
 =?utf-8?B?MTRRZ0VmZDhaeXI1RVBRYjdSNnBlMDJUWm5MQlVxeVBQYkhwQ0czR2ZNUzRs?=
 =?utf-8?B?T3dwYjlQWDh2dUczb01FTGEvSVM2ZkY1bTNiamRNdGN3NG1jL1FSNHJ6Y2xK?=
 =?utf-8?B?RFZwU1Z5NzdEU3FrTFlubnFtQnRrM3p2UzZVdVdKVmNzQnJDeGdNZ203cEh5?=
 =?utf-8?B?eGNHZ0VyK3hDd3BsZ2dVRk45S0JwZGxzV0NrTU9iZGFXK3A4ZTVVeE0rODVz?=
 =?utf-8?B?K0YrZnJiNVU3Wi9lcVVabFRiRnRCNUlDakNKbnh2ajc1VVJNcTI1NTJtVmJX?=
 =?utf-8?B?ZXVwNjNuakZYRlFuZjBNSWxYUVdMU3JhQ0FZYXZtQWFMWU5vK1lVV25FTmlM?=
 =?utf-8?B?RFQ0dHZ0WUVDZ2s3UjVZcmdCbXNpY1Q4ckdFYVpoUjhselJOWjBEMDA4TDlx?=
 =?utf-8?B?RmlzT2R6YS9tZ2RkSVJLa0pXaWV6dXFoUVhBSFk5L1VPOWpZd3VkcXNKYzI0?=
 =?utf-8?B?eFpqZS9aM2pFY2NQMi9UNWJJa2sySEozM3V5YTVtQU9mZm1vZ05lUHY2MEhS?=
 =?utf-8?B?bEN4TjhYOUZqSUdYNk1vUXI5eE50cm9sSEVTUVBPM3RCZWRNMmRmSDA3SW9s?=
 =?utf-8?Q?janw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0859e0a3-3e68-478c-13b6-08ddd8c30b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 10:37:17.8282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRiXwoXT1Otxoww+XIcTtdviVxsb/nzztMgV5weu5aRUs0rViFGcb7YUhZ/r4MshJKv+fWmyvc5SIsjBZ0e++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
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

W1B1YmxpY10NCg0KSGkgU3RlcGVoZW4sDQoNClRoYW5rIHlvdSBmb3Igc2hhcmluZw0KDQpTbmlw
cGVkDQoNCj4NCj4NCj4gT24gRnJpLCAgOCBBdWcgMjAyNSAwNzo0OTowOSAtMDQwMA0KPiBLaGFk
ZW0gVWxsYWggPDE0cHdjc2UxMjI0QHVldHBlc2hhd2FyLmVkdS5waz4gd3JvdGU6DQo+DQo+ID4g
VGhlIGNyYXNoZXMgYXJlIG9uIDIyLjExLCAyMy4wMywgMjQuMTEsIGl0IGlzIG9uIGFsbCBkcGRr
IHN0YWJsZSB2ZXJzaW9ucyBhbmQgMjUuMDcNCj4gYXMgd2VsbC4NCj4gPiBQbGVhc2UgZmlyc3Qg
Y2xvc2UgcHJpbWFyeSB0ZXN0cG1kIGJlZm9yZSBzZWNvbmRhcnkgdGVzdHBtZA0KPiA+IGFwcGxp
Y2F0aW9uIGFuZCB0cnkgdG8gY2xvc2Ugc2Vjb25kYXJ5IG9yIGV4ZWN1dGUgYW55IG9mIHRoZSBm
b2xsb3dpbmcNCj4gPiBjb21tYW5kcywNCj4gPg0KPiA+ICJzaG93IGRldmljZSBpbmZvIGFsbA0K
PiA+IHNob3cgcG9ydCBzdGF0cyBhbGwNCj4gPiBzaG93IHBvcnQgeHN0YXRzIGFsbA0KPiA+IHNl
dCBmd2Qgcnhvbmx5DQo+ID4gc2V0IGZ3ZCB0eG9ubHkNCj4gPiBzdGFydA0KPiA+IGV0YyINCj4g
Pg0KPiA+IFdlIGFyZSBhbGwgYWdyZWUgdGhhdCB0aGVzZSBjcmFzaGVzIGV4aXN0cy4gRmlyc3Qg
d2Ugd2VyZSB0cmllZCB0bw0KPiA+IHByZXZlbnQgdGhlIGNyYXNoZXMgYXQgUE1EIGxldmVsLCBi
dXQgaXQgd2FzIG5vdCBwb3NzaWJsZSB0byBhZGQNCj4gPiBjaGVja3MgaW4gZWFjaCBQTUQuIFRo
ZW4gd2UgdHJpZWQgdG8gYWRkIHNhZmV0eSBjaGVja3MgaW4gZXRoZGV2DQo+ID4gbGF5ZXIsIGFu
ZCBpdCB3YXMgbm90IHN1aXRhYmxlIGFzIHdpdGggcHJpbWFyeSBjbG9zaW5nIGFsbCByZWZlcmVu
Y2UNCj4gPiB0byBkZXZpY2UgaW5mb3JtYXRpb24gKHBvaW50ZXJzKSB3b3VsZCBsZWFkIGNyYXNo
ZXMuDQo+ID4NCj4gPiBUaGVuIHdlIGFncmVlZCBvbiBzZWNvbmRhcnkgcHJvY2VzcyBtb25pdG9y
aW5nIGZvciBwcmltYXJ5IHByb2Nlc3MgZXhpdGluZy4NCj4gPiBhbmQgaXQgaXMgbm93IHJlc29s
dmVkIG9uIGFwcGxpY2F0aW9uIGxldmVsLCBpLmUuIG9uIHRlc3RwbWQuDQo+ID4NCj4gPiBOb3cs
IHRoaXMgc29sdXRpb24gaXMgd29ya2luZyBwZXJmZWN0bHkuIFdlIGNhbiBhZGQgZWFsX2NsZWFu
dXAgZm9yDQo+ID4gZ3JhY2VmdWxsIGV4aXQuDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4g
S2hhZGVtDQo+DQo+IE1heWJlIHRoaXMgcXVpY2sgcGljdHVyZSB3b3VsZCBoZWxwIGV4cGxhaW4g
dGhlIGRhdGEgc3RydWN0dXJlcw0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
4pSCDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIIgICAgICAgICAgICBIdWdl
IHBhZ2VzIChzaGFyZWQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIINCj4g
ICAgICAgICAgICAgcnRlX2V0aF9kZXZpY2VzW10gIOKUgg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAg4pSCDQo+ICAgICAgICAgICAgICDilIzilIDilIDilIDilIDilIDilIDilIDi
lIDilJAgICAgICAgIOKUgg0KPiBQcmltYXJ5ICAgICAg4pSCICAgICAgICDilLzilIDilIDilIDi
lIDilIDilIDilIDilIDilLzilIDilIDilIDilJANCj4gUHJvY2VzcyAgICAgIOKUgiAgICAgICAg
4pSCICAgICAgICDilIIgICDilIINCj4gICAgICAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUkCAgICAgICAg4pSCICAg4pSCDQo+ICAgICAgICAgICAgICDilIIgICAgICAgIOKU
vOKUgOKUgOKUgOKUgOKUkCAgIOKUgiAgIOKUgg0KPiAgICAgICAgICAgICAg4pSCICAgICAgICDi
lIIgICAg4pSCICAg4pSCICAg4pSCICAgICAgICAgICAgICBydGVfZXRoX2Rldl9kYXRhDQo+ICAg
ICAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilJggICAg4pSCICAg4pSCICAg
4pSCICAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSQDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgIOKUgiAg
IOKUgiAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAg4pSCDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIOKUgiAgIOKUgiAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKWuuKUgiAgICAgICAgICAgICAgICAg4pSCDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUgiAgIOKUgiAgICAgICAgICAgICAgICDilIIgICAgICAgICAgICAgIOKUgOKUgOKUgOKU
vOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKWug0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDilIIgICDilIIgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKWuiAgICAgICAgICAgICAgICAg4pSCDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKU
giAgIOKUgiAgICAgICAg4pSCICAgICAgIOKUgiAgICAgICAgICAgICAgICAg4pSCDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIOKUgiAgIOKUgiAgICAgICAg4pSCICAgICAgIOKUlOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICDilIIgICDilIIgICAgICAgIOKUgg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDilIIgICDilIIgICAgICAgIOKUgiAgICAgICDilIzilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJANCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAg4pSCICAg4pSCICAgICAgICDilIIgICAgICAg4pSCICAgICAgICAg
ICAgICAgICDilIINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSU4pSA4pSA4pSA4pS8
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pa6ICAgICAg
ICAgICAgICAgICDilIINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAg
ICAg4pSCICAgICAgIOKUgiAgICAgICAgICAgIOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKWug0KPiAgICAgICAgICAgICBydGVfZXRoX2Rldmlj
ZXMgICAg4pSCICAgICAgICDilIIgIOKUjOKUgOKUgOKUgOKUgOKWuiAgICAgICAgICAgICAgICAg
4pSCDQo+ICAgU2Vjb25kYXJ5IOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgICAgICAg
IOKUgiAgICAgICAg4pSCICDilIIgICAg4pSCICAgICAgICAgICAgICAgICDilIINCj4gICBQcm9j
ZXNzICAg4pSCICAgICAgICDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDi
lIDilIDilIDilIDilIDilIDilJggIOKUgg0KPiDilJTilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilJgNCj4gICAgICAgICAgICAg4pSCICAgICAgICDi
lIIgICAgICAgICDilIIgICAgICAgICAgIOKUgg0KPiAgICAgICAgICAgICDilIzilIDilIDilIDi
lIDilIDilIDilIDilIDilJAgICAgICAgICDilIIgICAgICAgICAgIOKUgg0KPiAgICAgICAgICAg
ICDilIIgICAgICAgIOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiAgICAgICAgICAgICDilIIgICAgICAgIOKUgiAg
ICAgICAgIOKUgg0KPiAgICAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilJgg
ICAgICAgICDilIINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgg0KDQpEZWZp
bml0ZWx5IHNvbWV0aGluZyBpbiB3YXkgYHJ0ZV9ldGhfRGV2X2RhdGFgIGlzIGNoYW5nZWQgaW4g
c29tZSByZWxlYXNlLg0KRWFybGllciB3aGVuIHNlY29uZGFyeSBjb21lcyB1cCwgdGhlIG1lbW9y
eSBzaGFyZWQgZm9yIHJ0ZV9ldGhfZGV2X2RhdGEgd2VyZSBwcm9iZWQgYnkgc2Vjb25kYXJ5IHRv
IGdldCBwaHlzaWNhbCBkZXZpY2UgaW50byBsb2NhbCBtZW1vcnkuIFRoZW4gYWxsIHZpcnR1YWwg
ZGV2aWNlcyB1bmRlciBzZWNvbmRhcnkgd2VyZSBhZGRlZC4NCg0KSGVuY2UgYWRkaW5nIHBoeXNp
Y2FsIG9yIHZpcnR1YWwgZGV2aWNlIGluIHByaW1hcnkgZGlkIG5vdCByZWZsZWN0IGJhY2sgdG8g
c2Vjb25kYXJ5IGFmdGVyIHJ0ZV9lYWxfaW50aSBjb21wbGV0ZWQgYnkgc2Vjb25kYXJ5Lg0KSSBh
bSBzdGlsbCB0cnlpbmcgdG8gZmlndXJlIG91dCB3aHkgQEtoYWRlbSBVbGxhaCBtZW50aW9uZWQN
Cg0KYGBgDQpQbGVhc2UgZmlyc3QgY2xvc2UgcHJpbWFyeSB0ZXN0cG1kIGJlZm9yZSBzZWNvbmRh
cnkgdGVzdHBtZCBhcHBsaWNhdGlvbiBhbmQgdHJ5IHRvIGNsb3NlIHNlY29uZGFyeSBvciBleGVj
dXRlIGFueSBvZiB0aGUgZm9sbG93aW5nIGNvbW1hbmRzLA0KDQoic2hvdyBkZXZpY2UgaW5mbyBh
bGwNCnNob3cgcG9ydCBzdGF0cyBhbGwNCnNob3cgcG9ydCB4c3RhdHMgYWxsDQpzZXQgZndkIHJ4
b25seQ0Kc2V0IGZ3ZCB0eG9ubHkNCnN0YXJ0DQpldGMiDQpgYGANCg0KYEkgdGhpbmsgdGhlIHJl
YXNvbiBpcyBiZWNhdXNlLCBpbiBhbGwgdGhlIHRlc3Rpbmcgd2UgdXNlIFNJR0tJTEwgdG8ga2ls
bCB0aGUgcHJpbWFyeSwgYW5kIG5vdCBjbG9zZSBvciBzaHV0ZG93biB3aGljaCB3aWxsIHRyaWdn
ZXIgdGhlIGNsZWFudXAuDQpUaGUgdGh1bWIgcnVsZSBvciB1bmRlcnN0YW5kaW5nLCBpZiB5b3Ug
YXJlIHNodXR0aW5nIGRvd24gcHJpbWFyeSBhbHdheXMgc2h1dCBkb3duIHNlY29uZGFyaWVzIGZp
cnN0LmANCg0KQEtoYWRlbSBVbGxhaCBJIGFtIG9wZW4gdG8gYmUgYXZhaWxhYmxlIHRvIHNsYWNr
IGZvciB5b3Ugd2hlcmUgeW91IGNhbiByZWNyZWF0ZSB0aGUgaXNzdWUgKGFzIHlvdSBoYXZlIHdv
cmtpbmcgc2V0dXApIHdpdGggdGhlIHZlcnNpb24gZGVwbG95ZWQuDQpQbGVhc2UgZG8gbGV0IG1l
IGtub3cuDQoNClJlZ2FyZHMNClZpcGluIFZhcmdoZXNlDQo=
