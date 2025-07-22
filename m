Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30215C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 11:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47AFB40283;
	Tue, 22 Jul 2025 13:07:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A099D40265
 for <dev@dpdk.org>; Tue, 22 Jul 2025 13:07:47 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M9HUSs021912;
 Tue, 22 Jul 2025 04:07:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
 IqGCm0jxD51ryeOojmJTWfL4jx9DU62FORIp1+xYJU=; b=G0FA49dfQDMc6DOtO
 XDTlsAb3RDxz/+b8qH5mcbao6KiFVpAa+uQ/GLVHI4LLiUnOrTxTR3LOL9Tloh2n
 6sEbunZ1XaDDcvu3SJx8mERzprKX3g+1VL3KX7+ijJdRHF5mFAN7LIZjrdr7QFQY
 t5TVHRmlP3kv/8OmRpzODd5wQdvv+KkWI3VZd+3jiHfW1INwlnW4sbJmQo6hkT9r
 0o3QdJxi+e7t4f/1J71Fhjlhcj80L38sJOthLKtYhokwPgnNnU9LnlygaWXQ1LcL
 1yy/nq3rBj1CAnct3hAmrxKrX4jMUIIv9TmBBrAVdykFAjhsYYZLFu4VL7ad1TAO
 DaeOQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4827vp87dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 04:07:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 04:07:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 04:07:45 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 3C52E3F7074;
 Tue, 22 Jul 2025 04:06:53 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <mb@smartsharesystems.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <tduszynski@marvell.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v7 7/8] trace: add PMU
Date: Tue, 22 Jul 2025 13:06:53 +0200
Message-ID: <20250722110653.2716323-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDBD@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FDBD@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cfHSrmDM c=1 sm=1 tr=0 ts=687f7102 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bt5KbKNvAAAA:8 a=M5GUcnROAAAA:8
 a=DECHjbIcvSuuep2PTKsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-zEBD5cKgE7DNtTSb7C:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 12owMukNgaIg3yYjPfQ7ZG1A2xAypimv
X-Proofpoint-ORIG-GUID: 12owMukNgaIg3yYjPfQ7ZG1A2xAypimv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MCBTYWx0ZWRfX0KiFW0DvZ63O
 edIWfmFvI+aDFMr0HKnJNyRZlKBJZwmyFp5uHOOyab3ZU8F+cPlV/EnkO/ZzcUR15NeBa7DLwQn
 llVzoQvKG0KPjEXitGd2SY2fBWYM3PqIItvLBl4n/xzVmtdK+0R3Fn8curpfbUFWKAkqal8Ky+C
 KyYUIYbz+ih7mMf5IdHezlLaEXakX2g/I29IKYSJbs4V+hNazZqc9YNQOjvhL4uwRpEl+n//3rb
 i/QdoTsS7SDEcOvlK1dX6ni5sivYq6NpH3N5LYM8TMy2p6w3fI/EJP4vhYOPwtNp812VqF4inhc
 jeAdYQ9x1VtnIbpsIAo6zOvVROnVgYQlZyogG6PH5a646Z/VYluhCaku8IASvRg80TvwZyW0B0E
 +sPBVYHb1dz/AXbA6ow7qiZeH8KOiD9B4h3Mmo1bS4XZ9TLKAxVxRXSxLlmYw6pyKwGwOkAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
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

> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Monday, 21 July 2025 12.46
> >
> > 21/07/2025 12:24, Tomasz Duszynski:
> > > > On Fri, Jun 27, 2025 at 5:41 PM Tomasz Duszynski
> > <tduszynski@marvell.com> wrote:
> > > > >
> > > > > In order to profile app, one needs to store significant amount of
> > samples
> > > > > somewhere for an analysis later on.
> > > > > Since trace library supports storing data in a CTF format,
> > > > > lets take advantage of that and add a dedicated PMU tracepoint.
> > > > >
> > > > > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > [...]
> > > > > --- a/lib/eal/common/eal_common_trace_points.c
> > > > > +++ b/lib/eal/common/eal_common_trace_points.c
> > > > > @@ -119,3 +119,23 @@
> > RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_enable,
> > > > >         lib.eal.intr.enable)
> > > > >  RTE_TRACE_POINT_REGISTER(rte_eal_trace_intr_disable,
> > > > >         lib.eal.intr.disable)
> > > > > +
> > > > > +#ifdef RTE_LIB_PMU
> > > > > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_trace_read, 25.07)
> > > > > +RTE_TRACE_POINT_REGISTER(rte_pmu_trace_read,
> > > > > +       lib.pmu.read)
> > > > > +#endif
> > > > > +#ifdef RTE_EXEC_ENV_IS_WINDOWS
> > > > > +/* gen-version-map.py script generates export symbol maps by
> > scanning source files without
> > > > > + * evaluating conditional compilation. Hence __rte_pmu_trace_read
> > will be included the version map
> > > > > + * even if library is not compiled.
> > > > > + *
> > > > > + * On Windows if msvc linker is used this leads to a hard link
> > error
> > > > > + * (LNK2001: unresolved external symbol) because msvc requires
> > all symbols listed in the .def file
> > > > > + * to be present in the object files.
> > > > > + *
> > > > > + * Other linkers, e.g: gnu ld or mingw ld, are more forgiving.
> > They silently ignore symbols listed
> > > > > + * in the map file if those symbols are not present in the
> > binary.
> > > > > + */
> > > > > +rte_trace_point_t __rte_pmu_trace_read;
> > > > > +#endif
> > > >
> > > > From a quick look, could you export this symbol from the PMU library
> > itself?
> > >
> > > Got caught up, but here is my take. It would likely make trace a
> > dependency, but I believe the
> > > dependency should be reversed. Also from my perspective this
> > suggestion feels more like a
> > > refactoring.
> > >
> > > So unless I've misunderstood your point, I'd rater keep the current
> > solution as is.
> >
> > I think you got it right: a refactoring looks beneficial.
> > Please think about it.
> >
>
> It's a long term goal (wishful thinking?) to move Trace out of the EAL, and into a separate library.
> Considering this long term goal, refactoring PMU to make it depend on Trace would be a step in the wrong direction.
>
> However, if we disregard this long term goal, and do consider Trace a core part of the EAL, refactoring PMU to depend on Trace seems cleaner to me too.
>
> I'm in favor of not adding more obstacles to moving Trace out of the EAL, i.e. don't refactor PMU to depend on Trace.

Tried moving that to pmu itself but unfortunately it won't compile due to current dependencies.
PMU gets build before EAL so some symbols coming from trace (which is part of EAL anyway) cannot
be resolved.

That said, I decided to cut corners and moved workaround along with lengthy explanation to
rte_pmu.h. With that, at least EAL internals are cleaner and automatic symbol export is resolved too.

Let's continue discussion under v8.

> Also, I tend to agree with Tomasz about PMU being lower level than Trace, so PMU depending on Trace seems wrong. No strong opinion on this last point, though.
>
> @Jerin, what do you think?
