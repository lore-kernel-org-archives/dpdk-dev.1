Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EFECDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 569794029D;
	Tue, 23 Jun 2026 17:27:50 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by mails.dpdk.org (Postfix) with ESMTP id 7FE7240150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 17:27:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcGX6YE6/6aMVYq22Pevf1yAL02bf0i/BCCwAIBNuoc7Cv502/hamQOpktT/bDBDtt5jFe5swvSwfnglwxtnxOvulNVtT5/hrggTke4WYW1hg6N75UQqOQeEe021S82AIe+SrRaiYvijoLtX3ze+zXWjqSXdk4ysSdj3sjJkSVXdL6ZzJuADc0PY/8qAx3C3Mvub0PP5GrQKZgnHFYSHPXjwVp6N0z2i4VOUq+N6Y85vWGb4s6oOelmsc0bT/YAuTLn99HVcLL2xvnW8W0m+KqbcttwHKMpa+VlpmYgeRRRd/q+FjrxPesOVuKiImquuitnOOtdrxZalq0BU0mDiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6EPCrjgMVrZ89x2xrd5IgRa9ULRcEEijJNBjXxURCM=;
 b=qWBkLEUf5STlqD6TNAaWyLnJqa+Bi4jUXU60juGIamFZOq3AOFnP65cjT9RZCPFUV95smBH3q9Q1uL8iMPO4o+3pZdjeKcPIHgSkwyRBvUye02JfYdyPSlo/RVUL5FnZEFbCqBcBqW/eCX94BZDMXd/SVG+KPwBhfpzoZ8NbzUSUwHAmedmCo+oFxJPY46AymzOcVXYv1FfbTjw7HbVdGosoWh72lsXIQTx/QAi81iRlx09IB9DJlgJSzUlwduYl+WYmIPbkUiQ/i9UAVj3R8Z7zIv1Fp7ejhlRn6i0WTUnfen97665ALX8XBsCflRs0+jc4jDNYav+ZomfIIOs/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6EPCrjgMVrZ89x2xrd5IgRa9ULRcEEijJNBjXxURCM=;
 b=Qtq1XbSw1sjm4e6K8e0mfPOQdsp9h5irxZCqvVWGtnWe3qF0RUFOOHiemctZR+mNXz9uIKz22DEJGcg5daH2JS5IFGlcB9mf30FR5YuLJBw4OfEq2AEvy9+7R/wMJX731EiolrcU++O7zz0/2WQWp6fstbCjKpmxohlf5dF8j6PGt8ugOSEjBIKRy4vtV/FBWT6qrllEloxgQAtdpvaxrI9wlHGXcE+V4UD5mZJawdtTN5eSS8y5pS/Z6hu4/95hOKBHMIGyLMgABs25BOUhYSu4kAxMeT59VaKrd6o64d7U5RX8wW44/EmKSkFlpUNG8tTGzlN8XmOsHRTr8YFN0Q==
