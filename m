Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE14606A802
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lbK6iFZL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9583640281;
	Tue, 10 Nov 2026 17:59:45 +0100 (CET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 0BD2C4026C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 17:59:44 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8b6399ebb41so2010752b3a.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 08:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794329982;
 x=1794934782; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eRCTrJr5SI6cx+S5SsqxU+rquQ7HAdI2pwypDQNSfvk=;
 b=lbK6iFZLxgq2hVFq3LIPWGUeJCrBBrh6On1evfcZSba6Jo+JplaCPcBr2jifUOJ4L8
 UMbDsTK4A6UxRCx7b8wKKYmq5AMrA/1IFE2jkAiWZpDKc+87y5B4Ym3j+bfuc5RV8lNZ
 J7Tqwv14OYf84sQeYhYuE7p9TnQKteLdrW4vggAbHyjnNzI6RHWV3T29xhbyvlX2QUxK
 2Qr46GQwwIIz3J1gc4JHxGaUQvUuXKAz8/pOuudWqv8vEeV97RQ4srUxnN1+yIZfZU+h
 0xhnbBy+6Jzepq9R0sKqRrNIiLwnPpNBSQCGEQN4GRCgsBZ4m/8o9ugQ3vf/ZoBYqPFf
 EUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794329982; x=1794934782;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eRCTrJr5SI6cx+S5SsqxU+rquQ7HAdI2pwypDQNSfvk=;
 b=cxnYkHKqljI9vOdMJ/Egou6vxZ8/5sARxnft/e6xDUvYTR0tfjm9uyKO24F0fDGO7i
 nuGvCs827r5X+Se8HzkoRCPKhr4QpAEB+E8H/kihVhmfbyAOZJv1ZKJB3YRfbEGITYx5
 Tz1W4t6Bq1U2LHEzVkPacqLmkSyTY793btgIcx1SyH/tyMJ8UwJ0sk9+JjroeiMlYMnV
 iN9GkSD9Z9gzS0A0cTMxZIW/y7DzTG7sWWuUNbWuFL5QdeB9PoMl3HULXnT5nOvOfiEh
 G/Z2QIRT8Ikxj4+7vL3kLgafEYrqZ4HsTfI3ukLQMRHFQr21ar9vh/O5z8Mk0n5fXuSz
 d1/Q==
X-Gm-Message-State: APuU4Z8BBDD8VQB5XQ9KvvjtmOM/8uNgHqE5Pt4NvG7eGF0Y+xorRVTj
 F8MGo3zIQW6YWC+4Of9kcuIL2nSX1OYchKsCLvCKtZNg8suO1mHsJQdvw3e5R26i9Hw=
X-Gm-Gg: AYBFou3KhyCeqL7A2MrpMAbxeslona9M3Ey9r5mK1PAfcrChax6MKSBG/s9QDFo8De6
 L6hpkF2+JRuknYD664c+BJHMhHQpWB7KmDbQrvESQEhi8zUDXd6CjGLsFM/kEZD9gsF+Fk66iDp
 p5UlAyZ2Nzg+6FvjqPWqDH5qoyOQLfBLvUTYgPMK+TBoU5sRMcykcWT1WfLVTF2oWeldS+Tz6qH
 Xc6x4Z+jlS1g67MUGsp6AFRzzSVkdkULJPft4va49SfjpBTIb0a4liNjA6mRPlARdRcU0tvSZT3
 gFj0ZsEQ4OQEpWhabn0xD+qAsIQgc4QDov8AtD/7H1/CGDKYnrehB0jsa0v2r4O2LoPK88ZnISb
 gx5sFYXVcfEr07qc16xm/uidUU63M4VKoxChIsXbvcrJyE8f2BKmx2t0iHOwYBiRcoD91PkFDOH
 9BO8i51Jg8OOTQiNQ4KpcF1suhVrl+lc3+4dYIeDgRsKY/K/JweG1JZuHaDpV18zwymO8xWVV8h
 OimVxRxM69nMhJcvFrK1t8fMVgLKdjkrHYiIR7BP6DD2OPp9TEVfcmmtXN9vXf/of8EaixFxFnj
 8XR0JNLTJ0nfmR+42PWDmyV9khLTzbhqRjiLsB/jaQSss7xmAduRTHiuZlelPDydDFCkGvI=
X-Received: by 2002:a05:6a00:4503:b0:8b1:e8dc:c899 with SMTP id
 d2e1a72fcca58-8ba85618e20mr3154664b3a.6.1794329982257; 
 Tue, 10 Nov 2026 08:59:42 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa7de3680sm1174224b3a.4.2026.11.10.08.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:59:42 -0800 (PST)
Date: Tue, 10 Nov 2026 08:59:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] app/testpmd: add explicit link autonegotiation control
Message-ID: <20261110085819.3318e22e@phoenix.local>
In-Reply-To: <20261110121658.1536152-1-bruce.richardson@intel.com>
References: <20261103155033.3740814-1-bruce.richardson@intel.com>
 <20261110121658.1536152-1-bruce.richardson@intel.com>
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

On Tue, 10 Nov 2026 12:16:57 +0000
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

Applied to next-net and resolved merge conflict and minor docbook whitespace
