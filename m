Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CECD46BFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC1C4402B6;
	Wed, 28 Jan 2026 20:57:28 +0100 (CET)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52]) by mails.dpdk.org (Postfix) with ESMTP id 66F1D4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:57:28 +0100 (CET)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-5ecddf73062so126277137.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:57:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769630248; cv=none;
 d=google.com; s=arc-20240605;
 b=h8ptih4K7Va3eNh3OW5ua45bpEkWIG2Y5E7vlfZCmCJ7wexvAWSC8JzyF4roVTbw0l
 SgolPu7aVqcfJDYDBqAjSs9x/x/R71jVlmrMTRDrhRvjW/JvLxZlES0q3/4fnfbrUqaj
 hlPlFmZGZigAeVgKafkqaDHZmuKQ/ZwKnFOaHEnOJQ+TF4d8hkuYZUPJM4lZ1sXLMgLT
 4Qoz/MIFw9Q3iL4KuPIsGDBKuxEFKFGY8+O14Ci+93PNmXGl1kk+TViKY84H/JxvfZJ8
 EEleXQ9c83WwKhbDEYpH70K3Zbxc6jgn7h+zZgylVq8I/LseyGawhWhDj8nIbc4itq7Z
 GB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iJagRYA4B3rjFf2vyRn6+AHGO1uQdtI9M0Sj+uayj5A=;
 fh=+L1L+ZHbKjrb2f5CsW4olkadjYbHjR06LFcqyhSoUu4=;
 b=DcskXDX58kcrM1yLKDFuLNImEuimtZOBq5yUoTmg10EHsliEpDNbqdawFshL8VuVlo
 QRbGvWxyIEXO2TDp2Sg+bZuTwkx0WQwZWVoZiXBlU9HX237S2fRzeTFcupRrEqLZsdYB
 PBLduJwdjzzSJFADT5vQgkeFaUNpnLq7WwLnVm+YihQA10NpTwEFSWSbrn+F8jnpb8YE
 dHNCGglCuujxRWkkMY3K7MD3EWTXHb/Y8iZhayMXgf/ubbgWeIbjH8yAk6N9GV+nfb1g
 e4AF5Il8iZyXzRyIs4RXJXBQv59VVwyI82aAkJ4X/JuPAZhYKtHu3UPB1K638z1lmPsg
 pa7A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769630248; x=1770235048; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJagRYA4B3rjFf2vyRn6+AHGO1uQdtI9M0Sj+uayj5A=;
 b=H6lSfxxMCUiNEEzjNtQw6tqNGBfZvWyuB5FH1oothb/BlBLgCKarTRDCxwZ7AQiPOC
 iKtJUiDs6c0qMbzdYgw9MTe1xf6VakpJosgYeTPP/E2TC9vsL9wh4N+9bbX294nSJadr
 WbC1eBk1DsP7WXpVqE4rzbhTG//pp53idNT0RytkfVCwTq3CPOTi3RWNJugmNFrkePzu
 RPCqWd7FTIxPJX7YF68TZIBM+sbv/xa1EGM2OfK+jobZu6PqwWwmdur/MD6jLBMw7nX4
 7+7NpBT4nb+4MendzWxrjoqMbug/begfBGbqNkyjkkW/2E9feOC8LCcnC/OynFSsDopI
 indg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769630248; x=1770235048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iJagRYA4B3rjFf2vyRn6+AHGO1uQdtI9M0Sj+uayj5A=;
 b=rSajVmxaRfsypkCZ3EmjtlXMt5xY5GTl3urnBbwX1b1Xd4Q1N73n2zN4nSTQD6ehC+
 /A8jlBIFugHHMrD/OToUtahFgDghaJTG4l9jiI5aRd4Hx0PVE2+7hOXx32yTuIvBQXq5
 XkDLd1/UKhA41Kczj704PEepuZ90VAkmIXDK97yk6Uxt/4RMZrMUz+pBgNxjqBJChis1
 hWhF+/x/AxNbqN3j3ytLvnSiist/LoJl8gD2Iig6gthrb0b+iv2TLZdGd+l/G/TLf2Z7
 vinJbhp0y6BcD6GGVLXqKjhLXRrdnhTLm9eJeM7dIIQ3pUApl7TmgrdHilXU6YAhW5PM
 8MPQ==
