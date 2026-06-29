Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C9CC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 17:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DAB140293;
	Mon, 29 Jun 2026 19:38:11 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 4C14C40150
 for <dev@dpdk.org>; Mon, 29 Jun 2026 19:38:09 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-139aff562e1so5239631c88.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782754688;
 x=1783359488; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLkOc+EaE8bBufnL9VMA3jYO93Kg4Gy8xShSZ/+HxeQ=;
 b=Ti1hJxejJdln168Zu3Hl1rOVWiKGGGKwf5vcSdg17IdKh2Rh4KmTAj3FusHqyG/OCZ
 gNnUTQ6CT31ZI5uBeq0ksf7j1q3S9CXujAUaBG7TBYI1YRYorZZDc0ba528ZlGoemuqz
 o4XCcoAbz6kpYzD8FbyBLWFslpubg9d5BFazJuTGnLL7zG2TySlWtGl50swqvmhicKQg
 cpfSSvwnLKEUlmAS1yzgLC/oyzQSzSBhIvS3LLlSHeIzZERQw3OUWnbohkTOzUq3ruxh
 Q6IOMA8f3lIYollppMhpWE3ozwCS7eRkPIMwnQYGHJCT8ixReD5EAfnQQZs4yXAlzHo3
 ZFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782754688; x=1783359488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cLkOc+EaE8bBufnL9VMA3jYO93Kg4Gy8xShSZ/+HxeQ=;
 b=Pbd6rSEZlfUklGtE58IWMbhn+MA5n1q1kgbwFPGbfhi7J3YzwROB3uJyxLGryASoIs
 xmSsHFqEQ/QETB065gVbulYDJLN+97xkUJCgEBKPiMazs80aPXmcOMYGMsuw5cxbPqun
 XTnLba5eyUdcov7Bvx+DtrekePYZ6+y2zHvqEMnHBshVWxPzWU65Ke68bteLAawYD+w2
 WoX6eglYS/tfYEatEJYFk8vtsQAHXM6S6t9K/IsYEb8kfdfLIcrPufIJxL4zYM9R48pE
 DQHv3ihCnfgw1yRKHWRWyON2OlYu0vWb/LmzTfvHKHnYg0NuYEmaF0hcEbdT6mMj/0xO
 yMfQ==
X-Gm-Message-State: AOJu0YxM61yhgwy3Y38RenG67YKEgW3JYJJQ7A4dk4775wCMJj0LKCaM
 dbhBRvTvqzK3CyQfttX/1KVngzCKeKwcnGcN51goq0HpO0SmgqyIj8U2s8lIdNouu8k=
X-Gm-Gg: AfdE7clnxQgkziZG1acHxAXYCIx382+NTaS2JFNsDDRiIbm/S4sH2GBVFuWbWkTZ4Mz
 rOxfm/aAIJyGVhhsD1XO+KEX/lmUfBK3LB+z7ZYkIU6TmX1edkai6NZ2NTdYqYS1PI3I52FIhj1
 XL/f1A1DksjFyVwWnWslCQbCx41hIZxR6ESGJqvNNBRGyhO8w8IkDl6tEgevSvsMlwA/y3r/a1R
 QUwiad0aq32XArhIFUcmRPkkj65E15xltuCnLrlq10cwyOnWuzY0GkZvBE4swnRQJ1arRifaL7q
 GAZycDLopAlsbd+9kcOHaG4/d4ojiC32jhbdfIhXf2Ah9gmiHx2iInuhI/OJ+0iKde5Nn4rhG6a
 PAQFl79AQEt0HBe0moILt2IpqxobRLNPX45IA0NjTC8HzYQEAoClQj6BM/p+C67zETmuco0Y8gx
 EUAN/dyMHpx/tx/zo2Fy/5hNrpa5T0DYtXCM1Kaq6ekkjueJaUsA4Nbw==
