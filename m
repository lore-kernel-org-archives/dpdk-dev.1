Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BED29C36
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 14:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF7A74029A;
	Mon, 19 Jan 2026 15:55:35 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52]) by mails.dpdk.org (Postfix) with ESMTP id B74FD40299
 for <dev@dpdk.org>; Mon, 19 Jan 2026 15:55:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAs6whEPGUbwUAVU2vElrHOF8OntP4N1U4llkuZdwvYK55eTmVF9jicLnvkxGz5unb4o5dqzfptlL9KOUZfczhUb8gBvPfUq68ZBF+Qu1urOGyn6kgu8ig4pQSk2RgdA9ZwaRHC5LGunhdzTTCeA7rBOURGLxdPLDizSty7hbWk88NQDoRojVX5z6ocPVk4CHkOvS/PMHfASfquIc/yahpav0HJ03b6QPYfzZK7q6mTDHn7uORMCfTOH+U6/8nEZp3/UhpTvFYJFgla2axGj51MwR1dHu8kViYnVK9Lj28P+YBAaNg3DhAqLFJyaPkiFxGlg3bRRIoXwdHzMZ9ivfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtUfspWLBX9D1gPWhlkNLa72fV9xt91GecQYGD2QEro=;
 b=wT272mUEsEq/PCn9aAPDhwEZ4ORCBUi7I0D4Ld+4lonAO9MabzUA7F/Pw3qV25Z55r46O9TbOJxVW6rIBUzr/Ly7nK39tX7ZbR8E8J2vjAHc2efwnp9mY/Xy+mzVFEjfDS5jaey7EQ3Hf8hSaN36nxl+RU80ClTX0/FN/bKyLCp+EgE7QW0JP1Eu3JXc8KT5Q94G+/eajsVcGE/i0nSuRX6avrl4D1EHpSdsvw7VXxQR7CH1ihdO5CiiKQ0E+N6yMHNNSmSVzBs7ryEQ+hF53wFUKUbEUc4FYo05O4bRVRu6krA5S1QGFVppyuj02Bah2p332F42DQUXlKmY2mqAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtUfspWLBX9D1gPWhlkNLa72fV9xt91GecQYGD2QEro=;
 b=3lm22XwHyEdsNhRhp/6+CWbmrcfoGA/bsuD0haDdCCGK1ff4h7dyP7NqMed/coc1sN5ykjEo+HBVn24tizxY/R/jT5FdZ/TEA6679qJovmDkTC3x/FO75mbubGK+CuPwev6QzN/hR3fWMG79UI3MDi1/KtAJ1ywDYjL51luI5bc=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 14:55:30 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 14:55:30 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Jan Viktorin
 <viktorin@cesnet.cz>
CC: "dev@dpdk.org" <dev@dpdk.org>, "roretzla@linux.microsoft.com"
 <roretzla@linux.microsoft.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "john.mcnamara@intel.com"
 <john.mcnamara@intel.com>, "dmitry.kozliuk@gmail.com"
 <dmitry.kozliuk@gmail.com>, "pbhagavatula@marvell.com"
 <pbhagavatula@marvell.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "ruifeng.wang@arm.com" <ruifeng.wang@arm.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "honnappa.nagarahalli@arm.com"
 <honnappa.nagarahalli@arm.com>, "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v4 0/4] Introduce Topology NUMA grouping for cores
Thread-Topic: [PATCH v4 0/4] Introduce Topology NUMA grouping for cores
Thread-Index: AQHciVOnZ15ODzZ5R0S05EnKUfVGcA==
Date: Mon, 19 Jan 2026 14:55:30 +0000
Message-ID: <PH7PR12MB8596B5365FC72F93DB0BC2128288A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20250317144607.118a40b0@coaster.localdomain>
 <20260117105722.659fc146@phoenix.local>
