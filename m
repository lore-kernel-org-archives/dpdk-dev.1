Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C0C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 07:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E0F8402B5;
	Wed,  2 Apr 2025 09:00:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB87C4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 09:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743577235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ja9/oQ3/g3P+5U+qBu5/5yI68u70HSZmp7/7nsDREuA=;
 b=W9V2Du2PXBwpoIeQf/CMts2oaHIZT16ZDCivfKylkQiqPclq3RuZBFCAB2hp8ZQbC1KwbG
 Yr0yntlb7TKaVWh0qUez3kVfCKXD7aZ48/joEVJaZqygLgLuoglaPbxjUAYecgk6C3CMda
 7zeaU/s1kgLerkk1Efg8RZMk14WqtHM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ewSH6klYNu6B05rk9VLBpQ-1; Wed, 02 Apr 2025 03:00:34 -0400
X-MC-Unique: ewSH6klYNu6B05rk9VLBpQ-1
X-Mimecast-MFC-AGG-ID: ewSH6klYNu6B05rk9VLBpQ_1743577233
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-54994e431dcso3610691e87.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 00:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743577233; x=1744182033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ja9/oQ3/g3P+5U+qBu5/5yI68u70HSZmp7/7nsDREuA=;
 b=aUusSwkPmP2M9KMOd3WYvYTXRgdVjnll56Ts9Ca631zRbIHZR7cfeKoYCVtjvhiWzw
 0kG+JNDKih70hwY1ClT0QRUtyHiz9i2cEFB5Z4e7+ry0AAzd7mqk0E8Ey9PoFhmXH1Au
 Y6T+KwOjJuha7bpuqAxSzfNIOlZNvlt7bmAX8CJqQFc3WVM54Eyw3da3lU3OE+C1xAYh
 efr2AgG8omz5qZ54kpoF8V5FgXHcmINNHlSL44Nd4GLkQCn/AOlWFJdHtye6vhJLyqOJ
 iAJbMlVCPo1lt9YdnNgkdvPG+bcYHyafkE9hBQzpQsOwDf7ImfA4+z5oKVn/kPJLkyDK
 cCHQ==
X-Gm-Message-State: AOJu0YyYJppplenPVcHsUHce3B3mGCTYPv96yoIrQ6LF5a0rkjwLw7I3
 muxGS/s7PqIn2Bfs3sCRHc1kduUPvyZFOo/ZmxZzwk4QNlp7xO4yIvVEt4UaxPLchdkiqz5WW3C
 jaG5nqWJSPjVZzTer92YpkovKGl7E6sgi6li2mYMOI7hmuRJtPuWNe9Ey/d7GvNu2SZxl8vdDvE
 NpQyfLolghC4F4pwY=
X-Gm-Gg: ASbGncvCKtAhiqEhSW0btDudAdsXuji7a7G0KvimWH/zCzX2WrTaYy/FpRozwcGJHQU
 gXaY/YqTkZ3I2CWJyd0k0snVjxjTCOm6VL+x1rPEHbJefXFSU+GBqWcxMahCSOA1iMRpOwh017k
 M=
X-Received: by 2002:a05:6512:4028:b0:54a:fa58:a6f4 with SMTP id
 2adb3069b0e04-54c19c5d2bamr335351e87.24.1743577232682; 
 Wed, 02 Apr 2025 00:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLy4ARc4HOCd/0HY3RHV08PKStY/Yu5VgDQAwkIGPR2yNT3VFtYV2u5mgFNuq5FlwowK7dyRitPqQR+Dc8Ya0=
X-Received: by 2002:a05:6512:4028:b0:54a:fa58:a6f4 with SMTP id
 2adb3069b0e04-54c19c5d2bamr335345e87.24.1743577232285; Wed, 02 Apr 2025
 00:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-5-david.marchand@redhat.com>
 <4725377.72vocr9iq0@thomas>
In-Reply-To: <4725377.72vocr9iq0@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Apr 2025 09:00:19 +0200
X-Gm-Features: AQ5f1Jrw7t5FWCgxsFsDkxYvZ9N8KlV3j4jUom1lLyxPSb-18zTp371PMYBdiz0
Message-ID: <CAJFAV8zJSs6MyE-V=EokwxhKw=2_f+7ohphLP8eP-3WKsW9AUA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] build: generate symbol maps
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2zqzg6WSKG0B6X1BJM-QXBnB9ktXFOrjRUNcifxP6-Q_1743577233
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

On Tue, Apr 1, 2025 at 10:25=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 28/03/2025 11:52, David Marchand:
> > Rather than maintain a file in parallel of the code, symbols to be
> > exported can be marked with a token RTE_EXPORT_*SYMBOL.
> >
> > From those marks, the build framework generates map files only for
> > symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
> > becomes unnecessary).
> >
> > The build framework directly creates a map file in the format that the
> > linker expects (rather than converting from GNU linker to MSVC linker).
>
> At this point of the series, the build is broken.
> I suppose it is a tradeoff to avoid squashing 2 big patches together.
>
> This is the error I hit:
> drivers/meson.build:275:37: ERROR: Unknown variable "sources_avx2".

Hum, I'll have to reproduce.
I had tested patch per patch in previous revisions, but I have a doubt
after the rebase on top of Bruce series..


--=20
David Marchand

