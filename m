Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6213CD98EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 05:34:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4F3440276;
	Wed, 17 Jun 2026 07:34:22 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
 by mails.dpdk.org (Postfix) with ESMTP id 682764026A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 07:34:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMik+74/bWh0pJCx1lpxJnZvwCv2k+nyJl00aAb/iMT1dWLta0h0FXDodTyCH39wqBpFKPrqfn6MIcsXztViJOUQ4F2q9DIzP9BosmLFNdSEQsgAVWKkdOBNYKyMIua8NCy4H3bA0gic+TtKAsBscIqxYph8/tB54EbnSHYB7kHM6CF3H9cx6DOuvGTGIVXWAHrZMnfG1mj2J6nhfZn51iqtKV84Ek9prUd+um/Efe+GtQkoLlNwg2ZyGrwq3AOiB16MVGCO5EMHkillMRK5j6ou3jKsaIFxWMgWag68Uqhv/rBM6gpsaFo9TA/foj9ymZD7GnruoAkGe00m7i7YxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLq2TUjPILdWIASNKuzksAzIa7CkaDmz5R+hk4LFm9Q=;
 b=cBTbQtYioz6j83KEbE4lcsBe+q7s+ZpXADexM71vHn5M1JMI4ADXz4SBYUmcRySVRtynWW4x4N7se4t5PAu7P+7NIWlhtgJ79ZzcMeT9IlY8Vpmjz3bHSs4YBdEcyVLWhKonNMhdGsXuyMvfNchxTh0WktSzlBP6n/1WejZRxOUNN6VnE5mUcN9dUd8h567EIaFu7vskg/SufieL8yw6V0S7Bl06JkpL6b/WjdF8qxeyk/dgfXY9LX1CauuZxAEscWksftb69Gic23pgAgzAJBM7ebB/hoqQHLsF/mdJFCcfzM1Wa7+clcrmkOl+3tAS4zic4EFgTPfkg4UWra6W6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLq2TUjPILdWIASNKuzksAzIa7CkaDmz5R+hk4LFm9Q=;
 b=jwmzfdE4HI/sVU2QV3SywtzD0q2JPJvaQeMMFjIDv2t8ESvjvh1sUJRtPx/HOYI8YGc3yyzYLGWtyyJPLZ3pr4viNaM5Eijy4FMgz1lPzBtDsFTxOl2o+TmeJeTFAxggMUKc7lwJ+jWKZ0+KZVpnYjsyaapi0z6A9tKrSlAg7n3A9uekDnxMCkQLy3ptqINcH7Blgm7APy5Zx8S9e9NgNuSQ4b9L2iV0xL4RkO1o8sK11nKV++nLT2Rp9o3eBWiE7O0ZTE/zStWBX+5x3m2dcvrthpWnOk/PrNYQ4fjZRIOCHHAp9E5TRaHSBvfcUDeq1Np9gYWd+fUeX2fRPug8Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by GVXPR04MB10707.eurprd04.prod.outlook.com
 (2603:10a6:150:214::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 05:34:19 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 05:34:18 +0000
Content-Type: multipart/alternative;
 boundary="------------waa484eGo5eI3WQPnbY2PG6K"
Message-ID: <2960c0ce-95e0-492f-afeb-4e91c3059902@oss.nxp.com>
Date: Wed, 17 Jun 2026 11:03:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] net/dpaa2: RSS fixes and improvements
To: Maxime Leroy <maxime@leroys.fr>, dev@dpdk.org
References: <20260616104717.723087-1-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260616104717.723087-1-maxime@leroys.fr>
X-ClientProxiedBy: MA5PR01CA0250.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::11) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|GVXPR04MB10707:EE_
X-MS-Office365-Filtering-Correlation-Id: e0428c87-b15b-4205-ac47-08decc3213ba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|19092799006|11063799006|56012099006|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wDAjzgB4CyLAi1u1Q5Armx3M61QI4mVjSoXqROYrXUxNLAtMkob01rcqpjImo6/YsdjTIX6hFAZbnzRVuQ3MpycaZ9ETBc0E5IoR1ji7DLInV9mFKmFNmPkKq7r6B8vQ8VcL7VN+uTVo+8jqm1jv/KOpyoGScKmk2vB6otVpLXE04ESfBUNyOPtyfkk29+7iNnXw2wnPlO3OkxQykF6Wgf3zcsZTs+7xoXW/+DkeSczmvWyZJ/hshyAPUFp5YQcS2u3JifguDfv1JRKGlxsvF0jml4jnioGUK/TYJzjwzCuho8h8JHPvSI8iNM272ZoQH+6BRgqE5aUxmaY/t/rHrpgQw6nmmZm/xrnNEx5qMIw0dHX1DLdqoNGpQ4XJ6TxI4t1ZpvW/ZmMytrg30MseKhPqCLnzJwt4OCSyQdkp19Dmd/Vz+9sVDjcUNLlwYaYOZ8huHmR7jNo2NNHSyTyfh2TwMUaJCWUlOEgBmjmc1lZUdeBryD+r+g1UF0Mo7NljFcW6SWLfRfWHyxo8mjxsPeWHbuyP1WlUwFpoT2SNFN+feIcIZmRCm8Eq8b9llDU07u+esRnqY1pIsSO2JaR/0nty6cLaC6yLBb5vKPNowr708tYDQ38QsSatBLBmW2TGPBXNyllgRCQ8m8XHFcfjqHIkeYAtYhIGvlRjrreol59d68+5egruJs5OoaqiVXYE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(19092799006)(11063799006)(56012099006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0kxRVhweExuYnZLM293czh4Y2o4eTNuQThkSHhPTkhPb0dYVkxMUksvQ1Zr?=
 =?utf-8?B?eFRPMkhiM1NDc1dXQW1XY2RPNlNHWmwzRjFFbDdXVjI5Y1NyMTkzRlN2TVJS?=
 =?utf-8?B?MU51TDQ4UHJFRDJORXJ1ejhXdGNma2NDdmJ1TmJJNmdOZHpJZU56OFdGaXpn?=
 =?utf-8?B?YWFQOGpNSDN3WXhiVGU4dHVmS1NMbnFEQWo2R1NUODVwQUU3elVQSkgveUhm?=
 =?utf-8?B?Y3Z4NGh2dVV0YmEwL282NmFuQlB4a0d6ZGVUY1hnMzlyR05GSHZwR2R2TmNu?=
 =?utf-8?B?YWdhM1ZHOWZNY0p3SS9QMVdpUGU1MWF2UkVlR2xXUmlhM0dOeWxuV1NjbHc0?=
 =?utf-8?B?YjVuR01RQzA0MzVVR2swVzNZUTFXbGtQc3NlaVNrb0d5NmMyUDh3Y0ZDdlg5?=
 =?utf-8?B?eURGQnBvdHVSU3FmOFMyYUZ3REpVNjRSZ0tLdlZpU2JMaExNY3dJOU9sVzkz?=
 =?utf-8?B?RVcwb0VxdzdDbTBOanhWUUw4MVBBTFllVDdYRWszbVR3SnhhT2t5Y3UzSWNW?=
 =?utf-8?B?L0pTSDZuaUNTampJay9wWE94Q0FQUTI0eHlyTVZ1Y0NYK2h2V3U3UG5XelhF?=
 =?utf-8?B?REdSUVZKQys3bFNnTVhLd1FqcENmbVNxeWRQV2pLUHVud1RodXJlSnZtVldz?=
 =?utf-8?B?RzFUdkxpTnNNaHBwQkFMOUJKcXNCMkxYeUo3b1FaNFhpZVlVMDlrYUdGT1cr?=
 =?utf-8?B?b0ZhbG50ekNTSmsvZVc1SVN3WHY0TUVkN1NEVkh2ZXZFU2RpM1BNZmRHOCtz?=
 =?utf-8?B?dVBaWUVkUW9ZK1V5Ri9LeW9GUnh3Q3RaVFgyZzJVWEFnUXlua1RySUhzaWVy?=
 =?utf-8?B?YlBTN0Fyc3NjV2wrNFRJdEQrN01vN3dxblcwM011VzliaXN5REF4UHJkVm91?=
 =?utf-8?B?cnhXTklHM2F1cXNwb21iblRFK0huK2M5MURyYmJvQUxjYVdtMExkMzhjTXZx?=
 =?utf-8?B?d1c0ZkFJcnc1d0cxdkN3d0NqT2pPckUxSGxoZ3RpbDFmOHZyV2JIYmxOUWhD?=
 =?utf-8?B?U2lIeFh1YjhySU4xcHJxTCtXOEdZY3JIRnN3NVNMTU4vbnRFVG1FWHdYWWpz?=
 =?utf-8?B?b1FlbnZoT0ZlbExLYmFUamdFZmdBSlFZY0NRSTkzY2dCUXNvT3JlZno4YjRO?=
 =?utf-8?B?THlYbUIra2VPQm1EYS9OTytHcHlFZDNCVkswUlJBSjhRUHhHTEYyc3Qva3J1?=
 =?utf-8?B?ajlkeTJSdGI2MVduSEo0RzlEaWNtdHhUMmxUVVlVdm5pRC9XcXgvVFNMWUxW?=
 =?utf-8?B?bGlqSXRYaE04VWxpYUIvSzk0Nkk3RGFZQ2pka1k0c21tWWNXQUxUR29lUjZw?=
 =?utf-8?B?WXFvbnJlVVdFYk1qR0ExWGdoTlFUWkZreXk5YytGYXlwYkN0ZytpUm82ckN4?=
 =?utf-8?B?bEdCM3Z4WnBZdmVWVkFtTk55bzNISGtjci9rbTZneFRDd3p3MmNWcW9KakF2?=
 =?utf-8?B?ekRocXVWZmhST2FBK1YzRlNvd3pZQ2JnOUd6bm1ZOHdQOGJud3BMYXRQN0FJ?=
 =?utf-8?B?VGREZkFVUWdST2o0bVhLeG1aRzdMK0hyVlNHRVlEQVp0b1JrTDUySzczY1lz?=
 =?utf-8?B?aVNLL2ZBUW9yNEhINDJGKzI3VTBXZVFoM3NKeHh2NnM3TENiN1VVeXpvemhT?=
 =?utf-8?B?WmNTUXFWWjhSdEJDb1A0Ymk5L1BrUlQ0eVNiVFZmT0FYOWkxZkYrcDNTM01X?=
 =?utf-8?B?Tk0vZUppMDk4NXozWjVvakdtWVZCQUhVZEJiSDdJQ2ZWbkRjNnJKS05wVWs4?=
 =?utf-8?B?OEZWZ2ZQdU1ETm5sWTR4NTBuYTlVYUg1cjNvWk1jSGROZWVaalpPNHg4TGRZ?=
 =?utf-8?B?TkEvZ0pUbjVMc2RTZVJuOGVhQ2hWZ1BlNGtlRnpEVGJSTXAzeERvYzd1SVZ0?=
 =?utf-8?B?Q09ZYmQ4dWFiYU5mMVVZMDlWNlBBeGFMbGxTT0plVmFtTlFUaVYxc1VBT1k1?=
 =?utf-8?B?N0pvSmJyWmtCK0wvd2NmREZyc0ZiVFpRYllzcHh0Z3piemdvVzNqQ0dQNHdJ?=
 =?utf-8?B?WlFQMDVuUE5qNS80WlZyalFrMHlTRmtQWEhhWk92OHdVMGNSTFl0WDl6SWEr?=
 =?utf-8?B?RkR1ODZ2RFlLMVVTVXNucmJoYU9ra3F0Qmd1T3Z4cnNXRnJIN2JVdnE2VXpR?=
 =?utf-8?B?UkQ0VXMyalIrZERCS1gvaWtsZXc0V1pHby9WamJzN09EQlo2Z2N6c1FidVpE?=
 =?utf-8?B?NG16OG9TejJFSlcxYis5bVJVMEtPNnRKTEtjOWRNRjVWLzhwd3pLekhIZnoz?=
 =?utf-8?B?S2d2Tk1oWnpqM3hiOEtBQkNXT0FHRlRJTGJMbjRpTVBrcSt0Snc2bGNJZnJT?=
 =?utf-8?B?clkvcVE0NFhxZjVnY2llbjd0Y1loNS9BUlpObVhKb1pSMXZQRDBabEEyVlJF?=
 =?utf-8?Q?iG5rkLaa6qtNFmiI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0428c87-b15b-4205-ac47-08decc3213ba
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:34:18.8709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIU2G/2a/OsRW8PzomJ4EB7WwbGK8KSALHzAQ/3oMdgeiidchxKUpNPYRXymlq8uScqEIZU2ikJH05klFWR8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10707
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

--------------waa484eGo5eI3WQPnbY2PG6K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 16-06-2026 16:17, Maxime Leroy wrote:
> A set of RSS fixes and improvements for the dpaa2 PMD.
>
> Patches 1 and 2 fix the RSS hash key: the L4 destination port was never
> added (both extracts used the source port), and SCTP now uses the same L4
> port extraction as TCP/UDP. Both are tagged for stable.
>
> Patches 3 and 4 are small cleanups in the key builder (a dead num_extracts
> increment, and the unset PPPoE guard flag).
>
> Patch 5 honours RTE_ETH_RSS_LEVEL_INNERMOST so tunnelled traffic hashes on
> the inner IP header. Patch 6 implements reta_query / reta_update as an
> emulation over the HW distribution-size mechanism, since dpaa2 has no
> software-visible indirection table.
>
> Tested on LX2160A (lx2160acex7).

Series-

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

--------------waa484eGo5eI3WQPnbY2PG6K
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <div class="moz-cite-prefix">On 16-06-2026 16:17, Maxime Leroy
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260616104717.723087-1-maxime@leroys.fr">
      <pre wrap="" class="moz-quote-pre">A set of RSS fixes and improvements for the dpaa2 PMD.

Patches 1 and 2 fix the RSS hash key: the L4 destination port was never
added (both extracts used the source port), and SCTP now uses the same L4
port extraction as TCP/UDP. Both are tagged for stable.

Patches 3 and 4 are small cleanups in the key builder (a dead num_extracts
increment, and the unset PPPoE guard flag).

Patch 5 honours RTE_ETH_RSS_LEVEL_INNERMOST so tunnelled traffic hashes on
the inner IP header. Patch 6 implements reta_query / reta_update as an
emulation over the HW distribution-size mechanism, since dpaa2 has no
software-visible indirection table.

Tested on LX2160A (lx2160acex7).
</pre>
    </blockquote>
    <p>Series-</p>
    <p>Acked-by: Hemant Agrawal <a class="moz-txt-link-rfc2396E" href="mailto:hemant.agrawal@nxp.com">&lt;hemant.agrawal@nxp.com&gt;</a><span style="white-space: pre-wrap">
</span><br>
    </p>
  </body>
</html>

--------------waa484eGo5eI3WQPnbY2PG6K--
