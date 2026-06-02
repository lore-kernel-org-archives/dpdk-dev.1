Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09208CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 20:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CB06402AB;
	Tue,  2 Jun 2026 22:45:21 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 17BE8402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 22:45:20 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-137dd523634so4740417c88.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780433119;
 x=1781037919; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CahNp9W3xNnFqzksnA97nmzwCDuFT5Bak9jgapl/V+8=;
 b=xUTsQmluobUmtAHR7d1RCosiVP1usuetV0aba3JyeEZjgA9viAEXeY1ug0sSmqAyGU
 Iy8JefodjeBLHkXwV8Up415nhus3CyGEHbjWlEG7Jk7u4JMSFGGN9wdqFiIPPEJLB+Bd
 nS0IQ5qU58/4ZGL+RHXUe9KWXRzvgElr/8tTE0choGveNVcLnZOVtlv8fmE9RzWLRqTP
 UuDTqplElPTidK/5HzOZRQO56IUI/X5oO5yOhxgbTYR9InumXNPIWEaiQnKdBbQm/s2o
 vM4+HEMuyi0511D6XncouMvosr7e7gu5LYH5+nHTTnmOUbm2Ygkq2jsbAPhMaX2/fnoz
 0qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780433119; x=1781037919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CahNp9W3xNnFqzksnA97nmzwCDuFT5Bak9jgapl/V+8=;
 b=VCtOpVLm9v3XWOZo1qvfX5eoKRQGYWlq0oPciLsdz/VtANCuCJFvgNoY1e5GW8PcgP
 wCLdK9vrKzKaCL3LtZ9immTy4hxPix2ebYd29s5CuvH6bJIfB6+rN2KlpqRkTxcWdnB2
 Wd16AZt+BzZtMxQI6HVdHhrk6oTPSEyw4Ez7ASMu8HIbmStQR3qQUJ9v0LlAp/5xAiII
 T5eRJ/p7H4UF+s3dbBKv27YZbOUjv9Q19UDR0iXWr3IyN65+vfriD81bqLTJhKUE1vZy
 p53PygiCm/3yNuPjO3bqOw9DS9e+8hQEwh/ElD6e8ZybGfjCeYAJeQU2JiMyI8+j3WeM
 HgSA==
X-Gm-Message-State: AOJu0YyN+hjycAley8I37m4P5TNTjjtkLSZ1q9rw4t1MwsY7zVT4fh33
 RarBw0MaOLjqcl8MjsJ6dwsufYywMsty7eXvlCBIpzfv2BxFyDxk45/1bT0hzu5mq3I=
X-Gm-Gg: Acq92OG3oPlMVQ3bAp7Vcu61IGmsjjFpqWa5+4HfOA6vAzlqCqiSzPXNTFpSU8vcF8f
 WSmp1w4VWchyhVaQGp9Gyx2KNOwYcxUtad/UAor6K9V1dk4NR4zKUV2zCixqZ40rJrCErE+c9Sg
 5+V5KAPOB0zrCiczjk+TgCZDZoq678njp8L3rQSCAxBYPrUg09pBirkzUXR/YDh0pYW5C+aUfKe
 74hkb+x3HWhRai+hBEyoqz7bwBuFT6DdUnke4ybLBDiGKPVfNres0PIFHNh6Wms0SBv2bIo8Y3f
 z/Jl9fmgwOVGvRgVOwIpQgvTl4A2oIytsE7S2EKQ/1P8P7LCyf8cWRb1biW+UclKGDLqE0Z7wir
 UfFH+t4+9bWefdVz4nZfGd2PjVng6Fx794Wh4yZ5QWDaLUv7xWOMzKl9fZUCaXuFn8t6idFz3O8
 JqRM4m3D+MeUkf7VBKqMnK+ShtlQGZ23kErWsVHEET314oIzwQ3VFc0M23kPiFtXeG9ofO/4iHc
 bk=
X-Received: by 2002:a05:7022:6290:b0:130:6c8f:5aae with SMTP id
 a92af1059eb24-137f6a47ec5mr119745c88.14.1780433118927; 
 Tue, 02 Jun 2026 13:45:18 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f53f06c4sm681333c88.0.2026.06.02.13.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 13:45:18 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:45:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v5 0/5] Fix and improve VLAN/MPLS parsing in
 rte_net_get_ptype
Message-ID: <20260602134516.376b1362@phoenix.local>
In-Reply-To: <20260518132712.70913-8-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
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

On Mon, 18 May 2026 15:27:14 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> Revert commit 1f250674085a ("net: fix packet type for stacked VLAN")
> which introduced a regression causing single VLAN frames to be
> misidentified as QinQ due to incorrect use of |= on the ptype.
> 
> Replace the separate VLAN and QinQ code paths with a single loop
> that handles arbitrarily stacked VLAN tags. Fix the MPLS path to
> use the bottom of stack bit instead of a hardcoded label limit,
> and parse the L3 protocol of the MPLS payload by inspecting the
> first nibble.
> 
> Add unit tests for rte_net_get_ptype covering Ethernet, VLAN, QinQ,
> MPLS, IPv4/IPv6, and truncated packet scenarios.
> 
> v5:
> 
> * Split the series in multiple patches.
> * Revert the commit that introduced the bug.
> * Add support for stacked VLAN/QINQ as suggested by David.
> * Fix MPLS bottom of stack detection. Try to guess MPLS payload.
> * Add more test cases.
> 
> v4:
> 
> * changed the approach again. Only set VLAN or QINQ ptype for the first
>   encountered vlan/qinq ether type.
> * unit tests not changed
> 
> v3:
> 
> * changed the approach: initialize pkt_type=0 and only set it to
>   RTE_PTYPE_L2_ETHER if neither of VLAN nor QINQ matched.
> * extended the unit tests to check for header lengths and added ipv6 / tcp
>   cases.
> 
> v2: added new ptype tests
> 
> v3:
> 
> * changed the approach: initialize pkt_type=0 and only set it to
>   RTE_PTYPE_L2_ETHER if neither of VLAN nor QINQ matched.
> * extended the unit tests to check for header lengths and added ipv6 / tcp
>   cases.
> 
> v2: added new ptype tests
> 
> Robin Jarry (5):
>   Revert "net: fix packet type for stacked VLAN"
>   net: support multiple stacked VLAN tags
>   net: add unit tests for rte_net_get_ptype
>   net: parse L3 protocol after MPLS labels
>   net: add truncated packet tests for rte_net_get_ptype
> 
>  app/test/meson.build      |   1 +
>  app/test/test_net_ptype.c | 326 ++++++++++++++++++++++++++++++++++++++
>  lib/net/rte_net.c         |  72 +++++----
>  3 files changed, 369 insertions(+), 30 deletions(-)
>  create mode 100644 app/test/test_net_ptype.c
> 


In addition to the other comments, would like a release note for this.

Warning: rte_net_get_ptype() is a public stable API and this changes its
observable output (MPLS payload now resolves to L3 IPv4/IPv6 and falls
through to l3 instead of returning at the MPLS layer). No release-notes
entry accompanies the series. The VLAN misidentification fix (patch 1)
is a bug fix with Cc: stable, but the MPLS L3-detection change is a
behavior enhancement to an existing API and warrants a note in the
current release notes.
