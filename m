Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B9C88E73
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 21:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCF5640E35;
	Mon, 14 Sep 2026 23:20:09 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2CD0140A6B
 for <dev@dpdk.org>; Mon, 14 Sep 2026 23:20:08 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-869d181419bso3551817b3a.2
 for <dev@dpdk.org>; Mon, 14 Sep 2026 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789420807;
 x=1790025607; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OHszgAoutrbPkBZGXAtxbAyvZAQfo77JPA7jcy8E8Ug=;
 b=01Q3YTUJvS7WoGe4fJbdcCVAbrEVe8vDsdedXAJ+JV9aaU0xeTt/ts/VWKooxCdDtp
 g991jhdxrrU1jHLZpjzDaUnHd7DZ9qbzpW9QaLD8LQm8AcXicJxkOaKPKmR2VR/GDQQr
 d8ks23RozYvA20zut1HBN+e2m905vF5m5j3eNFNCmhvJJTbzseHEWvhS/6P2yWusOwcy
 ahMCNnjfEZBWfuUO8SUkCxgfFxG78jiMphDFkPkieBr0L0fu2ao+dZKVJE09quRjpaq7
 7lyhXOmOulWn7B6v1dQG2XPDWVw1EuDfIsVDNPudBLRrmqj+f6JdtJkBE5rHsKffnMAZ
 bDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420807; x=1790025607;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OHszgAoutrbPkBZGXAtxbAyvZAQfo77JPA7jcy8E8Ug=;
 b=TgJ9XibPzUt19v87gryvTAg2qiCN+4K2VFglJcYA6HDMUiCKjGMmXS5FfyfQEaK4R2
 AcMydvv3YjFdtOAEUAna7DiLEis1Fv1j2Ph3tyPPhEYu+TbWvhECVJRRpHMtvP+y4HjB
 YRw+F8SEA54Hd4aP7apSnICwSDnT4bWUSVitEd25ngY/F3ZYfDF5nhurBlARtQIfkv3K
 DTP/z0pU+nO/QwI+HJzKYmG6CBww6hoJZbXjXbl4a3reTq/sGu7uJX3XRNUSPk277OD6
 r6rcDauDN0NXewwaELVyaB58X5TvoZTTLHqDOcWeO86+KxiScC3b76EtqwwuVyjJzonf
 SJrA==
X-Gm-Message-State: AFuF++lYPxb7wRrfkHA6YLJNp6NFdF0EJ6QDeSSp7M7t753xp13v0BuP
 BSAa2I6i3jWq+eYpHDSIT0OuVPIdM3MvcDIgxWlTpfq9Xkb+cHMQpo+msMOEfXRdQjk=
X-Gm-Gg: AYBFou3bapcod9OfuTU4aZR85HrEd2QGAe8ozWPCNFgIrgQ7hXVmrz7jKA5RbcOTfvr
 FUrBRei4gZSrmGI7nrfpeyZcBvvp6FvwZtclZvGN93rdbW/pUv8MT4oNLxa1vPuBFP+HjvvwqBm
 JaFCyFG4tQTfe/SyznrDZZbRcd3UhcZY9nxmtt9noo3SDzE7PHaenFXgbV5gUjWZunbUSF6hnJ+
 h0PYhkert4JM+wF7gNgnun0OnH+h54LVQgSDgibCpm9NnsaKvzQhNRWS2WXI6qmDnvO+D2TnVv4
 lCVfPOA2PXd1Ub5ZKGu8IxfZqlhBOQw+VKDsHp4cHq6VsjCnmdCWVQVIU8i9Ue4CSIbL+3QXw6V
 RXQLMRFoin2XCj89MKk7A1HgPiuh+yfj58DodleLXjr67LoxefOzRd9ppbLxWvCg3PrUbDvcIR7
 GxXa6XKroyCbCjWoDGOGg8gHHPyrir7U9CzpHUp32AWuJnuuzN1lAiJSvaP5zm6SA+iE7HYSO5y
 uZanjMV0rjQ4WAktLU9WkVoZvc2I4wmRlxkj+RR76yZSgaqOI4=
X-Received: by 2002:a05:6a00:148c:b0:848:2eac:bfb2 with SMTP id
 d2e1a72fcca58-86f85108aadmr8149580b3a.13.1789420807122; 
 Mon, 14 Sep 2026 14:20:07 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b2a3bc011sm5147086b3a.57.2026.09.14.14.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:20:06 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:19:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Randy L Tice <rtice@cisco.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH 1/1] eal: add API to get CPU socket ID
Message-ID: <20260914141956.4d0f59dc@phoenix.local>
In-Reply-To: <178941409436.3.12421464753538796039@cisco.com>
References: <178941409436.3.13205580340776837645@cisco.com>
 <178941409436.3.12421464753538796039@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 14 Sep 2026 15:28:14 -0400
Randy L Tice <rtice@cisco.com> wrote:

> Add rte_cpu_socket_id() so applications can map an OS logical CPU
> ID to its NUMA socket without requiring an EAL lcore ID.
> 
> Existing public socket APIs depend on EAL lcore configuration or the
> calling thread's EAL state. They do not cover code that needs to look
> up topology by OS CPU ID, such as building socket memory policy.
> 
> Reuse the existing per-OS EAL CPU socket lookup internally, while
> keeping the eal_cpu_socket_id() helper private to EAL.
> 
> Signed-off-by: Randy L Tice <rtice@cisco.com>
> ---
 

New API's should be marked as experimental, so there is no ABI contract.
The return value of eal_cpu_socket_id() has no way with that signature
to return error. If given a bogus cpu, that code returns 0.

New functions in DPDK need to have a matching test. Somewhere in
the existing dpdk-test would be good.

There was a bigger patch series to give a full topology API to
deal with more complex chip arch; but it seems to have stalled.

