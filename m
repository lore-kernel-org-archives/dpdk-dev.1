Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5484DC02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 14:10:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43983402C4;
	Tue, 18 Feb 2025 15:10:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0BF1C402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 15:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739887828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VuwPTT3qdeVEQiSrNVgtc/Kf/Ci+eMFaWndbzoFwvQ=;
 b=LT4fQhMGDSBmBnxQaYYCbodbtryKIITwe2yFoi/v7xTq1QntCebKCnxhu8KLzJFLU7Q5v6
 fBkZEvo8ErF+/NYNxN1Agok/LqZ9KoMfJ4nT3Jjt76e5yy6Gsi3do+wC4lnxSQBp9zjsHT
 pxRC+uXQ7EmM2TtGjht9TNFb0w2kFb4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-v67r9pQSP4m_i-oUJ0RVXA-1; Tue, 18 Feb 2025 09:10:27 -0500
X-MC-Unique: v67r9pQSP4m_i-oUJ0RVXA-1
X-Mimecast-MFC-AGG-ID: v67r9pQSP4m_i-oUJ0RVXA_1739887826
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-545319f8e7aso1542138e87.1
 for <dev@dpdk.org>; Tue, 18 Feb 2025 06:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739887826; x=1740492626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VuwPTT3qdeVEQiSrNVgtc/Kf/Ci+eMFaWndbzoFwvQ=;
 b=hn55TG0lk4ZyW/nwR1K3o2xXWp3PZ0YVphfrzPGR/iRqOknetubG+ikH6tFnMJOvZu
 YgnEn7c2API1YW84rdct2/QWFiiEgfyA+y2ZQLkD5zeLj2F8cuDLgzyRGTb1Qwu+aNhY
 Ae5WN1/gmRPZOZq2SPxDcOPrxDX3mxZbrM7sQxK63DGRTlKBhNVEaxZS6EzkNNM0vmCh
 GvXpwsILvodfiuTly+4Qvxt2Yz2O4ZFXnRo1nHys+j9eZUWGeY2jqAhE4C84uKAaug1c
 J7EYsv1n/CxScAbjb/KAYSqan1TWX3Btpf7PAFb2O50CXR6KWz78woS5B3hqSyXhF0xA
 eY+Q==
X-Gm-Message-State: AOJu0YzEC6KY+h2YUy5Pc7jru/cohRTXuLDuS2c040qeLeDGYDCd6suM
 8T6cXQZqUgyUQ0YK1StUbyQG17F0SmOTp5i5VbI+1z7GOumTL7CSXSTR171iDZA+YRl/qtv3S9K
 exdVf7X1IyB+aRGTka7BjuMm8kr183zYyfEK0YCeK9Uop5eVH0Q8M8Atk/VZJ52pZ8OcWorxgWd
 kG+6k/b5xmCZ67zxs=
X-Gm-Gg: ASbGncujOz3ucgfgMfSnB7U2Fnn1hVcTROHNMPEp7RK85Mv71dIIINQ54qFw/uHGa98
 iT20mmqamKHmfNj9qNSAzrdjL2/3GVsX85VMw/gber7c7eZLJPxvWDneE9HsMjPe/
X-Received: by 2002:a19:2d08:0:b0:545:1d96:d6f7 with SMTP id
 2adb3069b0e04-5452fe80778mr3877781e87.32.1739887825724; 
 Tue, 18 Feb 2025 06:10:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtrE6Hk3zNRd7GVZOTRsDiU4TSqMER0hLo0i0xtFaug68ArUk0e+MOVm3knjz6D3M2uOZbKPwyrqW90X+h158=
X-Received: by 2002:a19:2d08:0:b0:545:1d96:d6f7 with SMTP id
 2adb3069b0e04-5452fe80778mr3877765e87.32.1739887825342; Tue, 18 Feb 2025
 06:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20250213075010.2670431-1-david.marchand@redhat.com>
 <f7teczvbcph.fsf@redhat.com>
In-Reply-To: <f7teczvbcph.fsf@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 18 Feb 2025 15:10:13 +0100
X-Gm-Features: AWEUYZmH1UyoYKlfQqNO7li6RS6tYcfranZvdEgbPx75ZmSxEOF917giIZeQjwA
Message-ID: <CAJFAV8zuMwzA6mPxzPsk3d5OHjYu3vVjHtTzwODjxDmm7aJAKg@mail.gmail.com>
Subject: Re: [PATCH] ci: build with MSVC in GHA
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, andremue@linux.microsoft.com, 
 Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7qqu5DzEnCxP4Ib8rcRjQ2WH8bMXZ-bqzQ2WApLtSA8_1739887826
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

On Tue, Feb 18, 2025 at 2:32=E2=80=AFPM Aaron Conole <aconole@redhat.com> w=
rote:
>
> David Marchand <david.marchand@redhat.com> writes:
>
> > Add a build target in Windows 2022 for MSVC.
> >
> > Loading MSVC environment and having successive commands in a single
> > (cmd or pwsh) shell does not seem to correctly report if one of the
> > commands failed.
> > For now, load MSVC environment and run commands in separate shells.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> LGTM.
>
> Acked-by: Aaron Conole <aconole@redhat.com>
>
> How far back will this work (ie: can we backport this to older branches?)

MSVC was added in 23.11.
The patch applies cleanly and runs on 23.11 (where only lib/kvargs,
lib/log and lib/telemetry are compiled) and 24.11.

I can add Cc: stable if you think it is worth having it in LTS (UNH
provides some coverage in LTS releases).


--=20
David Marchand