X-Gm-Message-State: AOJu0YwWqBTZTSv4X/NAvtoKt4+I5kzY8O56SA5DmRBzFLquIyCvPZdF
 lOinGykPFgITy2XKxZLskUX2DkVHPURlccL2IT043ba9OdmDf9E/37fMrdIJhAMaTl/yUdXNtnH
 tPWe6N0xJOuud8tgqVeNUSl++dppI6eF7t7EU
X-Gm-Gg: AZuq6aL15yzqQQBLRRLUtIZyxGEH69P6NOAvkmqFG0zWrwqtiWLSjJhi0CyeTg9hjE/
 6vrnby1dTKA61Q4OKo2AFgjJxxXJqrzxk3m5uggihqeJYHlzXxRyOuJP+9nZDdAad61XultVV4R
 BqoDUXaUlrIonUOBSZ3LJC7OHtMSlRaH52H/oPYcc1CpKodsEmdsZvF7CWuc+flQZhs+lRArS9J
 nq3A7reuLB+3ot0gJS9lFBUYVN4aZGxcDABnWbxF6X7H/6kyZbXrZMJ+Q1eZ63CSzOh9w/gek6d
 3Vv/xApTc6fKeCVYUkNYSCw=
X-Received: by 2002:a05:6102:3ec6:b0:5f5:3244:20c with SMTP id
 ada2fe7eead31-5f8cdae32abmr257117137.4.1769630247633; Wed, 28 Jan 2026
 11:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-2-stephen@networkplumber.org>
In-Reply-To: <20260128173138.151837-2-stephen@networkplumber.org>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 28 Jan 2026 11:57:16 -0800
X-Gm-Features: AZwV_Qi9NHVfgRiQB3huDTswaRaPRoSwKHTiwpxzepXH-IerbMH8o2ENjFu8DB8
Message-ID: <CAFn2buD=1CwnP92LGuj7fGzi_Cujnp8eTV96ZzTNKBjsA6kzOA@mail.gmail.com>
Subject: Re: [RFC 1/4] net/af_packet: remove volatile from statistics
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, "John W. Linville" <linville@tuxdriver.com>
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

Can you clarify why removal of volatile is safe (visibility, ordering)
when the producer thread and consumer thread can be different?

On Wed, Jan 28, 2026 at 9:39=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Statistics are only updated from a single thread at a time and
> the compiler should not have to worry about optimizing them.
> The statistics returned are 64 bit so use uint64_t instead
> of arch specific unsigned long.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/af_packet/rte_eth_af_packet.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_p=
acket/rte_eth_af_packet.c
> index ef11b8fb6b..158393dd70 100644
> --- a/drivers/net/af_packet/rte_eth_af_packet.c
> +++ b/drivers/net/af_packet/rte_eth_af_packet.c
> @@ -57,10 +57,10 @@ struct __rte_cache_aligned pkt_rx_queue {
>         uint8_t vlan_strip;
>         uint8_t timestamp_offloading;
>
> -       volatile unsigned long rx_pkts;
> -       volatile unsigned long rx_bytes;
> -       volatile unsigned long rx_nombuf;
> -       volatile unsigned long rx_dropped_pkts;
> +       uint64_t rx_pkts;
> +       uint64_t rx_bytes;
> +       uint64_t rx_nombuf;
> +       uint64_t rx_dropped_pkts;
>  };
>
>  struct __rte_cache_aligned pkt_tx_queue {
> @@ -72,9 +72,9 @@ struct __rte_cache_aligned pkt_tx_queue {
>         unsigned int framecount;
>         unsigned int framenum;
>
> -       volatile unsigned long tx_pkts;
> -       volatile unsigned long err_pkts;
> -       volatile unsigned long tx_bytes;
> +       uint64_t tx_pkts;
> +       uint64_t tx_bytes;
> +       uint64_t err_pkts;
>  };
>
>  struct pmd_internals {
> --
> 2.51.0
>
