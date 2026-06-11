Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA1ACD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 10:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 941E642FFF;
	Thu, 11 Jun 2026 12:13:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8DC1840041
 for <dev@dpdk.org>; Thu, 11 Jun 2026 12:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781172817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rSoCUYQ8Ve2dI3gZiZaweMqQShdPIBfdweLPSuFOChY=;
 b=GvBdGb0+XrfwH8ZDmN5RUwujwLzfw/hkWXoBbFFgrzy/lW/sF5HX0WO326DPwoalbyK6fk
 f7tv1Ai2Mia52SsZAPifNHQemqZztcul9u4jM4ynglrSqYhVgqa1I8WWdUtBLw6BghsRr6
 30EUFzKzZqkNSErgxWLnJPdv03Z5dV8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683--EIte6taMT2BWfIvFANxTg-1; Thu, 11 Jun 2026 06:13:36 -0400
X-MC-Unique: -EIte6taMT2BWfIvFANxTg-1
X-Mimecast-MFC-AGG-ID: -EIte6taMT2BWfIvFANxTg_1781172815
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa661a8129so5176432e87.3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 03:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781172815; x=1781777615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSoCUYQ8Ve2dI3gZiZaweMqQShdPIBfdweLPSuFOChY=;
 b=IMw73NvKgxR7vLBaPH7Vy3lm+zsUCvirAqt7Q555SVR5rbmB/oWooiLJKJj/0YKh6i
 U2cUFwbQIhTlv9Em26Y5bcHSfC6lGrd+LrIDB0EEXeeUOKGOd+/TPVZav49tPm2G7M6x
 NJCAUS1Zkj2BJHGGH+2gVu2YxatQ5AcGrzbPcFNLRk8Lh+MYLX3pQ/HVc91r2nksC248
 m7VlXXg7ttU6AXPRgaP+q6EEkIEWweKgCu0Bi/GVtij3wRqKqXF/ifVPAWJNA6ExRkNq
 yrUctWtundI4cGw0QEqnLPE6BTFWOriQBbAXRcPuDXd116azni9vU0lIICJF2693eDMk
 8CEQ==
X-Gm-Message-State: AOJu0YxoLIFNSkkr2lMcPXuAHuyuvBcGKIyW8RLSgqgylQEnSPzq8bfM
 OLoiCHx6XItdTUzN+UdKLyYtwoGQJbJTa62bqROCe2Uon0Azz1NEGLAbVw0Q4Lh4+2zi7qlvgvy
 jztyprZb2zryo7xqCI5i/kAru2uSHMBEYPTO4dQrAXwrrwGrNi5X4j9N89OkdCkYlx7cM5R2qwn
 vTbcllTV0RJijb2JrcHNg=
X-Gm-Gg: Acq92OE2iWh2ijPrClExjkuPlRvvuxG1HHOA0vzyHC8fhvq0O7IOcI9FHPUVlrJ1ZgK
 OHbmK+6Dx3RYlL/s7hUZ56DY2bYmZq/RzZYUWepOXlSkslqc7DXcZKYMGUOWWhSTUBqJUUyDZAK
 PWpyvWssq3alCqvTrkPHV+8pKFnZtQDsGqXkFHay08sCF3D245J1AHD6mI8al/Eu62w3tkeP2C8
 yx9isK4uF0b6ZNw6KsQgJVHjbGfHlcoETbnrhu2mVdhzFdGWJaZJmrSzOp9Hi2MoryRph4KZ3lS
 YsrS
X-Received: by 2002:a05:6512:3e15:b0:5aa:126b:4504 with SMTP id
 2adb3069b0e04-5ad27ae30c6mr738517e87.23.1781172813842; 
 Thu, 11 Jun 2026 03:13:33 -0700 (PDT)
X-Received: by 2002:a05:6512:3e15:b0:5aa:126b:4504 with SMTP id
 2adb3069b0e04-5ad27ae30c6mr738505e87.23.1781172813314; Thu, 11 Jun 2026
 03:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260422075414.2528455-1-maxime.peim@gmail.com>
 <CAJFAV8wn26hRUTzCG4ai+apT8+bWL7+cEE1N-gV1tJt8B9a4hQ@mail.gmail.com>
 <CAJFAV8zsDEW6vU69NHmZiqUyB4xz+qDPQsw-cBBeScGeuE_Fiw@mail.gmail.com>
 <CACyZvzgxXHmfeXtCwV37VR7moci6d1p_chy5XVuLYZ1LufsdwA@mail.gmail.com>
In-Reply-To: <CACyZvzgxXHmfeXtCwV37VR7moci6d1p_chy5XVuLYZ1LufsdwA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 11 Jun 2026 12:13:21 +0200
X-Gm-Features: AVVi8CdQRzokp8kpsVUYaaIq1jFi93rGjZFjxFsmbigaUu4rH3gLIoskiVmCLRQ
Message-ID: <CAJFAV8wAJXZxEsa5TkTizs5mnpJhd6zBJ6ZNuJ089qVa=DcnTg@mail.gmail.com>
Subject: Re: [PATCH] eal: fix core_index for non-EAL registered threads
To: Maxime Peim <maxime.peim@gmail.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PMO7Mzvoyd7rth3-0qld5ExXEUHo7tUTVCdbfDBMBg4_1781172815
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

On Wed, 10 Jun 2026 at 15:46, Maxime Peim <maxime.peim@gmail.com> wrote:
>
> I am not sure it works either, if the lcore are manual set with a gap: `--lcores=0,7` (from `eal_parse_lcores`):
> - lcore 0 will get core_index = 0
> - lcore 7 will get core_index = 1
>
> When calling `rte_thread_register` we will hit lcore=1 as first not-assigned lcore and set core_index=1 as well.

Ah ah yes...

> It seems like a solution should be to have a bitmap of the currently used core_index stored in the global config.

Yes, it seems the right way to handle this.
We have a rte_bitmap API but it is probably simpler to go with a rte_bitset.


-- 
David Marchand

