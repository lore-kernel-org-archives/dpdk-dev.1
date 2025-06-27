Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DDC7EE3A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4890F4026D;
	Fri, 27 Jun 2025 12:11:44 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 7667E4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:11:43 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id A0EC61D00187;
 Fri, 27 Jun 2025 06:11:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 27 Jun 2025 06:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751019102;
 x=1751105502; bh=oT6v937YHizsoKJ9XrENTgbiqxK67pYXE5RwKoeVg5E=; b=
 pE6X1NUk15I1wv8XzzwJsw54Al1DLt0UMJVmlV8c/03CdoI8Yg7AfhABqIst5D3f
 uSmtzTpbrxxfzSJY0/NBoxQrBypKyF9oM4LQATS1evhDxLlfhe7aSLLtsWCqjeXQ
 v4DckspqMPVb36XxwQN/OZ5hiaT7aOE7JOP17/JT7UU8d/gMir1vtNUx9SL7nIgL
 OY4LwxrrvqUmrvKhChi7kwsmAVDBc5Nfz/EAzub8N4Fi7ev8JqNSn/YjzKk5ZD6+
 LBru0X0H62qWavloeBM4KX9NNi1lX+ywFHk+BezZnUe58H8Qj+Hd1kBab+qz000z
 05KT4UX5deZxpR6vSqfFow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751019102; x=
 1751105502; bh=oT6v937YHizsoKJ9XrENTgbiqxK67pYXE5RwKoeVg5E=; b=k
 YZh0DeKTUQRi6KNkm8/oGxl5NUmDSpd5vWXlV6Q4DJFnot0hv5xDFQFLjKoLSive
 imsn+qYmCpMz+8g7UepFDjt+oK9iMy7qgvX3ClB+ZJNv00Ogz7+PKoIELL59otW0
 1esJrTU2Nxd+MqPc3iR0ch8taEb9hnYyjbfSJ2q+eSFPZglvriz/jZ0AQiJTx+n9
 7skAakzLzkh/uPu3Bls6uN1+ksMFRW7T4ESA2nkJ8f8UN5AttAhiJMR9A1gmJPMW
 BSUfsoV6k4iinqBMEF83mZ/PHLMC8RC9iYcckwGsdFZlPpmJfITKBIrqTat0aC7S
 AS+Or6k4tJ1i8oqM6O1mg==
X-ME-Sender: <xms:Xm5eaMobjSpX74xS1Xx15V8hEHiwvIZXIOikOVm92qgiWwxsC4oJwA>
 <xme:Xm5eaCptOvfyQa1Ti1k7t3-i_m4SCj7Q6eAOpmBfvJpYgKPG0XpfYHypYSwz3td9H
 jnQReX1B8wTc2EPcg>
X-ME-Received: <xmr:Xm5eaBOPDMg5ER7ZKuij7X3IGbOWBqGayPK1-nc6NepTmz6XESaHRlaONGWShiWPfH3CNy1Gdui4iXxx8crvPwmXoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesih
 hnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehvihhpihhnrdhvrghrghhhvghsvgesrghmugdrtghomh
X-ME-Proxy: <xmx:Xm5eaD5pSxo9hOUumLAztJlJ-F73Pik7dO3OJmDJCd48FD3_bt4pbg>
 <xmx:Xm5eaL5HFfhtIVgIrluADD7i7X4Sl4jLHZVRnua5rt1n5iOqpSMhHw>
 <xmx:Xm5eaDjckidJcDG3Gbs6sVKhO7gcA1ur3P5u3X05DdLzg3_Q9bmskA>
 <xmx:Xm5eaF6ln9FNAkW8eYvWsEBq_rtWAhQBNMB3S1X9BBFAy0QubxKyJw>
 <xmx:Xm5eaP6Ez0zS8TAb6slyNNJQX2SCXxgxVYBJzT-hMpjnbNZ0nQH0GG2e>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 06:11:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Varghese, Vipin" <Vipin.Varghese@amd.com>
Subject: Re: [PATCH v5] build: reduce use of AVX compiler flags
Date: Fri, 27 Jun 2025 12:11:40 +0200
Message-ID: <4628127.sP1CNn8AQk@thomas>
In-Reply-To: <PH7PR12MB85960653AC67A63162DC75468274A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250611105310.472523-1-bruce.richardson@intel.com>
 <PH7PR12MB85960653AC67A63162DC75468274A@PH7PR12MB8596.namprd12.prod.outlook.com>
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

> > When doing a build for a target that already has the instruction sets for
> > AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> > x86-64-v4 '-march' flags, as they are unnecessary. Instead, when the default flags
> > produce the desired output, just use them unmodified, and don't bother adding in
> > extra enabling flags for AVX2 or AVX-512.
> >
> > Depends-on: series-35421 ("doc/linux_gsg: update recommended compiler
> > versions")
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Vipin Varghese <vipin.varghese@amd.com>

Applied, thanks.


