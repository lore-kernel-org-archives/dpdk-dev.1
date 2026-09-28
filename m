Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31317C9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B98440269;
	Mon, 28 Sep 2026 12:47:14 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by mails.dpdk.org (Postfix) with ESMTP id F221740041
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:47:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcQALZNzcKehpVE+LmRniFzKGCuF4ROn/3YP/eNljegB89vsttFsx6SwiqruftUcziYhUN4BNvapdfdU6eFsBen+cFJgZOYHp6HXOQi+3xnj+Oy/3MNQK4NzDT5ZhafVOcmIR05dpCvfCaQwtkH0YqGnDMaNp4cCVONJ9nQqt7a1sXHo0cNpvjtQO2B3TvEJYFSFvuySLes3jYM0aj3PJgtwBKmWpaWqsuilBC/15eP/yD3HFeqbhwkwZM4bhr2t4qf+Nq+Gk2GwXkwjLXq5kfCUQu1HHN39jhWDG+p01ziWGVOCJWYuoOLpj1+rKO+tOC2eNeQWV4SSU3wDcolrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRRYuR+b5FSLNwpkzKll/AAuVDrnX00hQxsSBTiMGbQ=;
 b=n4L+xUZ2Wnx8l/XWZ4fHBLpSFGhGwf/KQJXjpZV5KrbsmCEvkRqIdpuSUUY0gp6mDFR2PBZGneDPV2/v6dRZ+1BFk2YS6yAlOcSX7SuxtVwgp56Gr7zLTA54AKaKC1sJK2hN0PYqcH2KyjnRz4kmFZiY2utwmP4basJ1wuETEj3x6ii/RKdNtjJc6FIZGiZUgvHm1l52SneWq6VbiJ+tV8yOm17shiI8DDZy+WZHEcjhoqnRb5qIrr6iPRbfyFVtlvXia9J/XdfO88kbuTsQzrX4jXfI9kc0Faac0+L+ntEHbIv7ctroVNbgcGIHB5Wl9rIMftYQxwdfARFUw4xFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRRYuR+b5FSLNwpkzKll/AAuVDrnX00hQxsSBTiMGbQ=;
 b=e/M6N/M1og0eTDilWcmkHShH8xIB0ZN4H+7S3A+0N9l+I8NTITfROiqh8W4Xp3qfAJTrQsr9iGoXdB33cM35g/X8+/OF9FHXF7tURuIbwd46RUgA9WVNRWXUIOcfsdINcLVsxB8iRwOm7xlGagzeaAUu4/pKkm3IT9eMK1JxGoo=
Received: from BLAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:36e::23)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:47:09 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::40) by BLAPR05CA0020.outlook.office365.com
 (2603:10b6:208:36e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Mon,
 28 Sep 2026 10:47:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:47:08 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 05:47:05 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Jingjing Wu <jingjing.wu@intel.com>, Selwin Sebastian
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Sachin Saxena <sachin.saxena@oss.nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v1 2/3] raw/ntb: add AMD NTB support
Date: Mon, 28 Sep 2026 16:16:39 +0530
Message-ID: <20260928104639.2373194-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arZLWdmiKaF_BYwY@bricha3-mobl1.ger.corp.intel.com>
References: <arZLWdmiKaF_BYwY@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: e554ad0e-846b-4210-119f-08df1d4dd85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|3023799007|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VxRaWQ0NOEYryaFhh9MSeSsiLk6fvKpw03f3RES7CTKcarrkvBN9GERkWdXSyYyDwie56CocmKUkVC+G05aWbSK6slp/Jfp9KzD9/E1jwflus/C92ptXcIvyYwzfV3InRnUysSB2gU1z1mVlUQ2c/zZIRs/xzzQpk+Jrk7lUQ6UyimkMyRhkhQAw0PBZGo5rJdzcWf2F9qwagnCsXz2C4DmXv76mqWrRqDe6XErYvrHqR4rlVxUMbo0BiSi1YDYdJDLGnsIOeV3bpsQdjK8Kojsumoex3eqT+Tt939zZeUahjARpkZJKyxqomoidzNQHbgfJ6TUWFzJE8UcNYpzdrCg+Pnx7P3BFog9wKx9stfKsVa5L63m2UrObr5gHd/5kVkkMlYUI8rqVyzCYvAbosKT/Gq9Y+NMF5i4bsHwZhjWrPebSkzjskACi/KbYps8g5oYVseZf5x4K/t9LSPzQfYnAa+hhvUiK3TncgU3kJX4Gt0X2DHQlvt5mvupLi7q2UDjaYWwEcKI3B3suTnHf5dI0yiDDbgFS2Vr/FsvR7ti5J8VkXiJnmf5TQSrVlh2o7xILfUIEmotpqh713nlbw7qEgz4VBIE3qLCJ1VG4YN/AoR2yV+YErxGdJ95haN2nXWc9XLRBLJe5p5aopxmqOdJYLqY90JIvJoJPp4BtNCZJXYNrj4pSIWCJFqD2NapTzBQ8OmatRz4qXIkOHGfL7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VlklM246MyC4SfjpTMXhMUC7mMXMhesLtr1ke3zKaoIimeRiIQlJnjV1iDEFCxIEO5MCLyzzWxJWqhdK845XvGChoUjRPtyzzVGcOby1/caGMCDlGkN8pd6zACbq/0BwBI3VAHMlr3v6/rdme2GAvWk8aKWYUw/AWbr6CV1a3IGVcqDKuN/SJCG9uPjloXd5GOeR9W+F6vHhXJrTvXdDmBTUyLIs6GvfkJF6N3H0su5B8LQPGbXYYw+ugKPme52/KeKtRRh3myayIy6p2b4H4Qhb94ddn6dP29mNfzrwQ1rUR1Tc1jNJ4x1Qo8psDlXKszviIxHBnsOI+iaXBFlf/LQFqd6IZfLy4MtdGGnt7gF09D98QkM15bADx5iLvGJsRMlF/CwDQrcbTrJMcU0xzjGi34ITE2F+fGdyYLejTJWFbvCIm7+H1cpt74FXlCG9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:47:08.9075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e554ad0e-846b-4210-119f-08df1d4dd85c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

