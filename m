Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD10C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 05:35:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 066134068E;
	Thu,  2 Jul 2026 07:34:46 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
 by mails.dpdk.org (Postfix) with ESMTP id B13D3402C5
 for <dev@dpdk.org>; Thu,  2 Jul 2026 07:34:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo4GEKPZY17rMWcStLuYALnqlXexqiZG9ruJj+fi8dalGp0wUnU724VhWsSibmUOG7iuBKxrLuc1GS2AsLn1oVq+oilvJE7hSa6p3d34YdAW5LRqqLxDe/k31oqtbAQfKCZZVepVboWL4p4GBxicBClHzIi6yekmg5iueYEG0OL0/rBWhoOB/HZGwe7Dk/OCkFiOJ6LmDlc7draej1GcOMQ4fJw6slSxjpGfyhPTFkN33ei6GZlhXs69HIXgMqZO9IYoFHjmYW+0sls9/6qkQnSJcqqv2odSvfpULx2/8x84LcFrjSNyTCc69gmqjoKgg64SXOK9379GrYickh2t7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/blCT+EbBm2jHK2p2muc7UWsQXr6D3bj2eQS+xlzcs=;
 b=Lx79zMNOhskk9UVZjtXeugevyUph6sewkeJgtk1bsSB9R1QyRR/x35BxMtL3RwA8Pj1rPZHL/zM927ZQsB2x2UZFB0qnqWDqNkQP4UMnWsjm6zpm2wPNkiwyNXxH1hSDZyAJHM2Dkot4DiveUgSuO0GU1gjnWE5OJRGvknYJPhx+Rx53AZpW2Vb3X07mo3vdyikOHD1ILvFCYe9QI+KgduZ+LLmoNK5tFVbxTBYg/asSFU/KNua9slBysUjKSjIG20KpknybkMonLUVJt0ziFfJcE5xz3vd0AjiJmnLGLxmhZEtjtP9xkydiWpQME/1I+VAs5vUwwT88r6kywMCRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/blCT+EbBm2jHK2p2muc7UWsQXr6D3bj2eQS+xlzcs=;
 b=eH3gcWbqIShG34RguxXdHL3oDBJeM08Hz7KRjjkImVc3XhIeJXwSyOJ9kf4iJddSI9f/KSreFJD4B336RO4Gnxjk/zcXztx/sQiKGygvGqFdPzZ6AvrXz9JeEOWFnzlAQeb8d5VWlWB+srHm0rhlpX5jvPgfBxUeWvQj2T8RgA6IMd7CkLATZAosZUL9tgdF73syUbWf1GehVrAxeYef9FLj5mv+p04qF/rm8CzsTSEJRJheIe54n68uTmhOkW179i/hINjPVB+dYNmtlPkxacivJJJYcfiEdn85C7q+iRUylUzu+LXAH8p3EK4ezzhnRxkAIBIqnRGT30jQM1vFmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by GV1PR04MB9181.eurprd04.prod.outlook.com
 (2603:10a6:150:25::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 05:34:38 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 05:34:38 +0000
Message-ID: <3d72bdcc-0f9c-4e61-a363-dcd294aed090@oss.nxp.com>
Date: Thu, 2 Jul 2026 11:04:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/19] drivers: release DPAA bpid on driver destructor
To: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: david.marchand@redhat.com, dev@dpdk.org, Jun Yang <jun.yang@nxp.com>
References: <20260621172731.2916346-1-hemant.agrawal@nxp.com>
 <20260626065655.279742-1-hemant.agrawal@nxp.com>
 <20260626065655.279742-18-hemant.agrawal@nxp.com>
 <20260626095901.5bef5e05@phoenix.local>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260626095901.5bef5e05@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0227.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::8) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|GV1PR04MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 534ea084-1279-4b85-2129-08ded7fb9b97
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|19092799006|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tZEEGeLJoesLcjQPjUJjzNcVv3oCVw1sYVmviyB3CiQuJ64fIyvOvViLt2ut4pupZhC1F3gYX+ZM0G5jWEfyYgg6CN1Mt5R6SQwxqnBu5kSaxqdWdm3yhF64B4yLmVdwci65qvBl7XfPX99KeWLeFYA4Qow+5rrG3P0lZ6I+Ub4Ckus2LejXQroVthHlZsXkiZQAaroh4uOPxr/8EM4CrLSzBZLg8UTz+4/aOHBu2A0GSgyjMPp8+/be0YtddEOS9gg++Nru2RePxPYwYlibJ6D6llJoftRJcV4lnHB+qHfXyHyDEXqqQDtmnw0pFIL5Ecv1C/5KEmT2QUIHvnV1R94Uz0ZegoNDu2txstAwF6bh4vF4uQfCW3H81O1dqOQ9/FiwbF4aLmFTXLICyW/jXo5yC1elgrCYnOIIuyaJZ+1slEPe1TGhOvNb5wS4GdlKEsX92yLB0/S5tD/aPSpt6vIJBsnHHhSzZ1/OP45cXh5sPQcJbAQQfpb4oxlk5KG72Bpp/wvIEnVqfsS1m2kHatJ4p4EGU5g28zJ7yuTKhzPtDwE5OKIIfn4gveS5ftnRwGU5l/Dv/KXV7Tdb0FHIfWSPEagu2ln8NpO+PlbwmyiDvglYPENFYjC3iqx30SEIqgOlvJS3iYmzMmer4pSFuyJT2Yci+OLok0x1v4xFwG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enM3V29NVmtRUzVxUUFqZk4zSzVtUERIZFUxK0orOFNqQ2VnbkxqSDFRNGEz?=
 =?utf-8?B?OFJ2dzBQeUFhSUFWT2s1ZVRFdVNrZnJIT3dCQkF5bHc1WTlKNnJydTF5MWYx?=
 =?utf-8?B?QnluODhlNXh4ckZsVGZBaXdUWHpQeVMrbHRKSnJYdzgwcUZhandCdkltMk11?=
 =?utf-8?B?VERJWlhXZUlqZkNGM3g0ZWhERm1NS1BUK0plV1hmZ20wd21HUFRrQjYrenJX?=
 =?utf-8?B?YmFveHk0OHJ3ZnlFa1Nta3dZYWlzSG5uK2JpRmZiSUFoLzFac1F2dTdHdjFU?=
 =?utf-8?B?Sk1KcEg3ZTlrMERvMzFPcDZZNy9ocC9qd25SMVk4OHZpalRGTnZkQVJzYjRY?=
 =?utf-8?B?ekJkWW9iUGxsbXc4NCtEYW9BbGtVOTYrZ1BEME1QNzFEU2xLQTEybE1kMy91?=
 =?utf-8?B?T1FVcVBibngwSENRci9MY0dTRG9OYXN1NUZNbGFqQmJPUG14eWZRK1BpNXEw?=
 =?utf-8?B?MFY4c0hPMmE4czVhZjdzd2NaRlRXdEUwSGl2d0tjVHcrZDBzY2E0K2N6a0RQ?=
 =?utf-8?B?TWUzb3BUVXQ0MzcvQVhiZ3RMdlpLT0V2UDhjdnFOOHF6UjBQQlM3QmhqSE1w?=
 =?utf-8?B?VDA2c3J2U2JVWWZkek1yR3RlTW0vQ0VkY3dIMVhPT2xvakgwNEtUZDlXcGx0?=
 =?utf-8?B?enJDYlJEdEhuWWt0U2hpYW9BUkxwVi84ekZoRzh3bFpqWlBiWEVtNUYxS3Vj?=
 =?utf-8?B?azQxT3lnU1QvTkVBMVcvRHh2Q2kwZ0pXUDlHR2RkZTFqS1ozQlRuS3VsRDM3?=
 =?utf-8?B?V2J2L20rZUI1NFV0SFZiYUMveFlIK2thZzVaVnc0ZFZhM0FYcEdMSUhKY0hs?=
 =?utf-8?B?cTgveXE1TEhqNDlhSjdiOENuVHEwYUN6WEk5amE1UTZYL25ZY25uaUZNY09Y?=
 =?utf-8?B?ZWpkVGpKN1ZuUlpsTW1sUWZJSktseXBYQ2p2eTZKemRIVjBIeUg2eFI0RUE4?=
 =?utf-8?B?eFQ2VDVNMnVTWVV5UzJyZGxWVU0xMFM4R0JENjF6U041Ym5BdG9TcmwzYUNr?=
 =?utf-8?B?aFhFK1VxV3RnS2M4TU9IdzN1eS9oL2Y3dkJueG1yK2hBaldnZFUwWmEzZEhU?=
 =?utf-8?B?VXcwZ29tQ1B3RGNvSElSK01Ec2x0eU45YlpmdFhta1ZiYUUrR2hnbFFyZW0v?=
 =?utf-8?B?K1IyUEg2eWN5b2QrMEVqckp2bVR6enZXMmpnanJQUlR6anlMMnpjbTUzM3JP?=
 =?utf-8?B?ZllFK0xnZnJVSGdRQWFvbUxiOTBxQmxobDZqVUxJd0w3bTlRWFZ4ZklRMk5r?=
 =?utf-8?B?TldPa1VFdjZrQ3pjb0N5QjZzTFd4eTRjSGR0S3JFUEpvT0MwWWVqSFJZaFA3?=
 =?utf-8?B?ZGNYdm9hRHVQU05nWVA4eHA1UDlMK2d1bVlRUy9YOUV1Y21kbW5GeVZxcmlV?=
 =?utf-8?B?UHpnZVUwaVViM3VRRTJiUFdiTW9lUm1EdmNGRWJWYVU5UFg1dzd5NWwrUWVQ?=
 =?utf-8?B?OWhHNmVmOWdJVWQ3VnNLSjVKUGRIUHR0YzZpaVRxb0pmcDBFeE1vUUZocGU2?=
 =?utf-8?B?TEtNTEprRGZQMzEzS3hkUUZHQnNtNm02eDJ3UTlmNjM3VWtEZHRwQnBuc2V3?=
 =?utf-8?B?bitoUWt4WSsyK2xCWXVXNTJ3cDIvNU5vY1lHVk1jY2RXUTMxVTZORlU2U1dk?=
 =?utf-8?B?YjFQL3FVRmtteXFJTEI5OE96elo5RnpSdExSZ1VvenRUWTVVTCs3Rjk1dTht?=
 =?utf-8?B?ZFVxRVRZT0VneDN0T2JaeHJ3eVRCSldhRTdjRW5COUozdEg1YU5QMTdySjVJ?=
 =?utf-8?B?OER5eHdtQVAyYk9HMVl0TnBXQzNha2tOWFpFU00zVjJMQldKSC9YUHFQRUtI?=
 =?utf-8?B?M0ozb3JjejBpOFFlbXlrbWIrNnoxUzBvSy9jdmVOekhNdUhUeGhoM1Zib3VI?=
 =?utf-8?B?NjBpeVBQR3g3b0c2cXVJWW94UDhwSWk4NGFWN0NCYXpvUGg1MGgva0MySytS?=
 =?utf-8?B?TWFVV09yVy9zNkRCSkJhczdMUGJlS0oxTEtrNTZQY2twUy9EcjkvaGpicGRO?=
 =?utf-8?B?cEVEdFArL2ZtUWdibk14dzNSUWNEM1R1eHdEQ1daV0FIUW5sN0dGaE1pMTdT?=
 =?utf-8?B?TEpmRGNDRzhSZGhwN1FYb3pXQW90TFpnZEdEdHJ0UGFMNHUyU1l3MXVIUkcr?=
 =?utf-8?B?QmloSTZOeU5SZ2NaUnFMR0szdU82UFNkS0hyN1RQUkhsREIvRjRFR3dlMVhC?=
 =?utf-8?B?dkE4cWVrU2dSdkVFdFdKRVA1WFRwdDl5TVZPVlJNZ2lUTDdDbEFFQlNUemZy?=
 =?utf-8?B?L3NRK1NJazNEZ1UrRVRUYnkvQjAzUGhZdG1zV0xNcVdDTnl4eDd6MGhlVlc2?=
 =?utf-8?B?Y29LSWJlMGtYNmVraXpoTmZtMmdKaHR3SHVORy9wdjhSM25hV2tWQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534ea084-1279-4b85-2129-08ded7fb9b97
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:34:38.3846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QscSH/wCDYw+tZNk1E99SGSCAh9PPNe/CDHntb753wU9a2FSG2Iug69lig1/5yeNMaNTqXjisbSdw43PCfrew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9181
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


On 26-06-2026 22:29, Stephen Hemminger wrote:
> On Fri, 26 Jun 2026 12:26:53 +0530
> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
>
>> From: Jun Yang <jun.yang@nxp.com>
>>
>> Track allocated BPIDs in a static per-BPID flag table and register a
>> driver destructor that releases any BPIDs still marked as in use at
>> process exit. This prevents BPID leaks when an application exits without
>> calling rte_mempool_free(). Also tune the per-lcore mempool cache flush
>> threshold to match the hardware bulk release size (DPAA_MBUF_MAX_ACQ_REL)
>> so that buffers are returned to HW in optimal burst sizes.
>>
>> Signed-off-by: Jun Yang <jun.yang@nxp.com>
>> ---
> Build with ASAN fails with this patch.
> Simple fix is usually replacing all use of rte_memcpy with memcpy.
> Rte_memcpy on x86 confuses ASAN and it thinks certain sizes reference past
> end of buffer. I would just do a global replace of rte_memcpy with memcpy
> across all of drivers/bus/dpaa none of this is performance critical on old
> versions of Gcc which is the only reason rte_memcpy still exists.
>
> This needs to be fixed before merging.

for now, I have fixed the affected patch. replaced it with memcpy.



