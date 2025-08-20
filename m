Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E939ECA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 12:04:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 121F840292;
	Wed, 20 Aug 2025 14:04:14 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by mails.dpdk.org (Postfix) with ESMTP id B6E294027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 14:04:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeBSnhOJNYQ09Z0aE15cXoGRB/DEdU9T8+p1phk3gkgq8hYuZYQSvBfVOwXlgTiv4CVve5mvpv4iiqMptZxjOH8h1z+XddQaRz2HT3mGdKVAEauEa1S5+TX7Z1KxlSRuzkz59SvfTc+w+4ElVj8rqxE06A0FKGHb9lg/S2wGM6xstmYRxbABBfikxTKmr75YfmPByiCcNUs/C0TC5kcbmtxkfJlmH6UgR5vzGwlaN09f/og+F0Tw7TAUC2ikNXxdtT/pVnV25R0CZC160SbHPhMnNRiTBlZA7znYc4J08AeT1PLAofgrHny96PmP25wnRKjwlnvH7e6r4RGdGUPdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbVlgE4YSKkB3OKCgTk9ZZNqaF3JWJw9SIKWT9chlkk=;
 b=pwH6Fz258FNJsCbRqvVeIV03Us+ZcRQOL0NeQM1ymFy8tlWQt4ZIzAMFJ9h6sI2MmNjHpptwt+Slw0xmKHXldku4d2wQRhQWTSWcNd268ahWybzc3OA1bXU+/vxZJ+Wt8R5EgRyABe9bq/dbwaXxr1434jL8jxk1HrX/aJBd6uq9tfFAyZaEyE0X45ppoHH+0T/EWeYgqyK8KkScJcJEkJDXlsKYVpj4HnbSH+GV5Ln4/Hufkt+GNzdqah4ppi1VE+oEcSgDqhkFvWPqnWNDtIl/oMn5gJTy76+4HCZjDQQo/2uLykmUgpQ+GnRM84RJOGbndBfRjjwzPCNgg7tbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbVlgE4YSKkB3OKCgTk9ZZNqaF3JWJw9SIKWT9chlkk=;
 b=byr7g+Gl9yWzMVOYO9yEYHgYVp5Qd0aVFyy5+TQvHm0q32FNmagzBRMj3X8+KNErmb3qtSdc6xoncFwWO5g1/iC0fLSoG0t8Jxb+59HZShtESAauvqjDOAChhHkpf5gWtZAtNXJyHL69Tk7OQMr8JBsyJjps4h8rrLLpMUtdAiG+cuQLe3ryaCtqe20ZU0qLjSJooLQXBxolCb3loCauBdjHVYimWXpVBHZ87htOHoVOPHmtQCGjQfvIV6GRWH+tl4EGDEdIh44NWFESsKzXK4v1+Aq7AUcLWZALn2wVvXiqEC/wsfMGoucTzehmWmFjdsYgw0qtUmm0GrKcfMhPXA==
