Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E94CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED2594060C;
	Thu, 28 Aug 2025 01:17:34 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 11EB040298
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:17:33 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c84925055aso251041f8f.2
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336653;
 x=1756941453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeASw9nLdLsCJoOK1hV6qeCTVEVyVN6BurNkxviERls=;
 b=qme70wwO+CIW02bMsVhOSDLamocZqxVvYNUm1xYWV9nixYbjT5i6D+0y4lIW13IYJ8
 gzdApTcqo14dXfMFZXEqVLMuirS/rah1wgBRRB8WF9CeVJTRdzXQHWzrzBLQwYvcV+4+
 yn1Q3D8xfnV7a/KzIwnElwnZ8pdplD+i1pjPhggs1Fp8KAGvuyvn/SB8eb5Vrp61SCHX
 7STr2RVtB6dgPrA0TXXmhYeEoZ6HlIfQkVGNa5VDHlGSdnOzFzKlMxEuPe4+0T+ahdep
 JOvTqlp8M6AuD+DF1u/m0usNWqM7+XRfh0yWAPJpfS8VaI2/wpO2xwANMm8gamQvDHav
 StZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336653; x=1756941453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeASw9nLdLsCJoOK1hV6qeCTVEVyVN6BurNkxviERls=;
 b=sTuQc3kzyZb7eWGCM4CKSaBC3cjM0WECZ7Nrj8DqhJySiob3b1keWSi56rbm/o7Yi3
 xiU6NcYISQCwaiAfQKSD1QkSzYld6VIHCA0+EA+fzMhDRtvDv/sjgx6tmH1Gtr+sh4yg
 niijwkX1qop3NHruiGgtu/gc9u06j/4napXjAf8aTRAGNoPB/Y5ChdZZDVNl39/VAG+9
 HoWK7ZuJeE3b1HcfkQvwJJ9yPZ8PijJLyS9JjYnOvWsx64ORXGn0uB03f6ijKD4/8WC4
 xR/tPfjMBwiMSTsBZ7mB0sVdldm5okBCTEUpsDrE64ZID/PtnVVs2e7yq1RYD8ssCP3j
 knwA==
X-Gm-Message-State: AOJu0Yyqm+vlOdjyL/I0SW15OcbF2Aja0FLImuJUseK//escG3YMWcAS
 OjLUAGQO/asD6EMFsZQ4AhLsT0HXTXWXzoBiR/rU4/GXvL72Fc64UNuUOzvHbRkYkpE+b2CFuwl
 hXtwr
X-Gm-Gg: ASbGnct57M0pmbe5msD8wBp55mSaur9c1W+9njdwu60pCe4yIo+BARzq170eAutdXwc
 eOv04iT7FNRTVWcgwTeqv4TlB1HGnNvOZW3pWWnC/sCXrB3HbfgtRUjHWfafbO+xj/GXdK+7qdH
 8B9F4clIACO/xJUD+XzkfOj2ebCT7G3EbSA0QKjAKKFAwnSZqL/tb7Ogo7P4IiRFSUahqTOxzts
 lSkiTdixEFcbXJHopQxMtvmUWvfomanaU8TUOs6ZdEvW8K6Qjmr3We1DEA00ExEpt9Vk3Lnmgub
 bcEF6d1nCdhSgWcKdekBITS5Bjt+3+Uu9G3t4uzf3Y8gM/NYTxIpsqzYFrLnY4kwdDDBQxVT2Wf
 b1A1cYeO0Mc82IcltFeUt01YD+oahbjPe2SRoMcoNabpDKZAr2L8NGaBlgaMO8J3zFn4+GSB8md
 E=
X-Google-Smtp-Source: AGHT+IE8pxU+jAX20mB+max7RFhsw1nhl7D6fayzOdWwxKk8JlVc3Bx1eqinuc5r/6zvNueabbWYEw==
X-Received: by 2002:a05:6000:4313:b0:3a5:527b:64c6 with SMTP id
 ffacd0b85a97d-3c5da54ea6bmr14500402f8f.1.1756336652666; 
 Wed, 27 Aug 2025 16:17:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711211cc8sm22146987f8f.36.2025.08.27.16.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:17:31 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:17:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] mbuf: optimize segment prefree
Message-ID: <20250827161726.24cebd9c@hermes.local>
In-Reply-To: <20250827213535.21602-1-mb@smartsharesystems.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 27 Aug 2025 21:35:34 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> =20
> +/* GCC only optimizes single-bit MSB tests this way, so do it by hand wi=
th multi-bit. */
> +#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
> +#undef RTE_MBUF_DIRECT
> +#define RTE_MBUF_DIRECT(mb) \
> +	(!(((const uint8_t *)(mb))[offsetof(struct rte_mbuf, ol_flags) + 7] & \
> +	(uint8_t)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> 56)))
> +#endif

Complex enough expression that I would prefer this be an inline function
with some more temporary variables and more comments.
Like the magic 7 for mask??
