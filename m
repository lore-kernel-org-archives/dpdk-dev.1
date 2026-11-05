Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B140606A33E
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=HZjELl6K
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4665640E01;
	Thu,  5 Nov 2026 21:32:17 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTPS id F39FB40DD5
 for <dev@dpdk.org>; Thu,  5 Nov 2026 21:32:15 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-53397554beaso22121421cf.3
 for <dev@dpdk.org>; Thu, 05 Nov 2026 12:32:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793910735; cv=none;
 d=google.com; s=arc-20260327;
 b=jb1duF0MMRPQdSfJd0orj2kexTIHFXYUK7rNhZhTr91F89LpkcIHl7amtsVlyna7er
 4fxrQwsc/7h2faxkLOxyBkJBHMRitl3pEtdhYY0Y1BpkBxAyE85Qbf/SA67BJWnjJXbC
 Q4no4xm3s7qGv4KEpzMZvwqPoGFrXXwDEDNjiXgg9NG1AG/bqbQvZkzyKd2ze/4YwIwW
 a7oSDKWsQW/XuGzgI0/dvI1vcQ0xos40fK6r+yfutrIAOoKwCzLKUsaYMo7sEVMvMUq5
 JrqCX84xrEnrHMUu9IXc2Q4yTLcDuQEyexpJMcfqczJrJH0N4rEBslGTep5jxndMZwAf
 V4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uBfgwRO3EgbFATbI/m+gh2zRglSdAku6frVWd+uhsC0=;
 fh=jyMH2+0+3pEdQQJZ1/6cI68g3jMji6ykIDvg8vmKLE8=;
 b=TN41hd9pIvPpZzqVIh9dyJ7dUSTbBTc/zq4Lcez621IJEgIPG5tPrfNcVVB1K+0xsw
 60cav5JP2AbUrg4w+cf9VtyuNeSeEC8cym3JK60wg4sAvAIXmPLAc6xYF1Nm86cR2srn
 50eA3Knzf2d+4CC9Yz4QRBv7uzvOQ/wclbm1rQOKFgF9WeCqGVJ/cNXu67eu9q/c48s/
 C765k3gQAd0We6iG+WAAo/XZs6MN8k9fxDe72FNpmxjyck1IJlCpsOAcV4JgNXbxZMD0
 SA+2VYigdn7WtPjAG1JsegtqfJTyoRwQ1i+HYE+cn0qa7SQ7WvdHroAUgJ6O9SM8zfVN
 09QA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793910735; x=1794515535; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uBfgwRO3EgbFATbI/m+gh2zRglSdAku6frVWd+uhsC0=;
 b=HZjELl6KBn6Gmd/JWtQivoLtSk4m/KGWd3yMNGZMk1oDESPLahc2Y/XDkwB7/b8M3g
 Ya/P83jUVVtPgRx846Q5lFpUlW8BFNBaXRqzOKY7s7ybaw39Ai3hM1RY6obeVOXzwxR7
 glCx87stvhT5Q+WaRReb18nuHNbr7rd4OuTuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793910735; x=1794515535;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uBfgwRO3EgbFATbI/m+gh2zRglSdAku6frVWd+uhsC0=;
 b=V94XWe2JifG2BSNKDKVzBMztVV+aqbRKG5IglaAUWlWJTdIJCLT4Xew72O9qlVvCWu
 IyedbF8RuJD0feLS63iebijCQgbe8gf8dwWSXCQ4NyB5pEYK/R0Ryfd0zwRDuc8zE4sR
 PrbitvYJdn2sqMiymcqb7dT95FL085vfIxq3v4FU0lMF36vKHayamQtNLg/PULQsy8qq
 qjJAH/D/RtGNrLsCwfsQjadBMsyeClOo9VmCigYPYoRfuDi7ZsjBwzshNtrHrdWSHDrs
 uejxGY6Al4/TfGCJ+H4+00vXYPTZu3pAZwi/Vwea2Ido7mLVeCsklXPsPhu3tqM++8Wu
 tRWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxX5SHmJfJliBZQvFoyiMroUeqnksZSm5XbXe+nw4hY/Xe2Y1JVC78Dl3BejZ/9u1G9i+E=@dpdk.org
X-Gm-Message-State: APuU4Z/PYZr5DtXohhO2lE0CotFOjY6BipGyRsrKt3/1SfNjxFnDRBME
 bOQanZrrq2uOo+bmo7yz0rrMhOUqBY5cjLPtgWezM/3//fpoow+WeFozUiyzmZwf4fbkRPaK7Fh
 lzJjmmoOlSev3PzbTWeFCZygeU2/CtXxcmZnDl9mVKA==
X-Gm-Gg: AYBFou0PFqLhBKPhXRKmPLLP2NmIeYYJkZ8y0WZQiY3aAbHpAF4wKVG4TKvUhCR9gC9
 lyrxbaWcbY4inYR/Ziu4qMM+x0adud2Ho5sYISVSfAZ1sCcRTMFqH/Sh8WE/J2ME8hYz4A3mk98
 vrR+xdMZaqEBbxqXHXS0k6vgIaAzPIIKWuZRu+96FvXXoyPAc6qCPb1TvqiLBh50IfKQKwD/Zed
 SDk5D41Eqp4mC7t0lpeY23+p1T8Lq5G//+L19SpAhDF8q8KxfR1lPfTHzS+0vsQwCFGSMyrA0zf
 Wa7S2olq1fUutS/p0baLvOspAD5j1LtC4a15RbsSkb3pG3ZyyGglfNkM1Kin9Xt/no7klbsP/Vo
 DMXxpSfY+w2fsSyIxq+geVeh2I1cJVkxwg7G2UXOz5xH0ySpI6bDfTyOaucfYO+fF7KvHFkLh+z
 VtZkDQiktxZRIWY/4OdWG1dW8qtEYmS5GCZq0qk46FrwnzjqJT1Ia0qI4xtKnkZqFqrq/+l2mXs
 M29uN7vls5TxzMqxbX6x1gOsNTwNC2R0bDU8PJA7qkluT3QLA==
X-Received: by 2002:ac8:610d:0:b0:536:6378:c806 with SMTP id
 d75a77b69052e-54e1377eea5mr8256061cf.26.1793910734870; Thu, 05 Nov 2026
 12:32:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105174137.498850-1-dladd@iol.unh.edu>
 <20261105200413.513618-1-dladd@iol.unh.edu>
In-Reply-To: <20261105200413.513618-1-dladd@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 5 Nov 2026 15:31:38 -0500
X-Gm-Features: AclHuK9fOnoi-CYRdb7tAUxzoIhCkYCltjArA7KMyUmA-zkDI0QSkYOkZuHW4oo
Message-ID: <CAKYPG+w7YPRakOaT4_twsdCcMt87YEKF4EYj+JBZM2DURqF1Pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: add eventdev API
To: Dillon Ladd <dladd@iol.unh.edu>
Cc: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, dev@dpdk.org, 
 abailey@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000001c68fb065f8d64f0"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000001c68fb065f8d64f0
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>

--0000000000001c68fb065f8d64f0
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><span class="gmail-il">Reviewed</span>-<span class="gmail-il">by</span>: Koushik Bhargav Nimoji &lt;<a href="mailto:knimoji@iol.unh.edu" target="_blank">knimoji@iol.unh.edu</a>&gt;</div>
</div>

--0000000000001c68fb065f8d64f0--
