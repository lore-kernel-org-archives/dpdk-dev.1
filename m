Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9927EFCE22
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 00:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BD3A406A2;
	Thu,  5 Mar 2026 01:00:32 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 8746E4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 01:00:31 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12776bebe9fso5796236c88.1
 for <dev@dpdk.org>; Wed, 04 Mar 2026 16:00:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772668830; cv=none;
 d=google.com; s=arc-20240605;
 b=g7hIh2iGJSdf+ilj2hobqVorjXh3HPO4NzCMkjXxc6xOSH3x/lwms62FuXhqQQMQmQ
 uwe0ACuTch4YHDiAHkw6MrJzxOx0sFhUUwXPhL22Dv8Fzcia7u0asQ8EzpJQedDcJQ9h
 CXx7CsJnCxD9C1NVlDdv1iDHjVMZvBmOl5EMXKHIIHHNCzEWzUj5rqUIQEMWCoUx2e5+
 8j4hGgkWgVAPQw7TPX98W38bbDNct8IXe0ok+O1QOOHE5Z/Cpqdg1lmz9LF8FBC8hdw0
 6IEzD5nXHuL9IQDtx8INMk1AqhAD5r0Ilrob7Wc42z+9CIvlM0buoIUNwWvGi2Sr8tIs
 YP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=LYVL/FzlGwN7CX4EYs58QTfMjEWXyZDrFIAcKPmx1Io=;
 fh=6iNmakO698nAyEze7EQZkGAKcKkZGLflACmRw2xLbpA=;
 b=NjitWIy+QWPgIP3GUfVqj6IT+g49jtU1LzP8cSNa6jjHaYTXO/E6mLXBC4Fr8PXwQo
 xyQGcWoV1dbJ5cXi+RUd4eVxgfFiOMOgZbQa3QmUelLJnDwpyB+ByO99essD+694CLhI
 uKzBCoy70490Tj4CW7XRZ6MUteiH8j6ldpF2rIjkjtdYv+hJR8FNl2zr3qTXEEmL4u0u
 BxfBJQRwPqEaUncaZNz5lFj27a+n+Yyds44g7kS/hcwdCQ3VjHLul+VSy4kBcM99fqMx
 Su/mlRffk9J1IF4ZsUFIbegP/gR4KU2MOWxhNacMFUhhLUeSoI2zqXx/ftb/O7zUMC91
 2VYg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772668830; x=1773273630; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LYVL/FzlGwN7CX4EYs58QTfMjEWXyZDrFIAcKPmx1Io=;
 b=aNAug0EVHgF127u2+4mJBH0/TroaDCoRH++PuxpZaCxANBa7BRX+XBYXQYerNAyhLf
 6mEmtzzxsIHG7rxQwoT45kAScvMnhQI192m5/EtcmTkTcNX4DtlXKQDcVi0gWtq0YrjF
 jhcIRFkWrAQNqPdjfyx3R/GSgJMuVswIJHVKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772668830; x=1773273630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYVL/FzlGwN7CX4EYs58QTfMjEWXyZDrFIAcKPmx1Io=;
 b=xD0N/INvqP7SgBPjg/wOHWYuTQtMq8/Xx1BDNQv8jIVwXZtkpfgJv3L/a6QLh4zPqf
 RYPUfj67DJwXCJ75L+ajRe/14JsgZyFMCs+vaajcSG+hdfXvcrNK9VYwHFLGEWeQeyZ0
 /CUbMVaPFiCTOQTKohszAX7Pi42kMSM/L4B4jC6hSkAJexna2fTGAy1hmwmEaHYFEDst
 NGOMkxtTgjucIrYW6iyl+psE2+DOigu7+aMKiDUZtDLVdNlRXL5Tha+h3zOg8iE3aX/v
 UJ4OrO3xXHiNu0UcH/nOoH717PX1JbgyJYEB8IgUQH88SO4JgbLGURGGx7WzmbDUa/4R
 62pA==
X-Gm-Message-State: AOJu0YxtP3+PjreF9mdoPci4Bksc1N5wjUd9w+G+xuKO6Y3wEIX00Wk6
 X46CyhHjd02xfyI6bJ0Fo5sOngdoxud9n4eVZTWC35yZOOaxBfuWWduv7iS4tBls9AuSgRaQq9I
 kYu6wVozcSJsjp48SXfTM+k/Obhc5jYOxFIA2QVeU3HsECKvIrlVyYQ4KUg==
X-Gm-Gg: ATEYQzwQOTQSA5bnJFHKodYOJpUOvw9VMtgAQKONbA0Hm5GUdI1j1j91m60pexMNAHJ
 fJz1TlRpJ1R5sb4jaDZgAozgfEQ03Uos4VNqcuDl9paOpYL4i6h+GJpAZeBDqICc/7wEhOggEmS
 HOeLCwHq9Car+VlzgifM6ie9SktgSxwvjhUm8fkhKtHDYCKuQomY2t5xC1+wral/3H1Mo1qUQ60
 FjVAruJtERPDAVCvotW1g8s5XvfP95ehc8Zqt5zx3ZJMXbtVwOUsynHwoBEtOw6SLwvzBPhF6aB
 YrsYfrhSXsQJhntoVPtnRr4KJoWjxkS5sVS+YpwyJypJxGfw+l6E4UgOn+uh9O42AN5szy62
X-Received: by 2002:a05:7300:80c8:b0:2ba:956e:d26a with SMTP id
 5a478bee46e88-2be311d2787mr2063275eec.36.1772668827054; Wed, 04 Mar 2026
 16:00:27 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 4 Mar 2026 18:57:30 -0500
X-Gm-Features: AaiRm52wbq53Exh8sDTzzFWxbPjGDZXVArk3wAbEwJWTFfD4zuOiJ1w_i_Ef15k
Message-ID: <CAJvnSUDYngNDDUnKbB1FB2=SFGV7NVwrJ0ZaW0fixqD-tXaBRw@mail.gmail.com>
Subject: DTS WG Meeting Minutes - February 12, 2026
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

February 12, 2026

Attendees
* Patrick Robb
* Luca Vizzarro

Minutes

General Discussion
* The release candidate 1 (RC1) date is 9 February 2026. RC2 is Mar 2, 2026=
.
* Patrick=E2=80=99s CFP proposal for DPDK Stocholm:
https://docs.google.com/document/d/1f31BihHVWAuAYcU_MoZKeN0lhs0jJm2_v7AXO4U=
rjaQ/edit?usp=3Dsharing
   * Reviews are appreciated

Patch discussions
* Cryptodev testing:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D37325
   * Andrew to check out the GHA CI failure:
      * f"Gbps and MOps were {result["gbps delta"]} below baseline",
SyntaxError: f-string: unmatched '['
   * Akhil sent a clarification regarding the algorithms to be tested,
and in what dpdk-crypto-perf mode (cipher only, cipher-then-auth,
etc.):
   * Andrew has added a new crypto_perf decorator for dpdk-crypto-perf
testsuites.
* Flow offload testing:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D36976
* Can be merged:
   * Testsuite name cleanup:
https://patchwork.dpdk.org/project/dpdk/patch/20260202170924.398261-1-abail=
ey@iol.unh.edu/
      * This is unblocked now that the missing testsuite rst files
have been added

Bugzilla discussions
* N/A

Any other business
* Next meeting is Feb 26, 2026
