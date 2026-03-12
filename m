Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF2106ACC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:20:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40F3340A67;
	Thu, 12 Mar 2026 17:20:55 +0100 (CET)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54]) by mails.dpdk.org (Postfix) with ESMTP id 47F9540613
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:20:54 +0100 (CET)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-4042905015cso738798fac.0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773332453;
 x=1773937253; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emlIhyqCl4yUB9oOQQQCN2UgxeLLFlO0hkcqQLx5nr8=;
 b=HHfmOHSBsenYnTYWcP8skTHtvEiknSIrKXmKrK00pcWfJKaZ7TYWsFfoLXK/qaIEXi
 wiM/2s+T6P1fnuwA8XkVs2/AXgDKSMPzc0H/U2kiuGE/OlZHJH2tXqRRcS8P1fG5QJw5
 iUBPycwYXfBfFxdYxv7ZAuDVrEBn5SWgP9R9h2xXVSeCBIqwAmnkDd/i+m/XnKHkVX6r
 158DpRxJUKJu7s0mh7uf1nUFCANumG9dXkKK8IVHQC5tGl/pRg4HWVbtpoB84lNSF6Ti
 5eI+dZ3kiFiio8HpvF/jnWLxSsGcMdDIMeolpBq6Tgzjr8nquE9XLKDyg9UUc3w052m2
 G2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773332453; x=1773937253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=emlIhyqCl4yUB9oOQQQCN2UgxeLLFlO0hkcqQLx5nr8=;
 b=J24eQQ+B1G8PaoJK9AD+PsNOBgT7DJTya+eDR0dWDV1k9okstA/wbMgzfQT57mv5y7
 Mvurn5ORJzWZ4J3rbBHEfViyr/Dpb5dOFWPeyyNgM+1NJx48PoTkEG8rr1S/UzB7I+Ft
 dCtP/Bb6y+wH9adV9k/+wpfOi6M8wa7sRBnBuVe00RzcLjwgJLDIpJh2fGg+cf7/zESP
 fB907buDIhmUfaVYkeG7YiEFaDfQKGRfzdo1wy9CIWVFtmDrbhrwznuzGKHcMpzUKi6+
 IuJb2O6PxPmVgzQfwOSBw9AxEc23oCWYwkBQ3aQZyWeju1AJaYjMUi5KLHj3A9LHj3Ma
 PzTw==
X-Gm-Message-State: AOJu0Yw6M+7qJX3O+Orj4j3sH2U5FxJ9t4YGFnH7vfYpv3B+XziT2D9t
 v+GTx3/H2z8/4yb+hTkjxPzMgfTs7ybBXIQyc4PH7WfuVjep4+GoSSJ9hSO4sqldH2s=
X-Gm-Gg: ATEYQzwisxwFPWuwh4F63dOdY1RtSDxhD1uXR2GOGAMr9XQpVNHaliL0f+ru7u0qvdU
 NjVxRyndU1rSlh5J+TawRWE8bmdGLRK9w8+/RiZ/meYbFkrvwafrKvIGVwDXo0ngmUIm7VgRcr/
 QT81Eph+6QsHdgKCsNc6F2Mq14I0tuN+UbiuN5sYubMATn2qyVuDvdpF3tsxzJKUtEYDcv/bCOn
 ThpigiLuM62gWizZ28bFfkQeqPVXnzzaO01+5Q2QNnKFOuqZfuPKqVtnxTu7hO6kSrHQdZqKbP9
 8HG3Tow7U4uKoSipPjHcprtV0jzQpveMzACEMSj1wjzRdGTfa3AFCUW/cGVfk2xVdPB2dSZrZGH
 LXx5mXU61C3pEq0RT3u3F50kGSDZW2/Hnwn/T2NqzWhZdNujQY3tYYQTZofwyDu5LsRzwHUGbi8
 VWJdFPfpQcreIzyGa8vN5BG5rR8arW47Rsfi4=
X-Received: by 2002:a05:6870:a40c:b0:417:36a5:23a8 with SMTP id
 586e51a60fabf-4177c68728fmr4301655fac.14.1773332453410; 
 Thu, 12 Mar 2026 09:20:53 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e6e82cdsm5629624fac.18.2026.03.12.09.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:20:53 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:20:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 3/3] net/af_packet: support jumbo frames
Message-ID: <20260312092050.0a85818b@phoenix.local>
In-Reply-To: <20260312133248.3435717-1-xavier.guillaume@ovhcloud.com>
References: <20260310163158.4832e4b1@phoenix.local>
 <20260312133248.3435717-1-xavier.guillaume@ovhcloud.com>
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

On Thu, 12 Mar 2026 14:32:48 +0100
Xavier Guillaume <xavier.guillaume@ovhcloud.com> wrote:

