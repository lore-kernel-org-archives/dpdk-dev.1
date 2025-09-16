Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4874DCAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 21:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49309402A9;
	Tue, 16 Sep 2025 23:33:45 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id D89F940288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 23:33:43 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id B512D1D00139;
 Tue, 16 Sep 2025 17:33:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 16 Sep 2025 17:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758058422;
 x=1758144822; bh=syeqEvzzJyeF+3ETDpljh0nbM3elWdR5ui2mv78Tyzk=; b=
 Hx/tPDV6LC9Zj9Vxi2DS3Y57wLxErAhNZxB0uiKCSe+Lv0hA2L0ZDt1JtFzMPfnz
 7dEI5ZBAQTO7GhfVCtVBbBBZUWz0fbFhzohqGQCN9YLEyDVn0TpPUjf4DQZf9YxM
 1ySOXEIrXPpghPpB3XLZ8Y1eweZl7chwkWDOp7uolDQxGrKQxL/ou6Fd2NlBg6SY
 C37XORkiztQvzXedHE1vyMcGgd/6gAYx2wxQDKUZ4GxYzxeZuGNW1oguHQ7clPvO
 siKWfDMzLf4iyfJUSMA12a3OShcxPWKlqWRExSrbqSmMgvvy4fqeTK9dTb6Xs3J8
 GkgE/A6mUpATIgscEtVsAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758058422; x=
 1758144822; bh=syeqEvzzJyeF+3ETDpljh0nbM3elWdR5ui2mv78Tyzk=; b=f
 2WhYGq4iOxMVPyiyznJu0fp35v6gyXV0R2HxF6g7O8XJpI1E7pg1nlpVT7icm8OE
 +zmKVDaOUKXgAjdK/wiqPol+hn8FHWAiV27tByI6YIfU9p1QByKCyqJEU81s/bYk
 PApUhv+6fz/uv6pv8J5nPgeUrkXKsd7jmzzxNG/Vxxv1ssJh8MEOj56NLsmSpXyr
 +AdnUPUfZA621WYuNSn0RlMSS7C4ZsUV4wu6PYFukJhGwwGPb7ggWhjN/J1YYCV9
 NegtLuK+33OamFsDrPVIE2G/mRartnx9Kwup6Y0bvlu/Y3nE0YMuE/TWMQeMPRHS
 jH+P0OtjHEQKa1xv4Rq/g==
X-ME-Sender: <xms:tdfJaJjoeyI_kWGtQElfTKVVC0bzYtCutV-SKJ9S-EEjHiz03rf20g>
 <xme:tdfJaIemcwe1AthosdXab1blRKNe__1tW3LawI_iqEHPzORCWZM7wTVT6HC52nlaF
 qGDG-2wI_UMeydzTA>
X-ME-Received: <xmr:tdfJaAmwufxsqwlUtijp1KdCYOkaK7kqkcV2EIZKihNAiDITJzIpfWD7YjuudwZ271NjTp65qJBacfybi7CLKeJ1Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudeiiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepudefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdho
 rhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhgssehsmh
 grrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhi
 tghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghjihhtrdhkhhgrph
 grrhguvgessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdhvrdgrnhgrnhihvg
 hvseihrghnuggvgidrrhhupdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehr
 vgguhhgrthdrtghomh
X-ME-Proxy: <xmx:tdfJaFwrdALgKAvZb2IPRuPZgPMjpOFPykCq8t7Y9_oDeh5ZZj93lA>
 <xmx:tdfJaLy9qJCVWFbqPT1Qv4ASrrNmIqjVNJE8XaSEwUinS-a1MSVsxA>
 <xmx:tdfJaNW7ibyvq6dmYffXV2WyeUsuDZE2d9MQ9k1KNoS3H3UDTwWrAA>
 <xmx:tdfJaKSjbPHDagVYlylP00V3fXUg1w6KjWc0qmFnHsf_QMNOiSYKyQ>
 <xmx:ttfJaJPCYUW5J0SwBbLSJoLV1EdBi-3AUs5xYDDH69pf24dSP7q1OeD0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 17:33:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, mb@smartsharesystems.com, bruce.richardson@intel.com,
 ajit.khaparde@broadcom.com, jerinj@marvell.com,
 konstantin.v.ananyev@yandex.ru, david.marchand@redhat.com,
 maxime.coquelin@redhat.com, gakhil@marvell.com, viacheslavo@nvidia.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 1/4] mbuf: record mbuf operations history
Date: Tue, 16 Sep 2025 23:33:38 +0200
Message-ID: <7063702.lOV4Wx5bFT@thomas>
In-Reply-To: <20250916141731.4e140fcf@hermes.local>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-2-shperetz@nvidia.com>
 <20250916141731.4e140fcf@hermes.local>
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

16/09/2025 23:17, Stephen Hemminger:
> On Tue, 16 Sep 2025 18:12:04 +0300
> Shani Peretz <shperetz@nvidia.com> wrote:
> 
> > @@ -607,6 +608,9 @@ static inline struct rte_mbuf *rte_mbuf_raw_alloc(struct rte_mempool *mp)
> >  	if (rte_mempool_get(mp, &ret.ptr) < 0)
> >  		return NULL;
> >  	__rte_mbuf_raw_sanity_check(ret.m);
> > +#if RTE_MBUF_HISTORY_DEBUG
> > +	rte_mbuf_history_mark(ret.m, RTE_MBUF_ALLOC);
> > +#endif
> >  	return ret.m;
> >  }
> 
> If you made rte_mbuf_history_mark a dummy function if RTE_MBUF_HISTORY_DEBUG
> was not defined, then you could remove most of the #ifdef clutter and
> would get type checking on normal builds.

Yes good idea!
We need to check whether an empty inline function will be completely
optimized out by the compilers (clang and GCC).


