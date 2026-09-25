Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C0C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 09:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7D8240BA6;
	Fri, 25 Sep 2026 11:18:05 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56]) by mails.dpdk.org (Postfix) with ESMTP id 208AC40B9F
 for <dev@dpdk.org>; Fri, 25 Sep 2026 11:18:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afiYkYPYqAEgUoPqE2J29KcKzTmq2BEtUE4bFuPr348N4pD3ntMhlxP+FGy5gQHmkc1gAkvzpm8hb6KweP8+6RUyvH8AROPBDbRnUy9hxvDXCt7Eda0dvmrYQTrkPYgBNTGFl8oFNO7zvdQSBOhV1/Y4Be+Dxx3bhe19t8M4zE2PY2rKYcEC3DJLtN7peGp+cUTq++S0XVd9D1GZpK7511j43L2c7iiwBYhWlHRmFsrGwkcGs6jOnvwldJQpi2Q7aQWBfypLtfnj1Ie/V7wGsgqthYlWidiMRuZoUxckw88lxNu0sOUyOCPlRW2zZ2iA6guEyW84vY0qwV4GCJUgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MPTRgHfqgK2r/yrBCIIUnqwFqHIwS56PbaoZy6vGF4=;
 b=ZJPaWoZHbg+A7TWVqWU4iFFTxd4CU43u6MjfWi/iA3s07o36+QVmT6XKgaSitpGfLanbf8r8Xm8RD4tIDAdFt9eeYWpA9BfVGCjGpmEJFQSZTurkwa5ZT0DWDm+1o7Ghyo/clKKMxTyp4Kp4FYjmys96qnptZhhp1WLRNXS2nwvm7OtKWX9xCBUN3G0TIv0j/4ymkZ2VJ05UJIBrErdNPGdAqPbvc4vD6tsAS5EizLsbrkv6ySznpxXBFLsEhnVWq0J/KjO0gFHDglEvWvZsGOvlWjdD3UHGcodqp3VhnaNNIYhYpMW0GH+u/Ob6jDBTahoC87Pu0uTzmMKh7XKWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MPTRgHfqgK2r/yrBCIIUnqwFqHIwS56PbaoZy6vGF4=;
 b=itfzFx1j0EtDRe9zvPw7vxt41tjzoniAtLEBAI/VHIfA+SUkV9r46aMRbISBew44ThtSQv91hY6zaOGSj9dQ1sbbTf0LTw6D2Q0nU0QSyLBxSNHtddLyfxIz2Nx9SckHzJ/b0H+CxxCmBhwZSXAhBeLqGHbXxocoO8UPlWnlsek=
Received: from BL1PR13CA0098.namprd13.prod.outlook.com (2603:10b6:208:2b9::13)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:17:59 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::74) by BL1PR13CA0098.outlook.office365.com
 (2603:10b6:208:2b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Fri,
 25 Sep 2026 09:17:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 09:17:59 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 04:17:55 -0500
From: Bhagyada Modali <bhagyada.modali@amd.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>,
 "Jingjing Wu" <jingjing.wu@intel.com>
CC: <dev@dpdk.org>, Selwin Sebastian <Selwin.Sebastian@amd.com>, "Raghavendra
 Ningoji" <raghavendra.ningoji@amd.com>, Robin Jarry <rjarry@redhat.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>
Subject: Re: [v1,0/3] raw/ntb: add AMD NTB support
Date: Fri, 25 Sep 2026 14:47:21 +0530
Message-ID: <20260925091721.2234369-1-bhagyada.modali@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJFAV8wJKYoid=NnVkT81K0A-3v160xvrsstDj8bhAKaK3Ankg@mail.gmail.com>
References: <CAJFAV8wJKYoid=NnVkT81K0A-3v160xvrsstDj8bhAKaK3Ankg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 28df3308-24cd-4576-f5f7-08df1ae5e468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|56012099006|6133799003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8Z+Z8qVm4krNPuiKywkHdeK/agk6JZCQG91z1a2poa2JHpjwmkb3GvlFbtq13edT9DYEGxtsl7QwkRmgXj81Yyx8rNlmFhDz5+HPL84PvY+7GsSp7Us+eLX8+MO9Ra4KSlnJGmH6ByCVYKeqD/g9cklIHqhZpIxQw8p68Q+Jgw3bHKIlBZi8hXLZxuwfElSyox+bX/POFuu7IyoY3VNvf1AsurXu8LggkIaeLoEEW7P4HyeAg8NM4vbE4pBfjgCjobSVNte41g1772HPj4j2cXXYrV5M2fo6D3rqIU4a2jru4UuNDfoP7Ck3ffduEYiTzB3Anvw+qbWk0M4qUhQFh4pPOEI5RD485DNfguk1hHP678qUqGZsutyBi86u4hHq+0rTzRRmW+aOk2kVNSrMVGKS+eLOjjFaunulKS3XE2ulH6rwDhgHAdRDV5+t9ik8/HyjBZsJwAkj6lBXdeR8O9VXyuINpDxZwxna9VHKSnxLZIXUDpTIybDbggLxQqUF+qUvLkqg1GojLJwmmTL7C9sSTpJ2cWZCGHrRxnOGFMFPhAZSHqMr5HJdiYJDV80qWZxVBi/q84HdjW2vc5WtOoJMLE4QJCbbotQw/6aLOjHv/YQzXCdWuTsIm2Iu2LpnEFPrDCuM5c1UEQwdOKGAoqytQX9EAP0OuRJWz9Qo9puwvDvt9k/890SljhAHIr51iwiw085hWnyMKBEyjzD4Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8bskH/7TQKBRhKA3/D6Ni+SbcS+BylxnmQyDD9yXMewuaWvUBMLLjMdNyV7Y6TtZqFfpIko82y2S8MxYdaGBHSucarr0h2MzWDJIg3R9oCTZxHWXzOkG856uq0gyh4qZO4o+F71R0Csj4u7cZjR+U5xo7nS2V8w+Y5E07yt0k8+zG1HDzCH/7hT2+g1Dx5V5WRvoqpn8sfy+in1eTx3XZVCHF0SxLtdVSmGk5yQjajfI3ZaAsS/PiLoqjySY2JvL0Q2pXq5/ve2UawZSFXZoHyVkUeEBBkA1P0DoPhtAQONY9gAUBChxTgFs0TV5j0F7d254rIighRsMnOd6ucJzx8qRd+I35frK1RWA9Z+sUsH7+0BvOY3ofDLRzEQfuxUZpOACxfhX0m0yqLavk+pPZKNQ7hwsljVuK1drS+bgbRcmSaZSykbvdiwBmIXd1wjt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:17:59.1396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28df3308-24cd-4576-f5f7-08df1ae5e468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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

Hello David, Jingjing, Bruce,

We are close to the RC1 window and have not yet received any review feedback. 

We are hoping to have the series considered for RC2 and would appreciate a 
timely review to keep the submission on track. Thanks.


Regards,
Bhagyada.
