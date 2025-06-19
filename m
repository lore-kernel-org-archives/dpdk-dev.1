Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129FEC71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 05:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4948F42D45;
	Thu, 19 Jun 2025 07:44:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013010.outbound.protection.outlook.com
 [40.107.162.10]) by mails.dpdk.org (Postfix) with ESMTP id 1B25B42D45
 for <dev@dpdk.org>; Thu, 19 Jun 2025 07:44:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEFQuvE22zHs0atAIIHlKmfFmFaiZGpRIjzU14Kr7xnnLeNbduzgwvbQEJISeyMM5hL0peMmA2T7046qJsKq0jXAsy25nOArLJ1FlpK5JHPdUwCWdB7sLJqf7MaQyVAsQr8Ac09Y7iiRwEIiJM1Cq61iJ5A6iMwM5dMHB/x0GN4KZSexFypgjZGmFjd4w1vBbG8WmUwwcWkoy/KnjCSV2cIZCUfuvVvg4y6G8jre2NkZTd8pArCSusXXRiu5dspCGf6l1lBBS5qML7WZO+4IxkfVCsflX7l/M4UpB9ouk30UcAN2Z0w+VKTFcAKHveyALWRwoGp5YI79rMMLX2Xecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lu+4rgwc6bUajVdRCZH92IlbAnxyZYNW11fdvTNdHA=;
 b=hBfpH3AuZKNGxglBBOMkUPQHVUjDZYEM632sEJGYpRpKF+B38xWE7i2zztbkAY8hlT3SPMHgsUWkxJEFaLmf5/UPBWxYQxpZ9UpJStk1UuBLMykf3fRx+4WGz5tiMgbsCdi/YguSXWVvLTXhPAnJcR9lk29XZghO1Jvh//6q2lCK/5wmU8q4dY37VIGY6FVh0Z9zbbg0/o2EF3pnQhEV+czzDxejMp+enV7oI6Nd8NH53FkQMGWiNouP9i7Y2l4lLuOwSOz7ZDlFheWSY9vyZFh9kupqNAKkqirl3nukUq9JMG0XeubuIb3Y2oQW+1YCueyMr7Oxb6ofVCqbJ0xhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lu+4rgwc6bUajVdRCZH92IlbAnxyZYNW11fdvTNdHA=;
 b=DZrfd8QEkikk9a3Mj69gVey+ZRbKrDJhFrcgHEYE3CqeJtoU/fFyB3rHuzLGvxy/VMduIUNKfdTiSbzVYPsJlSJmvdOeZh0fMH6bQmVjyX4qLnNlqZ175Urqht41miUzVolz8ucTF1y1i6gGpOX184w5TgXNHjahLAhLe/xndjxrRJpoPReVAJMn6qUqceBnv1Zc4/88Z55fZxGlukvnEcYEFvNvgInvGxntZRRYHI+KDKYY/++zqVvWgRwlws8QEHNw1zx9NmSyla9d05uOtasNUFxTvsnwQunMsVvCbqXiOM1RHzsRcWfy1z9CHTkoTkqKeuh+MgBuP3ftFfot2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM0PR04MB7154.eurprd04.prod.outlook.com (2603:10a6:208:19f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 05:44:05 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%5]) with mapi id 15.20.8835.018; Thu, 19 Jun 2025
 05:44:05 +0000
