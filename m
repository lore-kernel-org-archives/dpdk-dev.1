Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE30CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:05:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07ACD427D9;
	Fri, 17 Oct 2025 11:05:05 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id E67F040B8F
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:05:03 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 57C2014000FF;
 Fri, 17 Oct 2025 05:05:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 17 Oct 2025 05:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760691903;
 x=1760778303; bh=9T7tSBHPL3CxAdPLHoPyvznu+QsIIRAunNhob/yg/U8=; b=
 dZudNV1u3qISe1uARJlbB+yqIWMF48q9CqDy87f3PeK+zyTg6hb3UAQHMsgOvdhK
 Jy7TGRUG6jrQjRqs3j93b+l4BV5y/a7vAcybViK0jnKQpR2PA38w/rZ5mgwjqU+i
 SuHuDiacCF4gmlDHWATcC4fVOPpDxnXOu3bq2h4JUmWWsY/D8yal3FC3B0voOFTO
 7srFJzpnNbFw2x62pptfywlITsIiA1pX81ly+DouNR5KuOwt/6F2C6h3FlXLMr43
 aksKFhL3fNaC/2AzLwSUL3KetIy4jVABZLPbbTp2YfKXJ0q4t6n7asaEg2j2VWqy
 /yuNpu3XkusZHtd7VFE9zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760691903; x=
 1760778303; bh=9T7tSBHPL3CxAdPLHoPyvznu+QsIIRAunNhob/yg/U8=; b=i
 Ldgh7BqjVOyP+tPXWcF/fg2Lk0G72gGBHD2fQvgTkfCWbjR7jk/WlVLCZZsPhDKk
 R363k4JmdVt25vVcxGLpS/gunjszsipBIsObYvDbkakggBw4RHoKg9XEleGXsMyU
 IYtzXjDyFrzi3M9nI09DZM+A6wa652wqT0Nk3wMjXxPMAcKZpFHAeR3z7KkmL17z
 a0cWvtkFuwdnT+M9uC57OY0Q38/2s51UAtVoSbftPnKf8PbUvgrOxhtXIEBuRoy5
 C+e8BTPaCXuvGMgP6fvSeYewK418mpF2eWu6Tb6fh3vl/DCfeeEK9FMVxDCjIGMz
 NPUwnEsRDa7K/rnWwTAXQ==
X-ME-Sender: <xms:vgbyaK-2Z5mz8uiHLiLPtZX2G7zCHInR4DTKqQ4iImZbSFv8GkMU1Q>
 <xme:vgbyaFohzjnod4cQWwzVM5kXLM8oWakxfTuSnJMnmVUkdK-sF7biUN8kYbhV8CTVb
 1_dRzuqexj06Kku_J2mpZ0iCwjLurlVyNgvBkZ9AsAy5FvkeXo1Jw>
X-ME-Received: <xmr:vgbyaPCFu6fN5S22cz1VNBn5SQ3jWwEntUO7A9QVIJsV81SdVAMUqMKro1v1BINSFRPjaKDzvEqwLZwwPhzx6BAYMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekjeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehtughushiihihnshhkihesmhgrrhhvvg
 hllhdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepjhgvrhhi
 nhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvg
 hshihsthgvmhhsrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhp
 lhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:vgbyaHyrO33Yp3V_ApK4YuQK6cjL4crylojecRQnwc8HmknVO7hNuA>
 <xmx:vgbyaM1HDXhV_Hk5SYsAZiIYZCb3Y6JRnAHyMJ1lxGz7gcP0Wgd3iA>
 <xmx:vgbyaHwu1ZEFZcJlnmv86S0kwnls8BD6x2pCPKl9nWld4HJz69b4Sg>
 <xmx:vgbyaDEHjUlGYhM34ED_GJN75g2WdmVq-iUxO0aD2ON-iYz_FBNkyQ>
 <xmx:vwbyaEdDHuAFsDDU07F3P9mdY0iU9QY0xAZgEabXDK2wBUAsbvIvJbtP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 05:05:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: David Marchand <david.marchand@redhat.com>, bruce.richardson@intel.com,
 dev@dpdk.org, jerinj@marvell.com, mb@smartsharesystems.com,
 stephen@networkplumber.org
Subject: Re: [PATCH v10 03/10] lib/pmu: quiesce rte_pmu_read deprecation
 warning in chkincs
