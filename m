Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B2FCCD19A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 16:40:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEC99427A7;
	Thu, 16 Oct 2025 18:40:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7CF3A4026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 18:40:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760632805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPFmSTbBN7d2EZjZf7nQeFRk5ozOFPw4TecKO4bXzGY=;
 b=Ptq2SDRAr4wEktFPH3X/T8c7L4rdniD7FsPUmeFFmFgxL/Py2MgV1mws0dQ5lQc3ah5x+o
 qQBmVxwdGqZP1z0YXEfP1zRFxgmpRbAgOUxXwPSa+t5IwlmbdpNzYL2Tejg0bcqhNcIxUg
 3J53sH3yiznzizL6FdTKEF8afPxKm/c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-lfVACCHoMaucGyuzTugoKw-1; Thu, 16 Oct 2025 12:40:01 -0400
X-MC-Unique: lfVACCHoMaucGyuzTugoKw-1
X-Mimecast-MFC-AGG-ID: lfVACCHoMaucGyuzTugoKw_1760632800
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-57cd230eb72so955188e87.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760632800; x=1761237600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPFmSTbBN7d2EZjZf7nQeFRk5ozOFPw4TecKO4bXzGY=;
 b=NoWgKFb9ncGxwJnRWDOnwTyc7aw+n9as5wZkq8FXzWw+zUCx3fnu34LrBBsTqtcyO+
 fMH8EJ71Rg1Dq4OgxqCpMfwVWpUEAdsYcxbDkup4FTZJnKc45E/pWksodb44elK5i1G6
 l6lnsCL39lHe2sa1qYknKNFN6naV8O6MKoJYrhQIe4J7bAB3ZZLKGuRrexQ3h/4uJfjf
 rsldxgggMG4reKBqKUP9FXBrl/ItP8eN+H9Ljy4ZcKF5rJM2QxAaCmdaMRyKBlUJlyEO
 WBJeak53bGkhhG1fVo8SAi83EdMuBP4++YR2qj3ClEdIDRBsa/NtwLLvxkizHDENi77c
 juVA==
X-Gm-Message-State: AOJu0Ywl5icVM8TiftWF4VdC+Qwk4RqMA2GazUszadmgYhB3Igt9xzkc
 mSPuouwdY5mEzUB9wRxyyNXW42AnuM43/q3WNHMtVc4HxdXlq69vKEgWKFQLf/H2q16BxiwsLex
 giU8i4Q/XEIZWHHnVK+ayxdXNML6YfhephqmdB/OxanIB4eDte87O6TRkc1fEpaTbE4QbRb4qd0
 +bboR6xWxclsSJbkudJG8=
X-Gm-Gg: ASbGncsN+gjQchotc+vJTXnGY5bnPkEJA2w1EhGONgzYaUfzYTBEsX0X1ktcjMLQIha
 tcaVw8MkYKDTumDN9MwopWgalR/oWVm3BviLJl9WIfJy9z+p0Murv0vc5VjTHMzg/4pFv9W5kpF
 yo8ZDaEQks4GeP1EcfSSipyQwwtQhQ2TLHbrVOgNyJGaSdN1FZkre7gg==
X-Received: by 2002:ac2:4bc1:0:b0:586:9b16:6d24 with SMTP id
 2adb3069b0e04-591d8534579mr245984e87.26.1760632800301; 
 Thu, 16 Oct 2025 09:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0/FfYOq2mzsvhlULsbjqpHmMDvCZKHtXvPaQWrxIxjVvXlUfzXf06kF+/SK/WJSLXiqKZmPOCS90kEZeMDG8=
X-Received: by 2002:ac2:4bc1:0:b0:586:9b16:6d24 with SMTP id
 2adb3069b0e04-591d8534579mr245976e87.26.1760632799836; Thu, 16 Oct 2025
 09:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250527223642.31577-1-nicolas.chautru@intel.com>
In-Reply-To: <20250527223642.31577-1-nicolas.chautru@intel.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Thu, 16 Oct 2025 18:39:48 +0200
X-Gm-Features: AS18NWB7DvOk0Pmf7kJQ2MgkKqtWbvmgn6_cZuiHJDWokNAEOuzGl0OvphJvtME
Message-ID: <CAO55cswKpxQhYGpP=im-Vvswm_sF-1ZjUvw7RJni0Ksn5XAi0g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] bbdev: add trace point per operations
To: Nicolas Chautru <nicolas.chautru@intel.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, hemant.agrawal@nxp.com, 
 hernan.vargas@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oVi97LDH8zTMW3aov9WwsY0c7INnJfHrIxWkFS0odHs_1760632800
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

On Wed, May 28, 2025 at 12:36=E2=80=AFAM Nicolas Chautru
<nicolas.chautru@intel.com> wrote:
>
> Hi Maxime,
> Follow up on previous discussion on trace point for failed operation.
> Add a trace point per operation type, so that we can add into
> existing tracepoint framework the details of the set of parameters
> for an operation rejected by the driver.
>
> Thanks
> Nic
>
> Nicolas Chautru (2):
>   bbdev: add trace points per operation
>   baseband/acc: add trace points per operation
>
>  drivers/baseband/acc/acc_common.h |   1 +
>  drivers/baseband/acc/vrb_trace.h  |   4 +-
>  lib/bbdev/bbdev_trace.h           | 113 ++++++++++++++++++++++++++++++
>  lib/bbdev/bbdev_trace_points.c    |  12 ++++
>  lib/bbdev/rte_bbdev.c             |  24 +++++++
>  lib/bbdev/rte_bbdev.h             |  14 ++++
>  6 files changed, 166 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>


Fixed checkpatch errors and  applied to next-baseband/for-main

Thanks,
Maxime

