Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2288C3ABC5
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 16:09:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B13AC4025D;
	Wed,  7 May 2025 18:09:37 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 50DFA4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 18:09:36 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4Zt0Zk6MBdz4nt7;
 Wed, 07 May 2025 16:09:34 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4Zt0Zk5VDWz3BqM;
 Wed, 07 May 2025 16:09:34 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746634174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=za45j2wuLMgC4dxq7wce29QlTTxXk7cfeUPIsPjLf4k=;
 b=FPjRuv3HrlCEurzMU0ZzPBY5Fbrj6OF7PRF8PgnbxphIZQrE7MbhZxsFQFJQhV91N6imHi
 F7SM/A0TJ0puO+cIsaqJA/BJwQOgCjFsV/331wXyHbLmH5iwLUKnDRysg0ke+XHv9PbkRt
 InbZRjKvXyGLpopWIhfHl4ak7rQnLtqYFUMJ+jY5L5JuRuMm2ipRTyFuJrxPB7E9mIEjZz
 S86l3t3/vGHQZv+QgbWsoNFCmB8VInov43Nq+qAbXIEDa1Ac5DuDVBElf7BQOzyk4Wln6Q
 DfKpyPlWIbDRg7fRFca6YCNWZWu5dbbrccst9l3/WL0G3vLX5JbbphAxS30hMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746634174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=za45j2wuLMgC4dxq7wce29QlTTxXk7cfeUPIsPjLf4k=;
 b=rk3FlVwOeUY8S3rfdO4QkigKEg/HPuG11ImgUCVWW5aKzp4JO4crOCg8Ix1U1N7yf2TJoN
 144ZmEE44OAP3buoDq2U6JMpZmMlX5maAd7lFLxDlfValCDXPFNsoAv6xRjG16VZxapobS
 q+oXsTWaChJ0ewMIoMA99T3kvWIm7n74oRPEKd87gAtuYGZEBiA0kzOmq62vDojhtTvT4L
 f2Es9ektLKStiCTBgwfggdHzcOH6fmJotg8NSRLSFsRKPQy5h5oRIE9cbRJ2ew6a3BS4yJ
 lCGCEwGD+UyPgfi/ARAgg/m8fCgh5gE9kDUVEC3U2k8UU5ZU84CFcZe2gSCZYA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746634174; a=rsa-sha256; cv=none;
 b=Pq/OBI59BMmD9809q8iOBoG4+ThhZiADbMQDOpziZhFqm6Rl0zihGR8pGjAw8QnRLefR66
 71InDetkC1YddDjvSOuKBm2dNlIhZqWIIsHA1zlQ7Ec4UdyBhLavGn2d1t2sEgLtXqGw4k
 nfC5rK1AK5NPUKf/Kp8qaOMteEpKfPsODMUPb1K7WG+ihm9ri3v030mugb94VefuG5VwC3
 FW9Ebi4qjxmw3Nbnh9bppTFLYa+D1rD5diH/PN+0XzNcZkr4CH1dRuY2hOT9PWtFZcaJIq
 Bgs9DXcAL2WUeXLxD0McPeLWV1cKByc1lb7OswU1EREUh7COHkIrxPbsLXEzfA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from localhost (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4Zt0Zk3Hqhz9j2;
 Wed, 07 May 2025 16:09:34 +0000 (UTC)
 (envelope-from jfree@freebsd.org)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 May 2025 11:09:33 -0500
Message-Id: <D9Q252DFOH0V.1CHFLNZDP105D@freebsd.org>
From: "Jake Freeland" <jfree@freebsd.org>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>, "dev" <dev@dpdk.org>
Subject: Re: [PATCH 3/3] eal/linux: Check hugepage access permissions
X-Mailer: aerc 0.18.2
References: <20250506175010.1141585-1-jfree@FreeBSD.org>
 <20250506175010.1141585-4-jfree@FreeBSD.org>
 <CAOaVG142x9ENgVF_p2GuhYA7wRuSXN83=__4D_+kXvxghZB-mg@mail.gmail.com>
In-Reply-To: <CAOaVG142x9ENgVF_p2GuhYA7wRuSXN83=__4D_+kXvxghZB-mg@mail.gmail.com>
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

On Wed May 7, 2025 at 3:52 AM CDT, Stephen Hemminger wrote:
> Please don't split message a across multiple lines.
> Open and access are not the same in all security checks, so not a great
> idea.

What do you mean by this? In this case, access() is just verifying that
we can read and write to the hugepage directory. What extra security
check does open() perform that would be needed here?

Keep in mind that open() will still be used to open the hugepages and
perform it=E2=80=99s own checks later on. The purpose of this access() call=
 is
to avoid saving inaccessible hugepage paths up front.

> Some analyzer tools may flag as time of check, time of use issue.

If this access() check succeeds (i.e. we have r/w access) and the
permissions of the hugepage directory change to read-only before we call
open(), then open() will fail like it does without this patch. This
seems like reasonable behavior to me and is better than having no
initial r/w check at all.

Thanks,
Jake Freeland

>
> On Wed, May 7, 2025, 02:50 Jake Freeland <jfree@freebsd.org> wrote:
>
> > Currently, hugepage mountpoints will be used irrespective of permission=
s,
> > leading to potential EACCES errors during memory allocation. Fix this b=
y
> > not using a mountpoint if we do not have read/write permissions on it.
> >
> > Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> > ---
> >  lib/eal/linux/eal_hugepage_info.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/lib/eal/linux/eal_hugepage_info.c
> > b/lib/eal/linux/eal_hugepage_info.c
> > index d47a19c56a..dbfa38b05c 100644
> > --- a/lib/eal/linux/eal_hugepage_info.c
> > +++ b/lib/eal/linux/eal_hugepage_info.c
> > @@ -260,6 +260,12 @@ get_hugepage_dir(uint64_t hugepage_sz, char *huged=
ir,
> > int len)
> >                                 continue;
> >                 }
> >
> > +               if (access(splitstr[MOUNTPT], R_OK | W_OK) < 0) {
> > +                       EAL_LOG(NOTICE, "Missing r/w permissions on hug=
e
> > dir: "
> > +                           "'%s'. Skipping it", splitstr[MOUNTPT]);
> > +                       continue;
> > +               }
> > +
> >                 /*
> >                  * If no --huge-dir option has been given, we're done.
> >                  */
> > -
> >
>
> >

