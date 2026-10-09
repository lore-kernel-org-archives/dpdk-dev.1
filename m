Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E34ECA601E
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 20:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C96840274;
	Fri,  9 Oct 2026 22:04:06 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 656B04026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 22:04:05 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3a7cfe8f761so1490122a91.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791576244;
 x=1792181044; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ssT7m6aby2se6HrCmtFMB/6LaYZeGCqju9aZYehpjCM=;
 b=fN6KoSYCvBPH9bBUf+hTpQ5tHthya5WKrjcwQtDBF8u3sgl0SKsrPXJVxirfaEJfqE
 qRyO9axB+LHdRTpd1s9tD6vw6d1DF56xVy2yLpqzTvxSNzwNjLWiASi3ZV/CMrKuLm5t
 ioXpOJuInBuwjrUN1DXDYrYG6Zil4ADDbqWbyrrVJPr1qq6XwdaXEk9lRZUELZ63iPA+
 eXT1BImGcq/59dcjhKU/LohJMTn5I303ZPT1yxUe9Fk+MQLcLG9FpxN0JMpbSQ4Z5tug
 s/w1qxcCcdAuZsmMec6Qz6OEryEJ+pGeED9F9kiBuuFvcl2EArKzPBu4Wr0BJ5/haIvZ
 FI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791576244; x=1792181044;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssT7m6aby2se6HrCmtFMB/6LaYZeGCqju9aZYehpjCM=;
 b=CDBnz88Rb4Mm0hvDxPi5cwr6YAtvV1OpnkXqZEpyxc5cPoBWwJBTxyhzs7sbL+gulV
 0p33zEBRlwpKg+POuNnsjGEH2xeTMBWNQ5mwoVJjuJdvDj1CPXesHls9vik4BJVR9xBA
 X4K07hMr8YjvJ/jbxK73eOtKs+RYGlEes6svZFmnvZadHYm6fN1DYCWUAq91LQbtWi95
 6DWfkzRus7hJGqd7Zt0/FAIsU24E7IvzbUc4CW0wx8T6rtQs5nmWPv1qkOSqj2Y1EVm1
 3uN3G90jsmilvE9ik/9xDzVzpEIKe7ZbGo3mQzIoJIlgPDx5Li0GaC66Mujj2TUP4fJo
 KojQ==
X-Gm-Message-State: AFq9FYJJ7Sd8hUvsod9S50uxkljZtTpdlOA4k0MmsO4dVjoMKYNccsuM
 AqeBXWfRzGdVkqcKbhzVRScbu0P7UNgh0o4R99BKtzRi4yyLX/7ZFngtQgR/riC/t1RQgOLZyzy
 nWvdc
X-Gm-Gg: AYBFou1f88mwn01eHmqbbVlVO3fS6dpRBFCpXo+geEEiZURFhDPPHn1WmoeMs2tjmtD
 jdviM5lGiweIgu69SJsWdsMuSSANtBh5Rk87hC1NiFKtgFJivu/jLG+o0xVQhP+AwNsl83EEjVf
 C3N7vawxkNwPFDbOKQiYjrEJgFE2MK34s1JKHORsHF+ZWuUMtKHZiHVYqDzLwJAA0tQhBZguSNP
 SmsHvb2tZBla0HmWGynQPtvcrX3z8W1VktEgA0MNwxI+V4vzXihZLN8UPEaJe6Q7aFY4buBxk5x
 tmGPpuuDjDwBTKqAp7YSLi8RCvhjKxBdlonH2LLd3cDakxGKu/gmNPzv5O00vlZ5C5eIzY8wGTR
 nJWksMwxuTLg86yeamI82DpBJhhE45yoVU8ZogLvNA3VGLX8Nn5Nnu11O1X8Y7Ts4W4NEPoOlvF
 +qifMF0nnhKl9rxZa5vMM3Q3K0a3iLYCXTd4PmYZ9NrQ7sTZdvUMSpKsKrIHVqflLXmkmInnl/A
 aK4DTeNBU7z64GAg/X6wv+xWcgTX7rjBqWdWzUc
X-Received: by 2002:a17:90b:1d50:b0:3ab:4e4:e97a with SMTP id
 98e67ed59e1d1-3ab3ab227d9mr1635486a91.26.1791576244116; 
 Fri, 09 Oct 2026 13:04:04 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab32d58bd0sm2997814a91.0.2026.10.09.13.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 13:04:03 -0700 (PDT)
