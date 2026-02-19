Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D678E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 11:01:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEFE0402EA;
	Thu, 19 Feb 2026 12:01:09 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1C812402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 12:01:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oju4/XY9vO7zSg1Ay18ImvCUhUnXdiikcH8ItJZLgAweDvoPcgbfnqxutJwrNaajrrdnPHAwIw/ZHPo+siZ+SgNCXEpyEWYHzf5BH4CSJlb7cPCI/eMLD2BfnE38prnNrCorBk7JrUdJkKITAGW218IFFUVktbtEw/+UjH+Q+ilcpS493yxZJWMNqp8htoz+W3TeSRTBkUL+4aMN5yXaPKOgYsYYLsTucX2bx+PJmlYgRBDpQYapw0PdZmY+Lllx5P1tpJuVr81c+XDbZvM9rx70HWGemdFDwBU7lUevyCxVwJt73dDSz1DS0aGER/iVD57g+PJjmYWtAvZmf164zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqaCflp3bIl6B/5y7iN10StmtHeMjJ8oJoVYWY3JoSo=;
 b=Ibts5/HfLfMU8sDzY+i2saklcv0vDImL9Sd2xUjP9dnvzELZVnQb2xhDvmPCUpW1rb//h840x+edmG/TXm4JqaIDJ6d5S0u+SJMVUrCsMlJu1BG5o1r6JalSBqd8jpPui985qNssXusbo67WiUOvBm/tNl8NhV7f8PXej0w3VK9dt8TWc80T7NVzC0uFtvf6jOrrEV2TyTLnAnggvTNxV8ssxdMLF/3ehBdQ5jdq/q9pleLWTp76hHVhLK2rr6lV9WGDG/MpTlrGTl7JYK7nxP/oAYuQi6475z0FZ2ukznCLANlakwQ1hSju6EOzK/QxA7pOTtKhnw81FsKBPXjDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqaCflp3bIl6B/5y7iN10StmtHeMjJ8oJoVYWY3JoSo=;
 b=sj6vqFhu1EqYuy9MVxs3L8RWhdXpwog5BvN3TGsb9GIU7pHk0ObtwSazMI0ez6UV93Xir6QOhznueHhKqNZZBcUhTQWSaJawjHeGnTYhwGYecI7Eg2mSmLlJA6DUVYVC8DWuwkOIYj+GxGGGhH3+nKRbcfagm1grPhyOoufdReNktx2AYDUOQPX/9GTYTEvv4MqpQMQMyN35NxC/b04xqghwqmSaGTJ6TnDtO6ZtUfI3tOzr9OfYvptb7KXd34XxgIa99feAHbCBOlubDn9y3gODYPvKc4bgfjx1cJ5+7Ff9KTpRcSx4WHxkLGE6zkXBBiU6oyQGiFp+gzcUXpUeog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI1PR04MB9809.eurprd04.prod.outlook.com
 (2603:10a6:800:1dc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 11:01:06 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 11:01:06 +0000
Message-ID: <773dbc56-26af-49e8-97af-6f996d8bd517@oss.nxp.com>
Date: Thu, 19 Feb 2026 16:31:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] net/dpaa2: fix rx error queue memory leak on port
 close
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-3-maxime@leroys.fr>
 <fed52258-7066-40bc-9cef-b3388062628a@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <fed52258-7066-40bc-9cef-b3388062628a@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|VI1PR04MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: 86be4841-3b37-4bfa-55ab-08de6fa62dd2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWt1c1BVYmtHN2RIY1I4Rkt4eGZZSzVFNmdnU1UrbmZVUzN3Zms4aFI2Nktu?=
 =?utf-8?B?OElOa2pFMVZTVFU3eFBMZ3V6RnRvQVdsbW1ydTg1VkdXTkRsSzFWU2VhOE5a?=
 =?utf-8?B?UTZHSWw3enBacXlyQTd1VndYeFNaWDFqZnBRUkRZaVlabGRSN2pkRW5IcXVE?=
 =?utf-8?B?QjdGandYZ3VpUnRmMUNQNi9WaUtrZlA2R3FzTWllSUFOS3B6c3QzYmttQ2c0?=
 =?utf-8?B?TjdSaUY5dVBWQjVSV2FZdWFHQUlCdktkbDNjR0lkWmtnbWZmMk5tU3ZGTGNI?=
 =?utf-8?B?WUhEZkc5bWFJYVhMNTVDbmZzRjFTbW9BRG1pVjkvT1JJVGNHUU0yTDVpVGRk?=
 =?utf-8?B?RnlmUmhzUzg4Ky9RVVYxU3ZHK0xxdnVxRnlsVWFMN0gxVDA2QlN3V0c0dkZO?=
 =?utf-8?B?REt1eWZyeTQxNTV3N0pTQWdjamFKLzF4SVV0L3RaTVBxVzR3cTVLL3IxTktD?=
 =?utf-8?B?SEIyY3pGNUgzK2F2RklSanV3eDFuWTlvMlk1RVc3VmJDSS85eGFjUGY4WFVx?=
 =?utf-8?B?ckN2OEV0WUt6TGN2akxOSzhBRzRrTys5ZHo0R3ZqQlUrSHE2dGphZ1htUEQ0?=
 =?utf-8?B?cDZmcTA2bGl4Y1hYb3FQVkFHMmdaU1h0QXZ6VVdhTjZqbjVSSnNqMjlDL3pN?=
 =?utf-8?B?VnFRRXdyZUJCUUZDeWZsNlRMdUtBU095OHdWUGdESnRFZjk3aEtiZFh6cEZD?=
 =?utf-8?B?anRoR2VOSStyMDhLWlBpdUdPSGhFcm1xU0VEbzQ5bld0ZDlaV2hFYlZLYnVr?=
 =?utf-8?B?WTVuRFpOU2NGN1A4UndYWEF0UUNjT3dCUkNUR2lpa2dxWWRqOXhoUUpEc0t5?=
 =?utf-8?B?N0MyZzlkM2RQSHdWL2VXdHJOV0Y4VU5jMjl5N1RqT3l1YzdGRmNoakp0d05V?=
 =?utf-8?B?M0Z3dFpDa0poNXltSGFMQ2dBUE1ZRHo3YjFaMnViaDNsVlFZS3lYTWZQZFlh?=
 =?utf-8?B?V1dEWE5OK1N0R1J1cDl6MFdvTjBRdHdFbGpibzRxKzJVdnAxQm9jbWJEaXpS?=
 =?utf-8?B?VU1QTWxFMFR3aXRrMGwwaG8yQU1UNzVuZ1RlVDhGUVl6WkRycUd6bUkyTFM1?=
 =?utf-8?B?YnBXYi9tc2Uwb1E3dENRK2RDbFdCZERWMU1hek1zdW5iWjJjZmE4SVFPMjlC?=
 =?utf-8?B?dmxnbXU3MjJFbjdDVk81NkZuYmZ2LytFS1BIUjVFZzNpbnpoRTMwcUU1Wk9P?=
 =?utf-8?B?MjIrMkY0L1BNUmg2dWplQjhXUmtZcWlJb0xDUkVyNzhPVHFvYTFETXo3Lzhj?=
 =?utf-8?B?cC9kMzZieEFacmtkODJWN1IxOHhzNVIxUi9OT1FKY2I5elkrd0k4UUZ4dUlT?=
 =?utf-8?B?NHhkbzV3MmhDZE5Sb2EyOXdRM1hKOWw2SEdsYTQzbDM0cjNSRVlzRmwvUzg5?=
 =?utf-8?B?cjNyTXlzejJGdzVESm9VYlhjQ3A2RHJETE5LdXdHRW5DR2h0UGVRYmZHMU01?=
 =?utf-8?B?ajhyTjJIMUNDMnlPUWEyR2xuZmRya25XUUJnd1pUeWk4azBibUtFUURQUTFq?=
 =?utf-8?B?WGRtU0IxOVliYWVYWGFzZHpWRE4vUjJpejVaQjFldWNqOGo4dHRNYkV6WXFF?=
 =?utf-8?B?eTUrK21KVTA0U0pweFVZcmxMS2lLSmJUbUU5akgyWTFkcWVnN0hNQTV4Wk1D?=
 =?utf-8?B?VXd5ZlBsRWdicHJIeGhrQ2Fmays3dzYyWXFjZXVXR2g4b2toeGJKYUZ6NldW?=
 =?utf-8?B?L2RlaFJid01teHlQMFE5S2dzMEFaNUxpenlyTzRlVGJ4eC9aRVIwTllpbFUx?=
 =?utf-8?B?VDhVbUxmUjhVOU5XTmIvM1J1YzVlQUo3UjVqeDQvM2kwWEQzWG5WSHJmcThI?=
 =?utf-8?B?Yy8rdERhVDBSdXBGNlV3aDlhKzdmRU9XSnJHNStBQWd5dkJ5VUljYzRuaTFR?=
 =?utf-8?B?M0R6MnZ2ZmVvYlJjMVN5Ujk5Z0RrUC9NMGcrcFBmVHBRcGJ2TTBQeWluODVl?=
 =?utf-8?B?dGlrSjBxUHZKUE1RVldnSVJQaS9tQ1R3czNackR5T1UxcE1KZzlvT2VjWjdZ?=
 =?utf-8?B?blpzZ1R5Ui9mb1NQbEtBNGxkckNDUW8yanFMdkFUd2tQcC9mRmI5M2R0dzJT?=
 =?utf-8?B?RmM0T2dyUGQ4NDJnTlhPUkV2L1B3OWVoTzdnTzhPd3ZHcEI4UFhiQ0RQcVpT?=
 =?utf-8?Q?oHP4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTZralNBR2F5R2x4aUp3WDZUSnN3VEZPM21oUzRESHBja0VBenpJRnppZHdx?=
 =?utf-8?B?anE0bldHdXZpSTM1OXp3RXBkOW9OVHJDOXJKWUwza0RuOS9kb0ZxZkJlNG1h?=
 =?utf-8?B?M1pqNFF0UGlvQ0lWNHJ4dmN3cGxDL1N6SVBVVzVEdE9ESzNlT1FNSE1jNVpw?=
 =?utf-8?B?M1d6Z3I1RnNSdGswMFBnc2hoK0UxanB5ZkdFNU1nK0dwQWlDUVhUUEJRNFdU?=
 =?utf-8?B?SEU0dWRrNGhYS3lTUGtmWmdCSkxRTUlvOHJodTJiRGlBbWZVSW9ZYnFCZDc5?=
 =?utf-8?B?RXpWMEsvVktiTWVRaHl5UmVib2FjbCtkQ1YrU2ROMFRhVVpEc1laVE1kUUtX?=
 =?utf-8?B?OXRNdno1MFJKdHloanc5VGVDczM3US9wUXVWTkFZWmVDdG5QKzJtTFNmLy8w?=
 =?utf-8?B?M0VmV01RVVBHeE5YT3dMQjdSVG93T2M1RTNOcWhsREpEbVhSdlpRcjRFelli?=
 =?utf-8?B?UVhRNUFpeDNmaXVYT21PZkdIaTFFbGNyUU5yUjJPM3ZzdWc2UnhWVGxmbGlm?=
 =?utf-8?B?dUJYQ2ZSbFg2a2hzUVUrYjdzdmRWZEN1SS9iVk9GV2dWSFZnbUd0YTUxVW85?=
 =?utf-8?B?b1hJN0hHT3k5bUlFVnFWeCtpNldvNzFMQTJUZTdVL0NqOHlDbU5OeHJUTkpB?=
 =?utf-8?B?aDlPWFJmWjB1TVJGU0NReEV4L0gyM2U0cjllaGRLOFpka2NzSGtpdno2T2Va?=
 =?utf-8?B?amRrdDcvOE54UU9CRDVNNjdtMDh3WitVMERFZHJ0a3JNcEZ2YTBvcW9ra3FZ?=
 =?utf-8?B?MGd3R1dHdWRML1NzRWVTMlU3ZzUzNGJlSWhqNk12aWVBYjBYODFPK1RGbnhq?=
 =?utf-8?B?akpUclFsVERnYXVLN2Vla3ZocDR3SFM2Z0thcUs5YUM2QVlXQmpPKzUvZXJq?=
 =?utf-8?B?Q0FhNTZGTDNZd2RlSUdQd1NCWHE0RmoySzY1bHpvSXI1WmkzMmZGdGhDbmtL?=
 =?utf-8?B?ZUsvV3l6WlhDWmxxQlFhL2dkSTZ3cEpSYm44NkJYZWV4Mlh5cXFZZlJhSWR4?=
 =?utf-8?B?TGJpS0YvWjdOZ2ZWeVFPM3VQOC81Szc0UGU3VVlOU1ZlYlh1UmZnOGxSa0h5?=
 =?utf-8?B?Qk1mZlg4U1J0YzNFbGhnNmgzNG1BVU1MQTdkNU4zRGVkWk5jb3pqWTh2b0tw?=
 =?utf-8?B?ZnF1ZHloQ3o1Z091dFJVQXJYanBFTmMwUTVxVEdISlVCMWxXK3BzKzAzVmpD?=
 =?utf-8?B?SUhjRnR3NDlHVEVmNDBHTW5SK3N2MHFMaUUvRk5kWGtpU2ZXTjVzVE9WUi9a?=
 =?utf-8?B?aDNrVjEzMkkvVk9RTXBMT25RWFVBL3MyekhuUWdwR1lQeU0rRGdJOFdQcmRp?=
 =?utf-8?B?dEgwQnhheFVJendocWFpZ3pROWlYVm5LWmtzOFZtcjBFVjV1bWNUai96UDBz?=
 =?utf-8?B?TElWbjA0MlViTXh4eUE5amNRUnUxVzhzdDNxQVZoUm5VYmJJNkRlY1UwUlFP?=
 =?utf-8?B?TXluRkZ4a1dLMXc3VVVxdmpCZ3cwREtqaWp1MGgxenVqN1FkTWtPTk9SUk5a?=
 =?utf-8?B?SmVQREVxTWNKTldNT1dKUC8wVUt5UXVXMGk2TDF4b25KZlRqRTY3ekhtK2hP?=
 =?utf-8?B?bVYzcFh3SUVsdWtEclU4Zy9UZnBPVVhnVFBkYVhGNE9ORWF0enl3TXdGdGRZ?=
 =?utf-8?B?cU9WQnVaU3FvN3lhUGJ1OXVhRW1kbE14M3ZPaWJZbGVYVE5VV2FXY3ZwUFZH?=
 =?utf-8?B?cmJtNWt0QjBiUElhQm9XUzE4SnZLcnhlSXZtNThzcWpENUUrVC9UODJXOUYw?=
 =?utf-8?B?WTloQzRIVmNxRU1PeFkyVHRsZ3NubXAvV1E0UzB3UHZkQ2lOeUhrMWN6T1p0?=
 =?utf-8?B?dHN4eXFUMDVqbDJGNmczMUtmaTF3MmlnZ21tUU9EL3R6eS9kdVhOd2NydmVH?=
 =?utf-8?B?anBMTGpJNHNMcDZYN21GeHdsMWozc2RLcmIya2ZycC9ablJXNlc1KzhvQk9V?=
 =?utf-8?B?ZlpTVW1JL1VHUUJVQTFaMWFIUFl2ZkJIc0RpZ3htcjBPSUxrVWlJSmFHcDZ6?=
 =?utf-8?B?TEdUNmJmdnlPQnhCc2M4Y0JLK3Q4emwrSlpIY2o3UjhTelBlcU1rb1g5ZHUy?=
 =?utf-8?B?eGRJNEo0czh3ZEhTamY2TGFMQnV0VjZVQ2IxUGJDOElzVDFvTkdxRVhpdjRi?=
 =?utf-8?B?eVVhc20wbDQ5ejRzVlMyOUxlV1RLdng4YnRzSWl5RTl1d216MHJSQVoyYktk?=
 =?utf-8?B?ZExwQkF6Y0J4ejNvYWpHT3JxcElGSE5WVGU1Nll5emh1cVNuMkd3VGNXWlRS?=
 =?utf-8?B?ZkZSc0xYNjVaNmpLUlRsNGJKakVDZi9LeDJvS0l5RU4yV05TbTZCUUNIdTdB?=
 =?utf-8?B?aEtNSjhvUTMxNTdET05Uc1YvcWVQS2l0ejBGNmRmRWdpN1RYQkNNMWFlU3Zi?=
 =?utf-8?Q?pZRsa8RYXyJjjES0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86be4841-3b37-4bfa-55ab-08de6fa62dd2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 11:01:06.0296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFhsUv1Aye+VGA5mP9z2MWEOWra500hyCGn2TOEL9eYFM+CSCplcFc8rSwOsiBbIOxWjDwYUEwtBFebbTQuz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9809
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


