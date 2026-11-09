Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A46606A326
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RDg7VCpN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90FA740285;
	Mon,  9 Nov 2026 23:01:28 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTPS id EC37F40283
 for <dev@dpdk.org>; Mon,  9 Nov 2026 23:01:25 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso7744455ad.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 14:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794261684;
 x=1794866484; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mHaiECguxytDkoOGAR0Zb+oHwGbNE9yLbO37PaSzMxM=;
 b=RDg7VCpNBP0c6al6+mE2RoPS51M+zLkud0r9uvS/OQTFKLybIuNdBt10Z96bXzjN9Q
 3VTcKKe24PGs8dZoVCqX3h0Kgjf1gT3/sMi0VtSqtrUwg+qJGnoBLFrjL9IUhz7kqUEk
 iATbZdybmhGCO+TzsHpqA4G7hDV45fc/zMZuGGQTzbsM9GMrX7RZJjbu3VYZH+BBys+9
 c6OJTzeUJSSIOZVTKlQDe862aFRciBMJ2bjpsmOu+RTp/k1F5Kq3hcPmVvtlpeb7UKYn
 eX4mfl0MlEB2pp9Jd7I7UJgaQa/Fd1dAIwPk6kGi8iDKbyoKKajVrRDu2c0EZYAF21kn
 1Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261684; x=1794866484;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mHaiECguxytDkoOGAR0Zb+oHwGbNE9yLbO37PaSzMxM=;
 b=CFo4BWXfmXrAk75H/Tp0ZQGiWEu/f4iGLLZ82WhjJ/wXN7T1/Pc3A4X/KJj2kVR2wo
 OAshPSPg9r/4C6ESr/TkkNBS0lSOyrn7s3PHqqHijhUW9s5xpKGTdzMK8EIR8/dgb/bO
 yXY/JkIrtNMhX2d9GOG7OyCZUXAxh9KmiCflnWEnSEvt02FTThnmXfLtAouG1Jee+sWA
 iCJkGT6SZZ9jszXwozGbAk8QpDkbyCbnqC0CiqwlG2CNvFwCTKFBIstGiCZOiEEuccyQ
 Cpc5O8ZQvgYNAX1zaJVRYKd+Vn2nVhu5lA7ZpmfgF/ItuXBEVKkl/S1n1TbjSnPosgNM
 zxPg==
X-Forwarded-Encrypted: i=1;
 AL+hErGWES5WgIQSPtCLp3jxvELYLPn2f0yLdCsyddzkfU+eW8MBcJVS2kCWXZcYdEOuzRqisms=@dpdk.org
X-Gm-Message-State: APuU4Z8Z4zNc29T3pFvIAz4zZ8CbyYGLSkSCz0RLwznU2BOC90YrK6xH
 1N7ZBev/oEzhWcqmJ+vtsnA+N/6s09Un90a6nH5Jk+aeScsXhIvx5vh2ieARtuc10L0=
X-Gm-Gg: AYBFou2bLdCGoBJH/ek39jKapMDJ0jhAdTpgZG8Hw8CmaLGCr8j9u2Ua0aITiD1TcF5
 QxCVaLeECwWrZPM0L+4e1Olj2S8c4F3AosyMFNLUjUEYJvHev4+cfZGHrk3dzgAH1rRenFCxvlh
 Bpwx3JjPuuG3YvGsQ383ySeX1k5N64YxNiGl1F78Ehgh2Y3Pey1C3a9G3oXVO8yq+lG3OZ6F6hF
 CKdHBhQrEjdNUvO6D16zYkVwcwj8IYdtg3QR4pR/hcj9PqG4lVp9nNpnubD/H08J8/vvKGw5HgN
 cbdRA7FaY54wO03YUm2GgDVTWF1tYgRyOpKQb9fOiCgSK+AEeqxrAY3ch4OaKwgFFe5+fX7CD+8
 7l4uhoJ6TzHCPhu3TrW4uXdKSDi79BPSr5brFVLdL2a47Ge1boEnajX+0McUaQl8ECAtHrUih4m
 7LU9JCy71y1iW8J4qUGNosrvzqCyHggzMP+JzCLz8Kd0L9n1+Vu7P8XkBmhsDgXUv7MHABbRRA6
 tdkjacODfshMIY5igjeO0/H/CdFWbuqhZFyYrM4VXoUEKqt+LkC7r3BktxibymMFgCHHinY/1Z8
 /s+1j4fH1GqvY/IfB76WkylTjCcyI8BZnXUoZxzXUnEwkDUosaN7w6Iqql3IDPFTn3QhNw==
X-Received: by 2002:a17:903:2c5:b0:2e9:3dd0:c7d with SMTP id
 d9443c01a7336-2edb9204fd5mr4838415ad.20.1794261679039; 
 Mon, 09 Nov 2026 14:01:19 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6a412acsm2246035ad.4.2026.11.09.14.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:01:18 -0800 (PST)
Date: Mon, 9 Nov 2026 14:01:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH] ethdev/telemetry: fix hide_zero parameter being reset
Message-ID: <20261109140116.366c0760@phoenix.local>
In-Reply-To: <20261030034157.49080-1-fengchengwen@huawei.com>
References: <20261030034157.49080-1-fengchengwen@huawei.com>
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

On Fri, 30 Oct 2026 11:41:57 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> When the "hide_zero" parameter is parsed successfully in the ethdev
> telemetry regs command, the else branch unconditionally resets
> hide_zero back to false, discarding the parsed value. As a result the
> hide_zero option is silently ignored.
> 
> Remove the unnecessary reset so the parsed hide_zero value is retained
> and passed to eth_dev_get_port_regs().
> 
> Fixes: ba4d57bd849d ("ethdev: support hide zero in registers telemetry")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---

Applied to next-net.
Note: this all gets a lot cleaner if/when the kvargs helpers get merged
https://patchwork.dpdk.org/project/dpdk/patch/20260930224340.58580-3-stephen@networkplumber.org/
