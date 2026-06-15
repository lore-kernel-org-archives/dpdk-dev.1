Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB633CD98CF
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 18:53:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2240E40B9F;
	Mon, 15 Jun 2026 20:53:19 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 1FE4E400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 20:53:18 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137335bc3caso4350166c88.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781549597;
 x=1782154397; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7FIBFXTjifFwgIRIDnPUyZO7XX1tvXqxh7Yemjk89k=;
 b=sALUkpyXeOQpwlm/u0zQDHk7lQEekyn9/OvALa29bLRR+o137OMuUWS2u4/a/4d289
 2CS5YU61PGXW4twS7Qeo+D4fJ7WIg1sNjTp+vkJ0p1ZrMJ5zeDLQ1Crvlz0oUp4y+O0D
 O3r+ZNoor1n0QvIMm4c4FLLx2UFSaaOtZIdAha4mipoFfZoEVNAJVa5SwbZ4oNJ5OOD1
 X0NvIlsupUgnYJRzBAcuj3p3uWXbV3RL5O3dELEmUKSa/9+JQqb0qCzvcdOewDkaVvKn
 KVPfEUAIycUFgKstq4XZ7RMU4FRroD9oPBjAmQ449O3xxqNjJHt8PhqlfGxo1DU1kio4
 i1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549597; x=1782154397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O7FIBFXTjifFwgIRIDnPUyZO7XX1tvXqxh7Yemjk89k=;
 b=Bi5k54VY8BITt3RMwVQrzqKER+cg7yyJTlbpp4b8AeWZUiGAws6HXLvHXhYFfu3oe2
 Pf6PdgLKvNKcWs+mDFT9b8LH43Q2nyx/OMIExHKaENQmfccDc4NOL8SJ9cRVnUGd+hyT
 f1Gk+yxAZx3TyJj16YU5AKueykx58ypyupCOpNq1U50bmyM6MkrR44Bj+Qds4Y/GZdeN
 FeL+3K7cPwTcfELoe6O7MFV1iJhCAhPEOm1vO8Ts2s944USpUWh+7WQljnWoF0ZuWzgV
 MfeZ1Jo3Yy2W4oVPdlYzTlGI8zYK9jONVPHnGThXhTiz+5Sgq9OK90ZWmqgpwnTttQzl
 m2xQ==
X-Gm-Message-State: AOJu0YwCrGCDe2XT4OeRQ/ayq3I/wqI8Fgz1mzUVVujtACT1j353h2eA
 3DJe0i3IisYxvy1Eq4+SOAgSt2swWVphQRe4E5GE44Lp8YjPC2Nedmeypw/B6FeuSmM=
X-Gm-Gg: Acq92OExOhW1PtUg8NDaAUmqIlJPIc7Qqa3oJqhm/a5fYrGd73CFSJL7M0zLbwJjPL1
 8YhTA1bGg/uRps6MH4FTA0s7pqszU5lQvDWe3+dqHWkwCTPgwvlowwZ25CjNhEPu0brE7zk7HAt
 Kjr3xgOi5LTvEsSCG4vlO5RkCXL5zS12nd2V9dECEd1oLf+lyVbYUowxnEDVFV3LCDyDCYG0Uwf
 8btFno8eTSRboPVj7+bPvec3vqw7aNCw/70iJwljZIWb8GlowFJHdMZkFaXiCE/dMEdwe1O9tar
 3XCY1LVIOUFmg6XvGmsDF7sBUUrOfg/00QljNY20d8169qVkRxIt4Kfe5Ea64s9drZ6UqKF1lPT
 XSHXErGDh1df8u5PLdzk80yvklA7L93MbxdYrTZRp9AC759hG0K2h1bMrbi4zV7QIera574+Car
 2M84GqF2pi+NKv2qqm5w6DuNfHisK36LTYo7HX/64gJ8ytUNT3G2wWiWP+2bulb2TV
X-Received: by 2002:a05:7022:2585:b0:137:9ee5:208d with SMTP id
 a92af1059eb24-13985f45c3bmr143469c88.33.1781549596971; 
 Mon, 15 Jun 2026 11:53:16 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b9110d3sm11609193c88.5.2026.06.15.11.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:53:16 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:53:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com
