Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B938CD5BCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 11:44:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B5E240A82;
	Thu, 13 Nov 2025 12:44:15 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
 by mails.dpdk.org (Postfix) with ESMTP id AA78340151;
 Thu, 13 Nov 2025 12:44:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdbAip+QWiPPTlOf6D9fsULUShZIAEaX39bUWKeGS7hi7RurJTZxyjnQqTQZGBrsbp2TrVqJEDLDK5ZYpuTieK9U5RGG9sqtioQ8QfzDXJzkhayNTPntpAM+VeLAnCtBMb1sBoa69LuKaFyTFLZV0liP2YoWR3v4LMsfa1C8repu9SVzng/BQgJNSCln+nOArz/Gb6Fr4xSL2gTZUfSCI8vi8Z7u/fvVsVDiPneoi4vXER7YJ2X3IY0TNyGo5IqZXaFb5PKKT0SGMWzFU80VrHgLm/Bw7pLOrEyiuF58J+lLNP1qLe7mZM1N6CTzj32MN3yotdS4ttWRRATCBP3klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTMtlK75uyypBwTAS8PdBJXap+OvW+hs7SG+18qPG/U=;
 b=ECzlHTF0AWOZY0RDJESN6jZF9AAAWqu/SKah9Gb8gHKO60kTrMrrWZeQMJdHWgWj4/eEQF1QnIZIyNQCrRTyT+wDa6xp9ul5T+SHMxxaG0A+86LCnIXWQGF7eRoBwZbAp55QCjAKiprFSSjLviH19yqyqlYfhqZMO0QdDrBdXhf+EXl9W7XQZY1pW6LZhLpUZRCCgw0ckclN4jSl/KrgPEwrn7BG9DxuKIzotlrwvyP/U/vFO3mhW2dFiNYADsVVtlNGJerTMGKiDct7hIwM0Cf/QZCNpocg9x1Iav24Lzi27ZZirfiB4iz1qFD/zDOtmQctBnD8FwO/Sl8A66LAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTMtlK75uyypBwTAS8PdBJXap+OvW+hs7SG+18qPG/U=;
 b=djjS/cfp5JcZ9nEvVZACUcwNtLR7a23awiJ1eE1Oj2TexoUUYd3fsHWx5qJVLCc2lafL7PZCDc3V71GZrDMTC3eEGATBTh1pd+7e2bXj3+9MkhEwT9PKPN9g2q+RXVYDMVWDOVTktMOmH+pyJhWCZI2sTvlPMUJaOHzIn/SfcOYQaA92ktjRFNlMgE51bbnfh+5kao0jdekrnO9nfmNgQISjTiR4Xdd+g0481cYEHZ1VKLZc/aEWZDA9fC+KJB2+cl2L2biLvpgQNYbPCtNtFk6/82CFugLBPm6W8Tpllp7sQdeOFfRnG5Lk5e1ZhMfvsMGSl9MgStKYM239TnSSQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:44:12 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:44:12 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: sachin.saxena@nxp.com,
	stable@dpdk.org
