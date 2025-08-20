Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085FCCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 15:12:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5852A402CC;
	Wed, 20 Aug 2025 17:12:47 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 4BCAA4027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 17:12:46 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3b9dc52c430so27383f8f.0
 for <dev@dpdk.org>; Wed, 20 Aug 2025 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755702766;
 x=1756307566; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIfhLRYY5ZMObhlok+42RvmHrV/YBiFqa7YrHKOl/I4=;
 b=3VQSwsg4fCVtyJGlyjU6IvDmH0BeVedN77MLYUK7UTbjzXqsTZz2xyZRPxYJDWdTD1
 m38zcUru3O6CF3GoD1KoWnrWLNTT+gyZlXvU4SSE5EJBSUXpzO4RuHCjPyuIv7mHvykS
 qXUJ5v33tmIc7G5chOr2Ch5Er0NV7+GcDwaetThiwyhAwx1rF5M4mKTzIFndNR7C1RAs
 EtOM15BDYxvrmqme27ideg6oxCgEOXd+nPksNZY4o4N75Jvm0Y9id1B0q+IQA00H+RTE
 sA+jJUOz3nPujOtR6qwBfjpsGvFHO16HbdWKgVUocHbbQsR7LBw/EWnTdxg0JVb6kn1T
 z0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755702766; x=1756307566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIfhLRYY5ZMObhlok+42RvmHrV/YBiFqa7YrHKOl/I4=;
 b=X0JZYwzQ0J+vILvryD/rPchXXj9wnELefk8GshaCA769paWElSM8YIWMktOtQZxEoB
 glw0mC2IK5WPR+J00UBtaEquYROq4irAlJa7mhGw4xS/HQeTNcYa4I/gHrtHhha1fnpE
 2nlYhsvDx2m/f0M6VJ6RGHA2hP3Es8PQcdmxghzXNJ6gm7xPKLV8EQ6oeL22pJESYGld
 Wp7pOct6wtxf9N3ozVKjOE1WPeduLKMluJAa3XnRfkG2u+uci9a4wG89+rulaLHqkMDI
 CxejRCM6gmKnXVQ+vR54z8YMKclGM4f6Hgnw5lttwH5v9xpKoIxS4ZXYl4TFBLCMvqqo
 iixQ==
X-Gm-Message-State: AOJu0YwslGX9FuueJAaEE1A/CaFANt6DwanrhldRK4t0WN+JpicawWih
 4Pjjldac617ITM4aR9R5HQYf4kWtFbYAtXrMqv7tEESr60xg+rYBRqAEJX+LZg/MPzuZs0PV/2y
 4J7/swRA=
X-Gm-Gg: ASbGncu7JG9sqGmGLQe/ACJTh4BgtGHkr3TjR9C6oH0eJeWqavuZ2nliq6663IFUuoR
 +Wbf5cmpiFvRRrrjN0i7wiTv/1FcT5ydFRLoCL7FuuISW04U62YN6Bz4IaMQHQROvjp/qt6PKcF
 3qUBpJGK3M6oynCmsrDYU7XPj+ojRXANZQubXIOinEfASrlFuFkb64yaG+87pn24ZyaK5GIG8XT
 sZjBzlwRpPPsZdyWmDDxDKeoUOeZ/xqROnFCC0ib9cFlvSMNd4WAvyRZxU64F0o6SUGpjqtm8Og
 ZYZvdu+M4Ol5jClWtdRL+8CwRApavmn9/a+CZk4HnvsLJB5v6NRukd3j7i+x9FULOlmOwf9UUZH
 V8IcqMiA3YtOj0Smqq7bIoNEJ/Kn6ops+mc/QTTK4wxDgDBcSUUw0gVkA4xZwO4igTCljjUFLpZ
 0=
X-Google-Smtp-Source: AGHT+IF878kbPcmqvAdh2e86jEi2bU0SEvW/6lcPeukDBy0EEaC9B7W5uo2JQ8oIvQ0sQ0uED4tK2A==
X-Received: by 2002:a05:6000:250d:b0:3b7:905e:2a32 with SMTP id
 ffacd0b85a97d-3c32c434671mr2510513f8f.12.1755702765524; 
 Wed, 20 Aug 2025 08:12:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c287e6sm41226725e9.1.2025.08.20.08.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 08:12:45 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:12:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 3/3] net/macb: add necessary docs and update related
 files
Message-ID: <20250820081241.43462fbd@hermes.local>
In-Reply-To: <1755664500-9517-1-git-send-email-liwencheng@phytium.com.cn>
References: <1749200875-53516-1-git-send-email-liwencheng@phytium.com.cn>
 <1755664500-9517-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed, 20 Aug 2025 04:35:00 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
> index ccad6d8..8a66081 100644
> --- a/doc/guides/rel_notes/release_25_11.rst
> +++ b/doc/guides/rel_notes/release_25_11.rst
> @@ -24,36 +24,10 @@ DPDK Release 25.11
>  New Features
>  ------------
>  
> -.. This section should contain new features added in this release.
> -   Sample format:
> +* **Added Phytium macb net driver.**
>  
> -   * **Add a title in the past tense with a full stop.**
> -
> -     Add a short 1-2 sentence description in the past tense.
> -     The description should be enough to allow someone scanning
> -     the release notes to understand the new feature.
> -
> -     If the feature adds a lot of sub-features you can use a bullet list
> -     like this:
> -
> -     * Added feature foo to do something.
> -     * Enhanced feature bar to do something else.
> -
> -     Refer to the previous release notes for examples.
> -
> -     Suggested order in release notes items:
> -     * Core libs (EAL, mempool, ring, mbuf, buses)
> -     * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
> -       - ethdev (lib, PMDs)
> -       - cryptodev (lib, PMDs)
> -       - eventdev (lib, PMDs)
> -       - etc
> -     * Other libs
> -     * Apps, Examples, Tools (if significant)
> -
> -     This section is a comment. Do not overwrite or remove it.
> -     Also, make sure to start the actual text at the margin.
> -     =======================================================
> +  Added a new network PMD which supports Phytium 1 and 10 Gigabit
> +  Ethernet NICs.
>  

Please leave the template text there, it is only removed just before release.
Just add your entry after the template.
