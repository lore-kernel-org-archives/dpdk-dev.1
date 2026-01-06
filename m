Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7564CF6C0F
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 08:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A20240267;
	Wed,  7 Jan 2026 09:56:30 +0100 (CET)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50]) by mails.dpdk.org (Postfix) with ESMTP id 1A689400D7
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:16:17 +0100 (CET)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-5dde4444e0cso451126137.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767723376; x=1768328176; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BH+ZQ7P2lXgyzpanRLtfWzHA4aM0nnpHqh0Xc6tApZg=;
 b=EEvurpiAD9iY27V8ErjVbr3nmQPDrPTVV2SLQV/1vUmEmE0qRr7s+MhMPSMOYNfQvJ
 Zx7gMC8Ga9JQUg14qEpOEEX7jbW2QqeANaDRB+gvvE/0zm2oY6O60olCEVaC5kyZmZlQ
 j+bURYeJ88Q51cdrIekjWeR53MTYymolCQP25mbFKfJsI4jP6pCds+c5iadG3hzjoFz5
 KNqI27je+shj8omzEDz7QR7UAicl30P7C/cx2qoI274B1uWQjTvvapMUO6jj2ymx8Fhx
 A0RTNVytw/mVugy2bOUWHvBHPl/piUZKHipnBHnG93hS85z+Ok86stFtzTD9oaL/662h
 LYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767723376; x=1768328176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BH+ZQ7P2lXgyzpanRLtfWzHA4aM0nnpHqh0Xc6tApZg=;
 b=F5u98wJaDvcZnaZSZMY5i6BTNOYeoLgs9CEE+/nRAIyTppn/OqmiZBgdCcpFN0lltx
 k1/O+C190SiLyitLr8G1zSe1jMPC0yHT2hO8VDJgHFo0JXyTIL+gjUUAjtkh+FGiWDKL
 bzLii/tgRdmspGJQ4hdJXggJLb8gQLLgnnJyiIRg1enBLeoSk6hRQWlvmsicRzxFDgP9
 Xry/H5CluYvx+X4nHGgHde4gN9+7s6pvbO9pGcwfPc9qjpa4Jtrar4Tr4yzKeISuNpju
 6CdKAwaeU19DFeDlA3SmUP1Ukz2NHV9HqLJ/3qJYCBYt4PJOUvWBRNpRTcN5S9n/PbJR
 847Q==
X-Gm-Message-State: AOJu0YyVSywNVOrrPMxEdb+mK3kgpklUVt6W8laKhgGUc02FwLPnIyty
 XeulaRFRvg6UwlEGtN9jzq1YZUwPw4VMF84kUUpkRBF3Ey+NAfYHLMvUpVyIiBJtB6Hnlg5/Sue
 2eCTcTRttTBtJ0ywGWaBUan6aAQUwKGxYfbVY
X-Gm-Gg: AY/fxX6C9j2wISccpMCppXtVwdSr7I6r5MRDZNkM1plg3UGS9c8HYxwNta1sJQftvNz
 ImKH5Sg4gIjPlZc6d/iAqbbfOWgiKgq4r6/emS6sD350Yv1oyMxSQWiuxc+TRo97BjShprxF5Zn
 DReY4hKlnM5lRuoVcxkl58uQJUjCRS6JHj60wcwo9J6xNMaM2aNwNf+Uhn2tWwFoJDIPicWGL56
 tQxJ51dpOXmiY4Ck+4R3WerNCiqyVLScD/PkBIAKiJxzHzQmLfiaVNAn5oNcCepzVMkGwfJGIYc
 yNw/S3d/saLq1B3ulJdh02k/UkS6R5VfhR5M3g==
X-Google-Smtp-Source: AGHT+IHGidt0BPLf9ctL6NMp1plYCF8uQ5oEHxsQ0eVw8GAiVJt+6o5ZmCTkdBiXrpD0CY0nMCmjlA7X2kDwnZBQ7E8=
X-Received: by 2002:a05:6102:3f03:b0:5dd:c5d8:13e5 with SMTP id
 ada2fe7eead31-5ec745a20dcmr1028579137.44.1767723376203; Tue, 06 Jan 2026
 10:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20260105232754.34404-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6562B@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6562B@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 6 Jan 2026 13:16:05 -0500
X-Gm-Features: AQt7F2qaFMwlzeUW2xpQ6Q-PRsxfW3_bWe-t125Xa6pDLjRrINuicSSVZ3GnhQ0
Message-ID: <CAFn2buAhuP0zUsDNxrGbc=j69caCX0G0hg46UK4ZBuVcsNPUAQ@mail.gmail.com>
Subject: Re: [PATCH] net: optimize raw checksum computation
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 07 Jan 2026 09:56:29 +0100
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

On Tue, Jan 6, 2026 at 5:59=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesys=
tems.com> wrote:
>
> > From: Scott Mitchell <scott.k.mitch1@gmail.com>
> >
> > Optimize __rte_raw_cksum() by processing data in larger unrolled loops
> > instead of iterating word-by-word. The new implementation processes
> > 64-byte blocks (32 x uint16_t) in the hot path, followed by smaller
> > 32/16/8/4/2-byte chunks.
>
> Good idea processing in 64-byte blocks!
>
> I wonder if there would be further gain by 64-byte aligning the 64-byte c=
hunks, so the compiler can use vector instructions for summing the 32 2-byt=
e words of each 64-byte chunk.
> This would require a 3-step algorithm:
> 1. Process the first 0..63 bytes preceding the first 64-byte aligned addr=
ess. (These bytes are unaligned; nothing new here.)
> 2. Process 64-byte chunks, if any. These are now 64-byte aligned, and you=
 should ensure that the compiler knows it.
> 3. Process the last 32/16/8/4/2/1-byte chunks. These are now aligned, whi=
ch eliminates the need for unaligned_uint16_t in this step. Specifically, t=
he 32-byte chunk will be 64-byte aligned, allowing the compiler to use vect=
or instructions. The 16-byte chunk will be 32-byte aligned. Etc.
>
> <random idea>
> Step 1 may be performed in reverse order of step 3, i.e. process in chunk=
s of 1/2/4/8/16/32 bytes (using the lowest bits of the address as condition=
) - which will cause the alignment to increase accordingly.
> </random idea>
>
> <feature creep>
> Checking the alignment at runtime has a non-zero cost, so a an alternativ=
e (simpler) code path might be beneficial for small lengths (when the align=
ment is unknown at runtime).
> </feature creep>
>

Good idea! I implemented your suggestion but I didn't observe a
measurable difference in cksum_perf_autotest. I suggest we proceed
with the approach in this patch as an incremental step and I can post
a followup with your suggestion above to review/discuss. Note the
checksum computation requires processing in 16 bit blocks for
correctness which requires special case handling for odd
length/buffer-address alignment so complexity/code is higher.

> >
> > Uses uint64_t accumulator to reduce carry propagation overhead
>
> You return (uint32_t)sum64 at the end, so why replace the existing 32-bit=
 "sum" with a 64-bit "sum64" accumulator?

Good catch. It gives more headroom to avoid overflow but not necessary
and I will revert.

>
> > and
> > leverages unaligned_uint16_t for safe unaligned access on all
> > platforms.
> >
> > Performance results from cksum_perf_autotest (TSC cycles/byte):
> >   Block size    Before    After    Improvement
> >          100  0.40-0.64  0.13-0.14    ~3-4x
> >         1500  0.49-0.51  0.10-0.11    ~4-5x
> >         9000  0.48-0.51  0.11-0.12    ~4x
> >
> > Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
>
