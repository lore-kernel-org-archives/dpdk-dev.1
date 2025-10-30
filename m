Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F62CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 12:40:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6035D4027A;
	Thu, 30 Oct 2025 13:40:36 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by mails.dpdk.org (Postfix) with ESMTP id A01394026F;
 Thu, 30 Oct 2025 13:40:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB8MlaNNoRXOXfhPefC1K+OzTH32vnrmrjxinKW2G0rv4biKn+8cUNf6M3y5slsBCDGMLTfMj0vfqTbbqVXIiauGjCl8r5wYMUKR2UsmJqUoqhfR4eQMstBZLV7aqycKIoZ84Pw5yT88ufhTpccCHdlTswFdG7lVA/Yvkme5uN2+6NJfWz486SMFR8ybS7Vf6iTFbLzGr1V7vWyXaFz2zmvumNaoG+Kd5x/fXaMqSe/rJdTjM9IfooJC4n58N7XIwXGogCP6bOqUisHGKiHw+IFiMumz9P8aCm9bOAdkMq65DnKmqllHJsJErghu9E8m+mTui2F0Qrbuky0juuTEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldMVR6vdt6yHJCWnUMxcatBGa1ISKHYh44Az6syaloo=;
 b=GF1qI9ZBYWlQlDV0hM65xQjvjtVRojw3LOyCuPrbtSaDbVm9SRqHugUh6LvPfEN693K4cxq68xg+i/YtQVVybgpDRDo82nYNle7vKUA3Fy0yaG+Cil9CZxfXMAvWLIGdwEYcGYlK4xp4PYGiQdNr8EtKmi1tlcHn0LSOTanfvYJ29fiYyEmG6fK6aTN1O7qWXEg2KcPlHo4TgA6xD3b3/PmjTZe97F+46maDnKt0nKdP6UX+Bqk7iC/D5R2EXUERC2cDQQZA47LMXWkLzFNy+jB9CWR5bOtVBk4D9NT8lj9pg4pX2nzxTmWzwhX1cFvPB/K4gqFbrXkbn//kUhicsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=syseleven.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldMVR6vdt6yHJCWnUMxcatBGa1ISKHYh44Az6syaloo=;
 b=YW+gqlRHWec6i/kMBvIy1eDOCwgudN7EPwcYB76jtns+C+rL4vuwoeAex2COW+NQ8SpTE0aHabjbLRZepkkoVpYIOfKK1V39dTo+aOlCkUM+7lX5ajVH3MsR/rBQBhB5ULL+5C+zTPjRnde3QeonUVOEPmKc1ZhXvKwSHt0clCd5djae3daALH75kQBXWL0rCZ97y3ZxT2lEmlMFl0Gxx7GOp3OE+RVd95yUYlrN3CtLk1lmH0fY/70xbVvqLG14SyGIQXh7Y+nk0+B/ENpBtQrX+OjWslQa+YVIgB2BR7SpUb3meHTn0wFGMGBqRByz8atBvP/BUICJLtnoCshARA==
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 12:40:30 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::f2) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 12:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 30 Oct 2025 12:40:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 05:40:11 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 05:40:10 -0700
Date: Thu, 30 Oct 2025 13:39:07 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, <dev@dpdk.org>, Michael Rossberg
 <michael.rossberg@tu-ilmenau.de>, Erez Ferber <erezf@nvidia.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: store rxq MTU at allocation time
