Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22A3CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 13:35:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04668402DA;
	Thu, 15 Oct 2026 15:35:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5FD01400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 15:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792071339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QabDmpABboqal6GfWmwMGuRMaYRe10C7uYtpkjnJ4Og=;
 b=TqC6WT76vlywhNMNHAiVHBlJS24Qf7aJyYm5OpesE0U9sn+4i6jutIrHgsx4+WPa5A8/wx
 aeo7zMPl+syz73yDnHBRv13vMgf+5RnYbgJfxyDvHldLQRnPVGNnQpgQzJ44JCfQarvEBF
 iuZ1zL1v3scmgl3sTJi5VbBiwWlP+6Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-toqWOeb0OuKr5ugC7nO9cg-1; Thu, 15 Oct 2026 13:35:37 +0000
X-MC-Unique: toqWOeb0OuKr5ugC7nO9cg-1
X-Mimecast-MFC-AGG-ID: toqWOeb0OuKr5ugC7nO9cg_1792071336
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5bcf2d3d83dso1035895e87.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 06:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792071335; x=1792676135;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QabDmpABboqal6GfWmwMGuRMaYRe10C7uYtpkjnJ4Og=;
 b=cG3/YTJZiq35RhzFfHVpyZHYGwHtZsFX0dI8AvWPwUjC/r3gJX7RVd2sylr86p1Vit
 0FQl3R9hqHeTgwIXWa8WkDGBIoLTSyAK7Cg9zToWfKwhEOB0vtVsX41jTo9lziweEnap
 c9Gv36dYtRPwpXEJmVKbPAZ92nZLQNMh1qR51HipD0HLkPTLbVPaqkHbxlzB8c+1J9Ud
 pmc4ZG3YFXEqtaPGEUZdjzC9ZE76ok7My0VsNWsNGLfPS2IO/4NiX5wffZQ6hh7aqv8B
 omC6QJnSIoR9Nl9WIVOIWl0s2OYez+YwBU1kFqd+9zkoJt4XVvFEdE20bI4ktuenBITh
 dcLQ==
X-Gm-Message-State: AFq9FYLWCHBwgXpwb+wjPRete3Ru25NoMfwaDDF1CoUJjGsixd2D/IP8
 3opROp7WMGEKB1ZeNW8l92cGnjrQc2/3B/1oRNHhG3Rye51MzgCSwjFaukfgPuZFnLFdUIfCqca
 7stGhGcW0aBD2K9ASZlstNc3noodeFLmHnKVG5E7E1VlrMWnEUybuFnAuOGnEcHkRtLQk8eIJCe
 dr5jQhrAzCzwqTecsiOag=
X-Gm-Gg: AYBFou1zwRBQ2cgFcsqEsmMbfRkull8hRJHbPQTPEHfmLTJPCrQJ2C3+zJE4fy+2tY+
 O83WM11su6upd4rUtCQR7ba8K9gbnM3UAvhTroK7TJmDrYdCvlkYx/KCSg7kAZ5Uhxrh1/lniVJ
 WfEPvY7Tyco6mYnNAddt9rfFU5QvRi5lm1GgiqeIxzWRZ3lP4L5KkpCof53Qx+U1w9NghfbYTyt
 36OF7/arY0r4EIf5eGRM6dlL6+I5bKL9dAxLGdCHRN0x6/t
X-Received: by 2002:a05:6512:3a82:b0:5be:4684:d027 with SMTP id
 2adb3069b0e04-5be4684d1d5mr215637e87.12.1792071335533; 
 Thu, 15 Oct 2026 06:35:35 -0700 (PDT)
X-Received: by 2002:a05:6512:3a82:b0:5be:4684:d027 with SMTP id
 2adb3069b0e04-5be4684d1d5mr215627e87.12.1792071335079; Thu, 15 Oct 2026
 06:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261015110944.11508-1-bruce.richardson@intel.com>
 <CAJFAV8wugtAUroug=7EkehuPdtYKB6=o7heqZRswOeTX8EZ71w@mail.gmail.com>
In-Reply-To: <CAJFAV8wugtAUroug=7EkehuPdtYKB6=o7heqZRswOeTX8EZ71w@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 15:35:21 +0200
X-Gm-Features: AclHuK8rpqzym-wDwt-Qw7hFAN6wmPTqMxiVOtalM33oUbe0s-xPTf-67TFPc2g
Message-ID: <CAJFAV8yzTi1G8aYfGy4k3EUZ5VER-fiY==oNaDNZMCmFUvmgpA@mail.gmail.com>
Subject: Re: [PATCH] meson: fix always-true meson version check
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UNI3KLb4YIh3kjpN3ZZX3RX-UlcvC5pxoj4F62DK8Lc_1792071336
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

On Thu, 15 Oct 2026 at 13:12, David Marchand <david.marchand@redhat.com> wrote:
>
> On Thu, 15 Oct 2026 at 13:08, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Since the minimum version of meson needed to build DPDK has been
> > increased to 0.61, the version check for >= 0.60.2 will always be true,
> > so just remove it.
> >
> > Fixes: c1d15cc8d571 ("build: bump meson version to remove warnings")
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