Message-ID: <641877ac-be17-4d06-abc3-55d42749eb32@oss.nxp.com>
Date: Thu, 19 Jun 2025 11:13:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 00/10] DPAA specific fixes
To: vanshika.shukla@nxp.com, dev@dpdk.org
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM0PR04MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b18d5ad-2d4a-4727-598b-08ddaef44d7e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXdkQVA2aU0wUEozSUEvdnptYzQyS3ViaTlDOFlqTHJ1M2RpMTltblU4Qmov?=
 =?utf-8?B?alJwazFqd21BWEZEM0paSnZla1FLVnpFcXpaS0JzZGU2Y0V5aEgrMFUvQTlB?=
 =?utf-8?B?Q055dGUyYVR4aTRtVlhKd2NiMUE5Njk1c3JTUU5RZE5MRFhZRUxCdklVQ1gv?=
 =?utf-8?B?MVF0WVQyUDErb3dLNitmcmJ3NnNqVUJrRG1GYzBLZnNPdUU3QVdORmlITDVD?=
 =?utf-8?B?ZTBuclFpeWxHSnNCb2orbTN2dVNCZ2ZJdytPYTZVdUp1T0lGL1J6M2ZBYytx?=
 =?utf-8?B?OHJZWjg3Mis4ZHZUVGZDRjdQM3hoeHdXNjFiL1V6Zi8xczRFN1BadHpXZlJs?=
 =?utf-8?B?bjZBWGo2T1o1THZHb3E3YXkyWmNJdDRxTnFGaUlxdFl1VC9PZmdtU1ViTEJD?=
 =?utf-8?B?MkJveGl2bkU3MHFzbUFiYVYvOFZZUzhROGxnbVN6cVlqNkZKR3JaN2tzcFo3?=
 =?utf-8?B?QlN0cTZkYUs3YVY4THlLbiswN28xbUJaOGx1dmZQK3hRR250eHk4L0dSSlM1?=
 =?utf-8?B?RU1iNEsxcUFydXl2VEU3cFRtT3c5OFZSL29iQlhVT3puaXhoazIvNnltK0Vq?=
 =?utf-8?B?QmhTbm5Od2ZrdjNSbEU4NTRMbXpqdkxTOW1ZUXMrYWZJVnIwc0VacWJmOEc3?=
 =?utf-8?B?RUFrV0RnOStLbTVHNjl3b1R1V3p4NXh4NWR0V0ZFKzR4RDNPNGdob2lqRGRF?=
 =?utf-8?B?dHJRUzd0WkNwNktLWnliTzJ4RkVDTFNaWUR3bnhQdEhjcnVlZ3h3cllVbE8y?=
 =?utf-8?B?U3ZwdThLb2o4UnFDdnN1RkxhdVV6U09Qc3BGcTNMMEpsUTdOMlVPUjhRYzRt?=
 =?utf-8?B?TGZ6YUFxV3ZvNzI4STE3NEVxbFMxMUU3bWdCOHVjcjhOajF1UHAzbU9BMUkx?=
 =?utf-8?B?c0ZOTE00ZXZkeWZKMVpzZ1Q0TGNiY2dBT2pPTjBsaHNuS09HWHAxWHB4dmdE?=
 =?utf-8?B?R2NwNFI2RjhIVjVnZG9WT2NsZ2l3OU9oTU5FeEFaKy96QTc5cFJqNEJldTNu?=
 =?utf-8?B?TERhSWtRa204K3NPYjNwS3NRVk9OdzRmMklVdytld2l0VHBTSjNoaE1DZ3NV?=
 =?utf-8?B?UlJxZFhNM2RNVmk5V045akRWV2NZVDYzSWx0R21OcnppMlVzKzE3bzArZXF4?=
 =?utf-8?B?ZTA4UGYveUJBSyt1R3VxYVlDR2RNSXJaMTgraGd6Ny90UUVtdDI4WFlTME42?=
 =?utf-8?B?ZElPdDdTZ2h1VHViOXg1Rk4xekU3QVVnZk01ZitNcW9iYi81aEYycXBwTXow?=
 =?utf-8?B?RjkvVEZOdTcxSE9WZ0U2OExhTXR6MUIwMW5ZK3hLVkU5NU9JUnVZR2xsNjhU?=
 =?utf-8?B?MW5nVlZTc2NVT0ZpbVNqNWtBQ2NOamZYK2hEeG85bDZPenQ0clJtV0JYbC96?=
 =?utf-8?B?STE0aUJwMUpLWTNEcGtGWG1HdmRLZzE3aDYzdXZrc0NxZkdTUHFBWDJMWGp4?=
 =?utf-8?B?dzZkL2U3T2pzRVpleVl5RkdUSm5MQ3hsNVFibDNOc2p3U3BhaVB4ZURMVCtw?=
 =?utf-8?B?UG9neDFmL1FjSkZFK2VpVHRrVzM4UWlBTGhRZlFXSm9WR0xpYVVBazFBRG85?=
 =?utf-8?B?SVVkR0dQUlM3cGc1SnBZRS9MNFFqOS9WQ1BnQjMyOXV5R3ljZ1c4emoxdUpp?=
 =?utf-8?B?U21aZVpJQzFEUERSWlkvU2FLRERSNnBJWW9vU0IzNGd3V3RaTzRBSGJSaEZa?=
 =?utf-8?B?em5UbVYxTWNObjNEUVFsZ1FlcG1SL1lZQy9HNGRKTllqbEJMUytxcWNFRCtF?=
 =?utf-8?B?R1hXTHQrWmZTVzVPVkJpU3pZSXl4MHUxOGNoTG5NTndlaGZoUXRkaS90aFlv?=
 =?utf-8?B?eno3TzdTZWZsVm5VcGtCUDF3RGRPdnY3UktwUGlHQjU5eU0zYng5SXVCZXhi?=
 =?utf-8?B?SVdIVjR0ekhXc20zUEE4TktURUg3Q3BNajhZUmIrSldQby91bi85azJ2Nm9E?=
 =?utf-8?Q?YV2q3IzmXgY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGFuWEhicXl3NiszbXBhZCtGcmQ5YnJsR3JnV3lMYm12VUxRZWo4ZUoydmdq?=
 =?utf-8?B?VmVGNWNpMmt6RTFwbm9zVXp3bTBuR0NBcUo5QnlHOERubFBTQXFaM1ZLWWFF?=
 =?utf-8?B?S0dEalJVSG1RZUh4NTNjOWVFY3pyRm5ja1JzUmQ4WTFDRWRuS3ZZV0t5bmlU?=
 =?utf-8?B?c3BKZGh6cmtsb3RGdWVhTFVqWk9nTE1UMm5nbjl6MDRxVE90TkZRRGhIL1BI?=
 =?utf-8?B?Mmx4K3RyN2d3ck1VVDNnTGpGR2MzN2VSdlArVU15Y1hyTFlTV2tYY3dnTStD?=
 =?utf-8?B?UEdIbVpEZlZpdVB0VHVQeUdNT3FocVVZQXhDa2h6K3Iyak8xNlo0VFVWRzZV?=
 =?utf-8?B?TzJueXVUaTcxekJIWkUvTDg3OVYwcXNxcWdMVjZGTjlianZ1RkNxT2pDWnJp?=
 =?utf-8?B?R0JXREk5Rzd4dzAyUExrYjNvaEJSUnNZNHJwcEZOZGZUaUI0MUUyQjhVWDNW?=
 =?utf-8?B?MVMwMlN2NU1sN1RwQ2EwRmNxZnY0TU1wSTlSb04zWUJPNE40bHFhWFNXeXFT?=
 =?utf-8?B?YmRZM3ppVGJGeVI0d1p3R2ltZTVIbGlsYVJIYXJlY01PVThPYWxWbnNHcWZt?=
 =?utf-8?B?MG9sYWVJb3p3cy85aDV6VEk1SnhCRjFzMFIwc00wUksyOU92VDAyNlQ3Qlkv?=
 =?utf-8?B?MnhXMEpmMHJsNDljUWY2ZjFNdEtSY1UyZDlGMEs1T2kxQjVYWlBZVUtWUzBJ?=
 =?utf-8?B?bE15VTcyZGkvNXQ1Ujh0VjhnVDNFQVVPTWJXZ2VNd2g0ZCtIWVZ3RzVMaGwr?=
 =?utf-8?B?OWR3WUk2NC9aNzNjRTF5K0pBVjF4c29wM1Q3QTZIam0ydFR0dVdBZGdaT2sx?=
 =?utf-8?B?SG11dWdVRXNGczhCaGVEWXpJOEMwU2kvWVdlU21Ga0JBTHM0eUduZjFZWk9X?=
 =?utf-8?B?UUN1Unl5ZHM4R3Y5VjB3K0pMTTNwYUs0RVVhbldXOWJ1NlFNNGhlMWtOL1Na?=
 =?utf-8?B?dHZPMS8zcDBxMEhUa2pKRmRNOUpIV21LWU9MNnc2YUdsRnVNMm5kclJHRDBZ?=
 =?utf-8?B?bjlsUTVnQmgvYzA1THNXckdkSEdrajN4YklLR2VUdWd5RkdnR1RlNmt1WVdI?=
 =?utf-8?B?YmtPOFZVNk45TVhvNkx1citEUjBzcVpYR0dScmRnVTFzU1ZscmEyZnYyeXNh?=
 =?utf-8?B?dFRtUXdvaysvYjJNbUZsakU3TERnalROWWhoN0F0bEpEaUt2eENzUzlOdlJX?=
 =?utf-8?B?UDkrVjlJTGdLN2w4L3N0Q0NpTFhXdjRreGtHM3kvMUY1NXZ5VVAxYjdaVWNh?=
 =?utf-8?B?TXhHNllrQ20zQzhWOEhiWVhXeGZ2OU0ybEpyNEpyVUhTMFQrMXNSRGE4RW1U?=
 =?utf-8?B?N216a1U4NjlkVWh1N2F1b2N0cDlmWTV2Z2N1T285TXppY0Q5MTVBNkdRWmd3?=
 =?utf-8?B?M29SU0lScGJIOTZxWkpCc2UxZityYlBsQmdHL0xwWGp1RG9DL0RoZHIxT1l6?=
 =?utf-8?B?VjZ0eTdPUXd3NzZHSVhreTJWQnVaL2VJeDR6aTZtSlc3aXN6NXliaGhBV2Fw?=
 =?utf-8?B?WGhKV216UGc3ZWQvdmR0S0VMdzBkRGZpcENrRHN6Y2VxU0JDQUd5ai9FUU01?=
 =?utf-8?B?dFZ0ODBQTTRnVy84VWxDWC9USU43Z0NLUlVFdkR6VG5yZDRuYmEvaUF1VUdL?=
 =?utf-8?B?Qm95MjhLcXdDbTQybkh3bkRZQnlRRHUydjVBNEg2NkJ4VnZKWlFkZ0tmR1RG?=
 =?utf-8?B?UG8rU0o2NTdBa0VwV1BsNzhUMWJMZ2x5ZjNIYnJmTlVpdjRSWmZUSmhMT2hn?=
 =?utf-8?B?V3VYZHhNVG84cFhCVEpuRDdNTDczdndPd28vZytWQVc0aldSK1ZWWjNpcW1G?=
 =?utf-8?B?V2JGMzhKTEJiajMrV1Nzd0lnM0pJYmFSaUNDVXpPbFFXZmYwdmRORGw1NGZC?=
 =?utf-8?B?SWhYN3JmaWFDTFc5bDRrU0xHN3NvYWFWaGpvSk9waDZKZS9WczR3M3I5di9X?=
 =?utf-8?B?SzVpQWNLVit0VGwrYS95SklLOGd1NXdFUzBQaDJOaUNUY2pPMkFUR2owYmhv?=
 =?utf-8?B?T202c01uSHBIQ0JLekp5VHBkRUthOU5nS0tpOU5ZVUhaK3c0V1JxTWVWcHRW?=
 =?utf-8?B?TXRJL2t1cFZHc2tQUTlvWkQ1a2xSQ3V6c3NwNG5Ka3FXTzljTHBGOVdlTmx2?=
 =?utf-8?B?YW9YZy8yVWpKY0JDWW53eWlCZFJuRG14U2dkbjhZaUo4c01va2Y3eGFQaG0y?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b18d5ad-2d4a-4727-598b-08ddaef44d7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:44:05.5198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVYByIG58tCvK4Z/q4LKsllkqajx0V58vXoWnmqU+kTlpkKCuR8oidcssZ2o5JfkSryq7Wc4Qaw1kPu2OAzaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7154
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