Received: from BYAPR11CA0039.namprd11.prod.outlook.com (2603:10b6:a03:80::16)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:04:05 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::aa) by BYAPR11CA0039.outlook.office365.com
 (2603:10b6:a03:80::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 12:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 12:04:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 05:03:49 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 05:03:48 -0700
Date: Wed, 20 Aug 2025 14:02:42 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Joni <canary.overflow@gmail.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: Segmentation fault when running MPRQ on testpmd
Message-ID: <20250820120242.63zqjpokdzmumrka@ds-vm-debian.local>
References: <CACGKW7TYR50ehjwexYrkrtCG2qq7-Ayj89K+wyoO5e2a2+F8hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGKW7TYR50ehjwexYrkrtCG2qq7-Ayj89K+wyoO5e2a2+F8hA@mail.gmail.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 7258bdf8-ece0-4af2-4e65-08dddfe1a904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|30052699003|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmdxbUU5YmFYOGVlcVdEbGpsM0hVcGFYQUtRa0RsZ08rMlVCSWVrQ2kwa0NC?=
 =?utf-8?B?Nm01c2FhNzBidnpNTWJuZ3JQdmlldG1kZHIzYzJxWThhUnljWExib3BxNlpZ?=
 =?utf-8?B?dHZQNW5IWmU5WEVFRWxLOEVNSlBjbzhyRUc3MElKdy93ZWZiMi9vRTZ0YUI4?=
 =?utf-8?B?d1FzaXlsY1BoUVpucFoySTZSTERIWWhzZEMzelc0ZVR2VXEzZ29MaFVtU3Y3?=
 =?utf-8?B?SEx6RG1GdU1sajJOVUZGVnU2bVJhSFlBdjIvRFVrQ0ZYc1RZZkFua2lZajR2?=
 =?utf-8?B?a1BMUllRZmQrTXEzTksyYlRBQXhlWlZ1QjFZK21HRHdmalk4UTVFSFhLMmpy?=
 =?utf-8?B?T3o3RzRnOTJnYVRGa2d0YlNMUEF1V2pvbU5ueUtReEY2MWhtd3NYMVJzNDdN?=
 =?utf-8?B?MWlpUnVHdjQxdUx6QUxoczRaakNRZjBoNnRPMnZuV0N5SU5kMXh2b1JUQWdh?=
 =?utf-8?B?bVNDNzdHTFhnaDlDcWNwbW1DYVRpZnNERko5aXI5N0xpUFRIM1RWQzVuVkM1?=
 =?utf-8?B?cGo5WFc0dEd2VVUwWTlwUFN1eGQzdE56bi9zWjlWU1ZqSGQyNXhjY2JZbW9r?=
 =?utf-8?B?RW4ya2EyMzQ3UGhJVmtkRVVPT1hGVHJKUkNyUHIrM0hOSDNxVjd3MmFHNUhH?=
 =?utf-8?B?OGJqYjk2SmgzZ01uZkxHa1lIaVZxWjlicVlIb0lEdm5EaldIQ0NDa3lrUkgv?=
 =?utf-8?B?eEhSZXErQ1VZSXB2V1MxUWtpRWFwT0x0d2NOOHBCRE9abkZBazVkV2tMQXlj?=
 =?utf-8?B?elcrend4d3hPQWU1TkN1Nnd2RDhiY2NkbjBVdlcvVjBnLzlMZVp1ZUtYaEZn?=
 =?utf-8?B?VzJ2anB1OUxPYWZHUlRvcEMwTHF3VHdMMitPZU9GTUVzOEtvejh0OTZSZ0Vt?=
 =?utf-8?B?K1I0T05IdnZmZmRvcms5UEFxZDlrVkdCNnc4b3VKUlRSNTJvNSs3V1prZVhI?=
 =?utf-8?B?TjdKQlNVaWVIcVBFN2cwM3N2NXhqa1Z5N1V4OEdZVlg2a2NFTEFDTzRldHNk?=
 =?utf-8?B?a1JSSXZVd0FzNHFiSEkwVWlSZW5PRFdhdmpyaUZZZWVTTEVCZW91YnE2N2Vj?=
 =?utf-8?B?cEM4aU56ak1aQUJHay95MjJjTzJ2UTN4K2ZESVNaOGpjOW9VTlFuRDIrb3JC?=
 =?utf-8?B?aVN3UDI1azVLbjJIUHB2TFhaZGplK2dLR011eXQwdytMaGRreGlqNzlGdDBy?=
 =?utf-8?B?OCs0SEJpQVhuVkpWMndlMko2WUdRTzFKSXlEcFdMSG9UMHFuRWRlakVHc0Yv?=
 =?utf-8?B?VjRIbys3K3ZYdjdxV3MxdndjT3dtT2ZHc1NseXNaWldpeEpOM01XSDkwODN6?=
 =?utf-8?B?M1pCcCtJU3ZaS3FhS05ZT0hBZFlzMnFLUERKS3V1RUpJVFpyKytvVFk2VTRZ?=
 =?utf-8?B?N0JUMVdCd2pYS1oxNkwyZ3lQcXIvNkYrUmVZVE9VaEsvOTkzZk13NSsyS3F0?=
 =?utf-8?B?cXRUZUdtSzB6Z3hZQkNFWDR1VzQvNGxJR0crUXp2RHRYdngxUXZRbzdocVJw?=
 =?utf-8?B?c1hldDd4UnExRVovcFpibGZjdkppYjJMM1I4bnI5SG9mU3dhNFVQVXZGdDNX?=
 =?utf-8?B?dDVjbGxnUGN2MDdMaHlCQjNWak5nbWtLTWdJcVNVTSsvZy9GcVc4YjY3Z1Jh?=
 =?utf-8?B?MFptMW9xbjJKamZnb3ZrMHpqMFlNR1dGZk8xakRzenh3YWlOZW9SSnk0OTFP?=
 =?utf-8?B?bmpoU2dIeVd3VGpQdnpUQk9oeE5ybWZHbkdSUmxENUdtYk9Ib0ZEZnhLcVl2?=
 =?utf-8?B?MDQvaGJhSVVwYlU3aGJrNXlnb28rQ3hxZXZXSlJtdEdaamNMMDFCOXRQakZT?=
 =?utf-8?B?Y2NNaUp5U2V3QU5HN1FHdGtMcWRibGRPUGh1cGJvenNBRTg3VFhHeHpjazNm?=
 =?utf-8?B?Z0pyQmpkYUg3bE5VTGdWZGYyVDZLZ0RPdHJJSVhNRVlncVhBVnNNNE1rdFZ4?=
 =?utf-8?B?c3pmMHNLUzloQ3NsZVZCZnY4TmJkZEY3dkNtTTR1RVlOczFHYjgvQXp5T0VP?=
 =?utf-8?B?bEJtS09QMHB5blV3dUFvaGJscFZHVU1MVEJKSi9XblJ6ZGZCTXZLQTl0cWY2?=
 =?utf-8?Q?9QCEZN?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(30052699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:04:05.1692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7258bdf8-ece0-4af2-4e65-08dddfe1a904
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

Hi,

On Wed, Aug 20, 2025 at 04:40:16PM +0800, Joni wrote:
> Hi,
> 
> I hope this is the correct place to report these issues since it seems to
> be related to DPDK codes. I've reported this to Nvidia a few days ago but
> have yet to receive any response from them.
> 
> My server is currently using ConnectX5 MT27800 (mlx5_core 5.7-1.0.2) on
> firmware 16.35.4506 (MT_0000000011). My DPDK library version is 22.11.
> 
> I ran the following testpmd command which resulted in segmentation fault (I
> am currently running on filtered traffic with packets >1000 bytes to
> increase the odds of hitting the segmentation fault):
> 
> dpdk-testpmd -l 1-5 -n 4 -a
> 0000:1f:00.0,rxq_comp_en=1,rxq_pkt_pad_en=1,rxqs_min_mprq=1,mprq_en=1,mprq_log_stride_num=6,mprq_log_stride_size=9,mprq_max_memcpy_len=64,rx_vec_en=1
> -- -i --rxd=8192 --max-pkt-len=1700 --rxq=1 --total-num-mbufs=16384
> --mbuf-size=3000 --enable_drop_en –enable_scatter
> 
> This segmentation fault goes away when I disable vectorization
> (rx_vec_en=0). (Note that the segmentation fault does not occur in
> forward-mode=rxonly). The segmentation fault also seems to happen with
> higher chances when there is a rxnombuf.

Thank you for reporting and for the analysis.

Could you please open a bug on https://bugs.dpdk.org/ with all the
details?

Do you happen to have a stack trace from the segmentation fault?

Slava: Could you please take a look at the issue described by Joni in this mail?

> 
> Upon some investigation, I noticed that in DPDK’s source codes
> drivers/net/mlx5/mlx5_rxtx_vec.c
> (function rxq_copy_mprq_mbuf_v()), there is a possibility where the
> consumed stride exceeds the stride number (64 in this case) which should
> not be happening. I'm suspecting there's some CQE misalignment here upon
> encountering rxnombuf.
> 
> rxq_copy_mprq_mbuf_v(...) {
>     ...
>     if(rxq->consumed_strd == strd_n) {
>         // replenish WQE
>     }
>     ...
>     strd_cnt = (elts[i]->pkt_len / strd_sz) +
>                ((elts[i]->pkt_len % strd_sz) ? 1 : 0);
> 
>     rxq_code = mprq_buf_to_pkt(rxq, elts[i], elts[i]->pkt_len, buf,
> rxq->consumed_strd, strd_cnt);
>     rxq->consumed_strd += strd_cnt;       // encountering cases where
> rxq->consumed_strd > strd_n
>     ...
> }
> 
> In addition, there were also cases in mprq_buf_to_pkt() where the allocated
> seg address is exactly the same as the pkt (elts[i]) address passed in
> which should not happen.
> 
> mprq_buf_to_pkt(...) {
>     ...
>     if(hdrm_overlap > 0) {
>         MLX5_ASSERT(rxq->strd_scatter_en);
> 
>         struct rte_mbuf *seg = rte_pktmbuf_alloc(rxq->mp);
>         if (unlikely(seg == NULL)) return MLX5_RXQ_CODE_NOMBUF;
>         SET_DATA_OFF(seg, 0);
> 
>         // added debug statement
>         DRV_LOG(DEBUG, "pkt %p seg %p", (void *)pkt, (void *)seg);
> 
> rte_memcpy(rte_pktmbuf_mtod(seg, void *), RTE_PTR_ADD(addr, len -
> hdrm_overlap), hdrm_overlap); ... } }
> 
> I have tried upgrading my DPDK version to 24.11 but the segmentation fault
> still persists.
> 
> In addition, there were also a few other issues that I've noticed:
> 
>    - max-pkt-len does not seem to work for values < 1500 even though "show
>    port info X" showed that the MTU was set to the value I've passed in
>    - In mprq_buf_to_pkt():
>        - uint32_t seg_len = RTE_MIN(len, (uint32_t)(pkt->buf_len -
>    RTE_PKTMBUF_HEADROOM)) --> seems unnecessary as to hit this code, len has
>    to be greater than (uint32_t)(pkt->buf_len - RTE_PKTMBUF_HEADROOM) due to
>    the if condition
>        - If the allocation struct rte_mbuf *next =
>    rte_pktmbuf_alloc(rxq->mp) fails and packet has more than 2 segs, the segs
>    that were allocated previously do not get freed
> 
>     mprq_buf_to_pkt(...) {
>         ...                } else if (rxq->strd_scatter_en) {
> 
> struct rte_mbuf *prev = pkt;
> 
> uint32_t seg_len = RTE_MIN(len, (uint32_t)
> 
> (pkt->buf_len - RTE_PKTMBUF_HEADROOM));
> 
> uint32_t rem_len = len - seg_len;
> 
> 
>       rte_memcpy(rte_pktmbuf_mtod(pkt, void *), addr, seg_len);
>       DATA_LEN(pkt) = seg_len;
>       while (rem_len) {
>          struct rte_mbuf *next = rte_pktmbuf_alloc(rxq->mp);
> 
> 
>             if (unlikely(next == NULL))
>                 return MLX5_RXQ_CODE_NOMBUF;
>             ...
>     - In the external buffer attach case where hdrm_overlap > 0, the code
> did not decrement the buffer refcnt if allocation struct rte_mbuf *next =
> rte_pktmbuf_alloc(rxq->mp) fails
> 
> mprq_buf_to_pkt(...) {
>     ...            if (hdrm_overlap > 0) {
> 
>         __atomic_add_fetch(&buf->refcnt, 1, __ATOMIC_RELAXED);
>         ...
>         MLX5_ASSERT(rxq->strd_scatter_en);
>         struct rte_mbuf *seg = rte_pktmbuf_alloc(rxq->mp);
>         if (unlikely(seg == NULL))
>             return MLX5_RXQ_CODE_NOMBUF;
>         SET_DATA_OFF(seg, 0);
>         ...
> 
> 
> Hope to hear from you soon!
> 
> With regards,
> Joni

Best regards,
Dariusz Sosnowski
