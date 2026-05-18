Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F715CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 17:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F159402D9;
	Mon, 18 May 2026 19:52:49 +0200 (CEST)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45]) by mails.dpdk.org (Postfix) with ESMTP id 158EA40041
 for <dev@dpdk.org>; Mon, 18 May 2026 19:52:49 +0200 (CEST)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-65db820588aso2211213d50.2
 for <dev@dpdk.org>; Mon, 18 May 2026 10:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779126768;
 x=1779731568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwbAcG/jcmmdm8A4Tp3IBVe+4/ZZkz3QclCSKZuTd7U=;
 b=I57fdhAz0UJHKwtjTYyvUIq6FzhfF8YMUbIRPU2r7wwofBvHS73cW09Owx3uSTupny
 wwO8L02I3Xd7aqNV2IZ3ovlyPkv/qZ3GL0Dc4QzHksp2srMytlCVsSdb98XOuhNkvvcB
 bwZLyqUMY2fVTu7ILTzJFVd4J9/k5zWnidfEJ25SHQMaYnrL73JQsiog6JQMnjgFov3i
 NNXQZVQsKVD59wAV6BR5Eon1sPWBKgkobx07ccBJTw0YM9asZJ40yFfjA/bLaYssebkG
 MMujBP3QdgAL9PUJHXr0BNRP+bgBh/tmBM73UfEkuhglOAY9U+RDHLvg/jQQd035BLUY
 MNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126768; x=1779731568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XwbAcG/jcmmdm8A4Tp3IBVe+4/ZZkz3QclCSKZuTd7U=;
 b=mil5bZd6kr2ArRlpJuFq0CgxCEFBbr3iO8hbT0WuD2Av+nJ8HrgvmdHFV4AVTTK+E4
 uEpnYnk1n86DTnEEFcZTCun4HfrzEG4beSQrAPGD9nIFVEavXhayNeYo6+wNLqiMCLb8
 asEvTnHtaQn+0VDekZ4CqVqEm7BBvW+/LIRSbHUgBCJk+IflJY+hs5K1ZZu3OiIOM90V
 b6OMboSlbb9GPp2iv6DnrTVKil3pu8lCTqzRs9WQHwGwt7Zu6Y1u6I08Ag7zoScJVx83
 ye0wPZKrY2gstL6FtoRm5p7tJSmuRoRuNpALFPCk5MnqYHIrPUe56na9za92+Zxtou/W
 kPSA==
X-Gm-Message-State: AOJu0YzXtkS5gJ4KfiOErxzG60m0llbpHhN+LN1pKXKkwuAGUk38dKOs
 71b56A9aSFbotobfez2u+qqTgqAxEQtSaNbrv2rDHUb0IeZ6o7hJPnvPmQ75LM8e3j4=
X-Gm-Gg: Acq92OEHqtolWab9bpduZ0ymlIp53HvvSBgDo/sAqWX4Ljf1tWR5eoajiAcuxiPotjW
 begaZx7maBVCzzl4JeLHQnIPs2o8zR2X7ivtReCyVFmcxcRMzmtXbf6ybaT5PGqoK6ZF10wDYAr
 VEuXi7mj9isFl2nSU9VjdPNA8J6/+uSbEjPb619CfoiyZC1ez7Sk5q8szKBOyk3zskFAhe9xyxl
 90exQ7vCzqOq2KbdAcGkEMp/drpZFqb37du0nYZEz0NQGxpHzOSdNTtYZPEnvFm96RjJmbK5Kzw
 9WQbwb/ArNfoxI9Auk9CY++yqW7YT5DGEg0TBs6E8P3SMZHkJeQA+7GkcK7mJGHegdRIozCjwCs
 lwvU18nZ0etdle5dB0ClishyznATGadDhdYRzlJWJjdg0v+OhfLpMkvnjjyVQyhar+rkoDtZKGd
 c8hF//QOTJ4goeBYE+vhyIkzTLgmo3Hk2sf+4=
X-Received: by 2002:a53:acd0:0:10b0:654:6a61:fb5a with SMTP id
 956f58d0204a3-65e226661cdmr13810661d50.2.1779126768382; 
 Mon, 18 May 2026 10:52:48 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7cc991c97a0sm25338167b3.2.2026.05.18.10.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:52:48 -0700 (PDT)
Date: Mon, 18 May 2026 10:52:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v5] net/tap: use offsets provided by rte_net_get_ptype
Message-ID: <20260518105245.237e7b22@phoenix.local>
In-Reply-To: <20260518082659.13036-2-rjarry@redhat.com>
References: <20260422133615.680318-2-rjarry@redhat.com>
 <20260518082659.13036-2-rjarry@redhat.com>
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

On Mon, 18 May 2026 10:27:00 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> Instead of guessing what are the proper header lengths, pass
> a rte_net_hdr_lens struct to rte_net_get_ptype and use it to get the
> proper header lengths/offsets in tap_verify_csum.
> 
> This allows supporting stacked VLAN/QinQ tags and IPv6 extensions.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Still needs some polishing around Ipv6 ext headers
per AI review...

[PATCH dpdk v5] net/tap: use offsets provided by rte_net_get_ptype

The refactor is mechanically correct. rte_net_get_ptype() with a
non-NULL rte_net_hdr_lens fills l2_len walking the full VLAN/QinQ
stack (up to RTE_NET_VLAN_MAX_DEPTH), and for IPv4 sets
l3_len = rte_ipv4_hdr_len(ip4h). Replacing the local l2_len/l3_len
arithmetic with hlen->* preserves the existing bounds checks and
genuinely fixes the stacked-VLAN case (the old code only handled
single VLAN +4 or QinQ +8). The unnecessary cast of l4_hdr to
struct rte_udp_hdr * was correctly dropped. The {0} initializer on
the rte_net_hdr_lens stack variable is appropriate since
rte_net_get_ptype only writes the fields it parses.

Info:

  - The commit message says "This allows supporting stacked
    VLAN/QinQ tags and IPv6 extensions." The first half is true.
    The IPv6-extensions half is not: the else branch that catches
    RTE_PTYPE_L3_IPV6_EXT and returns is unchanged, and the
    accompanying comment "IPv6 extensions are not supported." in
    that branch is also unchanged. For an IPv6 packet with
    extension headers, rte_net_get_ptype() will set
    RTE_PTYPE_L3_IPV6_EXT (not RTE_PTYPE_L3_IPV6), so the
    else-if branch is skipped and tap_verify_csum() returns
    without verifying L3 or L4 checksums. The hlen now carries
    the correct l3_len including extensions, so this is a
    prerequisite for IPv6-ext support but not the feature itself.
    Suggest rewording to "This is a prerequisite for IPv6
    extension header support" or dropping that half of the
    sentence.

  - drivers/net/tap/rte_eth_tap.c:549: minor scoping observation
    only (no action needed) -- the hlen struct is filled
    unconditionally on every received packet whereas previously
    rte_net_get_ptype() was called with NULL when offload check
    was disabled. The cost is a handful of stack writes per
    packet; consistent with how other PMDs handle this.
