Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722CCEFCE4D
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 00:07:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FA38406B6;
	Thu,  5 Mar 2026 01:07:55 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 816694029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 01:07:53 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12732165d1eso8085496c88.1
 for <dev@dpdk.org>; Wed, 04 Mar 2026 16:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772669272; cv=none;
 d=google.com; s=arc-20240605;
 b=YcNUkVm/ZB81Z21LlNlZFE36SSbVcYkPcjYimuI096Q6eYVkjrliHWJHsYaxw1vY+m
 r/wo46D6obVNfMHObQdBduaMSjDTtgJa8XnG9T7QQpJOkRJ8upw1hO8KwlXBJwU1bHCU
 92zq4qGOef0PHYZZub6Un7teDka45vPfuGyi4YccTtVrTzpD9DizqTNRd5HQiFDOqwK5
 pZ+68e1FSRS3cG9rOxobz29rjcjyj3SxrsjW2RNqUl+L+jZcHLdeYlPeXaL+GsoXrRE3
 YLWkCc7PKxBCefxqrWiB/fTrBfrdaDbO9a3WBygW+9nQnY4suJyLlf0QpP7tU3cHw+hh
 by6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=5VTP3YU7Dr5X83BZLxIMaJRMvN70zbJ7mwji1DF55n8=;
 fh=6iNmakO698nAyEze7EQZkGAKcKkZGLflACmRw2xLbpA=;
 b=T+W4dXjK4swmS+9ylx/9rJ/RjkiVch9ORZp9oWMhVyo/Q7zj8pewoxFYJk8ODhUxXl
 EvCSn+0tEWWMWMYq4dK1T19sXnF+DSRKvh+eKii7rPskfaMtZ7KzxgcjDLm3IiVO2mUD
 MzielKKkJPGO9+k1J+b3Cb4/LMMqURZWXQpx7GJuhW4E7A4a8yH/1GVyqE/srIvRZ4iz
 ZobKf4qEkw08wzAqN25/RxcIw3V8ke1lWGzgxYubKKF5A5+N9PXXleU6yEuL6NplFY1M
 1mMBcbBq31XYMip1uHgLJTER66oSQ5+P5rFETinTV7KJTHG1tTRv85+rEuYn7A+d3gGJ
 AaFw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772669272; x=1773274072; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5VTP3YU7Dr5X83BZLxIMaJRMvN70zbJ7mwji1DF55n8=;
 b=inIEok6e8owpXIrIITdufm/J6X7GlvcyswXGtZHekPkvddpa988Pe4pptnhUOOaqnY
 fNnWTqdCwsd3YxpIGfqnn9a3Jx/GLsUDwQ1+vruV85yLssDx2SWXyacW9ctVrkURL3dd
 cYJWWW4nQWLaZrXvIKwErjQXo1/Un/TDziHoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772669272; x=1773274072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VTP3YU7Dr5X83BZLxIMaJRMvN70zbJ7mwji1DF55n8=;
 b=p7cq3V3zrbeYQzRRsgmTZGn6m9TzCU2NrcvAGjIwgni9OqOl3/geEjVFGvYm29SUs8
 Co4JjBigJPu3bS+GtawbCDvzd2QSUTr0hS+DdFob9Twy1ifSM46QrrmQlzLMrvU6whNJ
 KkA4FOCvkUOOQiXu93q+p2bMO6e69+S9HVn4TQzJm+WB/QeceZjqxJMuqHk0lL9mFQsn
 eUNmnh+AJMQxF5yV00V0on9XzOavqb8/hTDJHBfq/7v6Pz8vEjCrbE06vtnBdfJykXyM
 9C+EVyoNWVDTpjVFsvBx/3lo/sptU4d4VCu1WTOKwgZBVpjETlhF123E6RB6B0KnaSMJ
 3Y2g==
X-Gm-Message-State: AOJu0YyNQFevjB44fZvM4J1d2Znzm5EXAY3/kP1qAOydqKo4zkeKwDdS
 b+6HG7jqMQs7/zbYZAmfpxDbSEUPqwdbe8GtLhM3OEbcVZQdtiCLAXGf4LBohZDm6aEIHGDK7H4
 7prdnqZAIoJyLtuaVF3P5PieO4l2d5yvFkusLYtzzu0DCvPHsCGNcDVAACg==
