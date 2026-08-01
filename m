Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD878C55171
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 03:26:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAE8040288;
	Sat,  1 Aug 2026 05:26:38 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id C76C940262
 for <dev@dpdk.org>; Sat,  1 Aug 2026 05:26:37 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso197945166b.1
 for <dev@dpdk.org>; Fri, 31 Jul 2026 20:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785554797; cv=none;
 d=google.com; s=arc-20260327;
 b=UyxcISDCERzmLJGVx5i4A9T6tkYENbZg+LYf0piy71YjDw9Zcum0BU4YVO2wOWVXM+
 lKBfPZ3O1zXIHCHZ1vKctaiFl9GOmMhmtvSqoChXIxcvtmgg9fkpDSbq7WmW+sFD38iU
 HCj4FRvAMJH1Nu1tHtkMccefX2nqzjWqH3WubJmwIM59D+4zKNXFWm3qkZua4VaN6BYW
 cpJFH6TMPyNQrxKH/PVKL66xDuBz/PBAulo2O+9VulzHaeitUgrlWY6jy7eCC32Lj0b7
 3vDXCOixctr+12NEgMUupiet9ZiTaGov2DYTf2FajbmQ7ApJz6Ls8qpUTYXjhdyMHNnN
 yyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6af+gokCOofI2k8lmMjwcGE/ZYPEfw+JvrMw+zcD5T0=;
 fh=qqJY8FsJKB6y70ihjiWKJEDeS6BBhdpZZ3caxyZ8aEo=;
 b=LduZZwDkfpjvYBrEv3cKCeQEjRMTN5lD1o10kMvcDVVSXL7pKqSFXjLMTfEyJeZpNe
 +TkkzEqIdwlSyRJWfpJ3Ef7Lh3LKUqhN/hjDo7VoRJ+684HibZGPggiMvYjyr6yPceIK
 MKPSNrc4IgdI5I87f5hqxphLatW0+C+fYIBNAYQkCNKVjL0PklhXfdnAgl/rKmHKrZC7
 5SNje3K4ioZZcOWvfkTW48JshJivFZF7jis0eiNrKJj+vYcuUoo+VYQ8HvjkKP2MUN6C
 PErcMiG4YOaAtIcljSCqIy1czq4DaFuzlTWvZ6Pt1HHAUthRYvt/XVnIbXfdDa+DAJTL
 WoXQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785554797; x=1786159597; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6af+gokCOofI2k8lmMjwcGE/ZYPEfw+JvrMw+zcD5T0=;
 b=O3nEXJktYZ42ViqNZDcrxGN6DJdunCYm4HhvzeuFAfi9fCMR53/1+1Mo6/P7p1yYgA
 pVTTn5+IOdREvWozZmHXsZpayAeUqTo0iH24dWx8eL2brIW2eskIw8BiMbJ9E8yENB7K
 oDjYNPq7l566iQfyH7dPdfHj+Ht9UKdaokjbIgysffVYNDeHPR/fAFxHlIrpHJFysXTS
 Myktieuhnh0EoNhxSwpTiHmP+Q2sV0+L/oO0zm6+SJkd2+t8xNstPc5RjVkIMCATXi+R
 XQ2e7M06ZT/a2KUHUXNTCtpTz22OZas4UgDSGtnyxuzDc+y8SgmTAeACrcp3T5IgcJNO
 yjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785554797; x=1786159597;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6af+gokCOofI2k8lmMjwcGE/ZYPEfw+JvrMw+zcD5T0=;
 b=jDbRvGtBEYOwG2MF2feXe83yNpfGx6KUNBT/LTjpJsvGBmb3IPFSE0TrwrljTnGl38
 ylWfxV1PkeZE0GMbQRf0xPUQL33jJPATiqpdCmkCtsmO8hLWmCD86kPUTHhqiCIVzX/f
 xYT0cHBrwkEHpT2hzDeno05CmCCcek11LJgmT8Duv/TKDfjXTvAiUy6yPoWLfqgJICCB
 9CGu5cMKHC9jotiGnxgUibvbF4uIeWglDOBTxGHkrrVg5y9lTh9/JO4/2Quhx/EuR2jG
 WURot6aFdSfS1X6exGxJTD6ynZEUq3VrgV8FX2FUwxVvEZBMycTqOXbuc2EjN/rKbBaH
 yyqQ==
