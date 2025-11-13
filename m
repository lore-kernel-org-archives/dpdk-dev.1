Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61466CD5BA3
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 09:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96C40402F0;
	Thu, 13 Nov 2025 10:16:33 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
 by mails.dpdk.org (Postfix) with ESMTP id 9BA4C4003C
 for <dev@dpdk.org>; Thu, 13 Nov 2025 10:16:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOLQfSYKMr/cA5OGSBeDr02aZMQ385+/Asnm6LaCanlSWUGy4tBBJHwK7KMUAYuN0+wO5pvfdbv9naPeoIJ6pt3WIdTpT/iIhkYnpXYBb45tKg79c83xsHFh52dO1GK0MoLIdEVCQu1xK3H3P2ZhhzS7SpTZzilUKjA48A8wiHD04TFOBiNuKDM2HtlDncpzR8dIV+12MYfKplq+GJMIs2AM4n1443GtUfTLFxqVSmrywJunH/6FWXbr2k2TppkTBsIyHMC2kDD/1Zadr7viizYJFORUQGuM5f1Jwzy3rrF3vNtLz6sqopXHtbd5QFPs0V8s11tuHWDDp7b/Z2oTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOTwsrueW6C9hrAtr7fgpmlwzTmF/iJRLqWSgvomI34=;
 b=RnQYfWq/b5i3lE86vKLd4WXU14tM4BZLBgqYufA6pP5Zif23FwtAQmriM5/7LXKjoq2cNFWHnfQa0cTEwN+wU4h8jMp+F0/w4aRX9+S91dbyijFbSP/8jke5nke2rF9WvDzA3O2sjYRUW9kqeb7bT47oDRklegnFDhR7Upa6CM1qnMW8mxUWpMcMkwQ8leuBU6EKmpFQpjh703atpxgrtOxGfo0Was1sE4Lxs/26V/PtyVvZPLoh5g+Z6zehHQfbQoHmEfcQlUnElB89iLqk0R63u+MHPjJf5Kz6gZfLbJChdnVTARHpfiPh4kykn/oRsEDWMOuko+eVgtJ983oEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOTwsrueW6C9hrAtr7fgpmlwzTmF/iJRLqWSgvomI34=;
 b=i63fb2MPc2vglVLnT18X+jYBlUgD1Nqm++HU+/dzoUSFiScGn2otD9tXsTw2xzfPBfJL+z8lIH+KPbEiMcdvR5bns594tmReE5T+apVubeFUk82mE01DlOX6bxc25JUfKiGbZpqoJA30PqSRDFKT82jvC3q/otOy0ZSDim74d9IGM8PAnPVgV+3v2UxlTdzXsi8+0aPGHk3fHbqFvcKbsRTWKazmmXD7SEFO79Jo2KOJGCMn/tQOAL7JIRlUQN+tCyxN+OXCBuJ+5KQXoOAux3LdVoRhVbzdzHB7mzhmBXnI1zCkCjxE+c9jW/nxEywL6b1HODx4oeczSpbrtqz9Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:16:31 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:16:31 +0000
