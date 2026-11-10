Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BB3606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QgCltoP1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B000840283;
	Tue, 10 Nov 2026 08:43:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 1983D4027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 08:43:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794296624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UBtdnEd+q5cvay/4TRhMn9IFiF/3OEVVuU1ctNbsMOc=;
 b=QgCltoP1XLVLCbJHcz5HVPwmVVmrN4dYZTQvC8YSN48N1CsHd7S3aMukbwzyPQ9cOzvEvc
 yzN3yzlEYz5HrRYYLo/PhTKPKu+oabNjIbrEIf4N6CFUxP8Xpd36w8lXh/M0ceiczhgmEn
 0vsh7Ok4GqCWO+gKz3BiqYZR2xyZSPY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-uQkRWs8DMkKVpY98Qr-krA-1; Tue, 10 Nov 2026 02:43:42 -0500
X-MC-Unique: uQkRWs8DMkKVpY98Qr-krA-1
X-Mimecast-MFC-AGG-ID: uQkRWs8DMkKVpY98Qr-krA_1794296621
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3ab3061668eso6119951fa.1
 for <dev@dpdk.org>; Mon, 09 Nov 2026 23:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794296621; x=1794901421;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UBtdnEd+q5cvay/4TRhMn9IFiF/3OEVVuU1ctNbsMOc=;
 b=HKMnn7ZH0dHzbT5rCiNFflFmjssPPl/JfhD3qGanYgJPVdcTsBGnqv+Bp+96VK5AA4
 ddoNMi75jE3VOCLdoNhfIKkWTuhgoYPnYxFor5LBmP1ss7QTRxvQZ84MVbypaHNZAHb9
 A00c3+ggIC65Y6DmmJ8OHusINxfswTFgv/XGCpKXeKTWSmnti9ZICSuOqGXHiH58G5LN
 riRS96NfpI9FAzt6cDLppSzPaoXtFnn1M64QhbGrX4xvM2LGe8sWd10MuLnqByMVtm9J
 OWoK+TDA7+rJYmIgUCv/9VqjEVENW7Vxzo61lQC+M3oGdCU/81UM3Kh7TEB4w4Rys4g+
 lLVg==
X-Gm-Message-State: APuU4Z9SOhJAgw1v8EPzEzKNS0x8ILHOSr/E03xG1Kk6Yo5sU6XTTmRh
 9/aH/AQNNWfYola4P4qxHE5p9JqilTKdf4KDXbg1dSrE29/PWiEINWOcmvY4hYe0DsR8Z5NXzbj
 ixpblpgKhP49NyAhsM9zKB1VryVPXQXMKDg1W6aj2eUYvH7HhYwjH+zWnSfo4E7wvE1Rv8Mbfjg
 NaLTUGjt1Ls9xLHL59JJw=
X-Gm-Gg: AYBFou0TagHn304bG1M0vQQUggvCzl+e9+LtuEYBDHGjYfmtMXF+7CaQ7nvCKfCPVvV
 xdVxbFfFRxMSL/jCYbZ3AfOXnJDryH/cW/+h6IbC2WGTBbYSVJCwUBFRG6wKpW07P8zcSL1yrQn
 uK7EmOqjHNdwf9ANkqK/2gCZkRfPfeR0MpqviPjUsXELIplwckobOHurmErCAlg4xg33HlMAnME
 gp78hiMpX8hw1LUFBUZ/FqNSckd0hjTHve+YpFJzgbPqo86
X-Received: by 2002:a05:651c:1443:b0:3a9:89aa:618a with SMTP id
 38308e7fff4ca-3ae09107436mr3139021fa.12.1794296620949; 
 Mon, 09 Nov 2026 23:43:40 -0800 (PST)
X-Received: by 2002:a05:651c:1443:b0:3a9:89aa:618a with SMTP id
 38308e7fff4ca-3ae09107436mr3138901fa.12.1794296620477; Mon, 09 Nov 2026
 23:43:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104164153.1674329-1-david.marchand@redhat.com>
 <20261106145730.2561787-1-david.marchand@redhat.com>
 <20261109141354.23e03f2c@phoenix.local>
In-Reply-To: <20261109141354.23e03f2c@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 10 Nov 2026 08:43:28 +0100
X-Gm-Features: AclHuK_IHjPaUl-_lr9ja3coXb3AEOit39ZFii4IQx8u1rG0Qb4HwtNJMYFSkXk
Message-ID: <CAJFAV8w0gWA+jJmTcFOeJTi1S+j5+rSq9Ltn+aWn59yJu0Oy5g@mail.gmail.com>
Subject: Re: [PATCH v2] net/memif: fix use after free on listener socket close
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jakub Grajciar <jgrajcia@cisco.com>, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SiUMxWHmb8k7YtbUrdKUrppPR4GDoMxLLbWREpHHhvk_1794296621
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 23:14, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri,  6 Nov 2026 15:57:29 +0100
> David Marchand <david.marchand@redhat.com> wrote:
>
> > memif_socket_remove_device() calls rte_intr_callback_unregister() on
> > the listener socket interrupt handle. If memif_listener_handler() is
> > active at that point, the unregister returns -EAGAIN and the code
> > proceeds to close and free the handle while the handler is still
> > running.
> >
> > Use rte_intr_callback_unregister_sync() which retries until the
> > handler completes.
> >
> > Fixes: 7281511c2cfa ("net/memif: fix some interrupt FD leaks")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> > Changes since v1:
> > - added missing _sync in other call,
>
>
> Applied to next-net but dropped the Fixes line since that commit
> is after the last release. Fixes is not necessary during the merge
> cycle.

I disagree.

Fixes: tag are not *only* for backport purpose.
Those tags also give useful information when looking back in git
history, to understand why change X is done.


-- 
David Marchand

