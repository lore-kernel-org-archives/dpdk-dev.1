Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E203CCD98CE
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 21:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD82540666;
	Mon, 15 Jun 2026 23:29:33 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id BC39F402F1
 for <dev@dpdk.org>; Mon, 15 Jun 2026 23:29:32 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30759632453so5578975eec.1
 for <dev@dpdk.org>; Mon, 15 Jun 2026 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781558971;
 x=1782163771; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1pOfD14VKhVOaSiUjQFTiIbwSd3D/SWNWV4bPP0fjE=;
 b=eUISCYObIppgKkGMoNC+RYdCQJtl6p59XG/cVBH/CCrq7JDVPEz7UxkMpyhalFVfe3
 0cLIKGE3cKypsVLokpJcKjlBwH0Gs5OgyacdC944fjzLR8wLWinXFfKMoKOEyoshuUDb
 lSsdfBSLEVtYVpoyIIh2/eaWua24OZm3Lzqp8DQt6PzbbHbzze5TpRbMNj7CPVsVKeeo
 QPJ38mpXYiEAfPyORmqPpMcRNrLQdLkv7SL7+WGDVgEJKE58LNUcURmdNO7G7BJY5ZtT
 I2FGZSt0u7qiNLweFU9lJ/Khw5Qzh8uYTK/HHQP/QexunSyy676x4xGYAmiaV5PfqSrI
 QjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781558971; x=1782163771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F1pOfD14VKhVOaSiUjQFTiIbwSd3D/SWNWV4bPP0fjE=;
 b=rn28XEGn8FCUoPztAFW6Eu2vzA1tux1EMT/moxMCGEtk72sqfoTs2LFM0u/ruw800V
 hL1wBJgpzKV3yoQGO4wESk7TmIuBvaYV/UtEX3AoLwaENXB+7DVngp6v1AFp4qT6+Pjt
 ZiK0kBHrfq3C2RIs3F9URmCGL69JYsmyZRYCIZ1eugJvCy3qzyAResIN8Tk/OqMNPhgB
 suakhCSSw0nwBUHUkl2kNhcrhHoXWe4zDnO40yMRN9nDQUrwKp7+B+jNVwNNUT/DeZoA
 LcycqmvTpCsXGaCbmnAO3dRTDEgRDy/LnubNnT844zMV5PDouWslxgnjXcVhKAdPGrVE
 Ydug==
X-Gm-Message-State: AOJu0Yw2IL14y1tXDC38JOerwwhPE6qCcWIIpRGxs7vUg8G5O7rggYcN
 VPy6jrs3psw/7Ypz/6/PsCgslpgYKWjigALblUC0ZGInSO0iaQgWcBHebJOvXdtKUYg=
X-Gm-Gg: Acq92OFLUyqmDo3AbnWDgQ86onuvrJXLYMk83qI5RbONHmztvFonZ3TJz8k+ni3J0ZE
 GOS6OUbLe7EJjui4rdYxXH42B3XvpD/lGqBINi03QwA6vNfSuJQ+lyD5G+dgZk6HduUzAytG6Kh
 w92USnzwhratEJdqdXK9RN5Sv8Z+t6cHqdgjSXRNpu/OGICuNBJ9L4ootL0OtXPfiUQ5vUslJId
 JYDoeKwkcbK4qjD8eQnQfGlh6RI+iWCflCq38jZO8gocK3s19NmqxS/+bXSTNJ8R2DgMjR3U2YU
 ZX9hCzj3mk3jzSikxvVMaGrFlv6xCOqCaRRuuQ0DMi3DbVkKDk3r4pmPfqnulCP+YjuGXvjA33d
 TmVXni5HIUOeNdiyy/s2u7phmMUEqwYz4EUJW821iDhMF7tFJ4zn9XZc81GVYEEMu1XQNq7rVXr
 UyAqwN1Ca3WZudWJS5+PCkNfozn8qEFMO88adCKZCFrmdvHGdHu7fIUFZxBGa0gkbO
X-Received: by 2002:a05:7300:2148:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-3081ff91132mr10809668eec.8.1781558971386; 
 Mon, 15 Jun 2026 14:29:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95342sm16480947eec.29.2026.06.15.14.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 14:29:31 -0700 (PDT)
Date: Mon, 15 Jun 2026 14:29:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com
Subject: Re: [PATCH v4 0/6] net/gve: add hardware timestamping support
Message-ID: <20260615142927.525f01dd@phoenix.local>
In-Reply-To: <CANULgnLQ6E-JFEJoB6N5DEcKcFsJ3Vj3qJMmAB=2OvBfbPWKFw@mail.gmail.com>
References: <20260605213022.2770893-1-blasko@google.com>
 <20260613042300.3760470-1-blasko@google.com>
 <20260615115314.5e2ff054@phoenix.local>
 <CANULgnLQ6E-JFEJoB6N5DEcKcFsJ3Vj3qJMmAB=2OvBfbPWKFw@mail.gmail.com>
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

On Mon, 15 Jun 2026 14:01:42 -0700
Mark Blasko <blasko@google.com> wrote:

> That appears to be the AI feedback from V3 (which was addressed in V4).
> I also looked at the AI feedback in the mail archive for V4 and it does not
> look like there's anything actionable.
> 
> Do you have any other feedback for the V4 patches?

Let me re-run it.

Sorry got wrong part of long AI thread.

Re-reviewed v4 against current main. The two correctness errors and the
interrupt-thread warning from v3 are all resolved:

  - 4/6: the periodic read now runs on a dedicated control thread via
    rte_thread_create_internal_control(), sleeping in 10ms increments
    with a relaxed stop flag, instead of blocking the shared EAL
    interrupt thread. Teardown sets the stop flag, joins the thread,
    then frees the memzone, so the join keeps the thread off the freed
    memzone. Good.

  - 5/6: nic_ts_lock is now initialized before gve_init_priv() (so the
    setup-time gve_read_nic_clock() locks an initialized mutex) and
    destroyed only after gve_teardown_device_resources() has joined the
    sync thread. Both ordering bugs are fixed, and the gve_init_priv()
    failure path destroys both mutexes correctly.

One item remains:

[PATCH v4 4/6] net/gve: add periodic NIC clock synchronization

Warning: the commit message body still describes the old implementation.
It says the sync "runs every 250ms using rte_alarm" and "the alarm is
still rescheduled", but the code no longer uses rte_alarm - it is a
dedicated control thread (gve_nic_ts_thread) that polls with
rte_delay_us_sleep() and a stop flag. The v4 changelog notes the switch,
but the commit message body itself was not updated. Please reword it to
match the thread-based implementation.

Patches 1, 2, 3, 5, and 6 look good. With the 4/6 commit message
corrected, the series is ready.
