Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1FED1171E
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:26:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80CAA4021F;
	Tue,  2 Dec 2025 18:26:32 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id A64DD400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:31 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8b2d7c38352so5124685a.0
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696391;
 x=1765301191; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KKkXO0DdqSLfvQL+r9+azMOE8g0DDy0NaHlRzhRcnbI=;
 b=BAElqTSxLlccmh5Ou+qp6jBiqzdzZTIFtG9RdWria0Ob3tK97aqBGixrZ+2xy9ALOy
 hErJ677QmPZEKy8TBUhmplO7nBSAwcQ+t5CciQN0Th/Qt1//d/idTw0OTwRjyQB0kS/I
 bnHYhhj+0ddmiaLv7cQgkqUg5+iWXVzL5FCAcLX02uTfmiHMzvrJE8vicgNlO/b5a1PG
 9Bp95hCMoNmWgZUtCkMAcQ0uJxxqo8fkJldHSArt25dzuSe+EVZRQqzO9wd3ujtIsdtq
 Y9wBVGilBcPtaKgBfFtzMR12bpXtImWd7gpMua1CewR6laD2OdUvhMcR9SPLXdo1YV9U
 hp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696391; x=1765301191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKkXO0DdqSLfvQL+r9+azMOE8g0DDy0NaHlRzhRcnbI=;
 b=c0sFTSO1Sr46FD/uNHLOMXwFauD6k6FFyBS347x1eefTEqPX74xz3C82QNolhp3eCd
 CAcm/YEOjVhyLPxOd0IsuLV2SDpIdEiykCtNE6XxUNePft+mbeVWRNVHy+fOAQKp84E4
 gt0CTzLKCRtV5uyN7pCLDOwtAeSNFi8TvJyALQtGo2rxuZhJOaGHgjoQ5nO8WetGUFDa
 LgQ6zgVMMkI51h7pI4Y2EbpMwIwDExwQHnM3oZ1YsVl196wVA5njy8L7NFwGLi/bRpWu
 OGQ1scD+mOVc0CPjYL+paiY2tr+KjbWkgEyH8/5d1RyhUgAKMaLUdX9rQiyAqRAqbxLQ
 0YJA==
X-Gm-Message-State: AOJu0YwZ4MbeaEBRKHAxRKQ7U8i6uNPSqwlt3KlORT3uURMKgsJx0SNx
 yvPyNqKsFewMIMmFwA6ZalimXkKJVJ5QOBJTvSy5P03CizUT3ZUrWbZED/QQ3qlHbboo8Lt2+v8
 T/BcP
X-Gm-Gg: ASbGncsXlrMHWG+L33kgBwWq3CQiymS3oC2v+vLKKBv00PAZ8xWDQfjkpJYq0ZAqXP+
 hEwpristfG49zKLQ1jPv1Unocz/pE9vcepMevtZiVwnaBahy/cXCUCbi7zQy3ilww+YSQGGnU0J
 XtjdCoR7GRH+cXmgxU3mALHn1AuFZoOZsuHix2RDIIA/7RLTVYZEb1C1J3SGAqyPS0zE18BevNm
 PN4mlNgBPgsN4o6HpCnI9cghhCSO2TufMNnh36YpOIPIQGKbtqWN/ZcxHvA3cTwS1T1NldPsCCD
 ru1+adNnEhXb5/4owGs9aJgd16w721rJ0lPWCfkDTrRx26UOhZbEBYMcRMZtG34DXUdWWZ235Tk
 fQPrNWSaVlkYjkmDuB/v+uK9yUH0//rw9rFJRNjC2FXozIc3ACNwyAkiORcsp3ysYS+2ZmpVhPW
 x6nlDXnLAEPfRfLBnN1K/UElHzNlsVCePsogOM42bWjb/At/xxEw==
X-Google-Smtp-Source: AGHT+IGWfJMHR3xrjDCfcO54qk7RcFrEr8kBoImXAPjVh+DF4Ea3WGGSSx/Ii4TU1cMDs2q5oNct9g==
X-Received: by 2002:a05:620a:2886:b0:8b2:df4f:5b8 with SMTP id
 af79cd13be357-8b5ac0ce10cmr468719185a.27.1764696390636; 
 Tue, 02 Dec 2025 09:26:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/8] first steps in fixing buffer overflow
Date: Tue,  2 Dec 2025 09:24:26 -0800
Message-ID: <20251202172626.283094-1-stephen@networkplumber.org>
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

This is preliminary work to fix the format overflow issues
in EAL and related libraries. The biggest problem area
still needing work is all the cases where the created
path for <runtime_dir>/XXX could overflow the maximum limit
which is only 108 characters due to Unix Domain socket
restrictions.

Stephen Hemminger (8):
  eal: use C library to parse filesystem table
  hash: fix possible ring name overflow
  eal: warn if thread name is truncated
  eal: avoid format overflow when handling addresses
  ethdev: avoid possible overflow in xstat names
  efd: avoid overflowing ring name
  eal: add check for sysfs path overflow
  eal: limit maximum runtime directory and socket paths

 lib/eal/common/eal_common_config.c |  6 ++-
 lib/eal/common/eal_common_memory.c |  2 +-
 lib/eal/common/eal_common_proc.c   | 18 ++++-----
 lib/eal/common/eal_filesystem.h    |  6 ++-
 lib/eal/linux/eal.c                |  6 ++-
 lib/eal/linux/eal_hugepage_info.c  | 64 +++++++++++-------------------
 lib/efd/rte_efd.c                  | 20 +++++++++-
 lib/ethdev/rte_ethdev.c            | 27 +++++++++----
 lib/hash/rte_cuckoo_hash.c         | 33 +++++++++++----
 9 files changed, 110 insertions(+), 72 deletions(-)

-- 
2.51.0

