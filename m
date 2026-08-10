Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E655DC5AD7B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 15:16:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCAC840272;
	Mon, 10 Aug 2026 17:16:26 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 75F7640144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 17:16:25 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2caced6038eso19925ad.0
 for <dev@dpdk.org>; Mon, 10 Aug 2026 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786374984;
 x=1786979784; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v/0F0TpPkaliqwg7XVd3+0y2O4WPM1ylFlXvIAGAr+E=;
 b=ztjO8jWqg0xIetih8orVXK3ymmm2t2lnF3gQMEmr0GShkwfZ0dTSdM0pTg3LUh+mVW
 Ui1DhbSCQRdY8FieXEphQCRTyw4ZwyXQF+8pNwl0iZ04X23WzrWF85SBgWwUdOBSL7Vw
 MudBEfYmp+29uJKy7bAmul6rllV/NY+l7mQ8BkwaqWuE1womncDkENEvUciaEZcw8yGe
 EWXI33upEjKUtKLMifCCH9EbPkOpfkhPNJpRqo3LVrnja6gBG0UVbqQuZn/YD1Lv6G59
 Wty2V8x+yzfljcKcs+Gp+seqxMzIKeiPK8yKBXqcOCt4eo/GTw1Q2tawnqTVmVoqcBt8
 /h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786374984; x=1786979784;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v/0F0TpPkaliqwg7XVd3+0y2O4WPM1ylFlXvIAGAr+E=;
 b=OHowwPrUDcJrGZXQmm34R+U07jWnn89ufj9Z5qNzIZ2HBsRhv4KUmaySbsPXsnEK2x
 yJ6kfxZ1m7QVgP/pCrE1vK/ZWjAxfoibMAHzrQdpXh3MTdgViMu5Itj/XHgkcyX5lIJg
 4hJpdcb3akq1DRM/dUFKPnWv1F4fF7oqu0Q+/614gs7EZxc328U8NkP2jYgW8J8lRetj
 If0GJuP84HhQ2oaTdVrft4jLYZg1gpDy9st1s4aYHxLGp+4DJXCaNsjg1EcVCGH0cUJE
 N0uk1JocQHm2Qn/THWR1EgfpT32MtOvrm/+TsgYWuva93RT0LdIIKFGxxX62hrqcvbfa
 zmFw==
X-Gm-Message-State: AOJu0Yz1C1fiMOIhov+prehMU+vt7bpZ9+1JamEctgzUVr91/XGSJS1V
 cJ/Z+Ei91KuJDSOIXp3/hYjkHFj8WVthU8HU9xKCG+pkKHseIISZJ4YS1gojaR4q/L0=
X-Gm-Gg: AR+sD102Esjb+v5/kxIzjodjUF84WPbunha/nI2ldhfc512OksuwXyTlW/Fh1qM08cj
 9ODaW5maqFaaypELROksPgdKqJNM5O6Sz5ETgjuJknIsMli1tn8rPooyT2GAihRLKop+7BwBT9h
 gT8dujL2MjAxD29y22OD8Vr2pzWMfw6WRuy3wz+7eWaDaj+QRiLG/ZRMoI8yZ4YwV3zEOUcNfLN
 Cur5pHUAOSQEAE7d5GzEbZVtd9OLG8+m531X2Zr9r5m23GNgtP/BoLk7sfdgPJ/O7MMMEDhlrLJ
 XbVAaFwABt00o0EzD66BVI4NleRM1xaTcDkD4B9wRUy+GRgI5X1rRZwYkoqT0owaqgkWNOvTOqf
 keV3pMeGTvVw1gKw+jAtii4MN9hUlfSF53DSEvRGH07TGi37KerLZPKXoCzHOipiJtMidsFdMyg
 hkC89AcwFVDkHN6yH3HdPG99qgZptdAT1JEdub23BPAVgcMiTAtpAPQsLz49YQtPch3WZvgsmCT
 BZooiM5oVsldKRSt+SXgSptJD+d/g==
X-Received: by 2002:a17:902:e54c:b0:2d0:401c:2edc with SMTP id
 d9443c01a7336-2d2b2d8ecacmr212298905ad.1.1786374984246; 
 Mon, 10 Aug 2026 08:16:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb88473sm40832378eec.17.2026.08.10.08.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:16:23 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:16:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, gakhil@marvell.com, hemant.agrawal@nxp.com
Subject: Re: [PATCH 6/6] crypto/dpaa2_sec: add support for env variables
Message-ID: <20260810081620.1a1753f8@phoenix.local>
In-Reply-To: <20260810112951.2879825-7-g.singh@nxp.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
 <20260810112951.2879825-7-g.singh@nxp.com>
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

On Mon, 10 Aug 2026 16:59:51 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> Allow driver configuration via environment variables as a fallback
> when devargs are not provided. After processing devargs (or when
> devargs are absent), check DRIVER_STRICT_ORDER and DRIVER_DUMP_MODE
> environment variables to set en_loose_ordered and dpaa2_sec_dp_dump.
> 
> This lets users configure the driver without modifying EAL arguments,
> useful in environments where command-line access is restricted.
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>

No. This is bad precedent. DPDK has a method for configuration.
Adding AdHoc environment variables creates chaos.
