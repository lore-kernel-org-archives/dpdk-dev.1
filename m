Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDD4EA8100
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 11:53:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7038400D7;
	Tue, 10 Feb 2026 12:53:27 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id B3BB7400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 12:53:26 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 6B4991D0008A;
 Tue, 10 Feb 2026 06:53:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 10 Feb 2026 06:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770724405;
 x=1770810805; bh=z3WWBR9zMJFHqPHcCJ6Sr1WrXtqKJoIsJ40u6kNkN90=; b=
 Kp9J2DQF5U9j3UhPdOYK0yygEqlS//ULmvnLHEpcmXXH/L4zoQOsMBKWFGMZtcy3
 g5aMnTg34UNS7De/R+m/NXyTdKQelpUb8RImAG2h7XsF8VLKdbl4BfbqOKqbsvyZ
 z7qzVXEw390Xw3jvmz0Na+D/+ZL3U4ubHzPyup1iZu4HF3WNbAbsyglby11YCSss
 tZjgi36694ABp8rQFwWBebriyJ8JXG5p5f0LkecpjmBmaPLlF9uixw4Op+H9riQr
 ju89/wl7n2cBgJBuBjTWEUnXBxNau4rNl6vihYhFfcdZJL8kx97zczypPwc3x+ig
 ydrl5hb0EL0FRORFrChFFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770724405; x=
 1770810805; bh=z3WWBR9zMJFHqPHcCJ6Sr1WrXtqKJoIsJ40u6kNkN90=; b=J
 kmFxZegrlq3f2AHwvzoxoP4io7uGHfivIA1L1FixHRJ/xPLNusQRF6LvNWTAptgR
 tKMgTgJ4C0jSMeST8oYo/qhQ7nxVCN5fA0fMAv7cFXuo4iSsxNdkmoFmi+64IxaY
 Lr1+8oobj2nXOvFONaQMh15s5UEWyZyLrX4WhQc7oe0TKYSdCiTQh5SYVyvDuPAs
 tRua/JO8dYHUc5rxVf9TlghX+/830Q/UUKAoF7c0w18yf/XxbrF21GcqBCtGKlom
 NQZXCJMQMaOYcWl7pzW4YTGeyTa0kcjz7zBCHOFdJz61wZds8rZkcwEiTTBAwu0R
 bdIhj9dwMFKmYvj4liS5w==
X-ME-Sender: <xms:NByLaWeapKqyA-VCOZqfVbLqriGXrYbY6hlQLXYGv-8dwouupo6q7g>
 <xme:NByLaZKhvjf-zunEnFnqY1XKu-5AssGOJmZnUmbcExLg9vhhyaJIcjSYYaM--p8q4
 AXWz0sbdud-GsKzJko6AzBsBJ_IVcpNpUECw4BWUETfH_6yXkC9dQ>
X-ME-Received: <xmr:NByLaTE_JeamOL1YXs4wiptdLF_J_HkbJ54A0zDIfQOSsAsP7SWAkAAO0HrP_V_xiucj5NB2SFzm_tx5NLiLao0jpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeeluefhtdeuvdegteeggfelieelfeegteevueelffeiudehfeeuiedu
 geehudfhgfenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghl
 ohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopehstghothhtrdhkrdhmihhttghhudesghhmrghilhdrtghomhdprhgtphhtthho
 pegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepug
 gvvhesughpughkrdhorhhgpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihs
 thgvmhhsrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumh
 gsvghrrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhht
 vghlrdgtohhm
X-ME-Proxy: <xmx:NByLaUAvPyuEZfpsmTT0Mnf40JNAxqJ6346DmiT1DYXo4wElHqylRw>
 <xmx:NByLae_4HYa_GcbrIbQURaEJvD8Mt2jklRbSKlqTSIVDCmCldKHSJQ>
 <xmx:NByLaYAnq6oS6NlU17gTx-_Zm2hEL2kALzP7mQvjwDc3oD5rM8S28w>
 <xmx:NByLabSg0kASIq91KrDc670zTFLxnEWWt80YQ1o-pYO0SKA8DfbTtw>
 <xmx:NRyLabQ-8u4cVrvHPeJmCY0kyd1eOdxU7Ywk9EhUEQvkVVD_43-p9cHf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 06:53:23 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com
Subject: Re: [PATCH v19 0/2] net: optimize __rte_raw_cksum
Date: Tue, 10 Feb 2026 12:53:21 +0100
Message-ID: <5146778.aeNJFYEL58@thomas>
In-Reply-To: <CAFn2buB6yCTZGFOfE-erpU92SRfgGqcvpFrivOLNva3g-pq5Lg@mail.gmail.com>
References: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <CAJFAV8yokz8AG5ZVLBvDSNszY05+81pRWqfWu9FmCgLOvBcZ_A@mail.gmail.com>
 <CAFn2buB6yCTZGFOfE-erpU92SRfgGqcvpFrivOLNva3g-pq5Lg@mail.gmail.com>
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

Here are my test results:

    buildtype             : debugoptimized
    default_library       : shared
    -march=x86-64-v4 (Cascade Lake)
    gcc 15.2.1
    clang 21.1.6

