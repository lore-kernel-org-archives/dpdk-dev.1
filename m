Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01947606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=EsQG5W/9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27157402B9;
	Sun, 25 Oct 2026 16:55:55 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTPS id DFBB640150
 for <dev@dpdk.org>; Sun, 25 Oct 2026 16:55:53 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e5fb79ce82so14386125ad.0
 for <dev@dpdk.org>; Sun, 25 Oct 2026 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792943752;
 x=1793548552; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XAG39lCGyAYKAQV89+7xEACKN+gUeyWkRspzt8D2HKk=;
 b=EsQG5W/9+hm4v1In5JOXoG9nBMiPUCuyo/oBefU5vSDkADYucnSLiiYF4wRiXybJjp
 sxDMW2sKAW646AyR7V2/ZqWl+Ni0mJDKzG4UseQ/2prQZmHfyZGM7EPxvLFKCCzdxah/
 DMguu6UhwNNgTp65SmvZ89yPV6H3LWtsHocrH4kRzrE8+UyMAGrMfGIeFaZ6z4h8f4O8
 P6Pu83L5g4LKv+xBF5KCuWcXAUMKMUGuok+zurpQlJrfJa/cMnxvAr1U+P2Xt32rv8fp
 rWDi5Z48c9Cz2PdWGFGRguq4ELgdT26GibMGf1rRKyF+Enp3lDe8rX0mDkpIgcgv2nS/
 CluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792943752; x=1793548552;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XAG39lCGyAYKAQV89+7xEACKN+gUeyWkRspzt8D2HKk=;
 b=o0DXvTcOUcIk6LBydm3QtMgV0SrF8WWcJ5OtIQJTW0qTEoVOObKhhKgBfWJ4Bob5Xk
 i8o4wuxP262D3fybzlnrABgwhfYZb5+1H72zy88YutIP21y2SOW1itbqIjhpqkUoYbEd
 2UIqxZ9qplaM3amcDndPMFNFzDiFGxSmzKODojaTaYxFbmQ10EI2YkHzyyoe0bWd9+y6
 Jz8UtLRm8HS9SPNonFtoYlKT3/L0EUnChOYTKv14VREKwFek76949IkxKxCGz1f2IvjE
 u9/u3fX4MXP1OQYiC0tb1mSmUnL+rZ9arb+b1o696ODvK0mmno5pz/TLFkICvq25XEIM
 XSig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpWWdTX14WS8MT16Fh+hiVlzoGVlRgF2xXNW7YYcxglHjCcm+yqB4idpxdIpWeW0WIYxs=@dpdk.org
X-Gm-Message-State: AFq9FYJtIEM+r9T4sBJmxFcgIGpNXliDNiOmv85nQU6J1UsMe2BNw64o
 Lwhnzpvgg7RNHJ/h6Wsebf6+svb2EVqGMrHBHnYDSVhmv56RwDE7VuU/PzWgp1RBYMo=
X-Gm-Gg: AYBFou2/XLog1Fh5pJ9w7nj9bR4zb2tvq4VFCdBa46p8b8pzfuoGcNl6HRXHfHZ+pmP
 S0HENddOZxp/rM5sIJWEIvK+mhRAF5eEP1t9CwomyghjhPsznSgqg/rcUzdt4O0ksHm0wttSD3E
 zotC0eV/FtyVeCEIoRgbO+ZvDrKESkDAfTE8hHfYv6hO9t7m0zvzMEhtw2hx1gtOJF+f3Cj7NFA
 e4VSGIuAhjM+OYqfwRYVUPVFyZqfndyP/MbZ5Kay6bjf0GQcxsrmEVZ4VmZxfoHVU4kJB9L9Rfy
 r6HT5y2zpQc+ei5XsVxH1MG3gkBuzuP5qrgAoKMtLpFAxwDeUqV1BJVr9ZsNgj3wvBkzbzvv+HK
 9WPZIedjriHRgBxiSrZoxFRwZdXlzeB+9aS2/Wv+SeXjYAGPc0PsBygGyOlxWes/OnsfCMZx9Mo
 9aWZsj2R/85Rqorn03feOTT974TqwaQ3vy0n+SvhgSMk7fBue5ztf1J1kwtslVw+jp/ZgZ8Tvoi
 m5EfMCaIqlnbz7OPAnHndjFXVtGqVD/bsn9mDluvPXiDWmxURYNi7rMQFEY0+oBlCjxXwf6Nr6X
 +WaVsxshUonwjKjDG5Y5HRy933OkawvZyg36vHUmSVk=
X-Received: by 2002:a17:90b:180d:b0:3a0:7261:d58e with SMTP id
 98e67ed59e1d1-3adead2fe65mr4435751a91.22.1792943751949; 
 Sun, 25 Oct 2026 08:55:51 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0977asm5190394a91.13.2026.10.25.08.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 08:55:51 -0700 (PDT)
Date: Sun, 25 Oct 2026 08:55:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chen Zhao <ch3nzhao@gmail.com>
Cc: weh@microsoft.com, thomas@monjalon.net, dev@dpdk.org, stable@dpdk.org,
 dpdklab@iol.unh.edu
Subject: Re: [PATCH] net/netvsc: fix event buffer leak on realloc failure
Message-ID: <20261025085548.3f5c7e31@phoenix.local>
In-Reply-To: <20261025021802.3343047-1-ch3nzhao@gmail.com>
References: <20261025014634.3295418-1-ch3nzhao@gmail.com>
 <20261025021802.3343047-1-ch3nzhao@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 02:18:02 +0000
Chen Zhao <ch3nzhao@gmail.com> wrote:

> Hi,
> 
> The AI review reports a double-free and a dangling event_buf:
> https://mails.dpdk.org/archives/test-report/2026-October/1069492.html
> 
> Both findings are false positives:
> 
> 1. On successful reallocation, goto retry skips rte_free(old_buf).
>    The retry label is outside the ENOBUFS block. Each subsequent entry
>    into that block reinitializes old_buf from the current event_buf,
>    so a later allocation failure frees the current allocation, not an
>    address retained from a previous successful reallocation.
> 
> 2. On failure, rte_realloc() returns NULL without freeing the old buffer.
>    That NULL return value has already been assigned to rxq->event_buf
>    before rte_free(old_buf) is reached. Thus event_buf is already NULL;
>    no additional NULL assignment is needed.
> 
> The patch preserves the existing reset-and-retry behavior while freeing
> the old allocation on failure.
> 
> Thanks,
> Chen

The CI AI model is still using to weak a model and I never believe anything it says
