Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE21CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 22:17:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BECAC40279;
	Thu, 25 Jun 2026 00:17:14 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 07EFD4025E
 for <dev@dpdk.org>; Thu, 25 Jun 2026 00:17:13 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30b6dad2382so2806695eec.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782339432;
 x=1782944232; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFJL6iD33aqDwl/f3G2GjFyVRXAVXKODdQDERUyhBxM=;
 b=KPuvwRWoaIuKppImw+19UT8zV55PrTY3bKongCcflofHQl0Gc1zmLQkF+rQGR8y7a4
 bJ+6WMzZqJAdAypoOEwB3sGg+cbNcr5J7D/t3NkNDZCJvTZwJZOyz69kbvrCx/PRIOVy
 CAi9amHzzcYKnQ6EVaMxSa7G+G1UfQr61Nw0IoD/iWGqTcomLZbNDmpsv0nTgnnJ7Bdi
 SOmP5of4E+aKcoU0NRjFxLMP87DrzHQPBJsrYqrosADyn6+4GS0y+4ZrCExFjklefV5R
 roAd621etGC9fX3Lfowuj0JzhDyL+cbgklRHkqQ22/8u2SmhQ+IwDlbWe+PH9190SycJ
 EfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782339432; x=1782944232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jFJL6iD33aqDwl/f3G2GjFyVRXAVXKODdQDERUyhBxM=;
 b=MzXzvU3VXEnuk5P74/ln6kJmt/WYuAGWtOVsvL6a6AuGunqhrgKOWIlkYq5uigFjpa
 bE+GqWIgYeEGoZ6/VJHI17gOuy6YHaNbuW6GwWIfujruJSk5yYj/FonUxVDh0dI8bpE2
 1sVLjtScBd+8ipTslY436umj5JSVBWkqJrSrIR7YwE6w4V030UPqpLka5/bo24ecOdaz
 Ihx8UY03M3lblXlK+IqCpie7Z2YYySsCRSXoBxUu9ZlmISyRcieFmAQWSaRNjH2RsEQd
 cqrR7xxGrkOyrzr3wbVLWm2zW8myArlCK+tCvkDDTZ17yli2EHpQjw9dokb6U1wpKOnx
 /+hA==
X-Gm-Message-State: AOJu0YyY9/cU02k4IrWBCaXluT4WtfxGr2PKV+AntaUzPlhRmjBLKc+x
 ZOUvnkyvbKbsVBGs+y86Vj7KmB2lf/mPZWY/KW625hKWCHpp+OcWfwQ6tcm770S12zI=
X-Gm-Gg: AfdE7cmMDM2INNemVmtB0XCCZyVBa3iIsvbHdX/aL97v5lq9k7l9ciUNscTkRzL7Zm1
 3XZqvPYF60U92PgvhCxbdkImg5iOPwA/fRl8FKbZJuxi1FLAROQ6gQYxWWAcf6izVBfSXX6gPgv
 RyeV6eIoBT8VhBIGzqHjXP4ru0nM1wNLVmYSfFGo7iV9yaEjOvrfuxu6IC3ncLEdOFNCbjj5miu
 6esSafq8ttrdHxXbyFcmDpcEbFHX34npZiSYQJ7L/jJKMWyNat390SY77S+auha2u36O6XOCm46
 a8wfgVB6IJgwoLz02ANpB8fAaqEqapYKeElnLw11UycxsdEFwTIrAAA+OGjfWU6UtuZVxBKr/lz
 RAKZu/0ht4nKXigrJc7bZUy1+HvwKNX1T6zmoUCGcndWihNpCl53TKuDNrN5h2cbpbJ8FxpOt0A
 nt6RB2KbLayuXS4+oTY7tUixQKgjDDT4zflKmeFOIZKBlsrT1w0+qTLQ==
X-Received: by 2002:a05:7301:fa04:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-30c84b64e8cmr89350eec.10.1782339431970; 
 Wed, 24 Jun 2026 15:17:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c9f166dsm1767430eec.22.2026.06.24.15.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 15:17:11 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:17:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, marek.kasiewicz@intel.com, thomas@monjalon.net,
 mb@smartsharesystems.com
Subject: Re: [PATCH v5] pcapng: add user-supplied timestamp support
Message-ID: <20260624151709.6c9b02e9@phoenix.local>
In-Reply-To: <20260624215858.710217-1-dawid.wesierski@intel.com>
References: <20260623141302.486601-1-dawid.wesierski@intel.com>
 <20260624215858.710217-1-dawid.wesierski@intel.com>
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

On Wed, 24 Jun 2026 17:57:01 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pcapng_copy_ts, 26.07)
> +struct rte_mbuf *
> +rte_pcapng_copy_ts(uint16_t port_id, uint32_t queue,
> +		const struct rte_mbuf *md,
> +		struct rte_mempool *mp,
> +		uint32_t length,
> +		enum rte_pcapng_direction direction,
> +		const char *comment,
> +		uint64_t timestamp)
>  {

I don't think you understood previous feedback.
  - use API versioning to provide additional argument to rte_pcapng_copy
  - do not introduce another function

The whole adjustment stuff just exists because the scaling parameters
are not available in rte_pcapng_copy() which is stateless and doesn't
want to have to lookup something in callback pdump_copy_burst.

Would like to have a more generic mechanism in future where timestamp
comes from hardware if available on rx. Then would need to have per-port
scaling conversion function.
