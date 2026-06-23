Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89979CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 22:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8503840299;
	Wed, 24 Jun 2026 00:44:26 +0200 (CEST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by mails.dpdk.org (Postfix) with ESMTP id 70CE440293
 for <dev@dpdk.org>; Wed, 24 Jun 2026 00:44:25 +0200 (CEST)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3996c9eeebeso3171921fa.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782254665; cv=none;
 d=google.com; s=arc-20240605;
 b=IQPUwZx14yrVvNoCHeIQ9dqvo+HTMjAL3f5YiW5DmuE20+ooCwcm2CKpjNuhe2Nd6D
 vAahws0ATAAmfFsmtjiRobsjajmKSQkAU6wTcMGLy9upbXxibRQGOyNXzUSdCNTfHX3y
 uO83ZjFuP2iUnXtHtkxoM3emUyf9fFnKs+fXtZB0eGFhu/TaSzupqaAfCTnwiRpKJ/NK
 cPqxYTySFa+KkhWV49IR0f26nekUE1gzF0uhr3a1lhJyhTcV5BghVB5puxEPiSaNewJG
 YEKLnMbFVimxKVB9uSdXgHxIW8o4onMtqNjwP6taoTg1DY80NRLgt/6A1EofBqzrJXZS
 X3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Do7g1R4h2+UsONnI+WGYKFanySRFagTkC2dT4pBQ+O8=;
 fh=V50KIVGK7lASsqoxKiZbaCBQVLUvwhecs5hnpFGAqJs=;
 b=bOc5g3ouZOI44yYOker7K8AUoikaEgx6aKuIOdgGd5UofgNVKMHN1bMUvL78lmeg4p
 56LL1kJPYXkhxM8ZPFDyO2v9kNlPn5LDFLxCcd8fks2EcN5q1+Wp6mM6cIt9a3mHbxsO
 +0aIkmeV0/rQRvd7BrGEQWEcinTyFcfcxuRfnHPGw8r84rSkw4YMun9SA3ErVFhRo/WG
 sUfQ7uIA9m8R+pVR3JKHwzr65rsHDymqV5nYtZemB6vS37bRFTHQkAdKtoJeKz5Eagkw
 ueTQ0QHJJwg7OCVcRd3mGQ93CV20sQ7LhWUAPfNHIMriWMT/ksgcQenvKbSmXy1AfCgq
 RFDw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782254665; x=1782859465; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Do7g1R4h2+UsONnI+WGYKFanySRFagTkC2dT4pBQ+O8=;
 b=ONGGxZjKM7AxgT4V7Z6DBvC2wXB4jUFM1vY8Dr9TiUVZWxRN7S/7gAxd23mhcForr3
 PDQry0mgEeJR2QF1k+UOBHN4EtFjZ8id9x0D95vuk+IyRLYGdh3vHdbhPCiN6HEQwEE1
 wS+VC+z+FtgW/GCy8HBtOL3KFQ2hNSaR/hoqOemH+bv+p/fyRmBV47aFOylKB/8J3RfJ
 Ufm2ZVtbF+7E+KvzU27hBIhjnN7LlNLkMJd/B7aHMHUDnzQJ9ZXU4RbeFVu/yckHHnnJ
 HOC+0IboRl5wICHqBBITZ0iSkw9iaJtqcKAZ1GnzE1pjtY0gzMQ97X47Fg/c4pcBH0UY
 ynKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782254665; x=1782859465;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Do7g1R4h2+UsONnI+WGYKFanySRFagTkC2dT4pBQ+O8=;
 b=gVK54/bRa7hBZF6oQCokv8I7b9cKwC661UGl1LhagU6hjJhhLHfTLR7zAJh9OH0H/H
 5+WjB525PiNsxB1Ejx7Cl6wEc6Ec9qjBSqwHYCpsh4w7OK4GlMGeTmtqaxxb1RMdy2/q
 aZQElwjSPGhwGKVUx4tNr2M09H0HhO25xAf8DKfSy3DUaQgDQoQ7Q6msLsHV5CclvRzb
 ErEVOHnCHUJImAYMc8vIH1UDODYv5nJAC9B8iE+0EfONnmxjWr4WZ6okKItsNL+mTgEl
 svhE1F71IjhOV5xrSOlFoYdU+XcoazES1ODfKj+408Gqk9MPqXtRMIIdG3+nieudtWZT
 4ZZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ83VCOYyzTNBySRVBxYWColNQD0tAUxEPg0wcgmCAvInmQTkWitU1VYgH2T+JpAM49FsOo=@dpdk.org
X-Gm-Message-State: AOJu0YxIfefpwvujefuFKte5J6FNCF+Zu4e72R9+lHUYHKIlt4dkLocV
 /JgsjPHUJGNDDB9xPZga9RC4EMyU2swW1vEo3xEndyaOh4hTKR6pkkXjclo730hGEKyziBpiKnh
 AaaUUEs32ybtsH+2xLSp5cFqNmjQdF1E=
X-Gm-Gg: AfdE7ckGi7J4H4qZTAwLWaArIbs9Hcw6ZVx3n948jmUBDwuiRpTA+Hy0NAUOp6apoOZ
 8CoVqtfBettv2318PuwSHwkB7hQItT9oZhVJ9DqjqPDNk3JaGLKRwRTj4O0NXIHFHse0LiiqLRP
 eTQARcdxg/tAiM4r5I9DFzBzEkbpwJgNrc6hny3DsqITpVWtHlk1DB34RvbUrU0Z14ZnnJeOcg0
 Ar9vNxGWDKZflZOHFFtdfng8tw87IfFM7CM7j3vlQi5dCeohWRsqs4BpKj6o0MyfvLhWTAE6HvP
 0zPA5jKT+RIlaklO3MY8YCYpNWjj9g==
X-Received: by 2002:a05:651c:2115:b0:396:b398:5918 with SMTP id
 38308e7fff4ca-39aba031be9mr1296761fa.1.1782254664607; Tue, 23 Jun 2026
 15:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260428181501.72434-1-abailey@iol.unh.edu>
 <20260513152715.133381-1-abailey@iol.unh.edu>
In-Reply-To: <20260513152715.133381-1-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 23 Jun 2026 18:44:13 -0400
X-Gm-Features: AVVi8CehoFHWHYB1fFL7HuORvkgtnUi0i3h6DETYT5hR8-ja_a3dnPfRD3_IrWk
Message-ID: <CAK6DuxufT4kzQUJj1ii5BPBLBnWZWsgL+TbaQN+VBnO7zHLgMw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dts: update parsing for cryptodev latency
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, lylavoie@iol.unh.edu, 
 ahassick@iol.unh.edu, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000002eedcf0654f380e2"
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

--0000000000002eedcf0654f380e2
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--0000000000002eedcf0654f380e2
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:patrickrobb1997@gmail.com">patrickrobb1997@gmail.com</a>&gt;</div>

--0000000000002eedcf0654f380e2--
