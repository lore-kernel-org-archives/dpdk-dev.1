Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25643F53D92
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 20:08:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 357C44025E;
	Mon, 16 Mar 2026 21:08:41 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
 by mails.dpdk.org (Postfix) with ESMTP id C6BF0400D5;
 Mon, 16 Mar 2026 21:08:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S64UfVsRJzSxNhjL9hcYHkZDvBJ+EyOv/LORDC7DWzwiO4hBqrnVCZCzlkTQnUJAL2rSgyNN99JLgw6QB/0AtM/bfg1zgTXCldH/xE7ZLIcIwlBxr3KSjzO18fQxtOL0kHXAEycxpd2WNro1EiHwWxOVmpPg7PN4935aT173UKAP7Gr5I/CTVg2IWFt/IFZZNaC+V0L5qtAabVVj4zxBVQWGT+Vx1kQe3ATJTxConxg2u+/kDesZmuY2yTuRgxKeLN9PKICRCdaE7bKieiBBxqHBcSfVJBflIFv1/Yg7Rv6mGlVRJ+qEstmlQaqtPSoU3HVMO2ccJ+FsdpvJWXqMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mMak2f0EM+EfBnU8xmFEVDjzqcr8wUqGEdqaC0lOOM=;
 b=ey5e+icYR9JnIslPJOpxg6G3BlMZyU2UQ2NWc9MckJ6E+VYpdeP1orL9RIGZXF9oPg6waZjoUCwxzIA17A/UpYSbawgIBoxdAK2mAg6Ool0VIVipU9b0Io9NnBZBwYC5p4dVV6+hr3U2GO1Ij3qs5nuLyDlDSOt/tIfss/0iG2zEQXFYLOjmrSXHBbbcoJxNM5Q8LXKEekcOngASBnK160OmYCPuQGaxLdlUBpIOkeahPBhYRKXvfGPG62uYdeLmFw4pQnIoQHN8xhNYM+Atduc6qzVgYEKWpgNGDtppTa+6J6hLN23W1jEsEc2CyjprLURj5kzvErjPl7VtZdv58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=amd.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mMak2f0EM+EfBnU8xmFEVDjzqcr8wUqGEdqaC0lOOM=;
 b=GoI0t9KqQvzJzZMTUNH1vOR+tk6TmOavIiyOkmqvMnmBSJ2x8vJw9m6nKTopk6hkOqypzeAKbObbmDtbKjHqTGD+HAgIOwOU+OFlM2s6lGxxHhYac+0JcW62QmYpE22cpiLG8pL9Pyc/juar83QGqYv7FJATBkBV287disBPehGnn0EE0jPEnbwEWTuzrEe6+dypiM1Zict55PRLdAKG0VxJwSDmxNCpad6d0h7I9wBt5/l1Yvhu/z6+cUp++O5k92yHLRI7NlFUoVs78dpiRwdokfk/aKnzB/KRFmBH+3y99wY4WAS8WkaQ2LuCUc/xpA9/6sAgcnnCwS0Prfw4FA==
