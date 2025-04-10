Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2202FC369A6
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 11:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0105640678;
	Thu, 10 Apr 2025 13:39:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C6370402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 13:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744285197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VErcSBER2qlIEelzi+u9cCEljfeUocMoz+Jrgz72NlA=;
 b=jLAWJGvJ7EKYbCx0uklthshjep/0fe848YIJeG9sjhbgH4TsN8XzWunZAh4DGpa0tea341
 84wsPvDK8eEQd54K9A31h8FbPnd+CAVPl0oJeiy0lTV8hl54FMMIHOmEZcFkXt7LLR7btd
 H7CV3pp88xUNpI0SXt4/iOcHuNbiyYc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-YIDfPP4NNRGdyG4EDTSPHg-1; Thu, 10 Apr 2025 07:39:56 -0400
X-MC-Unique: YIDfPP4NNRGdyG4EDTSPHg-1
X-Mimecast-MFC-AGG-ID: YIDfPP4NNRGdyG4EDTSPHg_1744285194
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30d8de3f91eso3793861fa.3
 for <dev@dpdk.org>; Thu, 10 Apr 2025 04:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744285194; x=1744889994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VErcSBER2qlIEelzi+u9cCEljfeUocMoz+Jrgz72NlA=;
 b=SKyGs2Capn3X9OZKdXulCyOgb7o2pjaVScNW4s5e/ysaelUCcS9rRH/rwtHrtZu+ZB
 jLfAFKMJGbcJc/qT+7Q9MnXc0Gboc7LG0Wjin+YL6BVk4KrHV5/hB69Sr410hxJKpyKQ
 8ELmMAUHnAiJXw9iYUJ9tgoEZYOjwoTcu6t2upK6QLqjVl+6OQwcbfhG3d110L6JroCq
 CZ6tei+FMHF9udvsLvbn5HC/BFVkm8jIcApsrZyTZutZ4uxLouzBDMHQI/gAW+6dnKbK
 4F93XUjWRB80gFqXfteeIkSJxRNO6eLcXfoAMz1vXPA3MYNSI3nf0E0BvWMKv4J0DkPy
 oqcQ==
X-Gm-Message-State: AOJu0YxYeScfNRK1WKLRMrIANOlRmzmyaLDyw2Ru8OPC4ZPqkM7lnXj2
 mhnjUUhWTO/hhkdTxzaKU6w9eXZDuTm+JV7IaVTLd1TSg4PtRElPMsEyU4VyIXkLJoDGwRyIUAm
 qSwO+bLhHFSlxSc3V7bm/DpJ3UfVybxGl0Nkv5TRUZMXxc4vqE96EtjqsTJlEObiFIJ4zkOi9Fu
 Cx+T6I00yCPwBb79U=
X-Gm-Gg: ASbGncuPU2wJ7JfdFIG2/CgQ+lzlyCwA/ajaZBAVhZLXejJ7cYMLUN27uXOiAiupBZx
 cR7AUpYgwFr3PwFr0Jb723wfQQ68JsrUufPbv3G8B7tEymMT12kFrpSjfxa/uWSuPzE5XfQI=
X-Received: by 2002:a05:651c:1594:b0:30b:d656:1485 with SMTP id
 38308e7fff4ca-30faccc0082mr9815131fa.32.1744285194525; 
 Thu, 10 Apr 2025 04:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXzwnV8AYUEA8Jc1W9lcWOMNcu4NtXm3vnQNRXF1jbY0j+7tfMY1cU3FajUcu8i81t1xJlnAEuBueVpySvBsw=
X-Received: by 2002:a05:651c:1594:b0:30b:d656:1485 with SMTP id
 38308e7fff4ca-30faccc0082mr9815061fa.32.1744285194226; Thu, 10 Apr 2025
 04:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 10 Apr 2025 13:39:42 +0200
X-Gm-Features: ATxdqUGDUVea0_NmYX_nKKO0jbOICP7KkibuhTsOGFg1OI0rzZyBxHn9_cg6-bw
Message-ID: <CAJFAV8wyJLOCxKsZRNjVXvXwkOULz4TmLkwgWU=Sdar6iAfqzg@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove VLAs
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Cc: dev@dpdk.org, Andre Muezerie <andremue@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NoLJW0q4bT9PTqe9mFs9IpzVV95vjvZ1V_m4BFIHz8w_1744285194
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

On Fri, Mar 7, 2025 at 2:40=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> There are two lines that were using VLAs, which are not supported by
> MSVC.
>
> 1)
> ../lib/rcu/rte_rcu_qsbr.c:326:12: warning: variable length array used [-W=
vla]
>   326 |         char data[dq->esize];
>       |                   ^~~~~~~~~
> 2)
> ../lib/rcu/rte_rcu_qsbr.c:389:12: warning: variable length array used [-W=
vla]
>   389 |         char data[dq->esize];
>       |                   ^~~~~~~~~
>
> The short-term fix is to use alloca, to allow progress with the msvc
> compatibility work.
> The long-term plan involves API changes and therefore can only be applied
> with a new release. This long-term plan consists of introducing some
> reasonable limitation on RCU DQ element size.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Honnappa, any objection?



--=20
David Marchand

