Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E2606A331
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ofGstOMH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC5174026F;
	Mon, 16 Nov 2026 18:41:29 +0100 (CET)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTPS id E03BA40150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 18:41:28 +0100 (CET)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cdde3597d8bso28169a12.1
 for <dev@dpdk.org>; Mon, 16 Nov 2026 09:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794850887;
 x=1795455687; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aMfzspdfjQn+cgdAO6e1wEvZCvxDmjlQLC5X0zC8GC4=;
 b=ofGstOMH9YnUayCYYPTmHWgkmFTyuqeS+DPplCi3An35TFpugaHdm/D+Z4huDFYuRM
 luS9/pOWgH1fcZ8x/UZZ+JGcS0cBtxea6aO0/Oi9lthrZ0a+ssHCRBO/4I+bxqaUZA1C
 o9howcwM8WzhZzVm29X3f8pm39q4YCQyPda4Rf+Yiuk/JsiOekZo8ORfdZfa5V28NHZ+
 NKVZSM2/zg/gOj7iJfR3Kfv1BuWYz6EOjR0KB2CxyGxpuherH7LqO0Dm/ZHEyqutCogk
 IjUHemX9AIcG9ZgnKTeJV2Xw0FuucFhIHP9ZDQsNX3hVYYUc0u9cXbnADsfXZulYAVav
 WbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850887; x=1795455687;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aMfzspdfjQn+cgdAO6e1wEvZCvxDmjlQLC5X0zC8GC4=;
 b=K1WZGcbMusMuIsQl8QaAl5DeEYfstur+c3u/BIeRE1JC1iNjr7Hlkq00pI/LdQuXM8
 mRgATPJqiUstaXFbfI2oXPr71PfnsD7+DeHT5o03+7/z7U1Ald9F9/MiDN8YL0clt7xa
 I+/hPkUbER1JMT2lwZerGAcXHie+m58zEpL4YBjYDL5GMMDQ4fHrQhLBvymiWPgLEuIA
 o19oKzcjAVtZDetu3dXv5Ticx7o5os3Zhvq/wN6KCJHDyVgbkuwNkUJh3nzXq/u4Zalb
 Yo5zW2iQHS3qgtSCrIcdNHvizSUWzCdZEX4WbJekebKLGnqmXXUL2OaP7s5X4iV0UnVR
 V4Sw==
X-Gm-Message-State: APuU4Z9m5H/SyLCCN2ViZwuEokKZCZvNfOGMEATXhGtAAHXAMRl06lw0
 VvAE8SV+LfCm7qSFa/VztMSC6MRY7nWWmP1qY6mY5eZRT9/3lDDa9PKQmdaFeHVhFv6hFqLvDPw
 r5Xg6Pp0=
X-Gm-Gg: AZFdTZcpsugcPNlV4XeVSQqbB2YgwRFwcHfErk/UmQ4lSL97eClJPd78nUxHPpOQGPc
 lhQEU/OIZm8JEtQ2Exirw5GltLl/gGlm/xnP8nW9rnwQ6qym7P4fSz2S+Mye2TzK4fpdPLivbOj
 L8h+z2T/x6Ky6FX7h5oaLeVePcO5v10lSAtYk2hAD5NAjYEYwbDdcdMoWcgLS9peRzQqbopaXWt
 SnJ4Jkh2tve6S9qje4KPAdQyA/ufBkFJ5qeUvUp2kOQ9iwfEq3WUVcTYdu26H70UdUlE2nzgmaj
 3dMw7EpxYo24TQjr5jtI/ZGnqHC758cdXVb3ebeDK+r6432exTq6SgB2iV7OjUA55D/WHX/5JRb
 ANpKgPypmIB3rpJWwzURaQHY7B1BURd+aaxwOdJ8rtJQflT1PoZRITsIl/qdXNcoTxUDi0KQZg8
 cOOXjTvaTQ+CRaULaVqx6zWzFr2RjhJBklOUi++AU1iJdr9NKKfh5LuxtAXi/t8Pi5l8tLrssxp
 dmLLkpUC33eJy0Csf30zHDkZmU6UMYUAMhAiYUNArveGSxGasOhfYrXGNqpXny5I1vP1HdOZisz
 1tvLSFIWzWERuTKs7AmgKvKl+qzm3jEPFhaskGV4Xxe0fiPm3+RGgh2KNvNU1H/dKXRmc2F06A=
 =
