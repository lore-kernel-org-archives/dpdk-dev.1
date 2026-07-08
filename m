Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C988BC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 12:52:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95CB340268;
	Wed,  8 Jul 2026 14:52:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 033B340265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 14:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783515145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7eL/em6SxGNLRHn6lfA8xHcs91W7H/nWen2AWpclpAM=;
 b=VljCdWOjcOTdajSa6rWMlm/gHNfOJ/39oIIMdtYntjuBRkM3+Lew6RFqyGAPLc0MkFDak5
 jhkcNUn38rbr0n/GLwifXrX8OwTf4uqmDGZKpK6UPA1/NscQeXCltLYHjzBwNSDWenFYBt
 b1z6GOhjCx5ef9iRxtK5SepGzP9mQkc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-isnytlP3O5S5uOKVj5o7WA-1; Wed, 08 Jul 2026 08:52:24 -0400
X-MC-Unique: isnytlP3O5S5uOKVj5o7WA-1
X-Mimecast-MFC-AGG-ID: isnytlP3O5S5uOKVj5o7WA_1783515143
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39ae216b900so3992671fa.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 05:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783515143; x=1784119943;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7eL/em6SxGNLRHn6lfA8xHcs91W7H/nWen2AWpclpAM=;
 b=j2eO5ALw/D+xzDSmys3Ju5wBbik2Vero+uL/1NOALtddRPz3P8Abg7Cp3tZynQriRL
 Awszsknq5QeNrdl723j93WmClR0QC0dYwdmM+EpwEGhrzIazMqX5y6V5xo/Ax+oMmYbX
 kgzRGSM7k/tF1gFHrgLBQKC9ZLlxTSg86JjuNJMt8HOZpuAApSx2bxoE8IQneLLC73uK
 xnSZiPmWKsBzUdNXffmbuV4Fcyhvd78g0yZ3gaSvqmYvHhB0uvBpbo8Tbouqkmdg81c/
 UFJDy1Inhr0PDFbEWk1weVa4Si2VZptjzdkwCg2eVx3qllFId/mo+hI6tSiyhH1rZ+k2
 gctQ==
X-Gm-Message-State: AOJu0YzYF/cUPoG1aDNJBurGkqW5z7B3KKNAPpmmkW+4p+fzwPi5mJ5S
 lyeekpr603mX5/D7fkMzAVWGfkrXVCLnQNFagsAPWjKLJdftArIshtvdg/fK4ezRjpHjdYaT+Pf
 QgkjGGjqiHmCgdwstEhE/zttrnk6hB9Y+p1mm+nnS3XR1fzBqVlP6IXi+Z2FyEMD3cnLT6G6HJb
 VXPa4uNy6ywJ/2p6Z31to=
X-Gm-Gg: AfdE7cklG0xTwlpuX9xgw3WU1lp2D19bI0T3Aacdpb9HVnTDhBA3wDJWAWWccZ79y49
 qCIKX4kGsFVELb4vh/GYc6vChl1CNXzQJakeWorHSwo0hZkXi6kqryZ6COUNePDxqlhdFinWlBx
 wA/sYfAKMoifx4QcwHXEe3H9CQaokQ3CgFyb49Nmc0C0Ol6TbNT4F/gthlNTf4pRMXXar2b6QBn
 F2YBm/KgGKYUJTa7GrDaYzxDQYP1Trs3XXTI9LPWrRbuBA7xD0ovJIMNrs=
X-Received: by 2002:a2e:9c49:0:b0:39c:7859:a2cd with SMTP id
 38308e7fff4ca-39c79994846mr3985481fa.13.1783515142668; 
 Wed, 08 Jul 2026 05:52:22 -0700 (PDT)
X-Received: by 2002:a2e:9c49:0:b0:39c:7859:a2cd with SMTP id
 38308e7fff4ca-39c79994846mr3985411fa.13.1783515142178; Wed, 08 Jul 2026
 05:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260706145510.680077-1-david.marchand@redhat.com>
 <20260707115551.967336-1-david.marchand@redhat.com>
In-Reply-To: <20260707115551.967336-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 8 Jul 2026 14:52:10 +0200
X-Gm-Features: AVVi8CeUZYtw288qnJYaiYXaF40vya7wohuEsFL87AmDs1tSnuliEiJM6fy7sbI
Message-ID: <CAJFAV8xu1zqhaaMj4-JYp+tew_YHW-CGVfNMRxNKqCn5DX0MJQ@mail.gmail.com>
Subject: Re: [PATCH v2] dev: fix hotplug notification to secondary
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, fengchengwen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kHAIMhscym2Be6oexNSPwcMKPjdIyJlgVXEZq5QWNY8_1783515143
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

On Tue, 7 Jul 2026 at 13:56, David Marchand <david.marchand@redhat.com> wrote:
>
> There was a logical error when making some last minute change.
> Fix the no_shconf evaluation.
>
> Bugzilla ID: 1963
> Fixes: 1a2e26d8701d ("dev: skip multi-process in hotplug")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

