Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D5BC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 690B14275C;
	Wed, 21 May 2025 12:15:54 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022119.outbound.protection.outlook.com [40.107.75.119])
 by mails.dpdk.org (Postfix) with ESMTP id 568354065D
 for <dev@dpdk.org>; Wed, 21 May 2025 12:15:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy1uU3RrB9LDfapmGculO8jtz9fVFVlRTaMtmPTCESfXzdN/NWcgCBlYdw/IVkIqRuxa1R99eyk0vBhyrSDOhEgXC+467iFFMgSt9jTvvymozlEvW/kMtQd+acZCi25+QzrnS9R5lqxI8ayFzl+cYGRycpHu+SQfMTKgS9eIhomtruaH7+TpVGkCIcTGO50JCBF+9enzTxS2lIEL0RHysZljYZTVB4kB5EvokkfhVCXBpIy3bZg0SpCwzN94C/Hp4ejg4WZnfHNI6sBAi09xNvi6jRCv1jtoZRceqmyd3iYs/9eD60AqEqdRN/mM+3b/4jNQUzs/8TdEQ9lAw0Bo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikgc+gcNkbkFYWjCxVceUe0wqVOCilwiQBj1lcen+18=;
 b=oIgIR0RPa2DaucFcbyU8Xg8sJl1gfJvjtpRJfbaBGvZaT5B1agiyKWXivHIKIc58pP41gvbDZKWGzxYrAH82Mmbkwv0ePnz+eF2LSzaeVu2KdWi85YVVo0f+QHpmzL1Uxc8GjVA+EXs7WmeumTkK8AVHQQWofOnWPq7lHCg7+KmUWGw3F8+FTO+6c1Ei3wXs/nyEhI/zhfrtjFtVlBeQG6FqMhFgKm1En3TeRWaU0Yf7lxZ7QMITBl2MayIRIidhg/X3sOnPtApYYWu1FgYS5qaPmZt/eJs7MrxFArCs/kDkAQ5kyCI4rRyp+Po6vf4COLp4EJLoX3xFLDrFBl07pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikgc+gcNkbkFYWjCxVceUe0wqVOCilwiQBj1lcen+18=;
 b=qv16kh1qdepvBOkbdV8kJmIM5LVDOOYQ6kTdppmAu5y6vB1+oi788JTvQNVrz3BTrPteAiyvffJwvhCOPaxbv82UvJR1KsHrEK6UXx94QvAti2EZuDzfougA0LVii5NtCwdbL+ze5N8ydSA+rpQf9xWIMs8yFAnMR1S9vdSZU4Lu89RuOcGHQESb+/86jK4cqh/Gi4BoBXJfVbnN/xId6IPOF52qYRQ1dRUPY5AtJoN6+zJlfCyZT5H4t/Gc07CRyfTVALBclv/KHuUEOl74JqZGG3/qg1B8/LvnboBbj21cI/h24H9qwtnkVs/GMqUVyf4AqFuqrzwj/1ZApuvCUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by SEZPR06MB6597.apcprd06.prod.outlook.com
 (2603:1096:101:18a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 10:15:47 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 10:15:47 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] ethdev: optimize how the values of the flag variables are
 assigned
