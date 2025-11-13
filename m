Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30C5CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 05:29:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B082240431;
	Thu, 13 Nov 2025 06:29:58 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011017.outbound.protection.outlook.com
 [40.107.130.17])
 by mails.dpdk.org (Postfix) with ESMTP id A55B24003C;
 Thu, 13 Nov 2025 06:29:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9/VDKipNB8g84+8YQ0QXjNflgLpDjuA9JrBDF+RwU65di8+eaDy3NGOjUXSBJTQV/wQ0sPb1G9NoKXQ+NSB3Xv5+ovKNpLAUQvgRqfWbEL4JChxqvZ7wC5saEGYOIaDZPr3IqDsiO5R/Yc+LDX/NJKyiAxM8o5WRYFM9v9Gy8AINJhFcNAexqY5edJ6Ht5iaVcnTUxtTXqZDKwz+HQhAglvr90KxzgV50NRErblaZLjueWvVONmvIl093BndEyidtrYAYqiKuMbjVoe03x6aD0aP8sIN4krBLOIKICCFvbQt3wb8pcqLdZGBIfAk56UfDXpGHgJud3yZDdCteTZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTMtlK75uyypBwTAS8PdBJXap+OvW+hs7SG+18qPG/U=;
 b=sxZ30seyFp+hePCV5qsRhlB0LkgE4nAjq0zzKQ2QIHJ/BNSxD3p+VYlID7lTkyVgA9hIuMkorSlGxnoUAeJMvdPmUQqAGhxvyzs22m8vk5Ogp5v/wrSoPzILpO4H8NLFf2vvvzYSr1Ih0EM97DQ/Tvsza7LdiAX+VGgAXCVPyhffnc4R2kOdWxGp20I/UYrE2IVhLt6dAobjwKY83eDmGOnY+dIBiKNbGK0mAD6S68VLLXmLKIdoJbEJTAhk8wNz4PsXkiFQjeCZv5gmDZZSkvyBpB+VtvKolN5/1f5PV9cPsLIo3WbrurTdph1DjHHmfr/6dh6N6KQa0atY/Bg1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTMtlK75uyypBwTAS8PdBJXap+OvW+hs7SG+18qPG/U=;
 b=e/PcyDL3BF+IohGWX5DaJIoVGckFVRtKXakQA5QE6OxiwmZgV9SWtBzx0MuZCFnWIguz5ay2RhSgApIjbUlDxxhYl9iebK4umMBonzlpvQ18N/OmHSkR5h79an+dvyHutqbsoyIEaiaC5P4l4f35j9hJbn79csOxpCA6UiG9dSH/DIZo4yWIekqlGgsC2wSZMR/lrPiRD6dMNk2hYqhoaiT3nRQ+4qFwre4T6+gfsiljV7Kb4WfptyJb7dq+71ERfDNwnkO/wvDRo8WTZQndFUOrsOxUwRCjWYWkps4vtSK8AWr43B93huuTKd9jSFemGMvm6kyxtKPrIssKu0tbgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 05:29:55 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 05:29:55 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: sachin.saxena@nxp.com,
	stable@dpdk.org
