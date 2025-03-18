Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683FC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 08:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A345402C4;
	Tue, 18 Mar 2025 09:19:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 766B240291
 for <dev@dpdk.org>; Tue, 18 Mar 2025 09:19:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742285983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JX1V/3qp3GUz0ODqoej+t0kpwfk4787tc2h6d6jOzAc=;
 b=Lz/wVUnAu29MEX1YwdH2OG4r8pZ7p1EhYHsQDxUxyeT53eC+I4Kw6nqHS/AEYckz5y7dbM
 GV3tf9SDhqhQNCt1EfhUFXthVqXVoQ+w+I0apbzdjzTDemH1tkF78qlhTpeecUjVk12jY6
 JxTjAf0QJ0+FhqfDTVwAHQ17oPB7/R8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-723GcsRkPG6_sQ-ruJeaaQ-1; Tue, 18 Mar 2025 04:19:42 -0400
X-MC-Unique: 723GcsRkPG6_sQ-ruJeaaQ-1
X-Mimecast-MFC-AGG-ID: 723GcsRkPG6_sQ-ruJeaaQ_1742285981
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5499d32e5e2so2902508e87.1
 for <dev@dpdk.org>; Tue, 18 Mar 2025 01:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742285981; x=1742890781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JX1V/3qp3GUz0ODqoej+t0kpwfk4787tc2h6d6jOzAc=;
 b=AbJKUK3ApleX6hxBSxs6sC9KRrgs5uRNTpX98ANjqXzkIfIct8+7CK56GSIHS0BV7z
 P9jYq6n+gO3L1M6LscZmmlLjUJqyvaNgRDXe5AyyuldCYJVsWNxHkKblaet+1i3F0AGX
 QP6+JfNqNVvbXFHl+oHCoyWDTBhqwYjsClVWdz7GMr2T+Mzoc8h8cJ59CeTfenEePAv+
 +u1xSxFVrqUjrCxh+da8Zstr64+Wn0cbIKnoDsfYPRt3fQjKGZgy4EGMUFgUSI9cJGT8
 QzsQE2KY0cYjWb6u6JVqAfRKiGkaCX0ort7+1C6mGtSl5jxosY3RhGJo5eYNBQzTax48
 HdBA==
X-Gm-Message-State: AOJu0YzajYOHTjbS9deiH/VCAhFgqyYiYOcqZAhnyyUwEifvUNCJyCBx
 nKY23a1BnGKhuKgsYT70E/3mfaZWKMx3X8h5Y2y/gnCJPX6iCbESfSuJBCaHTaZG1PL7zOM6eef
 gbfKK9pTVt1ABuZSdEzONw+QobXR7Z9t+BP96Gs3sc5vQZ6pA46pVrvWYtu4X9UZIpmKTmSO2bA
 3ckQ673eFbnyKxMxOBFsmbjKA=
X-Gm-Gg: ASbGnct0E4sMB+pdGbvjov8cN/LoAhNYc4ExaEOedEQY7C6S7sc/DbHRBlbaCwEWOnb
 SEoZpb5XTI+CvrbFKUoKcziXGLEJatVIX1nPPLtclb9gRtULwXq7prOMU2Gf97/O6QGZg1DP4Xt
 U=
X-Received: by 2002:a05:6512:3b9b:b0:549:57ae:ab38 with SMTP id
 2adb3069b0e04-549c3988020mr11294448e87.45.1742285980751; 
 Tue, 18 Mar 2025 01:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeQO+Xope4KW4XBKdx36qOkmbKxhTlmklfFS6mBrEFIk9ZmMkGBWhHH/dXzH0VqR+dhT6hDx/4twOY8+d5rkA=
X-Received: by 2002:a05:6512:3b9b:b0:549:57ae:ab38 with SMTP id
 2adb3069b0e04-549c3988020mr11294431e87.45.1742285980382; Tue, 18 Mar 2025
 01:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
In-Reply-To: <20250317154308.2782689-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 18 Mar 2025 09:19:28 +0100
X-Gm-Features: AQ5f1Jrbxk-qq9SyYEIWHlpm8U55mkfwl2_TltciledcSWf0ka-j2w6UN-HioQQ
Message-ID: <CAJFAV8ygaF-WL+eUkng9S5qTbdRCtrhDuYq=BJ9ydqS+e=kp1Q@mail.gmail.com>
Subject: Re: [RFC v4 0/8] Symbol versioning and export rework
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, 
 andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jyFlY2a6HrJZ_3bxVKV03WLqK6vR-zzSst1qrovySSc_1742285981
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

On Mon, Mar 17, 2025 at 4:43=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> So far, each DPDK library (or driver) exposing symbols in an ABI had to
> maintain a version.map and use some macros for symbol versioning,
> specially crafted with the GNU linker in mind.
>
> This series proposes to rework the whole principle, and instead rely on
> marking the symbol exports in the source code itself, then let it to the
> build framework to produce a version script adapted to the linker in use
> (think GNU linker vs MSVC linker).
>
> This greatly simplifies versioning symbols: a developer does not need to
> know anything about version.map, or that a versioned symbol must be
> renamed with _v26, annotated with __vsym, exported in a header etc...
>
> Checking symbol maps becomes unnecessary since generated by the build
> framework.
>
> Updating to a new ABI is just a matter of bumping the value in
> ABI_VERSION.
>
>
> Comments please.
>
>
> --
> David Marchand
>
> Depends-on: series-34869 ("remove driver-specific logic for AVX builds")

Erm, looks like the CI did not catch this dependency (maybe I should
have not put it after the signature.. ?).

Anyway... this is 25.07 material, I'll repost once dependencies (Bruce
series) have been merged in next release.


--=20
David Marchand

