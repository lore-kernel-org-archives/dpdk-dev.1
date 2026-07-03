Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7F0C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 17:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 839E54026F;
	Fri,  3 Jul 2026 19:21:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE874026A
 for <dev@dpdk.org>; Fri,  3 Jul 2026 19:21:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzosv/GDKbzc/JMbjC7j4LCLVV7BZqqQR+TpC7lHpyvyoUalA7uQ/8qXlrIRKHyxdMYD29flyVibWNjVNn1n8zZRK3Sw/83GPA+EUF6G54g/MUj30lxPoAFM1Ig4Glqeo8B4ox6XVDcsGKmSr8NmG2UpFrsEhkHQPI/R4zic8hK+gaXbKBpu33chGz/gvWl1rQ7P+6T5uQVxSJLIdNCWNDrRDLC2+eiw1tpVuuo1WKg76erQC3J8j/0S2IiyVE5OI39uPkysXb1YIoFRngLpN5huxYIpYawn0mwvC6l45fm36V2GRf2t/tlfv0M1RhyF5o9URRA+pnoiE2DdEtHTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krrGbdQKCva0K9G+SPQ3d7rKBmq0ge5qhMyYTNnYgxY=;
 b=i+sBf3mXm9EKWdPOXF5hjZ0q/UmvEo+YKvbZvWE8c/svLh2fPBFTGFgSw8sykDkHIAJ7pxuExUK8ixLHe2Gl2cBKiDtM2kJztlABrUZKxd2ojus9Qqtngampoc6p2pWP5RkWJACEOgd/AsCom/Av3R8F8eMAfRZMGpu+SmNP/htPpv/qL7kMYmopppU9hDosK0JETM7n3qRMprmhPPuuG+1QdkK8H42QXP6jkHdLx3Xh7oLLMIb/Dljt+rwvjgGVm1i//300ta2jsthVyiFpT6iY3AK5sAAaXI6qzwsfIA0ce39syBrUlnWsdJEdDpK9Ar77CZnbsWTY0AN+w2klhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krrGbdQKCva0K9G+SPQ3d7rKBmq0ge5qhMyYTNnYgxY=;
 b=fSWBTX59FhbF/QYcqNKHQ87bndkn2CRV+25uPnXmDim4u3XclX787uB0HJJPKxaPhq2pk2PglCMciz4Z910semEQTTWBw7NoiAkWTloq37BfLdCvBL/B1Zod2jGesM+7QxEjwSb5b+wnbCESJCrIfleox2xx6aNIRHlVhSjYh350AEvl7Wd8zZqts/QssWolkPTUjvE2CuZGSmYhqmc9ndTlFch3d5OLl2yuwZzAwmzv1G3soH8Yi7IR8Kj0JhuvUA7eg/aCTqRXrIpUi+adO5I0We+TI5uTyrz9245iIC7R8DXdcIZVQLOJuq1n/esw3rZQeHs7Yv9GhOXhV3YbIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI2PR04MB10857.eurprd04.prod.outlook.com
 (2603:10a6:800:271::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 17:21:11 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 17:21:11 +0000
Content-Type: multipart/alternative;
 boundary="------------TXyHO0Zzhn0Y50Q0f5aLjce0"
Message-ID: <3ac32501-55de-4d8b-87dd-55d31ca7e4bf@oss.nxp.com>
Date: Fri, 3 Jul 2026 22:51:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] net/dpaa2: support Rx queue interrupts
To: Maxime Leroy <maxime@leroys.fr>, dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, david.marchand@redhat.com
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
 <20260630144329.457643-6-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260630144329.457643-6-maxime@leroys.fr>
