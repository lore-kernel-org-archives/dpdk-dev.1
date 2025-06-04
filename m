Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7196C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 22:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D64EA402E9;
	Thu,  5 Jun 2025 00:12:10 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id A6760402A7
 for <dev@dpdk.org>; Thu,  5 Jun 2025 00:12:09 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4a43e277198so2338351cf.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749075129;
 x=1749679929; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B8Cv0VzF5SM39RlwAkOUHBO0t6H+0xldG42O3rpfV14=;
 b=mtTUa5Gk+RU0vbtFgDef8xfWa+1pQhiFWi/bmbvwmIMJU4cqcbB9eCD6TiRFA7tONB
 SxyKFhKGlPFPP4xkjyhiW7NKGPT731a/SkZu/6Xizzfp6Q39DEQKMJqPc4j9jGEQT28g
 FpmAE2Q67vvBoRCSJB1DlDXaGmEbjexfOVTIfI6jT1u/jgxEHY2v7QR0V0ZrYHOr4pj8
 8zo3s7wz23gMt6k6iHAIZlXXjsQeC1DU2hCjbzG+X8y6RiWsa5ugRS0qV4jIrtyQhG8Q
 2UU+D55NbLNhDPHc27brlz8ml30H+zs/G6idT9KylNIrw5IuDQ3hbW5F34U7uhsm8oX6
 3rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749075129; x=1749679929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B8Cv0VzF5SM39RlwAkOUHBO0t6H+0xldG42O3rpfV14=;
 b=d4jl2bKVMr4TvdI8U8qAdVG6SavIE25J3vyif+rarzTxFxTy+YZiHtJDqEIA8WdOFQ
 c7zK+FSHxZwcBETHVo6ID5l41Bj2MDBMS0E54bp67ofNjfeyJVaYcuPbQyy8Xc8zsqgO
 HdchO4V05mKMbziA1PAykqQwmJofb2KTrNli0YvW/MyMPkF2TnFf2ZHCac9qJWvfyKr3
 0XVfPvB9ON7oxDfc/YnNsW2PDUPTDkyzsqrYUv/12nAgPgTRoI4nwut6Ox2dleLt87o6
 YWMe+ZTUsYgitbXOBkGnHUfbH7zLq+yTtTv3+HtQvFZSWThDzFeKHnne96pO59vE0u0F
 7ORw==
X-Gm-Message-State: AOJu0YxLMLCHvHuSf0LqQMxkjEpjhaQCtdR64jusM6t5UjPulZWyizVH
 Cjs6D+76p1wTBsGW3uUex2alPfiFL3TDKdeGkuU6j4aRI9wkgJLVJ/K0qiLq6bGmTIfVxuf/gUA
 BGewc
X-Gm-Gg: ASbGncvNqxKkLXQ6E3W9FPlHpE09wiqdVO5KU76mAjgGkE5SiIaR00DA/ujc3fX6lQv
 TFhDwRb+3G7v5UiBaSfZpegCd7yUkCbMBeMOv8XXbAg1B2o/JuMy/mqz9zwum92G3vGnZUjt/n9
 vQ9ufNGJTBYd7N8cR9oSVXDVT/TnEMiJ4B8HCIPJ0NOV5ELc6C6Wk/Ob6ZZBaDSn0U/gS4gfIyt
 0S2vzbytSW12mYc67TDW923Zhltt3TII1qU9oueHpDCOeJmuFPlDa7v1mvct9VzSDYmnNFqF4h3
 7kaKKaz72hmE6tMUTYqsHb6+yWCAaOxrPzatvPs4In6YtP++c8dfyyXIL9kmt/MlUVOtFvMii45
 BSbP3+sqBotbKsohRqrU9bDyISomcgS9w8QE6
X-Google-Smtp-Source: AGHT+IGZr66Y5CIxkMwo5LJiBims/wPiRpMx0rNi34kiP2SRUgfJiK8KDspvLR2e7jlTkz4teb4tNw==
X-Received: by 2002:a05:622a:1b15:b0:4a4:3171:b942 with SMTP id
 d75a77b69052e-4a5a57edd55mr75581791cf.39.1749075128912; 
 Wed, 04 Jun 2025 15:12:08 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a5aea4edefsm5184851cf.3.2025.06.04.15.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 15:12:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/tap: remove unnecessary pragma unroll
Date: Wed,  4 Jun 2025 15:12:02 -0700
Message-ID: <20250604221203.126676-1-stephen@networkplumber.org>
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

Current versions of clang and BPF verifier no longer need
an explicit unroll pragma.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/bpf/tap_rss.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/tap/bpf/tap_rss.c b/drivers/net/tap/bpf/tap_rss.c
index a76f4bfcb3..6a1c3761b7 100644
--- a/drivers/net/tap/bpf/tap_rss.c
+++ b/drivers/net/tap/bpf/tap_rss.c
@@ -113,7 +113,6 @@ skip_ip6_ext(__u16 proto, const struct __sk_buff *skb, __u32 *off, int *frag)
 	*frag = 0;
 
 #define MAX_EXT_HDRS 5
-#pragma unroll
 	for (i = 0; i < MAX_EXT_HDRS; i++) {
 		switch (proto) {
 		case IPPROTO_HOPOPTS:
@@ -164,7 +163,6 @@ parse_ipv6(const struct __sk_buff *skb, __u32 hash_type, const __u32 *key)
 	if (bpf_skb_load_bytes_relative(skb, off, &ip6h, sizeof(ip6h), BPF_HDR_START_NET))
 		return 0;	/* missing IPv6 header */
 
-#pragma unroll
 	for (j = 0; j < 4; j++) {
 		v6_tuple.src_addr[j] = bpf_ntohl(ip6h.saddr.in6_u.u6_addr32[j]);
 		v6_tuple.dst_addr[j] = bpf_ntohl(ip6h.daddr.in6_u.u6_addr32[j]);
-- 
2.47.2

