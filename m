Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055C1CCD184
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 06:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3706B410FB;
	Fri, 17 Oct 2025 08:58:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3C92640269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:58:31 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H6lkhY029685;
 Thu, 16 Oct 2025 23:58:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 LapZ6ACuPAYz1EV+e9giLNvMORjyHSCIh645LdiXR4=; b=T4CLWjJ6znHvEF92x
 dnBGt9Xn9WKOR+53rdJinZcaMZ1La2RiPv9MMnGaLbafOA5pIwj3Yo7gMZzywUtc
 0DLcGBe1gpg3OU4QPOeUT6pwFM0LzIj2t8HOP+MxFd4TsQU/2+Krf9GYsdm/miS1
 ztLMb3sDcoXQWCST/I3Zu+bnW+pHa31ZeVcYazs3/6JEZymjqlBFq+PvbO+SNiCX
 bZz3RwTUS+1F5LDrlTGj1RE2YRH4/6gJ7DhmBtbV2E7y/X8xBS0EnhXu/OKUutC+
 GsBM1Pucb4ZeGqxqQt1N/TQpwitQ+uQQbtg3gBBsKoQn6n25dymnSDrC3dEU3eoa
 5eTGw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ugukg0ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 23:58:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 16 Oct 2025 23:58:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 16 Oct 2025 23:58:41 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 48FCA3F7054;
 Thu, 16 Oct 2025 23:58:26 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>
Subject: Re: [PATCH v10 03/10] lib/pmu: quiesce rte_pmu_read deprecation
 warning in chkincs
Date: Fri, 17 Oct 2025 08:58:25 +0200
Message-ID: <20251017065825.3242639-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808112758.454346-1-tduszynski@marvell.com>
References: <20250808112758.454346-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDA0OSBTYWx0ZWRfX1H+1cXw79QaD
 h1im0QBhtD4g6HKNLVr4UvAMGWcDF9O56rON5C8tbegBM06+d0Jpkcshc1KEOEpHfOuhLxQpiYy
 /PagX7L3Qef69LIMOWtddF5/LH7TRFzMQNqxA2rvcbTcSnUXtZfly1/gY9vuthyoEGDI2gmlZRe
 XaUR60+XfA7i6mtI2topAA+uOCnScjJUjUVJuOCnPUkoYmzDizfd7193a3loNOVLuFZSiZe92Vy
 vHU8AYQwpz2zdinvAVI8RbEkH0Zsnzzu5Nq7jGrUbnGD0YdczYys8SVWPgERW5K3zwM67JioaD8
 HEG0zkLV2II2BZM/qBhtkdctn6KZ0FKc+J13aI+QJArc/8xjP67q2KXosIZhHGHY+cYwXehY7E2
 HDRHTmCnq+pmBqoRw7a963XeGNg9AA==
X-Authority-Analysis: v=2.4 cv=NNfYOk6g c=1 sm=1 tr=0 ts=68f1e916 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=iO8hQBOTYyJhAAMDmvUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 1JjhYjFjNDG8n2a7ZNNjIRUEzV-RcsZH
X-Proofpoint-GUID: 1JjhYjFjNDG8n2a7ZNNjIRUEzV-RcsZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
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

> > > > Add a dummy rte_pmu_read() definition for chkincs when
> > > > ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
> > > > use of experimental APIs in tracepoints.
> > > >
> > > > Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
> > > >
> > > > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > > > ---
> > > >  lib/pmu/rte_pmu.h | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
> > > > index 57b634ecd8..84a5d522d1 100644
> > > > --- a/lib/pmu/rte_pmu.h
> > > > +++ b/lib/pmu/rte_pmu.h
> > > > @@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
> > > >
> > > >  	return __rte_pmu_read_userpage(group->mmap_pages[index]);
> > > >  }
> > > > +/* quiesce warnings produced by chkincs */
> > > > +#ifndef ALLOW_EXPERIMENTAL_API
> > > > +#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
> > > > +#endif
> > >
> > > Seems like an awkward solution I would rather that fix chkincs
> > > or restructure this.
> > >
> > > The way you are doing it will cause the checks for use
> > > of experimental API to not work.
> >
> > No matter how I shuffle things around, the experimental API keeps getting called from
> > non-experimental code, so those warnings will show up.. Fixing chkincs would mean telling it to
> > skip checks for this library, which is basically what I'm already doing here.
> >
> > Dropping experimental tag feels too soon. The library still needs some time to bake.
> >
> > So, unless anyone has got other ideas, which is the better trade off here: yanking experimental
> > tags or tweaking chkincs to ignore the library checks?
>
> Any preference or other comments regarding that?

Friendly reminder here. Can we agree on something?
