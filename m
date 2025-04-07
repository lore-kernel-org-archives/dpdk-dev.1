Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D819C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 13:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 382F640156;
	Mon,  7 Apr 2025 15:53:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E28A340041
 for <dev@dpdk.org>; Mon,  7 Apr 2025 15:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744034002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4NO2e+uCS6zl9y9MgHYfjzrkandZMW6zwUQifV7DMPY=;
 b=QkTUSMv16uhAYcs4ZuiZhhiv6jHQJ8MOEwpIYe/C4dKxb9UKYQwjCww1BGjmBFwKXh2Bn9
 gBEPxdwNkQ8cqkSoC9SB/FXEpnC9pZAqfcJ0ZjjpATWKXgpcYaNTyASZCUDJnh9dl9k0pK
 C3QCClRAMHtqbDy72minGaZnAn1InBQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-u9bQXUwyMym7ZSqtkyshYQ-1; Mon, 07 Apr 2025 09:53:20 -0400
X-MC-Unique: u9bQXUwyMym7ZSqtkyshYQ-1
X-Mimecast-MFC-AGG-ID: u9bQXUwyMym7ZSqtkyshYQ_1744033999
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30bfd1faeeaso18783251fa.1
 for <dev@dpdk.org>; Mon, 07 Apr 2025 06:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744033999; x=1744638799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NO2e+uCS6zl9y9MgHYfjzrkandZMW6zwUQifV7DMPY=;
 b=ihpszTppoKtKS+WRlmU/71zbjvmWVTZxhk0NdWUfh/P81aKvcwveqd+kufv9tPfyKr
 DwQHLvyZ5Y62d2g8ZWktbsMUcoGqaCxtLoe/Am7mynM48w/sbimKVarGB+g1VTEdACkC
 WrWsm4THK3hlqKa0hcj0jRNq9HF8I46MQOYnr8sH3Oow3564NuzO4HUulG6NpUjZGR3u
 akX9v0bWJLc89YLsYVlYOPtR8MpHyXEAcBhTylEMKRHIUPvTddzRdd5xY6CDM+CaefRJ
 bWse97gTBjvrwVoSCP4q9wlAN9MXIZS7tyDEOJH74kGb+29APVniMaP48dut1cHDMlPj
 mcsw==
X-Gm-Message-State: AOJu0Yxkx/tCjdzsTngsJI67iaEdxbqc9vDPJCaDMBshyxr7BbIGaGqm
 79n/fGt3WcYmIzGQ0G0P2sQ7V7J6znKMHGmPPURt72SQUBkQObvR5OvNfVubuO683ikA88XsiXN
 iHFClSK/oNo2QqotLoC1Qs8xBgeduVKAOFp15kTICvSC4dTHRAKkybgehzR6ZYoHjZgEWL6ZVYV
 7/5PHxWWqzRsmOwL4=
X-Gm-Gg: ASbGncv6QOAT0rUdDxogw9Tt47oQZjvvTZP2rBkayIGSS6YY1yyi49Gv9QI0/fV3Q28
 JADPfzhqPhplQPiHgteP5XM+Jij8sgY+eiw7yBFWnZT5b7MgwsfR04PB532P227UBf438muUV0k
 A=
X-Received: by 2002:a2e:a908:0:b0:30b:ec4d:e5df with SMTP id
 38308e7fff4ca-30f0a18e388mr37029021fa.34.1744033999171; 
 Mon, 07 Apr 2025 06:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3Yk3D14codIB+KFw+4CW5hiVrry+E8OfVI/6sroDJ/T2vuNFcrxyJUV20ywgNMXv8vnFUkLOapfvp8aGcFeI=
X-Received: by 2002:a2e:a908:0:b0:30b:ec4d:e5df with SMTP id
 38308e7fff4ca-30f0a18e388mr37028971fa.34.1744033998838; Mon, 07 Apr 2025
 06:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1740083508-6703-1-git-send-email-andremue@linux.microsoft.com>
 <1740083508-6703-7-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740083508-6703-7-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Apr 2025 15:53:06 +0200
X-Gm-Features: ATxdqUEQeexFWBStR5I5xUZ6MGWC-0JIvpJwWjthdFkmFk4l4AHB9zayigIxAQI
Message-ID: <CAJFAV8yh1+fA=bimjWyHJFYA7rCQUV9U67gHCxtQYsssyVtqLw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mbuf: enable to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iWKooCttO4unNHIb6DMqbGb71lrYGwPijwqUhQjUJY4_1744033999
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

Hello Andre,

On Thu, Feb 20, 2025 at 9:32=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Now that the issues preventing this lib from be compiled with MSVC
> are fixed it can be included in the compilation.
>
> The "net" library will automatically get compiled as well as it
> has a dependency on "mbuf" which will now get fulfilled.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I just merged the symbol export / versioning rework series.
Could you please resend this patch only, for the CI to have a go?

Thank you.


--=20
David Marchand

