Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDE4C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:42:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E627940665;
	Fri, 14 Feb 2025 18:42:36 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 07B1740651
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:42:36 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f83a8afcbbso3757541a91.1
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739554955;
 x=1740159755; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHcuT991InXoT/FlzCtAgxqh9N9RQ/mzINYCITfMXPA=;
 b=sGojGPNIhxXLWcipJu9k56zsxRWELWOA6SAwfIayF4kbdWj90LrFzwYN7+xSZuJEJN
 oRspLXVZncMQywkmIfSnmCt6WphfZiVBmt62v5H1thiLhuc09DNrL62OaGwqIyhgpVFJ
 uIFBv5qs12oE4ixeeAwFCMXthyrXoISrxaeiVteiCSBVGANl9uorcEkz6pe+MYmJ561w
 fnYGIChZ4Ku3skihRyweD1kdlEwd6OJaL6FsVw0CKdasaEQ/LFaJycWZi6W3GvB11jtY
 J4jPwBrXAGbYQAUA12cY3D9ExjiYAanS7yFXPgjdQPEgpUI0LT+98SB7qWCyV04yXmMj
 WM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739554955; x=1740159755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHcuT991InXoT/FlzCtAgxqh9N9RQ/mzINYCITfMXPA=;
 b=vZ1ACScfCpLLcxe+i1pqBcoEiObfJworotK3ZIH8zSQRPXyYMT3EQPFuCZS3Kmyyq6
 UzcuubbC394b4pmX2SxA7gNGeH9aGm40hszIpYL17zFou8rz3ogLDBzn30wStTlYcVn1
 tzM4ORrShFQkLzr5yveGITYs5ze+h/du0txzi1ltZ9fspmdQ+9pKhyPy2IOokKVyh6Vq
 WPEU3VIGIJGC3WOd+tGi6M12Ub6ZotyLpvcwgGvJst+pkJa8P/lam2Qq3gTuC1AOKqHN
 Kkc8tCN+s/5l9J6OFLEnVFXhaFNQbOj9maeszpsf5jT9U6K3fV5rGcQQQWkA1CoNK5GQ
 53xA==
X-Gm-Message-State: AOJu0YwYQiI5JiXmjrWZ2JRRON0UZ6PWh6ANqJLHCE5HlbbtSpl0KiAZ
 jmIHIrd8oZ1spVrF9+0DzPebZ2jA6kb/UjRNUCZpqMJpL6lla+L0WhWHO354HoqwQhO2Au1zIFU
 rYHI=
X-Gm-Gg: ASbGncuEK6WIFioNKGCM/emjnbsNax23mAUv+zwQ4OKGgA8psPyqbNpoiyyF8EaONi5
 tdu5z380XUcf1ol92Nf2G0gSdl4Eioa9GkaOqV8pEeu0dfuWuLm8EiwJo1tDGPaDBl9aEzWw78U
 IGU/37wMq1b4vrPoW/YaO2mFxGQpqUUBiapo11hya+U80ZdbW13gELFfGHS+W+D/nlkXnslic/b
 44WVhgFFyl8YTuIbCToAWi/lKFwSMXswnzxZ9tQ3nwXg1pBf0V3sMA5GCYVFoge9lotZZAZFFdU
 HFQBTN9umdMZz6O3v6YoSOO6fk1uKxOaE+PQLTKwE40ASaYE4eyYY+IcGZLKtt/daFMk
X-Google-Smtp-Source: AGHT+IFN7szdwMbqE0GeVk11leJtSC9wP8YQExZpYY5lwtONRzm1Dy+abxDhf/od4ue4sBPwcdKEYw==
X-Received: by 2002:a17:90b:4b82:b0:2ee:823e:39c4 with SMTP id
 98e67ed59e1d1-2fc406fe591mr16665a91.7.1739554955103; 
 Fri, 14 Feb 2025 09:42:35 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f48eesm5449852a91.22.2025.02.14.09.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:42:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/6] fix the handling of deferred start in ethdev
Date: Fri, 14 Feb 2025 09:38:53 -0800
Message-ID: <20250214174224.79142-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241213214929.817688-1-stephen@networkplumber.org>
References: <20241213214929.817688-1-stephen@networkplumber.org>
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

There is a inconsistency and lack of documentation around the deferred
start configuration flag. The queue deferred start only makes sense if
the driver has a way to start the queue later via ethdev ops.
Therefore move the check into the ethdev queue configuration handling.
Fix the driver documentation where the support of deferred start
does not match what the driver implements.

Stephen Hemminger (6):
  ethdev: check that device supports deferred start
  doc: fix feature flags for queue start/stop
  net/dpaa: remove unnecessary deferred start check
  net/dpaa2: remove unneeded deferred start check
  net/enetfec: remove unneeded deferred start check
  net/virtio: remove unneeded deferred start check

v2 - rebase and cleanup wording

 doc/guides/nics/features.rst         |  1 +
 doc/guides/nics/features/gve.ini     |  1 +
 doc/guides/nics/features/mana.ini    |  1 -
 doc/guides/nics/features/netvsc.ini  |  1 -
 doc/guides/nics/features/virtio.ini  |  1 -
 doc/guides/nics/features/vmxnet3.ini |  1 -
 drivers/net/dpaa/dpaa_ethdev.c       | 10 ----------
 drivers/net/dpaa2/dpaa2_ethdev.c     | 14 --------------
 drivers/net/enetfec/enet_ethdev.c    | 16 ++--------------
 drivers/net/virtio/virtio_rxtx.c     | 10 ----------
 lib/ethdev/rte_ethdev.c              | 14 ++++++++++++++
 11 files changed, 18 insertions(+), 52 deletions(-)

-- 
2.47.2