In-Reply-To: <20260117105722.659fc146@phoenix.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: stephen@networkplumber.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-19T14:55:21.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|IA1PR12MB8285:EE_
x-ms-office365-filtering-correlation-id: 8d5b948e-1742-4f9e-51fc-08de576aca34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NU5tOHhyWnA3YnUwZUtUclI2UFFCc2J5SC9wQStlaCtXR0hrRnJVeTNsT3ZC?=
 =?utf-8?B?cXpRd0VVT0RlTlhPTU5YaWRiS0EyaXZPV3FsY1ZxTUtXWlNIdktqNFNwRkps?=
 =?utf-8?B?aTh3SEoyN2Q3L1haM3c1TUsrT2tGUzN5S2xaRVZLUklHOFppWWdpT0psd3JE?=
 =?utf-8?B?MU1nOGhjaVQ2MVMzVFJ0dUZvdXNPSHhpT1oyazh5SlJBemI0QzJxdklZSXh1?=
 =?utf-8?B?bnQ5TE1YVWNkeElQMVBvSXFsdCt6TVFYNzZmQURtbXFQSDJHL2w4ZnpxWGw0?=
 =?utf-8?B?czRoOWdoNFpoWnl5eGNHT1JKWUxMQW4yUUNSTjV4RW1rQzBLNkFpTmpPcXFm?=
 =?utf-8?B?RkxQanBPTFc3MTVEM0dzS3lJUkxrTjk2aVFNODRxRWJtaEVldVhCZHByNnJM?=
 =?utf-8?B?b1lwalpWcGhDVW1rN3UyV0JCRElIYlA2dVk0UzNIWm9OcUxJVm44NzZqWUpq?=
 =?utf-8?B?WkNSRzJMQVNkdEx1eVhrNFA1YUdzclhwc0hwM2RQeUtURC9hQnE1S3V3OE1i?=
 =?utf-8?B?WXY4R2RPVnFndFlYK0I3NldUZ1p6MUNJNlJHM1k4YnZWTVNmMTByMlhBeVZj?=
 =?utf-8?B?by9BNnlJaXlZbUt6dnFNZStOY2l4ZWhWSjhEVGZySUMxRC9nVDBBWVB3V1A2?=
 =?utf-8?B?L3VzWjZjVUtvS095c1lGU3MxMmFwUEl2YU1ScmVBRE8xdW9aUE5LWXN3ODFZ?=
 =?utf-8?B?WE1uZDljQWZNc2h3QmUremRlaE9Hc0JSbDdueWpMU2xmK0dHcE1OWnRhbGIv?=
 =?utf-8?B?UEpGd244cHpKNHB2c1BLQ2xnWnpyQzNNbExlSmlXTkhnMkpYbkFXYStDSnA2?=
 =?utf-8?B?d1gxSzA3WTBzN0dHUENSdnVkeGlCRWxUVVFsL1lVZHRSNHZBZFRFMWFmbEpW?=
 =?utf-8?B?TXVyaHZnbUdCTHJFYW41c3NMUkZRcjhQdDBvak9hWGxjKy85ODlPM1Uwc1BI?=
 =?utf-8?B?bHJzbytuYW40RWFmNXlDcWVSVGVYVHJPUW1aSWpZQlNlcEgwVGErbGJ5UVpm?=
 =?utf-8?B?OWdMOCt2VEtWbGM4Wkx4eitCRVB6WmQ1ZjlNOXFnT1krUjVoRFRnNHpCcEov?=
 =?utf-8?B?VjNtVWcrMW9PVnJVVERmRXdOaFZlSEQyeDRqK2ZuV3FhM1ozNHRGWGRaWU81?=
 =?utf-8?B?UkdJQUttVS9kVDZJZy9uRG9uMWMreTY5ZUc5dGhDR3JYNWREeEdHTlNIRnlj?=
 =?utf-8?B?ZGd0R0o1ekFjcjNKVmMrdUJxWHJIa1BCNFUvN1M0SUJwMGZxZ0hnQnB0S1p2?=
 =?utf-8?B?RTZEblJMNzFkU3FyRDAzTnlKM1hCTVlFcitCdmxGZWJEb1BGMjdsalBrdUZP?=
 =?utf-8?B?c1dxQVpleGMrdCtrZzQ0Y2tQN0M3NDhmUTZsTmgvQ0ErbHk3VE5BMlQ3Ykhx?=
 =?utf-8?B?UVZOaXBOZkc0endtMVNoVy9WQ2tmVjNUL1lEY0xZVEJ4cFVzKzRhVldQYThP?=
 =?utf-8?B?Z2tZcjBrZDYrMXM3RWxPSlMyMWZzRVdveFA0MGFvZlYzNE1NK2xtMkZMRWFz?=
 =?utf-8?B?QWo4V3N1OEE2OE1FSkZIaDZXTkhSMW9QMjJxL2RabGJlMmdSYzBqSFBqRXJQ?=
 =?utf-8?B?djNUbFQwT1dKUDB1VUc0aE5RWFByaXRXNitwQUVVV0x6QzF5aXVjaytQT0E4?=
 =?utf-8?B?YVZ5M2k2djZqbDl6VyttYTZYYUpSYmxqbDJ0OUJrY2RtRktGb3I0aEw3ei9z?=
 =?utf-8?B?M0YzVmZrTTZaRGs2bE4zQlA0SkRQcDhGWUU0M0ZQcHdnMkxDMkhHeWh3L01i?=
 =?utf-8?B?b09aejZtMHNwRGgxWlJwK2tROGxhUkt5QmZnV3o3RHNLVWlGSTduTFhLWTVP?=
 =?utf-8?B?YTRwQTNvbTlpRjBSWVVnVEFCZGRYZk9oMnJTVGp4VVg5cFU3VFhyUzd4MHB4?=
 =?utf-8?B?S0ZUdFBOMzY2T0QyNG1mdDd4aVRQN1BlRERPcTJDWFpBM2hxTHQyTWNkUXhU?=
 =?utf-8?B?TnBWWlZCOHk3L0RMV1NBQTM0N2lFcW1haWdnMlBaQnVNQVJFN1hLaEthMTFj?=
 =?utf-8?B?bzF2SWxOKytVOC9SVEh2Y090elZ5L1VnUHloalU4Z3pjeFVkVlk2T3RVUEFW?=
 =?utf-8?B?UFQ3MEltREtMTVNxUnVIVXdaalpRRjJTOFVwMDlQY1lNWmZYemdRcDJacW9o?=
 =?utf-8?B?VmErTXJSUmFoaXNWc3BzRHkraXZwM0RBNlJDcUJhdU1jK1VhSm1WcVVTK1Ur?=
 =?utf-8?Q?0a/RYlaPpMTqjCdDqQ4sNYY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjc2bjJUWkcrMDNUSXEva0hQZkdjckd4UGdRQzNIOFpMaTBOSEszU1FuT2Vz?=
 =?utf-8?B?eGNsWmlXM0lkWGE5QnhsbWRUaXRITTAyQy83K3N0SmdSdTZLMk5QZkk5YlpL?=
 =?utf-8?B?azNuUzZ5S0s3bWN4Z0k5V1V4dmhRSE03VlNVemFBanR6N3p3MUQ4c2NTUFdR?=
 =?utf-8?B?TXNYSmVZbHVOSXNwaExHdzBUcXBHOHRGK1ZlYzlFcWtmWE82NkgrSkw0NlVY?=
 =?utf-8?B?NXJpYm00dUUvL1pJa2Fxcy9mRWdjYTVHN1BCVzlDL1pWRzhpTDBNRU5oYkc5?=
 =?utf-8?B?aW41R0lzeExrcTRWeGIzdGcvSVF4UDNONFgwWTFXalhpblFvUnVwTnFsb3pC?=
 =?utf-8?B?b2hTVHl1bVlzMlhrSVN0YkVRK0ZIdlozckxoWDFxRFg5eityTGo5T3Z4WG53?=
 =?utf-8?B?K3hqS1B6emhRN0Y3aGg3Q2o4K294RTdLQWJmcGlkc3NyU3dBRmRuWENxblBi?=
 =?utf-8?B?U0JXUFlLU0djaXNkR29JR1Z0WDRQd0IydVNrQlBqOWJ5YnFWMGprM2ZyNUtQ?=
 =?utf-8?B?bmlySEpNODlvNFA3VXN2L2dLVVNkMlFpMlhqTXMvMWlvNmdBY2ZKZ3VmZ3N3?=
 =?utf-8?B?dzlXWEN3VXFVY2xTN04zYjR5K2MzcDloNFdvdnZ5WjRXQXd3a2dwMEFhbmt5?=
 =?utf-8?B?RVIrekU1d3FIaHB0OWUrbVFvL2Vlbmc0dU1iUVRheXVteVEvSzlmMU5ORDM4?=
 =?utf-8?B?Nms0ZEx1dnp0TEszbjRabUZEMlFNTXdxVENUTFgxekJDUE12VERIWElUZ0Ru?=
 =?utf-8?B?SGo3Q1Qvc1BtbE1EVitvUlRrOHZzMjNockNnOW9reUlvWU9uTjYxZjNrSllm?=
 =?utf-8?B?dDMvZEhOWlMvL1c4L2U2VXRmMGtmQ2I5eDIzZFVkeW1FalJyTlJBWW1rcHNX?=
 =?utf-8?B?QmNXNkxCcDJUTjlHd0o2M3ZlbUUvamdEYW5WQk9jdDBJZXVvTEpyNVl6MGhH?=
 =?utf-8?B?eThScDhoRXRKK2w0d3ZKNFQrTk9tV09QV1N5d1lobkYwMHgwRktscWNlOHVP?=
 =?utf-8?B?OGxMTFZ6cE9mS2FydzFab0loNStJaW1qdmg4ZThBVDVYa3RiZzk1dXBJcGhR?=
 =?utf-8?B?T1QwNzhvTXE1T3o0NGJmVmVndm0xTG8vQ3AwRmdEL3VsVzlSSlB2MjE5VXBL?=
 =?utf-8?B?WTRIT3VJQ0RwS1A0UEJsL1JKT2JmNXloZGxzZGxhelVsSE0rQStTendiK0ZC?=
 =?utf-8?B?TEoybFV2VTVuV2crcE9XWm81b1Ava1RUMWIwMmZ4eGFRdS9MVWt0VUlyWnBP?=
 =?utf-8?B?bmV2YTlvQWlvcHoyN0ZtbjZRSlFVYWQ1VXN4N1k2YmJNdXpRS25teDZKb1FZ?=
 =?utf-8?B?bWMzKzY4R1l6WFpReTltT3htek9uUndyOThIVFk1blRkRDNKYTBjaVhoWFJp?=
 =?utf-8?B?Zm5vR0pxTnJxOVhRcGkyVEhZRE5ZaUJLSnFpL25iR1JXbUlMSFpxanBYaEhK?=
 =?utf-8?B?UjVsa2dTSVBMZC9NTlZDZzY4ZEwzTW9sQWwyeFRKSTFEUEJHRFVzT2YwZm8w?=
 =?utf-8?B?QUhYSktlR3gxMVdmay9jQ3pwWHRjU1VpbHNDT3hSZFF2ZVJKQW9hZGRYTUxZ?=
 =?utf-8?B?L0c2TWJnL1d6Qlo1TUp2OTJwU29hdUMrTFpHNVVmN0tPMjJCNVhKMHVtWVNF?=
 =?utf-8?B?eitVTGM3dFVCd1RTQjlBanlKb1hUMzk3RmRZbGUyOHlyOHozOS93cWpLbDVB?=
 =?utf-8?B?ejhHMmNranZZZ2lUUHQyUGpaUHREeXVFc0gvS0twalVEODUyVGdWd25GM3pu?=
 =?utf-8?B?SkpneWlLZmJKS2ZYYkczR0gvWURyNG9vbG44Yi9aL0RQN0l2aTByblJjR0dV?=
 =?utf-8?B?UHBIbm5PR0Y2TzZMWW9SYVdDWWU4TlNVSG1kVm1oL0Z2blplSHhreWlFa1VL?=
 =?utf-8?B?QmF4d3hxMWFEZkUvS01QdG1UVDl1M0IrdHhjWEkycGJNQTYrY1VSZWhJWXZQ?=
 =?utf-8?B?S1RPLzNWdHlTTlRkRDRZbnBzTW9IcTBieldrZHNmWVg2M1lnSElJSmRsN0xC?=
 =?utf-8?B?eUNYc3NUNzE0Y0UxL0FvL3o1MTJXWlZlNkxuOVZRQWlxcnFvWk9LMy93QU1l?=
 =?utf-8?B?ZGFQWllaTlJHNHdQTXg3a0hGM1hQOTlvNjBwRy9BL2UzM2xXMVhYc002eSsv?=
 =?utf-8?B?NXErOXNudnZKR1hIL295cmRjbmRmVDJlSWN6UDcvVDg3YVVKZ3U0ZEswcmpl?=
 =?utf-8?B?c2JIQkFMS0szOUpQcWpCTEkvaHZnR1JlcEZ0TjVJb1poelgyaXo2Z0pjazh6?=
 =?utf-8?B?c0tkSndSTmdaazVWblUwWDdjNWFpMXV4VEZXTWxnVHlNNE5FQTRldzk0QXg4?=
 =?utf-8?Q?1d8yEol/1QrApv6Pck?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5b948e-1742-4f9e-51fc-08de576aca34
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 14:55:30.3680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYAjrFHjSsjPPafBbF92zOHhbMEJu4eptGbO3QOBH6NqfoERZ7igS6pyUA4WU8S3YCbJfwfEdCvYHOQBk3sIfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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

