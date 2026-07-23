Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990ACC531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 07:15:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84CC24028A;
	Thu, 23 Jul 2026 09:15:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 15B674027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 09:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784790951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SvxyvXKS64nOBmaguiiqjBXDcBRCGnZBhMA9VcHb0kQ=;
 b=Y+lL52jse3WLWE2O97eBoBiBzhLJvPmC+el1zca59k/NBYGEcLdKkndK2ofuCTXShFcLAY
 frnwXqp4e+MPDp49f4tXiq2bZ2zXPGx7YQMDXYjC2IKwbtw29ucFD2/B+u6gbwNu0oBy++
 zqFLgk50DnOv8o006iEMXOkpvlGfINk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-JxGPJXUePgW1P3CguDiEYA-1; Thu, 23 Jul 2026 03:15:49 -0400
X-MC-Unique: JxGPJXUePgW1P3CguDiEYA-1
X-Mimecast-MFC-AGG-ID: JxGPJXUePgW1P3CguDiEYA_1784790948
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aebb33d6b8so256969e87.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 00:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790948; x=1785395748;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SvxyvXKS64nOBmaguiiqjBXDcBRCGnZBhMA9VcHb0kQ=;
 b=lNVMunDS10iMvfBojE6SBTfhk3pT/SbojWmJAXWXkhgVaTclXhm+WOZfcpCSDxS254
 zd1CfppVnsGZtkQXZMgCoFBzSe4Rzit8S0EX7yuObwAcEg6p365DcbKrXMEDQ1RL/wQm
 HLiQXqydA0EFAH1rcUQGeghSA6SpOXLXXZweTxi+YzjfYu5OVy4vgq4JePg6sRRNRrT+
 AwiybBhN5dqMfSbIBCoRV1oPbLB35A0TyjfTM7MXpXdv45z301m0zp3eNCNKgBc3nTFm
 IdD/luP5dicECqJg4/94JhrrewPIvdOiN86dyURWXnzuoJWCZb6GApzksScL1w94g39L
 6WVg==
X-Gm-Message-State: AOJu0YxQuKYVTs9zPNWmEmuYlIPku3gguAOnDbcQp+vQBQgZgDo6EKxh
 MoFkO/pizHq1RK87Cy4kr1AFkofFVOiwfd/GvSzPnxb2un2swS4PyJPgWKROywYnwFNt/Kokps4
 Ba9TVGCcJqRN2n2LO/x1lGtjebGrEfXUef94RntBTPhsbppL3ahSiKtH89e81ni5ooIYp6LkaE9
 tHUswcm2xDlJWQQn9UEHU=
X-Gm-Gg: AR+sD11F+oo1g530vh7fZF4X7PDHZyIwAU15lMvo1coapJvghfilGGbzA54slgZIVam
 MEkIxPmd9PTiDHYhAZgldkNZJ+4ddvptiOUTDyGHPDxYATmfixXxuGlCXZrWx1FkDfmcG00XJLK
 19RUrhs0EH53zZmXCLkFJpfEFGz77J1VOxEjghNo7fHtYbSdS75VIvTYWguDFwDhbMtJ/SToz+c
 wrko7BGRW6bzS5uqyqAVkBN4s1/1o/HNDXEUAZvqt1qe41c
X-Received: by 2002:a05:6512:31d4:b0:5b1:5f28:2198 with SMTP id
 2adb3069b0e04-5b2b2e49a31mr340548e87.3.1784790948272; 
 Thu, 23 Jul 2026 00:15:48 -0700 (PDT)
X-Received: by 2002:a05:6512:31d4:b0:5b1:5f28:2198 with SMTP id
 2adb3069b0e04-5b2b2e49a31mr340541e87.3.1784790947820; Thu, 23 Jul 2026
 00:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260723062416.1340761-1-david.marchand@redhat.com>
 <tOBZa6-IQjORkA4tX-aY-Q@monjalon.net>
In-Reply-To: <tOBZa6-IQjORkA4tX-aY-Q@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 09:15:36 +0200
X-Gm-Features: AUfX_mxtUDv2bqBT2ZRoaJQ_75jNWefLeaV5LbIlAP5mVrOGImkNpxlyO7qInFY
Message-ID: <CAJFAV8yX6ZG3M4LSKbziu3vrR9Zt=stFMBiy1VOyUyAcCmESyg@mail.gmail.com>
Subject: Re: [PATCH] version: 26.11.0-rc0
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n-o52jHVQnlvPf9uI7BOLhZNn8-BhplJbh3-2P95fyo_1784790948
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

On Thu, 23 Jul 2026 at 08:56, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 23/07/2026 08:24, David Marchand:
> > Start a new release cycle with empty release notes.
> >
> > The ABI version becomes 27.0.
> > The ABI exceptions are dropped and CI ABI checks are disabled because
> > compatibility is not preserved.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
>
> Acked-by: Thomas Monjalon <thomas@monjalon.net>

I forgot to bump some ABI version for symbol compat in ethdev and net/mlx5.
This is not that important, since Dariusz patches for removing this
compat will be applied right after, but I prefer not breaking
compilation on the very first patch of the release...

v2 in progress.


-- 
David Marchand

