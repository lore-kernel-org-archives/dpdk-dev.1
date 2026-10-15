Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200FCC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 16:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E0874060F;
	Thu, 15 Oct 2026 18:31:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5D4D0402DF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 18:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792081908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbt5rW4micN6Y6YL83T1XnClMjjMMt29j80zrqzg6sg=;
 b=Qwb0AniyHapZ3sKgL/sZuteWCuyhy1DO4mDX+qsyJFhrsXuAxc14SjobB6XA0G+HU51KZi
 8rXRyopnCs2sOKWes70J4p/qu9IRn1PZ9BfP5Q748GAtpte21F+ojWLe/NixLCJ426IBtR
 Hp4ON+KhwRvViXDzMa8RmoGUS5YYUiQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-7k5SimDrOgOTvB8YeGROwQ-1; Thu, 15 Oct 2026 16:31:47 +0000
X-MC-Unique: 7k5SimDrOgOTvB8YeGROwQ-1
X-Mimecast-MFC-AGG-ID: 7k5SimDrOgOTvB8YeGROwQ_1792081906
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5be456fa317so290886e87.2
 for <dev@dpdk.org>; Thu, 15 Oct 2026 09:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081906; x=1792686706;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tbt5rW4micN6Y6YL83T1XnClMjjMMt29j80zrqzg6sg=;
 b=q5NIeRWmX/1LE2IlnbBKyL9H4oO7TIeAJJtpJOALnXQCbI2NPrr62U5bMPuuhJfwRF
 KPV6tRpgqUV1n1mhS+N0z0cHTjTXf+AdmmOFexlJ8i6QNg1Ks5BuJ1vcysSzwqaY4xbb
 plcU8nceQiTYunTQWAgOBeM1EnVqL8lF9bRw2gnxUPndHo0HUk+DtF7pD5r/4TYZSOlo
 BvBnQO4xcK6Vbm7p3K7h29MK/UkHTI/4hP5CLJKL2xuUXuqxWFHC6o65lWlMdkG3SBAm
 gkrNg76ElnvJZsfRDZVpXatRVwiEfich812GL+KbHLJz9FWVHeiNs4zjV7u2OGXUUn2V
 Tigg==
X-Gm-Message-State: AFq9FYJVVr0QKL4rQhzL+xKAlzuwJ+mKtGrOhvN65NOHhuqr7w9Wvnvf
 G5O0w5MrIxKfDoJ/IBEvCvU3qrd4yVWzgf1oCdLGkaXxHKvl0sLxWUWenEw6oOCbptBndvMtJup
 NXzwQeusRJlQiSitaUXtubEdPndza1gWwyaio6jSLBs1gUwuosQK3IIC/kEvsk6zGrblgcfPLtT
 kxa6cu01wcUVRt9oqnrrw=
X-Gm-Gg: AYBFou23CquHE5ZhUox7f7zgzbIoCLiGXabnPtyHiC9yrekd9GsFAIQuuMZQVatCmfc
 ACtQDvEYxJk9ahbldNJyWWmeqdfwWXhgG+iYE97+eQz0sXOZhHI2xnbvZsufGDNPkBLaClKd/EO
 9PeWHUGQEkjF/GEq/wlGGoJZJTzIQRVoQ4o4iPf38JonlV9KEcFOGSjWyCcz25IBpX9p+UvhJ83
 7wWACHbsax65a4XaORWxfoNBVGEpElWPmt8PEZh3OSC+u/5
X-Received: by 2002:a05:6512:3989:b0:5b8:f4ed:2057 with SMTP id
 2adb3069b0e04-5bcde8c3f87mr7862454e87.57.1792081905745; 
 Thu, 15 Oct 2026 09:31:45 -0700 (PDT)
X-Received: by 2002:a05:6512:3989:b0:5b8:f4ed:2057 with SMTP id
 2adb3069b0e04-5bcde8c3f87mr7862447e87.57.1792081905216; Thu, 15 Oct 2026
 09:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20261015160157.3348253-1-david.marchand@redhat.com>
 <DM5JUAJZOBD1.1MJUHEI3YCXCO@redhat.com>
 <CAJFAV8zTVFEwzDrbOt9NLd8QjYNgFw2HEWQz_h=CKVnwaXkMgw@mail.gmail.com>
 <DM5JWJSS12VT.22J6MHQJOGKQS@redhat.com>
In-Reply-To: <DM5JWJSS12VT.22J6MHQJOGKQS@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 18:31:32 +0200
X-Gm-Features: AclHuK9j3vlc8XQ95mRt86xXhUgcfgVaCThK5e8tkTbEY53I_BvP7_Zj_Fd5Bk4
Message-ID: <CAJFAV8zNg1XJWN8ivq-3R-PJ7tfQLm9+jxoA+VbunaetOGuSTg@mail.gmail.com>
Subject: Re: [PATCH] ci: fix dependency on cmdline
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, Aaron Conole <aconole@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lGzSQDV3yPgKOsLJgE1lBnf6HsOeWNghGexawijoqRg_1792081906
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

On Thu, 15 Oct 2026 at 18:26, Robin Jarry <rjarry@redhat.com> wrote:
>
> David Marchand, Oct 15, 2026 at 18:25:
> > Examples have hardcoded dependencies see examples/meson.build.
> > Since the mini target explicitly requests l2fwd, this triggers an error.
>
> Ah, so we would need to add the cmdline dependency per-example?

Dependencies should probably be re-evaluated.
You can send patches but too late for rc1 now.


-- 
David Marchand

