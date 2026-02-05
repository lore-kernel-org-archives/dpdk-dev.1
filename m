Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4DCEA794E
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 00:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E98934028E;
	Thu,  5 Feb 2026 01:08:34 +0100 (CET)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44]) by mails.dpdk.org (Postfix) with ESMTP id 00DAD40264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 01:08:33 +0100 (CET)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-948a374845fso204059241.3
 for <dev@dpdk.org>; Wed, 04 Feb 2026 16:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770250113; cv=none;
 d=google.com; s=arc-20240605;
 b=kw+1CBtVf9kZf6rLAC6tpxmFyvuBke71YM9njO79sGbq51/PebF1uChQX8YxWXMALu
 63OIdQzume/11VIAd7TaLe/lXi3lvYGHKaMcziJgSUHHqoo0FoGBVdVr+mbv8lxB4NIh
 qxERBTvLOvJYXoVbvI6pQ5yUevC3l9jNc9B/qGwGWs8EP726mM02rXdHwARY3rf60hZ2
 LsKSp/pKkAe5x9UKNmOQ71NzkHT9uUpI9rYteuOqDgn180xYVwzi9TkI9EwVEdUzsYPH
 gbASNM6M88JYZg8LJq6cVLimF9qqHdZtyyanU32SZLrog37OyiAdXy4Ik7Hgvb/9+AQ7
 vQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z+9sQJBxO/ja1DTDWXbe7MQr/u9EqboNtMqofedIDFI=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=aOpABOhWT80/XQWCMQEpoHxF+Q64UExm9Vx8lfpC32iaid13ep8GVaKTIVcbNKG2QO
 3oK7+xB6iJiFIZl+YjqZxslI/OCyQH3hglJqYjuqZiVq/TQm/IINdbI08BKWCWjY5aTW
 8Gurp0ktv1d1ybs6/5mP6N8yceehgXA7tnWnDnX5lfRUuWjLgfLDJA/+tpI6YOMTP5RL
 G1TIY90Ej1rNsM91eoCtw/8mNY/hfLlW3S1/rBRn1ieRRzzK98V6YdQpgVHFf026j2S0
 2mC+rVOzhw9m9nvK89rTUau9RsMwT7h6H0wX5SSRvi/wT9QYbESJJLtW6HQz58PJd3d/
 BlpA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770250113; x=1770854913; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+9sQJBxO/ja1DTDWXbe7MQr/u9EqboNtMqofedIDFI=;
 b=jPioxKD4Rz/l2n+WPLoALEcLfvuG/Jg5kN/GhFJwbKjU1bDrmR2UFznGX9UgV9mpZU
 Eqpj4lzpKzkaz5V1NKGVmqSwNkcaBnnh6UgxWu0ayW5Z3lWz1YOssAS1DzG3vYixfTbC
 8+pviobQ8BCw47WvGNE5SB3wkQ8MWN6ilmNKs0PxsB8FCGZ4qlThMbnY6d3gtY6JqfdU
 b/XZI+ADBBKxTlboVrhWmggHK/USuta2vCeJ9oE6Y0Y1lvhOnMuV+7jfoFZVqCTYRk0C
 gu5NeEvxbt/0Zfj7O86ldzifVApV065zdblQF3z7sa6y/0oExop1T/7/o1xhzxgOARMf
 HzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770250113; x=1770854913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z+9sQJBxO/ja1DTDWXbe7MQr/u9EqboNtMqofedIDFI=;
 b=ZiDzOxKEITkGriesSwZ6RBjdhKBOr2k4J9Q8GuMitVQLveZ94qr4H+MG4Mi+ZbXwc2
 zIBWW/m/2KdpEbidbCRZ8XwW27YiLBEJ3vW6R1bbyVeSVPptyXO7euc22MmjJeS0ZTJ8
 3VmhtdkA5tjP+y4Me0I6RYJuJCldFns2dZJm3IjVM8/5k/8GkSL8meFpvOrlDFJZ1w6E
 KZ/FOWVZ6Z5+Tul9mYiWspBJZcqcigSjNamg7qeNybvKRNP5HnQqywW7li7Y36ezhvk0
 nwadFoja1/uHBZHRkG/wtU6xsY3qnU0LnDrhfCBVLE/qR+s89/IxrUSUmbckccyuyiEn
 aHJA==
X-Gm-Message-State: AOJu0YxjymsPN7VSDB2B+ii1D2ld5zKcMTMmkF6Xte6lJcWsteINqmpY
 uE9NsCRIRphnHbaSeAVV3i0bEOO6MYCAJz9wmim95NHjyHb6xXwV2P/yRzcqhJPO1w/MrUiHIP9
 kAnYUF2trcZRxf7MSqJ+sByGGn9zh7ITtxn/T