W1B1YmxpY10NCg0KSGkgQFN0ZXBoZW4gSGVtbWluZ2VyLA0KDQpUaGFuayB5b3UgZm9yIHRoZSB0
b29sIGFuZCByZXBvcnQgZ2VuZXJhdGlvbiwgd2UgYXJlIHdvcmtpbmcgaW50ZXJuYWxseSB0byBy
ZWxlYXNlIHY1IHNvb24uDQoNClNuaXBwZWQNCg0KPg0KPiAtLS0NCj4NCj4gIyMgUG9zaXRpdmUg
QXNwZWN0cw0KPg0KPiDinIUgR29vZCByZXNwb25zaXZlbmVzcyB0byB2NCBmZWVkYmFjayAocmVt
b3ZlZCBtYWxsb2MgY2FzdGluZywgTlVMTCBjaGVja3MsDQo+IGZpeGVkIHR5cGVzKSDinIUgQ29t
cHJlaGVuc2l2ZSBzZXJpZXMgd2l0aCB0ZXN0cywgZG9jdW1lbnRhdGlvbiwgYW5kIGV4YW1wbGVz
DQo+IOKchSBDbGVhciBBUEkgbmFtaW5nIHdpdGggcHJvcGVyIGBydGVfYCBwcmVmaXhlcyDinIUg
R29vZCB1c2Ugb2YgZXhwbGljaXQgdHlwZXMNCj4gKGB1aW50MTZfdGApIGluc3RlYWQgb2YgYHVu
c2lnbmVkYCDinIUgQXBwcm9wcmlhdGUgc3ViamVjdCBsaW5lIGZvcm1hdHRpbmcgYW5kDQo+IGNv
bXBvbmVudCBwcmVmaXhlcyAobW9zdGx5KQ0KPg0KPiBUaGUgY29yZSBjb25jZXB0IGFuZCBpbXBs
ZW1lbnRhdGlvbiBhcHByb2FjaCBhcHBlYXIgc291bmQsIGJ1dCB0aGUgcGF0Y2hlcw0KPiBuZWVk
IHRoZSBhYm92ZSBjb3JyZWN0aW9ucyBiZWZvcmUgbWVyZ2luZy4NCg==
