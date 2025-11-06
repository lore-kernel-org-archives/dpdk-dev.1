Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB4CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 16:38:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2F92402CA;
	Thu,  6 Nov 2025 17:38:31 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
 by mails.dpdk.org (Postfix) with ESMTP id B16A14013F;
 Thu,  6 Nov 2025 17:38:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH4MbY9LqSL34FVEfcCFY1S9K+Ss8j+5Pdc9d9MqU8qz0SdXxNJPgbl/gV3nj3nj3lD/t+kCe0050RepPmVcQi4HCxw5lCBV1ovbFlsqsiq3VYtG4HsbD1FxRa/bB64AfFl7XjgCVrjvyJI11U+qyRmZ4+CBJj9QYtrK0v/kSa6sNsx92GjGpIjHRgyDdOfJPVHZGxfLYvboVXSZLYGfB5NodST/n3aWkDE/HbnjKFIzijRmLZXhR7bBobNHKQz8JugDXkNKhWDDoKUJkkViTH7plR2Bh+aJjtCoH1hUEXbPjNwje1iT7owNsfdKExMVRRyhgV4KmXp32pQYKw4uLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An2fI9uXiqi62zBT1xrB06ulUBnsIdvigUDLa93NbjQ=;
 b=Uex2LUNbuZqRZCRdWlQcp6muYlplGRBDN/P06UcSamtIPl1APyeWLQWpblSp/N8M6w/ZPC3T8grmf2ZbHzJsvTGRA2OmlZ4Cmr+gU47ZHvqaM87yXZ4xqBK1UpLSEEz3yVcYsoR1sAR3VWwRItcWCJgetDfdvgVQqp/x/lFAr4+QdfZ/P273qbR0Kj82uaSpc87tc6oXiarqW4izN1h2D4L/IIH6H/68EUqg0KVzp+MYi5lClmLIQGmxFf2uazCqeJRx34lhWwpAaksMhILIWukkpXkmPOQ98i8JdMcosZkXPh8oaO+apXG7l0bDZNiAGjrbQXLieGLeg7lFF1/9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An2fI9uXiqi62zBT1xrB06ulUBnsIdvigUDLa93NbjQ=;
 b=EwpKxKONRQn69y3XJXJ6cyBPDTGkOMS4Gog9GdoHnV6tzJEbvoLG0VGLl51WGwkx+FU3p79aK6zMrweRuccOr4VzFF0idzsudPmp73aAi35gLoKmtNkufq6vRCRJIGaAWtIHdcrLoaEaCzl0MOAbTXd+A9/vaoIDUfwH8zCDoHF6ar/SRRQq/35AVgjyMdH307JFu2NZyHrazTeAZDG08Go1s3v9/+08nRNBx5QdFukhTqMDzqyXtYjTsgmbXV8Rbnvhq9OQtxNY4ZZMMDw0JJ15OVv2xYzslZVWD7W3hEDRkS7vRSjgeYhDeHVI/HxgP1YHhpt0b38XByGtFc6Imw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GVXPR04MB10801.eurprd04.prod.outlook.com (2603:10a6:150:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 16:38:29 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 16:38:29 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 sachin.saxena@nxp.com, stable@dpdk.org
Subject: [PATCH 1/3] net/dpaa2: fix duplicate calling of dpaa2 dev close
Date: Thu,  6 Nov 2025 22:08:05 +0530
Message-Id: <20251106163807.201451-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|GVXPR04MB10801:EE_
X-MS-Office365-Filtering-Correlation-Id: b605b2c0-86fa-4352-8a54-08de1d52ea5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3E2eHB6bDVHRUhqSzdMbGI1RlFiMkhwNFVXbDVPRGI1R1l5d0s2eEsvWUJ2?=
 =?utf-8?B?VUFIYXZzRkM5SHlwZVAwVDZxaVNCSTZqcC9wZ0RzQnQvU1RmbWt0elBxQys0?=
 =?utf-8?B?dDJIcDlIbHd4Smg1anU0WlZka05ROXVZWjYwbXV1MjNVdWZBMzkwSjVsSFNq?=
 =?utf-8?B?Z3JUT21IRnJ3QTRjd2duMHZEd2hIeTFlUDRUbTdVSml6UUtWRjEzdlBCMkRO?=
 =?utf-8?B?UkgwY3ZvWmUxaytqUmVnMXFnNEc2LzFvTElkMGJKMzZ1Z3BkejArTWRZTC9D?=
 =?utf-8?B?VWF5SmYrZlh1YjN1RWVjbWNGai9MSHcra3JZeWRIZGZxTlRrNjBFNjkxdFpo?=
 =?utf-8?B?TXJzVk5MSnhFNWdOUTE2akRyalgzUkZUVTZJTkptOXRBVXJCc2xRNEEvTlQv?=
 =?utf-8?B?UGgzL095aGtQckRUcTNKSVhGWjcyQllMQU9mdE9TRnh0amo5c0cxbW1iTDNS?=
 =?utf-8?B?WkdxbWExNytVeE1FcFNHV3Yrbi9NcDA5UzhNanB5bEtldjhxb01mN3A2cC9z?=
 =?utf-8?B?aU0vVmpjR3VmakZUTyszNDNRb1hxb1RSNW5IMmltSGZWSkdHNnJ6dFpzUE1o?=
 =?utf-8?B?N1VpbEhVSUdYZHBkazlwalQxM1I1SGpyeTZ2anYwdmhWek5saGlFdXBPL1Zu?=
 =?utf-8?B?cWNWeWRIZUJLeXN0b0NFRXE1bUNISDJyQllaejZoQk5PR01xbnNLNDN3UlZv?=
 =?utf-8?B?cXdYMHpKcTk3Wlk1OTJHQ1B0eGRvMkVhYU8vd0J3VGlnTjA1d3FBMGhNTnpa?=
 =?utf-8?B?cFB6WjFjWUwwQUtXVXIzUVo0djhzMWh2MkN4UHFOcEl2b0lqaUhvMzJ4TlJh?=
 =?utf-8?B?cWxzaS9QWWN3THBYUTdMMXJ4VDdNa1FQaUxwTjlGRExCaDRZTGZGMi94eC9q?=
 =?utf-8?B?bzNDRHR0eGhTODVIWEUrTzdQeWlyVzVTVTh6aEk4b0FhcDUrekpwMDRvTEh3?=
 =?utf-8?B?RnlSM3dESEtPWEFXdGVoRkpvbkdUb2lCMTNKT2xEemZmSFllYnFzNzluNURJ?=
 =?utf-8?B?Q0VpdnBHRjdQeW83UEZJVmM2UjFNTndVenQ5NThQM3JFd1F5ckd0aWt3SnBk?=
 =?utf-8?B?bXRLb2VOUVlQcGpNUG5kNUhaNFNYQ25UcmtqbVRaUlE0SkFyV0Jhb1dFOG1K?=
 =?utf-8?B?cjltOCs1ZDlOVXN5eUtCZ2lBanlEL3E1eVZuVGZVL1NtUklONlVPMDlMblFy?=
 =?utf-8?B?ZUFTRS82RHFqeit3eE5mS09JS1NvbmpkU1FpWmVYaWE4SmFkSXRnSkF1bzdK?=
 =?utf-8?B?NjVCTEMvNXI5OHBRbXFadjJDQ3BFYldTN1NpZHFNNDlteVBtZnZDVDFDUE4z?=
 =?utf-8?B?N00wNUppd1A0dmx2NHRCb1gvWTJmQUFBNW1WU0loOStEUTNoZkROUGRzRjkw?=
 =?utf-8?B?aVViRk0zMTVsTDlQV1AvQVRJUDBGZHUzTUlnZ2JXRGRuNXBXeEErY3hxZVpY?=
 =?utf-8?B?VGJCRGluOTNxVDYwTi9uR0tNRE1FL1E0MmdnYmQwTUZhM3dMditIS1JPR3VD?=
 =?utf-8?B?MklmZ1dibGdOd2VNS1JUTGMrTlZxblNqZ3VnajNwNnc0M1o2eWdFMWk3Z1VG?=
 =?utf-8?B?end2MjZ2YjQ1T2xhNjVFenZTKzRiTjFtbEduaWFvVVgrZjNLNnh0cVFhWFRt?=
 =?utf-8?B?eDduL0xuWEdVakpKMWVHcEw5dHVWNnJLb1BTMUVrM3ZQQ0JJR01VNkMzL0E3?=
 =?utf-8?B?Z3FmN1l3TUYreFFQdDExMkVoSTFRMVcvZGZTRGFpcWc5UnB0OTdiaWdOZDAx?=
 =?utf-8?B?aGhLZTZQVkx3Y2xObW5DdEwrc1N3MFQ0VW8rSVJ0d3grd01sZi9HbG1FQnNm?=
 =?utf-8?B?czMwSnBNM0NCZ2lUMW1zKzZXV2FOVHhweDRrSEF3RkhLREJ3V3M1RGNJOWVQ?=
 =?utf-8?B?ZnBYTGNYd3dKODQ2aXMrWFI3QUNWb1E0NXR6RWpFL2hNakFXSEw4V0p6dlhZ?=
 =?utf-8?B?QnBQa3NTcTAvNHdIZERhL0RtZTJaUFJWVXVCVGhEMTZ2TFFhbHJZTjZqRlh4?=
 =?utf-8?B?bUVPbzVRRXQyZmxpK3UwanBzMkx6eWxDRVdXR2RzVVZ2YThvNlFJdFJXbnlt?=
 =?utf-8?Q?Ga4T7W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTQ0S2tPcDRGbzZ3NVZyWDZCU1RCZTN4Y2dJQ0M1dlo4OWpmcGhEMlBFZzFo?=
 =?utf-8?B?V3RjMENvZnBuNmVBR1Faalh1RmlZL3VWUXlIVUZUaXdEYS9BTitnd2xBQ0s2?=
 =?utf-8?B?cmo2dHRoV3ZTa0U5UUpmRHVMM1pSZ1VtbW5uZTJVQ3YrbVhOYmhoOXdhL3BT?=
 =?utf-8?B?b1ZzMThNeUlSeHI5OGZuT0R5VmNLQjA1U1RPOXBLcVpGN1gwVUxqMkwxVXVW?=
 =?utf-8?B?cytBM0NSRCs5ZUxySEpFT0t2MUJXdU5uQmh2dzJIWUxING1wRVRNN2VIZDhC?=
 =?utf-8?B?MTRFeU9oNjBRN3JlMFpiYlI1cnJqWHRUMzB6UXNsbGYwanROdUxoSGJMT3hi?=
 =?utf-8?B?Y0o2U3BSQ3hmUFp1czgzbU5zMjlsdVo3TnZ1LzczaGR1cTJSZUR5SUJBSDFR?=
 =?utf-8?B?SW5HZVhTTXJ1bSt5MjJ0MEtlNHFieG9CeU1hYzNVTGc4eDRibWFkZGV6RENu?=
 =?utf-8?B?ZUxFRW1IZVlURXlMZFV4MXlodlVXU0hEK2Nnb1pSYVJYTVByMWkveU5hUU9O?=
 =?utf-8?B?Um1XRWlIVkt3bzNLZDAzZk9rU2c2STZCWXFJazlZeXdCWU9DT0w1OE1td0Vw?=
 =?utf-8?B?TnFaU3NLaTJONU9PY2ppcHpnYkZrZEhFcHAzWEtkRE81Y0tQMUN1M0lzSFoy?=
 =?utf-8?B?dXcwZzNCZDcyY0JUVEMwTGhpK25BYTFNSm15WXpha3dTT0VtSEZkV0paVGlq?=
 =?utf-8?B?UUFZOC9qZGlnMVdIV2lVdThwdEdLR0pRb1VhOU45aXF3Sm5XWk9TWkZPejZ1?=
 =?utf-8?B?eFdNVlM3UURiZWgrcjBoUkNsU2ovZnpDbUdDVDB5eW9iUWY5VDZ6ZE0rK2Jl?=
 =?utf-8?B?K0VDK0FQOHg0UHNXVEI0ai9uM0pORmNIYlBiRjFFQzhXNjBWbkd3M3pkK25p?=
 =?utf-8?B?eGd1VUplcndtZXlmODF0cmE4b0JTT2lhSUxrUjErWHRZdjBlbE01WVN6T1Vv?=
 =?utf-8?B?L0RVcVoxWjJDRE1BVG41TDJ5WFYvVjYxT1VIK1VJc1U4SnhyRTNaNUtubFNp?=
 =?utf-8?B?U2dvRzJCSlZJeWxwd01nd0RSUWJ6RmdpVVVYWG5CWEJpTFdKbTZSUFVrUWFo?=
 =?utf-8?B?SkV5Z21KKzBkYllNTWNDTkNiQjR0dzBoTEhuNmFWL08zMEpwT29XQWoxVGF1?=
 =?utf-8?B?SlJES2RNNmNaY1FKNTZEUlpxVTZuWjZjWHVMWlV5dGxWMG5oZGpGUnFXNHVx?=
 =?utf-8?B?YzBkbnJjNUc2SytzV1g1cUpKbG0zODZ6TjI1Q08vSi84a2Q0OEUyVVRnOUJQ?=
 =?utf-8?B?cmlaU3J6SVR6QkYyZzAvMzNXSmNYNWdjM1ZNdHVFQXFzR2FUL1hTRVBhK2hk?=
 =?utf-8?B?emlzZFB4TXRtcExiNTNjMlQxVmlXMTdnWlVtUER0Wm9Dbk52NXZmZTE1RUk2?=
 =?utf-8?B?clVyOXlXbHNTNUxPTjRTOUNIa1U3YVFEd0R0WG4xOXB0RTU0WXJyOU9GVVdh?=
 =?utf-8?B?NkpLTklBZzQ4elorR00veG9xUkEvUVFsZFhlRGliWmYxQjZpVkt0ZGcveW1o?=
 =?utf-8?B?ODlNTjdOeVNwNW5PdFg0K2hrKyt2U0VaUzVMUkpwWi9MaGtmTXhFY0pKak9y?=
 =?utf-8?B?UW81TytYRGpldlY3dzduVFJTUFZ5T1dTc1I3Z0RDM1ZxYXVLQldCalZadVZN?=
 =?utf-8?B?R2VFSTRuMnpCUFhMZWowQWdXWnBzVE0vS1hLMXB2MDF1OXljLzNDUDgyY0Ix?=
 =?utf-8?B?bDZseE5NY2V1SEpXUDVCZGNNRi92YzFKYXpwMnNOMzJlbzdha0NYY1lSWWFu?=
 =?utf-8?B?NVZYcm1KSG9PZFRSUDYwb1BZNzJuSkhWd2NnQzUzdWcrRi9kai9MUUZSblhz?=
 =?utf-8?B?MTdlUm9vanFYUWNSMUg1U2RQRWFGbGVnenVsQ3EzVWg1NEFMbmN0RFVZQ1gz?=
 =?utf-8?B?UVVSZmdWYkVHd2pkNG1ESjcvbUxReVFTY2ovZWpQVDg1dTdxdXZhNTF6TS83?=
 =?utf-8?B?MDBnZVFXSmtzZENHNGNDcUxRb25tbU5lYXhBKzJWYkpaZ2lPTU42eXRpN2tY?=
 =?utf-8?B?RzJFVnhOVUNnNG9laHlaQngxT3BqaWZPcHRybGswSWg4ZDREYUpzUkVNaTEz?=
 =?utf-8?B?UWhxMndQMGM4cVVHOUVKRzFhWW10YkV3cHdLeDR6aWtGY3JzRE03azBidXJQ?=
 =?utf-8?B?YWN1cndTZzNWUExGdXFmZUhWM1pzWDVNUW53aVlaQWJ3S1RTS0JKOFArTFg1?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b605b2c0-86fa-4352-8a54-08de1d52ea5f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:38:29.2336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq1jlxfC/lNp8FE3p1ccY6xjY7y65R5Rj66Fc6lkNW+Fz4cexNvjyiawJTHd6zQx+MH4rqUjMJLWoRiwNH7Qdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10801
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

When rte_eth_dev_close() is called, it performs the following actions:

Calls dev->dev_ops->dev_close(), which in this case is dpaa2_dev_close().
Then calls rte_eth_dev_release_port(), which releases all device data
and sets dev->data to NULL.

Later, when rte_dev_remove() is called, the FSLMC bus invokes
dev->remove() — that is, rte_dpaa2_remove().
However, rte_dpaa2_remove() calls dpaa2_dev_close() again. Since dev->data
was already set to NULL by the previous call, this second invocation
causes a crash.

Fixes: 5964d36a2904 ("net/dpaa2: release port upon close")
Cc: sachin.saxena@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 7da32ce856..f3db7982a4 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3347,14 +3347,17 @@ static int
 rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
 {
 	struct rte_eth_dev *eth_dev;
-	int ret;
+	int ret = 0;
 
 	eth_dev = dpaa2_dev->eth_dev;
-	dpaa2_dev_close(eth_dev);
+	if (eth_dev->data) {
+		ret = dpaa2_dev_close(eth_dev);
+		if (!ret)
+			ret = rte_eth_dev_release_port(eth_dev);
+	}
 	dpaa2_valid_dev--;
 	if (!dpaa2_valid_dev)
 		rte_mempool_free(dpaa2_tx_sg_pool);
-	ret = rte_eth_dev_release_port(eth_dev);
 
 	return ret;
 }
-- 
2.25.1

