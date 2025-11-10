Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD18ACCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 21:34:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B61A24026D;
	Mon, 10 Nov 2025 22:34:23 +0100 (CET)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 80C3640264
 for <dev@dpdk.org>; Mon, 10 Nov 2025 22:34:21 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B899E7A006E;
 Mon, 10 Nov 2025 16:34:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 10 Nov 2025 16:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762810460;
 x=1762896860; bh=CG014jOnStt+CJHc2wrsqS/RXiv49+q9gzfsJCBF8yE=; b=
 gTbqvk/+nxwIYHoQcI/edqr9fpUm54DczOi1yPQQCqy5NlARPPUFyKX9eODp7HpI
 H92TsHv9/oTn3BLT7eL+THxmlJ6qNVOHODdJndZ2JEbyclNp3T46Tft9bSZIhdh4
 pU0sdjTiQdTxGMmZiS65MpRjdwpV3HZb5NOLtIrl+t2Q7zKTOzkxHOhV7HtahIRv
 iqZCBV3Ri/NTtKcNDhVI9/H9DpEOCfQQCAnJXEZnWtitXl6hze3FEQS1MnzH/pe4
 tRf8C1FguxFQB4OQ+ibevG20NqaJLdIKQT7MiixnUNSX82QEsfmFHZGw38r91rQe
 gms8cfkH3MbYN1pISIFhGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762810460; x=
 1762896860; bh=CG014jOnStt+CJHc2wrsqS/RXiv49+q9gzfsJCBF8yE=; b=A
 vezY3IHJfPblD7OUtpYITxpkQIB9DVCcr+Rm/MHFJdz5l1ZHVoXRPXzJXzbd1zev
 A8NKciJctL0RtfJQJy3yIFJDCH+UbTe1AfyVGRty5LkPHxsU7ExNzcUez+RsOsBq
 ylGZ1wHSvLKeJp4QmCAHH42S33W4x+6BIKlpGVPYPn9N0WUM0ZqvVVyio7BVFNKH
 JzPWiWf3yqmqwlDCha/HWmU010Lb4aXCJnE462l3s2/fUrCfVSYxIr6CqCwZWvgp
 ENAnBpQ9W4ZT1brWBDbt/6tAOMo8grtIMEIqPZOr4iS1y5MWL2eS8oZez9+6H3o/
 nt3AvG622EHD4mm3rR4GQ==
X-ME-Sender: <xms:W1oSaQZWfbc17sGGOBYY7cCCcKmp3ze1qs301_Wg3wpd2U9NUjfOaA>
 <xme:W1oSaW1SxYsaxpb-JpsXPB6nt5nRQ-cXCAruj4MiLf_3TPwCac08ecRzO6FzrlSCg
 oPl6q5TGdgfhLvoPCD9nAQPMbU0243gGXRA6C98yB7BTf2KtsFlDQ>
X-ME-Received: <xmr:W1oSaecZedVm3yArkh7kpmRRqs0Mw9p7Ow3P0EimbScmLOe6KdIT2wvVhJ2ccCCQv9A4nuZ72x3ejuKrGA-JROG_wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrjhhithdrkhhhrghprghruggvsegsrh
 horggutghomhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehmrghnihhshhdrkhhurhhuphessghrohgruggtohhmrdgtohhmpdhrtghpthhtoh
 epshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohep
 uggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:W1oSafF39v8AYVoQVIkZG-au2kb-pbtFcaIS4zAZyWfyqtAL_XJR7w>
 <xmx:W1oSaX0q8p7l9uCO1FAdOrQQBPJzkDn03r7agaS147Jl-OKdj8ayog>
 <xmx:W1oSaXmPJVZjKn_6tH1C0ErP3NCGkahF-XK4lMKWO7C56VGF4dPYRw>
 <xmx:W1oSaX-JhtN_cCs5r9kDOa5rc3qOudZiUBqvUWIBHfCm8D4FHAcUWA>
 <xmx:XFoSaWCPe2P1G3QbwQ17YTKVmABFSLi-uBhfFYuU96ap7ly06xjevhox>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 16:34:19 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: ajit.khaparde@broadcom.com
Cc: dev@dpdk.org, Manish Kurup <manish.kurup@broadcom.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v5 48/57] net/bnxt: add meson build options for TruFlow
Date: Mon, 10 Nov 2025 22:34:17 +0100
Message-ID: <3070960.fgWkQ1oJHW@thomas>
In-Reply-To: <20251029160712.58519-49-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
 <20251029160712.58519-49-manish.kurup@broadcom.com>
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

29/10/2025 17:07, Manish Kurup:
> Add meson options for
> 1. TF template
> 2. TF feature bits
> 
> Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> ---
> +option('bnxt_tf_template', type: 'string', value: 'default', description:
> +       'Truflow template selection')
> +option('bnxt_tf_feat_bits', type: 'integer', value: 0, description:
> +       'Truflow feature bits')

Ouch, I missed that. This file was not part of my regular checks.
It is clearly not the direction taken for DPDK compilation these last years.
We tend to simplify the compilation matrix.

Anyway bnxt_tf_feat_bits is not used in the driver compilation.

I copy here an abstract of the use of the other option in another patch:
"
if get_option('bnxt_tf_template').contains('app19')
includes += include_directories('app_19_templates')
subdir('app_19_templates')
cflags += '-DBNXT_TF_APP_ID=19'
"

It is not documented, and the subdirectory is missing.

This whole thing looks very strange, so this patch is obiously rejected.




