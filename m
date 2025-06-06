Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5B5C61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 16:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BD0040283;
	Fri,  6 Jun 2025 18:27:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B4C2440263
 for <dev@dpdk.org>; Fri,  6 Jun 2025 18:27:47 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555NTOql028592;
 Fri, 6 Jun 2025 09:27:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 sED+W4K6TvwS4s92eHYIPY8JIOOKbj5IHUgTw4FDZ0=; b=MrixjUH84obqYqMJf
 VwzWEwTRqvue/34J49O2h1AtQktAJfZFAKpkVj27+4Ql3XuG9NrUcFX4f7NU7QEP
 4GpxRlA7X5TcbxZPqSI7S8FScHVbThNPbhPp7qWSCZ3JHSvzbOiDLQFBpTWzsfkV
 aHoaQqdE9RJbnbUVO+MSwBiwXmH3CQwhUzPKZj3ip5idC5Xv0jeVdtR2NYhydkvP
 QJwjgYxsAkC9/A3jMlPeJjJ+CXhmtch0qrf7xON8Tc7zY/tlptKD81VOrWz9SNp8
 NW7ciDUV4stEzuHcKPS0haPdXcBkIM5aEqZl6XIoU6k3cYlbJUxaLhvxFeRZU3sT
 EWAKQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 473mxxhrv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 09:27:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 6 Jun 2025 09:27:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 6 Jun 2025 09:27:42 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 206813F705D;
 Fri,  6 Jun 2025 09:27:37 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <thomas@monjalon.net>
CC: <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <tduszynski@marvell.com>,
 <zhoumin@loongson.cn>
Subject: Re: [PATCH v17 0/4] add support for self monitoring
Date: Fri, 6 Jun 2025 18:27:36 +0200
Message-ID: <20250606162736.409485-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <15762368.uLZWGnKmhe@thomas>
References: <15762368.uLZWGnKmhe@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7QL4jxGOPYbaG8M-kG8cQw6x9kG5rAVc
X-Authority-Analysis: v=2.4 cv=Z7bsHGRA c=1 sm=1 tr=0 ts=684316ff cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=v90GV_Y8AAAA:8 a=8rWy6zfcAAAA:8
 a=C2enSO9FMMxTcpXQMe4A:9 a=yK6Xxz7lNNgA:10
 a=fBD7mPJ_7mWCjuCAFpJ4:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: 7QL4jxGOPYbaG8M-kG8cQw6x9kG5rAVc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEyMSBTYWx0ZWRfX4vdIpHuq7d2a
 nhJcfYFhXnhw2gAgn3Z+IpEhQq1xZo7BTWLiCyLhlzRYYBHm0cbTgrZtVL0Bsta/Q2Y00cJKQyU
 x7zcokrn23gFLj7HUmY5a51fJZl8ofSl/CFvKpXnZk1iGkdmblzWkLoqxZJhddhFQjgoSDs8gfP
 STY4VsCxwAzPaRJlrpMfeVkIBEB73nrnEKdpUgB0ZxDDJ2R5sJ7KxZevk/fL6kD7LMo60RsNNAo
 qQfRuR1Pm2/OYy1VJPd4HHaUEzq8d9ddyrFFBRDKM9fI9kEX54EHBCh4L+e5QdPjxqZIo0ueyaO
 eFlaRk22a+vSry8tDb0qxw0gd0Q5lAg8/dvMOElYUmQGLLixf+w3tjir2KRvLQmIS5oGTmbajpW
 r0I2HQ4zexBQxLVSRltJAXikvlnymiLlALanR+/OobcCQKmMtYfp2r0Y7rfR0Z+YFwhvo/Z7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_06,2025-06-05_01,2025-03-28_01
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

>Hello,
>
>17/01/2025 10:00, Tomasz Duszynski:
>>  lib/pmu/meson.build                      |  22 +
>>  lib/pmu/pmu_arm64.c                      |  94 ++++
>>  lib/pmu/pmu_private.h                    |  32 ++
>>  lib/pmu/rte_pmu.c                        | 537 +++++++++++++++++++++++
>>  lib/pmu/rte_pmu.h                        | 251 +++++++++++
>>  lib/pmu/rte_pmu_pmc_arm64.h              |  30 ++
>>  lib/pmu/rte_pmu_pmc_x86_64.h             |  24 +
>
>Reading it again, I wonder why it is a separate library.
>In general we give access to the hardware in EAL.
>Why not having PMU in EAL?

I initially started PMU as something tightly coupled with EAL, but after
feedback from other developers I decided to decouple it completely [1].

The Technical Board also discussed this and supported the idea of having
PMU as a separate library [2].

The main goal is to keep EAL lean and focused only on core essentials,
making the PMU code easier to manage separately. This separation aligns
nicely with the broader effort to simplify EAL by moving optional
features out.

[1] https://lore.kernel.org/dpdk-dev/20230111210547.GA2134@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
[2] https://mails.dpdk.org/archives/dev/2023-January/260035.html#:~:text=PMU%20Library%20,principle%20for%20inclusion%20in%20DPDK

