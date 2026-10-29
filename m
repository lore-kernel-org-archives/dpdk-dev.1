Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A29606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W6XILcDH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 616624025A;
	Thu, 29 Oct 2026 18:22:01 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 64E7440151;
 Thu, 29 Oct 2026 18:21:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1jXlJF9kNzxwchJpY4t2sVNKnc00QG3smPtcdU0uFGkl7/AAXirp83t9rWQgSRcBG5qMw8D8GKpj0uNDEJdextm2wrum8uTgLfIuEUHA0nByyJiYjJ1zPa8vUMrptB6gMadSOPfULts85Bfrxs/xE/KWRuuMNv8qwsS7viO+eNCX+RjnRemC/w/VzrCtU8uInNbHctjSITU+Um/EWOdtYfrqnL6bIcQhS47UVIEQgSo3TywH0EBQtCO0r5uzUPRrDvuN1ODpJ7f755eEAYF+/Fb47w4z6Gs/PbtAlycqpGBnt3iIoKi03qHEGhgyMplr4cfUGONE8HvJNsxTiurDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2H4iIXVU1gHnCe8whn4Taoi9qRUJ4cmnE2/jzNKTBA=;
 b=bnn0gOM42rKf8vw7eP2lBKTCBqNtJhUgIE6/pusoSCLqoOz+CCh523cqFRdw637BVQqmTkSTgWVBOqXjh6fBFrBCu2eZWeO2pnYUPYZhwn5H7OQYqVe+3EVr+LNIgTy757yEWSyYPdgI60gerYKkonYkXywXreFVIoMiD/SvvAChlguNW3tBKGw+BM2/V2+aWAcJGcsqzYB+KtppzeOJh8xBdn4BFQqB9/3Y1oD1dBnSC+GnXdmg1Xn4645nabs+op86MoVUdzS9UWmNjQ7+yzCyyuzQsiOhtfr96Ug7YKEZiSXEFNtSrTdr9wHH8Sl/6yT1EH+te1mbDxb1ao0YEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2H4iIXVU1gHnCe8whn4Taoi9qRUJ4cmnE2/jzNKTBA=;
 b=W6XILcDH7NztlAgr8lPkFvYYRfzpaJJO3mkN+QJ64FQY/UDdu4D0ayovHrG1zC94iu3LlgtDOlC19BM3Dde2LIFzsRsdf5jYj2jUE/3QEV8e17xkdLOtoqlASm77xqL9HmGQTpfCcedcsQNek0brxq1OzAzYtH3RY8KLoZ1PECMcCyKwA0mdrquh5reN4kLa8Je4l3jewS06yjOMj/C7jwgMCDhkRX+Q5mvcXleWmxYfu7l5aJ5GiOUpvNq2JBYU7P/bLO/L04BMaMYx4yMaQ42K3DrFRfP6LNuLEbvkqW2ekdk/XNylTiNJuX3bGyhzSMEkkagBX4+ru75cAmikxQ==
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 LV0PR12MB392693.namprd12.prod.outlook.com (2603:10b6:408:608::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 17:21:53 +0000
Received: from DS1PEPF00053451.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::54) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Thu, 29
 Oct 2026 17:21:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00053451.mail.protection.outlook.com (10.167.23.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 17:21:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 10:21:34 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 10:21:33 -0700
Date: Thu, 29 Oct 2026 18:21:31 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 <dev@dpdk.org>, <stable@dpdk.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] net/mlx5: move to polling for LSC interrupts
Message-ID: <6rve5jfgmdl522b27mgbliiwcjerijolqqz7laga2rh5hdqjpr@llaptwm6uhvg>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
 <20261026100336.15d7ae6b@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261026100336.15d7ae6b@phoenix.local>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053451:EE_|LV0PR12MB392693:EE_