Received: from AM6PR02CA0028.eurprd02.prod.outlook.com (2603:10a6:20b:6e::41)
 by DBBPR07MB7609.eurprd07.prod.outlook.com (2603:10a6:10:1e1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 20:08:36 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:6e:cafe::cc) by AM6PR02CA0028.outlook.office365.com
 (2603:10a6:20b:6e::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.22 via Frontend Transport; Mon,
 16 Mar 2026 20:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 20:08:36 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 16 Mar 2026 21:08:32 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id C5E904020AB9;
 Mon, 16 Mar 2026 21:08:31 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id AFD16604B603; Mon, 16 Mar 2026 21:08:31 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, <dev@dpdk.org>,
 <jgrajcia@cisco.com>, <ferruh.yigit@amd.com>, <stable@dpdk.org>,
 <mattias.ronnblom@ericsson.com>, <heng.wang@ericsson.com>,
 <ravi.kumar.chennaparapu@ericsson.com>
Subject: Re: [PATCH] net/memif: fix descriptor flags corruption in
 multi-segment TX
Date: Mon, 16 Mar 2026 21:08:13 +0100
Message-ID: <20260316200819.3879365-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260316090845.158843db@phoenix.local>
References: <20260303110152.276344-1-sriram.yagnaraman@ericsson.com>
 <20260316090845.158843db@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|DBBPR07MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4609b2-226d-4894-79c2-08de8397cef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8nT0n2qfKkLacKYqJHWnN7GvERRZnHsWFXTL100avPJsxBide7vVoC8ljR/S+UAfg4acPSvBSKEyfe4dzK/rnidzQj52qL7LrSvaZNUrWYYyFbeLHfwUjq39/LW4wCiTyrfUKFrsAHUxqcwdK4ZI7EfthBP7cp8kOY7irUtYdwfFmAMS1mFAq/vVREQd1+r9YrvVx0gXs/TWDbJSihygcu9ujbH7BH9xfazMVkFOzwrm5k+oLlxtLTllyXNAypJEk0jcI6gv9+eK5bDmBgyo8FEkp+Ct6ymTFwrRyS3zYNiPusPh8jk00R4BdFjpw5SqfBPiZMPe1/jVypJbG6Fp3+evJaJ/3uBulMa4m83hRJEFaYhniZRO5dKrJ7yDaTqr7WeCs6W+2aBGxupfPbXIHc17DgNQPf1a9Z/OE0JZs61BwFjGa4p/li8xNMTfngc3z6aLnY5Hq1M4+HSAHltK01VnHoeMb2AtNSFLaify4VqbGtHFBxpp58OqyarOvX7fVydoACnGvkZ0lxNWxkmT13DbWKBzSCYMrupwboEl1AmZx9QZskdf63xJGC1Hz/Z1Fc0xQQoDx7QDYlJcmxd1eur9b06LdTs3tVx0nfpBnns7UsqyXztvsDGeykSmxQmpsc/Q10NJcjm9pm53TyDh8WDCLLT2EeKKLc1aCFpg3HRKnlgFVIIT2i5VDKrsQv/QXNAJIQJlVCNfUh12w72D20PGaFNd68RDjM/MwGvlZDG/auD6vnddxgkFh64F3uIpqLKZnmuYmIVHVXO/Uil7yA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QJnNvMvbPh3o0r1uhXDJBNL06d5ehfJOyLIfl7PGWuSQsF8ry2+D6hzIudCdDUtz/Lx9LzZNhmteHmvfuXwpINpy3thesMg2Vz7dfFfa4vrsqbgvF6ePaQKe+/W8/oQ8vQYTr1GyjPTwLNHK2tURPUM8Fv+kJDF0EXAyJ3V/c0qLBFNNx9xuQ5C8AHhqclqdd+PYIHl5CBBExJ+utgcRcvtHaTz3wu2SHsIpC5WldeFmjNHWgAIOoQH2+Wq2od8VysGWqwOR/UQT93gLx300u6Vvj7t/2Jy8/lmGtQFKgepePqgJunn3pYKIBvAJcuHTG/GhoFPrqEtZsCsDIcNqGo5QBfELy/Q6DSv7OpDBa+qXMu2RUrENYyDfFR2R99NM+6dlan7aAmeXYq+ZBjbjqkqvbXs4gTczIZfQUenrWu8HqT0yjf5GYBvyr8KTGP/Z
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:08:36.8082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4609b2-226d-4894-79c2-08de8397cef5
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7609
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

On Mon, 16 Mar 2026 09:08:45 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Looks good, the AI review spotted one thing.
> 
> Error: Asymmetric mbuf cleanup between the two Rx paths on truncation

Was this meant for the RX patch [1], not this TX patch?

The asymmetry is intentional. The fast path (mbuf_size >= bsize)
pre-allocates MAX_PKT_BURST mbufs via rte_pktmbuf_alloc_bulk() into a
local mbufs[] array, so on truncation we must free the unused portion
with rte_pktmbuf_free_bulk(mbufs + rx_pkts, MAX_PKT_BURST - rx_pkts).

The slow path (mbuf_size < bsize) allocates one mbuf at a time via
rte_pktmbuf_alloc() -- there is no batch array to clean up. Freeing
mbuf_head is sufficient.

[1] https://lore.kernel.org/dpdk-dev/20260316155918.3756017-1-sriram.yagnaraman@ericsson.com/
