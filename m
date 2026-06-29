Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC2C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 10:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD9AF4064C;
	Mon, 29 Jun 2026 12:42:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 158434021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782729725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KuDxi3dmO+jqzCH3/YbmZdm25y/eoKbv8C8qUKrju4Y=;
 b=DzDKBGF0lw5ml4BKdBWq7I02h3+n9NPYtAKKU5JmKFEfD3h32xUBRdUtBbYqTrdUS/+AGL
 wPSJWMIiXNMMMEmbHxPeqxZSqLjGBcPz2Ub7HDbm52d4fYisMZuW+yGK+Bn/0ApjmhZl1M
 ui1i3foLIol/9TIZZPkaorJ/RrhoJ8Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-UyJq9sa2N5GgPfbg1asZNw-1; Mon, 29 Jun 2026 06:42:02 -0400
X-MC-Unique: UyJq9sa2N5GgPfbg1asZNw-1
X-Mimecast-MFC-AGG-ID: UyJq9sa2N5GgPfbg1asZNw_1782729721
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39afdaa25e5so3229511fa.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 03:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782729720; x=1783334520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KuDxi3dmO+jqzCH3/YbmZdm25y/eoKbv8C8qUKrju4Y=;
 b=A3MV+lDJoRAYdxntDXGX7ZPIZUfsIcIdq/zqSYlTpoDtLaUS5a85h2siD1TDv4xk52
 ZjQxCjlPv/P8TUpuryNVjpBwTOi4Y67Wg4ccFl8a5QdX+24tUIhMFjKzVV543bx1nXGD
 ONQbF642661poT1B/+KK2OSWvSDSfk7VmOg85A1t31v1lmJ8TlPA412OGXMx58jVsIqA
 LOQmrFapCYwMixY4HlAR4woabsSIyhS6A20p4eSRirrN/md9ErYCfs0Hgip+I7u7ZQcw
 YGgj+aNCQXOWFMN7JXL1EE99HyDR6anCr0UD99xXySxNaw2t793pEGE7CkmyYi+8hmKv
 /sNg==
X-Gm-Message-State: AOJu0YxllpdwzHBOdlx40gtQjXMiP0VWnKLsbZx+kVJbsG8Uh8OwOrMq
 kLBKhNLV3Lz36k74eLmSgr6ejDoQvpc/F/DTW+6kgBMfFoVUJdK7LM37wGIr8LV8oriVUNnJZzV
 xpGP024NYwb2BbZcf8lteTXaQQ7XenyyvuAItgnuTf4+g1k4KxWMdhZeMg5GtdsS2yqWChRRR/U
 2uEaVoBqKHJS7lEoerwis=
X-Gm-Gg: AfdE7cnoe6Gje0TotYlAIPIRUW9vRsQr8jbktdX5M6dooHtisvxYUykO8/Qn5T8OrzT
 5ud3nbDcYdLUDFt3m5o9dTKrpkACjmddWLpfmE7XaRGBeN3EQLMGNj4Mo4c09oDJQmhnxwquX7I
 WeRq2Irhl7K9zog9yh2jUfIRMD27ddM75WQgOK3dVb6r7wOjXFWmtBBV/DFRkHY22rfcyzirmqr
 QztUqFYqwBWsKVKPUFiYjb7VztNCf3FNX1d8/HEWyub2BkneWJg1aFN1T4=
X-Received: by 2002:a05:651c:c91:b0:39b:695:32a3 with SMTP id
 38308e7fff4ca-39b0695466cmr10327091fa.13.1782729720624; 
 Mon, 29 Jun 2026 03:42:00 -0700 (PDT)
X-Received: by 2002:a05:651c:c91:b0:39b:695:32a3 with SMTP id
 38308e7fff4ca-39b0695466cmr10326971fa.13.1782729720128; Mon, 29 Jun 2026
 03:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260407141928.9426-1-wpan36@wisc.edu>
 <20260628152553.46342-1-wpan3636@gmail.com>
In-Reply-To: <20260628152553.46342-1-wpan3636@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 12:41:48 +0200
X-Gm-Features: AVVi8CdF5SB2L24PemwnAVJ-nEe8zuKxgBNTLoN6H5hNKv2fljj4swbo4O43Wx4
Message-ID: <CAJFAV8y79ZOcbdZH95XO7P-qrdC+O3EVo329xPL6cEFs972kew@mail.gmail.com>
Subject: Re: [PATCH v2] bus/fslmc: convert queue storage macros to inline
 functions
To: Weijun Pan <wpan3636@gmail.com>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org, sachin.saxena@nxp.com, jun.yang@nxp.com, stable@dpdk.org, 
 stephen@networkplumber.org, thomas@monjalon.net, Weijun Pan <wpan36@wisc.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1ae4nSf91JGHHpAsXvEuFEeyGiS3uqY1LCD8leXX104_1782729721
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

Hello,

Thanks for working on this issue.

On Sun, 28 Jun 2026 at 17:27, Weijun Pan <wpan3636@gmail.com> wrote:
>
> From: Weijun Pan <wpan36@wisc.edu>
>
> The queue storage allocation and free helpers are implemented as macros
> which declare local variables in the caller scope. This can cause shadow
> warnings when -Wshadow is enabled.
>
> Convert them to static inline functions to avoid macro-local variable
> scope issues without changing behavior.
>
> Bugzilla ID: 1744

This bugzilla is about compiling with -Wshadow.

The proposed fix is partial.
As I reported in my previous mail, enabling -Wshadow after the current
patch still shows many build warnings in
drivers/bus/fslmc/qbman/qbman_portal.c.
https://inbox.dpdk.org/dev/CAJFAV8w-VQJb6jM0KgAVP1rJKyUUwiBA6_seOCDwMX47rZmYyA@mail.gmail.com/

Could you work on a complete fix so the bz can be closed?


> Fixes: 12d98eceb8ac ("bus/fslmc: enhance QBMAN DQ storage logic")
> Cc: jun.yang@nxp.com
> Cc: stable@dpdk.org

Afaics, nothing is broken in the current code, why do we *need* to
backport the change?


> Signed-off-by: Weijun Pan <wpan36@wisc.edu>


-- 
David Marchand

