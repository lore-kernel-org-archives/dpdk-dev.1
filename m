Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A89CD37AC
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 10:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A205940278;
	Sun, 17 May 2026 12:01:18 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 0FE964026D
 for <dev@dpdk.org>; Sun, 17 May 2026 12:01:17 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 01B927A00AD;
 Sun, 17 May 2026 06:01:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 17 May 2026 06:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779012075;
 x=1779098475; bh=1Zp1mWpgM2WQXUm+SeXSiPfDchaq6W5d1+ztSywQizk=; b=
 TarF8qyQWRAukpmKiXa3sWNYkKnC6EanfZ7tQp5c0vRJO2v5ctR5LHKLuQssrexJ
 13pihEQ7ywWoREDQlvk9wVbJ5XMoA+I5zI6kuJinlTAlkeyEm3AsZuaovNgdXdH+
 j3UftCJlo3qu49urG9dhANRba+q+WXHT5hHsyNorF9qHgX8rSJCGs3cC6U4YIyO4
 J8+2DuMWX2ZIG+1pkgZUMKytoTp0gnezrJRmEWNOrVIdJH6XN/n3o7l+N+OHQXOg
 TKIx6RRcXYQuZhYo1ccORbSonFSQT/D1J5prEclo3aK65m/29MM1ulrXWTdZvaaY
 rRMVGmQpdkUfDt/5L7HdWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779012075; x=
 1779098475; bh=1Zp1mWpgM2WQXUm+SeXSiPfDchaq6W5d1+ztSywQizk=; b=l
 12NchciTlpjucTXw1o6Qu739uGIeTxBuKREGaUInxGxO1t+Xa0MQYSZwDfG4/Pv6
 y3CY0uJkeXqv8mgRt75vq2lNZ0T5EgO+6TzzLgj3pKnc37FLw6lPMqgD70IJ736Z
 hcKGaIY6sNQR4pmmEHefsWKWx6lgeSEUJjz7ScL13zrBYLfVI24U2DX4tfcGaux+
 Lum7hajmW78WAh157XFg/71LlXxs1OqrJNoCepkdj3/D7BPgFxFSWhW6c+cBcpou
 EZEe3L5gvMGJFhXVbOK18/a0j8DZhrSmTRHerq6o8ge/0Vas4qCwiJvajIZFltez
 Acu+zH/FLaCpO/U34K8vg==
X-ME-Sender: <xms:65EJagRWjjj0SU7JCT_GjUM67WFQN0Rcv_JeeLwHfCfeQcb9Mie4qQ>
 <xme:65EJali7XKK3mrh0qtKBDrU0hsBb10AD2Fh8gPEK5IzXQq_baEQHkN6hsxaJqIR5x
 Qrv4fWISHFoFBW82kTQvWSVDz1Dn22qRyo1FkPToVYAHnlJ65Hw4_4>
X-ME-Received: <xmr:65EJag5QTuEuPsOnMlS_vgU_Qy-WJT3Cu10VUDv-8AIIrVHt9fCKLBQACbNB8qBzXMrLkuI99-AcudsY_C4ATG15WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeehieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghnrdgthhgvnhhgfhgvihesiihtvg
 drtghomhdrtghnpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 rhgrnhdrmhhinhhgseiithgvrdgtohhmrdgtnh
X-ME-Proxy: <xmx:65EJaiArvkXJocbyv6Nu5wjidFCiauieA7OkEdQ_toTRvKcvlk_dzQ>
 <xmx:65EJanYmCnwDmZGXghPU4mn5iuRmaIiXxY_OuUjjeVJWoNirLyigKw>
 <xmx:65EJatYk1xp6CxsERSAW0sjwJlsjj6DEEIr70-jLU5mm9ZA51JFLyQ>
 <xmx:65EJau8A5a8aswqZwPfK8FtyrGq7BQDlKRAnm15IjGA4Or46X704Sw>
 <xmx:65EJal5cY86tn0rzyqX5uZAA423ypqh0uM_kthDZTmRk0rrPC3usRps->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 06:01:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengfei Han <han.chengfei@zte.com.cn>
Cc: dev@dpdk.org, ran.ming@zte.com.cn
Subject: Re: [PATCH 1/1] crypto/zsda: Update product name and maintainer
Date: Sun, 17 May 2026 12:01:13 +0200
Message-ID: <vUx6EBCfSDqE8kaiyvaYVg@monjalon.net>
In-Reply-To: <20260515081212.3565572-2-han.chengfei@zte.com.cn>
References: <20260515081212.3565572-1-han.chengfei@zte.com.cn>
 <20260515081212.3565572-2-han.chengfei@zte.com.cn>
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

15/05/2026 10:12, Chengfei Han:
> Correct product name from '1cf2' to 'Neo X510/X512' in PMD documentation.
> Update maintainer for ZTE Storage Data Accelerator (ZSDA)
> 
> Signed-off-by: Chengfei Han <han.chengfei@zte.com.cn>
> ---
>  ZTE Storage Data Accelerator (ZSDA)
> -M: Hanxiao Li <li.hanxiao@zte.com.cn>
> +M: Chengfei Han <han.chengfei@zte.com.cn>
> +M: Ming Ran <ran.ming@zte.com.cn>
>  F: drivers/common/zsda/
>  F: drivers/compress/zsda/

I suppose you wanted to apply this change to the crypto driver as well,
not only for the compress driver.

Applied with assumed change.


