Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62686CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FC53400EF;
	Thu, 15 Oct 2026 13:13:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 45D3940041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792062788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSw+6gTqq7aA3qkZA5+7Q3f+DVsT8HR3YLd+Apojpyk=;
 b=KLr25huYeU6TIoM3Q682RhnCjDreIFmKg7qDF1gqd2fxlHYoFSnXW74qbNk67KnAbCabSa
 oADHcD0XkkBQ7dgML8yIJYW+VhTvwzxBC4T+c++91uhpzEcuaeioo9tpM5wsOV3xckEXH+
 1Uwp6lm8GU8w0j+7zHIGLJ1lIxUNGs4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-oLdC_VzvNPusULXSdwrL9w-1; Thu, 15 Oct 2026 11:13:07 +0000
X-MC-Unique: oLdC_VzvNPusULXSdwrL9w-1
X-Mimecast-MFC-AGG-ID: oLdC_VzvNPusULXSdwrL9w_1792062785
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ab054f411aso3095791fa.2
 for <dev@dpdk.org>; Thu, 15 Oct 2026 04:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792062785; x=1792667585;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YSw+6gTqq7aA3qkZA5+7Q3f+DVsT8HR3YLd+Apojpyk=;
 b=LZ4DHq1KfOp4oOiHbU4vVHDCxnRaZZZ1t0FVxdeGC9Lewb+48E2UEktUHmgrnjhkEb
 xKypBsA9Pp5o5e8V1vnFHl0cSj4sSJItSUaqqsx3sAPshQdYfHeQ46b296CYppSuNVOk
 CUw31gaaM2CTDMi+53+DNdW3H9cTiVydYg3uwMbCy+nEXbxHYorjbj49TrDub6bc7eaz
 TVKn+3Llh8NkevFTXmzm521S9Z2pHJaXG49QhZc79CS15+veHN2niGnuSaB1SG8f6Dwy
 aFv475mLc0iLQzGVVtfrmSFSuyKbRLEUn8sUyrMEBobDRZq+qqvO0WX1wu9YdC5b+QMG
 wiew==
X-Gm-Message-State: AFq9FYK9QJqz3UMPAJ0xItQeXkNCZVmztt5Us2TIGtTZKLlwhzN5dB81
 ouSyKr3AMOkD4SU5qPYLlANIDk2ozLIsZhJ+GlpMQsvwFnOoVuNgFjsOEWf6z523fyK/+kwgM5l
 yArjFOAh0DUPR6AoG7nMxIhzDzsrOtoZgOUpPkLLRI7s+i9OICGJuaVvY2GiUHu+5cY20yO/JmY
 0U/cCoLoLfweAapdr+hj8=
X-Gm-Gg: AYBFou2STaDZ1MG4O9wYiSgpMqO0YjZXepHNM5xdZWAwWufRFfypcCItgCr/PDZe9lL
 tAW42kPncvhaRvhu0hyzw32J19c3VhpK0R5i8aJP0G+YGySfa8qeDfB2s4Vx6VPH+eJtstcLVU1
 kBHQjCqYzdjpZtiWYPt+z1ufj8RQdx5zoJzi60hDN09I5+S1BmAbtOfk7vgk5E5UFIYpxgFixqv
 oY3smgOjFloDsFbIPs5BOEloUPcEmcc6aPFmiOPGlYdROxX
X-Received: by 2002:a05:651c:4ca:b0:3a9:a1ed:633d with SMTP id
 38308e7fff4ca-3a9c55b0285mr42724331fa.17.1792062785444; 
 Thu, 15 Oct 2026 04:13:05 -0700 (PDT)
X-Received: by 2002:a05:651c:4ca:b0:3a9:a1ed:633d with SMTP id
 38308e7fff4ca-3a9c55b0285mr42724281fa.17.1792062784918; Thu, 15 Oct 2026
 04:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20261015110944.11508-1-bruce.richardson@intel.com>
In-Reply-To: <20261015110944.11508-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 13:12:52 +0200
X-Gm-Features: AclHuK_Y2tXACS6ye4LrMGHGfExqadDNqhWXomsnbS1pbdGwjCPya0KSGWi3VLY
Message-ID: <CAJFAV8wugtAUroug=7EkehuPdtYKB6=o7heqZRswOeTX8EZ71w@mail.gmail.com>
Subject: Re: [PATCH] meson: fix always-true meson version check
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JFNsYYygU3n5fWZ64BMEZcXw4zH1A3mwQw4IDnGu-p0_1792062785
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 15 Oct 2026 at 13:08, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Since the minimum version of meson needed to build DPDK has been
> increased to 0.61, the version check for >= 0.60.2 will always be true,
> so just remove it.
>
> Fixes: c1d15cc8d571 ("build: bump meson version to remove warnings")
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>

-- 
David Marchand

