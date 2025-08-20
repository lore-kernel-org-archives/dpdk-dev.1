Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D88CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 18:44:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85D62402B1;
	Wed, 20 Aug 2025 20:44:00 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 6E73440292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 20:43:59 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b916fda762so602182f8f.0
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755715439;
 x=1756320239; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Tw2kX/JiehCgJaiv1qilUaRQ46VjyfDe/GT9a2No3U=;
 b=AEb/Be7ND1bSrmryAZbUd8ssMMaSqrc3gNgF02+4LiMwDtDI3heRGohlgE1Yk+Bqm8
 xpV1pVoMXM8U/sOJqMTaH2ZCxho5uxXtN9ZcbgRXzfq6scGmu/k4NqMgaLqwbNP2n8Gz
 MCO+FC8U34A3eMZrB5eMe+ksPuRTMqwczRReUanMKgpN+jPg9QBR1gUKRtAuWh2XzhLX
 LU5SS/0tUUYeRZy/nWbR/uyY2r6NDtkeV97+FPmBfcmy3caa+eeVwU8Pimj9+9cFB0Tg
 n7rTdLJgU0PjrwM3JJibouwe24aPdkgBB5ohh6tCjRZ/hxB60kzre4PlW2ENE5y7mRg+
 LcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755715439; x=1756320239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Tw2kX/JiehCgJaiv1qilUaRQ46VjyfDe/GT9a2No3U=;
 b=SKWUhQXPhOMWmBgnuOBq64GETAIh3erIlT+DsNUXc9rmXY+/nw3604UAzmX2P812C8
 z15RCf8/7l4e5iIgZTlVeTtr6Qgl3QbQtvyhADFeR4OOaQFqh13RR+ABEiJCacYPd4zN
 Hq2k6i3wdAPVda0IxAxIqZk1SeH/9qeq5XRHMOjzivEnxwf6GspTRTQOEmVg6YXcIjy6
 8immt+56MDbaany/H5fQmllQLred7AzP6l+cjqhgh5ySqJeuZa0xB9EqkYftpDrjEnIp
 LEgRBmcoe+FPGbrtvu56pjOp7LHJDV71hJF09CWouqqnKwUMFi6WCWgl0jTAeUzYScsg
 PAng==
X-Gm-Message-State: AOJu0YyTOu/V/I4EoD2DMjXC+vSGztkengDtJ5D6aJPTz93+/JBJtYsD
 +f2oFewJfAIyJENYrmUEUcM8KHp+VIXGN+EAVyVX7olCVU4l7DOOWOWmbzVJx+x7dderGsb5EPq
 WC/yKZYk=
X-Gm-Gg: ASbGncvn4kFrrgpS82bWHhZkBtp8ZN+hL6NWPDJPMTK9NmWfxm3HJ3xBZeraKVO473e
 HBxJnhRO6mdpcWEkxAAdc5r4Au6BdXMkASyz6dOT4rTJKJmo8LG5VQAgbIGGC1xLUvsdPUw9/KG
 Cm1apr6u9h9onVGzbmzDXRwLHyw1LQFnf8M/ap0TiPsoIzXJ4FPBNHg+x4kHxWtwH53SJhe25U6
 t2/FjggqNeeDPFFbU1+oBoQ1WRTCeHGnDplnRCEf2DEWWp5GhIJqqsrc9eY6ob7T0Hh2GeKTiVq
 D7hmVTpA77flaEhVbSmPROPL4i4du1/lKr2snHcPs/VjWIi+GR+aaGi84j0z7MtgFvufqsgKzLq
 Sm5ddGzRKtB8d57/4jN9bNKJvl0xEW8GIikzQnIeOVCRprmhSGrPLFMTZ0ENNt9ym526DiyqBpr
 w=
X-Google-Smtp-Source: AGHT+IHn6awf6uaqTq+7gbBWDU6VslVS/aYoMxAXVvLo49oCOEp7i01moD4t3348SPQYpUpGDW0E/A==
X-Received: by 2002:a05:6000:2903:b0:3b7:8ed8:1c80 with SMTP id
 ffacd0b85a97d-3c45e6324a7mr511561f8f.3.1755715438850; 
 Wed, 20 Aug 2025 11:43:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47caca5bsm45577185e9.22.2025.08.20.11.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 11:43:58 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:43:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] ethdev: hide internal ethtool symbol
Message-ID: <20250820114354.6193025f@hermes.local>
In-Reply-To: <20250820084147.1253706-1-david.marchand@redhat.com>
References: <20250820084147.1253706-1-david.marchand@redhat.com>
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

On Wed, 20 Aug 2025 10:41:46 +0200
David Marchand <david.marchand@redhat.com> wrote:

> No code call this symbol out of ethdev, remove it from exported symbols
> and rename it.
> 
> Note: there is nothing particularly wrong with exporting this symbol.
> It is just unneeded, and this symbol referencing a linux kernel enum
> triggers a abidiff warning in the RHEL CI when this enum gets updated.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Queued in next-net
