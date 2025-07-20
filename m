Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB36AC83F22
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 20:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97BD3402D7;
	Sun, 20 Jul 2025 22:30:43 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mails.dpdk.org (Postfix) with ESMTP id 63E3340265;
 Sun, 20 Jul 2025 22:30:40 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-31329098ae8so3122528a91.1; 
 Sun, 20 Jul 2025 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753043439; x=1753648239; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ohu2tZPFuiqSvnY6mI1kqw6Xab5k9DrNLf7gAqo2Sqc=;
 b=JsZLnOYrfOXYtOgam5JWQeWS4bKkyHD/IbovpdBZIG49E6eLn4QUe6GOR7MBJ2MrZ8
 KP90a9px3g/rgXqQQ+0rddV7qWym6J0jrQitnFuS2W38XgKnCT/iMqdykzoR9j9723is
 y0HtTqO0KquJ4jDK5/yApboCQwsMsmVrQKXh0ouPO+exn8DyVNVUuYOQCFvZrORjj5Zh
 i5SHIEuMagN4atcQ4j8EAWZ/gnH6nKuhdonqKjwzNUa6QL0VcLPRlHGnxK0ES0WQJW2b
 bIJCnKbdq0KDVTtJ3SZf47LwlAPKYKMKyWt0keMwhwxDSzlCYsuQpIC4/OOQyvA85RQZ
 0U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753043439; x=1753648239;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ohu2tZPFuiqSvnY6mI1kqw6Xab5k9DrNLf7gAqo2Sqc=;
 b=Sw6bDYyXc3Rb0vSxI6qtKuJlLvjkXtekDc5NlThxXcp8ZeH3YGWmOG3J5sE/aL6HUL
 wAWzyX2njsgqEBwYeDqEL2/G7NEhuo4KI9JOXTidZH+43jZ5EpPL4/uDrkwgeW+VGjUb
 XCGxq+gpfOkjMwu66GDrheT+CFxHEgzH9ZAMP0Xxkxz92ioJVVuD/fX/JqhGwZmD7XCT
 MMPiGMaB7jQz7TX67R0W1T286PO3QOF/OfNB5fUM3rsRJxl04AtxM8hSNBClmnDAG9Mj
 0pBicYaAkQSMA8d8N4dwH3ldlwW6u4icLG125TzD92wNe1pPDzlg6+5CEXm7MMWplFqa
 jhGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBo7CZGtk+bp9UPpjNxhGIetauKnPBW9nvJEfs/fRyrLFcmi1nsuN6HYbjhnEIRIR8i/0=@dpdk.org
X-Gm-Message-State: AOJu0YwrNoSEtDTQ+xYpTxDkEVQkSJ/SRe8oXmD64oQ91cp765MEglBb
 tZvNNWIm7QXWDqijjrw75qMTC/uMf6b86FFezeqv+Hkuodjplz1kzwjl7NBiJ5fiu2KN4Rt7Hk/
 s8PqsNX3+3MIQM9qQt5T9rNMVUudcLnFaWjSJ
X-Gm-Gg: ASbGncsMNze2rdGYjCfOANU0yxf8a8ODopqtOINJLmmEDrP3RcpiWuTleKKDiNyY9JO
 6e/fccAPdotqY75N6Ldd+xmGkLDrOb8w9fUhkpinHC7RDQ2UtyFdMmVJmD+JDWu6iPCU7nQ67Yx
 FaZENlg0aN7ltJH2+0IO1G0Hr5g8aL+9/+ZOdd51pcu/1lV3A44GMHzvGxAECr7UlSRcOiMSYG/
 dXr/0Em
X-Google-Smtp-Source: AGHT+IETqcOkhYoP7rKCKHJHgsNLokoq/UZNjEHn95Kx7tHgZwoWtV0r98h1IC9SLwDcjBJa5sC8/G31kS3m2YnQpHw=
X-Received: by 2002:a17:90b:586e:b0:313:17d0:b066 with SMTP id
 98e67ed59e1d1-31cc03dc2f1mr15463843a91.7.1753043439000; Sun, 20 Jul 2025
 13:30:39 -0700 (PDT)
MIME-Version: 1.0
From: Isaac Boukris <iboukris@gmail.com>
Date: Sun, 20 Jul 2025 23:30:28 +0300
X-Gm-Features: Ac12FXzL8wFng1Fx8Pf5yeMOld69WWXr0mDIKoQHCm-wpQ1MpqkrQGs4Ew7W3_A
Message-ID: <CAC-fF8TLJnunZgYgpv-XBeH0ydN9hK5k5g_PZae6gA16rQ2ZSA@mail.gmail.com>
Subject: dpIP: a POC port of lwIP TCP/IP stack targeting DPDK
To: users@dpdk.org, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Hi,

Sorry for cross-posting, no intention of starting a long discussion,
just wanted to share this in hope for interest and collaboration.

I've been working recently, as a fun project, to port the low-level
lwIP code to DPDK. The idea being to start with a minimal yet widely
used stack, and gradually improve it by reworking the code and the
API.

It has now reached a POC level with a couple of working examples and
tests. That said there is still a lot of work to be done, such as
cleanup, API rework, porting more protocols and unit-tests, etc.

If anyone is interested in cooperating on this, plz take a look:

https://github.com/iboukris/dpip

Cheers
