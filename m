Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6E8CD8C89
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Jun 2026 18:49:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ED774060B;
	Sun,  7 Jun 2026 20:49:48 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id C41AF402AD
 for <dev@dpdk.org>; Sun,  7 Jun 2026 20:49:46 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137bd9ed2b1so3193218c88.1
 for <dev@dpdk.org>; Sun, 07 Jun 2026 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780858185;
 x=1781462985; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+/TBIahtvwpzBLN7Q4ieGJOFd5HwRu5U0q01mDHt2U=;
 b=WAtlzM3/3OzvK3lfUuE3qS92tpr8BXuQpk/3VdXfDnI0FdLPpR8pOha28e2UyDYH2y
 TPANTdajyTR4cK+SEXVJdrjLi5+q9m6aryo5+yeCPWeWmO1iDBmvlQnvLh8ItLppw91B
 ljOaxWbJOMzFFlHPNual/xeJTnl+Q/Ik41bo75TbuKzCcwKguyDzIdUWFFGDhwbxeLwc
 HicC+eizqE4TwPCsu5IY27J0KEd0s4IovwvIbxOShmXk+m0D1Hd3hcmqw2kc2W33AEfp
 xvvggqnYwuEVp23cMLS2YkD1D4qsy6vRWWASOOQcWn/HDm69PTxis5lyduIjJ/4pwZW4
 WA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780858185; x=1781462985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+/TBIahtvwpzBLN7Q4ieGJOFd5HwRu5U0q01mDHt2U=;
 b=ZeOlFN21D1FSX/obCTQAWOu14M0lJV2GQnOGVmkYVu5lGs4WwkYdj2XryFCQJO6JXk
 zID/Z/bFko8/HYC2St353DPGDK1eNO4RXcznCxrFTeh0Q90XK3wG/hBlQMS06nkR20cV
 6Gf8hJRzEykURDIwMUFE2xf0sFQPSrk8VcN4kVuamxrPtGuqYdvr0S40JQmbTG5IpPW3
 t0Fr5ty8iXsN80OMRWYZyqv99N7C8K6aG0eXqeBK7KjSq3rv4FOn+Fu11Qa//zMLCmtu
 VU9NtgWZbCwHSrxGp08rhYrRQa0Zs8SNiuutDAd9HDMhPKxtGxnNIVkLboUWimpNgfpv
 CjHA==
X-Gm-Message-State: AOJu0YxsU4YRY6zFLcIS3iyLHC7nbaCbCTazfGE2ZaY7dyZQIA0DVzu2
 +OOEkGHSHrmOiOlNp5fjnzkxoOxRUoRMR9H1K0jFtPlodRCNlEkuSI8JYVXfNE6XlT4=
X-Gm-Gg: Acq92OEw5AGwoaVJYUYp391lUPXFTNvODOif79IGdHjOkbFngv1WuAKYerJydtPf62a
 rpqs6EwIx6q8CvHjjTLC2x2UzP66SXkd/6WwyKsriWKsWvYknOA0Lun5Ujuud3PXZcAqjfkUCei
 aDmiQ/KxW24GMkPsVuIXWAKUxlgKG5b0oFN0QHHJq5xkB6+h+iKwmfpzlveSSPWEy/UgbR/q38H
 3T+BqrXimcryeSV7TTh26FjObK/UhIu/dlIXOnFiaUCsfpL8tvocjDeu/tE6IV83VAwp64YRP1e
 y/jLOoD10kw8C0zCieEmVtTmR4Rmc0p/BhCxROKFZSAGIKUvcTVCZ7rwU1sISLQ15pKy39NcRv7
 lEbMzY/BFzvFcCz0Ph8w7csuzUuUwwrbzlXmB0CVnVxnIH0xG2xxCeBnnOmAvZG9NwV8RDGObiX
 1fnFeagOsEIhaWPuK1zgWOVbxbr7DWslD6ZaK60nEhl5aMEi22LrQ2S/JDbJGjFVHysS96p5n1C
 Sk=
X-Received: by 2002:a05:7022:2397:b0:12d:de3e:cbfe with SMTP id
 a92af1059eb24-13806767673mr6764519c88.37.1780858185476; 
 Sun, 07 Jun 2026 11:49:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f548ade9sm10188058c88.2.2026.06.07.11.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 11:49:45 -0700 (PDT)
Date: Sun, 7 Jun 2026 11:49:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] net/gve: add hardware timestamping support
Message-ID: <20260607114942.68c996da@phoenix.local>
In-Reply-To: <20260512005404.946979-1-blasko@google.com>
References: <20260512005404.946979-1-blasko@google.com>
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

On Tue, 12 May 2026 00:53:47 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for GVE hardware timestamping on DQO
> queues. To support concurrent access, a mutex lock is introduced to protect
> admin queue operations. A mechanism is then added to periodically synchronize
> the NIC clock via AdminQ, and support is introduced for the read_clock ethdev
> operation. Finally, the RX datapath is updated to reconstruct full 64-bit
> timestamps from the 32-bit values in DQO descriptors.
> 
> Mark Blasko (6):
>   net/gve: add thread safety to admin queue
>   net/gve: add device option support for HW timestamps
>   net/gve: add AdminQ command for NIC timestamps
>   net/gve: add periodic NIC clock synchronization
>   net/gve: support read clock ethdev op
>   net/gve: reconstruct HW timestamps from DQO
> 
>  .mailmap                               |   1 +
>  doc/guides/nics/features/gve.ini       |   1 +
>  doc/guides/nics/gve.rst                |  18 +++
>  doc/guides/rel_notes/release_26_07.rst |   3 +
>  drivers/net/gve/base/gve_adminq.c      | 127 +++++++++++++++++----
>  drivers/net/gve/base/gve_adminq.h      |  29 +++++
>  drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
>  drivers/net/gve/gve_ethdev.c           | 148 ++++++++++++++++++++++++-
>  drivers/net/gve/gve_ethdev.h           |  39 +++++++
>  drivers/net/gve/gve_rx_dqo.c           |  26 +++++
>  10 files changed, 378 insertions(+), 22 deletions(-)
> 

Reran review with new version..

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
