Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA92CAC5BA
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 19:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D7F540663;
	Thu, 25 Sep 2025 21:41:11 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3903F4065E
 for <dev@dpdk.org>; Thu, 25 Sep 2025 21:41:10 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8572d7b2457so122885785a.1
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758829269;
 x=1759434069; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3dOx5/bIkg2g+IJ3i1a6kVzsrKBV6Up53fDvy6d5/8=;
 b=HJhaqz4gQ5BeptOsyw75zv7cYeZCm5QD1ciLQRbqY1k7+/Y5iK+NROgqobhpUhmHhT
 frw4F0cpl7IvONOv4DBxvqdZsJ9B+CKALgCJ9FkODQGG6gnrzuXVvTJMnWU26pS1xlqc
 yiEZobA1IwKbUAUfKY9mMRK85FwNjt7p0XjREM0XNIQBzrBw7Na+LuM+CdMTTSFYBVOw
 Ki4zjSVx86eS/G+rQGQ52WxwWr4hHSUWhudnARHaua4xKhwWShymvenaG1LbJAlX2mCo
 wbz0mK9dLni8s0DYOBzYEnRTvdJvVR1Lxh/qdimyjREWLQWtqOK36hvfM4lKkaevKGzC
 /oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758829269; x=1759434069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3dOx5/bIkg2g+IJ3i1a6kVzsrKBV6Up53fDvy6d5/8=;
 b=o88aHqOz5iP4Z362LW6JdoDEFBAdUh8xmw1zaNnRoH8drV8rDe6sKAimm8o0I6Qijc
 ok5EhfYuVUVMTMf29acubayxQTwGbl8Skc896DR4PeL10Y1Uguyko7hjx9xK+z9oppfa
 VE67uarRhWkCB3+9PVjzaDtWjAmvMLv9QGDlSXAlKaCHz5hflhioef4sXrMdVUE47SW3
 RLob7Hick13L5DFkb9njuJ7Qq2AAT4vpMwwoPt7jiV/WkKiMho/7SzmQfuKy3I8XhG0V
 15hc7bKXzpXvOuc9x9rgFIl6WEWF4XXjnuRh4rOVWSFb3N1jlJtVaX5qK0v4eHEhW5hr
 f6ug==
X-Gm-Message-State: AOJu0YwUB5iUJ9Mgnjy+5GaQ72Krr2/saamc1agtupZJLBx4bAe66slO
 LKnYnmsGy4mhoCzZLkVOqX7yR/RoSOByxSSpGkYEYkJV2oo88272m9IurD2n3ygkCYJX/1m8ZNt
 KkwYndrI=
X-Gm-Gg: ASbGnctk1xRhvk78yTEDHoK41ufJgWHiCr0Ip08s9+ti1gKcRCNTGLFItohFDEzMsKE
 OQSdH/UumetziNnlvLGP7oQtEEACPk/4YUAqPqKinBQHYd6HRGREwhwbE6p5vriGIZNm3dmzLnI
 DcTIaqMwpdT52QALD1MVvo84I4r+S1kDWK1xqLBZRIr8efRxrY/XlJ7YDTL7IBcKOwGI2L1a7DU
 RpVVb15p6nuSTsDf2iCIxWOJKAoyGK/lG6zBy0UexKCd/BHCaYsqsYjGOwpCWv5TCObWreS3PxQ
 I+4mZ5hhU2iSX5o8TvqOwufwXCcAUppq/6NKleoa3xRXukCspU5Hv4YTeHjlpS0hvhj21tK2NqM
 8UrVnma+/U81drZ0DVyAoubDdyI1rn+Cb19XAGAvFBGcVkmCVY578MEt/wgraYifXMWo7fY/ZmC
 c=
X-Google-Smtp-Source: AGHT+IErgwBDXdufQ7kIllFzU/L9a5K4b1Rmrt7kFpH2i5JGKM/ZMU4zLTwYjz/DVGVx4iu3SmcPHw==
X-Received: by 2002:a05:620a:4610:b0:82b:1d75:d8fc with SMTP id
 af79cd13be357-85bc0ad53c8mr543818685a.11.1758829269473; 
 Thu, 25 Sep 2025 12:41:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c33b73f99sm163263485a.63.2025.09.25.12.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 12:41:09 -0700 (PDT)
Date: Thu, 25 Sep 2025 12:41:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] app/testpmd: enable warnings for possibly invalid config
Message-ID: <20250925124017.2097c2c2@hermes.local>
In-Reply-To: <20250912160210.388290-1-bruce.richardson@intel.com>
References: <20250912160210.388290-1-bruce.richardson@intel.com>
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

On Fri, 12 Sep 2025 17:02:10 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> When dealing with multi-segment packets, there are separate offload
> flags which should be enabled on Rx (scattered flag) and on Tx
> (multi-segment flag). Print warnings on testpmd startup if we detect a
> situation where we suspect the user is missing these flags, e.g. we
> allow scattered packets on Rx, but not on Tx.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Queued to next-net
