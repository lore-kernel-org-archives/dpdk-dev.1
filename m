Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CECC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:51:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20F2040270;
	Wed,  5 Feb 2025 17:51:42 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 1F7A440261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:51:41 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2f9f6a2fa8dso678992a91.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738774300;
 x=1739379100; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Lu2aN6Qc0gQaHfi8EFVCkHHGtUepshZ6hddfF/2UMg=;
 b=v+KWwAcfTYJMPMdJrf99ySk7XQbxguWQVpJtb3L4+C+bfG0QBT1CWKJXSCzLzjl8PC
 qAAHpyvfju2RfzbbLbNt0jBtnD7cqvIPumGBtiRELQyUJoSZqouKn3/T3XGDack5cePy
 3t835nM9EWAO3wLVReD6BWZEmd4gSgCkqCewk+9bARVLdLo8CZHsSXhE77srWfPaiPlY
 uwZSJYWwxPoxm8zV2wF0/pR6nPC0Yxo6sZ3XcpQzUpgmp6SJBLREix23i+Ya/k5TGqzt
 Tj3lrzcxJjrlxQzhUI0JVJX7gf8TPQu1Q1NCwqymnyVpknw1+OjTilolG1mf1GhVfAIm
 hnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738774300; x=1739379100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Lu2aN6Qc0gQaHfi8EFVCkHHGtUepshZ6hddfF/2UMg=;
 b=YPuguzZRpvXWAcu3tsaf77EIyaV5qgOWumwLCwdrJ5VdLIiN2WdkA5ZErNUflvHqAs
 TC8IThJJIy17qxwGm/llFxF6Y9zKtW54vvjMXZmWmULZz//Q9f0xUzFkPX5UKmVkGwkw
 6Wjd9PzUYboLVkP0pALm3EszomZ+AGnHAxx1OjvtJkqITa6zEyPknu0wfcOba45DQpRO
 1hDqI78NkjzWgS8NAdp9XdeQ81/USulHSe69XvEWYI2UBhqfomRfF6mRE443vhoZ39FI
 nMLh3yQcAtholM2O69EYM6Cz10/TSXibQwritjipqaC2qOrf4LnXhLXb3TE6hMxmNUcO
 fl5Q==
X-Gm-Message-State: AOJu0Yx6chhWprcuMZiV81Nf8h71tAj8a7bak7tTbumOY1FZIAI7pC4t
 u6toBJdIfACpnVQGs7ZT57KUTMsSrN/m/4k8cHxQLleYjXBZ8V4ZKAHbMbNbJ58=
X-Gm-Gg: ASbGncu+LtlDVjexPRTNt1MVw0+IoBGMNRsMT56E8AzWP7BUtkRJkLMiEwQYCzJP00X
 DcykUTNGItY7Ew6clUuu3bGOa3pEol4/K75Wq8xx2Z4ovyIUBUHkPAePbqzDYRTvAaxd0LN2pGc
 MFD5/318tglJlb9DeWquJoFwzE2hz4j7Rp3arpgQPHundgXkvYyCHIvt3RNg3E7oBWTs+G8mMkE
 kBzw1QVhIyU0wtE9gQzfhMCoaZgFpIJadSF5HgN6B6ItB/PzcP7bBvOmwuNaMYm82WJl9bjWQcT
 w9NGrtu+NsLOiVWOPMHSwb3Xv63qKGiep3QuVd4jN34jpzRLHocOguMOX024F7UIlnhL
X-Google-Smtp-Source: AGHT+IE+RsKd2AAVldG1ZpJ/xY+1nMbR9o29OLAPP86aFNBWjSjDbF0lpO2MediqjOltHm+5NQWkQw==
X-Received: by 2002:a17:90b:1fc7:b0:2ee:693e:ed7c with SMTP id
 98e67ed59e1d1-2f9e0868531mr6348122a91.33.1738774300201; 
 Wed, 05 Feb 2025 08:51:40 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb97csm117206035ad.123.2025.02.05.08.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:51:40 -0800 (PST)
Date: Wed, 5 Feb 2025 08:51:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v2 00/34] net/ntnic: bugfixes and refactoring
Message-ID: <20250205085137.10921d3d@hermes.local>
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
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

On Wed,  5 Feb 2025 11:45:09 +0100
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This patch set addresses fixing issues in the ntnic PMD driver.
> 
> Changes in this patch:
> 
> The issues detected by the Coverity Scan tool.
> The problems that were detected by the internal tests.
> Fix for Bug 1622: ntnic: using signals and threads:
> https://bugs.dpdk.org/show_bug.cgi?id=1622.
>   The handling of signals within the PMD driver was removed.
>   For manipulation with all threads dedicated EAL API
>     (rte_thread_create_internal_control) is used.
>   Product by design requires usage of threads inside PMD driver.

Do any of these patches need to be backported to stable versions of DPDK?
