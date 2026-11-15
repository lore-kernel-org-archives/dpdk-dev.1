Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D80606A31F
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sBvXtA9c
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF7BA40150;
	Sun, 15 Nov 2026 22:23:27 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 37CED400EF
 for <dev@dpdk.org>; Sun, 15 Nov 2026 22:23:26 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3b09c07b3d2so1653362a91.3
 for <dev@dpdk.org>; Sun, 15 Nov 2026 13:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794777804;
 x=1795382604; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4WZcx/7cF0R4gLBg1UC/0m+wy+R2Yirt/j49owgiu5Y=;
 b=sBvXtA9cnOdHtDENKV31HByQRl1TiEQW+4haH5HCnaCOKDe0l9xhve7sa7MhMzpxfi
 3lMHVASH6RrWLzXOptXaFrMNefOo7w8w/W2qJFuqE+b6MDbWwtG6qbHbxeLoH/FxfNdy
 0y/o37nWPxXRR/u04AMnyEmCCaf9KC+lRyREferopHJcQNWBgkcfCT/asfBPqwGO48ac
 G/s3PTJbhaDJ1rr1O/h2xpVNbOHsiUAHqbAAkBa1vKCtREOD5VEgvq4GxlGX4WfC+KxK
 yjF2NkPWlShpK7dMPcnobUeRW59OgZyjgpV7LxZCrzfAJo+EQXaiaM/qlfe99gCZ5UR5
 3Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794777804; x=1795382604;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4WZcx/7cF0R4gLBg1UC/0m+wy+R2Yirt/j49owgiu5Y=;
 b=UIh38zTqrd8TpnhCHtgO5DZwFDpzAx/YC98Q9fKPvSp1Rw+GhlaUdOGsOPep+Ms0Ji
 /9sOlQ7VW9007IucAvzpMi7RsPlkS9Xd38/hwVFQd/LgLmGMczVPQgK3XOMc/PWkrIQx
 L1Zfcd+GOEhdnXrCXULhQHpWgUIOcQKqmS+hq6zfqZsH+yJ0ISRUD3nh2zgMAHUcWg4q
 1z5Oo1KJ9DiruLYfkRAEJAlRCz3oaLLUWNjJ4g6LTp2rtIXbe06n/8AJ4PpUChZFjNJC
 M7XvpkjtHi9YrZy3L9+ZS3X7yGW5mED+NZvtP8cpgJp2CLqaeNZZFdAWCR3SJtipjcJ5
 /Jeg==
X-Gm-Message-State: APuU4Z9U8O5/No+5BjBu1S9dDDkHYC1vkjfm38C4U5DiH4xVuXaUn7gE
 TxDbJKmAzgc2jl9YEtYWyfgJB9mUvBlmtAGV09kFRmjbZc8ImBGlace/AKGbLsp7g2w=
X-Gm-Gg: AYBFou1JB68px44u9iN1Ub1fqQo1f8zDRB5f6qrlWYWPE1H3NUvDCFWV2G6dzDcmHaM
 ItIgtvpB54BNWtZLlmjclAv/urhXF1qVIvVGYetX6H2Vd0u90RoT9W1x5sCAd+eCT/U3fI8Z77T
 F6rWYRZ+X35vB7Rw7b4XeFVjqRyiWT703LWcAepIzV1ABjkUV40yzMUM00/QI9r3Hp5fTzbqkK0
 RcQFvAGXkAj4r9hY2JWxPam9ScSQuIeF5jC2ClC+Gz77DGJpdl7EsTAw5sK3NJHjwIVgZlG18MT
 mwfEnA6Bxi/FLo8eC+vyfbrnJVwpkoob6TJa7999v5G6MZn1Z1jkeuHCzc4BAKzIoVbXrkkgnyk
 MNBXJUBClEg2EhcK+7ZP12uVP41rrxqQoCX4KwkNC7XP0fuG8qA3/giadALB8lsqcfrxr3o7ZcU
 5YbrUeETMwnj9I10LZG5ULflZUtQC7YAFNqs3DQLDAS6CMyvB1E9B9StK5SLq4lKGj8UuoIWKgP
 IASVf3l4FAiRzbaGoFiePEHuuki+hxBlqmgjuMLSAu+TgJVbeqd3LCouAvPnt3pPrSufcRB9jJt
 FVGiWgZronv6NPh0SjCjLvectsqF0EfybIikRAQnN5JCtHHEOaYdB7IoqD6EdmdL6jWRATcIWQ=
 =
