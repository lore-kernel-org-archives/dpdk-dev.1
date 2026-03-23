Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92544F483E4
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:53:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93A9840654;
	Mon, 23 Mar 2026 19:53:01 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 5DBD740653
 for <dev@dpdk.org>; Mon, 23 Mar 2026 19:53:00 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8296d553142so248347b3a.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774291979;
 x=1774896779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JHV/BNoUQZUqeSFgDfODMX36xh7qhwcP+5awx9t2lU=;
 b=Rin9w3TEb8Ac/6s4zlfqDPDB26FyR4a5mcstWWnPQZfD+fx7pj7NKimmqCdhxpTcZq
 sOXNDeYrEiD/JsHNWCO9IVo4GEouocDzXQOoGCbrKqDMmw487VukOruyx5eCo2mP7G1b
 eCfEGWnL56PCR4CcvmzeNG52oqiu2yNQr41kiodrW6VAlcV3xeEi0RiFsEcN7y8i230g
 kBE0PYhtGcw3PRqWo1B6AqBU9Ruyn0hkSzXgDUDETeYGevy41moabO4FKwwWQ1lt3xQ6
 EoEa5+1w3/iuO9msCwb+1ir+5BCTnsCjoQnzW8VmiIgFIsVao0MHY38DWdz9+98/bKUX
 5z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774291979; x=1774896779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8JHV/BNoUQZUqeSFgDfODMX36xh7qhwcP+5awx9t2lU=;
 b=F2exQ4DpvgolBn0Uju08g7s16mbD5wTSzdUPItIAEJ79hGOVcYK2JVKyrAtSUg7Iu5
 ugLVBszA8cJuqwN7otYHLszD1x2tBZey/LYfTAcdOMrz0DxL+PR+NnBksBARpBZYe9Md
 rUPPqFAn7+YVG8ZYo4wELEf+qp40TWDttwzLM5weOKbUIP7wqdr8Hd6D4tsDTrhvOTV6
 6o/kFfw2Y+wnYBrZ53UC6+y7wgce+zebdAcx45cjl7Nc4/Q/QZZtTint4No8KE7tVyRj
 hxDurNuXpGn6XCwg4D9B4zXYmsvIJoldaODVRoKtbDfdHdTrV9ryQ/tskdNZsWT8X/F1
 4KkA==
X-Gm-Message-State: AOJu0YwTD8gNB/1XzLitYnosgjwoR13BM3zJ5GUTIoICnoeEfa7AH9Lb
 QTVHtVJWSAvPQP7tYZGBgCldGyfjpCOzk7Qmusb9QF4OEacFzcfV4atjYMNOOdJm16CzNLJpmFK
 WFUsQw9M=
X-Gm-Gg: ATEYQzzrZY8nj8flDFaWuwMVW6KrZ6TBEJqju1LiEChsRZubMKzbmKmjNm/Ws/g+8MM
 0r1QbAMNGapODEeqUpidKnQBNF2CIQXeFuL+M7XkQr1PrqxwpHuHeDm+Mtsg/4Zm75op8DTxx2x
 VIJK9AMceQvyniAhD9Vm85pahCgNvnJ7E+NF6XDrzBNBfLXuXFrjjQfK+xbPJYZ8JjZyf5OKegu
 8lbGbd4kL0618wVYeLzpI3bmd9rjbAhvdXXMlcnFrgRmpBxr8ACV3H0WleCM+qk4++WRZCjiWwF
 NeYJvUbnbBQWVpmGcpC9mGMXkWZEPXE1G0ES6nEvF7mO/TgirFNNF5RniXeVGSCl8+gbhJh1yH7
 3eC47nuMMO/JaBHh8zdMf3dhQadFpaBtzYkBjuvJy0xvz+CcqLNfJrs7HIHlvIBuUhPywhBratF
 UJyN60xLe7h2bJgOkl1Tj5Cn8NPJtgkMLW77Q=
X-Received: by 2002:a05:6a00:2d12:b0:824:ad1e:3b6e with SMTP id
 d2e1a72fcca58-82a8c39fb55mr11299993b3a.49.1774291979477; 
 Mon, 23 Mar 2026 11:52:59 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409c480sm10205131b3a.35.2026.03.23.11.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 11:52:59 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:52:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v4] net/tap: add software MAC address filtering
Message-ID: <20260323115253.7db2b5ca@phoenix.local>
In-Reply-To: <20260323084241.81392-2-rjarry@redhat.com>
References: <20260319221034.703656-2-rjarry@redhat.com>
 <20260323084241.81392-2-rjarry@redhat.com>
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

On Mon, 23 Mar 2026 09:42:42 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> Linux TAP devices deliver all packets to userspace regardless of the
> PROMISC/ALLMULTI flags on the interface. When promiscuous mode is
> disabled, drop received packets whose destination MAC does not match
> any configured unicast or multicast address.
> 
> The receive path checks the destination MAC against the device's
> unicast address table (managed by the ethdev layer), the multicast
> address list (stored by the driver since the ethdev layer does not keep
> a copy), and accepts broadcast unconditionally. Promiscuous and
> all-multicast modes bypass the respective checks.
> 
> To support multiple unicast addresses via rte_eth_dev_mac_addr_add(),
> allocate mac_addrs with rte_zmalloc (TAP_MAX_MAC_ADDRS=16) instead of
> pointing into dev_private, and advertise the new limit in dev_infos_get.
> 
> Add a test to ensure it works as expected.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

Good to see test but:
 - test should the TEST_ASSERT macros to keep things smaller.
 - tests must test return value of functions during setup and normal teardown.
   (i.e promiscious_disable, all mullticast_disable)

 - there are helpers to inject packet already in the tap test.
   would that work?

