Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3D606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=U/5VX/2V
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D284440283;
	Tue, 10 Nov 2026 03:04:43 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 1FB584027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 03:04:43 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3b0bbdeae06so930589a91.1
 for <dev@dpdk.org>; Mon, 09 Nov 2026 18:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794276281;
 x=1794881081; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ifk+L3avkV8V8rXWnxNa6G+6E4T9V899mEY24oZu0yo=;
 b=U/5VX/2VpiDNZGcLzQ0cXT2PZ5KnpyU1wzOAmfV3Ma2wMbw8/aFEwEJE1Er75jXSaj
 eIuCvGz2wOoq/4HakLbIPg8SJcpmhsYrB6oYIbi1UJjhrhnxhmlqRhjx6yCsWlllLsFt
 8LfRoCg4Am5qjAIZik4wQDUE/9bjMvNrxnsBDcD47r4uUpl0b0jx/gOXYEmDgpjPJrVE
 82Tyy8KldEHFdQabs6/cxsAjuoT4OkPKvm4liuFlw37Nwyoqa8m/xq55szAloHyoSiq0
 G0moqQJlWxcxui8WxYHmCMsTVYHmYm97+MPSJR23qrEgNMKnhvbayyaoxGpQMo3I4AZ3
 NbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794276281; x=1794881081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ifk+L3avkV8V8rXWnxNa6G+6E4T9V899mEY24oZu0yo=;
 b=0io+5nRrlWOIAs6c22k0HXpNnuook52cIoMVybvNEbccKrSsNBu73lnixT1Ws8lyoX
 KJdheUr95jXZHzg6+pcUiHEO+xxAxveGVK0Qh3VC2JvOHVwUwaxCnRRZ+Zwdn4spCO3n
 h6YOYMBHCN5N53OGDtz6Fsu57XTPPQn6BeXM8Gh00artOFZr6wlcx6E3z9PelHg4WBno
 qoJgMS7NUdlWBg3444C16/IKZIfAYqe8VY0I+U7V8MOsRdKPWgrpLQIr7p2hnpjuetN3
 Wagmx2OWlP3RhsvuzCj0F5JkjfMjZbJRou8FOt8GMsZ3o0/kD/PB1NlwBjwpOiRG98N0
 OrLQ==
X-Gm-Message-State: APuU4Z8shCdWjO41Us9rb8ArMaUhYsW45vTleGlNhngAcKukJjysMV/P
 WhcidaMXjRScwG4iTUhdRNQJ83XRaJkhpnziS2q9Wodpdq8cIly2plzVr5hrLWtqlW2Vbamu+JI
 mu7ep
X-Gm-Gg: AYBFou38Wd3rnsS/Uo2pI4eDitwoX+6Wv7tynqnSkvK5Fg3lxTairg6ADhCmGyXH03n
 8KJQa9xSgg33QNUSLQklUJaTasFA3qykF1sw/v/KzNZwCR3bkJNu60j2yMMdFBjKweGep83DBt4
 OAAZBgzo6o0FpB291ep0TUJ5YR86lYxLQhtFFUsHglAcfU4V74mbqZIDIFqe/5JWBW2eoaKVBKO
 lmaFgcJxdtaK5ODjmzE8MThF7w4rcWwzswVc97XQwpsAZ8sHQUvvQS+p5bKtkpGdHcFeWcHM+vs
 VAndA6T1/LWrgfL6ePlXbMZedfscyxWty7ONJiJnLx1X55PnEIYj7pJPFfk9Uw8axFD0JqW+P4K
 QYL1EbbQSbMZY0bUFkla1GkP+/HSX0wEfnUKe1/akh2oAE3M5yxK9NuNMFoZQknrl7T7KN7YM7c
 fnr+9cePAF0xfDmzk9AHvyBtTkqEYSBkHLsQTv/Iiseu4qhP8mC/9VdaxtzMbgfaZsbhWIObW+c
 8YUQgICp3lH3qkLxpHSow2joUFjf2maQ+W0fdpJHJfSNm4o0kexBwcUYvrl6DMMtE5GTgUcLGfn
 wd4ULlsAnO1jLXm7BPZ2iemGAQd92LWeIERNVume4YLMq3gJm4F7ex74ns1qzTHQ53Wg
X-Received: by 2002:a17:90b:3148:b0:3a0:516d:9f88 with SMTP id
 98e67ed59e1d1-3b166cc877amr1393514a91.26.1794276281562; 
 Mon, 09 Nov 2026 18:04:41 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16774309bsm1729408a91.14.2026.11.09.18.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:04:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Eimear Morrissey <eimear.morrissey@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH] test: fix soring build with LTO
Date: Mon,  9 Nov 2026 18:04:37 -0800
Message-ID: <20261110020438.420106-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With LTO, gcc inlines rte_soring_acquirx_bulk() into
test_soring_stages(). The element copy switches on the runtime
r->esize, so the 16-byte copy path stays live and gcc reports
-Wstringop-overflow writing into the 32 x uint32_t stack arrays.
That path is never taken since the ring is created with 4 byte
elements and metadata.

The diagnostic is emitted by lto1 at link time, so it cannot be
silenced from lib/ring. Disable it for the dpdk-test link only when
LTO is enabled with gcc; non-LTO builds are unchanged.

Bugzilla ID: 2101
Fixes: 70581c355d69 ("test/ring: add unit tests for soring API")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/app/test/meson.build b/app/test/meson.build
index 2f1cd817cd..d16ca9f287 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -277,6 +277,12 @@ extra_flags = [
         '-fno-strict-aliasing',
 ]
 
+# LTO inlines soring acquire into the test, gcc then flags the
+# unreachable 16-byte element copy path (false positive).
+if get_option('b_lto') and cc.get_id() == 'gcc'
+	ldflags += '-Wno-stringop-overflow'
+endif
+
 foreach arg: extra_flags
     if cc.has_argument(arg)
         cflags += arg
-- 
2.53.0

