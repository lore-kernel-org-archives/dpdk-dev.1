Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77005C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:26:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C1E840E4A;
	Tue,  8 Sep 2026 16:26:47 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 9644640E4A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 16:26:45 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so4419010a91.2
 for <dev@dpdk.org>; Tue, 08 Sep 2026 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788877605;
 x=1789482405; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yOG5n/GUwDCiAx7dME8z8rFIThNabjhp++FXgwfWKi4=;
 b=EiKXO1Y65jCTeVE8ItvPThaFQ875cST2CszVNqeHfMKGPJH68i2HQP/JISjFFlTlqx
 dx+yMpEJRhMjrgn+4Ql1TKIPqeooLVapQ/YaAXMyDHFFNP8vxUZKqYhMbUggkhl+rQlG
 VqCqQR4TIrKUPgHAFgYHIJybIaIsOUWHoHBmqnbQhAShUR3J9lVaBq8ATS0Ej1ChX6sC
 TaemBBhjLNGMfY5TwPA9zOCQuakqdLhEMrne79PTQflQizLpj917iNgW5lXpAsm7jvQH
 3TuMBmL7zP+iSGBCh4DqzawjWvqQQbK0OBnw43NqanO63rH4QYtze/QAWzLWMqwjj3MR
 JWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877605; x=1789482405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yOG5n/GUwDCiAx7dME8z8rFIThNabjhp++FXgwfWKi4=;
 b=UPnz8zKcXd3p/hsWJP8xHdWFYVTwMIcEkImqkiYXzTD2Tr4BHll65UCtKifJIRWNYo
 xvovJDklrf0vIDCK8ZwqE8QH+pjvv3L18Ktgi6HP9cJt2lQpDov+If8qD1SsTegKE/Hx
 mugLESsBRDVxk6J1gRJG+2Y2xqeEhl9M4/4/Nn6Fp+xvvOFT6ppf3d2mLNV4QdG5P9vq
 3wk8hNezRqo23lJuLYyxWTMs3e/tWZf5T65ExZavDtx/N5l1fioOnAbTP0Y4THsASBvP
 SbScrr6KpfjDkfRbiyoMq7oftTLDl263YBBQj9w4Gvo7nxPj18JcY3n6m3/EfPLmMow8
 LOxg==
X-Gm-Message-State: AFuF++kCoDpwHhtQy3VRyj3zJnEz+svzmOLOK5wq72SW/WE3OTPeNm3A
 9uolGAdvfm7hXmDy7PjVLILK3umDPmiTTzWj6lustWPSH8bwSf65/kku2E/zk9kkm/E=
X-Gm-Gg: AYBFou0h8z0rjHwyCLl9I1enpSBq/dTi/R80tw+kmnOq2urelA+n0dGifK/uoyGSe06
 Kwy1lcbrB0yrViHLGQuRoooxdUqW8Qk0fMIr+N6vO+W+F4kvIQtdHByuFpgApD7skMpataFJGm4
 8tn7UCpd5DEWhnceN4QUgu8VIymwuNAxNWNmYG2MdJ4zW6njUuINHsWZN+28hQth3kNzV+8RBtQ
 DvDexerqXiDPi2F5k3YXM5uIU06WDu00iDkkyCoOvQT1hAGTerYxYdEgAQLm10ETmiSyG6Uxvh9
 K7aF3Ux0LZ0h+OoCdvGk3dTyl9bQJhZFSH11MEMHrtG+s7Tnpe7YeDmANZkc0PkZWLB+G0GNaCF
 3oAmSsZlfZNU17nP0e6lnEkU6dmADJmCijnwaLMjla+2qCY1MmdLLMI42ePMoZpQN+zrp5VU2Rz
 BBXmPZRtVO37nX/5s3ZFMucT9DzBoW4/rjH9+XvcEyFNZVPsMUseVDNkQsvv0Bm3kj4QvZ9lk0v
 XTgs9Hx4P99xpWBVzYuiS0Fdwchow==
X-Received: by 2002:a17:90b:5287:b0:38e:6a44:671b with SMTP id
 98e67ed59e1d1-39b25eeeef9mr46569188a91.0.1788877604629; 
 Tue, 08 Sep 2026 07:26:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08bcc090sm32559753a91.4.2026.09.08.07.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:26:44 -0700 (PDT)
Date: Tue, 8 Sep 2026 07:23:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit
 Khaparde <ajit.khaparde@broadcom.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 2/2] net/bnxt: fix MAC address removal
Message-ID: <20260908072342.3a7e1660@phoenix.local>
In-Reply-To: <20260908071854.3419531-2-david.marchand@redhat.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
 <20260908071854.3419531-1-david.marchand@redhat.com>
 <20260908071854.3419531-2-david.marchand@redhat.com>
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

On Tue,  8 Sep 2026 09:18:53 +0200
David Marchand <david.marchand@redhat.com> wrote:

> MAC addresses removal was tied with VMDq pools even when not used.
> So if VMDq is not enabled, no address would be ever removed.
> 
> Fixes: f9ddb36e0065 ("ethdev: skip VMDq pools unless configured")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Applied to next-net
