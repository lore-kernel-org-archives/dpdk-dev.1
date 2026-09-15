Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307BBC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FC0D40DDC;
	Tue, 15 Sep 2026 15:13:11 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id B5A64406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:13:10 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 d2e1a72fcca58-86efece610cso249772b3a.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789477990;
 x=1790082790; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J8MqMLgeTmlHh8djedwWy2iJiE240eJ/031WiTOvwEM=;
 b=Vg/V8r5jqfu82hJs36wKM5EBmZxNVJMbMP5SKYJ6gQkeSniJp3qi9O0nklvoBxhk7N
 jFCmVcUaZc3OOA8xfvnctvViPU854OfkVEx4fft3sOnMmWloY7PVlbqeaxY0HG7u/JKX
 YA2gAgOg5w1U1wAchQT9Hjx/Yp6CNajKmLg8/xEn7LlCov7j4NNEzg5BHWEwltLtc4Pp
 4jfdK4eMv9qZMI2JQeKGXjS2hBv5YqbtxzeWf32wEn6Vy8ZJMkJHmJVzKun1Px+u9L24
 PJ3RPDf+wA9mJEiTc9ju9tfi4s4UPE9e0CLfDLS+Fg/FFKqmWyW0TP25XxzMjSaCQGLl
 Iptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789477990; x=1790082790;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J8MqMLgeTmlHh8djedwWy2iJiE240eJ/031WiTOvwEM=;
 b=oE6s4eupW7nRh3eq7KpXTFqNVEPLU3cSvBoyYkFRCZn0Ar/NNmo8+HTjE1z8ufXS7j
 fruw5h2irDcM1LRS+Do0HLO7HVnSeNCY6EVEyBKupU3/GlKPibRdS7z6015V4v3c56Ne
 IsBw7pxG70IMi77kCco0OsZkX2AO2x0idTABo9QR2sDosO2gJ0PsW6zdhMTdGcrIopl3
 oMUX3IoOCNaSpO+q/Wv+XvZpvPcKpz0sNO9yrxCbduPQMRBYOvegAufXNr3JFbjjC9Wp
 E1EQXJ9/P2cvC/VGrBhom43+mt6leeS0Or6Am1FubC1WvE9w1nL6Wtx9rU1X4QQbrsEZ
 GiZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQmyoMdyue93S86WL7Pnlb0aBjzTsrcpN41fKB8Ixsiu8j0v1Nw2tLIcVuy1phAw3XQVc=@dpdk.org
X-Gm-Message-State: AFuF++nM1eEmv+HPedDrY5fQoUesq+srnZy6AGm9yVv8eGc0WyEOLUus
 Nw8GHfjiFng9wAQgggaoEr/7GEBcGUWBRVIlNz+uKM7HB/JM0hPK0MoWs8GJUOxsGEE=
X-Gm-Gg: AYBFou0LqqaQzi+BcoNvjug11fOQqvsBXe2mNtL79fG/8hDTLzeCzPYmnB9d+IAkdj6
 Q8zl2vQCOSGOLF9SrUYiZTRhJPuz1KLO9pXziyAosTEcREGomWGuNbROJ3z4QJT3Ms+6MKeDoe/
 uqcLyw4744Yt1Ty0UCvI/4arhD7f+HRT3MpoQ4mnM6P7vV4U4532ZLdAyBPlHTLREIiKUNu4/Ts
 Il5XkWsx8N2LdSUAUhI78ZBBjKSco9Iod00Qm94v6IHLV/9MojCDZPCDHqVaekT74xxepGhwDef
 riHgJ8WZK6V3J0a0uRDS7rfv6SnsSCsbBo1mCPcxrwKzFT8QfVGD6Tub9d06BGqIW1ufORERItZ
 ZiAa7hwaWP51lD+WBmedSHx7L3uE7QEOc5K6JldD/Ti79PruoxamHqziyjNOTC7jY3OU5uYWP1l
 XO2VwiVSaR54QsNog2rM622Zw4Bvs1zJTr0NiDRW3d5+sI0Dc6/qLyMec4zzrm3eM73i4crUR71
 9pgI7oHQKEAEICfKXRyOSJ4CksbrUFl3t3WDq+h
X-Received: by 2002:a05:6a00:a24a:b0:857:727c:a1f3 with SMTP id
 d2e1a72fcca58-87180ef3b18mr1515386b3a.21.1789477989756; 
 Tue, 15 Sep 2026 06:13:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b29dc0b1esm6273842b3a.48.2026.09.15.06.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 06:13:09 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:13:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 7/7] app/validate-bpf: add BPF validation application
Message-ID: <20260915061303.415ba389@phoenix.local>
In-Reply-To: <20260914145418.37353-8-marat.khalili@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
 <20260914145418.37353-1-marat.khalili@huawei.com>
 <20260914145418.37353-8-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 14 Sep 2026 15:54:17 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> Add a new DPDK application, dpdk-validate-bpf, for pre-validating eBPF
> programs for compatibility with the lib/bpf execution context.
>=20
> The application allows evaluating eBPF programs against the DPDK verifier
> before loading them into a real application. It includes an interactive
> debugging mode to trace state changes per instruction and understand the
> validator's decisions.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Build fails on FreeBSD

*Build Failed #1:
OS: FreeBSD15-64
Target: x86_64-native-bsdapp-gcc
FAILED: app/dpdk-validate-bpf.p/validate-bpf_parse_decl.c.o=20
gcc -Iapp/dpdk-validate-bpf.p -Iapp -I../app -Ilib/bpf -I../lib/bpf -Ilib/e=
al/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/inclu=
de -I../lib/eal/include -Ilib/eal/freebsd/include -I../lib/eal/freebsd/incl=
ude -Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal -I../lib/eal -=
Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/m=
etrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse =
-Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib=
/ring -Ilib/net -I../lib/net -Ilib/ethdev -I../lib/ethdev -Ilib/meter -I../=
lib/meter -Ilib/cmdline -I../lib/cmdline -fdiagnostics-color=3Dalways -D_FI=
LE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -inc=
lude rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliter=
al -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-e=
xterns -Wold-style-definition -Wpointer-arith -Wshadow -Wsign-compare -Wstr=
ict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-missing=
-field-initializers -D_GNU_SOURCE -D__BSD_VISIBLE -march=3Dnative -mno-avx5=
12f -mrtm -DALLOW_EXPERIMENTAL_API -MD -MQ app/dpdk-validate-bpf.p/validate=
-bpf_parse_decl.c.o -MF app/dpdk-validate-bpf.p/validate-bpf_parse_decl.c.o=
.d -o app/dpdk-validate-bpf.p/validate-bpf_parse_decl.c.o -c ../app/validat=
e-bpf/parse_decl.c
../app/validate-bpf/parse_decl.c: In function 'take_arg':
../app/validate-bpf/parse_decl.c:392:33: error: 'array_length' may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
  392 |                 arg->value.size *=3D array_length;
      |                                 ^~
../app/validate-bpf/parse_decl.c:381:24: note: 'array_length' was declared =
here
  381 |                 size_t array_length;
      |                        ^~~~~~~~~~~~
cc1: all warnings being treated as errors