> Hi Stephen,
>=20
> > I wonder if TPACKET header could go in mbuf headroom.
> > And also, could the copy on receive be avoided? =20
>=20
> Thank you for your review and the interesting questions. I had not
> considered these angles, so I took some time to look into it.
>=20
> As far as I understand, the current RX path copies the packet data
> from the ring frame into an mbuf so that the ring slot can be returned to
> the kernel immediately after the copy. This keeps the ring available
> for new packets regardless of how long the application holds the mbuf.
>=20
> Going down the zero-copy route would introduce a strong coupling
> between kernel-managed ring frames and DPDK-managed mbufs: the ring
> slot could not be released until the last reference to the mbuf is
> freed, which risks stalling the ring under any buffering.
>=20
> Because of this copy and the resulting decoupling, the TPACKET header
> does not need to be carried into the mbuf at all. It is only read
> for metadata (packet length, VLAN, timestamp) before the frame is
> released back to the kernel.
>=20
> In this context, my feeling is that the introduced risks outweigh the
> gains (the memcpy looks relatively small compared to the full kernel
> networking stack af_packet goes through).
>=20
> Did I miss something?
>=20
> Regards,
> Xavier

Copies matter, especially for larger packets.

I noticed that later kernels support TPACKET_V3 with sendmsg and MSG_ZEROCO=
PY
it was added in 4.18 kernel so should be ok; the downside is it goes from
ring to syscall per packet rather than syscall per burst.

For RX, you right it adds complexity.

Did some brainstorming (with AI as checking), and it looks like=20
maybe some mixed mode where it uses zero copy on Rx until there
is some high watermark. Something like:


## The design

The receive path becomes:

1. At queue setup, register the entire mmap'd region as an external memory =
zone that DPDK knows about (via `rte_extmem_register` if needed for IOVA).

2. On each received frame, allocate an mbuf but attach it to the ring frame=
 via `rte_pktmbuf_attach_extbuf` instead of copying. The `shinfo` free call=
back atomically sets `tp_status =3D TP_STATUS_KERNEL` to release the frame =
back to the kernel.

3. Advance `framenum` as normal =E2=80=94 the frame stays owned by userspac=
e until the mbuf is freed.

## The hard part: ring backpressure

This is the real design question. In the copy path, frames are returned to =
the kernel immediately in the RX loop. With zero-copy, a frame is held unti=
l the application frees the mbuf. If the app is slow or holds references (e=
.g., reassembly, batching into a burst for a worker core), you burn through=
 ring slots fast.

A few options:

- **Large ring** =E2=80=94 bump `framecnt` significantly. Memory is cheap a=
nd the ring is already mmap'd. For a capture workload this is usually fine.
- **Fallback to copy** =E2=80=94 track how many frames are outstanding. Whe=
n it crosses a watermark (say 75% of the ring), fall back to the memcpy pat=
h for new packets so you keep returning frames to the kernel. This is what =
the AF_XDP PMD does conceptually with its fill ring management.
- **Just drop** =E2=80=94 if the ring is exhausted, that's backpressure. Th=
e kernel drops packets, which shows up in `tp_drops`. For monitoring/captur=
e workloads this is often acceptable.

The fallback approach is probably the most robust for a general-purpose pat=
ch. Something roughly like:

```c
/* threshold: if outstanding frames exceed 75% of ring, fall back to copy */
bool zero_copy =3D (outstanding_frames < (framecount * 3 / 4));

if (zero_copy) {
    /* attach extbuf pointing into ring frame */
    rte_pktmbuf_attach_extbuf(mbuf, pbuf, pbuf_iova, data_len, shinfo);
    rte_pktmbuf_pkt_len(mbuf) =3D rte_pktmbuf_data_len(mbuf) =3D ppd->tp_sn=
aplen;
    /* do NOT set tp_status =3D TP_STATUS_KERNEL here; callback does it */
    outstanding_frames++;
} else {
    /* copy path as before */
    rte_pktmbuf_pkt_len(mbuf) =3D rte_pktmbuf_data_len(mbuf) =3D ppd->tp_sn=
aplen;
    memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, ppd->tp_snaplen);
    ppd->tp_status =3D TP_STATUS_KERNEL;
}
```

The `shinfo` callback would need an atomic decrement on the outstanding cou=
nter plus the `tp_status` write. You'd pre-allocate one `rte_mbuf_ext_share=
d_info` per frame slot at init time, each wired to its corresponding `tpack=
et2_hdr`.

One subtlety: `framenum` advancement is no longer gated on the current fram=
e being released. You're advancing past frames that are still in-flight. So=
 you need a separate counter or bitmap to know which frames are actually av=
ailable when you wrap around. The simplest approach is to just check `tp_st=
atus` as you already do =E2=80=94 if you come back around the ring and the =
frame is still held by userspace (status not `TP_STATUS_USER` from the kern=
el), you stop, same as today.

That actually works cleanly because the existing `tp_status` check at the t=
op of the loop already handles this =E2=80=94 a frame you haven't returned =
to the kernel won't have `TP_STATUS_USER` set, so the loop naturally stops.
