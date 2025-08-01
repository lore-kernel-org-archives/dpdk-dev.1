Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40799C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 09:38:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00F0F40263;
	Fri,  1 Aug 2025 11:38:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A71B940156
 for <dev@dpdk.org>; Fri,  1 Aug 2025 11:38:13 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719Y8Vi007705;
 Fri, 1 Aug 2025 02:38:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 /QLZDGoDpW69tKabrArKEx0YjJwj8Yn6QL14GVsexc=; b=cnKZr4KRUGCjH7uQo
 aEefBhgns7Yr67xQXTzNOHl8KK7uyOaNla5jI94EN2lc+BCT4XROZNRwDmk7zHMI
 b0LviJLTqscXRnmcLaj2mv2xfQPugasuX3De7J17QupcBu4hj7rfihbAKWvlc7zs
 Lsu+Q+J4roHK9DRdevB2NAf6yflh50BO+IR064c3DD2q1Wk9xj0o+rw6t5iUd9qy
 TDmzal2au0lT6S+CWKBOV+T/fqX/7LvcGXS6GB8rRP0uuZBtOU+k04hxFahSL6rq
 xUMff6dbPW2UM6aBPl7aD23ZlaEB6LJF7MIMM5MK3AwSr5XjHbdcSjKRG+gtFsar
 LM0iQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 488u2cr095-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Aug 2025 02:38:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Aug 2025 02:37:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Aug 2025 02:37:12 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 191BF3F7092;
 Fri,  1 Aug 2025 02:37:07 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <stephen@networkplumber.org>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <tduszynski@marvell.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v9 1/8] lib/pmu: quiesce rte_pmu_read deprecation warning
 in chkincs
Date: Fri, 1 Aug 2025 11:37:06 +0200
Message-ID: <20250801093706.3394974-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723072752.7f6812e3@hermes.local>
References: <20250723072752.7f6812e3@hermes.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=688c8b04 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=BP31eyYstNH1JJ_2QwgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YuNnWhy9B8hctyKYMaAcyW7YxtjwMuyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3MCBTYWx0ZWRfX/1dBLBFCOLgn
 dX1sIfq5EnnU1vYDQIS0AtpPcgpocoeja5Xw2eqL3cYcYodlikZ54ruam/QEGUMdZ/P/YjaaWUG
 4Wvi9CuDn/HFW/z8GmQBf3di/G0tzjur4oJN2IyB4EGySa5Qhv96tzsnTwyTRiVeZLLOZOUlsAx
 6jP15Bk3LGU1jC/Xna+XrwOOscsiTswMO7oHzUO+f9ric/dy0An5mP1mE4jTHttLYkUL2N3Qv/2
 YzA2i1STcxLXKpew5ng7tJX/UX/8oulH16fM6l/5vewocy7UzX5Ir+SKeBJFg9zVTS3lXCIvY/2
 q89iCkDUffC2Z5Nd7yAWQgWjbimdEXc1PnhludJ9JKMqFi/CNDlWa0Mh4rr1BxVkOqhpWNP2Q8H
 lFY7OA7ZXXQ95/plRNcI+9acLBpWWUYcBJVcx+LYyvafwe1i8z5OI5kgSpEcY5/2bNnJugQk
X-Proofpoint-ORIG-GUID: YuNnWhy9B8hctyKYMaAcyW7YxtjwMuyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
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
> >
>
> Seems like a problem that could be fixed cleaner in chkincs?

I don't think there is good solution to this problem. From one angle chinkcs should detect
violations to experimental api calling conventions and it does that. This library is injected
into eal tracing so calling experimental api happens hence warnings are showing up.

On the other hand adding some exception list (or whatever) to chkincs could encourage similar
cases by making it a) easy b) looking clean. What I have now is at least not very appealing.

It looks like this library is the only one non-compliant to experimental api calling rules so I'd
leave that workaround as is hoping that it won't be experimental for too long.
