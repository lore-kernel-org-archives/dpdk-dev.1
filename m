Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50658CA600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 16:10:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 628C64027E;
	Thu,  8 Oct 2026 18:10:20 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 859D940269
 for <dev@dpdk.org>; Thu,  8 Oct 2026 18:10:19 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8897e83332fso446864b3a.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791475818;
 x=1792080618; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KPvpLA0vtwpKRmlNaCs56pAY8vtQdpbGsp/svTb0QKQ=;
 b=n+zFvhZHJ9+UVer7lc9/oHjNztpqCpY7nTInwkNvG6jszkr2Am9CzRXuDj7mdIK+wX
 F6ZhYNUSs6U2zOkSL0X5dkmFfIO9a3QxYwvw/8OTEh3rzoSVNuDkxJE9t9rNERJgfRjg
 oD1YkxeQ09/9mTZdaRmfBndATCXNALy3dCkU3fGzgE9rPAJhQCbFKiwqpFkj3HovvL0l
 9zPOYzc4XB3qBxKvjD0otmdX0Xud9KMjbG38SBIu7GW9V9RqKA7Y3LFPynO7UH06xqug
 en22FiXmUHqRHy+M0ztxxc2ZZ4f7sXR5LcmCcJEstOA8R1aMuXsYsQJfOIm8q7sR+Q3v
 hwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791475818; x=1792080618;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KPvpLA0vtwpKRmlNaCs56pAY8vtQdpbGsp/svTb0QKQ=;
 b=2CcE0JYVlpWmYpnJEYTp9hymP8A4herKxKo8UOP7VcoqzxcYkZOgV5S06RaLTaAoj7
 J0r/JkqEJFbcfsFR/ISzxoYpsa6UQpMtTeIdP2Cim5kl7My5O/5EyyO5lzswmbWB4mTC
 ZjmdXacCr5iKAUo+47mcpNLRS5/qpXJ64FgB2wfp44KJbOPXsJUH8O5sF/jgsw3wFFtB
 G3dViy6HyBe5S3Df0hln7gZAf31RFjukddU4vTnizON2Ygis7qUyiuL9LW97P+wX6JA2
 o/dqVOYlvYmbTSVBDrUc2/7r2wNA3haA9lLx/7aLFm5IMtJdwTjmTQhHnzEJ7h8ViO4t
 SX6Q==
X-Gm-Message-State: AFuF++m9X0VN5Pq4boa9yxjZyUpaFhAh/RVZxoHl1jYolKYh+bDtgP6U
 5HoSsfuhn5KhdxyFmJ74ZO5oAMg3U8iEJ54pxqw6zqZGcrY91k2wHFwBNzUU4KFFues=
X-Gm-Gg: AYBFou0fc4v53qQv7jyjLAd7W6RYxHgvmF5Hh6Ab9D5sDfKxvYDgiVP2BQl7dxgfSdt
 Y2w3jTV6Xbx5zYKlgNfV15n0x58r5lnaxlHP8e8E3XkcxKPbdFMr6FwLSVF1Y5R9t1SUJ6ZZ7pf
 FczqqyC0y3VBiBx5K4Uo2ZTC0msoKKRh39EW+S+bT+q+VeQn/ME5cccnmb4eP7pUI38dBB/AIbP
 eZDmjZ3RIvrVBWgwL3pK5WLSFCX6sWozQA285KKadqPrVjzajSLuRljKPdRF7hYkqpF3w7oWPBw
 nJnon/mFkgWq37c7W6LHMB1GN5ornFvVlhRkYfV4NAzLjCivu/a5Hpm8Bfyy/mcJ0jZdvpkc3v/
 M9K9im2waNv7dL0VlxTncVdvG11AyoqvPYh5Lbu8TNssH/xWb1ftYvSyDjmYyhXX3TOco5DXMHA
 BI3YqGx02zJV1bhXJGXNZjQDfAOXQs7Jcp8QtykePG6KDPvT+24ireBTRWuqdBQB1ImBJ8ntICg
 ZYYhgihspc0ErmqFK20CtrvAHhULz2EI4sgskK1
X-Received: by 2002:a05:6a00:1954:b0:881:236b:748a with SMTP id
 d2e1a72fcca58-8930a0f77d9mr2062604b3a.16.1791475818217; 
 Thu, 08 Oct 2026 09:10:18 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-895ecc4d41bsm159792b3a.30.2026.10.08.09.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 09:10:17 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:10:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, aman.deep.singh@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH] app/testpmd: add command to decode module EEPROM
Message-ID: <20261008091013.0d6f73e7@phoenix.local>
In-Reply-To: <20261008080203.144487-1-roma55592@yandex.ru>
References: <20261008080203.144487-1-roma55592@yandex.ru>
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

On Thu,  8 Oct 2026 10:02:03 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> The "show port <port_id> module_eeprom" command only prints
> a hexdump of the pluggable module EEPROM, which has to be
> decoded by hand against the SFF specifications.
> 
> Add the "show port <port_id> module_eeprom decode" command
> to print the fields decoded by rte_eth_module_eeprom_parse(),
> such as the vendor, the transceiver type and the digital
> diagnostics, in the same form as "ethtool -m".
> 
> The EEPROM read is moved to a helper shared by both commands.
> 
> Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
> ---

Applied to next-net
