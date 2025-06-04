Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE03BC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 12:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0749842D80;
	Wed,  4 Jun 2025 14:20:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3737C402D8
 for <dev@dpdk.org>; Wed,  4 Jun 2025 14:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749039598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXIhiDmdKIf0nLHo4I9E0nN0f/SyJcvVjR3zD/pUjtQ=;
 b=bM5tzgOIzfUdbt+MXA0HoRhRB+2nyCAHvvlZ69LrapfVbsNZZ8Y725m3cJsIJPwn7dsxAk
 vqaIAHcMV+3Nvwotg2KjBYodhTg2F/j4NTdb7QZwEPgsmmG9EZf5ENogGjNJy9FY36v5S9
 HYj+4WrHUlw98RpCuXrKwVmc+e2SrkE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-TTsoT9oHPvSQgYxhRXBiBA-1; Wed, 04 Jun 2025 08:19:57 -0400
X-MC-Unique: TTsoT9oHPvSQgYxhRXBiBA-1
X-Mimecast-MFC-AGG-ID: TTsoT9oHPvSQgYxhRXBiBA_1749039596
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55328b79ec3so475435e87.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 05:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749039596; x=1749644396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXIhiDmdKIf0nLHo4I9E0nN0f/SyJcvVjR3zD/pUjtQ=;
 b=YV+BuAogKC1yHSmgiDTkNCH1eDZT5UadZmN/0iI+1Uwg2Sqc8KMcG7rVUjRUHb+0k9
 WcMH3lN9lVi2vOe+UaAd9Oh7F6Q5s7jjtUdcHzpdCLDI5haKL43axUWO5Wqt0wHsLKOO
 ANPAiIezSNI/VOu7KV+zVQZVjWIr8x2dQW7KCuqwF40T76S/Hf6zxzdZzJKHB0Rxm+oQ
 TKFgfDSdLHZAfd+DDGcu9JkRpFB7KvqbUZ6EBvB7P8Q/UTUNrXyCOEiU5XNEqX80jvci
 D4gKX4neX06+8hV2E6Z4nUYt6jwXdB/NJK2gAnaiYbAG9QUMaVIY/6xZ74OIELjRTRak
 46TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcfbsA5I/WwqT1gd1RO29LDAJnDKWNZH4fwM23ImeZiGP7Pm3v6bDeU0EuCMfiEfAcHqk=@dpdk.org
X-Gm-Message-State: AOJu0YyHTZqL7Ua9muzJ351cNHRti5BGVQ/DjgOUV2aqqwaCckJG9q0+
 IjfjabCkZOKgA2mCtDwbjTWawWFASvnR7ieaKTFW9N25bTKQG+O+jQYuZVph3F1G4cP9HnttBbl
 y70NRkl7HxpzqYp3J2WRYzAq9l+yIdyGEUQAfVmnjpjI5yqowlm5xMo001akVtlg80lF9zbPWIJ
 KjoX/+9QVtLOffNJsfC54=
X-Gm-Gg: ASbGncs2QXFd2NZcfvn3UZGknwP4vB/4zhbumhnucZyz6vLwaT1T8JM9x98UfmUo0tn
 fPZzujkbuMnAi/PXDAV4XijwUBBU4+9+jTaFJn0OzHQWV/L1UyIxKn4QAOsOE7LUgNDKc10Y=
X-Received: by 2002:a05:6512:2256:b0:553:2a16:2503 with SMTP id
 2adb3069b0e04-5535719cdc4mr734352e87.22.1749039595914; 
 Wed, 04 Jun 2025 05:19:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG69nzSadJqJq5/oyd7qWvvaoufPzOsvPL6tgCiF3Dh0eZFi7TsHFR3GtmzlT0QWVI4N3pUnaFt0ukGAvDcdUc=
X-Received: by 2002:a05:6512:2256:b0:553:2a16:2503 with SMTP id
 2adb3069b0e04-5535719cdc4mr734345e87.22.1749039595440; Wed, 04 Jun 2025
 05:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <1734988233-20208-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1734988233-20208-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 14:19:43 +0200
X-Gm-Features: AX0GCFtueAsSQYKTMZP0rMx2FeBHW0wvG7UAfqLOGFGtoCE8XD8kYODpN_tMp34
Message-ID: <CAJFAV8zCw0QJzFgKsYco=W2b7Z5J=P=Wva+xqDuEggtCODzApg@mail.gmail.com>
Subject: Re: [PATCH] app/test: fix stack overflow in fib6_perf_autotest
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UihLEhbqyw3KYQ6Q3frEUW_ZEe43FWeR_fPdGSLwWKg_1749039596
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

On Mon, Dec 23, 2024 at 10:11=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Test fib6_perf_autotest was hitting a stack overflow on Windows
> with MSVC.
>
> The fix is to move some of the data from the stack to the heap.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied, thanks.


--=20
David Marchand

