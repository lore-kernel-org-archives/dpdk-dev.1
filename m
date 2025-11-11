Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE25CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 16:31:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8C5E402B0;
	Tue, 11 Nov 2025 17:31:42 +0100 (CET)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43]) by mails.dpdk.org (Postfix) with ESMTP id E539040280
 for <dev@dpdk.org>; Tue, 11 Nov 2025 17:31:40 +0100 (CET)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-93516cbe2bbso1093153241.2
 for <dev@dpdk.org>; Tue, 11 Nov 2025 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762878700; x=1763483500; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHZH+lFhMcGMH5HZfVuw8C2lyEvVPAus3RTVYTpJlX4=;
 b=WTn24CjOfiqoufLJ7k//Gp+t0O2z+OsDzNh5kBC3l6C56WmUeHVJAfUIMO6mEOBk5e
 HOJdr7UKUaG/wFFZP9Qtlq2/XQ8VHOhTHeYySowy/NPa01Z84t6wHddJN3ClMPCw0NzY
 H7k2eAv7+zSJppzm74iikmR3kWsZNiaG1T3TquYrfHqO6H8R0uHauvAbFsWBX8hoJB6h
 r2LmdpyZkT5Yfprhwmy4KLqRk6Zsx+Ae+LkxRFIC/P/eMNi6jjvpZkuhwPW/qiUPkQeV
 hnhvNcugj/LMWDvfrIbe0FsAzXdG0Qnl9C9D6z9R17wo/b/qbW0c5o7b7G7eeM2o1+rM
 tDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762878700; x=1763483500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QHZH+lFhMcGMH5HZfVuw8C2lyEvVPAus3RTVYTpJlX4=;
 b=l3K0m5xz/w31QjYcI4W9eAgMvjXdV7pLaRz7vf376ME+O5gPs5yoj6NS0BP7ahZxXs
 IMf1g/NTTkPZhtDK+JbFhEhsYZUs5Utt1tFKAHFwqvmXiYZTAg9aygsuuibfJDJZ3PR/
 NmN+KjcUm+wROtBR4ZjqYrmVLP+mxjKOFIgLw5Wnn8d7xT+Z0vAJcSgkosyjFKVi3LGb
 FCBEUIikK1WlukSS/NnzLZHf7f6ZrD2BtmNIGBdujJkJy0mftpqndWHo/M3uAcz5Ya8+
 fPjc97GUi5s0IdHmRx/XiaNM/UOZOLtaweuu3idn2SLBlfAvoSephhA8lISLKYSR5bo2
 MUYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnbepBzPVTisFAzWHmuqhmL3zi0Lg3/oyIZpHZt7xdUm/J9VqQ8mzb+pCrmlWCa25lxIw=@dpdk.org
X-Gm-Message-State: AOJu0YwVi4Y3cWR6BlNLEMtHfNnSatA7CKuxzzGpFnLkTzWo8GtAFzlA
 JaByrVR2aEiVkU3oDNQA4oF66E2q3N2Mzobobn3zADODxl2TP92UQ/pez9pdeX9OhO661MC8UFD
 6rfFvHLItkmDOZJ/baCJz600qse8GkMk=
X-Gm-Gg: ASbGncsZ7sYCHBV2VmGAj8jGmzXxHKyZuBhmzKRBc84GZDRSjHdjr1tj68rRUCPh7T5
 JA3FFYumUtJLM4wgQ90Vt/UW3Jo17ugy/mxpNFRB2tnntkgQJmfSjorI5kVFDdP/SPVqTekEd3B
 sR3U6zzJ8Jx6I/qcy10IcFmCC2SWoaUYPJpm4ESJvaZYsyQIj5rVhM0JlZIjU4F7qPYfmr4z9gt
 YTcQzMX3PO0tcLYm/+CBC2AOTjEWPD+mz7f+ei9g8km+8GJIuiuUUc932xxdW/JyIjgVhIjQUCn
 szX0
X-Google-Smtp-Source: AGHT+IGihW8fgwX3tkfcLBQdXYj2EO+EFWXWRbllnJqulYDkAbhQRHanP/wp58cOwuRO26Y/IaquqztEMDQebV7KU4M=
X-Received: by 2002:a05:6102:4428:b0:5dd:b2ed:a427 with SMTP id
 ada2fe7eead31-5ddc47d5d5emr4898479137.28.1762878700039; Tue, 11 Nov 2025
 08:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-2-marat.khalili@huawei.com>
 <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
 <e99e848a439e46c4bf9092c2c83de2a8@huawei.com>
