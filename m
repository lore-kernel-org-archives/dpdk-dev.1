Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307F7C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 13:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8713D40395;
	Fri, 16 May 2025 15:19:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 25DFC402F1
 for <dev@dpdk.org>; Fri, 16 May 2025 15:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747401586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHxuN4X8LisjOwQG0c7tQJ3UrSRBxyfcxLaEIM8hY9Y=;
 b=DKtToOd+ypULkQZhSEsIo6haBHY4Gb0zf04kQ5KB8B6s5RT+R48BGncSITrlYJyPnrgSvc
 VSgamaWOOXINI5F3uLqv9nqU264UL4Z2uyg4rIQi0OkSJ+cLgPeCebId0YCgAdx6/Q8Vqj
 uIJyBnFrq9+3kWyjDP+/as4WcGRZWy0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-RTCJ-4L2NGiRHNlkg6TlXw-1; Fri, 16 May 2025 09:19:45 -0400
X-MC-Unique: RTCJ-4L2NGiRHNlkg6TlXw-1
X-Mimecast-MFC-AGG-ID: RTCJ-4L2NGiRHNlkg6TlXw_1747401584
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-54c2a5fd572so911024e87.1
 for <dev@dpdk.org>; Fri, 16 May 2025 06:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747401584; x=1748006384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHxuN4X8LisjOwQG0c7tQJ3UrSRBxyfcxLaEIM8hY9Y=;
 b=OgXbUz65C2mHdxTE1xLN2ns3YYzKJK9YxPtuOOicKWOCAKObTagKxPuLERhOJ/3DAk
 kX0sgWiZPy1nWyCcwYSD3xesr1/f7breXXWjpNA/uM3QKb+VG3iod3kqvQ//HUZgPSBi
 KBrkPEDN/U0gwmrvoeMSJ8bMNf7rDFJhkUWMxc7D8oQzfq8+wL2eSF02uiW6M7j6k5jr
 kP3llT+sXpJPgaKUJMOF+RDrEebgRx9ALeHCvP12bNmDB4xo01sVEc1UW8K4mVQcACVm
 fH4EawrsML9ZSPqptg3YWbkpk/4T+irj0hZx9XoFL6StwAkSd9uxep/cn5VQAyz2NE3H
 UTNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpff4zoOXrwC5WwWXGVUC91tU4Q/eBqvgAuLAI7e9JO+hULI3h5sbZZ6dvzSSc6EP4TgU=@dpdk.org
X-Gm-Message-State: AOJu0Yyu2LUTFkXTpf1XuhkyT6CAihd9e+qHBbnxBpysifkxpxNiOPCO
 CHODVKPyA7zplMsP4QXXc7aFqEVsl+S156UDDY5ubVePY9EznP06LTRHwEzZtc9Ry7aaz+hohEa
 pg4r8Io/urLZU3cvi+biGIc/kmGuFXeiQ/PCCrJioD28xG2B/NdQuqOOIUK7u/+LRfObjSg+Bap
 7+I8Qw8qyLoIZVp7+GXhA=
X-Gm-Gg: ASbGncuj1Ls6FZnwc0TpxwmC6F5OIaAQcssJ4xKNIE7Wzw/lbhjr3Nu3PORFNrY6xjJ
 9OjDJwywxETI3XRnNP18FVfs3BJQ8SblG16hnNO/ZslJyqB23ggFyypKPuKP8nO5I4xOHCPY=
X-Received: by 2002:a05:6512:2284:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-550e71e48c0mr1118771e87.31.1747401583847; 
 Fri, 16 May 2025 06:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHopQPsCjYHhCTaMdQYDaKy8gIffwoTpFmKuXwAwwssJqqyL427qPcs+lha9y34HS7K4r3QWnEPTpviZ91tPbw=
X-Received: by 2002:a05:6512:2284:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-550e71e48c0mr1118762e87.31.1747401583420; Fri, 16 May 2025
 06:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 15:19:31 +0200
X-Gm-Features: AX0GCFuAMiHTH8OFUhkdOax_LNG6MeIALzQHaI6CgQwQqrUtbeAyeN-kh86iYS0
Message-ID: <CAJFAV8yBUQ_DZhxwrco0Kk675Jwf9WaVU9voGjM-SGMj5O42vA@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove VLAs
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ayTBNIehaEyoQqavz0C1GiX3SrgB3BAFdhCHP-9Abzo_1747401584
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

Applied with enabling RCU compilation on MSVC.
Thanks.


--=20
David Marchand

