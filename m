Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645F0C282C6
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 08:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99EDE40280;
	Mon,  3 Mar 2025 09:59:05 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by mails.dpdk.org (Postfix) with ESMTP id 6BEC5400D7
 for <dev@dpdk.org>; Mon,  3 Mar 2025 09:59:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llDCHYikUftUsQWOJZF5+bV00UTkGW7bRH8i3hyZIin+Jp9iKUKR4D3GIHnmGTHLblJkytGYBV1lhaK3b/7OdXVfZ6X5KiyRFPPVxwuq2FKMjvk+lczZNnWHfYx/VrorDsQOnx3aga52BybrbtzofN0Fei8zdIwQfevpsUdOk01i6j9VC3f0hUam0BYfsAK9tMS0HpbPOrik44dZQGXcOzm+hr5IJQv/pGBXQmlIV7h6bza9FfouIGSXEf7xPBq1gEO/d58thP7OAHB3IPUKP2tgJQ+YCNs3CZ6aGE5QO69lonFSbBPeuV9GtAlE8BEX3nnTFRTWmEWsVCfndxFEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A9Q+QiAknY0M0/laLOwIL/bVwT/pNO2/CLc3HSEXxE=;
 b=ufGJrZBsUDrNU+SIdSRBmFFto5CtiwMLe0HHq6CJT6Gx7uUPKbNAgqUE6e9J15GsG94JHQpWcArQf3hW8jj/VWY2Jq2jy38xSRvBqM+uDR+LexSL6mr6KE2c6CXZMQkBl537m9kLqTYEUiFsep5JT8PCujBV7IItNvArCKH96TfHjvng5LWVyw7Z7CqlQiintN2JUOJuN+roOvR2KQ5IBUP8A2k4+0QHYCDcaKbWDejHQBj/E4dgzu5fT6APYExVlUPTqSjmzIVP3tazY1rlKTfTZLhEeSQV1A+Ix2rjp+d4JU4/dTeV99nGjDvMcYt6cnHTzojuml62fmCTVaoPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A9Q+QiAknY0M0/laLOwIL/bVwT/pNO2/CLc3HSEXxE=;
 b=5TPGbtELuyckxJwxlyuIeKDJVv40id5xDI1aKZPIvbJsyL57Pdvw+hIPP19RdH7O5BAJ1KVW0/nsq97r0qj2yS4BCqCIuk4nWspCBdJlJAdfh/lNomRt/61M68Tliq8PJQyxNnKEjisEEcwOkJTJv4pCtXyaQgJsMfMrYIfpsWk=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 08:59:02 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%6]) with mapi id 15.20.8489.021; Mon, 3 Mar 2025
 08:59:01 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "roretzla@linux.microsoft.com"
 <roretzla@linux.microsoft.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "john.mcnamara@intel.com"
 <john.mcnamara@intel.com>, "dmitry.kozliuk@gmail.com"
 <dmitry.kozliuk@gmail.com>, "Ajit Khaparde (ajit.khaparde@broadcom.com)"
 <ajit.khaparde@broadcom.com>, "Song, Keesang" <Keesang.Song@amd.com>,
 "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>, "ruifeng.wang@arm.com" <ruifeng.wang@arm.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "honnappa.nagarahalli@arm.com"
 <honnappa.nagarahalli@arm.com>, "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Topic: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Thread-Index: AQHbL22WzCqF9Lj5SUqurJMDjBRIs7NFKZjQgABbpICAHFCwwA==
Date: Mon, 3 Mar 2025 08:59:01 +0000
Message-ID: <PH7PR12MB85962518E0D8763C5EE8534682C92@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <PH7PR12MB85960CB35BB467CEBBC2CA2F82FF2@PH7PR12MB8596.namprd12.prod.outlook.com>
 <2097299.UkFFEUeh36@thomas>
