Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE3AC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1D804028A;
	Fri, 14 Mar 2025 00:46:11 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 3166340289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:46:10 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so2778264a91.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741909569;
 x=1742514369; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=cN89hwOpDs7i42WHBgoiv2pk6XI6PdlFSkfbtQOSuHw=;
 b=prVVPIlE6O0+gNunLFxuayM8ltRy9SQWmgtUaNsptohiPrKTEMYADRo3soO1gGdQJF
 xSXU3IG8cII5u0n7hBEg8ZfhrWLr9c3Kp9UUVrEqLO5BgzqE0gNL5DZOQ1Z/filOCPbk
 JnS+RNcjpPv6S4hRB/YLjRaGl/gT2FYHBDRHyyqXEK314EAkTNpCYlhoX16Icr8fOJ00
 Bxc5FdnDmy+vdMz4N+2z9mSqXBSuUr+P7LdriXtaygob6Eqhl0LOksua6y4rVUFdMvfL
 sfufGlBsz8uD3m2SQhnqtMfkwacgVzgAoCPWLuUvjZyitfxcCazDxjzwfNyBMzecOhA4
 4qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741909569; x=1742514369;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cN89hwOpDs7i42WHBgoiv2pk6XI6PdlFSkfbtQOSuHw=;
 b=Zos6i4tKqmdGxAlYoOYYgW0X3kc8Ssw70UZ0mqHDgOrR/pOaicIaK7A3qt9dORTy84
 YhXjAWRZ2pnLdqR0yyJ811gpybgwN0ZhPz8rq+Nq6S65NuAmdddgLoYU5iKnU/k4RB4g
 BJFpbnR5vpNZVO4xL3gfWSj74RZhq8YbELLjXOY1ku3r6Oivj4m/79HovIe+mhg+qkrH
 QA3b2IdGThEaYHE9bwm5UVsKlGYJcVBZ0mvNqJB3hal5tyE7X9AesBhTC08MHuViKYhb
 tI2kHkAL40R3NEQED5Zzz5H9PKf3olIw2bTvmQyDEg30F99Syn3dSo3sJnY/hchoTPQW
 6C6w==
X-Gm-Message-State: AOJu0Yxz8XKyrCm5ROsCte9WtwhXty2AzaM+CNey7RUUzcH2YCvjqPn6
 4dyVAAVMyxDFJsx2ATZvn5cZHC8XpBtV3JuTJrLibTxCCZSFN29SJRNcIxPXuSUeG32h10ydSPj
 r
X-Gm-Gg: ASbGncvOoipSwfbtxwKTTBpKLSNprzzXFC749xDqF69qNA0MDBbgOgwaFLppI0zBMPJ
 rsF2hP1PrsoLQhZL9o+n9YMQDwkLwiVPEzssnW/x6zuiiaExO6BDO94UHJ5ls0T5mF01Ym6jaju
 KXUKLYgxyUf9ZQwioYogVBbAjcrhy/LPjDzRni4tHGZrgu10m13lV5xskXEfqp0GG70snu0R7x8
 yz2UlYjenfd8H87e83XYaiE/gukbt6ZTVbubgJ0qRkW9+ybA8rQbpqkLz/h+a9DWAtfzRO8hwio
 gQFkKMnlbFlvVpeogYECBx+ZaAwewDdb/TottXXd5ZoZmXZ23u3g8s2snVUvwdzvCefMt73roeV
 pFpfn5ts74d669BbVZc9IArULYtle4pn0
X-Google-Smtp-Source: AGHT+IGAgt6cdKp7yRGrGQoCPUYcl+K9cPkbOOQq8vWNZWC9e6MMQIQtO24mfjvk2ezQA1IC5kQbkA==
X-Received: by 2002:a17:90b:1343:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-30151d81735mr444392a91.35.1741909568968; 
 Thu, 13 Mar 2025 16:46:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301390b05a4sm1997155a91.49.2025.03.13.16.46.08
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 16:46:08 -0700 (PDT)
Date: Thu, 13 Mar 2025 16:46:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Techboard Meeting Minutes 2025-Feb-05
Message-ID: <20250313164606.3716e5e2@hermes.local>
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


Members Attending
-------------------------
Aaron Conole
Bruce Richardson
Hemant Agrawal
Jerin Jacob
Kevin Traynor
Konstantin Ananyev
Maxime Coquelin
Stephen Hemminger (chair)
Thomas Monjalon

NOTE: The technical board meetings are on every second Wednesday at 3pm UTC.
Meetings are public, and DPDK community members are welcome to
attend. Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes

Next meeting will be on Wednesday 2025-Feb-19 @ 3pm UTC, and will be
chaired by Morten.

Agenda Items

1. Video platform for up coming summit in Prague.
General consensus was that Youtube was easiest and most accessible to remote
participants. With possible backups of Slack and Discord. There is a problem
in that many of these platforms are not accessible in China.

2. Code Challenge
The survey showed that were 5 items that would be worth pursing.
  - WiFi support
  - Code coverage
  - review and bug triaging (using AI?)
  - document best practices with DPDK
  - L2 learning bridge

But in order to make progress, need more involvement.
Stephen is willing to help but doesn't want to be the sole person trying
to make it happen.

3. Process issues
Aaron raised the issue that patches come to often and overload the CI
infrastructure (as well as reviewers). Will work on a draft policy
to give contributors on guidelines (once per day) and more feedback.

See "doc: Document frequency and volume limits on patches."


