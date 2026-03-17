Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A026FED9E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 15:55:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C097402B0;
	Tue, 17 Mar 2026 16:55:57 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 2D1EF40270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 16:55:56 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A70377A0181;
 Tue, 17 Mar 2026 11:55:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 11:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773762955;
 x=1773849355; bh=2lK0EOVzbaYJzD3Vdc82GyeikFlI2IqbEJ/SJbp3Ju4=; b=
 YP7PSRM37FaFBfyhIJB2l/MuXnovvf2/ss/6zSUQmkmB9bQZIQ+AjHZNrGgGAl+b
 zQ714U1UTpm4QJD9C9Y/VIWIIQaOP3UF7Wi6Fg7gxKOSnfFd33MjRb6jR1FseEt4
 VzHAGEd5DgdRQiN2bayq7I21O2G45MLNcLNzuKYpwjzhTB/+RI5i7nokj1DMdACl
 JIcmPhDFhSuuqbR1am51VbQ9jPrne0JJBMpoX92RE+6ud2ZT2eMZ433HO3BAoFtF
 xNmkN2SMdTOH6lAtAyNyrvwhDdZBIuJ5iRgki87U54g+oWHseaXEb0aR16c7PyHb
 gmxs7nIHaA6n+su5ukj6Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773762955; x=
 1773849355; bh=2lK0EOVzbaYJzD3Vdc82GyeikFlI2IqbEJ/SJbp3Ju4=; b=a
 Zhd3hjDfzXq76XfkqSDunn36yyIdcVO446VMKsRp6hdHl+jVOnNiMNjnR137hvNC
 DVHQCDoGUziNNoPM/vjCZCUfFoLMdBZBv/t13rIsE/q1ic5f20V/R9vHDovxaUjW
 2CKbKhb2/5lNRLrMvXPUmX7fjaAFOAZpvba4zCWrTxOa0ePfe3P1rFiPg6Un6rc1
 YqHCeoErBUevHLgI/J2KPN9WefEzU0DEfhcnzzuo7PGVYOlZ8oS6urvWEV2B4Yh8
 dXXs4NfoHbgsx3tqqQUTOMQMGpM760w5k57AZYvaM4H4Bcp0ie17qgr6nqxOIUgh
 xMIiMXtXFsZf5lFYZ/aLg==
X-ME-Sender: <xms:i3m5abPdkOjqL_ixKHpMK2IV1duhH-2f9cLguOCzG7xmj7VQ40z5Xw>
 <xme:i3m5aSQkjIkwpRbq3SyOziIp2E_pz27J0CKaZ5UCdx3V7AluJ0sk4gG87U3iLpJL8
 UospUW7dgAIz8uNq7BwgKjzthe8CfAGSJyRVsiX66ELrX1T7iZzJw>
X-ME-Received: <xmr:i3m5adDEUhFEYSK9m3BfSpttYIw36X89x5qHkDpBD9Xsu1L3A1dB__gqS60s8A_FVn3hYpnAu9R6W4FZLj3tefdF5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:i3m5aRhMZGXg0CObhyGatzCgmfV8vtbchsTtM2MZkPvqJeRLrcx_LQ>
 <xmx:i3m5aWPsenL3anPYWc0IGYcpqDDiP9joNFaw1YYN8NForckrCH3RdA>
 <xmx:i3m5aS7h1Rs60WBpCU0jj2FBcMdJGSQvDTaCeAcnBHIcnP2RoX_O3g>
 <xmx:i3m5aU2yjmbr0FH5NRDW2Qy470NvcHIZRARBpZ0nI_liFp_LkLSPFA>
 <xmx:i3m5aVgYNTKbe0GmHgVMipyaSNDX5E1V69-o_6toT0Nn_z2Xtsvu81rQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 11:55:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] Static analysis fixes
Date: Tue, 17 Mar 2026 16:55:53 +0100
Message-ID: <6225470.alqRGMn8q6@thomas>
In-Reply-To: <20260312103606.702617-1-ktraynor@redhat.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
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

12/03/2026 11:36, Kevin Traynor:
> Fix some leaks and uninitialized variables.
> 
> Kevin Traynor (4):
>   vhost: fix resource leak
>   net/bnxt: fix uninitialized read
>   app/testpmd: check for no arguments
>   app/testpmd: fix fd leak

Looks like the patch 3 is rejected.
Patches 1, 2 and 4 applied, thanks.


