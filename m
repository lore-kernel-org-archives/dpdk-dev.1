Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB45CD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 04:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF8524013F;
	Sun, 21 Jun 2026 06:28:11 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
 by mails.dpdk.org (Postfix) with ESMTP id 09B25400D6
 for <dev@dpdk.org>; Sun, 21 Jun 2026 06:28:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQFNj37JPkJxt7qpOf5FW94USavMcEO3U/Mw+LLJAVcXogLDqZ0g86R5s8MCGGZhog+qWP9UZk4OkKNkTWaiiFSY72wMmIU163JXg1/SOv+1KaK+xNRXquG5KrhDtIbMQexsx9BH2y0yGF06kcSemWYmrmZExcLheZKxcqpMGmGTZwiCFXJULbd2RD8O5XYzvO8qsekyjUO4/FxuwuF1/8AvCBhuMqRwEYCaheomv/EhiUKt03GSIDYClQ+hNaE6BB62L0x3boz+C1ssU0YzKN9+BxBJQ/bIXfgaTiJRElB+Fk8pnc5wV21eeggNgxAs+AJlkSzhv06XHVrHNPSBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xswR5TiYqlMF7HHozTDdiVWVxDlLxXbJYSU1Vwgm8cM=;
 b=Fm3ejmu/9SHJ/5Wg2lEqHeih3CPzTr+1KCcvoa+aXLIGL4nWoM1/5LBae2LmQnVIZFNeWu/3olNl4iwFhRgrw+czrSdjlBP3cbHVjNTAjUisbaPJlK0iJdebe31PYBa5dr8lG8Xr5FeFUneI3pHJ4MEzWpK2DRKKh4HU1k73tv8qcSrOcia4+/NiG3tP7DAGD+N8YTQUDFkvVDi8gjxYTfM35NKSY7YSvngs6YiP+aAF2G4BEWwQYzqNZYnTFtUr8cVk1fSEGsxlBqq/M4KI2ihw/w/OkZMeoEet4iV0Y+3Mgnhk7JyccHFaoG3U9EtsUhVwlsgfckM+tCxL01vXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xswR5TiYqlMF7HHozTDdiVWVxDlLxXbJYSU1Vwgm8cM=;
 b=Zlei0t99JWJmLVQEDMaqVVR991HCYvvqj1gDeJhc/JARx07xiHHtaKF3ipAof/vfDl+BurWIi9V+ljHK99EHPbuiKlAyEuTe27cc9KNsn/UQk321r/eE/2WGLNb6kvVAlJhkoOzon+Pa6zt/9HKbohdbFqRQsBZE3fmYak5Er8tZ1RLWQPeoesRz/3OsO/9hdMs7ioKffYV313yZDKgHjeMMUGgWPaehpSy5sGB8lSy5KMGu050vCtCXWw1UoEZa5gfDoWP8y3pVj89ShXvYlY67c3HpzmNHOaF1XJB2YHg2O+ivOajhxLueRMSmm6QmPQ6wSPFR2uj30w6fLWN8pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM0PR04MB11855.eurprd04.prod.outlook.com
 (2603:10a6:20b:6fd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 04:28:05 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 04:28:05 +0000
Message-ID: <86091477-d553-4ea1-879a-4c3f1753a130@oss.nxp.com>
Date: Sun, 21 Jun 2026 09:57:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/24] deprecate rte_atomic functions
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0267.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::9) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM0PR04MB11855:EE_
X-MS-Office365-Filtering-Correlation-Id: 426b19dd-c985-4ff7-8f1c-08decf4d7cf0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: ydGgORxVCiIJmSrU4YjtEobj2+wjGrFsFJGZFPQUzJ5fnI7NcziMO4MP1ZHRLPxiNlq3cIoDlQ+3lMgzdfrINA8jUBlsNMNSRIz1KMHh8HPCVvfA3kHDQHhDSnaktke3mZ2IGWVxKftdsOLUCFY4lvh2Eor8eTcHP9GaMjykw97jX0wRsp8aOiw0sBvxwgty9a2yHqemKbfXR5gpOdBJZMvlpTJfJV1RccztNC753L95L5fwmGhy/g31nw1cXwRfF9Hjzu77BK3UJxXRhtEgGkn7Li4waLZN7WhfJc1bNv/Xq7XPrrIyTua+N+oXfrOQSxdktp84W4Orm6mY8bUj/bXo/vnmQSsAHU3/D0Sz0H0Xepxv9Y62YSHDPyZlrllpTIjYuH3DnQnoKMPC7MLEyolX5lknatyKdLFSVhDT3wVEnvv3dC+m4zxRiufalJezvdiTVsPLGMKQq0d8NfozG2BLNAH54338K7A94PLgPrbPPFUXpSUHm7JlIgToLqp4YT13Nj8UCyJ8bDvRlIqvJO6BIq7xQqka5bX1e9Inh8XQYDFtdj3gnKxTcTgJjFslNdqR0pIWQ8Oczj3IoAaRyQRkGC7nlGHLMvs8wfNNCcgoOCyc+Oj8XkzBu0OMayWp5ky1VVmigTT2QI858ryo+9diB4iCdkWR6ltrJmS/gtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dExRUWluV0VJWmJGOGgwM2xPQzduMkJtSFlHRzNlN2gyS0lBVng4SGJXelpB?=
 =?utf-8?B?TGZySTBrWkRhc2NrMXdXQXZCTFFGdzRhaTBhM1pNNEoxUThENytOVGZXSm1w?=
 =?utf-8?B?ejhZVEFTckp4bE9YY295ODEySUVIeTBKQ1lGT2pnUkc2VmUreHZNYlRUVUli?=
 =?utf-8?B?ak1RSnVqYXRGYXM5YU9RUTZGWkk0aHRTRjc2Wk4xV3k3WVZ4T0o2QkZ0dDVl?=
 =?utf-8?B?b082bzNhcHI4OGp3cHdrVXNEbHRXc1RSOTBCckZlbjZ3WERTbmpHdjJpaXhL?=
 =?utf-8?B?T1JucVJkL2RNUnFkL1hJZjlyVjVRZ25Vb01vdjJUT0loTEFWS2ZyVUV5VEp2?=
 =?utf-8?B?WTBLRTdlMnVZMVV0VDBMTUdobDAxNFpncTdHS2NZdzB1WXV1aFBZa0RwVi8z?=
 =?utf-8?B?WVJUakludVVXTnFZWEZHa3RiNlp2U043ZU4zTm9sdDczTEthV3oxZDZ2V0J1?=
 =?utf-8?B?dkNJNU1vdFdVQWNPVFVXZ1J3TVdmZWJBZjBScTlZVVMrWFIrS0UybXFXSUNi?=
 =?utf-8?B?cEpZK1Q4SGlWOVQwOUhkbFlwK083aDlrUFZEVlBjcGsyaEEvdi8waTZNVUpG?=
 =?utf-8?B?OHVJQmJyNDlUdFRQMVAzRGlQUS9zcDM2b1Ridis0akpNbjRGdS9HU1c3cnhq?=
 =?utf-8?B?OXhwc1ZMbEdsNFFYMjVQd0N1WUw0VFFJZ2pGeng2L1pYVkFwbUY0cVRpMG8y?=
 =?utf-8?B?a2kxZE8vZElYKzBVUWMrZmVxNWJWWUUzZk44QlNGdU9uc3FBYStHdTVIbjFN?=
 =?utf-8?B?dXBGNVIxLzFKa3Q0U0h0NVpLTnVsTnIrUm8wRmxzMzBMb21ZYll3cVJPbnhK?=
 =?utf-8?B?V1E3N04wSXp3ak1EMm8xT1FqSXRmSHBSeEZicEVuZ3FSYTFOZi9kVFF1cmhz?=
 =?utf-8?B?RkYzUTk3LzNaaWNQMFlBdEZzVzM5VnBnZDdTWGk3bm5ReVJwQmVvZGhmNS9W?=
 =?utf-8?B?YzFhMlJSMXVnZlRndHhMTk4yaGVtTGlsV2J6ZW9iWVlxZS9yeG9MVTBmV21Q?=
 =?utf-8?B?L1NuczBtZzgxa1NPU3RmSDliYVZnS1FUTU1QajBBS0NWMDAzUnJ6cWwyM09V?=
 =?utf-8?B?ZmREZE5tNGFiY0VxaGFCUWZFdmkxYzZqU1JBaVcvR1pSU1l4bVU4VFIzY3Bh?=
 =?utf-8?B?YUNsV0pLdEdQbDdKZFV2c040Q0ZvdXNFWEhZSXVoY1BrcHBGOE9OZXNQc1JM?=
 =?utf-8?B?WFV4S0ZpM2QzVGJhdWNGeGdEMjRSTVNPeDZyNkMveGo3V011WDlTaWRsQWZX?=
 =?utf-8?B?Tm1sVTlUYXdCTnVZeGFBbEM1RGU3ekZmdDdWd3VNNGFyMXQrdmM1ZlRkTEJK?=
 =?utf-8?B?TG4xVVZqUFUxV25nMVluL21LT0N6dGxyeGh3Z1owZDkzdVUxUUdjdVRoWXZr?=
 =?utf-8?B?ZkcwWDM2ZFB2NkRaWGlhNVFGT0QrN1VnL2tNYndtL01hTHg1M3RVcC9iT1hx?=
 =?utf-8?B?cDdEYTRwbERGREV2eFRrU2N4Z2FScTRhN0VxSWVscXV1SUxLdE1QVm9IRzVj?=
 =?utf-8?B?b2M3RkRoNnZDL2lPL2wvYStSQkNKa0tzdHRzVEpoUXdUYURNaFRRUmNPMk41?=
 =?utf-8?B?QXVDVDVsdXBTT2h2QnVJKzdWU1Z1c3BiNStzcmpuazgxV1NDS29EM3JleGgv?=
 =?utf-8?B?NVJlcWUwNWFYYU5KYU8xUXFMMGd4M2o1UGdHeTRBbUV3SVg1Mi9QRkU0N1Iy?=
 =?utf-8?B?ZGpDMk9DWjdtTE1LVFNPQ0tObm0zc0x3a3U4TThKZmp1b2tYeHFiN3pkVFR5?=
 =?utf-8?B?SFhZdUNHU05IZDZ6NEtyWFl6YzRnYVhyZkYraTVqQThWQVB2NzJySlR2UFRx?=
 =?utf-8?B?Rkk5WWhsMm5iMVlTRGpmci9BWHE2c0JnRUVpOGVZb3J5cDBrN3lQcTFCK1hp?=
 =?utf-8?B?YmhId2ZKM045UTFzY0Q0ZlJvU3ZnWjVsRmVkcXdkNHI1WEgvWnpFWUNaUUtE?=
 =?utf-8?B?bHE1YzlDMVNSc0RlS25PL2tDNEJrcWU2RkMzWS9lVGhUOGFNS3QrRDI2WW1G?=
 =?utf-8?B?Sko0cVJaZ0ZHUDg4c3RMcnphRzZXcDVhbmVBL0swdzFUTkdGbzIxemxOOS9S?=
 =?utf-8?B?Q3dNZTNpbWJyM1h3Z05aZHJCM3hkayt0SXJsSithcGFtY1AvRXZjR21DVlQy?=
 =?utf-8?B?dlhmQkJ2ZndjeXpzUmRSUCsyZ1JtTDNEWklLVkJZdVlFb0g2MWxVREU2R252?=
 =?utf-8?B?QzR2dnU0b3g0ai9QcnFQbjhPWHZVdkhVc0J5YWhCOFljQVVGV05icXJ3QUJC?=
 =?utf-8?B?S0dIQWFTQS9QUTM1c29Ya3BZYW9hNjNXMzZjdzRJWHRKZ284TWF2SWFPUXhp?=
 =?utf-8?B?ZDZmdUpsNFpFUjlCS3FLZitCaGJWcS81OFhibkdyR05OVXhhTEI2a2tnRlVv?=
 =?utf-8?Q?WmqjpLpjHBghroCM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426b19dd-c985-4ff7-8f1c-08decf4d7cf0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 04:28:05.2026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2syKyZS8A/mWffThA3QRuDE3fOjqqIDSgXmJxwQkh9YFKsWFRrV+wSJs8pwAXe70ZG4YOgwcll7CT4D95thuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11855
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


