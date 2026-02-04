Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4725DE9538C
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 11:45:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FFD9402EE;
	Wed,  4 Feb 2026 12:45:02 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id D367B402DE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 12:45:00 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 64148EC0573;
 Wed,  4 Feb 2026 06:45:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 06:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770205500;
 x=1770291900; bh=H/dEkOcXLMKXeeOZF1fR1uB6zSIVwkylrvWKKlkH+gI=; b=
 IPqyqXSqvqUz9pxRois1RnZjnW1+BQYD9zdvQ6bsnS0c6T+EPW/vCCP396nuVkT5
 vbEZnS2OMR81CtG4iF8gMR46weHO3owtI3kLLksDOTMA4ykOHgd5Q18sTvMaGqKW
 BIz/8IwfirdXwZpElXijnYKZX3LbFLybIupdI5MY+YcWzd/CIFBdsTU8h3Y5B7M3
 L/9DacVL9EcbScnfyM7NR6MaNoRuT3l99PlTBilH+0jngvBcwsIzCJ7SAH/jDDrs
 U0hpFfZAWwXWMZl82CckfRXtBarC42Xu+MILy4LWM6GgCzTVDNZ4rCUuf0zmY28x
 Wmi5tKHH3GQY9oSGqT2Yzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770205500; x=
 1770291900; bh=H/dEkOcXLMKXeeOZF1fR1uB6zSIVwkylrvWKKlkH+gI=; b=M
 +ShfiKbsaAxaQe1J8S672dC/AJMjzw7z3EovOvZ1wa6D+PWYvdkcZ8GlP+oYRmg8
 Be5URLO/ZhY0zVf5kELY3yMrMF6WcgPw+/svVWni0ES5D9xmGAGi72NK/8al92Pw
 iNM3q8JnNsLRTiuzzwQqyR2YudvP6RDnVQf8ui1DxRP0nqUkOPU2MU1A7JmziLDq
 HLp+7jbSLzIMlpf1Tl+eN1lkrHndh5q5t9QbLMu48LgG3TLfUIwxCK7xekzJAiaV
 8ptYxVxmi1ojVeVfCRnaUSDsuiHpOxTc3ivHP/KA2MscOaRAlLQAqvzk3hFRb4T1
 j1vV/wPkKR9AzstX5gZvg==
X-ME-Sender: <xms:OzGDaei6rR02l8WF7FjjaL_0D7ebkR1dJPmL_AmfxUha5e94EdlSxQ>
 <xme:OzGDaX9ewTokrtG4U1zA4yZ9-teiQRRcTrbSK3i-sxORBablGvqRhH92mVKp6MsXi
 i5XbrzYVAaiOVfg629d70JGMiJMM2z0RQ9GD0EdbB5pgWCOlWeOeg>
X-ME-Received: <xmr:OzGDaRqeiFQ3OZ3OM-7CmE11Mjo4Os3MyRI3K9jy-Gdo6hHZ5yiSAj7IrP9nxtIHEjVAYoDEPktL7JRMfkJ-XC8vhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhi
 gvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhr
 khhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepmhgrrhgrthdrkhhhrghlihhliheshh
 hurgifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepjhgvrhhinhhjrggtohgskhesghhmrghilhdrtghomhdprhgtphhtthhopehmsgessh
 hmrghrthhshhgrrhgvshihshhtvghmshdrtghomh
X-ME-Proxy: <xmx:OzGDaXXun_-VmGDctA-pWRs4Z1erYOvrO_UrPr4rhgEyl2jgfuVL_g>
 <xmx:OzGDaYAA9RllBX3R27GjioKNFG35NNGB4zK6VBVh78ysJJoqQczrYw>
 <xmx:OzGDaT2msYUhrTBZC4xUPhmi7h2ruUmvgdQRIH_2HAmR2G0OYLNX2Q>
 <xmx:OzGDaS1lsBSzlsQ8h0iX80BskS9hBnsK1dm3DjEL8v8V1f1ENftseQ>
 <xmx:PDGDaU_INg5IF1E751sS-B4L3aAGJPNjawzb0K2oPqrG75bwrW-2rcCy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 06:44:58 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: konstantin.ananyev@huawei.com,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Marat Khalili <marat.khalili@huawei.com>, dev@dpdk.org,
 jerinjacobk@gmail.com, mb@smartsharesystems.com
Subject: Re: [PATCH v4 0/6] bpf: simple tests and fixes
Date: Wed, 04 Feb 2026 12:44:57 +0100
Message-ID: <4487716.QJadu78ljV@thomas>
In-Reply-To: <20260127060244.46b2cee6@phoenix.local>
References: <20251217180141.60227-1-marat.khalili@huawei.com>
 <20260127114944.35993-1-marat.khalili@huawei.com>
 <20260127060244.46b2cee6@phoenix.local>
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

27/01/2026 15:02, Stephen Hemminger:
> On Tue, 27 Jan 2026 11:49:36 +0000
> Marat Khalili <marat.khalili@huawei.com> wrote:
> > Marat Khalili (6):
> >   eal: variable first arguments of RTE_SHIFT_VALxx
> >   bpf: fix signed shift overflows in ARM JIT
> >   bpf: mark ARM opcodes with UINT32_C
> >   bpf: disallow empty program
> >   bpf: make add/subtract one program validate
> >   bpf: fix validation when conditional jump is first instruction
> > 
> >  app/test/test_bpf.c          | 254 +++++++++++++++++++++++++++++++++++
> >  lib/bpf/bpf_jit_arm64.c      | 184 ++++++++++++-------------
> >  lib/bpf/bpf_load.c           |   2 +-
> >  lib/bpf/bpf_validate.c       |  48 ++++---
> >  lib/eal/include/rte_bitops.h |   4 +-
> >  5 files changed, 375 insertions(+), 117 deletions(-)
> > 
> 
> This is what an automated review looks like when everything is good:

Does it make the author a good candidate to be co-maintainer?



