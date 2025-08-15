Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A610CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 657E74026A;
	Fri, 15 Aug 2025 18:15:37 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 86953400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:15:36 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b9d41bea3cso1991106f8f.0
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755274536;
 x=1755879336; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vv6LKKkhHv6GYLPrU1ILDjkHytw/FCOsH7CGwvcAv0c=;
 b=GbV2ZuoAsu0U6W9wE4mveaR5yL5Q/l6A5ttnTu5WoT7ENvsBFJ0t26L3tSvEkdtxYI
 ZIDGVJcuzKkxEUxZoWl8u5/0/Bzz+W/TrD1swzsWIg5WITcRv9W0gGkfcmOkpuru96Yw
 J6PgERz7qSnLg4HX5U2UH7Yhj/Kmrhs0QvKKVAj9tkeAIlySfKXYi9548QulMJrVaWfb
 de0ITlD1i843p0bCXO4yiSFeYT6o1qeSv4cIn2Ahdfe/XTt74wFWG9y02xCvt5+CGLFO
 WL1x7ZObPbZD3vvSY7ORvrNmPYI+SUdUYqJxbdPrCpJkS++BBdLbNv0U5Sd4L2iLCpi0
 3l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755274536; x=1755879336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vv6LKKkhHv6GYLPrU1ILDjkHytw/FCOsH7CGwvcAv0c=;
 b=ZZyILSCVxoHxQNjmcne785HqR8q3yv+V1/o6difkIO4kSw7SG1T3iBKbfyTAqShpJa
 hnXtOQKR7nzLZ+bqHz0FPl2WBjuITb5vXXCuip535lkHi6jbYJl6j85901vMPJ/U+CcD
 O0K3/AW+U8qmOOtiFutIZIShPkGKsQ2FmwvA2HwwTP/af/nvYrCHxNDo9XthOXfB0Frh
 5Gon5I/9xqRdvZEGViwTmSF5NU3yqGmjFZgov4bXHGU2xRqGvyRN886QwC5KVi+h+CBO
 SHkwygdzb/yf5TcMIzuSpBNALqZxtIp0Ti9cpzT5Xqe5ugIur+Q5Md4SWB0NtGX25izP
 Rv3g==
X-Gm-Message-State: AOJu0YzksgKe3gkDTeTSKvD551Ea5Snoe0aVj6EHbXmrKMwl1bRncNop
 5nO626exoebUbHe3KhF0w8dkL4OBD8YfhHVF8S/GXsrGCRhz/1j+ElFrTlQt1lY8w7E=
X-Gm-Gg: ASbGnctj26QH1KSvbPFcPEUELCZoBhlBKuUgF7NsVJe+u2/HNWbymGJfQINxD7lHKed
 S4VSuKi/skj8Sj+b+cAeEXs3R9dUAYuSqrzBfMKcx9r2wSdqP7nMg9Eue/T0TNJSLyg4fPxIsv4
 JcKmHGju+ljn5bYjkh4HyAh5Tf/jPi4/swAsBYzmwyIILIZmr+hwNfHQYiINOFAHh5S6EMr22a8
 dMF0C0zsF+rQPX0mTX3oIVzgymKZguvnt6x0QS64XEuwK9raxxpBf92LCBp5bCP0hSGe0A84v3W
 S88War0BFRss5dvcNziWqPDg46xxp6C7LxU7RQUFqQJp1MWQi8+Rjk4ppk+a2Etghf6i3TC2M77
 lywU55VYdYouLcZlTZNewZLNpLJDudQzSiEpfJuAoIZtCLLK2iwwQCdLVCzYfX4zOgQMyKbq/eY
 s=
X-Google-Smtp-Source: AGHT+IEibyS/dqUCYaj/rkh48DStpVVctmNMarz2vM7SoTUA9rIxVX68qAT+EFy9QuvH/nnx+4uQsw==
X-Received: by 2002:a05:6000:290c:b0:3b7:924a:998f with SMTP id
 ffacd0b85a97d-3bb66a37a11mr2276812f8f.5.1755274535984; 
 Fri, 15 Aug 2025 09:15:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9a67sm2470516f8f.35.2025.08.15.09.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:15:35 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:15:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/6] Enable warnings about use of comma operator
Message-ID: <20250815091531.269017ab@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE37@smartserver.smartshare.dk>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE37@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 15 Aug 2025 08:40:58 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 14 August 2025 23.29
> >=20
> > This series was motivated by recent thread on netdev
> > about build with -Wcomma in clang. This warning catches code
> > that uses comma where a semi-colon is a better choice. =20
>=20
> Overall, I agree that using semicolon is better for consistency is most p=
laces, but using commas in some loops - e.g. "for (dst=3D,src=3D; condition=
; dst+=3D, src+=3D)" - might be more readable than the alternative.

The compiler only warns for standalone statements, it handles the case of f=
or(i=3D0,j=3D0;i < n; i++, j++) with out
warnings.

>=20
> Stephen, I'm interested in the discussion about this, can you please post=
 a link to the thread on the netdev mailing list?
>=20

There is not a single thread, Simon sent patches for Intel and Nvidia drive=
rs that have been merged.
https://marc.info/?l=3Dlinux-netdev&m=3D170280627225075&w=3D2