Date: Wed, 21 May 2025 18:15:31 +0800
Message-Id: <20250521101531.34240-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|SEZPR06MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1afb25-4588-48a0-b5ac-08dd9850744a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTNRa0xRZHdKKzd0ejY5R0lCanl5L0J1QjJDSG11ZWtrWVRDZ3lxbEJmSXJ0?=
 =?utf-8?B?Qzg3cjNSb2U4UHJjRGR5QlV6Z1VNcG1VVXplNFF1cVVXTEhmbXNjRXZLeGll?=
 =?utf-8?B?VHZQV2pJbUlvZnpTZ3R2RlM1KzdmSXFUb25UdXFqcjB1V1VDSjdreExnRU1K?=
 =?utf-8?B?K0dtWmxqVGh6b3YxNmpoYlJzcEdCUmJEUzA0clVpNGxadFdST2hKQ1M2eFVw?=
 =?utf-8?B?UWNuMCt5dnU2azNwZDBUblBmOVk0TFpHTXZtbWQrY0syMktvWDEzU3FaYk5t?=
 =?utf-8?B?Y0J6bThVUXhIYmdIRTROU2lSb2ZHZ0M1bFlVc0dSTHdiSUFKenprYTBMaXY3?=
 =?utf-8?B?emJvZkJIWFAxalliY2dyWVpSM2QwVldUTTUvcHpzTjJzdWcyaEZyWXZSaUpQ?=
 =?utf-8?B?UU80TVdKUGFib0pJQnRjUWNPVkx4R1Z0V0FpYitYeUx2cTFuR2trQ3hjKzQr?=
 =?utf-8?B?b2xpNjdEUjYzWTVTclk2NFg2eEp4d05XMGdZdkdRYkVNNWswRzRadVdlQTVm?=
 =?utf-8?B?Qzlxc3hNeFVsaG1HdHltbkhrQTcvK0k2ZmJra2xsU3p1c2crMUZBTTNmQ3o4?=
 =?utf-8?B?WlZUUFdZYXZRUUdkRmxUUTU0TkNrZldOTFZYOGpvU3JKSXhXYTdmWkhHbXFC?=
 =?utf-8?B?ajN5bHIyc2hOaUN1SUd0NjBFL1RrK0dqY2RnSVROV3NVM2tIMlZicEkxMmZk?=
 =?utf-8?B?aGorYmVEMDJZSTlDRXhlWXRaWk5YdFl6KzlDWi8veWxVMkN0QXdrSnFaSy9q?=
 =?utf-8?B?UksySjZzOGdna1M4NUIvbXpjZ0ZZaWQwNlVCZkpXNlBSTEM1VTAwYU44ZUs3?=
 =?utf-8?B?ZDZHWFdZMTZiSjFjYVBLMitmY2g2YUZENy9MS1pQZDJ5VnpXOWFucyt0RHBk?=
 =?utf-8?B?bXdaZzVldVAxeUg1b0lnaXVNUWlzNHdOV3pIWDdQcGJaRmp1RDdpeUJNOVVa?=
 =?utf-8?B?NDNSNlJKSnA1NUFCeWJGQlZzTzlaQk1xL1JMUTB1eWpQWlRZdnRrMnVZOVVR?=
 =?utf-8?B?TlZPQkJvZjRIMFJ4Z0ZkMVBzRG5Tc3lJRjByek5GMjFReXRrdWVDY0plYzFn?=
 =?utf-8?B?dkUwUmg5MnZna3NORjhkM0dYaHozenZtWGJCTGlPTktjV09udWthK0dEOTBw?=
 =?utf-8?B?RmEyUm5idjhFSnN1cnZ2KytnR1BTOEt6WDRpTFFSd1U4YU9TMzUvT0IzaE9E?=
 =?utf-8?B?aXVZY0hncmZFZmEvbEpMa2FRYkxKSmhBU2xZTUtsbUZDRUtYQnVVY01hYTNF?=
 =?utf-8?B?NFlaVU5KRlFSTXh3RFFrcThqVGsrZ1kvRUFYeDV4RktUSm9CYTQ0VlRMaTZY?=
 =?utf-8?B?SHh5bXpucFRBMldmbWJWMEZ2VDc5VDIwUktDTmlnKzA3SDl1UURqWTgrTUNj?=
 =?utf-8?B?cEtqMFZWMXBWM2NCcFQ3eHBpYVllQlg2czBWOUpIVzMyNGZxcVNNei9adUJw?=
 =?utf-8?B?bjdPZUZabVhDZjg2R1dWZ0NFeUd0K09Fb3IxNmxKeElzK09JVCtxQ1ErV3Bm?=
 =?utf-8?B?RlhmTUM0MFF3ZGNIQ2F2ZnQzbVRXdHJFNXc5TVZVelFwRU56cUFRSkFwRUZT?=
 =?utf-8?B?bzNrR2trYUlXR0I0WGxPMjJsQitOYW51MmNjaHdjU3VhTzRPWldiZXhDeE02?=
 =?utf-8?B?QXQvWUNqWnZ4ck8zWXFOOTRGQzNpZWc3NDhoSGtaNkxxejIvRnhHbXIzaUd2?=
 =?utf-8?B?OHM3YWViMzFKSzZ3WFBLTkVUVllYckdheXNSOTgxQUt5cGwvcHRsWTg0bmJi?=
 =?utf-8?B?L1I0cnE2MngvYkg0TlBQMi9YOVBPTUtSYzZyMzEvbUVRZHF3aXNCZW1hY0N5?=
 =?utf-8?B?bGlrbFp1Z2NoYlRuWTl5NU9CVVFoWWJiQTNHRlpvT3RNRklrbHlycHUwTVJ4?=
 =?utf-8?B?K0YyTSsvTGw1akM0RjQ5bk12UnFQbDE3WU8rWnZoak9jVFdlWXorekplczBo?=
 =?utf-8?B?TWV0RWRGajJNT3RiNmpvSGEvL0htOU5UcHc5WkQ1NHBZVCtPVXBERVBWUWVj?=
 =?utf-8?B?cCtsQXB6WTV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2krbkRiYkFRRXI1OEZQTEd5ejFGY25iMTQ1alRQTEtOMy93L0NHSjRGM1lB?=
 =?utf-8?B?eWljbUtkbTNNYXVEaTlTNWEzajd2TXNKd2Y4U3VaYVBMWWxScEE2UGxGK0o1?=
 =?utf-8?B?VnZheTYvNW9wSU9BRTc1TUphS0FkaUJlelh1SFhEZmk5L1A3bFR5cllZb2p1?=
 =?utf-8?B?b3dnMHlOVGlOdkFDOWVWR1Q0QlkwdkZDMGptRjUvWGxDNDFYclpraXh0bCt6?=
 =?utf-8?B?dlljZGxHdDIrZWRjSnZuRG5HVldEenVZY0E5b0NHOUVrVUQvVk9TSWZjYytZ?=
 =?utf-8?B?bXJBMnFodUd3Q293b0dEcnV5R1V6aS9Ta2dqNDBJMHAwaGMyM3pxKzFJZURR?=
 =?utf-8?B?U2VyazJhOWlJWDhtSVpRTlk2ams4TG44NEFtUE1iL3QzNFJuS2dJQWo3V2NI?=
 =?utf-8?B?V3BnWWhLaUtDVUlQYmJnWWM2K3hKSmMvUGkyOGorN2k5dDVLL1ROWEVrbjhx?=
 =?utf-8?B?ZTNqanJEYkpmblF1Uk5tdFdzSEFPZWxaWEZEQ0dSd1BJclB2NUpqRVAzVWlr?=
 =?utf-8?B?dVE5amdMaDBZRDVOekxic1kydGNjZjZ0OHBzZjRHVmQxdU1COVJ2bFFWSysz?=
 =?utf-8?B?MkxnUGtFN1oxTnU1aERVL3VUWlROVUpiVk9JQXhTWTM2Y2VvTVFNUTJaeUhF?=
 =?utf-8?B?TStCVWNJb1pvdWc1OCt1SS90TzN3d3lBUVdFV3h6QzlzQTN4ZTR4Y1BTMTc2?=
 =?utf-8?B?TFRocUhLTy9Xcy9KQmdwaDN5eWtZQm9iby9jL2lrcHEyZVQ0d2w5andqWUFD?=
 =?utf-8?B?WEtUZktKQlEycnNLSmdweE5QQWdhTGxrVFBYL3ptNlRiakkzQ3g3SElOR3Er?=
 =?utf-8?B?aW9RNk03TU5yTko1SXNWTStaZ1doUHZjemwrOFQyY0tpcmJ0UzFnaVJZTXk5?=
 =?utf-8?B?ZEpTTWJEbkRjZ0YxYTNWdEhlcTFOWmdRRnRTU3pJWWszNTJ6citnRjZnSERY?=
 =?utf-8?B?cnY4WS9vSVBVM1hlN1pGeE5TVlp1ZWtSM1lGcmVmZXF5YTFncGpYdzNTcXIw?=
 =?utf-8?B?dXQ1TjJtMVlTeWFWcEZmN0hiQ2tWNFRFZldYdUprbUpJODNBaUo3RzJKeTVW?=
 =?utf-8?B?VFJmV2ExTW9VbnowVjgzdDJzL3RaeWNkUkFRbkc4MnhpSU1YakN3SnJvTjhJ?=
 =?utf-8?B?ejM1WkVoUWRBaEFudmFqUWZDK2c0amJZUTVRd1E2MXlydWtwMzNzZ0dUT1JH?=
 =?utf-8?B?Rm5uazFwMkgwamVjc3VnZEYrcXVudHQ4dUxkdEF6NFNtWHBsbmFNVWZTL3k0?=
 =?utf-8?B?RFgyMGU5M09tWnJDSlcwc084akNsRXJYSkZocWJNa0FDb3dVTlpFcHVuWXNX?=
 =?utf-8?B?NzdNYW9NYzFaS0srcHprSFcxSDJOa0JqYzlKUmhEenU3OWRiYXY3Mkt1Rkkx?=
 =?utf-8?B?ZnBZeWx6cHNWS1E1dzd5Ymw2aWQzUy9mZGQvOWVTQXFIRitDZExSNVNlSGY3?=
 =?utf-8?B?ZFpwTTN2cjhBSHRaYXkyUlk4MDJhYWhDeHN1VlMzTi8yU2UwODlYalZlK0sy?=
 =?utf-8?B?RStZRmMrdzhBaklaT2F3M2h1UXhpaXU3eklScFIrMTdwYktld0FSaFhoTFd3?=
 =?utf-8?B?MHhHYmNPM0k2dXpIWFhOS3JIOUhJTEFndlhwSEs1WTVWYjBGcHU4LzNYejB4?=
 =?utf-8?B?dEM5aUFxVFJMNE9FT1lWQ1l0REZYVkZzT1V3TjdvV0kvSDFMMllzVjYraTFo?=
 =?utf-8?B?RlhxaVF0aklmeFhLZUozb2Evcm1KWkYwMkFRWW5QNkJIRUhXUUY3MjdZcHdX?=
 =?utf-8?B?R2JEVjNGL092MG1CMkNMaHA3UHJsb2Z4TXdqQzBjcFM2QUR2c0xUTkVlWFRY?=
 =?utf-8?B?NE1YL0hPRWliL015YnZtajFTdXZVclh4OWovdnM2RkJ4dUhGTG1qQnV3SlI5?=
 =?utf-8?B?bHNaNnlnR1QxczhaclMyaldRWC8zbFh3Umg2amhsTEd3ZDJKdFV2RmxwUTU1?=
 =?utf-8?B?QlE4Mi93bXdlQjNsNUs1MHVHcFByVjQzNTIrOXQwSWJiWXhPdDR3N21JQTF0?=
 =?utf-8?B?dTZxaERuRGFvK2ZhN0pwVExqNG14Q09FVkVaR0Q0b2J5b1RERDYvTkRtZHA4?=
 =?utf-8?B?c0MyL3YyVFMwM3RHWDBOc2h0U3E1Q3VjT3RQT2JUTkdEdnMzVjViOHJMUS84?=
 =?utf-8?B?T09pdXZhMWtJTkJxdllicEZzK29ENnZjemlaWVgzZEF2QUxUaXFjcjZlUXhO?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1afb25-4588-48a0-b5ac-08dd9850744a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:15:47.4892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 498lBW3Hva7wRzixdlofMrVmJG/gozNeDJ3i2ArlQIVGMDh7sUCPsoRQxXZuohmo9/2uu+V1o4w5qLJ1QGRHHs0jblgg1jqoKeQ5BouwoiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6597
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

Set the values of the promiscuous and all_multicast variables
according to the return value.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 lib/ethdev/rte_ethdev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d4197322a0..c27d3e5041 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3044,10 +3044,9 @@ rte_eth_promiscuous_disable(uint16_t port_id)
 	if (dev->dev_ops->promiscuous_disable == NULL)
 		return -ENOTSUP;
 
-	dev->data->promiscuous = 0;
 	diag = dev->dev_ops->promiscuous_disable(dev);
-	if (diag != 0)
-		dev->data->promiscuous = 1;
+	if (!diag)
+		dev->data->promiscuous = 0;
 
 	diag = eth_err(port_id, diag);
 
@@ -3112,10 +3111,10 @@ rte_eth_allmulticast_disable(uint16_t port_id)
 
 	if (dev->dev_ops->allmulticast_disable == NULL)
 		return -ENOTSUP;
-	dev->data->all_multicast = 0;
+
 	diag = dev->dev_ops->allmulticast_disable(dev);
-	if (diag != 0)
-		dev->data->all_multicast = 1;
+	if (!diag)
+		dev->data->all_multicast = 0;
 
 	diag = eth_err(port_id, diag);
 
-- 
2.19.0.rc0.windows.1

