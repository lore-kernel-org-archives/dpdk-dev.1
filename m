Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A42AC87FC9
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 20:54:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B0A74026A;
	Sat,  2 Aug 2025 22:54:02 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 8222640156
 for <dev@dpdk.org>; Sat,  2 Aug 2025 22:54:01 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso2802879f8f.3
 for <dev@dpdk.org>; Sat, 02 Aug 2025 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754168041;
 x=1754772841; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PLqlrb6qkRz5ksnciZFYTUJWfPPCdDc8sKMLhXiyNE=;
 b=xRq9Cbx4kMHgvmBtuGbys2WUjLKh8gpp1noxRPJWi2yxxCwqaYEMR1eyT5ckKuyVLI
 SGGrRvU3Kg8jS6rMfAjX3OXzco0FwnLQKFxcBMHnAvSHH3QZqcCUB8mYOhkMSXkbWhew
 sTk9bPw4KzWwPvw0DN+fz5IVyiEeYoYJzSeENxZ0+jSBQ3fe3JbCW346xox82CQG8rE7
 8G/c1HTbVdRBWVWqFdZdietnK2rRF8Nl1pA6CFwA0y6TVfytFOYdFM9tf+baCVQw3F20
 czA8o7JOO9WB8vGL0p/pJrt1KJijMy0j5oAKDGuLH3KycODVUv+LI8jWRzdNScLauCSu
 vSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754168041; x=1754772841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PLqlrb6qkRz5ksnciZFYTUJWfPPCdDc8sKMLhXiyNE=;
 b=OVmZrDGHFTtft/rdLfY+foMjeMqCqIXipe6Gy7UfM6zNzzuZCDKCBcY/xSz2HWOhL7
 O2jmIZJoflwCCj3HK78foD6g4rVP3YQ/Ee/uKwecpDeWjZangFJ8TKsqDkByG/QNz1wI
 vRk0EgBXImfCXXwvl8wGQNAlKPx2cLb6c3ZrjDymqewlg3RixF3rRZkc1tlfv0ATDLVA
 m7tOHkYBoy/+rgQjYx8yjAg3bdOLq6/E5YY6D58uoFL5seYTIlknCSyow25negbCdDd9
 wJnkYn5lIenRcOBoj9w9r4gxysKV8qS1xikWfYquv58ABF+At1uE39Av7te+Am72b2vt
 58SQ==
X-Gm-Message-State: AOJu0YzvgyDCOWvQxqUQ2r3r5HMNl2tcFmoWvnr0hSELIDn78RoULn34
 9UREni2gK6E/KJ9zL9Od3npoe9phl+zaz4JnPrfJuKGIQQscI5d0mlQ4qRDHRr8xkhg=
X-Gm-Gg: ASbGncuZSeVFu1ccy9fSt+BN5g3gwBMm5xQsrz68asCiupR0RGu0Wpdpz+tqETrXGzj
 KHkSUdimZ2utEAULH+ZosniNMKzC+pojZJY7URLkx8LA32rxl17FfMrx5NWISNamRAm2ssa2GlH
 4xoJrigUjTyVIeHS0KE6hOUZI8f64pwQdQTE9TlcjiU3NFsouHm2XrxnxDqzlkpM1GOiY9fbBsI
 L8DL8ey0PwsCE7yaa8eIHgnQz5gNBOw+SHPxqFr8Uhm8snpMeITadybHrb0jnA6EkrfITgiB5rT
 Crhu7JJMp/WaZX0PpdIw08tKmTT/OIrC0s4rRxv9txJgqw1ElJ+Pat51XlC1TAv2qZimd8wsqjW
 P6pVOdpFDGnNOyHlDp+4SeVgPS34eRtftIJVnV3FhtloViTOpWxjhRuWIPZ/1nN+7CcBde+0dVi
 Q=
X-Google-Smtp-Source: AGHT+IHDcvrVmrFS7jBp3tEK4DyaZPk51nkyy4HqCobWdrXc7uV9la7EEJIIh9bstzliCDZIJPd0cw==
X-Received: by 2002:a05:6000:2507:b0:3a5:527b:64c6 with SMTP id
 ffacd0b85a97d-3b8d9468c8cmr3371258f8f.1.1754168040488; 
 Sat, 02 Aug 2025 13:54:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b8aab8c0sm37086105e9.19.2025.08.02.13.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 13:54:00 -0700 (PDT)
Date: Sat, 2 Aug 2025 13:53:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] ethdev: Reject conflicting TX offloads configuration
Message-ID: <20250802135354.158d8561@hermes.local>
In-Reply-To: <20250731090731.671589-1-mb@smartsharesystems.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
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

On Thu, 31 Jul 2025 09:07:31 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +		RTE_ETHDEV_LOG_LINE(DEBUG,
> +			"Ethdev port_id=3D%d tx_queue_id=3D%d, Tx offload %s potential confli=
ct with per-port Tx offload %s, "
> +			"runtime support depends on the driver",

Shorten the message, and get it on one line.
When a message is so long it won't fit on one line, it is too verbose.
