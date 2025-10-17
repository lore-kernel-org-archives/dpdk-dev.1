Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD799CCD184
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 05:16:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C274442791;
	Fri, 17 Oct 2025 07:16:45 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
 by mails.dpdk.org (Postfix) with ESMTP id 5E8AF40DD7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 07:16:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjgaEgnck0c5JckDRyI3ys8hutXuavT7Eem/3kP52yGgsbNvxKpEjoicmKzGidEK/qUo3APEIVVEc6aUVynkKsuqbWA6UZQ9bv+jMIZipX4gx/aPpjQyIaCOGYVGyyxFP39PE9ymGdj0xa5fiWw7EfOAIK7bNaONacAJm+NgiN70jW6sAMmnUKeBlZ03XXm4+ru2myXSe5HterMe3XfsrSx+Ut8TmzxFUCFryfQIc7qbOP47iVjU/AuEBle1l5bSRaAt5MC+Kk/Eb2hGFteX80dmu3VP1gLdXr8uUBJwA5ze0+8Ey5fZSdVt6ERF4FqPqD86YDkH8ai5OxyV5OwE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO4nCKTekkw7gFCFF1C62PDNjT074r9qdsE23+Vouss=;
 b=Qcoo6+mCBOZ9rAU6BWJBebpLdmW1cdLa9lHHCJb9VEQyRaIrOR2GrtxmpQL4855bHbyxV4BrKL1+8aG41Ob9OYDCGA4TvZc+ERn8kAhYAG/npUmoz++gVOz5On50k27/uqjdtaB0qa78EUCpZfCtP8lT1euiBEuSp1ZLQYsFSGyIg1triH7V1Lg1bx4dQCBJmxAhhdznPYMpstMXquK7MXa0rGDwQkoLHikuHYRkzcrVpSPSPQchT1xt2Wlbpo4ZzeKd77xy0M70Fu24JqR3+BM3/sWUIxQ2Ji32x3I+eASIRpQlvPBKq2VjdNu/+Rrb3Ck4UTbX0mOY0EOEGyD9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO4nCKTekkw7gFCFF1C62PDNjT074r9qdsE23+Vouss=;
 b=XPTVlG3oOc6a+3gJ7Mq1zwAKOhaHoouOQ46Vav91wDCZVX+OZz7l3ZZsUzflRe4fXyOWISEMljnPvh8APK/J/X2ezED9kI9Lj4H+p+L2NZAKYvleVpgFz+XZPH0bbYZ1wIfrxhpbgxUdxFZi4hcP+rW4Jmn8KXmFZDwNtWIUepJg5rMLODSjefyon9M1BtJkxdrmrn9cm27+AarPDYoPpZ+hfyYfrnxG1FQTT1UcvkHRAfum0CcbnOnMnSjBcrdPmjFfBsmYG83GD2+mstfMqZsJJcl6EkyWC9ObmqbAyp4Q6CSXMMw9ix3jpr17Lp75/I2QPYze/hdnMasWuDv3cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DBAPR04MB7301.eurprd04.prod.outlook.com (2603:10a6:10:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Fri, 17 Oct
 2025 05:16:42 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 05:16:42 +0000
Message-ID: <ff7c9aa2-a00b-486a-ab73-fa6b630eac1b@oss.nxp.com>
Date: Fri, 17 Oct 2025 10:46:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] DPAA specific changes
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org
Cc: hemant.agrawal@nxp.com
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251017044848.3269627-1-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DBAPR04MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ebcc09-14ff-4625-d399-08de0d3c5bd1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXcvbzBXQUhPdHNRaHdvOC8xZjhJZnRnb3VxMkFwMmg3L1VBRXNRMlhWRjRX?=
 =?utf-8?B?RGhLM1JKZkRzektYQ1NYN3A5OVRKY08zS0lZM3JGVTMwMFZjVUlCM0lPY3Vl?=
 =?utf-8?B?TlNkajNFb284bjZiemNLeTVrUlBkcVl0OU53dGNDN0RMYll2c05uRUttemwr?=
 =?utf-8?B?WDI5OU5VWGh1dllEdWpvdVRmR1JDYkJxNEhIdVZqb3dxalMzQnVUYzE1ZGJ2?=
 =?utf-8?B?bkN1SGFpRlhTbjVScFNBTEo3VTZMV1REQzd4dXRudXNqRXJqN05lY3VPUXpl?=
 =?utf-8?B?QUk1NGVTeXZMRCtVMEVGUUxxY3ljTE1OVlZCbnBGM2svVzBxMG9vd2Z6RVRH?=
 =?utf-8?B?MksxU2RsUW9uLzZYWm4rZGhXZkc5UTNwelZEYkswUGJzdGhKQzNITlBxWTdI?=
 =?utf-8?B?Nk9qSGNtdmZJN29RN2dFZVJhVWV6RUg5SEdHWVhSaElRZjhVQWV6VW0wd2tj?=
 =?utf-8?B?UFpJWlRPZThFa1VQazMyajFKNEhYR1VVUmtSZUc0SFN3VmJFWUlNRFRHOXRh?=
 =?utf-8?B?RjExZHhPaHlFajdHanU2TXVXZUJwMDNlbTdZM050V29aUmdTWDlXRm9vS2Fp?=
 =?utf-8?B?Snp1TjJuS2hlUjByMVc3MEtCWXdZS2Mzd3JGVldrcTJFdTJSaHhmekQ5b2l4?=
 =?utf-8?B?eGQ3eFY4bmtZNzRWbTZSWUJFZ2loWkRmZ0g1ZzUwdEovcWowUk1SblZkdGtE?=
 =?utf-8?B?ZkRPbXZjQVJjV2MvU2cvRTYrMkR6K2Z1N1BCRnU3ZzM4ejA5WWl0TEswbmZI?=
 =?utf-8?B?U2hoeURvd3haamZBaVhTbTZuUHFTUTNsVEF4eVQzVWNlTGM0d0V1Yy9rNWZP?=
 =?utf-8?B?TzBVVmRmNjh5azI2eXR0SmhtUW9IaXd6MmtpMnFRZG5mN1JuMEVCbGJCZi9S?=
 =?utf-8?B?dkpnWjBBbUVmbGY4NHZWbjB6Y0dOcWE1YXlpU0tsM0NoRFNzc0lEbThkZU5B?=
 =?utf-8?B?U2xsOGErMC9seGUzN1NjMkw0K2JBVG51ckd2UmplU1Y3SjZ4MDBDclpVM2pP?=
 =?utf-8?B?Ni9YeStCdGdHT3ZQK3VBSkRtd01LU1F5d3QveXFiTE9SQXk2QUlOSXBFRkMx?=
 =?utf-8?B?TnBmR1ROa2FlREFwVGNoRTI4WjZmZ0JPR3haQnBiRC9ya3Z2cUlvTUh1ZkJD?=
 =?utf-8?B?Tm8rSEFocEhZaU9RZW5kTGkwczdyWU1NWEVYeDRrbldEL3d1NjFsRTZUK1I0?=
 =?utf-8?B?ZjB1MEduMXk4V1E4MFhtTXJlSFJjRDVpVUZ2VC8yWUFtWjNleEtWSkVUTkZu?=
 =?utf-8?B?ZjZ0NnVrMU5EaU9yMGpTUjUwMmo4amVUZy9CQ0JGcWM2OWUwcmZTL29IVUhL?=
 =?utf-8?B?bHk2V2F2dERrM01taWlFS1JHcG1xVDZ3MmYvbEl1QTJyNkhWamFwd25GTDFD?=
 =?utf-8?B?TGV5cDVvSWFaNC91YmpvUGZxc1pWdUc3eWFKR0creWZtTjlUNG50Ym9SWUhU?=
 =?utf-8?B?ZkorV2lJYnFvRlU4RS9wK1NJWTFtcGozenZjRThlTk5Lb0t3US9oNWp0SE81?=
 =?utf-8?B?aVpoNDAycWVsaXkxQkhud2dPQlpYQmIreGpGdnE0Z0F6VGNMcStjdUJtUTNX?=
 =?utf-8?B?MjJQUTR5YUV4TG5aU0dCS1BBaEQ2UjJqeDFrL3Q4Q3RvbkRadFdVOTJNMTBm?=
 =?utf-8?B?d3lnUmRNUkR5aGErSEEwbmtkRWRyc2ZydXlqU283Yndjd2JqbDQ2eUd0aTF3?=
 =?utf-8?B?WjRzSjJqTW5KSmcyaWNoRnpVODBSN1lia1kzZjQvL0F4N0NyVW8xVW9acEt0?=
 =?utf-8?B?SzZoMmJtdGFKSEJGTWRQVXdjNVNtRHJKczl0bDlrT1NuVWRsamlmajg4SVpJ?=
 =?utf-8?B?YlQ0TTVJYkpuc0VCczRaK0FyV2ZrVTdCVGZhWHZYK0JZVWpuT0w2dUhXRERU?=
 =?utf-8?B?QVpuclNSaUQ1Z3NLdFlWSm8xMXNCVXhvQ082YTlvTXU4dmt5L1hIZ2IrZTlQ?=
 =?utf-8?Q?QXZS+z8aAcPKIu/dPpv4OLICP5Bg6sFJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JkSEIvUlpSTHkwbVUzUEFaOERpbTkyTGRienhqdnlBUmVTSHJkK0xBZnhl?=
 =?utf-8?B?MTBhYkdCdDdJOUdnbTZrMjNvZHdWZWtxaFhKT2hFTzJZSkJZM0w0anNvSUkx?=
 =?utf-8?B?SXdpWVd4Mncrc09tVmxQQnp6SFJoQmFrZWJQQmIrYitSbXd2SmpkZGNVV1Bt?=
 =?utf-8?B?cXkwdXAyTXpSOTg3Qnl6VGErazI1RnJwalBrU1FJQUtIYlpDZkNRSllTcC9r?=
 =?utf-8?B?b2hjWWFOUVpLYUl5UFBrME9CbXpvV0JUNzFNbUltZjZON24rbWs1L29GY2Z3?=
 =?utf-8?B?b2FJdzJwOFlTZXhieTRPeE1Cb2FyVzFySFNTbERWYUIwTURSRUcyaFNBTVFW?=
 =?utf-8?B?Z0d1ejJXajNrK041V0pVdHlxcWo0c1g0V1ducWc0OWNsN2dETGFUdFdBVVpj?=
 =?utf-8?B?MHFoOTQ3dXNLdDUraTN0VEZTb0ZvRDJiTGNqREZRUWw1ODRIdFBUdHY4QURv?=
 =?utf-8?B?YStlekZvOUdLTVpZNkFtT0EwNXppQjZ4UndsZEl1OTNFWi95SzB4ckIwLys3?=
 =?utf-8?B?cjJpelJtZG9YVlFGYWdza3orK0xaZFFucDhaL0FrdTVTVjFSVEx0d09VckZw?=
 =?utf-8?B?ZzM5Ym1EeFZRQjF1WWhiV1AybWFMZjFYVUdYTTZ2Uzg4QTJ1YzI5UzFQNVZN?=
 =?utf-8?B?MWdGcUFrQXcwMFZJam13U1pHWHNWTklrOGlibHBjdzZhQWhHY0ZWTFovbUFR?=
 =?utf-8?B?bDQ2bWY5Z0ZjbUVsYU9Bb1Yxb0NMRzFnTGpXcEJBTUdsNkRMNVZMY2pyTk9z?=
 =?utf-8?B?MTZUZ3VidjBhTThsMzc3VXlpdHFaaHhzNmtCNjhqUzNwSktmSXBMSkZLRldF?=
 =?utf-8?B?enBqUFN6WDFycCtHaFJ3UUtuelR1Nms1ajE1RFZnUjJXVVhPeGVLWHZqL2pN?=
 =?utf-8?B?dFlUV002MjNmTi9kV0YzekZQVDJNVzZzeC9PeHVqRzNra2lsNTF2RmNOR3VF?=
 =?utf-8?B?YTVJQlo2Tm1kZU9IVDhsc28xZ1R3bnV0ajhXK1FpRzFtR0dZQ1FRMStxYmNo?=
 =?utf-8?B?RUVjOGhvdHUwMHRreGdCMUtLNHJxQnhYMzFod0FGZC9vUE5Ob2N5TzBCaGNi?=
 =?utf-8?B?SGFEUHAzK2dZaVBRdldtR1QzQ0pnUWVRRitwUG1LVjgwQys0eXRhbHdOYmFi?=
 =?utf-8?B?dy9vZVc5SXE4VHAxaVVSSURaUWE0RmpCUWJCUHJ6Z0FaNElqZUZTaG0wRlg4?=
 =?utf-8?B?bW83UnEwMWpuOFEzcTRseDl6aGpYdnFQdERnUzRUYmNwUENVZGRScFNUWUsr?=
 =?utf-8?B?emtjZVhEbG5uZTVxSDJmRUpiVll6WTFyMTJGN3JpbmlWRGVIUDZFaEhVdk9q?=
 =?utf-8?B?eGVNZ043VlJnR0xraEhHVDQxOWhKS3pqaVRacmlkTkdMc0FqallWaTVucHNX?=
 =?utf-8?B?NVZFRzRwTVJiTlRyZTJJcjJLR0VOa0lib3FPZjFNV1dHc3BLOXhPUlBtQ3Fl?=
 =?utf-8?B?em1Ycm9jazBxZHJFakd0UStDdFlGSWdsOXpDWVJRUjFZd0MxbXUzR3Z0dERi?=
 =?utf-8?B?ZWdBcldqdC9qaVRMK3VYZlFxYUM3eDFmaHU3YWpRVldjclR4c2tMaWZXeGtE?=
 =?utf-8?B?aGlBS2JsNjkzd1IwbG0vb3VVTHR1MStLazVwWFRYanJ6WU1JcWtOcmFVNXlX?=
 =?utf-8?B?dXB0cW9kZjFySkIwNVFLcFNOamZ3QU5IUzdaRmo3SVJpR1hvOFk3ck9OUjR4?=
 =?utf-8?B?OStVYnhqMnRFb3Z5K25PTU5IeHpOWllJaDhVNnRySDlXTnU4TVNkTFZTeTBF?=
 =?utf-8?B?L3k3T0tPbHR5MTVtQjZZaFJjaERnVXVYZUpUVlp3U0YxRWpneGNlczFDVjlK?=
 =?utf-8?B?K1YwM0xZbEhGR1JJcEJlZm5RaHdTMUNRODE1TnZ6dzkyMUpXcnh5V3NicURG?=
 =?utf-8?B?dERrOWhLTUdQaEZEQ1FHdkZmbEpNVVlrVExaeUpKRDZCN1RUeHp1THEwaito?=
 =?utf-8?B?a2doTmJhcTU4dHh6L2FXbkhWanNvRllPUVFHSEs1cEtSQmpUcVlHWC9vRmlP?=
 =?utf-8?B?ZVNVeFpINzJKOEN6NUt1c3pJcXpvZ21BYk95eGJ6b1NTWkd3Tm1IeWl6RTBx?=
 =?utf-8?B?U0Q0eDl4TVV2eHVQVEs0M0J6WWk1NlJERGhBQ2tZOE1RamRKOFRhNHBZWFJC?=
 =?utf-8?B?Tk1iMHVxSDA5ZG56ZzJuZEhuNG1BY2JaZVBQOU83QUJmNDVlSGxBdnVlamVZ?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ebcc09-14ff-4625-d399-08de0d3c5bd1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 05:16:42.6681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUUYLJwt0SMl7CSQDDPPcrRWE8YmLQ0g8yRgSk0H1GocF3ES48ORvHVS5cGifmNj/ormW9Gquh1G994oWZ/E0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7301
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

Series-Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

