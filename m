Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA5CCA474
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:55:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA71440684;
	Wed,  1 Oct 2025 09:55:27 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id C11D9400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:55:25 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 30951EC01BF;
 Wed,  1 Oct 2025 03:55:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 03:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1759305325;
 x=1759391725; bh=/hyV+JCiMd6r5Ho3OAjpnTS7vqVwv5RgmYY2XR1IEQw=; b=
 OHiz3w1odmsI/v414tuXtwMt2ibt3TbUGeWCGtq8aQeayX68BPxT+VaVzOfWWp0G
 1wmVLcm7FmLmKY+BYoBf0EUCGdzHZOwZzz0fSioKqojl37YJvpJ3DDvzGBzcPRUP
 ZloY13OkwYrw0wqpjQDTUkbe1F7GvtE5Gpuu+dXcIrcSLMHnFFFFdBfmpt1GONCQ
 rXJx0sRq6yF051m+4Z78NrqlBF4kd60XJT9CcIJtOZoZXbTBA3bKWwgDz+/98DYw
 X57lBSW1r4rp4rLlvbAxfPvS83VuI9bAMzImDzBcxJ7cV6NpU4hzPxxdxNtzVVMw
 YJd3evMfLGaNi8ejxTh14w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759305325; x=
 1759391725; bh=/hyV+JCiMd6r5Ho3OAjpnTS7vqVwv5RgmYY2XR1IEQw=; b=i
 tp3Z8Xp2EFbuH1hKw32vnogLflU0tCzs7fSk0t+dZG7rpe+E9psjgB3qbXoD/KZw
 1JquXEH329659xA7SYCq/GGiYTK7Q/9NsbiNXCVf0stejehWTAi3OVeKEKqLKOE9
 6DRtbBK9SXVz3eFMLSNUVOiQY89ghFDvGfV2N3RMzTyJGwbeh+l3R5Gw2YquRLmw
 3ZUXk2sg88BIOjaPp6bT6nryjPqON1HilUeTGkzGCp/eWg2OA06fZkW+5JBh7bd0
 IiG0AfkRIGm4k+lHzkpkLHiDN7365n2gmRR6Qn3+Ezv8HK9MniP+YVlArMf2n18F
 ccfHIireR7SOGcsTC5l9Q==
X-ME-Sender: <xms:bN7caHu1V7axZ-mNrkiH6VFcOEaUW_Yzj_etrBRRbVGBrcy6wkOOxw>
 <xme:bN7caD4VX7ZZtuTV-m7Mievx_lsmUZrwZsMF30jbw-Ekm3yu7cveZJrJOY0rJemtm
 5fxvV9Z0HB1gFPzjO-l1ZWk-1171yclyjrPE5EydJwgWRQK2VIr9Q>
X-ME-Received: <xmr:bN7caOTSpPQm5uXYEU6uinUny0KlWIKrgZr2Hp2TsRyvvM7FcSHIeS_2Wcyxt7huD4RrjbTHiIlzUk0srlJYi1cheA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvdehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepudeiheeijegrughighgrshhhrhgvvghshh
 esghhmrghilhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhes
 ihhnthgvlhdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrvhdrrghnrghnhi
 gvvheshigrnhguvgigrdhruhdprhgtphhtthhopehjrghsvhhinhguvghrrdhsihhnghhh
 sehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:bN7caKqJA33dwXSUVflOCuOxBYJwwSF7-3C4yQqWG39KQesrw4jdQQ>
 <xmx:bN7caELs-l8cJ8gtoZhO9NInAIPkPvs90vCjlz6D5YMv6Skkd7hgaQ>
 <xmx:bN7caFoOk9ysOEH9Sr5GhKgUyRU9qnnt_t0qS8VCWDNhA4EtF3WPvA>
 <xmx:bN7caEy1j4XnBlCbIOWtruh53rSvlm5jkT7hDGaKRKPnIcG6HefRxA>
 <xmx:bd7caMO_9OMzhFZIFxZBVFFZVmdWNjfQDRF6DWWFr6jzB1AvK_h2YJ0z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 03:55:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Date: Wed, 01 Oct 2025 09:55:21 +0200
Message-ID: <7068093.UjTJXf6HLC@thomas>
In-Reply-To: <CA+-x59aDXS9-G=Yx3bUHj=XQX2Tjavkihu0w5r69P62y-g8Lpw@mail.gmail.com>
References: <20250716103439.831760-1-16567adigashreesh@gmail.com>
 <2664319.yIU609i1g2@thomas>
 <CA+-x59aDXS9-G=Yx3bUHj=XQX2Tjavkihu0w5r69P62y-g8Lpw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

29/09/2025 18:28, Shreesh Adiga:
> On Wed, Sep 24, 2025 at 8:28=E2=80=AFPM Thomas Monjalon <thomas@monjalon.=
net> wrote:
>=20
> > Hello,
> >
> > 16/07/2025 12:34, Shreesh Adiga:
> > > Replace the clearing of lower 32 bits of XMM register with blend of
> > > zero register.
> > > Replace the clearing of upper 64 bits of XMM register with
> > _mm_move_epi64.
> > > Clang is able to optimize away the AND + memory operand with the
> > > above sequence, however GCC is still emitting the code for AND with
> > > memory operands which is being explicitly eliminated here.
> > >
> > > Additionally replace the 48 byte crc_xmm_shift_tab with the contents =
of
> > > shf_table which is 32 bytes, achieving the same functionality.
> > >
> > > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> >
> > Sorry I'm not following.
> > Please could you start with defining the goal of this patch?
> > Is it a code simplification or a performance optimization?
>=20
> It is intended to be a minor performance optimization.

Please could you give some performance numbers in the commit log?