Date: Fri, 9 Oct 2026 13:03:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/3] net/af_packet: do not return outgoing packets
 from rte_eth_rx_burst
Message-ID: <20261009130359.0dc2eec4@phoenix.local>
In-Reply-To: <20261009151015.742011-1-frank@dressler.pro>
References: <20261005002809.1676723-1-frank@dressler.pro>
 <20261009151015.742011-1-frank@dressler.pro>
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

On Fri,  9 Oct 2026 16:10:12 +0100
Frank Dressler <frank@dressler.pro> wrote:

> In contrast to other PMDs, the AF_PACKET PMD does not only return
> incoming but also outgoing packets from rte_eth_rx_burst(). This is
> fine for applications similar to tcpdump which usually want to see
> both. But it is not always the desired behavior. For example, the
> AF_PACKET PMD might be used in a testing environment in which no
> regular ethernet PMD works. In such an environment, the AF_PACKET
> PMD must behave like a regular one, i.e. not return sent packets
> from rte_eth_rx_burst(). One could use the AF_XDP PMD for this but
> it has different dependencies than the AF_PACKET PMD because it
> requires the ``bpf()`` syscall, for example, which might not be
> available.
>=20
> For this reason, this series adds the ignore_outgoing=3D<0|1> devarg.
> When set, the PMD ensures that rte_eth_rx_burst() only returns
> incoming traffic. The default is 0 so that existing software works
> as before.
>=20
> The first patch does this filtering in the PMD because this works
> in all supported kernel versions and for all queue counts.
>=20
> The second patch adds PACKET_IGNORE_OUTGOING which moves the
> filtering into the kernel. It is supported since v4.20 but only
> works for single-queue AF_PACKET scenarios. Multi-queue AF_PACKET
> is still filtered in the PMD. =20
>=20
> The third patch adds PACKET_FANOUT_FLAG_IGNORE_OUTGOING which is
> supported since kernel v6.2 and moves the filtering into the kernel
> for the multi-queue scenarios. The kernel does not expose a direct
> way to check whether it supports PACKET_FANOUT_FLAG_IGNORE_OUTGOING
> but it also does not return an error when the sockopt is set on
> kernels that do not support it. Because of that the sockopt is set
> opportunistically. For kernels v6.2 the filtering will then happen
> in the kernel and for earlier versions the PMD does the filtering
> for the multi-queue scenario.
>=20
> Overall we get the following:
>=20
>               | Single Queue | Multi-Queue
>   ------------+--------------+-------------
>   Kernel 5.4+ |  in kernel   | in PMD
>   Kernel 6.2+ |  in kernel   | in kernel
>=20
> I tested this on both, kernel 7.2.8 and kernel 5.4.0 with both single
> and multiple queues. My results, strace'ing testpmd 7.2.8, with the
> variants of ignore_outgoing=3D0|1 and single/multi-queue:
>=20
> Kernel 5.4.0:
> 	qpairs=3D1,ignore_outgoing=3D0: -
> 	qpairs=3D1,ignore_outgoing=3D1: setsockopt(14, SOL_PACKET, 0x17 /* PACKE=
T_??? */, [1], 4) =3D 0
> 	// 0x17 is PACKET_IGNORE_OUTGOING
>=20
> 	qpairs=3D2,ignore_outgoing=3D0: setsockopt(14, SOL_PACKET, PACKET_FANOUT=
, [-1878917532], 4) =3D 0
> 	// -1878917532 does NOT contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 	qpairs=3D2,ignore_outgoing=3D1: setsockopt(14, SOL_PACKET, PACKET_FANOUT=
, [-805175699], 4) =3D 0
> 	// -805175699 does contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
>=20
> Kernel 7.2.8:
> 	qpairs=3D1,ignore_outgoing=3D0: -
> 	qpairs=3D1,ignore_outgoing=3D1: setsockopt(13, SOL_PACKET, PACKET_IGNORE=
_OUTGOING, [1], 4) =3D 0
>=20
> 	qpairs=3D2,ignore_outgoing=3D0: setsockopt(13, SOL_PACKET, PACKET_FANOUT=
, [-1878978899], 4) =3D 0
> 	// -1878978899 does NOT contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 	qpairs=3D2,ignore_outgoing=3D1: setsockopt(13, SOL_PACKET, PACKET_FANOUT=
, [-805236964], 4) =3D 0
> 	// -805236964 does contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
>=20
> They show that the setsockopt succeeeds even on the old kernel that
> does not support PACKET_FANOUT_FLAG_IGNORE_OUTGOING, so setting it
> opportunistically is fine. They also show that the code only tries to
> set PACKET_FANOUT_FLAG_IGNORE_OUTGOING or PACKET_IGNORE_OUTGOING when
> requested by ignore_outgoing=3D1. And it shows that
> PACKET_IGNORE_OUTGOING is used for single and
> PACKET_FANOUT_FLAG_IGNORE_OUTGOING for multi-queue.
>=20
> I have also manually ran testpmd in all modes and both kernels to
> verify that ignore_outgoing works as expected, sending packets and
> checking what testpmd was receiving (``set verbose 1``).

