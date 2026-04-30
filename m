Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800B1FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 14:09:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 689D14021F;
	Thu, 30 Apr 2026 16:09:37 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 60EB9400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 16:09:36 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2ed0a45e970so1093881eec.1
 for <dev@dpdk.org>; Thu, 30 Apr 2026 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777558175;
 x=1778162975; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6hbLSmHtopLbe5T/AnMSGhlvNmmcQd9eikMGqZclV8=;
 b=VA5yH6Fxr3Sb7qEQjzwoEapC7N76jyMQleJXU/VedTbrcK9DwD+T6tQsFyGSgxZd3C
 2OUAxipcPAhdAcxBYwBCDuMY/3nUooc6CjcjJOBs8MquK3G3pZVS0mjD5FwNwrFHrh3g
 /XaaFc+PQDdfFMeb5jgXt0o1n4qcdhQKfb/KQly/J/hQCoRt8rgDzB56GDEsP8Y8lJG3
 YnnNrYZVd1SC+bPzZIfP0aVjAjqPWuFZCeYF0+Wldt5n2vi0Mznw5QVh23x5QH/JcFs1
 KI37YQ6MJklD7DGy8km2s8o/BY0tpQOgjcR0YLrZKna+EAMHu9K+dpo652U8QK5rWdpM
 kZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777558175; x=1778162975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N6hbLSmHtopLbe5T/AnMSGhlvNmmcQd9eikMGqZclV8=;
 b=hy9Q9jJBTguWwb1kuQqREIOVPTpQJLqhgPjdB0Oe5ax54o5ai4OOfEpZgp6cZfyPYP
 AD7BD20QAWoQbhxyzKL6WGitg84Ik4lmbTyawD2O33jDAPTpU2tFdgzeuaw7+GRHKops
 71omYvwhRoU47pgKorX7p7KxbwDy006Lyr8L5gois7XNCGJz2gICFD4vNFDq39O5bZSp
 kbDXq/usCGZ0taMk5GUR6mFFicoFNwmMz7E8mMwIwkcgEXVr4Z4exg921ky3nojjKOct
 b981fMo5oAHZkgjddOzE8PHiflbxsje+w0BUYTxuaOT84AXKe/MZ1NXHgvTVe5Y9WCsM
 HqJQ==
X-Gm-Message-State: AOJu0YwS8oonrS4uCSXreqxJs8nDtDzRnkueRuWkS7hdhYobFa7ZsTHb
 y6Z7JNN5iH2VhTUwYXtP/48WypUZ/bvEfaoen0qFALydX2prJKHXBGXOwgwl0yASwQo=
X-Gm-Gg: AeBDievCCmzFmCmcteY2eq+hRNoohYeEk0st1clZ/YmwL1kPBfvTU0tNq+crR8WnF2A
 7eUiqTPZLlOqcPlnkSQLQ5A6Q9RzDtaenel8x/T56sNOc84AGbla9OFbuU8LlSQ7OvWF3sfrs05
 KZjlAFFcfRqtvYzPnvXb+LNpuZ0BvL1BPqPNZA/0mzjCmlUxEgPPvnfBdOq/sdEWY47lwqQKj+x
 clDlrakjIdszFFsd1MZePP7CoUnk0qkOnuLqD0z16Kavypxg98nI/jrLW+FXaGRuUjpOFhUOjys
 H3uN5vXoDWQpq8ur4II0x+DCu0SbFqLZpgVFwzw1Ww7YOAuuryGM0hjytmVYIDqS1cv3DSN/KOu
 xDj8H3Hh2AZVdukxd3j4kwwfjnwwQ5UV++v4OX2WPT7fqxPvyhUKMuHfzLpDChUTUuipfVUkT6A
 8GkglhjvQ69z4C8WgHnJ78Sg5S9jFpj1XNazB5AK2OSDnKuA==
X-Received: by 2002:a05:7300:df4c:b0:2c1:6cfd:73ee with SMTP id
 5a478bee46e88-2ed3dcb58bemr1523714eec.24.1777558175287; 
 Thu, 30 Apr 2026 07:09:35 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0cefc1sm7065125eec.28.2026.04.30.07.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 07:09:34 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:09:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, reshma.pattan@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, marek.kasiewicz@intel.com
Subject: Re: [PATCH 6/7] pcapng: add user-supplied timestamp support
Message-ID: <20260430070932.16d20726@phoenix.local>
In-Reply-To: <20260429073111.3712950-7-dawid.wesierski@intel.com>
References: <20260429073111.3712950-1-dawid.wesierski@intel.com>
 <20260429073111.3712950-7-dawid.wesierski@intel.com>
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

On Wed, 29 Apr 2026 03:31:10 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> Add rte_pcapng_copy_ts() which accepts an optional timestamp parameter
> in nanoseconds. When the timestamp is non-zero, it is used directly
> instead of reading the TSC. This allows applications to provide
> hardware PTP timestamps from the NIC, enabling accurate packet capture
> with PTP-domain timing rather than host-local TSC values.


Also, the HW timestamp would have to be in ns since Unix Epoch
not what HW clock is. That is a hard thing to do...

I would rather have the pcapng infrastructure know how to use
hardware timestamp dynamic field if present. But the problem is
getting the conversion right; it would have to compute offset and
resolution per NIC, and NIC's roll over too fast. The problem is
hard.

Bottom line: needs lots more work
