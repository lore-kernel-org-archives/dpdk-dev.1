Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A67C282EC
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:34:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E77D24065F;
	Thu,  6 Mar 2025 14:34:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8628A40430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:34:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741268059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KzulSnCqCNLVAi4kv6lMFaO/KIguwnNGsYwGzDvlHCo=;
 b=YQlk5Y/q6MzdYHROWFaEHMSelM2FVUrK+w4oDhDfv5bLiagnrormLOwOVg5M37qmBpYCOb
 DLZmzZOvPF6GW6CQMoy1EzoJTO5GFJJW9ZSPqcTbdkNn8g1U8E/w7vdYSuH6O0Djrs+RMO
 3ZZq28g0ujqzFxHSk8FGXlwKoJDYcCs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-kKV3fKevPDufahBr4GNRTw-1; Thu, 06 Mar 2025 08:32:57 -0500
X-MC-Unique: kKV3fKevPDufahBr4GNRTw-1
X-Mimecast-MFC-AGG-ID: kKV3fKevPDufahBr4GNRTw_1741267960
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-543bb2be3dcso427155e87.2
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741267947; x=1741872747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzulSnCqCNLVAi4kv6lMFaO/KIguwnNGsYwGzDvlHCo=;
 b=nFoM8LfITKWvWeIuAKQqR5R/QnhyETJL4rs3Dw/m26aS7tlF+KWqSG7XIS3np0O+kc
 kS2uscHjeFHg9Qami5lASG3qEQg62GmHpLvjNpjLCjBkiT0rGqP1+sNFh0YRz8Np7ZcG
 2Bcoe5ezzjnoPL3tMNxK9n/xj7uoA1rO3uo2Q6XHzCqjx/CgtCsHI9OasOipxYcTlquH
 YYeyR/S1oQPWw0ZHrHbNFIl6+nmX7EL44uyPae7eYy0xPS37c0ZI2d+oLaMa4bYBGU+q
 aGiAWN9uTcTQ0Xpji9ExN/sSLniJsrfmX67wiYTaKYB6ZYVvxyMOKPb5EDtn3MTTEWCl
 PV/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsEJB/VZAqXKfeYzvQTHrV6Qly94HiWo1bO4JWkNwzqYf1uKb1QnZnwueOY1m2UKEHN1o=@dpdk.org
X-Gm-Message-State: AOJu0Yw6lzCaCEZ3Mfr1xY7RRutmRXA0EKznJjFElkzEKC/XeK39Zn4i
 jbAMFXN86Qv3qVulppnNhdXQ54gtquMhiP9qTEmDq25az0cwOcbyO8pNbGtliVlinxln+js+TcA
 n1vPqSZIwwr+yeOesHf3ghjm1qCw4qlqfXZSc7py+iReeOeIlN+GaHFO9+nidJe5I8fM+DYNhg8
 GXQGMekJScmN3Wp1E=
X-Gm-Gg: ASbGnctR5B6544lH5J/o5yVr514R7xdRUqfuBxShqI4VizaHp1Fq35acqw1pzmIvYAt
 hoU9rkhkhbHu4KOrORUrQrOXm/0Yv5Tq1BeDYNM+xjdwq4jONoFnnCtZPb4FSIxujgxi4B77BLO
 E=
X-Received: by 2002:a05:6512:3994:b0:549:74a7:12de with SMTP id
 2adb3069b0e04-5497d3830dfmr2471176e87.48.1741267947174; 
 Thu, 06 Mar 2025 05:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq6rTNXu+/TQZdXwAMMX8KQzwW5IZWrmU0Y+9kWfFpuiyNg3nmMLWfclYSiyVPD3SAcTthrCBn4xFIQYtJ4xg=
X-Received: by 2002:a05:6512:3994:b0:549:74a7:12de with SMTP id
 2adb3069b0e04-5497d3830dfmr2471169e87.48.1741267946794; Thu, 06 Mar 2025
 05:32:26 -0800 (PST)
MIME-Version: 1.0
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
 <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:32:14 +0100
X-Gm-Features: AQ5f1Jq_6vXfd3cbXjPQD0loKf41u7rnu_45TuZadUePnk2bkVlfDAbPGicmHT8
Message-ID: <CAJFAV8zKC3vaFW9kfwZdUJz68PKvKrq8qCDRRRMU4OGwjzgVKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/hash: initialize __m128i data type in a
 portable way
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com, 
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z-NhMQ6h5Bj5ix2R0hh4DpzWPl9nPSrkFwsCnNf_bbM_1741267960
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

On Tue, Mar 4, 2025 at 10:53=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> The mechanism used to initialize an __m128i data type in rte_thash.h is
> non-portable and MSVC does not like it. It clearly is not doing what
> is desired:
>
> ..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
>     truncation from 'unsigned __int64' to 'char'
> ..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
>     truncation from 'unsigned __int64' to 'char'
>
> A more portable approach is to use compiler intrinsics to perform the
> initialization. This patch uses a single compiler intrinsic to
> initialize the data.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

No need to send a new revision.
I applied just this patch, and dropped the second patch in patchwork.

Applied, thanks.


--=20
David Marchand

