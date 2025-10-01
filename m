Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B6CCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 12:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9654C40A71;
	Wed,  1 Oct 2025 14:16:20 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 99A50406A2
 for <dev@dpdk.org>; Wed,  1 Oct 2025 14:16:19 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 285C714001C2;
 Wed,  1 Oct 2025 08:16:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 08:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1759320979;
 x=1759407379; bh=CsaHOeIUMGQwTi1MFpUZVK9zUA5PVeLqY0Nl6ou781E=; b=
 QUrie7vPFiDtOf8m6dKqqopFBg3ic3dBb3RAvAtuWmxirNVdq02mgTai9JeNARxr
 33t2TdWBRb7gjzVnBC3f0CtomCzi8Bc/pKcVC40KCZC7y2v/tp0JuzkAX0Bksb4N
 vU+PZ+UsTq1cUyqojj1YLlLk6oNh89sGtI5Jn01lfpSwOaa4qd1+IHGy0v2hnaIQ
 DfV4lQfHn3GTm2/uhss4NqorVTpG8evWKKoCPZMIxPyK3FlVAxsJfWlG8mExOm6y
 80mojaS2zULcfn9G3yDNVsAWynrKL8+r0v9ojpz9wbrB8G7zlkerz4dkeytUxsjv
 INYZalj5A7RNQR+CT6ou9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759320979; x=
 1759407379; bh=CsaHOeIUMGQwTi1MFpUZVK9zUA5PVeLqY0Nl6ou781E=; b=n
 7vnxvceZ/QV2H9mxR4UGedI+tC5fnVB1IlOd7vH+fUM8JYUXdm8DYx4guvq9gdhE
 PJc/SFZdlsc/tBa26GxEjQ8TWYGWR7UzfDz5b0ViYH2/HiAuKieTqQDQGSWKCb0v
 aNNptzqw1aqkxj+xDB8Az6BwEMtSJsD1zdzDbjbldAy5qkw7DFag9YPi+5XhSGfL
 VqJ/lvlsAZ4gOppyJKof62tMRfWjw9acqyK29vk9HHqmFygSMcpVCaQHf6zOtd6B
 S2xKeEReckLp8DR1PN+25URMQ4zj0aEaKbtSyzDdovVNNmQtDl3iQCrf892xRFsn
 u3upKDQfyCzsYuXQXMRrA==
X-ME-Sender: <xms:khvdaG1AGkftcDnUycxMheBU3L3pUYRBgemZnXRwaprhW8AMsW83iA>
 <xme:khvdaEiqIRVuVOLPdChDT8eZwQI1oSZzLrY_CytFRGaPGHmm1dadP0dH4uhdw3HJo
 11x-hpLJffylTpCCj5cM-oW0D78JUc7WgU1emOVO6nVhJmS5ZoSPQ>
X-ME-Received: <xmr:khvdaCZEnTCW_GHsYeml5z-6b0Wpc3A1yXc4sWfhjfOjY1NpXUkvYLNR10P6rzZPuocBS8avXStQ0RNN1Aku8qZ5uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:khvdaMQOZeBQM5uCAWTEKqF4XDFpLnaNwPTcQubl1SVf5eUGnVRomQ>
 <xmx:khvdaFT0DY7hPpsLgTQjCVLedjy1LQV9TBnqQ-RrAzdg1b-B5MRcYw>
 <xmx:khvdaASqhaBRIlOpOEERcQ6xoSEKAJFX8rKgtyVKFoYvV4LlzBXgpQ>
 <xmx:khvdaK64btjBB2jIauDP3D_BT0RTqUbRKloLJHJCd_VtIVaYJu3BEQ>
 <xmx:kxvdaF3pKxVSdXyPtE5PNOTpMhIaF5O_wlk8Aq3z0_VNenaxPYGNilX9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 08:16:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Date: Wed, 01 Oct 2025 14:16:15 +0200
Message-ID: <22593368.0c2gjJ1VT2@thomas>
In-Reply-To: <CA+-x59aZzXLWACV17OaHCyUU_WnqfdGdJqjJqMeHmLX49G_2mg@mail.gmail.com>
References: <20250716103439.831760-1-16567adigashreesh@gmail.com>
 <7068093.UjTJXf6HLC@thomas>
 <CA+-x59aZzXLWACV17OaHCyUU_WnqfdGdJqjJqMeHmLX49G_2mg@mail.gmail.com>
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

01/10/2025 12:24, Shreesh Adiga:
> On Wed, Oct 1, 2025 at 1:25=E2=80=AFPM Thomas Monjalon <thomas@monjalon.n=
et> wrote:
>=20
> > 29/09/2025 18:28, Shreesh Adiga:
> > > On Wed, Sep 24, 2025 at 8:28=E2=80=AFPM Thomas Monjalon <thomas@monja=
lon.net>
> > wrote:
> > >
> > > > Hello,
> > > >
> > > > 16/07/2025 12:34, Shreesh Adiga:
> > > > > Replace the clearing of lower 32 bits of XMM register with blend =
of
> > > > > zero register.
> > > > > Replace the clearing of upper 64 bits of XMM register with
> > > > _mm_move_epi64.
> > > > > Clang is able to optimize away the AND + memory operand with the
> > > > > above sequence, however GCC is still emitting the code for AND wi=
th
> > > > > memory operands which is being explicitly eliminated here.
> > > > >
> > > > > Additionally replace the 48 byte crc_xmm_shift_tab with the conte=
nts
> > of
> > > > > shf_table which is 32 bytes, achieving the same functionality.
> > > > >
> > > > > Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> > > >
> > > > Sorry I'm not following.
> > > > Please could you start with defining the goal of this patch?
> > > > Is it a code simplification or a performance optimization?
> > >
> > > It is intended to be a minor performance optimization.
> >
> > Please could you give some performance numbers in the commit log?
> >
> I don't think that this change can be reliably measured. The changes only
> impact
> the last stage crc 64 to 32 fold and the last 16 bytes computation. The
> impact will only
> be a couple of clock cycles at best. Reducing the static array usage also=
 I
> don't know
> if it can be reliably measured especially since it is not affecting the
> main loop.
> This patch can be ignored if minor incremental changes are not desirable.

Minor changes are desirable.
I'm just asking to understand the real impact of the change.
In general when doing an optimization we try to test it
and give some numbers.
Note we have a unit test for CRC in app/test/test_crc.c
but no performance test for it.

I'll wait for a review from an x86 maintainer.


