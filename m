Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31603CD98CE
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 21:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C2AF4066B;
	Mon, 15 Jun 2026 23:01:58 +0200 (CEST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47]) by mails.dpdk.org (Postfix) with ESMTP id 341E5402A7
 for <dev@dpdk.org>; Mon, 15 Jun 2026 23:01:56 +0200 (CEST)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6912f4acca4so6702114a12.1
 for <dev@dpdk.org>; Mon, 15 Jun 2026 14:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781557316; cv=none;
 d=google.com; s=arc-20240605;
 b=IHZ+ywL8wJscvH2hnOes7aQLsbI+LLZIP7/KUYkM6ucJnFzv4WEAV13Tx5vnIXds9z
 Dq8LvMAiK5FzTHKL3Z6UaIY2s4hbhTb5Nj/EAT9GHIvLF6msF0fSvC9ibd0rdcuJWGss
 QbyZHi2/oOsf2exySf93M6M1FeyTQVEpcCfKcyn35PW2uxxt39n3gKcW4w09K4uU6WoK
 VCQCwGD0dlCORReL/M4UCxOJrIHDj5fFK/ABtnDq0fQP+oxFLz8WLTQL6Mpswf0MnM0y
 P3JkGTBuasPC1R83tIU7QrOhg5fDbacw0Y2ycKO71fnl4TzbqGPKjWEHiLQmT3yw+tbJ
 RqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GL4daG5fjYaiFHiNGLM6AU7gjmeNITe94G0ldUdux2w=;
 fh=gXuVkZy4DIH1KclIgOOu3nfImmY3eADSFcCnKAnDptE=;
 b=NHKBYR91untyOEK1oJLzHppIWfH/ZunuC2S9M305e1C0AE9SkKyI1+n6/rcnlH/MMn
 no2Vm3Mc33zJP6avpmqejXJIKUTSxDHrNh/h6uoioSYDCMdKdV/qaMVn8y6XqN5U6JQa
 s3fomZcqTbrMtfTci+xZ2rOT+H0ZR35+8DHnmogXNUp/+w2UvIKI4F1FHQD1vREtQxba
 p2YCyX+7kO+NnYcuPWl4nb+zmaQQ0dU122WufA3kLNyR1q2hsqgD6ugIL/gQhDARZgWb
 HyTWgxavRC2HgwFudixOCEsyfxRzvBeMHTq2YFdYdHIyJwFOlUD0c1fTkUucF3K/VlYl
 g6dw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781557316; x=1782162116; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GL4daG5fjYaiFHiNGLM6AU7gjmeNITe94G0ldUdux2w=;
 b=oCNtwDHlI7UPxZB8xtJbWty78jJYL4tymT87Vk5W6WPLXdl+FWXU1Njyt2s52+egB/
 tB3tx2Ivy31hWQSWLeTxdgfoQRYL6aSoWsYr1kd5nShSKDErTkhsxvr4qa5ZIvBx94RD
 9qXwmG4xKzpHU5bkMe8uiHGP/qMv9NHJnbpwO0GFZIXxI/k/7zh2HVeI4TxZ5DGfHElm
 0kRoiAaFduUxRTlR6q5Xw/Rqu2SViW61vyxUPQiFAoih5sjoHIBKxmkn3Yg+QvZWXnRP
 1NVyoJwTSHcSMHpiF2jakLr2l1ktnucTKSgohIz5GAYTujglu5yGLquZYxl2VWXpiyPK
 z6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557316; x=1782162116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GL4daG5fjYaiFHiNGLM6AU7gjmeNITe94G0ldUdux2w=;
 b=LI7JIFCWVbnQ7v22IhamsrG804jmIgI7joITkEWzlYB1H4CWtcn3lEl+4+tsBpEhgM
 fI29jys8osRzr9p5db+WDrgkqItJYUYLS+KleMjillUlROBqAu3UC4Wqrp3gwwy7zyuI
 XrOpwGm99MKxWjKzf89xGg/EU4byLWi6fJmoM/5+sFm0sv5Ei1Ndi3Hs2LyQR0o1QKhP
 YfxjsnB/htaIrx11woJpbaFlS3clXwyeDYxDC5tngpYZtDneoDFDhF90GkCB1bDg5HI4
 w6+ZN3ex762W/3aG54Ipgbgq/t2jgYEVvZ6+WagQD4IWlcFI0TrWZKFfrf/LN7X9VD1J
 b9pA==
X-Gm-Message-State: AOJu0Yzlu4WuPVGRo2outrTMyYhdTN+1UiC03VLEnlndqzHkjKYaSOq0
 5P7eiDtJDMvWV7kokm1BywBu+bkiLX4wRTKgNKNS84E0IdzShiAlsvAM6R4q6hPYwjtC9cM5qZr
 azeVUSFXxUtdgnWwUAQOFAPT5UuNJZdNqN9xvRsDR
X-Gm-Gg: Acq92OFXkSTestJErJ2+/JlEnE1nyr2lNGsZhL26BzrN5ytnYClitprrID7TTTfOXq8
 TRzdeTsC7+hhGlS9iiZ7Qf6RS9zbXgm7KhtWtp9j8eeaajzgb9hVJnDFqrLjGp9Bipi97DO2XA8
 BK10238E5ya1VswKfDh44JxjvEk4PGyHrGzttR2lccxf6hYggKh18sVl78Fm6jEz8uWD05HMwYP
 X8TeJs5Rc21mou6gkHfZdwSCM4Z2Cmt49FZGYZoC+ha6KSCoRQFWvv7Sb0C/8vbBRlLMeRvXPKZ
 peNMWJ3rUfS+qAswolCtP8wrc9KdSGOEGfRZNLqLb8JKHM1c/454Jmhbb+uUjoqB9N4zDqNqVCs
 zytE8YA==
