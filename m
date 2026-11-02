Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE858606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PATxp9cY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E4D40281;
	Wed,  4 Nov 2026 13:08:38 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 3C04340264
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:27:59 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so2137280f8f.0
 for <dev@dpdk.org>; Mon, 02 Nov 2026 00:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793608078; x=1794212878; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0b16BCym5uh3OBHLyc4s8TTeMHTvhn2Gy0TvDiQPC/c=;
 b=PATxp9cYIA+3d8aKOChPdRduewEN25Uiu0PUV6JuHTso4UynrWhO7iNmhlMHZZWymE
 Exwwc5N5oqZEOp5xrQUHEGMtbFn0+ZseDN8CwJvi8okRo2iLnngrqfr5iNKcB9FfXsFf
 r6z+MjrvS7vdHCiQ5Hjy6Ng3AbmgZmFK8HKGYAvKc0xlWd5N81+5kX+I332Dm8ICc0Lf
 kH3V5HE6JLrXBhXdcCHukzXn02PGnYwQ3PQlaIzChe4BfMYVQBckpxh0cn2X+ZShaao3
 Rt38z9i5qjPcPEb6i8wfCjzGLvaW1aYI5dJRtMZSc6CB4gkfh1tp/2PfPBuAompV/Of1
 DOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608078; x=1794212878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0b16BCym5uh3OBHLyc4s8TTeMHTvhn2Gy0TvDiQPC/c=;
 b=zwVklFa38mETE5Pry9MdUY/FjH1O2e0EEZP1zlz1WUQGBJOwdhQj/cpTDOJTrhQkSs
 V3193jbCFm6IlH3N4++NjPe/Hfb8MXaFM5FoABDSZ4G/MrBDQ9R5QlPsOpWQ8gCsgjzC
 c0a3I666W53zZRD/xBBIhDBhqPDTCbsOAH55jZWoGh9c0ic1brMcTOAlNvDcZ+t4/D7C
 VyVdF8eY60MSkM58IfbIggZGmC5G7hVR9JsBhmQPHIqT6Q1+xU3Q0OlhOc1BbtK5KdXf
 jsaF9IW64yBDyFexqlde1t/Wh6WIxVy/xbc8tTrXX2QrzajZrpuBAjjrfwgPbRn4u56R
 ppaQ==
X-Gm-Message-State: APuU4Z/HB3tP3a8YMyMay6qCtjTDznzTV45pjd/k/+Jea9p8uO1Dj36N
 CgjVH1RzeNuRgnFiq5iXDpWfy320/ztARZnCiFWrb8t4Yf86wzDG5uEk
X-Gm-Gg: AYBFou10liy0Q6qXE72PG1fjZhQdVfr72X1LfADOc9VVvoXozlnUHvVuIoWWjlS6ggu
 R09YjhrjnzcoPX4J/k86YzBc3q2zTkdYQFKgR2/O9kk4tCerZROhu4ZzDku3Q2urPkfhzQx5XY5
 QcQ7z5Q8u+Ej+Tj0a4/A9DGTJdV8l3a+ZD4Gpf+ukwfb2xZax4v5zjvCdi1Reu5d1gJtVjGYL9J
 j3/EzXNS9+YRH98PhZxrguYOa5DDDIzpXfaHbzeM6Zn0k88cHGvSbrpjnCW2/YSAsj4NjySVAfa
 5kNBXXDyxu06sE3zGcVcoHn77FXfFHNT/HA15BhLMZGTZ2Am4pMdyu90YVilYvq/Htt4yAxpT6b
 1+E4DVlEdvrBGTMsOnQD+6j+HXczc2N+9ml5GXmjxv6q1gQgn45gEA2fQ+msNR/Ma5rTTSYGvNJ
 f0jidgBqiW7IF4NVz7Zv37WApgNtS5bF6AGiY+nkLKCSNvQP9syETq3hNyieigzNyWuheEOLYlI
 +8c3Tpq8J96DmNQtot4XIMDinOLHv+BwdO9nFY2XoTUS/5+ZtgKShF61Izk0tDqdDR1AH3Jc67X
 tRMpGRcghqT1kpxOpDPr/XNV7h7t4pvA4lWcpCIy4yGmbdRVpppoSD2eeL7z66A24mhPiMalquF
 wTAcmfYabyS2zP4voE5eWvE9rpZx45Bm8LcnrTbf4/Hv/cGw=
X-Received: by 2002:a5d:5d0c:0:b0:48e:7833:2e56 with SMTP id
 ffacd0b85a97d-48e7833321dmr13664168f8f.23.1793608078282; 
 Mon, 02 Nov 2026 00:27:58 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net
 ([131.189.143.225]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm21002425f8f.6.2026.11.02.00.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:27:57 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, Long Li <longli@kernel.org>,
 stable@dpdk.org
Subject: Re: [PATCH 2/2] net/mana: fix Rx interrupt enable failing on lock
 contention
Date: Mon,  2 Nov 2026 08:27:56 +0000
Message-ID: <20261102082756.835327-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102091202.180b9eb5@stephen-xps.local>
References: <20261102070809.813033-1-orgads@gmail.com>
 <20261102070809.813033-2-orgads@gmail.com>
 <20261102091202.180b9eb5@stephen-xps.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 13:08:38 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stephen Hemminger <stephen@networkplumber.org> wrote:
> > Fixes: 077ca514d641 ("net/mana: support device reset")
> > Cc: stable@dpdk.org
>
> Since this code didnt go into a previous stable release
> doing cc to stable is not needed

Right, reset support is only in 26.07. Please drop the Cc: stable
when applying, or I can send a v2 without it if you prefer.

1/2 fixes code from 22.11, so I left Cc: stable there.

On the AI review of this patch: reset_ops_lock is a default-type,
non-robust mutex, so pthread_mutex_lock() cannot return an error
here, and the existing calls in the reset path do not check it
either.

The iol-unit-arm64 failure is memif_pmd_autotest crashing on
Fedora 44, which this patch does not touch.

Recheck-request: iol-unit-arm64-testing

Thanks,
Orgad