In-Reply-To: <e99e848a439e46c4bf9092c2c83de2a8@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 11 Nov 2025 22:01:13 +0530
X-Gm-Features: AWmQ_bnzJpqNEZBHr32ncSaxhYcik6Lt9uq7UbA5TKVIWHPk4B6BSZR-g3191tY
Message-ID: <CALBAE1OW-zbiJKQOgTOeEyE6R6CtGAfF__okaEypWMkt7hBENA@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
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

On Tue, Nov 11, 2025 at 3:40=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
.com> wrote:
>
> > On Mon, Nov 10, 2025 at 9:01=E2=80=AFPM Marat Khalili <marat.khalili@hu=
awei.com> wrote:
> > >
> > > Left shifts of integer literals and bool values overwriting the sign =
bit
> > > were used multiple times in bpf_jit_arm64.c. E.g.:
> > >
> > >     insn =3D (!!is64) << 31;
> > >
> > > where is64 has type bool (double bang is a no-op here). The operand o=
f
> > > left shift was promoted to type int, which when 32-bit wide cannot
> > > represent the result. Similarly literal integers have int type by
> > > default.  Sanitizer produced the following diagnostic during runtime
> > > (for various lines):
> > >
> > >     lib/bpf/bpf_jit_arm64.c:241:18: runtime error: left shift of 1 by=
 31
> > >     places cannot be represented in type 'int'
> >
> > Wonder why none of the tests in app/test/test_bpf.c able to catch
> > this? The generated ARM opcode looks OK (otherwise tests wont pass).
> > Could you check what is missing in the app/test/test_bpf.c?
>
> That tests do trigger it.
>
> RTE>>bpf_autotest
> ../../src/lib/bpf/bpf_jit_arm64.c:320:18: runtime error: left shift of 1 =
by 31 places cannot be represented in type 'int'

This is when ASAN is enabled. Right? Is it really generating BAD
opcode(i.e emiter generating bad OPcode) and test fails?


>     #0 0x22bf59c in mov_imm ../../src/lib/bpf/bpf_jit_arm64.c:320
>     #1 0x22bfae0 in emit_mov_imm ../../src/lib/bpf/bpf_jit_arm64.c:378
>     #2 0x22c3bfc in emit ../../src/lib/bpf/bpf_jit_arm64.c:1321
>     #3 0x22c4314 in __rte_bpf_jit_arm64 ../../src/lib/bpf/bpf_jit_arm64.c=
:1414
>     #4 0x22775c0 in __rte_bpf_jit ../../src/lib/bpf/bpf.c:44
>     #5 0x228fbdc in rte_bpf_load ../../src/lib/bpf/bpf_load.c:115
>     #6 0x6312f8 in run_test ../../src/app/test/test_bpf.c:3225
>     #7 0x631848 in test_bpf ../../src/app/test/test_bpf.c:3269
> [...]
>
> RTE>>bpf_convert_autotest
> ../../src/lib/bpf/bpf_jit_arm64.c:241:18: runtime error: left shift of 1 =
by 31 places cannot be represented in type 'int'
>     #0 0x22bf04c in emit_add_sub_imm ../../src/lib/bpf/bpf_jit_arm64.c:24=
1
>     #1 0x22bf270 in emit_mov ../../src/lib/bpf/bpf_jit_arm64.c:267
>     #2 0x22bf2a4 in emit_mov_64 ../../src/lib/bpf/bpf_jit_arm64.c:273
>     #3 0x22c1a68 in emit_prologue_no_call ../../src/lib/bpf/bpf_jit_arm64=
.c:884
>     #4 0x22c1c9c in emit_prologue ../../src/lib/bpf/bpf_jit_arm64.c:904
>     #5 0x22c327c in emit ../../src/lib/bpf/bpf_jit_arm64.c:1136
>     #6 0x22c4314 in __rte_bpf_jit_arm64 ../../src/lib/bpf/bpf_jit_arm64.c=
:1414
>     #7 0x22775c0 in __rte_bpf_jit ../../src/lib/bpf/bpf.c:44
>     #8 0x228fbdc in rte_bpf_load ../../src/lib/bpf/bpf_load.c:115
>     #9 0x631e7c in test_bpf_match ../../src/app/test/test_bpf.c:3328
>     #10 0x632ce8 in test_bpf_filter_sanity ../../src/app/test/test_bpf.c:=
3376
>     #11 0x6331c4 in test_bpf_convert ../../src/app/test/test_bpf.c:3487
> [...]
