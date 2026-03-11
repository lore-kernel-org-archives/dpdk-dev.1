Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C121125856
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:57:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F4F940A76;
	Wed, 11 Mar 2026 17:57:19 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id BC3844060A;
 Wed, 11 Mar 2026 17:57:18 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id AF8D11D00179;
 Wed, 11 Mar 2026 12:57:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 12:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773248237;
 x=1773334637; bh=G6hqOlwBJ5DXwP3Bxc8ciRJJ1hQRs/WJwZ/PIJwaBYQ=; b=
 JVu3p2zdVZrVrpoUnrbM0I+2fDb27x1dVU9m2HAsAPx+8QevpINw3MHdpyISkWjn
 4fbfb7dQ3Eo3KIkjTI+4hg7Up6Qna1IDo1H7m8kHmsh6MIorR3Q+JKCK/ZWi7jAS
 tw5URwO6yX2gTqbAqQJ1lF/aJZj5NYWlRZ7bOi7dYpr3vpOVN9P3UujvYNuaIB3k
 BAfaQkwL0DZOZ7NdDI7JIIM5jlQX5QKo994q+CXxFlhyjqmHfLAWt5pNm+dVhCoF
 DSkqCIEtAfNwIEYh6cJGoqKr8PYxJHe0PKDm416h1HcNRt6F1QsWtsMHAmsXJnG9
 pvTaXTVP+Kys5Yin1woanA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773248237; x=
 1773334637; bh=G6hqOlwBJ5DXwP3Bxc8ciRJJ1hQRs/WJwZ/PIJwaBYQ=; b=q
 W/ZCzvFJX02PeT4Ai/LGdtevmqIK0Fok13oLW0hTor12Vr0NK/UpjlN8/FgmLZWX
 vk1VL8Cp/SLjj8Br4rQ+4zhD7Ixv9akTOTHYu6l4u/CcIaEBHVxtEv7ADeIic9bU
 A6DrTHg9tGY4wsOr1mz7u7OaW6NTL2G8TKXhtKylyO/P9DOaFbqcOEkWWC5E8R7N
 pZ9N4M3wXcdJZEBjJ+Ba1UoYATwMDZCc8YnBib/9AQve0DzEL/B+mRzoevm5X56a
 78kCeaMQs5Tj5Z6ybUUs0CkDhSa7zArex+PVqTarjdwpbhDr+2qRrlM96C44KCLG
 euXsU14wSbCLD4WgtOApg==
X-ME-Sender: <xms:7Z6xaaiufWKConiWWp8dM2c9ccIR8k2Vord6UA1X1IkmVOczkNvghg>
 <xme:7Z6xaWeb5NviY8aNwRtR_dUU7bZuW9hXe4A0rWiTv5pOja_CHqpZSSnIUuXAvjkzR
 0zgHOAryix7YXYoSNchTzgPTiBGUKIguazOLMGuQTSq12iw95r2jA>
X-ME-Received: <xmr:7Z6xaVnI0yDDMopvfJ-UMtWzMUuhq-jQJmeZB2F36Tvbj9TFKvS_HREV5e18y_LcMU5ceAMy-ef17dhVIOQvDVYuQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeggeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmohhhrghmmhgrugdqshhhuhgrsgdrsh
 hiugguihhquhgvsegsrhhorggutghomhdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoh
 epkhgvvghgrghnrdhfrhgvhihhohhfsegsrhhorggutghomhdrtghomhdprhgtphhtthho
 pehkihhshhhorhgvrdhprggumhgrnhgrsghhrgessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:7Z6xaXsqZTtzRQYUBGXRpvtmctN8v0QFOXLc3eULji3-jdOY9N3omQ>
 <xmx:7Z6xaT8rtKSYn_YT8jujwE5DNlMW5wNxJv2s4XhaLPb9WpMo5oe2SA>
 <xmx:7Z6xaRMuRgUHC7fGLewjoBQ2lz-euYMLEOA5Yme_-4f0TL8Zxagw3A>
 <xmx:7Z6xaRFt4HRYX5uwkTYx1imKkKrycdOMUHTSFapMNCiV8mnjJflkXg>
 <xmx:7Z6xacTirEnuPsb4_GeZ0fHsI2vgTDP5zNG5GG_LLtgwdw5fqZDuHkr0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 12:57:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: Re: [PATCH v3] net/bnxt: fix clang wcomma warnings in ULP
Date: Wed, 11 Mar 2026 17:57:15 +0100
Message-ID: <5972273.DvuYhMxLoT@thomas>
In-Reply-To: <c17fda9f565e7e5b9ef2a19cc6716aed@mail.gmail.com>
References: <20260227195410.70511-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260227200025.70591-1-Mohammad-Shuab.Siddique@broadcom.com>
 <c17fda9f565e7e5b9ef2a19cc6716aed@mail.gmail.com>
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

03/03/2026 19:02, Kishore Padmanabha:
> Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> 
> Fix compile warnings seen when using clang with the -Wcomma flag in the
> bnxt ULP driver code by replacing commas with semicolons.
> 
> Bugzilla ID: 1807
> Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique
> <Mohammad-Shuab.Siddique@broadcom.com>

Applied, thanks.



