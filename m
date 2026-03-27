Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2514810F284A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 16:22:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 246C240E49;
	Fri, 27 Mar 2026 17:22:17 +0100 (CET)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 70462402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 17:22:15 +0100 (CET)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so2643044eec.0
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774628534;
 x=1775233334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=269K5Dm4khstQTTgkAeJZBd2sK5MU3SzuiCCNZVqfvQ=;
 b=sWR/ZoEKyIjisqL2Hju4hpnVzhiq7cB/hhA8IJFYEW5h58VFIMSjavGrK5G6RUrXCm
 YHVC0BnXLZdPhyA5lM/TzIK7kp1pWORsfB24vg3z1EpIwiCd56i5vODbFmGqh9NSdBoh
 lnenvVz2NIADRo663aSeC38QyQ4JaEgjc0V3pvogcTPYFzvv5rBN8TGLNr9XD3XW60EJ
 hgPx0fUl/c5/gNOA2TeuaaO/jOy/+HLn70u+iCp9Md+JxL4pIvAlnckLOt4xuPqrFFlz
 +CaW44PIsusnLHz3mjdke+4SEEvyhI3nmYhhI1CfbFQ+kMpMw5/y/S3D5yeXYBo3dgGj
 y5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774628534; x=1775233334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=269K5Dm4khstQTTgkAeJZBd2sK5MU3SzuiCCNZVqfvQ=;
 b=g3QJGm2y7BpxfSHRyX3CTtgUDY6vf4tPl7iZgCbQsdfUMAEvbz/pr4c6W2iqJO8d3W
 fQ3j7o656RhP/PLriIAkuUJ+TeTuhAMI01HO/+hWASQSK7+rY3N0uWhyClE5NNLfpxsq
 ukjRCZmuCA+ZPkpLG77dWZ+PqlHeW3BBmROoVDiU4mbPGV5JKK+psce9AYdBQFk5dyry
 qzYZtqZ3PeZw3zMLoy/uWyhHW9+d5sRB6up10UHiqXROZCz16iFor2wW7NEJ7rRLVzLL
 4qxeAqzWf0UUzsgZ82/+Ccg/qtJmXZd1QvOCxTyPpQZiOkdAYcFma/6BwHgQq80whHU9
 KqPw==
X-Gm-Message-State: AOJu0YzhDinHx3Bodq0fR1gy8SVemVTRk10650qrgefQY9YwsigHNa1L
 asPu3u53MafN5XfR1Vb4cXzRLVAd6sEzaL+QqPMuACIEWxqdscPScBysURsofPAlcjuItUmgi2t
 xota9
X-Gm-Gg: ATEYQzyU7fQJzL6vsIyv9sC/wuxfC0V6hvrS9GvAOqMqvx8BlsPd+ohwjv0KAR0QWqp
 T25vJzDrvOqbUk40RYAP0ebslf4B/cNDUwDdzaurJ5hPc02diKnkBGExOkZJXFhNVBVUfRIfLht
 eUU1SYgNL+Qb3lwLpwqVJXgX06ZvQMlkxZQgMDT8NJPW9/HyU9r6TtN9U1zMHVVj2GmKMYLjsEs
 sCIyNjp5uS4QHEH6qb6MgcP02Iumskm/B/OrJnhVmmvWjWFHXUc/Hu6ScVLhkAvEGd0dfuWrDJY
 iYP2nROKbfY5PxhRswpg+CFNzg/qtqAU9OWIrbZrNbhk4V4Ze9quILSM/skG4YKdnIG2uUNEHIh
 iiIX0KgmwoTLgShK6oML//X+Qwkta/5WGbUY+2STTKWd6s6iCg+HZ6QfZg3JKDidpFmpN7P+tJy
 rvhlS2TLJ3HD3VLplw73FaIPREqDxqxIIAmwQ=
X-Received: by 2002:a05:7300:c38f:b0:2c3:9406:d574 with SMTP id
 5a478bee46e88-2c39406da12mr177586eec.4.1774628534486; 
 Fri, 27 Mar 2026 09:22:14 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ec49615sm5837025eec.11.2026.03.27.09.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:22:14 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:22:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] net/tap: fix close for partially configured port
Message-ID: <20260327092210.150d7411@phoenix.local>
In-Reply-To: <20260327083903.3394778-1-david.marchand@redhat.com>
References: <20260326124612.2580985-1-david.marchand@redhat.com>
 <20260327083903.3394778-1-david.marchand@redhat.com>
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

On Fri, 27 Mar 2026 09:39:02 +0100
David Marchand <david.marchand@redhat.com> wrote:

> In case no rxq has been set up (like when starting testpmd with no mempool
> drivers), a crash happens in tap_dev_close:
> 
> Thread 1 "dpdk-testpmd" received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7fad68b in tap_dev_close (dev=dev@entry=0x4c4a80
> 	<rte_eth_devices@INTERNAL>) at ../drivers/net/tap/rte_eth_tap.c:1111
> 1111			struct rx_queue *rxq = dev->data->rx_queues[i];
> 
> (gdb) p dev->data->rx_queues
> $4 = (void **) 0x0
> 
> Fixes: 23e2387b49a1 ("net/tap: allocate queue structures dynamically")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - as Stephen AI reported, [rt]x_queues array are sized against
>   dev->data->nb_[rt]x_queues, so the loop after the 23e2387b49a1 rework
>   can go out of bound. Since nb_rx_queues == nb_tx_queues with this
>   driver, simply check the number of configured rxq,
> 
> ---

Applied to next-net