X-ClientProxiedBy: MA5P287CA0301.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::15) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|VI2PR04MB10857:EE_
X-MS-Office365-Filtering-Correlation-Id: 93de7471-c215-410f-9796-08ded9277a01
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: 4y0T78pSX4xvEpf1Uxf59afr5s6wDLHFwKWZprWgamro6XNz05crt9e2sRjDH1UPUb+ghtWpqlx0j7wGaf80a/b8znwETfIJLKbtIm+oYWXFzCOc8S6BsBJZLxdzD0HKdc9tXLfzeZUQmAFVzSz8KC6BHkWsYleCGndr739P+njixJTwUKYHb8mnpyKQVbdWXYpJ/zJG4PZ3rtIsV/iyALkosijWaz9AXYR6vBeJxmUbRsbaLbwCP3HxeB9aEBWWo9TjlXp+0MKoqObUCj+m9sx6XJPQJEVWMhBT5av4KwzC8zrxdvE+MlcRMRX5an8a8TqwD7koEPm/LkmBru/H9Ig75KBdEj3SpKZD7LUWhztx2SwGz5EpXMRgRmNeXlZHhmmug4vbWg3FLqhELmYF7CalwOP1J/N9KXHEbUlvi/uivOI+p1fhDHZpDU9H+TP3WdRsPetsor0F+olF+OBLY3PpB1nCUbYKZvoMXJhElFGPPjHHISIT24B7jAghfVXdbubODdS20SEh7m+MEI+TiEQoe6GcbuaxnPRgkgacU+iLvX5w4opomx8uodvhZCgIp39SyIfazXUklvRR9AFuUFWbxveTsSRG7VNT/ysozG4RT6akNh760gslvgrgSUpG72WhdJhXS/iqG5pP7tKEAePPr/MC9PK/JpX/viV7odM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXV0bk03V0k5STNwZXVGQ1BQa2lMZmtKWkJKYktkUTcxSEI4OUYwbUVYVlJ5?=
 =?utf-8?B?djdZSC9BTXpJcmw5R2hNNks1N1JIaWFTdHBvSStsWkZGaDhUdUpkSzFWaTI4?=
 =?utf-8?B?cVpjbkpQdkdnV1BnRHN5d0JneFJnTi8xaWRZa0dYMXkzaThiNEVid2YzeHVv?=
 =?utf-8?B?MU1lWmljK2tZekdjcHk4N2pBOGgyVmtKRENOQnJnT3NGc2VFTzBxRnM3d0Jn?=
 =?utf-8?B?TktNVlNnZ0lXZTBlR3YzRU5pNVI2cFR6bm9GOTcydVgwTVE4eEtCOVN6VHE2?=
 =?utf-8?B?TlcwQVI5M3pmT1M1UWVrRGU0WVl3eVNnQWs1eHE3dW9HRzhWUThNZE8zSEsr?=
 =?utf-8?B?VGVKMjBCUHB4NHVYSzFKTFYvazBLS3dHZFZ6cW4vOFpvSENSQzRXTStPUGdi?=
 =?utf-8?B?VktqUDRUNFlIb2Rhc1hCYnVzS3JZbzgyM0hacXphU1IxVDRTOVZBRmRma3Zj?=
 =?utf-8?B?MG9GUjNPOHhaSzJqZDhHMEczZllHTC9tU1Q3Z3JqQVdpaGswNVA3MHpjQU4z?=
 =?utf-8?B?OWtScVgrOE5VcUgxSjQxRytmUjUzcmVtSUxSRzN3RDFEYkZGbGFYZjdwekFa?=
 =?utf-8?B?M3J1MTdxQm11d3FDZGlGa3VvVGhhZVNieDRYNUtDVTA2eGE4K3RpQ3BIOTky?=
 =?utf-8?B?M3hQdzdROThUUWN1UGxtUUhET01nQjdkb2hLL3IyWnQ0Yldhdm1OSmM0V3FT?=
 =?utf-8?B?UVI5YWNWUFZpQVhYdHRtc3pKR0pCaDEwVmVmbnYwZkEydkI0NDBvUmdYWGM3?=
 =?utf-8?B?Y1JnblJaVmdPZmUvcU9mUWJlc2h3TG1iZlc2V1FLK2daZjlrcGErTVU4TTdC?=
 =?utf-8?B?UVcyRWk1MlJlbTFrUHhrekFmWHNPWEdNd1VzRjUyK3I1aDN6MjZkQ1FLYXMy?=
 =?utf-8?B?YmJZcGRRUUZ0MkZLQmdJMkFUd3ZhTjQzSk1hUXBBUyswZVZGeGpISC9vdEtn?=
 =?utf-8?B?VFdJSVZVNnFCTU5lb1hlb0tLdHRVUGZCS3N6Y2NWZ1BhMmp0Q2RnZVUrb3kx?=
 =?utf-8?B?UjUxb1JpWjNVQ01pTktFSVdUclJiNFl2c21vRjZLZ3A2NlM2S3VVNlA4UkM0?=
 =?utf-8?B?TFlmcURjczJnbDdUazJuZWgvWExxZWZuMjN0UG5pZThNczRRaFZBUVA0M01V?=
 =?utf-8?B?elROcjJmTElLc3pnZUJGODZ3dkF6cjVVSTAyNFAvL2VaUHBlS08raVAwaTFB?=
 =?utf-8?B?TTRoUDkyWXAyY0k4T2N2UjNlT1U0bTVia0hUVHppUkNxQmI4TnErYU9vbWpO?=
 =?utf-8?B?M1YrdzFTRlF1Q2dOenBHbFJseXRSN2FmS0tkQ20xeWJLbWM1OGZTci9pYWRQ?=
 =?utf-8?B?aFl1R2FRcTR5NXNKOTdSbmM3YUNJNFhZQTJxcnMzOFhOMWIyZi9Eby9ZYitX?=
 =?utf-8?B?dUU5NXFuYXFkQTh5N2srUzBERm13aW55Znc3WXJJZzltcE44WStuMkhqWjJB?=
 =?utf-8?B?UWx2djJKUGZhYmp2eDNOSGgxb3lWakNnVUVFZXF0akpnck5qcU0rN0RGa2Mr?=
 =?utf-8?B?VXVPZFBqWjdnVFVKZUw3WDgrT1h3OGdmYnpDbEt1UG9peUxPTDBuMjd4eDZO?=
 =?utf-8?B?K3NIcUFnZ2NQTGcyeEk1Ynh5OWNpYUJ5Vk9SSUdPSWVCZURDandlbDc2TUpi?=
 =?utf-8?B?NEI3bGVjalNOaHJ0bnpxdkErMCtjRUUwUUdsczV3UW8xU2tLVndzU1Nqc1pa?=
 =?utf-8?B?UnpXS2FRN1c3RHRMYmF2Unl5RGk2SEx5V0s2cDFRWDRLaVdxMUlZMVRRdE1u?=
 =?utf-8?B?cEQ2Wm0vN0NsdDFRRnFINnhQTjZ2YlV6MmVPSjR5Mzc0NGJwRWFlb0lnK0JE?=
 =?utf-8?B?YVdKZHB2SVFHeVpYaFNtaG1pVzdORnp4K0g4YXhZdmllaXBXMkNJdmQ2eHhI?=
 =?utf-8?B?YklLdWRXc040ZkNuamphaUJFTVBFeGVGMkpkVUgwSDYyNkRCNmg0SmlFMCtD?=
 =?utf-8?B?NzF0cUZnYVo4MHZTeTdpYTg0MFY3MDFRL2dEcGpuMWhDWVRXbnIvQXJjeHh2?=
 =?utf-8?B?TWJ2QnJ4aUVkWTRPb3YwVEk3L2d0R3VNNjM1azc4MlgwSUtYR0NXL29OR0R4?=
 =?utf-8?B?SDNWK00xMnFpNE52a3prbWpNMGxISVp2WDNoMUNrazB3cGozRGVrK1JrcVNh?=
 =?utf-8?B?cm1UNjFJWm5kaEZxL2xpK25lMWxqbDAzMWk0dHdiUnJBd3RMUEJvTnB5SG1T?=
 =?utf-8?B?RHNSdTJLWXFEbXZjUDhxUG5QVjFCbFhJdFlzeVNjQ1NPYlFPSWNhRDlqeW01?=
 =?utf-8?B?YStoaDBuZVhEUlFIdkFwamxpZmNESkIzQ3ZTcmxjb0NTREYvYm00aXEzak4z?=
 =?utf-8?B?N1dDdkUycHhaYWJpQzhRVWJTa3ovVkFqZkxtbFE1cnlEVER2cHNMWFVmQWVU?=
 =?utf-8?Q?WNbaTphUOnzu2Inw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93de7471-c215-410f-9796-08ded9277a01
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 17:21:11.1301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Unm5dgSC3CWCS/z8d+jNBuRd/ljwbgtYTcJ+D4NbU5xuaSD1nEsgJqABurb8MDafzZyjJmKERyfydCVx/9MlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10857
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

