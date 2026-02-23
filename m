Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F75EC1116
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:45:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EEB7402EF;
	Mon, 23 Feb 2026 18:45:25 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id E8A52400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:45:23 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d4c4b494fcso2610944a34.3
 for <dev@dpdk.org>; Mon, 23 Feb 2026 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771868723;
 x=1772473523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgENgI3qP1k45kDEb4b2TYQGFcskMgSVzZwmFKdrzMA=;
 b=gM/4DiH+KA1+Q1QJvL+ydwj/it/NZz1j75zuHQAFyG7yiQHGNAlAJvAWdQibyFFb2U
 I+97zKcUJ0+iMtl0cxZK2sa0MOQoUEyhnX73hSBnjNqSWaqCRQbhtTrSLwwkNxJRI/AE
 PVgUhXlCQIeF1jfpD4Uq1VOVegiICmoIsvvB6rPOZpqyjpdeihWwHD38xW5+b587Fq9v
 qmbnmVmtgbtfccvcH0qZsHw9pxvZJ5pValzlEFV5SFoq9EudXjIcAIvSpzw2wunhZWs2
 YubSI9qWaookxh3PgevBawEvXBZ0FJMxtTGvWRN4rOvfUGlkDmIZ3dUW8DOqkfpB4z9n
 iLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771868723; x=1772473523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RgENgI3qP1k45kDEb4b2TYQGFcskMgSVzZwmFKdrzMA=;
 b=rq5niToDzgpDINsMeQR/hwD9dSjdqclHxdydc5nx/KmvW3Ta2kjNsVfNQLxUxA5YMX
 Tcu2g/18z/jrdMniSbC6p9YM4xq9kFNcpdYkHs+NCBrxXluJUuA281Q2ucuJxdRMViT3
 yLFtOGSpFqkiJoNp3m98zuoIb8Si7LI+Yz5uqTygUyE0BQAzTvTn9MBAq1+Anvlwsd/4
 qiByItlX76CZwVsRv0sBNFk0ASjBgQ0phpl6+ESCWoDNaVHnkhPlwZDnQt0KHEPm1uei
 j4tBXJHOFINJkQyJDlWOdf5Wa5MVQjLmHFpYdvn8tpMITtbDTH+eesXYqSjOHTZ+m8Zz
 fodA==
X-Gm-Message-State: AOJu0YyjDQeFfam9Ijlx41Z9fVjjKzkxKujCoPb3j3/eWxxDe2iYVKQG
 AyycuijfttgEhOliW6p04LTOZKVudX8d7X10kUMp5XmKvdLN5MfZeEdYyoxz6U1UmFY=
X-Gm-Gg: AZuq6aL22KIRpdu9BHLSNn1JFfoW73O0k7TN+U5LL7PLZ3yYefoF3EzlWjr8MdNuC/e
 Fssq7+tCS+90xT2h1izPRXRh7k6irKULasWZFgwPIw3qyA+I9jFg0yxewxgQYdn8oRdOEwkZf6J
 lRkliqb85w9R0kUAxPh6vCW0Khf5wUAdz9eKaclTSg8TBIjHRNxEWhOhA8FpuhiNEzUyXfshps0
 SqcM8ymirScEAm0BBWmEfZN+FCn7GQIhiqFIACSu+fii3cmUt5ZN+Q1MaKVs8U5IvvfCPp0a2xE
 j0MbOMQbDNBW57UjsxSDuEbwFdAW08EUIBcWcfUb1zBMXDFuNT0+xPHaeDFx1XX7N0bFtnUlw+r
 8ZCaOn9T1DlovqKsKp0vM/QvAvbVAgcuxzrZqFIqXQc+ssDwXEQb/7sKnGesNlkbTRCq8Tgr+pT
 EbIUFpxVsKYDCzzbCMsm0IcODJlncz8YgZJd1fK2L+FxV333/KIjoBBj5NSHXM+Yg3
