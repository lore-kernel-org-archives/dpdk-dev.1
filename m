Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B2EC9833E
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CB7E40269;
	Mon, 28 Sep 2026 12:47:39 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by mails.dpdk.org (Postfix) with ESMTP id E36AE40041
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:47:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqVS7xDjwJD1CxEy2F0IlyRIDXS4hZm67WSgC8xq05QSE3BRH9vMfk7IXgHHMQjD+vxEBkPOAs/0etfO4ugbxcTMylqtQ+fnGROKxjQHHeZ+kzwOt1sDfBhRSJT6DV1oVT3x5QVbETZFYA9hyPI/j3ntWUhYH0cJOuP3519T9GUaF/1E1V77VK/o9gc5bqUTaUzhuU0u0sGxu4mxJGyXbmQesKnO1PXQCEu1EOYAqQ5O9Gr5fd61Wbp5xwClnAezt87RRkXqmPmUVWe2bA5h1SbchYUVOqH37ZmNo7KNSBOmAQJglvT/lRaK8sD6ploPQ3amIJVnu90Et/6EUcdOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az13Kzteu8kT2gjkOsKYEjUAUjBfN+E/16f928oCgXM=;
 b=udvaQ0/zalDmCSJleoPAw0y3lK+whbULuQZFqUZGPK4e6JQl/+JYGV7Y2lwNFQZ3P1nZkHW+1lIqbgZA3Q14os/FLK1/oDUGxQ9GrgdUnAJbnw9gJOghFHn+ieIMWnYD6aLW/5eXPPHS0MCYuKM1Nz5ew7sYCjhANDDgxR8cFy/B3DSlZ3HnOOaQuT1Og3UrZqrI7oQGxRilFqKmsdKWRoHceBQH7J80OqrloICwXyTnZHru50HGJve79EKuW0qlrNBtcFhR0Vu8+D+7N2KdKb+UrMLA6LQqiWu9kNK9Rf36UG/QR32DArbXF0FNRIZBVHlB13ECFGu2c/P+i2c+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az13Kzteu8kT2gjkOsKYEjUAUjBfN+E/16f928oCgXM=;
 b=2fhK+JnXdbY+SkMqpcZmIrcZ0DCnEcOQCQaWn+IIOS2w0WNzOlZYoGozHgW226o+u6cWK4JMtwipE7ITkbiIDwRw9nBmv7OvOB8qvObKZOL1gzXsw9IGV5GyZTaY6tMAWuNV05czrgYj548ADxJMeKYlwoayV52SSG6iWysVTwA=
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:47:34 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::20) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.13 via Frontend Transport; Mon,
 28 Sep 2026 10:47:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:47:33 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 05:47:29 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Jingjing Wu <jingjing.wu@intel.com>, Selwin Sebastian
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Sachin Saxena <sachin.saxena@oss.nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v1 3/3] doc: add AMD NTB support
Date: Mon, 28 Sep 2026 16:17:14 +0530
Message-ID: <20260928104714.2373250-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arZSCR-GL1jq3iqM@bricha3-mobl1.ger.corp.intel.com>
References: <arZSCR-GL1jq3iqM@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 3596529c-af32-447d-839c-08df1d4de71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FD7/SKaxlFotMQRvaXz0Rp2rrD1eNdMIbhHlyUsx/gakO32Wiiuj5giTWByQW6sT2I4AL4qyI9eEJGp/3DOd0PZYnyKaYmb+BIdYSezAkDCvAza0nVHpSOsa9h9lxj22dxlgDCOJ5rjYqmNzHtiP/iAsEC56oOs27UK+vf8xiqwDhhrp+6yis5kQ5rx1dy2rtPwjqQZfENxvoBaDDrmOx0ITG9A/fgK2GonAU1Qp4aU4xuYVpHgaDJ3/Ea9DgYtD95XLIbQ+rlhFJrrkzNyV+51fRpptlxCHJnyif1c2YnU5StJIZmyGDnBh9IATvQRAwg9nQeXwOHKUXOGX/r34576b4lmwwQR+RU3iVaG0AAGReY17/M5B0g+UyaZw8DGLIz3nhLw73K4W76/JcJzv21R4s9LZ5UVLTFAmDBO13NK3CRbFzuNlP4Wt4qu6Ol7su4a1vIhp6Q5WGo6axJ/qwNKe/u5uJWNySYl4aoCRZ1eIzOYdNtRUNrYii+6CZCKWVlnWy0ULht7OiBqOoa75MsbT1b/fdnLZcpFYwgM2c58wTTCHh9Yx4EhOk/au/QjsQszgSqy9/t0Rez4GDlF2vbWhhbmFxiLI9Ges7NEpqkNE+VowUf4WSwqTjUyFQaD1hVmY7sWvspVNd/qCUap06rhHYb+WsMvr+ZliniyXXfpgaD5S7G3Dj7tyErn31IkUofstAflVz8Mh5tMTsNPf7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: apu2VQ5YQcrVwe4K9/CYpe6zjyUKKTtlayayZLSTpy7Wc7TxR3BietxZZNnXZOwCFwqqYFl1Okxn425CZ58+Q5sTWiBWgufbGwKIlbYais/CEILB6bWvV8he3m7VuhOHM4fXp03MZlR5HohEiuNm77LwkFgf555JQl5+PD+zNMX59t5viggMyIt3ksvuNI/XpTENwOhtagtPFShNYV0RcXn9fxxcJxkaMyGjDvCErlXRsaRfF8sShrzKdcuRaHRwZ0HVRG9/FXUZa+2479f0q0xeVHQ3U3GM6FMku1OmfAfkXSTK9iv7huPSgg6ox0VPciWchWa2Om8Nv/qQYWTiE6/VBo6Inxkm9NeJz0fOU716M0a0c23eOPoRjtsVo9lGF6YF5LOSVSKVuhovzzLeyQj5WyV48QXuJaYcjrwwZ4Ku5NG/9cliFk9WmJdR0Ydl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:47:33.5775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3596529c-af32-447d-839c-08df1d4de71e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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

On Fri, Sep 25, 2026 at 10:50:49AM +0000, Bruce Richardson wrote:
> This documentation should be squashed into the prevous patch adding the
> support. See also one additional comment below.

Done - in v2 the documentation, release note and MAINTAINERS update are
squashed into the AMD driver patch, so the series is now 2 patches.

> > +The AMD NTB hardware exposes two memory windows (BAR23 and BAR45), 16
> > +doorbells and a single shared 16-register scratchpad bank. The scratchpad
> > +bank is split into two disjoint 8-register sets, one owned by each side, so
> > +the driver uses a packed handshake layout that fits within 8 registers.
> > +
>
> The documentation needs an update on the alignment requirements and
> handling - either the need for the new alignment API if one is added as I
> suggested, or else details on how the app needs to handle it itself (which
> is less preferable).

Added. v2 adds the new rte_pmd_ntb_get_mem_align() API (as you
suggested), and the guide now documents the outbound translation window
constraint and instructs applications to reserve each memory window
memzone with the alignment returned by that API, pointing at the
ntb_fwd example as the reference usage.

Thanks,
Raghavendra
