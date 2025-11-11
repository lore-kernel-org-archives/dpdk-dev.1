Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3455BCCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 16:30:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAC9C402B0;
	Tue, 11 Nov 2025 17:30:07 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id E262340280
 for <dev@dpdk.org>; Tue, 11 Nov 2025 17:30:06 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4edaf8773c4so35371841cf.1
 for <dev@dpdk.org>; Tue, 11 Nov 2025 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762878606; x=1763483406; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ln++Bb9eE3hkk0hd3G0cunK1dSTConYTa48gWLNhiEE=;
 b=a7Pp2EVPyXl/phyVQ8A09I9GXuKwBz2onVvH088EeERtRxrhdOZz+oWEDKfBthd4xZ
 lSCFoa0+1sz0wW9CVv6+BhZrqW82xcQxi3GmTyjMNdVP6gjafnFFYekflh5Q1NGPbkT8
 K3a5d/1AmyTpYLgS/zI4GRN+bEezUxcsPl3vaojMZDazipg+I6rx+sMjQebUrYuUO2oc
 2uGJ7CLY1uUxKZnYmf4mo0bBLWpL0ltk2AXyLNxFnxZN1CT08Zfrs3FEtj362E7CY6Ou
 6R8C+JD4SJmThI8Sf4rrKVZ6lJVtq7sR1AD10K2AeqCuDSxUbjgl6FAfWpi8alW5GdU7
 HrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762878606; x=1763483406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ln++Bb9eE3hkk0hd3G0cunK1dSTConYTa48gWLNhiEE=;
 b=e60/ietWj7lJLvMqGxf0lOQQ2MPbcseJ35B7JUCQloV7U2wy+mvwiFh07etu/jPBFZ
 0MLzhWb+WES4XZkxAOsZFuCorKpSMW+yUwO+LZy+PkfrOSiokbTkDMJsh8o2L0+g66Bp
 szlG2C2ogzBUaJHOD93Y2dkhTPZ2254f6liuQFB59DjhX2C1/W8qrj6IoxEnBnnjjBU4
 6zgRU4dMwlKluitGWpYtQFaHoy/cEqPoBQyoucSPr62GnRGvJ/V/5yWQ1CiEqRemSIl9
 I0//z++/G4qtRiXJp+cL+TZ1d8WdaBXBthQzbMdB9+fbeh89XrM+EgEA0xt96hvdMES4
 uung==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3giL3xZowF+zAuW22EcnIn/QVehtc+BWR0fWh3qcUJdKAGtR5AhHWLhUJKOGjxEwbQRo=@dpdk.org
X-Gm-Message-State: AOJu0YzLUgIDWjrrs6wPBQ0USJUw+m22EyLgFBDnpmexHzpi0QbSJ1qm
 MzPxQDsS8lheY6PL8VLuze0NQo6t7ngE9+H18yhHG6t6TD/mrdfxoYmdGhLuCAPqpMxaBoEsztw
 9rvNVeSL8tMniVPgMfqCIBvClqp3yuj0=
X-Gm-Gg: ASbGncuxw3QZQV+RD3l4oTegv0Qi2imgKiHlh6BJURSmeIlNU+lm7cb/CWPGJQyagyz
 sbOA4cLTkdx7Hf9jTZx5LUsejDCoUIAAyw4/2sK0oEIO1CYW9KoKu8lN3kEpthaz6IwFWVWT1TM
 9h6LJsPMp8uC0PhHRnC8I3TeZ11OfZomDzYI4Vu+nOiHx3//D9I7TtU/l2TxMpmsU3xXHGZMMaT
 33rxTvJhA23m6027Ah3j6So0yO3hdlAtEwhyDvmLi0xWRIj16HAJUOsFd0=
X-Google-Smtp-Source: AGHT+IH+mE91KZmjROwDRwecHbUd6SGz7SVp6x/Eedk2Y1SZAzC/DHSa0AkcNYReThdc4u+iWMWfzNk3h9mAz4ycjmI=
X-Received: by 2002:a05:622a:10f:b0:4ec:f969:cabc with SMTP id
 d75a77b69052e-4eda4e7baacmr167763711cf.10.1762878606074; Tue, 11 Nov 2025
 08:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-2-marat.khalili@huawei.com>
 <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
 <e99e848a439e46c4bf9092c2c83de2a8@huawei.com>
In-Reply-To: <e99e848a439e46c4bf9092c2c83de2a8@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 11 Nov 2025 21:59:39 +0530
X-Gm-Features: AWmQ_bm1rsOfr5sof9_-p1SjWtzTE-J-SeHD_2ootnetdPdFli2yE9VHQ6eg9yk
Message-ID: <CALBAE1OcHv5O7_22ZBJCVauzX-D_WZ_gSFF+hxtu61WveAMAMA@mail.gmail.com>
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
