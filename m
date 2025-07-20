Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3D4C83F22
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 13:17:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2564021E;
	Sun, 20 Jul 2025 15:17:48 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 2FB194014F
 for <dev@dpdk.org>; Sun, 20 Jul 2025 15:17:45 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 853ED1D0003B;
 Sun, 20 Jul 2025 09:17:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 20 Jul 2025 09:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753017464;
 x=1753103864; bh=Wg8Tfdae3dmv2IC4kffgeEwUEAXR3FlnFqre85wgFfg=; b=
 Qrxet4yW2XBQfPRFXgfvJpXSUB6vpZfu7XF2LjTib9YczIu0YtgdEvi9V16tvu0g
 2e85UTzweyk43JKfSE4udXEwtHpkZsirO0LBvAwY/oYGaGwYyR7XbmWiPtB+n+bm
 IAIvYMVLvz0yaHXl2UrvgHrt9fUQvzHjHh7KrbyGbR62JnFmLn8Ml/FjuS7D4MgB
 3wtiCRhoAUy8m0FRLrtw1FWchQP8aeR75YaIrgLkfsv4abVqwvdMUDKmfwZR1M2V
 75zSrkQ+CtWIVNloonRCrcCYIOqO8fiz1PfjANBkXNR0TP23XeiEYo1UxbKmsLsl
 9eiVqyW8Ogq5rYlp0GFDYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753017464; x=
 1753103864; bh=Wg8Tfdae3dmv2IC4kffgeEwUEAXR3FlnFqre85wgFfg=; b=C
 1BgVt3/835rnHku887UO/qtKn22T61kn2Avuq3pgO7S/nQhgkgiC90GGvUccaVAs
 +VEAV7HppKnQVUqvOfz1JenZ68xzk/s4FFKkl5/miguQYrQ9PqVasdLOJIHlgD9V
 C0xpzPnbgZJnfQcKmLPx+koVAsYGkEsrm4LZvAbY5YadgO+cW25kQ7qLEb/AZ1f/
 Xgvpaimab1BqUD6/HyKcuelyz0beES5AtCRxh96Dca5evwhRmocNEuu6n1lRDNXA
 W9lVEJj2KKwb7tGNErhNuxtU00E1LNXhmbUvDbO8OwwsG17Rv0EfiQjB9v7AlRhc
 4IUo6cvppZHCgfR5k4d3Q==
X-ME-Sender: <xms:eOx8aF_oG9vLhCHYqGZGVY-11mJViDKwWXlQQZqSyzIGIfsB6T73Dw>
 <xme:eOx8aO9TOgaMNbLiHsI5ei43NuW4FnwQGGnIfRa2jIkgMiMKDEae-8GszMqfQcxa-
 kKbXij5hI6u1L-QDg>
X-ME-Received: <xmr:eOx8aEsWJolw5EE_kz8D-abw6iFJAz6kKKioe_qJxEJHh3KlRSHuEXQwiwdV3nJdSNaG7JV25du1IWluwg_z3771Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeileeftdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:eOx8aBrWq2j6JeI5x-Vx8AVQFliUIYHMTqr1QVjYW1AOePNeTWky0Q>
 <xmx:eOx8aBnOVwe0veYI1qig0E8FtiAUY834gRB3dQcA1XGjwNl_WiRdqg>
 <xmx:eOx8aFy0X5rFtG8t-W89ifQCJImA-AEHUIKX8XjNjCkCCwPpCZINNw>
 <xmx:eOx8aJleMmGQAOHjFv0uL5895A_OnhMIArTrwsgZZl7o2vGGcC3bcw>
 <xmx:eOx8aE7Dhh1NDcFUp7aJWY42WLxR3Wu9Qh0K96bVwDmTgR6kuMkTXaS0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 09:17:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: update ABI reference version in example
Date: Sun, 20 Jul 2025 15:17:42 +0200
Message-ID: <24020273.6Emhk5qWAg@thomas>
In-Reply-To: <20250528233041.200373-1-stephen@networkplumber.org>
References: <20250528233041.200373-1-stephen@networkplumber.org>
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

29/05/2025 01:30, Stephen Hemminger:
> The example should list current ABI reference version.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/contributing/patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
> index 8ad6b6e715..fc9844242e 100644
> --- a/doc/guides/contributing/patches.rst
> +++ b/doc/guides/contributing/patches.rst
> @@ -539,7 +539,7 @@ to a different location.
>  
>  Sample::
>  
> -   DPDK_ABI_REF_VERSION=v19.11 DPDK_ABI_REF_DIR=/tmp ./devtools/test-meson-builds.sh
> +   DPDK_ABI_REF_VERSION=v24.11 DPDK_ABI_REF_DIR=/tmp ./devtools/test-meson-builds.sh

Actually it should be v25.03 to make sure the new ABI
introduced in 25.03 is not changed.

I'm not sure we want to change that at every release.


