Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69BC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 06:59:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CBD14013F;
	Thu, 22 Jan 2026 07:59:51 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11]) by mails.dpdk.org (Postfix) with ESMTP id 81673400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 07:59:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XouMowPnlp5U56FE8FfJ/GFngVWxi5PmTW0BnAu9oPzg/mnUpWSsvK/FM1gsEp9pEoeLtv9jSvGfS4qSs9PWVX5C/clmdWZr/wGhixbn28YWaapk/XHo8duGrPn7yTjNJLI6LM1OmWjRiVg6TTrPrwQCc9uo/fB4NxNGtlGIP2ZsXUpzFtA6UloF1eoCXh1C31RhurEYsI3+XT2doWExBJtRU1SnQnKHCTfCxo/Cgsnek4o9p5zyFJQBP4Sa/pV+wAXHgakvBxnSwvVlIah3flb8wNN7pTxu4X6FpOWjjXrIM+Uky+M1AOrbEyJ5ZTmVGXVx22nLlUNDLnGiikBdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VeqQdA2q6h7My6hVUtdRZ2YXdO1Yc/qwfeyjHgJJyA=;
 b=iXPJf89WXb6IGthZV51UWl30l/tWUuuNYn9zWmOYcUE23iWI3a7YSenEX6Rz6BavryOPxs+klfNud4nvsN4TsalLIhbER2SSWIVihmA+TjU/3oJmc8eo/Tz+1RTqH2Y44GVsAFhUzzj/ThbyjTYTaRWc+bxm1jQx0GeY0TjcwwJfvhFLBjPZWmP+hGD28o5JAMJhMH2RiHYEZk4VoqFMYl2LATJ1YVKouy5Kn1B1CoDA2ltzWS4VNKkaX66ZhwnbpOBA/mOFc4rXk49me5jKZDCRwQez6wewbBGJKWWZcJ2lLBubkS2CEk658CxAlCcPLlY62s84lt//yASM5UKfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VeqQdA2q6h7My6hVUtdRZ2YXdO1Yc/qwfeyjHgJJyA=;
 b=3UVta+7tdpeEkmiqST8edbMDcFRaMLcvHu8I/Y6blwADMKr+IzM3IpOrYX8wj1PQeaAS90vXyijMmXLrN3awoOtZc4VCuklKCzOFNAPM4qIZpZui2t6ZvZZwuEWAIbhTVlKSW2gyV19PERVjRhQOPnl4+rw9tHdxeui7N1iz3+4=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 06:59:46 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 06:59:45 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Stephen
 Hemminger <stephen@networkplumber.org>, "P, Thiyagarajan"
 <Thiyagarajan.P@amd.com>, "Murali Krishna, Bala" <Bala.MuraliKrishna@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcg7uDLBHaOyG5bUy6tdTsisR14rVQvruAgAouhgCAAAgkMIAAAOaggAGXv9CAASlJcA==
Date: Thu, 22 Jan 2026 06:59:45 +0000
Message-ID: <PH7PR12MB85961D3A7388DF0C0445915A8297A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260112120337.277331-1-mb@smartsharesystems.com>
 <20260113151943.31c58217@phoenix.local>
 <PH7PR12MB8596A21E5892BABF88665C5B8289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB8596F1FE29BA757F8884E7A98289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65677@smartserver.smartshare.dk>
 <PH7PR12MB8596838852258FB94342042A8296A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8596838852258FB94342042A8296A@PH7PR12MB8596.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: mb@smartsharesystems.com, Thiyagarajan.P@amd.com,
 Bala.MuraliKrishna@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-21T11:40:43.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|MN2PR12MB4341:EE_
