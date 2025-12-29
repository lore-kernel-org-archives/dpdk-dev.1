Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E82CE92FF3
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 23:02:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53F41402BC;
	Tue, 30 Dec 2025 00:02:29 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id E05584025A
 for <dev@dpdk.org>; Tue, 30 Dec 2025 00:02:28 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so11925487a12.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 15:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767049348;
 x=1767654148; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2w+KMM+uSl8OmtNVBrrU12GNAERk/WZ2MI3ugR/hAFU=;
 b=IpO1xJjxkRH+3iK2+sgpL2zKz7xPwTj8qFDz43izQNZyYzjBkI4yyV963I5+Ww+QLM
 fBQ8k2Wwywp06a5FEUR+6WFA/cV2tUJPa+jum2QB02aBuew4GSJDDF2qB5TgXixDXnkx
 hgcFCVVIkyYPVuqnNPO58AKkjMdTG1Vg15HeCBKPm96pT3YBYBh/bchxN/w6fNChCXbO
 SAMreMaHbP6jtkBl2atSJ4QZc8vOGVxqXRxqUfONVmcvSVxi1Mg0lbAAvAXzDlUU3+RW
 BkTgqjkIfJmEyvJuyxlf0IAttH2+7sJRiJwkRP5x15gDE05Pj3DrrC7oeSHNjjEeWtWL
 Ov4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767049348; x=1767654148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2w+KMM+uSl8OmtNVBrrU12GNAERk/WZ2MI3ugR/hAFU=;
 b=EnnQkmA8rvmE0laeSDTcHPqNHfP3ZNSIzbMoXAdwyk7QYKgk8FAiIjCndiltWdT7w6
 j79b5ob8/+JQBysjKLmgVSW9o+yBTdMG6txohV/b1Arvt0xA7rQXZtPM91+zfiA/yq0O
 OtjsoBUn9Wp4I9YMrFBZik3h2/LK55+GSdoNNwcfbP9aDVhqqee9infH9snqd7uI1sIf
 33epBbJzyrES8CDILs4kxxFUIKfFVl6zaEm5l3GdlhI4HlpK0opuhLuHwfzzOzxOWVbt
 cHial6XlbtF6tZobN4AC4jL/s02umT/wWQA+IcFDDyezeyApwKPHujwxRgvVuK7MkjQa
 kINg==
X-Gm-Message-State: AOJu0YxUh9cI6/EdzvctBbJAxpShp/hwfH5TdshhdPRS0BGl9s6Isnv0
 GedaQfiTsgUM58ApaprewS1DhEBboSexBZKSMfLlwtl6m9xomDoCKa+RK4Rn7KVCxJ2DTmsrZbz
 xjjN8aAo=
X-Gm-Gg: AY/fxX5vqjpj1yNxqOqg8kvRAqa9/TCont9KRcXca0++Z2lIlpNOIlNXyyJAp6ZFY2Y
 wTYzDxlXJbudh7lB+HgxQoO8HAIivzFzKbnwRzTbMOGALp2rCJAlKJxHlPR/OOkMOBV9IPsKo4a
 dKNbzN8Jgs2jsBy1ZsLBrb9ptAZ+j49TP9zCAINT1xhnCmWNi6Z4w24adNJHU19xfk5xJnx83Mg
 8S/wz2rz5d+cbImJRocdh66K03VoJNKTX4mY6bA6a1AQ0gVAYMmkFFixp0CG/85tLyX7HVGXFI+
 9bTAQR5V2vZDcdqNHvNpJfmyYRSmKexuUw6S+s3iAuiaR78+4HMz6V2i4YRy3ysSE42ycWuLcX/
 XVPRIZYSpffuG8foMP48nmPo1VoB0mCqasAu/BZaoIAJwnAR87nAsh+TxHaYSsxEBkRebfJ3JwP
 5FfoAR6SHrO2rkJbud1QX9kMTcR5eqI+tYybktyBF2B2wjaR35IA==
X-Google-Smtp-Source: AGHT+IEPAx51G0/sTrDmpjQsJtZoelRa+7OvDMBPAmYiRuiS7c/9C3GX2Pb9Kszjd4Z0E8ZHkt/wMg==
X-Received: by 2002:a17:906:6a1c:b0:b7c:e320:522c with SMTP id
 a640c23a62f3a-b80371d4499mr3572158666b.53.1767049347922; 
 Mon, 29 Dec 2025 15:02:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b830b5fe8cfsm1933148166b.59.2025.12.29.15.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 15:02:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/6] pcapng: timestamping and comment fixes
Date: Mon, 29 Dec 2025 15:01:03 -0800
Message-ID: <20251229230223.151874-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126051218.50568-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
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

Performance improve performance and tests for pcapng.

Stephen Hemminger (6):
  pcapng: use alloca instead of fixed buffer
  pcapng: add additional mbuf if space required on copy
  test: add more tests for comments in pcapng
  test: vary size of packets in pcapng test
  test: increase gap in pcapng test
  pcapng: improve performance of timestamping

 app/test/test_pcapng.c  | 134 +++++++++++++++++++++++++++++-----------
 lib/pcapng/rte_pcapng.c | 101 +++++++++++++++++++-----------
 2 files changed, 163 insertions(+), 72 deletions(-)

-- 
2.51.0

