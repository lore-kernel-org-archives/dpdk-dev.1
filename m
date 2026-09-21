Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15905C982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 06:14:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC87C40289;
	Mon, 21 Sep 2026 08:14:18 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14]) by mails.dpdk.org (Postfix) with ESMTP id 03E7E40268
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:14:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlONsHWreVOf4/D1ue/9YfqwUTbDTpBdVY3XXxSWjHiwH34hAIxsYeksd3dYPagDs8QUIuSnF1gpk+PrAAExirSBcX5VtqfPML4pZVaVLi0TwyWC0uiere4/YXGfdoiLAI9vosQ7oTshu1JSsebVd9vLeNnrvAw2NxIAh2gBjSpN0XXT3oJTN1cTjWm2wQRvn/K91kmclsQ9Amh11PHwb3LB2R/pQznnetxZS+MfIw83q7wMcRWMKcR8MY/mQGuPuWfwnTfnXnPvLTJ4YugXAuo6r8DSSz/WzQFrovQ291ovPO+H7Iz1K3FhjLs6WlvuMg5sxNKyKreWYdu4Vr9dCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpKna38pFIqT23zfR5LZ441yussSJiWvjLkQk7e9nfo=;
 b=ImWAcNw38ho6mrGaBe7DDnNbVWoKtoDVG/Fx8KlxkGlC2IQkauY8FNQgHz2hSr+JPMctRDucCy5LNIXkoCpGB0efeBNxUwx+islTN9wNoNO2G/NY0XyovGgGcy5KOVdY7ygpfeWs32zAX5YKRIsogxf27RQ7NxPHnkMScAPt2SJ/dHw7vkueWpI1eIDZKBuTDbzNGqVarHNqbAlKFulMRS1M/+rrgT2JREshrFMzIgv3M1Nl6Wz/SNa243ycKi35f3g/uykRkeMgBtdyHLN0UnSMziir8xIgasgWsMdd75MxwhWtfqcxJD554TU5C1jhQGMlakzMjRJ7FeNYnVDknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpKna38pFIqT23zfR5LZ441yussSJiWvjLkQk7e9nfo=;
 b=I7FcHlJIH4QrtilzBuJu/rsenZY5jp1XfYZie3KWHcJZW+t4eLE7PXzygdrt9rQa5WXl+heuPMNJA0wUgLbff8YVNhJhp1QxYcdvf61Eftt2e0d6tuDxLNrj1TUMOT9IXPw+XyVFrwka/7FF/XZ2fMbUu5NJBP1eric211vB0TA=
