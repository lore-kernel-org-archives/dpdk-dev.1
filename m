Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80747CD4F4A
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:57:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A714E4060A;
	Mon, 18 May 2026 15:57:50 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 05C2C402D9;
 Mon, 18 May 2026 15:57:49 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8ECB414000DF;
 Mon, 18 May 2026 09:57:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Mon, 18 May 2026 09:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779112669;
 x=1779199069; bh=g+Ch58L59MSmx9ncn7wVduaK2DG+V+t8VQKnG0Kvxrk=; b=
 f611mZ+ux+wHydUU6MChi5STtufemwZAcOMpMohxtUp3UEFY9iwP7ZWcm63RLiFv
 Vh+R/LGI0Rl+ikKWrl2ZB9c3aAUftPKMsPnaLp6d3EspJmorcV2TKp0JbvJtPtkv
 rApCvKb2lcP+mhNS13F2upNSda0yrmMNebhv+ySd8C4Ljl2jjLbfW3YXJoTHpLaq
 wSaWggjlm8FoW4rHOmxmKmmjgFxmpj59q7m2x7NUbsSDTWP6vz0AY9qftc9rpzVF
 HlwwN14gIpbiJkWGDsn6T+rhsoqcoOS5a/WjAqDFHTk/Tc2yL3t+24ZAJ8ZtFkZb
 xD/VBPdapa77WbvNF+YvdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779112669; x=
 1779199069; bh=g+Ch58L59MSmx9ncn7wVduaK2DG+V+t8VQKnG0Kvxrk=; b=C
 8nb4Ebqb5oJPkOdjvx76D1YvIwcpllbs2z2+tTvUX0UimFSyGjMQ3RbS1zE3GQFC
 hE2TwT4S86pYTQ4ZlItgvwNDn0L8IKIqNXW+g/ui0hE6KxUQQt8l+8kpeXf6s5O+
 0eheJxgzeGPN1xIeOTtiXQwFcjO8HGAks09By9rCj071Vj9M8CC9EoZXK7pDbs1d
 3tWYXYeuERwMLCKlpIWA5QGn2cJaN5c7qdy4Kn4xRUfmUrw8vvQBMkfAqvONRBjZ
 zRdZilNI6vvPWWmYfmXFuHBtTH9XDl0guApqWfdhkhNhGtgH44yTkeKeOS+3E9a8
 XiGCd7elRFU0OkfCpjFFg==
X-ME-Sender: <xms:3BoLakD68m4icdBg9G2k3zMCOV3J11PedWr6tEWYImJ_5H6cjB6_zQ>
 <xme:3BoLamqO28f05uB72aXt2fjI8V3uTDK1fXQFRYwNzapQk6BhkXG_eap6SxjwTJor3
 MXW3Cm8JJyuoSdFHHsT101fo3JmhK1XBM4TG6VAsSTIs-4N93zbB9Q>
X-ME-Received: <xmr:3BoLavjo-f2MvIdIiuZPrgjn-F493kXTuYqvVQqs1DcJXA1S3r1D_7DHR7lXEfjYZe1EKBDbZCImc66BM4inys0rNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeltdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhr
 ghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
 dprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgt
 ohhm
X-ME-Proxy: <xmx:3BoLajDCheJgQVLFmDicTZWPClD6AutCrWmcbdztUBa-mkdQTBIdnQ>
 <xmx:3BoLakHclLHV3dbebc-xwjfFY_aOuNe1ZELRCNK0uFO2RzOFejaghw>
 <xmx:3BoLarI7UJ3b92OcmMWZlLRa06emX8V7lRIQE15sWo1LC4ottLb4iw>
 <xmx:3BoLaomMJCJhLV1coJ4m0eE0QI4zOX_utpXCXTL1zJtG1tYr7MbBSQ>
 <xmx:3RoLagqF0jMFARJXzXZXyCjaqK0yknUkMoaXB_vKU3GH2qfwaX2X5gJJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 09:57:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] spinlock: remove volatile qualifier
Date: Mon, 18 May 2026 15:57:46 +0200
Message-ID: <6w2XzSnBQLCrgX3KnE_K3A@monjalon.net>
In-Reply-To: <6261630.31tnzDBltd@thomas>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <6261630.31tnzDBltd@thomas>
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

04/05/2026 11:06, Thomas Monjalon:
> 04/05/2026 10:37, Thomas Monjalon:
> > The user and count fields of rte_spinlock_recursive_t
> > do not need the volatile qualifier
> > because they are only accessed by the thread holding the lock,
> > which already provides the necessary memory ordering.
> > 
> > Removing volatile aligns with a C++20 deprecation
> > for increment and decrement of volatile variables.
> > 
> > This issue was seen with GCC 16 which changes the default C++ version
> > from -std=gnu++17 to -std=gnu++20.
> > 
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> I've just found this has been discussed 4 years ago:
> https://inbox.dpdk.org/dev/20221221083717.135c3f81@hermes.local
> 
> Stephen had found some comments issues that I will fix in another patch.

Adding the compiler messages:

rte_spinlock.h:241:14: error: '++' expression of 'volatile'-qualified type is deprecated [-Werror=volatile]
rte_spinlock.h:252:21: error: '--' expression of 'volatile'-qualified type is deprecated [-Werror=volatile]
rte_spinlock.h:278:14: error: '++' expression of 'volatile'-qualified type is deprecated [-Werror=volatile]


