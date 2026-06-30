Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD8C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 19:19:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 954594064C;
	Tue, 30 Jun 2026 21:19:22 +0200 (CEST)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50]) by mails.dpdk.org (Postfix) with ESMTP id 80BC2402E2
 for <dev@dpdk.org>; Tue, 30 Jun 2026 21:19:21 +0200 (CEST)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-664c7dc6830so2070753d50.0
 for <dev@dpdk.org>; Tue, 30 Jun 2026 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782847161;
 x=1783451961; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=8c3DajdsNVNOFykexz4qtDmiH0mSbzxcKMufU4DUIP0=;
 b=BeQARPsOPmJtXOL1Y2qzjh614FPx3yTexGYqAMbzyej40zqaL2hMtz4vTATycn1kK1
 TcvKy6pGarrXUQwa6SHfUaWoZTigCvpr8VDJVWa3K11LpTHtNx+tfJ6cuvHF3rKI3XbE
 NKmwr9q4jvF/kPfVL2VfN7QEukeguX3DWrh88ClHl4TBcg6gqwUi5Wypp9pbSe9ikXkO
 wvr7+P6AnbWdPC9Ew5RlBG1sCm1Ae8EZBFHc9Opszrvzg7kjJW1HPdsFtE+w2r6ET83j
 M+mZihHUQW4d9snyyrBjVy7OrR2KejP/JTh0EXKxuhW3JNzc7HQybhRTGEcUODNm9C83
 dPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782847161; x=1783451961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8c3DajdsNVNOFykexz4qtDmiH0mSbzxcKMufU4DUIP0=;
 b=HfhE0bZWWQTa/1z7T3QGyuMhaOHyPv+L76WBUhDfctw4acN0luMkH3Y8IcR+sACAJ7
 SGF8ZJ226OntIEqbYX8rT8sjNR4o6zQgSEskYjJ0/IulDUA9hv5TPlOR4CXCZMqnkwpn
 BjF8NYwDdQFFakwdY3Tz9Dr491v+V5FKWrMwQq6NyIXJ/5Sg7hqPRfIZ2TszAZGY3kMi
 niSpQkG/TQVN7vw3PyO/CWqmBugVGdlIhj1aJFulSfk321PgxclRmmVE+edeV9maOHm2
 GTlONa1wgxE+B/L8nlC8qLnMfui6PdOTMRz3bw4tDUCwyvHHbA7widoRNXB+LlAFiaKZ
 du0g==
X-Gm-Message-State: AOJu0YwyqSZNSkdKXiy9G03fxPhNzULlOfAKY66ybXrJdOqr/Z+pb4Zf
 jEEaRLjWGKLEmDip1uTDh+cTgdyTaHpYV1tcclHDXWg0c4vLlifD2qy4CBpkPOptFphEREcw4Uj
 RPfu2
X-Gm-Gg: AfdE7cm92KVc7YK32BvP/KtJ77pnoz9RsCqBNXQp0kcEyF+YN3s4HH3ul06DNeYkreQ
 eER0VSV9qq8s1gViXCUYNHjXSQM4XGbKGmqJm6ox2dhNbhop/yHhCdS+ViEUhktdn7xl2E3RnwX
 DTsO4i8blwzn9eb4FnyW0Ywdu1BqnGTm6K8i5/9NxOhlwC/xuUP5KYDNvMza9+I8I27NvrxfP3n
 1gJyzLlrNEPsosr6jJUxj5lEuUxuGntNHQFzeZRl3MHu5l1Ad6Se6XIF9nlxWsY3BSSh1avJPd/
 NxLyAfoI+gaGYUolwXYfAPbqBpVvphHM7MUYMbP8d5aIdO5c1LDJdYBMddJ0BMv5eFq9e++F42h
 6lRL981N7dvBKk/CgHdCgDFNaGOZ5Hz7vm6vbiXK/2DDe/Kc02q6DBttDDpH0OCNBhRGugtv9gx
 xUQSOn7S8bXXgdlnWo3k7llTH5G9PRbssp4RFqnoKAAI8ofse4dStKJA==
X-Received: by 2002:a05:690e:d48:b0:664:b27c:2b40 with SMTP id
 956f58d0204a3-664f96ea0d9mr4629887d50.19.1782847160554; 
 Tue, 30 Jun 2026 12:19:20 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66500677dd8sm1321193d50.7.2026.06.30.12.19.19
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 12:19:20 -0700 (PDT)
Date: Tue, 30 Jun 2026 12:19:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v2 8/8] doc: add release note about ip_frag changes
Message-ID: <20260630121917.09548c26@phoenix.local>
In-Reply-To: <20260630153723.525167-9-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260630153723.525167-1-stephen@networkplumber.org>
 <20260630153723.525167-9-stephen@networkplumber.org>
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

On Tue, 30 Jun 2026 08:36:20 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The changes to ip_frag might impact some conformance or
> performance tests.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Recheck-request: github-robot: build
