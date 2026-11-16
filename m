Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD560A3834
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CRCRjMT5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46F3340294;
	Mon, 16 Nov 2026 20:06:05 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 5894C40150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 20:06:03 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cddee4abc57so442301a12.0
 for <dev@dpdk.org>; Mon, 16 Nov 2026 11:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794855962;
 x=1795460762; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tj3H9PHFK38V4AyDKs6tWznp2fVBaZb2FqfvrN4ixOQ=;
 b=CRCRjMT5GPgfbeT4j339LP3j/83kAKJXmiRWC5EYIK/hrPvOzM5EyK2NGdjK0SK+5q
 s+PeCGWEfVUEouQt5gNUa5wXW1RQAKMIbbeyyFvouY4kqJha9wOXY/YnVBUEcKaAgJsK
 uPk4wnjWY11qEx1EXYoc8Ydt8DOal4l4DBXsAeHl2mFef+K3VeHTHUBnEoRHRKeUbX7D
 n+RH+mFvLI+qKecW3vIJyr6rxkTkms6GCU+mG93v9YrDXqM4/s5uX3nZEwLkNOHuFMKQ
 Oe2EopwSJ7R+iJv2q3oRoeCejIkuRsOP5xD64O182bmfoUJE//95blxrjOQ6oj9J/+s1
 NWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855962; x=1795460762;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tj3H9PHFK38V4AyDKs6tWznp2fVBaZb2FqfvrN4ixOQ=;
 b=Uyi7jz3jvMxFin8JZcg9hNjFtVuHgy1D7SH86E1jAw8gMHfv8Q1E3p8/0hQRLaaZg9
 MvWbh36NiLNB8Daed7e1AoIM24/c6syr34w/J2VxRPdK9FH5dpoKl1A9PbLO8A0LWeih
 CVeKnAphU84KoqmwaYcTrdcUs0FK8yQpp39g4kmRslDtaZnQKa7B8exRNECCEPuKczZa
 O4u8b80zfXVHpINpzO3g3k7u7LpZbZIyte9hHv/LNR5r1hcdnFPs7zsZz4LydakjklO5
 m/SV9T4ppRLzBdUwaThEkqpBm8bZl4aNOPOWRODeRgvbIblAcwLfJFkL7pHYDhZp18Pj
 BRnw==
X-Gm-Message-State: APuU4Z8VtwmRRlTcpMR8RVCgEHbtzmMG81qsI1T1aB3+2bgkK90o4uvU
 uODrAKdmfeKMmRLUgn0aGiyCRb5KVuWIJE7T1bsdwrQgtcFZdt+3D2z0R+mLaWxGkPw=
X-Gm-Gg: AZFdTZdGmB1KUKQhmuKJ86gSXyB1X2OUuWrW4a8/yDNHbV5LsPOTDoBTuAbOVD5iRag
 8xSzTB098pbNRJ6vkbq8jWfSqs/LdVeXxUwtucAqjmPQd/J+ghDw3qZJT/I8YbpAQyeRoWqPHhH
 jIVYfcogJ9rnbxsGhlJZB4AozoJU8yigWvWBI9eKH1rf7W29D8/nKC6TIXGbAcAktGEGqzGTdat
 3/FSgjLHOYOYxs4gEDwhN/j3nt8+PyQZfumvu8nI02gmRqV6eoWyEb+Sc7G4cW1CtpFmWFW032F
 6NoCRbfkpdvmzpn5FcazUC3NuWSrivvVSVsNvL005aaLgXA85f8PM7jURctY7fjJMG+dO8p9QB2
 /XD/izQD6ARmtK8XZHVQ1vQhI9KFMVfUKP6kQrZMBGe5kndPi3vtMmENiu3tnzI5AodCIczDTWP
 Yomgzy7jeVi3dWISQS1EuRVTzHKJC4fI4Mdx1M7Zia/1HiecgBIZiF06ckoHhZzqp8Aw7Sjm4Xy
 +BsLYoZSihqqUvan45bagJZZMmObY64vOhJk/wWreI0+cOEZ8i0cALUB1SuqUPm9VTZTz6jSOGC
 M7zYVI0byIlst5mFRZGlQYTFmpp+0UC2PK8cJUeP8FnYe1vyEyxVgsrGJ4xnI5Yk5LbFo3wYAjS
 +t1MO05LgmdkR2y4HlGY=
X-Received: by 2002:a17:90b:4f8b:b0:3a8:495b:d64b with SMTP id
 98e67ed59e1d1-3b1b07ff572mr10801754a91.4.1794855961563; 
 Mon, 16 Nov 2026 11:06:01 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc188ff97sm4767147a12.16.2026.11.16.11.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 11:06:01 -0800 (PST)
Date: Mon, 16 Nov 2026 11:05:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Randy L Tice <rtice@cisco.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/1] log: add name query functions
Message-ID: <20261116110559.1649b3f6@phoenix.local>
In-Reply-To: <179269447225.66.503181230751464930.0001-log-add-name-query-functions.patch@cisco.com>
References: <179269447225.66.14480121779058708237.0000-cover-letter.patch@cisco.com>
 <179269447225.66.503181230751464930.0001-log-add-name-query-functions.patch@cisco.com>
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

On Thu, 22 Oct 2026 14:41:12 -0400
Randy L Tice <rtice@cisco.com> wrote:

> From: Randy L Tice <rtice@cisco.com>
> Date: Thu, 22 Oct 2026 14:34:31 -0400
> 
> Applications can query the numeric level for a log type, but cannot map
> a level or type identifier back to a human-readable name without parsing
> log dump output.
> 
> Add experimental helpers for retrieving the canonical level name and the
> registered log type name. Document ownership of the returned strings and
> add unit test coverage.
> 
> The original downstream implementation was authored by Walt Robinson
> <walrobin@cisco.com>.
> 
> Signed-off-by: Randy L Tice <rtice@cisco.com>
> ---

Finally got around to looking at this, I think it is OK.
But AI had a good suggestion about making error returns the same.

Review: [PATCH 1/1] log: add name query functions

Applies cleanly to main. Builds with -Dwerror=true including
app/test.

Warning
-------

Patch 1/1: inconsistent error convention between the two getters.

rte_log_get_type_name() returns NULL for an invalid type, but
rte_log_get_level_name() returns the string "unknown" for an invalid
level. A caller cannot tell an out-of-range level from a real one
without comparing against a magic string, and the public API now
inherits whatever eal_log_level2str() (an internal symbol) chooses
to return. Return NULL for both:

const char *
rte_log_get_level_name(uint32_t level)
{
	if (level > RTE_LOG_MAX)
		return NULL;

	return eal_log_level2str(level);
}

and in rte_log.h:

 * @return
 *   The name of the log level, or NULL if level is not valid.

The test then becomes:

	TEST_ASSERT_NULL(rte_log_get_level_name(UINT32_MAX),
		"invalid log level has a name\n");
