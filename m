Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5DDC369DC
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 15:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2211D4042E;
	Thu,  1 May 2025 17:06:37 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 480B9402D3
 for <dev@dpdk.org>; Thu,  1 May 2025 17:06:35 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3035858c687so834876a91.2
 for <dev@dpdk.org>; Thu, 01 May 2025 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746111994;
 x=1746716794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pthcJw0y0zdqdIP1COAUFsqUsVmi7LwVmpK2POH5QuY=;
 b=0b+SM1ALF5Yq4Rw1G6J4RgZy+T77ITsebvb2RO0qD6554/y2QcpTBXCPr8CbmdRQz5
 o5ONn4PBA9cm9CKudXr4sheQIHYbNAp69zZj6xhYvIB6xr6HH8OPmAYHXX1qR2F7pLeA
 cNccgJ3tbf6XrXX8HKm1WGKCF3apmoePSNlSE/VdeLvW2zxmjOQ/CY7ZPSnV+q7TBmD1
 QqfMvA6Plh2zzuk6j6y88+41HzcQzksyoimgR0880HI0EwT4FdBv82CjLkCkZp/grjdQ
 M6lb8PHjvMJ5+IEND1yrDPYW2AyTQhpuRYK3QviwCDUgVTO2M7jnOuuku6jU1pUk+VX2
 4L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111994; x=1746716794;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pthcJw0y0zdqdIP1COAUFsqUsVmi7LwVmpK2POH5QuY=;
 b=xBJV2tE+XppqElPZztl2jg92GvCg5qKcZK9V6lyQ9E2E/auNJ/uc7hIEDdbdQ+Nu0V
 cHht+YD0IdezZjkSW4tl/A5j7ohZi+r6fDSn8KbX6E54h07oRwyimDsdiAuVx8f8A1Qw
 e13jcCX1mC/kOxrRlvpf5/D9bIynTaesnRZJupd2Hp94gF6wv7ksxaywoqB7Z1ZIquNB
 WUaArwDFCfM345sr7OmoYltnjbxgHR8kzXEXT8F9Ma4QRWj6pZSNzDRLRRRH7s3oKIA5
 677FraPvWfdDjHfLkWmgZ5ROISYcdUKoO/nHxRhUu2nHbH9hcz7emSqK7frhiSK5VK5M
 LdpA==
X-Gm-Message-State: AOJu0YzWQN2pKXRnFxaAWacXF8CGpveMkzVwQiTab8sbSJmD8OsB/4dG
 Zr+3tNaCIvYhSB+9S0oVDKnPNWO877tAy6Yql2vgM/7rs22ttLiEC0JGON1/F//GZ63L/69Twhj
 T
X-Gm-Gg: ASbGncvTzIEhULKxSMZFGnfO+F8F29tpD2k1mVyw5MXcj6GXfqdPaMm6wM/Dxzi2QuQ
 GvQ4a10LXsohoV7OOcXu80FOmVj3I9M47kuTzMEFNfH4j2IYlVsf5nQmaltUaGBqYc/wv7h8UqQ
 q3sL6AjMy6VyH9OLLTZ20mTttHDXs9OwBUp8tuc9mtI9AciOEJRNPjHf6APisHDbvkBWm3WSSom
 xZZGBHi3l1XyYp3ZjKEmeNoZIDiz3wq166EQCYogLEY7BAkof3YYlCJfetEZDmbpBm5rN1UIo8w
 Q8YA9XROQksUuWkRiywzlguulBhkaYJuAZO2K2TCJw4pzPabhVv5yG/bNC/U76oUovG40nfKBPS
 xoLkWAP6ZgzbcY3nf
X-Google-Smtp-Source: AGHT+IFTYH9CpRuDO6lJmjLlUsZXAD7pir+VaUzGcWc3/JgBPvbW5W/N7tAT18LgLLAaPc8wvRRDkQ==
X-Received: by 2002:a17:90b:2e50:b0:308:6d7a:5d30 with SMTP id
 98e67ed59e1d1-30a41d440e6mr5453889a91.18.1746111993909; 
 Thu, 01 May 2025 08:06:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4748e813sm986223a91.24.2025.05.01.08.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 08:06:33 -0700 (PDT)
Date: Thu, 1 May 2025 08:06:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: techboard@dpdk.org
Cc: dev@dpdk.org
Subject: rte_control event API?
Message-ID: <20250501080630.440a78ba@hermes.local>
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

There was recent discussions about drivers creating control threads.
The current drivers that use rte_thread_create_internal_control keeps growing, 
but it got me looking at if this could be done better.

Rather than having multiple control threads which have potential conflicts, why not
add a new API that has one control thread and uses epoll. The current multi-process
control thread could use epoll as well. Epoll scales much better and avoids
any possibility of lock scheduling/priority problems.

Some ideas:
   - single control thread started (where the current MP thread is started)
   - have control_register_fd and control_unregister_fd
   - leave rte_control_thread API for legacy uses

Model this after well used libevent library https://libevent.org

Open questions:
   - names are hard, using event as name leads to possible confusion with eventdev
   - do we need to support:
        - multiple control threads doing epoll?
        - priorities
        - timers?
        - signals?
        - manual activation?
        - one off events?
   - could alarm thread just be a control event

   - should also have stats and info calls

   - it would be good to NOT support as many features as libevent, since
     so many options leads to bugs.