x-ms-office365-filtering-correlation-id: 9429e3b8-8a9a-404a-c647-08de5983d39b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QTRyWUlrT0xQVDZMZFFJK3F5SWJYWGdpYjZOSlUyV0VmMzBEQWppWlpMQmo2?=
 =?utf-8?B?a0hNcnNWNmVuSTR6d3pZcC9JYU5PVlR4dFNPY3hTNDh6RWRSdEhEbTc3b0hD?=
 =?utf-8?B?VUxwTEVmS2JZTHd5NU5oTzdNSEp5Qm9SR3ZhVVVzNE1XYmZrZkVUSXpaMlM5?=
 =?utf-8?B?em1hWWVyVU5iZlI5aUorNkpXczZpb0xQVGc1dlFZbGlMQnVYQWhkYzFMYWdV?=
 =?utf-8?B?OW9UclJ6STA2Um92T3ljNGNUYVJpa0JwSE95aXROUVJGa3Q3V0lIZWVGVnpM?=
 =?utf-8?B?UEFCTjMrWE0yaFVLNkNCbHozdGRmUjF3NUYzSVpvNnlOb3ZiOWN5UFZiWHNa?=
 =?utf-8?B?K1NReFNGdXJ5RmZTeWpFam5qQU50cUlHYTBrN2hRUnVPdUdTajhHUHVlS0dT?=
 =?utf-8?B?cjhaSUNSQUQ1RDlPRTZBaEFxOXRzT2xQSzE4WllyUmRlQS8zWFlWcjdRK0xa?=
 =?utf-8?B?TWhlekM4ZVpZOXdKUzlIMzlJemZUalowa2tKQS8wOW9naHFPZGdMMGJCc0tH?=
 =?utf-8?B?UkppM3Q3dDdjMkVadmdtbWo3ZGJ3Smt0L3N2RTdCdUR2QURsdnJlbEk3Skwv?=
 =?utf-8?B?Rk8vYk5jRldLeW1aNEhEaEdlSDBRSVZ4a0dCeSt5dTdIYUtObC9JOURkbk1L?=
 =?utf-8?B?OWcwT2ZSWW9XQkhiYjk1ZG9jdG4yT1RyRUxUMmtVQWhKVm1IbUpVeldtWmpz?=
 =?utf-8?B?enhYMmFKS1N6KzFiOFNMYnd4b1ZEYVpZUnhzaHA2aGgybjJ6S3JpeVBxT0Vr?=
 =?utf-8?B?WjZLcDdxSm9aVmxlTGppY3hPVlJwaURvTTN0UGRnNjQ5VlhlcFczcEdDV0lW?=
 =?utf-8?B?MWk0YkZpcjl4ZVcvZVA4ektHUWdBTmFhM1lsK3JDbTNKbUozN3o0NGU4MWhq?=
 =?utf-8?B?WGdlYStDTjdTazJXcGdrWmdTblpySlEwSGxaZUR6Vm5MeWc4Q1ZhVVN6ZVdT?=
 =?utf-8?B?VDlzY3FZZ1VhLytoK01NQlhGVEdDNGlMcSs4Tm4zMEc5c2VEZVN2dDVjcFpL?=
 =?utf-8?B?WEpGcEZ0cmNEUHRaMTV4U2czbERQYjZzdzRVeW9ORm5KNEdvdm5zOGFna0Rj?=
 =?utf-8?B?NnlJU2tNdjI0MmRSREJ1YnFZYkFFTjVSSkszTkFhNVA1NG41M0ZnQkpQZGpR?=
 =?utf-8?B?bjQ5dXFLdVFINHF1WkFiWEwvbzYySHgzYjl5em9zaEZtVXNSS3kvSFZ1bUNa?=
 =?utf-8?B?TmtrWTFHL1lzc3B1cm1IRzA5TkN3Zm04elBvWDUvZFB3N2xFQXowU2MxbEdD?=
 =?utf-8?B?dlVFbnZzMWFKR0xNUEk1dWdaaHFKaVdoS1g4RUo3MkRScEtQQUs2K1NFL3Ju?=
 =?utf-8?B?RnZWbExuT1RCTDNwbkdmTEZwL2R0QUUrdnpucWNFZXAvbmc3ZWd1bWFaVTJy?=
 =?utf-8?B?RzVoQVVDb3hxWjVuWG5ocHlMRXpzdmswNlpNbExWQXhYYTJlMDhBVDBiRU9F?=
 =?utf-8?B?bXRYRmpXZVY1ZmI3MGF4a3ZiYkxqc1drcmxybE9tVFdzeTVwVS94aStlZE5K?=
 =?utf-8?B?UmdZem5xWit4S3Y3MmZwTEhKemVhRG1KVk94eTN1S2s4VXNEMnp0Wm96NXRH?=
 =?utf-8?B?MmI5S283V2VpTm1yeUZxVnZnUUdwZzY3ZjJGNnVjUDV3MTV6OUFpOUhWQ05G?=
 =?utf-8?B?cUcxMENtZEhLSUJvSWt6QWRpd0l0d1dIMkI2aDB5bFBCdjBGLzVmeTNpTGYr?=
 =?utf-8?B?Q2pGMlJXSGNhL2dHU1VpelpsN0VVQldPOGNTQkZqT0xIa3hyQ0FyZmtIclo0?=
 =?utf-8?B?RnlIMnpNWVJhTmkxYUE5dHQ4bDVYUS8zc0lHUHVZazgvWHc4WkhnNUhmUjhG?=
 =?utf-8?B?VGFpU3dmbTVIdlVZNUdrM294a0dIME1taGxlZk0rQjdQOUEvRElEWEhUaHFq?=
 =?utf-8?B?V1lzNHF3QldFMmVjY2d2MHBhdDA3QUhuTUJVcTlUZmZrR1N5R000UUNiUGVG?=
 =?utf-8?B?QVZOeGtYeTU2WlNaV3JHcU81enJNbUVFbGlKVjNMSGJnQXpUUDNrTGkrVTJN?=
 =?utf-8?B?S1R1VUZ2UmlRQ3g3enA2OHVOZUFSNys0cnhtR3lWNElpV3JTdEdMT3U4R3JS?=
 =?utf-8?B?QTd0UkFJQlI2anpKV1M3alJXNkpBdFZZaWZBSWZsb21iY3pIcFR5MkJhUmxE?=
 =?utf-8?B?T1daKyt3N0M1TWJrTEl1NDYxRm55U25ZQzRqYzM2azhlSC9wSVhvdWg3S2Nu?=
 =?utf-8?Q?UX2bf4z71bzW0puDY5SHx5A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFNwdithbnREZXovcy9Dc3k4TUtQaTQ0Y3U2d2VDTDlwTFdkQmtHakF2TGh3?=
 =?utf-8?B?QURhUFJrSDYvN3NsSFdReHEwSWFDTVdtd2pZblBQNG01NXhBOWtiYXlzV0xj?=
 =?utf-8?B?dngzT2RFZ29aYWFhVnVnUXJjdmdSaXkvNHVIVUNudllyMGlWVXBvWHZ0bi9y?=
 =?utf-8?B?NEcvV2l1WFROcmVKS0cvc0ZDZlRTRmZjUmUwaHdHYUVLdFlrUWNxOTVYKzZm?=
 =?utf-8?B?cTRtd0dIT1lXNmJidGlORVQ5ZzB3ekpnUGJhb0EvdHdCMnJnQkkwVGtpOUZ6?=
 =?utf-8?B?WU5Sb0dQck85ejl0MWNaZzVRQ3NwanZVQXBWVXdtWnlKVWdCWWpyS0kwMTg4?=
 =?utf-8?B?eVFoRGxLWk9ybzhMaE9VVDk5WW0yWGNyZUtkbm1FT2Jkenk0NW9xSTR4dFl6?=
 =?utf-8?B?cU1UWVBEUThKaFFSbk0zMDhEakdHR3JlVWdpaWVrR2FubTh6Vkp2bmY5NHds?=
 =?utf-8?B?K1JabnM2YzhSbFRKUWJQbUxZYkdWdlFycGlMQUtEbnFtclY4ckZ1bkJlUnE2?=
 =?utf-8?B?VXorMTBKWE1mTityMTNHYUdRWi96TWlTekNVTXlSQitYMmFtbms1Y3hYeVJq?=
 =?utf-8?B?dTVZRTE2R2kyUm5Wd3ZZcEYzVk1CUExnNjJCWGVvTE5sTjlzWEt1dmF3VS9r?=
 =?utf-8?B?eTVHanNHWHVBSkdXQXM0VDVLOGkwRDFiNFYrK205N3lXSWFjUDhWRUZsR09F?=
 =?utf-8?B?VkxsMnFqREtqd2RobHFYb01QRk5PaUtEZkdSSzZWSWN6Q3FYSzlicjRwek5K?=
 =?utf-8?B?NTRFR09IQUwxQlZjRHdnd2piekQwVWlqNFpxRUlDY0Zab0cxSHBkNk1zelA4?=
 =?utf-8?B?N3BGelNFbWEzUHRWVDRhaTFGMTA1SFYzSXVNdnArVE8zdytuY1p4QTBWcGVG?=
 =?utf-8?B?WjBtVW0yQ3kyc0ZkTFZId1BNRHhIeEtHdC9NNWNHQTRndmllNmpRdWhNWmNU?=
 =?utf-8?B?ODBOZy9abkZuUUgxWmt1aGxLclhpa1ZzSFk4T1AvM2ZrNEJYR213NzRSWkNZ?=
 =?utf-8?B?SXZPM0hJVHUxZGdUbVJwV2RSTDJOM3FBMS93YTByTElvRkRnUUlwWHExR3M3?=
 =?utf-8?B?VVpCaGFuRFlyRlpmVnB4bkxTYkcvSjhESUtoNlU3N2pRK2lEaUxaSVdlRyt6?=
 =?utf-8?B?U3lWQ2dXeFJVcEdhS0lsUnAyLzZyRGxCa3NvWmdCUStrWXc5WGd0VXAvMmVr?=
 =?utf-8?B?OFlGTTM0aURkcVcrSEN3dkgvK21jcEIvOTluUTgrZEJsc3k0ZmRxYUFZY1la?=
 =?utf-8?B?dHpKVlhaVHhOaC9YVUE2RVBQb3RoU21FaHJIc29QcjJneng5Rjl0dFh4YXVj?=
 =?utf-8?B?VWxvNlVtd1ErSGh1azRUZ3ZBZzdjZ1g0TWxSQjM2ZlpESi81NGQ5K0pBOTJC?=
 =?utf-8?B?ZVRtMXQ3Wm1maVlTSndjYStaSW10bmNBdStGSGh0WlNSMy9WMlFNTmdpcXc4?=
 =?utf-8?B?dHVlTWsybnpLNUN2UDUwdk5zRWhJTjFzTG5NNWxpOUxYY3ZNancrMHVlSzM3?=
 =?utf-8?B?M2Z2elRsWXhuOFI4YXJSN0VBcUdwT1FpalZ2YTdJTmFRNVpSM3B0MTgwcFM4?=
 =?utf-8?B?cGNQa2o2cTdpTWZxMUp4U1ZwbDF2YnBYZ2tmV2puYjdUVkVGWHo5dGxwRjlX?=
 =?utf-8?B?V0h3VThVU3REdXZaOG5iRW5CS3VGaFNTNkRVYm1kYWtRSnhiRWIyb284Z0xT?=
 =?utf-8?B?cGJEdFk3QXd2bzBMUnd4a1Q3SWxjSnJrU2dmUmpkaXpDR1dhb1lUVTJ5SDl4?=
 =?utf-8?B?cFNlZm0xOWpXRHBqY0xEb2JabnVtU21QUDEwUHM5dm1EMlpaSmxET1hoVjcw?=
 =?utf-8?B?cFQ1NS9yRTRDLzRWVFhCamxoRFhjN2NSM2x3RjZKN0lqUGx4WWF0cXQ1U0JE?=
 =?utf-8?B?dE9PWlZkYnN1b3VUanUwMi91YmJpdlU3YzI3VE42ZXloS2JkWndoYUo0NFF4?=
 =?utf-8?B?QzZLWDZ2SW9SZzNYbmFraCswZ2F0RjZSZFFRbTFPMzlrM1BxQ1FHMFluSGEx?=
 =?utf-8?B?aEN5UTJwRGNmN040Q1dBYUlubllvV0RsaUtSZEI1K0VDOU1YdFNqZWw2NU5Z?=
 =?utf-8?B?ZTJIZlhTZ1gzN2ZoSkQzYy9LR1BmZWxQN1Fad0U2bUhUZ0N0NlBSa3lrV1BW?=
 =?utf-8?B?eWdwY1VKQlFSN01HMkI1eTlLY3JHRUdKcG1zQWFERGd5NXVHQnpiY0RtcUdy?=
 =?utf-8?B?Ni93QkFaNHo2NytyM0kzaktHSllRWm1hZk9oUU9jblVnMms4bmlGemNNUHIw?=
 =?utf-8?B?Zkh5ekEvamxFeFBQWVJaZlUzRDM3d3RoWHAvdFRkNTRwZ1g2Tm13TG1UOXc2?=
 =?utf-8?Q?dITvvADxY2mYshRlfq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9429e3b8-8a9a-404a-c647-08de5983d39b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 06:59:45.8201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imvWTOa2El2DcK1xXlTEQwpq8ZrBnDaFNQnTXmbqogrbuXIhm3umV8ow7UtCNumJRjNb6FLuVKKYm0wOF3EvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

