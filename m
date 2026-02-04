Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4FDE9D40D
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 16:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFE48402F2;
	Wed,  4 Feb 2026 17:52:40 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id CEB73402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 17:52:39 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso244325e9.0
 for <dev@dpdk.org>; Wed, 04 Feb 2026 08:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770223959;
 x=1770828759; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43D7o/RKuLrJNVISFq5UXSR+2mHuJmYlndXKYQsergo=;
 b=bX0Dh6li1jC4Dv161/lKrowVcPIPNyJy1lxjuDwfBjAgLvNrz4Au3Evtkt5ycHONbx
 xRo8W6oOk/JmfSeoxAQPfEFKpSBNF788mrGJ9mqSe9b0zk1PqRGv7qFxQ5M34MR5SyOe
 oy6gZR0toBUJ6nISwBaDojmVqnvr0BPp7vjKnirG/PNH6uvFv5snVTWNfLWTHkIUEELc
 TmD/h8HV2majnnFCWxKIHXFWfUZsC8gBa6EXRqaeSMs7LgYpatMPSlO77Grdjvq1vksQ
 mZgoEZMkBCrPKi2jqtX89+ZDM5eJVoB9HXurxUL66H3aPAgT5EnLcyiv2/f6QRsL8qvf
 Eg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770223959; x=1770828759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=43D7o/RKuLrJNVISFq5UXSR+2mHuJmYlndXKYQsergo=;
 b=BJVZ5RoW6TP+GtW2xrlyP+yQnPRlj+XFepbbjE3ndIBu6HVp/KNPKlO2eZ9VX2hgoA
 0Hs1XlJ44397sQMF47WIuT52vUMkWuwCBHbazknN89LILSuNf8uEN7wFlGcO4fPTKeaF
 dGhlfzbwMvwhBKNpCHboKycv54tdGC4jNd1GJH8bSjqK4K985OWsyZ9KzyA6MEgl8Z0l
 Jvhbt7tQ1ii/3lldg+eNb1Wm+3z81NHfGKGJz9TxEXilKuRQZp3tvR0gYiyOZEdEX3og
 0XU2B9G4jYPzSE/NjYCiF73WJjDR14KbjqeoVQVzpmAggWNR5puWbLH7jeG/m89vtKg3
 87eA==
X-Gm-Message-State: AOJu0Yw5/8kR30AkIzKl3+zSxNaxJ3bqBXToYG8bF7yQ7zTwpibXIUSe
 EwM4OP8PDDT/Ov8kjNRNWt749x4NlrlpLv2K0x59TvenQXiOWvx6E47t2Obbb1fVHXJasjq6ov5
 s5Pm1
X-Gm-Gg: AZuq6aKkJl2QB1wrias/mHCHkCsd39t3sfrEsDgUa4oAaIRwQqFrbtVg0vpx6hI5dn4
 E9VLgRkZc3/lGYt/nd52uCmdEVLAmBj0OZJRtAiYYvlSrvCmpBEggcf5QYhv1EbnkHiumjZiS3Z
 xwoqxL2fXNVmBQjLmh5BC8kZv6fUoWL9WVx+TYxv78+GPah9CjfU1pZcQ4amD8QeSoItupboqFc
 KM/aiOm8JV4AhcI5sYnwD2XxUS0iiAO8a8rZN4FbftpMEq6tJwn0+7hPJpmCreU2G7lX+jMoYmV
 6q6QviQE5B4/tYbFwB8mUv2t1EMNf3v+Hvia4OmkdTCS8WUmGugFxe0U4nsCgckj76jBXcRvsey
 3s4x8dSNcRsbzZB9eQLv2+GHDRk7GkU3g8s/8Av1B4AE/QAA8dGYp1Pi5bBTY1oB3XnC+AEvNiC
 V22Q6mek9RuRShWlDrBDortFyeJugIUm/RjnEc5Qc7Ry+HjDmuO/0F
X-Received: by 2002:a05:600c:6217:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-4830e93f21dmr55632195e9.16.1770223958818; 
 Wed, 04 Feb 2026 08:52:38 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180640e5sm6682021f8f.40.2026.02.04.08.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:52:38 -0800 (PST)
Date: Wed, 4 Feb 2026 08:52:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [RFC v1] net/af_packet: add io_uring TX acceleration
Message-ID: <20260204085233.17c32e71@phoenix.local>
In-Reply-To: <20260204161202.36805-1-scott.k.mitch1@gmail.com>
References: <20260204161202.36805-1-scott.k.mitch1@gmail.com>
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

On Wed,  4 Feb 2026 08:12:02 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott <scott.k.mitch1@gmail.com>
> 
> When user space application does sendto() to notify the kernel
> there is data to process, the kernel synchronously processes
> pending frames and the CPU cost is attributed to the application.
> The kernel processing may also include kernel RX (netlink, ovs)
> and packet manipulation. This can negatively impact performance
> by limiting CPU to each dpdk network thread.
> 
> io_uring offers a mode (SQPOLL) to offload this processing
> to a dedicated kernel thread. This makes the kernel processing
> asynchronous, which can improve throughput by 30%+. The trade-off
> is SQPOLL threads consume additional CPU but this follows the
> same principle as virtio backends, and enables use cases that
> can't adopt virtio (e.g. containerized workloads).
> 
> This patch adds optional io_uring support for TX kick operations
> to replace synchronous sendto() syscalls. When enabled, uses
> SQPOLL mode with kernel-side submission polling for reduced
> syscall overhead.
> 
> Features:
> - Optional liburing dependency (version >= 2.4 required)
> - SQPOLL mode with configurable idle timeout
> - CPU affinity for SQPOLL threads (IORING_SETUP_SQ_AFF)
> - Shared workqueue support (IORING_SETUP_ATTACH_WQ)
> - Registered file descriptors for IOSQE_FIXED_FILE optimization
> - Single issuer and cooperative taskrun optimizations when available
> 
> New devargs:
> - tx_io_uring_enabled: Enable io_uring TX (default: 0)
> - tx_io_uring_sq_size: Submission queue size (default: 1024)
> - tx_io_uring_sq_thread_idle: SQPOLL idle timeout in ms (default: 500)
> - tx_io_uring_q_cpu: CPU affinity for SQPOLL threads (repeatable)
> - tx_io_uring_wq_num: Number of shared workqueues (default: 0)
> 
> The TX path updates the ring tail pointer directly instead of calling
> io_uring_submit() to avoid the io_uring_enter syscall, relying on
> SQPOLL to pick up submissions. If the SQPOLL thread sleeps, we wake
> it with IORING_ENTER_SQ_WAKEUP.
> 
> Falls back gracefully to sendto() when:
> - liburing is not available at compile time
> - SQPOLL is not supported by the kernel
> - io_uring initialization fails for any reason
> 
> Signed-off-by: Scott <scott.k.mitch1@gmail.com>
> ---
> Depends-on: series-37248 ("af_packet correctness, performance, cksum")
> 
>  doc/guides/nics/af_packet.rst             |  16 +-
>  doc/guides/rel_notes/release_26_03.rst    |   1 +
>  drivers/net/af_packet/meson.build         |  14 +
>  drivers/net/af_packet/rte_eth_af_packet.c | 420 +++++++++++++++++++++-
>  4 files changed, 435 insertions(+), 16 deletions(-)
> 
> diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_pac

I would rather it be a different driver than af_packet.
See my RFC patch for using io_uring 