X-Received: by 2002:a05:6830:3bc5:b0:7cf:ccc0:db0a with SMTP id
 46e09a7af769-7d52bf9c73fmr6622132a34.33.1771868723098; 
 Mon, 23 Feb 2026 09:45:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf9f5b9sm7615920a34.8.2026.02.23.09.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:45:22 -0800 (PST)
Date: Mon, 23 Feb 2026 09:45:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linux.microsoft.com
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2 3/8] net/netvsc: add multi-process VF device removal
 support
Message-ID: <20260223094519.5764d5fd@phoenix.local>
In-Reply-To: <20260221024540.659098-3-longli@linux.microsoft.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
 <20260221024540.659098-3-longli@linux.microsoft.com>
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

On Fri, 20 Feb 2026 18:45:22 -0800
longli@linux.microsoft.com wrote:

> From: Long Li <longli@microsoft.com>
>=20
> When a VF device is hot-removed by the primary process, secondary
> processes must be notified to release their references to the VF port.
> Without this, secondary processes retain stale port references leading
> to crashes or undefined behavior when accessing the removed device.
>=20
> This patch adds multi-process communication infrastructure to coordinate
> VF removal across all processes:
>=20
> - Shared memory (netvsc_shared_data) to track secondary process count
> - Multi-process message handlers (NETVSC_MP_REQ_VF_REMOVE) to notify
>   secondaries when primary removes a VF device
> - Secondary handler calls rte_eth_dev_release_port() to cleanly release
>   the VF port in its own process space
> - Primary waits for all secondaries to acknowledge removal before
>   proceeding
>=20
> The implementation uses rte_mp_request_sync() to ensure all secondary
> processes respond within NETVSC_MP_REQ_TIMEOUT_SEC (5 seconds) before
> the primary completes the VF removal sequence.
>=20
> Fixes: 7fc4c0997b04 ("net/netvsc: fix hot adding multiple VF PCI devices")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

AI review feedback:

**Patch 3 (net/netvsc: add multi-process VF device removal support)** =E2=
=80=94 adds MP infrastructure to coordinate VF removal across processes.

**Three concerns:**

1. **Race window on `secondary_cnt` during probe (~50% confidence).** The s=
econdary increments `secondary_cnt` *after* `rte_eth_dev_probing_finish()`,=
 but `netvsc_init_once()` and device setup happen before that. A primary re=
moving a VF during this window sees `secondary_cnt =3D=3D 0`, skips `rte_mp=
_request_sync()`, and the secondary never gets notified =E2=80=94 leaving i=
t with a stale VF port reference.

2. **Misleading "VF is already locked by primary" comment.** In `netvsc_sec=
ondary_handle_device_remove()`, the code reads `hv->vf_ctx.vf_port` from sh=
ared memory with a comment saying the primary's lock protects it. But `rte_=
rwlock_t` is process-local =E2=80=94 it doesn't work cross-process. The act=
ual synchronization comes from the MP message exchange itself (the primary =
sends the message after setting state, the secondary handles it after recei=
ving). The comment should reflect that.

3. **`netvsc_init_once()` not protected by the spinlock.** It's called from=
 `eth_hn_probe()` without `netvsc_shared_data_lock`, while `netvsc_uninit_o=
nce()` is called *inside* the lock. If two netvsc devices probe concurrentl=
y in the same process, the `init_done` flag check could race. Low risk sinc=
e DPDK probe is typically single-threaded, but inconsistent with the uninit=
 path.

**Minor style notes:** `MZ_NETVSC_SHARED_DATA` uses macro-style naming but =
is a `const char *` variable =E2=80=94 could be a `#define` for consistency=
 with `NETVSC_MP_NAME`. The stub `netvsc_mp_primary_handle()` that always r=
eturns 0 is benign but could mask future protocol errors.

**Overall:** Sound infrastructure, suitable for merging with the comment fi=
x and awareness of the probe-time race window.