X-Received: by 2002:a05:7022:e18:b0:137:ec94:b487 with SMTP id
 a92af1059eb24-13b2a1af5e6mr188996c88.30.1782754687872; 
 Mon, 29 Jun 2026 10:38:07 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ab6sm78510190eec.15.2026.06.29.10.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 10:38:07 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:38:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, Joshua Washington <joshwash@google.com>, "Jasper Tran
 O'Leary" <jtranoleary@google.com>
Subject: Re: [PATCH] net/af_xdp: add Rx metadata and dynamic timestamping
 support
Message-ID: <20260629103804.3d4154bb@phoenix.local>
In-Reply-To: <CANULgnK9-P5dQtTPayiFD7PLor=1qV=7du-AtRuWGPd4F5SmAQ@mail.gmail.com>
References: <20260623215325.814776-1-blasko@google.com>
 <20260623150638.266d8574@phoenix.local>
 <CANULgnK9-P5dQtTPayiFD7PLor=1qV=7du-AtRuWGPd4F5SmAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 28 Jun 2026 17:50:03 -0700
Mark Blasko <blasko@google.com> wrote:

> In AF_PACKET, the PMD reads the timestamp from socket ring headers
> because the kernel stack processes the packet and allocates a socket
> buffer. Since the kernel stack and socket buffer allocation are bypassed
> in AF_XDP, UMEM frames are given directly to the PMD, which
> means the kernel never generates these socket headers. Also, it
> looks like the TAP PMD doesn't support RX timestamps.
> 
> Since the location of metadata in the UMEM headroom is determined
> by the XDP program, the current driver implementation is coupled to
> a specific XDP program layout. As an alternative, we could just
> plumb the entire metadata headroom to the DPDK application and let
> the application parse it based on whatever XDP program is in use.
> That would couple the application and the XDP program, but would
> at least decouple the driver and the XDP program.


Sorry if I was not clear enough before.
The DPDK PMD provides an abstraction to applications to avoid exposing
as many details as possible. Whenever possible a PMD should follow
precedent and implement functions in a manner similar to other drivers.

The method of expressing received timestamps was never well described
in DPDK documentation. The convention is:
  - A dynamic field in mbuf is used for the timestamp.
  - All drivers using timestamp should register the same field
    using rte_mbuf_dyn_rx_timestamp_register.
  - The mbuf field is filled inside the rx_burst processing.
  - The timestamp dynamic field is a 64 bit unsigned number rolling
    clock value.
  - A PMD providing timestamp, must also define a readclock ethdev dev ops
    so that application can compute the number of ticks in timestamp per
    time interval.
  - A PMD providing timestamp must advertise that in offload flags.
  - Timestamp should only be inserted if the Rx timestamp offload flag
    is set during configuration.

When I read this was a little confused about meta data in mbuf.
Would have been clearer with a simple helper:

static inline void
af_xdp_rx_timestamp(struct rte_mbuf *m)
{
	const struct af_xdp_rx_metadata *meta
		= rte_pktmbuf_mtod_offset(m, struct af_xdp_rx_metadata, -(int)sizeof(*meta));

	*RTE_MBUF_DYNFIELD(m, timestamp_dynfield_offset, uint64_t *) = meta->rx_timestamp;
	m->ol_flags |= timestamp_dynflag;
}

If you are going to do Rx timestamp then a simple readclock ethdev op
is also needed to tell the application what the units are.

But there are bigger issues with this patch:
1. The patch assumes metadata is always present in XDP receive but device
used by XDP may not implement it. There is no capability checking.
The DPDK PMD ends up advertising RTE_ETH_RX_OFFLOAD_TIMESTAMP
unconditionally even if underling kernel device doesn't do it.

2. The format of metadata is not a documented contract between kernel
device implementing XDP and the DPDK.

3. The XDP documentation says you need to check for metadata
in each frame.

4. There are no head bounds checks; must check that there is
packet headroom is configured with enough space for metadata.

I am sure AI will find several more things but need fixing
before ready to merge.