Subject: [PATCH v2 1/5] net/dpaa2: fix duplicate calling of dpaa2 dev close
Date: Thu, 13 Nov 2025 10:59:27 +0530
Message-Id: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251106163807.201451-1-hemant.agrawal@nxp.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PR3PR04MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 62123bfc-c812-458d-7aaa-08de2275ad61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0QyamJwZEhLYXV2K2I1bEZFL01NSVVJakZpZEVLMGFxWXBtQVh3TDhNZm9Z?=
 =?utf-8?B?bFNxOXFJeFREdFpsSER4ZWc0clV5Nkh5ZlFDTGlTUXo1M3ZHVlhQb1RaNjh2?=
 =?utf-8?B?MUpzUUkrdU9wNDNoNlNhb2d6T3N4SG5PRHdDVEVZVWJ4cW90MCtad1A1Z3V1?=
 =?utf-8?B?ZWRLWmEvWitLQ3pqUjZWUVE5bC9MSGdoVENwQU90eXpyY0RVRzh3SjNsNmZy?=
 =?utf-8?B?T0pmN25EdEhPcjIzNkMzMlR6cHc0SU5SZ2c0UktTUGV3aC9KNjNnRlFLTUdH?=
 =?utf-8?B?V0NsWnVhKzk1N1hndVlzblo5TkpIbXhMS3J0KzlhUzc4MWljZXdGRWtEeUNJ?=
 =?utf-8?B?MnlXeFBwaHoxT2RoUTBnWUI2blVJdG5CMEx0aFMrdVNhdTBOOVNIYWRPL3Rj?=
 =?utf-8?B?TFY5Uk8rZHZSdmJId3R1dktrMHJDVGdDZXBNQ3JWelovYndvTW0vemhaOVZN?=
 =?utf-8?B?bTJLUlZHSDhiTG5xaU5OMzVRTzlsQ2tnTmU1ajhvR0hvejdSbTdpQkpRZ3Bu?=
 =?utf-8?B?MEFMTUN0TTdMNThlZnBuRTFmMW83WVJKVW5UUU9SK1l1SG5yT2h6aHBYZEJ3?=
 =?utf-8?B?YWlrTUcvTkVjSlVVU0JKa2RsZHVWQXFRaUkzZGQrS0I1WE9aYjJYT2UyWEdF?=
 =?utf-8?B?aHZCM1dsNTlnZDRGU240TitsL2VxUlEzTjYwOVZHa2xiRVdvS3BwTlI5dFpi?=
 =?utf-8?B?MFhOUGwyN3c4cGhTTW4rZUhPQU9KOU1YNisyNGJwSStWckk1M2poQnlWR083?=
 =?utf-8?B?ZG1HMk05aU1aM0lDekM1MmQzTUhNRGhsanVTVGZLd3M3L2dLV3VwMzFNUFNa?=
 =?utf-8?B?dGRvNTgwbXZBZ0pIMldpeGZMYWU5bkpzRGxTZVM5RU51QnZlUW9jZS9UUWdz?=
 =?utf-8?B?T3lsKzRxaDZ2T0lscEhYRUVTckZXS1J4WUhZY3BwaWRoVmh5aUF5THdnREhQ?=
 =?utf-8?B?dXhPa21tanZrZzdDUWdJV051QUg2NkJxQUpNdVZJSXlpelRYS0RTNnlnLzVz?=
 =?utf-8?B?NW5ZU2Y3aStVM1IxVjJ4YTgyMWV0U3M3UWNIWmhqTGpZQlpmSS8yR3pVV3FO?=
 =?utf-8?B?S1JISGpqZERUbHVrQWEwc2srRnFkNTZTcGgxckt6QmRva20rdHhNRnY1TzE1?=
 =?utf-8?B?Q0M4SUduY3Qra0phbmVsVHVhMnhLVHBVa3N4dENqZHJIbGlTNHowMWg2OGVF?=
 =?utf-8?B?bndmQXJVQ2dobFdpVWk4UzlQeWZWcmphRFFWVGR5OWJNZmprdkVLSGZEWXlF?=
 =?utf-8?B?L21CeTJyVStITTR3eXVmbC8ybnN3U0tSZ1pnd3BMaUw5cU1XdWVFbXllcEpE?=
 =?utf-8?B?NXpZVmgrZFpncS9QbDdJVFJDUll3OWdZR1NoU25lUFZ3NjBwYXBtVDY1Z1Ay?=
 =?utf-8?B?a1pwOU4yUHRpTGR1Zlh6SWtqcmE1VkExbGxBVG5yTjI4SHRad2t1bVE2VFhE?=
 =?utf-8?B?NWtuYWJ0V1J2eEJwKzF0emFmV2pIYlhOZzcxVUNNU0pLNVIzZXNXbDcwOHND?=
 =?utf-8?B?OWgvZkZ2ZHg0aCtoWHo5YVpYS2hSMHJjTVdLTkRlQVRqdFZIdkVGV1gwM1pS?=
 =?utf-8?B?ZFhneHJmc1oxUUkxUGdtbXJwM2pzZDNLcVEwcWU0VFIyNjZaQUx5ZmNpdThH?=
 =?utf-8?B?NFF3bDEvTXErNWlyYmRnaUZSS01RVGNBanBnM01iWHR3RXZ6bWtFVVRFNUEv?=
 =?utf-8?B?UGcrdXFDMUlBOEpMODBkL0NoSmdVcFFLa3lGd1lSamdoYW4xUTByckljSUtq?=
 =?utf-8?B?WU9MdGUrMnJTdEJIVDBWbGw4SEtoaE1zeDM4amszbjE5Nk9ocW1acXZYajFR?=
 =?utf-8?B?OXhqSDJZKzdVR2JMQ21zdG15OHdiVE95VWxWdVFsSlh2UW1nYS9oS0NMQlRU?=
 =?utf-8?B?a3BkcEdINDBXK1lmM2tYVDR0a3I2bEZRSXNjSTNnRjZMUG9maTZKRzRSd2RS?=
 =?utf-8?B?YWxtQkJkUGphVTV6NVRlYTgrbjlKQ2x3K3NHaGV6M2JuaWEyMzliQUxxRW5u?=
 =?utf-8?B?UFFabXRXa0Uwb21PTERkRWZWanBMRkJmUjdIQmMybTB4SzRQSDFNVjd0WHpu?=
 =?utf-8?Q?Z3Ewkn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVBDR3YyL1BjajRHanJwcm9JSGkzeWZKYTZhdUEzcDMvSGtUNVpPcTR1QkxS?=
 =?utf-8?B?NDkyOFZ0eUhVRmZFK1BCUzZTS3pnNFNmT2wvUFNIOWg0b2oxbzZNVndwT1JX?=
 =?utf-8?B?N1pPNTVBWmtycWx6MnRkRXBvVUd3aThsdFd4YlV1Wi9nOWV1WDgyWGw4U1hX?=
 =?utf-8?B?OE9aTlA4UlMvaTVxbnNzbG55cFRHVC9iQjdsS01aMU9heVdBOHJJSjhEcDk3?=
 =?utf-8?B?TGlyRU9scWZUb0NRc0NJOHhNRG03SDNIVGZSYThrZHlVOUhCNHJoa05UZ3Rn?=
 =?utf-8?B?S1V6Zm1XdEhpS0Z6QnRHVXErL01vcmxlTEt5QUVZRzBOelBPZHVnWFlTZDJ3?=
 =?utf-8?B?Sk5nZlY3dTBjT3NsY2FRb3hTblE5c2wwM2NMVzJRSVkzUkN2eWxMclY4ZU0z?=
 =?utf-8?B?eVVJQ04xcnUrblJlNUUvaDJFc1VSbVdibDFnWEF1T3BUOUdFT2NXNmlhTUVB?=
 =?utf-8?B?dllOYlp6UzgrQk9vVFdlVG1LcmFSUis3NlZnVVhsbzVjRXYyZ0txellSaHpj?=
 =?utf-8?B?WVZpcnFkaWtJVndOMDFXZXBWR3kxOWs0NWEwUzdjNUR2M1V0cUh1M1l6WTNl?=
 =?utf-8?B?U2g1OGl3QlB2YTBJRUhHRWs3enlWYUd1MzVzektkNjRxVi96emt4dmF1M3hj?=
 =?utf-8?B?Y2hXOTlxMmZob3dXNGhPZG9NUmlmTk8rb2ZmZEpUUkdnSlc0RzRMQ0hMTnh4?=
 =?utf-8?B?RUhENEZaL1NHeVlKUGxaS3M4WG9FT280cFFDK3ZKMEZRWjFvVWw4TDIzUTlV?=
 =?utf-8?B?UVg0cEpxVjVaZFloRFd2aEg0QTRQeUwreUVHdCtzdm5mM2FCRUFXWW9FbHNU?=
 =?utf-8?B?M1VsY2F2NzlSRnpBMVZMazlHUkpWVHBOc3IwblMzQ29WUjFRVnNWK2c5SXI1?=
 =?utf-8?B?UkxWRUJMalRVazdGNjZGQTNHMGhUU1dEUkFFbDlqbGthcTVXMnBob1R4LzlX?=
 =?utf-8?B?OWU0KzhTQlFFQmRsWHYxQlQ4cEFFRklpM1BKQXdVWWMyRWdkNTMvd29MQlly?=
 =?utf-8?B?SldhWE1LK1l2WTJlbU04RnVYOWNUNnhEcEFFQWxJTmNqeW5LWHl0dHZQRElJ?=
 =?utf-8?B?Z0JvNm5jTnMzUWF0bFdVNW0zcEZObmxvNWNEWWI4S002dXJkak1lbzEyOWp2?=
 =?utf-8?B?b3BGSUxINGZEYTZGblB1bmp1QmpqaDZEZ25nVy9zVkNSMFMrdU9MSXIwNUI3?=
 =?utf-8?B?Y3JTYnpvNVJzYnNEQSs1UGtzUndKdlRRZWRwU016L1VZMkJKd2EyNUExdkU0?=
 =?utf-8?B?eUFCZmwyWDBxaHFhU21IbDhWSDhaRkFUWndxcUtPVDVDUVVqcEdzZUc1Ujdn?=
 =?utf-8?B?OHhGZkdHd3FMV3hLdnF5Z2RNQU9WeU5mUFNLVzFZN2d4SU1qWUIwbjE2S2RJ?=
 =?utf-8?B?UUIySXU1a2p5TEprWTZ4c0lQS1c5SkxVZW5JRGpZd0RJL0VQWnJjb2Jqb1Vh?=
 =?utf-8?B?OVdxQStEZGVNNHdHVEs0TDNvbDBaelY3WUFFMVdDN1VqRmkvYW9reGR3NlBF?=
 =?utf-8?B?akRiNmN4K1V2OTRtZEFVZUN0cDF5T0NlZnhKNjd3R0R1aDRRNzBtcm1IL0VG?=
 =?utf-8?B?anZqaFExVG9vNXN1TXNKck41SGdDTytVWUNWaUFFckNlT0JJUCs5dFlzSGsw?=
 =?utf-8?B?dWlIWWpPa3RWWlpZQ0JnMUVUMCtoTFRweWdxOG5HOEdpb3FxM1ZJVkZWeDda?=
 =?utf-8?B?VGFpckVyaXllQW9ROERsekJZQ0hmMVVTaE9EMVVUS1J6UW80OVlsMjRxMnRJ?=
 =?utf-8?B?MEM3WDFrQWdNUDNCTk9yWkcxc0xUenR1c1BaaFVqWjFObms3MitaeDU1cmJQ?=
 =?utf-8?B?NmZJS3oxK2ZscEU5ZXptSFpkbHNPa2ZxRlUrOGw3dHlDVmxDUzlRVVJCcnVF?=
 =?utf-8?B?bHFubmpsblJycFp2bUZBZ2lRRXczdk9peURFbThLY0dZZW9oeVVaeFFsOGV5?=
 =?utf-8?B?OFRJS0NHTE5VLzFKMVlSSDc5elJ0SFNVUGFHYVF1NzBNeWRJZWpuUEE2dHp3?=
 =?utf-8?B?ZUpCWXVwSDh1aUdGaGlZbVdoMkNaZjRmOWhOUXBEY3dMbm5CSnZWRFYrOCtt?=
 =?utf-8?B?UlhqK2txNWNTQ1Y2UFdPTTNFWWdGR0o3alpOMnlpVzZPOGVxYWIrR09VNDZN?=
 =?utf-8?B?S0grOW8vOWlMb3hZQ3U4UU5HbkFHQWZTQkQrZ1BQd3M1WUorK2U4bURPYjV2?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62123bfc-c812-458d-7aaa-08de2275ad61
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:29:55.1136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGFiXKr5mnht3iYEnLaM+vknzGCrwSMoKNJQMyMUTmNkWrHW8oePeMtwEz7urMINSepFT3XB2ztold0rcR++ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
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
 drivers/net/dpaa2/dpaa2_ethdev.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 7da32ce856..fc63cf4f09 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3347,14 +3347,19 @@ static int
 rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
 {
 	struct rte_eth_dev *eth_dev;
-	int ret;
+	int ret = 0;
+
+	eth_dev = rte_eth_dev_allocated(dpaa2_dev->device.name);
+	if (eth_dev) {
+		dpaa2_dev_close(eth_dev);
+		ret = rte_eth_dev_release_port(eth_dev);
+	}
 
-	eth_dev = dpaa2_dev->eth_dev;
-	dpaa2_dev_close(eth_dev);
 	dpaa2_valid_dev--;
-	if (!dpaa2_valid_dev)
+	if (!dpaa2_valid_dev) {
 		rte_mempool_free(dpaa2_tx_sg_pool);
-	ret = rte_eth_dev_release_port(eth_dev);
+		dpaa2_tx_sg_pool = NULL;
+	}
 
 	return ret;
 }
-- 
2.25.1