Message-ID: <789c9484-a0d3-4d18-86d4-b0cb02c0682c@oss.nxp.com>
Date: Thu, 13 Nov 2025 14:46:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Cleanup rte_dpaa2_device
To: dev@dpdk.org
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251112091049.2669481-1-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: c5093019-c7c9-42fd-c544-08de2295551d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE0yMHI2ajZoS0Z1anJWMHNwMVJPdHZheFFBdkRVN01XcUNVS3pVWkhjZVo2?=
 =?utf-8?B?OHZxWXh3MEF4RUUxRVc3ZkJQcmUvMHNoTC9iWEVzd0lqR3lRQm54Q2N6MnRQ?=
 =?utf-8?B?K1l2TkE3TE9LbUpZdmNUbkFqZHRZSTFFSkg2K2ZXUnZPNlJuQk5YWGtUU3Vn?=
 =?utf-8?B?RG1xeFBsdWIxOFRKOGNvdTJ1eWdZS25CSXhlUTBxbTRkQ1Q3SVdadE90NEU4?=
 =?utf-8?B?RDhrOWlOQWZBVXBka3IzWGhFWGg4U1didlJpRDVvTGpKNEo5dTdyVDBqMFhV?=
 =?utf-8?B?eTREc3dFMTJsTzJiWk5wV2llZVZWV3JVZUJMcjg4bkZ3SytlcVFMWHQ1clFX?=
 =?utf-8?B?cWozL2FoTFNSZVNySGMwNmNOUGpiTDJEWkZNNDdOallHeTg3V0NBOE9FcVpV?=
 =?utf-8?B?NmhITEEvSFZwWDdzRXR3K0I5RklXMFpDYzc1SmkvSllWcU10cUtXY3lza2RV?=
 =?utf-8?B?SmtWQ0tRak1Gd0dvL0FEWnZzOTRlTjZzOXhkZmFQR2tJNXplL0ZHT2dqV0VQ?=
 =?utf-8?B?U1k5S1hmeUx4a2F6U3o0NjRrTXI0bUlrVndTRGhFOWJlUEVYUnZHVDMwMGVX?=
 =?utf-8?B?VDc5ajlURjlydktvczJ6anh4amI3YTNKY21DcVFFeWxaSmpLMVdSV0pFLzBk?=
 =?utf-8?B?Q1FXSkdZck9ERHVlZkE3WkhuWDZrWG9ja09xcVZ2SDE4RkpnNnA4dzA1M2Jy?=
 =?utf-8?B?NDlRYzRIZldFWXp2ZEhYeVV1R3FZREp6V3AwRUNzbEJoRkZudTV1U1kvN0FX?=
 =?utf-8?B?T3k0Z1VZbGUyUXZhTWYyaXVJQnVrdUtEaVJOS3R3YjZIQVZqWUJZamZEeXRJ?=
 =?utf-8?B?NnErTlgwdTVYYWpmenlmczU4Z3Y2VVdTd1JNRzRncHUwWUFWRFUwSlhNS3lx?=
 =?utf-8?B?NTNpaVFFNzg4Z2dkQklNMXo2VVIzVktyKzYrMGlhb0dGNW12bCs2Z3JoSG4r?=
 =?utf-8?B?NSsxb2p1NDRvcHBZSzRnNm43djZEZkNXNmV6dzBtbEIzU3plSWg3WHFtNG81?=
 =?utf-8?B?RXJxR3M5NnQ2eTdPdWhUQVUwcHJISUFLUzFiUmUxS1RCcUUyallIZXZ1T21J?=
 =?utf-8?B?TUdiUHlJRHJ5RzJ6djRoVXpxbmcvdnlMUk9oUGVkU0Eyamc2VWlSNHdMb2V6?=
 =?utf-8?B?QWdxMUpQUnBJdDN4NXJ3YWw2STR3WExDTU5oVmNiRW9yUmZDVHNoUGpyNVFO?=
 =?utf-8?B?V3BvaldINDhyV1hvZENZL3QvY1ZhdEhnRWxOa1h4aWZaVnRLR2VoSGkxMTUw?=
 =?utf-8?B?eDljODZRY2l2RkZ3TWJneU5lMjdVTFBOLzhXUzlCd1VrdTJoWDZTeDhpUzBs?=
 =?utf-8?B?K1JDMWtVNlhCL3JGWEJSTllqb1Y4elVjSDFJYW1uMTlaSTNlUG05SFhIdndQ?=
 =?utf-8?B?VmZIT1MreG1iS2Y0aFZSaEtxamwzcDNxWC9zR2NhTUxuMmpoVmdBdjNpZzVE?=
 =?utf-8?B?R3RLdGFBeGtlcUwzYUhocXU3Wm9aV3UwbG0zVTVrc1IyTkhCYy9QUlZTUXpi?=
 =?utf-8?B?bURTcHRxaVhRUWt3b2NmbG5VeHE4OHVOK2NubTdlYUxOdXIyTXVKMTM5MHVH?=
 =?utf-8?B?Mm5wYWU0SFlIWnU5RlhNcEcxZ2E5WDFlK05xWHY5QXpMQzlPSW1oQUgwTUFa?=
 =?utf-8?B?OUJZeEhrUUZTMXJKaklnVzJPZ2RqSHVKbElEMGpwMGdOZzJGeEZQNk5ibEdS?=
 =?utf-8?B?L25GN0JQOEFMcFFLa01RRmF2TW5pSk1PMFhXUm1jcFlEMGNhcG1mTmZta1hM?=
 =?utf-8?B?a04vZkxzdDhqNFUvQitzU0lHWG9OQ3U0SnN2T3JkUVdGelhaL2xHWDFNSUM5?=
 =?utf-8?B?VmJGdEdVbCtkT291c0xsNWo5ck1TSVcvZmFDdzhnemkycVU3d0htcmIyNFBK?=
 =?utf-8?B?a05IUHpiUVdFWmZCV09YL3U2Y3FrMTFHUGlBUTBWSWhkU2tJdGNwS24vSXlq?=
 =?utf-8?Q?IMqim4A/inlZ6QsW0Z1IkVXBlBw1+XL8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVVUL2VCY0xvK1REdUtuU0gzZ043SVMxN2hmcmhpbE9yN3paMjA2a3NQRURR?=
 =?utf-8?B?bklvWkRqSVJYTVJpUXVGVVF1K2N3MGoxWFU5WmRhcWdla1BUdDFSQ25KTkRD?=
 =?utf-8?B?RzIyMm5lTmJXRU80Z1BMZEJNaFE1ckVFbzBjOTF3ZXJUcjFlV2hWYUE4MHBk?=
 =?utf-8?B?dWhINVhwaExJMy81V0s0eFV3WHhMQTFOUEsyL1U0akoxVnErSWE3REZFNDRD?=
 =?utf-8?B?cjkwaVk2a0d2Y3l0UnQzVUNleDh6QmE1NjlYRVdIbkplSnJsZUlpQ1dvTG41?=
 =?utf-8?B?WVpydnhDYmJlQ2xXQjRieDN2VTBYMk04UjVETTFiRDAyNVkwMjlRdTJaYU1q?=
 =?utf-8?B?U05QODFpMXM4VGQyMVZxdmNXMEZ4U3E0dnoyVUR4Y0dySjU3aDkyYStmS01a?=
 =?utf-8?B?eDJlM3o3VFo1RlhKQjJwdWpHTmM2TitvcjRqT3d3clZBZkw5Z21wOWNaeDRo?=
 =?utf-8?B?cjJKdEx3UWh5eVVZdnVsNmlZUnlhblVUTFBMcldORmdqaWNnYTBxSGo0N29L?=
 =?utf-8?B?aFVWdmZtU3NCazJxRVFmVzRaSWNBL0VDOUZTekY5cjNNSlFDWTZhajRZOTJI?=
 =?utf-8?B?MFBFNFhPRS9FaGU1THFLVHBjcCsxYUVCVXVKQ2YvNUZJWHZPMUVGUmxLTTFx?=
 =?utf-8?B?Ti9jb2ZiMDhDdE54bTVmVVNVRTg5eExFbm5PT0NyU1FMTm5iU3YzeitnbjBD?=
 =?utf-8?B?SC9aL3hSQ1VxcTlYODZCaWlBdjZEalE3UCtabHIzaEpOYm9rdHpFMElxcFIr?=
 =?utf-8?B?dXlGalp6andKQy9TeXJXN3dVTG5TQloySW1ucWx3VDlaL0lhQUROSFgrL1NB?=
 =?utf-8?B?OEN3QkZCcnBOalJOc2JoSGlYWUN1SzdHdk5vdzdKejhLbTlDaXRQTVByZWlL?=
 =?utf-8?B?N0QvQVlTSzFDKzJoZDhsMlBLMVRVUElTbURFQ2U5ejhYd1gzUWtVY3hkVXMw?=
 =?utf-8?B?Y3lxaFBVWkgxaDIvWXhRYzJMcnc4N0lPVVBOVFdwOVVnRUxRMkcvOGNCS2gy?=
 =?utf-8?B?T3phaFkydU5ibm0wdjljUEpxMUE4SHpyTHNKaVIyZWJ0R3d1eWtDMVhLak14?=
 =?utf-8?B?MFRwakxDakRJazFBN0w1T2s2YzNIQlBULzBNMFFEWXg0VmxHU3JIZi9UWDRm?=
 =?utf-8?B?cUt1c0dDZEJFNXRlbDhudEtlQ2VPMjNpYmt4MUZ3QUFPT0ttT0pZZEZqUklm?=
 =?utf-8?B?T0tBM3JGaDVFYi92cW9ncXQzTEp0VUFRZUh2ZitHNkl1UmtUVHRQU09JbU5U?=
 =?utf-8?B?bzFtUXpUWFpqektEY3FnOTMyb1E2Uzg0Q0ZpbllMdTNycWp0dFlaaWUwWUxU?=
 =?utf-8?B?YkY4THJvMnozN25uRjRkakR3S3BacEI5UVVTT2dEQ25NUFRGNDhmR3ZhZHVD?=
 =?utf-8?B?eTFNZzNYajRoRmZDTmRQZnJONzdua2VoTkpuL2tRdFYxTDg5NGlNQmZua1la?=
 =?utf-8?B?SXVXY29FN0ZNUEtZUzdFRGZWUmRNQUE0d1lBaXd2VmcvdkNoRXZ4eUNHSDRD?=
 =?utf-8?B?RHZJM1kzR0phSEtVS2Z2STRMaWZsOU5Hb1AzR3VzTldLTmtyamhLQTFZYklz?=
 =?utf-8?B?ZGRSdEJabHVST1R0dkQzWWxMNG4yL1NOak5BcmNncHN3d3ZsZ0ZjMDBIZHZr?=
 =?utf-8?B?eVBuU0tWa3FoeG5jekhCR2R5cGpsZC9wS0EvKzlyZXFUTEQvd0pBaExHcFpQ?=
 =?utf-8?B?djhlNkcwNVFUL0VKZHE5ZDMzT3g3MWNTVnF5N2cxa2xiamticXM4VThSUVRS?=
 =?utf-8?B?L0NhQmFLeEQxaTloRXhPT0ZPUWlzVTQ0VWZJT0ZwbFltRXhKbktSZWFLNEZ0?=
 =?utf-8?B?WXRmUWZ0L1IvMGdOd1N0QWNXUThkNXZvSGQwS3lFSnZ6SzRZRDYyWWFGUDdY?=
 =?utf-8?B?aXpGb2EzdVROWHZxQ0Rna0lmdXFFWmFIUy9QK1d3R0hPV3pYMjFBQzJWSHJo?=
 =?utf-8?B?S3lxNmxsL1dKUHNKVHEvV1o1Q0FxK0UraS9mL09EYUt3anpyRVovUi9YS282?=
 =?utf-8?B?anZUelk1MlgwNm9SdEV6QXF5Qk82SDFqVENNcEpHR2ZVT0hFbEJQd1IyQjNY?=
 =?utf-8?B?MHFUS1RvOGRkY01uMGlQSjNxNndJTzF2T0syM0lrQ3ZNK3Y3ciszME1QWnBa?=
 =?utf-8?B?V2U3Rjk3cnVtM2NkQmgxejFmcGFJbkhiVmlqaU9qUm5lRDRpVkh5dnhjVk94?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5093019-c7c9-42fd-c544-08de2295551d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:16:31.0314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI8Dtp7LSpWVIAhyrw3gJW/XG2kn+trRgzSnpCQUnAUPKbf8lF7cXVK/2wNQz3VRYjui7thHKn5hMZbsVLDhbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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


On 12-11-2025 14:40, David Marchand wrote:
> The rte_dpaa2_device object keeps track of a device class object
> (cryptodev, dmadev, ethdev, rawdev) which is a layer violation.
>
> Make use of the device class respective infrastructure and remove those
> back references.
>
> Disclaimer: this series is untested as I don't have the hardware.
> I only based those changes on look at the code and other drivers.
>
Series-Tested-by: Hemant Agrawal <hemant.agrawal@nxp.com>