X-Gm-Gg: ATEYQzxsYnPZGspCQ2AhMKNHkN4ethshVw5XtL1mxvmAH2eSb2yGUhh8gUGDXk0FY5t
 7CJUqWywbObPv2qkgdgr+cbs36+O4zYdt4f6nCBFJAF/Wu5w3zdzxz0ddNU0mE1bi705H9fJbhv
 biL9DxpkkKNR6UNPqYUkUJmqz2V7/KS96xFYmt+Er/2LRhQQ4S2G2RDSLA99PnV8Qjk1e/mKOdq
 JTZ34u4kV/QXL/vKZxEdf7z9kGx/DSmDYnz9w6YzhojS34Z6oEkl8wScyOKOR8mN0GR7z3jyYsG
 kzyCJ3oqo7gxg8YgZeuaFy8naAwnel5WiYbZ0PCiNjKQO2aLzjrlKn7KrcK5BYxpvH1jDvXv
X-Received: by 2002:a05:7022:6ba8:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-128b7094ademr1786334c88.11.1772669272186; Wed, 04 Mar 2026
 16:07:52 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 4 Mar 2026 19:04:55 -0500
X-Gm-Features: AaiRm53BaOfAkLCRuDXMr1tnp_crqKLbKXW94YH_dScSSJqSyKkQyMuS0WYhTn8
Message-ID: <CAJvnSUBRLFpzSRrY-6xbFSWX3C_K+f-7cXxnq6aRSTtoe7RG1g@mail.gmail.com>
Subject: DTS WG Meeting Minutes - February 26, 2026
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

February 26, 2026

Attendees
* Patrick Robb
* Luca Vizzarro
* Manjunathagouda Hosamani
* Matt Labrecque

Minutes

General Discussion
* DPDK 26.03 schedule:
   * RC2 March 2
   * RC3 March 9
* Patrick=E2=80=99s CFP proposal for DPDK Stocholm:
https://docs.google.com/document/d/1f31BihHVWAuAYcU_MoZKeN0lhs0jJm2_v7AXO4U=
rjaQ/edit?usp=3Dsharing
   * This has been submitted. Presented the idea of doing it as a
=E2=80=9Cdemo=E2=80=9D to TB/GB.
* Discussion with Manjunathgouda about legacy DTS vs new DTS:
   * There is a goal from the Intel side to move from the legacy DTS
to the new DTS
   * This team does complete validation from the intel side - they are
reporting the intel test results on the release notes.

Patch discussions
* Cryptodev testing:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D37325
   * Patrick reviewed the framework and API code yesterday, and is now
running the testsuite across our hardware to review that aspect.
      * test_run.yaml and nodes.yaml config files optional fields.
What is the best solution going forward? Is it a benefit to provide a
more verbose documentation of the optional vs required fields in the
.example config files?
   * Docs build failure reported by intel lab has been resolved.
* Flow offload testing:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D36976
   * MODIFY action rules will now be hardcoded, as supporting modify
in the flow rule generator was adding lots of complexity.
      * So, only QUEUE and DROP actions run through the generator
      * JUMP and MODIFY are explicitly coded.
* Support NO_LINK topology:
   * https://patchwork.dpdk.org/project/dpdk/patch/20260224163200.39360-1-a=
bailey@iol.unh.edu/
   * Patrick to review
* Speed Capabilities Testsuite:
   * https://patchwork.dpdk.org/project/dpdk/patch/20260225183328.73357-1-a=
bailey@iol.unh.edu/
   * Patrick to review
* Make one link the default topology:
   * Docs build resolved
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D36896
   * In need of review
   * Patrick to review
* Can be merged:
   * Testsuite name cleanup:
https://patchwork.dpdk.org/project/dpdk/patch/20260202170924.398261-1-abail=
ey@iol.unh.edu/
      * This is unblocked now that the missing testsuite rst files
have been added
   * Limit single core performance test to 3 significant digits:
      * https://patchwork.dpdk.org/project/dpdk/patch/20260224200419.50597-=
1-abailey@iol.unh.edu/

Bugzilla discussions
* Andrew has continued to clean up the list and pick up small bugs.

Any other business
* Next meeting is Mar 12, 2026