X-Received: by 2002:a17:90a:c2cf:b0:3b0:9310:b255 with SMTP id
 98e67ed59e1d1-3b3abe61aadmr85556a91.36.1794850887213; 
 Mon, 16 Nov 2026 09:41:27 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b2133c5dsm8677124a91.0.2026.11.16.09.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:41:26 -0800 (PST)
Date: Mon, 16 Nov 2026 09:41:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] net/af_packet: fix accidental fanout group ID reuse
Message-ID: <20261116094125.239f7bee@phoenix.local>
In-Reply-To: <20261111104536.248312-1-frank@dressler.pro>
References: <20261110190626.519592-1-frank@dressler.pro>
 <20261111104536.248312-1-frank@dressler.pro>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 10:45:36 +0000
Frank Dressler <frank@dressler.pro> wrote:

> This fix ensures that the queues of an AF_PACKET vdev do not
> accidentally join an already existing fanout group in the same netns.
> Joining such a group would make each member receive only a fraction of
> the packets.
> 
> It sets the PACKET_FANOUT_FLAG_UNIQUEID flag for the first queue which
> asks the kernel to allocate a new, unique fanout group ID, then asks the
> kernel for that queue's fanout configuration which includes this
> generated ID but not the flag anymore (the flag is ephemeral) and then
> uses it for subsequent queues to make them join the same fanout group.
> 
> The bug exists since the PMD's introduction in 2014:
> 
>   # 2014 DPDK:
>   $ git show 364e08f2bb:lib/librte_pmd_af_packet/rte_eth_af_packet.c |
>       grep getpid
>     fanout_arg = (getpid() ^ (*internals)->if_index) & 0xffff;
> 
>   # v26.07:
>   $ git show v26.07:drivers/net/af_packet/rte_eth_af_packet.c |
>       grep getpid
>     return (getpid() ^ if_index) & 0xffff;
> 
> The chance for a collision might look low initially as it requires PIDs
> to be equal mod 65536. But the chance is high for applications running
> in containers having individual pidns but a shared netns, which can be
> the case in a k8s pod, or also with manually started containers, e.g.
> `--network ns:<path>` in Podman. The individual pidns increase the
> chance of different processes having the same PID.
> 
> To quickly reproduce the issue, you can start multiple AF_PACKET DPDK
> applications with qpairs greater than 1, prefixing them with
> `unshare --fork -p` to have each one get the same PID as if they were
> executed in a container. Each one then only receives a fraction of
> the traffic.
> 
> The used UNIQUEID fanout flag is available since Linux v4.12, while DPDK
> currently requires Linux v5.4 or newer. The change is also compatible
> with RHEL 8.
> 
> Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Frank Dressler <frank@dressler.pro>
> ---

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

The commit message is way to long though. Will chop it during merge.
You need to tell you AI to be concise. I have started using multiple
prompts to tell it to not repeat.

The kernel review prompt includes /kslop skill which has:
https://github.com/masoncl/review-prompts/blob/main/kernel/slop-indicators.md

AI even flagged that:


Logic is correct. The kernel clears PACKET_FANOUT_FLAG_UNIQUEID from
the stored group flags after allocating the id, and PACKET_FANOUT
getsockopt returns id | type << 16 | flags << 24, which is exactly
the encoding fanout_add() needs for the later queues to pass the
match->flags/type checks and join. DEFRAG, ROLLOVER and
IGNORE_OUTGOING survive the round trip unchanged.

Info

The commit message is longer than it needs to be. The two git show
transcripts repeat what the Fixes: tag already says; dropping them
and the "This fix ensures" opener would leave something like:

  The fanout group id was derived from (getpid() ^ ifindex), so
  processes in separate pid namespaces sharing a netns (e.g. a k8s
  pod) can pick the same id. Their queues then join one fanout group
  and each process sees only part of the traffic.

  Use PACKET_FANOUT_FLAG_UNIQUEID on the first queue so the kernel
  allocates an unused id, then read it back with getsockopt and use
  it for the remaining queues.

  PACKET_FANOUT_FLAG_UNIQUEID is available since Linux 4.12.

Worth one sentence: this also fixes two af_packet vdevs on the same
interface in one process, which previously shared a group because
pid and ifindex were identical.
