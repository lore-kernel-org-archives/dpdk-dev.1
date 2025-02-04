Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0FDC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 668144025D;
	Tue,  4 Feb 2025 17:11:48 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 21AC6400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:11:45 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514D0Z2s019360;
 Tue, 4 Feb 2025 08:11:45 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44kkda0cu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 08:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jmm7vLXELRxaDwlrZ/uHjIa/r+X3ZnTW0VeSIQKgOQVTn34EV3LywaAOs1TYdXpkrVkNBgI/H/Q2TdPvfpbaaJMo+DFVi78hLTREHlxkPnAN3O3JjQePVeoXQyfrwPwiFX85hxU8Bs1ajhBTlQZwM/mjWpudBh7ePIgW4g+o0TN8ZJ79FN7vSjwZVi/b3ddezp9PNbh8hExv04FlDWg/9L7nuxCdUmUNpAYFDWl8j/KS5YfFy7NqTVPtbxQfOelE51SH8ktOzH3IINp0e5IUPzRPxFtpm3PbCQRHi3N9nbYMeCTnBYWp8mTL2MmVric01AttHf0EO1ECBpPu7Tx4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O14U35FqAnwTRkSYyKaihAMETodPliyYFID50S/8kAI=;
 b=Yn5/k0zhen7xo9JnIaiOwNRfNTuE4SRGzekwu2DSD9HnmtnUYA5/BH5PLFOQlARw9OuAw2qixhwt3iL74RnpSqvpQfZkdW0bXWMBHoh19UZU/uHEUKJJp9/cNUu6efOWEOoXa9Rq+AAhGG6pGzaoDjrL/IrmLKuv0QooU/8WdGsPid3qrqhfeDixH3a32YyyJ/KmZAag7pO9axR35HL6Llm/IXAkAMqqSkpFimCKTi3LS6qM83wuHHzKelILj6Q9DrvpIPcEuhAmvdBKLFNRF4rF0RsDivVJtmBeA4cPZfsayh5BYNv8az6rJ8m7eRAQh//IVWx0kQK23tLUownxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O14U35FqAnwTRkSYyKaihAMETodPliyYFID50S/8kAI=;
 b=OHHXyuCK8FK8KRqcskI5wndzhr/rrjF/HdjPF5Ir74wx2vOEpeP32QnIsRKo6bYv9rpM9hHtraR7GM8myNgx3zHg5jSQVPXLPC2oiCYi0+T6o4hZ0eFjuE6CuU7dno8yxno9jrfVKd3fYToSNzftkbRKSmHIFdmD9lCOy4ZL2LM=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 DM4PR18MB5026.namprd18.prod.outlook.com (2603:10b6:8:51::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Tue, 4 Feb 2025 16:11:41 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%7]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 16:11:40 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Luka Jankovic <luka.jankovic@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 "mattias.ronnblom@ericsson.com" <mattias.ronnblom@ericsson.com>
Subject: RE: [EXTERNAL] [RFC PATCH v6 1/2] eventdev: add atomic queue to
 test-eventdev app
Thread-Topic: [EXTERNAL] [RFC PATCH v6 1/2] eventdev: add atomic queue to
 test-eventdev app
Thread-Index: AQHbbka3xSZpDZj+OUa6u1PPzCklObM3YdVA
Date: Tue, 4 Feb 2025 16:11:40 +0000
Message-ID: <PH0PR18MB40860FA2D8B571B3F0FB0818DEF42@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250115133844.1403623-1-luka.jankovic@ericsson.com>
 <20250124095937.1436673-1-luka.jankovic@ericsson.com>
