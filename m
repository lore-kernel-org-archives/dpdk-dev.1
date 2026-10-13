Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D75BCC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A70FC40274;
	Tue, 13 Oct 2026 16:35:06 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id C22DA40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 16:35:04 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3008114000E0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:35:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Tue, 13 Oct 2026 10:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791902104;
 x=1791988504; bh=tZlcWGnq3NAgqayK3inv1RfHBuJF1i/tBONri728zyY=; b=
 Uf0xfTE0TFbsfaiS1GwqG3pmFHbd3u/kR/DMlWMaD4xUZ7j++NOcu5W2Bi0WJ2iO
 mB0TRZ/hTZMCaSphEjIrs9SpzuXkgbR5/+eL3fSCE7zjY5FJ5F2i0cEy8y06Whto
 vZvA/3HbkTPadjQxKf9z0kbjX93n/TP3KP/+6AppyALnopPaGMpempdIiijGA/fv
 eScChnNy8BN6YK+rGzyM7rImIpe1qdj1B8Bh1FJ7ge/QIpbQ2Pbik2Zz7GDOTvDp
 sjuTdX145kOz9LStEEg1jcdUxDEJ1VQEWw/MHZ3hWKe9kkzK7wYgIOW4gAoN6Qzn
 R4cqek/h/tf1oaChCPqfdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791902104; x=
 1791988504; bh=tZlcWGnq3NAgqayK3inv1RfHBuJF1i/tBONri728zyY=; b=j
 f10Hmuqti1ua+qi91A9Zy52pWdRmrMGCuQM50thtVHOO72lc38R6nnSX+Z+NsTz3
 UF5uaPV0qNfgwEsm43+4KthErKu7hN4SsnGTjvArR+jqHkis/u+tb0SznHg2QnwP
 qH7I1dPuVbCsqGQqDqnBqz+MvqSW1oxm8pYYjoog2PcvBWcWjiuHiltJ4C7BR1ca
 BfNH4h4MtpQIydcSN/Ot7HxKtXJLnv1YcdnHB5eXMs25giRD2lonT2AD5xc+2fU0
 G2RGlfr8htrCQDqwOqxwrcps4Akxx/hu0LnJ8x1S4x/3hSNcpysJaKb4jcxwJscc
 MGi9XyFIYZyTMWDdY2fHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791902104; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:AWrMvFrA8XvlQTLGr1Pq3CW0LaS6jVYycHSicuu+l4CgkPx
 rgFWyZpWudVUfPjWq7kwry0LT4hs9zUqz3owIfR/sHDfEjb134FNNMWoxBiDBQp6
 V2LP0FOCSLrh7mXAkhX9KufD7OvQ5/MzvcF6UQvRQTaGV2QjXVupv5Rlp2dhFnH/
 eeNTQwpf3eQHho7gYrPJ0DfgCOT4Prx56mCVe8QgimEV/S3K1lkDvTM0JT2Z366U
 mOIQxgHptwLuiL/bCOQacE3sgYKF6ZJJL3CTfWnJxLpFdwobU83EjvmZQXig+3hO
 VQgpwsv34LM7cjdHj6k0N2Ecc6jlcQ3XxR+fRkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:cchzzVrd0gHoAESz1E9l4yut9cyEUoMaQKl9eEdBKRE=:3IoM4J3hHF32V4JQvDmGkueZ1MbDHcW8mUvAw4T72u4=;
X-ME-Sender: <xms:l0HOalCA_8Ai7aik4bWzOuz9np-wodf5zbb3aFBW-DidlAd5hjOM0A>
 <xme:l0HOav1ufCXw79WrZVyFt8SGj_psdWl9xaOqZ6F8N19vVXxk08fyg6nwy9tZDb-3c
 GnvI_-3JDSRZ62i4mDLAC6evaN6dsN1V75c9wt1DfCdjo7fseG74jE>
X-ME-Received: <xmr:l0HOajWZ7Ye0-P3hMWhcAOPKUCyfCNhVK5aSMcwlVe1xl02r2KqhTCHjWO1vJ3f4zfrULmISmodSJoMr3KO40Zs>
X-ME-Proxy-Cause: dmFkZTFu5mtUxgpvEF8q8Ftg1VCZMP3F+Amg599wH7n+9iTXbtXAvJbo7AmVRge9CFthni
 2wsfSseGRWEjKxRPOk/Hh9Mv9BJS+NNy/ZYTzM1RsageCwDaZXD9VrOZyPUsCytGwj1jR2
 Skj/YhM2XC5b9e7jntK47d36sei1WYG0K6iqkhEYrspyY9SK9DyMizY+Tnsba085Mu3LFk
 Rd5Ihny5deqMLX7JyrTDbFt29kQB1WnV5Q1FZrgY13sQoeX/kowto3qcRE+rIFZmdvIf28
 FZDZ2QtrusAz2h82fxweRMCt9VBPOI31+L/Ib/f4WeaDLceU4Z5JK2vJS2QT18I0nARBKu
 6qazJcW1mNhnQhnK6i4aX9pSG6yra5hN0eytpv+DLlC01zK0mPcqFGkhta9AjPw5tV05CQ
 WyCws5YRFjvdM8agirBbXSCKsPoY67kj0DKgm99D6Cw+Fm/ycisR67ssRK1tzbvgX5vmop
 m0cEZzpGAmwwR7a33RZeSQ2zHmUFa0rD9cxCHujGOO1Z4qPmYnS5rFIHUr7v1DSbHft+c4
 s6ZFmTyRi2AyJYdE507UY/+dT5jxfw1dEBOQ7MlW1BbYW6bMpTZSQvhJhcy1JHA5Dva94s
 lbkcjcn9GZJkF151wWjtKs+bkNUxRK+K33h8ZeyTllgunRNRSm70rNxy0smQ
X-ME-Proxy: <xmx:l0HOahl5P2Pnm9RLE7mRTcxCh-dyYiLKsHgTj1C7WvpaEzKxnRWuMQ>
 <xmx:l0HOatD7J84MCR6LfEzHGltV1g4T8tAc752ovFyGK01pxWYz0VQGog>
 <xmx:l0HOapdg3V7bAA9iL0A7MbuOa3MtgJMKs4FYukN8YU7veG-frdQcRg>
 <xmx:l0HOagJIBDCz1K6bOPUKyi5YgZPm4BT9pXijLxjC8SY8bhTbxTDXLw>
 <xmx:mEHOapDB2VAEkCJu-loettTSD7EmZDyEFEx8cHuAWaiPSEFsWjhBLFDY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 10:35:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/13] make signal handlers async-signal-safe
Date: Tue, 13 Oct 2026 16:34:59 +0200
Message-ID: <gxY2U2gcR2u7bN14ODZzfw@monjalon.net>
In-Reply-To: <20260907170454.351647-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260907170454.351647-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

> Stephen Hemminger (13):
>   graph: do not call printf in signal
>   examples: remove printf from signal handler
>   examples/vmdq: do not print from signal handler
>   examples/symmetric_mp: do not print or exit in handler
>   examples/vdpa: make signal handler safe
>   examples/vhost: make signal handler safe
>   examples/vhost_blk: do not tear down from signal handler
>   examples/ntb: do not print and re-raise from signal handler
>   examples/ipsecgw: do not print from signal handler
>   examples/l2fwd-macsec: remove print in signal handler
>   examples/ethtool: fix exit flag and unchecked cmdline
>   examples/vmdq_dcb: allow exit on signal
>   examples/eventdev_pipeline: make signal handler safe

Applied with a bit of squashing for useless printf, thanks.


