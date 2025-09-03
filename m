Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AD9CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 07:51:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1F96402BC;
	Wed,  3 Sep 2025 09:51:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 07ACD40261
 for <dev@dpdk.org>; Wed,  3 Sep 2025 09:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756885862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EB4soVdL/ErfhOYR6ZnI/CNzmUx8cgtCpURRYGe1IzI=;
 b=ABYAsiREo1ysrRzwrd+qH8AMrXpaF1nNOCySgNsp/lZce5TXZZmBJ64lRE43sJVxfEHUIc
 OJ9RPKv0NU53w2fGDlPUtZqORbm22aSQ0xgBOICwHrv18MbImIkvG6H9Vn6BdR1s/Mp4Rm
 avKXO4nIAu29C7/5KzTa2tPQdGL2j0c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-hA2hvXlvNSmWuAiQDwtUUg-1; Wed, 03 Sep 2025 03:51:01 -0400
X-MC-Unique: hA2hvXlvNSmWuAiQDwtUUg-1
X-Mimecast-MFC-AGG-ID: hA2hvXlvNSmWuAiQDwtUUg_1756885860
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-55f6bdc1773so2673543e87.3
 for <dev@dpdk.org>; Wed, 03 Sep 2025 00:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756885860; x=1757490660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EB4soVdL/ErfhOYR6ZnI/CNzmUx8cgtCpURRYGe1IzI=;
 b=DPJTXKFvZThzYrzF62PdHhuIJyu22M41LQmShfFhE0jnPMnINEqkuMFdR/i7LCfcXl
 VtJfNCeEdUMuoXR0UJmVJfZc33dLP7wsTUtCpCOoXJBMV+InAweOHwlczrvERG6BRoqW
 wpN0Z/QJnzh6MN0+Il6QOSfU11tb6mpVsjcYTVnBoa+If7h+9j0A51ftTNnSCpMbUp3W
 HKaNdys48IdpnK2uJ89xkGX9D2f0UJUiwFtKtC1UCe9mV+o02Q7GT/7gZmNGf4octp2+
 4JUlBklpViQwN1YozKpbAh+t11foTIFkr5tbv50MeVHQUf9uxeWULEELwLPhk/B7WdPU
 J9gQ==
X-Gm-Message-State: AOJu0YyN6FaRJwng+kKJ6egV6MfKcHhscHhYXDDjZ6eId8DM3t7F+Nsc
 tprEa/h3IP80wWVCssg21zCZc0m0+HashKs6vsIWEWDRZaFS9ZvfIE4WJAbwl23hsKarvPvRlh7
 CO1dcSlx9LXUieHHaSYgdCyE29rVwr7RZbfPWeDAPOp3ZGuvRF4OML7I3RdICTN9ExnUqFsXrar
 LvYL66Yub05AyAS1ROvNUtIoVPKPU=
X-Gm-Gg: ASbGncv9zkESWnOTr/zOBeBzOyavkNTn9Z5fe/qJDt1WfFVoggpv33W9yqWx6eDaPL4
 rDUtr0DlML7BTSqfzb9045aoZ7zWcqDyeJy77TG3++A/1gKfG+jeZtkqpogEcW8JByWGIFo8jVd
 qCUShARliBhV5Meb6OPMeG5Cs=
X-Received: by 2002:a05:6512:2513:b0:55f:6a72:5679 with SMTP id
 2adb3069b0e04-55f70906104mr4187444e87.34.1756885859514; 
 Wed, 03 Sep 2025 00:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ2LlAFGnmFzfZHaV5kylTEU/+2LRJNHUF87dScUNSuOOiTfof63hHWmuQG3RA1Dwu/6RutuRHdJuVtWVLLx4=
X-Received: by 2002:a05:6512:2513:b0:55f:6a72:5679 with SMTP id
 2adb3069b0e04-55f70906104mr4187435e87.34.1756885858985; Wed, 03 Sep 2025
 00:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250903072826.1727004-1-david.marchand@redhat.com>
In-Reply-To: <20250903072826.1727004-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Sep 2025 09:50:47 +0200
X-Gm-Features: Ac12FXxKQjy27LmVSQ7bQB43xMYQ8cW0vO1oUOTD8Vzok5Umowr55ygWI9GEtqc
Message-ID: <CAJFAV8y0ZpCRY-QZ9CD+bK=jvbfhc5A3DG4q+JpQz4Fi9XqTtQ@mail.gmail.com>
Subject: Re: [RFC 0/8] Cleanup VFIO API and import Linux uAPI header
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8fK5Bu0qgrfmKIXREKKWjlOifN5oN-eA7Qu1xKR5tbs_1756885860
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

On Wed, 3 Sept 2025 at 09:28, David Marchand <david.marchand@redhat.com> wrote:
>
> The VFIO headers have a number of issues:
> - showing to the world a lot of internal considerations,
> - defining macros with the VFIO_ namespace (confusing, and a source of
>   conflicts with the VFIO official uAPI),
> - wrapping around VFIO uAPI in case the kernel headers do not contain the
>   expected API (putting the burden on DPDK developers to find the right
>   way to detect the presence of a VFIO feature),
> - (somehow related to the previous point) supporting old version of the
>   Linux kernel while DPDK now requires a v5.4 Linux kernel at least,

For people who would like to test this series, compilation may be
broken in the middle of the series (probably at the 3rd patch and
fixed at the last patch) if your toolchain provides old linux kernel
headers.
This is an issue I hit myself when testing cross compilation on ppc
with a 2022 toolchain provided by bootlin.
Upgrading the toolchain solved this.


-- 
David Marchand

