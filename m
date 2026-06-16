Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F47CD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 08:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C719B402DB;
	Tue, 16 Jun 2026 10:03:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C881240289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 10:03:21 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G65xUY1992650; Tue, 16 Jun 2026 01:03:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 XU+W3rdRMez1+451U8illJIBy1WaM6KuiO85FOV8fs=; b=j63rjI25cpHQ/3ABn
 Wk01d/E2CZfgsCH61nUnr2A4wWbDxqRlVB9ODFobl2MZlPAISeq+SySR+XoHJRWE
 zcaVvPE5XK4LjG3bcJ2jy41NNxgBrMQ0vAvQMtANufFdU6YMFcp0PU3xMpIIuF7e
 jAjbSccKpcbI7kJJz4qVv+iqzx3ZanWm5qaU1XGHzEieo4vr13SXmlDSWyA1C3hs
 2J8WAv5aWaNKNMbJxHtzQs/QPld4tDcvhUV7wQwJUbP3B+A7nzk3ww2lPSkvYHIz
 bAaT1jZR+c2RvSjFyMGu2DKy7VPxkCYi/Elf7xPAX6g5gO5mIeGLEeV5cVfglH3Z
 7HGvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4etu38hs8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 01:03:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 01:03:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 01:03:15 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 72B2C3F7043;
 Tue, 16 Jun 2026 01:03:12 -0700 (PDT)
From: <kirankumark@marvell.com>
To: <rjarry@redhat.com>
CC: <cfontain@redhat.com>, <david.marchand@redhat.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <kirankumark@marvell.com>,
 <konstantin.ananyev@huawei.com>, <maxime@leroys.fr>,
 <ndabilpuram@marvell.com>, <vladimir.medvedkin@intel.com>,
 <yanzhirun_163@163.com>
Subject: Re: [PATCH dpdk v2 2/2] graph: replace circular buffer with
 priority-based bitmap
Date: Tue, 16 Jun 2026 13:33:11 +0530
Message-ID: <20260616080311.2372090-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <DJAAFGOSALXB.3BJ91NA2ES267@redhat.com>
References: <DJAAFGOSALXB.3BJ91NA2ES267@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: U-CRWMRWvX4OIguf3f_fkgvkVB-ZxOAT
X-Proofpoint-ORIG-GUID: U-CRWMRWvX4OIguf3f_fkgvkVB-ZxOAT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA4MCBTYWx0ZWRfX/F06kUbkFF1D
 QY61UjHWFsk/awYkYG/z7dXA556e6jt+kkWIg+uAkGi/XXZ1TIHgLNpCXtQJNqWqV978iCfzbdv
 BNi0JbEbwJxzmFKdck4Q7nME6Aq7vrw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA4MCBTYWx0ZWRfXwfmym0SNp5Im
 I2TfJyvghXX58NpUJF4V5XbOQwHEWBc0OdyXv8pq9r04h11cTAzbH9K9mnfsfDs9NEKUC0yWK1j
 GqpXNz60E58kddlc2UE6l3/TzhSAGtxlXQxBVdtTYfnrDJoBEaDeCBEvy5E9Hju5TWIiY5ewUDe
 pFG3ebEVlXrNOL6JhKFvCkNqoIk/FZ2dNyAVk/5CecOLtGcHG4kfvk+dDBRBCHW8vcksKesu9x+
 u4M6bagVLkXrCEOrsccoVDDnedgAN73FNLFwx7+LX8kERqgg0v8OVAn7EUv4M6CbY+Cnd2NsgzZ
 pb/0FtoF/s7bW0TMr1/7pImxOx+swJd0HcHFKWdqfRcp7WXJKm2GN6+hhoqA38QNyw99UBYwxTI
 7E3rRome44StMHIX1nXmJwX/gMTUMrE/SgPdLw9vP0xLFMw+i3CMJIuVIeyE3CaoC8Huv+Gm474
 NrmKt+xvj1K6XZzGeAg==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a310344 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=dGCdxeqfR0iHkFUmFQIA:9 a=zZCYzV9kfG8A:10
 a=0lgtpPvCYYIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
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

> Hi,
>
> , Jun 16, 2026 at 08:30:
> > This will break the ABI. Please check and fix.
>
> Yes it will break the ABI. There is no way around it. What did you mean
> by "check and fix"?
>

 Looks like we canot avoid ABI break, Since Graph is not experimental library,
please send deprication notice and we need to wait for next ABI breaking release i.e 27.11