--------------TXyHO0Zzhn0Y50Q0f5aLjce0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30-06-2026 20:13, Maxime Leroy wrote:
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index a68404ee5e..36f8669644 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -5,6 +5,8 @@
>   
>   #include <time.h>
>   #include <net/if.h>
> +#include <unistd.h>
> +#include <errno.h>
>   
>   #include <eal_export.h>
>   #include <rte_mbuf.h>
> @@ -25,6 +27,7 @@
>   #include <dpaa2_hw_mempool.h>
>   #include <dpaa2_hw_dpio.h>
>   #include <mc/fsl_dpmng.h>
> +#include <mc/fsl_dpcon.h>
>   #include "dpaa2_ethdev.h"
>   #include "dpaa2_sparser.h"
>   #include <fsl_qbman_debug.h>
> @@ -658,6 +661,8 @@ dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, int num_lcores)
>   	}
>   }
>   
> +static void dpaa2_dev_rx_queue_intr_unbind(struct dpaa2_queue *dpaa2_q);
> +
>   static void
>   dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
>   {
> @@ -675,6 +680,12 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
>   		/* cleaning up queue storage */
>   		for (i = 0; i < priv->nb_rx_queues; i++) {
>   			dpaa2_q = priv->rx_vq[i];
> +			if (dpaa2_q->napi_dpcon) {	/* release the rx-intr channel */
> +				dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
> +				rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
> +				dpaa2_q->napi_dpcon = NULL;
> +				dpaa2_q->napi_sub_dpio = NULL;
> +			}
>   			dpaa2_clear_queue_active_dps(dpaa2_q,
>   						RTE_MAX_LCORE);
>   			dpaa2_queue_storage_free(dpaa2_q,
> @@ -880,6 +891,26 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
>   		}
>   	}
>   
> +	if (dev->data->dev_conf.intr_conf.rxq) {
> +		if (!dev->intr_handle)
> +			dev->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
> +		if (!dev->intr_handle ||
> +		    rte_intr_vec_list_alloc(dev->intr_handle, "rxq_intr",
> +				dev->data->nb_rx_queues) ||
> +		    rte_intr_nb_efd_set(dev->intr_handle, dev->data->nb_rx_queues) ||
> +		    rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_EXT)) {
> +			DPAA2_PMD_ERR("Failed to set up rx-queue interrupts");
> +			/* capture the error before cleanup may clobber rte_errno */
> +			ret = rte_errno ? -rte_errno : -EIO;
> +			if (dev->intr_handle) {
> +				rte_intr_vec_list_free(dev->intr_handle);
> +				rte_intr_instance_free(dev->intr_handle);
> +				dev->intr_handle = NULL;
> +			}
> +			return ret;
> +		}
> +	}
> +