Message-ID: <20251030123907.pjj53xv7bk7tewqu@ds-vm-debian.local>
References: <20251028100144.36284-1-a.schollmeyer@syseleven.de>
 <20251030091313.55152-1-a.schollmeyer@syseleven.de>
 <20251030102155.m2uk2us7vzgh3k7h@ds-vm-debian.local>
 <20251030104009.cx74wmofh6ljsukv@ds-vm-debian.local>
 <ad4b00f0597538b9a5ac5c8ef59b921bde2791a8.camel@syseleven.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4b00f0597538b9a5ac5c8ef59b921bde2791a8.camel@syseleven.de>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 2144bf4f-af27-4cd6-527a-08de17b1818e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?JVytJh9WRYsM6ectE7YVMtQ5VK1gvpPvGlJfPpb8qhwoKx+i1hKKQnoSOf?=
 =?iso-8859-1?Q?5kHDgLkBfG7E+PwwouN1wB1RbWNszTND2u+4OKua3+qqhuAbcx16hUQhda?=
 =?iso-8859-1?Q?sRA+dGISSAJcI0iyPCHQJqQPRY6WUFGD54qCgMC8exs0yGXEB8MX4SmbnN?=
 =?iso-8859-1?Q?dXNuZj2yUvqV4U7AMFoXkPAyC4Suer31dhWTrBx0BizZSWI0D/2esSxHtA?=
 =?iso-8859-1?Q?ZhK4rvaWWJp/Y4kXer3PyU55mOirDSlgTikprUFWW7K/BbQaiboN1E5Bhs?=
 =?iso-8859-1?Q?Rhmnylv4sJiVO6ho1196cDtD0SCM1QLuRGIUtOCFe6kqPFv/QAv2ptdsbd?=
 =?iso-8859-1?Q?LEFYDnqgqu96SFDaitelHpDqhHV8mF+VypQI95QF6K3A55TqPbmNMifEce?=
 =?iso-8859-1?Q?NRCOX9DDeYvBMpcqqxAKbdb1VrP8JAoad5iEFxVPJBIWi87zvXeB0K2igE?=
 =?iso-8859-1?Q?ta94egO26QvmIW4tMEjxvWIwRubLjSZu/k0VMt6rp3J689efERiax/MZ2k?=
 =?iso-8859-1?Q?Pwd7aAY23t8c1VfOam32IVJH5wFHQhDskw7/ge7RjfRtvrA0ocPy4rqJC6?=
 =?iso-8859-1?Q?FwerBIbOTKY2rkzkeM/VG3n5FLMSzCkadd3nbOdRalv64Th838d8Us4nif?=
 =?iso-8859-1?Q?ogHGHsRhH1Tfolkxib28PVacjpVnpHoccOACoxDWc96y0xKqx6nG8GZG9I?=
 =?iso-8859-1?Q?Fx+bn11RKn9IQ5xMOwU6smyOvRsX4O++cyUF8kQTSCCHdzbeRCEluvQLIa?=
 =?iso-8859-1?Q?5f9682NnuX6vegcjAwt0zRfO1MFSCUnIiTS2P5wmQp/auORSp7kdnJfUlc?=
 =?iso-8859-1?Q?/HCtfc4tOHVsxCm+TtV3+XzudMsa7F//Lu96q6HEO8AQD1rIjjnLeeh6Mf?=
 =?iso-8859-1?Q?eFt7wj0brMwXFP/jmM6Wr0E5ALPNvlvUB5h/sfYv1WOnfAo/TLtvJAxKs6?=
 =?iso-8859-1?Q?eVyAfN6wrUrgFSN7uFDb0k+X1QrL/Dz2iGG6VyZJ0ZfxH2sFaDog4XrqM6?=
 =?iso-8859-1?Q?3KICmRJcPXjzkbeJyBMTqqXNxjSt9XxeM9EPFa/4/hhC8QaodLhT6JFtkr?=
 =?iso-8859-1?Q?AmIEojwX5Nq6OLUvk0jjPY8tAxg6vfcj5cVja1M8Wd538WGQr/5kqhG/9w?=
 =?iso-8859-1?Q?KvnnI+EwRhHhpYkoXIYNSszLLWKNiGDC+fdDQHagMxbzrFELJyu4AcZaEW?=
 =?iso-8859-1?Q?qcCgUhEkKr/XKmKJ0OWLUGQmLkNvR+83ydhIbXNJUAcYRNdv0JF7R8g5o9?=
 =?iso-8859-1?Q?iW9vj8ORLFnd84Je3uW+cWZb69mkEp6XsXIrle6Ca+TY/sjEG/WaaO7/2r?=
 =?iso-8859-1?Q?hejleXL/fDmk6bQtFpbF0wZsHHvGYmjZXpt0niy+LW0Cdn0tfPJbRw6zR9?=
 =?iso-8859-1?Q?1cXCL7F2pJ9FptuLKsIRc8PE6B32DBBOCSsTv76f7upJpz7104+MDcHKda?=
 =?iso-8859-1?Q?0cm04PFviUV3b3ht6mV37drmqi6GhxB+y6KwjbH2bNDML/h6OCyQvWBYEI?=
 =?iso-8859-1?Q?d8tZXsILGqFkaxp1d4CkGZ1S0kYt2oiU0zdnnOkylVB5cGYS0KM2sapMxM?=
 =?iso-8859-1?Q?ylx/CE1a2iaenykKM2kSlT1pJKqgKi6N/8AdCqoZo/2huNdqxN5OHlIr/1?=
 =?iso-8859-1?Q?nj9qvzQjQxyQo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 12:40:28.2162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2144bf4f-af27-4cd6-527a-08de17b1818e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580
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

On Thu, Oct 30, 2025 at 12:21:51PM +0100, Adrian Schollmeyer wrote:
> Hi,
> 
> Am Donnerstag, dem 30.10.2025 um 11:40 +0100 schrieb Dariusz Sosnowski:
> > Could you please change the state of previous versions of this patch
> > to "Superseded" in Patchwork?
> 
> done. I hope everything should be okay now.
> 
> Best regards,
> Adrian
> 
> -- 
> Adrian Schollmeyer
> 
> SysEleven GmbH 
> Boxhagener Straße 80 
> 10245 Berlin 
> 
> T +49 30 / 23 32 012-0
> F +49 30 / 61 67 55 5-0 
> 
> https:// www.syseleven.de 
> https://www.linkedin.com/company/syseleven-gmbh 
> 
> Current system status always at: 
> https://www.syseleven-status.net/ 
> 
> Company headquarters: Berlin 
> Registered court: AG Berlin Charlottenburg, HRB 108571 Berlin 
> Managing directors: Andreas Hermann, Jens Ihlenfeld, Jens Plogsties,
> Andreas Rückriegel

Everything's perfect. Thank you very much and thank you for the contribution.

Best regards,
Dariusz Sosnowski

