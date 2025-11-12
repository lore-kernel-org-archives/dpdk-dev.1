Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2640BCD4F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 23:06:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BFA440267;
	Thu, 13 Nov 2025 00:06:15 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 0F37640151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 00:06:13 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-bbbc58451a3so109971a12.0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 15:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762988773;
 x=1763593573; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HxPsqZWQU7g7z5AZdR7AoHPxCN57sjgovRsTelHHhw=;
 b=cvBjwPalkIuCOrq/yzg3oXcEtsO24krY/uhi2ss2uHqRcbhdvf/062TtdXPqm0Xw4v
 yGp1JPOVkdRemNQ0uAp4CxWlDISGycI59CCN5pBs30Yfk79hyCqs0p9wk9TE/0uN2opj
 jmiGrnadh0IKLrCbaMMBQ6E+2neSIYmAJl5eFx2Izccp0S48BBSejNlu1va/6+KdAXSu
 spZV3Qu+DxLJCjWw4kcSM97o0g+fjxUUVqD9DhcIHjspVxVfxuX6bYqyKjhSdV8Zw/0M
 xsTAGKq9WrOSvv5pQuV4KpdV4FZjG3lULKscC8CeD/hbNOnidcbYmsTEYWF0ydY4Lj1d
 B96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762988773; x=1763593573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7HxPsqZWQU7g7z5AZdR7AoHPxCN57sjgovRsTelHHhw=;
 b=cvC0oGIUQ7mIfuwIYyV2nT8BTZhyxk1Ti7tPE9O6kz9IB1o6Yn8ecnjMq5YeLfDMDS
 gX/RIq4mttWYXjXFv6VWgqjEgioNPc+SqVP1dEzFrNplBN8IU/9xDaEpY0MGpEsa6ti8
 5kR//6i/Y+WBS6cEKgbXhk+yOWlF9vhSv0KyKjDJmdI7oHJX6moMrWOdJCygp0R9ftYE
 gPMrz/Av4FL5R6du0arnVYVf2s9nA+EZXTCIYsoA8CZFe5kac3Lxe545pjU1dOm9BJ0I
 eAIBCz8SEhhxvFDhSEh9MfDXxqTR4BVq8T7B7ZarN2cCaHlZ4+TcLDzVwQgBmqTZG4t9
 FIkA==
X-Gm-Message-State: AOJu0Yzrj+aQsEsRYBhpZD4+H6SjsjCOAnHGG1VeHtXJv5ibXi2A7kjE
 tEU9NIBc9idwa6BPI6PHEPnssBzQJvO01AxxL+q2R99ygzvC7eGSoeMKTWF/czCpVEM=
X-Gm-Gg: ASbGncsd4epgq+nKojpUQ45gSwrLxtSAzoDiYP6EQhAb8Ve9KCErBe8+AvA+OZ0NvrT
 vm4JOqGu132MHJjmoEB3jzFGImMdlw0MqO8ES4cg6J04P9VCs8LJ8vvNg5d9WefF8lRGtKb4jR5
 UZgnKDDJtCrT5X23L8rUqdmNEqEEIPWRzR/N60j1z2LHHBWEaZgWDos1XqlepXmYCqr5k4h2Evu
 pxp7N30xR9mBHmgXLLzvgMXpFlQ8iBqAFzs2HfOgzLD87D7T1Gcmaj9Ps2e5RW5/3LtSASRvT0O
 OikJbyj/PZuGtO51TUUfCMfu8SshS6B9UbHeXXu3sRoIK8jq2cy0+GuZtyfpe8T6boZrXxaIvLF
 dFgVF4y+AThxqH3josnIzKGFRQf5+pFS+BiqfpoHueBYNyQ/5VIBeVGzxnFivhKUKc91cB7L94+
 5t92ZOMCNJll/Bj39zg9qWHF9HBTVqcjnaQw==
X-Google-Smtp-Source: AGHT+IH8lcXfzwMmv+u9+6YhQfL5LNtFa1O9haEk48alWMyPdS5Op3m9rCTgQur4OdsDGp6YAqw6MA==
X-Received: by 2002:a17:903:22c2:b0:295:551b:4654 with SMTP id
 d9443c01a7336-2984ed3706emr65019435ad.23.1762988772990; 
 Wed, 12 Nov 2025 15:06:12 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2bed23sm2579825ad.87.2025.11.12.15.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 15:06:12 -0800 (PST)
Date: Wed, 12 Nov 2025 15:06:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, sachin.saxena@nxp.com, stable@dpdk.org
Subject: Re: [PATCH 1/3] net/dpaa2: fix duplicate calling of dpaa2 dev close
Message-ID: <20251112150610.067740e6@phoenix>
In-Reply-To: <20251106163807.201451-1-hemant.agrawal@nxp.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
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

On Thu,  6 Nov 2025 22:08:05 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> When rte_eth_dev_close() is called, it performs the following actions:
>=20
> Calls dev->dev_ops->dev_close(), which in this case is dpaa2_dev_close().
> Then calls rte_eth_dev_release_port(), which releases all device data
> and sets dev->data to NULL.
>=20
> Later, when rte_dev_remove() is called, the FSLMC bus invokes
> dev->remove() =E2=80=94 that is, rte_dpaa2_remove().
> However, rte_dpaa2_remove() calls dpaa2_dev_close() again. Since dev->data
> was already set to NULL by the previous call, this second invocation
> causes a crash.
>=20
> Fixes: 5964d36a2904 ("net/dpaa2: release port upon close")
> Cc: sachin.saxena@nxp.com
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>

Not merging this now, because of the feedback about how this driver
is interacting with bus. Either need an ACK or new version.