Subject: [PATCH v4 1/4] net/dpaa2: fix duplicate calling of dpaa2 dev close
Date: Thu, 13 Nov 2025 17:13:52 +0530
Message-Id: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
References: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DB8PR04MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd5e142-281f-4e8a-92e7-08de22a9f6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEwyZVdBNTBEREV6QTg0YTllNnJmNjcvNHd1dEtneHNQcEZIUXNLZVlIRVp2?=
 =?utf-8?B?bm5aTGVrVnJpbVlOeFhsSUxXaWVlenBDa2QyM3JIYUpmNWx3QnRUelU5NHdL?=
 =?utf-8?B?Vm5zSDZwZlJnYTBhZExsdVkya0xYaVM0bDhkbmM3SHFQQmdwakhHVW11dFFj?=
 =?utf-8?B?THUwSitnUnBFbWc3YzRSdUtCbG9hQWxHaGZaQUpJcGhhQXBDaXpkYkQxcnEv?=
 =?utf-8?B?L0ZyR3NWRDlkTG84MmZTMG94RFkrNDNZTGNhMHdrUHJtZkJsTlJKNk9sVW5S?=
 =?utf-8?B?L2lYZ2FCSW1zenh1dmlIT2V1ZnppRHp3c09GUkdTVTRPMjFZMlcyMEdES1ls?=
 =?utf-8?B?N2hKV2JpVDlYUGU2STl4VXZxOTFIVnluMkRUNy91QUtMekFGbmlTbVRkRXQ1?=
 =?utf-8?B?bjlrUG1BRHBJVk96WnFGME1ZUlU5NkhNdkR2TlYySHVteU80VVNrK0hUMzhz?=
 =?utf-8?B?ME1RbXpNUmVUTG5XdXl0Z3V3d2VMRHNNWDFxNVNiZGpWMHFmY3VuNStPb2tU?=
 =?utf-8?B?U2Jid3VlRmNQOGhuUEhHb3Zyb1VSQm5JUGl1ZThpNnp0dGNCZW9mVU9SMzhU?=
 =?utf-8?B?cGZuZjVLdEZ6bTZQZ053LzRzU2ZhOElGUEkwNWVRalB5VWpqZVdzd3luK3B0?=
 =?utf-8?B?cFhobTFmVHJCNks4K1pLUklZcFJHRm9VTVZmNG51ZFBLNkE4emhkc2hQaEtG?=
 =?utf-8?B?NWVrRXA5VlFBSlRvbGk3bHVNZXhBd0QyRVJxdHI2am9TSVJjcmUwcU1QclVU?=
 =?utf-8?B?WUdrVkl5TW83SFVKTXFZYnFGb2xqOTVQYmZqYlZVTzlEWEpGaTVsNTN0NDlW?=
 =?utf-8?B?YTgwQ1ZERTVHQXVxcUZoTkY1bktqZUluMUJ4Vjh2RUNud2ZTUTdLQWZLK1FR?=
 =?utf-8?B?RUw3d1BHOCtPVk5hOVhmQkdPajRvejJmL0NHeVphcnYzUGltWmkvZ1NmbUU0?=
 =?utf-8?B?ZUJPZGtYa3pyTkhPZnlrZmZFY3JuMUFCVld6aCsxa1hkWGs1M1NEMEdCNURR?=
 =?utf-8?B?STRtdnlDLyswQTlVUmRsaUQzd1B1eGJmQkVMUW8xZHYrNDc1MTFHZDZ1dktM?=
 =?utf-8?B?ZGNXMnRwUktWL1AxcHRGTGcraStVbDdVVFR1OGZPYjJTUHd4UVVzQ1JqRmUy?=
 =?utf-8?B?UVltRmkxUnFYSXYyY1ZOVTdUeDFjSmVoTndhSTlGVVg3ZmZBNjhObHh1SXpD?=
 =?utf-8?B?MjR1ditkUkN0WUM4TkFaTVpDUVI2OWFSSlc4ZTliRVBOblpXUWdhZ3hEa3Fz?=
 =?utf-8?B?bmZ1d1hyR1YwTUV5N29JMFRmVjhaRUdSQzRxZGtVVU1CcVRMcmZvU1R6SVI0?=
 =?utf-8?B?QXVIN1l5NG4rRFp3Y0NoL2RNUityNEMzYjQrR2V0YUJPdkJGM1doRnUybncx?=
 =?utf-8?B?UDM0a0FSL1hKblVDT043NkNZbG96emtLWFZ4b0dQbWp3c2ttT2M0aWw0RFZG?=
 =?utf-8?B?Z0d2c1FOdWc0alZDU0RVMmNBcHNwcXRwQVFiMHEzNytRbW43N0tPc0RBdUFE?=
 =?utf-8?B?Mi9RMEQ3YWpzNmNnc2hZNEJDeExMdjJDS0lyWlRzYVJwV3pBSUEvMkRXdWJD?=
 =?utf-8?B?YWZaakxReTFiV3lOZWhsSDZBakwvS3hXQWN5ZUhkeWlkZWRuY1IyMkRjcDYz?=
 =?utf-8?B?SGc4SEd1cjRvM2lNZGxjamRTWTZvRVpFNmFjYjVlODVuVS82U1RHbVR6NytC?=
 =?utf-8?B?aUluTDZWcFF1RjhWWjBGT2d1Ujc5NEV5aWdZanhEcmp0cHVhcEhnQ1E5alVW?=
 =?utf-8?B?MUZqcEdLeG5PSE8vS2hxbmlGSUVpM1lXN0xlam9aOVBrQzlrSm0reC9ZWFc1?=
 =?utf-8?B?MmN2ZmFFRUU1bk1hbkR6dkFTblJrQkVkRkVhLytTUVo3Q3lpT08rbUdwQXVC?=
 =?utf-8?B?RFhHakNWTFJleTd0YWtHemg4ZTB0TXlnRzBjS0c4UHRLcEZNNEt1d0JYcFk3?=
 =?utf-8?B?TCt5VitneEdzZUp6N2tkd3FEdXppSFdUWHgxUlB4SmJVMXJPZ1NaKy9HWHZZ?=
 =?utf-8?B?UlY2dVRETnpLNXZzZ2plcTFOdHh2emUrR3p0aW4yR2luMFRhZ2hwODF1SDQ1?=
 =?utf-8?Q?+DKH88?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0t0NWFZeitsNmFuY1lqdUxKMy9ZdG1NZnU4NzZCR0gyNGJlK3YyTzhTb2tY?=
 =?utf-8?B?VC9JaFY0dFFSVkZWcVM0c3hWckU2NlpTbzhFOTJ2RGI0ZytqQk9JZzU3T0Z2?=
 =?utf-8?B?Ujk3TDU3dlhuSUVJRTY4bGRzUjlsUFhqOVlWcjdZR3o5WDkyMHV6Y1V2K0o3?=
 =?utf-8?B?L2d4OXBibXlFWkIrYUx6U3F0V1h2QWtYWVVTTkJSa0U4SVpzejdxSzdzZjhM?=
 =?utf-8?B?ZDJndTl4Qk9Gc0I4cUQyeERNc0YzTzFmK1E1ZHk2SlBSMC9aOVVmSVVWTFIw?=
 =?utf-8?B?aW9tZlVpaEgwekMrWnJkckd2b1B4d0VWZVVJeWYwQWtWNXZTVlpVQTNOVEZi?=
 =?utf-8?B?dERqcjZLa3A3VFk0dHZId0lWY2lRUEJHL1FscGJUSURySWtRM3ZoVlYyWmgw?=
 =?utf-8?B?eHB5SWlTMCtLQWpNd0Z2NWxUNjhadGluQ2p1S1NObzk3VEFzSE10eWh5MTcv?=
 =?utf-8?B?ZFlyazFMUFowaEJiQXBobzVta0FVdlY3dlFhTmIySk5sekg1Umc5MXJ0TlBE?=
 =?utf-8?B?K3d2amJlU3FTZDdxRmZoSVEweUxKL0NKSkFrSzhpcFlRMGRSaXgrYnlndlpI?=
 =?utf-8?B?Rk5NckFPQkw5cStpaGd4a1h3UVZZcWlibHM3a0lkSjV6aUZOalo3djV4enhO?=
 =?utf-8?B?cC85TGE0M0h4NU5PMmhJT1p1amRMTVZYRDZjWEt3ZWFLT3p5YUFJZHdKZ0k3?=
 =?utf-8?B?R2xSa09YQkdVOVBHVGJhZ2RjQVZubU54VlJrKzA1MExhVVMzSnhkdGpUWE1I?=
 =?utf-8?B?M0h5Nm9xU1IrNXhuanlMQkcybEJCZDFVV0NwMm4vREpib0RDdWVBSkFwbERM?=
 =?utf-8?B?bWZPLzk1K0tyb2gxYldQZlJMcVdXdjh4Y3o2MW9tMERhMFdPdTR5cHVzSnh4?=
 =?utf-8?B?cUhOTU1hWVpXY05JMXhnYTQ4YmRaV0dzYldzcE5TcjdkMU1JZHN1bHU0OWJx?=
 =?utf-8?B?UlVxeXdhbWM2Z3VoQkNTRHVvaE5nL2pUR0FLUmhOYjRMdUM0YTh5b0lXNnFi?=
 =?utf-8?B?S0RjMko4TFVPaC9peDRFZjFteXhFeis3NzMwdnhFbnJiNk9rNllna2dJUkEw?=
 =?utf-8?B?a01ZSWRLeEg2ZTlQZjV6YUQ0b0Z1V0dpT1lkRmlocDM1M2pEM3lVZ1pmZzZR?=
 =?utf-8?B?TU5ld2FCdnc1eVpkSng2T0tJSW5Ga2tsNjg4MFhXbTlzMGJPcEJacHlWeU1u?=
 =?utf-8?B?K0VLV21PWFE4SndUbWw2aTdmME83SmJha0szY2YxUEd0LytZaXlTQ3RienNH?=
 =?utf-8?B?ZWhvOXFwdmhEM3F0WXhvbnJUZDFDUXhublU5aE1Cb2UxZWVQZjhnTmF5bW9V?=
 =?utf-8?B?QnduTG5idzJqdW8wN09LRmlDNTFVN0NBam91NmYzd3Q3Umw0eGQ3ZllvNVZS?=
 =?utf-8?B?a0hxbXQ3Q2N2bTIzdjJCdGR1Wm40QkZzWkwxVkl1VklBakhyMVdsQlFkSTRG?=
 =?utf-8?B?aGlxNDBGYlNpNVRkYSswaktRMkliRUw4Z1EvTXZURE1ZNXkwYkhzcXpVdjV6?=
 =?utf-8?B?NmdVcFpMcjgrWnBFMno4eVZiMmpoSWZndTNrbGp1WE45Y01HdTN1d1pvZDdL?=
 =?utf-8?B?dkZObHlZdkR2amNxRTM5Y1E3cGlXRGJJbnovemNBYUQvTDJCeHNyZngzc2Uy?=
 =?utf-8?B?MExxT3VpclVZZFNmUTlscVlRWlQzaGxtQTg0N2hDRDV2ek84S1UyMVBQMWZk?=
 =?utf-8?B?d0wzVm5uWUNjb2s5YVIyYUlwM0xDM0k5TTFDOVp2Mk1WUlBIbmEwSjFWTUlp?=
 =?utf-8?B?U2d1Y09Wck8vZjJxdWErTUErUVorYU02Zm9yNzJnTi9NOFROMlVXbVNDREc3?=
 =?utf-8?B?WFlwUENoMEVxRU4ybjBVZjMwVkJBVnB4ZEpBcGs0dGdHbDVaOTR5SVR5UkhW?=
 =?utf-8?B?MVRNeHBaa0N1Tmw2aDh1RVF4WWJ3VTAwbVJiZnhFalpCUFd4a3pCL0UvU2lj?=
 =?utf-8?B?aURHS2dlTCtxTEdDUFhEUmd5YkF4bC9TWjZXSE0vN0hiQUFtSE51Vm4yV2tw?=
 =?utf-8?B?WFlyazc3UnFIV0RSR0s5by9mSVd2RzVhM3VXU3djcTV6SGZSbngwRW9rZU43?=
 =?utf-8?B?UXNTZXhjUkcxU3ljbG9LTmZqUVhDc1NNU0tKMlFSamxEWWxMclB1cVFsbGxh?=
 =?utf-8?B?OVp6OTZOT0JlNTdKY0ZlenhoWERNVDhNNUpSUzJIWnZoSUdrZVhsWU9DVXZ1?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd5e142-281f-4e8a-92e7-08de22a9f6d1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:44:12.1368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utqhF2Wj2PwHXemC3k2e0FnZMSOIXts3vjY5QByYwDWcQy42xCdWgNm+aPWKL0OhcrGyQ7GBjFgwTwo0VVm6kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
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

