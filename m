Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F285C982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 881C142EC8;
	Fri, 16 Jan 2026 22:31:12 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 3A99B42EE0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:31:11 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so2188615f8f.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768599071;
 x=1769203871; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrET59uYCMdvTGdl2IjlHONfcDNOpCfVFu9IUXe8BRs=;
 b=CT9VbEIOzI46JCFBDnOA9u7i8lN23frEXx5TNwubtL1sZLgq7FOzzeqyai4t21Sa3B
 bXKYpt2obqykmRgCqEZfzm4oWYZcGxiO6S2jEk+V3yRtcEyhacEYFDoNjkLIOUJBYrTF
 UIHkpqgQWZ++k9K8p8YsvpLUbZNkx++t42a74SS90vpfshqvFBukXgqS6Ldw16OW9KXX
 A5jNmg9IrBnjZKM19YNjNcRz1S0TtFCCWKlfKAkREg65YKuv/y4qJUTo36eCDZGdq6uj
 EHd6YaDa8AAYbvRlqFpZsPjtgfneHvseKvFZWv/2jnZRYKz5gZcrA5//+noDGALMOjIN
 FH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768599071; x=1769203871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hrET59uYCMdvTGdl2IjlHONfcDNOpCfVFu9IUXe8BRs=;
 b=GPQJZtOtm5sh3df8MCdjCnwvfYEP/BG+En6xn2uLvVdl7RcQ6PUhJGrgibvwsaTVmB
 sAcT4KSZkI6n869LtSIHeYNYVVPmMDtUdYqKUyPJmQO1puPYL7/aMPMUuNpVwKf4elnJ
 MJVZg7yiwdi5aCpPkOdevy1Vrc1lW6Iz7N/0NJbXhmsUWkZVOLCMJLKpaDnC5k4DAqIY
 K4KYbUJoFxO+BK4i2guK6L4BvxvLtXK2/FQcfCFx2zpPYEYiTSZXC4LgGnQOeCwRfmNM
 Y1pJzQrXjQciMAQRybixOWxg2jEDkL2VfB5JI3yii/YNkXvMP2KAjWPzXjhx2oJ2uQD6
 rVsQ==
X-Gm-Message-State: AOJu0Yzy/RAXrJNcwsMlFgib3bguHZnEGX8psHIbpk0ZWX2v8dla4f8c
 xONPOEQ1rQivy30n8CXFNRla2sHjcGBQyKgYbymdXG1w97W1/BdPBZ73ZGIOybyjBjFruGeml3X
 rbGEY
X-Gm-Gg: AY/fxX7bmdKcdcdxYfmqM39H8bWLJ1h322xKcThg7OBb0o2Lkrywo0yu0Z1H+p+IX1I
 48siPpUxKmUZ8aztwAm60VXGvbpAGdRfgHd1OMkHwh0SWi72bb222Whxc7Q5rdjfs3v2PYFhAYW
 tFcR3CcZvfVdgW8UAXLWau+mkJxarhUZb7aH2ljQPHeeJVS4aqNyxkciF6bYuCNJZWRi+r1QweD
 lLV3mMHqoNGcBrgFcAHFaFMvqGAyJN/7RdxWOPN7ING5baSpPlI3M/1BZJdvcGAvvvd6+ESJDk5
 EJdjvU2KkLy4UHyJicdE9/DhyMYEu/P/DiEKPPzw4OOBh4HvxScKOxIrBf9nIFE/PsCfEtPsIfm
 XSkHzEoC1prtErLNGwPET859WYxIVIaz2Bt2NLhXfET8I0lVcR6oVR+9wXk6VpCFp6mtLLmEgK9
 b0P9ySBzuZ2N8bemDwOZwK2BdqiRxyGlbnjUUw1hioWkrUhRKbPw==
X-Received: by 2002:a05:6000:1a88:b0:431:9b2:61c4 with SMTP id
 ffacd0b85a97d-4356a082ee3mr5484615f8f.45.1768599070746; 
 Fri, 16 Jan 2026 13:31:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996e2d8sm7398759f8f.28.2026.01.16.13.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:31:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 3/5] doc: correct grammar in QoS framework guide
Date: Fri, 16 Jan 2026 13:29:34 -0800
Message-ID: <20260116213100.110419-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116213100.110419-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
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

Add missing article "a" in phrase "As result" which should be
"As a result" in four locations including table cell descriptions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/qos_framework.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/qos_framework.rst b/doc/guides/prog_guide/ethdev/qos_framework.rst
index 1144037dfa..53a72ab677 100644
--- a/doc/guides/prog_guide/ethdev/qos_framework.rst
+++ b/doc/guides/prog_guide/ethdev/qos_framework.rst
@@ -621,7 +621,7 @@ The token bucket generic parameters and operations are presented in :numref:`tab
    |   |                        | while the bucket is full are dropped.                                        |
    |   |                        |                                                                              |
    +---+------------------------+------------------------------------------------------------------------------+
-   | 3 | Credit consumption     | As result of packet scheduling, the necessary number of credits is removed   |
+   | 3 | Credit consumption     | As a result of packet scheduling, the necessary number of credits is removed |
    |   |                        | from the bucket. The packet can only be sent if enough credits are in the    |
    |   |                        | bucket to send the full packet (packet bytes and framing overhead for the    |
    |   |                        | packet).                                                                     |
@@ -716,7 +716,7 @@ where, r = port line rate (in bytes per second).
    |   |                         | *   tb_time += n_periods * tb_period;                                       |
    |   |                         |                                                                             |
    +---+-------------------------+-----------------------------------------------------------------------------+
-   | 3 | Credit consumption      | As result of packet scheduling, the necessary number of credits is removed  |
+   | 3 | Credit consumption      | As a result of packet scheduling, the necessary number of credits is removed|
    |   |  (on packet scheduling) | from the bucket. The packet can only be sent if enough credits are in the   |
    |   |                         | bucket to send the full packet (packet bytes and framing overhead for the   |
    |   |                         | packet).                                                                    |
@@ -805,7 +805,7 @@ as described in :numref:`table_qos_10` and :numref:`table_qos_11`.
    |   |                          | }                                                                          |
    |   |                          |                                                                            |
    +---+--------------------------+----------------------------------------------------------------------------+
-   | 3 | Credit consumption       | As result of packet scheduling, the TC limit is decreased with the         |
+   | 3 | Credit consumption       | As a result of packet scheduling, the TC limit is decreased with the        |
    |   | (on packet scheduling)   | necessary number of credits. The packet can only be sent if enough credits |
    |   |                          | are currently available in the TC limit to send the full packet            |
    |   |                          | (packet bytes and framing overhead for the packet).                        |
@@ -1720,7 +1720,7 @@ Traffic Metering
 The traffic metering component implements the Single Rate Three Color Marker (srTCM) and
 Two Rate Three Color Marker (trTCM) algorithms, as defined by IETF RFC 2697 and 2698 respectively.
 These algorithms meter the stream of incoming packets based on the allowance defined in advance for each traffic flow.
-As result, each incoming packet is tagged as green,
+As a result, each incoming packet is tagged as green,
 yellow or red based on the monitored consumption of the flow the packet belongs to.
 
 Functional Overview
-- 
2.51.0

