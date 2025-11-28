Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C949BD116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:44:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E93C64013F;
	Fri, 28 Nov 2025 14:44:52 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id F1C0D400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:50 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 512DBEC050B;
 Fri, 28 Nov 2025 08:44:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 28 Nov 2025 08:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764337490;
 x=1764423890; bh=2i1oUjQjm/k6jI/pwv7PIzlVvCgd7lW1w9gjIbkLyIg=; b=
 wvsTQ3p6ZJbhIAivvqdm4SCDtlWzOyVuOf0IY0impft/TIe9aqal25DZVPScegnT
 jn1gCl/3fnULqCn2f3QCPmN8zdNuweBv6GPxj1h4IAL4bAbBuX0NUswxTXItfuo1
 6DDCa3FCzcM74CQisHKo6o+qb0ZtDrhKqkc9C4UxjyP/yHIaH0eaCpYMsiyfLfxA
 ySXOCbhwexnkhOeGFkcMpC86PSwx9yASAKHDut0oO1+Ee+CH9BUbB2yqzSIY2THs
 GIjzdr548d/6v2kfFFKxrdFAwkdMDj/4n36vxTIWcH/bxeooT7vkW/0thEU4KKpS
 sdF//DQXawFezXxyblM3Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764337490; x=
 1764423890; bh=2i1oUjQjm/k6jI/pwv7PIzlVvCgd7lW1w9gjIbkLyIg=; b=Z
 UhU4POwzBlwHI8pPQgAinyyc7fF6Vnx7QFEmyn0OxeG3X8YLqdq9gENu/D28IiSY
 Z+1u1oat/TFkICRhcg6IvFmw8z9mBMfxXkksd+G7/y9x19x3Qwuv6yASwY9ZFA46
 /oMzc5pLB9SCfoBRMpd89wsQ7OR2aZBaM2q0p6N0gCuZbzBnMSxNgnz7Zz5dSVl2
 5g8R4OH9321gNjye7NkKle6C6weymdpf4yG5+jghQS14r5QP5JUXb9yKkT9uUqlY
 jKkzX5ZGvBvg085bRZyXMblzH5LD2Xya2VYwN3L8HWo60fkaXIuFHjwmrJ+x0oTU
 p1Bw1WttJACjCoI7Qu2xg==
X-ME-Sender: <xms:UacpabgiXzpW9aq3nk_SW3BpUYKStJcP_wKFsCE3ujoqrhsXfIE8DA>
 <xme:UacpaYKZ5O_M3195_sTcqyuiuJNmIZ0FL2tPj8m0p930Pe6KqKYXEDoehpnINOeCb
 E-_QaTnVwb17wtWctvZ1n_llREbhng4NwmOxBWOYeQgrRk8rsfiJQ>
X-ME-Received: <xmr:UacpaTAy6zNPkD1xRezbzkh_WxLfWFz89OiDNrqWTwxTwGFVRjNR2fxjt0V-xGxDAsAnxwDx2xAz40qKq-1Gc0fQWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedttdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhi
 gvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhr
 tghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtg
 hpthhtohepmhgrrhgrthdrkhhhrghlihhliheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:UacpaQg_qrEFCk-1mky_4m3NcRdKhBJX2Gb-A_lHM3FZCdY57rKpXA>
 <xmx:UacpaTkUaBN8sKPz67j3-glqmo1PVj9f2PVj99m7991cYOtYpqONvQ>
 <xmx:UacpaUrgJ7GwmA0ZasM2ooPDNrt_lsGGRs7UUTkgk2hFiTzfS-upvA>
 <xmx:UacpaUEx9t4JYa__KuRnWxmE5Z46q4UBuXAYcB6cmnQkiNaDkekOsA>
 <xmx:UqcpaYJKI7W6YonrcTz4-3E1sWWUKMZnnEt3NmtYsnDy7Ly5gUERCfVp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 08:44:48 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH] maintainers: update for BPF test coverage
Date: Fri, 28 Nov 2025 14:44:47 +0100
Message-ID: <4203552.44csPzL39Z@thomas>
In-Reply-To: <2eba644eba404147a57bbaf333bbe6dc@huawei.com>
References: <20251124181123.3427921-1-thomas@monjalon.net>
 <2eba644eba404147a57bbaf333bbe6dc@huawei.com>
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

25/11/2025 09:36, Konstantin Ananyev:
> 
> > When adding the directory app/test/bpf,
> > the file MAINTAINERS was not updated.
> > 
> > Fixes: cf1e03f881af ("test/bpf: add ELF loading")
> > Fixes: 81038845c90b ("test/bpf: add Rx and Tx filtering")
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > 
> > ---
> > 
> > Kontantin, are you OK to be the maintainer of these new tests?
> 
> Yep.

Applied



