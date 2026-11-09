Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B3606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pBmgtV/X
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAC8A4028F;
	Mon,  9 Nov 2026 18:45:55 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTPS id BE2A340270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 18:45:53 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ed06b725fdso8642385ad.0
 for <dev@dpdk.org>; Mon, 09 Nov 2026 09:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794246352;
 x=1794851152; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WnmJDb8+SAaEdZp8nTexnSdqkBFw2BORCuA7TLYmLRk=;
 b=pBmgtV/XuPJD4gO7aCU/acApFyZ2r8OXivajyZMHq+T6TGsBzU1u9D1JxKYJZapVye
 m8O1pQBKBJ05Cmmae32NsPQtq+SLN3olDTC2G4vHs5Pn/TXb3xpw7sqya8X3KfUrOAMB
 JIo7BAX4K65i54z6eUYNB1dJ5lpXnODUdjVYZ6MswE8/kIahgWBs48CmnHV28fjXG8Kg
 81UxtuUDwElFeHIfXygc9MxsH60rMyV70PzFj1cqVHb36UK4twUqZwvrpXdsDMWmJVT6
 7cn6dDj9KjDZjftIe53TFg8VFppPkOsh6y2Hlpf4HsOxF/HeC066vz/rOJPqGv85+37y
 fOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794246352; x=1794851152;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WnmJDb8+SAaEdZp8nTexnSdqkBFw2BORCuA7TLYmLRk=;
 b=SsfeUAgHIC6NgXRadiqcaNTlERQ0C4qOaxZ4eLrcFoAF6fXu+utEYDLfCBFRIY4VwE
 jmK4v4UoApmSpekZHypaJKYXLVY+RA0bBWUZgajkDcgd2MyLbETWxNtZudDOhvTE/ICO
 yhv58ttfk2GTGawimXOEcK4UI3U+5kcJ7/BbF2z0hbSSrnoAWBjdfJJ3YfROW47peTu5
 sqjhgYVOpBbS/yYlCFNx1detDQDWt1jX4FF/tMEkAELWBBVHWbDIoHGc8vGNbJoFdOXo
 PnhsBTsH+9QcZ5XX/PA/z7J0g8wt/MU+ebTdu87h3XF1q6dU5Muqy3u72i2k2XCYmTn/
 +Czw==
X-Gm-Message-State: APuU4Z8Bo2jZKkInx0wRuei5eXAxVrW415wVGIu7Qgmx0RqLCIuNL0NS
 mwudqzRv33IA7aAxPZ4RKHPls/lxWaqfyy1qv8IeuaIznOmAyC4czS5VdlizAeZl+JY=
X-Gm-Gg: AYBFou1YbLjvEfT2R2oAgl0L7tT/hs8SLiaLHYBNICimOLk0FtXRULLCErNMS+OOP0C
 s1BKLeb/SCM4anmYUJdiZmD6fkcwA0H+9U9n4jHzg98CKzlexWRlNZkM0RusN2uTXxuWI5sDbfj
 GhiqpiELwwe4oGdFAcNfP/x98xlRvi3asHghKINITfS3IZwCTbZBrewDnZEA6llt1d66SgtqI9J
 Sl5W0ehQ2Z/XeysOJcWWjW1UHIMQZ0rKPFSWYx2wbnuCxCj42ijVtmLWSFQMXB9OPTZkiKDp//9
 xsUrjwcO2mdM8pvbCoTBO0TdG3UqCKjBCM4IYC/J/swcPiCIDOrop/Ka+iSHjH7tLKSXDeVAJqz
 N7aS/NS5YdEDB9cGx51SSJo/xoTMLpBYxtoXVvWDOQ1y0HCZTeVzVGWoisWUuCLHYpx1HN3BM7b
 ihtCtBaj+WNWlzWE/WVOyjtXbwgKqJoze+/ew12/G+K9cpvC0aawM8arvWMjrzs1muiZU2Gd5VN
 n6adtLh/tYmC04Sc66SdSAXlDi0AeSi6ed+5zraye+iVsggF3cOb0FENjRo+QKsP9YDWivv4d95
 7GvbBVF9yJMozeZcrbduWY9kof7a0llAfeWdD3iWfFrbJW2K0Mn9fGiMe0L7UZDwIxYSauGD
X-Received: by 2002:a17:902:d48b:b0:2e9:6333:fba8 with SMTP id
 d9443c01a7336-2edb6ea610cmr1886575ad.16.1794246352115; 
 Mon, 09 Nov 2026 09:45:52 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6a42d89sm831635ad.8.2026.11.09.09.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:45:51 -0800 (PST)
Date: Mon, 9 Nov 2026 09:45:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] app/testpmd: add explicit link autonegotiation control
Message-ID: <20261109094548.3c431c50@phoenix.local>
In-Reply-To: <20261109155935.1054994-1-bruce.richardson@intel.com>
References: <20261103155033.3740814-1-bruce.richardson@intel.com>
 <20261109155935.1054994-1-bruce.richardson@intel.com>
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

On Mon,  9 Nov 2026 15:59:35 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> When a particular speed was specified for a port in testpmd, the flags
> passed to the underlying API call always included the
> RTE_ETH_LINK_SPEED_FIXED flag. This flag is not a mandatory part of the
> bitmap when setting speeds, and is used to disable autonegotiation.
> It's possible to have a link report only a single speed while
> still have negotiation enabled, so testpmd needs to be extended to
> support setting a speed both with and without the flag.
> 
> This patch does so by adding optional "autoneg on|off" setting after
> speed and duplex settings specified by the user. This new option adjusts
> the presence or absence of the FIXED speed bit in the ethdev
> configuration structure "rte_eth_conf.link_speeds" bitmap. For backward
> compatibility, the default value is "autoneg off" for fixed speeds if
> not specified, meaning that the RTE_ETH_LINK_SPEED_FIXED flag is set on
> the speed value by default.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> V2:
> * changed syntax to more closely match that of ethtool, adding
>   autoneg on|off at the end of the command.
> * increased compatibility by ensuring that when no autoneg value is
>   specified, a numeric speed sets the fixed flag (autoneg off), while an
>   "auto" speed keeps autoneg on.
> ---

Looked ok to me, but AI decided that it was pickier than me.

Review: [PATCH v2] app/testpmd: add explicit link autonegotiation control

Applied on 26.11-rc2, testpmd builds with -Dwerror=true. Parser
behaviour checked against lib/cmdline: the 7-token and 9-token
instances share a prefix, but match_inst() rejects the short
instance when trailing tokens remain, so there is no ambiguity.
Semantics match rte_ethdev.h (FIXED is bit 0, AUTONEG is 0).

Warning
-------

link_speed_fixed_bit() returns a uint32_t bit, but both callers
immediately reduce it to bool:

	link_speed_fixed_bit(res->value1, autoneg) != 0, &link_speed) < 0)

Make it a predicate and drop the "!= 0" at both call sites:

	static bool
	link_speed_is_fixed(const char *speed, const char *autoneg)
	{
		if (autoneg == NULL)
			return strcmp(speed, "auto") != 0;

		return strcmp(autoneg, "off") == 0;
	}

	if (parse_and_check_speed_duplex(res->value1, res->value2,
			link_speed_is_fixed(res->value1, autoneg), &link_speed) < 0)

Info
----

testpmd_funcs.rst: "NOTE: Combining ``auto`` speed with ``autoneg
off`` is an error." is plain text. The file uses the ``.. note::``
directive everywhere else (17 instances); use it here too.

Review-Result: WARNING
