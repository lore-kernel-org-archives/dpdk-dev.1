Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA4E94623
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:14:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A97B40663;
	Tue, 10 Feb 2026 01:14:03 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 082FC400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:14:02 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-480706554beso37997785e9.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770682441;
 x=1771287241; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oc0RO3rqkUNIgBYiBxPNXg0JZMe4fgKMS6IhNDnerGY=;
 b=P0C5OtJnM7LrxvDPf+HfbmGoL6syPKdDtEU5ZdLiz97N+JqcyP360Jvzbm8yaqxVm3
 UcDyCn2EsNV04pDK7q67odNKfCukwngNngaB6MkBZvNHx1CHq3UwqKfD4O7E+hSNDHHq
 faDEEiRFoO83nMG0RbiVJTDpnHf9rW/4C6zJt7FuSLGaMnU8bQnv2gQNN1SLqB/LioqH
 Ob2C3hxXnzFJ9yYWUAvO5726h5okvMnhhgX7UZ0LkwV4Ki6v9Vg5FpUiRwx/leTI2OiB
 XSGiUI9HKpSFZomdiZqUXYrlvQQCDONAVozLfM7QIzXqGBsQ4l7nh90ecVGzu8JFrCDK
 ijtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770682441; x=1771287241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oc0RO3rqkUNIgBYiBxPNXg0JZMe4fgKMS6IhNDnerGY=;
 b=svrXMTo3T7vAqkMZTFnAcJvPwfyZBw0tFx4eMTNxHPKZ1YGX4otR6PUaEASrd/ZU3u
 FnruMMFkED64GkzXHnnJsScrPd6H/QzLysE2xirbegnv8Zc98jQB63vaPQLijXP0UsmW
 CHnwMUVKZEM7A0u1O89SMjwOXRyDPmSeQnD2Tgrz5MQUHKG/cz1yvyQidjpea4T8+xtR
 z6ZoumisGjA5qvj2nZ/Wj3O7j+zKXhf9hVk50BAwcwiIbl1+K/G12FMVg0ATTGZiJ6fa
 SEifi1TR5qPnubO3NWhKGdeJuFIhDrlynFqgTzoPQQtWgtbPNI0IROYxmscagPKIs2/o
 FWxw==
X-Gm-Message-State: AOJu0YxbxcIeMUN5pIq426b96nIHA6JBdUtaUHlYdm2mIPpyysNXS3xq
 C/VNPDZy7jukF+zLkYi2oEtG/Vk+XhNf5qJ+oqxi3LOo5oePHMmzDY9AFm9E2jusyq4=
X-Gm-Gg: AZuq6aJb6ksup8COQjcELsaqzNOOnxoFMlbc3kEaX2/B40OJGQJ0EKfyqP5CU975/CW
 znzT1ghyBn04EE40mx3VVxdzPeXXE7z3gP2P+C0MZ/018Jp+7mpiV1qHVFvkZNIA+7+BmPLtJXS
 ck6E6ID8weYvdrWAIv1OD9rO2PqmWucBV74gsS/3M98l3JN677Hj8mbipNVgsz1nJJ1BXAP5hQq
 y1ks+zJNVsanuL17J+132gMVPUKw90aPqSYIniYD83gkvbQ4ttGP8MeL8jzjZN4sPSQUGtGYU4p
 BtWl/6l8/WwkTObs26jIqNw5XtlqjYvAyVGYyS4VbsjcKH6Om1BixMSBRNqo8A4z3UXWqLRXYTc
 zcZUlXhhz5PzCK0vyH2oPMeNWy1acQt/PzVksLjkVBoOQ5ynF6NllLjYPxI9u8nVE3vdg9AzJg4
 E6iOiLHWuOz9uL9VLWoGxHwz+RD5K/xpe/mfSWWHwsXQy9Ys0e6KKV48fof8t5x5TJ
X-Received: by 2002:a05:600c:4745:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-483201e4b18mr209559245e9.16.1770682441596; 
 Mon, 09 Feb 2026 16:14:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209eeef0sm98928075e9.20.2026.02.09.16.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:14:00 -0800 (PST)
Date: Mon, 9 Feb 2026 16:13:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, techboard@dpdk.org, Bruce Richardson
 <bruce.richardson@intel.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, stable@dpdk.org
Subject: Re: [PATCH] ethdev: fix mbuf fast release requirements description
Message-ID: <20260209161355.60d28743@phoenix.local>
In-Reply-To: <20260205092848.36435-1-mb@smartsharesystems.com>
References: <20260205092848.36435-1-mb@smartsharesystems.com>
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

On Thu,  5 Feb 2026 09:28:48 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> It was unclear if mbuf fast release could support segmented packets, or if
> mbuf fast release required non-segmented packets.
> This has now been investigated in detail, and it was concluded that
> segmented packets can be supported with mbuf fast release still achieving
> the enhanced performance.
> So the description of the mbuf fast release Tx offload flag was fixed.
>=20
> Furthermore, the general descriptions of the Rx and Tx offloads were
> improved, to reflect that they are not only for device capability
> reporting, but also for device and queue configuration purposes.
>=20
> NB: If a driver does not support segmented packets with mbuf fast release,
> it can check the multi segment send flag when selecting transmit function.
>=20
> Fixes: 55624173bacb ("mbuf: add raw free and alloc bulk functions")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

Queued to next-net
