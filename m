Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F5ACAC5A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 12:23:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38F0140288;
	Thu, 18 Sep 2025 14:23:55 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 212844027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 14:23:54 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 6B9AC1D003C9;
 Thu, 18 Sep 2025 08:23:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 18 Sep 2025 08:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758198233;
 x=1758284633; bh=ZeNIXfaqhvTKEeYRkqh1HOQT5SNRDBbba+Z05SMTRAQ=; b=
 oLMi8MvedWliYmxMkH/RIw9lw+1ggWu7gWuka6/1U/OXS8fF0XkwItPajKUPK1jM
 Igb91x297RZzr8AHuv8gW8DohzksrDinYdo7X0t5NqITan/ZEKG3LUUL9PKuRnxs
 qBU2UNuUU3fGzIUclkfZjtGaNK6dKjmRYdRShGfikvCMviY0YY72WTnexuFlPK3o
 qMOixZHCXfCTXOgHxy67mWip1fcJBelJJycQw26ykJbQEL6H37cZhLEa8Fjzv7+A
 BH8d66/IFUH6XZfCSKM+GWF089Lt4OUFRXvoxYKBYlMpdRBJrE14fNw0NlcZUPR7
 a1QffDXzU54NUxHkx+brzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758198233; x=
 1758284633; bh=ZeNIXfaqhvTKEeYRkqh1HOQT5SNRDBbba+Z05SMTRAQ=; b=Y
 SvCGm/8SapRCSWM8LHv67F+uX3y3mhZRDahnl3kF7Sv6svP5cflKFEIg52E8vgC5
 G7oLZxcEgBC0a0w//fqWlhlvvscQGdmS12Olx90t7NSK4wpWfyWc+rhx3braeEHF
 4JTBNncMLTp/BIlQwmoEvsgIwFH7FjVN8bM76bxE4tD29P9BQtsvA9uP+Ek71NNd
 pv1eA0cqcgxGTJHjbvt6mMa+yary3MwgJXn5uIqof7RZUXg121dxhjjCyMVIuqoE
 Oc/yiDrVcuqEctAmuGm0WihTjTLmsNGb6BRKa2fHedtDh0d5mPwfny4LFaDVhAzU
 aTB+grr6p/oENsVjGAXZQ==
X-ME-Sender: <xms:2PnLaLVQc8V2bf3KVtq5DogoFuOHVhBQzmb-8yEqqiX58iSemFJQ2Q>
 <xme:2PnLaG0D9j0AI-7I3ckq62yGC_Ye1kw8lCn4U6Om3traQQ50vqYyzp7jIfB9Wj0PX
 ZeIpdmxvcdmXL1bzA>
X-ME-Received: <xmr:2PnLaA3nGQD3YJjVYk-wV1-4jpA6dqzyZH5Z6AKvr4GsjQBuRNUzssZaQZgPbpZuqW7keIJo3BKX418hJgGE91vhVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieefvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrnhhgrdhjuhhnlhhonhhgudesiihtvg
 drtghomhdrtghnpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgs
 vghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:2PnLaB-K-gDJ8Wpv41jK-ceOReWPygR2OjbLe9dW5UUm4CL9w8XXBw>
 <xmx:2PnLaF0q6sM9zct26bsJAqa7lWbcUzpuUSROVDp1ff_y46rv02O5hQ>
 <xmx:2PnLaG-hUu5BgCEmy2yWYbs5Rw_uWEfggjxLTCFr21UztiYwnQ1UWg>
 <xmx:2PnLaNs2uy2T97lUF-AIGGXEpSE39_ozfV9UlsYvineDVN4E0lw_6w>
 <xmx:2fnLaIVWodY31jgmL0oTinFjT-K3Je336MdK4bOQoR11-aCLe2mYkyMF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 08:23:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: add support compiling on riscv-64 systems
Date: Thu, 18 Sep 2025 14:23:50 +0200
Message-ID: <16432632.tv2OnDr8pf@thomas>
In-Reply-To: <20250911023211.3576860-1-wang.junlong1@zte.com.cn>
References: <20250911023211.3576860-1-wang.junlong1@zte.com.cn>
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

11/09/2025 04:32, Junlong Wang:
> modify meson.build for support compiling on riscv-64 systems
[...]
> -if not is_linux
> +if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
>      build = false
> -    reason = 'only supported on Linux'
> -    subdir_done()
> -endif
> -
> -if arch_subdir != 'x86' and arch_subdir != 'arm' or not dpdk_conf.get('RTE_ARCH_64')
> -    build = false
> -    reason = 'only supported on x86_64 and aarch64'
> +    reason = 'only supported on 64-bit Linux'
>      subdir_done()

There is also powerpc. Do you think it will compile?