Received: from BN9PR03CA0098.namprd03.prod.outlook.com (2603:10b6:408:fd::13)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 06:14:10 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:fd:cafe::a1) by BN9PR03CA0098.outlook.office365.com
 (2603:10b6:408:fd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Mon,
 21 Sep 2026 06:14:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 06:14:09 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:14:06 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Jingjing Wu <jingjing.wu@intel.com>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>, "Sachin
 Saxena" <sachin.saxena@oss.nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v1 1/3] raw/ntb: generalize framework for multiple vendors
Date: Mon, 21 Sep 2026 11:43:46 +0530
Message-ID: <20260921061346.1889320-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aq1Tie4YuRtESo30@bricha3-mobl1.ger.corp.intel.com>
References: <aq1Tie4YuRtESo30@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: c868aa51-0a08-4e82-6ab6-08df17a78ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|11063799006|3023799007|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hXgoBBM7qG3FpVq8rWKhv+LNO7hVWwfdbs2qKUgsM6p5iRotvZxPFkBWKoEw2oIRy2FKvfSdb5kfyiWTP2242PkyU2cSVD5NvlGCHjNY9EfTXLadNdsawRunnyhSYKC3kYFzwg9DmrCzJbBZcj6g1bQDlOZ5wFwJzH0i5uugSQ8VIibMx8b4OFE5Om3ECQLAOG+79CTk20RkzhW8cHBm+zsxe13l3U3nTnTVwkUcew6zozYCRwugIm+AKg5ZRQbBMlymXZFStjn0fjMAT02G1VeN1IxdhX5KPuqX+ZAgAkXMS76071kPwPg3uKSb5QBALAjbI62P8vpOlUKrBLRmsy0DIXF2NgUA0C/h5Ro8SPZbhlWJR+vjvrejtlNGOJ5YDElc6YPB8jGJUnpg8rftW4vekq4zmEo6OpoSgRRigs/xN/bwyLdKJCHp2iW5PUilqtV3XxWPQuVFiRfiCcCODrtoP54mxnILurKPt/6TVzYjKAdAs670rLCQfgaAkDq9pCzDEl5tzlGTtnUO9cUMcwG2M+cHELjH7Idx3OWmUNdEG5Jtjx31JJ+5iZV3bsxhf5+TlWw7jupl8CduIbq2VCBOb9LROgIQfvj40BAz2uS8kE1MPOC81cDBuL5i7+J7u/EXYXVgDFzYw+2m5Mgz85VHfDTHP2RpW/XT1Z4FNmX2gsO9uO1OrQEZVWE/02/sqsVO2zS1gPYIemglXmoMTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(3023799007)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8BG4pgiAiM4W+USxyFx6IlNvvdowwVH/Fhs01kiml/lFA8vrs9ITfxI+OKm+id6/9UhA4umwh7XsZQmedpPFW9xrJWaWQtipSedLdiEUD7dhtNnOTAzdusBcsARDO963V1un5Cb1adMyWuzSEHrmeyW9yaL/iG0RwpbYsOxBHPMYQ2qzESVYEUyEUqT7FpbvOGQAnUlQpNoM6371DxraRfNJ+eWJJgXM0wusj55olRylXSO3wVIaG1WjAvIs66WgvhT/746El0SkTn3Oam+6fy1YKzS7exmRvtCZxupwPwfTTc2/r273oWd7EstngEqcWNTYRjLXrsls+sWKowrCIlxqcY+PzZ8M7+W0LbaTe+kJ4oe9Tz1Pk1QHviN72CzU7frpJbKTNHmqzmGhbShbRFjTIwDM3ewLw6T8ibrpnhs0ZFLQAAMsSHE6T11kp3US
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 06:14:09.5902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c868aa51-0a08-4e82-6ab6-08df17a78ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
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

On Thu, Sep 18, 2026 at 03:06:49PM +0000, Bruce Richardson wrote:
> > +	void (*interrupt_handler)(void *param);
> > +	/* Optional vendor-specific handshake. If NULL, the built-in
> > +	 * scratchpad handshake is used. Used by hardware (e.g. AMD) whose
> > +	 * scratchpad layout differs from the built-in protocol.
> > +	 */
> > +	int (*dev_handshake)(const struct rte_rawdev *dev);
> > +	/* Optional vendor-specific peer-config read at device start. If NULL,
> > +	 * the built-in scratchpad reads are used.
> > +	 */
> > +	int (*read_peer_config)(const struct rte_rawdev *dev);
> >  };
>
> For these new op fields, do you foresee cases where other drivers might use
> the "default" functions as you have now? Might it be better to simplify
> things and always use driver-supplied ops, converting the existing
> functions into intel-specific ops, rather than making them fallback
> functions?

Thanks Bruce, that makes sense - I agree the uniform "always call the op"
style is cleaner than the NULL-fallback branches.

But the built-in handshake (ntb_handshake_work) and the peer-config read 
in ntb_dev_start  implement the  scratchpad  protocol considering Intel-specific scratchpad layout
 -  vendor with similar  intel scratchpad layout could reuse them . AMD is the exception because
it has only 8 usable scratchpad registers per side and needs its own
packed layout. - Future vendors with similar  AMD scratchpad layout would reuse them.

If you think still it's essentially necessary  will take up in next iteration/v2:
Rather than hiding them as fallbacks, keep them as named, 
reusable default ops and wire them into the Intel driver explicitly:

  - export ntb_handshake_work and set .dev_handshake in intel_ntb_ops;
  - factor the inline peer-config read in ntb_dev_start() into
    ntb_spad_read_peer_config() and set .read_peer_config for Intel;
  - set .interrupt_handler = ntb_dev_intr_handler for Intel;
  - drop the "if (op != NULL) ... else ..." branches so the common code
    always calls the op.

That removes the implicit fallbacks you are flagging while still letting any
future standard-scratchpad vendor opt into the generic implementations.


Thanks,
Raghavendra
