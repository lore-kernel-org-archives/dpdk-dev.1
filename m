Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295E0CD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 11:19:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44DF040296;
	Tue, 19 May 2026 13:19:10 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 7A5614025E
 for <dev@dpdk.org>; Tue, 19 May 2026 13:19:09 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 408527A00B0;
 Tue, 19 May 2026 07:19:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 07:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779189548;
 x=1779275948; bh=M+quFJ1GpefLQMhTOb2g0nto550SmaIteZik+tQRdHI=; b=
 EjHbI34udTA6Fl6lNOow2GaC9TXXY9ullNCcaZnko0wUw++k1Q2vi3Siq5LrwGwu
 stK+IqAKRA4Gev9Wv2upFT15VI4kXbf6fv/cHnaXfzIXJLVwfYu/SAQ7eT+T/5Kv
 I7inUm4TouKdRomsg9tOvmpz+3Z4oOIDPrTWayDb8Pk+v40Qz1wovW4QyyUs44nZ
 O2+uv9FoOjzhrrh+Sga7OpPojLHTHV9tAuks6kzG1ZZyPTeUi9pfzdBYGeDqAxH2
 Dz6WDYXuNBn8fZhtdEBRk6KTiCQUSgY9ndFC38zYj1ZI/Sqzzuav9Ooi6zXF9Blc
 H9uSx58Pj8Shr8xUtFo+iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779189548; x=
 1779275948; bh=M+quFJ1GpefLQMhTOb2g0nto550SmaIteZik+tQRdHI=; b=h
 LTIl1nYxrKlQz4h7T6GJjcA40e4+cpxlFU/GyGVf+Ktpf3Zq/vLHZhShZ6O6E0Hz
 R/HsxIyug1EiDEyCzaaXjB4GgYoPp57IFAB86of98sFGD/Jn4+bcI1D+0TUguzyM
 VZ7P56DoIeydhdwwW9pW5NlXwL/3J4UDDJ00jKSGzGjJMB+kRfY9cE+qSIIr5roc
 cWABE7n5GgM+sZNW1cyzNkEBU8re3Zr7moBg62wla5WnAYt5PlguXsEVjw/qnKN1
 Wkxe8Joc1Q2ivMmzuw04gaVTBSxFO5HtKUOQ//Tho5kyZ+mxrC04EzV2ws3LH6KI
 CqS6jbBR6iy09fojbNOjw==
X-ME-Sender: <xms:K0cMahCNQTt4EJ2csZb_SF-GP-4oPeWazsleLO3RGYPul9USl7aXzA>
 <xme:K0cMaq-9-1jtlImXk6yqvJszBYXE_UP9A2yCfd4mOetWU_FUqUBLFXK0DjfcJ5Nda
 yck8TiAn6I7SY3TNHKYApRB8JFcyycrLe3c7NvTCJ0C0iLTlOAy>
X-ME-Received: <xmr:K0cMagER2jbC0xKJoEzEsk05VM9KWCTRGB1nCPLxo6Bh_ErzTTzcycUvEBJXSzkobssWISgeNY6-ArJ7hoCsVSXqOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:K0cMagMKOexG5P90zP4kWkcBoRaCysAS7DfzbqivEmyfeOe-aciP2A>
 <xmx:K0cMaieIHkvnyv_iAFnwyODCNwhI6CgMwrOgkAgtOdbeSODt9xB3NQ>
 <xmx:K0cMatss6EXoFdK44sJU-gF0i_DbQwuVqETYxp0OKIFn6X7mMjCPJQ>
 <xmx:K0cMajmYIdWoErJNt78C9uM8_cpSFajwr5ydeOWU6tKk21HMrZcvAQ>
 <xmx:LEcManIW55TsVbig19R2sdn7S0XcdSCzDTJxtElC7hlTFXVvuOA98Olz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 07:19:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH v3 2/3] spinlock: add debug checks in recursive unlock
Date: Tue, 19 May 2026 13:19:05 +0200
Message-ID: <108gdZZnQYq4Bod-5AJiaw@monjalon.net>
In-Reply-To: <20260519103640.3986710-2-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260519103640.3986710-1-thomas@monjalon.net>
 <20260519103640.3986710-2-thomas@monjalon.net>
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

19/05/2026 12:34, Thomas Monjalon:
> The recursive unlock assumes that the caller owns the lock.
> This behavior will be checked when RTE_ENABLE_ASSERT is on.
> There is an additional check for the count which should be positive
> if no corruption happened.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
> v3: new patch in the series

Forgot:

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Suggested-by: Robin Jarry <rjarry@redhat.com>


