Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34670C369C2
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 16:07:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35F9440263;
	Thu, 24 Apr 2025 18:07:19 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id D236C402E3
 for <dev@dpdk.org>; Thu, 24 Apr 2025 18:07:17 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso1616418b3a.0
 for <dev@dpdk.org>; Thu, 24 Apr 2025 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745510837;
 x=1746115637; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iUGJGJvJtBwtpwR5Ur9n/Rv3civamppU7EbdWoLQ7B0=;
 b=Q+W2BjCuis5C/KwGzrGq28GU+pjpzus679wk8YebF0LR53TA/4qTkxLbwpiF1Fllb1
 IGgM3By0qXNNAhWbXNLHdl28cwijf6eJAnnA9/Y14sLuVR9G+fl2rqXIcU8N58lMMIdc
 VheaOqTdbU6nuw+4LPsnt0EUDd5VLzZfXkJim0aJOtI+DSGCN/UWeVxk3BZz4wy+kwUB
 wT+2Mqun2XocOEi4wdJlUlldzEw7mSozICe/vfZfsZb6rwpTR2yirLcplB9XV2pp17f6
 wjhxSuEEnvYaIc5PdzlMC4XiQaR9+UsgKm2jKE5kXl+8T8L16SvAsC/jOaXU3e+ts/xr
 em+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745510837; x=1746115637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iUGJGJvJtBwtpwR5Ur9n/Rv3civamppU7EbdWoLQ7B0=;
 b=QNpTcmR+YvGlwp03m3xvkXGk2sWhECdZfRnJgjmQfN2GS1/ojK1vqDw/pFBjzzIQzG
 jHwS6AAdUjKzoi/5uE0UBVogXLTQmL+amhB/uRCzRWurlTcURxJ3iWlGQPGRpIarRGSY
 lhy4rJb7z62uerLWnzN9GoCdeBSvbCn7wADdpaXS6NGFIZ3Q2Jd9yiA5X2eczXK0ZGXt
 +QeODT+fMPSKDz9gYMh1R/lIdbhXXj5UdNRBq56OWxNvpxH6rrb/XkrnKlcB8m+aaP0V
 yZaC4j2ifjV89wrQ03BqY9mH2xmkjDm11or4CMG5pJbrX1ERiYZlVgi7tNSvM3qnHqPT
 MXTA==
X-Gm-Message-State: AOJu0YydtO9jRK4d6RZcs2RgN3FKh/gVRizEro3lRL3sCD7BUMcFRVxD
 BSn6xWg3174JfGBBhTuncdslDt2WLp7x/YwHp5vg4j0iaftzdc5rN2AJ/8ZErGA1TzEss0CWhxs
 q
X-Gm-Gg: ASbGncvPolCgdENUC5IXmqpawMO8Lh/mIHS1+FjDW8c9O5Q/5o6lI5jgwXAcU8EPxLg
 au01VYjNH1WrcnfdAhL+q1i6GK0c5yblCvimElrET8yz5EqAY4V2FUn1C1G0r2Z63vtrI/dUEHc
 DJucv0jX6io53q9qqD9i/EroIF+sEe6edbrJ2F5sPUr0H1d5X/vUQzp6n7zE1ZAOYtN9w2FdMam
 CCQDmHs763Lbutl4c9zskJw5cPjQ+ep0pKtW8+MdIk7Wx7t6vPPnWRjDOe5wsPGBHxoggknV574
 +lPHjKUu6P0IMiEueZUcdzNaavIlrcT+jFYZue2ioxQ0o2sWgA9Chq0qn7rbOwdtA8EguLvwlj9
 UlbHpf1mKooCdm4deU4bCt+YTG7w=
X-Google-Smtp-Source: AGHT+IHkHU6q+Ps1xYef0YVg+LiC5EIG09T/9ViOJ1XDhBFlCDGiUJe22ZRt5rgD79HHs6mkWpXfUg==
X-Received: by 2002:a05:6a00:843:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-73e2463558cmr4066134b3a.14.1745510836738; 
 Thu, 24 Apr 2025 09:07:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912c94sm1586590b3a.3.2025.04.24.09.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:07:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/tap: do not force inline or unroll
Date: Thu, 24 Apr 2025 09:07:05 -0700
Message-ID: <20250424160705.19655-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

The BPF code in TAP device was using outdated advice on how
to write BPF programs. Modern BPF verifier has to do less work
if force inlining and unrolling is not done.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/bpf/tap_rss.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tap/bpf/tap_rss.c b/drivers/net/tap/bpf/tap_rss.c
index 025b831b5c..a76f4bfcb3 100644
--- a/drivers/net/tap/bpf/tap_rss.c
+++ b/drivers/net/tap/bpf/tap_rss.c
@@ -34,14 +34,12 @@ struct {
  * This is same as rte_softrss_be in lib/hash
  * but loop needs to be setup to match BPF restrictions.
  */
-static __always_inline __u32
+static __u32
 softrss_be(const __u32 *input_tuple, __u32 input_len, const __u32 *key)
 {
 	__u32 i, j, hash = 0;
 
-#pragma unroll
 	for (j = 0; j < input_len; j++) {
-#pragma unroll
 		for (i = 0; i < 32; i++) {
 			if (input_tuple[j] & (1U << (31 - i)))
 				hash ^= key[j] << i | key[j + 1] >> (32 - i);
@@ -54,7 +52,7 @@ softrss_be(const __u32 *input_tuple, __u32 input_len, const __u32 *key)
  * Compute RSS hash for IPv4 packet.
  * return in 0 if RSS not specified
  */
-static __always_inline __u32
+static __u32
 parse_ipv4(const struct __sk_buff *skb, __u32 hash_type, const __u32 *key)
 {
 	struct iphdr iph;
@@ -103,7 +101,7 @@ parse_ipv4(const struct __sk_buff *skb, __u32 hash_type, const __u32 *key)
  * Parse Ipv6 extended headers, update offset and return next proto.
  * returns next proto on success, -1 on malformed header
  */
-static __always_inline int
+static int
 skip_ip6_ext(__u16 proto, const struct __sk_buff *skb, __u32 *off, int *frag)
 {
 	struct ext_hdr {
@@ -150,7 +148,7 @@ skip_ip6_ext(__u16 proto, const struct __sk_buff *skb, __u32 *off, int *frag)
  * Compute RSS hash for IPv6 packet.
  * return in 0 if RSS not specified
  */
-static __always_inline __u32
+static __u32
 parse_ipv6(const struct __sk_buff *skb, __u32 hash_type, const __u32 *key)
 {
 	struct {
@@ -207,7 +205,7 @@ parse_ipv6(const struct __sk_buff *skb, __u32 hash_type, const __u32 *key)
  * Scale value to be into range [0, n)
  * Assumes val is large (ie hash covers whole u32 range)
  */
-static __always_inline __u32
+static __u32
 reciprocal_scale(__u32 val, __u32 n)
 {
 	return (__u32)(((__u64)val * n) >> 32);
-- 
2.47.2

