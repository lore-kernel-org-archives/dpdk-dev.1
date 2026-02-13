Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1668EF99D3
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 20:44:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3579402C0;
	Fri, 13 Feb 2026 21:44:16 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 98DA9402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 21:44:15 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4376de3f128so904325f8f.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 12:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771015455;
 x=1771620255; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mpd1VxqEV+kZ2CSXe/PU9LylFJ/hjmrnn5oaicpDrhM=;
 b=U/jaxicTwlgOkmGoYpO1mc09z6ur0vJxz2rHEo2JXPViPn4wm64FEY4bQc5kswBnDC
 NFSim/KOwQzKmx0CO7NL47hSGHo9YqXd6OGYpiMD9rwfpCpspsGNofcbzKDRBAAyURW3
 veqEvYkKsw5omk6YPQzhbBJy/8tsUnfEDQhvFt/kQLNzfLC4NWtQlSFhphpU8kcN3dQK
 4ymE7HNWvx0bSmwwWZXssvh4IYAmo2yRjbSuYi1ra0VzCktm8y814RPB9Wqa7V4PMOHs
 xd/3biw9Y2k88VDklQcT6CO0ngVH8T+7jswBy9WZiOh32oUMJmjgV/rSrtPp/bR20ZTr
 GpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771015455; x=1771620255;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mpd1VxqEV+kZ2CSXe/PU9LylFJ/hjmrnn5oaicpDrhM=;
 b=bYkW96BvI/3oGIVw9XHkg+VDaqm5ZSA1VIwx20gIY7t01k/5w+c5YawyJXI6QPTmOQ
 uysVatfLHua6btPv+dGQWOGqbqyA/aaRnzEy1avm6iKztxisjwep35OVQVhW/KpoR9ar
 bIKKqhKVHd2N9FrX7fQVQVLyqJCxwTM4S/rHITq69TAaCxza37F2WxS5JGlUVglhi9Px
 q8jXWAZez5rlt7xjbJtR0egBairYHF1ebradzijLAb8EQZg1EEXAQZQiGAm2EIZx30w2
 KbadTw15P1P7cWYK7waMgfqS+fk0+ahjQ8yRe8P1g5zgSmzoIfCGmFEUbVdpf7c711DQ
 y8HQ==
X-Gm-Message-State: AOJu0YweIFSde74P+cIlbLxxkamhLj0Zz2HyzgWoKNfSAwp05qrR6gtW
 d3+0lwSEOy61zjLSV5N88XPKFOw99dvXoKKPt0STHLSl3sEcUIa9zJ5j2lFGzxmqxSo6wNvD9t7
 jloO2
X-Gm-Gg: AZuq6aK99mRjBRbwUq7/O9QGfo18TU1QDMTGnhrXN4iApPvC5G8qVCrmtGhpTIz8eH6
 Rp1Od0t2kcFE6vIjrg7fUU41BxxD6BJjaogWHD+soDcsnY4gwT4CmEr66xp0AA8asboBcO7U7Z/
 LSdDhHZ8iZ/IcYNIPVJ048b78iz5FDi5yM3mO+1ORM6KWX1lGEB1byfFVvnIykx3AWJtpKzHJMa
 H9etCKs0y5YFN9RWmoXp6yYQFh2US425uN08UfeDxURIsWicCi/g47VdJNf4KJkghSIbMDdmXtB
 bwxEEZgeW9DUTr06ZsB7swWMaAESP5eT4Q2C8RYrEu5CTGVYz0Yoiy7Mvng8EZWWs74uwT1o/qn
 cAwItTQ5en2Ae7NT9HAuoyXA8TlP8Qee0w1RhIQmJ0oimVsi+ZWqYS2jfz409WPsYfGsDWTclNA
 SUqYvupDcxI/BrxpdSaub9on+FVISzHB7/TXUWN23uizflAwp7icQ8jSmZGIbINCasJBVco/Uxn
 h8=
X-Received: by 2002:a05:6000:2906:b0:435:9e32:2b78 with SMTP id
 ffacd0b85a97d-4379db33f13mr1358252f8f.1.1771015454945; 
 Fri, 13 Feb 2026 12:44:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a5f0sm7831487f8f.11.2026.02.13.12.44.13
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 12:44:14 -0800 (PST)
Date: Fri, 13 Feb 2026 12:44:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: DPDK 26.03 rc summary
Message-ID: <20260213124410.1ee3d328@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Pointed AI at the current commits in main to see if any bugs were creeping =
in.
It had some good observations. I can give detail if you want.

Key takeaways:

The 26.03 cycle is overwhelmingly a hardening release =E2=80=94 50% of comm=
its
carry Fixes: tags. Three major systematic efforts dominate: your format
overflow hardening series (37 patches), Bruce's variable shadowing
warning enablement (32 patches), and Marat Khalili's BPF validator/JIT
correctness fixes (9 patches).

The highest-severity finds per AGENTS.md criteria are the vhost patches
from Maxime Coquelin =E2=80=94 particularly the descriptor chain bounds che=
ck,
which is a guest-exploitable vulnerability (no bounds check + no loop
counter on guest-controlled memory). The mmap MAP_FAILED vs NULL check
is a textbook bug that could cause memory corruption.

The NBL driver stands out as a concern =E2=80=94 8 correctness patches
including double-frees, NULL derefs, and 10 Coverity issues, all
shortly after its 25.11 merge. Worth extra scrutiny going forward.

New features are modest, which fits the pattern for a non-LTS release focus=
ed on quality.
