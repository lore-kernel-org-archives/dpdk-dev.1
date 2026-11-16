Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58043606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vv216iFB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4C7B4026F;
	Mon, 16 Nov 2026 15:17:15 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by mails.dpdk.org (Postfix) with ESMTPS id A872640150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 15:17:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZnXQl0ijN6A/5ggIeA58LfhL2QZChMjz4azCvHQuX5YZi+qXCF1D7xmtCUD7eLJs2w/7lCwZA4DZdNVzsGfb4fWJ5UxbSMxbRaY9qaqWjC8rmwlqdcVO6x5bDrFZMmKTIXq+lEsmdF4VcifWDLJ8SqBZr2OtBaYDx6BgpMcH445cpso/c0MeNh+3Si+965zbC0eoaXoZbuyDTo0ixJVzO5xygkQuVfaWdMFy0zN1Z+2cfS0eVlbTOpuLZ90sjOxHWdjbWpCoMnoMPhu1Bo9Y1hMlanJPMwS/O7xgM7zUN9FiFC/JSkfYfh2KucQuIym7IIAnunKqaP9vrPM9haV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9ddHSSkTsUCLDtkxKarsNn2mjTCdtMi27VR3f3/mjo=;
 b=fdFnXSZnFCxSuGov/5YyrKd2qw9Lmmna+ozdv/95NCpK052g8detvQj9Qv6hi21BGKD6ZaPHgvPyH0nlu+bSY2K8eGiCEgU4PuO1/nGKz1MBb9xeHSMt8KydkzVhq8+4KAOdTU+NTt8wPrUf1jYHV0HVlGpTF+z3ELYZ48gGHzYXi5yTVQEg0g5s8dwURbIXReoqUZDm0B00vw7PfVzXc4eWkEdcDxr4kOaLcQzt1TJnIN4HaNuTkhkcaLnycmrw9yIFqFez3tWV21FHXS/XdOC6BpyYcuAOMu1Zx0NbCGTbMmDNMtsnpqQIa5tt6aHar/KLFOZr8aOwMi33lSrBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9ddHSSkTsUCLDtkxKarsNn2mjTCdtMi27VR3f3/mjo=;
 b=vv216iFBuu8Aon68O3Mvm9QnSy0hBrA2+EurkEOnEFjBqekX8ULt3KjeOwkjDgbGElmDw902XuvYAbXcUYKn9I2EJox7B4zxj1On0m8Bx5FKGeR6Mq5Tsz+BEzngUeHGKQbuFGPhdHkSpaQi0Q9tIDPtDbVesX5GSoQ8cGsob0LhUU4lM5hkva4fFu9s0PlKY2MDp0PsEkuml7lN7mCwKPx+pHJR4G8mVwcgpDp5Ag/9qQXU5mfnZDduerh+ir2YXgbUwap1hW35hEtD35q6FPoueDKw1Qd97Tpxg5Fp+wI0Kgs4ZwDcIn1OeQpaX9cZxJI6czEdbzmmKJBxMIZSRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CH3PR03MB7411.namprd03.prod.outlook.com (2603:10b6:610:197::16)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:17:09 +0000
Received: from CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088]) by CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:17:09 +0000
Message-ID: <83697e5f-5142-4aa2-a907-290b1da1603a@altera.com>
Date: Mon, 16 Nov 2026 19:47:02 +0530
User-Agent: Mozilla Thunderbird
From: "Prusty, Subhransu Sekhar" <subhransu.sekhar.prusty@altera.com>
Subject: Re: [RFC 0/4] net/mcdma: add Altera MCDMA poll mode driver
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rtice@cisco.com, cheryl.bansal@altera.com,
 nanditha.jayarajan@altera.com
References: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
 <20261109092513.59d8b647@phoenix.local>