On Fri, Sep 25, 2026 at 10:22:17AM +0000, Bruce Richardson wrote:
> Reviewing changes to common code only, please see inline below. I think
> there is quite a bit of complexity introduced by the alignment constraints
> which could do with being simplified.

Thanks Bruce, agreed on all counts. v2 reworks the alignment handling
exactly along the lines you suggested. Point-by-point below.

> > -                'ntb_hw_intel.c')
> > +                'ntb_hw_intel.c',
> > +                'ntb_hw_amd.c')
>
> Very minor nit, but consider putting the ")" on the next line and putting a
> comma after the 'ntb_hw_amd.c' entry (since meson allows a trailing comma).

Done in v2:

  sources = files(
          'ntb.c',
          'ntb_hw_intel.c',
          'ntb_hw_amd.c',
  )

> > +	/**
> > +	 * AMD NTB uses an outbound translation window: writes to a BARxx
> > +	 ...
> > +	 */
>
> Consider shortening the coment here. Also see other feedback below
> regarding this field.

The whole block is gone in v2 - ntb_dev_info_get() no longer sets any
per-vendor alignment field (see below).

> > +	uint64_t mw_addr_align;
>
> Again, shorten the comment here to just a line or two.
> Also, in terms of how it is used, remove the special case for 0 == cache
> aligned, and instead change code assignment above to be cache aligned by
> default. [...]
>
> This is really complex to have in the app [...] I would suggest that,
> rather than trying to expose this via a single addr_align value - which it
> turns out isn't actually the alignment needed - you add a separate API
> called "get_mem_align" or something similar, and then hide the complexity
> of this calculation in the driver. Then you can drop the mw_addr_align in
> the info struct.

Done. v2 drops mw_addr_align entirely and adds an experimental API:

  uint64_t rte_pmd_ntb_get_mem_align(uint16_t dev_id, uint32_t mw_id,
                                     uint64_t mw_len);

backed by a new mem_align op. The driver returns the actual base-address
alignment required for a window of the given length, so the app has no
hardware-specific logic. The AMD driver returns
max(4K, rte_align64pow2(mw_len)); the Intel driver returns the memory
window size (matching the previous mw_size_align behaviour). The app
just reserves the memzone with the returned value, no branching:

  align = rte_pmd_ntb_get_mem_align(dev_id, mz_id, mz_len);
  mz = rte_memzone_reserve_aligned(mz_name, mz_len, socket_id,
                                   RTE_MEMZONE_IOVA_CONTIG, align);

The alignment rule itself now lives in amd_ntb_get_mem_align() with a
short comment; the misaligned-base check stays in amd_ntb_mw_set_trans().

Thanks,
Raghavendra
