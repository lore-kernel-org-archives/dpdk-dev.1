Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B79C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 09:54:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41630402F0;
	Mon, 23 Jun 2025 11:54:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 63A7740041
 for <dev@dpdk.org>; Mon, 23 Jun 2025 11:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750672479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3Y324C8NcxOwBErKpoWtIFlFy8T/NR7Ra5Zmw4cjzk=;
 b=PC3RaQWTUwVArppdUvseytBQOjzxKOkEjldgWq4jU9iP3jcW1yQu0VcVsKFkHJrXUAFy8m
 3KTgFaXVjMizCKqcCz/joRauDx1Glcsk6wNSDeeUYIsZZEs+qI/UwRiH1c4xLVaB69j4l3
 NGp5iTKfIqxJ+KMdmRMIF0EIquXyrMk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-nDGqjk2tPOCx8-Tg_MxUSA-1; Mon, 23 Jun 2025 05:54:38 -0400
X-MC-Unique: nDGqjk2tPOCx8-Tg_MxUSA-1
X-Mimecast-MFC-AGG-ID: nDGqjk2tPOCx8-Tg_MxUSA_1750672477
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-550d7bd9a7fso1785853e87.2
 for <dev@dpdk.org>; Mon, 23 Jun 2025 02:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750672476; x=1751277276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3Y324C8NcxOwBErKpoWtIFlFy8T/NR7Ra5Zmw4cjzk=;
 b=mLhZr5/TzQwzdrt06T7+iwWn4KjkNlmC4XlXpmEB/TzZOm60v6xIWaTDTOOiwQjVJG
 d9PrT2v1z7WYMoay1RlATi1pXtwQRV8yN8N4VHnyDIyJDAhRUrh8YJoHPAFe0dGzSvgm
 1reDQFsTAUwtQ5+hnxRjieRvNaxI6miMdPovzkTbot+DGI2WZ89GydKehNId3n0M9jaI
 /5XIhjI1HLoyCPboeBuBE3m7uue7Bo1nRDJ4pW4T/CQHUdlDvHl20gD6748NRwIwRvsc
 gdAIjoo78Xso4zOwsVgl/ySqE2sdOOcvJ0rChq+GpMPrLn8EErrKjWtpUsdF6Ta88nDk
 uKQw==
X-Gm-Message-State: AOJu0Yxkp9a/LRxFonpqzBOzPCTsh4+Xq45/rsjUMzvBgjRCZxPSLbDZ
 h08ujJ7/khsx9yJjDmu6FeY/bob/RzLR+JWFVwFUJeiLg4bV9Lzwx3KPBf7fCGKxePuukMujVqi
 sYBF+hXN3as6O8lhfOXaj2hxOKpCZjfA+E9ImZSE8S8CcSpmJux+PNI9EtPmqqy7+lTU60BDq6I
 SvKXCz7rM/65wj/Bji1t8=
X-Gm-Gg: ASbGncsY3Q3oK0DPyU/gLwODySxzUZQiwF6GFZR3dTRtRPFXMt45zIi06KkgBKt1YIA
 GLcfOazqWBIlxjx3l8OQ7jObuRxtoQqa+RN/ApYiGqGNAOcxYGP+7jrwLKIqOauAE7mwMzH+FIW
 aUGe/HeA==
X-Received: by 2002:a05:6512:691:b0:553:37b0:d992 with SMTP id
 2adb3069b0e04-553e3bb3e62mr3284564e87.19.1750672476499; 
 Mon, 23 Jun 2025 02:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdRaD7Ge8Fk5QftxTaTSKAU3f8CwoCcLUofQ033DFAJRSU4qw8uIEhFs/29D5LEW3l8LtHuNvpuucKotlbZK8=
X-Received: by 2002:a05:6512:691:b0:553:37b0:d992 with SMTP id
 2adb3069b0e04-553e3bb3e62mr3284554e87.19.1750672476039; Mon, 23 Jun 2025
 02:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-3-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-3-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 11:54:24 +0200
X-Gm-Features: AX0GCFuFj89wST4RYgqGFMhUPOliCgbK4pwVnmS3pPt6xWVvnq3-Jyzh20f6aD0
Message-ID: <CAJFAV8z_V_K=0PUwbRsxnv6DXbFr9RGL9oLRrDCrNhry-LyMYw@mail.gmail.com>
Subject: Re: [PATCH 02/10] test/telemetry: fix test calling all commands
To: Shai Brandes <shaibran@amazon.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YGCStRU4FiHLELHIcbYBgfe_HzYCtEyr-ih4nJWjbfc_1750672477
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Shai,

On Thu, Jun 19, 2025 at 9:11=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> This test was doing nothing as it could not find the telemetry client
> script following the test suite rework.
>
> Caught while looking at UNH unit test logs:
>
> /root/workspace/Generic-Unit-Test-DPDK/dpdk/app/test/suites/test_telemetr=
y.sh:
> 18: /root/workspace/Generic-Unit-Test-DPDK/dpdk/app/usertools/dpdk-teleme=
try.py:
> not found
>
> Fixes: 9da71dc4f96e ("test: add test case for scripted telemetry commands=
")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

This fix is flagged as a failure because telemetry_all hits a 10s
timeout in AWS CI.
https://mails.dpdk.org/archives/test-report/2025-June/887693.html

Please use a 30s timeout (like other CI do for fast-tests), iow pass a
'-t 3' to the meson test command.

Thanks.


--=20
David Marchand

