Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67971CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 15:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3701E4060A;
	Mon, 18 May 2026 17:25:49 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id A3D11402D9;
 Mon, 18 May 2026 17:25:47 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4381A14000BF;
 Mon, 18 May 2026 11:25:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 11:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779117947;
 x=1779204347; bh=+2sHG2Gg4Jujh3E5h2OYttF4oqkH1V16K01Vmf4lcsY=; b=
 upMBpoLxbuO5Z78zR9W5vNIzaNgFErRF4q7BxrvdY6eaw/d5qufDNa3/DxKdrAdl
 H9OCETwrvQesifbEd248BAAdFZzKXXiIHucM4Y36MZk4GAXwnaxioN0TDFsUfMrA
 L/4Di1hrN0eRw4Q7hrIAPfyfmRcB1LLELSNkg/1rQ3TQNd+5y7BGs/rAZbFC2pVJ
 eC09x1K36fYVQNbi6t48x1q+QrCOndO4naJFEPEN+XfIZY/myVp76aiHLBUI5RZG
 W3q82rN+ee+w8aAqC84q/4ugbG3mEATE0j+7P9jd9UE/LU9R4IufgSYbfGBeGuLF
 2HqPAowLifdEZ3hywHSQQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779117947; x=
 1779204347; bh=+2sHG2Gg4Jujh3E5h2OYttF4oqkH1V16K01Vmf4lcsY=; b=V
 hN7vKMscuGE/9XztRxgIli3rHs0vf8N7H+XJvGui9et4m+WtiV+TRZuXYio/ljhy
 mEZaAOcuPSjPSh3/9VcVQ1xFCe01ENPB6XnL/bQfqtPSPoqn7Vq+hh2+3DlfAQqa
 jew+qw7UV9PMNCqcIg5NPwLi/b6Zjr/OojMst3Sk9qroaWZBHgW53cG+drCfWMBZ
 5g93nAuRmXXvEff0OAgCtK6ragCEZSOMtg1/zw8yvxaiY/Q3jYxSWnqTJXpLItD+
 3XTPMOPTOmqSG468Mogg3fLuuvw7JtoZThcuAL9JDNQRGj4r6ViggxxDod/Ve0nR
 yCoYq6qRrCIuH2cj1QNng==
X-ME-Sender: <xms:ei8LalCbLT62cdAayHpu9gewS8k92B7Bni0w2uzr9x-kfSiYEvQebQ>
 <xme:ei8LasdasQS5Uw-r8yCm9fTwPm_LCUPSjWvALB2N-P1wmUVx0FeCupyYc3XV0yx_z
 MvzLiDIgfhFbkmNyf29pCKndaAshOc_HpdemJ2BtMQopxORdp5aDg>
X-ME-Received: <xmr:ei8LasK4v-7OMWk6dQxWq2ITF7DZSsmutyKYIaTF3MwPSk8XwFPwJniagM-7xwj8CP6tg1NcRSWjxxfxloo3ZldxiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeelvddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtvghphhgv
 nhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepkhhonhhsthgrnh
 htihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopegsrhhutggv
 rdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:ei8Lav036W2CucbBKHs9QMnrXdzY_OwIhx9LzyYnKJZL5bNOnJVZ4Q>
 <xmx:ei8Lamh_maAM_dp3QgKTRqPY8RGDvmZotoRVp1JKHMjf8Yq_aIpJ_g>
 <xmx:ei8LagUfoNGeDSByVW8ZBev1nrzd31MuXOpnNHCev1JfNr1FdKLafA>
 <xmx:ei8LalWCHXIOs5mRC4kUZX6H1X7Ped8_TAvX4UNj9EYiydAz2iG8uQ>
 <xmx:ey8LarXR_SYjE3Pf3HoZcS2z_SEslWKTrukdfF_5tGkd3m2QVgXlI1Nv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 11:25:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: Re: [PATCH v2 1/2] spinlock: remove volatile qualifier
Date: Mon, 18 May 2026 17:25:43 +0200
Message-ID: <kagkiNyiQQ67llvhX0AB8g@monjalon.net>
In-Reply-To: <DILWG1XCA7NV.33OR3FAYCVVI0@redhat.com>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260518150819.3332628-1-thomas@monjalon.net>
 <DILWG1XCA7NV.33OR3FAYCVVI0@redhat.com>
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

18/05/2026 17:14, Robin Jarry:
> Hey Thomas,
> 
> Thomas Monjalon, May 18, 2026 at 17:07:
> > When compiling with C++20 standard requirement (default in GCC 16),
> > the increment and decrement of volatile variables are rejected:
> >
> > rte_spinlock.h:241:14: error:
> > 	'++' expression of 'volatile'-qualified type is deprecated
> > rte_spinlock.h:252:21: error:
> > 	'--' expression of 'volatile'-qualified type is deprecated
> > rte_spinlock.h:278:14: error:
> > 	'++' expression of 'volatile'-qualified type is deprecated
> >
> > The count field of rte_spinlock_recursive_t
> > does not need the volatile qualifier
> > because it is only accessed by the thread holding the lock,
> > which already provides the necessary memory ordering.
> >
> > The user field can be accessed outside of the lock,
> > so it must handled as a C11 atomic variable.
> >
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> > v1: drop volatile keyword
> > v2: make user an atomic variable
> > ---
> >  typedef struct {
> >  	rte_spinlock_t sl; /**< the actual spinlock */
> > -	volatile int user; /**< core id using lock, -1 for unused */
> > -	volatile int count; /**< count of time this lock has been called */
> > +	RTE_ATOMIC(int) user; /**< core id using lock, -1 for unused */
> > +	int count; /**< count of time this lock has been called */
> >  } rte_spinlock_recursive_t;
[...]
> > @@ -230,9 +230,9 @@ static inline void rte_spinlock_recursive_lock(rte_spinlock_recursive_t *slr)
> >  {
> >  	int id = rte_gettid();
> >  
> > -	if (slr->user != id) {
> > +	if (rte_atomic_load_explicit(&slr->user, rte_memory_order_relaxed) != id) {
> 
> This needs to be rte_memory_order_acquire

The memory ordering is managed with the sl variable.
The variable user has just to be atomic, so relaxed should be enough,
am I wrong?


[...]
> > @@ -246,10 +246,9 @@ static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
> >  	__rte_no_thread_safety_analysis
> >  {
> >  	if (--(slr->count) == 0) {
> 
> This code is completely broken. Any thread can unlock without any check.

Maybe, but I don't intend to fix recursive unlock in this patch.
The subject is "remove volatile qualifier" (and unblock GCC 16).


