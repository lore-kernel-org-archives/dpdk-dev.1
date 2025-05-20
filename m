Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BF4C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 15:30:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00DB840A71;
	Tue, 20 May 2025 17:30:36 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 6B6804029C
 for <dev@dpdk.org>; Tue, 20 May 2025 17:30:34 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6f8c53aeedbso71661136d6.2
 for <dev@dpdk.org>; Tue, 20 May 2025 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747755033;
 x=1748359833; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaQ3BOL1r4U2Ga3mzRfyOf29cJVcH3H6vKKZ8jlVWj8=;
 b=0HsdkDvVJ//1CEXrUkcIFlUL2N3hWpYWLdjKpEsh1R9u+k4rDBBiAGGTFtbN3pcik2
 IWr9s0kwzdkqManS630cIMghR+gTWeRE49chgbHvW9nRLeUpNVi2l1w6ITs7o9h9cVnP
 T4eDhl0OQU4bjVK8lU1xErqpoBgBwURUpl3zjmf/AqHwOqHORXtFrQ9ajWrry3ZDtftD
 cPMeCXmixE1twUHjzbsNKdSweGArkTMuCJ5SvtPD7UsGtyqtc1lQYlhityqWcynjdgVz
 uVo5TROKFyQhAJznkhBxx8S5Rjx+LWiWpPNUdu2yQ6LZWb8eWJ2s285C/degntLwOjf+
 i0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747755033; x=1748359833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaQ3BOL1r4U2Ga3mzRfyOf29cJVcH3H6vKKZ8jlVWj8=;
 b=dtBQpvvmRA+1KPpzXcKB4BJ5c89AoaBS5L9ZJj+HNraBR/R+bArPizhoKYI45NBCRX
 YXq6IhDREu9vtG0DPRiaxzYU+xP23rfriJg7dBAzN/gCJ1VUQfC+OmbcaLJJlOyuw2LL
 74oMR9KeZfULkRDsl/LYH7111pjDGoyAmvaXJEkJ+KM2789C6W2ww81Zoaiezg9m7MYd
 povGlwmjIDkO2zs1qgpupY2D66mkc0nhl64edg/Z03y+rMM7a3z/QXPchzp2YNro/Xgm
 Del5DpK59uF78m3NqK8cXq9UvgU5TBRXClUDUbt27RBrDILRtkaPF9czLEESY9Up39PU
 hKZw==
X-Gm-Message-State: AOJu0YyUa9w4KcLzrbp/zA2qcES43Qq9ASxUwR03e2xaBdlJbWQEBZsT
 ZXOwR7RetImM0HVI7yYOxPdItenHYpYqparU20pHokcMKJkgYHN+C6V8oSaGDEn4JiQ=
X-Gm-Gg: ASbGncvzONBUPYm54FTTc1PPfrN1Tohy7IcOtJtUJW6ti1Ulq8ijO5gMMLp5MXensmf
 ShPnD3WGYDCMFiOzh382Ss1R3HnS1nebROcbc7/tqbwdvyJ0moIqZOsRj7Qj+L0uhWi4Zzuotnw
 55RN4gj0gSgdgOJRaCvWc74XIf5lzGPlerZWsMtcq+LuT6hfMwYBD272OAewshEGa31ESoxBU/h
 REeabfokCknJHHLaFkKysy0AjmOj4vl4PjItC73D3ygiOoJZG/nN4mvOfPjGcMuemDOGu58TCkY
 +rAhLRgHddCKj7ly8hLUc2AmIt2JpeJwHlKp9RAj3fOIpYVEsiAPQ5xseo93M9cr2FD+U6DAKgr
 1qdZDqNM0Eiv3Q8gMC4NlcrIr8lvEeyMPeWjKSEo=
X-Google-Smtp-Source: AGHT+IHDPPP8dfKwgcNv5GS948+S74yboKuuzbWFs5w0fR9C4/WoWoEalxQJEbnYkvxaLDcvivm9Eg==
X-Received: by 2002:ad4:4eea:0:b0:6f5:1cb1:aa23 with SMTP id
 6a1803df08f44-6f8b2c642e1mr296281786d6.16.1747755032637; 
 Tue, 20 May 2025 08:30:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b089c92esm72760516d6.32.2025.05.20.08.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:30:32 -0700 (PDT)
Date: Tue, 20 May 2025 08:30:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Yi Chen
 <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>
Subject: Re: [RFC 01/18] net/hinic3: add intro doc for hinic3
Message-ID: <20250520083027.45f5077c@hermes.local>
In-Reply-To: <20250418070306.9290-2-wff_light@vip.163.com>
References: <20250418070306.9290-1-wff_light@vip.163.com>
 <20250418070306.9290-2-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 18 Apr 2025 15:02:39 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index 093b85d206..1d65cf7829 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -24,37 +24,9 @@ DPDK Release 25.07
>  New Features
>  ------------
>  
> -.. This section should contain new features added in this release.
> -   Sample format:
> -
> -   * **Add a title in the past tense with a full stop.**
> -
> -     Add a short 1-2 sentence description in the past tense.
> -     The description should be enough to allow someone scanning
> -     the release notes to understand the new feature.
> -
> -     If the feature adds a lot of sub-features you can use a bullet list
> -     like this:
> -
> -     * Added feature foo to do something.
> -     * Enhanced feature bar to do something else.
> -
> -     Refer to the previous release notes for examples.
> -
> -     Suggested order in release notes items:
> -     * Core libs (EAL, mempool, ring, mbuf, buses)
> -     * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
> -       - ethdev (lib, PMDs)
> -       - cryptodev (lib, PMDs)
> -       - eventdev (lib, PMDs)
> -       - etc
> -     * Other libs
> -     * Apps, Examples, Tools (if significant)
> -
> -     This section is a comment. Do not overwrite or remove it.
> -     Also, make sure to start the actual text at the margin.
> -     =======================================================
> +* **Added Huawei hinic3 net driver [EXPERIMENTAL].**
>  
> +  * Added network driver for the Huawei SPx series Network Adapters.

Leave the comment section in the release notes alone, it gets handled
as part of the release process.