I see one warning from AI review worth fixing.

Series applies to main (1d020e1) and builds at each commit with
-Dwerror=3Dtrue. Kernel filtering is right in both cases now: single
queue uses per-socket PACKET_IGNORE_OUTGOING (no fanout group), multi
queue sets PACKET_FANOUT_FLAG_IGNORE_OUTGOING on the group with the
sll_pkttype check as fallback for pre-6.2 kernels. The v3 fanout
problem is resolved.

The test still cannot tell a working filter from a dead port.


[PATCH v5 1/3] net/af_packet: filter Rx of outgoing packets in the PMD

Warning

1. ignore_outgoing=3D1 test passes if the port receives nothing.

     if (ignore_outgoing)
             TEST_ASSERT(rx_pkts =3D=3D 0, ...

   Only outgoing traffic is generated, so a queue that drops
   everything passes. Echo the transmitted frames back through
   tap_fd, as test_af_packet_loopback() does, so they arrive as
   incoming. The kernel only ever transmits on the tap, so for
   ignore_outgoing=3D1 the count is exact:

     ignore_outgoing=3D1: rx_pkts =3D=3D nb_tx      (echoes only)
     ignore_outgoing=3D0: rx_pkts >=3D 2 * nb_tx  (sent + echoes)

   After do_tx_burst(), with tap_fd set O_NONBLOCK:

     while (echoed < nb_tx && elapsed < LOOPBACK_TIMEOUT_US) {
             n =3D read(tap_fd, tap_buf, sizeof(tap_buf));
             if (n > 0) {
                     if (write(tap_fd, tap_buf, n) =3D=3D n)
                             echoed++;
                     continue;
             }
             rte_delay_us_block(STATS_POLL_INTERVAL_US);
             elapsed +=3D STATS_POLL_INTERVAL_US;
     }

   then poll all Rx queues and check the counts. With qpairs=3D2
   this also covers the fanout path.

Info

2. Use ``rte_eth_rx_burst()`` (double backticks) in af_packet.rst
   and release_26_11.rst. Single backticks are RST interpreted text,
   not literal; both files use double elsewhere. Also in 2/3, 3/3.


[PATCH v5 3/3] net/af_packet: use kernel to filter multi-queue Rx

Info

3. Commit message says the PMD "does not need to do this anymore",
   but rx_queue->ignore_outgoing stays set for nb_queues > 1, so the
   sll_pkttype check runs per frame on 6.2+ as well. Keeping it is
   correct (the flag cannot be probed, and sll is in the same cache
   line as the tpacket2_hdr). Fix the text, not the code:

     The PMD check is kept, since older kernels accept the flag
     without effect and support cannot be detected.

4. Release note "filtered in the kernel since v6.2" reads as a DPDK
   version. Say "Linux 6.2". The kernel version detail fits better
   in af_packet.rst next to the devarg than in the release notes.

PS: AI review also mentioned pre-existing bug.


A separate, older bug turned up while checking fanout_add() in the kernel. =
get_fanout_mode() always ORs in PACKET_FANOUT_FLAG_ROLLOVER, and the kernel=
 returns -EINVAL for PACKET_FANOUT_ROLLOVER combined with that flag. So fan=
out_mode=3Drollover with qpairs > 1 always fails setsockopt. It=E2=80=99s n=
ot part of this series, but it deserves its own Fixes patch.