GCC - BEFORE
Alignment  Block size    TSC cycles/block  TSC cycles/byte
Aligned           20                20.5             1.02
Unaligned         20                14.1             0.70
Aligned           21                15.8             0.75
Unaligned         21                15.8             0.75
Aligned         1500               148.2             0.10
Unaligned       1500               148.3             0.10
Aligned         1501               148.4             0.10
Unaligned       1501               148.2             0.10

GCC - AFTER
Alignment  Block size    TSC cycles/block  TSC cycles/byte
Aligned           20                20.8             1.04
Unaligned         20                15.6             0.78
Aligned           21                16.9             0.81
Unaligned         21                16.9             0.80
Aligned         1500               109.5             0.07
Unaligned       1500               111.6             0.07
Aligned         1501               111.1             0.07
Unaligned       1501               113.0             0.08
Aligned         9000               612.4             0.07
Unaligned       9000               612.6             0.07
Aligned         9001               581.5             0.06
Unaligned       9001               601.7             0.07

CLANG - BEFORE
Alignment  Block size    TSC cycles/block  TSC cycles/byte
Aligned           20                14.2             0.71
Unaligned         20                 9.5             0.47
Aligned           21                11.7             0.56
Unaligned         21                11.8             0.56
Aligned         1500               610.7             0.41
Unaligned       1500               632.0             0.42
Aligned         1501               610.4             0.41
Unaligned       1501               627.6             0.42

CLANG - AFTER
Alignment  Block size    TSC cycles/block  TSC cycles/byte
Aligned           20                14.0             0.70
Unaligned         20                 9.1             0.45
Aligned           21                 9.7             0.46
Unaligned         21                 9.6             0.46
Aligned         1500                77.9             0.05
Unaligned       1500                79.4             0.05
Aligned         1501                79.4             0.05
Unaligned       1501                80.4             0.05
Aligned         9000               447.8             0.05
Unaligned       9000               492.1             0.05
Aligned         9001               448.5             0.05
Unaligned       9001               492.6             0.05

Before your patch,
With small block size, clang is better than GCC.
With large block size, GCC is better than clang.
After your patch, clang is always better than GCC.


07/02/2026 02:29, Scott Mitchell:
> Thanks for testing! I included my build/host config, results on the
> main branch, and then with this path applied below. What is your build
> flags/configuration (e, cpu_instruction_set, march, optimization
> level, etc.)? I wasn't able to get any Clang version (18, 19, 20) to
> vectorize on Godbolt https://godbolt.org/z/8149r7sq8, and curious if
> your config enables vectorization.
> 
> #### build / host config
>   User defined options
>     b_lto              : false
>     buildtype          : release
>     c_args             : -fno-omit-frame-pointer
> -DPACKET_QDISC_BYPASS=1 -DRTE_MEMCPY_AVX512=1
>     cpu_instruction_set: cascadelake
>     default_library    : static
>     max_lcores         : 128
>     optimization       : 3
> $ clang --version
> clang version 18.1.8 (Red Hat, Inc. 18.1.8-3.el9)
> $ cat /etc/redhat-release
> Red Hat Enterprise Linux release 9.4 (Plow)
> 
> #### main branch
> $ echo "cksum_perf_autotest" | /usr/local/bin/dpdk-test
> ### rte_raw_cksum() performance ###
> Alignment  Block size    TSC cycles/block  TSC cycles/byte
> Aligned           20                10.0             0.50
> Unaligned         20                10.1             0.50
> Aligned           21                11.1             0.53
> Unaligned         21                11.6             0.55
> Aligned          100                39.4             0.39
> Unaligned        100                67.3             0.67
> Aligned          101                43.3             0.43
> Unaligned        101                41.5             0.41
> Aligned         1500               728.2             0.49
> Unaligned       1500               805.8             0.54
> Aligned         1501               768.8             0.51
> Unaligned       1501               787.3             0.52
> Test OK
> 
> #### with this patch
> $ echo "cksum_perf_autotest" | /usr/local/bin/dpdk-test
> ### rte_raw_cksum() performance ###
> Alignment  Block size    TSC cycles/block  TSC cycles/byte
> Aligned           20                12.6             0.63
> Unaligned         20                12.3             0.62
> Aligned           21                13.6             0.65
> Unaligned         21                13.6             0.65
> Aligned          100                22.7             0.23
> Unaligned        100                22.6             0.23
> Aligned          101                47.4             0.47
> Unaligned        101                23.9             0.24
> Aligned         1500                73.9             0.05
> Unaligned       1500                73.9             0.05
> Aligned         1501                95.7             0.06
> Unaligned       1501                73.9             0.05
> Aligned         9000               459.8             0.05
> Unaligned       9000               523.5             0.06
> Aligned         9001               536.7             0.06
> Unaligned       9001               507.5             0.06
> Aligned        65536              3158.4             0.05
> Unaligned      65536              3506.1             0.05
> Aligned        65537              3277.6             0.05
> Unaligned      65537              3697.6             0.06
> Test OK
> 





