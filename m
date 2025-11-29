Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A160D116EA
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 21:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 329284013F;
	Sat, 29 Nov 2025 22:19:15 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 05D96400D7
 for <dev@dpdk.org>; Sat, 29 Nov 2025 22:19:13 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 6B68DEC09CB;
 Sat, 29 Nov 2025 16:19:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sat, 29 Nov 2025 16:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764451153;
 x=1764537553; bh=O4VlEzWnKEkr6TmOaYraiar4h50RTHXc/UpEHLmSpjY=; b=
 qEqYtvF5FfvWMfl4X9qz4RyHzNs89ALx2VZH3Is9RW0vx516HlUNZ57FfQ5ZpxNI
 YDj/6GdQo28a8fofWmNOK2+nQyw6krjTrampgzc2YKIDKRH83jX4AsJSJFFqKV/W
 6XXvlZlYMQLmsior6ZSIocFTnv3WWHziQd/0A+VsTMdexNQsdfjlPT3KN/mDP23Z
 D0vCqQ/HAjNscaa8nnmDfhPUInltVRI0MvrLDMrNySoohjWBtzJvBrD4DXvT13fS
 XXDWFuIDM83n6keqQkWl65mq8f7/QpGlyLVOSKmkvA8beoJnB8hXGz/BTJ5zIQ4M
 oRjsEpsk2KY1ehW0JBJLug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764451153; x=
 1764537553; bh=O4VlEzWnKEkr6TmOaYraiar4h50RTHXc/UpEHLmSpjY=; b=e
 Z0/J/zHpVeA1/1NxrvHez0CpB1QhvNZ9rj5ytxgg9qdMCb7uYSUV6wVS6WgZBhuT
 KL0p+A47WartNNophePWNgXc/EyoCsJYWiGhYcMuk62EfA3bCiAsOdGNMXHKVHF4
 EjhIm8ZOGvO2U3rakK7+horObVkj0/nMQw308Ykb4ihPgEMjEX+kdA0xkNaUP7UT
 q52DnHKfDDoG65MYxSpio22Frs5M2bSU9NxSFcAfX/MbYuzkLodFla8iIGsBl6FB
 V9sNGMlc8iYgIIi+iEsQsNDPKlcaeBs6hzgxyETqchT0t4t8ZGLCLf9BT0s0cpo5
 j76mMzHqn30Dz4BqHnOAQ==
X-ME-Sender: <xms:UWMraWx3S4clDlyPVC8i4q2g2eXw0ty6P0hy2bcq0BRARRgfVDpHsg>
 <xme:UWMraenNp-lTzdR52CdjJwnr8whrCAq4TB_AA19xMUUp9Ktj3_WqPczhMy6ZGDU74
 ENzkpr16hJk7R_I3sdkZrUP6aE4HL5HI5e5wIELrnOTKE09YNeeTw>
X-ME-Received: <xmr:UWMrabELPS9ReDSMpVJ28H8hE5a9VETGRzoFT-fafv2bu62di9wwT6v9toq4sv6kuedVPobi_8YTT1-3Ob0zPpAekQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefgeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:UWMraeWfPhOh8Lvzf2VxUu8VDg3RvAVUV8_C7Sv1br4xPP2SyWU3mA>
 <xmx:UWMraazItqZUwuJrekSIRBYRAIIxi4QZuvLaocKSMVb51QfpVJpqfw>
 <xmx:UWMraUNCiIJl3LbFkBkPcqwoeErbPbgoojqesQlgBTmjOLtwcWm_YA>
 <xmx:UWMraT7mFhnXa71O_PEz_4goBLBbt7jOBTWLhCyjLHaey_SGUKtlLw>
 <xmx:UWMradaopZvYLUwErKU1WHS7f8GSRFugGNVxdUuQFguuL44uKjQnHjAg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 16:19:12 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools/test-meson-builds: reduce output size
Date: Sat, 29 Nov 2025 22:19:10 +0100
Message-ID: <3862442.irdbgypaU6@thomas>
In-Reply-To: <20251020155536.1965938-1-bruce.richardson@intel.com>
References: <20251020155536.1965938-1-bruce.richardson@intel.com>
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

20/10/2025 17:55, Bruce Richardson:
> The various builds done by the "test-meson-builds.sh" script can take a
> large amount of space on disk. Some simple changes allow us to reduce
> the space used significantly. Specifically:
> * use the default "release" build, which does not include debug
>   information, for builds where we won't check ABI.
> * use shared linkage rather than static for the 32-bit builds.
> 
> After making these changes a set of builds produced by test-meson-builds
> shrank from ~17G to ~7G on my system.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

I agree with this change. I had done something similar 4 years ago:
https://patches.dpdk.org/project/dpdk/patch/20210808125139.3573701-6-thomas@monjalon.net/

My patch was also adding build types "debug" and "minsize".
Now that clang is fixed, I will work on it (requires fixes for minsize).

Your patch shrinks the build directory from 20G to 9G in my setup.

[...]
> -	config $srcdir $builds_dir/$targetdir $cross --werror $*
> +	config $srcdir $builds_dir/$targetdir $abicheck $cross --werror $*

There is another call to the function config() for the ABI ref build
which requires to add the new ABI parameter:

-                       config $abirefdir/src $abirefdir/build $cross \
+                       config $abirefdir/src $abirefdir/build ABI $cross \
                                -Dexamples= $*
                        compile $abirefdir/build

Applied with this change, thanks.


