Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA5C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 16:03:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 365FC42E67;
	Wed,  4 Jun 2025 18:03:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 79F9342E45
 for <dev@dpdk.org>; Wed,  4 Jun 2025 18:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749053028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDyypYhoIT1iMYmkdxn+L4cm8Aoc1BJZdIN3xProyU4=;
 b=M3UfmpOjqMrOEi02uBFZXsVLggaLkz/JDSQEJpJJVNv87FQd5vczXitcMihNXGvqe2i8mp
 +qV2gQDZcwqrubgKKJIMByggOqNBfT0GyxNajOqFjDng/+Jejs3/+HX2n+qRTwNsBUiBuL
 nNuRf4s2f8oMw9t71Pg0MbnXzK25UWk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-EcVBjKBoM3-Rv6gLs1sDhw-1; Wed, 04 Jun 2025 12:03:45 -0400
X-MC-Unique: EcVBjKBoM3-Rv6gLs1sDhw-1
X-Mimecast-MFC-AGG-ID: EcVBjKBoM3-Rv6gLs1sDhw_1749053024
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-550f0376a83so3382333e87.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 09:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749053024; x=1749657824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDyypYhoIT1iMYmkdxn+L4cm8Aoc1BJZdIN3xProyU4=;
 b=fDJbMVoAIGPZ3XCViV2g1EcLtX5tsTsy/twC/y3UqfXu1kCXV1/DIxN+0IpRHZ+qFt
 EWnNWh7mj3a862veuaJoqJ6gdevmAjqYGenEIopY42arTk9hcJNFzwhpAsiQVSWPM48y
 ETTNJV09pBFkVUCWjOmp3w/KJD03ZpHYjB1Z7v5IZ5cOad8Qve+lJGXvbxet1a3m7oPN
 rOmgq5l3MypAbQahiDbQaLnw86kMe92pXoDuJM31BZ0T4e7h8R43Wt5NMF/1zjePaKbc
 Q3KYNYrJnpEyY32D3T4cDAm0meQj56mC+sl7XSi1SVkkpOsoHHPwec1tg+tP1ZwN8ocN
 KT8A==
X-Gm-Message-State: AOJu0YzmqDXo0SjIptdsxD9O9ciz2jp+BKnpJzQOA8rN2cJDVvRC0xtk
 YLycjHnjezDVfh15BA/lZ4NdSKDK4bpcQTDPzeSp6Og/svkX9MTy9Ktpt/kNc8vtIrr4Qd8xWvX
 ZytxyEEcWUc/8iD8+qG7AbxBbvZv0dxoatl6aeDlMgibrzHACs+0D1txKqv+xRFdwuQK7vMRJpm
 OOPJVIWLeewEyfTirNIvA=
X-Gm-Gg: ASbGnctDl+9isV3Pb0+0rjvy9d2QEaT559oq13ro8GWEiV/vSlNQDDTrWK7uU1Qwi5R
 SvPmtcAzpG7LA+Xwhnpwh23TuQ81p8okfHSbGpQNjenUeGQk1Q6+KTDjLJA3RSK/rH7knEQwrZA
 YzUXkqsg==
X-Received: by 2002:a05:6512:3e0d:b0:553:2bf2:e303 with SMTP id
 2adb3069b0e04-55356bf9864mr1060071e87.30.1749053024243; 
 Wed, 04 Jun 2025 09:03:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3OBVdLzMYcS0zZFyHr6+Gw34jTdF49TyNj1aQu0UQSHt1ueHzpMxVadNnjgH5pnJXCzT9SIFfHgkWwX/7krA=
X-Received: by 2002:a05:6512:3e0d:b0:553:2bf2:e303 with SMTP id
 2adb3069b0e04-55356bf9864mr1059983e87.30.1749053023374; Wed, 04 Jun 2025
 09:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250402124258.2299435-1-huangdengdui@huawei.com>
 <20250403025736.135846-1-huangdengdui@huawei.com>
In-Reply-To: <20250403025736.135846-1-huangdengdui@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 18:03:31 +0200
X-Gm-Features: AX0GCFt_70hIwgXHYW3JYEiWK4KnsZGrMUIAtIUJv9o3K5O72NiZHHvbfOiWkqY
Message-ID: <CAJFAV8xu7i7O3U3mQS3+2=kQYh2j2fvLcZNZ6U19_=YtPA2+3Q@mail.gmail.com>
Subject: Re: [PATCH v2] mem: fix infinite loop
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: dev@dpdk.org, fengchengwen@huawei.com, lihuisong@huawei.com, 
 haijie1@huawei.com, liuyonglong@huawei.com, roretzla@linux.microsoft.com, 
 anatoly.burakov@intel.com, stephen@networkplumber.org, 
 mb@smartsharesystems.com, dmitry.kozliuk@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D8nu0Lzjy9z0WR7Ei7ui6R0DDAnZpHL0TN4OfBI9hDQ_1749053024
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

On Thu, Apr 3, 2025 at 4:57=E2=80=AFAM Dengdui Huang <huangdengdui@huawei.c=
om> wrote:
>
> When the process address space is insufficient,
> mmap will fail, which will cause an infinite loop.
> This patch stops attempting mmap if it fails and
> the requested size cannot be reduced.
>
> Fixes: b7cc54187ea4 ("mem: move virtual area function in common directory=
")
> Cc: stable@dpdk.org
>
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>

Applied, thanks.


--=20
David Marchand

