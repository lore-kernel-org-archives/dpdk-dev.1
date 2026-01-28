Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A0FD35699
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 09:57:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AE44402E5;
	Wed, 28 Jan 2026 10:57:02 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id B5735402DB;
 Wed, 28 Jan 2026 10:57:00 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3845314000B2;
 Wed, 28 Jan 2026 04:57:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Wed, 28 Jan 2026 04:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769594220;
 x=1769680620; bh=fSsJRJB/ScOaDxacJEFoxnz79u5g7ETeMdA1lm+CAec=; b=
 CSP5tuiRZzf4bq/4Gm1lnlZRaSRMKlbtaVzgpZQoRTQ7lFzb46c3+IZkLdXdzi6r
 JSWRPMN6CesM2jvAANV9ANZvpBFkBtM4vRvd71sndCfK+36LLcWnKDYTiae4mVeQ
 8WJGfEBaO3Y7ZspwnYN7cjKp9EoMyR7yGCGuYkC6ZiH25S1CLMzvcdCP+raho6uM
 vjvZ1auIKKpG825e7WRm7vR72n/dpSdhc5kEoUFZQNEe/0+1hIJ/xvgkDmMtKvpa
 EQsBPjpBVkogLAI6c6+sNd3TW03GUuMiQb5ZjWA23De1KtHene3kooA/Jo6Gvdsl
 ndhQQexOdBIY3eNowXu85Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769594220; x=
 1769680620; bh=fSsJRJB/ScOaDxacJEFoxnz79u5g7ETeMdA1lm+CAec=; b=N
 aO0YgJPjfePAok5wAT8kj6enmIPleurQy7/aGwmUwpNNMpSq3M966RImtwH1CvsU
 mV8kw+Ndn3O++RaACQW5drjm/09f2jiljRUXkAyk8rSNn8EHcd8WA7XyXwKINps3
 EbctvzFkntxknrlwrJ0C2paNwRDs9OAdoH1hITMHC07rvHg2MdS+alKXlcrD0gjc
 is5FCE5Uc0ztCKlFySveloteDUjnphMEIM2WLqtQ5WmqZUAyEFke8yuoxjfKW+UP
 UM6BCPFnBRgm2+kx9q/FvXw03RoWEKkm4AbalN95yJhlnBsbR+r1H2qU/a4nALFj
 zkfrs05uoaNBvx/LsoOFg==
X-ME-Sender: <xms:a915aZ_8hmt4Ta9l23_xLqOWb4xpABTh61j4PIv7NMrBnY9P3C6aPw>
 <xme:a915ad3qld7TiKbKNoYKveFxglYRGgzgRxNjGIqD6ACjOv9_KDFv_2Qrp-ICZgIxC
 5Q4iD0-AkmSwk8ycOvghIusf3xfxHKLUXnfUOR7TjVxnRBcaIL1aQ>
X-ME-Received: <xmr:a915ae-XZg54vPPRCMga9LwtLgo4POpPc6ok_s6mtRocYfPDGMN68yqFos-WuthBtAtvmUb2R1OCkPHPRvTzWQhlYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeftdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepfigrthhhshgrlhgrrd
 hvihhthhgrnhgrghgvsegrrhhmrdgtohhm
X-ME-Proxy: <xmx:a915aVsrsgOJSgj8VIn1_YNGJ35BjmeJ9fS_LQ1-A51ORbIafCqLXw>
 <xmx:a915aZBFnvWLSjpZHlVuUZw_4K6uQfsOpD-v1Hq71K3gsB3e9wY41Q>
 <xmx:a915aVUMw6DQG-EgWlsLlRA4haJ1DaWjXmgSXHQcZyXqwxO5acti-A>
 <xmx:a915afDTvXHiYHYQg2Xmi8jfQ-s3NL2XODVoSZ8DZNlDRY7do6e-mw>
 <xmx:bN15ac4brNWlbHuXOVOLWo7mzpn1xp-MQyvVB5hOCzwhqhnNJJcvz2At>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 04:56:59 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] config/arm: fix 32-bit cross compile with latest GCC
Date: Wed, 28 Jan 2026 10:56:57 +0100
Message-ID: <2619339.Sgy9Pd6rRy@thomas>
In-Reply-To: <63f59ea1-983c-48b2-a502-c6546f149a1e@arm.com>
References: <20260114171335.3051704-1-bruce.richardson@intel.com>
 <63f59ea1-983c-48b2-a502-c6546f149a1e@arm.com>
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

14/01/2026 18:37, Wathsala Vithanage:
> 
> On 1/14/26 11:13, Bruce Richardson wrote:
> > When building for 32-bit arm with GCC versions >=11 and using the
> > DPDK-provided cross-file, the initial configuration step fails  The
> > error given is:
> >
> >    config/meson.build:189:8: ERROR: Problem encountered: \
> > 		Compiler does not support "armv8-a" arch flag.
> >
> > but the real problem is actually an fpu-related error which is explained
> > in the meson log file:
> >
> >    cc1: error: '-mfloat-abi=hard': selected architecture lacks an FPU
> >
> > This error can be fixed by specifying an fpu explicitly, and a number of
> > options will work, e.g. -mfpu=neon, -mfpu=fp-armv8. Choosing the latter
> > here to avoid mandating neon by default.
> >
> > Fixes: e754875c296c ("config/arm: add aarch32 cross-compilation")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

Applied, thanks.



