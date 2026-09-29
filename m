Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC948CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:51:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1510A402F2;
	Tue, 29 Sep 2026 14:51:38 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by mails.dpdk.org (Postfix) with ESMTP id DE7C84013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:51:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZUzlsGIw2JUHv+fTOyUk8jp21nK19xVTGsdl1CV1WKbZq0gZx7r/LjlHZKjPPK8caH89aZ/kAzkC3IwWlhEfPKnGA7Uz0Vf9AuRxlNRBwUtsYtuRp7jWJlRv4B5TgVxLegGBvRj7tkf5lKM0SgwvJaGJr94T5J2qYsLONp0UrqTnB4+Qzlq389JiQvIWS8h/gGH5u77/0CB1xz6r9ylZmOiKNjLkLfrOCqqMml/ZZnX0HVNlH/ppuSjHHDPbejdP2vF9bDM1eLFzaXEbHP3sQfLg1JwPGMRgIDqnfdJ8fTysczrVCP37ERYkxPwSIhwEPgNDlTdG5+gRYAQ5rE2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdoHobEDCmOKMe5nF1WFdqXBcapqRA9S2EdVAd47G3g=;
 b=tEktsiRAmsDZ1vY9gmouOfBTgf2pUq+yOiqmMqWuHSSmnIJVawrPWWpF6p2p8wR29nPtha5R4UkFVQf3IplLSyvWKwxst/8/IDxN+ECVVMrdSDd1VXWAACpfFxDtprzg0Gpje/wEqnaZFuOICIMKHplc7++vg7c3apXlkEnR9fBekukARvQy280mWeTqpYa75A6Q/KlRuf9OkhULU7KCgHO1lKX/wcIn53eaav4bcRN8uDfEaDfBAGNSIM1Vr03TlCRteEqP3NeCmbltEDHH6msodEqaWWxKfANrYe/MbUKNjAE7VpxhPpew48xNDR7UyOZBBNpzIZ9bt0scwuUMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdoHobEDCmOKMe5nF1WFdqXBcapqRA9S2EdVAd47G3g=;
 b=kWwYtQF1s20nciQ+NwiHBXo5gsOsxbD8y7NS9nCF6Ytmpgt+cnayhCsjwgVWIoPrqURCKKphCt7nIbVOgiq3NZAGTXDaWLZtw9vpeVPGdm9A7/sw0irIx1wxJdS9x4QDPtipCEUttQeum/Ir9zLzUst2F8ciYrLqqAO6XC6/ZLH55QP/Nws/bvFw67KhEObUUO+kyQy5YC+rdwyGoEHR+WKR+D0eAPLzOsAlKbWilGjBfPt22c/SaAQEFD5vugd0oqZaH5Pdoe+SubiNefrZKlzn0EeRwV43j24rJ2wqATMDTIZaOpKDpwje0FuJx/wFBnB8p8S09ERV6o0d6CydFw==
Received: from PH1PEPF00013304.namprd07.prod.outlook.com (2603:10b6:518:1::16)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:51:30 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2a01:111:f403:c902::c) by PH1PEPF00013304.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Tue, 29
 Sep 2026 12:51:30 +0000
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
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 12:51:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:14 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:11 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v9 2/5] net/mlx5: remove redundant MAC address index checks
Date: Tue, 29 Sep 2026 15:50:50 +0300
Message-ID: <20260929125054.85048-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924063836.355745-2-david.marchand@redhat.com>
References: <20260924063836.355745-2-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce5c827-ca8d-45ba-447f-08df1e28622a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fhXwdSGKRTblzsCDKHPdTApDqfR0H3bkNLoF1ERWqB9f/3uHBc7g0JO41oJyrOr0y43/ojiCL7+04UPPy5WmhWmPPUsfCVpGkESIzSPDKr31b6CQX6OAcR//dw+94spA6TiSUwJTyY92JzzPNUzvJBM0Y2PoYLduRPcxsbVJf9HMcb+dWFIOghC1r9WZDn0DqAdT7DCIu22Ab07Rqq9RpEX3oWhnXLiIncZiBheGGObAvoiXLJlS5wAzoeaDejwGNd4BZg0e5FAhxqbvr3mN1uCbO1sBti6IUm5PUZaf/YZEGQYBTJ48+q7jPyAVYczapGgcocJVb1Y+gzhIwy2qMOqKlqlUaWJH5ABm4boYldRjwju05RdfhjcTsQfxohTKvIjXOau4uxdsW8PEy7b7YKjF/b+ply+m+e4L0ferK60erIMPSs2foG/WC8cbcw/Klppf9e16R6E3zRO9G1f4JMKgZXnBzFfI2awn/87wa+X0b1PrJXON17Uf6U0XuqOrQCsn4/AFXiZGAcUFZ32/reyyBnLFvfMAjVoZ9nzxOgyt/m/OaZRlIYJBgoAxPcGZtUsnqe4xZk7nCSIi+CWoFyy3V3yY4ol6WAJywYEKn1un4GEn3TJlzzMTceVADC6JNYfAOnT0gIeUZL4ffaifaVh76F4fp4tassOt7gEpJ0VHN9LXkNrbLHBXtKUnFdmNPqiTYn0BIPGgqjbXFeCsJw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sNqQu/bGC6s2zBohJkhr99sJR1FL4NH8KXSneXiaqdDW1JXRNv/PTFTK3zleV7ncMQlvvwqHYgvu0CZJyNDekBVaudAZTq5+OrEyc86aTzoLuptdKfYxlNCjTosrw44RcME6fTK3dy0irlefxkXZec+LPyr/uJuFAyQATCRpvXzYGVE5r4rybW4ny02KO7rh8p0rhVHdfWPa6+pyUU1D8oprAfL0sJoGKbLV0we4Xc2Ox/lY0oHcydt24GZ+TMK/kRgubsEfJyvuIfyZ4QB3OluZzijMQaOIVa5qE3I+f+x5KuVmESQLB8RmBnCVSAk9kWTdAzFPSvck8n5iB5OWIKfeQDixqJyz1oIesCCcmKjQeoeGogDI4IJ744VOmeMYJrqvqcemRUySUhQFIzl0JlSCxpNTBM7pRCflfjSeQ37ZwSLd3BnO8ZkbqZ327l1k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:51:30.2115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce5c827-ca8d-45ba-447f-08df1e28622a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
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
