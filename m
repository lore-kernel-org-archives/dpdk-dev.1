Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C44606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=NR6A9xG4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C521400D7;
	Wed, 21 Oct 2026 17:09:50 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id B468140041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 17:09:48 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2ea138a3497so5288585ad.2
 for <dev@dpdk.org>; Wed, 21 Oct 2026 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792595388;
 x=1793200188; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gNsPvBpViCMwinRHNK2T15D5vf2jpbFLb1T3TJFLzjY=;
 b=NR6A9xG4P+UY3+X4q3PGzEqKuFZEvukCoxmCMCp4BDtAh/QVLZ0seJvYR2xcLAypLJ
 8aL3oXFvxt25DD8PoHEVeIt/WQcWJBtRRjVk5+wjvUS9hPdN+T4Mb2DMTaxKicrzZFRz
 lPaYtXMH5UVT2DxvjgVNZWTnPTuntV31eTn4vbLkNMliNPgP0TM90owSJBV/tjaaLo5N
 kTDjWYSi83Y5D1EJ0GJj407mRUNnHjEFgQO+fVR8kIscILKiyrIlqCJP11s0A8ouwaDH
 PQ+xJjyBG9nXJJuayfckF93th/k0nhN2vskgL1fAb3xaBoqCVFBce/7+BkXAxgZMDSTg
 9kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792595388; x=1793200188;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gNsPvBpViCMwinRHNK2T15D5vf2jpbFLb1T3TJFLzjY=;
 b=u86x4EEBGi2cV2eS4/G41ANiKyQV8K77Cm788Vg+gI9GRkq5GDjtN5L9QYu272ymSL
 +/eomwN1KXGH6IVkpwlO4dk3KZvCS1DGCZV3uSHaNMrKFNbvxNyMS/e9cIXTV4aVPtgV
 U3Ed/hzr7KJoP6vBcfOINhFqJe/mZ/dWAEpIA1RgK6InLZWNOpZxw4QScCKQBJ4OXXFQ
 /BNyz4etWmAnk/u4rtee827wYnLA17L31YNP44/ltZC6WZvC2spSH19grA5kjVu9coc6
 m+iUGauv3Sh9BtM+JUZn1gcCbraKX0sdysH89177IUN5Q91XnoEZDp8aOpYlQAONdmok
 oYxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwckwIpSxjsW6cE0KKAonm8+d6v5I7uhwbCYWfuJYf/pUDY0wkXHsu0Cd5+TWDs8Js+3dQ=@dpdk.org
X-Gm-Message-State: AFq9FYIqLCxtpgcQiBqMXZL0uVEjKqU32KUv8gNv33jQ67b+JUGH94bQ
 +AAwryHGPYOSLdjrtrTaiutAL8uhqRMJ4bUkZx5aJPyDgfBcbtKl1m5Ehd4jMVlif/I=
X-Gm-Gg: AYBFou08LOFb/vFVQMRo6zJFO53Hu/fZ9rPYNglOGm5gL1E7YM1KIgXnALwFJ5i1eot
 9DqBKumMy6ofmQQjPOodQtIb+4/wVE6Hvqe4zSOWrYxhsR9E2d6ThTLhSaTwTG/9uxUiivTiPs+
 kMG1LgIth+d6s7SH8ozkQsfM5iRPPpgbEw73fwUO0v85a8XiiQ3TDEb0ebWf6jtTpcnOpjDgXxS
 MUyCR91N0Z4gzue7tCx/7BFdaCmIBKMqRl6Hlz66ohF1sHAPijn+wzGrgIO7t8m+1xYhlF1CRm6
 BKoCZgzEggPj23K7RhhO8ySmUMVJIfL7lJj4KJPJMq314sO0HP08C6ubZRydIQpfUXWeiaZDU4O
 liJ2sQ8DNufTM4SXi5DAqWsZb6wN2Gfai7MSWBXgbhI577JbMT//dEye4NrnFmxOsTolJeQOnzA
 KqSUld9kQhNj2T84AVPrfhJfU6fLEDsr7eAQSG8xY6etkOR8UplSRzI1z2najL/KaUY+vQ9B7BH
 0AQdbWofHxIr1wPO74ER5itsGkmQVfYiKFHVK5E1Oo183nNw/CfzrYtTFMN6r7ls0DOfY9pOIup
 cRxgVBqH8Y6bijEBsaKtiw==
X-Received: by 2002:a17:90a:d2ce:b0:3a7:82ef:bcdd with SMTP id
 98e67ed59e1d1-3ad86d9e094mr2128747a91.41.1792595387611; 
 Wed, 21 Oct 2026 08:09:47 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad80303302sm4768968a91.11.2026.10.21.08.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 08:09:47 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:09:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: Marat Khalili <qm2k21@gmail.com>, dev@dpdk.org, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>, Honnappa
 Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: Re: Proposal using RCU for callbacks
Message-ID: <20261021080945.19a6993f@phoenix.local>
In-Reply-To: <163e4df8-ffd1-4f1d-b4ce-b0886f7ee524@yandex.ru>
References: <20261012111324.6db17de9@phoenix.local>
 <332e7685-e72b-48bb-b03d-9cbf71455660@gmail.com>
 <20261012150455.1ea77c99@phoenix.local>
 <163e4df8-ffd1-4f1d-b4ce-b0886f7ee524@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 12:51:11 +0100
Konstantin Ananyev <konstantin.v.ananyev@yandex.ru> wrote:

> In particular, regarding membarrier() - consider using it for BPF CBs
> instead of smb_mb, but decided not to. The main reasons:
> - with membarrier() - all threads in the process will be affected.
>  =C2=A0 Also, AFAIK it is implemented via IPI - which is quite heavy.
> - current smp_mb (at least on modern x86_64) is quite fast
> (it uses lock-ed instruction on thread's stack, and last time I measured =
it,
> takes =C2=AC30-50 cycles). As we usually doing it for a bulk (32+) of pac=
kets,
> the overhead is quite small: 1-1.5 cycle per packet.
>=20
> But again, if you have some smart ideas how to improve our RCU lib with=20
> membarrier() -
> would be really interested to hear.

There is a version in current wireshark extcap patch series.
The membarrier is expensive but only happens when capture is stopped.
We can afford a system call there.

The read side (in callback) is:

static inline void
capture_rcu_enter(unsigned int slot)
{
	struct capture_rcu_reader *r =3D &capture_rcu.reader[slot];
	uint64_t t;

	if (r->depth++ !=3D 0)
		return;

	t =3D rte_atomic_load_explicit(&capture_rcu.token, rte_memory_order_relaxe=
d);
	rte_atomic_store_explicit(&r->ctr, t, rte_memory_order_relaxed);

	/*
	 * The loads that follow must not move above the store of ctr. The
	 * writer forces that on every CPU with membarrier, so no fence is
	 * needed here; capture is refused if membarrier does not work.
	 */
	rte_compiler_barrier();
}

static inline void
capture_rcu_exit(unsigned int slot)
{
	struct capture_rcu_reader *r =3D &capture_rcu.reader[slot];

	if (--r->depth !=3D 0)
		return;

	/* release: prior loads complete before the slot reads idle */
	rte_atomic_store_explicit(&r->ctr, 0, rte_memory_order_release);
}