X-MS-Office365-Filtering-Correlation-Id: b12e9c20-d392-47df-4fbe-08df35e12044
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|4143699003|11063799006|56012099006|10067099003|261021121427099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: NGDgSk0amO/iipJmJfdgftg7albnBqFl/lN55K/hRBBcX5oszoUdTJR8YvkLApeNNhFCXJAayGkNs5b0abfPt7whx0fiHQNP316mmHfKIStibIJ0lJuZ6wl8L0gehmRaunpJKrPkI8ahoz4Yz5Vqb25GVu9eO0AnE5ha4O6e0+N8ari+Vlm6KE407KMeHI1EgV5CHhVlBGtKiOkgwB/Co9SiOMCVo0514flfLJ3ytKQ6WsaKqneaFvHMib9OFXJG8P9WAX8G/Ed0YjOziuoZnte0Of4YcW0uibonEI3TkPrK3Ab8RrK/jtLQpYsJDEwvyAOframxPHzT0j21uDyFfcGjqhBI3p850ro4Ec8hruNegP5ATCLCS2Tj2/13LHYXNTcuF+0sFTUZkaNlW+/srn7JIefcNEe0T/gGtQbPRb8TDkmPH1keaQC2cDPLoIUwsafDSEUbUClTrR2EKFTgWG9wwy1xiHlyyqHrjJCJw2XCXBzlbpFcI769d3K9hJUr/63H9ZkL2IKIGzuvmb1a0fNNu+4NxJjwYjo2FkUycGZaB0r/6MBeUOTbrqaab0IRGrPObnyCgHLdrPn57PlDEoS4BhyOIpjYUAgXKD8bfpxsk7XZ4MjPEdtc9IUmVYwGpjX22y1Hasl6CRxzZQUKWDi7bxWxylLThuowUvamuHWPQQLLQU41T2apr43VMD67Y3vA7WE8eBpnTkxJg2z/Xg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(4143699003)(11063799006)(56012099006)(10067099003)(261021121427099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNehVJTA/7kHMEPIodlRjaxGtvQ/TLFKL74LsU32vpbqfQdyggJsoFy0XkeCbEa4EyOYNQ3YV+olfbaGp/gxv0S+YQMCGcByq0Iw3FUcgstTYRt7RrDBUqFM9t4WhoAMnzXLz+05SiDM45NVH4q92PgzglUaOMCIfAoskdKEVVvEyY0inp6kU9Xe98egN9oHLi4SSE+Aw4EC4Rl8Ic1KPypg80ZAkHJBY7U4+JiouN2b3c8gyodVrR3EjbQyhwi7OqIqS4i9lVwSTHf3LAvlAgJFaksK542DQqWbNOy6CkGrftwuoefpK+cV9bnkUWSSPE4T/u39LJns034JUhTTBgOJ0sLpoNcRAvN7c1spjf4f6xET/Q1+onrC8kW4aVP+66gG7hfbzvMsO5SuyDqQxBAoxwXBPJsBVtfZUEn0lZgIKOSbtuo495Yf3iazYWeu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 17:21:53.3389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12e9c20-d392-47df-4fbe-08df35e12044
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053451.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB392693
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 10:03:36AM -0700, Stephen Hemminger wrote:
> On Mon, 26 Oct 2026 17:04:00 +0100
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> 
> > +/**
> > + * Retrieve the carrier state of a device.
> > + *
> > + * The IFF_RUNNING flag reported by SIOCGIFFLAGS reflects the RFC 2863
> > + * operational state, which the kernel only refreshes from its link watch
> > + * work queue and which may therefore lag the actual carrier by up to a
> > + * second. ETHTOOL_GLINK reports the carrier directly, and additionally
> > + * flushes any link watch event still pending for the device.
> > + *
> > + * @param dev
> > + *   Pointer to Ethernet device structure.
> > + *
> > + * @return
> > + *   1 if the carrier is up, 0 otherwise.
> > + *   Negative errno value is returned on error.
> > + */
> > +int
> > +mlx5_link_carrier_get(struct rte_eth_dev *dev)
> > +{
> > +	struct ethtool_value ecmd = {
> > +		.cmd = ETHTOOL_GLINK,
> > +	};
> > +	struct ifreq ifr;
> > +	int ret;
> > +
> > +	memset(&ifr, 0, sizeof(ifr));
> 
> Odd, why not use structure initialization for both?

Agreed, odd. I'll unify in v2
