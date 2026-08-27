Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B0C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D575F402BD;
	Thu, 27 Aug 2026 17:59:33 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
 by mails.dpdk.org (Postfix) with ESMTP id C792440150;
 Thu, 27 Aug 2026 17:59:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQvSbkhhm7iiJkRRL/kSN19eTA7lSwE2gYmGHeuvCxf6crFhdcZCxyM3x5rGTWr98phTnKkw+pOKkY8DtO+QYW6/J4TMPklUfIPbo3ETWSJAaxbP7ygSp5qxGOl0/q/7Zih8CjWlglob34K4/LkSiq7rq3zCUYGLihJLYXvbYwldhl6KqzWQn9WimuLQbADMyUNvBDKJpG6BTM4TTP1XwW+8+jmCJZUwiv1U54hwEkrWYC/ae2CPZAh2/35gUkzAf/QXEoHUAhIAkcN0Pm20YqL3/jxg9QzcQn19HJart//oOZJe8EwqirMiLPDpl9H07LGh6G8DkZqVjm7jPJiAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJD9izX7GCese5CoFv7FaMzTQHvuI6gn71cRbRRHdJk=;
 b=H4fknucuKHs0Z3zKf4gwkFhVQ3H2dixgG6pwiZBUESdbhGJj5UDCEUulXdVI4lcJ+86eiVwiUOi3PPfG7/hGm1AWg8Ert9tGM5tUrsBTTMmiYhRMtx+H1c568N87EjbZHzJ12/H9rtNkgozozueiveqCxJgCXv5MA6Z+icDpe8B7jj8a2jDfFOxkeO4rxpgrXA4BLZOSzpogglj1CrbkNkCfq+lxHtQBckb+OamZR0uJCm+f0qOJYXUY2DAt4AQs1qQwK/KeV+3OCmrNdigDoDwd51nGNe/406POg5tmntFsLpPG/uZPqhSw7z6kVZ43dso6Kon/jjmolhI6yH86Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJD9izX7GCese5CoFv7FaMzTQHvuI6gn71cRbRRHdJk=;
 b=i9QqzfifHsu2D06ujWwnXoUHUI7PwFPREoaTktiwS1KEmAgQov3oUZzXq4+yl1m7zbpMPUXttJ8sSkZPSo2rS5zwkifwm5Xv3wIU2qA730jXXsDHSaDSL5SAXdhMasJhQgbU++eKye1w65f7juXOcezI0nq/KqWFCpQg3Pm8RftKsh7+kispskslHLVCOpR10PkA4CNVJc30yZCzxIq4y0577c92Mmk72YganGv1oRcp8EWLghG+FBXTNiVY78YW7ZNX56rBH5Ue1NI0C4/PkEdzNbSD+1ARPN1L0zQh6hsWofU9aMQMFzxFzjscbVaQqAbr/BmR8IJOcBfgr5Dccw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS8PR04MB8947.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:59:31 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 15:59:31 +0000
Message-ID: <a45480a2-dcb2-48a0-bbf2-2061e491364c@oss.nxp.com>
Date: Thu, 27 Aug 2026 21:29:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/dpaa: fix Rx queue shutdown before init
To: Prashant Gupta <prashant.gupta_3@nxp.com>, stephen@networkplumber.org,
 david.marchand@redhat.com, hemant.agrawal@nxp.com, dev@dpdk.org
