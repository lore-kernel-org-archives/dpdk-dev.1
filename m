Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A1AF9D0D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 14:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB24F402F2;
	Tue, 14 Apr 2026 16:42:51 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 6D883402E1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 16:42:50 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2d868d014a5so2453804eec.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776177769;
 x=1776782569; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJr8+s25juBJ79cyfNbuKRZPuwld9S2FLL41aIcUpJE=;
 b=J11vHu3xQQ0Mi4C/z6Q9cAFhMQT9EWLKvKgblJgOd7iHN9ojkfkkUNlaFcKQgVEqdy
 FhS6pkE4QHgVnNTmbJoVlyuJvQMMLskIT2RNKsPWvnZ4YA72KeenLRZdXU6m17BtGoWj
 jQ5OgbUMdA/S89D2P5/i3ynoLODx/HU1eldFMy8yXQFWPsRQwvijM0lYjuwn8Spz2y9A
 XgS4yYPzyevvCall+QFLbGjjw1rpLVvaK7gOzP2JMdtCeTy1RJwxWBCjZRlCqPZbAyGG
 rjYUVWNZIyOOvWm4I9uU5270P+mXHscAHT1SQRr7dH+2FDBdEnGYxhiQAnZR5XcPrgXx
 nLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776177769; x=1776782569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJr8+s25juBJ79cyfNbuKRZPuwld9S2FLL41aIcUpJE=;
 b=Jy6BDaS4Uc/bpkyQMh/tVWc1H2MxM4XtX4L1U3DSr1oRkjOyANa4uveeKwFQcF8Yzi
 XamapVIivQKeB4AHeTfbOWXqYofFBoQJeC+NDvzvSSwr8iIJNwoRe7fyn+58Na4VzolP
 Fu6IMSZq+UvwY8sraGM0ZtwZEmU8DmzY4yoPex9WBxb/MQmVYxBCg5HDq4DtLn/odPA3
 W29tA6yTTAGm9vCOdyZfyulKAogc6/siIk0/tszyejrImOpceRNw0OQ3LaR3KiZV79Al
 1E17HXWjq0qwjuFOWU6IQIPgL6MdzDgS2EoW41zHMV79pGXWqbqnx+lZc+2G5CtNRyjk
 D94g==
X-Gm-Message-State: AOJu0Yzno0NNbZVjRl+mCXZ7VfaBO50XmFuCglj72b8jfEcR9oeR4TSr
 TNaoFqHVYQXpG8BGFagKTInQwQ+JbPf/zzYm6Selnc8iACB5JFDwWHbCGXwzFToaqOdAxnx6Hn7
 dvCpG
X-Gm-Gg: AeBDieuX6Bzf3gyKH/hhAaVk1NwDAQhh9UbgDuwIabmCOGimuymDg6Q9Oxa239g3Mcv
 k36OQ+7GVEHKGzfiFIzE9xpeH74TUMKS51aAp/2thKYXrF9alAkp4elyCtiMhM2+LLUpR4rZsJP
 ctjKdvKN5egdqakOwOcolUy8239zxfAqt+nT7lEyVyFaav/z/o8ivR28JhFCF3+UiG/Syl/odUx
 gr83B/kcxOr8X9RLPktO1CKrlQ3W4DT83BeAo2vNbpeRX44DafP70eDg4MYFpurQabF8poYpeLL
 g/oHR3GZ3joKC2cKKqU1T065z8R+bm1URwfQe/VpQFlZGk4HBtgEr3ZpCrGHM8sIQpwIn6XSlrJ
 84ZRvKQRHJpHCahBswnt9Bi23msTtHOL7FqPCZCPD5TTSrCBHz/8m/MT6ic5aWItC288VVVEJpH
 RYsLERdjemIZe+8ya2ePXihbR/Tsq4B1ODlFhDXX/CxK4=
X-Received: by 2002:a05:7301:4083:b0:2d3:2983:c890 with SMTP id
 5a478bee46e88-2d588e838b5mr9845077eec.15.1776177769143; 
 Tue, 14 Apr 2026 07:42:49 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm24985835eec.3.2026.04.14.07.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:42:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/6] fix process shared pthread mutexes
Date: Tue, 14 Apr 2026 07:39:52 -0700
Message-ID: <20260414144246.110681-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413171836.123467-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
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

Several drivers and the ethdev layer initialize pthread mutexes
in shared memory with default (process-private) attributes.
This is undefined behavior when secondary processes use them.

This series adds PTHREAD_PROCESS_SHARED to all affected mutexes.
All are on control paths (firmware mailbox, hotplug, flow ops,
PHY negotiation) where sleeping is acceptable.

See POSIX spec:
https://pubs.opengroup.org/onlinepubs/009696899/functions/pthread_mutexattr_getpshared.html

Bugzilla ID: 662

v2 - fix build on Windows which does not need this.

Stephen Hemminger (6):
  ethdev: fix flow_ops_mutex for multi-process
  net/failsafe: fix hotplug_mutex for multi-process
  net/atlantic: fix mbox_mutex for multi-process
  net/axgbe: fix mutexes for multi-process
  net/bnxt: fix mutexes for multi-process
  net/hinic: fix mutexes for multi-process

 drivers/net/atlantic/atl_ethdev.c      | 14 +++++++++++++-
 drivers/net/axgbe/axgbe_ethdev.c       | 19 +++++++++++++++----
 drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
 drivers/net/bnxt/bnxt_txq.c            |  3 ++-
 drivers/net/bnxt/bnxt_util.c           | 13 +++++++++++++
 drivers/net/bnxt/bnxt_util.h           |  2 ++
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
 drivers/net/failsafe/failsafe.c        | 15 ++++++++++++---
 drivers/net/hinic/base/hinic_compat.h  | 13 ++++++++++++-
 lib/ethdev/ethdev_driver.c             | 22 +++++++++++++++++++++-
 12 files changed, 99 insertions(+), 19 deletions(-)

-- 
2.53.0

