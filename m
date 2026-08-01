Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5DAC55173
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 15:49:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DAAB402BB;
	Sat,  1 Aug 2026 17:49:27 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3CCD140299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 17:49:25 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9ef3e1337fso1445101a12.2
 for <dev@dpdk.org>; Sat, 01 Aug 2026 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785599364;
 x=1786204164; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FuFtTDinus87NyEoGbynQ4iEbCSAbrvkEEz0kBJeCWI=;
 b=GzFSvULbMy1Q0/SRkmTkXtBFRsF/tfnnU5xTXJfHzJQwLGi5y2/T/lD/e/4aznTSFP
 21ZAZiqqGPxzE6mukP8o0ObHXcS9vln/jnnRYYmAzKP5asR2+R9LEO5bfR2WzN28vclR
 E6bcWYvXUZcQjU94MtF78dmdrrijFY/+hlk8DawdBY8QQYIm3tf2CXy1UQOHEqvdxT6k
 w4aZsaZnmtdn9el0+OZUJhF8HrbCi8msb+JOcnKfu8f4082R449hfG5Q7xj+C+C+9Dsd
 94PIlc2pBl9OsBnygPaOBPJa8tqw6zAZ8T0dHW7vLAW7K5n7muz1CpV2Z5NrpQ8e/F6j
 vyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599364; x=1786204164;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FuFtTDinus87NyEoGbynQ4iEbCSAbrvkEEz0kBJeCWI=;
 b=BgEZCKzKzCTG8yBa48/B8BFMk1HhIN2iHL1AdaB6nXBFIGxdms0DoOlSXv0LGm0TS/
 hCJCTg66mD+AQ7uQlzWPPEhk/q8v3FaMlXP+heWpEIib0L5Z1NoyLGxeJwXs/furjHev
 L7YtKPLy7hk/SMkYZfyLmwIElKcXTe/TuACSeLw3zq5QVwuaKA+4QvBuZZrLmYdaczvB
 LIleBGwzngX8tdmNEcGjY7HXmeYx9tTWDuQmg3681a1WjIXlAvj67X2ETHbspwJ5wSjr
 B9DMRETh5WdumRsulLxtlzqS2Ce27ZjhdiFW/Eldji4Uy8LyRiLdJxIFGT5q4woQ5WSV
 FL/Q==
X-Gm-Message-State: AOJu0YyIc7g/lpVA7fT4JTievr2J/8FmuK/G1ds1MfeG4SL76KAPMmIv
 eIHqtzq5z3NLgmgomseMQRXfgambe/02UrClqtzlDtGWeuPKGRXW+bDI11oe7Q8vuCc=
X-Gm-Gg: AR+sD10yyCgf7WH/ZGBicKfb/N4jArc3ziZuNXXsQ/ilwWaW7z1OAX6wFkrYUBtKOSU
 J6Ahs1Iss9abK4flCvmcDhURZdc8l498Wues/g/WeGbf+KMsX90jY2UpjMWWAOKy/1UxDXq5tgl
 mmmPWiYk+IeLXekytX05iJYlqPotG6EgxJnsmn5SBiISqXXzDR6m+JNOb508OBAHPo+djUtBKMT
 12BdfF2oz5MitMCTZ8TZAyCyACuu+UsCIZmzTw8VcFdhi9r2XfHrcxRo/3boiW+eP5/m0UYEV4G
 3swlaEjnFjjx10tLDkYeL9eSf4JYlmYmVADd9Pdc//MkjCoRLXvdTi7MFbzWvZKwvK08kMNMbjY
 Pq93Y2gTMvbIzuMo4WjsQ1Tl+0QUCwN0TBwMBmQ6iIHzId4MT/SwOFr6sM2xAPLDGFmrb8czzhU
 mZURMCATgsBMIvBvzT4As6BAK7mLbIvIDAvto631IUlg+dHWN/QWlGHjEwmPj2OEjbKh1Hn2Mke
 q3MTgayzlTWPl5dLzJEuvSikADGuw==
X-Received: by 2002:a05:6a20:430b:b0:3c0:9c1a:8936 with SMTP id
 adf61e73a8af0-3c92a90228amr3951438637.62.1785599363975; 
 Sat, 01 Aug 2026 08:49:23 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c96asm19459716eec.7.2026.08.01.08.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:49:23 -0700 (PDT)
Date: Sat, 1 Aug 2026 08:49:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, ciara.loftus@intel.com, mtahhan@redhat.com,
 joshwash@google.com, jtranoleary@google.com
Subject: Re: [PATCH v4 0/2] net/af_xdp: add Rx timestamping and read_clock
 support
Message-ID: <20260801084920.4538596b@phoenix.local>
In-Reply-To: <20260801032534.2865192-1-blasko@google.com>
References: <20260623215325.814776-1-blasko@google.com>
 <20260801032534.2865192-1-blasko@google.com>
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

On Sat,  1 Aug 2026 03:25:31 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for dynamic RX timestamping and
> clock querying in the AF_XDP Poll Mode Driver.
>=20
> The first patch introduces three new vdev devargs to specify
> layout-agnostic metadata offsets and bitmasks for extracting hardware
> RX timestamps from XDP metadata into the mbuf dynamic timestamp field.
>=20
> The second patch implements the read_clock ethdev operation, querying
> ethtool for the interface's PTP Hardware Clock index at start and using
> clock_gettime to query the NIC hardware clock time.
> ---

AI review with Claude Opus sees some valid issues:

The significant one is in patch 1: rx_timestamp_enabled is computed in
eth_rx_queue_setup() and includes timestamp_dynfield_offset >=3D 0, but
the dynfield is only registered in eth_dev_start(), which runs
afterwards. Since af_xdp doesn't advertise runtime queue setup, the
flag is latched false and timestamps are never written. af_packet has
the same start-time registration but keeps the offset out of the enable
condition =E2=80=94 setting the flag from rxmode.offloads in
eth_dev_configure() is the fix.

Second error: the release notes hunks target release_26_07.rst, but
main is 26.11.0-rc0 and 26.07 has shipped =E2=80=94 that's also why the ser=
ies
no longer applies.

Beyond that, mostly documentation/code mismatches: parse_hex_arg() is
base-16 only while the doc promises hex or decimal, the offset
direction is undocumented (they're measured backwards from mtod), and
the doc's own example puts the validity byte inside the timestamp bytes.