Cc: stable@dpdk.org
References: <20260827072913.1015508-1-prashant.gupta_3@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260827072913.1015508-1-prashant.gupta_3@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: a21d3c5f-00fd-4e62-2aa5-08df04542e4d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d7WWL5s0qZUEpYIwB6WjNQXdjFOasuk3uxRXLaM8hUw9RIn2o+lEUzIxWI0LIh6RDjCTIYK/d47j8nPsSZIc31cFr9r/qe2lSkZ0Lv+QkpZRT54wbBngKMUC89ZziXHkyI+XFgvmCidZX6hxpTQhiD8OrcLZEKQGSPnhSqhC9Gp82joSuST95Nbk/LiyMkce1XBy4RPqasgzBrx+RGima7wYxb/o8J16YSesKDtW15tls5QZQC1VEEsLN/YrAEVIb3ZzU0ty3exIXcxVr93odtHIosLUKh42FVWdz9ivGkOcDbLPuqtloFFTbwcRVNuO0AxlU+oLw0s6WJAWmW7mBAmeiWwANzdiR6Qsq8UI0vvzyGk6H1d/Bvtp+ZAjiSDwDIzR5q3eXyPcZbU+c5sfeSEVeP1oCop+mZ2QV16/LKInj6NmYavC4d7ngsuio/f/rOofLwZfMZMP4t2ds9SZPvzJ7UKEshm/4aK3RCByKu3qKqr4OPb7YCoKgFVvA59NneP6IyvbIUMT97bV+tv1X18mkik0xlL7HF3ffgS4erT7CWEYaUe+Lu4z91Jy/BCildJzDE1uVOrCGNa0OmjmM+QPyic63NSGgOt2lEHw2mD3HsqdCop9Ys8CVAlnFcpcWuLi65lrO6NrWTsXL7Fe0G3FjT8PrF/7uewcnPZi9uU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWxYd2pvQXpOWEZyUmdFUG9Ja1JHTFBlQXRSa3lzVlVmSEVJdXNuYVV4c2Fr?=
 =?utf-8?B?OXYxWC9KVXdHVFBTQm5KZXpIazh6Y1VWcEIvNkRkTDB2M3R0S2hjaXJzT040?=
 =?utf-8?B?MzR5a2sva0YvUHhJRXpic2NwSU01cGFTeWE0TVR2ZUhIRCtpOG0rYkw0Z1Zy?=
 =?utf-8?B?NU5iVDNCdmZnRERhTCt1dFlDRDBKdU54NDNRc0FGL1c4Q3luOXNvM2pJa2VL?=
 =?utf-8?B?WFVJa1VxcUlpTHZISm92Mk9ocjE4QUNza3FRd1g5c3BVakJTY3ExTTEyd3Rp?=
 =?utf-8?B?Q3dpemIxNjY4ZHJGclFrNFJNcHRHTzg5YmdVNXAyeWpJL2QvUXBBTmhBQmlB?=
 =?utf-8?B?ZkpEUCs4bTRPdmN5L0ttVXB0bUlyWHZMZkFadENNeVEreHo4SzFmdjdhN05Q?=
 =?utf-8?B?N1AyUmVpdVlnejNVYzcyK2plUDh6M2JJME9zZElpU2QyVUpEV21QSE9pTGoy?=
 =?utf-8?B?ZEVtRjFOR3l6aW9tSzhRL1J2cm9KQ2E5dnRvcXZDZjQ3Q3YwUjJGSnk0cG9R?=
 =?utf-8?B?UWxISnZ0TGI5dHlhK3NBZW1CelNtZGFWTWh5WFhCMDNockhacFVxWmRkS3kw?=
 =?utf-8?B?N1VQbk5OUkRGejdrUVFjaCtldE5nb0EwK05heDlqUlpSd1RUK1hGdUZPNCtZ?=
 =?utf-8?B?d1lhWGphbzhPWGZ0R3U4WEYvTGFMSkRobjBMbm44M0hPcFlsVzJabzFicTVS?=
 =?utf-8?B?MEQwQmtkaEQwMW8vMm9qYm9yTTlYbHErOTQzeFBkanN0ZUIvcHBBVW5lTXYx?=
 =?utf-8?B?SThYZFNoQXdyRzFqV0pyRXdXOG5TQ2Z1dWFDZVJQWGhJSW9WdGp6QVZCZXJH?=
 =?utf-8?B?NmRVU01xRHJkSHBjUnVtaWVvVVZHVnlycU5nN3ZqWS9DQzFKSkFieXl4SWEz?=
 =?utf-8?B?eWQ1MFJEOTVPRnZ4aTAyaUFabW1GSGs5TEkycTBOM0hlYUFpci9vRDVJOTU5?=
 =?utf-8?B?bVNwd3dHSnBDOURpc2VHaGlqTE5HZW51R3crY3B2SWJneVpNUS82ellBWWp4?=
 =?utf-8?B?OC9jRTVtL3oxOHJUS21TVS9rYm9kZWY0dCtsKzhOQ1VVc1NrNWVNdUNHRmhx?=
 =?utf-8?B?VnJudWowdXJkWXhzOW9uYVd5NFdlQ1dEaGQyZ2JyTklLVVdvSlRpZWV5Q3dJ?=
 =?utf-8?B?aGJaK0F6anJ4V3p5VmE3ZnR6NU0xdEZxdklibUR5Z2pOR2hINVkzRXR5bFN0?=
 =?utf-8?B?eWozUmE1ZXh6NEhtTnJKNzRtOE5xYXNpbENtQzdVUTdGV2dhcWVCOG5ma1dM?=
 =?utf-8?B?L1JUdnRFWG95cXg0citDcHlQNFpvQXlPODByZ3J3UHRCYVZObDQ3elh2c2xQ?=
 =?utf-8?B?TXN0RUY2MmxDakxKb2pXVFZ4aWhtRitOQ0xMUXdXZWF1ODFRdDA2d1l1czhy?=
 =?utf-8?B?Wm1CRHhtVG13TWh1SzdhUjhwUEVPSTd5cTBTNVJPWFpjTkdXR0xnWFhRM0ZV?=
 =?utf-8?B?MVRYR1pyMUZLdkszdms1cDZzbVUzSUJkc0p6NDRJS2owMTJyc2NCTW1YNWcr?=
 =?utf-8?B?VWZnU3dVa2xvS1kzWUNlWWI2bXg4ZGU5dDJZUU96NmU2a3AxempqamdCSDZV?=
 =?utf-8?B?STJHMkV1OEo0aGs0S3FhaEVFUjJZQU9qQ05qaXlBTzRNTW1uZ2JCVVVTbjRK?=
 =?utf-8?B?OVpoejA0cEVKV3dkdWhPVWNXMUlvampvNnBnUDFTbmg0bnNPYklhL3FlYjVW?=
 =?utf-8?B?anhpZm9UcCtEakVXdjhwSFlUQUJPbkw4bE0zNWdGVGhPajFlUURHWDIxSGpM?=
 =?utf-8?B?ZGNJVzlvVnRaYnppeVBIMzhRQ3RUZHlsT3RZaXZ1TGJJc3h4WGdhWG5Fakd4?=
 =?utf-8?B?MkFGLzhyVi9GUkdwWkZpSjlSZ2oyQVB1SnZkSTViQ3BBSE4zNk9rbUNpeU1F?=
 =?utf-8?B?Z0JCSFEyc1BwSzh1ZVExcEo0SVo4OHpFdS9za3UvUVZydGVNOTBjeCtVSTdq?=
 =?utf-8?B?a3RJQXJhNDJHYUx0MmpkNVoxWU42MEpPNFpOT05CN3JQbWRiTGlnV0REc0dV?=
 =?utf-8?B?bTVUZFhVaW92RmpnRTRnZU5iTG1Jb2F2emlrM1ViVWFFd013TzZVSmxkQ2F5?=
 =?utf-8?B?VzYyK3NmamVGdFFkdS9RZ04xM1RlWFh0enJsMUpzRzR0dktuMnpuZGZUYWQ5?=
 =?utf-8?B?S01rYjBDbVE4V21WVGNzbGRZQVpFajFwVDdrTTNOOERoOEpPdE5QaU9CcGRa?=
 =?utf-8?B?TGJIZGE0Vmo4ZE8walp3cGJmb0xFRm1JajZiM2lxcjE1QjdCMXJvV2x0ejgz?=
 =?utf-8?B?enFybjdDdUtxR3g5ZndZVTRnYnQ3Z041SThWWVBhRE5QZkJnZk5Wbzk4cENo?=
 =?utf-8?B?UTB0bURLR1BBdG53QmY3YUxHbENPSWVoVmxwcEU4dVZmQkdIZnU2THlvczFr?=
 =?utf-8?Q?CEAGLJbMJE1lvVnA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21d3c5f-00fd-4e62-2aa5-08df04542e4d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:59:31.3073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcs9HKdIjlzzr+ROURJb9dI1tVx547q2cxiaA+gOyDHdnACvyu8EnBbrM3cMAfaNBVsV+SPcVpPa4SEWtGacCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947
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


On 27-08-2026 12:59, Prashant Gupta wrote:
> The frame queue shutdown in dpaa_eth_rx_queue_setup() is too late:
> the queue has already been created and initialized by dpaa_dev_init(),
> so the shutdown forces a live FQ out of service and the queue no
> longer receives frames.
>
> Move the shutdown to dpaa_dev_init(), just before dpaa_rx_queue_init(),
> where it cleans up a frame queue left over from a previous run as
> intended.
>
> Fixes: 0e3c389b9e4f ("bus/dpaa: do proper cleanup of frame queues on shutdown")
> Cc: stable@dpdk.org
>
> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
> ---
>   drivers/net/dpaa/dpaa_ethdev.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

>   