X-Gm-Message-State: AOJu0YzChWNeCpqcuALUg7OB2Iw+ZSlFoLLyPojCNCMRB+E1uf7P1LFc
 QQ/zmvKddRF/9XZ4wu2SWl1u7lhisAv1VUb4/M0Y8mUMof3Ex+f9eOdbR65vAKEA3OcIf2Jl5ZG
 GuNRvuZDDCN4kqO718vUhBbcaqwyybUlxbhSCZTKl
X-Gm-Gg: AR+sD11Wrv5adax/WpP87zM9YxpB5YNvwyGZ32M1MnK+B8QzjvzvnoleaCpfRP4knYE
 B5XzGmbKPxAimCyxrRh6zU55jI5nM/gZKONy0YG6r8uq8xcpzbpdmjga6jKlnPHZwzgqP6QpMu8
 8x0zed9odp5JmLoB63bG7e2F0VHvRRL/ZSh0Tw2Zs0QfcBD0K/IaSUpDIaHzQOdWFPCrVDZgPEP
 IvMxyqnLmNvYBR1A1HK3xUL9NJNiB9vjNv80R6ZRxrvVmkKlqPqgmfwFBtlY5XfAjMTB2g3cPqd
 Op4QlN2ZjB+h2DOFk/+uR62NsK1OUYpKqR1As6u3FM1UhNPTalzMif4ioTPMaaV3/asP1704WEt
 1ArqBEntqBVTwQ4qqt2TEWSfC
X-Received: by 2002:a17:906:4556:b0:c12:713b:e199 with SMTP id
 a640c23a62f3a-c1fe7f455bemr77725266b.25.1785554796539; Fri, 31 Jul 2026
 20:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260721121129.2911774-1-blasko@google.com>
 <20260721121129.2911774-2-blasko@google.com>
 <20260726100141.6dd2fa86@phoenix.local>
In-Reply-To: <20260726100141.6dd2fa86@phoenix.local>
From: Mark Blasko <blasko@google.com>
Date: Fri, 31 Jul 2026 20:26:25 -0700
X-Gm-Features: AUfX_mwsbvuCklSLvo_uWUCrHbwIWJ6hG4OT-mJv1IrsMptVLfn5d18GQ_C9ToM
Message-ID: <CANULgn+54b0z472uvU3FjtLK7O7KxNc4HuN4SKLuRuANqyPQZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] net/af_xdp: add af_xdp rx metadata and dynamic
 timestamping support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, joshwash@google.com, jtranoleary@google.com
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

On Sun, Jul 26, 2026 at 10:01=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 21 Jul 2026 12:11:27 +0000
> Mark Blasko <blasko@google.com> wrote:
>
>
> > +xdp_meta_rx_ts_offset
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The ``xdp_meta_rx_ts_offset`` argument specifies the byte offset of th=
e 64-bit RX
> > +timestamp within the XDP metadata headroom area (prepended before pack=
et data).
> > +
> > +.. code-block:: console
> > +
> > +    --vdev net_af_xdp,iface=3Dens786f1,xdp_meta_rx_ts_offset=3D8
> > +
> > +xdp_meta_valid_hint_offset
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The ``xdp_meta_valid_hint_offset`` argument specifies the byte offset =
of the validity
> > +flag byte within the XDP metadata headroom area.
> > +
> > +.. code-block:: console
> > +
> > +    --vdev net_af_xdp,iface=3Dens786f1,xdp_meta_rx_ts_offset=3D8,xdp_m=
eta_valid_hint_offset=3D4
> > +
> > +xdp_meta_rx_ts_valid_mask
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The ``xdp_meta_rx_ts_valid_mask`` argument specifies the bitmask (in h=
ex or decimal) used
> > +to verify timestamp validity at ``xdp_meta_valid_hint_offset``.
> > +
> > +.. code-block:: console
> > +
> > +    --vdev net_af_xdp,iface=3Dens786f1,xdp_meta_rx_ts_offset=3D8,xdp_m=
eta_valid_hint_offset=3D4,xdp_meta_rx_ts_valid_mask=3D0x1
> > +
>
> Awkward to have so many new metadata devargs, but I guess if XDP has no m=
etadata standard there
> is no better way. Maybe combine into one devarg if all are required?

Not all parameters are required: `xdp_meta_rx_ts_offset` is the only
devarg needed for basic Rx
timestamping when timestamps are always valid. `xdp_meta_valid_hint_offset`=
 and
`xdp_meta_rx_ts_valid_mask` are optional parameters used only when the
BPF/driver layout
provides a per-packet validity hint.

Sent v4 with the other review comments addressed.
