Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD40C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 09:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B65A40292;
	Mon, 16 Jun 2025 11:55:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EFAB64027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 11:54:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8FJJP025825;
 Mon, 16 Jun 2025 02:54:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 RVjVcXN9/FhDDZlhn2TNUyrbuTkrCcFvEgKY/vOYgc=; b=SBNQSz2LdvbvwJvfT
 l0krBhSsEpCrArevocj9jEjrR+sjhb6fWe0Z3Qy5xP7//J+ee9f2Kyne3Bqzo6wp
 HUR1s31pJJLmVP1b4/78AyM67hdDq1gRlpgFJi/shDNnFxzq1NxqaGbb3VtgKRsD
 ZrcxC4MbVKDY+YrUBvieV+Urrxlrx2YtRvnuDc07aGA26oBnTrt512K7bmMVnATW
 92tGtUcjr/24q6JXKjhHkG2Fsgws+eaOjgXkKui0YbWWyHl7gx2+9Sng90o8gmFp
 NgiUFQ0S6AoBmoFPKEP8bMM0nWvqK0Rn/xqbRMssB/SsUNGYAQs0Tx6Ot+gsjHMt
 ZkfLA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47adr8rcja-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 02:54:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 02:54:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 02:54:51 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 4960F5E6875;
 Mon, 16 Jun 2025 02:54:49 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <tduszynski@marvell.com>,
 <wathsala.vithanage@arm.com>
Subject: Re: [PATCH 3/6] lib/pmu: reimplement per-arch ops as callbacks
Date: Mon, 16 Jun 2025 11:54:47 +0200
Message-ID: <20250616095447.3236260-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6962805.F8r316W7xa@thomas>
References: <6962805.F8r316W7xa@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TfSWtQQh c=1 sm=1 tr=0 ts=684fe9ee cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=SyUIHfGIs-mbNrOdmbgA:9
X-Proofpoint-ORIG-GUID: AlLqLnWVlj0FIikTqwaBohWtYaPDmL2y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NCBTYWx0ZWRfX38drcEtl8pB7
 vLjggimklUGZxRCBtAdt7NkRh+lFAZ0ayCsAltZJ6R3VvLeMc6AaBghNVxBw/jH/dZJaA9TMF1H
 1uddiTPniPgudo4/AZZL8ZHRUtoo4kadM/bJMpGlKoXJvyVCMNdMkcksXYYq+xdkcfJM8FdldsS
 /hdTUjG4wtgd8JHhpohp3rqsvrVQ90UR1kW8KvQzf0LQ+riXOf1KbooTM3y6UPtKNpKai7wPgcg
 PQ/4ZIVleX74moto4i64H/dV59Vp172i6+J9cg3WyGB3fgbJIvfF4eo4uu9kin4Z46fD7W9ikkk
 V40g8oXe4+wEpOn+JOTjazdhkv8/saIUe4OfJsobi1W9jSL7d0AVxv++EFqjLoXcKI/6+YI9RaQ
 /KyLZVtg0TcmTfKdsqGcUvthdMAbfFe8O2HPwS0H3qddSAflt7DNGuAeukoOM/pADT0jy9WF
X-Proofpoint-GUID: AlLqLnWVlj0FIikTqwaBohWtYaPDmL2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
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

>16/06/2025 08:53, Tomasz Duszynski:
>> +static inline int
>> +pmu_arch_init(void)
>> +{
>> +       if (arch_ops && arch_ops->init)
>> +               return arch_ops->init();
>
>These are not boolean values, please compare explicitly with NULL.

Okay.
