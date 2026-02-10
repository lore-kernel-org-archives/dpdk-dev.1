Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D7E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA63740611;
	Tue, 10 Feb 2026 01:10:32 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 745E4400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:10:31 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4362507f396so234359f8f.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770682231;
 x=1771287031; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1Z2ZnWZkxE2ofrYnyR23LexqKskgyMJdwijpH4SaF8=;
 b=abt4QL70oKBbKXKaSIewsHgu/cOhTONVHuxbj5dW8VK+CdVQp+mMEP8UydyG9QE70Z
 jqE3zYazz/K+yFwrke6N7zTJa4ECBeQuvE8vOeTVS+4Co2o3nEb525XljPTOXmemX0vf
 /43sgAe8iSpH5+aAKPlEkics9SSYXSrbUvQBVFjIv/kHwc43AXk+l71pxiqX2mBZxSlS
 4dahtSpacePF9tA8B5OZd309mYh9O59xDP2w5d4ynyGPZ5a1C86Qau4Fbni2eTmM2GBN
 ROIG3irvxlrWbr0UBKiFUYaKOkoRknKL81y9JtUe7MAU2VIW3EqtbLtMu29jgNc3OYoj
 IOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770682231; x=1771287031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a1Z2ZnWZkxE2ofrYnyR23LexqKskgyMJdwijpH4SaF8=;
 b=HRzsS4tfyGzS6LVusnxdJ04JWHcQjXamZ/GvD1aowYs3BFmWJfER+Iq/ZMcT/rEY3x
 QlSMaJtcRYidmSmspcMvSKdcni+TKjQZIsFMfnl7uYB+kNb5OFLKCf7NCntxBiUcBTJN
 vRSeovNp2nhbx+BxTPOXamIgspMajBRlUXrqocJOZV4n8ZGUlnurNj0f74j6TIDOuxzS
 PYdqdy40Lg6PlVHsaNkzNEfVu+9/oA0urqg9dbgb/JZRNeYsn52Hcv7PCH0qJC/WwLgm
 c/8bCAaYDzimPhY7+Q2qsaif568hKbD58Opj9MSCxtWR3eM713CKcFDBioGMYCEj5Q6T
 PsEQ==
X-Gm-Message-State: AOJu0Yy7Rpav8N4ILDQmUAaJ7+SEZDTHTh1dzRbRJkuneHdEHOf0A0NG
 G/88MGKfu8xqJaP2hOR1zpZT0uoTzFChifc1tzX8F4CIv9c7LSed+j3UPeYYBXSD9Bk=
X-Gm-Gg: AZuq6aJeDCCFCndK28bZ523aUYDJGX2DrLGbSmNmiBIlsDsjnYELx/OqaFxVYQlag6F
 BMNzPCCpr7DgKrEmZyocUkkVxyVNj1KAo0rKr+e2O8vEPSTMU85+P0w5TZfQ+Us9Zk+N6P7lm38
 876AEyazy4aioWzmvyaPQkzZJ79hTYSio3X6w6tAZCVwVAWx1GLPs7R8aNAs/V8+klpPK8vNP/j
 PE425AOpAFa+2uvQbFGRev2Dbg11HQLlflN/0oZEFlQtKzrDtfGRqNpERwv3peeP2lJtPz2dEFc
 dyqTqHWKUaIc3oroJ3RUsHaTOhGpVXEri4Em4iXdWZ7rA2hN4W9POXQi4bpqBr9wiQ/RKcKR1Fy
 xMz2F7e597UGqKXCTsYD8XvvXI8eEvYcUT5+JWlVbXtX8QRwSlS7X6eLaAJm11K8F6UMRIuJ4Ul
 xKaYlNnZOY3n+Utk8bdLA9z0Wn4zunR7MwmR8fOkRsnClUNPipudcB
X-Received: by 2002:a5d:5c8a:0:b0:430:fd84:315a with SMTP id
 ffacd0b85a97d-43629381a52mr18082816f8f.39.1770682230947; 
 Mon, 09 Feb 2026 16:10:30 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b2110sm30333676f8f.3.2026.02.09.16.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:10:30 -0800 (PST)
Date: Mon, 9 Feb 2026 16:10:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kerem Aksu <kerem.aksu@i2i-systems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] cmdline: update clear screen behavior
Message-ID: <20260209161026.0dfed9e5@phoenix.local>
In-Reply-To: <20260116154256.206571-1-kerem.aksu@i2i-systems.com>
References: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
 <20260116154256.206571-1-kerem.aksu@i2i-systems.com>
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

On Fri, 16 Jan 2026 18:42:56 +0300
Kerem Aksu <kerem.aksu@i2i-systems.com> wrote:

> Control+L should clear screen and redisplay prompt at the top
> line. DPDK rdline library will not change anything on the screen when
> fed with Control+L.  When prompt is lost after too many text written
> to the terminal, users will press Control+L to clear screen and put
> the prompt to the top line. This is expected behavior in bash(1) or
> applications that are using readline(3). Updated to behave as users
> expected.
>=20
> Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
> ---
>  doc/guides/rel_notes/release_26_03.rst |  1 +
>  lib/cmdline/cmdline_rdline.c           | 29 ++++++++++++++++++++------
>  lib/cmdline/cmdline_vt100.h            |  1 +
>  3 files changed, 25 insertions(+), 6 deletions(-)

I was going to queue this to next-net.
But AI review sees some things that need to be addressed.
Do you want to resubmit with fixed release note, or I can fix that.


Errors: None.

Warnings:

    Release note entry is placed under "API Changes" but the public API sig=
nature is unchanged =E2=80=94 this is a behavior change and may belong unde=
r a different section.
    Commit body could open with what the patch does rather than jumping int=
o background.
    Pre-existing missing spaces around operators (i=3D0 ; i<rdl->prompt_siz=
e) in touched function =E2=80=94 good opportunity to clean up.

Info:

    rdline_clear_screen() wrapper is only called once; could be inlined, bu=
t the named function improves readability at the call site. Fine either way.

Overall: Clean patch, good refactoring approach preserving the public API. =
No correctness issues.
