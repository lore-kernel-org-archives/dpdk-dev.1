Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBB4CCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 07:43:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ABC4402E2;
	Mon,  6 Oct 2025 09:43:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 38E45402AF
 for <dev@dpdk.org>; Mon,  6 Oct 2025 09:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759736579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=I4voYmyOQ4tf+Aeoce3AWpGxV/E0SjcmfvVZuUjOK6E=;
 b=aFXuDdCp7JUKAfT/xXqQ3u+q32sgcILo5dsZkjwD1j/CujCx2weuINBE4t93inyJ4nBMLx
 YudxVedSsamznAItcVidpYO7maCh8T1JPBnaBt957eiJaz0XFOqsbJ5qlNbfNt97ZP21lI
 Gz/U2GT7p6teppaLe+lwwB38oC5MOM4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-FPX4t2lKNOSYxcwxxzoQJg-1; Mon, 06 Oct 2025 03:42:58 -0400
X-MC-Unique: FPX4t2lKNOSYxcwxxzoQJg-1
X-Mimecast-MFC-AGG-ID: FPX4t2lKNOSYxcwxxzoQJg_1759736577
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-578fc5ee67dso2558240e87.2
 for <dev@dpdk.org>; Mon, 06 Oct 2025 00:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759736577; x=1760341377;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I4voYmyOQ4tf+Aeoce3AWpGxV/E0SjcmfvVZuUjOK6E=;
 b=sAJSwmcKoQJTBOWUE4ccbC2bZy7Bv0Qt1tZqZPYSC/X1Kk20ewZ3JF9uTZOjG7dHPz
 E8x5dQDcV9XihS+UtufTiXSi4ePCx9PZLEgRGtSTe5agj6Qj1GLwp99GkgtzUTNcudw0
 hRrPrC2CLDeIvx8AI4JjriQu0G6bqdTsVAj4IJXE96PEFOxCMpzvNmy0eAV1WTYy2/oR
 PhglyZyw04BfXlyw+eing/YId5wjS4n0imCWYfaG5/ps56HeCWaKwmIazRc72q3UuOeA
 PtbmQxQGuVlnzMoFDThdTdZGGE4xyg/JS/XlaOWlxAK6gD3RqDzfe62HUPRXqI4SmU0U
 966g==
X-Gm-Message-State: AOJu0YxUX0WTXVDsIW44byVUVWrRdqRi7fScA7T8A0/JOOlcY6sb76EP
 Z+/ATYVvaE/FPlEJyhOWocFf6UmtOcbgFuW7c9pORaoVHv4cotNv4ghieBYDla41TRNSfcu/gkp
 gMtgwIicbLucOpaO7FO3TBkFkLH/AoaBh3pkqJQy/UiR4BE2GBWGonColmAAuSyODsio9sgQqYF
 uVlY2ZnsOaNLSxWlHQAOI=
X-Gm-Gg: ASbGncsKd9JeJjpXpz1ISn9p1Krp37uFPeX+XrKzvJd7lBcOLMk3GQFagkIPy3cB9Mn
 /mYceV/OeD04vYGjnuNaqlRDGCcXCu+YOrwmu99V/AKspowGDRU04ny6JvWMwYMb0HQCun4tzqG
 4Wuqdv6fXL99AbDs/eunUXXJB5eRCZ
X-Received: by 2002:a05:651c:1992:b0:372:9992:1b0 with SMTP id
 38308e7fff4ca-374c3823058mr27673081fa.31.1759736576724; 
 Mon, 06 Oct 2025 00:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3tTcsIh0iqu2Vi8rJZ+0ylCxE3Pe+6zG5m9nwQKN/RiHDh3o15qe70ro4KXguzgAOXok7x82ep5qKQJ105Z8=
X-Received: by 2002:a05:651c:1992:b0:372:9992:1b0 with SMTP id
 38308e7fff4ca-374c3823058mr27673031fa.31.1759736576233; Mon, 06 Oct 2025
 00:42:56 -0700 (PDT)
MIME-Version: 1.0
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 6 Oct 2025 09:42:44 +0200
X-Gm-Features: AS18NWB4d8yN_SdI0kLxV0Iu2ncv_ocSVI38-RXSMaG_Fzlmsml3N1JtTbj2QKo
Message-ID: <CAJFAV8zLgkqEyifkG0t5f22pu+55PUXAKXdQXHHK7n2sxenTzg@mail.gmail.com>
Subject: Build failure in OBS with openSUSE 15.6
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, 
 Kevin Traynor <ktraynor@redhat.com>, Aaron Conole <aconole@redhat.com>, 
 Patrick Robb <probb@iol.unh.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cqCdkpofCkUYaRUBYyxjTeMg2BFUV-LDrnmJvi4kDIE_1759736577
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

Hello Luca,

We have a build failure in the openSUSE 15.6 job in OBS.
https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/openSUSE_Leap_15.6/x86_64

This failure is due to 4a04a346e7f3 ("vhost: simplify use of
pragmas"), which followed dd7fdfff9bc1 ("build: remove support for GCC
< 8 and clang < 7").

The openSUSE 15.6 job still uses
[   39s] C compiler for the host machine: cc (gcc 7.5.0 "cc (SUSE Linux) 7.5.0")

Is it possible to update to a more recent gcc?
Otherwise this test should be dropped.


Thanks.

-- 
David Marchand