If |dev_configure()| is called a second time (e.g. after changing 
|nb_rx_queues|), |dev->intr_handle| is already non-NULL. The code skips 
|rte_intr_instance_alloc()| but calls |rte_intr_vec_list_alloc()| on the 
existing handle without first freeing the old vector list. This leaks 
the previously allocated vector list and may also cause a size mismatch 
if |nb_rx_queues| changed between calls.

Should not we free the old vector list before reallocating:

if (dev->intr_handle)

     rte_intr_vec_list_free(dev->intr_handle);

else

     dev->intr_handle = 
rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);

  /* then always call rte_intr_vec_list_alloc() */


>   	dpaa2_tm_init(dev);
>   
>   	return 0;
> @@ -898,6 +929,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>   {
>   	struct dpaa2_dev_priv *priv = dev->data->dev_private;
>   	struct fsl_mc_io *dpni = dev->process_private;
> +	bool dpcon_allocated = false;
>   	struct dpaa2_queue *dpaa2_q;
>   	struct dpni_queue cfg;
>   	uint8_t options = 0;
> @@ -938,6 +970,25 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>   	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
>   	dpaa2_q->offloads = rx_conf->offloads;
>   
> +	/* NAPI: grab a DPCON channel for dev_start to bind this FQ statically */
> +	dpaa2_q->napi_sub_dpio = NULL;

> |dpaa2_q->napi_sub_dpio| is declared as |RTE_ATOMIC(struct 
> dpaa2_dpio_dev *)| in |dpaa2_hw_pvt.h|, but here it is assigned with a 
> plain |= NULL| instead of |rte_atomic_store_explicit(...)|. This is 
> inconsistent with the atomic stores used elsewhere (e.g. in 
> |dpaa2_dev_rx_queue_intr_unbind|) and may cause memory-ordering issues 
> on weakly-ordered architectures (ARM/aarch64).
>
> Please use:
>
> rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL, 
> rte_memory_order_release);
>
--------------TXyHO0Zzhn0Y50Q0f5aLjce0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30-06-2026 20:13, Maxime Leroy
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260630144329.457643-6-maxime@leroys.fr">
      <pre wrap="" class="moz-quote-pre">diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index a68404ee5e..36f8669644 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -5,6 +5,8 @@
 
 #include &lt;time.h&gt;
 #include &lt;net/if.h&gt;