X-Received: by 2002:a17:907:762a:b0:bec:c237:4ec1 with SMTP id
 a640c23a62f3a-bff4a8fbcf6mr404298366b.13.1781557314968; Mon, 15 Jun 2026
 14:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260605213022.2770893-1-blasko@google.com>
 <20260613042300.3760470-1-blasko@google.com>
 <20260615115314.5e2ff054@phoenix.local>
In-Reply-To: <20260615115314.5e2ff054@phoenix.local>
From: Mark Blasko <blasko@google.com>
Date: Mon, 15 Jun 2026 14:01:42 -0700
X-Gm-Features: AVVi8CcZ7kK1y9Kexbx_ZREdAaKZGNqW4vd7MCIbjQ8c4kVesHwzxo5xvR8x4Io
Message-ID: <CANULgnLQ6E-JFEJoB6N5DEcKcFsJ3Vj3qJMmAB=2OvBfbPWKFw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] net/gve: add hardware timestamping support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com
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

That appears to be the AI feedback from V3 (which was addressed in V4).
I also looked at the AI feedback in the mail archive for V4 and it does not
look like there's anything actionable.

Do you have any other feedback for the V4 patches?

On Mon, Jun 15, 2026 at 11:53=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sat, 13 Jun 2026 04:22:33 +0000
> Mark Blasko <blasko@google.com> wrote:
>
> > This patch series introduces support for GVE hardware timestamping
> > on DQO queues. To support concurrent access, a mutex lock is introduced
> > to protect admin queue operations. A mechanism is then added to
> > periodically synchronize the NIC clock via a dedicated control thread,
> > and support is introduced for the read_clock ethdev operation.
> > Finally, the RX datapath is updated to reconstruct full 64-bit
> > timestamps from the 32-bit values in DQO descriptors.
> >
> > ---
>
> AI spotted several issues...
>
> Reviewed the v3 series against current main. Findings on 4/6 and 5/6
> below; patches 1, 2, 3, and 6 look good.
>
> [PATCH v3 4/6] net/gve: add periodic NIC clock synchronization
>
> Warning: gve_read_nic_clock() runs as an rte_alarm callback, i.e. on the
> shared EAL interrupt thread, and calls gve_adminq_report_nic_timestamp()
> -> gve_adminq_kick_and_wait(), which busy-waits via rte_delay_ms() up to
> GVE_MAX_ADMINQ_EVENT_COUNTER_CHECK * GVE_ADMINQ_SLEEP_LEN =3D 100 * 20ms =
=3D
> 2s on an AdminQ timeout (tens of ms in the normal case). Blocking the
> interrupt thread that long stalls link-status/reset detection and every
> other device's interrupt and alarm handling for the whole process. The
> existing gve_check_device_status() alarm only does a single ioread32be(),
> so this is new behavior for the driver. Consider running the periodic
> read off a dedicated control thread, or otherwise bounding the time spent
> on the interrupt thread.
>
> The teardown ordering itself is fine: rte_eal_alarm_cancel() is called
> before gve_free_nic_ts_report(), and its spin-until-not-executing
> semantics catch the self-rescheduled alarm, since the new entry is queued
> during the callback before the dispatcher removes the executing one. No
> use-after-free on the memzone there.
>
> [PATCH v3 5/6] net/gve: support read clock ethdev op
>
> Error: priv->nic_ts_lock is locked before it is initialized. In
> gve_dev_init() the order is:
>
>         err =3D gve_init_priv(priv, false);
>         ...
>         pthread_mutex_init(&priv->nic_ts_lock, &mutexattr);
>
> but gve_init_priv() -> gve_setup_device_resources() ->
> gve_setup_nic_timestamp() calls gve_read_nic_clock() synchronously when
> the device reports NIC-timestamp support, and after this patch
> gve_read_nic_clock() takes priv->nic_ts_lock. So on timestamp-capable
> hardware the first lock runs on an uninitialized mutex, and the later
> pthread_mutex_init() then re-initializes an already-used mutex - both
> undefined behavior. It only appears to work because dev_private is zeroed
> (a zeroed pthread_mutex_t happens to be a valid default mutex on glibc).
> Initialize nic_ts_lock (and the mutexattr) before the gve_init_priv()
> call.
>
> Error: priv->nic_ts_lock is destroyed before the alarm that uses it is
> cancelled. In gve_dev_close():
>
>         pthread_mutex_destroy(&priv->nic_ts_lock);
>         gve_free_queues(dev);
>         gve_teardown_device_resources(priv);    /* cancels gve_read_nic_c=
lock alarm */
>
> The periodic gve_read_nic_clock() alarm is still armed when the mutex is
> destroyed, and that callback locks nic_ts_lock; if it fires in the window
> before gve_teardown_device_resources() cancels it, it locks a destroyed
> mutex. Move the pthread_mutex_destroy(&priv->nic_ts_lock) to after
> gve_teardown_device_resources() returns.
>
> The two 5/6 errors are the same root cause from opposite ends: the
> nic_ts_lock lifetime needs to bracket all its users - initialized before
> the synchronous setup-time read, and destroyed only after the alarm is
> cancelled.
