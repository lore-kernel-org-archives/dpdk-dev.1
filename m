Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A01CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 20:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EB1040669;
	Tue,  2 Jun 2026 22:45:31 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 237564065B
 for <dev@dpdk.org>; Tue,  2 Jun 2026 22:45:30 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-304fb780deaso4380781eec.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780433129;
 x=1781037929; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gTtpU9g8JIP9EtY6Da3BwWy6RS3/we7bY8//LUu2NI=;
 b=jvAM5Lb3PT4L8jC25aX50PAIuYSrTZ+7Yx44MjgfcSJId+nmeAlsW3P3fkuENxvuYa
 RenwcrRH8Cek+ADnHzCfEM4nW6C8VdpN6EYaPKGIPubBOcGZbXZ6bRjAJTh2NeG+2mUG
 dRJDFyc21NqQlGA37D/vv3upQRZP/ALG9AcKv3+pxMee9Pvm1uorXipFg1wY1B1ddQOD
 Jk22gEL/kZUry5RlyRfnVkukmcbnVJaQldASm5CWEwq2hVY32yCowNcJH2jaKIFQ7mtg
 HLPzUMnN5VkKVtBycx6x1Z4EXU9cjF5DF3Z4LtWTlZnSaD8RemuJ16mCuP00dwA3s1eh
 i9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780433129; x=1781037929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8gTtpU9g8JIP9EtY6Da3BwWy6RS3/we7bY8//LUu2NI=;
 b=d7zAhSyQ1tURN6QD77CYDkIlGK9WaDyqwpADueRyl4iofQ0xRlIl2fvVwL/t8ay3oy
 Em3f9MwyVKwP16W6pMwYlxleIAejmJrJT/BsrjJREjxI3YE2CZqtRAsNdOqkMGbVQILc
 3RKJ/O/F/HaWOPs+YdyfC+/gc4pFaXKzXMvCvGXxSP6fWeKEZxwwYrku7g9mlgqH2e2/
 +m4WhIDHaN+2COexTjzVGfogvbEsnaRDlfxahuOm03LqVMHVKHuRb+j0H5E5x0TcjfiF
 4qe0yMN2MSkFRUsvzkssJddsDCegM6mYAie2NrGDtY1adWEXwG6IcgXy9Mgl9pb4IqgR
 JCmQ==
X-Gm-Message-State: AOJu0YzpfXMyM4ap8gnLF835W6jvFAz0yL4TWOHp5EEY+7LSYt3EmPM8
 R5knJPjA6GmopIGuOGBYdNCdqsULATkrPyovR+AlzRiHyr4FVQs6XwFstn+vi362RtvHlnRgfqR
 GksjE
X-Gm-Gg: Acq92OGHJof2/8hIxoUn1YH96tDUaSiAbbcmDYZqdJChKYnWbW5o0VXWl1Tspv0AqY3
 yrcz9wJyDv9WPCGNHmHpz+bbq3OxmVjgsn5HkK4so2/YlG+91AiOjwn3zqtZn8XLicDEbBbIAwJ
 Ch0uvPAlI+9IdXOq7E5gml21vT/gdeBwHAHEZ687RIfno0D4J0EPsknS0OQMmlyH+7oSDqwxZgJ
 47aRKVDJ7VgtYR9Vb1eudunLpoIh/njJYL6G83Rpm2+Z5JCxqdrORkXmlJpvlveQN+KYbs0fEdT
 GAt0ISwlP+jNz/Tt0aQQjXgbJhY8bygEE3I3L9phOHDWSQIFR6+oY+zQf5yQuvlvmqqST6Vz9Fj
 69MiHfm6ZmG/ehcw8TPPumzVhPByUorijrQNJmHCkxG43Y0SRBh2YbYeIULe9zYzTyXQzJWJzIq
 4CwOSpSnxza/EG+V4zrRpCFkwHNqLrgcLqw6vUkvCO5afAfypqXaSPy0pcx518t/wmcow86o0aq
 2k=
X-Received: by 2002:a05:7300:8b84:b0:304:2e00:5fb5 with SMTP id
 5a478bee46e88-3074fa56a0amr209280eec.3.1780433129157; 
 Tue, 02 Jun 2026 13:45:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dea9226sm418985eec.19.2026.06.02.13.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 13:45:28 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:44:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v5 4/5] net: parse L3 protocol after MPLS labels
Message-ID: <20260602134437.49e0d81e@phoenix.local>
In-Reply-To: <20260518132712.70913-12-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-12-rjarry@redhat.com>
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

On Mon, 18 May 2026 15:27:18 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> rte_net_get_ptype stops at the MPLS layer and never identifies the L3
> protocol of the payload. Also, the label parsing uses a fixed maximum of
> 5 headers instead of checking the bottom of stack bit.
> 
> Use the bottom of stack bit to consume all labels and inspect the first
> nibble of the payload to determine if it is IPv4 or IPv6.
> 
> Add test cases to verify this works. Ensure that an unknown protocol
> after MPLS (e.g. ARP) does not produce a bogus L3 type.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

AI spotted similar potential uint8_t overflow here.

Patch 4/5: net: parse L3 protocol after MPLS labels

Warning: same uint8_t l2_len concern as patch 2. The old loop was capped
at MAX_MPLS_HDR (5); the new "do { } while (!mh->bs)" is bounded only by
packet length, so a deep label stack wraps l2_len.

Info: the local is named "nimble" (and the read into nimble_copy);
the comment says "first 4 bits", i.e. the nibble. Likely meant "nibble".

