Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D8E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:43:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FB58402EE;
	Wed, 18 Feb 2026 17:43:29 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id 7059340269
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:43:28 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d4d8712b40so26600a34.2
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771433007;
 x=1772037807; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DwF28NTcrwXkksmfJMTkDCzP5WCwu3sYCwmvK9uR2hE=;
 b=Lll5nMY2IlV7KA0Im/fhHhnKUW1f1A7r/nBLOliA5/ljclIRSimfhfdwfw1qOwz2Mp
 m0m/1i/1yTsljRm1mIxdmB9C7YXwF3k5RyRYNGwmH3g1JNgsC89YfYmlk+mPGrP1flBd
 pY8tLP7PKb0H4p9war54DNCY8M92wObcILWDJr+3wNHipCnBEgMJwC0VIHnD5+JK7Ffg
 wKtNeU7ldVaWRVbaORVvZg0jnYm3YgjH4zHNhD0gUI/IQAATKEqeKVotQFHplnm5kOmD
 /GW7mk1kp/26OXU++RpcwpHRgSQTOKSkSHeoCRIbWgzVwbcq7W8JN3/2ExLyIYccAemY
 qk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771433007; x=1772037807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwF28NTcrwXkksmfJMTkDCzP5WCwu3sYCwmvK9uR2hE=;
 b=QbwhEWIvPe+d/M2w52nO9iPKGqBh+jNsl4dDTwpRJmMuQz45wCiefIvcrAan6K2VbV
 vJwADnwxA/y/wzQk1/W1/hKeTHXv8a2pPpWa+n78N7TCyCpz+d9vjoVvjnZdJGRPg6fg
 4b8YW+ZBZCJ8pGjIMMSPlrROMOZcf9akRP+rx152EwvUxlkAAws9A9qyTsUc2Egp9XyE
 007a2eTDIDLl24tzl+CHUlQ2HKJNP87Julg8zPrdSZdCkbhw8RCJ79c3PaZnF5A+oNlv
 i2f5Cj/cdWGDIlJb5FFWUnochLPJ0tVzf6MV2hAi6qAc+8Y7Lap1BX0ruNt0jubMAqwR
 XGvA==
X-Gm-Message-State: AOJu0YxfLg1syk8+cqv2EUGZQbjtskmMhSXcUdMbx9PJ03yLahu4rZux
 7vdCc2Mz8JXM8jgbdEmgQvjVu/pgpUvOA2uNDdptT0zcfFlBZbMpgPeGSuezZMVghlx6GWJP91p
 KusPV
X-Gm-Gg: AZuq6aLv0Kd2K3TmpnYa8hodnfcliOp4xdMDOkXGVgbR1z0eb4/1hM+EFzQvwBd3qD7
 hsS+t0SBNipuAqZoHUcj0harW/FKf1Yg9zRYnZOB9h3NR1LdJorIDxU9TOA9K28a4xpe6dtxrRZ
 lP4wFC09WrAMlZig65ZSIJMBdfx2wWw4k9F1K6q9AVHOqsw6lF8isaYkN5u8UOCv9iA2ikg8tDk
 xHkTSPMTEvGBKOXwc5tx9TMLp2IjvkagAU7209MNoC4muP+KinIgb5qbADIPRMkIZ/M4McrqXHU
 V0BKdy5AHiE4O/r4QvgfV7Z5jdcByvDkKk0DE5Mul+DGhfkUoaQIqZSGtdjlWPnpp1d74LwA84Z
 B7ZDb5p+l99DxvkB374bjb4jMLps5x1ULfXiamEcYW624Lj3TPK+yIvnvbRMf0saKqRhR0SoGuw
 jlzLlCBuKOql0aQDBTWGzOiVv6g4NBdwAm+xv6nd0plN6AHTtMZB0bCgzV2iijCg==
X-Received: by 2002:a05:6830:25c3:b0:7cf:d7ec:1893 with SMTP id
 46e09a7af769-7d4d0c1add4mr7510623a34.25.1771433007434; 
 Wed, 18 Feb 2026 08:43:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c6727752sm12878313a34.23.2026.02.18.08.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:43:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Date: Wed, 18 Feb 2026 08:40:58 -0800
Message-ID: <20260218164324.915065-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Code review of the axgbe PMD identified several correctness bugs,
primarily around resource management on error paths in device
initialization and an out-of-bounds descriptor ring access.

Patch 1 fixes multiple resource leak paths in eth_axgbe_dev_init():
  - mac_addrs leaked when hash_mac_addrs allocation fails
  - hash_mac_addrs leaked when phy_init() fails
  - rte_intr_callback_register() return value unchecked
  - DMA reset failure via hw_if.exit() logged but not propagated

Patch 2 fixes wrapper_rx_desc_init() which only releases the
current queue on mbuf allocation failure, leaking all mbufs
from previously initialized queues.

Patch 3 adds pthread_mutex_destroy() calls in axgbe_dev_close()
for the four mutexes created during init.

Patch 4 fixes an out-of-bounds read in both Rx and Tx descriptor
status functions where desc[idx + offset] can exceed the ring
size. The offset is now folded into the index before masking.


Stephen Hemminger (4):
  net/axgbe: fix resource leaks in device init error paths
  net/axgbe: fix Rx queue leak on descriptor init failure
  net/axgbe: destroy mutexes on device close
  net/axgbe: fix descriptor status out-of-bounds access

 drivers/net/axgbe/axgbe_dev.c    |  5 ++++-
 drivers/net/axgbe/axgbe_ethdev.c | 26 ++++++++++++++++++++++++--
 drivers/net/axgbe/axgbe_rxtx.c   |  8 ++++----
 3 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.51.0