In-Reply-To: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|DM4PR18MB5026:EE_
x-ms-office365-filtering-correlation-id: 55f381d3-bea8-431c-c782-08dd45369c39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nYPJb9mHM/zLI6xpkkzY1DYoAYssG10nVgzTim+l/DHIN/qYKu70QYrCbgyJ?=
 =?us-ascii?Q?pHQSRgQ1zR5ghzhPiSQtOG2DbMcN0OMqpHvUee9rhxj/XzRXNtbzUJtIz1nc?=
 =?us-ascii?Q?EbuJiHfwqSK0SlLuQ5m40EBAVooOPaa29ZvP+KqOqg1QxMa24rCom50WQEBV?=
 =?us-ascii?Q?63v63wEe17narxa/MvjOp3sH+uN98Xzd1SdAbvZaSNsmietrxBXH2JeqyiEO?=
 =?us-ascii?Q?fxgumUg5ssUlznuD2NJ1i4/Tmo5YAJzDGL7LchMK9jUZd/pafuA4Ui4S+CYi?=
 =?us-ascii?Q?jFS01N7twDKDqsFnzYHS4SVrH6oBKf7yk6X0rrIFEfY17VZ/5hTCs40Lm49v?=
 =?us-ascii?Q?stHPen8xNRxW/HX0S63mkgh+d25cxtdNEH9fYD9W8bkZMC9XMJBeZlP2EqAS?=
 =?us-ascii?Q?NTeb/K2g6MroVEXXmS7Mgr/WDs5TY9QVbRk5cvH3/G3bP3gj1AchPWtIdEib?=
 =?us-ascii?Q?Hxv5iIDL12aMBaUWhZea9PDKRDYny9wzDomVUZsMm4OvrGp1oXyhyFxkwkht?=
 =?us-ascii?Q?EN1n7FJb/95YXeXJWuykVaTDuRkEKX/89VzoFHL1JEETf1z61A1M8eM7wdm+?=
 =?us-ascii?Q?wbo1U/oud3ixXUEDAOeOAzvDlEP9RI8xskpU4DSb/htIWBcAqX+HWo380fyz?=
 =?us-ascii?Q?OtJypCQu9g1mL2xh7FhziJnrQG69qOpJ/SGBEcOC8QmzRek0lVG6p3MMHxVz?=
 =?us-ascii?Q?xD7G17fXx2AuG1ss4dDLuEAOH/vAw2HygQkuJavYE6ihY1LZSdWNNCrXBl8u?=
 =?us-ascii?Q?wLbThCJScSO2ZZcjUE4bnBGV15ODqObnwXYrsyTIMbnmHbp9jQIwhemxqsrD?=
 =?us-ascii?Q?fWl+j/sE5GcBrH67+LB0WGwfj0+bs6ynLW5Q6311iwnDgJl2CYvtkIlKX8ge?=
 =?us-ascii?Q?bK2JuJZQvBbLHHj3W/CWpc4AkrSDd4DVZq8wYZXfBoCnuWPw8JJz9423eug1?=
 =?us-ascii?Q?wCKOu0si9nT6+4opFddorKPMdhxreR9GTQ6djj+kdVRZ2TvebY+KscGuprQb?=
 =?us-ascii?Q?+FuBWAm8HzgmCENXD1GSGvzceZBXyEt39wt0P7Yd4qex5a/sfK9azy05C2qf?=
 =?us-ascii?Q?sigVHulpEmF2DQEsmtVDATVzOPiJChwgfJQGJ602x3UM35oBEGFRXAW31Giz?=
 =?us-ascii?Q?/dpRRXbzVCrJ/viSu9FJcW327DqpX/VjW07oEgliFLcH6VLDBO0AJdOyIRQO?=
 =?us-ascii?Q?MgrQR5IfHK/lXiF4jUp9lJCZFLg6BeQogTFhui4ewYZuywi+ALsBqAecFtq6?=
 =?us-ascii?Q?cki/+w24heJW8i7uznXnC7N+GcnkQRdrA7Uu+IW4RXW0/nSVQl2t2CxP3m66?=
 =?us-ascii?Q?2G0mTRWicdanAIZYjpKhm6pwZxOwpb40vXXC3aOu/8xl5ezDFgwsstlI6gwC?=
 =?us-ascii?Q?esvmmG0wrLyV8C41I7mNOGFhYrFsmLRr0h+hsT6RHo/s6QAyKikwy5Isf+LJ?=
 =?us-ascii?Q?TwPqZP9z8ULh9dWs0tAzQkH6jMpY4qpa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ZxA9PfjZz22kogKrKZk/jQIklJh+M2L1qJX9Bg/e4KcY4MC+Lfn9KcUWQ0a?=
 =?us-ascii?Q?Ie9+R5wqOx8yQlUOJxAzP4zmOfdahG/ZnMR1U0ldcY+6KnPJliLr+mz17Eyb?=
 =?us-ascii?Q?uUErM0JEsFO0npd9RAs0Pby1SuPayS/atTGi5YyxHKdKZ3fHS2HkM5wvYCSU?=
 =?us-ascii?Q?FyijTCfEKO3ZfdwaHEH7bKQsdkGEFSiHodZOns6mLQ6Zcxs1o2i8tf26pjNV?=
 =?us-ascii?Q?CHuygbRGCKvXMLJT3vNXvxRq/Vz8djuafl+Pxgp9GWypg8kWCMuvJR0aKabH?=
 =?us-ascii?Q?Ghi5vs+cHrxP2dFeqpUsJg3kRmlJIdVDMsXTvosFO8WqfYGBtdQTYLOAfMT3?=
 =?us-ascii?Q?7qBG6SdR1J0pVaMRpnng7UyaofdomJLJoBgfrARMjpNKCmTWCT0ncQ4abK2W?=
 =?us-ascii?Q?6FmGX2+SK3sXQK/J+/yMbz3BfdklpS9ra0xESZAK/43CoEMxYbetrEQC1M3x?=
 =?us-ascii?Q?OkD+cbtWpQq5Axu+T71vAgzkod3grSX3Sva8LQY+6T8dsTdlvC4ZUjo1YSNv?=
 =?us-ascii?Q?i3PY8/GrligtqBKpHeUSh0Ncb//XsXCc/UzPl0UoogR4Aj7IYsM6xog8NTGA?=
 =?us-ascii?Q?hI5E16SdEJKX4HA8onjTY2G6JQu1I0QNYoC6NtZfrDaaPskMxyIOj99vVk9j?=
 =?us-ascii?Q?U4TN+r7+h9NqwWqpmvfKqdn8c4tXQFm8QloDPM+UzN14n4/vTccd9qlWXUJ3?=
 =?us-ascii?Q?5RdO5DgLF1veUpnfXliM4Bgd7lR+zWRevuK/DffHY7gxWssy0bwnUVlBqhQd?=
 =?us-ascii?Q?MdKRoqPwi/JXVluUff+qZeaJnUI7OdKJimizbk7mzhkf4tpWwB9LOxu9WrLq?=
 =?us-ascii?Q?ZaETZNIoQJW9FPpXy7ZI+BWpz5LWIG9BGtMIbz17UWGXFm5cLn00x+iIJc9f?=
 =?us-ascii?Q?2anANX9F5sd88m5WkeoldLRv+Mat7HEMiXMAg9ykLoeAnU4YImXwBPsrbtl9?=
 =?us-ascii?Q?6Am+uvwuAMJl0fX24JwWjRpyE5aK86bU8JTqXNkp7/c3kI19oUX98l/N3k57?=
 =?us-ascii?Q?h8t1cyYF2zvwnab78YSWsrJ0b3QCNcaFWxCuGKvFImrIyP0rADkO05mcfrxn?=
 =?us-ascii?Q?JqUzwuwP7btKqSMFRgN4ua88YYx26lK52cSPYvsLAbADKbuQIHc1wJ5tvWc/?=
 =?us-ascii?Q?B1htb+UU8Wj7IkKFtsh9e3N+VfSmZecwxusLEa8CZTAOqpSNN9wD7LHwaBNn?=
 =?us-ascii?Q?hm6Y3WugtjBkYA0uiNnN0uzgbXSmIULtCCuj+4sj31WK4rXLyH90+K+bN1VB?=
 =?us-ascii?Q?LnANJ+ZoXg9F4PXGttzns2ibM329DlIqXbiFkt/PfjJOPQE3jEzt8iqwHPEj?=
 =?us-ascii?Q?AUMNb4+qBGoRsV9/WbW1BxCL081oEiivOMEneXQrbnDau/YyaTykbqe4NbmK?=
 =?us-ascii?Q?jLdakZGVa545t/v8S8LYWXqxhC6g4d0P2KThQHAODcPupQf0LvoBua8WFTy3?=
 =?us-ascii?Q?nKZuknGxLHx1z9tCJaBpTD51hyg374RY4j/z/LoiIdNkSDMT7FRdaWNyj9vG?=
 =?us-ascii?Q?KFNU2g71l74yXoF1EYUwH5SZ72jhRKtHjRRk+sMDwt/ZjAOyNme68BjL8U8k?=
 =?us-ascii?Q?UQWSUKrS7tSRjB4RaeRv/WXyPe0WD0wnowghilv7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f381d3-bea8-431c-c782-08dd45369c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 16:11:40.7617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t38ujkB44TTGqIKFb2CJrtniQPvR9ONVwbdyMjIcPaGGjpej/RvEKy26p4jR5kKSr9JpO60ys4SRm32NxPbJR9P3qTybnQO4OoPY3QtB2+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5026
