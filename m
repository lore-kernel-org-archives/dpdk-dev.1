Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EADCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:48:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB4C340608;
	Wed, 29 Oct 2025 14:48:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1185840608
 for <dev@dpdk.org>; Wed, 29 Oct 2025 14:48:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761745712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d5a/A1FXbtdueFalKvaIBVijaCIx/pE1c3DikQ7srwc=;
 b=ixnXZXWZTPte5EmIMKrEOeVczYxKaVaZDyhtgxQvQdiAgkiGXNzqGDYr+5TcumLGg2parW
 W6YPQORQ8Ymr6dn8YTlztZRa3GwEGk1bEx+HLhMqTRI/jcDWZZ/YGuXYMEdyvjphA31CDQ
 r+bQRx8hSjzxVFQsj7KUS10F3rzJk+U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-xWcreRicOpeuD5dEk2_3CA-1; Wed, 29 Oct 2025 09:48:30 -0400
X-MC-Unique: xWcreRicOpeuD5dEk2_3CA-1
X-Mimecast-MFC-AGG-ID: xWcreRicOpeuD5dEk2_3CA_1761745709
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-592f14f2834so464151e87.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745708; x=1762350508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5a/A1FXbtdueFalKvaIBVijaCIx/pE1c3DikQ7srwc=;
 b=J8cQAe8V+FUb1HraMDC8DftJqTu21kxWt+kUXjmqDJzzEfoKnKMWCU6FNsu0S4kKqN
 Kz4QZz8F+z51Lcu7SIetspWnmXn3LH+sYmbuu2GAVFRdOfp6eVv/RftEDyfGFTwO8cc+
 H4Ny2tC/1imI5WqRA7kSi254ZApv1yMRcOSl5nzi4kbaEqZJY5Be5s1tJlGVvFsn0P5e
 l2YpwSPZ11BjwSFI4lL6LO7T3+HB8G55mq0iANfyk5fMAmLgl1IfaMzuCqhyn8lg/H/t
 uMKBAvxRanu2ec3lA+uFc7BxVa+cKyTgtzk+C3y1htg8EgLtIedkFNVUPkmWwo/+0L91
 dm4Q==
X-Gm-Message-State: AOJu0Yzb5pQ3v8zmFvMsNHE2UFGQxJe7AeT0Qk5Dkm4drnVrKyuR8wjV
 murEuPRXwF6mXmPaisSrVNC4xN8W0+tpG+by1iQjVsbsUn0u9Gc2F7d9BHhMAzTAHDyfRPo3+Rf
 dkaaKVZAdI48RPoqrdXvVAvo3eqPs7R5oro5dOT5BxaNq+qVT+qSnZEtoTgd56k+zrWuWBoG3XP
 rS3Dsr5/qZy7UnyB7jVTs=
X-Gm-Gg: ASbGncvxSveMYKzTlWptt7CZSm7eZtQUfsxOukoo2WWEe+OBOV89jUn6f7kDtTaPhTa
 XhfXYm48EcmfOp/8f4PIEq2WuyNMQhUUn/j/loMpAGr9q1cD8IIO9lV+dxGoAFaBtau27FNNNo9
 BmzoUf3utbqlb61GmspLO+/BBgtMZJJEYoWCKQYZ2R0d7UlK2bCD5TkdkCSA==
X-Received: by 2002:a05:6512:3f13:b0:591:c898:e83d with SMTP id
 2adb3069b0e04-59412cb41bdmr1122606e87.24.1761745707347; 
 Wed, 29 Oct 2025 06:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvHbr9LW7tBmBJdY+FgSOVIplt20kkfHbm5Btzbws0qx/zQUnZcW6hnPnC6ytITam2cy5KvQFvAySASnEi5l8=
X-Received: by 2002:a05:6512:3f13:b0:591:c898:e83d with SMTP id
 2adb3069b0e04-59412cb41bdmr1122498e87.24.1761745704482; Wed, 29 Oct 2025
 06:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251027164621.175861-1-stephen@networkplumber.org>
In-Reply-To: <20251027164621.175861-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Oct 2025 14:48:13 +0100
X-Gm-Features: AWmQ_bl5OqLGygL105pTYzNOJHXlEXgpa-QjPWgIpitiEe8rhxg3AU3ElpEjdl4
Message-ID: <CAJFAV8zi5=hBo6wEWwqr=QZyzodkf1K-39m82Fj9CA+-2SX1PQ@mail.gmail.com>
Subject: Re: [PATCH] dmadev: fix build if RTE_DMADEV_DEBUG enabled
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QA7FXgaOcbV2PWXF6aMuccwanhYPZUfwAZmN5rP1AFM_1761745709
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

On Mon, 27 Oct 2025 at 17:46, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Missing definition of errnos causes build failure:
>
> In file included from ../lib/dmadev/rte_dmadev_trace.h:16,
>                  from ../lib/dmadev/rte_dmadev_trace_points.c:8:
> ../lib/dmadev/rte_dmadev.h: In function =E2=80=98rte_dma_copy=E2=80=99:
> ../lib/dmadev/rte_dmadev.h:1183:25: error: =E2=80=98EINVAL=E2=80=99 undec=
lared (first use in this function)
>  1183 |                 return -EINVAL;
>       |                         ^~~~~~
>
> Bugzilla ID: 1814
> Fixes: 8f1d23ece06a ("eal: deprecate RTE_FUNC_PTR_* macros")

I am not following the rationale... 8f1d23ece06a removed a macro but
use of errno was already there, so I am skeptical this is the right
Fixes: tag.

The issue was present from the start, so:
Fixes: 91e581e5c924 ("dmadev: add data plane API")

> Cc: david.marchand@redhat.com
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


--=20
David Marchand

