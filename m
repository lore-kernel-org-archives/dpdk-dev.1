Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2E6C87FCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 10:09:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 141FF4025D;
	Mon,  4 Aug 2025 12:09:17 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8CC2B400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 12:09:15 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5747uHJX022673;
 Mon, 4 Aug 2025 03:09:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 nDfWzIQJwtBCwT7WfaHfRYBbgyb0UseL1zN0/pF4IM=; b=Sl+XF15i6q9BCAxAs
 zSDOoQWi3hPIkcPKcwYOL/3e78+bjHPQu3EGEfAYTC06I6y4G0xHbTSQ1baLM59k
 ejEA+2iamsgijwYYOrkH8cYpm1lju4IY4U/Sklg8B05PoYOiM9vyJZm/aR0fnLkD
 DyeTnOP9PkESgTuFY4yxPaepiuaeJrvV883fFlT+U3CRE5hKszqsIFGnJrLieq3l
 Roho9JBHu5XaDzjL6zH4hZdP5V6e2eIERuyGAOqaNNx2HTzUH/OFr8DYwvbt493r
 YBDxpRpbTfCz/u969Ts3170Ppohuc1uAM485jhfzqDA5t94x3g1VC6DrEgiAils3
 2KBLg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48arwcr6t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Aug 2025 03:09:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Aug 2025 03:09:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 4 Aug 2025 03:09:16 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 170613F704A;
 Mon,  4 Aug 2025 03:09:10 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <stephen@networkplumber.org>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <tduszynski@marvell.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v10 03/10] lib/pmu: quiesce rte_pmu_read deprecation
 warning in chkincs
Date: Mon, 4 Aug 2025 12:09:09 +0200
Message-ID: <20250804100909.4052876-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801144704.490d0433@hermes.local>
References: <20250801144704.490d0433@hermes.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=d6z1yQjE c=1 sm=1 tr=0 ts=689086ca cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=BP31eyYstNH1JJ_2QwgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA1NCBTYWx0ZWRfX0vH1/BCwK0MJ
 ekoFZ7LBRqAflneuiGcaUzFzbMQQock178oQnw6CwxCwVRCacfiPUjjEWTrn6AW5hM/mZ7jDoGH
 U5g/6eUSZYIFmpjGjbuvld1k2iyahl+pyevgAEMmkXX7ucl600UrBNcka0obMqTKliZ607qqX+3
 wQBVb2BdYo5NW03jSqzbfRJ5BVJYLV7dAsixI6SWT87v3P2y+d716meeEEZL+k0nCyhqe1j58HT
 NkVM0Qu2I2snkmFAR/dOOhtqBVumv/V/0chNO+92fGUaC0ITNJgUGc0sTK0P4+Xb3nBH1FVJ2/P
 /tg9Luncd5Q+CW5E6sTKt6Im0PD+GdTAc5mMCLnIWV3Cn62NDBYP4Pqgs8FkDfJTb31TBkoZQji
 b9rklipjoLO7RUPz2BxTYdXHcUAhnV+t30AMIFM7JZBRkmKxwPFrfnrWoTtHu/u0xthPbJWV
X-Proofpoint-GUID: vgyVDH5XJg0zWyuOELcdhCOaJtj3wzWU
X-Proofpoint-ORIG-GUID: vgyVDH5XJg0zWyuOELcdhCOaJtj3wzWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
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

> > Add a dummy rte_pmu_read() definition for chkincs when
> > ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
> > use of experimental APIs in tracepoints.
> >
> > Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
> >
> > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > ---
> >  lib/pmu/rte_pmu.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
> > index 57b634ecd8..84a5d522d1 100644
> > --- a/lib/pmu/rte_pmu.h
> > +++ b/lib/pmu/rte_pmu.h
> > @@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
> >
> >  	return __rte_pmu_read_userpage(group->mmap_pages[index]);
> >  }
> > +/* quiesce warnings produced by chkincs */
> > +#ifndef ALLOW_EXPERIMENTAL_API
> > +#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
> > +#endif
>
> Seems like an awkward solution I would rather that fix chkincs
> or restructure this.
>
> The way you are doing it will cause the checks for use
> of experimental API to not work.

No matter how I shuffle things around, the experimental API keeps getting called from
non-experimental code, so those warnings will show up.. Fixing chkincs would mean telling it to
skip checks for this library, which is basically what I'm already doing here.

Dropping experimental tag feels too soon. The library still needs some time to bake.

So, unless anyone has got other ideas, which is the better trade off here: yanking experimental
tags or tweaking chkincs to ignore the library checks?
