Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A3B606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KzMTbygc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDD1240268;
	Fri, 23 Oct 2026 16:16:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB82040265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792764970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYW5I7A1cxYf7Dr+Lk1JUKLIfMNHK7cU2Bni8iIGxKw=;
 b=KzMTbygcC9fFvIZF3VqSXW2Xny+tyFA8jlsn3yinnKurPlj8mNbrvaHHADDQyaCf4q6YeY
 /6LD5EgNMSfhdE2xiFBI8nXsvwRfNpkh8QVsAX8xzrLNHSUTdk0rAYhv8llGr52iSE01Y9
 p0lGmtgVGQQRka4B5D6F04Ygc86ZLjs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-z5oDIdYENHK2Nxs6a9qdRg-1; Fri, 23 Oct 2026 10:16:09 -0400
X-MC-Unique: z5oDIdYENHK2Nxs6a9qdRg-1
X-Mimecast-MFC-AGG-ID: z5oDIdYENHK2Nxs6a9qdRg_1792764967
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab2f8ce13dso11952851fa.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 07:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764967; x=1793369767;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sYW5I7A1cxYf7Dr+Lk1JUKLIfMNHK7cU2Bni8iIGxKw=;
 b=DcKHF2g8vDwZ2JrTggW6Aiztu7rQ3z+H6cwzEXS+2YrW375TAyuMhFVOnKv8sk/P7W
 9XLurmk23GGffMmYSzPExtVWP4OOldKButZU27dlXYGPs8Pi4C24xg3sM0xEgoWSMhUT
 onelWLqWu7jdybGU6g0kvgGYMzq6pdZLqio4zm7k9DAAn353eJXNKQv1pQWT5srbUFt5
 /U7l1OEIfaPgj1kieqBpHUtHh5tqm5rNnwhW2sp9wB1wLhyWug1QuOW/w4PMKLmTS6mw
 TS9WnLaUJeQI1myfhHa09Cfro8r6JHkAxa6zhkpBOmmzmwYAUUH3YMO6rCrsKwWkynru
 yAQw==
X-Gm-Message-State: AFq9FYJsyYLr9YPX7NONqOYFIl3+7zmBK0LRncfXt45Vjy9F9Vopk+RW
 ADFfR1cUs66PokVwtHGwSYqFTIEbyPEO27mVp5eh4bDgF9Swi4koDtBjyoVQEE5W84vo43q/z6D
 NkKTJdZrAeNRC6zZxH96NRD/90251EXBkSjkBm962v92XUm4b6JBw8NT5KExyMWO0Vk4FuFmxXy
 xq2RvpXwRs8xTeargQYRA=
X-Gm-Gg: AYBFou1pmvXlaTRW993B13hOdrEDIPgT+Ko1bL1VQalef7i9v3sYS1ZdJFlUWNyu3mB
 0eqoEvJYhkZ41+VGR5eGcglwCqBGkDfnTAst1SfepbKn230pP3rM8UkV8unOxzxli3HC+KKF4Hb
 uWvaCp6IegeoPFqQhYlP1eUwCyxUq/Lvb96HOXPgDR2lubtiMhEZuROU3HN/nlzPP3M06COFqSA
 Aeh7mabC7kfc+23ShqlyAtPO9er88mZVJncXneiIMgcZ4lZ
X-Received: by 2002:a2e:be8d:0:b0:3ab:4e70:6959 with SMTP id
 38308e7fff4ca-3ac51146c28mr16145041fa.19.1792764967273; 
 Fri, 23 Oct 2026 07:16:07 -0700 (PDT)
X-Received: by 2002:a2e:be8d:0:b0:3ab:4e70:6959 with SMTP id
 38308e7fff4ca-3ac51146c28mr16144951fa.19.1792764966825; Fri, 23 Oct 2026
 07:16:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <8e863c1aa5d265fa27560dd27ba61858c217ff3d.1792763492.git.anatoly.burakov@intel.com>
In-Reply-To: <8e863c1aa5d265fa27560dd27ba61858c217ff3d.1792763492.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Oct 2026 16:15:54 +0200
X-Gm-Features: AclHuK883xF7R6fHNgxXmV4MuGmI8RqoO6lZcckBxSEqfxX5S4C-d5Ct1Raeqws
Message-ID: <CAJFAV8yi8VxCz8kyuw=Qz155KPzWw2OPGMPJ0nRH+HhBFTMHsw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] interrupts: fix event arrays copy on instance
 duplication
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Ray Kinsella <mdr@ashroe.eu>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ejQhTeDOUwyrgp6M2td-1E-qakpp1esneMgL_qfyDo_1792764967
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 15:51, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> The event FD and epoll event arrays are copied using the number of
> entries as a byte count, so only a fraction of the entries make it
> into the duplicate.
>
> Copy the arrays by element size.
>
> Fixes: b7c984291611 ("interrupts: add allocator and accessors")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Thanks for working on those issues on such short notice.

I already put a series for fixing a number of issues with interrupts.
As part of it, I would remove the whole duplication principle.

Could you perhaps test your series on top of mine?

https://patchwork.dpdk.org/project/dpdk/list/?series=39749


-- 
David Marchand

