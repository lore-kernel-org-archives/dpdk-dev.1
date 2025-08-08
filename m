Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E5C87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 11:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 021AD402AB;
	Fri,  8 Aug 2025 13:28:07 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 488554028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 13:28:05 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578A1ITu000597;
 Fri, 8 Aug 2025 04:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 9HAR4aYIQqR9gRBwimVNZB+nmmU88abKnxLnBO4j7M=; b=bF0l/LaeQ3W+il3wF
 kImLOT1bc4Vft5YLxoE+HI0GY1zJsKxn4pAlC/LDRgtN5uwDBv3GiQEacj1f29iu
 2ZWE8Xcp8AWZSI93YzhXGZ/jpUqqrh9VnDJp29xj3IbtWTJScUrMaJP4LCI4Rhd1
 K+jSybQcoUKZuEm87HNfGann36Dn3R8iVS3/E+2Ux5LCJDfmia9nzmwhD7aDu4XL
 oP97BZr9eCsj/oMaYZ02W075uJdADfrjKNv8XK18vwZ/hSjZOc4YIdIXLmYsQ2cU
 A91/N2nuliNYrUxBFXVhf7p84XN76RuGMgbpleqlIcX+1TtUVDme+9igPAZZHaxW
 eYHmQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48ddtq87xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 04:28:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 8 Aug 2025 04:28:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 8 Aug 2025 04:28:05 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 24CC43F7058;
 Fri,  8 Aug 2025 04:27:58 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>
Subject: Re: [PATCH v10 03/10] lib/pmu: quiesce rte_pmu_read deprecation
 warning in chkincs
Date: Fri, 8 Aug 2025 13:27:58 +0200
Message-ID: <20250808112758.454346-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804100909.4052876-1-tduszynski@marvell.com>
References: <20250804100909.4052876-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA5MyBTYWx0ZWRfX5HV9mLCdEWf+
 LFdRx6cXU1q71lJG3s+5TOUNAFgYfMox7Jep3GJZZ21xO1H+Ocy9LXEZdH53b1g+pi1TRwrBpUR
 OoLo+th7lvUAhViXlmbbSQKQ1Fn1JcK9k/Nkfpw3uxJMdYNS5oKNcV4LOR33LsWwSNri1aKlTWS
 1QQmLVFHnc58Unadlppx8IaVDwvlH9F5Y1sizJF7yQJkHpEUvSvxP6gBy5YbiAnI41L4Tv0WlUK
 tPQjfRQlpsE4ZRAwIVh9AgBIFr+vPVmUTSxOyVcp0aV97KJ+GsOlJUPJG6G/UupM0IXEI5fcWef
 4Q4IPIKnge0NrNuKrIUK21Oab2BtXhlzl+nuq+wKbMXBE2lj2ee9cMUrsysPdiP/PwLqR1gnRXK
 zxUL5yB/hnTx/WrbQ2aybARJ18M1Iibh1owMC/t+YKFU0hpAhj5ZqN9um0V3t/5heee+Zg6b
X-Proofpoint-GUID: qgSvf1TM3CktqUggR2HBxpNZdlyWkGIy
X-Proofpoint-ORIG-GUID: qgSvf1TM3CktqUggR2HBxpNZdlyWkGIy
X-Authority-Analysis: v=2.4 cv=X8tSKHTe c=1 sm=1 tr=0 ts=6895df43 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=vAe-lJBlSaMOdJ35rNAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
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

> > > Add a dummy rte_pmu_read() definition for chkincs when
> > > ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
> > > use of experimental APIs in tracepoints.
> > >
> > > Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
> > >
> > > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > > ---
> > >  lib/pmu/rte_pmu.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
> > > index 57b634ecd8..84a5d522d1 100644
> > > --- a/lib/pmu/rte_pmu.h
> > > +++ b/lib/pmu/rte_pmu.h
> > > @@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
> > >
> > >  	return __rte_pmu_read_userpage(group->mmap_pages[index]);
> > >  }
> > > +/* quiesce warnings produced by chkincs */
> > > +#ifndef ALLOW_EXPERIMENTAL_API
> > > +#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
> > > +#endif
> >
> > Seems like an awkward solution I would rather that fix chkincs
> > or restructure this.
> >
> > The way you are doing it will cause the checks for use
> > of experimental API to not work.
>
> No matter how I shuffle things around, the experimental API keeps getting called from
> non-experimental code, so those warnings will show up.. Fixing chkincs would mean telling it to
> skip checks for this library, which is basically what I'm already doing here.
>
> Dropping experimental tag feels too soon. The library still needs some time to bake.
>
> So, unless anyone has got other ideas, which is the better trade off here: yanking experimental
> tags or tweaking chkincs to ignore the library checks?

Any preference or other comments regarding that?
