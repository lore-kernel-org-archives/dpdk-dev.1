Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA5D262AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 23:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 610B1402BD;
	Wed, 21 Jan 2026 00:16:43 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 8255A40278
 for <dev@dpdk.org>; Wed, 21 Jan 2026 00:16:42 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so38859625e9.3
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768951002; x=1769555802; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nZITmggwvVD6BjNuMEyuhIV8aJ0BtinPPQYB9UmaZyU=;
 b=Wuai14ouAdJj/kH94xADDa5HaKy7OMCR+Hi0aam3578o2suvQ4Tls37QGzQhf0EEqj
 JGN9eD+j+cgnk+VsTynVLG3cItgtBvuV9DsKs5+zKWIF5JEwa60J8sehy9/dtU1snAQy
 bMQbVKGyhi2SzK0aZW+RuCdytaD6e5p1jbGTk61owvYifGKSMiENmXfhMKT3cWUvgzfo
 gNv4jNY2XXx9b0ZDzY9JO1oK4mDHC1wgxCGH/SZZk6h7rx1oyQgNIIQAg/3U8qS5r0I4
 2wUnD26lFQlDCSpX0mtaJJlG4IGofCKFyL55cb2RXbhZQssQbaAzrPqfei6zmq/1UkIt
 axoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768951002; x=1769555802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZITmggwvVD6BjNuMEyuhIV8aJ0BtinPPQYB9UmaZyU=;
 b=LfZFVCL+cuqDcFoe6L0cS0+c/+Iw/MyeBSOp9D02TDPxbl5fxHM8RQP5UFwgdQzzhW
 cQw+GxwtXUI0cdbEGuZk4nrfYJkKrF3dh/gPHVb1opNHCr+Xj7VT1SoTVFRrq4ZIy2NB
 QTGzmyYPJzJQ6yrohP9nRfUNJsahaZ/rJpp5ONsgGWV2OXJrMfDVNiJ8t/2dX9YxUZEQ
 F9i6GPeok8LUrSxFfI80ShcMmrl/ii8WHp++SawONDvpTlv48GVHZzt9Ibe3gYQqXxdd
 /nEJJDmb4xCj7ON3aHbh2GZyXch4vAQuh7zSgstqqZZYp+T9G7DgCBnfGvsnMxsAZ3NT
 jrVQ==
X-Gm-Message-State: AOJu0Yz9JQGQ1mQtsxvKx6HByhm7RaNmnSzKoA2/M6wrgKEUg/SkSAlE
 gg4Kd3xC05Or7TrrILIF/fgYikBS9gZWesw2ZXSMUDc031QKuZ27I68hUZqRYEh/bgV6VWbw1RQ
 8g4us
X-Gm-Gg: AY/fxX74p/GQNeYeXtdjurkBjtVax5LzflEexUd5jYvfBm9QJmEDUKZPtu6AyE0RA0G
 ZMGuN309Hjo5WkDuzAfSwP0ab6+fMgSJL/dounMadbbByfgRN3JlPh7L4f/E9w6nVk3WQl1BDHm
 FfZDfs5SrP7b0wACsJlsmfx5Q756pxZLCGUfTll5FUARlxJqF8lLA2hZidMJcb8QVFlyojvmDK8
 66tGqmc6O7r1bfwIffs4TCVt/LhohqJ2Ba3YSCV55BvxZvyWXX3uvKjgnrlLrjZcLd0SWwvUBQ2
 cE5l06KptMeaxwPzuNhP3SRBMVBVY3Ah5Wgk3cMiZljOC+D8l/ZwHOHclpe7gvIBUI5/MexH7bW
 aq1yne4Hu3t7hxjRGMokvZnI4qT0m8YIP1YHFpKoCCJZmgv2hIQjhNsemYnlyHFks8YtxoKafz3
 S0JNwN68qxBQIYJtg1IgAoVHrjOPcG+0yi0hZFbLNf+9wd5A==
X-Received: by 2002:a05:600c:3107:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-4801eab9e76mr183341415e9.5.1768951001935; 
 Tue, 20 Jan 2026 15:16:41 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595e0a705sm3903968f8f.14.2026.01.20.15.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 15:16:41 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: dmarx@iol.unh.edu, probb@iol.unh.edu, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v2 0/1] dts: fix invalid f-string syntax
Date: Wed, 21 Jan 2026 00:16:37 +0100
Message-ID: <20260120231638.194471-1-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
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

Extracted from https://www.mail-archive.com/dev@dpdk.org/msg326745.html
to hopefully help move things faster.

Sorry for the resubmission noise, adding the signed-off-by line I forgot
previously.
If this patch set is not needed, it can be ignored.

Lukas Sismis (1):
  dts: fix invalid f-string syntax in testpmd API

 dts/api/testpmd/__init__.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.7

