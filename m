Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD371C19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 03:01:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D15C0402E6;
	Thu,  6 Mar 2025 04:01:36 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 779CB402A0
 for <dev@dpdk.org>; Thu,  6 Mar 2025 04:01:36 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso452624a91.3
 for <dev@dpdk.org>; Wed, 05 Mar 2025 19:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741230095; x=1741834895; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BSoxkA7BuImnAoNpGTl9O7xXPlO154bN8mwuK6cFTJU=;
 b=e9jFkVAzOXmGp5SYnaPuJP2v79YqPLavoRBddkya3okXWWDevh7LuZW74fre2UeT8g
 VxamnWf0NEBNF+a7xm3oHnpkuqnq7LcqOzfrR4i6PW1V3qYOZKFktgOnXwpPQdr+YcAf
 fLsRTGffswGSD381zerd1Rz69AIzyCiWvY9JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230095; x=1741834895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSoxkA7BuImnAoNpGTl9O7xXPlO154bN8mwuK6cFTJU=;
 b=R+6r6Pc0ZoaYU8sfyHaQnCU73hezSpJUWrb7xfGrN4649TlTMADNJxLyCGjhzrC4ZH
 DBPgxH9kiuykcL/EzHhsxVsNW3zBvsVMtvhPEo01ab83udyhiMBKpiy9k8qqW1WQ3H9S
 bDm3RKFJBQd70YnmZtUda58AZ2WXL71AVO29K4Ps27hVd3GNYphl22cu9+BZnbfWkqQC
 k9DrCL+Sc53SzfjKTM1qpV+aIeAU11jH3BE4NlhgRgT75yWrb1vQqXA6C13qQS5AtNwX
 zzgvLqYTQQY1e4w2Aq1d+o1I6edJx9IdDAxjptaVlsaiOgdzQCP2RlMik2xj/XQl+p2b
 laNw==
X-Gm-Message-State: AOJu0Yz5RdtLXKmoC5X5j/PuO3Lfq1rwDX24Y+bGv2qTJHd6jcDP+ID5
 ME836xKigWzflFJqxAxK5658TgmlpcaRQ8mEhYfBQCmdgOZoyytHamgOcQYi+xJ2belfZMhLilH
 MxezLoThxBYWAKBTpL0n8jo4l2UyBm043ryYE/7B1abpKFGeyoy6l4Q==
X-Gm-Gg: ASbGncuXUKbWO7e+J2jWmMNtg1LDXBv0/f/p9/fQ1bgoKqVDlas3R+inViOgJnw+Qxa
 8LTihfHgpqZgmLQtgwouOflAHsXJ9+qaMWabzQBPpV/0e4eN0LSSDZOKiwcXQAzgaohDVTPBRpH
 VPMEnN8KCUH8gMZP5tzfOc4LqrBEbpaZx/5bjFD5xt9g==
X-Google-Smtp-Source: AGHT+IFjrp9ycxzFQyIjur0J4h8Vp5wzjzO4kMSmvPQt5sUw9lO8NEpinqGGDuhyr2NcU2BREl3AkujzwtKPJmKPPbU=
X-Received: by 2002:a17:90b:5250:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2ff4978fe9dmr8821596a91.6.1741230095618; Wed, 05 Mar 2025
 19:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
In-Reply-To: <20250305212349.2036410-1-david.marchand@redhat.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 5 Mar 2025 21:57:58 -0500
X-Gm-Features: AQ5f1JoVktbmBiNzodMAJ3NBlvuqzaMcKmXc0ZOSK2xLBz0pG16FAPuwy1et5N8
Message-ID: <CAJvnSUDP6USFKX6CupnTxWNhzvTFsWVOxjQjD0QXoXr6BSDnMg@mail.gmail.com>
Subject: Re: [RFC] eal: add new function versioning macros
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, andremue@linux.microsoft.com, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Content-Type: multipart/alternative; boundary="000000000000526cb5062fa3b95c"
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

--000000000000526cb5062fa3b95c
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

There was an infra failure with the Arm Grace server about 12 hours ago
which caused this failure - sending a retest request.

--000000000000526cb5062fa3b95c
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Recheck-request: iol-intel-Performance<br><br></div>There was an infra failure with the Arm Grace server about 12 hours ago which caused this failure - sending a retest request.</div>

--000000000000526cb5062fa3b95c--