In-Reply-To: <2097299.UkFFEUeh36@thomas>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cbd3a1f4-8cb5-4a86-ba25-338b73d8a01d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-03T08:58:24Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|MW3PR12MB4345:EE_
x-ms-office365-filtering-correlation-id: e4a00caa-a6fd-40d2-204c-08dd5a31a4a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MmVQTVRlZGN3YU9GMTlkWlVoUFhSanJQRnFrZjJWbkc4QUlldDJELytRRlIx?=
 =?utf-8?B?aTErR0FIdWZiQis5Y1pKRi85eWJhQnZFRzFyekhYajN3MjBHRXBvTDVPdUI5?=
 =?utf-8?B?NU94ZjV1cEN3NE5lR05aRC9TTDY1N3o4amVZQU1sYjF2Vmw4b3BZRjZ0M2FJ?=
 =?utf-8?B?U2NZTlhueXZwQ0twK0l6Z0dNSWRrVW1STU5RaUlIU2hMQldFMGVBMTM4N1U3?=
 =?utf-8?B?aUhXVW4zUTN1dXRHZVVjdXM3Rk5wVnJkRFhrZmhtWGRzUnlJVjNiTGFNdDNZ?=
 =?utf-8?B?V2hnOUwzNWQyRTFNc1ZtNW9uMU9IelJWbDZ5RjhZNHhLcmZHSmVHVHJ6b3pR?=
 =?utf-8?B?QXVDT3UwODhHYS9WUW5ITGtBOXAwMDJOUFQxMUQvdW5SekJ3Vm5hSDJrTHlJ?=
 =?utf-8?B?RDBuQytwVmF0a3JEWk1wNklKSER4S0owS3RCYUEvblpmZktUbnZYLzhSZ25V?=
 =?utf-8?B?YXhmTE1HT1BValhBbnZXYUhVUGRWeG45SzJ6bmcrMFpQQ0Z3VTBseUIyUVBK?=
 =?utf-8?B?Q1ZyNEFNblVuemhhUE9lSWFGUE02RWEvdklZdnJZR1RKaVdvYU9zNEpmL3JI?=
 =?utf-8?B?VFozMTlhTkdGNkdHTUZBQ0pOSnBsK0VESG15Ly8zQ21DUUJHTUxkU1cyaDY1?=
 =?utf-8?B?YXMwQU40enFrNDZzczgramF6azNKbGN2UkF4ZVNPa2gwdU41QnpCd3FUcE5Q?=
 =?utf-8?B?VXl4L0Erd2tXaEJDVGhVNjEwd2UvM1hHY04xOWFUVU96WXZHUmExeTBwUHNz?=
 =?utf-8?B?L2dtTTJ5d256cU1UYjZFcmhmVTBBc1VScUQvbTUrWThzYTRZM3BOK2hiUVp2?=
 =?utf-8?B?bmU3bmcwNHJRdXRvSkg1alBXQTg4Mmp1RWNabWdvN3JLdFNkZlVrcTVDRmdn?=
 =?utf-8?B?WDEwRW5oZ0RCNjFQditnSk5jMDdCUFJmMVZLUTE0b2RvUTFRL2Q5Ym1nZ1hV?=
 =?utf-8?B?OTlDeHVLUEdPL2JqQ1FFRHI4MnhxWWpkMkZodlVMOG92bHJyd2ZkUUZJcGFS?=
 =?utf-8?B?VXplSm9pNjJCbUl2SUZnbU4yT2VOand3K1FlUGszaWJnbHR1cWhtZGR5S1VG?=
 =?utf-8?B?WDIxTU93b2YxVmRRbDBPUi9sYTlrZFprbGVLWFdqbDd3allHb2NodzJ3NG5E?=
 =?utf-8?B?UEtrd09rTXFTMUpISEZkN2czbkg0TDNpQjhYSGYxVXRjK2JHcVJpeXRLY1Fv?=
 =?utf-8?B?RlJKb0V0eGRxTWk0d0VvWDVOZk1FVU51d1JFdFFFRFhWem1yMit6TlRWdXp0?=
 =?utf-8?B?LzBFVXB6bUJRdXVXUGQyblFFcGNacGk1L3JMOElvYlV5QUVaWHdVRXc4VWds?=
 =?utf-8?B?RUdnMmZqTHdDRlhwalFRV2xmRzBpTUdJMGw3ZmZFUnp0U3Q5bUY1WXFtek1G?=
 =?utf-8?B?bFZNR1VKcCt3R0YxTmJNQTk0TjRJL1ZQVUh5SHFLYmZGZmR2V3lSb202ZVBU?=
 =?utf-8?B?RFM4NU1YQWlFUmtrb3J5VGhjMS8zWCtaSTZ0RWpUTlNBSWtnLzFCQWN2ampS?=
 =?utf-8?B?cGVEVHc3am5MREQwVktmYVFWSlRIN3pPWFBFM2s4MmNRNkRMTGlzdVdDT1dy?=
 =?utf-8?B?UjFIR0FuZkl5S3VnMWtZS2FlVWd0YWgyTVR5UjV5cTV0YlM5OWIwNTlQaUhm?=
 =?utf-8?B?QnRseWhCYm1SZTJzSjhBVk1lRzAvSWN5Q1pUZTZaOXNZaDFrVlhWN3VBY0Jr?=
 =?utf-8?B?T1ZlOXBNazRaS2g4T09WRlAxKzRpQURsbXRTZ1MrS0dLTVVQMkxtTmNWaFo3?=
 =?utf-8?B?bTErNDVMOVViRXNaTzU3U2o4TWlRVnd0R0o0SFZ0aEdRU1NOUTlJdkdtQjNo?=
 =?utf-8?B?bFJaZFRJME9IMDNId3B5RDhQS3o4YmQyM3lEV0FJbk5wUHNZcUplZkdyeXJS?=
 =?utf-8?B?SUVJODIxY0podkxjYzF4QVMvYThMN1EyU0hjRUliS3VzUGFpbzBuK1BOQk9i?=
 =?utf-8?Q?NVWaoPZAcQw6f7s9GquJm07jewXDTyl8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0N0Ti9oTkVmN1lxSWR5bTRpZzlCR1cvODNNK09rRjFEUzQ5b09ZdlF3WVZC?=
 =?utf-8?B?clJMRTRCZWlLNDVxaDRwY1BreHRNTDhhbjRWTXJWSWtMOVhHbSsxbTRiWGYy?=
 =?utf-8?B?a0Nqa1FndHpPVWF0VGowaHVrdEhSbUxoVUNnQXJVQllqWjJjRmMvcStFaGRk?=
 =?utf-8?B?K0JRQVFKbkYxc1ZvMW5aUTJnWmNWK21DUktqU2xqeUxscWxkMWF1SHdmOVor?=
 =?utf-8?B?bDFQaVVKd2Y1ODFpNTBTdVpwVFo3U3podzNIKzdMNUFOWUMycmV6bGh5MDA0?=
 =?utf-8?B?OEt5QWozYTJUclYzN1pXaS9JeU9LcDNkSXFDMjdBSmdGWHRaZlNOMlJ2Z2J5?=
 =?utf-8?B?bXFwdGoyeXN2dEZ3R2k5bHNCMmhIN3RHanhBOVRvWk1acUN6blA2VkpuUXNq?=
 =?utf-8?B?c1RkWmhqVjFKcE9HMi8rNVEvQjB1S09SbUFGOUJJaVRYc1ZaQThmVmdjTS8v?=
 =?utf-8?B?Z3JjSEVBTEErVGFtdm54aHQra0hWRWN5cGVZUzc5WTQ2NlhlUWdYc2RLWVoz?=
 =?utf-8?B?bm5HbnZMbVBGM2hQWk5uaG93UURoblFNa0xycHdMUE1qbHhQRkFVWERhQ2Rj?=
 =?utf-8?B?bzBjTFM5TjRrTlptbXJIOWpsUnJoeEVGUEpXWUFYY3NYbFR0N1I5VnM3Qmp6?=
 =?utf-8?B?bDhxTm1GMFZVT2RDdDdIbDZGR2o1SmpFMGo2aVJ6VEVZYlpRUkdjY0ZJV1FM?=
 =?utf-8?B?eFZXWk5hbGpvbStGNFdaeU9NYmFHRjNQUWxySC9GTVN0WnZqTkQ3WUpaS3RP?=
 =?utf-8?B?ME91TUxueDYxRWE5VE9NYk9INHVBMU5UdXhpaEY2MjF2UXp5Z2hWOVNWTjJn?=
 =?utf-8?B?SVNSeUJiV2EyUllQZEVzbE9mSlZNL0hJQkVDSytZcDdyZEQxTTcza0Y2RDN1?=
 =?utf-8?B?SDhDdGp4Z3VwTGltRTlHaXJCRjVaWFNza0gzUUtzdUoybXVRZlQwVVJ5cm4x?=
 =?utf-8?B?b2FLSXVma0lkaTJJcTllMDVXQzBjODNBT2FPNDR5NWZlUG8vMzdyZGR5Rncy?=
 =?utf-8?B?UEhtaytGcVRsYy9FRXdTaXZxbjZOSC9WeUVxb0tEREQwU3lXeXphYld6UHVM?=
 =?utf-8?B?STJrVEtDb1c4Z0RxaGNqNEp6WDRReEJ3ei9kOGZsTjNxTEsrei9OQnlhR3Iw?=
 =?utf-8?B?Y28xdlUvODcwSXBzLys3RmJUcFY5ZkhvL1diYWc3eXE3clM5WkdTTVVPMEtG?=
 =?utf-8?B?K3h6N0pJS2FHUHdaR1NGU283MlUvT01XUkZCYmhvUjlCTEtoUGh2RU5ZSnJJ?=
 =?utf-8?B?VHFjN0JaWUsrdm1hM2ZzWkM0Um9kc2FuSmU5WjhvSGxVL1hCbmFNSDJkZzVs?=
 =?utf-8?B?aEFXTk9XejRVL3JOVmlQSE1WTWd4NjdVbXdiWGZjRFg5d29vb2R6dGdpWlkr?=
 =?utf-8?B?VTJob3pWV1ZlRHZ0eElDSTVaMUp2aEJYcjVKcnRwaStDZVlyYnVjVUtZK2xF?=
 =?utf-8?B?SytHRnUrZG81TFlZWjBzc0FMYUlNamhiR2NXQ01iYVMvWWx1QldnSEw3UkxV?=
 =?utf-8?B?M3dyY2ZjTHdMeDJGUnFvSHpwUzZtTDdUVGZsYmFKak5IQm96NCt4Vy9paHlS?=
 =?utf-8?B?QjA4cXRUdS9zOVo2b1J2a1A3RFpLaUFNd214UTczNWdwTllrdWlvVXczT1hZ?=
 =?utf-8?B?TDFQOGt5eUV0aWFpMmRFeWFPMzU3dzRhWkQvamtCcTBkWTNmSFBlYjBodlJ1?=
 =?utf-8?B?QnpHdURpNFk1QUwxS0x6V3FrNFp2eTk2Q2d5c2JyVUtHV1Y0aWtyYng0OUl5?=
 =?utf-8?B?VGVLU1lIWHZydWNLQk9TbWVFMlFxU3ZMc2tEV3BhS2w4cjNDNjF6d2k0L2ZR?=
 =?utf-8?B?ZXZPS1lSdjg5azZHbGhWQmt4OUd6bnRjSDN6UUJzN0V5Qmpva1BNa0NkY3V3?=
 =?utf-8?B?UnFhdHQ2N01OTDFlK3lnRjJvZHFQYzdKcWM1dTJVeW52QkpnRWpEVHB4QnND?=
 =?utf-8?B?NzlVUWVuajdqTzBYMDNNUERhRmRINDAwcUgydzBxU1FmdVE0RUp3cEhsNU9h?=
 =?utf-8?B?RW1KSnNJNDltU3B2a1M1bDFQVjJzU21LcTBqYklXN3IxOFMyZnRzSWg3TVJz?=
 =?utf-8?B?TzhTN0tQU0ZFR2dUUHdvdnE3d01pNmZEdnZTaVl1VldLYjFGaUo4NDI0bE8r?=
 =?utf-8?Q?KNAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a00caa-a6fd-40d2-204c-08dd5a31a4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 08:59:01.8117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nExU8sg3XXK6DxP3xHVfjGYO67kPnCP6auxHDVM5bHl0L0XcGgtGaHNTRms7YxNtqD1Wc6M9cTPzpk9QKGcQRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

W1B1YmxpY10NCg0KSGkgVGhvbWFzDQoNCnNuaXBwZWQNCg0KPiA+DQo+ID4gVGhvbWFzIGFuZCBB
aml0aCBjYW4gd2UgZ2V0IHNvbWUgaGVscCB0byBnZXQgdGhpcyBtYWlubGluZSB0b28/DQo+DQo+
IFllcywgc29ycnkgdGhlIHJldmlldyBkaXNjdXNzaW9ucyBkaWQgbm90IHN0YXJ0Lg0KPiBJdCBo
YXMgYmVlbiBmb3Jnb3R0ZW4uDQo+DQo+IFlvdSBjb3VsZCByZWJhc2UgYSB2MiB0byBtYWtlIGl0
IG1vcmUgdmlzaWJsZS4NClN1cmUgd2lsbCBkbyB0aGlzIHdlZWsuDQoNCj4NCj4gTWlub3Igbm90
ZTogdGhlIGNoYW5nZWxvZyBzaG91bGQgYmUgYWZ0ZXIgLS0tIGluIHRoZSBjb21taXQgbG9nLg0K
Pg0KDQo=