Subject: Re: [PATCH v4 0/6] net/gve: add hardware timestamping support
Message-ID: <20260615115314.5e2ff054@phoenix.local>
In-Reply-To: <20260613042300.3760470-1-blasko@google.com>
References: <20260605213022.2770893-1-blasko@google.com>
 <20260613042300.3760470-1-blasko@google.com>
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

On Sat, 13 Jun 2026 04:22:33 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for GVE hardware timestamping
> on DQO queues. To support concurrent access, a mutex lock is introduced
> to protect admin queue operations. A mechanism is then added to
> periodically synchronize the NIC clock via a dedicated control thread,
> and support is introduced for the read_clock ethdev operation.
> Finally, the RX datapath is updated to reconstruct full 64-bit
> timestamps from the 32-bit values in DQO descriptors.
> 
> ---

AI spotted several issues...

Reviewed the v3 series against current main. Findings on 4/6 and 5/6
below; patches 1, 2, 3, and 6 look good.

[PATCH v3 4/6] net/gve: add periodic NIC clock synchronization

Warning: gve_read_nic_clock() runs as an rte_alarm callback, i.e. on the
shared EAL interrupt thread, and calls gve_adminq_report_nic_timestamp()
-> gve_adminq_kick_and_wait(), which busy-waits via rte_delay_ms() up to
GVE_MAX_ADMINQ_EVENT_COUNTER_CHECK * GVE_ADMINQ_SLEEP_LEN = 100 * 20ms =
2s on an AdminQ timeout (tens of ms in the normal case). Blocking the
interrupt thread that long stalls link-status/reset detection and every
other device's interrupt and alarm handling for the whole process. The
existing gve_check_device_status() alarm only does a single ioread32be(),
so this is new behavior for the driver. Consider running the periodic
read off a dedicated control thread, or otherwise bounding the time spent
on the interrupt thread.

The teardown ordering itself is fine: rte_eal_alarm_cancel() is called
before gve_free_nic_ts_report(), and its spin-until-not-executing
semantics catch the self-rescheduled alarm, since the new entry is queued
during the callback before the dispatcher removes the executing one. No
use-after-free on the memzone there.

[PATCH v3 5/6] net/gve: support read clock ethdev op

Error: priv->nic_ts_lock is locked before it is initialized. In
gve_dev_init() the order is:

	err = gve_init_priv(priv, false);
	...
	pthread_mutex_init(&priv->nic_ts_lock, &mutexattr);

but gve_init_priv() -> gve_setup_device_resources() ->
gve_setup_nic_timestamp() calls gve_read_nic_clock() synchronously when
the device reports NIC-timestamp support, and after this patch
gve_read_nic_clock() takes priv->nic_ts_lock. So on timestamp-capable
hardware the first lock runs on an uninitialized mutex, and the later
pthread_mutex_init() then re-initializes an already-used mutex - both
undefined behavior. It only appears to work because dev_private is zeroed
(a zeroed pthread_mutex_t happens to be a valid default mutex on glibc).
Initialize nic_ts_lock (and the mutexattr) before the gve_init_priv()
call.

Error: priv->nic_ts_lock is destroyed before the alarm that uses it is
cancelled. In gve_dev_close():

	pthread_mutex_destroy(&priv->nic_ts_lock);
	gve_free_queues(dev);
	gve_teardown_device_resources(priv);	/* cancels gve_read_nic_clock alarm */

The periodic gve_read_nic_clock() alarm is still armed when the mutex is
destroyed, and that callback locks nic_ts_lock; if it fires in the window
before gve_teardown_device_resources() cancels it, it locks a destroyed
mutex. Move the pthread_mutex_destroy(&priv->nic_ts_lock) to after
gve_teardown_device_resources() returns.

The two 5/6 errors are the same root cause from opposite ends: the
nic_ts_lock lifetime needs to bracket all its users - initialized before
the synchronous setup-time read, and destroyed only after the alarm is
cancelled.