On 20-06-2026 07:58, Stephen Hemminger wrote:
> The rte_atomicNN_* family was flagged for deprecation in 2021 by
> commit 3ec965b6de12 ("doc: update atomic operation deprecation")
> but enforcement never landed and in-tree usage continued to grow.
>
> This series finishes converting every remaining in-tree caller to
> the C11-style rte_atomic_*_explicit() / RTE_ATOMIC() API, then
> marks the legacy functions __rte_deprecated so future in-tree and
> out-of-tree uses are caught at compile time.
>
> The goal of this series is to get driver writers to review and
> test each change.
>
> v5 - rebase now that ring changes are merged.
>     - drop the barrier (rte_smp_mb) patch not required.
>
>
> Stephen Hemminger (24):
>    bpf: use C11 atomics in BPF_ST_ATOMIC_REG
>    net/bonding: use stdatomic
>    net/nbl: remove unused rte_atomic16 field
>    net/ena: replace use of rte_atomicNN
>    net/failsafe: convert to stdatomic
>    net/enic: do not use deprecated rte_atomic64
>    net/pfe: use ethdev linkstatus helpers
>    net/sfc: replace rte_atomic with stdatomic
>    crypto/ccp: replace use of rte_atomic64 with stdatomic
>    bus/dpaa: replace rte_atomic16 with stdatomic
>    drivers: replace rte_atomic16 with stdatomic
>    net/netvsc: replace rte_atomic32 with stdatomic
>    event/sw: convert from rte_atomic32 to stdatomic
>    bus/vmbus: convert from rte_atomic to stdatomic
>    common/dpaax: use stdatomic instead of rte_atomic
>    net/bnx2x: convert from rte_atomic32 to stdatomic
>    bus/fslmc: replace rte_atomic32 with stdatomic
>    drivers/event: replace rte_atomic32 in selftests
>    net/hinic: replace rte_atomic32 with stdatomic
>    net/txgbe: replace rte_atomic32 with stdatomic
>    net/vhost: use stdatomic instead of rte_atomic32
>    vdpa/ifc: replace rte_atomic32 with stdatomic
>    test/atomic: suppress deprecation warnings for legacy APIs
>    eal: deprecate rte_atomicNN functions
>
for dpaax/fslmc patches:

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>