X-Gm-Gg: AZuq6aIdrkBwIa/JrMFJwwgY0ABF/d0iY8t+GAYBeXFKSAVshRiT3BRNQ0jr3X+b34B
 lH7dJ15iNHngTK8g6mOm0T2bVr1TK1xiSZIXTfw3HnCA2Ytip7MfrKCpIZVa86ZQap1c6XFBdwI
 u2BRHeOA7//DrBnECmjJndgkwqe8TndZnViknAmnI87T4IUwqOS9lD35LjWZg2Yd1Axx6MZmGaN
 h4bh9A9EkNx1bMNu+mPgB8DavmuuJpo4iYj8DluQmnA+CP01UC359BDSW4oDMIaABVm5VASJx4M
 /yBE0qWlELDSqVbVh5pxzqI=
X-Received: by 2002:a05:6102:390f:b0:5ed:8e3:b66a with SMTP id
 ada2fe7eead31-5f9395ad9bfmr1787913137.28.1770250113122; Wed, 04 Feb 2026
 16:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20260204161202.36805-1-scott.k.mitch1@gmail.com>
 <20260204085233.17c32e71@phoenix.local>
In-Reply-To: <20260204085233.17c32e71@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 4 Feb 2026 16:08:22 -0800
X-Gm-Features: AZwV_QjoxGcaA1t4VIBz54jtXp0ydP9R1a2bWA4NLmj9tEnDd1bbQmHieHlWHzA
Message-ID: <CAFn2buB3bu+ow7uOru73mXDu111kfJGg8B6NZDQRCZzHcuZz+A@mail.gmail.com>
Subject: Re: [RFC v1] net/af_packet: add io_uring TX acceleration
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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

Can you send a link to the RFC patch? I found a discussion thread
https://mails.dpdk.org/archives/dev/2024-November/307925.html but some
of the discussion in this thread (use of epoll, independent FDs per Rx
and Tx, etc.) don't apply to af_packet which doesn't use system calls
on the data path, but only the sendto() notify on TX. Seems reasonable
that TAP could benefit from io_uring but not clear that needs to be
mutually exclusive to af_packet. Can you clarify?

On Wed, Feb 4, 2026 at 8:52=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed,  4 Feb 2026 08:12:02 -0800
> scott.k.mitch1@gmail.com wrote:
>
> > From: Scott <scott.k.mitch1@gmail.com>
> >
> > When user space application does sendto() to notify the kernel
> > there is data to process, the kernel synchronously processes
> > pending frames and the CPU cost is attributed to the application.
> > The kernel processing may also include kernel RX (netlink, ovs)
> > and packet manipulation. This can negatively impact performance
> > by limiting CPU to each dpdk network thread.
> >
> > io_uring offers a mode (SQPOLL) to offload this processing
> > to a dedicated kernel thread. This makes the kernel processing
> > asynchronous, which can improve throughput by 30%+. The trade-off
> > is SQPOLL threads consume additional CPU but this follows the
> > same principle as virtio backends, and enables use cases that
> > can't adopt virtio (e.g. containerized workloads).
> >
> > This patch adds optional io_uring support for TX kick operations
> > to replace synchronous sendto() syscalls. When enabled, uses
> > SQPOLL mode with kernel-side submission polling for reduced
> > syscall overhead.
> >
> > Features:
> > - Optional liburing dependency (version >=3D 2.4 required)
> > - SQPOLL mode with configurable idle timeout
> > - CPU affinity for SQPOLL threads (IORING_SETUP_SQ_AFF)
> > - Shared workqueue support (IORING_SETUP_ATTACH_WQ)
> > - Registered file descriptors for IOSQE_FIXED_FILE optimization
> > - Single issuer and cooperative taskrun optimizations when available
> >
> > New devargs:
> > - tx_io_uring_enabled: Enable io_uring TX (default: 0)
> > - tx_io_uring_sq_size: Submission queue size (default: 1024)
> > - tx_io_uring_sq_thread_idle: SQPOLL idle timeout in ms (default: 500)
> > - tx_io_uring_q_cpu: CPU affinity for SQPOLL threads (repeatable)
> > - tx_io_uring_wq_num: Number of shared workqueues (default: 0)
> >
> > The TX path updates the ring tail pointer directly instead of calling
> > io_uring_submit() to avoid the io_uring_enter syscall, relying on
> > SQPOLL to pick up submissions. If the SQPOLL thread sleeps, we wake
> > it with IORING_ENTER_SQ_WAKEUP.
> >
> > Falls back gracefully to sendto() when:
> > - liburing is not available at compile time
> > - SQPOLL is not supported by the kernel
> > - io_uring initialization fails for any reason
> >
> > Signed-off-by: Scott <scott.k.mitch1@gmail.com>
> > ---
> > Depends-on: series-37248 ("af_packet correctness, performance, cksum")
> >
> >  doc/guides/nics/af_packet.rst             |  16 +-
> >  doc/guides/rel_notes/release_26_03.rst    |   1 +
> >  drivers/net/af_packet/meson.build         |  14 +
> >  drivers/net/af_packet/rte_eth_af_packet.c | 420 +++++++++++++++++++++-
> >  4 files changed, 435 insertions(+), 16 deletions(-)
> >
> > diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_pac
>
> I would rather it be a different driver than af_packet.
> See my RFC patch for using io_uring