Date: Fri, 17 Oct 2025 11:04:59 +0200
Message-ID: <4661587.2iPT33SAM4@thomas>
In-Reply-To: <CAJFAV8wGnXv4gO+0pf3e6gw0ahFH7q0JbMfiaGDjY9hBBX=_Pw@mail.gmail.com>
References: <20250808112758.454346-1-tduszynski@marvell.com>
 <20251017065825.3242639-1-tduszynski@marvell.com>
 <CAJFAV8wGnXv4gO+0pf3e6gw0ahFH7q0JbMfiaGDjY9hBBX=_Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Hello Tomasz,

Recently David has improved the checks on headers.
We would like to see a new revision
(with the approach described below by David)
passing in the CI with the new checks.

Thanks


17/10/2025 10:45, David Marchand:
> On Fri, 17 Oct 2025 at 08:58, Tomasz Duszynski <tduszynski@marvell.com> wrote:
> >
> > > > > > Add a dummy rte_pmu_read() definition for chkincs when
> > > > > > ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
> > > > > > use of experimental APIs in tracepoints.
> > > > > >
> > > > > > Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
> > > > > >
> > > > > > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > > > > > ---
> > > > > >  lib/pmu/rte_pmu.h | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
> > > > > > index 57b634ecd8..84a5d522d1 100644
> > > > > > --- a/lib/pmu/rte_pmu.h
> > > > > > +++ b/lib/pmu/rte_pmu.h
> > > > > > @@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
> > > > > >
> > > > > >         return __rte_pmu_read_userpage(group->mmap_pages[index]);
> > > > > >  }
> > > > > > +/* quiesce warnings produced by chkincs */
> > > > > > +#ifndef ALLOW_EXPERIMENTAL_API
> > > > > > +#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
> > > > > > +#endif
> > > > >
> > > > > Seems like an awkward solution I would rather that fix chkincs
> > > > > or restructure this.
> > > > >
> > > > > The way you are doing it will cause the checks for use
> > > > > of experimental API to not work.
> > > >
> > > > No matter how I shuffle things around, the experimental API keeps getting called from
> > > > non-experimental code, so those warnings will show up.. Fixing chkincs would mean telling it to
> > > > skip checks for this library, which is basically what I'm already doing here.
> > > >
> > > > Dropping experimental tag feels too soon. The library still needs some time to bake.
> > > >
> > > > So, unless anyone has got other ideas, which is the better trade off here: yanking experimental
> > > > tags or tweaking chkincs to ignore the library checks?
> > >
> 
> What we have been doing in other libraries is to hide calls to
> experimental symbols in inline helpers, which is the issue here,
> right?
> Then add a RTE_VERIFY(false) so that an abort is triggered at runtime
> in case an application called this helper.
> 
> See a3e126fd58d1 ("bitset: fix build for GCC without experimental
> API") for example.
> 
> 
> I see the same #define hiding for __rte_pmu_enable_group and
> __rte_pmu_read_userpage.
> Something like below should be applied on main before looking at this
> new series.
> 
> $ git diff
> diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
> index 57b634ecd8..fcf125a908 100644
> --- a/lib/pmu/rte_pmu.h
> +++ b/lib/pmu/rte_pmu.h
> @@ -31,6 +31,7 @@
>  #include <rte_branch_prediction.h>
>  #include <rte_common.h>
>  #include <rte_compat.h>
> +#include <rte_debug.h>
>  #include <rte_lcore.h>
> 
>  #define RTE_PMU_SUPPORTED
> @@ -181,12 +182,6 @@ __rte_experimental
>  int
>  rte_pmu_add_event(const char *name);
> 
> -/* quiesce warnings produced by chkincs caused by calling internal
> functions directly */
> -#ifndef ALLOW_EXPERIMENTAL_API
> -#define __rte_pmu_enable_group(group) ({ RTE_SET_USED(group); 0; })
> -#define __rte_pmu_read_userpage(pc) ({ RTE_SET_USED(pc); 0; })
> -#endif
> -
>  /**
>   * @warning
>   * @b EXPERIMENTAL: this API may change without prior notice.
> @@ -211,6 +206,7 @@ __rte_experimental
>  static __rte_always_inline uint64_t
>  rte_pmu_read(unsigned int index)
>  {
> +#ifdef ALLOW_EXPERIMENTAL_API
>         unsigned int lcore_id = rte_lcore_id();
>         struct rte_pmu_event_group *group;
> 
> @@ -231,6 +227,10 @@ rte_pmu_read(unsigned int index)
>         }
> 
>         return __rte_pmu_read_userpage(group->mmap_pages[index]);
> +#else
> +       RTE_SET_USED(index);
> +       RTE_VERIFY(false);
> +#endif
>  }
> 
>  #ifdef __cplusplus