On 11-06-2025 12:40, vanshika.shukla@nxp.com wrote:
> From: Vanshika Shukla <vanshika.shukla@nxp.com>
>
> This series includes fixes for NXP DPAA drivers.
>
> V4:
> Fixed compilation errors in the "bus/dpaa: optimize qman enqueue check" patch
> on Ubuntu 22.04.
> - Ensured buffer bounds are respected and added validation for buffer count
> extracted from mcr->verb.
>
> V3:
> Fixed compilation errors for "bus/dpaa: optimize qman enqueue check" patch.
>
> V2:
> Handled review comments and checkpatch warnings
>
> Gagandeep Singh (1):
>    bus/dpaa: improve DPAA cleanup
>
> Hemant Agrawal (2):
>    bus/dpaa: avoid using same structure and variable name
>    bus/dpaa: optimize qman enqueue check
>
> Jun Yang (5):
>    bus/dpaa: add FMan node
>    bus/dpaa: enhance DPAA SoC version
>    bus/dpaa: optimize bman acquire/release
>    mempool/dpaa: fast acquire and release
>    mempool/dpaa: adjust pool element for LS1043A errata
>
> Vanshika Shukla (1):
>    net/dpaa: add devargs for enabling err packets on main queue
>
> Vinod Pullabhatla (1):
>    net/dpaa: add Tx rate limiting DPAA PMD API
>
>   .mailmap                                  |   1 +
>   doc/guides/nics/dpaa.rst                  |   3 +
>   drivers/bus/dpaa/base/fman/fman.c         | 279 ++++++++++++---------
>   drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
>   drivers/bus/dpaa/base/qbman/bman.c        | 149 +++++++++--
>   drivers/bus/dpaa/base/qbman/qman.c        |  50 ++--
>   drivers/bus/dpaa/base/qbman/qman_driver.c |   2 -
>   drivers/bus/dpaa/bus_dpaa_driver.h        |   9 +-
>   drivers/bus/dpaa/dpaa_bus.c               | 179 +++++++++----
>   drivers/bus/dpaa/include/fman.h           |  40 +--
>   drivers/bus/dpaa/include/fsl_bman.h       |  20 +-
>   drivers/bus/dpaa/include/fsl_qman.h       |   2 +-
>   drivers/bus/dpaa/include/netcfg.h         |  14 --
>   drivers/mempool/dpaa/dpaa_mempool.c       | 230 +++++++++++++----
>   drivers/mempool/dpaa/dpaa_mempool.h       |  13 +-
>   drivers/net/dpaa/dpaa_ethdev.c            | 291 +++++++++++++++-------
>   drivers/net/dpaa/dpaa_flow.c              |  87 ++++++-
>   drivers/net/dpaa/dpaa_ptp.c               |  12 +-
>   drivers/net/dpaa/dpaa_rxtx.c              |   4 +-
>   drivers/net/dpaa/fmlib/fm_lib.c           |  30 +++
>   drivers/net/dpaa/fmlib/fm_port_ext.h      |   2 +-
>   drivers/net/dpaa/rte_pmd_dpaa.h           |  21 +-
>   22 files changed, 1023 insertions(+), 423 deletions(-)

Series-

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