X-Proofpoint-GUID: 6O1ggvQ9WvlT2uIXA9-3qc8XGh0YRKrR
X-Proofpoint-ORIG-GUID: 6O1ggvQ9WvlT2uIXA9-3qc8XGh0YRKrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
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

> Add an atomic queue test to the test-eventdev app, which is based on the
> order queue test that exclusively uses atomic queues.
>=20
> This makes it compatible with event devices such as the
> distributed software eventdev.
>=20
> The test detects if port maintenance is required.
>=20
> To verify atomicity, a spinlock is used for each combination of queue and=
 flow.
> It is acquired whenever an event is dequeued for processing and
> released when processing is finished.
>=20
> The test will fail if a port attempts to acquire a lock which is already =
held.
>=20
> Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>

It would be great if you could add atomic-atq test too.

Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

> ---
> v6:
>  * Revert the use of event.u64 to mbufs as the Marvell CNXK platform
> assumes
>    event.u64 to be 8-byte aligned, which causes the test to fail.
>  * Clarified deadlock error message.
> v5:
>  * Updated documentation for dpdk-test-eventdev
> v4:
>  * Fix code style issues.
>  * Remove unused imports.
> v3:
>  * Use struct to avoid bit operations when accessing event u64.
>  * Changed __rte_always_inline to inline for processing stages.
>  * Introduce idle timeout constant.
>  * Formatting and cleanup.
> v2:
>  * Changed to only check queue, flow combination, not port, queue, flow.
>  * Lock is only held when a packet is processed.
>  * Utilize event u64 instead of mbuf.
>  * General cleanup.
> ---
>  app/test-eventdev/evt_common.h        |   9 +
>  app/test-eventdev/meson.build         |   1 +
>  app/test-eventdev/test_atomic_queue.c | 390
> ++++++++++++++++++++++++++
>  app/test-eventdev/test_order_common.h |   6 +
>  4 files changed, 406 insertions(+)
>  create mode 100644 app/test-eventdev/test_atomic_queue.c
>=20
> diff --git a/app/test-eventdev/evt_common.h b/app/test-
> eventdev/evt_common.h
> index 63b782f11a..74f9d187f3 100644
> --- a/app/test-eventdev/evt_common.h
> +++ b/app/test-eventdev/evt_common.h
> @@ -138,6 +138,15 @@ evt_has_flow_id(uint8_t dev_id)
>  			true : false;
>  }
>=20
> +static inline bool
> +evt_is_maintenance_free(uint8_t dev_id)
> +{
> +	struct rte_event_dev_info dev_info;
> +
> +	rte_event_dev_info_get(dev_id, &dev_info);
> +	return dev_info.event_dev_cap &
> RTE_EVENT_DEV_CAP_MAINTENANCE_FREE;
> +}
> +
>  static inline int
>  evt_service_setup(uint32_t service_id)
>  {
> diff --git a/app/test-eventdev/meson.build b/app/test-eventdev/meson.buil=
d
> index ab8769c755..db5add39eb 100644
> --- a/app/test-eventdev/meson.build
> +++ b/app/test-eventdev/meson.build
> @@ -15,6 +15,7 @@ sources =3D files(
>          'test_order_atq.c',
>          'test_order_common.c',
>          'test_order_queue.c',
> +        'test_atomic_queue.c',
>          'test_perf_atq.c',
>          'test_perf_common.c',
>          'test_perf_queue.c',
> diff --git a/app/test-eventdev/test_atomic_queue.c b/app/test-
> eventdev/test_atomic_queue.c
> new file mode 100644
> index 0000000000..d923df23cd
> --- /dev/null
> +++ b/app/test-eventdev/test_atomic_queue.c
> @@ -0,0 +1,390 @@
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +#include "test_order_common.h"
> +
> +#define IDLE_TIMEOUT 1
> +#define NB_QUEUES 2
> +
> +static rte_spinlock_t *atomic_locks;
> +
> +static inline uint32_t
> +get_lock_idx(int queue, flow_id_t flow, uint32_t nb_flows)
> +{
> +	return (queue * nb_flows) + flow;
> +}
> +
> +static inline bool
> +atomic_spinlock_trylock(uint32_t queue, uint32_t flow, uint32_t nb_flows=
)
> +{
> +	return rte_spinlock_trylock(&atomic_locks[get_lock_idx(queue, flow,
> nb_flows)]);
> +}
> +
> +static inline void
> +atomic_spinlock_unlock(uint32_t queue, uint32_t flow, uint32_t nb_flows)
> +{
> +	rte_spinlock_unlock(&atomic_locks[get_lock_idx(queue, flow,
> nb_flows)]);
> +}
> +
> +static inline bool
> +test_done(struct test_order *const t)
> +{
> +	return t->err || t->result =3D=3D EVT_TEST_SUCCESS;
> +}
> +
> +static inline int
> +atomic_producer(void *arg)
> +{
> +	struct prod_data *p =3D arg;
> +	struct test_order *t =3D p->t;
> +	struct evt_options *opt =3D t->opt;
> +	const uint8_t dev_id =3D p->dev_id;
> +	const uint8_t port =3D p->port_id;
> +	struct rte_mempool *pool =3D t->pool;
> +	const uint64_t nb_pkts =3D t->nb_pkts;
> +	uint32_t *producer_flow_seq =3D t->producer_flow_seq;
> +	const uint32_t nb_flows =3D t->nb_flows;
> +	uint64_t count =3D 0;
> +	struct rte_mbuf *m;
> +	struct rte_event ev;
> +
> +	if (opt->verbose_level > 1)
> +		printf("%s(): lcore %d dev_id %d port=3D%d queue=3D%d\n",
> +			__func__, rte_lcore_id(), dev_id, port, p->queue_id);
> +
> +	ev =3D (struct rte_event) {
> +		.op =3D RTE_EVENT_OP_NEW,
> +		.queue_id =3D p->queue_id,
> +		.sched_type =3D RTE_SCHED_TYPE_ATOMIC,
> +		.priority =3D RTE_EVENT_DEV_PRIORITY_NORMAL,
> +		.event_type =3D RTE_EVENT_TYPE_CPU
> +	};
> +
> +	while (count < nb_pkts && t->err =3D=3D false) {
> +		m =3D rte_pktmbuf_alloc(pool);
> +		if (m =3D=3D NULL)
> +			continue;
> +
> +		/* Maintain seq number per flow */
> +
> +		const flow_id_t flow =3D rte_rand_max(nb_flows);
> +
> +		*order_mbuf_flow_id(t, m) =3D flow;
> +		*order_mbuf_seqn(t, m) =3D producer_flow_seq[flow]++;
> +
> +		ev.flow_id =3D flow;
> +		ev.mbuf =3D m;
> +
> +		while (rte_event_enqueue_burst(dev_id, port, &ev, 1) !=3D 1) {
> +			if (t->err)
> +				break;
> +			rte_pause();
> +		}
> +
> +		count++;
> +	}
> +
> +	if (!evt_is_maintenance_free(dev_id)) {
> +		while (!test_done(t)) {
> +			rte_event_maintain(dev_id, port,
> RTE_EVENT_DEV_MAINT_OP_FLUSH);
> +			rte_pause();
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void
> +atomic_lock_verify(struct test_order *const t,
> +		uint32_t flow,
> +		uint32_t nb_flows,
> +		uint32_t port,
> +		uint32_t queue_id)
> +{
> +	if (!atomic_spinlock_trylock(queue_id, flow, nb_flows)) {
> +		evt_err("q=3D%u, flow=3D%x atomicity error: port %u tried to take
> held spinlock",
> +				queue_id, flow, port);
> +		t->err =3D true;
> +	}
> +}
> +
> +static inline void
> +atomic_process_stage_0(struct test_order *const t,
> +		struct rte_event *const ev,
> +		uint32_t nb_flows,
> +		uint32_t port)
> +{
> +	const uint32_t flow =3D *order_mbuf_flow_id(t, ev->mbuf);
> +
> +	atomic_lock_verify(t, flow, nb_flows, port, 0);
> +
> +	ev->queue_id =3D 1;
> +	ev->op =3D RTE_EVENT_OP_FORWARD;
> +	ev->sched_type =3D RTE_SCHED_TYPE_ATOMIC;
> +	ev->event_type =3D RTE_EVENT_TYPE_CPU;
> +
> +	atomic_spinlock_unlock(0, flow, nb_flows);
> +}
> +
> +static inline void
> +atomic_process_stage_1(struct test_order *const t,
> +		struct rte_event *const ev,
> +		uint32_t nb_flows,
> +		uint32_t *const expected_flow_seq,
> +		RTE_ATOMIC(uint64_t) *const outstand_pkts,
> +		uint32_t port)
> +{
> +	const uint32_t flow =3D *order_mbuf_flow_id(t, ev->mbuf);
> +	const uint32_t seq =3D *order_mbuf_seqn(t, ev->mbuf);
> +
> +	atomic_lock_verify(t, flow, nb_flows, port, 1);
> +
> +	/* compare the seqn against expected value */
> +	if (seq !=3D expected_flow_seq[flow]) {
> +		evt_err("flow=3D%x seqn mismatch got=3D%x expected=3D%x", flow,
> seq,
> +				expected_flow_seq[flow]);
> +		t->err =3D true;
> +	}
> +
> +	expected_flow_seq[flow]++;
> +	rte_pktmbuf_free(ev->mbuf);
> +
> +	rte_atomic_fetch_sub_explicit(outstand_pkts, 1,
> rte_memory_order_relaxed);
> +
> +	ev->op =3D RTE_EVENT_OP_RELEASE;
> +
> +	atomic_spinlock_unlock(1, flow, nb_flows);
> +}
> +
> +static int
> +atomic_queue_worker_burst(void *arg, bool flow_id_cap, uint32_t
> max_burst)
> +{
> +	ORDER_WORKER_INIT;
> +	struct rte_event ev[BURST_SIZE];
> +	uint16_t i;
> +
> +	while (t->err =3D=3D false) {
> +
> +		uint16_t const nb_rx =3D rte_event_dequeue_burst(dev_id,
> port, ev, max_burst, 0);
> +
> +		if (nb_rx =3D=3D 0) {
> +			if (rte_atomic_load_explicit(outstand_pkts,
> rte_memory_order_relaxed) <=3D 0)
> +				break;
> +			rte_pause();
> +			continue;
> +		}
> +
> +		for (i =3D 0; i < nb_rx; i++) {
> +			if (!flow_id_cap)
> +				order_flow_id_copy_from_mbuf(t, &ev[i]);
> +
> +			switch (ev[i].queue_id) {
> +			case 0:
> +				atomic_process_stage_0(t, &ev[i], nb_flows,
> port);
> +				break;
> +			case 1:
> +				atomic_process_stage_1(t, &ev[i], nb_flows,
> expected_flow_seq,
> +						outstand_pkts, port);
> +				break;
> +			default:
> +				order_process_stage_invalid(t, &ev[i]);
> +				break;
> +			}
> +		}
> +
> +		uint16_t total_enq =3D 0;
> +
> +		do {
> +			total_enq +=3D rte_event_enqueue_burst(
> +					dev_id, port, ev + total_enq, nb_rx -
> total_enq);
> +		} while (total_enq < nb_rx);
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +worker_wrapper(void *arg)
> +{
> +	struct worker_data *w =3D arg;
> +	int max_burst =3D evt_has_burst_mode(w->dev_id) ? BURST_SIZE : 1;
> +	const bool flow_id_cap =3D evt_has_flow_id(w->dev_id);
> +
> +	return atomic_queue_worker_burst(arg, flow_id_cap, max_burst);
> +}
> +
> +static int
> +atomic_queue_launch_lcores(struct evt_test *test, struct evt_options *op=
t)
> +{
> +	int ret, lcore_id;
> +	struct test_order *t =3D evt_test_priv(test);
> +
> +	/* launch workers */
> +
> +	int wkr_idx =3D 0;
> +	RTE_LCORE_FOREACH_WORKER(lcore_id) {
> +		if (!(opt->wlcores[lcore_id]))
> +			continue;
> +
> +		ret =3D rte_eal_remote_launch(worker_wrapper, &t-
> >worker[wkr_idx], lcore_id);
> +		if (ret) {
> +			evt_err("failed to launch worker %d", lcore_id);
> +			return ret;
> +		}
> +		wkr_idx++;
> +	}
> +
> +	/* launch producer */
> +	int plcore =3D evt_get_first_active_lcore(opt->plcores);
> +
> +	ret =3D rte_eal_remote_launch(atomic_producer, &t->prod, plcore);
> +	if (ret) {
> +		evt_err("failed to launch order_producer %d", plcore);
> +		return ret;
> +	}
> +
> +	uint64_t prev_time =3D rte_get_timer_cycles();
> +	int64_t prev_outstanding_pkts =3D -1;
> +
> +	while (t->err =3D=3D false) {
> +		uint64_t current_time =3D rte_get_timer_cycles();
> +		int64_t outstanding_pkts =3D rte_atomic_load_explicit(
> +				&t->outstand_pkts,
> rte_memory_order_relaxed);
> +
> +		if (outstanding_pkts <=3D 0) {
> +			t->result =3D EVT_TEST_SUCCESS;
> +			break;
> +		}
> +
> +		if (current_time - prev_time > rte_get_timer_hz() *
> IDLE_TIMEOUT) {
> +			printf(CLGRN "\r%" PRId64 "" CLNRM,
> outstanding_pkts);
> +			fflush(stdout);
> +			if (prev_outstanding_pkts =3D=3D outstanding_pkts) {
> +				rte_event_dev_dump(opt->dev_id, stdout);
> +				evt_err("No events processed during one
> period, deadlock");
> +				t->err =3D true;
> +				break;
> +			}
> +			prev_outstanding_pkts =3D outstanding_pkts;
> +			prev_time =3D current_time;
> +		}
> +	}
> +	printf("\r");
> +
> +	rte_free(atomic_locks);
> +
> +	return 0;
> +}
> +
> +static int
> +atomic_queue_eventdev_setup(struct evt_test *test, struct evt_options
> *opt)
> +{
> +	int ret;
> +
> +	const uint8_t nb_workers =3D evt_nr_active_lcores(opt->wlcores);
> +	/* number of active worker cores + 1 producer */
> +	const uint8_t nb_ports =3D nb_workers + 1;
> +
> +	ret =3D evt_configure_eventdev(opt, NB_QUEUES, nb_ports);
> +	if (ret) {
> +		evt_err("failed to configure eventdev %d", opt->dev_id);
> +		return ret;
> +	}
> +
> +	/* q0 configuration */
> +	struct rte_event_queue_conf q0_atomic_conf =3D {
> +			.priority =3D RTE_EVENT_DEV_PRIORITY_NORMAL,
> +			.schedule_type =3D RTE_SCHED_TYPE_ATOMIC,
> +			.nb_atomic_flows =3D opt->nb_flows,
> +			.nb_atomic_order_sequences =3D opt->nb_flows,
> +	};
> +	ret =3D rte_event_queue_setup(opt->dev_id, 0, &q0_atomic_conf);
> +	if (ret) {
> +		evt_err("failed to setup queue0 eventdev %d err %d", opt-
> >dev_id, ret);
> +		return ret;
> +	}
> +
> +	/* q1 configuration */
> +	struct rte_event_queue_conf q1_atomic_conf =3D {
> +			.priority =3D RTE_EVENT_DEV_PRIORITY_NORMAL,
> +			.schedule_type =3D RTE_SCHED_TYPE_ATOMIC,
> +			.nb_atomic_flows =3D opt->nb_flows,
> +			.nb_atomic_order_sequences =3D opt->nb_flows,
> +	};
> +	ret =3D rte_event_queue_setup(opt->dev_id, 1, &q1_atomic_conf);
> +	if (ret) {
> +		evt_err("failed to setup queue0 eventdev %d err %d", opt-
> >dev_id, ret);
> +		return ret;
> +	}
> +
> +	/* setup one port per worker, linking to all queues */
> +	ret =3D order_event_dev_port_setup(test, opt, nb_workers,
> NB_QUEUES);
> +	if (ret)
> +		return ret;
> +
> +	if (!evt_has_distributed_sched(opt->dev_id)) {
> +		uint32_t service_id;
> +		rte_event_dev_service_id_get(opt->dev_id, &service_id);
> +		ret =3D evt_service_setup(service_id);
> +		if (ret) {
> +			evt_err("No service lcore found to run event dev.");
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D rte_event_dev_start(opt->dev_id);
> +	if (ret) {
> +		evt_err("failed to start eventdev %d", opt->dev_id);
> +		return ret;
> +	}
> +
> +	const uint32_t num_locks =3D NB_QUEUES * opt->nb_flows;
> +
> +	atomic_locks =3D rte_calloc(NULL, num_locks, sizeof(rte_spinlock_t), 0)=
;
> +
> +	for (uint32_t i =3D 0; i < num_locks; i++) {
> +		rte_spinlock_init(&atomic_locks[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +atomic_queue_opt_dump(struct evt_options *opt)
> +{
> +	order_opt_dump(opt);
> +	evt_dump("nb_evdev_queues", "%d", NB_QUEUES);
> +}
> +
> +static bool
> +atomic_queue_capability_check(struct evt_options *opt)
> +{
> +	struct rte_event_dev_info dev_info;
> +
> +	rte_event_dev_info_get(opt->dev_id, &dev_info);
> +	if (dev_info.max_event_queues < NB_QUEUES ||
> +			dev_info.max_event_ports <
> order_nb_event_ports(opt)) {
> +		evt_err("not enough eventdev queues=3D%d/%d or
> ports=3D%d/%d", NB_QUEUES,
> +				dev_info.max_event_queues,
> order_nb_event_ports(opt),
> +				dev_info.max_event_ports);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static const struct evt_test_ops atomic_queue =3D {
> +	.cap_check =3D atomic_queue_capability_check,
> +	.opt_check =3D order_opt_check,
> +	.opt_dump =3D atomic_queue_opt_dump,
> +	.test_setup =3D order_test_setup,
> +	.mempool_setup =3D order_mempool_setup,
> +	.eventdev_setup =3D atomic_queue_eventdev_setup,
> +	.launch_lcores =3D atomic_queue_launch_lcores,
> +	.eventdev_destroy =3D order_eventdev_destroy,
> +	.mempool_destroy =3D order_mempool_destroy,
> +	.test_result =3D order_test_result,
> +	.test_destroy =3D order_test_destroy,
> +};
> +
> +EVT_TEST_REGISTER(atomic_queue);
> diff --git a/app/test-eventdev/test_order_common.h b/app/test-
> eventdev/test_order_common.h
> index 7177fd8e9a..471a044611 100644
> --- a/app/test-eventdev/test_order_common.h
> +++ b/app/test-eventdev/test_order_common.h
> @@ -79,6 +79,12 @@ order_flow_id_save(struct test_order *t, flow_id_t
> flow_id,
>  	event->mbuf =3D mbuf;
>  }
>=20
> +static inline flow_id_t *
> +order_mbuf_flow_id(struct test_order *t, struct rte_mbuf *mbuf)
> +{
> +	return RTE_MBUF_DYNFIELD(mbuf, t->flow_id_dynfield_offset,
> flow_id_t *);
> +}
> +
>  static inline seqn_t *
>  order_mbuf_seqn(struct test_order *t, struct rte_mbuf *mbuf)
>  {
> --
> 2.34.1

