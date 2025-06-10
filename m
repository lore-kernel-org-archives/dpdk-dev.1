Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB17C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 09:55:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7287A42E62;
	Tue, 10 Jun 2025 11:55:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 10CFF42E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 11:55:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559NV3ba006061;
 Tue, 10 Jun 2025 02:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 cbMoNyTfvKBWIULxZ+FO2WSpRPJa5XgLRR6otrukbs=; b=MH7MWjUbIIPdddFNs
 dPl/517WQjEVzycZp0Zdz5YZKbH0AvAOtOCGE19BxaANobadFfgXsuipGeCH1QnF
 qII6X/PTRPooW2y8wxmCioaYvg6zBi/NXAyj0Q2lIL7wB9D0FBHgWoheB1S+yMf2
 FZoiu4pgISBMOSir4qMrtPotLeTpW5dTznRGtZEfSawGctnMpkgFrppr1JpjnZdU
 O6Jx72GTwAzzTgFDRLjfNy/CANHmJI6i120X2wW0ePDAZrxKsJCCp5D1bCovix0N
 EriFNMhczzqxerRQ5s37tIBlUCn9dSwcFzYo0zorWTBOSiDuZIvj2c/1gDVH7FUD
 PD89w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4769bn1475-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 02:55:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Jun 2025 02:55:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 10 Jun 2025 02:55:29 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 4F7AD3F7057;
 Tue, 10 Jun 2025 02:55:25 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <thomas@monjalon.net>
CC: <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <tduszynski@marvell.com>,
 <zhoumin@loongson.cn>
Subject: Re: [PATCH v17 0/4] add support for self monitoring
Date: Tue, 10 Jun 2025 11:55:23 +0200
Message-ID: <20250610095523.1144504-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5285753.vfdyTQepKt@thomas>
References: <5285753.vfdyTQepKt@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA3NSBTYWx0ZWRfXygyDggQ4wE6x
 dhBqM9G8lQiZtImjocCR+RYNyI/nUdm/PpYgmlgpl2aJglb/YbEIWWpHLJc9Wce6uYpunOECEfy
 AOWAcusfz4tVK7zB3WZ5Pi0vIJTeUAggMrA7u1ih6zr8JY5p7joHH39v4R0sOqU91BmeSMxYvNG
 yeIf1lQPXv/X5GKPxxmHAequSVpo85iyV5eZNhAmeQp1/oFSp20qi4Z4zXMIEJaUjqvs2e6amju
 V+SVWLkph4EJQvdzjpvw4K8Xj4wB1k3M7y+yKF0rWtg9T0pUyHU+UHWqNhFQaiQoP0PK8K6B/vx
 m9FlAKyObohhe2+RLTEB9fM7PKV8hj21dVF68DUrfsYPs2fkmQ9XuwKA8NHpNZ6voLEM4Sbals3
 9hMaFujq/bN2sL/1Mr5B8DXvA4oqqUnHqodDe1lRVf/ZsECcGFpRWGvNGm/x3Mbs6zPjaVow
X-Proofpoint-ORIG-GUID: v9eh7JeZuCcFZgSITd-6WJfxOLE7nw3p
X-Proofpoint-GUID: v9eh7JeZuCcFZgSITd-6WJfxOLE7nw3p
X-Authority-Analysis: v=2.4 cv=ZuDtK87G c=1 sm=1 tr=0 ts=68480112 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=JpQwxCUzP14bQih6QUoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_03,2025-06-09_02,2025-03-28_01
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

Hi Thomas,

Thanks for taking the time to merge the code and for the detailed update.
Cleanup and fixes you've done - appreciated.

I'm working on resolving remaining issues.
