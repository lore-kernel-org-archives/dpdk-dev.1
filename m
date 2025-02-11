Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED7C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F14409FA;
	Tue, 11 Feb 2025 18:50:06 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 381E44067A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:50:05 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f40deb941so126769705ad.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739296204;
 x=1739901004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7gq2UdrqwzQMWTRnOe7xjO2zlbraKCq9nmuarSXaBk=;
 b=VQZXal1blUUBkc0wLzzMMeIVgP4tHJe/r7RPYySxvJNGbkoW/K2Huulg5//95ZStuX
 02Ug0KAzkO2wt2hcnCFshpMY49C60MeJGKWqQ9Wgrt6VbgiHf3EmGTw6ux8fgsfEbtLn
 tDlWotzudir1HhLEkxP1mV4L0LWIFetBvLulUn0xDz7AmlkDPL14gMT/AR/nBENlSc2I
 YYNdfOYGWH5LRxdEnU7/obnEqNIh6DEm7qUtXmwHgUFqGc9L++diqfYfFEu4nnKQXdSp
 0qn0ubLLlYE/Zh2DaEYNH4wh5Lt43/+4ESR6up9NsG72KUIZ94AD8yEBu8zLGMf9TvUL
 CrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739296204; x=1739901004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7gq2UdrqwzQMWTRnOe7xjO2zlbraKCq9nmuarSXaBk=;
 b=AfhcB0NRAZGJcYM7bhP3GDEbXsmIUH52ZMl7I88LR8FfHZleEU74RNani7b8ycQl2q
 0NK/DTUx18RrvHlzhG25U1gXrxyiT44aRcUmx4Y1tpCLtYRYRZwqORzzryTtxWaNeqRG
 HPjsfX2yTy3/Sla6Epw0buW6PqNsC9ydLMRrnBDwI7/6lIbvL4z5Z28xUm/j45m58an1
 wDRWdV1dOJdv+U0tbd/9Bxb6a8wKvKYGrQ/XNohUIZhiekPuC36QjMXJU+At9NaL0U5O
 2DdxkuvDnT0XmS0IercfevwTq29nyWmk/QdFZ3CirLDIWc2ObpORy7K/aWR5HnjOb3nK
 FYkQ==
X-Gm-Message-State: AOJu0YxsNSWITL+gB27MjorGOlAor0MtiAtNXiHvg8GFu96u0kD1TyWX
 W/ZqnfJIEfYNHelZZLQNHzCG/rWqB3wBYbrQyYd0xsfCUvH0YjsbY4B78tF2eeA=
X-Gm-Gg: ASbGncs5HThouN+iDBeyTqinMhVzoamGEzxjO10jA+AZ92rbq+23ruzEkuPRoMBWAm4
 P+3Gv34Cbl44AZJooo5a5g28t149dUZOWKwb6/vaFdk9jZgyLYcEw8KepupoRcR6jJOH/3vtAbz
 IFEb9NIBcQUoop8lNejAXyMVFJrUH1+wF/sr/Vs44ynZP2thAVMERWNM5NdY9tO4U28bho4JAPi
 lfCS+E/pGsZck+4BmjYA5mWMc6M5LOFHj4izQJlV1qByAn5HNrBetMNtKdKi92Z7P357iHSbpC7
 GxC5p4GaB29U3cqXAzjOlVmIYqNNCYiGEzy1PYlZ6TFzrtBMAGNNCf1Hb9dY8NDjgbgb
X-Google-Smtp-Source: AGHT+IEyW98wM0yQXjk7BwnthqO02ZJx1T5uudxNj02igYmKo0rADRXA66ERs+NzNwxqSIpLZ6q0pA==
X-Received: by 2002:a17:903:1c8:b0:21f:3e2d:7d36 with SMTP id
 d9443c01a7336-220bbab34e8mr2863785ad.1.1739296204107; 
 Tue, 11 Feb 2025 09:50:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3650cd59sm99330665ad.4.2025.02.11.09.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:50:03 -0800 (PST)
Date: Tue, 11 Feb 2025 09:42:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, pdamouny@nvidia.com
Subject: Re: [RFC PATCH] app/test-pmd: add option to run startup cmds
 without echo
Message-ID: <20250211094228.0e4ade74@hermes.local>
In-Reply-To: <20250211164402.99941-1-bruce.richardson@intel.com>
References: <20250211164402.99941-1-bruce.richardson@intel.com>
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

On Tue, 11 Feb 2025 16:44:02 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Depending on the scenario, a user may want to run testpmd with
> pre-canned startup commands either with or without echoing of those
> commands as they are executed. To observe progress of each command, or
> to help determine what command an error response is printed for, echoing
> is useful. When running a large number of commands, performance can be
> improved by disabling the echo of each one.
> 
> Therefore, we can add a new cmdline-file-noecho command to testpmd to
> allow running without echo. Behaviour is otherwise the same as
> cmdline-file command.
> 
> When adding the new command also:
> * fix leak of the fd when using the existing cmdline-file flag
> * add cmdline-file (and cmdline-file-noecho) to the testpmd docs
> 
> Bugzilla ID: 1612
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

The variable and option name seems awkward to me, but I can't think of
a better suggestion.
