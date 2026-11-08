Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A7606A33D
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SpJqC/Q6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FBF440265;
	Sun,  8 Nov 2026 21:29:36 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 435054013F
 for <dev@dpdk.org>; Sun,  8 Nov 2026 21:29:34 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a06c60065fso81678b3a.1
 for <dev@dpdk.org>; Sun, 08 Nov 2026 12:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794169772;
 x=1794774572; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pcuvOWwnIoMtWgpBvSpNlk8/FwXKQY1TtY2pQmpt4dA=;
 b=SpJqC/Q6cx1/ie3Lb6oAYp4R6NcjrJHj7NSqBhueFuKATIe1MKOyW381Kw7F95xU6K
 Qt11ufLtF07PdnBjjBj22Nlp3I1f7yUlRjGvw04Ws08RA7DdoL0O9FAPIpi8aLm55o8V
 cf/iRVrARJhq7ozEEcbSXFZoxf6SllytG6fChgHs2wzyaauCmNH30l2TNYd320nUp34/
 6Mp1iWeAIykpIqi3G7FiF3Xa/iiiz4QCLiv8VZjLQ221J55fv4Ntpil0jgdv2vpyKjQ9
 ftKYtOFixZF7oAn8LeQzlbumIweAagZj4KWF7fP0KCHzTUya76LL4A5vXhUepHr7E4f3
 77SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794169772; x=1794774572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pcuvOWwnIoMtWgpBvSpNlk8/FwXKQY1TtY2pQmpt4dA=;
 b=g0UxbSLR+UJWFtpQCFMhED/8bpjwb6fuzO9GlH/CfyZTrQyrGITxcS5i+6hQEGJ7TJ
 3R6ZgGzi6panFmyi4YfvAHKuWnEg7Fjuim/8JAtJNdc0fgV274SLvdRARbrYLqo2uEHF
 MV3hDEZUkirrzGmRe85iJ1kHlHdQCcu88sL8i/snZeR95m5w3qKMB4VRfRW6tyz6AFZD
 hr0JSdyY5P5Gfh+nBFl5Y21vYgVArWclorF2yRjbC5AXEH2yS5Oz5ekrKf/mGqhfJgUZ
 zZB9+bggV3zi5NMKWnWcf+SdFzBg/z+T/2IcKtHW0kqufnaSn9zf8Wky1yP5j/78ZOJJ
 /fow==
X-Gm-Message-State: APuU4Z8J6pydMKNXir1qp8Nyyjbc4vbUMgvukIpAhjtC5xFi81DuKiTu
 y8XpqEcidhH/ab1FNxI//1tlZUBIdMeKazIyt/pr0EahoiM19v7AkWUUUoEQ/HBXnn4=
X-Gm-Gg: AYBFou0SFgcTctyyNZkb5BAf0YbBji3JseuezuuenpDa9PnZLd6X9iRDZP4qALmYgVF
 6Hlcpe0bUhoazIrTPBB0uVnWTqyGtQbx63JZ7mmtH31A2ca1LNUMIMCTBnZYHgTiq08BbhaI6Cj
 nqnIugev4ktvDX+Wlv8YWy4Yb7DpJoakOqGnRzXf3dpdNmBhzLQUTP2XVIvkxDfSzgchEnEmvEA
 1LQAy+6dKQ9Dc1sG1QOfb8mPsNND0CeUv0RrS7ps4qvxrt49teNMokeAZfwc+cQuqSDczoVqGgI
 71tvuB4hlnLCnVpXGZ9mwrs41vVJ9u1Ktq/Bh+GWIfMzJelQz/UF0lL/WAt+bdGuoMBk8CXBbEA
 T9ooBsw9+S5bwNMu1u3EISxExnuMpvSU5wyfiXvy2vHuSoLYhWhAO7NwFHjN/A9/Dbpnq2ScaEG
 BKrZFkpt/hoLR97KTGdyr7ES/pc9jINM0JXr2uF9reNUyI3K1dn7bnMm1nUApW69VGhMSraMhN+
 WX3xqsWkEeiE5LgVNROXlgwTovz3Z2XLwGnlLlzHtwlBnLWTv5XbsfrO6Fo3cLlHyMtA84nHZ9c
 r+XRs0+gh5JeAPa/xC/NqZQU0WMRe1PltvvHGyyn+rKfjNB+2qd8LNfkF1ggpXVbQq0t0Q==
X-Received: by 2002:a05:6a20:7fa7:b0:3e2:701d:7e7d with SMTP id
 adf61e73a8af0-3eed4dc43f2mr2000415637.67.1794169772409; 
 Sun, 08 Nov 2026 12:29:32 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb9677b1d4sm1012286a12.1.2026.11.08.12.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 12:29:31 -0800 (PST)
Date: Sun, 8 Nov 2026 12:29:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 ktraynor@redhat.com, Bing Zhao <bingz@nvidia.com>
Subject: Re: [PATCH] net/af_packet: fix build with old kernel headers
Message-ID: <20261108122929.38561d27@phoenix.local>
In-Reply-To: <dab30cb4-025c-4a75-892d-3519dcc67053@dressler.pro>
References: <20261106142756.241131-1-bingz@nvidia.com>
 <dd205eb8-4741-452e-8490-16d157e1bb1e@dressler.pro>
 <0374e022-3c41-4a6b-9464-7f879ef02ce1@dressler.pro>
 <20261108082211.1f190f4b@phoenix.local>
 <dab30cb4-025c-4a75-892d-3519dcc67053@dressler.pro>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 8 Nov 2026 18:51:35 +0000
Frank Dressler <frank@dressler.pro> wrote:

> But should these changes go into DPDK or NVIDIA's DOCA?
> 
> DPDK's current code requires no patch since the code works with the 
> kernel versions required by DPDK, i.e. Linux >= v5.4.
> 
> NVIDIA's DOCA, however, ships current DPDK to RHEL 8 which comes with 
> kernel v4.18 that is unsupported since DPDK v24.07. The latest release 
> is DOCA 3.5.0 which ships DPDK v26.03 to RHEL 8 which is not supported 
> by DPDK.

If NVIDIA is shipping new DPDK with old distro, then it is there problem.
