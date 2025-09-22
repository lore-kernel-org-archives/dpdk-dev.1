Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE0CA100F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 15:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03FD0402CB;
	Mon, 22 Sep 2025 17:52:58 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 6A0EF402A9
 for <dev@dpdk.org>; Mon, 22 Sep 2025 17:52:56 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id AD0AB1D0017A;
 Mon, 22 Sep 2025 11:52:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 11:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758556375;
 x=1758642775; bh=IueKjGU1dS2N4tcPo1ey9BmK7RbDlRa2AVItd/OeZCk=; b=
 phZB0tdZFY4q4mn/WOEHqQMSyPN655ObQ+/ks/J6gNjjXiUj/oxEWHy84q0kVOer
 FK1H90Pc8Q2l/zZKXHgxiE8fHghvrfMcOGr1Ch3XD95ah4BSddtIy82RXxdmxO4a
 zyplXyryq86DBfgHasL7/F9R6xp4FcZyLHzZSWDtDjtpMLmun3dy0kJK6/Gr+qmB
 hfz/bj0xQa1WyuozmVBOEChzdPkPt+uC7nMDGrFZ6tEumzpYztOwx9hsTjbP+f/l
 lbkQPUWtxAHtJF8WOWL2f1T/2fKUqAVcWydzSzXEfsrTGiKMPkykU+oJpfrnUFD/
 /Jfl3cG0BgFQyURuG26Gxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758556375; x=
 1758642775; bh=IueKjGU1dS2N4tcPo1ey9BmK7RbDlRa2AVItd/OeZCk=; b=E
 Jhc4rYDE7nVjsYszXOiB5s8/faJG+24PwYiK2fn4xL5BY6IZz0gsbsJsYg3AMLs6
 UJrCWeWWXWCmwGvPq3QfC1E6fpWJZLVKdUxsAOLS1bVrFBigfh0qgmCO9AbxkPfn
 fVLcDlxM/AImcXHVfa8UZxhXmFyiFKcn9SE75U1y08O5CGhb6vlym0YhJmlp6iV6
 xzx4o4a1cgBs0fYEoCkd0poMn/Q9k/1Pbwmo2TQAJsRbvpbjojS0DBzpYSWhlBM4
 lA5lrHKgbiuOIKUJ3go966t/ghVv5uK/ZcYsRj/+f/hvcngspuEOoUY4WdkrCLrE
 3YW22ZlFMLHKNna6af+yQ==
X-ME-Sender: <xms:13DRaMm05b2INSZz4ilidS7sJnoOLhjT33iVzwyg6vpQWZeDMT_p3Q>
 <xme:13DRaHTdHIGiqtGe3j6-VP3Vm6tjhkdpseeSGhvP7v44XUKKOYq_6BN6wFuJdr_O2
 4_CgFxBz6Ip-spocpnWa4iToHUjV3u-yHQJNHfYjlKvlb_-tPydBA>
X-ME-Received: <xmr:13DRaOKVGy_JJa16exu4ptacKpXnnzwZ441WvqSwykEW5kdRHJtrepEsMJ9WeqEE9MjiklxDxZqcDd-u569EGGEABg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepkhhtrhgrhihnohhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrhhutggv
 rdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgurd
 hmrghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:13DRaNDD7BrMurZCwf8dvX22Nw9TgnUHAr1IERv0SD722_Aos9F1HQ>
 <xmx:13DRaHDSjrV5OiBDT-L9geCBlf_5rglTbwDa066N7Rc4oSSvqXPnQQ>
 <xmx:13DRaPBjwUMorFhgwLeIV4BvZZ5fUgsysl4Xx9NA_mTja8DcljzW0A>
 <xmx:13DRaCrqdg_PXJKsYV353ihrTDKKfjxPI-kmX31kaynWti1JNi_MUw>
 <xmx:13DRaEbk2_FTmcPtt1oVIpuRL3_a9_mlUOhhc1sOGf97nd1R9kzq1kXc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 11:52:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org, Kevin Traynor <ktraynor@redhat.com>
Cc: bruce.richardson@intel.com, david.marchand@redhat.com,
 Kevin Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH 2/2] build: add backwards compatibility for wildcarding
 nested drivers
Date: Mon, 22 Sep 2025 17:52:53 +0200
Message-ID: <8866794.lvqk35OSZv@thomas>
In-Reply-To: <20250922110708.47879-2-ktraynor@redhat.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
 <20250922110708.47879-2-ktraynor@redhat.com>
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

22/09/2025 13:07, Kevin Traynor:
> Up until DPDK 25.03 'net/*' could be used with meson options
> enable_drivers or disable_drivers to explicitly enable or
> disable all net drivers.
> 
> In DPDK 25.03 commit
> c1d145834f28 ("net/intel: move Intel drivers to a subdirectory")
> moved Intel drivers to 'net/intel/*' and 'net/*' no longer enabled
> or disabled the Intel drivers.
> 
> Expand wildcards handling to include nested drivers.
> e.g. 'net/*' will also enable/disable drivers in 'net/*/*'
> 
> This adds backwards compatibility so that so that 'net/*' will
> continue to enable/disable Intel and any future nested drivers.
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> ---
>  drivers/meson.build | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 3fbf04e1cd..ccd25e4d18 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -58,4 +58,9 @@ foreach driver_type : [['disable', get_option('disable_drivers')],
>                      .format(driver, driver_mapped))
>              driver = driver_mapped
> +        elif driver.contains('*')
> +            if driver.endswith('/*') and not driver.contains('/*/*')
> +                # for wildcard add nested wildcard
> +                driver = driver + ',' + driver + '/*'
> +            endif

The special pattern ** does not work in Meson?


