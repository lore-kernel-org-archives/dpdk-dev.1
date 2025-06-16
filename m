Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32557C71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 16:07:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44BD8402BC;
	Mon, 16 Jun 2025 18:07:28 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id A71BB4021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:07:26 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b2fd091f826so3369017a12.1
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750090045;
 x=1750694845; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7GBckyrIBev+8tl/1l7IYoUsiTGIUdV7jvNXFw6/yw=;
 b=l6xOJGAhKqQVVKF9pwFUMgtldwXYgeZWwdezk6+v9yUpoiixGgVA87g5z0gPYqtzNY
 mRqr3QRAr1FzEW4BZcNnlaaflHFKpX3hBsPqbsqo2ZxnpsfTKMpOJ2VCXqaW+aMrfodD
 pQpIJ8Hmut+hJExnhW5h+jFLwo1ZJ88o9k8zU/XgB4vXifXXIDiXdG7YswJQ4gYDg/N3
 K3d3AdCxyCL8XzAz9t6R8UoEf2B4bW0biYbDNjgi8gCXnkIVEW9bKKhrlWNh1yIaUeyv
 rcB0VpkWL/pvkyQR9VN4uWIEIFJAGXBrgfGqFUwkfrKR10xOZvReY6bRJlVPwmKXO443
 +oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090045; x=1750694845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7GBckyrIBev+8tl/1l7IYoUsiTGIUdV7jvNXFw6/yw=;
 b=RZM4lB/eTFpLujmN4YcAxoMME/BLVccKqBH2wcuGIUtJnAKtQmHdXxoBfyiltl0lkO
 SiWaEXlyRIr2JOW6kawWG1QHMMj+7xPAkeDR6K9bRyoEdE3mNQXZGhPPE6PIUnpoxvep
 n7YY2RM8qHktIvRUla/fXiAtuDw+GY9nVV2u1xwPH1PS0aWKa2REAtH9C3jOqF0K7FQt
 xMrxIDFtNIa6IVbZDL4TManKtnr223/DKvz1SSYOeH0PIz6qdbi0eqk2hMHyI9cxesAy
 qPiXvF39ppiQkWh1oLY2sFKaTsPWrjyuK1K+aG0PWi5tqhxJVamX1Bxr2wvNw4Wh3UGU
 LNZA==
X-Gm-Message-State: AOJu0Yz7RPi2Hlwi1PHho31UqkMvi2b1nAozRPXiIfgFmL+FfnOMYgXW
 mQajgP5B9HNw6AhGq/3G1lRgy8SoTdmnxxmeMc/BUw5ToEx/3Of28Qgouoa+SUTu2caZ0WGI4wY
 UkGxS
X-Gm-Gg: ASbGncu6UfywAsLqBd551ULnkuK6w6L5K4nCu8HNjMm8nmr8CjbPqMH3Xok8yM4LSKd
 MzIdOpPNsijqj9XJNN3QXxhGLzbcU6rdG3u6DOSvWO2uQuoAKVmoxOGd/A5eKN4Op6MucJgmQbG
 /VzJLG4maPG9F/TX2ESCri5pGvNWCo4e4tdnl2XWyhHEQfQ6JTZzjMs134qryat8zlo4jY7ylTo
 g9dNEXgWhicL/acbYeZixij2sqYQJm9gFPl/weE7xln5hFvw2J62vXG5YqhVIVtOsry92Lao5m8
 QhTN8sI7OzVGwFVogZlFwwtGJmaM0RWhQFxtKBbuukq7useB/xdNJMaidUIYoq5PVvPUsiyqVyN
 I9RZwnR8jOg2/okdiGPy7QFoWIcNcdQBbk3Sy
X-Google-Smtp-Source: AGHT+IFlyV5ntiWHPB58HsHvb7cPi13tFFSc34AF+BJ9FambOHbckQnge9NYe8SaGCblUW+Ms5mwJQ==
X-Received: by 2002:a05:6a20:7346:b0:21f:54e0:b0a3 with SMTP id
 adf61e73a8af0-21fbc62cb6bmr14696626637.2.1750090045486; 
 Mon, 16 Jun 2025 09:07:25 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748900d252esm6992623b3a.163.2025.06.16.09.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:07:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] Latencystats optimizations and fix
Date: Mon, 16 Jun 2025 09:04:31 -0700
Message-ID: <20250616160718.49938-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250613003547.39239-1-stephen@networkplumber.org>
References: <20250613003547.39239-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


After investigating latencystat test failures, discovered it poorly
designed to handle bursts and multiple queues.

v2
  - need atomic to be safe on non ordered platforms

Stephen Hemminger (2):
  latencystats: fix receive sample MP issues
  latencystats: optimize locking on transmit

 lib/latencystats/rte_latencystats.c | 68 +++++++++++++++++++----------
 1 file changed, 45 insertions(+), 23 deletions(-)

-- 
2.47.2

