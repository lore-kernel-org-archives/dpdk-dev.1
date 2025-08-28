Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F77C8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 14:55:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F5954025A;
	Thu, 28 Aug 2025 16:55:53 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 9F57F4025A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 16:55:51 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3c79f0a606fso656115f8f.0
 for <dev@dpdk.org>; Thu, 28 Aug 2025 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756392951;
 x=1756997751; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miPatUMO+zIUidoi6IziVs0yjVkquK7EIxNiZlG0CXs=;
 b=mWpcs7fI6RBmuPkLIN5yJCVnvAkFkcLQTEsLG+kKgnTB2zPksim45f9VJSubOcakpG
 zCLeL5dY0ARmkdj+nDjuEbO7wX3EJCRr0mfgvsIK0XgSqywWpSNa0dd16I4QWqKKde89
 DCtQDoJEdtoDn0lObZx03Nib2SSvtsSm5xATAj2s2nvO0cwdPf2/EGRDR0R6LY3yA5XL
 vsC7DIa2FD0rCULIrxujpKXJYFCadAEBS8xl1vOLq0En0kDiz8v46TySyxNzU0xOpNiI
 fOtiZGOdXqQLFXMYN5KaliKhazsVgYmZXaP1zWUbH9J7Wti59lHALu6XLFcOgzaofjkJ
 5RjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392951; x=1756997751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miPatUMO+zIUidoi6IziVs0yjVkquK7EIxNiZlG0CXs=;
 b=IYbk+40kEQpXfge9RQkGAQuUUzUcuqKTezkAmAtNKN9GALXXDBenTbaY0zjuuTS5g6
 rtX7TeNARvO9uAa0W9hx2A/Wq2TMq3UiXrTs9kIlTM5mx6LEXslLmagQ8E5P5qJoOcMF
 wkeqMJ/9gTJHoVgwaPSCavTBu9i4YpeZ6sZ3rO3wyAbUGJByndZX04gM9mFUrMIZ9cS6
 WdR1MOzTr0eNWvPeZ1rekEhrUozh8Nvz2dWlqf/MylvC991qokqeWuDLIyp0Rwk2E0aj
 Z+h6EEmEFz2/keAz/EqOEeb0CMaUZTiI2hjQ6/ND3IS/PAx2p8IsrID03y3lYU7tIPFT
 6Fmw==
X-Gm-Message-State: AOJu0YyP4JcVYF7qtdLOF6K47B9t//E4JLcvF3jLuuj0Qv2PYYDOBsSi
 zoFbSRq7wIbwO/3iIiZMYZZs0ywklAT8iSVOWfYGDn92XCh8q24GTJImpc/WzlkC77Y=
X-Gm-Gg: ASbGncuLO+8foeS3ebvFKt3Dpodic0jvLiv6a/KI6xFS8BFX16oz/kfKy12Glqfd4mZ
 0xOvxcPHWS0iiz0fKYacxW5jCsqlagou9sy/23edIwlpveez1KiGT3B+w9mRVwu+iafNkLanxlo
 urJyyBIp+CKmCcn22uI/5tOJ7Xr4FSqk6nr7+ZRA0ilGltSXABtdyfYwo8ovSfJEa20gcCCDlJy
 T8+lRdTtQqf02qhYExSvTkE3Kvw4srKn3ND7eum2CBwIEaEwwaKKdhnPZPlIND+v6nlyWKjs9SU
 B6IBYh/kXqyv+nV0UXT5vAy2HgdUupxD1XpTE76BeLTrto9vNMVMfwWJ81J24mBl7J1popTgFH0
 Ur/0Ofa+QfILlD7jY8NJo73o1nVPCbpNhJWYCNs4lck/Fp7tHzF1LhiNSBXYoqOMcYu4cx2ibvc
 dnrf22wgdMSg==
X-Google-Smtp-Source: AGHT+IGKo0T0X/GF2qFQfeXQrPwVGTrZV1DCcUdqQyB4J3e2pMnY2rG6Bub+6Yu8Pd490Rvea5vOLw==
X-Received: by 2002:a05:6000:2408:b0:3ca:8b32:e43d with SMTP id
 ffacd0b85a97d-3ca8b32e8c6mr8924681f8f.1.1756392951167; 
 Thu, 28 Aug 2025 07:55:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66c383b1sm59405935e9.3.2025.08.28.07.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:55:50 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:55:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/ice: make link state configurable on device stop
Message-ID: <20250828075547.1fe99122@hermes.local>
In-Reply-To: <20250828102305.1522036-1-ciara.loftus@intel.com>
References: <20250828102305.1522036-1-ciara.loftus@intel.com>
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

On Thu, 28 Aug 2025 10:23:05 +0000
Ciara Loftus <ciara.loftus@intel.com> wrote:

> Introduce the boolean restore_link_state devarg for the ice driver. When
> set, when the ice port is stopped, the physical link will be restored to
> the state it was in when the device was started.
> 
> Prior to this patch the default behaviour was to always restore the link
> to its original state. The new default behaiour is to always bring the
> link down, which is in keeping with most other drivers.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Device specific devargs should be discouraged. Seems like the same
issue occurs across multiple drivers.