Received: from PH8P221CA0049.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::6)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 15:27:43 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:510:346:cafe::8) by PH8P221CA0049.outlook.office365.com
 (2603:10b6:510:346::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 15:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 15:27:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 08:26:43 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 08:26:42 -0700
Date: Tue, 23 Jun 2026 17:26:22 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/5] eal: fix macro for versioned experimental symbol
Message-ID: <rg475uc6ktrpsqfu32jmcfhluqlopy43kiwsonogud2z4aul7r@qwibo7j5yfk6>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260623113752.1100072-2-dsosnowski@nvidia.com>
 <20260623065000.57d775c9@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623065000.57d775c9@phoenix.local>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: b64fdd94-c3c7-4808-0c96-08ded13bf852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: dW05oS+CUIsLmL+IyYpbTZF3Jda3aXmsyZnlNfSrBsn+U97uTk0DSYcp398zWANdZ0OZ95gpewTZNyTE+BQcZQsXz426SQLlzyZ3ewyJLBCdcfIiySWpR+Mx5wVQXQpgTcJuuQRIKMIAziE9Et+qd6QuXpuUGA8x5v191UsJIhjZd6qAMydcHIUNwvRO7pAsZB9brXUtlaLYPAu5c2SToqSdjBZlWSQealZ2RK1rMo3YbgkoqpKeEXRpQr+5R7UimIEfeHynjjy2vxr9t4W6VgHDJv1RFxIqjxdJi+4ZgqKdRD6JnLlaCCKuuI7VzXOW4jssHyZSOoB74axOYXiy+iMxqKZ1y6Rr7EPUGM2SfQ+D6RNEXQ0IO6bBXc3D6UmFr4XvLukfL5YVBsDy6q0XGkSf65/iiVC+SF7ekhf5KnMXHa5Tm8R9h8UM7sv0UEb27rljl3TIgqx7eyw71RpMZwJdPcnhiXo3Eqe9adFYtGTfMlKXD4HlRDUoyUz50nxwrjvVlqTjoPEEELwKVydeN7OLoP4riSc8Sl1erRr2o+YAGCtCM8+h+YV+QtGTbTFYXb9NmA5+IqwJN+IxykGdql4uAP9IFESO/ts+ZjVK6N2MT54RdVWMX+uiliw4wNQH5KL27xeh+aXM2z0A4eK4342YMlHJxfQ0fQe1LiVks9azdqlkhMU6TmnHW/YHlypa5PCPeWVruMgMbi4OdC5bUA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5TTu2ZLFzU+OVOj+d6x1ChYtBdIY9gkS91Q/T2ORC14qACTR96mGgz9UyfS6WMkW1OCKe4Qpc5yJ5ataOfXbQXLLNqsn6NnP5Z1mYDYKDnRUUjO9qvfrIi9NyLUSx4IYSH4xWUMY7FNPEJJ/yT4Z9PH0BOYLKUPe8HDP9/nZUfyyyzub1RErAhnS34k8e5Mn0MVUfhWhVIrAwLEuv5toEm73dGKthpUW8blQZ78VZfFd9EAN8aT9DD+IZRLQ2k/x432FPdrwoBeN7FCFkPHiYZm8G7qI2vuE4qiwqdm/M8C2GjNI+E6YjAS55DcmOT45pZxio+iVKZtjhAAq9oCEgg6k36aJap5ojYp5b6eUHzaWcphH++NuFD8BOOSlDIF0c8Su/CARt24ZpGZmInmS5TMxeV+daeQhCTk+hzeV0FkCe7ZXROLTbjCQTc/8/rer
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 15:27:43.1089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b64fdd94-c3c7-4808-0c96-08ded13bf852
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

On Tue, Jun 23, 2026 at 06:50:00AM -0700, Stephen Hemminger wrote:
> On Tue, 23 Jun 2026 13:37:47 +0200
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> 
> > Add a missing semicolon after __asm__ block in
> > RTE_VERSION_EXPERIMENTAL_SYMBOL macro.
> > It's lack triggers the following compilation error with clang:
> > 
> >     ../lib/ethdev/rte_flow.c:320:1: error: expected ';' after top-level asm block
> >       320 | RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_flow_dynf_metadata_register, (void))
> >           | ^
> >     ../lib/eal/common/eal_export.h:75:74: note: expanded from macro 'RTE_VERSION_EXPERIMENTAL_SYMBOL'
> >        75 | __asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
> >           |                                                                          ^
> >     ../lib/eal/include/rte_common.h:237:20: note: expanded from macro '\
> >     __rte_used'
> >       237 | #define __rte_used __attribute__((used))
> >           |                    ^
> > 
> > Fixes: e30e194c4d06 ("eal: rework function versioning macros")
> > Cc: david.marchand@redhat.com
> > 
> > Signed-
> 
> I didn't see this because clang doesn't have symver support.
> Which version of clang is this?

clang 19 available on Debian 13:

  $ clang --version
  Debian clang version 19.1.7 (3+b1)
  Target: x86_64-pc-linux-gnu
  Thread model: posix
  InstalledDir: /usr/lib/llvm-19/bin
