Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23602CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Oct 2025 16:29:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03328402C4;
	Sun,  5 Oct 2025 18:29:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 36791402C1
 for <dev@dpdk.org>; Sun,  5 Oct 2025 18:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759681755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9lX/i/ni1VuRETOkwHYN9U0Yj1XSlGKbikGXOV/Yg4g=;
 b=DT3NSO38CQMJEZBrCTtxeKyCvLsNn9DQ7TykYRLz11jO3k9YYBn2A6tMH4i9hJOpBCp/cP
 s/wr2rN4yev5No8D555ImtEkNiMvLS2DXyHsMYcxK5PkWZE/xlAMVq619t8l5odMo4I7Ps
 PMJQCqmIsy2uJHFUH/WY+2+ZqpgkRd4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-2gMo51phPSOs53SPq71ylQ-1; Sun, 05 Oct 2025 12:29:14 -0400
X-MC-Unique: 2gMo51phPSOs53SPq71ylQ-1
X-Mimecast-MFC-AGG-ID: 2gMo51phPSOs53SPq71ylQ_1759681753
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-36c983e4c21so17368981fa.1
 for <dev@dpdk.org>; Sun, 05 Oct 2025 09:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759681752; x=1760286552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9lX/i/ni1VuRETOkwHYN9U0Yj1XSlGKbikGXOV/Yg4g=;
 b=hy5WVnhxPhH1I0UoGMVKEPihn3Sn5JpwsdsdJqVKd7S76QOAg8I7A71ehGyqYfI7x1
 LcmLTH2i+2tPqEkUoxv2mza3PQHcQIl4mkKqomD3yNxoaS9eJmcmebdud/1IUwHXLJC8
 K2Y4gX8Tbz7q7SgWpqAS0/bU0KK0aPU4qRH1Ft2XDHDl6qAJDsTnbDR1DGDkFe7alLh1
 pIx710x6ny+UQerGHx1ddzlygkZR+MJs0QkzOhKbY1l/ME8TD92qgKUHZDaZbvkT7aA9
 mPBtu3MUobbDPT1x6pjqoEX8PFBpUSp1Ajpgox4DHot3STA1tnXsFOnrtv3cxsdlGNlK
 ToPg==
X-Gm-Message-State: AOJu0YzsiZu7kG9UwHSJpPf1pOuWuFQl/44RZ8jfbYY2S4JuIb+BhrUR
 QQmhQ5eHR9a6uSO0QVaR+RmugWne+sJZ0wVvhY0zK+HFIAVK8BV5ipysUJFtAKiDNS7gPUbPu23
 uw0uJu6eyWcf1XjYCcv90QFlFJP7MEooQOue7xW1NaUl+U8IpPtd2mxkkvrMEYtdC4UHgsrwvN6
 2B/LTDByNhJLxGUzNBVrA=
X-Gm-Gg: ASbGncsIciiZYdE6gN5vNWKy38mu0XDlunCE2o/gPvxlCFjPfASWJx0gQ5/jfsLqcCk
 3ICbpgRtF7YwaLCE1bh7QXw185biuB4/W0BVHc/g/rRjC8IyhxyPzc+W4e5FMifLGw9MYrua93G
 fTNAon7ehvKgdrbbwtt+St+7Ih8ifq
X-Received: by 2002:a05:651c:19aa:b0:367:74f5:6fc9 with SMTP id
 38308e7fff4ca-374c386d34bmr27495721fa.32.1759681752526; 
 Sun, 05 Oct 2025 09:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXBE86IfaYaNinp4teOZTwBcIRwrQKVNyJgqCcUA/3+ajhLvfzYGakQkEplUFKrAG2rTVVDjqLG0emuFhO6bE=
X-Received: by 2002:a05:651c:19aa:b0:367:74f5:6fc9 with SMTP id
 38308e7fff4ca-374c386d34bmr27495681fa.32.1759681752105; Sun, 05 Oct 2025
 09:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251002165546.523435-1-david.marchand@redhat.com>
 <20251003065101.617467-1-david.marchand@redhat.com>
In-Reply-To: <20251003065101.617467-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sun, 5 Oct 2025 18:29:00 +0200
X-Gm-Features: AS18NWDGtGngP0Zfc9X5H_05l9WlbJ9-XYTbjjDexYtdjf_HYkExRpNmkq5VAwY
Message-ID: <CAJFAV8yQ0RHBPfVYMYfEAjmc+gmw8k9Kje8n8PHH=5gY+58=Ow@mail.gmail.com>
Subject: Re: [PATCH v2] test/debug: fix crash with mlx5 devices
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, dsosnowski@nvidia.com, stable@dpdk.org, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H1TlKDkSyxKzlpfsklgpG9Ebk2PRXe7mcUuwYn8FTPc_1759681753
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

On Fri, 3 Oct 2025 at 08:51, David Marchand <david.marchand@redhat.com> wrote:
>
> Running rte_exit() in a forked process means that shared memory will be
> released by the child process before the parent process does the same.
> This issue has been seen recently when some GHA virtual machine (with
> some mlx5 devices) runs the debug_autotest unit test.
>
> Instead, run rte_panic() and rte_exit() from a new DPDK process spawned
> like for other recursive unit tests.
>
> Bugzilla ID: 1796
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks for the reviews.


-- 
David Marchand

