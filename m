Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4CCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:51:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 228CD4279B;
	Tue, 29 Sep 2026 14:51:47 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3752B42796
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:51:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiLLVB5LWttU3raIR6KCatVTByDR5aXIXXzrMYaUzJbGodFupCFTK+7DI8r0jYNwCGh15V7hNji80SYSYlS486J3kg9BQJVCLDVYqf4fG2QFxnkT8yG21mPLnPXyZeEKbaQ5Ikm+AIYLoUGW8PZvJ/a4us++mf0/AYyRPmk34smeu6Kvqpw6C8S69EC4MifRnytN52ljQecjFTA3ad4LY68dyJTcY2DFyZOvET8NpVND8z5cpFPQThUiSuLh+0M4l52M52U8lEM5hHDiFcKIpIhCzZqbiPkWpGUdSB9p433lgnoNVpeQZhnyoGHj1Ab/b9YDjWTxrJ7iajEVDQYS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdoHobEDCmOKMe5nF1WFdqXBcapqRA9S2EdVAd47G3g=;
 b=ocIqsHFCu+jCRrvLLYGczOErd0d69nvVOXz/7gKHTwRZ3lLJqjT3XFVbBZ74sgW1+1/tiLfqEjI3nWDxGAkta7uzTR19eKBTY2eOeHd6r7ovNwAVEQZi3K3zfJ+Aq30BfC7AuO2zh1XIhH0YJIna+1disBG0HlxXEZ1/3g8Jc1cbcCK3wrpKuEbUqnJLkZB1EtFLJIy1Lan9dggpoYAMvM1KQJMZjUSRGhaKrBAfSkokeNFz0KRpesqpdFq9RyPFW1RgtPBmQ8TVWXd17DaawEJy4Xn+XIpEABR+PcxdpxCvT5lup0oCJxQ67bN/C2bkRv5Rpk9LkCUkTtm3FYI19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdoHobEDCmOKMe5nF1WFdqXBcapqRA9S2EdVAd47G3g=;
 b=SfkSf/IReXqSCkyjTMhZ+ouuhfexUwBitPR2gJH/iqfdjV+XJpqd6qDafwPdbDg2BGnA/3KqT/zn9vSM3iWYt/AJy9h6Z5/UVsctyVSK2O1nxk9fqddvM2o51vh7Rx5Qkxua+uXDKpv4QzKamcKzyyjqICGXyyjBV8dEjPg81XJYMB02lQfGY+pogXf6MJ9FR5y5jVThiU/9zYTE7Lu47RCAXcI/2s/3ehbceHVAoKnNsJWJYpPBuSwsAz8VQeJcbiD5uXzb6RWQdfnZ16QQa1qoZNMw+bl/9XZPtDSGr2iLLSuTSrgoCJdXa4nVH05yNkdnbjKetlwAWPpzZnM5pA==
Received: from PH1PEPF00013301.namprd07.prod.outlook.com (2603:10b6:518:1::f)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 12:51:34 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2a01:111:f403:c902::c) by PH1PEPF00013301.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Tue, 29
 Sep 2026 12:51:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 12:51:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:16 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:13 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v9 3/5] net/mlx5: pass maximum number of unicast MAC to
 common code
Date: Tue, 29 Sep 2026 15:50:51 +0300
Message-ID: <20260929125054.85048-2-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924063836.355745-3-david.marchand@redhat.com>
References: <20260924063836.355745-3-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 435bbb72-0fb1-40f3-bfc6-08df1e28647c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nOhCo8Qto4c8LJFVUutGKVDc8kpj+ahwURFJaiqOZM/xPO7fBezzeYJ1Qu3zQoummUOtqaZP3T7mAbpN0aXlub7vAiJaPfurrxtLpJAaAzkZXQty3MnvNQlx3ynRIDfCReVwLG5LosMmGSDxvFDuoLbp6UkZ4AwH5jQdZE99CYvQ2V3jk8Nwr1AGfKHScHpmUE3wpL8ndKnzcUsrzC80GKFEUdS29sAp6ZKKmPwnyvMIAVuw4XCn9aDjFFYwuHXVk+GpCbQowAePlSrNZOiDd0eiACLsyICBT+I53Th/gCsgi/lhrYuzDWr3D8+0t8w431Shqpzn0EEynN4yJa6ZT35jYKrxDCNT8ZkK5ztPfk7THFdyK6NV6+4o55fKvzABtvpkbKlv8SQDgeWict+CrtMMBpnx2W3vVxPEGZ/CHFq6u/MxaD6C95KEVfKT50kn9uHMqj77u7julMx0UcD9ryhvef7GiB2DUacHKACB4osxW07H084zEhYrzFyIDiBe2HtoqXu7QERFCka1JaFqGui+DmGfLOnpXxdCtBTSZLjcnYEtL4nUZHHMOuoSpfWelrHIlWr/dAL3R01m/FFEV3wXALsiujyKE+k/7cIwpCnkeocyP4u/+XKJuBt1U6YHvnzhYmJQGTmJsbmxgft1wRoPIrniCsC1+7KwjWJhpko1l4gE1o5pYkB3EWt80C0XSaak8tETzf/VPIsjZIuv6A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SgemdO7i4TSswze2ynq3YqPCiY00xgSb/BzzPMLvJD/bPg7wn6Yi0GzlRkVTgSAVba8bfSS2Wt0PKzxS/u77kMN28vLNy10MxLDKFeZtcnJJYt4r2Jo4vXXcMvPm+Frb8e674TGl1YUdoxTg4kxnMV0/wjRc8Ys2+iOvnj0CpAKLP+Xsg8aowshdXMwnfaPYIQYAPIPjNzEgtSfEIGlSzQrpaAFZlxApxcTJQYx+3ELC3z0oAXV4db5s/5h7655dtlrShvskrmaLWZXUkuKYzVNHDP53uBNZJwho3EW6tsRtXoLYTDd15UKzkDjIIR6CRL4HyTKPo8uYNZCtKXeXruwUBr0hamU/tLSV9tCUWFazzciVJPA17q1zK1GkwIs5MaQJaDln/OUSCiQ+73oC05cM97Li9Yx8Gi+KZEAP5cQt75oow6JpCJRvAu8r87gb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:51:34.1028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435bbb72-0fb1-40f3-bfc6-08df1e28647c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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

Acked-by: Raslan Darawsheh <rasland@nvidia.com>
