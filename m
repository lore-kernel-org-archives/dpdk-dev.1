Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D50C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 11:04:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EF8040697;
	Tue, 29 Apr 2025 13:04:02 +0200 (CEST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 by mails.dpdk.org (Postfix) with ESMTP id 2267740263;
 Tue, 29 Apr 2025 13:04:00 +0200 (CEST)
Received: by mail-yb1-f177.google.com with SMTP id
 3f1490d57ef6-e73120cc26fso3792339276.0; 
 Tue, 29 Apr 2025 04:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745924639; x=1746529439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vIDbZjSeLE689k1gEIxTQbKb7tVzt7H7mkqXfM6XyW0=;
 b=m6kUtEIDvy4fxZvC9WEdiqPtrLGHxVpEYGs3hAL0FCFu9Wib21vdEW7WaAAE+Tf4SX
 BqGKqHx13Uj7DFU8N9hlVQniF0pJW26oyCAbSLKSBAjRrZizWkHKaANmXyk/qKsrUQ5K
 K9vHk1BDnnao5oo00xqiaVQT8sQ6H0nRRROD8F3VaPBrkwDGAc37LLvK1P1hqKwzvegR
 ftHuoW2yulN+Y9lWyzT41f/BtFk9K+ON2ctRYSgom+C85g/oxZm9gwkvJgWDEQ+fHrA5
 LT2Ns0TUKmFkajo+q+WuFizHylAEEus2hlZ7NIr+nc+91tsVq7ySETxzxzHosH8KCJ4/
 GWFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJE1ugh/pAlr8yspP2wbpfNxB7YneB2bf8USmEVDY5LjIS2F+djZcsKev04QGX+2aterFGbCtS@dpdk.org,
 AJvYcCUz4MwIkJ2Rio1BpI1REZ+cbJOx5P2yHSwlUd9CPQiEI+x4D2tOT2TK5ta0zGkzdbGllQ==@dpdk.org,
 AJvYcCVYZRNjK8+S8G8v3jDPoSiOc8w5TAlpf69t/PI56yXkcwqSb4ujLP+qljF2x6Drv5TyA9dp@dpdk.org
X-Gm-Message-State: AOJu0Yy6bdwgF8sF5dvZYovhtm4hDMl1RFGp1cG/owTYjraubX/yXZwj
 i7f1YsRZdmqfFgFojeppw5ryiRu1fBdGGzZMbUBDw/GzFpOimxTrQAXCnqCx
X-Gm-Gg: ASbGncvlo8/jWN+e4JfkCESNcEs6sv5XiwBrzwen+H1+bliM7+jESje0ph/CodZrYnt
 mW40hqi6K1aeZbw9qJHpiVCC4tMTz4R9UMVqh6uGfabxMm0ERb9WRtc/T2zFksk3gK5xLT/1m3c
 SheeeOhm11CJF10aP+T3wfMe+pDNR9tASzXN2zYLdbEJCwG/FJkwM9DUfBX6LXv3jMJ3WVIOt3h
 fL9AOtgN6Hvqk5wMp5HjGOpSTTqUauCK6N6QvsoGi6PtIqGMhxNurHHTyXNwZp3F8T+NHmhhCFN
 ruupJHIIZeXWiU3v6kWku4QL4jbsonbeKPYley1HB3XCbrBCbgsodTxfsght51g+Yz5ieLpyhF8
 AJZIexlpceSxh
X-Google-Smtp-Source: AGHT+IHZRrbc7P5m4YsmzSgF+bBBhiGqpMgkSqqcY6yRY7Wc5D2DDJ/9paO7wHpvowHQiqdmLR6XIw==
X-Received: by 2002:a05:6902:e0d:b0:e6b:80e3:2d00 with SMTP id
 3f1490d57ef6-e7323384676mr16380849276.17.1745924639254; 
 Tue, 29 Apr 2025 04:03:59 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com.
 [209.85.128.180]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e7303a7ec3csm2752865276.13.2025.04.29.04.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 04:03:58 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-700b17551cdso46359647b3.0; 
 Tue, 29 Apr 2025 04:03:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUNKQunZxZjfyIyAegvT5VlrYw7KMNnq4uGPVDSqSd3ay8rLl/wlUbjx4Ig0NbPZpIQqQ==@dpdk.org,
 AJvYcCVYSgwttD9YReGAbu5mWU9CWjW9T1DflBm6TwfqiB5F3QiCHXnlIxy5DxCvwD6ybD72UwuLLwrt@dpdk.org,
 AJvYcCWbBgh20WmfLipIs3uah/TYe9BsOTx1zTHCCCLY13rtyVnjyVxB3eFN7zVUnCB5BgJQ7iNx@dpdk.org
X-Received: by 2002:a05:690c:6ac9:b0:708:16b0:59bf with SMTP id
 00721157ae682-7085f23883emr172935317b3.26.1745924638210; Tue, 29 Apr 2025
 04:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
 <8fd14d21-dea3-48ea-afd3-ae347f566bb1@redhat.com>
In-Reply-To: <8fd14d21-dea3-48ea-afd3-ae347f566bb1@redhat.com>
From: Luca Boccassi <bluca@debian.org>
Date: Tue, 29 Apr 2025 12:03:46 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnTJbf_-V4UP-=xDmgOXYvhTxgs87yimSo==+jK=nPn40g@mail.gmail.com>
X-Gm-Features: ATxdqUHlDAvQjp8wPrFmLDcmhsRiqFEx2sSXTJJVjoMAI94nYdXHKGbBAny7zMA
Message-ID: <CAMw=ZnTJbf_-V4UP-=xDmgOXYvhTxgs87yimSo==+jK=nPn40g@mail.gmail.com>
Subject: Re: meson error on ARM Grace server 23.11/22.11
To: Kevin Traynor <ktraynor@redhat.com>
Cc: Patrick Robb <probb@iol.unh.edu>, ci@dpdk.org, dev <dev@dpdk.org>, 
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, stable@dpdk.org, 
 "Xueming(Steven) Li" <xuemingl@nvidia.com>
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

On Tue, 29 Apr 2025 at 09:31, Kevin Traynor <ktraynor@redhat.com> wrote:
>
> +cc Luca/Xueming
>
> On 29/04/2025 03:43, Patrick Robb wrote:
> > Hi,
> >
> > At the DPDK Community Lab we have been running CI tests with a new ARM
> > Grace server for the past couple of months on main and next-* branches. I
> > am trying to add LTS runs now, and ran into a snag with 23.11 and 22.11 for
> > this system. Stable maintainers I'm not sure whether this should be
> > addressed or not for hardware which is new and didn't exist when 22.11 and
> > 23.11 were released... but I figured I'd make the tickets and find out. I
> > attached the meson logs to the tickets and if for whatever reason you guys
> > want to remote into this machine, I'm happy to setup the VPN and SSH
> > access.
> >
> > 22.11: https://bugs.dpdk.org/show_bug.cgi?id=1703
> > 23.11: https://bugs.dpdk.org/show_bug.cgi?id=1702

Assuming this only requires some changes in meson to accommodate, I'd
be fine in accepting a patch for 22.11 that enables it, if someone
were to send it. If it requires more invasive changes then it would
need to be evaluated for risk.
