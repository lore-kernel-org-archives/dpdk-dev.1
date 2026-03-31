Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F4610F9307
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:32:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D707640275;
	Wed,  1 Apr 2026 00:32:53 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 7AC344026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:32:53 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso6047871eec.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774996372;
 x=1775601172; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woG7fBZaXD5J/0BVDlgyRsdlC4rfPyxK4dLG8I71h5U=;
 b=CE+obpKzXWmnojf517/RGL/UB7WtkpVRBBZEcTaUYW8pxPrKbD2uGRVbEVmr3zGNCA
 nl+DGsV8lyiVv36dFfASXJ7Ig0HMQsdQ+kTgo0nissSwq4p2y9xPC4LwWy20yCBq5s+N
 iyn95fp6Uq7XMITHycV22NHJSOWMkD+mva5802Hu6MIIa43BKg4vNl8H5mfEYmOl8zjF
 qyxj2wDENSjDHVwBaVy+NOUjD4sN35ucir4ppAdimyKedbeP9jQe6jxgKf8SnOLrhscO
 zVr5Uv9M4T3s3EexZIw1PAQa9OUSl7+ZbK37l5OBePqKWCYVS6Wt7J4Sui92u7wwN4F3
 MOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774996372; x=1775601172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=woG7fBZaXD5J/0BVDlgyRsdlC4rfPyxK4dLG8I71h5U=;
 b=rkjdFbVeEFYPqHcbzSK/Wp7vvfugzU+HKoE6319bwFRD7cv2Imqm2MBSIGacDH5GRG
 xWf4RNf+bpseYO/bimCIFEjSEkovBM6gvfZ0ZN8q0CIlOLz02W3igAWx0IHtNyXZD6tB
 +qhnBLDhNPDjO4JTKAbpJiuFKqXK+hDgZJGRJA1s5ftoT78Gs2Fn43Pwk419lzXViBjL
 xvO/hfzvUM8yAtwPO6qiOD214s2vvUMnAJhGTmvUy2/PziT6PL+T0NeN40xQDU3F2xYC
 3INbjukmWV8KzaM4BetjdVscIqubbYIfeWr2C12OVvi0BSr7I++0U41T5Vc/k0ehwh1S
 Q5eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4U67cmwX7IDhT8O977VT5C0PSw1gU9vUMIZGD/rQlBYqEtuydtCsG8/hYJWz+gn/aRKE=@dpdk.org
X-Gm-Message-State: AOJu0Yy7kfUh6Ge7W78UFiZ04t31XalPUwVuVoMMBSS8v3fVZ5Y4e91g
 7oKU+hqEAmkbK+JKxfsFeWwhj/3TOhuzhdVSkwHEe8y6aywRkrJN3voz/U6YwN8JhYw=
X-Gm-Gg: ATEYQzyhUUMm7e3Q0+N91b/+Wlt7AE06dx45NjhK/8qaTpwFcekwc84oeKf+nV2zKsX
 CZq1Qra0u2cP3KvgZ9/nvQs80A6KsdL5pYtAVxL+yh9TGmVqP9qz8Oq4hnmCOdUozaPuafA0mkv
 NHEXq3SiRTGrJGFDy8l4G6wBBm1y+w+i/wlvS6t907qQMG7M+glqe+VYVvx0cFO9T+Zgmwsv5nF
 B/Jxe8yE3vRvwZt6SKLGfj16jQec78llYFwV+AH4gl1udu+ybVm8bmGa5gpDzlRroTJEdlOkwAd
 oKZzsrf9B0WRBL39MUMqVAjG+OTr66Dw9dQfhgvkhw7t5OAIzO2q2x8QaVPBjPaLccNVcwCO0+T
 mUpx5i+E6Zde71zRTV32/Lit0Q1/2u6Mz9JJbP3Y6SNxCW0DM3i6H2C8tazmPKZfoTCG1Tz02ZD
 0fgXPAOnXZWBk6L8eyhjXpoIb+Cn3lXeW2Eio=
X-Received: by 2002:a05:7300:aa8c:b0:2c1:23d:c728 with SMTP id
 5a478bee46e88-2c9333bca76mr624751eec.31.1774996372426; 
 Tue, 31 Mar 2026 15:32:52 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c46a0d06sm10938855eec.10.2026.03.31.15.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:32:52 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:32:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org
Subject: Re: [PATCH] doc: reword contributor's guidelines
Message-ID: <20260331153249.285d7ca9@phoenix.local>
In-Reply-To: <20250512144842.29976-1-nandinipersad361@gmail.com>
References: <20250512144842.29976-1-nandinipersad361@gmail.com>
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

On Mon, 12 May 2025 07:48:41 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> I have revised sections 9-12 for grammar and clarity.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---
>  doc/guides/contributing/linux_uapi.rst    |  32 ++--
>  doc/guides/contributing/patches.rst       | 177 +++++++++++-----------
>  doc/guides/contributing/stable.rst        | 163 ++++++++------------
>  doc/guides/contributing/vulnerability.rst |  59 ++++----
>  4 files changed, 193 insertions(+), 238 deletions(-)

These changes were intergrated into: https://patchwork.dpdk.org/project/dpdk/list/?series=37078