W1B1YmxpY10NCg0KSGkgQE1vcnRlbiBCcsO4cnVwLA0KDQpXZSAoQFAsIFRoaXlhZ2FyYWphbiBA
TXVyYWxpIEtyaXNobmEsIEJhbGEgYW5kIG15c2VsZikgaGF2ZSB1c2VkIGRtYS1wZXJmIHRvIHZh
bGlkYXRlIHRoZSBwZXJmb3JtYW5jZSBmcm9tIDFCIHRvIDE3QiBwYXlsb2FkLg0KRm9sbG93aW5n
IGFyZSBvdXIgb2JzZXJ2YXRpb25zDQoNCldpdGggY19hcmdzIGAtRFJURV9NRU1DUFlfQVZYNTEy
YCBlbmFibGVkIG9uIHplbjQsIHdlIG9ic2VydmUgYXJvdW5kIDI1JSBwZXJmb3JtYW5jZSByZWdy
ZXNzaW9uIGZvciBwYXlsb2FkIHNpemUgMUIgdG8gMTVCIGFuZCAxN0IuDQpXaGlsZSBpbiBjYXNl
IG9mIDE2QiB3ZSBzZWUgaW1wcm92ZW1lbnQgaW4gTW9wcyBieSA0MCUuDQoNCldpdGhvdXQgY19h
cmdzIGAtRFJURV9NRU1DUFlfQVZYNTEyYCBlbmFibGVkIG9uIHplbjQsIHdlIG9ic2VydmUgKy00
JSB2YXJpYXRpb24gZnJvbSAxQiB0byAxN0IuDQoNCmBXZSBhcmUgaW52ZXN0aWdhdGluZyB0aGUg
dmFyaWF0aW9uIGlzIG1vcmUgcHJvbWluZW50IHdpdGggYXZ4NTEyIG1lbWNweS5gDQoNCk5vdGU6
DQoxLiBpbiB6ZW40IGxkfHN0ciBpcyBicm9rZW4gdG8gMzJCLiBXaGlsZSBpbiB6ZW41IGxkfHN0
ciBpcyA2NEIuDQoyLiB3ZSB0ZXN0ZWQgbWVtaWYgY29weSBvbiB6ZW41IHdpdGggcGF0Y2ggKHdp
dGhvdXQgLURSVEVfTUVNQ1BZX0FWWDUxMikgb24gNjRCIGFuZCA2NUIgcGF5bG9hZC4gSXQgaXMg
c2FtZSBhcyB6ZW40IG9ic2VydmF0aW9uIChzaGFyZWQgaW4gcHJldmlvdXMgZW1haWwpLg0KDQoN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWYXJnaGVzZSwgVmlwaW4g
PFZpcGluLlZhcmdoZXNlQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyMSwg
MjAyNiA1OjE5IFBNDQo+IFRvOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tPjsgU3RlcGhlbiBIZW1taW5nZXINCj4gPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0K
PiBDYzogZGV2QGRwZGsub3JnOyBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGlu
dGVsLmNvbT47IEtvbnN0YW50aW4NCj4gQW5hbnlldiA8a29uc3RhbnRpbi52LmFuYW55ZXZAeWFu
ZGV4LnJ1Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY2XSBlYWwveDg2OiBvcHRpbWl6ZSBtZW1j
cHkgb2Ygc21hbGwgc2l6ZXMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQg
ZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5p
bmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBb
UHVibGljXQ0KPg0KPiBIaSBATW9ydGVuIEJyw7hydXAsIHBsZWFzZSBmaW5kIG91ciBvYnNlcnZh
dGlvbiBydW5uaW5nIHRlc3RwbWQgd2l0aCBtZW1pZiBpbg0KPiB6ZXJvLWNvcHkgbW9kZSBkaXNh
YmxlZCAocnRlX21lbWNweSBlbmFibGVkKS4NCj4NCj4gMS4gRFBESyBiYXNlbGluZSB2ZXJzaW9u
OiAyNS4xMSB3ZSB0ZXN0ZWQgd2l0aCB0ZXN0cG1kIGluIGlvICYgZmxvd2dlbiBtb2RlIDIuDQo+
IHVzaW5nIG5vIGNhcmdzIGZvciBtZW1jcHkgKHJ0ZW1vdjMyKSBhbmQgd2l0aCBwYXRjaCA2NEIg
JiA2NUIgd2UgZ2V0DQo+IGAxNS41TXBwc2AgMy4gdXNpbmcgY2FyZ3MgYCAtRFJURV9NRU1DUFlf
QVZYNTEyYCBmb3IgbWVtY3B5IChydGVtb3Y2NCkNCj4gYW5kIHdpdGggcGF0Y2ggNjRCICYgNjVC
IHdlIGdldCBgMTQuOE1wcHNgDQo+DQo+IFdlIHdpbGwgcnVuIHdpdGggZG1hLXBlcmYgYXBwbGlj
YXRpb24gZm9yIHBheWxvYWQgc2l6ZXMgb2YgMSwyLDMsNCw1LC4uLmV0Yw0KPg0KPiBSZWdhcmRz
DQo+IFZpcGluIFZhcmdoZXNlDQo=