+#include &lt;unistd.h&gt;
+#include &lt;errno.h&gt;
 
 #include &lt;eal_export.h&gt;
 #include &lt;rte_mbuf.h&gt;
@@ -25,6 +27,7 @@
 #include &lt;dpaa2_hw_mempool.h&gt;
 #include &lt;dpaa2_hw_dpio.h&gt;
 #include &lt;mc/fsl_dpmng.h&gt;
+#include &lt;mc/fsl_dpcon.h&gt;
 #include &quot;dpaa2_ethdev.h&quot;
 #include &quot;dpaa2_sparser.h&quot;
 #include &lt;fsl_qbman_debug.h&gt;
@@ -658,6 +661,8 @@ dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, int num_lcores)
 	}
 }
 
+static void dpaa2_dev_rx_queue_intr_unbind(struct dpaa2_queue *dpaa2_q);
+
 static void
 dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 {
@@ -675,6 +680,12 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		/* cleaning up queue storage */
 		for (i = 0; i &lt; priv-&gt;nb_rx_queues; i++) {
 			dpaa2_q = priv-&gt;rx_vq[i];
+			if (dpaa2_q-&gt;napi_dpcon) {	/* release the rx-intr channel */
+				dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
+				rte_dpaa2_free_dpcon_dev(dpaa2_q-&gt;napi_dpcon);
+				dpaa2_q-&gt;napi_dpcon = NULL;
+				dpaa2_q-&gt;napi_sub_dpio = NULL;
+			}
 			dpaa2_clear_queue_active_dps(dpaa2_q,
 						RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q,
@@ -880,6 +891,26 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 		}
 	}
 
+	if (dev-&gt;data-&gt;dev_conf.intr_conf.rxq) {
+		if (!dev-&gt;intr_handle)
+			dev-&gt;intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+		if (!dev-&gt;intr_handle ||
+		    rte_intr_vec_list_alloc(dev-&gt;intr_handle, &quot;rxq_intr&quot;,
+				dev-&gt;data-&gt;nb_rx_queues) ||
+		    rte_intr_nb_efd_set(dev-&gt;intr_handle, dev-&gt;data-&gt;nb_rx_queues) ||
+		    rte_intr_type_set(dev-&gt;intr_handle, RTE_INTR_HANDLE_EXT)) {
+			DPAA2_PMD_ERR(&quot;Failed to set up rx-queue interrupts&quot;);
+			/* capture the error before cleanup may clobber rte_errno */
+			ret = rte_errno ? -rte_errno : -EIO;
+			if (dev-&gt;intr_handle) {
+				rte_intr_vec_list_free(dev-&gt;intr_handle);
+				rte_intr_instance_free(dev-&gt;intr_handle);
+				dev-&gt;intr_handle = NULL;
+			}
+			return ret;
+		}
+	}
+</pre>
    </blockquote>
    <p>If <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">dev_configure()</code>
      is called a second time (e.g. after changing
      <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">nb_rx_queues</code>),
      <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">dev-&gt;intr_handle</code>
      is already non-NULL. The code skips
      <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">rte_intr_instance_alloc()</code>
      but calls <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">rte_intr_vec_list_alloc()</code>
      on the
      existing handle without first freeing the old vector list. This
      leaks the
      previously allocated vector list and may also cause a size
      mismatch if
      <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">nb_rx_queues</code>
      changed between calls.</p>
    <p>Should not we free the old vector list before reallocating:</p>
    <p>if (dev-&gt;intr_handle)&nbsp;</p>
    <p>&nbsp; &nbsp; rte_intr_vec_list_free(dev-&gt;intr_handle);&nbsp;</p>
    <p>else&nbsp;</p>
    <p>&nbsp; &nbsp; dev-&gt;intr_handle =
      rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);</p>
    <p>&nbsp;/* then always call rte_intr_vec_list_alloc() */</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260630144329.457643-6-maxime@leroys.fr">
      <pre wrap="" class="moz-quote-pre">
 	dpaa2_tm_init(dev);
 
 	return 0;
@@ -898,6 +929,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev-&gt;data-&gt;dev_private;
 	struct fsl_mc_io *dpni = dev-&gt;process_private;
+	bool dpcon_allocated = false;
 	struct dpaa2_queue *dpaa2_q;
 	struct dpni_queue cfg;
 	uint8_t options = 0;
@@ -938,6 +970,25 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q-&gt;bp_array = rte_dpaa2_bpid_info;
 	dpaa2_q-&gt;offloads = rx_conf-&gt;offloads;
 
+	/* NAPI: grab a DPCON channel for dev_start to bind this FQ statically */
+	dpaa2_q-&gt;napi_sub_dpio = NULL;</pre>
    </blockquote>
    <br>
    <blockquote type="cite" cite="mid:20260630144329.457643-6-maxime@leroys.fr">
      <p><code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">dpaa2_q-&gt;napi_sub_dpio</code>
        is declared as <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">RTE_ATOMIC(struct
          dpaa2_dpio_dev *)</code>
        in <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">dpaa2_hw_pvt.h</code>,
        but here it is assigned with a plain <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">=
          NULL</code> instead
        of <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">rte_atomic_store_explicit(...)</code>.
        This is inconsistent with the atomic
        stores used elsewhere (e.g. in <code style="background-color: var(--mui-palette-action-selected); color: var(--mui-palette-success-dark); padding: 2px 4px; border-radius: 3px; font-family: Monaco, Menlo, &quot;Ubuntu Mono&quot;, Consolas, monospace;">dpaa2_dev_rx_queue_intr_unbind</code>)
        and may
        cause memory-ordering issues on weakly-ordered architectures
        (ARM/aarch64).</p>
      <p>Please use:</p>
      <p>rte_atomic_store_explicit(&amp;dpaa2_q-&gt;napi_sub_dpio, NULL,
        rte_memory_order_release);</p>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20260630144329.457643-6-maxime@leroys.fr">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------TXyHO0Zzhn0Y50Q0f5aLjce0--
