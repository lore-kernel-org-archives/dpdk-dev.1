Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A569D232DC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 04:58:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 591B2402A7;
	Fri,  9 Jan 2026 05:58:00 +0100 (CET)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53]) by mails.dpdk.org (Postfix) with ESMTP id BFE9F400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 05:57:58 +0100 (CET)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-93f56a97064so1179074241.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 20:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767934678; x=1768539478; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkCLBSZnnv1VTIiEImgf1f4UjjWxycgoACpTRsoI5DQ=;
 b=Z3c6DWN6hO+PDyfIrXA34/H7i5BzCjCG9NkkzSF1Wy7mv0C0W8EdR7cpHE/G6NUotr
 OOKwhuCQ9lIboDamI1rMh1dzH0LQskVfEx8hIOao3om1k3KOf4e9zBMZIs+JL95OyrjY
 22E+hYfYMGPSeYea/Ij0MtLRHI5dpECKoYFu187mojL/MJOoCxTDAyAWdfhP0kh5sdEk
 S0s7YqZDuokNo0lOHCGBY3jp3gOjYeZ0NjdmWEy1aj4euQrBRMbgZth5aDXxJI8hFCp8
 92mqt/Iv5Qc9Alypx44fTKBld3s5aUX8VBVE4TDRsuB17sdHj0ymOamxubiM5AWOF/0X
 oBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767934678; x=1768539478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KkCLBSZnnv1VTIiEImgf1f4UjjWxycgoACpTRsoI5DQ=;
 b=spC8NZL4zAmjLX3V1fKxk7n8VrwPCk3gcafYk4OBbxLWQbkL2CdVwYVB8cNVde3LJ7
 9wRU7pIONrTzsgQlT3i+5vvvWX2b6EBLwuUmiM/Rc1wI+dsA4ePF1XsZVOXKriGoGsVo
 PeCXKONLAXmjk+WM7QfrGWH9XsMaT7OcT4/5aO5Vs+LEon1WMP+Lg5ERPUTznObCN3ZG
 az1YYIGeI0sT1EAD5jlcb2JUup/HCYfrAXXvpccZOrPn4F1ItnCVKuHuuJf7SD9fVCfx
 tLi1fsUH9SQE+UKa0L7LzQDNlXNK1ndvyXL53m3p6wHO3lAP7dw6CbDvt34O88gr3Lgr
 hFmA==
X-Gm-Message-State: AOJu0YxmXUcudy6IlJ7teVnNvV2SIjIlyeWb+iNEfT8cfW5+eMe7UT2C
 30ZHgX4ZN8LOhiBLf79IvnEekVuAITbgCF0Q7RV95oUQFgrDKuEJ2UZTdnvRLW3rQyVf0H/kxpw
 vjx313XkvAoEFdSBuor1AQFCvTUN4NcTY2Vzd
X-Gm-Gg: AY/fxX5OmeYaG5yHfn9PkPdXwYGTb7TzKxwaOxEUn/+PE1ov7+ZXlJKCmmDDC3+UGfJ
 qhKW+ZNo6Kd56qJDRPJffZ2LuhBKTDjma66PtHgHdjinqDKqPzF+CuePTnK3oe2WCSPIG0otajF
 cxgPtYlO5cf3u162yntzDC1qBzRxk65MNZNq9J6nU3asj1N3zaK9IAh2PTrgxwPftD+u+sT0Xxu
 08wPPAzTlFSTiKR3fp1xR0DWAIgEL5BStoUTgCV+ciT9a8nSQNBt4rfrKTt3bMTaBV2KWo7+CoK
 lC7hE7mw6zFu4T4vJeuM38PtFjI=
X-Google-Smtp-Source: AGHT+IE0Pf4MoQXdw4caISIBqhVO6Qc4wNW7ydC/ZRalka/SFSa1lwd3ZHIegi0kiG1X5NUz+RnjhqYHlUmKdW59VL0=
X-Received: by 2002:a05:6102:560b:b0:5db:3b75:a2aa with SMTP id
 ada2fe7eead31-5ecb688e212mr3704285137.18.1767934677938; Thu, 08 Jan 2026
 20:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20260108061338.27217-1-scott.k.mitch1@gmail.com>
 <20260108081229.60b095b9@phoenix.local>
 <CAFn2buDp4ffHuSXmTrW8mfNHxm-t3FL=TVgMKFAc2gU7fyXPGg@mail.gmail.com>
 <20260108160058.685cf7a7@phoenix.local>
In-Reply-To: <20260108160058.685cf7a7@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 8 Jan 2026 23:57:46 -0500
X-Gm-Features: AZwV_QhaRW2YTtQWQZZ6kkGYbwPcRs5qeSdyF3B_MVsy3eOkUqhh1a1F0xHDAFU
Message-ID: <CAFn2buCqxz=43Xy6QycxS0KaY9A49bcLrsBOGFoP6MzHE0fnNg@mail.gmail.com>
Subject: Re: [PATCH v5] net: optimize raw checksum computation
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, mb@smartsharesystems.com
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

On Thu, Jan 8, 2026 at 7:01=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 8 Jan 2026 16:19:37 -0500
> Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
>
> > On Thu, Jan 8, 2026 at 11:12=E2=80=AFAM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On Thu,  8 Jan 2026 01:13:38 -0500
> > > scott.k.mitch1@gmail.com wrote:
> > >
> > > > +#ifdef RTE_CC_GCC
> > > > +     /* Suppress GCC -Wmaybe-uninitialized false positive. No asse=
mbly/runtime impacts. */
> > > > +     asm volatile("" : "+m" (psd_hdr));
> > > > +#endif
> > > >
> > >
> > > Maybe rte_compiler_barrier() will do same thing?
> >
> > Agreed it feels like a compiler bug but looking for advice if I'm
> > missing something :)
> >
> > My initial concern with rte_compiler_barrier is its a general barrier
> > which may have broader impacts on
> > optimizations and compiled code. Will that be an issue in this case? I
> > wasn't sure and the approach
> > in the patch is targeted at a specific variable and assembly from
> > clang/gcc was the same. I will
> > introduce a macro to make it cleaner and I can replace it with
> > rte_compiler_barrier if preferred.
>
> Maybe try with -fanalyzer and it might tell you more.
> I suspect some of the aliasing setting are causing issues.
> Some drivers are turning on no-strict-aliasing

I have more evidence this is a GCC optimizer bug.
The RTE_SUPPRESS_UNINITIALIZED_WARNING approach serves
as a workaround to avoid the bug. I created a more minimal reproducer:
https://gist.github.com/Scottmitch/bf23748b4588e68c9bdb8d124f92f1bd

Your suspicion was correct, -fno-strict-aliasing avoids the bug but I don't
think it is desirable to enable this broadly for DPDK when we have a
more targeted workaround.

I will reach out to RH to confirm but in the interim I suggest we keep
RTE_SUPPRESS_UNINITIALIZED_WARNING (or similar alternative).
