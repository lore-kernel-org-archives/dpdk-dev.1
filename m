Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9657CFD371
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 01:22:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2227640685;
	Tue, 25 Nov 2025 02:22:44 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 6590A402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 02:22:42 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EE1B114001C8;
 Mon, 24 Nov 2025 20:22:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 24 Nov 2025 20:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764033761;
 x=1764120161; bh=i2xNY0yt+3/yWtPVPj3xc0xLD83+4fcC7yaf8T9CFU8=; b=
 tHzOvEw+FaCie9YB0HFGqF8IGqz9sW5L8Ex1mtjWDJc61zxVrOSq2ACO/dAoXvz0
 Am6kVcShHg0y1zgOdfo6QRwdEQjKNlV7NXmkPOymntHVQaP5WSIhGKN9TouNBqIS
 7AlH1ARL8DvlniYTBVR8pVSUEMPPhnVVkb38UZ7Pdlu9JiCq8o+rS1CQ1LqCHk+1
 RyvFYHpdmLzQsgj061CU5UTB+V9eaI6vu9j1g3iPhbdMZRKjqrD0Uqf/qXVWtJh8
 qqTOLP1KaPu9D4afIQn+zMNMDW8vYwaI973tX7klO8Kysu/eyVShZTke8Bs7R4CR
 8dXXn4E2TR8J2UHAGtS8uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764033761; x=
 1764120161; bh=i2xNY0yt+3/yWtPVPj3xc0xLD83+4fcC7yaf8T9CFU8=; b=G
 sZ5LrJz33FGvxLqjiqEoWnp6O6vy9woAUP6N0GFVvZEGLOyOy5GXzUt2WvSlVbi8
 bVExDBz91dG21YxFfcKgk4Ce7KOyJLMRJCG3Ki9qKQFZWvkqfMdRMXrvxyNVH5JM
 4s1+Fc7wl+JpOywSMkL+9MVm5/EJy3FbAvHFdISV31jkQcZKznDvXdnrQAkGaCFz
 cxl5dTAOrtGNbqvXscfj8TKQneM8Gwv5cWCoaRRTwJq/5zNWZgQOw39FisfZW4qp
 KO/HAMrCnBIUibGBCssuls8AaJ5enflum4iBhgS6NweOjUYBC2Je43Svdj6zfgxW
 6luEUt8dJ7lEHaOEBdyJg==
X-ME-Sender: <xms:4QQlacRKEuRNK-fq6qwz2_bRR6CJ1IGv6TyWIQu9S30MUNbdHDxgyw>
 <xme:4QQlaeHYPQ3Dw8otDes_zijhF7f_4mr4zfvXdoqZT4biF0NNmAwLwkBSpSMf-cfDi
 pWo372hgghvq-kSKbOZiFU9ApeWCDjkIXQJwe-Xs1aLRJGTbGorlg>
X-ME-Received: <xmr:4QQlaY8wMB2_11N4dprY0QtMKF-_Q6mvcHxmzKu0F_IL1o9X9SJaDTtgtKTh2pD7NeB22GJZ_CVjp7kaiwZUFoWL9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtudehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrgdrsghotggtrghsshhisehgmh
 grihhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 sghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:4QQlaYIeyzAhJQloy2pBeaGdJs6LcGwyy-fY988UM_G4SOp0WTKCYQ>
 <xmx:4QQlabbROlQdck99jM0j02nTRQW6eCA_JbmiyyYf6Rqcy6fr6NFuXw>
 <xmx:4QQlaSJSB8Zm4EY1bbxUfjNp0JPAJnJfaC_R_qjMO9JGwxEgHzpxvA>
 <xmx:4QQlaRAAooIzfTa5HuqQNSDaJIGSSHlsQP_dVZwpqciJKAwWUTl9Uw>
 <xmx:4QQlaV1jRrnrzpHykcAqLTcndw-yDKQWTctcxyPJPCV_AHEGLqtbjAYY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 20:22:41 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: luca.boccassi@gmail.com
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] doc: add install_tag to meson
Date: Tue, 25 Nov 2025 02:22:39 +0100
Message-ID: <3862772.88bMQJbFj6@thomas>
In-Reply-To: <Z3uwcddSVFDt6dNn@bricha3-mobl1.ger.corp.intel.com>
References: <20241223132220.138227-1-luca.boccassi@gmail.com>
 <Z3uwcddSVFDt6dNn@bricha3-mobl1.ger.corp.intel.com>
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

06/01/2025 11:29, Bruce Richardson:
> On Mon, Dec 23, 2024 at 01:21:13PM +0000, luca.boccassi@gmail.com wrote:
> > From: "bluca@debian.org" <bluca@debian.org>
> > 
> > This allows building and installing only the documentation, without
> > recompiling the whole project, using:
> > 
> > meson build -Denable_docs=true
> > meson compile -C build doc
> > meson install -C build --no-rebuild --tags doc
> > 
> > In Debian/Ubuntu the documentation is built separately from the binaries,
> > in a separate architecture-independent build job, so that it has to be
> > done only once, instead of once per supported architecture.
> > 
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> > This requires meson 0.60, so there's a warning printed as the minimum
> > defined is 0.57, but it's harmless, and the feature is only used when
> > explicitly invoked with --tags, which simply has to be done with newer
> > meson versions. If install --tags is not used, then there's no issue.
> > 
> >  doc/api/meson.build    | 3 +++
> >  doc/guides/meson.build | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

This patch was missed.
Applied, thanks.