X-Received: by 2002:a17:90a:b116:b0:3b1:bd5d:53a9 with SMTP id
 98e67ed59e1d1-3b1bd5d564fmr4842068a91.63.1794777804308; 
 Sun, 15 Nov 2026 13:23:24 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aec43699sm13319088a91.10.2026.11.15.13.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:23:24 -0800 (PST)
Date: Sun, 15 Nov 2026 13:23:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ajit Kumar <Ajit.Kumar@amd.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] net/axgbe: serialize PHY and link status access
Message-ID: <20261115132321.0dc24dfa@phoenix.local>
In-Reply-To: <20261112135611.2757325-1-Ajit.Kumar@amd.com>
References: <20261112135611.2757325-1-Ajit.Kumar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 19:26:11 +0530
Ajit Kumar <Ajit.Kumar@amd.com> wrote:

> From: Ajit Kumar <ajit.kumar@amd.com>
> 
> Concurrent link status polling and PHY access can result in
> simultaneous I2C/MDIO bus transactions. On systems with multiple
> AXGBE ports this may lead to I2C transfer failures such as
> -EAGAIN, -ENOTCONN, or -ETIMEDOUT and can cause incorrect link
> status reporting.
> 
> Serialize access to shared PHY communication resources by
> protecting PHY status updates and introducing a mutex around
> I2C/MDIO ownership acquisition. Also add retry delays for
> recoverable I2C transfer failures.
> 
> Signed-off-by: Ajit Kumar <ajit.kumar@amd.com>
> ---

AI found some issues that still need addressing before merge

Subject: Re: [PATCH] net/axgbe: serialize PHY and link status access

The global axgbe_i2c_mdio_bus_mutex is the right fix; it matches
xgbe_phy_comm_lock in the Linux xgbe driver, which DPDK lost when the
global lock became the per-port pdata->phy_mutex. The other two
changes do not belong with it as written.

Warning

1. link_status_mutex does nothing useful.

   It is per-port and only taken in axgbe_dev_link_update(). It
   cannot serialize bus access between ports (the problem in the
   commit message); the new bus mutex already does that inside
   axgbe_phy_get_comm_ownership(). It is also not taken by
   axgbe_dev_interrupt_handler() -> an_isr, the only other path
   touching PHY/AN state. Two concurrent link_update calls on the
   same port are control-vs-control, which ethdev does not promise
   to make safe. If they can happen, the lock must cover the ISR
   too; if not, there is no point in it. Drop the mutex, the struct
   member and the init.

2. Retrying -ETIMEDOUT and -ENOTCONN.

   axgbe_i2c_xfer() already waits up to 1 s before returning
   -ETIMEDOUT. One retry doubles that per phase, and it now happens
   with the global bus mutex held, so every other port's
   link_update blocks behind it. -ENOTCONN is an address NAK
   (IC_TX_ABRT_7B_ADDR_NOACK), meaning nothing answered at that
   target, not bus contention.

   If the bus mutex fixes the concurrent access, these errors
   should not occur any more, and retrying them hides a different
   fault. Keep the -EAGAIN (arbitration lost) retry only, or explain
   in the commit message what still causes the other two after
   serialization.

   In the second hunk "ret &&" is redundant, and the closing brace
   in the first hunk is indented one level too shallow:

	if (ret) {
		if (ret == -EAGAIN && retry--) {
			rte_delay_ms(AXGBE_I2C_RETRY_DELAY_MS);
			goto again1;
		}

		return ret;
	}
	...
	if (ret == -EAGAIN && retry--) {
		rte_delay_ms(AXGBE_I2C_RETRY_DELAY_MS);
		goto again2;
	}

3. Missing Fixes and stable tags. The per-port lock dates from the
   initial PHY code:

   Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
   Cc: stable@dpdk.org

Info

4. The static mutex only covers ports in one process. When ports of
   the same device belong to different DPDK processes, or one port
   stays with the kernel xgbe driver, the only arbitration is the
   hardware mutex. axgbe_phy_get_comm_ownership() writes
   AXGBE_MUTEX_RELEASE to XP_I2C_MUTEX/XP_MDIO_MUTEX unconditionally
   before acquiring, which can take ownership away from the other
   agent. This bug is older than the patch, but the commit message should
   say the fix applies to ports in a single process.

5. Suggested commit message body, once 1 and 2 are addressed:

   The I2C and MDIO buses are shared by all ports on the device.
   axgbe_phy_get_comm_ownership() takes the per-port phy_mutex,
   which does not stop two ports in the same process from using
   the bus at once, causing I2C failures and wrong link status.

   Add a driver-wide mutex taken before the per-port one, as the
   Linux xgbe driver does.
