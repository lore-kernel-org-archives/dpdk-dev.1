Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40A606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Be38oIq6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 123E840151;
	Wed, 28 Oct 2026 01:35:31 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 3E0494003C
 for <dev@dpdk.org>; Wed, 28 Oct 2026 01:35:30 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3acc96a256dso288906a91.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793147728;
 x=1793752528; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V6eq+iod6WTLCG5BX9DBtPUyxqgY7s6KuRjEoffvfDI=;
 b=Be38oIq6mGI2ioeNwrlkB+P0b3BjtnQa0nYP5omntweWnqKMO8j5jBC8h7O0owlsan
 2qE7UvPgcne+scpChjieulgjNlYigndjo8tYL8KWOZosis4ki8Qb+V4ejZmBGrvVcRc0
 72QCSrDupGKFry21aVSQb2ViGp9qgclc6CrthJBOFVaF5bt7y++2HR4vS9AcPdftVDQ1
 QOVa5VL5saeUYNgIu2RDgW02SmDvsnfIoEamvPSx/HNYVxEKS5EoGNxSMKa8PbI4461R
 rE7ciLcmKkGMZNOYreNXPd3fA6ZmAVg+DOKQjs4sQGsw3XcGMusQwhRrVUnKWI7EGZXD
 Wgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793147728; x=1793752528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V6eq+iod6WTLCG5BX9DBtPUyxqgY7s6KuRjEoffvfDI=;
 b=v/Qma0nX8fPNlRPSaLcjo9tWq4cTgTojrkYEbX2sbKqC1oHKfbS2O4XSFq8vzV6/3q
 jvWoqPg1/M6DbREk4aAr8B6wtzX69f1qOIazQhzrwvf4NTMYZjHGZsJG9lTej4Pqk1ep
 PgQVEsAUs+llZsPdJGFzPpoK5u4I3NIyjoSUT1tNR7SWQmzn762PYt6as+YtPmAUdAWz
 ZiwJD1OdygYQk7IZ1ZCDSox5WwewN6dBQORcFvEZuFDf00MzpIs/0KRpmtZmSvWASmfd
 L6AZbOBvvHRt8LBTR5fdJZ94gDKCTAqUcHo3ajuIwfOKZK2WE3VAo5O4ERFRAc7vjhEj
 WGdA==
X-Gm-Message-State: AFq9FYIC7vg3B3yfXp0CjPTRAeYBI46gM41HPvSlKf1ViHwdmgVvUaeb
 Fz9eEgxiO9Y8ff7o1NCh4orPxyG/f31au8vqRuv/UEvHDj7QRr7sbsw7zHUwWwl4DQ5ThxHCF/s
 yRd9BogA=
X-Gm-Gg: AYBFou2l2c5zjcWHmjnk/P6IxRkdJJLPVxqQk5IoUyqQ/P/KfhJ46fZ9W0nZvjOKNQU
 HDwMCXmtESCApQbvjCj4Wp7OWSVwSkyS0aU1llkEmGHgYaK/pMxqX8PL9NFhwyHt+wYocXNxLAM
 JSCTIKxEWs+OgiuxqN7RdHXB/VWUWer17u1OWt8E4hXk6FzidKoGkC0FF7SbkThvcz9QpSPrisk
 7ER6U06BK+mHhuBJAzLWHWWwXjlcqSTYNHGdquiCN1lB24lbzsbQnfo9TV0dnwJtd8R7iljA5TM
 OGY05GY1Y4aj4uFaLfftM4lOO1J1VxV9rhmyBlAwvq1n1M3lzqp3qyi19OhZ+MpvuwtLuuZNFWP
 heiK0h40/7NGetDgkGF/+YAjAkXRBDATrsu5/G0dIaWautSr4G8eHoOxgNs41DRNhE7wuyR1M5h
 VC3IICXy/ERfknSyRzCSZWj3HaHuaf2jFKagqRNgKBVyja2+PvGrQaekFHcToIcynXCm74TQWBE
 fKeiRer+6EPf4DTUcAxcz9r8yRimKrO7dHGaNm91aaN4532VgnrkuAWOI4b5GYghe8yZfJsjd8e
 JcBOZQOofksfDg0tTVDCrj0hwuBSdhbZwhsIj17OOsMTrWdDf8RfTNvljnnzMYx/R9hA6CE=
X-Received: by 2002:a17:90a:ec90:b0:3ac:80dc:f40b with SMTP id
 98e67ed59e1d1-3ae580d225dmr456298a91.33.1793147728336; 
 Tue, 27 Oct 2026 17:35:28 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a9f286fsm397187a91.15.2026.10.27.17.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 17:35:28 -0700 (PDT)
Date: Tue, 27 Oct 2026 17:35:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: Re: [PATCH] bpf: fix index register for classic BPF indirect loads
Message-ID: <20261027173524.40fc9f9b@phoenix.local>
In-Reply-To: <20261027170619.2193021-1-stephen@networkplumber.org>
References: <20261027170619.2193021-1-stephen@networkplumber.org>
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

On Tue, 27 Oct 2026 10:06:19 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Classic BPF filters using a variable offset into the packet, such as
> "tcp[tcpflags] & tcp-syn != 0" or "tcp[0:4] = ...", read the wrong bytes.
> 
> The indirect loads ldb/ld [x + k] were handled in the same case as the
> arithmetic instructions, which take the source register from
> BPF_SRC(code), that is bit 0x08. In a load opcode that bit is part of
> the size field, not a K/X selector, so BPF_LD|BPF_IND|BPF_B (0x50) and
> BPF_LD|BPF_IND|BPF_W (0x40) both yield BPF_K and the index register
> becomes R0 (A) instead of R7 (X). The halfword form works only because
> BPF_H and BPF_X are both 0x08.
> 
> Give the indirect loads their own case next to the absolute loads and
> emit X as the index register. The interpreter and the JITs already
> take the index from src_reg, so this fixes all engines.
> 
> Bugzilla ID: 2085
> Fixes: 2eccf6afbea9 ("bpf: add function to convert classic BPF to DPDK BPF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Reported-by: Anthropic OSS scanner (ANT-2026-O029C471)
