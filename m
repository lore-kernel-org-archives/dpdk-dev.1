Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C0C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 23:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFCB2402AD;
	Thu, 23 Jul 2026 01:10:35 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 8B0824027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 01:10:34 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-381b831d535so21871a91.0
 for <dev@dpdk.org>; Wed, 22 Jul 2026 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784761833;
 x=1785366633; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SjWz4JgSK95kDOW51RsCNQqqm83lBBwxzf17JW9Oi44=;
 b=vAtvmxnSrT7ejmARqPiKutCkJ/b3oRZkZ4T36K1Y1OVDnCr+Lm3K+n6ZUOZBEb6qdF
 D+GRH0Vw35Orzy0iqjBsDBjNHh0dp6g4PfRJMBmMCXZspIOOEdXk208aqX19u3n/ZAcn
 qSo60Y7rB3RD2OkWTMnUj6e7SzPq/l8B3arddAh3Nky7wR41QteY4vCxnTtucNk2x2m4
 rBARCUYYfS8elohppZCXWZI8YKFtwyHE6f4mbbt+KFy6TOPKHIQ8Ow03Fy3BiJylYrHW
 ZJ5cHyxs6LxwTuIwQXGqPA0tT+4kDMeOSG59X7VV9uC8cM2eeg+yMJEdSx4sgfYyEvax
 1oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784761833; x=1785366633;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SjWz4JgSK95kDOW51RsCNQqqm83lBBwxzf17JW9Oi44=;
 b=EvuSiSZ6OZ4zVjgxRuH91McDPkU5iT10vloQLA/AsBJFIxTusioOdvtSCcgDg3Mjoa
 +SJ/2gAb/ThxKkIZOTgUvoz5gKSkpyGmQIXF2G0B5X2o8rMPU4ZP+rjOiSRLQ80o10a0
 iRKXgdrxZX7TVhC6rXuDL2kLM7HECdGZd3GLreVhd8WeDs4E2dxfoGKvPW8CtTGWH7Xr
 Y0ZE03BWBjtZhzeccUTt8Lj/UlyBOtQqH6FPPzDya8fHy30rbBdorOpCQXXbtdBqxB89
 I/uF77r8QYEuvHY1l2lVVGiDw43ef3S2wLQ+l0ZRY0XtZ1QAOYHDJ4gUUCi6z1wtkqyn
 sSxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RohCeXyIkt7CwUeR74D21HexLAQ1Ym6VWvDwV0A9JgcXJA7SC1qLmGoiqi0lS8gnqFfJDg=@dpdk.org
X-Gm-Message-State: AOJu0Yw9Iry6lxGpDJ5wILF3XtGf3RW6idZZw1d1SVYfbRU+f0mBm02J
 w3ml24PvIkZBtpjAfNnSRAfU6Wn7nl8/APMLHimXKLz0WsdfpvG+SO7XQvE7MWvuPXY=
X-Gm-Gg: AR+sD13W3J+3XneEgnrVYBOaCsEQu2UghM8LcsbHyYF5w+3fR4bI6vK1FHkjUFiKvXm
 jYHNIiJsJuCQhIJP0FQ7CuxPIMN3rdz+B8O2eap1NfF3PloaZgEF0hc8yVOeJ0P/B/WIl/G3zO1
 BJPTxKLvRrGRe9S+x//6Phs2vjY4n3E7e4evl9bEQ/bTmieoQeVCU9QrxhbgGeCQZN5CHKava9c
 7B+wGMFLwG5DsZrWPLqNlKBiWDbIxS3gDbWZ5euBkFrgnmtB7J43lCDDjIkIiN9HFNtqdk1p64t
 iZGd8prdOG713mrZ+2YIS4NylbuiEZmp4zhNdurX1gaGM/ncf0T533xjTcerdj3aWZpnCANn1ee
 mW6bqPk/Xj3wzu+SaMK5FMyZAyH35Iw0qYP/e5S517PsfSswna5qSEVtY8ja39SdRr5vsgnuyHK
 7RXhkkFGyQyeLoK9WZP4PVngx4VrhaK8RCff0FmX333xs=
X-Received: by 2002:a17:90a:da8f:b0:37f:9ce1:cda8 with SMTP id
 98e67ed59e1d1-38ec687719bmr629494a91.30.1784761833624; 
 Wed, 22 Jul 2026 16:10:33 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130a8421sm8839836c88.10.2026.07.22.16.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 16:10:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:10:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 dev@dpdk.org
Subject: Re: [RFC PATCH] net/bonding: reject control operations in secondary
Message-ID: <20260722161030.54962462@phoenix.local>
In-Reply-To: <20260708174204.72574-1-wpan3636@gmail.com>
References: <20260708174204.72574-1-wpan3636@gmail.com>
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

On Wed,  8 Jul 2026 12:42:04 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> +static int
> +bond_ethdev_primary_only(const char *op)
> +{
> +	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
> +		return 0;
> +
> +	RTE_BOND_LOG(ERR, "%s not supported in secondary process", op);
> +	return -ENOTSUP;
> +}
> +

Minor nit, the function returns 0 or -ENOTSUP but then caller
always ends up just checking for 0. It might look cleaner as boolean
function or wrap the whole thing as a macro like ethdev does.
