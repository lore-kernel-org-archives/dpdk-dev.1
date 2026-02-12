Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9918EE3698
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 16:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E49BD402E2;
	Thu, 12 Feb 2026 17:54:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7E70B40041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 17:54:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770915279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IV2IzhdRfUelBgZGWWqGPDY3v64fWnxF3aiX7uzxWA4=;
 b=R3mTdDdwb07R2byc+yVF/KUyegJNkOb2hkqBYFSabSxGk2KRVTvT0u+3BJWNw4QAxFRv4m
 hUNxrG2zsqLe/0k2XrA9enuaDgt/ZrwL2s5PB4OtiUvzwJnqadj+9uOgTMGTrmlRDdH1jV
 ykLZG3wr0alagntcbk6xI7YFjKHTduc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-ysfE6tRaOsaKLz_nLisD2w-1; Thu, 12 Feb 2026 11:54:36 -0500
X-MC-Unique: ysfE6tRaOsaKLz_nLisD2w-1
X-Mimecast-MFC-AGG-ID: ysfE6tRaOsaKLz_nLisD2w_1770915275
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38713b53884so5251841fa.3
 for <dev@dpdk.org>; Thu, 12 Feb 2026 08:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770915275; x=1771520075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IV2IzhdRfUelBgZGWWqGPDY3v64fWnxF3aiX7uzxWA4=;
 b=ocVoI81DPuUbOpJNmRPH7dog0yRCRwuQ1DMnsPtYxMtF17sRQ/zaNlrHZlbqgAdhT8
 rWNsYekHjyaHi2PzEbmmmRRLDFymimIXCWJJRzPbi8MINUpamfpvVsfDa8bo9RjBL1du
 3QlcDgqSyhikrgPUiw7co+l6yvKwwDb7gYiCce94HGwR2WV3pdWODywDAvClO8cJWhI2
 MFOTEj1WLdmd0D2PddR0tyuKvqIsdJb3r0AuVCCrhKtRVwNEEVej8Dpxe8SaKvvaM6kk
 jPYcRgEsTKhdv5JfanItGaotcEUpNe6sdJAm2jD8OsRECajcIqy6rirzX0pE5MerBrvD
 3rgA==
X-Gm-Message-State: AOJu0YxKAz0q7EWmG6WFPXS6TjTVxc/fzAE6S9ZAwdQugns51ag26yG8
 1ysx5rkrT38+0yaoiWrAWlBn0hWhTAate9y2xqsNyU42cGuM57Xi3AHJjQxFe/LL3uupwBThjws
 J+4h3kxhrhxuUj9LrTOm7JmErYjK6nWj++5BlgBW/GCFn+r9csW8sXZh6V8NUKrYnxz1wsrj6YR
 fukMkHNGWkQem5/CZl5Vk=
X-Gm-Gg: AZuq6aJfv2rkWKwYGdWiiVihEwG7HtpDRLX6XwJSi2kO7VTfAsNSubLy+1NW+1ZnwmR
 AdSV7GfoTPMpmvColIGDYYJ9KmQwI2oC5KNvnhY98p+t0OaHlHNhUL3/r916GataYSGI1vc2awV
 UpwuQjO9i4LKHHuZYsbIaFhK24SSi/PjCQsxYsO7Jj6BERk8/YpiqQDvvXS4miL4eBPfViulQlS
 vcVND9x/XZFcS+kjJ84dYDEIucg+j3O9iH2Hj5c/WDZeJoXMo5ubElvmThfeplJ1v2UYQ==
X-Received: by 2002:a05:6512:3e28:b0:59e:4524:d479 with SMTP id
 2adb3069b0e04-59e64f281dcmr1205060e87.16.1770915274761; 
 Thu, 12 Feb 2026 08:54:34 -0800 (PST)
X-Received: by 2002:a05:6512:3e28:b0:59e:4524:d479 with SMTP id
 2adb3069b0e04-59e64f281dcmr1205045e87.16.1770915274354; Thu, 12 Feb 2026
 08:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20260212162705.3923717-1-bruce.richardson@intel.com>
In-Reply-To: <20260212162705.3923717-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 12 Feb 2026 17:54:22 +0100
X-Gm-Features: AZwV_Qhp-1BPSe3CF9Arxz_cMjTQsTdYyeIdatipWXRy7gvAMfeDimDZTFHQwko
Message-ID: <CAJFAV8xteqCnX7LKqPWFSmvbBz-rQVCRUuSmHLaHdG-BckhAqA@mail.gmail.com>
Subject: Re: [PATCH] hash: fix maybe-uninitialized warnings on build
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, vladimir.medvedkin@intel.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b1tP3TZVJ0hPBWAd9Ps10ny_LDlH5sGx-tYrw0OUBDY_1770915275
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

On Thu, 12 Feb 2026 at 17:27, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Following recent changes to the test-meson-build.sh script[1] to use more
> build-types warnings are seen in the hash library GFNI code about values
> possibly being uninitialized.
>
> In function =E2=80=98_mm512_mask_permutexvar_epi8=E2=80=99,
>     inlined from =E2=80=98__rte_thash_gfni=E2=80=99 at ../lib/hash/rte_th=
ash_x86_gfni.h:150:6:
> /usr/lib/gcc/x86_64-linux-gnu/15/include/avx512vbmiintrin.h:97:20: error:=
 =E2=80=98tuple_bytes_2=E2=80=99 may be used uninitialized [-Werror=3Dmaybe=
-uninitialized]
>
> These all appear to be a false positive, but fix these by explicitly
> zero-initializing the offending values.
>
> [1] 177acaf5cf75 ("devtools: test different build types")
>
> Fixes: 4fd8c4cb0de1 ("hash: add new Toeplitz hash implementation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Too bad Intel CI did not catch it.

Acked-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

