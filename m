Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19200C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 06:12:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10C37402D3;
	Thu,  6 Aug 2026 08:12:04 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
 by mails.dpdk.org (Postfix) with ESMTP id D1C0E4027E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 08:12:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRjuvZRQmS6RpvFErFMaIX5ShNOUJjsGaeAiBHDyNHTIKlIc4Me7kbV56pyHCFEU+AE+uTCmLf5GLbSACA3CYTcLXvIUqtsXG+pkf/jWcMKxOudaSytsNywghDi5SyXy2mfSWgCMwrIPsRV+orBJOsFkVpCgdXtpytOSOT7/S/cKmM+iBZFXSzENN+FglXYYP+1j3DiiaBkcRNhPXeDUz7iGdu+cj1rc6j47rJ9VVdxoxQ7Lbp8xKAJearS6pwj2e8P5l0k08+E/OBBkbrU6W1XYYnx6RncWQmbbG4TD8GkwT+6O10zJG9mnqgj54nynboqvsQf6WimHfwTD2PpUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5QuIyIMO8HX8JqFjb1gQ8E7B4J8uMEJZger52ZzHk4=;
 b=sjgb31UsItpFzlA6ob05JM++5dX/NqXaHJ3WMu5C5oYrmZcmzFyU1BSTVUFG1tHZG6clIOe0cBykYtDeIYUHL2/0t5X9Feq+mbU4rEHwxcBLygccBcGGCh0AJlnWWY/Uj+RR/3cn+44pQba1SWmk4hB4tgptA6VzAOvmRESZPxapVBq16L1uzVBNHpAZ1Le6miaJHn15RdNzIRoTjkCMvMMLeU0fhBRaEU4c3BjlO5ifbglMsJ+XBKOlNYXsKKbdyUfAw2xOWoxnqBrcz4Rr1FPLuCOw4yVCdHuJjzRfbA2P+K2P/MLFb1kLHnR7br7scsdxJs0/VxftqxpXT7BCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5QuIyIMO8HX8JqFjb1gQ8E7B4J8uMEJZger52ZzHk4=;
 b=syLOWnajE/RcypB/DnB/vSh3J/RcwJOZhFYfMsYTPQQyj9gZpHgOOCpvISOs1pGp9ht/mQXdowkKNvwQmPKAzFqd67ekB4jN8IBhg0grFo2Mn0M2HhZaAMP8xd1epqFEUlBid/W19L8xeeW+/dOf1RUBpDmhhAHZVz8mcxRYAqRDB2X6ECUs2q71JfLtpJHwJ1OB11E4rP/GiWaRqDy7c+w3CMO55rIDw12F92SiLtXTXwJs7OJyEz7IoTbqq8rP1v82/B+rqNKBVnVsRVVgDItvu1gCXd3RXi+MsHnBXCB70IxPYiaIjBlFD5mWURHkUbqxqH1ckuFz12FeKm0wXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM7PR04MB7110.eurprd04.prod.outlook.com
 (2603:10a6:20b:119::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 06:12:01 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 06:12:01 +0000
Message-ID: <6ff2cd1f-0492-48c1-ae6f-fe3c20d24dd6@oss.nxp.com>
Date: Thu, 6 Aug 2026 11:41:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 23/32] event/dpaa2: replace deprecated barrier in selftest
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-24-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260729175715.165120-24-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: f522ff46-b4a5-4f2f-a20a-08def381a0d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: ev5A7JUIO/y2Z24BshceveAr0Rc/I7hhjcKQ0Xf36LOz27b4/kpaeIOGzoe8u2twLeSYjdAldkdtq938SbrkimklaO48AU3as8QrsJtkzbpwZJxOZjurhlRU+TSb7m/R1wRq5tOUXr96yl3klEFKt91G9h41LhGrHR88S2Hm4oOxm9FaSb4Ch19pX6qK1mZl1HHe+X30sMqD4CLD6Au2B5QmeJv7FVosNYUNot0ymXWQ54BEcGWgS6szeqSm+cN1pCg2pB014l8Y9PBoaMCcjuOr0IZs1HNtTbpZB2ms0GqAfxZikmrUYv2+BFrYzP/9Tnr7EvC84B/ywHxh6p8LDE+mQnWbRtxErb0YIxIJFEg6b+8sJhrrS6+9DW3pkJydswQmOMDd5YmD9bS44hfcx3fgVTUv8jT5h2Z0vdVLi84+KM7IsnBrs3WskJKPUtr2QlGgOB+eCeq7WV98Kw4iPmSCZDFcGXj1QNhv6eFtg4b+WjBy5+FttQoTGuA4h0D+H4w85bQPqSPrBwxKZnh/6lnYbLHlEim9AQngn0TfspurjGTt02xLL+VR2noE8W1XlpfkrIL6f1NuGc2zy794wQnRyZWnOGc8dyr05WJmwvAMF6NBBQGxTzCw7zIdd8JaHceyaQhmJpc8a1hLGfpC4AQjHIm79K2kgWEpmKYJaoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdEMnZZdmRxYUp2cDgxWGlkWTV3U1NoQk0zejRzVFJ4djlNb3d4eGlMeC82?=
 =?utf-8?B?VUdiQzNDUTlPSWJacHJOeUhSL2N5QVhwMDlSeG1tM2RoTWdaR2FWaFR2cHRD?=
 =?utf-8?B?MkJBSDNQRWJjY3lXYUNBRVBNb1BiK0J6Qm14REFuWmtibm5YczhodmhyVVJK?=
 =?utf-8?B?UnlnYXdNQUlQOC9POWtMMlZtRFhQTkIvL21QOHBVQ0dmY00rblIxb29VdzRD?=
 =?utf-8?B?MFU4YkY3Z3FlN2dVL1FWaFR5d2FQRDJpUEtpN0RYbUdQSDV6cmJUTTgyV2l6?=
 =?utf-8?B?aXh4bkQrdjB3dUhudmswOG44cHNVbktZSVNLdElSVlA1Ynl3c0RvM21YR2xw?=
 =?utf-8?B?NXk3M2RRSUVtT3hoRWNTQ0Fyd1RBZk9QVmlXL2pRcjE5cnZ0TmJaUWZ0c1c1?=
 =?utf-8?B?T3JNdklWdjZEVWZBWlRNN05GMmpiKy9vOWNqMFZYVm84c3pTaDhrSjRNTmk0?=
 =?utf-8?B?dUpZYngwdUdEL09DR0U1RXBxNTIrU0hxOFFZVFZ6VTdLVDlrNENqUkt3RVU4?=
 =?utf-8?B?MkkvVC9aWkI2a1pFZnBZTnB1UE82M3dSRWVGcmkwTzV4UnZ6MEtrODJUY2xT?=
 =?utf-8?B?bVcvS29ZQnRyN0F6MlZPMXlpc2tGTWQyTlFpaXZ4SXI4TUVHU0V2T0Z3aFdh?=
 =?utf-8?B?U0N3OS8ra2JSVzdIVnl5WXBqSmhNUVJYTDNnUW9SdVJUSmtJbFVMby9naVFY?=
 =?utf-8?B?R3Q2aFdnTEtPOXJheEl3SkJ6WXF0NDk2SDdRZXhzUEFVSThQOC92aTNVc0ht?=
 =?utf-8?B?eEdtdkN4NW5tWXcxbWgyaW1DcjJpQjhkZ0Frb293MXpUQVhvRDA2bExpYm9p?=
 =?utf-8?B?bSt1c0R5TUFzWVorWXg2YXNyNEJxUGQrdWQ0M3FSeWtON3dUL2RucS9CT21X?=
 =?utf-8?B?dGJ0OWtPMEgxZFRieWs3T3JtMTZCWDVITDR1TElOQ0hmODZOeWlBaVZqamtG?=
 =?utf-8?B?MGV3MG5rUHNkL3ZqMkR0bFJkdXFsUTQ1MFlyUm96SldCM0FiS1I0K0Jqa3N2?=
 =?utf-8?B?a1RudGhKdFRPUVB4bmZKbDVUbEFKc1MwSEVFS3hRVU5vVEFsQmlyTEoyZXdE?=
 =?utf-8?B?aUl6YTNhaWh5ZW5sLzR1d21PU1NSMU4vYXlxNnV5QTdJVCtoN25BOTJUWkgy?=
 =?utf-8?B?SE1LU2xWS3RJTFZma0o3S3VGQzFUSTFjUUdYb1BqYUl2R1ppTlBLa2dtMEFC?=
 =?utf-8?B?SFNxSWgxZ21Cb3lQSjhzUGJDQ2wrRjlQMGc3NjBTaUVaOWlUaVhScTJsdDJI?=
 =?utf-8?B?YjRmZEpLTHNUUXR1bWo1TnBibnNnck5RQ0hKemEyc0VFdVJxY1VsR2U1a1F3?=
 =?utf-8?B?VCs1UE1wYi9aS3VacmZqakdBcEw5UUZ6Y0FVTnhsWmdFclBiZXFGMzZFZ2w4?=
 =?utf-8?B?SWcxNVhab3UwRXdrZ2dKOHVKZ2tMUmVhYlNyRmJGbjc3enlwV3N6aFIycnRB?=
 =?utf-8?B?NkdWMXVOMVdFNHdGbnNEbjMveUFYR1EvUDRRQi9UV2RrQUt6b3FUNVBkaURK?=
 =?utf-8?B?bU8wYzFIY2psMW4zN21NQXhJODRYMGtKRXFrRGF4SmZMWkVaV2ZlOGt0b0pl?=
 =?utf-8?B?Ly9aekFaNWVhSDQza2xkUVlJYWZTUkVxVElFTCthVU1sazFQNmMzMTREbXZS?=
 =?utf-8?B?S3UxZFlFYWJBRDM4TVhUWlQ2MjJsbVJCMkoyUitXNEJoWXdyTjJud2I0TmZB?=
 =?utf-8?B?aTVzM25XZ2lRNFB6S2x6MkxaczE2WDhjb1JTaEh1OVFtM3VoKzRGRlFOREJ2?=
 =?utf-8?B?cDdRd01IVEZmckV6UHFBdUY2d0RmejJMMGlNdktwcENLWXBpWCtsZ05reW0y?=
 =?utf-8?B?UUxyWVV4bGhrRlJrSTMybnoyaDk3RDBLVW0vczFwNzFtNWRaQmFFdkZvT05o?=
 =?utf-8?B?Sjd0WEhKMWF0R1JWOG9NMWVXNzBaU1E4MkVFR2N2MnF2TjZpMzlIc0IweVAr?=
 =?utf-8?B?WDc3bUVnRkxMZy9nZHhqb3JtWFRDdWwwbEsyVHdML3l6bVRwR2JvWkRHekFp?=
 =?utf-8?B?ZzY1VGJLRDZpV1ZTbEhVVFpORk5Va21Dbm1WcisxYTRIWWZHVWF0NGdac3Nh?=
 =?utf-8?B?S0xrOTRrd3ZSQWhZQzZRbjByanN4UnZ3ZmkyT3hQNFdMbUZFS1gvbXN3QWts?=
 =?utf-8?B?c2pETTZ4cmtnQW0vb0oyREZJcE0wUjZTbjh0NjRIWHZMWXJkbjRrYm82UUdv?=
 =?utf-8?B?ZFZoMGlFa2p1SmFqQTBmV3RVclBmL0JBbm5HT1dhdkJOTlM4QTRNdE1jTGUv?=
 =?utf-8?B?encvUnhGRnl3bU9XdkhCRmhtbXFGdWpBQlJDeE4zczN0QnFpL1F5K3Q2MWlL?=
 =?utf-8?B?bDFvbXdNaE1SQ3Y1VlN6L2VLMHhROGdhODdpL3V1TEsyN2VqUUpKWUIrTGxT?=
 =?utf-8?Q?Yx87OtLscx8flP+A=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f522ff46-b4a5-4f2f-a20a-08def381a0d0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:12:01.0843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNKDkIFnD92VfU6OKpAF7u0hg4umSUylTnVnWAPZkstRPqcuXr2B4cWt3jQ8D2Koz2g4bKFhoFaJIBDWKc9lZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110
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


On 29-07-2026 23:24, Stephen Hemminger wrote:
> Publish worker parameters with a release fence before launching the
> lcores instead of the deprecated SMP write barrier.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