On 19-02-2026 16:26, Hemant Agrawal wrote:
>
> On 18-02-2026 21:34, Maxime Leroy wrote:
>> The rx_err_vq is allocated separately with rte_zmalloc() in
>> dpaa2_alloc_rx_tx_queues(), but dpaa2_free_rx_tx_queues() only frees
>> its q_storage contents via dpaa2_queue_storage_free() — the struct
>> dpaa2_queue itself is never freed, leaking memory on every port close.
>>
>> Add the missing rte_free() and NULL assignment.
>>
>> Fixes: 46d02eeaaeb8 ("net/dpaa2: fix queue freeing")
>> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
>> ---
>>   drivers/net/dpaa2/dpaa2_ethdev.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c 
>> b/drivers/net/dpaa2/dpaa2_ethdev.c
>> index cef819650b..b75b934b17 100644
>> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
>> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
>> @@ -691,6 +691,8 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
>>           if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
>>               dpaa2_q = priv->rx_err_vq;
>>               dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
>> +            rte_free(priv->rx_err_vq);
>> +            priv->rx_err_vq = NULL;
>>           }
>>             /*free memory for all queues (RX+TX) */
> Similar change is also required in error handling path of 
> dpaa2_alloc_rx_tx_queues
ok, you have it covered in 04/11 patch, may be combine this and 04/11 patch
