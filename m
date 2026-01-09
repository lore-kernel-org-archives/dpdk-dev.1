Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45403D26D69
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 15:27:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B5C740B90;
	Fri,  9 Jan 2026 16:27:25 +0100 (CET)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by mails.dpdk.org (Postfix) with ESMTP id 10E0040B8F
 for <dev@dpdk.org>; Fri,  9 Jan 2026 16:27:24 +0100 (CET)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5636bf70eb6so188866e0c.3
 for <dev@dpdk.org>; Fri, 09 Jan 2026 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767972443; x=1768577243; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PR0ueh246A+vAEelzE9hTbxUFMJ3rjIGqMp4lO6YfQ4=;
 b=YlcaYAgAtGFBDmAewhKmF1e6U/1Ba9yZGzV9L3gh7X1VT3LzbjdPBeHDhofKhnUVz5
 N14oHiRVLT/8JrfI8dgaQE1yw0hkVVEe3sYMz2tMNjF7YtB1nWgWzBIQjWNQh8T9+zN+
 5ldJBT7JHPbPoK7zp0twmW6Zz/BgZZhgMBjM8VFGYg1j8npKU9VVbZlUdjY0k8+tMgF7
 yazd/g9dFz6L8Nfzs3so06m7AXpOKOrBxnDAM91q0VMxJLtw/gOxB/+xYP+GOXE79yTx
 VAN6IElWVgmzXn9RHgtVm5hOXA4R+7yYGlqINQ+0wL9FrF6Nno3FiCXAkTL5DAvb6A3v
 rnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767972443; x=1768577243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PR0ueh246A+vAEelzE9hTbxUFMJ3rjIGqMp4lO6YfQ4=;
 b=t383byrkTzucwNR8y97n0rUbpWl+3NVuIob9amnZW9EFZB4cF2/wkkhEEPU+mMpyBH
 5l206PUVau8I5qnKBt4dvxbPv//XdRQ3+c9R2SfbeLXPk489PcdTdhRLo8wGEuAJOFL6
 0ABaoApRQmGrFiQp3OLr/LvMXuZC73PTS+st7RCQCDPo0HDfk0Z1SQIqyuXMRkmXeqUt
 9GRsrS6wfF3RtEqG8gPC4WlifydWiLIF0JaKQ8zc/zwzB5wctPIUupL7dkBze1LLOfsO
 WkIbtnNWdkgh4Ec/gkZfXTVGUFqBIFlR2Y/2vNvlkvtgbeYI2vXTtcJ0r6jUlBCTCOdb
 FpCQ==
X-Gm-Message-State: AOJu0YxvwQ3O4ANhNLkU8EB4vDSEJgXGtE7HR1BMYrwJbwFb1yMIskS2
 QTokSoyZ0tB6HAMpCgKbOzbSjEsbxvhigKDmgPiQ8+Fi5zMgljywWkqZyb4Vaj/5Z0KGpLTuvyl
 tqGs+Cr4ViKumf1Lg+RIgKmyH4S9D2vM=
X-Gm-Gg: AY/fxX5qGln7cbBRyGlMlGQMRQpKlZGle2kB4VCJNRsnxO4A6Eqr9mkbUBcFGGyIl2g
 XApUgHbU8SpHLxnfQvrTwPCUc64bzwdR3IAWHDJ3CHr5wipiI8KGMjWE/eitpUuAECnbiK8KpoQ
 rKzd4T8qPz27YLsXGMwBO/jisebWYBS8RXF32yKgRV0KzIx3r8yfCqQD1VrFl0XagoUBExPBvT4
 U1iDt5WhFS+4/A/rai4hNjm/UMADTXVHfCIjKOS3CmVr1uC/clDR80UETPu0qCVhFzw9f/mtw3I
 1EEU6F4vHtM4vVB4d1f6DkUdK/U=
X-Google-Smtp-Source: AGHT+IG7+iftlPhuk5fU8K4ScOzWtIhE1zOt5QkiCkt5xehcjPw8z+xzAacx2MQ6kGVAQg8j2ZEs3FWpjUaGIfsaSdw=
X-Received: by 2002:a05:6102:4a84:b0:5db:2b4d:f1ee with SMTP id
 ada2fe7eead31-5ecb687a389mr3563322137.17.1767972438601; Fri, 09 Jan 2026
 07:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20260108230509.6541-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65638@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65638@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 9 Jan 2026 10:27:07 -0500
X-Gm-Features: AZwV_Qg0YVfftarSsJZJTD8oe7YfhVNE9QpAOBr-IKDglOqiy7bo5C9U9bnrcQA
Message-ID: <CAFn2buDULHpj-5m1TXEcp0xUfMpTA9dKqEuEC98UhDp4qW21og@mail.gmail.com>
Subject: Re: [PATCH v11] net: optimize raw checksum computation
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
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

On Fri, Jan 9, 2026 at 4:26=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesys=
tems.com> wrote:
>
> > Changes in v8:
> > - __rte_raw_cksum: use native pointer arithmetic instead of RTE_PTR_ADD
> >   to avoid incorrect results with -O3 for UDP checksums. Also improves
> >   performance due to less assembly generated with Clang.
>
> Personally, I also have observed GCC's optimizer behave as if it loses so=
me contextual information when using RTE_PTR_ADD, and thus emitting less op=
timal code.
> I didn't look further into it, and thus have no data or examples to back =
up the claim. Which is why I haven't started a discussion about discouragin=
g the use of RTE_PTR_ADD.
> In other words: I support this change.

Sounds good! I observed ~600 (dpdk ptr macros) vs ~500 (native c ptr
operations) TSC cycles/block in cksum_perf_autotest.

>
> >       /* if length is odd, keeping it byte order independent */
> > -     if (unlikely(len % 2)) {
> > +     if (len & 1) {
> >               uint16_t left =3D 0;
> > -
> >               memcpy(&left, end, 1);
> >               sum +=3D left;
> >       }
>
> Changing "len % 2" to "len & 1" made sense for consistency in previous ve=
rsions handling 32/16/8/4/2-byte chunks before this 1-byte chunk; now it ma=
kes no difference, so consider not changing this part at all.
> Under all circumstances, don't remove the unlikely() for handling odd len=
gth in __rte_raw_cksum(). The vast majority of packets (and partial packets=
, e.g. headers) being checksummed are even length.
>

Sounds good. I will restore the original.

The use case that motivated these changes was software interfaces (veth)
with encapsulation requiring software checksum on inner IPv4 payloads,
where lengths may be odd/even. However, I agree that header checksums
with even lengths are the more common case and unlikely() is appropriate.