Content-Language: en-US
In-Reply-To: <20261109092513.59d8b647@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::13) To CH3PR03MB7411.namprd03.prod.outlook.com
 (2603:10b6:610:197::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR03MB7411:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: d06afcac-5498-499c-24d3-08df43ec4ce0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|4143699003|11063799006|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261021135927099003|261021130227099003|261022113327099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261102130727099003|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: O3cHT4SoScNjoOKetiGLlqQ37EqQTeHq2bFxncmKQO8PjYh3Uawbt2WEJ1Syo5mCCKdXQubRwygfTrawid1Ix6P+c0DwtzGLBnA61xNt5eEkjzdY9iJtm8RsTF3Z8UNF5WYMNzR6uNWvQHf9HcbeZIuhyeQ7STs80NcuUVN/shhu7e2MFRAT5TAlGHswZmWxgUGGiDgYATnaj+/7nR8qYf103LP+QEpV7b4JEVVVhMF5YoH51JVzKJJp28gX2mxeZdweWXJlShohj+B7p1Pv7bA2JrNwUi2Kj7dO5ROCSVJSf7cpH14jcexol3FUxENJj9AZsgbrtINgCpsJuwEsJl6OWq12Qd4QDo5bRRO5qUgdFFB2Fg3wfJD16EmJEq2xRF5I6mt/w2KKm4whMXNvd0UV6Q1eQD9Hu4E6/RDVVv269rrcZ2Q51CmNykhCjjx4mBrgSIgWd+OAHB0BfexrTDU1l4H8QQ3jkcosGhMKyM8HFedcY3UZqrrZRzzUrkxJN6Na78v9fD0DaNpQV5qr9QqT4gBAOhAbtBCi4ZYJPvrPYZoS0YMG8wSkluuZsVxlrp/rPFibEq+UA6T8vTtJQ6TGPqcy1oNDiGZd0AC2cxU6CnkwIK/ff5hEwi9Slj4SgV5RVUCR3Wv25ioOb12kn4+2XZGxu00OJgo/xOLxKUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR03MB7411.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261021135927099003)(261021130227099003)(261022113327099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261102130727099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZvTzZTSm9IOE0rd21iN0M5TFM1Wjl2NnZtZWNYRmprZkZveHpxRTZlTUsv?=
 =?utf-8?B?RVVhSTErN2dsTFdYbEg4dnZEK1E0K0luMGV4TnlUSUUxekRKYy96dHAyUGIw?=
 =?utf-8?B?dTBSTG83endXYnlQZXgyTnU3RWdmd2FHY1lOMVRDT1EvYmVRV2tmak91cnla?=
 =?utf-8?B?UXlBT0doR0Y3S1JHZ04ySEZVZkdNQVVaUEtqQlRDaGNaWHloQmFCRDY0WjRN?=
 =?utf-8?B?SVRiK1kvL0tGK1dlQUppNXhDalRpNDAvL3JvemdWNGhDTHpmSVVUWUdKWWE5?=
 =?utf-8?B?Y3ZxRlFRR2tFODArTTVjVjlWdWlZYnNNcERDT21Kb3NZWmlkYUk4MkRmZzJE?=
 =?utf-8?B?WVRXTDhOY0o2OTBodnRBdDVCVGtBQTNCR3lRSFo2RTJxTDBmN3IyYTk2VnN3?=
 =?utf-8?B?NVpxNFdOMWNrRFdLWG1GVFViNlRZVFpQSTE2OUQyQmZPU2w4OEs3UER4UjBk?=
 =?utf-8?B?TFZLRzNpNHlVNUNyQTBTbHZaQ0hxbkpic0tZYWJvNVdaUzhqS05OWnVaZWlI?=
 =?utf-8?B?VE1QUnpacXJxZUlGZlJjQjZYTGw3eUJpM0lqT1Z6Sk9oNk9ibXVuZ09Ibmp6?=
 =?utf-8?B?ajFLR3hySmthaTkxZU5yWlZld0ZZWGZiQzc5K3lSRUowb3IwT2lqYmlSTjlV?=
 =?utf-8?B?MU5acFdzZHFDRzBXRWhxYW92RkUrRE1oMmZUM3hkVzN5bUJUS05ZM2orRnd6?=
 =?utf-8?B?Z2hEekFtN3lXT2RQeXRhMnkyV0pYdC82Tk9neGRJZEdhUzRmd2xISzhrYzlj?=
 =?utf-8?B?RGpuKzVFSlUvZEdKOG5Oc3dyakhKVG9zeVdCYVJLaTNEVXZBSytYeklOeVAw?=
 =?utf-8?B?M01kOXdjaE55anNibTJXd2MyOU4xNExsRGZSbVlJdDVSOUFnVmxoNTlWTXUw?=
 =?utf-8?B?U2paTkNrdUlHSmZ5Zy9odlJpRUlQNlNKWmlZSXdGdFdaeURGREMvOVFPbmt1?=
 =?utf-8?B?a0VCMkVicmQ5WDlMMzByd2hhVHorWitvaUZkdVBQOFV5S20rNENmaVd2VVp1?=
 =?utf-8?B?QVJKQUFlVVZvd0ExTG1ndG93OGgwNEhJNXN4UWZ2QTljak5IbWZGUHp0TG9h?=
 =?utf-8?B?T1dxMmg1aEh0UTVtb1lNM3RrYnBDOXFQVTl6WUhOR1d4VzdxL2NqeEpuMkdU?=
 =?utf-8?B?eXJIUENIVnpxNDhFdFI3TnlyZEVlYnlIM0lmNm1zQjdESml1SHVLUlgrSnlN?=
 =?utf-8?B?V3ZtM0R0aEltbDVrY1pTWGhEYjNKWDRobWRxYW8yS1Y0ZUtsZjhMNG5yQ2dV?=
 =?utf-8?B?alZIU2dzSHo1V0Z2QnZsQlZta2E1RGhLaTY5Y201ckpVNXY5VXY4WERPUUdG?=
 =?utf-8?B?cGJJaEsvSXF5Q0o2R0E1R0YzRGJFeHFHRC91Vkl5eWhhamlMVmc1OHdVZy91?=
 =?utf-8?B?UmlScTM1bnlYWThZY0Q1R3lBZzJ5VjZneGRKMzB2dU1XSFB6WUp1SlYxbjEz?=
 =?utf-8?B?ZDFtQzBwM24zTDFVR2xvUFNjLzFYNDZBNUFSaWlJZVFTZnMvalh0bkhSTVJo?=
 =?utf-8?B?ZWNRU3NjWWFYV0gwZEhrV081NDA3WmFKWTJ0NWJhN1hLMC92Y242dFcyMENM?=
 =?utf-8?B?QnhGSFE3L0VUdjk2UHZ3V0ZCMnRMYjRqdHZGeHVRdElrYWFKQ0x0YkNCZEhl?=
 =?utf-8?B?SmoybjlTRTI0WDV0cjcrVjZ6ODIxeXlQTzdMSUR6MSsxYVF5VS9EWGwxWFg1?=
 =?utf-8?B?UVJ0SEdQTncvS001Vm84Z09KUTZiVi9PTHNWS2NaVkJlZmJFNVZOMVVxdWcz?=
 =?utf-8?B?bFBhSDlpVjIzRHdkcmwzL0h3RHJWUTZKblVrQTNVVno5SFA2Rm1tQW1IdjRZ?=
 =?utf-8?B?MzF1YWI4WThEU296aCtsV041eExhcFZ3TUxPcGxIemNab05oZDQzT1dTS1pw?=
 =?utf-8?B?bXFxSkVMYThIbWVKOWZra2dXNnlqVENhcE80ZmlyMU14eldHeXFIMkJqMERP?=
 =?utf-8?B?Wlp3Y3RQMEcxTkdLamNMclZHZmRJdWNXTktFa1pmemxFVlpRWHUwVnNaOXJx?=
 =?utf-8?B?MURjckVLcHkvTGpycFkwMTJwVEVYZHNzOUtEbk55NUhJdGdLLzEvYXdUbDRx?=
 =?utf-8?B?b2lmQUh4Ui8yWndwUThIelVQOENiMVp0cE9taGo2cnBjU1EzODYyd0xSNzE4?=
 =?utf-8?B?Wk03SDA0ZmlhY1FhWGorSHRJWTVpSllTRytranl5ck55K25yR0xEdGJaZ25R?=
 =?utf-8?B?WTlpeHdSWjFTOEJ2WTdiN1lBUTRSN0dSaHpreTRmSnJwdTBYS2pCRmJZQW9S?=
 =?utf-8?B?MzF4ZkdRdnZPeTkyVzVUOFZXc1llSkl3UTY2clhxVEtjSVl6UHVjNnlkcCt2?=
 =?utf-8?B?Nk9rb2EvT3NCSHlDRGhESG9xQk51UTVlUmtYTkFxTEE0WmpxVk5kTCtQYmFN?=
 =?utf-8?Q?onhfpAn3w+U6lVtAVZsJA1vusEsMqw2d9sBB0?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06afcac-5498-499c-24d3-08df43ec4ce0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR03MB7411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:17:09.2678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmeNDW0AqNjZBJ84Z3cO5sptG01H/V36wSzdLp0aNVLIT7Gr7oH9lc0Ywtcjx1got8+vlhQLZN1SmW2F7sIYCL5ruCXB1OWndA/A91dUWVnX30U7IK3pTtf7IzfFyJ8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stephen,

>> We would appreciate feedback on the ethdev design, the experimental
>> PIO APIs, and PF/VF devargs.
> 
> Lots of feedback from AI review. Mostly it needs to be tested with testpmd

Thanks for the feedback. I am newbie to dpdk and will try to adapt with 
the process. We will address the AI review feedback and also we will 
plan to test our driver with testpmd before submitting the next patchset.

> before review consideration. And you are too late for 26.11

We will resubmit for 27.03 after addressing all the review comments.

> 
> Review: [RFC 0/4] net/mcdma: add Altera MCDMA poll mode driver
> 
> Applied on 26.11-rc2, builds clean with -Dwerror at each commit.
> Post-apply sources read, not just diffs.
> 
> Series-level
> ------------
> 
> Target release. 26.11 is at rc2; a new driver lands in 27.03.
> RTE_EXPORT_EXPERIMENTAL_SYMBOL(..., 26.11) in patches 3/4 should say
> 27.03, and the series needs a release notes entry in the 27.03 file.

Sure.

> 
> PCI ID and PF/VF model (you asked about devargs). The ID table is
> vendor 0x1172, device 0x0000, i.e. the Altera default IDs. Any
> Altera design left at default IDs will probe as MCDMA. Whether a
> function is PF or VF is decided by the presence of pf_index=, and a
> VF needs parent_pf_idx= to find its channel count. The usual way to
> do this in DPDK is distinct device IDs for PF and VF (and a real

Since ours is FPGA drivers this will be tricky as the IP configuration 
in a design may not always have the device IDs assigned and even though 
assigned every design can have a different device IDs which may be 
difficult to add in the enumeration list. This is why we have this 
approach to distinguish with devargs. Is there any other way we can 
approach this?

> device ID for the MCDMA IP); then is_pf comes from the match entry
> and both devargs go away. A VF probed with no devargs at all
> currently fails (see patch 1).

As current enumeration is based on the devargs to decide on the pf/vf, 
the driver is designed to fail without this. Please guide how it can be 
done without this.
> 
> PMD-specific API (you asked about it). Patch 4 reimplements what
> ethdev already has: eth_dev_ops.get_reg / rte_eth_dev_get_reg_info_ext()
> gives named register dumps that testpmd and dpdk-proc-info already
> consume. Implement .get_reg and drop rte_pmd_mcdma_qcsr_read/dump.

Thanks for pointing we will fix the driver to use this.

> Patch 3 (PIO) has no generic equivalent, see notes there.
> 
> testpmd. mcdma.rst says the driver has not been tested with testpmd.
> It should be before a non-RFC submission; it will exercise close,
> stop, mtu set and secondary process paths that pktgen does not.

Sure, we will test the driver with testpmd.

> 
> 
> Patch 1/4: net/mcdma: add Altera MCDMA poll mode driver skeleton
> ----------------------------------------------------------------
> 

We are reviewing the AI review feedback and will get back with specific 
query and concern if any while addressing them.

Regards,
Subhransu

